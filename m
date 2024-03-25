Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2669C54E64
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Mar 2024 07:11:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44DF610E628;
	Mon, 25 Mar 2024 07:11:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ry+C4Hn2";
	dkim-atps=neutral
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA49D10E628
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Mar 2024 07:11:14 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 02D73CE0ABD;
 Mon, 25 Mar 2024 07:11:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEE30C433F1;
 Mon, 25 Mar 2024 07:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1711350672;
 bh=Na+D4oMLZVbeAYKzO6JgJaOnxkPP6UKJ/rpViZ9Dd7M=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=Ry+C4Hn2LzihQS6aYeJ2us7Evgo4Rcnoav8aCG4rO5oqgbYGqkMQGQOqvQ76zyHxY
 R18tc3jQCXE+LxzXXE5wVGg6G/Yz7afT7zHmbGvLab/rp03sQMtPZvNsiIqupEz4Ng
 wsnnhELGkBqpxX99HZvrwxTu18C68MYp64XQk7/8OSrhSdTQ00/ZccRJix7EKbzX7A
 KYz/SpO6SkqDUJjeh3MUmXhDEq0muyvCg5h9hjhksm69DGS+ZcIAfHIKgwn/J88zIW
 CinynW/pKAGvs4PekUCV0PxoLlvFl/rJEtlhHSKj9krwRn+nCIaroYHtEkCGT7NAfi
 wZTWoG27mOeJQ==
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
Subject: [PATCH 22/28] scsi: hpsa: Use PCI_IRQ_INTX
Date: Mon, 25 Mar 2024 16:09:33 +0900
Message-ID: <20240325070944.3600338-23-dlemoal@kernel.org>
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
 drivers/scsi/hpsa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index af18d20f3079..23b19fa30661 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -7509,7 +7509,7 @@ static void hpsa_setup_reply_map(struct ctlr_info *h)
  */
 static int hpsa_interrupt_mode(struct ctlr_info *h)
 {
-	unsigned int flags = PCI_IRQ_LEGACY;
+	unsigned int flags = PCI_IRQ_INTX;
 	int ret;
 
 	/* Some boards advertise MSI but don't really support it */
-- 
2.44.0

