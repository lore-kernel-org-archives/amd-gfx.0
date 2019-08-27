From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amd/display: fix struct init in update_bounding_box
Date: Tue, 27 Aug 2019 14:02:18 -0400
Message-ID: <CADnq5_ME=erztEhDhW5Z2RYr7kpMT_OOHm2xyJDPGd8a2d3LuA@mail.gmail.com>
References: <20190827162924.88524-1-rrangel@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190827162924.88524-1-rrangel@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Raul E Rangel <rrangel@chromium.org>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, Charlene Liu <charlene.liu@amd.com>, Leo Li <sunpeng.li@amd.com>, Harry Wentland <harry.wentland@amd.com>, David Airlie <airlied@linux.ie>, LKML <linux-kernel@vger.kernel.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, Nikola Cornij <nikola.cornij@amd.com>, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, hersen wu <hersenxs.wu@amd.com>, Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>, Jun Lei <Jun.Lei@amd.com>, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

On Tue, Aug 27, 2019 at 1:33 PM Raul E Rangel <rrangel@chromium.org> wrote:
>
> dcn20_resource.c:2636:9: error: missing braces around initializer [-Werror=missing-braces]
>   struct _vcs_dpi_voltage_scaling_st calculated_states[MAX_CLOCK_LIMIT_STATES] = {0};
>          ^
>
> Fixes: 7ed4e6352c16f ("drm/amd/display: Add DCN2 HW Sequencer and Resource")
>
> Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> ---
>
>  drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> index b949e202d6cb..d8dd99bfa275 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> @@ -2633,7 +2633,7 @@ static void cap_soc_clocks(
>  static void update_bounding_box(struct dc *dc, struct _vcs_dpi_soc_bounding_box_st *bb,
>                 struct pp_smu_nv_clock_table *max_clocks, unsigned int *uclk_states, unsigned int num_states)
>  {
> -       struct _vcs_dpi_voltage_scaling_st calculated_states[MAX_CLOCK_LIMIT_STATES] = {0};
> +       struct _vcs_dpi_voltage_scaling_st calculated_states[MAX_CLOCK_LIMIT_STATES] = {};

I think it would be better to just use a memset.  Different compilers
seems to do the wrong thing with these sort of initializations.

Alex

>         int i;
>         int num_calculated_states = 0;
>         int min_dcfclk = 0;
> --
> 2.23.0.187.g17f5b7556c-goog
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
