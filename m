Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15C65C54E58
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Mar 2024 07:11:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C4AF10E625;
	Mon, 25 Mar 2024 07:11:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RjWecleT";
	dkim-atps=neutral
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E778710E625
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Mar 2024 07:11:10 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 40E33CE0EC7;
 Mon, 25 Mar 2024 07:11:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2503DC43390;
 Mon, 25 Mar 2024 07:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1711350668;
 bh=B5GsqWlQHNO5gyAGYUNoL0BzLN/ZPFlXUtFST/FBM58=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=RjWecleTKJ4gUhd6cWKMnd3A9YcWMwvl2zAC+RnU0DednLVfmKi+swr2VBY2iU/Sd
 AXPp0TIZMlJ9bx0aqj+3KPAm0lUuRignz9qlzBz9fUbYzbR2MUtOBnrX8eUl4yDBQn
 znftTMGLESwuWD1sfiZFf9XIhRZNDiDf+o+UWQUN+75pfyzqChhnsp+SdaEZyj9NNy
 5SGFxDX2IlgB/2VP/Ps3I82vOMKIOFbuTNzWwLcxJbvwr+ucIy0LTfKEJ3O9ND/D1p
 im9ZztFBTeD6z4mZnFuUY/9ikBLDDs7z5cO9XaEpceu5EcwxuWJo456k400Cj4Vl3K
 bc97J27Cy0QrQ==
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
Subject: [PATCH 21/28] scsi: arcmsr: Use PCI_IRQ_INTX
Date: Mon, 25 Mar 2024 16:09:32 +0900
Message-ID: <20240325070944.3600338-22-dlemoal@kernel.org>
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
 drivers/scsi/arcmsr/arcmsr_hba.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/arcmsr/arcmsr_hba.c b/drivers/scsi/arcmsr/arcmsr_hba.c
index ad227e6cb10e..35860c61468b 100644
--- a/drivers/scsi/arcmsr/arcmsr_hba.c
+++ b/drivers/scsi/arcmsr/arcmsr_hba.c
@@ -1007,7 +1007,7 @@ arcmsr_request_irq(struct pci_dev *pdev, struct AdapterControlBlock *acb)
 				goto msi_int1;
 			}
 		}
-		nvec = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_LEGACY);
+		nvec = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_INTX);
 		if (nvec < 1)
 			return FAILED;
 msi_int1:
-- 
2.44.0

