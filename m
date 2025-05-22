Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60900C54ED0
	for <amd-gfx@archiver.kernel.org>; Thu, 22 May 2025 04:46:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99EE0113132;
	Thu, 22 May 2025 04:46:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="s05kljcy";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2078.outbound.protection.outlook.com [40.107.100.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12A7C93825
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 May 2025 03:45:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fmgJiHXv9SlkLUrK20KqtWIYnRDodw4YUFfy696kCHBztjajGD6kulbtcmyY3OnZtZEMDwEZDbg6sFQRx+eoNaYmYOJd3Rn/NdheeN7/ZQiRikOOUIszbMWHOqaGuFT3sWoVJe+ITnlQ9bwOXdBTZ6ylvfuZTlf1Ioy/+ShOMguFtm+rGy8hCSNhFVeTgze77nVAWKV+SqxIVL82EyfSrSCbwUwGB7KRWU3SRE8oeUj18I0hhFOyrQg5APGZJylJfFpRjw6IklGQRN/3Y6nGcTdZZ2YxRafUtv1FKj21D05KFCDO3fT8O6+qSTlGi2wrMKxWdp4lDpY6aA43HCk2+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=044rA3LJcVocqpK9eusqsw7tTEDPFbpxMZrpiVZHfkU=;
 b=e/6Y80POmFutEfqRZxxGVbnxDRS7j2vCkaSVou8vIzdO5YdbspvUJkflqrsqAIDoXepm5iCKYnLrR+JPlGq9kcFmDRKMeAY9Q2N07hIt7uxxOVt4IF23glU3MPo6H/+0AH3bbPcCz7J4hXGtJu+zjO4xEylmvl0G6X+aFwc+FIzwmT5tnbMtaeTdUkiQqo/kxe8y2ryjQInR4nFUpFO9Ajv2oJ263De1OIC77gadWPlsMtWSHtQ/WmwuMwLiziFQQt2Rty3339nKVQ8+BX25b2oTFAjJ8+s/mnI/ZoXv0AjdeI+/dcFKc/LDN+yGMj2hwpyEMA7xDkabtlPaPt2Gbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=044rA3LJcVocqpK9eusqsw7tTEDPFbpxMZrpiVZHfkU=;
 b=s05kljcybXPVf04MP0/ihiAtzpj7IK7/xxYUfV6P6iRatpYCcv9hx3igml5ah1kcTI5w6DBTb/BFYz5AkvOXxSGQRlbIvhMGxOf5AjXQqOQ31TS4jA0H/9H1Sa91r9qDaRqwyf8KuDYpH66iXdU6eVPU3IcanjgAI2gPXUnCr5w=
Received: from BN0PR04CA0015.namprd04.prod.outlook.com (2603:10b6:408:ee::20)
 by BN7PPF7C0ACC722.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6d5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Thu, 22 May
 2025 03:45:07 +0000
Received: from BL02EPF00021F6D.namprd02.prod.outlook.com
 (2603:10b6:408:ee:cafe::11) by BN0PR04CA0015.outlook.office365.com
 (2603:10b6:408:ee::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.31 via Frontend Transport; Thu,
 22 May 2025 03:45:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6D.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 22 May 2025 03:45:07 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 May
 2025 22:45:06 -0500
Received: from hjbog-srdc-17.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 21 May 2025 22:45:04 -0500
From: Samuel Zhang <guoqing.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <victor.zhao@amd.com>, <haijun.chang@amd.com>, <guoqing.zhang@amd.com>,
 <Christian.Koenig@amd.com>, <Alexander.Deucher@amd.com>,
 <Owen.Zhang2@amd.com>, <Qing.Ma@amd.com>, <Lijo.Lazar@amd.com>,
 <Emily.Deng@amd.com>
Subject: [PATCH v7 3/4] drm/amdgpu: enable pdb0 for hibernation on SRIOV
Date: Thu, 22 May 2025 11:43:49 +0800
Message-ID: <20250522034350.433219-4-guoqing.zhang@amd.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250522034350.433219-1-guoqing.zhang@amd.com>
References: <20250522034350.433219-1-guoqing.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: guoqing.zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6D:EE_|BN7PPF7C0ACC722:EE_
X-MS-Office365-Filtering-Correlation-Id: a46bdd41-ed25-47a2-50fd-08dd98e30b71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fjRUPN542Jb3q6R7i6r3j49ghcleQuJAwzj/I/riwBwtnpIrXuFFttYUfutp?=
 =?us-ascii?Q?PvnYR9AQK0HExRBNg5JK7No5D0LKweUmg8/INpraL/vca+b6OlkPNocMnKa9?=
 =?us-ascii?Q?tbCOfFAp/DWeNFc9IiRIOgz+u+HfwwKP7Y6/OsAMX+HhSlpbkWSexo/DSMsj?=
 =?us-ascii?Q?/+Sr7o1wXSjQlI7Kjof9kMYDGU8UDrv7AmtzAUwe8sqvNzpGB7RQ3xEeUTWt?=
 =?us-ascii?Q?Fpfl956woiIRUxQ1y3+bmoZiF8N8F9QMIsLUpIqMEqgD4MmUF2UxRWEF8+yp?=
 =?us-ascii?Q?oXT218a4uBLud1f4eiqofBUDaVnUjrKmwYnbzzA4lMvpalh7+dr/uat8Hm/9?=
 =?us-ascii?Q?a+lxburida4l85Wjf9QlrM598XF+ixjfROYok4mYvKlUWYMYaKCB7gDjNb9g?=
 =?us-ascii?Q?KG3VOAcYRsLDNUe8Y4E4KVXvkZmYPOKrv2y7RA0ypwj1/K+7dZBNeIJ5N39D?=
 =?us-ascii?Q?uUa/7NaGo2lDQLdpl43lIlwoeCKKxxZvM4qJO/YAFniGU99d1UcHZFl8YGyn?=
 =?us-ascii?Q?BLs8CxreKRFtHUuAmYt8jk/gNGB/ITD95KXvf4ntEeITX09hSAcR7tmYwD6V?=
 =?us-ascii?Q?SnZPXlQxLxQ/AaHapq/3oefAKb4BMrDhhR4CtbQgBENVXXzPWSa5c5XKssMq?=
 =?us-ascii?Q?QQ3EBb3afHGJ4RvI84RtKAgfYFSjqlt79vlgWdDNxIguPReG5QDud2y/og0k?=
 =?us-ascii?Q?5ozXvgOfPE5c1ps0MOzveflrjBsopTVxM/8E8J3UCJphIzSxtssHiAxbedRv?=
 =?us-ascii?Q?1G0C2dMjmm2ertogd8sY/JG86LZqHbxqp6sno+dCs8eBPsRxYdRpZH0CNt/p?=
 =?us-ascii?Q?6BGOU360+k5nXR3xwvumdFCb8H8slcJZNQr+CGntmeA3xekdCEKhKqhH9doZ?=
 =?us-ascii?Q?VNAYPD0RsRHPv0uekEzXWbwClK/4DJMrZOyvJTM9C8hB6WNLJK1mtjdhlk28?=
 =?us-ascii?Q?ahUnE0FPacONVe5CAAqyAK93oxQVMVAetEd29pqKM3DqoDn8q8OVUoChRsII?=
 =?us-ascii?Q?OiUfwJ1xPy4bKINmy3R08XNbMXQiW0+tyR5CN6Bs5aSQTyKdLPoLKOCYiqsD?=
 =?us-ascii?Q?EhRZANiIEN/NPQzjwujlRJ7+OyuXLhhfoDo5SvafYw155zzPrImL4I1dfa3X?=
 =?us-ascii?Q?IP8EcnJ8W7WD7NfEVmaSr0VMfnxhOF/xXI5Mms7b4IHxamAdYDU00C1s/Z5z?=
 =?us-ascii?Q?IMI9M5jo3NBAV/ljRBp67omoOlDVkWiDH+hPKKzvG5fjlTOPOTKndVQRAO1i?=
 =?us-ascii?Q?gedDxd9jb3s9Iw4Nk/JK6k5BXNuD+9WcWBY9cCUZkInBDrjlYxM35BHPURXT?=
 =?us-ascii?Q?JhhVS2gAQgXpoMr/dc5r9vsfF6SGvUiyIkuvUeTYzQDlzJnSOPwKctKMfH67?=
 =?us-ascii?Q?LE9MDOyhglCPn0wF4/wt46BVnNOuMlr2jE3x8ZYCv1HzVWWw2TDoR3G2LTe8?=
 =?us-ascii?Q?96naGtM+WD7OKZMi4iLJ6G4dyuShiJKlk2Xv4V7hsoB1EMJdjYUdFBDLfhok?=
 =?us-ascii?Q?GCk8fX1f3kfbjgTv/ra+ciXbv8wGS1QPbOom?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 03:45:07.2982 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a46bdd41-ed25-47a2-50fd-08dd98e30b71
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF7C0ACC722
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

When switching to new GPU index after hibernation and then resume,
VRAM offset of each VRAM BO will be changed, and the cached gpu
addresses needed to updated.

This is to enable pdb0 and switch to use pdb0-based virtual gpu
address by default in amdgpu_bo_create_reserved(). since the virtual
addresses do not change, this can avoid the need to update all
cached gpu addresses all over the codebase.

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    | 23 ++++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 13 ++++++++----
 4 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index e5bb46effb6c..97389168c90f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5065,6 +5065,10 @@ static inline int amdgpu_virt_resume(struct amdgpu_device *adev)
 	adev->vm_manager.vram_base_offset +=
 		adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size;
 
+	/* fb_start/fb_end may be reset in get_fb_location(), set it again on resume */
+	adev->gmc.fb_start = 0;
+	adev->gmc.fb_end = adev->gmc.xgmi.node_segment_size * adev->gmc.xgmi.num_physical_nodes - 1;
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index d1fa5e8e3937..35df4be6ef2a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -38,6 +38,8 @@
 #include <drm/drm_drv.h>
 #include <drm/ttm/ttm_tt.h>
 
+static const u64 four_gb = 0x100000000ULL;
+
 /**
  * amdgpu_gmc_pdb0_alloc - allocate vram for pdb0
  *
@@ -251,7 +253,17 @@ void amdgpu_gmc_sysvm_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc
 	u64 hive_vram_end = mc->xgmi.node_segment_size * mc->xgmi.num_physical_nodes - 1;
 	mc->vram_start = mc->xgmi.node_segment_size * mc->xgmi.physical_node_id;
 	mc->vram_end = mc->vram_start + mc->xgmi.node_segment_size - 1;
-	mc->gart_start = hive_vram_end + 1;
+	if (amdgpu_virt_xgmi_migrate_enabled(adev)) {
+		/* set mc->vram_start to 0 to switch the returned GPU address of
+		 * amdgpu_bo_create_reserved() from FB aperture to GART aperture.
+		 */
+		mc->vram_start = 0;
+		mc->vram_end = mc->vram_start + mc->mc_vram_size - 1;
+		if (mc->real_vram_size < mc->visible_vram_size)
+			mc->visible_vram_size = mc->real_vram_size;
+	}
+	/* node_segment_size may not 4GB aligned on SRIOV, align up is needed. */
+	mc->gart_start = ALIGN(hive_vram_end + 1, four_gb);
 	mc->gart_end = mc->gart_start + mc->gart_size - 1;
 	mc->fb_start = hive_vram_start;
 	mc->fb_end = hive_vram_end;
@@ -276,7 +288,6 @@ void amdgpu_gmc_sysvm_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc
 void amdgpu_gmc_gart_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc,
 			      enum amdgpu_gart_placement gart_placement)
 {
-	const uint64_t four_gb = 0x100000000ULL;
 	u64 size_af, size_bf;
 	/*To avoid the hole, limit the max mc address to AMDGPU_GMC_HOLE_START*/
 	u64 max_mc_address = min(adev->gmc.mc_mask, AMDGPU_GMC_HOLE_START - 1);
@@ -1068,6 +1079,14 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev)
 	flags |= AMDGPU_PTE_FRAG((adev->gmc.vmid0_page_table_block_size + 9*1));
 	flags |= AMDGPU_PDE_PTE_FLAG(adev);
 
+	if (amdgpu_virt_xgmi_migrate_enabled(adev)) {
+		/* always start from current device so that the GART address can keep
+		 * consistent when hibernate-resume with different GPUs.
+		 */
+		vram_addr = adev->vm_manager.vram_base_offset;
+		vram_end = vram_addr + vram_size;
+	}
+
 	/* The first n PDE0 entries are used as PTE,
 	 * pointing to vram
 	 */
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
index cb25f7f0dfc1..e6165f6d0763 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
@@ -180,7 +180,7 @@ gfxhub_v1_2_xcc_init_system_aperture_regs(struct amdgpu_device *adev,
 		/* In the case squeezing vram into GART aperture, we don't use
 		 * FB aperture and AGP aperture. Disable them.
 		 */
-		if (adev->gmc.pdb0_bo) {
+		if (adev->gmc.pdb0_bo && !amdgpu_virt_xgmi_migrate_enabled(adev)) {
 			WREG32_SOC15(GC, GET_INST(GC, i), regMC_VM_FB_LOCATION_TOP, 0);
 			WREG32_SOC15(GC, GET_INST(GC, i), regMC_VM_FB_LOCATION_BASE, 0x00FFFFFF);
 			WREG32_SOC15(GC, GET_INST(GC, i), regMC_VM_AGP_TOP, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 59385da80185..23d02965ad65 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -413,6 +413,11 @@ static const uint32_t ecc_umc_mcumc_ctrl_mask_addrs[] = {
 	(0x001d43e0 + 0x00001800),
 };
 
+static inline bool gmc_v9_0_is_pdb0_enabled(struct amdgpu_device *adev)
+{
+	return adev->gmc.xgmi.connected_to_cpu || amdgpu_virt_xgmi_migrate_enabled(adev);
+}
+
 static inline bool gmc_v9_0_is_multi_chiplet(struct amdgpu_device *adev)
 {
 	return !!adev->aid_mask;
@@ -1726,7 +1731,7 @@ static void gmc_v9_0_vram_gtt_location(struct amdgpu_device *adev,
 
 	/* add the xgmi offset of the physical node */
 	base += adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size;
-	if (adev->gmc.xgmi.connected_to_cpu) {
+	if (gmc_v9_0_is_pdb0_enabled(adev)) {
 		amdgpu_gmc_sysvm_location(adev, mc);
 	} else {
 		amdgpu_gmc_vram_location(adev, mc, base);
@@ -1841,7 +1846,7 @@ static int gmc_v9_0_gart_init(struct amdgpu_device *adev)
 		return 0;
 	}
 
-	if (adev->gmc.xgmi.connected_to_cpu) {
+	if (gmc_v9_0_is_pdb0_enabled(adev)) {
 		adev->gmc.vmid0_page_table_depth = 1;
 		adev->gmc.vmid0_page_table_block_size = 12;
 	} else {
@@ -1867,7 +1872,7 @@ static int gmc_v9_0_gart_init(struct amdgpu_device *adev)
 		if (r)
 			return r;
 
-		if (adev->gmc.xgmi.connected_to_cpu)
+		if (gmc_v9_0_is_pdb0_enabled(adev))
 			r = amdgpu_gmc_pdb0_alloc(adev);
 	}
 
@@ -2372,7 +2377,7 @@ static int gmc_v9_0_gart_enable(struct amdgpu_device *adev)
 {
 	int r;
 
-	if (adev->gmc.xgmi.connected_to_cpu)
+	if (gmc_v9_0_is_pdb0_enabled(adev))
 		amdgpu_gmc_init_pdb0(adev);
 
 	if (adev->gart.bo == NULL) {
-- 
2.43.5

