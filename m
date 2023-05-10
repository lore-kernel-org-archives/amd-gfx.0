Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6111FC77B7C
	for <amd-gfx@archiver.kernel.org>; Wed, 10 May 2023 17:56:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A97410E4DC;
	Wed, 10 May 2023 17:56:56 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2063.outbound.protection.outlook.com [40.107.101.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3588710E4EC
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 May 2023 17:56:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=alV0qAjBEfFCRESBvRYz7kAZIX8cAGFspdoPK/cgc2DdQ4iCJaUoHKQLSvPi4upsVtV1I8SiW0fqgdPAorOQSTaBy/Zme4g7sTm6K5vi+mm3FqgEOeSl+zPfN7ypIpocjeZXEZANG+I+unJ8nSurgBKZ48CHUE6ftNiMWtS5CF95BXGlvrihZltypxF1vMlIp5dr+uC8oZ++giXdZkvJUznzinFDapmn+yaFsg4SbPdxKmWBJh04anm/e0MO7RwD8LB8+CCYx0ptTSSYpU6WA4bXB73Lmn8eeb/wgLUvdHO1lovJXzHhbBECc9GUvh5R8w/B85E7KT/xvZWvWpxP5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dQ+yQf88MnVSTZmU/TpBmVu43ekBEykFqfPQu6B+BIo=;
 b=Jz+qcNx7CpJqQwh1DO5sQbynVNVd86l3H76ijq/OSZOtG4IFbczKoJfuQ0Pe98zyg4cTaACQNire6q9d9DBt3GUHW+d28YcQZnCdH2KOD5i0PTWDhenHkIq3EhpppeNJ9f8M/InELWNT5ICCuvJmg/j8sslYEvyPPh9JkLdb696Dt9pZnp7ruF/B8dlV906qYjAVTJJZhlG4GSZHgjigjqHHyoe2bTB5IeIUBFw8oBXKpHb9FsOyXHWLl1zEUo4DJ3FVzCvDHbo8anyaecFYGoobvkbjX4cX17phoHvtWDe7o/O5XeI/CMzuqTJ8C3bArm/qJCeh4y/FXQgEXhtABA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQ+yQf88MnVSTZmU/TpBmVu43ekBEykFqfPQu6B+BIo=;
 b=IfT7fBsso6IQIX2CsmbgJG6ldP93HVSvlFppiy9FlrmfyjkV1P1Jb+T48U05v7CkuXwuu4FYdc3ITPkmc8YhxDe0N3nF/II5ihwJfuD4ouOARGPjNMpVgGM7oEvdltvI4bx0tzs4bA+Kh+TSTI7BUtImamUoI1aEOP6PADy3Pxo=
Received: from BN9PR03CA0934.namprd03.prod.outlook.com (2603:10b6:408:108::9)
 by MW4PR12MB6849.namprd12.prod.outlook.com (2603:10b6:303:20d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Wed, 10 May
 2023 17:56:52 +0000
Received: from BN8NAM11FT086.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:108:cafe::17) by BN9PR03CA0934.outlook.office365.com
 (2603:10b6:408:108::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18 via Frontend
 Transport; Wed, 10 May 2023 17:56:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT086.mail.protection.outlook.com (10.13.176.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.21 via Frontend Transport; Wed, 10 May 2023 17:56:51 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 10 May
 2023 12:56:44 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/6] drm/amdgpu: Override MTYPE per page on GFXv9.4.3 APUs
Date: Wed, 10 May 2023 13:56:28 -0400
Message-ID: <20230510175630.938276-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230510175630.938276-1-alexander.deucher@amd.com>
References: <20230510175630.938276-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT086:EE_|MW4PR12MB6849:EE_
X-MS-Office365-Filtering-Correlation-Id: faf33e60-9670-4d3a-50a4-08db517fef39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oytT/2zugxc3NQkYFSkNY9nK/GW127MwKOtwggX/JAgvG4SYxUoI9WIkVqfappK7dZPBGsaY19YEG4wSOrZWiQ6KxzDBSkeBXesk69sEOfuCGcRCDK4E4BG4HL6+zQWRCoV92iJnfj41vpzLYJTUS+3SEfSeL3aUAk7tSqY70tYbSlbkCssH5y5pke8fFaokRrUPFzYJDIryNix+IEGuuLCF8pfNsLi9vGAVcKHB9yIYMMoKQInjgvLMMX/+s+QeQQf3s0MjWObxw5qfcd0DjzqatOur4J9AvKCCvz+wSC3cPBcu3QmnYpEgyCU3fgXwRW5j1jH0N+Wjtilkc9DhLK67Zw+UkNguQFpA+PcDmGVags2AUb6l9FG6TUgKNEpOXohp9Nlq7LziPxUjFzm0eXHPxNb8rlmdvCc5AsmVKM0rGGuqnKPVNvQXklGn8tAB5UL6PQupbnSbnGwoBu8ETvMsjrXf4dG0tDOmxIoUQjtOM3If8+KxuMqI8aL55NmQy8w5/b+Al0TB1CsgMAU6jLmojZHQL/CfbiRlKlyVFQJCvezmEL2XmEhqmSQetQlw5TC7ghcCad+ST7yQ8rIwoftWUCIF/i4nYGoZKQIwAlpzJea4bh8W9qIJ+Kxjkr0ciPteU9RGc1fzoYEXsWdY4Waoki2p0gKYnGcEjxvyq+64tC9dFeGQXuPV+FL8CMOkQdQSn7Nr5nXtIxpJqC8TkXUrVj7TRI0Uq8Il/OoFQYE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199021)(36840700001)(40470700004)(46966006)(478600001)(86362001)(47076005)(83380400001)(336012)(36860700001)(426003)(2616005)(40480700001)(26005)(1076003)(6666004)(7696005)(70206006)(6916009)(70586007)(82740400003)(316002)(356005)(81166007)(54906003)(4326008)(186003)(16526019)(41300700001)(8676002)(5660300002)(8936002)(40460700003)(2906002)(82310400005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 17:56:51.8795 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: faf33e60-9670-4d3a-50a4-08db517fef39
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT086.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6849
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
Cc: Alex
 Deucher <alexander.deucher@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Felix Kuehling <Felix.Kuehling@amd.com>

On GFXv9.4.3 NUMA APUs, system memory locality must be determined per
page to choose the correct MTYPE. This patch adds a GMC callback that
can provide this per-page override and implements it for native mode.

Carve-out mode is not yet supported and will use the safe default
(remote) MTYPE for system memory.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
Reviewed-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-and-tested-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h   |  7 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 22 ++++++--
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c     | 64 +++++++++++++++++++++++
 3 files changed, 90 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 43357d699e6e..6794edd1d2d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -148,6 +148,10 @@ struct amdgpu_gmc_funcs {
 	void (*get_vm_pte)(struct amdgpu_device *adev,
 			   struct amdgpu_bo_va_mapping *mapping,
 			   uint64_t *flags);
+	/* override per-page pte flags */
+	void (*override_vm_pte_flags)(struct amdgpu_device *dev,
+				      struct amdgpu_vm *vm,
+				      uint64_t addr, uint64_t *flags);
 	/* get the amount of memory used by the vbios for pre-OS console */
 	unsigned int (*get_vbios_fb_size)(struct amdgpu_device *adev);
 
@@ -336,6 +340,9 @@ struct amdgpu_gmc {
 #define amdgpu_gmc_map_mtype(adev, flags) (adev)->gmc.gmc_funcs->map_mtype((adev),(flags))
 #define amdgpu_gmc_get_vm_pde(adev, level, dst, flags) (adev)->gmc.gmc_funcs->get_vm_pde((adev), (level), (dst), (flags))
 #define amdgpu_gmc_get_vm_pte(adev, mapping, flags) (adev)->gmc.gmc_funcs->get_vm_pte((adev), (mapping), (flags))
+#define amdgpu_gmc_override_vm_pte_flags(adev, vm, addr, pte_flags)	\
+	(adev)->gmc.gmc_funcs->override_vm_pte_flags			\
+		((adev), (vm), (addr), (pte_flags))
 #define amdgpu_gmc_get_vbios_fb_size(adev) (adev)->gmc.gmc_funcs->get_vbios_fb_size((adev))
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index bc5d126b600b..60b1da93b06d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -786,13 +786,14 @@ static void amdgpu_vm_pte_update_flags(struct amdgpu_vm_update_params *params,
 				       uint64_t pe, uint64_t addr,
 				       unsigned int count, uint32_t incr,
 				       uint64_t flags)
-
 {
+	struct amdgpu_device *adev = params->adev;
+
 	if (level != AMDGPU_VM_PTB) {
 		flags |= AMDGPU_PDE_PTE;
-		amdgpu_gmc_get_vm_pde(params->adev, level, &addr, &flags);
+		amdgpu_gmc_get_vm_pde(adev, level, &addr, &flags);
 
-	} else if (params->adev->asic_type >= CHIP_VEGA10 &&
+	} else if (adev->asic_type >= CHIP_VEGA10 &&
 		   !(flags & AMDGPU_PTE_VALID) &&
 		   !(flags & AMDGPU_PTE_PRT)) {
 
@@ -800,6 +801,21 @@ static void amdgpu_vm_pte_update_flags(struct amdgpu_vm_update_params *params,
 		flags |= AMDGPU_PTE_EXECUTABLE;
 	}
 
+	/* APUs mapping system memory may need different MTYPEs on different
+	 * NUMA nodes. Only do this for contiguous ranges that can be assumed
+	 * to be on the same NUMA node.
+	 */
+	if ((flags & AMDGPU_PTE_SYSTEM) && (adev->flags & AMD_IS_APU) &&
+	    adev->gmc.gmc_funcs->override_vm_pte_flags &&
+	    num_possible_nodes() > 1) {
+		if (!params->pages_addr)
+			amdgpu_gmc_override_vm_pte_flags(adev, params->vm,
+							 addr, &flags);
+		else
+			dev_dbg(adev->dev,
+				"override_vm_pte_flags skipped: non-contiguous\n");
+	}
+
 	params->vm->update_funcs->update(params, pt, pe, addr, count, incr,
 					 flags);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 52f5bab5fcb7..5c9f0169292e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1302,6 +1302,69 @@ static void gmc_v9_0_get_vm_pte(struct amdgpu_device *adev,
 					     mapping, flags);
 }
 
+static void gmc_v9_0_override_vm_pte_flags(struct amdgpu_device *adev,
+					   struct amdgpu_vm *vm,
+					   uint64_t addr, uint64_t *flags)
+{
+	int local_node, nid;
+
+	/* Only GFX 9.4.3 APUs associate GPUs with NUMA nodes. Local system
+	 * memory can use more efficient MTYPEs.
+	 */
+	if (adev->ip_versions[GC_HWIP][0] != IP_VERSION(9, 4, 3))
+		return;
+
+	/* Only direct-mapped memory allows us to determine the NUMA node from
+	 * the DMA address.
+	 */
+	if (!adev->ram_is_direct_mapped) {
+		dev_dbg(adev->dev, "RAM is not direct mapped\n");
+		return;
+	}
+
+	/* Only override mappings with MTYPE_NC, which is the safe default for
+	 * cacheable memory.
+	 */
+	if ((*flags & AMDGPU_PTE_MTYPE_VG10_MASK) !=
+	    AMDGPU_PTE_MTYPE_VG10(MTYPE_NC)) {
+		dev_dbg(adev->dev, "MTYPE is not NC\n");
+		return;
+	}
+
+	/* TODO: memory partitions. mem_id is hard-coded to 0 for now.
+	 * FIXME: Only supported on native mode for now. For carve-out, the
+	 * NUMA affinity of the GPU/VM needs to come from the PCI info because
+	 * memory partitions are not associated with different NUMA nodes.
+	 */
+	if (adev->gmc.is_app_apu) {
+		local_node = adev->gmc.mem_partitions[/*vm->mem_id*/0].numa.node;
+	} else {
+		dev_dbg(adev->dev, "Only native mode APU is supported.\n");
+		return;
+	}
+
+	/* Only handle real RAM. Mappings of PCIe resources don't have struct
+	 * page or NUMA nodes.
+	 */
+	if (!page_is_ram(addr >> PAGE_SHIFT)) {
+		dev_dbg(adev->dev, "Page is not RAM.\n");
+		return;
+	}
+	nid = pfn_to_nid(addr >> PAGE_SHIFT);
+	dev_dbg(adev->dev, "vm->mem_id=%d, local_node=%d, nid=%d\n",
+		/*vm->mem_id*/0, local_node, nid);
+	if (nid == local_node) {
+		unsigned int mtype_local =
+			amdgpu_use_mtype_cc_wa ? MTYPE_CC : MTYPE_RW;
+		uint64_t old_flags = *flags;
+
+		*flags = (*flags & ~AMDGPU_PTE_MTYPE_VG10_MASK) |
+			 AMDGPU_PTE_MTYPE_VG10(mtype_local);
+		dev_dbg(adev->dev, "flags updated from %llx to %llx\n",
+			old_flags, *flags);
+	}
+}
+
 static unsigned gmc_v9_0_get_vbios_fb_size(struct amdgpu_device *adev)
 {
 	u32 d1vga_control = RREG32_SOC15(DCE, 0, mmD1VGA_CONTROL);
@@ -1373,6 +1436,7 @@ static const struct amdgpu_gmc_funcs gmc_v9_0_gmc_funcs = {
 	.map_mtype = gmc_v9_0_map_mtype,
 	.get_vm_pde = gmc_v9_0_get_vm_pde,
 	.get_vm_pte = gmc_v9_0_get_vm_pte,
+	.override_vm_pte_flags = gmc_v9_0_override_vm_pte_flags,
 	.get_vbios_fb_size = gmc_v9_0_get_vbios_fb_size,
 	.query_mem_partition_mode = &gmc_v9_0_query_memory_partition,
 };
-- 
2.40.1

