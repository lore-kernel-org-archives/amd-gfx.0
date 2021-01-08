Return-Path: <SRS0=yWhT=GL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C93C433DB
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 16:33:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38757238EC
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 16:33:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38757238EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD2DE6E840;
	Fri,  8 Jan 2021 16:33:45 +0000 (UTC)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A1196E840
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jan 2021 16:33:44 +0000 (UTC)
Received: by mail-qk1-x735.google.com with SMTP id h4so8940680qkk.4
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 Jan 2021 08:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=120R76jlSZSos3WQ/FKMPZEIajiC4cBsjwlq//05Ibs=;
 b=aJtkhBvUu9HzahWLgsYURkfzxh4LIskDBlnsigYTcBkZYX24Fd0Er7PTFZTW2QOL6/
 ewsCCjsn96rjKBa4IdsCVY/+97yg9xBPU4AGs7AWEFGV4x48pRyn2NIMB8fOEifXZNb8
 HnsFoC29ddd9RLZDHoBKB41rU1mV7peFXyT+vck6hYC93VQG0A1OAY+L8uuDSjz9n4Hb
 6IYRQFcYtZJH38ZRb2IyJ10LCXtbbpOtfTV5KE2RL0ZAj5vBGzynSbf6MCT3Xo3oBD5c
 3kG/L18MXHMR01bK2+r5peBr7aWuCi4Jw1+rjoldZAMoUtc/qjhOJ/4p0js6/vMtJARV
 klIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=120R76jlSZSos3WQ/FKMPZEIajiC4cBsjwlq//05Ibs=;
 b=lJHTjllrzITKDZNB9tOyxkWIPcIwHXxcqJs8s9gb9iIZU9W624BjHPIRjegk+lZ5y5
 39FdLZfXOxN30rmjwzgsRNIzddDanxn6MwyFjPS6P6pZYx3qlLWqPJhL7HfAgWHvwq0c
 mIdlZ7/4fQXcZq2FJIjVr9Reor2VT2MtmRnUzsE54+bHNi0H6cYPgfuX6tGJ8RSbRdXW
 SZx7e3K3H1Y1wzKjBMcbtt8MQOWPgiFGHfeLYKb5D/1Wz8A9Eq6pmpOND/tOur475EOf
 ic9MclMm+4ak8QUYfivqTtZzQ/KDzKuRf97G0CWTmE3Nny23fUFADXNs2Hjd+mrlCqKp
 PgXA==
X-Gm-Message-State: AOAM533pcgZWZqjnw2bJvhPzDbzcRtzukpL1yRCxBcvNMoG1+s80E8oT
 lVivXzmpxymMUqEnOJvslX5FI6Ae3Hc=
X-Google-Smtp-Source: ABdhPJz7e3X9TqFgTlVO8WU5uVjyXMI7yqZr7HJ2ChTotKpJxZaz7ErFYwRg93Ga7+V0ZlJh5QLzGg==
X-Received: by 2002:a37:74c5:: with SMTP id p188mr4854538qkc.263.1610123623600; 
 Fri, 08 Jan 2021 08:33:43 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.241])
 by smtp.gmail.com with ESMTPSA id k42sm2864638qtk.17.2021.01.08.08.33.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Jan 2021 08:33:43 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/display: fix build with CONFIG_DRM_AMD_DC_DCN
 disabled
Date: Fri,  8 Jan 2021 11:33:34 -0500
Message-Id: <20210108163334.374220-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

dc_allow_idle_optimizations() needs to be protected by
CONFIG_DRM_AMD_DC_DCN.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 318eb12f8de7..2dc8493793e0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5490,10 +5490,12 @@ static inline int dm_set_vblank(struct drm_crtc *crtc, bool enable)
 	else
 		dm->active_vblank_irq_count--;
 
+#if defined(CONFIG_DRM_AMD_DC_DCN)
 	dc_allow_idle_optimizations(
 		adev->dm.dc, dm->active_vblank_irq_count == 0 ? true : false);
 
 	DRM_DEBUG_DRIVER("Allow idle optimizations (MALL): %d\n", dm->active_vblank_irq_count == 0);
+#endif
 
 	mutex_unlock(&dm->dc_lock);
 
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
