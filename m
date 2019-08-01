From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH][drm-next] drm/amd/powerplay: fix off-by-one upper bounds
 limit checks
Date: Thu, 1 Aug 2019 14:53:28 -0400
Message-ID: <CADnq5_OqLtvBWXJhT9c=kxK3HeXSEDdfYS1N7Dh68kbiiLk5+w@mail.gmail.com>
References: <20190801111541.13627-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190801111541.13627-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Kevin Wang <kevin1.wang@amd.com>, Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

On Thu, Aug 1, 2019 at 7:15 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There are two occurrances of off-by-one upper bound checking of indexes
> causing potential out-of-bounds array reads. Fix these.
>
> Addresses-Coverity: ("Out-of-bounds read")
> Fixes: cb33363d0e85 ("drm/amd/powerplay: add smu feature name support")
> Fixes: 6b294793e384 ("drm/amd/powerplay: add smu message name support")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index d029a99e600e..b64113740eb5 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -38,7 +38,7 @@ static const char* __smu_message_names[] = {
>
>  const char *smu_get_message_name(struct smu_context *smu, enum smu_message_type type)
>  {
> -       if (type < 0 || type > SMU_MSG_MAX_COUNT)
> +       if (type < 0 || type >= SMU_MSG_MAX_COUNT)
>                 return "unknown smu message";
>         return __smu_message_names[type];
>  }
> @@ -51,7 +51,7 @@ static const char* __smu_feature_names[] = {
>
>  const char *smu_get_feature_name(struct smu_context *smu, enum smu_feature_mask feature)
>  {
> -       if (feature < 0 || feature > SMU_FEATURE_COUNT)
> +       if (feature < 0 || feature >= SMU_FEATURE_COUNT)
>                 return "unknown smu feature";
>         return __smu_feature_names[feature];
>  }
> --
> 2.20.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
