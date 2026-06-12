Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CC77CD98CE
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jun 2026 06:42:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA4B610F29D;
	Fri, 12 Jun 2026 06:42:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WOL+dIyw";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013005.outbound.protection.outlook.com
 [40.93.201.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADC1D10F299
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 06:42:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jPy58IBxSmM4d2Al48+qQYI74SeK3p2Mcjt1AbSFQF6hXsWfEDKCq6SwEkvpPoVC0RydhPGVQE5FWvroLyGcMutRGWHoJ+ZXR1vEMj4MSz6SMFJJ1rRY9nvwKoq81v1kQFjlnQg/2f9PTPmzxQqJX1U6VRwIjoVsDmCc1VB/rDnT2DB1M7jMbiC34xWzqPSzbAIlBtisuLY0aoOD4M+UgAU8IA5uP3CoD34B6YJrjnjg2WQPxcsoWbdKg26W23G3JhKeLBXZLTkoFMkZfHhq8OzO2/1LXGC/4qKCf3Om6P82BRIcAstkYmPC9UyoyAN9jDeHWNMJH25nhOPy+jlwUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qEMffJGxYmWus1u5B8sm8DYsARl+VVmAJ3EdwnxSF+Y=;
 b=o/mjAuwxNB0FqrUdd3LZJEKyw2m1djNiR7oFMeTmKDYvuy2bmfiZuZx4Nimd1AwYgmpXT/ght5qoh63A9H81okeQv4Xbuz3qIrfpCA4HX7pn1PK+o2nxd42LjWMcHaAJ/DHXz8XbCNrNxzlsL/R8r+1wlzLBof2vn/PrvFIaAdyzCjSbEjsTXNESed4z5cvNL79JX3OvuSlKg/0Kx3DX477/jTfgdrIDkqGNx57Mz5PAvv0XzudwwrWDINpM4Vg31yYQZE9W0tDCCU+OqLSSBMGrS3JA9skMEiKgiIV2FstC8tMRHhvf+u3APwisppUIxflDQUd1sowD/MO0Vp40gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qEMffJGxYmWus1u5B8sm8DYsARl+VVmAJ3EdwnxSF+Y=;
 b=WOL+dIywYYFTK0WLwfXtYnc1sRcxDjOcFoWrtt0dia7oJ3NDYw8Mj+M+RGmFM/UvIILNvUJt5IzSTULstZko6WxRnh9AlRj+XiNhU6TyfwCyMSRM/ObEltXE1lhDLmmNYgjae3MQGAncIFCL8ZLk4gr3VylriRi5n7sFFrE75+U=
Received: from CH3P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::27)
 by DS7PR12MB5886.namprd12.prod.outlook.com (2603:10b6:8:79::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.14; Fri, 12 Jun 2026 06:42:38 +0000
Received: from CH1PEPF0000AD7E.namprd04.prod.outlook.com
 (2603:10b6:610:1e8:cafe::16) by CH3P220CA0009.outlook.office365.com
 (2603:10b6:610:1e8::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Fri,
 12 Jun 2026 06:42:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7E.mail.protection.outlook.com (10.167.244.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Fri, 12 Jun 2026 06:42:38 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 12 Jun
 2026 01:42:35 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Pierre-eric.Pelloux-prayer@amd.com>, Pierre-Eric Pelloux-Prayer
 <pierre-eric.pelloux-prayer@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH v3 3/3] drm/amdgpu: add userq job and state transition trace
 events
Date: Fri, 12 Jun 2026 14:42:23 +0800
Message-ID: <20260612064223.196556-3-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260612064223.196556-1-Prike.Liang@amd.com>
References: <20260612064223.196556-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7E:EE_|DS7PR12MB5886:EE_
X-MS-Office365-Filtering-Correlation-Id: d9b491d5-0d89-4091-988c-08dec84dcb4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|23010399003|1800799024|36860700016|22082099003|18002099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 3G/OG22wFcWaAD8lBBqQ914Jt5s95KwNC4YCGVSjXhq2gycVWgdiECLnfHY3VeUkQxbX0acdeQlCSgLH8Wvuxyx+ErKWDB5PUr6iXbI/k9ozN2ECFAp8+wt9uFGpKc0rhX5sbGYd26yl1Sjo3ESUa7+qkvEpvZ5BP414G/wkPMoZ7t5I0mPPdsYzsNqtzf6NR5rFxB5SBv0NS3wJqKDX6ao+QU6cbt2QIV9GeOfafj/M1slLu8lScH1KG+pV87vQXmZa4iCVZ/wS5Io68bmuwIqRXmWfI4aDFSkNtmKixPUybSBbpfuoYBbInyR2xxgFvZhFxOVx4XgOMEUqjsLlXSq3+PiTqb1lLHtj/rRIPVGOK9/khdau6sXrR4i9plU8scf1rBhQg9FYCSBM7n9gg5AIW6ELcC+rEET0SedDloiLLWLX7rpTqzb1a8GrKFXdpGoSmYKBqyt/fDAiiRQJJ/EPm2NLcCOIuLipBXURi0m/442orFtIEeaaFaBxzLeMesezvdOAM2E55ZShF3UWNTE48lCuF9DsqMf7LVHAM+igjvHt7wC6/D3dvE+Mdq+xXBcC3yn3HJThW6VNYtluaONHtaC9es6NofDetnXHIzUjGdN6rbkplpqVb/3W5aOXL8naPO9JTg/cqlnYPDZsggswX4c0UCSdiH+gGlcU8tOtWQnpNpqlAqjODRZN0nj7ZdKSyueD4DZmbG4Cfl/FAz1yCgGPy0GdZ0mXIw++3ws=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(23010399003)(1800799024)(36860700016)(22082099003)(18002099003)(6133799003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7YpHOyg2lBSpGUDjp9IEdCkHiFO3BaoFShoL45OrhJEebBxwYXCqO2d2/qklynZyDD2rhNXihDcmtk8nRklJ4Poq5GUOSLPunIO6dSgdH3UUl8Bbl+FmhWGFw9+ZjHjPcqWvA6ZdMxIDTqTCyRndP4sKO8i+DtwBOl9EyJG66zhfX/hwMW1+nZiHnQANQt2lWRZQnW+C8TD5EcZP0KygcEmriOeoFETdj0kFubpc7pHkSIawThA+8eQdN34x+pkEN1DAGCUYB6XRce6O7oOXaiXI7qPr7TQcp6O2zKsTuIwKAGYoY0t0nVFQKbCDrOsOtaIfvFN+PXYyW2EIUt+xpCtt79zWwSmYrZUl6r5R7FVTutQ0xG7n0FYK9DFxm5B8nEotTABVz+aQl+vCFDDKpxpAeKlwZdcnPK11VWQZ/uwSEhnOeUqbm5ObUyrq5jvP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 06:42:38.1625 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9b491d5-0d89-4091-988c-08dec84dcb4e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5886
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
Co-developed-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h     | 92 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     | 21 +++++
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 10 +-
 3 files changed, 120 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
index df98be22f1f5..fcd4cf2f4cd8 100644
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
@@ -636,6 +638,96 @@ DEFINE_EVENT(amdgpu_userq_queue_result, amdgpu_userq_destroy_end,
 	     TP_PROTO(struct amdgpu_usermode_queue *queue, int result),
 	     TP_ARGS(queue, result));
 
+TRACE_EVENT(amdgpu_userq_emit_fence,
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
+TRACE_EVENT(amdgpu_userq_wait_deps,
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
index c6b9e8fc6293..210d83b0aba5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -294,11 +294,15 @@ static int amdgpu_userq_preempt_helper(struct amdgpu_usermode_queue *queue)
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
@@ -314,10 +318,14 @@ static int amdgpu_userq_restore_helper(struct amdgpu_usermode_queue *queue)
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
@@ -335,12 +343,15 @@ static int amdgpu_userq_unmap_helper(struct amdgpu_usermode_queue *queue)
 
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
@@ -357,11 +368,15 @@ static int amdgpu_userq_map_helper(struct amdgpu_usermode_queue *queue)
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
@@ -890,6 +905,7 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
 		if (!amdgpu_userq_buffer_vas_mapped(queue)) {
 			drm_file_err(uq_mgr->file,
 				     "trying restore queue without va mapping\n");
+			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_INVALID_VA);
 			queue->state = AMDGPU_USERQ_STATE_INVALID_VA;
 			continue;
 		}
@@ -1382,12 +1398,14 @@ void amdgpu_userq_pre_reset(struct amdgpu_device *adev)
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
@@ -1406,6 +1424,8 @@ int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost)
 
 	xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
 		if (queue->state == AMDGPU_USERQ_STATE_HUNG && !vram_lost) {
+			trace_amdgpu_userq_state_start(queue);
+
 			userq_funcs = adev->userq_funcs[queue->queue_type];
 			/* Re-map queue */
 			r = userq_funcs->map(queue);
@@ -1413,6 +1433,7 @@ int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost)
 				dev_err(adev->dev, "Failed to remap queue %ld\n", queue_id);
 				continue;
 			}
+			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_MAPPED);
 			queue->state = AMDGPU_USERQ_STATE_MAPPED;
 		}
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index c0d68863fa17..751535a7aef9 100644
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
 
+	trace_amdgpu_userq_emit_fence(dev->dev, queue, fence);
+
 	mutex_unlock(&userq_mgr->userq_mutex);
 
 	/*
@@ -701,7 +703,7 @@ amdgpu_userq_wait_add_fence(struct drm_amdgpu_userq_wait *wait_info,
 }
 
 static int
-amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
+amdgpu_userq_wait_return_fence_info(struct drm_device *dev, struct drm_file *filp,
 				    struct drm_amdgpu_userq_wait *wait_info,
 				    u32 *syncobj_handles, u64 *timeline_points,
 				    u32 *timeline_handles,
@@ -869,6 +871,8 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
 
 		amdgpu_userq_fence_driver_get(fence_drv);
 
+		trace_amdgpu_userq_wait_deps(dev->dev, waitq, userq_fence);
+
 		/* Store drm syncobj's gpu va address and value */
 		fence_info[cnt].va = fence_drv->va;
 		fence_info[cnt].value = fences[i]->seqno;
@@ -969,7 +973,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
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

