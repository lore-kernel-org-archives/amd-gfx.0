Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59AE6C5472F
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Aug 2024 13:08:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0301D10E31D;
	Tue, 27 Aug 2024 13:08:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hAgjGQZ7";
	dkim-atps=neutral
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 244CF10E321
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Aug 2024 13:08:04 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-20212f701c9so3694875ad.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Aug 2024 06:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724764083; x=1725368883; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h8XbnTR1gey+PX6ExhNKwSzrqFokefS9pLGe1Lc91bY=;
 b=hAgjGQZ7epbZukSkhdd59wNV8+Il4jHovLSmAsoSsMh7Vgpc0CEjbd/MULd4URXDRz
 JVl/7BfkFEaTxdiW5x9KGBerZ55d0EicmzsW5ZoXOstpsUSgQD2RH4PHffFbuzC1mHdT
 SKmbIHSc+WrhhCKed6luheEYM9UmVmnD1/PchrsV2ycPrOrDk2eR6ORZJedZQ4ZOt+zF
 mrrAwJMDVLlfh1YOT5+jT/2YaH/D6YlGDBwgvDFA9sr2fZE9uFPPBTKz3azjVI3E+ZJu
 VR52qFuIJwJtEi6UMidYyMXzAWXGfGVBBm9L/fzSDSy+a4Mv7z0SY/rSLeiG/jRJJRca
 Nokg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724764083; x=1725368883;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h8XbnTR1gey+PX6ExhNKwSzrqFokefS9pLGe1Lc91bY=;
 b=rP9dLeF1Px7cxFZ5ej6mt35B7yusS2iXm0rhwBu9T0W0VGgQ5O8b2OKQ5IpcBTbCGu
 cG49bAxpM8sGDOsTFEuntE6KlItWIA/JjxJSGqWIS52pQIG36O0Pg4r/UnnDgoc1BwYV
 JzooTACEuT+11ohGzZ0D/zDB7KfK3uRSp7rqnDDNz1FKeMhbPrSLw9i4KSIc0+B2d3TU
 UMn2RAPyhwTVDJHxYRRW/nsfmfNGobGiyqe3QiAetvSnMMtr5hfviNDoFY9S0HezP/I1
 T8mXlBa6vBYNUhmbt2E4XM2RPTcuN0VjRXIlWwuHpiXnvFugFR5NvsHAslOPxjylGQOY
 fVmw==
X-Gm-Message-State: AOJu0Yx+8ucfbUBfkLYDTtuQf5PxCmlD/4PLoOjkFujXlUbCh/gElT6s
 DLb+L1uMAkXoLLwzefr+Q88/jpQFwtVrro8CCs0QcEtkT+igqRQ/lQGvF9myzTjcjQGj9alsndY
 PWyJhwjfiH3UOa0uwtARgyEM0tt4=
X-Google-Smtp-Source: AGHT+IFmrRJPuZ8MdXOVE4HwPSsIachGzQGTG6CGlZ5Agt0P/T1OsTSewqooHQNBmVh4PDEzteeVUk7tm0XzLV7Vrm8=
X-Received: by 2002:a17:902:f551:b0:1fb:a38b:c5b6 with SMTP id
 d9443c01a7336-2039e43a895mr93861885ad.1.1724764083267; Tue, 27 Aug 2024
 06:08:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240827072600.60239-1-yifan1.zhang@amd.com>
In-Reply-To: <20240827072600.60239-1-yifan1.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 27 Aug 2024 09:07:51 -0400
Message-ID: <CADnq5_OiakRUpXvdXaKF4CXwLeep=a5jNH0kGQ8hpNM0weL-Qw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: Don't drain ih1 for APU
To: Yifan Zhang <yifan1.zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Felix.Kuehling@amd.com, Philip.Yang@amd.com,
 xiaogang.chen@amd.com
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

On Tue, Aug 27, 2024 at 3:26=E2=80=AFAM Yifan Zhang <yifan1.zhang@amd.com> =
wrote:
>
> ih1 is not initialized for APUs. Don't drain it or NULL pointer
> error will be triggered.
>
> Fixes: 490fc21fe97c (drm/amdkfd: Change kfd/svm page fault drain handling=
)
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/a=
mdkfd/kfd_svm.c
> index b44dec90969f..1d08978955c7 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -2458,11 +2458,13 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, st=
ruct svm_range *prange,
>                 adev =3D pdd->dev->adev;
>
>                 /* Check and drain ih1 ring if cam not available */
> -               ih =3D &adev->irq.ih1;
> -               checkpoint_wptr =3D amdgpu_ih_get_wptr(adev, ih);
> -               if (ih->rptr !=3D checkpoint_wptr) {
> -                       svms->checkpoint_ts[i] =3D amdgpu_ih_decode_iv_ts=
(adev, ih, checkpoint_wptr, -1);
> -                       continue;
> +               if (!(adev->flags & AMD_IS_APU)) {

Would be better to check if the ih1 ring is valid rather than checking
for APUs.  E.g.,

if (adev->irq.ih1.ring_size)

Alex

> +                       ih =3D &adev->irq.ih1;
> +                       checkpoint_wptr =3D amdgpu_ih_get_wptr(adev, ih);
> +                       if (ih->rptr !=3D checkpoint_wptr) {
> +                               svms->checkpoint_ts[i] =3D amdgpu_ih_deco=
de_iv_ts(adev, ih, checkpoint_wptr, -1);
> +                               continue;
> +                       }
>                 }
>
>                 /* check if dev->irq.ih_soft is not empty */
> --
> 2.37.3
>
