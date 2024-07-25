Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50891C3DA49
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 18:04:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F09FF10E8AE;
	Thu, 25 Jul 2024 18:04:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SYFwUgJw";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2040.outbound.protection.outlook.com [40.107.96.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E694B10E8AD
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 18:04:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CHU6uIY5+h/7HtTCNkgcRmkF7jgkj7oiOyioiLZhR65QEjlbQO3vGLBwpMOYtmd8cVnLhWz8cai2QqM6fP62KWL3/Abiiiar9WeFwat3uKcfa+I5IffDc8oeL13jkzlNmSdRpMRwvpo0IP7w5B/hrXRnRv9nmYYR1D6j3bCgketWefs/bLWQ0sor97Rf39NxlJJum3xnntBCUqjXNGoZ9OClfGQPiCViwm7cuxCvGFk7AmGUCAn8O8MgMRM+5rwq87SWBtna3Wwfm5O1bKPrg4gHBEK6xBfa7bnjFquAMipxVpBkpPpMvrRyJshPww4xMQlpMc4YZgGT/BrQSX7D7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rHg4ZdePVhchlAB6zpWsEYGQ41FwO541afzuTS9Fj2o=;
 b=wqF4RPc0BRpGhz5eAQeOoxa7AG2NEEfR0RM2e2Dq/33C0skNmxtnFa9D3NHEUgZfv55hgOFkQRkyRDtbYrRjGIecXQK+DMl0q51g0lV4GejHG+dv3OXftfcgogjUAadc7yWGjnhwGOdyud1sI5JFAGVuLFTrR7Xwk85DUQ1F8N2ltmynQanA/XzhkSY6w4jg2lKZq7wJni8AoSxGDKLgg5P/jNLbf4Y9VoQA2lQUD1FUPHU2XOyKyw6aB3EGXE9aPqKrqWa6zcHWD5D8sMBkv7cbR71vAJ/BS/wFp9zknukVCM3MRCqDBqRJOLJ10wbnG/Wxjpgr+weDEUyTmg22zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rHg4ZdePVhchlAB6zpWsEYGQ41FwO541afzuTS9Fj2o=;
 b=SYFwUgJw9q5t6dq7GX09OPmlAeyYLsSUopO7UxSIZC4fU71zXc95xDg5qsVMW35j0ULcNOSkZonl9IGdEAg5PIPG3sRhaDQx4FR9Vfr5qKUuJ0qnXpaH3qQ3JyZ+Myn/ZfpI7mmUPWcOFXZaSBhiDJ/likaU3/jElB17LUXd6u4=
Received: from CH0PR03CA0190.namprd03.prod.outlook.com (2603:10b6:610:e4::15)
 by CH3PR12MB9080.namprd12.prod.outlook.com (2603:10b6:610:1a7::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28; Thu, 25 Jul
 2024 18:04:21 +0000
Received: from CH2PEPF00000142.namprd02.prod.outlook.com
 (2603:10b6:610:e4:cafe::bc) by CH0PR03CA0190.outlook.office365.com
 (2603:10b6:610:e4::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20 via Frontend
 Transport; Thu, 25 Jul 2024 18:04:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000142.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 18:04:20 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 13:04:12 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>, Jun Lei <jun.lei@amd.com>, Rodrigo Siqueira
 <rodrigo.siqueira@amd.com>
Subject: [PATCH 22/39] drm/amd/display: Use gpuvm_min_page_size_kbytes for
 DML2 surfaces
Date: Thu, 25 Jul 2024 12:01:06 -0600
Message-ID: <20240725180309.105968-23-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240725180309.105968-1-Rodrigo.Siqueira@amd.com>
References: <20240725180309.105968-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000142:EE_|CH3PR12MB9080:EE_
X-MS-Office365-Filtering-Correlation-Id: b7dc7d7d-34e5-40a0-5f97-08dcacd43595
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7n486MJblInL9UhtuTIrZhPVwQ7YdxZNl8oZ+p0dSUTmtXd8FZfAxsyplG5b?=
 =?us-ascii?Q?5drt+UFN0ppMUoJzhzD4epg3aqqc37FeQg9rGOWLbOeVtqu9ykgogB4+02Bm?=
 =?us-ascii?Q?5ttuO8blH0AT+shhsiui+Fd4f2ipDmk+MMbsAx7kcQUvq4XYqyqtXx0hxqck?=
 =?us-ascii?Q?EPHZdZhMEjacpjjMshHxsPcL1O+NDsrrswWvGaG9l/OCuDY6v/C0EwL3nHYk?=
 =?us-ascii?Q?b0k3pZtC2P8Ilmi8+plYzSRDn4skVOx7tvksyBaLEjgfc2tiWblWH+YDrRB7?=
 =?us-ascii?Q?MoFcJf85cs98abU4Jf7CJ5Xi4v6xb0sbfjqSVjjJUgJXSbfkv32Y0EiqZBV+?=
 =?us-ascii?Q?r6yIvU2rqRvBbmU/8zeqeMZYqGcbskvHdC+kcnDZl2lazHU9eLPHbE8Kf274?=
 =?us-ascii?Q?svzU9HoTWSmffahc4hEAcAE+cBvSdSqoUn+Q8zaw5eRgaTygkOG45POJiUxT?=
 =?us-ascii?Q?9JPuqGZbKn0vhY3sRIpbmUY5EeXsHEsZo6AFoaj7gQQfufaGF2+zsB5lQGnM?=
 =?us-ascii?Q?RHRySSRbQMOZ+fbtFBfVl7j8li3B4emUrl6+ZIivmd4f0A/UU14YlQziEYno?=
 =?us-ascii?Q?Pi7No20LcVCBN1oJpc1RnjTC6eUhWH7QOrZ4IfNdyMis5d9HHRVcMgHzqfE4?=
 =?us-ascii?Q?z1ff0KiBmohWACR9HW8R1j+jvOIeVLmXBBFe4t6vrLHDp0CWLTiAKnAq0ziX?=
 =?us-ascii?Q?K/xI9WHRQXQgAsdYhFCTycRntxActRH+77qm48SJ1aLkUQG7I4wTNcRQ7Iy5?=
 =?us-ascii?Q?tS2RWgjAFrpjgGtW3TRSYPurjCoGUVZiGiFgVQlKmvpFiVxJ3vdvpGg8xGbC?=
 =?us-ascii?Q?IGLyhDc0RZTfwt+4QpGqrp+FiOxXVgDWSUJXgt97+LTFnFn4Ip4xCgHYoRvu?=
 =?us-ascii?Q?bfSMY4VHHVMiroBqHqlhvAwzI8MjV3ZHLTXwFad83sxduP2ctZrvg4l6oO5r?=
 =?us-ascii?Q?6wMzCWXGcTBaDWDBel+/pXCKAN7ZG9Vqzg97elrX26KmNrdnOKvkuGW4sc10?=
 =?us-ascii?Q?ar3ZeZZcP6ChQI4DOTT5GXadAegtTS9WGzy4f8Jc3TAOahAWd9AsDX9X+r5/?=
 =?us-ascii?Q?oPm3oB+GIHKgk44LWPQesfnicHsgX+4RMl01wqGyuzh6s2qIgL4fzBUSkfmn?=
 =?us-ascii?Q?YH6NNrAPUSAoF+cbq0RtZUXsCfh2R5ys9JRbAqnlNNYgrsbyL4Nlbx6d1qrS?=
 =?us-ascii?Q?BF7JX4ZNvBaSns2Oysu+LICfNEXrfd1+RLUyG/YD2DQ7KWVv1TW0oW2KtoqT?=
 =?us-ascii?Q?EZdxwua5GIPDiJxH2DAg5ds/p8kQWi/eaRrP5hSITgyNvTVHmLzX6RYSaS95?=
 =?us-ascii?Q?xjxyEWKvmBz3pqvz18oh/bB9Fg5OVUE+GVFUQM/gkq0WUCNYFnwSOs3lD5AL?=
 =?us-ascii?Q?uKP7Ly579O9KkEwz6WJiLfUGgpr1aLqRKUP3pnO/BNVirnVRegpdQ8/6J7qj?=
 =?us-ascii?Q?XlvyrDDiDOglwvEWeokhCmf33JsuVnA3?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 18:04:20.9137 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7dc7d7d-34e5-40a0-5f97-08dcacd43595
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000142.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9080
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

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
It's currently hard coded to 256 when it should be using the SOC
provided values. This can result in corruption with linear surfaces
where we prefetch more PTE than the buffer can hold.

[How]
Update the min page size correctly for the plane.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Jun Lei <jun.lei@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 .../display/dc/dml2/dml2_translation_helper.c | 20 +++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
index 25d4ef040173..7e39873832bf 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
@@ -954,7 +954,9 @@ static void get_scaler_data_for_plane(const struct dc_plane_state *in, struct dc
 	memcpy(out, &temp_pipe->plane_res.scl_data, sizeof(*out));
 }
 
-static void populate_dummy_dml_plane_cfg(struct dml_plane_cfg_st *out, unsigned int location, const struct dc_stream_state *in)
+static void populate_dummy_dml_plane_cfg(struct dml_plane_cfg_st *out, unsigned int location,
+					 const struct dc_stream_state *in,
+					 const struct soc_bounding_box_st *soc)
 {
 	dml_uint_t width, height;
 
@@ -971,7 +973,7 @@ static void populate_dummy_dml_plane_cfg(struct dml_plane_cfg_st *out, unsigned
 	out->CursorBPP[location] = dml_cur_32bit;
 	out->CursorWidth[location] = 256;
 
-	out->GPUVMMinPageSizeKBytes[location] = 256;
+	out->GPUVMMinPageSizeKBytes[location] = soc->gpuvm_min_page_size_kbytes;
 
 	out->ViewportWidth[location] = width;
 	out->ViewportHeight[location] = height;
@@ -1008,7 +1010,9 @@ static void populate_dummy_dml_plane_cfg(struct dml_plane_cfg_st *out, unsigned
 	out->ScalerEnabled[location] = false;
 }
 
-static void populate_dml_plane_cfg_from_plane_state(struct dml_plane_cfg_st *out, unsigned int location, const struct dc_plane_state *in, struct dc_state *context)
+static void populate_dml_plane_cfg_from_plane_state(struct dml_plane_cfg_st *out, unsigned int location,
+						    const struct dc_plane_state *in, struct dc_state *context,
+						    const struct soc_bounding_box_st *soc)
 {
 	struct scaler_data *scaler_data = kzalloc(sizeof(*scaler_data), GFP_KERNEL);
 	if (!scaler_data)
@@ -1019,7 +1023,7 @@ static void populate_dml_plane_cfg_from_plane_state(struct dml_plane_cfg_st *out
 	out->CursorBPP[location] = dml_cur_32bit;
 	out->CursorWidth[location] = 256;
 
-	out->GPUVMMinPageSizeKBytes[location] = 256;
+	out->GPUVMMinPageSizeKBytes[location] = soc->gpuvm_min_page_size_kbytes;
 
 	out->ViewportWidth[location] = scaler_data->viewport.width;
 	out->ViewportHeight[location] = scaler_data->viewport.height;
@@ -1332,7 +1336,8 @@ void map_dc_state_into_dml_display_cfg(struct dml2_context *dml2, struct dc_stat
 			disp_cfg_plane_location = dml_dispcfg->num_surfaces++;
 
 			populate_dummy_dml_surface_cfg(&dml_dispcfg->surface, disp_cfg_plane_location, context->streams[i]);
-			populate_dummy_dml_plane_cfg(&dml_dispcfg->plane, disp_cfg_plane_location, context->streams[i]);
+			populate_dummy_dml_plane_cfg(&dml_dispcfg->plane, disp_cfg_plane_location,
+						     context->streams[i], &dml2->v20.dml_core_ctx.soc);
 
 			dml_dispcfg->plane.BlendingAndTiming[disp_cfg_plane_location] = disp_cfg_stream_location;
 
@@ -1348,7 +1353,10 @@ void map_dc_state_into_dml_display_cfg(struct dml2_context *dml2, struct dc_stat
 				ASSERT(disp_cfg_plane_location >= 0 && disp_cfg_plane_location <= __DML2_WRAPPER_MAX_STREAMS_PLANES__);
 
 				populate_dml_surface_cfg_from_plane_state(dml2->v20.dml_core_ctx.project, &dml_dispcfg->surface, disp_cfg_plane_location, context->stream_status[i].plane_states[j]);
-				populate_dml_plane_cfg_from_plane_state(&dml_dispcfg->plane, disp_cfg_plane_location, context->stream_status[i].plane_states[j], context);
+				populate_dml_plane_cfg_from_plane_state(
+					&dml_dispcfg->plane, disp_cfg_plane_location,
+					context->stream_status[i].plane_states[j], context,
+					&dml2->v20.dml_core_ctx.soc);
 
 				if (stream_mall_type == SUBVP_MAIN) {
 					dml_dispcfg->plane.UseMALLForPStateChange[disp_cfg_plane_location] = dml_use_mall_pstate_change_sub_viewport;
-- 
2.43.0

