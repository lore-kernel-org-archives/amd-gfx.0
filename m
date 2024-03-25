Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F864C54E64
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Mar 2024 07:11:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7634210E61F;
	Mon, 25 Mar 2024 07:11:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JFHyCT7W";
	dkim-atps=neutral
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96ADB10E61F
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Mar 2024 07:11:07 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id B5FB0CE1079;
 Mon, 25 Mar 2024 07:11:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB58C433C7;
 Mon, 25 Mar 2024 07:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1711350664;
 bh=sTPATJrZxPXDBU2hJVRgbRVp2puDXDGSZp/6Anb2ra0=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=JFHyCT7W6X1xUcGVlMTa9iTr+w72NzubImHdd/0DveOX+7NhWajlvvcfrjrxl60sS
 KkT921c4aSXDeZslfjxdIPIMprZCkYQPpxVcNU/yL7f/aDwrf4GrjNM9dKSG4W7uf3
 fMe50RzV4tc7wWOXO8P9bQbN+3SGEfKS8ayLJFCI50/a9rODs8i3qKiGSlk9MMMkPB
 ql92SAegznSMyE4yCvrW46M/kA2pNYT9yKzBJ4gpVUp+bCC5n+ZHDYRggqrf8dTsld
 nLGac3hxSgAWlW+LOGDkAuqUhlzjavo07M+c+jV9WprXJ6qpPlWdGjC29JjHhDZ8aR
 45GG63jK43Sig==
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
Subject: [PATCH 20/28] net wireless; realtec: Use PCI_IRQ_INTX
Date: Mon, 25 Mar 2024 16:09:31 +0900
Message-ID: <20240325070944.3600338-21-dlemoal@kernel.org>
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
 drivers/net/wireless/realtek/rtw88/pci.c | 2 +-
 drivers/net/wireless/realtek/rtw89/pci.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index 9986a4cb37eb..282f1e5a882e 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -1612,7 +1612,7 @@ static struct rtw_hci_ops rtw_pci_ops = {
 
 static int rtw_pci_request_irq(struct rtw_dev *rtwdev, struct pci_dev *pdev)
 {
-	unsigned int flags = PCI_IRQ_LEGACY;
+	unsigned int flags = PCI_IRQ_INTX;
 	int ret;
 
 	if (!rtw_disable_msi)
diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 19001130ad94..100549694e53 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -3547,7 +3547,7 @@ static int rtw89_pci_request_irq(struct rtw89_dev *rtwdev,
 	unsigned long flags = 0;
 	int ret;
 
-	flags |= PCI_IRQ_LEGACY | PCI_IRQ_MSI;
+	flags |= PCI_IRQ_INTX | PCI_IRQ_MSI;
 	ret = pci_alloc_irq_vectors(pdev, 1, 1, flags);
 	if (ret < 0) {
 		rtw89_err(rtwdev, "failed to alloc irq vectors, ret %d\n", ret);
-- 
2.44.0

