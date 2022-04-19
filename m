Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA002C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Apr 2022 13:47:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FEC910EA02;
	Tue, 19 Apr 2022 13:47:48 +0000 (UTC)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DB8D10EA02
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Apr 2022 13:47:47 +0000 (UTC)
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-de3eda6b5dso17559079fac.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Apr 2022 06:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=fCdaAO1eruSgmAsi6kHnfjzB5PP6vrg0f+EoIaPZpAk=;
 b=o3LNpAgi6fe7pSrGgl3nqrDXpIhLOji6PfhYKa99DzVseo7srZPO8OSujdcCpa1vMx
 zu/DemZy5F+7qBZGNdzH8/+RV6GomC+yPA72y87EsebVlueFVqqHsITG7Yb4fsX5CPIU
 g/YIsf1rPWjXIdKLBhnkMQWgcu66YtXIaDD3i8+3d9w25Z+kPOYk5wLey4aUfbkO0JbT
 8ApkY53dHbx6ffTOTiCHcIe7oBxfyJyzH8E3y1EpymS0dQ4aecompa9shqT424jJJ010
 9X+OmPHIysSBHJOGdPkTE2A1mS1YaNnGykNClDCaXyiRt5GvBTBQqrxeC4cHS7UX8V+y
 DPQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=fCdaAO1eruSgmAsi6kHnfjzB5PP6vrg0f+EoIaPZpAk=;
 b=TsGjs5TwAy5YjCcW/iK7gEhGK5byLqU+jsituW+47KrsMNcihKefNwsb5iH73gUD92
 SvnwIOCy/M8UoBLdGNh0oDZHExr1aTlkOuWlV1Xh2oTCZUPLxUK/1rs55I3vPcf19pz3
 PwdvWUXpbGJU4XskOnSQrrqtMad2MB+yNF0VTYkglOvF2qo0/FDrr9AYDcfE1SokOCct
 emm7ozL5Rj+ge8vSnytEQFeOadpHS1bU938lHKkxiyBH8dMXjM/XMrBtujflWpYI0xZ1
 VEYBGO7BRIFoffX6kWinRvxUUnFRWt0xNysm430B8pH1gizZgN17/7U3GaoaUV1NdDY/
 a2Sg==
X-Gm-Message-State: AOAM533aSsTAZGT6/x3M0VThx0xVLqAAsOLpOcgIVqLmF5fDpcGRgyjh
 FQBCiiWXO6C77WO4V5tnezwapzKuumuCWvmylU/y9VNC
X-Google-Smtp-Source: ABdhPJyQkqYvqW1mHX5ploYyaAL1rQIzooBcgTelVF/05/yiiR204obzhyD6q5/9Me1z/z54eom7oRs/IOHKp/pl7/I=
X-Received: by 2002:a05:6870:311d:b0:de:9b6c:362b with SMTP id
 v29-20020a056870311d00b000de9b6c362bmr7901306oaa.200.1650376066356; Tue, 19
 Apr 2022 06:47:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220419110633.166236-1-christian.koenig@amd.com>
In-Reply-To: <20220419110633.166236-1-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 19 Apr 2022 09:47:35 -0400
Message-ID: <CADnq5_P17sVBQVO6CQ2eQ3WxY9KBJWCsVRSVrMEwyqgFaDOWPw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: partial revert "remove ctx->lock" v2
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Apr 19, 2022 at 7:06 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> This reverts commit 461fa7b0ac565ef25c1da0ced31005dd437883a7.
>
> We are missing some inter dependencies here so re-introduce the lock
> until we have figured out what's missing. Just drop/retake it while
> adding dependencies.
>
> v2: still drop the lock while adding dependencies
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com> (v1)
> Fixes: 461fa7b0ac56 ("drm/amdgpu: remove ctx->lock")

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c  | 21 +++++++++++++++------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c |  2 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h |  1 +
>  3 files changed, 18 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_cs.c
> index 970b065e9a6b..d0d0ea565e3d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -128,6 +128,8 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_par=
ser *p, union drm_amdgpu_cs
>                 goto free_chunk;
>         }
>
> +       mutex_lock(&p->ctx->lock);
> +
>         /* skip guilty context job */
>         if (atomic_read(&p->ctx->guilty) =3D=3D 1) {
>                 ret =3D -ECANCELED;
> @@ -709,6 +711,7 @@ static void amdgpu_cs_parser_fini(struct amdgpu_cs_pa=
rser *parser, int error,
>         dma_fence_put(parser->fence);
>
>         if (parser->ctx) {
> +               mutex_unlock(&parser->ctx->lock);
>                 amdgpu_ctx_put(parser->ctx);
>         }
>         if (parser->bo_list)
> @@ -1157,6 +1160,9 @@ static int amdgpu_cs_dependencies(struct amdgpu_dev=
ice *adev,
>  {
>         int i, r;
>
> +       /* TODO: Investigate why we still need the context lock */
> +       mutex_unlock(&p->ctx->lock);
> +
>         for (i =3D 0; i < p->nchunks; ++i) {
>                 struct amdgpu_cs_chunk *chunk;
>
> @@ -1167,32 +1173,34 @@ static int amdgpu_cs_dependencies(struct amdgpu_d=
evice *adev,
>                 case AMDGPU_CHUNK_ID_SCHEDULED_DEPENDENCIES:
>                         r =3D amdgpu_cs_process_fence_dep(p, chunk);
>                         if (r)
> -                               return r;
> +                               goto out;
>                         break;
>                 case AMDGPU_CHUNK_ID_SYNCOBJ_IN:
>                         r =3D amdgpu_cs_process_syncobj_in_dep(p, chunk);
>                         if (r)
> -                               return r;
> +                               goto out;
>                         break;
>                 case AMDGPU_CHUNK_ID_SYNCOBJ_OUT:
>                         r =3D amdgpu_cs_process_syncobj_out_dep(p, chunk)=
;
>                         if (r)
> -                               return r;
> +                               goto out;
>                         break;
>                 case AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_WAIT:
>                         r =3D amdgpu_cs_process_syncobj_timeline_in_dep(p=
, chunk);
>                         if (r)
> -                               return r;
> +                               goto out;
>                         break;
>                 case AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_SIGNAL:
>                         r =3D amdgpu_cs_process_syncobj_timeline_out_dep(=
p, chunk);
>                         if (r)
> -                               return r;
> +                               goto out;
>                         break;
>                 }
>         }
>
> -       return 0;
> +out:
> +       mutex_lock(&p->ctx->lock);
> +       return r;
>  }
>
>  static void amdgpu_cs_post_dependencies(struct amdgpu_cs_parser *p)
> @@ -1368,6 +1376,7 @@ int amdgpu_cs_ioctl(struct drm_device *dev, void *d=
ata, struct drm_file *filp)
>                 goto out;
>
>         r =3D amdgpu_cs_submit(&parser, cs);
> +
>  out:
>         amdgpu_cs_parser_fini(&parser, r, reserved_buffers);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ctx.c
> index 5981c7d9bd48..8f0e6d93bb9c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -237,6 +237,7 @@ static int amdgpu_ctx_init(struct amdgpu_device *adev=
,
>
>         kref_init(&ctx->refcount);
>         spin_lock_init(&ctx->ring_lock);
> +       mutex_init(&ctx->lock);
>
>         ctx->reset_counter =3D atomic_read(&adev->gpu_reset_counter);
>         ctx->reset_counter_query =3D ctx->reset_counter;
> @@ -357,6 +358,7 @@ static void amdgpu_ctx_fini(struct kref *ref)
>                 drm_dev_exit(idx);
>         }
>
> +       mutex_destroy(&ctx->lock);
>         kfree(ctx);
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ctx.h
> index d0cbfcea90f7..142f2f87d44c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> @@ -49,6 +49,7 @@ struct amdgpu_ctx {
>         bool                            preamble_presented;
>         int32_t                         init_priority;
>         int32_t                         override_priority;
> +       struct mutex                    lock;
>         atomic_t                        guilty;
>         unsigned long                   ras_counter_ce;
>         unsigned long                   ras_counter_ue;
> --
> 2.25.1
>
