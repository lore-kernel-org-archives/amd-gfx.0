Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C4A0C36002
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Mar 2025 14:14:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D456510E3E9;
	Mon, 24 Mar 2025 14:14:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hjWQYPK8";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2059.outbound.protection.outlook.com [40.107.101.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5145E10E368
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Mar 2025 14:14:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a2wwMwTTZTE36+Ab5ZUpTqBKVon9AcfDqKC68YIavgA54ODykd+E6Ooguinlod2utanMg+0yRuri0Xxj5xQnrCaayJHQavH4Q8u0JzNTZmM6iQztyAM0k5YU+BRB03Y+HuKtfipNgsFyk4YVRiMYxG21eKgZPVUOwsQ60fRZdYpb7P5P8EkDXkxKO02C8qNq3zMsRuNJKk6d9LrsCV8IVcQR8EbDWwlgysePIivK9tUv8As4ElfuQ3oW0iKbAWu64tQpqJ+ublBCfw8F9fUzcpIWwNyXhldPEBxkcpcjl1dZwLgNUdZgmGuY+cLRax6eSZW6H8WHqq/bYKq3re570A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y9/VhyHZRyTZ62XS70zCFuH36D6aXRbLmJywc2b806s=;
 b=AGSmBBYlefhxCvNqwA4TNDz+8NvTTWg6s1c4YiKoCI2uOQqp6bkKajyFGtRdLWGY54bZ6cgho10Qf8ZJuXR+DTW+UmcJyRzy3ZfFsH5S5qCSyOX3fwnoTyWyQW4sahXW0QJst8nxnTSEbEYm97Ib5Zj2iVvcYbQINLOZaSEISKLmFXIezW3kg/E+c+jZxahpkNQBAIfmOez1z6k9N8C7yAWIVVSKcCheOwqefzeD36cmkKseEQp0YnpxJeCuTsQ8+LKly/AKOJRLJ/LW1fHZN3+r/7/8wRtUcstEWMKD128pvlspWgwiCjRtnKLG68BRcSLmbm2nhQ1pGwEpvnLFQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y9/VhyHZRyTZ62XS70zCFuH36D6aXRbLmJywc2b806s=;
 b=hjWQYPK8kgmC/WALqMHRGPMtHUxF7jDfVXlC6QKu22S2v5lX6vfbFgj4VPjMJZYdozf7eWG05iFye2gatdysqe7wzYhNbhzNP8WMyoMFJ8v0JOQmZ8s2oYsXlDTPHAfxgzn4M9roJtYx4TG35OYCH4OAQXCTjV0qxnv4vkW111M=
Received: from SA0PR13CA0029.namprd13.prod.outlook.com (2603:10b6:806:130::34)
 by MW6PR12MB8708.namprd12.prod.outlook.com (2603:10b6:303:242::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 14:14:32 +0000
Received: from SA2PEPF00003F68.namprd04.prod.outlook.com
 (2603:10b6:806:130:cafe::82) by SA0PR13CA0029.outlook.office365.com
 (2603:10b6:806:130::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Mon,
 24 Mar 2025 14:14:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F68.mail.protection.outlook.com (10.167.248.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 24 Mar 2025 14:14:31 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Mar
 2025 09:14:28 -0500
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <KevinYang.Wang@amd.com>, <Tao.Zhou1@amd.com>,
 <YiPeng.Chai@amd.com>, <Stanley.Yang@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH] drm/amdgpu: Parse all deferred errors with UMC aca handle
Date: Mon, 24 Mar 2025 22:14:15 +0800
Message-ID: <20250324141415.36174-1-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F68:EE_|MW6PR12MB8708:EE_
X-MS-Office365-Filtering-Correlation-Id: ccd9ae9f-4f74-436c-dbdb-08dd6ade321a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cjhHWGJ1juoHUHF1Eod1T4ZBhLVVR1Dfa9C/3xTe4CTws0tm6+0K0OZqKOUU?=
 =?us-ascii?Q?nh4XnXQyMJBjTxKQEKUzG0t5HePm8HD1CGJZ/W/eDMdDMfor1w8ojlv/2AT6?=
 =?us-ascii?Q?qtwsnQzJEcXmkpWliROk7rfn5wH8FENL+LXuYKNoNs8yM3K0D5sQ8vA31N9k?=
 =?us-ascii?Q?iMadGl48n3nBjOkdKleL/h4ft/PmmEr2wSuvvhIWoZejvFuLfPIypJEUj7HN?=
 =?us-ascii?Q?97nI45fNDjP84mnXEBupARmWci4zlxLDPkT+wybxeqRMCdsmeCRnT4iE024v?=
 =?us-ascii?Q?i3S8UuLXZViGyIiOOT24n5l9WTYsJRkhExnx07YMeyGbVWRtdVwwVAMz8z3M?=
 =?us-ascii?Q?TSylaYThi3ZHT1A8o+49ITFWGpklWSb6V5ynsuK4cWJxoB/7L3P9+P+PJBoL?=
 =?us-ascii?Q?iZLvsezAr29F6kOc2fHSGeQvosAwUmTrBfwHCUFoQ0jx11N/d/ZfkyuRmzso?=
 =?us-ascii?Q?QMFHMdHGLJonWmPAxBuAeiPjILb9GJyN8+zhoJ4F6LfKUkEHmfIiU4OJaUjz?=
 =?us-ascii?Q?XLEpkIdjzMx1FusFG9pHBKxtssmO9pB3wMWgozoK48CAhweCqnJhGr3Kn454?=
 =?us-ascii?Q?v6G3FG79nUNdudkyw6/KUENx2g1YtA3CP6GHCw56+c6V154keZYBeUqLP/tx?=
 =?us-ascii?Q?rL731AB2rnRhsGkIvxIrVqXPDiDbf7k5l1I3Gr1KY65KwcMAcJ3FkTEcXvZu?=
 =?us-ascii?Q?tWdfh7WBMR4qZY+i/h1MyKqj5riWKwK/fD5bLhw1YVErCPoAiL8KFZrYD+kG?=
 =?us-ascii?Q?YI5yFVYP1ctVGLEUfwfHfK0va79Mja7QwQDY6FSSa53zn1lrN2BLIzy9UUG0?=
 =?us-ascii?Q?YQgdhZiagi87DluLipL6yHnXeKlW4JZOdequq57IsWxTFqpG4FLydgz2mAhK?=
 =?us-ascii?Q?xLljTf1pGEUde9yWQSO+WuZ+pZX/TeJTmHkaV1LCphI4UJRJpRhEJgTvSN7i?=
 =?us-ascii?Q?YfcE4MekdtodLPTDkn6PcjSozp3ihmM4NtjXIH8XueJRsB8LH3sQ1yL3tMan?=
 =?us-ascii?Q?nPYx3yiwSFgilGmn9C0JKvdcKme/MtUghzhcV/jjqX/iF2VmQwM210htpLPk?=
 =?us-ascii?Q?+Xj2QgZPC7QJ2BbBnmqXtAk9g4Cuyl3YzG021TmevOgSkpfxxp4sqkQOXCgm?=
 =?us-ascii?Q?NTX0VEEGl+ddfyTUr81t0ehvJyVwPapHV+4M+u5jwWKVwelE8vkwRirfvM9x?=
 =?us-ascii?Q?ATGgIsd63je4m96PCMQaTTG9roBg5ViXmAlp8CgyIfunrDu1EszKLjZ3r9j8?=
 =?us-ascii?Q?O0ZuvnZcds8nPUycRAlPopzcci0Xc5ukcbckLGX3wENNRMUx/nMaKGre+yrF?=
 =?us-ascii?Q?p/ZFemR0Ua24uWqf/wf3KIiZBqOIEx/dwbmPcYpHaHy6gTqPb++VFgL50R2E?=
 =?us-ascii?Q?BD0kiSVtZe0lnXV+Q9K6c/q4hAf9myB4crF8vPpDWl0HYtBjWr1Kbp9pkoX7?=
 =?us-ascii?Q?0w4TdRjWqGMQHtOHAlJhf4n8W5wpBRglS2O1TtfApxr1zSv+fZZUxPCmTcwn?=
 =?us-ascii?Q?WyyGsM9AYBs/II8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 14:14:31.1758 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccd9ae9f-4f74-436c-dbdb-08dd6ade321a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F68.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8708
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

We should only increase the deferred errors in UMC block.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c  | 4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h  | 8 --------
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c  | 8 +++-----
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c   | 3 ++-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  | 2 +-
 9 files changed, 14 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index dc47f5fd4ea1..b4ad163f42a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -195,6 +195,10 @@ static bool aca_bank_is_valid(struct aca_handle *handle, struct aca_bank *bank,
 {
 	const struct aca_bank_ops *bank_ops = handle->bank_ops;
 
+	/* Parse all deferred errors with UMC aca handle */
+	if (ACA_BANK_ERR_IS_DEFFERED(bank))
+		return handle->hwip == ACA_HWIP_TYPE_UMC;
+
 	if (!aca_bank_hwip_is_matched(bank, handle->hwip))
 		return false;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
index 6b180f1b33fd..38c88897e1ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
@@ -80,14 +80,6 @@ struct ras_query_context;
 	(ACA_REG__STATUS__POISON((bank)->regs[ACA_REG_IDX_STATUS]) || \
 	 ACA_REG__STATUS__DEFERRED((bank)->regs[ACA_REG_IDX_STATUS]))
 
-#define ACA_BANK_ERR_CE_DE_DECODE(bank)                             \
-	(ACA_BANK_ERR_IS_DEFFERED(bank) ? ACA_ERROR_TYPE_DEFERRED : \
-					  ACA_ERROR_TYPE_CE)
-
-#define ACA_BANK_ERR_UE_DE_DECODE(bank)                             \
-	(ACA_BANK_ERR_IS_DEFFERED(bank) ? ACA_ERROR_TYPE_DEFERRED : \
-					  ACA_ERROR_TYPE_UE)
-
 enum aca_reg_idx {
 	ACA_REG_IDX_CTL			= 0,
 	ACA_REG_IDX_STATUS		= 1,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index be426542c1ae..af62688d34bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -1134,7 +1134,7 @@ static int xgmi_v6_4_0_aca_bank_parser(struct aca_handle *handle, struct aca_ban
 		break;
 	case ACA_SMU_TYPE_CE:
 		count = ext_error_code == 6 ? count : 0ULL;
-		bank->aca_err_type = ACA_BANK_ERR_CE_DE_DECODE(bank);
+		bank->aca_err_type = ACA_ERROR_TYPE_CE;
 		ret = aca_error_cache_log_bank_error(handle, &info, bank->aca_err_type, count);
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index e84238336fb6..ff77f59a1499 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -893,15 +893,13 @@ static int gfx_v9_4_3_aca_bank_parser(struct aca_handle *handle,
 
 	switch (type) {
 	case ACA_SMU_TYPE_UE:
-		bank->aca_err_type = ACA_BANK_ERR_UE_DE_DECODE(bank);
+		bank->aca_err_type = ACA_ERROR_TYPE_UE;
 		ret = aca_error_cache_log_bank_error(handle, &info, bank->aca_err_type, 1ULL);
 		break;
 	case ACA_SMU_TYPE_CE:
-		bank->aca_err_type = ACA_BANK_ERR_CE_DE_DECODE(bank);
+		bank->aca_err_type = ACA_ERROR_TYPE_CE;
 		ret = aca_error_cache_log_bank_error(handle, &info, bank->aca_err_type,
-			(bank->aca_err_type == ACA_ERROR_TYPE_CE) ?
-				ACA_REG__MISC0__ERRCNT(misc0) :
-				1);
+						     ACA_REG__MISC0__ERRCNT(misc0));
 		break;
 	default:
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index a758f0889d29..41afabd812d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -1290,7 +1290,7 @@ static int jpeg_v4_0_3_aca_bank_parser(struct aca_handle *handle, struct aca_ban
 						     1ULL);
 		break;
 	case ACA_SMU_TYPE_CE:
-		bank->aca_err_type = ACA_BANK_ERR_CE_DE_DECODE(bank);
+		bank->aca_err_type = ACA_ERROR_TYPE_CE;
 		ret = aca_error_cache_log_bank_error(handle, &info, bank->aca_err_type,
 						     ACA_REG__MISC0__ERRCNT(misc0));
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
index a54e7b929295..84cde1239ee4 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
@@ -751,7 +751,7 @@ static int mmhub_v1_8_aca_bank_parser(struct aca_handle *handle, struct aca_bank
 						     1ULL);
 		break;
 	case ACA_SMU_TYPE_CE:
-		bank->aca_err_type = ACA_BANK_ERR_CE_DE_DECODE(bank);
+		bank->aca_err_type = ACA_ERROR_TYPE_CE;
 		ret = aca_error_cache_log_bank_error(handle, &info, bank->aca_err_type,
 						     ACA_REG__MISC0__ERRCNT(misc0));
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 2c659470946c..c1c59637bd51 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -2397,7 +2397,7 @@ static int sdma_v4_4_2_aca_bank_parser(struct aca_handle *handle, struct aca_ban
 						     1ULL);
 		break;
 	case ACA_SMU_TYPE_CE:
-		bank->aca_err_type = ACA_BANK_ERR_CE_DE_DECODE(bank);
+		bank->aca_err_type = ACA_ERROR_TYPE_CE;
 		ret = aca_error_cache_log_bank_error(handle, &info, bank->aca_err_type,
 						     ACA_REG__MISC0__ERRCNT(misc0));
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index 74f57b2d30a5..0e404c074975 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -85,7 +85,8 @@ bool umc_v12_0_is_deferred_error(struct amdgpu_device *adev, uint64_t mc_umc_sta
 
 	return (amdgpu_ras_is_poison_mode_supported(adev) &&
 		(REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1) &&
-		(REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Deferred) == 1));
+		((REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Deferred) == 1) ||
+		(REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Poison) == 1)));
 }
 
 bool umc_v12_0_is_uncorrectable_error(struct amdgpu_device *adev, uint64_t mc_umc_status)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 20f47947e894..1e4ec8f07896 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1940,7 +1940,7 @@ static int vcn_v4_0_3_aca_bank_parser(struct aca_handle *handle, struct aca_bank
 						     1ULL);
 		break;
 	case ACA_SMU_TYPE_CE:
-		bank->aca_err_type = ACA_BANK_ERR_CE_DE_DECODE(bank);
+		bank->aca_err_type = ACA_ERROR_TYPE_CE;
 		ret = aca_error_cache_log_bank_error(handle, &info, bank->aca_err_type,
 						     ACA_REG__MISC0__ERRCNT(misc0));
 		break;
-- 
2.34.1

