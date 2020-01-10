Return-Path: <SRS0=i8pd=27=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D135AC33CA4
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:47:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A45242082E
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qwiHCzZo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A45242082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 665A96EA36;
	Fri, 10 Jan 2020 14:47:42 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FDB06EA41
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 14:47:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQ82SRUPz7jJUzhNKtob1TY+2nlhKuW4jq1gILcQendDRu2YQuUMDFuCXWJvREqhzlh3BYhAHMWUQairCczgE2nonqVx35wQoQPgVfPBJozsw2a9xiejcBNfdgIERPHZUzEawzMNFlG45uFMzRCda74dSH2/W6mCkg/iPFcko2tDK2RXza1QsVuTa2+tH+e15TAWbSCL0fLzgqGypL9rvuygqo0zY2ZGXmJcRUGgrfD45MpRS1a8SDYlL4gpDhbfmrLZzy4C+hX1G3/opNIFi5YX6D7rfMF8dP+jv1DuEwiWeMhSJuiK4sAtlwpItKZ6vyaOLWI/IibsGVvCo7U1Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CHMDXF32KGOP5zAmrg0LV9h3W87auPReUm2EULeC76M=;
 b=V4+aGyyvw+uZ4wxTP8Agq2jw8AIPw/zGIhhRwYAYvd73YNMvs4oZDOEkrpBGGudlnmgzLEITS9ifk6ncP7VtTh4ljdEcr+g+r94MtEqO3GKBU1osKSUwZWyybKdjgUSSQPLWsw4Jd0PlwHKb0sIBmA1f/tPhMkj9JloB6GPeLCafcCoohi6H64F4YXYdf9yUIOhptOk66jaJDozslUzI9kX63wjhHcrOxWGa20oKPkVZyf4ByDqbn6rbkKIkO/42aSpFffUQrc6fln5HKOWP3YARTdQpi2CQEeD5nKGRcYTEkEl0AP5yohokK/J1T2SXbxtzMdcl88kKWkl8Y/0UnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CHMDXF32KGOP5zAmrg0LV9h3W87auPReUm2EULeC76M=;
 b=qwiHCzZoeizRSCyKExO20hAKbmtZ7O5AIB3ALA9BU9IYgIImXpI03XB+6FP97N2DMwUHnGaK8Q3aKLajw/LL6GTHJZbEVIgSemqtlWbs+S5Dvtj1QnJE7g/PJJEis/7/qP9sWtV/qyI92tMcLu10LPmtaIbl3V3mLUaoYI12Ev8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.11; Fri, 10 Jan 2020 14:47:37 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::699c:a877:13ef:6ae2]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::699c:a877:13ef:6ae2%6]) with mapi id 15.20.2623.011; Fri, 10 Jan 2020
 14:47:37 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 19/43] drm/amd/display: Fix double buffering in dcn2 ICSC
Date: Fri, 10 Jan 2020 09:46:31 -0500
Message-Id: <20200110144655.55845-20-Rodrigo.Siqueira@amd.com>
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
 15.20.2623.8 via Frontend Transport; Fri, 10 Jan 2020 14:47:36 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cb637ae6-a670-4bb6-2b25-08d795dc0921
X-MS-TrafficTypeDiagnostic: MW2PR12MB2524:|MW2PR12MB2524:
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB252470376F7BEF0AD4B1BC3698380@MW2PR12MB2524.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
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
X-Microsoft-Antispam-Message-Info: Qw9+jX5f5QCU7ykrmzYRfVFIJ5DN4T6BD6m3DyD7kp1grawZRUaKd+imk9m7CP7XOFnvLI9U+41Hy9rRaNU5iYFBgLiTOeFsRfp+hMqXoTTcMRxkjuTy1u8NBM+ayGZMvnsa4Oaz5xL9O4fHJOc5lqSXqf6YxAQY3ztvSP1erLjcmuiPUXLj74/w41/+eNTIbrG54Yc8RvytdeM9FpHHexsaQT+GKSR5BywTCY/8uuPwX4LAHBg+V6XVHkOwlQPw1NviWZhq0ypUZFsWM2vol4L15BvL326XkH/BPho5dshtidBhht1Hy2czgaMFBp3pkMBIIP8xdxjKz42izpR377ZnKSonsM1oxx+Rae614DT5cyeLUNchw2cOWOwKcTBK3BTbamZyZaJdJruoo6TkQT2Q8MFuemdERu1tNSKoWU4PYhNBcdUU5uKZ+vgD0Y2h
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb637ae6-a670-4bb6-2b25-08d795dc0921
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2020 14:47:37.6196 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /+lXZZXxm/qadsC9AtRtnfGq7fujZQ66OUw8+F9Z6GeemPYcL+lOnWE9MgfgoMNTJBGdX1rhsQ0iPND22RUnGw==
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
When rapidly adjusting video brightness, screen tearing was observed.
This was due to overwritten values in ICSC registers. In dcn10, this issue had been
fixed by implementing double buffering via alternating ICSC modes.
However, the second register set used in dcn1 doesn't exist in dcn2.

[How]
Create new program_input_csc for dcn20.
Use ICSC_B registers instead of COMA registers as second set.

Signed-off-by: Noah Abradjian <noah.abradjian@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../drm/amd/display/dc/dcn10/dcn10_dpp_cm.c   | 20 -----
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c  | 24 +++---
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dpp.h  | 31 ++++++-
 .../drm/amd/display/dc/dcn20/dcn20_dpp_cm.c   | 83 ++++++++++++++++++-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c  | 10 ++-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_mpc.h  |  6 +-
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |  1 +
 .../drm/amd/display/dc/dcn21/dcn21_resource.c |  7 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h   | 20 +++++
 9 files changed, 160 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_cm.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_cm.c
index 935c892622a0..4d3f7d5e1473 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_cm.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_cm.c
@@ -88,26 +88,6 @@ enum dscl_mode_sel {
 	DSCL_MODE_DSCL_BYPASS = 6
 };
 
-static const struct dpp_input_csc_matrix dpp_input_csc_matrix[] = {
-	{COLOR_SPACE_SRGB,
-		{0x2000, 0, 0, 0, 0, 0x2000, 0, 0, 0, 0, 0x2000, 0} },
-	{COLOR_SPACE_SRGB_LIMITED,
-		{0x2000, 0, 0, 0, 0, 0x2000, 0, 0, 0, 0, 0x2000, 0} },
-	{COLOR_SPACE_YCBCR601,
-		{0x2cdd, 0x2000, 0, 0xe991, 0xe926, 0x2000, 0xf4fd, 0x10ef,
-						0, 0x2000, 0x38b4, 0xe3a6} },
-	{COLOR_SPACE_YCBCR601_LIMITED,
-		{0x3353, 0x2568, 0, 0xe400, 0xe5dc, 0x2568, 0xf367, 0x1108,
-						0, 0x2568, 0x40de, 0xdd3a} },
-	{COLOR_SPACE_YCBCR709,
-		{0x3265, 0x2000, 0, 0xe6ce, 0xf105, 0x2000, 0xfa01, 0xa7d, 0,
-						0x2000, 0x3b61, 0xe24f} },
-
-	{COLOR_SPACE_YCBCR709_LIMITED,
-		{0x39a6, 0x2568, 0, 0xe0d6, 0xeedd, 0x2568, 0xf925, 0x9a8, 0,
-						0x2568, 0x43ee, 0xdbb2} }
-};
-
 static void program_gamut_remap(
 		struct dcn10_dpp *dpp,
 		const uint16_t *regval,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c
index 4d7e45892f08..bbdab5000a7c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c
@@ -104,7 +104,7 @@ static void dpp2_cnv_setup (
 	uint32_t pixel_format = 0;
 	uint32_t alpha_en = 1;
 	enum dc_color_space color_space = COLOR_SPACE_SRGB;
-	enum dcn10_input_csc_select select = INPUT_CSC_SELECT_BYPASS;
+	enum dcn20_input_csc_select select = DCN2_ICSC_SELECT_BYPASS;
 	bool force_disable_cursor = false;
 	struct out_csc_color_matrix tbl_entry;
 	uint32_t is_2bit = 0;
@@ -145,25 +145,25 @@ static void dpp2_cnv_setup (
 		force_disable_cursor = false;
 		pixel_format = 65;
 		color_space = COLOR_SPACE_YCBCR709;
-		select = INPUT_CSC_SELECT_ICSC;
+		select = DCN2_ICSC_SELECT_ICSC_A;
 		break;
 	case SURFACE_PIXEL_FORMAT_VIDEO_420_YCrCb:
 		force_disable_cursor = true;
 		pixel_format = 64;
 		color_space = COLOR_SPACE_YCBCR709;
-		select = INPUT_CSC_SELECT_ICSC;
+		select = DCN2_ICSC_SELECT_ICSC_A;
 		break;
 	case SURFACE_PIXEL_FORMAT_VIDEO_420_10bpc_YCbCr:
 		force_disable_cursor = true;
 		pixel_format = 67;
 		color_space = COLOR_SPACE_YCBCR709;
-		select = INPUT_CSC_SELECT_ICSC;
+		select = DCN2_ICSC_SELECT_ICSC_A;
 		break;
 	case SURFACE_PIXEL_FORMAT_VIDEO_420_10bpc_YCrCb:
 		force_disable_cursor = true;
 		pixel_format = 66;
 		color_space = COLOR_SPACE_YCBCR709;
-		select = INPUT_CSC_SELECT_ICSC;
+		select = DCN2_ICSC_SELECT_ICSC_A;
 		break;
 	case SURFACE_PIXEL_FORMAT_GRPH_ARGB16161616:
 		pixel_format = 22;
@@ -177,7 +177,7 @@ static void dpp2_cnv_setup (
 	case SURFACE_PIXEL_FORMAT_VIDEO_AYCrCb8888:
 		pixel_format = 12;
 		color_space = COLOR_SPACE_YCBCR709;
-		select = INPUT_CSC_SELECT_ICSC;
+		select = DCN2_ICSC_SELECT_ICSC_A;
 		break;
 	case SURFACE_PIXEL_FORMAT_GRPH_RGB111110_FIX:
 		pixel_format = 112;
@@ -188,13 +188,13 @@ static void dpp2_cnv_setup (
 	case SURFACE_PIXEL_FORMAT_VIDEO_ACrYCb2101010:
 		pixel_format = 114;
 		color_space = COLOR_SPACE_YCBCR709;
-		select = INPUT_CSC_SELECT_ICSC;
+		select = DCN2_ICSC_SELECT_ICSC_A;
 		is_2bit = 1;
 		break;
 	case SURFACE_PIXEL_FORMAT_VIDEO_CrYCbA1010102:
 		pixel_format = 115;
 		color_space = COLOR_SPACE_YCBCR709;
-		select = INPUT_CSC_SELECT_ICSC;
+		select = DCN2_ICSC_SELECT_ICSC_A;
 		is_2bit = 1;
 		break;
 	case SURFACE_PIXEL_FORMAT_GRPH_RGB111110_FLOAT:
@@ -227,13 +227,13 @@ static void dpp2_cnv_setup (
 		tbl_entry.color_space = input_color_space;
 
 		if (color_space >= COLOR_SPACE_YCBCR601)
-			select = INPUT_CSC_SELECT_ICSC;
+			select = DCN2_ICSC_SELECT_ICSC_A;
 		else
-			select = INPUT_CSC_SELECT_BYPASS;
+			select = DCN2_ICSC_SELECT_BYPASS;
 
-		dpp1_program_input_csc(dpp_base, color_space, select, &tbl_entry);
+		dpp2_program_input_csc(dpp_base, color_space, select, &tbl_entry);
 	} else
-	dpp1_program_input_csc(dpp_base, color_space, select, NULL);
+	dpp2_program_input_csc(dpp_base, color_space, select, NULL);
 
 	if (force_disable_cursor) {
 		REG_UPDATE(CURSOR_CONTROL,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.h
index 5b03b737b1d6..d9ce60b6aa6e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.h
@@ -150,6 +150,10 @@
 	SRI(CM_SHAPER_RAMA_REGION_32_33, CM, id), \
 	SRI(CM_SHAPER_LUT_INDEX, CM, id)
 
+#define TF_REG_LIST_DCN20_COMMON_APPEND(id) \
+	SRI(CM_ICSC_B_C11_C12, CM, id), \
+	SRI(CM_ICSC_B_C33_C34, CM, id)
+
 #define TF_REG_LIST_DCN20(id) \
 	TF_REG_LIST_DCN(id), \
 	TF_REG_LIST_DCN20_COMMON(id), \
@@ -572,6 +576,14 @@
 	TF_SF(DSCL0_OBUF_MEM_PWR_CTRL, OBUF_MEM_PWR_FORCE, mask_sh),\
 	TF_SF(DSCL0_DSCL_MEM_PWR_CTRL, LUT_MEM_PWR_FORCE, mask_sh)
 
+/* DPP CM debug status register:
+ *
+ *		Status index including current ICSC, Gamut Remap Mode is 9
+ *			ICSC Mode: [5..4]
+ */
+#define CM_TEST_DEBUG_DATA_STATUS_IDX 9
+#define CM_TEST_DEBUG_DATA_ICSC_MODE_SH 4
+#define CM_TEST_DEBUG_DATA_ICSC_MODE_MASK 0x3
 
 #define TF_REG_FIELD_LIST_DCN2_0(type) \
 	TF_REG_FIELD_LIST(type) \
@@ -630,11 +642,16 @@ struct dcn2_dpp_mask {
 	uint32_t COLOR_KEYER_RED; \
 	uint32_t COLOR_KEYER_GREEN; \
 	uint32_t COLOR_KEYER_BLUE; \
-	uint32_t OBUF_MEM_PWR_CTRL;\
+	uint32_t OBUF_MEM_PWR_CTRL; \
 	uint32_t DSCL_MEM_PWR_CTRL
 
+#define DPP_DCN2_REG_VARIABLE_LIST_CM_APPEND \
+	uint32_t CM_ICSC_B_C11_C12; \
+	uint32_t CM_ICSC_B_C33_C34
+
 struct dcn2_dpp_registers {
 	DPP_DCN2_REG_VARIABLE_LIST;
+	DPP_DCN2_REG_VARIABLE_LIST_CM_APPEND;
 };
 
 struct dcn20_dpp {
@@ -656,6 +673,12 @@ struct dcn20_dpp {
 	struct pwl_params pwl_data;
 };
 
+enum dcn20_input_csc_select {
+	DCN2_ICSC_SELECT_BYPASS = 0,
+	DCN2_ICSC_SELECT_ICSC_A = 1,
+	DCN2_ICSC_SELECT_ICSC_B = 2
+};
+
 void dpp20_read_state(struct dpp *dpp_base,
 		struct dcn_dpp_state *s);
 
@@ -667,6 +690,12 @@ void dpp2_set_degamma(
 		struct dpp *dpp_base,
 		enum ipp_degamma_mode mode);
 
+void dpp2_program_input_csc(
+		struct dpp *dpp_base,
+		enum dc_color_space color_space,
+		enum dcn20_input_csc_select input_select,
+		const struct out_csc_color_matrix *tbl_entry);
+
 bool dpp20_program_blnd_lut(
 	struct dpp *dpp_base, const struct pwl_params *params);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp_cm.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp_cm.c
index 05a3e7f97ef0..423f3daa177f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp_cm.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp_cm.c
@@ -36,6 +36,9 @@
 #define REG(reg)\
 	dpp->tf_regs->reg
 
+#define IND_REG(index) \
+	(index)
+
 #define CTX \
 	dpp->base.ctx
 
@@ -44,9 +47,6 @@
 	dpp->tf_shift->field_name, dpp->tf_mask->field_name
 
 
-
-
-
 static void dpp2_enable_cm_block(
 		struct dpp *dpp_base)
 {
@@ -158,6 +158,83 @@ void dpp2_set_degamma(
 	}
 }
 
+void dpp2_program_input_csc(
+		struct dpp *dpp_base,
+		enum dc_color_space color_space,
+		enum dcn20_input_csc_select input_select,
+		const struct out_csc_color_matrix *tbl_entry)
+{
+	struct dcn20_dpp *dpp = TO_DCN20_DPP(dpp_base);
+	int i;
+	int arr_size = sizeof(dpp_input_csc_matrix)/sizeof(struct dpp_input_csc_matrix);
+	const uint16_t *regval = NULL;
+	uint32_t cur_select = 0;
+	enum dcn20_input_csc_select select;
+	struct color_matrices_reg icsc_regs;
+
+	if (input_select == DCN2_ICSC_SELECT_BYPASS) {
+		REG_SET(CM_ICSC_CONTROL, 0, CM_ICSC_MODE, 0);
+		return;
+	}
+
+	if (tbl_entry == NULL) {
+		for (i = 0; i < arr_size; i++)
+			if (dpp_input_csc_matrix[i].color_space == color_space) {
+				regval = dpp_input_csc_matrix[i].regval;
+				break;
+			}
+
+		if (regval == NULL) {
+			BREAK_TO_DEBUGGER();
+			return;
+		}
+	} else {
+		regval = tbl_entry->regval;
+	}
+
+	/* determine which CSC coefficients (A or B) we are using
+	 * currently.  select the alternate set to double buffer
+	 * the CSC update so CSC is updated on frame boundary
+	 */
+	cur_select = IX_REG_READ(CM_TEST_DEBUG_INDEX, CM_TEST_DEBUG_DATA,
+					CM_TEST_DEBUG_DATA_STATUS_IDX);
+
+	/* IX_REG_READ reads whole reg, so isolate part we want [5..4] */
+	cur_select = (cur_select >> CM_TEST_DEBUG_DATA_ICSC_MODE_SH)
+					& CM_TEST_DEBUG_DATA_ICSC_MODE_MASK;
+
+	/* value stored in dbg reg will be 1 greater than mode we want */
+	if (cur_select - 1 != DCN2_ICSC_SELECT_ICSC_A)
+		select = DCN2_ICSC_SELECT_ICSC_A;
+	else
+		select = DCN2_ICSC_SELECT_ICSC_B;
+
+	icsc_regs.shifts.csc_c11 = dpp->tf_shift->CM_ICSC_C11;
+	icsc_regs.masks.csc_c11  = dpp->tf_mask->CM_ICSC_C11;
+	icsc_regs.shifts.csc_c12 = dpp->tf_shift->CM_ICSC_C12;
+	icsc_regs.masks.csc_c12 = dpp->tf_mask->CM_ICSC_C12;
+
+	if (select == DCN2_ICSC_SELECT_ICSC_A) {
+
+		icsc_regs.csc_c11_c12 = REG(CM_ICSC_C11_C12);
+		icsc_regs.csc_c33_c34 = REG(CM_ICSC_C33_C34);
+
+	} else {
+
+		icsc_regs.csc_c11_c12 = REG(CM_ICSC_B_C11_C12);
+		icsc_regs.csc_c33_c34 = REG(CM_ICSC_B_C33_C34);
+
+	}
+
+	cm_helper_program_color_matrices(
+			dpp->base.ctx,
+			regval,
+			&icsc_regs);
+
+	REG_SET(CM_ICSC_CONTROL, 0,
+				CM_ICSC_MODE, select);
+}
+
 static void dpp20_power_on_blnd_lut(
 	struct dpp *dpp_base,
 	bool power_on)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c
index c38f7fdb43a8..ce95e7db4814 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c
@@ -154,7 +154,10 @@ void mpc2_set_output_csc(
 	 * the CSC update so CSC is updated on frame boundary
 	 */
 	cur_mode = IX_REG_READ(MPC_OCSC_TEST_DEBUG_INDEX, MPC_OCSC_TEST_DEBUG_DATA,
-						MPC_OCSC_TEST_DEBUG_DATA_OCSC_MODE_IDX);
+						MPC_OCSC_TEST_DEBUG_DATA_STATUS_IDX);
+
+	/* Isolate part of reg data we want [1..0] */
+	cur_mode = cur_mode & MPC_OCSC_TEST_DEBUG_DATA_OCSC_MODE_MASK;
 
 	if (cur_mode != MPC_OUTPUT_CSC_COEF_A)
 		ocsc_mode = MPC_OUTPUT_CSC_COEF_A;
@@ -211,7 +214,10 @@ void mpc2_set_ocsc_default(
 	 * the CSC update so CSC is updated on frame boundary
 	 */
 	cur_mode = IX_REG_READ(MPC_OCSC_TEST_DEBUG_INDEX, MPC_OCSC_TEST_DEBUG_DATA,
-						MPC_OCSC_TEST_DEBUG_DATA_OCSC_MODE_IDX);
+						MPC_OCSC_TEST_DEBUG_DATA_STATUS_IDX);
+
+	/* Isolate part of reg data we want [1..0] */
+	cur_mode = cur_mode & MPC_OCSC_TEST_DEBUG_DATA_OCSC_MODE_MASK;
 
 	if (cur_mode != MPC_OUTPUT_CSC_COEF_A)
 		ocsc_mode = MPC_OUTPUT_CSC_COEF_A;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.h
index 8c77e78e2df5..950e6f9cd23e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.h
@@ -185,9 +185,11 @@
 /*
  *	DCN2 MPC_OCSC debug status register:
  *
- *		Field describing current OCSC Mode has index 1 [1..0]
+ *		Status index including current OCSC Mode is 1
+ *			OCSC Mode: [1..0]
  */
-#define MPC_OCSC_TEST_DEBUG_DATA_OCSC_MODE_IDX 1
+#define MPC_OCSC_TEST_DEBUG_DATA_STATUS_IDX 1
+#define MPC_OCSC_TEST_DEBUG_DATA_OCSC_MODE_MASK 0x3
 
 #define MPC_REG_FIELD_LIST_DCN2_0(type) \
 	MPC_REG_FIELD_LIST(type)\
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 9233144ae74e..2ef6d0e2b0ed 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -638,6 +638,7 @@ static const struct dce110_aux_registers aux_engine_regs[] = {
 #define tf_regs(id)\
 [id] = {\
 	TF_REG_LIST_DCN20(id),\
+	TF_REG_LIST_DCN20_COMMON_APPEND(id),\
 }
 
 static const struct dcn2_dpp_registers tf_regs[] = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index 5a6e7ac5f785..81e087e85721 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -609,6 +609,7 @@ static const struct dce110_aux_registers aux_engine_regs[] = {
 #define tf_regs(id)\
 [id] = {\
 	TF_REG_LIST_DCN20(id),\
+	TF_REG_LIST_DCN20_COMMON_APPEND(id),\
 }
 
 static const struct dcn2_dpp_registers tf_regs[] = {
@@ -619,11 +620,13 @@ static const struct dcn2_dpp_registers tf_regs[] = {
 };
 
 static const struct dcn2_dpp_shift tf_shift = {
-		TF_REG_LIST_SH_MASK_DCN20(__SHIFT)
+		TF_REG_LIST_SH_MASK_DCN20(__SHIFT),
+		TF_DEBUG_REG_LIST_SH_DCN10
 };
 
 static const struct dcn2_dpp_mask tf_mask = {
-		TF_REG_LIST_SH_MASK_DCN20(_MASK)
+		TF_REG_LIST_SH_MASK_DCN20(_MASK),
+		TF_DEBUG_REG_LIST_MASK_DCN10
 };
 
 #define stream_enc_regs(id)\
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h
index 125e42dbd3c5..45ef390ae052 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h
@@ -47,6 +47,26 @@ struct dpp_input_csc_matrix {
 	uint16_t regval[12];
 };
 
+static const struct dpp_input_csc_matrix dpp_input_csc_matrix[] = {
+	{COLOR_SPACE_SRGB,
+		{0x2000, 0, 0, 0, 0, 0x2000, 0, 0, 0, 0, 0x2000, 0} },
+	{COLOR_SPACE_SRGB_LIMITED,
+		{0x2000, 0, 0, 0, 0, 0x2000, 0, 0, 0, 0, 0x2000, 0} },
+	{COLOR_SPACE_YCBCR601,
+		{0x2cdd, 0x2000, 0, 0xe991, 0xe926, 0x2000, 0xf4fd, 0x10ef,
+						0, 0x2000, 0x38b4, 0xe3a6} },
+	{COLOR_SPACE_YCBCR601_LIMITED,
+		{0x3353, 0x2568, 0, 0xe400, 0xe5dc, 0x2568, 0xf367, 0x1108,
+						0, 0x2568, 0x40de, 0xdd3a} },
+	{COLOR_SPACE_YCBCR709,
+		{0x3265, 0x2000, 0, 0xe6ce, 0xf105, 0x2000, 0xfa01, 0xa7d, 0,
+						0x2000, 0x3b61, 0xe24f} },
+
+	{COLOR_SPACE_YCBCR709_LIMITED,
+		{0x39a6, 0x2568, 0, 0xe0d6, 0xeedd, 0x2568, 0xf925, 0x9a8, 0,
+						0x2568, 0x43ee, 0xdbb2} }
+};
+
 struct dpp_grph_csc_adjustment {
 	struct fixed31_32 temperature_matrix[CSC_TEMPERATURE_MATRIX_SIZE];
 	enum graphics_gamut_adjust_type gamut_adjust_type;
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
