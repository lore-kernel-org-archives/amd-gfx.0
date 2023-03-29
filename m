Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4973C6FD18
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 16:05:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21EAF10EB83;
	Wed, 29 Mar 2023 16:05:22 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2052.outbound.protection.outlook.com [40.107.100.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8793910EB9E
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 16:05:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FcB3SzrZU9jo0Il+hykOvSIXzeV5aR4ZDfugy30RasJRTnDHWpMcwxtXb5s5PRPbM7yqvZeb78s3AK3XnXd0nWUBvuo5o7yrCr5vzlsTLKEG3EpaTBVi2R4MrbTL8B8Hsq6Du02v2VVFUNZPkl5lwFmIpWR376PxL+8re3kXpPAJIpwSMdfX80YBglPXr0E+l0n/0+YBLT0upl08DFxF1Ub+dlkAS/AHCY7GO53/u4Ns55UrnJaNP140BQEhCJzJnaVwcsyZBLZc+No+XaaeYDPLVtOwE8FG5E/YP0y/nE/kZGnDmbhKkSnmju5Ms5Mbg8GmcIqfyNYaiEN3d+sbhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cHLizTWoOiSRh0FbcX+EyiOj6mrBStbW78ZBp45fbvY=;
 b=nBuXvAzedz11DrRGgjy9GJce+0pp/IDIcVumKQoFXepgNzwBu7eb7vY7hyrEvQJB5sr/ASd+TVTFlM1G6POpxhtuFPndsRJEZCFt04anc25AM4LIyP0hUT3Ph+CQh9cPXl/Vrrq1AjGMucVnpNmdheJD0NioBAcF8f9KD0cPKfMrzfRecWTtrlUR6CQhew9/5MIkyzgb/RSt9lLNup+oAq7GmD3VrPKMsBr8YgFbNf+mg4PW4ujXg1CiyHKX7Fbr8ZHO0oZ6yEK/ELSyePVg4ohCYFZ2B/i6+p7uvmk5Dq+ToJtPSU/oKWF99JIf/WOpDW63w00QDNwENp6gQzTA3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cHLizTWoOiSRh0FbcX+EyiOj6mrBStbW78ZBp45fbvY=;
 b=lkvECnm6mGx+AFKo7VGlfbBbVangSnqZhlM8rh7Yb7ha+vt3gJIL3uF3vKQZBB07nbzRQyeOdWNSmWeVu37Q1nxkGkArRdy0FlEjxIo7VoDPgMZxdiYQi/gC6t+jlAF0QkFf+08KoTGNfJyUIpb4dDRBJgZmYRwR4e7BySvnNww=
Received: from BN9PR03CA0267.namprd03.prod.outlook.com (2603:10b6:408:ff::32)
 by SJ0PR12MB8615.namprd12.prod.outlook.com (2603:10b6:a03:484::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.28; Wed, 29 Mar
 2023 16:05:17 +0000
Received: from BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ff:cafe::92) by BN9PR03CA0267.outlook.office365.com
 (2603:10b6:408:ff::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 29 Mar 2023 16:05:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT015.mail.protection.outlook.com (10.13.176.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.20 via Frontend Transport; Wed, 29 Mar 2023 16:05:16 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 11:05:12 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 5/9] drm/amdgpu: create context space for usermode queue
Date: Wed, 29 Mar 2023 18:04:41 +0200
Message-ID: <20230329160445.1300-6-shashank.sharma@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT015:EE_|SJ0PR12MB8615:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cff3671-a473-462d-57ad-08db306f6312
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TNFolMNyignzpW12GrnxUu+/i8JuP+IBITL9u9oN7dUv3PdyJ5KCc4v9oZBqMtTvF+8LJlp/P48+cMReOhYmAUJzXZb/CeLMCtObkvHtLx7w0tsxvfvcpDcvs5MXQ8mVMjuqBqLITgz8sLTlLesFbVIBlqqVxoI8V7WCzXUKyggzjaDkBM9VQOl+DEV9ABWnPUkL0TOKfGitTAdPswI8TPnk55Fx7euWRs1NW4CU/M5KbXgU2Z49CTZCDOdyR10dVz9lGBDIZOLjOXnTv3DIhKaAk+SFwos+0lZKaJALAZBWVPKMN5n+z5/N7jQvcfrmIKed9TdTIK7+enwKUOwI27UafuiaqCJ/uukHtRjQRt9DvVT9goEm3Z7vWyx72yEt+76Nzg6Oj8EGh0/pmNXYdV4Yveozcgp08vZiPHJW2VP9/ULdfnJ6hWATeuDdj6pDuTM+0O2CEuIK/ne0VrfQdC+LsC+xjD1QDbMEjH0aNn8RbXjuNgCFjVbmXGUvb8Vc1sYNG1BlvvLx+jdMf98fUZtnYYDeS2yG0i3fKhGci3IMJHVCCVpKjq1/UtIwNnOwBKdChIuE1IQAie3eOe8mqKTUKduzwP3zEoNvWwyxVbdTz0q4n1liBnmZLWLpl4uDHxqndw3u9LEG1N2HTeDJ2SkB+vnwhwdSWsK9QiTir0LedD/+qZu9nL9cfZNxOsETrWF6PR6kDOc1FUWD6RLNwUq29VNplDNEvmPeD5JJ2j4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(47076005)(2906002)(2616005)(83380400001)(426003)(336012)(6916009)(8676002)(4326008)(70586007)(70206006)(7696005)(478600001)(54906003)(1076003)(316002)(26005)(16526019)(82310400005)(186003)(6666004)(44832011)(36756003)(86362001)(36860700001)(41300700001)(82740400003)(81166007)(5660300002)(40480700001)(356005)(40460700003)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 16:05:16.4394 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cff3671-a473-462d-57ad-08db306f6312
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8615
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

The FW expects us to allocate atleast one page as context space to
process gang, process, shadow, GDS and FW  related work. This patch
creates a joint object for the same, and calculates GPU space offsets
for each of these spaces.

V1: Addressed review comments on RFC patch:
    Alex: Make this function IP specific

V2: Addressed review comments from Christian
    - Allocate only one object for total FW space, and calculate
      offsets for each of these objects.

V3: Integration with doorbell manager

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c |  1 +
 .../drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c | 60 ++++++++++++++++++-
 .../gpu/drm/amd/include/amdgpu_userqueue.h    |  7 +++
 3 files changed, 66 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index 052c2c1e8aed..5672efcbcffc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -71,6 +71,7 @@ static int amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq
     queue->userq_prop.queue_size = mqd_in->queue_size;
 
     queue->doorbell_handle = mqd_in->doorbell_handle;
+    queue->shadow_ctx_gpu_addr = mqd_in->shadow_va;
     queue->queue_type = mqd_in->ip_type;
     queue->flags = mqd_in->flags;
     queue->vm = &fpriv->vm;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
index 12e1a785b65a..52de96727f98 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
@@ -23,6 +23,51 @@
 #include "amdgpu.h"
 #include "amdgpu_userqueue.h"
 
+#define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
+#define AMDGPU_USERQ_GANG_CTX_SZ PAGE_SIZE
+#define AMDGPU_USERQ_FW_CTX_SZ PAGE_SIZE
+#define AMDGPU_USERQ_GDS_CTX_SZ PAGE_SIZE
+
+static int amdgpu_userq_gfx_v11_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
+                                                 struct amdgpu_usermode_queue *queue)
+{
+    struct amdgpu_device *adev = uq_mgr->adev;
+    struct amdgpu_userq_ctx_space *ctx = &queue->fw_space;
+    int r, size;
+
+    /*
+     * The FW expects atleast one page space allocated for
+     * process ctx, gang ctx, gds ctx, fw ctx and shadow ctx each.
+     */
+    size = AMDGPU_USERQ_PROC_CTX_SZ + AMDGPU_USERQ_GANG_CTX_SZ +
+           AMDGPU_USERQ_FW_CTX_SZ + AMDGPU_USERQ_GDS_CTX_SZ;
+    r = amdgpu_bo_create_kernel(adev, size, PAGE_SIZE,
+                                AMDGPU_GEM_DOMAIN_GTT,
+                                &ctx->obj,
+                                &ctx->gpu_addr,
+                                &ctx->cpu_ptr);
+    if (r) {
+        DRM_ERROR("Failed to allocate ctx space bo for userqueue, err:%d\n", r);
+        return r;
+    }
+
+    queue->proc_ctx_gpu_addr = ctx->gpu_addr;
+    queue->gang_ctx_gpu_addr = queue->proc_ctx_gpu_addr + AMDGPU_USERQ_PROC_CTX_SZ;
+    queue->fw_ctx_gpu_addr = queue->gang_ctx_gpu_addr + AMDGPU_USERQ_GANG_CTX_SZ;
+    queue->gds_ctx_gpu_addr = queue->fw_ctx_gpu_addr + AMDGPU_USERQ_FW_CTX_SZ;
+    return 0;
+}
+
+static void amdgpu_userq_gfx_v11_destroy_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
+                                                   struct amdgpu_usermode_queue *queue)
+{
+    struct amdgpu_userq_ctx_space *ctx = &queue->fw_space;
+
+    amdgpu_bo_free_kernel(&ctx->obj,
+                          &ctx->gpu_addr,
+                          &ctx->cpu_ptr);
+}
+
 static int
 amdgpu_userq_gfx_v11_mqd_create(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
 {
@@ -43,10 +88,17 @@ amdgpu_userq_gfx_v11_mqd_create(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_u
     }
 
     memset(mqd->cpu_ptr, 0, size);
+
+    r = amdgpu_userq_gfx_v11_create_ctx_space(uq_mgr, queue);
+    if (r) {
+        DRM_ERROR("Failed to create CTX space for userqueue (%d)\n", r);
+        goto free_mqd;
+    }
+
     r = amdgpu_bo_reserve(mqd->obj, false);
     if (unlikely(r != 0)) {
         DRM_ERROR("Failed to reserve mqd for userqueue (%d)", r);
-        goto free_mqd;
+        goto free_ctx;
     }
 
     queue->userq_prop.use_doorbell = true;
@@ -55,12 +107,15 @@ amdgpu_userq_gfx_v11_mqd_create(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_u
     amdgpu_bo_unreserve(mqd->obj);
     if (r) {
         DRM_ERROR("Failed to init MQD for queue\n");
-        goto free_mqd;
+        goto free_ctx;
     }
 
     DRM_DEBUG_DRIVER("MQD for queue %d created\n", queue->queue_id);
     return 0;
 
+free_ctx:
+    amdgpu_userq_gfx_v11_destroy_ctx_space(uq_mgr, queue);
+
 free_mqd:
     amdgpu_bo_free_kernel(&mqd->obj,
 			   &mqd->gpu_addr,
@@ -73,6 +128,7 @@ amdgpu_userq_gfx_v11_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_
 {
     struct amdgpu_userq_ctx_space *mqd = &queue->mqd;
 
+    amdgpu_userq_gfx_v11_destroy_ctx_space(uq_mgr, queue);
     amdgpu_bo_free_kernel(&mqd->obj,
 			   &mqd->gpu_addr,
 			   &mqd->cpu_ptr);
diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
index 2911c88d0fed..8b62ef77cd26 100644
--- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
+++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
@@ -38,10 +38,17 @@ struct amdgpu_usermode_queue {
 	int queue_type;
 	uint64_t flags;
 	uint64_t doorbell_handle;
+	uint64_t proc_ctx_gpu_addr;
+	uint64_t gang_ctx_gpu_addr;
+	uint64_t gds_ctx_gpu_addr;
+	uint64_t fw_ctx_gpu_addr;
+	uint64_t shadow_ctx_gpu_addr;
+
 	struct amdgpu_vm *vm;
 	struct amdgpu_userq_mgr *userq_mgr;
 	struct amdgpu_mqd_prop userq_prop;
 	struct amdgpu_userq_ctx_space mqd;
+	struct amdgpu_userq_ctx_space fw_space;
 };
 
 struct amdgpu_userq_funcs {
-- 
2.40.0

