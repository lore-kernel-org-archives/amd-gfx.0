Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E9F6C54E64
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Mar 2024 07:10:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F17D810E5EF;
	Mon, 25 Mar 2024 07:10:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Rcvu88Ax";
	dkim-atps=neutral
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 488AB10E5EF
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Mar 2024 07:10:07 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 0A8E2CE107F;
 Mon, 25 Mar 2024 07:10:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81377C433A6;
 Mon, 25 Mar 2024 07:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1711350603;
 bh=bge2ws3KEdaftguW+pXSTaqf039X5n/M2UtisDmoU/8=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=Rcvu88Ax/T4BADtvVU2RSXDDGbN2ci5GXz8sX6akWSAefJwGB4zGbYZ0a1SYC33jI
 zE9fKLHNijw6fivZvcpvha0nydx7S6RNDLsNBmt7+8Ydlv8p5cWASGqI7Ym4+34MPS
 xeZkSxqdabnmqsLGl6mds4cJwBNfGc77zgbvYs9mknon7aIN15YoJNXbXc13a/WZOy
 FRSY+nkPMP98MhhvgIVs0kph3TjhiYkWBsGYm90FSrxoBIzYFpGarohxJ4GY+rGHMm
 OjXTUsDOe6F5tdt3a3/wAkZ+hhrZBFDx1W8oBPjy1IrIPr9eI9wgmziPuYc6UypRoc
 0XeODtLj3MV/Q==
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
Subject: [PATCH 04/28] sound: intel: Use PCI_IRQ_INTX
Date: Mon, 25 Mar 2024 16:09:15 +0900
Message-ID: <20240325070944.3600338-5-dlemoal@kernel.org>
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
 sound/soc/intel/avs/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/avs/core.c b/sound/soc/intel/avs/core.c
index d7f8940099ce..69818e4b43da 100644
--- a/sound/soc/intel/avs/core.c
+++ b/sound/soc/intel/avs/core.c
@@ -343,7 +343,7 @@ static int avs_hdac_acquire_irq(struct avs_dev *adev)
 	int ret;
 
 	/* request one and check that we only got one interrupt */
-	ret = pci_alloc_irq_vectors(pci, 1, 1, PCI_IRQ_MSI | PCI_IRQ_LEGACY);
+	ret = pci_alloc_irq_vectors(pci, 1, 1, PCI_IRQ_MSI | PCI_IRQ_INTX);
 	if (ret != 1) {
 		dev_err(adev->dev, "Failed to allocate IRQ vector: %d\n", ret);
 		return ret;
-- 
2.44.0

