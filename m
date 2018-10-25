From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH -next] drm/radeon/kms: remove set but not used variable 'pll'
Date: Thu, 25 Oct 2018 14:24:17 -0400
Message-ID: <CADnq5_OSqxu_e88dmh57eiq2y78jKrQkarDXNYpeSWCe066DrA@mail.gmail.com>
References: <1540116359-164086-1-git-send-email-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1540116359-164086-1-git-send-email-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: yuehaibing@huawei.com
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, Chunming Zhou <David1.Zhou@amd.com>, Dave Airlie <airlied@linux.ie>, kernel-janitors@vger.kernel.org, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

On Sun, Oct 21, 2018 at 11:32 PM YueHaibing <yuehaibing@huawei.com> wrote:
>
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> drivers/gpu/drm/radeon/radeon_legacy_tv.c: In function 'radeon_legacy_tv_init_restarts':
> drivers/gpu/drm/radeon/radeon_legacy_tv.c:435:21: warning:
>  variable 'pll' set but not used [-Wunused-but-set-variable]
>   struct radeon_pll *pll;
>
> It never used since introduction in commit
> 4ce001abafaf ("drm/radeon/kms: add initial radeon tv-out support.")
> Also remove related variables 'dev, rdev, radeon_crtc'
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/radeon/radeon_legacy_tv.c | 10 ----------
>  1 file changed, 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_legacy_tv.c b/drivers/gpu/drm/radeon/radeon_legacy_tv.c
> index 4278272..3dae2c4 100644
> --- a/drivers/gpu/drm/radeon/radeon_legacy_tv.c
> +++ b/drivers/gpu/drm/radeon/radeon_legacy_tv.c
> @@ -421,24 +421,14 @@ static void radeon_legacy_write_tv_restarts(struct radeon_encoder *radeon_encode
>
>  static bool radeon_legacy_tv_init_restarts(struct drm_encoder *encoder)
>  {
> -       struct drm_device *dev = encoder->dev;
> -       struct radeon_device *rdev = dev->dev_private;
>         struct radeon_encoder *radeon_encoder = to_radeon_encoder(encoder);
>         struct radeon_encoder_tv_dac *tv_dac = radeon_encoder->enc_priv;
> -       struct radeon_crtc *radeon_crtc;
>         int restart;
>         unsigned int h_total, v_total, f_total;
>         int v_offset, h_offset;
>         u16 p1, p2, h_inc;
>         bool h_changed;
>         const struct radeon_tv_mode_constants *const_ptr;
> -       struct radeon_pll *pll;
> -
> -       radeon_crtc = to_radeon_crtc(radeon_encoder->base.crtc);
> -       if (radeon_crtc->crtc_id == 1)
> -               pll = &rdev->clock.p2pll;
> -       else
> -               pll = &rdev->clock.p1pll;
>
>         const_ptr = radeon_legacy_tv_get_std_mode(radeon_encoder, NULL);
>         if (!const_ptr)
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
