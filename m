Return-Path: <SRS0=i8pd=27=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33BF8C33CA3
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:47:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B1E42082E
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="CBxn6ebf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B1E42082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9C576EA3A;
	Fri, 10 Jan 2020 14:47:33 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACB366EA3A
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 14:47:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GEzmw/Dk2kw6UuEwM17OIhBymdw9d+9lsrKfM4x74lFFKr88SWrPhTlT2AmnLKQ3wpvoJm/H3UKjmcTTAASnICqewMN0kBUr5mw7WlbmOdFLiLHVLI8P9pnIAoHbkTgnW7vcS6ZQGuGtmJRhzOX3J6fDrkPGeDbg3izdtzqgfoooOWXlSDQxdUfLpMUmYvl3z8sgu8eNS+5G4oQEI+N3Hn5pRECI3U4Vp7YjhXaLysqdSoHzqWNAATur+TR81tsHUKuKG9g9wdYdJyb6d62ntyhQfiEffTCY4c+YirgD1B7kEOLU/cmkngeping5m4medn57hJY+yozWA3c3ZOb3AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2aRWzYuVq+JamKRMOpVYO1k3QJcQAWMX5WBIeB0yELc=;
 b=Lk+TpbwSvZCNffWwZrS92TI/jid1+ENswI7uR2L9vooFXtyfJb1LsuI7sIdgZ99LPUJqhR9PMADKMgmFptPnWulfjUNOITZ9ZJte6ZjnecAOFun+X2qmDy1nXv7m5ljhZX/iBDm/OVGlqh1ImY5GfP7aRW9ZsIbSU5c/TMUKhSBsXKjX9HrzxkGbv2U0HVO+mBs4Ui0/agkNiqZPe7jXpto1K8zGCBK/fMHYz+mweMUxuZi03d6e9CE1xB+2Yy3oFA0rhevVfONyWAPk72IQ1i6Q4IF47PV6R2n3ZmDAK4I+8jEXpEK4uCVqYa3oQa7hutuEu0mwYWv1rQ+pxsGPYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2aRWzYuVq+JamKRMOpVYO1k3QJcQAWMX5WBIeB0yELc=;
 b=CBxn6ebfYBzhwbaE2Yo66coynpBU8puMEsNUJdmNyb0oOOGaGPQ8kvH1JCTW9RYn7/XlwIMg5kx4lO0JIsS+fA/lBpkTZhMoSTEMTwUxQUbyFdLllYqGfh0+67eDeOvAOR/Q3TJ6iCS7/6BMS3148t3frkROT6byFKMpMwjs0pM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.11; Fri, 10 Jan 2020 14:47:30 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::699c:a877:13ef:6ae2]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::699c:a877:13ef:6ae2%6]) with mapi id 15.20.2623.011; Fri, 10 Jan 2020
 14:47:30 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 11/43] drm/amd/display: Add double buffering to dcn20 OCSC
Date: Fri, 10 Jan 2020 09:46:23 -0500
Message-Id: <20200110144655.55845-12-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200110144655.55845-1-Rodrigo.Siqueira@amd.com>
References: <20200110144655.55845-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YT1PR01CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::22)
 To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
Received: from atma2.amd.com (165.204.55.250) by
 YT1PR01CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.8 via Frontend Transport; Fri, 10 Jan 2020 14:47:29 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9d92d16c-546e-464e-75ec-08d795dc04bc
X-MS-TrafficTypeDiagnostic: MW2PR12MB2524:|MW2PR12MB2524:
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2524C8C92FEA3474A182498998380@MW2PR12MB2524.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 02788FF38E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(189003)(199004)(8936002)(5660300002)(6916009)(54906003)(81156014)(6486002)(81166006)(36756003)(316002)(1076003)(2906002)(6666004)(956004)(7696005)(52116002)(478600001)(186003)(2616005)(86362001)(26005)(16526019)(66556008)(8676002)(66476007)(4326008)(66946007)(461764006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2524;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: znJsAutb61FHDmE2YPiVg+K00uI2ukampF2Ozmwk9+n9I8aIoICmkYfAKpBHdHkeE3jsM/toFsFILAk1KXTwjp3Z0XO3caUTHlYJ2PVEb7MHKFr/HRJ2ptU+xlpa9RY6i4OBoJdLIou0QI3zAzp5Zs3AnVBKJPoi2PtdhsijZ59fr3NZReBUohCIei/g/WXzkVo9pOq8kkdfl0jU8wZ5EOJcvl+0BK+jwCmzK6J7PDyYIMszCCUg17Us5J6lB4qPIaxfYfuWUUih+yqptaKpuInmVOxbq7i52F/HswASA7JvkId9LIe4+keTK7ik8jMfaJdx882ylL6Qe2pgsZWaSPA5z/ggZ5X8FQdZpHkSVhNJJXSq1Tr3ScgmHbVOQ1/YMmi+0xMgzlazQ431Ocz0c9MP5XMUsu31Zg+J9ZyMRYBAkfpjpkkhoV0u+j1Udn2dhjlVjL+hSxthx8BF1ZJr0HGYL0kDdNxWmhQNHz3k8klIVUovxLBUAkO4lTG202tS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d92d16c-546e-464e-75ec-08d795dc04bc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2020 14:47:30.2467 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EX6oyxasibezgM8C3RLcrw163YvRn3PFGe2XblGhsbNHe9tV/Zju77c74N5hBFQ4rvE215/OJCNlNmW/UPjwmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2524
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com,
 Tony Cheng <Tony.Cheng@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Noah Abradjian <noah.abradjian@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Noah Abradjian <noah.abradjian@amd.com>

[Why]
When rapidly adjusting colour properties (e.g. brightness), screen tearing was observed.
This was due to overwritten values in OCSC registers. In dcn10, this issue had been fixed by
implementing double buffering by alternating OCSC modes.

[How]
Alternate which OCSC registers are used by switching modes each time.
This double buffers the CSC writes.

Signed-off-by: Noah Abradjian <noah.abradjian@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c  | 45 ++++++++++++++++---
 .../gpu/drm/amd/display/dc/dcn20/dcn20_mpc.h  | 16 +++++++
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |  1 +
 .../drm/amd/display/dc/dcn21/dcn21_resource.c |  3 +-
 4 files changed, 59 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c
index f90031ed58a6..c38f7fdb43a8 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c
@@ -33,6 +33,9 @@
 #define REG(reg)\
 	mpc20->mpc_regs->reg
 
+#define IND_REG(index) \
+	(index)
+
 #define CTX \
 	mpc20->base.ctx
 
@@ -132,19 +135,32 @@ void mpc2_set_output_csc(
 		const uint16_t *regval,
 		enum mpc_output_csc_mode ocsc_mode)
 {
+	uint32_t cur_mode;
 	struct dcn20_mpc *mpc20 = TO_DCN20_MPC(mpc);
 	struct color_matrices_reg ocsc_regs;
 
-	REG_SET(CSC_MODE[opp_id], 0, MPC_OCSC_MODE, ocsc_mode);
-
-	if (ocsc_mode == MPC_OUTPUT_CSC_DISABLE)
+	if (ocsc_mode == MPC_OUTPUT_CSC_DISABLE) {
+		REG_SET(CSC_MODE[opp_id], 0, MPC_OCSC_MODE, ocsc_mode);
 		return;
+	}
 
 	if (regval == NULL) {
 		BREAK_TO_DEBUGGER();
 		return;
 	}
 
+	/* determine which CSC coefficients (A or B) we are using
+	 * currently.  select the alternate set to double buffer
+	 * the CSC update so CSC is updated on frame boundary
+	 */
+	cur_mode = IX_REG_READ(MPC_OCSC_TEST_DEBUG_INDEX, MPC_OCSC_TEST_DEBUG_DATA,
+						MPC_OCSC_TEST_DEBUG_DATA_OCSC_MODE_IDX);
+
+	if (cur_mode != MPC_OUTPUT_CSC_COEF_A)
+		ocsc_mode = MPC_OUTPUT_CSC_COEF_A;
+	else
+		ocsc_mode = MPC_OUTPUT_CSC_COEF_B;
+
 	ocsc_regs.shifts.csc_c11 = mpc20->mpc_shift->MPC_OCSC_C11_A;
 	ocsc_regs.masks.csc_c11  = mpc20->mpc_mask->MPC_OCSC_C11_A;
 	ocsc_regs.shifts.csc_c12 = mpc20->mpc_shift->MPC_OCSC_C12_A;
@@ -157,10 +173,13 @@ void mpc2_set_output_csc(
 		ocsc_regs.csc_c11_c12 = REG(CSC_C11_C12_B[opp_id]);
 		ocsc_regs.csc_c33_c34 = REG(CSC_C33_C34_B[opp_id]);
 	}
+
 	cm_helper_program_color_matrices(
 			mpc20->base.ctx,
 			regval,
 			&ocsc_regs);
+
+	REG_SET(CSC_MODE[opp_id], 0, MPC_OCSC_MODE, ocsc_mode);
 }
 
 void mpc2_set_ocsc_default(
@@ -169,14 +188,16 @@ void mpc2_set_ocsc_default(
 		enum dc_color_space color_space,
 		enum mpc_output_csc_mode ocsc_mode)
 {
+	uint32_t cur_mode;
 	struct dcn20_mpc *mpc20 = TO_DCN20_MPC(mpc);
 	uint32_t arr_size;
 	struct color_matrices_reg ocsc_regs;
 	const uint16_t *regval = NULL;
 
-	REG_SET(CSC_MODE[opp_id], 0, MPC_OCSC_MODE, ocsc_mode);
-	if (ocsc_mode == MPC_OUTPUT_CSC_DISABLE)
+	if (ocsc_mode == MPC_OUTPUT_CSC_DISABLE) {
+		REG_SET(CSC_MODE[opp_id], 0, MPC_OCSC_MODE, ocsc_mode);
 		return;
+	}
 
 	regval = find_color_matrix(color_space, &arr_size);
 
@@ -185,6 +206,18 @@ void mpc2_set_ocsc_default(
 		return;
 	}
 
+	/* determine which CSC coefficients (A or B) we are using
+	 * currently.  select the alternate set to double buffer
+	 * the CSC update so CSC is updated on frame boundary
+	 */
+	cur_mode = IX_REG_READ(MPC_OCSC_TEST_DEBUG_INDEX, MPC_OCSC_TEST_DEBUG_DATA,
+						MPC_OCSC_TEST_DEBUG_DATA_OCSC_MODE_IDX);
+
+	if (cur_mode != MPC_OUTPUT_CSC_COEF_A)
+		ocsc_mode = MPC_OUTPUT_CSC_COEF_A;
+	else
+		ocsc_mode = MPC_OUTPUT_CSC_COEF_B;
+
 	ocsc_regs.shifts.csc_c11 = mpc20->mpc_shift->MPC_OCSC_C11_A;
 	ocsc_regs.masks.csc_c11  = mpc20->mpc_mask->MPC_OCSC_C11_A;
 	ocsc_regs.shifts.csc_c12 = mpc20->mpc_shift->MPC_OCSC_C12_A;
@@ -203,6 +236,8 @@ void mpc2_set_ocsc_default(
 			mpc20->base.ctx,
 			regval,
 			&ocsc_regs);
+
+	REG_SET(CSC_MODE[opp_id], 0, MPC_OCSC_MODE, ocsc_mode);
 }
 
 static void mpc2_ogam_get_reg_field(
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.h
index 9f53192da2dc..8c77e78e2df5 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.h
@@ -80,6 +80,10 @@
 	SRII(DENORM_CLAMP_G_Y, MPC_OUT, inst),\
 	SRII(DENORM_CLAMP_B_CB, MPC_OUT, inst)
 
+#define MPC_DBG_REG_LIST_DCN2_0() \
+	SR(MPC_OCSC_TEST_DEBUG_DATA),\
+	SR(MPC_OCSC_TEST_DEBUG_INDEX)
+
 #define MPC_REG_VARIABLE_LIST_DCN2_0 \
 	MPC_COMMON_REG_VARIABLE_LIST \
 	uint32_t MPCC_TOP_GAIN[MAX_MPCC]; \
@@ -118,6 +122,8 @@
 	uint32_t MPCC_OGAM_LUT_RAM_CONTROL[MAX_MPCC];\
 	uint32_t MPCC_OGAM_LUT_DATA[MAX_MPCC];\
 	uint32_t MPCC_OGAM_MODE[MAX_MPCC];\
+	uint32_t MPC_OCSC_TEST_DEBUG_DATA;\
+	uint32_t MPC_OCSC_TEST_DEBUG_INDEX;\
 	uint32_t CSC_MODE[MAX_OPP]; \
 	uint32_t CSC_C11_C12_A[MAX_OPP]; \
 	uint32_t CSC_C33_C34_A[MAX_OPP]; \
@@ -134,6 +140,8 @@
 	SF(MPCC0_MPCC_TOP_GAIN, MPCC_TOP_GAIN, mask_sh),\
 	SF(MPCC0_MPCC_BOT_GAIN_INSIDE, MPCC_BOT_GAIN_INSIDE, mask_sh),\
 	SF(MPCC0_MPCC_BOT_GAIN_OUTSIDE, MPCC_BOT_GAIN_OUTSIDE, mask_sh),\
+	SF(MPC_OCSC_TEST_DEBUG_DATA, MPC_OCSC_TEST_DEBUG_DATA, mask_sh),\
+	SF(MPC_OCSC_TEST_DEBUG_INDEX, MPC_OCSC_TEST_DEBUG_INDEX, mask_sh),\
 	SF(MPC_OUT0_CSC_MODE, MPC_OCSC_MODE, mask_sh),\
 	SF(MPC_OUT0_CSC_C11_C12_A, MPC_OCSC_C11_A, mask_sh),\
 	SF(MPC_OUT0_CSC_C11_C12_A, MPC_OCSC_C12_A, mask_sh),\
@@ -174,6 +182,12 @@
 	SF(MPC_OUT0_DENORM_CLAMP_B_CB, MPC_OUT_DENORM_CLAMP_MAX_B_CB, mask_sh),\
 	SF(MPC_OUT0_DENORM_CLAMP_B_CB, MPC_OUT_DENORM_CLAMP_MIN_B_CB, mask_sh)
 
+/*
+ *	DCN2 MPC_OCSC debug status register:
+ *
+ *		Field describing current OCSC Mode has index 1 [1..0]
+ */
+#define MPC_OCSC_TEST_DEBUG_DATA_OCSC_MODE_IDX 1
 
 #define MPC_REG_FIELD_LIST_DCN2_0(type) \
 	MPC_REG_FIELD_LIST(type)\
@@ -182,6 +196,8 @@
 	type MPCC_TOP_GAIN;\
 	type MPCC_BOT_GAIN_INSIDE;\
 	type MPCC_BOT_GAIN_OUTSIDE;\
+	type MPC_OCSC_TEST_DEBUG_DATA;\
+	type MPC_OCSC_TEST_DEBUG_INDEX;\
 	type MPC_OCSC_MODE;\
 	type MPC_OCSC_C11_A;\
 	type MPC_OCSC_C12_A;\
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index b715ecc1b5e6..a05746142ec8 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -706,6 +706,7 @@ static const struct dcn20_mpc_registers mpc_regs = {
 		MPC_OUT_MUX_REG_LIST_DCN2_0(3),
 		MPC_OUT_MUX_REG_LIST_DCN2_0(4),
 		MPC_OUT_MUX_REG_LIST_DCN2_0(5),
+		MPC_DBG_REG_LIST_DCN2_0()
 };
 
 static const struct dcn20_mpc_shift mpc_shift = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index c76449f58064..5a6e7ac5f785 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -465,7 +465,8 @@ static const struct dcn20_mpc_registers mpc_regs = {
 		MPC_OUT_MUX_REG_LIST_DCN2_0(0),
 		MPC_OUT_MUX_REG_LIST_DCN2_0(1),
 		MPC_OUT_MUX_REG_LIST_DCN2_0(2),
-		MPC_OUT_MUX_REG_LIST_DCN2_0(3)
+		MPC_OUT_MUX_REG_LIST_DCN2_0(3),
+		MPC_DBG_REG_LIST_DCN2_0()
 };
 
 static const struct dcn20_mpc_shift mpc_shift = {
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
