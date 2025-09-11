Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E699BCAC587
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Sep 2025 14:43:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9067E10EB5A;
	Thu, 11 Sep 2025 14:43:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="asVMeDgd";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2052.outbound.protection.outlook.com [40.107.100.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E81F010EB5A
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Sep 2025 14:43:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CCgM2tRx03NoXq4WoXbLbn6EL8bCI7SajV9Ti02e/g3RUjA9LdQdxSRbAGu6az8Roke8+PyuVlEDc3z90ul3jK2yTwVVQDBFrBlTblw9Xn3H+BPY2qbIBx6niYvV+DQTKaNN+KC4pGKTvjfjLYLBWvLM4KSzZ1cDmftKtc4ZiXjIMK2AaA2LK27zBfr5DniPtgt8dYlUkI3qYPZahgZvtxBzKI0NzrCUMGYYHdAjSpspfc2iajYm3JiNmIPmYDGHD2CQwTAVRqsCpKVYnOupqzInhJBNEMlCd3bz8iem0S1USX3fsYRIKXqR6DyRwVqfw0xQtgqH5UtPlr0Z+Nbfcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=46jpGa+10F6W5AtVTBkULUMDm6EGm/HPUi2+Pbmt6AY=;
 b=JSCHEUBombBCnechi/HSoKAOwaabD+K5nOS3scHWWqu+4Fsu0a3ssVMudYzB8S4vEiYnLrYuJpKIdA62PbcnYzYXPCnwHzXpf9mpC8IsB3e5BYBxL5jqDJviyrqsq8JsS9/YNrCTWoYYIJA8s+ydtgkDeVtVS6vLs+PwUN+FqHYvDQEMiB+BVDgWqBF+MZSFhRvDG5W2bRF7vZfow57D96h2TEAjA3iyd4jqUPNMuQ5eIkkHIHsX7U/r8TUIa7M6PO6CjkldgcXUdEwZPd+W5DLfMFJG20oU9RfEEG6UU25CxM6Hdck1EM4BfMdvvGu4f3fogcvfp3V5EXQptXLP7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=46jpGa+10F6W5AtVTBkULUMDm6EGm/HPUi2+Pbmt6AY=;
 b=asVMeDgdblqEtj73nni0xIjDfT2zh//89wm2Cb4gBblSKpHJazGDf6F9d1EF80Bf2uyf178lprEaUED4Wf19PrhjdiinIiEoZTHbqr+ExIQnl6U3TzKlZXB5ASaKWwON+cAt0w7V+fk0c5+0mCXy46iUvp+Erimxk67gVPIvKdE=
Received: from BL0PR0102CA0021.prod.exchangelabs.com (2603:10b6:207:18::34) by
 LV8PR12MB9181.namprd12.prod.outlook.com (2603:10b6:408:18d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 14:43:19 +0000
Received: from BL6PEPF0001AB52.namprd02.prod.outlook.com
 (2603:10b6:207:18:cafe::6) by BL0PR0102CA0021.outlook.office365.com
 (2603:10b6:207:18::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.17 via Frontend Transport; Thu,
 11 Sep 2025 14:43:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB52.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Thu, 11 Sep 2025 14:43:19 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 11 Sep 2025 07:43:17 -0700
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [RFC PATCH 4/4] drm/amdgpu/dma-buf: Treat MMIO_REMAP as fixed I/O;
 don't move it
Date: Thu, 11 Sep 2025 20:08:15 +0530
Message-ID: <20250911143815.825607-5-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250911143815.825607-1-srinivasan.shanmugam@amd.com>
References: <20250911143815.825607-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB52:EE_|LV8PR12MB9181:EE_
X-MS-Office365-Filtering-Correlation-Id: ae4050fc-20b2-4b49-b197-08ddf1418ce2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SUFYRU5Dcy9TNXZPWDd1ekw2dURFUC9DSFc1WFpsOTlSUzA4eWlDSWc4VGcz?=
 =?utf-8?B?VjdvRzA4WGFzNGJRZnhUQ001QU1tNWV6TTJhcjFUalhmaTFkTUdhaVlnNWtM?=
 =?utf-8?B?Q1ZzUjcwb0RUeXd0VXNMSmtFb3h2aVZzeFREZHlTREJjQzRFaGthY1ltNjBS?=
 =?utf-8?B?dzNmd3pwZHRia0o5RmpwOVVnZGo1cG9jUng0bVloTWRFVU9kUWxTMS9JcDZu?=
 =?utf-8?B?SVdtNDNEd3U0MTJHSXhPekZYV2c2S25ueGZJVUhlZ3V1bysrYW4vd3dENUJk?=
 =?utf-8?B?VU9aNkgycm5GN1dMSlg1dlJlS1dMb1ZGS3c0enNmbTdNUXhQNUlIM0N2VFZ6?=
 =?utf-8?B?a3FoMWNxVFBDZTU5MEVTMjVHbUNNWmd5bk1BajQwblJkTmViWURaR0pqbHN3?=
 =?utf-8?B?aTFBSXNTbURJU3ErVUQ0cFliUUIzMXRTcUdEU1RlN2xiaWszQ2JTUENxMGZk?=
 =?utf-8?B?ekx1ckFOd01nekRYdkhtcU9Db3MwMkN1SUxhK2xLWC9hVU1YQmEvWkcrN1Jl?=
 =?utf-8?B?Vm5ac1duNGxOblQrK1lac0NvVHNsdFN1cXRQbWVITUY4a2grY205UUkzdjYz?=
 =?utf-8?B?UDNCZGptaFJFQzJyano2SmtVOVZhL2hJT2F1a3N2eVIwVk54Zk5xeDNseVdl?=
 =?utf-8?B?OHF0YXB0YkVXc3ZYNFMvcTNtclh1UlBuRU9ubGR3RS9mcUlrK20yOHdjS3JH?=
 =?utf-8?B?SHMrK0JoQ3JJM0Rka2RrUldoOFpibXZobEt4WFJnUGRwUEN5UjJuYjBhNTNI?=
 =?utf-8?B?akdjNUsxZEgydVR0Yms0Z3JFd2xJUk5tUm13ajhLTXNidTBQa1lKajg0Nk1p?=
 =?utf-8?B?dWk2RVo2bXJZbS9vUlJPWEljaXZ0RkdTTTRIZCswYWdwRnYwV2hUZU91bC9u?=
 =?utf-8?B?bHlMcncySWhOTTJCTEdNOXYwTEpqRlpkMXYxMkxNcTFRUGk0TEVpV3c5Nnda?=
 =?utf-8?B?NGwwN29mZ0k5U2ZtOUVkTkVzM0xidzNGOW9aK3JaMTNOUVZTVHphZEcxMDZ5?=
 =?utf-8?B?NDNiNVNySUczQnVWY3Q5MG90M2E5bkR5aTRLUUNCczJ4N2hUN21tQWhJUjUx?=
 =?utf-8?B?TllTL1pKRVJTSUx6Z3UyUTNzOGxEd2NGdU5GdDFZb2VKY3lTSjBlemxhTm1z?=
 =?utf-8?B?OVBIdHBQUzNJYzc5TjAydHlwVG5QbE9NbEtaUENyYzNuaFVORW1Wam9rT3R1?=
 =?utf-8?B?SUpkMlZSK1dVdDZneW04TmZ4LzU1ZFUwd2o2MlNuVkZsY2Y4RGU4WUJnT2du?=
 =?utf-8?B?TU1maktwUWZyZEZ6R0pmSnB4L0hxVnJLMGxwbXh5V2k0bWxPdDZJUktMUWVn?=
 =?utf-8?B?cXFEcGlrbDBWaUxwdTRqRnREOElpTnBYZm5LV0VtSEozd0EvSFJsSk5LWC9o?=
 =?utf-8?B?OWlmQ3RuOWRueE52OWw5U0pJY3BWQjdjYldka0ZhWUEvTHhuOTN3bmlhVEpP?=
 =?utf-8?B?czh4Q0E2ZHpWMGFPN0EyTTE1Nm1FaHJLV2FNWTB6dG1zcEIwRXBKcE1sTXF2?=
 =?utf-8?B?TU1tcFlRS2tpaDhjU2lBTEFSK2RlcHlibWVGNmcvd1NBTnlPc25XTVlSUEZI?=
 =?utf-8?B?cEpqVnJ6Wjh4WXpkUEEzci82R0ZPVVpZZUpUdmJvRldMZXVZc2dZZ2tIYXY1?=
 =?utf-8?B?VFVoYURsRG9laElkejVTOFVYdmtCMkFkKzBLRXRyRnhsN2N6UFZNTFFieE5s?=
 =?utf-8?B?UUxTaDM1U3U4OHY2anhIMkYrZEVtUm9lbTQ2dUpUMGh3S2l4YlhGMUcrQUZP?=
 =?utf-8?B?dTdjaE9keGg5eHltVkZQQ3AvdG90R2NvM2F0amZSMkg0VkVndzcvTmhxZnFO?=
 =?utf-8?B?TEdDM240ZFM1eGtoSGdpU3BLQndRQWVlQ1V0TmZsZjlZNkcxSGJqYjNmakp4?=
 =?utf-8?B?N3RuaGlmWGlTOU5WMjBFeVQyMlEwMDlWWWtaYWZnZGNzV3ZiWlA5Rk90ME5T?=
 =?utf-8?B?eVFoeDJSTlg4VzBBbzNlTnpNYXEvVkxSTlhZMkhmeWM0MWFNY1I5ZWxHZEdY?=
 =?utf-8?B?RGlRT2lNNTBFZGVpT2pCWkVYZjM0Z0llUjdOa0RFck1IOGtab09yY2lSbzlw?=
 =?utf-8?Q?idW0Ye?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 14:43:19.4884 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae4050fc-20b2-4b49-b197-08ddf1418ce2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB52.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9181
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

The HDP flush page (AMDGPU_PL_MMIO_REMAP) is an MMIO window, not RAM.
It must not be migrated to GTT/VRAM by dma-buf paths.

This change makes pin/unpin no-ops for MMIO_REMAP and skips CPU-access
migration, keeping the object fixed.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index 31d78561ab95..4c75e296b57f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -109,6 +109,11 @@ static int amdgpu_dma_buf_pin(struct dma_buf_attachment *attach)
 	struct amdgpu_bo *bo = gem_to_amdgpu_bo(dmabuf->priv);
 	u32 domains = bo->allowed_domains;
 
+	/* Already pinned at export; don't try to move I/O apertures */
+	if (bo->tbo.resource &&
+	    bo->tbo.resource->mem_type == AMDGPU_PL_MMIO_REMAP)
+		return 0;
+
 	dma_resv_assert_held(dmabuf->resv);
 
 	/* Try pinning into VRAM to allow P2P with RDMA NICs without ODP
@@ -148,6 +153,10 @@ static void amdgpu_dma_buf_unpin(struct dma_buf_attachment *attach)
 	struct drm_gem_object *obj = attach->dmabuf->priv;
 	struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
 
+	if (bo->tbo.resource &&
+	    bo->tbo.resource->mem_type == AMDGPU_PL_MMIO_REMAP)
+		return;
+
 	amdgpu_bo_unpin(bo);
 }
 
@@ -354,6 +363,11 @@ static int amdgpu_dma_buf_begin_cpu_access(struct dma_buf *dma_buf,
 	bool reads = (direction == DMA_BIDIRECTIONAL ||
 		      direction == DMA_FROM_DEVICE);
 
+	/* Never migrate MMIO_REMAP for CPU access heuristics */
+	if (bo->tbo.resource &&
+	    bo->tbo.resource->mem_type == AMDGPU_PL_MMIO_REMAP)
+		return 0;
+
 	if (!reads || !(domain & AMDGPU_GEM_DOMAIN_GTT))
 		return 0;
 
-- 
2.34.1

