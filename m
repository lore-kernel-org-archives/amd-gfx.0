Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF1C606A31D
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2026 14:27:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 544D011283F;
	Fri, 30 Oct 2026 14:27:35 +0000 (UTC)
Received: from mail.sig21.net (mail.sig21.net [217.197.84.222])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBF0210E87E
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2026 10:03:46 +0000 (UTC)
Received: from localhorst ([127.0.0.1]) by mail.sig21.net with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.96) (envelope-from <js@sig21.net>) id 1xMjGL-0007HB-1P ;
 Fri, 30 Oct 2026 11:03:41 +0100
Received: from js by abc.local with local (Exim 4.100.1)
 (envelope-from <js@sig21.net>) id 1xMjSW-0000000045d-3wnL;
 Fri, 30 Oct 2026 11:03:40 +0100
Date: Fri, 30 Oct 2026 11:03:40 +0100
From: Johannes Stezenbach <js@sig21.net>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
Subject: Re: amdgpu causes boot failure after BIOS update AGESA ComboAM5
 1.3.0.1a on Asrock X600
Message-ID: <auRrfMntlpc6rGhK@sig21.net>
References: <ar-GzWfyQMeRTRCt@sig21.net>
 <CADnq5_ODecWYOwbBYDnV-aeAi+pCMoxJvufuzY8_4yf5cF0dEg@mail.gmail.com>
 <2b4560f5-3458-4218-89f7-509c298b2126@amd.com>
 <asAFItSKC74Lm9mT@sig21.net> <atCaRZrxxcz4xRje@sig21.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atCaRZrxxcz4xRje@sig21.net>
X-Mailman-Approved-At: Fri, 30 Oct 2026 14:27:34 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 15, 2026 at 11:17:57AM +0200, Johannes Stezenbach wrote:
> On Fri, Oct 02, 2026 at 09:25:22PM +0200, Johannes Stezenbach wrote:
> > However, my self-built kernel still crashes early after I changed
> > amdgpu to be a loadable module. So there is something else going
> > on, but lets concentrate on the andgpu failure with the Debian kernel.
> 
> I was able to resolve this. I went through my kernel config and
> compared to Debian's and found the following suspicious
> configurations that had worked with previous BIOS v4.14:
> 
> CONFIG_PCIEASPM_POWER_SUPERSAVE (should be CONFIG_PCIEASPM_DEFAULT)
> CONFIG_EFI_DISABLE_PCI_DMA
> CONFIG_EFI_DISABLE_RUNTIME
> 
> After disabling them my kernel can boot and runs stable.

So I thought. But I had also enabled EFI_STUB because the
Debian kernel had it, but it causes "failed to unprotect
memory range at..." messages. Thus now after kernel upgrade
to 7.2.13 I disabled it -> can't boot.
Setting this is needed with BIOS v4.23:

CONFIG_EFI_STUB=y
CONFIG_EFI_HANDOVER_PROTOCOL=y  (maybe, =n not tested)


Johannes
