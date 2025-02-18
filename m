Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57744C021AA
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2025 04:59:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9A1F10E60C;
	Tue, 18 Feb 2025 04:59:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BE4CJSSu";
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8E2E10E60C
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2025 04:59:03 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id F404A5C5AAC;
 Tue, 18 Feb 2025 04:58:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 954B4C4CEE6;
 Tue, 18 Feb 2025 04:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1739854743;
 bh=Ry8imehsB62tExGRXNbN1GCa4QqXRXKZCz3w+rB4dkA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BE4CJSSucOT2EKOzLyyc3BsnVxHcsLb/MBigEBba6EXU1jvm62y14LzmcCPPmVajS
 Bo1eufRcDKg/6JJPIvP3PmmTC1RfmgPq+LTE34BgFWMIHgLkIRj7djI0ktlRlzKxMR
 UcSMAKuOU2uPYsWGjyZxywtNCBePiV9aDuKoi21TvR31gl0yhAwTY12UwxYG4iw5j6
 TJorM6IRaQKGdxaqdIwqcUNcuYXE+KOqlZr0ncYIUVAdWKv6iCxWDk9aC7iVmYvk8N
 AdfOAVUuYX0D8Ke0Nz92YvMjvDMX4GQUlpCzu8WMBR7nvIUYrycNy4PgFVUonD4kmk
 eRF7IJ1TdYYaw==
From: Mario Limonciello <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 11/13] drm/amd/display: Use _free() macro fro releasing sink
 in amdgpu_dm_update_connector_after_detect()
Date: Mon, 17 Feb 2025 22:58:38 -0600
Message-ID: <20250218045840.2469890-12-superm1@kernel.org>
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

By using a _free() macro multiple duplicated snippets of code to free
the sink can be dropped. The sink will be released when leaving scope.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 08b05fd1cdb91..fa5be13f8dd75 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3591,12 +3591,14 @@ static void update_connector_ext_caps(struct amdgpu_dm_connector *aconnector)
 	}
 }
 
+DEFINE_FREE(sink_release, struct dc_sink *, if (_T) dc_sink_release(_T))
+
 void amdgpu_dm_update_connector_after_detect(
 		struct amdgpu_dm_connector *aconnector)
 {
 	struct drm_connector *connector = &aconnector->base;
+	struct dc_sink *sink __free(sink_release) = NULL;
 	struct drm_device *dev = connector->dev;
-	struct dc_sink *sink;
 
 	/* MST handled by drm_mst framework */
 	if (aconnector->mst_mgr.mst_state == true)
@@ -3643,8 +3645,6 @@ void amdgpu_dm_update_connector_after_detect(
 			}
 		}
 
-		if (sink)
-			dc_sink_release(sink);
 		return;
 	}
 
@@ -3652,10 +3652,8 @@ void amdgpu_dm_update_connector_after_detect(
 	 * TODO: temporary guard to look for proper fix
 	 * if this sink is MST sink, we should not do anything
 	 */
-	if (sink && sink->sink_signal == SIGNAL_TYPE_DISPLAY_PORT_MST) {
-		dc_sink_release(sink);
+	if (sink && sink->sink_signal == SIGNAL_TYPE_DISPLAY_PORT_MST)
 		return;
-	}
 
 	if (aconnector->dc_sink == sink) {
 		/*
@@ -3664,8 +3662,6 @@ void amdgpu_dm_update_connector_after_detect(
 		 */
 		drm_dbg_kms(dev, "DCHPD: connector_id=%d: dc_sink didn't change.\n",
 				 aconnector->connector_id);
-		if (sink)
-			dc_sink_release(sink);
 		return;
 	}
 
@@ -3735,9 +3731,6 @@ void amdgpu_dm_update_connector_after_detect(
 	}
 
 	update_subconnector_property(aconnector);
-
-	if (sink)
-		dc_sink_release(sink);
 }
 
 static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector)
-- 
2.43.0

