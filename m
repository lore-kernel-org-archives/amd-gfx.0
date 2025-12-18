Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF21D711CC
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Dec 2025 22:42:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3CBC10EBB8;
	Thu, 18 Dec 2025 22:42:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2MnYbWyh";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010056.outbound.protection.outlook.com
 [40.93.198.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6247110EBB8
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Dec 2025 22:41:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VAGifx4pUiovEmPj+118xurtAOH4OnPulhaCOyLK/nVNU1CJrOdeb0Ob5pPaExA5yXwAnEwjRBBml+lBNHynpwYJ4klztTqjxenQp+PyF6CE34hhOiV6lpUJmvdwgIR2GwBTVe5Ph9m3DURW3Ymwp5ZMjjyeDDRgFT+d+vr+2PlyJcm367bvg1uamDlwSWPCPE7Qo9kTr9N8cpSnAUuA09BV30sH8nJsFQEz7eNChAqbGH2rHsuO6iQVtXXpfi6scZDvdCHt9a2eCSosy5dJX9N7KKrwTvF+wEG1sHaM60PHbGk3BMwmmNX1Pb90N9/9z1FwiveTNTHcUqFywMAUdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ilR479OiPdt7oX625iYesUjNwJ/AY9DznM+QHL5tgIs=;
 b=tqIeod4eS3ERgKA8eMATM0wR1PI5kSmaxyojP9CjIk7Qdk4rPz5fH0uCYHP+ZCd8QFb7lVJHBQKo1USxiiTP6lvi3oM2Tsrz+7drL1ETpGtBHQOEVmoFHndQFNXDoPMaodarqKT2lK+XwrTzqX+tFE7DCUB8hxIjMCR9BxmddU1IjRBwr9KPgj5N/GcsVWagRAqiENlgXCmR90EBevkurOHlS6daDSfks0lWVNeJi6GuKnyHb5zv0ZodHTjoioixdZDiZI272vBqKQp2ikl52merb2l5CwcgTxYqPNFVd2moCBuoL8Hfzf8XD4tM96sSmq+z5Z8wfRtyk4ceJ/FDRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ilR479OiPdt7oX625iYesUjNwJ/AY9DznM+QHL5tgIs=;
 b=2MnYbWyh6YmGm596duPhJYZPCX5PQqk2XuGKS23J2aauKYFfAJ3geYkHxHZ6W0fKEutTcJbbCszZL0YR94JoT3dUjQOZZ4aHb0bL2RFK9sxYrCu0jbeW+tvTBdhnO4Py4uLHD9G+frRWQ9TVnHCek9DNqIHRB/snvysV3G/Vy5k=
Received: from MW4PR04CA0107.namprd04.prod.outlook.com (2603:10b6:303:83::22)
 by CH1PPF989868826.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::61d) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.7; Thu, 18 Dec
 2025 22:41:55 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:303:83:cafe::40) by MW4PR04CA0107.outlook.office365.com
 (2603:10b6:303:83::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.7 via Frontend Transport; Thu,
 18 Dec 2025 22:41:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Thu, 18 Dec 2025 22:41:54 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Dec
 2025 16:41:53 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Timur=20Krist=C3=B3f?=
 <timur.kristof@gmail.com>
Subject: [PATCH 1/7] drm/amdgpu: don't reemit ring contents more than once
Date: Thu, 18 Dec 2025 17:41:35 -0500
Message-ID: <20251218224141.5841-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|CH1PPF989868826:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bc1cf47-bc7d-4150-6f04-08de3e86a4cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dFU0aUFwOEpBVGIxMWVNV1NLVi9yNGtpTWNNOE40RDgyMmhJSTVsRi9UQy9Z?=
 =?utf-8?B?bDNoQlpHMUF0T3BleUUrVEZyekhpRDNudG1DUnE4OEpMZmFKU0I1ZThtalFG?=
 =?utf-8?B?UTdpaFE2RkQvWHBVOVZVc3NNUDNrMVZFNE56aktka09mbHV2SDlEcG56ZFVs?=
 =?utf-8?B?dWFENWEzaWtRNG0xb0tCMk9QemJPZzF0SzRnTzZWSFdxL25MaTBGT3lZS0Vx?=
 =?utf-8?B?bFJZaktYNUoxK2dxdU5BNksvbHU5TGVRUG5pYXZGZlZHNmNja2g0UEJ6alBs?=
 =?utf-8?B?anRNSkNpWDdJZUhac253V1YwdDB5WXFGL2I3WTdaMU5kZ3BDTU5XRW1nRlZD?=
 =?utf-8?B?MENrUGZld1g3cnJyZS8vSElLenRhbjhRdXFSNnhOS2ZpdDU3ZWx5cDQ1ZERT?=
 =?utf-8?B?cjBmUkNMZEMxVWlTVFB1eURuUkpLSmx5QXA3aDl0RjRYZHNhSEpUUFJBNUp5?=
 =?utf-8?B?eXpyMnhaS3FFL2RvR2FGOWVtb2tmRlUxM3pqOGRFMUNTMzVCOVJsQ2ZvRzJ4?=
 =?utf-8?B?dFdPSHEwMnlIYWFYZFB6emFKaWtkUlNuYSt3NUZVNFUyZktrMWxXNElhdm9a?=
 =?utf-8?B?OFBod3U1VjgxMVNFMFZNVm1wQ3BVS1hKTjBYNDZOWS9NT3RrQ3lNOGVJQWdE?=
 =?utf-8?B?VU43VUFrSzdqVy9iQXpLRW9OSXEzTEJZOGw2Y24zcWlScXlUTHJZVDkrcktx?=
 =?utf-8?B?SEFvbnFHTkxUWG5oamdHL3NCbU1KZ3pLSVZVZ2pyTm9qemVEZVZZTCtic3VH?=
 =?utf-8?B?WC9PTzJ2Q0ZiUjRWdDRVd3VCK2RxV3pjZ1Q5U0I3RWZEdlpHME9pbHI0cERT?=
 =?utf-8?B?VEhkQmFoVW5rdDhUYUVGRFMzS3QrRHJmdmlPUVcvNmo4enVKQlFVVnUwWmZH?=
 =?utf-8?B?c1FYWGZyNngxNlRENjdtOXJSZXlzRFRrb2xUbVBoWC9sQUNGOFJoa1c5UEIw?=
 =?utf-8?B?R2JjNitJSmhnQ0N4RmFsOWZuOTZ2SkJVTlJQRWVwZjJTUkJZOVQ5R1Z3THNs?=
 =?utf-8?B?M3V5bENXanphMzZIbWI5Q2V0K0NRWFI5cGxUSldXOXJLWDlaYjIrdjg4QUZF?=
 =?utf-8?B?OUVyRHgrWVNDUUJJMWhKbHRYSTN1RVB1VjVMQTZjVUs4K2hXVVNnRWNPeDFO?=
 =?utf-8?B?ZTM0VjlhOXV3b3A3YWkzVWxaTVBhVzAzdFhwK2hJcmQ0cVMzWXFIWjZsNHZL?=
 =?utf-8?B?RUdlcHBjMytjdGlXZVdZOFYvTi9CK0tqSk8zQWhVbXI1Mm1YL3ZwOG1VMzFB?=
 =?utf-8?B?OXBxQWZzNWdheEpFR0tDQ2ZzTy9QVlA0Q2c3NDh5QktGSXoyT3VadFNuMjVV?=
 =?utf-8?B?SnprQXZhcEpTRVBPUnorZnljVjNMUFBhVEJRZXFobWh1MEJSTGx1Z3hpQjlY?=
 =?utf-8?B?Z1VmQVV2dTczQ2pxTlYxS3FaSXMyWnZhK3Q5N1M0SUNSVGY2bmVYMFlNWnk0?=
 =?utf-8?B?eXFOWjFwTmZjeElhWi9SbWlhcVllbFFNL3ZBcGI0MzQvN2N4RFR4aWVjSkc4?=
 =?utf-8?B?ckpJYTd6RjJEZGlxeC9QZ25MK1N0dzgwNGFvaWhjRGpVUlI4c2gyczBUd01v?=
 =?utf-8?B?LzVGRFp0dHBMeGlrK0NCTWhlcDdINFRZRTVjYUNZZ1ZBM0d6OHlsczVCYVJu?=
 =?utf-8?B?RHVLY0lUemxsb05vcmZkbVBtSE42b0F1eHJ4YVYxYVhpT05mcGFGajdyRTRz?=
 =?utf-8?B?aUZMZ0t4SWlXMy9yOGFidGhRaWZ2VGRscWVZekNpc3RLVGxyaUNpR1p6ZVBi?=
 =?utf-8?B?Sm9UT0piNmxyWFZyQXp5Yjc3U3FweXZiVFBPMmtNUGlUQzkzT1dSZ202cHdM?=
 =?utf-8?B?eXlYNEIrZkd2V3pXK0tuNTArQTUyZ0FzSUsrSVhBVW5GS0tLWGVCWnVCT0Y3?=
 =?utf-8?B?YjJZblJ2dE40c2dMWEgxOE5hbUlpQ1F0MW1TSnpwY1I5bTJMSXFDV1VReVdJ?=
 =?utf-8?B?M1BEMFJnL0FodzhvODhLTlBkZlpFTC9INnE3MFMyb2o2bXJxL3pib2hpM0ZL?=
 =?utf-8?B?a1NDeFpNK2tvZUw1WmZ4RW1pOGNobXVPc0RVR2QyVUZaQXNCbm5BdkM1dnhZ?=
 =?utf-8?B?ZjJYWVd1bFBXTzFjZkYwT045N2laODFRc24rM2dOcEZuSU9CVjdoaFh4ekRt?=
 =?utf-8?Q?wL7I=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 22:41:54.3236 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bc1cf47-bc7d-4150-6f04-08de3e86a4cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF989868826
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

If we cancel a bad job and reemit the ring contents, and
we get another timeout, cancel everything rather than reemitting.
The wptr markers are only relevant for the original emit.  If
we reemit, the wptr markers are no longer correct.

Reviewed-by: Timur Kristóf <timur.kristof@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 22 +++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  |  2 ++
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 1fe31d2f27060..334ddd6e48c06 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -710,6 +710,7 @@ void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *af)
 	struct amdgpu_ring *ring = af->ring;
 	unsigned long flags;
 	u32 seq, last_seq;
+	bool reemitted = false;
 
 	last_seq = amdgpu_fence_read(ring) & ring->fence_drv.num_fences_mask;
 	seq = ring->fence_drv.sync_seq & ring->fence_drv.num_fences_mask;
@@ -727,7 +728,9 @@ void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *af)
 		if (unprocessed && !dma_fence_is_signaled_locked(unprocessed)) {
 			fence = container_of(unprocessed, struct amdgpu_fence, base);
 
-			if (fence == af)
+			if (fence->reemitted > 1)
+				reemitted = true;
+			else if (fence == af)
 				dma_fence_set_error(&fence->base, -ETIME);
 			else if (fence->context == af->context)
 				dma_fence_set_error(&fence->base, -ECANCELED);
@@ -735,9 +738,16 @@ void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *af)
 		rcu_read_unlock();
 	} while (last_seq != seq);
 	spin_unlock_irqrestore(&ring->fence_drv.lock, flags);
-	/* signal the guilty fence */
-	amdgpu_fence_write(ring, (u32)af->base.seqno);
-	amdgpu_fence_process(ring);
+
+	if (reemitted) {
+		/* if we've already reemitted once then just cancel everything */
+		amdgpu_fence_driver_force_completion(af->ring);
+		af->ring->ring_backup_entries_to_copy = 0;
+	} else {
+		/* signal the guilty fence */
+		amdgpu_fence_write(ring, (u32)af->base.seqno);
+		amdgpu_fence_process(ring);
+	}
 }
 
 void amdgpu_fence_save_wptr(struct amdgpu_fence *af)
@@ -785,10 +795,12 @@ void amdgpu_ring_backup_unprocessed_commands(struct amdgpu_ring *ring,
 			/* save everything if the ring is not guilty, otherwise
 			 * just save the content from other contexts.
 			 */
-			if (!guilty_fence || (fence->context != guilty_fence->context))
+			if (!fence->reemitted &&
+			    (!guilty_fence || (fence->context != guilty_fence->context)))
 				amdgpu_ring_backup_unprocessed_command(ring, wptr,
 								       fence->wptr);
 			wptr = fence->wptr;
+			fence->reemitted++;
 		}
 		rcu_read_unlock();
 	} while (last_seq != seq);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index a1fb0fadb6eab..d881829528976 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -150,6 +150,8 @@ struct amdgpu_fence {
 	u64				wptr;
 	/* fence context for resets */
 	u64				context;
+	/* has this fence been reemitted */
+	unsigned int			reemitted;
 };
 
 extern const struct drm_sched_backend_ops amdgpu_sched_ops;
-- 
2.52.0

