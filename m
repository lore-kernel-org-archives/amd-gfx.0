Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E2F0CD11BF
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Mar 2024 07:10:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0B1310E611;
	Mon, 25 Mar 2024 07:10:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nSPzc2Tb";
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5434B10E60D
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Mar 2024 07:10:50 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id CDA3260DEA;
 Mon, 25 Mar 2024 07:10:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A7CAC43399;
 Mon, 25 Mar 2024 07:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1711350649;
 bh=82CeZhOQbJ6rbgh7yjtlPJLHhk0GT4ijOnBVaOy6U2I=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=nSPzc2Tb9CbjeS4SH754ujdqu5AOYkmi9pYGiC+52yMSsJb12CQQGvH6HOqcjluEc
 nTgCHxSGg4BP17X6liPUewIyfkzuHbAC9lX5yA9LCoNIU5wTPUO6Jp4giQFoYsSVdq
 vsO5VL+nFcXm5PoIct9t+HSS7eFbuGIbV3+PoVM35Lqi0KbfrbKkqBctgADp2mCw7g
 of2/PrKdPtBV2tPUA688yNIMnf323z0oGDXVY5ka+8rF26qQkzz2lGeyA3Okf+jFTo
 NPVEAyqSp56LeoF9RMsOCxNNaMaZitpcVAG9HSlkavbkttHENw5PMlpS1dqr62HAVK
 WZKEDdyXUfdFA==
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
Subject: [PATCH 16/28] net: atheros: alx: Use PCI_IRQ_INTX
Date: Mon, 25 Mar 2024 16:09:27 +0900
Message-ID: <20240325070944.3600338-17-dlemoal@kernel.org>
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
 drivers/net/ethernet/atheros/alx/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/atheros/alx/main.c b/drivers/net/ethernet/atheros/alx/main.c
index 49bb9a8f00e6..0dbb541155f3 100644
--- a/drivers/net/ethernet/atheros/alx/main.c
+++ b/drivers/net/ethernet/atheros/alx/main.c
@@ -901,7 +901,7 @@ static int alx_init_intr(struct alx_priv *alx)
 	int ret;
 
 	ret = pci_alloc_irq_vectors(alx->hw.pdev, 1, 1,
-			PCI_IRQ_MSI | PCI_IRQ_LEGACY);
+			PCI_IRQ_MSI | PCI_IRQ_INTX);
 	if (ret < 0)
 		return ret;
 
-- 
2.44.0

