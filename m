Return-Path: <SRS0=Z3Jh=FT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1545DC4361B
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Dec 2020 01:09:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D18442074B
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Dec 2020 01:09:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D18442074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=moreofthesa.me.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B7436E198;
	Tue, 15 Dec 2020 01:09:13 +0000 (UTC)
Received: from spam.moreofthesa.me.uk (moreofthesa.me.uk
 [IPv6:2001:8b0:897:1651::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 996CD6E17C
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Dec 2020 01:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=moreofthesa.me.uk; s=201708; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Lk+SzH7RS46WDkQzX9yeukYg7lB6eQ+mcnYG9BRq4B0=; b=LM4thWNebQyR3vZfHWSbru9Mhi
 r8Z0C4RFXZiorVLmc+EKbnMHs4PNvXMhQ+IYMawNgEIW66VDKbmcXsvTv+HxBoOX3+rnniGg+KXxt
 79y+Eqwh3MM9AfjbBNygC+vd0WJQT4kFQUtdhkW0RCYdwsmlKeuwMIlo77VEYMHrUxSpLeym+MZdZ
 WW6h7HKQQrf7y2a/tg+g8haXPy3MbcP8xLQtZjnwSqpAtVQLorEM1ZmEW3WjTozk3phJLISauNyH/
 56LK2MPbm/EpX7k6vTPg7X4xWEaGWqhp5AbjuwEkzMojxh1kERBamBGagT81gZG8EGpxJV3mK3lVs
 iR0J1fvQ==;
Received: from [2001:8b0:897:1650::2] (helo=flibble.moreofthesa.me.uk)
 by spam.moreofthesa.me.uk with esmtp (Exim 4.92)
 (envelope-from <devspam@moreofthesa.me.uk>)
 id 1koypr-000334-Jq; Tue, 15 Dec 2020 01:09:03 +0000
From: Darren Salt <devspam@moreofthesa.me.uk>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/8] amdgpu: limit maximum BAR0 size when attempting to
 enlarge (v3)
Date: Tue, 15 Dec 2020 01:08:58 +0000
Message-Id: <20201215010902.18945-5-devspam@moreofthesa.me.uk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201215010902.18945-1-devspam@moreofthesa.me.uk>
References: <20201215010902.18945-1-devspam@moreofthesa.me.uk>
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

This is coarse, applying to all dGPUs.

[v3] On -ENOSPC, include the size attempted in the logged error.

[v2] If there are no advertised sizes small enough, limit to the smallest
available.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 32 ++++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  9 ++++++
 3 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index c228e7470d51..0b17e758e3f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -201,6 +201,7 @@ static const bool __maybe_unused no_system_mem_limit;
 
 extern int amdgpu_tmz;
 extern int amdgpu_reset_method;
+extern int amdgpu_max_bar_size;
 
 #ifdef CONFIG_DRM_AMDGPU_SI
 extern int amdgpu_si_support;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index ac94f8db06a8..fde5aaf97dc6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1107,6 +1107,7 @@ void amdgpu_device_wb_free(struct amdgpu_device *adev, u32 wb)
 int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
 {
 	int rbar_size, current_size;
+	int max_size = -1;
 	u64 current_bytes;
 	u32 available_sizes;
 	struct pci_bus *root;
@@ -1121,13 +1122,20 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
 
 	current_bytes = pci_resource_len(adev->pdev, 0);
 
-	/* Skip if the BIOS has already enabled large BAR, covering the VRAM */
-	if (current_bytes >= adev->gmc.real_vram_size)
-		return 0;
-
 	current_size = current_bytes ? pci_rebar_bytes_to_size(current_bytes) : -1;
 	rbar_size = pci_rebar_bytes_to_size(adev->gmc.real_vram_size);
 
+	/* If a maximum size is set, skip if that is the current size */
+	if (amdgpu_max_bar_size >= 0) {
+		max_size = max(amdgpu_max_bar_size, 8); /* clamp to min. 256MB */
+		if (current_size == max_size)
+			return 0;
+		rbar_size = max_size;
+	}
+	/* Else skip if the BAR already covers the VRAM */
+	else if (current_bytes >= adev->gmc.real_vram_size)
+		return 0;
+
 	/* Check if the root BUS has 64bit memory resources */
 	root = adev->pdev->bus;
 	while (root->parent)
@@ -1144,6 +1152,19 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
 		return 0;
 
 	available_sizes = pci_rebar_get_possible_sizes(adev->pdev, 0);
+	if (max_size >= 0) {
+		/* Cause larger sizes to be ignored unless that would leave
+		 * no advertised sizes (which shouldn't happen).
+		 */
+		r = available_sizes & ~(-1 << (max_size + 1));
+		if (!r) {
+			/* No smaller sizes, so use the smallest advertised */
+			r = ffs(r);
+			if (r)
+				r = 1 << (r - 1);
+		}
+		available_sizes = r;
+	}
 	if (available_sizes == 0)
 		return 0;
 
@@ -1171,7 +1192,8 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
 	if (r == -ENOTSUPP) {
 		dev_info(adev->dev, "BAR resizing not supported.");
 	} else if (r == -ENOSPC) {
-		dev_info(adev->dev, "Not enough PCI address space for a large BAR.");
+		dev_info(adev->dev, "Not enough PCI address space for a %lldMB BAR.",
+		         pci_rebar_size_to_bytes(rbar_size) >> 20);
 	} else if (r) {
 		dev_err(adev->dev, "Problem resizing BAR0 (%d).", r);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index cac2724e7615..dd2dc992ed13 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -161,6 +161,7 @@ int amdgpu_force_asic_type = -1;
 int amdgpu_tmz;
 int amdgpu_reset_method = -1; /* auto */
 int amdgpu_num_kcq = -1;
+int amdgpu_max_bar_size = -1;
 
 struct amdgpu_mgpu_info mgpu_info = {
 	.mutex = __MUTEX_INITIALIZER(mgpu_info.mutex),
@@ -807,6 +808,14 @@ module_param_named(bad_page_threshold, amdgpu_bad_page_threshold, int, 0444);
 MODULE_PARM_DESC(num_kcq, "number of kernel compute queue user want to setup (8 if set to greater than 8 or less than 0, only affect gfx 8+)");
 module_param_named(num_kcq, amdgpu_num_kcq, int, 0444);
 
+/**
+ * DOC: max_bar_size (int)
+ * The maximum BAR size, in megabytes. Only affects BARs which the BIOS hasn't already made larger.
+ * Unlimited by default.
+ */
+module_param_named(max_bar_size, amdgpu_max_bar_size, int, 0444);
+MODULE_PARM_DESC(max_bar_size, "Maximum FB BAR size, log2(megabytes) (default = -1, meaning unlimited; minimum is 8 for 256MB).");
+
 static const struct pci_device_id pciidlist[] = {
 #ifdef  CONFIG_DRM_AMDGPU_SI
 	{0x1002, 0x6780, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_TAHITI},
-- 
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
