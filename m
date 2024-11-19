Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62994D591D4
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Nov 2024 06:36:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B66DE10E5CF;
	Tue, 19 Nov 2024 06:36:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NSfhNUOR";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D783810E5CC
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Nov 2024 06:36:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zGJiVClnopJP+n6LpKKAtNNKSqNoZJRz44L2E/4+XBcivqLjDscTK47g+HCJ3AleV6CwmJOouNyvleUGCWvTfv+4huVjTJJZPH86uSy1S11EjycJa7DsuIukmR61sfOZMm1EUn+rTP6WHWr+EmQo4HMWXahzOCGF6kF7mW8wvXFLd+0Wr8h412Yd5Ypx0Otz7VEDxMryglh/rNkgifA3pVbva0DlSrpkmT115ibHHTCUfG+Obcx7+JWr4nISWsnBeajE1QU6PBs6qzOjvppVP88aZgnOfimbCLgkiQ6+ZHSBjzyFf+vo70nv8+j/VI1oafpQ/1r9EcZOk9fIGqyQrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2jpBbTLQltbTZ7asohVaynGrUZHeuQoZLXhr9m+sJ0k=;
 b=YpXK3BXQ724vcmoYpq2oXX29LRthnZnIT3gzXkqt/b1RBPpVBTc7tLwYZj8kioNC2wTXPb9gb3DkD8IO5NloPRuUIQqlOxV618FK0eUXbg3Auj2bfbpV2aWIXjtXD4ZEXwBDaMtVaDhUqqrm2mYZWPkAjgNPDGZy3w/dFOQfdt6JUTrhXWKs/n8PpElV1oxCsqibPQ1sqYQSamU4CIxfXHuKsy/bSrgPUl+BEgW/cHFSjzFni2r58JffHBvFs/5/ak+nLGB7/f27LxyIh9918ImmBe7w8TbJydsKU8zf+Y4+XsE8IHDKopkA/uduv+n8CAAGVYwHWKevTL9INNnPhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2jpBbTLQltbTZ7asohVaynGrUZHeuQoZLXhr9m+sJ0k=;
 b=NSfhNUORNMmQtZQatsg2PwcA9IwOk8Bj+G8/K+y8Po38Zz/QfRh4S/ShVTIEeOHos3JSyM6Azz+pWN5tz991783c31T5DQXkVf6J3YV/lGk70haVdbzRzXLiMV/vl1BQFw7/XF6bW0WXoQE7sTSKJYhBcD8783JP6B1mtmW7MnI=
Received: from MW4PR03CA0044.namprd03.prod.outlook.com (2603:10b6:303:8e::19)
 by CH0PR12MB8485.namprd12.prod.outlook.com (2603:10b6:610:193::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.14; Tue, 19 Nov
 2024 06:36:38 +0000
Received: from CO1PEPF000075F3.namprd03.prod.outlook.com
 (2603:10b6:303:8e:cafe::d8) by MW4PR03CA0044.outlook.office365.com
 (2603:10b6:303:8e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22 via Frontend
 Transport; Tue, 19 Nov 2024 06:36:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 CO1PEPF000075F3.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 19 Nov 2024 06:36:37 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Nov
 2024 00:36:34 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 11/21] drm/amdgpu: retire RAS bad pages in different NPS modes
Date: Tue, 19 Nov 2024 14:35:54 +0800
Message-ID: <20241119063604.81461-11-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119063604.81461-1-tao.zhou1@amd.com>
References: <20241119063604.81461-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F3:EE_|CH0PR12MB8485:EE_
X-MS-Office365-Filtering-Correlation-Id: fb093c73-2359-4657-2f1b-08dd08648532
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?i0KTbd4QkxhyoDS2MxsmFJ6FZbJtaj3YyuhN89YobRzUW/zkjWbHonrcckMk?=
 =?us-ascii?Q?/N1ze9iHadcLlfXcof7AmrDHYmRAFkNXf2NwRUipOzYUJ2gifalIKDUiPKgK?=
 =?us-ascii?Q?Af6BnxySEqkkCfUjJDKDX7ILde4Yq49rODcBddR/DU+HaaNu2gtDNua/YX8j?=
 =?us-ascii?Q?rd3avFhXy1nrpaikTgZFVUdjZ3RTuVzZlESy1ZE97IcixI/77+ZZSx5GgDOi?=
 =?us-ascii?Q?iJSG37sPrjSecN6y2oK6yfMa690kqAWAcyGHMjMGh5elCnAOXf74tv+fK7Kz?=
 =?us-ascii?Q?n6LHQ3FOWprfWkV2PwrpVyrF1qg8wZ+GZRWqkByaUprWiEqlA0QJaTbvDbhW?=
 =?us-ascii?Q?x5qXxb1tMGnBF7Sfx5v4mOVv40I/n+OepgF18f64NP1sMWFF6JKmDGZLpFI2?=
 =?us-ascii?Q?jxXpU4r1UZUeMW76nByYVme21iJwSlMY2AR3iL18fZt4JITyjxUOctjk6Dd9?=
 =?us-ascii?Q?taAyC/YLsbwYAewKIpMl+Z7dOfTkRZLQG0Ht7ImK3T8zyug6UDnSJ0o4IsZI?=
 =?us-ascii?Q?jqR39ABHz9FBbBHAFT3w+695QMuuxPIMHNVJNS5JSHzzWcp3MPpcZj4Xf3Og?=
 =?us-ascii?Q?39rp0HWF8JyTl5qZjLJijz4znZHiFcA3WwnunU4xCY6gQ7aZZAJY8govaqz0?=
 =?us-ascii?Q?F/b7KhVSeN5ndIJPOHICWJ2ECBPRvv+xpCqzrFuzx0wiiMG9L6LHzaTV28lk?=
 =?us-ascii?Q?DlAW+zKHAYFN7iHIBfC7i08/gUN7QS+ZJh3PgSls0MVR3lu6U+en0mLHEibK?=
 =?us-ascii?Q?iNqVfbNpdEQFGQnTvz1o1YTTiNz3hckOWKKGqG+2XdVqZFz4at39Fn/ApzsV?=
 =?us-ascii?Q?gMa4X/SQZHiufOqVz2ssWm18WOKUm1FN1HDOIYabnUfAjD1/A5L5uqKel01s?=
 =?us-ascii?Q?DYzY5AyGfUKzdj0YRphnu4ErdlPM8vpKpfS4aEv6FyQUe2V0fR/EXQBqF9K1?=
 =?us-ascii?Q?FQE1GqP+e0RS5zcUEQArwjGjUEuHqhXROK64JoMLmqD1CxUcwWBTlx5vb133?=
 =?us-ascii?Q?O76zmBE70KZIi5n9sZcGK7Nlv9zvUbG1iCOYetP9t8Q3DdB4m0A2C20j6cAU?=
 =?us-ascii?Q?R53KTRqQACjLUHLvWMTtCKH9E6BGOSOnDPLt6hmjW+tcb5CFv6p1NlOT9xYq?=
 =?us-ascii?Q?WN7h7F2rCGDh8kt2q8jy859W2jYVh3n/qE9EfEEeeYZD3TUz9xdq6PY1Htdc?=
 =?us-ascii?Q?CrL9VdrWF7myka8cGXQC0kGEMwE+ylFdyLvPZazyBjG/O50fEWx1gFL1IKtm?=
 =?us-ascii?Q?mDKagyXx+vbN0EPrl+sKRTlIyiLf2U60wvhPLyqUDKlR3gUWRbcwy8W5G005?=
 =?us-ascii?Q?7lqpakORQ/dq1Z85RnY9E3qt87EaFcvh9Pe+r/oW/f0kXbhcgVJQ5o8mrH1/?=
 =?us-ascii?Q?WAJI3c3HYsNIToTwoq+JabylZEBu4NSd5sG+cNs2SWr/RTjRcA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 06:36:37.9170 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb093c73-2359-4657-2f1b-08dd08648532
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8485
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

There are some changes in format of memory normalized address per
NPS mode, need to adjust bit mapping according to NPS mode.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 64 +++++++++++++++++---------
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.h | 11 +++++
 2 files changed, 52 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index ce60fd6675ce..17ef9a6743f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -179,10 +179,13 @@ static int umc_v12_0_convert_error_address(struct amdgpu_device *adev,
 					struct ta_ras_query_address_output *addr_out,
 					bool dump_addr)
 {
-	uint32_t col, row, bank, channel_index, umc_inst = 0;
-	uint64_t soc_pa, retired_page, column, err_addr;
+	uint32_t col, col_lower, row, row_lower, bank;
+	uint32_t channel_index, umc_inst = 0;
+	uint32_t i, loop_bits[UMC_V12_0_RETIRE_LOOP_BITS];
+	uint64_t soc_pa, column, err_addr;
 	struct ta_ras_query_address_output addr_out_tmp;
 	struct ta_ras_query_address_output *paddr_out;
+	enum amdgpu_memory_partition nps = AMDGPU_NPS1_PARTITION_MODE;
 	int ret = 0;
 
 	if (!addr_out)
@@ -199,7 +202,7 @@ static int umc_v12_0_convert_error_address(struct amdgpu_device *adev,
 			dev_warn(adev->dev, "Failed to query RAS physical address for 0x%llx",
 				err_addr);
 
-			return ret;
+			goto out;
 		}
 
 		bank = paddr_out->pa.bank;
@@ -208,42 +211,57 @@ static int umc_v12_0_convert_error_address(struct amdgpu_device *adev,
 		umc_inst = addr_in->ma.umc_inst;
 	}
 
-	soc_pa = paddr_out->pa.pa;
+	loop_bits[0] = UMC_V12_0_PA_C2_BIT;
+	loop_bits[1] = UMC_V12_0_PA_C3_BIT;
+	loop_bits[2] = UMC_V12_0_PA_C4_BIT;
+	loop_bits[3] = UMC_V12_0_PA_R13_BIT;
 
-	if (!err_data && !dump_addr)
-		return ret;
+	if (adev->gmc.gmc_funcs->query_mem_partition_mode)
+		nps = adev->gmc.gmc_funcs->query_mem_partition_mode(adev);
+
+	/* other nps modes are taken as nps1 */
+	if (nps == AMDGPU_NPS4_PARTITION_MODE) {
+		loop_bits[0] = UMC_V12_0_PA_CH4_BIT;
+		loop_bits[1] = UMC_V12_0_PA_CH5_BIT;
+		loop_bits[2] = UMC_V12_0_PA_B0_BIT;
+		loop_bits[3] = UMC_V12_0_PA_R11_BIT;
+	}
 
-	col = (err_addr >> 1) & 0x1fULL;
-	/* clear [C3 C2] in soc physical address */
-	soc_pa &= ~(0x3ULL << UMC_V12_0_PA_C2_BIT);
-	/* clear [C4] in soc physical address */
-	soc_pa &= ~(0x1ULL << UMC_V12_0_PA_C4_BIT);
-	/* clear [R13] in soc physical address */
-	soc_pa &= ~(0x1ULL << UMC_V12_0_PA_R13_BIT);
+	soc_pa = paddr_out->pa.pa;
+	/* clear loop bits in soc physical address */
+	for (i = 0; i < UMC_V12_0_RETIRE_LOOP_BITS; i++)
+		soc_pa &= ~BIT_ULL(loop_bits[i]);
 
 	paddr_out->pa.pa = soc_pa;
+	/* get column bit 0 and 1 in mca address */
+	col_lower = (err_addr >> 1) & 0x3ULL;
+	/* MA_R13_BIT will be handled later */
+	row_lower = (err_addr >> UMC_V12_0_MA_R0_BIT) & 0x1fffULL;
+
+	if (!err_data && !dump_addr)
+		goto out;
 
-	/* loop for all possibilities of [R13 C4 C3 C2] */
+	/* loop for all possibilities of retired bits */
 	for (column = 0; column < UMC_V12_0_BAD_PAGE_NUM_PER_CHANNEL; column++) {
-		retired_page = soc_pa | ((column & 0x3) << UMC_V12_0_PA_C2_BIT);
-		retired_page |= (((column & 0x4) >> 2) << UMC_V12_0_PA_C4_BIT);
-		retired_page |= (((column & 0x8) >> 3) << UMC_V12_0_PA_R13_BIT);
+		soc_pa = paddr_out->pa.pa;
+		for (i = 0; i < UMC_V12_0_RETIRE_LOOP_BITS; i++)
+			soc_pa |= (((column >> i) & 0x1ULL) << loop_bits[i]);
 
-		/* include column bit 0 and 1 */
-		col &= 0x3;
-		col |= (column << 2);
-		row = (retired_page >> UMC_V12_0_PA_R0_BIT) & 0x3fffULL;
+		col = ((column & 0x7) << 2) | col_lower;
+		/* add row bit 13 */
+		row = ((column >> 3) << 13) | row_lower;
 
 		if (dump_addr)
 			dev_info(adev->dev,
 				"Error Address(PA):0x%-10llx Row:0x%-4x Col:0x%-2x Bank:0x%x Channel:0x%x\n",
-				retired_page, row, col, bank, channel_index);
+				soc_pa, row, col, bank, channel_index);
 
 		if (err_data)
 			amdgpu_umc_fill_error_record(err_data, err_addr,
-				retired_page, channel_index, umc_inst);
+				soc_pa, channel_index, umc_inst);
 	}
 
+out:
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
index f0074abb5381..9298018d938f 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
@@ -55,13 +55,24 @@
 #define UMC_V12_0_NA_MAP_PA_NUM        8
 /* R13 bit shift should be considered, double the number */
 #define UMC_V12_0_BAD_PAGE_NUM_PER_CHANNEL (UMC_V12_0_NA_MAP_PA_NUM * 2)
+/* C2, C3, C4, R13, four bits in MCA address are looped in retirement */
+#define UMC_V12_0_RETIRE_LOOP_BITS 4
 
 /* column bits in SOC physical address */
 #define UMC_V12_0_PA_C2_BIT 15
+#define UMC_V12_0_PA_C3_BIT 16
 #define UMC_V12_0_PA_C4_BIT 21
 /* row bits in SOC physical address */
 #define UMC_V12_0_PA_R0_BIT 22
+#define UMC_V12_0_PA_R11_BIT 33
 #define UMC_V12_0_PA_R13_BIT 35
+/* channel bit in SOC physical address */
+#define UMC_V12_0_PA_CH4_BIT 12
+#define UMC_V12_0_PA_CH5_BIT 13
+/* bank bit in SOC physical address */
+#define UMC_V12_0_PA_B0_BIT 19
+/* row bits in MCA address */
+#define UMC_V12_0_MA_R0_BIT 10
 
 #define MCA_UMC_HWID_V12_0     0x96
 #define MCA_UMC_MCATYPE_V12_0  0x0
-- 
2.34.1

