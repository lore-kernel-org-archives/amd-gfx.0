Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454E4606E839
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2026 20:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=bt61ZBmo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6E7610FEC9;
	Wed,  4 Nov 2026 20:04:23 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012049.outbound.protection.outlook.com [52.101.48.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B1E410FEC9
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Nov 2026 20:04:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QP44uHDlesiBifDxjvSYi/YznPPJ8QGL2GeBnpkY10UKABjnew75mq0RKz4JuNovZ3jjV/ptgpcrHHINjRwVokx7boFHR5kWgGV+MT3/f2wISeIUd6rl1NsWaXMrVTMX2+zcEDB3FWZ5BFG4vHA8VTdk6U5p/kb3eWDOpRwaANU5P+geTmYEl0n6rGh6mB3z/YoSuGoGYEwW8Uz2x+fZsIilhSxEvwqNgxrKWVrRDuAPhslvnW7Fd1BgPtcPHnNBprywsKdcnvEnEJlYBl3ydJRnDzI0KUhH4UrB+kGSnry5605SDCNGUAx3X2G4UYmBrE2+BtQxw1OR4wiBvWMXlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Gzn6mj3z785LlXiZoOtR0mdx9MTGwTJwkFWjZGP7fY=;
 b=gT7o9uF6vxj4zyT9pUpTWfHM8Uu2TnwskwQc/RVf08wDuxscJBpnQDuxtZiujBWIkLoudTANy/4MhigDpQko61120ekPwgPalgGffWgQ/yJFvo7GrCrRfR9Hr2uoqBQWrgiKMXhOuLVPKWgblkArTiRVOO/QVUkzBKf60bUi5uVLaXmJfhaAyhrCwzDCRvna6KNrs6MTKDX6npcWaD2MxF0163UKLniJa6PtiVbukJi8LayUwSbIEQUL49ivZKsI21xIRRVHCWfJnhziZEZj4UNi0Ow8Ob9hwSyLATwv2JFmaR5ehguiDbXzk8mTBCTbpSHL6q9woE+vtEjqtMmYQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Gzn6mj3z785LlXiZoOtR0mdx9MTGwTJwkFWjZGP7fY=;
 b=bt61ZBmox1A++hm1jxF0qYuh53jT/xIExLUBNE1mOlHlydaxfseH61n8ittSLHj1+tqIS7ny683DruonsRl1JU/Xv0hxWiLmJK31XdqKY3y54aT+2LmKg3v5wKFLEOG4b6PcbLKrU2FArN4eKK3qcdLomk83ktwKjVMiytotVOE=
Received: from DS1P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:455::9) by
 SA1PR12MB6895.namprd12.prod.outlook.com (2603:10b6:806:24e::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.10; Wed, 4 Nov 2026 20:02:10 +0000
Received: from DM3PEPF000265B9.namprd04.prod.outlook.com
 (2603:10b6:8:455:cafe::58) by DS1P220CA0004.outlook.office365.com
 (2603:10b6:8:455::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Wed, 4
 Nov 2026 20:02:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM3PEPF000265B9.mail.protection.outlook.com (10.167.23.246) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 20:02:09 +0000
Received: from MKMZHLUO01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 14:02:08 -0600
From: Zhigang Luo <Zhigang.Luo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Hawking.Zhang@amd.com>, <Lijo.Lazar@amd.com>, Zhigang Luo
 <Zhigang.Luo@amd.com>
Subject: [PATCH] drm/amdgpu: keep SPM VF VRAM at GPU address 0
Date: Wed, 4 Nov 2026 15:01:52 -0500
Message-ID: <20261104200152.77286-1-Zhigang.Luo@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265B9:EE_|SA1PR12MB6895:EE_
X-MS-Office365-Filtering-Correlation-Id: b692e255-a305-4740-240b-08df3aae8279
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|23010399003|36860700016|6133799003|18002099003|56012099006|261021121427099003|261021123027099003|261009223027099003|261026121527099003|11063799006|10067099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: 3LfVk6kCFQsJN4A9HwTth51qkDJr4J5tpsuGSY9wO7Y0OV2VddJ+d6a3xLgRAwfSIAGIzdxwQtGUO5Y9ecM41jaIL3SoK0v/GvGzJkLMVwWAf7ClNF+m3bVAYMieB+k4hJ2lWSz9yDps9tWexceDF8L7RlwmgTBRpxLc4osZfyA5pl/oofewMwPunDloJFnRihE/fjo3ZtSIlLhld08P0q0qhJUXL+DjQY7P2QGiC0MGCXRjxeaAQQRAERdtW6Q7ycvAbBFiLOyVgahFx5sbzHxHZsdhNJReUXapWY8cPwIRxOeYKPgWH3fftx+NzOZWTdg4oo/I5U6/5IgoenmaKzlxHbRIaLOJYtgax/R8PLpuZWD0ylOgqoika97phG2B6RGtXQik2XfxrXNGAcVVjUai/awox3C1uSVcFfIGd1DNXiQbBTWypqp7hd5rDg+nWPB3WAKndz6k0NvGTzVFjt2YwPe8RLHAn2WnqMgFqigjySiExWe7p6eXtk1NFi3+6IzALZ3Y+JYkILtUBRzB/GKYz2i5qnONoH3pL9fGrseJhGVmqeBasX/dnhzifD3wrPHmsl3vcJNVFvJS3J/5p1n8Hx+1r+6+3tSFjp0OalDzF4yqNXFZg3n+TkR/v2JJtc3FLzU7PWbI1CsA6CLRLnRsW8GDB66m3+WVhGnKG44FtosfRyNrKHIIOcv5cxsfuLA9rP2bDfaG9hhTB24Mug==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(23010399003)(36860700016)(6133799003)(18002099003)(56012099006)(261021121427099003)(261021123027099003)(261009223027099003)(261026121527099003)(11063799006)(10067099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jzpzIbgLvpKsMCUW7Kr03Z7FsBoRRe8N6gV/KOs+it78J+auYe18kuyBYM1osBxVHjQ2Sr+QfBhh8O583v1FH6cf4rhcFfVAp2uPnqsmjOEPbXwSenUSkglqelOLlMZ+xDzPxW1AzFAfpTR1wC7VJO8u5EK42WfhJSZKMgwb+/y94y1Qp5DOlUoLJw4PycTmKZj+e9/jSk2TKTzMwSA4Ov6ZurYqZH9MmfkUTzaBR8GC5mnhN3SmeG6IuElAkw9yHLn4KSSm4C5OstaYAWM0EGBLgkUeryumfIilCEVL086fgGe3lnZYYNhwsVdBGLDRG3LuUefXGFWw+hD65xiGUtHL4ToqQyCasoCTkOnLZUYkqIF9XIn3QI+Won19HBhRUnU9UWG7hv8+yX+nEfwzuwMEaPK5HwD9W0PXdlzbVwMyT0uI2IMRavEFgLKFoT+k
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 20:02:09.7118 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b692e255-a305-4740-240b-08df3aae8279
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3PEPF000265B9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6895
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

- bug 'amdgpu_virt_resume': resume added the xGMI node segment on top
  of the MMHUB FB offset for SPM VRAM; use aper_base and skip the node
  offset
- bug 'gmc_v12_0_vram_gtt_location': the initial load path added the
  same node segment after aper_base; skip it when VRAM is SPM
- bug 'amdgpu_gmc_sysvm_location': SPM used the hive window and a 4GB
  GART alignment; zero the VRAM GPU window and place GART after local
  VRAM on an 8GB PDB0 boundary
- bug 'amdgpu_gmc_pdb0_alloc': PDB0 covered the hive; size SPM coverage
  from mc_vram_size
- bug 'amdgpu_gmc_init_pdb0': SPM subtracted the node segment from
  aper_base; keep the system physical base

Signed-off-by: Zhigang Luo <Zhigang.Luo@amd.com>
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
index 4204c3c750a8..78fae3fbee11 100644
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
 
@@ -266,16 +269,21 @@ void amdgpu_gmc_sysvm_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc
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
@@ -1274,7 +1282,8 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev)
 	uint64_t flags = adev->gart.gart_pte_flags; //TODO it is UC. explore NC/RW?
 	/* Each PDE0 (used as PTE) covers (2^vmid0_page_table_block_size)*2M
 	 */
-	u64 vram_size = adev->gmc.xgmi.node_segment_size * adev->gmc.xgmi.num_physical_nodes;
+	u64 vram_size = amdgpu_virt_vram_is_spm(adev) ? adev->gmc.mc_vram_size :
+		adev->gmc.xgmi.node_segment_size * adev->gmc.xgmi.num_physical_nodes;
 	u64 pde0_page_size = (1ULL<<adev->gmc.vmid0_page_table_block_size)<<21;
 	u64 vram_addr, vram_end;
 	u64 gart_ptb_gpu_pa = amdgpu_gmc_vram_pa(adev, adev->gart.bo);
@@ -1292,7 +1301,8 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev)
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

