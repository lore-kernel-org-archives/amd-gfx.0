Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B361C3DA45
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jul 2024 19:41:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2C9A10E8CF;
	Wed, 10 Jul 2024 19:41:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JR5zXsN2";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B4B810E8CE
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 19:41:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n8X8W/IxRJdEEiBfE7mwEbtAAB99AFMEQJIty4gpbolsuLsyNQer+6BlrJhIxCPlcFMU14dNe09TDeTALhT4vB4Kd5+kVDvUNOli6yFYqHUGOiDM/IicCk9kmiqEm7L9Zh7zGqd8lJo4pEroKPzpzVI63nJbuT1CwMvn4HN153EVCtDqmUO7673AIyCFGQ36rNq6QMmGiC+0JQ7G7nU04JlgKHb85Pdb6usJtYe8GaRnDHz+4Fgzr4+HL5rF+CtYzoPKOYRDd+67ivtVZp2wh0Q3Ic0kRyQ60WqQtc9KuH0NM1nDdSuAw669xaPzXlyp8UM54MG7FrUMzP9Dm/PLmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dYK3WiQmZKJ0ygA2uWvXIpw8nyKTfCINKu55g9CrRmc=;
 b=KzIRtz1qufcAd3BR5xxfNuj6JUC2a+oNLMMJz6UCJrk88u2YR18/vEfAkSVuAM5S82rm5W38WhZtxtQHbScxsRWWP2t7QNzhY/pSpZ0/ezyV1uYhkhliQGxeIjU3m9x8n/rcEGmbIai05UMqgy+P5IjI7X7of3XO7n6lku7zqHqxnl32mJw8fwwTEsKbEjph/ZC286G3LI0TSU+hEI2pl2GGB8uHD+h4Vm/xVhGXy/Acz9hSd3TKMreryGhluMUPu6zkJgcYsZ+kcwghtEdUOHCuyfR6AErwu44AUBGDQ4eOcHyLbtW9et5W1RVmGz86dGCn0gLmzP7L6PifuHbZDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dYK3WiQmZKJ0ygA2uWvXIpw8nyKTfCINKu55g9CrRmc=;
 b=JR5zXsN2GvmEMJ4o2prtw31eIRQh/ZFSgRwNq1l4Wyrp8UnmobIfzWMAMWjE08Nny/bKVugkup7ZE29jNCpUNqKctUHmwF2ybymUe10LreXps02XrgA3At9gJJl144fYJg9TY58G4xLPMCInWArQMylxJyM+rqHgt8yw/KpQVek=
Received: from PH7P220CA0107.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::13)
 by DM4PR12MB6301.namprd12.prod.outlook.com (2603:10b6:8:a5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.34; Wed, 10 Jul
 2024 19:40:54 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:510:32d:cafe::85) by PH7P220CA0107.outlook.office365.com
 (2603:10b6:510:32d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20 via Frontend
 Transport; Wed, 10 Jul 2024 19:40:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Wed, 10 Jul 2024 19:40:54 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 14:40:53 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 14:40:52 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 10 Jul 2024 14:40:47 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>
Subject: [PATCH 48/50] drm/amd/display: improve logic for addition of modifers
Date: Wed, 10 Jul 2024 15:37:05 -0400
Message-ID: <20240710193707.43754-49-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710193707.43754-1-Jerry.Zuo@amd.com>
References: <20240710193707.43754-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|DM4PR12MB6301:EE_
X-MS-Office365-Filtering-Correlation-Id: ddec20f2-7f20-4132-3baa-08dca118366e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3EgS+zU3jz1Du40jluuTyPSTkYrBS/eRNCTscPEDFFzJ5OlMe0Z+SD9n6OsQ?=
 =?us-ascii?Q?/JwF/mBqBDzNYUOk2v20VB8Rpjq/Osjpc2MPCgN68+vDe8AFAewGAofpmsN2?=
 =?us-ascii?Q?Z+Ko5A4neoQ3pCLS4mbndM9ihtsXkaoFjAfszxtr4jxlQfNlE51ekeuy7fFy?=
 =?us-ascii?Q?XAth1B+MtUmmpzq54FRgw3BN/aTvKIiR4mS8H2uuio2eCzTs6F8G52Q9eLyU?=
 =?us-ascii?Q?KCw01f2Wpsm1IvEA/MzdkZGD/F6RTrQyZrLBGERGv8bf4v2sF4g1Z6TG09+v?=
 =?us-ascii?Q?WRAVx9ewiH6TBEwGAS8hry/0609+r+tXWOeg8+TBcSOEI9y0oSBSE15jpbUg?=
 =?us-ascii?Q?JHdd2KA+/hZ1rrH6oql+bCS52MauSo57qyK4sh/fEhTmLCHPRpWukAepDmp+?=
 =?us-ascii?Q?JoKSEvwZBK0VEEtngyZ35VRL4lUegvs06F1JvRJhFxPW1y+V1rzvTEnYqZ4X?=
 =?us-ascii?Q?PLJlP4sdh6U5LukV7Gi48e95KrDaQdtS08aiZLX1iU2tdeOoQ3r4uLNWkXFW?=
 =?us-ascii?Q?l9CG023brJ8hC2dpIkWjpRdBuojwqD5ZcjuBUtiavK+Y9/XPK857j1cKbQ9t?=
 =?us-ascii?Q?0mAUZIyOx6SpTGAQLsLk2Pf2Rl25vVtzCA8sPC+iwomAM/rncjrIxUCYVG7s?=
 =?us-ascii?Q?MR2/fA2O2f/xykl+5QLWzgVrTKqiaavYdZ9C+zeQRHtWkoqzNw/Tn5EDVOu5?=
 =?us-ascii?Q?EgzMfj+hG0SRb+SqDJKVtdQquT0SlviNJRMPcttDHMocWvWWixG05X+fCHoy?=
 =?us-ascii?Q?jXLKpg3TXo8tkpnDluPRIzCLbOHyNyN3ESfgnThJ/LIZpF/vMu2XdEoVZcDg?=
 =?us-ascii?Q?bnhZWhIYCn9H/KdeKdNqjNtjO68xkoXn5/mv/gGQUMt5OsejdQfRXQInQ/Wb?=
 =?us-ascii?Q?mgoZng39I0PO/wiU65KBf75RTSgL4v0hmcoZnDgmwFXT1qhET62lseIegB8s?=
 =?us-ascii?Q?ZZHEZIarhNIsu3HZMKqgkSzK0JmX8O0SNkIsmBW0ChMOauDr3rwhB0Aogxsh?=
 =?us-ascii?Q?H+rA7+SNrJbyd2XNIYwOaehn9xKsH7+1LAEeA42co5NC3Esh3W/sgu2RiCSW?=
 =?us-ascii?Q?9MjjDXcvN+yqr8gbK2vGkH15m3eXYr1JoE2QdXQbHXidyUeKx3IiuyOnAw3L?=
 =?us-ascii?Q?2u6eGkU8g7o9H07FXMm8tyPki4x9dtYrcv/lvqdkPyLzBhT1pLrtvj+YbNRj?=
 =?us-ascii?Q?ksEtbCce6iHOmW8lzq94iTe2cl8Qx/TUHClstp9/tnF3RZbOIqnV6neBBLJ+?=
 =?us-ascii?Q?o67xRn1ZTXP8EoNtlCA9pXjzsFyghLEZkT3QFtoL9X7xfPwV2Y6co9pggkbc?=
 =?us-ascii?Q?r5sMHN6eEAPnFLTCx1zrlwpaUmO8cT4RBoaPSDR7SPJqiCo76jdDyl4PdA5X?=
 =?us-ascii?Q?KTEyMw7zMefOL5NGXSsaF9D+gSJWJwClnf4bAThR2F9T+XOYi7uorRzu03vg?=
 =?us-ascii?Q?kkuiiIedKurvljUqBtha2D4OH6gCTI2D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 19:40:54.1748 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddec20f2-7f20-4132-3baa-08dca118366e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6301
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

Use an extra for loop to reduce duplicate code for adding modifiers

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 36 +++++++++----------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index dde4f1dda2e2..dc16d82aced4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -695,28 +695,26 @@ static void amdgpu_dm_plane_add_gfx12_modifiers(struct amdgpu_device *adev,
 	uint64_t mod_256b = ver | AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX12_256B_2D);
 	uint64_t dcc = ver | AMD_FMT_MOD_SET(DCC, 1);
 	uint8_t max_comp_block[] = {1, 0};
-	uint64_t max_comp_block_mod[2] = {0};
-	uint8_t i = 0;
+	uint64_t max_comp_block_mod[ARRAY_SIZE(max_comp_block)] = {0};
+	uint8_t i = 0, j = 0;
+	uint64_t gfx12_modifiers[] = {mod_256k, mod_64k, mod_4k, mod_256b, DRM_FORMAT_MOD_LINEAR};
 
-	/* With DCC: Best choice should be kept first. Hence, add all 256k modifiers of different
-	 * max compressed blocks first and then move on to the next smaller sized layouts */
 	for (i = 0; i < 2; i++)
 		max_comp_block_mod[i] = AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, max_comp_block[i]);
-	for (i = 0; i < 2; i++)
-		amdgpu_dm_plane_add_modifier(mods, size, capacity, ver | dcc | max_comp_block_mod[i] | mod_256k);
-	for (i = 0; i < 2; i++)
-		amdgpu_dm_plane_add_modifier(mods, size, capacity, ver | dcc | max_comp_block_mod[i] | mod_64k);
-	for (i = 0; i < 2; i++)
-		amdgpu_dm_plane_add_modifier(mods, size, capacity, ver | dcc | max_comp_block_mod[i] | mod_4k);
-	for (i = 0; i < 2; i++)
-		amdgpu_dm_plane_add_modifier(mods, size, capacity, ver | dcc | max_comp_block_mod[i] | mod_256b);
-
-	/* Without DCC: */
-	amdgpu_dm_plane_add_modifier(mods, size, capacity, ver | mod_256k);
-	amdgpu_dm_plane_add_modifier(mods, size, capacity, ver | mod_64k);
-	amdgpu_dm_plane_add_modifier(mods, size, capacity, ver | mod_4k);
-	amdgpu_dm_plane_add_modifier(mods, size, capacity, ver | mod_256b);
-	amdgpu_dm_plane_add_modifier(mods, size, capacity, DRM_FORMAT_MOD_LINEAR);
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
+
 }
 
 static int amdgpu_dm_plane_get_plane_modifiers(struct amdgpu_device *adev, unsigned int plane_type, uint64_t **mods)
-- 
2.34.1

