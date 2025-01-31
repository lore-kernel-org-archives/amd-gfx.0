Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 640A7C0218F
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2025 17:21:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BB1910E416;
	Fri, 31 Jan 2025 17:21:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ksuzWoYF";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 973CE10E409
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2025 17:21:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xC5jg1CFKsG1V1BWsCmFgnlG9spGxpV1ighIg0ds7aP3+spHqTAXKPqntYr1YBf2s9yFwcCMsOg2MxvS+MBAn3asD0u0Kc3nHPmVWOkVJo9U+v4Z6kmp1BuwTRlqmsJOGAlnp3YS1USB9qQiDVkfY5lLZeLA+7MchQcePIad6UXCp1qsC5F/d7UkbXqYbh54H/YT9dD7FAN/AJChWHZGgvqvIGIQhywR1tyVLTSfJPlpGCc4T4ig3Gnh+bZfhr7jULQNeO2jqdj+4cOJNoA8uFH+SpI5iuc6M3ZuyU46KvSXXJMoHUz8swTtgcJYPciitLZUCac5WrwTrzfhwZ+rNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pmPyOVxkbS6NCWf5VcJiwkkGvBTWWpRBx0JL/rRi/uk=;
 b=C8DUik0EcGMO7DfLqfvFCQopc1mOR1ynb1tOUNNeuxfa+Kk5bmyjuPn7MJWB4gXMJhsk7C96DVeCzdYuRXBT+/gXRD07xYUh6GgiUe/eUWt9J19/NTVFhRBXGTuZ8F1cO+XhrIvSox4Q3SITf+VsnqYs6htHpRvTV4DZnZHTYvdf0Nn5I1cRpcQ2JwWIpreJdmxfKSlKjGxh3srOI8masKXra5kmz9NHPJ2ThPfiqhBh+QTKlS0v1eojjAqL/g9w6TDUuvCcE3EG9FM8KiQvh7h+Ee5KNktZJfIAsC1AZqCEBy5FOigsdWBeH0q+35cZbZj86F+Z8qk3GZZKKT/LGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pmPyOVxkbS6NCWf5VcJiwkkGvBTWWpRBx0JL/rRi/uk=;
 b=ksuzWoYFzZtphYVYt4vX3HrUJfWpN55yr6MFMiuL2LjOB3GffBZGPnfAkqpVt0Wg0/vSBJux3WSS54Cxf+HR7kYE8q4AsjvgL+b1Fgb7djbiWlZxPqBan1qKAm+6KVzp6xbZDSAU3gkZVDQoUKJyiddvNKT0nUly7poS8oVEiBA=
Received: from MN2PR22CA0015.namprd22.prod.outlook.com (2603:10b6:208:238::20)
 by SJ0PR12MB6878.namprd12.prod.outlook.com (2603:10b6:a03:483::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.20; Fri, 31 Jan
 2025 17:21:28 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:208:238:cafe::81) by MN2PR22CA0015.outlook.office365.com
 (2603:10b6:208:238::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.18 via Frontend Transport; Fri,
 31 Jan 2025 17:21:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 31 Jan 2025 17:21:27 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 31 Jan
 2025 11:21:26 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amdkfd: add a new flag to manage where VRAM
 allocations go
Date: Fri, 31 Jan 2025 12:21:12 -0500
Message-ID: <20250131172113.1807775-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|SJ0PR12MB6878:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d138b6e-9b6f-448e-0e66-08dd421bb1eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mzLyr+t8xat1Ju83N19gLmFTECTdR750hQpKCoHDP3azWY1eNALRQUQ5FG6y?=
 =?us-ascii?Q?Gm8TDwQW9kTOm7P5RKFGPicO/xlOa6FODB+3DU23cKRq2uEIZnmfZFKv++Qt?=
 =?us-ascii?Q?qCtXlI3ikPT1F+i4f52tkVOr1ajQDnxudgwTjP4LuK5y7ZKJOx4EMLXd0ETK?=
 =?us-ascii?Q?m7115fgUpHpWlqs28CKETxEnwgH1+lK1XvGKlugmosBmuo1jik1vEXhMUkma?=
 =?us-ascii?Q?8hjPXjW0MHvvycAAirJNen9I3Hv7dBCHlUWQSkwe8CVTFKonmDHmvtnGg6T2?=
 =?us-ascii?Q?kARp3ulUUijr7arn4EC3kkEotVPTCzY2AmsCEeAePygzVU2g+/gJFvSuft3q?=
 =?us-ascii?Q?oYiyr/I11S/t4hMA2YVkb/YxfUgsDQZV5zN76ZjV4nzY+uTPtj+2TaUB9VOk?=
 =?us-ascii?Q?A3J6mASQ5XF/h9ZcKpbJI3npLWr3kOy7aDQ4bJGOHFzBJF1TrRzgEtX/Ool3?=
 =?us-ascii?Q?uhIuvKXCeaJW6KTnH85gObbUUHMtJqc6uV0BGTGLwoYdn0YIzyOOoVw3SNTf?=
 =?us-ascii?Q?sjIFrEvkOurYmtTDv0s1XlaVuvp8LfD/LW+Rf3gmzmz6GuiYJpxzjPibsLrE?=
 =?us-ascii?Q?651q5A0Q7MqrAk4tQ+X3phSGL4Xz0iRCjoMKmDOXYeP+l82YdR9sLBgW+5Ah?=
 =?us-ascii?Q?cJFl9R+y5paORoaZy1Ue+r2kn5fXmZ42ejUJiEredIE99M9rlB3VFAuHQP33?=
 =?us-ascii?Q?+cIIvdl7TWV/87QJLufQVv0rwTumt2QriYHPVc7zW/xFLEccCQnZ+UxOE1S4?=
 =?us-ascii?Q?6ouQx+17ejmN26KfAmsupBU6hosywVEwr2SeJMtf9rREM9q7cEzHbHeusL9N?=
 =?us-ascii?Q?IVqFMjdECp/Nev8FrJAGbb3Oeh5k9ZdmL3DFmIcqPawGTgHT33/lj6JSDJ6g?=
 =?us-ascii?Q?+wjoSwqEBzaYEFRNJid/iECR6kP6xaDS9sNtn+46G1+nUiPVgZ8fGKAqGzZj?=
 =?us-ascii?Q?U8/+WbfZtj+uspWSsTBUboTIqbDX9GevTCPlYWD+CqtQ8atGBuvyb5FZJEGB?=
 =?us-ascii?Q?CC9ShaUHrV1yzueU73yEAlOIVgsbpqiL1GwjMmL08x0gmQcoTlKZHFEhu8JN?=
 =?us-ascii?Q?qqLeYlGFD2V5VcNNYgFgXu7jAUP0m8PolQdYudz7PfxdzFYN4FavVCdAt5/9?=
 =?us-ascii?Q?J3Turc2QdAg6H7yeM5go5v8eYdL0BH/l4wBMjv+Dj7H7va3kYT6iK7fPmdpB?=
 =?us-ascii?Q?/ZfD6I4ddcLOt4UsHj/PewA8JNd8HzYMVQTdBMejjq72IfIXCAkSBwawxsgq?=
 =?us-ascii?Q?e5O+q+rGa0QaidisB5PVYi8ICaS3IMFtY73L2iR6XLMiaRi9S1RbpdCHlpQi?=
 =?us-ascii?Q?r7bsPH/F8L6xUJ4KtwXEaIfUaDF4oqUORYdy6J2d3hmKgQ5ZSRmc9+W5fbbA?=
 =?us-ascii?Q?YmLtp7PNQDiVeQ6VgakHXN56c3/k8TGBw0Ly5xnty44XPhcPpX92wsmJZaq0?=
 =?us-ascii?Q?gmiMLk34pMU1T7YxwU0ci0ytmbLkET/6PLWqexQoJdIHFK4wJB61OgOHiVb8?=
 =?us-ascii?Q?fXA8uT4GWfDWQRo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 17:21:27.2219 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d138b6e-9b6f-448e-0e66-08dd421bb1eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6878
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

On big and small APUs we send KFD VRAM allocations to GTT
since the carve out is either non-existent or relatively
small.  However, if someone sets the carve out size to be
relatively large, we may end up using GTT rather than VRAM.

No change of logic with this patch, but it allows the
driver to determine which logic to use based on the
carve out size in the future.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h              |  5 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c       |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 16 ++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c          |  3 +++
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c         |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c             |  4 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h             |  2 +-
 7 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 5e55a44f9eef6..dea0246a23c65 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1209,6 +1209,11 @@ struct amdgpu_device {
 	struct mutex                    enforce_isolation_mutex;
 
 	struct amdgpu_init_level *init_lvl;
+
+	/* This flag is used to determine how VRAM allocations are handles for APUs
+	 * in KFD; VRAM or GTT.
+	 */
+	bool                            apu_prefer_gtt;
 };
 
 static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 2c1b38c5cfc62..0312231b703e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -459,7 +459,7 @@ void amdgpu_amdkfd_get_local_mem_info(struct amdgpu_device *adev,
 		else
 			mem_info->local_mem_size_private =
 					KFD_XCP_MEMORY_SIZE(adev, xcp->id);
-	} else if (adev->flags & AMD_IS_APU) {
+	} else if (adev->apu_prefer_gtt) {
 		mem_info->local_mem_size_public = (ttm_tt_pages_limit() << PAGE_SHIFT);
 		mem_info->local_mem_size_private = 0;
 	} else {
@@ -818,7 +818,7 @@ u64 amdgpu_amdkfd_xcp_memory_size(struct amdgpu_device *adev, int xcp_id)
 		}
 		do_div(tmp, adev->xcp_mgr->num_xcp_per_mem_partition);
 		return ALIGN_DOWN(tmp, PAGE_SIZE);
-	} else if (adev->flags & AMD_IS_APU) {
+	} else if (adev->apu_prefer_gtt) {
 		return (ttm_tt_pages_limit() << PAGE_SHIFT);
 	} else {
 		return adev->gmc.real_vram_size;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 2b4d3840e5bca..60062c10b083f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -197,7 +197,7 @@ int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 			return -EINVAL;
 
 		vram_size = KFD_XCP_MEMORY_SIZE(adev, xcp_id);
-		if (adev->flags & AMD_IS_APU) {
+		if (adev->apu_prefer_gtt) {
 			system_mem_needed = size;
 			ttm_mem_needed = size;
 		}
@@ -234,7 +234,7 @@ int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 	if (adev && xcp_id >= 0) {
 		adev->kfd.vram_used[xcp_id] += vram_needed;
 		adev->kfd.vram_used_aligned[xcp_id] +=
-				(adev->flags & AMD_IS_APU) ?
+				adev->apu_prefer_gtt ?
 				vram_needed :
 				ALIGN(vram_needed, VRAM_AVAILABLITY_ALIGN);
 	}
@@ -262,7 +262,7 @@ void amdgpu_amdkfd_unreserve_mem_limit(struct amdgpu_device *adev,
 
 		if (adev) {
 			adev->kfd.vram_used[xcp_id] -= size;
-			if (adev->flags & AMD_IS_APU) {
+			if (adev->apu_prefer_gtt) {
 				adev->kfd.vram_used_aligned[xcp_id] -= size;
 				kfd_mem_limit.system_mem_used -= size;
 				kfd_mem_limit.ttm_mem_used -= size;
@@ -890,7 +890,7 @@ static int kfd_mem_attach(struct amdgpu_device *adev, struct kgd_mem *mem,
 	 * if peer device has large BAR. In contrast, access over xGMI is
 	 * allowed for both small and large BAR configurations of peer device
 	 */
-	if ((adev != bo_adev && !(adev->flags & AMD_IS_APU)) &&
+	if ((adev != bo_adev && !adev->apu_prefer_gtt) &&
 	    ((mem->domain == AMDGPU_GEM_DOMAIN_VRAM) ||
 	     (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL) ||
 	     (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP))) {
@@ -1667,7 +1667,7 @@ size_t amdgpu_amdkfd_get_available_memory(struct amdgpu_device *adev,
 		- reserved_for_pt
 		- reserved_for_ras;
 
-	if (adev->flags & AMD_IS_APU) {
+	if (adev->apu_prefer_gtt) {
 		system_mem_available = no_system_mem_limit ?
 					kfd_mem_limit.max_system_mem_limit :
 					kfd_mem_limit.max_system_mem_limit -
@@ -1715,7 +1715,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 	if (flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
 		domain = alloc_domain = AMDGPU_GEM_DOMAIN_VRAM;
 
-		if (adev->flags & AMD_IS_APU) {
+		if (adev->apu_prefer_gtt) {
 			domain = AMDGPU_GEM_DOMAIN_GTT;
 			alloc_domain = AMDGPU_GEM_DOMAIN_GTT;
 			alloc_flags = 0;
@@ -1966,7 +1966,7 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
 	if (size) {
 		if (!is_imported &&
 		   (mem->bo->preferred_domains == AMDGPU_GEM_DOMAIN_VRAM ||
-		   ((adev->flags & AMD_IS_APU) &&
+		   (adev->apu_prefer_gtt &&
 		    mem->bo->preferred_domains == AMDGPU_GEM_DOMAIN_GTT)))
 			*size = bo_size;
 		else
@@ -2393,7 +2393,7 @@ static int import_obj_create(struct amdgpu_device *adev,
 	(*mem)->bo = bo;
 	(*mem)->va = va;
 	(*mem)->domain = (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM) &&
-			 !(adev->flags & AMD_IS_APU) ?
+			 !adev->apu_prefer_gtt ?
 			 AMDGPU_GEM_DOMAIN_VRAM : AMDGPU_GEM_DOMAIN_GTT;
 
 	(*mem)->mapped_to_gpu_memory = 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 8ac8417d51cea..32b42f1104623 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1989,6 +1989,9 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 	DRM_INFO("amdgpu: %uM of GTT memory ready.\n",
 		 (unsigned int)(gtt_size / (1024 * 1024)));
 
+	if (adev->flags & AMD_IS_APU)
+		adev->apu_prefer_gtt = true;
+
 	/* Initialize doorbell pool on PCI BAR */
 	r = amdgpu_ttm_init_on_chip(adev, AMDGPU_PL_DOORBELL, adev->doorbell.size / PAGE_SIZE);
 	if (r) {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index d05d199b5e448..79251f22b7022 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -1027,7 +1027,7 @@ int kgd2kfd_init_zone_device(struct amdgpu_device *adev)
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(9, 0, 1))
 		return -EINVAL;
 
-	if (adev->flags & AMD_IS_APU)
+	if (adev->apu_prefer_gtt)
 		return 0;
 
 	pgmap = &kfddev->pgmap;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index e32e19196f6b2..db3034b00dac2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2692,7 +2692,7 @@ svm_range_best_restore_location(struct svm_range *prange,
 		return -1;
 	}
 
-	if (node->adev->flags & AMD_IS_APU)
+	if (node->adev->apu_prefer_gtt)
 		return 0;
 
 	if (prange->preferred_loc == gpuid ||
@@ -3441,7 +3441,7 @@ svm_range_best_prefetch_location(struct svm_range *prange)
 		goto out;
 	}
 
-	if (bo_node->adev->flags & AMD_IS_APU) {
+	if (bo_node->adev->apu_prefer_gtt) {
 		best_loc = 0;
 		goto out;
 	}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index bddd24f04669e..6ea23c78009ce 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -202,7 +202,7 @@ void svm_range_list_lock_and_flush_work(struct svm_range_list *svms, struct mm_s
  * is initialized to not 0 when page migration register device memory.
  */
 #define KFD_IS_SVM_API_SUPPORTED(adev) ((adev)->kfd.pgmap.type != 0 ||\
-					((adev)->flags & AMD_IS_APU))
+					((adev)->apu_prefer_gtt))
 
 void svm_range_bo_unref_async(struct svm_range_bo *svm_bo);
 
-- 
2.48.1

