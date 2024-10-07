Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25EE0CFB452
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Oct 2024 18:38:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC98010E3FD;
	Mon,  7 Oct 2024 18:38:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="M84dT9vv";
	dkim-atps=neutral
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EE0910E3FD
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Oct 2024 18:38:47 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-2e0ad414718so534992a91.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Oct 2024 11:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728326326; x=1728931126; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=11QEKvAHeRaYkFUPntQNQN+yM5PTuL12NROr8uGibBI=;
 b=M84dT9vv2L3W2Hly9trhakASXqZs5V1a7MBnfP+OxHQ0FY2f9GLcUvLnQiM+Kt+paK
 f/YKxWJQbQWxOIubUJnLJATCUREvsp7UGAUElZd6hSXaoDxyq7O/ANncDuGZATFxcHa0
 EsXSAcCHksfZUogYYEQwgHq7c+J2qUcY1KarhTxPEtDcdmMyGjmxoDzE/vxNF1nzXDNi
 vjYzNrs1G7Uen1zqN2/DDHZ78eTCrw2VXKkSXZ18tcChfile18KNMusKShcBmcQDvk05
 K8MxcAZ1K5Ph2nt4tJFN8m13p+DHipU+mZq5YByY46AJuoDQi4Rwzx1z2P5z9KFohAdJ
 7BfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728326326; x=1728931126;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=11QEKvAHeRaYkFUPntQNQN+yM5PTuL12NROr8uGibBI=;
 b=mnLn+hcsoHsfT2UDkDQSQPIx99/t4jDTVJt5qPcrzvQrNDOSakDIDlVw1BT5eK5zHs
 icPsogHIlwk6NOByltxr3crc3aLF8Zhe7zfwWKxNGY/6FPosaajBYnwIVSnEYBpinN3l
 aS4KRPebSnHlsPi9qULoJG4HUzb8e+i8MoxJJm8qPm12int9Nk3SKOF5iuVYm2X4GIRc
 AETcY8XxgqT7C9uT+QXvLytDescKTF7Aea60RGxKonHL+4TNaUmHldb0/JvVfCyG3hhb
 wIekt7rJhKEIcEuh90OtjZyD0JTOBcp/4K3bWHvQoUiEBNxAZtU0g4dbx8d9i+8b+X/I
 Fjbw==
X-Gm-Message-State: AOJu0YzJIR+Kv2BhdfraG//ueamqap2yPPUIpmg/hK/ozMGurOyCmx5z
 1TMeIj27Da7Y0T+PEkcvAwBJ7k1F3aW9O8NkXNQM3Aa5ZkXL654XFLKSYvjlu1wUVMBKiNrABvV
 fLZ5wcsK+KPdpwoEt3RiGGxrhLEQ=
X-Google-Smtp-Source: AGHT+IHKZ8xKFmbDqAbjmAzrOJwyRsWx8BFxGKlFawzawY9atHtn0d+VAasc2eu/ZM67LixfDrAnmVshun2uJjZGtu8=
X-Received: by 2002:a17:903:230b:b0:207:5e6d:ae4 with SMTP id
 d9443c01a7336-20bff1939d4mr78604645ad.11.1728326326485; Mon, 07 Oct 2024
 11:38:46 -0700 (PDT)
MIME-Version: 1.0
References: <20241007183241.1584-1-christian.koenig@amd.com>
In-Reply-To: <20241007183241.1584-1-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 7 Oct 2024 14:38:34 -0400
Message-ID: <CADnq5_PJ6jdyJ_e92M_P7YnSW8VyyRZrareS=wEa+TsSS3z30Q@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: always set GEM function pointer
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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

On Mon, Oct 7, 2024 at 2:33=E2=80=AFPM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Make sure to always set the GEM function pointer even for in kernel
> allocations. This fixes a NULL pointer deref caused by switching to GEM
> references.
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Fixes: fd69ef05029f ("drm/radeon: use GEM references instead of TTMs")

Acked-by: Alex Deucher <alexander.deucher@amd.com>

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
