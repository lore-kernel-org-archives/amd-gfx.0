Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4062C3ABC3
	for <amd-gfx@archiver.kernel.org>; Mon, 12 May 2025 06:42:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9206910E2DB;
	Mon, 12 May 2025 06:42:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PYtg9Kp2";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2086.outbound.protection.outlook.com [40.107.100.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6B5010E2DB
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 May 2025 06:42:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c//kzphC7tHRq02pBHPUSHHF0+q3YUu3JUZMN26aaosBRafNm1H1ZrjSPk59WKKHco4A5DpavlNraCggr+4NenUu+MtQQyY082XmNU8OGXTiZVyBMS7wSRltPgVJ3Zko8mVi3+8dQYBMafJRWQxz8tDarAK3S5JuCcdDodU5c7OJ8y32bi9Tsra15wO3KLiKkgJQLH6DnrS8UasARiiX1vTiIPTMOXlMnDbR43E67chY+uJ9WP0NfcO7/oa/YEa3XHEm6tTFOHSBE3wY6a8dw6NprqXes7dNgNBA04AFhp1AuWAxYxqgcBTbLzavqAbjNk/E8Vjk0x5ikzkpfIisng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WlygrPFgynUPjkMlH7qzJ8Ba40OxUVXa19t1dxyBkF4=;
 b=RUIXGs0AUCEDKk8onVnTbBTIBPmeC+qi9AE0x0qZHgpO1+QQtLX+pOiSUf0FGpBNM477qowWQHG8gjhTR3XmGa1zKloFLkhd+3WWciIdM++oWfVShpSjqSr1UwpVrlVzEv1tY8Z7vylu/z28mCTLXcJQ+CeEnBgOWJw0BsPBSt56VCt8MhM4MZB4gk17e2RSrSRVdhn3m8Ht8fXgn/b0ZZ3UH7TOZUL5XDG0qPkL6gYKsM+VZUK4I+WQEzUbnFohYORzs0sIjp8mzJNLAR2tZtvvgn4++iOlQPkTcq8NJ9vblmMR/sGjFRZdVAp4G5fvoAiXpLbmKhKi5dBqMZ4L/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WlygrPFgynUPjkMlH7qzJ8Ba40OxUVXa19t1dxyBkF4=;
 b=PYtg9Kp2NILT2olrbhS1IQsxyC3p61eVkOMCtmr3VwBQzynRgfJCs/Wn/9iXLdFfAWXj3T7drCRj/ITMZ/zUVZI7NJe6B8EoDNwQvTTLI+oHI3P2S6loj3FHM28NXOkJ8hX8jvVCMmQcnfeV9/eGnTj2QhD5LPCn2FNZIvytKxw=
Received: from MN2PR20CA0043.namprd20.prod.outlook.com (2603:10b6:208:235::12)
 by SJ2PR12MB8847.namprd12.prod.outlook.com (2603:10b6:a03:546::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 06:42:17 +0000
Received: from BN2PEPF00004FBE.namprd04.prod.outlook.com
 (2603:10b6:208:235:cafe::87) by MN2PR20CA0043.outlook.office365.com
 (2603:10b6:208:235::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.26 via Frontend Transport; Mon,
 12 May 2025 06:42:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF00004FBE.mail.protection.outlook.com (10.167.243.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Mon, 12 May 2025 06:42:16 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 12 May
 2025 01:42:15 -0500
Received: from hjbog17.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 12 May 2025 01:42:13 -0500
From: Samuel Zhang <guoqing.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <victor.zhao@amd.com>, <haijun.chang@amd.com>, <guoqing.zhang@amd.com>,
 <Christian.Koenig@amd.com>, <Alexander.Deucher@amd.com>,
 <Owen.Zhang2@amd.com>, <Qing.Ma@amd.com>, Jiang Liu <gerry@linux.alibaba.com>
Subject: [PATCH v5 2/4] drm/amdgpu: update GPU addresses for SMU and PSP
Date: Mon, 12 May 2025 14:41:39 +0800
Message-ID: <20250512064141.387079-3-guoqing.zhang@amd.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250512064141.387079-1-guoqing.zhang@amd.com>
References: <20250512064141.387079-1-guoqing.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: guoqing.zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBE:EE_|SJ2PR12MB8847:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b34d400-ae46-4e8a-2acf-08dd912022ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?s24EGfM12X5XQWQnj47+J1A/7ZSnCkzxYoaUIyweUcfx+s7eNlxnNYq5IN08?=
 =?us-ascii?Q?vOHRHBk2QasNfyaE9/XuiwBlKhZmJ8Qu9Wjwsg26aevT2ITxAq1S1f8BpaiG?=
 =?us-ascii?Q?Gl8eD1H9imrodHh9NixdVO1Qwn6ANcI7aaSmm2DTjpjXfqw4JZiQAF20JMEO?=
 =?us-ascii?Q?rTmQGkbqCC3YIgiFdCLOctIcPCtyNBasuDtQB2ZGbFtbKB09ry8AA/tPVF6C?=
 =?us-ascii?Q?ipXDdBuqx12N80mem0jA+GkXXiICiS3xq/NETVnuekMluCTTpMXkgaI530Ww?=
 =?us-ascii?Q?k7QRpNQIPaUT1Dfej3c2ofH1/rWOiE3gNJZY22yza7QL40ckK5iaq5En2nyj?=
 =?us-ascii?Q?Hm8hrTdsf1469P6Zq64LLRNC8AWXeGKWHRC5EZEn8IrTfLP0SyZpkDb6HxaK?=
 =?us-ascii?Q?glngHPWP//dKoW1TEij/e+SDCctORqFZlCtj46UjTGKFxN1vcEx4kPaFeCUp?=
 =?us-ascii?Q?WkhgNQX+xL98u6pDa0kChyHfGWRXgEm3WfWbfic7cTBfnA71aKF1LbMcZ5ho?=
 =?us-ascii?Q?ruKvxg748HBKm65q56wyGkOlaO1abyk09QNaKoZYza/STqnJq2GmbmeczP1m?=
 =?us-ascii?Q?RTyKp5oSJiXf9vi/CYclXKmRaYpQ7nBFU/bHaBuwlWb86HRl5VnUTDvPIs9a?=
 =?us-ascii?Q?2fj2vflN5Pz5301OSwsJvOFG4u70wRVFNs37rYqhFZSkz2CcyyHfzHkT32Jj?=
 =?us-ascii?Q?UvR6ViyUXNtFdXTKFNvsUz8R58yH1G9lEvpx3Z0wj+sXzdUZ9iRszZZxd874?=
 =?us-ascii?Q?XJFjye25iul62yb/EolCFKvyF8zvvNCLyI5KSKJ9k3ZyWYahvijgXeUvHQfR?=
 =?us-ascii?Q?+ChjIQSrzN4lZo5+d2TaHT7GL0ehnS+e/jeDcuxlmznPKamHRL0DEDl1MITt?=
 =?us-ascii?Q?Q3k6FORUbYB0q4vQPfGbcQephVoh6StZH+LVhnbBzfPz3mOE3l4ksTJyCk4j?=
 =?us-ascii?Q?CRm7BYoVnZPEYfuKZSphtBy/ETdeD108JlD433NLGj6VXhIXYS0L7cOhvUkQ?=
 =?us-ascii?Q?N96L7kDaCqFPVgK1kI78a84pUuXXcGYPPjBK//KlYJCD14Sg+5eFVyKz0WqW?=
 =?us-ascii?Q?fVoeB9+TmLmR2S/JaIrcGPpUqvnLo3glhBrTDs7BZmj8YKYr8Z2bCP9TLscK?=
 =?us-ascii?Q?jS5FpuONI+KcIp7F9WyT4CUxQDUJDKl9gLGjkASq71B0+3bKWb1UT2vPeaQm?=
 =?us-ascii?Q?yWHovZt+xryYuDxy0VOd37ArMIulu0YfCmkfekRNuEx+BzH37kwUT8DugDK5?=
 =?us-ascii?Q?mYFUXW/0Vpf3MXdPDosRYzmxIMbYf8YTI1XsmnuVX6KSNaRs8VHCd8VoZaOt?=
 =?us-ascii?Q?V/QGUGlJD/zMg9D9YOb23lZzfvz+od85xhrr6QjiUdp3bEv5zGsyFyhxOrJf?=
 =?us-ascii?Q?AFJjSDMx5zKOgcz0aCswNr/9ggsMpULapvStm4qkcxFSzivW6AxewAhLdrMq?=
 =?us-ascii?Q?o2DoSzjRhKSyuWmS+Cu03mA5aY8R3W2Nal6VNxzRFXCkSuRrX8mXn4eN3UBh?=
 =?us-ascii?Q?lxvT5triQjpPKzbux34embyQJzWw+PNLPe0R?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 06:42:16.3659 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b34d400-ae46-4e8a-2acf-08dd912022ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8847
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 20 ++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    | 27 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c  |  3 +++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c  | 18 +++++++++++++++
 5 files changed, 69 insertions(+)

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
index e1e658a97b36..14271f62ca8e 100644
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
@@ -3976,6 +3999,8 @@ static ssize_t psp_usbc_pd_fw_sysfs_write(struct device *dev,
 	memcpy_toio(fw_pri_cpu_addr, usbc_pd_fw->data, usbc_pd_fw->size);
 
 	mutex_lock(&adev->psp.mutex);
+	if (amdgpu_virt_xgmi_migrate_enabled(adev))
+		fw_pri_mc_addr = amdgpu_bo_fb_aper_addr(fw_buf_bo);
 	ret = psp_load_usbc_pd_fw(&adev->psp, fw_pri_mc_addr);
 	mutex_unlock(&adev->psp.mutex);
 
@@ -4085,6 +4110,8 @@ static ssize_t amdgpu_psp_vbflash_read(struct file *filp, struct kobject *kobj,
 	memcpy_toio(fw_pri_cpu_addr, adev->psp.vbflash_tmp_buf, adev->psp.vbflash_image_size);
 
 	mutex_lock(&adev->psp.mutex);
+	if (amdgpu_virt_xgmi_migrate_enabled(adev))
+		fw_pri_mc_addr = amdgpu_bo_fb_aper_addr(fw_buf_bo);
 	ret = psp_update_spirom(&adev->psp, fw_pri_mc_addr);
 	mutex_unlock(&adev->psp.mutex);
 
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

