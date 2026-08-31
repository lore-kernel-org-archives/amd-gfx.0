Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D141C61DFD
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 19:49:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA9E810EADB;
	Mon, 31 Aug 2026 19:49:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gwQHUIGb";
	dkim-atps=neutral
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com
 [209.85.218.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CAA810EADB
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 19:49:42 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-c250a2bc3b3so11853766b.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 12:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788205781; x=1788810581; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=aiO2fK2x5TPIWYb6bMn+ph4f/a9tQnQbtffTFep6tBE=;
 b=gwQHUIGbu4BHC9/pojOt4F7kMFP8k6vlLLnFkyR0LOQ7zORMkeau+4sth3dMJHSsG+
 EsRPnFGhX+3xEExNLNjlskOgycNzDZIzI3fVzK4J3VreoHZMAqSN07cJz7gMQTxbC/kV
 gLBdNZ/DUTagy2GqA1l3jT2+66raMFUT/LDfL69RplEdOrZKT+ySyDycR4V3ubA+7lHv
 7O1ooobBuKdnonymF8lpJAX8QFea19t7GNn8en//FMNm4B7H/gtYG0H8CF1yYGW7qPrT
 3t4nCRv7MuxkqZeAyNsmPJ2jWaj4rVsBk1CXrNDQfDEYLRtEBTTUB7pyRmoVb3OKRIma
 j6pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788205781; x=1788810581;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aiO2fK2x5TPIWYb6bMn+ph4f/a9tQnQbtffTFep6tBE=;
 b=tSXEUbu2BgyMa6/L1v8W1iRMT5qzyhWtDYmx8jDSc8cghp6B3RPDKQ2g8/BFs5uKcB
 zUaBwQdrkIw6MomaMro1hSrG6mGdskI96LzRA53r4eZg8/C3FKL1FTG9tXhjuNCu7fjS
 jc8rvXo32BrFq1ZlU+zqNALKhHlMCnVRBVvCPx8lGTJ/wPHyG6TtbxlUZOvo8QxLjlQ2
 1Ts+ihpw5Aas4kZculBdTz2ZE7WaRY+bIvsxm8wiuqJUyC9Z/+HHQKPRn0jEBh3tNyjw
 5UIfT5AitL9wXYKasG/zfJu+l6OgrOmJPcqLiYllMtPS7P18zHxnV4x9BlOQNccvpzBK
 gyUg==
X-Gm-Message-State: AFuF++kHxyP2HC1xE4mutL9eS9vzRAQKv6Q2UykFsdiWjT9H4PHC9VSs
 l5hINZ2XVvHf5fzIIIid4WfPKKa4vAKwA8DtCRAzyEMQr8hE+ZBTZx/SJPTLXdk3
X-Gm-Gg: AR+sD11wz1GnXQP2HOnGqhEqEh5x5M0uh3Yaf6aBRQAr+JVCAOisfKn087gh70E5dS4
 fNanVV8y6koixvvIlJlR3TZXsewqRCAfuuMzOZYSgU3h8EqDmgozlEII9GeF1cJFZIQ4krhgkM1
 pj448bEg5MAW2hdIhXR5j4CDvab0Z+VdzATAMQnu0GgcZ+tzj56ssupnobOuiuS7MUneKArYHQj
 gAsGR2BnDMtneLPacl981X1BPjqx/Nu9NBlALlxtzZ6827OwjQpWNcvwXjIxROeOpKHlgxcu7qI
 c1j2X+RJFQ0XARmVRMuXJHoITT0vLYltvuDoE0G+87mV1jfvgf6zt+ZrjSbh/6dO97YA5bRkMPf
 hVykhMSOlbVqzTR/yHi/BJBdLuj7VuXgtkpCGKEPHi0gVK/2cz9QAV1Q03I+zgEIiuNbnveDLOJ
 RnYs4PahdZVcg725BWBQtFqD2hVrGcFqnT+tFJsXMxBFBwjE2Hose1XlrEcXw174CydpprJwHER
 1x3q3f2DDvNkNmAbcrnRA+q+LSCzMIOJLtfG3Y9kdD8NeIOkg==
X-Received: by 2002:a17:907:d2a:b0:c24:c250:a6b5 with SMTP id
 a640c23a62f3a-c2557200b60mr1764359866b.12.1788205780581; 
 Mon, 31 Aug 2026 12:49:40 -0700 (PDT)
Received: from office-omarchy.localdomain (89-64-240-222.dynamic.play.pl.
 [89.64.240.222]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255f1facbcsm473200066b.44.2026.08.31.12.49.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 12:49:40 -0700 (PDT)
From: Dennis Thomsen <dennis.fich.thomsen@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, harry.wentland@amd.com, sunpeng.li@amd.com,
 Dennis Thomsen <dennis.fich.thomsen@gmail.com>
Subject: [PATCH] drm/amd/display: Guard NULL DDC pins in dal_ddc_open
Date: Mon, 31 Aug 2026 21:49:26 +0200
Message-ID: <20260831194926.274044-1-dennis.fich.thomsen@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
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

[Why]
dal_gpio_open_ex() can return GPIO_RESULT_OK while leaving gpio->pin
NULL: a concurrent HPD vs display power-down race closes the pin after
the open succeeds and before FROM_HW_GPIO_PIN(). dal_ddc_open() then
dereferences pin_clock->pin->store.en (NULL+0x28) and the kworker dies
with IRQs off, hard-wedging the machine.

Observed on Radeon 890M (DCN 3.5, Strix/Kraken) after DPMS-off when the
DP sinks drop their links.

[How]
If either pin is NULL after a successful open, close what was opened
and return GPIO_RESULT_OPEN_FAILED so AUX fails instead of oopsing.

This does not serialize HPD detect against DPMS-off; it only stops the
NULL deref turning that race into a hang.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/5716

Signed-off-by: Dennis T. <dennis.fich.thomsen@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c b/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c
index 95f8b7c7d657..af66978590a8 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c
@@ -577,6 +577,13 @@ enum gpio_result dal_ddc_open(
 		goto failure;
 	}
 
+	if (!ddc->pin_data->pin || !ddc->pin_clock->pin) {
+		BREAK_TO_DEBUGGER();
+		result = GPIO_RESULT_OPEN_FAILED;
+		dal_gpio_close(ddc->pin_clock);
+		goto failure;
+	}
+
 	/* DDC clock and data pins should belong
 	 * to the same DDC block id,
 	 * we use the data pin to set the pad mode. */
-- 
2.55.0
