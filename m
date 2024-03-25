Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22B7AC54E58
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Mar 2024 07:09:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8240B10E5E8;
	Mon, 25 Mar 2024 07:09:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nlLsGMZ2";
	dkim-atps=neutral
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2F7C10E5E8
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Mar 2024 07:09:55 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 5F30DCE0B17;
 Mon, 25 Mar 2024 07:09:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 481CBC43394;
 Mon, 25 Mar 2024 07:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1711350592;
 bh=fgNYRUWQ1ehKxth4W+tPpNo5aTyrEzS0AG45mdCeF+8=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=nlLsGMZ2Nh1cmWZviNXNJCoreXfnZJbu/HHZ5lA3BMPBMNWQKCda07SFBYqYhojiW
 fVZSiiPSSgYzid9Z+ET8AaD/7NA3ZpksRz0tid4Zbt+pwN2P6b2h3LawbPRcs03yPg
 QoSyFngv2VBgv17tj1gF7yCPHd5J3L5PnRgyE13/PYW6ku+qY19ZNJYClUXzgUc8/h
 c9d2WErzPC3zdyVm8IA7SZxCmmndh+BTOzvXXha8YlvWjcMTxTYUWp2zKalOq8Q467
 hjGn63aTCi2DWOPTiWtV45L+Y/i6QK7e2kF4i/AQbLg8riS7vdPwlVzsUx1VuQ5Ypb
 nyRI/JDRgUqXA==
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
Subject: [PATCH 01/28] PCI: msi: Use PCI_IRQ_INTX
Date: Mon, 25 Mar 2024 16:09:12 +0900
Message-ID: <20240325070944.3600338-2-dlemoal@kernel.org>
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

In pci_alloc_irq_vectors_affinity(), use the macro PCI_IRQ_INTX instead
of the now deprecated PCI_IRQ_LEGACY macro.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/pci/msi/api.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/msi/api.c b/drivers/pci/msi/api.c
index be679aa5db64..dfba4d6dd535 100644
--- a/drivers/pci/msi/api.c
+++ b/drivers/pci/msi/api.c
@@ -213,8 +213,8 @@ EXPORT_SYMBOL(pci_disable_msix);
  *            * %PCI_IRQ_MSIX      Allow trying MSI-X vector allocations
  *            * %PCI_IRQ_MSI       Allow trying MSI vector allocations
  *
- *            * %PCI_IRQ_LEGACY    Allow trying legacy INTx interrupts, if
- *              and only if @min_vecs == 1
+ *            * %PCI_IRQ_INTX      Allow trying INTx interrupts, if and
+ *              only if @min_vecs == 1
  *
  *            * %PCI_IRQ_AFFINITY  Auto-manage IRQs affinity by spreading
  *              the vectors around available CPUs
@@ -279,8 +279,8 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
 			return nvecs;
 	}
 
-	/* use legacy IRQ if allowed */
-	if (flags & PCI_IRQ_LEGACY) {
+	/* use INTx IRQ if allowed */
+	if (flags & PCI_IRQ_INTX) {
 		if (min_vecs == 1 && dev->irq) {
 			/*
 			 * Invoke the affinity spreading logic to ensure that
-- 
2.44.0

