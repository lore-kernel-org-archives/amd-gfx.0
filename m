Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EA65E6BF30
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jan 2026 17:31:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EA7410EA36;
	Fri, 30 Jan 2026 17:31:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cC/c+wmS";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013011.outbound.protection.outlook.com
 [40.107.201.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3D0310EA35
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 17:31:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XyauKfj+nxXgrS3h7cm6hO/UBSGpl8zrwWO1EYpzR/7l1sjQPr+dHQUpJUUurThN1icYDt4xEN6pm0TxoPTLxdgRjCK0ZQrri6CaGrc6sGWdIKsFKNVoP+yKQssACHH0bysUkbmAmzeFHEMp2MbF6t8gH+ZGcnBLZwd64R++/8QmPerKmxDMxImNsvl8rUMU+gXI5ssCkjT7ZzLJTBzkd2iYPElHAUUrIrBwq2KdSp063hRV8Fj1M9G+nToSYt+D2s6Fcsr9DcaZrfFRPAtAh4YMfcrzfmeHj6W/mXUWmcvAftl32zpy4h/AQ4w77b7D5XpgC6ee3fTneZMYej8qpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J0vvx4zUz0eItI3xwIgrJlHz6gFXjWVXygrsuMQmvHM=;
 b=Oax9pRDoFF84b4wqsBKHFsbWxZYZAtRw01WXz1oKWNHjsiVxIQIVximRlDBnrrbFI2wM7VozX6sGUPmzy6QKGx/B0EsW/PtH+6o0moY4DcltqASjsiKRM518TKMeVZCWh/y6t4CAm1AWfbua/Wr0SUtM/hAm0LfJvxhFdpQ2E0HksHHcpffsgyoGQiTsptrRRMuXwVAaVuwe8rmZSXNbnv+7gZZAoCnD0HM1Jp6v/LxC8L6nqV4GnKhCte+w0l2uF3snLxsLP+RSHu4DCCBsuq3IUgzTcLISJ3ExfZoOGztXQvr9VJ2mBberbF8f3FMa0Km+4cOzaXa7wbp8INaEeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0vvx4zUz0eItI3xwIgrJlHz6gFXjWVXygrsuMQmvHM=;
 b=cC/c+wmSFGAFeG7NCOJPZMJ9VN6GEOjVx8LlNqmpU4p44LdGKAFlHvpBEnqluXGwiR+D4QSjn8W0t/YrElCFg/zdQSBJ+uAmPWMfRVwDTFlV5Fgaxm082XjEkaIt3JPG9nXGIPMtZ3ewALGmDTtDlCF0W4M6p6mkjz/5XIRxhX0=
Received: from SJ0PR05CA0127.namprd05.prod.outlook.com (2603:10b6:a03:33d::12)
 by BN5PR12MB9488.namprd12.prod.outlook.com (2603:10b6:408:2a9::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Fri, 30 Jan
 2026 17:31:14 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:a03:33d:cafe::13) by SJ0PR05CA0127.outlook.office365.com
 (2603:10b6:a03:33d::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.5 via Frontend Transport; Fri,
 30 Jan 2026 17:31:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 30 Jan 2026 17:31:13 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 30 Jan
 2026 11:31:02 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 30 Jan
 2026 09:31:01 -0800
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 30 Jan 2026 09:31:01 -0800
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 12/12] drm/amdgpu: rework ring reset backup and reemit v8
Date: Fri, 30 Jan 2026 12:30:42 -0500
Message-ID: <20260130173042.15008-13-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130173042.15008-1-alexander.deucher@amd.com>
References: <20260130173042.15008-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|BN5PR12MB9488:EE_
X-MS-Office365-Filtering-Correlation-Id: b7e75094-44a9-4092-9c72-08de60255de1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bOMB8oT1+a2l+SdJyuUjYPb25LyBpBuZ42oUrGcin9mnzcmlisuCAvwHaJ4l?=
 =?us-ascii?Q?kXHZSvVYLHP/NGbmwN2NDqwh/F2lTw3FeGJ8BGknX9msfCjg9r4a0dUbtENG?=
 =?us-ascii?Q?cs6vk97lGnefLjtQ6kkJdmMGPrLslEcSkypTSU4GZ2ECl6U+W0IkrnXMiC7O?=
 =?us-ascii?Q?Yh8WDbqsSE/Z1NKyXPBXO3+SibxUthm14kcYAfq3tNUdH499bjA6u90qA94n?=
 =?us-ascii?Q?KOkTb2GJ/zyIlctshPgg7juSyKpuYfb568M3tGiwvi52nUhU+USH3k60ulF6?=
 =?us-ascii?Q?LgZw//UMjUqQR4oP/RBlYyl7w8AOn8fMPNUE1wMV63UPOpA6VjfWBg5HKZEr?=
 =?us-ascii?Q?ZVtx8xNIK6mMZ/PgsnlemSXDEBVCKmyS+9QugjCTHgRvDaiy4ry6sRmIWSf4?=
 =?us-ascii?Q?BHFAhQ5ofRSXPDLj1OjHKn3Wt09NkjHuWjHAKGzcdydCcxNmnZR9GXcc+Gbf?=
 =?us-ascii?Q?IQPWO9xYz/L/u0zsR1NJcLfeE31yoe8e+3B+D8HzJZN9CBEi2/6iBxlCN4Tz?=
 =?us-ascii?Q?C5czsfDJEu482x4pCFa4jNZzTbDvXGio1Q6+urtUDDSrJs07A/JVqRCE7OYH?=
 =?us-ascii?Q?FJSPHVsaLzDfW5VGYrR2/1rYVLK/7JDX17t4xVnKQ18+8zNLxTXnvXH/A+OA?=
 =?us-ascii?Q?3+7lY//ycHBEVrGD3ikpAVTgHJm+0QkDpqoaIS2fLw2L1bfxoTyAw1CRArHO?=
 =?us-ascii?Q?sLOQMQc160uSySSKqAt36phId5AVXLPiCWFC1/4WkNiVQjzPSGQTpprw/FBr?=
 =?us-ascii?Q?FdIA3+khelaPeaQ2rAB7ZsfclxGcXJ2ymnoPyxe9qZf0JbyFAm5hk9AN6AiZ?=
 =?us-ascii?Q?Z4RRurgzm+tDqgyDsJOyrYSQosAONiGyNpBtUjckuzGNJInOTvN8LJBvuZ1Y?=
 =?us-ascii?Q?ck4+xhmzZiYqNeMGYx85jDBnA2Yd/tXEsSU3lpx1pKJrw51350LjT2LmGCo1?=
 =?us-ascii?Q?fCYrFb0ArxkmAXbMbnI0s2uz9Wz3cnAOOA4exM9jHmhe8xGZlnngl1ocwz9W?=
 =?us-ascii?Q?vkKHFT8K+xEs0vHjX+dHmA4/ZwtlriDXsGgBsNzCU6iFdN2dH9gM0GErEbxz?=
 =?us-ascii?Q?fWczUHoti2UU/KGYIncS9ugve03zUqf1wLPiNb8LK7lKNVe39eiDMWHY1YHD?=
 =?us-ascii?Q?u11T7Wrr/8IgXjSBYrv54N5O/tEaOd6Rxq6PEJCuG+B/RONLn6MHXRQs40Oi?=
 =?us-ascii?Q?Hu7L9GkGcaaLHuv4PZTpmTpNIlcwa+1oHhvm2r0sPTNsi5rU7L2nHyeIYqll?=
 =?us-ascii?Q?ECuiS0ltWMrA9rs/aRyf0lf0Hv1OpkOYdqk/4VKhAcKEPqa0UGgE5VuabtDT?=
 =?us-ascii?Q?EZskhB/Eaj65fIb6ef69Guc1YW+yDzYzDqB+HxYxsN/YE+rka+thdbv/12r/?=
 =?us-ascii?Q?bfaUG9U9gnqF+Pu53TvT9uLk6OPRp+yT+t2oLwaQkxARPwiZ182avG5UtI04?=
 =?us-ascii?Q?YuzJv8PkZMQslCVntak18nqFGL8gMCR7wsFIHyvZ7QJQXXNLd5SJxLyRjuYs?=
 =?us-ascii?Q?4tiJ4yYWOozb737+G92LEVnMqWnVO2bPbfbg+PIkIVmpPlmyh5F8rzU9cZMo?=
 =?us-ascii?Q?eSrOyWWUYTwtG3xoKlHXYuPEXmP1OXoniKI1NAwVq/tf4giTtZ4hAK51NGZ3?=
 =?us-ascii?Q?DsGH1LZYlXV9ILOqNAMYre3HFjyXrEbeuAwg7wxT6o8nZRZj4yQCdNgBZqIm?=
 =?us-ascii?Q?GgdIug=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KsVlWSEJmgaQPPI2L9HDXMAkeKnr1JqYeiOWLy034M/r6RdNao8NzaQXigjAcJ9Jny83sXLboE9d4aC9fcm+eW6XcAYFr+vpMBIej7WkD3J4HMrZ0lvcYC5VPYHRhnqB8OOm0ySnjfRcydFRyVxoOirjws96f3UH6dotVdsocuT/F+6f+WMLdksbGYmCP6EG+gOpi/3feLjx8oW1GaYyZJM36Gc04cnNSIbG4CR4m3b3yQ/IMrX8O3ImV7g8xeHsBeMO3kVUyJwXSu7d088VDzI5WzUkVoJU74fsSTfVQ9sbDtdfTP5xdcRgiZcsbX2T6gdN69kVpFVcEfm0idBfo1kosQTDr/FHSEDw/U+KurswEZZOPnYCiPXMQPsUMjogGhAfuZ3ZZTuAUfM8YwpyRf51eU/P59G7/+GPv0ipzaWZW7E8+/Ry3twr27OUq/EX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 17:31:13.7521 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7e75094-44a9-4092-9c72-08de60255de1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9488
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

Store the start wptr and ib size in the IB fence. On queue
reset, save the ring contents of all IBs.

For reemit, reemit the entire IB state for non-guilty contexts.
For guilty contexts, replace the IB submission with nops, but reemit
the rest.  Split the reemit per fence and when we reemit, update the
wptr with the new values from reemit.  This allows us to reemit jobs
repeatedly as the wptrs get properly updated each time.

v2: further simplify the logic
v3: reemit vm state, not just vm fence
v4: just nop the IB and possibly the VM portion of the submission
v5: simplify the vm fence check
v6: split the vm and ib fences
v7: fix commit message
v8: use wptr rather than count_dw to calculate offsets

Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 98 +++++++++--------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c    | 25 ++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c  | 46 +++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  | 20 ++---
 4 files changed, 72 insertions(+), 117 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 3c38bf58fd3f2..941aa442fa133 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -89,16 +89,6 @@ static u32 amdgpu_fence_read(struct amdgpu_ring *ring)
 	return seq;
 }
 
-static void amdgpu_fence_save_fence_wptr_start(struct amdgpu_fence *af)
-{
-	af->fence_wptr_start = af->ring->wptr;
-}
-
-static void amdgpu_fence_save_fence_wptr_end(struct amdgpu_fence *af)
-{
-	af->fence_wptr_end = af->ring->wptr;
-}
-
 /**
  * amdgpu_fence_emit - emit a fence on the requested ring
  *
@@ -126,11 +116,9 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct amdgpu_fence *af,
 		       &ring->fence_drv.lock,
 		       adev->fence_context + ring->idx, seq);
 
-	amdgpu_fence_save_fence_wptr_start(af);
 	amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
 			       seq, flags | AMDGPU_FENCE_FLAG_INT);
-	amdgpu_fence_save_fence_wptr_end(af);
-	amdgpu_fence_save_wptr(af);
+
 	pm_runtime_get_noresume(adev_to_drm(adev)->dev);
 	ptr = &ring->fence_drv.fences[seq & ring->fence_drv.num_fences_mask];
 	if (unlikely(rcu_dereference_protected(*ptr, 1))) {
@@ -241,7 +229,6 @@ bool amdgpu_fence_process(struct amdgpu_ring *ring)
 
 	do {
 		struct dma_fence *fence, **ptr;
-		struct amdgpu_fence *am_fence;
 
 		++last_seq;
 		last_seq &= drv->num_fences_mask;
@@ -254,12 +241,6 @@ bool amdgpu_fence_process(struct amdgpu_ring *ring)
 		if (!fence)
 			continue;
 
-		/* Save the wptr in the fence driver so we know what the last processed
-		 * wptr was.  This is required for re-emitting the ring state for
-		 * queues that are reset but are not guilty and thus have no guilty fence.
-		 */
-		am_fence = container_of(fence, struct amdgpu_fence, base);
-		drv->signalled_wptr = am_fence->wptr;
 		dma_fence_signal(fence);
 		dma_fence_put(fence);
 		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
@@ -726,25 +707,28 @@ void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring,
  */
 
 /**
- * amdgpu_fence_driver_update_timedout_fence_state - Update fence state and set errors
+ * amdgpu_ring_set_fence_errors_and_reemit - Set dma_fence errors and reemit
  *
- * @af: fence of the ring to update
+ * @guilty_fence: fence of the ring to update
  *
  */
-void amdgpu_fence_driver_update_timedout_fence_state(struct amdgpu_fence *af)
+void amdgpu_ring_set_fence_errors_and_reemit(struct amdgpu_ring *ring,
+					     struct amdgpu_fence *guilty_fence)
 {
 	struct dma_fence *unprocessed;
 	struct dma_fence __rcu **ptr;
 	struct amdgpu_fence *fence;
-	struct amdgpu_ring *ring = af->ring;
 	unsigned long flags;
 	u32 seq, last_seq;
-	bool reemitted = false;
+	unsigned int i;
+	bool is_guilty_fence;
+	bool is_guilty_context;
 
 	last_seq = amdgpu_fence_read(ring) & ring->fence_drv.num_fences_mask;
 	seq = ring->fence_drv.sync_seq & ring->fence_drv.num_fences_mask;
 
-	/* mark all fences from the guilty context with an error */
+	ring->reemit = true;
+	amdgpu_ring_alloc(ring, ring->ring_backup_entries_to_copy);
 	spin_lock_irqsave(&ring->fence_drv.lock, flags);
 	do {
 		last_seq++;
@@ -756,39 +740,45 @@ void amdgpu_fence_driver_update_timedout_fence_state(struct amdgpu_fence *af)
 
 		if (unprocessed && !dma_fence_is_signaled_locked(unprocessed)) {
 			fence = container_of(unprocessed, struct amdgpu_fence, base);
+			is_guilty_fence = fence == guilty_fence;
+			is_guilty_context = fence->context == guilty_fence->context;
 
-			if (fence->reemitted > 1)
-				reemitted = true;
-			else if (fence == af)
+			/* mark all fences from the guilty context with an error */
+			if (is_guilty_fence)
 				dma_fence_set_error(&fence->base, -ETIME);
-			else if (fence->context == af->context)
+			else if (is_guilty_context)
 				dma_fence_set_error(&fence->base, -ECANCELED);
+
+			/* reemit the packet stream and update wptrs */
+			fence->ib_wptr = ring->wptr;
+			for (i = 0; i < fence->ib_dw_size; i++) {
+				/* Skip the IB(s) for the guilty context. */
+				if (is_guilty_context &&
+				    i >= fence->skip_ib_dw_start_offset &&
+				    i < fence->skip_ib_dw_end_offset)
+					amdgpu_ring_write(ring, ring->funcs->nop);
+				else
+					amdgpu_ring_write(ring,
+							  ring->ring_backup[fence->backup_idx + i]);
+			}
 		}
 		rcu_read_unlock();
 	} while (last_seq != seq);
 	spin_unlock_irqrestore(&ring->fence_drv.lock, flags);
-
-	if (reemitted) {
-		/* if we've already reemitted once then just cancel everything */
-		amdgpu_fence_driver_force_completion(af->ring, &af->base);
-		af->ring->ring_backup_entries_to_copy = 0;
-	}
-}
-
-void amdgpu_fence_save_wptr(struct amdgpu_fence *af)
-{
-	af->wptr = af->ring->wptr;
+	amdgpu_ring_commit(ring);
+	ring->reemit = false;
 }
 
 static void amdgpu_ring_backup_unprocessed_command(struct amdgpu_ring *ring,
-						   u64 start_wptr, u64 end_wptr)
+						   struct amdgpu_fence *af)
 {
-	unsigned int first_idx = start_wptr & ring->buf_mask;
-	unsigned int last_idx = end_wptr & ring->buf_mask;
+	unsigned int first_idx = af->ib_wptr & ring->buf_mask;
+	unsigned int dw_size = af->ib_dw_size;
 	unsigned int i;
 
+	af->backup_idx = ring->ring_backup_entries_to_copy;
 	/* Backup the contents of the ring buffer. */
-	for (i = first_idx; i != last_idx; ++i, i &= ring->buf_mask)
+	for (i = first_idx; dw_size > 0; ++i, i &= ring->buf_mask, --dw_size)
 		ring->ring_backup[ring->ring_backup_entries_to_copy++] = ring->ring[i];
 }
 
@@ -798,12 +788,10 @@ void amdgpu_ring_backup_unprocessed_commands(struct amdgpu_ring *ring,
 	struct dma_fence *unprocessed;
 	struct dma_fence __rcu **ptr;
 	struct amdgpu_fence *fence;
-	u64 wptr;
 	u32 seq, last_seq;
 
 	last_seq = amdgpu_fence_read(ring) & ring->fence_drv.num_fences_mask;
 	seq = ring->fence_drv.sync_seq & ring->fence_drv.num_fences_mask;
-	wptr = ring->fence_drv.signalled_wptr;
 	ring->ring_backup_entries_to_copy = 0;
 
 	do {
@@ -817,21 +805,7 @@ void amdgpu_ring_backup_unprocessed_commands(struct amdgpu_ring *ring,
 		if (unprocessed && !dma_fence_is_signaled(unprocessed)) {
 			fence = container_of(unprocessed, struct amdgpu_fence, base);
 
-			/* save everything if the ring is not guilty, otherwise
-			 * just save the content from other contexts.
-			 */
-			if (!fence->reemitted &&
-			    (!guilty_fence || (fence->context != guilty_fence->context))) {
-				amdgpu_ring_backup_unprocessed_command(ring, wptr,
-								       fence->wptr);
-			} else if (!fence->reemitted) {
-				/* always save the fence */
-				amdgpu_ring_backup_unprocessed_command(ring,
-								       fence->fence_wptr_start,
-								       fence->fence_wptr_end);
-			}
-			wptr = fence->wptr;
-			fence->reemitted++;
+			amdgpu_ring_backup_unprocessed_command(ring, fence);
 		}
 		rcu_read_unlock();
 	} while (last_seq != seq);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 0932a093dee3d..f4d090bc4784c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -126,6 +126,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	struct amdgpu_ib *ib;
 	struct dma_fence *tmp = NULL;
 	struct amdgpu_fence *af;
+	struct amdgpu_fence *vm_af;
 	bool need_ctx_switch;
 	uint64_t fence_ctx;
 	uint32_t status = 0, alloc_size;
@@ -146,13 +147,14 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	fence_ctx = job->base.s_fence ?
 		job->base.s_fence->finished.context : 0;
 	af = job->hw_fence;
+	vm_af = job->hw_vm_fence;
 	/* Save the context of the job for reset handling.
 	 * The driver needs this so it can skip the ring
 	 * contents for guilty contexts.
 	 */
 	af->context = fence_ctx;
 	/* the vm fence is also part of the job's context */
-	job->hw_vm_fence->context = fence_ctx;
+	vm_af->context = fence_ctx;
 
 	if (!ring->sched.ready) {
 		dev_err(adev->dev, "couldn't schedule ib on ring <%s>\n", ring->name);
@@ -192,12 +194,18 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		dma_fence_put(tmp);
 	}
 
+	/* VM sequence */
+	vm_af->ib_wptr = ring->wptr;
 	r = amdgpu_vm_flush(ring, job, need_pipe_sync);
 	if (r) {
 		amdgpu_ring_undo(ring);
 		return r;
 	}
+	vm_af->ib_dw_size =
+		amdgpu_ring_get_dw_distance(ring, vm_af->ib_wptr, ring->wptr);
 
+	/* IB sequence */
+	af->ib_wptr = ring->wptr;
 	amdgpu_ring_ib_begin(ring);
 
 	if (ring->funcs->insert_start)
@@ -218,6 +226,9 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		cond_exec = amdgpu_ring_init_cond_exec(ring,
 						       ring->cond_exe_gpu_addr);
 
+	/* Skip the IB for guilty contexts */
+	af->skip_ib_dw_start_offset =
+		amdgpu_ring_get_dw_distance(ring, af->ib_wptr, ring->wptr);
 	amdgpu_device_flush_hdp(adev, ring);
 
 	if (need_ctx_switch)
@@ -256,6 +267,9 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		amdgpu_ring_emit_frame_cntl(ring, false, secure);
 
 	amdgpu_device_invalidate_hdp(adev, ring);
+	/* Skip the IB for guilty contexts */
+	af->skip_ib_dw_end_offset =
+		amdgpu_ring_get_dw_distance(ring, af->ib_wptr, ring->wptr);
 
 	if (ib->flags & AMDGPU_IB_FLAG_TC_WB_NOT_INVALIDATE)
 		fence_flags |= AMDGPU_FENCE_FLAG_TC_WB_ONLY;
@@ -298,13 +312,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		ring->funcs->emit_wave_limit(ring, false);
 
 	amdgpu_ring_ib_end(ring);
-	/* Save the wptr associated with this fence.
-	 * This must be last for resets to work properly
-	 * as we need to save the wptr associated with this
-	 * fence so we know what rings contents to backup
-	 * after we reset the queue.
-	 */
-	amdgpu_fence_save_wptr(af);
+
+	af->ib_dw_size = amdgpu_ring_get_dw_distance(ring, af->ib_wptr, ring->wptr);
 
 	amdgpu_ring_commit(ring);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 129ad51386535..83750ab4e81b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -90,10 +90,13 @@ int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsigned int ndw)
 	ndw = (ndw + ring->funcs->align_mask) & ~ring->funcs->align_mask;
 
 	/* Make sure we aren't trying to allocate more space
-	 * than the maximum for one submission
+	 * than the maximum for one submission.  Skip for reemit
+	 * since we may be reemitting several submissions.
 	 */
-	if (WARN_ON_ONCE(ndw > ring->max_dw))
-		return -ENOMEM;
+	if (!ring->reemit) {
+		if (WARN_ON_ONCE(ndw > ring->max_dw))
+			return -ENOMEM;
+	}
 
 	ring->count_dw = ndw;
 	ring->wptr_old = ring->wptr;
@@ -104,29 +107,6 @@ int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsigned int ndw)
 	return 0;
 }
 
-/**
- * amdgpu_ring_alloc_reemit - allocate space on the ring buffer for reemit
- *
- * @ring: amdgpu_ring structure holding ring information
- * @ndw: number of dwords to allocate in the ring buffer
- *
- * Allocate @ndw dwords in the ring buffer (all asics).
- * doesn't check the max_dw limit as we may be reemitting
- * several submissions.
- */
-static void amdgpu_ring_alloc_reemit(struct amdgpu_ring *ring, unsigned int ndw)
-{
-	/* Align requested size with padding so unlock_commit can
-	 * pad safely */
-	ndw = (ndw + ring->funcs->align_mask) & ~ring->funcs->align_mask;
-
-	ring->count_dw = ndw;
-	ring->wptr_old = ring->wptr;
-
-	if (ring->funcs->begin_use)
-		ring->funcs->begin_use(ring);
-}
-
 /**
  * amdgpu_ring_insert_nop - insert NOP packets
  *
@@ -875,7 +855,6 @@ void amdgpu_ring_reset_helper_begin(struct amdgpu_ring *ring,
 int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
 				 struct amdgpu_fence *guilty_fence)
 {
-	unsigned int i;
 	int r;
 
 	/* verify that the ring is functional */
@@ -883,16 +862,9 @@ int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 
-	/* set an error on all fences from the context */
-	if (guilty_fence)
-		amdgpu_fence_driver_update_timedout_fence_state(guilty_fence);
-	/* Re-emit the non-guilty commands */
-	if (ring->ring_backup_entries_to_copy) {
-		amdgpu_ring_alloc_reemit(ring, ring->ring_backup_entries_to_copy);
-		for (i = 0; i < ring->ring_backup_entries_to_copy; i++)
-			amdgpu_ring_write(ring, ring->ring_backup[i]);
-		amdgpu_ring_commit(ring);
-	}
+	/* set an error on all fences from the context and reemit */
+	amdgpu_ring_set_fence_errors_and_reemit(ring, guilty_fence);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index e196ffbdd1f3a..6da7eb49d30a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -121,7 +121,6 @@ struct amdgpu_fence_driver {
 	/* sync_seq is protected by ring emission lock */
 	uint32_t			sync_seq;
 	atomic_t			last_seq;
-	u64				signalled_wptr;
 	bool				initialized;
 	struct amdgpu_irq_src		*irq_src;
 	unsigned			irq_type;
@@ -146,15 +145,15 @@ struct amdgpu_fence {
 	struct amdgpu_ring		*ring;
 	ktime_t				start_timestamp;
 
-	/* wptr for the total submission for resets */
-	u64				wptr;
+	/* location and size of the IB */
+	u64				ib_wptr;
+	unsigned int			ib_dw_size;
+	unsigned int			skip_ib_dw_start_offset;
+	unsigned int			skip_ib_dw_end_offset;
 	/* fence context for resets */
 	u64				context;
-	/* has this fence been reemitted */
-	unsigned int			reemitted;
-	/* wptr for the fence for the submission */
-	u64				fence_wptr_start;
-	u64				fence_wptr_end;
+	/* idx for ring backups */
+	unsigned int			backup_idx;
 };
 
 extern const struct drm_sched_backend_ops amdgpu_sched_ops;
@@ -162,8 +161,8 @@ extern const struct drm_sched_backend_ops amdgpu_sched_ops;
 void amdgpu_fence_driver_set_error(struct amdgpu_ring *ring, int error);
 void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring,
 					  struct dma_fence *timedout_fence);
-void amdgpu_fence_driver_update_timedout_fence_state(struct amdgpu_fence *af);
-void amdgpu_fence_save_wptr(struct amdgpu_fence *af);
+void amdgpu_ring_set_fence_errors_and_reemit(struct amdgpu_ring *ring,
+					     struct amdgpu_fence *guilty_fence);
 
 int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring);
 int amdgpu_fence_driver_start_ring(struct amdgpu_ring *ring,
@@ -314,6 +313,7 @@ struct amdgpu_ring {
 	/* backups for resets */
 	uint32_t		*ring_backup;
 	unsigned int		ring_backup_entries_to_copy;
+	bool			reemit;
 	unsigned		rptr_offs;
 	u64			rptr_gpu_addr;
 	u32			*rptr_cpu_addr;
-- 
2.52.0

