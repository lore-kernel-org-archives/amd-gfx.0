Return-Path: <SRS0=fKyo=G5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F8A1C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Jan 2021 18:17:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F379207A0
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Jan 2021 18:17:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F379207A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4E7E893A3;
	Tue, 26 Jan 2021 18:17:24 +0000 (UTC)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BD90893A3
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Jan 2021 18:17:24 +0000 (UTC)
Received: by mail-qk1-x72a.google.com with SMTP id r77so16676477qka.12
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Jan 2021 10:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=lTpwyJHgQk7FXhYlA6hc0Xmept2/SbS4lw4XoRFkGww=;
 b=PqdVhsQOJ99wrA+e6YDSNLVpYDNxIxrYbTFrJKqLfluXnPU0wi2Mzf7PJb/b99I10t
 ikOtBn4HEmTLxPLZ20+5N2zldZQzrd8c8DK+NaYH7AEt6yfvmI96X/AIV07xyO9HG3zW
 ZbffDmN6xnLIUtHmBNKQaajHR1+k6kjM5X3eOUaiggfPqXyVK6/XondzXUVX0QucZ4g7
 xi8OY2fOXMaePegElJX3IrMtkE8xPn63U+tqJTYOQ/hShi1gbvWEbKtQv9ZZxx1XJHR5
 7oZkf4upsQdnm8WxpqeZvybPTyvuMmYFqi+QM9MEJ6zT09dlQmuo4QNR5iCnAmjV0suo
 JMDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=lTpwyJHgQk7FXhYlA6hc0Xmept2/SbS4lw4XoRFkGww=;
 b=WidehSnJx7RWVm9NVE53ak0Yg3cdRPsii0k3a4vlHp3fKYaLOF+4i7s/oBaxA5MgDt
 38PBYCqJjBdyw8GOzB3oPaDA+tTPetZo41PuSoYLWVxvm80/ZcXpYo3hUKEF9TOXCiCG
 WzhJ7R5pECNSGWkY0Hyg527bdn1KD2blgppnYHPnupGEp7lHTlazqDrL14F65p9U8vUF
 JHS6pnnMaPnvBP6rF+pmuOq4PAalQbx7edUcYc/WEDT6/bCQ2kC4s1olR/CFcqGaLNLi
 xGnaf5i+eg29yi4O0Nnn1WZs+vYRHgRiQ4HAb0QAHEMvhTSjPou2CitcTJ3W8hJ07FmW
 x86w==
X-Gm-Message-State: AOAM532MSUhRc9QXYo0moL2L5yYmWRSqYR6GUkMPXf2RMYcSfso3675x
 i+Pi96naw9Xs1kZtjikWCxHV/EnVwMg=
X-Google-Smtp-Source: ABdhPJzTZSl1ypNTIQGez0mnmXoqNjvSEOJSIBr1/1nNu++pUrZPnZgdlmy+h+IZQs/Fcpq15jxnfg==
X-Received: by 2002:a37:9ec8:: with SMTP id h191mr6783455qke.174.1611685038514; 
 Tue, 26 Jan 2021 10:17:18 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.237])
 by smtp.gmail.com with ESMTPSA id q50sm14374129qtb.32.2021.01.26.10.17.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Jan 2021 10:17:18 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/pm/smu11: fix static fan speed readback
Date: Tue, 26 Jan 2021 13:17:02 -0500
Message-Id: <20210126181702.48944-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The xclk needs to be divided by 4.

Fixes: acab02c1af43d3 ("drm/amdgpu/pm/smu11: Fix fan set speed bug")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 147efe12973c..36dac106ed4b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1245,7 +1245,11 @@ int smu_v11_0_get_fan_speed_rpm(struct smu_context *smu,
 	if (!tach_period)
 		return -EINVAL;
 
-	crystal_clock_freq = amdgpu_asic_get_xclk(adev);
+	/*
+	 * crystal_clock_freq div by 4 is required since the fan control
+	 * module refers to 25MHz
+	 */
+	crystal_clock_freq = amdgpu_asic_get_xclk(adev) / 4;
 
 	tmp64 = (uint64_t)crystal_clock_freq * 60 * 10000;
 	do_div(tmp64, (tach_period * 8));
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
