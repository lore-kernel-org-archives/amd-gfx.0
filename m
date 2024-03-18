Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5305BC54E5D
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Mar 2024 13:37:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2CA410F73B;
	Mon, 18 Mar 2024 13:37:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hA9PA2Zk";
	dkim-atps=neutral
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CA7A10F73B
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Mar 2024 13:37:07 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-29deb7e2f7aso2466743a91.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Mar 2024 06:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710769027; x=1711373827; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x8K253EiuCBn/yhFvAgVhA8gkFoVuWaoPjixkpwn7RA=;
 b=hA9PA2ZkLQ0ti8Cb5FhraV6fpeys5MRRsv9XnQ5+YCPbSWfQRZPw5uhhX8XCFdTWaL
 hrXqXFs0Vnx7uOltc7d31RHLvGvsW6Wvg3BN6cx3SeTzgepiFHJ+3bW700A2ztQSVHoG
 d1/3dIvDgTfg8AMcI6XNHTaBsSgs2v58RFSWfuu09Swy+OZhAVWfx0xR4vPipciEkVnH
 DAljUwq3V0TwnY9ajRf5w5rEgkPmtvu8Jvsm6i9vnYbUZLY230We2+on+TLctIO95bPN
 6UNi2ZU4I1mXvtRSiNJZ1ZxkUXquvjwHup5EmGOPKR3tcBWlMdIh3it06comu7Hnbuhj
 zzGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710769027; x=1711373827;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x8K253EiuCBn/yhFvAgVhA8gkFoVuWaoPjixkpwn7RA=;
 b=ezFqzEmntu4uM8x4EUKUV21eYSNckW+iRopYEaPVRqzgrRZoPOdcLAsp1OtKTLxJNg
 pUXLAqTP09iUxe0JkFFHtSyhfubugX4PEbeZ8T/ZyVn05j1XjcSBDTJjhQRfN0eBNDHO
 doN2DxI1GFBt5P4+GbIAvhPLmOPK0s+qAkYtMtTvxfR5+dNPjb+1Go1V9STBA6JqF6wD
 umuV+RI/WZ76lC7i695x9Rh1QWYUBW2urIkY5OmcnP1YBBeGxGm+38la5vL4QbomC+rJ
 yfwNx9+C01zzGiGZ+E9vKXD952gHpoas040nQMD8MB6or9+mtzXg1pPJnpjUw9yCkJgb
 sj3Q==
X-Gm-Message-State: AOJu0Yy7utaw6MJPtJHvvRlircOcXJazl+aBpPedWQj+EuXtoauSHGu7
 3QXxdk5BOJATMFqA3XMvTU/AIPXBH4ObAHCjCvShspJjGra7MWgljm2uOhZ77LVcfz69ucCxKpu
 9rPcX2d8Nqz4kqZCiogMswz4EG2vYjfPN
X-Google-Smtp-Source: AGHT+IGDYcoyxepJjRf50qOWDi1n91GKZ7qCACIRd919UW69h59LYYDzX2UG0h2gdxvwNN6jtl3CqEcyt0MiH4hw1V8=
X-Received: by 2002:a17:90a:7f95:b0:299:df2:66b2 with SMTP id
 m21-20020a17090a7f9500b002990df266b2mr8517816pjl.22.1710769027163; Mon, 18
 Mar 2024 06:37:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240318065211.11097-1-kkartaltepe@gmail.com>
In-Reply-To: <20240318065211.11097-1-kkartaltepe@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 18 Mar 2024 09:36:54 -0400
Message-ID: <CADnq5_MxfDSaOoD9J2DfdkM2wzX_HfRPkLv8CSSVPzJSKi1aUQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Remove pci address checks from acpi_vfct_bios
To: Kurt Kartaltepe <kkartaltepe@gmail.com>
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

On Mon, Mar 18, 2024 at 4:47=E2=80=AFAM Kurt Kartaltepe <kkartaltepe@gmail.=
com> wrote:
>
> These checks prevent using amdgpu with the pcie=3Dassign-busses parameter
> which will re-address devices from their acpi values.
>
> Signed-off-by: Kurt Kartaltepe <kkartaltepe@gmail.com>

This will likely break multi-GPU functionality.  The BDF values are
how the sbios/driver differentiates between the VFCT images.  If you
have multiple GPUs in the system, the driver won't be able to figure
out which one goes with which GPU an you may end up assigning the
wrong image to the wrong device.

Alex


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_bios.c
> index 618e469e3622..932ce13ad232 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> @@ -386,9 +386,6 @@ static bool amdgpu_acpi_vfct_bios(struct amdgpu_devic=
e *adev)
>                 }
>
>                 if (vhdr->ImageLength &&
> -                   vhdr->PCIBus =3D=3D adev->pdev->bus->number &&
> -                   vhdr->PCIDevice =3D=3D PCI_SLOT(adev->pdev->devfn) &&
> -                   vhdr->PCIFunction =3D=3D PCI_FUNC(adev->pdev->devfn) =
&&
>                     vhdr->VendorID =3D=3D adev->pdev->vendor &&
>                     vhdr->DeviceID =3D=3D adev->pdev->device) {
>                         adev->bios =3D kmemdup(&vbios->VbiosContent,
> --
> 2.44.0
>
