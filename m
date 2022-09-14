Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBDF6ECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 03:49:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A97F10E7FF;
	Wed, 14 Sep 2022 03:49:48 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0ACE210E7FF
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 03:49:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N2+TCZF2gxbwpKWyQbAyUOH2pLt/NzXSaGPX1cVwiQhgscDt4Af2QaDDcPWO0ae8J4SSQX1Nq4343Sx2ZoYRyciZws/ZxGRc+4aJtuZastLo9jKCfSyHyTh7QOxr+ZQRPZmgeceuLY5sNaogsbg8RV2BOmTWmJL4DuDMq3xmNFVN6s9RWCMcI7SCgHg2TIu/XxIM6Tc90T58W6UY/FRLPy9pz49DjH4+pmKI4eKttEMklg8np72rsvqdGeJKGiIFDQlthmm05C+i/iXsMyDYBUweBsaX4v9quitheXh7hSOh2LiSsZxcnC3yy8EiT2b0sFk7a+4xXqHEg8lgkhduTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KJ+l6K0V3ahRsZYLA89IzNFSMTauGUR7usEpPMvvFUI=;
 b=VjuMqh5jRx1+6mqBHoyThFCIg68Lh3N/OQhVQ6eVKsXQ0RdByclUYZ8rKxkcKVmVhkWuE7hBiO/MW4vPuv8pg7gv+Qg0vmi8nJZ+/ni+158PmOREGM8O74dLMfQJQV3nz9hfVMcgVtvqKvQpAGL1Bu07OF+iDlfZy2YL9BIep5FjNTG2JvjcciLfcXSKsMVpYbQZnc4ZQJm5+e3U5XO8Atob6hwpbJO5fr3lPDQ62NnLy71iMTme8bFWNqnF52ITYDswIMBa7R5J1KI3HvmkdVQwkhRW5ELUm2bAfijKzgk4WWdC96ZJ6uwJu6yCCcbeRyR8UVmf51qVC/1OCx/RaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJ+l6K0V3ahRsZYLA89IzNFSMTauGUR7usEpPMvvFUI=;
 b=WcajQ4QXgpZA2x2eLLEjwdNCr2BxUBO1tyqAiimqLU7x+mQC0sZGR2D+MpiD5KO0Iz4F/ISgWDTiqQzXXIGWBQ5N7x9bjjwG6Ztq3SijDmW0wN8VsAOb50ofcspS7qaz3+Q92LBZLwiCistQH9X79EyI0B2QWUEt+8jkvyhS2JA=
Received: from DM6PR07CA0119.namprd07.prod.outlook.com (2603:10b6:5:330::11)
 by BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 03:49:41 +0000
Received: from CY4PEPF0000B8E8.namprd05.prod.outlook.com
 (2603:10b6:5:330:cafe::e0) by DM6PR07CA0119.outlook.office365.com
 (2603:10b6:5:330::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.12 via Frontend
 Transport; Wed, 14 Sep 2022 03:49:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000B8E8.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.12 via Frontend Transport; Wed, 14 Sep 2022 03:49:39 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:49:39 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:49:38 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 13 Sep 2022 22:49:34 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 08/47] drm/amd/display: fix dcn315 memory channel count and
 width read
Date: Wed, 14 Sep 2022 11:47:29 +0800
Message-ID: <20220914034808.1093521-9-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914034808.1093521-1-Wayne.Lin@amd.com>
References: <20220914034808.1093521-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8E8:EE_|BL1PR12MB5874:EE_
X-MS-Office365-Filtering-Correlation-Id: 044d5c20-ed18-459f-3460-08da960426b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eeb+NAYblyIJzOXmgL0TZB+trZQCj9vwGyYvZzQupbXqMN/1yTQvThZ7P4FJUkem2KRVvsFZM5m5XIFcORFMXiKaQz8cS8fi+TnRGIIbZlExaYHtGkoSn4aopr2dphHiuvncr2TZg+5hsmOtCsqQ1aVqfMU6ewZHhUwatTE6fcuCCe1N/OdAvVUx6Z7cR1p9jeFiTbEQTmAev7KsdOGcVy8cyXe7uUdmGieqG+8+zHSpQvTAdv8rri6ZMqf8iU07bNiAe98A3ItzmFxyARCdjaA5kFCLuXW3L8pTIp4kBo6wd3FsJp+MpKe2q3ldQybrDhqtrNo3yZJ1lFYI9JE1Q1LnD6DYhnPpNImKvSArEY9YECG3hGzW1pNbLG9xqDkhlMevbuugUZF/wirTR5djx06MzYof1EF80uzR7vuHQMhPKNLzMOPP6V1GAHrhHP2rvbdvWbu0/RlaBlrzAoOdqmqvNIFuenM1cnol9U4FTMR5EG6NA7orzK5eHjViZF6iB2E8pIJMTgoxoUfpHiywbkE6F4xzuiPzibfnjky+CgYqi2ge4eYvSM6XD5/nr3tA1pEc+Nh3pC3OvamxTTB9Q9bzW9o+FFlnJRuuoxKHikOEQr9oOqGCAiab1Fdz0un8xPbEDRPmJa0WvmHBYxfwV/N+6X9CJeO7drlo36JXhHrq36oz3u5EYfm3/UNNa9duLl3II2Rcd9Wv+970Sed2fhZAbWXJmrriQXxJ/WTu4QHYmiMVGfqEfFZnC5LfECi4RQkE8BSWjyQLici+2I9hRgStvIP8HM9ogLyodee13V4NdOced8SAyYPV1aB13MKC
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(396003)(39860400002)(346002)(376002)(451199015)(40470700004)(36840700001)(46966006)(41300700001)(4326008)(8676002)(7696005)(54906003)(6666004)(83380400001)(47076005)(316002)(478600001)(26005)(40480700001)(82310400005)(70586007)(2906002)(70206006)(186003)(2616005)(336012)(426003)(5660300002)(40460700003)(8936002)(6916009)(1076003)(36860700001)(81166007)(36756003)(82740400003)(356005)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 03:49:39.8763 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 044d5c20-ed18-459f-3460-08da960426b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5874
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

