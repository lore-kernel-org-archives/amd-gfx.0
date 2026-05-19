Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F569CD4851
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 10:21:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1447910EC07;
	Tue, 19 May 2026 10:21:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="n/cv/fku";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73E6610EC05
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 10:21:34 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-441209fb77eso1989616f8f.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 03:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779186093; x=1779790893; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=08y0z9eKwFIrC7hXm+XqSGuVMGx83QeCyl2mmgvek7M=;
 b=n/cv/fku2dTWn1VU+ugCjKoVJc/VqERoaDKssrGOlLEXrWlX0REJMK5jx+3ypaUjPR
 zJ6uYK8aryk6ky+Ckoj7KTIaF4uIu8RzryAOIU1gAATSEG9LsJy89EvIVZMxq2H+9Pcg
 gWXRkoJy+3scyOj0xls4XXXnEvXnBnlr5nBnn6CjQ5vV8eQA6dEo3MsFrd4PmF6EkPWx
 gukFzsG6eiZ5jxQWwxPPehm2tHSayZAnKQjgfg2hUSLXeet6Qat9rav4Y5HSAeKkb5yH
 J6uxvJLhPWUU8EIXbJyvAdtJwRBMGhbFjHQQQgIq0IN7aJH2p9O3ur31Cem0L1kv5fFH
 Coow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779186093; x=1779790893;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=08y0z9eKwFIrC7hXm+XqSGuVMGx83QeCyl2mmgvek7M=;
 b=bi4vKvM7czGAOpIDwtvY6V89hEYkfjkLzuIaoa3wLYRdewnK8myvWJvs22gXHClfps
 vp+WkzE2zwJUjLWV1YKqhBVmghR6uuKDh44WlqPnhp0Pj+6olA38QhTERKVGsU5UoGp4
 U7wfWVJxtxJOvaNQtgnkLa74qqdVUAjAbCpqPiNKr7wJtLsE4BdsB91io4K1OHegvw3k
 1CdA8RyyfLiFBGDwQya5Dhdm4iG78ImxB70cHTw+XCzbT8V2zFuSLwsoDZFxAVPAeOJi
 H8dKm/o9DwvrzKyn03CnJegzUedfkhcNwMFo/ViyBZQFt9hCR2UIEaz1oYQ0bq4Xni4U
 ituA==
X-Gm-Message-State: AOJu0YwNLoLswqR2zU6q9vKcKNTcFW9nwrLBTdsL6Rwvy3UpxCkadS9D
 aKmgf/kgURwJO134eQakIrACaVJ3NG/k+J+JH9jUfjjEYhZu3/+wvkYDvd5dwUu3
X-Gm-Gg: Acq92OHnrTZypnPXuK6Ps+vs2egDcaiKZ0b3EJo0HhP/P9VCWfhHsh5k10L9r0XzbAk
 bUwrvYQzmnsnBdqwbwkbq/+3qItEZZA3GfkZUxKbLdJDcW4WU0FopmLrGTK96ZK1dHH20mdogL7
 7zyln8gHhOnO2sJ9IlYX65oaPGXiWyiW/3tE728lhbUiAQfxxh3jqmxwb8VSjqfOqxzDRCp+hRw
 ibx22+73XfcHW/kBBjNwg8pXk+9fuxrVz+ESdc8mngp/0h/c9KxDVelVkpXWoRaRmz827uf+R5/
 meTrSkLfkgmbaY7HsQRgxghpy6JcyriIoGOuNQROVM/sIIAG6eY5tf+ald+4OfIXJ0c4w7kOSjs
 BEbqaWbi6lhraxtcK2F8M1OOvL+PPs+hsb10zhpHKYcS6XcBFPeTZSR0hD8vqG1OWv1EMscFgJP
 JbRNWgTLeicXAzf8ijzm/sch32Icm1p0GaVYzy+sOeZaSxJb8ES4rms+vqMwYt1K1M0bjo9hyTV
 nc=
X-Received: by 2002:a05:6000:290f:b0:43e:a75e:352 with SMTP id
 ffacd0b85a97d-45e5b73b1d5mr31265652f8f.4.1779186092950; 
 Tue, 19 May 2026 03:21:32 -0700 (PDT)
Received: from Timur-Hyperion.home (54001290.dsl.pool.telekom.hu.
 [84.0.18.144]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0fe0fecsm41028224f8f.26.2026.05.19.03.21.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 03:21:32 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Natalie Vock <natalie.vock@gmx.de>,
 Melissa Wen <mwen@igalia.com>, Harry Wentland <Harry.Wentland@amd.com>,
 Alex Hung <alex.hung@amd.com>, Roman Li <Roman.Li@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 11/14] drm/amd/pm: Delete non-functional SMU8
 get_dal_power_level implementation
Date: Tue, 19 May 2026 12:21:15 +0200
Message-ID: <20260519102118.246466-12-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519102118.246466-1-timur.kristof@gmail.com>
References: <20260519102118.246466-1-timur.kristof@gmail.com>
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
Reviewed-by: Melissa Wen <mwen@igalia.com>
---
 .../drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c   | 22 -------------------
 1 file changed, 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
index 736e5a8af477..8a37c745cb11 100644
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
2.54.0

