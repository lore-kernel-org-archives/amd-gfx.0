Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD9D4C19F2D
	for <amd-gfx@archiver.kernel.org>; Sat, 13 Aug 2022 15:58:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53309BDCAC;
	Sat, 13 Aug 2022 15:58:06 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2047.outbound.protection.outlook.com [40.107.100.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD06DA1E9E
 for <amd-gfx@lists.freedesktop.org>; Sat, 13 Aug 2022 15:57:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gu9N1aaTTqrulxapQnMXlmqx3Be0kYxOClrb04fOlO8wdcQcG/UnwHwSR51T63THS5z5UgVKp1J3voyB/LrTPDRFIZp5QeopDy3XHAD4YWMPcsqVkmaXuMSDBd8LUQXZO54Fke/oIYLeZE7aNtuUQZotLD5MioQSuzHqIpaH1AqFE2H40ann6DG59FZCAhDca6X+Roh2Y7LZm+2JBsKDcJ7vDq9gOWQybmyGZ9k4BbrBAwQJR85ux/f5qzSnFBvFowmsfYU17KkdGXk2QrNTiTs/oW8pwXHGaJ3Wq7ZnSoA0gH6x/kUX0CF7gdvJUcz9nnMZ4sFRa5aHkQFxc1BD1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cvTk9+6/gasZgGK9N4id0AHowxS9SYBk6nqRPEvvUWA=;
 b=i11ZY4iDT/aYVF4Ex7gfrpMfpIVSyKhnkrGg55lKQ1aVXjdtBNxNP/hSk1v690Fn0Rcy4n1aKIaWCI+baLH3uMQvD+SnlBPegxtizFYcRqPP2tgzoe/LfBA1tdcn+tyRDpMKhiVs2OcVrzcTE3O2r1FYQ6GHm9Co3leUslkSbPalzG8k97B5Oz/JvpSXgLaPRckvD0uF7pGvDU9mhPPwkMPU8wiVINNTCTG84ivABgcD9CbksQxswyfYQZFXhDt06PQNcSTalT9el6P9OWl1MdN1JwEkztfExX/7V8JcY8yIf9wv/VlbfcsUKubCAJj3k0iN+IHQoYMkNNdcAZYP+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cvTk9+6/gasZgGK9N4id0AHowxS9SYBk6nqRPEvvUWA=;
 b=4bWok4oOy72vUsL8SZQK3gsVtgzCJ/nWZ49Io0+1Onv2A4Xpm/3i4nX3NyA6EoVX/G57oTV/bKlWSAlEi6PM1EKHTx8FqyyJvvGmxV1iTo2JhXzY1CgNMokaU4yooewN6Zkz/7bVb0CA1lbQRNPo9CNfxpf830m4STjXlPXSw/Q=
Received: from BN0PR04CA0035.namprd04.prod.outlook.com (2603:10b6:408:e8::10)
 by DM6PR12MB3305.namprd12.prod.outlook.com (2603:10b6:5:189::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Sat, 13 Aug
 2022 15:57:47 +0000
Received: from BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e8:cafe::5f) by BN0PR04CA0035.outlook.office365.com
 (2603:10b6:408:e8::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20 via Frontend
 Transport; Sat, 13 Aug 2022 15:57:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT032.mail.protection.outlook.com (10.13.177.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5525.11 via Frontend Transport; Sat, 13 Aug 2022 15:57:47 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sat, 13 Aug
 2022 10:57:46 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sat, 13 Aug
 2022 08:57:46 -0700
Received: from MKM-L10-YUNXIA9.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via
 Frontend Transport; Sat, 13 Aug 2022 10:57:46 -0500
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <harry.wentland@amd.com>,
 <mario.kleiner.de@gmail.com>
Subject: [PATCH v3] drm/amd/display: Fix vblank refcount in vrr transition
Date: Sat, 13 Aug 2022 11:57:43 -0400
Message-ID: <20220813155743.8056-1-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5bc2f376-b576-4dcb-f613-08da7d44916d
X-MS-TrafficTypeDiagnostic: DM6PR12MB3305:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dk8fqZ+vFmBpDjmVdzocmGVn34nRBYGuCuAZkIv/qGq2EwdtIM7YSIYjv7Q6isU8a6aeLuHiyhjuPpBuQyGw41sasrvMbp4k+AO0OEFM/KfcbWFeTzHpaI86C08LWcUFWosg/AvkEhe2npbkRLbotnH2RSbokuWnM0a1ixQWxqa5f7lLVDhxWEu+FquhbhJ48nWGnT34NaAXAcTozxJ6oHuaDh9k4XKg5h4kz7mM0Pb1QyD6YrPVlvusYmDTlR7bPO48qiNoaz9BZiMjL+VviJ6hxONnNYs4Kt9VWoJG9OlgOxdiz+rC3E74TkWfYbRGWqOQurKDirQPENGbS23bJ/xWOJhQy8bQf6+BgAEOdMzfxr6Bxlz8P0cToe6Qf8ip+V9bdoaNtkuSlgVjvbN57EH7myN7HiKYsKf14Xkn14MJWhznErM90hVdDY95E7R4q3iGW5Fxfpq1ew1OszsMni5XRzk/ESaO/HxZa1sxp/Ojw/gwl31I955yopYqYqpmsMXNsyH54Y2+Oku4VTI5K4/yTZJfGQOp90oKCEcCtZLyVGIqB4v7B+AZi9BWQ88UeUzfDCL+AGMF/GZU5rxnZ7mGONTDubGrfpNN4DvshxhLCj0XBNseikTsesAt0a3cpZoyo36zMgOW+GEMzsD/ktBConMveTk+QMOyBjfyXhY41veJD3KCcnoR6oN1nBd7ll6RHAzdEkfvHb9zchbkXQdJrtJIXKNSFt6ppbbLTi2jdZ0mmigjnENK/relWY8HDW3BSA3Nc5vbEFepmwB8muM+J3nAV8ZRcuKDPhloF/zvQa50Jfyfvmi4oRTEql6Pkjb+KJogNjsm1XLYDia8ew==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(376002)(396003)(39860400002)(136003)(36840700001)(46966006)(40470700004)(26005)(36860700001)(40480700001)(41300700001)(7696005)(2616005)(82310400005)(1076003)(186003)(40460700003)(6666004)(426003)(47076005)(336012)(83380400001)(4326008)(70586007)(70206006)(8676002)(2906002)(8936002)(5660300002)(478600001)(110136005)(316002)(356005)(82740400003)(86362001)(81166007)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2022 15:57:47.3278 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bc2f376-b576-4dcb-f613-08da7d44916d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3305
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
v3: remove redundant local variables

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 42 +++++++------------
 1 file changed, 15 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index ddcb7845f642..bbb1587216bc 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7481,15 +7481,15 @@ static void amdgpu_dm_handle_vrr_transition(struct dm_crtc_state *old_state,
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
@@ -8254,9 +8254,15 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 		mutex_unlock(&dm->dc_lock);
 	}
 
-	/* Count number of newly disabled CRTCs for dropping PM refs later. */
-	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state,
-				      new_crtc_state, i) {
+	/**
+	 * Enable interrupts for CRTCs that are newly enabled or went through
+	 * a modeset. It was intentionally deferred until after the front end
+	 * state was modified to wait until the OTG was on and so the IRQ
+	 * handlers didn't access stale or invalid state.
+	 */
+	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state, new_crtc_state, i) {
+		struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
+		/* Count number of newly disabled CRTCs for dropping PM refs later. */
 		if (old_crtc_state->active && !new_crtc_state->active)
 			crtc_disable_count++;
 
@@ -8266,21 +8272,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 		/* For freesync config update on crtc state and params for irq */
 		update_stream_irq_parameters(dm, dm_new_crtc_state);
 
-		/* Handle vrr on->off / off->on transitions */
-		amdgpu_dm_handle_vrr_transition(dm_old_crtc_state,
-						dm_new_crtc_state);
-	}
-
-	/**
-	 * Enable interrupts for CRTCs that are newly enabled or went through
-	 * a modeset. It was intentionally deferred until after the front end
-	 * state was modified to wait until the OTG was on and so the IRQ
-	 * handlers didn't access stale or invalid state.
-	 */
-	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state, new_crtc_state, i) {
-		struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
 #ifdef CONFIG_DEBUG_FS
-		bool configure_crc = false;
 		enum amdgpu_dm_pipe_crc_source cur_crc_src;
 #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
 		struct crc_rd_work *crc_rd_wrk = dm->crc_rd_wrk;
@@ -8289,7 +8281,6 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 		cur_crc_src = acrtc->dm_irq_params.crc_src;
 		spin_unlock_irqrestore(&adev_to_drm(adev)->event_lock, flags);
 #endif
-		dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
 
 		if (new_crtc_state->active &&
 		    (!old_crtc_state->active ||
@@ -8303,10 +8294,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
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
@@ -8318,14 +8306,14 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
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
+		/* Handle vrr on->off / off->on transitions */
+		amdgpu_dm_handle_vrr_transition(dm_old_crtc_state, dm_new_crtc_state);
 	}
 
 	for_each_new_crtc_in_state(state, crtc, new_crtc_state, j)
-- 
2.37.1

