Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF815C87FCB
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jul 2025 19:17:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53B6B10E120;
	Wed, 30 Jul 2025 19:17:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GS90Vm+4";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78CBA10E120
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Jul 2025 19:17:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vlVLVT4r0ju1YKpxvC6Y/HdXoopU4n4WR5zN7phtTScGPaD5d6EEhGzj7mTkAJR9QmK4GQAwraNocw/v6j8Bi8cgYHTiy0/6hyKLn9WT7LsTYaCqov3Vv+GOlSHCogTJB6uv0CtCYQdJWXNB9HJWGBtUnwxVrSP1e64wIEjetlksHRfhEzp1szY0fZuVK4VPoTuvHVxRfIchxJ5v6oqgQeKzulDbFhelIUV8rPRHivkHsJJ/lrlrB1ZZROMR0oW/Dk5W5gcp+y3PcP6ncjGKpR0EmUpGcEt45uFz4Rm59DzRPevSTXr4xDPegPuCtxyiP3VnySN+4cd0znwc4ijtHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PgUpq1ekaigsabYPokLgyxrpk/QN2ScBB1A1PT1jpU8=;
 b=WAIuJ/qCTewM/fJKq+BQagdU76eFoliZdM4UNFhxrykI8fmIHh6yBqbT2Ha0Si+5X+F5p/V1G4aced62hksX/se5s8NBoczmQP2bVn+x8xs2/V9XO52D34U50WIE5FEdXECGml90+tAnXLF7EKdhsaSZfzlF3zCU9Uo2DlxA83FLS2FJFg+ITR+R4sI3dmcKGVMSFuT13VYBq4WLhQ2Q+TVmdjd5ggRkJCvHiwLW+QoSDHGUuRojclHYR4YBWGGvwXGGHVIhaP8W3G4wnrA93uHToTKLRRnNLnKsyCFb1kMPX/GV6umYPWm8FdGT71yjAvb8uloWrCzMf/almHLpLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PgUpq1ekaigsabYPokLgyxrpk/QN2ScBB1A1PT1jpU8=;
 b=GS90Vm+4o75VFYCpAyfYY8qrqOQ/91onoVRsTGLObBRhUDZSsngBIFt4iMTvN61uxMUqy2oR1VPvpPJPnhb3BDYYxTLW9Scafn865fSeDtoOBE8UxjdMhOcxTImOgYVreoim8uJyUgUrxFpzzLk5PGFew10zttXU7nXcJoiOuG8=
Received: from DM5PR07CA0087.namprd07.prod.outlook.com (2603:10b6:4:ae::16) by
 PH0PR12MB7862.namprd12.prod.outlook.com (2603:10b6:510:26d::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.11; Wed, 30 Jul 2025 19:17:21 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:4:ae:cafe::fc) by DM5PR07CA0087.outlook.office365.com
 (2603:10b6:4:ae::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.12 via Frontend Transport; Wed,
 30 Jul 2025 19:17:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Wed, 30 Jul 2025 19:17:20 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Jul
 2025 14:01:12 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Jul
 2025 14:01:02 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 30 Jul 2025 14:01:01 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Reza Amini <reza.amini@amd.com>, Krunoslav Kovac
 <krunoslav.kovac@amd.com>
Subject: [PATCH 09/12] drm/amd/display: Fixing hubp programming of 3dlut fast
 load
Date: Wed, 30 Jul 2025 14:59:00 -0400
Message-ID: <20250730185903.1023256-10-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250730185903.1023256-1-Roman.Li@amd.com>
References: <20250730185903.1023256-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|PH0PR12MB7862:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ab26857-7abe-418f-3848-08ddcf9db4d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?o6Y2eZs7vuKyEDPVEikuneD42YoIjGDhGco0hoRmM9MF8mPgdnYSlJ0tNkMj?=
 =?us-ascii?Q?rco5fWdbs5BluTozSLLdXF+PUk2WA9jS7xqqJDH45T6KT6JhbT9suc4CArpX?=
 =?us-ascii?Q?bt8KXIzaMZEgYfE80HjWUT3JIBJTCa08e8p0lBYHEQwkvS04+Coe4iqP3LhV?=
 =?us-ascii?Q?UpFCaw4PppBk05c8IMgAXURAeB63c/xViS/0dhqotiqKjzktsBZTwbSU6JzJ?=
 =?us-ascii?Q?QhDT+HxLgNxRvtObd94BtLhMy/jKiyEYtPkOFhFkg1lMAfKM1sh8r6zmOeDq?=
 =?us-ascii?Q?fD3q3WVnz6pWyKy5cofR1U++YFpepU6xglVjXVw6zQTib1bOAcidYzn+fbhG?=
 =?us-ascii?Q?yAjdAJSz7Ba6ltGD/lf+b7+6wDKpZ2sftbg+T4i3xnAdVHvW8vGVs6I2fS/Q?=
 =?us-ascii?Q?+GC8jkrwnnTqvwGmNvNI4INfNlFyD+/uZXN/I2kaXyZOOIoXbihYYO6IQRUJ?=
 =?us-ascii?Q?vArXEtoQrFqbFyqn88AloZ7I81eSToc7dQbioZmF38FhbFZdHZYSSA8d3wF6?=
 =?us-ascii?Q?Eu0TfCxTtMdLW5juEEPbDtzRGD8lZ5N0yGz1bCQaUmnKoJ0cn9DfeYZRt3Aa?=
 =?us-ascii?Q?RDKqyDEDMeAUQCHq59SEuLhXIH4VYYFTRu9PhD6WKOh+lqkXeoTfdwkl2Vy3?=
 =?us-ascii?Q?IY9HTQ4cOrAkGCFux7F7nO6STsXumXl/sFcgNOJjlZOGmC5MzZ9JLxU2vvSU?=
 =?us-ascii?Q?aC92buQIdwBHRiH34Vfsau/dZGs4wcCmTy+Sj6k2pXMni2vHlZiHKr26sCQl?=
 =?us-ascii?Q?Deu5Jcs6KY/D24AvGqWtnNEd/Q1XlQ5P3ZOsSqC8/J7y9ohNeEzxBBLsoPa3?=
 =?us-ascii?Q?uqZc5mORrhPvSx49ab40lFXYru42LEcYA1lM9PfYaHNkdKfvJZL1FbiUGT1k?=
 =?us-ascii?Q?USIqGdgWMheZ5bwQqmbDH32mBkHFCTBrbWUbgOR9HSyR6pra1u7BsENC2O5O?=
 =?us-ascii?Q?1dYaE00PyPQxwzv4DFe+ttP60Yx7yE+Blg/wevhvr6urTwDYZH7fX7zZ4cyV?=
 =?us-ascii?Q?aB0IrDsFZRfWKOCagQL5DbcYG+JUJ+UICYFIIaDGA4m7yoWFStl7Ej9SFfA7?=
 =?us-ascii?Q?ClEY/hRtYX55KPJxMqz4FGp56zFd0CQeYh5ilBOSmabFkQASgMNe7o1lb5dp?=
 =?us-ascii?Q?8C+smjg2szMMcXAkJxNslGje2HgXvFGgr1rLldw3fiwrZKyVQ/Me7fzE08ZR?=
 =?us-ascii?Q?/MMPGTg1CMvuiU1pelv5hwb9BHQPIQCY73tawIq9Ia8MdgechHN2SzwUqCC2?=
 =?us-ascii?Q?hzpvtz5Q3x/ghw2gzXySU/F/7Xcr3KkRNI8QoGaWpQTwryS7HkXHo+oJE6dT?=
 =?us-ascii?Q?Tg52+DXkdnoENd3igRl4CP8rmfcPm/qdEjgHmelzutyqdXHZnZoJ8gkUqAIh?=
 =?us-ascii?Q?tnPYOHA4wx9Su9N+EudZBAtK49qFjGnW9Z7YnqvmHbMTstu8rEjC/M91mgUZ?=
 =?us-ascii?Q?6fN7fEswrCDQNMBqPS8j1QVmoZHKEnpdRNehcrHsafYudtdMecNeE1MdFYLO?=
 =?us-ascii?Q?hY8INOwEgCECDyL0NlvMKarBos7jQ+qJGkvw?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 19:17:20.6156 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ab26857-7abe-418f-3848-08ddcf9db4d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7862
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

From: Reza Amini <reza.amini@amd.com>

[why]
HUBP needs to know the size of the lut's destination in MPC.
This is currently defaulted to 17, and needs to be set for specific
lut size.

[how]
Define and apply the missing hubp field. Taking this opportunity
to consolidate the programming of 3dlut into a hubp and mpc function.

Reviewed-by: Krunoslav Kovac <krunoslav.kovac@amd.com>
Signed-off-by: Reza Amini <reza.amini@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h           | 26 ++++++++
 .../amd/display/dc/hubp/dcn10/dcn10_hubp.h    |  1 +
 .../amd/display/dc/hubp/dcn20/dcn20_hubp.h    |  1 +
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.c  | 38 +++++++++++
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.h  |  4 ++
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   | 63 ++++++++++++++-----
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  | 19 +++++-
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h   | 11 ++++
 8 files changed, 148 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 5653c1673aec..c013b28207a1 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1311,6 +1311,32 @@ union dc_3dlut_state {
 };
 
 
+#define MATRIX_9C__DIM_128_ALIGNED_LEN   16 // 9+8 :  9 * 8 +  7 * 8 = 72  + 56  = 128 % 128 = 0
+#define MATRIX_17C__DIM_128_ALIGNED_LEN  32 //17+15:  17 * 8 + 15 * 8 = 136 + 120 = 256 % 128 = 0
+#define MATRIX_33C__DIM_128_ALIGNED_LEN  64 //17+47:  17 * 8 + 47 * 8 = 136 + 376 = 512 % 128 = 0
+
+struct lut_rgb {
+	uint16_t b;
+	uint16_t g;
+	uint16_t r;
+	uint16_t padding;
+};
+
+//this structure maps directly to how the lut will read it from memory
+struct lut_mem_mapping {
+	union {
+		//NATIVE MODE 1, 2
+		//RGB layout          [b][g][r]      //red  is 128 byte aligned
+		//BGR layout          [r][g][b]      //blue is 128 byte aligned
+		struct lut_rgb rgb_17c[17][17][MATRIX_17C__DIM_128_ALIGNED_LEN];
+		struct lut_rgb rgb_33c[33][33][MATRIX_33C__DIM_128_ALIGNED_LEN];
+
+		//TRANSFORMED
+		uint16_t linear_rgb[(33*33*33*4/128+1)*128];
+	};
+	uint16_t size;
+};
+
 struct dc_rmcm_3dlut {
 	bool isInUse;
 	const struct dc_stream_state *stream;
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.h b/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.h
index f8f991785d4f..0b7547d5b488 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.h
@@ -671,6 +671,7 @@ struct dcn_fl_regs_st {
 	uint32_t lut_done;
 	uint32_t lut_addr_mode;
 	uint32_t lut_width;
+	uint32_t lut_mpc_width;
 	uint32_t lut_tmz;
 	uint32_t lut_crossbar_sel_r;
 	uint32_t lut_crossbar_sel_g;
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.h b/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.h
index 62369be070ea..f325db555102 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.h
@@ -264,6 +264,7 @@
 	type HUBP_3DLUT_DONE;\
 	type HUBP_3DLUT_ADDRESSING_MODE;\
 	type HUBP_3DLUT_WIDTH;\
+	type HUBP_3DLUT_MPC_WIDTH;\
 	type HUBP_3DLUT_TMZ;\
 	type HUBP_3DLUT_CROSSBAR_SELECT_Y_G;\
 	type HUBP_3DLUT_CROSSBAR_SELECT_CB_B;\
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
index 705b98b1b6cc..5028180ad80a 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
@@ -127,6 +127,43 @@ void hubp401_program_3dlut_fl_format(struct hubp *hubp, enum hubp_3dlut_fl_forma
 	REG_UPDATE(_3DLUT_FL_CONFIG, HUBP0_3DLUT_FL_FORMAT, format);
 }
 
+void hubp401_program_3dlut_fl_config(
+	struct hubp *hubp,
+	struct hubp_fl_3dlut_config *cfg)
+{
+	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
+
+	uint32_t mpc_width = {(cfg->width == 17) ? 0 : 1};
+	uint32_t width = {cfg->width};
+
+	if (cfg->layout == DC_CM2_GPU_MEM_LAYOUT_1D_PACKED_LINEAR)
+		width = (cfg->width == 17) ? 4916 : 35940;
+
+	REG_UPDATE_2(_3DLUT_FL_CONFIG,
+		HUBP0_3DLUT_FL_MODE, cfg->mode,
+		HUBP0_3DLUT_FL_FORMAT, cfg->format);
+
+	REG_UPDATE_2(_3DLUT_FL_BIAS_SCALE,
+		HUBP0_3DLUT_FL_BIAS, cfg->bias,
+		HUBP0_3DLUT_FL_SCALE, cfg->scale);
+
+	REG_UPDATE(HUBP_3DLUT_ADDRESS_HIGH,
+		HUBP_3DLUT_ADDRESS_HIGH, cfg->address.lut3d.addr.high_part);
+	REG_UPDATE(HUBP_3DLUT_ADDRESS_LOW,
+		HUBP_3DLUT_ADDRESS_LOW, cfg->address.lut3d.addr.low_part);
+
+	//cross bar
+	REG_UPDATE_8(HUBP_3DLUT_CONTROL,
+		HUBP_3DLUT_MPC_WIDTH, mpc_width,
+		HUBP_3DLUT_WIDTH, width,
+		HUBP_3DLUT_CROSSBAR_SELECT_CR_R, cfg->crossbar_bit_slice_cr_r,
+		HUBP_3DLUT_CROSSBAR_SELECT_Y_G, cfg->crossbar_bit_slice_y_g,
+		HUBP_3DLUT_CROSSBAR_SELECT_CB_B, cfg->crossbar_bit_slice_cb_b,
+		HUBP_3DLUT_ADDRESSING_MODE, cfg->addr_mode,
+		HUBP_3DLUT_TMZ, cfg->protection_bits,
+		HUBP_3DLUT_ENABLE, cfg->enabled ? 1 : 0);
+}
+
 void hubp401_update_mall_sel(struct hubp *hubp, uint32_t mall_sel, bool c_cursor)
 {
 	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
@@ -1033,6 +1070,7 @@ static struct hubp_funcs dcn401_hubp_funcs = {
 	.hubp_program_3dlut_fl_crossbar = hubp401_program_3dlut_fl_crossbar,
 	.hubp_get_3dlut_fl_done = hubp401_get_3dlut_fl_done,
 	.hubp_clear_tiling = hubp401_clear_tiling,
+	.hubp_program_3dlut_fl_config = hubp401_program_3dlut_fl_config,
 };
 
 bool hubp401_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.h b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.h
index 608e6153fa68..887b479ed1d7 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.h
@@ -349,6 +349,10 @@ void hubp401_program_3dlut_fl_format(struct hubp *hubp, enum hubp_3dlut_fl_forma
 
 void hubp401_program_3dlut_fl_mode(struct hubp *hubp, enum hubp_3dlut_fl_mode mode);
 
+void hubp401_program_3dlut_fl_config(
+	struct hubp *hubp,
+	struct hubp_fl_3dlut_config *cfg);
+
 void hubp401_clear_tiling(struct hubp *hubp);
 
 void hubp401_vready_at_or_After_vsync(struct hubp *hubp,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index 39910f73ecd0..79c9bea78c47 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -328,19 +328,25 @@ static void dcn10_log_hubp_states(struct dc *dc, void *log_ctx)
 	}
 
 	DTN_INFO("\n=======HUBP FL======\n");
-	DTN_INFO(
-		"HUBP FL:  Enabled  Done  adr_mode  width  tmz  xbar_sel_R  xbar_sel_G  xbar_sel_B  adr_hi  adr_low  REFCYC  Bias   Scale       Mode      Format\n");
+	char pLabels[18][50] = {
+		"inst", "Enabled ", "Done ", "adr_mode ", "width ", "mpc_width ",
+		"tmz", "xbar_sel_R", "xbar_sel_G", "xbar_sel_B", "adr_hi ",
+		"adr_low", "REFCYC", "Bias", "Scale", "Mode",
+		"Format", "prefetch"};
+
 	for (i = 0; i < pool->pipe_count; i++) {
 		struct dcn_hubp_state *s = &(TO_DCN10_HUBP(pool->hubps[i])->state);
 		struct dcn_fl_regs_st *fl_regs = &s->fl_regs;
+		struct _vcs_dpi_display_dlg_regs_st *dlg_regs = &s->dlg_attr;
 
 		if (!s->blank_en) {
-			DTN_INFO("[%2d]:  %5xh  %6xh  %5d  %6d  %8xh  %2xh  %6xh  %6d  %8d  %8d  %7d  %8xh %5x %5x %5x",
+			uint32_t values[] = {
 					pool->hubps[i]->inst,
 					fl_regs->lut_enable,
 					fl_regs->lut_done,
 					fl_regs->lut_addr_mode,
 					fl_regs->lut_width,
+					fl_regs->lut_mpc_width,
 					fl_regs->lut_tmz,
 					fl_regs->lut_crossbar_sel_r,
 					fl_regs->lut_crossbar_sel_g,
@@ -351,8 +357,13 @@ static void dcn10_log_hubp_states(struct dc *dc, void *log_ctx)
 					fl_regs->lut_fl_bias,
 					fl_regs->lut_fl_scale,
 					fl_regs->lut_fl_mode,
-					fl_regs->lut_fl_format);
-			DTN_INFO("\n");
+					fl_regs->lut_fl_format,
+					dlg_regs->dst_y_prefetch};
+
+			int num_elements = 18;
+
+			for (int j = 0; j < num_elements; j++)
+				DTN_INFO("%s \t %8xh\n", pLabels[j], values[j]);
 		}
 	}
 
@@ -541,19 +552,43 @@ static void dcn10_log_color_state(struct dc *dc,
 		 dc->caps.color.mpc.ogam_ram,
 		 dc->caps.color.mpc.ocsc);
 	DTN_INFO("===== MPC RMCM 3DLUT =====\n");
-	DTN_INFO("MPCC:  SIZE  MODE  MODE_CUR  RD_SEL  30BIT_EN  WR_EN_MASK  RAM_SEL  OUT_NORM_FACTOR	FL_SEL	OUT_OFFSET	OUT_SCALE	FL_DONE	SOFT_UNDERFLOW	HARD_UNDERFLOW MEM_PWR_ST	FORCE	DIS	MODE\n");
+	char pLabels[19][50] = {
+		"MPCC", "SIZE", "MODE", "MODE_CUR", "RD_SEL",
+		"30BIT_EN", "WR_EN_MASK", "RAM_SEL", "OUT_NORM_FACTOR", "FL_SEL",
+		"OUT_OFFSET", "OUT_SCALE", "FL_DONE", "SOFT_UNDERFLOW", "HARD_UNDERFLOW",
+		"MEM_PWR_ST", "FORCE", "DIS", "MODE"};
+
 	for (i = 0; i < pool->mpcc_count; i++) {
 		struct mpcc_state s = {0};
 
 		pool->mpc->funcs->read_mpcc_state(pool->mpc, i, &s);
-		if (s.opp_id != 0xf)
-			DTN_INFO("[%2d]:  %4xh  %4xh  %6xh  %4x  %4x  %4x  %4x  %4x %4xh  %4xh  %6xh  %4x  %4x  %4x  %4x  %4x  %4x  %4x\n",
-				i, s.rmcm_regs.rmcm_3dlut_size, s.rmcm_regs.rmcm_3dlut_mode, s.rmcm_regs.rmcm_3dlut_mode_cur,
-				s.rmcm_regs.rmcm_3dlut_read_sel, s.rmcm_regs.rmcm_3dlut_30bit_en, s.rmcm_regs.rmcm_3dlut_wr_en_mask,
-				s.rmcm_regs.rmcm_3dlut_ram_sel, s.rmcm_regs.rmcm_3dlut_out_norm_factor, s.rmcm_regs.rmcm_3dlut_fl_sel,
-				s.rmcm_regs.rmcm_3dlut_out_offset_r, s.rmcm_regs.rmcm_3dlut_out_scale_r, s.rmcm_regs.rmcm_3dlut_fl_done,
-				s.rmcm_regs.rmcm_3dlut_fl_soft_underflow, s.rmcm_regs.rmcm_3dlut_fl_hard_underflow, s.rmcm_regs.rmcm_3dlut_mem_pwr_state,
-				s.rmcm_regs.rmcm_3dlut_mem_pwr_force, s.rmcm_regs.rmcm_3dlut_mem_pwr_dis, s.rmcm_regs.rmcm_3dlut_mem_pwr_mode);
+		if (s.opp_id != 0xf) {
+			uint32_t values[] = {
+				i,
+				s.rmcm_regs.rmcm_3dlut_size,
+				s.rmcm_regs.rmcm_3dlut_mode,
+				s.rmcm_regs.rmcm_3dlut_mode_cur,
+				s.rmcm_regs.rmcm_3dlut_read_sel,
+				s.rmcm_regs.rmcm_3dlut_30bit_en,
+				s.rmcm_regs.rmcm_3dlut_wr_en_mask,
+				s.rmcm_regs.rmcm_3dlut_ram_sel,
+				s.rmcm_regs.rmcm_3dlut_out_norm_factor,
+				s.rmcm_regs.rmcm_3dlut_fl_sel,
+				s.rmcm_regs.rmcm_3dlut_out_offset_r,
+				s.rmcm_regs.rmcm_3dlut_out_scale_r,
+				s.rmcm_regs.rmcm_3dlut_fl_done,
+				s.rmcm_regs.rmcm_3dlut_fl_soft_underflow,
+				s.rmcm_regs.rmcm_3dlut_fl_hard_underflow,
+				s.rmcm_regs.rmcm_3dlut_mem_pwr_state,
+				s.rmcm_regs.rmcm_3dlut_mem_pwr_force,
+				s.rmcm_regs.rmcm_3dlut_mem_pwr_dis,
+				s.rmcm_regs.rmcm_3dlut_mem_pwr_mode};
+
+			int num_elements = 19;
+
+			for (int j = 0; j < num_elements; j++)
+				DTN_INFO("%s \t %8xh\n", pLabels[j], values[j]);
+		}
 	}
 	DTN_INFO("\n");
 	DTN_INFO("===== MPC RMCM Shaper =====\n");
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h b/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
index cee29e89ec5c..198a28bd8e28 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
@@ -89,7 +89,7 @@ enum hubp_3dlut_fl_addressing_mode {
 enum hubp_3dlut_fl_width {
 	hubp_3dlut_fl_width_17 = 17,
 	hubp_3dlut_fl_width_33 = 33,
-	hubp_3dlut_fl_width_transformed = 4916
+	hubp_3dlut_fl_width_transformed    = 4916, //mpc default
 };
 
 enum hubp_3dlut_fl_crossbar_bit_slice {
@@ -99,6 +99,22 @@ enum hubp_3dlut_fl_crossbar_bit_slice {
 	hubp_3dlut_fl_crossbar_bit_slice_48_63 = 3
 };
 
+struct hubp_fl_3dlut_config {
+	bool enabled;
+	enum hubp_3dlut_fl_width width;
+	enum hubp_3dlut_fl_mode mode;
+	enum hubp_3dlut_fl_format format;
+	uint16_t bias;
+	uint16_t scale;
+	struct dc_plane_address address;
+	enum hubp_3dlut_fl_addressing_mode addr_mode;
+	enum dc_cm2_gpu_mem_layout layout;
+	uint8_t protection_bits;
+	enum hubp_3dlut_fl_crossbar_bit_slice crossbar_bit_slice_y_g;
+	enum hubp_3dlut_fl_crossbar_bit_slice crossbar_bit_slice_cb_b;
+	enum hubp_3dlut_fl_crossbar_bit_slice crossbar_bit_slice_cr_r;
+};
+
 struct hubp {
 	const struct hubp_funcs *funcs;
 	struct dc_context *ctx;
@@ -288,6 +304,7 @@ struct hubp_funcs {
 			enum hubp_3dlut_fl_crossbar_bit_slice bit_slice_cb_b,
 			enum hubp_3dlut_fl_crossbar_bit_slice bit_slice_cr_r);
 	int (*hubp_get_3dlut_fl_done)(struct hubp *hubp);
+	void (*hubp_program_3dlut_fl_config)(struct hubp *hubp, struct hubp_fl_3dlut_config *cfg);
 	void (*hubp_clear_tiling)(struct hubp *hubp);
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h b/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
index 7641439f6ca0..14f0304e3eb9 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
@@ -115,6 +115,16 @@ enum MCM_LUT_ID {
 	MCM_LUT_SHAPER
 };
 
+struct mpc_fl_3dlut_config {
+	bool enabled;
+	uint16_t width;
+	bool select_lut_bank_a;
+	uint16_t bit_depth;
+	int hubp_index;
+	uint16_t bias;
+	uint16_t scale;
+};
+
 union mcm_lut_params {
 	const struct pwl_params *pwl;
 	const struct tetrahedral_params *lut3d;
@@ -1098,6 +1108,7 @@ struct mpc_funcs {
 	 * MPC RMCM new HW sequential programming functions
 	 */
 	struct {
+		void (*fl_3dlut_configure)(struct mpc *mpc, struct mpc_fl_3dlut_config *cfg, int mpcc_id);
 		void (*enable_3dlut_fl)(struct mpc *mpc, bool enable, int mpcc_id);
 		void (*update_3dlut_fast_load_select)(struct mpc *mpc, int mpcc_id, int hubp_idx);
 		void (*program_lut_read_write_control)(struct mpc *mpc, const enum MCM_LUT_ID id,
-- 
2.34.1

