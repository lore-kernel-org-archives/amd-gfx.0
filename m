Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D5DEECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 03:49:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 250E910E7FD;
	Wed, 14 Sep 2022 03:49:25 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 231E710E7FC
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 03:49:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J1hv09/NbUHkHVuIxIHB43wBBTh9QaFIG5unWAEzkTykirsHDcyDAZpEBsPONgskZQug/fAEVHZZGcZRB6OPnv/qqRhE16XAJQ2TeeZtFaT4apoiDJ9a2xm6gIw61qRKq2YxUkHWxVZeIMxxMyMs7lTZ/pLyoY6dKgtySlrNpTyEPSkFz0QEuZJEz9XfvUO0mYirMc5oAVoMAiwcCS2VTNVKYNKOD7ejxof3AKTHY4BaAVkSe1rCx2p00/IRJFImk/SEO+AR0y7Ir3mJSq7ifEuV8jYoKRlHlwfLndNGD0zLevCiHFNYbcPDNRvmLmqDtowEGBWATxGc8rNTo0EWSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=drfvbaTv/aBTE70QOfEjSkQV3eSxqo3bMaw8QYlC+J8=;
 b=jMku9ANjmD1Ebeq/RXJIIVOtEq1u4OdrA/d5QgLVES11s/lx0q+EY0c+IgCkh1DIex2lFdmfmIMnOCox8Xj2ZXJPxnR/wfYWvPd5WvQb2GX8d+5k6AI8spNuQQOQE9V7ua0nN8mMdldnt0Ub4KxPuHbcnmu4KMrGw7D/ilgkTlXZ4iAWG3z78JyCfn4EqzPXAPgl/ZYP+AgbaPcrl3FqOOXaOsc8DlvdxYEp0CO5sWL/lYMHH/xOrn/Xj1RzpZTgs/ceGLaL1cBpG5OoEXhG5TKnX7IT1x8xniOdMioA3tp60qHabZGvtLCnCB5qn7yemTZhfzUNxzMCzNrt2p+SMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drfvbaTv/aBTE70QOfEjSkQV3eSxqo3bMaw8QYlC+J8=;
 b=2pZ+AdmGbdsiQngS/IXx1w/mMyZhp7c/PvRrKHkyM+vOA2iuwWl0Nlm+/5lmunwpLj2t+e1R5ivtKekWStL0uWRc0LzXOowA2tRxmQMOMaOeCkAtN0Y5Ffh5gSxhnd8MpzNp0pjAQsSaA0MIHyYkpb2+il4UzLj007a/+eICIHA=
Received: from CY5PR22CA0063.namprd22.prod.outlook.com (2603:10b6:930:80::9)
 by MN0PR12MB6320.namprd12.prod.outlook.com (2603:10b6:208:3d3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 03:49:09 +0000
Received: from CY4PEPF0000B8EF.namprd05.prod.outlook.com
 (2603:10b6:930:80:cafe::24) by CY5PR22CA0063.outlook.office365.com
 (2603:10b6:930:80::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22 via Frontend
 Transport; Wed, 14 Sep 2022 03:49:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000B8EF.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.9 via Frontend Transport; Wed, 14 Sep 2022 03:49:08 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:49:07 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 13 Sep 2022 22:49:03 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 05/47] drm/amd/display: Various logs added
Date: Wed, 14 Sep 2022 11:47:26 +0800
Message-ID: <20220914034808.1093521-6-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914034808.1093521-1-Wayne.Lin@amd.com>
References: <20220914034808.1093521-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8EF:EE_|MN0PR12MB6320:EE_
X-MS-Office365-Filtering-Correlation-Id: c82c2b7f-d7fd-4502-9a8a-08da96041425
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U2A9NTV8qpcNxfM4+IhsTtlXAAyTWUXhzNT02m13+a+fOcmaPNEG+WYaIkpeOMUri8YVa7jGT6zwGkq4P+LFY9ndO5eALGlTzuJqMbtFtZcVkeJNVTvZ4GgfCM63IshXVZ+Zzf3KI8cKcqwVZVaABT3G9HW0zOIWFFVeXXoD89VoigWWYwQKVsAntn1Jb7xFFGJKeDswhUf0T3M7nVFt/25etEVsVyNmd+UIicelvboAs+TOUMdxWaztjMohOirEJ1YaD6zAChiY/7hepTaB3QDr4WDLqHVMVuDjldJhxv9irs17G2TgbvrZkKJqi/0r99n0fKbj/OGqnWMhmxLnlt+k4FSdVMF0p/00scFYDYcUQm2AALoZF1N7fkb2UJNCdAMSHMcBDXzL169uN0IYX+8J97cj0jSwVLS/8tCgr+j5fFcypmDfvds3ldwyWayVhuQOTf91RFfsaJs3PQ+Tp4r+agmDc7hFq+dx9iI+kBmqTzBLvAVN/410SOdHhhUhg43rz394zugMLoqdysbqYWDlB7zvGZdhZkoYbfeyKNOASeTMamLL4uLFJKfSH8PU0cV72J7IopHeEhtbnx3aZ4OT+GYGiWkIkFty+YoF3QYcNaVvtgZI1l7PRpZAD0aZtDVntoqmkDgMe5aRJSh2lAg/U/Pob464I7I2PkjKUMSVcomPmhglAWSeAqpA19zQR7Ce5S1GyTzqS05O68FEP1EUj683kTq6dZqhWSj2kQ0z2y2Y7lmaom8s282+YRPTzSjNGG8ypxdWCF/M1GMwm0xxO9URKkL7hudyzf7+XuA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(136003)(396003)(376002)(451199015)(40470700004)(46966006)(36840700001)(6916009)(6666004)(5660300002)(2616005)(356005)(47076005)(82310400005)(186003)(70586007)(336012)(70206006)(426003)(86362001)(1076003)(2906002)(36756003)(26005)(81166007)(316002)(4326008)(82740400003)(40480700001)(8936002)(478600001)(41300700001)(8676002)(54906003)(83380400001)(40460700003)(7696005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 03:49:08.7296 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c82c2b7f-d7fd-4502-9a8a-08da96041425
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6320
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Leo Chen <sancchen@amd.com>, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Leo Chen <sancchen@amd.com>

[Why & How]
Added logs for panel delays, spread_spectrum_percentage,
and gpuclk_ss_percentage to facilitate debugging.

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Leo Chen <sancchen@amd.com>
---
 .../drm/amd/display/dc/bios/bios_parser2.c    | 54 ++++++++++++++-----
 1 file changed, 40 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index 85ed0afb74a9..acbdb7926375 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -850,7 +850,7 @@ static enum bp_result get_ss_info_v4_1(
 		if (disp_cntl_tbl->dvi_ss_mode & ATOM_SS_CENTRE_SPREAD_MODE)
 			ss_info->type.CENTER_MODE = true;
 
-		DC_LOG_BIOS("AS_SIGNAL_TYPE_DVI: %d\n", ss_info->spread_spectrum_percentage);
+		DC_LOG_BIOS("AS_SIGNAL_TYPE_DVI ss_percentage: %d\n", ss_info->spread_spectrum_percentage);
 		break;
 	case AS_SIGNAL_TYPE_HDMI:
 		ss_info->spread_spectrum_percentage =
@@ -860,7 +860,7 @@ static enum bp_result get_ss_info_v4_1(
 		if (disp_cntl_tbl->hdmi_ss_mode & ATOM_SS_CENTRE_SPREAD_MODE)
 			ss_info->type.CENTER_MODE = true;
 
-		DC_LOG_BIOS("AS_SIGNAL_TYPE_HDMI: %d\n", ss_info->spread_spectrum_percentage);
+		DC_LOG_BIOS("AS_SIGNAL_TYPE_HDMI ss_percentage: %d\n", ss_info->spread_spectrum_percentage);
 		break;
 	/* TODO LVDS not support anymore? */
 	case AS_SIGNAL_TYPE_DISPLAY_PORT:
@@ -871,7 +871,7 @@ static enum bp_result get_ss_info_v4_1(
 		if (disp_cntl_tbl->dp_ss_mode & ATOM_SS_CENTRE_SPREAD_MODE)
 			ss_info->type.CENTER_MODE = true;
 
-		DC_LOG_BIOS("AS_SIGNAL_TYPE_DISPLAY_PORT: %d\n", ss_info->spread_spectrum_percentage);
+		DC_LOG_BIOS("AS_SIGNAL_TYPE_DISPLAY_PORT ss_percentage: %d\n", ss_info->spread_spectrum_percentage);
 		break;
 	case AS_SIGNAL_TYPE_GPU_PLL:
 		/* atom_firmware: DAL only get data from dce_info table.
@@ -885,7 +885,7 @@ static enum bp_result get_ss_info_v4_1(
 				      DATA_TABLES(smu_info));
 		if (!smu_info)
 			return BP_RESULT_BADBIOSTABLE;
-
+		DC_LOG_BIOS("gpuclk_ss_percentage (unit of 0.001 percent): %d\n", smu_info->gpuclk_ss_percentage);
 		ss_info->spread_spectrum_percentage =
 				smu_info->waflclk_ss_percentage;
 		ss_info->spread_spectrum_range =
@@ -893,7 +893,7 @@ static enum bp_result get_ss_info_v4_1(
 		if (smu_info->waflclk_ss_mode & ATOM_SS_CENTRE_SPREAD_MODE)
 			ss_info->type.CENTER_MODE = true;
 
-		DC_LOG_BIOS("AS_SIGNAL_TYPE_XGMI: %d\n", ss_info->spread_spectrum_percentage);
+		DC_LOG_BIOS("AS_SIGNAL_TYPE_XGMI ss_percentage: %d\n", ss_info->spread_spectrum_percentage);
 		break;
 	default:
 		result = BP_RESULT_UNSUPPORTED;
@@ -930,6 +930,7 @@ static enum bp_result get_ss_info_v4_2(
 	if (!smu_info)
 		return BP_RESULT_BADBIOSTABLE;
 
+	DC_LOG_BIOS("gpuclk_ss_percentage (unit of 0.001 percent): %d\n", smu_info->gpuclk_ss_percentage);
 	ss_info->type.STEP_AND_DELAY_INFO = false;
 	ss_info->spread_percentage_divider = 1000;
 	/* BIOS no longer uses target clock.  Always enable for now */
@@ -944,7 +945,7 @@ static enum bp_result get_ss_info_v4_2(
 		if (disp_cntl_tbl->dvi_ss_mode & ATOM_SS_CENTRE_SPREAD_MODE)
 			ss_info->type.CENTER_MODE = true;
 
-		DC_LOG_BIOS("AS_SIGNAL_TYPE_DVI: %d\n", ss_info->spread_spectrum_percentage);
+		DC_LOG_BIOS("AS_SIGNAL_TYPE_DVI ss_percentage: %d\n", ss_info->spread_spectrum_percentage);
 		break;
 	case AS_SIGNAL_TYPE_HDMI:
 		ss_info->spread_spectrum_percentage =
@@ -954,7 +955,7 @@ static enum bp_result get_ss_info_v4_2(
 		if (disp_cntl_tbl->hdmi_ss_mode & ATOM_SS_CENTRE_SPREAD_MODE)
 			ss_info->type.CENTER_MODE = true;
 
-		DC_LOG_BIOS("AS_SIGNAL_TYPE_HDMI: %d\n", ss_info->spread_spectrum_percentage);
+		DC_LOG_BIOS("AS_SIGNAL_TYPE_HDMI ss_percentage: %d\n", ss_info->spread_spectrum_percentage);
 		break;
 	/* TODO LVDS not support anymore? */
 	case AS_SIGNAL_TYPE_DISPLAY_PORT:
@@ -965,7 +966,7 @@ static enum bp_result get_ss_info_v4_2(
 		if (smu_info->gpuclk_ss_mode & ATOM_SS_CENTRE_SPREAD_MODE)
 			ss_info->type.CENTER_MODE = true;
 
-		DC_LOG_BIOS("AS_SIGNAL_TYPE_DISPLAY_PORT: %d\n", ss_info->spread_spectrum_percentage);
+		DC_LOG_BIOS("AS_SIGNAL_TYPE_DISPLAY_PORT ss_percentage: %d\n", ss_info->spread_spectrum_percentage);
 		break;
 	case AS_SIGNAL_TYPE_GPU_PLL:
 		/* atom_firmware: DAL only get data from dce_info table.
@@ -1015,7 +1016,7 @@ static enum bp_result get_ss_info_v4_5(
 		if (disp_cntl_tbl->dvi_ss_mode & ATOM_SS_CENTRE_SPREAD_MODE)
 			ss_info->type.CENTER_MODE = true;
 
-		DC_LOG_BIOS("AS_SIGNAL_TYPE_DVI: %d\n", ss_info->spread_spectrum_percentage);
+		DC_LOG_BIOS("AS_SIGNAL_TYPE_DVI ss_percentage: %d\n", ss_info->spread_spectrum_percentage);
 		break;
 	case AS_SIGNAL_TYPE_HDMI:
 		ss_info->spread_spectrum_percentage =
@@ -1025,7 +1026,7 @@ static enum bp_result get_ss_info_v4_5(
 		if (disp_cntl_tbl->hdmi_ss_mode & ATOM_SS_CENTRE_SPREAD_MODE)
 			ss_info->type.CENTER_MODE = true;
 
-		DC_LOG_BIOS("AS_SIGNAL_TYPE_HDMI: %d\n", ss_info->spread_spectrum_percentage);
+		DC_LOG_BIOS("AS_SIGNAL_TYPE_HDMI ss_percentage: %d\n", ss_info->spread_spectrum_percentage);
 		break;
 	case AS_SIGNAL_TYPE_DISPLAY_PORT:
 		ss_info->spread_spectrum_percentage =
@@ -1035,7 +1036,7 @@ static enum bp_result get_ss_info_v4_5(
 		if (disp_cntl_tbl->dp_ss_mode & ATOM_SS_CENTRE_SPREAD_MODE)
 			ss_info->type.CENTER_MODE = true;
 
-		DC_LOG_BIOS("AS_SIGNAL_TYPE_DISPLAY_PORT: %d\n", ss_info->spread_spectrum_percentage);
+		DC_LOG_BIOS("AS_SIGNAL_TYPE_DISPLAY_PORT ss_percentage: %d\n", ss_info->spread_spectrum_percentage);
 		break;
 	case AS_SIGNAL_TYPE_GPU_PLL:
 		/* atom_smu_info_v4_0 does not have fields for SS for SMU Display PLL anymore.
@@ -1860,7 +1861,7 @@ static enum bp_result get_firmware_info_v3_2(
 		/* Vega12 */
 		smu_info_v3_2 = GET_IMAGE(struct atom_smu_info_v3_2,
 							DATA_TABLES(smu_info));
-
+		DC_LOG_BIOS("gpuclk_ss_percentage (unit of 0.001 percent): %d\n", smu_info_v3_2->gpuclk_ss_percentage);
 		if (!smu_info_v3_2)
 			return BP_RESULT_BADBIOSTABLE;
 
@@ -1869,7 +1870,7 @@ static enum bp_result get_firmware_info_v3_2(
 		/* Vega20 */
 		smu_info_v3_3 = GET_IMAGE(struct atom_smu_info_v3_3,
 							DATA_TABLES(smu_info));
-
+		DC_LOG_BIOS("gpuclk_ss_percentage (unit of 0.001 percent): %d\n", smu_info_v3_3->gpuclk_ss_percentage);
 		if (!smu_info_v3_3)
 			return BP_RESULT_BADBIOSTABLE;
 
@@ -2011,7 +2012,7 @@ static enum bp_result get_firmware_info_v3_4(
 
 			if (!smu_info_v3_5)
 				return BP_RESULT_BADBIOSTABLE;
-
+			DC_LOG_BIOS("gpuclk_ss_percentage (unit of 0.001 percent): %d\n", smu_info_v3_5->gpuclk_ss_percentage);
 			info->default_engine_clk = smu_info_v3_5->bootup_dcefclk_10khz * 10;
 			break;
 
@@ -2417,6 +2418,7 @@ static enum bp_result get_integrated_info_v11(
 	info_v11 = GET_IMAGE(struct atom_integrated_system_info_v1_11,
 					DATA_TABLES(integratedsysteminfo));
 
+	DC_LOG_BIOS("gpuclk_ss_percentage (unit of 0.001 percent): %d\n", info_v11->gpuclk_ss_percentage);
 	if (info_v11 == NULL)
 		return BP_RESULT_BADBIOSTABLE;
 
@@ -2631,6 +2633,7 @@ static enum bp_result get_integrated_info_v2_1(
 
 	info_v2_1 = GET_IMAGE(struct atom_integrated_system_info_v2_1,
 					DATA_TABLES(integratedsysteminfo));
+	DC_LOG_BIOS("gpuclk_ss_percentage (unit of 0.001 percent): %d\n", info_v2_1->gpuclk_ss_percentage);
 
 	if (info_v2_1 == NULL)
 		return BP_RESULT_BADBIOSTABLE;
@@ -2792,6 +2795,8 @@ static enum bp_result get_integrated_info_v2_2(
 	info_v2_2 = GET_IMAGE(struct atom_integrated_system_info_v2_2,
 					DATA_TABLES(integratedsysteminfo));
 
+	DC_LOG_BIOS("gpuclk_ss_percentage (unit of 0.001 percent): %d\n", info_v2_2->gpuclk_ss_percentage);
+
 	if (info_v2_2 == NULL)
 		return BP_RESULT_BADBIOSTABLE;
 
@@ -2943,6 +2948,27 @@ static enum bp_result construct_integrated_info(
 		default:
 			return result;
 		}
+		if (result == BP_RESULT_OK) {
+
+			DC_LOG_BIOS("edp1:\n"
+						"\tedp_pwr_on_off_delay = %d\n"
+						"\tedp_pwr_on_vary_bl_to_blon = %d\n"
+						"\tedp_pwr_down_bloff_to_vary_bloff = %d\n"
+						"\tedp_bootup_bl_level = %d\n",
+						info->edp1_info.edp_pwr_on_off_delay,
+						info->edp1_info.edp_pwr_on_vary_bl_to_blon,
+						info->edp1_info.edp_pwr_down_bloff_to_vary_bloff,
+						info->edp1_info.edp_bootup_bl_level);
+			DC_LOG_BIOS("edp2:\n"
+						"\tedp_pwr_on_off_delayv = %d\n"
+						"\tedp_pwr_on_vary_bl_to_blon = %d\n"
+						"\tedp_pwr_down_bloff_to_vary_bloff = %d\n"
+						"\tedp_bootup_bl_level = %d\n",
+						info->edp2_info.edp_pwr_on_off_delay,
+						info->edp2_info.edp_pwr_on_vary_bl_to_blon,
+						info->edp2_info.edp_pwr_down_bloff_to_vary_bloff,
+						info->edp2_info.edp_bootup_bl_level);
+		}
 	}
 
 	if (result != BP_RESULT_OK)
-- 
2.37.3

