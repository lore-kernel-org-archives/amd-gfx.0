Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1D6CCD8CA4
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Nov 2025 16:34:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7817C10E8D2;
	Thu, 13 Nov 2025 16:34:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VAYYqzFK";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE4B510E8C0
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Nov 2025 16:33:55 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-47118259fd8so7741725e9.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Nov 2025 08:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763051634; x=1763656434; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EBjOqFJU8IfmSQi1e5KlIEO+YZVq2W+I3N/cwznMz9M=;
 b=VAYYqzFKtlw1ichIWSKHWlWR/BkM+j5etVMRAEecNa9lYyIjDvlMiR6/zCqXeFV7Z/
 2mq9Gkww6YWjdxBhEHex1iiqYLIxCHtHV7lrMUMc3GLwGBtDgHNG6kNMAoSZMk3h9whj
 2wzYNAqp/Gy/+Mq2atuc5vtMRTUERU+BPSNJKzp7XwHYBMMXI0Gi7xEINbEuN3Zmhq8H
 LPj2dUbyeVTsOxUD5trmbsnA2lI1LVG8hR33sY8lIvBWdE9M4MFFUpyVJSHe17iIHLh+
 REZ+mEqEN4FG1ziPy15sAnpiOObe6tpbIe3plgyUBcCMpJBz0gQxuZyhyMxt1S58Id6u
 m5Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763051634; x=1763656434;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EBjOqFJU8IfmSQi1e5KlIEO+YZVq2W+I3N/cwznMz9M=;
 b=ideFv6Yx3xDNrnKx/UaIvkpTuCY9KsbLvu1lnZg2/WkfNY33sTLzJW6pDBU7t/eNnp
 IbxbJ3YuUNIMaoKx1bJQTxvzC/cKhIUgR0NeYJWdu+jaa9L/oLmg9GQKWBj7CD/ZVTkh
 6XaZ/STe4kr+aQ0778fHDEfH2ugpHMezvbYPoM0HwDNp6XrTvtuIWftCG06xmABLWKby
 4qlKfvsj8t2h7lbz9hyEtCDyaZfQVwn6xkmxk1SFSQKmDxjBXo2Gmvcuw1Nd5AD9sAY2
 CdwZnnsbNQZgQgCbzYV6ji6OqhZC8c+ld+tvqesFcpg8kSisJxABZ3Tr01rU7PUqQfP/
 V0OQ==
X-Gm-Message-State: AOJu0YwINa1lkP2ldJcwvI73t71OZlLLp2ZHIeRu/5SPCLXj+HofYDOa
 lz5fjqvfOd9RvTWwfb0KYy30yqp3tB4uF2E2NjVhbwo9uCO51uGPX8lAzGfobA==
X-Gm-Gg: ASbGnctINOI82A+yeG3aZCdtm+wv03DlVDiNeX8UD18iRcwWI67Gho00JrvDoGYwUxo
 +c2fd4+rmrLsO5ttcBr7vj4+udQBGIxp8plT5/d26gTgqb7gw3a2/gUZTS4BjHXv7VTII626hfi
 Vh6H+p8CNS6ROOAjCxb0TJxzL3koPi72K2OysSLcei7Lll5M2yO7HoqQlL1h7H+ETpYQD0PWfs+
 +XBglFcZOUHBLZSvGVJCvqjxCD3LbcyNaYzKv/rJw+3Pt+WODB61VnXwebm1RFVRar9lslTwr8V
 7UKu1NwuWkwyk/JCPEALwPj2xD4/oJ/mTfuSYCiTqWUxFv3/hCMo9Ij6GRyI56ASs+S8ARN/H4l
 rWgDtRlU3/cYxIrRX9MM/cRa3ba0jYtcSL8UAfefj3I9z7HN1I0fa1ug97xYZrVyHPVdskRuRiR
 F84l8S68kxGjcUM8emu7slf9/RainVe7qDoaAsHmnqxe6MErsVagfiFzW9W9m7LuOSnLbUWIpXR
 Bbohqt5Snne6z4Zh2chIMVYhVDiQw==
X-Google-Smtp-Source: AGHT+IF6d5Sa5huPQlbSE0sJqku6pzlKSooL7HtDwWSJGjEc9Lf5uWh1rHNG+mXYIZnocafClD6pqQ==
X-Received: by 2002:a05:600c:1387:b0:477:7b30:a6fc with SMTP id
 5b1f17b1804b1-4778feb13femr1027175e9.30.1763051633364; 
 Thu, 13 Nov 2025 08:33:53 -0800 (PST)
Received: from Timur-Hyperion.home
 (20014C4E24E1AF00BA2088E69F553967.dsl.pool.telekom.hu.
 [2001:4c4e:24e1:af00:ba20:88e6:9f55:3967])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47789ffea1esm76376335e9.13.2025.11.13.08.33.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 08:33:52 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Ray.Wu@amd.com, Harry.Wentland@amd.com,
 Alex.Hung@amd.com, Wenjing.Liu@amd.com, Chris.Park@amd.com,
 Yu.Wang4@amd.com
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH 2/4] drm/amd/display: Cleanup uses of the analog flag
Date: Thu, 13 Nov 2025 17:33:46 +0100
Message-ID: <20251113163348.137315-3-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251113163348.137315-1-timur.kristof@gmail.com>
References: <20251113163348.137315-1-timur.kristof@gmail.com>
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

In the detect_link_and_local_sink() function, do not modify the
EDID capabilities of the display based on the connector. Instead,
respect the analog flag better and when the analog flag is set,
check that the connector indeed supports analog displays.

Suggested-by: Ray Wu <Ray.Wu@amd.com>
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 15 ++++++++++++---
 .../gpu/drm/amd/display/dc/link/link_detection.c  |  2 --
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index aa31e969b39d..9703f7fc957d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8665,8 +8665,14 @@ static void amdgpu_dm_connector_add_freesync_modes(struct drm_connector *connect
 	if (!(amdgpu_freesync_vid_mode && drm_edid))
 		return;
 
-	if (!amdgpu_dm_connector->dc_sink || amdgpu_dm_connector->dc_sink->edid_caps.analog ||
-		!dc_supports_vrr(amdgpu_dm_connector->dc_sink->ctx->dce_version))
+	if (!amdgpu_dm_connector->dc_sink || !amdgpu_dm_connector->dc_link)
+		return;
+
+	if (!dc_supports_vrr(amdgpu_dm_connector->dc_sink->ctx->dce_version))
+		return;
+
+	if (dc_connector_supports_analog(amdgpu_dm_connector->dc_link->link_id.id) &&
+	    amdgpu_dm_connector->dc_sink->edid_caps.analog)
 		return;
 
 	if (amdgpu_dm_connector->max_vfreq - amdgpu_dm_connector->min_vfreq > 10)
@@ -8693,7 +8699,10 @@ static int amdgpu_dm_connector_get_modes(struct drm_connector *connector)
 			amdgpu_dm_connector->num_modes +=
 				drm_add_modes_noedid(connector, 1920, 1080);
 
-		if (amdgpu_dm_connector->dc_sink && amdgpu_dm_connector->dc_sink->edid_caps.analog) {
+		if (amdgpu_dm_connector->dc_sink &&
+		    amdgpu_dm_connector->dc_link &&
+		    amdgpu_dm_connector->dc_sink->edid_caps.analog &&
+		    dc_connector_supports_analog(amdgpu_dm_connector->dc_link->link_id.id)) {
 			/* Analog monitor connected by DAC load detection.
 			 * Add common modes. It will be up to the user to select one that works.
 			 */
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
index d163360a2bf6..6d31f4967f1a 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -1224,8 +1224,6 @@ static bool detect_link_and_local_sink(struct dc_link *link,
 			break;
 		}
 
-		sink->edid_caps.analog &= dc_connector_supports_analog(link->link_id.id);
-
 		// Check if edid is the same
 		if ((prev_sink) &&
 		    (edid_status == EDID_THE_SAME || edid_status == EDID_OK))
-- 
2.51.1

