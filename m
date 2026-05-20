Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76AE0CD4F5E
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2026 06:39:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0772410EEF7;
	Wed, 20 May 2026 06:39:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EAWlqJTw";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012021.outbound.protection.outlook.com [52.101.48.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03E9910EEF7
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2026 06:39:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kstK895Xy8/Qd21W1SrXpXVRO5Z52kMjSPBAt3642kbdeT45AFGIBDO9rLx7iuEun/DVsLlZzTWlv0y/UPonjhVkQaRMyK/StmuM8XTzNxxcJKLmTC+WOymfuEPQfkecVl5OrxOKVivLOA97mX0szfhe1Ck3NEbmJb6qYG0Xh05dZOaeMfyt3mQCKjcM/HgOUD7gtKzMNB+mfHczBSrJG1GL6ZCkV+Xi+dKMdONJm9rYaaAuZQYOH8pYyUwgZCw4UXuDeJHfmKX+c96GoEZe3E0mpXJtQMsOm5YDjv7nMUg7ieaYpSHa8agMfyQyXS7Q8E+QwmGC63sNlYY8EPy/hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yjpo5WPipTX79swDop7qBzuq5/5RsIPawv94PHcxfVg=;
 b=oXiW/SNHlV/DHz5seYGzpW/eApTwDHPbZpSA7fc/mKI6FzErEh4QaO4y8D5pmZxglP1H+KyFpO9jVe9/qSGGt+wqZ487dLSWVM64yDGjC1f1huNtPrjzysuFnHe7wnn+3a4un8fIenMugclRQXIzcCkYEdC6Imn3BAK1JLrhDzDy/1+AsfJXIJeIgQzrNB0j1mUKeDPhgXzEQjr/AmrwV2+jMd9/wANhXUGiI34tdz0DBktMz0mCIUcmz23hph+G7Gz6bTJhjhVqvqCNp39TxJKgAXogwsO9hNckD29i3EYNzNcViPBVEm0O2FUwZqzAmBWc4dCdOow8SdlNlyX2Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yjpo5WPipTX79swDop7qBzuq5/5RsIPawv94PHcxfVg=;
 b=EAWlqJTwBCL8PytDoUAq0AR6zljR3eSPzJiCpYh83l/r+/cyNvjXLSoIbOrtSQocZS+U3kEUkte06WHbkorXEJnxliL36grvThQL8YsURpPEaaECkg0lcH9XEB9bS32mczIQG2Q9pzm02BgnvSf5APBL/duqkJD8EmTlanYe3fQ=
Received: from SJ0PR03CA0334.namprd03.prod.outlook.com (2603:10b6:a03:39c::9)
 by DS0PR12MB8501.namprd12.prod.outlook.com (2603:10b6:8:15d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 06:39:27 +0000
Received: from SJ5PEPF000001F6.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::3) by SJ0PR03CA0334.outlook.office365.com
 (2603:10b6:a03:39c::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Wed, 20
 May 2026 06:39:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F6.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 20 May 2026 06:39:27 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 20 May
 2026 01:39:25 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>,
 <pierre-eric.pelloux-prayer@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: add eviction fence tracepoints for userq
 profiling
Date: Wed, 20 May 2026 14:38:58 +0800
Message-ID: <20260520063859.15914-2-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260520063859.15914-1-Prike.Liang@amd.com>
References: <20260520063859.15914-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F6:EE_|DS0PR12MB8501:EE_
X-MS-Office365-Filtering-Correlation-Id: 690142b7-3c67-4851-8ae3-08deb63a8a19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|56012099003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: uFMDPtMng8eoRtxgBt9gtVXZRtqXJuJAoXya/lkr/emHaB+Pn18SA58wBSsrFg1VdpK9zCzm9t3FHlF7x+t64yg25uDpg6Bq7gb78kxy9pzW8Gk1tlHMbAJXAJ8f41avnv0qnGddVP5n8XkwtfGJai815GMTCMuk5Okb7wq97ssqPvhagKCln5c3yRmUIi9mTz7LEDHJHMZrFneCclpvFn3TCuwYkBbhjTA1113QtVGLYreo17u2QUWrKIhV5KRlYuQ3j2UzPxPZX4IdApSPlRoLVlNzBCg/FW1YM8TtRulKaxnjTh5byLQ+3dZX89Za7tMgiFgdwhv1Q9AstVu6IIvTNsy+RyWfV2ZpaSvRbhCUKjwQOn0cAXh9nGgWxV7WIL+tRqwdPgy73aPyN7mo6P+ECCs2SzaFSa4Js89+w9218XwOULFlVSsptd/+O2s7Pg0/BnqyJP5To4z6UJubAqvIlgEMiq1DNwAu+2bOQyCQAfGpPzWxJGiM2uTet0nPzh+sqiwqX4rgVd0+y5qPmD97TLaK/8hw3aBgB9TniB4LvV2NEUm4e4N1fyxq5L3UxVLug0QobmjPTna2d8oKAFnIf+pZ+DlFhf0aHc2ptyT5huOeJjBSgngGBU43O/Ylvb2Ya0vCewJBC49jI6gYXHGVdSMwFzTBai82BDKd7j8RujfSmyqMMGDdAZaC1i9jJFWpyDagHBnhq/L3oOHhFHHaH7UJG0eo+PilIeL5nx4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(56012099003)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yZVi3CAy9TWzPg9resya6TGMnpJrnLMB15f7ybS629R2VQ+zaqlD+PUU5kPIiSLgWr+jmDVWfv0n7SkeXk4yJOM3szYa2C+lNg/5hg1ay+4QlVP2KSlo4qnqqgqPWnZNZ4V93pOlE8zPp2hUmlpf/w/BqVNaJ6cLUdXA5M6Ley7+t2sYFZ47Sd7cJV3HiwGH9KqKgBjzc6V1UYi5MtVj+fU6yRjLDu699IajQW/1IBtonoRLxoO0bdT4e3xkB7f4M7KB1nI0yj2i4yXPK+g+qWvVrQLHgxJz3QM8wJJorFvxqVmRPsLQwA3mobiPu9HzpflHL/Zo+1PHAkhb13OZaJAzTtzi8UVQ/JAxpJ9WHLo3uEu4xZTTUkbJOzOw5TOoRvVhgglVzdQ10sREKrJZtO5QfkE0XzTUE2QWktfKN/ON2Ew+J9mgPIMVmy5ddzqq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 06:39:27.3131 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 690142b7-3c67-4851-8ae3-08deb63a8a19
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8501
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

Add ftrace events for the userq eviction fence lifecycle.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_eviction_fence.c    |  8 ++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h     | 23 +++++++++++++++++++
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
index 5ae477c49a53..9358f9b35914 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
@@ -24,6 +24,7 @@
 #include <linux/sched.h>
 #include <drm/drm_exec.h>
 #include "amdgpu.h"
+#include "amdgpu_trace.h"
 
 static const char *
 amdgpu_eviction_fence_get_driver_name(struct dma_fence *fence)
@@ -44,6 +45,8 @@ static bool amdgpu_eviction_fence_enable_signaling(struct dma_fence *f)
 {
 	struct amdgpu_eviction_fence *ev_fence = to_ev_fence(f);
 
+	trace_amdgpu_userq_eviction_fence_enable_signaling(f->context,
+							   f->seqno);
 	schedule_work(&ev_fence->evf_mgr->suspend_work);
 	return true;
 }
@@ -84,6 +87,8 @@ amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
 	 * next fence.
 	 */
 	dma_fence_signal(ev_fence);
+	trace_amdgpu_userq_eviction_fence_signal(ev_fence->context,
+						 ev_fence->seqno);
 	dma_fence_end_signalling(cookie);
 	dma_fence_put(ev_fence);
 
@@ -138,7 +143,8 @@ int amdgpu_evf_mgr_rearm(struct amdgpu_eviction_fence_mgr *evf_mgr,
 	/* Remember it for newly added BOs */
 	dma_fence_put(evf_mgr->ev_fence);
 	evf_mgr->ev_fence = &ev_fence->base;
-
+	trace_amdgpu_userq_eviction_fence_emit(ev_fence->base.context,
+					       ev_fence->base.seqno);
 	/* And add it to all existing BOs */
 	drm_exec_for_each_locked_object(exec, index, obj) {
 		struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
index 5a01f63d1f32..4ff8a4d7bb8b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
@@ -636,6 +636,29 @@ DEFINE_EVENT(amdgpu_userq_queue_result, amdgpu_userq_destroy_end,
 	     TP_PROTO(struct amdgpu_usermode_queue *queue, int result),
 	     TP_ARGS(queue, result));
 
+DECLARE_EVENT_CLASS(amdgpu_userq_eviction_fence,
+	    TP_PROTO(u64 context, u64 seqno),
+	    TP_ARGS(context, seqno),
+	    TP_STRUCT__entry(
+			     __field(u64, context)
+			     __field(u64, seqno)
+			     ),
+	    TP_fast_assign(
+			   __entry->context = context;
+			   __entry->seqno = seqno;
+			   ),
+	    TP_printk("eviction fence=%llu:%llu",
+		      __entry->context, __entry->seqno)
+);
+DEFINE_EVENT(amdgpu_userq_eviction_fence, amdgpu_userq_eviction_fence_emit,
+	    TP_PROTO(u64 context, u64 seqno),
+	    TP_ARGS(context, seqno));
+DEFINE_EVENT(amdgpu_userq_eviction_fence, amdgpu_userq_eviction_fence_enable_signaling,
+	    TP_PROTO(u64 context, u64 seqno),
+	    TP_ARGS(context, seqno));
+DEFINE_EVENT(amdgpu_userq_eviction_fence, amdgpu_userq_eviction_fence_signal,
+	    TP_PROTO(u64 context, u64 seqno),
+	    TP_ARGS(context, seqno));
 #undef AMDGPU_JOB_GET_TIMELINE_NAME
 #endif
 
-- 
2.34.1

