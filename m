Return-Path: <SRS0=l6GN=4A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD76FC2BA83
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2020 04:33:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3E6620848
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2020 04:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kykCR+KB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3E6620848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 591D86E4AB;
	Wed, 12 Feb 2020 04:33:22 +0000 (UTC)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 909CB6E4AB
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Feb 2020 04:33:20 +0000 (UTC)
Received: by mail-yb1-xb35.google.com with SMTP id b141so465954ybg.10
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2020 20:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/+3Gc05t28Hko+ggBOMzzH8ntI4hl+K6ektSGvsDRPE=;
 b=kykCR+KByMLzEQi/DgVUR/qRntburGg3BQANAH7dynSMs81Tk5EDsil/fTrFyBT49I
 pdl/hLGBZ1DAwseFIKz1+sgqfabS0CwhjjxDWFbs6q1Q6xThafoejx3QQrxajeMEnumO
 AcpHtzYcPN7my2AMX+ZrRc38cUkn3pkiNIo3dsnkhVWefizgW5/kOTGnpKT2PxW7SnHE
 g/BKsASF7noTOwqAsT3wfTj9bQ5eBkZY08+C/jN8cF+3EdNyXeCJgd1Lz+Tw3Ygax1yF
 5Mq9sEEVWFqd1zftfNaYsIgf6jSbSdZG6mEH32c45Qi5Bet2KgEerg62NJEtIOIRnk/9
 MBQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/+3Gc05t28Hko+ggBOMzzH8ntI4hl+K6ektSGvsDRPE=;
 b=Fu8kfps+qJ1AdGNpy5C02BuUCTnUoiG9q4grVxVBwSapy9SFS/qMvcwtbDEgTnM9Et
 +UvjyoznUG0ZTle2A0C5+YYas21vd9bRdByAVrvtV3weZLa+1DFmDlaDfaD9usSDIF06
 yIM9qEHspU4HPcuzjHCpTWIJl+FIeawjIM82AHDfnu4gXIQVWtctLlR7l96/ab/gWmTH
 tSp8hwsNIa0nBKx3oQOXMw6os3kRRscxeOqQ1LEDN0Wt0TJHF474gVG8Z+GLYY0ujkrH
 TCSt3E4Ej57HfaE8YYlREB9TwJL18fDC6Q/ksNzMxr5kj5f3qGR0bNPZ/iZHWfXJtb4D
 tDZg==
X-Gm-Message-State: APjAAAWR/xdmKre7hSfhpUKeCC8477TLelN0/RwnT4eBtLdT1DqZe4Q0
 KYOUqQJN1PUkmXtSLRmL+tjuwDZ7
X-Google-Smtp-Source: APXvYqzGNHJmSdJrAeJ3o/eIXxwYIbPOrMw2WFsnejjthN1dm/7cnAkQge03Bq3ZXSsG+0a0tN5Yrg==
X-Received: by 2002:a5b:88e:: with SMTP id e14mr9109521ybq.338.1581481999509; 
 Tue, 11 Feb 2020 20:33:19 -0800 (PST)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id h23sm2966676ywc.105.2020.02.11.20.33.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2020 20:33:19 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/3] drm/amdgpu/display: extend DCN guards
Date: Tue, 11 Feb 2020 23:32:57 -0500
Message-Id: <20200212043258.1123758-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200212043258.1123758-1-alexander.deucher@amd.com>
References: <20200212043258.1123758-1-alexander.deucher@amd.com>
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

to cover dcn2.x related headers.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c  | 4 ++--
 drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c   | 2 +-
 drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index a65a1e7820d6..c02e5994d32b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -46,12 +46,12 @@
 #include "dce100/dce100_resource.h"
 #include "dce110/dce110_resource.h"
 #include "dce112/dce112_resource.h"
+#include "dce120/dce120_resource.h"
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 #include "dcn10/dcn10_resource.h"
-#endif
 #include "dcn20/dcn20_resource.h"
 #include "dcn21/dcn21_resource.h"
-#include "dce120/dce120_resource.h"
+#endif
 
 #define DC_LOGGER_INIT(logger)
 
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c b/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c
index d2d36d48caaa..f252af1947c3 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c
@@ -47,9 +47,9 @@
 #include "dce120/hw_factory_dce120.h"
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 #include "dcn10/hw_factory_dcn10.h"
-#endif
 #include "dcn20/hw_factory_dcn20.h"
 #include "dcn21/hw_factory_dcn21.h"
+#endif
 
 #include "diagnostics/hw_factory_diag.h"
 
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c b/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c
index 5d396657a1ee..04e2c0f74cb0 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c
@@ -45,9 +45,9 @@
 #include "dce120/hw_translate_dce120.h"
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 #include "dcn10/hw_translate_dcn10.h"
-#endif
 #include "dcn20/hw_translate_dcn20.h"
 #include "dcn21/hw_translate_dcn21.h"
+#endif
 
 #include "diagnostics/hw_translate_diag.h"
 
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
