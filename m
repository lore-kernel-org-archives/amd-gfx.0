Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 529E0C2D0CD
	for <amd-gfx@archiver.kernel.org>; Mon, 19 May 2025 08:22:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED8FE10E219;
	Mon, 19 May 2025 08:22:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J03+2/nK";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2081.outbound.protection.outlook.com [40.107.212.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EE8810E219
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 May 2025 08:22:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fZdPGYRP4sTZmxKytb0xwwQkXCRO74iEDiCPDxfaSxHtycvj1+emlv/ltbZIv0tuhdCP3FgF3NQaaSPXx+pEXaEciDE2pL7KsCQIch7A1XD8MDRIJeYfuQcr3d+kt9Xjwr6FMpabyQU+Reu3rOPJIcefHUxliL64rkGq+XnFemmg+AsG/E8O512MMyfPyHV/VqIxSIND2ckDJ/GVHM4GaFhH6bHbOVYGoiS1GYIuEcmxP8ZeVafgT+XqT+Mc5o7EK4Lh3L7O3a9AUpjiSLnHPjA9jVzO4kYEB5SgcAOVQKIdHt/JGVJmK9M/uq5FbXFbSqtbSLbfF5m+Pq7OsHk73A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c7Jxw5sBOsKbvGXv30qxVEkT+YyKyU7eEoVQOGVwses=;
 b=vuf9LFyrlp0vJdoTNxdSNe0fli3kS2Xv2WjDIlnrAYJ2QCJpRwuqQZarViwVa2+4TS13sAPJ0wTp7YDUkWfR3JXRNhJBfThFjZsVdUWl/F5oJxc763nSgcGQSOCIvDt4U5d4Aw24amZLWhlaQ+5AGy5TWNKS7DaDR8XL3QsABiExv1jsXypEB5wEOjAYxJpQNMEVsGYwkr/VatdKRw26J/cmDj+Ujm9Eb5kxdxVxC0drj+jIriAJNv+XTZGMJWLUHyDJRgkdoYlUhKXLqGfXJyFT+RLE69v8NzzlSdcj1l/RlICIMAKJ0n3p2rKWpz2OoStsMjqMc3e0IbsdoCoDdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7Jxw5sBOsKbvGXv30qxVEkT+YyKyU7eEoVQOGVwses=;
 b=J03+2/nK4Wsn8m7dZe3DvhhZaTd6Qempfcjeyy7i92sdUjLu8cwT+v+zumb+WNwOTz0UHGjnHYC4rAohh6NqMCPbEEyJ/0XFsVLe6kyiiGoRgWvLVPAkJHTOJrmLAKscj9Mjc3uAf8d6NWcJCTjzV3Z3YvuhQ9KUi2mEREdDZ8w=
Received: from SJ0PR03CA0086.namprd03.prod.outlook.com (2603:10b6:a03:331::31)
 by SN7PR12MB7202.namprd12.prod.outlook.com (2603:10b6:806:2a9::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Mon, 19 May
 2025 08:22:21 +0000
Received: from SJ5PEPF000001CB.namprd05.prod.outlook.com
 (2603:10b6:a03:331:cafe::8f) by SJ0PR03CA0086.outlook.office365.com
 (2603:10b6:a03:331::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.29 via Frontend Transport; Mon,
 19 May 2025 08:22:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CB.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Mon, 19 May 2025 08:22:21 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 19 May
 2025 03:22:18 -0500
Received: from hjbog-srdc-17.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 19 May 2025 03:22:15 -0500
From: Samuel Zhang <guoqing.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <victor.zhao@amd.com>, <haijun.chang@amd.com>, <guoqing.zhang@amd.com>,
 <Christian.Koenig@amd.com>, <Alexander.Deucher@amd.com>,
 <Owen.Zhang2@amd.com>, <Qing.Ma@amd.com>, <Lijo.Lazar@amd.com>, Emily Deng
 <Emily.Deng@amd.com>
Subject: [PATCH v6 3/4] drm/amdgpu: enable pdb0 for hibernation on SRIOV
Date: Mon, 19 May 2025 16:20:37 +0800
Message-ID: <20250519082038.21459-4-guoqing.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CB:EE_|SN7PR12MB7202:EE_
X-MS-Office365-Filtering-Correlation-Id: 585a1268-6a58-429b-47a2-08dd96ae46fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mbLH6mCJ4TbyMO5RPfAvvoU+nAN4OQu4iHAxVH3O/XxwCuZ6cdkHPPJAtt9B?=
 =?us-ascii?Q?OH0K+NJYhc5rWdxSOP7Jg37wgzdyV42uGoZl6woyh3Qwps2fZLL5qg5acL51?=
 =?us-ascii?Q?OKl+CWYCQGt6V0SP2/4/sG+cCwieWkfDXxk6YRUV2Ljqes7sqD33mwlglikQ?=
 =?us-ascii?Q?kDAkkGUNU92kzBbemjenhOY87dEWgWEqPBRTOu3KebEkbsns1aynpd8Awe3S?=
 =?us-ascii?Q?BmV3o7AbtYMzr7wU1DmJgO5u90I9CjJGFYOdynTNiQ6FC0j0M85ZN2IeeOFk?=
 =?us-ascii?Q?kA+Ok1TeGUbTYmji1enzIAwJeZZJ2dJwn4XO7rt6Qwliq4L1S1lGkS49B6Yw?=
 =?us-ascii?Q?TMXDlsasRkmrJr1AX/KyGuJjwxi0rH2m8WIdje+UDhY0DpqKd+qVKRZ1eK6S?=
 =?us-ascii?Q?E6v0PnShgp4g0su3QXklb7Yh6lBBS0c6eGfDZO+wJdqk+8IQzTFyHPJNdLvy?=
 =?us-ascii?Q?XahohwQCIKxMhLHaXfacRUfBrH5nBf9hMpasmk940q7CSn3Il6BSLpfAMWGm?=
 =?us-ascii?Q?5huqG4PCd90WT4XgD/1Ber1KYb7YBaSX80XH9uTvN8fw12SBPxRlDSFv4fmj?=
 =?us-ascii?Q?7Fu8l1NNv62QKwrFjAcA+VL1V5Stb840Z2lGRcx/QWr/GWkN2fKJ4gT1Mrts?=
 =?us-ascii?Q?iKWHLz98sp2ebKwKAUCl7pcm4al3a+8NFFzhVQPi+vsak7adt6PVbJbmDazz?=
 =?us-ascii?Q?2vqc5Xio27nxoaVjRGbSrg7BdYfzj7xO6pwLKJPK4DsuyD+ONHYhFwv18KJs?=
 =?us-ascii?Q?T3/xpyqzUlle/d01yf5a3cIF930g1ftGON5IfjI5e9UNVUTsgQmkyzXNuKVA?=
 =?us-ascii?Q?cJBedlfy26F/izmYDJartOWPQhhwSaMrMJmWUOholT1I3Ut98elnE7fZgMU5?=
 =?us-ascii?Q?2FWsWSkZ5WMYp/w78LVWUN37K27vJJRs//cynwI4UtTQFz7UxlQ78Wmsa5VC?=
 =?us-ascii?Q?PSZdPmGKptDPX/8X0mJyM+AG2puztZk6ijOgRC/6FoZEw4hWcnxshPyIVNMW?=
 =?us-ascii?Q?w+p5ODyYVFou/t7GizfLDXBTFJ5gwPZeqvdderp4Kq2RFBCeohkC9iGyVkka?=
 =?us-ascii?Q?3n5NWLovRCihU3dOgPkAF/BZ450j38xnlyQbwflXfcSGQh8nPAiWz2byiJzX?=
 =?us-ascii?Q?dYV+g4wV6a1zVXAgkvazPdLn6TJlO0zH6RbNbsF/CETjyBQhEMQWM8EfDgYO?=
 =?us-ascii?Q?6+8R5fk1B2ABAeJeT0FQgC0PkSSDmwerX/b4ecwbRciY2gFwyhozgKDzH3kC?=
 =?us-ascii?Q?JAS8tO2M2BAHNTwsn60IRH4e/O1s3oW+WMIJhG/FAlXjLpw0aZKtfTf3nYG5?=
 =?us-ascii?Q?75fHLbag92f4wLyVveu6q1gpUpOv8ZaTBjwng/W/ptDbKjGyHgfYx3VgnD4C?=
 =?us-ascii?Q?JTDYGX0W2d1MuC/G0D5y6cPo0a9vbfX5+utPhYnm7hvNZoeuPxfTMwI0MifB?=
 =?us-ascii?Q?bf28btIPXEVcjtPiWJ4Dyo8aoPrfKh3FDOM+QIXzqcQ6Sy9pHApPulzbuKau?=
 =?us-ascii?Q?dVzEDcxOGFbQOEkEN8oKgRf9I+Tukr2XiUrv?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 08:22:21.4709 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 585a1268-6a58-429b-47a2-08dd96ae46fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7202
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c  | 32 ++++++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h  |  1 +
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c    | 10 +++++---
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c  |  6 +++--
 5 files changed, 37 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index d1fa5e8e3937..265d6c777af5 100644
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
@@ -249,15 +251,24 @@ void amdgpu_gmc_sysvm_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc
 {
 	u64 hive_vram_start = 0;
 	u64 hive_vram_end = mc->xgmi.node_segment_size * mc->xgmi.num_physical_nodes - 1;
-	mc->vram_start = mc->xgmi.node_segment_size * mc->xgmi.physical_node_id;
-	mc->vram_end = mc->vram_start + mc->xgmi.node_segment_size - 1;
-	mc->gart_start = hive_vram_end + 1;
+
+	if (amdgpu_virt_xgmi_migrate_enabled(adev)) {
+		/* set mc->vram_start to 0 to switch the returned GPU address of
+		 * amdgpu_bo_create_reserved() from FB aperture to GART aperture.
+		 */
+		amdgpu_gmc_vram_location(adev, mc, 0);
+	} else {
+		mc->vram_start = mc->xgmi.node_segment_size * mc->xgmi.physical_node_id;
+		mc->vram_end = mc->vram_start + mc->xgmi.node_segment_size - 1;
+		dev_info(adev->dev, "VRAM: %lluM 0x%016llX - 0x%016llX (%lluM used)\n",
+				mc->mc_vram_size >> 20, mc->vram_start,
+				mc->vram_end, mc->real_vram_size >> 20);
+	}
+	/* node_segment_size may not 4GB aligned on SRIOV, align up is needed. */
+	mc->gart_start = ALIGN(hive_vram_end + 1, four_gb);
 	mc->gart_end = mc->gart_start + mc->gart_size - 1;
 	mc->fb_start = hive_vram_start;
 	mc->fb_end = hive_vram_end;
-	dev_info(adev->dev, "VRAM: %lluM 0x%016llX - 0x%016llX (%lluM used)\n",
-			mc->mc_vram_size >> 20, mc->vram_start,
-			mc->vram_end, mc->real_vram_size >> 20);
 	dev_info(adev->dev, "GART: %lluM 0x%016llX - 0x%016llX\n",
 			mc->gart_size >> 20, mc->gart_start, mc->gart_end);
 }
@@ -276,7 +287,6 @@ void amdgpu_gmc_sysvm_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc
 void amdgpu_gmc_gart_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc,
 			      enum amdgpu_gart_placement gart_placement)
 {
-	const uint64_t four_gb = 0x100000000ULL;
 	u64 size_af, size_bf;
 	/*To avoid the hole, limit the max mc address to AMDGPU_GMC_HOLE_START*/
 	u64 max_mc_address = min(adev->gmc.mc_mask, AMDGPU_GMC_HOLE_START - 1);
@@ -1068,6 +1078,14 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev)
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
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index bd7fc123b8f9..46fac7ca7dfa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -307,6 +307,7 @@ struct amdgpu_gmc {
 	struct amdgpu_bo		*pdb0_bo;
 	/* CPU kmapped address of pdb0*/
 	void				*ptr_pdb0;
+	bool pdb0_enabled;
 
 	/* MALL size */
 	u64 mall_size;
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
index 59385da80185..04fb99c64b37 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1682,6 +1682,8 @@ static int gmc_v9_0_early_init(struct amdgpu_ip_block *ip_block)
 		adev->gmc.private_aperture_start + (4ULL << 30) - 1;
 	adev->gmc.noretry_flags = AMDGPU_VM_NORETRY_FLAGS_TF;
 
+	adev->gmc.pdb0_enabled = adev->gmc.xgmi.connected_to_cpu ||
+		amdgpu_virt_xgmi_migrate_enabled(adev);
 	return 0;
 }
 
@@ -1726,7 +1728,7 @@ static void gmc_v9_0_vram_gtt_location(struct amdgpu_device *adev,
 
 	/* add the xgmi offset of the physical node */
 	base += adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size;
-	if (adev->gmc.xgmi.connected_to_cpu) {
+	if (adev->gmc.pdb0_enabled) {
 		amdgpu_gmc_sysvm_location(adev, mc);
 	} else {
 		amdgpu_gmc_vram_location(adev, mc, base);
@@ -1841,7 +1843,7 @@ static int gmc_v9_0_gart_init(struct amdgpu_device *adev)
 		return 0;
 	}
 
-	if (adev->gmc.xgmi.connected_to_cpu) {
+	if (adev->gmc.pdb0_enabled) {
 		adev->gmc.vmid0_page_table_depth = 1;
 		adev->gmc.vmid0_page_table_block_size = 12;
 	} else {
@@ -1867,7 +1869,7 @@ static int gmc_v9_0_gart_init(struct amdgpu_device *adev)
 		if (r)
 			return r;
 
-		if (adev->gmc.xgmi.connected_to_cpu)
+		if (adev->gmc.pdb0_enabled)
 			r = amdgpu_gmc_pdb0_alloc(adev);
 	}
 
@@ -2372,7 +2374,7 @@ static int gmc_v9_0_gart_enable(struct amdgpu_device *adev)
 {
 	int r;
 
-	if (adev->gmc.xgmi.connected_to_cpu)
+	if (adev->gmc.pdb0_enabled)
 		amdgpu_gmc_init_pdb0(adev);
 
 	if (adev->gart.bo == NULL) {
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
index 84cde1239ee4..18e80aa78aff 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
@@ -45,8 +45,10 @@ static u64 mmhub_v1_8_get_fb_location(struct amdgpu_device *adev)
 	top &= MC_VM_FB_LOCATION_TOP__FB_TOP_MASK;
 	top <<= 24;
 
-	adev->gmc.fb_start = base;
-	adev->gmc.fb_end = top;
+	if (!amdgpu_virt_xgmi_migrate_enabled(adev)) {
+		adev->gmc.fb_start = base;
+		adev->gmc.fb_end = top;
+	}
 
 	return base;
 }
-- 
2.43.5

