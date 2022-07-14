Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF842C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jul 2022 15:10:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58128113470;
	Thu, 14 Jul 2022 15:10:38 +0000 (UTC)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2B13113470
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jul 2022 15:10:36 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id v12so2792282edc.10
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jul 2022 08:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=SN4zWIaKibleur8LDpln6pW7nvGUcxpjyWJfonGVcgY=;
 b=ZhdyFylPfA35/MHUX67DwYErquNMdtDxSdr81hTwrshetk/M0r/wRL/PhXbdfnM1Dx
 xZwwslnXnK1m+TZJew7kDFEwrqPjf95DaPfwzKFCMGqyBfCnonpirP0xBrqfjxXE++dp
 ekm9hpK6QPSxHgYIVyf7yDUe27ep8WD981vQFN5ffopFiW+aHfgabEz+HLtDDKdr80Vc
 XTUo2a5YYFEj8emO9D7PBz1xIZM8Bb5z6gtwdG4aXdFgbHCjmtk/0yplZtsAEGJJ9jdT
 1iK/uJpw9aWJV6JLpAjOKyu6LaSp7iZvuQDeZ5pdXhLFCyxevEMt84lo4NXs57Dyhlf+
 kLVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=SN4zWIaKibleur8LDpln6pW7nvGUcxpjyWJfonGVcgY=;
 b=yJ47PRudMtv1pEB2IexXFmRgJIFXthnMVRLs5WyBbq6lGXlwKMSWwEpDwqlSub+Aex
 nQR6zVSMuQ8qR0GRkfk7MtLtuREobLVCG0znUP06FiSJmNsu5vnlVyA0GHs2z0IETccH
 o/GSIzjWoHH/PngEuQl9Dbunrk7PlKrtrnLa9awQRbsS+S3GsVpyhSpMHjm/I0y0znDd
 cHqRBJUii4O+AaLVSU8BjMT5HMCUqamlzPVyGCt8s0z5J/aaG8aMReLWaCApK/FOO5ja
 MNJ/NpYGQrVuKsm19W/cfhySdM+H643Z+zzsEf40Qu+F64yGlsgj4aWAnw0G7+3dCL1l
 jEew==
X-Gm-Message-State: AJIora+yINt7n1P5zrIL1rKUcaTQMz1v34L0nsAxjY3YeyGbkR5hjqf+
 9G+jqy8A32qyWEP2Mt/dQEt/3WeGjqUnZfwQG30=
X-Google-Smtp-Source: AGRyM1vWetcS0O8Sy9eoLt1X0Xs+PSunKAZakb+9tQBdUXVTMQJjv8F8L1AM3uQWRvHOIGPyQABIxbPhzOVDBVcQUxg=
X-Received: by 2002:a05:6402:13:b0:439:ffe8:bec9 with SMTP id
 d19-20020a056402001300b00439ffe8bec9mr13190592edu.297.1657811435321; Thu, 14
 Jul 2022 08:10:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220714103902.7084-1-christian.koenig@amd.com>
 <20220714103902.7084-3-christian.koenig@amd.com>
In-Reply-To: <20220714103902.7084-3-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 14 Jul 2022 11:10:23 -0400
Message-ID: <CADnq5_PMzJwJfibstGBLExH0z4aH1ZJiy-uezBa2YtB6z7+G=g@mail.gmail.com>
Subject: Re: [PATCH 02/10] drm/amdgpu: Protect the amdgpu_bo_list list with a
 mutex v2
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
Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <Marek.Olsak@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Yogesh.Mohanmarimuthu@amd.com,
 Luben Tuikov <luben.tuikov@amd.com>, Vitaly Prosyak <Vitaly.Prosyak@amd.com>,
 Alex Deucher <Alexander.Deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jul 14, 2022 at 6:39 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> From: Luben Tuikov <luben.tuikov@amd.com>
>
> Protect the struct amdgpu_bo_list with a mutex. This is used during comma=
nd
> submission in order to avoid buffer object corruption as recorded in
> the link below.
>
> v2 (chk): Keep the mutex looked for the whole CS to avoid using the
>           list from multiple CS threads at the same time.
>
> Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <Alexander.Deucher@amd.com>
> Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
> Cc: Vitaly Prosyak <Vitaly.Prosyak@amd.com>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2048
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>

I think this is a valid bug fix on its own for stable.
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c |  3 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h |  4 ++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c      | 16 +++++++++++++---
>  3 files changed, 19 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_bo_list.c
> index 714178f1b6c6..2168163aad2d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> @@ -40,7 +40,7 @@ static void amdgpu_bo_list_free_rcu(struct rcu_head *rc=
u)
>  {
>         struct amdgpu_bo_list *list =3D container_of(rcu, struct amdgpu_b=
o_list,
>                                                    rhead);
> -
> +       mutex_destroy(&list->bo_list_mutex);
>         kvfree(list);
>  }
>
> @@ -136,6 +136,7 @@ int amdgpu_bo_list_create(struct amdgpu_device *adev,=
 struct drm_file *filp,
>
>         trace_amdgpu_cs_bo_status(list->num_entries, total_size);
>
> +       mutex_init(&list->bo_list_mutex);
>         *result =3D list;
>         return 0;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_bo_list.h
> index 529d52a204cf..9caea1688fc3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
> @@ -47,6 +47,10 @@ struct amdgpu_bo_list {
>         struct amdgpu_bo *oa_obj;
>         unsigned first_userptr;
>         unsigned num_entries;
> +
> +       /* Protect access during command submission.
> +        */
> +       struct mutex bo_list_mutex;
>  };
>
>  int amdgpu_bo_list_get(struct amdgpu_fpriv *fpriv, int id,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_cs.c
> index b28af04b0c3e..d8f1335bc68f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -519,6 +519,8 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_pars=
er *p,
>                         return r;
>         }
>
> +       mutex_lock(&p->bo_list->bo_list_mutex);
> +
>         /* One for TTM and one for the CS job */
>         amdgpu_bo_list_for_each_entry(e, p->bo_list)
>                 e->tv.num_shared =3D 2;
> @@ -651,6 +653,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_pars=
er *p,
>                         kvfree(e->user_pages);
>                         e->user_pages =3D NULL;
>                 }
> +               mutex_unlock(&p->bo_list->bo_list_mutex);
>         }
>         return r;
>  }
> @@ -690,9 +693,11 @@ static void amdgpu_cs_parser_fini(struct amdgpu_cs_p=
arser *parser, int error,
>  {
>         unsigned i;
>
> -       if (error && backoff)
> +       if (error && backoff) {
>                 ttm_eu_backoff_reservation(&parser->ticket,
>                                            &parser->validated);
> +               mutex_unlock(&parser->bo_list->bo_list_mutex);
> +       }
>
>         for (i =3D 0; i < parser->num_post_deps; i++) {
>                 drm_syncobj_put(parser->post_deps[i].syncobj);
> @@ -832,12 +837,16 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_p=
arser *p)
>                         continue;
>
>                 r =3D amdgpu_vm_bo_update(adev, bo_va, false);
> -               if (r)
> +               if (r) {
> +                       mutex_unlock(&p->bo_list->bo_list_mutex);
>                         return r;
> +               }
>
>                 r =3D amdgpu_sync_fence(&p->job->sync, bo_va->last_pt_upd=
ate);
> -               if (r)
> +               if (r) {
> +                       mutex_unlock(&p->bo_list->bo_list_mutex);
>                         return r;
> +               }
>         }
>
>         r =3D amdgpu_vm_handle_moved(adev, vm);
> @@ -1278,6 +1287,7 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser=
 *p,
>
>         ttm_eu_fence_buffer_objects(&p->ticket, &p->validated, p->fence);
>         mutex_unlock(&p->adev->notifier_lock);
> +       mutex_unlock(&p->bo_list->bo_list_mutex);
>
>         return 0;
>
> --
> 2.25.1
>
