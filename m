From: Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH 6/6] [RESEND] drm/amdgpu: work around llvm bug #42576
Date: Wed,  2 Oct 2019 09:51:37 -0700
Message-ID: <20191002165137.15726-1-ndesaulniers@google.com>
References: <20191002120136.1777161-7-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191002120136.1777161-7-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: arnd@arndb.de
Cc: David1.Zhou@amd.com, Hawking.Zhang@amd.com, airlied@linux.ie, alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org, christian.koenig@amd.com, clang-built-linux@googlegroups.com, daniel@ffwll.ch, dri-devel@lists.freedesktop.org, le.ma@amd.com, linux-kernel@vger.kernel.org, ray.huang@amd.com
List-Id: amd-gfx.lists.freedesktop.org

> Apparently this bug is still present in both the released clang-9
> and the current development version of clang-10.
> I was hoping we would not need a workaround in clang-9+, but
> it seems that we do.

I think I'd rather:
1. mark AMDGPU BROKEN if CC_IS_CLANG. There are numerous other issues building
   a working driver here.
2. Fix the compiler bug.
