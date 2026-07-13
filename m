Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48ECAC44507
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2026 16:27:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2AC210E628;
	Mon, 13 Jul 2026 16:27:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dVnP52TV";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012052.outbound.protection.outlook.com
 [40.93.195.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1690110E61E
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 16:27:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yMpxnWf605p48s/GWq8n+U8ESyaYC+CMR2q6YGHHRIKiDnYg/tEeHYU1oK9wTeixZvfhZvtACpDen2RXU8kBw2nJsqkJbzsLPCJfWacLDThmtGoxhC6Dq0myyItjdyb8bE4viBD48NwfVqZl42SDQ5saJQ6zS8awSVTg5S26JYRjEujQdApbpbZsR04nhNNd69H9TBMXCkEuTD6aj/7gIWIImIIoLKW2EtQlhkZiglGvsFFXRLrYbe/2xTiwbQRrkVQ69PsmzNL6TjP/u070eNwvLya67zDcDbLg8ydRTMYcRfi5WNrJ6oB7DVfdNMR3lKYfZ2+tAXsKimYw3mL9Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZPM9gQlSp5swairuwP+gqq7ujF3yNsWE2H85NznLN/s=;
 b=vDiWGj1s2X3PGvjYuQVcWfGJET8R1SA5APaoctYzKocszMQz8Mj+UMgOvVqA9XhCsS3LDwsXAxe9yyVE7P1xdIpgEzL6+Nuc5JZeFPCgHIKrROi/a+f9JY24oC7+XjhExURiGAYF2DtWU6Xrm2tabJSnoskg+9PzJfiiJjLFQlu8A7phGlis7KN5cgNgTxOCgEby7KRwx63msXny3cT84Xj11DIHckr4atKnvyLDy3yJxqZjc2qZ/37dlfeeXI4qJyrZ8Fp7yMZgYjwuAhyWQljCY91IT0n/s2EZWQJxkd+wkEF999j2PAqtbBkTw78aCPA//2t6nGaM1XbdV2O9Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZPM9gQlSp5swairuwP+gqq7ujF3yNsWE2H85NznLN/s=;
 b=dVnP52TVhgAFYBPeZNH3is62oPimgpMuzHFm7H7Iuf8y+onHSBuTMGZPRI1dbyMw9vbLZYeShx44/P7ipzV+lXDa13GadGbZar3JePA/Vm2nWrF/8gKuLzIC25/KxKExF0dcWY4/zgkzSvkTuVOdaus0kfdv9dgRm3lvfJ+EXM8=
Received: from SJ0PR13CA0097.namprd13.prod.outlook.com (2603:10b6:a03:2c5::12)
 by SN7PR12MB7251.namprd12.prod.outlook.com (2603:10b6:806:2ab::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 16:27:48 +0000
Received: from SJ1PEPF0000231F.namprd03.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::6d) by SJ0PR13CA0097.outlook.office365.com
 (2603:10b6:a03:2c5::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.9 via Frontend Transport; Mon, 13
 Jul 2026 16:27:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231F.mail.protection.outlook.com (10.167.242.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Mon, 13 Jul 2026 16:27:47 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Mon, 13 Jul 2026 11:27:45 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v3 1/3] drm/amdgpu: Signal USERQ_EOP EVENTFD notifications
Date: Mon, 13 Jul 2026 21:57:20 +0530
Message-ID: <20260713162722.3349626-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260713162722.3349626-1-srinivasan.shanmugam@amd.com>
References: <20260713162722.3349626-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231F:EE_|SN7PR12MB7251:EE_
X-MS-Office365-Filtering-Correlation-Id: 0605303e-a136-4b5b-ba6c-08dee0fbad2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|36860700016|1800799024|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 4zTxp3bYK8h304mFU0FViL0MpdBGVvM3VfjscGAP5+2hWRO/Qq6VfcOKlXeTleGqUiYsX3MF/lSNyHXDsFoxcmg0G1hTNFBwhELlcW3PHvV+FTnzCPXJCJK82w9+PWa8dcWHCZKrxmDb06SvGCDMKVmfYlY2tS6motThmQYlJB6KEYbMPE6lqwu+EcLJWA39goomXk5MuzEn7AnPVHV6/grJ2+eFIYPibQw6q62QQH7EANM6U3vX/2tMh87o9Reph1PceunXTX+BQXgdxK0DGoWF2m3hx/9EJ8s6o08dIwcl3CH4jwdDJ8L+Z3gBNZlBLTf7tXPtzTpb73tFmM/vd+OsozlKYIgRyJKYpNgKn5uQgHAWUHeCKwrYtkbqIr1tLcx6RZ0FioZhDDnASuvRNEaon+jCW4wmOiwQ2Hx4BGAAFJZBrylB6WXlsbo/pbRU6wFJkjduB1CLWzinmcf7zYSLsIQZzO7awrf1di0ST08n9J6Rk5F91Y/nltn0yhKKFQ1NRqhvDoSjqR3cKI/UZ04NfYaoPGlf2HP9rWqYy9+q1eQaK/YXq5qwZhiZz/7VGqNQnT3pNJ8os8HP8N+7TLyfjKTEL4pKv2MNknHQ9lwwLGD8dDuZ2RuqkeHq6zDIw5e44dOIxGQBGRiv3zU9qT5j3GQR2duZ7acg73humgkvA+LPZdrf0XN6QE4a1K+yFXTPrgGtGzgW6/7alo7+Wg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(36860700016)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HKeCDVPtoKgFzVYKhv6z4fjLmNsKrZ4POQJkHxm2Z5tRfLI3dLz7P89Wb3SQDspY9hn2/kDxoWNumzr8WxlKJMkChprUtmfxT8Mh/E0vtYi0HXexah8SCTi8dDa+MUxGI/T4OnD2G05wsj0jDONJ/Fx9AOo2baGMupvFgLmRC25WbLnuv+0K9OKbBfrdlWKJNl/3MTXwsPC+OCGmO0zdenYopGMnXL/7mScINzzx7QMHuE7XVs7xRUwwYJL73DBsc5wSMWO0zyGJN6VRSnPJS8pZsjkBYGlBZEdvER99IJwtt31llxIbtpxPQ/Rb501fKNz8GyQ9+aBG7Y3BQpsOhy29zbfxNLWN2cpPXRgowqCcEZNbCM69ZkT7D0Wn4pyX3GmAqKzelgingt9zkaOkW65qPRbBGUU2SFgGo++nq5TLfl9fiHOn0jXa/J7WaU4M
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 16:27:47.8919 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0605303e-a136-4b5b-ba6c-08dee0fbad2f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7251
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

Signal USERQ_EOP EVENTFD subscriptions from the USERQ interrupt path.

The EOP interrupt already identifies the queue that completed. Use the
queue object directly to notify matching EVENTFD subscribers.

Routing notifications through the queue object keeps delivery tied to
the queue instance that generated the completion event, avoiding
ambiguities from reused queue identifiers or doorbell indices.

EVENTFD remains notification-only and carries no event payload.

v2: (per Christian)
- Move USERQ_EOP EVENTFD signaling into amdgpu_userq_process_fence_irq().
- Reuse the existing doorbell-to-queue lookup instead of duplicating it
  in the interrupt handler.
- Keep fence processing and EVENTFD notification handling together in a
  single helper.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index fbf783946f6d..ab3ef3a9f655 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -215,6 +215,7 @@ void amdgpu_userq_process_fence_irq(struct amdgpu_device *adev, u32 doorbell)
 {
 	struct xarray *xa = &adev->userq_doorbell_xa;
 	struct amdgpu_usermode_queue *queue;
+	struct amdgpu_eventfd_mgr *eventfd_mgr;
 	unsigned long flags;
 	int r;
 
@@ -232,6 +233,11 @@ void amdgpu_userq_process_fence_irq(struct amdgpu_device *adev, u32 doorbell)
 		/* Restart the timer when there are still fences pending */
 		if (r == 1)
 			amdgpu_userq_start_hang_detect_work(queue);
+
+		eventfd_mgr = amdgpu_userq_eventfd_mgr(queue->userq_mgr);
+		amdgpu_eventfd_signal(eventfd_mgr,
+				      DRM_AMDGPU_EVENT_TYPE_USERQ_EOP,
+				      queue);
 	}
 	xa_unlock_irqrestore(xa, flags);
 }
-- 
2.34.1

