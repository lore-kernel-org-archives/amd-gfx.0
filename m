Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1232CA9EC8
	for <amd-gfx@archiver.kernel.org>; Sat, 10 Oct 2026 12:38:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BC5610EBE9;
	Sat, 10 Oct 2026 12:37:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="h62DOo3Q";
	dkim-atps=neutral
X-Greylist: delayed 365 seconds by postgrey-1.36 at gabe;
 Fri, 09 Oct 2026 19:26:52 UTC
Received: from mta1.migadu.com (out-15.mta1.migadu.com [95.215.58.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 536F411227B
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Oct 2026 19:26:52 +0000 (UTC)
X-Envelope-To: amd-gfx@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=oOwGbuDH4is48yWx6pl2bm046cUQPMcDmLWPHdbtGuM=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791574010; v=1; x=1792178810;
 b=h62DOo3Q4wB+dPAOaUeHNrrAZg0VZZEeCP6j+vEUzKZpKW0nnzTj1HsB82tYwBsls54MOaQH
 4tbCRwpPaHIA5yqDuukizfkXObBZMMkl0tRnFSe9S2b7lVpkqE5ZYsoNBfKFSTdq1p5Ke3N5dHv
 TuLB6Vq6HVe8sPfEw+6v6Klk=
X-Envelope-To: amd-gfx@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id 7f7139aa950e2d35;
 Fri, 09 Oct 2026 19:20:36 +0000
X-Mizu-Trace-ID: 7f7139aa950e2d35
X-Migadu-Flow: FLOW_OUT
Message-ID: <497eb268-656f-49ab-8df0-83ede5b36a81@linux.dev>
Date: Sat, 10 Oct 2026 00:50:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-linus] PCI/AER: Skip error recovery on false alarms
To: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Alex Deucher <alexdeucher@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>,
 Vitaly Prosyak <vitaly.prosyak@amd.com>, amd-gfx@lists.freedesktop.org,
 Jason Perlow <jperlow@gmail.com>,
 Thorsten Leemhuis <regressions@leemhuis.info>
References: <0552ed277e40a288e0157af799257ee6ec722534.1791460615.git.lukas@wunner.de>
 <20261008191705.GA917105@bhelgaas> <ash0Rn78gwlQ87Fg@wunner.de>
Content-Language: en-US
From: Aditya Garg <aditya.garg@linux.dev>
In-Reply-To: <ash0Rn78gwlQ87Fg@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Sat, 10 Oct 2026 12:37:50 +0000
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

Hi

> I think the firmware on the T2 is upgradable in principle, but Apple isn't
> going to do us the favor to fix it.  So we don't have any other option
> than keeping a blacklist for ANFE-incompatible devices, with the T2 being
> the first device on that blacklist and maybe others to follow.
> 
> I was going to work on this for the remainder of the week, but if you feel
> the feature needs another cycle to mature, I have no objections to
> reverting eddba19b8b5f for v7.3 and re-applying it together with the two
> required fixes to pci/aer.  (The two required fixes being the one for Alex
> and the one for the T2.)
> 
> Thanks,
> 
> Lukas

It would be nice if someone could test this patch:

-->8--

From 88c681d745931ad8b0199a490dc0278bf2a3df9b Mon Sep 17 00:00:00 2001
From: Aditya Garg <aditya.garg@linux.dev>
Date: Fri, 9 Oct 2026 19:17:02 +0000
Subject: [PATCH] Quirk

---
 drivers/pci/pcie/aer.c  |  3 ++-
 drivers/pci/quirks.c    | 12 ++++++++++++
 include/linux/pci.h     |  1 +
 include/linux/pci_ids.h |  1 +
 4 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 922a726a5..cab195f7c 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -428,7 +428,8 @@ void pci_aer_init(struct pci_dev *dev)
 	 * Advisory Non-Fatal Errors are masked by default (PCIe r7.0, sec
 	 * 7.8.4.6).
 	 */
-	if (pcie_aer_is_native(dev) && dev->devcap & PCI_EXP_DEVCAP_RBER)
+	if (pcie_aer_is_native(dev) && dev->devcap & PCI_EXP_DEVCAP_RBER &&
+		!dev->no_aer_anfe)
 		pci_clear_and_set_config_dword(dev,
 					       dev->aer_cap + PCI_ERR_COR_MASK,
 					       PCI_ERR_COR_ADV_NFAT, 0);
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index de9bbccda..acca89532 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6422,4 +6422,16 @@ static void pci_mask_replay_timer_timeout(struct pci_dev *pdev)
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9750, pci_mask_replay_timer_timeout);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9755, pci_mask_replay_timer_timeout);
+
+/*
+ * Unmasking Advisory Non-Fatar Errors on Apple T2 Secure Enclave
+ * processor leads to the Mac shutting down spontaneously. Avoid
+ * doing that.
+ */
+static void quirk_no_aer_anfe(struct pci_dev *dev)
+{
+	dev->no_aer_anfe = 1;
+}
+
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_APPLE, PCI_DEVICE_ID_APPLE_T2_SEP, quirk_no_aer_anfe);
 #endif
diff --git a/include/linux/pci.h b/include/linux/pci.h
index d31a8d107..83ffa5058 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -514,6 +514,7 @@ struct pci_dev {
 	unsigned int	rom_bar_overlap:1;	/* ROM BAR disable broken */
 	unsigned int	rom_attr_enabled:1;	/* Display of ROM attribute enabled? */
 	unsigned int	non_mappable_bars:1;	/* BARs can't be mapped by CPU or peers */
+	unsigned int	no_aer_anfe:1;		/* Don't unmask */
 	pci_dev_flags_t dev_flags;
 	atomic_t	enable_cnt;	/* pci_enable_device has been called */
 
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 63774ae2b..103024f74 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -1007,6 +1007,7 @@
 #define PCI_DEVICE_ID_APPLE_IPID2_FW	0x006a
 #define PCI_DEVICE_ID_APPLE_IPID2_GMAC	0x006b
 #define PCI_DEVICE_ID_APPLE_TIGON3	0x1645
+#define PCI_DEVICE_ID_APPLE_T2_SEP	0x1802
 
 #define PCI_VENDOR_ID_YAMAHA		0x1073
 #define PCI_DEVICE_ID_YAMAHA_724	0x0004
-- 
2.55.0

-->8--

