Return-Path: <SRS0=jwYW=3U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799D8C2D0DB
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2020 22:17:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CE002082E
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2020 22:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ckmRnZNZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CE002082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D33986FC30;
	Fri, 31 Jan 2020 22:17:05 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF0626FC2E
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2020 22:17:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GPCfdEcWy/x1GBjP9hPUmWV3plorKa2RjFdQV6Tc8YBAN87dutU7TDDCp3YOTyObU4pLJdt8ZOpGHYamVBP27Aep4sHOMdwx2KvBXuwqnGgA1eEK/Wn1H8JLsEwyXi0SrS5T4hzh+QR5IatCIvQcXxQHbiFnMauGWwfMyNp+Z6ZoQg61Lb3NxSA+cy0hukdR+OnOCSPiYvv7SFG6ZNKQNXtfCT5wbv67x0PKioC4tz0V4hO0rVRx+lcas3+9UjODnGNd6CEr2Zax4e5i4eDYHM4UAG3oMnGy65YPhDi5lez7QPBnbfToA2uuv0UnxRhtvDfgSzmBmJqtPw+Qu0XaVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IvfsCkFSKs2nOy9V4hyqFrA6cFIXJ/k/QOv7+WFM1G0=;
 b=oD0e3Mf39tW5QamRebGHARrRd46NRgaIfmJFG63MNNIOjBpqljnj/loACtX0Y8oXoWI57yc+6XxFoHNR1Txvcu8W5eTE8EDQDyjMKPB5bCFgs7w7JdWAJKRHgFS4c8O4HzBnoASolRavbmE0GdEFZsL0DXbHiiNVXj2SPKTqj++DNPjVmr6OTEfqP074wpcAXpus2UMuB+Mlwp9/j9qGEvc8YTj+2W9KqNFhUUcJWMgEt98mw/YMTh4HYt9h5O8XxKhNdWKwHnmaHuqp08dJ3ykJYxpjIM8je26+j6p3PagakNw1BO8sehKQHHTbzevi2bCV/+Ch1V1jG3L4g/kltA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IvfsCkFSKs2nOy9V4hyqFrA6cFIXJ/k/QOv7+WFM1G0=;
 b=ckmRnZNZrydLWj8243focdBLIpV8UbYUEknBBq0Dp92RZlgylSKnEMhS3dDGAaOOGDedD59xUlm70B2iQm5bgK/5bJBY7jETndOAWUX51a0hAd54eejt4WJXS3Do4JyWSrWxiuUXioscv5ccnfOFDUyldE6jbtXiwDpURp3kNtA=
Received: from BN6PR1201CA0019.namprd12.prod.outlook.com
 (2603:10b6:405:4c::29) by MWHPR1201MB0272.namprd12.prod.outlook.com
 (2603:10b6:301:52::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.26; Fri, 31 Jan
 2020 22:17:01 +0000
Received: from BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eae::203) by BN6PR1201CA0019.outlook.office365.com
 (2603:10b6:405:4c::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.27 via Frontend
 Transport; Fri, 31 Jan 2020 22:17:01 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT021.mail.protection.outlook.com (10.13.177.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2686.25 via Frontend Transport; Fri, 31 Jan 2020 22:17:01 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 31 Jan
 2020 16:17:00 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 31 Jan
 2020 16:17:00 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 31 Jan 2020 16:16:59 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/33] drm/amd/display: Add set psr version message
Date: Fri, 31 Jan 2020 17:16:11 -0500
Message-ID: <20200131221643.10035-2-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200131221643.10035-1-Bhawanpreet.Lakha@amd.com>
References: <20200131221643.10035-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(376002)(346002)(136003)(428003)(189003)(199004)(54906003)(4326008)(2906002)(36756003)(356004)(1076003)(86362001)(7696005)(478600001)(316002)(6666004)(81156014)(8676002)(81166006)(186003)(6916009)(8936002)(26005)(426003)(2616005)(70206006)(336012)(70586007)(5660300002)(15650500001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR1201MB0272; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a07f753-f7c5-4736-f1db-08d7a69b4b61
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0272:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0272A7EFC779C5214559A5B3F9070@MWHPR1201MB0272.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:422;
X-Forefront-PRVS: 029976C540
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X3H+gRmLVASIZ1EaCzJ9NXY8JxcOGywmzl3g5bmqkuBMu+9yBZ03WUYC9F29zL0R+XO7dFdW0zKaKvqxKiD5bj1THWuG74JL2BP/JhvgQZihjkocRiO1th1PgjHwztel02LhLIt6pHaw5XplzVaOyJ3NrH+DG02oaB2H6ejh295dTLhRp2IK9RANB1+/KGqCnsMrPB719ennAB4jBTW35x5rs3IAczkjONKu9mUlscXr8KmmdDJ7xjfOg2hUti0vnEReZGrbC9cgkT7n8sJg4G9qukWfo1pyT0sJToWarldJPpME6JCn9QC2KOqCkvWTjWOxVIqvbGCHIRIQAHd2jE65tNzLblhinlT+8pexMRNBh7bFSSloswDJOi5eCzRF83/yXhrRtClNqPtgvy9l7olOe+O/wX6wXmjsh9AxrNLkIVVtsb5GYNXFGTKZ8cKm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2020 22:17:01.0636 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a07f753-f7c5-4736-f1db-08d7a69b4b61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0272
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
Cc: sunpeng.li@amd.com, rodrigo.siqueira@amd.com, harry.wentland@amd.com,
 Wyatt Wood <wyatt.wood@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wyatt Wood <wyatt.wood@amd.com>

[Why]
Must know psr version during runtime.

[How]
Add set psr version message structures.

Signed-off-by: Wyatt Wood <wyatt.wood@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  6 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c | 62 +++++++++++++------
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h |  9 +--
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 10 +--
 .../drm/amd/display/dmub/inc/dmub_cmd_dal.h   |  4 +-
 5 files changed, 57 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index a09119c10d7c..41184e593f85 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -2401,7 +2401,7 @@ bool dc_link_set_psr_allow_active(struct dc_link *link, bool allow_active, bool
 	struct dmub_psr *psr = dc->res_pool->psr;
 
 	if ((psr != NULL) && link->psr_feature_enabled)
-		psr->funcs->set_psr_enable(psr, allow_active);
+		psr->funcs->psr_enable(psr, allow_active);
 	else if ((dmcu != NULL && dmcu->funcs->is_dmcu_initialized(dmcu)) && link->psr_feature_enabled)
 		dmcu->funcs->set_psr_enable(dmcu, allow_active, wait);
 
@@ -2417,7 +2417,7 @@ bool dc_link_get_psr_state(const struct dc_link *link, uint32_t *psr_state)
 	struct dmub_psr *psr = dc->res_pool->psr;
 
 	if (psr != NULL && link->psr_feature_enabled)
-		psr->funcs->get_psr_state(psr_state);
+		psr->funcs->psr_get_state(psr_state);
 	else if (dmcu != NULL && link->psr_feature_enabled)
 		dmcu->funcs->get_psr_state(dmcu, psr_state);
 
@@ -2589,7 +2589,7 @@ bool dc_link_setup_psr(struct dc_link *link,
 	psr_context->frame_delay = 0;
 
 	if (psr)
-		link->psr_feature_enabled = psr->funcs->setup_psr(psr, link, psr_context);
+		link->psr_feature_enabled = psr->funcs->psr_copy_settings(psr, link, psr_context);
 	else
 		link->psr_feature_enabled = dmcu->funcs->setup_psr(dmcu, link, psr_context);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
index 225955ec6d39..bdf80b09277e 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
@@ -36,16 +36,39 @@
 /**
  * Get PSR state from firmware.
  */
-static void dmub_get_psr_state(uint32_t *psr_state)
+static void dmub_psr_get_state(uint32_t *psr_state)
 {
 	// Not yet implemented
 	// Trigger GPINT interrupt from firmware
 }
 
+static void dmub_psr_set_version(struct dmub_psr *dmub, struct dc_stream_state *stream)
+{
+	//stream->psr_version;
+	union dmub_rb_cmd cmd;
+	struct dc_context *dc = dmub->ctx;
+
+	cmd.psr_set_version.header.type = DMUB_CMD__PSR;
+	cmd.psr_set_version.header.sub_type = DMUB_CMD__PSR_SET_VERSION;
+
+	if (stream->psr_version == 0x0)
+		return;
+	else if (stream->psr_version == 0x1)
+		cmd.psr_set_version.psr_set_version_data.version = PSR_VERSION_1;
+	else if (stream->psr_version == 0x2)
+		cmd.psr_set_version.psr_set_version_data.version = PSR_VERSION_2;
+
+	cmd.psr_enable.header.payload_bytes = sizeof(struct dmub_cmd_psr_set_version_data);
+
+	dc_dmub_srv_cmd_queue(dc->dmub_srv, &cmd.psr_enable.header);
+	dc_dmub_srv_cmd_execute(dc->dmub_srv);
+	dc_dmub_srv_wait_idle(dc->dmub_srv);
+}
+
 /**
  * Enable/Disable PSR.
  */
-static void dmub_set_psr_enable(struct dmub_psr *dmub, bool enable)
+static void dmub_psr_enable(struct dmub_psr *dmub, bool enable)
 {
 	union dmub_rb_cmd cmd;
 	struct dc_context *dc = dmub->ctx;
@@ -67,13 +90,13 @@ static void dmub_set_psr_enable(struct dmub_psr *dmub, bool enable)
 /**
  * Set PSR level.
  */
-static void dmub_set_psr_level(struct dmub_psr *dmub, uint16_t psr_level)
+static void dmub_psr_set_level(struct dmub_psr *dmub, uint16_t psr_level)
 {
 	union dmub_rb_cmd cmd;
 	uint32_t psr_state = 0;
 	struct dc_context *dc = dmub->ctx;
 
-	dmub_get_psr_state(&psr_state);
+	dmub_psr_get_state(&psr_state);
 
 	if (psr_state == 0)
 		return;
@@ -91,7 +114,7 @@ static void dmub_set_psr_level(struct dmub_psr *dmub, uint16_t psr_level)
 /**
  * Setup PSR by programming phy registers and sending psr hw context values to firmware.
  */
-static bool dmub_setup_psr(struct dmub_psr *dmub,
+static bool dmub_psr_copy_settings(struct dmub_psr *dmub,
 		struct dc_link *link,
 		struct psr_context *psr_context)
 {
@@ -104,18 +127,16 @@ static bool dmub_setup_psr(struct dmub_psr *dmub,
 
 	for (int i = 0; i < MAX_PIPES; i++) {
 		if (res_ctx &&
-				res_ctx->pipe_ctx[i].stream &&
-				res_ctx->pipe_ctx[i].stream->link &&
-				res_ctx->pipe_ctx[i].stream->link == link &&
-				res_ctx->pipe_ctx[i].stream->link->connector_signal == SIGNAL_TYPE_EDP) {
+			res_ctx->pipe_ctx[i].stream &&
+			res_ctx->pipe_ctx[i].stream->link &&
+			res_ctx->pipe_ctx[i].stream->link == link &&
+			res_ctx->pipe_ctx[i].stream->link->connector_signal == SIGNAL_TYPE_EDP) {
 			pipe_ctx = &res_ctx->pipe_ctx[i];
 			break;
 		}
 	}
 
-	if (!pipe_ctx ||
-			!&pipe_ctx->plane_res ||
-			!&pipe_ctx->stream_res)
+	if (!pipe_ctx || !&pipe_ctx->plane_res || !&pipe_ctx->stream_res)
 		return false;
 
 	// Program DP DPHY fast training registers
@@ -161,13 +182,13 @@ static bool dmub_setup_psr(struct dmub_psr *dmub,
 	copy_settings_data->hyst_lines				= psr_context->hyst_lines;
 	copy_settings_data->phy_type				= psr_context->phyType;
 	copy_settings_data->aux_repeat				= psr_context->aux_repeats;
-	copy_settings_data->smu_optimizations_en	= psr_context->allow_smu_optimizations;
-	copy_settings_data->skip_wait_for_pll_lock	= psr_context->skipPsrWaitForPllLock;
+	copy_settings_data->smu_optimizations_en		= psr_context->allow_smu_optimizations;
+	copy_settings_data->skip_wait_for_pll_lock		= psr_context->skipPsrWaitForPllLock;
 	copy_settings_data->frame_delay				= psr_context->frame_delay;
 	copy_settings_data->smu_phy_id				= psr_context->smuPhyId;
-	copy_settings_data->num_of_controllers		= psr_context->numberOfControllers;
+	copy_settings_data->num_of_controllers			= psr_context->numberOfControllers;
 	copy_settings_data->frame_cap_ind			= psr_context->psrFrameCaptureIndicationReq;
-	copy_settings_data->phy_num					= psr_context->frame_delay & 0x7;
+	copy_settings_data->phy_num				= psr_context->frame_delay & 0x7;
 	copy_settings_data->link_rate				= psr_context->frame_delay & 0xF;
 
 	dc_dmub_srv_cmd_queue(dc->dmub_srv, &cmd.psr_copy_settings.header);
@@ -178,10 +199,11 @@ static bool dmub_setup_psr(struct dmub_psr *dmub,
 }
 
 static const struct dmub_psr_funcs psr_funcs = {
-	.set_psr_enable			= dmub_set_psr_enable,
-	.setup_psr				= dmub_setup_psr,
-	.get_psr_state			= dmub_get_psr_state,
-	.set_psr_level			= dmub_set_psr_level,
+	.psr_set_version		= dmub_psr_set_version,
+	.psr_copy_settings		= dmub_psr_copy_settings,
+	.psr_enable			= dmub_psr_enable,
+	.psr_get_state			= dmub_psr_get_state,
+	.psr_set_level			= dmub_psr_set_level,
 };
 
 /**
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h
index 229958de3035..4fe8b53d9551 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h
@@ -34,10 +34,11 @@ struct dmub_psr {
 };
 
 struct dmub_psr_funcs {
-	void (*set_psr_enable)(struct dmub_psr *dmub, bool enable);
-	bool (*setup_psr)(struct dmub_psr *dmub, struct dc_link *link, struct psr_context *psr_context);
-	void (*get_psr_state)(uint32_t *psr_state);
-	void (*set_psr_level)(struct dmub_psr *dmub, uint16_t psr_level);
+	void (*psr_set_version)(struct dmub_psr *dmub, struct dc_stream_state *stream);
+	bool (*psr_copy_settings)(struct dmub_psr *dmub, struct dc_link *link, struct psr_context *psr_context);
+	void (*psr_enable)(struct dmub_psr *dmub, bool enable);
+	void (*psr_get_state)(uint32_t *psr_state);
+	void (*psr_set_level)(struct dmub_psr *dmub, uint16_t psr_level);
 };
 
 struct dmub_psr *dmub_psr_create(struct dc_context *ctx);
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index cd9532b4f14d..8f518e7d8b4e 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -257,13 +257,13 @@ struct dmub_rb_cmd_psr_enable {
 	struct dmub_cmd_header header;
 };
 
-struct dmub_cmd_psr_setup_data {
+struct dmub_cmd_psr_set_version_data {
 	enum psr_version version; // PSR version 1 or 2
 };
 
-struct dmub_rb_cmd_psr_setup {
+struct dmub_rb_cmd_psr_set_version {
 	struct dmub_cmd_header header;
-	struct dmub_cmd_psr_setup_data psr_setup_data;
+	struct dmub_cmd_psr_set_version_data psr_set_version_data;
 };
 
 union dmub_rb_cmd {
@@ -277,11 +277,11 @@ union dmub_rb_cmd {
 	struct dmub_rb_cmd_enable_disp_power_gating enable_disp_power_gating;
 	struct dmub_rb_cmd_dpphy_init dpphy_init;
 	struct dmub_rb_cmd_dig1_transmitter_control dig1_transmitter_control;
-	struct dmub_rb_cmd_psr_enable psr_enable;
+	struct dmub_rb_cmd_psr_set_version psr_set_version;
 	struct dmub_rb_cmd_psr_copy_settings psr_copy_settings;
+	struct dmub_rb_cmd_psr_enable psr_enable;
 	struct dmub_rb_cmd_psr_set_level psr_set_level;
 	struct dmub_rb_cmd_PLAT_54186_wa PLAT_54186_wa;
-	struct dmub_rb_cmd_psr_setup psr_setup;
 };
 
 #pragma pack(pop)
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd_dal.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd_dal.h
index 7b69eb37f762..ce793f47f234 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd_dal.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd_dal.h
@@ -32,7 +32,7 @@
  */
 
 enum dmub_cmd_psr_type {
-	DMUB_CMD__PSR_SETUP		= 0,
+	DMUB_CMD__PSR_SET_VERSION	= 0,
 	DMUB_CMD__PSR_COPY_SETTINGS	= 1,
 	DMUB_CMD__PSR_ENABLE		= 2,
 	DMUB_CMD__PSR_DISABLE		= 3,
@@ -42,7 +42,7 @@ enum dmub_cmd_psr_type {
 enum psr_version {
 	PSR_VERSION_1			= 0x10, // PSR Version 1
 	PSR_VERSION_2			= 0x20, // PSR Version 2, includes selective update
-	PSR_VERSION_2_Y_COORD		= 0x21, // PSR Version 2, includes Y-coordinate support for SU
+	PSR_VERSION_2_1			= 0x21, // PSR Version 2, includes Y-coordinate support for SU
 };
 
 #endif /* _DMUB_CMD_DAL_H_ */
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
