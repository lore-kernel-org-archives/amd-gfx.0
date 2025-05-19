Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 679EEC2D0CD
	for <amd-gfx@archiver.kernel.org>; Mon, 19 May 2025 08:22:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09A3210E211;
	Mon, 19 May 2025 08:22:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wz2vc1vd";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D4D010E211
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 May 2025 08:22:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r2t8oRTbJUKW5Ak+0A4FWviBwqAf/4zYcb90JCbKMSgcVxEUnV+e8XhwZ283hF/fdL4H6WBXUOaKZkrzLmIyn3HcHtI/IVfakQY8S67+KHaUa9ciqROsPQONgxY50kWgbqA7tAnoJOKyqBBpe2AAuq017gHF2Il2rAbIvaGilMyqs2WgYxSQuGvvEoi2aGkDZ8BqHRLHAlGeQmXlbkwSgUWxXla9JWyzRbqz1bU1fyLyuKIkgVl1Ahdhytd090dV7zYW+RZxV1LBjGA9K6rEggGo7LsKHqyBYX09pElijYbOn8RmgMNjKvPp6JS/Id7NUZMM7f2fmHAAwHZ2rgmnQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zPCbPHDvEXhvSWbqtcdfoWd5mL+45zcouP60FP5XVzo=;
 b=yrjfSnLpsQfZvwFs1+vG7iZChqI44xl6N0HgVGa+H3ed3PnT9F8dTchLq5PzMuffyPGM+0ASmgoUWruiJArzRE40Onb3rwYG1Mq9o5KSn5JNEeOMi6pTdwqf+A0v+Cw5f7ZzYilQx18UXVUNNAHUHqvIBNoOz97DegEsh5wuAE8i1yz5p2jsLOtdDqip7hGNK/HlIRNVgkSArXbWKokrBF59eh/1RgGBcn3tOLF4GXvCamrlhjlXI8iudZocwlw28exuuwYi+CjUcahE5BAq3xhuP4nUKXOgzW3rCM2y7LOwsv7gMlfSxqCRYMCY9Y2yuQZKzj/gvOnDWVYzarknEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zPCbPHDvEXhvSWbqtcdfoWd5mL+45zcouP60FP5XVzo=;
 b=wz2vc1vdwXt+Irs88RXDelnKnhGOXlq5gJRaa53cFY6xEIR39TaYzkB2hdmIz9Zau7GiQsNHTVsqlBigFZrFFrZUZ5O/DDZsfQ2h9GGj8NQKVSyFNpYha3G3+xNiRn7TcjI1pr97BIEcx1nyjCxMVg76Gt8SKMITiB4rrIqUvuw=
Received: from BY3PR05CA0026.namprd05.prod.outlook.com (2603:10b6:a03:254::31)
 by DM6PR12MB4217.namprd12.prod.outlook.com (2603:10b6:5:219::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 08:22:16 +0000
Received: from SJ5PEPF000001CE.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::6f) by BY3PR05CA0026.outlook.office365.com
 (2603:10b6:a03:254::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.13 via Frontend Transport; Mon,
 19 May 2025 08:22:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CE.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Mon, 19 May 2025 08:22:16 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 19 May
 2025 03:22:12 -0500
Received: from hjbog-srdc-17.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 19 May 2025 03:22:10 -0500
From: Samuel Zhang <guoqing.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <victor.zhao@amd.com>, <haijun.chang@amd.com>, <guoqing.zhang@amd.com>,
 <Christian.Koenig@amd.com>, <Alexander.Deucher@amd.com>,
 <Owen.Zhang2@amd.com>, <Qing.Ma@amd.com>, <Lijo.Lazar@amd.com>, Jiang Liu
 <gerry@linux.alibaba.com>
Subject: [PATCH v6 2/4] drm/amdgpu: update GPU addresses for SMU and PSP
Date: Mon, 19 May 2025 16:20:36 +0800
Message-ID: <20250519082038.21459-3-guoqing.zhang@amd.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250519082038.21459-1-guoqing.zhang@amd.com>
References: <20250519082038.21459-1-guoqing.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: guoqing.zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CE:EE_|DM6PR12MB4217:EE_
X-MS-Office365-Filtering-Correlation-Id: 98bc4170-c73e-427c-4871-08dd96ae43bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Oemn216bMkEJjC7tNbdC0dDesmjS0n3vzbKAVxzYiV97aN8CzkKYnRqOcKLo?=
 =?us-ascii?Q?eak0nvPOPGQK9t1A0ORFMPYw5TuxRCbEWuiE8NlvLLOYsUu2LIZf42tfJz++?=
 =?us-ascii?Q?vGYe0yoXUVHlygfNVdWgDgjS8DZbbmLOKG60LA/iBXOSYS11qsonYu3MovXn?=
 =?us-ascii?Q?8TWrTxNEesu8difEAkI6wJUyHWxVgTZgems+s6fW9wAR1wJxd+BxfREauXhf?=
 =?us-ascii?Q?yvq61Owa2nsS+IABsu7zZVrbdHeGaFHqquYOe1XGothQ7IDDS6r+JxxmD8qc?=
 =?us-ascii?Q?4LIzld9Zn5wYl+zgTWzollSaHnjvlIeb7X2bAaV3JN1w7NeNVhacqPNy+2y9?=
 =?us-ascii?Q?Vhtn1XZMCRTHSyrRT3FQPbBGBmkAJRBBSb8/yMIIZYvRZpMeezQOyFrdMPXp?=
 =?us-ascii?Q?raCmAg/guixlXtHHIgOnejnhlE+CUztgQhwxFc3KCV5gxSScd0HuftWivXi4?=
 =?us-ascii?Q?5E1HW7baAh5SS2rjFnTWCRtHgjWR1s+4dwysGz7yLhYxTvO+BVy0DKkJv+YC?=
 =?us-ascii?Q?GrKapetqv/YDXLMc7EmRP6DK5TmKDv1OPGi4R5fLk+vTQf+95hDlGWkIcpOD?=
 =?us-ascii?Q?2I2F54bbmYRpKguGpHoTuX7/DXDTpd1qLKrSjDV2gRe2IJc9WtWrIbDEgOJt?=
 =?us-ascii?Q?8GYz/zMoL6fW6CX304EbO6wg79GSHnht4Br4KRcsitztjmCUth3GY2m8FNEc?=
 =?us-ascii?Q?hbJwVpxI0DpJr0W/ObC54i7Np11nUP/P60HfY4Kn8gjyU7oy3p/HlElIUiBR?=
 =?us-ascii?Q?/M030QN2OszeE8QZUX8nDNw6PzQeLmOcg5FBOxBn2ajb1ZnW9rfXJqLYOYG3?=
 =?us-ascii?Q?YOIapDWaKs2d2xaw6ADYGG8u1CNSS8Y0aLP+2YzvEVwurnvYRaqpBX8Ew8mi?=
 =?us-ascii?Q?wSK8SG3uSP1R9RMz0LF/wOL7g/HTZdL8S5XQor6Voz+ww+AlaNDsuy+gfKNH?=
 =?us-ascii?Q?cCftHWAcs/dw1wlsZa2rOqcNptyq+uaM69GwnRUTdP003VSc/dYeL4uNop0I?=
 =?us-ascii?Q?XwFnYoiQ2N/W/BMqNCK2Yai4Li+ZuawDQDHLY8n542kwlVfDkm8CVxvOwbhq?=
 =?us-ascii?Q?8pjkg2UU7bN71ezhkYFEhgzrTInBUWxSLXVHy+fgT5xCsvAIEg8XJjijnaPU?=
 =?us-ascii?Q?8mNUcKXgnJ8WN+r/LUUOdDDXZ8smuKemsjhdIjQGZkWMgGVE43/f13hn6V+U?=
 =?us-ascii?Q?Z4g+kQl33fOUQOsiePhyPDxxmxAP9iqMvWuYfGNYtdG10KeqaOME06WF6uht?=
 =?us-ascii?Q?B1hwRbshPofawZ9iwDG7G7hUJQLK0Fs7yygYSFsSc700t8jRcJ3EAr844u2i?=
 =?us-ascii?Q?Kuhy5mrBnPiA/NA8auWgFBEXIPGMVSRBklMOOwWqmZy+T885a+GuoeIOv5Ef?=
 =?us-ascii?Q?nPlRY2hMLCqD16xKWfarYNoXh8Xj42PrdS45bShpNmwPJ5dlshLTw0xJcv2E?=
 =?us-ascii?Q?YpuQ+faoiVs7pP5PNCB44vmZfAsuYvdSvlUsLhcN4hEmti467cOq1hRjbM5z?=
 =?us-ascii?Q?sOFRRoPO3nSGrqgA6M+mBW6JRdfnJ1bHU7v7?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 08:22:16.0134 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98bc4170-c73e-427c-4871-08dd96ae43bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4217
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

