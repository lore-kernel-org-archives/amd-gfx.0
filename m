Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9FA1C3ABA9
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Apr 2025 08:26:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EA1810E701;
	Wed, 30 Apr 2025 08:26:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g48DvCVk";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 211FD10E6FB
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Apr 2025 08:26:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r/baFbVAOrBh9Uce8uj492B0aillVkNCAIIfGn1X7Ob84KD3CZIs1ku8g18y0V/5p+eupr5tcUIQXPEiIfDbtOKRy6anlsbKIK/A9gi+r1MUcyDBB/7NctijqAAAeCxtqCgFCS+aWB1ciKDmmQ3IKd2u+EPe31UXqc7m48gCQbYblmHUkIB3RhmvAKXrB5RQXcnk0VaK89IvQw8ugwEFTAHkCabocOXHElsBTUC2yAfqZqBl5LY+LoDpxH6miZ8evUUozKJD6mDcnLARR+y6lPg6Pw0CYa8ISeFwUgRcwuGa8RXYmzyzYhb3IlGDOJ2CifKkxgcdtBtP4FsmfpcEBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WSJBr+wV4Bxv0TQKJiY82cU0PHF9UYYIJay96fRy0Ms=;
 b=PVxgMwm5LlxMVDp7B+H88noa4mKLFfSNOdc/hpsy534NmqoQNII7eHqZCtzRikGXeZsR2iFcn97zsyXzp+b8omYY3QruIZHMZ1ftpqVViggx4IuPY/HawLd7q5HZFIzbsgkD/s+Dznc2PdMZV7Icex9DAASzubp1Xio58J0khUs3GRxbScwFu8p+xrcx007cVk9hlh0gt00qnDas5rLd7YGgVfeYZPxgG4tJXPH3u7uDGJrnsao3sB8Vkm3wJb/QNLto99dHNEpP2fFEBL6tt4lqTK3rhS7tnLw2Mjbj14ZLnfuUDyMwwNBDc/dqpXTeLWBwDV8BKlox5zkIPcKwog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WSJBr+wV4Bxv0TQKJiY82cU0PHF9UYYIJay96fRy0Ms=;
 b=g48DvCVkb+oa79YqsPDkohZgaG+u7GMUJ1xdycmSfoZfqFNZ2XRZ6yp1syMsGwNivMi8GYWJNP3Ov6jEqCE7cCTlW+Aeb2xQ8SBuYyKu2XPodoeSIY6HLoWBWb0d5lecnBwRSxj3fqbJFq3/V+KoXogq6FOnGfDlAQXhciTFBZI=
Received: from BY3PR10CA0005.namprd10.prod.outlook.com (2603:10b6:a03:255::10)
 by SA0PR12MB7073.namprd12.prod.outlook.com (2603:10b6:806:2d5::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 30 Apr
 2025 08:26:08 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:a03:255:cafe::63) by BY3PR10CA0005.outlook.office365.com
 (2603:10b6:a03:255::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.38 via Frontend Transport; Wed,
 30 Apr 2025 08:26:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.20 via Frontend Transport; Wed, 30 Apr 2025 08:26:07 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Apr
 2025 03:26:05 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH 5/7] drm/amdgu: get RAS retire flip bits for new type of HBM
Date: Wed, 30 Apr 2025 16:25:48 +0800
Message-ID: <20250430082550.60109-5-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250430082550.60109-1-tao.zhou1@amd.com>
References: <20250430082550.60109-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|SA0PR12MB7073:EE_
X-MS-Office365-Filtering-Correlation-Id: a07b8edd-a888-45a7-63f7-08dd87c0a795
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024|30052699003; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mkHcH6viYyDOTo/HafUzWYOGTe/fHuNjFhiHrBjkict7MuurjJh0PtseTCu2?=
 =?us-ascii?Q?m09zWwEvMI6TsO2G2cAi77yPD43ulA1It8ss/OnDRYuTZqU/7EFQlqAdzmyv?=
 =?us-ascii?Q?pD6Oqa4zNHPw7zK3ERgWZdFdBslzWI09aFdRyerBvSZe+V3CVZdDawnWHks3?=
 =?us-ascii?Q?Wdj+ROda94RQ6UlTtuzDAdMlkefk+961kVanTmbMdEq3+6xzGJSv2a6no3L/?=
 =?us-ascii?Q?ulNVZ4xubqlxIF5HqYEGiBqOZ2Sh7BAdX0uMuABEdljUC0bM9+eoP6+GSltV?=
 =?us-ascii?Q?E7Vmew+yN/L5CXLJQRjnjl4+3xMz2uVgUzedRibSAlzYJ0XRPEXkJgRR1It7?=
 =?us-ascii?Q?9OyFh4HbvymCYCLexTTYXmeS1hzY7feH+2+eNVh91C7pFXSkqTbMheLFpSvl?=
 =?us-ascii?Q?jfNREvvE69kjwOIHGRFYBZr8TaB+XNaJSUj2hFB0s1jMJ0jA0B1p8TthZyRA?=
 =?us-ascii?Q?2VVQFyNtEAYqRuApwbxfx5+xR8XjXyHdqIF0ZxNw4inGnDOKtLykHCnmnX7a?=
 =?us-ascii?Q?hfNGT6ihRo6e/Q9xYhqkki35Vvekr13S0UZf7exn5PkPHVHm5hkQMjVmbC2U?=
 =?us-ascii?Q?0KZvW7TfBWirJhIQLLIQStxHMzKtnBMcP6XwaeZhDsKGTfhWiUdnsEwSXOJM?=
 =?us-ascii?Q?I50skJqIjCCByD94xKAVYoGgqQ7TKxkgGRTJFDpmkxOeKj13bMjK+yAhlDSB?=
 =?us-ascii?Q?xqUl53ssGoSvJ+5jzawWREB7w0qhyLiMoRJihIBnWLWIbWi/f7iCPDBuse3q?=
 =?us-ascii?Q?p1ALttL82/Z5IrhEIJtlqy9TaxSiFtl/297yNp0PJxSbiYOyx17/N7jM6xEZ?=
 =?us-ascii?Q?i6Haju2q+PjicH8JqI4vy98gfj8uEITH7TtecegupZ1XVm+8bnrqC134fD1j?=
 =?us-ascii?Q?+c0s7gY0nIDs64n0Ocmhm2LMgkqN1Otj3eHLI1gYN7ryCpOFG/Fjik4+M5sA?=
 =?us-ascii?Q?a3oUMHNxxwwPkFfMUy+/269fpCFTkI6W+LwnMItM7gV77jbT67rw0dCJw/Q5?=
 =?us-ascii?Q?eTUUJhjm+/8W6Uf2BikUl391ntYTYZ+l4hYjQtV44XCcatALm/w988w2n0bc?=
 =?us-ascii?Q?XCNycYNbf+3DVgq9xPG6hRof9fr0FwKm8kMm2nQDNUbA78EOnj2BthqwH5r8?=
 =?us-ascii?Q?OaazV3ghsaMkSg2eHmxW5ySVdvmURxdOJ3c/hB0L16vrKlZLDU91KVBza5Sn?=
 =?us-ascii?Q?PYnHs4+tNg/xm4lwFouL+CdtJmjCwvd84GwvMIyXob1W5zMhWkpqkPo44TPO?=
 =?us-ascii?Q?JD9b6ntVCuulrHmByt1uTrvDF4XSdKfejd6CgWQfu16xrMrmSrUgT/R8ZasA?=
 =?us-ascii?Q?db31E5KeN4KaEkiVOTxyucbEO6bWfGyHGFIxIWP82wa//iet5RGeJ3rNsIv9?=
 =?us-ascii?Q?VGgBiBqYm5AA9Iy27M3fqsoLH1NcdIitsopuWhu4O65H6xjLR4JaT28bJapG?=
 =?us-ascii?Q?KGDOay9hOxu8t6ByFVGxWxHq0MBG3gL3Emb+hZrqQAWWGtaV4+9TDw0Mpjws?=
 =?us-ascii?Q?rMJN68D/99JvAnNw2TK7vuPlWCViX8fYGyOj?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(30052699003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 08:26:07.0928 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a07b8edd-a888-45a7-63f7-08dd87c0a795
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7073
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

Get RAS retire flip bits for HBM with different types and vendors
in various NPS modes.
Also set flip row bit and MCA R13 bit in PA in different NPS modes.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 47 ++++++++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.h |  1 +
 2 files changed, 38 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index 05e3b34927c4..f9076feb5a24 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -24,6 +24,7 @@
 #include "amdgpu_ras.h"
 #include "amdgpu_umc.h"
 #include "amdgpu.h"
+#include "atom.h"
 #include "umc/umc_12_0_0_offset.h"
 #include "umc/umc_12_0_0_sh_mask.h"
 #include "mp/mp_13_0_6_sh_mask.h"
@@ -178,6 +179,7 @@ static void umc_v12_0_get_retire_flip_bits(struct amdgpu_device *adev)
 {
 	enum amdgpu_memory_partition nps = AMDGPU_NPS1_PARTITION_MODE;
 	uint32_t vram_type = adev->gmc.vram_type;
+	uint8_t hbm_vendor = adev->gmc.vram_vendor;
 	struct amdgpu_umc_flip_bits *flip_bits = &(adev->umc.flip_bits);
 
 	if (adev->gmc.gmc_funcs->query_mem_partition_mode)
@@ -188,23 +190,48 @@ static void umc_v12_0_get_retire_flip_bits(struct amdgpu_device *adev)
 	flip_bits->flip_bits_in_pa[1] = UMC_V12_0_PA_C3_BIT;
 	flip_bits->flip_bits_in_pa[2] = UMC_V12_0_PA_C4_BIT;
 	flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R13_BIT;
+	flip_bits->flip_row_bit = 13;
 	flip_bits->bit_num = 4;
+	flip_bits->r13_in_pa = UMC_V12_0_PA_R13_BIT;
+
+	if (nps == AMDGPU_NPS2_PARTITION_MODE) {
+		flip_bits->flip_bits_in_pa[0] = UMC_V12_0_PA_CH5_BIT;
+		flip_bits->flip_bits_in_pa[1] = UMC_V12_0_PA_C2_BIT;
+		flip_bits->flip_bits_in_pa[2] = UMC_V12_0_PA_B1_BIT;
+		flip_bits->r13_in_pa = UMC_V12_0_PA_R12_BIT;
+	} else if (nps == AMDGPU_NPS4_PARTITION_MODE) {
+		flip_bits->flip_bits_in_pa[0] = UMC_V12_0_PA_CH4_BIT;
+		flip_bits->flip_bits_in_pa[1] = UMC_V12_0_PA_CH5_BIT;
+		flip_bits->flip_bits_in_pa[2] = UMC_V12_0_PA_B0_BIT;
+		flip_bits->r13_in_pa = UMC_V12_0_PA_R11_BIT;
+	}
 
 	switch (vram_type) {
 	case AMDGPU_VRAM_TYPE_HBM:
 		/* other nps modes are taken as nps1 */
-		if (nps == AMDGPU_NPS2_PARTITION_MODE) {
-			flip_bits->flip_bits_in_pa[0] = UMC_V12_0_PA_CH5_BIT;
-			flip_bits->flip_bits_in_pa[1] = UMC_V12_0_PA_C2_BIT;
-			flip_bits->flip_bits_in_pa[2] = UMC_V12_0_PA_B1_BIT;
+		if (nps == AMDGPU_NPS2_PARTITION_MODE)
 			flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R12_BIT;
-		}
-
-		if (nps == AMDGPU_NPS4_PARTITION_MODE) {
-			flip_bits->flip_bits_in_pa[0] = UMC_V12_0_PA_CH4_BIT;
-			flip_bits->flip_bits_in_pa[1] = UMC_V12_0_PA_CH5_BIT;
-			flip_bits->flip_bits_in_pa[2] = UMC_V12_0_PA_B0_BIT;
+		else if (nps == AMDGPU_NPS4_PARTITION_MODE)
 			flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R11_BIT;
+
+		break;
+	case AMDGPU_VRAM_TYPE_HBM3E:
+		if (hbm_vendor == SAMSUNG) {
+			flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R12_BIT;
+			flip_bits->flip_row_bit = 12;
+
+			if (nps == AMDGPU_NPS2_PARTITION_MODE)
+				flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R11_BIT;
+			else if (nps == AMDGPU_NPS4_PARTITION_MODE)
+				flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R10_BIT;
+		} else if (hbm_vendor == HYNIX) {
+			flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R0_BIT;
+			flip_bits->flip_row_bit = 0;
+
+			if (nps == AMDGPU_NPS2_PARTITION_MODE)
+				flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_C4_BIT;
+			else if (nps == AMDGPU_NPS4_PARTITION_MODE)
+				flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_B1_BIT;
 		}
 
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
index ccdd6cd430f8..63b7e7254526 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
@@ -62,6 +62,7 @@
 #define UMC_V12_0_PA_C4_BIT 21
 /* row bits in SOC physical address */
 #define UMC_V12_0_PA_R0_BIT 22
+#define UMC_V12_0_PA_R10_BIT 32
 #define UMC_V12_0_PA_R11_BIT 33
 #define UMC_V12_0_PA_R12_BIT 34
 #define UMC_V12_0_PA_R13_BIT 35
-- 
2.34.1

