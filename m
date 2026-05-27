Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 903B1CD5BD5
	for <amd-gfx@archiver.kernel.org>; Wed, 27 May 2026 12:20:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D4C410E7A4;
	Wed, 27 May 2026 12:20:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eBib4JhC";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013010.outbound.protection.outlook.com
 [40.107.201.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 979A410E171
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 May 2026 12:20:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dxg7xAHkrlwHOLR3HulEovqJ/knGxEPu8BJ95oOgglAhtmXJAHrOR7L4HWRYKTqz7nNhT+ZHi4UzyDhBWgw34cpVYn3wOqEnyc9bBSd9QjnHZdRiZjCQ5mrz+Hlzh8BeyajYq8IOP5RLWtJpsFeMBcsnhWGLc2bKc+C5ZfW8bQOG3SNTo1wJGZakbtUASJI4KZKya63L5VAMxJRvThMSiQkxZj+R40W83taqeFTEfKLvfnx4SWTnEJj9OjiHKBYiTrsTGedGbHeZNfxONWlyYpfVSX102a//rGhdv/wph5OjEDc+x5L5/kLLUtfaY7aXiEmfByYD+3H6MFs6WEDRrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4DOIfbbItcrTFjDHcEURLShvjbqCT+QMqFrM4Hvo+jI=;
 b=ar8BeXXEU/ur851vZN0GLbvNz0Q+S4CS3cM6iDy6Zt08fvQIvNAytEl79pDd8hoPCybSAqiafDJfHMq7vuEqFwjaUIS5OO19yv0z+C68lNklYz4AnAYK4QIrerjZs3ucgJ5JYw3l1bxMsqRkGqblyFtlQuUKmX+5k3wzgkpdFWixCs24PZOdcUH3s1KYuXKCeDLNYQc56hvw3yY2VLlyQyhko8rgfnDz4agUONmuzWF/8h0ArIcpsWxZLUazULT34/dcmM1PpTF2rviQkWF0hqiBdCmicw2tEMutnBrCRlt8eHlAHpmAsGtu+wsgf8tyxHDtdooJ2sguC+JpfWKWBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4DOIfbbItcrTFjDHcEURLShvjbqCT+QMqFrM4Hvo+jI=;
 b=eBib4JhCXZHgMUHPni9lO17BO1eHYeKHEG4TNX+OEZqCxGOFJ4JXxRs+msXkQRBw6josxdYC5TjLbUGEMzJTatlHD3yXuPGGdpqQS/ygk+P+gjCU+1jPS6tnmbQVQTNEclG4Ljqx9mwKrJ/Yac9tY1dFryA+akEYBfICS7f55Zk=
Received: from SA1P222CA0163.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::22)
 by MN2PR12MB4485.namprd12.prod.outlook.com (2603:10b6:208:269::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 12:20:14 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:3c3:cafe::31) by SA1P222CA0163.outlook.office365.com
 (2603:10b6:806:3c3::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Wed, 27
 May 2026 12:20:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Wed, 27 May 2026 12:20:14 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 27 May
 2026 07:20:12 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Pierre-eric.Pelloux-prayer@amd.com>, Pierre-Eric Pelloux-Prayer
 <pierre-eric.pelloux-prayer@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: add userq job and state transition trace
 events
Date: Wed, 27 May 2026 20:20:01 +0800
Message-ID: <20260527122001.69831-2-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260527122001.69831-1-Prike.Liang@amd.com>
References: <20260527122001.69831-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|MN2PR12MB4485:EE_
X-MS-Office365-Filtering-Correlation-Id: 360ae786-f28d-44c4-3b20-08debbea4e7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|11063799006|56012099006|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: XlhlbReLKdpCmhMbhFKLQ+Lb9bhJs0h4ddDic08JRJKeTCYFGFJ73Jit/7N866LcyDWtfy6e+lgokbVIVmwGZ0iHtDNorKlViWTP1lhzLy6PVQphQ6ND/mBC3ZZHWO/5gVDAZi4e3GOZJ7s1P25IE3gDGyatgFKDodyfDag+QYeSNrWPiEnXveUVpb0K45elJezfSpHjGNxSVTl/mSq+9PA/dilbLaeR/naAQMoe5FPSUCtitn2tKQ9NXz8Vco3ylzDmE7FCghZ61Wga93EtNGgY9ykJDuncmfanBqfuG0zZ1emjvnDeltzbAH6CO/cuGTBRd2qqkN7iG7aFt7m9rI8TUitv7JqouJKGXNkC6JtqtqOdgFZmp8XfTfiTvgutbaLy0AQovaAQpmMriPa13zbu/ZTxIJxOl/Hu8Oc+WpAskMeGrgPb0OnTKJqDdkG7mTy5aCJqfQtedMhi8BJRGdWcihGN6OQgpTijnJKQS80MeJZ3LPUCk5LYyOx/7DsyPuSAh8bwgr7CVvAaF25Cf1zcEyy0Z13DCjQm9uEwHiolmqPI2Kni46KqJvSzkigK3EDcY5rCy2yARew5m27fKr9pBYnIuJa60kYFmJsUqbcIovjxkOlveoR1mGvG/18xnB29VyXrPzACCIrXnLV6zHDvFAPXSIO0Wg1qj9GhhGMAyjzinuZOPZjDBOrSPevgQcRuTgFYP5A1Sa+skHWDuO7cmIDdWVxoPu9wl2fXuIE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(11063799006)(56012099006)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NhA4pzGYxkyIItKpJlnnO/arfDk0TphNzNa38e7pZZ1wbVkCZWHGnAAG5evjRQvkqrlusjn4pbd8fYmq2b1wdYnvc9J2kgJ+MHf2M5H1AEeF2uZJ93Rc4tqAEvMJNyzRBVJDrFyObB1rTApfF+WLRwSFZBNjYbX3GovUGk6joHAtt4gEyEcnQPdombyA2/b2gI5LfXMWI0ry4jzuJ5pINJp1gHze2vxPoV65xHiJ6CbOej6YEhmpFnseM1UxZ0efnOm0Ra1kB9Q5t5bENVShIdP4bLLqFfV98zkOdCuVoxdlsRN1zS+N21EUfxydoe8PjH3VrzrtbfN19ghcXPw2+ZKa+BRImgOVLADGVVvfrVPXMao54KBkbzicxayiyzPnnnbKUrIm+0BFeq3ZpLsI+1ZWGOfw2qWWwbNGoGG/xUta8XmM+Yaviq1hpJUm7PUp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 12:20:14.6046 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 360ae786-f28d-44c4-3b20-08debbea4e7c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4485
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

From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>

Add ftrace events for tracking the userq fence emit, signal
and queue state transition.

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h     | 113 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     |  21 ++++
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |  12 +-
 3 files changed, 143 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
index df98be22f1f5..ef6a1fb82ff3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
@@ -28,6 +28,8 @@
 #include <linux/types.h>
 #include <linux/tracepoint.h>
 
+#include "amdgpu_userq_fence.h"
+
 #undef TRACE_SYSTEM
 #define TRACE_SYSTEM amdgpu
 #define TRACE_INCLUDE_FILE amdgpu_trace
@@ -636,6 +638,117 @@ DEFINE_EVENT(amdgpu_userq_queue_result, amdgpu_userq_destroy_end,
 	     TP_PROTO(struct amdgpu_usermode_queue *queue, int result),
 	     TP_ARGS(queue, result));
 
+TRACE_EVENT(amdgpu_userq_job_run,
+	    TP_PROTO(struct device *device, struct amdgpu_usermode_queue *queue, struct amdgpu_userq_fence *fence),
+	    TP_ARGS(device, queue, fence),
+	    TP_STRUCT__entry(
+			     __field(u64, fence_context)
+			     __field(u64, fence_seqno)
+			     __string(dev, dev_name(device))
+			     __field(u64, doorbell_index)
+			     __field(u64, client_id)
+			     __field(u32, queue_type)
+			     ),
+	    TP_fast_assign(
+			   __entry->fence_context = fence->base.context;
+			   __entry->fence_seqno = fence->base.seqno;
+			   __assign_str(dev);
+			   __entry->doorbell_index = queue->doorbell_index;
+			   __entry->client_id = queue->userq_mgr->file->client_id;
+			   __entry->queue_type = queue->queue_type;
+			   ),
+	    TP_printk("dev=%s, client_id=%llu, type=%u, doorbell=%llu, fence=%llu:%llu",
+		      __get_str(dev), __entry->client_id, __entry->queue_type, __entry->doorbell_index,
+		      __entry->fence_context,
+		      __entry->fence_seqno)
+);
+
+TRACE_EVENT(amdgpu_userq_job_queue,
+	    TP_PROTO(struct device *device,
+		     struct amdgpu_usermode_queue *queue),
+	    TP_ARGS(device, queue),
+	    TP_STRUCT__entry(__field(u64, context)
+			     __string(dev, dev_name(device))
+			     __field(u64, doorbell_index)
+			     __field(u64, client_id)
+			     __field(u32, queue_type)
+			     ),
+	    TP_fast_assign(__assign_str(dev);
+			   __entry->doorbell_index = queue->doorbell_index;
+			   __entry->queue_type = queue->queue_type;
+			   __entry->client_id = queue->userq_mgr->file->client_id;
+			   __entry->context = queue->fence_drv->context;
+			  ),
+	    TP_printk("dev=%s, client_id=%llu, type=%u, doorbell=%llu, context=%llu",
+		      __get_str(dev), __entry->client_id, __entry->queue_type,
+		      __entry->doorbell_index, __entry->context)
+);
+
+TRACE_EVENT(amdgpu_userq_job_add_dep,
+	    TP_PROTO(struct device *device, struct amdgpu_usermode_queue *queue, struct amdgpu_userq_fence *dep),
+	    TP_ARGS(device, queue, dep),
+	    TP_STRUCT__entry(
+			     __field(u64, context)
+			     __field(u64, dep_context)
+			     __field(u64, dep_seqno)
+			     __string(dev, dev_name(device))
+			     __field(u64, doorbell_index)
+			     __field(u64, client_id)
+			     __field(u32, queue_type)
+			     ),
+	    TP_fast_assign(
+			   __assign_str(dev);
+			   __entry->doorbell_index = queue->doorbell_index;
+			   __entry->queue_type = queue->queue_type;
+			   __entry->client_id = queue->userq_mgr->file->client_id;
+			   __entry->context = queue->fence_drv->context;
+			   __entry->dep_context = dep->base.context;
+			   __entry->dep_seqno = dep->base.seqno;
+			   ),
+	    TP_printk("dev=%s, client_id=%llu, type=%u, doorbell=%llu, context=%llu depends on fence=%llu:%llu",
+		      __get_str(dev), __entry->client_id, __entry->queue_type, __entry->doorbell_index, __entry->context,
+		      __entry->dep_context,
+		      __entry->dep_seqno)
+);
+
+TRACE_EVENT(amdgpu_userq_state_start,
+	    TP_PROTO(struct amdgpu_usermode_queue *queue),
+	    TP_ARGS(queue),
+	    TP_STRUCT__entry(
+			     __field(u64, doorbell_index)
+			     __field(u64, client_id)
+			     __field(u32, queue_type)
+			     __field(u32, from)
+			     ),
+	    TP_fast_assign(
+			   __entry->doorbell_index = queue->doorbell_index;
+			   __entry->queue_type = queue->queue_type;
+			   __entry->client_id = queue->userq_mgr->file->client_id;
+			   __entry->from = queue->state;
+			   ),
+	    TP_printk("client_id=%llu, type=%u, doorbell=%llu, from=%d",
+		      __entry->client_id, __entry->queue_type, __entry->doorbell_index, __entry->from)
+);
+
+TRACE_EVENT(amdgpu_userq_state_changed,
+	    TP_PROTO(struct amdgpu_usermode_queue *queue, enum amdgpu_userq_state new_state),
+	    TP_ARGS(queue, new_state),
+	    TP_STRUCT__entry(
+			     __field(u64, doorbell_index)
+			     __field(u64, client_id)
+			     __field(u32, queue_type)
+			     __field(u32, to)
+			     ),
+	    TP_fast_assign(
+			   __entry->doorbell_index = queue->doorbell_index;
+			   __entry->queue_type = queue->queue_type;
+			   __entry->client_id = queue->userq_mgr->file->client_id;
+			   __entry->to = new_state;
+			   ),
+	    TP_printk("client_id=%llu, type=%u, doorbell=%llu, to=%d",
+		      __entry->client_id, __entry->queue_type, __entry->doorbell_index, __entry->to)
+);
+
 #undef AMDGPU_JOB_GET_TIMELINE_NAME
 #endif
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 9dc6cb579ac7..536e73c7e9ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -296,11 +296,15 @@ static int amdgpu_userq_preempt_helper(struct amdgpu_usermode_queue *queue)
 	int r;
 
 	if (queue->state == AMDGPU_USERQ_STATE_MAPPED) {
+		trace_amdgpu_userq_state_start(queue);
+
 		r = userq_funcs->preempt(queue);
 		if (r) {
+			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_HUNG);
 			queue->state = AMDGPU_USERQ_STATE_HUNG;
 			return r;
 		} else {
+			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_PREEMPTED);
 			queue->state = AMDGPU_USERQ_STATE_PREEMPTED;
 		}
 	}
@@ -316,10 +320,14 @@ static int amdgpu_userq_restore_helper(struct amdgpu_usermode_queue *queue)
 	int r = 0;
 
 	if (queue->state == AMDGPU_USERQ_STATE_PREEMPTED) {
+		trace_amdgpu_userq_state_start(queue);
+
 		r = userq_funcs->restore(queue);
 		if (r) {
+			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_HUNG);
 			queue->state = AMDGPU_USERQ_STATE_HUNG;
 		} else {
+			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_MAPPED);
 			queue->state = AMDGPU_USERQ_STATE_MAPPED;
 		}
 	}
@@ -337,12 +345,15 @@ static int amdgpu_userq_unmap_helper(struct amdgpu_usermode_queue *queue)
 
 	if ((queue->state == AMDGPU_USERQ_STATE_MAPPED) ||
 	    (queue->state == AMDGPU_USERQ_STATE_PREEMPTED)) {
+		trace_amdgpu_userq_state_start(queue);
 
 		r = userq_funcs->unmap(queue);
 		if (r) {
+			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_HUNG);
 			queue->state = AMDGPU_USERQ_STATE_HUNG;
 			return r;
 		} else {
+			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_UNMAPPED);
 			queue->state = AMDGPU_USERQ_STATE_UNMAPPED;
 		}
 	}
@@ -359,11 +370,15 @@ static int amdgpu_userq_map_helper(struct amdgpu_usermode_queue *queue)
 	int r;
 
 	if (queue->state == AMDGPU_USERQ_STATE_UNMAPPED) {
+		trace_amdgpu_userq_state_start(queue);
+
 		r = userq_funcs->map(queue);
 		if (r) {
+			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_HUNG);
 			queue->state = AMDGPU_USERQ_STATE_HUNG;
 			return r;
 		} else {
+			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_MAPPED);
 			queue->state = AMDGPU_USERQ_STATE_MAPPED;
 		}
 	}
@@ -894,6 +909,7 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
 		if (!amdgpu_userq_buffer_vas_mapped(queue)) {
 			drm_file_err(uq_mgr->file,
 				     "trying restore queue without va mapping\n");
+			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_INVALID_VA);
 			queue->state = AMDGPU_USERQ_STATE_INVALID_VA;
 			continue;
 		}
@@ -1389,12 +1405,14 @@ void amdgpu_userq_pre_reset(struct amdgpu_device *adev)
 		if (queue->state != AMDGPU_USERQ_STATE_MAPPED)
 			continue;
 
+		trace_amdgpu_userq_state_start(queue);
 		userq_funcs = adev->userq_funcs[queue->queue_type];
 		userq_funcs->unmap(queue);
 		/* just mark all queues as hung at this point.
 		 * if unmap succeeds, we could map again
 		 * in amdgpu_userq_post_reset() if vram is not lost
 		 */
+		trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_HUNG);
 		queue->state = AMDGPU_USERQ_STATE_HUNG;
 		amdgpu_userq_fence_driver_force_completion(queue);
 	}
@@ -1413,6 +1431,8 @@ int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost)
 
 	xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
 		if (queue->state == AMDGPU_USERQ_STATE_HUNG && !vram_lost) {
+			trace_amdgpu_userq_state_start(queue);
+
 			userq_funcs = adev->userq_funcs[queue->queue_type];
 			/* Re-map queue */
 			r = userq_funcs->map(queue);
@@ -1420,6 +1440,7 @@ int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost)
 				dev_err(adev->dev, "Failed to remap queue %ld\n", queue_id);
 				continue;
 			}
+			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_MAPPED);
 			queue->state = AMDGPU_USERQ_STATE_MAPPED;
 		}
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 008330a0d852..6071e83acd9e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -30,7 +30,7 @@
 #include <drm/drm_syncobj.h>
 
 #include "amdgpu.h"
-#include "amdgpu_userq_fence.h"
+#include "amdgpu_trace.h"
 
 #define AMDGPU_USERQ_MAX_HANDLES	(1U << 16)
 
@@ -528,6 +528,8 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 	/* Create the new fence */
 	amdgpu_userq_fence_init(queue, fence, wptr);
 
+	trace_amdgpu_userq_job_run(dev->dev, queue, fence);
+
 	mutex_unlock(&userq_mgr->userq_mutex);
 
 	/*
@@ -701,7 +703,7 @@ amdgpu_userq_wait_add_fence(struct drm_amdgpu_userq_wait *wait_info,
 }
 
 static int
-amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
+amdgpu_userq_wait_return_fence_info(struct drm_device *dev, struct drm_file *filp,
 				    struct drm_amdgpu_userq_wait *wait_info,
 				    u32 *syncobj_handles, u32 *timeline_points,
 				    u32 *timeline_handles,
@@ -835,6 +837,8 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
 		goto free_fences;
 	}
 
+	trace_amdgpu_userq_job_queue(dev->dev, waitq);
+
 	for (i = 0, cnt = 0; i < num_fences; i++) {
 		struct amdgpu_userq_fence_driver *fence_drv;
 		struct amdgpu_userq_fence *userq_fence;
@@ -869,6 +873,8 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
 
 		amdgpu_userq_fence_driver_get(fence_drv);
 
+		trace_amdgpu_userq_job_add_dep(dev->dev, waitq, userq_fence);
+
 		/* Store drm syncobj's gpu va address and value */
 		fence_info[cnt].va = fence_drv->va;
 		fence_info[cnt].value = fences[i]->seqno;
@@ -968,7 +974,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 						   gobj_write,
 						   gobj_read);
 	} else {
-		r = amdgpu_userq_wait_return_fence_info(filp, wait_info,
+		r = amdgpu_userq_wait_return_fence_info(dev, filp, wait_info,
 							syncobj_handles,
 							timeline_points,
 							timeline_handles,
-- 
2.34.1

