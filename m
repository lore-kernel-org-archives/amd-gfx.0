Return-Path: <SRS0=QenQ=FP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B444FC433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Dec 2020 00:55:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05E1623DB4
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Dec 2020 00:55:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05E1623DB4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=moreofthesa.me.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 804406E5B0;
	Fri, 11 Dec 2020 00:55:10 +0000 (UTC)
Received: from spam.moreofthesa.me.uk (moreofthesa.me.uk
 [IPv6:2001:8b0:897:1651::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 682526E506
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Dec 2020 00:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=moreofthesa.me.uk; s=201708; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lfhXLULDdWgypQDXXNLKFRpea8zxbY3sfKs531fHUKE=; b=RbCFz920gfFKrOEnikuCtfos71
 7+mMSExYIWhUj4GIYXVB3HQaWX9Vdm3V4odWrEFddHOQKj5os4A3qeCLdvwJLYQMRazcGgi032frB
 n0mMzztU6GQEBv8w5J4gKQDJ6FKfygp7EiL46eHzqlSEYA7p1zb2DyRAohaLet1NBLBfI/HtC7Aia
 MGOAQN5mHDguUUqxHB4duNnZBrb0Jm0YK2qisO1ouctZhTn0+z+QV779RG+6EZ1MBT/68FrxWkQ1H
 19+fDzDxqFGNhqqJztmyczxWRqIc65xNwqAH8PXiUOF9FdGMf6BMcjcX1GuL5jGGAwIgXvfckli4p
 DMhHEZqA==;
Received: from [2001:8b0:897:1650::2] (helo=flibble.moreofthesa.me.uk)
 by spam.moreofthesa.me.uk with esmtp (Exim 4.92)
 (envelope-from <devspam@moreofthesa.me.uk>)
 id 1knWiB-0002lw-DD; Fri, 11 Dec 2020 00:55:07 +0000
From: Darren Salt <devspam@moreofthesa.me.uk>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/7] amdgpu: limit maximum FB BAR size when attempting to
 enlarge
Date: Fri, 11 Dec 2020 00:55:04 +0000
Message-Id: <20201211005506.4554-6-devspam@moreofthesa.me.uk>
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

This is coarse, applying to all dGPUs.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 +++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 9 +++++++++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 2efce7fa6a4b..c844e2a8500a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -202,6 +202,7 @@ static const bool __maybe_unused no_system_mem_limit;
 extern int amdgpu_tmz;
 extern int amdgpu_reset_method;
 extern bool amdgpu_resize_bar;
+extern int amdgpu_max_bar_size;
 
 #ifdef CONFIG_DRM_AMDGPU_SI
 extern int amdgpu_si_support;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 292796e9f83d..b6c5ee490cbf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1125,7 +1125,13 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
 	rbar_size = pci_rebar_bytes_to_size(adev->gmc.real_vram_size);
 	current_size = pci_rebar_get_current_size(adev->pdev, 0);
 
-	/* Skip if the BIOS has already enabled large BAR, covering the VRAM */
+	/* Skip if the BIOS has already enabled large BAR, covering the VRAM (or >= limit, if set) */
+	if (amdgpu_max_bar_size >= 0) {
+		const u32 max_size = max(amdgpu_max_bar_size, 8); /* clamp to min. 256MB */
+
+		if (rbar_size > max_size)
+			rbar_size = max_size;
+	}
 	if (current_size >= rbar_size)
 		return 0;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 6df33df74775..0542843c7d63 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -162,6 +162,7 @@ int amdgpu_tmz;
 int amdgpu_reset_method = -1; /* auto */
 int amdgpu_num_kcq = -1;
 bool amdgpu_resize_bar = true;
+int amdgpu_max_bar_size = -1;
 
 struct amdgpu_mgpu_info mgpu_info = {
 	.mutex = __MUTEX_INITIALIZER(mgpu_info.mutex),
@@ -816,6 +817,14 @@ module_param_named(num_kcq, amdgpu_num_kcq, int, 0444);
 module_param_named(resize_bar, amdgpu_resize_bar, bool, 0444);
 MODULE_PARM_DESC(resize_bar, "Controls whether the FB BAR should be resized (default = true).");
 
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
