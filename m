Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8167C9EC95
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Jan 2026 14:04:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D83DD10E3D6;
	Mon, 12 Jan 2026 14:04:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="kchJVSnv";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3222C10E3B6;
 Mon, 12 Jan 2026 12:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1768220508;
 bh=iRtfMCL1Oz7vI19NsR0rJtTifPlnDjelAukBq66MZrY=;
 h=From:To:Cc:Subject:Date:From;
 b=kchJVSnvf8Az4kLIN6nwQlaUO8oCVTJpDz4fZ4UDRsQBeSmTzhl21q03BUIJ0CX6g
 9RcJfsPZmCXJt0HFDXbvuvutBP6b6xFyP8iac/HL3xvmtmtDasDMZ5GjN3WWEFs+F+
 +YTLYQDyT36wTdTYrsN4xTVPUFSModSOqG785KHBtI0TjimxwsjdnGDjb/urPtAwAo
 mMV4lwGofzWnbbQXp5+eCbCwExWaAHkwt8HXrCHtoJ8zDbziXqewk4+bcjimynu9nL
 A1fxt9ebjRuqjkpiOapCg0NV7CO+RgdULoYEoStd/A276z4En2o9GuLgFkkjDgllT8
 EtrYL421nak3Q==
Received: from nemo.lan (unknown [IPv6:2a07:244:40:6b00::646])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: vivek)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 6673D17E0CB0;
 Mon, 12 Jan 2026 13:21:48 +0100 (CET)
From: Vivek Das Mohapatra <vivek@collabora.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel@collabora.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] drm/amd/display: Initialise backlight level values from hw
Date: Mon, 12 Jan 2026 12:20:46 +0000
Message-Id: <20260112122140.2609679-1-vivek@collabora.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 12 Jan 2026 14:04:34 +0000
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

Internal backlight levels are initialised from ACPI but the values
are sometimes out of sync with the levels in effect until there has
been a read from hardware (eg triggered by reading from sysfs).

This means that the first drm_commit can cause the levels to be set
to a different value than the actual starting one, which results in
a sudden change in brightness.

This path shows the problem (when the values are out of sync):

   amdgpu_dm_atomic_commit_tail()
   -> amdgpu_dm_commit_streams()
   -> amdgpu_dm_backlight_set_level(..., dm->brightness[n])

This patch calls the backlight ops get_brightness explicitly
at the end of backlight registration to make sure dm->brightness[n]
is in sync with the actual hardware levels.

Signed-off-by: Vivek Das Mohapatra <vivek@collabora.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 354e359c4507..50f0547ed63c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5258,6 +5258,8 @@ amdgpu_dm_register_backlight_device(struct amdgpu_dm_connector *aconnector)
 	struct amdgpu_dm_backlight_caps *caps;
 	char bl_name[16];
 	int min, max;
+	int real_brightness;
+	int init_brightness;
 
 	if (aconnector->bl_idx == -1)
 		return;
@@ -5282,6 +5284,8 @@ amdgpu_dm_register_backlight_device(struct amdgpu_dm_connector *aconnector)
 	} else
 		props.brightness = props.max_brightness = MAX_BACKLIGHT_LEVEL;
 
+	init_brightness = props.brightness;
+
 	if (caps->data_points && !(amdgpu_dc_debug_mask & DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE)) {
 		drm_info(drm, "Using custom brightness curve\n");
 		props.scale = BACKLIGHT_SCALE_NON_LINEAR;
@@ -5297,6 +5301,18 @@ amdgpu_dm_register_backlight_device(struct amdgpu_dm_connector *aconnector)
 					  &amdgpu_dm_backlight_ops, &props);
 	dm->brightness[aconnector->bl_idx] = props.brightness;
 
+	/*
+	 * dm->brightness[x] can be inconsistent just after startup until
+	 * ops.get_brightness is called.
+	 */
+	real_brightness =
+		amdgpu_dm_backlight_ops.get_brightness(dm->backlight_dev[aconnector->bl_idx]);
+
+	if (real_brightness != init_brightness) {
+		dm->actual_brightness[aconnector->bl_idx] = real_brightness;
+		dm->brightness[aconnector->bl_idx] = real_brightness;
+	}
+
 	if (IS_ERR(dm->backlight_dev[aconnector->bl_idx])) {
 		drm_err(drm, "DM: Backlight registration failed!\n");
 		dm->backlight_dev[aconnector->bl_idx] = NULL;
-- 
2.39.5

