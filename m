Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EEB606A323
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2026 19:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=fZujtegj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B05F410E20C;
	Mon, 16 Nov 2026 19:47:56 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011032.outbound.protection.outlook.com [52.101.57.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18DA110E20C
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2026 19:47:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bBCJhDkghlVUTqOhrf+BLLZqH71k3ujTOlP1x6YUqUGwYxKCNpKtKPvFfcNrojmD10vJ/v51kTFqG1hTm2n5w2cPNSJTiRlDBbJU7pf/MZyqcXLAuUZjyv2SU2hHZodoX9sG59qm5nZNlWpOu16N28DFBcApqvoaZHY68mwVwv+B0IclPZTdhvYLG82Tz+T2w+nnQSALrQUDUbENsxdosiW7oQS1J8wCzdtkpvWu8STkRHadyRVD+0PxDSLPqhKvkkJYUr6YLmbo4Xp9wCQuCq/YY3sCjCC082GUAHFKohCVfNf5Mx7Tpeq9AoxWdP0UjNpCNnZGO+qGQ5XoRA3Yzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yyLTuz/3feEHVMkQOKuCKt25hOg/PzJyXyKyPOcYddA=;
 b=LojTGcgNoXegWp4zo7iY4fX1ZgwcMkjFapM7GdZz9h7CCOAOLJsRldAKKI6WvYh4uxDYczkNzhbyVCuJ/xFRBFayrQ/9UV9RIhv7P+6EZesP4vv3PCV4j0WGr1+BrOtxifCzqEMIG00MV2bFcOimv1twPEyIP7rY2kfcUnUaHM0QNmP3WCYG5XCbvIhWdl+sxycTwfS0fiCJY2ge5k0fUu7nSyvih3TggJgXSmlKTFKTB2fRRIaCDZtlPg77nmkvEE8s4NlechOWL/MnvbKa+SluHmCDQXTN4v7W5777TvO4vl3H8AEnjUOYwlpTa9xtQWOCEvQgcY6lJxFpDvx/sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yyLTuz/3feEHVMkQOKuCKt25hOg/PzJyXyKyPOcYddA=;
 b=fZujtegj3Axi0f0guH7DHaGZ2/9pXfPbzjle6Qv2LyvqIzDXEybYbnNi5yIhdfvPtl9Z+GmYgaDFYjWIAxGKXdNZ9+DuTzN0LKrAWXhjC+LA+zdn5ECqUqous3U3lNEygWS5ln+SquRe9PXOXMvGUtOQauKopwsk1G2UHRnssR4=
Received: from DS1P221CA0026.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:242::10) by
 IA4PR12MB663679.namprd12.prod.outlook.com (2603:10b6:207:12d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 19:47:46 +0000
Received: from CY8PEPF0000005B.namprd21.prod.outlook.com
 (2603:10b6:8:242:cafe::8d) by DS1P221CA0026.outlook.office365.com
 (2603:10b6:8:242::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Mon,
 16 Nov 2026 19:47:46 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY8PEPF0000005B.mail.protection.outlook.com (10.167.247.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.0 via Frontend Transport; Mon, 16 Nov 2026 19:47:45 +0000
Received: from MKMZHLUO01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 16 Nov
 2026 13:47:44 -0600
From: Zhigang Luo <Zhigang.Luo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <Hawking.Zhang@amd.com>, <Lijo.Lazar@amd.com>, Zhigang Luo
 <Zhigang.Luo@amd.com>, Zhigang Luo <zhigang.luo@amd.com>
Subject: [PATCH 7/7] drm/amdgpu: keep the A+A VF VRAM base at the SRAT address
Date: Mon, 16 Nov 2026 14:47:27 -0500
Message-ID: <20261116194727.397571-2-Zhigang.Luo@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116194727.397571-1-Zhigang.Luo@amd.com>
References: <20261116194727.397571-1-Zhigang.Luo@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PEPF0000005B:EE_|IA4PR12MB663679:EE_
X-MS-Office365-Filtering-Correlation-Id: a8e1d4fa-f2d1-4147-0da7-08df441a7ca4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|23010399003|22082099003|18002099003|261009223027099003|11063799006|56012099006|261102123227099003|261028144727099003|261026140227099003|261021121427099003|261021123027099003|261022075727099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info: VMAF1Kt1ngOqKaVKed62lPN5fgWP5j9QwXUwmdRX+xmuKXdQfRAVPHMvVPgCn1IlxlJZGkGAkinfRKO3CcqaddpB8e+S3aksKXZ97khK7j96ndm1u5NWvkJALqfN1Ueg4qsCZIjSLHGPDV3MYYytvU1hNFZosoBv1wJKDlJ+IilWYu6DBcF6N5XrTFX32IiVFEk+w4lsEHUqdApZgfB0XWDWn83S2cPdMuDwCBf21GgcmpzYostesQvsYePwvBknGyBfU+CC2ky3Kf6P0+qL/o+KcfN5PzaSlSR26oXOmZLHAqXjXRod6E6G+pClzPdzzC78cS5Af6dW9RwORzdllRyiEmF+7JKYWbuvQxnsQLZxndysavk/cn+y2D/+xDN66r53Ze1B9UrPgbllezTTm08C8AVIlTntMFVW39/6aroY1eWz5D/E/l9PvJZNvYBhoVHvBMlSIWE87Sy0q1hBmEzmCRIYAzywjWQlfx1TzN1TemeRUHzP8ZVSLQ+9jXj5PbvyVqKzqQkdHpGuIUkUC22D3TyZSg9YuOCFfqSZDA1gs+9vi2fNhWZwRoVgJRlJcqu2CmlvIEC2PRW6mc9THDJaT7alhtUwjXy1CWUM6apBcmYMF+4XrJ6zfc3tjJN3hDBRSOFhnhizJGzNzeUxEu7xh3zcIJ5EsqIVsnLGaOpl3arFlTXrEmK82gateUYPZRK4XNX5DM4k992l7hOutQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(23010399003)(22082099003)(18002099003)(261009223027099003)(11063799006)(56012099006)(261102123227099003)(261028144727099003)(261026140227099003)(261021121427099003)(261021123027099003)(261022075727099003)(261022105027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Bw744lPPEpRf7cRAfGFCzw7zCu87pP3+Cd1aGgihQKjs3Aa3zMu3vWAox5KGEiylEBq1juPmR2QiRSroJer43jsfcVu0+wEFn8BNW+9s4GGGiKOJNrsQf4TwSh+pvar+p+EiYc+KhwoOafjjBzTVt5O8T+jU+OC1aw76/9IdgyxCdwHH7r2fGNwAUcKwDnTLOV+EtthBMRLgUWokDDnxKLidLGN6fvz8sD+fdnedQLSv29negAbXq1Pmj428XaAxXDww8yGkqRgpyWLf4Zm7vOHpqq0Lt2zSQ0ZaGp6sozfbqnFrepDKcXNNzIVPmfMegMzU6wVqoVOQbxy7uqikwC8GDniaHd7IhX8435pdq43lyWnE3Vu1TAHdv4nvVI08Hwl1M9mA/bAIcfsC2VRt74hSvNF/y0EbELlWqgwL1RHJ3BSw1MxxEZTBUXnP3gM/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 19:47:45.9994 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8e1d4fa-f2d1-4147-0da7-08df441a7ca4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY8PEPF0000005B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB663679
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

On the A+A VF the hypervisor reports each VF's VRAM address and length
in the ACPI SRAT table. The XGMI LFB region and segment registers
describe the physical GPU, not the VF, so the node id and segment read
from those registers are not a valid VRAM starting address.

Read the SRAT length in mmhub_v4_2_0_get_xgmi_info() and report the VF
as one physical node at id 0 whose segment is that length.
get_mc_fb_offset() reads the SRAT address on each call. mc_init copies
that address, plus the node product, into aper_base and sets aper_size
from the segment. Node id 0 makes the product zero, so the PTE base
stays at the SRAT address.

v2:
- Explain that the SRAT address is already the VF VRAM base and must
  not be adjusted by the XGMI node segment.

v3:
- Report the VF as XGMI node 0 of 1 instead of special-casing the
  node offset and the PDB0 size.

v4:
- Read SRAT in get_xgmi_info() and derive aper_base and aper_size from
  the FB offset and the segment size.
- Move the 8GB GART alignment into its own patch.

v5:
- Revert the SRAT aperture commit with the other two reverts. Leave
  mc_init on the restored connected_to_cpu path.

v6:
- Read the SRAT address in both get_mc_fb_offset() helpers on each
  call instead of caching it. Keep the SRAT length as the segment
  size.
- PDB0 is already enabled because the VF is CPU-connected. Leave
  amdgpu_gmc_is_pdb0_enabled() unchanged.

Signed-off-by: Zhigang Luo <zhigang.luo@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h  |  8 +++--
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c | 16 ++++++++++
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c | 38 +++++++++++++++++++++++
 4 files changed, 60 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
index 5f36aff17e79e..47092ec6dff2c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
@@ -79,11 +79,13 @@ struct amdgpu_xgmi {
 	/* from psp */
 	u64 node_id;
 	u64 hive_id;
-	/* fixed per family */
+	/* Segment size. Fixed per family on a hive. On an SPM VF this is
+	 * the SRAT length of that one VF.
+	 */
 	u64 node_segment_size;
-	/* physical node (0-3) */
+	/* Physical node, 0-3. An SPM VF is node 0. */
 	unsigned physical_node_id;
-	/* number of nodes (0-4) */
+	/* Number of nodes, 0-4. An SPM VF reports one node. */
 	unsigned num_physical_nodes;
 	/* gpu list in the same hive */
 	struct list_head head;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
index b13967a1c8fba..837ad28530e48 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
@@ -53,6 +53,22 @@ static u64 gfxhub_v12_1_get_fb_location(struct amdgpu_device *adev)
 
 static u64 gfxhub_v12_1_get_mc_fb_offset(struct amdgpu_device *adev)
 {
+	/* SPM VRAM starts at the SRAT address. */
+	if (amdgpu_virt_vram_is_spm(adev)) {
+		u64 fb_offset, seg_size;
+		int r;
+
+		r = amdgpu_acpi_find_gpu_memory_in_srat(adev, &fb_offset,
+							&seg_size);
+		if (r) {
+			dev_err(adev->dev,
+				"Failed to find SPM VRAM in SRAT: %d\n", r);
+			return 0;
+		}
+
+		return fb_offset;
+	}
+
 	return (u64)(RREG32_SOC15(GC, GET_INST(GC, 0),
 				  regGCMC_VM_FB_OFFSET) << 24);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index 7e0b83b1015fc..14ef841d70365 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -707,7 +707,7 @@ static void gmc_v12_0_vram_gtt_location(struct amdgpu_device *adev,
 			amdgpu_gmc_agp_location(adev, mc);
 	}
 	/* base offset of vram pages */
-	if (amdgpu_sriov_vf(adev))
+	if (amdgpu_sriov_vf(adev) && !amdgpu_virt_vram_is_spm(adev))
 		adev->vm_manager.vram_base_offset = 0;
 	else
 		adev->vm_manager.vram_base_offset = adev->mmhub.funcs->get_mc_fb_offset(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
index 4495d52b4b07c..ba4483948ce5f 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
@@ -132,6 +132,26 @@ static int mmhub_v4_2_0_get_xgmi_info(struct amdgpu_device *adev)
 	if (!adev->gmc.xgmi.connected_to_cpu)
 		return 0;
 
+	/* The SRAT entry is the VF's whole VRAM. PF_LFB_REGION describes
+	 * the physical GPU, not the VF, so report a single node. The
+	 * length is the segment size. get_mc_fb_offset() reads the
+	 * address later.
+	 */
+	if (amdgpu_virt_vram_is_spm(adev)) {
+		u64 fb_offset;
+		int r;
+
+		r = amdgpu_acpi_find_gpu_memory_in_srat(adev, &fb_offset,
+							&seg_size);
+		if (r)
+			return r;
+
+		adev->gmc.xgmi.num_physical_nodes = 1;
+		adev->gmc.xgmi.physical_node_id = 0;
+		adev->gmc.xgmi.node_segment_size = seg_size;
+		return 0;
+	}
+
 	xgmi_lfb_cntl = RREG32_SOC15(MMHUB, GET_INST(MMHUB, 0),
 				     regMMMC_VM_XGMI_LFB_CNTL);
 	seg_size = REG_GET_FIELD(
@@ -177,6 +197,24 @@ static u64 mmhub_v4_2_0_get_fb_location(struct amdgpu_device *adev)
 
 static u64 mmhub_v4_2_0_get_mc_fb_offset(struct amdgpu_device *adev)
 {
+	/* SPM VRAM starts at the SRAT address. mc_init copies it into
+	 * aper_base.
+	 */
+	if (amdgpu_virt_vram_is_spm(adev)) {
+		u64 fb_offset, seg_size;
+		int r;
+
+		r = amdgpu_acpi_find_gpu_memory_in_srat(adev, &fb_offset,
+							&seg_size);
+		if (r) {
+			dev_err(adev->dev,
+				"Failed to find SPM VRAM in SRAT: %d\n", r);
+			return 0;
+		}
+
+		return fb_offset;
+	}
+
 	return (u64)RREG32_SOC15(MMHUB, GET_INST(MMHUB, 0),
 			         regMMMC_VM_FB_OFFSET) << 24;
 }
-- 
2.43.0

