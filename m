Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C0B4FDEE4A
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2026 19:15:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C34D710F291;
	Thu, 23 Apr 2026 19:15:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fal0+GUs";
	dkim-atps=neutral
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D31E10F277
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 19:15:35 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-43d734223e4so4852750f8f.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 12:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776971734; x=1777576534; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A9uvbBZ2Qc5YXCxY3h27T/Lac7VU24+ediAyFLI8bzM=;
 b=fal0+GUsEUhFlo1hXqBY4kNvHNmuPxxNUUJpqC5bS2wDy8Mx792kkqkQ91Ndg5MGXB
 06r5ndIOjwlXhDGyWAUf0C3et73E+D1eA3I1jaOQ0sRLEi8hoVW9CpAcE/VFt2aAZX26
 pD7jR8cphTlq/hfVH2rEipwS0E8+tXDhPWTCD6D386uSWratEFB06U3vM3/7l5ZISV9w
 j9Ekzh5PiEzZRopZM5D/Orrn12gSEq0m9E3CGpTMXqYnX3tKySQxRdSgIVIPrbSB8+QG
 J7vuHfKdCA1qZfwiqLjVRYCM1ufLdZ2XwNTTWQFfoo18hB3T6WdtI7XzEgj+mHo3Ct8Y
 INog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776971734; x=1777576534;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=A9uvbBZ2Qc5YXCxY3h27T/Lac7VU24+ediAyFLI8bzM=;
 b=Y0xWnOhAnKi61wkJBYeqNcUHMzgXa+cuhACqrpxUQaUVCNqFRX3nEtXj3wEnNCaWHQ
 i7fYDujBo8H/sCuflYrljyI3WKma+e2pGCIb7htehXVs4sEbM9SQcSneMgL2/cMVmMo6
 Dvkk3lkbSoWOYfYKtmVIQxX4CgCVP0het/y8aEvBdGCIKGbrDAzzyYBk5GxtZizfoZXP
 7smtb8aBJR4PAafEyfuhy/lcB2WQ2DwnIO/ZM29MUXyKS2M8lYTONLfIgOBgtZdRmjBI
 Q40lHHzipNGKDwbpgfklp+rOxx8YzP0NtbJyd3w99uUNZ6LOwGOgwo1f8jP6MOFYYWYJ
 eoIA==
X-Gm-Message-State: AOJu0YwQZJM6VZ/vitZp14pxUNJf7ERDnopeIlNBUcNJ+WGsKeZh0Lec
 8xBqF7euvqERf8j8bbrOgJMW2t+Hw4o+Fn1ynbN+2xM11XFPTRH/yGATsd73oWou
X-Gm-Gg: AeBDies55ZpA9Fd8mvrCUuKIK2qkzQ8sybnks7LVXdMd5luvVGHXmFxTN/luXNHSkl/
 5UgVUtLuFCucw0A6VtQq+gDBXbypOtfUmDJz/uViTp3hORYM281NDAw8ck5NbJ8oGm9qiQrcux2
 vlTKKs7HzxKDgPCaj7UbcW5oygQU10WPNuk2TUBef/a3Md5oA2JUgTVKmwsl0RgW3MizaPeIlgV
 /N/aZftk0lOdS7X2JOGVWlV8WfckULKpeD/KW+SL0ayXgc6SOuYzfkqjjKJ6ImUAMAkUEA6EjQP
 JDRBUkXd1Up3h/DGH3MfusScYAO8BNLBVqeij5porpltOMqSy2+6tj58yvhMat4K8Su2GFh5Vis
 pYPAlGw2dTbfCUQCvdaEeOERrUgic9hag/6Y6MYhpb/I4Xo4ka3JbAk4vCUBuqsDnZ3iUu+F8qp
 RMUS+0hOTe1OW+QoVUljL/cgyMhPF1WFXQ2LNo8oX2pibG6wDMOl5kndkNN7FHGkko0gaCFee7a
 +IlzQ==
X-Received: by 2002:a5d:4527:0:b0:441:29c5:f90a with SMTP id
 ffacd0b85a97d-44129c5f92bmr6085578f8f.22.1776971733941; 
 Thu, 23 Apr 2026 12:15:33 -0700 (PDT)
Received: from Timur-Hyperion.home (5E1B98A2.dsl.pool.telekom.hu.
 [94.27.152.162]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-44123d23e0bsm15792782f8f.15.2026.04.23.12.15.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 12:15:33 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Alex Hung <alex.hung@amd.com>, Harry Wentland <Harry.Wentland@amd.com>,
 Roman Li <Roman.Li@amd.com>, Leo Li <sunpeng.li@amd.com>,
 David Airlie <airlied@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Melissa Wen <mwen@igalia.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 11/14] drm/amd/pm: Delete non-functional SMU8
 get_dal_power_level implementation
Date: Thu, 23 Apr 2026 21:15:16 +0200
Message-ID: <20260423191519.73127-12-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423191519.73127-1-timur.kristof@gmail.com>
References: <20260423191519.73127-1-timur.kristof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This function was effectively a no-op because it always
returned the maximum possible power level, because the
maximum voltage is in millivolts while the dependency
table didn't contain actual voltages.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 .../drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c   | 22 -------------------
 1 file changed, 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
index 736e5a8af4779..8a37c745cb117 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
@@ -1522,27 +1522,6 @@ static int smu8_store_cc6_data(struct pp_hwmgr *hwmgr, uint32_t separation_time,
 	return 0;
 }
 
-static int smu8_get_dal_power_level(struct pp_hwmgr *hwmgr,
-		struct amd_pp_simple_clock_info *info)
-{
-	uint32_t i;
-	const struct phm_clock_voltage_dependency_table *table =
-			hwmgr->dyn_state.vddc_dep_on_dal_pwrl;
-	const struct phm_clock_and_voltage_limits *limits =
-			&hwmgr->dyn_state.max_clock_voltage_on_ac;
-
-	info->engine_max_clock = limits->sclk;
-	info->memory_max_clock = limits->mclk;
-
-	for (i = table->count - 1; i > 0; i--) {
-		if (limits->vddc >= table->entries[i].v) {
-			info->level = table->entries[i].clk;
-			return 0;
-		}
-	}
-	return -EINVAL;
-}
-
 static int smu8_force_clock_level(struct pp_hwmgr *hwmgr,
 		enum pp_clock_type type, uint32_t mask)
 {
@@ -2063,7 +2042,6 @@ static const struct pp_hwmgr_func smu8_hwmgr_funcs = {
 	.store_cc6_data = smu8_store_cc6_data,
 	.force_clock_level = smu8_force_clock_level,
 	.emit_clock_levels = smu8_emit_clock_levels,
-	.get_dal_power_level = smu8_get_dal_power_level,
 	.get_performance_level = smu8_get_performance_level,
 	.get_current_shallow_sleep_clocks = smu8_get_current_shallow_sleep_clocks,
 	.get_clock_by_type = smu8_get_clock_by_type,
-- 
2.53.0

