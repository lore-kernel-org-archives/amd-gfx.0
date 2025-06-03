Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 140C1C5B549
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Jun 2025 02:19:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9ED7510E1CC;
	Tue,  3 Jun 2025 02:19:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gilo9D8P";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 586DA10E1CC
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Jun 2025 02:19:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K1xJJkOA27FEMxwhinlt02QkrxaASDsHtj9lKVMJ7f6UCq8jHlPKtfH9mAFB0Wx/DMn8+UukT5vENpPfecz8MZxgKq8Tw5t2VAPUm2yiPVg/gK7z6EcGNTl4gCdVg/u4yj+ACARoMYHwlrom4guvYwT/YNoYwRTn/VmWzjV8lnT8CgxMoMyBi+Ge4Tz/9U6kcPn6G2C+WkI95zgXpgcnO9bVE859GlB9FxKIwT0CwWVgzofap/b51r3vaXKVVXDo3SxJ3WVHCh/JgTbPs/afeUCwqAFHcOx8J0LNICPwff/cLjBTDfVG4MO3VDkaEyKVDG6kl7q9gffJmjRnYhWnsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TZ0RE2nADtMoA18d17QA2q4/y0tCaH4rxYObX0Nq1Q8=;
 b=VrWp4RSg2HgICcJtn8/BzPBJQzyTsV/s+CnOQEktq6xJc2aP075fChtjQnrKuSwIE39CYRuve1SBJS2R7rv3mhV//9A84yNRHfPiAxTIRfTIVaB0tlgLSpZVtcrakOfQLTRGbhM8Oxmba3AuYel/d/6rpK+xffBC1WDC+jjASaBmmwQ5lOwdn6MfBeYefDG2dRlzle/04qXm4FAGVQv2MnjOJQN1DrU0aqn9SV30dGRaI48ISzIgCqNUtYHlptUTZe1gnBtM9RGoNxLoGKyFuRZJu5Nz7KIQQIT6SR/jqmwMP0EeEnh3R19WQAGvZueIe49xQmyFv3YTWoE0M3N5pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TZ0RE2nADtMoA18d17QA2q4/y0tCaH4rxYObX0Nq1Q8=;
 b=gilo9D8PS9SfVF8e4KMjWJ+Pw1/EWGd1D+uW24XR8fMAkxd8l+7mV/xj20EWzCJco6dHWRLcBtHAHYssy0h8vkVHYcZCLQMoU9sBAVVDPxvjZ5c2eh81Kzo88tYXCfSWeWDhiytuXh3UboA4Uev6bLyXw75+fl0eWom3Gwl3a/o=
Received: from CH2PR04CA0006.namprd04.prod.outlook.com (2603:10b6:610:52::16)
 by LV8PR12MB9208.namprd12.prod.outlook.com (2603:10b6:408:182::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.32; Tue, 3 Jun
 2025 02:19:39 +0000
Received: from CH2PEPF0000009B.namprd02.prod.outlook.com
 (2603:10b6:610:52:cafe::57) by CH2PR04CA0006.outlook.office365.com
 (2603:10b6:610:52::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Tue,
 3 Jun 2025 02:19:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF0000009B.mail.protection.outlook.com (10.167.244.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Tue, 3 Jun 2025 02:19:39 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Jun
 2025 21:19:38 -0500
Received: from hjbog-srdc-17.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 2 Jun 2025 21:19:31 -0500
From: Samuel Zhang <guoqing.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <victor.zhao@amd.com>, <haijun.chang@amd.com>, <guoqing.zhang@amd.com>,
 <Christian.Koenig@amd.com>, <Alexander.Deucher@amd.com>,
 <Owen.Zhang2@amd.com>, <Qing.Ma@amd.com>, <Lijo.Lazar@amd.com>,
 <Emily.Deng@amd.com>, Jiang Liu <gerry@linux.alibaba.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH v10 2/4] drm/amdgpu: update GPU addresses for SMU and PSP
Date: Tue, 3 Jun 2025 10:19:07 +0800
Message-ID: <20250603021909.841690-3-guoqing.zhang@amd.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250603021909.841690-1-guoqing.zhang@amd.com>
References: <20250603021909.841690-1-guoqing.zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB03.amd.com: guoqing.zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009B:EE_|LV8PR12MB9208:EE_
X-MS-Office365-Filtering-Correlation-Id: 91b78068-1e4e-4be9-e8ec-08dda24517ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bXRKZTdwOVNOc2lhZVI2ak1xbEZ6T05LSndHU2Z1Rkl6TTMzdFVPbzZTVTdy?=
 =?utf-8?B?Vm41S0xxbnpuUlZqU0ZRTkZsdGM1cmloT0s2dDdjY2VLdWxicjlHWFlDOHc4?=
 =?utf-8?B?NjNmU2dyZXkzWWpMUUtPenQ1SVZaNG9YL3dlRWVyM0tnMlMxYUxNQ2lGMGRR?=
 =?utf-8?B?WUNGeUJxSDM1NzVpQTFhS1JCUDFabHRRUnI5ZnpxMWhJUFJiNkx2blYwbGQ5?=
 =?utf-8?B?ZDltY3JQUFhubkg1UTBBc0FZczIvMzBuK09BTEw1Wkt3cmhXNzZ1eGlQQ2tJ?=
 =?utf-8?B?YjFleFhDZjRHOFFyOFFMWlZ5NG1FVmcranJkN1Y0T2Jnb2huRjY2SXVRc2dF?=
 =?utf-8?B?V1ZDQWIxdjdhMGNtMkpMRGpEV0lVTDFxZ2dLais1REcyNlNEYkxFdzVuSVNW?=
 =?utf-8?B?MHNGVkU2elduUHEreEJZRUQxd2JXK1lMemR2d2QrTzAyczVXZCtGbDdNYlBz?=
 =?utf-8?B?RmpnZk9pV0VhZWdZc2hxaVdXNWJKWGVFSFpUczJPRTVaMlJRYVZCQmJHWklo?=
 =?utf-8?B?UHN2UTg4ays4QUtaamErcWoza2RadUNyQUYxd0ROMWF3emY4SDZXdDdCZ2ti?=
 =?utf-8?B?RWI1Q1JWUE1QbGdZQXJSa0hmRERwUFFpS0hmSW1CZHM5d0l4THJhL3h3WFZU?=
 =?utf-8?B?a1dDdTVjMWFpY0xQalE2eFk5MjlzaWJRRFFpRC93SmpubU9JS0x6K0drY3RY?=
 =?utf-8?B?WlJBMFo4cnJ0b2lWQkx2cWluRmUwRmduMW5XT0NmSFkva2cwdEdiUjUvS09n?=
 =?utf-8?B?cXYzRzlUbzVWS253eHRlTSsvY3FVZGF5ME45ejA2cjVDUTlkSTdETXc3Z0FD?=
 =?utf-8?B?TVRJQk9OWnNXaUtLSzA3eUJtYmdpcU5ERmNHbHB4UnNyZVQ5SWtBdFVVMFlW?=
 =?utf-8?B?MnBqZE0vdk5sekEzUHlRWXpzaGM4aUpnbjNlQy96YklsdXV1eE9YVmlqVHF3?=
 =?utf-8?B?RUZpNXpGdTVXTU5vRGYyc0pvbkpkRDJzRlFpMlk3azA3YWlMbkhGa2dEdXBm?=
 =?utf-8?B?cHpqUXFjWmtqMVoydGZxcGMzczlzTnJzN1lWNW9BVzdCSlNyUndobklzUmNa?=
 =?utf-8?B?R0VqQjJUNmpWRXN4SkVER085ZGg4QmlJaVpKZ05UeFE1b2poY1gwQzVCc05l?=
 =?utf-8?B?MGF2b1RyWXdRUEx1LzBkTUovMTdGNjM0U0JWaTMyakFXQVBvdnp1SUY0Uk9D?=
 =?utf-8?B?UW1NWFRxcDRONSt1UmpEL3E3dXgvOEUrTTBsRFJvN3dmVG8wN1pmSnN4VjU1?=
 =?utf-8?B?K201b0tUSXNhOXd3YmhSZFVOek9uTk92dzkvMnZEakxNV0R1dS9udzd5V1NK?=
 =?utf-8?B?SDc1cTBRT0IvbHE3NjJWdUVhZUpkYXQ2TjE3cDFJdTdyemNkVVIvNXl6ZnRF?=
 =?utf-8?B?akUwVVJYMFJIZUFHM3FTWlJ3WVI2QlM4b0pxeHBPR21SY0M2QlpsTldzUUIr?=
 =?utf-8?B?eXF4R2ZDczNKMWdDZEpCNi9pRDhZK1d4eW90NDFJdnYrUTNrYW1rU2pqL2ZG?=
 =?utf-8?B?NllpOHQ5N1B1Z000Zzd2VVpqVzNhUmZnS1RybHZXQ0ZVVzd4dXM1YWFHeW0v?=
 =?utf-8?B?Rm1nL2daMzBRMVpTS0VSM2doby9qY0pYU0hWODZ6K2pXTHhYYnZ3ejE5eUxo?=
 =?utf-8?B?Y3J5cHczY3VCeC9NZkdDL0NJMm5lOXpHZUNSQUpOU3ZneTZYZWU1azRoMXlS?=
 =?utf-8?B?MTRjVFJlSm9sdythZUhWeWtUYm9EL0dkd3BzUlNXWEpGRTduQlJNMVBzQlY3?=
 =?utf-8?B?MDhJa1RMWXEzZVZ6S0h3Y2dNYjlYcmNBMXp1UldZSXp3aUNtRTBoOFVYVWtG?=
 =?utf-8?B?M09CYmQ2L0lld2t3ZDBnLzg1TjF3RmQrSmk5Q0s1bUNubnZKQW54TTRTRDVZ?=
 =?utf-8?B?SmlEOTZ4QjdHUUFYRnFoaUI0TXphQTZ1QVVEbzZNTDlIZkkwVTNoN1F4WE5a?=
 =?utf-8?B?ZVI2QzlnWGNLUW5HZ2ovMVBvTlBQUnI1RUJMSWhCOGVtNzNWYVBEVWppVnlS?=
 =?utf-8?B?R1FXdFF1aVVmWkJoWlI5R2FoWlFad2FaR0t0WHdGa3RPOTBPT2Yrdld3LzE3?=
 =?utf-8?Q?rekcst?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 02:19:39.3896 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91b78068-1e4e-4be9-e8ec-08dda24517ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9208
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

