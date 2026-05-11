Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2219CD37BE
	for <amd-gfx@archiver.kernel.org>; Mon, 11 May 2026 13:54:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 419AB10E757;
	Mon, 11 May 2026 13:54:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L2/mzJVz";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013059.outbound.protection.outlook.com
 [40.93.196.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87D5C10E75A
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 May 2026 13:54:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x8S0oPv71c71CnFO7EAgongVXPGWIhqdnChLI9sO8n4R38WyypcfpJJAJ/gMa4gyZWu0MAwUxxZNfgQn/fj45SMiWCJ8yDf+7tJsH+tWUN6nAjlk5I8zj49bwgsKuKSJ7yMfPdNu6NkWu9ZMlFOyuC07zceDBEZUoNOO5oBtD3aClNddKVcciWfCO/FNlwGikwzPvb86Y1QlsEPI2V7Unvznn1M0ykQPYTD10xy7dH8kIj3+47+LjKMm733IaVRJ3A1ViHE02L8C7vHrczpeIEqkL1XZASCyll6taz8nb/QxQg7iTL0uMXrV3x+/7aenYVReh28P5u53gE4obsfPcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4uOk1aBHSfJhC/HrOosmd0p6Dt4ZuLucp591FVu3A2E=;
 b=VnfnTC8pHh3WNGoe5cXd6N9ViZkoDsCn/Qw7T50sx4eC5lI0g2qxZRX/sg+tQQgx2+dQtnsE5/zQYu6MsC1l+qo9dPAroDUL9s7fF82rnZaFPtbFqQwkF1YoS3wAPIjVrt92vZqjS3nioGNv6rNYiZYtN5Qr/qliBe7lkDRKhqMfNo0wCpys+YRWkl/JoQNb/Jm5uA0w5vWeXrpUVbc5mVUnGMUrD3FtUKJFYFFGmAu/5XGqL+ZletVLSIOADvi/pajfzqq1/j5PwGxpmf5SyXEPO41tI4GZVZ/lq7kgFIqntD5iEnHq7AKvoNtbtV9slscEi/IuRE/SCYwDyiN6KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4uOk1aBHSfJhC/HrOosmd0p6Dt4ZuLucp591FVu3A2E=;
 b=L2/mzJVz3jGLLTFEcizXLWa00A9qo/TwhX5kP5jilv0hRBTzsSuQqj1c6RC2RcABDF/ZmarXtTNMheTxILeGDa8d4KsKqj0fKec4pCZm1LFu7avCMRukEIMO77vF8bJRAuzsDdycgp59EwmiloO51qW/0x383KoSTM+0sZxHJPs=
Received: from BLAPR03CA0151.namprd03.prod.outlook.com (2603:10b6:208:32f::15)
 by SN7PR12MB7300.namprd12.prod.outlook.com (2603:10b6:806:298::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Mon, 11 May
 2026 13:54:47 +0000
Received: from BL6PEPF0002256E.namprd02.prod.outlook.com
 (2603:10b6:208:32f:cafe::16) by BLAPR03CA0151.outlook.office365.com
 (2603:10b6:208:32f::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Mon,
 11 May 2026 13:54:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0002256E.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Mon, 11 May 2026 13:54:46 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 11 May
 2026 08:54:45 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH 1/4] drm/amdgpu: add userq create and destroy tracepoints
Date: Mon, 11 May 2026 21:54:32 +0800
Message-ID: <20260511135435.3818345-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256E:EE_|SN7PR12MB7300:EE_
X-MS-Office365-Filtering-Correlation-Id: 25ccfeb6-2041-424d-45b5-08deaf64dcbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|11063799003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: uJsfEDhYI2Ymz/XcNOUyCkNG/IjQkzf/gRQoeZVa5KTTo6J1OLJ4pAdNtwJnL327SkCFgC0hH9TC+wsGPeZMNX2s3FTZVDyKcu8zJjNLTQj1bZaPaCYSI6jmHFycfFwyKCbsOy6AJo1hXTWGNu9j7MO7wjiYxFQ9uun37TbgP5rtRoCE+U5ioR4op9CUg1dWIuNSpmCCb7a/XRXA1T6M4KllFSzsYBCgtxfRawgZ240t0TZqZdpAcmqH2sTDZbuyaGVdALlWTx4ngG0gxYDbW8w+a/Ei37F/q8mhQE9xm6u6zQG9/MNhGp2AQblzj8lRGCVdg0CkM4+MVdfnwOwGxX82KWzxb6UUYgthnRm3Gol3trkz8mGPc0wVz3Pspw8Xt8gp4La2z0M1U0hN//ci/933WPq++CkG1+YJsy3dSdaejib2V7Yz62A9uASTbmdeo4Wp3wy6oDvJP68JFGyCBvVnV1MOpx9qBZc0s6HR12p1NCRRoiR7uNKUzg82N0aMbZYr0KwmgjZuzSjv6jGbgtnbhV5MyEQR7mTLLtjZmTqCwUT5yfSEU5vh4HJzt3U4z6v8mvq9uWxGmuKruVcmVlUWwcNDNkm9PguMpd2V4SDX4qj8locOnulFVJb1oEvfNqMqaOtpjIjues/X+1G9VL1Hsv1tU69x2PhYsqqE94iVWaKT0onk3Ii/EOPC7crewXnrvRKx3bgRDnMKctzgq3YZLZ/m007gXnAgfY6v9vM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(11063799003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XAQg46PXWh5H/iKcj3FZACOYHOfRqMYdW0YAxqsRr8pTd+meGVMIrfMDN4ah/oKebNQUq9R0QhuymyEWQKZ+tc9M3bZ0kXfucT1tem3cPwzRX9yMO4HK4k3yc7cd2EE49IZEfQ9ECGzEdY+fQflkgXRtj4ZnEbbITZOXb3qMtrcmM0CgWXys6N6HC93HOosuo3DaKB8ZVJ4weQqbGOJJqu9/YRgW9CAfjHwyNiR7rJXULt7+3XAEna1FSBhCabmcJttoNpXFtqxVNEHCVH3lzu7v/KFPeKsXJioJhmtigZP5Jlh+sBiU+t0QDSPNinpt/RTb98dBAz8FA8YTMKBRsW6MNXCahmNlyDhNjPQ71gQcaK36FSQn5w58rGuejOPmnJbZLI6yFDzBbWd5+81bZEboJm9oXNRyJd0lCU9Z21wz1fm4Z06GgbpKzmMsYsP8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 13:54:46.7742 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25ccfeb6-2041-424d-45b5-08deaf64dcbd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7300
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add ftrace events around user queue creation and destruction to profile
queue setup and teardown latency.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h | 58 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 11 +++++
 2 files changed, 69 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
index d13e64a69e25..5a01f63d1f32 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
@@ -578,6 +578,64 @@ TRACE_EVENT(amdgpu_reset_reg_dumps,
 		      __entry->value)
 );
 
+DECLARE_EVENT_CLASS(amdgpu_userq_queue,
+	    TP_PROTO(struct amdgpu_usermode_queue *queue),
+	    TP_ARGS(queue),
+	    TP_STRUCT__entry(
+			     __field(struct amdgpu_usermode_queue *, queue)
+			     __field(u64, doorbell_index)
+			     __field(int, queue_type)
+			     __field(int, state)
+			     __field(u32, xcp_id)
+			     ),
+	    TP_fast_assign(
+			   __entry->queue = queue;
+			   __entry->doorbell_index = queue ? queue->doorbell_index : 0;
+			   __entry->queue_type = queue ? queue->queue_type : -1;
+			   __entry->state = queue ? queue->state : -1;
+			   __entry->xcp_id = queue ? queue->xcp_id : 0;
+			   ),
+	    TP_printk("queue=%p, doorbell=%llu, type=%d, state=%d, xcp_id=%u",
+		      __entry->queue, __entry->doorbell_index,
+		      __entry->queue_type, __entry->state, __entry->xcp_id)
+);
+DEFINE_EVENT(amdgpu_userq_queue, amdgpu_userq_create_start,
+	     TP_PROTO(struct amdgpu_usermode_queue *queue),
+	     TP_ARGS(queue));
+DEFINE_EVENT(amdgpu_userq_queue, amdgpu_userq_destroy_start,
+	     TP_PROTO(struct amdgpu_usermode_queue *queue),
+	     TP_ARGS(queue));
+DECLARE_EVENT_CLASS(amdgpu_userq_queue_result,
+	    TP_PROTO(struct amdgpu_usermode_queue *queue, int result),
+	    TP_ARGS(queue, result),
+	    TP_STRUCT__entry(
+			     __field(struct amdgpu_usermode_queue *, queue)
+			     __field(u64, doorbell_index)
+			     __field(int, queue_type)
+			     __field(int, state)
+			     __field(u32, xcp_id)
+			     __field(int, result)
+			     ),
+	    TP_fast_assign(
+			   __entry->queue = queue;
+			   __entry->doorbell_index = queue ? queue->doorbell_index : 0;
+			   __entry->queue_type = queue ? queue->queue_type : -1;
+			   __entry->state = queue ? queue->state : -1;
+			   __entry->xcp_id = queue ? queue->xcp_id : 0;
+			   __entry->result = result;
+			   ),
+	    TP_printk("queue=%p, doorbell=%llu, type=%d, state=%d, xcp_id=%u, result=%d",
+		      __entry->queue, __entry->doorbell_index,
+		      __entry->queue_type, __entry->state,
+		      __entry->xcp_id, __entry->result)
+);
+DEFINE_EVENT(amdgpu_userq_queue_result, amdgpu_userq_create_end,
+	     TP_PROTO(struct amdgpu_usermode_queue *queue, int result),
+	     TP_ARGS(queue, result));
+DEFINE_EVENT(amdgpu_userq_queue_result, amdgpu_userq_destroy_end,
+	     TP_PROTO(struct amdgpu_usermode_queue *queue, int result),
+	     TP_ARGS(queue, result));
+
 #undef AMDGPU_JOB_GET_TIMELINE_NAME
 #endif
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 3077ca4e27a0..50c46d31fbae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -33,6 +33,7 @@
 #include "amdgpu_userq.h"
 #include "amdgpu_hmm.h"
 #include "amdgpu_userq_fence.h"
+#include "amdgpu_trace.h"
 
 u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
 {
@@ -617,6 +618,8 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
 
 	int r = 0;
 
+	trace_amdgpu_userq_destroy_start(queue);
+
 	cancel_delayed_work_sync(&uq_mgr->resume_work);
 
 	/* Cancel any pending hang detection work and cleanup */
@@ -625,6 +628,7 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
 	r = amdgpu_bo_reserve(vm->root.bo, false);
 	if (r) {
 		drm_file_err(uq_mgr->file, "Failed to reserve root bo during userqueue destroy\n");
+		trace_amdgpu_userq_destroy_end(queue, r);
 		return r;
 	}
 	amdgpu_userq_buffer_vas_list_cleanup(adev, queue);
@@ -650,6 +654,7 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
 	amdgpu_bo_unpin(queue->wptr_obj.obj);
 	amdgpu_bo_unreserve(queue->wptr_obj.obj);
 	amdgpu_bo_unref(&queue->wptr_obj.obj);
+	trace_amdgpu_userq_destroy_end(queue, r);
 	kfree(queue);
 
 	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
@@ -754,6 +759,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 
 	mutex_init(&queue->fence_drv_lock);
 	xa_init_flags(&queue->fence_drv_xa, XA_FLAGS_ALLOC);
+	trace_amdgpu_userq_create_start(queue);
 	r = amdgpu_userq_fence_driver_alloc(adev, &queue->fence_drv);
 	if (r)
 		goto free_queue;
@@ -809,6 +815,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		 * This drops the extra and last reference which should take
 		 * care of all cleanup.
 		 */
+		trace_amdgpu_userq_create_end(queue, r);
 		amdgpu_userq_put(queue);
 		amdgpu_userq_put(queue);
 		return r;
@@ -826,6 +833,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		r = amdgpu_userq_map_helper(queue);
 		if (r) {
 			drm_file_err(uq_mgr->file, "Failed to map Queue\n");
+			trace_amdgpu_userq_create_end(queue, r);
 			mutex_unlock(&uq_mgr->userq_mutex);
 			/* Prevent racing with close */
 			if (xa_erase(&uq_mgr->userq_xa, qid) == queue)
@@ -839,6 +847,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	atomic_inc(&uq_mgr->userq_count[queue->queue_type]);
 
 	amdgpu_debugfs_userq_init(filp, queue, qid);
+	trace_amdgpu_userq_create_end(queue, 0);
 	amdgpu_userq_put(queue);
 	args->out.queue_id = qid;
 	return 0;
@@ -853,6 +862,8 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 free_fence_drv:
 	amdgpu_userq_fence_driver_free(queue);
 free_queue:
+	if (queue)
+		trace_amdgpu_userq_create_end(queue, r);
 	kfree(queue);
 err_pm_runtime:
 	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
-- 
2.34.1

