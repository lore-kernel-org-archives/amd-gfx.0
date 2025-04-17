Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EC27C369CA
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Apr 2025 08:58:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1255910E1BB;
	Thu, 17 Apr 2025 08:58:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O8Peg77Z";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8276A10E192
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Apr 2025 08:58:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bxHb1BQ/EpAWA8ChyZf0q0da9XalkYVCa/A0a3TANbp9ZyGeyI6DAXUiY8AhruPR/KLThaA6WwzIBOEyPqUI19m9okLwCiO2i8SYuT8aFFF3Nq7KX1kiv4NDL0mcrBtAXBIGbj0FEzom1HEjeKWdSdBEexcwyHZ2OkQ/rhirApDKRJwyre7TmqrThEg9dNG3s+mtBqPRnacacwAPFGR7np5H9+STUuqxHwbrJOjTL3Hfq/4p5vIzHhGtoSMi3gxv+W2PG2mez9ToWd9R8E7AmsWlhXoQUUTh5vqNv69jcA8N/LDrIxz8sZcLXuiHTaVtMPv5YuRcZA76R6zAkJa9gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p4reAOREOJycQLln0gYIyvr/zTibBLulCZ1q7FeFHJs=;
 b=RKDfkD2hUScYfVT5PLmL3Vz6eyi5E7FC/A5fvxjrl7VzL02JJgqnr47HCE61rHsO/6PiyTuEiUOposQuJLziuq6kCeLxUlyYyoSjk7xKpO1vLOVy/jM3j5iCARP43cDWTERXvc7BgPH68fRqEXMYTytnwpNBTzkCF06mZw/zJHO/46pfowjcJhDSEN1kpQyxJ09Gq3THO73u9Yzk2pC5ce3P9QzvyWAj6D1RtbT/MYK3N55cwLWWBm4be4ajMivBS9qQ6y+ww7qH8HNCdSkYxgXTYXGrx9oTsvOBlfafB30U4Zp84kG8xqa16Dn+R0tiDCze04vX5DW3lmQN/hYYvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p4reAOREOJycQLln0gYIyvr/zTibBLulCZ1q7FeFHJs=;
 b=O8Peg77ZfFYitheROeIybEnms/2xBN5DXuZLDxR1ie8l6bqc/FaVtdUU9j1OGDLbeTHZcQPVj143kQtKUYka4pkLVa9gCoQwqzrvrEzf+lTj5hRZhLDjdI2ndP4Ks/tBYBT1pljrQjF7IM4q+QhvbgXvWoUDFPzh5e7ytScxd0k=
Received: from DM6PR10CA0008.namprd10.prod.outlook.com (2603:10b6:5:60::21) by
 CH2PR12MB4103.namprd12.prod.outlook.com (2603:10b6:610:7e::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.21; Thu, 17 Apr 2025 08:58:48 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:5:60:cafe::2a) by DM6PR10CA0008.outlook.office365.com
 (2603:10b6:5:60::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.35 via Frontend Transport; Thu,
 17 Apr 2025 08:58:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Thu, 17 Apr 2025 08:58:48 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Apr
 2025 03:58:46 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 4/6] drm/amdgpu: implement get_retire_flip_bits for UMC v12
Date: Thu, 17 Apr 2025 16:58:30 +0800
Message-ID: <20250417085832.36455-4-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250417085832.36455-1-tao.zhou1@amd.com>
References: <20250417085832.36455-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|CH2PR12MB4103:EE_
X-MS-Office365-Filtering-Correlation-Id: 0faa74b4-15d5-480d-8107-08dd7d8e1125
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2CHRcCAwPsdlY3+CHp2/6IdfiC/E3+rnRn4xQSJlvqcbfVwobgMcGIQKBnmM?=
 =?us-ascii?Q?wX1pQnL1xm4xVGDtLFh6Fm0PPX5J7pMfV1myo9d5nEGgOqJjvVBoIads1Xhm?=
 =?us-ascii?Q?qQyqF3eqLCjrrJQr3TTMJAn2mvjGiyR8yQasfpCCuRR8MnwHLhXaT+TKFJMC?=
 =?us-ascii?Q?bGUdvYVCNQt8k0Ey88R0To1n1PHKEKm8xkYKrGD2F6jXOb0bZY6wdzG0bmD3?=
 =?us-ascii?Q?bv2YrmYZKhqAPT2mFA23uP7inFIq+G1jJNNFQixAvOgGwAYmJuA7uUd9Q7g9?=
 =?us-ascii?Q?YYKC/J9BCDGbcNAOmGl8hVK2dZqWwZNjMiqIiyUEsIf1iP3B+whJor6ZSZy9?=
 =?us-ascii?Q?lH98VjcGg9slvazNi4ShnVcxFto6yAcMGYpBWdYodgmtZviGNsvmePkR0DPP?=
 =?us-ascii?Q?Yv23I5fmyQHxXkejZ2DbS3hOlNlegX8+oluyz4ZkHzpgf1oOECsWDDoqxG4h?=
 =?us-ascii?Q?bUxCI3v1ntJZzGFILwOycKaKrtlVfLdQuPaJR9W0aNI3OZxtDJySxrzOgCMg?=
 =?us-ascii?Q?OYqXZps+pGrT2UeiMTCjtd1Rw0wfpeFPlWbmifM3vFs+yOSPtWF5aGyZVrBn?=
 =?us-ascii?Q?aOTjhjgzzZxe+TUAfKtYyDaUSCbu9dFijv639gLHUDD7GLYSOxbI4iBnS7Sr?=
 =?us-ascii?Q?PwY8seZeBFxesieIhF1A4uacP8D8dm6zMbNnUHllr3v0aa+4MskLiIH+kOQL?=
 =?us-ascii?Q?2FnoVt78mRlAqO1LsqSli7FFsfIhD2QHDL9w/2o9DnlFjrvN+JAFNG9D0PJD?=
 =?us-ascii?Q?rNPyRSpoC84eORHJkTuwBweibIaIuV66p1+eRlm4BONX04WGlhzOXEF+CJ16?=
 =?us-ascii?Q?Ms3gDJ/m191SMMkrJgIdYq6u291j3x//EkSkSG19BMYaupIaPUs7j8vnJT63?=
 =?us-ascii?Q?XGD5nzT4Trenkw0G22Df/O70a2q/d+HBiUtkHWS/EddYCLZUk3GDlYrYezio?=
 =?us-ascii?Q?MN4dNLToRiWbvdv/UGwh0G9k5vum487EdydSMu1MQLeVHgZd6Jd49pqN0nHB?=
 =?us-ascii?Q?33VJXuMDDgUNSjFV7PIWDErT2TRGdvFcNHDt7VO1iRjV5O3FeR+COjOzGAdH?=
 =?us-ascii?Q?4SG+U4CcBh/NwhBAD3JKRthxUqgweZyOdrGeXA9LwVlSDQGSXFMG/MSwKR+a?=
 =?us-ascii?Q?tPNbaXijmTysDeQbVlMprzTbVQSOit5bbklDaNYGb9HQPmHIOxMYfJN2j3lE?=
 =?us-ascii?Q?j1nCr5G02peQVwvRjJIv44R2GY8t5fvLP5i4hZ1hiDsW8sZzqAMnEVw/qGec?=
 =?us-ascii?Q?SH7PV3tXlI96U+bdIPgjDl3k3D9S7sr/kHRINo+MHa/0wLFQiacnV22esiOd?=
 =?us-ascii?Q?Ybg95AWOmMjEEvV6Z1QPdXnkZ1WhIjKQqf2wDAI9FOQfVMEOh0lL31+fzxOO?=
 =?us-ascii?Q?orgH23cvNxvARooXG7f8hNsAfwmMKInbpVb5iyWlS3Zpa97IcwlkxAUYBOyS?=
 =?us-ascii?Q?XA+BW5b8M9iME8ptdDp8KoMj2E6rDR/i9vr6YRDSY4OYa9ebryD0xz9HE9ou?=
 =?us-ascii?Q?inyuTgSKlFgcyd+QXjpAzGE0sR65g+pRWRJF?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 08:58:48.2039 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0faa74b4-15d5-480d-8107-08dd7d8e1125
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4103
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

The RAS bad page retire flip bits can be set per vram type,
vram vendor and nps mode.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  |  1 -
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 82 +++++++++++++++++---------
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.h |  2 -
 3 files changed, 53 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 3caebe7c25a5..464015fc2012 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1504,7 +1504,6 @@ static void gmc_v9_0_set_umc_funcs(struct amdgpu_device *adev)
 		adev->umc.umc_inst_num = UMC_V12_0_UMC_INSTANCE_NUM;
 		adev->umc.node_inst_num /= UMC_V12_0_UMC_INSTANCE_NUM;
 		adev->umc.channel_offs = UMC_V12_0_PER_CHANNEL_OFFSET;
-		adev->umc.retire_unit = UMC_V12_0_BAD_PAGE_NUM_PER_CHANNEL;
 		if (!adev->gmc.xgmi.connected_to_cpu && !adev->gmc.is_app_apu)
 			adev->umc.ras = &umc_v12_0_ras;
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index d715cfde6aec..774d3baa62d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -174,6 +174,49 @@ static void umc_v12_0_query_ras_error_count(struct amdgpu_device *adev,
 	umc_v12_0_reset_error_count(adev);
 }
 
+static void umc_v12_0_get_retire_flip_bits(struct amdgpu_device *adev)
+{
+	enum amdgpu_memory_partition nps = AMDGPU_NPS1_PARTITION_MODE;
+	uint32_t vram_type = adev->gmc.vram_type;
+	struct amdgpu_umc_flip_bits *flip_bits = &(adev->umc.flip_bits);
+
+	if (adev->gmc.gmc_funcs->query_mem_partition_mode)
+		nps = adev->gmc.gmc_funcs->query_mem_partition_mode(adev);
+
+	/* default setting */
+	flip_bits->flip_bits_in_pa[0] = UMC_V12_0_PA_C2_BIT;
+	flip_bits->flip_bits_in_pa[1] = UMC_V12_0_PA_C3_BIT;
+	flip_bits->flip_bits_in_pa[2] = UMC_V12_0_PA_C4_BIT;
+	flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R13_BIT;
+	flip_bits->bit_num = 4;
+
+	switch (vram_type) {
+	case AMDGPU_VRAM_TYPE_HBM:
+		/* other nps modes are taken as nps1 */
+		if (nps == AMDGPU_NPS2_PARTITION_MODE) {
+			flip_bits->flip_bits_in_pa[0] = UMC_V12_0_PA_CH5_BIT;
+			flip_bits->flip_bits_in_pa[1] = UMC_V12_0_PA_C2_BIT;
+			flip_bits->flip_bits_in_pa[2] = UMC_V12_0_PA_B1_BIT;
+			flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R12_BIT;
+		}
+
+		if (nps == AMDGPU_NPS4_PARTITION_MODE) {
+			flip_bits->flip_bits_in_pa[0] = UMC_V12_0_PA_CH4_BIT;
+			flip_bits->flip_bits_in_pa[1] = UMC_V12_0_PA_CH5_BIT;
+			flip_bits->flip_bits_in_pa[2] = UMC_V12_0_PA_B0_BIT;
+			flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R11_BIT;
+		}
+
+		break;
+	default:
+		dev_warn(adev->dev,
+			"Unknown HBM type, set RAS retire flip bits to the value in NPS1 mode.\n");
+		break;
+	}
+
+	adev->umc.retire_unit = 0x1 << flip_bits->bit_num;
+}
+
 static int umc_v12_0_convert_error_address(struct amdgpu_device *adev,
 					struct ras_err_data *err_data,
 					struct ta_ras_query_address_input *addr_in,
@@ -182,11 +225,10 @@ static int umc_v12_0_convert_error_address(struct amdgpu_device *adev,
 {
 	uint32_t col, col_lower, row, row_lower, row_high, bank;
 	uint32_t channel_index = 0, umc_inst = 0;
-	uint32_t i, loop_bits[UMC_V12_0_RETIRE_LOOP_BITS];
+	uint32_t i, bit_num, retire_unit, *flip_bits;
 	uint64_t soc_pa, column, err_addr;
 	struct ta_ras_query_address_output addr_out_tmp;
 	struct ta_ras_query_address_output *paddr_out;
-	enum amdgpu_memory_partition nps = AMDGPU_NPS1_PARTITION_MODE;
 	int ret = 0;
 
 	if (!addr_out)
@@ -211,34 +253,15 @@ static int umc_v12_0_convert_error_address(struct amdgpu_device *adev,
 		umc_inst = addr_in->ma.umc_inst;
 	}
 
-	loop_bits[0] = UMC_V12_0_PA_C2_BIT;
-	loop_bits[1] = UMC_V12_0_PA_C3_BIT;
-	loop_bits[2] = UMC_V12_0_PA_C4_BIT;
-	loop_bits[3] = UMC_V12_0_PA_R13_BIT;
-
-	if (adev->gmc.gmc_funcs->query_mem_partition_mode)
-		nps = adev->gmc.gmc_funcs->query_mem_partition_mode(adev);
-
-	/* other nps modes are taken as nps1 */
-	if (nps == AMDGPU_NPS2_PARTITION_MODE) {
-		loop_bits[0] = UMC_V12_0_PA_CH5_BIT;
-		loop_bits[1] = UMC_V12_0_PA_C2_BIT;
-		loop_bits[2] = UMC_V12_0_PA_B1_BIT;
-		loop_bits[3] = UMC_V12_0_PA_R12_BIT;
-	}
-
-	if (nps == AMDGPU_NPS4_PARTITION_MODE) {
-		loop_bits[0] = UMC_V12_0_PA_CH4_BIT;
-		loop_bits[1] = UMC_V12_0_PA_CH5_BIT;
-		loop_bits[2] = UMC_V12_0_PA_B0_BIT;
-		loop_bits[3] = UMC_V12_0_PA_R11_BIT;
-	}
+	flip_bits = adev->umc.flip_bits.flip_bits_in_pa;
+	bit_num = adev->umc.flip_bits.bit_num;
+	retire_unit = adev->umc.retire_unit;
 
 	soc_pa = paddr_out->pa.pa;
 	channel_index = paddr_out->pa.channel_idx;
 	/* clear loop bits in soc physical address */
-	for (i = 0; i < UMC_V12_0_RETIRE_LOOP_BITS; i++)
-		soc_pa &= ~BIT_ULL(loop_bits[i]);
+	for (i = 0; i < bit_num; i++)
+		soc_pa &= ~BIT_ULL(flip_bits[i]);
 
 	paddr_out->pa.pa = soc_pa;
 	/* get column bit 0 and 1 in mca address */
@@ -259,10 +282,10 @@ static int umc_v12_0_convert_error_address(struct amdgpu_device *adev,
 		goto out;
 
 	/* loop for all possibilities of retired bits */
-	for (column = 0; column < UMC_V12_0_BAD_PAGE_NUM_PER_CHANNEL; column++) {
+	for (column = 0; column < retire_unit; column++) {
 		soc_pa = paddr_out->pa.pa;
-		for (i = 0; i < UMC_V12_0_RETIRE_LOOP_BITS; i++)
-			soc_pa |= (((column >> i) & 0x1ULL) << loop_bits[i]);
+		for (i = 0; i < bit_num; i++)
+			soc_pa |= (((column >> i) & 0x1ULL) << flip_bits[i]);
 
 		col = ((column & 0x7) << 2) | col_lower;
 		/* add row bit 13 */
@@ -684,5 +707,6 @@ struct amdgpu_umc_ras umc_v12_0_ras = {
 	.update_ecc_status = umc_v12_0_update_ecc_status,
 	.convert_ras_err_addr = umc_v12_0_convert_error_address,
 	.get_die_id_from_pa = umc_v12_0_get_die_id,
+	.get_retire_flip_bits = umc_v12_0_get_retire_flip_bits,
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
index 056bbc038312..ccdd6cd430f8 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
@@ -55,8 +55,6 @@
 #define UMC_V12_0_NA_MAP_PA_NUM        8
 /* R13 bit shift should be considered, double the number */
 #define UMC_V12_0_BAD_PAGE_NUM_PER_CHANNEL (UMC_V12_0_NA_MAP_PA_NUM * 2)
-/* C2, C3, C4, R13, four bits in MCA address are looped in retirement */
-#define UMC_V12_0_RETIRE_LOOP_BITS 4
 
 /* column bits in SOC physical address */
 #define UMC_V12_0_PA_C2_BIT 15
-- 
2.34.1

