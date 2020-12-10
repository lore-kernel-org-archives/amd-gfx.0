Return-Path: <SRS0=6/kp=FO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3293CC433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 00:57:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19D7F233EF
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 00:57:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19D7F233EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=moreofthesa.me.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCF486E182;
	Thu, 10 Dec 2020 00:57:47 +0000 (UTC)
Received: from spam.moreofthesa.me.uk (moreofthesa.me.uk
 [IPv6:2001:8b0:897:1651::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 411866E183
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Dec 2020 00:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=moreofthesa.me.uk; s=201708; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7sc6KoQnme7DSMEiUqVIxMl7DS+a515r/y+p8Ou+whk=; b=c+yu6UnlFWH5GWRHPXphk3peJQ
 sQ4ZehSe5O1aNHUqOBE9TeDtxeT5mM3fftRh1OvqZcmd7V+xP8+ZFH4wlGe7KuTu5s1Tdz3UzwGQj
 xqEqwd3C1HL2R0EIwXCkuD94ASvrSgpcIZj0vIq3jgMnXAxxGoM1bslDDEsN+23SEJhtwr4tlBkQS
 nWUb7jHGk9nIFMVyQQDvSGmw3cC2RGhMa1O0z9YWty5uTGPGj1vZ4GRzGrk4yU99SNGkZyw+yOqvR
 MM5/Xk+O5wLD+POj+RkNRQ2JZ7ptRZ6fWjtaL8O5N8vbjHE12jTrWMsrOJ8iQ96iX6QBZpU5d8a7T
 7Iemx67g==;
Received: from [2001:8b0:897:1650::2] (helo=flibble.moreofthesa.me.uk)
 by spam.moreofthesa.me.uk with esmtp (Exim 4.92)
 (envelope-from <devspam@moreofthesa.me.uk>)
 id 1knAHA-0004ax-Ae; Thu, 10 Dec 2020 00:57:44 +0000
From: Darren Salt <devspam@moreofthesa.me.uk>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] amdgpu: resize BAR0 to the maximum available size,
 even if it doesn't cover VRAM
Date: Thu, 10 Dec 2020 00:57:44 +0000
Message-Id: <20201210005744.5877-1-devspam@moreofthesa.me.uk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:8b0:897:1650::2
X-SA-Exim-Mail-From: devspam@moreofthesa.me.uk
X-SA-Exim-Scanned: No (on spam.moreofthesa.me.uk);
 SAEximRunCond expanded to false
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
Cc: Darren Salt <devspam@moreofthesa.me.uk>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This allows BAR0 resizing to be done for cards which don't advertise support
for a size large enough to cover the VRAM but which do advertise at least
one size larger than the default. For example, my RX 5600 XT, which
advertises 256MB, 512MB and 1GB.

Signed-off-by: Darren Salt <devspam@moreofthesa.me.uk>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 44 +++++++++++++++++-----
 1 file changed, 35 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 355fa0057c26..ec3610b4110b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1078,6 +1078,11 @@ void amdgpu_device_wb_free(struct amdgpu_device *adev, u32 wb)
 		__clear_bit(wb, adev->wb.used);
 }
 
+static inline u32 bytes_to_size_pci(u64 bytes)
+{
+	return order_base_2(((bytes >> 20) | 1)) - 1;
+}
+
 /**
  * amdgpu_device_resize_fb_bar - try to resize FB BAR
  *
@@ -1090,20 +1095,25 @@ void amdgpu_device_wb_free(struct amdgpu_device *adev, u32 wb)
 int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
 {
 	u64 space_needed = roundup_pow_of_two(adev->gmc.real_vram_size);
-	u32 rbar_size = order_base_2(((space_needed >> 20) | 1)) - 1;
+	u32 rbar_size = bytes_to_size_pci(space_needed);
 	struct pci_bus *root;
 	struct resource *res;
+	u64 current_bytes;
+	u32 current_size;
 	unsigned i;
 	u16 cmd;
 	int r;
+	bool nospc = false;
 
 	/* Bypass for VF */
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
-	/* skip if the bios has already enabled large BAR */
-	if (adev->gmc.real_vram_size &&
-	    (pci_resource_len(adev->pdev, 0) >= adev->gmc.real_vram_size))
+	current_bytes = pci_resource_len(adev->pdev, 0);
+	current_size = bytes_to_size_pci(current_bytes);
+
+	/* Skip if the BIOS has already enabled large BAR, covering the VRAM */
+	if (current_size >= rbar_size)
 		return 0;
 
 	/* Check if the root BUS has 64bit memory resources */
@@ -1121,6 +1131,9 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
 	if (!res)
 		return 0;
 
+	dev_dbg(adev->dev, "BIOS-allocated BAR0 was %lluMB; trying to get %lluMB",
+	        current_bytes >> 20, space_needed >> 20);
+
 	/* Disable memory decoding while we change the BAR addresses and size */
 	pci_read_config_word(adev->pdev, PCI_COMMAND, &cmd);
 	pci_write_config_word(adev->pdev, PCI_COMMAND,
@@ -1133,11 +1146,24 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
 
 	pci_release_resource(adev->pdev, 0);
 
-	r = pci_resize_resource(adev->pdev, 0, rbar_size);
-	if (r == -ENOSPC)
-		DRM_INFO("Not enough PCI address space for a large BAR.");
-	else if (r && r != -ENOTSUPP)
-		DRM_ERROR("Problem resizing BAR0 (%d).", r);
+	while (rbar_size > current_size) {
+		r = pci_resize_resource(adev->pdev, 0, rbar_size);
+		if (r == 0 || r == -ENOTSUPP) {
+			break;
+		} else if (r == -ENOSPC) {
+			if (!nospc) {
+				/* Warn only the first time */
+				dev_info(adev->dev, "Not enough PCI address space for a large BAR.");
+				nospc = true;
+			}
+			--rbar_size;
+		} else if (r == -EINVAL) {
+			--rbar_size;
+		} else {
+			dev_err(adev->dev, "Problem resizing BAR0 (%d).", r);
+			break;
+		}
+	}
 
 	pci_assign_unassigned_bus_resources(adev->pdev->bus);
 
-- 
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
