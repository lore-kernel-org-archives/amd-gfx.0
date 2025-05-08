Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D704C3ABBE
	for <amd-gfx@archiver.kernel.org>; Thu,  8 May 2025 05:10:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C67A110E2E4;
	Thu,  8 May 2025 05:10:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="r+/35O6s";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F16710E2E2
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 May 2025 05:10:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rJQep4CUSvxleRQLmDMzuJBjzQPEJ7E1O8m9+JDAhAc7p53LjvrkkSv/cUMLmQtpx8T3S2VPho1HueV2giW4alPJ4GkW5rBiGMNnz8Io8xRFp9AeBZCd2AzQBOjMsxiUiD6W/xU/vysIcSJ82ne8cMLhhn0REoNQs71a+wBxEd1xqKy1VzAYeFUB7dAc2dd2MHAiaw2Zfvhs/sdNPTOYPEiDmTXNTCx0iylL0kvGTxhAFWl1RkwuRSN9gqEW9Lq69ppkIM9nRhlAtBFoYS/AaO9iesCY+81E4bWNzMvUnxnTKn+GuU9Dd2aZxpEZ28FVyW2F640oBRMzOVzD72rjxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dAabFGCTol7piol4a5i81GkfTYRo2yjxnQ0s5aKEatM=;
 b=ccDDGq8/apKJ+2aQheOY7v8WkGRj/AXlgqWvdJL1IjlVNBiUE6xZXOWaXccBkH8nqKHRdpIUy5eZUuoLD7PltDFNOqUuDMqL7s9PEUhhUiU9eEKJ7GJ4PXd73FkfOs7QMf5FlNRYh7CgqcmYco14SkrwQRxt6XA6clharW1SBuKETy5OnphWBqwrb+E8PYAWcfUo0IPaQK/gFKCHKz0jFIULyaI/hySMFRwYt/YrQFEQoJjtIY7nuIL1CS+J0JyyAKiYA1xe0mAFEm4UbuLmX9GPE8f8EmMzz5uQV5F+xhLPEw6ZIZ+81TGRMSVqui8uo4sJRhaxOsPi1Fop7ffI2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dAabFGCTol7piol4a5i81GkfTYRo2yjxnQ0s5aKEatM=;
 b=r+/35O6sNp9GZ8nQE8MF5XONwwKAh55wRy1HAZoJ8P5yBH3uOfxKJwBh3BEZCo8fYlvb74N8oR8VuTD4tJAtwQxoywKaQtogBulUIakLiKk9Uy4RolYMlDUE/z3wO28v0TSimbZhPz5jHFy36z2ykGoN+a3xRaJjgBUoNrtIjD4=
Received: from SJ2PR07CA0022.namprd07.prod.outlook.com (2603:10b6:a03:505::24)
 by SN7PR12MB6911.namprd12.prod.outlook.com (2603:10b6:806:261::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.22; Thu, 8 May
 2025 05:10:09 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2603:10b6:a03:505:cafe::d3) by SJ2PR07CA0022.outlook.office365.com
 (2603:10b6:a03:505::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.33 via Frontend Transport; Thu,
 8 May 2025 05:10:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Thu, 8 May 2025 05:10:07 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 8 May
 2025 00:10:07 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 8 May
 2025 00:10:06 -0500
Received: from hjbog-srdc-17.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 8 May 2025 00:10:04 -0500
From: Samuel Zhang <guoqing.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <victor.zhao@amd.com>, <haijun.chang@amd.com>, <guoqing.zhang@amd.com>,
 <Christian.Koenig@amd.com>, <Alexander.Deucher@amd.com>,
 <Owen.Zhang2@amd.com>, <Qing.Ma@amd.com>, Emily Deng <Emily.Deng@amd.com>
Subject: [PATCH v4 3/7] drm/amdgpu: enable pdb0 for hibernation on SRIOV
Date: Thu, 8 May 2025 13:09:22 +0800
Message-ID: <20250508050926.228674-4-guoqing.zhang@amd.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250508050926.228674-1-guoqing.zhang@amd.com>
References: <20250508050926.228674-1-guoqing.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|SN7PR12MB6911:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a256982-9aad-4e43-4783-08dd8dee99d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BD0tfxCfurJNUbLHuZrPjdS49/m8r0sNequcU6PRmxk4P8w8EzLAxK47/ZyA?=
 =?us-ascii?Q?uZPL6qm5qxCHv9f7ndZoPa89bJi0wpKf8R5Uf36Z9hDuxgcmb2+kJYAKW9u9?=
 =?us-ascii?Q?l5aVX3JDB6VF9cbnooWNeXu+qKVHALdbRbryiJhmu0LK3kTmF/UTif35xIHn?=
 =?us-ascii?Q?o1iZk+k9vG89zw0QpFDidyYyQUGVqIO7Ar0H1R+41f97LIL/Q5vNGsaUtQaq?=
 =?us-ascii?Q?Pti8+XVTz/kgaLcT9ZX/SxDcnYkZGuT231s9byfJN24B/tvZH1w0nyWvIHpf?=
 =?us-ascii?Q?JawytI8gGq4UYsr82uYFKl3xLm3WmNzhvGWX3rwsZd/7JLhlc41VzEw5numU?=
 =?us-ascii?Q?RYG2+a46Kyzqv0722Lb5m9qPuYKuC//tHQpcMxZfkXrMAMO+z7fKutOsnPk5?=
 =?us-ascii?Q?ticGwi2qfrtibnk7SeIkbhnn1yeLXHHXOPP7lcYnUIU3MPA/lmOTvBULj1J5?=
 =?us-ascii?Q?cbRGS1FMKtJTTF5fenpiyzLeY7lYxUr1xoNdZ6NkrI60wxNark0iBIlZ8gqF?=
 =?us-ascii?Q?+kBYc9642wZz2v+pZcpXAl92JOUwuefrcbUxZla0W34h+p1baRaEHBpa4/kV?=
 =?us-ascii?Q?kyyrpdKXaGTDlKdT/fHXqUEZ9b5sZrftcLDXAERPTEjld7pjVcF1FXMc/OBL?=
 =?us-ascii?Q?gR85GHREnOAV5BtguclqZNnZIsgpScHotOlNYQuBARXryE0q4/O5TocrzyQY?=
 =?us-ascii?Q?U4MV1rBiAmHpTnSx2U0l7YnW3V/drwBahbglVOjhAwGJwgG92yvkD/U/28Dp?=
 =?us-ascii?Q?gHa2zUlN4ScG/ulA/mrPg3SwJfBmOusUGqBtjMRpNv8MD1shDcZTp5DOAfDK?=
 =?us-ascii?Q?qnxJbZQNm5P95Oe3z3EVL7SZiRM4Qhl98faRhaQySsIFt2nJK/RYcKH2g1pI?=
 =?us-ascii?Q?onbg8bPUn57YA6kaw8NRCI7KhcBuf5MdNKrDtMJ40NKuBetcC5a28D36DOXI?=
 =?us-ascii?Q?9lR/VXFf3anVH5MYWZ2Q1rEDHbKW7uJLEoiv0DaKct79lS5Fvy/tj//wtfSb?=
 =?us-ascii?Q?m77bZOhx1PTUUnOw6D11TM9lA6CqwpJRgehae8ihEJdVzIZiNCgh3aEEpcSG?=
 =?us-ascii?Q?UgYUWCGNpSlzKo2T91Uagka60e4YAur4zCjC0xxiERQOw218nzMtix30rIL0?=
 =?us-ascii?Q?r98mRYO1913gw/wOyaClTaVLFBc9HY4HOkvIMNeKHlZWDho8Lo+/LLRoX/lP?=
 =?us-ascii?Q?EBLE9CZQ8V9bjdksDZkzbCUo+Zsm7wB48zIyYzparJa29nOT+GFzXtkNcpU0?=
 =?us-ascii?Q?c0TJnIMSXyhTg9mBItna3iGr2kjqAWOl7uCvoLwMNcngbuk+5CRASRWzEAE0?=
 =?us-ascii?Q?2OCCJadR1o54CgfyZ6QKdcRLnt9lBrSkHPLvtpIA2cXxRSRJjTrq7CKdq8/9?=
 =?us-ascii?Q?hDMg5RbKj73Da4J0HoLHlmVufsqpDUclF5WAhdCj3yAThJUjLsjfdd50rSvD?=
 =?us-ascii?Q?nbwYtcQlfjZz2fFfBM/BMH9lRg5t1THNOrdzrZ/AsiAju2PjlBO7X1H0NT+X?=
 =?us-ascii?Q?4U/3g/IeMxajE2qlscaV/bWttWOMWsPLZGE7?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 05:10:07.7834 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a256982-9aad-4e43-4783-08dd8dee99d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6911
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
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c    | 13 +++++++---
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c  |  6 +++--
 5 files changed, 40 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index d1fa5e8e3937..c7179e5f7f78 100644
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
+	if (adev->gmc.xgmi.connected_to_cpu) {
+		mc->vram_start = mc->xgmi.node_segment_size * mc->xgmi.physical_node_id;
+		mc->vram_end = mc->vram_start + mc->xgmi.node_segment_size - 1;
+		dev_info(adev->dev, "VRAM: %lluM 0x%016llX - 0x%016llX (%lluM used)\n",
+				mc->mc_vram_size >> 20, mc->vram_start,
+				mc->vram_end, mc->real_vram_size >> 20);
+	} else {
+		/* set mc->vram_start to 0 to switch the returned GPU address of
+		 * amdgpu_bo_create_reserved() from FB aperture to GART aperture.
+		 */
+		amdgpu_gmc_vram_location(adev, mc, 0);
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
 
+	if (!adev->gmc.xgmi.connected_to_cpu) {
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
index bd7fc123b8f9..758b47240c6f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -307,6 +307,7 @@ struct amdgpu_gmc {
 	struct amdgpu_bo		*pdb0_bo;
 	/* CPU kmapped address of pdb0*/
 	void				*ptr_pdb0;
+	bool enable_pdb0;
 
 	/* MALL size */
 	u64 mall_size;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
index cb25f7f0dfc1..5ebb92ac9fd7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
@@ -180,7 +180,7 @@ gfxhub_v1_2_xcc_init_system_aperture_regs(struct amdgpu_device *adev,
 		/* In the case squeezing vram into GART aperture, we don't use
 		 * FB aperture and AGP aperture. Disable them.
 		 */
-		if (adev->gmc.pdb0_bo) {
+		if (adev->gmc.pdb0_bo && !amdgpu_sriov_vf(adev)) {
 			WREG32_SOC15(GC, GET_INST(GC, i), regMC_VM_FB_LOCATION_TOP, 0);
 			WREG32_SOC15(GC, GET_INST(GC, i), regMC_VM_FB_LOCATION_BASE, 0x00FFFFFF);
 			WREG32_SOC15(GC, GET_INST(GC, i), regMC_VM_AGP_TOP, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 7c0ca2721eb3..356b0fe5a538 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1682,6 +1682,11 @@ static int gmc_v9_0_early_init(struct amdgpu_ip_block *ip_block)
 		adev->gmc.private_aperture_start + (4ULL << 30) - 1;
 	adev->gmc.noretry_flags = AMDGPU_VM_NORETRY_FLAGS_TF;
 
+	adev->gmc.enable_pdb0 = adev->gmc.xgmi.connected_to_cpu;
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
+	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4) ||
+	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 5, 0))
+	    adev->gmc.enable_pdb0 = amdgpu_sriov_vf(adev);
 	return 0;
 }
 
@@ -1726,7 +1731,7 @@ static void gmc_v9_0_vram_gtt_location(struct amdgpu_device *adev,
 
 	/* add the xgmi offset of the physical node */
 	base += adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size;
-	if (adev->gmc.xgmi.connected_to_cpu) {
+	if (adev->gmc.enable_pdb0) {
 		amdgpu_gmc_sysvm_location(adev, mc);
 	} else {
 		amdgpu_gmc_vram_location(adev, mc, base);
@@ -1841,7 +1846,7 @@ static int gmc_v9_0_gart_init(struct amdgpu_device *adev)
 		return 0;
 	}
 
-	if (adev->gmc.xgmi.connected_to_cpu) {
+	if (adev->gmc.enable_pdb0) {
 		adev->gmc.vmid0_page_table_depth = 1;
 		adev->gmc.vmid0_page_table_block_size = 12;
 	} else {
@@ -1867,7 +1872,7 @@ static int gmc_v9_0_gart_init(struct amdgpu_device *adev)
 		if (r)
 			return r;
 
-		if (adev->gmc.xgmi.connected_to_cpu)
+		if (adev->gmc.enable_pdb0)
 			r = amdgpu_gmc_pdb0_alloc(adev);
 	}
 
@@ -2372,7 +2377,7 @@ static int gmc_v9_0_gart_enable(struct amdgpu_device *adev)
 {
 	int r;
 
-	if (adev->gmc.xgmi.connected_to_cpu)
+	if (adev->gmc.enable_pdb0)
 		amdgpu_gmc_init_pdb0(adev);
 
 	if (adev->gart.bo == NULL) {
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
index 84cde1239ee4..9b3d1ac138ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
@@ -45,8 +45,10 @@ static u64 mmhub_v1_8_get_fb_location(struct amdgpu_device *adev)
 	top &= MC_VM_FB_LOCATION_TOP__FB_TOP_MASK;
 	top <<= 24;
 
-	adev->gmc.fb_start = base;
-	adev->gmc.fb_end = top;
+	if (!adev->gmc.enable_pdb0) {
+		adev->gmc.fb_start = base;
+		adev->gmc.fb_end = top;
+	}
 
 	return base;
 }
-- 
2.43.5

