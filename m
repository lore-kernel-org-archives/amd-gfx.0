From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amd/powerplay: fix struct init in renoir_print_clk_levels
Date: Wed, 6 Nov 2019 12:20:42 -0500
Message-ID: <CADnq5_O2wgq6YDXJXZizSKKmAbLDxRkQaSwAjofTS3pbTiPc2Q@mail.gmail.com>
References: <20191105155734.1.If8740b4a5095031f2c00746fbc3224be9849d76b@changeid>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191105155734.1.If8740b4a5095031f2c00746fbc3224be9849d76b@changeid>
Sender: linux-kernel-owner@vger.kernel.org
To: Raul E Rangel <rrangel@chromium.org>
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, LKML <linux-kernel@vger.kernel.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>, Evan Quan <evan.quan@amd.com>, Rex Zhu <rex.zhu@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

On Tue, Nov 5, 2019 at 6:10 PM Raul E Rangel <rrangel@chromium.org> wrote:
>
> drivers/gpu/drm/amd/powerplay/renoir_ppt.c:186:2: error: missing braces
> around initializer [-Werror=missing-braces]
>   SmuMetrics_t metrics = {0};
>     ^
>
> Fixes: 8b8031703bd7 ("drm/amd/powerplay: implement sysfs for getting dpm clock")
>
> Signed-off-by: Raul E Rangel <rrangel@chromium.org>

Applied.  thanks!

Alex

> ---
>
>  drivers/gpu/drm/amd/powerplay/renoir_ppt.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> index e62bfba51562..e5283dafc414 100644
> --- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> @@ -183,11 +183,13 @@ static int renoir_print_clk_levels(struct smu_context *smu,
>         int i, size = 0, ret = 0;
>         uint32_t cur_value = 0, value = 0, count = 0, min = 0, max = 0;
>         DpmClocks_t *clk_table = smu->smu_table.clocks_table;
> -       SmuMetrics_t metrics = {0};
> +       SmuMetrics_t metrics;
>
>         if (!clk_table || clk_type >= SMU_CLK_COUNT)
>                 return -EINVAL;
>
> +       memset(&metrics, 0, sizeof(metrics));
> +
>         ret = smu_update_table(smu, SMU_TABLE_SMU_METRICS, 0,
>                                (void *)&metrics, false);
>         if (ret)
> --
> 2.24.0.rc1.363.gb1bccd3e3d-goog
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
