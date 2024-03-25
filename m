Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ECF8C54E64
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Mar 2024 07:10:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0E4310E5F9;
	Mon, 25 Mar 2024 07:10:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZssjjmZV";
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58E2C10E5F9
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Mar 2024 07:10:12 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id C58FD60DEF;
 Mon, 25 Mar 2024 07:10:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E31EC43390;
 Mon, 25 Mar 2024 07:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1711350611;
 bh=Ob+fZgzFxcE9wTSVWNWVKgYEP0VNmwg/dyGtefu3nb4=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=ZssjjmZVDRmf/cKWuqrUJCCoGRf8DjhmxDd61XMz9XVtI/KQyNpKe5/j2TfAnroy/
 Sf+5rUBcHgmRkOyQx3F+j5s3GR484tRyUucokjtIxKpm5l4ajb4g8N1vC5nlY0v6nr
 5zRexkjs3n00maX+dSVIdKqwxDGF4jVbQTkltPZHkBaegx++WyJft/S1rKxUbeH2Fi
 lPpgZhvKhUvfuFWdNh2pvCrlNZ8DZI07wwKzc7E4V+hKlPUowOcBx1nnrVj2Lu9xUL
 pskMGlroIo1rXIkad1Sg5w8mD2aLfXhwcAhAkKS+6Np8s0ldpLcddg2XFcibCoaNIU
 CPb/KwrHTOlcQ==
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
Subject: [PATCH 06/28] tty: 8250_pci: Use PCI_IRQ_INTX
Date: Mon, 25 Mar 2024 16:09:17 +0900
Message-ID: <20240325070944.3600338-7-dlemoal@kernel.org>
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
 drivers/tty/serial/8250/8250_pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 0d35c77fad9e..400b16c0336c 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -4108,7 +4108,7 @@ pciserial_init_ports(struct pci_dev *dev, const struct pciserial_board *board)
 			rc = pci_alloc_irq_vectors(dev, 1, 1, PCI_IRQ_ALL_TYPES);
 		} else {
 			pci_dbg(dev, "Using legacy interrupts\n");
-			rc = pci_alloc_irq_vectors(dev, 1, 1, PCI_IRQ_LEGACY);
+			rc = pci_alloc_irq_vectors(dev, 1, 1, PCI_IRQ_INTX);
 		}
 		if (rc < 0) {
 			kfree(priv);
-- 
2.44.0

