Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35F3EEA3C48
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2026 10:41:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C113C10E797;
	Thu,  9 Apr 2026 10:41:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rFHcIUg+";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013013.outbound.protection.outlook.com
 [40.93.196.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D26EA10E796
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Apr 2026 10:41:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KV03A5FxYzBTWgwsunCqJd4M14YN2j0eO/sPnLsGfISqOlGnrOTrRKqI/HnaMST5e/uPqvCZrTEdZBAYZ/YAL9zKkyxH7m1DvmQDteMMXdWIhLN2NPtqvdbj690vh9nVu7yKQp/DTnD3hbqsqF96Vu3xgvAoV9qY8sOBVPcDDL88kdvjvWu8ejxMstQThw1u1OL/LCHTZFp0KJ+RXywmkb+bo1LHNxM5Al4NVTWrexSSLF9D1N6CVmmyKmjjB+1nhqslIKxemLu0znNMZ1FBuqlXGClnZ5ktk8DVeql2K+cIo1fEk3r9XKkKOK7KMJ0qG2U5X6BNtMqmGhMhj4E0oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pJLbbXMQyL9alljzaAjv0Gg5wdHP5C3ap4jXbjbXJO0=;
 b=rMeZIQhIhEYaMyhdRSZi9z+N6Pj/pOgsEVWqxD/UghYCdJmDzR0JqnycaawsgOL0sYpXT8/G7bhy/LehuC1Tt+aCyDNb9KsqZi2R5X/Qs1VdCLn5J2uqBKqarU2EMMHn889iQZg6Jvx6jfv5XBpaGPRfIxD/u6UHZ2273Bhgv4Q4e2jc5Di2j/7E9nx+c0ll22hGVrb8A5uzA59yxhHOBVTwo5ikXkr64sH/nub0tTrLbhy8br9mrjkhUA1LuFd9rOmKb37H+nEuFOfbMvE8tpVf4zQm19p36dOJJ+3lvwxmcfOK7sbu0bpULl2n0fOCVKZ+CEfy5D2dCpeYG4imjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJLbbXMQyL9alljzaAjv0Gg5wdHP5C3ap4jXbjbXJO0=;
 b=rFHcIUg+J3WXQ4zn9u0vwTCbKRG9ntIZ7MrHO/OqyUBq/jOzc8YYw9iiuyYx5cse3jImsH/YBhHMu/0SOCk+8B5BjIXUq+Dmoe1Zu4GbnVpKx7xT/nwvXgNqFmWVmyMSSfNBBZFTRWMuAzy0o2zVBqCKcdP2gOgpm95GnunFMfo=
Received: from SJ0PR03CA0175.namprd03.prod.outlook.com (2603:10b6:a03:338::30)
 by LV5PR12MB9804.namprd12.prod.outlook.com (2603:10b6:408:303::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 9 Apr
 2026 10:41:31 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:a03:338:cafe::48) by SJ0PR03CA0175.outlook.office365.com
 (2603:10b6:a03:338::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.37 via Frontend Transport; Thu,
 9 Apr 2026 10:41:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 9 Apr 2026 10:41:31 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 9 Apr 2026 05:41:29 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v6 7/7] drm/amdgpu/gfx11: Signal USERQ EOP eventfds via userq
 manager
Date: Thu, 9 Apr 2026 16:10:57 +0530
Message-ID: <20260409104057.2284155-8-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260409104057.2284155-1-srinivasan.shanmugam@amd.com>
References: <20260409104057.2284155-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|LV5PR12MB9804:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b01d6c6-54d6-43ca-8fd9-08de96249031
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 99P+DyuAjDq5R2x9gLAqJpVLQCf22O5sGbYhiDN5ahfO1gvo6dQcxq6zwpMDYK2/EbfOODrAcahkCK5rQfv0nL43cBtd6sJsAScf1UinMqTjbH13GYZ7JQwg5uiTQ54SSaSRhQxMQvPRL5X7OFCqPdhocLX01veJKexHHVeBpZ7DAcxj1lYAUwhXT9mBHsYBcjmnkjuohZhPNRc+EDn29p95x9Sum46RGVgSjVZsuQ79hHv/dh3k+7zZXlfULNvu7FeHHUv12qVzvdq+hlVMVFHh3TF2V2xFr8xAJVFe7wxnronKTnf9u5aIcrJiNocixcJizVqEOY+x6jr3U1RFhCeK9rpAD4arxt1IXAxuNEXEyFv/Qu3Q2cRiBEF3K39qt0EUSEfi+BckvcIVyyZOrMFzWixm/Lw50udrLK1NKmFj7XaJ2hL7y2H1gFMjLg8GSWiydi4lBJhxfDw7Z1nW5ij80id1mDrNMcsmB/ghY3sWne0o0rLNLVGKi3ZmsKCReRTmrDgqKoFQcNHSArRuZImPWTA5Cn+jIJjeU+RJ4hVyyjQw1TLIt/WtMkEeE7KlBIFpUjlM3UQE0g9GhjKaBIOJE3wx9nKgKqGuwwXjnaA2bBUgoEGUKVSdM7EOz0IYPPt+VpLet3p7+I/1Qzmb7fAF3C6uRg35p4NxzjiEiTFwg3Zd359NYP6aEl+Z4aWrxc2T1SJMNPu3Lt/2HqKnrfegSFtKky7lI9ROxp5N5FOfyqkCvOX8Cwy+thPDl4omxna/kZaSIWAdbVTFjE0jZQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nFqRNnnd0sy9WVNN4Ijb9/MqqPYhPJ6/kuXWjAfrT48iJ91muwr/WrjfGYynCFBTUekvGnUqw9XCjV+r4FNiDlw0RTznUu8cRgqnDqMLXKcO0tOjZVtqo9BhhENGXgIcg7Lm6fCtCbJ++VCnbJj6PYBeXMZ+qf1ejsRF7spbpX7crShGjgD5ptO4pqA68Qyabode+BjUoDGZJvg8lcdHaE0tCgLmrGuMeYNYAKMRNFaaY0FoXUHfzsXUsAR8sN/MTQZUz/tJ4SOnZWaF8HpUaooLHPMxzf+P8fE20I7hf9EIkYSa/YVWZDiPTYqiokPdoPAyFbX62HnV2mtQANy+DG+Hmbx+cDkt0InW/U90PHMHATyQk3IsXHvKxTL352k1iRwjClAkx9F126XlgvypkcCsMttC7Q6Sf9OUvvAmhrstut//6nPaFQuvAhiIKBN4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 10:41:31.3948 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b01d6c6-54d6-43ca-8fd9-08de96249031
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9804
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

Signal USERQ EOP subscriptions through the userq manager associated with
the queue, using the shared AMDGPU EVENTFD event type and a queue-scoped
routing key.

In the current USERQ IRQ path, the queue object does not store an
explicit logical queue_id. However, it already carries a doorbell_index,
which is queue-specific and naturally available in the IRQ flow.

Use the queue's doorbell_index as the queue-scoped routing key for USERQ
EOP signaling.

This folds the earlier intermediate gfx11 eventfd hookup into the final
queue-aware signaling path, so the series only introduces the IRQ-side
signaling once.

For USERQ EOP, queue-scoped subscriptions are matched using the queue's
doorbell_index as the queue-specific routing key. Userspace passes the
same value through the current queue_id field when binding or unbinding
EVENTFD subscriptions.

Signaling remains notification-only and uses plain eventfd_signal(ctx)
once per matched occurrence.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 5097de940a19..84ffacdde97d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -26,6 +26,8 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include "amdgpu.h"
+#include "amdgpu_userq.h"
+#include "amdgpu_eventfd.h"
 #include "amdgpu_gfx.h"
 #include "amdgpu_psp.h"
 #include "amdgpu_smu.h"
@@ -6502,14 +6504,27 @@ static int gfx_v11_0_eop_irq(struct amdgpu_device *adev,
 	DRM_DEBUG("IH: CP EOP\n");
 
 	if (adev->enable_mes && doorbell_offset) {
-		struct amdgpu_usermode_queue *queue;
+		struct amdgpu_usermode_queue *queue = NULL;
+		struct amdgpu_userq_mgr *mgr = NULL;
 		struct xarray *xa = &adev->userq_doorbell_xa;
+		u32 queue_key = 0;
 		unsigned long flags;
 
 		xa_lock_irqsave(xa, flags);
 		queue = xa_load(xa, doorbell_offset);
-		if (queue)
+		if (queue && queue->fence_drv)
 			amdgpu_userq_fence_driver_process(queue->fence_drv);
+
+		if (queue) {
+			mgr = queue->userq_mgr;
+			queue_key = queue->doorbell_index;
+		}
+
+		if (mgr && mgr->eventfd_mgr)
+			amdgpu_eventfd_signal(mgr->eventfd_mgr,
+					      DRM_AMDGPU_EVENT_TYPE_USERQ_EOP,
+					      queue_key);
+
 		xa_unlock_irqrestore(xa, flags);
 	} else {
 		me_id = (entry->ring_id & 0x0c) >> 2;
-- 
2.34.1

