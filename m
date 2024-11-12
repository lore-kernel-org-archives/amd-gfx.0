Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43D49D597A7
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2024 21:37:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2877310E669;
	Tue, 12 Nov 2024 21:37:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZNtE91gd";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2063.outbound.protection.outlook.com [40.107.236.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96DB610E660
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2024 21:37:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iPMtZZMRm+GQ7SqdfDjQxCpoO0OVQePp2HdXP1JfXnUm0JpCYzbgtLMPzyupen4mVyuuFkky4WX6d7HyhwV0ZHK4wH16sXwTxGRjO+HnqFY4cKlBEJ8NvWE8FhyP7POcZb6UST9XjMsDPqGl+5j6c7/2Be0bIAZuBPEJpBHmml/Wdz5rBywAxXOz0EXiYrEvnILo4ZoZ3/hVxjStGuR/LqD3F466mwXDLiGSehQnK6V6njVzBr6kgs2OqHmSWqdGv2YdJffvgeVP6ffMUQ7AYyUwj8ETp24QonUCW6ekJDFbj9aAZZB/dOgsI7GqOgTY50TLB/ZETZYwCBia6jX8bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OHv9YJo3hGasNAYzmueKkmo4TxGIm6ueIjVsQWQ2KYc=;
 b=jHn6nMEbFtEEvyJ/Nzntrc9Tt8IaBz1GeGyccv290ZadyDGvB1HDTB6B3q9K3e231RsSBmpSQuH3hhz8I9Vcyfejggf1txAVHWfG/GVnFcKuBhDxQytoqhaLDxZ/ujgSzOz+6YtE7RN5dcWnTsU9Ib3y9XXnKqBpwwfq3brYFix4wu7gxIfVNiq+vSH/vxOAdVS/OvT1ewsTDu0aVEKmqbho+1MyZV34nwtfr67AuzfCxLilncdOq3ABzJddVX3uVD9p1U2Rnlhe4AIGz+itk8Vh0QLI7xcWF0BNRfnx7AYN7cZxIz6HFY/j4OFu9Y0vA/AmXC9bkGCTLV2vBTLDfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OHv9YJo3hGasNAYzmueKkmo4TxGIm6ueIjVsQWQ2KYc=;
 b=ZNtE91gdLGsQL8T77LlYmL8n7NwvpNF/1GL/DRL/IlDzkaHyGezVZ8zShkL1WHbXe1vpbkc+uP40eYYeKYeAkJyMeefVPUDdT2v1xDFP/JZubeMnBr0msB51yQjsSV+cfpZE8tFL4p6f9VmixneZvf+B9j/RXwrEUdvZYc237xU=
Received: from BN0PR03CA0044.namprd03.prod.outlook.com (2603:10b6:408:e7::19)
 by DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.28; Tue, 12 Nov 2024 21:37:31 +0000
Received: from BL6PEPF00020E5F.namprd04.prod.outlook.com
 (2603:10b6:408:e7:cafe::60) by BN0PR03CA0044.outlook.office365.com
 (2603:10b6:408:e7::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16 via Frontend
 Transport; Tue, 12 Nov 2024 21:37:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E5F.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 12 Nov 2024 21:37:31 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Nov
 2024 15:37:29 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <yaolu@kylinos.cn>, <jfalempe@redhat.com>, <harry.wentland@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 1/6] drm/amdgpu: add generic display panic helper code
Date: Tue, 12 Nov 2024 16:37:11 -0500
Message-ID: <20241112213716.49355-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241112213716.49355-1-alexander.deucher@amd.com>
References: <20241112213716.49355-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E5F:EE_|DS0PR12MB6390:EE_
X-MS-Office365-Filtering-Correlation-Id: a0cc4423-03f9-4eec-ab8c-08dd036236a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ByCtb20hNWZdrrtzqJrVUFGlZWFHuYrCMPyP/coufbivpUd4u7CVdWTxzs5E?=
 =?us-ascii?Q?xLwoTcS/GfuUXyQmkQGqf+w3hRqvT2/1tuSDGu5IGjCU51h3s9Gu5SosOpe/?=
 =?us-ascii?Q?e2696cClf+8hNgr5JRN1rulMNMTjRtkPjhM/jon3uiCFKAESteN9J1eZdCJS?=
 =?us-ascii?Q?ecggyp3DmD2MfrXrGV177Ns6EzdnSQ1Zj6p/Cfx+Ee9npk7AIbiR54Sy01wR?=
 =?us-ascii?Q?dp8Iy2aXbov/EnueZA4unJ4oBNgs89nApepZD8pYZ5YGgu/BleKy257WH+NL?=
 =?us-ascii?Q?FGpr1UuA0gAaPuJOKH4rrAeVTik6rVY+YJ7agXibP1fek4wUtsjnYVGMAYsM?=
 =?us-ascii?Q?I5+G7QRuewd/lSqcXJYXYuUz98a45NpyHTe3cwUckKqpr7k9ovsjCqNVOJQ1?=
 =?us-ascii?Q?PfYZToh+YQ4YWwz2SuKSpRYLR5qNDJB5xTqFDOITE0N+KzR7/y6D4RPvtziX?=
 =?us-ascii?Q?+RlQSJZIrzGF+rt9gh+adVnJd4RDhO08jlALTvTVVpWs+pRwvZjIuhVJADeC?=
 =?us-ascii?Q?nhC7++inC/8lHQoZ6y9tVbIilepHxELUtw5Kbqy+KSrq8YXBGlst5rIkHFAW?=
 =?us-ascii?Q?r+KQT16AAV97mgdK2uAOGqvAnrCr7ESi8DbizinmSKN8Qi+JAYPDKu6xEFhF?=
 =?us-ascii?Q?PcSKEPAZ0BhroZRrKaUiIYHbkvLXSE0C/cD/DhoRoc14zfOcA+mK3R3AVALi?=
 =?us-ascii?Q?3wOcz8loj6UoDBYdzGKAeHWehkuJi6f67dhJAxltBL0qJLiZXGTGUUXY4aYA?=
 =?us-ascii?Q?Ha+fvjzqVG0WVkYmaUuZuCFwV0Ek30SJcpOOcivZDpI1KJu3+HPhKxpTsCAu?=
 =?us-ascii?Q?hJRJ8SRwR/vPjxxvXCup4ZHPB5iWAq4Usy9mVQ09984ev7uvf3ZE4dEUHiVJ?=
 =?us-ascii?Q?UiWGgaK15Asg34LwDywoualb6H5OHm0mn+OTonxo59n6ritYBdcvZbaFqiF4?=
 =?us-ascii?Q?RL1t8iCovuZ5N3PcVjkekx5Jqvv1qMtf2L8ajfuPQe55B6skvNDITeLJZ1v+?=
 =?us-ascii?Q?pBWuC+cGljIvoLb56HtqT7EET+qKHUMTNxdLAPbS6a2cPR2aWcboH3aqRhtQ?=
 =?us-ascii?Q?+dR16HTm6/eQ9itj6c07wb2m+KnWCafjMgkYJN5idqDUbUjvHgm7iVmlnZ8c?=
 =?us-ascii?Q?/bvQpoFNH4U/hN6jeP/ckPUMW6+rnIkHBj172aq7gtNedgdSqD3XiefQV3wU?=
 =?us-ascii?Q?YnwwRNW/069NyVkHmQe+WuRSpYvN8Fj74xq1FaYM9AzU7xVUt+kFlecDjnLY?=
 =?us-ascii?Q?EgSjwRozK+EDKUT0Tx8uSmLQLQ3haFeRXY5Mkh0x/GMiFPLKQ3qI80miQRxt?=
 =?us-ascii?Q?Y81Aua7FlaQUAke/6mEttftxocp29uShX8C/boaMfjkMZKJqCQZltvhV6uaL?=
 =?us-ascii?Q?PDr0ju/R0E55PpbbLDH069lA3ISO1Fkg1fsHKvlKprMIf/jETQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 21:37:31.3774 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0cc4423-03f9-4eec-ab8c-08dd036236a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E5F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6390
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

Pull this out of Jocelyn's patch and make it generic.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Lu Yao <yaolu@kylinos.cn>
Cc: Jocelyn Falempe <jfalempe@redhat.com>
Cc: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 80 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.h |  5 ++
 2 files changed, 85 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index b119d27271c1..35c778426a7c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -33,6 +33,7 @@
 #include "soc15_common.h"
 #include "gc/gc_11_0_0_offset.h"
 #include "gc/gc_11_0_0_sh_mask.h"
+#include "bif/bif_4_1_d.h"
 #include <asm/div64.h>
 
 #include <linux/pci.h>
@@ -1788,3 +1789,82 @@ int amdgpu_display_resume_helper(struct amdgpu_device *adev)
 	return 0;
 }
 
+/* panic_bo is set in amdgpu_dm_plane_get_scanout_buffer() and only used in amdgpu_dm_set_pixel()
+ * they are called from the panic handler, and protected by the drm_panic spinlock.
+ */
+static struct amdgpu_bo *panic_abo;
+
+/* Use the indirect MMIO to write each pixel to the GPU VRAM,
+ * This is a simplified version of amdgpu_device_mm_access()
+ */
+static void amdgpu_display_set_pixel(struct drm_scanout_buffer *sb,
+				     unsigned int x,
+				     unsigned int y,
+				     u32 color)
+{
+	struct amdgpu_res_cursor cursor;
+	unsigned long offset;
+	struct amdgpu_bo *abo = panic_abo;
+	struct amdgpu_device *adev = amdgpu_ttm_adev(abo->tbo.bdev);
+	uint32_t tmp;
+
+	offset = x * 4 + y * sb->pitch[0];
+	amdgpu_res_first(abo->tbo.resource, offset, 4, &cursor);
+
+	tmp = cursor.start >> 31;
+	WREG32_NO_KIQ(mmMM_INDEX, ((uint32_t) cursor.start) | 0x80000000);
+	if (tmp != 0xffffffff)
+		WREG32_NO_KIQ(mmMM_INDEX_HI, tmp);
+	WREG32_NO_KIQ(mmMM_DATA, color);
+}
+
+int amdgpu_display_get_scanout_buffer(struct drm_plane *plane,
+				      struct drm_scanout_buffer *sb)
+{
+	struct amdgpu_bo *abo;
+	struct drm_framebuffer *fb = plane->state->fb;
+
+	if (!fb)
+		return -EINVAL;
+
+	DRM_DEBUG_KMS("Framebuffer %dx%d %p4cc\n", fb->width, fb->height, &fb->format->format);
+
+	abo = gem_to_amdgpu_bo(fb->obj[0]);
+	if (!abo)
+		return -EINVAL;
+
+	sb->width = fb->width;
+	sb->height = fb->height;
+	/* Use the generic linear format, because tiling will be disabled in panic_flush() */
+	sb->format = drm_format_info(fb->format->format);
+	if (!sb->format)
+		return -EINVAL;
+
+	sb->pitch[0] = fb->pitches[0];
+
+	if (abo->flags & AMDGPU_GEM_CREATE_NO_CPU_ACCESS) {
+		if (abo->tbo.resource->mem_type != TTM_PL_VRAM) {
+			drm_warn(plane->dev, "amdgpu panic, framebuffer not in VRAM\n");
+			return -EINVAL;
+		}
+		/* Only handle 32bits format, to simplify mmio access */
+		if (fb->format->cpp[0] != 4) {
+			drm_warn(plane->dev, "amdgpu panic, pixel format is not 32bits\n");
+			return -EINVAL;
+		}
+		sb->set_pixel = amdgpu_display_set_pixel;
+		panic_abo = abo;
+		return 0;
+	}
+	if (!abo->kmap.virtual &&
+	    ttm_bo_kmap(&abo->tbo, 0, PFN_UP(abo->tbo.base.size), &abo->kmap)) {
+		drm_warn(plane->dev, "amdgpu bo map failed, panic won't be displayed\n");
+		return -ENOMEM;
+	}
+	if (abo->kmap.bo_kmap_type & TTM_BO_MAP_IOMEM_MASK)
+		iosys_map_set_vaddr_iomem(&sb->map[0], abo->kmap.virtual);
+	else
+		iosys_map_set_vaddr(&sb->map[0], abo->kmap.virtual);
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h
index 9d19940f73c8..dfa0d642ac16 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h
@@ -23,6 +23,8 @@
 #ifndef __AMDGPU_DISPLAY_H__
 #define __AMDGPU_DISPLAY_H__
 
+#include <drm/drm_panic.h>
+
 #define amdgpu_display_vblank_get_counter(adev, crtc) (adev)->mode_info.funcs->vblank_get_counter((adev), (crtc))
 #define amdgpu_display_backlight_set_level(adev, e, l) (adev)->mode_info.funcs->backlight_set_level((e), (l))
 #define amdgpu_display_backlight_get_level(adev, e) (adev)->mode_info.funcs->backlight_get_level((e))
@@ -49,4 +51,7 @@ amdgpu_lookup_format_info(u32 format, uint64_t modifier);
 int amdgpu_display_suspend_helper(struct amdgpu_device *adev);
 int amdgpu_display_resume_helper(struct amdgpu_device *adev);
 
+int amdgpu_display_get_scanout_buffer(struct drm_plane *plane,
+				      struct drm_scanout_buffer *sb);
+
 #endif
-- 
2.47.0

