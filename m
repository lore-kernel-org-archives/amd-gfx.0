Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C44A2C77B6D
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 16:05:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E26610EB84;
	Wed, 29 Mar 2023 16:05:26 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3C7310EB84
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 16:05:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f3MJWQVRZ52slrnMIp40Sx10tZQ3b0I8GzZWB6IJxdnLH+7sXosX0QcgWaa8yHirLYA16AdHRcIZ9BhOf1XpFTifRARgiGIOQpAUr3EyNPnf7kPajV248rsVYAZV/wyTVq/vXTcI0eLYdohg5GV8j4/x+iBZ1P9ItcLgN2iAPJo6KbkprkZHviSUn+aKk9dXmNo/6gc+lMT0hqL9FhEyplldrC+xwoeodX7blzW7FfsDmwSeGc66SKqw4MPvIT4t2tkaMztVBF5yKh/P8uvIqHevJuAo8pZbzMTMmqCLrCCtwnwNon4vSjHvBP/logTwj+hs38HwpSgjwlYYDEjQzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5o4SPAIjGwF98hhnSubf3hX0iNxNz20bM4G5AAj+TNQ=;
 b=R4NRSd+NaFteVCnTF53qunTF7TqbaFKKu0s5uz1SzP3oFb2/cKRIsuGgg1ZzMdwN0Qo20MwfB64TegGE0J0rXtsquTHahTFgIZZjBlOjbjLa//zP2K3FyT6wGmvpkXWOGQZk22QNuZvypvhzbtY5lMvrD83g+c2iOHuOxBcOMFbRm8fs6HzsthTox1q+LBZyLJU6q+psFMOoc8BQV32C50EQLkj2QVOKGM+8LOtkPIocXsU2t1tYkWm9NBqUgqIXtOVOlPBvm7fW7vOH7xcUxEOaN/zORDyz+wbhZloY6brUQUk0VY+bWwtpkKTJcfXAmRtc9D2klOoiEqd9tJ0avg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5o4SPAIjGwF98hhnSubf3hX0iNxNz20bM4G5AAj+TNQ=;
 b=i0ehkL3M2y8/4cyJpiZ3nWr2N6JbWfFGUMrtyDveiE+rFe7dZIRV/+c0JzHQisx0793X/3vP2uJbdZnUfOt9i40QftxxQdkz7JhwYm55dpwiZQCqOaUkeZW2LSjUJ9oIrboFWtLpxrkKC6sqBqJ/RVUUDS2cDE8VpP+pIJodmI4=
Received: from MW4P222CA0005.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::10)
 by SA1PR12MB5670.namprd12.prod.outlook.com (2603:10b6:806:239::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.31; Wed, 29 Mar
 2023 16:05:18 +0000
Received: from CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::d9) by MW4P222CA0005.outlook.office365.com
 (2603:10b6:303:114::10) with Microsoft SMTP Server (version=TLS1_2,
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
 15.20.6222.22 via Frontend Transport; Wed, 29 Mar 2023 16:05:17 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 11:05:15 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 7/9] drm/amdgpu: map usermode queue into MES
Date: Wed, 29 Mar 2023 18:04:43 +0200
Message-ID: <20230329160445.1300-8-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230329160445.1300-1-shashank.sharma@amd.com>
References: <20230329160445.1300-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT042:EE_|SA1PR12MB5670:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e78682c-0619-4da9-d554-08db306f640e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZJALGMF4Xf/a1U4zvvD0YMoFF3UqZEV2ZhlzkjACG5Vs+64Ybt8NlcSxgFkZPY/2sidD9haaXfnStq7n5f86fQA1t/CCd+0Y9dKKcPo1eMc9MvuKscrbOG/7bCx1xn/aYZOYbrjUy9Iy7tLUvNrvEKgAZG6nx2We3DmHIAb1lC05qEMzvpEkLx1cVvOsIdKFlJ5lJv6dyHaFEVL6mSwWs64tZTzOvHsENXfRvNrPBoAtgCJK/ROOvmS2SZNL4C8CU0/zjGhzYe8gX4IthsdAHsG+sczBv6h5o52P/HjtwIBgLgDadPYb+uW3FazQxxj4PCh7LAJRxoCDWopNjB0B0Amr3Ec70X12Ai6PysHIAGKJ69AnDnLVytwdP/Z5TGVG2qeOyfqCdwJsZ31wzDEWA8ZSKBjmXZJ6Tp+XGcdLx2FF8Q/mafHZpauvyxhcL20z56Vgqco5I6mn9cu1cOEhjSH5+tXJ2/NVkoIjgHYXv4Zb+V6P5JT8YBVdD071X39sXXiaFLXg2OKID0dNm+ROEDZ7Q1jjBmP++SVc9mTPzK3ReCy4Z0rGbUtWsz0k3YWOG6ajphDuGsoopyKudszgZTZyDTEzMw7EohicvqGZopEibptI/pQA267whp1Gx4RvgbHZBkVFbB2Gq2qivMDMS++iOn+ou+YDEvS/o3Uq9jqhsNf2ZuD2DgjaqF1zfEE6M68IvUDMBCCwCGoqI9shfOknwRCDyJNGkNv0TC4stbQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(39860400002)(376002)(396003)(451199021)(46966006)(40470700004)(36840700001)(83380400001)(356005)(1076003)(81166007)(82740400003)(26005)(6666004)(478600001)(82310400005)(7696005)(316002)(54906003)(36756003)(70586007)(8676002)(70206006)(6916009)(40480700001)(41300700001)(86362001)(4326008)(2616005)(336012)(47076005)(44832011)(8936002)(2906002)(5660300002)(40460700003)(16526019)(36860700001)(426003)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 16:05:17.9691 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e78682c-0619-4da9-d554-08db306f640e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5670
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
 Shashank Sharma <contactshashanksharma@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>,
 Shashank Sharma <shashank.sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Shashank Sharma <contactshashanksharma@gmail.com>

This patch adds new functions to map/unmap a usermode queue into
the FW, using the MES ring. As soon as this mapping is done, the
queue would  be considered ready to accept the workload.

V1: Addressed review comments from Alex on the RFC patch series
    - Map/Unmap should be IP specific.
V2:
    Addressed review comments from Christian:
    - Fix the wptr_mc_addr calculation (moved into another patch)
    Addressed review comments from Alex:
    - Do not add fptrs for map/unmap

V3: Integration with doorbell manager

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c | 70 +++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
index 39e90ea32fcb..1627641a4a4e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
@@ -23,12 +23,73 @@
 #include "amdgpu.h"
 #include "amdgpu_userqueue.h"
 #include "v11_structs.h"
+#include "amdgpu_mes.h"
 
 #define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
 #define AMDGPU_USERQ_GANG_CTX_SZ PAGE_SIZE
 #define AMDGPU_USERQ_FW_CTX_SZ PAGE_SIZE
 #define AMDGPU_USERQ_GDS_CTX_SZ PAGE_SIZE
 
+static int
+amdgpu_userq_gfx_v11_map(struct amdgpu_userq_mgr *uq_mgr,
+                         struct amdgpu_usermode_queue *queue)
+{
+    struct amdgpu_device *adev = uq_mgr->adev;
+    struct mes_add_queue_input queue_input;
+    int r;
+
+    memset(&queue_input, 0x0, sizeof(struct mes_add_queue_input));
+
+    queue_input.process_va_start = 0;
+    queue_input.process_va_end = (adev->vm_manager.max_pfn - 1) << AMDGPU_GPU_PAGE_SHIFT;
+    queue_input.process_quantum = 100000; /* 10ms */
+    queue_input.gang_quantum = 10000; /* 1ms */
+    queue_input.paging = false;
+
+    queue_input.gang_context_addr = queue->gang_ctx_gpu_addr;
+    queue_input.process_context_addr = queue->proc_ctx_gpu_addr;
+    queue_input.inprocess_gang_priority = AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
+    queue_input.gang_global_priority_level = AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
+
+    queue_input.process_id = queue->vm->pasid;
+    queue_input.queue_type = queue->queue_type;
+    queue_input.mqd_addr = queue->mqd.gpu_addr;
+    queue_input.wptr_addr = queue->userq_prop.wptr_gpu_addr;
+    queue_input.queue_size = queue->userq_prop.queue_size >> 2;
+    queue_input.doorbell_offset = queue->userq_prop.doorbell_index;
+    queue_input.page_table_base_addr = amdgpu_gmc_pd_addr(queue->vm->root.bo);
+
+    amdgpu_mes_lock(&adev->mes);
+    r = adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
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
+static void
+amdgpu_userq_gfx_v11_unmap(struct amdgpu_userq_mgr *uq_mgr,
+                           struct amdgpu_usermode_queue *queue)
+{
+    struct amdgpu_device *adev = uq_mgr->adev;
+    struct mes_remove_queue_input queue_input;
+    int r;
+
+    memset(&queue_input, 0x0, sizeof(struct mes_remove_queue_input));
+    queue_input.doorbell_offset = queue->userq_prop.doorbell_index;
+    queue_input.gang_context_addr = queue->gang_ctx_gpu_addr;
+
+    amdgpu_mes_lock(&adev->mes);
+    r = adev->mes.funcs->remove_hw_queue(&adev->mes, &queue_input);
+    amdgpu_mes_unlock(&adev->mes);
+    if (r)
+        DRM_ERROR("Failed to unmap queue in HW, err (%d)\n", r);
+}
+
 static int amdgpu_userq_gfx_v11_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
                                                  struct amdgpu_usermode_queue *queue)
 {
@@ -129,6 +190,14 @@ amdgpu_userq_gfx_v11_mqd_create(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_u
 
     amdgpu_userq_set_ctx_space(uq_mgr, queue);
     amdgpu_bo_unreserve(mqd->obj);
+
+    /* Map the queue in HW using MES ring */
+    r = amdgpu_userq_gfx_v11_map(uq_mgr, queue);
+    if (r) {
+        DRM_ERROR("Failed to map userqueue (%d)\n", r);
+        goto free_ctx;
+    }
+
     DRM_DEBUG_DRIVER("MQD for queue %d created\n", queue->queue_id);
     return 0;
 
@@ -147,6 +216,7 @@ amdgpu_userq_gfx_v11_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_
 {
     struct amdgpu_userq_ctx_space *mqd = &queue->mqd;
 
+    amdgpu_userq_gfx_v11_unmap(uq_mgr, queue);
     amdgpu_userq_gfx_v11_destroy_ctx_space(uq_mgr, queue);
     amdgpu_bo_free_kernel(&mqd->obj,
 			   &mqd->gpu_addr,
-- 
2.40.0

