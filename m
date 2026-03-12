Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06243FED2E7
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2026 08:08:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9073910E9D2;
	Thu, 12 Mar 2026 08:08:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0S0kBqkO";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011010.outbound.protection.outlook.com
 [40.93.194.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1216C10E9D2
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2026 08:08:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fCkfR9RPVKupGeP/3n11wRvi2UXO68hXEGd4qiIVO0Cd0RxSgv4qBlhyRwBDWHHH3T952IJHtE/HEnUr7fP/Fm6wjNS6Fie1s8ifHKS0S46u+YWew8PX6z/r8+1tEUGvaAWYpS5Kh8sPV44854ILFtaLFeAqz+o0dfy1yKZwDT1ef40VbJEET4VLfIYxy+ipDMofNt4hUsWVXLnEUA2Fz7pm+6nwFMmOqvPS9WZV5RfuHdyrRRa279d3/k69Ba4cwyYMs6dNeGU6YXK6JPKR1hT+0uBsMKBdusa8CGXLj/2BWD8yBMaDEkORjHvYk2TkopFcc8dkrKzOqLZzPR1eJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JGcjL+LY1uZdZ52auCCJkcoxtwjx34BTSp08sOGy9u8=;
 b=s92zKot7Fc+93V7ddRH6artSkubuFSqbY3JgyxhDX4YcfY6eUncRoZqPWdXW+XUK4NQTZCToRtHYmCplwUJ9QWAyE64GGxyu5IMzSDUuQjMGQHbcHbKOy54qFt4Zgbps3JFyAL4qWIRrfaGR/H1fDfqMoJwF5rjzzRkCnwwLc+jKdoKEB4a57fD0jrQ20sC84Esd/6+hGicii+AdtzHtrqKUN2ljj2zR3amJaAil56UMr/bNrJuXHhRQzthR4rK1ufBdBtk66kNHfoCNDUmbe00T/2lo9sCaH/Ow14zoL2PgPwJkqgduxM/GUjKV7pEmQ3w8us54n+iKrKH9F5cYKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JGcjL+LY1uZdZ52auCCJkcoxtwjx34BTSp08sOGy9u8=;
 b=0S0kBqkOIobG726JXWUQYRZuDxpK7Budt0PruaRgvSzL2kST7ptphQ0qbjtXtNA20DBb40Jw+Dy7DbATZYKz0FQwJDjj24SlZGd+sU3dF96UqREd5xRPTapg1KFEAc4SmusDq4M5zIA4P+DYnAQ5l9T+KtTOx06I6EwdpqjaIAQ=
Received: from DS7PR03CA0351.namprd03.prod.outlook.com (2603:10b6:8:55::16) by
 EAYPR12MB999156.namprd12.prod.outlook.com (2603:10b6:303:2c2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Thu, 12 Mar
 2026 08:08:03 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:8:55:cafe::87) by DS7PR03CA0351.outlook.office365.com
 (2603:10b6:8:55::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.27 via Frontend Transport; Thu,
 12 Mar 2026 08:08:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 12 Mar 2026 08:08:03 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 12 Mar
 2026 03:08:01 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: update flip bit setting of RAS bad page
Date: Thu, 12 Mar 2026 16:07:47 +0800
Message-ID: <20260312080747.485024-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|EAYPR12MB999156:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a6f9c1d-60ef-461a-8ac6-08de800e7c41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: sr5KLk2+J8AEu4BLX8PQvL/ooEJdNm6lS9T8JUKEekXTNi+eW6SfeTLzhjHiYV96mHX9UKREhbOPoazedNj36AQ02eF54kIbdLMiXT8RVJvOUHKUtzsEBziurTS0gwn5/LPpGOHkKKxv7td+iZ7yQDKRxOaJ4ULLSnJjxt2OhN4DKCau0XHKOX79CzPjK3BVvuvLgjw7A1EJ4e7qdLvSog6OqdniytMtZfznKBJ6N7acEuPaIZFOoWF8QrAMNuMVfhJa2ch6YLjyMB84KUKA8FicUcPUzyY+WWQqHu3ZqYcWdLwm6d2UlY4FROTqydnch2GLahs3UEOvPQuEjXXMks3ZlgMNVraI+3lRHz/Isi2y0RwlIydvtAAu0DNupcTGspqj6xMJ6yoagLA9ELC8j/y9xevFvdDiSd8IXGF8P5xmwM504839te/MkwssKkztD4gAIsc1yh44dzLl0qeOaHKqoRRoZFtLmsGx97rbR29jr9YomRbrvVdYcz8epotihYx6z+x7u/HPTMyMKM5neRjokRLOSRzhNVLmkuxK06FNn2S4VaIedJZkdwr8ZKS3OIOq2wW8plxJekWIPu3dny4pArS8uVmtrAoq2I0mHC9h4CVJvQVDAanCpx5F8W4ZVU3HjnpNSny/bQNjvVxgp/cJZoiRmcD+Mv3nDqMAZPxWD10j8wObkvjpIvcIbetDXNvfcJbSGyauRTReNlKlClL8voNqzqnG5bSkJCo9hhy9ImhUrR0pcqCiojVnS5KxWcXKn2kKsZ5hK/HkXosSPg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NFWbaOEUTNSJJqZVcmqoITc77IyRmCECdk/tpq0SuZ5vobON3Zy9qdgusJrvFIzcPU9M+CzAdr9Evgf+akG0kah3EpOgEzsPHC7mFqnfmhiB460W1HIrEEE8wY02Gi8HGx2ramJwewCJvY3FIVL6hTwAYFAnia0oigUn58Az8kLdVAELPbVA47XzF0TINO1uRVrQmAEct9Q/uXdOZVDICY16GlPa5Nl8jwZWWpLfZIiZE8FVHp1y0JEQFKgXBmpGMEwA3w016K039IcQ+cd+WAzPY2cFt5VCa+6PMgwI4/Fcei6Eye9UwKwl6KlSGanYj1LRT7/DGVbZu4GKBRUHao2Cz9bJUepz7siFM0+VPskcTe8H+yQw5WYlXrN1/NT4X1comUfbrQjOh6PfwrktvmiDwNX86rrgCVM4WKOHgGXJlVHr4bC6HMG88GpHz4kI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 08:08:03.4878 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a6f9c1d-60ef-461a-8ac6-08de800e7c41
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR12MB999156
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

The flip bit setting is different if umc number is half of original
configuration.

v2: block the flip bit setting for unsupported umc configuration.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 113 +++++++++++++++++--------
 1 file changed, 80 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index 0f5b1719fda5..6cf674dfc8c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -183,50 +183,97 @@ static void umc_v12_0_get_retire_flip_bits(struct amdgpu_device *adev)
 	if (adev->gmc.gmc_funcs->query_mem_partition_mode)
 		nps = adev->gmc.gmc_funcs->query_mem_partition_mode(adev);
 
-	/* default setting */
-	flip_bits->flip_bits_in_pa[0] = UMC_V12_0_PA_C2_BIT;
-	flip_bits->flip_bits_in_pa[1] = UMC_V12_0_PA_C3_BIT;
-	flip_bits->flip_bits_in_pa[2] = UMC_V12_0_PA_C4_BIT;
-	flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R13_BIT;
-	flip_bits->flip_row_bit = 13;
-	flip_bits->bit_num = 4;
-	flip_bits->r13_in_pa = UMC_V12_0_PA_R13_BIT;
-
-	if (nps == AMDGPU_NPS2_PARTITION_MODE) {
+	if (adev->gmc.num_umc == 16) {
+		/* default setting */
+		flip_bits->flip_bits_in_pa[0] = UMC_V12_0_PA_C2_BIT;
+		flip_bits->flip_bits_in_pa[1] = UMC_V12_0_PA_C3_BIT;
+		flip_bits->flip_bits_in_pa[2] = UMC_V12_0_PA_C4_BIT;
+		flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R13_BIT;
+		flip_bits->flip_row_bit = 13;
+		flip_bits->bit_num = 4;
+		flip_bits->r13_in_pa = UMC_V12_0_PA_R13_BIT;
+
+		if (nps == AMDGPU_NPS2_PARTITION_MODE) {
+			flip_bits->flip_bits_in_pa[0] = UMC_V12_0_PA_CH5_BIT;
+			flip_bits->flip_bits_in_pa[1] = UMC_V12_0_PA_C2_BIT;
+			flip_bits->flip_bits_in_pa[2] = UMC_V12_0_PA_B1_BIT;
+			flip_bits->r13_in_pa = UMC_V12_0_PA_R12_BIT;
+		} else if (nps == AMDGPU_NPS4_PARTITION_MODE) {
+			flip_bits->flip_bits_in_pa[0] = UMC_V12_0_PA_CH4_BIT;
+			flip_bits->flip_bits_in_pa[1] = UMC_V12_0_PA_CH5_BIT;
+			flip_bits->flip_bits_in_pa[2] = UMC_V12_0_PA_B0_BIT;
+			flip_bits->r13_in_pa = UMC_V12_0_PA_R11_BIT;
+		}
+
+		switch (vram_type) {
+		case AMDGPU_VRAM_TYPE_HBM:
+			/* other nps modes are taken as nps1 */
+			if (nps == AMDGPU_NPS2_PARTITION_MODE)
+				flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R12_BIT;
+			else if (nps == AMDGPU_NPS4_PARTITION_MODE)
+				flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R11_BIT;
+
+			break;
+		case AMDGPU_VRAM_TYPE_HBM3E:
+			flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R12_BIT;
+			flip_bits->flip_row_bit = 12;
+
+			if (nps == AMDGPU_NPS2_PARTITION_MODE)
+				flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R11_BIT;
+			else if (nps == AMDGPU_NPS4_PARTITION_MODE)
+				flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R10_BIT;
+
+			break;
+		default:
+			dev_warn(adev->dev,
+				"Unknown HBM type, set RAS retire flip bits to the value in NPS1 mode.\n");
+			break;
+		}
+	} else if (adev->gmc.num_umc == 8) {
+		/* default setting */
 		flip_bits->flip_bits_in_pa[0] = UMC_V12_0_PA_CH5_BIT;
 		flip_bits->flip_bits_in_pa[1] = UMC_V12_0_PA_C2_BIT;
 		flip_bits->flip_bits_in_pa[2] = UMC_V12_0_PA_B1_BIT;
+		flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R11_BIT;
+		flip_bits->flip_row_bit = 12;
+		flip_bits->bit_num = 4;
 		flip_bits->r13_in_pa = UMC_V12_0_PA_R12_BIT;
-	} else if (nps == AMDGPU_NPS4_PARTITION_MODE) {
-		flip_bits->flip_bits_in_pa[0] = UMC_V12_0_PA_CH4_BIT;
-		flip_bits->flip_bits_in_pa[1] = UMC_V12_0_PA_CH5_BIT;
-		flip_bits->flip_bits_in_pa[2] = UMC_V12_0_PA_B0_BIT;
-		flip_bits->r13_in_pa = UMC_V12_0_PA_R11_BIT;
-	}
 
-	switch (vram_type) {
-	case AMDGPU_VRAM_TYPE_HBM:
-		/* other nps modes are taken as nps1 */
-		if (nps == AMDGPU_NPS2_PARTITION_MODE)
+		if (nps == AMDGPU_NPS2_PARTITION_MODE) {
+			flip_bits->flip_bits_in_pa[0] = UMC_V12_0_PA_CH4_BIT;
+			flip_bits->flip_bits_in_pa[1] = UMC_V12_0_PA_CH5_BIT;
+			flip_bits->flip_bits_in_pa[2] = UMC_V12_0_PA_B0_BIT;
+			flip_bits->r13_in_pa = UMC_V12_0_PA_R11_BIT;
+		}
+
+		switch (vram_type) {
+		case AMDGPU_VRAM_TYPE_HBM:
 			flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R12_BIT;
-		else if (nps == AMDGPU_NPS4_PARTITION_MODE)
-			flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R11_BIT;
 
-		break;
-	case AMDGPU_VRAM_TYPE_HBM3E:
-		flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R12_BIT;
-		flip_bits->flip_row_bit = 12;
+			/* other nps modes are taken as nps1 */
+			if (nps == AMDGPU_NPS2_PARTITION_MODE)
+				flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R11_BIT;
 
-		if (nps == AMDGPU_NPS2_PARTITION_MODE)
+			break;
+		case AMDGPU_VRAM_TYPE_HBM3E:
 			flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R11_BIT;
-		else if (nps == AMDGPU_NPS4_PARTITION_MODE)
-			flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R10_BIT;
+			flip_bits->flip_row_bit = 12;
 
-		break;
-	default:
+			if (nps == AMDGPU_NPS2_PARTITION_MODE)
+				flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R10_BIT;
+
+			break;
+		default:
+			dev_warn(adev->dev,
+				"Unknown HBM type, set RAS retire flip bits to the value in NPS1 mode.\n");
+			break;
+		}
+	} else {
 		dev_warn(adev->dev,
-			"Unknown HBM type, set RAS retire flip bits to the value in NPS1 mode.\n");
-		break;
+			"Unsupported UMC number(%d), failed to set RAS flip bits.\n",
+			adev->gmc.num_umc);
+
+		return;
 	}
 
 	adev->umc.retire_unit = 0x1 << flip_bits->bit_num;
-- 
2.34.1

