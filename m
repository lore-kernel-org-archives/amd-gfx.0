Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C388C54E58
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Mar 2024 07:11:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89CCB10E627;
	Mon, 25 Mar 2024 07:11:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="q/LGWM1B";
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA00110E62A
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Mar 2024 07:11:20 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 608BD60DEF;
 Mon, 25 Mar 2024 07:11:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66983C43394;
 Mon, 25 Mar 2024 07:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1711350679;
 bh=bD3pn7waGVyabrrIrvOuivhv+kWsQE+KY0AsrDgUOwM=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=q/LGWM1B7C6oEXzLyn0OvSQrW0mAYOU7gObAFz+pNpqU7TWGiohm0kB2VOYMbAp6G
 8XerHyhTXQ9lBuR1SvmU75R8uPyT300T1voZ4MRUXX78O32A4ws5P54ycc9hiEZIu0
 iUGVY7pgXel5vb3yTJwmRm6sWrCF/joWvrZ5l/WPDwMwk4LzxA7JOuYTN//zUArb7g
 Y5wwkRJBoJzSHlvM+90D35vHdP3cURyOeeYh4pljIZMKS4MGe4Z0edJl9+FOmBqN2+
 1WNTb0dt7g+Qn2dYT0ZKSF7O5EZTCeifqWePGiAULS55uHgPhdxNsr7So3C4RV8Kul
 lh45KDw/hcAFg==
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
Subject: [PATCH 24/28] scsi: megaraid: Use PCI_IRQ_INTX
Date: Mon, 25 Mar 2024 16:09:35 +0900
Message-ID: <20240325070944.3600338-25-dlemoal@kernel.org>
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
 drivers/scsi/megaraid/megaraid_sas_base.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 3d4f13da1ae8..631a24d91fa9 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -6300,7 +6300,7 @@ static int megasas_init_fw(struct megasas_instance *instance)
 	}
 
 	if (!instance->msix_vectors) {
-		i = pci_alloc_irq_vectors(instance->pdev, 1, 1, PCI_IRQ_LEGACY);
+		i = pci_alloc_irq_vectors(instance->pdev, 1, 1, PCI_IRQ_INTX);
 		if (i < 0)
 			goto fail_init_adapter;
 	}
@@ -7839,7 +7839,7 @@ megasas_resume(struct device *dev)
 
 	if (!instance->msix_vectors) {
 		rval = pci_alloc_irq_vectors(instance->pdev, 1, 1,
-					     PCI_IRQ_LEGACY);
+					     PCI_IRQ_INTX);
 		if (rval < 0)
 			goto fail_reenable_msix;
 	}
-- 
2.44.0

