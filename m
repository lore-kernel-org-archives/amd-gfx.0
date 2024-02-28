Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA0CAC47DD9
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Feb 2024 14:42:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71E2110E091;
	Wed, 28 Feb 2024 14:42:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="G5BFw7R9";
	dkim-atps=neutral
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7A1C10E091
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Feb 2024 14:42:34 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-1dc5d0162bcso46991855ad.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Feb 2024 06:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709131354; x=1709736154; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9RrRoP9FTKB9RW0a54kzqv0BuA+7ynzoItfg7omv4V0=;
 b=G5BFw7R9+bBM2SUFIR+g+FET1wJdJ164/EwX34NSM+p6kC2lFXDXROXnpa1j0KKS0S
 CDCy7M3DePGT4eLsDIl05qAzCJUxypWh9RIA0bhjD74c1tkEul3m/FN55JLeWhWlspc4
 hcQ1HnzIfIikK9ivtW1fnTcZv6eh6ZZ+B2OoCwSFSZnq4DxrUpMARV3f6pFFqixX+xiX
 eG7O2CxZRA4+u54oNwH7wwiT0HOaijaonM9IXh7axVogxqTcrwdZHVUGQFfwu7NT942p
 BGjhUWlE18hf5WTuqnDn7vHUbvHw2zKp/WcNyfueaxXnZ2Lxwgx1Feo2b0rGwVI3y+g6
 EtWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709131354; x=1709736154;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9RrRoP9FTKB9RW0a54kzqv0BuA+7ynzoItfg7omv4V0=;
 b=ihenlueaaez0lERd9oFO7yxMRkyctSOTaEJHidnfvCx/gQG1A9zTHjV/RWVI5sSYYL
 u1GQ2X8MaCzl+dkiX1bq4MAUvS5RNdL/yDXsBr8QRMCUrNBXi80RTZQ8DCBg+O7sEnJk
 TJ8aorzhqt5OS9HAwvlJ2+An01va/5duUDW2ffiEBMcHarN5tADQhzOAeQs2UgsGxRAM
 gi6uC7H5jojzereUAodLL1xcBx0zQJuT7kWhA5KREJduREKEPfNY3SIKh6AhETpwdhor
 oOVvpPjPQWq343NKjpB0+exLiWCew+f57qo1HJXiDCD1AEUxOuVUZ98pYXU+sfviie2z
 h1EQ==
X-Gm-Message-State: AOJu0Yz+7PKqa4/WNj0tuDLknZpHQ5dNWfFGIML107GGL3D/qRq77IQW
 UJsfO0AbjTWZCHpILwCQtRNEtS/GeVIwAWNqSEudj6jRTrhUKBMt1tgV4lxiualI4EigsL97/So
 FCQMDdL3VyIVEVSS+8mSEygGo6Wo=
X-Google-Smtp-Source: AGHT+IH8ufNgb0fpIuaM5xZJQ8Dpj5Sy+mrw+hm4SircDNMBMwGzFY4eOdfs4S2GBId3z8xIvu7in3fudXGDvCXJ8R8=
X-Received: by 2002:a17:902:c943:b0:1db:916e:d77a with SMTP id
 i3-20020a170902c94300b001db916ed77amr17006337pla.2.1709131353967; Wed, 28 Feb
 2024 06:42:33 -0800 (PST)
MIME-Version: 1.0
References: <20240227155355.517538-1-Harish.Kasiviswanathan@amd.com>
In-Reply-To: <20240227155355.517538-1-Harish.Kasiviswanathan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 28 Feb 2024 09:42:21 -0500
Message-ID: <CADnq5_PXiXTX+va2Y_WzwP2a+rmW4V6zyd_oeTLHa+F=12N5DQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Removed used parameter
To: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

On Tue, Feb 27, 2024 at 11:13=E2=80=AFAM Harish Kasiviswanathan
<Harish.Kasiviswanathan@amd.com> wrote:
>
> Also passing adev is misleading if BO is associated with different adev.
> In this case BO is mapped to a different device
>
> Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h       | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 4 ++--
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c         | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_amdkfd.h
> index 4fb32d86cd0e..0ef223c2affb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -320,7 +320,7 @@ int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct k=
gd_mem *mem,
>                                              void **kptr, uint64_t *size)=
;
>  void amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(struct kgd_mem *mem);
>
> -int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_device *adev, struct =
amdgpu_bo *bo);
> +int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_bo *bo);
>
>  int amdgpu_amdkfd_gpuvm_restore_process_bos(void *process_info,
>                                             struct dma_fence __rcu **ef);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index ef71b12062a1..d0819fa5fcd8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -2189,13 +2189,13 @@ int amdgpu_amdkfd_gpuvm_sync_memory(
>
>  /**
>   * amdgpu_amdkfd_map_gtt_bo_to_gart - Map BO to GART and increment refer=
ence count
> - * @adev: Device to which allocated BO belongs
>   * @bo: Buffer object to be mapped
>   *
> + * BO will be mapped to GART of adev to which it is previously associate=
d with
>   * Before return, bo reference count is incremented. To release the refe=
rence and unpin/
>   * unmap the BO, call amdgpu_amdkfd_free_gtt_mem.
>   */
> -int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_device *adev, struct =
amdgpu_bo *bo)
> +int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_bo *bo)
>  {
>         int ret;
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/a=
md/amdkfd/kfd_chardev.c
> index 824e660283b2..f030cafc5a0a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -371,7 +371,7 @@ static int kfd_ioctl_create_queue(struct file *filep,=
 struct kfd_process *p,
>                         goto err_wptr_map_gart;
>                 }
>
> -               err =3D amdgpu_amdkfd_map_gtt_bo_to_gart(dev->adev, wptr_=
bo);
> +               err =3D amdgpu_amdkfd_map_gtt_bo_to_gart(wptr_bo);
>                 if (err) {
>                         pr_err("Failed to map wptr bo to GART\n");
>                         goto err_wptr_map_gart;
> --
> 2.34.1
>
