Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0190EC5AD49
	for <amd-gfx@archiver.kernel.org>; Fri, 30 May 2025 21:54:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96D4910E89F;
	Fri, 30 May 2025 21:54:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Mi+3kPiR";
	dkim-atps=neutral
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B35CF10E89F
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 May 2025 21:54:32 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-30eccc61f96so376119a91.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 May 2025 14:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748642072; x=1749246872; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y+D2wceAzXYZZVpnVJWkxx8qyHcBBptHaTZTTVGZwUQ=;
 b=Mi+3kPiRrGbkbCo4NSQkw6OxuzQHdyZTQXGPw4q9vnEfLWzHQyKaa/4bDwePCXquip
 aMoRYuheeOQ57QfofP02iHIgDdnKvGRwE+FtOYmtS3QPnx8z3RU+TWQgbsiPT+12wl5S
 ZnT5TbIFllX4cz+BANecUYHrh+Wtn1FLCiJwiGnEDtidIPdIJmutf9CnwBnWuKGw0u0I
 EXhYRt7mhW6QI4Y7ZH1d63zauQww19bMwlx/90Gld+U0SCjHS68m0YCsMlhQ3TQ3YicK
 VBvHjDcgG9oVGkW/KqOTyedjEI0x1VnCFNcykECa742uiESGbOKH7p7v5xuqImFnh0Y/
 5zyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748642072; x=1749246872;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y+D2wceAzXYZZVpnVJWkxx8qyHcBBptHaTZTTVGZwUQ=;
 b=sJp3gQYWbEZH3y6h6bV8ndpyhrdHktyQ+keh11xCxR2eFbf5OapxkP+O+AFFhmFCGS
 lQA5MTB2HJCb8Y+yLTs01bBj+fxtVcbLFFi4RGOF9IciKww9elnTfsCcAHw/y8QJcYJV
 9IFXjROjtzAuKd+Si901fBFERLAFPyrqBUNfdmfxSnIulzggHywXn4syH4ZB3a5aJO5M
 USdrPQLoYB66anoCWddVCDRsVKf5lU9ujHGrYz8proHz9tfM01xLnHj1wWHtTL5MViDb
 2aRSkdxJzdlKlk/Lh9bhVjdTrs3kNjN9tQR651dL+YmD50Z38nfdixZqOGzgMpCxxh3b
 9myg==
X-Gm-Message-State: AOJu0Ywo/IGiYHjXTlPPfGOFjm99BV6K5s5xSlpAtg3msI3XNZwjLE+D
 DnjRHbOlPG7KxlDvAocn2i8vAVPHImFSuHX+A9XQs49AG1XXykBmNexkSLGPiWecl4vGW4Fh1YZ
 8hyo7LprX6/DLBHj38w7uk0cXXDQDGP6A7g==
X-Gm-Gg: ASbGncvmCDA+M3uGRrsLc78T09n8ITqDt1YJ+QgurMEUQCxkeKggavZ5iN8TOY7zPkt
 Cc+pRg+zn7NqMckZjSe1zhCa0Wfg/RwQIywnddOuWmIq6TXl4zIQWETvZvr99a/O1fT6ZXujVa9
 2IuJtNgBWfoeYGiHUys6egJpd5O+lUM2VeVLXtS44+kgip
X-Google-Smtp-Source: AGHT+IGrP0s7yXvqrlNHmd0ozx/GbVvGBQfTtOPMtF2/Vmqbv4l/m+jv6d3Jd02lRdqFxIPy3V6leXn1En+hUonqI5M=
X-Received: by 2002:a17:90b:270d:b0:30a:80bc:ad4 with SMTP id
 98e67ed59e1d1-3123ef57a61mr2872702a91.0.1748642072188; Fri, 30 May 2025
 14:54:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250530075505.882004-1-Prike.Liang@amd.com>
 <20250530075505.882004-9-Prike.Liang@amd.com>
In-Reply-To: <20250530075505.882004-9-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 30 May 2025 17:54:20 -0400
X-Gm-Features: AX0GCFvCaaaXdSY-gkIwv98T2hM0_FDoKnAQwSUHZQmb26I87jBFSFdin_tnnyk
Message-ID: <CADnq5_M1nRDbPXRkbtdTbjgFBNRwJ_jHgCUp2+rhZcfrYogaAA@mail.gmail.com>
Subject: Re: [PATCH 9/9] drm/amdgpu: validate userq activity status for GEM_VA
 unmap
To: Prike Liang <Prike.Liang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian.Koenig@amd.com, Lijo.Lazar@amd.com
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

On Fri, May 30, 2025 at 4:05=E2=80=AFAM Prike Liang <Prike.Liang@amd.com> w=
rote:
>
> The userq VA unmap requires validating queue status before unamapping
> it, if user tries to unmap an active userq by GEM VA IOCTL then the
> driver should report an error for this illegal usage.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 16 +++++++++++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  5 +++++
>  2 files changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index e43a61f64755..e2275280554d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -234,7 +234,7 @@ amdgpu_userq_map_helper(struct amdgpu_userq_mgr *uq_m=
gr,
>         return r;
>  }
>
> -static void
> +static int
>  amdgpu_userq_wait_for_last_fence(struct amdgpu_userq_mgr *uq_mgr,
>                                  struct amdgpu_usermode_queue *queue)
>  {
> @@ -243,10 +243,14 @@ amdgpu_userq_wait_for_last_fence(struct amdgpu_user=
q_mgr *uq_mgr,
>
>         if (f && !dma_fence_is_signaled(f)) {
>                 ret =3D dma_fence_wait_timeout(f, true, msecs_to_jiffies(=
100));
> -               if (ret <=3D 0)
> +               if (ret <=3D 0) {
>                         drm_file_err(uq_mgr->file, "Timed out waiting for=
 fence=3D%llu:%llu\n",
>                                      f->context, f->seqno);
> +                       return -ETIMEDOUT;
> +               }
>         }
> +
> +       return 0;
>  }
>
>  static void
> @@ -464,7 +468,13 @@ amdgpu_userq_destroy(struct drm_file *filp, int queu=
e_id)
>                 mutex_unlock(&uq_mgr->userq_mutex);
>                 return -EINVAL;
>         }
> -       amdgpu_userq_wait_for_last_fence(uq_mgr, queue);
> +
> +       if (amdgpu_userq_wait_for_last_fence(uq_mgr, queue)) {
> +               drm_warn(adev_to_drm(uq_mgr->adev), "Don't destroy a busy=
 userq\n");
> +               mutex_unlock(&uq_mgr->userq_mutex);
> +               return -EINVAL;
> +       }
> +
>         r =3D amdgpu_bo_reserve(queue->db_obj.obj, true);
>         if (!r) {
>                 amdgpu_bo_unpin(queue->db_obj.obj);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.c
> index 5e075e8f0ca3..168fc3835aaf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1930,6 +1930,11 @@ int amdgpu_vm_bo_unmap(struct amdgpu_device *adev,
>         struct amdgpu_vm *vm =3D bo_va->base.vm;
>         bool valid =3D true;
>
> +       if (amdgpu_userq_gem_va_unmap_wait(vm)) {
> +               dev_warn(adev->dev, "shouldn't unmap the VA for an active=
 userq\n");
> +               return -EINVAL;
> +       }

There's not need to wait for anything.  Just return an error if the
userq has not been destroyed yet.

Alex

> +
>         saddr /=3D AMDGPU_GPU_PAGE_SIZE;
>
>         list_for_each_entry(mapping, &bo_va->valids, list) {
> --
> 2.34.1
>
