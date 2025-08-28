Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEA92C8303F
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Aug 2025 09:15:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BC1E10E93C;
	Thu, 28 Aug 2025 09:15:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iec6qg36";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E31A910E8AE
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 09:15:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GJBos4+bVcmILv0ICGXkG5hjwbALPQN7850wa2ySnIydHAyhAm58wuYDWvfoBOSyeBoXMikJlGhagpUA80LcVvDboqr/BA13u1V3q5pUAwX/0hdZRQwhgDH24RXLpcGYNQS6fyfmM5VUlf2mJXf3elTqoUFONSdZ65zKfVjCyfR+XxaMUsBMlmooxwCIZaPoRq3D0D6groM9K0ECdV4UOw2n4b4v9MRfpivCZiKbj6llyBooWGt55nm1nuurGLVph+GTCu3gSpO/7hgWJKYkkV6VcPQyZjQLfaaZx9QlwS7GKwtKP8j+1G1JHA8gie09KUK9CQYAm3Ur0kQSifhK9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sicIl4xuUwglQoLblALJ+cm2n/YOMY5bV9AnzdyLNzo=;
 b=NpGley5xpOFrxawyhWEZfUxt5rp927EtSO1WK10SNgXK/pmfn3Ah0G62UYUkl/nWRK8m2EYVApz2xveke+mYwz2DQ0Jzl8/7MKZDN/Uscx5C1acpmdfRrWjnE6wK+e+V4kvMh3R07n6M+H8GJIkZRK+S+VAXQDzOZ8n1BrLADjdkLXrRpYed6WBo2F3c+34aYiVA/ZUnWkPcxypUzTIEKvlZm2YgziJqd1JR5iOKHxNVPk79A44+dS1DjX8J7GAjG+CsITNE9GIS9dNC/W6cEC79Ez2C9MPmuIkNZch0yN6xxQRjpCWjJTNdnMCSKWDEYX3Y9aU+cjFwOoyh6bV6tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sicIl4xuUwglQoLblALJ+cm2n/YOMY5bV9AnzdyLNzo=;
 b=iec6qg36g8X1Cft2JQL6CYTGjFXwluyN+/Q3GRGe5NyCxOHcVnQEcVDTt92o+28oOudIqRDImofG02ZCUM1d2pYHdcpzX2eltNzaIVq5BhVmF2ViLVnwU+6js5Dn62aNvxq/0ONVbLhROsK/F3tBDEYDZMVFMbYlj8E9FJVSVNk=
Received: from CH5PR03CA0009.namprd03.prod.outlook.com (2603:10b6:610:1f1::22)
 by DM4PR12MB8558.namprd12.prod.outlook.com (2603:10b6:8:187::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Thu, 28 Aug
 2025 09:15:36 +0000
Received: from CH2PEPF0000009D.namprd02.prod.outlook.com
 (2603:10b6:610:1f1:cafe::c5) by CH5PR03CA0009.outlook.office365.com
 (2603:10b6:610:1f1::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.18 via Frontend Transport; Thu,
 28 Aug 2025 09:15:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009D.mail.protection.outlook.com (10.167.244.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Thu, 28 Aug 2025 09:15:36 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 28 Aug 2025 01:46:01 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v3 6/9] drm/amdgpu: Implement TTM handling for MMIO_REMAP
 placement
Date: Thu, 28 Aug 2025 12:15:27 +0530
Message-ID: <20250828064530.3948378-7-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250828064530.3948378-1-srinivasan.shanmugam@amd.com>
References: <20250828064530.3948378-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009D:EE_|DM4PR12MB8558:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ae7d8f5-575c-4431-4f93-08dde61372fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZkxaNjlHanNBRERZdVhvQnFKSHA5R3FIVGsyd282RGlmTDBHYlZQRVprQlBx?=
 =?utf-8?B?SVJrRUVVS0RCSk9JR3pkQU9tRWxBaDNiYUtYVjF6OHYyWDZrQ3hLRVhaZFgr?=
 =?utf-8?B?R1pBcTNTNmZVOXBMRTFHTENuaDNrc1BNbHdWYW5pcURVaGdla09mb25kZ01m?=
 =?utf-8?B?YU90NGF6UmZLTWpDVG53eWJsL1paWjN6N09rRG5WcER5MGdTTXZ0U29QSlFW?=
 =?utf-8?B?MGd4ampyODZtUHFNQlJmQU9idVZuWVNLblNLNDV1aDE4elhSbTBjaE9hZEcv?=
 =?utf-8?B?OU92VlFZOUhnbWVUSkVVVXhvVnlaT3R6dW16N0lyb0hLUytGVWU2OVBzOFc2?=
 =?utf-8?B?eFhabnlzZ25vWDFtdDB6OU9TcjZKbHlpVStCc0wzd2NUYW93Q05PNVRzWE9X?=
 =?utf-8?B?aThYY1pzTU9RcnpOTTQzU0lyU0JmZTAxL1VFK2Q2NGF3eFN0a2VBSFZMelhB?=
 =?utf-8?B?R1d1d25YZzJtSVllcnlBSkVBejIwTDRLZGdOQWFVWmxqckVVOGlGTTUyRjhm?=
 =?utf-8?B?L2Z3YkM2bE1uMTQ5ZWFZM0RJMWpIUHdJM3YxallOSmwreE1mWUFqd0s5K3Yy?=
 =?utf-8?B?UlExUzlkaEdlV05HRnBkYnZCcFBQREZWSVgydUJaUEM3SDRZNFV6bTlIYm50?=
 =?utf-8?B?dFQvL016ejhSQ3FkLzJucnJJOTV3N1F4R2s4d3BOZ3pIU3krKzRXVkErU2sr?=
 =?utf-8?B?T3VRaU9EVzhvb3VrZElxa2tocWd3N1BYUnNRM25jU3o5bGJnditQbFlsY3Zj?=
 =?utf-8?B?YmhVS3k3Y3hEN3RXNGtrSmVSbTcrVnFadE4vRzhoODlzNmhJSjkxWFRBNi9H?=
 =?utf-8?B?OWZXT3Q4SWhTNnY0c2RIY09vd01CeWFtbXRiY0YxRE16QTB0Sy9LdGRTUzRt?=
 =?utf-8?B?cklQSnBrZEdvdWlsWjBpeFlSajlwRDF5dU1iSjhkNWlrZlhSWTlWUWkrNWJH?=
 =?utf-8?B?K2xpWmhHM2NKbDFqcFpRWXpURVlUVXZuV0hmb3VhTC95NGxGYmxZWll5akNH?=
 =?utf-8?B?NVAra0JJK2JYNHFVR2t0U3ZvbE5TeWxHRExzY2pBNTBTcG1VTDY0dS9yRklM?=
 =?utf-8?B?UENncDJhbXh5Y0F1bUpiaThCWFdyZ2hUMDI1Ryt2MlBQOHF5TVBMUWFFc3FZ?=
 =?utf-8?B?d2F6UGhqZURGN0QydlUxMHpTYm5QdGtuYlFNRktjVHp2MGxSR0hjd3pxWlpp?=
 =?utf-8?B?MmRFTXFubFZHL1pZVVA5U3hVMm5nZmFmWi9UOWsyQlRvT0c2LzNpelgxRmFQ?=
 =?utf-8?B?aUpyYklmWkptSEdLa2x6TzNwMUhHdkhzYy8xcEwxUjZhYVJuRzJCZGp1M2pP?=
 =?utf-8?B?bEM4Qy9hZ2hwM2lOejhJZkR0NmR0WEhkTldnVEprMTZrSTJFWWhpM2FHTkt4?=
 =?utf-8?B?cEduaCsvVHQyejI1SmNpN0xZeHYzNmYzbzhHaDd5VWc2YUNjWUo2c1JGVUd3?=
 =?utf-8?B?eXlScy84OUlvY2k5a2ZMWDZuNzdPWUlVYlhYb3JPQTNxUG91QnAxa21hVGdl?=
 =?utf-8?B?MWtoT3FMYnkvR3FMd3VsV1VzU1BtTVkxdDJIOVpvOGtQL3pMbkpKaW5tL08z?=
 =?utf-8?B?MGJoV25LS0FjY0psS1V1OXgwZFhuTGc5VVFhdjFnelhCdnBET1dDVFlIS2tq?=
 =?utf-8?B?UHhzMGdoVS9EM2VzTTFzaEVPZVJZS2lEd2RLcmRUaHhSbDZTNGRVS05nZmxR?=
 =?utf-8?B?S2d6MTBXWmlxVTd0aVhzOWNEWlRudzZGT3lyV0RBNkVGUElwNkEvTGF2VjhV?=
 =?utf-8?B?OHUwbXdCQVE0Q0czOVF4UEV5MDJHY3c4TnFGUUE0SEZGcmwrOVdzNG1MajZs?=
 =?utf-8?B?KzhTdHVuRjJoUlI2RURwQ3JQT0s3b0UvM3pkcmpSZTVxaWxWRHhXd1c5NDBP?=
 =?utf-8?B?ZFBYUnR4emdrTzEvRTVXYzZPYThBS3hVeFUzV081TmlxMXJUOXFlT3ZBZDNz?=
 =?utf-8?B?dzFMNXZ5NnRhYSt0MlZiVHRtTXFWdlo2eHp4bHBJWjRkODRxUk55SUFMeVJi?=
 =?utf-8?B?OTZKOVc2SzF1bzVtb3BNQXk5L3VhYkYxNFNkaEdNWXZpN20veGZVV01scGJK?=
 =?utf-8?Q?43pI5L?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 09:15:36.3964 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ae7d8f5-575c-4431-4f93-08dde61372fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8558
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

