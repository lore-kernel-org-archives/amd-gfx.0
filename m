Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE4E606A31C
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2026 16:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Jr31jC0n
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0575310E2B8;
	Mon,  9 Nov 2026 16:26:58 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012055.outbound.protection.outlook.com [52.101.53.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B44210E2B8
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Nov 2026 16:26:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CIyFeyrEg5HdbSPm+JxYSBtAWxtX27GBOflVcMMvlQ59BZtzjrNWnaUUN5jsQn/va+nR3PNzl9UeS4oi/ABisyzptI0D0gzDm53HPzjmTqLxck+xohOG/Pbn92l7aQHp5f6vlfU+G9NCjVH8Yc6j9J2Px8xYjBf2iHpNQWcR24MZh0CkVBXf/OdeWr58SmY/g9E/uW0wvg6BK43LtKx45ArMsBD4BNs5PRFVhLQPoZIc5g7DVE/3diI2IUUZYQTrfVG/PJ9ROHJ2U/8LAaJRBvrrV/5aG+9OdTMh93Bgcp3tBsIv4AFAZGu+5gmhNayHRzb7baHOLZ7yHQP9vYzLHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M2UysC6qFlv6JbPALOSaomq2EEWWgeIBLCI/uFDk9Js=;
 b=p1ESZWO3BWDK5Fnoze6PniAPgRCsAowqg7mDQKQHCCWM5tuIXbm0UBOX1N5xI0XfOZ7rAWqypq1j8PVnKD6m/jlS2La7afbjo6NduMmqAHNkji9Fn4xCPL5Bu3WpA36s+4k68yMXZ9yNkNA9fWJ7OBUvuPBoe9+t3n5SGC0TRTn3ZwvlB1ogJJ6+0wiuD9B86CaiBVNWzUqq0jzsbOQQqfX1h11D/XlflDLgZ9rOW67w74lXmPy/8Fir0rwA1iPdIUpPuMLrc7Pre78n/T7w5UC3VnxUI9/KN9IQ88DN84DKXZVnVajUHbb/ostZYmK84n3j4V28BxRtsmN2D3TLpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M2UysC6qFlv6JbPALOSaomq2EEWWgeIBLCI/uFDk9Js=;
 b=Jr31jC0nWAg6ApULwi8j30XvYhSN1J8pAVF9e3lCehj92mWRCdYo1HEsIG0FO5T840FHM+fBZMZVBgahugFKGd1+mJfci+TKWboSqI4BVA4iA1bR7i8yncyAeUDd60pkpruR2Gj/AgQEMp3nJZnrR+Izrr++GZKUqzOVAnjE/jU=
Received: from CH0PR07CA0028.namprd07.prod.outlook.com (2603:10b6:610:32::33)
 by PH7PR12MB6881.namprd12.prod.outlook.com (2603:10b6:510:1b7::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 16:26:42 +0000
Received: from DS2PEPF00006E25.namprd05.prod.outlook.com (2603:10b6:610:32::4)
 by CH0PR07CA0028.outlook.office365.com (2603:10b6:610:32::33) with
 Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13
 via Frontend Transport; Mon, 9 Nov 2026 16:26:42 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00006E25.mail.protection.outlook.com (10.167.23.218) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 9 Nov 2026 16:26:42 +0000
Received: from MKMZHLUO01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 9 Nov
 2026 10:26:34 -0600
From: Zhigang Luo <Zhigang.Luo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <Hawking.Zhang@amd.com>, <Lijo.Lazar@amd.com>, Zhigang Luo
 <Zhigang.Luo@amd.com>, Zhigang Luo <zhigang.luo@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: keep the A+A VF VRAM base at the SRAT address
Date: Mon, 9 Nov 2026 11:26:15 -0500
Message-ID: <20261109162615.167236-4-Zhigang.Luo@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109162615.167236-1-Zhigang.Luo@amd.com>
References: <20261109162615.167236-1-Zhigang.Luo@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00006E25:EE_|PH7PR12MB6881:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d74ebbb-0ef2-403b-bc2d-08df3e7e3d4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|18002099003|22082099003|10067099003|11063799006|261028144727099003|261026121527099003|261102123227099003|261022105027099003|56012099006|261021123027099003|261021121427099003|261026140227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: JdLfiD85IAMEBMfL4njCnhTRvm8S9NLfeKilzPi/G7mUenah1fvEtCyJmrtVaNAufJLCgq3j7FzCpA5wNUwDg5CvyQWyxhGqItOKeCXAWfeQo9r7TQ0RSz/Ou87ji9VIXzjy8anUFLMY02IqCZOOQpHd3HKKR2kKAMx1x11FQSvmeZCXNIgId3NOGqTSk7Kzm1wN/5Dv4fKfp2k5Do+1MyFg9bmy2eyrVysWolPdVX+17h2jje+Hv7c02Nun6/oySBI655IzoB7YrDxv8OEu+w5Q+6zKTia6R12szzQoGzX/4I2HWmgQbMx+3eFD3u0aqmyRo85rQgBLf6f3qAOMjbTKpQwUKhmFVgW8wPBXGqf8xQFZLORL0jrzf67kXLbd69Fz3b67UholX/GGZqvegwVyEj1CorObvdRTaAogzY1cY7tqpH66kTtbiR+L9KaHHWijwBp4TMGySqvU3K8VJ521D5WTwLe84jAnPbdgPoLfA8WP+e6C9WPorKuyKM7f+zAYYAMm+G5+XjPSJdtZNpsropW5I11ulbY455R1t+SjVqP45V2ZxzWXLQWtmkpQmL8/OsMWqgAQxuSPk4tPOie1mc8FMFfQekgxqusRm+HB7pTtFrSQoA9/2eytNDQNHpZ9e0zin4bh9th4kRhxBucozjzADGrdrzdpnRvq1qOhTnqz93SodT5IlT3ByqHFPvBiKkwE/3hn3MEPRS0PSg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(10067099003)(11063799006)(261028144727099003)(261026121527099003)(261102123227099003)(261022105027099003)(56012099006)(261021123027099003)(261021121427099003)(261026140227099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: whHJsJof2CWMydw3TGLNBlsjvbyfEMC2s3/cQIlxHfBLTIgGzsU7i+Ie9bQhOfTxiqiwz2oFgd4YE1BHkImLbKqO0Cb2YGQE2l4hnrv7KbhMndIk+IxRHdOSpYemvOKwZQ6EmF4k11DIl433+mlH8PtMGpoIbfQEhp1/9OwMjGlXkziVEVRv3NFHu5Lgoa9op+9QGtfFfyJkvzxW/KnC0RerFhtnEuIw12jE5n8q+ne7zcKV46JcVHKPPJ7CRLGZtkTENzp9pkYIMrC/+Gln6sE7y1XJ2QwulBAgW5bZaELGRcZfBzP8hGA0PnOILHD9N2El2eEC2iK2htNY5mSIWptpVj2be+CSDfgOWjLNgu1fjfCJgH2WSqwNx7pB+H0zim4cMmrJiQjyhxDPsV5hqSWKkwGQ9qx8y6Wdvb0st5MmiCd/QWRNk8EcdBS9jlpC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 16:26:42.4554 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d74ebbb-0ef2-403b-bc2d-08df3e7e3d4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00006E25.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6881
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On the A+A VF the hypervisor reports each VF's VRAM address in the
ACPI SRAT table, and that address is stored in aper_base. The XGMI
node segment does not describe the VF, so physical_node_id *
node_segment_size is not a valid VRAM starting address.

gmc_v12_0_vram_gtt_location() and amdgpu_virt_resume() still added
that offset on top of aper_base, which moved the SPM PDB0 system PTEs
off the VF's HBM. Leave vram_base_offset at aper_base on both paths.
Size PDB0 from the VF's local VRAM and place GART after that window,
aligned to 8GB. That alignment is one PDB0 entry when
vmid0_page_table_block_size is 12, and it applies to every PDB0
placement.

v2:
- Explain that the SRAT address is already the VF VRAM base and must
  not be adjusted by the XGMI node segment.

Signed-off-by: Zhigang Luo <zhigang.luo@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 12 +++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    | 22 ++++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c     |  6 ++++--
 3 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 9326f811c500..7a664b7b1ba3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4677,9 +4677,15 @@ static inline int amdgpu_virt_resume(struct amdgpu_device *adev)
 	dev_info(adev->dev, "xgmi node, old id %d, new id %d\n",
 		prev_physical_node_id, adev->gmc.xgmi.physical_node_id);
 
-	adev->vm_manager.vram_base_offset = adev->gfxhub.funcs->get_mc_fb_offset(adev);
-	adev->vm_manager.vram_base_offset +=
-		adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size;
+	if (amdgpu_virt_vram_is_spm(adev)) {
+		adev->vm_manager.vram_base_offset = adev->gmc.aper_base;
+	} else {
+		adev->vm_manager.vram_base_offset =
+			adev->gfxhub.funcs->get_mc_fb_offset(adev);
+		adev->vm_manager.vram_base_offset +=
+			adev->gmc.xgmi.physical_node_id *
+			adev->gmc.xgmi.node_segment_size;
+	}
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index f76da74abfec..96075db3b9ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -42,6 +42,8 @@
 #include <drm/ttm/ttm_tt.h>
 
 static const u64 four_gb = 0x100000000ULL;
+/* PDB0 block size 12 covers one 8GB entry. */
+static const u64 eight_gb = 0x200000000ULL;
 
 bool amdgpu_gmc_is_pdb0_enabled(struct amdgpu_device *adev)
 {
@@ -60,7 +62,8 @@ int amdgpu_gmc_pdb0_alloc(struct amdgpu_device *adev)
 {
 	int r;
 	struct amdgpu_bo_param bp;
-	u64 vram_size = adev->gmc.xgmi.node_segment_size * adev->gmc.xgmi.num_physical_nodes;
+	u64 vram_size = amdgpu_virt_vram_is_spm(adev) ? adev->gmc.mc_vram_size :
+		adev->gmc.xgmi.node_segment_size * adev->gmc.xgmi.num_physical_nodes;
 	uint32_t pde0_page_shift = adev->gmc.vmid0_page_table_block_size + 21;
 	uint32_t npdes = (vram_size + (1ULL << pde0_page_shift) - 1) >> pde0_page_shift;
 
@@ -261,16 +264,21 @@ void amdgpu_gmc_sysvm_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc
 	u64 hive_vram_end = mc->xgmi.node_segment_size * mc->xgmi.num_physical_nodes - 1;
 	mc->vram_start = mc->xgmi.node_segment_size * mc->xgmi.physical_node_id;
 	mc->vram_end = mc->vram_start + mc->xgmi.node_segment_size - 1;
-	/* node_segment_size may not 4GB aligned on SRIOV, align up is needed. */
-	mc->gart_start = ALIGN(hive_vram_end + 1, four_gb);
+	/* Round up to a PDB0 entry so GART starts on the page-table PDE. */
+	mc->gart_start = ALIGN(hive_vram_end + 1, eight_gb);
 	mc->gart_end = mc->gart_start + mc->gart_size - 1;
-	if (amdgpu_virt_xgmi_migrate_enabled(adev)) {
+	if (amdgpu_virt_xgmi_migrate_enabled(adev) ||
+	    amdgpu_virt_vram_is_spm(adev)) {
 		/* set mc->vram_start to 0 to switch the returned GPU address of
 		 * amdgpu_bo_create_reserved() from FB aperture to GART aperture.
 		 */
 		mc->vram_start = 0;
 		mc->vram_end = mc->vram_start + mc->mc_vram_size - 1;
 		mc->visible_vram_size = min(mc->visible_vram_size, mc->real_vram_size);
+		if (amdgpu_virt_vram_is_spm(adev)) {
+			mc->gart_start = ALIGN(mc->vram_end + 1, eight_gb);
+			mc->gart_end = mc->gart_start + mc->gart_size - 1;
+		}
 	} else {
 		mc->fb_start = hive_vram_start;
 		mc->fb_end = hive_vram_end;
@@ -1269,7 +1277,8 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev)
 	uint64_t flags = adev->gart.gart_pte_flags; //TODO it is UC. explore NC/RW?
 	/* Each PDE0 (used as PTE) covers (2^vmid0_page_table_block_size)*2M
 	 */
-	u64 vram_size = adev->gmc.xgmi.node_segment_size * adev->gmc.xgmi.num_physical_nodes;
+	u64 vram_size = amdgpu_virt_vram_is_spm(adev) ? adev->gmc.mc_vram_size :
+		adev->gmc.xgmi.node_segment_size * adev->gmc.xgmi.num_physical_nodes;
 	u64 pde0_page_size = (1ULL<<adev->gmc.vmid0_page_table_block_size)<<21;
 	u64 vram_addr, vram_end;
 	u64 gart_ptb_gpu_pa = amdgpu_gmc_vram_pa(adev, adev->gart.bo);
@@ -1287,7 +1296,8 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev)
 	flags |= AMDGPU_PDE_PTE_FLAG(adev);
 
 	vram_addr = adev->vm_manager.vram_base_offset;
-	if (!amdgpu_virt_xgmi_migrate_enabled(adev))
+	if (!amdgpu_virt_xgmi_migrate_enabled(adev) &&
+	    !amdgpu_virt_vram_is_spm(adev))
 		vram_addr -= adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size;
 	vram_end = vram_addr + vram_size;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index cd276a138e10..e37c84f10709 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -734,8 +734,10 @@ static void gmc_v12_0_vram_gtt_location(struct amdgpu_device *adev,
 		adev->vm_manager.vram_base_offset = adev->mmhub.funcs->get_mc_fb_offset(adev);
 	}
 
-	adev->vm_manager.vram_base_offset +=
-		adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size;
+	if (!amdgpu_virt_vram_is_spm(adev))
+		adev->vm_manager.vram_base_offset +=
+			adev->gmc.xgmi.physical_node_id *
+			adev->gmc.xgmi.node_segment_size;
 }
 
 /**
-- 
2.43.0

