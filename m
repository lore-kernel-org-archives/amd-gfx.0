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
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF4FC3F68F
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:47:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C38FF20838
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="E8XJlSjq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C38FF20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BCDD6EA47;
	Fri, 10 Jan 2020 14:47:45 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D7326EA46
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 14:47:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F73vI5c6GVIUuvNwfKXhAPOL1X9+mcapjJ7h5AbVEDKPOnPV7EWwqzdJkiKWuObHfVIrvjCINMRbPRxiFc6W1rUNjmRV+u+NMt5+5TXeZqmBJlhB8oQm1SsiEh0UR6cBToiRX+msIfDAc0Jr6L0OTHjhwH37LboV2bb7CYJ1U6QP5CSNaf8WJIrSaA1EmJ0O4BTG2GxLKE3nL15lGyJEe0H1tgLlE9vTduGb3WalpkkJEQMEsgh86+gKqPirgG4AcQ0bJbREbRjaOblumBzwA55A7mGOnzdXS1Jk8rcI8f4disOVoWgaz9NNEZCiPHGAsAWrxZirbvDQ3G2bZjzYZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=flA5B5MWpsYXd+0zoLVoso8AijXkbS3uftGXYKpYfPE=;
 b=cIYqdCBQb4Wo/RcX8U3eTyRYVGpZCfZtqLX/nOdNdFp2ozyyIO3I3LXO6n/TsO7bd6dx5QouRxc9tqtYIb5NBSx0KeOwWtcULmI1a/+UkDFvNHq8JRXmfCblOmV89LyOKFxGuaX4rLVd+PCB79TjS7W/QebHxA3gfbmD8eekqnCRLQ3GQzFHMo2tqYG8Y0WexdIol249s4I8+tMtBbW5TQBX1GOQreBIUJLCTrssu6DSk4JUbCXiPet32UklkxQe2Qr+Umut+EkHi12KL41vooKC3TRgF5gMcq4xXvqfQsrVsXF20BrJleBYEped0Ah34QhorEqAVW6WEoyJWXnopg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=flA5B5MWpsYXd+0zoLVoso8AijXkbS3uftGXYKpYfPE=;
 b=E8XJlSjqgl66FkoeLTv4g9I9zZB35Y692T9h+7o4Trjejr0WOCgLAdlHyYdZXU4xkKullHcI5hYbwkpoeDDWBTVBD57fT0xIUi4TEWftktz2lsYGKf4tSm4spO02D5d9AaWPd/tK95zKyGimfLRl3mY9SwuaSjLCS2uOThtt818=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.11; Fri, 10 Jan 2020 14:47:42 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::699c:a877:13ef:6ae2]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::699c:a877:13ef:6ae2%6]) with mapi id 15.20.2623.011; Fri, 10 Jan 2020
 14:47:42 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 24/43] drm/amd/display: Indirect reg read macro with shift and
 mask
Date: Fri, 10 Jan 2020 09:46:36 -0500
Message-Id: <20200110144655.55845-25-Rodrigo.Siqueira@amd.com>
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
 15.20.2623.8 via Frontend Transport; Fri, 10 Jan 2020 14:47:41 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f3866e79-a292-4cf6-99cf-08d795dc0bcd
X-MS-TrafficTypeDiagnostic: MW2PR12MB2524:|MW2PR12MB2524:
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2524E968AC8ABFCE2557604A98380@MW2PR12MB2524.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 02788FF38E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(189003)(199004)(8936002)(30864003)(5660300002)(6916009)(54906003)(81156014)(6486002)(81166006)(36756003)(316002)(1076003)(2906002)(6666004)(956004)(7696005)(52116002)(478600001)(186003)(2616005)(86362001)(26005)(16526019)(66556008)(8676002)(66476007)(4326008)(66946007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2524;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q/hV64diLANfbj+JHYdV52equtsc6vegOPiEfpRpiS33mFhYa095iSnxVd0O4DvL8djyQOX7tyguRU5UBiIHcmYRtpDrwp6gEzdSfwXsmlfNqAMCuXWinqbIxjYImBo8AzVFXDXijK11EluQDwz4EOLLFBG/bRvqhcNqVc4vt184zLmw8bU4wmQJ8Ka48o3s0y7sXEZ2YGRJspITbgDEPDa7t9tw3bOWijN7O18FctftNasd9ghQ3pcp657II6wivFrqCjb/XhZzNUx9SMWjYYtd2EWkVnUpr1Bo9RDW8V5pEEqjgFE6UxZEAHzySJB4eiB+Evs30W5iBx9RVY4DmMEVuig0kxHa5axOEklzlMtvKvKmq2PRU29e53uKddtzeeF8Idz1CfBxw++XFJVM5ACi4zPorxhT9ySnG1OL4nJmQ1Q4gSDxyCO1n/yFr02G
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3866e79-a292-4cf6-99cf-08d795dc0bcd
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2020 14:47:42.1640 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u4ow6DTI17AC1QgK5T5jOfjTKsFeag8ft2yvySyJIT5K1wsNMIKzGU6vXf8aJlO236orxf16PPfySHqftk9ujw==
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
Recent double buffering changes for dcn2 use IX_REG_READ.
However, this macro returns the full register value, with the need to
manually shift and mask it to retrieve field data.

[How]
Create new IX_REG_GET macro that handles shift and mask.
Use this for double buffering reads instead of IX_REG_READ.

Signed-off-by: Noah Abradjian <noah.abradjian@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_helper.c    | 30 +++++++++++++++++++
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dpp.h  | 16 +++++++---
 .../drm/amd/display/dc/dcn20/dcn20_dpp_cm.c   | 18 ++++-------
 .../gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c  | 16 ++++------
 .../gpu/drm/amd/display/dc/dcn20/dcn20_mpc.h  | 10 +++++--
 .../drm/amd/display/dc/dcn20/dcn20_resource.c | 10 ++++---
 .../drm/amd/display/dc/dcn21/dcn21_resource.c | 10 ++++---
 .../gpu/drm/amd/display/dc/inc/reg_helper.h   | 13 ++++++++
 8 files changed, 86 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_helper.c b/drivers/gpu/drm/amd/display/dc/dc_helper.c
index 02a63e9cb62f..737048d8a96c 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_helper.c
@@ -552,6 +552,36 @@ uint32_t generic_read_indirect_reg(const struct dc_context *ctx,
 	return value;
 }
 
+uint32_t generic_indirect_reg_get(const struct dc_context *ctx,
+		uint32_t addr_index, uint32_t addr_data,
+		uint32_t index, int n,
+		uint8_t shift1, uint32_t mask1, uint32_t *field_value1,
+		...)
+{
+	uint32_t shift, mask, *field_value;
+	uint32_t value = 0;
+	int i = 1;
+
+	va_list ap;
+
+	va_start(ap, field_value1);
+
+	value = generic_read_indirect_reg(ctx, addr_index, addr_data, index);
+	*field_value1 = get_reg_field_value_ex(value, mask1, shift1);
+
+	while (i < n) {
+		shift = va_arg(ap, uint32_t);
+		mask = va_arg(ap, uint32_t);
+		field_value = va_arg(ap, uint32_t *);
+
+		*field_value = get_reg_field_value_ex(value, mask, shift);
+		i++;
+	}
+
+	va_end(ap);
+
+	return value;
+}
 
 uint32_t generic_indirect_reg_update_ex(const struct dc_context *ctx,
 		uint32_t addr_index, uint32_t addr_data,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.h
index 141dea963db9..27610251c57f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.h
@@ -589,14 +589,22 @@
  *			Gamut Remap Mode: [10..9]
  */
 #define CM_TEST_DEBUG_DATA_STATUS_IDX 9
-#define CM_TEST_DEBUG_DATA_ICSC_MODE_SH 3
-#define CM_TEST_DEBUG_DATA_ICSC_MODE_MASK 0x3
-#define CM_TEST_DEBUG_DATA_GAMUT_REMAP_MODE_SH 9
-#define CM_TEST_DEBUG_DATA_GAMUT_REMAP_MODE_MASK 0x3
+
+#define TF_DEBUG_REG_LIST_SH_DCN20 \
+	TF_DEBUG_REG_LIST_SH_DCN10, \
+	.CM_TEST_DEBUG_DATA_ICSC_MODE = 3, \
+	.CM_TEST_DEBUG_DATA_GAMUT_REMAP_MODE = 9
+
+#define TF_DEBUG_REG_LIST_MASK_DCN20 \
+	TF_DEBUG_REG_LIST_MASK_DCN10, \
+	.CM_TEST_DEBUG_DATA_ICSC_MODE = 0x18, \
+	.CM_TEST_DEBUG_DATA_GAMUT_REMAP_MODE = 0x600
 
 #define TF_REG_FIELD_LIST_DCN2_0(type) \
 	TF_REG_FIELD_LIST(type) \
 	type CM_BLNDGAM_LUT_DATA; \
+	type CM_TEST_DEBUG_DATA_ICSC_MODE; \
+	type CM_TEST_DEBUG_DATA_GAMUT_REMAP_MODE; \
 	type FORMAT_CNV16; \
 	type CNVC_BYPASS_MSB_ALIGN; \
 	type CLAMP_POSITIVE; \
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp_cm.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp_cm.c
index 4047d406a74c..8dc3d1f73984 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp_cm.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp_cm.c
@@ -176,12 +176,9 @@ static void program_gamut_remap(
 	 * currently. select the alternate set to double buffer
 	 * the update so gamut_remap is updated on frame boundary
 	 */
-	cur_select = IX_REG_READ(CM_TEST_DEBUG_INDEX, CM_TEST_DEBUG_DATA,
-					CM_TEST_DEBUG_DATA_STATUS_IDX);
-
-	/* IX_REG_READ reads whole reg, so isolate part we want [10..9] */
-	cur_select = (cur_select >> CM_TEST_DEBUG_DATA_GAMUT_REMAP_MODE_SH)
-					& CM_TEST_DEBUG_DATA_GAMUT_REMAP_MODE_MASK;
+	IX_REG_GET(CM_TEST_DEBUG_INDEX, CM_TEST_DEBUG_DATA,
+					CM_TEST_DEBUG_DATA_STATUS_IDX,
+					CM_TEST_DEBUG_DATA_GAMUT_REMAP_MODE, &cur_select);
 
 	/* value stored in dbg reg will be 1 greater than mode we want */
 	if (cur_select != DCN2_GAMUT_REMAP_COEF_A)
@@ -275,12 +272,9 @@ void dpp2_program_input_csc(
 	 * currently.  select the alternate set to double buffer
 	 * the CSC update so CSC is updated on frame boundary
 	 */
-	cur_select = IX_REG_READ(CM_TEST_DEBUG_INDEX, CM_TEST_DEBUG_DATA,
-					CM_TEST_DEBUG_DATA_STATUS_IDX);
-
-	/* IX_REG_READ reads whole reg, so isolate part we want [4..3] */
-	cur_select = (cur_select >> CM_TEST_DEBUG_DATA_ICSC_MODE_SH)
-					& CM_TEST_DEBUG_DATA_ICSC_MODE_MASK;
+	IX_REG_GET(CM_TEST_DEBUG_INDEX, CM_TEST_DEBUG_DATA,
+					CM_TEST_DEBUG_DATA_STATUS_IDX,
+					CM_TEST_DEBUG_DATA_ICSC_MODE, &cur_select);
 
 	if (cur_select != DCN2_ICSC_SELECT_ICSC_A)
 		select = DCN2_ICSC_SELECT_ICSC_A;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c
index ce95e7db4814..de9c857ab3e9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c
@@ -153,11 +153,9 @@ void mpc2_set_output_csc(
 	 * currently.  select the alternate set to double buffer
 	 * the CSC update so CSC is updated on frame boundary
 	 */
-	cur_mode = IX_REG_READ(MPC_OCSC_TEST_DEBUG_INDEX, MPC_OCSC_TEST_DEBUG_DATA,
-						MPC_OCSC_TEST_DEBUG_DATA_STATUS_IDX);
-
-	/* Isolate part of reg data we want [1..0] */
-	cur_mode = cur_mode & MPC_OCSC_TEST_DEBUG_DATA_OCSC_MODE_MASK;
+	IX_REG_GET(MPC_OCSC_TEST_DEBUG_INDEX, MPC_OCSC_TEST_DEBUG_DATA,
+						MPC_OCSC_TEST_DEBUG_DATA_STATUS_IDX,
+						MPC_OCSC_TEST_DEBUG_DATA_OCSC_MODE, &cur_mode);
 
 	if (cur_mode != MPC_OUTPUT_CSC_COEF_A)
 		ocsc_mode = MPC_OUTPUT_CSC_COEF_A;
@@ -213,11 +211,9 @@ void mpc2_set_ocsc_default(
 	 * currently.  select the alternate set to double buffer
 	 * the CSC update so CSC is updated on frame boundary
 	 */
-	cur_mode = IX_REG_READ(MPC_OCSC_TEST_DEBUG_INDEX, MPC_OCSC_TEST_DEBUG_DATA,
-						MPC_OCSC_TEST_DEBUG_DATA_STATUS_IDX);
-
-	/* Isolate part of reg data we want [1..0] */
-	cur_mode = cur_mode & MPC_OCSC_TEST_DEBUG_DATA_OCSC_MODE_MASK;
+	IX_REG_GET(MPC_OCSC_TEST_DEBUG_INDEX, MPC_OCSC_TEST_DEBUG_DATA,
+						MPC_OCSC_TEST_DEBUG_DATA_STATUS_IDX,
+						MPC_OCSC_TEST_DEBUG_DATA_OCSC_MODE, &cur_mode);
 
 	if (cur_mode != MPC_OUTPUT_CSC_COEF_A)
 		ocsc_mode = MPC_OUTPUT_CSC_COEF_A;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.h
index 950e6f9cd23e..c78fd5123497 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.h
@@ -140,7 +140,6 @@
 	SF(MPCC0_MPCC_TOP_GAIN, MPCC_TOP_GAIN, mask_sh),\
 	SF(MPCC0_MPCC_BOT_GAIN_INSIDE, MPCC_BOT_GAIN_INSIDE, mask_sh),\
 	SF(MPCC0_MPCC_BOT_GAIN_OUTSIDE, MPCC_BOT_GAIN_OUTSIDE, mask_sh),\
-	SF(MPC_OCSC_TEST_DEBUG_DATA, MPC_OCSC_TEST_DEBUG_DATA, mask_sh),\
 	SF(MPC_OCSC_TEST_DEBUG_INDEX, MPC_OCSC_TEST_DEBUG_INDEX, mask_sh),\
 	SF(MPC_OUT0_CSC_MODE, MPC_OCSC_MODE, mask_sh),\
 	SF(MPC_OUT0_CSC_C11_C12_A, MPC_OCSC_C11_A, mask_sh),\
@@ -189,7 +188,12 @@
  *			OCSC Mode: [1..0]
  */
 #define MPC_OCSC_TEST_DEBUG_DATA_STATUS_IDX 1
-#define MPC_OCSC_TEST_DEBUG_DATA_OCSC_MODE_MASK 0x3
+
+#define MPC_DEBUG_REG_LIST_SH_DCN20 \
+	.MPC_OCSC_TEST_DEBUG_DATA_OCSC_MODE = 0
+
+#define MPC_DEBUG_REG_LIST_MASK_DCN20 \
+	.MPC_OCSC_TEST_DEBUG_DATA_OCSC_MODE = 0x3
 
 #define MPC_REG_FIELD_LIST_DCN2_0(type) \
 	MPC_REG_FIELD_LIST(type)\
@@ -198,7 +202,7 @@
 	type MPCC_TOP_GAIN;\
 	type MPCC_BOT_GAIN_INSIDE;\
 	type MPCC_BOT_GAIN_OUTSIDE;\
-	type MPC_OCSC_TEST_DEBUG_DATA;\
+	type MPC_OCSC_TEST_DEBUG_DATA_OCSC_MODE;\
 	type MPC_OCSC_TEST_DEBUG_INDEX;\
 	type MPC_OCSC_MODE;\
 	type MPC_OCSC_C11_A;\
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 2ef6d0e2b0ed..85f90f3e24cb 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -652,12 +652,12 @@ static const struct dcn2_dpp_registers tf_regs[] = {
 
 static const struct dcn2_dpp_shift tf_shift = {
 		TF_REG_LIST_SH_MASK_DCN20(__SHIFT),
-		TF_DEBUG_REG_LIST_SH_DCN10
+		TF_DEBUG_REG_LIST_SH_DCN20
 };
 
 static const struct dcn2_dpp_mask tf_mask = {
 		TF_REG_LIST_SH_MASK_DCN20(_MASK),
-		TF_DEBUG_REG_LIST_MASK_DCN10
+		TF_DEBUG_REG_LIST_MASK_DCN20
 };
 
 #define dwbc_regs_dcn2(id)\
@@ -711,11 +711,13 @@ static const struct dcn20_mpc_registers mpc_regs = {
 };
 
 static const struct dcn20_mpc_shift mpc_shift = {
-	MPC_COMMON_MASK_SH_LIST_DCN2_0(__SHIFT)
+	MPC_COMMON_MASK_SH_LIST_DCN2_0(__SHIFT),
+	MPC_DEBUG_REG_LIST_SH_DCN20
 };
 
 static const struct dcn20_mpc_mask mpc_mask = {
-	MPC_COMMON_MASK_SH_LIST_DCN2_0(_MASK)
+	MPC_COMMON_MASK_SH_LIST_DCN2_0(_MASK),
+	MPC_DEBUG_REG_LIST_MASK_DCN20
 };
 
 #define tg_regs(id)\
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index 0dd724de201a..f1ec3448c0c0 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -471,11 +471,13 @@ static const struct dcn20_mpc_registers mpc_regs = {
 };
 
 static const struct dcn20_mpc_shift mpc_shift = {
-	MPC_COMMON_MASK_SH_LIST_DCN2_0(__SHIFT)
+	MPC_COMMON_MASK_SH_LIST_DCN2_0(__SHIFT),
+	MPC_DEBUG_REG_LIST_SH_DCN20
 };
 
 static const struct dcn20_mpc_mask mpc_mask = {
-	MPC_COMMON_MASK_SH_LIST_DCN2_0(_MASK)
+	MPC_COMMON_MASK_SH_LIST_DCN2_0(_MASK),
+	MPC_DEBUG_REG_LIST_MASK_DCN20
 };
 
 #define hubp_regs(id)\
@@ -622,12 +624,12 @@ static const struct dcn2_dpp_registers tf_regs[] = {
 
 static const struct dcn2_dpp_shift tf_shift = {
 		TF_REG_LIST_SH_MASK_DCN20(__SHIFT),
-		TF_DEBUG_REG_LIST_SH_DCN10
+		TF_DEBUG_REG_LIST_SH_DCN20
 };
 
 static const struct dcn2_dpp_mask tf_mask = {
 		TF_REG_LIST_SH_MASK_DCN20(_MASK),
-		TF_DEBUG_REG_LIST_MASK_DCN10
+		TF_DEBUG_REG_LIST_MASK_DCN20
 };
 
 #define stream_enc_regs(id)\
diff --git a/drivers/gpu/drm/amd/display/dc/inc/reg_helper.h b/drivers/gpu/drm/amd/display/dc/inc/reg_helper.h
index 47e307388581..2470405e996b 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/reg_helper.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/reg_helper.h
@@ -458,7 +458,14 @@ uint32_t generic_reg_get8(const struct dc_context *ctx, uint32_t addr,
 #define IX_REG_READ(index_reg_name, data_reg_name, index) \
 		generic_read_indirect_reg(CTX, REG(index_reg_name), REG(data_reg_name), IND_REG(index))
 
+#define IX_REG_GET_N(index_reg_name, data_reg_name, index, n, ...) \
+		generic_indirect_reg_get(CTX, REG(index_reg_name), REG(data_reg_name), \
+				IND_REG(index), \
+				n, __VA_ARGS__)
 
+#define IX_REG_GET(index_reg_name, data_reg_name, index, field, val) \
+		IX_REG_GET_N(index_reg_name, data_reg_name, index, 1, \
+				FN(data_reg_name, field), val)
 
 #define IX_REG_UPDATE_N(index_reg_name, data_reg_name, index, n, ...)	\
 		generic_indirect_reg_update_ex(CTX, \
@@ -479,6 +486,12 @@ uint32_t generic_read_indirect_reg(const struct dc_context *ctx,
 		uint32_t addr_index, uint32_t addr_data,
 		uint32_t index);
 
+uint32_t generic_indirect_reg_get(const struct dc_context *ctx,
+		uint32_t addr_index, uint32_t addr_data,
+		uint32_t index, int n,
+		uint8_t shift1, uint32_t mask1, uint32_t *field_value1,
+		...);
+
 uint32_t generic_indirect_reg_update_ex(const struct dc_context *ctx,
 		uint32_t addr_index, uint32_t addr_data,
 		uint32_t index, uint32_t reg_val, int n,
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
