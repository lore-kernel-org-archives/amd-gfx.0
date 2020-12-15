Return-Path: <SRS0=Z3Jh=FT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BDC1C2BB48
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Dec 2020 01:09:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E0952076D
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Dec 2020 01:09:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E0952076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=moreofthesa.me.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BA2C6E17C;
	Tue, 15 Dec 2020 01:09:07 +0000 (UTC)
Received: from spam.moreofthesa.me.uk (moreofthesa.me.uk
 [IPv6:2001:8b0:897:1651::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0613C6E0C6
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Dec 2020 01:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=moreofthesa.me.uk; s=201708; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=av/1m0A4UyyvwJMqc+Jl/h03kb0qDUxl3556dHZ9Qhs=; b=0Ejq4IsthkKe/u66/g/vJkuLrb
 4QDv+JUbcAed1lWiGtBfD4hkUxEJb4yNY8bAsyNob6y8mRQDqf13wkImn7nMWgdv74QTLYLlQ5RnT
 o9bvhdBW6UgcD/nSp/uq4YmSyM3MkeOfW29q9JRSPLCgqnZhvLDdczbuex/J5aEJzykkna0DTtCrD
 HG7Hy175bdCBr69eYbYRFElRh13EmOPcE54HfI1uOBUGTQx9fFYjCdLmtVnDU79HPQJ1pyiTMpzAb
 A2SGYYLEcE19YYVB73Y74fltsLUvPIP3Xf5Zr7lQCj08uqAK36enZMVxtOQk4ydLX6XTPruWGYeV8
 daq/QDew==;
Received: from [2001:8b0:897:1650::2] (helo=flibble.moreofthesa.me.uk)
 by spam.moreofthesa.me.uk with esmtp (Exim 4.92)
 (envelope-from <devspam@moreofthesa.me.uk>)
 id 1koypr-000334-Ue; Tue, 15 Dec 2020 01:09:03 +0000
From: Darren Salt <devspam@moreofthesa.me.uk>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 6/8] amdgpu: allow overriding of the GPU's list of supported
 BAR sizes (v3)
Date: Tue, 15 Dec 2020 01:09:00 +0000
Message-Id: <20201215010902.18945-7-devspam@moreofthesa.me.uk>
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

Some cards don't advertise a BAR size which covers all of the VRAM.

Mine, a Sapphire RX 5600 XT Pulse, advertises only 256MB, 512MB and 1GB.
Despite this, it appears to work fine with the full 6GB visible via an 8GB
BAR.

v3: changed implementation due to changes in preceding patches.

v2: different option controlling this due to a dropped patch.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  8 ++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 10 ++++++++++
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 0b17e758e3f1..93285ec7bfc3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -202,6 +202,7 @@ static const bool __maybe_unused no_system_mem_limit;
 extern int amdgpu_tmz;
 extern int amdgpu_reset_method;
 extern int amdgpu_max_bar_size;
+extern bool amdgpu_override_bar_sizes;
 
 #ifdef CONFIG_DRM_AMDGPU_SI
 extern int amdgpu_si_support;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 125aca52e25d..8490a96ee25e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1151,7 +1151,11 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
 	if (!res)
 		return 0;
 
-	available_sizes = pci_rebar_get_possible_sizes(adev->pdev, 0);
+	if (amdgpu_override_bar_sizes)
+		available_sizes = ~(-1 << rbar_size) & ~0xFF;
+	else
+		available_sizes = pci_rebar_get_possible_sizes(adev->pdev, 0);
+
 	if (max_size >= 0) {
 		/* Cause larger sizes to be ignored unless that would leave
 		 * no advertised sizes (which shouldn't happen).
@@ -1188,7 +1192,7 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
 
 	pci_release_resource(adev->pdev, 0);
 
-	r = pci_resize_resource(adev->pdev, 0, rbar_size, false);
+	r = pci_resize_resource(adev->pdev, 0, rbar_size, amdgpu_override_bar_sizes);
 	if (r == -ENOTSUPP) {
 		dev_info(adev->dev, "BAR resizing not supported.");
 	} else if (r == -ENOSPC) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index dd2dc992ed13..59f6b95f0875 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -162,6 +162,7 @@ int amdgpu_tmz;
 int amdgpu_reset_method = -1; /* auto */
 int amdgpu_num_kcq = -1;
 int amdgpu_max_bar_size = -1;
+bool amdgpu_override_bar_sizes = false;
 
 struct amdgpu_mgpu_info mgpu_info = {
 	.mutex = __MUTEX_INITIALIZER(mgpu_info.mutex),
@@ -816,6 +817,15 @@ module_param_named(num_kcq, amdgpu_num_kcq, int, 0444);
 module_param_named(max_bar_size, amdgpu_max_bar_size, int, 0444);
 MODULE_PARM_DESC(max_bar_size, "Maximum FB BAR size, log2(megabytes) (default = -1, meaning unlimited; minimum is 8 for 256MB).");
 
+/**
+ * DOC: amdgpu_override_bar_sizes (int)
+ * A blunt instrument for ignoring the listed BAR sizes.
+ * This is intended to handle VBIOSes which list the wrong set of sizes but which aren't recognised as such by the kernel.
+ * Disabled by default.
+ */
+module_param_named(override_bar_sizes, amdgpu_override_bar_sizes, bool, 0444);
+MODULE_PARM_DESC(override_bar_sizes, "Ignore VBIOS supported BAR sizes, for where the list is wrong. (Disabled by default.)");
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
