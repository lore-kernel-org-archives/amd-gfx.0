Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A07DBC021AE
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2025 04:59:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A31410E612;
	Tue, 18 Feb 2025 04:59:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UEHjSIp+";
	dkim-atps=neutral
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5C8110E60C
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2025 04:59:04 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 02BA3A41D03;
 Tue, 18 Feb 2025 04:57:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34B9AC4CEE2;
 Tue, 18 Feb 2025 04:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1739854743;
 bh=5pLxyiY1ZySGawFdXBMP4ixBcuNQElaLR8is3CxnG7k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=UEHjSIp+GwxutSMbjfmGpXgUUofDLI5Y3cumBsHrIx3SLNHTQQYHuN1MONi02rjr6
 hh+9FwExrkQNimelrvFn95/hyPYXTetvJo6zbFSI+XefUv7v6uZ7Rn+RHw1sqEYi9O
 LfmxXiKM0YM5jJY91sAMD1v+doGw/DLINWMHhNAPzGN+8WL1TJh00SzMByRbw2Xj6+
 1S+mY60wtqm2Qfgz4ioEWYC7W+t7XHTyhTqzFM9qYjxRjMWS+dNWLzOARhUuLhPiTb
 DrB6XWLoSRV5gZ2DhtigZphokkLcx1Fbipb0MsPtvriQ14Ed8AaTvndIDL15T3G0xp
 2mWjom/n2+aQg==
From: Mario Limonciello <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 12/13] drm/amd/display: Use scoped guards for
 handle_hpd_irq_helper()
Date: Mon, 17 Feb 2025 22:58:39 -0600
Message-ID: <20250218045840.2469890-13-superm1@kernel.org>
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

Scoped guards will release the mutex when they go out of scope.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index fa5be13f8dd75..a469b5fd43a7a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3750,7 +3750,7 @@ static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector)
 	 * In case of failure or MST no need to update connector status or notify the OS
 	 * since (for MST case) MST does this in its own context.
 	 */
-	mutex_lock(&aconnector->hpd_lock);
+	guard(mutex)(&aconnector->hpd_lock);
 
 	if (adev->dm.hdcp_workqueue) {
 		hdcp_reset_display(adev->dm.hdcp_workqueue, aconnector->dc_link->link_index);
@@ -3774,10 +3774,10 @@ static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector)
 		if (aconnector->base.force == DRM_FORCE_UNSPECIFIED)
 			drm_kms_helper_connector_hotplug_event(connector);
 	} else {
-		mutex_lock(&adev->dm.dc_lock);
-		dc_exit_ips_for_hw_access(dc);
-		ret = dc_link_detect(aconnector->dc_link, DETECT_REASON_HPD);
-		mutex_unlock(&adev->dm.dc_lock);
+		scoped_guard(mutex, &adev->dm.dc_lock) {
+			dc_exit_ips_for_hw_access(dc);
+			ret = dc_link_detect(aconnector->dc_link, DETECT_REASON_HPD);	
+		}
 		if (ret) {
 			amdgpu_dm_update_connector_after_detect(aconnector);
 
@@ -3789,8 +3789,6 @@ static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector)
 				drm_kms_helper_connector_hotplug_event(connector);
 		}
 	}
-	mutex_unlock(&aconnector->hpd_lock);
-
 }
 
 static void handle_hpd_irq(void *param)
-- 
2.43.0

