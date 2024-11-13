Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A5BAD41C02
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2024 05:31:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF99F10E67E;
	Wed, 13 Nov 2024 05:31:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="F7j7YOlF";
	dkim-atps=neutral
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94D1210E67E
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2024 05:31:03 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-20c83c2e967so1463325ad.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2024 21:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731475863; x=1732080663; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PXYDJCryjZnBtGXecMA7nGbZ8j5wwf7t1Z/0B6GIrTs=;
 b=F7j7YOlFn7/54DjVJ4zp6b8LcFrtQHYp0JZCsmfVVk7CoMXMdWGfQgsM6/OAm7Jjpj
 /KDydDAeiupfVp2dZxapilixK7+vs/7YxPojhd07GaD16NxytUWeBgFZcKsNAxpLT9l1
 hVPVrctsccx9Ft76OzmocKwgovdkncg5YOXAW6CZO8pcGCL7pqtu87rE5g43EFfE/yEI
 UYhowgNp9DWqdiQ6tiNvBYRLd5cd+5IWUjrbnWlER7x0eWydeV6ENVpgG6I5hPII/eCi
 gtC01KEMmIFbglSxy/JLJRgRwNEwV3GpbzOgvphtrizIFu3sCg3r2GXuQHh43c1oTSNX
 5uPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731475863; x=1732080663;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PXYDJCryjZnBtGXecMA7nGbZ8j5wwf7t1Z/0B6GIrTs=;
 b=kFSlyYuAwu40iAXvYVLChmOp1AVsFcwH49c0Kfb7CeRj/iGGLzVZkM9HSZxTzCxw1m
 hUcUCc9cMd93ctX1XvZXLJR4h7cphPs1BOM7fb0ra1/xkPvlORUBbrKuKy17t4kT2Hru
 M5F7E6ll3Eq569knkArlLAWENSAB6uKcNB8xUVthumCeMCta4GravtEsmAZQ9aEQTBTJ
 MUNvCDX7yS7n6pSKzt6ReccDUx4h3GXgGsGdiSA6yYz3MVqRvlNgu+jF6NFORFVRx7hr
 YvwaZM7al/JHwvikLjaP1g8r1ESsxp5Ms1h2HCrYeyF2dgfoDMehs+sEWrfdKD4GCxF5
 5cRQ==
X-Gm-Message-State: AOJu0YyhyCjfGKik/eKf54/B7NnhuskdNgfr9YltHcs3BIX7Wu5U4yWe
 S/X739FA3nL4k19ZsdVVzOmH5JGftsKsBSRHMHy7NzbjOeEuvB17aDoDZJ/Q72i30sSd4UGCs3i
 BsXgdV9iwlr3SPiI4kmSrztcaASVelbGM
X-Google-Smtp-Source: AGHT+IEWQUOE7ei1jmJ/niGFjTU8WpzPwNNgZQ0qpq58Zv+fblQU/8K6X5PYoOoa7OrvVPurPUQpwakdG8VPINXdmyE=
X-Received: by 2002:a17:902:dacf:b0:207:14d2:ddeb with SMTP id
 d9443c01a7336-2118359ab86mr109450785ad.13.1731475862626; Tue, 12 Nov 2024
 21:31:02 -0800 (PST)
MIME-Version: 1.0
References: <20241112143050.1931822-1-jesse.zhang@amd.com>
In-Reply-To: <20241112143050.1931822-1-jesse.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 13 Nov 2024 00:30:51 -0500
Message-ID: <CADnq5_MNgbysA=FbS=_er1GhLgJRjW9hhMWZjQeR5XZiLPb=sw@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/admgpu: fix vcn sw init failed
To: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>, vitaly.prosyak@amd.com,
 Tim.Huang@amd.com
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

On Tue, Nov 12, 2024 at 9:31=E2=80=AFAM Jesse.zhang@amd.com <jesse.zhang@am=
d.com> wrote:
>
> For multiple vcn instances, to avoid creating reset sysfs multiple times,
>  add the instance paramter in reset mask init.

I think it would be better to create one sysfs file per instance.  E.g.,
vcn_reset_mask, vcn1_reset_mask, vcn2_reset_mask, etc.

Alex

>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c |  8 ++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 10 ++++------
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c |  4 ++--
>  5 files changed, 14 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vcn.c
> index 25f490ad3a85..1d4eda649845 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -1295,11 +1295,11 @@ static ssize_t amdgpu_get_vcn_reset_mask(struct d=
evice *dev,
>  static DEVICE_ATTR(vcn_reset_mask, 0444,
>                    amdgpu_get_vcn_reset_mask, NULL);
>
> -int amdgpu_vcn_sysfs_reset_mask_init(struct amdgpu_device *adev)
> +int amdgpu_vcn_sysfs_reset_mask_init(struct amdgpu_device *adev, int ins=
t)
>  {
>         int r =3D 0;
>
> -       if (adev->vcn.num_vcn_inst) {
> +       if (inst =3D=3D 0) {
>                 r =3D device_create_file(adev->dev, &dev_attr_vcn_reset_m=
ask);
>                 if (r)
>                         return r;
> @@ -1308,12 +1308,12 @@ int amdgpu_vcn_sysfs_reset_mask_init(struct amdgp=
u_device *adev)
>         return r;
>  }
>
> -void amdgpu_vcn_sysfs_reset_mask_fini(struct amdgpu_device *adev)
> +void amdgpu_vcn_sysfs_reset_mask_fini(struct amdgpu_device *adev, int in=
st)
>  {
>         int idx;
>
>         if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> -               if (adev->vcn.num_vcn_inst)
> +               if (inst =3D=3D 0)
>                         device_remove_file(adev->dev, &dev_attr_vcn_reset=
_mask);
>                 drm_dev_exit(idx);
>         }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vcn.h
> index 7ff4ae2a0432..9b10044c61a3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -519,7 +519,7 @@ int amdgpu_vcn_ras_sw_init(struct amdgpu_device *adev=
);
>  int amdgpu_vcn_psp_update_sram(struct amdgpu_device *adev, int inst_idx,
>                                enum AMDGPU_UCODE_ID ucode_id);
>  int amdgpu_vcn_save_vcpu_bo(struct amdgpu_device *adev, int inst);
> -int amdgpu_vcn_sysfs_reset_mask_init(struct amdgpu_device *adev);
> -void amdgpu_vcn_sysfs_reset_mask_fini(struct amdgpu_device *adev);
> +int amdgpu_vcn_sysfs_reset_mask_init(struct amdgpu_device *adev, int ins=
t);
> +void amdgpu_vcn_sysfs_reset_mask_fini(struct amdgpu_device *adev, int in=
st);
>
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v4_0.c
> index 59f83409d323..109b27904984 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -250,11 +250,9 @@ static int vcn_v4_0_sw_init(struct amdgpu_ip_block *=
ip_block)
>                 ip_block->ip_dump =3D ptr;
>         }
>
> -       if (inst =3D=3D 0) {
> -               r =3D amdgpu_vcn_sysfs_reset_mask_init(adev);
> -               if (r)
> -                       return r;
> -       }
> +       r =3D amdgpu_vcn_sysfs_reset_mask_init(adev, inst);
> +       if (r)
> +               return r;
>
>         return 0;
>  }
> @@ -292,7 +290,7 @@ static int vcn_v4_0_sw_fini(struct amdgpu_ip_block *i=
p_block)
>         if (r)
>                 return r;
>
> -       amdgpu_vcn_sysfs_reset_mask_fini(adev);
> +       amdgpu_vcn_sysfs_reset_mask_fini(adev, inst);
>         r =3D amdgpu_vcn_sw_fini(adev, inst);
>
>         kfree(ip_block->ip_dump);
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v4_0_3.c
> index e9b869f373c9..ef3dfd44a022 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -217,7 +217,7 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block =
*ip_block)
>                 ip_block->ip_dump =3D ptr;
>         }
>
> -       r =3D amdgpu_vcn_sysfs_reset_mask_init(adev);
> +       r =3D amdgpu_vcn_sysfs_reset_mask_init(adev, inst);
>         if (r)
>                 return r;
>
> @@ -254,7 +254,7 @@ static int vcn_v4_0_3_sw_fini(struct amdgpu_ip_block =
*ip_block)
>         if (r)
>                 return r;
>
> -       amdgpu_vcn_sysfs_reset_mask_fini(adev);
> +       amdgpu_vcn_sysfs_reset_mask_fini(adev, inst);
>         r =3D amdgpu_vcn_sw_fini(adev, inst);
>
>         kfree(ip_block->ip_dump);
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v5_0_0.c
> index 96ec01cffea3..8f9c19c68d88 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -186,7 +186,7 @@ static int vcn_v5_0_0_sw_init(struct amdgpu_ip_block =
*ip_block)
>                 ip_block->ip_dump =3D ptr;
>         }
>
> -       r =3D amdgpu_vcn_sysfs_reset_mask_init(adev);
> +       r =3D amdgpu_vcn_sysfs_reset_mask_init(adev, inst);
>         if (r)
>                 return r;
>
> @@ -223,7 +223,7 @@ static int vcn_v5_0_0_sw_fini(struct amdgpu_ip_block =
*ip_block)
>         if (r)
>                 return r;
>
> -       amdgpu_vcn_sysfs_reset_mask_fini(adev);
> +       amdgpu_vcn_sysfs_reset_mask_fini(adev, inst);
>         r =3D amdgpu_vcn_sw_fini(adev, inst);
>
>         kfree(ip_block->ip_dump);
> --
> 2.25.1
>
