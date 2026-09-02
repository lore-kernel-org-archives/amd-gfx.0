Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3443C624D3
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2026 12:50:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B376510E407;
	Wed,  2 Sep 2026 12:50:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U/iCC5By";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011004.outbound.protection.outlook.com [52.101.52.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D067310E407
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 12:50:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RtapwZYiXUfTY88EQjzF7ogiqNgopuyTnmRiesm/1lAFH/jKTgdBqrGq7aV5cZESqSb7jQKRQJR7YdnVtMB891oRq6cNuAYJ9+17h9y2kohQuOQJARESRSCyaexwAtinSV5J7iUbTaidZmCIcaODU1U/zvMx7r1K7yjTOTUMMa/DFvTbIQeaqFkArEdINScdmPbGvaxK1s6pfBMLY/61lqvJH7Nrr2o6YMIbskVrp/UXFCaI4FAn2L0ycXisddlSUu/cxkfZRxPku8EOwk6jVG/7ypCmPioUPXtdaDoMPdWCiFuk0X/fz6VJnrXvMqfvOxNJVZ2R/dh+Vumfjc2JKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pXDXVm2b64uUr9ApFGLJkquGcE9U21X7XL5kWcIiJhA=;
 b=H+ORH3CnYVKikbcdw8lktG01j6htNrgRCgqdT1Jq1QhJGWWxs3QCgLzeT4Zw2uS2+uSLb6KSgbYe0jYQzZw9eALX2FNG80KrPJ10HllIFSGRykOD8P3W9TjUea3vk9uluCo0NZfGKhpjZRetU2aj0pcoVPw13VN89ib+zEWJmp2k1h4ELoKekNb0ykoaX+g8ewmHTrVAFpdhacYzeopo+tMm9/o4edj377FvRx9HEUvMXpLSQNst23mbOm3KGXudkegXZehAcfk4vF0dYBTb0G4teofHb0ALVTeKbScC79H+BfIRrB4emYe73SV3lc2IuwUDa+oK8mbQxT6CXAyP5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pXDXVm2b64uUr9ApFGLJkquGcE9U21X7XL5kWcIiJhA=;
 b=U/iCC5ByUyuANvCzHE0Y5MbbOwkbo2+S/fWZCRbxuHRme6IcPDIOIhzH8giZR4UOlsWr0yznQGTJgdG1XPRjpN/KoxKY6CkFoS+vm7je2FWCen3+9HrcVBbHKanBGa9MTQtK/zOUFhmRP6OBb6J6WV1aWdemSr1BF1vVz79mYMo=
Received: from SJ0PR03CA0134.namprd03.prod.outlook.com (2603:10b6:a03:33c::19)
 by SJ2PR12MB7963.namprd12.prod.outlook.com (2603:10b6:a03:4c1::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 12:50:24 +0000
Received: from SJ1PEPF000026CA.namprd04.prod.outlook.com
 (2603:10b6:a03:33c:cafe::27) by SJ0PR03CA0134.outlook.office365.com
 (2603:10b6:a03:33c::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Wed, 2
 Sep 2026 12:50:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026CA.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 12:50:22 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 07:50:15 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Vitaly.Prosyak@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH 04/18] drm/amdgpu: move userq fence wait out of signalling
 section
Date: Wed, 2 Sep 2026 20:49:47 +0800
Message-ID: <20260902125001.621629-4-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260902125001.621629-1-Prike.Liang@amd.com>
References: <20260902125001.621629-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026CA:EE_|SJ2PR12MB7963:EE_
X-MS-Office365-Filtering-Correlation-Id: a8350218-12db-4d95-40ec-08df08f0c0d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|23010399003|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: HLjIOSCprzmKg64Qm9mkxgAYrHTaciBtf805dwUgSq9FkV+gFWwVN7GV9f+thcCUuUbSnJnedcuc4I9r6ErdX2OTKv0DJOzI9wAu0MeTixU0yPSetnxzUkPZfaaRp0JVycVRNlVDK59RPzrCOc8i1zmVAJfbmCgxB1/yMBhR7okSAEwAUi89iIZs9K2QwGsOotiqaFlaNOLeRvOBRSgrgl6vVtQNF5C4h9D8lsC9XkPxiDCWhtzE9472OuBflp6sp9BkpCSBmdCTmxSrtAs7wXvk5eNKdkaby3wDvZfuDMH0ZFQjW9CnEKcO1cGdQoETdxifoczzEwDh9f+w/BAq2FotBOIm/n9DABqPwlfX8Zfr8SLlmabTFMZOasZPcj3FEDnGph+IHuUIbNgR30EPuTKQyLU5VVdtC30zdVN5Yp9pYXHALSal0BuWr9A556COVamAy3H6CpdHJWmYa9138fgm6Xug/Sor0GeYmNiYVFBApOfZDE4xDdMrZ40lj/cPLPYSeNHUZOoctR2cZ/UkHk3WDURvsGcSOBtj5a4fNxD58+D+E+gxMh6dGjx8oa+yKEZt/lMR+Fz3PENJolycfvP5NGX/MNRLdTRvFNlMU/9wIogVDG0ChZchEg4qbA92sn5O7zKveZWUbOTFAXZpCKLLQYeYU6fT54kesVQb/K2rf6EBmNsPmj0qt8PZoDwbYamR1evRvxW1C5OWr0Y0Gg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(23010399003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MdCeEDnQVDoW4D8uzOkUzHolP13jl5GhWNxdo+l27jiozXogdAbReZpDoPdFsftZHn11BI1MCz/hFM/wRlQwV1qQyGcIAqxcr6CeWeIah4ZYKdDlsVmcnjBmthxHxncImKzEJ+ndggKmb/97rpAKuKiM5zO0Pe/KWHyqVzsz6JT1i65bEI4wGAxt3oSkZf9BRXTDGYsOngLZ4x3rrBISA0n46IFYv5IdvNW5Et71Ca+nFzEEaPrNrJCV3SFLzw24S9KnSyJOzqL9HlQCefv6xqupmMqkGxn30eQe7552nhobJaZNo5g5ePahJTxXNjBBW5SQqc4Z6Qh7Dexyb9AHTlP+V2EUkCh+Y8jo1pVAIyAKwYxjpLLH4x5fKMbF5OPVtiMl6cq1AYUe0uR/x4HZogVkf94Vdt5lmSWtWnC7AbUwsaIIpdTcyQJTqq6+czuK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 12:50:22.9368 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8350218-12db-4d95-40ec-08df08f0c0d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026CA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7963
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

The eviction fence suspend worker waits for every pending userq fence
from inside a dma_fence_begin_signalling() critical section. Waiting on
another DMA fence while responsible for signalling one violates the
cross-driver fence contract and is reported by lockdep as a
dma_fence_map dependency.

Move the wait before dma_fence_begin_signalling(). Keep userq_mutex held
so queue lifetime remains stable while inspecting last_fence.

Fixes: fc61df151617 ("drm/amdgpu: annotate eviction fence signaling path")
Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c | 3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          | 4 +---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h          | 1 +
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
index 4c5e38dea4c2..a0802012de49 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
@@ -68,6 +68,9 @@ amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
 
 	mutex_lock(&uq_mgr->userq_mutex);
 
+	/* Fence waits are not allowed in a fence signalling critical section. */
+	amdgpu_userq_wait_for_signal(uq_mgr);
+
 	/*
 	 * This is intentionally after taking the userq_mutex since we do
 	 * allocate memory while holding this lock, but only after ensuring that
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index ed329041a648..a7b68fd2360e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1272,7 +1272,7 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
 	return ret;
 }
 
-static void
+void
 amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)
 {
 	struct amdgpu_usermode_queue *queue;
@@ -1291,8 +1291,6 @@ amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)
 void
 amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr)
 {
-	/* Wait for any pending userqueue fence work to finish */
-	amdgpu_userq_wait_for_signal(uq_mgr);
 	amdgpu_userq_evict_all(uq_mgr);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 6412a7f7b6ef..488dc21d7c81 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -162,6 +162,7 @@ void amdgpu_userq_mgr_cancel_reset_work(struct amdgpu_device *adev);
 void amdgpu_userq_mgr_cancel_resume(struct amdgpu_userq_mgr *userq_mgr);
 void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr);
 
+void amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr);
 void amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr);
 
 void amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr *userq_mgr,
-- 
2.34.1

