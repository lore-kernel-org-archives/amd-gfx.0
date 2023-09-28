Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDE4DE743C6
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Sep 2023 21:56:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BAEF10E6B5;
	Thu, 28 Sep 2023 21:56:48 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E0B810E6B5;
 Thu, 28 Sep 2023 21:56:47 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 0309161DB8;
 Thu, 28 Sep 2023 21:56:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61D58C433C7;
 Thu, 28 Sep 2023 21:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1695938205;
 bh=CCOmPtaIPAksl9FwVME2X9kGTjH7x0T2LVT+vz1R4gI=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=s4LDK5ARohl7qAnovUvynqNIvU0/b3bTTmaLsUmuJtrcWtxe92gX+eqwyvILh6IHq
 uDpLdB+qdEj1x/WA1mYpzeaCdaYK5cvYmK4HX1T5kemXL2PcdefesTsa+WhXnqesjE
 WMjak6vKupls/2afH4o7RKu3w8LANEbobTxzY9l6fo6iK+op3M/5KYbo0c8KyxZH0O
 719btZeOdZf4US21Wm0jATfP1Sh3NI8phBKTfiTYSgm1yEyEojpkG+T9oWSV8CXvuz
 bQHoyPhW2ITiU9HDQNup/JW99w6piiXTnTMEwLWomQAwUzRwdkvdOxMPrZ3BV1Sj/y
 XgYHOwGXxa/8Q==
Date: Thu, 28 Sep 2023 16:56:43 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: Re: [PATCH 0/5] Add the pci_get_base_class() helper and use it
Message-ID: <20230928215643.GA506151@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825062714.6325-1-sui.jingfeng@linux.dev>
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
Cc: alsa-devel@alsa-project.org, Sui Jingfeng <suijingfeng@loongson.cn>,
 nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Aug 25, 2023 at 02:27:09PM +0800, Sui Jingfeng wrote:
> From: Sui Jingfeng <suijingfeng@loongson.cn>
> 
> There is no function that can be used to get all PCI(e) devices in a
> system by matching against its the PCI base class code only, while keep
> the sub-class code and the programming interface ignored. Therefore, add
> the pci_get_base_class() function to suit the need.
> 
> For example, if an application want to process all PCI(e) display devices
> in a system, it can achieve such goal by writing the code as following:
> 
>     pdev = NULL;
>     do {
>         pdev = pci_get_base_class(PCI_BASE_CLASS_DISPLAY, pdev);
>         if (!pdev)
>             break;
> 
>         do_something_for_pci_display_device(pdev);
>     } while (1);
> 
> Sui Jingfeng (5):
>   PCI: Add the pci_get_base_class() helper
>   ALSA: hda/intel: Use pci_get_base_class() to reduce duplicated code
>   drm/nouveau: Use pci_get_base_class() to reduce duplicated code
>   drm/amdgpu: Use pci_get_base_class() to reduce duplicated code
>   drm/radeon: Use pci_get_base_class() to reduce duplicated code
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 11 +++------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 20 ++++-----------
>  drivers/gpu/drm/nouveau/nouveau_acpi.c   | 11 +++------
>  drivers/gpu/drm/radeon/radeon_bios.c     | 20 ++++-----------
>  drivers/pci/search.c                     | 31 ++++++++++++++++++++++++
>  include/linux/pci.h                      |  5 ++++
>  sound/pci/hda/hda_intel.c                | 16 ++++--------
>  7 files changed, 59 insertions(+), 55 deletions(-)

Applied to pci/enumeration for v6.7, thanks.
