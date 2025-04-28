Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB6EFC369DC
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Apr 2025 13:56:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80B8710E544;
	Mon, 28 Apr 2025 13:56:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="a8Oggd1B";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18B4E10E544
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Apr 2025 13:56:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hhNRtPBGBuhOHQx4P1sFCVCZf+mhVGny6Rd6Q6IClt4HROPc2t7N48Dvl8InRRVvrc/Rku5VzyfmlKi40nMq9e6i9vSaFxZZt3FLK9gArJejF0TYw2m2OYyZ0xFUflo/NnthK+TylST1+IrHs8LOUUOqsmavIbFtrzGvVOimJU5mQHc75LgXCnw1ZfyNlUyLPC7+jlYu4NQPXL+nstlB9KVrwQEU1Rw23QYCW4TQ3FiOCU15T4ydjFQ+xufpzeNUmpE4QGS5lcFhGZLGO5Ukxn0D9lTllPqHSCik37DERL0mKRDrGK1p5huCh9yiwIdNc605zjIaXBZyafYXiJKPBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w5O5J9RBnLIAj+XpY3QEyhOOvngd+oZcYPTtsWxQ0Xc=;
 b=VtVFw6YFExiho5YOR2oWBs42RAUg2lmBBv3VzfqBJ2rSTK8Br+TJWezGzBwChIOl5sEnRQyIpzOaTPVNhMOuDGP/Y9O1YfNOs4fzlzSL3AL3P01SwUXxwul2T3/yNdKbelR0/Wn7xyJMQlxUvwMJ6b4ekXYWLUngGC8yi9cnrs0rce01tUyR3Qi3NmK8dNSUIppNOFZRUAJA/nfxBVVVArc5zDOea1WBMeEMsjo0WCfznGAg4qZw0slZDpJtD+2Re3GiT1nu88d3NBmKQG4zzk14NaF2BNtYS7ja7F+qgMfddLTmynbH/XjHW+wbSVioaPRjaGprYmyPPyeV+bvTYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5O5J9RBnLIAj+XpY3QEyhOOvngd+oZcYPTtsWxQ0Xc=;
 b=a8Oggd1BXhhs9ZFKTky8vuB6n0V110otVB+jwSrVVD/Dq5SQ1ZDANEOL+Ra/hCdakzxF7jpAvhv3c/cNN33E2O2qZjG6JHmIfqWZPkWqEnyzvrDpmSgJe6Eq51+e+twLAkvZB4mRxIbSxGB6pz7ECx1qUyNJ6qgtyIs9Flw5Y50=
Received: from CH0PR03CA0025.namprd03.prod.outlook.com (2603:10b6:610:b0::30)
 by BL1PR12MB5780.namprd12.prod.outlook.com (2603:10b6:208:393::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 28 Apr
 2025 13:56:14 +0000
Received: from CH3PEPF00000009.namprd04.prod.outlook.com
 (2603:10b6:610:b0:cafe::12) by CH0PR03CA0025.outlook.office365.com
 (2603:10b6:610:b0::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.40 via Frontend Transport; Mon,
 28 Apr 2025 13:56:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH3PEPF00000009.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 13:56:13 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 08:56:13 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 08:56:13 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 28 Apr 2025 08:56:05 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, Roman Li
 <Roman.Li@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 06/28] drm/amd/display: Fix invalid context error in dml helper
Date: Mon, 28 Apr 2025 21:50:36 +0800
Message-ID: <20250428135514.20775-7-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250428135514.20775-1-ray.wu@amd.com>
References: <20250428135514.20775-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: ray.wu@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000009:EE_|BL1PR12MB5780:EE_
X-MS-Office365-Filtering-Correlation-Id: b07a2c17-0d0b-404f-86c9-08dd865c7089
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GcuP0qK/COST2Ci4AXbJMFodIVwJuNwmWN0ZpDrGvybrFP/ssR6PnAM4eDCk?=
 =?us-ascii?Q?Fk5Ttb4mpq9jh7UCcjTvqmznBkMyXtLinYjKA6kW40bEWcCtLEj6Ay8BOW+O?=
 =?us-ascii?Q?iDuSP1MdaAU4SBharEg6M/ZOrR1GUSvX25LvxunzRXJ7U1IYTX2BQVM9/x3f?=
 =?us-ascii?Q?2LR9/qHRl2GKIx04++9WhoCytXWkhxAWvetO3wiBmqQ+ucVilFAZ6CUngtdL?=
 =?us-ascii?Q?Ui+1WGYELbBYUG/AlCD16bDGT6BJcX/7D+35dJkYX449YekWsFi/v/8Y939i?=
 =?us-ascii?Q?Jam7gu12SVQ/G0Yh/JTDUKVZdHWFQ7P/4b3rXt+WRCDh9IKbGSH4i6Gn5NC8?=
 =?us-ascii?Q?y9Cqez2Qv82k4RZ/jjmP0Hko061CsWftzyrcb+qKZ6EuAOyWpnObGJOe0Wm8?=
 =?us-ascii?Q?h9JjSCV5SHhOy5We4cLZgs8HlZvbesggGdZjLzdm8HUha57P/Iaf9zUF+hk7?=
 =?us-ascii?Q?NUpF0t50UlbNpUU+Xts9o8Djkd6fLQsyDmNiTqzmxu4YV59/2ErMXo1MmDX1?=
 =?us-ascii?Q?dwqtjKs5LjF9n0c115jjjtut/jL4POjHXNNfWPp9Hwzh85uL9JW3Uz/P+5mF?=
 =?us-ascii?Q?QqjoSBr6fmKNc1d1fhagyH4WENwUlJZbFuqYzLtHOec23PIqf6e6OEf25cAz?=
 =?us-ascii?Q?DWU5iTJLPXhNVu8iWb7NTMDoYOihFAxkJODFTs+AOT+GysdydC06RfcCmCcH?=
 =?us-ascii?Q?c0E6i4lRi10863RHBc7KCd8iPCdnwPiJWSJW6qJpHPKGVj3/jMn1EhEcv5Gc?=
 =?us-ascii?Q?7gGt8N4SBL3DQFTfvlyvklWxN5bXiZe64h1jV2+KiUfSbxy0yWj2OeDsw+Dt?=
 =?us-ascii?Q?Sp2EQo1m0xMCIqGegPoFjwSZtS2Ikmy09DrQD9dn4D/ieWYEUMKAAr2u+8G9?=
 =?us-ascii?Q?X0PMvYyc+uhi4Ve7YLOb3NGLwjdFdyz8GWKSVui+RYUjFEqBVSiCSr7SY0tn?=
 =?us-ascii?Q?CN0BWlwwG+1vpWKtJiv64hWOFJUZobkwBPyR//Ruf1mOpjRcCbFaB38ibqUT?=
 =?us-ascii?Q?4dG3+2nz/s64atje+H3ZqLbGgYGpaZuetdy+UDwVL25OYw0O+YlNvl9IDbZ1?=
 =?us-ascii?Q?hDO3PCTvBi/LSiAs4VxN2tVM03kG8/HLwaWNbZpUtNPJYuXLIfPnTHAgFYPN?=
 =?us-ascii?Q?kN4FUd3U+oFx/ef0rIpNrn31TULwXW1Z+xfJ35oqUPpoeGPTWxkcPv1j2USJ?=
 =?us-ascii?Q?gLGrmnrxaPgdw/wHzS2OA5cwqaLYgo9bFnSEENgdLJq2MtDYXrpWk2ha3toe?=
 =?us-ascii?Q?iP2cuSIXFj/ahnIZSwIDSvgFxbnjGakIILaV/e0bblAW+mYTcEx2dEu6WxJX?=
 =?us-ascii?Q?vcWv2jmYc/tKyTO647gH9JKfVroY+yN8VVbuiVvov80mEO/vEAp8pzMeT2FR?=
 =?us-ascii?Q?2DCQ5HdakQCTtX/t0TsZh5LlfiWNWQYgKzf81kH4BnuE0210gL6G1sUal570?=
 =?us-ascii?Q?9Kz7T7EF4HtvGhT6/5GwQ8iHLpLhn0ChlRfE9sNeTAHfyGcsmgHKJHjwSsk1?=
 =?us-ascii?Q?cs+OGDw84vNwZURg5LXppwm7s0OFy+g+v5dM?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 13:56:13.9006 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b07a2c17-0d0b-404f-86c9-08dd865c7089
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000009.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5780
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

From: Roman Li <Roman.Li@amd.com>

[Why]
"BUG: sleeping function called from invalid context" error.
after:
"drm/amd/display: Protect FPU in dml2_validate()/dml21_validate()"

The populate_dml_plane_cfg_from_plane_state() uses the GFP_KERNEL flag
for memory allocation, which shouldn't be used in atomic contexts.

The allocation is needed only for using another helper function
get_scaler_data_for_plane().

[How]
Modify helpers to pass a pointer to scaler_data within existing context,
eliminating the need for dynamic memory allocation/deallocation
and copying.

Fixes: d1df16640462 ("drm/amd/display: Protect FPU in dml2_validate()/dml21_validate()")

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Roman Li <Roman.Li@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../amd/display/dc/dml2/dml2_translation_helper.c  | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
index 857ce1695fd5..5de775fd8fce 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
@@ -973,7 +973,9 @@ static void populate_dml_surface_cfg_from_plane_state(enum dml_project_id dml2_p
 	}
 }
 
-static void get_scaler_data_for_plane(const struct dc_plane_state *in, struct dc_state *context, struct scaler_data *out)
+static struct scaler_data *get_scaler_data_for_plane(
+		const struct dc_plane_state *in,
+		struct dc_state *context)
 {
 	int i;
 	struct pipe_ctx *temp_pipe = &context->res_ctx.temp_pipe;
@@ -994,7 +996,7 @@ static void get_scaler_data_for_plane(const struct dc_plane_state *in, struct dc
 	}
 
 	ASSERT(i < MAX_PIPES);
-	memcpy(out, &temp_pipe->plane_res.scl_data, sizeof(*out));
+	return &temp_pipe->plane_res.scl_data;
 }
 
 static void populate_dummy_dml_plane_cfg(struct dml_plane_cfg_st *out, unsigned int location,
@@ -1057,11 +1059,7 @@ static void populate_dml_plane_cfg_from_plane_state(struct dml_plane_cfg_st *out
 						    const struct dc_plane_state *in, struct dc_state *context,
 						    const struct soc_bounding_box_st *soc)
 {
-	struct scaler_data *scaler_data = kzalloc(sizeof(*scaler_data), GFP_KERNEL);
-	if (!scaler_data)
-		return;
-
-	get_scaler_data_for_plane(in, context, scaler_data);
+	struct scaler_data *scaler_data = get_scaler_data_for_plane(in, context);
 
 	out->CursorBPP[location] = dml_cur_32bit;
 	out->CursorWidth[location] = 256;
@@ -1126,8 +1124,6 @@ static void populate_dml_plane_cfg_from_plane_state(struct dml_plane_cfg_st *out
 	out->DynamicMetadataTransmittedBytes[location] = 0;
 
 	out->NumberOfCursors[location] = 1;
-
-	kfree(scaler_data);
 }
 
 static unsigned int map_stream_to_dml_display_cfg(const struct dml2_context *dml2,
-- 
2.43.0

