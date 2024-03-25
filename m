Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B01A3C54E64
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Mar 2024 07:10:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40A7F10E60B;
	Mon, 25 Mar 2024 07:10:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hfxMiJR0";
	dkim-atps=neutral
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B7F610E60B
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Mar 2024 07:10:48 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 731D6CE0EC7;
 Mon, 25 Mar 2024 07:10:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53FBAC433F1;
 Mon, 25 Mar 2024 07:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1711350645;
 bh=nyF2+f8zI4vWZZf4r2IxJ8C5vv5uk+A5vLMYxEnvgXc=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=hfxMiJR0ORogAdo8z44jgN7ImT1K3uzA7Nw2cuUg1EzJtLTSitA05+M68aV0oxeHn
 fjVG+F/o1o+iuBT9hhMLfNUs+FCbqWRDmx0vbKuRmkd1hi9uKSE1lBwZW/u3EKKhn3
 Ir5PVl2I2TiIi7c7Fax1iCnmhSowKj0rp/0Xprzd0PakkUdhVo5VzxUpbMzjH06w29
 u2m9sDcqEvvL9QLkqITXrg5MxN/YZtDEyunGNE6c9qx1ldUmSLozLe1m3MB6Lb15Nc
 s7D1BJGySQAxCz1SWn3Mxv6+TFEo+Qyg85AZHzX3Woj0NLVIJdKpi7UeRNPtSgJsht
 g00WVirSzmSvg==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>,
 linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Jaroslav Kysela <perex@perex.cz>, linux-sound@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-serial@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
 platform-driver-x86@vger.kernel.org, ntb@lists.linux.dev,
 Lee Jones <lee@kernel.org>, David Airlie <airlied@gmail.com>,
 amd-gfx@lists.freedesktop.org, Jason Gunthorpe <jgg@ziepe.ca>,
 linux-rdma@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 15/28] net: aquantia atlantic: Use PCI_IRQ_INTX
Date: Mon, 25 Mar 2024 16:09:26 +0900
Message-ID: <20240325070944.3600338-16-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240325070944.3600338-1-dlemoal@kernel.org>
References: <20240325070944.3600338-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Use the macro PCI_IRQ_INTX instead of the deprecated PCI_IRQ_LEGACY
macro. To be consistent with this change, the macros AQ_HW_IRQ_LEGACY
and AQ_CFG_FORCE_LEGACY_INT are respectively renamed to AQ_HW_IRQ_INTX
and AQ_CFG_FORCE_INTX.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/net/ethernet/aquantia/atlantic/aq_cfg.h          | 2 +-
 drivers/net/ethernet/aquantia/atlantic/aq_hw.h           | 2 +-
 drivers/net/ethernet/aquantia/atlantic/aq_nic.c          | 2 +-
 drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c     | 9 +++------
 .../net/ethernet/aquantia/atlantic/hw_atl/hw_atl_a0.c    | 2 +-
 .../net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c    | 2 +-
 drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c | 2 +-
 7 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_cfg.h b/drivers/net/ethernet/aquantia/atlantic/aq_cfg.h
index 7e9c74b141ef..fc2b325f34e7 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_cfg.h
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_cfg.h
@@ -17,7 +17,7 @@
 
 #define AQ_CFG_IS_POLLING_DEF 0U
 
-#define AQ_CFG_FORCE_LEGACY_INT 0U
+#define AQ_CFG_FORCE_INTX	0U
 
 #define AQ_CFG_INTERRUPT_MODERATION_OFF		0
 #define AQ_CFG_INTERRUPT_MODERATION_ON		1
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_hw.h b/drivers/net/ethernet/aquantia/atlantic/aq_hw.h
index dbd284660135..f010bda61c96 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_hw.h
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_hw.h
@@ -104,7 +104,7 @@ struct aq_stats_s {
 };
 
 #define AQ_HW_IRQ_INVALID 0U
-#define AQ_HW_IRQ_LEGACY  1U
+#define AQ_HW_IRQ_INTX	  1U
 #define AQ_HW_IRQ_MSI     2U
 #define AQ_HW_IRQ_MSIX    3U
 
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
index d6d6d5d37ff3..fe0e3e2a8117 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
@@ -127,7 +127,7 @@ void aq_nic_cfg_start(struct aq_nic_s *self)
 
 	cfg->irq_type = aq_pci_func_get_irq_type(self);
 
-	if ((cfg->irq_type == AQ_HW_IRQ_LEGACY) ||
+	if ((cfg->irq_type == AQ_HW_IRQ_INTX) ||
 	    (cfg->aq_hw_caps->vecs == 1U) ||
 	    (cfg->vecs == 1U)) {
 		cfg->is_rss = 0U;
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c b/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c
index baa5f8cc31f2..43c71f6b314f 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c
@@ -200,7 +200,7 @@ unsigned int aq_pci_func_get_irq_type(struct aq_nic_s *self)
 	if (self->pdev->msi_enabled)
 		return AQ_HW_IRQ_MSI;
 
-	return AQ_HW_IRQ_LEGACY;
+	return AQ_HW_IRQ_INTX;
 }
 
 static void aq_pci_free_irq_vectors(struct aq_nic_s *self)
@@ -298,11 +298,8 @@ static int aq_pci_probe(struct pci_dev *pdev,
 
 	numvecs += AQ_HW_SERVICE_IRQS;
 	/*enable interrupts */
-#if !AQ_CFG_FORCE_LEGACY_INT
-	err = pci_alloc_irq_vectors(self->pdev, 1, numvecs,
-				    PCI_IRQ_MSIX | PCI_IRQ_MSI |
-				    PCI_IRQ_LEGACY);
-
+#if !AQ_CFG_FORCE_INTX
+	err = pci_alloc_irq_vectors(self->pdev, 1, numvecs, PCI_IRQ_ALL_TYPES);
 	if (err < 0)
 		goto err_hwinit;
 	numvecs = err;
diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_a0.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_a0.c
index 9dfd68f0fda9..8de2cdd09213 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_a0.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_a0.c
@@ -352,7 +352,7 @@ static int hw_atl_a0_hw_init(struct aq_hw_s *self, const u8 *mac_addr)
 {
 	static u32 aq_hw_atl_igcr_table_[4][2] = {
 		[AQ_HW_IRQ_INVALID] = { 0x20000000U, 0x20000000U },
-		[AQ_HW_IRQ_LEGACY]  = { 0x20000080U, 0x20000080U },
+		[AQ_HW_IRQ_INTX]    = { 0x20000080U, 0x20000080U },
 		[AQ_HW_IRQ_MSI]     = { 0x20000021U, 0x20000025U },
 		[AQ_HW_IRQ_MSIX]    = { 0x20000022U, 0x20000026U },
 	};
diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c
index 54e70f07b573..56c46266bb0a 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c
@@ -562,7 +562,7 @@ static int hw_atl_b0_hw_init(struct aq_hw_s *self, const u8 *mac_addr)
 {
 	static u32 aq_hw_atl_igcr_table_[4][2] = {
 		[AQ_HW_IRQ_INVALID] = { 0x20000000U, 0x20000000U },
-		[AQ_HW_IRQ_LEGACY]  = { 0x20000080U, 0x20000080U },
+		[AQ_HW_IRQ_INTX]    = { 0x20000080U, 0x20000080U },
 		[AQ_HW_IRQ_MSI]     = { 0x20000021U, 0x20000025U },
 		[AQ_HW_IRQ_MSIX]    = { 0x20000022U, 0x20000026U },
 	};
diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
index 220400a633f5..b0ed572e88c6 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
@@ -534,7 +534,7 @@ static int hw_atl2_hw_init(struct aq_hw_s *self, const u8 *mac_addr)
 {
 	static u32 aq_hw_atl2_igcr_table_[4][2] = {
 		[AQ_HW_IRQ_INVALID] = { 0x20000000U, 0x20000000U },
-		[AQ_HW_IRQ_LEGACY]  = { 0x20000080U, 0x20000080U },
+		[AQ_HW_IRQ_INTX]    = { 0x20000080U, 0x20000080U },
 		[AQ_HW_IRQ_MSI]     = { 0x20000021U, 0x20000025U },
 		[AQ_HW_IRQ_MSIX]    = { 0x20000022U, 0x20000026U },
 	};
-- 
2.44.0

