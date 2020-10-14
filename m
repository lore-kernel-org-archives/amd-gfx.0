Return-Path: <SRS0=q64Q=DV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B0CC433E7
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2020 17:55:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA1D02222A
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2020 17:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U7O8f36X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA1D02222A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00DE76EB1E;
	Wed, 14 Oct 2020 17:55:26 +0000 (UTC)
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com
 [IPv6:2607:f8b0:4864:20::f44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E4BF6EB1E
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2020 17:55:25 +0000 (UTC)
Received: by mail-qv1-xf44.google.com with SMTP id t20so1877844qvv.8
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2020 10:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=F78BnGQMQedx0jg5elGHac11ukD8IlWUk1yGtAVoA+U=;
 b=U7O8f36XKhqOGGoUCJkK5UHgWwlX/NrNy6aeCWuY1X7HV2WegZAcwPID0biWTkt0DY
 cC937CmcXXyCxla9Yg/MFSg1gKpLYXxaX+9LySnn8S4z6nxuQfy1GPe3uA8fiPLwKpUe
 brcn8BdofIuIkzPokmgeuv8UIBlt3Xb19r6ipfIKuMcLFtxaRUj8Cds2fNSAU2ER6Q4K
 aNPPTsUTee9RZNYzD134Wair7/8M5BIB84zw9Hw7E0eApwXBnXTlwJQioCMGzp50IuoX
 GxkJkwOr4uK1wS7Za3FfYY59VOZb4ddacMQ3ylF3I0bpqCA9W582fzCIhWNJAOGGvNqY
 tmBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=F78BnGQMQedx0jg5elGHac11ukD8IlWUk1yGtAVoA+U=;
 b=pZ4WeNflmiCAvtP7j8g5PuW0JkYkMMQcB1z+/26yo2rK4YMH9xkt8L9MLFVwmzxRyD
 NwpueolKZMF/7xpyeJgexpVOUcmXCkJt78PDKK5L2g4nfOGYYG+DO/9H69TsQbrOHIzh
 nN/8DKuyCO3uCxW1ffBJy1aczeIFAPaRVH/NY6qI8Q7n5V6jIGSuF7BU9aQE33wZCShC
 oFraSSjVxK/uU/xTLZ2B347Qb/eb8jPuJBZoPf8MfPXxRnzQx+GjnqzrTADHP74GfxYk
 t/mmf0VngKFrtM/lP76PQAzq5Nl71NXBA25BmNqIU/x1JGsUS+yQQyApu0aFIZKlP82Z
 LmaA==
X-Gm-Message-State: AOAM532oxbBZKtiaPSQho7fyLj+B3f2Kbi/eQP44WrmYQLr+jJUSb3wP
 +l8QinDLSXYaO33C85EXfWIWSe9/YUQ=
X-Google-Smtp-Source: ABdhPJxPaiwW/N71cQfjlFKwLDTGzcofebFgpKhFOCVmFqevaRYFuGbx99WdkQ9ZI9hJLB0YELN8jA==
X-Received: by 2002:a0c:f706:: with SMTP id w6mr696164qvn.48.1602698124063;
 Wed, 14 Oct 2020 10:55:24 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id j24sm155403qkg.107.2020.10.14.10.55.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2020 10:55:23 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/display: DRM_AMD_DC_DCN3_02 depends on
 DRM_AMD_DC_DCN3_01
Date: Wed, 14 Oct 2020 13:55:07 -0400
Message-Id: <20201014175507.973772-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
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
Cc: Alex Deucher <alexander.deucher@amd.com>, rdunlap@infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix this to avoid build problems if DRM_AMD_DC_DCN3_02 is defined, but
DRM_AMD_DC_DCN3_01 is not.

Fixes: 36d26912e8d854 ("drm/amd/display: Add support for DCN302 (v2)")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
index 5906778627f0..93cdcd1ee9ff 100644
--- a/drivers/gpu/drm/amd/display/Kconfig
+++ b/drivers/gpu/drm/amd/display/Kconfig
@@ -45,6 +45,7 @@ config DRM_AMD_DC_DCN3_01
 config DRM_AMD_DC_DCN3_02
         bool "DCN 3.02 family"
         depends on DRM_AMD_DC_DCN3_0
+        depends on DRM_AMD_DC_DCN3_01
         help
             Choose this option if you want to have
             Dimgrey_cavefish support for display engine
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
