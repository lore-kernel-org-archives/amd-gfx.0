From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH -next] drm/amd/display: remove set but not used variable 'ds_port'
Date: Mon, 11 Nov 2019 12:57:49 -0500
Message-ID: <CADnq5_PcSdTm9yKdbv=QHFtGeO58a30wZ0KxjQUNqy3Aax9thg@mail.gmail.com>
References: <20191109093725.42364-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191109093725.42364-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: YueHaibing <yuehaibing@huawei.com>
Cc: "Wentland, Harry" <harry.wentland@amd.com>, "Leo (Sunpeng) Li" <sunpeng.li@amd.com>, "Deucher, Alexander" <alexander.deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, Chunming Zhou <David1.Zhou@amd.com>, Dave Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

Applied.  thanks!

Alex

On Sun, Nov 10, 2019 at 9:29 PM YueHaibing <yuehaibing@huawei.com> wrote:
>
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.c: In function dp_wa_power_up_0010FA:
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.c:2320:35: warning:
>  variable ds_port set but not used [-Wunused-but-set-variable]
>
> It is never used, so can be removed.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> index 65de32f..b814b74 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> @@ -2910,7 +2910,6 @@ static void dp_wa_power_up_0010FA(struct dc_link *link, uint8_t *dpcd_data,
>                 int length)
>  {
>         int retry = 0;
> -       union dp_downstream_port_present ds_port = { 0 };
>
>         if (!link->dpcd_caps.dpcd_rev.raw) {
>                 do {
> @@ -2923,9 +2922,6 @@ static void dp_wa_power_up_0010FA(struct dc_link *link, uint8_t *dpcd_data,
>                 } while (retry++ < 4 && !link->dpcd_caps.dpcd_rev.raw);
>         }
>
> -       ds_port.byte = dpcd_data[DP_DOWNSTREAMPORT_PRESENT -
> -                                DP_DPCD_REV];
> -
>         if (link->dpcd_caps.dongle_type == DISPLAY_DONGLE_DP_VGA_CONVERTER) {
>                 switch (link->dpcd_caps.branch_dev_id) {
>                 /* 0010FA active dongles (DP-VGA, DP-DLDVI converters) power down
> --
> 2.7.4
>
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
