Return-Path: <SRS0=6PJh=FR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A7EDC4361B
	for <amd-gfx@archiver.kernel.org>; Sun, 13 Dec 2020 22:53:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B8222220F
	for <amd-gfx@archiver.kernel.org>; Sun, 13 Dec 2020 22:53:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B8222220F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=moreofthesa.me.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B81D289E33;
	Sun, 13 Dec 2020 22:53:30 +0000 (UTC)
Received: from spam.moreofthesa.me.uk (moreofthesa.me.uk
 [IPv6:2001:8b0:897:1651::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C748E89E39
 for <amd-gfx@lists.freedesktop.org>; Sun, 13 Dec 2020 22:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=moreofthesa.me.uk; s=201708; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Iyt8JdO4s2dswyYCI8EdZSSZcAaYAFHhjqPxdYsyKVw=; b=RSNO6jxtIFm2alL0YYfFKi5Lz6
 bmxgKOFB8/13c1EMyiOekfZmKrcpB/I9bKzCIdiRaDua5Nz0ltLXIv3bl3XFwKe2achjyweA86/Bo
 9D+GYGhHlkzH/IDHIRlI29BT0R1tnn2yNmO/BYTEyTtxZgpVmcVnDGbv0RQX9c2iYB/QfGOLYXBOR
 nBctlTjXWxNO3Ayj17k2VzYiOcvJs0cVH9m2tx3PlPfxn+tvDdjzvs5xB+1kLhuk73BkRwwFumq90
 XrJEWHzrK/r0AyYmZh1bg7XXxzGjwI3NfRbDlF3O6KDRN9okpofFW8MKClEuev+wf03Y95Sovgxbf
 xqxEQP4A==;
Received: from [2001:8b0:897:1650::2] (helo=flibble.moreofthesa.me.uk)
 by spam.moreofthesa.me.uk with esmtp (Exim 4.92)
 (envelope-from <devspam@moreofthesa.me.uk>)
 id 1koaF2-0004Qu-BI; Sun, 13 Dec 2020 22:53:24 +0000
From: Darren Salt <devspam@moreofthesa.me.uk>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/8] amdgpu: limit maximum BAR0 size when attempting to
 enlarge (v2)
Date: Sun, 13 Dec 2020 22:53:19 +0000
Message-Id: <20201213225323.6752-5-devspam@moreofthesa.me.uk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201213225323.6752-1-devspam@moreofthesa.me.uk>
References: <20201213225323.6752-1-devspam@moreofthesa.me.uk>
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

v2: If there are no advertised sizes small enough, limit to the smallest
available.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 31 ++++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  9 +++++++
 3 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 327a0daf4a1d..c0e3e402023e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -194,6 +194,7 @@ static const bool debug_evictions; /* = false */
 
 extern int amdgpu_tmz;
 extern int amdgpu_reset_method;
+extern int amdgpu_max_bar_size;
 
 #ifdef CONFIG_DRM_AMDGPU_SI
 extern int amdgpu_si_support;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b0f8ad603147..c6495a86b280 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -909,6 +909,7 @@ void amdgpu_device_wb_free(struct amdgpu_device *adev, u32 wb)
 int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
 {
 	int rbar_size, current_size;
+	int max_size = -1;
 	u64 current_bytes;
 	u32 available_sizes;
 	struct pci_bus *root;
@@ -924,13 +925,20 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
 
 	current_bytes = pci_resource_len(adev->pdev, 0);
 
-	/* Skip if the BIOS has already enabled large BAR, covering the VRAM */
-	if (current_bytes >= adev->gmc.real_vram_size)
-		return 0;
-
 	current_size = current_bytes ? pci_rebar_bytes_to_size(current_bytes) : -1;
 	rbar_size = pci_rebar_bytes_to_size(adev->gmc.real_vram_size);
 
+	if (amdgpu_max_bar_size >= 0) {
+		max_size = max(amdgpu_max_bar_size, 8); /* clamp to min. 256MB */
+		/* Skip if the maximum size is the current size */
+		if (current_size == max_size)
+			return 0;
+		rbar_size = max_size;
+	}
+	else if (current_bytes >= adev->gmc.real_vram_size)
+		/* Skip if the BIOS has already enabled large BAR, covering the VRAM */
+		return 0;
+
 	/* Check if the root BUS has 64bit memory resources */
 	root = adev->pdev->bus;
 	while (root->parent)
@@ -947,6 +955,19 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
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
 
@@ -971,7 +992,7 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
 	pci_release_resource(adev->pdev, 0);
 
 	for (;
-	     rbar_size >= 0 && rbar_size > current_size;
+	     rbar_size >= 0;
 	     rbar_size = fls(available_sizes & ~(-1 << rbar_size)) - 1
 	    ) {
 		r = pci_resize_resource(adev->pdev, 0, rbar_size);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 06a5b6ae1c43..74baa8dafa5f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -150,6 +150,7 @@ int amdgpu_noretry;
 int amdgpu_force_asic_type = -1;
 int amdgpu_tmz = 0;
 int amdgpu_reset_method = -1; /* auto */
+int amdgpu_max_bar_size = -1;
 
 struct amdgpu_mgpu_info mgpu_info = {
 	.mutex = __MUTEX_INITIALIZER(mgpu_info.mutex),
@@ -765,6 +766,14 @@ module_param_named(tmz, amdgpu_tmz, int, 0444);
 MODULE_PARM_DESC(reset_method, "GPU reset method (-1 = auto (default), 0 = legacy, 1 = mode0, 2 = mode1, 3 = mode2, 4 = baco)");
 module_param_named(reset_method, amdgpu_reset_method, int, 0444);
 
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
