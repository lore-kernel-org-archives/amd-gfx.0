Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1236DECAAD3
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 03:26:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1996210E7E5;
	Wed, 14 Sep 2022 03:26:27 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1E8010E7E3
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 03:26:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AeeaE5Kk4EVHfEhiwPw/+fXVRUjwhTpoRU7uO00xBOAQLuQyWkjUP+6jber/x52iQeE2nmE5+/7WHStLN8mVGgsYwMrEZtmaBZUwx74QaXmoEdt9SYQXn+/RtE8mY/ccc92xUfTJr0RnPGIvm8B1qC15it1wyftnZbp8Fp3D649vBKZ3MBJRlCK/NavUL80Gzc8IwhROlLRFkCYMQ5VmPc3hTKGxpxo8D3+wLIp6oO4UQNVdDP/+JyiZ8LgTkvo+QU/f5I9XJP/o34zAzG+pEBfh2BmqIe/XQLRBqk1JZRJQOyesB1Jq4K+REOs0dcBtZ65KQ3m5P9I1yIz4ZL4krw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=drfvbaTv/aBTE70QOfEjSkQV3eSxqo3bMaw8QYlC+J8=;
 b=KnDuxnVbvSa4aGkLVo/YxYQ8LpGe8MXwmbEOMe4invC8vBV8eJ/lqZb70CWAPP7OV48Dcv53MOWUzx92Lc6Us0XrbTUoQw/77EsnpM2a7KclrDvFkPVHCc4Or0RCg9/dTQIz8wvxRVRibjdFo2Dw1bxHkTOZMVMtuy4opGyOEk4BenC/jFBQuzxWsIBXKC+M+/6ktpd28Upixxt9LxCY5UW7y6fIR1hGJMfPpXm/cI4DTsRbNsUqK9zN6DNEthOYQRRXGCRVtqyacvbZGd9NK59jCR1ViOi26VQUNcPskHF92m4ayxYKmtgN3soK3FQqD1jN3KgFAMGRlsdXryYhlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drfvbaTv/aBTE70QOfEjSkQV3eSxqo3bMaw8QYlC+J8=;
 b=Gd5rMjbQiWhdg+wbV+Za/AQ5acXke6HffQGQkpXooNj8Y15uqZiQsOjcMDuZ+Afl6X6WLIrTvmz7C7OJESxKwTsD1QhCaa0OOUMONuhE8P7dsAkNYrORmkcDiLKKHlSUwSwzrA9K0Tv3VbsbbNDUsmMtdgWdNlrDmvl3Fnb3qik=
Received: from DM6PR12CA0025.namprd12.prod.outlook.com (2603:10b6:5:1c0::38)
 by MN2PR12MB4453.namprd12.prod.outlook.com (2603:10b6:208:260::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 03:26:19 +0000
Received: from DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::d9) by DM6PR12CA0025.outlook.office365.com
 (2603:10b6:5:1c0::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.15 via Frontend
 Transport; Wed, 14 Sep 2022 03:26:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT067.mail.protection.outlook.com (10.13.172.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 03:26:18 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:26:18 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 13 Sep 2022 22:26:14 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/47] drm/amd/display: Various logs added
Date: Wed, 14 Sep 2022 11:23:59 +0800
Message-ID: <20220914032441.1075031-6-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914032441.1075031-1-Wayne.Lin@amd.com>
References: <20220914032441.1075031-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT067:EE_|MN2PR12MB4453:EE_
X-MS-Office365-Filtering-Correlation-Id: 82d5a715-5b16-473d-c4a0-08da9600e3b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U9xZhbetdwpmJHKoJpU/535ka6fsxpXmHU6RTDLXNsfVgEmsTIoWxhU6igTy/z61NF+cZjwcpZ0yTrEoQP0BhFFDGt6KKFjHEVJI41DNN3SysEp/Ez5VGfSl1Wpe4XIxzgfnwcvD+uXY32hhQzemCT51xei8OM8VY79of8RQBK3+SpkoUnCVreZtPH4EWX/2Ssp16VoVn89Dv3j55cqYWKnCRla9ylrGUcSfQL6iTRpL4nUjhbnGXx53HMFPIN4SVFiOjMAgkwnNE6/7noe93LmtFA+P6kkKALzPfl4mndxHCSKCgv1K4WXAcC/abm65TDxn5FsR8wiX4ouvGMl8qNYUNzbFynZZmt+yMFXJq3pXAuNXgATkWx6z5TXh6DGwbqyizWzkdYY8GiKTL9OClIEKBVeIruljDI9XC4NGi5hPll1A9Vmu89gE7fit6F+sW2OocF0F0bWCsfu7l3KpuKADCPf/hRYhwphTHvm8+xSAi8xMva2qIlOyLT8vOQlGMYKNcHLkhqf7OjDCZ/Od0o+DnjKKFQGoh6mu34pnW4DfR5vztxc4HDJ+ZEuwBMTsANe0OlCB1RT6UCDlzLjLXU2Z9CtIQKPcSgssAHFLaVbUruRloIcV/21YfS7Xc+xZgEV8rhEdttJ09OW8DoxjOUgOkDC88MSXczU5Xiohj1y/SE07IdGw1Xj50JUoKvRncPLGTjSQ/A6AdaLLJpzPapuSJKlloLs4QWw67nLrgyrZ9QXaybJBU/JU62K9BSqD5LdlIrzrGnpyA8Ra/LYGQmv0dNsuAbl9pLVM8/0cRAU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199015)(40470700004)(46966006)(36840700001)(26005)(7696005)(478600001)(6666004)(54906003)(316002)(6916009)(70586007)(2906002)(4326008)(70206006)(8676002)(41300700001)(8936002)(5660300002)(40460700003)(36756003)(82310400005)(40480700001)(86362001)(81166007)(82740400003)(36860700001)(356005)(336012)(47076005)(426003)(83380400001)(1076003)(186003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 03:26:18.9588 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82d5a715-5b16-473d-c4a0-08da9600e3b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4453
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

