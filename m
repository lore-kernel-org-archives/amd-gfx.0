Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5540F106F30F
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 09:43:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E04F810E960;
	Thu, 26 Mar 2026 09:43:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n4AkL+hp";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010061.outbound.protection.outlook.com [52.101.201.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B36710E9E8
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 09:43:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m72hopBNLsFqX9xejJgyF2XeQCw19l+240R4XYAQum+bANvkHgwcfiY6QGpX3GExrGYomCRlavdhW4rYKVchuiHePam33sr2DyCmgKM99Y5eDXZ7No0w2IHDfPxw6e2CfTJfjonLbg90BmwV/3mUAnI16TXUTDK/WMH05ddIOhgAjyoY0ciQxx3r2j1EGVQ4mM15s4oRbYzrlPanRArknSlOkeCHGXl7+FdaDlxHPjh9BPieGkNtblvh2sm6stScoZzoekESXPk5hr8+vvBXpz5mvr7WI/oc4b+VrTGKPlIxed4HVlz/6g94EBLVVEPbQ6B1XTBGol5V+bxY+XetZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YJNz8hA+u/z7JFuZhpOcd6IHdMulWIDG4GR3GMigV6g=;
 b=VDYDFXmYTDFtHGo3xqtXRC8etWc4DP+xtcooAV19xQg3nihGBws829oMGpPK+ervuxznR1OlnP7qW+kMSLWCZcFOvBV+aqJcU8WX1e7MsqaNGjw6Ia7E1T1V78g0TmMSC624WbmqgDv4DqaABL3O18INV29tfiyhfcCJRZxh11G2ni4nd97PuocIq2+CM4zJAVC4KyWlz62kcuyVBdCJ0UhJ6Sde+5RX5k4A6lgPbWcz1nHPGdG3Kwc6q72+e61C2iclEVE/UgqXr9BebE0i7rJizXIkZUggc5Img8kwRuSnfOgnh/rN/ATp4nH9akq9PSq8ir5BHhNmtFhAmgJ1sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJNz8hA+u/z7JFuZhpOcd6IHdMulWIDG4GR3GMigV6g=;
 b=n4AkL+hp5QIBG4GIqhzy7yqYMnGAClItEeM+aPbKZBid7KAk6CRkpE96Scwexhc1FVgsyOazviI5ox8D5x6GqdKtO3sDy8b26xGxBN4i9uhMYsoj3IFOUN0NWGa1gUvPBA7wKJ0y2hLYASITXwTCCH6ICXSVe1F/chDoeQpXjeU=
Received: from SA9P223CA0015.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::20)
 by DS0PR12MB9445.namprd12.prod.outlook.com (2603:10b6:8:1a1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Thu, 26 Mar
 2026 09:43:09 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:806:26:cafe::c4) by SA9P223CA0015.outlook.office365.com
 (2603:10b6:806:26::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Thu,
 26 Mar 2026 09:42:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 09:43:08 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 26 Mar
 2026 04:43:07 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 26 Mar 2026 04:43:01 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Shaoyun Liu <shaoyun.liu@amd.com>, Michael Chen <michael.chen@amd.com>,
 "Amber Lin" <Amber.Lin@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>, Jesse
 Zhang <jesse.zhang@amd.com>
Subject: [PATCH] drm/amdgpu/mes: migrate KCQs to sched pipe around MES
 suspend/resume
Date: Thu, 26 Mar 2026 17:41:02 +0800
Message-ID: <20260326094255.822066-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|DS0PR12MB9445:EE_
X-MS-Office365-Filtering-Correlation-Id: 92407190-6843-473a-7eb4-08de8b1c1678
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: r9X+o0PU2oFtwtApNMwSWAdK741IANg0mGaORsX4jxLGbQ2roGNxvOuX0RLE3d6G46xZ9V7UKPVOKnLc3d5hONTnT8skF45pJzhaErLbudnR2nzZPJbsEVLtP1loixMYqCM3SAYf5ptCptOesfg2KBpevF8YclHeIKH8wGt1Zg6QG0DFniecUT/AXc7/eHUoKE7rATlHrGx8hpwME6hTsXATcnrvzI10IFth/3DJsyB4E9U3kxBcOnY5kcPqCq3zfIM044P5Md8H1UJCli1B2idJxk1ne8Iqy1KGbT4TRN0BJWZAYoj7pTb6olea7MnJDekIL3zCgT3DAFdPHnQkF2Sw4RTnx0B+wNT+3m79yLu/TLEYaJQ482iOo8i/uNeK8PRey0CV6CqBPMHgDwA+FexK90snSTmT6ThahQ3u+G0deaU++BSzC4rnKVm9knjA4MKMYq6iAqjN1kqtHUhFxn/yBARMMvQvlGCEq5BbwBJIsEqeKCh0BntIPiBnhqh+JpU05zwbIJSzTXy5txxxlvoOx2KEHYxezV/fM3V0uQJ44cLREdBMkJuS8Fi7yEnQXkxHj7yXhufj3XEyL5er/xZVTKMicWF/XuIyGqjK0SZkf8OzLz1hcp62oGKePFfEh+oLbRZJgyxQe6UAkkMynXw0SyDVHOm0Jl/No2kTn1ryWVAR7PAG+5mVpwV3/Uy7/mCVauycNucWwwuXn76/qw2wh4LiANHKE0qFgDU+hK5AryMyMdEw6pFqU0Wzrug5wm1yJQjL7X62zzH2WJjs8A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: B9lVcJqsqc1IRuTwSpYycYlUwtdKB4eeQ64LNLUe7IZgiiZZOatOvbu1j/FdUmicPU5N8a7hqSxqi719KLr6dk2bMd8G56Eo4QYiYF6XWUVOSt317kLT879wB4NTdFa+i4Ghk655w7o4MlnOrgbEhfSCWXjZCFaH+aAfTWroKXqz0Mi8KpTgFK6BPtFIRuofJpj5A4Ka3h5nRuxTPenBq4VgH2HV4XTMthQGJUDvUTTXvB2iY6y7k2RGjd3wlI5am6/V2wwaIXOhOKKjQUq1oywGWcAadUyT2kjUgR56gjra71w+4sLUPEjUNfpuzrJ266cmjooegch6VaUoLwpSMI0DW2lZ4qxE/a3EGVB4MpsJEsWtpd0gipXO5wxFv3RqLaRKKVxPf9JcVqQRZ+2TJAXiZ4t2xw+VSQJuZ2PBgzSuVnP4NAsuADIKtpNFaN0+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 09:43:08.5128 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92407190-6843-473a-7eb4-08de8b1c1678
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9445
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

On GC 12.x dual-pipe MES, kernel compute queues (KCQs) may be registered
on the KIQ pipe while suspend_all/resume_all is driven from the sched pipe.
That can leave queue ownership inconsistent across suspend/resume.

Add an explicit KCQ migration flow in amdgpu_mes_suspend()/resume():
- unmap KCQs from their original pipe/queue
- remap them to sched pipe temporary slots before suspend_all
- restore original pipe/queue ownership after resume_all

Track per-ring migration state (valid bit, temporary sched queue id, and
original pipe/queue), and add rollback handling for partial failures.
If map-to-sched fails for the current ring, restore it immediately before
rolling back earlier migrated rings, so the current ring is not left unmapped.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c       | 315 +++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h       |   7 +-
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c        |   2 +-
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |   2 +-
 4 files changed, 321 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 0d4c77c1b4b5..fe179641e6aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -114,6 +114,9 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 				adev->gfx.disable_kq ? 0 : adev->gfx.num_compute_rings);
 
 	adev->mes.adev = adev;
+	adev->mes.kcq_migrated_to_sched_pipe = false;
+	memset(adev->mes.kcq_sched_migration_valid, 0,
+	       sizeof(adev->mes.kcq_sched_migration_valid));
 
 	ida_init(&adev->mes.doorbell_ida);
 	spin_lock_init(&adev->mes.queue_id_lock);
@@ -281,7 +284,284 @@ void amdgpu_mes_fini(struct amdgpu_device *adev)
 	mutex_destroy(&adev->mes.mutex_hidden);
 }
 
-int amdgpu_mes_suspend(struct amdgpu_device *adev)
+static int amdgpu_mes_map_legacy_queue_on_pipe(struct amdgpu_device *adev,
+						struct amdgpu_ring *ring,
+						u32 pipe_id,
+						u32 queue_id,
+						u32 xcc_id)
+{
+	struct mes_map_legacy_queue_input queue_input;
+	int r;
+
+	memset(&queue_input, 0, sizeof(queue_input));
+
+	queue_input.xcc_id = xcc_id;
+	queue_input.queue_type = ring->funcs->type;
+	queue_input.doorbell_offset = ring->doorbell_index;
+	queue_input.pipe_id = pipe_id;
+	queue_input.queue_id = queue_id;
+	queue_input.mqd_addr = amdgpu_bo_gpu_offset(ring->mqd_obj);
+	queue_input.wptr_addr = ring->wptr_gpu_addr;
+
+	amdgpu_mes_lock(&adev->mes);
+	r = adev->mes.funcs->map_legacy_queue(&adev->mes, &queue_input);
+	amdgpu_mes_unlock(&adev->mes);
+
+	return r;
+}
+
+static int amdgpu_mes_unmap_legacy_queue_on_pipe(struct amdgpu_device *adev,
+						  struct amdgpu_ring *ring,
+						  u32 pipe_id,
+						  u32 queue_id,
+						  u32 xcc_id)
+{
+	struct mes_unmap_legacy_queue_input queue_input;
+	int r;
+
+	memset(&queue_input, 0, sizeof(queue_input));
+
+	queue_input.xcc_id = xcc_id;
+	queue_input.action = RESET_QUEUES;
+	queue_input.queue_type = ring->funcs->type;
+	queue_input.doorbell_offset = ring->doorbell_index;
+	queue_input.pipe_id = pipe_id;
+	queue_input.queue_id = queue_id;
+
+	amdgpu_mes_lock(&adev->mes);
+	r = adev->mes.funcs->unmap_legacy_queue(&adev->mes, &queue_input);
+	amdgpu_mes_unlock(&adev->mes);
+
+	return r;
+}
+
+static int amdgpu_mes_migrate_kcq_to_sched_pipe(struct amdgpu_device *adev)
+{
+	int num_xcc, xcc_id, i, j, r, ret = 0;
+	int rollback_xcc = -1, rollback_i = -1;
+	u32 max_sched_slots;
+
+	num_xcc = adev->gfx.xcc_mask ? NUM_XCC(adev->gfx.xcc_mask) : 1;
+	max_sched_slots = min_t(u32, AMDGPU_MAX_COMPUTE_QUEUES,
+				adev->gfx.mec.num_queue_per_pipe ?
+				adev->gfx.mec.num_queue_per_pipe : AMDGPU_MAX_COMPUTE_QUEUES);
+	memset(adev->mes.kcq_sched_migration_valid, 0,
+	       sizeof(adev->mes.kcq_sched_migration_valid));
+
+	for (xcc_id = 0; xcc_id < num_xcc; xcc_id++) {
+		bool sched_slot_used[AMDGPU_MAX_COMPUTE_QUEUES] = { false };
+
+		/* Seed pipe0 occupancy from kernel compute rings in this XCC. */
+
+		for (i = 0; i < adev->gfx.num_compute_rings; i++) {
+			j = i + xcc_id * adev->gfx.num_compute_rings;
+			if (adev->gfx.compute_ring[j].pipe != AMDGPU_MES_SCHED_PIPE)
+				continue;
+
+			if (adev->gfx.compute_ring[j].queue >= max_sched_slots)
+				return -EINVAL;
+
+			sched_slot_used[adev->gfx.compute_ring[j].queue] = true;
+		}
+
+		for (i = 0; i < adev->gfx.num_compute_rings; i++) {
+			struct amdgpu_ring *ring;
+			u32 orig_pipe;
+			u32 orig_queue;
+			u32 sched_queue;
+
+			j = i + xcc_id * adev->gfx.num_compute_rings;
+			ring = &adev->gfx.compute_ring[j];
+			orig_pipe = ring->pipe;
+			orig_queue = ring->queue;
+
+			if (orig_pipe == AMDGPU_MES_SCHED_PIPE)
+				continue;
+
+			/* Prefer the original queue id; otherwise pick the first free sched slot. */
+			sched_queue = ring->queue;
+			if (sched_queue >= max_sched_slots || sched_slot_used[sched_queue]) {
+				for (sched_queue = 0; sched_queue < max_sched_slots; sched_queue++)
+					if (!sched_slot_used[sched_queue])
+						break;
+
+				if (sched_queue >= max_sched_slots) {
+					ret = -ENOSPC;
+					rollback_xcc = xcc_id;
+					rollback_i = i ? i - 1 : -1;
+					goto rollback;
+				}
+			}
+
+			adev->mes.kcq_migration_orig_pipe[j] = orig_pipe;
+			adev->mes.kcq_migration_orig_queue[j] = orig_queue;
+
+			r = amdgpu_mes_unmap_legacy_queue_on_pipe(adev, ring,
+						     orig_pipe, orig_queue, xcc_id);
+			if (r) {
+				ret = r;
+				rollback_xcc = xcc_id;
+				rollback_i = i ? i - 1 : -1;
+				goto rollback;
+			}
+
+			r = amdgpu_mes_map_legacy_queue_on_pipe(adev, ring,
+						   AMDGPU_MES_SCHED_PIPE,
+						   sched_queue,
+						   xcc_id);
+			if (r) {
+				/* Restore the current ring before rolling back earlier migrated rings. */
+				int rr;
+
+				rr = amdgpu_mes_map_legacy_queue_on_pipe(adev, ring,
+								 orig_pipe,
+								 orig_queue,
+								 xcc_id);
+				if (rr)
+					dev_err(adev->dev,
+						"failed to restore current KCQ during migrate rollback xcc:%d queue:%u pipe:%u\n",
+						xcc_id, orig_queue, orig_pipe);
+
+				ret = rr ? rr : r;
+				rollback_xcc = xcc_id;
+				rollback_i = i ? i - 1 : -1;
+				goto rollback;
+			}
+
+			adev->mes.kcq_sched_migration_queue_id[j] = sched_queue;
+			adev->mes.kcq_sched_migration_valid[j] = true;
+			ring->pipe = AMDGPU_MES_SCHED_PIPE;
+			ring->queue = sched_queue;
+			sched_slot_used[sched_queue] = true;
+		}
+	}
+
+	return 0;
+
+rollback:
+	/* Roll back only rings that were recorded as migrated. */
+	for (xcc_id = rollback_xcc; xcc_id >= 0; xcc_id--) {
+		int start_i = (xcc_id == rollback_xcc) ? rollback_i :
+			(adev->gfx.num_compute_rings - 1);
+
+		for (; start_i >= 0; start_i--) {
+			struct amdgpu_ring *ring;
+			u32 orig_pipe;
+			u32 orig_queue;
+			u32 sched_queue;
+			int rr;
+
+			j = start_i + xcc_id * adev->gfx.num_compute_rings;
+			ring = &adev->gfx.compute_ring[j];
+
+			if (!adev->mes.kcq_sched_migration_valid[j])
+				continue;
+
+			sched_queue = adev->mes.kcq_sched_migration_queue_id[j];
+			orig_pipe = adev->mes.kcq_migration_orig_pipe[j];
+			orig_queue = adev->mes.kcq_migration_orig_queue[j];
+
+			rr = amdgpu_mes_unmap_legacy_queue_on_pipe(adev, ring,
+						       AMDGPU_MES_SCHED_PIPE,
+						       sched_queue,
+						       xcc_id);
+			if (rr) {
+				if (!ret)
+					ret = rr;
+				/*
+				 * Skip map to avoid double-mapping if unmap from
+				 * sched pipe failed. Leave valid flag set so a
+				 * subsequent restore attempt can retry.
+				 */
+				continue;
+			}
+
+			rr = amdgpu_mes_map_legacy_queue_on_pipe(adev, ring,
+						     orig_pipe,
+						     orig_queue,
+						     xcc_id);
+			if (rr) {
+				if (!ret)
+					ret = rr;
+			} else {
+				ring->pipe = orig_pipe;
+				ring->queue = orig_queue;
+				adev->mes.kcq_sched_migration_valid[j] = false;
+			}
+		}
+	}
+
+	if (!ret)
+		memset(adev->mes.kcq_sched_migration_valid, 0,
+		       sizeof(adev->mes.kcq_sched_migration_valid));
+
+	return ret;
+}
+
+static int amdgpu_mes_restore_kcq_pipe_ownership(struct amdgpu_device *adev)
+{
+	int num_xcc, xcc_id, i, j, r, ret = 0;
+
+	num_xcc = adev->gfx.xcc_mask ? NUM_XCC(adev->gfx.xcc_mask) : 1;
+
+	for (xcc_id = 0; xcc_id < num_xcc; xcc_id++) {
+		for (i = 0; i < adev->gfx.num_compute_rings; i++) {
+			struct amdgpu_ring *ring;
+			u32 orig_pipe;
+			u32 orig_queue;
+			u32 sched_queue;
+
+			j = i + xcc_id * adev->gfx.num_compute_rings;
+			ring = &adev->gfx.compute_ring[j];
+
+			if (!adev->mes.kcq_sched_migration_valid[j])
+				continue;
+
+			sched_queue = adev->mes.kcq_sched_migration_queue_id[j];
+			orig_pipe = adev->mes.kcq_migration_orig_pipe[j];
+			orig_queue = adev->mes.kcq_migration_orig_queue[j];
+
+			if (ring->pipe != AMDGPU_MES_SCHED_PIPE ||
+			    ring->queue != sched_queue) {
+				if (!ret)
+					ret = -EINVAL;
+				continue;
+			}
+
+			/* Move the queue from temporary pipe0 slot back to its original location. */
+			r = amdgpu_mes_unmap_legacy_queue_on_pipe(adev, ring,
+						     AMDGPU_MES_SCHED_PIPE,
+						     sched_queue,
+						     xcc_id);
+			if (r && !ret)
+				ret = r;
+			if (r)
+				continue;
+
+			r = amdgpu_mes_map_legacy_queue_on_pipe(adev, ring,
+						   orig_pipe,
+						   orig_queue,
+						   xcc_id);
+			if (r && !ret)
+				ret = r;
+
+			if (!r) {
+				ring->pipe = orig_pipe;
+				ring->queue = orig_queue;
+				adev->mes.kcq_sched_migration_valid[j] = false;
+			}
+		}
+	}
+
+	if (!ret)
+		memset(adev->mes.kcq_sched_migration_valid, 0,
+		       sizeof(adev->mes.kcq_sched_migration_valid));
+
+	return ret;
+}
+
+int amdgpu_mes_suspend(struct amdgpu_device *adev,
+			 bool migrate_kcq_to_sched_pipe)
 {
 	struct mes_suspend_gang_input input;
 	int r;
@@ -289,6 +569,19 @@ int amdgpu_mes_suspend(struct amdgpu_device *adev)
 	if (!amdgpu_mes_suspend_resume_all_supported(adev))
 		return 0;
 
+	/*
+	 * Explicitly migrate KCQ ownership to scheduler pipe before suspend_all.
+	 * This keeps firmware restore path consistent without changing steady-state
+	 * legacy queue map/unmap semantics.
+	 */
+	if (adev->mes.enable_legacy_queue_map &&
+	    migrate_kcq_to_sched_pipe) {
+		r = amdgpu_mes_migrate_kcq_to_sched_pipe(adev);
+		if (r)
+			return r;
+		adev->mes.kcq_migrated_to_sched_pipe = true;
+	}
+
 	memset(&input, 0x0, sizeof(struct mes_suspend_gang_input));
 	input.suspend_all_gangs = 1;
 
@@ -299,9 +592,18 @@ int amdgpu_mes_suspend(struct amdgpu_device *adev)
 	amdgpu_mes_lock(&adev->mes);
 	r = adev->mes.funcs->suspend_gang(&adev->mes, &input);
 	amdgpu_mes_unlock(&adev->mes);
-	if (r)
+	if (r) {
 		dev_err(adev->dev, "failed to suspend all gangs");
 
+		if (adev->mes.kcq_migrated_to_sched_pipe) {
+			if (amdgpu_mes_restore_kcq_pipe_ownership(adev))
+				dev_err(adev->dev,
+					"failed to restore KCQ ownership after suspend failure\n");
+			else
+				adev->mes.kcq_migrated_to_sched_pipe = false;
+		}
+	}
+
 	return r;
 }
 
@@ -326,6 +628,15 @@ int amdgpu_mes_resume(struct amdgpu_device *adev)
 	if (r)
 		dev_err(adev->dev, "failed to resume all gangs");
 
+	if (!r && adev->mes.kcq_migrated_to_sched_pipe) {
+		r = amdgpu_mes_restore_kcq_pipe_ownership(adev);
+		if (r)
+			dev_err(adev->dev,
+				"failed to restore KCQ ownership after resume\n");
+		else
+			adev->mes.kcq_migrated_to_sched_pipe = false;
+	}
+
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index f80e3aca9c78..fa8ef0ed63db 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -85,6 +85,11 @@ struct amdgpu_mes {
 	uint32_t			kiq_version;
 	uint32_t			fw_version[AMDGPU_MAX_MES_PIPES];
 	bool                            enable_legacy_queue_map;
+	bool                            kcq_migrated_to_sched_pipe;
+	u32                             kcq_sched_migration_queue_id[AMDGPU_MAX_COMPUTE_RINGS * AMDGPU_MAX_GC_INSTANCES];
+	u32                             kcq_migration_orig_pipe[AMDGPU_MAX_COMPUTE_RINGS * AMDGPU_MAX_GC_INSTANCES];
+	u32                             kcq_migration_orig_queue[AMDGPU_MAX_COMPUTE_RINGS * AMDGPU_MAX_GC_INSTANCES];
+	bool                            kcq_sched_migration_valid[AMDGPU_MAX_COMPUTE_RINGS * AMDGPU_MAX_GC_INSTANCES];
 
 	uint32_t                        total_max_queue;
 	uint32_t                        max_doorbell_slices;
@@ -429,7 +434,7 @@ int amdgpu_mes_init_microcode(struct amdgpu_device *adev, int pipe);
 int amdgpu_mes_init(struct amdgpu_device *adev);
 void amdgpu_mes_fini(struct amdgpu_device *adev);
 
-int amdgpu_mes_suspend(struct amdgpu_device *adev);
+int amdgpu_mes_suspend(struct amdgpu_device *adev, bool migrate_kcq_to_sched_pipe);
 int amdgpu_mes_resume(struct amdgpu_device *adev);
 
 int amdgpu_mes_map_legacy_queue(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
index 0e9089544769..177a78d9aa68 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
@@ -1899,7 +1899,7 @@ static int mes_v12_1_suspend(struct amdgpu_ip_block *ip_block)
 {
 	int r;
 
-	r = amdgpu_mes_suspend(ip_block->adev);
+	r = amdgpu_mes_suspend(ip_block->adev, false);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 18bc5ba25f8f..e5167cbb77f8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -367,7 +367,7 @@ static int suspend_all_queues_mes(struct device_queue_manager *dqm)
 	if (!down_read_trylock(&adev->reset_domain->sem))
 		return -EIO;
 
-	r = amdgpu_mes_suspend(adev);
+	r = amdgpu_mes_suspend(adev, false);
 	up_read(&adev->reset_domain->sem);
 
 	if (r) {
-- 
2.49.0

