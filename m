Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6101CA9EDE
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Oct 2026 07:42:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70F2610EF07;
	Mon, 12 Oct 2026 07:42:52 +0000 (UTC)
Received: from mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9DDA10E26D
 for <amd-gfx@lists.freedesktop.org>; Sat, 10 Oct 2026 17:24:38 +0000 (UTC)
X-Envelope-To: amd-gfx@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=+bmvvBpu1/q/Geae+t+01frY+TdKdwgirUCbYdQH1rA=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791653076; v=1; x=1792257876;
 b=H8JvJezBmj91KgQeJvWz8QbVJOezeCVJZuKrQ/dYIJSTcou7sCUNJFZm/fj+afMozjgPMZfS
 PnwjXNayrObd5m7qzg28qGtGzH0sJGn4Nz9JIlrdJAGa/Az8wsPlCke3Qs4PqOOFdokARLZtJ7S
 bipdZeKJq+TNFRWTqY/kxlpA=
X-Envelope-To: amd-gfx@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id 84d4c3e66e47ae57;
 Sat, 10 Oct 2026 17:23:33 +0000
X-Mizu-Trace-ID: 84d4c3e66e47ae57
X-Migadu-Flow: FLOW_OUT
From: Aditya Garg <aditya.garg@linux.dev>
To: Bjorn Helgaas <helgaas@kernel.org>,
	linux-pci@vger.kernel.org
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Alex Deucher <alexdeucher@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>,
 Vitaly Prosyak <vitaly.prosyak@amd.com>, amd-gfx@lists.freedesktop.org,
 Lukas Wunner <lukas@wunner.de>, Jason Perlow <jperlow@gmail.com>
Subject: [PATCH for-linus] PCI/AER: Skip unmasking Advisory Non-Fatal Errors
 on T2 SEP
Date: Sat, 10 Oct 2026 22:53:01 +0530
Message-ID: <20261010172301.12764-1-aditya.garg@linux.dev>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 12 Oct 2026 07:42:49 +0000
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

Jason reported that since commit eddba19b8b5f ("PCI/AER: Support Advisory
Non-Fatal Errors"), the Macs with Apple T2 Security Chip were powering
off a few seconds after every boot. He also found the PCI Device
106b:1802, which corresponds to the Apple T2 Secure Enclave Processor was
misbehaving and the most likely reason is that the device is ANFE
incompatible due to Apple's custom hardware.

Since its highly unlikely that Apple will release a firmware update to
support ANFE, introduce a quirk as suggested by Lukas to blacklist the T2
SEP from ANFE.

Fixes: eddba19b8b5f ("PCI/AER: Support Advisory Non-Fatal Errors")
Reported-by: Jason Perlow <jperlow@gmail.com>
Tested-by: Jason Perlow <jperlow@gmail.com>
Closes: https://lore.kernel.org/linux-pci/CABZrw2HcaOh3DHTJtxU5dXrb3Vg19scr6+qR-xe_+R7rME35_Q@mail.gmail.com/
Signed-off-by: Aditya Garg <aditya.garg@linux.dev>
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
+ * Unmasking Advisory Non-Fatal Errors on Apple T2 Secure Enclave
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
+	unsigned int	no_aer_anfe:1;		/* Don't unmask Advisory Non-Fatal Errors */
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

