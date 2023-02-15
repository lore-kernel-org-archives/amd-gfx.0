Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D530C636D4
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Feb 2023 18:44:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0232410EB72;
	Wed, 15 Feb 2023 18:44:46 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5D7710EB83
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Feb 2023 18:44:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m7nBMCKKoXwNPT0gMmYynS3FWfMZ6j5iG7Ovt2/ph7iMs+XY++c0+hAXQm2q3n2787OvqjGWqQ9xSoSgNGt3VZedcNQLv7ztPd/5wzoZMPEPLPDpKuMjUJEIi7EQoAd6FgT3Lpu5zHwvCKJ/anE/37l1ZG07Cw2uraY6/LHTApYI46xLFhGJ/E6q9iCZHy8U0zpfOZgzPVLGtxjKgwfETASTzU2KfUN3Fa1h939fB8ERyVonHQMBo/+UDy+M2VaDu2eY0laE1UldCqxj137XAstDQYGZxjFqL3o4t91EFaO1oD/H7OywuAXcghFOekOqcfERm3e6wpG3cZ5IBK1+Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L1y/Ox8n51BkWzSW+VG09xrw0W3Wfo9bXaLU5kphQEU=;
 b=gwVNsFj74jimfa76q2EtMbbCMSDZpgbsfLhS0yFOVt3imSuEhcCFmuxCblc++nUI67mhnaI2Qwq482cwW3bLMUJQ0qsaFOXhSjEUThkLAEXJq4mOAhcUuOAXdmnC2TU0Yd6DHthGti7KvTgjw6TRiBPnhK41/wKJPbbnWBi6f6xPxz4SARZsPJd2k27QPSMjPfsSeAG32cVGG1K6iCKaz1zjnMB0B4VZHOZzZ0KUvsuvFyc/wJM2NuwO7aGqhZXDZpTrEbeRbOz7t9pld0cl/286sRm05Ekd7tA9DpR0dx9Dedx8lHFZz8GnGW4jIULfFLWWQNaq7GegjIFwUc0Q2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L1y/Ox8n51BkWzSW+VG09xrw0W3Wfo9bXaLU5kphQEU=;
 b=MSZvIKLB0aWYm69J86BvpVVAHTYMd761Itq+Y9itArdoImG/FzpGJ2VeGilKt9Cb6/6F4h6CHRUoHw1IwqG98lg1t6vb2SjK00UKS6BOYAyGaxeYE3fkz7XQWywMm9pMXP/PxqHn8oA4DG9vvbMMkpXcnokhSJO/qmMHgfVZWcA=
Received: from DM6PR08CA0019.namprd08.prod.outlook.com (2603:10b6:5:80::32) by
 CY5PR12MB6155.namprd12.prod.outlook.com (2603:10b6:930:25::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.26; Wed, 15 Feb 2023 18:44:40 +0000
Received: from DM6NAM11FT102.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::36) by DM6PR08CA0019.outlook.office365.com
 (2603:10b6:5:80::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26 via Frontend
 Transport; Wed, 15 Feb 2023 18:44:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT102.mail.protection.outlook.com (10.13.173.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6111.12 via Frontend Transport; Wed, 15 Feb 2023 18:44:40 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 15 Feb
 2023 12:44:38 -0600
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 7/9] drm/amdgpu: map usermode queue into MES
Date: Wed, 15 Feb 2023 19:43:55 +0100
Message-ID: <20230215184356.2205-8-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230215184356.2205-1-shashank.sharma@amd.com>
References: <20230215184356.2205-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT102:EE_|CY5PR12MB6155:EE_
X-MS-Office365-Filtering-Correlation-Id: da5b3eb8-ac7b-4d9e-4dc8-08db0f84b24f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jO+8HJo/BsBTH8jQBNkdQTpPkaK3wIxY8x5Mroq1rCj8xTxAw2UAykDlfI3ZRCPlT9MPo4BfUmvwVb9xzwV+jmIspfo3/qbmSzWHhRkl4oFi6reNf3abwLxQpX36hLn/PAh8FM68IIkjF9lGfjp1JISSknhvMKKwE9q3OEfixXGIDUxo3n77uNXGMllVuBJebRhTkOZet/TbfC+S6mYDzrKf3YVDOLo2YAb3kI2FICZP7XH9yPQM7JicCLtWfvFLS8f6Sdg6Pcv2qco3VpcJATx/Y7RgUQAdD+cox1caQ+JIb0JqjWLV0GdXwEX0RcAEKTl8pXh1dvSUg8dRoS9edYYElLGWA3j2/oHFJ6iWjOV3GdHvpMxZpJowNeOvYxEobOrRjKAbIs0wNZJELxwNM3nto2Cfjbwz/CslZnLdFoOgFnuT0dOHP51yX/cWX7jcxQWKbQ+ug0HuLBmOQNvdIGbrffFTYDXxoXRahpcrWzeQP+assqDPpaqNEPwtJl4h6JR5p+1cQrewKUGSvvGKWN9eHPeW5wtyXaaqSg3Tlzp+pGH+dksRiGBwyeCQLSPUAKb/dFJcOjqTzXGtl2QN4sDQzvHV7DQDKttPnIWP7WAkfp5fvnpUEplPwN0mMTo7YWXaHrGiP5j/cSciNY980u9a14SheffBhdDU7NlAkxU/3U1IWXfsI60dcLNqiPwAnzqbutw+xZ/kcjgE/yT02a8PLdmxHNcl5r3Ea51kvb0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(39860400002)(136003)(396003)(376002)(451199018)(40470700004)(46966006)(36840700001)(54906003)(83380400001)(426003)(478600001)(336012)(2616005)(47076005)(7696005)(1076003)(36756003)(6666004)(40460700003)(26005)(186003)(16526019)(44832011)(41300700001)(5660300002)(356005)(8936002)(86362001)(40480700001)(316002)(2906002)(82310400005)(70206006)(70586007)(81166007)(82740400003)(4326008)(6916009)(8676002)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 18:44:40.3917 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da5b3eb8-ac7b-4d9e-4dc8-08db0f84b24f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT102.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6155
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
 Shashank Sharma <contactshashanksharma@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>, Arvind.Yadav@amd.com,
 shashank.sharma@amd.com
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
2.34.1

