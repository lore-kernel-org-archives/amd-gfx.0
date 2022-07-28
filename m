Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5C71C04A68
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Jul 2022 13:49:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 356F912BB25;
	Thu, 28 Jul 2022 13:49:50 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EAD5112FE9
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Jul 2022 13:49:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cj1SzYMcsJ6WwQmf8lNvjsi7IobpjR+qW3dgcZSthjvBhU0pureo0AAm9XqMVgUWp41z6Dtjkrsu1cbY3pbesCzECrLjUm/u+6CszPJRoVMxCABq2iPL+EzQuQXlxl4MvIyN8VydcvP98keYTEoq6kUtNYMN/fCzxKD+fRoAnRZCWyotrzQV4AJji5ykSDxlwaPKzTZL2GDPgWk82RDW+SSZt3QL6muFncE6NjfYi6PxLy3LYYFm0iwBtVOywmYUfWSFZacHczKjDyi3JZx5Vid4VgcIbofwgsTP/epaIAHoeBo+I+ac3Co5gWJFLFWEOxwgdZRo+jxQER0vjhtN4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QRVk5SaFBMohH+yGGjapfbOQaQBxDaFSJChdb9Vueg8=;
 b=bhUX9yKyX2I+Uckq18GQ9a4WPhQ9V69g98y4XgY/kxiYd0JLRoIWG33ErFka1E2pGRFanGoYjttUw/3Ti6Z8cNA0WIRskWyib68Ga415kJHDDzPsMO4pTesA2ml3Dg90EvNNsy7Gaocr/BQWhDQu+dstm3Mcl1ygJESy8ycG0BLwon6+BrQLrgziyGwyNLf9+6Fd4GP/8RgHeO5jRUEbfxwQU7FXb0Mbfl21nGwGzw2Y+og5h3OAA8HqoZqgW/payPkQpLSnuozbfKsJWk6SPWEi5CfgVWLCG0Vpa8vdZuC7Tz6XT0f06LrbeeeQYSMiPFPb8iwwfFu/J73zDrTnUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QRVk5SaFBMohH+yGGjapfbOQaQBxDaFSJChdb9Vueg8=;
 b=uldkZ4szPu1ztLw+F3pwifh+MEVeLVPMITZrzb8NXmAMvLy20dtmUTqJtEbGOcxHb9xNR+PJo3/3zSwnm/9k6+WKWo8s6EzvmMbq8XX27/CFn3yAs5BLcrtGyM56E+7JaYWf1ToDKL1B5drSX1YiE1Wkckcf1UBzW7UFg0+z4OI=
Received: from DM6PR04CA0013.namprd04.prod.outlook.com (2603:10b6:5:334::18)
 by DM4PR12MB6133.namprd12.prod.outlook.com (2603:10b6:8:ae::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5458.25; Thu, 28 Jul 2022 13:49:44 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::5f) by DM6PR04CA0013.outlook.office365.com
 (2603:10b6:5:334::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18 via Frontend
 Transport; Thu, 28 Jul 2022 13:49:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5482.10 via Frontend Transport; Thu, 28 Jul 2022 13:49:44 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 28 Jul
 2022 08:49:41 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 28 Jul
 2022 08:49:41 -0500
Received: from MKM-L10-YUNXIA9.lan (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Thu, 28 Jul 2022 08:49:41 -0500
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amd/display: Fix vblank refcount in vrr transition
Date: Thu, 28 Jul 2022 09:49:34 -0400
Message-ID: <20220728134934.11434-1-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: afcb8750-2549-4dac-3ec9-08da70a00714
X-MS-TrafficTypeDiagnostic: DM4PR12MB6133:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lJ2jZXkFCtBbxFn123r1NuhsAARKitldlak7qBTbE9/dkihMttp1l5+HqsSic2M1G7QT9WgO6NNoPXFD0aI8QrR91rB5TmqJp+v9/VNOWeuwlvHO4ss9ClkQRRZvHHs53sUVuyVdPqqMPHfawzKRjPe7RCUvOgUu/pCr+Q9Uxz+PMXxlspxShG6GLyweryEuyGCIcjOToB1gO6cebBto0kmEM17A74oY2b+iR+w0HAqv0vbphm6JKiCXOxC4pQ6+wRmyTR5GETnQSgyPt/Q3HrvABDgJo4CD5LNKFCLRg0NcMUfLgsLD58Zu5LPYOAtp+kNK77UXy+TJYtJZsppu0QZAFp0A1cIdgEJK4V1iADLFSfCQ7XsoTBNAC1y5+AXxTz0Njho3N2K6hLkrJdFbfOnUg8hd/crwDkRiFPipl8QkdK5PixxSFGeP+Ezl+ni+VjY7odAOlH+dpiAJirXmHxR4irjkZ8rGve2KoKiaM79G1syvCOoJt9e3JLgw8jryPMgvl8hts+Afm88Kvisi6itFN6xoIsI5MJRrOFQ3lExf0Oop6CiZZQMgYHLrfgt7GpACUoFaZvpzI/0pWfg+JeaAY/OiM0Fw3TAS8qM2EL9wqbK82MkGWlEbWEGzowwiETxeTATCeD3Kf2ci1VxOMH3aYtyn3fa3YpfXvDDIE1iCcYBgv/0TDp7KfINJlYXX065llICfATsw+s490VbCecZbX3oRN+RKTkmP5+fEpOH8Oo9udZkrzcnPn7ukEGr+WSWbfY/1U42CnC+chWm0Cm2HpgPsasuMorsvcOVUCKEgmOxrnakI04EO5wmu1FHc
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(39860400002)(376002)(396003)(136003)(36840700001)(46966006)(40470700004)(82740400003)(356005)(6666004)(41300700001)(82310400005)(36756003)(81166007)(4326008)(8936002)(70586007)(478600001)(8676002)(70206006)(966005)(40460700003)(26005)(83380400001)(5660300002)(86362001)(336012)(6916009)(316002)(36860700001)(426003)(2906002)(40480700001)(2616005)(186003)(1076003)(47076005)(117716001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2022 13:49:44.1098 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afcb8750-2549-4dac-3ec9-08da70a00714
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6133
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

Unchecked calls to drm_crtc_vblank_get seems to be common in other
drivers as well so it may make sense to let get always succeed during
modset, see
https://lists.freedesktop.org/archives/dri-devel/2022-July/365589.html

Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
---
v2: check the return code for calls that might fail and warn on them

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 34 ++++++++-----------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 92470a0e0262..9f3fdb92e7a4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7480,15 +7480,15 @@ static void amdgpu_dm_handle_vrr_transition(struct dm_crtc_state *old_state,
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
@@ -8252,23 +8252,6 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
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
@@ -8287,7 +8270,15 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 		cur_crc_src = acrtc->dm_irq_params.crc_src;
 		spin_unlock_irqrestore(&adev_to_drm(adev)->event_lock, flags);
 #endif
+		/* Count number of newly disabled CRTCs for dropping PM refs later. */
+		if (old_crtc_state->active && !new_crtc_state->active)
+			crtc_disable_count++;
+
 		dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
+		dm_old_crtc_state = to_dm_crtc_state(old_crtc_state);
+
+		/* For freesync config update on crtc state and params for irq */
+		update_stream_irq_parameters(dm, dm_new_crtc_state);
 
 		if (new_crtc_state->active &&
 		    (!old_crtc_state->active ||
@@ -8324,6 +8315,9 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 					DRM_DEBUG_DRIVER("Failed to configure crc source");
 #endif
 		}
+
+		/* Handle vrr on->off / off->on transitions */
+		amdgpu_dm_handle_vrr_transition(dm_old_crtc_state, dm_new_crtc_state);
 	}
 
 	for_each_new_crtc_in_state(state, crtc, new_crtc_state, j)
-- 
2.37.1

