Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2773ECAAD3
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 05:13:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FF5710E556;
	Wed, 14 Sep 2022 05:13:27 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23C6810E556
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 05:13:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FbWjtsr+9fsJ6vp0emyQ1rQ3Kt/U3QHdLpog4gQ6yLpeA8sa713gCCULRdXUE6ZcFVwI7KsZpql0Pre8h5XoS1zAlR5/rletgxg5EV73qmWHrL/Iz10j8+Ip2yhOjuhtoDjYu39TLO2ij7ELF1hlaBPBhxyuoMo/z8xS+aQQmUYvnIwWG/aJOfP5tVuaac+k8hQaAWPGIL5aYlif+fT68KJ1JfmTG7zcWOLZzUiopHyvliC7HvKmdPFplgmvJRKP5kVmLhPExub5/yuB74I0ogLWmPoYw0ITJltKcvWGjZ4nNojp15BZQW0EkNmASoADtfXQpB1WMGI2zzv3AgKe3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=drfvbaTv/aBTE70QOfEjSkQV3eSxqo3bMaw8QYlC+J8=;
 b=I07dkmbIyDUiz/bKht3LeWbokN7T60oQz7eVCJ+palV7KWjr0ZQpRFHwfetPjQy0lI3HrlC6PitCDTZI22qcESKLt6v+lZ4nDLAVo4UhnBW3yR0m+T6SXTGchCXiPNP9wmNFhCpJ98F9N6g1zEBikUXXle8dBs9Amcm9w0SRgaU9AlykOARdEhAGJRV469/VKFs8TDegxBF9gwnJkYH5WZZU/nO/GNIWuF5Di9LkTn7BcnDiNLtp0EWHoF2IVS09xN69km/oSH6lm53EkmBvd+LbVm3sYXj6WfUGgLcyFVPEV4tFnM11Gr2ugRZIOOcozSUQ2zLTXz7/fG2kdCjRQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drfvbaTv/aBTE70QOfEjSkQV3eSxqo3bMaw8QYlC+J8=;
 b=CsQ6qiHvglcA42SzAvAZEg9E9I8TBaC6CDDD59RLV5HHu2QB/VmA4P1GplnFJejjhgF34YccrKRGIQnYiyf2VARYwRUSc5SO9Wc9nAcwktNnQAM/iqvTEu3MV21opW0V/PQpH/W4lvPdTrDEqaMuy5fHRT2NrbM7RMoojkcccGw=
Received: from MW4PR03CA0253.namprd03.prod.outlook.com (2603:10b6:303:b4::18)
 by DS7PR12MB6358.namprd12.prod.outlook.com (2603:10b6:8:95::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 05:13:16 +0000
Received: from CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::50) by MW4PR03CA0253.outlook.office365.com
 (2603:10b6:303:b4::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22 via Frontend
 Transport; Wed, 14 Sep 2022 05:13:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT055.mail.protection.outlook.com (10.13.175.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 05:13:15 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 14 Sep
 2022 00:12:30 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Wed, 14 Sep 2022 00:12:10 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 05/47] drm/amd/display: Various logs added
Date: Wed, 14 Sep 2022 13:10:04 +0800
Message-ID: <20220914051046.1131186-6-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914051046.1131186-1-Wayne.Lin@amd.com>
References: <20220914051046.1131186-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT055:EE_|DS7PR12MB6358:EE_
X-MS-Office365-Filtering-Correlation-Id: 2aa338d8-1df4-4694-0aa5-08da960fd450
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r7Wql7pOio2UscxyRVaPdSk+zISRQTgooJho569sRtcYPD7ckDm/3bVghUNTTDvgeaqT4NTOX2rd/bugZgz82u3qptRhkt92xb824+fsAnpuN7N8Gpf/GlRmj7cdgy4wJSx7kJXqnAcFmAL0mrHcPsW+YJbIp15Ka3fHj3mnZZ8971L6tZ+asCEMOU7DTUPkThVqO8X9WWRHgDfTOVGlmy7+OhRyH8skHV2I+nvWA6lLRKyN1UrGdXPCZxN49goyT1n+bG7JlrwhxmRrvgcd+nwFjfuzmeggzWKICobD1pcj4ylBUXUfALB4EIZIzAfZLBwIK0c/oNN7n1fE2vz71rhem1Ne7t75xsBOr+J4g1RlQxHLqU5LjJonB9heVLerrxHrpqd7o2t9ZUUJdaA+XvXgGZNKP3/NZZN897//mCQRUPXCiLxYf1oWbm04sEOcRFO965vgz2hbpZDPTXdoOpdqAvnqmwBDF1JwMIP3Xr9fTkYSX4gtmVAaDaB5Ylb0s63ytLoJQC9xtNybYT2lBHVHSO0hRcE5ycXtUA202Ewu3TL4KI4LbosX0cwGyoyh9sMqsMn3e4ByahZrrdcLwySAiYthy+hbdisM1slXv2F1APARpJtgavRVe6zui4jvS1BWQKiJLZjeT7U1ibI7XnbRdGypfIpTxudIm3ta6PkDbyk+ZpGxcPBNyCaNgdPIf743vwaUG6dSAn01tD5yBm+izk+DpYJ/UN6md6nEhuH9fnek2GqKxS/m6HyG5P9/tTei1HKT+V4UeHAYqaQC6lhsEx3e+iXbsVWQ3bgz9iI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(376002)(396003)(136003)(451199015)(40470700004)(36840700001)(46966006)(316002)(70586007)(86362001)(54906003)(36756003)(356005)(40480700001)(41300700001)(36860700001)(6666004)(336012)(83380400001)(2616005)(7696005)(426003)(4326008)(26005)(186003)(70206006)(2906002)(6916009)(8936002)(82740400003)(81166007)(8676002)(47076005)(478600001)(1076003)(40460700003)(5660300002)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 05:13:15.5162 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aa338d8-1df4-4694-0aa5-08da960fd450
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6358
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

