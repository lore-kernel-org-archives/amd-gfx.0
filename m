Return-Path: <SRS0=NRDG=IQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17048C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Mar 2021 18:36:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9257964F1B
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Mar 2021 18:36:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9257964F1B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EAE86E171;
	Thu, 18 Mar 2021 18:36:43 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AC0F6E171
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Mar 2021 18:36:42 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id B78ED6023B;
 Thu, 18 Mar 2021 18:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616092601;
 bh=12KhgTzjW4N7bDGAzwkMoRKeIVcx9FGipQWCCmfehZ0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=qCSsMflkjZ3rm7Wq7ogNwItA6pbQGvYXdLQNh6siKBClBj2GMCw15Hq4YQQ9NzQcj
 6RoyAAtpKpqpESDo4muARn7guKGBRSe6U9+HPTTeCSa/PtGlSPPWMM84z1cgDhS9Zv
 2WDXaJym4YoX+BKN+toYAS3O3Il2KJOFN8vfVyPaKQrjnlBjeecEAmpKBbNJJv8RKJ
 53PH1QNZ7D3skGHh4tP8AEb9ojjZw0m8L4O6m2dyo3MJvJcNWlJQKCTq4TlOo1fqfV
 KY5fWap4K2gEnteRIr49JsZcyZYpvP78O73Ks6n8aPztjbYVcMfdu3+CYAyhyU24VX
 bI5DbwO+1DnGw==
Date: Thu, 18 Mar 2021 13:36:39 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH] PCI: quirks: Quirk PCI d3hot delay for AMD xhci
Message-ID: <20210318183639.GA158657@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210316192851.286563-1-alexander.deucher@amd.com>
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
Cc: Shyam-sundar.S-k@amd.com, linux-pci@vger.kernel.org, Prike.Liang@amd.com,
 amd-gfx@lists.freedesktop.org, hegel666@gmail.com, bhelgaas@google.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Mar 16, 2021 at 03:28:51PM -0400, Alex Deucher wrote:
> From: Marcin Bachry <hegel666@gmail.com>
> 
> Renoir needs a similar delay.

See https://lore.kernel.org/linux-pci/20210311125322.GA2122226@bjorn-Precision-5520/

This is becoming a problem.  We shouldn't have to merge a quirk for
every new device.  Either the devices are defective, and AMD should
publish errata and have a plan for fixing them, or Linux is broken and
we should fix that.

There are quite a few mechanisms for controlling delays like this
(Config Request Retry Status (PCIe r5.0, sec 2.3.1), Readiness
Notifications (sec 6.23), ACPI _DSM for power-on delays (PCI Firmware
Spec r3.3)), but most are for *reducing* delay, not for extending it.

Linux supports CRS, but not all the others.  Maybe we're missing
something we should support?

How do you deal with these issues for Windows?  If it works on Windows
without quirks, we should be able to make it work on Linux as well.

> Signed-off-by: Marcin Bachry <hegel666@gmail.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/pci/quirks.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 653660e3ba9e..36e5ec670fae 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -1904,6 +1904,9 @@ static void quirk_ryzen_xhci_d3hot(struct pci_dev *dev)
>  }
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x15e0, quirk_ryzen_xhci_d3hot);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x15e1, quirk_ryzen_xhci_d3hot);
> +/* Renoir XHCI requires longer delay when transitioning from D0 to
> + * D3hot */

No need for "me too" comments that add no additional information.

> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x1639, quirk_ryzen_xhci_d3hot);
>  
>  #ifdef CONFIG_X86_IO_APIC
>  static int dmi_disable_ioapicreroute(const struct dmi_system_id *d)
> -- 
> 2.30.2
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
