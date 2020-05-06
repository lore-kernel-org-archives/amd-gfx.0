Return-Path: <SRS0=JxR8=6U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 494C2C28CBC
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2020 19:48:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0782820747
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2020 19:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qPGoYaEA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0782820747
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E29689F35;
	Wed,  6 May 2020 19:48:04 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8F8389F35
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 May 2020 19:48:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aGrkcPpteZatH4YtvEfyazEJHmQaCU3Z5nzfs/fHRmpkRwdk6XqJQaeNNRwiGh+FaRmOKUrwufj6hXguHsMTC2MhyGlpaGOJNKJ8q/7NissZTJzvk5X+ULIWQ6r+k3RY72sk2hhLWdWbnBPfEyR1ijH42EN4OQ1GgH7juyLbAjPvg0gWX/xAVSjtDFOozpnLP+AkK0QpAp7DERHkjZ231q1sAvGBu6MQ0g2bp2WzTmi0oaqEEnz0ToKeDgaIhOUBNaunvOrCXA0JNokJ4eLxzNhajK4d3ujgY+1HqoMKimvLQ/2wGjy85hM4Ck7Ng9CqsO9j98yfrIuEjopi1EX3rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VX86B+atU9gVtNneJ+JxYe66bMhMfWnFtWObDiHWTWQ=;
 b=TLKhrjZZDeLqzZZ4OmddPeDN3dX7ms/PXqoFbMncMfMin4RwkywVTqUxsuXer8JGikJGEDq8Bj9vPFGZJUH3aQJnBZc0EdtAhMa078Sj80Q2qWzg7rb587NDZ+t6hD/j6ljv5X/o3K7QFmVFeXrT7t0yEYtcESoB6hb/kNd8SSnSIWRMPfqgv3SEht27tU7be5jrSlv+/OlyWh4/rV8HHc54TEJidg9RnsY5h3JUY0RjvLcfGrNelZ93bdaYcrl8sDO0eXfN0R6TwrXWzbceqLd8QVpArsSgXE5gMyhlcTm2TPHqZGmgc/q0yRNsF2NAAeM3Xf+KglsUyDxxyeTB+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VX86B+atU9gVtNneJ+JxYe66bMhMfWnFtWObDiHWTWQ=;
 b=qPGoYaEAFPq05Kts/xEciaj70nbOO65nn2OI03kXv8a5Wmp2NIBw+2H3Ps+rcSESinO+fzORM7yxP89jWnaSIyXxH4xxlq6d7vOkW03UadHsm1kC4uvCvdeJGi/9fuzMsI1qh9c8zv7ofLAbIJjX1uHK03W2ocLpnPSrNbqijOw=
Received: from BN6PR1201CA0008.namprd12.prod.outlook.com
 (2603:10b6:405:4c::18) by DM5PR12MB2470.namprd12.prod.outlook.com
 (2603:10b6:4:b4::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Wed, 6 May
 2020 19:48:01 +0000
Received: from BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:4c:cafe::89) by BN6PR1201CA0008.outlook.office365.com
 (2603:10b6:405:4c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27 via Frontend
 Transport; Wed, 6 May 2020 19:48:01 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT042.mail.protection.outlook.com (10.13.177.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2979.27 via Frontend Transport; Wed, 6 May 2020 19:48:00 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 6 May 2020
 14:48:00 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 6 May 2020
 14:47:59 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 6 May 2020 14:47:59 -0500
From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Fix vblank and pageflip event handling for
 FreeSync
Date: Wed, 6 May 2020 15:47:54 -0400
Message-ID: <20200506194754.10780-1-nicholas.kazlauskas@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(39860400002)(346002)(376002)(46966005)(33430700001)(47076004)(356005)(36756003)(70586007)(186003)(82740400003)(82310400002)(70206006)(4326008)(33440700001)(5660300002)(1076003)(81166007)(86362001)(2906002)(6916009)(54906003)(316002)(336012)(44832011)(8676002)(2616005)(426003)(6666004)(26005)(478600001)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c2ff2d2-6c95-4329-1d19-08d7f1f6621b
X-MS-TrafficTypeDiagnostic: DM5PR12MB2470:
X-Microsoft-Antispam-PRVS: <DM5PR12MB2470257A53B40569ACCCB76EECA40@DM5PR12MB2470.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 03950F25EC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oIPWx6Ydo+bEF1WIuR6j2447A16bAigXmBoiXfRcDAQeKKcBld5YBqo9nCk9YuyraQuU27TXYMpgB3vFeGGsW3Z4tSVgga/0sWuOyrWZvsBs5cCcUDZuae5iQjecxd0nvCTuxX5bYQFM51Fb/yeGnw1Q4sh29jWtMbDegbyJ32tIpjJ4Z6SALJzNFUc1qtRRc8tK/friHbHhcXlunXsEBCzcw34eA7OmGH4NYpM3hxfMWV42EFtTh91bEsDdvkmxIOvGlqUsK1vSf/cE/lPFAWTa8z1bqUUm89KBrrZTwiigbOfv0zI652xkqkkwj1Sq5+s9PuR5Gfn+su/o4/yqa9ZYYUoRK+pAFfVjUrLT8JoPgDH3YPB1+Mbo5lWvq0VlDjyXKohELlRMMT4jFBalxbDJLU+iA1QvvUSexnitZ8FdMVQaq+Z2wFd8oXNKcdOW0aHw1vi2WLo7DSgxnj60AcHA0llnos//O1zySQQljJNw+eu6rqDWqFAcluF5RbOY5nMxkI86k26huRudn/tzFOMzDB66nufpMafKKZ0goJyA2Ii2OafwSj+RvhirEqPP1y0YK+6BObHlEjQzAPIifQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2020 19:48:00.5967 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c2ff2d2-6c95-4329-1d19-08d7f1f6621b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2470
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
Cc: Leo Li <sunpeng.li@amd.com>, Mario Kleiner <mario.kleiner.de@gmail.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
We're the drm vblank event a frame too early in the case where the
pageflip happens close to VUPDATE and ends up blocking the signal.

The implementation in DM was previously correct *before* we started
sending vblank events from VSTARTUP unconditionally to handle cases
where HUBP was off, OTG was ON and userspace was still requesting some
DRM planes enabled. As part of that patch series we dropped VUPDATE
since it was deemed close enough to VSTARTUP, but there's a key
difference betweeen VSTARTUP and VUPDATE - the VUPDATE signal can be
blocked if we're holding the pipe lock.

There was a fix recently to revert the unconditional behavior for the
DCN VSTARTUP vblank event since it was sending the pageflip event on
the wrong frame - once again, due to blocking VUPDATE and having the
address start scanning out two frames later.

The problem with this fix is it didn't update the logic that calls
drm_crtc_handle_vblank(), so the timestamps are totally bogus now.

[How]
Essentially reverts most of the original VSTARTUP series but retains
the behavior to send back events when active planes == 0.

Some refactoring/cleanup was done to not have duplicated code in both
the handlers.

Fixes: 16f17eda8bad ("drm/amd/display: Send vblank and user events at vsartup for DCN")
Fixes: 3a2ce8d66a4b ("drm/amd/display: Disable VUpdate interrupt for DCN hardware")
Fixes: 2b5aed9ac3f7 ("drm/amd/display: Fix pageflip event race condition for DCN.")

Cc: Leo Li <sunpeng.li@amd.com>
Cc: Mario Kleiner <mario.kleiner.de@gmail.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 137 +++++++-----------
 1 file changed, 55 insertions(+), 82 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 59f1d4a94f12..30ce28f7c444 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -441,7 +441,7 @@ static void dm_vupdate_high_irq(void *interrupt_params)
 
 /**
  * dm_crtc_high_irq() - Handles CRTC interrupt
- * @interrupt_params: ignored
+ * @interrupt_params: used for determining the CRTC instance
  *
  * Handles the CRTC/VSYNC interrupt by notfying DRM's VBLANK
  * event handler.
@@ -455,70 +455,6 @@ static void dm_crtc_high_irq(void *interrupt_params)
 	unsigned long flags;
 
 	acrtc = get_crtc_by_otg_inst(adev, irq_params->irq_src - IRQ_TYPE_VBLANK);
-
-	if (acrtc) {
-		acrtc_state = to_dm_crtc_state(acrtc->base.state);
-
-		DRM_DEBUG_VBL("crtc:%d, vupdate-vrr:%d\n",
-			      acrtc->crtc_id,
-			      amdgpu_dm_vrr_active(acrtc_state));
-
-		/* Core vblank handling at start of front-porch is only possible
-		 * in non-vrr mode, as only there vblank timestamping will give
-		 * valid results while done in front-porch. Otherwise defer it
-		 * to dm_vupdate_high_irq after end of front-porch.
-		 */
-		if (!amdgpu_dm_vrr_active(acrtc_state))
-			drm_crtc_handle_vblank(&acrtc->base);
-
-		/* Following stuff must happen at start of vblank, for crc
-		 * computation and below-the-range btr support in vrr mode.
-		 */
-		amdgpu_dm_crtc_handle_crc_irq(&acrtc->base);
-
-		if (acrtc_state->stream && adev->family >= AMDGPU_FAMILY_AI &&
-		    acrtc_state->vrr_params.supported &&
-		    acrtc_state->freesync_config.state == VRR_STATE_ACTIVE_VARIABLE) {
-			spin_lock_irqsave(&adev->ddev->event_lock, flags);
-			mod_freesync_handle_v_update(
-				adev->dm.freesync_module,
-				acrtc_state->stream,
-				&acrtc_state->vrr_params);
-
-			dc_stream_adjust_vmin_vmax(
-				adev->dm.dc,
-				acrtc_state->stream,
-				&acrtc_state->vrr_params.adjust);
-			spin_unlock_irqrestore(&adev->ddev->event_lock, flags);
-		}
-	}
-}
-
-#if defined(CONFIG_DRM_AMD_DC_DCN)
-/**
- * dm_dcn_crtc_high_irq() - Handles VStartup interrupt for DCN generation ASICs
- * @interrupt params - interrupt parameters
- *
- * Notify DRM's vblank event handler at VSTARTUP
- *
- * Unlike DCE hardware, we trigger the handler at VSTARTUP. at which:
- * * We are close enough to VUPDATE - the point of no return for hw
- * * We are in the fixed portion of variable front porch when vrr is enabled
- * * We are before VUPDATE, where double-buffered vrr registers are swapped
- *
- * It is therefore the correct place to signal vblank, send user flip events,
- * and update VRR.
- */
-static void dm_dcn_crtc_high_irq(void *interrupt_params)
-{
-	struct common_irq_params *irq_params = interrupt_params;
-	struct amdgpu_device *adev = irq_params->adev;
-	struct amdgpu_crtc *acrtc;
-	struct dm_crtc_state *acrtc_state;
-	unsigned long flags;
-
-	acrtc = get_crtc_by_otg_inst(adev, irq_params->irq_src - IRQ_TYPE_VBLANK);
-
 	if (!acrtc)
 		return;
 
@@ -528,22 +464,35 @@ static void dm_dcn_crtc_high_irq(void *interrupt_params)
 			 amdgpu_dm_vrr_active(acrtc_state),
 			 acrtc_state->active_planes);
 
+	/**
+	 * Core vblank handling at start of front-porch is only possible
+	 * in non-vrr mode, as only there vblank timestamping will give
+	 * valid results while done in front-porch. Otherwise defer it
+	 * to dm_vupdate_high_irq after end of front-porch.
+	 */
+	if (!amdgpu_dm_vrr_active(acrtc_state))
+		drm_crtc_handle_vblank(&acrtc->base);
+
+	/**
+	 * Following stuff must happen at start of vblank, for crc
+	 * computation and below-the-range btr support in vrr mode.
+	 */
 	amdgpu_dm_crtc_handle_crc_irq(&acrtc->base);
-	drm_crtc_handle_vblank(&acrtc->base);
+
+	/* BTR updates need to happen before VUPDATE on Vega and above. */
+	if (adev->family < AMDGPU_FAMILY_AI)
+		return;
 
 	spin_lock_irqsave(&adev->ddev->event_lock, flags);
 
-	if (acrtc_state->vrr_params.supported &&
+	if (acrtc_state->stream && acrtc_state->vrr_params.supported &&
 	    acrtc_state->freesync_config.state == VRR_STATE_ACTIVE_VARIABLE) {
-		mod_freesync_handle_v_update(
-		adev->dm.freesync_module,
-		acrtc_state->stream,
-		&acrtc_state->vrr_params);
+		mod_freesync_handle_v_update(adev->dm.freesync_module,
+					     acrtc_state->stream,
+					     &acrtc_state->vrr_params);
 
-		dc_stream_adjust_vmin_vmax(
-			adev->dm.dc,
-			acrtc_state->stream,
-			&acrtc_state->vrr_params.adjust);
+		dc_stream_adjust_vmin_vmax(adev->dm.dc, acrtc_state->stream,
+					   &acrtc_state->vrr_params.adjust);
 	}
 
 	/*
@@ -556,7 +505,8 @@ static void dm_dcn_crtc_high_irq(void *interrupt_params)
 	 * avoid race conditions between flip programming and completion,
 	 * which could cause too early flip completion events.
 	 */
-	if (acrtc->pflip_status == AMDGPU_FLIP_SUBMITTED &&
+	if (adev->family >= AMDGPU_FAMILY_RV &&
+	    acrtc->pflip_status == AMDGPU_FLIP_SUBMITTED &&
 	    acrtc_state->active_planes == 0) {
 		if (acrtc->event) {
 			drm_crtc_send_vblank_event(&acrtc->base, acrtc->event);
@@ -568,7 +518,6 @@ static void dm_dcn_crtc_high_irq(void *interrupt_params)
 
 	spin_unlock_irqrestore(&adev->ddev->event_lock, flags);
 }
-#endif
 
 static int dm_set_clockgating_state(void *handle,
 		  enum amd_clockgating_state state)
@@ -2454,8 +2403,36 @@ static int dcn10_register_irq_handlers(struct amdgpu_device *adev)
 		c_irq_params->adev = adev;
 		c_irq_params->irq_src = int_params.irq_source;
 
+		amdgpu_dm_irq_register_interrupt(
+			adev, &int_params, dm_crtc_high_irq, c_irq_params);
+	}
+
+	/* Use VUPDATE_NO_LOCK interrupt on DCN, which seems to correspond to
+	 * the regular VUPDATE interrupt on DCE. We want DC_IRQ_SOURCE_VUPDATEx
+	 * to trigger at end of each vblank, regardless of state of the lock,
+	 * matching DCE behaviour.
+	 */
+	for (i = DCN_1_0__SRCID__OTG0_IHC_V_UPDATE_NO_LOCK_INTERRUPT;
+	     i <= DCN_1_0__SRCID__OTG0_IHC_V_UPDATE_NO_LOCK_INTERRUPT + adev->mode_info.num_crtc - 1;
+	     i++) {
+		r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_DCE, i, &adev->vupdate_irq);
+
+		if (r) {
+			DRM_ERROR("Failed to add vupdate irq id!\n");
+			return r;
+		}
+
+		int_params.int_context = INTERRUPT_HIGH_IRQ_CONTEXT;
+		int_params.irq_source =
+			dc_interrupt_to_irq_source(dc, i, 0);
+
+		c_irq_params = &adev->dm.vupdate_params[int_params.irq_source - DC_IRQ_SOURCE_VUPDATE1];
+
+		c_irq_params->adev = adev;
+		c_irq_params->irq_src = int_params.irq_source;
+
 		amdgpu_dm_irq_register_interrupt(adev, &int_params,
-				dm_dcn_crtc_high_irq, c_irq_params);
+				dm_vupdate_high_irq, c_irq_params);
 	}
 
 	/* Use GRPH_PFLIP interrupt */
@@ -4544,10 +4521,6 @@ static inline int dm_set_vupdate_irq(struct drm_crtc *crtc, bool enable)
 	struct amdgpu_device *adev = crtc->dev->dev_private;
 	int rc;
 
-	/* Do not set vupdate for DCN hardware */
-	if (adev->family > AMDGPU_FAMILY_AI)
-		return 0;
-
 	irq_source = IRQ_TYPE_VUPDATE + acrtc->otg_inst;
 
 	rc = dc_interrupt_set(adev->dm.dc, irq_source, enable) ? 0 : -EBUSY;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
