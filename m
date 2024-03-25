Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3987FC54E58
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Mar 2024 07:11:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6C3110E62A;
	Mon, 25 Mar 2024 07:11:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PKc7/4Uc";
	dkim-atps=neutral
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D17E10E62A
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Mar 2024 07:11:26 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 5B9E1CE0B17;
 Mon, 25 Mar 2024 07:11:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28D4BC43390;
 Mon, 25 Mar 2024 07:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1711350683;
 bh=8d2fWq2KAGH9je3NZwkO0VjFD2jmAuDLY6ejwNE42qU=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=PKc7/4UcIGtVMn8cCV2sp+5jLJE31bILPthP+vMkJ6r4rFbdpzFzbRFeMiFcmspCm
 QHZKsCmuwUoqbTAf/joPq5J21aikBcS9L2F40l1UyvYIQldVySHYGxBBWaIgc7jem5
 pANyiH7dyHya+ExZLCSbl5Y1Mt7WJcUBw9lrhkXWL3+7trs4gi8yykJL63S6EKqGMb
 72TuZwd6CSGVjWGcJRwS5H6Z7d0q9ghopxNmHGBnDBwTCWBEvnTj7LcC/3diwsHlJ5
 OMHBUmTP3eG7afDk4Ipu/K2XdPKLaxfpCzXFE0lggNj86xNV9DKAuGIIeHuDq7Z2+K
 Sa0FYl2fXnhHA==
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
Subject: [PATCH 25/28] scsi: mpt3sas: Use PCI_IRQ_INTX
Date: Mon, 25 Mar 2024 16:09:36 +0900
Message-ID: <20240325070944.3600338-26-dlemoal@kernel.org>
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
 drivers/scsi/mpt3sas/mpt3sas_base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 1b492e9a3e55..40f6f87428d5 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -3515,7 +3515,7 @@ _base_enable_msix(struct MPT3SAS_ADAPTER *ioc)
 	ioc_info(ioc, "High IOPs queues : disabled\n");
 	ioc->reply_queue_count = 1;
 	ioc->iopoll_q_start_index = ioc->reply_queue_count - 0;
-	r = pci_alloc_irq_vectors(ioc->pdev, 1, 1, PCI_IRQ_LEGACY);
+	r = pci_alloc_irq_vectors(ioc->pdev, 1, 1, PCI_IRQ_INTX);
 	if (r < 0) {
 		dfailprintk(ioc,
 			    ioc_info(ioc, "pci_alloc_irq_vector(legacy) failed (r=%d) !!!\n",
-- 
2.44.0

