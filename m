Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B688C43334
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Jul 2022 14:40:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E25F310FC89;
	Sat, 16 Jul 2022 14:36:15 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F2C610E1EA
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jul 2022 18:18:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YOoAtqweAt3P03x6GsqirLcU4cv9Q3TY4giNh42Nc8qxYhqJyxQk5/KuyOPFgLwI+1QCZpA8267BrBUbmZbOLl8NNDojfCbSqq58cxWjbbq9OR0p2bZ3w2mjKaRnjvYQdL21JgD1ijmIr3UMr/lEkJZafU5aGAKzp4ZSS7930kw3DZZriLghT7Y2rWAd7tCgpKd22tz1tvnQhNyUCQ8LEWrak8sX7IFrakqyJ3dz66Odzl6fJ+URPjZbz3b1FV3EN7IS1KKWLSwocPHp8duoRbH7jylC4fz2cB/KnuoMMS69DxIXPXzBvaPNP0LZ8PPcvNo6WErdG5BvnQ5pOtG4Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=POm78dbZ9ga321HizA0P8dDksKhqjjNnlMZ7wDXJIus=;
 b=PKgPJY4WGYjbC3j4ZyHTQ5WAVe8GZOKAgTMRb5y4gJkh1Wd9+HvgY0dz+PW7dY6xRL9I05zP/kGTUL4g6bDBQV9oiTYz2lIu5X7DXmrQunOYdD4HtdEhj5IfVbB/kiufJQRLC+Ak+eHhJAZXeLo8E5DJHM3ykS06ebPUbHK2gMqJm2Csi9VqlMOtrJy+cyryRPRQOkeyRkVZapsMPkXxT1NuPLSLvNJWVBgBmIQ2OGspybE4vcVXWucJIHzdIZRXd8jJIncJxwaHtDaC0WD52aoYJhcB/cfXl6BqFBX7aPhXUfWONtd4W8cdwKQyQQzQmepqsbytujm2KyDk8GCzNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=POm78dbZ9ga321HizA0P8dDksKhqjjNnlMZ7wDXJIus=;
 b=dP85y9+aWyuk+i/zZheu7BL1oAGmEgTuBOK4nOv1RUQkc/2jA82dfra1G7zkhtfY4p5wuNuhDPKM1qlwnZe48k5l9FvDD6MfOkerMfQn42UrBM+HDdw4+bZTHJHGg1aSW8FPQMV6+4R4n4hr8IwsJHbi3vFN1GQ6ImR7jPslPOE=
Received: from DM6PR18CA0009.namprd18.prod.outlook.com (2603:10b6:5:15b::22)
 by DM6PR12MB2795.namprd12.prod.outlook.com (2603:10b6:5:41::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.15; Fri, 15 Jul
 2022 18:17:56 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::b2) by DM6PR18CA0009.outlook.office365.com
 (2603:10b6:5:15b::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25 via Frontend
 Transport; Fri, 15 Jul 2022 18:17:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Fri, 15 Jul 2022 18:17:55 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 15 Jul
 2022 13:17:55 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 15 Jul
 2022 13:17:54 -0500
Received: from arch-sec.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28 via
 Frontend Transport; Fri, 15 Jul 2022 13:17:54 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 26/31] drm/amd/display: Move ntuple to insert entry
Date: Fri, 15 Jul 2022 14:17:00 -0400
Message-ID: <20220715181705.1030401-27-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220715181705.1030401-1-Rodrigo.Siqueira@amd.com>
References: <20220715181705.1030401-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 564166e1-490d-49aa-58cd-08da668e5716
X-MS-TrafficTypeDiagnostic: DM6PR12MB2795:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r+iVnEkw0F9vY9UbOdRU1mPT5GAW3jD2jZPSyQvSCSuvoa33eTvSl1j/7LlhJm1vXXfXn9TXv2tTBEdwfwJfcFihoFD6twoncKz5ZxRXc567YoGl4fGLlEaHnkkD9fr6biG/P1VujvGHED0tiynWLoXAFdTFyeNw0tw0hfYoSdsDXkfJBlbipb2ujALPwjqWCjL9pVLTGrc3jjls7tQJa2aLeAwqPFt6IbyEHYoaW2XbV3IYtbWftw1i/fYp0RGo2eu7gnLtWYMpGxKnTRhDpMx1aw9PTUw142op66YrSRyjZ0asaGGW0mHY4wDvX8qXvLou+8jTMTdOuJ95I4ETRh734Ain6+ziERWx1jrQUS8ZVWU6f0xTCZn024z7giTeyGrOuJjCIiiUXk8PLXi33RmU7W6Imn33Ywpxh0/nIr52mXRlmh09b3csz9NckiBIRuOlP/mjf0NCdxShSz6Rj/F0jcefKEjPBcofGknsWeIg2FIq6h0RtjCbE4dWLcAwB6C0QPaxE8J8N9ura2cPCnxO8QBP71Sfrw9dTS9aJnaB0NXS2Cm5XnQs845BtnLcF3sAHRugWlAHbq8vUOO6s6FPw5R61cqHetsoNxDbJy4DXtznAZUWCNAUFCOJ27fv1mEMtHOnHZD6BPS+C3f8XxGU1KjsIfaNuzdkFEJ/IZIdLAGoNRu7Edv7LVeSb9KVWEVKl8sztE5aMPiXSEYpaH+c/hBaNUg5vEByRmbXueRji7yRDPnP4dhClFDCZf2iRDZ56iQRZ9RszwwisbBYdAdSsCB/Qky5eViqYbxpEz6MXNef6MZ0eWxHTHrdMTekt5CMYBy8OKONFWvKphu23mQ0czM0aA4sJEjnmsR85l8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(39860400002)(136003)(376002)(396003)(36840700001)(46966006)(40470700004)(2906002)(5660300002)(316002)(8676002)(70206006)(70586007)(40480700001)(54906003)(82310400005)(26005)(6916009)(478600001)(8936002)(6666004)(186003)(2616005)(41300700001)(336012)(356005)(47076005)(426003)(82740400003)(86362001)(83380400001)(36860700001)(1076003)(4326008)(36756003)(40460700003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 18:17:55.7724 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 564166e1-490d-49aa-58cd-08da668e5716
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2795
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Move get_optimal_ntuple to the FPU code and call it inside
insert_entry_into_table_sorted.

Reviewed-by: Harry Wentland <Harry.Wentland@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../drm/amd/display/dc/dcn32/dcn32_resource.c | 28 -------------------
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  | 25 +++++++++++++++++
 2 files changed, 25 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index 32edb3e5715a..adcc83e6ea55 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -1956,29 +1956,6 @@ void dcn32_calculate_wm_and_dlg(struct dc *dc, struct dc_state *context,
     DC_FP_END();
 }
 
-static void get_optimal_ntuple(struct _vcs_dpi_voltage_scaling_st *entry)
-{
-	if (entry->dcfclk_mhz > 0) {
-		float bw_on_sdp = entry->dcfclk_mhz * dcn3_2_soc.return_bus_width_bytes * ((float)dcn3_2_soc.pct_ideal_sdp_bw_after_urgent / 100);
-
-		entry->fabricclk_mhz = bw_on_sdp / (dcn3_2_soc.return_bus_width_bytes * ((float)dcn3_2_soc.pct_ideal_fabric_bw_after_urgent / 100));
-		entry->dram_speed_mts = bw_on_sdp / (dcn3_2_soc.num_chans *
-				dcn3_2_soc.dram_channel_width_bytes * ((float)dcn3_2_soc.pct_ideal_dram_sdp_bw_after_urgent_pixel_only / 100));
-	} else if (entry->fabricclk_mhz > 0) {
-		float bw_on_fabric = entry->fabricclk_mhz * dcn3_2_soc.return_bus_width_bytes * ((float)dcn3_2_soc.pct_ideal_fabric_bw_after_urgent / 100);
-
-		entry->dcfclk_mhz = bw_on_fabric / (dcn3_2_soc.return_bus_width_bytes * ((float)dcn3_2_soc.pct_ideal_sdp_bw_after_urgent / 100));
-		entry->dram_speed_mts = bw_on_fabric / (dcn3_2_soc.num_chans *
-				dcn3_2_soc.dram_channel_width_bytes * ((float)dcn3_2_soc.pct_ideal_dram_sdp_bw_after_urgent_pixel_only / 100));
-	} else if (entry->dram_speed_mts > 0) {
-		float bw_on_dram = entry->dram_speed_mts * dcn3_2_soc.num_chans *
-				dcn3_2_soc.dram_channel_width_bytes * ((float)dcn3_2_soc.pct_ideal_dram_sdp_bw_after_urgent_pixel_only / 100);
-
-		entry->fabricclk_mhz = bw_on_dram / (dcn3_2_soc.return_bus_width_bytes * ((float)dcn3_2_soc.pct_ideal_fabric_bw_after_urgent / 100));
-		entry->dcfclk_mhz = bw_on_dram / (dcn3_2_soc.return_bus_width_bytes * ((float)dcn3_2_soc.pct_ideal_sdp_bw_after_urgent / 100));
-	}
-}
-
 static void remove_entry_from_table_at_index(struct _vcs_dpi_voltage_scaling_st *table, unsigned int *num_entries,
 		unsigned int index)
 {
@@ -2062,7 +2039,6 @@ static int build_synthetic_soc_states(struct clk_bw_params *bw_params,
 		entry.fabricclk_mhz = 0;
 		entry.dram_speed_mts = 0;
 
-		get_optimal_ntuple(&entry);
 		DC_FP_START();
 		insert_entry_into_table_sorted(table, num_entries, &entry);
 		DC_FP_END();
@@ -2073,7 +2049,6 @@ static int build_synthetic_soc_states(struct clk_bw_params *bw_params,
 	entry.fabricclk_mhz = 0;
 	entry.dram_speed_mts = 0;
 
-	get_optimal_ntuple(&entry);
 	DC_FP_START();
 	insert_entry_into_table_sorted(table, num_entries, &entry);
 	DC_FP_END();
@@ -2084,7 +2059,6 @@ static int build_synthetic_soc_states(struct clk_bw_params *bw_params,
 		entry.fabricclk_mhz = 0;
 		entry.dram_speed_mts = bw_params->clk_table.entries[i].memclk_mhz * 16;
 
-		get_optimal_ntuple(&entry);
 		DC_FP_START();
 		insert_entry_into_table_sorted(table, num_entries, &entry);
 		DC_FP_END();
@@ -2097,7 +2071,6 @@ static int build_synthetic_soc_states(struct clk_bw_params *bw_params,
 			entry.fabricclk_mhz = bw_params->clk_table.entries[i].fclk_mhz;
 			entry.dram_speed_mts = 0;
 
-			get_optimal_ntuple(&entry);
 			DC_FP_START();
 			insert_entry_into_table_sorted(table, num_entries, &entry);
 			DC_FP_END();
@@ -2109,7 +2082,6 @@ static int build_synthetic_soc_states(struct clk_bw_params *bw_params,
 		entry.fabricclk_mhz = max_fclk_mhz;
 		entry.dram_speed_mts = 0;
 
-		get_optimal_ntuple(&entry);
 		DC_FP_START();
 		insert_entry_into_table_sorted(table, num_entries, &entry);
 		DC_FP_END();
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 66102db87265..7c60a954737b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -353,6 +353,29 @@ static float calculate_net_bw_in_kbytes_sec(struct _vcs_dpi_voltage_scaling_st *
 	return limiting_bw_kbytes_sec;
 }
 
+static void get_optimal_ntuple(struct _vcs_dpi_voltage_scaling_st *entry)
+{
+	if (entry->dcfclk_mhz > 0) {
+		float bw_on_sdp = entry->dcfclk_mhz * dcn3_2_soc.return_bus_width_bytes * ((float)dcn3_2_soc.pct_ideal_sdp_bw_after_urgent / 100);
+
+		entry->fabricclk_mhz = bw_on_sdp / (dcn3_2_soc.return_bus_width_bytes * ((float)dcn3_2_soc.pct_ideal_fabric_bw_after_urgent / 100));
+		entry->dram_speed_mts = bw_on_sdp / (dcn3_2_soc.num_chans *
+				dcn3_2_soc.dram_channel_width_bytes * ((float)dcn3_2_soc.pct_ideal_dram_sdp_bw_after_urgent_pixel_only / 100));
+	} else if (entry->fabricclk_mhz > 0) {
+		float bw_on_fabric = entry->fabricclk_mhz * dcn3_2_soc.return_bus_width_bytes * ((float)dcn3_2_soc.pct_ideal_fabric_bw_after_urgent / 100);
+
+		entry->dcfclk_mhz = bw_on_fabric / (dcn3_2_soc.return_bus_width_bytes * ((float)dcn3_2_soc.pct_ideal_sdp_bw_after_urgent / 100));
+		entry->dram_speed_mts = bw_on_fabric / (dcn3_2_soc.num_chans *
+				dcn3_2_soc.dram_channel_width_bytes * ((float)dcn3_2_soc.pct_ideal_dram_sdp_bw_after_urgent_pixel_only / 100));
+	} else if (entry->dram_speed_mts > 0) {
+		float bw_on_dram = entry->dram_speed_mts * dcn3_2_soc.num_chans *
+				dcn3_2_soc.dram_channel_width_bytes * ((float)dcn3_2_soc.pct_ideal_dram_sdp_bw_after_urgent_pixel_only / 100);
+
+		entry->fabricclk_mhz = bw_on_dram / (dcn3_2_soc.return_bus_width_bytes * ((float)dcn3_2_soc.pct_ideal_fabric_bw_after_urgent / 100));
+		entry->dcfclk_mhz = bw_on_dram / (dcn3_2_soc.return_bus_width_bytes * ((float)dcn3_2_soc.pct_ideal_sdp_bw_after_urgent / 100));
+	}
+}
+
 void insert_entry_into_table_sorted(struct _vcs_dpi_voltage_scaling_st *table,
 				    unsigned int *num_entries,
 				    struct _vcs_dpi_voltage_scaling_st *entry)
@@ -363,6 +386,8 @@ void insert_entry_into_table_sorted(struct _vcs_dpi_voltage_scaling_st *table,
 
 	dc_assert_fp_enabled();
 
+	get_optimal_ntuple(entry);
+
 	if (*num_entries == 0) {
 		table[0] = *entry;
 		(*num_entries)++;
-- 
2.37.0

