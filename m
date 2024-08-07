Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7CF2C3DA7F
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Aug 2024 07:56:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7074F10E432;
	Wed,  7 Aug 2024 07:56:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PH1p9t1e";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D635710E43C
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Aug 2024 07:56:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rGz2PwG7yXMIM2NT3Zxn+LufG0DF4vhTaej6hsVF7e9WvkAL3r1z/kwd+LzC/NsCVMHZeByCBDCS5w6aISA1ikLGiPKAOpIvgosS7FYO5Kp9R0nLB85rSdwJwZjLQm7ovhVFvBocLvbUJcV2qyC291UdCsDEfTmLvwZ6SfDo9hkM+rg/YdCyqtgMPzOFC3vfkr/1+VadCnO3srsb+najc0mOkeDMlPX43vur+6OtN6eA+GrfO9fJItOn8hPn1sH6iZtQaMAvDDMRlSdWAumvKV9pxbnHU6K514o0yL44zNZ8Pm+IiqwXhUYlnRKb78PkayOdpVjsQ4mZvKMz1RmLvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vL6LmSIiCN0U7nvC6Q+JkzmpjW++z1lV/PzmAkQW3e0=;
 b=MMB7UY0+JdAECnvdqQLEVslzZ3fodLp6779+zGk9e7Ijski6oN/DEdujRsCiFz1wTupLo03Kg/vq1xIZeAxcJRKNwwzKBUULVtJKcgm6V/HWysunTZLZCpg72LAowj147oJf6u7ilw8WqqXEBiVDL5iDFZu/htaIVrcCk05+gulZeinbOFAzgvEmRB6oCnrp8QtaMuQxCO+A/mH908XAz/PkhwSYHI9+iZCyZBCFOaKxxE5AM5Y13Boo5EozUjqgNBnfBCUi/Dmu1DI8CSHX5vKtSWISldKIgLbWdS2lFk0cxuu2ibm3XuvILKweWyfOtCbL9QvuMPoTJFv+Fpg3BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vL6LmSIiCN0U7nvC6Q+JkzmpjW++z1lV/PzmAkQW3e0=;
 b=PH1p9t1e9HJgZfhjUfE9ikd4NQ3nMf+V5Soe4S0Zqa2zAdo6/cOwauZf4AsPn94zJBg7DrAFQ9xAkTh/raU3yH+pphEiCCWq9KJmHmjjhhoF4/0a+pAugFAcGbSad2T3/b2snvv33n8Jh7ytsgkfMcu+3nz+MVSqJw+6AfIhUAI=
Received: from BN9PR03CA0498.namprd03.prod.outlook.com (2603:10b6:408:130::23)
 by DS7PR12MB8324.namprd12.prod.outlook.com (2603:10b6:8:ec::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.13; Wed, 7 Aug 2024 07:55:59 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:408:130:cafe::9) by BN9PR03CA0498.outlook.office365.com
 (2603:10b6:408:130::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.29 via Frontend
 Transport; Wed, 7 Aug 2024 07:55:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Wed, 7 Aug 2024 07:55:59 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Aug
 2024 02:55:58 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 7 Aug 2024 02:55:55 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>, Austin Zheng <austin.zheng@amd.com>
Subject: [PATCH 02/24] drm/amd/display: apply vmin optimization even if it
 doesn't reach vmin level
Date: Wed, 7 Aug 2024 15:55:24 +0800
Message-ID: <20240807075546.831208-3-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807075546.831208-1-chiahsuan.chung@amd.com>
References: <20240807075546.831208-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|DS7PR12MB8324:EE_
X-MS-Office365-Filtering-Correlation-Id: ede73ae3-6f0e-4a15-10da-08dcb6b66032
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JAVLimGmy+x4kA9g6jA6UdZDlZEv7ALKjxxkphuPRWECH9zTr/IJTHhbIjpH?=
 =?us-ascii?Q?5JdY44M0amKwnCDZ49mzged8uaV4PNDXxzHTRZdtw1m1bsB4n7PN3cjqU2wo?=
 =?us-ascii?Q?UigY6dP476LgXWTOT7lpOCd8QyW6B06ptcXpQ6VYoKT7QlQCJQHqyqPqwUCj?=
 =?us-ascii?Q?fBF2WjMj5nRUjrZYBKJxaaJZqRYQS2+9pgNw47b3NDr9jb6RtjEhqZgsnzgd?=
 =?us-ascii?Q?gD2o8LrAZLEYb1Sz2qXjwT7jFmwMEvel/EpvCJEyaFUZiOTZIqKQy417o/Vh?=
 =?us-ascii?Q?L/4Tk2faZtAcftajB4ODv68zO1naDPnF3vppIl+KSOyYROfXt/fPdRo0dLoe?=
 =?us-ascii?Q?pjuSYwzjMkxGQRHGAQcuVU9dHEBAZXk2SnkqMV/3oUERfSU5OsBCihqzIlkp?=
 =?us-ascii?Q?OeNzSKgaIdvRGOjQudO80I8Z4XbJSUgxtyhGgEx3fWBjwffZasn8ugsXrBUc?=
 =?us-ascii?Q?b/8Rj414FTVi/0BpBIsTCfePl+IL5w4MI3NRdFmGx3tKjfCmDnwAsrAC4Z9M?=
 =?us-ascii?Q?r5Zn8/1OMFfu5vTwzx9E9Ws9D8qyVvyn72ua1+Lqbe4FUht0lIemSl4kBoPC?=
 =?us-ascii?Q?RvsgkSwlakDG3SFQSi2htPToefIc+qZhhnGMUokm6sF8e+CvmL+cCZdbq0rw?=
 =?us-ascii?Q?yqB0mJbYmMIJqeCVYBUUc4WaN+NyrWSzqGDQm/IO7z1SkWmtTg1Q5Q88l7hN?=
 =?us-ascii?Q?nTq8toKxVqSjOVXNTJ+vkG4V1k5+EywlKa/g/SbHJtHQccPB1M1ik7eDP84o?=
 =?us-ascii?Q?HXk+QKQYJPbR5/pivJViDm1U0eD1lplB8CRd01cxfdC8vE7apRIDLYKaLOzT?=
 =?us-ascii?Q?0BxCvRSqNe1Z10M6+VB/xI/+t+9+SMX2HarYS0RT7z6TbWaWs2Hng9F6umVS?=
 =?us-ascii?Q?iYN2MirXMfr40c1HTEEz4AiKEDyt06t8EYDxdN249c3r1lTxqqM4PZJgUVxu?=
 =?us-ascii?Q?4TYRQtBqnAb6tUpnRV/LIbZhFriliAl6ExLU/bmkRRDAWjpkR/NIsTTdV6S5?=
 =?us-ascii?Q?W/75amTRHE5nEQR6sIwQjDAt+q+qk4v6p9Zz7TUuqwU2+u1xCIWyIl3C6XsO?=
 =?us-ascii?Q?NKNNmzjNqkGLq5epngwScXfC+U+3DPBbD/q2ZSXMwgFmuVzWjxQO5iUVa/QU?=
 =?us-ascii?Q?FWW+rRDmGoDYI2q0DG/3ozWK24l/cAfCaMlw9lXoEPJWUrM1Xk+NzpLLc9vz?=
 =?us-ascii?Q?77HvMRXvANEJX5cYH5VqrriCdeESYqLFWg3D6tSF4SfiM9Vc+ytstvn1bTtg?=
 =?us-ascii?Q?aJlvt3x8hl+h10+3x5YbQMOx/GTavOi+Q2BTA+jTaMI850CP0W/O9LvqDcHA?=
 =?us-ascii?Q?F8FjDJGBct1P/Q/8yVJuIY6zl+/4iFPkyfON+Ma0Bzlrr15jupUkvKdmD96c?=
 =?us-ascii?Q?j0aCuzRqZRqjVRHrtd2wK2s+AK9XkCBvfUmPUDxyqtnyO98hcWg/wmUBZqim?=
 =?us-ascii?Q?tUcPCaz77ixA02kJNJwEAceUgTtgKUfi?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 07:55:59.3183 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ede73ae3-6f0e-4a15-10da-08dcb6b66032
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8324
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

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
Based on power measurement result, in most cases when display clock
is higher than Vmin display clock, lowering display clock using
dynamic ODM will improve overall power consumption by 0 to 4 watts
even if we can't reach Vmin.

[how]
Allow vmin optimization applied even if dispclk can't reach Vmin.

Reviewed-by: Austin Zheng <austin.zheng@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c  | 14 +++++++++-----
 .../display/dc/dml2/dml21/src/dml2_top/dml_top.c   | 13 +++++++++++--
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
index 06e786995390..68b333b68933 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
@@ -717,6 +717,8 @@ bool pmo_dcn4_fams2_init_for_vmin(struct dml2_pmo_init_for_vmin_in_out *in_out)
 			&in_out->base_display_config->display_config;
 	const struct dml2_core_mode_support_result *mode_support_result =
 			&in_out->base_display_config->mode_support_result;
+	struct dml2_optimization_stage4_state *state =
+			&in_out->base_display_config->stage4;
 
 	if (in_out->instance->options->disable_dyn_odm ||
 			(in_out->instance->options->disable_dyn_odm_for_multi_stream && display_config->num_streams > 1))
@@ -737,28 +739,30 @@ bool pmo_dcn4_fams2_init_for_vmin(struct dml2_pmo_init_for_vmin_in_out *in_out)
 		 */
 		if (mode_support_result->cfg_support_info.plane_support_info[i].dpps_used > 1 &&
 				mode_support_result->cfg_support_info.stream_support_info[display_config->plane_descriptors[i].stream_index].odms_used == 1)
-			in_out->base_display_config->stage4.unoptimizable_streams[display_config->plane_descriptors[i].stream_index] = true;
+			state->unoptimizable_streams[display_config->plane_descriptors[i].stream_index] = true;
 
 	for (i = 0; i < display_config->num_streams; i++) {
 		if (display_config->stream_descriptors[i].overrides.disable_dynamic_odm)
-			in_out->base_display_config->stage4.unoptimizable_streams[i] = true;
+			state->unoptimizable_streams[i] = true;
 		else if (in_out->base_display_config->stage3.stream_svp_meta[i].valid &&
 				in_out->instance->options->disable_dyn_odm_for_stream_with_svp)
-			in_out->base_display_config->stage4.unoptimizable_streams[i] = true;
+			state->unoptimizable_streams[i] = true;
 		/*
 		 * ODM Combine requires horizontal timing divisible by 2 so each
 		 * ODM segment has the same size.
 		 */
 		else if (!is_h_timing_divisible_by(&display_config->stream_descriptors[i].timing, 2))
-			in_out->base_display_config->stage4.unoptimizable_streams[i] = true;
+			state->unoptimizable_streams[i] = true;
 		/*
 		 * Our hardware support seamless ODM transitions for DP encoders
 		 * only.
 		 */
 		else if (!is_dp_encoder(display_config->stream_descriptors[i].output.output_encoder))
-			in_out->base_display_config->stage4.unoptimizable_streams[i] = true;
+			state->unoptimizable_streams[i] = true;
 	}
 
+	state->performed = true;
+
 	return true;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_top/dml_top.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_top/dml_top.c
index a9c3ed6d50ef..f9f8869cd8b8 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_top/dml_top.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_top/dml_top.c
@@ -266,9 +266,18 @@ bool dml2_build_mode_programming(struct dml2_build_mode_programming_in_out *in_o
 
 	vmin_success = dml2_top_optimization_perform_optimization_phase(&l->optimization_phase_locals, &l->vmin_phase);
 
-	if (vmin_success) {
+	if (l->optimized_display_config_with_meta.stage4.performed) {
+		/*
+		 * when performed is true, optimization has applied to
+		 * optimized_display_config_with_meta and it has passed mode
+		 * support. However it may or may not pass the test function to
+		 * reach actual Vmin. As long as voltage is optimized even if it
+		 * doesn't reach Vmin level, there is still power benefit so in
+		 * this case we will still copy this optimization into base
+		 * display config.
+		 */
 		memcpy(&l->base_display_config_with_meta, &l->optimized_display_config_with_meta, sizeof(struct display_configuation_with_meta));
-		l->base_display_config_with_meta.stage4.success = true;
+		l->base_display_config_with_meta.stage4.success = vmin_success;
 	}
 
 	/*
-- 
2.34.1

