Return-Path: <SRS0=EPaF=PD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E337C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 18:44:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E632761040
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 18:44:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E632761040
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04F776EDEC;
	Fri, 15 Oct 2021 18:44:17 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DF476EDE7
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Oct 2021 18:44:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D+XhMt6EWByo1x/zEQ6vL22HTfOgfpuQ/xOneURcC7Zmb5T5IptBXv42qTsYnYUz+OprJppGOBs/RgwLh/ydfVcEDJXwWKmfGIEdDeBIil0q/Tm6OeJiN6awtY5Y0JHJfVG3duHD3aj9a2+bCF9G5XnM8aS/904X2z35XEQxf65v8u42NGmKuaO2a9gcKLSQBZIF8r56T0dKjcxR5dIgw19QPJTbccH2KO8b/oGUumn7E6U2KJ99AyDXqDqK4kv8WmXceA+9nUfXWBiieYWR4ueJG5CB+gdPg4RgBTVgXyrctSG1Nryd1PFFHebfCQPy1zW2u9L9M9dGqwOBa9BYDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BAa4vCVZQb0He2P0+QWSbPSNJQX62UVUGyLtTqcq0uA=;
 b=gMWurL0ahZ69ahbblF1y6Zdw1RQOcs8pGIHXVs+d/QxB/4Jf3AZmHHTZOpTsX5Tbiw4Jy75ZbsVhBmdpwU4gvyiFZ+AsW2MFTxLnnz97z8xOiUHP5UYz9j+16zAYE8vEt/EUWABEhVJ3nou1K7QtMXeezSKIVAp3mvMNStda+FOQSJYHTgok8aB7rQSaHweUFhhAPqd06HbPx6LMxFLIo3q0nuL9G00trvpKBL/bK7SlXkBem1Sq72hA9/WhpI6Z1Ngxw1VDlzJK7yyO/5MJlLDagOWpqldZoF5sbHasapIl/gHVr1abtwWWhZH7iemrWKzvt6+CzUNKjGJjm0MKEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BAa4vCVZQb0He2P0+QWSbPSNJQX62UVUGyLtTqcq0uA=;
 b=0oRRtwG+fnJ20T2FyM91aXrSNttRz9jN+u1rJBG1tu0V1zq/1nB9R2mFA6zKBbqdpV3WqZXULdQ+Q2O+M9SqGqA9ogMdHvDyZLMwNPvRHSnVpYYIKGz2Pio5La/+Sy18eTk6+L09XqS3jHS9F2yb1G0Ayj5UvSA3f2e5kRYn/xc=
Received: from DS7PR06CA0030.namprd06.prod.outlook.com (2603:10b6:8:54::22) by
 DM6PR12MB4283.namprd12.prod.outlook.com (2603:10b6:5:211::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.17; Fri, 15 Oct 2021 18:44:13 +0000
Received: from DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:54:cafe::aa) by DS7PR06CA0030.outlook.office365.com
 (2603:10b6:8:54::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend
 Transport; Fri, 15 Oct 2021 18:44:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT037.mail.protection.outlook.com (10.13.172.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Fri, 15 Oct 2021 18:44:13 +0000
Received: from ubuntu.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 15 Oct
 2021 13:44:11 -0500
From: Agustin Gutierrez <agustin.gutierrez@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
 <agustin.gutierrez@amd.com>, Nevenko Stupar <Nevenko.Stupar@amd.com>, Jun Lei
 <Jun.Lei@amd.com>
Subject: [PATCH 24/27] drm/amd/display: Add bios parser support for latest
 firmware_info
Date: Fri, 15 Oct 2021 14:43:29 -0400
Message-ID: <20211015184332.221091-25-agustin.gutierrez@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211015184332.221091-1-agustin.gutierrez@amd.com>
References: <20211015184332.221091-1-agustin.gutierrez@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c62fdc29-f561-4260-f473-08d9900bc87b
X-MS-TrafficTypeDiagnostic: DM6PR12MB4283:
X-Microsoft-Antispam-PRVS: <DM6PR12MB42834311F4409AF212914A46F5B99@DM6PR12MB4283.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:913;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A7/K2oLe3uettNTpaGyMnJJLLzZGGuIEVfiPklb5zpS6aFNnQpsJZ1OF/02X7jeK9yeUlCATW2UUoFQJQlYP6m4FpjPYflJ+PGXwJI4heCu8fo+ejfcy+SjFqlZ+oUQ2AJvvZfgKOEAcU4m/13SZ610tEhlagU7SVsBTat72IgYsxwmuaYeK+923/3ThOt0Ww2pl957E+7tXmX0W8m3v7qCJQyWBn+tDXB3bNTG9U2fZrU6lWMp83kU1ijG0s3Q0dCuC4s3aICu/KbT9/OWVxkqFKgNUZh48usCYjtG2HfqjsFQcPEiRYfX3v0V/ZncZqdAc9sxhWQfqwgls54THmIKy1cp2e9AT51iySaBoDNNNNyBdyeIXcb+rDuoB+EU+u5QgUuEbAKTYUbFIIsfmOF2kNi8oYVziGvgidluWcjE58CYiCKeVX5ZFGy9XKEEuDQtGaiibiGPSlo210IOOF0AaNXqm8gxNEaEqB8bOczaX//zlJ09pw//R99sNsPe0iW1UOJPIzkUQMhM0bf4CTpU9p12lD2xGF1sbNrgMk7HKaT/RL3SpoguZD1xRRAcKGzZKrRcIe3Fp1fsakdaC/lw3zTJPzLtWNXH6SXJtZAaMhoUGDe9VdfHJmyTeHTgV6zGb5d54mYgCpR5sdYJCM2uOcWdyo+c6JIo77tDJtiEwdA6c3fyszYGK8/SyVofuV/LebqL6TvBXQyi3PNouERGdiVjnRGhnxPuTY0G325I=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(82310400003)(36756003)(83380400001)(36860700001)(81166007)(356005)(8936002)(508600001)(8676002)(316002)(54906003)(1076003)(6666004)(5660300002)(4326008)(2906002)(70206006)(70586007)(47076005)(86362001)(2616005)(44832011)(186003)(16526019)(26005)(336012)(426003)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 18:44:13.1443 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c62fdc29-f561-4260-f473-08d9900bc87b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4283
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nevenko Stupar <Nevenko.Stupar@amd.com>

[Why]
V3_4 is latest in use.

[How]
Add bios parser support for firmware_info_v3_4 along
with some relevant fields it is also retrieving from dce_info
and smu_info.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Agustin Gutierrez Sanchez <agustin.gutierrez@amd.com>
Signed-off-by: Nevenko Stupar <Nevenko.Stupar@amd.com>
---
 .../drm/amd/display/dc/bios/bios_parser2.c    | 90 ++++++++++++++++++-
 1 file changed, 89 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index cdb5c027411a..c17732fba039 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -99,6 +99,10 @@ static enum bp_result get_firmware_info_v3_2(
 	struct bios_parser *bp,
 	struct dc_firmware_info *info);
 
+static enum bp_result get_firmware_info_v3_4(
+	struct bios_parser *bp,
+	struct dc_firmware_info *info);
+
 static struct atom_hpd_int_record *get_hpd_record(struct bios_parser *bp,
 		struct atom_display_object_path_v2 *object);
 
@@ -1426,8 +1430,10 @@ static enum bp_result bios_parser_get_firmware_info(
 				break;
 			case 2:
 			case 3:
-			case 4:
 				result = get_firmware_info_v3_2(bp, info);
+                                break;
+			case 4:
+				result = get_firmware_info_v3_4(bp, info);
 				break;
 			default:
 				break;
@@ -1575,6 +1581,88 @@ static enum bp_result get_firmware_info_v3_2(
 	return BP_RESULT_OK;
 }
 
+static enum bp_result get_firmware_info_v3_4(
+	struct bios_parser *bp,
+	struct dc_firmware_info *info)
+{
+	struct atom_firmware_info_v3_4 *firmware_info;
+	struct atom_common_table_header *header;
+	struct atom_data_revision revision;
+	struct atom_display_controller_info_v4_1 *dce_info_v4_1 = NULL;
+	struct atom_display_controller_info_v4_4 *dce_info_v4_4 = NULL;
+	if (!info)
+		return BP_RESULT_BADINPUT;
+
+	firmware_info = GET_IMAGE(struct atom_firmware_info_v3_4,
+			DATA_TABLES(firmwareinfo));
+
+	if (!firmware_info)
+		return BP_RESULT_BADBIOSTABLE;
+
+	memset(info, 0, sizeof(*info));
+
+	header = GET_IMAGE(struct atom_common_table_header,
+					DATA_TABLES(dce_info));
+
+	get_atom_data_table_revision(header, &revision);
+
+	switch (revision.major) {
+	case 4:
+		switch (revision.minor) {
+		case 4:
+			dce_info_v4_4 = GET_IMAGE(struct atom_display_controller_info_v4_4,
+							DATA_TABLES(dce_info));
+
+			if (!dce_info_v4_4)
+				return BP_RESULT_BADBIOSTABLE;
+
+			/* 100MHz expected */
+			info->pll_info.crystal_frequency = dce_info_v4_4->dce_refclk_10khz * 10;
+			info->dp_phy_ref_clk             = dce_info_v4_4->dpphy_refclk_10khz * 10;
+			/* 50MHz expected */
+			info->i2c_engine_ref_clk         = dce_info_v4_4->i2c_engine_refclk_10khz * 10;
+
+			/* Get SMU Display PLL VCO Frequency in KHz*/
+			info->smu_gpu_pll_output_freq =	dce_info_v4_4->dispclk_pll_vco_freq * 10;
+			break;
+
+		default:
+			/* should not come here, keep as backup, as was before */
+			dce_info_v4_1 = GET_IMAGE(struct atom_display_controller_info_v4_1,
+							DATA_TABLES(dce_info));
+
+			if (!dce_info_v4_1)
+				return BP_RESULT_BADBIOSTABLE;
+
+			info->pll_info.crystal_frequency = dce_info_v4_1->dce_refclk_10khz * 10;
+			info->dp_phy_ref_clk             = dce_info_v4_1->dpphy_refclk_10khz * 10;
+			info->i2c_engine_ref_clk         = dce_info_v4_1->i2c_engine_refclk_10khz * 10;
+			break;
+		}
+		break;
+
+	default:
+		ASSERT(0);
+		break;
+	}
+
+	header = GET_IMAGE(struct atom_common_table_header,
+					DATA_TABLES(smu_info));
+	get_atom_data_table_revision(header, &revision);
+
+	 // We need to convert from 10KHz units into KHz units.
+	info->default_memory_clk = firmware_info->bootup_mclk_in10khz * 10;
+
+	if (firmware_info->board_i2c_feature_id == 0x2) {
+		info->oem_i2c_present = true;
+		info->oem_i2c_obj_id = firmware_info->board_i2c_feature_gpio_id;
+	} else {
+		info->oem_i2c_present = false;
+	}
+
+	return BP_RESULT_OK;
+}
+
 static enum bp_result bios_parser_get_encoder_cap_info(
 	struct dc_bios *dcb,
 	struct graphics_object_id object_id,
-- 
2.25.1

