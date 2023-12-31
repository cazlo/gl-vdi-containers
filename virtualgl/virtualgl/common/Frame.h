// Copyright (C)2004 Landmark Graphics Corporation
// Copyright (C)2005-2007 Sun Microsystems, Inc.
// Copyright (C)2009-2012, 2014, 2017-2018, 2020-2021 D. R. Commander
//
// This library is free software and may be redistributed and/or modified under
// the terms of the wxWindows Library License, Version 3.1 or (at your option)
// any later version.  The full license is in the LICENSE.txt file included
// with this distribution.
//
// This library is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// wxWindows Library License for more details.

#ifndef __FRAME_H__
#define __FRAME_H__

#include "rr.h"
#include "fbx.h"
#include "turbojpeg.h"
#include "Mutex.h"
#ifdef USEXV
#include "fbxv.h"
#endif
#include "pf.h"


// Flags
#define FRAME_BOTTOMUP  1  // Bottom-up bitmap (as opposed to top-down)


// Uncompressed frame

namespace common
{
	class Frame
	{
		public:

			Frame(bool primary = true);
			virtual ~Frame(void);
			void init(rrframeheader &h, int pixelFormat, int flags,
				bool stereo = false);
			void init(unsigned char *bits, int width, int pitch, int height,
				int pixelFormat, int flags);
			void deInit(void);
			Frame *getTile(int x, int y, int width, int height);
			bool tileEquals(Frame *last, int x, int y, int width, int height);
			void makeAnaglyph(Frame &r, Frame &g, Frame &b);
			void makePassive(Frame &stf, int mode);
			void signalReady(void) { ready.signal(); }
			void waitUntilReady(void) { ready.wait(); }
			void signalComplete(void) { complete.signal(); }
			void waitUntilComplete(void) { complete.wait(); }
			bool isComplete(void) { return !complete.isLocked(); }
			void decompressRGB(Frame &f, int width, int height, bool rightEye);
			void addLogo(void);

			rrframeheader hdr;
			unsigned char *bits;
			unsigned char *rbits;
			int pitch, flags;
			PF *pf;
			bool isGL, isXV, stereo;

		protected:

			void dumpHeader(rrframeheader &);
			void checkHeader(rrframeheader &);

			util::Event ready;
			util::Event complete;
			friend class CompressedFrame;
			bool primary;
	};
}


// Compressed frame

namespace common
{
	class CompressedFrame : public Frame
	{
		public:

			CompressedFrame(void);
			~CompressedFrame(void);
			CompressedFrame &operator= (Frame &f);
			void compressYUV(Frame &f);
			void compressJPEG(Frame &f);
			void compressRGB(Frame &f);
			void init(rrframeheader &h, int buffer);

			rrframeheader rhdr;

		private:

			tjhandle tjhnd;
			friend class FBXFrame;
	};
}


// Frame created from shared graphics memory

namespace common
{
	class FBXFrame : public Frame
	{
		public:

			FBXFrame(Display *dpy, Drawable draw, Visual *vis = NULL,
				bool reuseConn = false);
			FBXFrame(char *dpystring, Window win);
			void init(char *dpystring, Drawable draw, Visual *vis = NULL);
			void init(Display *dpy, Drawable draw, Visual *vis);
			~FBXFrame(void);
			void init(rrframeheader &h);
			FBXFrame &operator= (CompressedFrame &cf);
			void redraw(void);

		private:

			fbx_wh wh;
			fbx_struct fb;
			tjhandle tjhnd;
			bool reuseConn;
			static util::CriticalSection mutex;
	};
}


#ifdef USEXV

// Frame created using X Video

namespace common
{
	class XVFrame : public Frame
	{
		public:

			XVFrame(Display *dpy, Window win);
			XVFrame(char *dpystring, Window win);
			void init(char *dpystring, Window win);
			~XVFrame(void);
			XVFrame &operator= (Frame &f);
			void init(rrframeheader &h);
			void redraw(void);

		private:

			fbxv_struct fb;
			Display *dpy;  Window win;
			tjhandle tjhnd;
			static util::CriticalSection mutex;
	};
}

#endif


#endif  // __FRAME_H__
