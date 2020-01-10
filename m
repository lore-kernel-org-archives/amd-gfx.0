Return-Path: <SRS0=i8pd=27=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD4EC33CA5
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:47:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7198D2082E
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="sLRME/Dr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7198D2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10FDD6EA41;
	Fri, 10 Jan 2020 14:47:44 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FB0A6EA44
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 14:47:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fwjXbU7Gm5QwJXwctJaj9/rV0QWscfhEzZRfNKC+Gou3WCuXOu8atnLMfbYb1ePhORlcSGJ7od/i4o04EB1Vj5ZFyFNFv1i8enuN8InnWB8XFRKmlYBKuvUMHUOeTJyDz32iNEebQ93xacfxn3YI2XZLTp8uay0moPgUOdXl/SmyBCtVrp6VY6Z3NDCrbprC+0/cNRGpkjTSMGoyV/YszH1wBR2FW/VrOOmLCUVwSzgFgYr7f4R0OHhs/MOZ420C8jXSAHlWfAD0gPhC7wjV3gc5nJmtjW+Q+Tua0pbYgpyOmHjcDwxE8ECUAakZtyKNOIKxsnEQNVeZ4cGpDbZ7mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vBRIii3kSPSLvxCtHSadpfxXe2VrUhg5kPZRHAatQ24=;
 b=E/eNCMh8Bo9qxy0mgq5vqNLI1pAiib9feW9Ua5dz5e1Rn819CtRWW6cMM/tGhE+E4lUqUOaziYUpFPxrinFUrOITDkUrP7ntAtv05HhPOYGyZoUjtHHkm8L29bi6531auQCQDmyN/owO/rOgUTlG0F5eG4hK4sLdssbaLbIQBHO82IF12QhLKpGwdEFnk5MRl/6r6od7B6gdIvY8C/g1aGCH+Cmr5v7khvWP2UAPM+1l3CNllVgUn4qDTqLU3evE0voAdmVDLmP0QqfXaHNPMagCSnkEvktbIVd66UTHZbHMDT7rKrD2nqu1bH1TWua9YrD+be0Iu0grQ7RkFDLigQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vBRIii3kSPSLvxCtHSadpfxXe2VrUhg5kPZRHAatQ24=;
 b=sLRME/DrGvLOBw4t8QpkQJV/4nqRtVc1/fp9hoJR8cP0V1DUfnXMoFi9SRIjpmly2DWc2yvMuMRf5fbVP0Z/7VjQPn25hOWNnhmLygsobqT/Od2NLRUjmv0jbccykVA5GyZjf3RE6XPmaeQezU0fx4UJbc+R5F6sd6bUD8TqHfc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.11; Fri, 10 Jan 2020 14:47:39 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::699c:a877:13ef:6ae2]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::699c:a877:13ef:6ae2%6]) with mapi id 15.20.2623.011; Fri, 10 Jan 2020
 14:47:39 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 21/43] drm/amd/display: Double buffer dcn2 Gamut Remap
Date: Fri, 10 Jan 2020 09:46:33 -0500
Message-Id: <20200110144655.55845-22-Rodrigo.Siqueira@amd.com>
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
 15.20.2623.8 via Frontend Transport; Fri, 10 Jan 2020 14:47:38 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4345dbcf-1485-49e7-15ef-08d795dc0a1f
X-MS-TrafficTypeDiagnostic: MW2PR12MB2524:|MW2PR12MB2524:
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB252498293F9109FFD66A752A98380@MW2PR12MB2524.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 02788FF38E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(189003)(199004)(8936002)(5660300002)(6916009)(54906003)(81156014)(6486002)(81166006)(36756003)(316002)(1076003)(2906002)(6666004)(956004)(7696005)(52116002)(478600001)(186003)(2616005)(86362001)(26005)(16526019)(66556008)(8676002)(66476007)(4326008)(66946007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2524;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h80E48GJHPe09sJTt0KepSI/Ce1OtdHFntM+Ol15/274TPhGIC/XtPw7nUNKMqCCK3RnSoVSsee3brbEP019Q1WoOq+EPkaSAHiK9MruhKChYP9n4BfGSgtlZKf7NMHPI+LSU3tOPopAtBRTsDMynR7iLOrHA7vbxlXBb6AIN+NHnyGclJ6RA6ccSLzqZ9BMbeXqoAPhdH/JjqkbzdzuOE4+TV4b8lfZ+1pMNmM9A41xlK8Dhcwbty9KR55EcYxAyEVJ/zXw5xRXvl9umMkvzlEqPqs5jGonr1BIpVMjxLTrRfuFXtgQ0kegLK1qbLcVXGnr+/0K1UfvElEMXxPwACFjMcIeHLX+pYsBZ+9DdzcV/YN54kdK5PnMBCgQltG0g2Z8maNjp8kuanO2w0DS2EMXm0E3NT3rVvae5bg362qwERXEhHHTdSSnr6ENID5F
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4345dbcf-1485-49e7-15ef-08d795dc0a1f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2020 14:47:39.3616 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hedb8vR6dEI7c5bS4eIxgZUYrbyAK9OZO1VK28K/rJkLlzD00W9+3cOCo3Y9UNO5eulyS+lMmopKgq9GjC5HjA==
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
When rapidly adjusting color temperature, screen tearing was observed.
This was due to overwritten values in gamut remap registers.
This issue was solved for OCSC and ICSC by alternating between "A" and
"B" registers to double buffer the writes.

[How]
Create new set_gamut_remap and program_gamut_remap for dcn20.
Alternate which registers are written to by switching modes each time.
Also fixes ICSC mode reg read to use proper data offset.

Signed-off-by: Noah Abradjian <noah.abradjian@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c  |  2 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dpp.h  | 29 ++++++-
 .../drm/amd/display/dc/dcn20/dcn20_dpp_cm.c   | 84 ++++++++++++++++++-
 3 files changed, 109 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c
index bbdab5000a7c..13e057d7ee93 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c
@@ -458,7 +458,7 @@ static struct dpp_funcs dcn20_dpp_funcs = {
 	.dpp_reset = dpp_reset,
 	.dpp_set_scaler = dpp1_dscl_set_scaler_manual_scale,
 	.dpp_get_optimal_number_of_taps = dpp1_get_optimal_number_of_taps,
-	.dpp_set_gamut_remap = dpp1_cm_set_gamut_remap,
+	.dpp_set_gamut_remap = dpp2_cm_set_gamut_remap,
 	.dpp_set_csc_adjustment = NULL,
 	.dpp_set_csc_default = NULL,
 	.dpp_program_regamma_pwl = oppn20_dummy_program_regamma_pwl,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.h
index d9ce60b6aa6e..141dea963db9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.h
@@ -151,6 +151,12 @@
 	SRI(CM_SHAPER_LUT_INDEX, CM, id)
 
 #define TF_REG_LIST_DCN20_COMMON_APPEND(id) \
+	SRI(CM_GAMUT_REMAP_B_C11_C12, CM, id),\
+	SRI(CM_GAMUT_REMAP_B_C13_C14, CM, id),\
+	SRI(CM_GAMUT_REMAP_B_C21_C22, CM, id),\
+	SRI(CM_GAMUT_REMAP_B_C23_C24, CM, id),\
+	SRI(CM_GAMUT_REMAP_B_C31_C32, CM, id),\
+	SRI(CM_GAMUT_REMAP_B_C33_C34, CM, id),\
 	SRI(CM_ICSC_B_C11_C12, CM, id), \
 	SRI(CM_ICSC_B_C33_C34, CM, id)
 
@@ -579,11 +585,14 @@
 /* DPP CM debug status register:
  *
  *		Status index including current ICSC, Gamut Remap Mode is 9
- *			ICSC Mode: [5..4]
+ *			ICSC Mode: [4..3]
+ *			Gamut Remap Mode: [10..9]
  */
 #define CM_TEST_DEBUG_DATA_STATUS_IDX 9
-#define CM_TEST_DEBUG_DATA_ICSC_MODE_SH 4
+#define CM_TEST_DEBUG_DATA_ICSC_MODE_SH 3
 #define CM_TEST_DEBUG_DATA_ICSC_MODE_MASK 0x3
+#define CM_TEST_DEBUG_DATA_GAMUT_REMAP_MODE_SH 9
+#define CM_TEST_DEBUG_DATA_GAMUT_REMAP_MODE_MASK 0x3
 
 #define TF_REG_FIELD_LIST_DCN2_0(type) \
 	TF_REG_FIELD_LIST(type) \
@@ -646,6 +655,12 @@ struct dcn2_dpp_mask {
 	uint32_t DSCL_MEM_PWR_CTRL
 
 #define DPP_DCN2_REG_VARIABLE_LIST_CM_APPEND \
+	uint32_t CM_GAMUT_REMAP_B_C11_C12; \
+	uint32_t CM_GAMUT_REMAP_B_C13_C14; \
+	uint32_t CM_GAMUT_REMAP_B_C21_C22; \
+	uint32_t CM_GAMUT_REMAP_B_C23_C24; \
+	uint32_t CM_GAMUT_REMAP_B_C31_C32; \
+	uint32_t CM_GAMUT_REMAP_B_C33_C34; \
 	uint32_t CM_ICSC_B_C11_C12; \
 	uint32_t CM_ICSC_B_C33_C34
 
@@ -679,6 +694,12 @@ enum dcn20_input_csc_select {
 	DCN2_ICSC_SELECT_ICSC_B = 2
 };
 
+enum dcn20_gamut_remap_select {
+	DCN2_GAMUT_REMAP_BYPASS = 0,
+	DCN2_GAMUT_REMAP_COEF_A = 1,
+	DCN2_GAMUT_REMAP_COEF_B = 2
+};
+
 void dpp20_read_state(struct dpp *dpp_base,
 		struct dcn_dpp_state *s);
 
@@ -690,6 +711,10 @@ void dpp2_set_degamma(
 		struct dpp *dpp_base,
 		enum ipp_degamma_mode mode);
 
+void dpp2_cm_set_gamut_remap(
+	struct dpp *dpp_base,
+	const struct dpp_grph_csc_adjustment *adjust);
+
 void dpp2_program_input_csc(
 		struct dpp *dpp_base,
 		enum dc_color_space color_space,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp_cm.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp_cm.c
index 423f3daa177f..4047d406a74c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp_cm.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp_cm.c
@@ -158,6 +158,85 @@ void dpp2_set_degamma(
 	}
 }
 
+static void program_gamut_remap(
+		struct dcn20_dpp *dpp,
+		const uint16_t *regval,
+		enum dcn20_gamut_remap_select select)
+{
+	uint32_t cur_select = 0;
+	struct color_matrices_reg gam_regs;
+
+	if (regval == NULL || select == DCN2_GAMUT_REMAP_BYPASS) {
+		REG_SET(CM_GAMUT_REMAP_CONTROL, 0,
+				CM_GAMUT_REMAP_MODE, 0);
+		return;
+	}
+
+	/* determine which gamut_remap coefficients (A or B) we are using
+	 * currently. select the alternate set to double buffer
+	 * the update so gamut_remap is updated on frame boundary
+	 */
+	cur_select = IX_REG_READ(CM_TEST_DEBUG_INDEX, CM_TEST_DEBUG_DATA,
+					CM_TEST_DEBUG_DATA_STATUS_IDX);
+
+	/* IX_REG_READ reads whole reg, so isolate part we want [10..9] */
+	cur_select = (cur_select >> CM_TEST_DEBUG_DATA_GAMUT_REMAP_MODE_SH)
+					& CM_TEST_DEBUG_DATA_GAMUT_REMAP_MODE_MASK;
+
+	/* value stored in dbg reg will be 1 greater than mode we want */
+	if (cur_select != DCN2_GAMUT_REMAP_COEF_A)
+		select = DCN2_GAMUT_REMAP_COEF_A;
+	else
+		select = DCN2_GAMUT_REMAP_COEF_B;
+
+	gam_regs.shifts.csc_c11 = dpp->tf_shift->CM_GAMUT_REMAP_C11;
+	gam_regs.masks.csc_c11  = dpp->tf_mask->CM_GAMUT_REMAP_C11;
+	gam_regs.shifts.csc_c12 = dpp->tf_shift->CM_GAMUT_REMAP_C12;
+	gam_regs.masks.csc_c12 = dpp->tf_mask->CM_GAMUT_REMAP_C12;
+
+	if (select == DCN2_GAMUT_REMAP_COEF_A) {
+		gam_regs.csc_c11_c12 = REG(CM_GAMUT_REMAP_C11_C12);
+		gam_regs.csc_c33_c34 = REG(CM_GAMUT_REMAP_C33_C34);
+	} else {
+		gam_regs.csc_c11_c12 = REG(CM_GAMUT_REMAP_B_C11_C12);
+		gam_regs.csc_c33_c34 = REG(CM_GAMUT_REMAP_B_C33_C34);
+	}
+
+	cm_helper_program_color_matrices(
+				dpp->base.ctx,
+				regval,
+				&gam_regs);
+
+	REG_SET(
+			CM_GAMUT_REMAP_CONTROL, 0,
+			CM_GAMUT_REMAP_MODE, select);
+
+}
+
+void dpp2_cm_set_gamut_remap(
+	struct dpp *dpp_base,
+	const struct dpp_grph_csc_adjustment *adjust)
+{
+	struct dcn20_dpp *dpp = TO_DCN20_DPP(dpp_base);
+	int i = 0;
+
+	if (adjust->gamut_adjust_type != GRAPHICS_GAMUT_ADJUST_TYPE_SW)
+		/* Bypass if type is bypass or hw */
+		program_gamut_remap(dpp, NULL, DCN2_GAMUT_REMAP_BYPASS);
+	else {
+		struct fixed31_32 arr_matrix[12];
+		uint16_t arr_reg_val[12];
+
+		for (i = 0; i < 12; i++)
+			arr_matrix[i] = adjust->temperature_matrix[i];
+
+		convert_float_matrix(
+			arr_reg_val, arr_matrix, 12);
+
+		program_gamut_remap(dpp, arr_reg_val, DCN2_GAMUT_REMAP_COEF_A);
+	}
+}
+
 void dpp2_program_input_csc(
 		struct dpp *dpp_base,
 		enum dc_color_space color_space,
@@ -199,12 +278,11 @@ void dpp2_program_input_csc(
 	cur_select = IX_REG_READ(CM_TEST_DEBUG_INDEX, CM_TEST_DEBUG_DATA,
 					CM_TEST_DEBUG_DATA_STATUS_IDX);
 
-	/* IX_REG_READ reads whole reg, so isolate part we want [5..4] */
+	/* IX_REG_READ reads whole reg, so isolate part we want [4..3] */
 	cur_select = (cur_select >> CM_TEST_DEBUG_DATA_ICSC_MODE_SH)
 					& CM_TEST_DEBUG_DATA_ICSC_MODE_MASK;
 
-	/* value stored in dbg reg will be 1 greater than mode we want */
-	if (cur_select - 1 != DCN2_ICSC_SELECT_ICSC_A)
+	if (cur_select != DCN2_ICSC_SELECT_ICSC_A)
 		select = DCN2_ICSC_SELECT_ICSC_A;
 	else
 		select = DCN2_ICSC_SELECT_ICSC_B;
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
