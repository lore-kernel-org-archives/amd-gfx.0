Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19941E7718B
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2024 21:51:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A624F10F080;
	Fri, 20 Dec 2024 21:51:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O3I3hXXx";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C3DA10F07B
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Dec 2024 21:51:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nsvqAbGRMf7ZIWgO4yD3SRy/OndX0TFERiT9IiLwLE3uEMdfp1d467Dz/e+9lgeYO8z1WPN3A7fRWeT0BYcQS+i3kuorKe9GF26qX+l8/R+rZE3EcjvZhvlDlCgXb8CtAKf0WJoRMLqR2OVxEA2w8ceuzaVRinasfHf0OLJwKo0D5nWFwDBJ7x5jqP4qloqIRclrpWCxDKYYUx64yI47+r2twMCQGTd/37fLIxtICfPY5Eio1OhvIGwlFglmlCS8iSTcgs5ijvtvD+J0uFKBPlpIDZuZ72va6JyjLoT+/09IbysV9ylWOdc/T0heQ2EwAwEI3gI/YuotVMgwfTjOCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4qTvAtahtPNqYWQrIn95psqhmWwFh5xCPA5ynxPpekU=;
 b=AREN/pDttsFP8ziwrDWB/+zvz26WXC5tE7CzlBsEgb78cLnPhlct97G+LptMAZ1ifasx5fSqRAO75CGMSrcsXAipGqml/zzMQZ7YEgbuhFWIO2G8uE2+TCUDayTHvPusK/6cHKLJDEqZqoSaRvKjj04sz08a+GmksCbTt6lCggd22Lih5wuirrF2pOleCcgzNpWMM72PwDvkuSvk4v+frhTl2d4msVd+70vgnJCKd5DiO/nomojHJf/D8GaiaKRcO02uIL1gJYZANqOR22vBYfq39lT1x3/NlSar8mTbCdcjbZNgWOngoz7lxMNP44d2ETPdbe+gpggcK9UuN9D8lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4qTvAtahtPNqYWQrIn95psqhmWwFh5xCPA5ynxPpekU=;
 b=O3I3hXXxmEL6x1RBAfwLKE/nF5lzGDN/pGNCEJES/bcfIaFT+0HKHbB0wd4pK3M9lkLOtcRh3uvHHA8rMv1Fgd8a6bScgVv3zA4KA47yneG+7BCsDgkAf463iXFWsvMX0VsEeixc0LKwPHrXusJxSZIq8DVBvHvUcjnMRwUiDfI=
Received: from MW4PR03CA0172.namprd03.prod.outlook.com (2603:10b6:303:8d::27)
 by SA0PR12MB7075.namprd12.prod.outlook.com (2603:10b6:806:2d5::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Fri, 20 Dec
 2024 21:51:20 +0000
Received: from SJ5PEPF000001EB.namprd05.prod.outlook.com
 (2603:10b6:303:8d:cafe::49) by MW4PR03CA0172.outlook.office365.com
 (2603:10b6:303:8d::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.21 via Frontend Transport; Fri,
 20 Dec 2024 21:51:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001EB.mail.protection.outlook.com (10.167.242.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Fri, 20 Dec 2024 21:51:19 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 20 Dec
 2024 15:51:18 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 20 Dec
 2024 15:51:17 -0600
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 20 Dec 2024 15:51:17 -0600
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, "Karthi
 Kandasamy" <karthi.kandasamy@amd.com>, Alvin Lee <alvin.lee2@amd.com>
Subject: [PATCH 17/28] drm/amd/display: Ensure correct GFX tiling info passed
 to DML
Date: Fri, 20 Dec 2024 16:48:44 -0500
Message-ID: <20241220214855.2608618-18-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241220214855.2608618-1-Roman.Li@amd.com>
References: <20241220214855.2608618-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EB:EE_|SA0PR12MB7075:EE_
X-MS-Office365-Filtering-Correlation-Id: 06d933d9-a719-44d4-c5e2-08dd2140702e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KwJn/2HA2XaJgeAPVq9Y8D/G3t4fNCl4WvtzZgGVw7Y2KfiHjZH0EDVLR0xW?=
 =?us-ascii?Q?QbZSX5yYClzVIfAdPc5dwfXQLQOS34r1p7a5/IH0SHURcMDe/VSBebr1Nh6B?=
 =?us-ascii?Q?wZNwVMTssUlqU6tUd/b+mOUimCbliMdFGjbzpcWy0E3JpGXi4maVAoahkmVM?=
 =?us-ascii?Q?MRCP8m1fXL+dehcXjnVR5YkkxrAAdTN4FgPaJqPn9N6TgoPRW5JUZlyigUfR?=
 =?us-ascii?Q?nYBeYxjGVT0DTjt9OMYI4UVXlLGZ6Ezq6jRbRv0PvRyxM1kgHPkovcR/Rmin?=
 =?us-ascii?Q?J5w3LZufD6Cg3TEpooU4pJLEPwFjJHDkmExe3y14JRUvnaNiT7e8hQUe86bk?=
 =?us-ascii?Q?mzTtjlo1CBmCKHle/UaDYLuoCUOOggyEJwyuYYXltLLAp1d/zjyJT30lz34F?=
 =?us-ascii?Q?dt+4d/YoLBtRSShzThyUMgqTxGsK7g0PoAiiIc80K/1jaPNQjsCSVdKi2OUJ?=
 =?us-ascii?Q?cYdJlI2g4TScroYueHOrPtocbjl2B+St1yZflXW4t1JCDOiv7mSHnpsrFDgi?=
 =?us-ascii?Q?AiOIa5wtMYG1/TqzkZlFm4BEQyCdFzPgOy3oEN6fxgLIxS1bMNnySLCaBqiA?=
 =?us-ascii?Q?rEemVgSuCkb/xiyumv8NAliF14Zfp25gyzrnaYHeFzrUFI8sCxMU5CVuuobp?=
 =?us-ascii?Q?S+De9Gp8Aka7owesrqgNLGTRqg1JEWIt2DOZlbQGr2p1Gz29qQY4bIbk08T3?=
 =?us-ascii?Q?BBOWDQelA5cm1ZQliou/2xh9ppzFsCRJ5etPWn9GnLtXl1/9UkNphxhSPZbS?=
 =?us-ascii?Q?IQR5/ie/V3f2Dp1jl6M2UFvG5Iy5gcUoG254TVv/KWehDNHPIKLtWUYdf1XU?=
 =?us-ascii?Q?rjgnBKKQkDR9w4apqYV0RVPHTvuI0doLKk+idFcYtv+Dj7LhoMe/8a5jpyfG?=
 =?us-ascii?Q?oakLdXplFMSFeGIHwSu2JA9vNRqblUl+J8Z7VMwOgOYYax+M6H8FO5TN7lNP?=
 =?us-ascii?Q?E6IZ1J11+8zzWbDJLs+q/CMB/7K5DrRqBTLQr16K4MVeP6pBECa/I/+Zhc9R?=
 =?us-ascii?Q?WAQxk7BVR7uhxbqfItw8L1jKNLnS3DJzQdSos+RxY3xlWvuoo6IST1t+Jt3c?=
 =?us-ascii?Q?vE+96Q37ykoB4J2dI+L4blGZXz0SpJJdXwj4C978GQ3MAxt628i0HqmKSXOq?=
 =?us-ascii?Q?QnmSNuiG4c4DNNBFtnCG14yQsM6U9UU+Tod3k/Os6IguMYvK7dCXSD5dF9EV?=
 =?us-ascii?Q?Lmi149sBjAaRPjp/dgQsF0maPxqdkQKhNKBOeFkAK928hNEAdmB54rEob59m?=
 =?us-ascii?Q?a4DZnp3VfWKiTC7BXWY2bMqMTfy7ZWeUWqz0HznQAlUxiaN5hlwLnXMrTG2k?=
 =?us-ascii?Q?AVkoukZlU3sHZYxvH3PPlpufnH1lOfgTeB/eg7tcGGWUr25CnX2cTfPhvlEf?=
 =?us-ascii?Q?R+qke63CsHzz2xWp08g/NqjjRh+Ks9onAjz+v8lWr8Xma7o5qVN3yXI4B6Ek?=
 =?us-ascii?Q?/UV3WIp930y3eymX+CEP0d2knxWoAqWGqWQwHP53MmYE5+5ZJsvcKIx/pl2e?=
 =?us-ascii?Q?Ils3663hQAMq22I=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 21:51:19.8809 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06d933d9-a719-44d4-c5e2-08dd2140702e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7075
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

From: Karthi Kandasamy <karthi.kandasamy@amd.com>

[Why]
To ensure DML validation receives the correct tiling information,
such as swizzle mode or array mode, based on the active GFX format

[How]
- For new GFX format passed swizzle_mode to DML.
- For legacy GFX format passed array_mode to DML.
- Dynamically determined the appropriate tiling info based on the
  active GFX format.

[Description]
This commit ensures that the correct GFX tiling information is passed
to DML. Depending on the active GFX format, the appropriate tiling info
is passed to DML. This change accommodates the different GFX formats
supported by latest platforms, ensuring compatibility and proper
DML validation.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Karthi Kandasamy <karthi.kandasamy@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c  |  3 +++
 .../dc/dml2/dml21/dml21_translation_helper.c     | 16 +++++++++++++---
 .../display/dc/resource/dcn35/dcn35_resource.c   |  9 ++++++++-
 .../display/dc/resource/dcn35/dcn35_resource.h   |  1 +
 .../display/dc/resource/dcn351/dcn351_resource.c |  2 +-
 .../display/dc/resource/dcn401/dcn401_resource.c |  1 +
 6 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index db8c55cc865e..774cc3f4f3fd 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -190,6 +190,7 @@ static void amdgpu_dm_plane_fill_gfx8_tiling_info_from_flags(struct dc_tiling_in
 		tile_split = AMDGPU_TILING_GET(tiling_flags, TILE_SPLIT);
 		num_banks = AMDGPU_TILING_GET(tiling_flags, NUM_BANKS);
 
+		tiling_info->gfxversion = DcGfxVersion8;
 		/* XXX fix me for VI */
 		tiling_info->gfx8.num_banks = num_banks;
 		tiling_info->gfx8.array_mode =
@@ -317,6 +318,7 @@ static int amdgpu_dm_plane_fill_gfx9_plane_attributes_from_modifiers(struct amdg
 
 	amdgpu_dm_plane_fill_gfx9_tiling_info_from_modifier(adev, tiling_info, modifier);
 	tiling_info->gfx9.swizzle = amdgpu_dm_plane_modifier_gfx9_swizzle_mode(modifier);
+	tiling_info->gfxversion = DcGfxVersion9;
 
 	if (amdgpu_dm_plane_modifier_has_dcc(modifier)) {
 		uint64_t dcc_address = afb->address + afb->base.offsets[1];
@@ -369,6 +371,7 @@ static int amdgpu_dm_plane_fill_gfx12_plane_attributes_from_modifiers(struct amd
 	amdgpu_dm_plane_fill_gfx9_tiling_info_from_device(adev, tiling_info);
 
 	tiling_info->gfx9.swizzle = amdgpu_dm_plane_modifier_gfx9_swizzle_mode(modifier);
+	tiling_info->gfxversion = DcGfxAddr3;
 
 	if (amdgpu_dm_plane_modifier_has_dcc(modifier)) {
 		int max_compressed_block = AMD_FMT_MOD_GET(DCC_MAX_COMPRESSED_BLOCK, modifier);
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
index efb099905496..47a8c770794b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
@@ -721,11 +721,21 @@ static void populate_dml21_surface_config_from_plane_state(
 	surface->dcc.informative.fraction_of_zero_size_request_plane1 = plane_state->dcc.independent_64b_blks_c;
 	surface->dcc.plane0.pitch = plane_state->dcc.meta_pitch;
 	surface->dcc.plane1.pitch = plane_state->dcc.meta_pitch_c;
-	if (in_dc->ctx->dce_version < DCN_VERSION_4_01) {
-		/* needed for N-1 testing */
+
+	// Update swizzle / array mode based on the gfx_format
+	switch (plane_state->tiling_info.gfxversion) {
+	case DcGfxVersion7:
+	case DcGfxVersion8:
+		// Placeholder for programming the array_mode
+		break;
+	case DcGfxVersion9:
+	case DcGfxVersion10:
+	case DcGfxVersion11:
 		surface->tiling = gfx9_to_dml2_swizzle_mode(plane_state->tiling_info.gfx9.swizzle);
-	} else {
+		break;
+	case DcGfxAddr3:
 		surface->tiling = gfx_addr3_to_dml2_swizzle_mode(plane_state->tiling_info.gfx_addr3.swizzle);
+		break;
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
index 89e2adcf2a28..b878b60feff9 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
@@ -1752,6 +1752,13 @@ static bool dcn35_validate_bandwidth(struct dc *dc,
 	return out;
 }
 
+enum dc_status dcn35_patch_unknown_plane_state(struct dc_plane_state *plane_state)
+{
+	plane_state->tiling_info.gfxversion = DcGfxVersion9;
+	dcn20_patch_unknown_plane_state(plane_state);
+	return DC_OK;
+}
+
 
 static struct resource_funcs dcn35_res_pool_funcs = {
 	.destroy = dcn35_destroy_resource_pool,
@@ -1775,7 +1782,7 @@ static struct resource_funcs dcn35_res_pool_funcs = {
 	.acquire_post_bldn_3dlut = dcn30_acquire_post_bldn_3dlut,
 	.release_post_bldn_3dlut = dcn30_release_post_bldn_3dlut,
 	.update_bw_bounding_box = dcn35_update_bw_bounding_box_fpu,
-	.patch_unknown_plane_state = dcn20_patch_unknown_plane_state,
+	.patch_unknown_plane_state = dcn35_patch_unknown_plane_state,
 	.get_panel_config_defaults = dcn35_get_panel_config_defaults,
 	.get_preferred_eng_id_dpia = dcn35_get_preferred_eng_id_dpia,
 	.get_det_buffer_size = dcn31_get_det_buffer_size,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.h
index f97bb4cb3761..9d03a55d90cf 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.h
@@ -35,6 +35,7 @@
 
 extern struct _vcs_dpi_ip_params_st dcn3_5_ip;
 extern struct _vcs_dpi_soc_bounding_box_st dcn3_5_soc;
+enum dc_status dcn35_patch_unknown_plane_state(struct dc_plane_state *plane_state);
 
 struct dcn35_resource_pool {
 	struct resource_pool base;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
index 263a37c1cd3a..16abd3ae8684 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
@@ -1754,7 +1754,7 @@ static struct resource_funcs dcn351_res_pool_funcs = {
 	.acquire_post_bldn_3dlut = dcn30_acquire_post_bldn_3dlut,
 	.release_post_bldn_3dlut = dcn30_release_post_bldn_3dlut,
 	.update_bw_bounding_box = dcn351_update_bw_bounding_box_fpu,
-	.patch_unknown_plane_state = dcn20_patch_unknown_plane_state,
+	.patch_unknown_plane_state = dcn35_patch_unknown_plane_state,
 	.get_panel_config_defaults = dcn35_get_panel_config_defaults,
 	.get_preferred_eng_id_dpia = dcn351_get_preferred_eng_id_dpia,
 	.get_det_buffer_size = dcn31_get_det_buffer_size,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
index 09f5b8b40791..d75f8da63e10 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
@@ -1609,6 +1609,7 @@ static void dcn401_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *b
 
 enum dc_status dcn401_patch_unknown_plane_state(struct dc_plane_state *plane_state)
 {
+	plane_state->tiling_info.gfxversion = DcGfxAddr3;
 	plane_state->tiling_info.gfx_addr3.swizzle = DC_ADDR3_SW_64KB_2D;
 	return DC_OK;
 }
-- 
2.34.1

