From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amdgpu/gfx10: Fix missing break in switch statement
Date: Mon, 22 Jul 2019 15:12:11 -0400
Message-ID: <CADnq5_NZNA3wCq4U4jbOU7BHfYgan5m=R6MbWmJ3Xp1oYMAUog@mail.gmail.com>
References: <20190721223949.GA13591@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190721223949.GA13591@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Kees Cook <keescook@chromium.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

On Sun, Jul 21, 2019 at 6:39 PM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> Add missing break statement in order to prevent the code from falling
> through to case AMDGPU_IRQ_STATE_ENABLE.
>
> This bug was found thanks to the ongoing efforts to enable
> -Wimplicit-fallthrough.
>
> Fixes: a644d85a5cd4 ("drm/amdgpu: add gfx v10 implementation (v10)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 1675d5837c3c..35e8e29139b1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -4611,6 +4611,7 @@ gfx_v10_0_set_gfx_eop_interrupt_state(struct amdgpu_device *adev,
>                 cp_int_cntl = REG_SET_FIELD(cp_int_cntl, CP_INT_CNTL_RING0,
>                                             TIME_STAMP_INT_ENABLE, 0);
>                 WREG32(cp_int_cntl_reg, cp_int_cntl);
> +               break;
>         case AMDGPU_IRQ_STATE_ENABLE:
>                 cp_int_cntl = RREG32(cp_int_cntl_reg);
>                 cp_int_cntl = REG_SET_FIELD(cp_int_cntl, CP_INT_CNTL_RING0,
> --
> 2.22.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
