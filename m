Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0229DC3DA42
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jul 2024 19:40:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B024110E8CC;
	Wed, 10 Jul 2024 19:40:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mafD9B29";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2082.outbound.protection.outlook.com [40.107.102.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62C0910E8CC
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 19:40:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FXqew65CvxNRWNmxC8CHv6LFpyep4vOpdqkpT9VVFz8o08uLawBxaXRCn+WWcMTtnDrtAhZ2yyw8bNhq9ztg3K17HdbK1+NqdYMki0YMURxeCu+PllPaaJvGtcsvI7/Y19XFDM8w47ENPdDYmWDzXeAW+QE3yOulXsaVCB49dz70l2G928NgJCfyJPZAkyy+XGIi3JSX/OLfejSpjK4tdxaHKHwQ0pTpLVzIMQYUPhuz0wjppOmuqAzv2c1MSzahzO6UN94BXxSIrP6ge08RNp+uWtoDfE68MCbVjV97WGFh4wMvyinFDRoVuCJbwKlmzHXKzJWycmINoLMAk6a8Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yHGtJjZlS1W3WluepE6kgXIpbu1eCoKczGb2dS5sYKY=;
 b=dDcLBT2sv966mXQ60VrV6etAg2F//ut1iZdBjvhpvHkzSH2z9vHfrlYI9R8qqW3zYRu4NNC56KqI5ImzTQzad262miWB7a/tHRqictAqvzQwMSkmNPxIwZHkTfNZkd5xw+dl6R/G0jAf5HEZ6ZG5OeODPjBec0ZiT6HlQrixsyYG1S67w+xLUYNyRPRboio/Dr8UBsRw9N/p2yfBOPnKXZFWbYOdwHdrJYu3lAuupyO6/ovkUo5b/eEy8eQDapwkUorzZUsnCk1tQYC3z8pCvLd9R9RAsxIzog4RK5c43/Pju3NUEV745oM4YJuaM85ec84+lNZdQWOM/AY8lDwR7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yHGtJjZlS1W3WluepE6kgXIpbu1eCoKczGb2dS5sYKY=;
 b=mafD9B29n8s2Zj+U9oU8ERufNq1rrVRkm8mWFGNr0WxxM8sIhJ3VErw5Sv+re0/CFDfRik6LOpujhBwV8CEl5Q3nOOjUeAjL8URSjgFmsvGsslK6ESCPQX5fNcI90w1LVoKCWP0zhg/k9uTxabeuZIF6ajxkSwkz/tQ6Boefz7A=
Received: from BYAPR01CA0071.prod.exchangelabs.com (2603:10b6:a03:94::48) by
 LV8PR12MB9208.namprd12.prod.outlook.com (2603:10b6:408:182::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 19:40:47 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:a03:94:cafe::60) by BYAPR01CA0071.outlook.office365.com
 (2603:10b6:a03:94::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35 via Frontend
 Transport; Wed, 10 Jul 2024 19:40:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Wed, 10 Jul 2024 19:40:46 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 14:40:45 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 14:40:45 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 10 Jul 2024 14:40:35 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Rodrigo
 Siqueira" <rodrigo.siqueira@amd.com>
Subject: [PATCH 47/50] drm/amd/display: Allow display DCC for DCN401
Date: Wed, 10 Jul 2024 15:37:04 -0400
Message-ID: <20240710193707.43754-48-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710193707.43754-1-Jerry.Zuo@amd.com>
References: <20240710193707.43754-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|LV8PR12MB9208:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a44ce86-3f40-4d03-4018-08dca1183224
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VwdfpDb93eOodkcA/3pTCtBCjo32tiEM2zwcS9KwNjn6dmmZfFyLAojUWvEI?=
 =?us-ascii?Q?Ax+tmzIJBJpUUxOwylEsu+08t7NBHFMNtV+ty2WnvS4Sh3obEnQZ4v4T23Zq?=
 =?us-ascii?Q?I88cB4y0mgKdCqdbnXs9kjgOBnJ+mRt1EOtYDz7e28eFYyC8CKnJ6SKI9lW9?=
 =?us-ascii?Q?o1YEBcHEQbxaWeDZZ0dgNgGbWV2jVcSoZ9Y/QtVHSSXV2mDGSjZbCT7suM/s?=
 =?us-ascii?Q?L6Opa6CsH73n64REVZOn11e9GJ412ZMVqY1eR2TR4P4NUG+mtznVKxIrT/o3?=
 =?us-ascii?Q?Mn9MszYRIQVP6prbk1kEHIYwB2AZ71RH9AV0oXIdYuo4dO4LqeeEtkCFg8Ww?=
 =?us-ascii?Q?+du2Xha1X++5YSIg+L8DBaKS4kmoSCqxaiUe5xL5rm1jYR5gNJZewX0Y3gl+?=
 =?us-ascii?Q?929G/t6SQa318Zmh/NpKh5cyZIcUP5IrXLxApmrTzUj/Ai3SNuacLw18g9tb?=
 =?us-ascii?Q?uBK5SvISL7B9SjJRFChwQnbtjVi7INZAjiJYyG60c4qG7lAoz1GSiOhQbYj4?=
 =?us-ascii?Q?WqOIYciTjmgLEf7aJIAXobnvUNozEbyrShXIRv8AnmBcc6GXCFeXMqYOvzU8?=
 =?us-ascii?Q?EEvVYWE5ESDDfL+0mI8azbldkVbvmqFwgDPxS1+MqJyeKk6oyHz0M8d+akPQ?=
 =?us-ascii?Q?K/YJJbcHOljSqFnDFSatlhhAfwfaMnL3zC3QM2EVre5ZewsojwG6Kdr2Mate?=
 =?us-ascii?Q?Px71ffmgSCqMIM9BemIKyNcufpbIMosDxkRpVACgRCTxc2imGBDr8NgQArWp?=
 =?us-ascii?Q?zm75fF0Pq58FHBvWRRNQPMsA8XuTW1cSt82F+ow1hgMmg3GeQgln0JOQqeyx?=
 =?us-ascii?Q?RKCYblIBL8/a3OuP2ARn4rPCfCkUiesTcyVD7tTZKD7d/SxY6XCuI68VEq4a?=
 =?us-ascii?Q?QrNnenqzSb0l3fOCOjCCXz/wBU7t+o47fLg7zTczGqH3bfTja3lIojO20yaO?=
 =?us-ascii?Q?yHygxpoUNaFwY7akVCA5jORSh8ZGiUXOeBZXgHonzPGGymXKzKv9Z87eZbT7?=
 =?us-ascii?Q?5GkwlrvSoKLZZPjGNB12mVVArhpj5M8g4BH3J7Cq+0h1Y8X2a4S4rYzrZtiE?=
 =?us-ascii?Q?OTUanHSpP++9TIri/7+eos7HI8zddyhQv3vuipF0cuvRjBh3lmKAzKogW+00?=
 =?us-ascii?Q?3imAOHk+TR5UOVrEMESE44wBEu0ShLoXIFgQlIdUHn52jmxK+PsZqs0Ga227?=
 =?us-ascii?Q?d7WoAbJx0lTRonZ4cf+qLW8rjBZ4IC98WnVzhqBsLyCrlbjhnQuAEHlKbRSq?=
 =?us-ascii?Q?7JddHaVUX61uFdH3yOgKnnw93w4nfYyekLvzXcIOjWATHv5Yt9sRMi9Lsxuk?=
 =?us-ascii?Q?P+94TGdQZxwt9dCOtu3rsSvRM2o+4z9wQOPsO4W/2Uso6NKdPxy2Jume8rmg?=
 =?us-ascii?Q?4iHO1F6ULEpjyptm339TaRN2fAx4QA1fjO+s5Xk3ucquUHrCCKlmLdbKPUwO?=
 =?us-ascii?Q?fXasA3fCohAzuRedBxPIwBbEz4U6445C?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 19:40:46.9791 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a44ce86-3f40-4d03-4018-08dca1183224
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9208
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

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

To enable mesa to use display dcc, DM should expose them in the
supported modifiers. Add the best (most efficient) modifiers first.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 29 ++++++++++++++++---
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 0320200dae94..dde4f1dda2e2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -689,12 +689,33 @@ static void amdgpu_dm_plane_add_gfx12_modifiers(struct amdgpu_device *adev,
 		      uint64_t **mods, uint64_t *size, uint64_t *capacity)
 {
 	uint64_t ver = AMD_FMT_MOD | AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX12);
+	uint64_t mod_256k = ver | AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX12_256K_2D);
+	uint64_t mod_64k = ver | AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX12_64K_2D);
+	uint64_t mod_4k = ver | AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX12_4K_2D);
+	uint64_t mod_256b = ver | AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX12_256B_2D);
+	uint64_t dcc = ver | AMD_FMT_MOD_SET(DCC, 1);
+	uint8_t max_comp_block[] = {1, 0};
+	uint64_t max_comp_block_mod[2] = {0};
+	uint8_t i = 0;
+
+	/* With DCC: Best choice should be kept first. Hence, add all 256k modifiers of different
+	 * max compressed blocks first and then move on to the next smaller sized layouts */
+	for (i = 0; i < 2; i++)
+		max_comp_block_mod[i] = AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, max_comp_block[i]);
+	for (i = 0; i < 2; i++)
+		amdgpu_dm_plane_add_modifier(mods, size, capacity, ver | dcc | max_comp_block_mod[i] | mod_256k);
+	for (i = 0; i < 2; i++)
+		amdgpu_dm_plane_add_modifier(mods, size, capacity, ver | dcc | max_comp_block_mod[i] | mod_64k);
+	for (i = 0; i < 2; i++)
+		amdgpu_dm_plane_add_modifier(mods, size, capacity, ver | dcc | max_comp_block_mod[i] | mod_4k);
+	for (i = 0; i < 2; i++)
+		amdgpu_dm_plane_add_modifier(mods, size, capacity, ver | dcc | max_comp_block_mod[i] | mod_256b);
 
 	/* Without DCC: */
-	amdgpu_dm_plane_add_modifier(mods, size, capacity, ver | AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX12_256K_2D));
-	amdgpu_dm_plane_add_modifier(mods, size, capacity, ver | AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX12_64K_2D));
-	amdgpu_dm_plane_add_modifier(mods, size, capacity, ver | AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX12_4K_2D));
-	amdgpu_dm_plane_add_modifier(mods, size, capacity, ver | AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX12_256B_2D));
+	amdgpu_dm_plane_add_modifier(mods, size, capacity, ver | mod_256k);
+	amdgpu_dm_plane_add_modifier(mods, size, capacity, ver | mod_64k);
+	amdgpu_dm_plane_add_modifier(mods, size, capacity, ver | mod_4k);
+	amdgpu_dm_plane_add_modifier(mods, size, capacity, ver | mod_256b);
 	amdgpu_dm_plane_add_modifier(mods, size, capacity, DRM_FORMAT_MOD_LINEAR);
 }
 
-- 
2.34.1

