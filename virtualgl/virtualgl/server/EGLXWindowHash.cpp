// Copyright (C)2015, 2021 D. R. Commander
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

#include "EGLXWindowHash.h"

using namespace faker;

EGLXWindowHash *EGLXWindowHash::instance = NULL;
util::CriticalSection EGLXWindowHash::instanceMutex;
