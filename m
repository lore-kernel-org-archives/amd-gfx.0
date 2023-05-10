Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C345BC7EE22
	for <amd-gfx@archiver.kernel.org>; Wed, 10 May 2023 21:24:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27E2910E544;
	Wed, 10 May 2023 21:24:18 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::613])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2CD410E540
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 May 2023 21:24:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FgLAn/Vhzgx9iPRvbe8tS6Vag4qshk+f+IYurzr/ek5xjpTQAw92DnnjMVZNkBAfqAqYD3bn3OSgd9AUtEz/+ZhNjl3vzKXPI/dhrnG/h8iJaFBesY/XRKkvfIcgZhDjoNMwm2p8XSjf7Fr7nSHDITdEHcWTYmeldFCUlG90dPJ60ekRnKERSki2hXAal55XQuJzzk3vHONA80wgCzeHWFUke1MGeOZKsTdBZ8RAs/UrkMpaCnp8tzTOadHh/4WfajwQX4kDVlv5fKCvCWpOMdBGVXy00ZbikD0fD7qnKkxfxTRfMWHxh2K83lNe5KO3aaCus1vVW6PQw6JmVLIukg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6boMhegEdYDRrQJjgClrHMmcx0QifUPHrmTQ4FZgMeU=;
 b=PgJpDWJELATX+PdnqyuT27BSYrC/x8NKTHkDEREvmloUc0wUKwgudvP8xotwMGktcthqDKqncIMktG5PJJNEZK+mgnyOndUs/laiCcET64ebyeTJtTL5zgfszY/Lx3lcQmd+47NH6KK9ot8KSBfeu93ENCS9RAiNbzRCSxvLd+u6qE/Z+nI760ENgDsSz3WAqGMcoEpYuEHkIx9WQTuRdwrunlMgU2vsF0pu9y8K42KTtPhHWsSvTGQf6DvxdSiZywZdXDb4Vvgc8RJJYLdNtRjpHeakMSs2np49QxfpcRcGszofdV7N3+6i+r6mZlkIbTx6x7Le36A8SiOMhCAgVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6boMhegEdYDRrQJjgClrHMmcx0QifUPHrmTQ4FZgMeU=;
 b=dpfQ0ynsJzsHUyn3Y3dNqOr6dyp3uY2+79viOXd2Y7fUmNwEIxwe2H7L1PenBUDZ7zevKMlcNy+/80wHaTdbu2KC/xVxIzzYpxvgthiVCinLYvl4A9G7aGeT6CauhSN18jDTQEGHiHlFik7fCgKZrwCDs3YmRbeo0AIopcOazrg=
Received: from MW4PR04CA0346.namprd04.prod.outlook.com (2603:10b6:303:8a::21)
 by IA0PR12MB8748.namprd12.prod.outlook.com (2603:10b6:208:482::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Wed, 10 May
 2023 21:24:03 +0000
Received: from CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::c5) by MW4PR04CA0346.outlook.office365.com
 (2603:10b6:303:8a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20 via Frontend
 Transport; Wed, 10 May 2023 21:24:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT033.mail.protection.outlook.com (10.13.174.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.21 via Frontend Transport; Wed, 10 May 2023 21:24:02 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 10 May
 2023 16:24:01 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 25/29] drm/amdkfd: Fix memory reporting on GFX 9.4.3
Date: Wed, 10 May 2023 17:23:29 -0400
Message-ID: <20230510212333.2071373-25-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230510212333.2071373-1-alexander.deucher@amd.com>
References: <20230510212333.2071373-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT033:EE_|IA0PR12MB8748:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e210d8a-5868-40f1-c69f-08db519ce0cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HqCuhrj834asz/KNOg/Bw71bAZ0G7C7l6U5GaANX+mxDUNh/YT5f44YaLtzAyoilaNAoba0lQRLN72EGxNHlCmJCk6AVo8Nb49DuE00eo9c80LTnls+pHUWBIY59tsRS6QdzOnubROvDBG/n0DVrVdEH+mrBBP/Hhyl3Gq70lFVPUaU7E97AHQx5Xhk6CzyjnM5AmvLxCQtxS76elMEbG8wBT+Ra92vmJWYv1lU4iQvcnuH/H7Xk4whDhFhk0e3nX5GA7aHNsO8KEkuvMKtnxVycjgagnzrPsKk/C/lnlZtOywQxaSEbFVEEXV5LkKISwwWOYRa1XwfPWCgLCfQ79i33aKPAvgXyRtAMESjSTGGWTebxzZW71Ry6P//l+CUTLaJqUnQjM+0EbY4fDcnuvVtYasAfgIrR7NVJksQTSlnSwuzhOF/zVi36lyzV+1hwDpO9L47OIvAWcj/y+FeYom03poAw08MxeOHLCn1lkxnUBzGkR44V8ZgfkQvJKHaN29L9T2FQaCl/FG2kIOpTgRQhF1BnFrj8fNxHE3kzn9B+2hgGBDPR8W//Gv+/UarisnAS2GG3RZHGMcovGikx03lKkJv7M8yCI6Iy4KrZW6ylngwPERvP893sBCeYBApn/DWF/uC5g30huDk1fa/atb+X1wzZlmKseSGGZL8og/Xgtj5/mkS2vR+cgeVcyxPe7VM2p+fnNQlwiFM5JRadPAl6OoI6B4WK5qUJTPCAfbRJgwqLz9o5hOMSVRa4HPxSUgXcMQtl1h+KdoYherLm3A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199021)(36840700001)(40470700004)(46966006)(54906003)(6916009)(4326008)(41300700001)(5660300002)(40480700001)(82740400003)(316002)(70586007)(70206006)(81166007)(2616005)(356005)(2906002)(36756003)(30864003)(47076005)(83380400001)(426003)(478600001)(36860700001)(8936002)(86362001)(82310400005)(6666004)(1076003)(8676002)(26005)(16526019)(40460700003)(186003)(7696005)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 21:24:02.9446 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e210d8a-5868-40f1-c69f-08db519ce0cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8748
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mukul Joshi <mukul.joshi@amd.com>

This patch fixes memory reporting on the GFX 9.4.3 APU and dGPU
by reporting available memory on a per partition basis. If its an
APU, available and used memory calculations take into account
system and TTM memory.

v2: squash in fix ("drm/amdkfd: Fix array out of bound warning")
    squash in fix ("drm/amdgpu: Update memory reporting for GFX9.4.3")

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    | 12 +--
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 81 ++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h       |  5 ++
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c          | 14 ++--
 5 files changed, 84 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 4bf6f5659568..948d362adabb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -35,6 +35,7 @@
 #include <drm/ttm/ttm_execbuf_util.h>
 #include "amdgpu_sync.h"
 #include "amdgpu_vm.h"
+#include "amdgpu_xcp.h"
 
 extern uint64_t amdgpu_amdkfd_total_mem_size;
 
@@ -98,8 +99,8 @@ struct amdgpu_amdkfd_fence {
 
 struct amdgpu_kfd_dev {
 	struct kfd_dev *dev;
-	int64_t vram_used;
-	uint64_t vram_used_aligned;
+	int64_t vram_used[MAX_XCP];
+	uint64_t vram_used_aligned[MAX_XCP];
 	bool init_complete;
 	struct work_struct reset_work;
 
@@ -287,7 +288,8 @@ int amdgpu_amdkfd_gpuvm_acquire_process_vm(struct amdgpu_device *adev,
 void amdgpu_amdkfd_gpuvm_release_process_vm(struct amdgpu_device *adev,
 					void *drm_priv);
 uint64_t amdgpu_amdkfd_gpuvm_get_process_page_dir(void *drm_priv);
-size_t amdgpu_amdkfd_get_available_memory(struct amdgpu_device *adev);
+size_t amdgpu_amdkfd_get_available_memory(struct amdgpu_device *adev,
+					uint8_t xcp_id);
 int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 		struct amdgpu_device *adev, uint64_t va, uint64_t size,
 		void *drm_priv, struct kgd_mem **mem,
@@ -327,9 +329,9 @@ void amdgpu_amdkfd_block_mmu_notifications(void *p);
 int amdgpu_amdkfd_criu_resume(void *p);
 bool amdgpu_amdkfd_ras_query_utcl2_poison_status(struct amdgpu_device *adev);
 int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
-		uint64_t size, u32 alloc_flag);
+		uint64_t size, u32 alloc_flag, int8_t xcp_id);
 void amdgpu_amdkfd_unreserve_mem_limit(struct amdgpu_device *adev,
-		uint64_t size, u32 alloc_flag);
+		uint64_t size, u32 alloc_flag, int8_t xcp_id);
 
 #define KFD_XCP_MEM_ID(adev, xcp_id) \
 		((adev)->xcp_mgr && (xcp_id) >= 0 ?\
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index cf8f80e4ef56..fa4057da0d7f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -156,12 +156,13 @@ void amdgpu_amdkfd_reserve_system_mem(uint64_t size)
  * Return: returns -ENOMEM in case of error, ZERO otherwise
  */
 int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
-		uint64_t size, u32 alloc_flag)
+		uint64_t size, u32 alloc_flag, int8_t xcp_id)
 {
 	uint64_t reserved_for_pt =
 		ESTIMATE_PT_SIZE(amdgpu_amdkfd_total_mem_size);
 	size_t system_mem_needed, ttm_mem_needed, vram_needed;
 	int ret = 0;
+	uint64_t vram_size = 0;
 
 	system_mem_needed = 0;
 	ttm_mem_needed = 0;
@@ -176,6 +177,17 @@ int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 		 * 2M BO chunk.
 		 */
 		vram_needed = size;
+		/*
+		 * For GFX 9.4.3, get the VRAM size from XCP structs
+		 */
+		if (WARN_ONCE(xcp_id < 0, "invalid XCP ID %d", xcp_id))
+			return -EINVAL;
+
+		vram_size = KFD_XCP_MEMORY_SIZE(adev, xcp_id);
+		if (adev->gmc.is_app_apu) {
+			system_mem_needed = size;
+			ttm_mem_needed = size;
+		}
 	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
 		system_mem_needed = size;
 	} else if (!(alloc_flag &
@@ -195,8 +207,8 @@ int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 	     kfd_mem_limit.max_system_mem_limit && !no_system_mem_limit) ||
 	    (kfd_mem_limit.ttm_mem_used + ttm_mem_needed >
 	     kfd_mem_limit.max_ttm_mem_limit) ||
-	    (adev && adev->kfd.vram_used + vram_needed >
-	     adev->gmc.real_vram_size - reserved_for_pt)) {
+	    (adev && xcp_id >= 0 && adev->kfd.vram_used[xcp_id] + vram_needed >
+	     vram_size - reserved_for_pt)) {
 		ret = -ENOMEM;
 		goto release;
 	}
@@ -206,9 +218,11 @@ int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 	 */
 	WARN_ONCE(vram_needed && !adev,
 		  "adev reference can't be null when vram is used");
-	if (adev) {
-		adev->kfd.vram_used += vram_needed;
-		adev->kfd.vram_used_aligned += ALIGN(vram_needed, VRAM_AVAILABLITY_ALIGN);
+	if (adev && xcp_id >= 0) {
+		adev->kfd.vram_used[xcp_id] += vram_needed;
+		adev->kfd.vram_used_aligned[xcp_id] += adev->gmc.is_app_apu ?
+				vram_needed :
+				ALIGN(vram_needed, VRAM_AVAILABLITY_ALIGN);
 	}
 	kfd_mem_limit.system_mem_used += system_mem_needed;
 	kfd_mem_limit.ttm_mem_used += ttm_mem_needed;
@@ -219,7 +233,7 @@ int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 }
 
 void amdgpu_amdkfd_unreserve_mem_limit(struct amdgpu_device *adev,
-		uint64_t size, u32 alloc_flag)
+		uint64_t size, u32 alloc_flag, int8_t xcp_id)
 {
 	spin_lock(&kfd_mem_limit.mem_limit_lock);
 
@@ -229,9 +243,19 @@ void amdgpu_amdkfd_unreserve_mem_limit(struct amdgpu_device *adev,
 	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
 		WARN_ONCE(!adev,
 			  "adev reference can't be null when alloc mem flags vram is set");
+		if (WARN_ONCE(xcp_id < 0, "invalid XCP ID %d", xcp_id))
+			goto release;
+
 		if (adev) {
-			adev->kfd.vram_used -= size;
-			adev->kfd.vram_used_aligned -= ALIGN(size, VRAM_AVAILABLITY_ALIGN);
+			adev->kfd.vram_used[xcp_id] -= size;
+			if (adev->gmc.is_app_apu) {
+				adev->kfd.vram_used_aligned[xcp_id] -= size;
+				kfd_mem_limit.system_mem_used -= size;
+				kfd_mem_limit.ttm_mem_used -= size;
+			} else {
+				adev->kfd.vram_used_aligned[xcp_id] -=
+					ALIGN(size, VRAM_AVAILABLITY_ALIGN);
+			}
 		}
 	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
 		kfd_mem_limit.system_mem_used -= size;
@@ -241,8 +265,8 @@ void amdgpu_amdkfd_unreserve_mem_limit(struct amdgpu_device *adev,
 		pr_err("%s: Invalid BO type %#x\n", __func__, alloc_flag);
 		goto release;
 	}
-	WARN_ONCE(adev && adev->kfd.vram_used < 0,
-		  "KFD VRAM memory accounting unbalanced");
+	WARN_ONCE(adev && xcp_id >= 0 && adev->kfd.vram_used[xcp_id] < 0,
+		  "KFD VRAM memory accounting unbalanced for xcp: %d", xcp_id);
 	WARN_ONCE(kfd_mem_limit.ttm_mem_used < 0,
 		  "KFD TTM memory accounting unbalanced");
 	WARN_ONCE(kfd_mem_limit.system_mem_used < 0,
@@ -258,7 +282,8 @@ void amdgpu_amdkfd_release_notify(struct amdgpu_bo *bo)
 	u32 alloc_flags = bo->kfd_bo->alloc_flags;
 	u64 size = amdgpu_bo_size(bo);
 
-	amdgpu_amdkfd_unreserve_mem_limit(adev, size, alloc_flags);
+	amdgpu_amdkfd_unreserve_mem_limit(adev, size, alloc_flags,
+					  bo->xcp_id);
 
 	kfree(bo->kfd_bo);
 }
@@ -1608,23 +1633,42 @@ int amdgpu_amdkfd_criu_resume(void *p)
 	return ret;
 }
 
-size_t amdgpu_amdkfd_get_available_memory(struct amdgpu_device *adev)
+size_t amdgpu_amdkfd_get_available_memory(struct amdgpu_device *adev,
+					  uint8_t xcp_id)
 {
 	uint64_t reserved_for_pt =
 		ESTIMATE_PT_SIZE(amdgpu_amdkfd_total_mem_size);
 	ssize_t available;
+	uint64_t vram_available, system_mem_available, ttm_mem_available;
 
 	spin_lock(&kfd_mem_limit.mem_limit_lock);
-	available = adev->gmc.real_vram_size
-		- adev->kfd.vram_used_aligned
+	vram_available = KFD_XCP_MEMORY_SIZE(adev, xcp_id)
+		- adev->kfd.vram_used_aligned[xcp_id]
 		- atomic64_read(&adev->vram_pin_size)
 		- reserved_for_pt;
+
+	if (adev->gmc.is_app_apu) {
+		system_mem_available = no_system_mem_limit ?
+					kfd_mem_limit.max_system_mem_limit :
+					kfd_mem_limit.max_system_mem_limit -
+					kfd_mem_limit.system_mem_used;
+
+		ttm_mem_available = kfd_mem_limit.max_ttm_mem_limit -
+				kfd_mem_limit.ttm_mem_used;
+
+		available = min3(system_mem_available, ttm_mem_available,
+				 vram_available);
+		available = ALIGN_DOWN(available, PAGE_SIZE);
+	} else {
+		available = ALIGN_DOWN(vram_available, VRAM_AVAILABLITY_ALIGN);
+	}
+
 	spin_unlock(&kfd_mem_limit.mem_limit_lock);
 
 	if (available < 0)
 		available = 0;
 
-	return ALIGN_DOWN(available, VRAM_AVAILABLITY_ALIGN);
+	return available;
 }
 
 int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
@@ -1712,7 +1756,8 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 
 	amdgpu_sync_create(&(*mem)->sync);
 
-	ret = amdgpu_amdkfd_reserve_mem_limit(adev, aligned_size, flags);
+	ret = amdgpu_amdkfd_reserve_mem_limit(adev, aligned_size, flags,
+					      xcp_id);
 	if (ret) {
 		pr_debug("Insufficient memory\n");
 		goto err_reserve_limit;
@@ -1780,7 +1825,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 	/* Don't unreserve system mem limit twice */
 	goto err_reserve_limit;
 err_bo_create:
-	amdgpu_amdkfd_unreserve_mem_limit(adev, aligned_size, flags);
+	amdgpu_amdkfd_unreserve_mem_limit(adev, aligned_size, flags, xcp_id);
 err_reserve_limit:
 	mutex_destroy(&(*mem)->lock);
 	if (gobj)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
index 68b63b970ce8..9c5912b9d8bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
@@ -24,8 +24,11 @@
 #ifndef AMDGPU_XCP_H
 #define AMDGPU_XCP_H
 
+#include <linux/pci.h>
 #include <linux/xarray.h>
 
+#include "amdgpu_ctx.h"
+
 #define MAX_XCP 8
 
 #define AMDGPU_XCP_MODE_NONE -1
@@ -34,6 +37,8 @@
 #define AMDGPU_XCP_FL_NONE 0
 #define AMDGPU_XCP_FL_LOCKED (1 << 0)
 
+struct amdgpu_fpriv;
+
 enum AMDGPU_XCP_IP_BLOCK {
 	AMDGPU_XCP_GFXHUB,
 	AMDGPU_XCP_GFX,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 089e1d498670..88fe1f31739d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1044,7 +1044,8 @@ static int kfd_ioctl_get_available_memory(struct file *filep,
 
 	if (!pdd)
 		return -EINVAL;
-	args->available = amdgpu_amdkfd_get_available_memory(pdd->dev->adev);
+	args->available = amdgpu_amdkfd_get_available_memory(pdd->dev->adev,
+							pdd->dev->node_id);
 	kfd_unlock_pdd(pdd);
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 872daaef0258..2dbbdad3f392 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -279,7 +279,7 @@ static void svm_range_free(struct svm_range *prange, bool update_mem_usage)
 	if (update_mem_usage && !p->xnack_enabled) {
 		pr_debug("unreserve prange 0x%p size: 0x%llx\n", prange, size);
 		amdgpu_amdkfd_unreserve_mem_limit(NULL, size,
-					KFD_IOC_ALLOC_MEM_FLAGS_USERPTR);
+					KFD_IOC_ALLOC_MEM_FLAGS_USERPTR, 0);
 	}
 	mutex_destroy(&prange->lock);
 	mutex_destroy(&prange->migrate_mutex);
@@ -312,7 +312,7 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
 	p = container_of(svms, struct kfd_process, svms);
 	if (!p->xnack_enabled && update_mem_usage &&
 	    amdgpu_amdkfd_reserve_mem_limit(NULL, size << PAGE_SHIFT,
-					    KFD_IOC_ALLOC_MEM_FLAGS_USERPTR)) {
+				    KFD_IOC_ALLOC_MEM_FLAGS_USERPTR, 0)) {
 		pr_info("SVM mapping failed, exceeds resident system memory limit\n");
 		kfree(prange);
 		return NULL;
@@ -3036,10 +3036,10 @@ svm_range_switch_xnack_reserve_mem(struct kfd_process *p, bool xnack_enabled)
 			size = (pchild->last - pchild->start + 1) << PAGE_SHIFT;
 			if (xnack_enabled) {
 				amdgpu_amdkfd_unreserve_mem_limit(NULL, size,
-						KFD_IOC_ALLOC_MEM_FLAGS_USERPTR);
+					KFD_IOC_ALLOC_MEM_FLAGS_USERPTR, 0);
 			} else {
 				r = amdgpu_amdkfd_reserve_mem_limit(NULL, size,
-						KFD_IOC_ALLOC_MEM_FLAGS_USERPTR);
+					KFD_IOC_ALLOC_MEM_FLAGS_USERPTR, 0);
 				if (r)
 					goto out_unlock;
 				reserved_size += size;
@@ -3049,10 +3049,10 @@ svm_range_switch_xnack_reserve_mem(struct kfd_process *p, bool xnack_enabled)
 		size = (prange->last - prange->start + 1) << PAGE_SHIFT;
 		if (xnack_enabled) {
 			amdgpu_amdkfd_unreserve_mem_limit(NULL, size,
-						KFD_IOC_ALLOC_MEM_FLAGS_USERPTR);
+					KFD_IOC_ALLOC_MEM_FLAGS_USERPTR, 0);
 		} else {
 			r = amdgpu_amdkfd_reserve_mem_limit(NULL, size,
-						KFD_IOC_ALLOC_MEM_FLAGS_USERPTR);
+					KFD_IOC_ALLOC_MEM_FLAGS_USERPTR, 0);
 			if (r)
 				goto out_unlock;
 			reserved_size += size;
@@ -3065,7 +3065,7 @@ svm_range_switch_xnack_reserve_mem(struct kfd_process *p, bool xnack_enabled)
 
 	if (r)
 		amdgpu_amdkfd_unreserve_mem_limit(NULL, reserved_size,
-						KFD_IOC_ALLOC_MEM_FLAGS_USERPTR);
+					KFD_IOC_ALLOC_MEM_FLAGS_USERPTR, 0);
 	else
 		/* Change xnack mode must be inside svms lock, to avoid race with
 		 * svm_range_deferred_list_work unreserve memory in parallel.
-- 
2.40.1

