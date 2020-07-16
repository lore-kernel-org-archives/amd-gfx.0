Return-Path: <SRS0=xwQz=A3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EAE4C433EB
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2020 21:23:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6040320787
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2020 21:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QLl3HtJm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6040320787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED8AB6ECF2;
	Thu, 16 Jul 2020 21:23:20 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48B006ECF1
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2020 21:23:20 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id f7so8664529wrw.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2020 14:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QBZ+0sn9WgLJddSZLHK/phmJ6CAzog/1X6eJ6Ply238=;
 b=QLl3HtJmmeegBDAp9haWQUK/9qgBxdSqy8OJGPsEwdIcbaj5KetwzdC8nn+6MXq9Zf
 SnGe17bVGfdBFmzB4QrK7wpRvQlw7hC9WFsYEyJmLpeCrIAZQ2k6RwQP6hRPw4qeTb8Y
 wj3cI3dZGveO3J5xIOJXmX6OnFy5uYoQ9WnGmEk5rzLSNxLR885gjkHfoWNn5Rbnnnei
 zrujcVqpl+U7rJlP5HC8VFPQGlFJrSxX7TgXb6iX6w51/3jfpjaJC/is2IybOMS0m8Bt
 WslNtl1t94NEJyuoomztiLOIQ9XW5mBEmN48y4TKAtO+X87oKqSltqqwmhWaRWICd/wb
 jfFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QBZ+0sn9WgLJddSZLHK/phmJ6CAzog/1X6eJ6Ply238=;
 b=g8Q6eu3O+TsOeeOPWl+qbIiQBLm/GamS8c8nrgI45wJ8FjOwVfvo58y+9IePo1/AUz
 TEI1PsajoHTQ0Tfeam6lrIqWqO8sRP532I+5L40kt3tGYNXNYFUP+/2clW3KjvR1IAu1
 CpYlw3y6lc0+S+3Q9dCUhNfeV7jHeBc6qA01rbWvzdehkddJY64Z4rgDYlEeBKDT3iGy
 /2zT/QSHoZKBPjwO+s7yNeEK33hX/5NsSry/RaW+Z+EEVy9nCVmA96FowvmovHlnMW07
 yFQ/qSATwaGQHNOoM6C96FgNFvmx1FZ+WcXezZAo4d47LcnLyiJhnPm5s21ZOUtomA1/
 Eo/g==
X-Gm-Message-State: AOAM532YfQtFj8xQlBLxWvj72SWilR1YrxClbF5AMnFXwsccO6Mu6MAt
 S4no6BKRMSk/H3BfOalYTJnBnWOH/2c=
X-Google-Smtp-Source: ABdhPJxyJg9Q+bRUlRJqcL8Gc4Er9BKnumBw8O2AlvE0GVudkT7Rc+hl8aa8ygKSmrTxoJwm3Smiog==
X-Received: by 2002:adf:a111:: with SMTP id o17mr6682506wro.257.1594934598543; 
 Thu, 16 Jul 2020 14:23:18 -0700 (PDT)
Received: from utente-Giga.homenet.telecomitalia.it
 (host-79-21-65-179.retail.telecomitalia.it. [79.21.65.179])
 by smtp.googlemail.com with ESMTPSA id c15sm10288696wme.23.2020.07.16.14.23.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2020 14:23:18 -0700 (PDT)
From: Mauro Rossi <issor.oruam@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v3 10/27] drm/amd/display: dc/dce60: set max_cursor_size to 64
Date: Thu, 16 Jul 2020 23:22:34 +0200
Message-Id: <20200716212251.1539094-11-issor.oruam@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200716212251.1539094-1-issor.oruam@gmail.com>
References: <20200716212251.1539094-1-issor.oruam@gmail.com>
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
Cc: alexander.deucher@amd.com, Mauro Rossi <issor.oruam@gmail.com>,
 harry.wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Issue in the Mouse cursor size in Linux Desktop Environments

[How]
In DCE6 dc->caps.max_cursor_size need to be set as 64 instead of 128

Signed-off-by: Mauro Rossi <issor.oruam@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c b/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
index 9d21cfba6009..179f67ed7dbb 100644
--- a/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
@@ -970,7 +970,7 @@ static bool dce60_construct(
 	pool->base.timing_generator_count = res_cap.num_timing_generator;
 	dc->caps.max_downscale_ratio = 200;
 	dc->caps.i2c_speed_in_khz = 40;
-	dc->caps.max_cursor_size = 128;
+	dc->caps.max_cursor_size = 64;
 	dc->caps.dual_link_dvi = true;
 	dc->caps.extended_aux_timeout_support = false;
 
@@ -1168,7 +1168,7 @@ static bool dce61_construct(
 	pool->base.timing_generator_count = res_cap_61.num_timing_generator;
 	dc->caps.max_downscale_ratio = 200;
 	dc->caps.i2c_speed_in_khz = 40;
-	dc->caps.max_cursor_size = 128;
+	dc->caps.max_cursor_size = 64;
 	dc->caps.is_apu = true;
 
 	/*************************************************
@@ -1365,7 +1365,7 @@ static bool dce64_construct(
 	pool->base.timing_generator_count = res_cap_64.num_timing_generator;
 	dc->caps.max_downscale_ratio = 200;
 	dc->caps.i2c_speed_in_khz = 40;
-	dc->caps.max_cursor_size = 128;
+	dc->caps.max_cursor_size = 64;
 	dc->caps.is_apu = true;
 
 	/*************************************************
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
