From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH][next] drm/amdgpu: fix spelling mistake "retrived" -> "retrieved"
Date: Wed, 15 May 2019 16:57:22 -0400
Message-ID: <CADnq5_PPv42iXCad7HqgG-3zbE307bPrMSsXCdYCNpgrHi4iRA@mail.gmail.com>
References: <20190510070734.20625-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190510070734.20625-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

On Fri, May 10, 2019 at 3:07 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake in a DRM_ERROR error message. Fix this.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/df_v3_6.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> index 7d375f8dcce6..a5c3558869fb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> +++ b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> @@ -194,7 +194,7 @@ static void df_v3_6_pmc_get_ctrl_settings(struct amdgpu_device *adev,
>                 return;
>
>         if ((*lo_base_addr == 0) || (*hi_base_addr == 0)) {
> -               DRM_ERROR("DF PMC addressing not retrived! Lo: %x, Hi: %x",
> +               DRM_ERROR("DF PMC addressing not retrieved! Lo: %x, Hi: %x",
>                                 *lo_base_addr, *hi_base_addr);
>                 return;
>         }
> --
> 2.20.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
