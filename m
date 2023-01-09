Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 136FBC5479D
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Jan 2023 14:19:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90DE289D4D;
	Mon,  9 Jan 2023 14:19:56 +0000 (UTC)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA45089D4D
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Jan 2023 14:19:54 +0000 (UTC)
Received: by mail-oi1-x22b.google.com with SMTP id c133so7214399oif.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Jan 2023 06:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LAFmiXxXpTd2DVZ1qFqzt2ULhZG8IhtLoMduAviIhCM=;
 b=pg+aS0M7+Nway2LbLnS/pBMA9pZ0XgmAq4ebDNrLGunpsPHihQ+QOSmrRsVDvmlmnV
 tKwk/eZIq17C7yYZLtgf4JhwsnYFmSsLOqSnzFQT75Fx00wXZ/5rtGsyzhzBTYFOBpiM
 2Yg6tI4N6Q+UFIJX7hkwuHf91SDCeiIrGnU4M2eFKYEuo6BmdJ+zw95JSy3ve6WmIVfM
 F8rJa2bb4Y7Bf+5w7I8psq+fYMG28IwsUfxMj0VIOJGeywAdWNfrIGFGf1An+bmvPm0H
 Ag/r60YZ77e7zfYicpKtLGWWid3RyAw/TzaGvGWtBvpiLK6tLHxiJ1wc8LkgThpfamAW
 1ULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LAFmiXxXpTd2DVZ1qFqzt2ULhZG8IhtLoMduAviIhCM=;
 b=p65L2+yTK8urtKWufL/d0f32u+MIoNv1/GRffr8jDhKNtXyOJ23l4s47kdznDNn6O4
 IVkHKC8kTGZv+pJjFa7KOoHZomoLXQAm8ePlnIRYkI+v62NKj/I+kDKjDTyhPbr0jPRD
 f2sQpgFMNbslUaT5knev8ZTx99QZOI2LhNq/Wrm+h4gBn7E39fMnXUEnrug9ODnGZI7F
 ZEKlvEXX8l76em5sCodzV5SPTvIEO/x0h0ITvp0CLAiT/imPcJzAljPwyCgA/y4sObjM
 tKjVTe3VRKEF7alzfYHwUbv5SNIEoDZ0VYYQlo+P3GY/1d1CfIdMzm3gs8ox2zYOKy8Z
 SaZw==
X-Gm-Message-State: AFqh2kqSUxWKusGIb5u4i06UyvUQm0r3/MP8P+gQ7WULYc93wfbW+xlH
 oKf7iw7F2m7tnof/slab3pHNM57IcqBktpeWE6XUeTdz
X-Google-Smtp-Source: AMrXdXvwXqnZ1zFDchtb/ldZnkjUzpuT/6kvuqXjthF8+hNtqMzrruR2wfHOyAe+YP5alLzIB27WoCD1+GqWjAcZeLA=
X-Received: by 2002:a05:6808:2001:b0:35b:d93f:cbc4 with SMTP id
 q1-20020a056808200100b0035bd93fcbc4mr4282560oiw.96.1673273993947; Mon, 09 Jan
 2023 06:19:53 -0800 (PST)
MIME-Version: 1.0
References: <20230109130120.73389-1-christian.koenig@amd.com>
In-Reply-To: <20230109130120.73389-1-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 9 Jan 2023 09:19:42 -0500
Message-ID: <CADnq5_P90Xb+8jfKE73HxnoKjOAJAo_JD4+iRHbgs4xWRs_=SA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix pipeline sync v2
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
Cc: luben.tuikov@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jan 9, 2023 at 8:01 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> This fixes a potential memory leak of dma_fence objects in the CS code
> as well as glitches in firefox because of missing pipeline sync.
>
> v2: use the scheduler instead of the fence context for the test
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/2323
> Fixes: 1b2d5eda5ad7 ("drm/amdgpu: move explicit sync check into the CS")
> Tested-by: Michal Kubecek <mkubecek@suse.cz>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 46 +++++++++++++++++---------
>  1 file changed, 30 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_cs.c
> index 47763ac0d14a..7b5ce00f0602 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -61,6 +61,8 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parse=
r *p,
>                 amdgpu_ctx_put(p->ctx);
>                 return -ECANCELED;
>         }
> +
> +       amdgpu_sync_create(&p->sync);
>         return 0;
>  }
>
> @@ -452,18 +454,6 @@ static int amdgpu_syncobj_lookup_and_add(struct amdg=
pu_cs_parser *p,
>         }
>
>         r =3D amdgpu_sync_fence(&p->sync, fence);
> -       if (r)
> -               goto error;
> -
> -       /*
> -        * When we have an explicit dependency it might be necessary to i=
nsert a
> -        * pipeline sync to make sure that all caches etc are flushed and=
 the
> -        * next job actually sees the results from the previous one.
> -        */
> -       if (fence->context =3D=3D p->gang_leader->base.entity->fence_cont=
ext)
> -               r =3D amdgpu_sync_fence(&p->gang_leader->explicit_sync, f=
ence);
> -
> -error:
>         dma_fence_put(fence);
>         return r;
>  }
> @@ -1188,10 +1178,19 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs=
_parser *p)
>  static int amdgpu_cs_sync_rings(struct amdgpu_cs_parser *p)
>  {
>         struct amdgpu_fpriv *fpriv =3D p->filp->driver_priv;
> +       struct drm_gpu_scheduler *sched;
>         struct amdgpu_bo_list_entry *e;
> +       struct dma_fence *fence;
>         unsigned int i;
>         int r;
>
> +       r =3D amdgpu_ctx_wait_prev_fence(p->ctx, p->entities[p->gang_lead=
er_idx]);
> +       if (r) {
> +               if (r !=3D -ERESTARTSYS)
> +                       DRM_ERROR("amdgpu_ctx_wait_prev_fence failed.\n")=
;
> +               return r;
> +       }
> +
>         list_for_each_entry(e, &p->validated, tv.head) {
>                 struct amdgpu_bo *bo =3D ttm_to_amdgpu_bo(e->tv.bo);
>                 struct dma_resv *resv =3D bo->tbo.base.resv;
> @@ -1211,10 +1210,24 @@ static int amdgpu_cs_sync_rings(struct amdgpu_cs_=
parser *p)
>                         return r;
>         }
>
> -       r =3D amdgpu_ctx_wait_prev_fence(p->ctx, p->entities[p->gang_lead=
er_idx]);
> -       if (r && r !=3D -ERESTARTSYS)
> -               DRM_ERROR("amdgpu_ctx_wait_prev_fence failed.\n");
> -       return r;
> +       sched =3D p->gang_leader->base.entity->rq->sched;
> +       while ((fence =3D amdgpu_sync_get_fence(&p->sync))) {
> +               struct drm_sched_fence *s_fence =3D to_drm_sched_fence(fe=
nce);
> +
> +               /*
> +                * When we have an dependency it might be necessary to in=
sert a
> +                * pipeline sync to make sure that all caches etc are flu=
shed and the
> +                * next job actually sees the results from the previous o=
ne
> +                * before we start executing on the same scheduler ring.
> +                */
> +               if (!s_fence || s_fence->sched !=3D sched)
> +                       continue;
> +
> +               r =3D amdgpu_sync_fence(&p->gang_leader->explicit_sync, f=
ence);
> +               if (r)
> +                       return r;
> +       }
> +       return 0;
>  }
>
>  static void amdgpu_cs_post_dependencies(struct amdgpu_cs_parser *p)
> @@ -1347,6 +1360,7 @@ static void amdgpu_cs_parser_fini(struct amdgpu_cs_=
parser *parser)
>  {
>         unsigned i;
>
> +       amdgpu_sync_free(&parser->sync);
>         for (i =3D 0; i < parser->num_post_deps; i++) {
>                 drm_syncobj_put(parser->post_deps[i].syncobj);
>                 kfree(parser->post_deps[i].chain);
> --
> 2.34.1
>
