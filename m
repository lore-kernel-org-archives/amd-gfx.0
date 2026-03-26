Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92759109E542
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 03:01:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3838210E935;
	Thu, 26 Mar 2026 03:01:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UxXUcWkg";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013009.outbound.protection.outlook.com
 [40.93.201.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6018310E935
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 03:01:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BIF5jxCzHBisIEX7otSEp7SyDD7o7A9l7IlClqho3j1pVyqBcVc14sYAqPk3LRdlarLXjWFKzLHlO63fuABSbLAy9Zk4kHxlj9ORYjQifv7FglBk8G28fjduGvMmns5Iqi14lOnpoqpaIwMPW2iKyOOitczQ0GAi5900Nr63Ojsy/vf0w/V//in4g9nugkUFcWxeCnuh92i/fjZzym186xUwI11WFcEqA+zpXmDUGN4Gd8ok2QVak31SFM+VNlwKLdwTegID2xdxgMlfY+T+Wvz1WY/tRxeNxFApi+qh2ipWvwB/CgOvRhGLnlMAO+IzkUnU79U61Cc5cGW10MuERw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PfZtblQ7Z25J7O1tb9cBGjBu7Gc4Y2JJP9s8US33/aE=;
 b=GYDpMrIvN7L0kS8Me3cly4yClxoAXzrom9ldLLQrGkv7zZx1kW6V4uWpgYPeun7mwJd1Y5VCTD0zJ24uuGXZIonE+C+vni94KpT+RrtExW0iiFrH8lxYrAVTfNhywsb/lAjIseGUWAkRyoe4OinsqwB8dXKEZ+6Qeus0PZu5fDZyqPewszNaa1A1ND0+C/BTuoGHKDQQPoWmC6FAxAzL57FCmnha/uqbX6/9VxLBLk6VQq0qng0gdBQgdJSVaIGNXOXbVIN3LZsQxbfn0mV5jO7TSSjnteToT+MLYPB6jMPTz5T/N656ZDZdTfJJFlAgiTpsiW3fyyZZ6+Iu0Jh7yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PfZtblQ7Z25J7O1tb9cBGjBu7Gc4Y2JJP9s8US33/aE=;
 b=UxXUcWkgig0mFluJeoXlAGazlYNhUpI2YtejKDowexp/mr6U83mgYEecjsd0aajJvACjYOwRO+cJETH8OwM5MUifA2t7tB4YZ+Y2/SVnIHQypokUzr3HaOTAUB5O2VNQbqYC2om7lygSRMqF3AusNXZEa+2uRZ8MZQWa6ShPcjM=
Received: from BL0PR0102CA0023.prod.exchangelabs.com (2603:10b6:207:18::36) by
 LV2PR12MB6014.namprd12.prod.outlook.com (2603:10b6:408:170::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 03:01:11 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:207:18:cafe::f0) by BL0PR0102CA0023.outlook.office365.com
 (2603:10b6:207:18::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.32 via Frontend Transport; Thu,
 26 Mar 2026 03:01:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 03:01:10 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Mar
 2026 22:01:03 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Gaghik Khachatrian <gaghik.khachatrian@amd.com>, "Dillon
 Varone" <dillon.varone@amd.com>, Chuanyu Tseng <chuanyu.tseng@amd.com>
Subject: [PATCH v2 11/30] drm/amd/display: Fix Silence signed/unsighed
 mismatch warning in dc
Date: Thu, 26 Mar 2026 10:57:02 +0800
Message-ID: <20260326030153.406612-12-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260326030153.406612-1-ChuanYu.Tseng@amd.com>
References: <20260326030153.406612-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|LV2PR12MB6014:EE_
X-MS-Office365-Filtering-Correlation-Id: a36ef522-6463-4e4b-e7b7-08de8ae3ef35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|56012099003|22082099003|18002099003|20052099010;
X-Microsoft-Antispam-Message-Info: n9MjtwGgsfl+fLvOyNFO9Wlhw259hpDUaP2aNtwnOkByYrLoQFZm99Hi59eaYjY+bAyt9ISGj20hsh/XM8igSPEIDq+49iX9RURjyFBqRyTX9W1UaSTYu5/zkz8YwYlCgXJXf0e4t5/lQ489s9VC0J6dmmgX4BA8ILeYAV3eE9iOuMiJ9kU30ZY5AMF+/xeHA3/BTEcHBuAEUE8C5t7KvPqtvfZ7S1QALaRUzLbj87r+hY4hkoUTMmKBlpryXgLHxxqN7hBLK0lWseCFy17cjGb+X7Vy4Ec4/XsaTr+S/qqgQk4XYZkgdyj6mezevJItesp2d8kpjrMcUUF51SEwJLcNOA0gFyVlR2EwOnR4KqlYetpi31DjWxUMlMEIN/7Au/X2bZOmoMmH5OAlpn5KaqEgJ8aju989kNnrFVppD2AGjwRFw6k5cmBBGIH9iFmHxQbP/5+JNLoPDtx2BomNCXcBqFJ4brP2CPwj+GFx7OXFXIYPdbWVSPXL9x9ZE1l3C5CyO1Y+conIPI30CNrBYM+PNKWENPIC7GO6lA8u9U67L6TXjBHsdtwnutrCd5NE2iZCMLOqEr9cYFzPUInrXbhr7SfaSdLZcOijTvQi3gOyaaDRaT76wzc4OBNrgL5rIlhaYc/aEvhRS9e8682rxnz6TwMtz0FL1LxZNCvRAIxmrjlIiJEKWeJD23GtPqvlrNMCRZI0HjeVyBVo082/Y8qSZtTNp151wTzz5AJpKKxrrGUyPdz+IhAgeOmIlxt9/TIP8KvWipwpvVvBf1BT6w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(56012099003)(22082099003)(18002099003)(20052099010);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1tDxFwK5xurhQW3au1kdcKjOGVGTN3TTjg7p+em7MtseNqNnncBn6MdH3Pldfp8yE/qWYuFFRX8j456SLEYStSOlMnMHiIgigLM36C4vhcmWOqFVbFlW94EBrdUGqjo9Cbn9k83HhGFMmQLTOP6uSsDNwkylYA74QPhfFv7oRDvicBCVsNfuMQ5OVvUDI8pLlBbIYedBqEFN7r0Z5QrQjXJ86BNLt4cQnISKUK5gIuik665KJzSGxB1Hio2HV3E6eq1XWsSe7ee7SSOhSF6/egwjynIhVByILSfZNiUT7CISdTuyWxsuo8ZQcwa66cj7qd72+DsfzK8hvkgo7haIdHSEZabFdjuo1J1hOF4z+prgfaa+FUnsWnt4zm1bZejk02XgnNzvtiM4pZ0zmqVslMi7XSVbcdZad3mB6YBM8jdyxtp6xRJdxolgmvldxzkY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 03:01:10.8267 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a36ef522-6463-4e4b-e7b7-08de8ae3ef35
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6014
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

From: Gaghik Khachatrian <gaghik.khachatrian@amd.com>

[Why]
Implicit signed-to-unsigned conversions caused compiler
warnings in DC paths.

[How]
Added explicit (unsigned int)/(uint32_t) casts for sentinel -1
assignments and IRQ ~MASK initializers, with small cast alignment
in logging/DPCD code.

Functionality and behavior is unchanged; only type intent is explicit.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Gaghik Khachatrian <gaghik.khachatrian@amd.com>
Signed-off-by: Chuanyu Tseng <chuanyu.tseng@amd.com>
---
 drivers/gpu/drm/amd/display/dc/basics/dce_calcs.c    |  8 ++++----
 .../amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c   |  2 +-
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c    |  2 +-
 .../gpu/drm/amd/display/dc/dce/dce_clock_source.c    |  6 +++---
 .../gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c   |  8 ++++----
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dwb_scl.c |  4 ++--
 .../gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c   |  4 ++--
 drivers/gpu/drm/amd/display/dc/dml/dcn10/dcn10_fpu.c |  2 +-
 .../drm/amd/display/dc/hwss/dce110/dce110_hwseq.c    | 12 ++++++------
 .../amd/display/dc/irq/dce110/irq_service_dce110.c   | 10 +++++-----
 .../amd/display/dc/irq/dce120/irq_service_dce120.c   |  2 +-
 .../drm/amd/display/dc/irq/dce80/irq_service_dce80.c | 10 +++++-----
 .../drm/amd/display/dc/irq/dcn10/irq_service_dcn10.c |  2 +-
 .../drm/amd/display/dc/irq/dcn20/irq_service_dcn20.c |  2 +-
 .../drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c |  2 +-
 .../drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c |  2 +-
 .../amd/display/dc/irq/dcn302/irq_service_dcn302.c   |  4 ++--
 .../amd/display/dc/irq/dcn303/irq_service_dcn303.c   |  2 +-
 .../drm/amd/display/dc/irq/dcn31/irq_service_dcn31.c |  4 ++--
 .../amd/display/dc/irq/dcn314/irq_service_dcn314.c   |  4 ++--
 .../amd/display/dc/irq/dcn315/irq_service_dcn315.c   |  4 ++--
 .../drm/amd/display/dc/irq/dcn32/irq_service_dcn32.c |  4 ++--
 .../drm/amd/display/dc/irq/dcn35/irq_service_dcn35.c |  4 ++--
 .../amd/display/dc/irq/dcn351/irq_service_dcn351.c   |  4 ++--
 .../drm/amd/display/dc/irq/dcn36/irq_service_dcn36.c |  4 ++--
 .../amd/display/dc/irq/dcn401/irq_service_dcn401.c   |  4 ++--
 .../drm/amd/display/dc/irq/dcn42/irq_service_dcn42.c |  4 ++--
 drivers/gpu/drm/amd/display/dc/mpc/dcn30/dcn30_mpc.c |  2 +-
 .../amd/display/dc/resource/dce100/dce100_resource.c |  4 ++--
 .../amd/display/dc/resource/dce112/dce112_resource.c |  2 +-
 .../amd/display/dc/resource/dce120/dce120_resource.c |  2 +-
 .../amd/display/dc/resource/dce80/dce80_resource.c   |  6 +++---
 .../amd/display/dc/resource/dcn10/dcn10_resource.c   |  2 +-
 .../amd/display/dc/resource/dcn20/dcn20_resource.c   |  2 +-
 .../amd/display/dc/resource/dcn21/dcn21_resource.c   |  2 +-
 .../amd/display/dc/resource/dcn30/dcn30_resource.c   |  2 +-
 .../amd/display/dc/resource/dcn301/dcn301_resource.c |  2 +-
 .../amd/display/dc/resource/dcn302/dcn302_resource.c |  2 +-
 .../amd/display/dc/resource/dcn303/dcn303_resource.c |  2 +-
 .../amd/display/dc/resource/dcn31/dcn31_resource.c   |  2 +-
 .../amd/display/dc/resource/dcn314/dcn314_resource.c |  2 +-
 .../amd/display/dc/resource/dcn315/dcn315_resource.c |  2 +-
 .../amd/display/dc/resource/dcn316/dcn316_resource.c |  2 +-
 .../amd/display/dc/resource/dcn32/dcn32_resource.c   |  2 +-
 .../amd/display/dc/resource/dcn321/dcn321_resource.c |  2 +-
 .../amd/display/dc/resource/dcn35/dcn35_resource.c   |  2 +-
 .../amd/display/dc/resource/dcn351/dcn351_resource.c |  2 +-
 .../amd/display/dc/resource/dcn36/dcn36_resource.c   |  2 +-
 .../amd/display/dc/resource/dcn401/dcn401_resource.c |  2 +-
 .../amd/display/dc/resource/dcn42/dcn42_resource.c   |  2 +-
 50 files changed, 86 insertions(+), 86 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/basics/dce_calcs.c b/drivers/gpu/drm/amd/display/dc/basics/dce_calcs.c
index 4da5adab799c..070195c5393e 100644
--- a/drivers/gpu/drm/amd/display/dc/basics/dce_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/basics/dce_calcs.c
@@ -2010,10 +2010,10 @@ static void calculate_bandwidth(
 	}
 	/*output link bit per pixel supported*/
 	for (k = 0; k <= maximum_number_of_surfaces - 1; k++) {
-		data->output_bpphdmi[k] = bw_def_na;
-		data->output_bppdp4_lane_hbr[k] = bw_def_na;
-		data->output_bppdp4_lane_hbr2[k] = bw_def_na;
-		data->output_bppdp4_lane_hbr3[k] = bw_def_na;
+		data->output_bpphdmi[k] = (uint32_t)bw_def_na;
+		data->output_bppdp4_lane_hbr[k] = (uint32_t)bw_def_na;
+		data->output_bppdp4_lane_hbr2[k] = (uint32_t)bw_def_na;
+		data->output_bppdp4_lane_hbr3[k] = (uint32_t)bw_def_na;
 		if (data->enable[k]) {
 			data->output_bpphdmi[k] = bw_fixed_to_int(bw_mul(bw_div(bw_min2(bw_int_to_fixed(600), data->max_phyclk), data->pixel_rate[k]), bw_int_to_fixed(24)));
 			if (bw_meq(data->max_phyclk, bw_int_to_fixed(270))) {
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c
index d50b9440210e..cd4c45516616 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c
@@ -92,7 +92,7 @@ static int determine_sclk_from_bounding_box(
 uint32_t dce110_get_min_vblank_time_us(const struct dc_state *context)
 {
 	uint8_t j;
-	uint32_t min_vertical_blank_time = -1;
+	uint32_t min_vertical_blank_time = (uint32_t)-1;
 
 	for (j = 0; j < context->stream_count; j++) {
 		struct dc_stream_state *stream = context->streams[j];
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 727bcf08a84f..e95d5b269738 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -5240,7 +5240,7 @@ unsigned int resource_pixel_format_to_bpp(enum surface_pixel_format format)
 		return 64;
 	default:
 		ASSERT_CRITICAL(false);
-		return -1;
+		return UINT_MAX;
 	}
 }
 static unsigned int get_max_audio_sample_rate(struct audio_mode *modes)
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
index b4f5b4a6331a..993a25c39aa9 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
@@ -610,7 +610,7 @@ static uint32_t dce112_get_pix_clk_dividers(
 			|| pix_clk_params->requested_pix_clk_100hz == 0) {
 		DC_LOG_ERROR(
 			"%s: Invalid parameters!!\n", __func__);
-		return -1;
+		return (uint32_t)-1;
 	}
 
 	memset(pll_settings, 0, sizeof(*pll_settings));
@@ -621,7 +621,7 @@ static uint32_t dce112_get_pix_clk_dividers(
 		pll_settings->calculated_pix_clk_100hz = clk_src->ext_clk_khz * 10;
 		pll_settings->actual_pix_clk_100hz =
 					pix_clk_params->requested_pix_clk_100hz;
-		return -1;
+		return (uint32_t)-1;
 	}
 
 	dce112_get_pix_clk_dividers_helper(clk_src,
@@ -1376,7 +1376,7 @@ static uint32_t dcn3_get_pix_clk_dividers(
 			|| pix_clk_params->requested_pix_clk_100hz == 0) {
 		DC_LOG_ERROR(
 			"%s: Invalid parameters!!\n", __func__);
-		return -1;
+		return UINT_MAX;
 	}
 
 	memset(pll_settings, 0, sizeof(*pll_settings));
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c
index dcd2cdfe91eb..c702a30563f9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c
@@ -381,10 +381,10 @@ bool cm_helper_translate_curve_to_hw_format(struct dc_context *ctx,
 	}
 
 	for (i = region_end - region_start; i < MAX_REGIONS_NUMBER ; i++)
-		seg_distr[i] = -1;
+		seg_distr[i] = (uint32_t)-1;
 
 	for (k = 0; k < MAX_REGIONS_NUMBER; k++) {
-		if (seg_distr[k] != -1)
+		if (seg_distr[k] != (uint32_t)-1)
 			hw_points += (1 << seg_distr[k]);
 	}
 
@@ -565,7 +565,7 @@ bool cm_helper_translate_curve_to_degamma_hw_format(
 
 
 	for (i = region_end - region_start; i < MAX_REGIONS_NUMBER ; i++)
-		seg_distr[i] = -1;
+		seg_distr[i] = (uint32_t)-1;
 	/* 12 segments
 	 * segments are from 2^-12 to 0
 	 */
@@ -573,7 +573,7 @@ bool cm_helper_translate_curve_to_degamma_hw_format(
 		seg_distr[i] = 4;
 
 	for (k = 0; k < MAX_REGIONS_NUMBER; k++) {
-		if (seg_distr[k] != -1)
+		if (seg_distr[k] != (uint32_t)-1)
 			hw_points += (1 << seg_distr[k]);
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dwb_scl.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dwb_scl.c
index a0d437f0ce2b..f73c5f42ea68 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dwb_scl.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dwb_scl.c
@@ -746,7 +746,7 @@ bool dwb_program_horz_scalar(struct dcn20_dwbc *dwbc20,
 		src_width, dest_width);
 
 	if (dc_fixpt_floor(tmp_h_ratio_luma) == 8)
-		h_ratio_luma = -1;
+		h_ratio_luma = (uint32_t)-1;
 	else
 		h_ratio_luma = dc_fixpt_u3d19(tmp_h_ratio_luma) << 5;
 
@@ -824,7 +824,7 @@ bool dwb_program_vert_scalar(struct dcn20_dwbc *dwbc20,
 		src_height, dest_height);
 
 	if (dc_fixpt_floor(tmp_v_ratio_luma) == 8)
-		v_ratio_luma = -1;
+		v_ratio_luma = (uint32_t)-1;
 	else
 		v_ratio_luma = dc_fixpt_u3d19(tmp_v_ratio_luma) << 5;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c
index 227aa8672d17..9dbccf58dde5 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c
@@ -159,10 +159,10 @@ bool cm3_helper_translate_curve_to_hw_format(struct dc_context *ctx,
 	}
 
 	for (i = region_end - region_start; i < MAX_REGIONS_NUMBER ; i++)
-		seg_distr[i] = -1;
+		seg_distr[i] = (uint32_t)-1;
 
 	for (k = 0; k < MAX_REGIONS_NUMBER; k++) {
-		if (seg_distr[k] != -1)
+		if (seg_distr[k] != (uint32_t)-1)
 			hw_points += (1 << seg_distr[k]);
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn10/dcn10_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn10/dcn10_fpu.c
index c5e84190c17a..5679b79d6f53 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn10/dcn10_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn10/dcn10_fpu.c
@@ -76,7 +76,7 @@ struct _vcs_dpi_ip_params_st dcn1_0_ip = {
 	.line_buffer_size_bits = 589824,
 	.max_line_buffer_lines = 12,
 	.IsLineBufferBppFixed = 0,
-	.LineBufferFixedBpp = -1,
+	.LineBufferFixedBpp = (unsigned int)-1,
 	.writeback_luma_buffer_size_kbytes = 12,
 	.writeback_chroma_buffer_size_kbytes = 8,
 	.max_num_dpp = 4,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index d2025779d036..e4bd6089026b 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -488,15 +488,15 @@ dce110_translate_regamma_to_hw_format(const struct dc_transfer_func *output_tf,
 		seg_distr[8] = 4;
 		seg_distr[9] = 4;
 		seg_distr[10] = 0;
-		seg_distr[11] = -1;
-		seg_distr[12] = -1;
-		seg_distr[13] = -1;
-		seg_distr[14] = -1;
-		seg_distr[15] = -1;
+		seg_distr[11] = (uint32_t)-1;
+		seg_distr[12] = (uint32_t)-1;
+		seg_distr[13] = (uint32_t)-1;
+		seg_distr[14] = (uint32_t)-1;
+		seg_distr[15] = (uint32_t)-1;
 	}
 
 	for (k = 0; k < 16; k++) {
-		if (seg_distr[k] != -1)
+		if (seg_distr[k] != (uint32_t)-1)
 			hw_points += (1 << seg_distr[k]);
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dce110/irq_service_dce110.c b/drivers/gpu/drm/amd/display/dc/irq/dce110/irq_service_dce110.c
index bb576a9c5fdb..1994a5f40ee9 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dce110/irq_service_dce110.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dce110/irq_service_dce110.c
@@ -92,7 +92,7 @@ static struct irq_source_info_funcs vupdate_irq_info_funcs = {
 		.enable_mask = DC_HPD_INT_CONTROL__DC_HPD_INT_EN_MASK,\
 		.enable_value = {\
 			DC_HPD_INT_CONTROL__DC_HPD_INT_EN_MASK,\
-			~DC_HPD_INT_CONTROL__DC_HPD_INT_EN_MASK\
+			(uint32_t)~DC_HPD_INT_CONTROL__DC_HPD_INT_EN_MASK\
 		},\
 		.ack_reg = mmHPD ## reg_num ## _DC_HPD_INT_CONTROL,\
 		.ack_mask = DC_HPD_INT_CONTROL__DC_HPD_INT_ACK_MASK,\
@@ -107,7 +107,7 @@ static struct irq_source_info_funcs vupdate_irq_info_funcs = {
 		.enable_mask = DC_HPD_INT_CONTROL__DC_HPD_RX_INT_EN_MASK,\
 		.enable_value = {\
 			DC_HPD_INT_CONTROL__DC_HPD_RX_INT_EN_MASK,\
-			~DC_HPD_INT_CONTROL__DC_HPD_RX_INT_EN_MASK },\
+			(uint32_t)~DC_HPD_INT_CONTROL__DC_HPD_RX_INT_EN_MASK },\
 		.ack_reg = mmHPD ## reg_num ## _DC_HPD_INT_CONTROL,\
 		.ack_mask = DC_HPD_INT_CONTROL__DC_HPD_RX_INT_ACK_MASK,\
 		.ack_value = DC_HPD_INT_CONTROL__DC_HPD_RX_INT_ACK_MASK,\
@@ -121,7 +121,7 @@ static struct irq_source_info_funcs vupdate_irq_info_funcs = {
 		GRPH_INTERRUPT_CONTROL__GRPH_PFLIP_INT_MASK_MASK,\
 		.enable_value = {\
 			GRPH_INTERRUPT_CONTROL__GRPH_PFLIP_INT_MASK_MASK,\
-			~GRPH_INTERRUPT_CONTROL__GRPH_PFLIP_INT_MASK_MASK},\
+			(uint32_t)~GRPH_INTERRUPT_CONTROL__GRPH_PFLIP_INT_MASK_MASK},\
 		.ack_reg = mmDCP ## reg_num ## _GRPH_INTERRUPT_STATUS,\
 		.ack_mask = GRPH_INTERRUPT_STATUS__GRPH_PFLIP_INT_CLEAR_MASK,\
 		.ack_value = GRPH_INTERRUPT_STATUS__GRPH_PFLIP_INT_CLEAR_MASK,\
@@ -136,7 +136,7 @@ static struct irq_source_info_funcs vupdate_irq_info_funcs = {
 		CRTC_INTERRUPT_CONTROL__CRTC_V_UPDATE_INT_MSK_MASK,\
 		.enable_value = {\
 			CRTC_INTERRUPT_CONTROL__CRTC_V_UPDATE_INT_MSK_MASK,\
-			~CRTC_INTERRUPT_CONTROL__CRTC_V_UPDATE_INT_MSK_MASK},\
+			(uint32_t)~CRTC_INTERRUPT_CONTROL__CRTC_V_UPDATE_INT_MSK_MASK},\
 		.ack_reg = mmCRTC ## reg_num ## _CRTC_V_UPDATE_INT_STATUS,\
 		.ack_mask =\
 		CRTC_V_UPDATE_INT_STATUS__CRTC_V_UPDATE_INT_CLEAR_MASK,\
@@ -152,7 +152,7 @@ static struct irq_source_info_funcs vupdate_irq_info_funcs = {
 		CRTC_VERTICAL_INTERRUPT0_CONTROL__CRTC_VERTICAL_INTERRUPT0_INT_ENABLE_MASK,\
 		.enable_value = {\
 			CRTC_VERTICAL_INTERRUPT0_CONTROL__CRTC_VERTICAL_INTERRUPT0_INT_ENABLE_MASK,\
-			~CRTC_VERTICAL_INTERRUPT0_CONTROL__CRTC_VERTICAL_INTERRUPT0_INT_ENABLE_MASK},\
+			(uint32_t)~CRTC_VERTICAL_INTERRUPT0_CONTROL__CRTC_VERTICAL_INTERRUPT0_INT_ENABLE_MASK},\
 		.ack_reg = mmCRTC ## reg_num ## _CRTC_VERTICAL_INTERRUPT0_CONTROL,\
 		.ack_mask =\
 		CRTC_VERTICAL_INTERRUPT0_CONTROL__CRTC_VERTICAL_INTERRUPT0_CLEAR_MASK,\
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dce120/irq_service_dce120.c b/drivers/gpu/drm/amd/display/dc/irq/dce120/irq_service_dce120.c
index 33ce470e4c88..6e2554503e90 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dce120/irq_service_dce120.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dce120/irq_service_dce120.c
@@ -79,7 +79,7 @@ static struct irq_source_info_funcs vupdate_irq_info_funcs = {
 		block ## reg_num ## _ ## reg1 ## __ ## mask1 ## _MASK,\
 	.enable_value = {\
 		block ## reg_num ## _ ## reg1 ## __ ## mask1 ## _MASK,\
-		~block ## reg_num ## _ ## reg1 ## __ ## mask1 ## _MASK \
+		(uint32_t)~block ## reg_num ## _ ## reg1 ## __ ## mask1 ## _MASK \
 	},\
 	.ack_reg = SRI(reg2, block, reg_num),\
 	.ack_mask = \
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dce80/irq_service_dce80.c b/drivers/gpu/drm/amd/display/dc/irq/dce80/irq_service_dce80.c
index 3a9163acb49b..41e5b6fd176f 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dce80/irq_service_dce80.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dce80/irq_service_dce80.c
@@ -68,7 +68,7 @@ static struct irq_source_info_funcs vupdate_irq_info_funcs = {
 		.enable_mask = DC_HPD1_INT_CONTROL__DC_HPD1_INT_EN_MASK,\
 		.enable_value = {\
 			DC_HPD1_INT_CONTROL__DC_HPD1_INT_EN_MASK,\
-			~DC_HPD1_INT_CONTROL__DC_HPD1_INT_EN_MASK\
+			(uint32_t)~DC_HPD1_INT_CONTROL__DC_HPD1_INT_EN_MASK\
 		},\
 		.ack_reg = mmDC_HPD ## reg_num ## _INT_CONTROL,\
 		.ack_mask = DC_HPD1_INT_CONTROL__DC_HPD1_INT_ACK_MASK,\
@@ -83,7 +83,7 @@ static struct irq_source_info_funcs vupdate_irq_info_funcs = {
 		.enable_mask = DC_HPD1_INT_CONTROL__DC_HPD1_RX_INT_EN_MASK,\
 		.enable_value = {\
 				DC_HPD1_INT_CONTROL__DC_HPD1_RX_INT_EN_MASK,\
-			~DC_HPD1_INT_CONTROL__DC_HPD1_RX_INT_EN_MASK },\
+			(uint32_t)~DC_HPD1_INT_CONTROL__DC_HPD1_RX_INT_EN_MASK },\
 		.ack_reg = mmDC_HPD ## reg_num ## _INT_CONTROL,\
 		.ack_mask = DC_HPD1_INT_CONTROL__DC_HPD1_RX_INT_ACK_MASK,\
 		.ack_value = DC_HPD1_INT_CONTROL__DC_HPD1_RX_INT_ACK_MASK,\
@@ -98,7 +98,7 @@ static struct irq_source_info_funcs vupdate_irq_info_funcs = {
 		GRPH_INTERRUPT_CONTROL__GRPH_PFLIP_INT_MASK_MASK,\
 		.enable_value = {\
 			GRPH_INTERRUPT_CONTROL__GRPH_PFLIP_INT_MASK_MASK,\
-			~GRPH_INTERRUPT_CONTROL__GRPH_PFLIP_INT_MASK_MASK},\
+			(uint32_t)~GRPH_INTERRUPT_CONTROL__GRPH_PFLIP_INT_MASK_MASK},\
 		.ack_reg = mmDCP ## reg_num ## _GRPH_INTERRUPT_STATUS,\
 		.ack_mask = GRPH_INTERRUPT_STATUS__GRPH_PFLIP_INT_CLEAR_MASK,\
 		.ack_value = GRPH_INTERRUPT_STATUS__GRPH_PFLIP_INT_CLEAR_MASK,\
@@ -113,7 +113,7 @@ static struct irq_source_info_funcs vupdate_irq_info_funcs = {
 		CRTC_INTERRUPT_CONTROL__CRTC_V_UPDATE_INT_MSK_MASK,\
 		.enable_value = {\
 			CRTC_INTERRUPT_CONTROL__CRTC_V_UPDATE_INT_MSK_MASK,\
-			~CRTC_INTERRUPT_CONTROL__CRTC_V_UPDATE_INT_MSK_MASK},\
+			(uint32_t)~CRTC_INTERRUPT_CONTROL__CRTC_V_UPDATE_INT_MSK_MASK},\
 		.ack_reg = mmCRTC ## reg_num ## _CRTC_V_UPDATE_INT_STATUS,\
 		.ack_mask =\
 		CRTC_V_UPDATE_INT_STATUS__CRTC_V_UPDATE_INT_CLEAR_MASK,\
@@ -129,7 +129,7 @@ static struct irq_source_info_funcs vupdate_irq_info_funcs = {
 		CRTC_VERTICAL_INTERRUPT0_CONTROL__CRTC_VERTICAL_INTERRUPT0_INT_ENABLE_MASK,\
 		.enable_value = {\
 			CRTC_VERTICAL_INTERRUPT0_CONTROL__CRTC_VERTICAL_INTERRUPT0_INT_ENABLE_MASK,\
-			~CRTC_VERTICAL_INTERRUPT0_CONTROL__CRTC_VERTICAL_INTERRUPT0_INT_ENABLE_MASK},\
+			(uint32_t)~CRTC_VERTICAL_INTERRUPT0_CONTROL__CRTC_VERTICAL_INTERRUPT0_INT_ENABLE_MASK},\
 		.ack_reg = mmCRTC ## reg_num ## _CRTC_VERTICAL_INTERRUPT0_CONTROL,\
 		.ack_mask =\
 		CRTC_VERTICAL_INTERRUPT0_CONTROL__CRTC_VERTICAL_INTERRUPT0_CLEAR_MASK,\
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn10/irq_service_dcn10.c b/drivers/gpu/drm/amd/display/dc/irq/dcn10/irq_service_dcn10.c
index 4ce9edd16344..8c8fc1c6b4ec 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn10/irq_service_dcn10.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn10/irq_service_dcn10.c
@@ -176,7 +176,7 @@ static struct irq_source_info_funcs vupdate_no_lock_irq_info_funcs = {
 		block ## reg_num ## _ ## reg1 ## __ ## mask1 ## _MASK,\
 	.enable_value = {\
 		block ## reg_num ## _ ## reg1 ## __ ## mask1 ## _MASK,\
-		~block ## reg_num ## _ ## reg1 ## __ ## mask1 ## _MASK \
+		(uint32_t)~block ## reg_num ## _ ## reg1 ## __ ## mask1 ## _MASK \
 	},\
 	.ack_reg = SRI(reg2, block, reg_num),\
 	.ack_mask = \
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.c b/drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.c
index 5847af0e66cb..59516b6f84a3 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.c
@@ -179,7 +179,7 @@ static struct irq_source_info_funcs vline0_irq_info_funcs = {
 		block ## reg_num ## _ ## reg1 ## __ ## mask1 ## _MASK,\
 	.enable_value = {\
 		block ## reg_num ## _ ## reg1 ## __ ## mask1 ## _MASK,\
-		~block ## reg_num ## _ ## reg1 ## __ ## mask1 ## _MASK \
+		(uint32_t)~block ## reg_num ## _ ## reg1 ## __ ## mask1 ## _MASK \
 	},\
 	.ack_reg = SRI(reg2, block, reg_num),\
 	.ack_mask = \
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c b/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c
index 71d2f065140b..8253a5f7adcb 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c
@@ -189,7 +189,7 @@ static struct irq_source_info_funcs vline0_irq_info_funcs = {
 		block ## reg_num ## _ ## reg1 ## __ ## mask1 ## _MASK,\
 	.enable_value = {\
 		block ## reg_num ## _ ## reg1 ## __ ## mask1 ## _MASK,\
-		~block ## reg_num ## _ ## reg1 ## __ ## mask1 ## _MASK \
+		(uint32_t)~block ## reg_num ## _ ## reg1 ## __ ## mask1 ## _MASK \
 	},\
 	.ack_reg = SRI(reg2, block, reg_num),\
 	.ack_mask = \
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c b/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c
index 2a4080bdcf6b..cd128b6fab73 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c
@@ -196,7 +196,7 @@ static struct irq_source_info_funcs vline0_irq_info_funcs = {
 		block ## reg_num ## _ ## reg1 ## __ ## mask1 ## _MASK,\
 	.enable_value = {\
 		block ## reg_num ## _ ## reg1 ## __ ## mask1 ## _MASK,\
-		~block ## reg_num ## _ ## reg1 ## __ ## mask1 ## _MASK \
+		(uint32_t)~block ## reg_num ## _ ## reg1 ## __ ## mask1 ## _MASK \
 	},\
 	.ack_reg = SRI(reg2, block, reg_num),\
 	.ack_mask = \
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn302/irq_service_dcn302.c b/drivers/gpu/drm/amd/display/dc/irq/dcn302/irq_service_dcn302.c
index 624f1ac309f8..adef0e4ae2bb 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn302/irq_service_dcn302.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn302/irq_service_dcn302.c
@@ -180,7 +180,7 @@ static struct irq_source_info_funcs vline0_irq_info_funcs = {
 		.enable_mask = block ## reg_num ## _ ## reg1 ## __ ## mask1 ## _MASK,\
 		.enable_value = {\
 				block ## reg_num ## _ ## reg1 ## __ ## mask1 ## _MASK,\
-				~block ## reg_num ## _ ## reg1 ## __ ## mask1 ## _MASK \
+				(uint32_t)~block ## reg_num ## _ ## reg1 ## __ ## mask1 ## _MASK \
 		},\
 		.ack_reg = SRI(reg2, block, reg_num),\
 		.ack_mask = block ## reg_num ## _ ## reg2 ## __ ## mask2 ## _MASK,\
@@ -199,7 +199,7 @@ static struct irq_source_info_funcs vline0_irq_info_funcs = {
 		reg1 ## __ ## mask1 ## _MASK,\
 	.enable_value = {\
 		reg1 ## __ ## mask1 ## _MASK,\
-		~reg1 ## __ ## mask1 ## _MASK \
+		(uint32_t)~reg1 ## __ ## mask1 ## _MASK \
 	},\
 	.ack_reg = SRI_DMUB(reg2),\
 	.ack_mask = \
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn303/irq_service_dcn303.c b/drivers/gpu/drm/amd/display/dc/irq/dcn303/irq_service_dcn303.c
index 137caffae916..639d649915e5 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn303/irq_service_dcn303.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn303/irq_service_dcn303.c
@@ -123,7 +123,7 @@ static struct irq_source_info_funcs vline0_irq_info_funcs = {
 		.enable_mask = block ## reg_num ## _ ## reg1 ## __ ## mask1 ## _MASK,\
 		.enable_value = {\
 				block ## reg_num ## _ ## reg1 ## __ ## mask1 ## _MASK,\
-				~block ## reg_num ## _ ## reg1 ## __ ## mask1 ## _MASK \
+				(uint32_t)~block ## reg_num ## _ ## reg1 ## __ ## mask1 ## _MASK \
 		},\
 		.ack_reg = SRI(reg2, block, reg_num),\
 		.ack_mask = block ## reg_num ## _ ## reg2 ## __ ## mask2 ## _MASK,\
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn31/irq_service_dcn31.c b/drivers/gpu/drm/amd/display/dc/irq/dcn31/irq_service_dcn31.c
index 921cb167d920..18049aa0dbd2 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn31/irq_service_dcn31.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn31/irq_service_dcn31.c
@@ -184,7 +184,7 @@ static struct irq_source_info_funcs vline0_irq_info_funcs = {
 		block ## reg_num ## _ ## reg1 ## __ ## mask1 ## _MASK,\
 	.enable_value = {\
 		block ## reg_num ## _ ## reg1 ## __ ## mask1 ## _MASK,\
-		~block ## reg_num ## _ ## reg1 ## __ ## mask1 ## _MASK \
+		(uint32_t)~block ## reg_num ## _ ## reg1 ## __ ## mask1 ## _MASK \
 	},\
 	.ack_reg = SRI(reg2, block, reg_num),\
 	.ack_mask = \
@@ -198,7 +198,7 @@ static struct irq_source_info_funcs vline0_irq_info_funcs = {
 		reg1 ## __ ## mask1 ## _MASK,\
 	.enable_value = {\
 		reg1 ## __ ## mask1 ## _MASK,\
-		~reg1 ## __ ## mask1 ## _MASK \
+		(uint32_t)~reg1 ## __ ## mask1 ## _MASK \
 	},\
 	.ack_reg = SRI_DMUB(reg2),\
 	.ack_mask = \
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn314/irq_service_dcn314.c b/drivers/gpu/drm/amd/display/dc/irq/dcn314/irq_service_dcn314.c
index 0118fd6e5db0..e86f3c03d4d4 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn314/irq_service_dcn314.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn314/irq_service_dcn314.c
@@ -186,7 +186,7 @@ static struct irq_source_info_funcs vline0_irq_info_funcs = {
 		block ## reg_num ## _ ## reg1 ## __ ## mask1 ## _MASK,\
 	.enable_value = {\
 		block ## reg_num ## _ ## reg1 ## __ ## mask1 ## _MASK,\
-		~block ## reg_num ## _ ## reg1 ## __ ## mask1 ## _MASK \
+		(uint32_t)~block ## reg_num ## _ ## reg1 ## __ ## mask1 ## _MASK \
 	},\
 	.ack_reg = SRI(reg2, block, reg_num),\
 	.ack_mask = \
@@ -200,7 +200,7 @@ static struct irq_source_info_funcs vline0_irq_info_funcs = {
 		reg1 ## __ ## mask1 ## _MASK,\
 	.enable_value = {\
 		reg1 ## __ ## mask1 ## _MASK,\
-		~reg1 ## __ ## mask1 ## _MASK \
+		(uint32_t)~reg1 ## __ ## mask1 ## _MASK \
 	},\
 	.ack_reg = SRI_DMUB(reg2),\
 	.ack_mask = \
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn315/irq_service_dcn315.c b/drivers/gpu/drm/amd/display/dc/irq/dcn315/irq_service_dcn315.c
index adebfc888618..5f9d90f37ffe 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn315/irq_service_dcn315.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn315/irq_service_dcn315.c
@@ -191,7 +191,7 @@ static struct irq_source_info_funcs vline0_irq_info_funcs = {
 		block ## reg_num ## _ ## reg1 ## __ ## mask1 ## _MASK,\
 	.enable_value = {\
 		block ## reg_num ## _ ## reg1 ## __ ## mask1 ## _MASK,\
-		~block ## reg_num ## _ ## reg1 ## __ ## mask1 ## _MASK \
+		(uint32_t)~block ## reg_num ## _ ## reg1 ## __ ## mask1 ## _MASK \
 	},\
 	.ack_reg = SRI(reg2, block, reg_num),\
 	.ack_mask = \
@@ -205,7 +205,7 @@ static struct irq_source_info_funcs vline0_irq_info_funcs = {
 		reg1 ## __ ## mask1 ## _MASK,\
 	.enable_value = {\
 		reg1 ## __ ## mask1 ## _MASK,\
-		~reg1 ## __ ## mask1 ## _MASK \
+		(uint32_t)~reg1 ## __ ## mask1 ## _MASK \
 	},\
 	.ack_reg = SRI_DMUB(reg2),\
 	.ack_mask = \
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn32/irq_service_dcn32.c b/drivers/gpu/drm/amd/display/dc/irq/dcn32/irq_service_dcn32.c
index e9e315c75d76..436461730db3 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn32/irq_service_dcn32.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn32/irq_service_dcn32.c
@@ -195,7 +195,7 @@ static struct irq_source_info_funcs vline2_irq_info_funcs = {
 		block ## reg_num ## _ ## reg1 ## __ ## mask1 ## _MASK,\
 	.enable_value = {\
 		block ## reg_num ## _ ## reg1 ## __ ## mask1 ## _MASK,\
-		~block ## reg_num ## _ ## reg1 ## __ ## mask1 ## _MASK \
+		(uint32_t)~block ## reg_num ## _ ## reg1 ## __ ## mask1 ## _MASK \
 	},\
 	.ack_reg = SRI(reg2, block, reg_num),\
 	.ack_mask = \
@@ -209,7 +209,7 @@ static struct irq_source_info_funcs vline2_irq_info_funcs = {
 		reg1 ## __ ## mask1 ## _MASK,\
 	.enable_value = {\
 		reg1 ## __ ## mask1 ## _MASK,\
-		~reg1 ## __ ## mask1 ## _MASK \
+		(uint32_t)~reg1 ## __ ## mask1 ## _MASK \
 	},\
 	.ack_reg = SRI_DMUB(reg2),\
 	.ack_mask = \
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn35/irq_service_dcn35.c b/drivers/gpu/drm/amd/display/dc/irq/dcn35/irq_service_dcn35.c
index 79e5e8c137ca..8d252ccbb297 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn35/irq_service_dcn35.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn35/irq_service_dcn35.c
@@ -184,7 +184,7 @@ static struct irq_source_info_funcs vline0_irq_info_funcs = {
 	REG_STRUCT[base + reg_num].enable_value[0] = \
 		block ## reg_num ## _ ## reg1 ## __ ## mask1 ## _MASK,\
 	REG_STRUCT[base + reg_num].enable_value[1] = \
-		~block ## reg_num ## _ ## reg1 ## __ ## mask1 ## _MASK, \
+		(uint32_t)~block ## reg_num ## _ ## reg1 ## __ ## mask1 ## _MASK, \
 	REG_STRUCT[base + reg_num].ack_reg = SRI(reg2, block, reg_num),\
 	REG_STRUCT[base + reg_num].ack_mask = \
 		block ## reg_num ## _ ## reg2 ## __ ## mask2 ## _MASK,\
@@ -198,7 +198,7 @@ static struct irq_source_info_funcs vline0_irq_info_funcs = {
 	REG_STRUCT[base].enable_value[0] = \
 		reg1 ## __ ## mask1 ## _MASK,\
 	REG_STRUCT[base].enable_value[1] = \
-		~reg1 ## __ ## mask1 ## _MASK, \
+		(uint32_t)~reg1 ## __ ## mask1 ## _MASK, \
 	REG_STRUCT[base].ack_reg = SRI_DMUB(reg2),\
 	REG_STRUCT[base].ack_mask = \
 		reg2 ## __ ## mask2 ## _MASK,\
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn351/irq_service_dcn351.c b/drivers/gpu/drm/amd/display/dc/irq/dcn351/irq_service_dcn351.c
index 163b8ee9ebf7..3e2f53308cde 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn351/irq_service_dcn351.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn351/irq_service_dcn351.c
@@ -163,7 +163,7 @@ static struct irq_source_info_funcs vline0_irq_info_funcs = {
 	REG_STRUCT[base + reg_num].enable_value[0] = \
 		block ## reg_num ## _ ## reg1 ## __ ## mask1 ## _MASK,\
 	REG_STRUCT[base + reg_num].enable_value[1] = \
-		~block ## reg_num ## _ ## reg1 ## __ ## mask1 ## _MASK, \
+		(uint32_t)~block ## reg_num ## _ ## reg1 ## __ ## mask1 ## _MASK, \
 	REG_STRUCT[base + reg_num].ack_reg = SRI(reg2, block, reg_num),\
 	REG_STRUCT[base + reg_num].ack_mask = \
 		block ## reg_num ## _ ## reg2 ## __ ## mask2 ## _MASK,\
@@ -177,7 +177,7 @@ static struct irq_source_info_funcs vline0_irq_info_funcs = {
 	REG_STRUCT[base].enable_value[0] = \
 		reg1 ## __ ## mask1 ## _MASK,\
 	REG_STRUCT[base].enable_value[1] = \
-		~reg1 ## __ ## mask1 ## _MASK, \
+		(uint32_t)~reg1 ## __ ## mask1 ## _MASK, \
 	REG_STRUCT[base].ack_reg = SRI_DMUB(reg2),\
 	REG_STRUCT[base].ack_mask = \
 		reg2 ## __ ## mask2 ## _MASK,\
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn36/irq_service_dcn36.c b/drivers/gpu/drm/amd/display/dc/irq/dcn36/irq_service_dcn36.c
index f716ab0fd30e..2540e8dc93a0 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn36/irq_service_dcn36.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn36/irq_service_dcn36.c
@@ -162,7 +162,7 @@ static struct irq_source_info_funcs vline0_irq_info_funcs = {
 	REG_STRUCT[base + reg_num].enable_value[0] = \
 		block ## reg_num ## _ ## reg1 ## __ ## mask1 ## _MASK,\
 	REG_STRUCT[base + reg_num].enable_value[1] = \
-		~block ## reg_num ## _ ## reg1 ## __ ## mask1 ## _MASK, \
+		(uint32_t)~block ## reg_num ## _ ## reg1 ## __ ## mask1 ## _MASK, \
 	REG_STRUCT[base + reg_num].ack_reg = SRI(reg2, block, reg_num),\
 	REG_STRUCT[base + reg_num].ack_mask = \
 		block ## reg_num ## _ ## reg2 ## __ ## mask2 ## _MASK,\
@@ -176,7 +176,7 @@ static struct irq_source_info_funcs vline0_irq_info_funcs = {
 	REG_STRUCT[base].enable_value[0] = \
 		reg1 ## __ ## mask1 ## _MASK,\
 	REG_STRUCT[base].enable_value[1] = \
-		~reg1 ## __ ## mask1 ## _MASK, \
+		(uint32_t)~reg1 ## __ ## mask1 ## _MASK, \
 	REG_STRUCT[base].ack_reg = SRI_DMUB(reg2),\
 	REG_STRUCT[base].ack_mask = \
 		reg2 ## __ ## mask2 ## _MASK,\
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn401/irq_service_dcn401.c b/drivers/gpu/drm/amd/display/dc/irq/dcn401/irq_service_dcn401.c
index fd9bb1950c20..dcfafcee0587 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn401/irq_service_dcn401.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn401/irq_service_dcn401.c
@@ -175,7 +175,7 @@ static struct irq_source_info_funcs vline2_irq_info_funcs = {
 		block ## reg_num ## _ ## reg1 ## __ ## mask1 ## _MASK,\
 	.enable_value = {\
 		block ## reg_num ## _ ## reg1 ## __ ## mask1 ## _MASK,\
-		~block ## reg_num ## _ ## reg1 ## __ ## mask1 ## _MASK \
+		(uint32_t)~block ## reg_num ## _ ## reg1 ## __ ## mask1 ## _MASK \
 	},\
 	.ack_reg = SRI(reg2, block, reg_num),\
 	.ack_mask = \
@@ -189,7 +189,7 @@ static struct irq_source_info_funcs vline2_irq_info_funcs = {
 		reg1 ## __ ## mask1 ## _MASK,\
 	.enable_value = {\
 		reg1 ## __ ## mask1 ## _MASK,\
-		~reg1 ## __ ## mask1 ## _MASK \
+		(uint32_t)~reg1 ## __ ## mask1 ## _MASK \
 	},\
 	.ack_reg = SRI_DMUB(reg2),\
 	.ack_mask = \
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn42/irq_service_dcn42.c b/drivers/gpu/drm/amd/display/dc/irq/dcn42/irq_service_dcn42.c
index 19e0741c62cd..bdf733d37a76 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn42/irq_service_dcn42.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn42/irq_service_dcn42.c
@@ -173,7 +173,7 @@ static struct irq_source_info_funcs vline2_irq_info_funcs = {
 		block ## reg_num ## _ ## reg1 ## __ ## mask1 ## _MASK,\
 	.enable_value = {\
 		block ## reg_num ## _ ## reg1 ## __ ## mask1 ## _MASK,\
-		~block ## reg_num ## _ ## reg1 ## __ ## mask1 ## _MASK \
+		(uint32_t)~block ## reg_num ## _ ## reg1 ## __ ## mask1 ## _MASK \
 	},\
 	.ack_reg = SRI(reg2, block, reg_num),\
 	.ack_mask = \
@@ -187,7 +187,7 @@ static struct irq_source_info_funcs vline2_irq_info_funcs = {
 		reg1 ## __ ## mask1 ## _MASK,\
 	.enable_value = {\
 		reg1 ## __ ## mask1 ## _MASK,\
-		~reg1 ## __ ## mask1 ## _MASK \
+		(uint32_t)~reg1 ## __ ## mask1 ## _MASK \
 	},\
 	.ack_reg = SRI_DMUB(reg2),\
 	.ack_mask = \
diff --git a/drivers/gpu/drm/amd/display/dc/mpc/dcn30/dcn30_mpc.c b/drivers/gpu/drm/amd/display/dc/mpc/dcn30/dcn30_mpc.c
index 6bfd2c1294e5..8b398b9a2b6b 100644
--- a/drivers/gpu/drm/amd/display/dc/mpc/dcn30/dcn30_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/mpc/dcn30/dcn30_mpc.c
@@ -1428,7 +1428,7 @@ uint32_t mpcc3_acquire_rmu(struct mpc *mpc, int mpcc_id, int rmu_idx)
 	}
 
 	//no vacant RMU units or invalid parameters acquire_post_bldn_3dlut
-	return -1;
+	return (uint32_t)-1;
 }
 
 static int mpcc3_release_rmu(struct mpc *mpc, int mpcc_id)
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
index 05f7ff60f8f5..82d76e7276a3 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
@@ -1042,7 +1042,7 @@ static bool dce100_resource_construct(
 
 	pool->base.res_cap = &res_cap;
 	pool->base.funcs = &dce100_res_pool_funcs;
-	pool->base.underlay_pipe_index = NO_UNDERLAY_PIPE;
+	pool->base.underlay_pipe_index = (unsigned int)NO_UNDERLAY_PIPE;
 
 	bp = ctx->dc_bios;
 
@@ -1114,7 +1114,7 @@ static bool dce100_resource_construct(
 	/*************************************************
 	*  Resource + asic cap harcoding                *
 	*************************************************/
-	pool->base.underlay_pipe_index = NO_UNDERLAY_PIPE;
+	pool->base.underlay_pipe_index = (unsigned int)NO_UNDERLAY_PIPE;
 	pool->base.pipe_count = res_cap.num_timing_generator;
 	pool->base.timing_generator_count = pool->base.res_cap->num_timing_generator;
 	dc->caps.max_downscale_ratio = 200;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.c
index 3f0a6bc4dcc2..294f3f5016b8 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.c
@@ -1240,7 +1240,7 @@ static bool dce112_resource_construct(
 	/*************************************************
 	 *  Resource + asic cap harcoding                *
 	 *************************************************/
-	pool->base.underlay_pipe_index = NO_UNDERLAY_PIPE;
+	pool->base.underlay_pipe_index = (unsigned int)NO_UNDERLAY_PIPE;
 	pool->base.pipe_count = pool->base.res_cap->num_timing_generator;
 	pool->base.timing_generator_count = pool->base.res_cap->num_timing_generator;
 	dc->caps.max_downscale_ratio = 200;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce120/dce120_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce120/dce120_resource.c
index 92890784caa6..5dd80d2279d2 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce120/dce120_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce120/dce120_resource.c
@@ -1082,7 +1082,7 @@ static bool dce120_resource_construct(
 	/* TODO: Fill more data from GreenlandAsicCapability.cpp */
 	pool->base.pipe_count = res_cap.num_timing_generator;
 	pool->base.timing_generator_count = pool->base.res_cap->num_timing_generator;
-	pool->base.underlay_pipe_index = NO_UNDERLAY_PIPE;
+	pool->base.underlay_pipe_index = (unsigned int)NO_UNDERLAY_PIPE;
 
 	dc->caps.max_downscale_ratio = 200;
 	dc->caps.i2c_speed_in_khz = 100;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
index a68e799d5885..bf889f40d9ff 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
@@ -937,7 +937,7 @@ static bool dce80_construct(
 	/*************************************************
 	 *  Resource + asic cap harcoding                *
 	 *************************************************/
-	pool->base.underlay_pipe_index = NO_UNDERLAY_PIPE;
+	pool->base.underlay_pipe_index = (unsigned int)NO_UNDERLAY_PIPE;
 	pool->base.pipe_count = res_cap.num_timing_generator;
 	pool->base.timing_generator_count = res_cap.num_timing_generator;
 	dc->caps.max_downscale_ratio = 200;
@@ -1140,7 +1140,7 @@ static bool dce81_construct(
 	/*************************************************
 	 *  Resource + asic cap harcoding                *
 	 *************************************************/
-	pool->base.underlay_pipe_index = NO_UNDERLAY_PIPE;
+	pool->base.underlay_pipe_index = (unsigned int)NO_UNDERLAY_PIPE;
 	pool->base.pipe_count = res_cap_81.num_timing_generator;
 	pool->base.timing_generator_count = res_cap_81.num_timing_generator;
 	dc->caps.max_downscale_ratio = 200;
@@ -1340,7 +1340,7 @@ static bool dce83_construct(
 	/*************************************************
 	 *  Resource + asic cap harcoding                *
 	 *************************************************/
-	pool->base.underlay_pipe_index = NO_UNDERLAY_PIPE;
+	pool->base.underlay_pipe_index = (unsigned int)NO_UNDERLAY_PIPE;
 	pool->base.pipe_count = res_cap_83.num_timing_generator;
 	pool->base.timing_generator_count = res_cap_83.num_timing_generator;
 	dc->caps.max_downscale_ratio = 200;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c
index 9c1a57a1f989..70d7ca0b0f86 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c
@@ -1348,7 +1348,7 @@ static bool dcn10_resource_construct(
 	/*************************************************
 	 *  Resource + asic cap harcoding                *
 	 *************************************************/
-	pool->base.underlay_pipe_index = NO_UNDERLAY_PIPE;
+	pool->base.underlay_pipe_index = (unsigned int)NO_UNDERLAY_PIPE;
 
 	/* max pipe num for ASIC before check pipe fuses */
 	pool->base.pipe_count = pool->base.res_cap->num_timing_generator;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
index 7d49a6003f03..e8d232006dbf 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
@@ -2430,7 +2430,7 @@ static bool dcn20_resource_construct(
 	/*************************************************
 	 *  Resource + asic cap harcoding                *
 	 *************************************************/
-	pool->base.underlay_pipe_index = NO_UNDERLAY_PIPE;
+	pool->base.underlay_pipe_index = (unsigned int)NO_UNDERLAY_PIPE;
 
 	dc->caps.max_downscale_ratio = 200;
 	dc->caps.i2c_speed_in_khz = 100;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
index a612c8932da9..959001d0a578 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
@@ -1409,7 +1409,7 @@ static bool dcn21_resource_construct(
 	/*************************************************
 	 *  Resource + asic cap harcoding                *
 	 *************************************************/
-	pool->base.underlay_pipe_index = NO_UNDERLAY_PIPE;
+	pool->base.underlay_pipe_index = (unsigned int)NO_UNDERLAY_PIPE;
 
 	/* max pipe num for ASIC before check pipe fuses */
 	pool->base.pipe_count = pool->base.res_cap->num_timing_generator;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
index 2c606d9042a2..0c70677b4544 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
@@ -2301,7 +2301,7 @@ static bool dcn30_resource_construct(
 	/*************************************************
 	 *  Resource + asic cap harcoding                *
 	 *************************************************/
-	pool->base.underlay_pipe_index = NO_UNDERLAY_PIPE;
+	pool->base.underlay_pipe_index = (unsigned int)NO_UNDERLAY_PIPE;
 	pool->base.pipe_count = pool->base.res_cap->num_timing_generator;
 	pool->base.mpcc_count = pool->base.res_cap->num_timing_generator;
 	dc->caps.max_downscale_ratio = 600;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c
index 65781c10e83c..97b6c4ee8532 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c
@@ -1432,7 +1432,7 @@ static bool dcn301_resource_construct(
 	/*************************************************
 	 *  Resource + asic cap harcoding                *
 	 *************************************************/
-	pool->base.underlay_pipe_index = NO_UNDERLAY_PIPE;
+	pool->base.underlay_pipe_index = (unsigned int)NO_UNDERLAY_PIPE;
 	pool->base.pipe_count = pool->base.res_cap->num_timing_generator;
 	pool->base.mpcc_count = pool->base.res_cap->num_timing_generator;
 	dc->caps.max_downscale_ratio = 600;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c
index 7c4c5c8aa4b6..bb3edfe86a1f 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c
@@ -1218,7 +1218,7 @@ static bool dcn302_resource_construct(
 	/*************************************************
 	 *  Resource + asic cap harcoding                *
 	 *************************************************/
-	pool->underlay_pipe_index = NO_UNDERLAY_PIPE;
+	pool->underlay_pipe_index = (unsigned int)NO_UNDERLAY_PIPE;
 	pool->pipe_count = pool->res_cap->num_timing_generator;
 	pool->mpcc_count = pool->res_cap->num_timing_generator;
 	dc->caps.max_downscale_ratio = 600;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c
index 360934bc5481..db627b4aa76a 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c
@@ -1159,7 +1159,7 @@ static bool dcn303_resource_construct(
 	/*************************************************
 	 *  Resource + asic cap harcoding                *
 	 *************************************************/
-	pool->underlay_pipe_index = NO_UNDERLAY_PIPE;
+	pool->underlay_pipe_index = (unsigned int)NO_UNDERLAY_PIPE;
 	pool->pipe_count = pool->res_cap->num_timing_generator;
 	pool->mpcc_count = pool->res_cap->num_timing_generator;
 	dc->caps.max_downscale_ratio = 600;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
index 6d23d88e400c..9d7520a384ae 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
@@ -1898,7 +1898,7 @@ static bool dcn31_resource_construct(
 	/*************************************************
 	 *  Resource + asic cap harcoding                *
 	 *************************************************/
-	pool->base.underlay_pipe_index = NO_UNDERLAY_PIPE;
+	pool->base.underlay_pipe_index = (unsigned int)NO_UNDERLAY_PIPE;
 	pool->base.pipe_count = pool->base.res_cap->num_timing_generator;
 	pool->base.mpcc_count = pool->base.res_cap->num_timing_generator;
 	dc->caps.max_downscale_ratio = 600;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
index 7b1f426652be..ee1d48158d3c 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
@@ -1831,7 +1831,7 @@ static bool dcn314_resource_construct(
 	/*************************************************
 	 *  Resource + asic cap harcoding                *
 	 *************************************************/
-	pool->base.underlay_pipe_index = NO_UNDERLAY_PIPE;
+	pool->base.underlay_pipe_index = (unsigned int)NO_UNDERLAY_PIPE;
 	pool->base.pipe_count = pool->base.res_cap->num_timing_generator;
 	pool->base.mpcc_count = pool->base.res_cap->num_timing_generator;
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
index 10feb64c0010..9ded310c74b6 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
@@ -1870,7 +1870,7 @@ static bool dcn315_resource_construct(
 	/*************************************************
 	 *  Resource + asic cap harcoding                *
 	 *************************************************/
-	pool->base.underlay_pipe_index = NO_UNDERLAY_PIPE;
+	pool->base.underlay_pipe_index = (unsigned int)NO_UNDERLAY_PIPE;
 	pool->base.pipe_count = pool->base.res_cap->num_timing_generator;
 
 	/* Enable 4to1MPC by default */
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
index 835bedfd6074..cab523733ce4 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
@@ -1745,7 +1745,7 @@ static bool dcn316_resource_construct(
 	/*************************************************
 	 *  Resource + asic cap harcoding                *
 	 *************************************************/
-	pool->base.underlay_pipe_index = NO_UNDERLAY_PIPE;
+	pool->base.underlay_pipe_index = (unsigned int)NO_UNDERLAY_PIPE;
 	pool->base.pipe_count = pool->base.res_cap->num_timing_generator;
 	pool->base.mpcc_count = pool->base.res_cap->num_timing_generator;
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index 5c0658a609a8..0b419877c8bc 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -2195,7 +2195,7 @@ static bool dcn32_resource_construct(
 	/*************************************************
 	 *  Resource + asic cap harcoding                *
 	 *************************************************/
-	pool->base.underlay_pipe_index = NO_UNDERLAY_PIPE;
+	pool->base.underlay_pipe_index = (unsigned int)NO_UNDERLAY_PIPE;
 	pool->base.timing_generator_count = num_pipes;
 	pool->base.pipe_count = num_pipes;
 	pool->base.mpcc_count = num_pipes;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
index b254e22a7628..38c9e79e891a 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
@@ -1699,7 +1699,7 @@ static bool dcn321_resource_construct(
 	/*************************************************
 	 *  Resource + asic cap harcoding                *
 	 *************************************************/
-	pool->base.underlay_pipe_index = NO_UNDERLAY_PIPE;
+	pool->base.underlay_pipe_index = (unsigned int)NO_UNDERLAY_PIPE;
 	pool->base.timing_generator_count = num_pipes;
 	pool->base.pipe_count = num_pipes;
 	pool->base.mpcc_count = num_pipes;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
index 154e00c32511..2d8a5f157988 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
@@ -1853,7 +1853,7 @@ static bool dcn35_resource_construct(
 	/*************************************************
 	 *  Resource + asic cap harcoding                *
 	 *************************************************/
-	pool->base.underlay_pipe_index = NO_UNDERLAY_PIPE;
+	pool->base.underlay_pipe_index = (unsigned int)NO_UNDERLAY_PIPE;
 	pool->base.pipe_count = pool->base.res_cap->num_timing_generator;
 	pool->base.mpcc_count = pool->base.res_cap->num_timing_generator;
 	dc->caps.max_downscale_ratio = 600;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
index 640650ed2184..9ed3d4879f76 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
@@ -1826,7 +1826,7 @@ static bool dcn351_resource_construct(
 	/*************************************************
 	 *  Resource + asic cap harcoding                *
 	 *************************************************/
-	pool->base.underlay_pipe_index = NO_UNDERLAY_PIPE;
+	pool->base.underlay_pipe_index = (unsigned int)NO_UNDERLAY_PIPE;
 	pool->base.pipe_count = pool->base.res_cap->num_timing_generator;
 	pool->base.mpcc_count = pool->base.res_cap->num_timing_generator;
 	dc->caps.max_downscale_ratio = 600;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
index 40894afd990e..d849d9eeb121 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
@@ -1829,7 +1829,7 @@ static bool dcn36_resource_construct(
 	/*************************************************
 	 *  Resource + asic cap harcoding                *
 	 *************************************************/
-	pool->base.underlay_pipe_index = NO_UNDERLAY_PIPE;
+	pool->base.underlay_pipe_index = (unsigned int)NO_UNDERLAY_PIPE;
 	pool->base.pipe_count = pool->base.res_cap->num_timing_generator;
 	pool->base.mpcc_count = pool->base.res_cap->num_timing_generator;
 	dc->caps.max_downscale_ratio = 600;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
index 7ac2f38bfde8..78bb1def9a0c 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
@@ -1919,7 +1919,7 @@ static bool dcn401_resource_construct(
 	/*************************************************
 	 *  Resource + asic cap harcoding                *
 	 *************************************************/
-	pool->base.underlay_pipe_index = NO_UNDERLAY_PIPE;
+	pool->base.underlay_pipe_index = (unsigned int)NO_UNDERLAY_PIPE;
 	pool->base.timing_generator_count = num_pipes;
 	pool->base.pipe_count = num_pipes;
 	pool->base.mpcc_count = num_pipes;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
index 6328b3dc35f9..11b302c4d06f 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
@@ -1864,7 +1864,7 @@ static bool dcn42_resource_construct(
 	/*************************************************
 	 *  Resource + asic cap harcoding                *
 	 *************************************************/
-	pool->base.underlay_pipe_index = NO_UNDERLAY_PIPE;
+	pool->base.underlay_pipe_index = (unsigned int)NO_UNDERLAY_PIPE;
 	pool->base.timing_generator_count = pool->base.res_cap->num_timing_generator;
 	pool->base.pipe_count = num_pipes;
 	pool->base.mpcc_count = num_pipes;
-- 
2.43.0

