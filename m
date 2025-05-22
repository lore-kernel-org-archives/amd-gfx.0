Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65313C54E90
	for <amd-gfx@archiver.kernel.org>; Thu, 22 May 2025 10:41:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00B9D10EC4E;
	Thu, 22 May 2025 10:41:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R/G0ct1H";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C213410E754
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 May 2025 10:41:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rMtzKUvWRZevBbqRIIhGG2x99/lAq97XwFxqjUMsF53Cau/m49cVdrlYEtF6JQpQWPVjfySglWRsBDikUt0nxuWO6Wb36/WasyRfEpdbLFZOXrdYZgYyLjeUzrQogZPEiMnwcV6Yohh2m9exjYGh6a6Nxw3jJO0JR7QwgFUU6d0+1Tg93Vc73MpPfnOyC3GUQpsWs743hj8/R0LD5yUwQS8xVpIfa8Lk9U6hfqiKTtJWcx9SkUFIOBdXp0DZ1ko9fZOSq0CPqZt49GNr/faegdWxJHrU2I7jfxQ3mFN1rx3ud75kESOHlGW9nq3SqdMFOaEMrdHG6NEEx6IAO9tTIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TZ0RE2nADtMoA18d17QA2q4/y0tCaH4rxYObX0Nq1Q8=;
 b=GQuK3PMNZjKD0XUCl7IeO7UgGHM0sg5FlJDu2Zy66kRBF+P82zBM8bT9GSpTOHgsB6RoLd2UqxwDvI6acM1DjnZlaZorJz2XjGea3lRbsaUI1eFqWf9i4PbnulxCTecJqdcHOO4l5/s3g3kk9G17cQS5EGG6xsD/o3H6wjlIB9heYUc02v/IyF/xlLVeV2h/K10QXGY13wAgAiJ7rTSzOOhPAu5bzoW9OcsxYkyqSuRYxZplQwGXgVOb0sDzQk4geHYSv1CiTJgt7UwxLhCLOmtvLa4EvI7eOsUKamL04+YPzEp/SlIw2e2Tz5iwrAAQN2jCyFX8Gu/s8FK56GtN/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TZ0RE2nADtMoA18d17QA2q4/y0tCaH4rxYObX0Nq1Q8=;
 b=R/G0ct1HykCZ1FGByf5WkQ/mjsbzLtDiqVleXMIHPPmdzHaISyY8Kh+7eCTklZbXhzKiUHKiH7+8ymn8gQC1CtE2+5Sy1v89ROE2u3PIkFnuOxsKodQUyiNIODzLQTo4MN3qFpU8cxxrzitZ8/+6BXgpF8nH9uL3agNdq0cAdpc=
Received: from PH8P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:345::19)
 by CH3PR12MB9220.namprd12.prod.outlook.com (2603:10b6:610:198::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.22; Thu, 22 May
 2025 10:41:17 +0000
Received: from MWH0EPF000A6734.namprd04.prod.outlook.com
 (2603:10b6:510:345:cafe::6e) by PH8P220CA0012.outlook.office365.com
 (2603:10b6:510:345::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Thu,
 22 May 2025 10:41:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000A6734.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 22 May 2025 10:41:16 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 22 May
 2025 05:41:15 -0500
Received: from hjbog-srdc-17.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 22 May 2025 05:41:07 -0500
From: Samuel Zhang <guoqing.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <victor.zhao@amd.com>, <haijun.chang@amd.com>, <guoqing.zhang@amd.com>,
 <Christian.Koenig@amd.com>, <Alexander.Deucher@amd.com>,
 <Owen.Zhang2@amd.com>, <Qing.Ma@amd.com>, <Lijo.Lazar@amd.com>,
 <Emily.Deng@amd.com>, Jiang Liu <gerry@linux.alibaba.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH v8 2/4] drm/amdgpu: update GPU addresses for SMU and PSP
Date: Thu, 22 May 2025 18:40:46 +0800
Message-ID: <20250522104048.569456-3-guoqing.zhang@amd.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250522104048.569456-1-guoqing.zhang@amd.com>
References: <20250522104048.569456-1-guoqing.zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB03.amd.com: guoqing.zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6734:EE_|CH3PR12MB9220:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a7b0eae-98bb-4b2b-1172-08dd991d2e27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N2phSlZvL01nVFdlMzd6V3l1VkJLTTVjODk3V0ZvdFlBellGVkJCSm1GYXYw?=
 =?utf-8?B?YU1mbDZwMmFKcVg5RWYxVHdyUi9ib0RIWmtNb1RscngzbzJaUVoyYWtxblln?=
 =?utf-8?B?YkFhK0xBK1RIKzBJelM1UWFiTUY0VnlaUlE3aGcvZzM3OHZSRWltVFIybWF5?=
 =?utf-8?B?KzFUYkV5UWtMZmVDZjN5M2ZRaUtsYTRhMHlmYnRvSGMya3lwL21Hc0ZxcTdY?=
 =?utf-8?B?V1duY2gxRVBVdDBUNUNOY2wwOUxESlZDTjlrbDh6bWFDbnVBWk1IbG5OeCs0?=
 =?utf-8?B?N0kwZHJhd3pPWGkvSUFUam1tQWRGbm9abkQ3RnBkaVlTZVJKMUcwUWlVTHRj?=
 =?utf-8?B?Ly8rVVo5L2MwWDJwVHMvazBraHlYY3ZtdGhNd25TeXQzSjJHWDRvc2p6OHd2?=
 =?utf-8?B?dlduc2dXakMzQk5pczNicnoxaGZYbVM5SjZzdXFaOVpmZkF5aXI4WURPZm82?=
 =?utf-8?B?ZjVBM0ViaEhueDlDK25hYkVnZDNWVEhSZXRrdmhJVlFFcmExc01iRkNEUHc1?=
 =?utf-8?B?ZlFpd0NZUjliS2dDSXdPeW9CeWZRV0puMWYzaTdiemxrc2k2VjhOczFEMFpy?=
 =?utf-8?B?OUtYSUViVzNoQ2hkUXJCMTlMZVdHWmxjcUZFUTdocGVkTUVFcWRuQVdpc09B?=
 =?utf-8?B?SzFvdkxCK3VQYXR3c3pXNFBxNU5EaXF5WFB5WHpFZ2pOMUF2OWN0NDd6Rjhs?=
 =?utf-8?B?cVU3d1J2QnViRWhiVUJVMEJsNkpzUTFCMXF2bFBjS0JvaTZ6dHNSY0djaVEr?=
 =?utf-8?B?MWxuOXRiUk5EVlE0TEZWdGVsdzR4Nnh0YmprL05pU2hpMVFvTzYzYm8zbkdl?=
 =?utf-8?B?WFJGblIxcitVR2ZWbURSWUxST2I0N3VtS1d0dStTb0JXeERRWDdsVnl1Ky94?=
 =?utf-8?B?VnVmVmhhUnBrb0R6QXU5T0oyS2lERE1RSUx3aU1ZUnpVRUlXTmdRam91c2pR?=
 =?utf-8?B?azc5Y3dqVFdQZVBpVjM1SkY5SDZ2THQ5eXpJWWhodlRId3lMc2w5YnZ2WmJ6?=
 =?utf-8?B?dHdZRnhBMXlCUEpjQ3hCVXEyRkp5Tm5TSmJsd2gzVzZ5dEN2aWg1TFE2REl3?=
 =?utf-8?B?ZXZacUVweC9qekd0Q1lmcldtZ3ZGOFVGbDZjOVppVXE4UlRoSjQ0N3d4Uk54?=
 =?utf-8?B?SnhLLzQvcjhTQVVuRXNnVlJOcmM1bW1uNTR3K3RlbUMwV0E3SUVLc3Z1ZWxP?=
 =?utf-8?B?dmJQRjdVeXdOelhmTEJoeHB5ZlpxQlNqRmF5NVNCTGMya3ZTNElZV0QzVnpt?=
 =?utf-8?B?dFMxcVgwL1ZleEMrNmxBSHlSdjF3dFNiVUIydXRjaU9lMHdGZG84WXcybWQ5?=
 =?utf-8?B?b1RGa2IxbEluOWxMRjFjT2E1cFdpOXJzNFF0R1dxNGxuZER4MVFjWng2TVY2?=
 =?utf-8?B?bE1GWHc1aWhPWEt5SFg4Zy9MRlROMkx6WEEwb3ZSbEhobGhUKzE5TVFKeDVM?=
 =?utf-8?B?ME42OEdGYUN0T3RHeTdVVDNDd25OUmtldURDTVpyVmlVZjNpYWpFZWwzSHdD?=
 =?utf-8?B?SEF3MzA4ek1nMTRQazA0cUxEU1NiaGEwdjdnYmF3cDNiK1hNQmhsMU5RR3BY?=
 =?utf-8?B?bmxyUmQ4aUJMcG9qZmEvcVVzYXo4dXZjVEx5Sm5oSVN0Ty9zZEpLbktyYmZD?=
 =?utf-8?B?WmdDL1lPeW0vQ0E2TVR1VlIzeHl5eXBLMDdjS0dvTFJZU0h4L0c3VXB2Smw3?=
 =?utf-8?B?L3JjdmNod3dFZjk4eXFDWGR1K2NDZEgzT0lNdFZGL2ZNZ1VFOUpVUlVQWVo2?=
 =?utf-8?B?Ukw3bDd5K1pjWnk4TExoM2NwM3c0c0lrV0J3STY2eTRsVW5rMXdNc0haejNH?=
 =?utf-8?B?bW1Cc3M3WDgxTUFNWFRxbGNmMHpMV1AvWGNtT3JYTWhSYTgvcEFKWUhWNGVU?=
 =?utf-8?B?REhEa2EvRStwb2dSQ3NWQUdud0pqUVl5UFlidHlSck4yUHVwcHg4eHRGdHdT?=
 =?utf-8?B?cy8wVWlxSFlkV1lUQVQvMVpQN0pkTm9veHArM3ZCSXJudFQ4UGxNeFBid3V6?=
 =?utf-8?B?UnRBbzBkVUw3aU9GK3ZZVU9mL0s5aXhqREZ3eW1yNkFPUlNETWZ3S1FhdVNW?=
 =?utf-8?Q?CPkMPX?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 10:41:16.2409 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a7b0eae-98bb-4b2b-1172-08dd991d2e27
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6734.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9220
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
index 4e794d546b61..c93376ac4043 100644
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
+	fb_base = adev->gmc.fb_start;
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

