Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC3FCFDEE3F
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2026 19:15:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E61B10F23D;
	Thu, 23 Apr 2026 19:15:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hlu3IWYL";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DEC710F260
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 19:15:28 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4852a9c6309so65232505e9.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 12:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776971727; x=1777576527; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kH2+DlnnCebjQvrHZXndnaYPOlTI4jsFVXyrwjdQqPQ=;
 b=hlu3IWYLBT5vKLbb2ipcpuHZY17bQNaZ/2H1eOsp5gm/GYKOMO5I0/Cs3fnwDsySv6
 OY2s/+dA6ZSoVJJvQVpjKdR26yw+SCX+a+c3OY93AJBVaayZDAPpjHBH27oMpsenwbj3
 UBEwONQ6gclmrKOmWNqm/wq4IWL3K/zpi5CcERhYPOBjXbI587+ws8FOJXykN7RU1Bgp
 7gMIhYOgbtXkpoZiKjxww/iaDz3i9U+NRlRi3293vAEAmvF2mBVyg68UIlI1hQaSndpg
 bDf6+KdBmervjF5QZsT+fS9SoE6RsNEO/VGdhRxGgHzXIcLD8RANjM4qLBgjYI2fj8Uw
 VEOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776971727; x=1777576527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kH2+DlnnCebjQvrHZXndnaYPOlTI4jsFVXyrwjdQqPQ=;
 b=XRPQH4BZyx/Vzh4QOKIsXxBYZ0421flnfkch4fJ4iyZfejSyo+QxAiMfdNOPA+adZi
 TEBYSkp+VV4XNc1mRSYGhRLWaDXcOS2Gx8dWa12jhW001C2zHthLLso3nkRc7pTKA1pU
 e+LsYM37PQifybiRhi+jtLP2B+6sap0XcFaz488LWvcNA97fFSyNbjNA4o24iHjgBD2A
 RqDh5uaHeESeXTjNSPZm8RY4IbN5OLVCazL/A95jia/sIw5VdpGsXNzVFzEguCBJakVB
 y0dJarc06SgmHm3t+4hkDtIZxs2TIEldY5ZwvnN7tYHn4HGmJrQk640ioEXak4gMokZA
 1jSg==
X-Gm-Message-State: AOJu0YwRC5j/1Ccm3Ut1sqcGJK/lA+hxy9vGl2x40zFbrkxY9+SPacwA
 NaH7rKbB1XEnG0vG1Vt0e4LhfTmxDCwrp3PcC6cY8EKMZj6MTaFxoEkopTKW5yrq
X-Gm-Gg: AeBDietficILZwlzPq1aDctN5tq3LI0zMaNO8BLDTs0q0AasrrfrpjXLCl+RQdQYv0R
 9X9KRv+SPENgMEZe2XPzRcyCAgNWJrli4HNc+TJ9NBkZhUK35GL8RIDjEuQV/D3evZ5T4Z2ED5W
 PWAduM59nbQctBtGVzm/HZsDKMBsdS6SzveDSELtSIJQfRDyldvcsFL+9vBrwRG6c9YCv21g5Gi
 DMx1ym0UW7yYuywXWavw2L2ov9LzchKnzi4AQB4lwLHPTqCIokulxRtY92a9HUNGCqe32UZQitG
 vdpukUXKXa85hD8iKpA6CeoBB/3V+bx0Xd1IYbhmHjpgefNVGeLgwgqB7LHuBwcEEL69cVmhmV5
 QxGFh6yWMqBW7+9dcJqKf9wnMOmI2duF7qC7tkT79PuLgLyqq9riQx6Ko7uLFT/ZhbFilJgd2p5
 5W6qZdecywrQ2Y8kerxkDU5IkmH7RwRIUMq5reICl0FzbqAoF3dV5sBbIFqJpHKtyOblOFRp101
 ZQb0A==
X-Received: by 2002:a05:600c:1da1:b0:488:79a3:f04c with SMTP id
 5b1f17b1804b1-488fb7863femr429336715e9.27.1776971726757; 
 Thu, 23 Apr 2026 12:15:26 -0700 (PDT)
Received: from Timur-Hyperion.home (5E1B98A2.dsl.pool.telekom.hu.
 [94.27.152.162]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-44123d23e0bsm15792782f8f.15.2026.04.23.12.15.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 12:15:26 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Alex Hung <alex.hung@amd.com>, Harry Wentland <Harry.Wentland@amd.com>,
 Roman Li <Roman.Li@amd.com>, Leo Li <sunpeng.li@amd.com>,
 David Airlie <airlied@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Melissa Wen <mwen@igalia.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 04/14] drm/amd/display: Delete max_clocks_state from
 dm_pp_static_clock_info
Date: Thu, 23 Apr 2026 21:15:09 +0200
Message-ID: <20260423191519.73127-5-timur.kristof@gmail.com>
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

It's not used by anything anymore.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c  | 28 -------------------
 .../drm/amd/display/dc/dm_services_types.h    |  3 --
 2 files changed, 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
index 17f42201ab862..2247969aa9acb 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
@@ -183,33 +183,6 @@ static enum amd_pp_clock_type dc_to_pp_clock_type(
 	return amd_pp_clk_type;
 }
 
-static enum dm_pp_clocks_state pp_to_dc_powerlevel_state(
-			enum PP_DAL_POWERLEVEL max_clocks_state)
-{
-	switch (max_clocks_state) {
-	case PP_DAL_POWERLEVEL_0:
-		return DM_PP_CLOCKS_DPM_STATE_LEVEL_0;
-	case PP_DAL_POWERLEVEL_1:
-		return DM_PP_CLOCKS_DPM_STATE_LEVEL_1;
-	case PP_DAL_POWERLEVEL_2:
-		return DM_PP_CLOCKS_DPM_STATE_LEVEL_2;
-	case PP_DAL_POWERLEVEL_3:
-		return DM_PP_CLOCKS_DPM_STATE_LEVEL_3;
-	case PP_DAL_POWERLEVEL_4:
-		return DM_PP_CLOCKS_DPM_STATE_LEVEL_4;
-	case PP_DAL_POWERLEVEL_5:
-		return DM_PP_CLOCKS_DPM_STATE_LEVEL_5;
-	case PP_DAL_POWERLEVEL_6:
-		return DM_PP_CLOCKS_DPM_STATE_LEVEL_6;
-	case PP_DAL_POWERLEVEL_7:
-		return DM_PP_CLOCKS_DPM_STATE_LEVEL_7;
-	default:
-		DRM_ERROR("DM_PPLIB: invalid powerlevel state: %d!\n",
-				max_clocks_state);
-		return DM_PP_CLOCKS_STATE_INVALID;
-	}
-}
-
 static void pp_to_dc_clock_levels(
 		const struct amd_pp_clocks *pp_clks,
 		struct dm_pp_clock_levels *dc_clks,
@@ -448,7 +421,6 @@ bool dm_pp_get_static_clocks(
 	if (amdgpu_dpm_get_current_clocks(adev, &pp_clk_info))
 		return false;
 
-	static_clk_info->max_clocks_state = pp_to_dc_powerlevel_state(pp_clk_info.max_clocks_state);
 	static_clk_info->max_mclk_khz = pp_clk_info.max_memory_clock * 10;
 	static_clk_info->max_sclk_khz = pp_clk_info.max_engine_clock * 10;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dm_services_types.h b/drivers/gpu/drm/amd/display/dc/dm_services_types.h
index 3b093b8699abd..44aa8d213d386 100644
--- a/drivers/gpu/drm/amd/display/dc/dm_services_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dm_services_types.h
@@ -258,9 +258,6 @@ struct dm_pp_clock_for_voltage_req {
 struct dm_pp_static_clock_info {
 	uint32_t max_sclk_khz;
 	uint32_t max_mclk_khz;
-
-	/* max possible display block clocks state */
-	enum dm_pp_clocks_state max_clocks_state;
 };
 
 struct dtn_min_clk_info {
-- 
2.53.0

