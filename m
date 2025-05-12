Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1E50C3ABCB
	for <amd-gfx@archiver.kernel.org>; Mon, 12 May 2025 06:42:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F53210E2D6;
	Mon, 12 May 2025 06:42:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uL9AvLaa";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC40110E2DC
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 May 2025 06:42:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=onI/tofA9jCD0s4vVrFZJ0FUZtsaHm8R826K5Oj1jnXd/DdUfASVtI+2HzC7oLL+tAIey7iGR073PULhG0pLwQesM78tA0bVQOltBA2q+svqMcQh82yPkEt6kseKbY7ubgVgrjBkt5gfuJZMhVQ8a99INsQxn2FqsWtBwIrCzQomCY/8di81t4p7YVdjz1ges3Bc8iJh080B9io1ZHBWtiMEcfGxU6FaeUkhxj10GH455WaSMBfAh0hKzhFlVzm3SUbxrLrQ7DGsKhMYhQqo5Xhv4repXxWjmyJ4ghdn9pahiXD7hKVjLMYJZ+DExqUVmjBb4ERbbISZNK1TSTwMYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zDOUOzPkNhK0CWJZLcjgV2MnQKHy8OJbLYVAfyjEG4Q=;
 b=dHx2ZLmcMeorbjXzs1vWU98pcfQNCRc1nPbORYD6U4sRhf9H0gEXxwt9qBcbpZN5ukOIazPqiHt7j4yIaMaa1JTj2++WI3sbE3gObCFv/PvVUJVAKO365qI5c3wV4Hmd37RhcRyo9cJji6/0pI4Wnpmppm3TdTPUqB9Se2DZD+myhXrtjzS819tn4nut5xmuF7d1TGgdZNFyi1+GHB2Y1fnJ1uQvZ/Jo8Mjw8pF0j+hEVpI9Nu3lN0HRWn4uQkE5XZKdK8hGvPLd/9Mi3Xf2c+0INz/vawWCKjPMPDEk3oiCie6I8P7zomMijNmGkuMGGHC6Pn2czw55O365KPprZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zDOUOzPkNhK0CWJZLcjgV2MnQKHy8OJbLYVAfyjEG4Q=;
 b=uL9AvLaaDslWof5uLDQHXX11PGOOE3BIdoC+WqPd6s2iix+28GjAP1bS8JAjyOIc7oGNBnHwLlMsUJI8UA00jU+FrVY3U2IomQgzq7qPBtc4aSd3mg9er3/Ub5ygKjKfNGvEgYXQq27cHpC1HvZ2peeepKD0YktWlffMYHddvOc=
Received: from CH2PR15CA0005.namprd15.prod.outlook.com (2603:10b6:610:51::15)
 by MW4PR12MB7311.namprd12.prod.outlook.com (2603:10b6:303:227::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Mon, 12 May
 2025 06:42:19 +0000
Received: from CH1PEPF0000AD7B.namprd04.prod.outlook.com
 (2603:10b6:610:51:cafe::ad) by CH2PR15CA0005.outlook.office365.com
 (2603:10b6:610:51::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.27 via Frontend Transport; Mon,
 12 May 2025 06:42:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7B.mail.protection.outlook.com (10.167.244.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Mon, 12 May 2025 06:42:19 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 12 May
 2025 01:42:18 -0500
Received: from hjbog17.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 12 May 2025 01:42:16 -0500
From: Samuel Zhang <guoqing.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <victor.zhao@amd.com>, <haijun.chang@amd.com>, <guoqing.zhang@amd.com>,
 <Christian.Koenig@amd.com>, <Alexander.Deucher@amd.com>,
 <Owen.Zhang2@amd.com>, <Qing.Ma@amd.com>, Emily Deng <Emily.Deng@amd.com>
Subject: [PATCH v5 3/4] drm/amdgpu: enable pdb0 for hibernation on SRIOV
Date: Mon, 12 May 2025 14:41:40 +0800
Message-ID: <20250512064141.387079-4-guoqing.zhang@amd.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250512064141.387079-1-guoqing.zhang@amd.com>
References: <20250512064141.387079-1-guoqing.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: guoqing.zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7B:EE_|MW4PR12MB7311:EE_
X-MS-Office365-Filtering-Correlation-Id: 943e18bb-26bd-4a60-a369-08dd91202473
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4+8TU0woj+B4KygevaEB7n2bxjlgXlWUJYaDCqz7T/xFljavfIe7Hd1N++5Y?=
 =?us-ascii?Q?gpONqou2CF4ggSbOcGDqtYmuSZXBbkNvGEhLurAb376G40zLYs53LMYrB3ai?=
 =?us-ascii?Q?dlJINuj9M5NyY7dvdI+jGpgStWHlELpjJI1/vYiB9QGl/uVmfZ+W2PSFdxcq?=
 =?us-ascii?Q?xLBrNCVUX5sELeWZb39+gZUPDX4BMn5CBz3KMkEAp6dsvbrjp7qCCaHWnJi4?=
 =?us-ascii?Q?WKLlNJ4JjQJXVI4nkKwZpUFClnstEFXXHmU7tQZm8VAGqEJQ5lrxlCeRWuw6?=
 =?us-ascii?Q?XTcFlOEd66t3uGP7pd4RozsYezHqcfGyI7S3jLbBMD+CBGsS3OP/yGm+IiYu?=
 =?us-ascii?Q?4JcgZb4diSni09WvOeQEHKNkVDcXX1oqmfvYZfW68Kj0MgWIEqts2eJgcgyw?=
 =?us-ascii?Q?UByPjT6bqwUfmU/RopnU5J5xPGBgkmza6xkge7V51zX2i4V0eLem/iIFQo2F?=
 =?us-ascii?Q?arW5XhiFJa5xGohkEnakBc67ykk8BWaAjnsD5NUodATDPcJV3XehReVjlsYv?=
 =?us-ascii?Q?5yzoY4tghm8UjQK5QRyUDRYjDPnsbNDtZJcNYLGAwk+MT5aa0or7DqjQkYNA?=
 =?us-ascii?Q?jWOXZd/fZ+vXiEJAhdSdEwbJWzCY1ErmzsDJNUgk7hZXHE6+ll068oqgTrw1?=
 =?us-ascii?Q?r6ZEgOsId62R0M5D7jTYf3kMIiec+23rcAnWSkdOc2DhVeQtLrfjPGyXd2iy?=
 =?us-ascii?Q?7H5BaJFoar0Uarbk2rbTqBkUPSzniMXnW+n6gPlXE9gBskh9sEFkMCOPmJ9u?=
 =?us-ascii?Q?fPxUKfugMWoF+z8+tCERI8vOhyKTuwLLWY1+AV/jYJQVVbxhVahHwwLYq8Bx?=
 =?us-ascii?Q?1G/YLC+r56hkRY3RzjtvYsgPTD2SDRh/zIt06nHnNx7wRfeCZ+jJ+Q4J1TRF?=
 =?us-ascii?Q?G5VYKUYaAenE/91+/+wzJMMgZCdeR9HrCtYACc42VChyBu/BNaDxbCFMpNmP?=
 =?us-ascii?Q?t8BxJIIAnGsaeDjdH1GbavvGWYL3Eu0BQF/7UxP+lqMoeqJUCUYzw/UukmWo?=
 =?us-ascii?Q?1vQI/gmnzR8nBXoOSh3jtTSNsaWJywpTlC/l+zSGBD+noIkK17z7JPnaZGQf?=
 =?us-ascii?Q?DWY+C5lO6SU2uf8oWc2/QKk0/aJcgybhVmKm39UU0dUP3hXHNCDmfEr9AGv4?=
 =?us-ascii?Q?kbhsXg7Vzr0gmsxTXZCRO0nJjgX5gupBTQn//k7uTug/fsmCIU4oLAgR+jV8?=
 =?us-ascii?Q?imht92hysstJce9on7xk9ViQgpCdgpkneoTyci3qBcbDLFt+f6v4Lj3GuGIg?=
 =?us-ascii?Q?145cD6Bg1lKcuQFvH6F1wam9JH+7jVBjJJst1HVQT8gJ8m/9n8Em8y20sd7w?=
 =?us-ascii?Q?Gj/q/jTxKwDPPSFip+PdJLbC236luzv8OjJONKoWUbLsbIQsoPn/f+SDr6Uz?=
 =?us-ascii?Q?RVB3riRi0iC8TKlDxSC7KiYwWu7JZqRsZWPfxre7oSdOO9kx5GAS00Ng+2i5?=
 =?us-ascii?Q?ffnIS0F3HCMG1xozampI3NVlJInOW5p9hSEEYMsjhwnyWIc54uGRf4b0J3as?=
 =?us-ascii?Q?/z/Pjet21dYHg+jPxJsoqnIkR5e9Q0+EQfxJ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 06:42:19.2477 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 943e18bb-26bd-4a60-a369-08dd91202473
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7311
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
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c    | 16 +++++++++---
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c  |  6 +++--
 5 files changed, 43 insertions(+), 14 deletions(-)

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
index 59385da80185..5adb2e455892 100644
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
@@ -2533,6 +2535,12 @@ static int gmc_v9_0_resume(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int r;
 
+	if (amdgpu_virt_xgmi_migrate_enabled(adev)) {
+		adev->vm_manager.vram_base_offset = adev->gfxhub.funcs->get_mc_fb_offset(adev);
+		adev->vm_manager.vram_base_offset +=
+			adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size;
+	}
+
 	/* If a reset is done for NPS mode switch, read the memory range
 	 * information again.
 	 */
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

