Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BB2EC3271E
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jul 2024 16:06:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01E1D10E392;
	Mon,  8 Jul 2024 16:06:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eQGzQYN+";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 276FD10E032
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jul 2024 16:06:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bPlBiuQsYoFsv6IQfVIoL59PhMB1TI1PZs1Gkwh/FnFqQifjelNm4v0e6dgetFy0WCWxvWXUB0TyUQmcF0UBE9BdnWk8phDdkEmh7ojHxXeUFboHF1r3TEKdV6CFoZagBiPtZAjGbs/3n+8CeVk6PeLZk8etRo3JvsuR017lHJFCMKXBOwrBfeZmBxSv+bzFdw8eXiKdkQMN+smzgNl7EjHEoCs+U6HNNPvlA+mf2v7twxoCF6y2t80e8EAX/xAjLKamI5jtnXMVfnX8ZganacYE4x4isiXZsgyOQtiIeXQimYGwMpRhOjEhf3uAPQyKSFt/JPUUXxQKYpqM/yIurQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3FCYbIeRnLItPO0ei/dlo++Ocz6utKXnvU8kQHyJxBQ=;
 b=n4NbHGmg5rV0z/Ew/2OpyWEvROjIA7xt+yXyR93OEdCk1FBfLk4w/2T6kYZ2+ooBcJTIyw95bv1bEa0R/W6OBobWzSz1GT7GcdjpoIcUNBdH3vC/SeHgtw9X6DW4hs37y/613Mr+7IYbmfX/7SlmBEtmsZvbl/vLkUZ1cmEEwjUbmDY+6Rs9Qsyn/eOlbYjtfGaGs47ifdh1eTx5Z2469GNjtWlIGP0NW40H/EZz/nUX6dVSxn5vDVxmUcpfNhSpo/9zoxi2fFyvTkDZacmH6sP4oWLbFHQPlaqaZ6GYQv9eP+lqnzhqWPYx4Td+7XGPh/gb2Sy4ztJx7Nqck2C+Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3FCYbIeRnLItPO0ei/dlo++Ocz6utKXnvU8kQHyJxBQ=;
 b=eQGzQYN+ZWqQ2x7hE2FYGozsAO4Z9lkYQskII1bEarNt3JTKyJv5yqQoEOFMlwrKvmxU6MIhacT3bIr5lgMnm5r0StcY2BfqnnTx7/MiYx+7jCfNvWwhyMHWqyzRxirUxwkngzxoSfBCdW+Kgclh48tVGZzDG7kd3cTXT4GIqzU=
Received: from SJ0PR13CA0120.namprd13.prod.outlook.com (2603:10b6:a03:2c5::35)
 by SJ0PR12MB8089.namprd12.prod.outlook.com (2603:10b6:a03:4eb::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 16:06:16 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::a0) by SJ0PR13CA0120.outlook.office365.com
 (2603:10b6:a03:2c5::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.19 via Frontend
 Transport; Mon, 8 Jul 2024 16:06:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Mon, 8 Jul 2024 16:06:15 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 8 Jul
 2024 11:06:11 -0500
Received: from aaurabin-suse.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 8 Jul 2024 11:06:10 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <rodrigo.siqueira@amd.com>, <marek.olsak@amd.com>,
 <harry.wentland@amd.com>, <alexdeucher@gmail.com>, <aurabindo.pillai@amd.com>
Subject: [PATCH] drm/amd/display: Allow display DCC for DCN401
Date: Mon, 8 Jul 2024 12:06:10 -0400
Message-ID: <20240708160610.1354015-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|SJ0PR12MB8089:EE_
X-MS-Office365-Filtering-Correlation-Id: cc635b92-1a87-40d9-7d4e-08dc9f67e57d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gSEINgqXm22byuF5BvXELgPEsGUVtBuQ/BtxAWPre8KjHY3t38U4IfGe3dYP?=
 =?us-ascii?Q?xhgm7lGFHDM0TQVcWQCIbrL3py5bD0+IVkY8Ya1XEfFKyUEFkOmmC2qykjjz?=
 =?us-ascii?Q?v14KLxV+7axS1QdZ4HmHLsXcphkwi4MODYdXxGyiW2nRR8gn/rsSMVbd5McT?=
 =?us-ascii?Q?BC7HfZeIBuQGkRs6eWISZ1djDC9GBsjQoSbE7kZzPNz3OrQRDcb40tNxBx73?=
 =?us-ascii?Q?l2ZHQuO8azhjanL4CHHAJY6ecK6Cp/8fL3hmPQR6o0AUxEPuuMLAT/cE60SX?=
 =?us-ascii?Q?1iCE3WIJqxmVTnEBSvJfDVa9d0lqAG1gSPzPIFNUXkpaN9R0+LCju0VAoJ1P?=
 =?us-ascii?Q?t2KvVouemmZ4AtgGzvzDf/wi+3wzPcBaJv2hOpu/A1jcmn/59zX660KIiaVq?=
 =?us-ascii?Q?qmy4Xbl9HAkpeGxvkhCX8kpbR6AfbWb9pHADWQMRyOxCkshdWmehdaKmev61?=
 =?us-ascii?Q?2AjJGpjYJVjTo7vMa0T88Z64ufkg8wPFOlaaEbVz/kXCLcZ3SpOKEWnL6zYy?=
 =?us-ascii?Q?QSrvfykHMCfg9QgiKuQpiXWli4CC6Q2Z+94Cwhy5//MyuAfjyDuwFgzQPvoh?=
 =?us-ascii?Q?9V7fDeqkFmsI90gmIakN7amytA4OmFtsmYH1DG1sUHjKEe0nUrsNjThJB2B1?=
 =?us-ascii?Q?87VnZvnDltoCrbz3OIrIkBqKh7+wMk6CqoHmSC9TtKbeTkbxe01b34yMMm2O?=
 =?us-ascii?Q?ciE9MaGTLTqurIePJlYppw1H58TDdjWHZZu4HapTKeJNYM1qHgB87oFwueLR?=
 =?us-ascii?Q?JQ3vcOyTQ3fbN+Qi40W1YU3EN/HSeZJNoBJuc5shKy+L9mth5osIq9pDqY5X?=
 =?us-ascii?Q?1Ej8gvbqvIurFel8skj9zEb/Kb108g1yHQhmmwDMsn7NPk0CriApCwa5c5BD?=
 =?us-ascii?Q?fxVxbYkHJ8N1jOzKP+6vsyAiZTEk8bmicB2x4Zux/J1VY3PcW/PaHM91pYIK?=
 =?us-ascii?Q?x5t6mb3fxjQVVYaZsqK7fETRs5goykhV8TTLyzWt8shw8p4Ji3YjINdujzno?=
 =?us-ascii?Q?VDCVdny88KHjpoZEhwU6xQrO/ofYtgFC9lJt9aFTWrnD9Xa2Q5Q9qhgVs78y?=
 =?us-ascii?Q?212HWokGE7Mh2jVqs7BoY2HSsr+Eha4ZRie0IommLx3aMaxaIlYnVhWT8hxk?=
 =?us-ascii?Q?N68iUDIBxU3anzSS1ZEkK27zpSOOnThyJZGFcYD4X0qz9C/+8K/BtZBs5cSs?=
 =?us-ascii?Q?R++XFk1e1DWgTMwgVOW4LoY5OBr3FwTL/vdqB181SPDE4H5DOHgtogv5G3Hs?=
 =?us-ascii?Q?A9UrmljDSTHaQeYp4f7CRxqxsEBRfUcjGNtUpacXWBvdWnSrGa5fiMsPm+U8?=
 =?us-ascii?Q?T168LrIRG8va+r3Y3ryasM0oBGbRnoIZWWI9gnGKT+okZd8bjNlHmUHIa0Nt?=
 =?us-ascii?Q?YxTJFo7JRlD2CFDxNX0k/sFcEqONhUJm0929yTBbHqr1CNdt6bQgRNqwTHz6?=
 =?us-ascii?Q?n/aIyrphXzB8Lggyvekm/vT5eYrgBsaM?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 16:06:15.8078 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc635b92-1a87-40d9-7d4e-08dc9f67e57d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8089
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

To enable mesa to use display dcc, DM should expose them in the
supported modifiers. Add the best (most efficient) modifiers first.

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 31 +++++++++++++++----
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 0320200dae94..a83bd0331c3b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -689,13 +689,32 @@ static void amdgpu_dm_plane_add_gfx12_modifiers(struct amdgpu_device *adev,
 		      uint64_t **mods, uint64_t *size, uint64_t *capacity)
 {
 	uint64_t ver = AMD_FMT_MOD | AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX12);
+	uint64_t mod_256k = ver | AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX12_256K_2D);
+	uint64_t mod_64k = ver | AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX12_64K_2D);
+	uint64_t mod_4k = ver | AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX12_4K_2D);
+	uint64_t mod_256b = ver | AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX12_256B_2D);
+	uint64_t dcc = ver | AMD_FMT_MOD_SET(DCC, 1);
+	uint8_t max_comp_block[] = {1, 0};
+	uint64_t max_comp_block_mod[ARRAY_SIZE(max_comp_block)] = {0};
+	uint8_t i = 0, j = 0;
+	uint64_t gfx12_modifiers[] = {mod_256k, mod_64k, mod_4k, mod_256b, DRM_FORMAT_MOD_LINEAR};
+
+	for (i = 0; i < ARRAY_SIZE(max_comp_block); i++)
+		max_comp_block_mod[i] = AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, max_comp_block[i]);
+
+	/* With DCC: Best choice should be kept first. Hence, add all 256k modifiers of different
+	 * max compressed blocks first and then move on to the next smaller sized layouts.
+	 * Do not add the linear modifier here, and hence the condition of size-1 for the loop
+	 */
+	for (j = 0; j < ARRAY_SIZE(gfx12_modifiers) - 1; j++)
+		for (i = 0; i < ARRAY_SIZE(max_comp_block); i++)
+			amdgpu_dm_plane_add_modifier(mods, size, capacity,
+						     ver | dcc | max_comp_block_mod[i] | gfx12_modifiers[j]);
+
+	/* Without DCC. Add all modifiers including linear at the end */
+	for (i = 0; i < ARRAY_SIZE(gfx12_modifiers); i++)
+		amdgpu_dm_plane_add_modifier(mods, size, capacity, gfx12_modifiers[i]);
 
-	/* Without DCC: */
-	amdgpu_dm_plane_add_modifier(mods, size, capacity, ver | AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX12_256K_2D));
-	amdgpu_dm_plane_add_modifier(mods, size, capacity, ver | AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX12_64K_2D));
-	amdgpu_dm_plane_add_modifier(mods, size, capacity, ver | AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX12_4K_2D));
-	amdgpu_dm_plane_add_modifier(mods, size, capacity, ver | AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX12_256B_2D));
-	amdgpu_dm_plane_add_modifier(mods, size, capacity, DRM_FORMAT_MOD_LINEAR);
 }
 
 static int amdgpu_dm_plane_get_plane_modifiers(struct amdgpu_device *adev, unsigned int plane_type, uint64_t **mods)
-- 
2.45.2

