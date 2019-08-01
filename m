From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] gpu: drm: radeon: Fix a possible null-pointer dereference
 in radeon_connector_set_property()
Date: Thu, 1 Aug 2019 14:55:42 -0400
Message-ID: <CADnq5_ND4=Vtkfxhxj0OAmUFT33NR+QuV7_Uv-yc-xzhZCWSbA@mail.gmail.com>
References: <20190729083644.29160-1-baijiaju1990@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190729083644.29160-1-baijiaju1990@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, Chunming Zhou <David1.Zhou@amd.com>, Dave Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

On Mon, Jul 29, 2019 at 11:08 AM Jia-Ju Bai <baijiaju1990@gmail.com> wrote:
>
> In radeon_connector_set_property(), there is an if statement on line 743
> to check whether connector->encoder is NULL:
>     if (connector->encoder)
>
> When connector->encoder is NULL, it is used on line 755:
>     if (connector->encoder->crtc)
>
> Thus, a possible null-pointer dereference may occur.
>
> To fix this bug, connector->encoder is checked before being used.
>
> This bug is found by a static analysis tool STCheck written by us.

I believe we always have an encoder for every connector, but never
hurts to be safe.  Thanks.  Applied.

Alex

>
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  drivers/gpu/drm/radeon/radeon_connectors.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_connectors.c b/drivers/gpu/drm/radeon/radeon_connectors.c
> index c60d1a44d22a..b684cd719612 100644
> --- a/drivers/gpu/drm/radeon/radeon_connectors.c
> +++ b/drivers/gpu/drm/radeon/radeon_connectors.c
> @@ -752,7 +752,7 @@ static int radeon_connector_set_property(struct drm_connector *connector, struct
>
>                 radeon_encoder->output_csc = val;
>
> -               if (connector->encoder->crtc) {
> +               if (connector->encoder && connector->encoder->crtc) {
>                         struct drm_crtc *crtc  = connector->encoder->crtc;
>                         struct radeon_crtc *radeon_crtc = to_radeon_crtc(crtc);
>
> --
> 2.17.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
