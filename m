Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 630BAC02198
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2025 15:19:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF24010ECED;
	Fri, 14 Feb 2025 15:19:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PimVNKDi";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCF2810ECF3
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2025 15:19:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O68JW+FneEOJVREqRy8K8z6FJ/N3j/K5AONBFfmHWoGKz5xxV/A6137hLR3pBx5Mo7vu7OiXO8X538/pqnUAPHGURX0lHRH5eknM7ih7Goeeblyx7GN04cY62RL6q+zllrHTbWnvd6Cz+4grXI/JgOWGoDma63m18Lf3Fycs0jbtaL1RvZYjQFATJdoUZTBM7LrzaEEQIb7UQzB7nVVRiynepd/OCg2Fr/JC534E959xD2o+IdMLYt78U2z+IDZ8CzJow8ktTbbdjerqMgWnR0OMA5W73stsoU8K+d/qcHCX/FurLVAKd39/bdNKUTqgrr9tN6BZ/ZklOU3rmV8Bfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mSFQH8n/lv4c/Jm9QyHBJ5MIgZywiv4vOmSSioPEai4=;
 b=JYlXI/HIHi7DkEsKSboVfQu+y+QI6Azb0aHDki82+LCN6NTtDc4V+uPbfgSYCXVZZshOnCVhmHsp5Huqu3F3UkxNBdY8YWqL1+QPGxu/V5GigSqOGMaiFPaHoUkEsMtxwzlBNV3zRYqhara54LjXc8Pv8IZB27GVfoAAkM68KDfx2onf77F+RVCMfecwPbFDsSBnxUk/X7p5mE3FnFYIiMc3zTJ6PV2XMvzRTYNJHFp+QD7SY733WFyEoNSWKoSBj8hYK4kHGMwMzEm1qGJTeId2HXcdyoSGurDoiRj+tXrkApv8dm7wdBW9UXrzkXV67KvcGJBV2O5t8zfzmEw4zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mSFQH8n/lv4c/Jm9QyHBJ5MIgZywiv4vOmSSioPEai4=;
 b=PimVNKDi5c6uLp1fbhQJGlzElec18tdG7ms1nX1oIaFCO/djwA5ZHMi1GguwkNdJ6Zy9FakR5OTYm1qq1cxjfS38Rj9F9mLhj4d5FzII/nY+PAqD0iJspeIe6oNmQulLSnKs3N3H3X38XfgWmKgdSXRJueBUvBJnN5G46iLRx7k=
Received: from CH3P220CA0027.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::25)
 by SA1PR12MB6993.namprd12.prod.outlook.com (2603:10b6:806:24c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Fri, 14 Feb
 2025 15:19:16 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:1e8:cafe::a7) by CH3P220CA0027.outlook.office365.com
 (2603:10b6:610:1e8::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.16 via Frontend Transport; Fri,
 14 Feb 2025 15:19:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Fri, 14 Feb 2025 15:19:16 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Feb
 2025 09:19:15 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu/mes11: allocate hw_resource_1 buffer once
Date: Fri, 14 Feb 2025 10:19:00 -0500
Message-ID: <20250214151901.2071738-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|SA1PR12MB6993:EE_
X-MS-Office365-Filtering-Correlation-Id: 39088c15-372c-4e17-1cc6-08dd4d0af202
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aWGnmhSpgisor1/sOse9PcIEB7Si2XytAG9J8Tvg4ll8CY6wkIzZSeMYeX10?=
 =?us-ascii?Q?SegQojtfKdHKvkjT7YfVLj8tIW8gh7GuRbuAI7HolCXGXBk4NF7XrO264oH3?=
 =?us-ascii?Q?3WtKjW5gf/r+ZvEZ4eoP09ak1XXGO2R2HCtxR9MyQL//BNi/4J/Djm2Rs4N/?=
 =?us-ascii?Q?Ln2+gI61ghpRYCN1vjYF65nVOjTlOsp0tJrhWabCfrr+U15I1fgj1CsgcUCA?=
 =?us-ascii?Q?n4q0gWyW48nb21Rqs70wEhtWe/m9w0f9ijFeP0S7KBRvKD2upgnxNRKWwAMn?=
 =?us-ascii?Q?nr0UF5IOqrQjtidl86U+DsMedfxst4B2K/O8d51s4fmTFE38sfVAhZGc0iOD?=
 =?us-ascii?Q?Ro2GHvuoGCvEHk6FogmderMxb4lJt2C+4RaT/P/Cx8e+Ti5WmGB3rIVeQqlB?=
 =?us-ascii?Q?14sBpzKAnxBg6fId3fUwMN4TBypYO4H2WIdUje2QFYEmoA2Rm7i2Ays8tZmB?=
 =?us-ascii?Q?dO8iQRkehMHQHc5f7M7kVdzIBOhRWFGAsnon1Ixl213zT77zQ95tlt5e6bv/?=
 =?us-ascii?Q?nMn71D/xppgth8XyDckaJUdwGdx+zutEBVk0nKByc4aicSLs6Sms2qCwP3NN?=
 =?us-ascii?Q?NCEUMuoPtTPw2oO0XnCSKKpi28m9VyytiQgXQW2Un1AkBPjFXNz0UYGGEK8w?=
 =?us-ascii?Q?GsN88EuU5VsN2M5tbtLXBkHpCqQFgcAhNTnMLYw3wCqQsjim8SlqsaOGoA1j?=
 =?us-ascii?Q?cC3+WyCmKHTL4YTLuUGovw8j/CQ2H0ySu5exUpLiQlZWf53P8ZqMeK2rnNau?=
 =?us-ascii?Q?Evtv6ONFNLjj4xICZFcGQW0yIfOyxSkDykYM17DMw/SXZogRR2ossoEaC4CN?=
 =?us-ascii?Q?kGR0dvCfXYkjNtNzKtET5DSR5w2NY7CqIJdBbVu5l/Zvler8v4901w4iQsEu?=
 =?us-ascii?Q?8kSIfwlUwehwtRizegFUFGsBIWCS4gwxRtmT8xM1wrNJq78n0WmnAHOmdxAq?=
 =?us-ascii?Q?jfghNKFD4epu+KESdxEA8mHq1qBR+x98eOlT0n53bpiHhTHHeVnoLFV/YKPL?=
 =?us-ascii?Q?5JW6DJyku/N4Hi2wXEnxZ+DQpbud76B5ElAjsSOaljzTsaVM+Q0M/SZRKkns?=
 =?us-ascii?Q?54tzE2nOW7Z45NzHyF1SPW3LtYdJBASISCuLuUfT3w/YUHpEhFm7giUoSCy6?=
 =?us-ascii?Q?d/rkU4yME7ZK4XlzMXC+gwR+ZzaH5vBvDr7/G3rxQmZWhasZbyKIxDV2uPzK?=
 =?us-ascii?Q?btc5oVylBehxc6mY9oEEDjdbaoSJbnTlAHxocC0AOminbEJ2/5wFg9sIqmZ7?=
 =?us-ascii?Q?K4RBIoPbNTACioom3MJyANfPJCnLY0wCQXVD20Nw01kq4NEyursszBj688Al?=
 =?us-ascii?Q?iCwkcaU6cGrllaHMLZr75g6FXyoIi41NhdWnwtl2Mc++EZmjyf4AugvYONVW?=
 =?us-ascii?Q?7Ea6JhXAqzDJsItupuLWo6QkBoRL4tTMUHrLjX3+Sk0stXeH0hnEsIdFhDF5?=
 =?us-ascii?Q?ywvXHzJqA3zWMBX90LJp0gZn1F/XXCghBDh/Ms+RQZCk/69z5lgssQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 15:19:16.0777 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39088c15-372c-4e17-1cc6-08dd4d0af202
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6993
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

Allocate the buffer at sw init time so we don't alloc
and free it for every suspend/resume or reset cycle.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 52 +++++++++++++-------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 26af0af718b5e..530371e6a7aee 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -64,6 +64,7 @@ static int mes_v11_0_kiq_hw_fini(struct amdgpu_device *adev);
 
 #define MES_EOP_SIZE   2048
 #define GFX_MES_DRAM_SIZE	0x80000
+#define MES11_HW_RESOURCE_1_SIZE (128 * AMDGPU_GPU_PAGE_SIZE)
 
 static void mes_v11_0_ring_set_wptr(struct amdgpu_ring *ring)
 {
@@ -743,11 +744,6 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
 
 static int mes_v11_0_set_hw_resources_1(struct amdgpu_mes *mes)
 {
-	unsigned int hw_rsrc_size = 128 * AMDGPU_GPU_PAGE_SIZE;
-	/* add a page for the cleaner shader fence */
-	unsigned int alloc_size = hw_rsrc_size + AMDGPU_GPU_PAGE_SIZE;
-	int ret = 0;
-	struct amdgpu_device *adev = mes->adev;
 	union MESAPI_SET_HW_RESOURCES_1 mes_set_hw_res_pkt;
 	memset(&mes_set_hw_res_pkt, 0, sizeof(mes_set_hw_res_pkt));
 
@@ -755,21 +751,10 @@ static int mes_v11_0_set_hw_resources_1(struct amdgpu_mes *mes)
 	mes_set_hw_res_pkt.header.opcode = MES_SCH_API_SET_HW_RSRC_1;
 	mes_set_hw_res_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
 	mes_set_hw_res_pkt.enable_mes_info_ctx = 1;
-
-	ret = amdgpu_bo_create_kernel(adev, alloc_size, PAGE_SIZE,
-				AMDGPU_GEM_DOMAIN_VRAM,
-				&mes->resource_1,
-				&mes->resource_1_gpu_addr,
-				&mes->resource_1_addr);
-	if (ret) {
-		dev_err(adev->dev, "(%d) failed to create mes resource_1 bo\n", ret);
-		return ret;
-	}
-
 	mes_set_hw_res_pkt.mes_info_ctx_mc_addr = mes->resource_1_gpu_addr;
-	mes_set_hw_res_pkt.mes_info_ctx_size = hw_rsrc_size;
+	mes_set_hw_res_pkt.mes_info_ctx_size = MES11_HW_RESOURCE_1_SIZE;
 	mes_set_hw_res_pkt.cleaner_shader_fence_mc_addr =
-		mes->resource_1_gpu_addr + hw_rsrc_size;
+		mes->resource_1_gpu_addr + MES11_HW_RESOURCE_1_SIZE;
 
 	return mes_v11_0_submit_pkt_and_poll_completion(mes,
 			&mes_set_hw_res_pkt, sizeof(mes_set_hw_res_pkt),
@@ -1442,6 +1427,23 @@ static int mes_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	if (amdgpu_sriov_is_mes_info_enable(adev) ||
+	    adev->gfx.enable_cleaner_shader) {
+		int ret;
+
+		ret = amdgpu_bo_create_kernel(adev,
+					      MES11_HW_RESOURCE_1_SIZE + AMDGPU_GPU_PAGE_SIZE,
+					      PAGE_SIZE,
+					      AMDGPU_GEM_DOMAIN_VRAM,
+					      &adev->mes.resource_1,
+					      &adev->mes.resource_1_gpu_addr,
+					      &adev->mes.resource_1_addr);
+		if (ret) {
+			dev_err(adev->dev, "(%d) failed to create mes resource_1 bo\n", ret);
+			return ret;
+		}
+	}
+
 	return 0;
 }
 
@@ -1450,6 +1452,12 @@ static int mes_v11_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int pipe;
 
+	if (amdgpu_sriov_is_mes_info_enable(adev) ||
+	    adev->gfx.enable_cleaner_shader) {
+		amdgpu_bo_free_kernel(&adev->mes.resource_1, &adev->mes.resource_1_gpu_addr,
+				      &adev->mes.resource_1_addr);
+	}
+
 	for (pipe = 0; pipe < AMDGPU_MAX_MES_PIPES; pipe++) {
 		kfree(adev->mes.mqd_backup[pipe]);
 
@@ -1670,14 +1678,6 @@ static int mes_v11_0_hw_init(struct amdgpu_ip_block *ip_block)
 
 static int mes_v11_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = ip_block->adev;
-
-	if (amdgpu_sriov_is_mes_info_enable(adev) ||
-	    adev->gfx.enable_cleaner_shader) {
-		amdgpu_bo_free_kernel(&adev->mes.resource_1, &adev->mes.resource_1_gpu_addr,
-				      &adev->mes.resource_1_addr);
-	}
-
 	return 0;
 }
 
-- 
2.48.1

