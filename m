Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAD65C32793
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Aug 2022 00:25:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E82910E8D4;
	Wed, 24 Aug 2022 00:25:33 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84F1610E536
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Aug 2022 00:25:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HagBNNOExz1/OxZ9Ml/0xtRp7DHruI4rrAFoBzlwvSR/p1oN1axNViQp646HIaZIlVTQZLdGZnijWGKxX/DMrXN23Xhuz5Lvkuv+eKy7nf/jWEwdlpRmCFZr0+N5ZLLPZQ5vPN4tWbD77CP5O9NW48tDyftOsQwPOTN6KAF+wxVgjQeDEeHSRgzHODZFGysZNeyH/hJsX2r0lUb4TXfmUQyO1WvtW30FQrPbA+2TSvDHA1mm6xyOhzmm2Ihb9knn3Kesh34KTc9MdFfmGPClXZr8rWj9rTer1Nxh2dMiQhDmq+wBwg8/rm4aK9gIxwUcf6JJBqhdzfbsF23UJHHwOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fpy/H/y8scsdNLaIaZoiu7BdC3angMdbCX05JhwMzQA=;
 b=bRbTU5a9R3/9DNLwMmHcor5KPYNjwI0XQsPTeqOhU1gxh2N1bjjPhq/5qO+w0SSFsjVGoyNkdGUTAFX0S44xZS24fz6r/+O/TPoGP3BDgTtvtg3KMVoMJVm5soW6jhyn2z+gr1czlJjB9i8YofbzGzuUIfZI10R7ULaLwvqekbqtQhhxooB0NOi/svBk9posZ8sF4Xs0eEyKt03tXHRSIxBB6N8rEo41RxU8IJ9wGSiSruL8ckC2j9+Gz1uweY/AYyvWeRh0rZgfQC1pxCPQZSWHZmH9aCEwMop367cGv9IvtUTjJCgpCxBgYOfNBptyhHS/tApdu8qLU23gXOdI2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fpy/H/y8scsdNLaIaZoiu7BdC3angMdbCX05JhwMzQA=;
 b=SVV/Cij5EOGIPgunvW5hcf2OmqoOtAp5se4+kPTXTP/YogLnU/5rA7hA2iVYj+tTKzQGzXZKtxWnoG6Z3A2+LB0FKDhMo7KD9NBbqDI8TVvwCzjcA9rzXiYo/LfQnqMDb+5AwYmXPUiHHjG8v9hXKOf/5zaoKcIY9fwGGpNcI18=
Received: from MW4PR04CA0254.namprd04.prod.outlook.com (2603:10b6:303:88::19)
 by DM4PR12MB5794.namprd12.prod.outlook.com (2603:10b6:8:61::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Wed, 24 Aug
 2022 00:25:18 +0000
Received: from CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:88:cafe::ad) by MW4PR04CA0254.outlook.office365.com
 (2603:10b6:303:88::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22 via Frontend
 Transport; Wed, 24 Aug 2022 00:25:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT021.mail.protection.outlook.com (10.13.175.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Wed, 24 Aug 2022 00:25:17 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 23 Aug
 2022 19:25:17 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 23 Aug
 2022 17:25:16 -0700
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 23 Aug 2022 19:25:16 -0500
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Harry.Wentland@amd.com>,
 <mario.kleiner.de@gmail.com>
Subject: [PATCH v4] drm/amd/display: Fix vblank refcount in vrr transition
Date: Tue, 23 Aug 2022 20:25:14 -0400
Message-ID: <20220824002514.4060-1-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af4d26d8-4746-47ca-678d-08da85671f61
X-MS-TrafficTypeDiagnostic: DM4PR12MB5794:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 74KEHkBCZcoZOKKRad6byORBi6cWTiKrMvXR6m75FJ3Ce28gBMY/SorP1WT0Hf4az8SJuavFktMsj9gC1ERnAUQuQTBD94p68IQLMGK5YHLA1g1tymr1rlvazz6T3FB4seeD6uTUXt5IqNdQX8ppjAcv8DbvEEgJtOhJFnG4eaZKmOEUkqRxmp5pJl3UghpgGIrUu8Jn/hmu39LDPpAX2zu3qXoD+88G0KAO5QTBfTJ7YSPMhc03lnCwkDsFl+eotknFa402cZGHTtU208uAIbjaMz15MhtJX6wznmpZQ4+SDUdQGJnkXaPpNd2n36oZ0UMYmqvsQ7qxnE9/PtSN0WR2htMknESwMmtP9x5RzEaVqhH9DDZnOwGvraoQ3WNYBuKWMev1V0tbyHHOsezM30Lto7PvBjoQ+KDtF9YZa8+HolndOTT06Qu1v3ZgY7IoKbr1Y9ZpPv3Ttqg8YeTW3Ama8vWPeZfU8tejdlEtfvlSnZtNMDrF7KDxX3o6t3Z3Nm8Rfy5RRAs/6g+YI7I8bu8lNZ078ZTAdZ4e78wDt2YWj3qAsUeB2dummI5iz6iO/Xe3M10TBcvAqLrzETqlK5guEVc3hAUX6uHPpEcIoRoVm8Kuxd5ITdNykJzKArLdZN9q0hCFcrE5AgtQYcOSB0jXGZuvd7e8DbJhTE+3wBOFB7brmpFqbZK649OkjtdXZfmdGxeOkBLvBafvkyGWJQcFzv8pN8mz24Oy+yh8wMmD/avFhf1CoGl9ejFz8D1RDg3KICQ3kVVOW7loyRq/Ed2MGD87gfBR441KqCFQ7zzzHhc8o8ebysOU1OvVUcNW
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(376002)(136003)(346002)(396003)(40470700004)(46966006)(36840700001)(36756003)(4326008)(8936002)(83380400001)(26005)(5660300002)(316002)(70206006)(8676002)(36860700001)(70586007)(82310400005)(40460700003)(81166007)(41300700001)(2906002)(86362001)(82740400003)(110136005)(1076003)(426003)(186003)(336012)(2616005)(40480700001)(356005)(47076005)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 00:25:17.9074 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af4d26d8-4746-47ca-678d-08da85671f61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5794
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
Cc: Yunxiang Li <Yunxiang.Li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

manage_dm_interrupts disable/enable vblank using drm_crtc_vblank_off/on
which causes drm_crtc_vblank_get in vrr_transition to fail, and later
when drm_crtc_vblank_put is called the refcount on vblank will be messed
up. Therefore move the call to after manage_dm_interrupts.

Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
---
v2: check the return code for calls that might fail and warn on them
v3/v4: make the sequence closer to the original and remove redundant local variables

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 55 +++++++++----------
 1 file changed, 26 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index bc2493a2a90e..de80b61b8d8e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7488,15 +7488,15 @@ static void amdgpu_dm_handle_vrr_transition(struct dm_crtc_state *old_state,
 		 * We also need vupdate irq for the actual core vblank handling
 		 * at end of vblank.
 		 */
-		dm_set_vupdate_irq(new_state->base.crtc, true);
-		drm_crtc_vblank_get(new_state->base.crtc);
+		WARN_ON(dm_set_vupdate_irq(new_state->base.crtc, true) != 0);
+		WARN_ON(drm_crtc_vblank_get(new_state->base.crtc) != 0);
 		DRM_DEBUG_DRIVER("%s: crtc=%u VRR off->on: Get vblank ref\n",
 				 __func__, new_state->base.crtc->base.id);
 	} else if (old_vrr_active && !new_vrr_active) {
 		/* Transition VRR active -> inactive:
 		 * Allow vblank irq disable again for fixed refresh rate.
 		 */
-		dm_set_vupdate_irq(new_state->base.crtc, false);
+		WARN_ON(dm_set_vupdate_irq(new_state->base.crtc, false) != 0);
 		drm_crtc_vblank_put(new_state->base.crtc);
 		DRM_DEBUG_DRIVER("%s: crtc=%u VRR on->off: Drop vblank ref\n",
 				 __func__, new_state->base.crtc->base.id);
@@ -8261,23 +8261,6 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 		mutex_unlock(&dm->dc_lock);
 	}
 
-	/* Count number of newly disabled CRTCs for dropping PM refs later. */
-	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state,
-				      new_crtc_state, i) {
-		if (old_crtc_state->active && !new_crtc_state->active)
-			crtc_disable_count++;
-
-		dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
-		dm_old_crtc_state = to_dm_crtc_state(old_crtc_state);
-
-		/* For freesync config update on crtc state and params for irq */
-		update_stream_irq_parameters(dm, dm_new_crtc_state);
-
-		/* Handle vrr on->off / off->on transitions */
-		amdgpu_dm_handle_vrr_transition(dm_old_crtc_state,
-						dm_new_crtc_state);
-	}
-
 	/**
 	 * Enable interrupts for CRTCs that are newly enabled or went through
 	 * a modeset. It was intentionally deferred until after the front end
@@ -8287,16 +8270,29 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state, new_crtc_state, i) {
 		struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
 #ifdef CONFIG_DEBUG_FS
-		bool configure_crc = false;
 		enum amdgpu_dm_pipe_crc_source cur_crc_src;
 #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
-		struct crc_rd_work *crc_rd_wrk = dm->crc_rd_wrk;
+		struct crc_rd_work *crc_rd_wrk;
+#endif
+#endif
+		/* Count number of newly disabled CRTCs for dropping PM refs later. */
+		if (old_crtc_state->active && !new_crtc_state->active)
+			crtc_disable_count++;
+
+		dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
+		dm_old_crtc_state = to_dm_crtc_state(old_crtc_state);
+
+		/* For freesync config update on crtc state and params for irq */
+		update_stream_irq_parameters(dm, dm_new_crtc_state);
+
+#ifdef CONFIG_DEBUG_FS
+#if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
+		crc_rd_wrk = dm->crc_rd_wrk;
 #endif
 		spin_lock_irqsave(&adev_to_drm(adev)->event_lock, flags);
 		cur_crc_src = acrtc->dm_irq_params.crc_src;
 		spin_unlock_irqrestore(&adev_to_drm(adev)->event_lock, flags);
 #endif
-		dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
 
 		if (new_crtc_state->active &&
 		    (!old_crtc_state->active ||
@@ -8304,16 +8300,19 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 			dc_stream_retain(dm_new_crtc_state->stream);
 			acrtc->dm_irq_params.stream = dm_new_crtc_state->stream;
 			manage_dm_interrupts(adev, acrtc, true);
+		}
+		/* Handle vrr on->off / off->on transitions */
+		amdgpu_dm_handle_vrr_transition(dm_old_crtc_state, dm_new_crtc_state);
 
 #ifdef CONFIG_DEBUG_FS
+		if (new_crtc_state->active &&
+		    (!old_crtc_state->active ||
+		     drm_atomic_crtc_needs_modeset(new_crtc_state))) {
 			/**
 			 * Frontend may have changed so reapply the CRC capture
 			 * settings for the stream.
 			 */
-			dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
-
 			if (amdgpu_dm_is_valid_crc_source(cur_crc_src)) {
-				configure_crc = true;
 #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
 				if (amdgpu_dm_crc_window_is_activated(crtc)) {
 					spin_lock_irqsave(&adev_to_drm(adev)->event_lock, flags);
@@ -8325,12 +8324,10 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 					spin_unlock_irqrestore(&adev_to_drm(adev)->event_lock, flags);
 				}
 #endif
-			}
-
-			if (configure_crc)
 				if (amdgpu_dm_crtc_configure_crc_source(
 					crtc, dm_new_crtc_state, cur_crc_src))
 					DRM_DEBUG_DRIVER("Failed to configure crc source");
+			}
 #endif
 		}
 	}
-- 
2.37.2

