Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEA12CDB471
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 08:46:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EEC110E585;
	Mon, 22 Jun 2026 08:46:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AfrjuJ9H";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010038.outbound.protection.outlook.com [52.101.201.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 956E110E584
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 08:46:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qa933NrhqlofDYvi4TZBwIglxFTJyIwFI8q08xFtt2hLVKjTroxHOax7cQ6vjc+uhSs4OyMMMdABCDDTCprM2xc8n78iXcDhp4x2B0VLNQqE1RskB13s1yqQRpuhVUFRfYg8FFxeKlnP99Du2KXVXeWzTYpIE5k26cjNc4wUqRtJ6LuL52p9Si+iL/eQNrInoOy4rrATWKydlTxvmSuLoyk5GHdqHysCPAq0ScTHjaqi6bwg/lVf5y2UVPumPA9zvxH4oN61QYkiRDFoH9mqLfDRQnFWOI5aFh0NvuOmaf5ElW0sAnhVFS4It0COp67oeEAK6vgG9e9VLdZj8+bh5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y38DLTY51/DnTWr+JGPD+KS/J9vq4lF2kJMi7LmKRxI=;
 b=CxclxNxQh0p5pp0LHweJ8rmTRW8uHjBbTPpXODkMFLeAPxWU/QKlUM4lquliXxS5E3EJkMlN6TOhAesC3bT/EQlG8A4synjgsnbiOFPVYjXVen1KPPuqcgv+0zGfkAXfT7qHoNzQE1MI4Uv/2f5ca2kLHiGLlLERkH4q05N1od9q0i/NmLyd7vd4F/TSA8+Tvgs1iMi1oZw5MxsFdBu2N4ULQj9XTCt4gL75RJbat8zOXmZQbwMubf34ooubuXmSCh18ikG/jFJUJ2pFf5V3yNuQFnrOHH8kPGTJ26LC/Ko8To+o1lpouW7w2f14VUs6XQtkkBi8DiqXW93usdlkiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y38DLTY51/DnTWr+JGPD+KS/J9vq4lF2kJMi7LmKRxI=;
 b=AfrjuJ9HUemR37juzhEKfTGdhi/cCQ7v1W+XmTjyQ8Zrmp8bHRxHXq82jngNGWzkAxdAuJBqYIKrUsx6i7U3iyxqAPJF4/xYWAyExyze9A2Mb5LaBUPDohqG3V4fiyO4h8ZP3tLPTzmACaAX6tK/zD4ot9hKwbaYMw63695uero=
Received: from DS1PR05CA0027.namprd05.prod.outlook.com (2603:10b6:8:23f::10)
 by SAWPR12MB999166.namprd12.prod.outlook.com (2603:10b6:806:4e1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.17; Mon, 22 Jun
 2026 08:46:37 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:8:23f:cafe::3) by DS1PR05CA0027.outlook.office365.com
 (2603:10b6:8:23f::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.12 via Frontend Transport; Mon,
 22 Jun 2026 08:46:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 08:46:36 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 22 Jun
 2026 03:46:34 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v2 44/48] drm/amdgpu: retire legacy get_retire_flip_bits for
 UMC
Date: Mon, 22 Jun 2026 16:44:46 +0800
Message-ID: <edd3385fa6376f8e0770a579d57938a65ee4a0f1.1782117608.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <594f7cbae0387b60f8af49505b57c1a5a604db2f.1782117608.git.cesun102@amd.com>
References: <594f7cbae0387b60f8af49505b57c1a5a604db2f.1782117608.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|SAWPR12MB999166:EE_
X-MS-Office365-Filtering-Correlation-Id: fd5cc1cf-e144-46cc-fd75-08ded03ac4d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: C/Pc0P21woCZhyP/ktLYED9/8Qg+QVK99licj1GD8CciiD34RZrVnD8ovv5EZFibCCs9wKhuxxlE8rEywa0G3qX9fKXGhuv658qR5KeoQoXwFSQiTzVQaIa1V+WndobBXq7TYsFD0o/H8+O6bAY3ePm4F+EsWadEbVR3vBdiMNO++k2RJYYHR8gpRbSO1KciWbTLTMMSw/InIwmWnrHSpvLZDo9LSrqbz9s9sxMJHWRP87H1lt00QmVPhaPjHSPeeIE3tPChxxLAv94UptPSG6uxbBt2xIvqWxfnlr2+BYLgI+QpM4HOXbU469RW0mSvketIlVfsareZmkNFxiytBTXC9RA6JvMUsMqjfm/yLwF2rV0NtEIEE1vcmIlOIPnOCzF/MkPiH8lORy1DUWe9iHfwO1KMzYmv1QKSkCgk2hwrH2c5lp3gYPOxK3w8/OBAVVCXoh7BdTC99bMXYXd0lf+im0x0GUKEg1uT7UpYGdmo58N/Ki6BihqbalXt3kKGDt9mvN8MEc6ySn2QUTSyXmgHk4JtniOgz3yjgFGlt1l3P60/Kqhjtk0RJaTDDWILiCgQN55jJcyKBz5VZgyQyFaMs06jmtIHa91jQF+9oI+Dmmjn1qSX0W6aM1w8hvVVXwkBGXOxBoU2pTJdOjNw7pwTJI//2L9/uXSrh0RF13UUoaoolbU7AjzMPRHaPmhUfvV/T3DTi/kV/j327vsI0Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lDkvEpy1cGNjCFO6EmN/WVKdmVFyln1BSd4pDBttGI0Y0BLm6aFnMaLbsJtzt4+H5yUqW9Un8nl0h0TThr8CvVQgoxlAVaACoiym+bSiysOogNv75FByZBAVqtVpT12eLHn3SXf1SAq01eMmYojga1mov66nKv6ZKn2N7WigEojukq+0sASg4ncthqczZxe2LvxO1meb957SZL77bmy3gv96PJj4GSiBHwlEGDw/vOuYvbl1k+vMBxUnbxpRguqp05cmmF8hqQFd1PSZl5es4nEgZFNoINFy7jTknDCobk3Q7SAGXZ6Z1ImPkVdulZctfcMDHP8y8KSPgK9OeLhb2lkeoC76w/IbOCNCNcoSzLJ8np5eKPOFo/YnXm9vsPBZ76T7EKHVqnfbdT4VmhEjxEzxeIoxIdMirA6GvYfG3hpZo5FD90pLrot7PTw5Gk+B
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 08:46:36.1712 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd5cc1cf-e144-46cc-fd75-08ded03ac4d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999166
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

Remove the legacy get_retire_flip_bits implementation for UMC v12

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 106 -------------------------
 1 file changed, 106 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index d62712324940..d3eeaead7ca2 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -73,115 +73,9 @@ bool umc_v12_0_is_correctable_error(struct amdgpu_device *adev, uint64_t mc_umc_
 		!(umc_v12_0_is_uncorrectable_error(adev, mc_umc_status)))));
 }
 
-static void umc_v12_0_get_retire_flip_bits(struct amdgpu_device *adev)
-{
-	enum amdgpu_memory_partition nps = AMDGPU_NPS1_PARTITION_MODE;
-	uint32_t vram_type = adev->gmc.vram_type;
-	struct amdgpu_umc_flip_bits *flip_bits = &(adev->umc.flip_bits);
-
-	if (adev->gmc.gmc_funcs->query_mem_partition_mode)
-		nps = adev->gmc.gmc_funcs->query_mem_partition_mode(adev);
-
-	if (adev->gmc.num_umc == 16) {
-		/* default setting */
-		flip_bits->flip_bits_in_pa[0] = UMC_V12_0_PA_C2_BIT;
-		flip_bits->flip_bits_in_pa[1] = UMC_V12_0_PA_C3_BIT;
-		flip_bits->flip_bits_in_pa[2] = UMC_V12_0_PA_C4_BIT;
-		flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R13_BIT;
-		flip_bits->flip_row_bit = 13;
-		flip_bits->bit_num = 4;
-		flip_bits->r13_in_pa = UMC_V12_0_PA_R13_BIT;
-
-		if (nps == AMDGPU_NPS2_PARTITION_MODE) {
-			flip_bits->flip_bits_in_pa[0] = UMC_V12_0_PA_CH5_BIT;
-			flip_bits->flip_bits_in_pa[1] = UMC_V12_0_PA_C2_BIT;
-			flip_bits->flip_bits_in_pa[2] = UMC_V12_0_PA_B1_BIT;
-			flip_bits->r13_in_pa = UMC_V12_0_PA_R12_BIT;
-		} else if (nps == AMDGPU_NPS4_PARTITION_MODE) {
-			flip_bits->flip_bits_in_pa[0] = UMC_V12_0_PA_CH4_BIT;
-			flip_bits->flip_bits_in_pa[1] = UMC_V12_0_PA_CH5_BIT;
-			flip_bits->flip_bits_in_pa[2] = UMC_V12_0_PA_B0_BIT;
-			flip_bits->r13_in_pa = UMC_V12_0_PA_R11_BIT;
-		}
-
-		switch (vram_type) {
-		case AMDGPU_VRAM_TYPE_HBM:
-			/* other nps modes are taken as nps1 */
-			if (nps == AMDGPU_NPS2_PARTITION_MODE)
-				flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R12_BIT;
-			else if (nps == AMDGPU_NPS4_PARTITION_MODE)
-				flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R11_BIT;
-
-			break;
-		case AMDGPU_VRAM_TYPE_HBM3E:
-			flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R12_BIT;
-			flip_bits->flip_row_bit = 12;
-
-			if (nps == AMDGPU_NPS2_PARTITION_MODE)
-				flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R11_BIT;
-			else if (nps == AMDGPU_NPS4_PARTITION_MODE)
-				flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R10_BIT;
-
-			break;
-		default:
-			dev_warn(adev->dev,
-				"Unknown HBM type, set RAS retire flip bits to the value in NPS1 mode.\n");
-			break;
-		}
-	} else if (adev->gmc.num_umc == 8) {
-		/* default setting */
-		flip_bits->flip_bits_in_pa[0] = UMC_V12_0_PA_CH5_BIT;
-		flip_bits->flip_bits_in_pa[1] = UMC_V12_0_PA_C2_BIT;
-		flip_bits->flip_bits_in_pa[2] = UMC_V12_0_PA_B1_BIT;
-		flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R11_BIT;
-		flip_bits->flip_row_bit = 12;
-		flip_bits->bit_num = 4;
-		flip_bits->r13_in_pa = UMC_V12_0_PA_R12_BIT;
-
-		if (nps == AMDGPU_NPS2_PARTITION_MODE) {
-			flip_bits->flip_bits_in_pa[0] = UMC_V12_0_PA_CH4_BIT;
-			flip_bits->flip_bits_in_pa[1] = UMC_V12_0_PA_CH5_BIT;
-			flip_bits->flip_bits_in_pa[2] = UMC_V12_0_PA_B0_BIT;
-			flip_bits->r13_in_pa = UMC_V12_0_PA_R11_BIT;
-		}
-
-		switch (vram_type) {
-		case AMDGPU_VRAM_TYPE_HBM:
-			flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R12_BIT;
-
-			/* other nps modes are taken as nps1 */
-			if (nps == AMDGPU_NPS2_PARTITION_MODE)
-				flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R11_BIT;
-
-			break;
-		case AMDGPU_VRAM_TYPE_HBM3E:
-			flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R11_BIT;
-			flip_bits->flip_row_bit = 12;
-
-			if (nps == AMDGPU_NPS2_PARTITION_MODE)
-				flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R10_BIT;
-
-			break;
-		default:
-			dev_warn(adev->dev,
-				"Unknown HBM type, set RAS retire flip bits to the value in NPS1 mode.\n");
-			break;
-		}
-	} else {
-		dev_warn(adev->dev,
-			"Unsupported UMC number(%d), failed to set RAS flip bits.\n",
-			adev->gmc.num_umc);
-
-		return;
-	}
-
-	adev->umc.retire_unit = 0x1 << flip_bits->bit_num;
-}
-
 struct amdgpu_umc_ras umc_v12_0_ras = {
 	.ras_block = {
 		.hw_ops = NULL,
 	},
-	.get_retire_flip_bits = umc_v12_0_get_retire_flip_bits,
 };
 
-- 
2.34.1

