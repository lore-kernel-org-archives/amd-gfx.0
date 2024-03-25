Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A713C54E64
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Mar 2024 07:11:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3AEE10E60D;
	Mon, 25 Mar 2024 07:11:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EQF88+Zs";
	dkim-atps=neutral
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B19F110E60D
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Mar 2024 07:10:59 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id CF49DCE0B65;
 Mon, 25 Mar 2024 07:10:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BCE5C43390;
 Mon, 25 Mar 2024 07:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1711350657;
 bh=XKJ4PdWS7sPUSp/i639lPoqRweHPQBN/JvN8m6hg+pc=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=EQF88+Zsdyl9+YqNvdRhZaeBdFtqwsmgLnRE2ZYEQO91OQDEssBs1HPYFOydw2Y/c
 q9fVT5yFUBshGdvC1nUwagh7ju47fKIHz84i+Kl0muQiajdyvAcnGrWwVPBVKT9G7i
 USMISh4UGA5PG/UwiADc9Diq32hAG2W8nPjC9IMpbUEg9z+qL+RoATwb/JLfpgPlhz
 Em6NmF8VDQuJbxefV/WmGaqGuE3aZePf4TtuO3WeiAJagXHfk082h9jsD/qBidsVoD
 6tsgfsehwBOgri2r63Ealv34YI6KGsuvwWNrnRxGVU/59jD+ALjfzcF5ZDBs0DLce0
 +1KV1UDFRbPWw==
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
Subject: [PATCH 18/28] net: wangxun: Use PCI_IRQ_INTX
Date: Mon, 25 Mar 2024 16:09:29 +0900
Message-ID: <20240325070944.3600338-19-dlemoal@kernel.org>
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
macro.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/net/ethernet/wangxun/libwx/wx_lib.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index 6dff2c85682d..ae0b940717a8 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -1674,14 +1674,14 @@ static int wx_set_interrupt_capability(struct wx *wx)
 	/* minmum one for queue, one for misc*/
 	nvecs = 1;
 	nvecs = pci_alloc_irq_vectors(pdev, nvecs,
-				      nvecs, PCI_IRQ_MSI | PCI_IRQ_LEGACY);
+				      nvecs, PCI_IRQ_MSI | PCI_IRQ_INTX);
 	if (nvecs == 1) {
 		if (pdev->msi_enabled)
 			wx_err(wx, "Fallback to MSI.\n");
 		else
-			wx_err(wx, "Fallback to LEGACY.\n");
+			wx_err(wx, "Fallback to INTX.\n");
 	} else {
-		wx_err(wx, "Failed to allocate MSI/LEGACY interrupts. Error: %d\n", nvecs);
+		wx_err(wx, "Failed to allocate MSI/INTX interrupts. Error: %d\n", nvecs);
 		return nvecs;
 	}
 
@@ -2127,7 +2127,7 @@ void wx_write_eitr(struct wx_q_vector *q_vector)
  * wx_configure_vectors - Configure vectors for hardware
  * @wx: board private structure
  *
- * wx_configure_vectors sets up the hardware to properly generate MSI-X/MSI/LEGACY
+ * wx_configure_vectors sets up the hardware to properly generate MSI-X/MSI/INTX
  * interrupts.
  **/
 void wx_configure_vectors(struct wx *wx)
-- 
2.44.0

