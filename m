Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A356CA0EFA
	for <amd-gfx@archiver.kernel.org>; Sat, 23 Aug 2025 07:20:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 216DC10E1BB;
	Sat, 23 Aug 2025 07:20:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LjGqppTa";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FD3D10E1B8
 for <amd-gfx@lists.freedesktop.org>; Sat, 23 Aug 2025 07:20:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oURGVVZnZPnCKDYp/m1CZZOaawJCOtdmeUIrzQYaduERnok/A+35LjcDm6+7IwXwFKBhIc2RBwZVgMuFK3keamQlIpH/1fWA9/XBYbfLlSBtQCEPP4g8GRm8P3Y+iVZRLJ1rGFfjat9l6c9u7S3HL5ShMSmiSBdmOR8w+MTXJGDNxXISCnRaepzRmjRUjvqU6v+6oxSIdUqR9LYU0cjCP7qI1DjM7Gud0N1n0Er1O9HlzbofKdCHFMgeK5NrKs9mL0E1uCpB4hhiE8FdO3cQA+LMNJWnVxX7XgQNBedepCHx53gyzaFBbntK2CJi6CQ65VC0Lqwk1MKZOS4ny6pmWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tJtSBrChHQHVyL9cc4XY2S006+Ic1tW59Si/g7/iECc=;
 b=c5twu3qp7V9y2aSPTNVnjf14twYNlEqt1gU4S5Auhl/bzVJ3p4ZD6wUUpxMloYvlM25ZL0oDhEZ+R0yNDmmaUu/WQGOZNqYde0GdCTR9B6XGytIqR+P6gwU3UGwxdPQwK60x8X8yPacRGi8ktD3V519Ixf7QFJHNYNAcH9qTJ4tnbrV4a12oZ0d1zATW7/XGqIfpC3TcVVBObYShZ2oXSS27NUZ+t9Vf55xq/4yVqGoci80Jd+IZrhRdUrnuwxIrPUqY+RP1YaszS1SRtA45E6+qfkwYC0psCM8iWj1FmxRWRp1xIfA9/RsX8E/RgNhkghwTbwteuxWfUJxNz2uA0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tJtSBrChHQHVyL9cc4XY2S006+Ic1tW59Si/g7/iECc=;
 b=LjGqppTa75uukZiIFBL9dcAHeMKYrv4IZO8J1yY7KSUV9MNsMf50c9v3sAxm3FiyhWtgWbs8EMSAxS+9flJkSQ7cNRse7nPLyoCGQcsnPnLqsQ23eQ5DFMMBQM6mppOrrCA5zxMGqEgAOZE1fQLZa4Q/uGeMUkE4Yn/Wj80pex8=
Received: from SA1PR04CA0020.namprd04.prod.outlook.com (2603:10b6:806:2ce::29)
 by SJ2PR12MB8881.namprd12.prod.outlook.com (2603:10b6:a03:546::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Sat, 23 Aug
 2025 07:20:43 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:806:2ce:cafe::c4) by SA1PR04CA0020.outlook.office365.com
 (2603:10b6:806:2ce::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.19 via Frontend Transport; Sat,
 23 Aug 2025 07:20:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Sat, 23 Aug 2025 07:20:42 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 23 Aug 2025 02:20:40 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [RFC PATCH v2 5/8] drm/amdgpu: Implement TTM handling for MMIO_REMAP
 placement
Date: Sat, 23 Aug 2025 12:50:13 +0530
Message-ID: <20250823072016.1272328-6-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250823072016.1272328-1-srinivasan.shanmugam@amd.com>
References: <20250820113254.3864753-1-srinivasan.shanmugam@amd.com>
 <20250823072016.1272328-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|SJ2PR12MB8881:EE_
X-MS-Office365-Filtering-Correlation-Id: 3661811a-f896-4b4c-9389-08dde2159206
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UmxtbXEyV202VnBoc2gzYUt3aTRYa09pUkFOOUtpdzMxVk9TZExvelZhR3Bh?=
 =?utf-8?B?d2dyanQvdUU2cDlQeWJobGV4UFExY0oxRTFNYWI1MzVoWE9oVmliL3FKekdx?=
 =?utf-8?B?NTNZamFZQVQ5aWVJSGdxNWJpS2UrenlhTTFBTkZvekFCb0xLOVQ4UUlRZDQ3?=
 =?utf-8?B?ak9QZDYxUDhTWU1RTmFnUThwUDBrOHg4SVBsazVHUmpxNW0wUkgrYmxVSWI1?=
 =?utf-8?B?TWhFNk0zdUFGb2p5YkRHcTVHN09nTGMxWXpRNjBGcnYwQmpOZzZ0R1cyeFQx?=
 =?utf-8?B?MHhSK28yWjVGWVUwdytyblJ6WmpiQTdYa1owRExoMG9YcWNVdGVXdWRqMlpw?=
 =?utf-8?B?K29IRmRieXpQaWJPY1haSk1haHBsbXhRdkU3SXVDaEFJRU92SitZZ0VuTGZZ?=
 =?utf-8?B?a2RIaFovYmNmMGUyRndaUUhUTy93TUFlZkFkMVR4RmhseGtQa1pMTEJaSjZu?=
 =?utf-8?B?cy9CQmRJcjBGNUZSMWdITWZsZ2xsVmREeGtUbEY4a21Mc2pYM3JaRDJDNXBW?=
 =?utf-8?B?cFlvMHVNeHN3VzJVN2grZlFFYzBZS3VpZnJyaUZhbUp1S0ZzM2VXTWtpSmw4?=
 =?utf-8?B?TVBiVWJWZExFY0lnQWx1UUZrc3N1NkdVVmtRdHYyRWl3SWI0YlErUEgvcnpR?=
 =?utf-8?B?eTl6dXJOcldsWUJFNUJJcUVMY3Z6ZXdJM2x3eEdvbG1rR1pjWW9kZ3JjWk5W?=
 =?utf-8?B?Z1NySkQ4dXdkbzdCUHFWbGw3aTRQN3UzRU15REFTMlpZU2tIWmV5bmx2Y1lX?=
 =?utf-8?B?L2Z5TGNGdGxsNHgwakY1TEorY2hWbENWZ01xRERxdUZyWVlzaXpORXJMS3NE?=
 =?utf-8?B?b1pvcnRZK2dCT0F3R3BsenNpUEZRL1lOWURScVRKQzZCcXh6M2RzTWJsSno0?=
 =?utf-8?B?QzBiWkE1RVJkbTNFREthZExwVVpyM242M3dsemFwd2FQbWZqMzg3QXdIOXh3?=
 =?utf-8?B?NUhXQkQ2WTRwU1FXczVqRlRJYm1xa05TekhlYnZPVDNrYnp4L096ZENTUGM0?=
 =?utf-8?B?cG8rV3B6dnBMbkxFdTd3UGxDY1ZlVlBLU2pDVHg3NGc2Q2duSDBXaUVtOGJR?=
 =?utf-8?B?b28wcDRtM2FkWHF6ZDRBclVMTWlGaUFJOEIrVVMrZ2dIdnJrcXRUR2NidzZn?=
 =?utf-8?B?L2Z0VHBqYUJPaFVUeTRwdGVBVkc4SWJXN05mbmZKZzdUTDczNzRKeVpJSFlG?=
 =?utf-8?B?NXAxcVl0MmNRVkJNUzJobzU0bVVSOCt2bk55a2wrbTV6VkY5WlBkOEI5Yzdw?=
 =?utf-8?B?SXdWYzBDNnA1clR6ZGhBTnlaQWNHOGVlZlpqeDRjclVWaXpBRFdYMG9MVXk3?=
 =?utf-8?B?SHJPaTF0bVZadHNtbit6V1VadDdJM2NueUt0dDE4Y0orVGxUREhjVXdLSkxl?=
 =?utf-8?B?WWp1MUlqNDkwd1V1bnBvc2ZxWlF6NmtFRGVKb0M3Y0hGNEtqNlhITzh2WHRX?=
 =?utf-8?B?WFd1UFZjbmpyUmxBWVBFM25pYWg2VWNHc3FQcWNiT01PNVMvSlUzczc2enV6?=
 =?utf-8?B?SUxsUUpJUHhndEZyUnhhc0FvRUwvVXcrRUFncWM5ckJTcmNLUUJ1cHRzZXkw?=
 =?utf-8?B?b25HUy9JL0xVb04yeTlQYUpEeFhjTVRXa3FTcHNzU3lYVUVQYll3MEFwa2dG?=
 =?utf-8?B?ajRLZVgvK1ZWQkdXSTlIZlBIRXdwcDhQaTlyOTNXMHF2SFA2MXBZN2poWVNH?=
 =?utf-8?B?LzdLWFp1bUszczZjLzJPMGlqdkR3WHdNSTExZ2NsMUdiZ2pHS0NBYVZtLytB?=
 =?utf-8?B?NjJOSnpPQXB4eGtCemxWYjZHNDNFbno1dUJ3WWZ2UEpscGVxaThMTVRVRmRY?=
 =?utf-8?B?MW1lclh5Q1NERkQwbGtyOWErMUZSWnd1bm5kSHc4SkUydHBDeUtBL3Y0UDEr?=
 =?utf-8?B?U3lHUHlqanlpclMya0ZwdDNhT094VmFvbHB6OTBQOU1PamtvNGRiUEJHM2h6?=
 =?utf-8?B?VTFhWHVrMXlZUzVGMVFWTHc2NUx1Y3NLVk5BakcwT01uWHFlNHljYXpPYkFw?=
 =?utf-8?B?bkJRbHZSWWU3dWJtVVRpNHF2MFhaK3hPTng1QTM3M3BNZFJldjhuOEV0YjJJ?=
 =?utf-8?Q?8vSuDP?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2025 07:20:42.7901 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3661811a-f896-4b4c-9389-08dde2159206
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8881
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
- Use adev->rmmio_base; remove base+offset math (Alex).

Cc: Christian König <christian.koenig@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 27ab4e754b2a..f6027ccd9196 100644
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
+		res->mem_type == AMDGPU_PL_MMIO_REMAP)
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
+		mem->bus.offset = mem->start << PAGE_SHIFT;
+		mem->bus.offset += adev->rmmio_base;
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
+		return ((uint64_t)(adev->rmmio_base + cursor.start)) >> PAGE_SHIFT;
 
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

