Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9381FE6BF31
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jan 2026 17:31:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FDDC10EA30;
	Fri, 30 Jan 2026 17:31:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L2d9wyn3";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010012.outbound.protection.outlook.com [52.101.85.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DFDF10EA33
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 17:31:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rrbJqO10NbW3V5VGLam2VGIIyxe3eFyyJaDTkXahbtUGeRDj5YL/mqkDmPHabF9UkmLCMKmGLn0h4H9e52eiDgSeO/2HQeiifnhZc0qBkV7UDcAuxXQNA/D1zy7Qp93H0wiCnurQsrWUlsAxG36nf2TRwKxLj4uhCeL7TE7AEgoDo53oMBtGq82/CyGVlPfchIBjEijMnW1ucDte3ZlbZf6RbybCk8pUuCPxDRDiIOP44VXQkcjO/ajd2QVYc4mBqPzZ8y5tBFBnNMq1ghXPMdfvvlVQcKAM7T8mN9Rq4/qBLhRLdjpOnV6LhREk3VpzdxrSQJPbf0xftH4bwN3ENw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wYuh1EylUSjOa5MzHI7dMt+6zOnX/sEsidK+rBmsQ+w=;
 b=WOMI+HDc4trYTioRueuND0H2Ukc4DuTSk8UjvYAA9mIR/0T6tIZ5NQ1bEuOSLgeNpaz+kmn4N85PtLuPTG/Spc3vCkI6slPXpFKMcmvS6OXjq8O/+H264nKpnbC3ZSELColK6mZnkODKUejWKlp6eiCdq3ws17Ve7Rnk697cl2vbY9c6stVH3bbheHszFbnBnoxTB5iUtn76cEI9TSIi93gCHGgn7QGpB5+/S9G625t8nPNw8n7tOwFHflBRf8tSj2c9VPShIcjPG65kG8Zbnsh55Klp2BUeHO11p9sfHxj4Zpl/A0VtDJD4MaLgUiH1w67+228n6MlCkZ6YbAPYNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wYuh1EylUSjOa5MzHI7dMt+6zOnX/sEsidK+rBmsQ+w=;
 b=L2d9wyn3M2VTwiV74bf1i5mGJtZupuXXYSlNk6k/BA7bGBZdqyCmsBTxYxXaZUbdWyO7n8iSw1o8+0gToewjhxMOIbEV1k4rP66tce3FNNdHj0GY4D0wscKO5DU3VdCVT4gtjF9XCRjn/3/HQL2aVgpmr+Uqle8ECE5dS2GUwj4=
Received: from SJ0PR05CA0130.namprd05.prod.outlook.com (2603:10b6:a03:33d::15)
 by CYYPR12MB8990.namprd12.prod.outlook.com (2603:10b6:930:ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Fri, 30 Jan
 2026 17:31:12 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:a03:33d:cafe::6) by SJ0PR05CA0130.outlook.office365.com
 (2603:10b6:a03:33d::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.2 via Frontend Transport; Fri,
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
 15.20.9564.3 via Frontend Transport; Fri, 30 Jan 2026 17:31:12 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 30 Jan
 2026 11:31:00 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 30 Jan 2026 09:31:00 -0800
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 10/12] drm/amdgpu: reorder IB schedule sequence
Date: Fri, 30 Jan 2026 12:30:40 -0500
Message-ID: <20260130173042.15008-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130173042.15008-1-alexander.deucher@amd.com>
References: <20260130173042.15008-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|CYYPR12MB8990:EE_
X-MS-Office365-Filtering-Correlation-Id: 09962a79-6e70-4e83-bc2e-08de60255d28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1Ju4M8mQbd7HAzFDzblpWkGUSVqFgFxtpg6uYVt2UPtH73oIemmo8Mu7nahY?=
 =?us-ascii?Q?3XbuVZ9oIF0aacYkwZHTmeZPIBK5/UH0B/W/4xzvUWUTilczDTaNtMbA83r+?=
 =?us-ascii?Q?I8iNluV5N5O4Atj8OUId3YytuQvbAX5nZWWg17ffOxmi4TXraM1f1o2Okudu?=
 =?us-ascii?Q?Rs6Mgz5Kxg6qhnxxouPOP10jiouXCAnVwrh15uJ/nKXmsZjWQ9uISriXOR8+?=
 =?us-ascii?Q?1JSo7NVk9mE6gtrASyCfrGV2h3NBj6FbBSoaHDlPNiZR90d5hKV3i74KZgxu?=
 =?us-ascii?Q?3SpEuXpQvKn5qPEQHU75cQ9XYDGpbOUuG65L6Jcl0VzVIj/BVMeldEDRyy9A?=
 =?us-ascii?Q?vTPreEe88JLokD5nGvbc0eto+qOtBZyBBvCNEJp/xQT4p2vbARMvJQ8s3cmk?=
 =?us-ascii?Q?uJtQsp4AklPWObvYFnPH1VysMbht3hD7+Iy5w8LAD6fu7Q5bKFsOU9gbX6+I?=
 =?us-ascii?Q?ypv06HqLeMX99vwPjDYhsM2aPHqxsy3R5E1bxPahoJmuqFZiVC8LD4USZe5f?=
 =?us-ascii?Q?NC6QPNotvbjun0I6qA4Ayj3B6ESEem5NO7sZaqt6Sgap0FIqEAaG8VoI6uFW?=
 =?us-ascii?Q?gwM2Sb/gyuG9naUw/J4MJdY9niPHFiJkMDl34CkUDpHB8vTk2gKzZeqp7wSe?=
 =?us-ascii?Q?YGB5NVtXxmNsuH7oHwEOYyYMLYSYB3227GJZO9neWXbryworMTomE5X7qZwb?=
 =?us-ascii?Q?dlc55bz7dGuDzyT/aFf8b8IejZe3TgnOp24pulN4KnRxHPiXhPpWhF6TsHkQ?=
 =?us-ascii?Q?qJSt1JRCTlsTY5LjISHQOOii0yWOzwWvklgLq3BbWcIhEPavJokOn9TsIEkT?=
 =?us-ascii?Q?iq6+6oaVi24JIZPXnE5nvhR0t0fxe77VBcFHB3Fv79qZV7ZbbhvwHO8koBdY?=
 =?us-ascii?Q?EtQUPLf3mGfy4ORgctmUmGhtD2DSxVoup1HB1H2gvTTizDk/DdWegDJatzdN?=
 =?us-ascii?Q?JK1WLKN0Tn7EnBYrFLoWHSMN2FFbOc1daTkWlPLxlOxVpQqDPNeh47FPuYhl?=
 =?us-ascii?Q?35r5gMEOWzMsgojxUEy13AL5FI3f5yc/RDH5BAY1liQc2y1kX7lBNI0+XpAK?=
 =?us-ascii?Q?b13pKmU+gdFtfhzSa6cP8zZ5iBbr4PyvpNnl74S49/fwqbnj6dv03bglvLM5?=
 =?us-ascii?Q?P0wkkZqbmKcuqFrCHgndL1S87C34vbjsYadhRNP81QxnnwokAIHmFV7oJdn1?=
 =?us-ascii?Q?E390kOxNw41v2kV5N/zjb/F39tEbzBoQrWJ0nqg7VbuuzNCCXguQyxzNCH0L?=
 =?us-ascii?Q?+IVLGeaxEyY+cbGAPSLq+9NY4Xr+wpT0xynpU0APcPeaurpyTUJQdz/TF+NJ?=
 =?us-ascii?Q?MsVLdhYv+B3ozvz4xE1PnH28fGjNfWHRYVLPEdKlAKpB0YLPU+s1drCK0dB2?=
 =?us-ascii?Q?vIz0Its0sLjf+nJotc1EQ+0p6XAW/VoyOynqKNQIBbcKCwcMMMDmCWe16QpB?=
 =?us-ascii?Q?3ABQXi7L59iJUeGRUIqHYsHurqv1EDE9gSAvJWydW3BTbkbcnak/9JJJSpZU?=
 =?us-ascii?Q?QKT6KLX1x1um+eBv7SDJ04blFs3SgQXDkVJkvw/TVGzZOCVokYvELn9ArzXA?=
 =?us-ascii?Q?mlAgBGR0RIPVgct78oS3b4it+T23vX5qa4DqWH/2ILn9NXBM/3xTHu3XG/W2?=
 =?us-ascii?Q?Yos7GBkVb/IxvrjQXwrJUCPx/6lXdBIHwhNhj8Bf/aqo9UHsgVRvEsLvv5nu?=
 =?us-ascii?Q?RZYQuw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6c78A6/XuAG0TVuSsmSVyV0yUrvTr67Kd6B9i14XnuSZj42EVPvmlXvBVzhckEiodYewwmpZczl0/XNrwxlmDvNdcvolz21bOzq65wZ3B8D5moLwq0j1GFq1F3l94jdOnbAjmuSIdw06quRnStZO2HVp+cnUeKr1FO0Yvn67MmQzMSr4sQ1p5dOgQWMcOSiEdEwlKad87oSQJ4dSEwrMSESiaBKR01g+I3nBScrrw/RGvDDO0gkC3Ik5ZA5nF8eYxxCZT1LP1r7n/1YOqDfbprKRPmQDgTlhQIDM6w6lRVzIlNi5BwXGSkycUPVPfeVAj0CtBcwc6MPVccMbQg/o2PllUpfzyZU+q8X6uv4EYskLW3wdFSKy6meV27rkVgJjxfi2uQueM8MvrnxxoGEYh20OYsR7MTvQNZBOKCmxc1XpFyG6SzlAUReidtpRmTpS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 17:31:12.4864 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09962a79-6e70-4e83-bc2e-08de60255d28
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8990
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

