Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5EDFD5E15A
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2024 11:14:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8762910E964;
	Fri,  8 Nov 2024 11:14:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B6cpHWsE";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CE5A10E964
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Nov 2024 11:14:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iouBC8J1FL+ixtcYatDzy3D341M1yWNm2Y/KwaKw/R2KgYKQmaiwJCip0+ZXNgBgOtRYroa/ceGr3FIL6d4yUNLCXEsComFN3/OmLLcQ8s3dI0b7umVfl0oFg/P1prdvj5RJbxiPdNF5gc5FlSVKqVnOxAKOksNNgBXzEYkK+jmb0mWlccvTxrQO8+NX/i7nK0kl4rBC2PBRhViRhP2c2aPzKbHIvv4aVuLXPzFNr9gBNUYULzoMsvNCrLQ3Cz5h/mnZO583JF2rVH5/6GC2YUQKnCV8gvZXzyJGC6bL4gwlh1IN2ZkYQzN+xzb1RxcKEk6J7RjyWO2LxqBPdPAXcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2jpBbTLQltbTZ7asohVaynGrUZHeuQoZLXhr9m+sJ0k=;
 b=h2QO7fc2NQlkS+t+q0z3wNv6vQa8m2KobhPzWjuhRqx3irxg9DlhzqieeVW+y/V5xUNWj8j8Yb13Q/yOkxrN6MgoWWGBxVZ0tp1cL8uJCHyg3NGoJBOGOMJy87Pj45UJDTZPERdbC3ioRggh4JhDj7poZq/X/3jnt/3qKDSV3zLkbPb48JAsfNqDnO73NoDfJUBDarVAo0VTP97SGq6tUu/fB95RdEsYIYdGQ1GKBPjjFb9xGW8fvuMJ1LIiJ6D4bH/lmgjz3i0QFgSq7DkeTIi/5opD0f2+ST/gdOT3Rr8LsT8hgp5aXaYd6TmgnModELdRMmjldjsab2bsDNDWCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2jpBbTLQltbTZ7asohVaynGrUZHeuQoZLXhr9m+sJ0k=;
 b=B6cpHWsEWU5/AlFrYSsqOVkyzFpOKlwSHdyMvzd2ASxe3c69Rrgo3VWroDIFb7H1sCnH7Zcc6F3dvb8RTIE5ma/FjBej1zVqJjsSCVYHRY6k5IKUlLeyMKkRlKCX0Z657CcT8Jb/4oEpv/cjWPjJOry6nBu6qQoK9OzgJ0qVbok=
Received: from BN9PR03CA0247.namprd03.prod.outlook.com (2603:10b6:408:ff::12)
 by PH0PR12MB5605.namprd12.prod.outlook.com (2603:10b6:510:129::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Fri, 8 Nov
 2024 11:14:47 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:408:ff:cafe::d) by BN9PR03CA0247.outlook.office365.com
 (2603:10b6:408:ff::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20 via Frontend
 Transport; Fri, 8 Nov 2024 11:14:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Fri, 8 Nov 2024 11:14:47 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Nov
 2024 05:14:46 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 13/23] drm/amdgpu: retire RAS bad pages in different NPS modes
Date: Fri, 8 Nov 2024 19:14:13 +0800
Message-ID: <20241108111423.60169-13-tao.zhou1@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|PH0PR12MB5605:EE_
X-MS-Office365-Filtering-Correlation-Id: 0095305b-d855-46f4-c2f2-08dcffe68e60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dxfeYFAJtXApMeB1xho0ashtTgGATBuxMt0wS4XpLndstVEEgDziXcKYp9pw?=
 =?us-ascii?Q?T1bLll4ooOVVVPrkKmHWLemwvJlP+AJw1tTDAjzdFXEDDZpQQFuV6H+vLStN?=
 =?us-ascii?Q?Uf3ezXM8IE3NFWvkCk616ax8j72QDfB1Ut6hxI3L1e6nQqtzwJKbj83GAMg6?=
 =?us-ascii?Q?jDxtgojre2krw9eaoPYCFTqFsP5cbNq9IiSUyHrEfIKltO2xxdK+2aOYTwlU?=
 =?us-ascii?Q?l2JBdTq0EFXf9i6WqPbP5xtCqfk/IAPsunR21wSlzR7Kike9vlahz3sHNd0M?=
 =?us-ascii?Q?vWGstzBfOEZ1x2OW7MBZodk1wpKkf2AZTtz7LykomyIYREW3AiTm8ihfOVks?=
 =?us-ascii?Q?C90JJqOr0hMQ0kcQe9c8JKXrjrAhawBXM8uVlB/PWLBKlL/nyiY3kx+XWCmd?=
 =?us-ascii?Q?n/iBx7I7DyahtKg50cRHozi6xcrQlo0TeKSggr7ESZvfyCM3KBwvgSSKtJIe?=
 =?us-ascii?Q?f7hqu4DuE3JoPdvHjBgSIcz/5JZBN9Qr1Aydvzhdtnnd/+/xL41O6m8IGzFY?=
 =?us-ascii?Q?35f7wITCNgV0WD0Alyq18n3D2cvcEcS6IXCYs5lcHtLwkoecxKAkZidWVg82?=
 =?us-ascii?Q?j9qmGxzJozfGV/wYfLuzj45VjKiPju4ugqH75rZfc140FarVCxTLt98ul6px?=
 =?us-ascii?Q?wZkfwW6WL+3lx0zsS9kK0Pb9qA/SIrmIXlWsfrg86HiPE+KbObQYGXlydWh9?=
 =?us-ascii?Q?jiiyWjEtIEoQtC+v+cVei1hUC0vYWQIa2GxRCuCH2aknPpSYU8qd+T6Axk6b?=
 =?us-ascii?Q?lFCdUprG5L9onNyelrm2dePFaMGZPDSCCSPiqBevNhXB1APV0CEuXBQ5yQJG?=
 =?us-ascii?Q?Z4XpRinuAwsKbGmngrIf1X2Ctqchs+aPZNzX4gmtUewxOqBisjN6zLTDtv8H?=
 =?us-ascii?Q?jS0ckjCrIaFryJsmwQfFznjZGRx+o5EoQrF0/Mk8x0xvyRIAT/0kgc+gvvHE?=
 =?us-ascii?Q?Der+/By0q3blA+bvqQOEeW3p9TQQ6WqJO4IqfL6PDaqj0xgxChiKtV2YliUx?=
 =?us-ascii?Q?k/S2g/ZvioTxrHQHhaEyAwii8DMUeXSE2xgKLHl2P+miWVLYgrehBdJWkFTX?=
 =?us-ascii?Q?rqcsf1Z1jH1oQe6I9yjdRnA3UgiVs4RLG5WK33f6QxOgHLQC3s0MPGOc9Ag8?=
 =?us-ascii?Q?7G6zx32w8HupCqgyI3prcsOIkiaLwHicWigVpyqRnwpfXfwbrkKFUIlFGydb?=
 =?us-ascii?Q?qm1J5ubkEUkQgaDUMQeyRtuazI6xYK6RAFrhLmjBpaqpZetwKK0N2BygNVaw?=
 =?us-ascii?Q?Hrv/caRH2ayZfP0PX+d38M8VKyIOEkbtvwPOM1I013ESTQuyMUHl7/rdK4jp?=
 =?us-ascii?Q?EX6sSxihMI2OgDbh8IgVBuBmmWu/HHq+Qm3+Eht/SEnoxS1GhuJZIpqp4gKI?=
 =?us-ascii?Q?bd5pXYIWISZui6UVk/9rNOO/AUVBfoXECMlTvzIQwV0lyQojug=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 11:14:47.5409 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0095305b-d855-46f4-c2f2-08dcffe68e60
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5605
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

