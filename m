Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B56C0C54E64
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Mar 2024 07:10:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3588810E602;
	Mon, 25 Mar 2024 07:10:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GY1gKPZR";
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E5F810E602
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Mar 2024 07:10:35 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 9A10060DF8;
 Mon, 25 Mar 2024 07:10:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E78CFC433F1;
 Mon, 25 Mar 2024 07:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1711350634;
 bh=uemYJfVkbVnT3VEbOjmxsh3+mQZRaZbIDtHRW0buzmE=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=GY1gKPZRAXf9ZdgQhJHKYAdRIVyaivjhTfAqp0rjm5jEeHUHSkvYbVlX6bCkg2z0G
 c+AfouRXSlVFhmHkO6YV5H74VakrPvx3kHO67qBekNDAy/I1EOx3amJUFFlVLpxW9A
 c76IJOZ6HPfr+LtRlBjeiHuYE1mBG2CLG9fPOElbSdbifP0BKkmu46Nywi+P9F0ZhG
 CvNzPQZ7CnG5ep3oSDqmVuTt1s8tWX/O4INxokpOmZiQSalX7hu80yhARzi7sY/uXh
 arsVkP9kmDRd2VzXccrZDKB4BJxc++nAciV6EcNDaVndbDuuf26fyidUYv2Sqf9tL4
 6RaZopG6B219A==
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
Subject: [PATCH 12/28] infiniband: vmw_pvrdma: Use PCI_IRQ_INTX
Date: Mon, 25 Mar 2024 16:09:23 +0900
Message-ID: <20240325070944.3600338-13-dlemoal@kernel.org>
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
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
index a5e88185171f..768aad364c89 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
@@ -531,7 +531,7 @@ static int pvrdma_alloc_intrs(struct pvrdma_dev *dev)
 			PCI_IRQ_MSIX);
 	if (ret < 0) {
 		ret = pci_alloc_irq_vectors(pdev, 1, 1,
-				PCI_IRQ_MSI | PCI_IRQ_LEGACY);
+				PCI_IRQ_MSI | PCI_IRQ_INTX);
 		if (ret < 0)
 			return ret;
 	}
-- 
2.44.0

