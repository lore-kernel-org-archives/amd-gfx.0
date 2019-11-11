From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH -next] drm/amd/display: remove set but not used variable 'bpc'
Date: Mon, 11 Nov 2019 13:01:11 -0500
Message-ID: <CADnq5_O7JwQd4+ncEe+KusqNqPBGXgkcUBX6VHP5OjhNwUseWg@mail.gmail.com>
References: <20191109093538.23964-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191109093538.23964-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: YueHaibing <yuehaibing@huawei.com>
Cc: "Wentland, Harry" <harry.wentland@amd.com>, "Leo (Sunpeng) Li" <sunpeng.li@amd.com>, "Deucher, Alexander" <alexander.deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, Chunming Zhou <David1.Zhou@amd.com>, Dave Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, Jun Lei <Jun.Lei@amd.com>, Anthony Koo <Anthony.Koo@amd.com>, Zhan Liu <Zhan.Liu@amd.com>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

Applied.  Thanks!

Alex

On Sun, Nov 10, 2019 at 9:30 PM YueHaibing <yuehaibing@huawei.com> wrote:
>
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link.c: In function get_pbn_from_timing:
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link.c:2364:11: warning:
>  variable bpc set but not used [-Wunused-but-set-variable]
>
> It is not used since commit e49f69363adf ("drm/amd/display: use
> proper formula to calculate bandwidth from timing")
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_link.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> index bdc8be3..53394e2 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> @@ -2653,13 +2653,11 @@ static int get_color_depth(enum dc_color_depth color_depth)
>
>  static struct fixed31_32 get_pbn_from_timing(struct pipe_ctx *pipe_ctx)
>  {
> -       uint32_t bpc;
>         uint64_t kbps;
>         struct fixed31_32 peak_kbps;
>         uint32_t numerator;
>         uint32_t denominator;
>
> -       bpc = get_color_depth(pipe_ctx->stream_res.pix_clk_params.color_depth);
>         kbps = dc_bandwidth_in_kbps_from_timing(&pipe_ctx->stream->timing);
>
>         /*
> --
> 2.7.4
>
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
