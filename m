Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7650CD37AC
	for <amd-gfx@archiver.kernel.org>; Mon, 11 May 2026 13:55:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EF4310E765;
	Mon, 11 May 2026 13:55:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qN21GylZ";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012002.outbound.protection.outlook.com
 [40.93.195.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60D6B10E75A
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 May 2026 13:55:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lNX0Rg9qCmlti5fbc2D7u/HjpbxuncqrGkVNa3ugs2jtcTsarN9Qz7s2hA8fZJF+Rh3KQATE6g3zom+Alca92U4XM3HqY8a0e1KODHeQe+qukaO40nQkpsxTs74LAs8ecqsArm+jCyCePKJ0An6qGqA8ssyJ0QNlLaPFGgjCQ2vJbsQfG9aJJhN/jYT4tOneV5azfnEDJDnuK6WQfXQzp7aySs7rNM1vgG3e6evbTF5oQL5qUg0tP4BP2uqgq7FH++g8kaQkFS9k4t3X/sQhiSmZ/k5J4MVM2jNlbd/tG489/OBS5SPpeANWysEdBrho1k5JYtUtSsXlFouqSgfhrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DmyEsK4yw8Ea/XsQ9vz0TqcZIXzfztRjLcDJcRQi1W0=;
 b=OTdrOPzHmDnTTVfADAkhM1wWg0KAJju7EIKPXgxydNO35FQ5giiitp5qKRRtPWCUjHMAnrfaR31xv9BrpL4PjL0fgtQ7UfiHqmYS5PIYrlqZKi/x5hF+OIJXnDqqvfepRFhMT9gH1r64fVPqGSTtBslNoPQqWVDkkfKVMFIB7P2zg+YwiwIlM1S3eeNo0Uq8CZ6NC5CDxA4QZSt5gdl8JjjX1Hz51IFq6zNXNuhDcjSFV2XxZ12sOdMO6d9VephHzpjrNj2aXj8ntqC8kUECm2Q4uw7S755vL5YKVPcueagOtv9heNj4Pjm995nJGp3LYRV4LbbiA7w5QEmxm+1zcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DmyEsK4yw8Ea/XsQ9vz0TqcZIXzfztRjLcDJcRQi1W0=;
 b=qN21GylZrEIW3c3w6noBicQmtCKXsrM1JX87IxvNfxfdgGn/gstZL8SCG9MkGyeTprHX69nYiheHJkPb/GrZIRVV0cfdu9StesD32y3jetFwoLl2lOiknT60+g+TWoQmY1clJHT/RKElH6zh21JI3ttBFRFtGbzzFYC/TN0DYzI=
Received: from BL0PR1501CA0015.namprd15.prod.outlook.com
 (2603:10b6:207:17::28) by SA3PR12MB7807.namprd12.prod.outlook.com
 (2603:10b6:806:304::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Mon, 11 May
 2026 13:54:53 +0000
Received: from BL6PEPF00022571.namprd02.prod.outlook.com
 (2603:10b6:207:17:cafe::3) by BL0PR1501CA0015.outlook.office365.com
 (2603:10b6:207:17::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Mon,
 11 May 2026 13:54:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022571.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Mon, 11 May 2026 13:54:51 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 11 May
 2026 08:54:49 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: add eviction fence tracepoints for userq
 profiling
Date: Mon, 11 May 2026 21:54:35 +0800
Message-ID: <20260511135435.3818345-4-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260511135435.3818345-1-Prike.Liang@amd.com>
References: <20260511135435.3818345-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022571:EE_|SA3PR12MB7807:EE_
X-MS-Office365-Filtering-Correlation-Id: 82e09cbe-3121-4281-be88-08deaf64df92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: J8TQ/8zOTk/OEk+s5bazx7FYwA1DsjnF9o8Xs3GA4mhS1nLBh3I60WjCnN7Se8CN7MayGZqN2JuZ/vErJhb7knqTByU6srjw6SOweFG+Cvr/7k43TeYuPZqb5MLNx1TPCJeC8ZrqXLgaHNbR7KnPbSpnSXudZM1MGzufolj04Z2EhmggNm80wSl5gZIxYVXzgklJce94EdCmo/zO5mgJy+eE4q5pdyQukxA8kbsHKh5gkr+rDBsOFY5G6GhpVx4mI3U39Cf0GkWzD3+w6tFBL5x4wkg3E3hajjVDwT6iTcllPVnswUyPe/GIH3Fm+xpL0BbjnkN7ts96dMmle2HAPw5HHWLKyyzUf5WGibuPr2t8zIag86Yy+6mvaN4DIMYlhnwpZ6kN4zkaGtxm9G7xdVO96Qn4SkJp7dWOpriA8FID649eRjiQdWz8RA9ufMMFtr+vT5YE+1bqmSjO+Sbxf8YnAJ1EysFAbwUcLvEMGZzCqAxZ35N4jmC/9KKHxpuGYBL35aig8hTm1LdSyzrz+X8gO+vsZQc3eXvpGNPTgwAML8odRwaCtPMk6M3P6Etkxunwb3anzFmxElsSSG/jdl5WVyHh7qE/JrCWE+PfhLHyaTYVYsR1brBvpxGdHKjCLI1TTCQxiQi9tRuVtbyvWEAPSk8KPQkv4qTuDHdsYXKSNChcDhjZdPTLFhzHeWOPdZuMVRyERJFCGtm5/8mpXTmEpSfQJTEUApinbue7Z4U=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(22082099003)(18002099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mwLRbEzrQQEdGdULl5xhATbIA9YM77VlJmlv4rwbeESihJ0AXuFAHqry4iuGITg7aanIwuaG0MZ/ZHdvEtlVaIzsytHru1xk1NYAi4q5iVgFZ662e6T9KuyR+5Ilo4lo2xE0UBtrQ2sXYrjyrG1vKuCbeeGVPhfNdj83evpjQW0kyyWe8NvM79vOHPY6fdldeI00iEMYzCp61R+bvFT9vG3j8k4NhX/OJG751/bIYj8ZPKyXxkRUO9eEfIXh4jL7ZfmPJ0n2WusgcVVDffcUP7+kLfVugUCG9GuFPbFKuiqJo68jGCsI+SybdI9/Q9M26aKxoqRsHk3AiTM9LgEYLxxLG5L3BHPYsJ0QYscetDO+YPA3IS97YAJ+sjXNv3ZDkZkTQeH56f9Qqg4wjfXhYhB6NzBsqbrWNSqi7inTMsauVa/akgm3LZgjYSbjSQev
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 13:54:51.5287 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82e09cbe-3121-4281-be88-08deaf64df92
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022571.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7807
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
 .../drm/amd/amdgpu/amdgpu_eviction_fence.c    |  8 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h     | 42 +++++++++++++++++++
 2 files changed, 49 insertions(+), 1 deletion(-)

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
index d421a44ef933..5191f4e957d5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
@@ -709,6 +709,48 @@ TRACE_EVENT(amdgpu_userq_fence_signal,
 	    TP_printk("context=%llu, seqno=%llu, rptr=%llu",
 		      __entry->context, __entry->seqno, __entry->rptr)
 );
+TRACE_EVENT(amdgpu_userq_eviction_fence_emit,
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
+	    TP_printk("context=%llu, seqno=%llu",
+		      __entry->context, __entry->seqno)
+);
+TRACE_EVENT(amdgpu_userq_eviction_fence_enable_signaling,
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
+	    TP_printk("context=%llu, seqno=%llu",
+		      __entry->context, __entry->seqno)
+);
+TRACE_EVENT(amdgpu_userq_eviction_fence_signal,
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
+	    TP_printk("context=%llu, seqno=%llu",
+		      __entry->context, __entry->seqno)
+);
 #undef AMDGPU_JOB_GET_TIMELINE_NAME
 #endif
 
-- 
2.34.1

