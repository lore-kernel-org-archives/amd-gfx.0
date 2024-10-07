Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA12FCFB453
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Oct 2024 18:36:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5306210E3FC;
	Mon,  7 Oct 2024 18:36:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZMAgiY5l";
	dkim-atps=neutral
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1C0810E3FC
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Oct 2024 18:36:28 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-2e13718283bso534328a91.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Oct 2024 11:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728326188; x=1728930988; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u0JiDMq6H0sRSaZBjs2rCFR09kLuq8QVdnzMidouxuU=;
 b=ZMAgiY5lLwPJWZvAiLrK1FTLwe4KovfXy8AlkiHZ+8QAL+MZaz/RpeVnQveZEtG3yP
 8PsmJkPXf3nojzGuD6k28/Mma96oSf9+wD3hE2EQzjASJdGAONx8Po6bjtr3GvEMg2K3
 eRFJSEiWhu2E1IWLReIg4hTTwEOQ2l7nccHsB5tlBy6kyjNAb9riveHBrSCpbTMLsaMW
 mrrY+P66aQUWMQy4u5SmdZ2qSg9887pmsxl+X+lrlyDi+zQQRqAbidqgOJmvoVmep5CQ
 irxLxUSAdeFM2qKql977LWHrOmlx+SvQVkTWyazxX6IUYoHBpp/dCZ/LeImj0JuUjZAS
 U9Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728326188; x=1728930988;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u0JiDMq6H0sRSaZBjs2rCFR09kLuq8QVdnzMidouxuU=;
 b=diKwHOLzfUjlpck0yBodGODOaaANbDpgEMBYA96s72X8PLUd/F4ax/684POLTsSw0M
 7KThVIG60/0D/rRf5LtZBV/l0aHHciYlRbsaHtpyooatcdgk9mARMAfCreMJMOBS8fDp
 1kHnOiSyojc6oscI1ILZuiHhUT6l0SnhFMHhIt+injICG2gh3qQvrDjH8QJG2gnWOTnA
 pBy09QYKYou0u173fe1nFahueBT76HWyZcDWOW0H7w7RHTr8PtyBo6BYfSWSSBevpugc
 kussbPDsGfj/klLuPK9qY7ZGk4I+AN73Uw4woMk6xMVFMcu2fZ/rY3abEO6zuwKIxsK4
 Iycw==
X-Gm-Message-State: AOJu0Yz5tWncbH26w1aT+qzP+D3lbzCd52w1VAFFVl4aabQ2nCRjsH/c
 CBWx2eroeoOVhDbBeVcfuNQC6O8OM8WEqatHyO4TAPRSY06Gv39hJSz+ReikVwZEKgDrVNn2Iww
 wOmb7vyyFGbGdGopO1duNLNrHfGk=
X-Google-Smtp-Source: AGHT+IFGCCvjowlF2a66l7ICNmwqNkO9EcOkE2rIDGjdJ1dtrh6oLvBakJyE2qaq+G+tEo94Dcaz35X/NMo/QRt9NlE=
X-Received: by 2002:a17:90a:e291:b0:2d3:b598:8daa with SMTP id
 98e67ed59e1d1-2e1e631b1a8mr6459559a91.4.1728326188036; Mon, 07 Oct 2024
 11:36:28 -0700 (PDT)
MIME-Version: 1.0
References: <20241007183241.1584-1-christian.koenig@amd.com>
In-Reply-To: <20241007183241.1584-1-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 7 Oct 2024 14:36:16 -0400
Message-ID: <CADnq5_PpmkbYppJWR6QLzm7J_iR4GpSOYYQbTR2Ni21t++R34w@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: always set GEM function pointer
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>, 
 Hans de Goede <hdegoede@redhat.com>,
 Christian Zigotzky <chzigotzky@xenosoft.de>, 
 Wu Hoi Pok <wuhoipok@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add a few people.

This should fix the radeon ttm gem conversion.

Alex



On Mon, Oct 7, 2024 at 2:33=E2=80=AFPM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Make sure to always set the GEM function pointer even for in kernel
> allocations. This fixes a NULL pointer deref caused by switching to GEM
> references.
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Fixes: fd69ef05029f ("drm/radeon: use GEM references instead of TTMs")
> ---
>  drivers/gpu/drm/radeon/radeon_gem.c    | 3 ---
>  drivers/gpu/drm/radeon/radeon_object.c | 1 +
>  2 files changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_gem.c b/drivers/gpu/drm/radeon=
/radeon_gem.c
> index 9735f4968b86..bf2d4b16dc2a 100644
> --- a/drivers/gpu/drm/radeon/radeon_gem.c
> +++ b/drivers/gpu/drm/radeon/radeon_gem.c
> @@ -44,8 +44,6 @@ struct sg_table *radeon_gem_prime_get_sg_table(struct d=
rm_gem_object *obj);
>  int radeon_gem_prime_pin(struct drm_gem_object *obj);
>  void radeon_gem_prime_unpin(struct drm_gem_object *obj);
>
> -const struct drm_gem_object_funcs radeon_gem_object_funcs;
> -
>  static vm_fault_t radeon_gem_fault(struct vm_fault *vmf)
>  {
>         struct ttm_buffer_object *bo =3D vmf->vma->vm_private_data;
> @@ -132,7 +130,6 @@ int radeon_gem_object_create(struct radeon_device *rd=
ev, unsigned long size,
>                 return r;
>         }
>         *obj =3D &robj->tbo.base;
> -       (*obj)->funcs =3D &radeon_gem_object_funcs;
>         robj->pid =3D task_pid_nr(current);
>
>         mutex_lock(&rdev->gem.mutex);
> diff --git a/drivers/gpu/drm/radeon/radeon_object.c b/drivers/gpu/drm/rad=
eon/radeon_object.c
> index d0e4b43d155c..7672404fdb29 100644
> --- a/drivers/gpu/drm/radeon/radeon_object.c
> +++ b/drivers/gpu/drm/radeon/radeon_object.c
> @@ -151,6 +151,7 @@ int radeon_bo_create(struct radeon_device *rdev,
>         if (bo =3D=3D NULL)
>                 return -ENOMEM;
>         drm_gem_private_object_init(rdev_to_drm(rdev), &bo->tbo.base, siz=
e);
> +       bo->tbo.base.funcs =3D &radeon_gem_object_funcs;
>         bo->rdev =3D rdev;
>         bo->surface_reg =3D -1;
>         INIT_LIST_HEAD(&bo->list);
> --
> 2.34.1
>
