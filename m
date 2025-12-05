Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E3B2D33980
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Dec 2025 15:20:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47EF089023;
	Fri,  5 Dec 2025 15:20:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zvrSeXCO";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010067.outbound.protection.outlook.com
 [40.93.198.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B15A89023
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Dec 2025 15:19:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O/S6r7k8wmRU67ssLSNuB4ek3FAF5oBFklxJJfeN7j7sRy6BHiAuwnHaumZDC9BbxGanM+6q9yAbeRYHjDhjQi2zybHa5Xxyi0Yub2hk/wAWtCUL6j/5LPT5Rvwh3pjPBScli07iGOgiz8GrGIQElnhIyv5GFjEyvORqJCauS5tlrFsVKVYBnHJjyWDeOyo0YeUhoG2EOMQeYqxIvVbtFgfUUksBGGQnI8F677FUJm2xlc4mCB0rIDBvJ/7IOVSCukNoEUWOLXOTKX6FVCV0RhB9OaHtsxPipkzhfUUTOpedcLHEEGxfXsL8W0GOLa8uXBuzoaoWUtcbnzDtMN6Aog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eJ9buTumH/Te6+T//OTzv0mlers0vfAFIeNZgUP7Mcw=;
 b=a/AiL5QSH8Mf5MBhSgZSd6Hk/IH/UtHr9OAMzp7KcJ2rTgMyb9+oBuJk7znO5B8/15InYxgX/fXf2HfaBdZgSfXGqciQiW6POq25G2Yff7uqJkb/N+h/UAYGIda59bP0+nQXQxgHXUJNwsHSugNt1XlrdziTpru7gnGMbxtv+kE/L3Re263N1fKE7QUGQa+nceLN3oz5ccHRBHMk85RtcfdhcXYUzVgdkps/TWcZzT9FgtBJC7fj1tTuez8IOWiI3qw3FS/Oh2jqDUUAn878TgPEeu/rswElCL4ecpL2sZvhGwPOyLVva04ik8Nyir1pl+jbJXm5Qfw86aof/WDwWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJ9buTumH/Te6+T//OTzv0mlers0vfAFIeNZgUP7Mcw=;
 b=zvrSeXCOIGWjjW2DrjPJPZqro6XvXThVVmMxpnbfD2OEokLevMsShVVaOA3wRiidJkZ1lpG8PKBbEW784Q0TzuVGyd1qNLoIoMcDQ2x99Cl6tpqFpShoywNTmnrldJLunxYwiKgBqB29IM/dhidub81Mwcbw/PXzw8Q/S/fKVtg=
Received: from DS7PR03CA0085.namprd03.prod.outlook.com (2603:10b6:5:3bb::30)
 by CH2PR12MB4309.namprd12.prod.outlook.com (2603:10b6:610:a4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.12; Fri, 5 Dec
 2025 15:19:54 +0000
Received: from DS3PEPF000099D9.namprd04.prod.outlook.com
 (2603:10b6:5:3bb:cafe::71) by DS7PR03CA0085.outlook.office365.com
 (2603:10b6:5:3bb::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.9 via Frontend Transport; Fri, 5
 Dec 2025 15:19:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099D9.mail.protection.outlook.com (10.167.17.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Fri, 5 Dec 2025 15:19:54 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 5 Dec
 2025 09:19:53 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: always backup and reemit fences
Date: Fri, 5 Dec 2025 10:19:41 -0500
Message-ID: <20251205151941.7980-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251205151941.7980-1-alexander.deucher@amd.com>
References: <20251205151941.7980-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D9:EE_|CH2PR12MB4309:EE_
X-MS-Office365-Filtering-Correlation-Id: a10fab23-6ae1-493a-7ac4-08de3411be84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TSfefpqumHYYJ6/sRWQdiVOtx5K13AvOQyrqQ1IxD8yGDCKz7a2MQIO70iIm?=
 =?us-ascii?Q?7hkB76cG4SDgJMI8RypTf2IeGBOa5vR+VJ58aQGIsf6sjRS7uaJ0v0PIHKee?=
 =?us-ascii?Q?9tvtwNA/g2Em5VexkIFsJni2Yd29MSUOZdBEkm70uDPDrkUuZf/6ms0+JL21?=
 =?us-ascii?Q?s/C1dEsWgNoE/STdGONETSw71L6LCe8WUPJH1IedeEcetHoHnY9YBkHqUq3M?=
 =?us-ascii?Q?Vgra6fYHijL8utOgJHqWJ3jT0Q1Ij/7c1jFXIgsKGXx4OXhFOHGxKRiSJ+OT?=
 =?us-ascii?Q?MvldvW+KmBazlTWjjvcIv+4+KWxdCHUDcpRAYsuXGxTgT9ZyvXSPWvMAnHci?=
 =?us-ascii?Q?ovN/TITTEDFdQNQyAdxjFyNHVnc2SApdrTezyzAewYGBh5aSKJwLCIcj7DX+?=
 =?us-ascii?Q?OsC9BnCXPs+gY1J+9FigDgK2/B8sr+l9VSI2+EXa5AR01wh0hCJQvCZmzF8d?=
 =?us-ascii?Q?VTuKgE4heZRwUwq2NdK+OJuzn7356mr516XMbTW5gXVVpVk43/A8lKMufeIA?=
 =?us-ascii?Q?dazxx0cUAk8a+FJq+AQuSE+GUCXieSBWQIukoJ8LZc9VqIUmXKg56UfZ4fkd?=
 =?us-ascii?Q?X32CDZ9mEA5/xWkMMo7B6iZj6pUK3Tsa1/LSIJ0BSKnWo4EkejgvEZEhx3fJ?=
 =?us-ascii?Q?7xIcIiEcaDUt/EehonnW3VGTxh4ZYXdbM2hzqLIZm7Gh/VnefKa757Fblnbk?=
 =?us-ascii?Q?iLwVHKrVTHkqTbb4TqlgjEKyM+S1E5f+5yATGbmYqzqodXfm85BpDxNCjDJ4?=
 =?us-ascii?Q?aByXBS7vDMQgHEZjcyKk/pKwOno27GZS9TMIkzmHb59z6XyaDYQ42sIdn4Rh?=
 =?us-ascii?Q?7POgWJBr9W9sWivPYN+j+mW0ZDGF/ER3BHQHiTM+DTjR6U5WoKoDEyDyMRdz?=
 =?us-ascii?Q?bbXgEdWsrk3h3tV9cKDXVssxRBKbLi3DrI/rPrTHjbiDV2dmgDbF0anKlYu7?=
 =?us-ascii?Q?RGH2SGM08/MvCzhLVTY73a+0Jna0E4EqcsmQRUlhRTTHhd+EuP3JUz8+XEZt?=
 =?us-ascii?Q?x4OA1aQ56pLMS6WEel/w0a2BhArizsUe2nWlT+5QfsY878OLnryPGvysvblT?=
 =?us-ascii?Q?A2EdqbQv6mQfMKHnoiO2jIMuoiQI86vUn19wz4J6ZXgetqAO5KQIRF2V/4jq?=
 =?us-ascii?Q?Pl8C8G7laLF8krALbfIk614kthNZ8wRK5WFElQzjjypqQSrTb+Bl3TusrynV?=
 =?us-ascii?Q?+4KPNQVMg0h6HrPOJLKQARC+UR4amTQn6KtN+ZMOwS2cA3l0sTq2Yd/n4IiW?=
 =?us-ascii?Q?y73xJEpUNFxwnllyYbiCoRsIY3CptoEgdrgKlRPYCeAo9bSPlULm6jJR2sS3?=
 =?us-ascii?Q?A2iGNHwbS2OEh/XtUgLJgCFk9d84eI9pnuU6lVbjGG2fLCBprcPWjYmwA9gm?=
 =?us-ascii?Q?hGS7OAcQOkuRPw0PoT2CZWlz5b3oXgE87hID5BQydsznHtMVgLhhE5/q4Xxq?=
 =?us-ascii?Q?/5YGVqSrF3Se6TVEY/2DLCfy+MFJXWVEo9mrv1yaSN+FVp6VpeZtH9WWG5PW?=
 =?us-ascii?Q?TRFH3foAqjl5sYv9geJGMODDcnqNNbwReCGCD55AhNLJZFapBd7fdhLKawcK?=
 =?us-ascii?Q?xY7a5e5esP3JxAfIrnc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 15:19:54.7822 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a10fab23-6ae1-493a-7ac4-08de3411be84
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4309
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

If when we backup the ring contents for reemit before a
ring reset, we skip jobs associated with the bad
context, however, we need to make sure the fences
are reemited as unprocessed submissions may depend on
them.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 29 +++++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  |  8 ++++++-
 2 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 334ddd6e48c06..9dfae9532c70e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -116,8 +116,10 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct amdgpu_fence *af,
 		       &ring->fence_drv.lock,
 		       adev->fence_context + ring->idx, seq);
 
+	amdgpu_fence_save_fence_wptr_start(af);
 	amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
 			       seq, flags | AMDGPU_FENCE_FLAG_INT);
+	amdgpu_fence_save_fence_wptr_end(af);
 	amdgpu_fence_save_wptr(af);
 	pm_runtime_get_noresume(adev_to_drm(adev)->dev);
 	ptr = &ring->fence_drv.fences[seq & ring->fence_drv.num_fences_mask];
@@ -743,10 +745,6 @@ void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *af)
 		/* if we've already reemitted once then just cancel everything */
 		amdgpu_fence_driver_force_completion(af->ring);
 		af->ring->ring_backup_entries_to_copy = 0;
-	} else {
-		/* signal the guilty fence */
-		amdgpu_fence_write(ring, (u32)af->base.seqno);
-		amdgpu_fence_process(ring);
 	}
 }
 
@@ -755,6 +753,18 @@ void amdgpu_fence_save_wptr(struct amdgpu_fence *af)
 	af->wptr = af->ring->wptr;
 }
 
+void amdgpu_fence_save_fence_wptr_start(struct amdgpu_fence *af)
+{
+	af->fence_wptr_start[af->fence_count] = af->ring->wptr;
+}
+
+void amdgpu_fence_save_fence_wptr_end(struct amdgpu_fence *af)
+{
+	af->fence_wptr_end[af->fence_count] = af->ring->wptr;
+	if (af->fence_count < 2)
+		af->fence_count++;
+}
+
 static void amdgpu_ring_backup_unprocessed_command(struct amdgpu_ring *ring,
 						   u64 start_wptr, u32 end_wptr)
 {
@@ -775,6 +785,7 @@ void amdgpu_ring_backup_unprocessed_commands(struct amdgpu_ring *ring,
 	struct amdgpu_fence *fence;
 	u64 wptr;
 	u32 seq, last_seq;
+	int i;
 
 	last_seq = amdgpu_fence_read(ring) & ring->fence_drv.num_fences_mask;
 	seq = ring->fence_drv.sync_seq & ring->fence_drv.num_fences_mask;
@@ -796,9 +807,17 @@ void amdgpu_ring_backup_unprocessed_commands(struct amdgpu_ring *ring,
 			 * just save the content from other contexts.
 			 */
 			if (!fence->reemitted &&
-			    (!guilty_fence || (fence->context != guilty_fence->context)))
+			    (!guilty_fence || (fence->context != guilty_fence->context))) {
 				amdgpu_ring_backup_unprocessed_command(ring, wptr,
 								       fence->wptr);
+			} else if (!fence->reemitted) {
+				/* always save the fences */
+				for (i = 0; i < fence->fence_count; i++) {
+					amdgpu_ring_backup_unprocessed_command(ring,
+									       fence->fence_wptr_start[i],
+									       fence->fence_wptr_end[i]);
+				}
+			}
 			wptr = fence->wptr;
 			fence->reemitted++;
 		}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index f93bf83f7f5e4..51b80c18ded9c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -151,12 +151,16 @@ struct amdgpu_fence {
 	struct amdgpu_ring		*ring;
 	ktime_t				start_timestamp;
 
-	/* wptr for the fence for resets */
+	/* wptr for the total submission for resets */
 	u64				wptr;
 	/* fence context for resets */
 	u64				context;
 	/* has this fence been reemitted */
 	unsigned int			reemitted;
+	/* wptrs for the fences for the submission */
+	u64				fence_wptr_start[2];
+	u64				fence_wptr_end[2];
+	unsigned int			fence_count;
 };
 
 extern const struct drm_sched_backend_ops amdgpu_sched_ops;
@@ -165,6 +169,8 @@ void amdgpu_fence_driver_set_error(struct amdgpu_ring *ring, int error);
 void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring);
 void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *af);
 void amdgpu_fence_save_wptr(struct amdgpu_fence *af);
+void amdgpu_fence_save_fence_wptr_start(struct amdgpu_fence *af);
+void amdgpu_fence_save_fence_wptr_end(struct amdgpu_fence *af);
 
 int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring);
 int amdgpu_fence_driver_start_ring(struct amdgpu_ring *ring,
-- 
2.51.1

