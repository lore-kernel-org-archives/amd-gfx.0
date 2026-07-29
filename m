Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 010D7C54F51
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2026 11:25:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9223C10EB8C;
	Wed, 29 Jul 2026 11:25:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PSN/4A6C";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011013.outbound.protection.outlook.com
 [40.93.194.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD21010EB8C
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2026 11:25:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RJKXhetJq7yfs/T0G3gkE6VAX3hniqarOY3Fw2tj66fVmYALMTZm0Bn0JKtTR6zoR6D+6H0mJ7fwOD/uDACy+oG4aahSUQLaMTAYR0aHCL8gw3tuooGphbEchzUhSQ8Xp42opv4ZMy6ZixIQD8bJQwS9NtFUJT6kcMN4p7BS+moOiJFjvs9VQzOvalZ/P7zrYigDbh4Z/+J/5C0CGK40EavobFhIMTHSC9dlFhTBNZtXcSvTKBYX58PKXA3wyiL2ttoLMtLEMD+SQzvVbsiLTEYFL1N84PXIcxEnptqPECUiT2a0T7nwYqjrc+/NAFhoL2vNR5yDjVmLG1nJRF6Wsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PqV1s+0TUT04+54hBnaaYzYP/Lyn17aVgmAu8uvMbXU=;
 b=SBsNw2z6FvdIRfOf2h5bviM2b1Sc46no9Na4dZt47SFN7eR67EkSBzA54TuOMGGpik6Q9DW5FmPIdaKzT+hpVvFAMBe0NBKZ2oOwv6+6HOQdk3zSddDLdoaoBG5XtbQvObb2LZd2Jk5TaKQTk9t718hCsjVCTRLki6muDXr7HIvLWmf3CsT66dMhKlc2Z/IJ7gKV7Rl8n1SirYqh4aLZV48uPNKndKaIJLXPCmiJ7Pj0H/gcX4Ogcp8rS+pCTXNFhOi2S8WEXYbnTKOALyu4AS8yX+KXD8w0CRDBSa82akd/AxqW5KSB8v1/w7tFOAMvfOtsENHsgApGoeClpM9XvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PqV1s+0TUT04+54hBnaaYzYP/Lyn17aVgmAu8uvMbXU=;
 b=PSN/4A6ChtwngRYt4xUcIBWz0rpDrtTQhRQa4nWlWvQIBY2C99oKPE21nUZ7U2H6KQVWAFKzzOoUiFXn1B/eNv3lXFQUIKTWr7kIIAwauuN07zQSxs2QqQcBvUStUIMcQ21OpF7EowcCTKIqzUiCoUDhhjwpZCpL/vpFeLLuVr8=
Received: from SJ0PR03CA0138.namprd03.prod.outlook.com (2603:10b6:a03:33c::23)
 by SJ0PR12MB8116.namprd12.prod.outlook.com (2603:10b6:a03:4ec::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 11:25:11 +0000
Received: from BY1PEPF0001AE1B.namprd04.prod.outlook.com
 (2603:10b6:a03:33c:cafe::2e) by SJ0PR03CA0138.outlook.office365.com
 (2603:10b6:a03:33c::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.13 via Frontend Transport; Wed,
 29 Jul 2026 11:25:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE1B.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Wed, 29 Jul 2026 11:25:11 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 29 Jul
 2026 06:25:07 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <pierre-eric.pelloux-prayer@amd.com>
Subject: [PATCH] drm/amdgpu: Allocate coredump ring buffers per ring
Date: Wed, 29 Jul 2026 16:54:52 +0530
Message-ID: <20260729112452.1644707-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1B:EE_|SJ0PR12MB8116:EE_
X-MS-Office365-Filtering-Correlation-Id: 927a1132-1fe1-4ad2-dbf4-08deed640da3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|3023799007|6133799003|56012099006|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: YY2N73UxBmMPcQBU3qCMXZ/p8lj5pWOC2Zg8EHB6K99wri0YgzJi0F382enkMnGnWTxLKbWnD6jKJFRsq7Mpw7sFNiUo0fowLik58GAKkIayLdtro+5XXsOn8QsHyzhWrN3fpM5nEDE57evAbFp9VjtvTuFINH8IWE2BrEedimZt0WC9cc5ocVmGvTMreRPMVflqmBA3KxzIWjC99NuN80vzy8gahBV777hlElGirmkMyKBYIVl4C0yhcJzZGu44TQbaOBqEwMUsr9wrqHOnCf/FHBZiVgLkkeQfZX5gLzWZs8D/NmjFsAFBqIGnaix9RCNnoB1+Ed3yTgN4ZjHv2fu5kY0zQbJplqF7YupnifnPzMjtr0d+h6zWVlc8bs/ebUspXIgpb2XQzAwJRSwaSE0EghmOLLrKNwVVAcXTQkj6YOdQry7rrqRLvhio7Ruo7YGkFqfN5aJcm5UlEaYn7MDXwBdpbv/2YSA12Yp5GS1nFKyQtwQLpXghPGsT7KrmD9IZeqov6+St3QrSw3T3zETHTiArXt36jOTIyFjqr0CQSAsVz5P/2QtqiKUdoDlrE8h5SQuggi7PdoW16EfKfEw14GryTolaVgA9O6aDd6yrSw7S8M4vLIewkqXSltc3AM8exBgthxKyOGBAM9aWncARM6eQYZXSF5n2R6mnlFl09vZYNqNuMTM7Lvdl5WRtMJtypPuNRaq08TO93m9mmA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(3023799007)(6133799003)(56012099006)(11063799006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vY7RT1hqdbPoYjoCaYg++nKftFLgBC3yhRd5yih52pPP5WwoOWpgdUYD8Req4X7TSBvoTFkP/J19NxJD6+NXJm8YXIoUxBW40G7tg3+P7xExiM9CnwYZL6h3Mm0N94+5rw0pOnpJY3+2hEgWaryYUZKzJSCXmJJD9JPVIvLE9Eb/ZAvfejs4jGJE9I60tB9ByClJRPoZCc3pd9AmEjDbJpp4NIQJfRF/HwAcFCDtI9lY7Pm+1AyssPrhM8RR0u3YxDFtD08ky5MFAu0ETflU+aIZxEaZIcJhtfaNxoOfIAs9ZsnxO7IevxMvxZ4VfNrglS3tjZG0gfn/MvNvNWk9T8am7S+rvA1KxH6wiGekjegR2MVXgRuAt6162qzfzgKEWCNVev1FdfnH3KeAATXycW71cb5fUHPrCeentr99/oaRA1Gczd6tF+61bb/+eInm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 11:25:11.3912 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 927a1132-1fe1-4ad2-dbf4-08deed640da3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8116
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

