Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 571F8D77881
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jan 2026 17:20:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8519E10EB7E;
	Fri, 23 Jan 2026 17:20:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZwDFFMah";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011012.outbound.protection.outlook.com
 [40.93.194.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8339110EB75
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jan 2026 17:20:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R8V8AoYqzDmKDRV+DEX3iFI6M6pDNAY3SDDmfnusspY9kWQ60hPs/fwtU901SNU46l6Vv9Srf56szeDIP/3fpPN0tnLdvJNRHgsBq7tC5fR5eBAlkMTgrjs/O58nYosRaa3on/eTdWwDJjjUxUKSoy5uA8zZIpikJ6plBwOiBE8Q8RG0vLvVPxZe+n065kxQLvTQFSdCGeIX1aPlS1G5U66cFWDCPO7POTH4OPs3hVFjV594ObmZH/8NPM1HvlsR2z80/6RuU66Dc52w+LfUCo6gLDYirlnvULjFP03zJWBo8BMkrVvS4QRIzxjm0hapaMkkA0v0QxEViIGgDUUJUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pDnO70A4JR04nDXZ4Sc1HaX/+URkSRguUVeg+TrRXWg=;
 b=Y7DMAf2xWv2S99sQLBgLYiHEAi4PwZEKpHjuMo1IvsjdltSBDsgS+RM1fX3YrhIOfE5WSarG6uy1TeHQUn4QglUMWcJFV35dDbcoSTzoPSRs3Zq+0iGCe3o3HSHSCRLFfLcEgylprpUhACsOH8ZHgMAfxJL10XI/D99rVH7+xXouLI1Cmj9PytFHtRxKawxKYB5SWKiRQer/BItdVU1nZI7QlJsd3Jx80ECkT3ik8SHcSSBgqeUqjvP0E+WIgGYQIMgaoqdakne//ZztJuoFH9F/AY2JtsAAgVQY7//T8HLLG7ziyauSU5hviqDDcuQCzON9T56oT+gPpHXgzppKrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pDnO70A4JR04nDXZ4Sc1HaX/+URkSRguUVeg+TrRXWg=;
 b=ZwDFFMah5D9hCCawFVUjpOW9VHFSxJFTOhK02G1THBNoQ32aNYSdJzzr7mvP3kqyzquSEFN+fRyak2KM7ys5SUyQ+sm8iBz0TUWvE+NGKHgOJgNdIgCh5GmM8I74U20Gv2AZ6LvJRacWp9mtDjcC/Zo6n8MLTH6Fqkw2TR2LTnI=
Received: from BL1PR13CA0320.namprd13.prod.outlook.com (2603:10b6:208:2c1::25)
 by DS0PR12MB8441.namprd12.prod.outlook.com (2603:10b6:8:123::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 17:19:55 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:208:2c1:cafe::1f) by BL1PR13CA0320.outlook.office365.com
 (2603:10b6:208:2c1::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3 via Frontend Transport; Fri,
 23 Jan 2026 17:19:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 23 Jan 2026 17:19:54 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 23 Jan
 2026 11:19:50 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 23 Jan
 2026 09:19:50 -0800
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 23 Jan 2026 11:19:49 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 10/11] drm/amdgpu: reorder IB schedule sequence
Date: Fri, 23 Jan 2026 12:19:36 -0500
Message-ID: <20260123171938.16814-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260123171938.16814-1-alexander.deucher@amd.com>
References: <20260123171938.16814-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|DS0PR12MB8441:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f2cc038-af7e-4948-f329-08de5aa3a053
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aPopRUB3dkpFqTKkGZVlAVnETD9/Gx4YqlWnHL8wkrMfc6HX95eP+ROdkpTS?=
 =?us-ascii?Q?2jV1oukn/c9dJZC00S4jWoLhQDxgIn3ZbBnSqiFif2aBpzzwDHGejY7+483E?=
 =?us-ascii?Q?/l63SPB0RlXItSTnsTImbIxXeMcNXa5cdQAhtK8hpQ20/5wzT1EotTDdw4LU?=
 =?us-ascii?Q?YI0lQbT1Xf0g9qj6srbzDOU2naOsNzhHM+xGvs6QtVhor0E5OP12xi1AthQU?=
 =?us-ascii?Q?zOKtm57ZtmOxFh5Ty4uLe2YP2dh0fJll5CUgoK+jzeasY7c31NALWMl+yLLY?=
 =?us-ascii?Q?fCnEqM3cXnGlklzFFqvemLsBiEmAlxFwzuyBU3xjMzSXy9NnMZpxVsssEWu+?=
 =?us-ascii?Q?uj8gZDcARQQxKm/z7tFeKT70IUuhIeeO/iSBpUJQkDP/fOoY2GHBIAkgdZSG?=
 =?us-ascii?Q?7x2jga3qTBBavKgTe2Jw1iBBMIn1KJyVZ+J4Xj347ARKAI+qxMPvZJatx7GQ?=
 =?us-ascii?Q?TrIhtx+ogwqUTrqYVZaQ/tDb4ywNV39UF+A5Vr249CHfImEDzugifQb4qN3w?=
 =?us-ascii?Q?4HJZO1SfazYSIibXMADK2DotlBQlvK4+4Wm5ede0bqd0aPaq6Q3H6HW77TXO?=
 =?us-ascii?Q?H3/4k2gpi49ptND8rT+z/y/J9sj69D1HPr5nUBO7gV3MB6K5yM8kcmT/7rrx?=
 =?us-ascii?Q?eiDQPUQUCjmKiKgtdhUXFCpHC5g6ddoX7cEAbUTwTfwWmncu61MBo0ZERw/g?=
 =?us-ascii?Q?NsXnNeGEiIL/1tcvIKp2GHCOWCiT0k8FdrMNWDCHvpmX7VnOO7bCRDzv4V7B?=
 =?us-ascii?Q?G/CgaM3p+x5V9625WuCOvivR2MWJHQCxIqNYHjHyMh07J+RUO0r2omEflhVj?=
 =?us-ascii?Q?KlbAewyBseGLmJ+y53ODRVJYahLEAsVLfHpm4q0TLEPvnLFTKgXmcn77SN70?=
 =?us-ascii?Q?aPA2OBbdCq2I53ZX4/qR8lgESVjLO6EneluBG6WhVhGKBYklhUW9oraww653?=
 =?us-ascii?Q?j+SR3AyfXHRUeMpwmpiedzgncopTPaONRvA5kKZFIMDIVZxWFxe7RuyObEaq?=
 =?us-ascii?Q?d/XK13p919UB417YDy0KdCBd9GC96A3f0MRtNvPimAprS+rlR54l4FoiL7EQ?=
 =?us-ascii?Q?zQ6cuKG1KVSwmxgAjESp+E2/NCMSyit91sCzQgNU/d+h3bpB4fzQLB3Dh9GQ?=
 =?us-ascii?Q?/ULPEILek7RMHwxDWG6ybm9/0bqpdjmu3YDVERybaTjCN1gZ7H/zt/NeYDAp?=
 =?us-ascii?Q?MPxV0CLqvWL0sDgEVghNX9U6xEqNGUj9LlLtwGFjZO+FBt2VOpoaGcSQzX1f?=
 =?us-ascii?Q?AFILIQlLwLk//m6rtsR775ESlhD4G43UfgFVer1Hs5wlmRnTnIqH9NBsrMge?=
 =?us-ascii?Q?WCRvWSkWTfIyN9QMz/byJ9lgNWrqbL2l5DQQ0BbY/R/n/UeBJm5Ho+nSOhJ4?=
 =?us-ascii?Q?uSJpj4qDJcMQsG/g6WiT6osuJf09+TnWDnoPonZPbD5rx4+mvffCvP0RWqyq?=
 =?us-ascii?Q?TgLFjQwgBEyeLhzmL4FUz1gs55LS3Td8csi4igtrPaGZotu3vcMKx740oeMw?=
 =?us-ascii?Q?UUb9ds2HO629EqIffqo+ho5iKxXnd19kX728ZwhKlQEdaq8dVIi2KWd24s7h?=
 =?us-ascii?Q?D9OeI//Kk9NDabo07PWVTgtD1wuhpMzahgdilV4TvAoH8OsSm/YQNVBbrgJs?=
 =?us-ascii?Q?L+DI8qMNZoFStYlK+ElrvvkOanYWEDjj3QJWCOsCv7IXfWGQliiiI+Ctb1tt?=
 =?us-ascii?Q?USdHPA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 17:19:54.8785 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f2cc038-af7e-4948-f329-08de5aa3a053
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8441
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

This reorders the IB schedule sequence to cleanly
separate the vm operation from the IB submission.
This makes the two independent so we can cleanly
associate each one with its respective fence.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 22 +++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c |  7 +++++++
 2 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 78987ecdfe03a..fc02756673860 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -192,16 +192,6 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		dma_fence_put(tmp);
 	}
 
-	if ((ib->flags & AMDGPU_IB_FLAG_EMIT_MEM_SYNC) && ring->funcs->emit_mem_sync)
-		ring->funcs->emit_mem_sync(ring);
-
-	if (ring->funcs->emit_wave_limit &&
-	    ring->hw_prio == AMDGPU_GFX_PIPE_PRIO_HIGH)
-		ring->funcs->emit_wave_limit(ring, true);
-
-	if (ring->funcs->insert_start)
-		ring->funcs->insert_start(ring);
-
 	r = amdgpu_vm_flush(ring, job, need_pipe_sync);
 	if (r) {
 		amdgpu_ring_undo(ring);
@@ -210,6 +200,16 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
 
 	amdgpu_ring_ib_begin(ring);
 
+	if (ring->funcs->insert_start)
+		ring->funcs->insert_start(ring);
+
+	if ((ib->flags & AMDGPU_IB_FLAG_EMIT_MEM_SYNC) && ring->funcs->emit_mem_sync)
+		ring->funcs->emit_mem_sync(ring);
+
+	if (ring->funcs->emit_wave_limit &&
+	    ring->hw_prio == AMDGPU_GFX_PIPE_PRIO_HIGH)
+		ring->funcs->emit_wave_limit(ring, true);
+
 	if (ring->funcs->emit_gfx_shadow)
 		amdgpu_ring_emit_gfx_shadow(ring, job->shadow_va, job->csa_va, job->gds_va,
 					    job->init_shadow, vmid);
@@ -296,6 +296,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	    ring->hw_prio == AMDGPU_GFX_PIPE_PRIO_HIGH)
 		ring->funcs->emit_wave_limit(ring, false);
 
+	amdgpu_ring_ib_end(ring);
 	/* Save the wptr associated with this fence.
 	 * This must be last for resets to work properly
 	 * as we need to save the wptr associated with this
@@ -304,7 +305,6 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	 */
 	amdgpu_fence_save_wptr(af);
 
-	amdgpu_ring_ib_end(ring);
 	amdgpu_ring_commit(ring);
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 6a2ea200d90c8..ed0d450b08362 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -815,6 +815,10 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		return 0;
 
 	amdgpu_ring_ib_begin(ring);
+
+	if (ring->funcs->insert_start)
+		ring->funcs->insert_start(ring);
+
 	if (ring->funcs->init_cond_exec)
 		patch = amdgpu_ring_init_cond_exec(ring,
 						   ring->cond_exe_gpu_addr);
@@ -891,6 +895,9 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		amdgpu_ring_emit_switch_buffer(ring);
 	}
 
+	if (ring->funcs->insert_end)
+		ring->funcs->insert_end(ring);
+
 	amdgpu_ring_ib_end(ring);
 	return 0;
 }
-- 
2.52.0

