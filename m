Return-Path: <SRS0=BT7C=ID=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18FB1C433DB
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 20:04:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE2E4650A0
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 20:04:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE2E4650A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D5466EC3D;
	Fri,  5 Mar 2021 20:04:25 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 802636EC3D
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Mar 2021 20:04:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UAYIZGkvLhxUIpZnaSpThjzG43yjL9rQ4BQS+56ewAAqbL0KMAEAHK+t7yNMBKheEwuHJs6bop7ElMgZbF8f9sYYWDc7B6VYM5t22e0jUlbC1xm/Fz4b2zn8HrAmHDKRceVbc0s6jASglaxnIBtRAnGVsldLQDOOikRcdjL416edZnZsjCo41kjWg6LRgL2p2ixGjxa6edwgGqu9xqqc+cvMu4A6+zqNwzThyPUunFGjohevgjRCIdkThePqNLStbYYm4naftQjurXbDi3dYiwlvi2H1rbRiK5xPnwJT7TzM2c4VhhV2KD+IoPuCLGJBV2fJ4ytCLLWvWyPAX5LWNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3IbWFXV2U1iV7E9yrVb1euLwjAiQd5mBp8b3P09Y63w=;
 b=HkVhPzOSxmTUXYxiUqwtL7gR8Fse8AvGI7qn/YkphWicZOyTFl81m4y7oI+YUTDATTHHcazpeiwNH9zqVk7U9GnuGNbmMmgRjPhVK/HP9RuK8yMvJeX/b6K9fXVS/m4PxWFNnnaloNfKBlVUqfGXOWmDo3miOnPriOG7l71NIEplTTPkYBQ8HGbHEi9Qp1ElVUBgf2lVnZ11ph+IppqHMppereuIrnZjTCNrm4IGlTc/6tUdrJQlfkWG1bPrvIQ0ksiG32dVUfYQJToypSX7MSRfGQAZnVPSbUrFVJsvKI9P74S1CBB3QcuX6u0s9rc1hu5rTArIfZ8ttj71Hv+uMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3IbWFXV2U1iV7E9yrVb1euLwjAiQd5mBp8b3P09Y63w=;
 b=BlHrPDLUkAqUGmhutSOta+Lg8FOfKsDjxkJbGRfPIXQ+TyWzdoxED4GK1TQGxNsfkUvCPqMnLW2RJDeoO3DErT1Gb37QJn1Vd4ZLh8/dUgeDLh70/jaRzXS6/FDhEL7FvU9PF5uFpyBKP31iBJKQb32np2EnV2bTKN7ble146Kg=
Received: from DM6PR02CA0057.namprd02.prod.outlook.com (2603:10b6:5:177::34)
 by MN2PR12MB4335.namprd12.prod.outlook.com (2603:10b6:208:1d4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Fri, 5 Mar
 2021 20:04:21 +0000
Received: from DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::67) by DM6PR02CA0057.outlook.office365.com
 (2603:10b6:5:177::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Fri, 5 Mar 2021 20:04:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB02.amd.com;
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT055.mail.protection.outlook.com (10.13.173.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3912.17 via Frontend Transport; Fri, 5 Mar 2021 20:04:20 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 5 Mar 2021
 14:04:19 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 5 Mar 2021
 14:04:19 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.2106.2 via Frontend
 Transport; Fri, 5 Mar 2021 14:04:08 -0600
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/14] drm/amd/display: Enable pflip interrupt upon pipe enable
Date: Fri, 5 Mar 2021 15:02:53 -0500
Message-ID: <20210305200301.17696-7-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210305200301.17696-1-eryk.brol@amd.com>
References: <20210305200301.17696-1-eryk.brol@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d89872a-26fc-4b5e-29eb-08d8e011dd4b
X-MS-TrafficTypeDiagnostic: MN2PR12MB4335:
X-Microsoft-Antispam-PRVS: <MN2PR12MB433522EFC8294A875442C272E5969@MN2PR12MB4335.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:376;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VkDVi2r7ASCYI6So864m6W1yOK1P5hTNLvEaBO+fXR9l9efXrNDSv/q8vFg9lqTkd1/t6gqsmwCvnMVGe8B9WV5buXmlt396O4qFLvM0EIH7Kn1pmymcaJ5Q2ieo7U9hdIvM+hC+RAnQHHm5dgAxZkv6wfheif7/7onR5rafmriWhU9IfxvkbVSsPxF1qYpEHHw1jKuRa1pcBOt0ZRsDc79xrvBRMyJxhgtW4oJqorAXRsatCzQTvyrfAcoLy4jxN5XTLrtIoiKWmUKiI9Zu39xttLqe+EW4tHomZJdWGZmNLfMUAnjxEhSRjxZEmmiXS0n8Tn93uVewfFd5XHicwj03xQMRPqca1yZEGNepgjIU2xS1X9R3R6QUHx7UtTimV23n7Ch9BwcchEuLL7J+LO/xAE1cMpYfkCGNUFgHGz0D/wbHrpWLzSM/ognV8kiUoFRZ99XXIueodu4DmiSobtYAre+X+Lp3Irza4Zn25cJlSMheEqJwyBaWZXalWJe18qhsKY5o6IK+I08rHh7Nl+yNgD4qgXYdSeUfK5cnWW0qG5yn21jCocz9qshsqOPbYkFzyLFWZ7nUB4Kb0tyjCw/7EmU91EfmYkzoH2ED32Kxise3b0UXOUkWh3o4jJ5fOuPkp8quNtBOYKrrjfvZ//R7QaCGJQRqYXLf161rBV8/ly4U80ZRyGsjCHlQ9+Lp
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(396003)(136003)(376002)(36840700001)(46966006)(5660300002)(8936002)(82740400003)(54906003)(356005)(6916009)(4326008)(44832011)(2616005)(83380400001)(36756003)(1076003)(36860700001)(316002)(8676002)(186003)(70206006)(426003)(26005)(47076005)(2906002)(336012)(478600001)(70586007)(82310400003)(81166007)(6666004)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2021 20:04:20.3752 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d89872a-26fc-4b5e-29eb-08d8e011dd4b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4335
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
Cc: Eryk Brol <eryk.brol@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing Zhuo <qingqing.zhuo@amd.com>, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Qingqing Zhuo <qingqing.zhuo@amd.com>

[Why]
pflip interrupt would not be enabled promptly if a pipe is disabled
and re-enabled, causing flip_done timeout error during DP
compliance tests

[How]
Enable pflip interrupt upon pipe enablement

Signed-off-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c     |  1 +
 drivers/gpu/drm/amd/display/dc/dc.h                   |  1 +
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c     | 11 +++++++++++
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.h     |  6 ++++++
 .../gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c |  7 +++++++
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c     |  1 +
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  6 ++++++
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c     |  1 +
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubp.c     |  1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h          |  2 ++
 10 files changed, 37 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index bd77519440e3..7f2ece5b4db0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4804,6 +4804,7 @@ static int fill_dc_plane_attributes(struct amdgpu_device *adev,
 	dc_plane_state->global_alpha_value = plane_info.global_alpha_value;
 	dc_plane_state->dcc = plane_info.dcc;
 	dc_plane_state->layer_index = plane_info.layer_index; // Always returns 0
+	dc_plane_state->flip_int_enabled = true;
 
 	/*
 	 * Always set input transfer function, since plane state is refreshed
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index b328393bcb7b..9765a63d973a 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -898,6 +898,7 @@ struct dc_plane_state {
 	int layer_index;
 
 	union surface_update_flags update_flags;
+	bool flip_int_enabled;
 	/* private to DC core */
 	struct dc_plane_status status;
 	struct dc_context *ctx;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c
index 9e796dfeac20..714c71a5fbde 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c
@@ -1257,6 +1257,16 @@ void hubp1_soft_reset(struct hubp *hubp, bool reset)
 	REG_UPDATE(DCHUBP_CNTL, HUBP_DISABLE, reset ? 1 : 0);
 }
 
+void hubp1_set_flip_int(struct hubp *hubp)
+{
+	struct dcn10_hubp *hubp1 = TO_DCN10_HUBP(hubp);
+
+	REG_UPDATE(DCSURF_SURFACE_FLIP_INTERRUPT,
+		SURFACE_FLIP_INT_MASK, 1);
+
+	return;
+}
+
 void hubp1_init(struct hubp *hubp)
 {
 	//do nothing
@@ -1290,6 +1300,7 @@ static const struct hubp_funcs dcn10_hubp_funcs = {
 	.dmdata_load = NULL,
 	.hubp_soft_reset = hubp1_soft_reset,
 	.hubp_in_blank = hubp1_in_blank,
+	.hubp_set_flip_int = hubp1_set_flip_int,
 };
 
 /*****************************************/
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.h
index a9a6ed7f4f99..e2f2f6995935 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.h
@@ -74,6 +74,7 @@
 	SRI(DCSURF_SURFACE_EARLIEST_INUSE_C, HUBPREQ, id),\
 	SRI(DCSURF_SURFACE_EARLIEST_INUSE_HIGH_C, HUBPREQ, id),\
 	SRI(DCSURF_SURFACE_CONTROL, HUBPREQ, id),\
+	SRI(DCSURF_SURFACE_FLIP_INTERRUPT, HUBPREQ, id),\
 	SRI(HUBPRET_CONTROL, HUBPRET, id),\
 	SRI(DCN_EXPANSION_MODE, HUBPREQ, id),\
 	SRI(DCHUBP_REQ_SIZE_CONFIG, HUBP, id),\
@@ -183,6 +184,7 @@
 	uint32_t DCSURF_SURFACE_EARLIEST_INUSE_C; \
 	uint32_t DCSURF_SURFACE_EARLIEST_INUSE_HIGH_C; \
 	uint32_t DCSURF_SURFACE_CONTROL; \
+	uint32_t DCSURF_SURFACE_FLIP_INTERRUPT; \
 	uint32_t HUBPRET_CONTROL; \
 	uint32_t DCN_EXPANSION_MODE; \
 	uint32_t DCHUBP_REQ_SIZE_CONFIG; \
@@ -332,6 +334,7 @@
 	HUBP_SF(HUBPREQ0_DCSURF_SURFACE_CONTROL, SECONDARY_META_SURFACE_TMZ_C, mask_sh),\
 	HUBP_SF(HUBPREQ0_DCSURF_SURFACE_CONTROL, SECONDARY_SURFACE_DCC_EN, mask_sh),\
 	HUBP_SF(HUBPREQ0_DCSURF_SURFACE_CONTROL, SECONDARY_SURFACE_DCC_IND_64B_BLK, mask_sh),\
+	HUBP_SF(HUBPREQ0_DCSURF_SURFACE_FLIP_INTERRUPT, SURFACE_FLIP_INT_MASK, mask_sh),\
 	HUBP_SF(HUBPRET0_HUBPRET_CONTROL, DET_BUF_PLANE1_BASE_ADDRESS, mask_sh),\
 	HUBP_SF(HUBPRET0_HUBPRET_CONTROL, CROSSBAR_SRC_CB_B, mask_sh),\
 	HUBP_SF(HUBPRET0_HUBPRET_CONTROL, CROSSBAR_SRC_CR_R, mask_sh),\
@@ -531,6 +534,7 @@
 	type PRIMARY_SURFACE_DCC_IND_64B_BLK;\
 	type SECONDARY_SURFACE_DCC_EN;\
 	type SECONDARY_SURFACE_DCC_IND_64B_BLK;\
+	type SURFACE_FLIP_INT_MASK;\
 	type DET_BUF_PLANE1_BASE_ADDRESS;\
 	type CROSSBAR_SRC_CB_B;\
 	type CROSSBAR_SRC_CR_R;\
@@ -777,4 +781,6 @@ void hubp1_read_state_common(struct hubp *hubp);
 bool hubp1_in_blank(struct hubp *hubp);
 void hubp1_soft_reset(struct hubp *hubp, bool reset);
 
+void hubp1_set_flip_int(struct hubp *hubp);
+
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 190b10445e03..9eb33eae0e81 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -2438,6 +2438,13 @@ static void dcn10_enable_plane(
 	if (dc->debug.sanity_checks) {
 		hws->funcs.verify_allow_pstate_change_high(dc);
 	}
+
+	if (!pipe_ctx->top_pipe
+		&& pipe_ctx->plane_state
+		&& pipe_ctx->plane_state->flip_int_enabled
+		&& pipe_ctx->plane_res.hubp->funcs->hubp_set_flip_int)
+			pipe_ctx->plane_res.hubp->funcs->hubp_set_flip_int(pipe_ctx->plane_res.hubp);
+
 }
 
 void dcn10_program_gamut_remap(struct pipe_ctx *pipe_ctx)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
index 0df0da2e6a4d..bec7059f6d5d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
@@ -1597,6 +1597,7 @@ static struct hubp_funcs dcn20_hubp_funcs = {
 	.validate_dml_output = hubp2_validate_dml_output,
 	.hubp_in_blank = hubp1_in_blank,
 	.hubp_soft_reset = hubp1_soft_reset,
+	.hubp_set_flip_int = hubp1_set_flip_int,
 };
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 48d1e0e2cf75..0d3c7e42204f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1146,6 +1146,12 @@ void dcn20_enable_plane(
 		pipe_ctx->plane_res.hubp->funcs->hubp_set_vm_system_aperture_settings(pipe_ctx->plane_res.hubp, &apt);
 	}
 
+	if (!pipe_ctx->top_pipe
+		&& pipe_ctx->plane_state
+		&& pipe_ctx->plane_state->flip_int_enabled
+		&& pipe_ctx->plane_res.hubp->funcs->hubp_set_flip_int)
+			pipe_ctx->plane_res.hubp->funcs->hubp_set_flip_int(pipe_ctx->plane_res.hubp);
+
 //	if (dc->debug.sanity_checks) {
 //		dcn10_verify_allow_pstate_change_high(dc);
 //	}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c
index f9045852728f..b0c9180b808f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c
@@ -838,6 +838,7 @@ static struct hubp_funcs dcn21_hubp_funcs = {
 	.hubp_set_flip_control_surface_gsl = hubp2_set_flip_control_surface_gsl,
 	.hubp_init = hubp21_init,
 	.validate_dml_output = hubp21_validate_dml_output,
+	.hubp_set_flip_int = hubp1_set_flip_int,
 };
 
 bool hubp21_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubp.c
index 88ffa9ff1ed1..f24612523248 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubp.c
@@ -511,6 +511,7 @@ static struct hubp_funcs dcn30_hubp_funcs = {
 	.hubp_init = hubp3_init,
 	.hubp_in_blank = hubp1_in_blank,
 	.hubp_soft_reset = hubp1_soft_reset,
+	.hubp_set_flip_int = hubp1_set_flip_int,
 };
 
 bool hubp3_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h b/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
index 22f3f643ed1b..346dcd87dc10 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
@@ -191,6 +191,8 @@ struct hubp_funcs {
 	bool (*hubp_in_blank)(struct hubp *hubp);
 	void (*hubp_soft_reset)(struct hubp *hubp, bool reset);
 
+	void (*hubp_set_flip_int)(struct hubp *hubp);
+
 };
 
 #endif
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
