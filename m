Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2997CAC592
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Sep 2025 21:33:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CCA610E1E4;
	Mon, 22 Sep 2025 21:33:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZNQnGDPd";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011043.outbound.protection.outlook.com
 [40.93.194.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E86A310E06A
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Sep 2025 21:33:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i1wGg5aDhHXM/cDX5mzkkk+EUG1Yzrr2rTks6q6pI1XtTzEbcm3bIZ0LuqauItsMINhb1DojwQtffh6PchXpVoC33KB18Tmb0AbatqxG6D/59FheVpv5IZ3aXLN8mBaN70DpcH3MjbvP7NPmv+9VBnP3pocq1oI4bgu+KknbaFX4QVjq5n+9eJxcwC3DzNpuB7vUKXP8Xu/BjojbgEQ0y6MsPdQc10kNlSF90nt5dGHkF6HdJHmRJkBYS7rsCV+yAvSuf3IV2+i5uS3A9uNQdl++Nlu2CIgR8Aj4M0xQavry45ZDG20c5v9wrhdQocL+wGuxR6fzAFK5DNUlH3AmWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r0xO2eJkLnacc0cok6Pjxh5tn4piSfBbwjqajGw/u60=;
 b=Uokx2q5+eZCePeOVqjBLuB+WTDrz6WrTYBvnTaJlsKJ04jc9j6ZhO46F/D4ZRk+4aQlwnrXvK33zBkR5S7ibEv+xRmfjEVs94UvrTX5gsBIhJaJxv/aThAaKWZMPPNR7IZWmcaRpovP2lgZejq08LJpkiM6h9DwHoUMXnYA17Ao41g1O6y1l3w12u5R19/JroeYiGlZSmAq1tnXBh17q1GOvGYrgEaEDY9MW9QM5SqCv2a1mwzbVf6ks7TT6i6adG4JrwmTeHJAPZ9ieW6JMS36DXDt6Vg673vI0AAEaNpc4kGmv6WL1BeBHfVysLDGucTxetH9htJd6pcbvtHMdjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0xO2eJkLnacc0cok6Pjxh5tn4piSfBbwjqajGw/u60=;
 b=ZNQnGDPdU/U3X2hy34rSisXSe6gwMds18X+5qcm3oF7hMMaG2lJl55v5FDP+2qPj9dp4cldESEC1ufAEfIzbxUbNEf23xrlYZLtzgK2xM3Sx+MkZYKOj8t8rOD/V5vfQmeOeSpY4LDNSs8uEz3gkfqewxXhpz+CBdnTWw5HAJxE=
Received: from MW3PR06CA0025.namprd06.prod.outlook.com (2603:10b6:303:2a::30)
 by CH2PR12MB4085.namprd12.prod.outlook.com (2603:10b6:610:79::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 21:33:29 +0000
Received: from CO1PEPF000042AB.namprd03.prod.outlook.com
 (2603:10b6:303:2a:cafe::a8) by MW3PR06CA0025.outlook.office365.com
 (2603:10b6:303:2a::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.19 via Frontend Transport; Mon,
 22 Sep 2025 21:33:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000042AB.mail.protection.outlook.com (10.167.243.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 22 Sep 2025 21:33:28 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 22 Sep
 2025 14:33:26 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: set an error on all fences from a bad context
Date: Mon, 22 Sep 2025 17:33:04 -0400
Message-ID: <20250922213305.3661288-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922213305.3661288-1-alexander.deucher@amd.com>
References: <20250922213305.3661288-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AB:EE_|CH2PR12MB4085:EE_
X-MS-Office365-Filtering-Correlation-Id: 92698fb1-3913-48e3-476d-08ddfa1fabe0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AlzmDbER7TUViGRoWgLswqphovnEXih31eNX6Fc4jdbgiraxdxBr+ZOTieN4?=
 =?us-ascii?Q?wOgtM8mSaLwb/2gp7E8N3dIu4qe9g8jd/lAz+k6d54EsMA/IlwG39aRMGsh9?=
 =?us-ascii?Q?y+L4waSHjIPo9NPjEwqAypTSi1PC39JT8T2m1IUrlXMsH2Xi5ccdKR/iARHV?=
 =?us-ascii?Q?aPnNzUhdeP1fefcnAr9qnIKNoe8dcMcuQOJk6arJJ/NEAzunx9L3QFjj78Ps?=
 =?us-ascii?Q?PRBGW+DJsvEEKjzCxxT0UMGB9bAEnVXLGoULvUT52UZCr4FFoOKMdSGyHb+d?=
 =?us-ascii?Q?oJFAdgmiLW0jokeHDw3r+faHj0fOhp0PAL6KB7QULuCUnIdFV0qc+19RCPb/?=
 =?us-ascii?Q?D//daa797COUdU9BKG63K8J3OYp9fsXacI4drFplGSt35HvwnrLm4ESuExU2?=
 =?us-ascii?Q?72NBKJF7WqWPXB+F6USZVXEilOpjEm2r+dvIveg6U4Nxgtwvu+sLuHb7RSOE?=
 =?us-ascii?Q?Dnkdp/FfNyveb5DVffJ4HamBKZhyHShm0JdoupWOeHdyDQfMI6pwcdPTKPG1?=
 =?us-ascii?Q?aOqyXF57auVMu82abGBXqCdX+Mh3W8JmtDzWUGtSUocB2qauZQ7L4F+8d+Bl?=
 =?us-ascii?Q?QZnGooF0YTRmDYQVV6k/7spYccH0FcDnaT2fLg9Zbgovaf2MO/r3SW5kwjcC?=
 =?us-ascii?Q?tmiOziuMi/GC4l/x0Y6V1xm1nqA8pbfV1k3RjOtSlci73GXJA5doRKd8bUHm?=
 =?us-ascii?Q?QPW7iz0YB3jrKVsfifD2eNQ/BJrY8ynAz6STzubtWQHbJbSyRHx0+cd2STD/?=
 =?us-ascii?Q?9GmW5f1a7BNKCCQxIVA4fpDvfThXwmOrNHk4fXMSSldqHsi0NKTNpKgRIZf3?=
 =?us-ascii?Q?xiB52ZDr5qVgM4u7FRML1ieEwsprEEf7Qvuhwa782Yj4PtFtysHTtym3U+CJ?=
 =?us-ascii?Q?GxB8xT7U4UlYjBIlyWNtiVSBvEogBV8lhzr5qFdb+Lfg4d/0lNIkzMlM2EId?=
 =?us-ascii?Q?NSYiDBk5sP3+v0CFe//MK0OUWrwVk92i4OUAIVZKKS925xN8QW0x3FTajl9h?=
 =?us-ascii?Q?WQq+vh1m6+XZDhoJqMLigjYibZ1liR4uGcQj+acGrKgMJ23LDz0xVRgpsqNu?=
 =?us-ascii?Q?JtfQcfKdUN22r8vyKQaNSVwdxYUQdXS/fSXqqRmrYPkC4jCKjrsdA+DGh8kY?=
 =?us-ascii?Q?5d8uXIdxBzwVEGeM4Ax6xK2MZUi1bjtTnN62FWffLSj+rwIMCtPcfCOmx3mR?=
 =?us-ascii?Q?0XE7oAbH6B+Lsbwu5G+1HsTKl0rwvNM4VwNuMWaI8Dp0D1yr2vW6IkxYEFyl?=
 =?us-ascii?Q?PBPaq6Dutif6Nj3BT9jykXlawPQf1kC1u8IGXAPWZxN1FLj/dYD7vLOKesWC?=
 =?us-ascii?Q?XKLFQdygm+zNtcaP4cD6CB/xcOgyAedWOmAH7+TkymBtbd/FNb3CsDdvSLsj?=
 =?us-ascii?Q?m3HuOKgD02mL2utiHekVVpFM5VD0vpqbVfsWKFin251J3ePvpz2Cwjg6NlTj?=
 =?us-ascii?Q?zq5UKh0qQfZ1raLw6WQBMBWLMtBA775mkOgpNDjHMRtzAYVTY6FGnOxrdXVT?=
 =?us-ascii?Q?0KwAvT4aV2AoKUKOwQliqy2ULj/315EHckwl?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 21:33:28.9673 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92698fb1-3913-48e3-476d-08ddfa1fabe0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4085
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

When we backup ring contents to reemit after a queue reset,
we don't backup ring contents from the bad context.  When
we signal the fences, we should set an error on those
fences as well.

v2: misc cleanups
v3: add locking for fence error, fix comment (Christian)
v4: fix wrap around, locking (Christian)

Fixes: 77cc0da39c7c ("drm/amdgpu: track ring state associated with a fence")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 39 ++++++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  |  2 +-
 3 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index e270df30c2790..18a7829122d24 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -758,11 +758,42 @@ void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring)
  * @fence: fence of the ring to signal
  *
  */
-void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *fence)
+void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *af)
 {
-	dma_fence_set_error(&fence->base, -ETIME);
-	amdgpu_fence_write(fence->ring, fence->seq);
-	amdgpu_fence_process(fence->ring);
+	struct dma_fence *unprocessed;
+	struct dma_fence __rcu **ptr;
+	struct amdgpu_fence *fence;
+	struct amdgpu_ring *ring = af->ring;
+	unsigned long flags;
+	u32 seq, last_seq;
+
+	last_seq = amdgpu_fence_read(ring) & ring->fence_drv.num_fences_mask;
+	seq = ring->fence_drv.sync_seq & ring->fence_drv.num_fences_mask;
+
+	/* mark all fences from the guilty context with an error */
+	spin_lock_irqsave(&ring->fence_drv.lock, flags);
+	do {
+		last_seq++;
+		last_seq &= ring->fence_drv.num_fences_mask;
+
+		ptr = &ring->fence_drv.fences[last_seq];
+		rcu_read_lock();
+		unprocessed = rcu_dereference(*ptr);
+
+		if (unprocessed && !dma_fence_is_signaled_locked(unprocessed)) {
+			fence = container_of(unprocessed, struct amdgpu_fence, base);
+
+			if (fence == af)
+				dma_fence_set_error(&fence->base, -ETIME);
+			else if (fence->context == af->context)
+				dma_fence_set_error(&fence->base, -ECANCELED);
+		}
+		rcu_read_unlock();
+	} while (last_seq != seq);
+	spin_unlock_irqrestore(&ring->fence_drv.lock, flags);
+	/* signal the guilty fence */
+	amdgpu_fence_write(ring, af->seq);
+	amdgpu_fence_process(ring);
 }
 
 void amdgpu_fence_save_wptr(struct dma_fence *fence)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 8f6ce948c6841..5ec5c3ff22bb0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -811,7 +811,7 @@ int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 
-	/* signal the fence of the bad job */
+	/* signal the guilty fence and set an error on all fences from the context */
 	if (guilty_fence)
 		amdgpu_fence_driver_guilty_force_completion(guilty_fence);
 	/* Re-emit the non-guilty commands */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index b6b6491797761..4b46e3c26ff39 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -155,7 +155,7 @@ extern const struct drm_sched_backend_ops amdgpu_sched_ops;
 void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring);
 void amdgpu_fence_driver_set_error(struct amdgpu_ring *ring, int error);
 void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring);
-void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *fence);
+void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *af);
 void amdgpu_fence_save_wptr(struct dma_fence *fence);
 
 int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring);
-- 
2.51.0

