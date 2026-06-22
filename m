Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCB9CCDB471
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2026 08:07:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B33C10E9F1;
	Tue, 23 Jun 2026 08:07:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=pm.me header.i=@pm.me header.b="Aw/urS12";
	dkim-atps=neutral
Received: from mail-4327.protonmail.ch (mail-4327.protonmail.ch [185.70.43.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF8FE10E695
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 12:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
 s=protonmail3; t=1782131649; x=1782390849;
 bh=+5AoqdLbG201OT7SCCKo+uKGJ8LdtVOX3oNnF+s+r8A=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=Aw/urS128ZcnJH8talsKbcLMSK+l+G3iGVs1jkw++Z8aeczor/AT5/YBF5kwWkncx
 wjyOuFyC635O6s9UJlNMCtbmLODlL8CMe4Cb24qIDRZhd3i4sqgj6rRd/HhLjZVbqi
 EtS6P4XK7HRTBPyJRjlP+674uVbuNj5ryTUI+x9IcWfnIUan5A/mPJmE6VQpr9FuET
 QT1dxoQKiHQKO17k7gkLhgMWTFPpnYcTrTO0VKiLz6OKDcvmKNPOcXkY8UGnRrOBgS
 XFvyVLzOv/zv+wplfHd6sgyIIoBcmwC3dXcZF3AWlcKag/Ga1zvY4694Bo5yEtBn0m
 CwEC6p0qZhZQg==
Date: Mon, 22 Jun 2026 12:34:05 +0000
To: =?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
From: Matthew Jacob <feralmatt@pm.me>
Cc: Matthew Jacob <mjacob@feralsw.com>, alexdeucher@gmail.com,
 amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] Support some Barco AMD based graphics adapters
Message-ID: <-OvmEF_NM5X1NJ1TKjZKl_nNHJhfQxE-zh4bIGMsBfCfSjyFJFc-sFkaYCXJZD4mhu1KKM0QJ7dbvMkzPJSzvkYhQixNHLNuRbSdNLnhjNU=@pm.me>
In-Reply-To: <10397a2a-88cf-4070-aced-291e24785a8d@amd.com>
References: <1b83ac6f-1018-3dee-c029-1b2ed78a8460@feralsw.com>
 <10397a2a-88cf-4070-aced-291e24785a8d@amd.com>
Feedback-ID: 169730088:user:proton
X-Pm-Message-ID: e4254e7b89988bf971a3f3ec6473026fc1b049e2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 23 Jun 2026 08:07:15 +0000
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

Sorry about the style. Do I need to resubmit?

My experience with the boards so far has been fine. Without the change mult=
iple monitors don't work correctly. With the change they do. Boot up in BIO=
S seems to operate correctly. Linux version testing has ranged from 5.15 th=
rough 6.12 and of course once top of tree recently.

Normally I probably wouldn't have bothered to intrude with this change, but=
 then the now widespread use of secure boot and the impracticality of disab=
ling secure boot in the Kaiser fleet when booting USB keys practically mean=
s that I need to get this change rolled out so that at least Debian will pi=
ck it up and produce signed kernels.


Wizard, 3rd Class

Sent from Proton Mail for Android.

-------- Original Message --------
On Monday, 06/22/26 at 01:22 Christian K=C3=B6nig <christian.koenig@amd.com=
> wrote:
On 6/19/26 20:45, Matthew Jacob wrote:
>
> These adapters typically are only supported by Barco on the Windows
> platform. However, with these changes in the linux driver, multiple
> monitor support should work correctly.
>
> Signed-off-by: Matthew Jacob <mjacob@feralsw.com>
> ---
> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 4 ++++
> =C2=A01 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index 60debd543e44..e3ba168795cc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -1926,6 +1926,7 @@ static const struct pci_device_id pciidlist[] =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {0x1002, 0x6646, PCI_ANY_ID, PCI_ANY=
_ID, 0, 0, CHIP_BONAIRE|AMD_IS_MOBILITY},
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {0x1002, 0x6647, PCI_ANY_ID, PCI_ANY=
_ID, 0, 0, CHIP_BONAIRE|AMD_IS_MOBILITY},
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {0x1002, 0x6649, PCI_ANY_ID, PCI_ANY=
_ID, 0, 0, CHIP_BONAIRE},
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {0x1002, 0x664D, PCI_ANY_ID, PCI_AN=
Y_ID, 0, 0, CHIP_BONAIRE}, // Barco MXRT-5600

Please no // style comments in kernel code.

Apart from that looks good to me, but I'm wondering if we shouldn't print a=
 warning or similar.

It could be that those boards have non standard VBIOS changes and cause pro=
blems on Linux.

Regards,
Christian.

> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {0x1002, 0x6650, PCI_ANY_ID, PCI_ANY=
_ID, 0, 0, CHIP_BONAIRE},
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {0x1002, 0x6651, PCI_ANY_ID, PCI_ANY=
_ID, 0, 0, CHIP_BONAIRE},
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {0x1002, 0x6658, PCI_ANY_ID, PCI_ANY=
_ID, 0, 0, CHIP_BONAIRE},
> @@ -1995,6 +1996,7 @@ static const struct pci_device_id pciidlist[] =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {0x1002, 0x6930, PCI_ANY_ID, PCI_ANY=
_ID, 0, 0, CHIP_TONGA},
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {0x1002, 0x6938, PCI_ANY_ID, PCI_ANY=
_ID, 0, 0, CHIP_TONGA},
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {0x1002, 0x6939, PCI_ANY_ID, PCI_ANY=
_ID, 0, 0, CHIP_TONGA},
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {0x1002, 0x693B, PCI_ANY_ID, PCI_AN=
Y_ID, 0, 0, CHIP_TONGA}, // Barco MXRT-7600
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* fiji */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {0x1002, 0x7300, PCI_ANY_ID, PCI_ANY=
_ID, 0, 0, CHIP_FIJI},
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {0x1002, 0x730F, PCI_ANY_ID, PCI_ANY=
_ID, 0, 0, CHIP_FIJI},
> @@ -2023,6 +2025,7 @@ static const struct pci_device_id pciidlist[] =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {0x1002, 0x67C4, PCI_ANY_ID, PCI_ANY=
_ID, 0, 0, CHIP_POLARIS10},
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {0x1002, 0x67C7, PCI_ANY_ID, PCI_ANY=
_ID, 0, 0, CHIP_POLARIS10},
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {0x1002, 0x67D0, PCI_ANY_ID, PCI_ANY=
_ID, 0, 0, CHIP_POLARIS10},
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {0x1002, 0x67D4, PCI_ANY_ID, PCI_AN=
Y_ID, 0, 0, CHIP_POLARIS10}, // Tentative Barco MXRT-8750
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {0x1002, 0x67DF, PCI_ANY_ID, PCI_ANY=
_ID, 0, 0, CHIP_POLARIS10},
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {0x1002, 0x67C8, PCI_ANY_ID, PCI_ANY=
_ID, 0, 0, CHIP_POLARIS10},
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {0x1002, 0x67C9, PCI_ANY_ID, PCI_ANY=
_ID, 0, 0, CHIP_POLARIS10},
> @@ -2036,6 +2039,7 @@ static const struct pci_device_id pciidlist[] =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {0x1002, 0x6985, PCI_ANY_ID, PCI_ANY=
_ID, 0, 0, CHIP_POLARIS12},
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {0x1002, 0x6986, PCI_ANY_ID, PCI_ANY=
_ID, 0, 0, CHIP_POLARIS12},
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {0x1002, 0x6987, PCI_ANY_ID, PCI_ANY=
_ID, 0, 0, CHIP_POLARIS12},
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {0x1002, 0x698F, PCI_ANY_ID, PCI_AN=
Y_ID, 0, 0, CHIP_POLARIS12}, // Tentative Barco MXRT-4700
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {0x1002, 0x6995, PCI_ANY_ID, PCI_ANY=
_ID, 0, 0, CHIP_POLARIS12},
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {0x1002, 0x6997, PCI_ANY_ID, PCI_ANY=
_ID, 0, 0, CHIP_POLARIS12},
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {0x1002, 0x699F, PCI_ANY_ID, PCI_ANY=
_ID, 0, 0, CHIP_POLARIS12},
> --
> 2.47.3
>


