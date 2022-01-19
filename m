Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D97CEC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jan 2022 15:47:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6971810E277;
	Wed, 19 Jan 2022 15:47:52 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2071.outbound.protection.outlook.com [40.107.95.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0823010E277
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jan 2022 15:47:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VfQj0AKxlGmwkvPrAW8zK4Ek5SV96mh9Al6tJYhWOhTk5wAyfU1P7bdXM5a54+jFs6Pas4P8fd68XRNhqiouI+BTUAGohWycLSFxGuqCaSrtd4uf1NRwWsRWlIUVysrR98EQZtxX4yZ1BJPPTkQn1j9yxWZ5HofmEDgtGV7YzQCtI7BfiLacaDWxtsxmtg9Irszaf0xGuQZtSCPbCuG4lWxl6V/YJ6wm1tTNr3RFu2MnX+qSaAQjsPLaEEs1v96jDp4xWqRs9x7EhGbmGCRLI5szCABrBno3+hevP+CWMWhUlL248MfMliszpeRIhYDJwXGpiYWBu0xqTjR5eR8VwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dI7ncV1798ATUzY/e055dZ6YjNqIqPaHZC/0V+jrAEM=;
 b=F/A+K/uGvqDUr0z3IFjbmQsXcdlJ6ZW5klstajV0ZRXJUfq0u7vA+V/eOEvRm+TZf3Lm3pHZ455M87do+K1y+J/Xk/85FKABtapDwtipmxDwVoi58Y/GT9Xi2G7SHsxqXMf1IzMsXX0bm3jZSEe2Jb5KyEzySxV7kUDGhyrtVklYDQPTWazb6rAJppvgp91mc6bCt1docXhFa+DyTty2hKM/F4mCo9eOIHR5fS20yoq2LR9ziEPQjwgK4MXKk+yMxvfzEoAErSg4w/gN1Tqxph7g6rMHoAxR1waHEUVitJqNeobisYWOJOPfg5prLNLjmh0Gt/opWTo0H2P5Qil0gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dI7ncV1798ATUzY/e055dZ6YjNqIqPaHZC/0V+jrAEM=;
 b=KMhhY+oLqdK88DJdiCOn93k2xJ81n5k4kK3hnUlQ0tJNJlwYLXEk0OvUA+tGFW7KJ2aRfHL7N+q/Kh1OamAPFaKKL7x95HYx7oIZFSI9076t82e/P43/fxRKAJYEEgPhRRcsMSCrjfxNiKLgG/WA58VKUJCMeHSjhUf4Jp8eKeU=
Received: from BN9PR03CA0989.namprd03.prod.outlook.com (2603:10b6:408:109::34)
 by BN6PR12MB1697.namprd12.prod.outlook.com (2603:10b6:404:105::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Wed, 19 Jan
 2022 15:47:50 +0000
Received: from BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::21) by BN9PR03CA0989.outlook.office365.com
 (2603:10b6:408:109::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7 via Frontend
 Transport; Wed, 19 Jan 2022 15:47:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT067.mail.protection.outlook.com (10.13.177.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Wed, 19 Jan 2022 15:47:50 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 19 Jan
 2022 09:47:49 -0600
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix broken debug sdma vram access function
Date: Wed, 19 Jan 2022 10:47:36 -0500
Message-ID: <20220119154736.113984-1-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ecc8f6b-d780-4b17-8637-08d9db630c2a
X-MS-TrafficTypeDiagnostic: BN6PR12MB1697:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB16975ECDF9C835BD93A9676885599@BN6PR12MB1697.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7IpcEZje8r8EKYUQ3IOkmWKdDk7ch0p+frTHcGbTja0E010mZ+0zFjEo8J5NqIHm85fNIFEgLXULAdgSGW3CYYvtX6kM6uoEJAg8P+gXv5CgpdZBZYW1DMyTQrMDkAEa/bxbwq+2d+nLSPmKYTO5Iwo+aBS0NvHU2UxINAV+vhOXcPejDcf2XYLz7OPfQISE+RBJmjcaOGJb3T9lCkQX7onStqXrupSm5GuFazkbN9g2z7/AtdCIitH/s10DzKxj0XaXrf1cEXzJGGD/yM7gkTgvWvf1c/J3j8x9Y3JxTkJB//0WnEcxN5nnNJlW7dS3CB1pnxr4jgC0nfApNNvF3U2kNB74lsrRdyWYmhsJZNbBDoTuKmdJ7IvasllF/0d7L86k18Nq3Uehj4/YiRq0TB/UmDSxf8eO8rf6JgY0e8WBR5pAZvfeG/eNGNILI8yarsQJYKFxUTJe8z0LidHHToyzh2du6TYCyU5Fg2XpUkh3g9azmDV0LegK9sqPZ1AADfyLAifFDzY5VmUDFHXgM05KEYkAcyRdMrMLDyZyBI+6Yug+Saqlx//oEOSAXsCm46V0YPZgs4/4MIoAvLt7Xroqz+fEPETgUcTQ4ztpmLm8vNf8G76XKqDkMFmQMTKxs/nQmvWs8sEg7edyeyQ03jeOU2AgFmp8pe5pTkjcUmPd5VJpCMQkn1AVC+PvGPTGAC8nLe6kzQDrI3Ykchpg/5PK4z6c91V7tyqjkuz/oO86UTj466Wb8a2TiW+hIxRHYXW44hqVA5ucWCtIFhoVfS9tnYauIiFFRCqbSO2ftlU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(40470700002)(36840700001)(82310400004)(70206006)(4326008)(7696005)(6916009)(16526019)(186003)(6666004)(47076005)(8936002)(26005)(54906003)(316002)(40460700001)(36756003)(1076003)(86362001)(70586007)(2906002)(81166007)(5660300002)(508600001)(2616005)(356005)(426003)(44832011)(8676002)(83380400001)(336012)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 15:47:50.1525 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ecc8f6b-d780-4b17-8637-08d9db630c2a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1697
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
Cc: Felix.Kuehling@amd.com, Jonathan Kim <jonathan.kim@amd.com>,
 Christian.Koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Debug VRAM access through SDMA has several broken parts resulting in
silent MMIO fallback.

BO kernel creation takes the location of the cpu addr pointer, not
the pointer itself for address kmap.

drm_dev_enter return true on success so change access check.

The source BO is reserved but not pinned so find the address using the
cursor offset relative to its memory domain start.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index b489cd8abe31..0a2e8e355eaa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1436,6 +1436,7 @@ static int amdgpu_ttm_access_memory_sdma(struct ttm_buffer_object *bo,
 {
 	struct amdgpu_bo *abo = ttm_to_amdgpu_bo(bo);
 	struct amdgpu_device *adev = amdgpu_ttm_adev(abo->tbo.bdev);
+	struct amdgpu_res_cursor src_mm;
 	struct amdgpu_job *job;
 	struct dma_fence *fence;
 	uint64_t src_addr, dst_addr;
@@ -1448,9 +1449,8 @@ static int amdgpu_ttm_access_memory_sdma(struct ttm_buffer_object *bo,
 	if (!adev->mman.sdma_access_ptr)
 		return -EACCES;
 
-	r = drm_dev_enter(adev_to_drm(adev), &idx);
-	if (r)
-		return r;
+	if (!drm_dev_enter(adev_to_drm(adev), &idx))
+		return -ENODEV;
 
 	if (write)
 		memcpy(adev->mman.sdma_access_ptr, buf, len);
@@ -1460,7 +1460,8 @@ static int amdgpu_ttm_access_memory_sdma(struct ttm_buffer_object *bo,
 	if (r)
 		goto out;
 
-	src_addr = amdgpu_bo_gpu_offset(abo);
+	amdgpu_res_first(abo->tbo.resource, offset, len, &src_mm);
+	src_addr = amdgpu_ttm_domain_start(adev, bo->resource->mem_type) + src_mm.start;
 	dst_addr = amdgpu_bo_gpu_offset(adev->mman.sdma_access_bo);
 	if (write)
 		swap(src_addr, dst_addr);
@@ -1858,7 +1859,7 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 	if (amdgpu_bo_create_kernel(adev, PAGE_SIZE, PAGE_SIZE,
 				AMDGPU_GEM_DOMAIN_GTT,
 				&adev->mman.sdma_access_bo, NULL,
-				adev->mman.sdma_access_ptr))
+				&adev->mman.sdma_access_ptr))
 		DRM_WARN("Debug VRAM access will use slowpath MM access\n");
 
 	return 0;
@@ -1882,6 +1883,8 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
 	if (adev->mman.stolen_reserved_size)
 		amdgpu_bo_free_kernel(&adev->mman.stolen_reserved_memory,
 				      NULL, NULL);
+	amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
+					&adev->mman.sdma_access_ptr);
 	amdgpu_ttm_fw_reserve_vram_fini(adev);
 
 	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
@@ -1901,8 +1904,6 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
 	ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_OA);
 	ttm_device_fini(&adev->mman.bdev);
 	adev->mman.initialized = false;
-	amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
-					&adev->mman.sdma_access_ptr);
 	DRM_INFO("amdgpu: ttm finalized\n");
 }
 
-- 
2.25.1

