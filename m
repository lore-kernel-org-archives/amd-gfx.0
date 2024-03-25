Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82EC3C54E64
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Mar 2024 07:10:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17BB310E5FB;
	Mon, 25 Mar 2024 07:10:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hyWih1aE";
	dkim-atps=neutral
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2DCA10E5FB
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Mar 2024 07:10:17 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 1B063CE1071;
 Mon, 25 Mar 2024 07:10:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E001DC43394;
 Mon, 25 Mar 2024 07:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1711350615;
 bh=/OcYeyGR7nBShU6EhPVo+RHG9KRcq17+M9rAUK4EZAk=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=hyWih1aEBrF5fxLDV0V7K3X3aOV9TRZTf1V6Bi5kbYHX7oexMuY0E7/Sx+c8SQDTh
 d/4dnVvriW2v5Lj5xRzzYkl9M1zajnODNQ6jcgylx6P2ZYBNPHm6gftRxMLNzVPtYc
 ijrfvXui5RyPzGBxjLHov1GbqT+koXV96+dkHf7/ZReRGiaH20mWOy9fs5Xl/uU/6S
 D/J8rLWLOIs0S8B2hNC35jNImJZ7h1x4c/QfZZW3EzDpvSyKqFJIOzCf35S9g86jC2
 c3dlzOrpO800VWpezt374Vba4a3Z5Gj+Orv3Ak8By8NusjGfQxybpKRyX/eeYcuYtC
 vLgsrYpw2VoQg==
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
Subject: [PATCH 07/28] platform: intel_ips: Use PCI_IRQ_INTX
Date: Mon, 25 Mar 2024 16:09:18 +0900
Message-ID: <20240325070944.3600338-8-dlemoal@kernel.org>
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
 drivers/platform/x86/intel_ips.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel_ips.c b/drivers/platform/x86/intel_ips.c
index ba38649cc142..73ec4460a151 100644
--- a/drivers/platform/x86/intel_ips.c
+++ b/drivers/platform/x86/intel_ips.c
@@ -1505,7 +1505,7 @@ static int ips_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	 * IRQ handler for ME interaction
 	 * Note: don't use MSI here as the PCH has bugs.
 	 */
-	ret = pci_alloc_irq_vectors(dev, 1, 1, PCI_IRQ_LEGACY);
+	ret = pci_alloc_irq_vectors(dev, 1, 1, PCI_IRQ_INTX);
 	if (ret < 0)
 		return ret;
 
-- 
2.44.0

