Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75BAAC28B20
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Mar 2025 19:12:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8674410E14C;
	Fri, 28 Mar 2025 19:12:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="STTu5pm/";
	dkim-atps=neutral
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC23F10E14C
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Mar 2025 19:12:21 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-301b4f97cc1so597913a91.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Mar 2025 12:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743189141; x=1743793941; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L6M+jEfRxi9aOF05qt7QPWvhA2JfC+UvAQEiXq8eBmY=;
 b=STTu5pm/lMser4plCp8hglwQnL3ahcCAvnyTyCTt/YbbFJDgTQBK4cNE31b9st8DG+
 vYXn7RIjrZKVv/pcQh3CoCHSZ1dt7WocKSYHl0oQ73R1+hsxQowEZEQhAwqLIhuSpT5i
 hvZgHX5XV0K03dBWl5FaetBiS3diP4ri/3lYkeXq4luZ2+B2ern7kfDRKAHEmoCYmMlH
 V9DHuFVNHyRU9IaGa8rYfNSN0vxPNQcJsPMC+Thz7vubxncmvH5u7uIrViUOsGym1lL8
 oI6RMyKqL+rdWJ8g3KaV/ovHaU+xLWIKMbNMmXBckWpgeEHAxysSUSs5BHZJc0EBonn+
 ODow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743189141; x=1743793941;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L6M+jEfRxi9aOF05qt7QPWvhA2JfC+UvAQEiXq8eBmY=;
 b=aUmRspkmZRSxKiVXcqAcvwNupwLT2dSxiyWQ2j9rnawYwANepS0iBTiM4BiSXvhI7D
 uB/hyW41vJxRbywAzO2KQn6zt59j/hpJzp8WR9eXlQ4TLBcdK/GqrRZGxQqUx7DA2wNk
 /3DJ46HNuAMKfaCI0/2NsV5JoNhrsf9bsD6EBAzwy6AQVB6b0XWI0SM2XozVGNQxELWw
 p67pGV4tH+6sHjohwzSWl+v5/QiEkqYdZjpeREdSkoqXxTBJg/QskEEaXUAprHXC8poT
 hWU+Ekzdu+WHIl26I0ijru7reecDnSNLKcMWjrbU3x5HGzuTYpwkK+TTF62qAUXqTZsO
 Fyvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUILHy34xVAQvHLdrRQ+ii9llQraBP7bzAGdZA16PLJaUj3dr7J0/Q89v/NPeAas02DA355+jgf@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz12eMUsCCphNV1eiKq/Qy0FdyJ//71VZP/tuXtQb9rp8VYucoK
 5drBMSPCZLmFZB9veHcck3dmSYUVNMFFfWZQ+DcMp1/5OJ60FEG+lAn/VGWyaYy1cyss5ceSoXE
 W2MSFJfA3FwbwcE6+sx1dur4yPnY=
X-Gm-Gg: ASbGnctxSMzW7O0aKuqARDJvGZOcLgDPC+H1u8n4TMYIiT+6UowHWdiuktEF2pAMV94
 TeJmAUDMVg+c/5d7udo2kJR84FaqplQLwIJ5LcmnXegObk77LEv74a8He6XWCEA7/DgFGMX/N3U
 BTykQmiNYu+N87Eb8vyO0OEE/pVA==
X-Google-Smtp-Source: AGHT+IG3E0KwPlFqdc+6OA/t6nErt2ZWXFmSlj0ZCEdi+9hNHixdAZsfUN1tk9pijeMOwdU6GZDqGsi0dZ1hIk3UxMY=
X-Received: by 2002:a17:90b:1a8f:b0:2fe:b45b:e7ec with SMTP id
 98e67ed59e1d1-305321652a1mr179219a91.8.1743189141208; Fri, 28 Mar 2025
 12:12:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250327195400.130758-1-natalie.vock@gmx.de>
 <95e48cb3-2b9c-46ea-85e4-7ce730dbb816@amd.com>
In-Reply-To: <95e48cb3-2b9c-46ea-85e4-7ce730dbb816@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 28 Mar 2025 15:12:08 -0400
X-Gm-Features: AQ5f1JqdylneLmvN725lmI7L6zeowNUw3izszfXWUH2qCVc4XWLzHfT6nThu33Y
Message-ID: <CADnq5_Mohzo-yF_+o+Jf9AHOLQfQv-zzt3fd6zYKFtjpEfFp0A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Add cgroups implementation
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Natalie Vock <natalie.vock@gmx.de>, amd-gfx@lists.freedesktop.org, 
 Maarten Lankhorst <dev@lankhorst.se>, Maxime Ripard <mripard@kernel.org>
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

Applied.  Thanks!

Alex

On Fri, Mar 28, 2025 at 9:03=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 27.03.25 um 20:51 schrieb Natalie Vock:
> > From: Maarten Lankhorst <dev@lankhorst.se>
> >
> > Similar to xe, enable some simple management of VRAM only.
> >
> > Co-developed-by: Maxime Ripard <mripard@kernel.org>
> > Signed-off-by: Maxime Ripard <mripard@kernel.org>
> > Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> > ---
> >
> > Resending this one since it got lost in the initial dmem cgroup
> > submission. Probably needs to be merged through drm-misc-next since
> > amd-staging-drm-next doesn't have dmem cgroups yet.
> >
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_vram_mgr.c
> > index ff5e52025266c..7b86d7f9d5d56 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> > @@ -24,6 +24,7 @@
> >
> >  #include <linux/dma-mapping.h>
> >  #include <drm/ttm/ttm_range_manager.h>
> > +#include <drm/drm_drv.h>
> >
> >  #include "amdgpu.h"
> >  #include "amdgpu_vm.h"
> > @@ -908,6 +909,9 @@ int amdgpu_vram_mgr_init(struct amdgpu_device *adev=
)
> >       struct ttm_resource_manager *man =3D &mgr->manager;
> >       int err;
> >
> > +     man->cg =3D drmm_cgroup_register_region(adev_to_drm(adev), "vram"=
, adev->gmc.real_vram_size);
> > +     if (IS_ERR(man->cg))
> > +             return PTR_ERR(man->cg);
> >       ttm_resource_manager_init(man, &adev->mman.bdev,
> >                                 adev->gmc.real_vram_size);
> >
> >
> > base-commit: 1822532477cb5f007313de4c70079c09aaa270d5
> > --
> > 2.49.0
> >
>
