Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3EE5FDEE3F
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2026 19:15:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80BF010F296;
	Thu, 23 Apr 2026 19:15:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="juXPsUrq";
	dkim-atps=neutral
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A8A210F23D
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 19:15:32 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-43cfce3a195so4115133f8f.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 12:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776971731; x=1777576531; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fUH28T2FA9Ddfx4PgnFrSifOGtQskH0QOOs8VhQ9W+k=;
 b=juXPsUrq2AbKTqwakf9xVHYqj7rX7ojmcbmHwKTUgLgjhhfs9xqGIcOzJTKCcKxhCa
 vvG37mO7w5LasJPeWf8ZWaDVdrihIbwKPa6vgltTU6k3XcFTOA8NQXbWubUnixJO3JrP
 Drt3ExVGZlF5BcJB/n815Wk7WerHB4UbcEXLshKVHB/dIiG6iTvilQIe3x0X1hH4sq/z
 GDcoe8xEuCl0NJuNvMkvfm78R9iqpCV9wulh/n0E3B8BRStagz/OyattXS8+ErRIbYks
 xwjCH4PNdTd6XRq93MKmSerADDsjbZGbq1N+F4uuRZRDD+Jpan3Y9VrLvQ3UH31nnnXX
 tePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776971731; x=1777576531;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fUH28T2FA9Ddfx4PgnFrSifOGtQskH0QOOs8VhQ9W+k=;
 b=F1tyaBchcbs/UkCAtbAbeN85Jel7khqXiGUUBlZSoFOQKXD0R48O5NCSMoDalPv//4
 foFpDP+qkCI454jJtmOCBGtifVgSo7ud5VWqtKis9RMmLGTfyRVWgm+LXwO5CzY8qQwh
 XuiTOuNvDjuxzKmYGhRsa+aOOAeIP1FhBhFq3p4dGQOiqYSkmVZw+Ao9/tqEFwpHCxVx
 txP2XnyiKFq261o2h7LGvsJq+pIkNKICJOBf+/pf1ikxvb5xr4khgeNbKrb7n9U5Ccdv
 TQqoQJXjjO31f1S5E6EsgR0+umubUJqonXtEzhXDntJVzFItLNA9KNAbn5aP6ucjEwzz
 Q/hg==
X-Gm-Message-State: AOJu0YyTaMfg+LtMT6u+norr9s5jRN4enaZ0NkTAtaYjEbQC/e9yeZmo
 ha8nHP0BPmefF52ZEZxqc+CquKZ2v67/S5u3b//3d+/OgdJFX0fD02dJyrkIelTx
X-Gm-Gg: AeBDiesAzNtJ9ENNfUWjRfQlJNXd0D0dkG5RFfQS1EZE2TBIHu/woXD0lRBmSbOZzs7
 Ky9kfaDXVUW8dBgKM6vDa+O7aZ/EDHhSQBFkbv+72EMxSDcrYhVvV79fOrs1oLqWzJdbDtFBP7V
 YsmMACwr23gPBv+zbvgTHD/R5K+BRslJbiQ04qSegWaRMvR5zQ1QAJk14hg/MuXfmqW4+6kYV7C
 Wu5zj691PxiPoLr/k32pODS/+0lA6rKLqCbnHta2/dWXfaxiq3Gw/xGndRLVE7SywZ/Pgts4WXi
 m8271b+VopldR+2jrqdo3kaot1jIuO2h9m+lFgAEU4hwtE+URY69R8frYz2a2sJpKE/INdmu5WZ
 j1OMjrDfJn6GxYah9K7c2KP8NvZaAJ//z6LPs5yK2QwATGLHWHim3beHsHqJOCoOA71JTMCsBNS
 urCwTMD2Kq3e7s9ge2UPzRSXKuM4ye28373hHLzDqrJ7ZaLP3H6IU+7zwxLpiPRY27l6+3Sm8yQ
 a5LZSyV690S9rOJ
X-Received: by 2002:a05:6000:1785:b0:43c:fc5c:a9fe with SMTP id
 ffacd0b85a97d-43fe3dbf4e7mr43836826f8f.20.1776971730707; 
 Thu, 23 Apr 2026 12:15:30 -0700 (PDT)
Received: from Timur-Hyperion.home (5E1B98A2.dsl.pool.telekom.hu.
 [94.27.152.162]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-44123d23e0bsm15792782f8f.15.2026.04.23.12.15.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 12:15:30 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Alex Hung <alex.hung@amd.com>, Harry Wentland <Harry.Wentland@amd.com>,
 Roman Li <Roman.Li@amd.com>, Leo Li <sunpeng.li@amd.com>,
 David Airlie <airlied@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Melissa Wen <mwen@igalia.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 08/14] drm/amd/display: Delete dm_pp_clocks_state
Date: Thu, 23 Apr 2026 21:15:13 +0200
Message-ID: <20260423191519.73127-9-timur.kristof@gmail.com>
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

It isn't used by anything anymore.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 .../drm/amd/display/dc/dm_services_types.h    | 27 -------------------
 1 file changed, 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dm_services_types.h b/drivers/gpu/drm/amd/display/dc/dm_services_types.h
index 44aa8d213d386..b3505d93503fd 100644
--- a/drivers/gpu/drm/amd/display/dc/dm_services_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dm_services_types.h
@@ -36,30 +36,7 @@ struct dm_pp_clock_range {
 	int max_khz;
 };
 
-enum dm_pp_clocks_state {
-	DM_PP_CLOCKS_STATE_INVALID,
-	DM_PP_CLOCKS_STATE_ULTRA_LOW,
-	DM_PP_CLOCKS_STATE_LOW,
-	DM_PP_CLOCKS_STATE_NOMINAL,
-	DM_PP_CLOCKS_STATE_PERFORMANCE,
-
-	/* Starting from DCE11, Max 8 levels of DPM state supported. */
-	DM_PP_CLOCKS_DPM_STATE_LEVEL_INVALID = DM_PP_CLOCKS_STATE_INVALID,
-	DM_PP_CLOCKS_DPM_STATE_LEVEL_0,
-	DM_PP_CLOCKS_DPM_STATE_LEVEL_1,
-	DM_PP_CLOCKS_DPM_STATE_LEVEL_2,
-	/* to be backward compatible */
-	DM_PP_CLOCKS_DPM_STATE_LEVEL_3,
-	DM_PP_CLOCKS_DPM_STATE_LEVEL_4,
-	DM_PP_CLOCKS_DPM_STATE_LEVEL_5,
-	DM_PP_CLOCKS_DPM_STATE_LEVEL_6,
-	DM_PP_CLOCKS_DPM_STATE_LEVEL_7,
-
-	DM_PP_CLOCKS_MAX_STATES
-};
-
 struct dm_pp_gpu_clock_range {
-	enum dm_pp_clocks_state clock_state;
 	struct dm_pp_clock_range sclk;
 	struct dm_pp_clock_range mclk;
 	struct dm_pp_clock_range eclk;
@@ -246,10 +223,6 @@ enum dm_acpi_display_type {
 	AcpiDisplayType_DFP6 = 12
 };
 
-struct dm_pp_power_level_change_request {
-	enum dm_pp_clocks_state power_level;
-};
-
 struct dm_pp_clock_for_voltage_req {
 	enum dm_pp_clock_type clk_type;
 	uint32_t clocks_in_khz;
-- 
2.53.0

