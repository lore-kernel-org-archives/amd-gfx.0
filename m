From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Ensure ret is always initialized when using SOC15_WAIT_ON_RREG
Date: Mon, 25 Nov 2019 09:55:06 -0500
Message-ID: <CADnq5_OGD5q44nEhHp2+RU3syhO9cUhqfnH34BRJhJrC-b+rLw@mail.gmail.com>
References: <20191123192336.11678-1-natechancellor@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191123192336.11678-1-natechancellor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nathan Chancellor <natechancellor@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, LKML <linux-kernel@vger.kernel.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, clang-built-linux <clang-built-linux@googlegroups.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Leo Liu <leo.liu@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

On Mon, Nov 25, 2019 at 3:07 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Commit b0f3cd3191cd ("drm/amdgpu: remove unnecessary JPEG2.0 code from
> VCN2.0") introduced a new clang warning in the vcn_v2_0_stop function:
>
> ../drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c:1082:2: warning: variable 'r'
> is used uninitialized whenever 'while' loop exits because its condition
> is false [-Wsometimes-uninitialized]
>         SOC15_WAIT_ON_RREG(VCN, 0, mmUVD_STATUS, UVD_STATUS__IDLE, 0x7, r);
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../drivers/gpu/drm/amd/amdgpu/../amdgpu/soc15_common.h:55:10: note:
> expanded from macro 'SOC15_WAIT_ON_RREG'
>                 while ((tmp_ & (mask)) != (expected_value)) {   \
>                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c:1083:6: note: uninitialized use
> occurs here
>         if (r)
>             ^
> ../drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c:1082:2: note: remove the
> condition if it is always true
>         SOC15_WAIT_ON_RREG(VCN, 0, mmUVD_STATUS, UVD_STATUS__IDLE, 0x7, r);
>         ^
> ../drivers/gpu/drm/amd/amdgpu/../amdgpu/soc15_common.h:55:10: note:
> expanded from macro 'SOC15_WAIT_ON_RREG'
>                 while ((tmp_ & (mask)) != (expected_value)) {   \
>                        ^
> ../drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c:1072:7: note: initialize the
> variable 'r' to silence this warning
>         int r;
>              ^
>               = 0
> 1 warning generated.
>
> To prevent warnings like this from happening in the future, make the
> SOC15_WAIT_ON_RREG macro initialize its ret variable before the while
> loop that can time out. This macro's return value is always checked so
> it should set ret in both the success and fail path.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/776
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/soc15_common.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15_common.h b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
> index 839f186e1182..19e870c79896 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
> @@ -52,6 +52,7 @@
>                 uint32_t old_ = 0;      \
>                 uint32_t tmp_ = RREG32(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg); \
>                 uint32_t loop = adev->usec_timeout;             \
> +               ret = 0;                                        \
>                 while ((tmp_ & (mask)) != (expected_value)) {   \
>                         if (old_ != tmp_) {                     \
>                                 loop = adev->usec_timeout;      \
> --
> 2.24.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
