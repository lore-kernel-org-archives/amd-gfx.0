Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 740CDCA0FF0
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Aug 2025 14:02:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CD8610EBCA;
	Fri, 29 Aug 2025 14:02:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CYSj0q8h";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 029E910EBCA
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Aug 2025 14:02:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GXKwnx+D0ZWKtJoSZozRHaOywdFSfcTY+R5aceuSE2X+DGPns7YcflcVQy+no/2RLzeqp/7MrJ4+Er4pbUVbSzZP6+b3oi//AuZKrAd+cNeDw5NQmuu85secxbuD9YV7BH+vG31Qc+qwuPvOr++6zKMaY6ljfnFxMjpYtVipHV8FLvEkydqq4lA7aqITSnVZGOB3wYqursctJqMJZwYKJ2HdruW6rMOHUeNiPR5+l+dJHGLE7SwYa53lGXuo55L5P+fjXeEVVje6gLocVcDPlGUt3btDTrw1ISv7e7YXOFgE2EUbrsJLAYwe2aYcYUlWPtiAnTou43fy7tHz6MaxJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tH7bfYD2ZqI1qCg3IhEdVoijuxi8EssPmSOJfQ+WWMA=;
 b=r+3V/2MCoRhDSwafXExi09vYU2eKtP8OaowYQjMdYNqEONnCTXhWR1dQANhIcaiifMcxtW3LK61vzmU3NXF7v7bauFx4kOeL/wiJRXB1p+Gbyt3gmAHT/xULZVoYFeKQACkmyxGZw2eeIL+UIqTktdVd0Z5bq0xxoeAmm6wERMz7++pNZ85+EYE2DAHuVKoGUkno8lLYImvsDmf/2P/XHZUl/4Vq5gCv0M7Q5ysXoAQ7yLVPRhgU7aQmuNSHRW9nNyWFNvbubj0P+Io3loC9Bsun4BgypWKDcQN3IDc0aFWaGIQNASLFLPMa15EqMGJew1s8ftUTltc3tElzsADytQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tH7bfYD2ZqI1qCg3IhEdVoijuxi8EssPmSOJfQ+WWMA=;
 b=CYSj0q8habrfRO/h/cFQJ7KAxuTmtwKO+oBUvzoiRcD/s6L476k2CHByPVJGQWUA1B0zN4BJ88d4kO5DlgN4OYkBHIWslPremH8o8m2bcgLoM3jcqxVYp+QrPBfGigAtgMw2BnGAeoAJzUbbOcTTHMgzaZ5M4AvvAE1xlVvysMY=
Received: from CY5PR17CA0002.namprd17.prod.outlook.com (2603:10b6:930:17::22)
 by IA1PR12MB8540.namprd12.prod.outlook.com (2603:10b6:208:454::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Fri, 29 Aug
 2025 14:02:36 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:930:17:cafe::2) by CY5PR17CA0002.outlook.office365.com
 (2603:10b6:930:17::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.19 via Frontend Transport; Fri,
 29 Aug 2025 14:02:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Fri, 29 Aug 2025 14:02:35 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 29 Aug
 2025 09:02:35 -0500
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb09.amd.com (10.181.42.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Fri, 29 Aug 2025 07:02:33 -0700
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v5 6/9] drm/amdgpu: Implement TTM handling for MMIO_REMAP
 placement
Date: Fri, 29 Aug 2025 19:25:20 +0530
Message-ID: <20250829135523.4032168-7-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250829135523.4032168-1-srinivasan.shanmugam@amd.com>
References: <20250829135523.4032168-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|IA1PR12MB8540:EE_
X-MS-Office365-Filtering-Correlation-Id: df27e7f5-f94d-4b47-dfb8-08dde704b4fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WCtVSkJrUUlURFE2eDdqbWVXWGcwd2syRzAzV3VST1RpUDROQ0RqRUdOR0th?=
 =?utf-8?B?ZUhJcTFiNWw5aDM1eXFzZ0dVYTMwKzgxaU5ETkFUVCt2bDhTdmllSmRNQWhR?=
 =?utf-8?B?dVVTbjFHZmxidnZ3MExiY3MzcG9WWkFROVVNY1B3bTA1emt6MllUd0psZ0dJ?=
 =?utf-8?B?QVBRK2VqZVBuSmRONTUveUlEUU9Zd1FjdHZncDNrT2lsbndwbDJnV2NKRFhH?=
 =?utf-8?B?UlJLR0JpZlRPWm5xT3E0Y09QWkErQk9jaDJhRzZqMHhkNmZLMC9FZ3pNYllq?=
 =?utf-8?B?am16ZGlhbm9naWl3Q2FXaTROb2dEQU0zc1d3THk0MjIrU3hYZzdYT3hkOXNh?=
 =?utf-8?B?MWY5bVJ4TnJLRGFCSjZMLzlQOHF4Z1dWVmZyRlpvOUY2aUwyUm52Z1VsdHQ2?=
 =?utf-8?B?aWl3Y3hSVkYwWnpkZmkySE9qNTNpRVB1Z1Z0ajRjTXN0czBvQXp3NFZpRnZX?=
 =?utf-8?B?aTd3aXhiZUk2SmhzVjFuMnVhWWJ1Yi90QXF6R1VINGVjSDE5emptOTZOYjVM?=
 =?utf-8?B?MmJMWGFDL0hSd1Fla09MYnpkYjI3TUhNOFluYi96Kytzck10RENrc09TTDNP?=
 =?utf-8?B?SldhdnJQNUVob212UnJ0MjlYUzFoY1dWbnFEMWZWL2RQaEZ6bThVTE5ZY0c2?=
 =?utf-8?B?cjExMmtWVzV0NFBlRWpyTkoyVXduTjlMMGZyZzFST0hjUUp5d0l1YTI0YTZJ?=
 =?utf-8?B?VnRwcFJkREtUK3VkVWhpN2xQNm5QUG5NTEhnb084bDNNMTVlY2M4eWJPQVhp?=
 =?utf-8?B?UUg2c1Rqbi8yTlp6S2JBMXNBMXllajhkaUszdk5tcCtURlV6TmR1YWJNYXlj?=
 =?utf-8?B?b1IrU2ZDUnpPUVQ4SnVnQXNnc2srNWFmN1lYR2JrUDJ1WGgyeXBtczNEeE9U?=
 =?utf-8?B?elVVdmdpRGVwYit3aWhSdnBTdVoxS3k5aTZ4bjV5c1A0cmJSL00xNzV2d0dN?=
 =?utf-8?B?bG53bWM5bGFuWkdhSTNuTUozeFRHcUJMZlg4NGRXUHV5TGhyeENsMzVhNlRP?=
 =?utf-8?B?TU5peThVam90alNFTHkzZzdPYlJxOFMzOVNpN1IyazZSL05lNE9KMnp3RkdE?=
 =?utf-8?B?U3U3ZEFhcHF1M1JCa1RKamJiZXJZREh0Wk1zTERRRUxYSHlPRjA5YWJHL0lN?=
 =?utf-8?B?YmpNaFJob0JWN0hpZnJzM0ZKbzcyTS9VT2NvSEt0bjZrVzVOWnIxS3QrNXRP?=
 =?utf-8?B?WFBkZmhMMURMYk1QOW9mR2lOQzNTeFROQmM2QlBRR0dlckRHRE5GQytGMnAw?=
 =?utf-8?B?RFZLeHZtcUNBN2ZvWXg1b0oxckN4Q2E1cmt1dmtjSnBaMmFBWFNiU3h2TXZh?=
 =?utf-8?B?V0o0WXNqYUNVZ3IyMVU2ZXYrMlkzdG56Smg2blcvYWZXMDVxUlhpTHlzN3Yy?=
 =?utf-8?B?bUhpa1BSN2ZvWVI3a2EvUk5yRTZXZFVUaXZzSy9nazFPbzRTc0xRbDRxRkdv?=
 =?utf-8?B?RVhQYTFqRXNmUmZJc3lFRkIxdzBOOXBNYjFuUzR5aUs3WEhUTnQ5clVOUkpF?=
 =?utf-8?B?bHQ2emxCUXpVd0ZZRmtYRTlVRXl1OTVvUTduY1hZMDhMdDBpd1A1S0FkOWJK?=
 =?utf-8?B?aEY0cG15eXpNaWZkQmpuZnN5eVE5dnIwZXFIbWZWcWZhbzdoNmRCdldTMkRv?=
 =?utf-8?B?ZkJJTzdRRGt0QWRxOVhUWE9RcE1HQ0tsZnhoZkprVHorV2lZbE5teURsOWFt?=
 =?utf-8?B?WHpSVlJpNXMxRVMrcENVMEtIeUlLbUpZalRqY0hlN05tRThHVUx6NUFyNXlN?=
 =?utf-8?B?bmFEOE9Ia0E4TGNORkhSU3Z5RGg3VzJsQ3RBNklRd1BxcXUxUTBEOE5QWEZi?=
 =?utf-8?B?NWUrVGJIOVRTTFdCc2cyMnFmeVNFbTNvMmp0SEI1cGhnWHBldWc5TzFEamdU?=
 =?utf-8?B?Z2RKUmJiL0tMcHZ0N3pHODZaU0liejZZWVhERkEvK1dWa0VRSUJYSW0wOWZq?=
 =?utf-8?B?aUFZeVpoTGxYUzRFREdHMGNSTmNlUVZPT3FWdW1qNUFtdDBsMlFtdk03TGxD?=
 =?utf-8?B?N3VqVFEzZndoM01GTVNObDJoby9sdkVUNE5GUEErSi81T3NEVWpRN1Y1L1cz?=
 =?utf-8?Q?FO8sWR?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 14:02:35.7954 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df27e7f5-f94d-4b47-dfb8-08dde704b4fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8540
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

v4:
- Drop unnecessary (resource_size_t) casts in MMIO_REMAP io-mem paths
  (Alex)

Cc: Christian König <christian.koenig@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 27ab4e754b2a..5f378f5c9350 100644
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
+		mem->bus.offset = mem->start << PAGE_SHIFT;
+		mem->bus.offset += adev->rmmio_remap.bus_addr;
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

