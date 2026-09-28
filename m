Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB463CA5FA1
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2026 16:44:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A40E10E68B;
	Mon, 28 Sep 2026 16:44:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QOjE8Biw";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011028.outbound.protection.outlook.com [52.101.52.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0007210E68B
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2026 16:44:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oXryyoy+RA+5jDQ08x9i2RxvEHVMniPUwI1TC7sn1V9m5U7E8JAJf/yL9evUFxUKnadXuYaN6xK327xgMXzGzblx/rykx1qzwVPmPI1ekVRd/f/eIPRSdWM/YE9Io724chtXjKGoRGHmdvt1xV6riDEOmoV/BVGohFOJef80QwR43SWJpussd8kM13Akq1IKsrEjAXqzCkZeSft7ol1GDoAWub8CDuPyE2wfEXN5OGUHHz/gOSQmgvXAoxReg+5OKJQ4IIO/cTdByPMNRfJmvcoXqEqkMDnmxcK5ypAhVisY0MZCsYB8MuZEWeymp15yGHFgYqvRFEAbovoC3zhfPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0WXhcgSDofMfzO//IBYhvatj/S+NRJbbWS+udljNLOA=;
 b=ngHPNPs2Id6EVCzeUcH5DaDYoNjrAL//7vl024MJ82lREiX3WZ8NnaVKuI8TV6+REjdXxlQB9cyXnFy92Ryk+dfStzNmqkPXTgYufgmmD/CTHV6bmd1XYgHxL2kUp+t28TO7Zxh2h06xr3Y0URCDscgkyOFZnBT9QJw+bnRpPnkneWJve6ynvRCNTJoPKb/7tRWVBTNnm9C+WNI7XHJM1d7s5b6jZEmqIGwhj3AkonTLJbE7PN7hutiVGbzQovwX5l9/B2D+oOIjgWFAgswqwNDBfUimGCyUBpFjVCnGV9rbmbuTOlDuZP25dnCvved51NwjOaZyHX82ZgJ0ktPMig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0WXhcgSDofMfzO//IBYhvatj/S+NRJbbWS+udljNLOA=;
 b=QOjE8Biwu3v/YU7sL1dflTzHT3l4tKt3emx7P9XtcQ9ifmmHz4m/VnO3I1UpwmrBDnT4TkL4XPIu8LqFVUYCEbIv1+Sn5hYK+8lWEdyuc91jR6rTpsYptxp85YBJghNIpAf0Fmix1aaJlBj53TK5h/hNK91HHQbo9Jt3GOIUlUU=
Received: from BN9PR03CA0754.namprd03.prod.outlook.com (2603:10b6:408:13a::9)
 by SN7PR12MB6887.namprd12.prod.outlook.com (2603:10b6:806:261::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 16:44:48 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:408:13a:cafe::1f) by BN9PR03CA0754.outlook.office365.com
 (2603:10b6:408:13a::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.24 via Frontend Transport; Mon,
 28 Sep 2026 16:44:48 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 28 Sep 2026 16:44:48 +0000
Received: from MKMZHLUO01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 28 Sep
 2026 11:44:46 -0500
From: Zhigang Luo <Zhigang.Luo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Philip.Yang@amd.com>,
 <Hawking.Zhang@amd.com>, <Lijo.Lazar@amd.com>, <Gavin.Wan@amd.com>,
 <Victor.Skvortsov@amd.com>, Zhigang Luo <Zhigang.Luo@amd.com>, Zhigang Luo
 <zhigang.luo@amd.com>, Fangsheng Huang <Fangsheng.Huang@amd.com>, YuBiao Wang
 <YuBiao.Wang@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH 4/6] drm/amdgpu: take the A+A VF GMC aperture from SRAT
Date: Mon, 28 Sep 2026 12:44:18 -0400
Message-ID: <20260928164421.10144-4-Zhigang.Luo@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928164421.10144-1-Zhigang.Luo@amd.com>
References: <20260928164421.10144-1-Zhigang.Luo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|SN7PR12MB6887:EE_
X-MS-Office365-Filtering-Correlation-Id: d7290172-ac3c-42bf-1e0b-08df1d7fcf69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|11063799006|56012099006|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: elO+x9cQnndEA3WxG/jk/85zxee2G36i1BYPUVboXME/IwU5/dPlFUS4Z/hgjA9XcIlBmlPOAZLUCukbg+QlMXzuPDpUjBTulk08RpfzCXxlZpFyHKhA/hvGgj/xDRbZVVQ7+IS7lt8r3EqO8CDYSjCRUVg3Rvd6Zygl8aLOQMgOADvwIhp/XzmEeVFDAN58qQjCg5ILH2lx2+3JQuP7RuhPn9R3qKkiJZLfivoVU06Ft28CkP+zxxXJ7jS5czXhNeyYaigIvolBh/8g1YDGfPgJfXdxRrGViQ0xU8mJIEA4BK146aOYyhvHQ7oqAJILbz7UmLVgVFJfA2e2Hggnn0U57bE4CLJSpCUvd9ajk6+/Hl4U7r7B3nYIHaBJ9iXGa0+WzzrzzQDW6HadRv6q3eGMcjHNNe7eTEQaKTyjg3lJ8t6wcy6bGqk9ZOR/P0hu+8AEq4r4+mObHTuJwWj9JLb3yQHDVLxetvC3kwzQz90gRFU18eIGp7/DrNGp80JMMRGYbl7l494/zez+UDa1GLxVso+qMLBJ62JjJuOxzitOlQs9WKl8MfkfpVeOdfbmZYJIeLbYUtUiZ9VOVjL/EvtQvgvitgHb969Atk3o15EYwSGU7GsTut1y8pKd8g8Lro/RRi3WcfW8fY5x6cLkRhJsjL7d8/07IkQKrQNhr1tjqzP/0GXqxw2+vEh7O3fflyNt+G9XymyumobHKGduGA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VtQLW6HyF7arQF1YNwFtmYA/a3XllTaYjyVJkClxGPkbzrS3kqYxU45+2NAmfSJ4viDQZ3mw+65lgrCkXVOTZ319+O20GfiK0POOeBnd+LUed8WnKXspyY2N0rKpXMdNmabDYOQZouIwvvZcyszvu6vAM6bhedRTaVb2NtasKwaZcrtsgz2XCZ2j22E3O/ZYxeaBsT1IiJjpjtbhp7SKDEVliFeBcIyI9DV/APjoJs5qfHXeaW1KqqNvdquThXPM3AG436HIsR98NPWe3d+amH4ZfQ7k3YHknht6SIf9WByvqnxBnDtDmMBp8HeKzQkjLa8I7XlX2FF/vjbuoy5N1qW9Urj1fepyAWFZWe6tPpUaOyB+zF/r4ye7i4AwlATNkPtxu+jfHpMmCBhvAUXnHJrphBcSVBNrtrckJ8KP5+VrEP6uGuv090U3VdLjgD6L
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 16:44:48.7298 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7290172-ac3c-42bf-1e0b-08df1d7fcf69
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6887
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

The A+A VF FB BAR is not usable, so resolve its aperture from SRAT in
GMC early_init. Skip later aperture assignment for SPM-backed devices,
and restrict the existing mmhub-based override to native A+A and APU.

The GPU reaches its HBM at a system physical address, so
vram_base_offset becomes aper_base as well, which makes PDB0 map GPU
address 0 onto that address.

The XGMI node segment size comes from the same place: once early_init
has resolved the aperture, use its size rather than the value derived
from the register, which does not describe the VF partition.

v2:
- Use (sriov_vf || passthrough) and amdgpu_virt_vram_is_spm()
  instead of connected_to_cpu for the SRAT aperture and node segment
  size.

v3:
- Resolve the SRAT aperture in GMC early_init and skip later aperture
  assignment in mc_init for SPM-backed devices.
- Rely on amdgpu_virt_vram_is_spm() without redundant VF/passthrough
  checks.

Signed-off-by: Zhigang Luo <zhigang.luo@amd.com>
Signed-off-by: Fangsheng Huang <Fangsheng.Huang@amd.com>
Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c    | 53 ++++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c |  5 ++-
 2 files changed, 45 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index 0cc73982ed6f..c88ce5b94863 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -638,6 +638,7 @@ static void gmc_v12_0_set_gfxhub_funcs(struct amdgpu_device *adev)
 static int gmc_v12_0_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	int r;
 
 	if (adev->smuio.funcs &&
 	    adev->smuio.funcs->is_host_gpu_xgmi_supported)
@@ -660,6 +661,14 @@ static int gmc_v12_0_early_init(struct amdgpu_ip_block *ip_block)
 	gmc_v12_0_set_mmhub_funcs(adev);
 	gmc_v12_0_set_umc_funcs(adev);
 
+	if (amdgpu_virt_vram_is_spm(adev)) {
+		r = amdgpu_acpi_find_gpu_memory_in_srat(adev,
+							&adev->gmc.aper_base,
+							&adev->gmc.aper_size);
+		if (r)
+			return r;
+	}
+
 	adev->gmc.shared_aperture_start = 0x2000000000000000ULL;
 	adev->gmc.shared_aperture_end =
 		adev->gmc.shared_aperture_start + (4ULL << 30) - 1;
@@ -706,10 +715,19 @@ static void gmc_v12_0_vram_gtt_location(struct amdgpu_device *adev,
 			amdgpu_gmc_agp_location(adev, mc);
 	}
 	/* base offset of vram pages */
-	if (amdgpu_sriov_vf(adev))
+	if (amdgpu_virt_vram_is_spm(adev)) {
+		/*
+		 * For SPM-backed VRAM, PDB0 entries use PTE_SYSTEM, so the
+		 * address is a system physical address. vram_base_offset must
+		 * be aper_base so PDB0 maps GPU address 0 onto the HBM system
+		 * physical address.
+		 */
+		adev->vm_manager.vram_base_offset = adev->gmc.aper_base;
+	} else if (amdgpu_sriov_vf(adev)) {
 		adev->vm_manager.vram_base_offset = 0;
-	else
+	} else {
 		adev->vm_manager.vram_base_offset = adev->mmhub.funcs->get_mc_fb_offset(adev);
+	}
 
 	adev->vm_manager.vram_base_offset +=
 		adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size;
@@ -746,17 +764,28 @@ static int gmc_v12_0_mc_init(struct amdgpu_device *adev)
 			return r;
 	}
 
-	adev->gmc.aper_base = pci_resource_start(adev->pdev, 0);
-	adev->gmc.aper_size = pci_resource_len(adev->pdev, 0);
-
 #ifdef CONFIG_X86_64
-	if (((adev->flags & AMD_IS_APU) && !amdgpu_passthrough(adev)) ||
-	    (adev->gmc.xgmi.connected_to_cpu)) {
-		adev->gmc.aper_base =
-			adev->mmhub.funcs->get_mc_fb_offset(adev) +
-			adev->gmc.xgmi.physical_node_id *
-			adev->gmc.xgmi.node_segment_size;
-		adev->gmc.aper_size = adev->gmc.real_vram_size;
+	/*
+	 * SPM-backed devices resolve the aperture from SRAT during early_init.
+	 * For native A+A (non-VF) or APU, override aper_base using mmhub
+	 * offset. Otherwise derive the aperture from BAR 0.
+	 */
+	if (!amdgpu_virt_vram_is_spm(adev)) {
+		if (!amdgpu_sriov_vf(adev) &&
+		    (((adev->flags & AMD_IS_APU) &&
+		      !amdgpu_passthrough(adev)) ||
+		     adev->gmc.xgmi.connected_to_cpu)) {
+			adev->gmc.aper_base =
+				adev->mmhub.funcs->get_mc_fb_offset(adev) +
+				adev->gmc.xgmi.physical_node_id *
+				adev->gmc.xgmi.node_segment_size;
+			adev->gmc.aper_size = adev->gmc.real_vram_size;
+		} else {
+			adev->gmc.aper_base =
+				pci_resource_start(adev->pdev, 0);
+			adev->gmc.aper_size =
+				pci_resource_len(adev->pdev, 0);
+		}
 	}
 #endif
 	/* In case the PCI BAR is larger than the actual amount of vram */
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
index 4495d52b4b07..4c0a2d671cfc 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
@@ -154,7 +154,10 @@ static int mmhub_v4_2_0_get_xgmi_info(struct amdgpu_device *adev)
 	if (adev->gmc.xgmi.physical_node_id > max_physical_node_id)
 		return -EINVAL;
 
-	adev->gmc.xgmi.node_segment_size = seg_size;
+	if (amdgpu_virt_vram_is_spm(adev) && adev->gmc.aper_size)
+		adev->gmc.xgmi.node_segment_size = adev->gmc.aper_size;
+	else
+		adev->gmc.xgmi.node_segment_size = seg_size;
 
 	return 0;
 }
-- 
2.43.0

