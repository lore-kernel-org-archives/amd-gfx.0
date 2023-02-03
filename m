Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BBD7C63797
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Feb 2023 21:54:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18B1110E920;
	Fri,  3 Feb 2023 21:54:52 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87CF310E91F
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Feb 2023 21:54:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CrtpdSXoZE9oiRGbU3JnKRCfol7f4x0mkVWz91vup6vrdCjqnnUVqhGnWdy8ZqDE8/SOLcyPoZBMt4NZjv0OnUo22MhV1HlrdXv45lvUInfgR3wsDBQOZGxrqvhyhzAWLzOaCFd52+Ll5uNxsWiHPnP/Oods+SPQNWbO2uE/mFhOjMq3FJcHA8jwceW3HPW6jH/hkWgNKxPifNV5xhx/sfc208iNOAEXYjVzP8nQY4eDqYLKdStHQX6o3UvEuqmxge9HNyUcNnpkznR3axU6cDzb0Jejh6D1c0VWP9uN37yRvxaKl9XXI9vt/zLm4llf32CiC92QoP2weA1Pr4QrgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Xu0nV2y/2UYXrGW0x41GOLCA1xwr2eeXRqcK0bjbyo=;
 b=LXTQHQMS9Loi6uewpuuObr7y32TzGZ21HIgW2Kl0xbS4RLbPwfdutMix4fPFJmkpIf59Lsi3J1ygC9WpinVKzFanQz5j6JaQbCgKU93K7ZjwNS+RjXfVhYM4l94Yw0U+Xfb++rKefNwlBOTI+AFktECvbnD3RGL5hNgv515h45UToYxyUJU6Zn0l947WX+7OYoXe1J1PdHFYeNEUqyAxNW4R25RSWwARIVzUtrP2JI45llv1zaz90aw3NQJCvE8GCdhywulbedgqY2cEV4JshoLFjf82VkxhC+zpQF/PnNn4SIekXoMUoFonxeB1WdhF7NHDmty/19nvHVcGGIemvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Xu0nV2y/2UYXrGW0x41GOLCA1xwr2eeXRqcK0bjbyo=;
 b=PmTM/RnmPuXiLeujo99vIAIP5H9lerFx75AAYPWM1yZDq+ffV5J7720f3YgRilR74eUMTLpa1kiTe5b9VjNIEGfyEtHOk8L3HM9vjUiNw1rDXn8c6GH1iXi/cnkblZyi/Nbp8d7GbyD/sVClmUZewgqfZ8ggULwTgr987LgcS7Y=
Received: from CY5PR19CA0121.namprd19.prod.outlook.com (2603:10b6:930:64::26)
 by DS7PR12MB8323.namprd12.prod.outlook.com (2603:10b6:8:ec::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31; Fri, 3 Feb
 2023 21:54:44 +0000
Received: from CY4PEPF0000C977.namprd02.prod.outlook.com
 (2603:10b6:930:64:cafe::73) by CY5PR19CA0121.outlook.office365.com
 (2603:10b6:930:64::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31 via Frontend
 Transport; Fri, 3 Feb 2023 21:54:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C977.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.18 via Frontend Transport; Fri, 3 Feb 2023 21:54:44 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Feb
 2023 15:54:41 -0600
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 6/8] drm/amdgpu: Map userqueue into HW
Date: Fri, 3 Feb 2023 22:54:07 +0100
Message-ID: <20230203215409.2021-7-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230203215409.2021-1-shashank.sharma@amd.com>
References: <20230203215409.2021-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C977:EE_|DS7PR12MB8323:EE_
X-MS-Office365-Filtering-Correlation-Id: 74452ddb-8a2a-4fee-8355-08db063142af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jze0/0zcI5xvs7uHbFeZFgvHmQCJyiVJtNbZQvKdiff2qZTgiSSnjUtHyd9Lrc7LzPgPp+4vxbxtbLjGzyMZlw9ilOyVhYREiES7uA4ThaEgnE4oVSCcijkASw39HmdIWN4WIeAE3dJL9vbdDaP1RZ9fmWqbhM9E6s2aqp6DnFamSAVkbPNEoGKiSKk2t+K/u3bZ1TFSW8E7XDiExVHVSUKXnkQG43gDV2SHjxjQqSuLMCbZ7eZr2UlXwbBgmOioIoQsZ6Gw68sxxkzbFFIw12KZl6lfdo+Wl44dE/SYL3dZxsxJVBBMjUNESZwuxYmfmXFkcUX8P7bBGP5ihkJ3kgPRVfrc2z5jrM/QocBrNYsgqX81nOHFIhkTdXN7HoIfdR0lWK1OUzhxSsdRLvH9sx8WGBuPnwb2Cn3bIYL3tBvyXvHsxSDD7ZLkp6JFyWe9sszC5UMAdv490oxGBTvNFarm2rFTkbdf94WW8HxtHLM8yoZnu86hb12qAKMdqvDKhl5LfihIPGhN53TIn9KuW78Bo685+SRxbl4KT706LMX09clHnu+dkYqhSA+0gQtBSoaL0TLvjmCMevkS6SpiWvO8EVU4+qRdfl85mco3RYmM7zEvdN8LqHJXp71CBqHsVJwVIwxxLZddrejE8iGKEvWpBffMg0Wr/YQGScALdlvfbfD8tbpnfUbQVDIzghUozhSHH9kOPEdAJbSCwSdTKZYX7t+cbiBv34IxIKLhoDY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199018)(40470700004)(46966006)(36840700001)(82310400005)(83380400001)(7696005)(186003)(40460700003)(36756003)(356005)(40480700001)(86362001)(82740400003)(81166007)(36860700001)(26005)(16526019)(336012)(41300700001)(2616005)(47076005)(426003)(478600001)(1076003)(54906003)(316002)(6666004)(44832011)(70206006)(6916009)(4326008)(8936002)(70586007)(8676002)(5660300002)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 21:54:44.3925 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74452ddb-8a2a-4fee-8355-08db063142af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C977.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8323
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
Cc: alexander.deucher@amd.com,
 Shashank Sharma <contactshashanksharma@gmail.com>, christian.koenig@amd.com,
 shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Shashank Sharma <contactshashanksharma@gmail.com>

This patch adds new fptrs to prepare the usermode queue to be
mapped or unmapped into the HW. After this mapping, the queue
will be ready to accept the workload.

V1: Addressed review comments from Alex on the RFC patch series
    - Map/Unmap should be IP specific.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 57 +++++++++++++++++++
 .../amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c | 47 +++++++++++++++
 .../gpu/drm/amd/include/amdgpu_userqueue.h    |  2 +
 3 files changed, 106 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index 18281b3a51f1..cbfe2608c040 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -42,6 +42,53 @@ static struct amdgpu_usermode_queue
     return idr_find(&uq_mgr->userq_idr, qid);
 }
 
+static void
+amdgpu_userqueue_unmap(struct amdgpu_userq_mgr *uq_mgr,
+                     struct amdgpu_usermode_queue *queue)
+{
+    int r;
+    struct amdgpu_device *adev = uq_mgr->adev;
+    struct mes_remove_queue_input remove_request;
+
+    uq_mgr->userq_mqd_funcs->prepare_unmap(uq_mgr, queue, (void *)&remove_request);
+
+    amdgpu_mes_lock(&adev->mes);
+    r = adev->mes.funcs->remove_hw_queue(&adev->mes, &remove_request);
+    amdgpu_mes_unlock(&adev->mes);
+    if (r) {
+        DRM_ERROR("Failed to unmap usermode queue %d\n", queue->queue_id);
+        return;
+    }
+
+    DRM_DEBUG_DRIVER("Usermode queue %d unmapped\n", queue->queue_id);
+}
+
+static int
+amdgpu_userqueue_map(struct amdgpu_userq_mgr *uq_mgr,
+                     struct amdgpu_usermode_queue *queue)
+{
+    int r;
+    struct amdgpu_device *adev = uq_mgr->adev;
+    struct mes_add_queue_input add_request;
+
+    r = uq_mgr->userq_mqd_funcs->prepare_map(uq_mgr, queue, (void *)&add_request);
+    if (r) {
+        DRM_ERROR("Failed to map userqueue\n");
+        return r;
+    }
+
+    amdgpu_mes_lock(&adev->mes);
+    r = adev->mes.funcs->add_hw_queue(&adev->mes, &add_request);
+    amdgpu_mes_unlock(&adev->mes);
+    if (r) {
+        DRM_ERROR("Failed to map queue in HW, err (%d)\n", r);
+        return r;
+    }
+
+    DRM_DEBUG_DRIVER("Queue %d mapped successfully\n", queue->queue_id);
+    return 0;
+}
+
 static void
 amdgpu_userqueue_destroy_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
                                    struct amdgpu_usermode_queue *queue)
@@ -170,12 +217,21 @@ static int amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq
         goto free_mqd;
     }
 
+    r = amdgpu_userqueue_map(uq_mgr, queue);
+    if (r) {
+        DRM_ERROR("Failed to map userqueue\n");
+        goto free_ctx;
+    }
+
     list_add_tail(&queue->userq_node, &uq_mgr->userq_list);
     args->out.q_id = queue->queue_id;
     args->out.flags = 0;
     mutex_unlock(&uq_mgr->userq_mutex);
     return 0;
 
+free_ctx:
+    amdgpu_userqueue_destroy_ctx_space(uq_mgr, queue);
+
 free_mqd:
     amdgpu_userqueue_destroy_mqd(uq_mgr, queue);
 
@@ -201,6 +257,7 @@ static void amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
     }
 
     mutex_lock(&uq_mgr->userq_mutex);
+    amdgpu_userqueue_unmap(uq_mgr, queue);
     amdgpu_userqueue_destroy_ctx_space(uq_mgr, queue);
     amdgpu_userqueue_destroy_mqd(uq_mgr, queue);
     amdgpu_userqueue_free_index(uq_mgr, queue->queue_id);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c
index 687f90a587e3..d317bb600fd9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c
@@ -24,6 +24,7 @@
 #include "amdgpu_userqueue.h"
 #include "v11_structs.h"
 #include "amdgpu_mes.h"
+#include "mes_api_def.h"
 #include "gc/gc_11_0_0_offset.h"
 #include "gc/gc_11_0_0_sh_mask.h"
 
@@ -239,6 +240,50 @@ static void amdgpu_userq_gfx_v11_ctx_destroy(struct amdgpu_userq_mgr *uq_mgr,
                           &pctx->cpu_ptr);
 }
 
+static int
+amdgpu_userq_gfx_v11_prepare_map(struct amdgpu_userq_mgr *uq_mgr,
+                                 struct amdgpu_usermode_queue *queue,
+                                 void *q_input)
+{
+    struct amdgpu_device *adev = uq_mgr->adev;
+    struct mes_add_queue_input *queue_input = q_input;
+
+    memset(queue_input, 0x0, sizeof(struct mes_add_queue_input));
+
+    queue_input->process_va_start = 0;
+    queue_input->process_va_end = (adev->vm_manager.max_pfn - 1) << AMDGPU_GPU_PAGE_SHIFT;
+    queue_input->process_quantum = 100000; /* 10ms */
+    queue_input->gang_quantum = 10000; /* 1ms */
+    queue_input->paging = false;
+
+    queue_input->gang_context_addr = queue->gang_ctx.gpu_addr;
+    queue_input->process_context_addr = queue->proc_ctx.gpu_addr;
+    queue_input->inprocess_gang_priority = AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
+    queue_input->gang_global_priority_level = AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
+
+    queue_input->process_id = queue->pasid;
+    queue_input->queue_type = queue->queue_type;
+    queue_input->mqd_addr = queue->mqd_gpu_addr;
+    queue_input->wptr_addr = queue->wptr_gpu_addr;
+    queue_input->wptr_mc_addr = queue->wptr_gpu_addr << AMDGPU_GPU_PAGE_SHIFT;
+    queue_input->queue_size = queue->queue_size >> 2;
+    queue_input->doorbell_offset = queue->doorbell_index;
+    queue_input->page_table_base_addr = amdgpu_gmc_pd_addr(queue->vm->root.bo);
+    return 0;
+}
+
+static void
+amdgpu_userq_gfx_v11_prepare_unmap(struct amdgpu_userq_mgr *uq_mgr,
+                                   struct amdgpu_usermode_queue *queue,
+                                   void *q_input)
+{
+    struct mes_remove_queue_input *queue_input = q_input;
+
+    memset(queue_input, 0x0, sizeof(struct mes_remove_queue_input));
+    queue_input->doorbell_offset = queue->doorbell_index;
+    queue_input->gang_context_addr = queue->gang_ctx.gpu_addr;
+}
+
 static int amdgpu_userq_gfx_v11_mqd_size(struct amdgpu_userq_mgr *uq_mgr)
 {
     return sizeof(struct v11_gfx_mqd);
@@ -250,4 +295,6 @@ const struct amdgpu_userq_mqd_funcs userq_gfx_v11_mqd_funcs = {
     .mqd_destroy = amdgpu_userq_gfx_v11_mqd_destroy,
     .ctx_create = amdgpu_userq_gfx_v11_ctx_create,
     .ctx_destroy = amdgpu_userq_gfx_v11_ctx_destroy,
+    .prepare_map = amdgpu_userq_gfx_v11_prepare_map,
+    .prepare_unmap = amdgpu_userq_gfx_v11_prepare_unmap,
 };
diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
index 3adcd31618f7..202fac237501 100644
--- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
+++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
@@ -82,6 +82,8 @@ struct amdgpu_userq_mqd_funcs {
 	void (*mqd_destroy)(struct amdgpu_userq_mgr *, struct amdgpu_usermode_queue *);
 	int (*ctx_create)(struct amdgpu_userq_mgr *, struct amdgpu_usermode_queue *);
 	void (*ctx_destroy)(struct amdgpu_userq_mgr *, struct amdgpu_usermode_queue *);
+	int (*prepare_map)(struct amdgpu_userq_mgr *, struct amdgpu_usermode_queue *, void *);
+	void (*prepare_unmap)(struct amdgpu_userq_mgr *, struct amdgpu_usermode_queue *, void *);
 };
 
 int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_device *adev);
-- 
2.34.1

