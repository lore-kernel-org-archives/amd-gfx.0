Return-Path: <SRS0=9beK=BA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE299C433E4
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 16:52:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4CDC2073A
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 16:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+prKugW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4CDC2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7967F89E2A;
	Tue, 21 Jul 2020 16:52:56 +0000 (UTC)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0BB889CF8
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2020 16:52:53 +0000 (UTC)
Received: by mail-qk1-x744.google.com with SMTP id x69so7445438qkb.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2020 09:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OK5cC3pT48JWrZvNZHSeVEG/HeDXfquVVb7eZW/m4eo=;
 b=H+prKugWhVNj6/htygESkO5x2I5QvqfJBGZCZ0LC896HVUX7kc2WcWmjYhuQ/bzLcP
 t5y4gy5XbkUAYp3+JvQ00Ye7c8QpOn6acCzT1W15b9nHdhxjL9MFU4ksOXnVKdTdwS9b
 60zjFzJ0o7uYlN5+fJ67JuAAUck2yoPf1cYOywQkzaoIigic/3prhxxK2gYYhqQ7+P+j
 DGAuFXn9xfMvSc7WWtxUCRfZIS0dBJcJqy4yMN+Euaml27FGZ8LxYwDCpW+9x1jgp5Ol
 F9Gd+HbUPBy5lB8FK6a6AuDIFwNogAe/uIix7MS7ulfLv3mBaH7hRlggtJ4Srfh07ETs
 EN1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OK5cC3pT48JWrZvNZHSeVEG/HeDXfquVVb7eZW/m4eo=;
 b=h7BRJzz0bKw0JDBo1UV76+lq00P+d45x3pPoyeNQFhVozhf1T5px+b8S4ed6P8KYdp
 EsV8DGhEiaKYUllBI+yfsibaXxyUPLfQfh7hWRMnNNNUDXbeCbPE7uj+HtLEF0hVEhqf
 HWYMSWF99N4leIBCBeHf4TTY+XYy8TldHb4wAHaEW155sMYC9IazL3h1NGb5Bz1QGT75
 pscLRbKsbB4EOCFdpcMehjXqiK/5HvXqRT49fLCnEYzoEDNUIGMO6u1KuikqxxJpTxg+
 fJUKFGQvG3J0MzBC9zDT5dq59HvTQil5WpBQyMfnfRNV4jxwrdgcjI3xEBzR1XGvGBuB
 /Png==
X-Gm-Message-State: AOAM5323pa2/ng4vCRpjZJKf71MivbBokjmoosqWXnwUqQ0XJO54oxyE
 gTNm5U6LKvcyiyQBJv3gK+MIx8MA
X-Google-Smtp-Source: ABdhPJzFe2YfmjD70wBtqL63Ro7zTsMH0WR9qPN7aR3fZY5ErJoD3RhjLtlGgrsGvNMhhPoBTlvS5g==
X-Received: by 2002:a37:6488:: with SMTP id
 y130mr27697204qkb.194.1595350372933; 
 Tue, 21 Jul 2020 09:52:52 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id d16sm2709212qkk.106.2020.07.21.09.52.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2020 09:52:52 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/6] drm/amdgpu/navi1x: add SMU i2c support
Date: Tue, 21 Jul 2020 12:52:39 -0400
Message-Id: <20200721165240.296265-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200721165240.296265-1-alexander.deucher@amd.com>
References: <20200721165240.296265-1-alexander.deucher@amd.com>
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

Enable SMU i2c bus access for navi1x asics.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index ead135f39c7e..56267e6c600e 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -23,6 +23,7 @@
 
 #include <linux/firmware.h>
 #include <linux/pci.h>
+#include <linux/i2c.h>
 #include "amdgpu.h"
 #include "amdgpu_smu.h"
 #include "smu_internal.h"
@@ -52,6 +53,8 @@
 #undef pr_info
 #undef pr_debug
 
+#define to_amdgpu_device(x) (container_of(x, struct amdgpu_device, pm.smu_i2c))
+
 #define FEATURE_MASK(feature) (1ULL << feature)
 #define SMC_DPM_FEATURE ( \
 	FEATURE_MASK(FEATURE_DPM_PREFETCHER_BIT) | \
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
