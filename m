Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 971AAC4167B
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Dec 2022 16:37:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CE8710E558;
	Fri,  9 Dec 2022 16:37:31 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2083.outbound.protection.outlook.com [40.107.96.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB33A10E558
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Dec 2022 16:37:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b90IUsxBWFxw72fR+IeD8jvr6s8o89ZXiuQyNLivUJrGk9LBE7FSAKeXMUdEI2t8FPzLQ3tpl87nDNMV57qQU+9THV+KPUvVSCTsxPHjI8xVQdzQY29HD8iMUehmb9VYOI3cldYRSQfAuwt1bkl7FNUzWg/F+Ek+vKEo5cXg5LNr4oBtilznqtkU6hT5UTM+Ezx/ZNsdXd3OPLL5g46L5NM+bDXL2Z7OYyf0/gim0as0k4yWDmyEii/hGSqyxTZcp0FLhf8LKS8hgrCBLHwcEPG+ZJiKTq3TVZ30bGG8FFNnMJQCRIPnUIwsBBcdB8Ik6/EWLgQVxxlvfU4zqgLQ5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pTeHbnzh32xhVC/YbflY8ASEp8fZNZS3xyNL1XphmBc=;
 b=Wc6h7E6BOy/uu5GHamkkMacu91wmu9f/3lhNpWTNoM7SDDN1J06Faa5nCiyvd/Rj7Gd36+UpgUHM6vUFGRNZpJZCl21R42XWBMslXyrhPWDUQLTnLHEqI/05ETZEtIkMNeGeLzFp1l/pTb/weIq6FS1tQLVx6rIpVA3dHFxCvh5HkZBM3Xe2SF8oXDifyKZuWP2oi3LiOxMCys4oEb41cQUNdoYqnbHBzyawZUlTYCgohhNNWxRwviYybGL5JDab1dMMPl02hOVPBqcfJLLPK47MlhMk679pDje0yIUJtk4f5m8ReEqgRYcM8gUz+LmF/D7CbIwGLZq+tBTax3lMFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pTeHbnzh32xhVC/YbflY8ASEp8fZNZS3xyNL1XphmBc=;
 b=eufnF5qtYRMgcB3LpxdPiSQ0YGlUeIAv63uHdR2iftBU8iGcekS8KlUV9JUGBQ6N7fVYkJ5jVoYxo7P6mq8+txJwr9sJvxmE5lCXINmPbrwDj/u+RW0J1KnorvOzQj/h24g0GIT9KJMXlQ1/ZNufEfH9jlFor2SL2GVZjkmsv9s=
Received: from MW4PR04CA0107.namprd04.prod.outlook.com (2603:10b6:303:83::22)
 by CY5PR12MB6527.namprd12.prod.outlook.com (2603:10b6:930:30::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Fri, 9 Dec
 2022 16:37:21 +0000
Received: from CO1NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::c9) by MW4PR04CA0107.outlook.office365.com
 (2603:10b6:303:83::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.18 via Frontend
 Transport; Fri, 9 Dec 2022 16:37:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT025.mail.protection.outlook.com (10.13.175.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.17 via Frontend Transport; Fri, 9 Dec 2022 16:37:20 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 9 Dec 2022 10:37:17 -0600
From: jdhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/23] drm/amd/display: Implement multiple secure display
Date: Fri, 9 Dec 2022 11:36:27 -0500
Message-ID: <20221209163647.25704-4-jdhillon@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221209163647.25704-1-jdhillon@amd.com>
References: <20221209163647.25704-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT025:EE_|CY5PR12MB6527:EE_
X-MS-Office365-Filtering-Correlation-Id: 4023050c-16c2-4bad-a0f5-08dada03a4a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qMK1K+PHF3mYNia165rj7j0EE715aa+owGnf9dQ9Pt1wykmyjm5NZda1sB10rY2bT+992sR46KnBCn9lx5vQBZPwBKWzPXAT3gLJ2qMSUlVLHizl7ZhCYhCwFBLcCOze8dhkuAgEfLP/5oXFGTNA8Pi1IvycU1TMvXh3Bg4/VRfxiGPpILbNbe5a+0ExFcD8pmB2fkthIdtCgG+sUXPdxV+UpDhXpmocGXmb7NYVQQ3BK3xU+vKFqFllWExUtoz7xkLSGLNAU2iHu+3eqX/ZgSyJDCqPp3S5HnR4SKXB0oeOLj1vo0Nz9u3iYchIMSnQw+fY0AcL+5PNhDHiR5Hb47ZFGMJeoh+/VkjKtqmToCk5iCbdDPcmO6LbIVqrmPDPd+XiP/NPDolrgK68HEbQisdxXKuurewij9lBTzDcs2eUKU0rwB1ZlyTj5wR8c4rn8ywrd+1CJrRQcLRuAUOMUth1HkN/tsk8oK2XVw8dL+G59MD5cP5vnayRvgGCC6TTnf2Rhir/Fo10SxwAgHaTs/HgPB+RQG3B665UbHxEiaqd8agOJobH2E2z3SMgfOU4Mkso56Ij7FVpD7C8bcFJHgHQNKFDPKZKZHgnmSRHxihun9ImhW69fKV9s50fn8vb+GZoeIOhGAFdLJT5yTXKMGtmLVX6CqQ1JPeTANJFlmvGIkFal6yGUPbd+i7ZBdfWLD8uxTLWE61V53ZFBYzrk+plTz5LkZ2N7L4WpOuu3YY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(396003)(346002)(376002)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(36756003)(2906002)(5660300002)(82740400003)(30864003)(356005)(47076005)(1076003)(2616005)(186003)(83380400001)(336012)(316002)(426003)(36860700001)(81166007)(16526019)(40460700003)(54906003)(4326008)(40480700001)(26005)(41300700001)(70206006)(6666004)(70586007)(6916009)(478600001)(82310400005)(8676002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 16:37:20.6949 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4023050c-16c2-4bad-a0f5-08dada03a4a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6527
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Jasdeep Dhillon <jdhillon@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Wayne Lin <Wayne.Lin@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alan Liu <HaoPing.Liu@amd.com>

[Why]
Current secure display only work with single display, now make it
work with multiple displays.

[How]
Create secure_display_context for each crtc instance to store its
own Region of Interest (ROI) information.

Reviewed-by: Wayne Lin <Wayne.Lin@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Alan Liu <HaoPing.Liu@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  29 ++--
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   7 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c | 150 +++++++++---------
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h |  25 ++-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |  38 +----
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   5 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   3 +-
 7 files changed, 116 insertions(+), 141 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 0f391a147354..4c2a99fbcd70 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1642,7 +1642,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	}
 #endif
 #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
-	adev->dm.crc_rd_wrk = amdgpu_dm_crtc_secure_display_create_work();
+	adev->dm.secure_display_ctxs = amdgpu_dm_crtc_secure_display_create_contexts(adev->dm.dc->caps.max_links);
 #endif
 	if (dc_is_dmub_outbox_supported(adev->dm.dc)) {
 		init_completion(&adev->dm.dmub_aux_transfer_done);
@@ -1737,10 +1737,15 @@ static void amdgpu_dm_fini(struct amdgpu_device *adev)
 	amdgpu_dm_destroy_drm_device(&adev->dm);
 
 #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
-	if (adev->dm.crc_rd_wrk) {
-		flush_work(&adev->dm.crc_rd_wrk->notify_ta_work);
-		kfree(adev->dm.crc_rd_wrk);
-		adev->dm.crc_rd_wrk = NULL;
+	if (adev->dm.secure_display_ctxs) {
+		for (i = 0; i < adev->dm.dc->caps.max_links; i++) {
+			if (adev->dm.secure_display_ctxs[i].crtc) {
+				flush_work(&adev->dm.secure_display_ctxs[i].notify_ta_work);
+				flush_work(&adev->dm.secure_display_ctxs[i].forward_roi_work);
+			}
+		}
+		kfree(adev->dm.secure_display_ctxs);
+		adev->dm.secure_display_ctxs = NULL;
 	}
 #endif
 #ifdef CONFIG_DRM_AMD_DC_HDCP
@@ -8409,9 +8414,6 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 		struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
 #ifdef CONFIG_DEBUG_FS
 		enum amdgpu_dm_pipe_crc_source cur_crc_src;
-#if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
-		struct crc_rd_work *crc_rd_wrk;
-#endif
 #endif
 		/* Count number of newly disabled CRTCs for dropping PM refs later. */
 		if (old_crtc_state->active && !new_crtc_state->active)
@@ -8424,9 +8426,6 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 		update_stream_irq_parameters(dm, dm_new_crtc_state);
 
 #ifdef CONFIG_DEBUG_FS
-#if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
-		crc_rd_wrk = dm->crc_rd_wrk;
-#endif
 		spin_lock_irqsave(&adev_to_drm(adev)->event_lock, flags);
 		cur_crc_src = acrtc->dm_irq_params.crc_src;
 		spin_unlock_irqrestore(&adev_to_drm(adev)->event_lock, flags);
@@ -8455,10 +8454,12 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 				if (amdgpu_dm_crc_window_is_activated(crtc)) {
 					spin_lock_irqsave(&adev_to_drm(adev)->event_lock, flags);
 					acrtc->dm_irq_params.window_param.update_win = true;
+
+					/**
+					 * It takes 2 frames for HW to stably generate CRC when
+					 * resuming from suspend, so we set skip_frame_cnt 2.
+					 */
 					acrtc->dm_irq_params.window_param.skip_frame_cnt = 2;
-					spin_lock_irq(&crc_rd_wrk->crc_rd_work_lock);
-					crc_rd_wrk->crtc = crtc;
-					spin_unlock_irq(&crc_rd_wrk->crc_rd_work_lock);
 					spin_unlock_irqrestore(&adev_to_drm(adev)->event_lock, flags);
 				}
 #endif
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index df3c25e32c65..abbbb3813c1e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -494,11 +494,12 @@ struct amdgpu_display_manager {
 
 #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
 	/**
-	 * @crc_rd_wrk:
+	 * @secure_display_ctxs:
 	 *
-	 * Work to be executed in a separate thread to communicate with PSP.
+	 * Store the ROI information and the work_struct to command dmub and psp for
+	 * all crtcs.
 	 */
-	struct crc_rd_work *crc_rd_wrk;
+	struct secure_display_context *secure_display_ctxs;
 #endif
 	/**
 	 * @hpd_rx_offload_wq:
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
index 66df2394d7e4..6453abcf5f4b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
@@ -101,35 +101,38 @@ static void amdgpu_dm_set_crc_window_default(struct drm_crtc *crtc)
 
 static void amdgpu_dm_crtc_notify_ta_to_read(struct work_struct *work)
 {
-	struct crc_rd_work *crc_rd_wrk;
-	struct amdgpu_device *adev;
+	struct secure_display_context *secure_display_ctx;
 	struct psp_context *psp;
 	struct securedisplay_cmd *securedisplay_cmd;
 	struct drm_crtc *crtc;
-	uint8_t phy_id;
+	struct dc_stream_state *stream;
+	uint8_t phy_inst;
 	int ret;
 
-	crc_rd_wrk = container_of(work, struct crc_rd_work, notify_ta_work);
-	spin_lock_irq(&crc_rd_wrk->crc_rd_work_lock);
-	crtc = crc_rd_wrk->crtc;
+	secure_display_ctx = container_of(work, struct secure_display_context, notify_ta_work);
+	crtc = secure_display_ctx->crtc;
 
 	if (!crtc) {
-		spin_unlock_irq(&crc_rd_wrk->crc_rd_work_lock);
 		return;
 	}
 
-	adev = drm_to_adev(crtc->dev);
-	psp = &adev->psp;
-	phy_id = crc_rd_wrk->phy_inst;
-	spin_unlock_irq(&crc_rd_wrk->crc_rd_work_lock);
+	psp = &drm_to_adev(crtc->dev)->psp;
+	stream = to_amdgpu_crtc(crtc)->dm_irq_params.stream;
+	phy_inst = stream->link->link_enc_hw_inst;
 
+	/* need lock for multiple crtcs to use the command buffer */
 	mutex_lock(&psp->securedisplay_context.mutex);
 
 	psp_prep_securedisplay_cmd_buf(psp, &securedisplay_cmd,
 						TA_SECUREDISPLAY_COMMAND__SEND_ROI_CRC);
-	securedisplay_cmd->securedisplay_in_message.send_roi_crc.phy_id =
-						phy_id;
+
+	securedisplay_cmd->securedisplay_in_message.send_roi_crc.phy_id = phy_inst;
+
+	/* PSP TA is expected to finish data transmission over I2C within current frame,
+	 * even there are up to 4 crtcs request to send in this frame.
+	 */
 	ret = psp_securedisplay_invoke(psp, TA_SECUREDISPLAY_COMMAND__SEND_ROI_CRC);
+
 	if (!ret) {
 		if (securedisplay_cmd->status != TA_SECUREDISPLAY_STATUS__SUCCESS) {
 			psp_securedisplay_parse_resp_status(psp, securedisplay_cmd->status);
@@ -142,17 +145,23 @@ static void amdgpu_dm_crtc_notify_ta_to_read(struct work_struct *work)
 static void
 amdgpu_dm_forward_crc_window(struct work_struct *work)
 {
-	struct crc_fw_work *crc_fw_wrk;
+	struct secure_display_context *secure_display_ctx;
 	struct amdgpu_display_manager *dm;
+	struct drm_crtc *crtc;
+	struct dc_stream_state *stream;
 
-	crc_fw_wrk = container_of(work, struct crc_fw_work, forward_roi_work);
-	dm = crc_fw_wrk->dm;
+	secure_display_ctx = container_of(work, struct secure_display_context, forward_roi_work);
+	crtc = secure_display_ctx->crtc;
+
+	if (!crtc)
+		return;
+
+	dm = &drm_to_adev(crtc->dev)->dm;
+	stream = to_amdgpu_crtc(crtc)->dm_irq_params.stream;
 
 	mutex_lock(&dm->dc_lock);
-	dc_stream_forward_crc_window(dm->dc, &crc_fw_wrk->rect, crc_fw_wrk->stream, crc_fw_wrk->is_stop_cmd);
+	dc_stream_forward_crc_window(stream, &secure_display_ctx->rect, false);
 	mutex_unlock(&dm->dc_lock);
-
-	kfree(crc_fw_wrk);
 }
 
 bool amdgpu_dm_crc_window_is_activated(struct drm_crtc *crtc)
@@ -192,7 +201,7 @@ int amdgpu_dm_crtc_configure_crc_source(struct drm_crtc *crtc,
 	struct amdgpu_device *adev = drm_to_adev(crtc->dev);
 	struct dc_stream_state *stream_state = dm_crtc_state->stream;
 	bool enable = amdgpu_dm_is_valid_crc_source(source);
-	int ret = 0;
+	int i, ret = 0;
 
 	/* Configuration will be deferred to stream enable. */
 	if (!stream_state)
@@ -200,21 +209,20 @@ int amdgpu_dm_crtc_configure_crc_source(struct drm_crtc *crtc,
 
 	mutex_lock(&adev->dm.dc_lock);
 
-	/* Enable CRTC CRC generation if necessary. */
+	/* Enable or disable CRTC CRC generation */
 	if (dm_is_crc_source_crtc(source) || source == AMDGPU_DM_PIPE_CRC_SOURCE_NONE) {
 #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
+		/* Disable secure_display if it was enabled */
 		if (!enable) {
-			if (adev->dm.crc_rd_wrk) {
-				flush_work(&adev->dm.crc_rd_wrk->notify_ta_work);
-				spin_lock_irq(&adev->dm.crc_rd_wrk->crc_rd_work_lock);
-
-				if (adev->dm.crc_rd_wrk->crtc == crtc) {
-					/* stop ROI update on this crtc */
-					dc_stream_forward_crc_window(stream_state->ctx->dc,
-							NULL, stream_state, true);
-					adev->dm.crc_rd_wrk->crtc = NULL;
+			if (adev->dm.secure_display_ctxs) {
+				for (i = 0; i < adev->mode_info.num_crtc; i++) {
+					if (adev->dm.secure_display_ctxs[i].crtc == crtc) {
+						/* stop ROI update on this crtc */
+						flush_work(&adev->dm.secure_display_ctxs[i].notify_ta_work);
+						dc_stream_forward_crc_window(stream_state, NULL, true);
+						adev->dm.secure_display_ctxs[i].crtc = NULL;
+					}
 				}
-				spin_unlock_irq(&adev->dm.crc_rd_wrk->crc_rd_work_lock);
 			}
 		}
 #endif
@@ -347,6 +355,7 @@ int amdgpu_dm_crtc_set_crc_source(struct drm_crtc *crtc, const char *src_name)
 	}
 
 #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
+	/* Reset secure_display when we change crc source from debugfs */
 	amdgpu_dm_set_crc_window_default(crtc);
 #endif
 
@@ -456,14 +465,12 @@ void amdgpu_dm_crtc_handle_crc_irq(struct drm_crtc *crtc)
 #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
 void amdgpu_dm_crtc_handle_crc_window_irq(struct drm_crtc *crtc)
 {
-	struct dc_stream_state *stream_state;
 	struct drm_device *drm_dev = NULL;
 	enum amdgpu_dm_pipe_crc_source cur_crc_src;
 	struct amdgpu_crtc *acrtc = NULL;
 	struct amdgpu_device *adev = NULL;
-	struct crc_rd_work *crc_rd_wrk;
-	struct crc_fw_work *crc_fw_wrk;
-	unsigned long flags1, flags2;
+	struct secure_display_context *secure_display_ctx = NULL;
+	unsigned long flags1;
 
 	if (crtc == NULL)
 		return;
@@ -473,75 +480,68 @@ void amdgpu_dm_crtc_handle_crc_window_irq(struct drm_crtc *crtc)
 	drm_dev = crtc->dev;
 
 	spin_lock_irqsave(&drm_dev->event_lock, flags1);
-	stream_state = acrtc->dm_irq_params.stream;
 	cur_crc_src = acrtc->dm_irq_params.crc_src;
 
 	/* Early return if CRC capture is not enabled. */
-	if (!amdgpu_dm_is_valid_crc_source(cur_crc_src))
+	if (!amdgpu_dm_is_valid_crc_source(cur_crc_src) ||
+		!dm_is_crc_source_crtc(cur_crc_src))
 		goto cleanup;
 
-	if (!dm_is_crc_source_crtc(cur_crc_src))
+	if (!acrtc->dm_irq_params.window_param.activated)
 		goto cleanup;
 
-	if (!acrtc->dm_irq_params.window_param.activated)
+	if (acrtc->dm_irq_params.window_param.skip_frame_cnt) {
+		acrtc->dm_irq_params.window_param.skip_frame_cnt -= 1;
 		goto cleanup;
+	}
 
-	if (acrtc->dm_irq_params.window_param.update_win) {
-		if (acrtc->dm_irq_params.window_param.skip_frame_cnt) {
-			acrtc->dm_irq_params.window_param.skip_frame_cnt -= 1;
-			goto cleanup;
-		}
+	secure_display_ctx = &adev->dm.secure_display_ctxs[acrtc->crtc_id];
+	secure_display_ctx->crtc = crtc;
 
+	if (acrtc->dm_irq_params.window_param.update_win) {
 		/* prepare work for dmub to update ROI */
-		crc_fw_wrk = kzalloc(sizeof(*crc_fw_wrk), GFP_ATOMIC);
-		if (!crc_fw_wrk)
-			goto cleanup;
-
-		INIT_WORK(&crc_fw_wrk->forward_roi_work, amdgpu_dm_forward_crc_window);
-		crc_fw_wrk->dm = &adev->dm;
-		crc_fw_wrk->stream = stream_state;
-		crc_fw_wrk->rect.x = acrtc->dm_irq_params.window_param.x_start;
-		crc_fw_wrk->rect.y = acrtc->dm_irq_params.window_param.y_start;
-		crc_fw_wrk->rect.width = acrtc->dm_irq_params.window_param.x_end -
+		secure_display_ctx->rect.x = acrtc->dm_irq_params.window_param.x_start;
+		secure_display_ctx->rect.y = acrtc->dm_irq_params.window_param.y_start;
+		secure_display_ctx->rect.width = acrtc->dm_irq_params.window_param.x_end -
 								acrtc->dm_irq_params.window_param.x_start;
-		crc_fw_wrk->rect.height = acrtc->dm_irq_params.window_param.y_end -
+		secure_display_ctx->rect.height = acrtc->dm_irq_params.window_param.y_end -
 								acrtc->dm_irq_params.window_param.y_start;
-		schedule_work(&crc_fw_wrk->forward_roi_work);
+		schedule_work(&secure_display_ctx->forward_roi_work);
 
 		acrtc->dm_irq_params.window_param.update_win = false;
+
+		/* Statically skip 1 frame, because we may need to wait below things
+		 * before sending ROI to dmub:
+		 * 1. We defer the work by using system workqueue.
+		 * 2. We may need to wait for dc_lock before accessing dmub.
+		 */
 		acrtc->dm_irq_params.window_param.skip_frame_cnt = 1;
 
 	} else {
-		if (acrtc->dm_irq_params.window_param.skip_frame_cnt) {
-			acrtc->dm_irq_params.window_param.skip_frame_cnt -= 1;
-			goto cleanup;
-		}
-
-		if (adev->dm.crc_rd_wrk) {
-			crc_rd_wrk = adev->dm.crc_rd_wrk;
-			spin_lock_irqsave(&crc_rd_wrk->crc_rd_work_lock, flags2);
-			crc_rd_wrk->phy_inst = stream_state->link->link_enc_hw_inst;
-			spin_unlock_irqrestore(&crc_rd_wrk->crc_rd_work_lock, flags2);
-			schedule_work(&crc_rd_wrk->notify_ta_work);
-		}
+		/* prepare work for psp to read ROI/CRC and send to I2C */
+		schedule_work(&secure_display_ctx->notify_ta_work);
 	}
 
 cleanup:
 	spin_unlock_irqrestore(&drm_dev->event_lock, flags1);
 }
 
-struct crc_rd_work *amdgpu_dm_crtc_secure_display_create_work(void)
+struct secure_display_context *
+amdgpu_dm_crtc_secure_display_create_contexts(int num_crtc)
 {
-	struct crc_rd_work *crc_rd_wrk = NULL;
+	struct secure_display_context *secure_display_ctxs = NULL;
+	int i;
 
-	crc_rd_wrk = kzalloc(sizeof(*crc_rd_wrk), GFP_KERNEL);
+	secure_display_ctxs = kcalloc(num_crtc, sizeof(struct secure_display_context), GFP_KERNEL);
 
-	if (!crc_rd_wrk)
+	if (!secure_display_ctxs)
 		return NULL;
 
-	spin_lock_init(&crc_rd_wrk->crc_rd_work_lock);
-	INIT_WORK(&crc_rd_wrk->notify_ta_work, amdgpu_dm_crtc_notify_ta_to_read);
+	for (i = 0; i < num_crtc; i++) {
+		INIT_WORK(&secure_display_ctxs[i].forward_roi_work, amdgpu_dm_forward_crc_window);
+		INIT_WORK(&secure_display_ctxs[i].notify_ta_work, amdgpu_dm_crtc_notify_ta_to_read);
+	}
 
-	return crc_rd_wrk;
+	return secure_display_ctxs;
 }
 #endif
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h
index 71bce608d751..4323f723c0de 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h
@@ -45,7 +45,7 @@ struct crc_window_param {
 	uint16_t y_start;
 	uint16_t x_end;
 	uint16_t y_end;
-	/* CRC windwo is activated or not*/
+	/* CRC window is activated or not*/
 	bool activated;
 	/* Update crc window during vertical blank or not */
 	bool update_win;
@@ -53,22 +53,17 @@ struct crc_window_param {
 	int skip_frame_cnt;
 };
 
-/* read_work for driver to call PSP to read */
-struct crc_rd_work {
+struct secure_display_context {
+	/* work to notify PSP TA to transmit CRC over I2C */
 	struct work_struct notify_ta_work;
-	/* To protect crc_rd_work carried fields*/
-	spinlock_t crc_rd_work_lock;
-	struct drm_crtc *crtc;
-	uint8_t phy_inst;
-};
 
-/* forward_work for driver to forward ROI to dmu */
-struct crc_fw_work {
+	/* work to forward ROI to dmcu/dmub */
 	struct work_struct forward_roi_work;
-	struct amdgpu_display_manager *dm;
-	struct dc_stream_state *stream;
+
+	struct drm_crtc *crtc;
+
+	/* Region of Interest (ROI) */
 	struct rect rect;
-	bool is_stop_cmd;
 };
 #endif
 
@@ -100,11 +95,11 @@ void amdgpu_dm_crtc_handle_crc_irq(struct drm_crtc *crtc);
 #ifdef CONFIG_DRM_AMD_SECURE_DISPLAY
 bool amdgpu_dm_crc_window_is_activated(struct drm_crtc *crtc);
 void amdgpu_dm_crtc_handle_crc_window_irq(struct drm_crtc *crtc);
-struct crc_rd_work *amdgpu_dm_crtc_secure_display_create_work(void);
+struct secure_display_context *amdgpu_dm_crtc_secure_display_create_contexts(int num_crtc);
 #else
 #define amdgpu_dm_crc_window_is_activated(x)
 #define amdgpu_dm_crtc_handle_crc_window_irq(x)
-#define amdgpu_dm_crtc_secure_display_create_work()
+#define amdgpu_dm_crtc_secure_display_create_contexts()
 #endif
 
 #endif /* AMD_DAL_DEV_AMDGPU_DM_AMDGPU_DM_CRC_H_ */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 461037a3dd75..a29952cd8f22 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -3245,46 +3245,24 @@ DEFINE_DEBUGFS_ATTRIBUTE(crc_win_y_end_fops, crc_win_y_end_get,
  */
 static int crc_win_update_set(void *data, u64 val)
 {
-	struct drm_crtc *new_crtc = data;
-	struct drm_crtc *old_crtc = NULL;
-	struct amdgpu_crtc *new_acrtc, *old_acrtc;
-	struct amdgpu_device *adev = drm_to_adev(new_crtc->dev);
-	struct crc_rd_work *crc_rd_wrk = adev->dm.crc_rd_wrk;
-
-	if (!crc_rd_wrk)
-		return 0;
+	struct drm_crtc *crtc = data;
+	struct amdgpu_crtc *acrtc;
+	struct amdgpu_device *adev = drm_to_adev(crtc->dev);
 
 	if (val) {
-		new_acrtc = to_amdgpu_crtc(new_crtc);
+		acrtc = to_amdgpu_crtc(crtc);
 		mutex_lock(&adev->dm.dc_lock);
 		/* PSR may write to OTG CRC window control register,
 		 * so close it before starting secure_display.
 		 */
-		amdgpu_dm_psr_disable(new_acrtc->dm_irq_params.stream);
+		amdgpu_dm_psr_disable(acrtc->dm_irq_params.stream);
 
 		spin_lock_irq(&adev_to_drm(adev)->event_lock);
-		spin_lock_irq(&crc_rd_wrk->crc_rd_work_lock);
-		if (crc_rd_wrk->crtc) {
-			old_crtc = crc_rd_wrk->crtc;
-			old_acrtc = to_amdgpu_crtc(old_crtc);
-		}
 
-		if (old_crtc && old_crtc != new_crtc) {
-			old_acrtc->dm_irq_params.window_param.activated = false;
-			old_acrtc->dm_irq_params.window_param.update_win = false;
-			old_acrtc->dm_irq_params.window_param.skip_frame_cnt = 0;
+		acrtc->dm_irq_params.window_param.activated = true;
+		acrtc->dm_irq_params.window_param.update_win = true;
+		acrtc->dm_irq_params.window_param.skip_frame_cnt = 0;
 
-			new_acrtc->dm_irq_params.window_param.activated = true;
-			new_acrtc->dm_irq_params.window_param.update_win = true;
-			new_acrtc->dm_irq_params.window_param.skip_frame_cnt = 0;
-			crc_rd_wrk->crtc = new_crtc;
-		} else {
-			new_acrtc->dm_irq_params.window_param.activated = true;
-			new_acrtc->dm_irq_params.window_param.update_win = true;
-			new_acrtc->dm_irq_params.window_param.skip_frame_cnt = 0;
-			crc_rd_wrk->crtc = new_crtc;
-		}
-		spin_unlock_irq(&crc_rd_wrk->crc_rd_work_lock);
 		spin_unlock_irq(&adev_to_drm(adev)->event_lock);
 		mutex_unlock(&adev->dm.dc_lock);
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 0cb8d1f934d1..e265faff4c3d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -518,14 +518,15 @@ dc_stream_forward_dmcu_crc_window(struct dmcu *dmcu,
 }
 
 bool
-dc_stream_forward_crc_window(struct dc *dc,
-		struct rect *rect, struct dc_stream_state *stream, bool is_stop)
+dc_stream_forward_crc_window(struct dc_stream_state *stream,
+		struct rect *rect, bool is_stop)
 {
 	struct dmcu *dmcu;
 	struct dc_dmub_srv *dmub_srv;
 	struct otg_phy_mux mux_mapping;
 	struct pipe_ctx *pipe;
 	int i;
+	struct dc *dc = stream->ctx->dc;
 
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe = &dc->current_state->res_ctx.pipe_ctx[i];
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index dfd3df1d2f7e..ef33d7d8a2bf 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -543,9 +543,8 @@ bool dc_stream_get_crtc_position(struct dc *dc,
 				 unsigned int *nom_v_pos);
 
 #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
-bool dc_stream_forward_crc_window(struct dc *dc,
+bool dc_stream_forward_crc_window(struct dc_stream_state *stream,
 		struct rect *rect,
-		struct dc_stream_state *stream,
 		bool is_stop);
 #endif
 
-- 
2.34.1

