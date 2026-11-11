Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DCD606A326
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 19:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=oUNf9b7V
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 783DE10E451;
	Wed, 11 Nov 2026 19:23:53 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011015.outbound.protection.outlook.com [52.101.52.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFF4510E32D
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 19:23:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rdpc9Xf/kJN2nEYWTBtRZGpy7Z0Hlav4ez2MhSzIlSzURTaWMk7H67DayD/y4Gs3M+raDLLi5urKlTETtg4WNDSTVBCYZ5Rz3+lOdCJ+u/zWZ+3TDU21c0SVL+Bpu+6wmuGqWj0cREeUgwHgQf39OkLqrYUPfGdluc+74xeYZPmS4/zQ+fYgJAqi2mm4BBo8Vkps+I/F+X84co3npuu6pYgiveZHQshcuyS2gVNyyEIDLNGleFt9ly2bJTjkNS+/l5ireDYemDmXoPenyoFGFWOGN2ZfXvrQb/bm2B9QdkJNsfx++2Y1Z2ed2JvAhd+svI4DxmcQEQ6JS11bRpu9kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=of7uf9hPqIMfJ/MugT2eFIzYHlPYVfRJqYlHMr6wgPI=;
 b=GUxCXI/bg/dZ7bEUUKl5ZKrXptFMfTspFPxcBn/CIKV3Fg4qDmg53811fF7HNYM/KjTu/IKkmEBOtpyoDxmZKc8VWNQHWyHG3HM11D/uEnu1uw4JKdpkENCgNKKq+14wJrq9RYTr4G1HHSfwJHzQekrisiP61fu8unKemI+ZQ85Kj1CRaLDE45YtVni4mNC8jUXF2P2042c2lUGPUocnCS7ERJ2JaPBwZIGsT7DUw/H9z900XpS8IreUDAdoUujz60hBKe9eL+HnNwUa8X6cLohQVBGicPGj37/WcJEFmI9HLqhLqVxevOghQD9rKOqcLVIl0r1A3Ws6HUguQ8jc/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=of7uf9hPqIMfJ/MugT2eFIzYHlPYVfRJqYlHMr6wgPI=;
 b=oUNf9b7VbQl+ezS+kT11YvLnJrTyTO/gVRmyiDcpUZmXXaEXewrI3LaNEw1hK+A+N/dLqZzKE+8e5QsdfwZEyto6PrU/U5kGK9SXVARq9UuaTTAQl13lzBiRR1e9GXaJB4q4vWFnFkvpoxsKG8HCLmYw8v9NzsHWu1xAEYwX7fU=
Received: from YT4PR01CA0109.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:d7::29)
 by SA1PR12MB7245.namprd12.prod.outlook.com (2603:10b6:806:2bf::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 19:23:39 +0000
Received: from BN3PEPF00022BC0.namprd04.prod.outlook.com
 (2603:10b6:b01:d7:cafe::2b) by YT4PR01CA0109.outlook.office365.com
 (2603:10b6:b01:d7::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Wed, 11
 Nov 2026 19:23:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BC0.mail.protection.outlook.com (10.167.248.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 19:23:38 +0000
Received: from MKMZHLUO01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 13:23:36 -0600
From: Zhigang Luo <Zhigang.Luo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <Hawking.Zhang@amd.com>, <Lijo.Lazar@amd.com>, Zhigang Luo
 <Zhigang.Luo@amd.com>, Zhigang Luo <zhigang.luo@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: keep the A+A VF VRAM base at the SRAT address
Date: Wed, 11 Nov 2026 14:23:18 -0500
Message-ID: <20261111192319.297456-4-Zhigang.Luo@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111192319.297456-1-Zhigang.Luo@amd.com>
References: <20261111192319.297456-1-Zhigang.Luo@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC0:EE_|SA1PR12MB7245:EE_
X-MS-Office365-Filtering-Correlation-Id: 53684ad0-ef3d-4d56-b327-08df402949cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|1800799024|376014|56012099006|5023799004|22082099003|18002099003|11063799006|10067099003|261009223027099003|261026140227099003|261021121427099003|261022105027099003|261102123227099003|261021123027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: BF9R/Ri6i0aUvJoKsX8yKJKzS1oN+sXTkzUn3f9jtyS9netDc9jxHFgCRY8J+jOIS1E3b37ejhmfqTIB8AVea7J3NT7o1ZoKjPXJ8K5Kws2drhxIcUs1x3wcdGSEfg0jYYaCyOIVKDZaOMj4ZTYvbS5uRTwK7bgPWJcetsAmFEMKsEPduMyAvDyr4FFdrebPvXKUz293imCqkzmgJdJxZnxRZC3nwGZfE3w4d5LoO8w7Hnlan9lLdooohHBltnyOKnXTqU6L7LAzdMBilKy8EQJQO+c6RKuNoMagYGUckNfiq+TRz8dH2u4l4ZBTSXBh9HcFNh0P9A1xfJLueEJ/qp9fNm5j9jydhZkC/uiVXuAjd0auvJecJZDZE+TaoC0jwzLFmsufwfgBIIO9IMyObWbHcS8LqmKIWIC1YyTQrCpc2NmtasZAoOLeS+cbC4ofoskHrXyiBIhhjYhKTo0H0FvDJS8vWRbKTmBHsn3MOt9gXc41ah/AyoV/C2f1fGAwSAgaTbPtBgosLug6Dw83Qi2gHMI44uMKa8Ob6/6jUfyKxc/x43aR0kcSkl6Bb706ONOjsW5udDzH2s1F8u27J57PLzqQq9iTD1/MtBDqp3hED9/jwKox78fRiNa145p5q1tDq0tARis+ROdOTH8MJMI3AENizo/R5QCZYoOMkxqz6iJfT0EZ/Jf+o340fWg9rXi+GVrhP1vLqfFEZLAsbA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(1800799024)(376014)(56012099006)(5023799004)(22082099003)(18002099003)(11063799006)(10067099003)(261009223027099003)(261026140227099003)(261021121427099003)(261022105027099003)(261102123227099003)(261021123027099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BSLSWdeWBuJ7XLT9ydSRrSvaAKc3AQzEkt5eR8jcJFWRzpCy0A4d0KFmlfS84cbFPp75MGkMVnlJR6X0esVb1yWYRyk3nMk9vMZC0Wnvp5wN9INEpuM2ilGIjV3g14ZVw22ngCQ6RgGthFr+BrR+0Drrj2tevkHjFkXy1jbQUfBSmFqX+QrWvRyUqWIyizJofRjDFxQDeKcEGVCPERtbK018u2TH9a3CywtAyDmOcTta8ic50UdG3HGfAFgCtjfUTRwFn88QZaGbp8dxjN/4g9di1IaTtt3lckn1jmafNH4fXPNWrb+5IWA/pNtAzMZ4LS63T1MUKipcvP9T7QBKncJP0xXc2gseAmYagJ1RFh7I1Zc/XfMx3zsqvE7Xu/sK8AtHAsj4DKpm/okuvgt7ovnqu8PscEAk/010OjI21gSypW1zR86Ivz3Ny5to9kX4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 19:23:38.5454 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53684ad0-ef3d-4d56-b327-08df402949cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7245
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
LFB region and segment registers describe the physical GPU, not the
VF, so physical_node_id * node_segment_size is not a valid VRAM
starting address.

Report the VF as a single XGMI node from mmhub_v4_2_0_get_xgmi_info():
one physical node, node id 0, and a segment covering the SRAT
aperture. The existing node offset math then adds nothing, and
node_segment_size * num_physical_nodes is the VF's local VRAM, so
PDB0 is sized correctly without a special case.

Return aper_base from the GFX 12.1 gfxhub and mmhub
get_mc_fb_offset() callbacks, the same way an APU uses the FB offset
for aper_base, so vram_base_offset is computed by the common path.

Align GART to 8GB. That alignment is one PDB0 entry when
vmid0_page_table_block_size is 12, and it applies to every PDB0
placement.

v2:
- Explain that the SRAT address is already the VF VRAM base and must
  not be adjusted by the XGMI node segment.

v3:
- Report the VF as XGMI node 0 of 1 instead of special-casing the
  node offset and the PDB0 size.
- Return the SRAT address from get_mc_fb_offset() instead of
  special-casing amdgpu_virt_resume().

Signed-off-by: Zhigang Luo <zhigang.luo@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c   |  6 ++++--
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c |  4 ++++
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c    | 13 ++-----------
 drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c | 20 ++++++++++++++++----
 4 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 04cf02dd22ac..ac2664e1eb8a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -42,6 +42,8 @@
 #include <drm/ttm/ttm_tt.h>
 
 static const u64 four_gb = 0x100000000ULL;
+/* PDB0 block size 12 covers one 8GB entry. */
+static const u64 eight_gb = 0x200000000ULL;
 
 bool amdgpu_gmc_is_pdb0_enabled(struct amdgpu_device *adev)
 {
@@ -261,8 +263,8 @@ void amdgpu_gmc_sysvm_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc
 	u64 hive_vram_end = mc->xgmi.node_segment_size * mc->xgmi.num_physical_nodes - 1;
 	mc->vram_start = mc->xgmi.node_segment_size * mc->xgmi.physical_node_id;
 	mc->vram_end = mc->vram_start + mc->xgmi.node_segment_size - 1;
-	/* node_segment_size may not 4GB aligned on SRIOV, align up is needed. */
-	mc->gart_start = ALIGN(hive_vram_end + 1, four_gb);
+	/* Round up to a PDB0 entry so GART starts on the page-table PDE. */
+	mc->gart_start = ALIGN(hive_vram_end + 1, eight_gb);
 	mc->gart_end = mc->gart_start + mc->gart_size - 1;
 	if (amdgpu_virt_xgmi_migrate_enabled(adev)) {
 		/* set mc->vram_start to 0 to switch the returned GPU address of
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
index b13967a1c8fb..13e29752e435 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
@@ -53,6 +53,10 @@ static u64 gfxhub_v12_1_get_fb_location(struct amdgpu_device *adev)
 
 static u64 gfxhub_v12_1_get_mc_fb_offset(struct amdgpu_device *adev)
 {
+	/* SPM VRAM starts at the system physical address from SRAT. */
+	if (amdgpu_virt_vram_is_spm(adev))
+		return adev->gmc.aper_base;
+
 	return (u64)(RREG32_SOC15(GC, GET_INST(GC, 0),
 				  regGCMC_VM_FB_OFFSET) << 24);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index cd276a138e10..1c7f3f0496cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -720,19 +720,10 @@ static void gmc_v12_0_vram_gtt_location(struct amdgpu_device *adev,
 			amdgpu_gmc_agp_location(adev, mc);
 	}
 	/* base offset of vram pages */
-	if (amdgpu_virt_vram_is_spm(adev)) {
-		/*
-		 * For SPM-backed VRAM, PDB0 entries use PTE_SYSTEM, so the
-		 * address is a system physical address. vram_base_offset must
-		 * be aper_base so PDB0 maps GPU address 0 onto the HBM system
-		 * physical address.
-		 */
-		adev->vm_manager.vram_base_offset = adev->gmc.aper_base;
-	} else if (amdgpu_sriov_vf(adev)) {
+	if (amdgpu_sriov_vf(adev) && !amdgpu_virt_vram_is_spm(adev))
 		adev->vm_manager.vram_base_offset = 0;
-	} else {
+	else
 		adev->vm_manager.vram_base_offset = adev->mmhub.funcs->get_mc_fb_offset(adev);
-	}
 
 	adev->vm_manager.vram_base_offset +=
 		adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size;
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
index 4c0a2d671cfc..409d57a9045e 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
@@ -132,6 +132,17 @@ static int mmhub_v4_2_0_get_xgmi_info(struct amdgpu_device *adev)
 	if (!adev->gmc.xgmi.connected_to_cpu)
 		return 0;
 
+	/* The SRAT entry is the VF's whole VRAM. PF_LFB_REGION and the LFB
+	 * segment describe the physical GPU, not the VF, so report a single
+	 * node covering the SRAT aperture.
+	 */
+	if (amdgpu_virt_vram_is_spm(adev)) {
+		adev->gmc.xgmi.num_physical_nodes = 1;
+		adev->gmc.xgmi.physical_node_id = 0;
+		adev->gmc.xgmi.node_segment_size = adev->gmc.aper_size;
+		return 0;
+	}
+
 	xgmi_lfb_cntl = RREG32_SOC15(MMHUB, GET_INST(MMHUB, 0),
 				     regMMMC_VM_XGMI_LFB_CNTL);
 	seg_size = REG_GET_FIELD(
@@ -154,10 +165,7 @@ static int mmhub_v4_2_0_get_xgmi_info(struct amdgpu_device *adev)
 	if (adev->gmc.xgmi.physical_node_id > max_physical_node_id)
 		return -EINVAL;
 
-	if (amdgpu_virt_vram_is_spm(adev) && adev->gmc.aper_size)
-		adev->gmc.xgmi.node_segment_size = adev->gmc.aper_size;
-	else
-		adev->gmc.xgmi.node_segment_size = seg_size;
+	adev->gmc.xgmi.node_segment_size = seg_size;
 
 	return 0;
 }
@@ -180,6 +188,10 @@ static u64 mmhub_v4_2_0_get_fb_location(struct amdgpu_device *adev)
 
 static u64 mmhub_v4_2_0_get_mc_fb_offset(struct amdgpu_device *adev)
 {
+	/* SPM VRAM starts at the system physical address from SRAT. */
+	if (amdgpu_virt_vram_is_spm(adev))
+		return adev->gmc.aper_base;
+
 	return (u64)RREG32_SOC15(MMHUB, GET_INST(MMHUB, 0),
 			         regMMMC_VM_FB_OFFSET) << 24;
 }
-- 
2.43.0

