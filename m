Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6F60106B53F
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2026 14:13:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4073110E7F7;
	Wed, 25 Mar 2026 14:13:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ypEvN5Zg";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011006.outbound.protection.outlook.com [52.101.52.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E98D10E7EE
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2026 14:12:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X8F5THOOXp4PGr2XnjB4Ig1UzOlKwFt29rEERdjWm9sjkTjrd1psnfM27ufZllcqfOs6lN1TkFvWLBT1TeOIMcGfUsFbXdGlTcZz6+Hu0s/ZOiwAAcs4KsbqYjnluh7sfVJy9foXZKgujBl6svDiu70LwrQkkA42ST0/dsyhF06+Pvec6HBDTrACBvpr0muWNhcDrxMMr6wg3mS84U3WSlC4wCacaiEgyB2ZC/gZH10egXvQ0BBxHO/BJEXBGDXYVQi3BGhzVOilg9gdFnfMtmLUxWSI/S/0iovdu/4hJQSUMfwqlsXugcKO1EEtecA/z9MDKkODGUP+nB6odytQ6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8iGG/9IKGbQ0E3NH4uH6hm+5gfWhTVpdHM7uGj3VisU=;
 b=jPzyfejBj6/h71kV/PiqSEyBdLu/HsiQ/eRR3O4mqof8ITbmSYUtAdJWry4EjUWjFL8YX9Lagx6KGEQJHKjBKKVhuSiMXhVLwpAuxFlM67GB/NXgvHvSwT8ExDOrfQkIchHJ8UpZB1kHE04T7Aa3UarZIQLLCKKW14AaWT8kKu6VEwo6oit6VLgca9DM+n5BGVIDnZME8ynRroJGBMSVzrR61ZNxMruJc1Sv3EKum8b2Hl1JAfoC7DaGIwNIDgYWXWKzTWk+Ib+ZIpfSM5DtkKrwuPLB9ulzybZ1fG8yU77XyzBLMETwICY6TH9WT9YjKXuDEspbCk2ZBUVHOSJ+pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8iGG/9IKGbQ0E3NH4uH6hm+5gfWhTVpdHM7uGj3VisU=;
 b=ypEvN5ZgKTSlgnI6/t/6TBa2K50W7uZUB9/9xHmlpbKlSwmd5BOapQPi39fs48+TVrmQiKhUsZwGRWIPT7IHcj+GD3xW50J0KVXYBNhWpzigQQEU2Udseq97YYR+Rxbdx087LHX61OMUcML00Sd/DmhKLuJVBPcZDO0ab7SGQsM=
Received: from SJ0PR03CA0366.namprd03.prod.outlook.com (2603:10b6:a03:3a1::11)
 by MN2PR12MB4469.namprd12.prod.outlook.com (2603:10b6:208:268::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 14:12:53 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::6e) by SJ0PR03CA0366.outlook.office365.com
 (2603:10b6:a03:3a1::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Wed,
 25 Mar 2026 14:12:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 25 Mar 2026 14:12:52 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Mar
 2026 09:12:49 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <Feifei.Xu@amd.com>
Subject: [PATCH 2/9] drm/amdgpu: Add stolen vga reserve-region
Date: Wed, 25 Mar 2026 19:42:19 +0530
Message-ID: <20260325141226.1173216-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260325141226.1173216-1-lijo.lazar@amd.com>
References: <20260325141226.1173216-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|MN2PR12MB4469:EE_
X-MS-Office365-Filtering-Correlation-Id: 696b3061-b21c-4f35-7627-08de8a789a56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 0I8IMzz12qaC7w+MAFcFtZ1B/4Nkp1EbI3ROuOt1pge3tsJwamqHxlT/FH79BvJb4NKCyDVz8IBFSlqI4lQ5NnzH/rOEBRX5cuwDq4qrnCOZt7I1mA/nJAbPZpG2M4N2nzi7LKh8Kj9Z3jYzMH9krLWoFygUweg2tr6JxpUdgjC6Ik7UT4vjxXEZH6eaivzOF969U4qFZuKeagxHjdGj/l9Z4Jp4X+8iJuRdxztFEfPDuOX7In+rBX2VxfJBxLmh/CqHNEreS4F1mLMZIBN7/TvU1f32UxSD6s8NlwSpKdhGCNWuE7Jk7mQVdnLawsynUOYywzxPe+CbDtoXgf2y+CSYox8Wn1Hkij/jagan+5pSV0qOnugFmhGC/886eYVfHdIu5K+EHnaYlvutsZC+n3dHWg8OhB5R7tkf8YnY4bmYxGe1+A4A0j7TLRV1q/mVr/KWsCIXUJi8gK6gQ55j22Y3RHRlSILyH63Nvmrc2Iui9Q3XQYmwx4jMzoipvbHWki0dNgCoJNcMsd6GjIbjUUzlPC4d2dWzmf1sCEA9R/B+hgjpeqPKS7gHOKt8AlWfBix7lcvptpAvzuhFpef9bdqXZqJWrPUhSsOD7becDWog+JyEpXON/XRfa1v4HbWaU9VaWCj0/Z62M9XVBLq4uhOd2ml4H4sin2+YssgC/0LpOPtX9wLrlp2Vv1MXKELmhT7wwcXVcdzT3SSUtuGmVyODZG7VtNLaYvnlLQE+TAvYRCTinF2E51j0Jz+Y3JLvYKs8pytpeTLGKNnLpRPSJg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YsfwGAZR9j17QiZWXrL/0V54tS5FPdg/5RvoS6nikCutYJF5CbODZL0zyYlgcq2sLJXyaQE3msWMeVriJ1XtNzZd1NlgvwP1H9ZQYva696qA7J9LtthS8jChdC8ZRpvuJS6NV7HsHUddyZwWxc453qHCtQj7Ozp6jilcJxPQttzbN1YMgfcdf/4qswvSjSOmknXh20RVMOyNvB6K3EOrzkHN0enENg8UJQiHGQBJVJph46Nw1DjhuPvDNYJVn/iJbO+xOCbXtGFLPicQTqM2MYtGV5EPNXuIJgX48MOUxUZv2uiukmdKGRzyx+HzHWeQaiPHemSiGPSshZG8ufrLlA167evNta/4TPEHDxvw4AjO43+DEVMUYPLxpj3ZNa7d/QFKdZOoV3XYT9yc0E42KLKh2yQabSW3jsKb3zRVL0jX1s1KedwQiatV9+9sRstS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 14:12:52.1812 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 696b3061-b21c-4f35-7627-08de8a789a56
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4469
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

Use reserve region helpers for initializing/reserving stolen vga region.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c           |  8 +++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c           | 10 ++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h           |  2 --
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  2 +-
 4 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index f165d4e401e8..c40ae1073017 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -1098,10 +1098,12 @@ void amdgpu_gmc_get_vbios_allocations(struct amdgpu_device *adev)
 		size = 0;
 
 	if (size > AMDGPU_VBIOS_VGA_ALLOCATION) {
-		adev->mman.stolen_vga_size = AMDGPU_VBIOS_VGA_ALLOCATION;
-		adev->mman.stolen_extended_size = size - adev->mman.stolen_vga_size;
+		amdgpu_ttm_init_vram_resv(adev, AMDGPU_RESV_STOLEN_VGA,
+					  0, AMDGPU_VBIOS_VGA_ALLOCATION, false);
+		adev->mman.stolen_extended_size = size - AMDGPU_VBIOS_VGA_ALLOCATION;
 	} else {
-		adev->mman.stolen_vga_size = size;
+		amdgpu_ttm_init_vram_resv(adev, AMDGPU_RESV_STOLEN_VGA,
+					  0, size, false);
 		adev->mman.stolen_extended_size = 0;
 	}
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 7f04e53983b5..84c482cc653f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2213,14 +2213,12 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 	 * and driver.
 	 */
 	if (!adev->gmc.is_app_apu) {
-		r = amdgpu_bo_create_kernel_at(adev, 0,
-					       adev->mman.stolen_vga_size,
-					       &adev->mman.stolen_vga_memory,
-					       NULL);
+		r = amdgpu_ttm_reserve_vram(adev, AMDGPU_RESV_STOLEN_VGA);
 		if (r)
 			return r;
 
-		r = amdgpu_bo_create_kernel_at(adev, adev->mman.stolen_vga_size,
+		r = amdgpu_bo_create_kernel_at(adev,
+					       adev->mman.resv_region[AMDGPU_RESV_STOLEN_VGA].size,
 					       adev->mman.stolen_extended_size,
 					       &adev->mman.stolen_extended_memory,
 					       NULL);
@@ -2349,7 +2347,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
 	amdgpu_ttm_training_reserve_vram_fini(adev);
 	/* return the stolen vga memory back to VRAM */
 	if (!adev->gmc.is_app_apu) {
-		amdgpu_bo_free_kernel(&adev->mman.stolen_vga_memory, NULL, NULL);
+		amdgpu_ttm_unreserve_vram(adev, AMDGPU_RESV_STOLEN_VGA);
 		amdgpu_bo_free_kernel(&adev->mman.stolen_extended_memory, NULL, NULL);
 		/* return the FW reserved memory back to VRAM */
 		amdgpu_bo_free_kernel(&adev->mman.fw_reserved_memory, NULL,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index b73f65a4bc0d..d973c96f0ebb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -99,8 +99,6 @@ struct amdgpu_mman {
 	struct amdgpu_gtt_mgr gtt_mgr;
 	struct ttm_resource_manager preempt_mgr;
 
-	uint64_t		stolen_vga_size;
-	struct amdgpu_bo	*stolen_vga_memory;
 	uint64_t		stolen_extended_size;
 	struct amdgpu_bo	*stolen_extended_memory;
 	bool			keep_stolen_vga_memory;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index d73095ac3ab1..30521e270d71 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -11153,7 +11153,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 	if (!adev->in_suspend) {
 		/* return the stolen vga memory back to VRAM */
 		if (!adev->mman.keep_stolen_vga_memory)
-			amdgpu_bo_free_kernel(&adev->mman.stolen_vga_memory, NULL, NULL);
+			amdgpu_ttm_unreserve_vram(adev, AMDGPU_RESV_STOLEN_VGA);
 		amdgpu_bo_free_kernel(&adev->mman.stolen_extended_memory, NULL, NULL);
 	}
 
-- 
2.49.0

