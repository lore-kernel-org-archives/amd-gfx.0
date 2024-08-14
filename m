Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1822AC3DA4A
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Aug 2024 15:18:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADCCE10E4D3;
	Wed, 14 Aug 2024 15:18:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DGADpGY8";
	dkim-atps=neutral
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BAF610E4CB
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Aug 2024 15:18:01 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-1fc56fd4de1so7911595ad.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Aug 2024 08:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723648681; x=1724253481; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wVzXilXLZ2OXVUURQQMjipPjanQkmq4P6xyQ1ui41us=;
 b=DGADpGY8zVTiVuS1Y4QXSocuA9KYq6MqAOAvbZ7EpE0q0DKBW9zdBWVyZzhbA+NhOy
 dg1ZEM2x9MoWztE7yu6dL5G1g+sd5DZyDa9G2bh+jcBIwMQ+cLHbXx0O/DRXzTFvJJ+m
 rLikwqACYQVbCMHMubGnGn7LgkbTAdxWhFevF5ls6n3QqVrOt5C1GqcRgPdvAr9sDpBe
 g2vIyMp9Sqs6ti5zdC+xp/hMxeHAZA3GVZAFs0xnP0lb8jchzXuBucCbyVV3rBBfX9rn
 uSahoDemM/LdNe27iq0mPt5vXoPNtwAJYc7DJG8xhtWs/X7krKR86LP5OTffGLbRRuJD
 ox0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723648681; x=1724253481;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wVzXilXLZ2OXVUURQQMjipPjanQkmq4P6xyQ1ui41us=;
 b=jDf/3f6h6ld2t+9LAF5kBxgYYa0bhkIZUZOjtY8HdZZMqbByo1mD4qfUkTGDm0rLl1
 V3BB3FRSxHdr8Kc3IwtmuFhrbaxra8b5i1vw2AkSWKeq919M0E1DvCKgJzqGjX/YMlEm
 AOaAb4xNjTCg0VJDD+PA/kFI6EqoU3hifmiIBokPxbvcp3xMhNCU7jYpj5w9UDLizRB+
 M2jkv4OiIUdD0uHytlHVDK6TQx44NZfSkVgO2mJ4rDbr2WBjov4MOTdZwnmDwHEUNB7B
 wGyrrG5n0SCTG7co0goqc7oP5pFsO+cUTm8ZjEA3elj35+3YwbJD9J8idjENSPVKISQn
 3Ccg==
X-Gm-Message-State: AOJu0YzW5BgEf8klS9vFMquMR97X38qdqjIs7gklRhKiLePjm+bZq1AV
 VlKU5kOCs2++p2J71D0Sn5+Cno5AbL5JAWYLgkXIgSW5B9VLpzet7yYDekpahB8g5aj7QBECISr
 RrvBodJDiksBcD3KdvxADS+OEoZnYiw==
X-Google-Smtp-Source: AGHT+IGWcnq3GvFN/OxCBQnzEAkHVRQwnk1Hhwx63mlK2PpKPIn2zSx23tn16qAZ2aGeLOeFs/my43RVUKM5vrFM+0E=
X-Received: by 2002:a17:903:228d:b0:1f4:a04e:8713 with SMTP id
 d9443c01a7336-201d9a28c93mr43406275ad.28.1723648680562; Wed, 14 Aug 2024
 08:18:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240814090849.36891-1-Rahul.Jain@amd.com>
In-Reply-To: <20240814090849.36891-1-Rahul.Jain@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 14 Aug 2024 11:17:48 -0400
Message-ID: <CADnq5_NVkyrNbYkC9GfB112BSoEzow6P-=EUQJ-gjAquOCyiGA@mail.gmail.com>
Subject: Re: [PATCH v3] drm/amdgpu: Take IOMMU remapping into account for p2p
 checks
To: Rahul Jain <Rahul.Jain@amd.com>, Ramesh Errabolu <Ramesh.Errabolu@amd.com>
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

On Wed, Aug 14, 2024 at 5:15=E2=80=AFAM Rahul Jain <Rahul.Jain@amd.com> wro=
te:
>
> when trying to enable p2p the amdgpu_device_is_peer_accessible()
> checks the condition where address_mask overlaps the aper_base
> and hence returns 0, due to which the p2p disables for this platform
>
> IOMMU should remap the BAR addresses so the device can access
> them. Hence check if peer_adev is remapping DMA
>
> v3:
> - remove iommu_remap variable
>
> v2: (Alex)
> - Fix as per review comments
> - add new function amdgpu_device_check_iommu_remap to check if iommu
>   remap
>
> Signed-off-by: Rahul Jain <Rahul.Jain@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 46 +++++++++++++++++++---
>  1 file changed, 40 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index a6b8d0ba4758..040c75c491cd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3952,6 +3952,25 @@ static void amdgpu_device_check_iommu_direct_map(s=
truct amdgpu_device *adev)
>                 adev->ram_is_direct_mapped =3D true;
>  }
>
> +/**
> + * amdgpu_device_check_iommu_remap - check if iommu remaped BAR

change this to:
Check if DMA remapping is enabled.

since it's not just the BAR, all system address space accesses will be rema=
pped.

> + *
> + * @adev: amdgpu_device pointer
> + *
> + * return if IOMMU remapping bar address
> + */
> +static bool amdgpu_device_check_iommu_remap(struct amdgpu_device *adev)
> +{
> +       struct iommu_domain *domain;
> +
> +       domain =3D iommu_get_domain_for_dev(adev->dev);
> +       if (domain && (domain->type =3D=3D IOMMU_DOMAIN_DMA ||
> +               domain->type =3D=3D IOMMU_DOMAIN_DMA_FQ))
> +               return true;
> +
> +       return false;
> +}
> +
>  static const struct attribute *amdgpu_dev_attributes[] =3D {
>         &dev_attr_pcie_replay_count.attr,
>         NULL
> @@ -6127,6 +6146,8 @@ bool amdgpu_device_is_peer_accessible(struct amdgpu=
_device *adev,
>                                       struct amdgpu_device *peer_adev)
>  {
>  #ifdef CONFIG_HSA_AMD_P2P
> +       bool peer_remap =3D amdgpu_device_check_iommu_remap(peer_adev);
> +
>         uint64_t address_mask =3D peer_adev->dev->dma_mask ?
>                 ~*peer_adev->dev->dma_mask : ~((1ULL << 32) - 1);
>         resource_size_t aper_limit =3D
> @@ -6135,13 +6156,26 @@ bool amdgpu_device_is_peer_accessible(struct amdg=
pu_device *adev,
>                 !adev->gmc.xgmi.connected_to_cpu &&
>                 !(pci_p2pdma_distance(adev->pdev, peer_adev->dev, false) =
< 0);
>
> -       return pcie_p2p && p2p_access && (adev->gmc.visible_vram_size &&
> -               adev->gmc.real_vram_size =3D=3D adev->gmc.visible_vram_si=
ze &&
> -               !(adev->gmc.aper_base & address_mask ||
> -                 aper_limit & address_mask));
> -#else
> -       return false;
> +       if (peer_remap)
> +               /**

These don't need to be kerneldoc comments.  Replace /** with /*

> +                * IOMMU is remapping DMA for peer_adev so all accesses
> +                * should be within peer_adev's DMA mask
> +                */
> +               return pcie_p2p && p2p_access &&
> +                       (adev->gmc.visible_vram_size &&
> +                        adev->gmc.real_vram_size =3D=3D adev->gmc.visibl=
e_vram_size);
> +       else
> +               /**

Same here.

With those fixed, it looks good to me, but it would be good if Ramesh
took a look as well as he wrote this code originally.

Alex


> +                * No IOMMU remapping so make sure the adev's aperture
> +                * fits into peer_adev's dma mask
> +                */
> +               return pcie_p2p && p2p_access &&
> +                       (adev->gmc.visible_vram_size &&
> +                       adev->gmc.real_vram_size =3D=3D adev->gmc.visible=
_vram_size &&
> +                       !(adev->gmc.aper_base & address_mask ||
> +                       aper_limit & address_mask));
>  #endif
> +       return false;
>  }
>
>  int amdgpu_device_baco_enter(struct drm_device *dev)
> --
> 2.34.1
>
