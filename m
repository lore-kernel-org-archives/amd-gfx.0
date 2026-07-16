Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B23A5C44512
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2026 13:04:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C544A10F2D3;
	Thu, 16 Jul 2026 13:04:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=leemhuis.info header.i=@leemhuis.info header.b="f++vEyqb";
	dkim-atps=neutral
X-Greylist: delayed 595 seconds by postgrey-1.36 at gabe;
 Thu, 16 Jul 2026 05:08:08 UTC
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de
 [188.68.63.98])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BADCE10E1F7
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2026 05:08:08 +0000 (UTC)
Received: from mors-relay-2501.netcup.net (localhost [127.0.0.1])
 by mors-relay-2501.netcup.net (Postfix) with ESMTPS id 4h114X52rRz65Kb;
 Thu, 16 Jul 2026 06:57:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
 s=key2; t=1784177852;
 bh=Y+aLt6RD/gcPHY8Y02l03KxsxSyNRGTtfi73yCVNIrI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=f++vEyqb7i74wzLk2ER2SNq2SDHOHTlypXyj4k587+F9R177fnp1FoWZVpbC/QnNL
 iaaeWRpS5uZaRH4u6T67TuSmX5AkRIDi7ttyVH0z5DOLJoW++ETrlgNINBy6KiTgNO
 Fgs/PGLQ69rVos9T0d8p3bvhB4u3R6m+S62BfnBj9e+Lw8pRUzhmosktIAjyTRMEJl
 +8fTyEA3JpnW/V2jJGPnvMite1jem2oWzTDFPjzNMOaqO3OajkFvDpVdVXVAiBg6RS
 e5VoymYl5fu867orMlkm1llz6htdL3wGf/q/DksznQsRSVVxyaJyhCQoZpRWQ3rpxd
 F/8MDrWIlsc9Q==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
 by mors-relay-2501.netcup.net (Postfix) with ESMTPS id 4h114X4Hgyz4yRB;
 Thu, 16 Jul 2026 06:57:32 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by policy01-mors.netcup.net (Postfix) with ESMTPS id 4h114W2zt8z8tcF;
 Thu, 16 Jul 2026 06:57:31 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown
 [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
 by mxe9fb.netcup.net (Postfix) with ESMTPSA id CF58F60305;
 Thu, 16 Jul 2026 06:57:30 +0200 (CEST)
Authentication-Results: mxe9fb;
 spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f)
 smtp.mailfrom=linux@leemhuis.info
 smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <b7f32505-25bb-494e-b574-f0dee575b991@leemhuis.info>
Date: Thu, 16 Jul 2026 06:57:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] drm/radeon: Fix VFCT bus number matching with soft
 filter
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Oz Tiram <oz@shift-computing.de>
References: <20260708193518.702584-1-mario.limonciello@amd.com>
 <20260708193518.702584-5-mario.limonciello@amd.com>
From: Thorsten Leemhuis <linux@leemhuis.info>
Content-Language: de-DE, en-US
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 MEK4
In-Reply-To: <20260708193518.702584-5-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <178417785107.4061344.8980285396872252790@mxe9fb.netcup.net>
X-NC-CID: R4xaiyy9Rhqk3FGGO7Jmn9y6IlIeft87FF7F+kd5MPy7BUoWOok=
X-Mailman-Approved-At: Thu, 16 Jul 2026 13:04:52 +0000
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

On 7/8/26 21:35, Mario Limonciello wrote:
> On systems where PCI bus renumbering occurs (e.g. pci=realloc,
> resource conflicts), the runtime bus number may differ from the
> BIOS POST bus number recorded in the VFCT table. This causes
> radeon_acpi_vfct_bios() to fail finding the VBIOS even though
> the correct device entry exists.
> 
> Introduce radeon_acpi_vfct_match() 

This patch showed up in -next yesterday and from a very quick look seems
likely to be the reason for a ppc64le build error I ran into:

"""drivers/gpu/drm/radeon/radeon_bios.c:614:12: error:
‘radeon_acpi_vfct_match’ defined but not used [-Werror=unused-function]
  614 | static int radeon_acpi_vfct_match(struct radeon_device *rdev,
      |            ^~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[6]: *** [scripts/Makefile.build:289:
drivers/gpu/drm/radeon/radeon_bios.o] Error 1
make[5]: *** [scripts/Makefile.build:549: drivers/gpu/drm/radeon] Error 2
make[5]: *** Waiting for unfinished jobs....
make[4]: *** [scripts/Makefile.build:549: drivers/gpu/drm] Error 2
make[3]: *** [scripts/Makefile.build:549: drivers/gpu] Error 2
make[2]: *** [scripts/Makefile.build:549: drivers] Error 2
make[1]: ***
[/builddir/build/BUILD/kernel-7.2.0-build/kernel-next-20260715/linux-7.2.0-0.0.next.20260715.427.vanilla.fc45.ppc64le/Makefile:2228:
.] Error 2
make: *** [Makefile:256: __sub-make] Error 2
"""

Full log:
https://download.copr.fedorainfracloud.org/results/@kernel-vanilla/next/fedora-rawhide-ppc64le/10721545-next-next-all/builder-live.log.gz

Ciao, Thorsten

> drivers/gpu/drm/radeon/radeon_bios.c:6> drivers/gpu/drm/radeon/radeon_bios.c:614:12: error:
‘radeon_acpi_vfct_match’ defined but not used [-Werror=unused-function]
>   614 | static int radeon_acpi_vfct_match(struct radeon_device *rdev,
>       |            ^~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> make[6]: *** [scripts/Makefile.build:289: drivers/gpu/drm/radeon/radeon_bios.o] Error 1
> make[5]: *** [scripts/Makefile.build:549: drivers/gpu/drm/radeon] Error 2
> make[5]: *** Waiting for unfinished jobs....
> make[4]: *** [scripts/Makefile.build:549: drivers/gpu/drm] Error 2
> make[3]: *** [scripts/Makefile.build:549: drivers/gpu] Error 2
> make[2]: *** [scripts/Makefile.build:549: drivers] Error 2
> make[1]: *** [/builddir/build/BUILD/kernel-7.2.0-build/kernel-next-20260715/linux-7.2.0-0.0.next.20260715.427.vanilla.fc45.ppc64le/Makefile:2228: .] Error 2
> make: *** [Makefile:256: __sub-make] Error 2

14:12: error: ‘radeon_acpi_vfct_match’ defined but not used
[-Werror=unused-function]
>   614 | static int radeon_acpi_vfct_match(struct radeon_device *rdev,
>       |            ^~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> make[6]: *** [scripts/Makefile.build:289: drivers/gpu/drm/radeon/radeon_bios.o] Error 1
> make[5]: *** [scripts/Makefile.build:549: drivers/gpu/drm/radeon] Error 2
> make[5]: *** Waiting for unfinished jobs....
> make[4]: *** [scripts/Makefile.build:549: drivers/gpu/drm] Error 2
> make[3]: *** [scripts/Makefile.build:549: drivers/gpu] Error 2
> make[2]: *** [scripts/Makefile.build:549: drivers] Error 2
> make[1]: *** [/builddir/build/BUILD/kernel-7.2.0-build/kernel-next-20260715/linux-7.2.0-0.0.next.20260715.427.vanilla.fc45.ppc64le/Makefile:2228: .] Error 2
> make: *** [Makefile:256: __sub-make] Error 2

> drivers/gpu/drm/radeon/radeon_bios.c:614:12: error: ‘radeon_acpi_vfct_match’ defined but not used [-Werror=unused-function]
>   614 | static int radeon_acpi_vfct_match(struct radeon_device *rdev,
>       |            ^~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> make[6]: *** [scripts/Makefile.build:289: drivers/gpu/drm/radeon/radeon_bios.o] Error 1
> make[5]: *** [scripts/Makefile.build:549: drivers/gpu/drm/radeon] Error 2
> make[5]: *** Waiting for unfinished jobs....
> make[4]: *** [scripts/Makefile.build:549: drivers/gpu/drm] Error 2
> make[3]: *** [scripts/Makefile.build:549: drivers/gpu] Error 2
> make[2]: *** [scripts/Makefile.build:549: drivers] Error 2
> make[1]: *** [/builddir/build/BUILD/kernel-7.2.0-build/kernel-next-20260715/linux-7.2.0-0.0.next.20260715.427.vanilla.fc45.ppc64le/Makefile:2228: .] Error 2
> make: *** [Makefile:256: __sub-make] Error 2

> drivers/gpu/drm/radeon/radeon_bios.c:614:12: error: ‘radeon_acpi_vfct_match’ defined but not used [-Werror=unused-function]
>   614 | static int radeon_acpi_vfct_match(struct radeon_device *rdev,
>       |            ^~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> make[6]: *** [scripts/Makefile.build:289: drivers/gpu/drm/radeon/radeon_bios.o] Error 1
> make[5]: *** [scripts/Makefile.build:549: drivers/gpu/drm/radeon] Error 2
> make[5]: *** Waiting for unfinished jobs....
> make[4]: *** [scripts/Makefile.build:549: drivers/gpu/drm] Error 2
> make[3]: *** [scripts/Makefile.build:549: drivers/gpu] Error 2
> make[2]: *** [scripts/Makefile.build:549: drivers] Error 2
> make[1]: *** [/builddir/build/BUILD/kernel-7.2.0-build/kernel-next-20260715/linux-7.2.0-0.0.next.20260715.427.vanilla.fc45.ppc64le/Makefile:2228: .] Error 2
> make: *** [Makefile:256: __sub-make] Error 2


> drivers/gpu/drm/radeon/radeon_bios.c:614:12: error: ‘radeon_acpi_vfct_match’ defined but not used [-Werror=unused-function]
>   614 | static int radeon_acpi_vfct_match(struct radeon_device *rdev,
>       |            ^~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> make[6]: *** [scripts/Makefile.build:289: drivers/gpu/drm/radeon/radeon_bios.o] Error 1
> make[5]: *** [scripts/Makefile.build:549: drivers/gpu/drm/radeon] Error 2
> make[5]: *** Waiting for unfinished jobs....
> make[4]: *** [scripts/Makefile.build:549: drivers/gpu/drm] Error 2
> make[3]: *** [scripts/Makefile.build:549: drivers/gpu] Error 2
> make[2]: *** [scripts/Makefile.build:549: drivers] Error 2
> make[1]: *** [/builddir/build/BUILD/kernel-7.2.0-build/kernel-next-20260715/linux-7.2.0-0.0.next.20260715.427.vanilla.fc45.ppc64le/Makefile:2228: .] Error 2
> make: *** [Makefile:256: __sub-make] Error 2



> which treats the bus number
> as a soft filter: vendor/device/function identity is the hard
> requirement, while exact bus match is the preferred path. When
> bus numbers disagree but device identity matches, accept the
> VFCT entry and log a dev_notice for diagnostics. This mirrors the
> equivalent amdgpu change.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> Cc: Oz Tiram <oz@shift-computing.de>
>  drivers/gpu/drm/radeon/radeon_bios.c | 45 ++++++++++++++++++++++++----
>  1 file changed, 40 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/radeon/radeon_bios.c b/drivers/gpu/drm/radeon/radeon_bios.c
> index c6df799c3cf4a..cc10880af096b 100644
> --- a/drivers/gpu/drm/radeon/radeon_bios.c
> +++ b/drivers/gpu/drm/radeon/radeon_bios.c
> @@ -596,6 +596,45 @@ static bool radeon_read_disabled_bios(struct radeon_device *rdev)
>  		return legacy_read_disabled_bios(rdev);
>  }
>  
> +/**
> + * radeon_acpi_vfct_match() - Check if a VFCT entry matches the device
> + * @rdev: Radeon device
> + * @vhdr: VFCT image header to check
> + *
> + * VFCT entries contain the PCI bus number as recorded during BIOS POST.
> + * On systems where the kernel renumbers PCI buses (e.g. pci=realloc or
> + * resource conflicts), the runtime bus number may differ from the POST
> + * value.  Match by device identity (vendor + device + function) and use
> + * the bus number as a preference: exact bus match is preferred, but when
> + * the bus numbers disagree we accept the entry if the device identity
> + * matches.
> + *
> + * Returns: 0 on match, -ENODEV on no match
> + */
> +static int radeon_acpi_vfct_match(struct radeon_device *rdev,
> +				  VFCT_IMAGE_HEADER *vhdr)
> +{
> +	/* Vendor and device IDs must always match */
> +	if (vhdr->VendorID != rdev->pdev->vendor ||
> +	    vhdr->DeviceID != rdev->pdev->device)
> +		return -ENODEV;
> +
> +	if (vhdr->PCIDevice != PCI_SLOT(rdev->pdev->devfn) ||
> +	    vhdr->PCIFunction != PCI_FUNC(rdev->pdev->devfn))
> +		return -ENODEV;
> +
> +	/* Exact bus number match - preferred */
> +	if (vhdr->PCIBus == rdev->pdev->bus->number)
> +		return 0;
> +
> +	/* Bus mismatch but device identity matches (PCI renumbering case) */
> +	dev_notice(&rdev->pdev->dev,
> +		   "VFCT bus number mismatch: table %u != runtime %u, matching by device identity (vendor 0x%04x device 0x%04x)\n",
> +		   vhdr->PCIBus, rdev->pdev->bus->number,
> +		   rdev->pdev->vendor, rdev->pdev->device);
> +	return 0;
> +}
> +
>  #ifdef CONFIG_ACPI
>  static bool radeon_acpi_vfct_bios(struct radeon_device *rdev)
>  {
> @@ -633,11 +672,7 @@ static bool radeon_acpi_vfct_bios(struct radeon_device *rdev)
>  		}
>  
>  		if (vhdr->ImageLength &&
> -		    vhdr->PCIBus == rdev->pdev->bus->number &&
> -		    vhdr->PCIDevice == PCI_SLOT(rdev->pdev->devfn) &&
> -		    vhdr->PCIFunction == PCI_FUNC(rdev->pdev->devfn) &&
> -		    vhdr->VendorID == rdev->pdev->vendor &&
> -		    vhdr->DeviceID == rdev->pdev->device) {
> +		    !radeon_acpi_vfct_match(rdev, vhdr)) {
>  			rdev->bios = kmemdup(&vbios->VbiosContent,
>  					     vhdr->ImageLength,
>  					     GFP_KERNEL);

