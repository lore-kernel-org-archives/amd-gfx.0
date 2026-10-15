Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AF4BCC6B34
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2026 12:56:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9627910E810;
	Thu, 15 Oct 2026 12:56:29 +0000 (UTC)
Received: from mail.sig21.net (mail.sig21.net [217.197.84.222])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2724E10EBA9
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 09:18:07 +0000 (UTC)
Received: from localhorst ([127.0.0.1]) by mail.sig21.net with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.96) (envelope-from <js@sig21.net>) id 1xHHb1-0001N2-3A ;
 Thu, 15 Oct 2026 11:17:59 +0200
Received: from js by abc.local with local (Exim 4.100.1)
 (envelope-from <js@sig21.net>) id 1xHHb3-000000001TN-09Bo;
 Thu, 15 Oct 2026 11:17:57 +0200
Date: Thu, 15 Oct 2026 11:17:57 +0200
From: Johannes Stezenbach <js@sig21.net>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
Subject: Re: amdgpu causes boot failure after BIOS update AGESA ComboAM5
 1.3.0.1a on Asrock X600
Message-ID: <atCaRZrxxcz4xRje@sig21.net>
References: <ar-GzWfyQMeRTRCt@sig21.net>
 <CADnq5_ODecWYOwbBYDnV-aeAi+pCMoxJvufuzY8_4yf5cF0dEg@mail.gmail.com>
 <2b4560f5-3458-4218-89f7-509c298b2126@amd.com>
 <asAFItSKC74Lm9mT@sig21.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asAFItSKC74Lm9mT@sig21.net>
X-Mailman-Approved-At: Thu, 15 Oct 2026 12:56:28 +0000
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

Hi,

On Fri, Oct 02, 2026 at 09:25:22PM +0200, Johannes Stezenbach wrote:
> However, my self-built kernel still crashes early after I changed
> amdgpu to be a loadable module. So there is something else going
> on, but lets concentrate on the andgpu failure with the Debian kernel.

I was able to resolve this. I went through my kernel config and
compared to Debian's and found the following suspicious
configurations that had worked with previous BIOS v4.14:

CONFIG_PCIEASPM_POWER_SUPERSAVE (should be CONFIG_PCIEASPM_DEFAULT)
CONFIG_EFI_DISABLE_PCI_DMA
CONFIG_EFI_DISABLE_RUNTIME

After disabling them my kernel can boot and runs stable.

The issue with occational boot failures in amdgpu persists,
but it's not a blocker since it only seems to happen on boot,
not on resume from suspend or hibernate. So in practice it
happens rarely and can be worked around by just resetting
until it boots successfully. I'll keep using the BIOS v4.23.
Please let me know if you have any idea about it, or if you
think it's also the IOMMU dynamic power gating BIOS issue?


Best Regards,
Johannes
