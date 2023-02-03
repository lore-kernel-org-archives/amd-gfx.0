Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37B5CC61DA4
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Feb 2023 21:54:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE0A710E906;
	Fri,  3 Feb 2023 21:54:47 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DABC210E906
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Feb 2023 21:54:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dd2pfF9+sDllB3h0u7l68N/VXhtAX39g3CtXLG0BXQ7xDgnPn6pf2mhGeJVHWzbfqoE1/ai87krpTSXuC8EPUrypcanC+x8fHu773mBPQsndz4ho2JFA9bJ8fwfn/cFfVPo0FXyLJTqbsgHqDL8yosipqM5dvqQ7WlcwqqApVfpYyf2jCL4rDvF1+ujFr85sEARLneQRhF3aUJW6FSFhGTk7K/1bu1PQi92cqNyhoVZovrg92VrJp+9K3aqAza7aokN2Os4t79jtRP4Fbzl7wQCyQCMG1mDRGXh1id3m/9LopwwB0ALofdLYa06OYOKYdB+EzubH4ViMEuhXCz/1eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eYHzn8uNth22uYH8Uj/TxLh0xdWEl844GiCLqQBrKgY=;
 b=Cq1iWc125OZKoLnOryUqut1b5TxKAYSqPc1nEqwJTg95PX2RK4fjMj0ZgUUKiK/Y3SZ3M0+qLiSf4pywuw26vU8sYSkNr5PSCZaYBl6AUYnx524QaM6SX/bllO+SBDKJJQNvf+jruWqxAB5xUnwMky/DLiqOfhapf/91rlMkTxB3Hnye7792ix7sVEIZrN0In+4zMookhKHUlajGcosDSUYB/zXh/B9JcwJTuPCGOQtNH6VZjJW26WjFjzoTHvOLaHDYBbtS328Xr/mANsjwAE+cwxqBvFjb+eIH6mwVrzGqny7rVjq/LaKtejNTK0kCudJEnwcZIxKc0dTDH9SoOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eYHzn8uNth22uYH8Uj/TxLh0xdWEl844GiCLqQBrKgY=;
 b=3X9mRgO+Ky+uKVnvwilabW5h9JF7HjgXaCiCOSsXCgfcfSVjQasph9gvCZhWb/sIUfRQKDHsGXLpFv2d/U5tRowVE35vt2wNKF+CioPzo6CwUBkFH1ct7XBnzqpmlgMRw6hzGjj1w624sgplCTpo4Oo9wBP8aGJkGLQ7YQS0YIY=
Received: from CY5PR19CA0132.namprd19.prod.outlook.com (2603:10b6:930:64::29)
 by BN9PR12MB5383.namprd12.prod.outlook.com (2603:10b6:408:104::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Fri, 3 Feb
 2023 21:54:42 +0000
Received: from CY4PEPF0000C977.namprd02.prod.outlook.com
 (2603:10b6:930:64:cafe::ed) by CY5PR19CA0132.outlook.office365.com
 (2603:10b6:930:64::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31 via Frontend
 Transport; Fri, 3 Feb 2023 21:54:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C977.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.18 via Frontend Transport; Fri, 3 Feb 2023 21:54:41 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Feb
 2023 15:54:37 -0600
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/8] drm/amdgpu: introduce userqueue MQD handlers
Date: Fri, 3 Feb 2023 22:54:04 +0100
Message-ID: <20230203215409.2021-4-shashank.sharma@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C977:EE_|BN9PR12MB5383:EE_
X-MS-Office365-Filtering-Correlation-Id: d8ec6aeb-659c-4d97-3498-08db063140fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ry78RQfx+p+oKXKk4WqitT07oeVRmA7zfesidbOpQ5UdWSor7Mo44n+Ts12TW80mBBYI2p0HvnHZU5RUVt3xQZwjdkhlednica3zzQDfUPArFfQcJPTQwtx3enKl0odujeg38kj0Y2JxOJaZ7DiI/lvbVTLPhvl3pZfe4SyRpkZOT6GPkaBB2vcR1gc/h+ngrOkBjFt84eM9HcxDSko3+SsN1B7CovvYfsLRENaDIxkjvRGXODa4emAB1WdJId7mELR1O8k0nSXPw32RW1TOi9XiOzEjdXxvWCcGHVMBFFQ00TqQfobgfk49k+k49JN9zYvaHtL77bXKQm1dspPZ5Q6mGiHTP1CywoXVuYn6bxmkJiIYE4uVCkFCNhJjlG90+N423Pfv4NZVyrrvP6Lv9ERM4dgR7cNDRy2S9U9t9fD4Zi+rErBodnhnCUe/cXYDqAPHohb/eGCa3/iUTILG3zzqqyysNmMzLFcKDzSDZZ3D1BxdwnQ54ZmBAbmwrMg+VdYf9zCfzGk0TolSKehrHyzD4rqbe2nKhSbpw5mQRboJBXcOP0kdsLyZ6amHP5Uo8ua+1Jg5qMh8V5pNEinpr+NNERxbTEWeMG8GSspyyzrM5LmDjWsid8a9s5hWOJi6eKPxu9KLVzXCyhCFH0LWe3zTSIW+UQFW6wwvdG433k8MphnedAigCNzM+axgR2aZjVJekK/78jCPvmMZsUTPaInaysEB04TdFwtIJKX93T8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(396003)(39860400002)(136003)(346002)(451199018)(36840700001)(40470700004)(46966006)(356005)(81166007)(40480700001)(336012)(47076005)(2616005)(426003)(83380400001)(82740400003)(40460700003)(36860700001)(8676002)(70586007)(6916009)(70206006)(44832011)(8936002)(41300700001)(5660300002)(2906002)(4326008)(86362001)(7696005)(478600001)(26005)(54906003)(6666004)(82310400005)(316002)(186003)(1076003)(36756003)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 21:54:41.5332 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8ec6aeb-659c-4d97-3498-08db063140fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C977.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5383
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

A Memory queue descriptor (MQD) of a userqueue defines it in the harware's
context. As the method of formation of a MQD, and its format can vary between
different graphics IPs, we need gfx GEN specific handlers to create MQDs.

This patch:
- Introduces MQD hander functions for the usermode queues
- A general function to create and destroy MQD for a userqueue.

V1: Worked on review comments from Alex on RFC patches:
    MQD creation should be gen and IP specific.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <contactshashanksharma@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 64 +++++++++++++++++++
 .../gpu/drm/amd/include/amdgpu_userqueue.h    |  9 +++
 2 files changed, 73 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index d5bc7fe81750..625c2fe1e84a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -42,6 +42,60 @@ static struct amdgpu_usermode_queue
     return idr_find(&uq_mgr->userq_idr, qid);
 }
 
+static int
+amdgpu_userqueue_create_mqd(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
+{
+    int r;
+    int size;
+    struct amdgpu_device *adev = uq_mgr->adev;
+
+    if (!uq_mgr->userq_mqd_funcs) {
+        DRM_ERROR("Userqueue not initialized\n");
+        return -EINVAL;
+    }
+
+    size = uq_mgr->userq_mqd_funcs->mqd_size(uq_mgr);
+    r = amdgpu_bo_create_kernel(adev, size, PAGE_SIZE,
+                                AMDGPU_GEM_DOMAIN_VRAM,
+                                &queue->mqd_obj,
+                                &queue->mqd_gpu_addr,
+                                &queue->mqd_cpu_ptr);
+    if (r) {
+        DRM_ERROR("Failed to allocate bo for userqueue (%d)", r);
+        return r;
+    }
+
+    memset(queue->mqd_cpu_ptr, 0, size);
+    r = amdgpu_bo_reserve(queue->mqd_obj, false);
+    if (unlikely(r != 0)) {
+        DRM_ERROR("Failed to reserve mqd for userqueue (%d)", r);
+        goto free_mqd;
+    }
+
+    r = uq_mgr->userq_mqd_funcs->mqd_create(uq_mgr, queue);
+    amdgpu_bo_unreserve(queue->mqd_obj);
+    if (r) {
+        DRM_ERROR("Failed to create MQD for queue\n");
+        goto free_mqd;
+    }
+    return 0;
+
+free_mqd:
+    amdgpu_bo_free_kernel(&queue->mqd_obj,
+			   &queue->mqd_gpu_addr,
+			   &queue->mqd_cpu_ptr);
+   return r;
+}
+
+static void
+amdgpu_userqueue_destroy_mqd(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
+{
+    uq_mgr->userq_mqd_funcs->mqd_destroy(uq_mgr, queue);
+    amdgpu_bo_free_kernel(&queue->mqd_obj,
+			   &queue->mqd_gpu_addr,
+			   &queue->mqd_cpu_ptr);
+}
+
 static int amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 {
     int r, pasid;
@@ -82,12 +136,21 @@ static int amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq
         goto free_queue;
     }
 
+    r = amdgpu_userqueue_create_mqd(uq_mgr, queue);
+    if (r) {
+        DRM_ERROR("Failed to create MQD\n");
+        goto free_qid;
+    }
+
     list_add_tail(&queue->userq_node, &uq_mgr->userq_list);
     args->out.q_id = queue->queue_id;
     args->out.flags = 0;
     mutex_unlock(&uq_mgr->userq_mutex);
     return 0;
 
+free_qid:
+    amdgpu_userqueue_free_index(uq_mgr, queue->queue_id);
+
 free_queue:
     mutex_unlock(&uq_mgr->userq_mutex);
     kfree(queue);
@@ -107,6 +170,7 @@ static void amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
     }
 
     mutex_lock(&uq_mgr->userq_mutex);
+    amdgpu_userqueue_destroy_mqd(uq_mgr, queue);
     amdgpu_userqueue_free_index(uq_mgr, queue->queue_id);
     list_del(&queue->userq_node);
     mutex_unlock(&uq_mgr->userq_mutex);
diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
index 9557588fe34f..a6abdfd5cb74 100644
--- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
+++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
@@ -26,10 +26,13 @@
 
 #define AMDGPU_MAX_USERQ 512
 
+struct amdgpu_userq_mqd_funcs;
+
 struct amdgpu_userq_mgr {
 	struct idr userq_idr;
 	struct mutex userq_mutex;
 	struct list_head userq_list;
+	const struct amdgpu_userq_mqd_funcs *userq_mqd_funcs;
 	struct amdgpu_device *adev;
 };
 
@@ -57,6 +60,12 @@ struct amdgpu_usermode_queue {
 
 int amdgpu_userq_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
 
+struct amdgpu_userq_mqd_funcs {
+	int (*mqd_size)(struct amdgpu_userq_mgr *);
+	int (*mqd_create)(struct amdgpu_userq_mgr *, struct amdgpu_usermode_queue *);
+	void (*mqd_destroy)(struct amdgpu_userq_mgr *, struct amdgpu_usermode_queue *);
+};
+
 int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_device *adev);
 
 void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr);
-- 
2.34.1

