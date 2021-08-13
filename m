Return-Path: <SRS0=hpB+=NE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2384C4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Aug 2021 06:16:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9049860F57
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Aug 2021 06:16:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9049860F57
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BB2E890BB;
	Fri, 13 Aug 2021 06:16:29 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2071.outbound.protection.outlook.com [40.107.102.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B12F66E4CB
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Aug 2021 06:16:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i8mjDoKzEmVzWD7tcypCvzSJNWbokuvZ8+KuyU81f/ks+pTTn2tjzKzguUC8ouqurylS66yUZv6ziOy2ftH2eNURO9Up4qCZePhiyxIs0RfJ7LpR8SL3QLRaR0MQR2VIenZZxFOk+0nFIBs9Mi2PMkZej/vrTLslhwCt/rFPu6KOwxRRNyfE/hCyYMecaHd0TKsk2moRErtPv9bbJVqTPGiqwqcO08pC0w9xSIVsac4OVn/n0Gi6nsPRYt9ouEZkjQxOu4WDIR87qHE3kM1F8iqykQJI2cc6PPIP1aeYtnE/Q2kSWqRvy4O1KVxMhriQGADO3kqCUeT0RRJNpvUKWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bXWwsq6hU1ivhjjwJWaZM3QFr3J0nItkyel+mizd32Q=;
 b=R/S94H4GM3NfL2hGBKbNCrqR+zCjVD+NnrESEKdj1NvxYbHSihFJ7gLGEw9DepyxtceW2dy3HMTLxMKc715RKxNtFisrqvnIHj6tbMVOY2Q23tQdxPxuZubGVUNABtz0VAlfsGNDbnDVPMih2DfCWbnXvRYwUTcwdr8dYFX5rb+iwAcUZTm+xBOVDCAETWGtXqR4Mw58z6Aaks3wxGBqk5uon8AgF+lEVZ4J5oN79EMCkjuKz13KNlujiaKTNmPwGZ137g2YrCiQjpF7s8ykHl+9PwF70kCNwxce15dmygBZrFoIQQp2rLBGQ7a2X92Jf3k5fTweyJXUHS2i55kJfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bXWwsq6hU1ivhjjwJWaZM3QFr3J0nItkyel+mizd32Q=;
 b=L/qZmWb9F9yPaXlCmXcVbO/atOt5qkPcOyagDi1BKqxYZt3wonIkFhUVRMvx/i8/52PPMVCO0paR/7j6M1bTbAOHKvDPcpsFxB3qH/hQSc8n6W51ZHJbVNIiKjwetcoTQtD60149TwZDzjm5H9gZAk/BK7JGNenhUfj62azN3ng=
Received: from BN1PR12CA0026.namprd12.prod.outlook.com (2603:10b6:408:e1::31)
 by SN1PR12MB2351.namprd12.prod.outlook.com (2603:10b6:802:2b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.21; Fri, 13 Aug
 2021 06:16:25 +0000
Received: from BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e1:cafe::ca) by BN1PR12CA0026.outlook.office365.com
 (2603:10b6:408:e1::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14 via Frontend
 Transport; Fri, 13 Aug 2021 06:16:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT016.mail.protection.outlook.com (10.13.176.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4415.14 via Frontend Transport; Fri, 13 Aug 2021 06:16:18 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Fri, 13 Aug
 2021 01:16:17 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 12 Aug
 2021 23:16:17 -0700
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.12
 via Frontend Transport; Fri, 13 Aug 2021 01:16:14 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <Qingqing.Zhuo@amd.com>, <bindu.r@amd.com>,
 <Anson.Jacob@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Roman Li <Roman.Li@amd.com>, Wayne Lin <wayne.lin@amd.com>
Subject: [PATCH 3/7] drm/amd/display: Use vblank control events for PSR
 enable/disable
Date: Fri, 13 Aug 2021 14:15:46 +0800
Message-ID: <20210813061550.3104690-4-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210813061550.3104690-1-Wayne.Lin@amd.com>
References: <20210813061550.3104690-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ef069fd-d6d8-44ff-5557-08d95e21dd4f
X-MS-TrafficTypeDiagnostic: SN1PR12MB2351:
X-Microsoft-Antispam-PRVS: <SN1PR12MB235152A92CCFF5026E4AE657FCFA9@SN1PR12MB2351.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5lEb6npDte0rB2uYN46/OJnYs7ap3fGcgsixmSP/OgDPSbMTrG8o7M2NL5041UHVTdsSHR3LGzcKjSvxfNxOkJaZBqmNUA01CscW/17TJYsKUJDAv7+brO4C5tVFLSl66JS/6O/jq4qR09EgEL7D6tVoypdCqQ63kIarb0zEy8JC8htsQkcUDpy49Rkg27EgdDGPx/fWWwECFZ8mWSMyn7F+N5sv2hVyUxFpDBEA4ojzDltLtQ+wmRKLL5D2hxhZCDnJhOral6d677fBt7PYdqMMjgslyA9STZt2zgQyPrYr+6WuGiWGrwYFc8uf6pbDSHhR8Aw/ZrfUpBN6C10KgZc30O4g5sWRqUC3EVpDVHu0bT0ZZUzEGFgeSLFjtUo0lnkwUKEiZtFmQ0urft5PmSby9pzGR9t2+dt+6lIyZiuJUGQhRv2AoleDVZWEeQN6Dgid7KvadUHmgIfEB0BaUZr5mSBdtuEfSvnVFgKajg79mpk/xDWOX4LwIo0vDS9yaOknkFC9I4F/+W37RYyT+lu8K1frDOH5D0QLzYsXXjlLQ/5ewSCJeCKH9snFHLsqoodAJWy6aHFdH6DxLGH3Ky4CNx/0YZBEoTMLfm5sWG9o8U4PkIPuXAKqPyQeVKWa+j7rSpo8E7OtSesf5zz+2+tGgRpn3KnxYPYEvOJ7dBX0jIO7xk+firWvxSoHv61EQ3yhrafE8J68qrTLc8wk0/tOLdBjNXAGV4n2MXCcBNIjsZ4XUTXxKjtUpHkivOTqoLUzH5cKIdS/86a1dA3Y4Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(83380400001)(36756003)(316002)(1076003)(70206006)(2616005)(356005)(70586007)(8936002)(5660300002)(6666004)(2906002)(6916009)(47076005)(82310400003)(36860700001)(4326008)(81166007)(34020700004)(426003)(186003)(8676002)(26005)(86362001)(508600001)(7696005)(336012)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2021 06:16:18.9101 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ef069fd-d6d8-44ff-5557-08d95e21dd4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2351
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

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
PSR can disable the HUBP along with the OTG when PSR is active.

We'll hit a pageflip timeout when the OTG is disable because we're no
longer updating the CRTC vblank counter and the pflip high IRQ will
not fire on the flip.

In order to flip the page flip timeout occur we should modify the
enter/exit conditions to match DRM requirements.

[How]
Use our deferred handlers for DRM vblank control to notify DMCU(B)
when it can enable or disable PSR based on whether vblank is disabled or
enabled respectively.

We'll need to pass along the stream with the notification now because
we want to access the CRTC state while the CRTC is locked to get the
stream state prior to the commit.

Retain a reference to the stream so it remains safe to continue to
access and release that reference once we're done with it.

Enable/disable logic follows what we were previously doing in
update_planes.

The workqueue has to be flushed before programming streams or planes
to ensure that we exit out of idle optimizations and PSR before
these events occur if necessary.

To keep the skip count logic the same to avoid FBCON PSR enablement
requires copying the allow condition onto the DM IRQ parameters - a
field that we can actually access from the worker.

Reviewed-by: Roman Li <Roman.Li@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 48 +++++++++++++++----
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  2 +
 .../display/amdgpu_dm/amdgpu_dm_irq_params.h  |  1 +
 3 files changed, 43 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index f88b6c5b83cd..cebd663b6708 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1061,7 +1061,22 @@ static void vblank_control_worker(struct work_struct *work)
 
 	DRM_DEBUG_KMS("Allow idle optimizations (MALL): %d\n", dm->active_vblank_irq_count == 0);
 
+	/* Control PSR based on vblank requirements from OS */
+	if (vblank_work->stream && vblank_work->stream->link) {
+		if (vblank_work->enable) {
+			if (vblank_work->stream->link->psr_settings.psr_allow_active)
+				amdgpu_dm_psr_disable(vblank_work->stream);
+		} else if (vblank_work->stream->link->psr_settings.psr_feature_enabled &&
+			   !vblank_work->stream->link->psr_settings.psr_allow_active &&
+			   vblank_work->acrtc->dm_irq_params.allow_psr_entry) {
+			amdgpu_dm_psr_enable(vblank_work->stream);
+		}
+	}
+
 	mutex_unlock(&dm->dc_lock);
+
+	dc_stream_release(vblank_work->stream);
+
 	kfree(vblank_work);
 }
 
@@ -6018,6 +6033,11 @@ static inline int dm_set_vblank(struct drm_crtc *crtc, bool enable)
 	work->acrtc = acrtc;
 	work->enable = enable;
 
+	if (acrtc_state->stream) {
+		dc_stream_retain(acrtc_state->stream);
+		work->stream = acrtc_state->stream;
+	}
+
 	queue_work(dm->vblank_control_workqueue, &work->work);
 #endif
 
@@ -8623,6 +8643,12 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 	/* Update the planes if changed or disable if we don't have any. */
 	if ((planes_count || acrtc_state->active_planes == 0) &&
 		acrtc_state->stream) {
+		/*
+		 * If PSR or idle optimizations are enabled then flush out
+		 * any pending work before hardware programming.
+		 */
+		flush_workqueue(dm->vblank_control_workqueue);
+
 		bundle->stream_update.stream = acrtc_state->stream;
 		if (new_pcrtc_state->mode_changed) {
 			bundle->stream_update.src = acrtc_state->stream->src;
@@ -8691,16 +8717,20 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 				acrtc_state->stream->link->psr_settings.psr_version != DC_PSR_VERSION_UNSUPPORTED &&
 				!acrtc_state->stream->link->psr_settings.psr_feature_enabled)
 			amdgpu_dm_link_setup_psr(acrtc_state->stream);
-		else if ((acrtc_state->update_type == UPDATE_TYPE_FAST) &&
-				acrtc_state->stream->link->psr_settings.psr_feature_enabled &&
-				!acrtc_state->stream->link->psr_settings.psr_allow_active) {
-			struct amdgpu_dm_connector *aconn = (struct amdgpu_dm_connector *)
-					acrtc_state->stream->dm_stream_context;
+
+		/* Decrement skip count when PSR is enabled and we're doing fast updates. */
+		if (acrtc_state->update_type == UPDATE_TYPE_FAST &&
+		    acrtc_state->stream->link->psr_settings.psr_feature_enabled) {
+			struct amdgpu_dm_connector *aconn =
+				(struct amdgpu_dm_connector *)acrtc_state->stream->dm_stream_context;
 
 			if (aconn->psr_skip_count > 0)
 				aconn->psr_skip_count--;
-			else
-				amdgpu_dm_psr_enable(acrtc_state->stream);
+
+			/* Allow PSR when skip count is 0. */
+			acrtc_attach->dm_irq_params.allow_psr_entry = !aconn->psr_skip_count;
+		} else {
+			acrtc_attach->dm_irq_params.allow_psr_entry = false;
 		}
 
 		mutex_unlock(&dm->dc_lock);
@@ -8949,8 +8979,10 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 
 	if (dc_state) {
 		/* if there mode set or reset, disable eDP PSR */
-		if (mode_set_reset_required)
+		if (mode_set_reset_required) {
+			flush_workqueue(dm->vblank_control_workqueue);
 			amdgpu_dm_psr_disable_all(dm);
+		}
 
 		dm_enable_per_frame_crtc_master_sync(dc_state);
 		mutex_lock(&dm->dc_lock);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index c6b8b835b08a..d1d353a7c77d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -91,12 +91,14 @@ struct dm_compressor_info {
  * @work: Kernel work data for the work event
  * @dm: amdgpu display manager device
  * @acrtc: amdgpu CRTC instance for which the event has occurred
+ * @stream: DC stream for which the event has occurred
  * @enable: true if enabling vblank
  */
 struct vblank_control_work {
 	struct work_struct work;
 	struct amdgpu_display_manager *dm;
 	struct amdgpu_crtc *acrtc;
+	struct dc_stream_state *stream;
 	bool enable;
 };
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq_params.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq_params.h
index f3b93ba69a27..79b5f9999fec 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq_params.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq_params.h
@@ -33,6 +33,7 @@ struct dm_irq_params {
 	struct mod_vrr_params vrr_params;
 	struct dc_stream_state *stream;
 	int active_planes;
+	bool allow_psr_entry;
 	struct mod_freesync_config freesync_config;
 
 #ifdef CONFIG_DEBUG_FS
-- 
2.25.1

