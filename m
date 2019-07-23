From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH][next] drm/amd/display: fix a missing null check on a
 failed kzalloc
Date: Tue, 23 Jul 2019 14:55:12 -0400
Message-ID: <CADnq5_Ni9T-jkLrv-s-v1VD8J=VQmyz6S43Na52=1sjdB-uJZA@mail.gmail.com>
References: <20190723142312.4013-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190723142312.4013-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

On Tue, Jul 23, 2019 at 10:23 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> Currently the allocation of config may fail and a null pointer
> dereference on config can occur.  Fix this by added a null
> check on a failed allocation of config.
>
> Addresses-Coverity: ("Dereference null return")
> Fixes: c2cd9d04ecf0 ("drm/amd/display: Hook up calls to do stereo mux and dig programming to stereo control interface")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/core/dc.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index 168f4a7dffdf..7cce2baec2af 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -1259,6 +1259,8 @@ bool dc_set_generic_gpio_for_stereo(bool enable,
>         struct gpio_generic_mux_config *config = kzalloc(sizeof(struct gpio_generic_mux_config),
>                            GFP_KERNEL);
>
> +       if (!config)
> +               return false;
>         pin_info = dal_gpio_get_generic_pin_info(gpio_service, GPIO_ID_GENERIC, 0);
>
>         if (pin_info.mask == 0xFFFFFFFF || pin_info.offset == 0xFFFFFFFF) {
> --
> 2.20.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
