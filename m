Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA271C02180
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2025 17:09:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59CB510E742;
	Mon, 13 Jan 2025 17:09:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TitMXIAM";
	dkim-atps=neutral
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B07B10E741
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jan 2025 17:09:02 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-2ef79243680so985501a91.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jan 2025 09:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736788082; x=1737392882; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CWbBG38R5hg2u35jm5hSUDPehqhS7bkNOqpSOUcyiRI=;
 b=TitMXIAMLR2kb7ip3wflGaqf254ojguYHH84SKzvSJK71KdIWoDpe+Fh8atAJwz9zO
 F4omIoS0Eyeh1Q+ruJG6CHZdVvD7Mc68W3yAC9z5pAC7ZWaNptlEskwikTQfZ74l1mN6
 Asil4/kIfREbVBU2k8XtF+Bdwf7XuQB6N/W3LqyE0dG/J2RJqevdA21lE6qWiMZmmIho
 yqon0jHcoVicGt3IBVlEq256qYxmT4leNWAKZ9bxHVEEuN8rmu2d1oZVTVwqCg8jDmVV
 Nogn7bk7ENGipGQJ68KPnD/bAAA0gEneNKplIM6WxmfxOJidvMz0Lhsc4vzLoKHyXqbo
 aiHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736788082; x=1737392882;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CWbBG38R5hg2u35jm5hSUDPehqhS7bkNOqpSOUcyiRI=;
 b=dDy17dJAR5G1LLR6sACy503PHhp5+Mzq4M30FC+T5njl/DvQh8xF01y8O3Jp+F4al3
 GXMCWdqKgYNV6IB3pT1/eu5MNPcGjvicioX/bA66pmCIBrd4mhdYu6eh629DWZld6gbU
 EhlRSetwq/TuS8fU/BIkD3BKlUylEHOFURfqThMUz+ZtcoOk5yrpRU4wRahwYTdJr0Em
 YPpwfkpqv5fW9AZ9Unp4k58ed2Bl+08yNIBJ+mNqOLkAbmBFaciqC5gqqNfHOIlL1UjH
 O7sUhQv5QiduXe9dbRXP9tRXnIT6XTNXySbNSPAijurWKUnhFELalYUGf4IWbv/QF/IQ
 IFRg==
X-Gm-Message-State: AOJu0Ywy7z+N7uobyCIrcbAWfCfaRhjgevSJASrusN2zPoTe3YUAlnPZ
 uPDZZ1iAok4yvbEoq4a/ORXleVpfPX+5VtU7pA5vRValt10vifELtmGqF1UpTnKIEU1wRK/YFk1
 9I3+daRzpRIG3wOyQ/GNev0Ht9GE=
X-Gm-Gg: ASbGnctJV8plMwM6nVnEFsBFkJPorWVgPZPUSzDE9Zb/dUbhT08yygNTY83FqGghEoT
 dFFcJGPpfyG4NgRQp1SacWausgQB/w7j1DWLyQA==
X-Google-Smtp-Source: AGHT+IHM/4iCgjTfRtMsPzyH0hiqU22pmvbWNp6kH2PvGwRhzfSRYvoQ/3nzdvd3JT+zmZEoMuE+Qor4YqPShs5/Gjg=
X-Received: by 2002:a17:90b:270d:b0:2ee:d4ed:13a7 with SMTP id
 98e67ed59e1d1-2f5490de540mr11421330a91.7.1736788081634; Mon, 13 Jan 2025
 09:08:01 -0800 (PST)
MIME-Version: 1.0
References: <20250107161024.73371-1-alexander.deucher@amd.com>
In-Reply-To: <20250107161024.73371-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 13 Jan 2025 12:07:49 -0500
X-Gm-Features: AbW1kvZvjLKseptOJdY_XnINucwB6rLBUL1gG_5Lq8SSfSPU8yIXIJQ0UfBPblI
Message-ID: <CADnq5_OO=vUVNfDoQdMCJC1+MXNOv+X1RUtRyv57orhDQ0GJ_Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: cache gpu pcie link width
To: Alex Deucher <alexander.deucher@amd.com>
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

Ping on this series?

Alex

On Tue, Jan 7, 2025 at 11:17=E2=80=AFAM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> Get the PCIe link with of the device itself (or it's
> integrated upstream bridge) and cache that.
>
> v2: fix typo
>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3820
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 152 ++++++++++++++++-----
>  drivers/gpu/drm/amd/include/amd_pcie.h     |  18 +++
>  2 files changed, 138 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 90eb92c4c2800..72aff70464ed7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -6162,6 +6162,44 @@ static void amdgpu_device_partner_bandwidth(struct=
 amdgpu_device *adev,
>         }
>  }
>
> +/**
> + * amdgpu_device_gpu_bandwidth - find the bandwidth of the GPU
> + *
> + * @adev: amdgpu_device pointer
> + * @speed: pointer to the speed of the link
> + * @width: pointer to the width of the link
> + *
> + * Evaluate the hierarchy to find the speed and bandwidth capabilities o=
f the
> + * AMD dGPU which may be a virtual upstream bridge.
> + */
> +static void amdgpu_device_gpu_bandwidth(struct amdgpu_device *adev,
> +                                       enum pci_bus_speed *speed,
> +                                       enum pcie_link_width *width)
> +{
> +       struct pci_dev *parent =3D adev->pdev;
> +
> +       if (!speed || !width)
> +               return;
> +
> +       parent =3D pci_upstream_bridge(parent);
> +       if (parent && parent->vendor =3D=3D PCI_VENDOR_ID_ATI) {
> +               /* use the upstream/downstream switches internal to dGPU =
*/
> +               *speed =3D pcie_get_speed_cap(parent);
> +               *width =3D pcie_get_width_cap(parent);
> +               while ((parent =3D pci_upstream_bridge(parent))) {
> +                       if (parent->vendor =3D=3D PCI_VENDOR_ID_ATI) {
> +                               /* use the upstream/downstream switches i=
nternal to dGPU */
> +                               *speed =3D pcie_get_speed_cap(parent);
> +                               *width =3D pcie_get_width_cap(parent);
> +                       }
> +               }
> +       } else {
> +               /* use the device itself */
> +               *speed =3D pcie_get_speed_cap(parent);
> +               *width =3D pcie_get_width_cap(parent);
> +       }
> +}
> +
>  /**
>   * amdgpu_device_get_pcie_info - fence pcie info about the PCIE slot
>   *
> @@ -6173,9 +6211,8 @@ static void amdgpu_device_partner_bandwidth(struct =
amdgpu_device *adev,
>   */
>  static void amdgpu_device_get_pcie_info(struct amdgpu_device *adev)
>  {
> -       struct pci_dev *pdev;
>         enum pci_bus_speed speed_cap, platform_speed_cap;
> -       enum pcie_link_width platform_link_width;
> +       enum pcie_link_width platform_link_width, link_width;
>
>         if (amdgpu_pcie_gen_cap)
>                 adev->pm.pcie_gen_mask =3D amdgpu_pcie_gen_cap;
> @@ -6197,11 +6234,10 @@ static void amdgpu_device_get_pcie_info(struct am=
dgpu_device *adev)
>
>         amdgpu_device_partner_bandwidth(adev, &platform_speed_cap,
>                                         &platform_link_width);
> +       amdgpu_device_gpu_bandwidth(adev, &speed_cap, &link_width);
>
>         if (adev->pm.pcie_gen_mask =3D=3D 0) {
>                 /* asic caps */
> -               pdev =3D adev->pdev;
> -               speed_cap =3D pcie_get_speed_cap(pdev);
>                 if (speed_cap =3D=3D PCI_SPEED_UNKNOWN) {
>                         adev->pm.pcie_gen_mask |=3D (CAIL_ASIC_PCIE_LINK_=
SPEED_SUPPORT_GEN1 |
>                                                   CAIL_ASIC_PCIE_LINK_SPE=
ED_SUPPORT_GEN2 |
> @@ -6257,51 +6293,103 @@ static void amdgpu_device_get_pcie_info(struct a=
mdgpu_device *adev)
>                 }
>         }
>         if (adev->pm.pcie_mlw_mask =3D=3D 0) {
> +               /* asic caps */
> +               if (link_width =3D=3D PCIE_LNK_WIDTH_UNKNOWN) {
> +                       adev->pm.pcie_mlw_mask |=3D AMDGPU_DEFAULT_ASIC_P=
CIE_MLW_MASK;
> +               } else {
> +                       switch (link_width) {
> +                       case PCIE_LNK_X32:
> +                               adev->pm.pcie_mlw_mask |=3D (CAIL_ASIC_PC=
IE_LINK_WIDTH_SUPPORT_X32 |
> +                                                          CAIL_ASIC_PCIE=
_LINK_WIDTH_SUPPORT_X16 |
> +                                                          CAIL_ASIC_PCIE=
_LINK_WIDTH_SUPPORT_X12 |
> +                                                          CAIL_ASIC_PCIE=
_LINK_WIDTH_SUPPORT_X8 |
> +                                                          CAIL_ASIC_PCIE=
_LINK_WIDTH_SUPPORT_X4 |
> +                                                          CAIL_ASIC_PCIE=
_LINK_WIDTH_SUPPORT_X2 |
> +                                                          CAIL_ASIC_PCIE=
_LINK_WIDTH_SUPPORT_X1);
> +                               break;
> +                       case PCIE_LNK_X16:
> +                               adev->pm.pcie_mlw_mask |=3D (CAIL_ASIC_PC=
IE_LINK_WIDTH_SUPPORT_X16 |
> +                                                          CAIL_ASIC_PCIE=
_LINK_WIDTH_SUPPORT_X12 |
> +                                                          CAIL_ASIC_PCIE=
_LINK_WIDTH_SUPPORT_X8 |
> +                                                          CAIL_ASIC_PCIE=
_LINK_WIDTH_SUPPORT_X4 |
> +                                                          CAIL_ASIC_PCIE=
_LINK_WIDTH_SUPPORT_X2 |
> +                                                          CAIL_ASIC_PCIE=
_LINK_WIDTH_SUPPORT_X1);
> +                               break;
> +                       case PCIE_LNK_X12:
> +                               adev->pm.pcie_mlw_mask |=3D (CAIL_ASIC_PC=
IE_LINK_WIDTH_SUPPORT_X12 |
> +                                                          CAIL_ASIC_PCIE=
_LINK_WIDTH_SUPPORT_X8 |
> +                                                          CAIL_ASIC_PCIE=
_LINK_WIDTH_SUPPORT_X4 |
> +                                                          CAIL_ASIC_PCIE=
_LINK_WIDTH_SUPPORT_X2 |
> +                                                          CAIL_ASIC_PCIE=
_LINK_WIDTH_SUPPORT_X1);
> +                               break;
> +                       case PCIE_LNK_X8:
> +                               adev->pm.pcie_mlw_mask |=3D (CAIL_ASIC_PC=
IE_LINK_WIDTH_SUPPORT_X8 |
> +                                                          CAIL_ASIC_PCIE=
_LINK_WIDTH_SUPPORT_X4 |
> +                                                          CAIL_ASIC_PCIE=
_LINK_WIDTH_SUPPORT_X2 |
> +                                                          CAIL_ASIC_PCIE=
_LINK_WIDTH_SUPPORT_X1);
> +                               break;
> +                       case PCIE_LNK_X4:
> +                               adev->pm.pcie_mlw_mask |=3D (CAIL_ASIC_PC=
IE_LINK_WIDTH_SUPPORT_X4 |
> +                                                          CAIL_ASIC_PCIE=
_LINK_WIDTH_SUPPORT_X2 |
> +                                                          CAIL_ASIC_PCIE=
_LINK_WIDTH_SUPPORT_X1);
> +                               break;
> +                       case PCIE_LNK_X2:
> +                               adev->pm.pcie_mlw_mask |=3D (CAIL_ASIC_PC=
IE_LINK_WIDTH_SUPPORT_X2 |
> +                                                          CAIL_ASIC_PCIE=
_LINK_WIDTH_SUPPORT_X1);
> +                               break;
> +                       case PCIE_LNK_X1:
> +                               adev->pm.pcie_mlw_mask |=3D CAIL_ASIC_PCI=
E_LINK_WIDTH_SUPPORT_X1;
> +                               break;
> +                       default:
> +                               break;
> +                       }
> +               }
> +               /* platform caps */
>                 if (platform_link_width =3D=3D PCIE_LNK_WIDTH_UNKNOWN) {
>                         adev->pm.pcie_mlw_mask |=3D AMDGPU_DEFAULT_PCIE_M=
LW_MASK;
>                 } else {
>                         switch (platform_link_width) {
>                         case PCIE_LNK_X32:
> -                               adev->pm.pcie_mlw_mask =3D (CAIL_PCIE_LIN=
K_WIDTH_SUPPORT_X32 |
> -                                                         CAIL_PCIE_LINK_=
WIDTH_SUPPORT_X16 |
> -                                                         CAIL_PCIE_LINK_=
WIDTH_SUPPORT_X12 |
> -                                                         CAIL_PCIE_LINK_=
WIDTH_SUPPORT_X8 |
> -                                                         CAIL_PCIE_LINK_=
WIDTH_SUPPORT_X4 |
> -                                                         CAIL_PCIE_LINK_=
WIDTH_SUPPORT_X2 |
> -                                                         CAIL_PCIE_LINK_=
WIDTH_SUPPORT_X1);
> +                               adev->pm.pcie_mlw_mask |=3D (CAIL_PCIE_LI=
NK_WIDTH_SUPPORT_X32 |
> +                                                          CAIL_PCIE_LINK=
_WIDTH_SUPPORT_X16 |
> +                                                          CAIL_PCIE_LINK=
_WIDTH_SUPPORT_X12 |
> +                                                          CAIL_PCIE_LINK=
_WIDTH_SUPPORT_X8 |
> +                                                          CAIL_PCIE_LINK=
_WIDTH_SUPPORT_X4 |
> +                                                          CAIL_PCIE_LINK=
_WIDTH_SUPPORT_X2 |
> +                                                          CAIL_PCIE_LINK=
_WIDTH_SUPPORT_X1);
>                                 break;
>                         case PCIE_LNK_X16:
> -                               adev->pm.pcie_mlw_mask =3D (CAIL_PCIE_LIN=
K_WIDTH_SUPPORT_X16 |
> -                                                         CAIL_PCIE_LINK_=
WIDTH_SUPPORT_X12 |
> -                                                         CAIL_PCIE_LINK_=
WIDTH_SUPPORT_X8 |
> -                                                         CAIL_PCIE_LINK_=
WIDTH_SUPPORT_X4 |
> -                                                         CAIL_PCIE_LINK_=
WIDTH_SUPPORT_X2 |
> -                                                         CAIL_PCIE_LINK_=
WIDTH_SUPPORT_X1);
> +                               adev->pm.pcie_mlw_mask |=3D (CAIL_PCIE_LI=
NK_WIDTH_SUPPORT_X16 |
> +                                                          CAIL_PCIE_LINK=
_WIDTH_SUPPORT_X12 |
> +                                                          CAIL_PCIE_LINK=
_WIDTH_SUPPORT_X8 |
> +                                                          CAIL_PCIE_LINK=
_WIDTH_SUPPORT_X4 |
> +                                                          CAIL_PCIE_LINK=
_WIDTH_SUPPORT_X2 |
> +                                                          CAIL_PCIE_LINK=
_WIDTH_SUPPORT_X1);
>                                 break;
>                         case PCIE_LNK_X12:
> -                               adev->pm.pcie_mlw_mask =3D (CAIL_PCIE_LIN=
K_WIDTH_SUPPORT_X12 |
> -                                                         CAIL_PCIE_LINK_=
WIDTH_SUPPORT_X8 |
> -                                                         CAIL_PCIE_LINK_=
WIDTH_SUPPORT_X4 |
> -                                                         CAIL_PCIE_LINK_=
WIDTH_SUPPORT_X2 |
> -                                                         CAIL_PCIE_LINK_=
WIDTH_SUPPORT_X1);
> +                               adev->pm.pcie_mlw_mask |=3D (CAIL_PCIE_LI=
NK_WIDTH_SUPPORT_X12 |
> +                                                          CAIL_PCIE_LINK=
_WIDTH_SUPPORT_X8 |
> +                                                          CAIL_PCIE_LINK=
_WIDTH_SUPPORT_X4 |
> +                                                          CAIL_PCIE_LINK=
_WIDTH_SUPPORT_X2 |
> +                                                          CAIL_PCIE_LINK=
_WIDTH_SUPPORT_X1);
>                                 break;
>                         case PCIE_LNK_X8:
> -                               adev->pm.pcie_mlw_mask =3D (CAIL_PCIE_LIN=
K_WIDTH_SUPPORT_X8 |
> -                                                         CAIL_PCIE_LINK_=
WIDTH_SUPPORT_X4 |
> -                                                         CAIL_PCIE_LINK_=
WIDTH_SUPPORT_X2 |
> -                                                         CAIL_PCIE_LINK_=
WIDTH_SUPPORT_X1);
> +                               adev->pm.pcie_mlw_mask |=3D (CAIL_PCIE_LI=
NK_WIDTH_SUPPORT_X8 |
> +                                                          CAIL_PCIE_LINK=
_WIDTH_SUPPORT_X4 |
> +                                                          CAIL_PCIE_LINK=
_WIDTH_SUPPORT_X2 |
> +                                                          CAIL_PCIE_LINK=
_WIDTH_SUPPORT_X1);
>                                 break;
>                         case PCIE_LNK_X4:
> -                               adev->pm.pcie_mlw_mask =3D (CAIL_PCIE_LIN=
K_WIDTH_SUPPORT_X4 |
> -                                                         CAIL_PCIE_LINK_=
WIDTH_SUPPORT_X2 |
> -                                                         CAIL_PCIE_LINK_=
WIDTH_SUPPORT_X1);
> +                               adev->pm.pcie_mlw_mask |=3D (CAIL_PCIE_LI=
NK_WIDTH_SUPPORT_X4 |
> +                                                          CAIL_PCIE_LINK=
_WIDTH_SUPPORT_X2 |
> +                                                          CAIL_PCIE_LINK=
_WIDTH_SUPPORT_X1);
>                                 break;
>                         case PCIE_LNK_X2:
> -                               adev->pm.pcie_mlw_mask =3D (CAIL_PCIE_LIN=
K_WIDTH_SUPPORT_X2 |
> -                                                         CAIL_PCIE_LINK_=
WIDTH_SUPPORT_X1);
> +                               adev->pm.pcie_mlw_mask |=3D (CAIL_PCIE_LI=
NK_WIDTH_SUPPORT_X2 |
> +                                                          CAIL_PCIE_LINK=
_WIDTH_SUPPORT_X1);
>                                 break;
>                         case PCIE_LNK_X1:
> -                               adev->pm.pcie_mlw_mask =3D CAIL_PCIE_LINK=
_WIDTH_SUPPORT_X1;
> +                               adev->pm.pcie_mlw_mask |=3D CAIL_PCIE_LIN=
K_WIDTH_SUPPORT_X1;
>                                 break;
>                         default:
>                                 break;
> diff --git a/drivers/gpu/drm/amd/include/amd_pcie.h b/drivers/gpu/drm/amd=
/include/amd_pcie.h
> index a1ece3eecdf5e..a08611cb80411 100644
> --- a/drivers/gpu/drm/amd/include/amd_pcie.h
> +++ b/drivers/gpu/drm/amd/include/amd_pcie.h
> @@ -49,6 +49,17 @@
>                                       | CAIL_ASIC_PCIE_LINK_SPEED_SUPPORT=
_GEN3)
>
>  /* Following flags shows PCIe lane width switch supported in driver whic=
h are decided by chipset and ASIC */
> +
> +#define CAIL_ASIC_PCIE_LINK_WIDTH_SUPPORT_X1          0x00000001
> +#define CAIL_ASIC_PCIE_LINK_WIDTH_SUPPORT_X2          0x00000002
> +#define CAIL_ASIC_PCIE_LINK_WIDTH_SUPPORT_X4          0x00000004
> +#define CAIL_ASIC_PCIE_LINK_WIDTH_SUPPORT_X8          0x00000008
> +#define CAIL_ASIC_PCIE_LINK_WIDTH_SUPPORT_X12         0x00000010
> +#define CAIL_ASIC_PCIE_LINK_WIDTH_SUPPORT_X16         0x00000020
> +#define CAIL_ASIC_PCIE_LINK_WIDTH_SUPPORT_X32         0x00000040
> +#define CAIL_ASIC_PCIE_LINK_WIDTH_SUPPORT_MASK        0x0000FFFF
> +#define CAIL_ASIC_PCIE_LINK_WIDTH_SUPPORT_SHIFT       0
> +
>  #define CAIL_PCIE_LINK_WIDTH_SUPPORT_X1          0x00010000
>  #define CAIL_PCIE_LINK_WIDTH_SUPPORT_X2          0x00020000
>  #define CAIL_PCIE_LINK_WIDTH_SUPPORT_X4          0x00040000
> @@ -56,6 +67,7 @@
>  #define CAIL_PCIE_LINK_WIDTH_SUPPORT_X12         0x00100000
>  #define CAIL_PCIE_LINK_WIDTH_SUPPORT_X16         0x00200000
>  #define CAIL_PCIE_LINK_WIDTH_SUPPORT_X32         0x00400000
> +#define CAIL_PCIE_LINK_WIDTH_SUPPORT_MASK        0xFFFF0000
>  #define CAIL_PCIE_LINK_WIDTH_SUPPORT_SHIFT       16
>
>  /* 1/2/4/8/16 lanes */
> @@ -65,4 +77,10 @@
>                                       | CAIL_PCIE_LINK_WIDTH_SUPPORT_X8 \
>                                       | CAIL_PCIE_LINK_WIDTH_SUPPORT_X16)
>
> +#define AMDGPU_DEFAULT_ASIC_PCIE_MLW_MASK (CAIL_ASIC_PCIE_LINK_WIDTH_SUP=
PORT_X1 \
> +                                          | CAIL_ASIC_PCIE_LINK_WIDTH_SU=
PPORT_X2 \
> +                                          | CAIL_ASIC_PCIE_LINK_WIDTH_SU=
PPORT_X4 \
> +                                          | CAIL_ASIC_PCIE_LINK_WIDTH_SU=
PPORT_X8 \
> +                                          | CAIL_ASIC_PCIE_LINK_WIDTH_SU=
PPORT_X16)
> +
>  #endif
> --
> 2.47.1
>
