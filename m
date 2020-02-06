Return-Path: <SRS0=1Ph7=32=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 573C4C35247
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2020 19:55:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25D0F21741
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2020 19:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qSzn+yXD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25D0F21741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF5B66E2DE;
	Thu,  6 Feb 2020 19:55:26 +0000 (UTC)
Received: from mail-yw1-xc43.google.com (mail-yw1-xc43.google.com
 [IPv6:2607:f8b0:4864:20::c43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7684C6E2DE
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2020 19:55:26 +0000 (UTC)
Received: by mail-yw1-xc43.google.com with SMTP id z141so5548959ywd.13
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Feb 2020 11:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4k7Ls6Zq6i1MiYpaIBiVXUV7tzBS4tfUUhdXHiHaJZ4=;
 b=qSzn+yXDlM/XuhyBq56p8932A1pLrdq2ErRDltEOrNBAw2vmcZt1Ppn14mPw2p/nKA
 zQgqT2+HYMGbbIQoA+J9Z6T4z38bFX4x7XdeeH7OHbZFhQzyIH5f6yNvDgj7x/GUoWD6
 PSWvE9OgE9MmZFG/v+1fmLklFNdGVbVTSGqwzI0/g34bwjpiBi+K+1wQJArvTUjsumSh
 lYLWMgWyCKen8dJoFRvxPmIkGmkT/C3lCKMbyfcdI5uUGZlubXzRKwx+zFb9UXT/lYN/
 Perr2SRkx/Qtd+K0c/2WHvb44G+i/iXk0VENVDmASVe24xy+1SyLhTb81E8rNnVX7AO5
 azHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4k7Ls6Zq6i1MiYpaIBiVXUV7tzBS4tfUUhdXHiHaJZ4=;
 b=lUW+qO4FeKNFG8jmoWqlkdem22TDbmwvm5IJAvTcYDSDbH/eYfICCok6m4fqTAUVTN
 PZhwhK/rlcVLsqKwYUqY9XskRHCdbUp2pzwR2mgqoJBI//By47aNq3M6dGlrHL8wt9ka
 sAVKfT4qxXqgDCUm+5ZXwdDZQyOAf+Ci/QloLM9pMxhuvajT6NgQRWnYX2fY3EGzJ8W+
 Yw+5dtGRE31HTGmh+9I2GPRZAfxtC+MpqV5+Bib0Xh2N5RXvV8WbIH+5UnIOrkYbwFEu
 N6Vvv4oL806fWtxqqcDJC026k1JnPmzZNjr+s6d/6Z8U87AX3iXuE/zJkvm7z48Dw3e2
 0yYw==
X-Gm-Message-State: APjAAAUodAjc0q8ls3/+NmChbZwocc4T9d77ZthaEbUVlaU0tdK28QSg
 L4I7mC3pY5D/+oNvlaQExDeTaEck
X-Google-Smtp-Source: APXvYqwx0JMavobxto9i6RcKNVUhELmGLGVCMmFkAdINnzJShe3jmyi4jCqK0jkibLbKL31LLKz1Ow==
X-Received: by 2002:a0d:e20a:: with SMTP id l10mr4740324ywe.17.1581018925364; 
 Thu, 06 Feb 2020 11:55:25 -0800 (PST)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id e63sm179870ywd.64.2020.02.06.11.55.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 11:55:24 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: update smu_v11_0_pptable.h
Date: Thu,  6 Feb 2020 14:55:15 -0500
Message-Id: <20200206195516.302101-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.24.1
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

Update to the latest changes.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/powerplay/inc/smu_v11_0_pptable.h | 46 +++++++++++++------
 1 file changed, 32 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0_pptable.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0_pptable.h
index b2f96a101124..7a63cf8e85ed 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0_pptable.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0_pptable.h
@@ -39,21 +39,39 @@
 #define SMU_11_0_PP_OVERDRIVE_VERSION                   0x0800
 #define SMU_11_0_PP_POWERSAVINGCLOCK_VERSION            0x0100
 
+enum SMU_11_0_ODFEATURE_CAP {
+    SMU_11_0_ODCAP_GFXCLK_LIMITS = 0,
+    SMU_11_0_ODCAP_GFXCLK_CURVE,
+    SMU_11_0_ODCAP_UCLK_MAX,
+    SMU_11_0_ODCAP_POWER_LIMIT,
+    SMU_11_0_ODCAP_FAN_ACOUSTIC_LIMIT,
+    SMU_11_0_ODCAP_FAN_SPEED_MIN,
+    SMU_11_0_ODCAP_TEMPERATURE_FAN,
+    SMU_11_0_ODCAP_TEMPERATURE_SYSTEM,
+    SMU_11_0_ODCAP_MEMORY_TIMING_TUNE,
+    SMU_11_0_ODCAP_FAN_ZERO_RPM_CONTROL,
+    SMU_11_0_ODCAP_AUTO_UV_ENGINE,
+    SMU_11_0_ODCAP_AUTO_OC_ENGINE,
+    SMU_11_0_ODCAP_AUTO_OC_MEMORY,
+    SMU_11_0_ODCAP_FAN_CURVE,
+    SMU_11_0_ODCAP_COUNT,
+};
+
 enum SMU_11_0_ODFEATURE_ID {
-    SMU_11_0_ODFEATURE_GFXCLK_LIMITS        = 1 << 0,         //GFXCLK Limit feature
-    SMU_11_0_ODFEATURE_GFXCLK_CURVE         = 1 << 1,         //GFXCLK Curve feature
-    SMU_11_0_ODFEATURE_UCLK_MAX             = 1 << 2,         //UCLK Limit feature
-    SMU_11_0_ODFEATURE_POWER_LIMIT          = 1 << 3,         //Power Limit feature
-    SMU_11_0_ODFEATURE_FAN_ACOUSTIC_LIMIT   = 1 << 4,         //Fan Acoustic RPM feature
-    SMU_11_0_ODFEATURE_FAN_SPEED_MIN        = 1 << 5,         //Minimum Fan Speed feature
-    SMU_11_0_ODFEATURE_TEMPERATURE_FAN      = 1 << 6,         //Fan Target Temperature Limit feature
-    SMU_11_0_ODFEATURE_TEMPERATURE_SYSTEM   = 1 << 7,         //Operating Temperature Limit feature
-    SMU_11_0_ODFEATURE_MEMORY_TIMING_TUNE   = 1 << 8,         //AC Timing Tuning feature
-    SMU_11_0_ODFEATURE_FAN_ZERO_RPM_CONTROL = 1 << 9,         //Zero RPM feature
-    SMU_11_0_ODFEATURE_AUTO_UV_ENGINE       = 1 << 10,        //Auto Under Volt GFXCLK feature
-    SMU_11_0_ODFEATURE_AUTO_OC_ENGINE       = 1 << 11,        //Auto Over Clock GFXCLK feature
-    SMU_11_0_ODFEATURE_AUTO_OC_MEMORY       = 1 << 12,        //Auto Over Clock MCLK feature
-    SMU_11_0_ODFEATURE_FAN_CURVE            = 1 << 13,        //VICTOR TODO
+    SMU_11_0_ODFEATURE_GFXCLK_LIMITS        = 1 << SMU_11_0_ODCAP_GFXCLK_LIMITS,            //GFXCLK Limit feature
+    SMU_11_0_ODFEATURE_GFXCLK_CURVE         = 1 << SMU_11_0_ODCAP_GFXCLK_CURVE,             //GFXCLK Curve feature
+    SMU_11_0_ODFEATURE_UCLK_MAX             = 1 << SMU_11_0_ODCAP_UCLK_MAX,                 //UCLK Limit feature
+    SMU_11_0_ODFEATURE_POWER_LIMIT          = 1 << SMU_11_0_ODCAP_POWER_LIMIT,              //Power Limit feature
+    SMU_11_0_ODFEATURE_FAN_ACOUSTIC_LIMIT   = 1 << SMU_11_0_ODCAP_FAN_ACOUSTIC_LIMIT,       //Fan Acoustic RPM feature
+    SMU_11_0_ODFEATURE_FAN_SPEED_MIN        = 1 << SMU_11_0_ODCAP_FAN_SPEED_MIN,            //Minimum Fan Speed feature
+    SMU_11_0_ODFEATURE_TEMPERATURE_FAN      = 1 << SMU_11_0_ODCAP_TEMPERATURE_FAN,          //Fan Target Temperature Limit feature
+    SMU_11_0_ODFEATURE_TEMPERATURE_SYSTEM   = 1 << SMU_11_0_ODCAP_TEMPERATURE_SYSTEM,       //Operating Temperature Limit feature
+    SMU_11_0_ODFEATURE_MEMORY_TIMING_TUNE   = 1 << SMU_11_0_ODCAP_MEMORY_TIMING_TUNE,       //AC Timing Tuning feature
+    SMU_11_0_ODFEATURE_FAN_ZERO_RPM_CONTROL = 1 << SMU_11_0_ODCAP_FAN_ZERO_RPM_CONTROL,     //Zero RPM feature
+    SMU_11_0_ODFEATURE_AUTO_UV_ENGINE       = 1 << SMU_11_0_ODCAP_AUTO_UV_ENGINE,           //Auto Under Volt GFXCLK feature
+    SMU_11_0_ODFEATURE_AUTO_OC_ENGINE       = 1 << SMU_11_0_ODCAP_AUTO_OC_ENGINE,           //Auto Over Clock GFXCLK feature
+    SMU_11_0_ODFEATURE_AUTO_OC_MEMORY       = 1 << SMU_11_0_ODCAP_AUTO_OC_MEMORY,           //Auto Over Clock MCLK feature
+    SMU_11_0_ODFEATURE_FAN_CURVE            = 1 << SMU_11_0_ODCAP_FAN_CURVE,                //Fan Curve feature
     SMU_11_0_ODFEATURE_COUNT                = 14,
 };
 #define SMU_11_0_MAX_ODFEATURE    32          //Maximum Number of OD Features
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
