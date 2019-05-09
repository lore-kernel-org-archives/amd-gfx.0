From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amd/display: Make some functions static
Date: Thu, 9 May 2019 10:51:36 -0400
Message-ID: <CADnq5_NmbWQWjYe5DnGJAPh-uA6Fwi+xZ4FJq-tJWYDuXp6teg@mail.gmail.com>
References: <20190508125516.16732-1-wanghai26@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190508125516.16732-1-wanghai26@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wang Hai <wanghai26@huawei.com>
Cc: "Wentland, Harry" <harry.wentland@amd.com>, "Leo (Sunpeng) Li" <sunpeng.li@amd.com>, "Deucher, Alexander" <alexander.deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, Chunming Zhou <David1.Zhou@amd.com>, Dave Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, "Cheng, Tony" <Tony.Cheng@amd.com>, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Hersen Wu <hersenxs.wu@amd.com>, David Francis <David.Francis@amd.com>, Jun.Lei@amd.com, Jerry Zuo <Jerry.Zuo@amd.com>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

On Wed, May 8, 2019 at 10:47 AM Wang Hai <wanghai26@huawei.com> wrote:
>
> Fix the following sparse warnings:
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_resource.c:483:21: warning: symbol 'dce120_clock_source_create' was not declared. Should it be static?
> drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_resource.c:506:6: warning: symbol 'dce120_clock_source_destroy' was not declared. Should it be static?
> drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_resource.c:513:6: warning: symbol 'dce120_hw_sequencer_create' was not declared. Should it be static?
>
> Fixes: b8fdfcc6a92c ("drm/amd/display: Add DCE12 core support")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wang Hai <wanghai26@huawei.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c b/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
> index 312a0aebf91f..0948421219ef 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
> @@ -458,7 +458,7 @@ static const struct dc_debug_options debug_defaults = {
>                 .disable_clock_gate = true,
>  };
>
> -struct clock_source *dce120_clock_source_create(
> +static struct clock_source *dce120_clock_source_create(
>         struct dc_context *ctx,
>         struct dc_bios *bios,
>         enum clock_source_id id,
> @@ -481,14 +481,14 @@ struct clock_source *dce120_clock_source_create(
>         return NULL;
>  }
>
> -void dce120_clock_source_destroy(struct clock_source **clk_src)
> +static void dce120_clock_source_destroy(struct clock_source **clk_src)
>  {
>         kfree(TO_DCE110_CLK_SRC(*clk_src));
>         *clk_src = NULL;
>  }
>
>
> -bool dce120_hw_sequencer_create(struct dc *dc)
> +static bool dce120_hw_sequencer_create(struct dc *dc)
>  {
>         /* All registers used by dce11.2 match those in dce11 in offset and
>          * structure
> --
> 2.17.1
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
