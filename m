Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC80ED29DE0
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jan 2026 08:02:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 244FC10E459;
	Tue, 13 Jan 2026 08:02:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j4YieNoF";
	dkim-atps=neutral
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D508010E406
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Jan 2026 15:31:24 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id
 5b1f17b1804b1-47a9567bcd9so6391765e9.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Jan 2026 07:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768231883; x=1768836683; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CGCr2hsW4qtNXAvJfTCntHNNhAfFNWn1Wh4irGq3akQ=;
 b=j4YieNoFvFf08JDuus/CBbtyvAIR3Fb3cTHY7xPpSSIwdLAdmts51fuDvySp3lQgEw
 bFULls4uYR1EhSx/zmn8HbcAAr3scHaMIfHeXXdLSBl6YrCRYnpyanujXoA5EpqEzKgx
 LlIFCepSheBT/HcXCJ3kqw8bnfGF6JvrGotjy4dOTxChloziZUdOwh55FitUiww1NVbg
 XdtokPRNAhk28dmb3yMhIYeCbpIogcC89mITw3V2T7Z6x6izQRIY57gCd1eSLiwGDkb0
 8MUmZcP6UtsFX++icNMEn8aLfwcTXMxn+mTXmw+gG0/IWDi7rj7WPfC7O353mdrJipM+
 rb9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768231883; x=1768836683;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CGCr2hsW4qtNXAvJfTCntHNNhAfFNWn1Wh4irGq3akQ=;
 b=PUo10xNvlj6LTqy6uvJVw4/xVsJM7kwf/r4dIMH4FA+ufPwEJrKRbqST1M7fBjV9l4
 zpB5Mvc2WJZiMnanJBVwdURN+Xr/rHVm985u/rfQWBbzevSj0c4t8KF6HRaPrP8OhUja
 kU138xr+evXYQeXD5R9i39exjz+579SnhSp3nuRttXxIzK69tA7EDWf2sLrzZ7WoTgSb
 zN76CI7X1uySg/13d5oNngfkw/CXAzR45dSyCCu4IAUMbxacXIHWFy5V3TsZ5SpBceCD
 Jsu4o26aCujmYGDQjgVT33bOz19ihuDdhGAeOj6HZ3gEQ45BtmaUSi2PakjYXLEsENEK
 R1Tg==
X-Gm-Message-State: AOJu0YylB9J0CF8XBOX4HZBPzSf6qvfHas0PYKTAmlimMsqn9NcaFNTF
 p64ENho89wbyjk+MgdCb3BhJ7rpuRmB4Bftvl8UAPmEmOaCgNROPhLWu
X-Gm-Gg: AY/fxX7U1z6lG0y4cTvdCuZ5C/Zp3aMy7MvyWu7vukB0rZrMNF196ErALiNosSD2LZc
 XyfsU6hnNA6eizdOTNsxrPZU0vR1/Ut0lHFmAk02SAj0+Mtq1AVdJcnt2LMLZBRK8TE02PGvEj5
 MH4Ae1wo8YCOym0Qg76Ehqb4oEB3uNRDQsp0BM6zr2nY4wr2wjNMiJhW0Kiqb9R3PRF1ecLz1ex
 M0nmTowCWln+2xz8PBt18ouG8QAjS43znuK+3gm+htyKivzOfLOuVOU1925qpmPK5MUNXDFGpcd
 SjTyV46sKJMetI2+E/BFEQZlMkVf4onS21TPHrePiKFL77jvfzieJ2iqXHa/HAaKOzTx0wcYQqH
 H3Z7BkMKUhABazaj8voggrRnMjiXGgwoEC+MxtGxDdSRXvc/ONcx2h3U+/pyYMEXyXmiAJ/d8Gl
 g2tHiOdMjCkqDH97kKx8czW1fzX74pckPVn3DbFgEv9d7EX+5jL6uiKBgdfX4=
X-Google-Smtp-Source: AGHT+IGfvySlxmJ7EZUnrwCPAXVGtoafY1CJHwvQPitRrIWo0fEUBb0h0OyU4n1kjAG9R5TJKXjMAw==
X-Received: by 2002:a05:600c:4f8a:b0:477:7b16:5f97 with SMTP id
 5b1f17b1804b1-47d849bbc7dmr117480815e9.0.1768231883098; 
 Mon, 12 Jan 2026 07:31:23 -0800 (PST)
Received: from laptok (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5ee243sm39334239f8f.31.2026.01.12.07.31.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 07:31:22 -0800 (PST)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com,
 harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/display: Add PCON VRR whitelist override
Date: Mon, 12 Jan 2026 16:31:18 +0100
Message-ID: <20260112153118.1640773-1-tomasz.pakula.oficjalny@gmail.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 13 Jan 2026 08:02:37 +0000
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

From: Tomasz Pakuła <forest10pl@gmail.com>

Adds override as part of dc debug mask. Allows faster testing and
reporting of VRR-compatible DP->HDMI adapters.

Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    |  3 +++
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c    | 16 ++++++++++++----
 drivers/gpu/drm/amd/display/dc/dc.h              |  1 +
 drivers/gpu/drm/amd/include/amd_shared.h         |  6 ++++++
 4 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 7fe40bbba265..65df54e4ef05 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2069,6 +2069,9 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	if (amdgpu_dc_debug_mask & DC_SKIP_DETECTION_LT)
 		adev->dm.dc->debug.skip_detection_link_training = true;
 
+	if (amdgpu_dc_debug_mask & DC_OVERRIDE_PCON_VRR_WHITELIST)
+		adev->dm.dc->debug.override_pcon_vrr_whitelist = true;
+
 	adev->dm.dc->debug.visual_confirm = amdgpu_dc_visual_confirm;
 
 	/* TODO: Remove after DP2 receiver gets proper support of Cable ID feature */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index d0f770dd0a95..c77885c2a3cb 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -1387,13 +1387,21 @@ enum adaptive_sync_type dm_get_adaptive_sync_support_type(struct dc_link *link)
 {
 	struct dpcd_caps *dpcd_caps = &link->dpcd_caps;
 	enum adaptive_sync_type as_type = ADAPTIVE_SYNC_TYPE_NONE;
+	struct amdgpu_dm_connector *aconnector = link->priv;
+	struct drm_device *dev = aconnector->base.dev;
 
 	switch (dpcd_caps->dongle_type) {
 	case DISPLAY_DONGLE_DP_HDMI_CONVERTER:
-		if (dpcd_caps->adaptive_sync_caps.dp_adap_sync_caps.bits.ADAPTIVE_SYNC_SDP_SUPPORT == true &&
-			dpcd_caps->allow_invalid_MSA_timing_param == true &&
-			dm_is_freesync_pcon_whitelist(dpcd_caps->branch_dev_id))
-			as_type = FREESYNC_TYPE_PCON_IN_WHITELIST;
+		if (!dpcd_caps->adaptive_sync_caps.dp_adap_sync_caps.bits.ADAPTIVE_SYNC_SDP_SUPPORT)
+			break;
+		if (!dpcd_caps->allow_invalid_MSA_timing_param)
+			break;
+		if (link->dc->debug.override_pcon_vrr_whitelist)
+			drm_info(dev, "Overriding VRR PCON whitelist check for ID: %06x",
+				 dpcd_caps->branch_dev_id);
+		else if (!dm_is_freesync_pcon_whitelist(dpcd_caps->branch_dev_id))
+			break;
+		as_type = FREESYNC_TYPE_PCON_IN_WHITELIST;
 		break;
 	default:
 		break;
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 98f0b6b3c213..513d3305bb41 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1014,6 +1014,7 @@ struct dc_debug_options {
 	bool scl_reset_length10;
 	bool hdmi20_disable;
 	bool skip_detection_link_training;
+	bool override_pcon_vrr_whitelist;
 	uint32_t edid_read_retry_times;
 	unsigned int force_odm_combine; //bit vector based on otg inst
 	unsigned int seamless_boot_odm_combine;
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index 75efda2969cf..fd08f4f1fccf 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -410,6 +410,12 @@ enum DC_DEBUG_MASK {
 	 * @DC_SKIP_DETECTION_LT: (0x200000) If set, skip detection link training
 	 */
 	DC_SKIP_DETECTION_LT = 0x200000,
+
+	/**
+	 * @DC_OVERRIDE_PCON_VRR_WHITELIST: (0x400000) If set, always return true if checking for
+	 * PCON VRR compatibility and print it's ID in kernel log.
+	 */
+	DC_OVERRIDE_PCON_VRR_WHITELIST = 0x400000,
 };
 
 enum amd_dpm_forced_level;
-- 
2.52.0

