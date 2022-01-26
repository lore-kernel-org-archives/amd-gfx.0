Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D08E5C2BA4C
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jan 2022 11:05:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5486A10E809;
	Wed, 26 Jan 2022 11:05:05 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 237D710E809
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jan 2022 11:05:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GAt4UHB8syNl6C6FkWDtbTqxZPdm3oMfxRhUmd1Cj+YtiODhlqxz1qHOn1VQm3iFL2xo6+f9do+jLJRN4uPgsJZLBape6d08n1FFbPINlpGWiDLzMa4HBCzMyqbka2F1CNydxJo9qLy3T5JLVQ6pKjpqx6SGvKjo7yGin4ZPyUlKl47oGZyMLavYlThhhCG13U9pWvEVTdgPCiw+2uZ3Y8RjxWKLlCyX0+uoMbDkH1iQ9wQpPE0DTkviWt5wDICWv9PoWFsSV1qmIy8J4hIwO2viAog2PNQfBNasGUqPtr/ZijO6QA+MgBqOkUbDVDVRr8o9eOmSLJDzdfdEmRTEGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ND1HMP4yBmkPVFIJ+YDwaZNljJxNWbwcyCOoEtS3/Ng=;
 b=Ov9ZhafEMNC/WOLyMooocGxEDqcqA9SN/4rdS+zPs88eKDW0bMSfiIiTnyzcSWq27jsb65ibshHrevyxRh6KpoyPIt9QZ3YeyyR2E8IYcnNtyxd5B8COfS3QQt0h8QClyBLV/fLr2NuCOIimn7A8IKDiQfUImfeCmIgf2WQ7QofUfW8cZ4AzYGCjDjIIma2MLK87GXXh1sVZNH8NtSObFbKz//Y2Az6jzeWuLsua9Odd7LOgNlIduH5vMpyqdWOfSZqusVasteOeq4oBNlRmBcGl8HFRWUmbbzUOCg8/q0s3cAJmRZd4NYuZMle6drOqgyFkJebWZYmFkiXlMOJvBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ND1HMP4yBmkPVFIJ+YDwaZNljJxNWbwcyCOoEtS3/Ng=;
 b=gVl5Mp7VoacJvFcirfKvddUIXpNsZ79gNeaNirm8NrvMH37RBiKEKVoyjfBBN6/+Wp8LLbpHxbxn92JCXnLyjaFx6jpTWvRKdQcE2iLj9SABdc8LD2ALcA4hojFKI9gQ5M4D8U4jsUVNFygG98aYqiP+Qc9Tj+/c639avQ7bpwg=
Received: from BN9PR03CA0590.namprd03.prod.outlook.com (2603:10b6:408:10d::25)
 by DM5PR12MB1833.namprd12.prod.outlook.com (2603:10b6:3:111::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Wed, 26 Jan
 2022 11:04:59 +0000
Received: from BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10d:cafe::21) by BN9PR03CA0590.outlook.office365.com
 (2603:10b6:408:10d::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Wed, 26 Jan 2022 11:04:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT006.mail.protection.outlook.com (10.13.177.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Wed, 26 Jan 2022 11:04:59 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 26 Jan
 2022 05:04:56 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <yipeng.chai@amd.com>, <john.clements@amd.com>,
 <Lijo.Lazar@amd.com>
Subject: [PATCH] drm/amdgpu: add umc_convert_error_address to simplify code
Date: Wed, 26 Jan 2022 19:04:47 +0800
Message-ID: <20220126110447.28973-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58319d6e-75c3-484a-ef38-08d9e0bbb1cb
X-MS-TrafficTypeDiagnostic: DM5PR12MB1833:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB183374E0D60F6EE358C6FA81B0209@DM5PR12MB1833.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fc4mTXlDNBNcmbFj5x6JW4wjlFoK/V/WvYwsL0QOQ1MwePL5q1bgmtomkaokOTGwlJuL2igAuhdCNuA+mLZGvahWfegC1aY/vlc53Yq4EMwsiFZ/snmOWgXzBNF8Ubjr24Ze2kYzRSPtJZmNnxtIb46IOEuRdqHBHYFWXEA0xgZ48QYikq1Srh4GGVpJC/4igcaO3x9R9TdyB1XnzbP/JcugZK7de6/DdcUq5JlVS3e2KnhQKOHSz9YkeVoYU+m15I4NbndM2Og1qOQl3KaLgCS7SoyqkjGkhJuIrygLL4/sBFI9bxzAm8S7ouqJ31eoU0rL6bqLWUKFArDMOJeot6Jc/p3cyVLC5PDCN0uLUp5N2VHo83/3IhMv8U7+z1wHzRb1i2RsbOQOpY2MoOhgMkjOPjXN1L4LHEBDKc5zX6Q72RZ/IcovPvUkiIm0eiAVzIedbcJve49LUnxjJ+kKEYpA9qEqwp/3Rx9DRFo+2dsp8imFUG9j7gfTGeiu/N3gj5le3Qdexpw+utThnHL8WdYjZmHTPSvIoxj25yqw+gWLbeH/cJosi3PKlWweozOYx0K/1JEl9gRUewSPooVwP3kaVScGuixNetZaU/MZbE/AC1wfa+eYqjEo0lJXB04egxHW6oNRSkpzRiQFTCqVpKUyuLRHQYr3UIYd0+lx8OiJ9Z5Fh77x13+2t7rK2H0ehQGy1GrjGDgRKAyx3gsXkPSHY9ILyGHnUPz7E6teavKtqu3SskRAD9864/woxGC1C3o3z2hR7cQ0pb4Fc8aqV0OUJO7GKa5PyS3k+sG6jZI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(40470700004)(46966006)(82310400004)(316002)(83380400001)(16526019)(26005)(110136005)(186003)(7696005)(5660300002)(86362001)(2616005)(47076005)(8676002)(36860700001)(2906002)(1076003)(6666004)(36756003)(6636002)(81166007)(40460700003)(4326008)(426003)(30864003)(8936002)(336012)(70206006)(70586007)(356005)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 11:04:59.5449 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58319d6e-75c3-484a-ef38-08d9e0bbb1cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1833
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Make code reusable and more simple.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v6_7.c | 94 +++++++++------------------
 drivers/gpu/drm/amd/amdgpu/umc_v8_7.c | 82 +++++++++--------------
 2 files changed, 61 insertions(+), 115 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
index 47452b61b615..4abcdda42ac6 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
@@ -114,21 +114,13 @@ static void umc_v6_7_ecc_info_query_ras_error_count(struct amdgpu_device *adev,
 	}
 }
 
-static void umc_v6_7_ecc_info_query_error_address(struct amdgpu_device *adev,
-					 struct ras_err_data *err_data,
-					 uint32_t ch_inst,
-					 uint32_t umc_inst)
+static void umc_v6_7_convert_error_address(struct amdgpu_device *adev,
+					struct ras_err_data *err_data, uint32_t ch_inst,
+					uint32_t umc_inst, uint64_t err_addr,
+					uint64_t mc_umc_status)
 {
-	uint64_t mc_umc_status, err_addr, soc_pa, retired_page, column;
 	uint32_t channel_index;
-	uint32_t eccinfo_table_idx;
-	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
-
-	eccinfo_table_idx = umc_inst * adev->umc.channel_inst_num + ch_inst;
-	channel_index =
-		adev->umc.channel_idx_tbl[umc_inst * adev->umc.channel_inst_num + ch_inst];
-
-	mc_umc_status = ras->umc_ecc.ecc[eccinfo_table_idx].mca_umc_status;
+	uint64_t soc_pa, retired_page, column;
 
 	if (mc_umc_status == 0)
 		return;
@@ -136,12 +128,13 @@ static void umc_v6_7_ecc_info_query_error_address(struct amdgpu_device *adev,
 	if (!err_data->err_addr)
 		return;
 
+	channel_index =
+			adev->umc.channel_idx_tbl[umc_inst * adev->umc.channel_inst_num + ch_inst];
+
 	/* calculate error address if ue/ce error is detected */
 	if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1 &&
 	    (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UECC) == 1 ||
 	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, CECC) == 1)) {
-
-		err_addr = ras->umc_ecc.ecc[eccinfo_table_idx].mca_umc_addr;
 		err_addr = REG_GET_FIELD(err_addr, MCA_UMC_UMC0_MCUMC_ADDRT0, ErrorAddr);
 
 		/* translate umc channel address to soc pa, 3 parts are included */
@@ -173,6 +166,23 @@ static void umc_v6_7_ecc_info_query_error_address(struct amdgpu_device *adev,
 	}
 }
 
+static void umc_v6_7_ecc_info_query_error_address(struct amdgpu_device *adev,
+					 struct ras_err_data *err_data,
+					 uint32_t ch_inst,
+					 uint32_t umc_inst)
+{
+	uint64_t mc_umc_status, err_addr;
+	uint32_t eccinfo_table_idx;
+	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
+
+	eccinfo_table_idx = umc_inst * adev->umc.channel_inst_num + ch_inst;
+	mc_umc_status = ras->umc_ecc.ecc[eccinfo_table_idx].mca_umc_status;
+	err_addr = ras->umc_ecc.ecc[eccinfo_table_idx].mca_umc_addr;
+
+	umc_v6_7_convert_error_address(adev, err_data, ch_inst, umc_inst,
+			err_addr, mc_umc_status);
+}
+
 static void umc_v6_7_ecc_info_query_ras_error_address(struct amdgpu_device *adev,
 					     void *ras_error_status)
 {
@@ -348,9 +358,7 @@ static void umc_v6_7_query_error_address(struct amdgpu_device *adev,
 					 uint32_t umc_inst)
 {
 	uint32_t mc_umc_status_addr;
-	uint32_t channel_index;
-	uint64_t mc_umc_status, mc_umc_addrt0;
-	uint64_t err_addr, soc_pa, retired_page, column;
+	uint64_t mc_umc_status, mc_umc_addrt0, err_addr;
 
 	mc_umc_status_addr =
 		SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_STATUST0);
@@ -358,54 +366,10 @@ static void umc_v6_7_query_error_address(struct amdgpu_device *adev,
 		SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_ADDRT0);
 
 	mc_umc_status = RREG64_PCIE((mc_umc_status_addr + umc_reg_offset) * 4);
+	err_addr = RREG64_PCIE((mc_umc_addrt0 + umc_reg_offset) * 4);
 
-	if (mc_umc_status == 0)
-		return;
-
-	if (!err_data->err_addr) {
-		/* clear umc status */
-		WREG64_PCIE((mc_umc_status_addr + umc_reg_offset) * 4, 0x0ULL);
-		return;
-	}
-
-	channel_index =
-		adev->umc.channel_idx_tbl[umc_inst * adev->umc.channel_inst_num + ch_inst];
-
-	/* calculate error address if ue/ce error is detected */
-	if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1 &&
-	    (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UECC) == 1 ||
-	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, CECC) == 1)) {
-
-		err_addr = RREG64_PCIE((mc_umc_addrt0 + umc_reg_offset) * 4);
-		err_addr = REG_GET_FIELD(err_addr, MCA_UMC_UMC0_MCUMC_ADDRT0, ErrorAddr);
-
-		/* translate umc channel address to soc pa, 3 parts are included */
-		soc_pa = ADDR_OF_8KB_BLOCK(err_addr) |
-				ADDR_OF_256B_BLOCK(channel_index) |
-				OFFSET_IN_256B_BLOCK(err_addr);
-
-		/* The umc channel bits are not original values, they are hashed */
-		SET_CHANNEL_HASH(channel_index, soc_pa);
-
-		/* clear [C4 C3 C2] in soc physical address */
-		soc_pa &= ~(0x7ULL << UMC_V6_7_PA_C2_BIT);
-
-		/* we only save ue error information currently, ce is skipped */
-		if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UECC)
-				== 1) {
-			/* loop for all possibilities of [C4 C3 C2] */
-			for (column = 0; column < UMC_V6_7_NA_MAP_PA_NUM; column++) {
-				retired_page = soc_pa | (column << UMC_V6_7_PA_C2_BIT);
-				amdgpu_umc_fill_error_record(err_data, err_addr,
-					retired_page, channel_index, umc_inst);
-
-				/* shift R14 bit */
-				retired_page ^= (0x1ULL << UMC_V6_7_PA_R14_BIT);
-				amdgpu_umc_fill_error_record(err_data, err_addr,
-					retired_page, channel_index, umc_inst);
-			}
-		}
-	}
+	umc_v6_7_convert_error_address(adev, err_data, ch_inst, umc_inst,
+				err_addr, mc_umc_status);
 
 	/* clear umc status */
 	WREG64_PCIE((mc_umc_status_addr + umc_reg_offset) * 4, 0x0ULL);
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c b/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
index de85a998ef99..df15b87ae12b 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
@@ -115,21 +115,13 @@ static void umc_v8_7_ecc_info_query_ras_error_count(struct amdgpu_device *adev,
 	}
 }
 
-static void umc_v8_7_ecc_info_query_error_address(struct amdgpu_device *adev,
-					struct ras_err_data *err_data,
-					uint32_t ch_inst,
-					uint32_t umc_inst)
+static void umc_v8_7_convert_error_address(struct amdgpu_device *adev,
+					struct ras_err_data *err_data, uint32_t ch_inst,
+					uint32_t umc_inst, uint64_t err_addr,
+					uint64_t mc_umc_status)
 {
-	uint64_t mc_umc_status, err_addr, retired_page;
-	uint32_t channel_index;
-	uint32_t eccinfo_table_idx;
-	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
-
-	eccinfo_table_idx = umc_inst * adev->umc.channel_inst_num + ch_inst;
-	channel_index =
-		adev->umc.channel_idx_tbl[umc_inst * adev->umc.channel_inst_num + ch_inst];
-
-	mc_umc_status = ras->umc_ecc.ecc[eccinfo_table_idx].mca_umc_status;
+	uint32_t lsb, channel_index;
+	uint64_t retired_page;
 
 	if (mc_umc_status == 0)
 		return;
@@ -137,13 +129,16 @@ static void umc_v8_7_ecc_info_query_error_address(struct amdgpu_device *adev,
 	if (!err_data->err_addr)
 		return;
 
+	channel_index =
+			adev->umc.channel_idx_tbl[umc_inst * adev->umc.channel_inst_num + ch_inst];
+
 	/* calculate error address if ue/ce error is detected */
 	if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1 &&
 	    (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UECC) == 1 ||
 	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, CECC) == 1)) {
-
-		err_addr = ras->umc_ecc.ecc[eccinfo_table_idx].mca_umc_addr;
+		lsb = REG_GET_FIELD(err_addr, MCA_UMC_UMC0_MCUMC_ADDRT0, LSB);
 		err_addr = REG_GET_FIELD(err_addr, MCA_UMC_UMC0_MCUMC_ADDRT0, ErrorAddr);
+		err_addr &= ~((0x1ULL << lsb) - 1);
 
 		/* translate umc channel address to soc pa, 3 parts are included */
 		retired_page = ADDR_OF_4KB_BLOCK(err_addr) |
@@ -157,6 +152,22 @@ static void umc_v8_7_ecc_info_query_error_address(struct amdgpu_device *adev,
 					retired_page, channel_index, umc_inst);
 	}
 }
+static void umc_v8_7_ecc_info_query_error_address(struct amdgpu_device *adev,
+					struct ras_err_data *err_data,
+					uint32_t ch_inst,
+					uint32_t umc_inst)
+{
+	uint64_t mc_umc_status, err_addr;
+	uint32_t eccinfo_table_idx;
+	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
+
+	eccinfo_table_idx = umc_inst * adev->umc.channel_inst_num + ch_inst;
+	mc_umc_status = ras->umc_ecc.ecc[eccinfo_table_idx].mca_umc_status;
+	err_addr = ras->umc_ecc.ecc[eccinfo_table_idx].mca_umc_addr;
+
+	umc_v8_7_convert_error_address(adev, err_data, ch_inst, umc_inst,
+				err_addr, mc_umc_status);
+}
 
 static void umc_v8_7_ecc_info_query_ras_error_address(struct amdgpu_device *adev,
 					void *ras_error_status)
@@ -330,9 +341,8 @@ static void umc_v8_7_query_error_address(struct amdgpu_device *adev,
 					 uint32_t ch_inst,
 					 uint32_t umc_inst)
 {
-	uint32_t lsb, mc_umc_status_addr;
-	uint64_t mc_umc_status, err_addr, retired_page, mc_umc_addrt0;
-	uint32_t channel_index = adev->umc.channel_idx_tbl[umc_inst * adev->umc.channel_inst_num + ch_inst];
+	uint32_t mc_umc_status_addr;
+	uint64_t mc_umc_status, err_addr, mc_umc_addrt0;
 
 	mc_umc_status_addr =
 		SOC15_REG_OFFSET(UMC, 0, mmMCA_UMC_UMC0_MCUMC_STATUST0);
@@ -340,38 +350,10 @@ static void umc_v8_7_query_error_address(struct amdgpu_device *adev,
 		SOC15_REG_OFFSET(UMC, 0, mmMCA_UMC_UMC0_MCUMC_ADDRT0);
 
 	mc_umc_status = RREG64_PCIE((mc_umc_status_addr + umc_reg_offset) * 4);
+	err_addr = RREG64_PCIE((mc_umc_addrt0 + umc_reg_offset) * 4);
 
-	if (mc_umc_status == 0)
-		return;
-
-	if (!err_data->err_addr) {
-		/* clear umc status */
-		WREG64_PCIE((mc_umc_status_addr + umc_reg_offset) * 4, 0x0ULL);
-		return;
-	}
-
-	/* calculate error address if ue/ce error is detected */
-	if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1 &&
-	    (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UECC) == 1 ||
-	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, CECC) == 1)) {
-
-		err_addr = RREG64_PCIE((mc_umc_addrt0 + umc_reg_offset) * 4);
-		/* the lowest lsb bits should be ignored */
-		lsb = REG_GET_FIELD(err_addr, MCA_UMC_UMC0_MCUMC_ADDRT0, LSB);
-		err_addr = REG_GET_FIELD(err_addr, MCA_UMC_UMC0_MCUMC_ADDRT0, ErrorAddr);
-		err_addr &= ~((0x1ULL << lsb) - 1);
-
-		/* translate umc channel address to soc pa, 3 parts are included */
-		retired_page = ADDR_OF_4KB_BLOCK(err_addr) |
-				ADDR_OF_256B_BLOCK(channel_index) |
-				OFFSET_IN_256B_BLOCK(err_addr);
-
-		/* we only save ue error information currently, ce is skipped */
-		if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UECC)
-				== 1)
-			amdgpu_umc_fill_error_record(err_data, err_addr,
-					retired_page, channel_index, umc_inst);
-	}
+	umc_v8_7_convert_error_address(adev, err_data, ch_inst, umc_inst,
+					err_addr, mc_umc_status);
 
 	/* clear umc status */
 	WREG64_PCIE((mc_umc_status_addr + umc_reg_offset) * 4, 0x0ULL);
-- 
2.17.1

