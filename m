Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4952C27C65
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jun 2024 16:53:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD4AD10E6DF;
	Tue, 11 Jun 2024 16:53:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="usP7UCkp";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDBFD10E6D5
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jun 2024 16:52:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hA9wdLgt4Dc0nuPJZjViw/LTDFDioLccCaatNY41zbsVh8ZagpSWYZlWsxkFOAKQt91/nghwVnxIuEExheR+VO4ZNRGjoTgVZMfIztPCJgNrT+AAyYF6W8f+gaJS8dsuzhRr/T71M1SEa4D3PKihJ40vPxkhTkMYa6ofdS578kW8nz/4RU5T5stMuHeBau8Abj8h9pihLoErBnKuWc51VNUzy2mU/dauDXwIpj6EIjh7UtWnBj2K4cfjrSTlQBUY8fIkn53KUBHKl3J6NSZGHaF6+PY6RZSLfnL83XMeqE786rvGBFJ2JGmYGe5tHn4ko9+mb0BMG5C4OBS1dOeurg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=omiT9qQ5FK+i8C/ijbhx9oOTASeIiJMu4fJdkfGjBOk=;
 b=UjisvQtFVjrCk5WyFCHPR2LQGI+ToVumeh06jxG8Ep6siDJk8ej4AHwH3+67NOTxB4Izb6n/51NudqtB1/MDYZxmQBNWsBWyIN4IkKm08xrRDd52HWMwrVBUTx4AVdZURG365Jxc0gEnUl4s9l8sr8OZJt25atY0bfmVqU6oZmBzmt1rN0w/ljC1E+ZaNVfsfWwu1obmu++UbNBVwsV9+ribqScIDWVVHCtDefqvGB/pgc5OE/9HxKygTuEKdWeoh8YQD9mSCz71oioJsT9PozWNGMhARLR9kBAOoEl8wDKKp8nfloc9YbKWzzqE3fSeN2860G45yrOPwNy5QEFNbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=omiT9qQ5FK+i8C/ijbhx9oOTASeIiJMu4fJdkfGjBOk=;
 b=usP7UCkpsVvcMpQps/QznQGoanaSwyw5jS5ccXQpEQtXHWZRKjO6nyoNZtQ0Y04R2Qqbo3sKyLwx3gylNaHlw7MPrKoc+bN6vGQ8VZJ8ORDElR3LKwyxqb4Exo368hVJGt0oThQVR17eJ9aDrmaX+7oTBASi8gXb3ypudLYcfyQ=
Received: from BN8PR07CA0034.namprd07.prod.outlook.com (2603:10b6:408:ac::47)
 by SA3PR12MB7952.namprd12.prod.outlook.com (2603:10b6:806:316::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Tue, 11 Jun
 2024 16:52:38 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:408:ac:cafe::f) by BN8PR07CA0034.outlook.office365.com
 (2603:10b6:408:ac::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.25 via Frontend
 Transport; Tue, 11 Jun 2024 16:52:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 11 Jun 2024 16:52:38 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Jun
 2024 11:52:34 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Daniel Wheeler <daniel.wheeler@amd.com>, <Harry.Wentland@amd.com>,
 <Sunpeng.Li@amd.com>, <Bhawanpreet.Lakha@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>,
 <qingqing.zhuo@amd.com>, <roman.li@amd.com>, <wayne.lin@amd.com>,
 <solomon.chiu@amd.com>, <agustin.gutierrez@amd.com>, <jerry.zuo@amd.com>,
 <hamza.mahfooz@amd.com>, Alex Hung <alex.hung@amd.com>, Harry Wentland
 <harry.wentland@amd.com>
Subject: [PATCH 17/36] drm/amd/display: Add null checker before access structs
Date: Tue, 11 Jun 2024 12:51:20 -0400
Message-ID: <20240611165204.195093-18-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240611165204.195093-1-hamza.mahfooz@amd.com>
References: <20240611165204.195093-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|SA3PR12MB7952:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fcc62b3-223f-4e57-cc6f-08dc8a36e6da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230032|82310400018|36860700005|376006|1800799016; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?58Xzf3jqa2MrX/FQxGBIM/CYPBc39m62Qws9b4LKUgwl14iRCuMiSNw9BRsO?=
 =?us-ascii?Q?N/DTTheI/kDy2fAkX7QnRPL6kckwa9Prvy924PzuYxmc8WHEWFHJwZIsgYyE?=
 =?us-ascii?Q?S2ASTjae/L/zqvKDicGOHvdwb7twBqI7eYoJp4yLWY57OBztnYc/ZEwBNAP3?=
 =?us-ascii?Q?KRso15Q9JUzmOZxi6+WV2rYPfKCyA8GZve6GbtkjgidJb9q40Pb6N9KGXoUt?=
 =?us-ascii?Q?12TpdRTAoZkiwf3Reu/SMEes9t9c6O+Xjw6mMV4WtKDosZY4n/IQhLkpBAtm?=
 =?us-ascii?Q?MTQdlxi7Z84Sf6ubiYcLOMnIQHGpVHV39qd4gCPBacgjNiRec2bYeNLdbqqK?=
 =?us-ascii?Q?XI/qfevkVevRpy3ZFInSUi6J65zcpld7uAbykkpi50FfmA3rks26PPStgOUd?=
 =?us-ascii?Q?zXfsykDZGGaia332EQ9SswkmoltqCb+ioVjcajVufj6ZNWDOXW28beGo7zsQ?=
 =?us-ascii?Q?OWZ70dKUMqOsYjnf+Gvo0DENlWu/ozeBxS1hd33AbTXojUphPVctB/NGVfTb?=
 =?us-ascii?Q?kpBsV5v4QcrPdFBHXZx688Rlkts+T8RxtIZ7/8ar5eCYyUVV2UcJglAMctW7?=
 =?us-ascii?Q?TyE7F4gxS5oZ6bj0r/c3THEPy3yWStA9pzzExOE+O0NKqtwOisbwI/pZsCVu?=
 =?us-ascii?Q?RRiD0RuV/6EsHcNsvdAy5KaJFV6d7MLtQIH9VXEPwo8COSbhADyWiWiE5zN2?=
 =?us-ascii?Q?Ov5PDNyinsCCtML5rxdXUHSMJ7bnSaDYUhRsv3Vra1UCyrn7KqDTvZ+kD8aF?=
 =?us-ascii?Q?HH8JvFMwgcVjDRxiezUD25gInHZKrD5bTm/SUTxvFyolkVBx4KdTAO+9Cj+S?=
 =?us-ascii?Q?MUBBw9dvnQbxGfA7+CszM7/M2wagUhHUEyM9O0Rov3Zc17V5AiB9OgeQzRI0?=
 =?us-ascii?Q?OMmwJtXaYPcxgVpt1r1D4kyP7wcv2l7xs/SRPlJ8xT4++eTaV0CcXSUklrLz?=
 =?us-ascii?Q?uL7Iz9yXCgPyq6Rbq0jo7/EOBuYtJaO+2qCxaDEcQX/L58Pjl/Sq98EFhqE2?=
 =?us-ascii?Q?ry9dr6pdbzkQiioXes+tQoq679FxF9pfaoiYPMdZOpT27Ed8C6D+Z7w1mlKg?=
 =?us-ascii?Q?2bJHrip4NuG6lztoflVyqb8tm4d5lrPEiFfO2btc6U0bdnTeht5tYn7TC0aE?=
 =?us-ascii?Q?OaRcqZtVbQj3X2PA2ClojWyIOygCpYV7L48lPU2jwH1mYTXLFYbT0W7aBluk?=
 =?us-ascii?Q?3b1oxL+1VF+X6Yuz0ufmpKL75Hd2hKvO0u19CR6g/3qPxPDqKmuyK1oRESw+?=
 =?us-ascii?Q?1NnCUD1dsTEbLugjnnxIuCmwbo4bUtleHni5kwlo0wXgw2qhBv++aLngl1lc?=
 =?us-ascii?Q?1Hi3wIcv+10lpD7vp4d32B2gscrz4QtF09qT86zD80SwfLx9XRsm6pYskoAk?=
 =?us-ascii?Q?2/11fiAe7FAzaobkg2fvAhrcleattMLm+C756er8sVPOhcZVyA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230032)(82310400018)(36860700005)(376006)(1800799016); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 16:52:38.3077 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fcc62b3-223f-4e57-cc6f-08dc8a36e6da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7952
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

From: Alex Hung <alex.hung@amd.com>

Checks null pointer before accessing various structs.

This fixes 5 NULL_RETURNS issues reported by Coverity.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_utils.c      | 2 ++
 .../display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c | 5 +++++
 .../gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c   | 2 +-
 .../gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c | 4 +++-
 4 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_utils.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_utils.c
index 4166332b5b89..b97d9abfdbc6 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_utils.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_utils.c
@@ -360,6 +360,8 @@ static struct dc_plane_state *dml21_add_phantom_plane(struct dml2_context *dml_c
 	struct dc_plane_state *phantom_plane;
 
 	phantom_plane = dml_ctx->config.svp_pstate.callbacks.create_phantom_plane(dc, context, main_plane);
+	if (!phantom_plane)
+		return NULL;
 
 	phantom_plane->format = main_plane->format;
 	phantom_plane->rotation = main_plane->rotation;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
index 7272a04b9d1d..00fedc00a735 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
@@ -1082,12 +1082,17 @@ static bool is_timing_group_schedulable(
 
 	/* init allow start and end lines for timing group */
 	stream_method_fams2_meta = get_per_method_common_meta(pmo, per_stream_pstate_strategy[base_stream_idx], base_stream_idx);
+	if (!stream_method_fams2_meta)
+		return false;
+
 	group_fams2_meta->allow_start_otg_vline = stream_method_fams2_meta->allow_start_otg_vline;
 	group_fams2_meta->allow_end_otg_vline = stream_method_fams2_meta->allow_end_otg_vline;
 	group_fams2_meta->period_us = stream_method_fams2_meta->period_us;
 	for (i = base_stream_idx + 1; i < display_cfg->display_config.num_streams; i++) {
 		if (is_bit_set_in_bitfield(pmo->scratch.pmo_dcn4.synchronized_timing_group_masks[timing_group_idx], i)) {
 			stream_method_fams2_meta = get_per_method_common_meta(pmo, per_stream_pstate_strategy[i], i);
+			if (!stream_method_fams2_meta)
+				continue;
 
 			if (group_fams2_meta->allow_start_otg_vline < stream_method_fams2_meta->allow_start_otg_vline) {
 				/* set group allow start to larger otg vline */
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
index f93853d434d2..e783afbbb397 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
@@ -2628,7 +2628,7 @@ static bool dcn20_resource_construct(
 		ranges.writer_wm_sets[0].max_drain_clk_mhz = PP_SMU_WM_SET_RANGE_CLK_UNCONSTRAINED_MAX;
 
 		/* Notify PP Lib/SMU which Watermarks to use for which clock ranges */
-		if (pool->base.pp_smu->nv_funcs.set_wm_ranges)
+		if (pool->base.pp_smu && pool->base.pp_smu->nv_funcs.set_wm_ranges)
 			pool->base.pp_smu->nv_funcs.set_wm_ranges(&pool->base.pp_smu->nv_funcs.pp_smu, &ranges);
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c
index 070a4efb308b..131d98025bd4 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c
@@ -795,11 +795,13 @@ static struct link_encoder *dcn201_link_encoder_create(
 {
 	struct dcn20_link_encoder *enc20 =
 		kzalloc(sizeof(struct dcn20_link_encoder), GFP_ATOMIC);
-	struct dcn10_link_encoder *enc10 = &enc20->enc10;
+	struct dcn10_link_encoder *enc10;
 
 	if (!enc20)
 		return NULL;
 
+	enc10 = &enc20->enc10;
+
 	dcn201_link_encoder_construct(enc20,
 			enc_init_data,
 			&link_enc_feature,
-- 
2.45.1

