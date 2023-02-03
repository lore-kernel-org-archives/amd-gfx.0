Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D72FC61DA4
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Feb 2023 21:54:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E853110E91F;
	Fri,  3 Feb 2023 21:54:51 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA00F10E906
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Feb 2023 21:54:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZntcxKh8IzmwCwIhCzCyfO8VR6ckmQT2xPO9W6NWnSBFxQU5j4OSXK2cmLu+kM8pxIGt2fJrEtgEV43KJbhO1b/vP3wD4QQN28S6/tvsPsbcbIZ3+Dhepp2MAVOu4CWwCGDBeGAt3oqV0mG8FpSaseHmbC9ST4OCb6GYhuEx9lQmF5+ii4AK7ieJivSHMC8cAd+90GtgQ1xFglunf/6nnNhVeLaH0dAlgiXfy6hzWC6tpCiOTZ2hnuMrP+5W3bbfklWne9CIlLC2Oetxu4gQX57E74PSgxFh5zVfTfbIfSbkceHOQDsBYtks/0NEQPBQzxkqYhDIjvUtGspQn5qFFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ctV8FAIgA7JSmf0pC3HHwiioNV+09IuepDLKm1iT+EA=;
 b=K6y12soWTCGVZbv5jZ3xBaKqnpArSS3J/HPXQ0xpQG9mC25ZbR5qLx+u1nRTgQfRC3B7KJtSDgTOY56touKrDQpv/jRmJZrT1ACZBvN/yDSoNlFLhmINotMkZ2U3c0hoY/vGido/tYfzd/r/9qvi1Y1JGld0BEEqVGw9BngFaPXGIQ2NSkJbaxzt5MeO3GmiztVFCIT7AGD85QzwAbCmGrTLUeuYupBqVCL+Ig/o9SlxSWZIUtGDz8Hpz/e7xeW0Ibc/L92vEiNs7fJhuMlLq/Afh+ub3bcQ7d6b3mKqpFzF4DJsDcjxZPqgzeu0B72T86CpYli2tIzamBzh8SY0bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ctV8FAIgA7JSmf0pC3HHwiioNV+09IuepDLKm1iT+EA=;
 b=B4N2PWz9qc64vKBS1aAkCke+nN2RWmCF5JIthes/rO6gL87Cus1JYtjJeynV/ipAKTG4KO+ZS3Q2E7mf/AXKcjQt/2glmOzPgpwnFFaXim5ibVqpp94AnGafhv67BngNMvXZBKtFarjIwEKG1E7YpZPADDStKqg7yHthTcw1bLM=
Received: from CY5PR19CA0132.namprd19.prod.outlook.com (2603:10b6:930:64::29)
 by SA1PR12MB6773.namprd12.prod.outlook.com (2603:10b6:806:258::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Fri, 3 Feb
 2023 21:54:44 +0000
Received: from CY4PEPF0000C977.namprd02.prod.outlook.com
 (2603:10b6:930:64:cafe::ed) by CY5PR19CA0132.outlook.office365.com
 (2603:10b6:930:64::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31 via Frontend
 Transport; Fri, 3 Feb 2023 21:54:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C977.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.18 via Frontend Transport; Fri, 3 Feb 2023 21:54:43 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Feb
 2023 15:54:40 -0600
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/8] drm/amdgpu: Create context for usermode queue
Date: Fri, 3 Feb 2023 22:54:06 +0100
Message-ID: <20230203215409.2021-6-shashank.sharma@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C977:EE_|SA1PR12MB6773:EE_
X-MS-Office365-Filtering-Correlation-Id: 1612b7b1-cb86-4d62-c339-08db0631424d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X6G6sCmMgZQJiQQVYw9GCtc9Pc22VFGLhW/gyZXwnsdx1oY9dm0ONQXXA2HZ03n9+IGXs82ALK68ZsteS4HIqCrmFR9MLROZrqIE+FvilXeevGQh56jw4t0HtLaPPOfKqS5zmzD4WNtBGtWnk/A+yKBzPf2LdT+ROn9zrE6uYKEZ0zu6bQS4KPzMhOXedvQEeieJmylByZX9iLgQT7BaN5LrMB0VDxC+SUxe8cQ3kRe77GdqqJxILJsdIC2BkrHdToIWdmlfseXgHNq6d4bfUbq795g+JxLmfSWStUmdPa0vEoRNyoDKPur7TbaJ32X2e+EwNkyyhdO2YIskHMiDGXuUg7M/AQIon3cWzYzgA2va9S+SgH+CjpsjQKIQh5xhB3541CAV5uuP98tAT1QdyX1QB7Y3FLqeMh+/a5PGZykWSscogGPBsyPavK8B9DzJ7wt4tdTr3VCYDVKYoVQz6lYgyfakbqhE600HVXN2zCYJDm+qG1/Cr19DPom645JTdNMgIs+CjZvoK6O3xjuzPP8Frd1dRgbRq4gpUbqaotZXGNqiS5DNdir1IqgS6zbXp8TMcvYlOpGeisCALfRNxubXsSmC2QKHRju5sNflm81DoxRsw9rmDa10JhkOqgmnNgkibGLoQ1bSqflf63YLvWsfRZkO33rCFt1gtKOWOT0oYiO1dMSBb+XSOoA62a/fh+kZt07tGVxmk5WIkm2ji8D2hGnRU6bdS+hJwmdK2Eg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(396003)(136003)(39860400002)(376002)(451199018)(46966006)(36840700001)(40470700004)(8676002)(41300700001)(4326008)(83380400001)(6916009)(70586007)(70206006)(8936002)(81166007)(5660300002)(40460700003)(36756003)(186003)(26005)(16526019)(36860700001)(40480700001)(2906002)(356005)(426003)(54906003)(478600001)(6666004)(82740400003)(86362001)(316002)(336012)(44832011)(1076003)(47076005)(82310400005)(2616005)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 21:54:43.7519 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1612b7b1-cb86-4d62-c339-08db0631424d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C977.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6773
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The FW expects us to allocate atleast one page as context space to
process gang, process, shadow, GDS and FW_space related work. This
patch creates some object for the same, and adds an IP specific
functions to do this.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c |  32 +++++
 .../amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c | 121 ++++++++++++++++++
 .../gpu/drm/amd/include/amdgpu_userqueue.h    |  18 +++
 3 files changed, 171 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index 9f3490a91776..18281b3a51f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -42,6 +42,28 @@ static struct amdgpu_usermode_queue
     return idr_find(&uq_mgr->userq_idr, qid);
 }
 
+static void
+amdgpu_userqueue_destroy_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
+                                   struct amdgpu_usermode_queue *queue)
+{
+    uq_mgr->userq_mqd_funcs->ctx_destroy(uq_mgr, queue);
+}
+
+static int
+amdgpu_userqueue_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
+                                  struct amdgpu_usermode_queue *queue)
+{
+    int r;
+
+    r = uq_mgr->userq_mqd_funcs->ctx_create(uq_mgr, queue);
+    if (r) {
+        DRM_ERROR("Failed to create context space for queue\n");
+        return r;
+    }
+
+    return 0;
+}
+
 static int
 amdgpu_userqueue_create_mqd(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
 {
@@ -142,12 +164,21 @@ static int amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq
         goto free_qid;
     }
 
+    r = amdgpu_userqueue_create_ctx_space(uq_mgr, queue);
+    if (r) {
+        DRM_ERROR("Failed to create context space\n");
+        goto free_mqd;
+    }
+
     list_add_tail(&queue->userq_node, &uq_mgr->userq_list);
     args->out.q_id = queue->queue_id;
     args->out.flags = 0;
     mutex_unlock(&uq_mgr->userq_mutex);
     return 0;
 
+free_mqd:
+    amdgpu_userqueue_destroy_mqd(uq_mgr, queue);
+
 free_qid:
     amdgpu_userqueue_free_index(uq_mgr, queue->queue_id);
 
@@ -170,6 +201,7 @@ static void amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
     }
 
     mutex_lock(&uq_mgr->userq_mutex);
+    amdgpu_userqueue_destroy_ctx_space(uq_mgr, queue);
     amdgpu_userqueue_destroy_mqd(uq_mgr, queue);
     amdgpu_userqueue_free_index(uq_mgr, queue->queue_id);
     list_del(&queue->userq_node);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c
index 57889729d635..687f90a587e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c
@@ -120,6 +120,125 @@ amdgpu_userq_gfx_v11_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_
 
 }
 
+static int amdgpu_userq_gfx_v11_ctx_create(struct amdgpu_userq_mgr *uq_mgr,
+                                           struct amdgpu_usermode_queue *queue)
+{
+    int r;
+    struct amdgpu_device *adev = uq_mgr->adev;
+    struct amdgpu_userq_ctx *pctx = &queue->proc_ctx;
+    struct amdgpu_userq_ctx *gctx = &queue->gang_ctx;
+    struct amdgpu_userq_ctx *gdsctx = &queue->gds_ctx;
+    struct amdgpu_userq_ctx *fwctx = &queue->fw_ctx;
+    struct amdgpu_userq_ctx *sctx = &queue->shadow_ctx;
+
+    /*
+     * The FW expects atleast one page space allocated for
+     * process context related work, and one for gang context.
+     */
+    r = amdgpu_bo_create_kernel(adev, AMDGPU_USERQ_PROC_CTX_SZ, PAGE_SIZE,
+                                AMDGPU_GEM_DOMAIN_VRAM,
+                                &pctx->obj,
+                                &pctx->gpu_addr,
+                                &pctx->cpu_ptr);
+    if (r) {
+        DRM_ERROR("Failed to allocate proc bo for userqueue (%d)", r);
+        return r;
+    }
+
+    r = amdgpu_bo_create_kernel(adev, AMDGPU_USERQ_GANG_CTX_SZ, PAGE_SIZE,
+                                AMDGPU_GEM_DOMAIN_VRAM,
+                                &gctx->obj,
+                                &gctx->gpu_addr,
+                                &gctx->cpu_ptr);
+    if (r) {
+        DRM_ERROR("Failed to allocate gang bo for userqueue (%d)", r);
+        goto err_gangctx;
+    }
+
+    r = amdgpu_bo_create_kernel(adev, AMDGPU_USERQ_GDS_CTX_SZ, PAGE_SIZE,
+                                AMDGPU_GEM_DOMAIN_VRAM,
+                                &gdsctx->obj,
+                                &gdsctx->gpu_addr,
+                                &gdsctx->cpu_ptr);
+    if (r) {
+        DRM_ERROR("Failed to allocate GDS bo for userqueue (%d)", r);
+        goto err_gdsctx;
+    }
+
+    r = amdgpu_bo_create_kernel(adev, AMDGPU_USERQ_FW_CTX_SZ, PAGE_SIZE,
+                                AMDGPU_GEM_DOMAIN_VRAM,
+                                &fwctx->obj,
+                                &fwctx->gpu_addr,
+                                &fwctx->cpu_ptr);
+    if (r) {
+        DRM_ERROR("Failed to allocate FW bo for userqueue (%d)", r);
+        goto err_fwctx;
+    }
+
+    r = amdgpu_bo_create_kernel(adev, AMDGPU_USERQ_FW_CTX_SZ, PAGE_SIZE,
+                                AMDGPU_GEM_DOMAIN_VRAM,
+                                &sctx->obj,
+                                &sctx->gpu_addr,
+                                &sctx->cpu_ptr);
+    if (r) {
+        DRM_ERROR("Failed to allocate shadow bo for userqueue (%d)", r);
+        goto err_sctx;
+    }
+
+    return 0;
+
+err_sctx:
+    amdgpu_bo_free_kernel(&fwctx->obj,
+                          &fwctx->gpu_addr,
+                          &fwctx->cpu_ptr);
+
+err_fwctx:
+    amdgpu_bo_free_kernel(&gdsctx->obj,
+                          &gdsctx->gpu_addr,
+                          &gdsctx->cpu_ptr);
+
+err_gdsctx:
+    amdgpu_bo_free_kernel(&gctx->obj,
+                          &gctx->gpu_addr,
+                          &gctx->cpu_ptr);
+
+err_gangctx:
+    amdgpu_bo_free_kernel(&pctx->obj,
+                          &pctx->gpu_addr,
+                          &pctx->cpu_ptr);
+    return r;
+}
+
+static void amdgpu_userq_gfx_v11_ctx_destroy(struct amdgpu_userq_mgr *uq_mgr,
+                                            struct amdgpu_usermode_queue *queue)
+{
+    struct amdgpu_userq_ctx *pctx = &queue->proc_ctx;
+    struct amdgpu_userq_ctx *gctx = &queue->gang_ctx;
+    struct amdgpu_userq_ctx *gdsctx = &queue->gds_ctx;
+    struct amdgpu_userq_ctx *fwctx = &queue->fw_ctx;
+    struct amdgpu_userq_ctx *sctx = &queue->shadow_ctx;
+
+    amdgpu_bo_free_kernel(&sctx->obj,
+                          &sctx->gpu_addr,
+                          &sctx->cpu_ptr);
+
+    amdgpu_bo_free_kernel(&fwctx->obj,
+                          &fwctx->gpu_addr,
+                          &fwctx->cpu_ptr);
+
+    amdgpu_bo_free_kernel(&gdsctx->obj,
+                          &gdsctx->gpu_addr,
+                          &gdsctx->cpu_ptr);
+
+    amdgpu_bo_free_kernel(&gctx->obj,
+                          &gctx->gpu_addr,
+                          &gctx->cpu_ptr);
+
+    amdgpu_bo_free_kernel(&pctx->obj,
+                          &pctx->gpu_addr,
+                          &pctx->cpu_ptr);
+}
+
 static int amdgpu_userq_gfx_v11_mqd_size(struct amdgpu_userq_mgr *uq_mgr)
 {
     return sizeof(struct v11_gfx_mqd);
@@ -129,4 +248,6 @@ const struct amdgpu_userq_mqd_funcs userq_gfx_v11_mqd_funcs = {
     .mqd_size = amdgpu_userq_gfx_v11_mqd_size,
     .mqd_create = amdgpu_userq_gfx_v11_mqd_create,
     .mqd_destroy = amdgpu_userq_gfx_v11_mqd_destroy,
+    .ctx_create = amdgpu_userq_gfx_v11_ctx_create,
+    .ctx_destroy = amdgpu_userq_gfx_v11_ctx_destroy,
 };
diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
index a6abdfd5cb74..3adcd31618f7 100644
--- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
+++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
@@ -25,9 +25,19 @@
 #define AMDGPU_USERQUEUE_H_
 
 #define AMDGPU_MAX_USERQ 512
+#define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
+#define AMDGPU_USERQ_GANG_CTX_SZ PAGE_SIZE
+#define AMDGPU_USERQ_GDS_CTX_SZ PAGE_SIZE
+#define AMDGPU_USERQ_FW_CTX_SZ PAGE_SIZE
 
 struct amdgpu_userq_mqd_funcs;
 
+struct amdgpu_userq_ctx {
+	struct amdgpu_bo *obj;
+	uint64_t gpu_addr;
+	void	*cpu_ptr;
+};
+
 struct amdgpu_userq_mgr {
 	struct idr userq_idr;
 	struct mutex userq_mutex;
@@ -52,6 +62,12 @@ struct amdgpu_usermode_queue {
 	uint64_t	mqd_gpu_addr;
 	void 		*mqd_cpu_ptr;
 
+	struct amdgpu_userq_ctx	proc_ctx;
+	struct amdgpu_userq_ctx	gang_ctx;
+	struct amdgpu_userq_ctx	gds_ctx;
+	struct amdgpu_userq_ctx	fw_ctx;
+	struct amdgpu_userq_ctx	shadow_ctx;
+
 	struct amdgpu_bo	*mqd_obj;
 	struct amdgpu_vm    	*vm;
 	struct amdgpu_userq_mgr *userq_mgr;
@@ -64,6 +80,8 @@ struct amdgpu_userq_mqd_funcs {
 	int (*mqd_size)(struct amdgpu_userq_mgr *);
 	int (*mqd_create)(struct amdgpu_userq_mgr *, struct amdgpu_usermode_queue *);
 	void (*mqd_destroy)(struct amdgpu_userq_mgr *, struct amdgpu_usermode_queue *);
+	int (*ctx_create)(struct amdgpu_userq_mgr *, struct amdgpu_usermode_queue *);
+	void (*ctx_destroy)(struct amdgpu_userq_mgr *, struct amdgpu_usermode_queue *);
 };
 
 int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_device *adev);
-- 
2.34.1

