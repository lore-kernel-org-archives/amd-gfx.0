Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE553C54E64
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Mar 2024 07:11:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6214310E632;
	Mon, 25 Mar 2024 07:11:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Alt9q+ta";
	dkim-atps=neutral
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E676110E62B
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Mar 2024 07:11:30 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 13F83CE0ABD;
 Mon, 25 Mar 2024 07:11:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05C10C433F1;
 Mon, 25 Mar 2024 07:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1711350687;
 bh=RYeTCQwP5u3jJ+AkUZ6LHgFtrd06l1caA0vGxdp3bhM=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=Alt9q+tawym1SyqqoG3+QMsGYWZJgANmwxp9AFI3vdUq2RwmFe7LszV6wCXfmCL04
 gNeXiSBV2JraBD3M9ikl3+OwKLNj5BURjtb2f/B1s2BWFxrL36wfliMy2fJRf3pm3e
 +7FxrHVGafniohFnc7hl//EbzU5dJJlcv1xXZIcju6daZfpS8M2z/ETtssi7R96I9q
 EFKpxTfZ83P4Sp7i+hUwmIMeT39mWgAhj37qlPAm79mS1V5cIhDGYp54/YJwxfGknk
 BMxEDK1zEWP5eBYTOFNht0LYBsfnsjK2F3j5REG0LbvZs3329wAz4I/BrXhscniuHI
 tRY9YQB+MrWdQ==
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
Subject: [PATCH 26/28] scsi: pmcraid: Use PCI_IRQ_INTX
Date: Mon, 25 Mar 2024 16:09:37 +0900
Message-ID: <20240325070944.3600338-27-dlemoal@kernel.org>
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
 drivers/scsi/pmcraid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/pmcraid.c b/drivers/scsi/pmcraid.c
index e8bcc3a88732..9c57efa10732 100644
--- a/drivers/scsi/pmcraid.c
+++ b/drivers/scsi/pmcraid.c
@@ -4033,7 +4033,7 @@ static int
 pmcraid_register_interrupt_handler(struct pmcraid_instance *pinstance)
 {
 	struct pci_dev *pdev = pinstance->pdev;
-	unsigned int irq_flag = PCI_IRQ_LEGACY, flag;
+	unsigned int irq_flag = PCI_IRQ_INTX, flag;
 	int num_hrrq, rc, i;
 	irq_handler_t isr;
 
-- 
2.44.0

