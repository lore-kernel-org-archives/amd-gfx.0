Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12A1CCF649C
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Nov 2025 00:08:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1EF610E6AC;
	Thu, 20 Nov 2025 00:08:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bLj4kDMT";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011040.outbound.protection.outlook.com [52.101.62.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A9A510E6AC
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Nov 2025 00:08:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nQlwrlZj37sGJpI74nijShJQfW1p2qdiaY2jM7BDscOzvHzlXrl7xxmJ53n2LgIlRNUOo2lvvM9fZLQJIqiPPN3j8aiC0iC8Rh+kNqf82qWt0Cgzcio4gTFwYWqTtz7KgmR4Lk79YZ8Y7VHrLBl8EYep5OHzw3eUXaejIiCp2sGDOkt8wEMGsnISGLHwZ4IzoV/7ZaxVin0r+d1LrtEWP8vgQWttWfsDSxT8sXjw9hhPX70AoIc8mAB4giGEX3fQm9pfp+SFR/OX4lfuHmWytdETeU4XSELUtJuzXtHJ4QPY3SgINEB5g1G/rG9ORV4kQ5GFd3gFnX4iMS0935kdQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NFPwBfVhWdLktV+PLvNJgl2ItffjjHK9IWwLEG32rk4=;
 b=C7Xnr4GSdxxwH3mEk/TtKZRsLchnljQIGIEFB1xtiCPx67Lo4hPB86HuVvdovn29yawATl795jd2bfQVj2ogkO/50ObbVSft/F3Q1A/WzTzpGpimE8WtfZrVuBLocVF0sebIKzNk2mOaFOOwkYrS/eXoMA6exOEv0fqoFPCojlsjKlkV0arX7IVJHVlB8xCU4A4hbzirlftT7zu/WgKB5mtwClO1Y9dZqNDu61DUq6SpL/FNjk4Ke5d7hhEiesGTNoAIMAjrF6hu1RpDLt6NuwMklHGU/XtCpgwG4SNKM/uQPgkjkWr0/CppfqGEXM6/jds0j4/A18f3V1mbP+qGiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NFPwBfVhWdLktV+PLvNJgl2ItffjjHK9IWwLEG32rk4=;
 b=bLj4kDMTICC+Z2IOuViNChviyxFlQ+DXx/KFLb9eSDtfY0iLGKafuUVOy10c6cwUYp/clCVwnWXt06guEgGZbGm5j3etU9IkJXL1fprmJtL0nK4VoaBJGa2CDRD83Ti5xm/YV44kUkHd+bu8wyroM5sA0YkACpZeuTzhl+FOfNU=
Received: from MN2PR19CA0031.namprd19.prod.outlook.com (2603:10b6:208:178::44)
 by SJ2PR12MB8927.namprd12.prod.outlook.com (2603:10b6:a03:547::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 00:08:30 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:208:178:cafe::f3) by MN2PR19CA0031.outlook.office365.com
 (2603:10b6:208:178::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Thu,
 20 Nov 2025 00:08:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 00:08:29 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 19 Nov
 2025 16:08:29 -0800
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Nov
 2025 18:08:28 -0600
Received: from rico-code.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 19 Nov 2025 16:08:27 -0800
From: Tianci Yin <tianci.yin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Kasiviswanathan Harish <Harish.Kasiviswanathan@amd.com>, Hawking Zhang
 <Hawking.Zhang@amd.com>, Tianci Yin <tianci.yin@amd.com>
Subject: [PATCH] drm/amdgpu: Enlarge DMA mask to 48-bit for GFX11 and GFX12(v2)
Date: Thu, 20 Nov 2025 08:08:25 +0800
Message-ID: <20251120000825.993579-1-tianci.yin@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|SJ2PR12MB8927:EE_
X-MS-Office365-Filtering-Correlation-Id: 79c81b15-14c1-4a7b-a400-08de27c8ef29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Yu++ruFicg8kU36SBxq9iPQS1Zm+nuserxkHPxEAxxXT7pREZmoZxpKxIHov?=
 =?us-ascii?Q?Ix3FSOuMuwCYyeqQ1YtE2aG6shvuuYltEh2Qd8jRBlVDJa+miDZtOrsoL8BW?=
 =?us-ascii?Q?96YJQpVqz20kcrTIUsuD3v5Tq6NA1x9R58CMVQcFE0l0G7wFb9Yye6mX9/y7?=
 =?us-ascii?Q?XgKYOK7ST/6R/KUq1xtMSaq32VcSVPhRzfCKRqtoEdSkxz2AEj+DdnVJ/I0X?=
 =?us-ascii?Q?SEUOLLEgp3Nz+jYa9YACZJaoyueKF9oSRiTTQmM9eAP0lIE+qGIwJlk8hmHV?=
 =?us-ascii?Q?v59j3/49TNmWnPWErVarZD4OmF/Zdr938XXCr1CW0YRCYVMpI1/W5avGX8wO?=
 =?us-ascii?Q?ejCyrAKQM5tpKJteBjI19iqeRT2xTWcO9s7L6wcMkMma67qdsJ/WB0TwZQBg?=
 =?us-ascii?Q?JA4fGK1Uc7Xawaxm8RSsJGqaht2ApEDFyKEcN2xLtsYGoGlaBV8KwXFLdOuN?=
 =?us-ascii?Q?/cWcyfq/ydHRHQKUpU86X6aTFEcf2vd4M3b/Q2BzoUJDI6cYVi/9DOS+RtA/?=
 =?us-ascii?Q?R38dsaHamohYEhhFvtkW/OGjNuaKL2M1DT/N7JGb9YP8NwbS+9f1ZkNyqwZJ?=
 =?us-ascii?Q?mXXk+csGVCih2FiHswESHmGnyfakgQMFZpesMHEtTSKY2mk4BAoFRKkR6MQH?=
 =?us-ascii?Q?ZH7bJTwWwf2KsAWJ9HCdfXg4fbLdLVepsWC1HIgaucWwTAxzPCNoDHg54vMr?=
 =?us-ascii?Q?Q7iVPILzdVDOUVNHIrdcGfmzzzst0SZvPWWK84TneGaRECGSldm5wHgNQHOW?=
 =?us-ascii?Q?D9nH8YWRmiaChxupivsfGoQ8oBJvYdjeazIMZbNAjS0Q09E8TaWTwX8+CIS0?=
 =?us-ascii?Q?kyVHTJ5FUUATsfZev5Q4DprxWtWMsQQ4de0oYDOPojtKtcA/LqV7u2zlRXPv?=
 =?us-ascii?Q?USkCK4SKK6+2BAQMR+zUk0paTsUCWGHHWU4cDRNPvrxkWK3PG5dSO0gAEIVu?=
 =?us-ascii?Q?NSMFRedMa+MAwDGf8P78SW7RlbL8AD3WcNEQiy0oyVJJq1FWXVzuGkwYLxZx?=
 =?us-ascii?Q?ATUWrX5rPb9t/j1MsM1e3feqk5Z33Ylx9YXMvybw3XC/Vpq0snRUoReynq73?=
 =?us-ascii?Q?i1f56Pgm2KPTvvau5cF07lW/NraQsGCwa1WS7y1ntSJnVv/E9EtE7BO4lfbM?=
 =?us-ascii?Q?zozaNjoSFxmQeluNdYvEEm+s8ISdVBhdmWyafy/JAs7MOnnuYfIvoHwY9lG0?=
 =?us-ascii?Q?rKYf3y5j3DnK2a/dnzQZXLQ5O6zncMEH6fjHlpnR/0UUN32vgA9T+8oQZ5XW?=
 =?us-ascii?Q?ebFCqRexe7tOD/jcmlY+riZ4f7P9cP3qo6sOWe19ISgiV7pTyd1wr10bmfhk?=
 =?us-ascii?Q?usGsbPahclVPe+F11nMcu1fnJ5FEgqKfMv46X6Smm+VGXcmdetQp/9zMyrdS?=
 =?us-ascii?Q?EXNLxS55D8Ve5LGIDfIPZkWPTMQ9lwiw61ubJw5SdM4bwFcGYjbtRVn7N4MY?=
 =?us-ascii?Q?yaPFPeB1gJb+Ywp4YbshDww9B8fOSDuePv+iy3f1F0grxxLBijtFkMeT1Vgg?=
 =?us-ascii?Q?Qo3LM0VtGDK/Zs1yRBfMg8JVjPBGRc4yegvDSf+pqO90Oyebkubq1/9xjr7K?=
 =?us-ascii?Q?AsVf1zod+d6iND2hDnA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 00:08:29.2252 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79c81b15-14c1-4a7b-a400-08de27c8ef29
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8927
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

From: tiancyin <tianci.yin@amd.com>

[Why]
On some servers equipped with huge system memory at multi-terabyte scale,
the PCI bus physical address alignment policy may assign GPUs very large
bus addresses that exceed 44 bits. This causes DMA address overflow errors:

[   83.216803] amdgpu 0000:43:00.0: DMA addr 0x0000210b39000000+8388608
overflow (mask fffffffffff, bus limit 0).

[How]
Enlarge the DMA mask from 44-bit to 48-bit to accommodate larger physical
addresses.

Signed-off-by: tiancyin <tianci.yin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 26 +++++++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 25 ++++++++++++++++++++-----
 2 files changed, 41 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index a1f8141f28c9..7efc3880eed8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -21,6 +21,7 @@
  *
  */
 #include <linux/firmware.h>
+#include <linux/processor.h>
 #include <linux/pci.h>
 
 #include <drm/drm_cache.h>
@@ -726,7 +727,7 @@ static int gmc_v11_0_gart_init(struct amdgpu_device *adev)
 
 static int gmc_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
-	int r, vram_width = 0, vram_type = 0, vram_vendor = 0;
+	int r, vram_width = 0, vram_type = 0, vram_vendor = 0, dma_mask;
 	struct amdgpu_device *adev = ip_block->adev;
 
 	adev->mmhub.funcs->init(adev);
@@ -805,13 +806,28 @@ static int gmc_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 	 */
 	adev->gmc.mc_mask = 0xffffffffffffULL; /* 48 bit MC */
 
-	r = dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(44));
+#if defined CONFIG_X86 && defined CONFIG_PHYS_ADDR_T_64BIT
+	dma_mask = boot_cpu_data.x86_phys_bits >= 48 ? 48 : 44;
+#else
+	dma_mask = 44;
+#endif
+fallback_dma_mask:
+	r = dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(dma_mask));
 	if (r) {
-		dev_warn(adev->dev, "amdgpu: No suitable DMA available.\n");
-		return r;
+		if (dma_mask > 44) {
+			dev_notice(
+				adev->dev,
+				"amdgpu: %d bit DMA is not available, fallback to 44 bit.\n",
+				dma_mask);
+			dma_mask = 44;
+			goto fallback_dma_mask;
+		} else {
+			dev_warn(adev->dev, "amdgpu: No suitable DMA available.\n");
+			return r;
+		}
 	}
 
-	adev->need_swiotlb = drm_need_swiotlb(44);
+	adev->need_swiotlb = drm_need_swiotlb(dma_mask);
 
 	r = gmc_v11_0_mc_init(adev);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index f4a19357ccbc..e1dd99e1151f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -21,6 +21,7 @@
  *
  */
 #include <linux/firmware.h>
+#include <linux/processor.h>
 #include <linux/pci.h>
 
 #include <drm/drm_cache.h>
@@ -742,7 +743,7 @@ static int gmc_v12_0_gart_init(struct amdgpu_device *adev)
 
 static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
-	int r, vram_width = 0, vram_type = 0, vram_vendor = 0;
+	int r, vram_width = 0, vram_type = 0, vram_vendor = 0, dma_mask;
 	struct amdgpu_device *adev = ip_block->adev;
 
 	adev->mmhub.funcs->init(adev);
@@ -802,13 +803,27 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 	 */
 	adev->gmc.mc_mask = 0xffffffffffffULL; /* 48 bit MC */
 
-	r = dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(44));
+#if defined CONFIG_X86 && defined CONFIG_PHYS_ADDR_T_64BIT
+	dma_mask = boot_cpu_data.x86_phys_bits >= 48 ? 48 : 44;
+#else
+	dma_mask = 44;
+#endif
+fallback_dma_mask:
+	r = dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(dma_mask));
 	if (r) {
-		printk(KERN_WARNING "amdgpu: No suitable DMA available.\n");
-		return r;
+		if (dma_mask > 44) {
+			printk(KERN_NOTICE
+			       "amdgpu: %d bit DMA is not available, fallback to 44 bit.\n",
+			       dma_mask);
+			dma_mask = 44;
+			goto fallback_dma_mask;
+		} else {
+			printk(KERN_WARNING "amdgpu: No suitable DMA available.\n");
+			return r;
+		}
 	}
 
-	adev->need_swiotlb = drm_need_swiotlb(44);
+	adev->need_swiotlb = drm_need_swiotlb(dma_mask);
 
 	r = gmc_v12_0_mc_init(adev);
 	if (r)
-- 
2.34.1

