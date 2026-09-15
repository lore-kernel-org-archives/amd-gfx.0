Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F8F9C88E75
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2026 17:29:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A337F10E600;
	Tue, 15 Sep 2026 17:29:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OjuvZTnh";
	dkim-atps=neutral
Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com
 [74.125.227.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E536510E600
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 17:29:47 +0000 (UTC)
Received: by mail-vs2-f12.google.com with SMTP id
 ada2fe7eead31-78a2363d4aaso158178137.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 10:29:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789493386; cv=none;
 d=google.com; s=arc-20260327;
 b=boFjAjDX2JIxp63uebqzKFoz5n5HYyRRlCwO84Yg0shPOlVyhOC0P62yeDCYbZe9yi
 FJ9jpXCjsbKnqdokcvkWe5UHtPSHn4DkYZvMrJayu+fq0rG+gBeWhMgqzWtQypsWaj2P
 ZoUaoafjctJbTuK8V3OJn1mkOC3ypyK6c9HfU6XRGJpc9RkTEZsSWMrdvi2OJ5p1mkGn
 0O4QLWxLwOpYwkQGrSmkIg8RJKU57jlrKzo1gT3NC4xUdT/f03a7g+853dqsgmljQ365
 g53WbtuiW/Nd27+9mdNL0qyiBUij6qV3xLnAAG2rn6aAMGDLoQmPvaTyrV/PXD9DiePp
 3ACw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PRIZ0SbJpIKYCW1C7yb08vaQ3wYoz2PXRv2Ia1mtPl0=;
 fh=jo4jpBq/De51/qbDPyzrotNGkAC6XcnI9ZRhvfov3F4=;
 b=BkV7kgMJf8F906hou4lCwSdgsXF/M1kD/pyEtifgUZDmVaJik8P/ry9bicbA1EU3Rs
 CZviYcriNIPe7qaIcnNIvK8gNyv8psq8cLZpoLRfy0bMvNU/30jlBPy0J5I6qj/ZFSqC
 9CfsGdF8jBHZTBZkan1fiZTUPc/w15dZWyJKZdjDMGU8NZxsE3IR2OQZHbN5karcw4Dd
 ISM52/k7a5y4SXxOW11vR12vlA7JeD1W0O3w4S2QX8iTRHATZrwvgvW8TXnDVDeCkmjw
 sqUMP1MQPNjB5cN9w60i4NuOSJk0CW/WvZrRqGGxaxHDwdEZP5TRR5nYlhLcDraCX/Xc
 ay/g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789493386; x=1790098186; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PRIZ0SbJpIKYCW1C7yb08vaQ3wYoz2PXRv2Ia1mtPl0=;
 b=OjuvZTnhpR6TVoJd4MzJuAkvQh4Daz6gA5FoZIQ8bih/fyevjBV03v1i/uk+QT/tLk
 gbjxbAe/L/+mu6LVSFfMcdzFcJtUhoGRUpHMVfxxTX/1nTI61U5cZg2LGH83tuRmNQdn
 AIUGewX3MxLGokDlK+t2dCna4C1Xd25s8hynhO+bJFifj8Dmna9kmwgTyoPn4D484CJl
 55WG41DXdZldGnVHIAkdtU3Ip2QRvq2gmrJ8XBV6c+P9CRFEqXLQawtn0OBN2mgtbX4r
 9k1ZJCap5zegp9o+UMznM0Wyc93F0lXYbzlOSmHYafNjcCCoRG9W1wvK3KAcALEWC4jn
 bF5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789493386; x=1790098186;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PRIZ0SbJpIKYCW1C7yb08vaQ3wYoz2PXRv2Ia1mtPl0=;
 b=1Gw7xhiJaZ1JIaqlwkdzockGz42RSh+nw/EBhmPpdrLteUa3lsl9TXYHgA+klASxDo
 0g/uVtcvCug3uSy4nCxfSd2VztiXp0vC2tuwGpdCPSlJhH86CbamzOWQbONg4M+zrtXg
 a4Qmvo7z/4Vudq8nebljfPo3KKtrimOyNen8qxbYxofG2W9oD/3aKVRbkbPigkUbwlhd
 0r8wUvs8emJKDSfRRBtAU/feYhqxPWOZ9gneFg2Zk0VkjXuvwBGL28KzzJm2KxkRmW4T
 HM0m41iI+56YtvqaGFrDBJz61p35UAIkA+l+oJhkJDG7JuLoNJOQd6H4hwdE6z7/rjdc
 cNqQ==
X-Gm-Message-State: AFuF++kSgdK7Us9Kg/CrbGYAIWofihYchjyt/OwvRv6K7sjDoQf8C1k1
 nv8GQx16Y/pjZlxmrere31Zon/V3iNGlROfXf+XarSJex+wooSB5haZhTohPgjRIQhGFDhbDrPc
 1EskIP19ch4Zh4OJPscNsZvMWRIueRDU=
X-Gm-Gg: AYBFou0VohElg7BPim+Y8dvaJHd6w9MaXC70BHKneeW6xVhZCDzCm8oZd8niivc62t3
 Y44GDlJvRFLzNk9o/i4qFHkRQOD2Nk8UToMZ07RkoGPHRymx1DfsmbqgQcayjHK0YrDN0701mGM
 ZUXWQKoVHmjIZoK6jvNdFY+ulZNm8/Kbyv7F/a3LR2u67ygjacBqNjqz8VT+cUdJ2sjkhpUqVCL
 rxywu7RwRXWO3bzBpKFolrvYN0D0HfuOTrZev2m6SVyyfJqTYc9mzyHouuoXDUerWrKBjbPV8Pm
 c6RR1HXbBcc75xqsK930ZwWbeZjw6QBHNWUSDHNBHX6/t30KOEtoBh1lkf3ANRYP4P8CNifHvAG
 bL4PIh/Ahia0qV9a0I3Vd9W80/MZnclXkEJHk/Akd1tQynzM1IJDpyg==
X-Received: by 2002:a05:6102:54a9:b0:797:bbf2:197 with SMTP id
 ada2fe7eead31-79b58c77125mr3303718137.1.1789493386428; Tue, 15 Sep 2026
 10:29:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260915160932.2118978-1-mario.limonciello@amd.com>
In-Reply-To: <20260915160932.2118978-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 15 Sep 2026 13:29:33 -0400
X-Gm-Features: AcwNN1WggCnKhZSO4Q2ivnkdYn-qdPXO1O6WPVPWUs8MPC-asbPgH8ecQ9WrDuE
Message-ID: <CADnq5_PJ6vrxctfaPVUu8DomnhvY0rUWv7YfqPEb0dLsVu3STg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix GPU PCIe link capability reporting
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>, 
 Lijo Lazar <lijo.lazar@amd.com>, stable@vger.kernel.org
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

On Tue, Sep 15, 2026 at 12:09=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Commit eb53125a7ad9 ("drm/amd: Add dedicated helper for
> amdgpu_device_find_parent()") made amdgpu_device_gpu_bandwidth() query
> the first device outside the dGPU. That is the host side of the
> physical link, not the GPU side.
>
> As a result, the ASIC and platform capability masks can both be based
> on the host port. drm_amdgpu_info_device then exposes the host
> capabilities to userspace, such as Gen5 x16 for a Gen4 x8 GPU.
>
> Cache both ends of the physical link during device initialization.
> Use link_dev for the GPU capability and link_partner for the platform
> capability and _PR3 detection.
>
> Reported-by: "Marek Ol=C5=A1=C3=A1k" <maraeo@gmail.com>
> Closes: https://lore.kernel.org/amd-gfx/CAAxE2A4VhsAzzO1QjBjUg+NgnbD04ZzM=
yN6xsUJxjKJHH6hxiw@mail.gmail.com/
> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
> Fixes: eb53125a7ad9 ("drm/amd: Add dedicated helper for amdgpu_device_fin=
d_parent()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  3 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 48 ++++++++--------------
>  2 files changed, 20 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 79b69d74eb2e5..3bad7b8f621cc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -626,6 +626,9 @@ enum amdgpu_enforce_isolation_mode {
>  struct amdgpu_device {
>         struct device                   *dev;
>         struct pci_dev                  *pdev;
> +       /* The two ends of the physical PCIe link outside the device. */
> +       struct pci_dev                  *link_dev;
> +       struct pci_dev                  *link_partner;
>         struct drm_device               ddev;
>
>  #ifdef CONFIG_DRM_AMD_ACP
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 44091ac12fa9c..0d277516fd55e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1959,18 +1959,17 @@ static void amdgpu_uid_fini(struct amdgpu_device =
*adev)
>         adev->uid_info =3D NULL;
>  }
>
> -static struct pci_dev *amdgpu_device_find_parent(struct amdgpu_device *a=
dev)
> +static void amdgpu_device_init_pcie_links(struct amdgpu_device *adev)
>  {
> -       struct pci_dev *parent =3D adev->pdev;
> +       adev->link_dev =3D adev->pdev;
> +       adev->link_partner =3D pci_upstream_bridge(adev->link_dev);
>
> -       /* skip upstream/downstream switches internal to dGPU */
> -       while ((parent =3D pci_upstream_bridge(parent))) {
> -               if (parent->vendor =3D=3D PCI_VENDOR_ID_ATI)
> -                       continue;
> -               break;
> +       /* Skip upstream/downstream switches internal to the dGPU. */
> +       while (adev->link_partner &&
> +              adev->link_partner->vendor =3D=3D PCI_VENDOR_ID_ATI) {
> +               adev->link_dev =3D adev->link_partner;
> +               adev->link_partner =3D pci_upstream_bridge(adev->link_dev=
);
>         }
> -
> -       return parent;
>  }
>
>  /**
> @@ -1986,7 +1985,6 @@ static struct pci_dev *amdgpu_device_find_parent(st=
ruct amdgpu_device *adev)
>  static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>  {
>         struct amdgpu_ip_block *ip_block;
> -       struct pci_dev *parent;
>         bool total, skip_bios, early_full_gpu_access =3D false;
>         uint32_t bios_flags;
>         int i, r;
> @@ -2082,10 +2080,9 @@ static int amdgpu_device_ip_early_init(struct amdg=
pu_device *adev)
>             !dev_is_removable(&adev->pdev->dev))
>                 adev->flags |=3D AMD_IS_PX;
>
> -       if (!(adev->flags & AMD_IS_APU)) {
> -               parent =3D amdgpu_device_find_parent(adev);
> -               adev->has_pr3 =3D parent ? pci_pr3_present(parent) : fals=
e;
> -       }
> +       if (!(adev->flags & AMD_IS_APU))
> +               adev->has_pr3 =3D adev->link_partner &&
> +                       pci_pr3_present(adev->link_partner);
>
>         adev->pm.pp_feature =3D amdgpu_pp_feature_mask;
>         if (amdgpu_sriov_vf(adev) || sched_policy =3D=3D KFD_SCHED_POLICY=
_NO_HWS)
> @@ -3783,6 +3780,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>
>         adev->shutdown =3D false;
>         adev->flags =3D flags;
> +       amdgpu_device_init_pcie_links(adev);
>
>         if (amdgpu_force_asic_type >=3D 0 && amdgpu_force_asic_type < CHI=
P_LAST)
>                 adev->asic_type =3D amdgpu_force_asic_type;
> @@ -5880,11 +5878,9 @@ static void amdgpu_device_partner_bandwidth(struct=
 amdgpu_device *adev,
>         *width =3D PCIE_LNK_WIDTH_UNKNOWN;
>
>         if (amdgpu_device_pcie_dynamic_switching_supported(adev)) {
> -               struct pci_dev *parent =3D amdgpu_device_find_parent(adev=
);
> -
> -               if (parent) {
> -                       *speed =3D pcie_get_speed_cap(parent);
> -                       *width =3D pcie_get_width_cap(parent);
> +               if (adev->link_partner) {
> +                       *speed =3D pcie_get_speed_cap(adev->link_partner)=
;
> +                       *width =3D pcie_get_width_cap(adev->link_partner)=
;
>                 }
>         } else {
>                 /* use the current speeds rather than max if switching is=
 not supported */
> @@ -5906,21 +5902,11 @@ static void amdgpu_device_gpu_bandwidth(struct am=
dgpu_device *adev,
>                                         enum pci_bus_speed *speed,
>                                         enum pcie_link_width *width)
>  {
> -       struct pci_dev *parent =3D adev->pdev;
> -
>         if (!speed || !width)
>                 return;
>
> -       /* use the device itself */
> -       *speed =3D pcie_get_speed_cap(adev->pdev);
> -       *width =3D pcie_get_width_cap(adev->pdev);
> -
> -       /* use the link outside the device */
> -       parent =3D amdgpu_device_find_parent(adev);
> -       if (parent) {
> -               *speed =3D pcie_get_speed_cap(parent);
> -               *width =3D pcie_get_width_cap(parent);
> -       }
> +       *speed =3D pcie_get_speed_cap(adev->link_dev);
> +       *width =3D pcie_get_width_cap(adev->link_dev);
>  }
>
>  /**
> --
> 2.43.0
>
