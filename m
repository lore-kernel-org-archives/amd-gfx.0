Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4F20CD98CE
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jun 2026 06:42:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5857110F28F;
	Fri, 12 Jun 2026 06:42:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RXAcakqx";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012048.outbound.protection.outlook.com [52.101.53.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05F5010F28C
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 06:42:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W7G8IBGnuFgDmRF1r0vZVH140jDsSnih9p5KNs2eHaspttiNosnhcVWrWlFATsK/O/xZXcIMcdj4cDj5tJ6bfV09luzufIJQSKtP8xE7jo01/7YYeHBvihOnOv6ow0LKFG5QahtqeWyO4nL7uvc+bQQ2t/4Pj6MkfO01jFvZkeGashGXw0ZHDrnvguF3IAGumhf6sV8N3CMKxF55q/disIYV0/jVzFds+RXGgxNQ5Aw1bhlGbDq1FI+YpLZF5zE8kTK1y/QrHCkdFul78DQWAUFMr9bCxZc3loo1J60UlKH7rS+pe7kX7L7pqrLD1Lv26QiLgUEHP9YvJtUuknJPqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vqF1VINK33ejDrPTiQ7V0jffig2Lpc0KOZXPgO5kBoA=;
 b=udegSxxmMaNpJjIQO6MBzi1ekzcflPBsE5SFPWQ8X46v/BYtmygPexxYnJ2qI3U14YiXojKBMv1oYWUTT7wNgwt+deAtGo3YPYuCpTHUax1hmpyTjv9fkF+lQPLL2WAsQfwvzupPNuAoKZSkYFhmWZDtfSpdi7k1WYdOgWw6p3gMW0iDHVHo9IQZxk4noZhsgpZVIauqQ3LRzbZYcG1AGtrlpxAnnIk3SRW3a71mGndtfmHCcry5gAdbglCQxHt7LF92D0T/E75eXSkb+ZoVkJS+Pm7PsEqB5bHecrQjiot0bCgYicReR8Y6h4Mbgvw1R8nyF9NpV2ufzzNO0Y63kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vqF1VINK33ejDrPTiQ7V0jffig2Lpc0KOZXPgO5kBoA=;
 b=RXAcakqxEJh7xM6OKNU/9uBI2JjH8mHZ8ZBrKHR042tDefl8z71Giw4VVUJeWT0Md8GBLJb1BG9YmtdVgKBGjOrVJMiLzla4VdxG2ald/8enAb6rfT8vBKUWYFpiD95RHp+6mheQSFSQt7wNWYRhffMYolALJ0AfKBq2ZXL8r28=
Received: from CH2PR04CA0022.namprd04.prod.outlook.com (2603:10b6:610:52::32)
 by SN7PR12MB6715.namprd12.prod.outlook.com (2603:10b6:806:271::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 06:42:36 +0000
Received: from CH1PEPF0000AD82.namprd04.prod.outlook.com
 (2603:10b6:610:52:cafe::92) by CH2PR04CA0022.outlook.office365.com
 (2603:10b6:610:52::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.15 via Frontend Transport; Fri,
 12 Jun 2026 06:42:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD82.mail.protection.outlook.com (10.167.244.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Fri, 12 Jun 2026 06:42:35 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 12 Jun
 2026 01:42:34 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Pierre-eric.Pelloux-prayer@amd.com>, Prike Liang <Prike.Liang@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH v3 2/3] drm/amdgpu: add userq create and destroy tracepoints
Date: Fri, 12 Jun 2026 14:42:22 +0800
Message-ID: <20260612064223.196556-2-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260612064223.196556-1-Prike.Liang@amd.com>
References: <20260612064223.196556-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD82:EE_|SN7PR12MB6715:EE_
X-MS-Office365-Filtering-Correlation-Id: dcb3e4a6-f619-4b5a-9b5d-08dec84dc9f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|1800799024|82310400026|376014|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Gre+YWHbvvrfJDCFmKR/yjHoDs4c9Y0NU61GhmGQ4VFQFcRcEBpBy2ny8iVFg3N8l++dH/+K5wS2QZgm/ABrwui2nID7CHZ4gVUU4BDTq1NPEKnBKayx1R5Jj3MLWOXWDzwSOai+Qgbceh73TlC/W2zQg75pG2+/A3ppazbVmFiMAlIT3kwrQ9/vhinYXhhp1DJwW7KiFlO54KylBbVmZgocsqztsmVusCSy6NHAzcbR58DD71yqS0My4CzqV/spBMSJNnm7i0C917UNQWVYnDNg6RKdsuveF2GDWYt/9ZVGSOip76dmspepwAR2uhn/VfImyuKDXsystSeDRTiwLuKGPKO6XNMYcIxQcpY0IN33m7g2VfJsNIrMmP9l6dm+R/KweRSzel23o0cTv+rwaRJDDY5bClrcCnV3jwR/LHmhFAtS972P6ixc1p9SVgYZ9pSBvW+qNT/2ENrfhkYnhPTbLzlnNwA7Fmbmcjn+R0x10UqmDSQioKjf+Fa1xCFBy/WIu+dJwhtcAsdrNokcHz4vGVymbClSwdNLfFc/y+HP5YkykkhPR0SKurmGiIKTurGiaE9ufRs3fQrhszrUkTqgg/QSkmyQe4YQWk79AQSOgfDsOngUdn3tZYpPbaIqetG9jHe9ZDV36pwzX3oop/7mUa7m3Aj8qzBFvXxT23Ve/dwewrFjcgXpaYT4tM/diLLRuIwfm1ed7yvFO8OSX24la8VHv5446ZzStX7Zv/U=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(1800799024)(82310400026)(376014)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hRmKo7mq9m3zV0HdJ03+HDORlGm4Kj8ym0M49CJ8lx+BRJsYo0k5JmCQPd1YSJ47E1N/k7jkPBN6UYsbWGr03QzQtxf3KSTzrxKpFZ/OBDadoUGI2n+89cqNAyxJ4GGXC4fJzgzEm+aUs9UBw55H8iG0wReXC1TcOMl/eBxn9brHmGDGs8VtiE3L5NP8aTH60AcaShzqJfkXcLYxiv3e4tnK1WnbRU3l37vWDhuf3FNjvN4crkHfFJfJp9cU1kpWSATVKcm2Dbg6hGd8LHPEaz3StsVbMsF9cJw/HSBT53y2X9jhY2eqOxEx2Fu8yez8kBCuiBozC68qLDtXg1wZ806FBdA7j1ABad1Eq00TRqY6UQu4oEOiawHAnAjT5tS/yrl3nCFQRoE8dOHrk8/XfsCxir+XlJxJcGUICwDDFYVUE3fwLan6JAxlEyZMdMG0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 06:42:35.9340 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcb3e4a6-f619-4b5a-9b5d-08dec84dc9f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD82.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6715
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
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h | 58 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c |  9 ++++
 2 files changed, 67 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
index d13e64a69e25..df98be22f1f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
@@ -578,6 +578,64 @@ TRACE_EVENT(amdgpu_reset_reg_dumps,
 		      __entry->value)
 );
 
+DECLARE_EVENT_CLASS(amdgpu_userq_queue,
+	    TP_PROTO(struct amdgpu_usermode_queue *queue),
+	    TP_ARGS(queue),
+	    TP_STRUCT__entry(
+			     __field(void *, queue)
+			     __field(u64, doorbell_index)
+			     __field(int, queue_type)
+			     __field(int, state)
+			     __field(u32, xcp_id)
+			     ),
+	    TP_fast_assign(
+			   __entry->queue = queue;
+			   __entry->doorbell_index = queue->doorbell_index;
+			   __entry->queue_type = queue->queue_type;
+			   __entry->state = queue->state;
+			   __entry->xcp_id = queue->xcp_id;
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
+			     __field(void *, queue)
+			     __field(u64, doorbell_index)
+			     __field(int, queue_type)
+			     __field(int, state)
+			     __field(u32, xcp_id)
+			     __field(int, result)
+			     ),
+	    TP_fast_assign(
+			   __entry->queue = queue;
+			   __entry->doorbell_index = queue->doorbell_index;
+			   __entry->queue_type = queue->queue_type;
+			   __entry->state = queue->state;
+			   __entry->xcp_id = queue->xcp_id;
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
index e87a3d83dd3e..c6b9e8fc6293 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -33,6 +33,7 @@
 #include "amdgpu_userq.h"
 #include "amdgpu_hmm.h"
 #include "amdgpu_userq_fence.h"
+#include "amdgpu_trace.h"
 
 u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
 {
@@ -507,6 +508,8 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
 	const struct amdgpu_userq_funcs *uq_funcs = adev->userq_funcs[queue->queue_type];
 	int r = 0;
 
+	trace_amdgpu_userq_destroy_start(queue);
+
 	cancel_delayed_work_sync(&uq_mgr->resume_work);
 
 	/* Cancel any pending hang detection work and cleanup */
@@ -532,6 +535,7 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
 	amdgpu_bo_unreserve(queue->db_obj.obj);
 	amdgpu_bo_unref(&queue->db_obj.obj);
 
+	trace_amdgpu_userq_destroy_end(queue, r);
 	kfree(queue);
 
 	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
@@ -673,6 +677,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	}
 
 	queue->doorbell_index = index;
+	trace_amdgpu_userq_create_start(queue);
 	r = uq_funcs->mqd_create(queue, &args->in);
 	if (r) {
 		drm_file_err(uq_mgr->file, "Failed to create Queue\n");
@@ -696,6 +701,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		r = amdgpu_userq_map_helper(queue);
 		if (r) {
 			drm_file_err(uq_mgr->file, "Failed to map Queue\n");
+			trace_amdgpu_userq_create_end(queue, r);
 			mutex_unlock(&uq_mgr->userq_mutex);
 			goto erase_doorbell;
 		}
@@ -712,11 +718,13 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		 * This drops the last reference which should take care of
 		 * all cleanup.
 		 */
+		trace_amdgpu_userq_create_end(queue, r);
 		amdgpu_userq_put(queue);
 		return r;
 	}
 
 	amdgpu_debugfs_userq_init(filp, queue, qid);
+	trace_amdgpu_userq_create_end(queue, 0);
 	args->out.queue_id = qid;
 	return 0;
 
@@ -732,6 +740,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 free_fence_drv:
 	amdgpu_userq_fence_driver_free(queue);
 free_queue:
+	trace_amdgpu_userq_create_end(queue, r);
 	kfree(queue);
 err_pm_runtime:
 	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
-- 
2.34.1

