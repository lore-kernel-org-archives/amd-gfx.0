Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC2DF94CA1
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2026 17:59:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D343E10E913;
	Tue, 21 Apr 2026 17:59:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dbXi/4/f";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010008.outbound.protection.outlook.com [52.101.85.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C631C10E916
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2026 17:59:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KtRKJG5IhtjZUzOfxavjcnb3ugDsIzm2PahF0jZVaA7EOdfF7Lc0HmcEhOo4oLSk2j9vQMD2GsbyofpZ71CRGiMUWQnsr1nSM/VWOjtPKDaO0D5zkSemadAvzE3rQUtZ2dH9ggMW2tpU/78yZaz8EIu0oADOq+5oSjHR6gvIS0KMyG68SuLshSxO51DTvWrCsLUjPLidRVwyRvtBAbKeRf+Qj/0fRkVnfxbwDrpLdlcnA+Dpf6fVkRKs+IZWqMc4o8vNzZj05Be1oGrAtuuEVYQEOWcGoCl8OljFbEJ1uJyhC8IZohG8HimgF3+5a7iYQqzpS2QGXzdVdd/FY0+M9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KCE9+pVjBdJ+NvT3qURzIl8F9KiBa8kxI8H60zQR5nY=;
 b=JFzosRWeqFl7ep/scFzljHpjCDbXBaryCm8dAsoTdfwnEvf4l8D4R3FIGMky5wWykGQHonW3D4gcT6sl5dji60Nob/1N0K7jFsQ0Gl6Qb+tjdOesHkpypib7PndRdhJOqZ4ZykOB+sA2GqyVXbjLXjtpNyuxf6TTIJhGOJW4QaCjTnTSzAb8GkSyflzaFozqB9uBIDyqpZksZu0KU0lYPA8bZW27znUdJRnhoQHd8Rw1I6Y3eMrAyzFNT1FefCLunfF950kvOXgWgF/RSO4C1ed1NdlfGpQ2pGy+Y8MIhb9mWZecvAjIpHD4FNkYmwA6WKh+InCcnyw+2lS1x3N1XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KCE9+pVjBdJ+NvT3qURzIl8F9KiBa8kxI8H60zQR5nY=;
 b=dbXi/4/f1sY0b/6F2upvkzdmv7SRcLXu+v04FK1F6Zg6n2Yi0MtXoogyW2P7BmtZd3t6b6vQReYg92Be1Q1hs9KuSzlt0NOSuMCG4Ljd6swvnq2LS/fMzJDCAYooG4VU0cST7lGivKSnhHZ3lSb4iTxQ9PV0RzaoD0uF02N7dzY=
Received: from CH2PR18CA0030.namprd18.prod.outlook.com (2603:10b6:610:4f::40)
 by SJ2PR12MB9138.namprd12.prod.outlook.com (2603:10b6:a03:565::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.14; Tue, 21 Apr
 2026 17:59:39 +0000
Received: from DS3PEPF0000C37F.namprd04.prod.outlook.com
 (2603:10b6:610:4f:cafe::95) by CH2PR18CA0030.outlook.office365.com
 (2603:10b6:610:4f::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Tue,
 21 Apr 2026 17:59:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37F.mail.protection.outlook.com (10.167.23.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 21 Apr 2026 17:59:39 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 21 Apr 2026 12:59:37 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v8 08/11] drm/amdgpu/gfx11: Signal USERQ EOP eventfds via
 userq manager
Date: Tue, 21 Apr 2026 23:29:05 +0530
Message-ID: <20260421175908.2402019-9-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260421175908.2402019-1-srinivasan.shanmugam@amd.com>
References: <20260421175908.2402019-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37F:EE_|SJ2PR12MB9138:EE_
X-MS-Office365-Filtering-Correlation-Id: 680131c9-9653-4e2f-beeb-08de9fcfc21b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: QWvvNhno6v4O/yGcK5MjZ0CMIzf+zXcacVqDSUiKfiLTEu9bA0AI/f2ErtB3wveCDVdQKHOYS/rxBwqpJ3drhmI2hxYKCPAcA7TVy0JcD+4YY2Cu7BgltvNBPva/+rdW+utMkC1tc7PqFMMpjwlcht2Zx35bmC3FF9u/TXL+m5Gam+mySvSK9Up05AoqfwXo0+9/Kk4rEPD/TcQIt1kWKC2lW9MG8EQsDCeoqwMm9VXeqtjeJ8p/4ZQoaESyYxWipLIKNJpmkMLTQUpFGADzmllr8F5wbY0pFEytpRdZCOuwR842BKxim8CdNDh8SPOuVA2WTeB1yI0bxCsnpV8xjarZBd2V+/JXWbMIfyMUbS0B3dcOb8sRx12vuONeXP6c+6YJc55i39yeCGdEE3yp5+4ElKcufQLD6JtB08B/MgqVvjSt8hjp139c+Zu+2KsyqHYPMrRhXRWFaWwnndWhA4NCLZ7+4UU0r905nlkAsgYF+3rK9ohwYPKCxF6jstxU8tqg+xjDidhmv+UFo85pGJzi3gfqHH1LzC92qBqm4uFPBrc5Qh1pMe8QrDe/UeKONBEN5c60pdaStWuNflbOVRpjhGPS21JNANxFoiCVGBJiDG8DK/5ioBgyTHfvMaCCZSX+gtaRb/SyxlvH4o1HbsXrUNyneiRWC2KeKOaq7IkUXfCP4XrSD4orLO/B4GxULlcd1CKE0vRp/KDVPhMDVrX7bIIM6PyhknSEJfxoBh/FFga+KgZUD51U2ydPGL5sCgQ3XwR/wPYkBbH9yOWXgg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vEDIOQe3i7KNtCn+2fTgCUDPPpvtDyh/Ty6igxD8ckY2hsmpiz8dd0E3cB/delUGkhK/Y6+2QnW95mmnqHFrQXCHpe98DrmV9F9mnPwltoXANXN9qTAbZYf+Jfoomwm6iTqjMATJyD05OqG3LsG9q6eEzIyy73rXH1lw7se+SbFKag8DHdIGy/w0M/5hg4khB8Cn6ZjuMDd8pFgUWpE0uSVQq22t9TASLwdbqcU3gX/1IsxmvrO09ASgsyB6TnIqZzs3GIJuxAkqkhWqJ65T2MP0KSp+EG8e+7MMFdyGM9bvo+bZWkwBtJGNlhCfI4FK3CrEtTe/6WLH0DbImHQgSqKWNXPpGGqOyZdGbGCQXTinfOjf3BvgBF1ThPzbJ7BRMnlbs+NGZIU16Wgdh7+2LHKr0tnAyC1n9Rf32rGwNPUI+wYGZt34rUBIQlRLmHSa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 17:59:39.6039 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 680131c9-9653-4e2f-beeb-08de9fcfc21b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9138
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

Changes in v8:
- Use queue->qid instead of doorbell_index for queue-scoped event
  handling (Alex)

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 8c82e90f871b..80379530164b 100644
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
@@ -6523,14 +6525,27 @@ static int gfx_v11_0_eop_irq(struct amdgpu_device *adev,
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
+			queue_key = queue->qid;
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

