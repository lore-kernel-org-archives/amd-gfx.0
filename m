Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BED53C54E65
	for <amd-gfx@archiver.kernel.org>; Thu, 22 May 2025 04:46:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9DEA11A4EB;
	Thu, 22 May 2025 04:45:00 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2059.outbound.protection.outlook.com [40.107.95.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B949E11BB36
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 May 2025 03:45:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WJ7w5ZzZtBzzVydHv/ZR7GNKu2ajb1X7vHZtanbhxhVln/3mrRUziXnqIDi4/l0gjNrugLcOBNqzh+EN+qUUIzhLrahsc26X+Eu72QO/45hH5Gx1jnplfjdat/flNtKKSfVyg7hAO5vFtBcupmPO8O/lRaUN8rCpoo7uFn/zWd6jkQRXVLpOUscA0sxnr9x0WND6X1/zE5Byd69NBMs0lMAkJz2plqjYhdj+0YqG3gIaG6zJZGivs72cKE6/tsqgcnPrDxh2aXQnlCGa6HCTqGQB8NjBStrYWBIrZMP0yBSuJNoLu8mwuUlor/xHwytW1MOLprPiKGby8k8mByW30Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yG3goOvLwpSDdtvrTfPi0KIJ2FMZjmeaoqzTj8tQV6U=;
 b=A/xxvoJ/RM7CK2zLfsvL0d3K80nC1yB+YwoiDpzjNZJKMQ8dpHU1UbW5oRZEXz3QuTGMmhDNpJygBby3xPSQ33vbDdMhuN0pO3I1XLuFqHuh/3oeyVdslchh6YWWjhbw3L+HdRPgxTkreaqTyk94HtS9vmt88jSCirVB2kYU2Yl79Nw4h9QXX5qT0ATECT6r8oQTdQTzd3IgxKcU2VxR5kROvNyDgFIyUl/NjnUDBejebJ8w98XCTiin8VMBA3v0cn5AANAugvFoNw46rVDW4afY10H1D9H3+MYANT4Z6khKzlXB7XjUrh1C9QMDAev/kiph8P75K1ompIgI9VX+Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yG3goOvLwpSDdtvrTfPi0KIJ2FMZjmeaoqzTj8tQV6U=;
 b=c+bJ/SbDQJrh1T95kwcaNun8+M48SbK1PpB6xsapYzmjVF2AqHld9Rwndhq0p3lBUjZ4jL1N4kQuxlI7B3A5KFpYceEe0Zlu5/m9Czk/WWN4JpAvxlbEWElHnMh7XhCn2oBsoC9OKV2/QsIuvoXeYndj/EqQ6A+v0F9qW+iilgc=
Received: from BL1PR13CA0019.namprd13.prod.outlook.com (2603:10b6:208:256::24)
 by SN7PR12MB7345.namprd12.prod.outlook.com (2603:10b6:806:298::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Thu, 22 May
 2025 03:45:05 +0000
Received: from BL02EPF00021F6C.namprd02.prod.outlook.com
 (2603:10b6:208:256:cafe::43) by BL1PR13CA0019.outlook.office365.com
 (2603:10b6:208:256::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.13 via Frontend Transport; Thu,
 22 May 2025 03:45:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6C.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 22 May 2025 03:45:04 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 May
 2025 22:45:04 -0500
Received: from hjbog-srdc-17.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 21 May 2025 22:44:56 -0500
From: Samuel Zhang <guoqing.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <victor.zhao@amd.com>, <haijun.chang@amd.com>, <guoqing.zhang@amd.com>,
 <Christian.Koenig@amd.com>, <Alexander.Deucher@amd.com>,
 <Owen.Zhang2@amd.com>, <Qing.Ma@amd.com>, <Lijo.Lazar@amd.com>,
 <Emily.Deng@amd.com>, Jiang Liu <gerry@linux.alibaba.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH v7 2/4] drm/amdgpu: update GPU addresses for SMU and PSP
Date: Thu, 22 May 2025 11:43:48 +0800
Message-ID: <20250522034350.433219-3-guoqing.zhang@amd.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250522034350.433219-1-guoqing.zhang@amd.com>
References: <20250522034350.433219-1-guoqing.zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: guoqing.zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6C:EE_|SN7PR12MB7345:EE_
X-MS-Office365-Filtering-Correlation-Id: 53c0ec69-323c-4f8a-02d9-08dd98e309fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VlRZdkVlUTliSVVjSk15QVNTSE01REZMdTFvd04waDlyZVpiSHVoeWt2emp2?=
 =?utf-8?B?Mzd4ZFE0ejhoajAxZ2ROa09wUTByYkxIN1dNcHpkeGFaSks1STcwUzdnaG4x?=
 =?utf-8?B?bmxGQmU3ZFEzbkVIbDlQNmNndGN5VUVXTWM5dWsrV0RuVGE3TjMzak15R2lh?=
 =?utf-8?B?WkJhOER6NFNGSjlQK1UwcForZ3l2akwvWlpPTExGWTU3bTZMWEMwemdCY21r?=
 =?utf-8?B?UDhKb3U0c3VxRUJzM3YzdHVlUzRwMGF3L1lpN24xdEN5OStFWGo1b1dOVVBI?=
 =?utf-8?B?Z0p1c2lsTlYyY2IrWTdydHlKMWR0SHNtakF1aEpuNGM0UXhqNTFGZFE1WmQ4?=
 =?utf-8?B?RTVQZzU4Q0w4eHVCUDVHd1JWZDh6YWxHamNRblhDL3M3T3BEbFFzRmxaWWdP?=
 =?utf-8?B?cFdJTlNyamFRMnBVR1NpUFNzSmNHQlZZQkFOb29TOGxvNnZ3NkQyLzczTFV6?=
 =?utf-8?B?cEVuT1NQVHVINEZhbXhJNFQ4ZVFqRm5sZGM2TXNBbWVQUWRNVFBZRms4YVhq?=
 =?utf-8?B?eHczK2lYSkFUYWZjUm0rQ1ZHQ2JUbHBQK294bXpZWnYwRm44endWYWYvTWhW?=
 =?utf-8?B?L2FyL20yUU1wbHZsUXBEdnZzQTZxeEF4SFRPYjhsSTJEOW00UmFJc3RNQmtL?=
 =?utf-8?B?aUdJT0FSbFNUVmxXYnE5c283c3RWYVphQkNsUWVsR3ZMbCtlWDlOQ3RoU2RI?=
 =?utf-8?B?MGt2N3pHK3lURkE2Z2xob0hYRGx2a05LV1ZrRVIwOHZYTjJKUHVWU1ZMT3Fi?=
 =?utf-8?B?TUg1ZkhlSVczSUJSYVRVTmpWc21lUUNJSUlDNS8weDM0MzJuV2RieW5Kdi9Q?=
 =?utf-8?B?cWNteDE1MmQvWVN3dUcxcDNaTXY0REh0TWxwMjlqMG8vT1VTWWVhNWRmZVlH?=
 =?utf-8?B?QnNvNTdnaFZqOWFjZUpJRC9nenBUR25GUHhyT3NmT2lXdE45NVAzL1MrWTRU?=
 =?utf-8?B?d0dxNDE3aWVwTUVsRmVHZk1lSzc5MmNicWR2VlljblN0OWw3UGQxWjRseWxK?=
 =?utf-8?B?TGdLVWtXVDNxdWFmN1pqenZLSjZlTldITW9tQnZUOEwwNTVaSXhIVFhIdzNP?=
 =?utf-8?B?bDlPYU82cG9ickYyS2xLSXFYWHJxRnNTbHRSblUrUmRNREVINGlGK0NiZ2lo?=
 =?utf-8?B?N0V3UFRXSzRnNStwbE11bjhKd0pEYVVGazQ3MjErZnNGUVN4dEpWM2Zkb1Bo?=
 =?utf-8?B?aEdZTm9hckNxWGtJd1dGb2RBUDN4MjZWZkFwdTM4MW8weUF4SlY0WVRJUUsx?=
 =?utf-8?B?ejVjZFlCK0t5SXJEamFNNU11cHIxVVovcVdMRElydkZsbWhmZnZFYy9yWnoz?=
 =?utf-8?B?ckFzTG1BVlVUNmtCSWh3VFV1bzRXbmlXQlJTdGh4RGN5Q3psbFF3L0NPbkFV?=
 =?utf-8?B?U2VVRVIzY0xQT1dRUXZwekhsY2lucUlNcjJsT0dxZGhyK1VOczVKSjlBdzdM?=
 =?utf-8?B?ZE95T2hqa0U5WGFzZ09HT1paaTFHSEVweU5SdHVTd2Q1QTRZS01TQVJpQ3Vk?=
 =?utf-8?B?ZEFhM2lyQ2RaVmt4Ri9OTFdlVGdHTWNCNnlZSVVRaGpGV2FrbHp1Z2dEYmI5?=
 =?utf-8?B?citjdHRQbU14cFBVTDRSblRERFVrMFJ0RDVYYVArSGh4U2FWc2ZLV0NnVUM3?=
 =?utf-8?B?TmxDcDJ5QlBMa0pZak5iR2pmT2pZUnVGSEx5bzBXZ0R4MzNFdDhPWXJyaU55?=
 =?utf-8?B?K0FjdWJtR294bmRZeEkrSUtHS1g0dDRoVFc1cTQwd2JYcFFkYk9zV1hZVGpx?=
 =?utf-8?B?MFp1Q0RZWnBkU08vYkZBdG02N2kwMlpOZ2VXTy9iR0ZxN1BraXoxcXRhOFAy?=
 =?utf-8?B?cWw4QVRzNjhLNDE4US9tM1AwZUpHeWVUWkRtOVBMLy9NZnNnU2JxVUJKdENP?=
 =?utf-8?B?UXY0ZjZWM2Ewcmw3NTNUa0k4dEYxSXFtcGZTYmtYdmkxTWFPY2Jkd3dVT3Q4?=
 =?utf-8?B?ajJ4SkNDUG9Cdzd6MXhNSDcyMGdGQWJFcm1Jcmp2bitkOWlISjR0K3pKRzA5?=
 =?utf-8?B?enZZZ2Ywd2ZIazNmdTkyditSK3E1Y1lJN29IR0JuRHZ5T3dCQjlSeS9XOGVG?=
 =?utf-8?Q?4LjHzE?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 03:45:04.8389 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53c0ec69-323c-4f8a-02d9-08dd98e309fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7345
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

add amdgpu_bo_fb_aper_addr() and update the cached GPU addresses to use
the FB aperture address for SMU and PSP.

2 reasons for this change:
1. when pdb0 is enabled, gpu addr from amdgpu_bo_create_kernel() is GART
aperture address, it is not compatible with SMU and PSP, it need to be
updated to use FB aperture address.
2. Since FB aperture address will change after switching to new GPU
index after hibernation, it need to be updated on resume.

Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 20 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    | 23 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c  |  3 +++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c  | 18 +++++++++++++++++
 5 files changed, 65 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 4e794d546b61..3dde57cd5b81 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1513,6 +1513,26 @@ u64 amdgpu_bo_gpu_offset(struct amdgpu_bo *bo)
 	return amdgpu_bo_gpu_offset_no_check(bo);
 }
 
+/**
+ * amdgpu_bo_fb_aper_addr - return FB aperture GPU offset of the VRAM bo
+ * @bo:	amdgpu VRAM buffer object for which we query the offset
+ *
+ * Returns:
+ * current FB aperture GPU offset of the object.
+ */
+u64 amdgpu_bo_fb_aper_addr(struct amdgpu_bo *bo)
+{
+	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
+	uint64_t offset, fb_base;
+
+	WARN_ON_ONCE(bo->tbo.resource->mem_type != TTM_PL_VRAM);
+
+	fb_base = adev->mmhub.funcs->get_fb_location(adev);
+	fb_base += adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size;
+	offset = (bo->tbo.resource->start << PAGE_SHIFT) + fb_base;
+	return amdgpu_gmc_sign_extend(offset);
+}
+
 /**
  * amdgpu_bo_gpu_offset_no_check - return GPU offset of bo
  * @bo:	amdgpu object for which we query the offset
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index dcce362bfad3..c8a63e38f5d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -320,6 +320,7 @@ int amdgpu_bo_sync_wait_resv(struct amdgpu_device *adev, struct dma_resv *resv,
 			     bool intr);
 int amdgpu_bo_sync_wait(struct amdgpu_bo *bo, void *owner, bool intr);
 u64 amdgpu_bo_gpu_offset(struct amdgpu_bo *bo);
+u64 amdgpu_bo_fb_aper_addr(struct amdgpu_bo *bo);
 u64 amdgpu_bo_gpu_offset_no_check(struct amdgpu_bo *bo);
 uint32_t amdgpu_bo_mem_stats_placement(struct amdgpu_bo *bo);
 uint32_t amdgpu_bo_get_preferred_domain(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index e1e658a97b36..3fc4b8e6fc59 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -871,6 +871,8 @@ static int psp_tmr_init(struct psp_context *psp)
 					      &psp->tmr_bo, &psp->tmr_mc_addr,
 					      pptr);
 	}
+	if (amdgpu_virt_xgmi_migrate_enabled(psp->adev) && psp->tmr_bo)
+		psp->tmr_mc_addr = amdgpu_bo_fb_aper_addr(psp->tmr_bo);
 
 	return ret;
 }
@@ -1270,6 +1272,11 @@ int psp_ta_load(struct psp_context *psp, struct ta_context *context)
 	psp_copy_fw(psp, context->bin_desc.start_addr,
 		    context->bin_desc.size_bytes);
 
+	if (amdgpu_virt_xgmi_migrate_enabled(psp->adev) &&
+		context->mem_context.shared_bo)
+		context->mem_context.shared_mc_addr =
+			amdgpu_bo_fb_aper_addr(context->mem_context.shared_bo);
+
 	psp_prep_ta_load_cmd_buf(cmd, psp->fw_pri_mc_addr, context);
 
 	ret = psp_cmd_submit_buf(psp, NULL, cmd,
@@ -2336,11 +2343,27 @@ bool amdgpu_psp_tos_reload_needed(struct amdgpu_device *adev)
 	return false;
 }
 
+static void psp_update_gpu_addresses(struct amdgpu_device *adev)
+{
+	struct psp_context *psp = &adev->psp;
+
+	if (psp->cmd_buf_bo && psp->cmd_buf_mem) {
+		psp->fw_pri_mc_addr = amdgpu_bo_fb_aper_addr(psp->fw_pri_bo);
+		psp->fence_buf_mc_addr = amdgpu_bo_fb_aper_addr(psp->fence_buf_bo);
+		psp->cmd_buf_mc_addr = amdgpu_bo_fb_aper_addr(psp->cmd_buf_bo);
+	}
+	if (adev->firmware.rbuf && psp->km_ring.ring_mem)
+		psp->km_ring.ring_mem_mc_addr = amdgpu_bo_fb_aper_addr(adev->firmware.rbuf);
+}
+
 static int psp_hw_start(struct psp_context *psp)
 {
 	struct amdgpu_device *adev = psp->adev;
 	int ret;
 
+	if (amdgpu_virt_xgmi_migrate_enabled(adev))
+		psp_update_gpu_addresses(adev);
+
 	if (!amdgpu_sriov_vf(adev)) {
 		if ((is_psp_fw_valid(psp->kdb)) &&
 		    (psp->funcs->bootloader_load_kdb != NULL)) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index 3d9e9fdc10b4..bf9013f8d12e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -1152,6 +1152,9 @@ int amdgpu_ucode_init_bo(struct amdgpu_device *adev)
 		adev->firmware.max_ucodes = AMDGPU_UCODE_ID_MAXIMUM;
 	}
 
+	if (amdgpu_virt_xgmi_migrate_enabled(adev) && adev->firmware.fw_buf)
+		adev->firmware.fw_buf_mc = amdgpu_bo_fb_aper_addr(adev->firmware.fw_buf);
+
 	for (i = 0; i < adev->firmware.max_ucodes; i++) {
 		ucode = &adev->firmware.ucode[i];
 		if (ucode->fw) {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 315b0856bf02..f9f49f37dfcd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1000,6 +1000,21 @@ static int smu_fini_fb_allocations(struct smu_context *smu)
 	return 0;
 }
 
+static void smu_update_gpu_addresses(struct smu_context *smu)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	struct smu_table *pm_status_table = smu_table->tables + SMU_TABLE_PMSTATUSLOG;
+	struct smu_table *driver_table = &(smu_table->driver_table);
+	struct smu_table *dummy_read_1_table = &smu_table->dummy_read_1_table;
+
+	if (pm_status_table->bo)
+		pm_status_table->mc_address = amdgpu_bo_fb_aper_addr(pm_status_table->bo);
+	if (driver_table->bo)
+		driver_table->mc_address = amdgpu_bo_fb_aper_addr(driver_table->bo);
+	if (dummy_read_1_table->bo)
+		dummy_read_1_table->mc_address = amdgpu_bo_fb_aper_addr(dummy_read_1_table->bo);
+}
+
 /**
  * smu_alloc_memory_pool - allocate memory pool in the system memory
  *
@@ -1789,6 +1804,9 @@ static int smu_start_smc_engine(struct smu_context *smu)
 	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
+	if (amdgpu_virt_xgmi_migrate_enabled(adev))
+		smu_update_gpu_addresses(smu);
+
 	smu->smc_fw_state = SMU_FW_INIT;
 
 	if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP) {
-- 
2.43.5

