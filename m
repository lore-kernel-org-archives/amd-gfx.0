Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3B8ACA1007
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 03:35:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FF4210E55F;
	Tue,  2 Sep 2025 03:35:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DQsxrm6Y";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E007710E55F
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 03:35:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P6zOoI9gthp1chuTAaY/VOeEOQK0C+KBnxbgv7pCqM9pGMjgO7pHavcT+PriLFg6GEZyHsS4DnFFGkq6FjNpeLEVfvygj05f/fHqMra8ZLoVBk6J2VqD46x4si6ze5U05pkZwLBJDjMf23L/zSt9xZTk6t5k2CReB6ajF6kGXgWjWK648daAZiuk+QYLIXoJ49e3Y776bakJ96ZnccZSYcatHB1WvyT/ZJNz4ElA4xQsvylG+TFbG15Noo4B+/SjlJ0+W8UIOx5FJqthaifpmlIVrnp1ryIXH9z7IMWPRCkvr64SIQxti9GnpJ5BEhT0e/AlHVceAg8ukhgRrpUF/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EDEWocDhICEtawWM10gBdn+yyJGBQia4XhaDbV5VhdM=;
 b=e84B9Ev/lkbzgPj385iYK/vusUdfQ0AIDquKR1YlpWySm7CuqJ4kfhB5VnD0FGex4aoUAUbUfG7IO9ql5IIWXyVMWHsGS9tGxffIwywBuyzrOsy6nczbaeYW4FKNmHmckiMUZjWeZk3QoBoiESRgGdfs1FuTL/ndTHWh4tVTlrO8Y2JS2uOU0t8u7ZJD7wQ5V0eUMrFpXHE5PXX16AVcO8pxQBXNfjphCXYdSdHo9VI+Kiw3dDmaD7JdcZiPsf0SCMBdazpAUDDbWUkncjseSy517u0JFwtzySQdPAGou/5lF7o9eelyLcvuv4aIsqay8UDdCSuOtfv7HTI1kskLeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EDEWocDhICEtawWM10gBdn+yyJGBQia4XhaDbV5VhdM=;
 b=DQsxrm6YJwLp4ZkgYHZOkuQ4rmlmwMDV/CJ8qddViTWYya1hXxMzav/4ZpoI/Yudgvmp+iBlTfkQImJ4CFVpeuvdXVI2efrUe/WKQVpJShw2Pq8XBOS8d3VsD7tYO3lgaOzLA27GjfU9318aMU9YIWPbXKK4Q1pBvuJ565Axn5s=
Received: from BN9PR03CA0203.namprd03.prod.outlook.com (2603:10b6:408:f9::28)
 by DS7PR12MB8251.namprd12.prod.outlook.com (2603:10b6:8:e3::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.25; Tue, 2 Sep 2025 03:35:41 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:408:f9:cafe::cf) by BN9PR03CA0203.outlook.office365.com
 (2603:10b6:408:f9::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.27 via Frontend Transport; Tue,
 2 Sep 2025 03:35:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Tue, 2 Sep 2025 03:35:41 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 1 Sep
 2025 22:35:41 -0500
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb09.amd.com (10.181.42.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Mon, 1 Sep 2025 20:35:39 -0700
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v6 5/8] drm/amdgpu: Implement TTM handling for MMIO_REMAP
 placement
Date: Tue, 2 Sep 2025 08:59:35 +0530
Message-ID: <20250902032938.468332-6-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902032938.468332-1-srinivasan.shanmugam@amd.com>
References: <20250902032938.468332-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|DS7PR12MB8251:EE_
X-MS-Office365-Filtering-Correlation-Id: f3a1df22-dccb-4f7a-231c-08dde9d1caa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OWw3TTRVQk9UUTRnSTlqc0FUQ01hd3g1YUxkVlBtMnA1dmc2VHhOWURqWERL?=
 =?utf-8?B?ZnFuVjIxSkx3bmVzNWl4c3p0a3BuQUJacFRKTEdwRmZXQnRZYzh6c2pZd1lJ?=
 =?utf-8?B?bEZhMjNyeWdjL3JRNnZabTdqaTkwaXFmeDRPSi90eCtCWXgweVlMNldJMm1D?=
 =?utf-8?B?SnBrdU5kTGVJNFpTRHRLSGNIMXlQNHRoUTg4Wmk3Qk41QUkrSjkrcHBUdmJw?=
 =?utf-8?B?S0hVK3AxSWs3MjQwNDhKQTdyOTN0Q2pNK1ZBR0VtemdrT3dOOGx1d2VDUS83?=
 =?utf-8?B?b1BJOEdXL2xkN3krNUNhTUNZbjZ2eUdyQThqUjc2Mit5Zm9OMXQ4cXE2U3Az?=
 =?utf-8?B?UjdvbTJZL04xS2RZbmRFRGhUc2RwZGQxT1h2bTFzQ3Y3VTdScDVkb2t0MXI5?=
 =?utf-8?B?MWREOU9WcitCV1BGSk5VdCtQcTA3WW1XYStBemNTQjVQVXNRckViUmptWDBX?=
 =?utf-8?B?bVdWZDVpN3RLRE0vck1Xa0ZKalhGci9NQWZRc2F4NGpKRmo3aDhsQklaMVlU?=
 =?utf-8?B?UGRpMkNjY2FKU05LcG9mNUFkOHZZdUlZaXhoMUpLdGl0WFh3dnFkMFJ4c1U4?=
 =?utf-8?B?WVZJaURMUHczckRjWm1hUU4wTnUrSEJVT3pxbnMyTDJsYnFBcUxQNG5tRzQ5?=
 =?utf-8?B?ZC9OS0ZYcHdOVTQ0bmtkdlJuemNqVkRlbFA5ZEhNTTlJeDJsNGMxWHkvcWpM?=
 =?utf-8?B?am04TUpST2Y0cFhFRHRIWlpWVGFJQ1owWW81L3V1cDYzQitteWZ4Slg0eG1P?=
 =?utf-8?B?cy9uaHBWa2dUdS8rZkx5VDNyNVArcy9ycTVmNGRlSEs5a1MxbEFDVDJBTFhF?=
 =?utf-8?B?c1IyY2lld3RtZTJIRStoYkI4ZXE0cHpWeUVVSnU0UEtPNkdJVmYxTlczUmpz?=
 =?utf-8?B?N21oZEpYbEVXZDR0MDcwRXA3UDMxY2lTUExFeDdyNFdycXczMzlFQXFrck5Z?=
 =?utf-8?B?UWplbFhEdSt4V1p0SjREZ1VRSFBRS1VOMmxEM1FuNW9NenR2UVBmYU03cWJj?=
 =?utf-8?B?RWV1RFpOT25Mb3dmemxxdFFnbWRXaHIwU1ZHcEdSZ09kMis2TUx0bFpJWkl3?=
 =?utf-8?B?YnE1Y0FuUVhlYWlKQ1UxSEpSeFRzY0pSdHdHVkdIR1R0TkFKTFNxYkkwTDF3?=
 =?utf-8?B?RXdKbUNIZzVtVkxtWE5xZW9jOHBPMFlEVEd6WmlFaVRxYXBOcDVGbm5PdXhQ?=
 =?utf-8?B?VjdTT0lqdkQreHQ1dldPb2xjVEtJMDgxd2RtdkxhVzJCKytKb3Y2UzJobDJu?=
 =?utf-8?B?bTZlM2ZZYThaam5PMkNxMmhUSkdGd20xSVVkYnVzamowL0FNLzhMa3dvNDNn?=
 =?utf-8?B?WE4rVEd1QWdCcmFLUFNuMFJUYStQbWVIeUl4V3IvMEVpY09INkJ4akNHZ2NR?=
 =?utf-8?B?Q2o2WUdxQk8ySEhSeFBqejVkREJ1bWhXRERvaXBOQVdDNnh2d3VGYzE2K0lL?=
 =?utf-8?B?YmQxeWdMby9uSWpaN1BTcHVXWTBLbVUvM0U0NjEvVFpjb0VvOVBpdUFyRTUv?=
 =?utf-8?B?WFBDRG53dHM1OEg4WXBYbFU0TU9HV1Q5ZDQ1ZWhZMHZDaTcrUVVIeU52Ni9q?=
 =?utf-8?B?L1MxblVoMURkTUVEZHg4NW55TG9qN1V0dktTVis5dmN5MGJzNExYQVQ3STdz?=
 =?utf-8?B?QjRNTmFnRWJUdWhxM2JhVDdHSFRvSlVMeTFVNnRQQkJkYmxSOUtVNGI3VE9T?=
 =?utf-8?B?b1o4SXVGV21KZTlsZ0hjU0JPeTZ5WGVET0JLdllucFhwS1hRdEM5cVpmd1BK?=
 =?utf-8?B?QmtyNytZUDRNczFpTDdyWi9XSktsZlA2bktkTGsxUzNyL25rZ3cxQzB4WTc5?=
 =?utf-8?B?Njh4Mi9ZRFlaZUxPcEJBM0ZKelA0Y2NacWYvaDhBZmxUa0FNeUY0WEYrVDlw?=
 =?utf-8?B?YW1peDVRRU5xc0ZoZXBrdGovYlNDNHFPdHZZa0lrdlpicmtKdmcxNFlNWXNp?=
 =?utf-8?B?RnhIYkhlQTM0T3duZWxramlJZjN6Q290ZE1XRFlucExQT0ZNSEZUcURpNDI1?=
 =?utf-8?B?TzVYVUJtbks1cjMxZVRaRnhlS20zMDJnVXFPTjB0ME5TRjU5S055ekJEQTV5?=
 =?utf-8?Q?oHOWmh?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 03:35:41.3432 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3a1df22-dccb-4f7a-231c-08dde9d1caa7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8251
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
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 27ab4e754b2a..42f97d568059 100644
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
@@ -1355,7 +1367,8 @@ uint64_t amdgpu_ttm_tt_pde_flags(struct ttm_tt *ttm, struct ttm_resource *mem)
 
 	if (mem && (mem->mem_type == TTM_PL_TT ||
 		    mem->mem_type == AMDGPU_PL_DOORBELL ||
-		    mem->mem_type == AMDGPU_PL_PREEMPT)) {
+		    mem->mem_type == AMDGPU_PL_PREEMPT ||
+		    mem->mem_type == AMDGPU_PL_MMIO_REMAP)) {
 		flags |= AMDGPU_PTE_SYSTEM;
 
 		if (ttm->caching == ttm_cached)
-- 
2.34.1

