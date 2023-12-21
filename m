Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74228C35274
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Dec 2023 18:11:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EFAD10E348;
	Thu, 21 Dec 2023 18:11:28 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24E9410E348
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Dec 2023 18:11:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kE1qOiwaNe05kofLXXdU/54bJxFIRqc2XGdzBbonXhB86n/fefzaDsZ6xRHHErzSHfN0+Gqiho1FiyE9d06iwmVDZsYEWGLhGgkRisFRBWlY9rGvgJXiZoig3ODudM+Q7Ap5H1T0ZO1Sxo9NLjKPk6ZH59IHYGIzSHB0qJmfDF0vfLmZtqUbFxYAVzY/tRx13jJCAqiIFonb/fhHZviDCQdTJyBj6XnbkPuQsAdv4rQOz72lLi0SNqL2md61cVaM4fcjzfg8kSpkIfaEHwU7e5pqw0NKM78E55mOHdGs8GJ0Cds0gGCojpdN71kjAsamAktLegFZKjQKHc4CHg7U5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gmYos1RyIT0OpIbgr2zPZrhh6Ly+/SakS6yyq+whKP0=;
 b=LExdA8vA1Jryma7IkQreMa1cLnIFgKGzojTBbKjrF4OSqsrAqgr6d5OOPW8Wfu1R6re9nwcEdLY/LPjnQnY8XczunVVcNW4DTizEYC+IgC6pozqZU2HSfJ+N3N66Hlc0cSYFJZT+cl+hzTm1CUVFv+y5JtoPqpDImzQ4l9PvSNXnXxwWl0B7k1qWdQX4NslzGkh4qIQACowCPHRzekFBfsN8qQh2TWTdjP8ddul9s/6MNY6gXm06v2ajil3/zkPGfQ6CyK8s4D1tLDECKyOEPgNLHOrdeuJkV7Hp9mC2Zsdz4uL8ftrIh+5wQ20Z6U2ZvLOoG+XP78oVBkkgrWbikg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gmYos1RyIT0OpIbgr2zPZrhh6Ly+/SakS6yyq+whKP0=;
 b=Sd/PTEZS5Owx8wVlQXd+BSg+Dqh9GjJib7TsG2duoQPIWsiwtQht3ZVfNQ0h66PUXQPb9j/uSQotho0MOHdBBSdcFqG15wQwEwgwD+ll+r+M3HnCbgakHiTJqPrWyJY/NWh46ESAhBDsxV3kNN7gZDYscshMA2XueJkanNh1K34=
Received: from CH5P221CA0022.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::23)
 by IA0PR12MB7776.namprd12.prod.outlook.com (2603:10b6:208:430::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Thu, 21 Dec
 2023 18:11:22 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:610:1f2:cafe::32) by CH5P221CA0022.outlook.office365.com
 (2603:10b6:610:1f2::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21 via Frontend
 Transport; Thu, 21 Dec 2023 18:11:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Thu, 21 Dec 2023 18:11:22 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 21 Dec
 2023 12:11:20 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amd/display: add nv12 bounding box
Date: Thu, 21 Dec 2023 13:11:05 -0500
Message-ID: <20231221181106.17924-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|IA0PR12MB7776:EE_
X-MS-Office365-Filtering-Correlation-Id: a28b3ba2-64aa-4766-dea4-08dc02503cd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J/PJeha7yp1JiZKM63WFzqUQ9BigbNjFwSCqB0+3w0KNqgq48v0ZgOZiFGwTcQaah7vHWYjQreFZXGDMLFGo0yH9ee3BN3u19j6vk6JaV2X2kJb8OlVm6xaytVcDLX5KOOsNtFuRHs/rlW+TF28Xe+ImOMRht6kQi7lWR4FLT6nZsgikEjsa33kFl4F6qFS5g2P6DWW12WfQGaWQTNksMTUtlbWKLtyjBCQKGYm40760jOK9HkHqmOPu0oBGt31djcz9NPSVT8uC4afvbi9SHYAjPoERqQPAPAdIMZYeWwP7+NyAzaET+GpuugyOea6TLx1DNpVDraBSt6xaG7unK1tGrElyEPnuj+yjVye9KKN5qj/HV1cnWJQ+0XbbOs3xFSQT44hVrUGCqBPtBYukP5k7mP8t09CRFISA29hJFHAxlkyShYchKZjR9+oSae8+TP5Oxk5l53mceuVL0qhJ7V/LgLPk4Q3Hi93dlDCz0ebscDkBbS2OlXsjexqqsFjdOKnwmIsRQ8ktXI8mS1buZ2VAjAZCECp/sbvvWtsUThzT9Thac8DYovzIot6sDgy4GldUfm1NLAFKF3VcO8trFOnVSq+pxMQVLH4KE0KEH82nAAx3j9xg2n2AyxH7oC36iecazvicXGlvVSoOBnIAnWGJrCDsGoWnW1PIsi+bXLddWCbVFfdAfuSZ7oW9+NdEY+7LLzMSXy0qjjNdJs7n00MAsR7AEpLb4FKSTwWwzoh8bId/fxfu0kyNMYB4hu5MxdhrkFTsyxlyNCiLiY8fpPmEOSevo+mUVsjyMV7dWgc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(376002)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(82310400011)(1800799012)(186009)(46966006)(40470700004)(36840700001)(8936002)(8676002)(4326008)(316002)(40480700001)(47076005)(478600001)(2616005)(7696005)(966005)(6916009)(40460700003)(70586007)(70206006)(6666004)(36756003)(86362001)(26005)(1076003)(83380400001)(2906002)(66899024)(41300700001)(16526019)(5660300002)(336012)(82740400003)(356005)(81166007)(36860700001)(426003)(36900700001)(357404004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 18:11:22.0471 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a28b3ba2-64aa-4766-dea4-08dc02503cd8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7776
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This was included in gpu_info firmware, move it into the
driver for consistency with other nv1x parts.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2318
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  | 110 +++++++++++++++++-
 1 file changed, 109 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
index 1ec8ca1fdb4f..38ab9ad60ef8 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
@@ -441,7 +441,115 @@ struct _vcs_dpi_soc_bounding_box_st dcn2_0_nv14_soc = {
 	.use_urgent_burst_bw = 0
 };
 
-struct _vcs_dpi_soc_bounding_box_st dcn2_0_nv12_soc = { 0 };
+struct _vcs_dpi_soc_bounding_box_st dcn2_0_nv12_soc = {
+	.clock_limits = {
+		{
+			.state = 0,
+			.dcfclk_mhz = 560.0,
+			.fabricclk_mhz = 560.0,
+			.dispclk_mhz = 513.0,
+			.dppclk_mhz = 513.0,
+			.phyclk_mhz = 540.0,
+			.socclk_mhz = 560.0,
+			.dscclk_mhz = 171.0,
+			.dram_speed_mts = 1069.0,
+		},
+		{
+			.state = 1,
+			.dcfclk_mhz = 694.0,
+			.fabricclk_mhz = 694.0,
+			.dispclk_mhz = 642.0,
+			.dppclk_mhz = 642.0,
+			.phyclk_mhz = 600.0,
+			.socclk_mhz = 694.0,
+			.dscclk_mhz = 214.0,
+			.dram_speed_mts = 1324.0,
+		},
+		{
+			.state = 2,
+			.dcfclk_mhz = 875.0,
+			.fabricclk_mhz = 875.0,
+			.dispclk_mhz = 734.0,
+			.dppclk_mhz = 734.0,
+			.phyclk_mhz = 810.0,
+			.socclk_mhz = 875.0,
+			.dscclk_mhz = 245.0,
+			.dram_speed_mts = 1670.0,
+		},
+		{
+			.state = 3,
+			.dcfclk_mhz = 1000.0,
+			.fabricclk_mhz = 1000.0,
+			.dispclk_mhz = 1100.0,
+			.dppclk_mhz = 1100.0,
+			.phyclk_mhz = 810.0,
+			.socclk_mhz = 1000.0,
+			.dscclk_mhz = 367.0,
+			.dram_speed_mts = 2000.0,
+		},
+		{
+			.state = 4,
+			.dcfclk_mhz = 1200.0,
+			.fabricclk_mhz = 1200.0,
+			.dispclk_mhz = 1284.0,
+			.dppclk_mhz = 1284.0,
+			.phyclk_mhz = 810.0,
+			.socclk_mhz = 1200.0,
+			.dscclk_mhz = 428.0,
+			.dram_speed_mts = 2000.0,
+		},
+		{
+			.state = 5,
+			.dcfclk_mhz = 1200.0,
+			.fabricclk_mhz = 1200.0,
+			.dispclk_mhz = 1284.0,
+			.dppclk_mhz = 1284.0,
+			.phyclk_mhz = 810.0,
+			.socclk_mhz = 1200.0,
+			.dscclk_mhz = 428.0,
+			.dram_speed_mts = 2000.0,
+		},
+	},
+
+	.num_states = 5,
+	.sr_exit_time_us = 1.9,
+	.sr_enter_plus_exit_time_us = 4.4,
+	.urgent_latency_us = 3.0,
+	.urgent_latency_pixel_data_only_us = 4.0,
+	.urgent_latency_pixel_mixed_with_vm_data_us = 4.0,
+	.urgent_latency_vm_data_only_us = 4.0,
+	.urgent_out_of_order_return_per_channel_pixel_only_bytes = 4096,
+	.urgent_out_of_order_return_per_channel_pixel_and_vm_bytes = 4096,
+	.urgent_out_of_order_return_per_channel_vm_only_bytes = 4096,
+	.pct_ideal_dram_sdp_bw_after_urgent_pixel_only = 40.0,
+	.pct_ideal_dram_sdp_bw_after_urgent_pixel_and_vm = 40.0,
+	.pct_ideal_dram_sdp_bw_after_urgent_vm_only = 40.0,
+	.max_avg_sdp_bw_use_normal_percent = 40.0,
+	.max_avg_dram_bw_use_normal_percent = 40.0,
+	.writeback_latency_us = 12.0,
+	.ideal_dram_bw_after_urgent_percent = 40.0,
+	.max_request_size_bytes = 256,
+	.dram_channel_width_bytes = 16,
+	.fabric_datapath_to_dcn_data_return_bytes = 64,
+	.dcn_downspread_percent = 0.5,
+	.downspread_percent = 0.5,
+	.dram_page_open_time_ns = 50.0,
+	.dram_rw_turnaround_time_ns = 17.5,
+	.dram_return_buffer_per_channel_bytes = 8192,
+	.round_trip_ping_latency_dcfclk_cycles = 131,
+	.urgent_out_of_order_return_per_channel_bytes = 4096,
+	.channel_interleave_bytes = 256,
+	.num_banks = 8,
+	.num_chans = 16,
+	.vmm_page_size_bytes = 4096,
+	.dram_clock_change_latency_us = 45.0,
+	.writeback_dram_clock_change_latency_us = 23.0,
+	.return_bus_width_bytes = 64,
+	.dispclk_dppclk_vco_speed_mhz = 3850,
+	.xfc_bus_transport_time_us = 20,
+	.xfc_xbuf_latency_tolerance_us = 50,
+	.use_urgent_burst_bw = 0,
+};
 
 struct _vcs_dpi_ip_params_st dcn2_1_ip = {
 	.odm_capable = 1,
-- 
2.42.0

