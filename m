Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ED8ED31A26
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jan 2026 08:29:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEC6C10E5DF;
	Wed, 14 Jan 2026 08:29:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NTyEywPl";
	dkim-atps=neutral
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com
 [209.85.208.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E4F510E155
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jan 2026 18:35:44 +0000 (UTC)
Received: by mail-ed1-f67.google.com with SMTP id
 4fb4d7f45d1cf-64b9cb95009so1057351a12.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jan 2026 10:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768329343; x=1768934143; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IrmCAv+0u0WGWxU7rdFQYvDotcwbRG+hi7tXS+XR9r0=;
 b=NTyEywPlWIxmw4++2l7HkOAlmJ9jo6QMZoigTtc96jb9HXxoa9TG66pCN8VktYGfUi
 nRz+JJaZZKeaE+ufnYNcZIUhegBMz4TI9G/VPNVzF4Gitf1KGM7rUM0XuAKlx72lPPtb
 4iHOMmrOkdySgtxkIg/rScrGKik3rwxXM79v/Mdukcc6f+9g3k5Rc3LEbCpWSveASKkR
 Gt67H701N4uhtx1foHxkFVIEBNOB+avLiBffUfvoifhKRZKLs4VjgTOwgrkywYzt3+dk
 00SXJ2qj3XH5MbMQ+mb93MxP6jBn3o89m0mNKxwL0B84x2SZiZ7g98Dzc0OlhIdgkoY9
 Wf3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768329343; x=1768934143;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IrmCAv+0u0WGWxU7rdFQYvDotcwbRG+hi7tXS+XR9r0=;
 b=OIWfd1kQU3Fuk2Nen24sNaBQAC44owUcwbOk/02KVHn1aWONdQZT+FtRTHtpXSHxm/
 E7/uDOWq0J1uXk+W8h2jKeH3JuOAg2pJdbffiZCoxpvjy/Ddel8qcTLx4CB5zOhxxZ92
 yhaiVa1/JcQ2pgpa48j07g6PiQfViBhoZXhS+avWmPjK6l3HqMaweBk+ThTQ0BS4gDJ0
 Ct3uVz4TqQmaumx7Ammo9IETO/+sqTfoW3zz9+tkQaZfAuM3SfTPCrMpGQT9IM/4H3c7
 oPyg++aoCI1Ax1YmPYe5MkLOuovSCEn2JMDiIoQSLHE6REP7+ZHzw2oDcq1Z3vdye/Pi
 MF9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDyAMBQr/mnXOVihXdl+7alwnNMVbYovAYXJvsTXJXEtEV71T+qlzODDKVQpU0qBL69kfYuHIi@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxu9QklJgqilosK5clmK/iJOq5ru2WNMorrIblumaqWCdJjvzzE
 fRQhuAD0u65m06Nr76Em2LysFu4NMhKNKoc6U3HQrXgLLqrt7CFGemW4Sq9qv0D3
X-Gm-Gg: AY/fxX63mBHbjg/HWzWLvGQyPQ0sdR+c8+MGPS+JqmnEMnqeqxv5lKrYwduHxuJiKJs
 FQKG/oD2OvHDJg8pAmyZk4E3UH83XSPwIC+GFy3Rn+HPIajhhGYGOkPedOzevR6PH7m3NQl3CQx
 exm6uWYbGHrRexFW7D43OgatTPpBP4Xx3AF0IFd1p8gFEWyRJhqn+rYLoQmBj+qRJ2KMJYd9nvi
 iwm8OUTUY99s0hPRDpCcGWiNa+AIktLfs6v1qlpjf3QWQXkpeQnxc0oGT1MqSVz/lTlWzrrV6Xo
 8k16huchkZUG2ACp32VExEf0pt9DxQRvT2/gMR/IaUFjOnKrvlFEdkLBICS0UxRI4MZ0Ah7Y6SP
 wqRqO6SlV2v/pIsteYJ4I6dqRLcC0kcb45aohMQIULwWz0jMtZCDcFat1taL5DZvbcZkXl/1DxH
 BzOi2Ef9XR8tZ7vG8xipyQcOt7DNJS1PVL0T71Csb0lN0Coe9asQ9Y5HdbdyDy48+d9FrbuwanR
 7E=
X-Google-Smtp-Source: AGHT+IHoxPmlwve81nzpQwXJHM+rfz0IvrdVk6fhTs25S/wNaPesU0aLJo8bdmaf4JMOamAf/pOu7w==
X-Received: by 2002:a05:6402:4316:b0:64c:9e19:983c with SMTP id
 4fb4d7f45d1cf-65097de0ab8mr11582633a12.2.1768329342852; 
 Tue, 13 Jan 2026 10:35:42 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6507b8c4479sm20957106a12.1.2026.01.13.10.35.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 10:35:42 -0800 (PST)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: alexander.deucher@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com
Cc: christian.koenig@amd.com, siqueira@igalia.com,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH v2] drm/amd/display: Add PCON VRR whitelist override
Date: Tue, 13 Jan 2026 19:35:40 +0100
Message-ID: <20260113183540.86266-1-tomasz.pakula.oficjalny@gmail.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 14 Jan 2026 08:29:27 +0000
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

Adds override as part of dc debug mask. Allows faster testing and
reporting of VRR-compatible DP->HDMI adapters.

changes in v2:
- Fix missing newline in drm_info()

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
index d0f770dd0a95..0fe881d4157e 100644
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
+			drm_info(dev, "Overriding VRR PCON whitelist check for ID: 0x%06x\n",
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

