Return-Path: <SRS0=buuZ=D4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A0AC55179
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 14:23:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B83732224E
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 14:23:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rWVGIFuV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B83732224E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA2A96EDB7;
	Wed, 21 Oct 2020 14:23:06 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 514606EDBA
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 14:23:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I8vkIyqHH9J+KGB4P4sLhoG6iEAwxeRKDiGKlqHphNB4YGOW5j14XoHTzCKJlyXjl7b3byVVnEdbLxA7v4sN/XsXEFmxwMYMp5VkdeWOdNG9HkSsqw1pdFds4gnoZ4+UkeXVd4S2/NCuuVCZFOBNijJfocYPWgbwKmDbI4Lgl1nBgZ7WQos425ca4nxLdLGNE28XXP1OTSJADlIPEuV7aNgxAsCj4XaB68Jo4HLVQQYU604AYCt0LoCOcnYPfvexJsvEePR7BOOuc1eSpkA9JXFm81+hF7efc1gK4c5/xPQppRCC78xIjowcLQQlY/nLvqkSC4jgP+ytAp5F4ZUuew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ty7UZKP96ubL57W8ewm8UWHkGAjuA9gZPhdMVHwqryo=;
 b=VuGBPD53VOvYbjjzeFnKWJaQBtgEh6rI5yK6wrS843ySK9DeRzJuGgMN5wxnFmiconQ9JzwrHXN8XmeEQQzpGs1CTV4NhwryWoC9DuoA4KxkFVuhCih60C9rYdZGaCc7CsrGshEpmbN6FcMd10oRpaU05J6XSwB+PecKemkFYWKj+Xx2CWxlUdOyv1TuwARqNYROOLmbQ3rDFWUciIFProtXb2LNTFzfpD3BOY96LAQIshMz/flk+EwiMG+00pMeL4Eox5oOgXtLwFuVJer0dDNgFEX8OH4UXgOOmH40mn/2iTqo8qXCEskERlRNgYNliNMB21/du/hndt0JQvFYvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ty7UZKP96ubL57W8ewm8UWHkGAjuA9gZPhdMVHwqryo=;
 b=rWVGIFuVPfwrtKPqkbPDGL0SSymuDfNgzf0HWAKjnSiNUSum9CJXMJLy0FavwM0HGtCoNxTxOdAAKplw9/JphmjxI8Mik+GQURd0SxSU7Ln4Gkxm/eLkoU2Fqh/CHsYSWamtGoEF95GcmGkY8BXJ/nAUDnCKYmVmWlpMqEu75ik=
Received: from DM3PR08CA0002.namprd08.prod.outlook.com (2603:10b6:0:52::12) by
 MN2PR12MB3152.namprd12.prod.outlook.com (2603:10b6:208:ca::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.23; Wed, 21 Oct 2020 14:23:03 +0000
Received: from DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:52:cafe::d0) by DM3PR08CA0002.outlook.office365.com
 (2603:10b6:0:52::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Wed, 21 Oct 2020 14:23:03 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT067.mail.protection.outlook.com (10.13.172.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3499.18 via Frontend Transport; Wed, 21 Oct 2020 14:23:03 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 21 Oct
 2020 09:23:02 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 21 Oct
 2020 09:23:01 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 21 Oct 2020 09:23:01 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/33] drm/amd/display: Source minimum HBlank support
Date: Wed, 21 Oct 2020 10:22:28 -0400
Message-ID: <20201021142257.190969-5-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201021142257.190969-1-aurabindo.pillai@amd.com>
References: <20201021142257.190969-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e96080d6-2cb1-472c-e56d-08d875ccd229
X-MS-TrafficTypeDiagnostic: MN2PR12MB3152:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3152F55A9AE86FE6C716A63F8B1C0@MN2PR12MB3152.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:93;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VU4C1UavvE2tuHR4VdGgZ/gEagHoloopj+D/swXE1UHlVG94p9FFR9LD2gB+0UYydXGRI501WZSl5Hg56hn6pk6HluBqROK1vxvY1UTONY7Jsf5XwM3cQoZig9X6QENjCaqyBLVC/rznNtA61VuuKUX3OMcR1I0OC/FpXRsugiWOGHCnOKGcadF89Vi2t1+Y+Mh75BlxhKfHMjI+HcUUOuIneWQsuJSclrFJkfoWLVtbj/D9bCmuRRxirNgWLaF33qJasXjCkYOmfY8c5zvVQu1rbZZLVYIpfUAz0lXENgG55rGjYu7PMhySvMkbApgUs6uzJVkfJpPY0YsIJ8qdMIF1LmJKAbtZElrm7u4Phnjv4cpo/XrJArXieP/xSQVJoNMLglnvKo8WA7I6utABsA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(396003)(346002)(376002)(39860400002)(46966005)(86362001)(81166007)(186003)(5660300002)(44832011)(6666004)(8936002)(8676002)(1076003)(30864003)(83380400001)(36756003)(2616005)(426003)(316002)(478600001)(4326008)(2906002)(356005)(7696005)(54906003)(70586007)(6916009)(19627235002)(336012)(70206006)(82310400003)(47076004)(82740400003)(26005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 14:23:03.1724 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e96080d6-2cb1-472c-e56d-08d875ccd229
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3152
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
Cc: Ashley Thomas <Ashley.Thomas2@amd.com>, Eryk.Brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ashley Thomas <Ashley.Thomas2@amd.com>

[Why]
Some sink devices wish to have access to the minimum
HBlank supported by the ASIC.

[How]
Make the ASIC minimum HBlank available in Source
Device information address 0x340.

Signed-off-by: Ashley Thomas <Ashley.Thomas2@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_debug.c    |  2 +
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 39 +++++++++++++++----
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 .../amd/display/dc/dce100/dce100_resource.c   |  1 +
 .../amd/display/dc/dce110/dce110_resource.c   |  1 +
 .../amd/display/dc/dce112/dce112_resource.c   |  1 +
 .../amd/display/dc/dce120/dce120_resource.c   |  1 +
 .../drm/amd/display/dc/dce80/dce80_resource.c |  3 ++
 .../drm/amd/display/dc/dcn10/dcn10_resource.c |  1 +
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |  1 +
 .../drm/amd/display/dc/dcn21/dcn21_resource.c |  1 +
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |  1 +
 .../gpu/drm/amd/display/dc/inc/core_status.h  |  2 +
 .../gpu/drm/amd/display/include/dpcd_defs.h   |  1 +
 14 files changed, 49 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_debug.c b/drivers/gpu/drm/amd/display/dc/core/dc_debug.c
index 87d89449b9af..7977e2839065 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_debug.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_debug.c
@@ -418,6 +418,8 @@ char *dc_status_to_str(enum dc_status status)
 		return "Fail clk below minimum";
 	case DC_FAIL_CLK_BELOW_CFG_REQUIRED:
 		return "Fail clk below required CFG (hard_min in PPLIB)";
+	case DC_NOT_SUPPORTED:
+		return "The operation is not supported.";
 	case DC_ERROR_UNEXPECTED:
 		return "Unexpected error";
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index ff1e9963ec7a..2114c280895a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -17,16 +17,16 @@
 
 #define DC_LOGGER \
 	link->ctx->logger
-
+#define DC_TRACE_LEVEL_MESSAGE(...) /* do nothing */
 
 #define DP_REPEATER_CONFIGURATION_AND_STATUS_SIZE   0x50
 
-/* maximum pre emphasis level allowed for each voltage swing level*/
-static const enum dc_pre_emphasis voltage_swing_to_pre_emphasis[] = {
-		PRE_EMPHASIS_LEVEL3,
-		PRE_EMPHASIS_LEVEL2,
-		PRE_EMPHASIS_LEVEL1,
-		PRE_EMPHASIS_DISABLED };
+	/* maximum pre emphasis level allowed for each voltage swing level*/
+	static const enum dc_pre_emphasis
+	voltage_swing_to_pre_emphasis[] = { PRE_EMPHASIS_LEVEL3,
+					    PRE_EMPHASIS_LEVEL2,
+					    PRE_EMPHASIS_LEVEL1,
+					    PRE_EMPHASIS_DISABLED };
 
 enum {
 	POST_LT_ADJ_REQ_LIMIT = 6,
@@ -4372,6 +4372,7 @@ void dp_set_fec_enable(struct dc_link *link, bool enable)
 void dpcd_set_source_specific_data(struct dc_link *link)
 {
 	if (!link->dc->vendor_signature.is_valid) {
+		enum dc_status result_write_min_hblank = DC_NOT_SUPPORTED;
 		struct dpcd_amd_signature amd_signature;
 		amd_signature.AMD_IEEE_TxSignature_byte1 = 0x0;
 		amd_signature.AMD_IEEE_TxSignature_byte2 = 0x0;
@@ -4390,6 +4391,30 @@ void dpcd_set_source_specific_data(struct dc_link *link)
 				(uint8_t *)(&amd_signature),
 				sizeof(amd_signature));
 
+		if (link->ctx->dce_version >= DCN_VERSION_2_0 &&
+			link->dc->caps.min_horizontal_blanking_period != 0) {
+
+			uint8_t hblank_size = (uint8_t)link->dc->caps.min_horizontal_blanking_period;
+
+			result_write_min_hblank = core_link_write_dpcd(link,
+				DP_SOURCE_MINIMUM_HBLANK_SUPPORTED, (uint8_t *)(&hblank_size),
+				sizeof(hblank_size));
+		}
+		DC_TRACE_LEVEL_MESSAGE(DAL_TRACE_LEVEL_INFORMATION,
+							WPP_BIT_FLAG_DC_DETECTION_DP_CAPS,
+							"result=%u link_index=%u enum dce_version=%d DPCD=0x%04X min_hblank=%u branch_dev_id=0x%x branch_dev_name='%c%c%c%c%c%c'",
+							result_write_min_hblank,
+							link->link_index,
+							link->ctx->dce_version,
+							DP_SOURCE_MINIMUM_HBLANK_SUPPORTED,
+							link->dc->caps.min_horizontal_blanking_period,
+							link->dpcd_caps.branch_dev_id,
+							link->dpcd_caps.branch_dev_name[0],
+							link->dpcd_caps.branch_dev_name[1],
+							link->dpcd_caps.branch_dev_name[2],
+							link->dpcd_caps.branch_dev_name[3],
+							link->dpcd_caps.branch_dev_name[4],
+							link->dpcd_caps.branch_dev_name[5]);
 	} else {
 		core_link_write_dpcd(link, DP_SOURCE_OUI,
 				link->dc->vendor_signature.data.raw,
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 024fd4b17f3a..3f888570ffad 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -156,6 +156,7 @@ struct dc_caps {
 	uint32_t dmdata_alloc_size;
 	unsigned int max_cursor_size;
 	unsigned int max_video_width;
+	unsigned int min_horizontal_blanking_period;
 	int linear_pitch_alignment;
 	bool dcc_const_color;
 	bool dynamic_audio;
diff --git a/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c b/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
index d741787f75dc..1f08fc1de132 100644
--- a/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
@@ -1073,6 +1073,7 @@ static bool dce100_resource_construct(
 	dc->caps.i2c_speed_in_khz = 40;
 	dc->caps.i2c_speed_in_khz = 40;
 	dc->caps.max_cursor_size = 128;
+	dc->caps.min_horizontal_blanking_period = 80;
 	dc->caps.dual_link_dvi = true;
 	dc->caps.disable_dp_clk_share = true;
 	dc->caps.extended_aux_timeout_support = false;
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
index 2bbfa2e176a9..d389efc5bf47 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
@@ -1375,6 +1375,7 @@ static bool dce110_resource_construct(
 	dc->caps.i2c_speed_in_khz = 40;
 	dc->caps.i2c_speed_in_khz_hdcp = 40;
 	dc->caps.max_cursor_size = 128;
+	dc->caps.min_horizontal_blanking_period = 80;
 	dc->caps.is_apu = true;
 	dc->caps.extended_aux_timeout_support = false;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
index b622b4b1dac3..2dc6df43d9db 100644
--- a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
@@ -1242,6 +1242,7 @@ static bool dce112_resource_construct(
 	dc->caps.i2c_speed_in_khz = 100;
 	dc->caps.i2c_speed_in_khz_hdcp = 100; /*1.4 w/a not applied by default*/
 	dc->caps.max_cursor_size = 128;
+	dc->caps.min_horizontal_blanking_period = 80;
 	dc->caps.dual_link_dvi = true;
 	dc->caps.extended_aux_timeout_support = false;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c b/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
index 16fe7344702f..b34d9ee5840e 100644
--- a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
@@ -1082,6 +1082,7 @@ static bool dce120_resource_construct(
 	dc->caps.i2c_speed_in_khz = 100;
 	dc->caps.i2c_speed_in_khz_hdcp = 100; /*1.4 w/a not applied by default*/
 	dc->caps.max_cursor_size = 128;
+	dc->caps.min_horizontal_blanking_period = 80;
 	dc->caps.dual_link_dvi = true;
 	dc->caps.psp_setup_panel_mode = true;
 	dc->caps.extended_aux_timeout_support = false;
diff --git a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c b/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
index 0eae8cd35f9a..e1326791711b 100644
--- a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
@@ -972,6 +972,7 @@ static bool dce80_construct(
 	dc->caps.i2c_speed_in_khz = 40;
 	dc->caps.i2c_speed_in_khz_hdcp = 40;
 	dc->caps.max_cursor_size = 128;
+	dc->caps.min_horizontal_blanking_period = 80;
 	dc->caps.dual_link_dvi = true;
 	dc->caps.extended_aux_timeout_support = false;
 
@@ -1171,6 +1172,7 @@ static bool dce81_construct(
 	dc->caps.i2c_speed_in_khz = 40;
 	dc->caps.i2c_speed_in_khz_hdcp = 40;
 	dc->caps.max_cursor_size = 128;
+	dc->caps.min_horizontal_blanking_period = 80;
 	dc->caps.is_apu = true;
 
 	/*************************************************
@@ -1369,6 +1371,7 @@ static bool dce83_construct(
 	dc->caps.i2c_speed_in_khz = 40;
 	dc->caps.i2c_speed_in_khz_hdcp = 40;
 	dc->caps.max_cursor_size = 128;
+	dc->caps.min_horizontal_blanking_period = 80;
 	dc->caps.is_apu = true;
 
 	/*************************************************
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
index 634171f63a2f..e74bb2735885 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
@@ -1418,6 +1418,7 @@ static bool dcn10_resource_construct(
 	dc->caps.i2c_speed_in_khz = 100;
 	dc->caps.i2c_speed_in_khz_hdcp = 100; /*1.4 w/a not applied by default*/
 	dc->caps.max_cursor_size = 256;
+	dc->caps.min_horizontal_blanking_period = 80;
 	dc->caps.max_slave_planes = 1;
 	dc->caps.is_apu = true;
 	dc->caps.post_blend_color_processing = false;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 2e613960516a..3e425d554f09 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -3813,6 +3813,7 @@ static bool dcn20_resource_construct(
 	dc->caps.i2c_speed_in_khz = 100;
 	dc->caps.i2c_speed_in_khz_hdcp = 100; /*1.4 w/a not applied by default*/
 	dc->caps.max_cursor_size = 256;
+	dc->caps.min_horizontal_blanking_period = 80;
 	dc->caps.dmdata_alloc_size = 2048;
 
 	dc->caps.max_slave_planes = 1;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index 8a85e07935b2..70a18271bd2d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -1930,6 +1930,7 @@ static bool dcn21_resource_construct(
 	dc->caps.i2c_speed_in_khz = 100;
 	dc->caps.i2c_speed_in_khz_hdcp = 5; /*1.4 w/a applied by default*/
 	dc->caps.max_cursor_size = 256;
+	dc->caps.min_horizontal_blanking_period = 80;
 	dc->caps.dmdata_alloc_size = 2048;
 
 	dc->caps.max_slave_planes = 1;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index 060c2e65718a..beaa6b9ae752 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -2606,6 +2606,7 @@ static bool dcn30_resource_construct(
 	dc->caps.i2c_speed_in_khz = 100;
 	dc->caps.i2c_speed_in_khz_hdcp = 100; /*1.4 w/a not applied by default*/
 	dc->caps.max_cursor_size = 256;
+	dc->caps.min_horizontal_blanking_period = 80;
 	dc->caps.dmdata_alloc_size = 2048;
 
 	dc->caps.max_slave_planes = 1;
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_status.h b/drivers/gpu/drm/amd/display/dc/inc/core_status.h
index f932801235c6..714593a15590 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_status.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_status.h
@@ -50,6 +50,8 @@ enum dc_status {
 	DC_FAIL_CLK_BELOW_MIN = 22, /*THIS IS MIN PER IP*/
 	DC_FAIL_CLK_BELOW_CFG_REQUIRED = 23, /*THIS IS hard_min in PPLIB*/
 
+	DC_NOT_SUPPORTED = 24,
+
 	DC_ERROR_UNEXPECTED = -1
 };
 
diff --git a/drivers/gpu/drm/amd/display/include/dpcd_defs.h b/drivers/gpu/drm/amd/display/include/dpcd_defs.h
index 3d29646c7cb4..aec7389aff37 100644
--- a/drivers/gpu/drm/amd/display/include/dpcd_defs.h
+++ b/drivers/gpu/drm/amd/display/include/dpcd_defs.h
@@ -156,5 +156,6 @@ enum dpcd_psr_sink_states {
 #define DP_SOURCE_BACKLIGHT_CURRENT_PEAK    0x326
 #define DP_SOURCE_BACKLIGHT_CONTROL	    0x32E
 #define DP_SOURCE_BACKLIGHT_ENABLE	    0x32F
+#define DP_SOURCE_MINIMUM_HBLANK_SUPPORTED	0x340
 
 #endif /* __DAL_DPCD_DEFS_H__ */
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
