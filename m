Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26A14C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jan 2022 08:51:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7DEE11AE9A;
	Fri,  7 Jan 2022 08:51:47 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9976A11AE9A
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jan 2022 08:51:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=blYJw9p+rITLAUJ05X3hwGqUNaYxizj+oRINkoe/tp/XWMRQ0NeSZr6/8iWY+mISzE5pyR5rL3EOHeWfSIAhGWNhSENCAa2aXZI1uonhoLgLzXlVLrW5UUNLexjgJc+d/jZicun5xHXzbNfYD5mXLoP+WIBnO8kxo1jGxgEb+n5Mo2f9Ohebyi/+kXslkX+A6VLUjGPS11rhz2vnvsQxZoXs7o+auLfJJIkdWI5jTfWEIBjn9Q7ivD6OeNmMLZO3LOd2AJjrtfkNBhfebbCBTDW/KNh+84bstk/LZ0VfPhXgjJl3mLqgBfG9IzJJJFN+Lfj/WWPDctDwctvhNpqPTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2lKUjDmud4zK+0wCMCmMtZJLp7wFBSV/lmM04YS013U=;
 b=JvUv2w2sazjZUCeTtdIbns2Xw4hHEGgjMfYpHRt+zxo9nNoKYVEvBl3OBVbx6iGavihUlYsmmINkOGBZzGyV0GnOYjMPpI3iN8Hr8fjsMvAC2+oi5PwiDJoll9zdCi3ulxKCUC9PWaY4ud3IReU+Ux8rZTHO2KWDYiHwp9XSJhspTmboycUTJ8YnMW2mfTbUgPumkJwXCC6KWgLKYVK8n8qy/CPGfkOhqLaeAJv3RF5V/auauRa4ZkBN+Q75L2JlxdmwRuk8G2eZ4+dVuFAwFcwsGFo16OC99m/havXY7DUsiETshfSrJz/CjaqRjkqH6R/Vt2717dWE1POsBTwGJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2lKUjDmud4zK+0wCMCmMtZJLp7wFBSV/lmM04YS013U=;
 b=Ay3cXoWrEeFIo7z1E/nkwvqIiwJET8dlnZTDg1idOAOIr+qNf10bGGXnd3UcGiTyD+DuQ66doxEJd9/Ew6B/mOtimV7C1fPlHdOryq6vFOeDuTvwcGkeWAdQ/2hx+/bSVXJMqmowdS4S63CI9WnK6GRVptCK8m9E3ZGorRwP+Dw=
Received: from MW4PR04CA0364.namprd04.prod.outlook.com (2603:10b6:303:81::9)
 by DM6PR12MB4959.namprd12.prod.outlook.com (2603:10b6:5:208::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Fri, 7 Jan
 2022 08:51:40 +0000
Received: from CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::fb) by MW4PR04CA0364.outlook.office365.com
 (2603:10b6:303:81::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9 via Frontend
 Transport; Fri, 7 Jan 2022 08:51:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT065.mail.protection.outlook.com (10.13.174.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.7 via Frontend Transport; Fri, 7 Jan 2022 08:51:39 +0000
Received: from brihaspati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 7 Jan
 2022 02:51:37 -0600
From: Nirmoy Das <nirmoy.das@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH REBASED 4/4] drm/amdgpu: recover gart table at resume
Date: Fri, 7 Jan 2022 09:51:15 +0100
Message-ID: <20220107085115.8820-4-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220107085115.8820-1-nirmoy.das@amd.com>
References: <20220107085115.8820-1-nirmoy.das@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f240e7e9-e410-47e3-97d0-08d9d1baeba4
X-MS-TrafficTypeDiagnostic: DM6PR12MB4959:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB49590B4E13E46A005CEFAB948B4D9@DM6PR12MB4959.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lFxlJHaXiL/zYn61Job96r5pdbYMAzZTWs6I/Cd+hhwzCfYgJ4k4uMITdGtV7FC0cSRh3z0sy3v2YGod4MhLH7uu3T7D40v+CCnXBDwDd4MiNyhwrwSPuGp+OEiaeRf1vGSWhIVCnLLuAhIwfG4T3NkWUBZTSZ+LCH2mZ6pkUy4AIW3Q0dkQeR4d6hrDJs0gZ3DNTIA1SU7TU+CFSsTUuQmDJplcaNOQ6j279nV/zUukknexwnMD5p0CsViI3ZODn2HfnYBMfYfuFNqZ5ooq6cZhwdvXaNPjm97+K6lkQXOsJBHiBGGhUfFmpbWnI0SNxMtJytHHJKySzyMGzCeJf3G/8xz4kPLjaaTGeMPmIUErAW7i3oHWRrKIwdIkva9UZ9jpsIWIOCZcKzyKJjSm483cnXAtEyVsPZy7/GIteiWBniy7jroIW4I8Tcfr6OGQTqIEC8JO5iaZZK+FvTG2cWo1dHUHka+FuIDK8jnhFz15zaSxkjknfeOpdfRdZmMizWfPuN2Pm9/2vqZf4t0zYEieDVJaS9hy3Ybkei6HfXVdeRDJGdaU9Hub7OkHwVbAt3XR2jjWLIjmSFE0xRUm6kjOeeBWUep7fhIymJdO0lc7HmTqVtyakSxC7gJGYEyHSIXCYmd6RjqEE6GC0R6FXYJ4J7oISkvPZaWzKAxFbjun4jdPhsl/5c+0eNuETU5X6/CoJbx7tGMlcAeagJyNmU6UyDCHljvkTpfbV8YzEAY/TAxAKUACS609L1JfxOsU7Sv+XfOYRNWaTbcIBSRYw6SvIMH8LNadPhkAuK/Gcms=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(40470700002)(36840700001)(70586007)(44832011)(70206006)(426003)(36860700001)(336012)(86362001)(40460700001)(2616005)(4326008)(16526019)(82310400004)(2906002)(6666004)(5660300002)(1076003)(26005)(316002)(186003)(8936002)(36756003)(508600001)(81166007)(54906003)(7696005)(6916009)(83380400001)(356005)(47076005)(66574015)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 08:51:39.5471 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f240e7e9-e410-47e3-97d0-08d9d1baeba4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4959
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
Cc: andrey.grodzovsky@amd.com, Nirmoy Das <nirmoy.das@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Get rid off pin/unpin of gart BO at resume/suspend and
instead pin only once and try to recover gart content
at resume time. This is much more stable in case there
is OOM situation at 2nd call to amdgpu_device_evict_resources()
while evicting GART table.

v3: remove gart recovery from other places
v2: pin gart at amdgpu_gart_table_vram_alloc()

Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 11 ---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c   | 84 ++--------------------
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c     |  3 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c      |  3 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c      |  3 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c      |  3 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      |  3 +-
 7 files changed, 11 insertions(+), 99 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 58b9a5176082..a89e08e44fea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4004,16 +4004,11 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 	if (!adev->in_s0ix)
 		amdgpu_amdkfd_suspend(adev, adev->in_runpm);
 
-	/* First evict vram memory */
 	amdgpu_device_evict_resources(adev);
 
 	amdgpu_fence_driver_hw_fini(adev);
 
 	amdgpu_device_ip_suspend_phase2(adev);
-	/* This second call to evict device resources is to evict
-	 * the gart page table using the CPU.
-	 */
-	amdgpu_device_evict_resources(adev);
 
 	return 0;
 }
@@ -4356,8 +4351,6 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
 		goto error;
 
 	amdgpu_virt_init_data_exchange(adev);
-	/* we need recover gart prior to run SMC/CP/SDMA resume */
-	amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
 
 	r = amdgpu_device_fw_loading(adev);
 	if (r)
@@ -4677,10 +4670,6 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 					amdgpu_inc_vram_lost(tmp_adev);
 				}
 
-				r = amdgpu_gtt_mgr_recover(&tmp_adev->mman.gtt_mgr);
-				if (r)
-					goto out;
-
 				r = amdgpu_device_fw_loading(tmp_adev);
 				if (r)
 					return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
index d3e4203f6217..645950a653a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
@@ -114,80 +114,12 @@ void amdgpu_gart_dummy_page_fini(struct amdgpu_device *adev)
  */
 int amdgpu_gart_table_vram_alloc(struct amdgpu_device *adev)
 {
-	int r;
-
-	if (adev->gart.bo == NULL) {
-		struct amdgpu_bo_param bp;
-
-		memset(&bp, 0, sizeof(bp));
-		bp.size = adev->gart.table_size;
-		bp.byte_align = PAGE_SIZE;
-		bp.domain = AMDGPU_GEM_DOMAIN_VRAM;
-		bp.flags = AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED |
-			AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
-		bp.type = ttm_bo_type_kernel;
-		bp.resv = NULL;
-		bp.bo_ptr_size = sizeof(struct amdgpu_bo);
-
-		r = amdgpu_bo_create(adev, &bp, &adev->gart.bo);
-		if (r) {
-			return r;
-		}
-	}
-	return 0;
-}
-
-/**
- * amdgpu_gart_table_vram_pin - pin gart page table in vram
- *
- * @adev: amdgpu_device pointer
- *
- * Pin the GART page table in vram so it will not be moved
- * by the memory manager (pcie r4xx, r5xx+).  These asics require the
- * gart table to be in video memory.
- * Returns 0 for success, error for failure.
- */
-int amdgpu_gart_table_vram_pin(struct amdgpu_device *adev)
-{
-	int r;
-
-	r = amdgpu_bo_reserve(adev->gart.bo, false);
-	if (unlikely(r != 0))
-		return r;
-	r = amdgpu_bo_pin(adev->gart.bo, AMDGPU_GEM_DOMAIN_VRAM);
-	if (r) {
-		amdgpu_bo_unreserve(adev->gart.bo);
-		return r;
-	}
-	r = amdgpu_bo_kmap(adev->gart.bo, &adev->gart.ptr);
-	if (r)
-		amdgpu_bo_unpin(adev->gart.bo);
-	amdgpu_bo_unreserve(adev->gart.bo);
-	return r;
-}
-
-/**
- * amdgpu_gart_table_vram_unpin - unpin gart page table in vram
- *
- * @adev: amdgpu_device pointer
- *
- * Unpin the GART page table in vram (pcie r4xx, r5xx+).
- * These asics require the gart table to be in video memory.
- */
-void amdgpu_gart_table_vram_unpin(struct amdgpu_device *adev)
-{
-	int r;
+	if (adev->gart.bo != NULL)
+		return 0;
 
-	if (adev->gart.bo == NULL) {
-		return;
-	}
-	r = amdgpu_bo_reserve(adev->gart.bo, true);
-	if (likely(r == 0)) {
-		amdgpu_bo_kunmap(adev->gart.bo);
-		amdgpu_bo_unpin(adev->gart.bo);
-		amdgpu_bo_unreserve(adev->gart.bo);
-		adev->gart.ptr = NULL;
-	}
+	return amdgpu_bo_create_kernel(adev,  adev->gart.table_size, PAGE_SIZE,
+				       AMDGPU_GEM_DOMAIN_VRAM, &adev->gart.bo,
+				       NULL, (void *)&adev->gart.ptr);
 }
 
 /**
@@ -201,11 +133,7 @@ void amdgpu_gart_table_vram_unpin(struct amdgpu_device *adev)
  */
 void amdgpu_gart_table_vram_free(struct amdgpu_device *adev)
 {
-	if (adev->gart.bo == NULL) {
-		return;
-	}
-	amdgpu_bo_unref(&adev->gart.bo);
-	adev->gart.ptr = NULL;
+	amdgpu_bo_free_kernel(&adev->gart.bo, NULL, (void *)&adev->gart.ptr);
 }
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 3d5d47a799e3..38bb42727715 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -989,7 +989,7 @@ static int gmc_v10_0_gart_enable(struct amdgpu_device *adev)
 	if (amdgpu_sriov_vf(adev) && amdgpu_in_reset(adev))
 		goto skip_pin_bo;
 
-	r = amdgpu_gart_table_vram_pin(adev);
+	r = amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
 	if (r)
 		return r;
 
@@ -1060,7 +1060,6 @@ static void gmc_v10_0_gart_disable(struct amdgpu_device *adev)
 {
 	adev->gfxhub.funcs->gart_disable(adev);
 	adev->mmhub.funcs->gart_disable(adev);
-	amdgpu_gart_table_vram_unpin(adev);
 }
 
 static int gmc_v10_0_hw_fini(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index 0fe714f54cca..cd6c38e083d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -476,7 +476,7 @@ static int gmc_v6_0_gart_enable(struct amdgpu_device *adev)
 		dev_err(adev->dev, "No VRAM object for PCIE GART.\n");
 		return -EINVAL;
 	}
-	r = amdgpu_gart_table_vram_pin(adev);
+	r = amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
 	if (r)
 		return r;
 
@@ -608,7 +608,6 @@ static void gmc_v6_0_gart_disable(struct amdgpu_device *adev)
 	WREG32(mmVM_L2_CNTL3,
 	       VM_L2_CNTL3__L2_CACHE_BIGK_ASSOCIATIVITY_MASK |
 	       (0UL << VM_L2_CNTL3__L2_CACHE_BIGK_FRAGMENT_SIZE__SHIFT));
-	amdgpu_gart_table_vram_unpin(adev);
 }
 
 static void gmc_v6_0_vm_decode_fault(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index 0a50fdaced7e..ab8adbff9e2d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -620,7 +620,7 @@ static int gmc_v7_0_gart_enable(struct amdgpu_device *adev)
 		dev_err(adev->dev, "No VRAM object for PCIE GART.\n");
 		return -EINVAL;
 	}
-	r = amdgpu_gart_table_vram_pin(adev);
+	r = amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
 	if (r)
 		return r;
 
@@ -758,7 +758,6 @@ static void gmc_v7_0_gart_disable(struct amdgpu_device *adev)
 	tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, ENABLE_L2_CACHE, 0);
 	WREG32(mmVM_L2_CNTL, tmp);
 	WREG32(mmVM_L2_CNTL2, 0);
-	amdgpu_gart_table_vram_unpin(adev);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 63b890f1e8af..054733838292 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -844,7 +844,7 @@ static int gmc_v8_0_gart_enable(struct amdgpu_device *adev)
 		dev_err(adev->dev, "No VRAM object for PCIE GART.\n");
 		return -EINVAL;
 	}
-	r = amdgpu_gart_table_vram_pin(adev);
+	r = amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
 	if (r)
 		return r;
 
@@ -999,7 +999,6 @@ static void gmc_v8_0_gart_disable(struct amdgpu_device *adev)
 	tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, ENABLE_L2_CACHE, 0);
 	WREG32(mmVM_L2_CNTL, tmp);
 	WREG32(mmVM_L2_CNTL2, 0);
-	amdgpu_gart_table_vram_unpin(adev);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 57f2729a7bd0..12a177ac14f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1743,7 +1743,7 @@ static int gmc_v9_0_gart_enable(struct amdgpu_device *adev)
 	if (amdgpu_sriov_vf(adev) && amdgpu_in_reset(adev))
 		goto skip_pin_bo;
 
-	r = amdgpu_gart_table_vram_pin(adev);
+	r = amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
 	if (r)
 		return r;
 
@@ -1821,7 +1821,6 @@ static void gmc_v9_0_gart_disable(struct amdgpu_device *adev)
 {
 	adev->gfxhub.funcs->gart_disable(adev);
 	adev->mmhub.funcs->gart_disable(adev);
-	amdgpu_gart_table_vram_unpin(adev);
 }
 
 static int gmc_v9_0_hw_fini(void *handle)
-- 
2.33.1

