Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9070C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Dec 2022 19:37:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E788010E22A;
	Fri, 23 Dec 2022 19:37:38 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D58D010E227
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Dec 2022 19:37:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gUQa0MvyzCRj6FhXlip68L7vJ7PRF36JvlmjC1mooaOgB0pvt/5joo1V4E/mNQkwdLVL8hhZScEVozQ2Jta8PIsqBfpaF9DTwj6AM+7qui+hb0iPwkDbdXwZjwze1KEj1L9vZSMBwRjLCz7CRX626kelkDzNpVPbr4+OhOUMJ83aGSIHdVPiaCjkXYLZKTu2nGglixBDoY3ShyXRi2yWIAkNknIbpLzJrF8OllAD6VU/RguTGJdvZa/ZMO/hlkRZ4loC59FMV4/k5F6S5znviQR4+MfrN///SvLzbqA68dqCqKnMojd9XijCGHf/SXsWgtK+FPQqFwJfzSFvnBdYUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fw97ud8/xz+Ehvh03IWWgHj/2yNh9fHVt/+DtH3Ne3A=;
 b=eWyRNOzaQW+YRkaKYx6xY1yfB8IWJuSTrON6h5hQqabcMXAN2BOhV/CrJRH9b8XM51N2F1imhjCScfs8EFZP9PSNXnC0x+85QmlgAt3smcl5VvNhDIepl24ga86Q3v0o3ZjBoHphlpTN5ydHjI2U2E1S/2dfEtHHNLyBaDzp554UXltldjR0a+yVlbsh+t/amuQXWe7YmTA9zXdwvDYrvCLzHwfg1zrFW40HwRqUoCh5KSF+ZwFG8M5bq+tSVi2uEh/q37kac2arkEiA6FwqM2t7MiLHpPbYWgmZ2FJF2TDcE/pByjZlErPM0QwUY1x8ZGEuduF9dFrk8pE+xDMx+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fw97ud8/xz+Ehvh03IWWgHj/2yNh9fHVt/+DtH3Ne3A=;
 b=P2bE0tvBcr3NQ4uSrpG+hxtAMmX+nFbAD65E2FROQO5CG1dVvFpi9oLIHqlWJVouYar827/oXL7WRY7wwyakWyYn49R/J1i++8IuP1rNnArTrvJ0B06OIrc57eH63g+PTMdAzFneydmlbUII+RI4xEtVpTDSzp8PmLz3aZdaZlA=
Received: from MW4PR03CA0099.namprd03.prod.outlook.com (2603:10b6:303:b7::14)
 by CY5PR12MB6598.namprd12.prod.outlook.com (2603:10b6:930:42::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Fri, 23 Dec
 2022 19:37:33 +0000
Received: from CO1NAM11FT090.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::36) by MW4PR03CA0099.outlook.office365.com
 (2603:10b6:303:b7::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.14 via Frontend
 Transport; Fri, 23 Dec 2022 19:37:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT090.mail.protection.outlook.com (10.13.175.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.13 via Frontend Transport; Fri, 23 Dec 2022 19:37:32 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 23 Dec
 2022 13:37:30 -0600
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [RFC 5/7] drm/amdgpu: Create context for usermode queue
Date: Fri, 23 Dec 2022 20:36:53 +0100
Message-ID: <20221223193655.1972-6-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20221223193655.1972-1-shashank.sharma@amd.com>
References: <20221223193655.1972-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT090:EE_|CY5PR12MB6598:EE_
X-MS-Office365-Filtering-Correlation-Id: 6213e0d7-659c-4f1a-e141-08dae51d22f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vXP24SVZM+yzn/h+b8BioC8+PwEdL2cKrkD1xO+nZ9P+/of9DQ6SOLnabv1RjatwGy/HOEsE74HzjRnhbL/wOSG6iej8UMXWunvOeL1/2sC0/Fm/2BS5sBdy6JXE5cGj7rytkcRMmlZF2JPjBjXxum3PmyO7V1JUIjdOBpbOSzxHdV9ynKy3GBsLoI08yU2n54z74pdanCDUL80JKI2ieAnOSTASnBNLStyfMKF8CI0GXvmmo4N9Ytx/lpEKVk9F/T/CrLNkgAQP5zEIZHr5r7AR76syH7rOddj3qulrNWtopHJtrcXLefGWR9oPED4Rt0X8Nl9rsKLf8HxfgijAdkJ8DHBtRMr/RwTL6oDCnhjgZMHCCUrKAS5nR718COxZ9IZtde4sTrQsZu1KYBie8QL7OCE+RI++SDXlFNJKbdPuj6QikHXUCI+nNtaOUNHgYln4FrkUJfrxGzlYr3qeSh1R0V7b4wnOYi5ooyN+orIJ5RujNF8DuuU1wd1f9TRq2bhpGTyF0jDEgU8iv8viRKZDUIyeYa9BnFhZWvq5rlAFn4w3Y8G2/oBlC5Okn471gaXdh7flUv90I1rtL+BapWueVwlPPhkgk0KvbY0fRtcJzaaSM6/VM/Bgj/q9i8i9FXLlC655lWc+xHyV0jyP6ATcRNBGshu+c4OE20ijOFu4H3VlEE6sfXg1/k3D7IfklgPlK0jvw4DHZFVcftkmwMuTWqe8MesZnlz3wov4PZs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199015)(46966006)(36840700001)(40470700004)(2906002)(316002)(36860700001)(82740400003)(40460700003)(36756003)(40480700001)(82310400005)(356005)(81166007)(86362001)(336012)(16526019)(83380400001)(6916009)(478600001)(54906003)(2616005)(426003)(1076003)(5660300002)(70206006)(6666004)(26005)(44832011)(70586007)(8676002)(41300700001)(7696005)(186003)(4326008)(47076005)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2022 19:37:32.8070 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6213e0d7-659c-4f1a-e141-08dae51d22f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT090.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6598
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
 Shashank Sharma <shashank.sharma@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, arvind.yadav@amd.com,
 arunpravin.paneerselvam@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The FW expects us to allocate atleast one page as process
context space, and one for gang context space. This patch adds some
object for the same.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>

Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 57 +++++++++++++++++++
 .../drm/amd/include/amdgpu_usermode_queue.h   |  8 +++
 2 files changed, 65 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index b566ce4cb7f0..2a854a5e2f70 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -69,6 +69,56 @@ amdgpu_userqueue_get_doorbell(struct amdgpu_device *adev,
     return 0;
 }
 
+static int
+amdgpu_userqueue_create_context(struct amdgpu_device *adev, struct amdgpu_usermode_queue *queue)
+{
+    int r;
+    struct amdgpu_userq_ctx *pctx = &queue->proc_ctx;
+    struct amdgpu_userq_ctx *gctx = &queue->gang_ctx;
+    /*
+     * The FW expects atleast one page space allocated for
+     * process context related work, and one for gang context.
+     */
+    r = amdgpu_bo_create_kernel(adev, PAGE_SIZE, PAGE_SIZE,
+                                AMDGPU_GEM_DOMAIN_VRAM,
+                                &pctx->obj,
+                                &pctx->gpu_addr,
+                                &pctx->cpu_ptr);
+    if (r) {
+        DRM_ERROR("Failed to allocate proc bo for userqueue (%d)", r);
+        return r;
+    }
+
+    r = amdgpu_bo_create_kernel(adev, PAGE_SIZE, PAGE_SIZE,
+                                AMDGPU_GEM_DOMAIN_VRAM,
+                                &gctx->obj,
+                                &gctx->gpu_addr,
+                                &gctx->cpu_ptr);
+    if (r) {
+        DRM_ERROR("Failed to allocate proc bo for userqueue (%d)", r);
+        amdgpu_bo_free_kernel(&pctx->obj,
+                              &pctx->gpu_addr,
+                              &pctx->cpu_ptr);
+        return r;
+    }
+
+    return 0;
+}
+
+static void
+amdgpu_userqueue_free_context(struct amdgpu_device *adev, struct amdgpu_usermode_queue *queue)
+{
+    struct amdgpu_userq_ctx *pctx = &queue->proc_ctx;
+    struct amdgpu_userq_ctx *gctx = &queue->gang_ctx;
+
+    amdgpu_bo_free_kernel(&pctx->obj,
+                          &pctx->gpu_addr,
+                          &pctx->cpu_ptr);
+    amdgpu_bo_free_kernel(&pctx->obj,
+                          &gctx->gpu_addr,
+                          &gctx->cpu_ptr);
+}
+
 static void
 amdgpu_userqueue_setup_mqd(struct amdgpu_device *adev, struct amdgpu_usermode_queue *queue)
 {
@@ -282,6 +332,12 @@ int amdgpu_userqueue_create(struct amdgpu_device *adev, struct drm_file *filp,
         goto free_mqd;
     }
 
+    r = amdgpu_userqueue_create_context(adev, queue);
+    if (r < 0) {
+        DRM_ERROR("Failed to create context for queue\n");
+        goto free_mqd;
+    }
+
     ctx->userq = queue;
     args->out.q_id = queue->queue_id;
     args->out.flags = 0;
@@ -306,6 +362,7 @@ void amdgpu_userqueue_destroy(struct amdgpu_device *adev, struct drm_file *filp,
     struct amdgpu_usermode_queue *queue = ctx->userq;
 
     mutex_lock(&adev->userq.userq_mutex);
+    amdgpu_userqueue_free_context(adev, queue);
     amdgpu_userqueue_destroy_mqd(queue);
     amdgpu_userqueue_remove_index(adev, queue);
     ctx->userq = NULL;
diff --git a/drivers/gpu/drm/amd/include/amdgpu_usermode_queue.h b/drivers/gpu/drm/amd/include/amdgpu_usermode_queue.h
index c1fe39ffaf72..8bf3c0be6937 100644
--- a/drivers/gpu/drm/amd/include/amdgpu_usermode_queue.h
+++ b/drivers/gpu/drm/amd/include/amdgpu_usermode_queue.h
@@ -26,6 +26,12 @@
 
 #define AMDGPU_MAX_USERQ 512
 
+struct amdgpu_userq_ctx {
+	struct amdgpu_bo *obj;
+	uint64_t gpu_addr;
+	void	*cpu_ptr;
+};
+
 struct amdgpu_usermode_queue {
 	int		queue_id;
 	int		queue_type;
@@ -44,6 +50,8 @@ struct amdgpu_usermode_queue {
 
 	struct amdgpu_bo	*mqd_obj;
 	struct amdgpu_vm    	*vm;
+	struct amdgpu_userq_ctx proc_ctx;
+	struct amdgpu_userq_ctx gang_ctx;
 	struct list_head 	list;
 };
 
-- 
2.34.1

