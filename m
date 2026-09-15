Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50607C88E75
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2026 18:00:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C791F10E383;
	Tue, 15 Sep 2026 18:00:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TaxJuLCA";
	dkim-atps=neutral
Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com
 [74.125.228.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CD9610E383
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 18:00:10 +0000 (UTC)
Received: by mail-pz2-f42.google.com with SMTP id
 41be03b00d2f7-cc4e4979c55so4834a12.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 11:00:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789495210; cv=none;
 d=google.com; s=arc-20260327;
 b=IkodRV+avxJijUgYhmNF8e0WjwjLDXmQkEgVs9+oFHuWjZUnUDFX0ZsD6xEEwv8mpM
 uh3QOtkJ0Gq8vQRTFsyOc3LGwx55P6a64MqxmcZ95NsKjKRMu56DtHk6pFCPP/Oe3GkD
 3nOC47T5KKF9HVdKxym961PUR+cBoS8GX1d6NUeBje3RudhkQyKE4/rWnS2kXuUBtoaJ
 zuLkqpT06Q2GlMuFfDLcy0CDxyYd6VNLflbSwfOftY+8vY/T+v6nfMqqkZaWQE8vllA8
 ZXB4QF8k6bS3+/pD0ZvMWsJF25g3ax6OYj1TKrGEgLIRQR9MHv+oaVLllsXKAlo8tsgC
 6uhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pgzQ8hE+NBT8Dk4qme6EBUfgVgvQK/KJyOdwx7nPBi4=;
 fh=/jXuF6kkEzGc76I89MWDwYajZhHhstOH8SMMdzCQivY=;
 b=rg8LoZxcci3XA1Ic6m9VYLc8bz69Y5snZY01Ibsu4LGEKNZJOkc7EWsKMT8MsL6U/h
 GgCuYvl2j4cKHzqvKf/5MwB27DITqf0IRAbsHTsYEU7i9q+VP8pX6OtT9Yzo2/VDzaW/
 iuIKWRlyUtNzoTawLUcgRCYhioKdJ0BbH7hgzheuA6pKGeS39kYpa7nnAc7CSOtfwSdd
 sV9mBXvFQo7xKR38/EcIGiK+cGNHar1h/mmGTZMPo+/R01uCw8MY1ZP65YCiUxEUlJWS
 9TM8rh9RdQVYXmoCxh7nhxiQnoZf+XLrf15D1wQpAl/QcSTT2V7LmVDPR2hQdQ/M9uZ5
 snCg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789495210; x=1790100010; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pgzQ8hE+NBT8Dk4qme6EBUfgVgvQK/KJyOdwx7nPBi4=;
 b=TaxJuLCAr6nQjU0/QmvgAZQ3wd/3LLSRqcGwfLOAcp42kOwpdKA+nvnn76pyjfPqeb
 9sw+N54E5o+eLJEZFtBCiOs4YbnXBO2WTPYBYbvgZdTUkHcikFlMP7Gr5r1rB6M4k6/M
 fq9OaG3gz5EyDa61B7T5WpySxoH890PNI6mBuBiTAyulx6QiGU/LEfePjIHLbznzQr8L
 2vmEOGPpUoh9n5Pzw+baWOKwTeu8GYWMR/78AJzCL/i3gO9JqYh1ZfeI+mcfz52GB3ln
 G6wp/Jyp5cl2gdIBq8FjZRyrfxwzunF50dX176BrcYnDBY+FZR1cWfxXAL/mFNqpNXys
 gWRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789495210; x=1790100010;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pgzQ8hE+NBT8Dk4qme6EBUfgVgvQK/KJyOdwx7nPBi4=;
 b=f9bKycE+e2SsUMaozUqe2S/xnC8VqALDTwdZ3DqKVfpvW9edNb+NYFI5dzmO0pw+mZ
 siESqbt8spnxAOQery+wPdPmKbqfCXTRhXZKSUGjJQF7tNLo2dIUFnhoS/PjFHNcpw5W
 RQyA4UK0IdQ/DF4qT52i9C++jPa5qR9de8dSrzTV72ri7Yc37tJKo4elOiIinnziCga1
 U7e154PngWEIPNj39gY7R8RWHj6NyadB9IALVcxEoV0shsvqCX/QFXUlRmAr5YYf8n0r
 lJ1C4LobMTnoyST1u5xjcvWj3AcDw5t9IKm4VOBNJo8d7UYGs6G5MQieLZHdjY3qTG4p
 XwjA==
X-Gm-Message-State: AFuF++nvZa7p0syKUh3pVImpwqCph4clHwWrxqonmTqTS6tKdpquXSNe
 grEqGXOx2IWpdHzU5xPWqw2PWbYv0V/p0gpIC9C02LamQ8GuiF6RfCRyx8nK4CRgOnq2qlfVdpd
 jhvi291HBS6aGypP24ZHV5l1uiQafVmU7+Q==
X-Gm-Gg: AYBFou0rfLiB0OiqOEya1vgY4sfd0yZipDRHQ2+MLBqiuRMQHtM4gCpmVHLfESTHP7M
 3N9ufK1sHktYGiGPPXR3B610WG0N08Do9biC+qDFevuC34h1pGfB6pRGut0ZQuaLx/LIwbvXhzY
 lQbHjcLekGDnaVCkbmZEymjsN/MwlaTkiVnXOdn0sTcIrC2zwwyMa0timos8sh9E9u803Hz3x+h
 A93dRsmUuGotag2pJH1y4Yv8ECzyAM4QQysup7ToFBFL7EhfcDYLYC7Fit3EF7LuaZZvym5JAsN
 Q7upaOUmpcsPUccfWtNqnCv88gvtktnzW5W+xBNxshIstFWhSqRmPB7CxVGLdxiyoh1poGWo0db
 fp21J6G4RleKhoXjN5c/g7wSropR4JCHm3QltNnCcgw==
X-Received: by 2002:a17:90a:d88b:b0:398:bac0:238d with SMTP id
 98e67ed59e1d1-39dec21ea0cmr10514557a91.5.1789495209868; Tue, 15 Sep 2026
 11:00:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260915175556.2160918-1-mario.limonciello@amd.com>
In-Reply-To: <20260915175556.2160918-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 15 Sep 2026 13:59:54 -0400
X-Gm-Features: AcwNN1Xde4XXRjPZYYFNus_cm_EZDVP-Sg1-M7lpKowmMV_WRv146mm3Ej3NovE
Message-ID: <CADnq5_MZgrtgk2EBjwoHzzgsW=uXMzLCvZ+8JVaL2wYjsbfW7g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Reuse cached PCIe link device
To: Mario Limonciello <mario.limonciello@amd.com>
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

On Tue, Sep 15, 2026 at 1:56=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> After "drm/amdgpu: Fix GPU PCIe link capability reporting" there are
> now a few areas of walking topology.
>
> Use the cached GPU-side link device for ASPM queries and switch state
> caching instead of walking the PCI topology independently in each path.
>
> Validate the internal downstream/upstream switch pair when initializing
> the cached link devices so all consumers share the existing topology
> checks.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 62 ++++++++--------------
>  1 file changed, 21 insertions(+), 41 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 0d277516fd55e..07121d4aed3dc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1353,31 +1353,6 @@ static bool amdgpu_device_aspm_support_quirk(struc=
t amdgpu_device *adev)
>  #endif
>  }
>
> -/*
> - * Some dGPUs expose their display endpoint below an internal PCIe switc=
h.
> - * Use the switch upstream port to query the host-facing link.
> - */
> -static struct pci_dev *amdgpu_device_get_aspm_pdev(struct amdgpu_device =
*adev)
> -{
> -       struct pci_dev *swds, *swus;
> -
> -       swds =3D pci_upstream_bridge(adev->pdev);
> -       if (!swds ||
> -           (swds->vendor !=3D PCI_VENDOR_ID_ATI &&
> -            swds->vendor !=3D PCI_VENDOR_ID_AMD) ||
> -           pci_pcie_type(swds) !=3D PCI_EXP_TYPE_DOWNSTREAM)
> -               return adev->pdev;
> -
> -       swus =3D pci_upstream_bridge(swds);
> -       if (!swus ||
> -           (swus->vendor !=3D PCI_VENDOR_ID_ATI &&
> -            swus->vendor !=3D PCI_VENDOR_ID_AMD) ||
> -           pci_pcie_type(swus) !=3D PCI_EXP_TYPE_UPSTREAM)
> -               return adev->pdev;
> -
> -       return swus;
> -}
> -
>  /**
>   * amdgpu_device_should_use_aspm - check if the device should program AS=
PM
>   *
> @@ -1413,7 +1388,7 @@ bool amdgpu_device_should_use_aspm(struct amdgpu_de=
vice *adev)
>          * the immediate upstream bridge. Use SWUS for dGPUs with an
>          * internal switch so that this is the host-facing link.
>          */
> -       aspm_pdev =3D amdgpu_device_get_aspm_pdev(adev);
> +       aspm_pdev =3D adev->link_dev;
>         parent =3D pci_upstream_bridge(aspm_pdev);
>         if (!parent) {
>                 dev_dbg(adev->dev, "ASPM: no upstream PCIe link for %s\n"=
,
> @@ -1961,15 +1936,26 @@ static void amdgpu_uid_fini(struct amdgpu_device =
*adev)
>
>  static void amdgpu_device_init_pcie_links(struct amdgpu_device *adev)
>  {
> +       struct pci_dev *swds, *swus;
> +
>         adev->link_dev =3D adev->pdev;
>         adev->link_partner =3D pci_upstream_bridge(adev->link_dev);
>
> -       /* Skip upstream/downstream switches internal to the dGPU. */
> -       while (adev->link_partner &&
> -              adev->link_partner->vendor =3D=3D PCI_VENDOR_ID_ATI) {
> -               adev->link_dev =3D adev->link_partner;
> -               adev->link_partner =3D pci_upstream_bridge(adev->link_dev=
);
> -       }
> +       /* Skip an upstream/downstream switch internal to the dGPU. */
> +       swds =3D adev->link_partner;
> +       if (!swds || swds->vendor !=3D PCI_VENDOR_ID_ATI ||
> +           pci_pcie_type(swds) !=3D PCI_EXP_TYPE_DOWNSTREAM)
> +               return;
> +
> +       swus =3D pci_upstream_bridge(swds);
> +       if (!swus ||
> +           (swus->vendor !=3D PCI_VENDOR_ID_ATI &&
> +            swus->vendor !=3D PCI_VENDOR_ID_AMD) ||
> +           pci_pcie_type(swus) !=3D PCI_EXP_TYPE_UPSTREAM)
> +               return;
> +
> +       adev->link_dev =3D swus;
> +       adev->link_partner =3D pci_upstream_bridge(swus);
>  }
>
>  /**
> @@ -6428,16 +6414,10 @@ static void amdgpu_device_cache_switch_state(stru=
ct amdgpu_device *adev)
>         struct pci_dev *swus, *swds;
>         int r;
>
> -       swds =3D pci_upstream_bridge(adev->pdev);
> -       if (!swds || swds->vendor !=3D PCI_VENDOR_ID_ATI ||
> -           pci_pcie_type(swds) !=3D PCI_EXP_TYPE_DOWNSTREAM)
> -               return;
> -       swus =3D pci_upstream_bridge(swds);
> -       if (!swus ||
> -           (swus->vendor !=3D PCI_VENDOR_ID_ATI &&
> -            swus->vendor !=3D PCI_VENDOR_ID_AMD) ||
> -           pci_pcie_type(swus) !=3D PCI_EXP_TYPE_UPSTREAM)
> +       swus =3D adev->link_dev !=3D adev->pdev ? adev->link_dev : NULL;
> +       if (!swus)
>                 return;
> +       swds =3D pci_upstream_bridge(adev->pdev);
>
>         /* If already saved, return */
>         if (adev->pcie_reset_ctx.swus)
> --
> 2.43.0
>
