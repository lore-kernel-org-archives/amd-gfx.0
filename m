Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EF11D2B931
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2024 14:06:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA97E10E5B4;
	Tue,  5 Nov 2024 14:06:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="x+BmiypF";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2061.outbound.protection.outlook.com [40.107.96.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC74410E5B4
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2024 14:06:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i6TLBeWQRlmm0Tjpif6UZrzPWetnS5/C25FTdvEqQcme0Epjyvz30pIICxwsaZIOfHBdrFD95ZBr9ED63DmWskB1pQ2M8F/+Yv5IlBXpqNTjJEbXnPddDHvQGJEkMZON1BpLMPNSe/BdraNa+rVNR5jVueyL0cABGE8wLmDO+1GLbiM2Bm9Fq4+SCJxMgmgG0YN6BA0YeF3QxGbH09aWPi71sYry49M3b2o+dVZatq40P3AUr70LCG0PwUW/4Fj8E7H4L51cSUKQYV6PtLYpuW4cS9hMc8UOWXurL/fgZemuGBKbPYkCa/WTNZemH6LXYAHY+tsT4+8cqH6vdkuMAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y5kBgy5Z8P5dT/LU1r8D+jM2NI/bLVqAxgYpTG5XmpI=;
 b=cqce05Py/wsl+rmOWxD0/lDKVZb1gZnIXVB8IPe0kQJt/ZIHdczWNi4z4VgM0j1aj+ohf96EHZMS6/4X7QxgzhzMHgVUm+5lgUHwH0fNWY8ebN5nuvgV3BYQLzuswwaz2GePLxkUM5gszAnNlx9MHcvxODaQ/Xw11a3Ev2gxpsgjKZLOUDqfM/yr/u8TrYtvNqgNVltyino8JlHWS85imz8GwUD01ljMGniVOAtw0v9a067nTrVfzXIesf1QsrTGS/n2/ykjQVXFcHeLWNm1b8Z2gMz7LdVs2U2bVN17K/+aWHVJUx50x2RTKUjzh0+1L2/Ggie7Mr1Md7Xm91VUWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y5kBgy5Z8P5dT/LU1r8D+jM2NI/bLVqAxgYpTG5XmpI=;
 b=x+BmiypFMoYuFM9l8YNm8JcQYB3CWIDZMnRSc1v/QagdShLuxhm0AE96Bl7d9QxI/tE2pUhzy2AT9dJOkK3p7NawtP0Kzb1clskuUqn4rreDGESZUmGh0YP0SjyopI/Ctjl4/FRAteQu3mFsd0igokPxfDfFTCDmFtSY/qkAmIw=
Received: from MW4PR04CA0332.namprd04.prod.outlook.com (2603:10b6:303:8a::7)
 by SA3PR12MB9157.namprd12.prod.outlook.com (2603:10b6:806:39a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 14:06:42 +0000
Received: from CO1PEPF000044F3.namprd05.prod.outlook.com
 (2603:10b6:303:8a:cafe::26) by MW4PR04CA0332.outlook.office365.com
 (2603:10b6:303:8a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30 via Frontend
 Transport; Tue, 5 Nov 2024 14:06:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F3.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 14:06:41 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 08:06:40 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <yaolu@kylinos.cn>, <jfalempe@redhat.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 1/5] drm/amdgpu: add generic display panic helper code
Date: Tue, 5 Nov 2024 09:06:20 -0500
Message-ID: <20241105140624.2897662-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241105140624.2897662-1-alexander.deucher@amd.com>
References: <20241105140624.2897662-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F3:EE_|SA3PR12MB9157:EE_
X-MS-Office365-Filtering-Correlation-Id: b6dd67f7-e3db-46bc-f6b0-08dcfda312ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bHi7LiuvwvO20kKvvUnt6L7MYOhZMIqcA36j8WLB7YGmOZptesK3XDEea4ZE?=
 =?us-ascii?Q?8hrvor0aipaZdcsiwHCer5uYBPsBZvyBJf/yCof2Oapk9Z5+fOKU9n0bZc3D?=
 =?us-ascii?Q?BKynm32fiRBH+CXQlw/cH8lojf+EZsLB7DR/b2xTFgZzn3rsNjEVdtXlzWYV?=
 =?us-ascii?Q?fDkuFm9ohIEqxxG+hbQ7FonvZcD7Jb6uGxidpKK9FBpPHsgp65CiQdbqMv1O?=
 =?us-ascii?Q?F9I6Ft2Fszt1FU/OleTm6j6hFGglmZjlBuCF4vk0EyAJ9gaWls8IZWKr9yfk?=
 =?us-ascii?Q?frVoMYr2w77gG1duN8Gq4H4Thb7Bc4796iVZldotGfPpmx7IxQKkBM6kZhBd?=
 =?us-ascii?Q?Cn7kb5MkzbUZnH2rvE4K7DJZLUMTNtTXYbuyszmDP0K9Aso6f+6j1oQ1wYoJ?=
 =?us-ascii?Q?4RXXPWqZSuXm8Mb7sKojqFGYKbANgL0Ppme5Igr0rJIOC9itZK2Ci0Wpzpml?=
 =?us-ascii?Q?dLmlCJ/WATmAMM7D5Hhpw9EPF5cqzv0AKLudnp6uZDqJsYwfHBdKyb8mT5ab?=
 =?us-ascii?Q?Vy0X7ashng45P49zG3nenq4bA9RAVNzaSyiJErZL5tsYzgjTqLe+oWsP60VQ?=
 =?us-ascii?Q?ug29We+ivMj08JAo0RTKkQVDALjrCdhJvryuv8JkhsTq5r7L8amzkmzWZgDb?=
 =?us-ascii?Q?ZBcK0Sn/q/x0T2bhh8j9fDI4nPB3CmlCENjPUS01JGztkRzx7qrjcXjhFhnx?=
 =?us-ascii?Q?5GyesDeQd1YWlzIysxM6dFg5Ab19pfuPWNPcKF6UQUnkQF5zbYvVzkq7lKZW?=
 =?us-ascii?Q?w2FWkgH6rf/bmCQyIDLGdh7PrmRLwbnuEd3qh/czgf/HsEvNYFAs79EhkJve?=
 =?us-ascii?Q?YY77qB/mDu//qXRbgtcB77OejVr1jdP6UNJW/wkVBQb1Sq71IgLpGmf3+K7h?=
 =?us-ascii?Q?zWqoejRWyTOQtt45SdnN4VamJLQkOCrfYYAXY5iLibhjfNvPGKsH1Bl+T52U?=
 =?us-ascii?Q?xbOZBOJqXaQO+fdDpak3LkgYN2I0wWA/g+yNglE/p8AgTCPlLha3hGRF01MD?=
 =?us-ascii?Q?oSrYk9yGudE0dyaqP3duTKSj2XcBL0eEskhWYWo5KZmi0e8Wl+P4zse7+83v?=
 =?us-ascii?Q?Cr3DnkH+kFpOnIETBDs198nDUP4cJRXGWrbHQvaF1tA7NWH6EOCWhRf88jSQ?=
 =?us-ascii?Q?7+MFlS7bDSmlhuKvgXSmB4Xyhby+ipcOyqF2WBhx1+XzIVgR8+hWLMo9ziIh?=
 =?us-ascii?Q?p3SZQTMqQUrkrufpWnKd5mJQaLFXOr39PRvARAGJuNuDp3o38imth3PYXxOD?=
 =?us-ascii?Q?PGNnKXDE6rsZ69JiFYpob8X1RVSVf7JNzjTlnXUH/ZjGX5oNE0mtcGs9z6OH?=
 =?us-ascii?Q?qvrm1Yy69BHnDvYj9Yj9G8NAaad+YEB5qSYbj5OaM9Pg/fZ8HT2HTxSQFwmD?=
 =?us-ascii?Q?N503zUSVQnoG9jH1Y6pSLrk2mtfjO4APr4ssdcUYI7OnUituLg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 14:06:41.7261 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6dd67f7-e3db-46bc-f6b0-08dcfda312ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9157
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

