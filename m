Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33BAEC54E64
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Mar 2024 07:10:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94D7B10E60C;
	Mon, 25 Mar 2024 07:10:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MKuC+jlA";
	dkim-atps=neutral
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCFDA10E60B
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Mar 2024 07:10:44 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id AD31ECE0B17;
 Mon, 25 Mar 2024 07:10:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B558C43390;
 Mon, 25 Mar 2024 07:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1711350642;
 bh=OmWC4u7/olcC3uHIhbPfvkwAK9DJXzZPo8ow7g20qSs=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=MKuC+jlA+mRfHMfmSKKv78QSW+WSz9J7DOIRN/RSAMSOhpWl+7zovZPRm8D1DFfRm
 XLo1+8eBt88H6kz7NK0kW8rOru79NjtwH13Q1sjIpmPZY7b/Xw7qPWcpwi1FdDjLk+
 MHUjx+jflFd/Hz4PxGMWU/BK9PlUmAsDJRS4WmbSfYlAQIMwkvJp3iHiLXGcYumX+7
 ZXv8Tk87JZxkQeiE8HKqYpdXKN2/7n0Nh3aMRviPoGAI+siUgm8GQh4OTZEIvtDeav
 lKW8lr5oU/OoN1gBl4jY1H/jdkPzAr6IekdUA79mnxYFxfvL5D9suh4Zz2FAr1cEt8
 rzeYBfdQPD3wg==
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
Subject: [PATCH 14/28] net: xgbe: Use PCI_IRQ_INTX
Date: Mon, 25 Mar 2024 16:09:25 +0900
Message-ID: <20240325070944.3600338-15-dlemoal@kernel.org>
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
 drivers/net/ethernet/amd/xgbe/xgbe-pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
index f409d7bd1f1e..c5e5fac49779 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
@@ -170,7 +170,7 @@ static int xgbe_config_irqs(struct xgbe_prv_data *pdata)
 		goto out;
 
 	ret = pci_alloc_irq_vectors(pdata->pcidev, 1, 1,
-				    PCI_IRQ_LEGACY | PCI_IRQ_MSI);
+				    PCI_IRQ_INTX | PCI_IRQ_MSI);
 	if (ret < 0) {
 		dev_info(pdata->dev, "single IRQ enablement failed\n");
 		return ret;
-- 
2.44.0

