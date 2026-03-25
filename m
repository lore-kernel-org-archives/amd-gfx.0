Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66CFD106B53F
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2026 14:13:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06ECA10E844;
	Wed, 25 Mar 2026 14:13:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QNtITTxM";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010006.outbound.protection.outlook.com [52.101.85.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30E2510E843
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2026 14:13:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZdJZinZ4lAdM+AMxxmxSu+y8VvRJN3WnzxoK+vMhppecBzdt27LbYv5uhak8t6Pa5lIldBL26dGH2mIaiK8U6oGs6QdPrXbvDmX/EPgbziDJgLn7q8gwy4gFT3PFjKo+ZQnFDVxOyapaFU5wrZdu2Q4jCzWKh2p/2/eGsSWowPcfmKj54PVF5UomrMuqRIhjUc/Kzx1Z3HSJwt+pBaernWzYH3K1JC5xkzfrUpKatEumnpj1dCzGWlNQCbzK7YEsR6Lg0CEYg0Qzz+eT3Ed0+7ppA8KYqoUHhQf2SVHS+0TJT4NwdllmTcHvb90VMIxQ3fqCl4DXSQqZ9hqLFXERBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QXPZO1+4Vuzn2cOimEw1KLUxQabOinTR0pqh06SChbY=;
 b=rqRATWPxam2zzZD4zSDTmBpop3ulB0d3zTJXkZq7BKVBlG1GOpNduwih6V49MWtNgNK3mSYC0/x3lgxoGJ7fdp9UMNOmDpHYVE5e/s7Z6Nw3Akx8OaItSeGfExiGcJtUSyg4mBsHO2qI1ODkMxr8yeGfb8YQzEDO4x6D1yI3kCYdwrRceTHogymyN1OEoBVzlFyVLU9CyND3Ynocwz8mjvbFU3Yc17J0UEVwHXShlP0sPXeuOg3xVlsHnAft6j8XCFo6iaaaJTj+iLV709302Sd4YlyHwuz6vk7ypAWFzuAQX8KC7ETfD2Xz6trFKJCj8PLaZ5hoE+OFt1hbvIymNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QXPZO1+4Vuzn2cOimEw1KLUxQabOinTR0pqh06SChbY=;
 b=QNtITTxMyoXpxissebvAyF5RWgercoZVLzu/R52kK37Eyalx6am8RxiU2OLKS/pV2zJbRuRP8eUE88mj88ecfv+wZXXV1NEcbeFX5kBzDs5RYIaTJ7IIphVBLDDDRbveilBgTexxmHpXnTi9AdOJgh/+9TmnYNmNpIG25LRrDe0=
Received: from SJ0PR03CA0364.namprd03.prod.outlook.com (2603:10b6:a03:3a1::9)
 by DS0PR12MB8788.namprd12.prod.outlook.com (2603:10b6:8:14f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 14:13:09 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::f9) by SJ0PR03CA0364.outlook.office365.com
 (2603:10b6:a03:3a1::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Wed,
 25 Mar 2026 14:13:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 25 Mar 2026 14:13:09 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Mar
 2026 09:12:59 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <Feifei.Xu@amd.com>
Subject: [PATCH 7/9] drm/amdgpu: Add fw vram usage reserve-region
Date: Wed, 25 Mar 2026 19:42:24 +0530
Message-ID: <20260325141226.1173216-7-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260325141226.1173216-1-lijo.lazar@amd.com>
References: <20260325141226.1173216-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|DS0PR12MB8788:EE_
X-MS-Office365-Filtering-Correlation-Id: 18345062-2723-4cf3-f247-08de8a78a478
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: AOBcc8/ozfnWDDnFT4vI8zVfvobR1T2kwIFnjcWwzOGu6NFEnVE3E4wEMMYvTUmPRPQqLFPPT9vr2bPBsEGpHj1cmaM4RpjvIZY5KOABdXxfVc9Apryj9WsvyOdw3rSe/WwfcqdDokWWqOz+18iGBcbIwYp86ViRjW28w7aK6TzR4tcNSbDZu52wvXmGGuRqW2odP0MOwi1Rs0AxdwFilI+o9J7nWMhHHjIPWtuCX5rGpm+upJ0xdxNbmhGUebx4ZzBRL0QTtIMDJstgsAMWFMkaQRqDitq78rDwhKf/Z/40K4awOO9q+bZcig+Rebf/thh+s6LN/ddF0BZEnHJbKlAeI5aT0EOaGqkzDf3uiRrAilQhEFTwJL9y51gXXg5pTyjlZM/X9qtEpJt1HNWyZk/dI+hoHJM0j64sqKr/pJdrg+blxAfTKsOqnunI7f6EJDnOfBkYxqF2vWcSf+3bzVw9eXrLGtQ9B3TDTSuMJG9xgW25phfgoZxpOYTbOGiNyGEY4j9cRvVAUgV7fS99X1AtnS1iBACvh5bhgXqCSpY/pvuSQuxETZuXo5+12B2adkbfDBo7rF7RT3Rt+B1r4xWogeeF954p+vhEXfIVYewFcQ7+WD+QMx5p1lcam9ioM9ahquWrYk4RW8oBSYK0atkavwa/Tpx/Y7eKYA5cHuWHbRmGR6KoQqMwCWG3JfbyaqL7SSBy/8eH8MYS1GbpHucn37GN8i+Bras2AFZkz4CsCosT7XAUhLU1b62kLEiNNyjvF+mbdDvCAj1laA/4NQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sGVIWYwvhGEIkTykc6TS8WcHynCWDypnDsxbIbV2PuNsbQGL4jY02+mDAT/535kyZUTRsbZRq/Alkp7yaG//1CvmCmHRPcGu+DEiCjGWaUmTQtZhdbAM2j9f6nreCfjqwTmve20yPr+OEMlVwaQYL1Kt04i957k6IeiDuZsDEk1G+HuAGVXPqgykNfklJ4hTFBT6l38k0lyVaBdaMGDr7CHRADgvEuJJ65m/0tbwmEVl0THK8mvvEj7ePuFMtC098oR6EKCjVaKkknx4bqV1iw/mdkPywpBhbRZcGk/SL66UxDjGwbs50imTrnArLeaR7D7Rfz+TSX2Cp+HRJVxRR8cC2nmGBDFMhYMlkadHQZxQI5ONQ1IRjy6zR7v1uZCKyU4lROFeR5ujvzEcrjXJj52BJqx+eacf8aU7ODQCkXpeuGGuFTjhV1JKfrrpKeh2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 14:13:09.1846 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18345062-2723-4cf3-f247-08de8a78a478
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8788
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

Use reserve region helpers for initializing/reserving firmware usage
region in virtualized environments.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c  |  6 +--
 .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  | 12 ++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 54 ++++---------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |  6 ---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      | 39 +++++++-------
 .../drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c |  8 +--
 6 files changed, 41 insertions(+), 84 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
index 763f2b8dcf13..956eb33008f8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
@@ -1685,9 +1685,9 @@ static int amdgpu_atombios_allocate_fb_scratch(struct amdgpu_device *adev)
 			(uint32_t)(ATOM_VRAM_BLOCK_SRIOV_MSG_SHARE_RESERVATION <<
 			ATOM_VRAM_OPERATION_FLAGS_SHIFT)) {
 			/* Firmware request VRAM reservation for SR-IOV */
-			adev->mman.fw_vram_usage_start_offset = (start_addr &
-				(~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
-			adev->mman.fw_vram_usage_size = size << 10;
+			amdgpu_ttm_init_vram_resv(adev, AMDGPU_RESV_FW_VRAM_USAGE,
+					  (start_addr & (~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10,
+					  size << 10, true);
 			/* Use the default scratch size */
 			usage_bytes = 0;
 		} else {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
index 7f4751e5caaf..36e1f6b65075 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -120,9 +120,9 @@ static int amdgpu_atomfirmware_allocate_fb_v2_1(struct amdgpu_device *adev,
 		(u32)(ATOM_VRAM_BLOCK_SRIOV_MSG_SHARE_RESERVATION <<
 		ATOM_VRAM_OPERATION_FLAGS_SHIFT)) {
 		/* Firmware request VRAM reservation for SR-IOV */
-		adev->mman.fw_vram_usage_start_offset = (start_addr &
-			(~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
-		adev->mman.fw_vram_usage_size = fw_size << 10;
+		amdgpu_ttm_init_vram_resv(adev, AMDGPU_RESV_FW_VRAM_USAGE,
+				  (start_addr & (~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10,
+				  fw_size << 10, true);
 		/* Use the default scratch size */
 		*usage_bytes = 0;
 	} else {
@@ -152,9 +152,9 @@ static int amdgpu_atomfirmware_allocate_fb_v2_2(struct amdgpu_device *adev,
 	    ((fw_start_addr & (ATOM_VRAM_BLOCK_NEEDS_NO_RESERVATION <<
 		ATOM_VRAM_OPERATION_FLAGS_SHIFT)) == 0)) {
 		/* Firmware request VRAM reservation for SR-IOV */
-		adev->mman.fw_vram_usage_start_offset = (fw_start_addr &
-			(~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
-		adev->mman.fw_vram_usage_size = fw_size << 10;
+		amdgpu_ttm_init_vram_resv(adev, AMDGPU_RESV_FW_VRAM_USAGE,
+				  (fw_start_addr & (~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10,
+				  fw_size << 10, true);
 	}
 
 	if (amdgpu_sriov_vf(adev) &&
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 0dde3fbfba59..674ceb24f93a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1735,22 +1735,6 @@ void amdgpu_ttm_unreserve_vram(struct amdgpu_device *adev,
 	memset(resv, 0, sizeof(*resv));
 }
 
-/*
- * Firmware Reservation functions
- */
-/**
- * amdgpu_ttm_fw_reserve_vram_fini - free fw reserved vram
- *
- * @adev: amdgpu_device pointer
- *
- * free fw reserved vram if it has been reserved.
- */
-static void amdgpu_ttm_fw_reserve_vram_fini(struct amdgpu_device *adev)
-{
-	amdgpu_bo_free_kernel(&adev->mman.fw_vram_usage_reserved_bo,
-		NULL, &adev->mman.fw_vram_usage_va);
-}
-
 /*
  * Driver Reservation functions
  */
@@ -1768,31 +1752,6 @@ static void amdgpu_ttm_drv_reserve_vram_fini(struct amdgpu_device *adev)
 						  &adev->mman.drv_vram_usage_va);
 }
 
-/**
- * amdgpu_ttm_fw_reserve_vram_init - create bo vram reservation from fw
- *
- * @adev: amdgpu_device pointer
- *
- * create bo vram reservation from fw.
- */
-static int amdgpu_ttm_fw_reserve_vram_init(struct amdgpu_device *adev)
-{
-	uint64_t vram_size = adev->gmc.visible_vram_size;
-
-	adev->mman.fw_vram_usage_va = NULL;
-	adev->mman.fw_vram_usage_reserved_bo = NULL;
-
-	if (adev->mman.fw_vram_usage_size == 0 ||
-	    adev->mman.fw_vram_usage_size > vram_size)
-		return 0;
-
-	return amdgpu_bo_create_kernel_at(adev,
-					  adev->mman.fw_vram_usage_start_offset,
-					  adev->mman.fw_vram_usage_size,
-					  &adev->mman.fw_vram_usage_reserved_bo,
-					  &adev->mman.fw_vram_usage_va);
-}
-
 /**
  * amdgpu_ttm_drv_reserve_vram_init - create bo vram reservation from driver
  *
@@ -2183,9 +2142,14 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 	 *The reserved vram for firmware must be pinned to the specified
 	 *place on the VRAM, so reserve it early.
 	 */
-	r = amdgpu_ttm_fw_reserve_vram_init(adev);
-	if (r)
-		return r;
+	if (adev->mman.resv_region[AMDGPU_RESV_FW_VRAM_USAGE].size >
+	    adev->gmc.visible_vram_size) {
+		adev->mman.resv_region[AMDGPU_RESV_FW_VRAM_USAGE].size = 0;
+	} else {
+		r = amdgpu_ttm_reserve_vram(adev, AMDGPU_RESV_FW_VRAM_USAGE);
+		if (r)
+			return r;
+	}
 
 	/*
 	 * The reserved VRAM for the driver must be pinned to a specific
@@ -2348,7 +2312,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
 					&adev->mman.sdma_access_ptr);
 
 	amdgpu_ttm_free_mmio_remap_bo(adev);
-	amdgpu_ttm_fw_reserve_vram_fini(adev);
+	amdgpu_ttm_unreserve_vram(adev, AMDGPU_RESV_FW_VRAM_USAGE);
 	amdgpu_ttm_drv_reserve_vram_fini(adev);
 
 	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index eaa26cda5780..df46f43e578c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -101,12 +101,6 @@ struct amdgpu_mman {
 
 	bool			keep_stolen_vga_memory;
 
-	/* firmware VRAM reservation */
-	u64		fw_vram_usage_start_offset;
-	u64		fw_vram_usage_size;
-	struct amdgpu_bo	*fw_vram_usage_reserved_bo;
-	void		*fw_vram_usage_va;
-
 	/* driver VRAM reservation */
 	u64		drv_vram_usage_start_offset;
 	u64		drv_vram_usage_size;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index c8e4c6e356aa..e9b8c08051f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -437,12 +437,8 @@ static void amdgpu_virt_add_bad_page(struct amdgpu_device *adev,
 	struct eeprom_table_record bp;
 	uint64_t retired_page;
 	uint32_t bp_idx, bp_cnt;
-	void *vram_usage_va = NULL;
-
-	if (adev->mman.fw_vram_usage_va)
-		vram_usage_va = adev->mman.fw_vram_usage_va;
-	else
-		vram_usage_va = adev->mman.drv_vram_usage_va;
+	void *fw_va = adev->mman.resv_region[AMDGPU_RESV_FW_VRAM_USAGE].cpu_addr;
+	void *vram_usage_va = fw_va ? fw_va : adev->mman.drv_vram_usage_va;
 
 	memset(&bp, 0, sizeof(bp));
 
@@ -710,15 +706,16 @@ void amdgpu_virt_fini_data_exchange(struct amdgpu_device *adev)
 void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev)
 {
 	uint32_t *pfvf_data = NULL;
+	void *fw_va = adev->mman.resv_region[AMDGPU_RESV_FW_VRAM_USAGE].cpu_addr;
 
 	adev->virt.fw_reserve.p_pf2vf = NULL;
 	adev->virt.fw_reserve.p_vf2pf = NULL;
 	adev->virt.vf2pf_update_interval_ms = 0;
 	adev->virt.vf2pf_update_retry_cnt = 0;
 
-	if (adev->mman.fw_vram_usage_va && adev->mman.drv_vram_usage_va) {
+	if (fw_va && adev->mman.drv_vram_usage_va) {
 		dev_warn(adev->dev, "Currently fw_vram and drv_vram should not have values at the same time!");
-	} else if (adev->mman.fw_vram_usage_va || adev->mman.drv_vram_usage_va) {
+	} else if (fw_va || adev->mman.drv_vram_usage_va) {
 		/* go through this logic in ip_init and reset to init workqueue*/
 		amdgpu_virt_exchange_data(adev);
 
@@ -763,31 +760,32 @@ void amdgpu_virt_exchange_data(struct amdgpu_device *adev)
 	uint64_t bp_block_offset = 0;
 	uint32_t bp_block_size = 0;
 	struct amd_sriov_msg_pf2vf_info *pf2vf_v2 = NULL;
+	void *fw_va = adev->mman.resv_region[AMDGPU_RESV_FW_VRAM_USAGE].cpu_addr;
 
-	if (adev->mman.fw_vram_usage_va || adev->mman.drv_vram_usage_va) {
-		if (adev->mman.fw_vram_usage_va) {
+	if (fw_va || adev->mman.drv_vram_usage_va) {
+		if (fw_va) {
 			if (adev->virt.req_init_data_ver == GPU_CRIT_REGION_V2) {
 				adev->virt.fw_reserve.p_pf2vf =
 					(struct amd_sriov_msg_pf2vf_info_header *)
-					(adev->mman.fw_vram_usage_va +
+					(fw_va +
 					adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID].offset);
 				adev->virt.fw_reserve.p_vf2pf =
 					(struct amd_sriov_msg_vf2pf_info_header *)
-					(adev->mman.fw_vram_usage_va +
+					(fw_va +
 					adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID].offset +
 					(AMD_SRIOV_MSG_SIZE_KB << 10));
 				adev->virt.fw_reserve.ras_telemetry =
-					(adev->mman.fw_vram_usage_va +
+					(fw_va +
 					adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_RAS_TELEMETRY_TABLE_ID].offset);
 			} else {
 				adev->virt.fw_reserve.p_pf2vf =
 					(struct amd_sriov_msg_pf2vf_info_header *)
-					(adev->mman.fw_vram_usage_va + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB_V1 << 10));
+					(fw_va + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB_V1 << 10));
 				adev->virt.fw_reserve.p_vf2pf =
 					(struct amd_sriov_msg_vf2pf_info_header *)
-					(adev->mman.fw_vram_usage_va + (AMD_SRIOV_MSG_VF2PF_OFFSET_KB_V1 << 10));
+					(fw_va + (AMD_SRIOV_MSG_VF2PF_OFFSET_KB_V1 << 10));
 				adev->virt.fw_reserve.ras_telemetry =
-					(adev->mman.fw_vram_usage_va + (AMD_SRIOV_MSG_RAS_TELEMETRY_OFFSET_KB_V1 << 10));
+					(fw_va + (AMD_SRIOV_MSG_RAS_TELEMETRY_OFFSET_KB_V1 << 10));
 			}
 		} else if (adev->mman.drv_vram_usage_va) {
 			adev->virt.fw_reserve.p_pf2vf =
@@ -1081,13 +1079,14 @@ int amdgpu_virt_init_critical_region(struct amdgpu_device *adev)
 	}
 
 	/* reserved memory starts from crit region base offset with the size of 5MB */
-	adev->mman.fw_vram_usage_start_offset = adev->virt.crit_regn.offset;
-	adev->mman.fw_vram_usage_size = adev->virt.crit_regn.size_kb << 10;
+	amdgpu_ttm_init_vram_resv(adev, AMDGPU_RESV_FW_VRAM_USAGE,
+				  adev->virt.crit_regn.offset,
+				  adev->virt.crit_regn.size_kb << 10, true);
 	dev_info(adev->dev,
 		"critical region v%d requested to reserve memory start at %08llx with %llu KB.\n",
 			init_data_hdr->version,
-			adev->mman.fw_vram_usage_start_offset,
-			adev->mman.fw_vram_usage_size >> 10);
+			adev->mman.resv_region[AMDGPU_RESV_FW_VRAM_USAGE].offset,
+			adev->mman.resv_region[AMDGPU_RESV_FW_VRAM_USAGE].size >> 10);
 
 	adev->virt.is_dynamic_crit_regn_enabled = true;
 
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
index 81553230dca4..1a640b76c988 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
@@ -36,17 +36,17 @@ static int amdgpu_virt_ras_get_cmd_shared_mem(struct ras_core_context *ras_core,
 	struct amdgpu_device *adev = ras_core->dev;
 	struct amdsriov_ras_telemetry *ras_telemetry_cpu;
 	struct amdsriov_ras_telemetry *ras_telemetry_gpu;
+	void *fw_va = adev->mman.resv_region[AMDGPU_RESV_FW_VRAM_USAGE].cpu_addr;
 	uint64_t fw_vram_usage_start_offset = 0;
 	uint64_t ras_telemetry_offset = 0;
 
 	if (!adev->virt.fw_reserve.ras_telemetry)
 		return -EINVAL;
 
-	if (adev->mman.fw_vram_usage_va &&
-	    adev->mman.fw_vram_usage_va <= adev->virt.fw_reserve.ras_telemetry) {
-		fw_vram_usage_start_offset = adev->mman.fw_vram_usage_start_offset;
+	if (fw_va && fw_va <= adev->virt.fw_reserve.ras_telemetry) {
+		fw_vram_usage_start_offset = adev->mman.resv_region[AMDGPU_RESV_FW_VRAM_USAGE].offset;
 		ras_telemetry_offset = (uintptr_t)adev->virt.fw_reserve.ras_telemetry -
-				(uintptr_t)adev->mman.fw_vram_usage_va;
+				(uintptr_t)fw_va;
 	} else if (adev->mman.drv_vram_usage_va &&
 		adev->mman.drv_vram_usage_va <= adev->virt.fw_reserve.ras_telemetry) {
 		fw_vram_usage_start_offset = adev->mman.drv_vram_usage_start_offset;
-- 
2.49.0

