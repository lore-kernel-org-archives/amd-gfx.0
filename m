From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/radeon/dp_auxch: Ratelimit aux transfer debug messages
Date: Thu, 23 Feb 2017 09:34:26 -0500
Message-ID: <CADnq5_PAk8kq=V7qF6bA1QvkAz_avUBSRkoHQBQgXr_dUBWHbQ@mail.gmail.com>
References: <20170222213453.20972-1-lyude@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170222213453.20972-1-lyude@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lyude <lyude@redhat.com>
Cc: xorg-driver-ati <xorg-driver-ati@lists.x.org>, David Airlie <airlied@linux.ie>, LKML <linux-kernel@vger.kernel.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

On Wed, Feb 22, 2017 at 4:34 PM, Lyude <lyude@redhat.com> wrote:
> Aux transfers always fail with non-zero status flags when there's
> nothing connected on the port, so we don't usually need to see all of
> the debugging information from it. Also, we try reprobing a -lot-, so
> without ratelimiting most of the kernel log is filled up with messages
> from radeon_dp_aux_transfer_native.
>
> Signed-off-by: Lyude <lyude@redhat.com>

Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/radeon/radeon_dp_auxch.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_dp_auxch.c b/drivers/gpu/drm/radeon/radeon_dp_auxch.c
> index 474a8a18..12eac4e 100644
> --- a/drivers/gpu/drm/radeon/radeon_dp_auxch.c
> +++ b/drivers/gpu/drm/radeon/radeon_dp_auxch.c
> @@ -168,7 +168,8 @@ radeon_dp_aux_transfer_native(struct drm_dp_aux *aux, struct drm_dp_aux_msg *msg
>                 goto done;
>         }
>         if (tmp & AUX_RX_ERROR_FLAGS) {
> -               DRM_DEBUG_KMS("dp_aux_ch flags not zero: %08x\n", tmp);
> +               DRM_DEBUG_KMS_RATELIMITED("dp_aux_ch flags not zero: %08x\n",
> +                                         tmp);
>                 ret = -EIO;
>                 goto done;
>         }
> --
> 2.9.3
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
