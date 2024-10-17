Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BE01D37485
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Oct 2024 13:21:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A66F10E828;
	Thu, 17 Oct 2024 13:21:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lIfA4+qy";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6111010E827
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Oct 2024 13:21:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KkhIRGJiJKLguQQK4S2jBMlHnV/GQLX69iqZEdElLE5QBc9qOhMEu0lzhVMU66j130uy1kfgOyGhwcGdbD24eNbA8+Gh/Zt1uN0mNIlYtR8Z9NgPO2emVKDKj6Qez7KVdn3JgLRYX12arRtJTvT5R7/nub+zWWUYbZmDqP3tNMNF7Gd+sC/a51dVTKvS41h73190HR/SLGpqNsQ2horSmJ5fugleRrmVWHLo/eOu+9ZH2vyF8tH4UuYNtxvH8vWPWL89B06h/T8FlxZcGo47aPdAGwcThRwgPtdFlh3pyozYzeKLeO3yTb/qFVCByV+oytHOpvLkAMJv7pseqkl1Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oqI4nDVwjq9AdzBO1NoWgfmO8ILww9NydcnjscehSvY=;
 b=oPHbC2Z0Kunra/yNzth+BZIE0AF9lghrOlvgykpeI2AUO+5j/SgRrOwx0Ntk/2DA0F+9t/xrLkwrLv4nGG/XybX3mojZnSVp3qHeUA1miav5/wHKI0kFTqSTzIfVBwagqjONWfa+uPdVZ4iOHntuZI/CVN+x9xkRnqgGc9hhqDF9DTpwa4somu7nZ5w98IlMLPkuZqRTkZs+yMtImXgkMBabrNLNqvODsygtiwyIu4LzXreFqIsDqABqFzQ2VlbCRnavG2sZe3bdIMUwN5GsPik3V0svr4Jve4/+XG8AjNZUgppxHvNXmZrZomOiwfDcyEJRrpCIdZY8IP6euCwsGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oqI4nDVwjq9AdzBO1NoWgfmO8ILww9NydcnjscehSvY=;
 b=lIfA4+qylr+rY6kBxtixLBv5vEr75ft92LY0Tt8suvoUlSysFrCfhx6udBjaRjmsEoExc2yuY0Z4opt9B8PfXfhgCYat2NXhCaev9TjyvLwppq+KMX7TjhI/5A6B16kqSpCdqYeguFQWY8zvOE5zOxOxkhR8svCMhAMdJVHdGlE=
Received: from BN9PR03CA0470.namprd03.prod.outlook.com (2603:10b6:408:139::25)
 by DM4PR12MB7573.namprd12.prod.outlook.com (2603:10b6:8:10f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Thu, 17 Oct
 2024 13:21:37 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com
 (2603:10b6:408:139:cafe::89) by BN9PR03CA0470.outlook.office365.com
 (2603:10b6:408:139::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18 via Frontend
 Transport; Thu, 17 Oct 2024 13:21:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 13:21:36 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 08:21:33 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 29/32] drm/amdgpu: dump_ip_state for each vcn instance
Date: Thu, 17 Oct 2024 09:20:50 -0400
Message-ID: <20241017132053.53214-30-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017132053.53214-1-boyuan.zhang@amd.com>
References: <20241017132053.53214-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|DM4PR12MB7573:EE_
X-MS-Office365-Filtering-Correlation-Id: cc6d460f-bf8c-4325-eee9-08dceeaea09e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Sd/Js5wxWY4OBkT0R9RdMCQMFlrpNEZRZnM2xTJD/GJRYsPyfb20DIBBJvJn?=
 =?us-ascii?Q?1WP7BnvFko0JdPtolyEDF/2eVFm0rfDjJjEAYTcPiIA1wF6COmLmIvcoPmR/?=
 =?us-ascii?Q?3V2ySQHzbizK1czzyD4rxyJV3Q2w3G7B4RAHWxWV1a1+q7NuhYagkLHMv9i9?=
 =?us-ascii?Q?BD3geDfx8A/LsJuNeSp381vlAx0D1zqs1KcKgyX2WvSalzXE4Nt7f+albueJ?=
 =?us-ascii?Q?rmOQ/Fv8BLFEL0suSSNLgoTOshi4yBlGHMLEzUlG5cpJNqqZE4+6LKBsMGSc?=
 =?us-ascii?Q?Cwf2hGzddWewi4XxmthLakPiMe+JPQwwBpG9A0RIuYvw149i/9Pux7IN9M5z?=
 =?us-ascii?Q?PtMTF+OyMjui1iQ99Bi897Hc40owmbzsg1mtplUTzZp405pyTkpA6DXhT5cy?=
 =?us-ascii?Q?iXqm4Q5sY//FFOeJF6MC3fAzbJI7m6stwjxPFVcPeE41DhsY6OU3cfmXM89U?=
 =?us-ascii?Q?Kulke7RJt8AAK9lMaEbsc5BLqwKDTQ19roy6BxZq3WWIN0t+AwfGYsfIeInT?=
 =?us-ascii?Q?H2ISAaASZD8IQ1zELRAJFHJ7vUCJz+DdYp/jFWHqZchnBflb+qPAfwZsVpdJ?=
 =?us-ascii?Q?u366tpEjd4fuja1pq7g5CLC39j7+Vxz6P8XsgmzneGug90QZva47MR3mKvOx?=
 =?us-ascii?Q?xSD6GXL0ca6tjiOhMmXYoXqkZyM7ge31X8R8khElR3S0+71HWwzqwi0MumnP?=
 =?us-ascii?Q?DNqMvYiAnbzdypZPlBRkVMzkjF8jq5HS9T56iQsZEW/veVHZMMa5c+TpCvtE?=
 =?us-ascii?Q?6CeLY5j0qbRmCvqONmajpw11jHEJcEkrgdBNeMZK0yT/FT0BUQqm8f0kEURa?=
 =?us-ascii?Q?Pnum6P2UA6RBn3J/BTVFz+WUII80nWetH/TQUU1JH5JUaissGj2YwT/dfX7d?=
 =?us-ascii?Q?Zjef/3teqGraC6jw1MpZ5VE6X8woknpzcjc54mzj/HBMPPKQX0/uTwhTFm6j?=
 =?us-ascii?Q?AAsSxB9mEfZ3ahThk7oJYpV2qXmG1lx1r02yHAmoKUTRUsPdgXH769WdDQld?=
 =?us-ascii?Q?RtPu0P+cKjYR3ObjkBPD/Rm4GQFg9Q2ajsVyvdWGFtqhk/R4hvUqK+6VADte?=
 =?us-ascii?Q?ikgYyKlaAqTH5sB8DlZ2orIL0uGwEs+ZDtN/1TN0vFjGZpRUBJnYmn5y/E7j?=
 =?us-ascii?Q?Nv1HJ44iRFvOPvhLizg5ekQnfGWCmzSNrAHhGzENSxw1Z6jNM1NTSm4VzQiO?=
 =?us-ascii?Q?rfvs0fDl6ThLklfRHa8dWT6X1IhimMhJTheGAEeOod8R9NaYDt1bZ/Xq2Eop?=
 =?us-ascii?Q?jP7NH+De4b0k5W1pG271TmpITS8CmJJb3g0+o4nflISyvBC2VcxXoilOl5wP?=
 =?us-ascii?Q?4TUxFXEcwp8GyU4yZW5Nl9exnSexcSL0bqVaePO2s6BbfLXgETEOxrJPC5bl?=
 =?us-ascii?Q?YI1Zp4RI5d/qPyVnR8MAJQTjbJHOw84mdliE7h4eVgnjpZUOGA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 13:21:36.5633 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc6d460f-bf8c-4325-eee9-08dceeaea09e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7573
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

From: Boyuan Zhang <boyuan.zhang@amd.com>

Perform dump_ip_state only for the instance of the current vcn IP block,
instead of perform it for all vcn instances.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   | 27 +++++++++----------
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   | 27 +++++++++----------
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 27 +++++++++----------
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 27 +++++++++----------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 31 +++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 35 ++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 31 +++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 27 +++++++++----------
 8 files changed, 112 insertions(+), 120 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 9255bcfc6c3d..27e0f206c9dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -1964,7 +1964,8 @@ static void vcn_v1_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm
 static void vcn_v1_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int i, j;
+	int inst = ip_block->instance;
+	int j;
 	bool is_powered;
 	uint32_t inst_off;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_1_0);
@@ -1972,21 +1973,19 @@ static void vcn_v1_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
 	if (!adev->vcn.ip_dump)
 		return;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return;
 
-		inst_off = i * reg_count;
-		/* mmUVD_POWER_STATUS is always readable and is first element of the array */
-		adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, i, mmUVD_POWER_STATUS);
-		is_powered = (adev->vcn.ip_dump[inst_off] &
-				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
+	inst_off = inst * reg_count;
+	/* mmUVD_POWER_STATUS is always readable and is first element of the array */
+	adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, inst, mmUVD_POWER_STATUS);
+	is_powered = (adev->vcn.ip_dump[inst_off] &
+			UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
 
-		if (is_powered)
-			for (j = 1; j < reg_count; j++)
-				adev->vcn.ip_dump[inst_off + j] =
-					RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_1_0[j], i));
-	}
+	if (is_powered)
+		for (j = 1; j < reg_count; j++)
+			adev->vcn.ip_dump[inst_off + j] =
+				RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_1_0[j], inst));
 }
 
 static const struct amd_ip_funcs vcn_v1_0_ip_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 94f000ed4895..665b749c5ac0 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -2072,7 +2072,8 @@ static void vcn_v2_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm
 static void vcn_v2_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int i, j;
+	int inst = ip_block->instance;
+	int j;
 	bool is_powered;
 	uint32_t inst_off;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_2_0);
@@ -2080,21 +2081,19 @@ static void vcn_v2_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
 	if (!adev->vcn.ip_dump)
 		return;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return;
 
-		inst_off = i * reg_count;
-		/* mmUVD_POWER_STATUS is always readable and is first element of the array */
-		adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, i, mmUVD_POWER_STATUS);
-		is_powered = (adev->vcn.ip_dump[inst_off] &
-				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
+	inst_off = inst * reg_count;
+	/* mmUVD_POWER_STATUS is always readable and is first element of the array */
+	adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, inst, mmUVD_POWER_STATUS);
+	is_powered = (adev->vcn.ip_dump[inst_off] &
+			UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
 
-		if (is_powered)
-			for (j = 1; j < reg_count; j++)
-				adev->vcn.ip_dump[inst_off + j] =
-					RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_2_0[j], i));
-	}
+	if (is_powered)
+		for (j = 1; j < reg_count; j++)
+			adev->vcn.ip_dump[inst_off + j] =
+				RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_2_0[j], inst));
 }
 
 static const struct amd_ip_funcs vcn_v2_0_ip_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 7c9a0169215e..5332b2903ce1 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -1946,7 +1946,8 @@ static void vcn_v2_5_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm
 static void vcn_v2_5_dump_ip_state(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int i, j;
+	int inst = ip_block->instance;
+	int j;
 	bool is_powered;
 	uint32_t inst_off;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_2_5);
@@ -1954,21 +1955,19 @@ static void vcn_v2_5_dump_ip_state(struct amdgpu_ip_block *ip_block)
 	if (!adev->vcn.ip_dump)
 		return;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return;
 
-		inst_off = i * reg_count;
-		/* mmUVD_POWER_STATUS is always readable and is first element of the array */
-		adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, i, mmUVD_POWER_STATUS);
-		is_powered = (adev->vcn.ip_dump[inst_off] &
-				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
+	inst_off = inst * reg_count;
+	/* mmUVD_POWER_STATUS is always readable and is first element of the array */
+	adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, inst, mmUVD_POWER_STATUS);
+	is_powered = (adev->vcn.ip_dump[inst_off] &
+			UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
 
-		if (is_powered)
-			for (j = 1; j < reg_count; j++)
-				adev->vcn.ip_dump[inst_off + j] =
-					RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_2_5[j], i));
-	}
+	if (is_powered)
+		for (j = 1; j < reg_count; j++)
+			adev->vcn.ip_dump[inst_off + j] =
+				RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_2_5[j], inst));
 }
 
 static const struct amd_ip_funcs vcn_v2_5_ip_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 061c958700d8..40a3d29d4e71 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -2269,7 +2269,8 @@ static void vcn_v3_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm
 static void vcn_v3_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int i, j;
+	int inst = ip_block->instance;
+	int j;
 	bool is_powered;
 	uint32_t inst_off;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_3_0);
@@ -2277,21 +2278,19 @@ static void vcn_v3_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
 	if (!adev->vcn.ip_dump)
 		return;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return;
 
-		inst_off = i * reg_count;
-		/* mmUVD_POWER_STATUS is always readable and is first element of the array */
-		adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, i, mmUVD_POWER_STATUS);
-		is_powered = (adev->vcn.ip_dump[inst_off] &
-			      UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
+	inst_off = inst * reg_count;
+	/* mmUVD_POWER_STATUS is always readable and is first element of the array */
+	adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, inst, mmUVD_POWER_STATUS);
+	is_powered = (adev->vcn.ip_dump[inst_off] &
+			  UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
 
-		if (is_powered)
-			for (j = 1; j < reg_count; j++)
-				adev->vcn.ip_dump[inst_off + j] =
-					RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_3_0[j], i));
-	}
+	if (is_powered)
+		for (j = 1; j < reg_count; j++)
+			adev->vcn.ip_dump[inst_off + j] =
+				RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_3_0[j], inst));
 }
 
 static const struct amd_ip_funcs vcn_v3_0_ip_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index fdf346bf3e34..3b2f4f1e0939 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -2177,7 +2177,8 @@ static void vcn_v4_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm
 static void vcn_v4_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int i, j;
+	int inst = ip_block->instance;
+	int j;
 	bool is_powered;
 	uint32_t inst_off;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0);
@@ -2185,22 +2186,20 @@ static void vcn_v4_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
 	if (!adev->vcn.ip_dump)
 		return;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return;
 
-		inst_off = i * reg_count;
-		/* mmUVD_POWER_STATUS is always readable and is first element of the array */
-		adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, i, regUVD_POWER_STATUS);
-		is_powered = (adev->vcn.ip_dump[inst_off] &
-				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
-
-		if (is_powered)
-			for (j = 1; j < reg_count; j++)
-				adev->vcn.ip_dump[inst_off + j] =
-					RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_4_0[j],
-									   i));
-	}
+	inst_off = inst * reg_count;
+	/* mmUVD_POWER_STATUS is always readable and is first element of the array */
+	adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, inst, regUVD_POWER_STATUS);
+	is_powered = (adev->vcn.ip_dump[inst_off] &
+			UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
+
+	if (is_powered)
+		for (j = 1; j < reg_count; j++)
+			adev->vcn.ip_dump[inst_off + j] =
+				RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_4_0[j],
+								   inst));
 }
 
 static const struct amd_ip_funcs vcn_v4_0_ip_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index daaf2fb6b3e5..be03d31cb206 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1757,7 +1757,8 @@ static void vcn_v4_0_3_print_ip_state(struct amdgpu_ip_block *ip_block, struct d
 static void vcn_v4_0_3_dump_ip_state(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int i, j;
+	int inst = ip_block->instance;
+	int j;
 	bool is_powered;
 	uint32_t inst_off, inst_id;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0_3);
@@ -1765,23 +1766,21 @@ static void vcn_v4_0_3_dump_ip_state(struct amdgpu_ip_block *ip_block)
 	if (!adev->vcn.ip_dump)
 		return;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
-
-		inst_id = GET_INST(VCN, i);
-		inst_off = i * reg_count;
-		/* mmUVD_POWER_STATUS is always readable and is first element of the array */
-		adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, inst_id, regUVD_POWER_STATUS);
-		is_powered = (adev->vcn.ip_dump[inst_off] &
-				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
-
-		if (is_powered)
-			for (j = 1; j < reg_count; j++)
-				adev->vcn.ip_dump[inst_off + j] =
-					RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_4_0_3[j],
-									   inst_id));
-	}
+	if (adev->vcn.harvest_config & (1 << inst))
+		return;
+
+	inst_id = GET_INST(VCN, inst);
+	inst_off = inst * reg_count;
+	/* mmUVD_POWER_STATUS is always readable and is first element of the array */
+	adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, inst_id, regUVD_POWER_STATUS);
+	is_powered = (adev->vcn.ip_dump[inst_off] &
+			UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
+
+	if (is_powered)
+		for (j = 1; j < reg_count; j++)
+			adev->vcn.ip_dump[inst_off + j] =
+				RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_4_0_3[j],
+								   inst_id));
 }
 
 static const struct amd_ip_funcs vcn_v4_0_3_ip_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index ff8db22b9614..43b1f3d06157 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -1638,7 +1638,8 @@ static void vcn_v4_0_5_print_ip_state(struct amdgpu_ip_block *ip_block, struct d
 static void vcn_v4_0_5_dump_ip_state(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int i, j;
+	int inst = ip_block->instance;
+	int j;
 	bool is_powered;
 	uint32_t inst_off;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0_5);
@@ -1646,22 +1647,20 @@ static void vcn_v4_0_5_dump_ip_state(struct amdgpu_ip_block *ip_block)
 	if (!adev->vcn.ip_dump)
 		return;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return;
 
-		inst_off = i * reg_count;
-		/* mmUVD_POWER_STATUS is always readable and is first element of the array */
-		adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, i, regUVD_POWER_STATUS);
-		is_powered = (adev->vcn.ip_dump[inst_off] &
-				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
-
-		if (is_powered)
-			for (j = 1; j < reg_count; j++)
-				adev->vcn.ip_dump[inst_off + j] =
-					RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_4_0_5[j],
-									   i));
-	}
+	inst_off = inst * reg_count;
+	/* mmUVD_POWER_STATUS is always readable and is first element of the array */
+	adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, inst, regUVD_POWER_STATUS);
+	is_powered = (adev->vcn.ip_dump[inst_off] &
+			UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
+
+	if (is_powered)
+		for (j = 1; j < reg_count; j++)
+			adev->vcn.ip_dump[inst_off + j] =
+				RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_4_0_5[j],
+								   inst));
 }
 
 static const struct amd_ip_funcs vcn_v4_0_5_ip_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index c83a5c09f410..65554c4e86cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -1365,7 +1365,8 @@ static void vcn_v5_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm
 static void vcn_v5_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int i, j;
+	int inst = ip_block->instance;
+	int j;
 	bool is_powered;
 	uint32_t inst_off;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_5_0);
@@ -1373,21 +1374,19 @@ static void vcn_v5_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
 	if (!adev->vcn.ip_dump)
 		return;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return;
 
-		inst_off = i * reg_count;
-		/* mmUVD_POWER_STATUS is always readable and is first element of the array */
-		adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, i, regUVD_POWER_STATUS);
-		is_powered = (adev->vcn.ip_dump[inst_off] &
-				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
+	inst_off = inst * reg_count;
+	/* mmUVD_POWER_STATUS is always readable and is first element of the array */
+	adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, inst, regUVD_POWER_STATUS);
+	is_powered = (adev->vcn.ip_dump[inst_off] &
+			UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
 
-		if (is_powered)
-			for (j = 1; j < reg_count; j++)
-				adev->vcn.ip_dump[inst_off + j] =
-					RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_5_0[j], i));
-	}
+	if (is_powered)
+		for (j = 1; j < reg_count; j++)
+			adev->vcn.ip_dump[inst_off + j] =
+				RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_5_0[j], inst));
 }
 
 static const struct amd_ip_funcs vcn_v5_0_0_ip_funcs = {
-- 
2.34.1

