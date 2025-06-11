Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB085C71147
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Jun 2025 18:41:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8834110E6E1;
	Wed, 11 Jun 2025 18:41:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nSghpuHN";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2FEC10E6E4
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Jun 2025 18:41:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NgMlWeSPti2di6pHskKDxUJIzkv9GL52SaD6qt2e3GsrOnyhbi7Ku8GyYYWWZnoNEWWeWZfy3CyekLDpzLJGfTU/0wYYQr0uVoSaQZEm0+7JLZUMAXPMguhqNlwsBcrGQDr20p0pfJ1j9ZnRRV61qGp9mhoOO8CHJu9r3LtF0oCxaa3JgmI2nqE0BV9dj1/JcHZo18E3WQ/wP2R2epRiC8BWeG2puKDcH9kMH1zaFFBmy2hBW/quxndjY543WjckHU8R2LnXAyh0TdwVauQDEK7vB76Phgy+5w7Hg90CZejVoiIWMZle/YV0AUEktQoLKSw9eQwNDIzuS0sfucx0mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fwgd6tNP0L6DbXk0kw9EIIZZZOHkJ7RA1v6lzARH6Gs=;
 b=BilAWUfam0RGytO9BOtvRw6ZKdYINKr6ZH26GRl8Ev6ttIqITk5r6avctHR+QaJK62ZdHjzXaf9ZdZ88Td2OasI+xwuWN6VUBPzLyVw0FMgPicpIQEnYuYuRuVpdOVvfnrW/4pGz4x5ANXmgsb4LjlPUIoQIU1cbFQl2RqMLFyShIgkcovyNqSX1FI7rU0kynCSm+gPtIu5PLir/URM/JprX3UxLk/Eq+orQr5Rp8FmptZDrobugFklB9gMg5pl0CpKJEyuAmaDWi5hdoobqyWrupqSxvFRx6BqgUw2YNlljxD3t2YPMdzhm6XT3W5DrgMh80j97HelduNcqjfGYxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fwgd6tNP0L6DbXk0kw9EIIZZZOHkJ7RA1v6lzARH6Gs=;
 b=nSghpuHNBytZ94gx8XoE7oS494udCYRPulUAhavvh9YdfCVNzWBulpOsDtJHEhBECuzq9iGD5u/N9Qp6dWrDZgJu9tjph6et554KJn46zsllce0UkJnVVwwnTd+2qAOZsDjcwiwN6DFPaNlPICsgJExgK+K3RtQB6jN/4QKmfe0=
Received: from BN9PR03CA0620.namprd03.prod.outlook.com (2603:10b6:408:106::25)
 by MN2PR12MB4240.namprd12.prod.outlook.com (2603:10b6:208:1d3::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Wed, 11 Jun
 2025 18:41:14 +0000
Received: from BL6PEPF0001AB77.namprd02.prod.outlook.com
 (2603:10b6:408:106:cafe::dc) by BN9PR03CA0620.outlook.office365.com
 (2603:10b6:408:106::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.29 via Frontend Transport; Wed,
 11 Jun 2025 18:41:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB77.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Wed, 11 Jun 2025 18:41:13 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Jun
 2025 13:41:12 -0500
Received: from aaurabin-z5-cachy.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 11 Jun 2025 13:41:12 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Yan Li <yan.li@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>, Aric Cyr <aric.cyr@amd.com>
Subject: [PATCH 01/10] drm/amd/display: apply two different methods to
 validate modes
Date: Wed, 11 Jun 2025 14:39:51 -0400
Message-ID: <20250611184111.517494-2-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611184111.517494-1-aurabindo.pillai@amd.com>
References: <20250611184111.517494-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB77:EE_|MN2PR12MB4240:EE_
X-MS-Office365-Filtering-Correlation-Id: d855780c-6506-414b-8f3f-08dda9178afa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Vxkkcb9SjwGOjlg7U/JMwoA9xhEhdOxyMWFqHQQXNLMrYaPQNJFOL9p8d8Bz?=
 =?us-ascii?Q?mdRIEMSxeG5/KwfOT3pEg86y8S61c5n42QCnNmSuDr5Y9xrgVLTFPKbiYov3?=
 =?us-ascii?Q?ezY2X+yfZ4JOFx1HEHtLscjS8Y4bH3qHpBRJh/hRC7wNvpB4ZH59guXhX/KE?=
 =?us-ascii?Q?80ypi6kk33d/gBjwb//vILWNrtarwVjOUernpCHOd+kWb7t01y3KiP9qc4P8?=
 =?us-ascii?Q?h2vezYJLHlM0zHSqy9K6gnE44YVkfxLVRY2y3tkZD7pi9dFCO3o3yvPBNaOG?=
 =?us-ascii?Q?VNG7q/VFxtM0m171PuHBKtM5uMbaAKll7/4ApGpNGnh1hC6CBPDWlhyNycUI?=
 =?us-ascii?Q?41Kyd9joet7iQLk+pntBK0AEKhS5ifo3VXzyilUYWWFcGAehY9CoIyl5Hn33?=
 =?us-ascii?Q?Pzul73Y6yr/TMZbzVtPYXsqc7AC/vFrzpGo+MMhbj7f+AfAP4Dfx6dAcQDdo?=
 =?us-ascii?Q?LTqAjWjE1uCsqnds973tuRTqmf1MykY4B1kkfHbZpFOpxthlEQHXxg25fGcz?=
 =?us-ascii?Q?clRqc/94WVKJ+ySkI6q5wz0wD3mfieOy1dx9mXtXdYoxId//L53kzeJiz/Ps?=
 =?us-ascii?Q?rh5IVaoazm8d6TuvWP4w+hjgIrGqCEkRMLEu9OZP9xABYq2FPrt7TRb5fsJk?=
 =?us-ascii?Q?hhoQVQYf16IzqpYxY6hEzITIFm9Xk4KcIMRrFtfVSXcN26FeXLaU8x6A5Z/X?=
 =?us-ascii?Q?4qevlK9plDamBMSIBYb9ungMIqarMfxm9drgfRyoYfI33DWlb5V/td/caUZX?=
 =?us-ascii?Q?CAgnlen69fEzAAALi3mD8zHXP8tsWN0nuKRE2DLrLFk8WShu7E5WrO5Wqh8R?=
 =?us-ascii?Q?hXiuY7IhIya6nhADJjgV1WDsfx5ihx1txEHmPgsU9RjqWXl3EJ67MBCg2VYi?=
 =?us-ascii?Q?QsQBdSl2XYlHKk22VUuqG++cra6kR43RJoLqzYCcZ9OeP+gFgmTcL1JYUN0d?=
 =?us-ascii?Q?sGsRCGBueyIeaaKm9Kh02TT+0AcEzLFpgYmFAkNm2m8p940GGRPchfC+1OjH?=
 =?us-ascii?Q?CvDhP9QEWuq+A6JRR5nvWtWrkbpGdqbIBnr47b6CpIKUubdqpfUNpG8CN72E?=
 =?us-ascii?Q?XH6IFtSkZ/xhPDyp6vbEuW+ShbgC5+1e6zjQG0iCmbpItHjS9MNgL4lAk/t1?=
 =?us-ascii?Q?7wrcn107tM/amr/kg52NQYuA9+loHk6+UHKFr1jXsnBuEbTN6sk/7zMk1kPS?=
 =?us-ascii?Q?OwzqwHztzDnBSRKQryZlTgRQq4pUFbIp8lNd4PQ+9RQr7LsndGL5J404dXMi?=
 =?us-ascii?Q?VCWF6oxmNk3P2G57WYGGWmHeV9jOd/IKVo9l0Ejo6CGEqjxq7v3cUI1JJaih?=
 =?us-ascii?Q?0TKoJsgrkE5xXdaQePiAk0RZrsAxptyPLVPZVsHPLHAS5vOf9pThbGE+LmEe?=
 =?us-ascii?Q?V9QM1NDKxCL/pNDT9QRruK2RnVb6GX4PKI3r7xS7pRd4lZGRXA+TnnBCKYl8?=
 =?us-ascii?Q?TKM8X73Db7lX9NlHU4Xvg6Idm45BAkWJIuRI4sexCqaMgiaFF3REylhdVPn7?=
 =?us-ascii?Q?sAVVljm/tWdttggL9Cw51H/6ONGYlipK3Mzi?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 18:41:13.7065 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d855780c-6506-414b-8f3f-08dda9178afa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB77.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4240
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

From: Yan Li <yan.li@amd.com>

[Why]
In DML2, the current method to determine a
mode is supported involves checking the
voltage levels sequentially from the lowest,
until one is found that can support the
mode. It causes cursor lag due to low
performance.

[How]
We apply two methods for mode validation.
1) DC_VALIDATE_MODE_ONLY: only the
maximum voltage level is checked to
determine whether the mode is supported, which
improves performance and eliminate cursor lag.

2) DC_VALIDATE_MODE_AND_STATE_INDEX: when
the optimal voltage level is required, check
the voltage level from the lowest until
a suitable one is found found and returns
its index.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Yan Li <yan.li@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../amd/display/dc/dml2/display_mode_core.c   |  2 +-
 .../dc/dml2/display_mode_core_structs.h       |  1 +
 .../drm/amd/display/dc/dml2/dml2_wrapper.c    | 64 ++++++++++++-------
 3 files changed, 42 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
index 7ae9c0ba0c9e..715f9019a33e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
@@ -10189,7 +10189,7 @@ dml_uint_t dml_mode_support_ex(struct dml_mode_support_ex_params_st *in_out_para
 	result = mode_support_pwr_states(&in_out_params->out_lowest_state_idx,
 		in_out_params->mode_lib,
 		in_out_params->in_display_cfg,
-		0,
+		in_out_params->in_start_state_idx,
 		in_out_params->mode_lib->states.num_states - 1);
 
 	if (result)
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core_structs.h b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core_structs.h
index 0670e4dc4fd9..dbeb08466092 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core_structs.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core_structs.h
@@ -1917,6 +1917,7 @@ struct display_mode_lib_st {
 struct dml_mode_support_ex_params_st {
 	struct display_mode_lib_st *mode_lib;
 	const struct dml_display_cfg_st *in_display_cfg;
+	dml_uint_t in_start_state_idx;
 	dml_uint_t out_lowest_state_idx;
 	struct dml_mode_support_info_st *out_evaluation_info;
 };
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
index b8c0ece7bb22..6c7e8aa85e7b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
@@ -93,12 +93,17 @@ static void map_hw_resources(struct dml2_context *dml2,
 
 static unsigned int pack_and_call_dml_mode_support_ex(struct dml2_context *dml2,
 	const struct dml_display_cfg_st *display_cfg,
-	struct dml_mode_support_info_st *evaluation_info)
+	struct dml_mode_support_info_st *evaluation_info,
+	enum dc_validate_mode validate_mode)
 {
 	struct dml2_wrapper_scratch *s = &dml2->v20.scratch;
 
 	s->mode_support_params.mode_lib = &dml2->v20.dml_core_ctx;
 	s->mode_support_params.in_display_cfg = display_cfg;
+	if (validate_mode == DC_VALIDATE_MODE_ONLY)
+		s->mode_support_params.in_start_state_idx = dml2->v20.dml_core_ctx.states.num_states - 1;
+	else
+		s->mode_support_params.in_start_state_idx = 0;
 	s->mode_support_params.out_evaluation_info = evaluation_info;
 
 	memset(evaluation_info, 0, sizeof(struct dml_mode_support_info_st));
@@ -224,7 +229,8 @@ static bool optimize_configuration(struct dml2_context *dml2, struct dml2_wrappe
 	return optimization_done;
 }
 
-static int calculate_lowest_supported_state_for_temp_read(struct dml2_context *dml2, struct dc_state *display_state)
+static int calculate_lowest_supported_state_for_temp_read(struct dml2_context *dml2, struct dc_state *display_state,
+		enum dc_validate_mode validate_mode)
 {
 	struct dml2_calculate_lowest_supported_state_for_temp_read_scratch *s = &dml2->v20.scratch.dml2_calculate_lowest_supported_state_for_temp_read_scratch;
 	struct dml2_wrapper_scratch *s_global = &dml2->v20.scratch;
@@ -266,7 +272,8 @@ static int calculate_lowest_supported_state_for_temp_read(struct dml2_context *d
 			dml2->v20.dml_core_ctx.states.state_array[j].dram_clock_change_latency_us = s_global->dummy_pstate_table[i].dummy_pstate_latency_us;
 		}
 
-		dml_result = pack_and_call_dml_mode_support_ex(dml2, &s->cur_display_config, &s->evaluation_info);
+		dml_result = pack_and_call_dml_mode_support_ex(dml2, &s->cur_display_config, &s->evaluation_info,
+						validate_mode);
 
 		if (dml_result && s->evaluation_info.DRAMClockChangeSupport[0] == dml_dram_clock_change_vactive) {
 			map_hw_resources(dml2, &s->cur_display_config, &s->evaluation_info);
@@ -331,7 +338,8 @@ static bool does_configuration_meet_sw_policies(struct dml2_context *ctx, const
 }
 
 static bool dml_mode_support_wrapper(struct dml2_context *dml2,
-		struct dc_state *display_state)
+		struct dc_state *display_state,
+		enum dc_validate_mode validate_mode)
 {
 	struct dml2_wrapper_scratch *s = &dml2->v20.scratch;
 	unsigned int result = 0, i;
@@ -367,7 +375,8 @@ static bool dml_mode_support_wrapper(struct dml2_context *dml2,
 
 	result = pack_and_call_dml_mode_support_ex(dml2,
 		&s->cur_display_config,
-		&s->mode_support_info);
+		&s->mode_support_info,
+		validate_mode);
 
 	if (result)
 		result = does_configuration_meet_sw_policies(dml2, &s->cur_display_config, &s->mode_support_info);
@@ -388,7 +397,8 @@ static bool dml_mode_support_wrapper(struct dml2_context *dml2,
 			dml2->v20.dml_core_ctx.policy = s->new_policy;
 			optimized_result = pack_and_call_dml_mode_support_ex(dml2,
 				&s->new_display_config,
-				&s->mode_support_info);
+				&s->mode_support_info,
+				validate_mode);
 
 			if (optimized_result)
 				optimized_result = does_configuration_meet_sw_policies(dml2, &s->new_display_config, &s->mode_support_info);
@@ -407,7 +417,8 @@ static bool dml_mode_support_wrapper(struct dml2_context *dml2,
 		if (!optimized_result) {
 			result = pack_and_call_dml_mode_support_ex(dml2,
 				&s->cur_display_config,
-				&s->mode_support_info);
+				&s->mode_support_info,
+				validate_mode);
 		}
 	}
 
@@ -432,7 +443,8 @@ static int find_drr_eligible_stream(struct dc_state *display_state)
 	return -1;
 }
 
-static bool optimize_pstate_with_svp_and_drr(struct dml2_context *dml2, struct dc_state *display_state)
+static bool optimize_pstate_with_svp_and_drr(struct dml2_context *dml2, struct dc_state *display_state,
+		enum dc_validate_mode validate_mode)
 {
 	struct dml2_wrapper_scratch *s = &dml2->v20.scratch;
 	bool pstate_optimization_done = false;
@@ -444,7 +456,7 @@ static bool optimize_pstate_with_svp_and_drr(struct dml2_context *dml2, struct d
 	display_state->bw_ctx.bw.dcn.clk.fw_based_mclk_switching = false;
 	display_state->bw_ctx.bw.dcn.legacy_svp_drr_stream_index_valid = false;
 
-	result = dml_mode_support_wrapper(dml2, display_state);
+	result = dml_mode_support_wrapper(dml2, display_state, validate_mode);
 
 	if (!result) {
 		pstate_optimization_done = true;
@@ -456,7 +468,7 @@ static bool optimize_pstate_with_svp_and_drr(struct dml2_context *dml2, struct d
 	if (display_state->stream_count == 1 && dml2->config.callbacks.can_support_mclk_switch_using_fw_based_vblank_stretch(dml2->config.callbacks.dc, display_state)) {
 			display_state->bw_ctx.bw.dcn.clk.fw_based_mclk_switching = true;
 
-			result = dml_mode_support_wrapper(dml2, display_state);
+			result = dml_mode_support_wrapper(dml2, display_state, validate_mode);
 	} else {
 		non_svp_streams = display_state->stream_count;
 
@@ -471,7 +483,7 @@ static bool optimize_pstate_with_svp_and_drr(struct dml2_context *dml2, struct d
 
 
 			if (result) {
-				result = dml_mode_support_wrapper(dml2, display_state);
+				result = dml_mode_support_wrapper(dml2, display_state, validate_mode);
 			} else {
 				pstate_optimization_done = true;
 			}
@@ -496,7 +508,8 @@ static bool optimize_pstate_with_svp_and_drr(struct dml2_context *dml2, struct d
 						if (dml2_svp_drr_schedulable(dml2, display_state, &display_state->streams[drr_display_index]->timing)) {
 							display_state->bw_ctx.bw.dcn.legacy_svp_drr_stream_index_valid = true;
 							display_state->bw_ctx.bw.dcn.legacy_svp_drr_stream_index = drr_display_index;
-							result = dml_mode_support_wrapper(dml2, display_state);
+							result = dml_mode_support_wrapper(dml2, display_state,
+										validate_mode);
 						}
 
 						if (result && s->mode_support_info.DRAMClockChangeSupport[0] != dml_dram_clock_change_unsupported) {
@@ -522,13 +535,13 @@ static bool optimize_pstate_with_svp_and_drr(struct dml2_context *dml2, struct d
 		dml2_svp_remove_all_phantom_pipes(dml2, display_state);
 		display_state->bw_ctx.bw.dcn.clk.fw_based_mclk_switching = false;
 		display_state->bw_ctx.bw.dcn.legacy_svp_drr_stream_index_valid = false;
-		result = dml_mode_support_wrapper(dml2, display_state);
+		result = dml_mode_support_wrapper(dml2, display_state, validate_mode);
 	}
 
 	return result;
 }
 
-static bool call_dml_mode_support_and_programming(struct dc_state *context)
+static bool call_dml_mode_support_and_programming(struct dc_state *context, enum dc_validate_mode validate_mode)
 {
 	unsigned int result = 0;
 	unsigned int min_state = 0;
@@ -542,15 +555,16 @@ static bool call_dml_mode_support_and_programming(struct dc_state *context)
 	struct dml2_wrapper_scratch *s = &dml2->v20.scratch;
 
 	if (!context->streams[0]->sink->link->dc->caps.is_apu) {
-		min_state_for_g6_temp_read = calculate_lowest_supported_state_for_temp_read(dml2, context);
+		min_state_for_g6_temp_read = calculate_lowest_supported_state_for_temp_read(dml2, context,
+										validate_mode);
 
 		ASSERT(min_state_for_g6_temp_read >= 0);
 	}
 
 	if (!dml2->config.use_native_pstate_optimization) {
-		result = optimize_pstate_with_svp_and_drr(dml2, context);
+		result = optimize_pstate_with_svp_and_drr(dml2, context, validate_mode);
 	} else {
-		result = dml_mode_support_wrapper(dml2, context);
+		result = dml_mode_support_wrapper(dml2, context, validate_mode);
 	}
 
 	/* Upon trying to sett certain frequencies in FRL, min_state_for_g6_temp_read is reported as -1. This leads to an invalid value of min_state causing crashes later on.
@@ -573,7 +587,8 @@ static bool call_dml_mode_support_and_programming(struct dc_state *context)
 	return result;
 }
 
-static bool dml2_validate_and_build_resource(const struct dc *in_dc, struct dc_state *context)
+static bool dml2_validate_and_build_resource(const struct dc *in_dc, struct dc_state *context,
+		enum dc_validate_mode validate_mode)
 {
 	struct dml2_context *dml2 = context->bw_ctx.dml2;
 	struct dml2_wrapper_scratch *s = &dml2->v20.scratch;
@@ -609,7 +624,7 @@ static bool dml2_validate_and_build_resource(const struct dc *in_dc, struct dc_s
 
 	copy_dummy_pstate_table(s->dummy_pstate_table, in_dc->clk_mgr->bw_params->dummy_pstate_table, 4);
 
-	result = call_dml_mode_support_and_programming(context);
+	result = call_dml_mode_support_and_programming(context, validate_mode);
 	/* Call map dc pipes to map the pipes based on the DML output. For correctly determining if recalculation
 	 * is required or not, the resource context needs to correctly reflect the number of active pipes. We would
 	 * only know the correct number if active pipes after dml2_map_dc_pipes is called.
@@ -626,7 +641,7 @@ static bool dml2_validate_and_build_resource(const struct dc *in_dc, struct dc_s
 		need_recalculation = dml2_verify_det_buffer_configuration(dml2, context, &dml2->det_helper_scratch);
 		if (need_recalculation) {
 			/* Engage the DML again if recalculation is required. */
-			call_dml_mode_support_and_programming(context);
+			call_dml_mode_support_and_programming(context, validate_mode);
 			if (!dml2->config.skip_hw_state_mapping) {
 				dml2_map_dc_pipes(dml2, context, &s->cur_display_config, &s->dml_to_dc_pipe_mapping, in_dc->current_state);
 			}
@@ -682,7 +697,7 @@ static bool dml2_validate_and_build_resource(const struct dc *in_dc, struct dc_s
 	return result;
 }
 
-static bool dml2_validate_only(struct dc_state *context)
+static bool dml2_validate_only(struct dc_state *context, enum dc_validate_mode validate_mode)
 {
 	struct dml2_context *dml2;
 	unsigned int result = 0;
@@ -706,7 +721,8 @@ static bool dml2_validate_only(struct dc_state *context)
 
 	result = pack_and_call_dml_mode_support_ex(dml2,
 		&dml2->v20.scratch.cur_display_config,
-		&dml2->v20.scratch.mode_support_info);
+		&dml2->v20.scratch.mode_support_info,
+		validate_mode);
 
 	if (result)
 		result = does_configuration_meet_sw_policies(dml2, &dml2->v20.scratch.cur_display_config, &dml2->v20.scratch.mode_support_info);
@@ -740,9 +756,9 @@ bool dml2_validate(const struct dc *in_dc, struct dc_state *context, struct dml2
 
 	/* Use dml_validate_only for DC_VALIDATE_MODE_ONLY and DC_VALIDATE_MODE_AND_STATE_INDEX path */
 	if (validate_mode != DC_VALIDATE_MODE_AND_PROGRAMMING)
-		out = dml2_validate_only(context);
+		out = dml2_validate_only(context, validate_mode);
 	else
-		out = dml2_validate_and_build_resource(in_dc, context);
+		out = dml2_validate_and_build_resource(in_dc, context, validate_mode);
 
 	DC_FP_END();
 
-- 
2.49.0

