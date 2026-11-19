Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB0C606A320
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Nov 2026 19:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YtwS/WSZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A53F10F105;
	Thu, 19 Nov 2026 19:56:01 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9655410F105
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 19:55:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 594F940ABF;
 Thu, 19 Nov 2026 19:55:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CE0B1F000C4;
 Thu, 19 Nov 2026 19:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795118155;
 bh=MVqqWDbhp5V3jEmBzisBCg1Pcm0LP8OpokoRgASxL/k=;
 h=Date:From:To:Cc:Subject:In-Reply-To;
 b=YtwS/WSZ8ooDiRvR16KU3ttTNtCTGD3fy1Nl5VBvxrG0BSiiuiYdqWNphd1bYcpjG
 abMvNwEjpkyRJatY9ovhXYp0YWx4fPnGFm1/oJm0VvwBN3GrXSMbAgXNqs9nNZpwc2
 RGwoBCOg5lxCCxXmlvx9ZIQe+pO0AxMRDgMsaK0pacY+6fDcJMW4VAqacHhDBmDtPb
 imczBwNL2Fphm93K7ShSLXdKAOyMj6eiRESLccR6W7RPdbAjncQh/dZlbjwumPtK9P
 7nW5LC+84mdNLbm2GGYOOnIGgQb6uBCBW83aj7djBRNkcDXsxGpYZVvan/9SyzdiJj
 DUduflOeCkZTA==
Date: Thu, 19 Nov 2026 13:55:53 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, linux-pci@vger.kernel.org,
 amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH v8 1/3] PCI: Cache bridge firmware secondary bus number
Message-ID: <20261119195553.GA835692@bhelgaas>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261119-vfct-regression-v8-v8-1-12463194e457@amd.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 19, 2026 at 01:21:19PM -0600, Mario Limonciello wrote:
> Drivers such as amdgpu and radeon need the bus number firmware assigned
> to a device to match it against firmware tables like VFCT. The PCI core
> may renumber buses (e.g. with pci=realloc), after which the runtime
> number no longer reflects what firmware programmed.
> 
> Record the bridge's secondary bus number in its struct pci_dev when
> pci_read_bridge_windows() reads the bus number register. This happens
> once, when the bridge is first enumerated and before any renumbering,
> so the value is what firmware left at FW/OS handoff. Devices behind the
> bridge can then retrieve their firmware bus number via their upstream
> bridge.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

I assume you'll merge via DRM?

> ---
>  drivers/pci/probe.c | 1 +
>  include/linux/pci.h | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 9a178e0e5f7f4..89a7c52ac3e5b 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -513,6 +513,7 @@ static void pci_read_bridge_windows(struct pci_dev *bridge)
>  	res.flags = IORESOURCE_BUS;
>  	res.start = FIELD_GET(PCI_SECONDARY_BUS_MASK, buses);
>  	res.end = FIELD_GET(PCI_SUBORDINATE_BUS_MASK, buses);
> +	bridge->fw_sec_busnr = res.start;
>  	pci_info(bridge, "PCI bridge to %pR%s\n", &res,
>  		 bridge->transparent ? " (subtractive decode)" : "");
>  
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index aa3765a20a96c..4c1b1e557a607 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -363,6 +363,8 @@ struct pci_dev {
>  	struct pci_slot	*slot;		/* Physical slot this device is in */
>  
>  	unsigned int	devfn;		/* Encoded device & function index */
> +	/* Bridge secondary bus number at FW/OS handoff */
> +	unsigned char	fw_sec_busnr;
>  	unsigned short	vendor;
>  	unsigned short	device;
>  	unsigned short	subsystem_vendor;
> 
> -- 
> 2.43.0
> 
