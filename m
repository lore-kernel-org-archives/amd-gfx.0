Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C689CD8CB2
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2026 06:04:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2EB510E71E;
	Wed, 10 Jun 2026 06:04:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="N5fSnjFc";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012009.outbound.protection.outlook.com [40.107.209.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 236AA10E71A
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2026 06:04:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ImQplZqtf6tpqTDtxMF2nZdAOhYb++qw7yZHiq6bO8bSmIjBUo7btHbFiaIMFWQL4foiUK3MNtBsh4OysUEWV3CpDkjzfIeDDHn36Qwh0zhvLBIrLRwhVN7XdMQCrhMmKNJ/aeOssVlgABE5bRTdZRne3V9hQ2x6F4SKIrO4iLaMnuZpjLsLcKdKm8zR7LpBoNUjjHpSk/+Xo0DcWySzr0TnVsK0eNsR0MGy8/pz9CedYQ6hB8ht+A4uG/vCktvv4WwVugm5PXSh2L5BUq0Z4AgHma+Qzq8LfXQsHV5M/Xi2GbV9Bs0/0OGODQoDt5jOt24qFauZCYhDY+9+nZRk7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aBnHU4xudgDEY9/VNDoqWq0Zo5E4Ptxoazwj6Hfa1lw=;
 b=utaLz2KVxjqhIixYz8E8nL7opaoWF/PU4vS6zqM16BJqIioiGqvpTYsYec+VQOBRLbIjKRhrAaukDNSPF25qVFQ69LzlWw3QdI054JS+cqG5O99ZkPUTr6YGVzklanH1Wac/aNUWtstYkcwKAeuFZWew+gmvyu8c+rbdVjsO7b95nij4nG2W2mMZuXfyWmzCrmStV8QNluGbfXTjWsHTbytI40y8j1RbIS0i14U4RdSD95p2TDz6GbXAtFPvXRTiYmo+5qsRX96xaIYzLZNFVd1vzXRrtWr/JDYyaOMvAtPoMZFnZVaySaeNP2l2PHchtb2VFNn53ounbxA+q43zwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aBnHU4xudgDEY9/VNDoqWq0Zo5E4Ptxoazwj6Hfa1lw=;
 b=N5fSnjFceEHCFjGEV7kRgAKXYl2icRs2ly5JVCycDcFYcFFsZFHUNtS+LBdXiDcNhxn8k7fhOh3VUQMwc3/fevOLlXMYZh36DA5UyRyEvfXRI04wWc8vKUOZcaBB0NeTPGID5ZUtcpVWxMxOf0BjUuwNyfBQKND4F46HKGsK5eg=
Received: from IA4P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:558::14)
 by MW4PR12MB6875.namprd12.prod.outlook.com (2603:10b6:303:209::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Wed, 10 Jun
 2026 06:04:42 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:208:558:cafe::27) by IA4P220CA0001.outlook.office365.com
 (2603:10b6:208:558::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.12 via Frontend Transport; Wed,
 10 Jun 2026 06:04:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 06:04:42 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Wed, 10 Jun 2026 01:04:40 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v10 6/9] drm/amdgpu/gfx11: Signal USERQ EOP eventfds via userq
 manager
Date: Wed, 10 Jun 2026 11:33:59 +0530
Message-ID: <20260610060402.2769642-7-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260610060402.2769642-1-srinivasan.shanmugam@amd.com>
References: <20260610060402.2769642-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|MW4PR12MB6875:EE_
X-MS-Office365-Filtering-Correlation-Id: 7897aaca-4854-4537-1bab-08dec6b629d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: /+pGg0rUGULKwPu7jP4gHoMIEZkihy7hqnWDdBFljoqqOQeDuzE0wtchGNLAFx44Xw0FMy9YKx7QuYqXvrTHmJSPko2cct5ZDU/bnxN2mWuYYxXdic24QJHCpr6e3PxFop3vkIUPVEJcME+24hklr5eEfpH5yA5QOLx9XgOOlWrc4ZKUvA+aINekThpFX2aA69LgV++0hm5oXqLrfAwIBsDnQVAdF1015KVsAnAZPPISEXI5N1hQ6Mk0e76zp6t9PhZP5xJLycui72EMvWZP10mUxwO+BwYKJIwS8zgc0H8pR2TAnnXaHx6bbRz5gYQz4G44/XZslgrCWp3KMi7uTE9mYkVMJAmDVaG9rMyAmPOImLis/DLMTd2mUXLxF8/hYYIZpQL+XlRRouGgIA54twewzDUqjt7v2h5PIT7bEyXDmizK8rSnPei2/8rnJpRYyVFHtWaA6fUSOrflWTfc+x8qkuP0PUQYT9mftKEX8LlWhMnQuQwjHJpRejX79CMEUapzgPOV12fQ1xxUmvO5XRUfrnCmZk8LgeqU0NLaGKrA2C45WAlBwPc+DXt/OP9DQC20nUyHVgTp0fnvIRtNdSCfAJP820oBr4N46M5DGmFoHbswyXpSLyDMncM6hH8sstfFMKymY939sZz36wIX0I9Vw8hW4zGAAzGFXtydFq+Hc7to2B+eQTN1TdDwSyg7N762sQ9CLXhxCKDD10GvvLIQORcd5tYVk+UVIdLusYY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: c38NIYh73/vTERXYctSCoCGzmuzzi8g6xeK832fss0iljouvonRbN/+Xp9iNiQsFK6nKCTtwdP9DqhvGJ04I86cqy2Sxp0w5ahkzH4HHqHTF+iSzmg+rGj+XnHH2WaKdXzDV3Xsg8f9NQ+ClBVsqEy2JalSMSDGae4UGx9U6O0Td6Xzbtno61/uNudjNEnDIgllyEAFdCjQUBk+2GAFY9qlL7DkZta51ZnkljZX7AmA6riAOsNMumZlxK40WpP1fgtBfnOGvzb6+y9DFtqCKx+DqS/oBU7tBGSwEGcblzyzu7ndMXH79yxx7yWceqpYUxDOucXFwbVWzaKKFc1YRBjKMGBp1CqztTwMsVesZyu0ww64BKMWZk0nk6fzk/IiNzTZyjFV+bwkZLoWjLMVmfhQ0ZfSGZmZCdOhc0q5wzQqB6Iw8OcqeRnHXoJ70Laib
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 06:04:42.0822 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7897aaca-4854-4537-1bab-08dec6b629d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6875
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

Signal USERQ EOP EVENTFD subscriptions from the USERQ IRQ path.

The IRQ flow already identifies the user queue associated with the EOP
interrupt. Reuse that queue object to signal queue-scoped EVENTFD
subscriptions through the user queue manager.

This avoids relying on queue_id or doorbell_index as internal routing
keys and instead uses the actual queue object associated with the event.
EVENTFD subscriptions hold references to queue objects, ensuring that
notifications continue to target the intended queue without being
affected by queue identifier reuse.

This folds the earlier intermediate gfx11 EVENTFD hookup into the final
queue-aware signaling path, so the series introduces the IRQ-side
signaling only once.

Signaling remains notification-only and uses plain eventfd_signal(ctx)
once per matched occurrence.

Changes in v10:
- Replace queue_id-based EVENTFD routing with queue references.
- Pass the actual queue object during USERQ_EOP signaling.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 1941bfbcbfbf..9727da9c4224 100644
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
@@ -6488,7 +6490,23 @@ static int gfx_v11_0_eop_irq(struct amdgpu_device *adev,
 	DRM_DEBUG("IH: CP EOP\n");
 
 	if (adev->enable_mes && doorbell_offset) {
+		struct amdgpu_usermode_queue *queue = NULL;
+		struct amdgpu_eventfd_mgr *eventfd_mgr;
+		struct xarray *xa = &adev->userq_doorbell_xa;
+		unsigned long flags;
+
 		amdgpu_userq_process_fence_irq(adev, doorbell_offset);
+
+		xa_lock_irqsave(xa, flags);
+		queue = xa_load(xa, doorbell_offset);
+		if (queue) {
+			eventfd_mgr = amdgpu_userq_eventfd_mgr(queue->userq_mgr);
+			if (eventfd_mgr)
+				amdgpu_eventfd_signal(eventfd_mgr,
+						      DRM_AMDGPU_EVENT_TYPE_USERQ_EOP,
+						      queue);
+		}
+		xa_unlock_irqrestore(xa, flags);
 	} else {
 		me_id = (entry->ring_id & 0x0c) >> 2;
 		pipe_id = (entry->ring_id & 0x03) >> 0;
-- 
2.34.1

