Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35E79C43334
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jun 2022 04:04:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9364A11A5F7;
	Fri, 10 Jun 2022 04:04:27 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E12CB11A5F7
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jun 2022 04:04:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WvYYmPPPJouEUwNBWbWtRODM6usoh3PZgCYof6dx3pWAU/TJ+m5G/3p6fTgNjCs1C0sIaFTmOqJKUU8P3wHFsCa3hA24rYK/h6HIK7vnE+n820QEOXQNNu7f1EFOmo3YzFtJyTmRV3SgMiljV63yTxgB944eS+VWYkKSe8tLVCVbaEp/NVUF+qjH7MRu4eR2rtOtaZw5wdzDepsBe8SfMfUUUAQC5CVIj7MWv8NsLAavTeXddSInfHMRmejqI3S6UzEgLOud/quR4gDZvjp3Tr8LmJV/MPEQy4jBwMArK7aApgc+PGb1CLvS10f/jbgAW8ccHC2CThTjJhJu+2XaJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aFdBYtdIFfhiakmY98S/905rrpD/849Jb2crpdgyiXM=;
 b=YZmEV+S2ccypvois7G7aWcrmfDUDkVqcvfSD/QQJe2jdPiRQMME/phukSN5jDaEkITFW8sxewuw5KE1X2a8RH2W3KTvHSfewRoVl098W68CLo0B0pN5r75bZjBQgLu+uDPw5SpEbrlN8TEw4exXEciSjZRHMvc6WoiYg4anyCM5qohB5boUCGFMyUn9H1ONJHvxvV4NqzssTl0RzWzR7UCEMUdr+MMCgG8bUwciM9N80mGw4HwR9HqNr9HmFpRpU9fKDHSmJHmg9tdHxxPE6JnctXJDyzmUnN3zfqKH1FmUW0q4TgupkDy5FCknOVW8TQssMw9YUaSPKftGPtdR74g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aFdBYtdIFfhiakmY98S/905rrpD/849Jb2crpdgyiXM=;
 b=3flU4Tx8fzEEJqCIRqGNrgH1zsHpC76g4RwmfJHrNXjzba5L21ZIyriZWb3mBZH6p+PiITPbvmTETVjQyUbkM/9feiYKhNpVwKqkXC0ZaHi6M+ntOx26zVlVVyJdYmNAeA+blwi1pNrLCbiuBEAnPN5Ig+4kXmzjEbjygC+uF94=
Received: from BN8PR07CA0027.namprd07.prod.outlook.com (2603:10b6:408:ac::40)
 by CY4PR1201MB0055.namprd12.prod.outlook.com (2603:10b6:910:1b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.15; Fri, 10 Jun
 2022 04:04:22 +0000
Received: from BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ac:cafe::61) by BN8PR07CA0027.outlook.office365.com
 (2603:10b6:408:ac::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.18 via Frontend
 Transport; Fri, 10 Jun 2022 04:04:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT020.mail.protection.outlook.com (10.13.176.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Fri, 10 Jun 2022 04:04:22 +0000
Received: from RErrabolDevMach.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 9 Jun
 2022 23:04:21 -0500
From: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fix error handling in
 amdgpu_amdkfd_gpuvm_free_memory_of_gpu
Date: Thu, 9 Jun 2022 23:04:11 -0500
Message-ID: <20220610040411.1586427-1-Ramesh.Errabolu@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 392f06a4-f143-4cbb-0928-08da4a964cd9
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0055:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB00554126449D03AE48112892E3A69@CY4PR1201MB0055.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: obfQ/pPpc35TyJmja3Ba+7tfpEZjk6LmzCQC67YtxHa3+obnXkCSAqrEyPwC4xMRAXkFbdH9dp1i5ItfP7RMz0DasTn0vMamf6OGSXKVU1l9RbYm52ITPInR0xCdgMGcN8yGX1mhRZwXOdj1opLtr8WgszpC6ye5yQ8GOgNpMFcza5YHKJvG/wUR7KaICmwWdCx/JLIe7VraguOJUZ/011xXz8upOu5iukHSehUhueqGwCCdtZ7q7AZzDjWGQFDB2O26enEy9x7QC8oi+UPYjb60nbJnGSNk68Qg3mogCopjz0ZqxdbD1+i6NDjLLOAtBCXmVV0wT+yPNmysny2k+o5OJOiYWKN2VTI8u5/5Fk1TOXpaByskAjfWme+JCcxBlOm0LvWgeI22VnmqQB4nKPfILA/dM+t2RSv9H9Cl1YCjk1lSRPl9tFOITaMK+N8Rw+2Y+yIwLBV9sbYLHv5ArXzbl8FSUsBi/F78PUHVJdQaiLgtxx43sz/blTqM3qm3cjfwkyqt82uvEAGUhrvn8hRfBCXSG+ovYx31rPv0Qye3P6xooS7h6HwatdtGDuVkV+hUmiiPhG2h46Bid9bgCZi0e0gePK1FhwnIZExWeLsuNzfHi+Hn8quN1HLJf+8Ge7cWrcLkpNacswJUgOjEr05ligx4saRGFhglYLr17qQl/+B5mKjHn85WfZZEDzyxSgNjBqNd20MOh2pZOtFGnw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(82310400005)(316002)(6666004)(6916009)(81166007)(70206006)(356005)(36756003)(70586007)(2616005)(336012)(26005)(8936002)(5660300002)(86362001)(8676002)(7696005)(4326008)(1076003)(36860700001)(16526019)(186003)(508600001)(47076005)(83380400001)(2906002)(40460700003)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 04:04:22.0563 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 392f06a4-f143-4cbb-0928-08da4a964cd9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0055
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
Cc: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Following error conditions are fixed:
  Unpin MMIO and DOORBELL BOs only after map count goes to zero
  Remove BO from validate list of a KFD process in a safe manner
  Print a warning message if unreserving GPUVMs encounters an error

Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 42 +++++++++++--------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index a1de900ba677..ee48e6591f99 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1013,14 +1013,22 @@ static void add_kgd_mem_to_kfd_bo_list(struct kgd_mem *mem,
 	mutex_unlock(&process_info->lock);
 }
 
-static void remove_kgd_mem_from_kfd_bo_list(struct kgd_mem *mem,
+/**
+ * remove_kgd_mem_from_validate_list() - Remove BO from process's validate list,
+ * in an idempotent manner, so that restore worker can't access it anymore
+ * @mem: BO's membership handle in validate list
+ * @process_info: KFD process handle to which BO belongs
+ *
+ * Return: void
+ */
+static void remove_kgd_mem_from_validate_list(struct kgd_mem *mem,
 		struct amdkfd_process_info *process_info)
 {
 	struct ttm_validate_buffer *bo_list_entry;
 
 	bo_list_entry = &mem->validate_list;
 	mutex_lock(&process_info->lock);
-	list_del(&bo_list_entry->head);
+	list_del_init(&bo_list_entry->head);
 	mutex_unlock(&process_info->lock);
 }
 
@@ -1796,7 +1804,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 
 allocate_init_user_pages_failed:
 err_pin_bo:
-	remove_kgd_mem_from_kfd_bo_list(*mem, avm->process_info);
+	remove_kgd_mem_from_validate_list(*mem, avm->process_info);
 	drm_vma_node_revoke(&gobj->vma_node, drm_priv);
 err_node_allow:
 	/* Don't unreserve system mem limit twice */
@@ -1825,20 +1833,12 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
 	unsigned long bo_size = mem->bo->tbo.base.size;
 	struct kfd_mem_attachment *entry, *tmp;
 	struct bo_vm_reservation_context ctx;
-	struct ttm_validate_buffer *bo_list_entry;
 	unsigned int mapped_to_gpu_memory;
 	int ret;
 	bool is_imported = false;
 
 	mutex_lock(&mem->lock);
 
-	/* Unpin MMIO/DOORBELL BO's that were pinned during allocation */
-	if (mem->alloc_flags &
-	    (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
-	     KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)) {
-		amdgpu_amdkfd_gpuvm_unpin_bo(mem->bo);
-	}
-
 	mapped_to_gpu_memory = mem->mapped_to_gpu_memory;
 	is_imported = mem->is_imported;
 	mutex_unlock(&mem->lock);
@@ -1853,10 +1853,7 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
 	}
 
 	/* Make sure restore workers don't access the BO any more */
-	bo_list_entry = &mem->validate_list;
-	mutex_lock(&process_info->lock);
-	list_del(&bo_list_entry->head);
-	mutex_unlock(&process_info->lock);
+	remove_kgd_mem_from_validate_list(mem, process_info);
 
 	/* No more MMU notifiers */
 	amdgpu_mn_unregister(mem->bo);
@@ -1878,7 +1875,18 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
 	list_for_each_entry_safe(entry, tmp, &mem->attachments, list)
 		kfd_mem_detach(entry);
 
+	/* Return success even in case of error */
 	ret = unreserve_bo_and_vms(&ctx, false, false);
+	if (unlikely(ret)) {
+		WARN_ONCE(ret, "Error in unreserving BO and associated VMs");
+		ret = 0;
+	}
+
+	/* Unpin MMIO/DOORBELL BO's that were pinned during allocation */
+	if (mem->alloc_flags &
+	    (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
+	     KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP))
+		amdgpu_amdkfd_gpuvm_unpin_bo(mem->bo);
 
 	/* Free the sync object */
 	amdgpu_sync_free(&mem->sync);
@@ -2814,7 +2822,7 @@ int amdgpu_amdkfd_add_gws_to_process(void *info, void *gws, struct kgd_mem **mem
 bo_reservation_failure:
 	mutex_unlock(&(*mem)->process_info->lock);
 	amdgpu_sync_free(&(*mem)->sync);
-	remove_kgd_mem_from_kfd_bo_list(*mem, process_info);
+	remove_kgd_mem_from_validate_list(*mem, process_info);
 	amdgpu_bo_unref(&gws_bo);
 	mutex_destroy(&(*mem)->lock);
 	kfree(*mem);
@@ -2832,7 +2840,7 @@ int amdgpu_amdkfd_remove_gws_from_process(void *info, void *mem)
 	/* Remove BO from process's validate list so restore worker won't touch
 	 * it anymore
 	 */
-	remove_kgd_mem_from_kfd_bo_list(kgd_mem, process_info);
+	remove_kgd_mem_from_validate_list(kgd_mem, process_info);
 
 	ret = amdgpu_bo_reserve(gws_bo, false);
 	if (unlikely(ret)) {
-- 
2.35.1

