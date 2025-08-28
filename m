Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EB87C8303F
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Aug 2025 09:16:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4CA510E94F;
	Thu, 28 Aug 2025 09:16:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VLi04xPD";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98E6410E94F
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 09:16:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M+ADEaCq41MiIaHH7EcsZEpornOx/B8WWx1FT5G2FvqN2/oTWGV3nS3eWcVbm5rMHnebavrHnotTnf5jj1M7Q0WIqla/AqOLCKP7jhq8/+n43SEpIIMYn+2Er/DKCQaAf1beBZYVK4HDELisxm8IJB/FviXdzvl/EEoQoCblxJAcBNmJFH/t0+onxD3YSz1ARdOoJWiTI6TL34/UaQJp6bq0UgH8cWZSnwqzpNH/EEy2IL5ikOqTXRnFUZ+9dbbHwjgyIp0IVYGTOUPvgi7V/zaqBdC8EMw7DE+9+WaIOGwUdx5BgT0NBPYMMJYjkWk9HXUmbQU6qsYR1xux48IzdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sicIl4xuUwglQoLblALJ+cm2n/YOMY5bV9AnzdyLNzo=;
 b=QC4NpmUo0bE+ws6GLcLHrnDPQOX/xU3hXysHhNlK+gaPhh9seH9QrFxD/fQb0O7k1Vwy6ZFky55boqg7ZwaMv/+iNb65Twsgjm+UBsUfBDvcF/6+sSg4Hy/f8SizOozuWeng4RdFiGO3N+Vqv1Op4oO1PDBNhR3BnnfWDlX7IlEhR9WCgDU5om0gZ8GnQAkMfOTYvuATuYp/86UmzPNC607CcilCV2rX5jfSm4EFqeAObtW0L08XzIN18AuNDDF606KyFh2kh3un8phmTspiawi0rQGw1WVka6KRKN40RDo1MLfPFJKmzoEdScdEeBjO/eqReTawL57VU7EVWKo9xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sicIl4xuUwglQoLblALJ+cm2n/YOMY5bV9AnzdyLNzo=;
 b=VLi04xPDSN0OKugG4gmiOGogOGXWSxtCsucnsblLvIjA1+mJbI5fSCx0D2efEHy++ZS/9N99mfPUAHnFkMyULfVpB3fP/Uzdf8W6q9Dftd9LYcM92datbYFX+1qz+HVFkCW6XmJDR3oC7lDKegRZKKNwcKyvo9L4b6YYGSqW/Eo=
Received: from CH5P221CA0004.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::20)
 by PH7PR12MB6761.namprd12.prod.outlook.com (2603:10b6:510:1ab::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Thu, 28 Aug
 2025 09:16:27 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:1f2:cafe::79) by CH5P221CA0004.outlook.office365.com
 (2603:10b6:610:1f2::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.18 via Frontend Transport; Thu,
 28 Aug 2025 09:16:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Thu, 28 Aug 2025 09:16:27 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Aug
 2025 02:20:53 -0500
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb09.amd.com (10.181.42.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Thu, 28 Aug 2025 00:20:51 -0700
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v3 6/9] drm/amdgpu: Implement TTM handling for MMIO_REMAP
 placement
Date: Thu, 28 Aug 2025 12:43:32 +0530
Message-ID: <20250828071335.3948819-7-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250828071335.3948819-1-srinivasan.shanmugam@amd.com>
References: <20250828071335.3948819-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|PH7PR12MB6761:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d49416b-30b0-4a6d-e992-08dde6139165
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SGxwRktJdVM2Nk0yK21tSXFBOVdEQ1RCT3JsWDFrSk5TNUs5SjdNMm0zQlB3?=
 =?utf-8?B?NnB4SDgwRlU5UGFjYkRZdFQvUU1Zd0w5ZzZoUldVRzhPT2dITEkzRWVZSWRz?=
 =?utf-8?B?R2NDS0lmanN4OEZFTzhvcVl6VXM4L0pDYmtaS3AxMEtKVzF2N0FZVnBjWUlP?=
 =?utf-8?B?MDFaaWZ2VnBKeStEWFZhYllXNThJTDd3ejZncWJRcCt5M21RUzhBTGNTOWNr?=
 =?utf-8?B?M2s3RUcxZHd0MlBva01ZRHVuVkszQzhlVUVhM256THdBRENvWVBiMDkxMzRm?=
 =?utf-8?B?MjFCRis3VmJmUGRhRnZiUVBseFpNUEdacnk0MVVPZ0lWV1NwSlV4NHQ0OWdr?=
 =?utf-8?B?QXRIYlFQaVR3SXUrTnczU25uNDRuN1VQTjhtdFR4NXdYUGtjaHgwRFJNVkFV?=
 =?utf-8?B?YjlaOWZnRGxwK3BZeHhHMloyNk03Y1Y3ekxFTTA2dGs0OE5vR1VBd0wwT2hE?=
 =?utf-8?B?aE91S1A3K09DalFydW92VEM1dzlBcHZnL1R4a09lTW80N0luN1JPNkdYMEZU?=
 =?utf-8?B?cEI3dlcvTzFCL0ZiYVQ4M05meTBZWG1Wbkw3R1FyM2QrMXhxUnk1a0puWVI1?=
 =?utf-8?B?bzJvRU9SQ0lSK2xQMWM5THVUU0s3dEQzUC8xR0FsQVpvMnRLTnlTbFNSUExT?=
 =?utf-8?B?MEFYT3JnNWk5bU9iUEsxRTRVNTUxT2hBV0NPTjhUUVg1OXlxdHpYa2ZMRmVo?=
 =?utf-8?B?Tml2aTc4WVNBWXFxajhnNTB3QzcxWjZ6b3FBand5WEZvOVBlcXhEQUZzNkdw?=
 =?utf-8?B?ZUJlWVRhVTB1MHJKTGhFWWNuNk1jNjVJMVhIcGpVQUdEL0R1c1d0ZGpXWnhJ?=
 =?utf-8?B?RHRpa0NPczVNbG9adEtyUVlOL2p4emlNU29ONmlwNjM5aDNVbjNuUjlNazBP?=
 =?utf-8?B?Yk9RcTlvZGJ1UzlIYWg4aFJVdmwzUnE4aXAwaFR0QjFzL2l0YWQrWTJESWt1?=
 =?utf-8?B?UGRNY1I4bjJ6NDFYRmRwbFFlR1owbER4ejlEdkNYL2JYbnFPTFRvenI5bTJu?=
 =?utf-8?B?TEVDbi9WRllNOUw5citvczFZV3ZPUDhYV0U4cGZnY2tEc01OODlOalhFVnFS?=
 =?utf-8?B?RCtnVkFEOG9JUU92a0hHMm4xTXU2WnltZVRrREVDWktlOEdnRUc2bUJSMXdV?=
 =?utf-8?B?RFVBV29aNFlJVnMwd3djOXU2azhycE9WclY5Y0MxdDdmWmxkdnpRejFxcEdB?=
 =?utf-8?B?Nlp2QXpQZ2wwMGxNN3I3Ly9zNWJuZ3RPaDVxRE1vU2wzQ1FSMXRIcjFkdGZJ?=
 =?utf-8?B?ZlQ1MUZYL2xrWXJCVXVhSFU1SlNySE9Jb1VCS2lETXNhN21uci9Wa1NDNnZY?=
 =?utf-8?B?c3RIUHBPQWVWck1vR2E4bVRXL2FCRFpkMmJkNTJJRTlFcTNwa0d2Rmd2OW1W?=
 =?utf-8?B?SEV2bllPV3NOdnNtcmExSk41V2NmcUVXVDNOZm1RaEMzeTI5cC9ndjJVYkMy?=
 =?utf-8?B?cGg1U1d4ZEV2enlGRnpKWWovNmhyVHJTejQ0ZVgxajVVekdzejd1eTNSNXoy?=
 =?utf-8?B?R2FNSWxRUmg0RnRpeUlWZnA3MGV0dFB6d3hBeU9BWnJVcitCZllraTZQL0Jk?=
 =?utf-8?B?Rm96YjRKdTdKYTU0Q1lOLzQ2N29oM096V0IxOWhnTU9iTFBvbVE3MnVVY3RT?=
 =?utf-8?B?T0YrVUZib3FmcjhKMGNSeXI5NXNUR05BTHZyd1dkdUg5NjAvZnFVTGFBTm9E?=
 =?utf-8?B?TGpiUjFtYzduSXJFSldaQitNRDl4Rm5vcEpoRmQwMC9sQW42cFFvaGNCN2JB?=
 =?utf-8?B?UkY2R2d6dVJxOFNCc0x4RGtBczJSYTcwZHFwcGp0NjkwWlhWTklnSWF6U2hR?=
 =?utf-8?B?UVk3TVIvWjBjMU9sYzVuZEttRU1NVkRZem02aXR3M3NGQ3BpSG5zeUIrMng0?=
 =?utf-8?B?VWloYW5PZFdWOFdzVE9Hb0ZBU2gremNLRytNNUNYRGczMDZGRkJib05MTUEz?=
 =?utf-8?B?eE1qSE9GV2VrM0NNMjZ4YjYybzNXVXo0MWIzaWlEZUw1cWkxSUgyYUpuNkk5?=
 =?utf-8?B?KytLYzYxM1orWVpmT09Kd0czMU0zejU2cVNIM1pud0FMQUVSdUlhZVhBaml5?=
 =?utf-8?Q?Iw2Kro?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 09:16:27.4086 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d49416b-30b0-4a6d-e992-08dde6139165
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6761
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

Implement TTM-level behavior for AMDGPU_PL_MMIO_REMAP so it behaves as a
CPU-visible IO page:

* amdgpu_evict_flags(): mark as unmovable
* amdgpu_res_cpu_visible(): consider CPU-visible
* amdgpu_bo_move(): use null move when src/dst is MMIO_REMAP
* amdgpu_ttm_io_mem_reserve(): program base/is_iomem/caching using
  the device's mmio_remap_* metadata
* amdgpu_ttm_io_mem_pfn(): return PFN for the remapped HDP page
* amdgpu_ttm_tt_pde_flags(): set AMDGPU_PTE_SYSTEM for this mem type

v2:
- Drop HDP-specific comment; keep generic remap (Alex).

v3:
- Fix indentation in amdgpu_res_cpu_visible (Christian).
- Use adev->rmmio_remap.bus_addr for MMIO_REMAP bus/PFN calculations
  (Alex).

Cc: Christian König <christian.koenig@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 27ab4e754b2a..9211d250fcfb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -123,6 +123,7 @@ static void amdgpu_evict_flags(struct ttm_buffer_object *bo,
 	case AMDGPU_PL_GWS:
 	case AMDGPU_PL_OA:
 	case AMDGPU_PL_DOORBELL:
+	case AMDGPU_PL_MMIO_REMAP:
 		placement->num_placement = 0;
 		return;
 
@@ -447,7 +448,8 @@ bool amdgpu_res_cpu_visible(struct amdgpu_device *adev,
 		return false;
 
 	if (res->mem_type == TTM_PL_SYSTEM || res->mem_type == TTM_PL_TT ||
-	    res->mem_type == AMDGPU_PL_PREEMPT || res->mem_type == AMDGPU_PL_DOORBELL)
+	    res->mem_type == AMDGPU_PL_PREEMPT || res->mem_type == AMDGPU_PL_DOORBELL ||
+	    res->mem_type == AMDGPU_PL_MMIO_REMAP)
 		return true;
 
 	if (res->mem_type != TTM_PL_VRAM)
@@ -538,10 +540,12 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
 	    old_mem->mem_type == AMDGPU_PL_GWS ||
 	    old_mem->mem_type == AMDGPU_PL_OA ||
 	    old_mem->mem_type == AMDGPU_PL_DOORBELL ||
+	    old_mem->mem_type == AMDGPU_PL_MMIO_REMAP ||
 	    new_mem->mem_type == AMDGPU_PL_GDS ||
 	    new_mem->mem_type == AMDGPU_PL_GWS ||
 	    new_mem->mem_type == AMDGPU_PL_OA ||
-	    new_mem->mem_type == AMDGPU_PL_DOORBELL) {
+	    new_mem->mem_type == AMDGPU_PL_DOORBELL ||
+	    new_mem->mem_type == AMDGPU_PL_MMIO_REMAP) {
 		/* Nothing to save here */
 		amdgpu_bo_move_notify(bo, evict, new_mem);
 		ttm_bo_move_null(bo, new_mem);
@@ -629,6 +633,12 @@ static int amdgpu_ttm_io_mem_reserve(struct ttm_device *bdev,
 		mem->bus.is_iomem = true;
 		mem->bus.caching = ttm_uncached;
 		break;
+	case AMDGPU_PL_MMIO_REMAP:
+		mem->bus.offset = ((resource_size_t)mem->start << PAGE_SHIFT);
+		mem->bus.offset += (resource_size_t)adev->rmmio_remap.bus_addr;
+		mem->bus.is_iomem = true;
+		mem->bus.caching = ttm_uncached;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -646,6 +656,8 @@ static unsigned long amdgpu_ttm_io_mem_pfn(struct ttm_buffer_object *bo,
 
 	if (bo->resource->mem_type == AMDGPU_PL_DOORBELL)
 		return ((uint64_t)(adev->doorbell.base + cursor.start)) >> PAGE_SHIFT;
+	else if (bo->resource->mem_type == AMDGPU_PL_MMIO_REMAP)
+		return ((uint64_t)(adev->rmmio_remap.bus_addr + cursor.start)) >> PAGE_SHIFT;
 
 	return (adev->gmc.aper_base + cursor.start) >> PAGE_SHIFT;
 }
@@ -1355,7 +1367,7 @@ uint64_t amdgpu_ttm_tt_pde_flags(struct ttm_tt *ttm, struct ttm_resource *mem)
 
 	if (mem && (mem->mem_type == TTM_PL_TT ||
 		    mem->mem_type == AMDGPU_PL_DOORBELL ||
-		    mem->mem_type == AMDGPU_PL_PREEMPT)) {
+		    mem->mem_type == AMDGPU_PL_PREEMPT || mem->mem_type == AMDGPU_PL_MMIO_REMAP)) {
 		flags |= AMDGPU_PTE_SYSTEM;
 
 		if (ttm->caching == ttm_cached)
-- 
2.34.1

