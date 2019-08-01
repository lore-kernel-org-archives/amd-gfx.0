From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH][drm-next] drm/amd/powerplay: fix a few spelling mistakes
Date: Thu, 1 Aug 2019 15:02:30 -0400
Message-ID: <CADnq5_OdBM83zkkgtjwzQ0jqsiDP5wZoMXioGcq4mycX2=Tavw@mail.gmail.com>
References: <20190801083941.4230-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190801083941.4230-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

Applied.  thanks!

Alex

On Thu, Aug 1, 2019 at 4:39 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There are a few spelling mistakes "unknow" -> "unknown" and
> "enabeld" -> "enabled". Fix these.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index 13b2c8a60232..d029a99e600e 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -39,7 +39,7 @@ static const char* __smu_message_names[] = {
>  const char *smu_get_message_name(struct smu_context *smu, enum smu_message_type type)
>  {
>         if (type < 0 || type > SMU_MSG_MAX_COUNT)
> -               return "unknow smu message";
> +               return "unknown smu message";
>         return __smu_message_names[type];
>  }
>
> @@ -52,7 +52,7 @@ static const char* __smu_feature_names[] = {
>  const char *smu_get_feature_name(struct smu_context *smu, enum smu_feature_mask feature)
>  {
>         if (feature < 0 || feature > SMU_FEATURE_COUNT)
> -               return "unknow smu feature";
> +               return "unknown smu feature";
>         return __smu_feature_names[feature];
>  }
>
> @@ -79,7 +79,7 @@ size_t smu_sys_get_pp_feature_mask(struct smu_context *smu, char *buf)
>                                count++,
>                                smu_get_feature_name(smu, i),
>                                feature_index,
> -                              !!smu_feature_is_enabled(smu, i) ? "enabeld" : "disabled");
> +                              !!smu_feature_is_enabled(smu, i) ? "enabled" : "disabled");
>         }
>
>  failed:
> --
> 2.20.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
