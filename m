Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3768ECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Sep 2022 21:20:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E46110E8E9;
	Wed, 21 Sep 2022 21:20:40 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86F3010E8E9
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Sep 2022 21:20:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hcvs1sgYgP+vRFcrXA9sZ0ucosgiaO6iNnZn+jU0hY72/jp04KjH0zBcTv5EmsRGW8XOuFwwhjVqTb4Illp3FAD641B8FbmD5Yovlbl+lBecYScnt6RysOjvRG3P7VpyBJieSdGBVxQWpvNFzlCBlUE/8VTsJYtDQtiUO3VGPWBaTSxkrV5hC7i5VvN5dAwBVlS2GkKbtoAZSlmTZon/PG4d9SjEeRtmLVoMjSXo0BzgODb6d5mal05w1l1WMHjab2h57gQd22zDMc1MXwgyFAD3FHJvH8q2gHktUEXhurEMYeeyZVk6uiMDXCLBZSNX3gr1i9sgu/LUrUMHwRm/tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6PjH0UsvArfG2q1zBV9pmOHEh+ubXBOYP939Kn/grY0=;
 b=a/IjJBEbTA7r2HgYLctBv/l+rRU8mUJuuY8cC9ZWlHi7p8puwIk5q33D/7OYRE408zd+IfnoHoTGVlv7/sgE3zgmX2iYH2lXXrUr8+jDaZjEu7FmfFOnCvYs023j5iknc5oEFvsEmU13jZiaWqpE291Mcx0mCPVg+2LVRhSfgCOlr4WUOKCkqXFnrdtXp1RJ2VX9nGNordL5FOlNLytaUxqj2dfhN5C9uBk5DXtoA92ud//kLjK6y4r2fDhjh7LpP5Pi2/7bq/77PLttlDTBPFrw4qZ/fa14wQI5AxJTS+htNkrsE/pHKuKDeeRyNTLR1KZmfSylpkIzIh+cvi9tQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6PjH0UsvArfG2q1zBV9pmOHEh+ubXBOYP939Kn/grY0=;
 b=epKOsPSaGdOQ8GYNKUh8VGdoU0wCVc2qWuwVWY5uJxAAF/x4DlO9UdCRinJcI6Q9LnMcAP4iMqxAO4VApseeF/txElC3vNE5K2K/etdeJ7Eu/zEKuYHtoi/kofeqn9Dirxr2ivUp9bw9PGiqpvn1Ht7q6LNsYOAAw6QSzjB2T8o=
Received: from DS7PR03CA0101.namprd03.prod.outlook.com (2603:10b6:5:3b7::16)
 by SJ0PR12MB7066.namprd12.prod.outlook.com (2603:10b6:a03:4ae::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17; Wed, 21 Sep
 2022 21:20:33 +0000
Received: from CY4PEPF0000B8ED.namprd05.prod.outlook.com
 (2603:10b6:5:3b7:cafe::e8) by DS7PR03CA0101.outlook.office365.com
 (2603:10b6:5:3b7::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14 via Frontend
 Transport; Wed, 21 Sep 2022 21:20:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000B8ED.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.11 via Frontend Transport; Wed, 21 Sep 2022 21:20:31 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 21 Sep
 2022 16:20:31 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 21 Sep
 2022 14:20:30 -0700
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Wed, 21 Sep 2022 16:20:30 -0500
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Harry.Wentland@amd.com>,
 <mario.kleiner.de@gmail.com>, <Rodrigo.Siqueira@amd.com>,
 <alexdeucher@gmail.com>
Subject: [PATCH v5] drm/amd/display: Fix vblank refcount in vrr transition
Date: Wed, 21 Sep 2022 17:20:19 -0400
Message-ID: <20220921212019.9496-1-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8ED:EE_|SJ0PR12MB7066:EE_
X-MS-Office365-Filtering-Correlation-Id: e70f35e0-0782-48c2-2400-08da9c171d71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tvm3E82mVElrRUyujtUvkdedfRxyrWlFPtqpDcGWeq72RqP7Btg2+LDNg2XW2McyDfOxfEjND0II5Kdkv0q4mJ8uL7/30bNauX0kvWW7O9fFcPEsxhFx4TiEqXHdJA6JIP39Epje5jcg+tkJZnGp8M4bcEt0H2Fmvyd0XW3/Ohm5May3G/QgXSljuIxsLy5Q9xhm1BIopEiSYUvKiy81Osh8h4zt8jM3PygW4uE0qWqj5nTP34kPh6H4GciTbA2WQ4NF03Z0v/XHgvTBGat/JQqRCC0HS7tl7DjqaQMazEx2KMbr6lnsZnfhBeygWDZi7ZNCCZP0hYBvgqTES4+MAB79WAC0dnyRM8R37Lw1HhstUp4XnLiTjYIRDLdJq/6nhhEowG5bqZ231opub1ERpT/I9F1AAF1munf6db2xtnyFjEpI0YhjU7w2gz4yHgrhGFndyLJzsdZzjnt/qL2GPkpWDM57bDrVuG73sVFTBqolMafhKE43/ht/LCgRsh6YtO1oqfU3WLrv+zosIM+JZFYLshOrERBdwdDvVgnCweaG7OMQYv6XIc4CgMrNRs/ItDEm0clC46xhcpJf17VWiHXIjmPx5zShgpwFJ80UbctBNrbc59jkaqq225oODUNKofZDnP7oOrQlzIgLoYrBqK3/oPQlyJEPjmuXwtmc2uaylZxvXw+PU6uo5dKxbp4AIQkPnEP48exQ+B8HaByqgr26L9hpGTP/irYY0nz0uyljJ8Os4jiBzauryuuUF1xc
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(136003)(39860400002)(346002)(451199015)(36840700001)(46966006)(40470700004)(2906002)(47076005)(110136005)(70206006)(70586007)(8936002)(316002)(8676002)(81166007)(356005)(36860700001)(82310400005)(966005)(478600001)(86362001)(4326008)(41300700001)(5660300002)(36756003)(6666004)(40460700003)(2616005)(336012)(426003)(1076003)(83380400001)(186003)(40480700001)(82740400003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 21:20:31.7231 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e70f35e0-0782-48c2-2400-08da9c171d71
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7066
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

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1247
Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1380

Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
---
v2: check the return code for calls that might fail and warn on them
v3/v4: make the sequence closer to the original and remove redundant local variables
v5: add bug tracking info

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 55 +++++++++----------
 1 file changed, 26 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index ece2003a74cc..97cc8ceaeea0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7484,15 +7484,15 @@ static void amdgpu_dm_handle_vrr_transition(struct dm_crtc_state *old_state,
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
@@ -8257,23 +8257,6 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
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
@@ -8283,16 +8266,29 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
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
@@ -8300,16 +8296,19 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
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
@@ -8321,12 +8320,10 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
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
2.37.3

