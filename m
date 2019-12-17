Return-Path: <SRS0=JueS=2H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE2E7C43603
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Dec 2019 20:47:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7DD42146E
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Dec 2019 20:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jyip8l1q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7DD42146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78924898EE;
	Tue, 17 Dec 2019 20:47:19 +0000 (UTC)
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com
 [IPv6:2607:f8b0:4864:20::b41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D6EE898EE
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Dec 2019 20:47:18 +0000 (UTC)
Received: by mail-yb1-xb41.google.com with SMTP id n66so2061230ybg.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Dec 2019 12:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=urh7F6QXg5oAvab9EcI2yZpnuU8jM/bYg78vSIaHAH4=;
 b=jyip8l1qgN65DPcz6PK1WUDxzqEsRiA7FQbsaILe7PGBcbQiu8lm8YkJOWhuvH73qJ
 yYrlfMtM6V3dy+0zwPcotmW0+WIMhSwmyGy+HfegOX4EtrORErol0Sg4LF3Dauon9QjC
 eXbpz4MfQ0q5+milOTFY+IzkrRrfacdF65SyvkaTusotAiUoJYwvB1F981GFsa0e+rF1
 1E5RLlyIjJx/WIg5UZU4EHVIbTP47TuLZ+IZw+AP4sZ1wLNeZVzG3FRSc/43BBdj9RkG
 6FFfP40S0CzCEAhh+P7JS8sQs3e5WvQ0pLm9AHXRZZtdAfkRLtQqt10XbrEyyYlxf3PD
 4uqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=urh7F6QXg5oAvab9EcI2yZpnuU8jM/bYg78vSIaHAH4=;
 b=c3RxT15VRVpQlScrMlNibUdBajbiW1CdS96bnyMFKvnwpdp90kOCp/uM2sLswRd+lz
 ECvUPIR3hbCVh8wlS3YviuS6/6SecV9CDFRgvvbPpnyUL61U58MxlV0Wp/dT1G72qGhS
 ak3t19+waN4fDAkXznwIlLO/sRgrNQlGYz4p+6+2CMjLBB2Kvk58EI8YxLRcskwHq2A2
 aKxAH4rVx4rrbfJOfQgPEgqJq0UwIt9WyACwzUWBi9UWdJ3DjPSatQWi5wcEJ977Az0E
 FwmLxueKn+bfq2LLbumIOK6u78MPnaEhvXc/ZezwwtZY0oO0ISLatko55cAuNvefI7MO
 xG1A==
X-Gm-Message-State: APjAAAX4sg30OKg55P/IGEFzZvCQef3qLKs4EMjOPvRipWQDazvoTpfP
 T8eHvXnCO2y3memJmbRH6ICvomAl
X-Google-Smtp-Source: APXvYqyexUbTvIG/057Xzi2IFlklg+8oeVBLn3kw4EniIAjm3KxVSZ62i3GlNjvVuFDebI3Zcs/DBA==
X-Received: by 2002:a5b:782:: with SMTP id b2mr27531ybq.25.1576615637260;
 Tue, 17 Dec 2019 12:47:17 -0800 (PST)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id 189sm10711260ywc.16.2019.12.17.12.47.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2019 12:47:16 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu/display: include delay.h
Date: Tue, 17 Dec 2019 15:47:06 -0500
Message-Id: <20191217204707.2258744-1-alexander.deucher@amd.com>
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

For udelay.  This is needed for some platforms.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c
index 110c8620907b..bcbc0b8a9aa0 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c
@@ -23,6 +23,8 @@
  *
  */
 
+#include <linux/delay.h>
+
 #include "hdcp.h"
 
 static inline enum mod_hdcp_status check_receiver_id_list_ready(struct mod_hdcp *hdcp)
-- 
2.23.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
