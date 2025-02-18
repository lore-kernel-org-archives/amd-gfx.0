Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAB2DC021A9
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2025 04:59:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59D2D10E610;
	Tue, 18 Feb 2025 04:59:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EKlyVOk0";
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A09B10E60C
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2025 04:59:03 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 6472D5C5A9F;
 Tue, 18 Feb 2025 04:58:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0A9DC4CEE8;
 Tue, 18 Feb 2025 04:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1739854742;
 bh=O8UBTal368Kx5gcksmYg1GfEqjPuXn0u1qF3nm4kNww=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=EKlyVOk00r11wsgrqn7N+iNBrZsFq7HbFPaDGAwzqHQYM/BxsYndcOq56eF8haqmw
 TDEklTDBNBwMTFDa87Zdhc5y1EAfe7hN1xN7+cIWFUS7QUg4tQvipgBTYsHeozpKYr
 9xwO9RAggfTPfIkIlsw7KPn+8QVX48EaaR4E/aANeuPVn186uvabuRCKIXU1hSC7kq
 RPvcIuxYmC4xHCJZdHRU1UBagixnvqCwjXwgkL3lAyEoRkeSwnZ8/gQkpdCAazHbKJ
 VbpI71fyojppddeszVdqHWNGPXX7HTSoX1LZNcjns5oqxPVcAUxTh72dh5+Jzykcrx
 gud7wXNg/qFNA==
From: Mario Limonciello <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 10/13] drm/amd/display: Use scoped guard for
 amdgpu_dm_update_connector_after_detect()
Date: Mon, 17 Feb 2025 22:58:37 -0600
Message-ID: <20250218045840.2469890-11-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250218045840.2469890-1-superm1@kernel.org>
References: <20250218045840.2469890-1-superm1@kernel.org>
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

From: Mario Limonciello <mario.limonciello@amd.com>

A scoped guard will release the mutex when it goes out of scope.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 33bed74c5b4c0..08b05fd1cdb91 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3618,7 +3618,7 @@ void amdgpu_dm_update_connector_after_detect(
 		 * For S3 resume with headless use eml_sink to fake stream
 		 * because on resume connector->sink is set to NULL
 		 */
-		mutex_lock(&dev->mode_config.mutex);
+		guard(mutex)(&dev->mode_config.mutex);
 
 		if (sink) {
 			if (aconnector->dc_sink) {
@@ -3643,8 +3643,6 @@ void amdgpu_dm_update_connector_after_detect(
 			}
 		}
 
-		mutex_unlock(&dev->mode_config.mutex);
-
 		if (sink)
 			dc_sink_release(sink);
 		return;
@@ -3674,7 +3672,7 @@ void amdgpu_dm_update_connector_after_detect(
 	drm_dbg_kms(dev, "DCHPD: connector_id=%d: Old sink=%p New sink=%p\n",
 		    aconnector->connector_id, aconnector->dc_sink, sink);
 
-	mutex_lock(&dev->mode_config.mutex);
+	guard(mutex)(&dev->mode_config.mutex);
 
 	/*
 	 * 1. Update status of the drm connector
@@ -3736,8 +3734,6 @@ void amdgpu_dm_update_connector_after_detect(
 			connector->state->content_protection = DRM_MODE_CONTENT_PROTECTION_DESIRED;
 	}
 
-	mutex_unlock(&dev->mode_config.mutex);
-
 	update_subconnector_property(aconnector);
 
 	if (sink)
-- 
2.43.0

