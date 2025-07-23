Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4FE9C87FC5
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Jul 2025 15:58:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D96B10E801;
	Wed, 23 Jul 2025 15:58:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BEv9ViWs";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 188C510E7FC
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Jul 2025 15:58:24 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4561a4a8bf2so77451395e9.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Jul 2025 08:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753286302; x=1753891102; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=njfzCYqfRFRWosCr630vnhxLkqhsfzrmEJRGwNsaFMs=;
 b=BEv9ViWsg56M5xuw239pFogV432189xNelpaY6rQm6VTeTBar+e39lKuckNhc5acSQ
 6uDoLY5OyFZDtDV6f3wXzEGIpJdxh7cbItN90K5aRNivi6mmvK/8kyEpMuvFLpzFmpRH
 opB5cI9vp1oshWrjuMj/vN1ww5sEWtxjTf05SXicneU66jr7t7hM2RMSnNht11KlVfx8
 +JQ091EcwcHXIcs/LnPrz5TB/n+Q+awfGJrPmtZP/lxlNspjWNDvWsJzJFeGnxZ/Ntp8
 e+d1R5g/5/iFe0t/alQO37lJLihW3nVR9/0SK9zg0YwK2ag4/0FtBm/F23t5tieaOEMv
 WfNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753286302; x=1753891102;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=njfzCYqfRFRWosCr630vnhxLkqhsfzrmEJRGwNsaFMs=;
 b=mRH7baWKRUEbDf3wVAFy863a/qTFI3eBdpgfhlQ66vliK+h1hrA+xhj8yxrHcESHXj
 rJ3O8nqRK80Y5rUD5sRk4stXkjqZ2jfTbMtU8wYp8EqYnqHL+37PSMNtvjY6f1bfV0qp
 tqXyD8MZJB3L/FVVnvbGNjhdQaOE1/RDoBCgB0UxTvjbARzV06Jt6n2q92VSg0/epNoE
 i7gq0KxiRQOz4+/iTxLdih9+ANSs7CNlyo1kfDJurGolQVOlJbSAedq9jocAIUyqBkW2
 uqxYRUQmNoYwqvhJ6F411tRONBdrjJyRcVCTkAFHd3058ociECQIqdCBHsu2hALcMUuY
 m5kg==
X-Gm-Message-State: AOJu0YyZP7ZJBNIiLt2Q3ul+/XH+KppoVYhGkGf2MMTzPiv9KSK1s20q
 9KUyD1gDJtKQYk76FmRi6x4pan3xD1eCAuk3RN5N+5hihuEfaDXLcSIgT7M4cg==
X-Gm-Gg: ASbGncs5muU+Ht5bMamN18f1drQJbxA6rwWmrbiW/ZbBtjCFjWwjylHH1+9Kc+BUf1Z
 5bo9TRbpWVPmEAT+devq4LCBVqvT9A/uyvQUFClulZJaI8U/egCB3rJkNFNmMFOjKQ7SpFLTtm8
 K2WHZFmWNMVx+h7nNQcibDqkxPSvKf3pBxKuP1ebOIBg1Jpp0L4N4VmTVM/uRI6SYfHfiKwM6fl
 +IGeekg3/gNvMXffrVO3oaB4np8nV2AfWNUAJVary4fAHTyrtRDMzBv0qCBgVeMQO2gFkH+kUY2
 pjyeQdYOfl42A1xCU/TWgHX1FH7YP9gK2UnufNpS5YEQUprSxmtlO0oW0mkaRWQ7ZH9lGHjQxxo
 b8rZ64g5BoGd5gyTRacxgeeCcTe5olVn0rJEh7Zxg3JzeyttDwD0TZTiBXUyaJywVVwPK1YZnb7
 5Savs/0k2yPNGZCuUAhP47uJY4ys6MtMEHV+Wc
X-Google-Smtp-Source: AGHT+IGggcRuc0yiPRu6zwbx3w1TVb6O/2jAnuPtRvvsHcplfNs1GzWfJ4234niLn/4dm4omBWl7sw==
X-Received: by 2002:a05:6000:2486:b0:3b3:c4b1:a212 with SMTP id
 ffacd0b85a97d-3b768c9c16amr3212290f8f.7.1753286302225; 
 Wed, 23 Jul 2025 08:58:22 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4D24D8FC008443E005DD6C3C62.dsl.pool.telekom.hu.
 [2001:4c4d:24d8:fc00:8443:e005:dd6c:3c62])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca2bf99sm16710468f8f.32.2025.07.23.08.58.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jul 2025 08:58:21 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 02/20] drm/amd/display: Add analog bit to edid_caps
Date: Wed, 23 Jul 2025 17:57:55 +0200
Message-ID: <20250723155813.9101-3-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250723155813.9101-1-timur.kristof@gmail.com>
References: <20250723155813.9101-1-timur.kristof@gmail.com>
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

The new analog bit will be used with DVI-I connectors.

DVI-I connectors can connect to both digital and analog monitors
and this bit will help distinguish between those.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 1 +
 drivers/gpu/drm/amd/display/dc/dc_types.h                 | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 9e3e51a2dc49..95c00af04d77 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -129,6 +129,7 @@ enum dc_edid_status dm_helpers_parse_edid_caps(
 	edid_caps->serial_number = edid_buf->serial;
 	edid_caps->manufacture_week = edid_buf->mfg_week;
 	edid_caps->manufacture_year = edid_buf->mfg_year;
+	edid_caps->analog = !(edid_buf->input & DRM_EDID_INPUT_DIGITAL);
 
 	drm_edid_get_monitor_name(edid_buf,
 				  edid_caps->display_name,
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 375ca2f13b7a..10de0930adaa 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -185,6 +185,10 @@ struct dc_panel_patch {
 	unsigned int wait_after_dpcd_poweroff_ms;
 };
 
+/**
+ * struct dc_edid_caps - Capabilities read from EDID.
+ * @analog: Whether the monitor is analog. Used by DVI-I handling.
+ */
 struct dc_edid_caps {
 	/* sink identification */
 	uint16_t manufacturer_id;
@@ -212,6 +216,7 @@ struct dc_edid_caps {
 	bool edid_hdmi;
 	bool hdr_supported;
 	bool rr_capable;
+	bool analog;
 
 	struct dc_panel_patch panel_patch;
 };
-- 
2.50.1

