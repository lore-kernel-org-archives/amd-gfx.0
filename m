Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF858E7FDE0
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Feb 2026 22:40:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E3B010E0BC;
	Mon,  2 Feb 2026 22:40:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TOfz2Vtg";
	dkim-atps=neutral
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C16B10E3DB
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Feb 2026 22:40:27 +0000 (UTC)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-2b8095668ebso184257eec.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Feb 2026 14:40:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770072026; cv=none;
 d=google.com; s=arc-20240605;
 b=BT5URIOYa8zUoJj8VB45fmzcqoFdiRNIDA3ZDFuWf/VKfqastAepmbaOJEN8yjq5SV
 tefkiWw2UuHolU1/JEjDYoqZpc0nDbMsI/tLxTRewA7cbEtFgVS5pug6pdKxhyF4HdJx
 58KJtd/1J1/mClptoZiBN886czZEquzRB+H+QpVFf9e2mggGGQ92CmOV+kJx5qsDg+Oc
 Y5gYCnr7Kgv7l5yWdoTm03hpNPFrpj39juWNn/iJI6ioenDxfI49E1NcsCSzueFhu/mv
 2RhVa3pAwjP4xt6TQZmH2sLF/H0leqjcbfQDOLYBE/7gSM6TztRILsYNldASvLILyjzQ
 TTlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9qGNK2Z9yzrkSdvhnSYW8dzZBf3cmo3e+C1MADwz/BA=;
 fh=E8U53EWEOdJX89MppPQsm+RjWyPsYote+DeS/AUzNG4=;
 b=aZdk4GQxifEbNFlCBUj2hmXC4OcV8CBsZCp9+fNlk4vm/4NsklBsxGg1pNKlTflShx
 9Oc2zzrsEDe7TpBvCaD6lQw0PKm4rKYCygqE2EUvPvXlA+Jp7VBPF+YgbM+qvZ5Ac3pO
 1tLvuTIYO5u7VYVe/cjjEvFZSFpY0X2fiated8ATkaAwUpZ2Yo+Wr04rEYIVYunk9VQf
 k5mFP3tMfPx0uGKc2Xr9KZIvcLxfRr+evdFm3Yj2NPVBqi96rlETvg3+SiufdXsV4BcD
 X/WCrrYf7FIKGytxfAATyFCr+dRmASJODeY65ne83RRlWdyDslmnOdjG/3OgjyAOpEdZ
 8m3Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770072026; x=1770676826; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9qGNK2Z9yzrkSdvhnSYW8dzZBf3cmo3e+C1MADwz/BA=;
 b=TOfz2VtglOkMY4nxnhsdUbuDxrOdr/KAjEvenHIbgJ3zlE+/kzZeURxOZOjMGwDjrj
 gNLmlC5yT82Hpbeu4W7kGJqYHJZyg4XDgHxlM6cSNcM5oxeM5lpi7SOEe7KuSZnSJKGA
 7Sz9UyWieABFOiHbMkRmI37dl4t24N5vXI2lokXNr9xHYo/NebD9pFJdIX1OERy4t8pU
 PwBB9CWnxduN0fRjq5819VY7W1kjqmz8y9u/gwvVMeYw1WcOSDv5TEV1nE+fMJWS/IVi
 VwxDo1J+aCG+h9CNfITkWEXxW6HIdXelaXq2yXfksNAob6qKeyxMWxyV19bGPlahUOPm
 05Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770072026; x=1770676826;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9qGNK2Z9yzrkSdvhnSYW8dzZBf3cmo3e+C1MADwz/BA=;
 b=e+tHRzppW60w6RLv8oYwKDcAXPaw2jLNDU69b/yZ6HDTnzgMc5nWSVGYZaoe5/INcR
 Mn/ZP20Ye6s81cdM5G4naD8Q8zbsA67K1MvMCgLPoEf6zXQl/Z2PH+8S1UZztEHVf1BD
 FkV0Wr0CdnaxxJG4+SuLXFS4riP1hg/fP0KaELyzZEO3vyRPc9dGgbkRxCP7qak0CgfU
 KRfHIHaSej5R52Zye4VHuz3Z/OEI8yTBXjY4f75PbJUfaI0MXcGe8MRBQIPi2M9g6UE3
 jvsPcI+qrlHOfaLa4gvOQDQnact/aDEs1mu8/pvdvTZc6YDDqw/GEB6FkRUbMdNpJu2F
 mmhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGSZSA8zUOiifUA1Kmus36qfotkV0VNXqgmwYFpfPaRq0/XkJn+Q2/IijAvNgW3VOZqDDgygJR@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyQiN4z9AL50KhC3LCLv5VGxzersLnzicNPRLMPlA39/MrSeCEU
 fLGpqgCPDuPGFNNXdMgB9YHsuw63t909KT6xP5tBCcK9utrJ/nfN+cBbKn2RNd2KWdxlED7WDYF
 yeqnecV+Spwqxqfq63MOzY9v9Z/rtWvM=
X-Gm-Gg: AZuq6aLOSwxKprXRo1KYMrVSkgv9yXyzUe+78VHSfRv0L6jPyPJg3QS7af7G58R0jNJ
 6tCXWW8IS/uXcJY0Y+yiGaciueBegEmNPnt0ned9W7GMW0TVN/Shirea+BgosfwDGW86m7oNm9C
 nIaEFXfoQZp66oVWBKtY6XXu8mFourhSuF55ni+CrHP2Yr1ain7UzLYPdimFblpSA85yVhTXVnE
 ksPD6eOU/IgM57Y+Un2OUlGGcynsO1gtFDHBf8MdaVGJTkR1zLRejdbvffCrWf0RGlNyX/n
X-Received: by 2002:a05:7022:3b02:b0:11e:332:1e01 with SMTP id
 a92af1059eb24-125c1003434mr2382967c88.3.1770072026440; Mon, 02 Feb 2026
 14:40:26 -0800 (PST)
MIME-Version: 1.0
References: <20260202125149.2067-1-christian.koenig@amd.com>
 <20260202125149.2067-6-christian.koenig@amd.com>
In-Reply-To: <20260202125149.2067-6-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 2 Feb 2026 17:40:14 -0500
X-Gm-Features: AZwV_QguSo9E9Q9M009HVC8oGAKCmUA7I7SW_ZlpvJYoX7kJ9rM1KggZjiL7nFo
Message-ID: <CADnq5_OiZc8z8jxCLAD5k+=YMfuCjc=GNNnp4xaU_fOvkYJykw@mail.gmail.com>
Subject: Re: [PATCH 6/9] drm/amdgpu: fix adding eviction fence
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: tursulin@ursulin.net, Alexander.Deucher@amd.com, Prike.Liang@amd.com, 
 Yogesh.Mohanmarimuthu@amd.com, SRINIVASAN.SHANMUGAM@amd.com, 
 Sunil.Khatri@amd.com, amd-gfx@lists.freedesktop.org
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

On Mon, Feb 2, 2026 at 8:37=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> We can't add the eviction fence without validating the BO.
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../drm/amd/amdgpu/amdgpu_eviction_fence.c    | 19 ++++++++++++++++---
>  .../drm/amd/amdgpu/amdgpu_eviction_fence.h    |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |  9 ++++++---
>  3 files changed, 24 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers=
/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> index ef4da6f2e2a3..6598823ec619 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> @@ -82,14 +82,27 @@ amdgpu_eviction_fence_suspend_worker(struct work_stru=
ct *work)
>         mutex_unlock(&uq_mgr->userq_mutex);
>  }
>
> -void amdgpu_evf_mgr_attach_fence(struct amdgpu_eviction_fence_mgr *evf_m=
gr,
> -                                struct amdgpu_bo *bo)
> +int amdgpu_evf_mgr_attach_fence(struct amdgpu_eviction_fence_mgr *evf_mg=
r,
> +                               struct amdgpu_bo *bo)
>  {
>         struct dma_fence *ev_fence =3D amdgpu_evf_mgr_get_fence(evf_mgr);
> +       struct ttm_operation_ctx ctx =3D { false, false };
>         struct dma_resv *resv =3D bo->tbo.base.resv;
> +       int ret;
> +
> +       if (!dma_fence_is_signaled(ev_fence)) {
> +
> +               amdgpu_bo_placement_from_domain(bo, bo->allowed_domains);
> +               ret =3D ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
> +               if (!ret)
> +                       dma_resv_add_fence(resv, ev_fence,
> +                                          DMA_RESV_USAGE_BOOKKEEP);
> +       } else {
> +               ret =3D 0;
> +       }
>
> -       dma_resv_add_fence(resv, ev_fence, DMA_RESV_USAGE_BOOKKEEP);
>         dma_fence_put(ev_fence);
> +       return ret;
>  }
>
>  int amdgpu_evf_mgr_rearm(struct amdgpu_eviction_fence_mgr *evf_mgr,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h b/drivers=
/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
> index 132a13a5dc1c..2a750add4e7b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
> @@ -58,8 +58,8 @@ amdgpu_evf_mgr_get_fence(struct amdgpu_eviction_fence_m=
gr *evf_mgr)
>         return ev_fence;
>  }
>
> -void amdgpu_evf_mgr_attach_fence(struct amdgpu_eviction_fence_mgr *evf_m=
gr,
> -                                struct amdgpu_bo *bo);
> +int amdgpu_evf_mgr_attach_fence(struct amdgpu_eviction_fence_mgr *evf_mg=
r,
> +                               struct amdgpu_bo *bo);
>  int amdgpu_evf_mgr_rearm(struct amdgpu_eviction_fence_mgr *evf_mgr,
>                          struct drm_exec *exec);
>  void amdgpu_evf_mgr_detach_fence(struct amdgpu_eviction_fence_mgr *evf_m=
gr,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gem.c
> index e28abfd04867..88a21400ae09 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -258,12 +258,15 @@ static int amdgpu_gem_object_open(struct drm_gem_ob=
ject *obj,
>
>         amdgpu_vm_bo_update_shared(abo);
>         bo_va =3D amdgpu_vm_bo_find(vm, abo);
> -       if (!bo_va)
> +       if (!bo_va) {
>                 bo_va =3D amdgpu_vm_bo_add(adev, vm, abo);
> -       else
> +               r =3D amdgpu_evf_mgr_attach_fence(&fpriv->evf_mgr, abo);
> +               if (r)
> +                       goto out_unlock;
> +       } else {
>                 ++bo_va->ref_count;
> +       }
>
> -       amdgpu_evf_mgr_attach_fence(&fpriv->evf_mgr, abo);
>         drm_exec_fini(&exec);
>
>         /* Validate and add eviction fence to DMABuf imports with dynamic
> --
> 2.43.0
>
