Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 718BCC55174
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2026 08:42:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C44F810ED7C;
	Wed,  5 Aug 2026 08:42:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uB2azsxO";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012057.outbound.protection.outlook.com
 [40.107.200.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F1AC10ED7C
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2026 08:42:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qH+uaEC59F0rXaSBT8Z+LSKXMVEiq1MthqkYakwZ3pPVmx/oudo0f8xabUenCKVZ2Rw54zBmIw2+jlCMdzxmYyIxFyTS/8RtrNN0yzNqdQyV+11LY8Z1meqB58OUNcICh9/hfD2wuPmqJ6fQ9A7t5PpXAAhYO1nH4jvmaZ9d5JT4QgI4VNENEBwXqfRP6vcSQ9JCdGBfTQruw8Weys5SlBIwb9INCGqeZwtipTqt3GRBIRKPXNROCXS9c9TukKIhvuElq07Ftke1SehS5CAUlxtQ8YZYImgmyxzwfZlbXoCN8d0+eoAAyMrfigmBPJdjN7Yw1f5lXhCX+PxXrU+oMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U59nuah544pWiRErN/fvxkUeqCawJ/KCxkV9NSLtRIg=;
 b=GTw6IKIQsxMSv/MDntrlZmZLobkiJfuR8pYCK/qxLlv2jJwohE4iHlXfOSMl5GemaPTJMNRr6JO73CwqqNxglrmKHnXpFThtWlZ9ad/XMafMsKXlOSac623eq6NT37WzSJmYs3lRmVeu2hjb+OGx2IqaJtXP4G2REnCGB25z0rL4m4KEOHY840DsggK9bz+U5QFOnwUe0Z92u8sjJffLqLNEqioCbzM4u11EmBgYuuFXISTAK1PG0HcVMkzkHQjoopRjuJO3ENjwyr9S8TAqp/N9llJOCbeCwRH3aVsebJSSgKxvG5+vlygoj7XxDHhdLrP4Zpic+vFQKNZ/7H+VuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U59nuah544pWiRErN/fvxkUeqCawJ/KCxkV9NSLtRIg=;
 b=uB2azsxOvbYAGJiehEiU1aA6MUQFWLPcwRDKoOl24adZFJEBLVlz0yhQBwxI0boR0G83b1JtyO4YiI+MXtd4dRrF+B6r9JkTAVtqUtLVU5lg0+lncnT+TDQbfjPwWCose6e9zHce31vwrpjUfTE3i6R3SfDomDzJLsJeZy6Fx/0=
Received: from MN2PR05CA0042.namprd05.prod.outlook.com (2603:10b6:208:236::11)
 by BL4PR12MB9484.namprd12.prod.outlook.com (2603:10b6:208:58e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Wed, 5 Aug
 2026 08:41:54 +0000
Received: from MN1PEPF0000ECDB.namprd02.prod.outlook.com
 (2603:10b6:208:236:cafe::32) by MN2PR05CA0042.outlook.office365.com
 (2603:10b6:208:236::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.16 via Frontend Transport; Wed, 5
 Aug 2026 08:41:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECDB.mail.protection.outlook.com (10.167.242.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Wed, 5 Aug 2026 08:41:54 +0000
Received: from shubhankar-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Wed, 5 Aug 2026 03:41:52 -0500
From: Shubhankar Milind Sardeshpande <Shubhankar.MilindSardeshpande@amd.com>
To: <Alexander.Deucher@amd.com>, <Pratik.Vishwakarma@amd.com>,
 <Christian.Koenig@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <Shubhankar.MilindSardeshpande@amd.com>,
 <Veerabadhran.Gopalakrishnan@amd.com>
Subject: [PATCH 1/3] Revert "drm/amdgpu: add support for NBIO IP version
 7.11.5"
Date: Wed, 5 Aug 2026 14:08:26 +0530
Message-ID: <20260805084114.1767743-1-Shubhankar.MilindSardeshpande@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDB:EE_|BL4PR12MB9484:EE_
X-MS-Office365-Filtering-Correlation-Id: fa74fbe4-f16c-43e3-e065-08def2cd673c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|56012099006|10067099003|11063799006|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: 08mu0kFMYrbqwQ+1ZELTBCqZP6cXWjuBuFfaWmHbmAIymAlz+VkaQPXTuUOuArK/6yFi8O1LKWpqto9TSK/B+ZfRCIOeS/Y9CbRfiwQJmmg4hjpRHzCUXNpKGiBvR8doYCEVnG3LXXi1/8xCWm5wbEAxy7i1opFAbLaGkCVaB+A5CuZHvNNVEhq0uSsMLkhXy+wlM/V96g0g8pPWRZGwrTZg5Vh4BF9vq2bWGfiR246AUutnsiQ0z/imw4JmV/wCrzfKrVqZP6Fd+3f5RxaHPcx+KnHrDp6jkKEU8RlKkT/g3TtT5crpSuTv6einvg8bBCdw4+dK97psWsxZIwO77KUAl3KvfRpQhbL3g7nwELkwqqNsYYNZQdcTAxWr7CIPPNL4sRAW6CFIZVskdtPWC1Jo4xqjaolnsvd2Qiv5XX3nkeimQdRwUojy2IZcnKw5h863h82O3OZvVpzO+gPOd4c1EjW5/rBweY7JqXvoKSPb8/l+HZUMbuh7CqOtCHiMCLIwKTOxyPU+rZ2Z313vKbn1LIxx+wI7ZQ1kubml5QeRDV9PCJb6AL/KDcaRpK3YjBArOu7tTbZovPBxUfJHsYOwoznrXLJfGymTxTVqpIyBqlRSz/X/ktZ0IP9gduZoAe1qt7pTJRhtlVolHRuKM8K9rdfDpKiCyiHF1BBBLVV8si9OnZ9aFd8p0kwQYSNzjnLjPjdVfiHb4/g6VMtdFA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(56012099006)(10067099003)(11063799006)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vGR8Lsi1S6F6Z90A2ELWOGvPFWQ/MfogPexpAieIMKXhGH8oIdYLp/sFQNUhwmNxk4n2JQ3WxbyMSzxyLa5XvnimnGNHksk3IJx4MpcffCX+LFRMyyJ27vwZPv5z+LBHjZ7Sycv68qAdzDfon0zsHnvWQN2HtYpgv6CkCfurCGl7IaiMw6e2Z6+4C61A/WQraae5vAB4UpSCmB7wrHdFfsCWl6VRh6OVYzy51N128SYIWKqkPBGyTiyAaUfMlS6R8owkB2wydcfySyPWhqVpB2dHmP/NY+sNw3cqdHIn95zBs6xh+HcKyeLDse8itrgNVySBSUtsO3UwHIY8iWekM6mMZnQKFHPdpM8vcE2A/DG0oCaW9phrWq4XJebZ6mga9w4lOTa7OikNI+kCEx6egmG8QpKVH/ZF0aH/+rIkxL/a93iWkk5A1uVCHeWRaeak
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 08:41:54.7010 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa74fbe4-f16c-43e3-e065-08def2cd673c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9484
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

This reverts commit 74ab07e3290ff38b31448af7bcf2085cadbb5e1a.

Signed-off-by: Shubhankar Milind Sardeshpande <Shubhankar.MilindSardeshpande@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   1 -
 drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c      | 153 +++++-------------
 2 files changed, 36 insertions(+), 118 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index a404d8aa13ee..b5a25ca2e901 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -3488,7 +3488,6 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		break;
 	case IP_VERSION(6, 3, 1):
 	case IP_VERSION(7, 11, 4):
-	case IP_VERSION(7, 11, 5):
 		adev->nbio.funcs = &nbif_v6_3_1_funcs;
 		adev->nbio.hdp_flush_reg = &nbif_v6_3_1_hdp_flush_reg;
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c b/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
index 000516b5845a..57b0cf817afb 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
@@ -57,56 +57,12 @@
 #define regRCC_STRAP0_RCC_DEV0_EPF0_STRAP0_nbif_4_10                                    0x0021
 #define regRCC_STRAP0_RCC_DEV0_EPF0_STRAP0_nbif_4_10_BASE_IDX                           2
 
-#define regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_HIGH_nbio_7_11_5                  0x8e13
-#define regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_HIGH_nbio_7_11_5_BASE_IDX         5
-#define regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_LOW_nbio_7_11_5                   0x8e14
-#define regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_LOW_nbio_7_11_5_BASE_IDX          5
-#define regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_CNTL_nbio_7_11_5                       0x8e15
-#define regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_CNTL_nbio_7_11_5_BASE_IDX              5
-
-#define regBIF_BX1_REMAP_HDP_MEM_FLUSH_CNTL_nbio_7_11_5                                 0x012d
-#define regBIF_BX1_REMAP_HDP_MEM_FLUSH_CNTL_nbio_7_11_5_BASE_IDX                        2
-#define regBIF_BX1_REMAP_HDP_REG_FLUSH_CNTL_nbio_7_11_5                                 0x012e
-#define regBIF_BX1_REMAP_HDP_REG_FLUSH_CNTL_nbio_7_11_5_BASE_IDX                        2
-
-#define regRCC_STRAP1_RCC_DEV0_EPF0_STRAP0_nbio_7_11_5                                  0x0021
-#define regRCC_STRAP1_RCC_DEV0_EPF0_STRAP0_nbio_7_11_5_BASE_IDX                         2
-
-#define regBIF_BX1_BIF_FB_EN_nbio_7_11_5                                                0x0100
-#define regBIF_BX1_BIF_FB_EN_nbio_7_11_5_BASE_IDX                                       2
-
-#define regBIF_BX1_INTERRUPT_CNTL_nbio_7_11_5                                           0x00f1
-#define regBIF_BX1_INTERRUPT_CNTL_nbio_7_11_5_BASE_IDX                                  2
-#define regBIF_BX1_INTERRUPT_CNTL2_nbio_7_11_5                                          0x00f2
-#define regBIF_BX1_INTERRUPT_CNTL2_nbio_7_11_5_BASE_IDX                                 2
-
-#define regBIF_BX_PF1_GPU_HDP_FLUSH_REQ_nbio_7_11_5                                     0x0106
-#define regBIF_BX_PF1_GPU_HDP_FLUSH_REQ_nbio_7_11_5_BASE_IDX                            2
-#define regBIF_BX_PF1_GPU_HDP_FLUSH_DONE_nbio_7_11_5                                    0x0107
-#define regBIF_BX_PF1_GPU_HDP_FLUSH_DONE_nbio_7_11_5_BASE_IDX                           2
-
-#define regBIF_BX_PF1_HDP_MEM_COHERENCY_FLUSH_CNTL_nbio_7_11_5                          0x00f7
-#define regBIF_BX_PF1_HDP_MEM_COHERENCY_FLUSH_CNTL_nbio_7_11_5_BASE_IDX                 2
-
-//BIF_BX1_BIF_FB_EN
-#define BIF_BX1_BIF_FB_EN__FB_READ_EN__SHIFT_nbio_7_11_5                                0x0
-#define BIF_BX1_BIF_FB_EN__FB_WRITE_EN__SHIFT_nbio_7_11_5                               0x1
-#define BIF_BX1_BIF_FB_EN__FB_READ_EN_MASK_nbio_7_11_5                                  0x00000001L
-#define BIF_BX1_BIF_FB_EN__FB_WRITE_EN_MASK_nbio_7_11_5                                 0x00000002L
-
 static void nbif_v6_3_1_remap_hdp_registers(struct amdgpu_device *adev)
 {
-	if (amdgpu_ip_version(adev, NBIO_HWIP, 0) == IP_VERSION(7, 11, 5)) {
-		WREG32_SOC15(NBIO, 0, regBIF_BX1_REMAP_HDP_MEM_FLUSH_CNTL_nbio_7_11_5,
-			adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL);
-		WREG32_SOC15(NBIO, 0, regBIF_BX1_REMAP_HDP_REG_FLUSH_CNTL_nbio_7_11_5,
-			adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_REG_FLUSH_CNTL);
-	} else {
-		WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_MEM_FLUSH_CNTL,
-			adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL);
-		WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_REG_FLUSH_CNTL,
-			adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_REG_FLUSH_CNTL);
-	}
+	WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_MEM_FLUSH_CNTL,
+		adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL);
+	WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_REG_FLUSH_CNTL,
+		adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_REG_FLUSH_CNTL);
 }
 
 static u32 nbif_v6_3_1_get_rev_id(struct amdgpu_device *adev)
@@ -115,8 +71,6 @@ static u32 nbif_v6_3_1_get_rev_id(struct amdgpu_device *adev)
 
 	if (amdgpu_ip_version(adev, NBIO_HWIP, 0) == IP_VERSION(7, 11, 4))
 		tmp = RREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_DEV0_EPF0_STRAP0_nbif_4_10);
-	else if (amdgpu_ip_version(adev, NBIO_HWIP, 0) == IP_VERSION(7, 11, 5))
-		tmp = RREG32_SOC15(NBIO, 0, regRCC_STRAP1_RCC_DEV0_EPF0_STRAP0_nbio_7_11_5);
 	else
 		tmp = RREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_DEV0_EPF0_STRAP0);
 
@@ -128,21 +82,12 @@ static u32 nbif_v6_3_1_get_rev_id(struct amdgpu_device *adev)
 
 static void nbif_v6_3_1_mc_access_enable(struct amdgpu_device *adev, bool enable)
 {
-	if (amdgpu_ip_version(adev, NBIO_HWIP, 0) == IP_VERSION(7, 11, 5)) {
-		if (enable)
-			WREG32_SOC15(NBIO, 0, regBIF_BX1_BIF_FB_EN_nbio_7_11_5,
-				     BIF_BX1_BIF_FB_EN__FB_READ_EN_MASK_nbio_7_11_5 |
-				     BIF_BX1_BIF_FB_EN__FB_WRITE_EN_MASK_nbio_7_11_5);
-		else
-			WREG32_SOC15(NBIO, 0, regBIF_BX1_BIF_FB_EN_nbio_7_11_5, 0);
-	} else {
-		if (enable)
-			WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_FB_EN,
-				     BIF_BX0_BIF_FB_EN__FB_READ_EN_MASK |
-				     BIF_BX0_BIF_FB_EN__FB_WRITE_EN_MASK);
-		else
-			WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_FB_EN, 0);
-	}
+	if (enable)
+		WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_FB_EN,
+			     BIF_BX0_BIF_FB_EN__FB_READ_EN_MASK |
+			     BIF_BX0_BIF_FB_EN__FB_WRITE_EN_MASK);
+	else
+		WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_FB_EN, 0);
 }
 
 static u32 nbif_v6_3_1_get_memsize(struct amdgpu_device *adev)
@@ -155,14 +100,8 @@ static void nbif_v6_3_1_sdma_doorbell_range(struct amdgpu_device *adev,
 					    int doorbell_index,
 					    int doorbell_size)
 {
-	u32 doorbell_range;
 	if (instance == 0) {
-		if (amdgpu_ip_version(adev, NBIO_HWIP, 0) >= IP_VERSION(7, 11, 4))
-			doorbell_range = RREG32_SOC15(NBIO, 0,
-					regGDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL_nbif_4_10);
-		else
-			doorbell_range = RREG32_SOC15(NBIO, 0,
-					regGDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL);
+		u32 doorbell_range = RREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL);
 
 		if (use_doorbell) {
 			doorbell_range = REG_SET_FIELD(doorbell_range,
@@ -191,10 +130,12 @@ static void nbif_v6_3_1_sdma_doorbell_range(struct amdgpu_device *adev,
 						       S2A_DOORBELL_PORT2_RANGE_SIZE,
 						       0);
 
-		if (amdgpu_ip_version(adev, NBIO_HWIP, 0) >= IP_VERSION(7, 11, 4))
-			WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL_nbif_4_10, doorbell_range);
+		if (amdgpu_ip_version(adev, NBIO_HWIP, 0) == IP_VERSION(7, 11, 4))
+			WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL_nbif_4_10,
+				     doorbell_range);
 		else
-			WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL, doorbell_range);
+			WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL,
+				     doorbell_range);
 	}
 }
 
@@ -239,15 +180,15 @@ static void nbif_v6_3_1_vcn_doorbell_range(struct amdgpu_device *adev,
 					       S2A_DOORBELL_PORT4_RANGE_SIZE,
 					       0);
 
-	if (amdgpu_ip_version(adev, NBIO_HWIP, 0) >= IP_VERSION(7, 11, 4))
-		WREG32_SOC15(NBIO, 0,
-				regGDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL_nbif_4_10,
-				doorbell_range);
-	else
+	if (amdgpu_ip_version(adev, NBIO_HWIP, 0) == IP_VERSION(7, 11, 4)) {
+		WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL_nbif_4_10,
+			     doorbell_range);
+	} else {
 		if (instance)
 			WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL, doorbell_range);
 		else
 			WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL, doorbell_range);
+	}
 }
 
 static void nbif_v6_3_1_vpe_doorbell_range(struct amdgpu_device *adev,
@@ -299,7 +240,7 @@ static void nbif_v6_3_1_vpe_doorbell_range(struct amdgpu_device *adev,
 
 static void nbif_v6_3_1_gc_doorbell_init(struct amdgpu_device *adev)
 {
-	if (amdgpu_ip_version(adev, NBIO_HWIP, 0) >= IP_VERSION(7, 11, 4)) {
+	if (amdgpu_ip_version(adev, NBIO_HWIP, 0) == IP_VERSION(7, 11, 4)) {
 		WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL_nbif_4_10, 0x30000007);
 		WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL_nbif_4_10, 0x3000000d);
 	} else {
@@ -341,13 +282,7 @@ nbif_v6_3_1_enable_doorbell_selfring_aperture(struct amdgpu_device *adev,
 static void nbif_v6_3_1_ih_doorbell_range(struct amdgpu_device *adev,
 					  bool use_doorbell, int doorbell_index)
 {
-	u32 ih_doorbell_range;
-
-	if (amdgpu_ip_version(adev, NBIO_HWIP, 0) >= IP_VERSION(7, 11, 4))
-		ih_doorbell_range = RREG32_SOC15(NBIO, 0,
-				regGDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL_nbif_4_10);
-	else
-		ih_doorbell_range = RREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL);
+	u32 ih_doorbell_range = RREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL);
 
 	if (use_doorbell) {
 		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
@@ -376,11 +311,12 @@ static void nbif_v6_3_1_ih_doorbell_range(struct amdgpu_device *adev,
 						  S2A_DOORBELL_PORT1_RANGE_SIZE,
 						  0);
 
-	if (amdgpu_ip_version(adev, NBIO_HWIP, 0) >= IP_VERSION(7, 11, 4))
+	if (amdgpu_ip_version(adev, NBIO_HWIP, 0) == IP_VERSION(7, 11, 4))
 		WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL_nbif_4_10,
-				ih_doorbell_range);
+			     ih_doorbell_range);
 	else
-		WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL, ih_doorbell_range);
+		WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL,
+			     ih_doorbell_range);
 }
 
 static void nbif_v6_3_1_ih_control(struct amdgpu_device *adev)
@@ -388,13 +324,9 @@ static void nbif_v6_3_1_ih_control(struct amdgpu_device *adev)
 	u32 interrupt_cntl;
 
 	/* setup interrupt control */
-	if (amdgpu_ip_version(adev, NBIO_HWIP, 0) == IP_VERSION(7, 11, 5))
-		WREG32_SOC15(NBIO, 0, regBIF_BX1_INTERRUPT_CNTL2_nbio_7_11_5,
-				adev->dummy_page_addr >> 8);
-	else
-		WREG32_SOC15(NBIO, 0, regBIF_BX0_INTERRUPT_CNTL2, adev->dummy_page_addr >> 8);
+	WREG32_SOC15(NBIO, 0, regBIF_BX0_INTERRUPT_CNTL2, adev->dummy_page_addr >> 8);
 
-	interrupt_cntl = RREG32_SOC15(NBIO, 0, regBIF_BX1_INTERRUPT_CNTL_nbio_7_11_5);
+	interrupt_cntl = RREG32_SOC15(NBIO, 0, regBIF_BX0_INTERRUPT_CNTL);
 	/*
 	 * BIF_BX0_INTERRUPT_CNTL__IH_DUMMY_RD_OVERRIDE_MASK=0 - dummy read disabled with msi, enabled without msi
 	 * BIF_BX0_INTERRUPT_CNTL__IH_DUMMY_RD_OVERRIDE_MASK=1 - dummy read controlled by IH_DUMMY_RD_EN
@@ -406,10 +338,7 @@ static void nbif_v6_3_1_ih_control(struct amdgpu_device *adev)
 	interrupt_cntl = REG_SET_FIELD(interrupt_cntl, BIF_BX0_INTERRUPT_CNTL,
 				       IH_REQ_NONSNOOP_EN, 0);
 
-	if (amdgpu_ip_version(adev, NBIO_HWIP, 0) == IP_VERSION(7, 11, 5))
-		WREG32_SOC15(NBIO, 0, regBIF_BX1_INTERRUPT_CNTL_nbio_7_11_5, interrupt_cntl);
-	else
-		WREG32_SOC15(NBIO, 0, regBIF_BX0_INTERRUPT_CNTL, interrupt_cntl);
+	WREG32_SOC15(NBIO, 0, regBIF_BX0_INTERRUPT_CNTL, interrupt_cntl);
 }
 
 static void
@@ -432,23 +361,17 @@ nbif_v6_3_1_get_clockgating_state(struct amdgpu_device *adev,
 
 static u32 nbif_v6_3_1_get_hdp_flush_req_offset(struct amdgpu_device *adev)
 {
-	if (amdgpu_ip_version(adev, NBIO_HWIP, 0) == IP_VERSION(7, 11, 5))
-		return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF1_GPU_HDP_FLUSH_REQ_nbio_7_11_5);
-	else
-		return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF0_GPU_HDP_FLUSH_REQ);
+	return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF0_GPU_HDP_FLUSH_REQ);
 }
 
 static u32 nbif_v6_3_1_get_hdp_flush_done_offset(struct amdgpu_device *adev)
 {
-	if (amdgpu_ip_version(adev, NBIO_HWIP, 0) == IP_VERSION(7, 11, 5))
-		return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF1_GPU_HDP_FLUSH_DONE_nbio_7_11_5);
-	else
-		return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF0_GPU_HDP_FLUSH_DONE);
+	return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF0_GPU_HDP_FLUSH_DONE);
 }
 
 static u32 nbif_v6_3_1_get_pcie_index_offset(struct amdgpu_device *adev)
 {
-	if (amdgpu_ip_version(adev, NBIO_HWIP, 0) >= IP_VERSION(7, 11, 4))
+	if (amdgpu_ip_version(adev, NBIO_HWIP, 0) == IP_VERSION(7, 11, 4))
 		return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX0_PCIE_INDEX);
 	else
 		return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF0_RSMU_INDEX);
@@ -456,7 +379,7 @@ static u32 nbif_v6_3_1_get_pcie_index_offset(struct amdgpu_device *adev)
 
 static u32 nbif_v6_3_1_get_pcie_data_offset(struct amdgpu_device *adev)
 {
-	if (amdgpu_ip_version(adev, NBIO_HWIP, 0) >= IP_VERSION(7, 11, 4))
+	if (amdgpu_ip_version(adev, NBIO_HWIP, 0) == IP_VERSION(7, 11, 4))
 		return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX0_PCIE_DATA);
 	else
 		return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF0_RSMU_DATA);
@@ -626,12 +549,8 @@ static void nbif_v6_3_1_set_reg_remap(struct amdgpu_device *adev)
 		adev->rmmio_remap.reg_offset = MMIO_REG_HOLE_OFFSET;
 		adev->rmmio_remap.bus_addr = adev->rmmio_base + MMIO_REG_HOLE_OFFSET;
 	} else {
-		if (amdgpu_ip_version(adev, NBIO_HWIP, 0) == IP_VERSION(7, 11, 5))
-			adev->rmmio_remap.reg_offset = SOC15_REG_OFFSET(NBIO, 0,
-				regBIF_BX_PF1_HDP_MEM_COHERENCY_FLUSH_CNTL_nbio_7_11_5) << 2;
-		else
-			adev->rmmio_remap.reg_offset = SOC15_REG_OFFSET(NBIO, 0,
-				regBIF_BX_PF0_HDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
+		adev->rmmio_remap.reg_offset = SOC15_REG_OFFSET(NBIO, 0,
+			regBIF_BX_PF0_HDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
 		adev->rmmio_remap.bus_addr = 0;
 	}
 }
-- 
2.43.0

