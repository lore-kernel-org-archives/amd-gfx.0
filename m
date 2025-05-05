Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEB57C3ABAA
	for <amd-gfx@archiver.kernel.org>; Mon,  5 May 2025 14:46:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B90410E2DC;
	Mon,  5 May 2025 14:46:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gVU7QzoU";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9576D10E2DC
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 May 2025 14:46:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ujFKyHeCmnjIkTGjbrFpwQlS61QyE9DYiZWPWmEsM4W3Zd9E+xJTTC3bRYYBYvf5vTT84IzclwBLBYzuCkncSWGX0FO+bT3clOuczzl4irdwxA+eVaOb7EYdRfrW81U8r8BPZ/5cTVYPwW/zqHaoSXqgppCaDHIvb4uiABPpgU4ZD4thxJ9u3k71iOfpsgZpsxAK4equ7KDBgtC7wOiTpmhzXTZiDudIRDsDhL8sSziCZnjlDylKikOOI6wPKdD+KrMofo483BIMxaztZ7EGcam/+XyEGFmuCIfvEmPx0V9RSaoalfCpmvjfO1VB/LtXhxXA67+WAo05HGpLPaKVoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wv/nqdtQ0wOCGBIwXLq5EAqLr0Q/5P+rnSAGgwzbXXo=;
 b=yDfvUAm6S9q3d0wFBFOAhtpJ99spYyCWoIDKUnN3EKmi9jn6Mt/ydt+BREhpxK83mAuAqVE2CQb+82wByKECCQsQg+UrdJY3HKRZBm1jBI+C/h6xUg4wEQFe+9oEqHi0gcb8Ssat2fXneLwYPz1Sh6UjzXnIBiiJ5PNcu1TudOpGWgIYgvGJVHJJEzEKRAvciCsgQEh0njKSbVn8XXexHEy/wvS2PvNoJt3odm5fwRLCv1SvP9sZLYeew2WvijqD48ohHsvYTTmsjST2OuisiKSyLp6rvDnhBTfDIsPd9Uyt6ae8vIwtjyg4llVT6bipF/8/HgiUl9YZSYumculdow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wv/nqdtQ0wOCGBIwXLq5EAqLr0Q/5P+rnSAGgwzbXXo=;
 b=gVU7QzoUTIG9TNezhBsjQhutegpvycDq5Aqi27pBTnmuTouuimUqfS6CM1c3FYCeMgDrneQfUew9Kwun46Z7oRztgegSUMoBe6vRM7KXxbqNUyhwktYC5NyWjU2UgP7cgH0wCUrBLqJ+HV3OYfmkR4tZZzrjc0JwUF1LGzYLjJ0=
Received: from CH0PR03CA0294.namprd03.prod.outlook.com (2603:10b6:610:e6::29)
 by IA0PR12MB8907.namprd12.prod.outlook.com (2603:10b6:208:492::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Mon, 5 May
 2025 14:46:05 +0000
Received: from CH1PEPF0000AD78.namprd04.prod.outlook.com
 (2603:10b6:610:e6:cafe::c4) by CH0PR03CA0294.outlook.office365.com
 (2603:10b6:610:e6::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.29 via Frontend Transport; Mon,
 5 May 2025 14:46:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD78.mail.protection.outlook.com (10.167.244.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Mon, 5 May 2025 14:46:05 +0000
Received: from ruijing-dev0.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 5 May
 2025 09:46:04 -0500
From: Ruijing Dong <ruijing.dong@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Saleemkhan.Jamadar@amd.com>
CC: <alexander.deucher@amd.com>, <Christian.Koenig@amd.com>,
 <leo.liu@amd.com>, <ruijing.dong@amd.com>
Subject: [PATCH v2] drm/amdgpu/vcn: using separate VCN1_AON_SOC offset
Date: Mon, 5 May 2025 10:45:49 -0400
Message-ID: <20250505144549.1263994-1-ruijing.dong@amd.com>
X-Mailer: git-send-email 2.48.0.rc0.12.gaaf18a9a82
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD78:EE_|IA0PR12MB8907:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fa16f18-8870-422e-bc6d-08dd8be390a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oMzenv1MD+Byl22JDJ0h0ced0z5IPauia0OoSaFcv0Zyup5NvH/ZgTyE1klI?=
 =?us-ascii?Q?j4vyjbr75iuSu4L+S/n2u1hyNxCo6LGzA1hIRGLoH1Ri6tJYcvE/uEp8hidI?=
 =?us-ascii?Q?rmZDzrnSbR7Zkb0KeCTVsIskYUUHY212ooa6y90r9/+6SaQ9HtJRvXPrbPRS?=
 =?us-ascii?Q?XfSqXZJ+93Dxj9wLPU+s06AYpf+8QtCoOOTiosrIW0AYrOBq/f1WIiGoeHkc?=
 =?us-ascii?Q?jLm7Fk3VlVmsODoZHjdlfpGv0rOkPtmrDM6eGWdLDNcPHK8CtSu7h5PmYGKk?=
 =?us-ascii?Q?dV998LThF7emSpyY0SuUMrXL2YFcd1r4HyEGbfflsWTaDuEqdAWG13EDk+yC?=
 =?us-ascii?Q?fHMFAO+b5gGLW9Ejn7ROtWy1US8m45pKft9Rihowqqd1cIIrgr792onPIlAO?=
 =?us-ascii?Q?ujU4U5/wrERbCHLvoaxTV5TfsI2U0dIAp8IPsg/+joVIJyzv2LqJzrcgeogA?=
 =?us-ascii?Q?KK+PAIyY4VQjP6wBDk9KC+Tzf1Yx9HKoAGkqGKliAMnaGfAwu0+hfPcADaGf?=
 =?us-ascii?Q?//4aoDir9H1YA1b1ptcMEEMaqMOjztPpZxhY79hTs+DcXBP1CdDBas3DJ02c?=
 =?us-ascii?Q?eod4jLoG+WShpx/x+nLU3Q7munOzuwt62t8dMOBYyV4vvRj08pwN4Nh7ghQi?=
 =?us-ascii?Q?OwMjpjtGhB0blKlz7IhLcu+B2+eDllqwTwFxCjUxbIfYWhigtWSmyCkuK1VK?=
 =?us-ascii?Q?OM92kF/P5Y2TXLaYK6at3WhpvBsZs3967sbZcN6R2gjCH/4rQPzbqwrqbiCW?=
 =?us-ascii?Q?367bKK0ab9kGvg+jUqbMIwSA2FPKfw1P921dTi8Frw+8xUqTJ2tQS7+RDY9N?=
 =?us-ascii?Q?DjTOHFOezA7j6d3nVD0KSZVkAuf3eQPQclRAeRYSeToO2E/1Ke1cOLrEtTxN?=
 =?us-ascii?Q?tm/0D+LvgS3iEy2HaQzjjRcy1amKzQXYnqutUGlYHruBFMnL8/uGWISOXoWZ?=
 =?us-ascii?Q?QPHjZ+GjqPPOCT7j5IFt5Ha6d0PlWMfSRKi1sk2C6RJLeLf+HU6Zu9Bw/LLm?=
 =?us-ascii?Q?6r7PLhROrZSAIKn/MFM8WaHqeSWkRoDdBkRCw995W7PkIrDU66QBb1aMK3cm?=
 =?us-ascii?Q?pXC6bgFarQxrHVnP4CSnehUk1gQR0yjrjTwvkEmhEP9Q2DZN45YOOBm+w/K/?=
 =?us-ascii?Q?r2BgFWInn6/UCs5I9kuhSPnm4ul6cmGRVh/PGIgLSaGOKFRPPWXoZGwuNpK7?=
 =?us-ascii?Q?72ZF53AMHF+UtJKQpKNv6HvI74D7zQxVyNrv65XdObHqbXAJ9Il7LXK0P5l6?=
 =?us-ascii?Q?TvK4owHKiImNV7I/it7sahzruM96wh0YiV1Yck7J2QwIm86So4NY5RSMsNi+?=
 =?us-ascii?Q?+fpbJ3jyi2V+KDdNbzdFCve8TmFhUUu7m7IvEiDlHopK9Rs8xdXRMIJkA+8K?=
 =?us-ascii?Q?h3NgAxmZ1uLDW9+jvmfFY6pL+dfGRjuOghWHCqwrUXgR7WdhVIomSe9y5+SN?=
 =?us-ascii?Q?JXLaJqq3ZNhizwBab244hYmGsFHROyEYApCwJJym4BM5bpCoEsOkl2nw8snK?=
 =?us-ascii?Q?LSUrgI+O6KlvfJqrcJBhmDjMcox/ER+fISdn?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 14:46:05.6222 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fa16f18-8870-422e-bc6d-08dd8be390a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD78.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8907
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

v1: fix GFX10_ADDR_CONFIG programming for vcn1
v2: VCN1_AON_SOC_ADDRESS_3_0 offset varies on different
    VCN generations, the issue in vcn4.0.5 is caused by
    a different VCN1_AON_SOC_ADDRESS_3_0 offset.

This patch does the following:

    1. use the same offset for other VCN generations.
    2. use the vcn4.0.5 speical offset
    3. update vcn_4_0 and vcn_5_0

Signed-off-by: Ruijing Dong <ruijing.dong@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h | 1 -
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   | 1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 3 ++-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 2 +-
 8 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index cdcdae7f71ce..83adf81defc7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -66,7 +66,6 @@
 #define VCN_ENC_CMD_REG_WAIT		0x0000000c
 
 #define VCN_AON_SOC_ADDRESS_2_0 	0x1f800
-#define VCN1_AON_SOC_ADDRESS_3_0 	0x48000
 #define VCN_VID_IP_ADDRESS_2_0		0x0
 #define VCN_AON_IP_ADDRESS_2_0		0x30000
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 8e7a36f26e9c..b8d835c9e17e 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -39,6 +39,7 @@
 
 #define VCN_VID_SOC_ADDRESS_2_0					0x1fa00
 #define VCN1_VID_SOC_ADDRESS_3_0				0x48200
+#define VCN1_AON_SOC_ADDRESS_3_0				0x48000
 
 #define mmUVD_CONTEXT_ID_INTERNAL_OFFSET			0x1fd
 #define mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET			0x503
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index d716510b8dd6..3eec1b8feaee 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -39,6 +39,7 @@
 
 #define VCN_VID_SOC_ADDRESS_2_0					0x1fa00
 #define VCN1_VID_SOC_ADDRESS_3_0				0x48200
+#define VCN1_AON_SOC_ADDRESS_3_0				0x48000
 
 #define mmUVD_CONTEXT_ID_INTERNAL_OFFSET			0x27
 #define mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET			0x0f
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 22ae1939476f..0b19f0ab4480 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -40,6 +40,7 @@
 
 #define VCN_VID_SOC_ADDRESS_2_0					0x1fa00
 #define VCN1_VID_SOC_ADDRESS_3_0				0x48200
+#define VCN1_AON_SOC_ADDRESS_3_0				0x48000
 
 #define mmUVD_CONTEXT_ID_INTERNAL_OFFSET			0x27
 #define mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET			0x0f
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index c6f6392c1c20..351afec0fc82 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -46,6 +46,7 @@
 
 #define VCN_VID_SOC_ADDRESS_2_0							0x1fb00
 #define VCN1_VID_SOC_ADDRESS_3_0						0x48300
+#define VCN1_AON_SOC_ADDRESS_3_0						0x48000
 
 #define VCN_HARVEST_MMSCH								0
 
@@ -614,7 +615,7 @@ static void vcn_v4_0_mc_resume_dpg_mode(struct amdgpu_vcn_inst *vinst,
 
 	/* VCN global tiling registers */
 	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
-		VCN, 0, regUVD_GFX10_ADDR_CONFIG), adev->gfx.config.gb_addr_config, 0, indirect);
+		VCN, inst_idx, regUVD_GFX10_ADDR_CONFIG), adev->gfx.config.gb_addr_config, 0, indirect);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 139c83bd165e..712e1fba33ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -45,6 +45,7 @@
 
 #define VCN_VID_SOC_ADDRESS_2_0		0x1fb00
 #define VCN1_VID_SOC_ADDRESS_3_0	0x48300
+#define VCN1_AON_SOC_ADDRESS_3_0	0x48000
 
 static const struct amdgpu_hwip_reg_entry vcn_reg_list_4_0_3[] = {
 	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_POWER_STATUS),
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index a8cfc63713ad..558469744f3a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -46,6 +46,7 @@
 
 #define VCN_VID_SOC_ADDRESS_2_0						0x1fb00
 #define VCN1_VID_SOC_ADDRESS_3_0					(0x48300 + 0x38000)
+#define VCN1_AON_SOC_ADDRESS_3_0					(0x48000 + 0x38000)
 
 #define VCN_HARVEST_MMSCH							0
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index d99d05f42f1d..75c9e7091558 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -533,7 +533,7 @@ static void vcn_v5_0_0_mc_resume_dpg_mode(struct amdgpu_vcn_inst *vinst,
 
 	/* VCN global tiling registers */
 	WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
-		VCN, 0, regUVD_GFX10_ADDR_CONFIG), adev->gfx.config.gb_addr_config, 0, indirect);
+		VCN, inst_idx, regUVD_GFX10_ADDR_CONFIG), adev->gfx.config.gb_addr_config, 0, indirect);
 
 	return;
 }
-- 
2.48.0.rc0.12.gaaf18a9a82

