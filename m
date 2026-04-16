Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83195F433DD
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2026 03:27:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2773910E7D0;
	Thu, 16 Apr 2026 03:27:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sVTet0T/";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012027.outbound.protection.outlook.com
 [40.107.200.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C6FB10E7D0
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2026 03:27:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YxTUiVy2TuXl+lyH95lfEXNM2S0UgH3/WIZ3IEUCywv6MO4hs4x4mAf3aDzS3ep5RF8FlL6XFFXrLPwSqQ4VQsMHWqGI3RAwBf0kGAkOdzC1/3hFCsY4ZSzDTMDjz4Jlxh2ixa0Btf/ezGxKXNlTLrTJ92MjuiwCl/RYe8n3rSj1IPmGcRDI2g6R0VtnF3l5sSqfbMpo7y9DIHZMdoF8WNSIiHv9hrIF6sjT1pCjAG55tfU5DdNqJ7CvRfjocFVS87QeaSJ+MnQpAiY6CWCNj+NJA3HURGcZR02gaKfJwI57r5IbsO21VXM6OQcFO7sjGo4F5abKs1fvxWkF6Q7UtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3NU+YseLVd3Uh8SlUz0GzVyqkq3seMZmJDhljZg+cLs=;
 b=VNGPrJbZN+hkDvRlX279LexaU9kOpY3RzdALufWon/ZpSHWfk72aXvHBOArfYKfDxGD4nfYxLqtbLLUEDQifBP+URoTRBtuEfAXPRar3z5WPGv+uP3hSltkn6Vl0lbEJ+qNhSFVarBNbbVS956fayi5rbT27Pb9hwEY+lKyi5hVwE2q0JP0cAE1z/gt+B9GliKZuPbip2gpYsazm2FCySaSM43iWclEZUjwp1ZOQEfvUHViE3kSsdAz29Sntzti4+iSmmXSnR6+jTk2DYQ2iaNaxjFVxjZmFq49mERrcEKpAc22PrD4mZKume8XRjMITL4lUH9TljYkVcQ53qiEUzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3NU+YseLVd3Uh8SlUz0GzVyqkq3seMZmJDhljZg+cLs=;
 b=sVTet0T//8bNs1BwuJVNBrlGZwaCy1YxXEuOHqtlU6lSIrbKgB2CMil11fUlcw+RPRIvzbDH0EniE07pU8rmGSVNxGGxE7+b2YgpBfaw3lRzAvSgp35r2I+UBTKJ97adj3QXeABOjJp3UmVCOROykiLM6+bz4Lm+O17cWGtDBHM=
Received: from DM6PR07CA0084.namprd07.prod.outlook.com (2603:10b6:5:337::17)
 by DS5PPF8002542C7.namprd12.prod.outlook.com (2603:10b6:f:fc00::657) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.21; Thu, 16 Apr
 2026 03:27:33 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:5:337:cafe::1e) by DM6PR07CA0084.outlook.office365.com
 (2603:10b6:5:337::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.51 via Frontend Transport; Thu,
 16 Apr 2026 03:27:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 16 Apr 2026 03:27:32 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 15 Apr 2026 22:27:30 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v7 07/10] drm/amdgpu/gfx11: Signal USERQ EOP eventfds via
 userq manager
Date: Thu, 16 Apr 2026 08:56:56 +0530
Message-ID: <20260416032659.2368054-8-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260416032659.2368054-1-srinivasan.shanmugam@amd.com>
References: <20260416032659.2368054-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|DS5PPF8002542C7:EE_
X-MS-Office365-Filtering-Correlation-Id: 43d2c1bd-9cee-41f1-12a0-08de9b681893
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: lN/qJ71SauQ8G+DhlmNQZ8Zl/vA/NiEeZl7v5plHansQ+H1RpvwcK0TgGWLfct/cHTi3LXdmlgXawM3EMG+rJ7Z4xsvSxCTzRBlowcpcXCnmvcwdca6vKibLvrGlEWxyfyPez1f4lpn2XIBvSd+C52buv7nEXFI+osXshQX73M0nph0YIAnYSw4xGISzrPS5NTSITH1dtMaYv+pYkolUMAHtEzLteXmEwEa5GDspLtXXpvNmf0BDpguCs7AD3ZHL2eCS3Gb6yht1+AexsxUtDMcZh1m65XCNzeaNMTH0wVBgY3UiLadGoUXGIYgEmPg7HnhG23qG7QNrJzy8JCGH9fRpyhdZkuOnN+eymMGPdZpavSsSG3WIGFO5yA4qFjWXVSptSH87SB83a9zlIBADAygCygw2srToJYF7UYEDWNICTS8aJWsj78tY6Ud0B/qGYllMusAf1GHxwqmH5fGP6MLd+hU90y7LXoc4p3SLBelT6pBvgFLQKWpmL77yWKdU43Ev7KxxolmhaHA9yZJ38XgVWa6brVaL0s4DrWvpAOg3sDTaUFyGmQ0apVzKA6MXXLCbXrOTsN+NNgYV5irGn2BA9grYWma3pq9ncFtuOiRrcazY1ZaHWXJj37XCmkyBejt6kRy56vUmsJY1hwTJEVhWgv854JGax4MbJfg8mcBgfgsRQzyoRpETOA0OMvpY7P2XtcsqHc5nF42ONc3u56ir6xS930NuloTg1VtpDOIxeJm9TG3TqZaJH9W0N5HdtkVNtyLdqiBvVUC1SZ0fog==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tzwsmpHTM6O3c9gtW5niPjk3Uz3i5jOqCXcXL36YRhoNM1wfyPfsyYermorPBTzVNPPS89k4NlESYplyUk+s1oDL05bsVlD0MzP+JMcSZNVhDDPAlirnRaOzbjjqJ+DgGNXxRQ21VhvDijlUry2gqofVQmr+UCzqLAqy6kBi/rDcDsfSU1ZCZmJ45A58QXL5teMadHMtK7CiiaUsHHF4TpI3MJ0GtMFreA4lnRIPR7AI1UJKBtNlsIVQ3gn596LWPB3iKicFf/gjNxdwW/U1zwm+XvDiAaBdhuT4amde4ADQCK1/9HqEgigR6Rbrjc4WYJcUDKHhJatPL5LbrjZY6MmlbJy2ALmAM10bkczGi9bTnkeumOKPlu9i1vVWWQkV1MRuiA8+IL2Pf8ycejXtjlBUCeM4QYEzGQVpcHV0pU8GlX0CftSp6NClyyM2TVzR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 03:27:32.3628 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43d2c1bd-9cee-41f1-12a0-08de9b681893
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF8002542C7
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
index 8c82e90f871b..ff43902a9c48 100644
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

