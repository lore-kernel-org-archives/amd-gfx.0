Return-Path: <SRS0=BheJ=2B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E93BAC2D0C6
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 15:33:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C04382077B
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 15:33:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUnT0C9Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C04382077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5794E6EB7F;
	Wed, 11 Dec 2019 15:33:29 +0000 (UTC)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C882F6EB76
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 15:33:24 +0000 (UTC)
Received: by mail-qk1-x741.google.com with SMTP id a203so9852038qkc.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 07:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=35PNvVRGYpWi6DDVnFLcE5DOGdIx1cVTLEY0N5Iozbg=;
 b=GUnT0C9ZO5Zb1ZeDh2EzRfkKnrVaiNhwz6+XZ11J7ElHU37hEKk+yySKbBHbCwYHu6
 uzNQIy0gytZC3Vy/Q19pBTes8c/rwWjCMB9PY5f9rqPRHicWXhKlqjZ2I2KiVGUabIHg
 BhBqU7dQnT1B7WJkJR5aCgag4RRUbxewTDbnYH8sj2Cd5ooJZRZcuBMzaz8u8XDXpARj
 AddmWw99sWHzhw2B0VHYrKcW8QgJnPvFkbycOxUux6GSXdpbsDgJsWluDGenvs1Iami2
 7H2mS/+eeQlVjUBIz1rAgW2uVDzE9RfoDC/6wKOGEe/hj6A+Hdo2aZ0dRTxJ3+BxTQeb
 JMDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=35PNvVRGYpWi6DDVnFLcE5DOGdIx1cVTLEY0N5Iozbg=;
 b=VDOwdBpAW4McW1/plA8ciKMiZTkrmYYRoNxLBNDbIcifs1xgVwCNU/8GwdsCZrrZ5n
 SRv7UXvgGPtLoeSML0IyY1R0xGI4em9dXnzbl1//svJJMsYAo9Q+gurgbE1V8jqUs6Ri
 njVDEmUOkHqU++PRWRrjx0YFxJB7I5tEaUR1to7hoSfFL3Ib3ilIsuLBW2rCKaf67HGJ
 Cgc+UextTMMgm+t7H6F/5eUotXVbNkTO8vsMcl7Vt73Z/QEfE+/0jX7Q0kIgmB67Pqsa
 mhqh1YQtnzYulOqbIFzKsm9yAxSQwW+CXTbUsAYAa47wRzR+vbUSTmv+MOtEJF5uYC4n
 SSWg==
X-Gm-Message-State: APjAAAWiVz6141Gt9CqW5AaGpVdHcI0GhoRI4dhC/Usaiyrqc2ngg6qt
 NYlTYLm2s2do4uzkSQZ1hqU9cue6
X-Google-Smtp-Source: APXvYqzvqOaQHmUXQa7zlAzs2S7aqF6CGbzAAKOwEDt5Q1IWjd+0fJggUMSG6P8nXYWk5oHqSdN90w==
X-Received: by 2002:a05:620a:b06:: with SMTP id
 t6mr3585891qkg.373.1576078403509; 
 Wed, 11 Dec 2019 07:33:23 -0800 (PST)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id p126sm752470qke.108.2019.12.11.07.33.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2019 07:33:22 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: fix license on Kconfig and Makefiles
Date: Wed, 11 Dec 2019 10:33:16 -0500
Message-Id: <20191211153316.1946311-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

amdgpu is MIT licensed.

Fixes: ec8f24b7faaf3d ("treewide: Add SPDX license identifier - Makefile/Kconfig")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/acp/Kconfig               | 2 +-
 drivers/gpu/drm/amd/amdgpu/Kconfig            | 2 +-
 drivers/gpu/drm/amd/amdkfd/Kconfig            | 2 +-
 drivers/gpu/drm/amd/display/Kconfig           | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn20/Makefile | 1 +
 drivers/gpu/drm/amd/display/dc/dcn21/Makefile | 1 +
 drivers/gpu/drm/amd/display/dc/dsc/Makefile   | 1 +
 7 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/acp/Kconfig b/drivers/gpu/drm/amd/acp/Kconfig
index 19bae9100da4..13340f353ea8 100644
--- a/drivers/gpu/drm/amd/acp/Kconfig
+++ b/drivers/gpu/drm/amd/acp/Kconfig
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only
+# SPDX-License-Identifier: MIT
 menu "ACP (Audio CoProcessor) Configuration"
 
 config DRM_AMD_ACP
diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig b/drivers/gpu/drm/amd/amdgpu/Kconfig
index 2e98c016cb47..9375e7f12420 100644
--- a/drivers/gpu/drm/amd/amdgpu/Kconfig
+++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only
+# SPDX-License-Identifier: MIT
 config DRM_AMDGPU_SI
 	bool "Enable amdgpu support for SI parts"
 	depends on DRM_AMDGPU
diff --git a/drivers/gpu/drm/amd/amdkfd/Kconfig b/drivers/gpu/drm/amd/amdkfd/Kconfig
index ba0e68057a89..b3672d10ea54 100644
--- a/drivers/gpu/drm/amd/amdkfd/Kconfig
+++ b/drivers/gpu/drm/amd/amdkfd/Kconfig
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only
+# SPDX-License-Identifier: MIT
 #
 # Heterogenous system architecture configuration
 #
diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
index 2a2f621c0d6c..87858bc57e64 100644
--- a/drivers/gpu/drm/amd/display/Kconfig
+++ b/drivers/gpu/drm/amd/display/Kconfig
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only
+# SPDX-License-Identifier: MIT
 menu "Display Engine Configuration"
 	depends on DRM && DRM_AMDGPU
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/Makefile b/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
index 2eeb03818072..5fcaf78334ff 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: MIT
 #
 # Makefile for DCN.
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/Makefile b/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
index b3688900d211..07684d3e375a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: MIT
 #
 # Makefile for DCN21.
 
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/Makefile b/drivers/gpu/drm/amd/display/dc/dsc/Makefile
index 7415b8bf6318..3f66868df171 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dsc/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: MIT
 #
 # Makefile for the 'dsc' sub-component of DAL.
 
-- 
2.23.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
