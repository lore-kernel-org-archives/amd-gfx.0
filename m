Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D08C0CD5BD1
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2026 06:42:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67DF810ECB2;
	Thu, 28 May 2026 06:42:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XaNvDZpI";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010047.outbound.protection.outlook.com
 [52.101.193.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28CEA10ECAD
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2026 06:42:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WV8+BDJ04A1O8tZyHM3dQQ44Ffe0L7dsDVHZleUYdN5r/7pQRODHtApkkMOiqJlz1b62Nv++IBCQ2eo4qvFPl52gA0UsAS/OkSEPs80f5IC+aTjNVhnygBvYEsyUzxWF4Iq3rtnlAhHVTCShr+wEoatjI9miTJ9X48PlwniZ/tjLAT6Yzv3cCmnkdHgKUjwWUQ92x8wDSsQQsKFjHlfD+saM/MbeHCEv4onja9quLfXDxGdYWTNQ1ZwVv5erGFJWQ01E1oMdZrnwYkRUvmHXy8WWLOAqhqmrkO8WeuArt3Rcx6EMvfpUx2TMBTjWxUGIlZx4+GH9QJlD/b1TRwds/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S9Y+HxU4xHFOpXhx0DKdjSafA97UgbUNUqnqcUdhw0w=;
 b=LtmY8pSDMCKVadHL9U7DWOnio+fSWd5nfELJnNHocBf2+oGiIBZga6RTxhROWP/oKjZbnaT315kA2SI2FuFq96jg4DNdewpglqdP8TqgFzexsWeYJJDYgS+Yge0BL1Nz03+iMqKJbmy7fAMD7cpBhyaVcqneJyMlWZCIDwIhm9cuSvlXM7vKOOM7+s37WrNpgw2dLnfK2QLHKUW03JjIAYo1MpFjpDfygiZWSb+JLACG7Yzv0M0gZ7Gic6z/SsKySFnYH7vsiPzVBG3Kh6Bo/5aZdDZSNhDaaldoeEp/5TiLM+dXSNJDKTx6XxkYy1tUBip1UI7OZRk+EtkKvoZ3Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9Y+HxU4xHFOpXhx0DKdjSafA97UgbUNUqnqcUdhw0w=;
 b=XaNvDZpItZZHCxIbzRhnj5JUlR0qxZBSitfpb5fHWdPnkMQqG5UfFoLJVlV5OkQC5WKtSiaVqsTyaq3p2jSvR0OoJRQiBr7rrIcrki50pSmOCVTeyLMObYQlt6HC08sb8AJmnM58UEg65yC6ign/NpGPA8tEiJQsspKwJvpqGGA=
Received: from BL1PR13CA0232.namprd13.prod.outlook.com (2603:10b6:208:2bf::27)
 by DS0PR12MB6581.namprd12.prod.outlook.com (2603:10b6:8:d3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Thu, 28 May
 2026 06:42:31 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:208:2bf:cafe::a9) by BL1PR13CA0232.outlook.office365.com
 (2603:10b6:208:2bf::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.4 via Frontend Transport; Thu, 28
 May 2026 06:42:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 06:42:31 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 28 May
 2026 01:42:29 -0500
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Subject: [PATCH 3/8] drm/amdgpu: add support for NBIO IP version 7.11.5
Date: Thu, 28 May 2026 06:42:01 +0000
Message-ID: <20260528064206.12358-3-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528064206.12358-1-Pratik.Vishwakarma@amd.com>
References: <20260528064206.12358-1-Pratik.Vishwakarma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|DS0PR12MB6581:EE_
X-MS-Office365-Filtering-Correlation-Id: a2566741-7a66-46cc-12d1-08debc844ade
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|22082099003|18002099003|56012099006|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info: uGKsfj3a120CTzfs9om5homJ+U86uXMkzAErAyIgPCMgDXxEAicMRbyh9aVBGnAQ6SLZcF5HoxmLC45lej4X1HcqpeP7DbdOtQsfunocn562TQmy6VxDNWkVBB1rJfrP09UHYN5uWIIqvZx/aZ3JkPOWTad7W+ma7ywqOJQF2oqFUw6dp7WMFKNDBearB6NVafCkEnD9jER0Z+2YDedfxpSoxKjS+gO6mGJWGy5e/cxTeb55oWIJqLmnghLXZ8ZSoiL8pUNojEqz72h1eEl5rc9/EnQVuMLNRqoNo6OKIIHTxpM368GvJossgvjQa4SJxuLOMYtcbEIge3HZsS8D0z5Nie+BJHTfG1JYnPm2J0Ly3bmtbCMXNcKdya9M0BK3DCj8aNff8WVLnV14dHzLTsqX9ME87zC7rDuBGbUvNZN74ydA3mpQ034lrEE9dlyy5pyLAGCORc80FZrkaZdax4EfDyVy95EiEkgpUeFIRCUlfnUE3ITXbgCPNpSXpVyRG7sJ+zFxtFqUB8T+PO9jqTcQ7NSiU+EiMn94fA1GmCZLacDxGD9gkySXG9IW56q8ajIJ62VUMT35ScYfVdUeIKs/o3K6+hIcf/pyMsWJv3mQ97N2j4J7yvTXESNtc0522TWHn3hAm71MuMvfc5g2Y4JeFJJw6AAjfXBJ8qsfLnLGXOuN95xbaXr44quL9+wSvmPujzE37nYtyV5xZ9cM6rHg949SjOTvNpDi7XFbnYY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(22082099003)(18002099003)(56012099006)(11063799006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jPffyEMtNyOrDyTl+8F2b8F1pafMiV3R2xgTX6AMAoj0dIdpIFy0kmTSgc0QQr/kQ6Q4WBYWgQKt1si3VwlA4fcg+pa3kNQaDYo4AEa6HnXZj2b4RTuhfsZTkUT0k5SCJ6p8kFAsoj9tQVc8GOiGzLnorU6NDpfDDhvg4i3qN46ljrKY5gHyd4FE2iP1IsIz7wAVKnQopvxCodvNk6YwS4xY9kPBpulC4SKnLQBwZRUgrnspKYq4yopUe7ebP94K4srm+43vn6uqBT20z6pssQwrJj2Xd/RmlmxgVD+skgqv+mMBw390Ir8tJHhWhvZ/+iS+Hfbi/K7trZjWs0MlpB3GHQlA9o3x4BodUiQkGfRfRgh8SfAsEGeCfKAeC+6Z3LmVb1KLLRhUPQ9cEmc3K3tESuebswAB7oP+6XIwm7MV0/kI9uR5t5lPn8kdxUKv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 06:42:31.0526 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2566741-7a66-46cc-12d1-08debc844ade
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6581
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

This initializes NBIO IP version 7.11.5.

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   1 +
 drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c      | 148 +++++++++++++-----
 2 files changed, 113 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index e23eda0c4ea5..32ceab25ad29 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -3202,6 +3202,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		break;
 	case IP_VERSION(6, 3, 1):
 	case IP_VERSION(7, 11, 4):
+	case IP_VERSION(7, 11, 5):
 		adev->nbio.funcs = &nbif_v6_3_1_funcs;
 		adev->nbio.hdp_flush_reg = &nbif_v6_3_1_hdp_flush_reg;
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c b/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
index 28a99b52f59f..d6c7234393a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
@@ -57,12 +57,50 @@
 #define regRCC_STRAP0_RCC_DEV0_EPF0_STRAP0_nbif_4_10                                                              0x0021
 #define regRCC_STRAP0_RCC_DEV0_EPF0_STRAP0_nbif_4_10_BASE_IDX                                                     2
 
+#define regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_HIGH_nbio_7_11_5                                      0x8e13
+#define regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_HIGH_nbio_7_11_5_BASE_IDX                             5
+#define regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_LOW_nbio_7_11_5                                       0x8e14
+#define regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_LOW_nbio_7_11_5_BASE_IDX                              5
+#define regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_CNTL_nbio_7_11_5                                           0x8e15
+#define regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_CNTL_nbio_7_11_5_BASE_IDX                                  5
+
+#define regBIF_BX0_REMAP_HDP_MEM_FLUSH_CNTL_nbio_7_11_5                                                     0x8e4d
+#define regBIF_BX0_REMAP_HDP_MEM_FLUSH_CNTL_nbio_7_11_5_BASE_IDX                                            5
+#define regBIF_BX0_REMAP_HDP_REG_FLUSH_CNTL_nbio_7_11_5                                                     0x8e4e
+#define regBIF_BX0_REMAP_HDP_REG_FLUSH_CNTL_nbio_7_11_5_BASE_IDX                                            5
+
+#define regRCC_STRAP0_RCC_DEV0_EPF0_STRAP0_nbio_7_11_5                                                      0xd000
+#define regRCC_STRAP0_RCC_DEV0_EPF0_STRAP0_nbio_7_11_5_BASE_IDX                                             5
+
+#define regBIF_BX0_BIF_FB_EN_nbio_7_11_5                                                                    0x8e20
+#define regBIF_BX0_BIF_FB_EN_nbio_7_11_5_BASE_IDX                                                           5
+
+#define regBIF_BX0_INTERRUPT_CNTL_nbio_7_11_5                                                               0x8e11
+#define regBIF_BX0_INTERRUPT_CNTL_nbio_7_11_5_BASE_IDX                                                      5
+#define regBIF_BX0_INTERRUPT_CNTL2_nbio_7_11_5                                                              0x8e12
+#define regBIF_BX0_INTERRUPT_CNTL2_nbio_7_11_5_BASE_IDX                                                     5
+
+#define regBIF_BX_PF0_GPU_HDP_FLUSH_REQ_nbio_7_11_5                                                         0x8e26
+#define regBIF_BX_PF0_GPU_HDP_FLUSH_REQ_nbio_7_11_5_BASE_IDX                                                5
+#define regBIF_BX_PF0_GPU_HDP_FLUSH_DONE_nbio_7_11_5                                                        0x8e27
+#define regBIF_BX_PF0_GPU_HDP_FLUSH_DONE_nbio_7_11_5_BASE_IDX                                               5
+
+#define regBIF_BX_PF0_HDP_MEM_COHERENCY_FLUSH_CNTL_nbio_7_11_5                                              0x8e17
+#define regBIF_BX_PF0_HDP_MEM_COHERENCY_FLUSH_CNTL_nbio_7_11_5_BASE_IDX                                     5
+
 static void nbif_v6_3_1_remap_hdp_registers(struct amdgpu_device *adev)
 {
-	WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_MEM_FLUSH_CNTL,
-		adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL);
-	WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_REG_FLUSH_CNTL,
-		adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_REG_FLUSH_CNTL);
+	if (amdgpu_ip_version(adev, NBIO_HWIP, 0) == IP_VERSION(7, 11, 5)) {
+		WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_MEM_FLUSH_CNTL_nbio_7_11_5,
+			adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL);
+		WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_REG_FLUSH_CNTL_nbio_7_11_5,
+			adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_REG_FLUSH_CNTL);
+	} else {
+		WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_MEM_FLUSH_CNTL,
+			adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL);
+		WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_REG_FLUSH_CNTL,
+			adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_REG_FLUSH_CNTL);
+	}
 }
 
 static u32 nbif_v6_3_1_get_rev_id(struct amdgpu_device *adev)
@@ -71,6 +109,8 @@ static u32 nbif_v6_3_1_get_rev_id(struct amdgpu_device *adev)
 
 	if (amdgpu_ip_version(adev, NBIO_HWIP, 0) == IP_VERSION(7, 11, 4))
 		tmp = RREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_DEV0_EPF0_STRAP0_nbif_4_10);
+	else if (amdgpu_ip_version(adev, NBIO_HWIP, 0) == IP_VERSION(7, 11, 5))
+		tmp = RREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_DEV0_EPF0_STRAP0_nbio_7_11_5);
 	else
 		tmp = RREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_DEV0_EPF0_STRAP0);
 
@@ -82,12 +122,21 @@ static u32 nbif_v6_3_1_get_rev_id(struct amdgpu_device *adev)
 
 static void nbif_v6_3_1_mc_access_enable(struct amdgpu_device *adev, bool enable)
 {
-	if (enable)
-		WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_FB_EN,
-			     BIF_BX0_BIF_FB_EN__FB_READ_EN_MASK |
-			     BIF_BX0_BIF_FB_EN__FB_WRITE_EN_MASK);
-	else
-		WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_FB_EN, 0);
+	if (amdgpu_ip_version(adev, NBIO_HWIP, 0) == IP_VERSION(7, 11, 5)) {
+		if (enable)
+			WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_FB_EN_nbio_7_11_5,
+				     BIF_BX0_BIF_FB_EN__FB_READ_EN_MASK |
+				     BIF_BX0_BIF_FB_EN__FB_WRITE_EN_MASK);
+		else
+			WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_FB_EN_nbio_7_11_5, 0);
+	} else {
+		if (enable)
+			WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_FB_EN,
+				     BIF_BX0_BIF_FB_EN__FB_READ_EN_MASK |
+				     BIF_BX0_BIF_FB_EN__FB_WRITE_EN_MASK);
+		else
+			WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_FB_EN, 0);
+	}
 }
 
 static u32 nbif_v6_3_1_get_memsize(struct amdgpu_device *adev)
@@ -100,8 +149,14 @@ static void nbif_v6_3_1_sdma_doorbell_range(struct amdgpu_device *adev,
 					    int doorbell_index,
 					    int doorbell_size)
 {
+	u32 doorbell_range;
 	if (instance == 0) {
-		u32 doorbell_range = RREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL);
+		if (amdgpu_ip_version(adev, NBIO_HWIP, 0) >= IP_VERSION(7, 11, 4))
+			doorbell_range = RREG32_SOC15(NBIO, 0,
+					regGDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL_nbif_4_10);
+		else
+			doorbell_range = RREG32_SOC15(NBIO, 0,
+					regGDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL);
 
 		if (use_doorbell) {
 			doorbell_range = REG_SET_FIELD(doorbell_range,
@@ -130,11 +185,10 @@ static void nbif_v6_3_1_sdma_doorbell_range(struct amdgpu_device *adev,
 						       S2A_DOORBELL_PORT2_RANGE_SIZE,
 						       0);
 
-		if (amdgpu_ip_version(adev, NBIO_HWIP, 0) == IP_VERSION(7, 11, 4)) {
+		if (amdgpu_ip_version(adev, NBIO_HWIP, 0) >= IP_VERSION(7, 11, 4))
 			WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL_nbif_4_10, doorbell_range);
-		} else {
+		else
 			WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL, doorbell_range);
-		}
 	}
 }
 
@@ -179,14 +233,15 @@ static void nbif_v6_3_1_vcn_doorbell_range(struct amdgpu_device *adev,
 					       S2A_DOORBELL_PORT4_RANGE_SIZE,
 					       0);
 
-	if (amdgpu_ip_version(adev, NBIO_HWIP, 0) == IP_VERSION(7, 11, 4)) {
-		WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL_nbif_4_10, doorbell_range);
-	} else {
+	if (amdgpu_ip_version(adev, NBIO_HWIP, 0) >= IP_VERSION(7, 11, 4))
+		WREG32_SOC15(NBIO, 0,
+				regGDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL_nbif_4_10,
+				doorbell_range);
+	else
 		if (instance)
 			WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL, doorbell_range);
 		else
 			WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL, doorbell_range);
-	}
 }
 
 static void nbif_v6_3_1_vpe_doorbell_range(struct amdgpu_device *adev,
@@ -236,7 +291,7 @@ static void nbif_v6_3_1_vpe_doorbell_range(struct amdgpu_device *adev,
 
 static void nbif_v6_3_1_gc_doorbell_init(struct amdgpu_device *adev)
 {
-	if (amdgpu_ip_version(adev, NBIO_HWIP, 0) == IP_VERSION(7, 11, 4)) {
+	if (amdgpu_ip_version(adev, NBIO_HWIP, 0) >= IP_VERSION(7, 11, 4)) {
 		WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL_nbif_4_10, 0x30000007);
 		WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL_nbif_4_10, 0x3000000d);
 	} else {
@@ -278,7 +333,13 @@ nbif_v6_3_1_enable_doorbell_selfring_aperture(struct amdgpu_device *adev,
 static void nbif_v6_3_1_ih_doorbell_range(struct amdgpu_device *adev,
 					  bool use_doorbell, int doorbell_index)
 {
-	u32 ih_doorbell_range = RREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL);
+	u32 ih_doorbell_range;
+
+	if (amdgpu_ip_version(adev, NBIO_HWIP, 0) >= IP_VERSION(7, 11, 4))
+		ih_doorbell_range = RREG32_SOC15(NBIO, 0,
+				regGDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL_nbif_4_10);
+	else
+		ih_doorbell_range = RREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL);
 
 	if (use_doorbell) {
 		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
@@ -307,11 +368,11 @@ static void nbif_v6_3_1_ih_doorbell_range(struct amdgpu_device *adev,
 						  S2A_DOORBELL_PORT1_RANGE_SIZE,
 						  0);
 
-	if (amdgpu_ip_version(adev, NBIO_HWIP, 0) == IP_VERSION(7, 11, 4)) {
-		WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL_nbif_4_10, ih_doorbell_range);
-	} else {
+	if (amdgpu_ip_version(adev, NBIO_HWIP, 0) >= IP_VERSION(7, 11, 4))
+		WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL_nbif_4_10,
+				ih_doorbell_range);
+	else
 		WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL, ih_doorbell_range);
-	}
 }
 
 static void nbif_v6_3_1_ih_control(struct amdgpu_device *adev)
@@ -319,9 +380,13 @@ static void nbif_v6_3_1_ih_control(struct amdgpu_device *adev)
 	u32 interrupt_cntl;
 
 	/* setup interrupt control */
-	WREG32_SOC15(NBIO, 0, regBIF_BX0_INTERRUPT_CNTL2, adev->dummy_page_addr >> 8);
+	if (amdgpu_ip_version(adev, NBIO_HWIP, 0) == IP_VERSION(7, 11, 5))
+		WREG32_SOC15(NBIO, 0, regBIF_BX0_INTERRUPT_CNTL2_nbio_7_11_5,
+				adev->dummy_page_addr >> 8);
+	else
+		WREG32_SOC15(NBIO, 0, regBIF_BX0_INTERRUPT_CNTL2, adev->dummy_page_addr >> 8);
 
-	interrupt_cntl = RREG32_SOC15(NBIO, 0, regBIF_BX0_INTERRUPT_CNTL);
+	interrupt_cntl = RREG32_SOC15(NBIO, 0, regBIF_BX0_INTERRUPT_CNTL_nbio_7_11_5);
 	/*
 	 * BIF_BX0_INTERRUPT_CNTL__IH_DUMMY_RD_OVERRIDE_MASK=0 - dummy read disabled with msi, enabled without msi
 	 * BIF_BX0_INTERRUPT_CNTL__IH_DUMMY_RD_OVERRIDE_MASK=1 - dummy read controlled by IH_DUMMY_RD_EN
@@ -333,7 +398,10 @@ static void nbif_v6_3_1_ih_control(struct amdgpu_device *adev)
 	interrupt_cntl = REG_SET_FIELD(interrupt_cntl, BIF_BX0_INTERRUPT_CNTL,
 				       IH_REQ_NONSNOOP_EN, 0);
 
-	WREG32_SOC15(NBIO, 0, regBIF_BX0_INTERRUPT_CNTL, interrupt_cntl);
+	if (amdgpu_ip_version(adev, NBIO_HWIP, 0) == IP_VERSION(7, 11, 5))
+		WREG32_SOC15(NBIO, 0, regBIF_BX0_INTERRUPT_CNTL_nbio_7_11_5, interrupt_cntl);
+	else
+		WREG32_SOC15(NBIO, 0, regBIF_BX0_INTERRUPT_CNTL, interrupt_cntl);
 }
 
 static void
@@ -356,27 +424,31 @@ nbif_v6_3_1_get_clockgating_state(struct amdgpu_device *adev,
 
 static u32 nbif_v6_3_1_get_hdp_flush_req_offset(struct amdgpu_device *adev)
 {
-	return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF0_GPU_HDP_FLUSH_REQ);
+	if (amdgpu_ip_version(adev, NBIO_HWIP, 0) == IP_VERSION(7, 11, 5))
+		return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF0_GPU_HDP_FLUSH_REQ_nbio_7_11_5);
+	else
+		return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF0_GPU_HDP_FLUSH_REQ);
 }
 
 static u32 nbif_v6_3_1_get_hdp_flush_done_offset(struct amdgpu_device *adev)
 {
-	return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF0_GPU_HDP_FLUSH_DONE);
+	if (amdgpu_ip_version(adev, NBIO_HWIP, 0) == IP_VERSION(7, 11, 5))
+		return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF0_GPU_HDP_FLUSH_DONE_nbio_7_11_5);
+	else
+		return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF0_GPU_HDP_FLUSH_DONE);
 }
 
 static u32 nbif_v6_3_1_get_pcie_index_offset(struct amdgpu_device *adev)
 {
-	if (amdgpu_ip_version(adev, NBIO_HWIP, 0) == IP_VERSION(7, 11, 4)) {
+	if (amdgpu_ip_version(adev, NBIO_HWIP, 0) >= IP_VERSION(7, 11, 4))
 		return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX0_PCIE_INDEX);
-	}
-	else {
+	else
 		return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF0_RSMU_INDEX);
-	}
 }
 
 static u32 nbif_v6_3_1_get_pcie_data_offset(struct amdgpu_device *adev)
 {
-	if (amdgpu_ip_version(adev, NBIO_HWIP, 0) == IP_VERSION(7, 11, 4))
+	if (amdgpu_ip_version(adev, NBIO_HWIP, 0) >= IP_VERSION(7, 11, 4))
 		return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX0_PCIE_DATA);
 	else
 		return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF0_RSMU_DATA);
@@ -546,8 +618,12 @@ static void nbif_v6_3_1_set_reg_remap(struct amdgpu_device *adev)
 		adev->rmmio_remap.reg_offset = MMIO_REG_HOLE_OFFSET;
 		adev->rmmio_remap.bus_addr = adev->rmmio_base + MMIO_REG_HOLE_OFFSET;
 	} else {
-		adev->rmmio_remap.reg_offset = SOC15_REG_OFFSET(NBIO, 0,
-			regBIF_BX_PF0_HDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
+		if (amdgpu_ip_version(adev, NBIO_HWIP, 0) == IP_VERSION(7, 11, 5))
+			adev->rmmio_remap.reg_offset = SOC15_REG_OFFSET(NBIO, 0,
+				regBIF_BX_PF0_HDP_MEM_COHERENCY_FLUSH_CNTL_nbio_7_11_5) << 2;
+		else
+			adev->rmmio_remap.reg_offset = SOC15_REG_OFFSET(NBIO, 0,
+				regBIF_BX_PF0_HDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
 		adev->rmmio_remap.bus_addr = 0;
 	}
 }
-- 
2.43.0

