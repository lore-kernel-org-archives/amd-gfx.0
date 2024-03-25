Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADAEEC54E64
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Mar 2024 07:10:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2700E10E5FD;
	Mon, 25 Mar 2024 07:10:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XUpBhcU4";
	dkim-atps=neutral
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7611B10E601
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Mar 2024 07:10:29 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 7BC91CE0ABD;
 Mon, 25 Mar 2024 07:10:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56255C433C7;
 Mon, 25 Mar 2024 07:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1711350626;
 bh=BOO5AFiKarAvKdN17nScbLEokRrc/g2D/BQM9yhP4d4=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=XUpBhcU4GiganFQWfcpsbaYVp+TsJUR7YCqoseHr5vZC0zMb+B2R5tSiJS9wEGs5i
 l26JyR1LurvCl22zfC9wlGhYjNiqb1/jW6GwMWiXDulr1ECjCaxKJ8GHElD9typr/r
 xIr9JRV3OtQWryAMUNEdkuaH/PTVfMxSpYdbaTtPW3CyrD74V8fYHhcIYa/M5LDqsC
 ilHVHSVTcdeMBjMzZvGW1r4QgrqqyC+auJ1ZQKC5IZwmlSEfiTLs6V3c2PDFCco7c7
 cHziWs6eB2Saz+fTKwatFYcm6UIv455fJxW0zdPpbBvMfjw0aFu6iR2GhrSOelQsk7
 nY5UqTzGjEMoQ==
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
Subject: [PATCH 10/28] drm: amdgpu: Use PCI_IRQ_INTX
Date: Mon, 25 Mar 2024 16:09:21 +0900
Message-ID: <20240325070944.3600338-11-dlemoal@kernel.org>
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index 7e6d09730e6d..d18113017ee7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -279,7 +279,7 @@ int amdgpu_irq_init(struct amdgpu_device *adev)
 	adev->irq.msi_enabled = false;
 
 	if (!amdgpu_msi_ok(adev))
-		flags = PCI_IRQ_LEGACY;
+		flags = PCI_IRQ_INTX;
 	else
 		flags = PCI_IRQ_ALL_TYPES;
 
-- 
2.44.0

