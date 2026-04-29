Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDF79FF8867
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2026 13:12:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D49F10E233;
	Wed, 29 Apr 2026 13:12:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kXSQF8Iv";
	dkim-atps=neutral
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED5F710E233
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Apr 2026 13:12:38 +0000 (UTC)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-2d935b4b15aso743679eec.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Apr 2026 06:12:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777468358; cv=none;
 d=google.com; s=arc-20240605;
 b=PIdfn2ns4C1xuK9ZuPdjO8e9NohfGMZbhBZf53IniYb2szlhcUqRKLgxRmtcRz0IEV
 nERY+HywCHRZJDQNY/4EYtBR13bVK+seZFdup0qo/zAXIjfdgUCUQ00Ae7z2kJWe7LI/
 9kl06BvosPfQuUGHRoaizsJk6aLTmLi4Y4C85EQTx9OFoZsLxxUDNLCopX8x2C7Zea2I
 e5Hk3UCCI5eH1ghiAp7qkfEzt6NBiQJi2iF1dEzVcuH7Sa9qKmLkIVcdpQ+Gy56c4QF8
 n1KyDdOKbXPSCNvVjPbp3JV02L2Fe6V57Z2QhBAhCa6qfGnCIulihgDDehHqgQxmEOO7
 8Bfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ALnrd3bX3x8lnMlEgtUxXTuL/tkwVbMlHZPPe8kg6w4=;
 fh=tHaW2Dnoj02vwIx2N49MV9LA78qZTpeHLM8fBIf8vts=;
 b=EcB+pfuGIB8mnpl11/FYVw/H+Vqwa6EuDfIFbiWG0ntBWYbjoFLHGHH1BuGKPzPHKE
 dZi7w+nh0FV1CitO9u2TkFbqENRzjtPQQhu7p/I1mIET9Oa69j0Toyy2cJ1JaFD4Wejc
 KWBFJBsYXOsLEaJ54jNm8KSW41t8q2rGImBt0S7q54goQxYM/yhBbFQ4ndpXVnW66IxE
 YY7Or5PU4xEAOf18TG+soFLlxP0JngJ4QhgV6SCQT8W5QepKlvAbosOjq14nfhncyOvP
 wAZI9dBI7WX9WVpqt165/mZgeUErvTw9PpCxG4lO6RIufrfv9n87r87N7GxjhPqnsUpV
 w6Ag==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777468358; x=1778073158; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ALnrd3bX3x8lnMlEgtUxXTuL/tkwVbMlHZPPe8kg6w4=;
 b=kXSQF8Ivgmsxe5TqwCeLE6v5G8r2IARLQX80xrSaSxAOdXzXZy3ok2uEdVBveeGC2j
 jdQWBln7roJGZwHHvsGxZ8gexhPJ6DCnqOefgUWTDjuFz7RYeqadbkZSnvW8Fghn5pUh
 zhmONAqsKRs4oN+ePFB9evExEiArF1Hg1wDBdL5Ti2vMzMZiISHKOmT0+DzQRgzb0Rdb
 A6DeScbtBAgR/KmRI3cC3QdnpqsoTjarpQ21nJNm0fScJx5nD1Mdl27Kn+2zC4wYqg4G
 RaXUBZxd2tC2MmJiD7AnhOGnnSve1Vxr4fUgYEgKThZJv7KYzbPIYoRFy9toP0BuRmGk
 gbLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777468358; x=1778073158;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ALnrd3bX3x8lnMlEgtUxXTuL/tkwVbMlHZPPe8kg6w4=;
 b=cMwpOhT9lHSjV2SWc5mWtJo4Ug8cSxBNIArGkefF2PmjFDUnmqhZB+i/QIm2gdvVMW
 /5ApF0D4J9nkNW58/fajGAqYy27599wbNUrtO7GHWdxpC2JaG/DYxbgJkiGi1NEA/UwI
 VizY2Ld47ECGqFpWEORixQ0XKTjdbGvfOAFHj4W2qAUJoFo8koWHzdKTkbFRIgri+ys5
 ZKRkwdJcfSxMO1Ssj4KJLIoS/KS4kp1kB0b6p3iM0BaCdopsLFcxt/8ZXdcHsIuf/d+s
 Hcj9ozVZTYZWxH8LyVWlHczDJ8xzRsfYwWktGhTOuFswjhAw0WpOO7vwYfKH3GrjN2fA
 kRgA==
X-Gm-Message-State: AOJu0Yx74abPHXGENb0OnV/uzkMfDFvHtQTQLszp/yi4mhXVAQBolQcj
 DJQSKM5926bGi17ycwRewUTMs25cM4dyK1ci6A8xdl7LSYqtYkh+MJCeLROJLQ56RjJtdumGgTn
 gCaNa0Ih/uEExSOYMLLBSxQkYjvbq5Yw=
X-Gm-Gg: AeBDiet6g5nIEysEQFA2xY2Tv/QS6KVaR/C2gCGbPlQ44pOXx/Y5CPLLVuy37PZVDAS
 HUqVgnhRym8gUcZI+ELYASs+YvPXYb5Rp/P1qF/MK25zHER96OoD44BaJNG8gV0co7nm+GSqTQi
 Rf7XmPtIwTpxRFnEyjcenTSqSiO6BcUNtL1IZ/4rL6W0fdka+LXRfqIz3MzS6fiqFYzhKMh95Dk
 iSPw3/lAG2c3q2q+ST9W4xGMYbH/Rj4hjm9Tb7TGSC5wROpbGPXW8K3Yo7F3XyJquRkVntLb8JH
 PiLr7T91mgoprJoSIUiFgoxz93/v4wuIB3zZXtwPdthmRd7+RTjZdDwZ/GUaDyXO0fnuxCwEc83
 k3LaQ
X-Received: by 2002:a05:7022:e1e:b0:12c:888b:aaab with SMTP id
 a92af1059eb24-12ddd46c3ecmr1486268c88.0.1777468357925; Wed, 29 Apr 2026
 06:12:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260428215618.3596608-1-Harish.Kasiviswanathan@amd.com>
In-Reply-To: <20260428215618.3596608-1-Harish.Kasiviswanathan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 29 Apr 2026 09:12:26 -0400
X-Gm-Features: AVHnY4JlwCpYVKwLI0I0UdxQA_Om1_BEgkvKjYlQvV6PCTEwQeT-MIGlhFF-Osg
Message-ID: <CADnq5_O+VZ1E37Rvg-7=k7WPnKmAyzrAYZHvHvhWn0tOUszFmw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: amdgpu_device_is_peer_accessible to support
 all BARs
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

On Tue, Apr 28, 2026 at 6:04=E2=80=AFPM Harish Kasiviswanathan
<Harish.Kasiviswanathan@amd.com> wrote:
>
> amdgpu_device_is_peer_accessible was initially written to check peer
> VRAM access, however, it is getting called for DOORBELL & MMIO range.
> Add support for these also
>
> Change-Id: I0ec4d85ad505e0a1369e2d4d9fb6421664df41a1
> Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  3 +-
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 15 +++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 71 +++++++++++++++----
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c     |  2 +-
>  4 files changed, 72 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 39894e38fee4..d41d608d03b5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1442,7 +1442,8 @@ bool amdgpu_device_supports_smart_shift(struct amdg=
pu_device *adev);
>  int amdgpu_device_supports_baco(struct amdgpu_device *adev);
>  void amdgpu_device_detect_runtime_pm_mode(struct amdgpu_device *adev);
>  bool amdgpu_device_is_peer_accessible(struct amdgpu_device *adev,
> -                                     struct amdgpu_device *peer_adev);
> +                                     struct amdgpu_device *peer_adev,
> +                                     int pcie_bar);
>  int amdgpu_device_baco_enter(struct amdgpu_device *adev);
>  int amdgpu_device_baco_exit(struct amdgpu_device *adev);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 7c01492e69dd..e5e3f437ad3f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -900,8 +900,19 @@ static int kfd_mem_attach(struct amdgpu_device *adev=
, struct kgd_mem *mem,
>              (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP))) {
>                 if (mem->domain =3D=3D AMDGPU_GEM_DOMAIN_VRAM)
>                         same_hive =3D amdgpu_xgmi_same_hive(adev, bo_adev=
);
> -               if (!same_hive && !amdgpu_device_is_peer_accessible(bo_ad=
ev, adev))
> -                       return -EINVAL;
> +               if (!same_hive) {
> +                       int bar;
> +
> +                       if (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_DO=
ORBELL)
> +                               bar =3D 2;
> +                       else if (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLA=
GS_MMIO_REMAP)
> +                               bar =3D 5;
> +                       else
> +                               bar =3D 0;

Can you use an enum for the bar values rather than magic numbers?
That will make it more clear what the caller is specifying.

Alex

> +
> +                       if (!amdgpu_device_is_peer_accessible(bo_adev, ad=
ev, bar))
> +                               return -EINVAL;
> +               }
>         }
>
>         for (i =3D 0; i <=3D is_aql; i++) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 073f632f295a..65709a2c53be 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -6177,36 +6177,77 @@ static void amdgpu_device_get_pcie_info(struct am=
dgpu_device *adev)
>   *
>   * @adev: amdgpu_device pointer
>   * @peer_adev: amdgpu_device pointer for peer device trying to access @a=
dev
> + * @pcie_bar: PCIe BAR index to check accessibility for:
> + *            0 =3D VRAM aperture (BAR 0)
> + *            2 =3D Doorbell aperture (BAR 2)
> + *            5 =3D MMIO remap aperture (BAR 5)
> + *
> + * Return true if @peer_adev can access (DMA) @adev through the specifie=
d
> + * PCIe BAR. For VRAM (BAR 0), @adev must be "large BAR" and the BAR mus=
t
> + * match the DMA mask of @peer_adev. For doorbell and MMIO BARs, only th=
e
> + * DMA addressability and P2P chipset support are checked.
> + *
> + * @note: CONFIG_HSA_AMD_P2P indicates support for P2P DMA mappings. Que=
ry
> + * P2PDMA distance only if the kernel has all the prerequisites for P2P =
DMA
> + * support. Otherwise fall back to the less reliable legacy P2P support =
to
> + * avoid regressions.
>   *
> - * Return true if @peer_adev can access (DMA) @adev through the PCIe
> - * BAR, i.e. @adev is "large BAR" and the BAR matches the DMA mask of
> - * @peer_adev.
>   */
>  bool amdgpu_device_is_peer_accessible(struct amdgpu_device *adev,
> -                                     struct amdgpu_device *peer_adev)
> +                                     struct amdgpu_device *peer_adev,
> +                                     int pcie_bar)
>  {
>  #ifdef CONFIG_HSA_AMD_P2P
> -       bool p2p_access =3D
> -               !adev->gmc.xgmi.connected_to_cpu &&
> +       bool p2p_access =3D true;
> +       bool p2p_addressable =3D false;
> +       resource_size_t bar_base, bar_size;
> +
> +       /* VRAM requires large BAR (full VRAM visible) for P2P access */
> +       if (pcie_bar =3D=3D 0) {
> +               if (!adev->gmc.visible_vram_size ||
> +                   adev->gmc.real_vram_size !=3D adev->gmc.visible_vram_=
size)
> +                       return false;
> +
> +               /* VRAM on CPU-connected xGMI devices is accessed via
> +                * coherent fabric, not PCIe BAR P2P
> +                */
> +               if (adev->gmc.xgmi.connected_to_cpu)
> +                       return false;
> +       }
> +
> +       switch (pcie_bar) {
> +       case 2:
> +               bar_base =3D adev->doorbell.base;
> +               bar_size =3D adev->doorbell.size;
> +               break;
> +       case 5:
> +               bar_base =3D adev->rmmio_base;
> +               bar_size =3D adev->rmmio_size;
> +               break;
> +       case 0:
> +       default:
> +               bar_base =3D adev->gmc.aper_base;
> +               bar_size =3D adev->gmc.aper_size;
> +               break;
> +       }
> +
> +       p2p_access =3D
>                 !(pci_p2pdma_distance(adev->pdev, peer_adev->dev, false) =
< 0);
>         if (!p2p_access)
>                 dev_info(adev->dev, "PCIe P2P access from peer device %s =
is not supported by the chipset\n",
>                         pci_name(peer_adev->pdev));
> -
> -       bool is_large_bar =3D adev->gmc.visible_vram_size &&
> -               adev->gmc.real_vram_size =3D=3D adev->gmc.visible_vram_si=
ze;
> -       bool p2p_addressable =3D amdgpu_device_check_iommu_remap(peer_ade=
v);
> +       p2p_addressable =3D amdgpu_device_check_iommu_remap(peer_adev);
>
>         if (!p2p_addressable) {
>                 uint64_t address_mask =3D peer_adev->dev->dma_mask ?
>                         ~*peer_adev->dev->dma_mask : ~((1ULL << 32) - 1);
> -               resource_size_t aper_limit =3D
> -                       adev->gmc.aper_base + adev->gmc.aper_size - 1;
> +               resource_size_t bar_limit =3D bar_base + bar_size - 1;
>
> -               p2p_addressable =3D !(adev->gmc.aper_base & address_mask =
||
> -                                    aper_limit & address_mask);
> +               p2p_addressable =3D !(bar_base & address_mask ||
> +                                    bar_limit & address_mask);
>         }
> -       return pcie_p2p && is_large_bar && p2p_access && p2p_addressable;
> +
> +       return p2p_access && p2p_addressable;
>  #else
>         return false;
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/=
amd/amdkfd/kfd_topology.c
> index 4dc9f9aa3a2e..24fb565fa53c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -1496,7 +1496,7 @@ static int kfd_add_peer_prop(struct kfd_topology_de=
vice *kdev,
>
>         if (!amdgpu_device_is_peer_accessible(
>                                 kdev->gpu->adev,
> -                               peer->gpu->adev))
> +                               peer->gpu->adev, 0))
>                 return ret;
>
>         if (list_empty(&kdev->io_link_props))
> --
> 2.43.0
>
