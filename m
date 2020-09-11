Return-Path: <SRS0=U106=CU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B7AFC43461
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2020 16:27:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5E78221EB
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2020 16:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="M8tPzpbG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5E78221EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42E876EAAD;
	Fri, 11 Sep 2020 16:27:21 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 755386EAAD
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2020 16:27:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lOaDS/T/NnWK7ACB7XV369jPQUtpVkCNK4w+eMd5Uc4ETD9jGPbhJbGgCO1E61xtaNdlkks+L6GZoTvS6OKoOHtpegvlz2h7O6x0n3790NwExLxhjxKSpFky6lzBAQvviqf1NOY52ChgmSZxTtvU5hkJUSEAcc5erwY20Amwubf0umnL9f89CgPL6Ugtxbs4pfpJn2iPtQdSYLuLcr5KjQPEgaGw7tIBkaANE7aThBiF9Y9lddsCODOnDKGgsslhH755br27Rf+HLfICCYab1LY10sDDDlm0sw0UDk6G9fjoxV/j0MfBKRjlC5zvKnpRz7AqqdE4mfvcJJMt1WLNeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/wQJP5+yDAvVrXZLndy1Kfv9Ems41KYM5mVxyW6UlDQ=;
 b=aBwWFcO14PPe9S2Yf4oMJZR2JkD+78GU+nHcLMIBA3QvRfmuDP73Neei7TqaISAcU2uZs3fxsO41AbZRAWLbWe80hKzGqXSN6GDx6HKWX4v935ON8nWBt1a4lQG5WkV9JseoVjPvOlZKSGxgyYysAdZUXD6H/STIvcTE9hnG1Ga6QsWYFifWEOt4Th5jZgzXU+Cs+wwSGtNU0tIKltJZAi4htbn+/Z/BnNIX1p6FFQ1zfSQBrHO1UJnvLX3QRIX3JRZQjt0rJyR3qp+hrv2rERmXiFCjiZb/SBH5Ht3uI01hAXpQL6ZPgDwE8bnQtTsPwIBLrb3guVBAuI/s2K9bTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/wQJP5+yDAvVrXZLndy1Kfv9Ems41KYM5mVxyW6UlDQ=;
 b=M8tPzpbGmjoP2SkhfHNmoTS4XsI/yHjUGkrji7LZ/mBu0JdQbk80YTcwwzcGtfHq3MsnA4GAr+KP/bCoBoCRC2AGLDL5GSA5vCd/ynu3XmHQ1ug2OFQC655LyL2JdYrnV1I+kaR0qx4MqSfWIe8JvyPsvEzfhMkzV5PvPg9JdxU=
Received: from DM6PR17CA0026.namprd17.prod.outlook.com (2603:10b6:5:1b3::39)
 by MN2PR12MB3325.namprd12.prod.outlook.com (2603:10b6:208:ce::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Fri, 11 Sep
 2020 16:27:11 +0000
Received: from DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::7) by DM6PR17CA0026.outlook.office365.com
 (2603:10b6:5:1b3::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Fri, 11 Sep 2020 16:27:11 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT027.mail.protection.outlook.com (10.13.172.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3370.16 via Frontend Transport; Fri, 11 Sep 2020 16:27:11 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 11 Sep
 2020 11:27:10 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 11 Sep 2020 11:27:10 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 2/3] drm/amd/display: Refactor to prevent crtc state access
 in DM IRQ handler
Date: Fri, 11 Sep 2020 12:27:08 -0400
Message-ID: <20200911162709.87720-3-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200911162709.87720-1-aurabindo.pillai@amd.com>
References: <20200911162709.87720-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5548cf9-1a62-4a1d-ce85-08d8566f8931
X-MS-TrafficTypeDiagnostic: MN2PR12MB3325:
X-Microsoft-Antispam-PRVS: <MN2PR12MB332546DB3AE04AEA169E63868B240@MN2PR12MB3325.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lIemZLxRTDKjEqrxISkWwmcYvaRNqHdEpVYxCBKR68+52W3FcA1SRGNcoLx2BLSvKMlT0QWHWXx11xV8FHWPKi3pmUwIYMwz8uiSWzJTqWu4obIzdRM0sCEYk/z2R13PYLgdpbqs20KWP7Q2kTLLFoTO/IfMyrTcXyIJY1CS54SHbBxMYN0uGwhBpK49NZExhXveyf9cPF2PW3/Wy3Ocpvi75p+1lx29CZxtVklmASqIvjpr3CPyKzz53ZcknVr3gZRJZXoDOFunZ+sqpT0fdcHDJOIgBO1qD4sX3XZDkLCD0WnZIZFD7lQq4bkIrIplVYNXVZQ5q39W8WTcohtYDnW/hWdIF78ZMbfWKGRPQ68k/Fq+wYm3aBUwbYnm+3VWhQs0NpZY12iUEuxtto7LRQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(376002)(136003)(346002)(46966005)(1076003)(26005)(83380400001)(336012)(7696005)(8676002)(70206006)(44832011)(316002)(47076004)(82740400003)(6916009)(426003)(30864003)(2906002)(70586007)(478600001)(8936002)(82310400003)(5660300002)(356005)(2616005)(4326008)(36756003)(81166007)(186003)(86362001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2020 16:27:11.5176 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5548cf9-1a62-4a1d-ce85-08d8566f8931
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3325
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
Cc: nicholas.kazlauskas@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why&How]
Currently commit_tail holds global locks and wait for dependencies which is
against the DRM API contracts. Inorder to fix this, IRQ handler should be able
to run without having to access crtc state. Required parameters are copied over
so that they can be directly accessed from the interrupt handler

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 111 ++++++++++--------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   1 -
 .../display/amdgpu_dm/amdgpu_dm_irq_params.h  |   4 +
 3 files changed, 64 insertions(+), 52 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 40814cdd8c92..1455acf5beca 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -192,17 +192,14 @@ static u32 dm_vblank_get_counter(struct amdgpu_device *adev, int crtc)
 		return 0;
 	else {
 		struct amdgpu_crtc *acrtc = adev->mode_info.crtcs[crtc];
-		struct dm_crtc_state *acrtc_state = to_dm_crtc_state(
-				acrtc->base.state);
 
-
-		if (acrtc_state->stream == NULL) {
+		if (acrtc->dm_irq_params.stream == NULL) {
 			DRM_ERROR("dc_stream_state is NULL for crtc '%d'!\n",
 				  crtc);
 			return 0;
 		}
 
-		return dc_stream_get_vblank_counter(acrtc_state->stream);
+		return dc_stream_get_vblank_counter(acrtc->dm_irq_params.stream);
 	}
 }
 
@@ -215,10 +212,8 @@ static int dm_crtc_get_scanoutpos(struct amdgpu_device *adev, int crtc,
 		return -EINVAL;
 	else {
 		struct amdgpu_crtc *acrtc = adev->mode_info.crtcs[crtc];
-		struct dm_crtc_state *acrtc_state = to_dm_crtc_state(
-						acrtc->base.state);
 
-		if (acrtc_state->stream ==  NULL) {
+		if (acrtc->dm_irq_params.stream ==  NULL) {
 			DRM_ERROR("dc_stream_state is NULL for crtc '%d'!\n",
 				  crtc);
 			return 0;
@@ -228,7 +223,7 @@ static int dm_crtc_get_scanoutpos(struct amdgpu_device *adev, int crtc,
 		 * TODO rework base driver to use values directly.
 		 * for now parse it back into reg-format
 		 */
-		dc_stream_get_scanoutpos(acrtc_state->stream,
+		dc_stream_get_scanoutpos(acrtc->dm_irq_params.stream,
 					 &v_blank_start,
 					 &v_blank_end,
 					 &h_position,
@@ -287,6 +282,14 @@ get_crtc_by_otg_inst(struct amdgpu_device *adev,
 	return NULL;
 }
 
+static inline bool amdgpu_dm_vrr_active_irq(struct amdgpu_crtc *acrtc)
+{
+	return acrtc->dm_irq_params.freesync_config.state ==
+		       VRR_STATE_ACTIVE_VARIABLE ||
+	       acrtc->dm_irq_params.freesync_config.state ==
+		       VRR_STATE_ACTIVE_FIXED;
+}
+
 static inline bool amdgpu_dm_vrr_active(struct dm_crtc_state *dm_state)
 {
 	return dm_state->freesync_config.state == VRR_STATE_ACTIVE_VARIABLE ||
@@ -307,7 +310,6 @@ static void dm_pflip_high_irq(void *interrupt_params)
 	struct amdgpu_device *adev = irq_params->adev;
 	unsigned long flags;
 	struct drm_pending_vblank_event *e;
-	struct dm_crtc_state *acrtc_state;
 	uint32_t vpos, hpos, v_blank_start, v_blank_end;
 	bool vrr_active;
 
@@ -339,12 +341,11 @@ static void dm_pflip_high_irq(void *interrupt_params)
 	if (!e)
 		WARN_ON(1);
 
-	acrtc_state = to_dm_crtc_state(amdgpu_crtc->base.state);
-	vrr_active = amdgpu_dm_vrr_active(acrtc_state);
+	vrr_active = amdgpu_dm_vrr_active_irq(amdgpu_crtc);
 
 	/* Fixed refresh rate, or VRR scanout position outside front-porch? */
 	if (!vrr_active ||
-	    !dc_stream_get_scanoutpos(acrtc_state->stream, &v_blank_start,
+	    !dc_stream_get_scanoutpos(amdgpu_crtc->dm_irq_params.stream, &v_blank_start,
 				      &v_blank_end, &hpos, &vpos) ||
 	    (vpos < v_blank_start)) {
 		/* Update to correct count and vblank timestamp if racing with
@@ -405,17 +406,17 @@ static void dm_vupdate_high_irq(void *interrupt_params)
 	struct common_irq_params *irq_params = interrupt_params;
 	struct amdgpu_device *adev = irq_params->adev;
 	struct amdgpu_crtc *acrtc;
-	struct dm_crtc_state *acrtc_state;
 	unsigned long flags;
+	int vrr_active;
 
 	acrtc = get_crtc_by_otg_inst(adev, irq_params->irq_src - IRQ_TYPE_VUPDATE);
 
 	if (acrtc) {
-		acrtc_state = to_dm_crtc_state(acrtc->base.state);
+		vrr_active = amdgpu_dm_vrr_active_irq(acrtc);
 
 		DRM_DEBUG_VBL("crtc:%d, vupdate-vrr:%d\n",
 			      acrtc->crtc_id,
-			      amdgpu_dm_vrr_active(acrtc_state));
+			      vrr_active);
 
 		/* Core vblank handling is done here after end of front-porch in
 		 * vrr mode, as vblank timestamping will give valid results
@@ -423,22 +424,22 @@ static void dm_vupdate_high_irq(void *interrupt_params)
 		 * page-flip completion events that have been queued to us
 		 * if a pageflip happened inside front-porch.
 		 */
-		if (amdgpu_dm_vrr_active(acrtc_state)) {
+		if (vrr_active) {
 			drm_crtc_handle_vblank(&acrtc->base);
 
 			/* BTR processing for pre-DCE12 ASICs */
-			if (acrtc_state->stream &&
+			if (acrtc->dm_irq_params.stream &&
 			    adev->family < AMDGPU_FAMILY_AI) {
 				spin_lock_irqsave(&adev_to_drm(adev)->event_lock, flags);
 				mod_freesync_handle_v_update(
 				    adev->dm.freesync_module,
-				    acrtc_state->stream,
-				    &acrtc_state->vrr_params);
+				    acrtc->dm_irq_params.stream,
+				    &acrtc->dm_irq_params.vrr_params);
 
 				dc_stream_adjust_vmin_vmax(
 				    adev->dm.dc,
-				    acrtc_state->stream,
-				    &acrtc_state->vrr_params.adjust);
+				    acrtc->dm_irq_params.stream,
+				    &acrtc->dm_irq_params.vrr_params.adjust);
 				spin_unlock_irqrestore(&adev_to_drm(adev)->event_lock, flags);
 			}
 		}
@@ -457,18 +458,17 @@ static void dm_crtc_high_irq(void *interrupt_params)
 	struct common_irq_params *irq_params = interrupt_params;
 	struct amdgpu_device *adev = irq_params->adev;
 	struct amdgpu_crtc *acrtc;
-	struct dm_crtc_state *acrtc_state;
 	unsigned long flags;
+	int vrr_active;
 
 	acrtc = get_crtc_by_otg_inst(adev, irq_params->irq_src - IRQ_TYPE_VBLANK);
 	if (!acrtc)
 		return;
 
-	acrtc_state = to_dm_crtc_state(acrtc->base.state);
+	vrr_active = amdgpu_dm_vrr_active_irq(acrtc);
 
 	DRM_DEBUG_VBL("crtc:%d, vupdate-vrr:%d, planes:%d\n", acrtc->crtc_id,
-			 amdgpu_dm_vrr_active(acrtc_state),
-			 acrtc_state->active_planes);
+		      vrr_active, acrtc->dm_irq_params.active_planes);
 
 	/**
 	 * Core vblank handling at start of front-porch is only possible
@@ -476,7 +476,7 @@ static void dm_crtc_high_irq(void *interrupt_params)
 	 * valid results while done in front-porch. Otherwise defer it
 	 * to dm_vupdate_high_irq after end of front-porch.
 	 */
-	if (!amdgpu_dm_vrr_active(acrtc_state))
+	if (!vrr_active)
 		drm_crtc_handle_vblank(&acrtc->base);
 
 	/**
@@ -491,14 +491,16 @@ static void dm_crtc_high_irq(void *interrupt_params)
 
 	spin_lock_irqsave(&adev_to_drm(adev)->event_lock, flags);
 
-	if (acrtc_state->stream && acrtc_state->vrr_params.supported &&
-	    acrtc_state->freesync_config.state == VRR_STATE_ACTIVE_VARIABLE) {
+	if (acrtc->dm_irq_params.stream &&
+	    acrtc->dm_irq_params.vrr_params.supported &&
+	    acrtc->dm_irq_params.freesync_config.state ==
+		    VRR_STATE_ACTIVE_VARIABLE) {
 		mod_freesync_handle_v_update(adev->dm.freesync_module,
-					     acrtc_state->stream,
-					     &acrtc_state->vrr_params);
+					     acrtc->dm_irq_params.stream,
+					     &acrtc->dm_irq_params.vrr_params);
 
-		dc_stream_adjust_vmin_vmax(adev->dm.dc, acrtc_state->stream,
-					   &acrtc_state->vrr_params.adjust);
+		dc_stream_adjust_vmin_vmax(adev->dm.dc, acrtc->dm_irq_params.stream,
+					   &acrtc->dm_irq_params.vrr_params.adjust);
 	}
 
 	/*
@@ -513,7 +515,7 @@ static void dm_crtc_high_irq(void *interrupt_params)
 	 */
 	if (adev->family >= AMDGPU_FAMILY_RV &&
 	    acrtc->pflip_status == AMDGPU_FLIP_SUBMITTED &&
-	    acrtc_state->active_planes == 0) {
+	    acrtc->dm_irq_params.active_planes == 0) {
 		if (acrtc->event) {
 			drm_crtc_send_vblank_event(&acrtc->base, acrtc->event);
 			acrtc->event = NULL;
@@ -4845,7 +4847,6 @@ dm_crtc_duplicate_state(struct drm_crtc *crtc)
 	}
 
 	state->active_planes = cur->active_planes;
-	state->vrr_params = cur->vrr_params;
 	state->vrr_infopacket = cur->vrr_infopacket;
 	state->abm_level = cur->abm_level;
 	state->vrr_supported = cur->vrr_supported;
@@ -6913,6 +6914,7 @@ static void update_freesync_state_on_stream(
 	struct mod_vrr_params vrr_params;
 	struct dc_info_packet vrr_infopacket = {0};
 	struct amdgpu_device *adev = dm->adev;
+	struct amdgpu_crtc *acrtc = to_amdgpu_crtc(new_crtc_state->base.crtc);
 	unsigned long flags;
 
 	if (!new_stream)
@@ -6927,7 +6929,7 @@ static void update_freesync_state_on_stream(
 		return;
 
 	spin_lock_irqsave(&adev_to_drm(adev)->event_lock, flags);
-	vrr_params = new_crtc_state->vrr_params;
+        vrr_params = acrtc->dm_irq_params.vrr_params;
 
 	if (surface) {
 		mod_freesync_handle_preflip(
@@ -6958,7 +6960,7 @@ static void update_freesync_state_on_stream(
 		&vrr_infopacket);
 
 	new_crtc_state->freesync_timing_changed |=
-		(memcmp(&new_crtc_state->vrr_params.adjust,
+		(memcmp(&acrtc->dm_irq_params.vrr_params.adjust,
 			&vrr_params.adjust,
 			sizeof(vrr_params.adjust)) != 0);
 
@@ -6967,10 +6969,10 @@ static void update_freesync_state_on_stream(
 			&vrr_infopacket,
 			sizeof(vrr_infopacket)) != 0);
 
-	new_crtc_state->vrr_params = vrr_params;
+	acrtc->dm_irq_params.vrr_params = vrr_params;
 	new_crtc_state->vrr_infopacket = vrr_infopacket;
 
-	new_stream->adjust = new_crtc_state->vrr_params.adjust;
+	new_stream->adjust = acrtc->dm_irq_params.vrr_params.adjust;
 	new_stream->vrr_infopacket = vrr_infopacket;
 
 	if (new_crtc_state->freesync_vrr_info_changed)
@@ -6982,7 +6984,7 @@ static void update_freesync_state_on_stream(
 	spin_unlock_irqrestore(&adev_to_drm(adev)->event_lock, flags);
 }
 
-static void pre_update_freesync_state_on_stream(
+static void update_stream_irq_parameters(
 	struct amdgpu_display_manager *dm,
 	struct dm_crtc_state *new_crtc_state)
 {
@@ -6990,6 +6992,7 @@ static void pre_update_freesync_state_on_stream(
 	struct mod_vrr_params vrr_params;
 	struct mod_freesync_config config = new_crtc_state->freesync_config;
 	struct amdgpu_device *adev = dm->adev;
+	struct amdgpu_crtc *acrtc = to_amdgpu_crtc(new_crtc_state->base.crtc);
 	unsigned long flags;
 
 	if (!new_stream)
@@ -7003,7 +7006,7 @@ static void pre_update_freesync_state_on_stream(
 		return;
 
 	spin_lock_irqsave(&adev_to_drm(adev)->event_lock, flags);
-	vrr_params = new_crtc_state->vrr_params;
+	vrr_params = acrtc->dm_irq_params.vrr_params;
 
 	if (new_crtc_state->vrr_supported &&
 	    config.min_refresh_in_uhz &&
@@ -7020,11 +7023,14 @@ static void pre_update_freesync_state_on_stream(
 				      &config, &vrr_params);
 
 	new_crtc_state->freesync_timing_changed |=
-		(memcmp(&new_crtc_state->vrr_params.adjust,
-			&vrr_params.adjust,
-			sizeof(vrr_params.adjust)) != 0);
+		(memcmp(&acrtc->dm_irq_params.vrr_params.adjust,
+			&vrr_params.adjust, sizeof(vrr_params.adjust)) != 0);
 
-	new_crtc_state->vrr_params = vrr_params;
+	new_crtc_state->freesync_config = config;
+	/* Copy state for access from DM IRQ handler */
+	acrtc->dm_irq_params.freesync_config = config;
+	acrtc->dm_irq_params.active_planes = new_crtc_state->active_planes;
+	acrtc->dm_irq_params.vrr_params = vrr_params;
 	spin_unlock_irqrestore(&adev_to_drm(adev)->event_lock, flags);
 }
 
@@ -7332,7 +7338,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 			spin_lock_irqsave(&pcrtc->dev->event_lock, flags);
 			dc_stream_adjust_vmin_vmax(
 				dm->dc, acrtc_state->stream,
-				&acrtc_state->vrr_params.adjust);
+				&acrtc_attach->dm_irq_params.vrr_params.adjust);
 			spin_unlock_irqrestore(&pcrtc->dev->event_lock, flags);
 		}
 		mutex_lock(&dm->dc_lock);
@@ -7545,6 +7551,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 	struct dm_crtc_state *dm_old_crtc_state, *dm_new_crtc_state;
 	int crtc_disable_count = 0;
 	bool mode_set_reset_required = false;
+	struct amdgpu_crtc *acrtc;
 
 	drm_atomic_helper_update_legacy_modeset_state(dev, state);
 
@@ -7654,7 +7661,6 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 			if (!status)
 				status = dc_stream_get_status_from_state(dc_state,
 									 dm_new_crtc_state->stream);
-
 			if (!status)
 				DC_ERR("got no status for stream %p on acrtc%p\n", dm_new_crtc_state->stream, acrtc);
 			else
@@ -7780,8 +7786,8 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 		dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
 		dm_old_crtc_state = to_dm_crtc_state(old_crtc_state);
 
-		/* Update freesync active state. */
-		pre_update_freesync_state_on_stream(dm, dm_new_crtc_state);
+		/* For freesync config update on crtc state and params for irq */
+		update_stream_irq_parameters(dm, dm_new_crtc_state);
 
 		/* Handle vrr on->off / off->on transitions */
 		amdgpu_dm_handle_vrr_transition(dm_old_crtc_state,
@@ -7797,10 +7803,15 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state, new_crtc_state, i) {
 		struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
 
+		dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
+
 		if (new_crtc_state->active &&
 		    (!old_crtc_state->active ||
 		     drm_atomic_crtc_needs_modeset(new_crtc_state))) {
+			dc_stream_retain(dm_new_crtc_state->stream);
+			acrtc->dm_irq_params.stream = dm_new_crtc_state->stream;
 			manage_dm_interrupts(adev, acrtc, true);
+
 #ifdef CONFIG_DEBUG_FS
 			/**
 			 * Frontend may have changed so reapply the CRC capture
@@ -8044,8 +8055,6 @@ static void reset_freesync_config_for_crtc(
 {
 	new_crtc_state->vrr_supported = false;
 
-	memset(&new_crtc_state->vrr_params, 0,
-	       sizeof(new_crtc_state->vrr_params));
 	memset(&new_crtc_state->vrr_infopacket, 0,
 	       sizeof(new_crtc_state->vrr_infopacket));
 }
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 4da7cd065ba0..6d4a751a389f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -434,7 +434,6 @@ struct dm_crtc_state {
 
 	bool vrr_supported;
 	struct mod_freesync_config freesync_config;
-	struct mod_vrr_params vrr_params;
 	struct dc_info_packet vrr_infopacket;
 
 	int abm_level;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq_params.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq_params.h
index 55ef237eed8b..45825a34f8eb 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq_params.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq_params.h
@@ -28,6 +28,10 @@
 
 struct dm_irq_params {
 	u32 last_flip_vblank;
+	struct mod_vrr_params vrr_params;
+	struct dc_stream_state *stream;
+	int active_planes;
+	struct mod_freesync_config freesync_config;
 };
 
 #endif /* __AMDGPU_DM_IRQ_PARAMS_H__ */
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
