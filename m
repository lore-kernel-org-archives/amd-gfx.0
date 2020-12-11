Return-Path: <SRS0=QenQ=FP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B07C4361B
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Dec 2020 00:55:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0076F23DB4
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Dec 2020 00:55:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0076F23DB4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=moreofthesa.me.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 882B86E5BB;
	Fri, 11 Dec 2020 00:55:10 +0000 (UTC)
Received: from spam.moreofthesa.me.uk (moreofthesa.me.uk
 [IPv6:2001:8b0:897:1651::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69B816E5B0
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Dec 2020 00:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=moreofthesa.me.uk; s=201708; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=f96+cvqLZUZBm6xYz+5nz2YWhUApEuZxeZxIGr9NsFU=; b=tNussu2ybxbleY7tV+GOHA2i+J
 gFughCBRD5IZhRzMjaoIow8vruxCdB6TeAv4WRCkWSZK0pDEG73CKKIP++x1ynrN+ENvFfnbTzMFs
 ewYemv6ljT9rDn5v1qmsd03pMyd81KuN76zTBdekYbkF3HF8rMv7kQWytn1VDDWl1b6Ul4golFeb6
 ATWKCEIKJfrPF46c4l1+TqK9Kb88E5Y6S4KkbcGFgSf8MyWxdO75Dm6kYZMGoCC306sSfXv/bxkms
 JQ++pTl1VyFIhDd6FNOLdiIVIUJAlm+oiMoWoZMYhW64Cv2BsptD7slzkgBrn9xmAZMoU92Y5H5/Z
 PcRamPdw==;
Received: from [2001:8b0:897:1650::2] (helo=flibble.moreofthesa.me.uk)
 by spam.moreofthesa.me.uk with esmtp (Exim 4.92)
 (envelope-from <devspam@moreofthesa.me.uk>)
 id 1knWiA-0002lw-VD; Fri, 11 Dec 2020 00:55:07 +0000
From: Darren Salt <devspam@moreofthesa.me.uk>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/7] amdgpu: resize BAR0 to the maximum available size,
 even if it doesn't cover VRAM (v2)
Date: Fri, 11 Dec 2020 00:55:02 +0000
Message-Id: <20201211005506.4554-4-devspam@moreofthesa.me.uk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201211005506.4554-1-devspam@moreofthesa.me.uk>
References: <20201211005506.4554-1-devspam@moreofthesa.me.uk>
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

[v2] rewritten to use PCI helper functions; some extra log text.

Signed-off-by: Darren Salt <devspam@moreofthesa.me.uk>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 53 ++++++++++++++++++----
 1 file changed, 43 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 6637b84aeb85..1e99ca62a4d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1106,21 +1106,24 @@ void amdgpu_device_wb_free(struct amdgpu_device *adev, u32 wb)
  */
 int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
 {
-	u64 space_needed = roundup_pow_of_two(adev->gmc.real_vram_size);
-	u32 rbar_size = order_base_2(((space_needed >> 20) | 1)) - 1;
+	int rbar_size, current_size;
+	u32 available_sizes;
 	struct pci_bus *root;
 	struct resource *res;
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
+	rbar_size = pci_rebar_bytes_to_size(adev->gmc.real_vram_size);
+	current_size = pci_rebar_get_current_size(adev->pdev, 0);
+
+	/* Skip if the BIOS has already enabled large BAR, covering the VRAM */
+	if (current_size >= rbar_size)
 		return 0;
 
 	/* Check if the root BUS has 64bit memory resources */
@@ -1138,6 +1141,14 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
 	if (!res)
 		return 0;
 
+	available_sizes = pci_rebar_get_possible_sizes(adev->pdev, 0);
+	if (available_sizes == 0)
+		return 0;
+
+	dev_dbg(adev->dev, "BIOS-allocated BAR0 was %lluMB; trying to get %lluMB",
+	        current_size < 0 ? 0 : (pci_rebar_size_to_bytes(current_size) >> 20),
+	        pci_rebar_size_to_bytes(rbar_size) >> 20);
+
 	/* Disable memory decoding while we change the BAR addresses and size */
 	pci_read_config_word(adev->pdev, PCI_COMMAND, &cmd);
 	pci_write_config_word(adev->pdev, PCI_COMMAND,
@@ -1150,11 +1161,33 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
 
 	pci_release_resource(adev->pdev, 0);
 
-	r = pci_resize_resource(adev->pdev, 0, rbar_size);
-	if (r == -ENOSPC)
-		DRM_INFO("Not enough PCI address space for a large BAR.");
-	else if (r && r != -ENOTSUPP)
-		DRM_ERROR("Problem resizing BAR0 (%d).", r);
+	r = 0;
+	for (; rbar_size >= 0 && rbar_size > current_size; --rbar_size) {
+		/* Skip this size if it isn't advertised.
+		 * This avoids pci_resize_resources returning -EINVAL for that reason.
+		 */
+		if (!(available_sizes & BIT(rbar_size)))
+			continue;
+
+		r = pci_resize_resource(adev->pdev, 0, rbar_size);
+		if (r == 0) {
+			dev_dbg(adev->dev, "Succeeded in resizing to %lluMB.",
+			        pci_rebar_size_to_bytes(rbar_size) >> 20);
+			break;
+		} else if (r == -ENOTSUPP) {
+			dev_info(adev->dev, "BAR resizing not supported.");
+			break;
+		} else if (r == -ENOSPC) {
+			if (!nospc) {
+				/* Warn only the first time */
+				dev_info(adev->dev, "Not enough PCI address space for a large BAR.");
+				nospc = true;
+			}
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
