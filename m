Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E110106F2E9
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 07:55:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 820D310E98C;
	Thu, 26 Mar 2026 07:55:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ycd15wzr";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010052.outbound.protection.outlook.com [52.101.85.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13BD410E986
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 07:55:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v7WDnji5ycCf+htPnmAwwhGYx9+8V63hREvyu6FFqCbL91g1fJKfo6OduF/v4jPt4x/pybCSffZfs1+aLnrUhxbvQmr2B0ZE+Fgz+lz1ZH82vtc8BqJysqGYxcYRK3Om+fWFvlRgERu3BbpvpPYZTLYPuBQ8/RD5Ra4WJBbglZIUIv6yNRZePF67mDfiMj2LF+npxz5DTLzricnOEJn/Rq0A/xXJfbhL8tABxib3MiOf/T9SbhrL+UPpoTWG8scaYOpS0xxFh2rgA16vsrBgC76Pff4qzNCLsq4GYtaKIyOhoh1ugRdh+CaXrz6JQGo71Lp+kACKqCLwfIIMq6N0RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p+lpHZdhn5DHO+8DRGyHyZ7hRAbzsJKVnKfM4j6zMgQ=;
 b=MsfnPSxVKe5RXQTgn3HxMMoM01s9ibhcb+YT/MvZW6AoXt5RxrGJOhL6BrayswmFVdt7ChmHYhxLh3+kCzvSaVwtV4MhE7zBNaa+fgHqmuHF+eNnduEW7RRNUETQGE+y54no6wypo6EedHBCIv73pOvOqLafEaoCo5RhIOiWmzAO2F1JfD2gZ3qFYeMsWFqLgSOwNvN65kV875bEacK0jiFXNqdazcyFZhavt1WYe2wn1naUOexezKM4gPJK3xGeT1MeQBcSUtLRsvtCDkZyQDXXUpn97l5FKh44P3YqyvvlFxB+iCuUm7NvMvbPllZtTuk00uxR69T2Qtcz+2bGPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+lpHZdhn5DHO+8DRGyHyZ7hRAbzsJKVnKfM4j6zMgQ=;
 b=ycd15wzrknA35iWkrTl/Ak3Xpx7XqrMq3U8yDU4uD9xP0D7ox4TpE9wc3sWEA063FjnRHiSUR8C/Ls2DHEmmEi0XtTeeqYXzWOyESBT9bfV3ke2le+bZAMorFhuAN/fUMJyPbcF9HO/I0BuEize1XwMr52VzaqeEsCDKk7IupHs=
Received: from BL0PR02CA0099.namprd02.prod.outlook.com (2603:10b6:208:51::40)
 by CH2PR12MB9460.namprd12.prod.outlook.com (2603:10b6:610:27f::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 26 Mar
 2026 07:55:09 +0000
Received: from BN1PEPF0000468B.namprd05.prod.outlook.com
 (2603:10b6:208:51:cafe::e7) by BL0PR02CA0099.outlook.office365.com
 (2603:10b6:208:51::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.22 via Frontend Transport; Thu,
 26 Mar 2026 07:55:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000468B.mail.protection.outlook.com (10.167.243.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 07:55:09 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 26 Mar
 2026 02:55:07 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <Feifei.Xu@amd.com>
Subject: [PATCH 12/14] drm/amdgpu: Add function to fill training region
Date: Thu, 26 Mar 2026 13:15:33 +0530
Message-ID: <20260326075412.1378411-13-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260326075412.1378411-1-lijo.lazar@amd.com>
References: <20260326075412.1378411-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468B:EE_|CH2PR12MB9460:EE_
X-MS-Office365-Filtering-Correlation-Id: abb929c9-6634-4c06-497a-08de8b0d00b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: ji47yEO5+Nua9dCLU6byQzfk7K4jiZ1Nxv1LEFWJwJqpkPoWa7BsNjoR3ezm0OWG/c75U6fE/Gj8rPYhBmsLvCJQvzYu7WrA7e2cqLattMd2FNzknUlLVGAltG4u9JUgkbxE1PFv0hV8U5nQaiim0U9f/H/BRo0t4rfjHbxpzSNKNK5wW9Ui6wkoKdTKZ7mMU4fDCvGQgsZdL7CGTEXw+Hyw732wdMTT6aIpZcsCtLX6Xq6ZMb9UybZd0T4eh71PBaa9eRHReDz8wpN5DkLaRCy6nXpH8zaYa/0ZhcuZfn0Z7z5pbSN7yYfexuw7eKUx3iWgEUwF1GjbqOhYe5DAHkTtwBXt+iIRxH4OBdbDaPeS54kpYm6IOk/9ZScyRvUnj7JCv/tQ1yeZWHckH45frSFm6V0gKVNT0a2ZFfxSF6/LxF4aUf/+giyFDQtEGsdQwF/IoADAx0FD4Hnz6FNc3Rlr1T2mSIJct6VnONNRyqYxbSk4Vohe7elnEH2X3MhU//Usoxfuja15KTgDhmiZY4eETIb2BN9nmEOpUdT60d6xuirbuRDs4mAcuexqiPCq1+iUyWzuYqcwydZshrBPDHBmQ3M4m+1a7jtnXx6gDdfpzLjaSLoFDo0f9Jng/uFgDuHXvZZ0VDXBWUAXp3m7ryj7+nD7FqjE4TbX14UU+azhzBaZo9gpejIpbzXru8wUbqg5TbVexm1Zp7VPFpqTH+oLabZg1JGCnPaPFiE5V7aeC+Cdzp2UueQfatHVSxh28YK+G7xrL4gEH90fbxsfmQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /tKwz33FFs3YuU6UTk35hQPYgEOLSH7v6/mm6UklTSAt+vBEYYojkayJTxhN8fb0RXFHKlvgQ+LRH3Jhl9aoQtqCmqAJ5Ew7RE1qip4VXEmDiTtmtUp215k10g7RoYwBvyQcwFA89HtdW39hazDzOFVqtS5d/guhVkvdJt55CCQJxemV+BxY997HKnNVf57MISqbsOfgmrwTx8FJaco6FYgwfyiETXcTJWDi1ylGR7k7/5bk0bAyDEF+vw93X6/s6mUeNEIDsnzGgecrTvPllpkbBRJxhWr3MY0GMCzGUMxOD/0Wys+n0RT+yoC+t9+ByNJUrBeIEsxsHv8zZDUPXCLz5NA+WqS09Cu2fe2F7TRn2aWRDA1JbHt46Kl5gSl11nV4HTla0yfFD29wWqEpR+SG/Gs4DL1hA+8KLp790Usp/icnSAxORwwr0/BICx/c
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 07:55:09.5409 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abb929c9-6634-4c06-497a-08de8b0d00b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9460
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

Add a function to fill in memory training reservation region. Only if
the reservation for the region is successful, memory training context
will be initialized.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 62 ++++++++++++++-----------
 1 file changed, 35 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index f5aa4fecb1b0..ccefa04f2cbf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1730,6 +1730,28 @@ static void amdgpu_ttm_init_fw_resv_region(struct amdgpu_device *adev)
 				  reserve_size, false);
 }
 
+static void amdgpu_ttm_init_mem_train_resv_region(struct amdgpu_device *adev)
+{
+	uint64_t reserve_size;
+	uint64_t offset;
+
+	if (!adev->discovery.reserve_tmr)
+		return;
+
+	if (!adev->bios || amdgpu_sriov_vf(adev))
+		return;
+
+	if (!amdgpu_atomfirmware_mem_training_supported(adev))
+		return;
+
+	reserve_size = adev->mman.resv_region[AMDGPU_RESV_FW].size;
+	offset = ALIGN((adev->gmc.mc_vram_size - reserve_size - SZ_1M), SZ_1M);
+	amdgpu_ttm_init_vram_resv(adev, AMDGPU_RESV_MEM_TRAIN,
+				  offset,
+				  GDDR6_MEM_TRAINING_DATA_SIZE_IN_BYTES,
+				  false);
+}
+
 static void amdgpu_ttm_init_vram_resv_regions(struct amdgpu_device *adev)
 {
 	/* Initialize memory reservations as required for VGA.
@@ -1739,6 +1761,7 @@ static void amdgpu_ttm_init_vram_resv_regions(struct amdgpu_device *adev)
 	 */
 	amdgpu_gmc_init_vga_resv_regions(adev);
 	amdgpu_ttm_init_fw_resv_region(adev);
+	amdgpu_ttm_init_mem_train_resv_region(adev);
 }
 
 int amdgpu_ttm_mark_vram_reserved(struct amdgpu_device *adev,
@@ -1804,19 +1827,18 @@ static int amdgpu_ttm_training_reserve_vram_fini(struct amdgpu_device *adev)
 	return 0;
 }
 
-static void amdgpu_ttm_training_data_block_init(struct amdgpu_device *adev,
-						uint32_t reserve_size)
+static void amdgpu_ttm_training_data_block_init(struct amdgpu_device *adev)
 {
 	struct psp_memory_training_context *ctx = &adev->psp.mem_train_ctx;
+	struct amdgpu_vram_resv *resv =
+			&adev->mman.resv_region[AMDGPU_RESV_MEM_TRAIN];
 
 	memset(ctx, 0, sizeof(*ctx));
 
-	ctx->c2p_train_data_offset =
-		ALIGN((adev->gmc.mc_vram_size - reserve_size - SZ_1M), SZ_1M);
+	ctx->c2p_train_data_offset = resv->offset;
 	ctx->p2c_train_data_offset =
 		(adev->gmc.mc_vram_size - GDDR6_MEM_TRAINING_OFFSET);
-	ctx->train_data_size =
-		GDDR6_MEM_TRAINING_DATA_SIZE_IN_BYTES;
+	ctx->train_data_size = resv->size;
 
 	DRM_DEBUG("train_data_size:%llx,p2c_train_data_offset:%llx,c2p_train_data_offset:%llx.\n",
 			ctx->train_data_size,
@@ -1831,30 +1853,16 @@ static void amdgpu_ttm_training_data_block_init(struct amdgpu_device *adev,
 static int amdgpu_ttm_reserve_tmr(struct amdgpu_device *adev)
 {
 	struct psp_memory_training_context *ctx = &adev->psp.mem_train_ctx;
-	bool mem_train_support = false;
-	uint32_t reserve_size;
 	int ret;
 
-	reserve_size = adev->mman.resv_region[AMDGPU_RESV_FW].size;
+	ret = amdgpu_ttm_mark_vram_reserved(adev, AMDGPU_RESV_MEM_TRAIN);
+	if (ret) {
+		dev_err(adev->dev, "memory training region reservation failed(%d)!\n", ret);
+		return ret;
+	}
 
-	if (adev->bios && !amdgpu_sriov_vf(adev)) {
-		if (amdgpu_atomfirmware_mem_training_supported(adev))
-			mem_train_support = true;
-		else
-			DRM_DEBUG("memory training does not support!\n");
-	}
-
-	if (mem_train_support) {
-		/* reserve vram for mem train according to TMR location */
-		amdgpu_ttm_training_data_block_init(adev, reserve_size);
-		amdgpu_ttm_init_vram_resv(adev, AMDGPU_RESV_MEM_TRAIN,
-					  ctx->c2p_train_data_offset,
-					  ctx->train_data_size, false);
-		ret = amdgpu_ttm_mark_vram_reserved(adev, AMDGPU_RESV_MEM_TRAIN);
-		if (ret) {
-			dev_err(adev->dev, "memory training region reservation failed(%d)!\n", ret);
-			return ret;
-		}
+	if (adev->mman.resv_region[AMDGPU_RESV_MEM_TRAIN].size) {
+		amdgpu_ttm_training_data_block_init(adev);
 		ctx->init = PSP_MEM_TRAIN_RESERVE_SUCCESS;
 	}
 
-- 
2.49.0

