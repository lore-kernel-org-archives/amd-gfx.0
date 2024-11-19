Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A929BD591C4
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Nov 2024 06:36:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 480D910E5C6;
	Tue, 19 Nov 2024 06:36:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="piKYBzLr";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26F4710E5C6
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Nov 2024 06:36:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fsf/ZM+rF9nJfIeRrySQ79S97OYPRe+0k58AwQXj6ydhtcxAcrvS4OMhSQfAsaU0RaI3kwX5bnXb7PH46vMmqBBlhOS5hJVJQHsrbtTAY0r1Q+rFFzDxBWFxLbt4u2+Nq7ADREGRs2oMgVDbVzQ+EKX1U0tZHL202R5jxntuHDLSR8RdJUSWtBPQStCi9quVZOmT+ChZroqahuJ1etJ/3in/ea01PEqQGHd9C/2KgS7jYnZauxBsu0na2rTOrbDvmuOLRZEZjMfMHiK/HDs+2ZuyGGe1hAL07M3QTxn8kxJJERwzKSquzrywQ3v9iJn9FbkFCfvUafqHOmmhPWmaQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6cUN3qZetZObnDHF7uWVd7q40K6fc6tOeeNr+1GHZ5c=;
 b=ZXx4xhAOsF2rLqX8LZufASfIvlTbiI5q6TrwhCZxdLJE/zmgaJQSY0rjhfpUGVfuzXlSld8aMiwcwtmSN/W/NpZ2WD7JulRFJ4ZtAm2i4o//5TD/G6k/vD3KYg/oewz34dgtYyS3GHDIhOFQirUomljrhKOqgJsxXaZDwrI+YdgHBpL9mzMiyLekVhrQVLUTDaPjGR/77zdWf24WPI5vpNn7iro3pdBuKgzYWPnSpGRAzcWhkbuYVpw3IWaWsn+gp6Laz9MCoXb0wWsXpdX9fFaFpkKpeihEqM/4JiNGL/KmxmB/Nay8Z4UddGOGrzXbGLb5xuzSDcudP/b5nfEn+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6cUN3qZetZObnDHF7uWVd7q40K6fc6tOeeNr+1GHZ5c=;
 b=piKYBzLr7KUzCcWBWLKIoP/KcwIXWNyucfJHUV6+6F+54QCZ41YO27iLapOAG/Y1UNQMRPbiFzZ+O9BxiFe6bGIFPGHw+ppzXr0Z7qu4S7maXGEkyvSGZ1ao2uGWcAzjWxHJBt5MNvdgxr/TWFTNs943CWJdg8EnLJ04QsFcMkY=
Received: from MW4PR04CA0071.namprd04.prod.outlook.com (2603:10b6:303:6b::16)
 by PH0PR12MB7486.namprd12.prod.outlook.com (2603:10b6:510:1e9::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 06:36:24 +0000
Received: from CO1PEPF000075F2.namprd03.prod.outlook.com
 (2603:10b6:303:6b:cafe::7c) by MW4PR04CA0071.outlook.office365.com
 (2603:10b6:303:6b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23 via Frontend
 Transport; Tue, 19 Nov 2024 06:36:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 CO1PEPF000075F2.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 19 Nov 2024 06:36:23 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Nov
 2024 00:36:22 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 01/21] drm/amdgpu: simplify RAS page retirement in one memory
 row
Date: Tue, 19 Nov 2024 14:35:44 +0800
Message-ID: <20241119063604.81461-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F2:EE_|PH0PR12MB7486:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e269a2c-600e-4f07-173c-08dd08647cf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OgoemZCu0L0vZ2ZCXrLO4SZJqCBDT/oDggEWYET8rTcq04YJd9LQYfUHvD//?=
 =?us-ascii?Q?jep7FN5pCzIG+KFGHlWOWzOFz5tKS5ZTV0IPkJgVFk2C2I6dKijZaWYKHvPi?=
 =?us-ascii?Q?/r813ysWy/SKrzu0Y9zc6SKuVfuiXcmP6uXeczysiIklcFMKAfa1t1DiNFwu?=
 =?us-ascii?Q?Xjb0o2R15nRV304f+a+72VFQ9V+FSpznFIhgxEDKKGyg/F8+BFvcItEuEShy?=
 =?us-ascii?Q?fK6D18p5z3xOK4X7e2x6Qwp77mqeB9iDLY6fSbdQogHqBjSR65nhAwGd/FAQ?=
 =?us-ascii?Q?nB6R6yqcg0XP1acxabEywgR50uCw72Q5sGbWq90S0TjMmWfEt5M5VXBu3nXO?=
 =?us-ascii?Q?1NlS5CFDIbhl3PMM17ptl/LvwqJRvoQAWby0hDFmMXwnd5QGpOD6a6BM79ON?=
 =?us-ascii?Q?WmgPwqZwNGRgNVeG+ldQQX8mAp08Ojt41zPcLDcspeV30JBvdbYF52E4HYBj?=
 =?us-ascii?Q?LnANJpO42O2R5sqK6t0OBDmuLz0UkKkglv8sNrjGIKcFczSwqSbXaa3tkgGu?=
 =?us-ascii?Q?BFBjLtfkgxjGtB0JleObt0bflZ8dUAiOJzDcKr5otajrjF5zvEb8OuRIMnjo?=
 =?us-ascii?Q?avZU5ZmstjgiDa35MLc9loZwGklWwP1vGgTdEhsTHhEPhuKWafxYTT4LThdF?=
 =?us-ascii?Q?V9S42hTg4PgJG93pOvIto8R4PLnHhMv8PD9z7m95potrMv1xJHGHtmHW9CFq?=
 =?us-ascii?Q?oLejickwnY1IDiIpiHCCRKKvTYddztX5Gf7LnMffLy8Eb43JmepNRo4cucZE?=
 =?us-ascii?Q?2AuS6eCg7NS12U4IaWf3F3bPYRkMBM0h2jYWMtohzEzWiT1txbS3AxkIXKhY?=
 =?us-ascii?Q?7nqMC1rLCmdu8ikX+qK+USkaf5LMrOn3fOA47Xbi6R7ZTrClp/Fd6pQ/cEXd?=
 =?us-ascii?Q?UGmH/MZ+iPSTH7kOlyr/NlYJCYwFxSXtfN2Mn0AFY9Zne5CMBK5PinBcz0+r?=
 =?us-ascii?Q?Wk1YNDPGOzcwElOThOu/lAks1xAcEJ9Z2B3/z9p0FpUFJ50B2TP/ZXYg2ZLq?=
 =?us-ascii?Q?4WszDXmwE5fqmwuDxeYlTp4TZrUPHklEbtzAePBcOE7tGJOWVZT1zIOdMUzk?=
 =?us-ascii?Q?paYMXUKXYuyjJYA3uLiBr5v/3eZEiZJeD9DcV7tz/0AiMcNel7z0zDbARrXG?=
 =?us-ascii?Q?RPtUBfLUAOJp78iVZUXNOiWBkKxNMcoLeSyIRZFHqm0hxsioogf672Ba0rv7?=
 =?us-ascii?Q?2eWNqAlEOeGKu5+dE/63WShuRMd5SwdgD4ROhAiu4XwsTCa6rAGmvU2r2Zp2?=
 =?us-ascii?Q?2YGyvkFsujH3PwvO9vujmjT05RAZrjVFz7k+loxn3sSPEs4Nhr3daYDB0PxJ?=
 =?us-ascii?Q?nxMFPksUi+SezfZDuQ2cXQXETctTRcqbTWSvL47HrMxHbZuYo5XcwHinN8Dx?=
 =?us-ascii?Q?hbh1RFgZLTL04It9EJhw+hjwtMKMlD5pG0b0o/4gUZq1H5OFXg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 06:36:23.9789 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e269a2c-600e-4f07-173c-08dd08647cf4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7486
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

