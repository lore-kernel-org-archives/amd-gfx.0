Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14F40CD1297
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2026 05:56:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA82B10E40E;
	Thu, 30 Apr 2026 05:56:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="35zshlct";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010035.outbound.protection.outlook.com [52.101.61.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D70410E40E
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2026 05:56:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iS5mYl45DrqbJdayvF9MyZ51nEjzlpwXErvyyf/QdN+a82x1jew/hR0wxlnUUtGb5Ktg0sG2l4bX5m6oeea9/0+dPA1U+1EWofCUsCuP/xfK9VyfpgZCTFyMwOO8zhodqsPLzKF4zbpd59VeK+wMtQDDNu248lhHK9gB2HgBwg5WB4POmqdZHGcdmmDVmd1n4rzIo/kSucuxlQhnAc2vuMjn7nTQGe+P/sBK3PZUMWI0BmB9djlbi0vMg+4jRVdXG/Rx5PKFIj/PJMQ6qF+iDo3VF0CX82SropBT302ur9aXryLTZNlewsNj3qGXNCmq1GLydBn17eOWMZccuvoSzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ejgMDwXqsEbbO+TICWSRVEjF++dGDFareJPlC1sq9w=;
 b=haUysNDmcq0qgk0b/dF280wrVRKJFiAZ554uG0zwR0O2rHrzHQzNyWdRcxbxlTjj9Cq74dTT+ScxzS48Rf+POR+fddTmHnn31UC1mt9752nKCJz5wy3J30QQsVr7Rc367NYwXLpibprZmpTvjUM7wQ7NJcc3Ir4BxA9zQoH9pQwTWjsTDylP9p/J5tcI2zBr8vMzNffFB7xi0jACyK6Jr15tFTDAZ/amSulmETk521Z9SqM1x5oSt/V9njV8zo9l+JrCA8FT0t15K8zmHDimo0SW5KV7Iz8tQ4kDw8OLOmakTcBBauI3kBJ/NCBNi6vL1Vaw3bOmOPVtnJcVg4svlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ejgMDwXqsEbbO+TICWSRVEjF++dGDFareJPlC1sq9w=;
 b=35zshlctcp/foe+h6msDf6QPXxBHx4oVrBIEyY7L9S/B43ANQWZXmkLTnlhEtCj0Rb6bozIdNnEQjjJrwrqY7GARq3EwMBIlMY92smwGyFKV1jaApO3fExlGeYWroLwGD7OfhGS4MbBC7ieIDH5eoJDjy52jWaBMn70KtGTsJ6c=
Received: from CY5PR22CA0005.namprd22.prod.outlook.com (2603:10b6:930:16::28)
 by DS4PR12MB9587.namprd12.prod.outlook.com (2603:10b6:8:282::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Thu, 30 Apr
 2026 05:55:52 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:930:16:cafe::d1) by CY5PR22CA0005.outlook.office365.com
 (2603:10b6:930:16::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Thu,
 30 Apr 2026 05:55:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 30 Apr 2026 05:55:49 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Apr
 2026 00:55:47 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <Christian.Koenig@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Use helper to set gart size
Date: Thu, 30 Apr 2026 11:25:27 +0530
Message-ID: <20260430055527.4026042-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260430055527.4026042-1-lijo.lazar@amd.com>
References: <20260430055527.4026042-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|DS4PR12MB9587:EE_
X-MS-Office365-Filtering-Correlation-Id: a873003e-7302-405d-44bc-08dea67d21bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: HLf0duTeSwGbD/GXQW9ewsQGWN2PtYEQ928WdMP9Lc9snDY7F1tpEyps8zf8TjVtUDz5YTIyUJBBTpvXY8Alh3evEeWjaTLtcD+OMW0nkaeohSOnYxXqGfGEXCv5O5HrRZkBbavkkB1fmjjQmQsy1mQAxxO0CZamw0azn6tt6B0HMX4qyHyvou0UqnRxpJRcob2r0pJ5H4MhaCJTrrk1mPb+BWux8QPxUCE6vcoIqKzjd1a1f4c245nnPXfYc7GLVEmgdiSPUxWtkcAiO0SVklOsbd0zsqUOcvK+xBaYy+U3nFywhkMgTYep7BP/a0H8A9KZB3wJulmM+bg4AOSO58lz1SWRuDXLTsdT4apeoIA+I/sy76r89Jck5ndFtudkiuBQ8H7v/1V7FQgH47BZc8e/B+aVHGygQF7L6bqS1RsHCpH8/gIrfJ07IUpj8sNZL+A0lIpu4VtriYwQEOxzJ/XBPrI5Pj305ohQIXdyd4IAPw+jhAUbvOvW/b/lBROAcJbF5fNsVPSHAxRAXLAlyPbYGxv9A4+tdDzNc674bjEkRs9pQwd9RVtwaIvGBK30NnQivSu15v4j1yKcOFKCzk7R0AxEVkgUa6vvtNzWzXGI99L/gu0g8Se+Zb5TWdYcxN508xV4jEiG6k1VuV6/Dh8jhiqjdd0dODHIdP1SEJ/WoFEXIhhYglYfBknPwDpooKQzacoE9SAX5F2FzXJsqZ1gPDTLTcr/nm81utxEhTbcn330S7i4SL07WaOZwOnnIPkL+xh4AOfJAZjarf8+sA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SKR4ijbEAsZy1/LBJ8q4gO0a2GXMs0VAdxjAGm5rjk4GsXG6g+c3cy64WdE1hYIGt68CJ2Lvm3bTgTu/E9GRdigqzLt7Q8TVUFWUq0twS0f+JHN5l/tbxojIUSDV1QftidYqtlGUpJ3xMGsqZ0NjxGyFIXKMc1cxtAlf5wwsTaJ8vXx8GYEVd3/lxIn749krLZPNFX/mHpq5Vve6RuPEIcxggR7vIce4plRXVqfIWtdM7c1u9pHALblOpCLUpXIcoWBgfXsInBmGyHqZSc3l1tSZzy/iUllNIhfFzw553QjVQGupPE82bf+YJlz8f1bTaAUYZNGYckun6k5cvoAytHXdi3bj7yPb2QQolzKUK5MRodd0mRtKD6RiUfNwhvlhAqAc9n8SGvnB5l9Wr7KWdxLzXgBl8LM1i1bWdYo5nCdgWfbiYG2GZZYPSi17ck6R
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 05:55:49.9831 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a873003e-7302-405d-44bc-08dea67d21bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9587
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

Find the default size required and use the helper funcction to set gart size.

Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 24 +++++++---------
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c |  5 +---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c |  5 +---
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c  | 28 +++++++-----------
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c  | 30 ++++++++-----------
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c  | 34 +++++++++-------------
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  | 40 +++++++++++---------------
 7 files changed, 66 insertions(+), 100 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index e1ace7d44ffd..8523833a74fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -707,20 +707,16 @@ static int gmc_v10_0_mc_init(struct amdgpu_device *adev)
 	adev->gmc.visible_vram_size = adev->gmc.aper_size;
 
 	/* set the gart size */
-	if (amdgpu_gart_size == -1) {
-		switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
-		default:
-			adev->gmc.gart_size = 512ULL << 20;
-			break;
-		case IP_VERSION(10, 3, 1):   /* DCE SG support */
-		case IP_VERSION(10, 3, 3):   /* DCE SG support */
-		case IP_VERSION(10, 3, 6):   /* DCE SG support */
-		case IP_VERSION(10, 3, 7):   /* DCE SG support */
-			adev->gmc.gart_size = 1024ULL << 20;
-			break;
-		}
-	} else {
-		adev->gmc.gart_size = (u64)amdgpu_gart_size << 20;
+	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
+	case IP_VERSION(10, 3, 1):   /* DCE SG support */
+	case IP_VERSION(10, 3, 3):   /* DCE SG support */
+	case IP_VERSION(10, 3, 6):   /* DCE SG support */
+	case IP_VERSION(10, 3, 7):   /* DCE SG support */
+		amdgpu_gmc_set_gart_size(adev, SZ_1G);
+		break;
+	default:
+		amdgpu_gmc_set_gart_size(adev, SZ_512M);
+		break;
 	}
 
 	gmc_v10_0_vram_gtt_location(adev, &adev->gmc);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 94d6631ce0bc..16388e3caea3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -709,10 +709,7 @@ static int gmc_v11_0_mc_init(struct amdgpu_device *adev)
 		adev->gmc.visible_vram_size = adev->gmc.real_vram_size;
 
 	/* set the gart size */
-	if (amdgpu_gart_size == -1)
-		adev->gmc.gart_size = 512ULL << 20;
-	else
-		adev->gmc.gart_size = (u64)amdgpu_gart_size << 20;
+	amdgpu_gmc_set_gart_size(adev, SZ_512M);
 
 	gmc_v11_0_vram_gtt_location(adev, &adev->gmc);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index 5bdd4b9b7893..586703ec0dfa 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -765,10 +765,7 @@ static int gmc_v12_0_mc_init(struct amdgpu_device *adev)
 		adev->gmc.visible_vram_size = adev->gmc.real_vram_size;
 
 	/* set the gart size */
-	if (amdgpu_gart_size == -1) {
-		adev->gmc.gart_size = 512ULL << 20;
-	} else
-		adev->gmc.gart_size = (u64)amdgpu_gart_size << 20;
+	amdgpu_gmc_set_gart_size(adev, SZ_512M);
 
 	gmc_v12_0_vram_gtt_location(adev, &adev->gmc);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index cc272a96fcef..af6944d2d330 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -328,24 +328,18 @@ static int gmc_v6_0_mc_init(struct amdgpu_device *adev)
 	adev->gmc.visible_vram_size = adev->gmc.aper_size;
 
 	/* set the gart size */
-	if (amdgpu_gart_size == -1) {
-		switch (adev->asic_type) {
-		case CHIP_HAINAN:    /* no MM engines */
-		default:
-			adev->gmc.gart_size = 256ULL << 20;
-			break;
-		case CHIP_VERDE:    /* UVD, VCE do not support GPUVM */
-		case CHIP_TAHITI:   /* UVD, VCE do not support GPUVM */
-		case CHIP_PITCAIRN: /* UVD, VCE do not support GPUVM */
-		case CHIP_OLAND:    /* UVD, VCE do not support GPUVM */
-			adev->gmc.gart_size = 1024ULL << 20;
-			break;
-		}
-	} else {
-		adev->gmc.gart_size = (u64)amdgpu_gart_size << 20;
+	switch (adev->asic_type) {
+	case CHIP_VERDE:    /* UVD, VCE do not support GPUVM */
+	case CHIP_TAHITI:   /* UVD, VCE do not support GPUVM */
+	case CHIP_PITCAIRN: /* UVD, VCE do not support GPUVM */
+	case CHIP_OLAND:    /* UVD, VCE do not support GPUVM */
+		amdgpu_gmc_set_gart_size(adev, SZ_1G);
+		break;
+	case CHIP_HAINAN:    /* no MM engines */
+	default:
+		amdgpu_gmc_set_gart_size(adev, SZ_256M);
+		break;
 	}
-
-	adev->gmc.gart_size += adev->pm.smu_prv_buffer_size;
 	gmc_v6_0_vram_gtt_location(adev, &adev->gmc);
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index fb5e33c8a5ee..93cf283191fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -394,27 +394,21 @@ static int gmc_v7_0_mc_init(struct amdgpu_device *adev)
 	adev->gmc.visible_vram_size = adev->gmc.aper_size;
 
 	/* set the gart size */
-	if (amdgpu_gart_size == -1) {
-		switch (adev->asic_type) {
-		case CHIP_TOPAZ:     /* no MM engines */
-		default:
-			adev->gmc.gart_size = 256ULL << 20;
-			break;
+	switch (adev->asic_type) {
 #ifdef CONFIG_DRM_AMDGPU_CIK
-		case CHIP_BONAIRE: /* UVD, VCE do not support GPUVM */
-		case CHIP_HAWAII:  /* UVD, VCE do not support GPUVM */
-		case CHIP_KAVERI:  /* UVD, VCE do not support GPUVM */
-		case CHIP_KABINI:  /* UVD, VCE do not support GPUVM */
-		case CHIP_MULLINS: /* UVD, VCE do not support GPUVM */
-			adev->gmc.gart_size = 1024ULL << 20;
-			break;
+	case CHIP_BONAIRE: /* UVD, VCE do not support GPUVM */
+	case CHIP_HAWAII:  /* UVD, VCE do not support GPUVM */
+	case CHIP_KAVERI:  /* UVD, VCE do not support GPUVM */
+	case CHIP_KABINI:  /* UVD, VCE do not support GPUVM */
+	case CHIP_MULLINS: /* UVD, VCE do not support GPUVM */
+		amdgpu_gmc_set_gart_size(adev, SZ_1G);
+		break;
 #endif
-		}
-	} else {
-		adev->gmc.gart_size = (u64)amdgpu_gart_size << 20;
+	case CHIP_TOPAZ:     /* no MM engines */
+	default:
+		amdgpu_gmc_set_gart_size(adev, SZ_256M);
+		break;
 	}
-
-	adev->gmc.gart_size += adev->pm.smu_prv_buffer_size;
 	gmc_v7_0_vram_gtt_location(adev, &adev->gmc);
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 963d5b0fa87b..1d3ddffd5a11 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -585,27 +585,21 @@ static int gmc_v8_0_mc_init(struct amdgpu_device *adev)
 	adev->gmc.visible_vram_size = adev->gmc.aper_size;
 
 	/* set the gart size */
-	if (amdgpu_gart_size == -1) {
-		switch (adev->asic_type) {
-		case CHIP_POLARIS10: /* all engines support GPUVM */
-		case CHIP_POLARIS11: /* all engines support GPUVM */
-		case CHIP_POLARIS12: /* all engines support GPUVM */
-		case CHIP_VEGAM:     /* all engines support GPUVM */
-		default:
-			adev->gmc.gart_size = 256ULL << 20;
-			break;
-		case CHIP_TONGA:   /* UVD, VCE do not support GPUVM */
-		case CHIP_FIJI:    /* UVD, VCE do not support GPUVM */
-		case CHIP_CARRIZO: /* UVD, VCE do not support GPUVM, DCE SG support */
-		case CHIP_STONEY:  /* UVD does not support GPUVM, DCE SG support */
-			adev->gmc.gart_size = 1024ULL << 20;
-			break;
-		}
-	} else {
-		adev->gmc.gart_size = (u64)amdgpu_gart_size << 20;
+	switch (adev->asic_type) {
+	case CHIP_TONGA:   /* UVD, VCE do not support GPUVM */
+	case CHIP_FIJI:    /* UVD, VCE do not support GPUVM */
+	case CHIP_CARRIZO: /* UVD, VCE do not support GPUVM, DCE SG support */
+	case CHIP_STONEY:  /* UVD does not support GPUVM, DCE SG support */
+		amdgpu_gmc_set_gart_size(adev, SZ_1G);
+		break;
+	case CHIP_POLARIS10: /* all engines support GPUVM */
+	case CHIP_POLARIS11: /* all engines support GPUVM */
+	case CHIP_POLARIS12: /* all engines support GPUVM */
+	case CHIP_VEGAM:     /* all engines support GPUVM */
+	default:
+		amdgpu_gmc_set_gart_size(adev, SZ_256M);
+		break;
 	}
-
-	adev->gmc.gart_size += adev->pm.smu_prv_buffer_size;
 	gmc_v8_0_vram_gtt_location(adev, &adev->gmc);
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index aca7841173f3..ced0f3941863 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1731,31 +1731,25 @@ static int gmc_v9_0_mc_init(struct amdgpu_device *adev)
 	adev->gmc.visible_vram_size = adev->gmc.aper_size;
 
 	/* set the gart size */
-	if (amdgpu_gart_size == -1) {
-		switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
-		case IP_VERSION(9, 0, 1):  /* all engines support GPUVM */
-		case IP_VERSION(9, 2, 1):  /* all engines support GPUVM */
-		case IP_VERSION(9, 4, 0):
-		case IP_VERSION(9, 4, 1):
-		case IP_VERSION(9, 4, 2):
-		case IP_VERSION(9, 4, 3):
-		case IP_VERSION(9, 4, 4):
-		case IP_VERSION(9, 5, 0):
-		default:
-			adev->gmc.gart_size = 512ULL << 20;
-			break;
-		case IP_VERSION(9, 1, 0):   /* DCE SG support */
-		case IP_VERSION(9, 2, 2):   /* DCE SG support */
-		case IP_VERSION(9, 3, 0):
-			adev->gmc.gart_size = 1024ULL << 20;
-			break;
-		}
-	} else {
-		adev->gmc.gart_size = (u64)amdgpu_gart_size << 20;
+	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
+	case IP_VERSION(9, 1, 0):   /* DCE SG support */
+	case IP_VERSION(9, 2, 2):   /* DCE SG support */
+	case IP_VERSION(9, 3, 0):
+		amdgpu_gmc_set_gart_size(adev, SZ_1G);
+		break;
+	case IP_VERSION(9, 0, 1):  /* all engines support GPUVM */
+	case IP_VERSION(9, 2, 1):  /* all engines support GPUVM */
+	case IP_VERSION(9, 4, 0):
+	case IP_VERSION(9, 4, 1):
+	case IP_VERSION(9, 4, 2):
+	case IP_VERSION(9, 4, 3):
+	case IP_VERSION(9, 4, 4):
+	case IP_VERSION(9, 5, 0):
+	default:
+		amdgpu_gmc_set_gart_size(adev, SZ_512M);
+		break;
 	}
 
-	adev->gmc.gart_size += adev->pm.smu_prv_buffer_size;
-
 	gmc_v9_0_vram_gtt_location(adev, &adev->gmc);
 
 	return 0;
-- 
2.49.0

