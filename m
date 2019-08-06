From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] gpu: drm: amd: powerplay: Remove logically dead code
Date: Tue, 6 Aug 2019 10:03:36 -0400
Message-ID: <CADnq5_MniQgphMuAsYkvYT9QerSTRYLQQwM_yo9Qxg09Tx-ceA@mail.gmail.com>
References: <20190805172138.GA4534@hari-Inspiron-1545>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190805172138.GA4534@hari-Inspiron-1545>
Sender: linux-kernel-owner@vger.kernel.org
To: Hariprasad Kelam <hariprasad.kelam@gmail.com>
Cc: Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

On Mon, Aug 5, 2019 at 3:01 PM Hariprasad Kelam
<hariprasad.kelam@gmail.com> wrote:
>
> Result of pointer airthmentic is never null
>
> fix coverity defect:1451876
>
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>

Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/amd/powerplay/smu_v11_0.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> index ee739c0..a3acd77 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> @@ -736,8 +736,6 @@ static int smu_v11_0_write_watermarks_table(struct smu_context *smu)
>         struct smu_table *table = NULL;
>
>         table = &smu_table->tables[SMU_TABLE_WATERMARKS];
> -       if (!table)
> -               return -EINVAL;
>
>         if (!table->cpu_addr)
>                 return -EINVAL;
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
