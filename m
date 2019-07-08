From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/7] drm/amdgpu/mes10.1: Fix header guard
Date: Mon, 8 Jul 2019 22:24:14 +0200
Message-ID: <CAK8P3a1thzkjD5V39QcVWb1fQe62g6PLChMKuwodyu_rbWhgBw@mail.gmail.com>
References: <20190704055217.45860-1-natechancellor@gmail.com> <20190704055217.45860-2-natechancellor@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190704055217.45860-2-natechancellor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nathan Chancellor <natechancellor@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, amd-gfx list <amd-gfx@lists.freedesktop.org>, dri-devel <dri-devel@lists.freedesktop.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, clang-built-linux <clang-built-linux@googlegroups.com>
List-Id: amd-gfx.lists.freedesktop.org

On Thu, Jul 4, 2019 at 7:52 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> clang warns:
>
>  In file included from drivers/gpu/drm/amd/amdgpu/nv.c:53:
>  drivers/gpu/drm/amd/amdgpu/../amdgpu/mes_v10_1.h:24:9: warning:
>  '__MES_V10_1_H__' is used as a header guard here, followed by #define of
>  a different macro [-Wheader-guard]
>  #ifndef __MES_V10_1_H__
>          ^~~~~~~~~~~~~~~
>  drivers/gpu/drm/amd/amdgpu/../amdgpu/mes_v10_1.h:25:9: note:
>  '__MES_v10_1_H__' is defined here; did you mean '__MES_V10_1_H__'?
>  #define __MES_v10_1_H__
>          ^~~~~~~~~~~~~~~
>          __MES_V10_1_H__
>  1 warning generated.
>
> Capitalize the V.
>
> Fixes: 886f82aa7a1d ("drm/amdgpu/mes10.1: add ip block mes10.1 (v2)")
> Link: https://github.com/ClangBuiltLinux/linux/issues/582
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

I ran into the same one now, and saw your version before sending an
identical patch.

Acked-by: Arnd Bergmann <arnd@arndb.de>
