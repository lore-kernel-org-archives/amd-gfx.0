Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7141C54E58
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Mar 2024 07:11:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2116910E62B;
	Mon, 25 Mar 2024 07:11:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eeMcew6/";
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FC4610E62B
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Mar 2024 07:11:32 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 9BB6960DE9;
 Mon, 25 Mar 2024 07:11:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1C3AC43394;
 Mon, 25 Mar 2024 07:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1711350691;
 bh=5yQ78yVVRx+BuSskjbXQyqGSxUtm8XGzf7kDWOz8oig=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=eeMcew6/36/+XrXV08/jTwz0Ah2T5VgTl9A7CIaoDpVgORmOu0zoxCnETHOKnyaws
 Jk6feyJmSEUva6kk1jBLhr3pFxKXIPS1esND8Y759MGG4528vj/7q3vwm4iP7prfAi
 85Lv7BZt8Xpn/MIX/xteBH2QDoK3HsIqofUmCiCCZaZ4b5V9ms5HZsVz1xL4k1C10T
 H8qcGuaFQjKd3U1++f+oqYXy4jRB1+cBHKsoY7bijIdbIqu0+clyNcUygZX8SRjMpM
 uCERTsbc5H9s0FyGqDeXjwv9/OQCAUdX0ilXktf5p6NMQS7qDGDZ2yXERmZxhsHcjJ
 CQRqEat8PcQRQ==
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
Subject: [PATCH 27/28] scsi: vmw_pvscsi: Do not use PCI_IRQ_LEGACY
Date: Mon, 25 Mar 2024 16:09:38 +0900
Message-ID: <20240325070944.3600338-28-dlemoal@kernel.org>
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

In pvscsi_probe(), initialize the irq_flag variable using
PCI_IRQ_ALL_TYPES to remove the use of the deprecated PCI_IRQ_LEGACY
macro.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/scsi/vmw_pvscsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/vmw_pvscsi.c b/drivers/scsi/vmw_pvscsi.c
index f88ecdb93a8a..c4fea077265e 100644
--- a/drivers/scsi/vmw_pvscsi.c
+++ b/drivers/scsi/vmw_pvscsi.c
@@ -1346,7 +1346,7 @@ static u32 pvscsi_get_max_targets(struct pvscsi_adapter *adapter)
 
 static int pvscsi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
-	unsigned int irq_flag = PCI_IRQ_MSIX | PCI_IRQ_MSI | PCI_IRQ_LEGACY;
+	unsigned int irq_flag = PCI_IRQ_ALL_TYPES;
 	struct pvscsi_adapter *adapter;
 	struct pvscsi_adapter adapter_temp;
 	struct Scsi_Host *host = NULL;
-- 
2.44.0

