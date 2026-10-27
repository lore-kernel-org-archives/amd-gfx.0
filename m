Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9523E606A320
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 05:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=JHaP2ZCB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3826E10E124;
	Tue, 27 Oct 2026 05:22:19 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012066.outbound.protection.outlook.com [52.101.53.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA63710E124
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 05:22:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y2tHIxAG87dqwDZUGkq92PoeMVnEv8SOEaMRpTk0UN/YjkKNPPP0XuVi3L/zM5VjYRwsKIls0EzTLME/9mQA08JngbD5sDe88zhWDmb/aIyy79tLHgg7AuhGsnhWMaekoBHWyaZLJdK5mldTA0sRr8SZUTr5lK6N859OvGixqnbB12hmS9vlr2bPeyzOnblTGxW34U1cCpR0ERkKaNW/HD8g+7mRVc1gnopO1Xy690mQwlf4T82fNNQYjgl+jjny8VZI28oRy8ADFvkW4DEH4Ur2aCP+2Qq4QhhifJPCjySaLvVR8uWFmnJrVny7X/VFagyhgU14PfYLjG8IaGfovQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EZpFGThBaION2hT4L0IVN4N0pJYE0IbA9PFHwKMFOzg=;
 b=cn7g6SiAxyAfiVPh8eqG41Xi8IJwn4Ih6pohMWetmC7fBuUZS44GDoHE9MEgfoFQqAYZfgVSumVC6cpiOTYqW2p15V5lJz6rNWmNn65XgBYIyoFZLyT+/SaGzPoZnqVJLoJ4P/5CyuRB7U7Gkx4B8KcT/eiafnjwAx1v9KnLFjZdocABvpML+OEYGQFkxHBNIzPmKOLmcqGB5fQOyUnlwvexM5//ZlNVNl7t3JDdV58R9PdPQTtDrME4w8w5Tg7yjJE1YOoQ0xyy3ivszf3jfbggRY9g8jtmId2rpWdLQvwShWRDdxSzVwpZbqjXE5SQQ0ejOok/IHBuDIKtfANt0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EZpFGThBaION2hT4L0IVN4N0pJYE0IbA9PFHwKMFOzg=;
 b=JHaP2ZCBcNyKW/lw/kJ/aP5vqQanbG87oKmNrQdMAcExqCYPZ1fm0HUx/GXlLxTA2IKBsEqStV9JoH2DUUvcMsTwlmiBTrket1Txtv9Okqs/SAf/S6oqWsFP+58wOZz4jeRcLhnsWzGPTE2ZZzoKayg0NgTLcQL1c5omGGhJp/g=
Received: from PH7P223CA0001.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:338::22)
 by PH7PR12MB6787.namprd12.prod.outlook.com (2603:10b6:510:1ad::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 05:22:08 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:510:338:cafe::b) by PH7P223CA0001.outlook.office365.com
 (2603:10b6:510:338::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Tue,
 27 Oct 2026 05:22:08 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B1.mail.protection.outlook.com (10.167.248.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 05:22:07 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 27 Oct
 2026 00:22:07 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 27 Oct 2026 00:22:05 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Eric Huang <jinhuieric.huang@amd.com>, <Felix.Kuehling@amd.com>,
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdkfd: use the queue's process info for the WPTR BO
 eviction fence
Date: Tue, 27 Oct 2026 13:21:22 +0800
Message-ID: <20261027052205.2716707-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|PH7PR12MB6787:EE_
X-MS-Office365-Filtering-Correlation-Id: f29c99de-8985-4cd5-9abf-08df33ea3edf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|261009223027099003|261021123027099003|261022105027099003|261021121427099003|10067099003|56012099006|261026121527099003|18002099003|11063799006|261026140227099003;
X-Microsoft-Antispam-Message-Info: FpprWXYzstu3xAwZ6kxud/yyKTBThaWwPsIScbkP/Tv7aTzY84bcFlOuvA8QGqaz7RKi1z9WexSwZpzMrtYYzQnNFiHDAYFVYlYhUuy0SAzcUmvzkGlbbeQIDMnyZZ2E6JF7wMhFnITKaZBN2ToNv8/nByW6HoAwckCP8pZSsZNGU65UqAL54XGGt8oKwzCEch2E10bRh0tKVBN3FHrIOF3lZVyNdk1+KUSC/JowUFrMTY2bdcMDAldf/aTCL/npRrluooW09/pWg4fJgEtWmasG6AqvBJ4+8mq31LPy1t8a2fWTKMKRXYWI4fH98xus0sq8EJducNBnKM6datNPBEp/JwJQF6568UczEd2IRHJUmGIXgOVT8z7zF1NXxaOvbEK3XmcqoFmgXCu9UXL4kMETNwtXjrM/ywRc4moRTKMBcDz0jQg/4AZXYZ0Xxn+Zotg59WxKUmcsn6kiiy3xiRL/d2ZZtSJv3VYXNsHPb+6wZ4tE6jUTiWdEKVgZLHYv9XXAJ3/lDEx3yTqty0qmtMah+XzsjuYIv+sOZXDZeGR1N+is11E13zgepqY8s+ihhH3sRphQfD+lG/1+4ozHhpE7ImpW5vaygmcU20jy1la5B3DsRPZL50E0OBWqwemqKD6noPbvyUp9mQuBpuCdcWjd2Op6cgux9Mux0b2rAk4M4MY9H59FQWM6XX/OyzcKoWhgozB/rCNxVaondfto2g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(261009223027099003)(261021123027099003)(261022105027099003)(261021121427099003)(10067099003)(56012099006)(261026121527099003)(18002099003)(11063799006)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UVixXdmJWgPzbjbQQb4xQhkeVwB6TAdanmKJKbkYqUlwtcyH+sYrExzKRIfDxv/rUXZmwYcnyDD+P+iOe5jzODNr/6iwVBKOfDHJxAJ2kiwwY8ymvBEvkKx4E9fZlJ28LzXY3/krIZcnjP2oUZwWSWA6NYBJV7JfoN16DEc+bBckcTyZhv8Xhkwu9HbuN/9LbEBB0KN0kN+/44gtqsRP1eakZS/9gYMhP4U1Y1sSD0Uw47Y9jgqxPKWCJKJ2FpebPDudrfNeeoQpmYEmnNJS6PtGmuoTBUOIhFHv3LR68uMLFQq7ufPeftFbCMHOv2quGqJQ3n4GrM4MHu9tvhvn1o68SZEuY7i1mrcC1Gqu8xbGm55pct8w3JOUwU7RERIP6rxVSaSL28FxApSBPjdup25NFvnZyeRkboU7bxS/hmQA81IXztV5dwbiloFik4uS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 05:22:07.9736 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f29c99de-8985-4cd5-9abf-08df33ea3edf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6787
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

amdgpu_amdkfd_map_gtt_bo_to_gart() removes the eviction fence of
bo->vm_bo->vm->process_info from the WPTR BO of a new queue. bo->vm_bo
is the VM which opened the BO last, not necessarily the KFD process' VM,
and a render node VM has no process info.

On navi31, an unprivileged process which exports its WPTR BO with
AMDKFD_IOC_EXPORT_DMABUF and imports it on a second render node fd
oopses in AMDKFD_IOC_CREATE_QUEUE:

  BUG: kernel NULL pointer dereference, address: 0000000000000060
  RIP: 0010:amdgpu_amdkfd_map_gtt_bo_to_gart+0x86/0x1a0 [amdgpu]
   init_user_queue.part.0+0x180/0x250 [amdgpu]
   pqm_create_queue+0x32d/0x730 [amdgpu]
   kfd_ioctl_create_queue+0x583/0x9f0 [amdgpu]

Pass the process info of the queue instead. With the fix, the queue is
created and destroyed normally.

Fixes: 7f347e3f8217 ("drm/amdkfd: Fix NULL pointer error for GC 11.0.1 on mGPU")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h             | 3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c       | 8 +++++---
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 3 ++-
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 77c0504cc158..74dc307e5140 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -344,7 +344,8 @@ int amdgpu_amdkfd_gpuvm_map_bo_to_kernel(struct kgd_mem *mem, void **kptr,
 					 u64 *size, u32 domain);
 void amdgpu_amdkfd_gpuvm_unmap_bo_from_kernel(struct kgd_mem *mem);
 
-int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_bo *bo, struct amdgpu_bo **bo_gart);
+int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_bo *bo, struct amdgpu_bo **bo_gart,
+				     struct amdkfd_process_info *process_info);
 
 int amdgpu_amdkfd_gpuvm_restore_process_bos(void *process_info,
 					    struct dma_fence __rcu **ef);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 4d209b6c2582..cd72f8d84e79 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -2261,11 +2261,13 @@ int amdgpu_amdkfd_gpuvm_sync_memory(
  * amdgpu_amdkfd_map_gtt_bo_to_gart - Map BO to GART and increment reference count
  * @bo: Buffer object to be mapped
  * @bo_gart: Return bo reference
+ * @process_info: KFD process info of the queue the BO is for
  *
  * Before return, bo reference count is incremented. To release the reference and unpin/
  * unmap the BO, call amdgpu_amdkfd_free_kernel_mem.
  */
-int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_bo *bo, struct amdgpu_bo **bo_gart)
+int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_bo *bo, struct amdgpu_bo **bo_gart,
+				     struct amdkfd_process_info *process_info)
 {
 	int ret;
 
@@ -2287,8 +2289,8 @@ int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_bo *bo, struct amdgpu_bo **bo
 		goto err_map_bo_gart_failed;
 	}
 
-	amdgpu_amdkfd_remove_eviction_fence(
-		bo, bo->vm_bo->vm->process_info->eviction_fence);
+	/* bo->vm_bo can be the VM of any file which opened the BO */
+	amdgpu_amdkfd_remove_eviction_fence(bo, process_info->eviction_fence);
 
 	amdgpu_bo_unreserve(bo);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 78ab759ad854..4c4a3a8587f4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -303,7 +303,8 @@ static int init_user_queue(struct process_queue_manager *pqm,
 		}
 
 		retval = amdgpu_amdkfd_map_gtt_bo_to_gart(q_properties->wptr_bo,
-							  &(*q)->wptr_bo_gart);
+							  &(*q)->wptr_bo_gart,
+							  pqm->process->kgd_process_info);
 		if (retval) {
 			pr_err("Failed to map wptr bo to GART\n");
 			goto free_gang_ctx_bo;
-- 
2.50.1

