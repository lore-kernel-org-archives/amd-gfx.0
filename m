Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC1FAEE4993
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Aug 2023 15:51:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B967710E43E;
	Wed, 23 Aug 2023 15:51:19 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFAA810E43C
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Aug 2023 15:51:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gZhAYrp5Y8Ri/fE7qzTWTVi8RHoH4l+HzTBwhgA5cKtijSd+H8IjDv502TeEiO1Smcr0G3OboiBN95Mpbtx6GvCmPdqLRSgU3Rfkh6A3ddjsNTNVT44T4yuKAzTV6HR7db502fvzTnHM1dmwXfTh2RhrA+bIuOqqVl2mJrf1f7nm3VJGCu7uPkJjE3FIlh3QRw9C+W3Y/B82Ixf6RKyrsVjRbS5Aijeq9UKRM8yzGRKRknMBnipfiqH7Gvw85qOXe3QQ2bbU8+0wiYXpG+SOqkz7Bs+v4PdMbSMMu/DDmkKipR0+rv11ZUzHpPHCgY2VV5KoNsYILpTmJkcKAALz7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oe1VHFXFpv9HcnBho+OKeEvpr9fONpLCSxJ/6TIXL5Q=;
 b=GDL9FJGt0hehBhyQyFvKa72ASVSoId6w+7vJzyF8ijEKJ3QBwcwlTFz371ZJldy5z9vx6xQyREUoeWv6zROHwmdK+64mzuPd/+0WGXr5+uzd0U+mLgtlFVeziQLtqfBPtUr7mZrFMSK9CWv5XGQ4a1oN2+HJhYG2uz0MVBXtPiOdfRqVYizq1EA7eQtHIEmZmcBzqB+sszYfyR2eetCDBbRjWAAvzlj0ZdxR8I9dBtLxW0edgL7IrRdfS1kAIaGgnwswetqo/YgaUUvXqniZGEmDpDWmIiiXQy3RdfYan8k3pwpAyRYzC3eh7Yzh3GxBZ5rFM3QauqkeK3s8pOn+mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oe1VHFXFpv9HcnBho+OKeEvpr9fONpLCSxJ/6TIXL5Q=;
 b=DikciLesnHiz4oQmjwmMG8pU3rIR0kDPQiII+MurnbzV4fZ6/MI5Ow4Yxk64tMYK+jRa9UlM2KtnFngJ5OSXv2Wu4D6Ntm0FRM706etd26wMNAkJqOXf5HxZjYqD86u8Cq8s0YYwjzPhhiLuuYkfuO6Td7Q2GbPZJQTDlyXq4vQ=
Received: from DM6PR21CA0010.namprd21.prod.outlook.com (2603:10b6:5:174::20)
 by BL3PR12MB6402.namprd12.prod.outlook.com (2603:10b6:208:3b2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Wed, 23 Aug
 2023 15:51:13 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:5:174:cafe::ed) by DM6PR21CA0010.outlook.office365.com
 (2603:10b6:5:174::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.7 via Frontend
 Transport; Wed, 23 Aug 2023 15:51:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Wed, 23 Aug 2023 15:51:13 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 10:51:10 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/35] drm/amd/display: Update dc.h for DCN35 support
Date: Wed, 23 Aug 2023 11:50:24 -0400
Message-ID: <20230823155048.2526343-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230823155048.2526343-1-alexander.deucher@amd.com>
References: <20230823155048.2526343-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|BL3PR12MB6402:EE_
X-MS-Office365-Filtering-Correlation-Id: 71811763-7de0-45e6-d1ca-08dba3f0c779
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OKPYWYRD6eaL2Fne5mUwSsoiaLGzNGUrEsCrf6fxFcQC7LM7xw97ShgUzv5fWggdw9lmNVBzbQAWcLB0wvv38kP/eFNMr6GmxwdxWUqRdE11cET3DiPvGqE43aFs6kKPpI1tAi692VQz3y0aDAEHy+2MQ8ic+ZejrX2ZHYogzEBB3k139XjDApNuZRyp0PUPD2QFfaN/2nfoDw+5IF2lDNveCaXX/WhG076MppaSTVmsmGinSCxmFzkZAKORGm9vS0nVq+o0QpJ51l2UvAu0wvTY8VhjYV+V8qClkMp/KzjO4nCmpMFbw1PIQqG43JkzBKLrkDCuVLnfRQWTxBb45IJZ3JptQkfytOSDMBkLHoti1frze/jGxWPOqbvvQw7Hg9cnJ3RuP4n6p/9oYMBi6Wwnkx5uZ8sEnMYnh6ztOWKz9ZTyDYrCbtbM/84K3kNuXW6/eV/Lar6vy56BR4/Va7dHwfi1Rdz9pM2x+Sra9+qihS19zkCdiFGCK3L31o5W5C5kT0apeM7fKuH5W1XKevVE8bzo+F+AaxakpTk/cNk4yp7M8e5WC2zj08v4gLaRhbMXcAgeHEQSKCLEIV8AsQ3/UZiaGe1Yh2jBGjffaXEE8j7PLKgYBL7oFLfVLlNHyH92MVUwO8DGOSATTr+9t1ycahRZU3k3+n4SWkAtWWsYqUmvSoLO2f/O4zR023CFUf2h8RPhpqrmocGSHFde2UAT1KUgRAj5CraKiZBxdKfvi8FsLQ0T8IChk7r7unrzaW2CI1EHzh0Vl4zGwzENYQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(396003)(376002)(346002)(1800799009)(82310400011)(186009)(451199024)(40470700004)(46966006)(36840700001)(47076005)(40460700003)(36860700001)(66899024)(15650500001)(83380400001)(2906002)(356005)(81166007)(82740400003)(86362001)(36756003)(40480700001)(41300700001)(70206006)(54906003)(70586007)(7696005)(316002)(6916009)(2616005)(8676002)(4326008)(8936002)(478600001)(6666004)(26005)(16526019)(1076003)(5660300002)(336012)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 15:51:13.6247 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71811763-7de0-45e6-d1ca-08dba3f0c779
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6402
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Qingqing Zhuo <Qingqing.Zhuo@amd.com>, Harry Wentland <Harry.Wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>

[Why & How]
Update dc.h for DCN35 usage.

Signed-off-by: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
Acked-by: Harry Wentland <Harry.Wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 56 +++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index a1d3c860aede..4d04728b48de 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -246,6 +246,7 @@ struct dc_caps {
 	bool extended_aux_timeout_support;
 	bool dmcub_support;
 	bool zstate_support;
+	bool ips_support;
 	uint32_t num_of_internal_disp;
 	enum dp_protocol_version max_dp_protocol_version;
 	unsigned int mall_size_per_mem_channel;
@@ -645,6 +646,53 @@ union root_clock_optimization_options {
 	uint32_t u32All;
 };
 
+union fine_grain_clock_gating_enable_options {
+	struct {
+		bool dccg_global_fgcg_rep : 1; /* Global fine grain clock gating of repeaters */
+		bool dchub : 1;	   /* Display controller hub */
+		bool dchubbub : 1;
+		bool dpp : 1;	   /* Display pipes and planes */
+		bool opp : 1;	   /* Output pixel processing */
+		bool optc : 1;	   /* Output pipe timing combiner */
+		bool dio : 1;	   /* Display output */
+		bool dwb : 1;	   /* Display writeback */
+		bool mmhubbub : 1; /* Multimedia hub */
+		bool dmu : 1;	   /* Display core management unit */
+		bool az : 1;	   /* Azalia */
+		bool dchvm : 1;
+		bool dsc : 1;	   /* Display stream compression */
+
+		uint32_t reserved : 19;
+	} bits;
+	uint32_t u32All;
+};
+
+enum pg_hw_pipe_resources {
+	PG_HUBP = 0,
+	PG_DPP,
+	PG_DSC,
+	PG_MPCC,
+	PG_OPP,
+	PG_OPTC,
+	PG_HW_PIPE_RESOURCES_NUM_ELEMENT
+};
+
+enum pg_hw_resources {
+	PG_DCCG = 0,
+	PG_DCIO,
+	PG_DIO,
+	PG_DCHUBBUB,
+	PG_DCHVM,
+	PG_DWB,
+	PG_HPO,
+	PG_HW_RESOURCES_NUM_ELEMENT
+};
+
+struct pg_block_update {
+	bool pg_pipe_res_update[PG_HW_PIPE_RESOURCES_NUM_ELEMENT][MAX_PIPES];
+	bool pg_res_update[PG_HW_RESOURCES_NUM_ELEMENT];
+};
+
 union dpia_debug_options {
 	struct {
 		uint32_t disable_dpia:1; /* bit 0 */
@@ -774,6 +822,7 @@ struct dc_debug_options {
 	bool disable_dpp_power_gate;
 	bool disable_hubp_power_gate;
 	bool disable_dsc_power_gate;
+	bool disable_optc_power_gate;
 	int dsc_min_slice_height_override;
 	int dsc_bpp_increment_div;
 	bool disable_pplib_wm_range;
@@ -849,6 +898,7 @@ struct dc_debug_options {
 	bool ignore_cable_id;
 	union mem_low_power_enable_options enable_mem_low_power;
 	union root_clock_optimization_options root_clock_optimization;
+	union fine_grain_clock_gating_enable_options enable_fine_grain_clock_gating;
 	bool hpo_optimization;
 	bool force_vblank_alignment;
 
@@ -862,6 +912,7 @@ struct dc_debug_options {
 	enum det_size crb_alloc_policy;
 	int crb_alloc_policy_min_disp_count;
 	bool disable_z10;
+	unsigned int disable_ips;
 	bool enable_z9_disable_interface;
 	bool psr_skip_crtc_disable;
 	union dpia_debug_options dpia_debug;
@@ -896,6 +947,8 @@ struct dc_debug_options {
 	bool dig_fifo_off_in_blank;
 	bool temp_mst_deallocation_sequence;
 	bool override_dispclk_programming;
+	bool otg_crc_db;
+	bool disallow_dispclk_dppclk_ds;
 	bool disable_fpo_optimizations;
 	bool support_eDP1_5;
 	uint32_t fpo_vactive_margin_us;
@@ -907,9 +960,12 @@ struct dc_debug_options {
 	bool disable_dp_plus_plus_wa;
 	uint32_t fpo_vactive_min_active_margin_us;
 	uint32_t fpo_vactive_max_blank_us;
+	bool enable_hpo_pg_support;
 	bool enable_legacy_fast_update;
 	bool disable_dc_mode_overwrite;
 	bool replay_skip_crtc_disabled;
+	bool ignore_pg;/*do nothing, let pmfw control it*/
+	bool psp_disabled_wa;
 };
 
 struct gpu_info_soc_bounding_box_v1_0;
-- 
2.41.0

