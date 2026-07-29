Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B128CC53200
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2026 12:02:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31C2410EBBB;
	Wed, 29 Jul 2026 12:02:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mu89A3Xk";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010045.outbound.protection.outlook.com [52.101.85.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40B6A10EBBB
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2026 12:02:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HZ3YSthkFJHh5UUfVlx+dV6C7NN0C5DfpR4pKXlzog5njaemVy+d2WOq4jto/i2Iexu4eOUEusoyrObKK27T1B0NsXIL5R9BYQq0UiWNXCurSxlZTviYgTmsh4euswviCmdwYA9cPQqweFEyeC7t2HDoHcc3PEx49I7wvuc5zhOeIZ0cs5p/Jcm+hXLt5sbcahhL6siTl6ykDA3Z6C4oNoU1jqCiq0fCUsclbj9CGiO0AtmNeuejzAEb94AIW0ODwZY85fEVKl4oeCrjKwgMx80Dt5+FDEwnhq1lKo+/LJFjwh/u5u2YFsZKkDqIZNMFh065rbJ7dQ6tKXX90ycyDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PqV1s+0TUT04+54hBnaaYzYP/Lyn17aVgmAu8uvMbXU=;
 b=c1+7o7zw1kMtJne0Rfu8zHpqK8a52BevftpWeVvNXjfQPw5pJ5l9TuFbc6hdZXk8odU39n5AM3wYzmWtjCN/XFePNaL0c8XPJNADI3rmfwNO+KCzxyV1Iqf08tLQBbdCXx0H/8lTEJ/litwpyYZUjpt+stGkRW6sWVKnjv8RFnagNy6DsUh4KROyOKwgB/3T8G6XcggMBP9mqbGia0nU1utB+m9jHO8wYQoxQ78tnz+4/09kJ0tCQWWQreNZ07rk+gzVfP8aDCkG5q4YpBUEnfKOwNRU/yzWWstoCcqPFcUtEaiAMD9tr8bRtbKVb6QAqgF1TE6idtAKyaEsk5hPvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PqV1s+0TUT04+54hBnaaYzYP/Lyn17aVgmAu8uvMbXU=;
 b=mu89A3Xk/63L0EUbg26V7ScuYbj1LmQWpbzQTO+PADISW7R8rJ39EstLho+dlniWji5IkwWzbw09YTDAFMvsXLXYCgqTrdv/74IrBIhib6kIt8cOcdXOjRqYbJarSHNfTA29p42m6Yzr9x6cft40qBYhbf1uJ2FSd1MQIxjmlnE=
Received: from BN9PR03CA0558.namprd03.prod.outlook.com (2603:10b6:408:138::23)
 by SAVPR12MB999169.namprd12.prod.outlook.com (2603:10b6:806:4e5::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.13; Wed, 29 Jul
 2026 12:02:15 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:408:138:cafe::86) by BN9PR03CA0558.outlook.office365.com
 (2603:10b6:408:138::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.12 via Frontend Transport; Wed,
 29 Jul 2026 12:02:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Wed, 29 Jul 2026 12:02:14 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 29 Jul
 2026 07:02:04 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <pierre-eric.pelloux-prayer@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Allocate coredump ring buffers per ring
Date: Wed, 29 Jul 2026 17:31:18 +0530
Message-ID: <20260729120118.1659135-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260729120118.1659135-1-lijo.lazar@amd.com>
References: <20260729120118.1659135-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|SAVPR12MB999169:EE_
X-MS-Office365-Filtering-Correlation-Id: ac4b1f60-6cc5-4659-7aac-08deed693ad1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|376014|36860700016|1800799024|6133799003|22082099003|18002099003|3023799007|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: YQhVQk4y0ARnSvOel4fRzcAOdJM3GAmYH8+czJExD2yiXfy7mLO8Bml9FhMkRC9y06EezuRv/zNwbt4Cxx9fND8aHQtCr+QB0timbBodMzoY8llhft+hd0b95HtQk9m6js9CyZPfze7sOOevwX9wWVzXTDOrgLernGt1be/zUPASe8BFXts1vQbHRkhrFzzEDcUchQeJARBPAB0o7ZUUYl3KlEM5SgdZcZ3zZcY23UZIZnHry4oS2b2hxkp267JVPLh6mjtX8tl8icxpey9Ne0+g3lRusWk7DPgYWDkBqZx73DJBhFG2IHnviCQy7n/loaPrgHxHRX3dr1Ws5dsKDwoObMYuZxHL2QrdqX85qP0a7km/t6TcyNTx2fnhSrtFSv4i0nUeknnx0Ucgz+sz3CzIZssriZJO7a2xVl+XDH/4n4RR5PG2lqwKV9XBBORCXX8O7Kc5NNADvq/Yp9+pFIKX0Myg4aI543WaW2FEfItwsslIHcZPoZC/UWD4Qq27lWqGu08io1v7CMAJF6O4aCCDJ5mkaBxWZ/tbYC6ZnVChJoNVFsb6dl8i/8LpAT/sIA29eFe6ey6wgmVlDzEPzPr9fWgxvncVXk+nfONzdPvTWFwQvkf4R3M7eOzPYfsIzXxuh3rJtHOmYl2Q6FsDGeArJDHOIIVkhQzr6awgAjX89hC4zV8ZwTF+e9yXMgew2XT73FCfbbBjuhHsnIVbyw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(376014)(36860700016)(1800799024)(6133799003)(22082099003)(18002099003)(3023799007)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0rgAHPdIFZCMupsmK6V8pZRRCCrybVFL/Vb1c4qkVZXmiLeaKuhv+PI+FKuaeR0jeS14cB4oBctYhZA+MnJXS+7vMktRxHrx8W1rI36oazS+gX8gBwqs0kOy/0yuqqaLbeIPYO8x0oGuVosmV0u6odjhWpLp3KAzb+Uko7wUOSstLjs3J8oduKhKsbzm6B415/a0MMLsHVXrPaDcaMHAL4OmYJB61dsMJf54014gWMgoPmnCkBHxYnfElXVUQ66grKx0Ep9kphg2F9UMUG1Q7JTvlDREk7yG5NaqpiHdxNm9OvCtunS7i/rWxVZ2ZXNobiChNqCCS8YE9VgbzcqYjwhBQpEQlmaJfKEh5WgZE+C23YMy1bVGUjuUXRdrYJq3tkQLGrgRQuL43v/hChAq5XlXCOnX/ukzZLHJBGu5zaC6vLANWmkF2pNAHTyQ4LqB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 12:02:14.6456 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac4b1f60-6cc5-4659-7aac-08deed693ad1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAVPR12MB999169
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

Allocate each ring buffer separately. A single allocation summing all
ring sizes can exceed the page allocator's MAX_ORDER limit and fail;
per-ring buffers stay small enough to satisfy. The existing allocation
style doesn't capture any ring data if the huge allocation fails.
Splitting into multiple allocations helps to capture as much data as
possible for the core dump.

A failed ring is left with a NULL buffer and skipped when formatting.

Fixes: eea85914d15b ("drm/amdgpu: save ring content before resetting the device")
Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Assisted-by: Claude Code
---
 .../gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c  | 50 ++++++++++---------
 .../gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h  |  3 +-
 2 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
index 4dfea36997d4..87e15e39eb30 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
@@ -343,7 +343,7 @@ amdgpu_devcoredump_format(char *buffer, size_t count, struct amdgpu_coredump_inf
 	struct amdgpu_ip_block *ip_block;
 	struct amdgpu_ring *ring;
 	int ver, i, j;
-	u32 ring_idx, off;
+	u32 ring_idx;
 	bool sizing_pass;
 
 	sizing_pass = buffer == NULL;
@@ -443,7 +443,6 @@ amdgpu_devcoredump_format(char *buffer, size_t count, struct amdgpu_coredump_inf
 		for (i = 0; i < coredump->num_rings; i++) {
 			ring_idx = coredump->rings[i].ring_index;
 			ring = coredump->adev->rings[ring_idx];
-			off = coredump->rings[i].offset;
 
 			drm_printf(&p, "ring name: %s\n", ring->name);
 			drm_printf(&p, "Rptr: 0x%llx Wptr: 0x%llx RB mask: %x\n",
@@ -452,12 +451,18 @@ amdgpu_devcoredump_format(char *buffer, size_t count, struct amdgpu_coredump_inf
 				   ring->buf_mask);
 			drm_printf(&p, "Ring size in dwords: %d\n",
 				ring->ring_size / 4);
+
+			if (!coredump->rings[i].ring_dw) {
+				drm_printf(&p, "Ring contents unavailable\n");
+				continue;
+			}
+
 			drm_printf(&p, "Ring contents\n");
 			drm_printf(&p, "Offset \t Value\n");
 
 			for (j = 0; j < ring->ring_size; j += 4)
 				drm_printf(&p, "0x%x \t 0x%x\n", j,
-					   coredump->rings_dw[off + j / 4]);
+					   coredump->rings[i].ring_dw[j / 4]);
 		}
 	}
 
@@ -498,10 +503,12 @@ amdgpu_devcoredump_read(char *buffer, loff_t offset, size_t count,
 static void amdgpu_devcoredump_free(void *data)
 {
 	struct amdgpu_coredump_info *coredump = data;
+	u32 i;
 
 	kvfree(coredump->formatted);
+	for (i = 0; i < coredump->num_rings; i++)
+		kvfree(coredump->rings[i].ring_dw);
 	kvfree(coredump->rings);
-	kvfree(coredump->rings_dw);
 	kvfree(data);
 }
 
@@ -543,9 +550,9 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool skip_vram_check,
 	struct amdgpu_coredump_info *coredump;
 	size_t size = sizeof(*coredump);
 	struct drm_sched_job *s_job;
-	u64 total_ring_size, ring_count;
+	u64 ring_count;
 	struct amdgpu_ring *ring;
-	int i, off, idx;
+	int i, idx;
 
 	/* No need to generate a new coredump if there's one in progress already. */
 	if (work_busy(&adev->coredump_work))
@@ -585,7 +592,6 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool skip_vram_check,
 
 	/* Dump ring content if memory allocation succeeds. */
 	ring_count = 0;
-	total_ring_size = 0;
 	for (i = 0; i < adev->num_rings; i++) {
 		ring = adev->rings[i];
 
@@ -594,38 +600,34 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool skip_vram_check,
 		    coredump->ring != ring)
 			continue;
 
-		total_ring_size += ring->ring_size;
 		ring_count++;
 	}
-	if (ring_count) {
-		coredump->rings_dw = kvzalloc(total_ring_size, GFP_NOWAIT);
+	if (ring_count)
 		coredump->rings = kvcalloc(ring_count,
 					   sizeof(struct amdgpu_coredump_ring),
 					   GFP_NOWAIT);
-	}
-	if (coredump->rings && coredump->rings_dw) {
-		for (i = 0, off = 0, idx = 0; i < adev->num_rings && idx < ring_count; i++) {
+	if (coredump->rings) {
+		for (i = 0, idx = 0; i < adev->num_rings && idx < ring_count; i++) {
+			struct amdgpu_coredump_ring *cdump_ring;
+
 			ring = adev->rings[i];
 
 			if (atomic_read(&ring->fence_drv.last_seq) == ring->fence_drv.sync_seq &&
 			    coredump->ring != ring)
 				continue;
 
-			coredump->rings[idx].ring_index = ring->idx;
-			coredump->rings[idx].rptr = amdgpu_ring_get_rptr(ring);
-			coredump->rings[idx].wptr = amdgpu_ring_get_wptr(ring);
-			coredump->rings[idx].offset = off;
+			cdump_ring = &coredump->rings[idx];
+
+			cdump_ring->ring_dw = kvzalloc(ring->ring_size, GFP_NOWAIT);
+			if (cdump_ring->ring_dw)
+				memcpy(cdump_ring->ring_dw, ring->ring, ring->ring_size);
 
-			memcpy(&coredump->rings_dw[off], ring->ring, ring->ring_size);
-			off += ring->ring_size / 4;
+			cdump_ring->ring_index = ring->idx;
+			cdump_ring->rptr = amdgpu_ring_get_rptr(ring);
+			cdump_ring->wptr = amdgpu_ring_get_wptr(ring);
 			idx++;
 		}
 		coredump->num_rings = idx;
-	} else {
-		kvfree(coredump->rings_dw);
-		kvfree(coredump->rings);
-		coredump->rings_dw = NULL;
-		coredump->rings = NULL;
 	}
 
 	coredump->adev = adev;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h
index 63f27337c09a..cb874d8c3394 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h
@@ -34,8 +34,8 @@
 struct amdgpu_coredump_ring {
 	u64				rptr;
 	u64				wptr;
+	u32				*ring_dw;
 	u32				ring_index;
-	u32				offset;
 };
 
 struct amdgpu_coredump_ib_info {
@@ -53,7 +53,6 @@ struct amdgpu_coredump_info {
 	struct amdgpu_ring              *ring;
 
 	struct amdgpu_coredump_ring	*rings;
-	u32				*rings_dw;
 	u32				num_rings;
 
 	/* Readable form of coredevdump, generate once to speed up
-- 
2.49.0

