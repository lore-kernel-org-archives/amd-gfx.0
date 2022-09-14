Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E767ECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 03:26:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9995B10E7E4;
	Wed, 14 Sep 2022 03:26:48 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 476BB10E7E4
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 03:26:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BCe48a0qhDK7ntVI9pIJkj8xOy4FM0KpNIIXEZgcxrMr2Zc46GbJAr7nwuXbGta5KQlYjwHw65OVm0ZXBTR0wdbbU9c6lHJCHWp6FbEclw494lKPl9kOpVJ++RRQSymZgt9IKbTUQ7DZVc81aOqFBKHQMR9zJ6Nq7hu2JWMAmcKvXbafnjvx4bFCB3bZ3DkaGULe2z+WVBWFoQzUiyMK9cotEKzgIcI1RLgQ8z1AcJKr+vXKT3l0bWQSAU4PGi+Sk+/lsq14i/wIL79p66KOyhiHFtjaqv5RD5bUg1UfF/5owsxwumrKup94t6Bf4xuM74soKOH4XBPFxGabthp9Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KJ+l6K0V3ahRsZYLA89IzNFSMTauGUR7usEpPMvvFUI=;
 b=RpOkrUQCG1jeNj5ajcSoXP9DKbI0Ztcu7zSCBvYP/n8jaiDWHm7nVCbxB8raIa82vHMe1OZHLlafpcOPJU/w0zqE7z8eGtAFOO/Fs2tBuPud13FmYsOuBPY+9Rf5+DahX9+qkBHIYjqNHBIMbqW0FWPWZ0r1+DzO5zS2GkVp8fYT6OeBktpF3PqCE+k9HNNMtqXHnS5/J50+hQgVdl7rl7v/+tTDbvKjZ10LT0UmboGER0QKWY3u8VhqiqXoa8e9k+57V76HOZJFM8YG+VlNRrcvlzpkyI9b0KZnJrEnaMo7AbvnRU86KHpnykPAsZo0Ach75+smYrLqgCHJA/veYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJ+l6K0V3ahRsZYLA89IzNFSMTauGUR7usEpPMvvFUI=;
 b=E/9SlI8Bn2OVqQrIHPpKK2ImT/6OXw72edn2bsnkz3DSuJcThtMB+KXQT+5fsMf248LXVRg2wuaVqWrjtjKJAAwr8l76REw6C+kxBWih0UfZUgOhTGfQeFvcT6oYKrVOBAOpEP8Xyic8pz/HJbJZaU4TH2dZlBya83IfKFjJfu8=
Received: from DM6PR21CA0023.namprd21.prod.outlook.com (2603:10b6:5:174::33)
 by BY5PR12MB4872.namprd12.prod.outlook.com (2603:10b6:a03:1c4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Wed, 14 Sep
 2022 03:26:41 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::a7) by DM6PR21CA0023.outlook.office365.com
 (2603:10b6:5:174::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.5 via Frontend
 Transport; Wed, 14 Sep 2022 03:26:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 03:26:40 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:26:40 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 20:26:39 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 13 Sep 2022 22:26:35 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/47] drm/amd/display: fix dcn315 memory channel count and
 width read
Date: Wed, 14 Sep 2022 11:24:02 +0800
Message-ID: <20220914032441.1075031-9-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914032441.1075031-1-Wayne.Lin@amd.com>
References: <20220914032441.1075031-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT048:EE_|BY5PR12MB4872:EE_
X-MS-Office365-Filtering-Correlation-Id: 67026361-8da6-4ebc-6370-08da9600f09b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: leXNfCkIy9hq8OUnukNgOxDlr1sFkYLBqaigqg6Gx5tmW2LTu2/xloGKpGgJ9zsJs4+O3dy+3xxoeKl1ihcQlAghiNTU4VUOMimoQ2VXbyow5i72id+IbPHyZD6PbeuRNB47AM6BKvte5YJV50WmJcYTFajCdQSvfZj0Ea8glhFvqePHUMKRdawCZqe73xYZ4zeyFpleRZtqumpxdA8Ztup4eFRPPtH5rwEzmMY25Fq0KmtkVV1BifImK2fRU+bSFRoswY7EMugskIunHSKGPihaJgiKJWvQeaysvVo9AY6bMrMzM+TrCakvacww/9rOj9NaG3XHjTmNzAy5wiMSkEULx6J6pQpNQkhZboYElpC/s3kax2r0pG9tUr+mPSXfcxSKe8M8OiUngx9jLaHYOm50tkZLswK78PnBDxuqempuWlI4K6+Izf33ugZKAgSunWEo0jYlmJqF24sHbf9eCKX0P7IhI5WcJgIKHQOZSeh/ZZSEC4+q/JIBPgaR9TIB6dt6/oSpwzdlwgY+l6t/8kisEBQybZNYCxCEk0Zcg674dxRo7Z1vIQnybET1Y1s+ufn/WPGxihyagM8Byipznu4Q9WAcWZROMSYDX8zXW+GwqHYhxUVw2j+wKJaiNwmOmayvW9eO9q5m/LxPINMn5ZQrn9Eb7om9oVw6medaE3GsuwMMry3kWKFyhAjzdC6K/Eqq/Sad+V8Obh3sGOPWaqaG8h7Ap88W2epWfgGWhDt6t55jQwcgvStcy5rnQuQ0yujPuLTE653VY82Uh72F9gRoTj8SkmA3WsG/1GP6wpgCvDCy7aPra5Jy/SDqXhsh
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(396003)(39860400002)(376002)(451199015)(40470700004)(36840700001)(46966006)(5660300002)(4326008)(2906002)(40460700003)(8676002)(86362001)(82310400005)(54906003)(356005)(36756003)(81166007)(47076005)(83380400001)(70206006)(1076003)(426003)(478600001)(26005)(336012)(7696005)(316002)(6666004)(8936002)(6916009)(186003)(82740400003)(40480700001)(70586007)(41300700001)(2616005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 03:26:40.6290 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67026361-8da6-4ebc-6370-08da9600f09b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4872
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
Cc: stylon.wang@amd.com, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

[Why & How]
Correctly set ddr5 channel width to 8 bytes

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
---
 .../gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c | 3 +--
 drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c       | 7 ++++++-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
index 14071aef5eab..dd6abfba9253 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
@@ -561,8 +561,7 @@ static void dcn315_clk_mgr_helper_populate_bw_params(
 	ASSERT(bw_params->clk_table.entries[i-1].dcfclk_mhz);
 	bw_params->vram_type = bios_info->memory_type;
 	bw_params->num_channels = bios_info->ma_channel_number;
-	if (!bw_params->num_channels)
-		bw_params->num_channels = 2;
+	bw_params->dram_channel_width_bytes = bios_info->memory_type == 0x22 ? 8 : 4;
 
 	for (i = 0; i < WM_SET_COUNT; i++) {
 		bw_params->wm_table.entries[i].wm_inst = i;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
index 43230709bd11..b6e99eefe869 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
@@ -291,6 +291,7 @@ static struct _vcs_dpi_soc_bounding_box_st dcn3_15_soc = {
 	.do_urgent_latency_adjustment = false,
 	.urgent_latency_adjustment_fabric_clock_component_us = 0,
 	.urgent_latency_adjustment_fabric_clock_reference_mhz = 0,
+	.num_chans = 4,
 };
 
 struct _vcs_dpi_ip_params_st dcn3_16_ip = {
@@ -688,7 +689,11 @@ void dcn315_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_param
 
 	dcn3_15_ip.max_num_otg = dc->res_pool->res_cap->num_timing_generator;
 	dcn3_15_ip.max_num_dpp = dc->res_pool->pipe_count;
-	dcn3_15_soc.num_chans = bw_params->num_channels;
+
+	if (bw_params->num_channels > 0)
+		dcn3_15_soc.num_chans = bw_params->num_channels;
+	if (bw_params->dram_channel_width_bytes > 0)
+		dcn3_15_soc.dram_channel_width_bytes = bw_params->dram_channel_width_bytes;
 
 	ASSERT(clk_table->num_entries);
 
-- 
2.37.3

