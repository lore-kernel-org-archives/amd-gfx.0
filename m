Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66B01D73E8A
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jan 2026 20:38:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CB2A10E356;
	Thu, 29 Jan 2026 20:38:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oHBdWiTy";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010035.outbound.protection.outlook.com
 [52.101.193.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB29F10E356
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jan 2026 20:38:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vYXiDrBNwKBq47I6k9CBEcPKqQWP9TKA0Z/MkL5MB6SPrk1iwNWfAZAcqg8FDUVfijmvarzxGufFoY02kVWwi/CIt1fOVLHhcRrY1EoYbJoXCvpwRCoQ3qSDpuwgqa7qZ32avrlVDfJpqJXsdp7/nHu/7D3pkbEKgsPwXKTgcXYiWoc2GLliZQfgVthMFE8kqzdzN9GOQ02CGaA+Yxjaco9msV71JlfLDc3cFkiIv/cWCbAo6r9IDuB2o8NCZUeEU075jntWKDOgBj3LGrcBKJZEmq9ILLTzWcI2NHKoWbDGbUdc7nJT7FOvwlTS3ISGWOUCG0FRNRbP8vgOsdaQGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wYuh1EylUSjOa5MzHI7dMt+6zOnX/sEsidK+rBmsQ+w=;
 b=wT+Vb9O4c57r1TTDV9ob6glK2Ni5NPe1RsHw+C4bY09otbgEM7wwzZOWsVH3K2UFCKLR3nq9UhtbULFE/jsj3VWUFAaCU8ddgMTsKgi/xnWYv1ZuHLmFHIlL6Qa4Kea2z5AP7SfV9iyDxDxL4/LR19ROnZyc97Utp1Aj1R3Eb3hmomT0YYoPJqKKcIJlS+vcKOwnWgetK9ZcXYdBE3KAZPGSjDdMzCktRqbRyuXzmQ1sHXhKPio2MtObcCWQCvB8mmGf84tBiw5+QuqHlEwDrKLzIW580W8RyVnnRcSvGnmkC61F1JbstJdgv7/BZI2jlLumW5XiYxRrgwZPnFjQEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wYuh1EylUSjOa5MzHI7dMt+6zOnX/sEsidK+rBmsQ+w=;
 b=oHBdWiTy2ZaC74ba+LnuCl8ihEWDp237lH0TZTjWVQACeoHGsFjhjqA1cO1Xe2AjNimeJBDUwt+DpLjvi2es6fJZjXeUjYNJGwX6CIXt2RxFKjc/tkV7wRSm+7ZV1380HXokvF+bXUT1R8X8H1qK6ah5+qie0TWg7+DCC4qKCmo=
Received: from DS7PR03CA0324.namprd03.prod.outlook.com (2603:10b6:8:2b::24) by
 MN2PR12MB4286.namprd12.prod.outlook.com (2603:10b6:208:199::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Thu, 29 Jan
 2026 20:37:59 +0000
Received: from CH3PEPF00000014.namprd21.prod.outlook.com
 (2603:10b6:8:2b:cafe::8c) by DS7PR03CA0324.outlook.office365.com
 (2603:10b6:8:2b::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.10 via Frontend Transport; Thu,
 29 Jan 2026 20:37:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000014.mail.protection.outlook.com (10.167.244.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.0 via Frontend Transport; Thu, 29 Jan 2026 20:37:59 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 29 Jan
 2026 14:37:55 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 29 Jan 2026 12:37:55 -0800
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 10/12] drm/amdgpu: reorder IB schedule sequence
Date: Thu, 29 Jan 2026 15:37:29 -0500
Message-ID: <20260129203731.21506-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129203731.21506-1-alexander.deucher@amd.com>
References: <20260129203731.21506-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000014:EE_|MN2PR12MB4286:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fd185ab-65ea-406c-d93f-08de5f764a92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PEHDAkE5zR+pyPMUyzfZ7RUQ5FPV7NqZLHoo4aYWC2TaMSx82D6nfCP0Wfm+?=
 =?us-ascii?Q?nLT3v9Rqotz+4560QocwfHvYFEseGxtpXpSHOI+uEv2Pm/7cNo1F2IYC5X98?=
 =?us-ascii?Q?Lj1OZzMHF6mB8v7EfetKXR405OwdcMpC8u7x7QfAKb1vxLJ2xf1rDJvfjif5?=
 =?us-ascii?Q?ONS2yiNgolB+riAbdfZ488ydbGhrU1fzFZgAhtFwWWSselycW9veYBgZY06P?=
 =?us-ascii?Q?JgdjMXKqbm86A6XVTfDKt/lNebK8hPFkjO97/WJpbk/d2zhk9NyexqZzrXOh?=
 =?us-ascii?Q?Cab+i7t2ELsVyGdTEhYh1ZmbAnUwcbumVwWOrGfOzeeqqjk3Df7TClCk8frp?=
 =?us-ascii?Q?xe93Y0MKZXrDYq/inxVT/FVD+Sbq+xzGcYsCN/ywZJmOzhke+FZPeMePd9WK?=
 =?us-ascii?Q?BBCtGkB9bNgW6JTrF3r+jZfQiKYlzZKOBsmVy0hWUsYXIrjeyAUlYmn983Bb?=
 =?us-ascii?Q?yxuoBi8JO/hcwI/aVUMqVnztgPJIOPKp5qk6Zfm9+BFBbb3EVYN+OPpgN8s8?=
 =?us-ascii?Q?ef5diRsEBZhXVSEeU7krce9yZpxSE/Kam8qTKXpbt38sWG7kJkzk1t0GLMdJ?=
 =?us-ascii?Q?tLOQtIPEnhdNUy5Zo7RHeYlad/vUk2zEV6wKmqqNfSudE59ebSVKmHRnaRsB?=
 =?us-ascii?Q?Q2Kwq3TPCAzV8ctk6OGSPtxxNqGKM1NZRdDLNeGLPob50DZB3TKTKpINzzzZ?=
 =?us-ascii?Q?FVHZJRyYSzE/6mltsbc4rXOiaAoc785HUuANodSaxiSvsPtmuHSNzUKRvemT?=
 =?us-ascii?Q?YRoFg17GgW3PLzdZ2AMJsfHDxna0RUMYnuhbNi+nSZInbxM31V7/9bccLktZ?=
 =?us-ascii?Q?0bS4YOaEZ5WyMeK4H/yqczzIxAPhILwZEDUx4oJ7qS2IW1RqyBEKNlSM/Bex?=
 =?us-ascii?Q?3yd26gDdGYQ0Yywst5vuQyQvSDqxADo9r84zko2VPnr+mpIOREm7gGywmELQ?=
 =?us-ascii?Q?a9GtXO84Pu9hkvFy4XN+aNYQxAq6q0LoT69lKojvFFRaec+oM6jp6SI29YZL?=
 =?us-ascii?Q?dd0sJaGgyh3wbIMS4K1u9a122MkqVsJNXFt9AnCXf7EkxG0tkOMZZR6DoY3S?=
 =?us-ascii?Q?tTUpe63k6pqKqbrX+9p37YLKgrK1aroPUvaDUsX88r9jrT3WFLiB4boUXuOT?=
 =?us-ascii?Q?YbH5i9egr22wBmrReNA7729RV/3G0LNho9ODw1p19221tdCRJxGnx4/UQgQQ?=
 =?us-ascii?Q?st2Vel6zwDgUH9ADPDp2vZB5F82F+XGlbWSTjSvwD/GtY3GtBNvufX0VrSFS?=
 =?us-ascii?Q?UvreIJA3KWVmkiLBs7gi/19ku/izPedF2ujRJyvqyzVKIwLyzTCjkG/U79mE?=
 =?us-ascii?Q?y+Mwb7bgOWwnOjuDU7WAc24LG/KHo2H5j+ELIiAXBjoFPkDWuhv9RWz+FMrw?=
 =?us-ascii?Q?kQhytrFGNUi4EVWYVjMWutE1bbtknUNmdsVA7r6IwejRQgibbx1r8RIuiTAo?=
 =?us-ascii?Q?J9aLVuBv5NEwUBhT0RLdhj7S9w2TaxoBS+dI+FfdTr7zqRM9OG4/2+HTxIa+?=
 =?us-ascii?Q?2ukkNqNaPA4H0r0OkxHqBrKvVxz5hqNTjaxNsvgfmDL96TdQR94McpsU0rbN?=
 =?us-ascii?Q?tYjfYR3cPQjpDPS283TeoH0tj8ofp4z2cEtUTBDFqNX5EANomGbG6J+c51t7?=
 =?us-ascii?Q?fFhaXVQUOEJayfNVpgYWEkEjFiBVnHXBaURnrBNn+0mYfHiBG50q3hD+2HGR?=
 =?us-ascii?Q?4iGVkg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: I49O4zIGgS6kie+ThRHL+y9voyned0W7S9/VuSvZq7BF/maESdPmoFZ5xqyIQ4V/0j2yzkiNNtvulvG0Yn1N4OmAtmJR/eEqus4EejACPaxnQUMk+3FgQ3302dSLu0AM+LI0AGqzAfjDUBGhy1mIvUg/0Zvr1ndJEbMVISIWpObB1TsJk0UwAF/+HdlTSi5l/yU1UoaqZzAU4NigE81cmSmRG064/MrfrBXTCxG0EVdZqGesgWdIfP/kaCkJDiZOVf70FrnjkJWaASNKIv5m5NhpN2SChHuMXkZLzhvCaxgmz264tgcVYBi63fQsUwEum37Vi9FgihRC2w4RwjD5zXpH8z7EtmJAjgeaov0lr/nkskT4FPhLOW3IZZ0+tiiT3+lak72QD3COwWoTUtTltJ2hETVyQmT1mGMkRBhRBDNwD8wGaTb4MIFQJVtni01O
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 20:37:59.4555 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fd185ab-65ea-406c-d93f-08de5f764a92
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000014.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4286
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
index 1f60ccb8782ee..0932a093dee3d 100644
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
 	if (ring->funcs->emit_gfx_shadow && adev->gfx.cp_gfx_shadow)
 		amdgpu_ring_emit_gfx_shadow(ring, job->shadow_va, job->csa_va, job->gds_va,
 					    job->init_shadow, vmid);
@@ -297,6 +297,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	    ring->hw_prio == AMDGPU_GFX_PIPE_PRIO_HIGH)
 		ring->funcs->emit_wave_limit(ring, false);
 
+	amdgpu_ring_ib_end(ring);
 	/* Save the wptr associated with this fence.
 	 * This must be last for resets to work properly
 	 * as we need to save the wptr associated with this
@@ -305,7 +306,6 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
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

