From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amd/powerplay: Fix an off by one in navi10_get_smu_msg_index()
Date: Mon, 26 Aug 2019 11:16:55 -0400
Message-ID: <CADnq5_PEFyHP7cOxZOYroGx+Hf1qSuSg+7DUiAakZMc1GcWbsQ@mail.gmail.com>
References: <20190826132012.GB6840@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190826132012.GB6840@mwanda>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Kevin Wang <kevin1.wang@amd.com>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Huang Rui <ray.huang@amd.com>, Daniel Vetter <daniel@ffwll.ch>, Evan Quan <evan.quan@amd.com>, Kenneth Feng <kenneth.feng@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

On Mon, Aug 26, 2019 at 9:20 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> The navi10_message_map[] array has SMU_MSG_MAX_COUNT elements so the ">"
> has to be changed to ">=" to prevent reading one element beyond the end
> of the array.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/amd/powerplay/navi10_ppt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> index d7e25f5113f1..fbecd25f150f 100644
> --- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> @@ -213,7 +213,7 @@ static int navi10_get_smu_msg_index(struct smu_context *smc, uint32_t index)
>  {
>         struct smu_11_0_cmn2aisc_mapping mapping;
>
> -       if (index > SMU_MSG_MAX_COUNT)
> +       if (index >= SMU_MSG_MAX_COUNT)
>                 return -EINVAL;
>
>         mapping = navi10_message_map[index];
> --
> 2.20.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
