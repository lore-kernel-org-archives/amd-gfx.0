Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19648EE49BE
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Sep 2024 15:14:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 951B010E037;
	Wed, 11 Sep 2024 15:14:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4GEMa37q";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AA5C10E037
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Sep 2024 15:14:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aqeFJb+66mbKg6l3g0UVOZlfnLxDq2pAQbTyPqN5n0B1kBm4uQaVm6iMfL/VMbDa9zvi3XBqhLkaI3VWFuiSRfV52FzkeEBt5z7kl0cbrAnugo1fCNv18obKxiUnMVmVQwvgXwbs58H3dp38Xiia/wETRd/dNFLnCSsLNodhGt0AlcOyionvPECQceEi/gONKDq4Yz6qgtuIsKIWbiN22VzXURvSmLtpxJqDWIdEICoXmR6vIBnPOKa1NSSF7oHXEEI1/us4QjD/j52+tkd+6nOimZn4E4hSJumqnUPs1oqqHh9uRRWR10BXfA7zOhG/d8E8mZczpKrL4Fshl/px0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oJgCsqfC3N6J00NuXlE8wpH3ebRoHfbLMn0jsXJOeBs=;
 b=ZmmIWVECj8nAfg2FLCuWaaHEIrpTOVK3dbaUYvph+FXy8pHUD9c0beHJwqYcdRrSJsYdmRuihG3iNxopfbe2IpcvxYxWa/4XB/nYaZcwhlKulmpaDprq93TxmY2NcxOP7J3KZvvE+M1Ts7LUviLx0OpSX1RzZ3eAv0KAlGjHFjv/AAOneAjp2TtFDqIeNKBYOPjt3NXCLbFjjYBDebQDL+byKr64HtbLPMQzSB+KIdcE/5tha8aGag/EyXtSywvR4mMlURJBedJeBrFEVDOQb/PR9PE/Q0wkITzooWHptAF+Ua3oQKJlEys5YkdePMGeyuqpqb+bb5Ff/G5KvsYY7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJgCsqfC3N6J00NuXlE8wpH3ebRoHfbLMn0jsXJOeBs=;
 b=4GEMa37qmz9A2X3rH+AxGRnXXeTuLsTJ8Cy3pkDtxT7aY1uV42EMV6mZR6UB/hSPp8MGel++EjCk0ofuv2WdwgegT2jJ3dkOsrChwCDBHzimsXszHWgfxNUj5cHLlqCIXxq9wrxdlvPGtmOy8upuEPS4oXRGCcQJqrQxc3y2FR4=
Received: from CH2PR14CA0055.namprd14.prod.outlook.com (2603:10b6:610:56::35)
 by SA1PR12MB6871.namprd12.prod.outlook.com (2603:10b6:806:25f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.20; Wed, 11 Sep
 2024 15:14:00 +0000
Received: from CH2PEPF0000013C.namprd02.prod.outlook.com
 (2603:10b6:610:56:cafe::7f) by CH2PR14CA0055.outlook.office365.com
 (2603:10b6:610:56::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Wed, 11 Sep 2024 15:14:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013C.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 11 Sep 2024 15:14:00 +0000
Received: from MKM-L10-YUNXIA9.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Sep
 2024 10:13:59 -0500
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: <Alexander.Deucher@amd.com>, Yunxiang Li <Yunxiang.Li@amd.com>
Subject: [PATCH v3 1/3] drm/amdgpu: stop tracking visible memory stats
Date: Wed, 11 Sep 2024 11:13:27 -0400
Message-ID: <20240911151329.9438-1-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013C:EE_|SA1PR12MB6871:EE_
X-MS-Office365-Filtering-Correlation-Id: cb057d25-e9e1-4af5-efdd-08dcd2745d6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DPnll0Nk8VE4pkL7ldMTzzpblUtbt3NngCSRPKH7FUWGDEd/AfWAKa0PDYCp?=
 =?us-ascii?Q?ERfsW83t8c+oHaTZMRIWzyUzDA5eM1wGUvuMDra7v4ljmw8HM4vVaS13YnPD?=
 =?us-ascii?Q?ARac4e07AE6/8GHium813uFNAhFBzOQ1B0Y7pFZnv4dRAdHXW5mjNYjglUud?=
 =?us-ascii?Q?BKT0UMwgk+aCHMzth1cQdgCS+COZNWySeTxKmTVox+LqKfXwmByBlwT42VB9?=
 =?us-ascii?Q?1rB98/EYrkPBORKGXxl8KD3qUYfYRu4HO/MpxDNp6J6kLCT1FZi03hzGnVfp?=
 =?us-ascii?Q?IbnvFrYf/kiihKQ1uCT+1HQJXN4FCLBoh3AIGz2JsPMCmIhGdPnQugPWEPk1?=
 =?us-ascii?Q?OgeRqoN+sjiqbKylNwBNiIJf255CiSEmoEUpoQFHF/zNP1Um1RzJiR6zsmKT?=
 =?us-ascii?Q?kTzugWpZoLTcIJR+hAp90MA+2T0YUn0x+c3U6U7MKGuyqMfaTQeaZCHoYJ/U?=
 =?us-ascii?Q?DEM0o5b1YFiYuFwixIKM1xwkpkDl9NZyVhyi0CdNqKu0LLFvW5VHlLGj2gHr?=
 =?us-ascii?Q?WP8aZX/GZZpuXyPFpWnJbwz7BMVrNOI9/24GZ+LdUFtprsRPwjC6JHp/EAyY?=
 =?us-ascii?Q?0Nfdk0smWvKoYjDrfvRM4t2PYHiYdkV+qmwSKJgdRl8b9REKN2RI76Yzrkxv?=
 =?us-ascii?Q?Gydb0ZviR2fResA4n9AMcyxBQHmCUDz7QLy1EI0l6SVAIlAvmHvg22w24Rra?=
 =?us-ascii?Q?XSc+GoDulVwpAMQzRhEMXy8x0ebtfWsBboLlWlKaTHAv9TymUM6BMUczRimF?=
 =?us-ascii?Q?LeEfalZ3477HR6CbT5Mmh2+9F5WGbwgDjv31txo850GdeMYCE4RRXUWXdgD5?=
 =?us-ascii?Q?vFQdTxYSsLvKw9WDHHQvkb8M7UWVkUgiGCaQB7s5a4BXvwOT3i0UguEHxQ6i?=
 =?us-ascii?Q?HQ1Dn23iTD8H8k2yFhKb0BOG+EzYyoC9apyqHT48UYfocaI/bIsZagtNFbsl?=
 =?us-ascii?Q?aD7GB3B2k6bin3PZqvCCdUYSKvjDQ9FxWHtsZnR5doMrcXOqodun5dc0/AbJ?=
 =?us-ascii?Q?VirMzmDwDFQChCkO0KQT16vU6ySrsr7U/TpGhm9J83GBR/mMww2TKKlJcyUs?=
 =?us-ascii?Q?UBdjv9LORknICJpN+Wy9d6ZnO0cduzF5N/oHsPO42YCr0FWW5cTqg3l8/Q9C?=
 =?us-ascii?Q?cUOPGJKUaR+yZu/tyPu7TFqh2pysKaAGGcx/rdE47wlsORPDHS194RUcS3+d?=
 =?us-ascii?Q?Yp3EMsGd0eWmK1JHrb4aKUtH3H7vaGRT8Y0kWpgzqgRU3pWyWsEFfFopt1p7?=
 =?us-ascii?Q?6N+NWv8PC4KL7x87HfGsMAs1A1ZN3ioqp1eVxE525BWgIV47EvphQXR4/fio?=
 =?us-ascii?Q?1+c5nAxSKzl9xwQdldU4ED3X8xYYKdVjXuJx6vX8uEXYOg185Lu15vOyvMYp?=
 =?us-ascii?Q?euS5+7lnDNJ9Gw4IlRfqkVFsl/ukU06DPQ8E92I4mXIsgripQE2AsT6wid0e?=
 =?us-ascii?Q?K9tquEkXMTlzmXyHDi/DXi9BEyk3x3LC?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 15:14:00.4511 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb057d25-e9e1-4af5-efdd-08dcd2745d6d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6871
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

Since on modern systems all of vram can be made visible anyways, to
simplify the new implementation, drops tracking how much memory is
visible for now. If this is still needed we can add it back on top of
the new implementation.

Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c |  6 ------
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 11 +----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h | 14 ++++----------
 3 files changed, 5 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
index c7df7fa3459f..9a40ff5c6dd3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
@@ -85,16 +85,10 @@ void amdgpu_show_fdinfo(struct drm_printer *p, struct drm_file *file)
 	drm_printf(p, "drm-memory-vram:\t%llu KiB\n", stats.vram/1024UL);
 	drm_printf(p, "drm-memory-gtt: \t%llu KiB\n", stats.gtt/1024UL);
 	drm_printf(p, "drm-memory-cpu: \t%llu KiB\n", stats.cpu/1024UL);
-	drm_printf(p, "amd-memory-visible-vram:\t%llu KiB\n",
-		   stats.visible_vram/1024UL);
 	drm_printf(p, "amd-evicted-vram:\t%llu KiB\n",
 		   stats.evicted_vram/1024UL);
-	drm_printf(p, "amd-evicted-visible-vram:\t%llu KiB\n",
-		   stats.evicted_visible_vram/1024UL);
 	drm_printf(p, "amd-requested-vram:\t%llu KiB\n",
 		   stats.requested_vram/1024UL);
-	drm_printf(p, "amd-requested-visible-vram:\t%llu KiB\n",
-		   stats.requested_visible_vram/1024UL);
 	drm_printf(p, "amd-requested-gtt:\t%llu KiB\n",
 		   stats.requested_gtt/1024UL);
 	drm_printf(p, "drm-shared-vram:\t%llu KiB\n", stats.vram_shared/1024UL);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 6faeb9e4a572..bcf25c7e85e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1282,7 +1282,6 @@ void amdgpu_bo_move_notify(struct ttm_buffer_object *bo,
 void amdgpu_bo_get_memory(struct amdgpu_bo *bo,
 			  struct amdgpu_mem_stats *stats)
 {
-	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
 	struct ttm_resource *res = bo->tbo.resource;
 	uint64_t size = amdgpu_bo_size(bo);
 	struct drm_gem_object *obj;
@@ -1298,8 +1297,6 @@ void amdgpu_bo_get_memory(struct amdgpu_bo *bo,
 	switch (res->mem_type) {
 	case TTM_PL_VRAM:
 		stats->vram += size;
-		if (amdgpu_res_cpu_visible(adev, res))
-			stats->visible_vram += size;
 		if (shared)
 			stats->vram_shared += size;
 		break;
@@ -1318,14 +1315,8 @@ void amdgpu_bo_get_memory(struct amdgpu_bo *bo,
 
 	if (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM) {
 		stats->requested_vram += size;
-		if (bo->flags & AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED)
-			stats->requested_visible_vram += size;
-
-		if (res->mem_type != TTM_PL_VRAM) {
+		if (res->mem_type != TTM_PL_VRAM)
 			stats->evicted_vram += size;
-			if (bo->flags & AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED)
-				stats->evicted_visible_vram += size;
-		}
 	} else if (bo->preferred_domains & AMDGPU_GEM_DOMAIN_GTT) {
 		stats->requested_gtt += size;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index d7e27957013f..e14b4fbb486e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -142,12 +142,10 @@ struct amdgpu_bo_vm {
 };
 
 struct amdgpu_mem_stats {
-	/* current VRAM usage, includes visible VRAM */
+	/* current VRAM usage */
 	uint64_t vram;
-	/* current shared VRAM usage, includes visible VRAM */
+	/* current shared VRAM usage */
 	uint64_t vram_shared;
-	/* current visible VRAM usage */
-	uint64_t visible_vram;
 	/* current GTT usage */
 	uint64_t gtt;
 	/* current shared GTT usage */
@@ -156,14 +154,10 @@ struct amdgpu_mem_stats {
 	uint64_t cpu;
 	/* current shared system memory usage */
 	uint64_t cpu_shared;
-	/* sum of evicted buffers, includes visible VRAM */
+	/* sum of evicted buffers */
 	uint64_t evicted_vram;
-	/* sum of evicted buffers due to CPU access */
-	uint64_t evicted_visible_vram;
-	/* how much userspace asked for, includes vis.VRAM */
-	uint64_t requested_vram;
 	/* how much userspace asked for */
-	uint64_t requested_visible_vram;
+	uint64_t requested_vram;
 	/* how much userspace asked for */
 	uint64_t requested_gtt;
 };
-- 
2.34.1

