Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77FC6D43357
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2024 11:14:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B11010E20D;
	Fri,  8 Nov 2024 11:14:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JFEM0d9w";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1754210E0BF
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Nov 2024 11:14:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BS8Rg1R1Ym1rr4Z+P6mHRwCS5A/51yq1L4HRBM2OVCg9Cjyn5yfXXK41CXtKWVrgynGkFCLrck260hWMbVTaM/OlBu8XZn9QVwRXO2iS4XiLshFzUfSQXsPAU2/QBGIvFn/2vvzvszGibF3q6ptEoW3dNnI6EK//qGCFMyaU8cOoeE+E3kCMOF4owT3LIOXgW2XiYhIgtjQW2WKbHxzNtBi6GAPNYRCSzOQNl15QHeShfYm9HT4eOkJOOITVVMrWR2Yl+507DVXYwIRSciDGfzD86EN7s4Mx+m88xaBj8BGkWNGHX2L1xeoLU+W3lgDFG7EsueM1D1rOVi7ylytLQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6cUN3qZetZObnDHF7uWVd7q40K6fc6tOeeNr+1GHZ5c=;
 b=CpmbkySYjr7NBLVGMMj06/qLK2IFpfCZhy4M+HvHvYsmdf7jdzamOjiHW4Lz2PZwOT0S3su5ZMh8YSOcglcg8pv1GediBx1GJVI3RSZCh2vYkpCgxclAa+rWZ/VaRAhi0KI+rbK6VMzvoytXrFGk9UGTmkV61MGKlwn/mrj3G8O6RXGRs9I0E0upLU1TQUtBq5wl9PYbiAOfL/p4voDe7SvTFxOLSj3qQuXmde6lt93zw0BdKICWkJko59M95dEJb4Q5t+wbsrSRXYEI4tnuC2SlftJ2es2MBESvcy9vekgUjiq+KkXUjWJ59pZ5HwuQk5GaYZEVIe5rmlejJqJEdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6cUN3qZetZObnDHF7uWVd7q40K6fc6tOeeNr+1GHZ5c=;
 b=JFEM0d9wGcXm/j8kOP8HI55OW6DTG5WUtowt3Ef7+ZWpEaPpHHngwISIVJcnYH+n4HZKJXoKKdyPujWShSOOP9pyCdyjrPLgseKYOUlqzJtA5za4ccSc8A0zxYA/klV/mJ3CdEZUhLT4vRTa1cbdELsFig/0UtEJXPSCLFJF+wU=
Received: from BL1PR13CA0205.namprd13.prod.outlook.com (2603:10b6:208:2be::30)
 by LV3PR12MB9236.namprd12.prod.outlook.com (2603:10b6:408:1a5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21; Fri, 8 Nov
 2024 11:14:35 +0000
Received: from BL02EPF0001A100.namprd03.prod.outlook.com
 (2603:10b6:208:2be:cafe::a4) by BL1PR13CA0205.outlook.office365.com
 (2603:10b6:208:2be::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.10 via Frontend
 Transport; Fri, 8 Nov 2024 11:14:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A100.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Fri, 8 Nov 2024 11:14:35 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Nov
 2024 05:14:34 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 03/23] drm/amdgpu: simplify RAS page retirement in one memory
 row
Date: Fri, 8 Nov 2024 19:14:03 +0800
Message-ID: <20241108111423.60169-3-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241108111423.60169-1-tao.zhou1@amd.com>
References: <20241108111423.60169-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A100:EE_|LV3PR12MB9236:EE_
X-MS-Office365-Filtering-Correlation-Id: 4336dca8-9a3f-4439-b03a-08dcffe68727
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?g0WuUC+CzvrK1koZqRcnmQWJ/ANd9uvEC8nGMsbCL79ZTGuG75ahOejLcn++?=
 =?us-ascii?Q?wza2LmKKnL4biCCH5D7ghjjvS/e4x4Sf6s6I31fNDSOpI27CFBdOvD/Y449D?=
 =?us-ascii?Q?sgICUhEgRs78hUqWEkFPzZZI4g1BZpBOv92K0utSd6KtSHHAsNr+Lo6AAY8Q?=
 =?us-ascii?Q?KBRWe4uhop+l0b32VhVZ+Xu4tRPIxGiBa9/4n8n+4oVGtUy1rkKJ0K1wUR8a?=
 =?us-ascii?Q?zXp8YMaMDuoC4TBeCRrH8sIBF0rMjLPe7FaTFzzPKoafpOm3DMhTDYeb/2PB?=
 =?us-ascii?Q?GCeepCB30HkB7LtSo0may3CeEqKhcUtZ5f6DkMpCJAcxnbWsgzixyfHaNbZD?=
 =?us-ascii?Q?lq3MxyNSYodo8RxrvBMH0T7gkCPeN6BHFWUH6qzVnX0/22BAu6aYb86IUoBC?=
 =?us-ascii?Q?juAvmoelMdPcxccH2MoDAIpTJH6fHbegyoG7BP6mOnitxA0VAVtqGyKTuuAe?=
 =?us-ascii?Q?4DHUaa3BfCrqk9Rptu7rDVnUKvpWXoZRjSjlkGkA8rP42+FDLM+9MzXIeJTM?=
 =?us-ascii?Q?O2tt8f3dLWyJZNb3z53VfiYP0abdcigMLs+R6V0x8E1GlZKPod/sGYD/h/zb?=
 =?us-ascii?Q?/yjX4S0XVwJnbmrFKo8r6FhdXVmJXdRANI0NN4yM6pegr85iupQUgksERfIv?=
 =?us-ascii?Q?tBDC/AM5njLqDAh5LdraqXX3qsrEa7WyMK6GHXbqrlFhuf2Wf1rf7jk8yKTN?=
 =?us-ascii?Q?1Su371Y5hz8tkxfoWLtExHAy8C0CiSYeZMb6/oGa/VmXAAD/HVPbnB58Km4O?=
 =?us-ascii?Q?/jhXYmvz4ml5piyIkEpjyX5B5YeEBNGCUAKpCpmaVJW7hN0DkDc1BW4NsDii?=
 =?us-ascii?Q?k2bChZQhbhfb0Nq5kd7E1q78cIiDTwGfc3Lc5xXb1LXfV6aRtsMRGiszqb4E?=
 =?us-ascii?Q?KzF3nW2ATq4lHsq1Ez+chqczReg4oJG7wLBhMX5ynOnqF9Gz7+aaqA8eSqup?=
 =?us-ascii?Q?Xq74BsWgB5hgTr1GJQePY3wr6RT9GKVtAjlitAa1XMFcn1577lwSTlIsIzTJ?=
 =?us-ascii?Q?v7cvm7awCX5TFsyhz9TjzpdOnJJhqi8D9ridJdX9iDsF3WfVcVlj+WpfRXxC?=
 =?us-ascii?Q?rI0UssdghZ/sR81LcFqm4qtfvReT9YKJHjLrV1zaEAOovYuIzF/32/Uo7hCO?=
 =?us-ascii?Q?a97bluSFkEXxqG5iaqc6DZ7pq4Kkve8Thkz4WozuEUfc/Qocpr97SMTC3rpq?=
 =?us-ascii?Q?ZkZRUdEh/W7mXqoBLzlmovwGWqbbUAeOoHmEBy5aNrrBBOs36JAGypV2pngf?=
 =?us-ascii?Q?UYSkY6Wq99sCD8iH8igMcuSuNm8PtKNm3JJbSCmvC75lOe8o4zmt2jW7O7dK?=
 =?us-ascii?Q?oDVOpacjhZoLBx4bZvl8CMHfSEuelTiSBRQt/fCRlZHpbrZPNxDLuGXsgGM8?=
 =?us-ascii?Q?Ca7QSfv9uthXDIn49QJIs7gZsaBjKQL8aSQG7rIqvpLscgyDeQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 11:14:35.4228 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4336dca8-9a3f-4439-b03a-08dcffe68727
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A100.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9236
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

Take R13 and column bits as a whole for UMC v12.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 57 +++++++++++---------------
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.h |  1 +
 2 files changed, 24 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index 1a8ea834efa6..8939b4f1fb49 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -177,7 +177,7 @@ static void umc_v12_0_convert_error_address(struct amdgpu_device *adev,
 					struct ras_err_data *err_data,
 					struct ta_ras_query_address_input *addr_in)
 {
-	uint32_t col, row, row_xor, bank, channel_index;
+	uint32_t col, row, bank, channel_index;
 	uint64_t soc_pa, retired_page, column, err_addr;
 	struct ta_ras_query_address_output addr_out;
 
@@ -195,31 +195,27 @@ static void umc_v12_0_convert_error_address(struct amdgpu_device *adev,
 	channel_index = addr_out.pa.channel_idx;
 
 	col = (err_addr >> 1) & 0x1fULL;
-	row = (err_addr >> 10) & 0x3fffULL;
-	row_xor = row ^ (0x1ULL << 13);
 	/* clear [C3 C2] in soc physical address */
 	soc_pa &= ~(0x3ULL << UMC_V12_0_PA_C2_BIT);
 	/* clear [C4] in soc physical address */
 	soc_pa &= ~(0x1ULL << UMC_V12_0_PA_C4_BIT);
+	/* clear [R13] in soc physical address */
+	soc_pa &= ~(0x1ULL << UMC_V12_0_PA_R13_BIT);
 
-	/* loop for all possibilities of [C4 C3 C2] */
-	for (column = 0; column < UMC_V12_0_NA_MAP_PA_NUM; column++) {
+	/* loop for all possibilities of [R13 C4 C3 C2] */
+	for (column = 0; column < UMC_V12_0_BAD_PAGE_NUM_PER_CHANNEL; column++) {
 		retired_page = soc_pa | ((column & 0x3) << UMC_V12_0_PA_C2_BIT);
 		retired_page |= (((column & 0x4) >> 2) << UMC_V12_0_PA_C4_BIT);
+		retired_page |= (((column & 0x8) >> 3) << UMC_V12_0_PA_R13_BIT);
+
 		/* include column bit 0 and 1 */
 		col &= 0x3;
 		col |= (column << 2);
-		dev_info(adev->dev,
-			"Error Address(PA):0x%-10llx Row:0x%-4x Col:0x%-2x Bank:0x%x Channel:0x%x\n",
-			retired_page, row, col, bank, channel_index);
-		amdgpu_umc_fill_error_record(err_data, err_addr,
-			retired_page, channel_index, addr_in->ma.umc_inst);
+		row = (retired_page >> UMC_V12_0_PA_R0_BIT) & 0x3fffULL;
 
-		/* shift R13 bit */
-		retired_page ^= (0x1ULL << UMC_V12_0_PA_R13_BIT);
 		dev_info(adev->dev,
 			"Error Address(PA):0x%-10llx Row:0x%-4x Col:0x%-2x Bank:0x%x Channel:0x%x\n",
-			retired_page, row_xor, col, bank, channel_index);
+			retired_page, row, col, bank, channel_index);
 		amdgpu_umc_fill_error_record(err_data, err_addr,
 			retired_page, channel_index, addr_in->ma.umc_inst);
 	}
@@ -229,7 +225,7 @@ static void umc_v12_0_dump_addr_info(struct amdgpu_device *adev,
 				struct ta_ras_query_address_output *addr_out,
 				uint64_t err_addr)
 {
-	uint32_t col, row, row_xor, bank, channel_index;
+	uint32_t col, row, bank, channel_index;
 	uint64_t soc_pa, retired_page, column;
 
 	soc_pa = addr_out->pa.pa;
@@ -237,29 +233,27 @@ static void umc_v12_0_dump_addr_info(struct amdgpu_device *adev,
 	channel_index = addr_out->pa.channel_idx;
 
 	col = (err_addr >> 1) & 0x1fULL;
-	row = (err_addr >> 10) & 0x3fffULL;
-	row_xor = row ^ (0x1ULL << 13);
 	/* clear [C3 C2] in soc physical address */
 	soc_pa &= ~(0x3ULL << UMC_V12_0_PA_C2_BIT);
 	/* clear [C4] in soc physical address */
 	soc_pa &= ~(0x1ULL << UMC_V12_0_PA_C4_BIT);
+	/* clear [R13] in soc physical address */
+	soc_pa &= ~(0x1ULL << UMC_V12_0_PA_R13_BIT);
 
-	/* loop for all possibilities of [C4 C3 C2] */
-	for (column = 0; column < UMC_V12_0_NA_MAP_PA_NUM; column++) {
+	/* loop for all possibilities of [R13 C4 C3 C2] */
+	for (column = 0; column < UMC_V12_0_BAD_PAGE_NUM_PER_CHANNEL; column++) {
 		retired_page = soc_pa | ((column & 0x3) << UMC_V12_0_PA_C2_BIT);
 		retired_page |= (((column & 0x4) >> 2) << UMC_V12_0_PA_C4_BIT);
+		retired_page |= (((column & 0x8) >> 3) << UMC_V12_0_PA_R13_BIT);
+
 		/* include column bit 0 and 1 */
 		col &= 0x3;
-		col |= (column << 2);
-		dev_info(adev->dev,
-			"Error Address(PA):0x%-10llx Row:0x%-4x Col:0x%-2x Bank:0x%x Channel:0x%x\n",
-			retired_page, row, col, bank, channel_index);
+		col |= ((column & 0x7) << 2);
+		row = (retired_page >> UMC_V12_0_PA_R0_BIT) & 0x3fffULL;
 
-		/* shift R13 bit */
-		retired_page ^= (0x1ULL << UMC_V12_0_PA_R13_BIT);
 		dev_info(adev->dev,
 			"Error Address(PA):0x%-10llx Row:0x%-4x Col:0x%-2x Bank:0x%x Channel:0x%x\n",
-			retired_page, row_xor, col, bank, channel_index);
+			retired_page, row, col, bank, channel_index);
 	}
 }
 
@@ -274,23 +268,18 @@ static int umc_v12_0_lookup_bad_pages_in_a_row(struct amdgpu_device *adev,
 	soc_pa &= ~(0x3ULL << UMC_V12_0_PA_C2_BIT);
 	/* clear [C4] in soc physical address */
 	soc_pa &= ~(0x1ULL << UMC_V12_0_PA_C4_BIT);
+	/* clear [R13] in soc physical address */
+	soc_pa &= ~(0x1ULL << UMC_V12_0_PA_R13_BIT);
 
 	/* loop for all possibilities of [C4 C3 C2] */
-	for (column = 0; column < UMC_V12_0_NA_MAP_PA_NUM; column++) {
+	for (column = 0; column < UMC_V12_0_BAD_PAGE_NUM_PER_CHANNEL; column++) {
 		retired_page = soc_pa | ((column & 0x3) << UMC_V12_0_PA_C2_BIT);
 		retired_page |= (((column & 0x4) >> 2) << UMC_V12_0_PA_C4_BIT);
+		retired_page |= (((column & 0x8) >> 3) << UMC_V12_0_PA_R13_BIT);
 
 		if (pos >= len)
 			return 0;
 		pfns[pos++] = retired_page >> AMDGPU_GPU_PAGE_SHIFT;
-
-		/* shift R13 bit */
-		retired_page ^= (0x1ULL << UMC_V12_0_PA_R13_BIT);
-
-		if (pos >= len)
-			return 0;
-		pfns[pos++] = retired_page >> AMDGPU_GPU_PAGE_SHIFT;
-
 	}
 
 	return pos;
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
index be5598d76c1d..dea42810fc53 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
@@ -60,6 +60,7 @@
 #define UMC_V12_0_PA_C2_BIT 15
 #define UMC_V12_0_PA_C4_BIT 21
 /* row bits in SOC physical address */
+#define UMC_V12_0_PA_R0_BIT 22
 #define UMC_V12_0_PA_R13_BIT 35
 
 #define MCA_UMC_HWID_V12_0     0x96
-- 
2.34.1

