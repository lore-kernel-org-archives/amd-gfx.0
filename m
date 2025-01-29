Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6216CC0218D
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jan 2025 02:45:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18E8710E71F;
	Wed, 29 Jan 2025 02:45:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DJG4FEdt";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2FAE10E71F
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jan 2025 02:45:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QJmc78hy+iwh0aKMhNvo9cKPLbxPTgDhwYvS3R2+pphtWjgGYJhSBSYeQFHc3liNCsq3JWJxaQG3n/iFJGdkzXCZiJCLMqa85+YuP9/GYMhVNgZEigxwzligDJNBiy2wwdmFOJDaWCcc9fmEzRHzJha4Mv1BKCsI0/UVaLa5uF5elD0KqMc6Gw+t6Lo8l51rLqz60p0mMkz7+EFdsg2WDtD7a27j+a5HX1/Q3BmtQhTo3n9Uvesnx3gMtoEGpw7MOUP/iXrB5lTPB3GnYCzl4dUDPq4nWxyq8g1iCdyAFDt9SLWx7umhEAkyldDX0sGcgWBZLvz0BOLQNJ8XQ//5Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ec7a7LcTDaWUUP/cIjxfjMA+Gc1K9wMgoktPJTvEiDM=;
 b=Pw+gzxSt1x2cTXfLCpNA8pDZwnc0drT5uzM+B/BF/fS/wSZRWl8eplZeCuUL3zPbRadrFOTqyGMsutQz/4/tNJX+egYMftYiTPd3vBu/7O+PNDouR+gzna3KvxeVXctYZB1ShTyGGqdWLy72gqbDyvpp4Kw2q6evVToGmkGoR21Mgg3D1UMM1R3gSnQv2n/+l/R3SNyL7rHrcDQVAi3szgdnZjEQApE4BUYWCWgStVdZQUlF46lerHC2De7hy32jFiULCwyDyT0M4pr524x3QgRawZNYiNkLWopJ/UIgRTnlRKGl3Y7ToX9MmIXmx3ceCXD3QCJ0cBxUjIM2v2m1Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ec7a7LcTDaWUUP/cIjxfjMA+Gc1K9wMgoktPJTvEiDM=;
 b=DJG4FEdtvI39D/NgsmXb0D4VZOmen36tTA2OSOyLw+fwhMKKbJk/lDIs3OrrHyCfYmTwbi52ff+w4bALNO+JrR9U90UX6JaXNPobgX5jtgqcfu5/dz0iwlf5MtTxyWXsMIv8b8IfbPCYq9De9thKHzgnQx6rTYFNtUCk/94ur/c=
Received: from MN2PR07CA0012.namprd07.prod.outlook.com (2603:10b6:208:1a0::22)
 by DM6PR12MB4220.namprd12.prod.outlook.com (2603:10b6:5:21d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Wed, 29 Jan
 2025 02:45:28 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:208:1a0:cafe::26) by MN2PR07CA0012.outlook.office365.com
 (2603:10b6:208:1a0::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.17 via Frontend Transport; Wed,
 29 Jan 2025 02:45:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 29 Jan 2025 02:45:27 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 28 Jan
 2025 20:45:25 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Austin Zheng <Austin.Zheng@amd.com>
Subject: [PATCH 02/10] drm/amd/display: Fix out-of-bound accesses
Date: Tue, 28 Jan 2025 19:41:38 -0700
Message-ID: <20250129024432.2107937-3-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250129024432.2107937-1-alex.hung@amd.com>
References: <20250129024432.2107937-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|DM6PR12MB4220:EE_
X-MS-Office365-Filtering-Correlation-Id: 4309ec79-a757-4dcd-bb2c-08dd400efd54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?T4enT0l8Q9ER4A116TahLW+ZrE7zLNa+99TPOoFa9SFdReyj/hfkvZvROjvU?=
 =?us-ascii?Q?bTQMMjp4vIy90nP9K4OWsj1v8t+5g8/QK7Llwq3ca38T6S7rWMPw5fed/o80?=
 =?us-ascii?Q?AQW3Xc9vTtOuYTPIsJug6iFqou24hQe2fMvWj3aIlTbJwl8Ke10CHpR3oi9T?=
 =?us-ascii?Q?Ed4wKIjsSgItCYfkFO2bFv8oTYgo6LCHK6S1zj1EVpHgqIn+g+kXWowfSAMP?=
 =?us-ascii?Q?9nSniWx0NCCHgoBOd4PDfq7cdoNq0Up1MtuuUNkI0fFe6DrFrwx8qeCzplvR?=
 =?us-ascii?Q?3FptcOb68DyqKc4UrjnLBSD22YXwEcGLTEnvwTOmC0OLbX3bYTg70T1u3Lf6?=
 =?us-ascii?Q?Tp8q45sbCTiaSjgtJCkMA8+atHNNNV8T94NTltZ1D6lzCHeg/dntl0ApkjgM?=
 =?us-ascii?Q?okTB6HdMziLrQrz3PKBPWM9PHxuxaGG1zNCxECoSws2SMNivXTRPZBiky1ME?=
 =?us-ascii?Q?swfPJQ5A2Wv1rYUCehB8SWFGp72u3xUPlRdG34BdfrW/0oN6f5DIji1erk/E?=
 =?us-ascii?Q?ZvrhGsIJBfcXMc+WSc47JZheX9U2y6o5itsgEBNZhcn5+efbfr+sUTH4YYKX?=
 =?us-ascii?Q?vQu4ggyLz68r5VOfUbUQTxc2Z1IiPhgXlnRPqGFWdUF29RPyLgdM3hOfIOdF?=
 =?us-ascii?Q?XWKju2MrVhzTGyD2AbC6ycQYiTp5FuV0e4D/Rikwj+NnP2cVuSNaf7lb3yJx?=
 =?us-ascii?Q?sSnOrntjotjd5TruR261IYEJmfn4eEmO7ZJogfDTx60FhYXlQWtcBVRkOm1w?=
 =?us-ascii?Q?x8KtFS3g3CsbrB7RoBMbRWgNhIhcZf4WEqiED0tJxkf/bGcW0vBc9ZHSs6lY?=
 =?us-ascii?Q?idaB6ir7iM6r1wruIelQmMvqp8LRGYOAzQwYmvUhRayzbB7OyJ9MnihcfbXg?=
 =?us-ascii?Q?sa1AGXoZpgcggngIQwuSg4sMOVbM6E5sSCFxltwsf3A42Q8BMXkOb10yDPpe?=
 =?us-ascii?Q?1ZjUHHyeYfyX+PMLAMzuaYiZZH/uQ2hfvWDJWVORK+y/Ybdg7M15vOEKeGAL?=
 =?us-ascii?Q?l+PFWWIMpw4IXsGNTo5FfD3vs0S1dEyJF4E+U/kX7P8NjRxa+o2wIypadh7a?=
 =?us-ascii?Q?w/udYeC5PZbfsx+qZjXf480q1agTpbkCSyU144E+zdTVwpMy0iBPzw3Hl3Ai?=
 =?us-ascii?Q?od2AQ71qqdWGzfUM69pGwv4Uv7Ekh0ia3uXeyzTOId2bTRG8LMrE2RdWtk4J?=
 =?us-ascii?Q?XmNn2y+I7vpu1akGaW5OSjh2T0Yx1/I/b4S6EdVlosub9+/XRka7FNyaFav4?=
 =?us-ascii?Q?wkNsBHKJPhcT9VjvKoC4krCBZoD5Llo7jycTxlxV5OI6UMhJdDtiyoirKYls?=
 =?us-ascii?Q?KMbrrPziKnOJD2X4/N70AUnEpIw7Ao09Tk/7nrHzCNA4Q8XTbY2tFcvbOphE?=
 =?us-ascii?Q?J9XhgXwl6ygQyxwvGS/7YpcVU7Cuv9CG414k/aP/Uz3gtvvSgoXZmGvHCsYo?=
 =?us-ascii?Q?bSNaVNUyYjWQ84VO34fDxFEPuTPe7G/V6wdtIduqLYMkTjSWYZCUlyCgmxFM?=
 =?us-ascii?Q?gvvojYqXxwJ4tcs=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 02:45:27.9761 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4309ec79-a757-4dcd-bb2c-08dd400efd54
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4220
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

[WHAT & HOW]
hpo_stream_to_link_encoder_mapping has size MAX_HPO_DP2_ENCODERS(=4),
but location can have size up to 6. As a result, it is necessary to
check location against MAX_HPO_DP2_ENCODERS.

Similiarly, disp_cfg_stream_location can be used as an array index which
should be 0..5, so the ASSERT's conditions should be less without equal.

Reviewed-by: Austin Zheng <Austin.Zheng@amd.com>
Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../amd/display/dc/dml2/dml21/dml21_translation_helper.c    | 4 ++--
 .../gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c   | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
index b9c6b45f6872..0c8ec30ea672 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
@@ -1017,7 +1017,7 @@ bool dml21_map_dc_state_into_dml_display_cfg(const struct dc *in_dc, struct dc_s
 		if (disp_cfg_stream_location < 0)
 			disp_cfg_stream_location = dml_dispcfg->num_streams++;
 
-		ASSERT(disp_cfg_stream_location >= 0 && disp_cfg_stream_location <= __DML2_WRAPPER_MAX_STREAMS_PLANES__);
+		ASSERT(disp_cfg_stream_location >= 0 && disp_cfg_stream_location < __DML2_WRAPPER_MAX_STREAMS_PLANES__);
 		populate_dml21_timing_config_from_stream_state(&dml_dispcfg->stream_descriptors[disp_cfg_stream_location].timing, context->streams[stream_index], dml_ctx);
 		adjust_dml21_hblank_timing_config_from_pipe_ctx(&dml_dispcfg->stream_descriptors[disp_cfg_stream_location].timing, &context->res_ctx.pipe_ctx[stream_index]);
 		populate_dml21_output_config_from_stream_state(&dml_dispcfg->stream_descriptors[disp_cfg_stream_location].output, context->streams[stream_index], &context->res_ctx.pipe_ctx[stream_index]);
@@ -1042,7 +1042,7 @@ bool dml21_map_dc_state_into_dml_display_cfg(const struct dc *in_dc, struct dc_s
 				if (disp_cfg_plane_location < 0)
 					disp_cfg_plane_location = dml_dispcfg->num_planes++;
 
-				ASSERT(disp_cfg_plane_location >= 0 && disp_cfg_plane_location <= __DML2_WRAPPER_MAX_STREAMS_PLANES__);
+				ASSERT(disp_cfg_plane_location >= 0 && disp_cfg_plane_location < __DML2_WRAPPER_MAX_STREAMS_PLANES__);
 
 				populate_dml21_surface_config_from_plane_state(in_dc, &dml_dispcfg->plane_descriptors[disp_cfg_plane_location].surface, context->stream_status[stream_index].plane_states[plane_index]);
 				populate_dml21_plane_config_from_plane_state(dml_ctx, &dml_dispcfg->plane_descriptors[disp_cfg_plane_location], context->stream_status[stream_index].plane_states[plane_index], context, stream_index);
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
index b416320873e1..b8a34abaf519 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
@@ -786,7 +786,7 @@ static void populate_dml_output_cfg_from_stream_state(struct dml_output_cfg_st *
 	case SIGNAL_TYPE_DISPLAY_PORT_MST:
 	case SIGNAL_TYPE_DISPLAY_PORT:
 		out->OutputEncoder[location] = dml_dp;
-		if (dml2->v20.scratch.hpo_stream_to_link_encoder_mapping[location] != -1)
+		if (location < MAX_HPO_DP2_ENCODERS && dml2->v20.scratch.hpo_stream_to_link_encoder_mapping[location] != -1)
 			out->OutputEncoder[dml2->v20.scratch.hpo_stream_to_link_encoder_mapping[location]] = dml_dp2p0;
 		break;
 	case SIGNAL_TYPE_EDP:
@@ -1343,7 +1343,7 @@ void map_dc_state_into_dml_display_cfg(struct dml2_context *dml2, struct dc_stat
 		if (disp_cfg_stream_location < 0)
 			disp_cfg_stream_location = dml_dispcfg->num_timings++;
 
-		ASSERT(disp_cfg_stream_location >= 0 && disp_cfg_stream_location <= __DML2_WRAPPER_MAX_STREAMS_PLANES__);
+		ASSERT(disp_cfg_stream_location >= 0 && disp_cfg_stream_location < __DML2_WRAPPER_MAX_STREAMS_PLANES__);
 
 		populate_dml_timing_cfg_from_stream_state(&dml_dispcfg->timing, disp_cfg_stream_location, context->streams[i]);
 		populate_dml_output_cfg_from_stream_state(&dml_dispcfg->output, disp_cfg_stream_location, context->streams[i], current_pipe_context, dml2);
@@ -1383,7 +1383,7 @@ void map_dc_state_into_dml_display_cfg(struct dml2_context *dml2, struct dc_stat
 				if (disp_cfg_plane_location < 0)
 					disp_cfg_plane_location = dml_dispcfg->num_surfaces++;
 
-				ASSERT(disp_cfg_plane_location >= 0 && disp_cfg_plane_location <= __DML2_WRAPPER_MAX_STREAMS_PLANES__);
+				ASSERT(disp_cfg_plane_location >= 0 && disp_cfg_plane_location < __DML2_WRAPPER_MAX_STREAMS_PLANES__);
 
 				populate_dml_surface_cfg_from_plane_state(dml2->v20.dml_core_ctx.project, &dml_dispcfg->surface, disp_cfg_plane_location, context->stream_status[i].plane_states[j]);
 				populate_dml_plane_cfg_from_plane_state(
-- 
2.43.0

