Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A9AEE936EB
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Oct 2023 21:21:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 307C910E3BE;
	Wed,  4 Oct 2023 21:21:56 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C3EC10E3BE
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Oct 2023 21:21:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fbkWhMBVcb+wv/CbVz6VqFj+5iGtaAALibiaoZYKjxHJm0aUvau4cJfG0Xa1NY1RjoGqGa7ElS+OJ2IccxzqDnTNOe1YcacD2ZQf6OBz8Nee/aYnRmN+a5h+Bt99MBVkwbtEXGIICERN0g6HmbcWuT5amQcjyrGzWU4HViEAqDjoAjmU7qWHzChbAOs1tPUGdv279vU9dxbA1tAK6fWBMEmaDlE/1QF+ZOFn2po7rBGZWc4+QO3bsCvHGJc4u/TppnqfkqMEr9IiK/h58fBLtR1Pf54wBr9svChuuG/urs4LmcYh2Q6ff16XlByuFLNcsrP2pWdXzdIcZ3t4iY8emQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QwbUw9NdY2z4RbrT7FQboK1FwoxSj3x3g1BfwQsC3i0=;
 b=MvVRKZsGcvy9xaC5VL2/ArYUVaFUBF3iI6uG2D6PsNk0XYStrcEWbqcjQW1c5P+sHAZ0RPkkga4OZzIBfLoPtj/lX1ScTtqntdsuI212O6swnPj5DVn5JNlCVzUlpg8sN7aenQnuHMY+4/zXYwjz69/YbcJ7fKFdpy0HNTuAbCln8bkWhj7erQcSk1c9ZUAIUbIcCnc3JrOInpmOkzOjAA9k5cew1UABwhmrQpC+FYKqzxAcU0iiHjj+GsQ+AEkWUdIlZqNAfRsu1Py0PQQW6q3dGYij6w66fvePpS4iqKc5mww1Y0uH/t4/Wlmxjk6QrmCt/kRUrAPEzaQEwMtLRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QwbUw9NdY2z4RbrT7FQboK1FwoxSj3x3g1BfwQsC3i0=;
 b=ooUIjuQwyOWsXRSN/XpQsIZC1PBRTVzCHf3dauKJIr3s0h62tf08FxhK6ReJuELQ+80eUV4cPml/Iyqarq6fF16im1PX/0IeKZs5AEhWgTPju87GOU2n59pfZJXCSvWsY8Hl7MNRrdPJUxF9gUhAV8FbgSxhxijajH1JhY7XODA=
Received: from BLAPR03CA0016.namprd03.prod.outlook.com (2603:10b6:208:32b::21)
 by LV8PR12MB9261.namprd12.prod.outlook.com (2603:10b6:408:1ed::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Wed, 4 Oct
 2023 21:21:50 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:208:32b:cafe::6b) by BLAPR03CA0016.outlook.office365.com
 (2603:10b6:208:32b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.26 via Frontend
 Transport; Wed, 4 Oct 2023 21:21:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 4 Oct 2023 21:21:50 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 16:21:48 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 07/16] drm/amd/display: Add z8_marks in dml
Date: Wed, 4 Oct 2023 15:21:01 -0600
Message-ID: <20231004212110.3753955-8-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231004212110.3753955-1-Rodrigo.Siqueira@amd.com>
References: <20231004212110.3753955-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|LV8PR12MB9261:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a48e5b6-50e4-40b3-8281-08dbc51fec75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QTIYJzTvTPmsJNjEtFU0Cm0kcefstj8UcsC0cwyT6kgoN0Vmdf5YstOy0YzpYzMhEKShB4JA6V6ImkValqWRdXMeWWDWCKoK+sWL//Vz81qxBsX1852HfOl6NPCifDW+D/0NUNE8jNUhsNqkk3p12KQcPxoW1cTAu0WZtagO+Epeybg0OFJgWtSZM/Ns95GJYpmbKwRO09VNZ++2Q8UxuBVd9r3bPx55SeXgRp5eIGRsJLb80qGnrInnNmAQyw1H4AiM30gd3Imhg45/OeScEG5DPkeOECIdgKGAEkRUf/TIL7bagGxrrtzaDNGWsKDUxOaTbHPHIG/zUsMA5x/5s/IT6/cQAOfMr6+A62al0J1kU1ReF8EyP44FqDoU6cxDlsnoQl17s3npXNDKpoLhfkkbCQ1ZTceAA20Z087reKYJte9Eswmp7+t4dr/NTbTeTxrzRpClc5S4ZpMxkOEuw3y2PSGuSPeBzJzbIN2KbR5oTbyq/cAMQSIKxSO7HJlFEyaAYmWA6L2+O7get1s2Q/DmHBGFEkzockNLhgPmwzB89S6N6jAmfct03lRrWz6TeB3svotmj/I22H+jM3H5+abd/kARJokSQbZLGYx7WW5yam2i+9fXqa1VO6kBjCzN5+4sBhwkL1prmi0iNDEUksX+DUKeotNv/N9NAVZqvrbQZPn2LP/JVUoBGrVVZhZWGjmbPEHvBcs3hd8mnDiPSgaWsP/NHT1PKVfNmPrjB1fdGoN6oKjjDoyshFC0JfbKEIbiywB4GGCofoDO/YEJKA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(39860400002)(346002)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(82310400011)(46966006)(36840700001)(40470700004)(6666004)(40460700003)(478600001)(70206006)(36860700001)(70586007)(82740400003)(86362001)(47076005)(1076003)(336012)(83380400001)(2616005)(426003)(16526019)(54906003)(26005)(8936002)(316002)(2906002)(8676002)(5660300002)(36756003)(4326008)(6916009)(41300700001)(40480700001)(81166007)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 21:21:50.4370 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a48e5b6-50e4-40b3-8281-08dbc51fec75
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9261
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
Cc: Charlene Liu <charlene.liu@amd.com>, Sunpeng.Li@amd.com,
 richard.gong@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Alex Deucher <alexander.deucher@amd.com>, Harry.Wentland@amd.com,
 Alvin Lee <alvin.lee2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <charlene.liu@amd.com>

Add z8 watermarks to struct for later ASIC use.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Charlene Liu <charlene.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c | 2 ++
 drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.h | 2 ++
 drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c        | 2 ++
 drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c      | 2 ++
 drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h      | 1 +
 5 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
index e65e86c84745..0d446d850313 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
@@ -10169,6 +10169,8 @@ dml_get_var_func(wm_memory_trip, dml_float_t, mode_lib->mp.UrgentLatency);
 dml_get_var_func(wm_fclk_change, dml_float_t, mode_lib->mp.Watermark.FCLKChangeWatermark);
 dml_get_var_func(wm_usr_retraining, dml_float_t, mode_lib->mp.Watermark.USRRetrainingWatermark);
 dml_get_var_func(wm_dram_clock_change, dml_float_t, mode_lib->mp.Watermark.DRAMClockChangeWatermark);
+dml_get_var_func(wm_z8_stutter_enter_exit, dml_float_t, mode_lib->mp.Watermark.Z8StutterEnterPlusExitWatermark);
+dml_get_var_func(wm_z8_stutter, dml_float_t, mode_lib->mp.Watermark.Z8StutterExitWatermark);
 dml_get_var_func(fraction_of_urgent_bandwidth, dml_float_t, mode_lib->mp.FractionOfUrgentBandwidth);
 dml_get_var_func(fraction_of_urgent_bandwidth_imm_flip, dml_float_t, mode_lib->mp.FractionOfUrgentBandwidthImmediateFlip);
 dml_get_var_func(urgent_latency, dml_float_t, mode_lib->mp.UrgentLatency);
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.h b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.h
index 2a0545801f77..8452485684f5 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.h
@@ -85,6 +85,8 @@ dml_get_var_decl(wm_stutter_exit, dml_float_t);
 dml_get_var_decl(wm_stutter_enter_exit, dml_float_t);
 dml_get_var_decl(wm_memory_trip, dml_float_t);
 dml_get_var_decl(wm_dram_clock_change, dml_float_t);
+dml_get_var_decl(wm_z8_stutter_enter_exit, dml_float_t);
+dml_get_var_decl(wm_z8_stutter, dml_float_t);
 dml_get_var_decl(urgent_latency, dml_float_t);
 dml_get_var_decl(clk_dcf_deepsleep, dml_float_t);
 dml_get_var_decl(wm_fclk_change, dml_float_t);
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
index 5bd695628ce8..da18c4b8c257 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
@@ -369,6 +369,8 @@ void dml2_extract_watermark_set(struct dcn_watermarks *watermark, struct display
 	watermark->urgent_latency_ns = dml_get_urgent_latency(dml_core_ctx) * 1000;
 	watermark->cstate_pstate.fclk_pstate_change_ns = dml_get_wm_fclk_change(dml_core_ctx) * 1000;
 	watermark->usr_retraining_ns = dml_get_wm_usr_retraining(dml_core_ctx) * 1000;
+	watermark->cstate_pstate.cstate_enter_plus_exit_z8_ns = dml_get_wm_z8_stutter_enter_exit(dml_core_ctx) * 1000;
+	watermark->cstate_pstate.cstate_exit_z8_ns = dml_get_wm_z8_stutter(dml_core_ctx) * 1000;
 }
 
 void dml2_initialize_det_scratch(struct dml2_context *in_ctx)
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
index e4f2f3eb9b32..552d5cffce2d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
@@ -717,6 +717,8 @@ bool dml2_create(const struct dc *in_dc, const struct dml2_configuration_options
 
 	initialize_dml2_soc_states(*dml2, in_dc, &(*dml2)->v20.dml_core_ctx.soc, &(*dml2)->v20.dml_core_ctx.states);
 
+	/*Initialize DML20 instance which calls dml2_core_create, and core_dcn3_populate_informative*/
+	//dml2_initialize_instance(&(*dml_ctx)->v20.dml_init);
 	return true;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
index e76726018927..4d0377354bdd 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
@@ -63,6 +63,7 @@ struct dml2_dcn_clocks {
 	unsigned int ref_dtbclk_khz;
 	bool p_state_supported;
 	unsigned int cab_num_ways_required;
+	unsigned int dcfclk_khz_ds;
 };
 
 struct dml2_dc_callbacks {
-- 
2.40.1

