Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF6C1C3601A
	for <amd-gfx@archiver.kernel.org>; Sun,  6 Apr 2025 19:36:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EBF710E166;
	Sun,  6 Apr 2025 19:35:56 +0000 (UTC)
Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 529DD10E04D
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Apr 2025 17:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cardosozeferino.com;
 s=protonmail; t=1743787270; x=1744046470;
 bh=dAnNBohRO0E7wcGA6C1BsoK61ZP6lpF9YYKacMs+B2Y=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
 List-Unsubscribe:List-Unsubscribe-Post;
 b=mpNGy58U0bIvd6yHvdmV7/upWmC/XeakTxNslxRoMhLxg0vsOQIzK8ItmJzSyl3qe
 c+12Mic9OCo3hzBKuQ6qkonvGkaPGOOceXY0DbcQpjGLYLm/07t8nOTeP8o+1xATdl
 qNjuecY8ZWGsfatoYkFOHtp9jyj0x+H74Q7e/hoRhBR86HwVRbLvcb5Z8w6sHiB9dU
 MHeNsro19HfXaIWyYOCJn4a82RhQTFesJAiM8AGPmZrvwYr0oqkElrl14uc8Rpem5z
 96nEf1Nuz6r6MpM2x/hGCBMZJ4mfvOVB+BXv1ERq8PD7r91AihdQZILOoZ757r9n05
 PzSxvecW7ZATg==
Date: Fri, 04 Apr 2025 17:21:06 +0000
To: Mario Limonciello <superm1@kernel.org>, amd-gfx@lists.freedesktop.org
From: Leo <leo.cod@cardosozeferino.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v2] drm/amd: Add pre-zen AMD hardware to PCIe dynamic
 switching exclusions
Message-ID: <d081405f-03e0-4021-af9c-b051b8676eb9@cardosozeferino.com>
Feedback-ID: 79006605:user:proton
X-Pm-Message-ID: 5ec6310484f4d3ad3673305b8fd38fddc914fea7
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sun, 06 Apr 2025 19:35:54 +0000
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

Em 03/04/2025 00:11, Mario Limonciello escreveu:
> From: Mario Limonciello <mario.limonciello@amd.com>
>=20
> AMD RX580 when added AMD Phenom 2 has problems with overheating. This is =
due to
> changes with PCIe dynamic switching introduced by commit 466a7d115326e
> ("drm/amd: Use the first non-dGPU PCI device for BW limits").
>=20
> To avoid risks of other issues with old hardware require at least Zen har=
dware
> for AMD side to enable PCIe dynamic switching.
>=20
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4098
> Fixes: 466a7d115326e ("drm/amd: Use the first non-dGPU PCI device for BW =
limits")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v2:
>   * Cover more hardware
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 +++++
>   1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index a30111d2c3ea0..caa44ee788c8f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1854,6 +1854,9 @@ bool amdgpu_device_seamless_boot_supported(struct a=
mdgpu_device *adev)
>    *
>    * https://edc.intel.com/content/www/us/en/design/products/platforms/de=
tails/raptor-lake-s/13th-generation-core-processors-datasheet-volume-1-of-2=
/005/pci-express-support/
>    * https://gitlab.freedesktop.org/drm/amd/-/issues/2663
> + *
> + * AMD Phenom II X6 1090T has a similar issue
> + * https://gitlab.freedesktop.org/drm/amd/-/issues/4098
>    */
>   static bool amdgpu_device_pcie_dynamic_switching_supported(struct amdgp=
u_device *adev)
>   {
> @@ -1866,6 +1869,8 @@ static bool amdgpu_device_pcie_dynamic_switching_su=
pported(struct amdgpu_device
>  =20
>   =09if (c->x86_vendor =3D=3D X86_VENDOR_INTEL)
>   =09=09return false;
> +=09if (c->x86_vendor =3D=3D X86_VENDOR_AMD && !cpu_feature_enabled(X86_F=
EATURE_ZEN))
> +=09=09return false;
>   #endif
>   =09return true;
>   }

I was able to test and confirm that this patch solve the issue 4098 on upst=
ream linux kernel git. I could check that backporting it to LTS stable bran=
ch 6.12 solve the issue with this series too. Tested on AMD 880G chipset, P=
henom II x6 1090T processor with AMD Radeon RX 580 GPU.

Tested-by: Leandro Pinheiro <leo.cod@cardosozeferino.com>


