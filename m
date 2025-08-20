Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54B96CA0EE4
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Aug 2025 11:33:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF5A910E700;
	Wed, 20 Aug 2025 11:33:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="A63waVcE";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D9C910E6FD
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Aug 2025 11:33:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ED1pk8qU/+T4MixZTo1N4ZMeKsOTPOHh7DjCvaWNidUljSUZ4/vYNoYNgjLpOFtgVXEv+GbVBnCN6vbbsow5ezEPLKeaS0Jkq3G7aZhScqaeNMvpvpgBOnTR3grDZvQNaDotDJvdaeLDT/9gGJ1YsUC29ZrQwVw2vL/plT/Rdaf1cw3YFKtZwnj65zaviW9YZ9nkHaSUmkTnt2p2e3UVAZtDVp4n0v5mDdJADVXfCTCCjo/O+lhqpewlEuvMhjAb8RNyudQVs7b8WCoqvkAFPgpIWdVDZDd7nzbl4pVUG3diCUheIRczQi3UiLA96/0iJ6C5mQLPwNLPgf+heq0hGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JoMuc7N6wYL8UcRicqPifnxinxn53ozYqiznzQGvzhg=;
 b=aUiM5bOKTwyLbTIc4aCCi5rj2NFapBG1gKDGm8wclEDcs3qmDnxTvtxVFlomcyZ1UR+BBOx24JFdLIs2jO20+lT17+9q0B0m+U9KxcRaIgqEst/qGWY3p4cgFdCqdjXFIEybpZyDYU2MLMfgcYeVcD3u6Xo1cq32qZnDO9Nv8nFmuuckeQ9svbdLwqLincqlpadL6vVznZP7HXf2O3UH7mZtRqEHjIq5STlHbwW5NET8M3y91jnWE7iLllgou66P0DXZanBYoorwQPHCwsSPiNSkKOuc+4E7HVWDEY1DBCYDC3Mi5Q/AzI12/gQssUQUHRMZ1mVKKYMsmxjwwY85nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JoMuc7N6wYL8UcRicqPifnxinxn53ozYqiznzQGvzhg=;
 b=A63waVcEplhnE0GAQ0H5Ia+zXNztkaDeyTf9EgBX+TqN4YkITWF/0JsrgCXS8HU07o7TcQBbbOxegoAQk/zPWzkMA8+ML4ZXh2H/zY3LsQjZk7ZExllmrpw189D4aUDdiAo6003wBwn7GbgOKJ7N9xn5MLWv6L4EXm3oaPAKttQ=
Received: from DM5PR08CA0059.namprd08.prod.outlook.com (2603:10b6:4:60::48) by
 DM4PR12MB6615.namprd12.prod.outlook.com (2603:10b6:8:8d::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.13; Wed, 20 Aug 2025 11:33:32 +0000
Received: from DS3PEPF000099DD.namprd04.prod.outlook.com
 (2603:10b6:4:60:cafe::25) by DM5PR08CA0059.outlook.office365.com
 (2603:10b6:4:60::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Wed,
 20 Aug 2025 11:33:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DD.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 11:33:31 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 20 Aug 2025 06:33:29 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [RFC PATCH 5/7] drm/amdgpu: Implement TTM handling for MMIO_REMAP
 placement
Date: Wed, 20 Aug 2025 17:02:52 +0530
Message-ID: <20250820113254.3864753-6-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250820113254.3864753-1-srinivasan.shanmugam@amd.com>
References: <20250820113254.3864753-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DD:EE_|DM4PR12MB6615:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fc25751-e97b-4398-d884-08dddfdd6455
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WlhVQ01iYUg0Z043WFFvNGpLenJBcmRsZTBsNURkbVoxVWgrbk1Bb0ZQNldq?=
 =?utf-8?B?SzJHZlltMXNocGpqdjhES0pjU0FlUlhtWlRKVGhjS2t1Y0RVS013bVRDQXls?=
 =?utf-8?B?UFk2R3pTYnc2U1VvYXR1OGdIdVp0ak5Ea0pYS1M2NzlxWUl3enBIeDJaSjJZ?=
 =?utf-8?B?cm1GTTI5SlJ4SDF5NlFNNDc5cDB6R1RpRU51T3lWMDg5akovbVBEVFJqT2Uw?=
 =?utf-8?B?Si83SThaU0ljQ21ITG9MOGFEQWovalo0d1lDdXlXN2FOR2RielJoczBPdE55?=
 =?utf-8?B?SW5NZjZPUzhUM3JiMWRhOXVMdks4QS93MjgrRy9NdVlqSUFSTzVBUk4rSWpv?=
 =?utf-8?B?VGszb0J1S2lRMXAxWnI4a25aNDJISHc3Y2RFdmk4WUpQdExuNi9jMmxBeWRK?=
 =?utf-8?B?YXNqR3FPWFduYVpRcHdGSE13M0VKY3RoWWVoWEhycmNzeGVpbzhZNlgzTFNR?=
 =?utf-8?B?R21ZUWhWVFJNaUh5ZmtDVEhNWTBERy9RUUJ6OGN0T0RmdEwwT1N6ejlvNEx1?=
 =?utf-8?B?YnlkdVNVU0taOW4yNzRZbFhYRUZ4WTNpOUE1Z1lYRENXU2dZTGdXaS8yMks2?=
 =?utf-8?B?U0tlMFZtSFFSS3NVYUJEUS85L2dzUFM2cnhKY0VzNDdQc1N0Rm1hakxlWVZ6?=
 =?utf-8?B?YXVPK2Q1Q243UWtrL2Z4emIycW80TDB1QWxTMy9wbEtxMDlMRFZUM0kwRVRU?=
 =?utf-8?B?Tlk1MVJCMVNJc2ZVaG9RUG12SUtTd0dHaTE3V2h1V0RRbUlHSXJybEdGL2I2?=
 =?utf-8?B?YndGUkRLTzVDamNqbXNYSnBlbkZRcytjVUw3SkFxODF4c0pZV2t4bG9DSzJy?=
 =?utf-8?B?WE1rWlJzWTg2S1M2V3pzcUlqS2RZMnJKNWtOV2hUV2xLNENmMFAybHlOYjhC?=
 =?utf-8?B?Ym1jbkZaZHc1MVVvWXFIS25BWVRCSHZUcXNjeVZYdUVYREpOQUhqMi9PSndZ?=
 =?utf-8?B?KzJha3QyVlFVT2R3TUFMUDRUQnpwa1N1VGZvQzk3cEhmVldCQkFtM21SVEJL?=
 =?utf-8?B?T2haUUM4OEpBcVd5cTEvZmxTTFdzZmI1eEJEU2RNZHlyYlhmZzY5T1NKWU0w?=
 =?utf-8?B?S1pCMjlmZU5OUkxEZnFQbUtHODRLTU13eWVzeW95bWM5V1RvQVZrbDlmZ0NW?=
 =?utf-8?B?MWpCNlhrRE5hOTFoL1dNYWZEMHFJTjQzNHo0bFRnNXlzcmQvUmIrZWN5ZDMx?=
 =?utf-8?B?TEFQUHFFSTRJOXRsRDJjNVJMWE1YVXNKLzI5YS9qZnRqeGhQdHhEY1FoVCtD?=
 =?utf-8?B?LzlhdjZDU09rVkVIZFQzT29WTHJDZy9LTkNULzcyZHNESlVUcDBnUFJyMW92?=
 =?utf-8?B?RWtVUE1pNnEreWIrWFBkRTRKYVdhbVNOUUpKUjRZeEFsazJLK3VqMWx4OG0v?=
 =?utf-8?B?Z2VBYndWbWRHM25GYzRwc24rTmljNlRzMm1IZm04OGlhbXpmbUJwMkF5NWlQ?=
 =?utf-8?B?OVNHVFNNQms4TUQ2WlMxRXF4NThVNHVtZk1rZVU0L1R1dVlmM1IwUnZuaXZw?=
 =?utf-8?B?blRnYVdXMlR2K1lHTk5IZ1ZFZTV2b21PSWFrNDc0ZHErUUsvRjB0MjhPdGov?=
 =?utf-8?B?azFJK0lBZkZlSlVSams4TW1IQm1UODlIZnJTVDFVdDUwa2hKQXJ5VWdHUHEx?=
 =?utf-8?B?dUgwWEF2R011dkZUQnZFejVLc1N6TElFWkp6WDNCdzZsQlA4QmpCMTNDMW0x?=
 =?utf-8?B?NVhQUEZhYjcrTlNsTWI5WmQ0ZlJINjlCK1NVM2tOdm4reW10bG4vNmZKMFBj?=
 =?utf-8?B?YzhFZTR6WVQxaGdkejN1Qk4zWDdxNldObjZ4WTd5S0pBQ3Fab0tUKzcyMWZs?=
 =?utf-8?B?Wmt5Qk1QS1pNbEtwdngwTGZjRlE5N25rNGxqbEoydHcycGE4WUUxR3pSaUFH?=
 =?utf-8?B?QWM2U3JVU2FZREdCYzVxZ0p1VWtIQWovK1lhN1V4THQydnF6ZDN3TUIvY242?=
 =?utf-8?B?OERQZnZpcGlBZlpINEdhRTNTRDlxRTNsa1dpdGcyRENLeWt1dTdZNFBKQW1D?=
 =?utf-8?B?SDJpeTRhWStBPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 11:33:31.9774 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fc25751-e97b-4398-d884-08dddfdd6455
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6615
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

Implement TTM-level behavior for AMDGPU_PL_MMIO_REMAP so it behaves
as a CPU-visible IO page:

* amdgpu_evict_flags(): mark as unmovable
* amdgpu_res_cpu_visible(): consider CPU-visible
* amdgpu_bo_move(): use null move when src/dst is MMIO_REMAP
* amdgpu_ttm_io_mem_reserve(): program bus.offset/is_iomem/caching using
  the device's mmio_remap_* metadata
* amdgpu_ttm_io_mem_pfn(): return PFN for the remapped HDP page
* amdgpu_ttm_tt_pde_flags(): set AMDGPU_PTE_SYSTEM for this mem type

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 26 +++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 27ab4e754b2a..157a5416a826 100644
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
+	case AMDGPU_PL_MMIO_REMAP:  /* <=== New HDP domain for remap page */
+		mem->bus.offset  = ((resource_size_t)mem->start << PAGE_SHIFT);
+		mem->bus.offset += adev->mmio_remap_base + adev->mmio_remap_offset;
+		mem->bus.is_iomem = true;
+		mem->bus.caching = ttm_uncached;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -640,12 +650,20 @@ static unsigned long amdgpu_ttm_io_mem_pfn(struct ttm_buffer_object *bo,
 {
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->bdev);
 	struct amdgpu_res_cursor cursor;
+	u64 pfn;
 
 	amdgpu_res_first(bo->resource, (u64)page_offset << PAGE_SHIFT, 0,
 			 &cursor);
 
-	if (bo->resource->mem_type == AMDGPU_PL_DOORBELL)
+	if (bo->resource->mem_type == AMDGPU_PL_DOORBELL) {
 		return ((uint64_t)(adev->doorbell.base + cursor.start)) >> PAGE_SHIFT;
+	} else if (bo->resource->mem_type == AMDGPU_PL_MMIO_REMAP) {
+		/* Return PFN for the remapped HDP page */
+		pfn = (u64)adev->mmio_remap_base +
+			(u64)adev->mmio_remap_offset +
+			(u64)cursor.start;
+		return (unsigned long)(pfn >> PAGE_SHIFT);
+	}
 
 	return (adev->gmc.aper_base + cursor.start) >> PAGE_SHIFT;
 }
@@ -1355,7 +1373,7 @@ uint64_t amdgpu_ttm_tt_pde_flags(struct ttm_tt *ttm, struct ttm_resource *mem)
 
 	if (mem && (mem->mem_type == TTM_PL_TT ||
 		    mem->mem_type == AMDGPU_PL_DOORBELL ||
-		    mem->mem_type == AMDGPU_PL_PREEMPT)) {
+		    mem->mem_type == AMDGPU_PL_PREEMPT || mem->mem_type == AMDGPU_PL_MMIO_REMAP)) {
 		flags |= AMDGPU_PTE_SYSTEM;
 
 		if (ttm->caching == ttm_cached)
-- 
2.34.1

