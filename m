Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 675B8C54E58
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Mar 2024 07:11:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E784C10E629;
	Mon, 25 Mar 2024 07:11:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JL2wUzhN";
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C705610E629
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Mar 2024 07:11:16 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 4BC7C60766;
 Mon, 25 Mar 2024 07:11:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0D75C43330;
 Mon, 25 Mar 2024 07:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1711350676;
 bh=o+vS4NpqxRewriEfXhl8rc1UaUJqCGJf5AV1plDyhJ8=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=JL2wUzhNvl/Bp7YDp4iaKkQcRJhsGAuwStqDgQZ0tpcEAaydDamp+C4q5hhpb5VPa
 5xMj3T442m0tEk3xkkqioHkWJRyORcDcsF2lADUcwqfkE+hL7IU0J1VuwmcdMbWYFB
 /Ii5tITZMkbZww0PdOdxKuEYyLZw5cJ+JDZ0JcIPAbRMjkG0ydL6oLfj7J/P9pVHP6
 Hk5dxbazhntqqDTmDDKjhH/2gTkE+/uC0UrWCUF3ffT6Rhk6pCLTB6gtJkAdGraYIh
 boG4zv1S9R5thvr9/qfheLMxSmZuWhVk+Nm2/mmLfXfYIqAdgnx9QkqDrnP1l1TeqD
 o+MTGULPcm6PA==
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
Subject: [PATCH 23/28] scsi: ipr: Use PCI_IRQ_INTX
Date: Mon, 25 Mar 2024 16:09:34 +0900
Message-ID: <20240325070944.3600338-24-dlemoal@kernel.org>
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
 drivers/scsi/ipr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/ipr.c b/drivers/scsi/ipr.c
index 3819f7c42788..e0326f1e6559 100644
--- a/drivers/scsi/ipr.c
+++ b/drivers/scsi/ipr.c
@@ -9463,7 +9463,7 @@ static int ipr_probe_ioa(struct pci_dev *pdev,
 		ipr_number_of_msix = IPR_MAX_MSIX_VECTORS;
 	}
 
-	irq_flag = PCI_IRQ_LEGACY;
+	irq_flag = PCI_IRQ_INTX;
 	if (ioa_cfg->ipr_chip->has_msi)
 		irq_flag |= PCI_IRQ_MSI | PCI_IRQ_MSIX;
 	rc = pci_alloc_irq_vectors(pdev, 1, ipr_number_of_msix, irq_flag);
-- 
2.44.0

