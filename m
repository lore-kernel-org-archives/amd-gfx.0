Return-Path: <SRS0=QenQ=FP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A133DC4361B
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Dec 2020 00:55:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AC2423DB4
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Dec 2020 00:55:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AC2423DB4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=moreofthesa.me.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB44C6E5C6;
	Fri, 11 Dec 2020 00:55:12 +0000 (UTC)
Received: from spam.moreofthesa.me.uk (moreofthesa.me.uk
 [IPv6:2001:8b0:897:1651::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAE476E5BB
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Dec 2020 00:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=moreofthesa.me.uk; s=201708; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7jndlwWIKP7EvUGwAsUTh7JQ88xwDpYkxWkGLObl+5s=; b=it2BWO1T/IMq7NHG7Y1alrG6a9
 I7KurOvr0uUCIBanqCcmsAhEotMIDyObzBdqAeOwQhPTBJFhu6NwJ6W+8RuWqLLTYJDUzMsxwt7rj
 1y93w3v79D3g8Pr6Blx4d9pkAPHnRZkyStglJSrkHjeeor/8XmrnZO4V7quuGuGpJ1hPC+zsctzvZ
 ZitQW07OD1Pf3gixesSPoYHEJcSdwtC2d1jPKm7nL8zuFTKN6DbeubWALnpvItWIvhoOEBV0jlDOe
 QzZ52+51EJAuMqxkIUJcuke9PDh+ZP30VBfGpuF82uF35mFzughlg6cWhtceKYGpNnECdG3d3cWmK
 FU4cGh/w==;
Received: from [2001:8b0:897:1650::2] (helo=flibble.moreofthesa.me.uk)
 by spam.moreofthesa.me.uk with esmtp (Exim 4.92)
 (envelope-from <devspam@moreofthesa.me.uk>)
 id 1knWiB-0002lw-NC; Fri, 11 Dec 2020 00:55:07 +0000
From: Darren Salt <devspam@moreofthesa.me.uk>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 7/7] amdgpu: allow overriding of the GPU's list of supported
 BAR sizes
Date: Fri, 11 Dec 2020 00:55:06 +0000
Message-Id: <20201211005506.4554-8-devspam@moreofthesa.me.uk>
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

Some cards don't advertise a BAR size which covers all of the VRAM.

Mine, a Sapphire RX 5600 XT Pulse, advertises only 256MB, 512MB and 1GB.
Despite this, it works fine with the full 6GB visible via an 8GB BAR.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 8 ++++----
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index c844e2a8500a..a64a9ac92ac1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -201,7 +201,7 @@ static const bool __maybe_unused no_system_mem_limit;
 
 extern int amdgpu_tmz;
 extern int amdgpu_reset_method;
-extern bool amdgpu_resize_bar;
+extern int amdgpu_resize_bar;
 extern int amdgpu_max_bar_size;
 
 #ifdef CONFIG_DRM_AMDGPU_SI
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b6c5ee490cbf..0f04686ed6c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1114,6 +1114,7 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
 	u16 cmd;
 	int r;
 	bool nospc = false;
+	const bool force = amdgpu_resize_bar == 2;
 
 	if (!amdgpu_resize_bar)
 		return 0;
@@ -1175,10 +1176,10 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
 		/* Skip this size if it isn't advertised.
 		 * This avoids pci_resize_resources returning -EINVAL for that reason.
 		 */
-		if (!(available_sizes & BIT(rbar_size)))
+		if (!force && !(available_sizes & BIT(rbar_size)))
 			continue;
 
-		r = pci_resize_resource(adev->pdev, 0, rbar_size);
+		r = pci_resize_resource(adev->pdev, 0, rbar_size, force);
 		if (r == 0) {
 			dev_dbg(adev->dev, "Succeeded in resizing to %lluMB.",
 			        pci_rebar_size_to_bytes(rbar_size) >> 20);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 0542843c7d63..468ca3725890 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -161,7 +161,7 @@ int amdgpu_force_asic_type = -1;
 int amdgpu_tmz;
 int amdgpu_reset_method = -1; /* auto */
 int amdgpu_num_kcq = -1;
-bool amdgpu_resize_bar = true;
+int amdgpu_resize_bar = 1;
 int amdgpu_max_bar_size = -1;
 
 struct amdgpu_mgpu_info mgpu_info = {
@@ -810,12 +810,12 @@ MODULE_PARM_DESC(num_kcq, "number of kernel compute queue user want to setup (8
 module_param_named(num_kcq, amdgpu_num_kcq, int, 0444);
 
 /**
- * DOC: resize_bar (bool)
+ * DOC: resize_bar (int)
  * Control whether FB BAR should be resized.
  * Enabled by default.
  */
-module_param_named(resize_bar, amdgpu_resize_bar, bool, 0444);
-MODULE_PARM_DESC(resize_bar, "Controls whether the FB BAR should be resized (default = true).");
+module_param_named(resize_bar, amdgpu_resize_bar, int, 0444);
+MODULE_PARM_DESC(resize_bar, "Controls whether the FB BAR should be resized (0 = off, 1 = on (default), 2 = override the GPU's supported sizes).");
 
 /**
  * DOC: max_bar_size (int)
-- 
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
