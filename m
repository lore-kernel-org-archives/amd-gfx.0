Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D93D5105D996
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2026 02:52:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57F3310E05D;
	Wed,  8 Apr 2026 02:52:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V9HjWBVd";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012026.outbound.protection.outlook.com [40.107.209.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C0BB10E05D
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Apr 2026 02:52:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WZSrzpnhTij7nZFbGUsqNofXkJW48hlUDIFhAcImDmtFUPVSjuQb1anGB6LFZDIS28kVS4o+F5rC56VHtKc69huoJzfA4KR6ZGhv/7MiEy7c5EV6UakVqqNM28yE5c5SiD3mBscyoj//nDsMRcw9zTiqtzoX20IaCpFGNFpktM+Rwk+htJxL25q64a1mHnQRSxHYZvL/eQM+ZwILj8LAiL1ro03YiZnsApv5WnZAsbg2GlXR74KgYGEQ4WwdCuNYPWWlYFxAsAIeENRlluj48tS7EuPyJ3lCVcTab+IXskBgkQtQfZ5u4hxxESOG6l2tdmPJ0V6y9P3U7Zyjb5LWqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nMgvMSeHlG/kKBnxt9HnZno5zeX+mLkx7JBIHhcPaFw=;
 b=eCDeLsH7EUSWXFsCjjUerLzwwRChR7iVmYxRqDHQu7XqicnKLlAP22dDOUKAigUFJ9kZF5LTrCRtYlT/NcEoVY1wx9RJSXCLUgi6FTttTJ+aPim9GkM71yz4qdqFSfOG1hhy75mHwDH/a8bBrm6KDib5g6Xe3q9iJeKOgR6pYIexAeUt8JFNIzpNdfhJsYtr/9071UbiIETDW1tz+8pyC9onjDwCjw4RwrSn5sXHiGpnNwn71ufmGwCLOM4RqTiXlLHpsbYlU0AXPK4yTIhGDKZIWU+k7n4ACOgG7IE5FTBUt5CWMtmHNNMI60Wx3VrU7AjpFxHg67k1IICiu0fQEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nMgvMSeHlG/kKBnxt9HnZno5zeX+mLkx7JBIHhcPaFw=;
 b=V9HjWBVdQnd6wtGqN77gCVPBBxZElZfCyuYRciGWb2+WDCce7K/1Nhq+OEJCj7uq8QIOAQ+vVXIq/9VIWcTd/VRJ9fRSoATV5JLayHxyYDomeNqCbcSR/2oAmqxvvBqoz6xgHBaRZYrSrpo7MuNT1VbZa4hBWvI2aoSm0IVqFic=
Received: from BYAPR02CA0023.namprd02.prod.outlook.com (2603:10b6:a02:ee::36)
 by BL1PR12MB5827.namprd12.prod.outlook.com (2603:10b6:208:396::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 8 Apr
 2026 02:52:36 +0000
Received: from SJ1PEPF00002310.namprd03.prod.outlook.com
 (2603:10b6:a02:ee:cafe::53) by BYAPR02CA0023.outlook.office365.com
 (2603:10b6:a02:ee::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.35 via Frontend Transport; Wed,
 8 Apr 2026 02:52:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002310.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Wed, 8 Apr 2026 02:52:35 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 7 Apr
 2026 21:52:33 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH] drm/amdgpu/userq: rework eviction fence suspension lock for
 fixing lockdep
Date: Wed, 8 Apr 2026 10:52:24 +0800
Message-ID: <20260408025224.3437723-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002310:EE_|BL1PR12MB5827:EE_
X-MS-Office365-Filtering-Correlation-Id: 760f39ec-7d0d-4814-0eb1-08de9519e387
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: j8BGGCWrmUQfci1GhI4PhFnqAXz94D5e+EEWwkjpKPizjjhyqoGrSmmEX7BEbfqh8JTgcapoxSfY/qMesZg5pGr0JAv/VM2yVgNRGZjlvfThN0FybAdFvem2pP9aviv0RYbsICIf+giXamWcOrfypXxgBBn7kpssP2nkXVtcv0tbuhZlzXYXatBM3lEVZtvRksD+poa+nQ8mnhIaupf0ysKLgBtE8VDlMJAqXniJgIQC8H4/dZ5uY2i7CXIQX+L4GJQIXVrwqJ2/OccJU115g6uDUTlMgfsks2w0uJ87SzFhsyP1yvnAv4Kr4ij7tZXLDKLDw1VvQ/WOVRY3petWeYOeyadzTttss4eazjW6Hll+994ryTFnF7mUyJdC9jAU/2HyCD898JOeojTuMUwQGNDhwEo/szsRQuN8nnN2WkmNxeHPGtMYqVjznk2QhleRI2dQhD5DLVjKZ48ZWANOipQ8dBALfFSArGfM/5GV7shRZmCAtjL6ene9F4MJIZBc8q3lFFlhE/1M6UQPHJJWrQxnb4ETBjejiNvfPFtGz1+jNODIIaepWqdQtHzZcJSca5c3ar7k+d7aznKQUPOUKF96SFW12OXoKqI9r8pkVqyP4qixTr1wwab3OrjSOuvRdSvFBgwY7PXfK6V4kKtjiRpRTquOPzuotN1/Iv68ar95jQnLSFXkI0jadZqAhhLrp8W+hsDXRPAjshAyRwYWq23Ai0TxPP+HVjl+5Ib6vw/bKtesMB7RT1KXM+58SCRxvPivy2MbffI9mpf3VCecDg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Ko27T3lGitldBTFSvr3KBMfKquFRKvkK0UccJpCyWOwOh0KasPmE6h4/5B1OHdzuWL2q77bpYAeM6m5Zg8s7u/gSfvWj69aqRdkdP+LKqZb5QLNkYlc7hLdYF/ybvqXqhj/wsWwfp/9zelmA8Apt5h2lsxk2uVSu4T5+qK5vuYXqu59AJKii27NiOfU7esol5Bu8lw6Ezd98c7fEjsRzhZupAyYy9ocyMXG/xSAnp7TNMMTCXc29CddGfnyxZh0PH/HhK6WPuYYM1fjnEDI3TIKQkCuwKkJGoZFL9xar20WzB6yMB2Q7P9DZdDsr9tbpz4svSnKvLBCaz+CbhTqu+fby072875meGwAKGXaXu9v6YZio6kvl8wYdzn30C2/XG4+Y6N1aWoVecAWFGYZ/xI639kL/s3bWy2ek73DYIPp/6udzZB/J+Z+EJdu0F2M3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 02:52:35.5855 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 760f39ec-7d0d-4814-0eb1-08de9519e387
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002310.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5827
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

amdgpu_eviction_fence_suspend_worker() ran amdgpu_userq_wait_for_signal()
with userq_mutex held. The helper used to walk the xarray and block on
queue->last_fence while keeping that lock, so the userspace signal path
could never get the lock while the wait fence sleep waiting, then triggering
120s hung task warnings.

Meanwhile, there also rework the userq lock access in the eviction suspension
path for resolving the lockdep/lock order issues.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_eviction_fence.c    |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     | 107 ++++++++++++++----
 2 files changed, 85 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
index 5ae477c49a53..00c450e31139 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
@@ -73,7 +73,6 @@ amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
 	 * allocate memory while holding this lock, but only after ensuring that
 	 * the eviction fence is signaled.
 	 */
-	cookie = dma_fence_begin_signalling();
 
 	ev_fence = amdgpu_evf_mgr_get_fence(evf_mgr);
 	amdgpu_userq_evict(uq_mgr);
@@ -83,6 +82,7 @@ amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
 	 * userq_mutex. Otherwise we won't resume the queues before issuing the
 	 * next fence.
 	 */
+	cookie = dma_fence_begin_signalling();
 	dma_fence_signal(ev_fence);
 	dma_fence_end_signalling(cookie);
 	dma_fence_put(ev_fence);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 9d3c39e96ac1..7691f169415b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -26,6 +26,7 @@
 #include <drm/drm_exec.h>
 #include <linux/pm_runtime.h>
 #include <drm/drm_drv.h>
+#include <linux/lockdep.h>
 
 #include "amdgpu.h"
 #include "amdgpu_reset.h"
@@ -34,6 +35,23 @@
 #include "amdgpu_hmm.h"
 #include "amdgpu_userq_fence.h"
 
+#define AMDGPU_USERQ_FENCE_WAIT_POLL_MS 1000
+static unsigned long
+amdgpu_userq_fence_timeout_ms(struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_device *adev = queue->userq_mgr->adev;
+	switch (queue->queue_type) {
+	case AMDGPU_RING_TYPE_GFX:
+		return adev->gfx_timeout;
+	case AMDGPU_RING_TYPE_COMPUTE:
+		return adev->compute_timeout;
+	case AMDGPU_RING_TYPE_SDMA:
+		return adev->sdma_timeout;
+	default:
+		return adev->gfx_timeout;
+	}
+}
+
 u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
 {
 	int i;
@@ -176,29 +194,12 @@ static void amdgpu_userq_hang_detect_work(struct work_struct *work)
 */
 void amdgpu_userq_start_hang_detect_work(struct amdgpu_usermode_queue *queue)
 {
-	struct amdgpu_device *adev;
 	unsigned long timeout_ms;
 
 	if (!queue || !queue->userq_mgr || !queue->userq_mgr->adev)
 		return;
 
-	adev = queue->userq_mgr->adev;
-	/* Determine timeout based on queue type */
-	switch (queue->queue_type) {
-	case AMDGPU_RING_TYPE_GFX:
-		timeout_ms = adev->gfx_timeout;
-		break;
-	case AMDGPU_RING_TYPE_COMPUTE:
-		timeout_ms = adev->compute_timeout;
-		break;
-	case AMDGPU_RING_TYPE_SDMA:
-		timeout_ms = adev->sdma_timeout;
-		break;
-	default:
-		timeout_ms = adev->gfx_timeout;
-		break;
-	}
-
+	timeout_ms = amdgpu_userq_fence_timeout_ms(queue);
 	/* Store the fence to monitor and schedule hang detection */
 	WRITE_ONCE(queue->hang_detect_fence, queue->last_fence);
 	schedule_delayed_work(&queue->hang_detect_work,
@@ -1274,16 +1275,76 @@ void amdgpu_userq_reset_work(struct work_struct *work)
 static void
 amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)
 {
-	struct amdgpu_usermode_queue *queue;
-	unsigned long queue_id;
+	lockdep_assert_held(&uq_mgr->userq_mutex);
 
-	xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
-		struct dma_fence *f = queue->last_fence;
+	/* Rescan the userq xarray after each fence poll interval to get
+	 * newly added queues or fences.
+	 */
+	for (;;) {
+		struct amdgpu_usermode_queue *queue;
+		unsigned long queue_id = 0;
+		struct dma_fence *f = NULL;
+		unsigned long timeout_ms = 0;
+		u64 context = 0, seqno = 0;
+		bool signaled = false;
+
+		xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
+			struct dma_fence *tmp = queue->last_fence;
+
+			if (!tmp || dma_fence_is_signaled(tmp))
+				continue;
+
+			f = dma_fence_get(tmp);
+			timeout_ms = amdgpu_userq_fence_timeout_ms(queue);
+			context = tmp->context;
+			seqno = tmp->seqno;
+			break;
+		}
 
 		if (!f)
+			return;
+
+		if (!timeout_ms)
+			timeout_ms = 1;
+
+		/*
+		 * We can't use dma_fence_wait() here. Waiting there and then
+		 * reacquiring userq_mutex creates a lockdep cycle through
+		 * dma_fence_map:
+		 *   userq_mutex -> reservation_ww_class_mutex -> dma_fence_map
+		 * and
+		 *   dma_fence_map -> userq_mutex
+		 * Instead, drop the mutex, sleep in bounded intervals, then
+		 * reacquire and poll the fence signaled bit.
+		 */
+		while (timeout_ms) {
+			unsigned long interval_ms;
+
+			if (dma_fence_is_signaled(f)) {
+				signaled = true;
+				break;
+			}
+
+			interval_ms = min(timeout_ms,
+					  (unsigned long)AMDGPU_USERQ_FENCE_WAIT_POLL_MS);
+			mutex_unlock(&uq_mgr->userq_mutex);
+			msleep(interval_ms);
+			mutex_lock(&uq_mgr->userq_mutex);
+			timeout_ms -= interval_ms;
+		}
+
+		if (!signaled && dma_fence_is_signaled(f))
+			signaled = true;
+
+		dma_fence_put(f);
+
+		if (signaled)
 			continue;
 
-		dma_fence_wait(f, false);
+		drm_dbg(adev_to_drm(uq_mgr->adev),
+			     "Timed out waiting for fence=%llu:%llu during eviction\n",
+			     context, seqno);
+		amdgpu_userq_detect_and_reset_queues(uq_mgr);
 	}
 }
 
-- 
2.34.1

