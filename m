Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58FE7C54E64
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Mar 2024 07:10:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBFBD10E617;
	Mon, 25 Mar 2024 07:10:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="s/+LXerr";
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1927010E617
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Mar 2024 07:10:54 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 69A6E60E0A;
 Mon, 25 Mar 2024 07:10:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D49E2C433C7;
 Mon, 25 Mar 2024 07:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1711350653;
 bh=L9+oMgTqns9sw9ne/My/DZdwn60k6w1jk+fymbaNaYE=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=s/+LXerrViBpnwV64FJRv7v83te1MPyMxomjHLvPDg/M1H1aOVEJ0hSAHGUv+riMl
 R8MjtDZABIUAZjV7OAFyndyVVnE0jRIQ6ekZMJvqX9M7y8clwA4+Xgym6OmUvDYQjK
 glW3Sc8DN/6jtzxPlP1XHWs4YyTJlY2mQBIPPu3oFiYovgLwB/sjGFQDHSBhU8Mg+6
 6lh6wernnvtghNv84/NCrQwZJKR2SFsEKwiCN49vhL84wcaGHJXGBG1EsJ/ZEFrwDY
 RsTgnbN7NI/RWAekJ1A7+P8iodcmZfevRfAssCW1980tgPJ8fJknHKzZkuYb4Yfr3c
 YS/hXzUDvbb9A==
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
Subject: [PATCH 17/28] net: realtek: r8169: Use PCI_IRQ_INTX
Date: Mon, 25 Mar 2024 16:09:28 +0900
Message-ID: <20240325070944.3600338-18-dlemoal@kernel.org>
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
 drivers/net/ethernet/realtek/r8169_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 5c879a5c86d7..7288afcc8c94 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -5076,7 +5076,7 @@ static int rtl_alloc_irq(struct rtl8169_private *tp)
 		rtl_lock_config_regs(tp);
 		fallthrough;
 	case RTL_GIGA_MAC_VER_07 ... RTL_GIGA_MAC_VER_17:
-		flags = PCI_IRQ_LEGACY;
+		flags = PCI_IRQ_INTX;
 		break;
 	default:
 		flags = PCI_IRQ_ALL_TYPES;
-- 
2.44.0

