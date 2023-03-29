Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 097CAC77B61
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 16:05:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F29C10EB87;
	Wed, 29 Mar 2023 16:05:29 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F3F010EB88
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 16:05:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QNbiNct+OFHJYtI5+anCsG0JM78SLiqhpDzn2rjpjB0Ooc/4wXKxNux5urmO1JrMTT+W6q5G9IZYoI4mgv3D8/C/K4s5FCe000ddMu3F4MHjeplgPIJlYnhV9qTTM7ut95Ncv9xhasftKk+3ZlqEUNSnoit7afRbGQXvIzwLCVPvQ9YF6XJvvD9LYod5FhRIlzp/Q2FfgqLs8BoP3t4liw5xtIK5nfHzvR+V9kv8/Qg+4RqfjnwPTEyIxzkGDGuZEAfxKShdI5rx51MJt9VX7gqY1EsqB3Q4WWAZtkzElRzGgL9U5STpQkvlkPSVkJ57dcAD+lJZFu6BIX57tqmVRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YNCWX6ZUvYpA7ndG2/5mUyJnwbqq7A0bcZ1Jmj5Q1Ds=;
 b=LpuI5jFKj36+kw2haRgdaHTnJ0h85H0v78hBn0FCr1WoNqQ9o3Cy5q46WBRPok86n0oQsRpQeYhY+3enYMiq4XNNs5k0mIqY/NlFPez4FKe+rJJslCwdbjsbUFI8xcayCOw1zxyauwzvLpwE0Mi5IkU3XYmqvYp8Kzxzibx7lfv25fMWI0KttNvotqD9EkYzq5IllI0gOhXvWPVuTkjz4JmZWAB92eEX6CmohkYeGVr3BPAVjQoFNPgQTRJ/KUe9J8ZTNn5go9UYdHhGHutOMky6R/VqyISieTpgiutGBFj2fswmtwZcGd4/O4aMFB3Pe/QdN6QmlIqtVVnov9gJRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YNCWX6ZUvYpA7ndG2/5mUyJnwbqq7A0bcZ1Jmj5Q1Ds=;
 b=0IEfQajnV2wLyKwE+YB1WaYUGKfnDjWX3ArTZ+BGh6bzV9xB8zM5/1NulqNIuiU9sbqEfBeIhk6wf6VZ/rLa+hPC7GEIOio+GPccR8JSaj2CP3YOURlu3h5ditSB/ksH7t8qJ1deDmER2Zh6NmGdk1spIH1m85e+lYT+y7jgNtM=
Received: from MW4P222CA0020.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::25)
 by IA0PR12MB8696.namprd12.prod.outlook.com (2603:10b6:208:48f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Wed, 29 Mar
 2023 16:05:18 +0000
Received: from CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::a7) by MW4P222CA0020.outlook.office365.com
 (2603:10b6:303:114::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 29 Mar 2023 16:05:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT042.mail.protection.outlook.com (10.13.174.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.22 via Frontend Transport; Wed, 29 Mar 2023 16:05:18 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 11:05:17 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 8/9] drm/amdgpu: map wptr BO into GART
Date: Wed, 29 Mar 2023 18:04:44 +0200
Message-ID: <20230329160445.1300-9-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230329160445.1300-1-shashank.sharma@amd.com>
References: <20230329160445.1300-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT042:EE_|IA0PR12MB8696:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d0ef059-ec19-434f-cf3e-08db306f646b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dZZioSJW6GAQ/erItHpza90AJqUh0c/mMIRhWMlQ/PgTvCvzmT47ogYv/YfJr1Xthll7Wm/v4zUh/XJ6JaL2zaHQNC3LbrYRzWra/bzcCP6pV1QtHBgVrzYQ3cC2xuCzGHG5zwDIIhjwxVkTvLo3PV6/gvUV6FDUFfDS5e81W3kAXP3hzigbvffBdkwcxvghI9AHNNkcQ7og0MSAdLhUm0PuBn4vLx7FHkJtQL9fKcg9guTHONQcfz2xHxtny2Br0O86FutzuL/3+rLAFDRTXMmM99rGnEmDvQSYQ+5QhO5bTS86B4pGlAB1z0hpBcLwNu5G+sCgxvriTH9pCr3/Lq0bpBRW/NHGtJKlbgX2mE4YNX4UCGEgOSBX1zpZageqevw66KkloP7TRAsjZGKLMk3/9nzP/LdQ/SXRZLgJgVSVSieyitOnaEH1S1U/eMFcVqDDzZT77EjFxLNul9m0n8H19+XuH9dpmtWa6h473Ebd92OUkd3/MFJN3OAjPXsSmhaZ4L5suonsX5eW5SnnJ87d/+9mAOiUlJUbje6fOvHEU0oaIFSgd+2Z/qFpDaTpcKIcyLZ/2it+UlPw1jeg52SKgahQfcaJQ6epAqez5CezX2trdCmUGjARgxvOc/NCPoIIiRmDHTWM2mrTMbcs1l+ycqRKcPyMhndSVXF5S2IiBYOW5JfK+a9QB9s3mwrfGtXpH8nWXd4kOW2nSm42GKerHAtSjZ2LQXQVHRDBfgQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(376002)(39860400002)(396003)(451199021)(46966006)(40470700004)(36840700001)(36860700001)(356005)(82740400003)(40460700003)(6916009)(86362001)(336012)(1076003)(8676002)(44832011)(41300700001)(2616005)(70586007)(70206006)(186003)(478600001)(316002)(54906003)(26005)(8936002)(16526019)(426003)(36756003)(7696005)(6666004)(83380400001)(47076005)(40480700001)(5660300002)(4326008)(2906002)(81166007)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 16:05:18.5628 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d0ef059-ec19-434f-cf3e-08db306f646b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8696
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, Arvind
 Yadav <arvind.yadav@amd.com>, Shashank Sharma <shashank.sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Arvind Yadav <arvind.yadav@amd.com>

To support oversubscription, MES expects WPTR BOs to be mapped
to GART, before they are submitted to usermode queues.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Shashank Sharma <shashank.sharma@amd.com>
Signed-off-by: ￼Arvind Yadav <arvind.yadav@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 89 +++++++++++++++++++
 .../drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c |  1 +
 .../gpu/drm/amd/include/amdgpu_userqueue.h    |  1 +
 3 files changed, 91 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index 5672efcbcffc..7409a4ae55da 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -43,6 +43,89 @@ amdgpu_userqueue_find(struct amdgpu_userq_mgr *uq_mgr, int qid)
     return idr_find(&uq_mgr->userq_idr, qid);
 }
 
+static int
+amdgpu_userqueue_map_gtt_bo_to_gart(struct amdgpu_device *adev, struct amdgpu_bo *bo)
+{
+    int ret;
+
+    ret = amdgpu_bo_reserve(bo, true);
+    if (ret) {
+        DRM_ERROR("Failed to reserve bo. ret %d\n", ret);
+        goto err_reserve_bo_failed;
+    }
+
+    ret = amdgpu_bo_pin(bo, AMDGPU_GEM_DOMAIN_GTT);
+    if (ret) {
+        DRM_ERROR("Failed to pin bo. ret %d\n", ret);
+        goto err_pin_bo_failed;
+    }
+
+    ret = amdgpu_ttm_alloc_gart(&bo->tbo);
+    if (ret) {
+        DRM_ERROR("Failed to bind bo to GART. ret %d\n", ret);
+        goto err_map_bo_gart_failed;
+    }
+
+
+    amdgpu_bo_unreserve(bo);
+    bo = amdgpu_bo_ref(bo);
+
+    return 0;
+
+err_map_bo_gart_failed:
+    amdgpu_bo_unpin(bo);
+err_pin_bo_failed:
+    amdgpu_bo_unreserve(bo);
+err_reserve_bo_failed:
+
+    return ret;
+}
+
+
+static int
+amdgpu_userqueue_create_wptr_mapping(struct amdgpu_device *adev,
+				     struct drm_file *filp,
+				     struct amdgpu_usermode_queue *queue)
+{
+    struct amdgpu_bo_va_mapping *wptr_mapping;
+    struct amdgpu_vm *wptr_vm;
+    struct amdgpu_bo *wptr_bo = NULL;
+    uint64_t wptr = queue->userq_prop.wptr_gpu_addr;
+    int ret;
+
+    wptr_vm = queue->vm;
+    ret = amdgpu_bo_reserve(wptr_vm->root.bo, false);
+    if (ret)
+        goto err_wptr_map_gart;
+
+    wptr_mapping = amdgpu_vm_bo_lookup_mapping(wptr_vm, wptr >> PAGE_SHIFT);
+    amdgpu_bo_unreserve(wptr_vm->root.bo);
+    if (!wptr_mapping) {
+        DRM_ERROR("Failed to lookup wptr bo\n");
+        ret = -EINVAL;
+        goto err_wptr_map_gart;
+    }
+
+    wptr_bo = wptr_mapping->bo_va->base.bo;
+    if (wptr_bo->tbo.base.size > PAGE_SIZE) {
+        DRM_ERROR("Requested GART mapping for wptr bo larger than one page\n");
+        ret = -EINVAL;
+        goto err_wptr_map_gart;
+    }
+
+    ret = amdgpu_userqueue_map_gtt_bo_to_gart(adev, wptr_bo);
+    if (ret) {
+        DRM_ERROR("Failed to map wptr bo to GART\n");
+        goto err_wptr_map_gart;
+    }
+
+    queue->wptr_mc_addr = wptr_bo->tbo.resource->start << PAGE_SHIFT;
+    return 0;
+
+err_wptr_map_gart:
+    return ret;
+}
+
 static int amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 {
     struct amdgpu_usermode_queue *queue;
@@ -82,6 +165,12 @@ static int amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq
         goto free_queue;
     }
 
+    r = amdgpu_userqueue_create_wptr_mapping(uq_mgr->adev, filp, queue);
+    if (r) {
+        DRM_ERROR("Failed to map WPTR (0x%llx) for userqueue\n", queue->userq_prop.wptr_gpu_addr);
+        goto free_queue;
+    }
+
     r = uq_mgr->userq_funcs[queue->queue_type]->mqd_create(uq_mgr, queue);
     if (r) {
         DRM_ERROR("Failed to create/map userqueue MQD\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
index 1627641a4a4e..274e78826334 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
@@ -58,6 +58,7 @@ amdgpu_userq_gfx_v11_map(struct amdgpu_userq_mgr *uq_mgr,
     queue_input.queue_size = queue->userq_prop.queue_size >> 2;
     queue_input.doorbell_offset = queue->userq_prop.doorbell_index;
     queue_input.page_table_base_addr = amdgpu_gmc_pd_addr(queue->vm->root.bo);
+    queue_input.wptr_mc_addr = queue->wptr_mc_addr;
 
     amdgpu_mes_lock(&adev->mes);
     r = adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
index 8b62ef77cd26..eaab7cf5fff6 100644
--- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
+++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
@@ -38,6 +38,7 @@ struct amdgpu_usermode_queue {
 	int queue_type;
 	uint64_t flags;
 	uint64_t doorbell_handle;
+	uint64_t wptr_mc_addr;
 	uint64_t proc_ctx_gpu_addr;
 	uint64_t gang_ctx_gpu_addr;
 	uint64_t gds_ctx_gpu_addr;
-- 
2.40.0

