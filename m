Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 553C9C54FB3
	for <amd-gfx@archiver.kernel.org>; Thu, 29 May 2025 10:03:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E667A10E72A;
	Thu, 29 May 2025 10:03:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="122bU2C2";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 172A210E72A
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 May 2025 10:03:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yHaICoALMEBT01zdjiUVA6nSrz3meeG1RFNkb669LTcRvbQEvIlAd+BRyquGiDUnR3uFQtC6snWoWADvaMBeEYe5Xb2H2F2s+Ja2KQUYvUbf8OIu+HBFE/j963Oe5VNRBKL0j3MeGGXQfsUzzHtlkWIH4Gyyv+L5cK7mM2uWcDoG7KrKBltUM0a+WscoVdDe6s2rXJb6C5E4HtoJC9lPwv8mitJTP14zXDlYvPW5Z+k6Sle3G6DKLb0noPsgyH3iyTtZlWt6TF22YIoslJUWFadTP7R3V2i7In2PFm3B2qeqsxTG9XHSPMKna+DJAmwloHGa/xzgjYH9McaEOz4FEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TZ0RE2nADtMoA18d17QA2q4/y0tCaH4rxYObX0Nq1Q8=;
 b=oqXUPJPEm44RlmGbQZL8i7mrAtaGLQrhySoHU8dc5M/e5OF9A81uwQrh9Eswh2HkgHndlQeZQvMGIeQzlRmuDB9gPA1yFNsIKEcv2XwSX43fUDHptL6UiqOoahhckLnH2B8Nc+p7TSqBRHCD6pIWU67MpIPylP8O6LvGs0UASlSGC60Hv2gxCY2fz7RxLipwjsUvhr/u4g52wHxX6pZYiz5LNHAdHocTx0UMYR13VKyW+5vUfJMmbjNaqRSba8Y84RaW7KJdlUd+EilU9YQodCwYLVNBnof9ViQPbPFQ3Qd1U/hMUejseOwZzRxu1NVXF+QVsTwatd9qxyRZbTBoKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TZ0RE2nADtMoA18d17QA2q4/y0tCaH4rxYObX0Nq1Q8=;
 b=122bU2C2YTKG4EUZ2gBlX9p5O6k4DwptWSjrrw6DJYET9M4NwS0iwGHBCVIqgw5SPuus5MKtn/cxdZRmbwR1oh/L30W0xvMmN9ehLIDcj0136G5+8blA1DnldVZNfRyzGBr+JRg+gdKgpqJbAxYZjdfT16Bqo995V2hvwThtDyw=
Received: from SJ0PR05CA0169.namprd05.prod.outlook.com (2603:10b6:a03:339::24)
 by CY5PR12MB6036.namprd12.prod.outlook.com (2603:10b6:930:2c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Thu, 29 May
 2025 10:03:22 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:a03:339:cafe::68) by SJ0PR05CA0169.outlook.office365.com
 (2603:10b6:a03:339::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Thu,
 29 May 2025 10:03:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 29 May 2025 10:03:21 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 29 May
 2025 05:03:20 -0500
Received: from hjbog-srdc-17.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 29 May 2025 05:03:12 -0500
From: Samuel Zhang <guoqing.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <victor.zhao@amd.com>, <haijun.chang@amd.com>, <guoqing.zhang@amd.com>,
 <Christian.Koenig@amd.com>, <Alexander.Deucher@amd.com>,
 <Owen.Zhang2@amd.com>, <Qing.Ma@amd.com>, <Lijo.Lazar@amd.com>,
 <Emily.Deng@amd.com>, Jiang Liu <gerry@linux.alibaba.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH v9 2/4] drm/amdgpu: update GPU addresses for SMU and PSP
Date: Thu, 29 May 2025 18:02:54 +0800
Message-ID: <20250529100256.754769-3-guoqing.zhang@amd.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250529100256.754769-1-guoqing.zhang@amd.com>
References: <20250529100256.754769-1-guoqing.zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB03.amd.com: guoqing.zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|CY5PR12MB6036:EE_
X-MS-Office365-Filtering-Correlation-Id: 71424d39-a66a-4d6c-13f2-08dd9e980b09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dy9XaHllYmdjOHovaU9HQlBmOUZVSlRGbE5EaEdLZFhhb0RZa2hHN09QTi96?=
 =?utf-8?B?dGhHYzhrWXdZd08wbUZ2ZTBUR01QUnRkcVBsdjFQZVdxWWJLWmNXOFk4NkdZ?=
 =?utf-8?B?WXJyR0JYTnVrQ3VQbzVNUG5QazVCNFNINGp6SGZPYkk0NlFNdS95UEQ0N2NF?=
 =?utf-8?B?YW1iUUFoS1FIYjZTaG5BOGdDcE13ZW1nb3VURkM2cm00c29tZGxwdmoyWjdo?=
 =?utf-8?B?R3phOHdid2pCVUpKUGljL2o5Ymsxb3loL0wrT1hwU3hXbkV1TXIwcnR5aTlE?=
 =?utf-8?B?SXJMSGxUQjVkMFlTeDZUVWh6cENRSDRJTW5uV0xpVVc1b2pDZXlVV2RIZnhH?=
 =?utf-8?B?TDcrSmFrYkVPclBjdnBoTS9ieFFHS1hwQjBDZU9iTUJwU2hTb3FnOFZ0MVU1?=
 =?utf-8?B?aVUxd3lQd0VBazBwa2NpSFNPV3J1d0cvMzlXU3dyQUh6Z1hTdUhNOTR4M1F2?=
 =?utf-8?B?UTJ1OUI3ZTRieEFrSGNWVEs4RjgrVU5tMzNJczZjYWkzUllvWW03Ky9BVVNO?=
 =?utf-8?B?R1orVDgvRHZBVHRLSy9KT3ZFT1YwZ0E1NWFlMTQ0U0hTVlFJemhBVWdYSGhW?=
 =?utf-8?B?SVMwWkplK0NMVVNJUW5sTDBkMTkvdStpWW9leW00Rkg0NVhyNFlXMEljUlRz?=
 =?utf-8?B?cFJIQ0o1S3FUUU13ajZvMkgrK1ZKQ2htcCsrNlVwMmhSSldpWW1rVktJOGpt?=
 =?utf-8?B?RTZWQy8wMktCeGpjdkdQQTR3UDZVYWc2QlVZaWNhUkhpMXFkemRXZzgxTnRh?=
 =?utf-8?B?WFI2Zyt3VW1GTm5nd1JBVGlJa1B6SXdUNXNLVHVGb1RJTzU2MHgyVGVzZldB?=
 =?utf-8?B?UUNFOVlsN2FPTzRPQllXNkI1Nzl5ZUJEK1lOcjF3bGFaTlBaZjIzcVV6d20y?=
 =?utf-8?B?ZHUwSEpuMG4xdnZGN1oxWGQ0alJKR3VHekwyQm85UHRvMmIxQmNKdlE4UXVX?=
 =?utf-8?B?KytZK09HQU9EbmZuUjRKK2tEdmoyNS9ZN3Y1R2xTVElIdThNaitKVVJoNENF?=
 =?utf-8?B?NitqZEF2RWF1U2hjaE82ZGVaL1BxZEdKeTRuamV5TnJtU2grazcvUkR4Qi84?=
 =?utf-8?B?SXhJb24xTUg0NHg5dGc4czFjb1NrdzhZV2NIWG5XMkNTczl2LzZHdFh5WHR4?=
 =?utf-8?B?TnVlY0pKTDlpd2s4RVdpcGxVWitvRmVZR0FtS1kvZUdlajhoVVF5V3FMU0No?=
 =?utf-8?B?dXdQd3c3M0NoQ3ZQdDVkWnVCUFJuSnJsYWp6emtlWEdDRmdYclk2Vm52SUk0?=
 =?utf-8?B?Y0Via2JaTGp0Mnc5MUQ5a0MzYWI3VHdEd09sdmZqUXo1aVZoMXMxM1RvTmxT?=
 =?utf-8?B?NmFuY0RBSkd0a0UwVHNvVWNJWmlaR25vQm5Dd203Z3NGeHd5cTZjSGVpYmhS?=
 =?utf-8?B?bVZqZ2Qwb1BMNWRsTFF3aGl6VjVhWUdIcjFHNHZKMFcrMGlpVE8rNzZxMTA3?=
 =?utf-8?B?SStYWkFDdCtycTliTDFkbUJaMFdYQXFRL3FRclVSNjZ0MFRrdS9wdnF6cm5R?=
 =?utf-8?B?STh2d3Q2bkIvZzdJVTB5ek9nWDREbVpjb0R5Wm4vZmRMeFFBaGdYYVVMRE53?=
 =?utf-8?B?ci90bDB1U0xYeTluYWdMWU8vTFREbDFqckdPRTNwcU81eStDajZNemh1UWRN?=
 =?utf-8?B?QUV1WTlsL2FYZkhBOEZpaVNnem5mZ0lUdUdOTGppdkdraXEwT3Q1SGNuckE4?=
 =?utf-8?B?VjRPTk9SdGdMSDA5aGtYQzFtU3RLWkJvRUxvaGZVeXNncDBPRWZ2TXRGOHpD?=
 =?utf-8?B?dzh0dWpsaDhhVkpLSEN6WGFBU0g5MExNTTRpK3JLL0dIYUFZMzNuQVpmbEFh?=
 =?utf-8?B?cDVvd1FadHQvMWZOYjBiVEFHMkE0NWpKRXVFVEhKbmFJUWZ6SlJGVzdzQzBP?=
 =?utf-8?B?c2pGUnQ2dFNpcTg4N28zTk4rWDdNVW45RG5zaWx2RERYUDRVWmxlL0dkM1pr?=
 =?utf-8?B?MytETDdQL2VWQmlDRXRBU1RPeDdpdzdGVEl6ZFMzejlMZkgrU0hXNnltYXRj?=
 =?utf-8?B?SmdEV3NSM3Z1ZG1UWDlOczlGeGc4bnEzcFdkbWo1dmh0bzF5NVZqbHVBejFn?=
 =?utf-8?Q?nHph0K?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 10:03:21.2574 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71424d39-a66a-4d6c-13f2-08dd9e980b09
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6036
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

