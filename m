Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92217C52D7C
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Aug 2024 21:55:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 118A610E3E7;
	Tue, 13 Aug 2024 21:55:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="X+V5sLhN";
	dkim-atps=neutral
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C17210E3E7
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Aug 2024 21:55:50 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-200aa78d35aso30722725ad.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Aug 2024 14:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723586150; x=1724190950; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5UreK/Nu01RTdq0bsCGOGzRb3JrXysALXhL2Lv4L9tw=;
 b=X+V5sLhNul/0I1cVTp8ORE461pg8rOTaErX1sQH6TrsYVxbdIz3p4FvDfpN1TfLW8w
 2TwPAWG8HY3n2bDtLUUrMXPS12qlSaM2uh4KJZFKL8QycNQXcW/5dOdl+vmhBwNi4eqM
 xFvTLcgJLY17fdC3xeqQYGXcdqJn+upE8QN9xhqlmKExpXW43MaYRtnU527QDTfbJ3mg
 5ioBL+zTkRv8dT8WUJWBvUaDrviMeBhJSeCltfDV5zcGVQ/7+jsumj/DOMNj3yAeqK5o
 YVS0zSLz6ldoXY1rD7iuGevxBoXUg6tFNMSMCSNbqlAIo0Pea+Os/VwUTYAn4meHefH6
 Pg3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723586150; x=1724190950;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5UreK/Nu01RTdq0bsCGOGzRb3JrXysALXhL2Lv4L9tw=;
 b=caimgWBCS5ivBfgYnae5WH+QfeC7UfnVaqD3m3UhHqtLdZPNGtzuszKJX2R8aT5ZBg
 hE+3O8X4NCdAHnvCANjB4Lol1opDtUbupnR+nJGaLLRSm82xqvF64Q7nTJxAWBvPebpv
 H2xCu04Gh3GfEqkLJIUY8Bp0F6CpyiCgxJ0gpJ5lpcdCSLbuSDNcxZV1KjGPowiRHzwp
 CUKDAW4mbGBrpDZIubeHLFhWW6mGJbRMKvP9s7dqaIM0hOGljfE49RmVz0ZtfBoKjVDa
 7Q4hWFrmRtlaaqbWxSNqJggJpJS0luwuKosX05am51RAiQhU6v3l3SX2tq/SA0i1rZPI
 Dw+Q==
X-Gm-Message-State: AOJu0YwXNjtTf2yVEE3+pAMdz6HWSX8K/5q1GLPRC1O2FlCTT2iY9Cg/
 dDefoZN3ioQWVqNetAyIH6FaT1xy7OZykAxf5aDpZCyVVtpWrn2vESks/j3XQNd8L9zd/T30GHe
 rUTZelSnhVMaJBKw3gvyBG3E8QBNOVWEb
X-Google-Smtp-Source: AGHT+IHErTP1CeJu+FlBT8yDAaQsOTIo2wfAKI2oO/ct0FjLBG8cpTe0F++kTLax4QGZJsBw8NqYYlPJOHxM9iXFexM=
X-Received: by 2002:a17:902:cf0d:b0:201:d945:4299 with SMTP id
 d9443c01a7336-201d945451bmr2583755ad.21.1723586149444; Tue, 13 Aug 2024
 14:55:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240813133854.21144-1-Rahul.Jain@amd.com>
In-Reply-To: <20240813133854.21144-1-Rahul.Jain@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 13 Aug 2024 17:55:37 -0400
Message-ID: <CADnq5_PZ0hOb+S9Zrukv2RP-LN+H7sxk=zoDGVPK_UsUAr7Ofg@mail.gmail.com>
Subject: Re: [PATCH v1] drm/amdgpu: Take IOMMU remapping into account for p2p
 checks
To: Rahul Jain <Rahul.Jain@amd.com>
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

On Tue, Aug 13, 2024 at 9:39=E2=80=AFAM Rahul Jain <Rahul.Jain@amd.com> wro=
te:
>
> when trying to enable p2p the amdgpu_device_is_peer_accessible()
> checks the condition where address_mask overlaps the aper_base
> and hence returns 0, due to which the p2p disables for this platform
>
> IOMMU should remap the BAR addresses so the device can access
> them. Hence check if iommu_remap and return true.
>
> Signed-off-by: Rahul Jain <Rahul.Jain@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 30 +++++++++++++++++-----
>  2 files changed, 26 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index f3980b40f2ce..618b44f5df85 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1138,6 +1138,8 @@ struct amdgpu_device {
>
>         bool                            ram_is_direct_mapped;
>
> +       bool                            iommu_remap;
> +
>         struct list_head                ras_list;
>
>         struct ip_discovery_top         *ip_top;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index a6b8d0ba4758..927b076aa952 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3950,6 +3950,9 @@ static void amdgpu_device_check_iommu_direct_map(st=
ruct amdgpu_device *adev)

We may want to rename amdgpu_device_check_iommu_direct_map() to
amdgpu_device_check_iommu() since we are getting several pieces of
data now.

>         domain =3D iommu_get_domain_for_dev(adev->dev);
>         if (!domain || domain->type =3D=3D IOMMU_DOMAIN_IDENTITY)
>                 adev->ram_is_direct_mapped =3D true;
> +
> +       if (!domain || domain->type !=3D IOMMU_DOMAIN_IDENTITY)
> +               adev->iommu_remap =3D true;

This is wrong, it should be:
if (domain && (domain->type =3D=3D IOMMU_DOMAIN_DMA || domain->type =3D=3D
IOMMU_DOMAIN_DMA_FQ))

>  }
>
>  static const struct attribute *amdgpu_dev_attributes[] =3D {
> @@ -6127,6 +6130,19 @@ bool amdgpu_device_is_peer_accessible(struct amdgp=
u_device *adev,
>                                       struct amdgpu_device *peer_adev)
>  {
>  #ifdef CONFIG_HSA_AMD_P2P
> +       /**
> +        * There are chances when we are in amdgpu_device_init
> +        * and either of adev have not called amdgpu_device_check_iommu_d=
irect_map,
> +        * Hence check if iommu_remap is available or not.
> +        */
> +       if (!adev->iommu_remap)
> +               amdgpu_device_check_iommu_direct_map(adev);
> +       if (!peer_adev->iommu_remap)
> +               amdgpu_device_check_iommu_direct_map(peer_adev);

This is ugly.  We should fix this up so we guarantee that
amdgpu_device_check_iommu_direct_map() has been called by this point
or just check this explicitly everywhere rather than caching it in the
adev structure.

> +
> +       bool remap =3D adev->iommu_remap;
> +       bool peer_remap =3D peer_adev->iommu_remap;

Need to declare variables before code.  Also this function looks at
whether peer_adev can access adev via DMA, so we only need to look at
peer_adev for DMA remapping.

> +
>         uint64_t address_mask =3D peer_adev->dev->dma_mask ?
>                 ~*peer_adev->dev->dma_mask : ~((1ULL << 32) - 1);
>         resource_size_t aper_limit =3D
> @@ -6135,13 +6151,15 @@ bool amdgpu_device_is_peer_accessible(struct amdg=
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
> +       if (remap && peer_remap)
> +               return pcie_p2p && p2p_access;
> +       else
> +               return pcie_p2p && p2p_access && (adev->gmc.visible_vram_=
size &&
> +                       adev->gmc.real_vram_size =3D=3D adev->gmc.visible=
_vram_size &&
> +                       !(adev->gmc.aper_base & address_mask ||
> +                       aper_limit & address_mask));
>  #endif
> +       return false;

This needs to be fixed up:

if (peer_remap)
               /* IOMMU is remapping DMA for peer_adev so all accesses
should be within peer_adev's DMA mask */
               return pcie_p2p && p2p_access && (adev->gmc.visible_vram_siz=
e &&
                       adev->gmc.real_vram_size =3D=3D adev->gmc.visible_vr=
am_size);
else
               /* No IOMMU remapping so make sure the adev's aperture
fits into peer_adev's dma mask */
               return pcie_p2p && p2p_access && (adev->gmc.visible_vram_siz=
e &&
                       adev->gmc.real_vram_size =3D=3D
adev->gmc.visible_vram_size &&
                       !(adev->gmc.aper_base & address_mask ||
                       aper_limit & address_mask));

Alex

>  }
>
>  int amdgpu_device_baco_enter(struct drm_device *dev)
> --
> 2.34.1
>
