Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368F4606A323
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2026 14:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Ri/QuL7m
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C873D10E7A3;
	Fri, 13 Nov 2026 14:57:45 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010013.outbound.protection.outlook.com [52.101.85.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 967DE10E7FD
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2026 14:57:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d5vclheSTdzr5B9RFt8Tv0k1BUsEfki4SeMf594Ev1oBNOTcYX+FIIy0geQeOkPDCgb1fxprx2njRRV4ftSNzooqSzYQzd16HsQaYOMyEPy8InWD/X5mv5gngegYb+hAwiWhHDjMbIUmZxZcuduXKs/qWvvE0Vvp2fdovJ93GhlBLmpT3uqjtifeOHZjYtVHpypM2rCgWBwlp73g9YgeT8axI0ahb4zMMSHkOXjTH1w7fPBV6lKPVTQje/ObYOoll1NVDT/7NNOr3cUKkYfDKtQg0vMv2gw3hibr83pnmEAgWhCOLjpXPsxCXoCSsG80jRoCRFkCGDzGx1g9l6GJ5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tf/AMt6o/fsRyYH3I9ZGzhJ5VmLOuq0zhIK9L+7Cebk=;
 b=r6awGlDaz4enrI0q8Gg9miDj/p3Iju+6Rwr1d0m4mTGLDxzTLJ0i5mpcEW22Vj6gKIHe3mIYPxzoa+pXFzKCieCzqR8cyw8siBULA9d/dKUZ78oIkGn9fKNb5hjct+WJLc+O6ffk0NM0hX0gbdhtQVi9pxfC9mDOLESY73JkUvdHVNS147741go6RAPddiGE4rK0uoQFU7Mqu0aTCNHaZNIVSSmpU5did0JO3tLmPZTiRf5TZ2AKzUQFuSDROheLiUrsS1SZits8vpDlTIqccNmiho/dGKLQO9iODHRQhAz9TrtYhdOctvnNq5WDbx9CtgGR1Z9IkVTzW0GRfbtwAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tf/AMt6o/fsRyYH3I9ZGzhJ5VmLOuq0zhIK9L+7Cebk=;
 b=Ri/QuL7my94VldB/Lldqg6h6zdqddO4VtjsGjlm8mzxfWikYE5XxLNduvAZuMy/JOiy+D/TMcB3R92lFhrNrXkP5FZT6y3GCkA8/2O30vFsm8agyla/trvI81DP64IANY7TJwsRv3Fz6e/ie+j5JAwEsIvbiDgqGp/wMqd2DBMA=
Received: from CY8PR19CA0045.namprd19.prod.outlook.com (2603:10b6:930:6::15)
 by PH7PR12MB8015.namprd12.prod.outlook.com (2603:10b6:510:26a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Fri, 13 Nov
 2026 14:57:35 +0000
Received: from CY7PEPF000000F3.namprd05.prod.outlook.com
 (2603:10b6:930:6:cafe::1c) by CY8PR19CA0045.outlook.office365.com
 (2603:10b6:930:6::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Fri, 13
 Nov 2026 14:57:35 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY7PEPF000000F3.mail.protection.outlook.com (10.167.247.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 13 Nov 2026 14:57:35 +0000
Received: from MKMZHLUO01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 13 Nov
 2026 08:57:21 -0600
From: Zhigang Luo <Zhigang.Luo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <Hawking.Zhang@amd.com>, <Lijo.Lazar@amd.com>, Zhigang Luo
 <Zhigang.Luo@amd.com>, Zhigang Luo <zhigang.luo@amd.com>
Subject: [PATCH 7/7] drm/amdgpu: keep the A+A VF VRAM base at the SRAT address
Date: Fri, 13 Nov 2026 09:57:02 -0500
Message-ID: <20261113145702.323968-7-Zhigang.Luo@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261113145702.323968-1-Zhigang.Luo@amd.com>
References: <20261113145702.323968-1-Zhigang.Luo@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY7PEPF000000F3:EE_|PH7PR12MB8015:EE_
X-MS-Office365-Filtering-Correlation-Id: f36c5885-a83d-4635-fca3-08df419673c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|1800799024|36860700016|260925022911599003|260925021911599003|10067099003|260925021311599003|56012099006|261021123027099003|261022105027099003|261022075727099003|261026140227099003|261021121427099003|11063799006|261102123227099003|261028144727099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: rgDo4rNpoGNHO92SsKzinAV0yoJxU6feOOIVXwrYMldoA2A7LtldYx9xWvGI/7ZS3TYhxgs+PzJmZihe3ct65YUKlViK751v0ysdXrrM33txeCCDzAOEvaMCencCYBht3XhmxZE+6rUT2QT5Wyr8+A0YWfvu5BQhkOQPq2uFVQS4XCqVTA24tk2WD15dhvUg3RzRqKD2lxcOeDBUyC43EBIip/t4nFnW8/uBisKMhBR173ZjulNWnvw6eRLxvsx8XGoWlZCvllQ+rE8eDaL76wP9BfnfGSFQFOBJvAMltBSDM5knHDehrhOWNGaEGXOg6hb1Mj3fVkTlQ+0VHOQcbbDZDw4j/NegRFKqEYBfXRjvF3/2NDu2WOUUOPNkVzhI19I9aLQiI7gYdKY4fHHzK8JinYxjUhS8g//dyEGBxHrrfMSGILgbX/4Q2eCZsMU0zU1pVy8Q8zY+YhW3bjCjXKVQoA3pRJCTH2zmIznApn0OxAA9vf2dQdkRpeqyOvOEEyuLWHIFFM1s5DCk/m/0wlLAFEMRaQEEzErncV6URufUaSt/Z00B0xQGOXMJi1MVjBM6WAloX00zSo/1KLa3ZKCVJVAQ615FUlUrhVtwDLNVla6XGwG8kbtDBeqxBE6CxVvgVSH4ih+Yzg6G7wiRw9XeP8GXda45ys7/c4XQg4msLTYSdGf0s4JAYieZdFQJ58M4t3h6D9++FIjCS97z2w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(1800799024)(36860700016)(260925022911599003)(260925021911599003)(10067099003)(260925021311599003)(56012099006)(261021123027099003)(261022105027099003)(261022075727099003)(261026140227099003)(261021121427099003)(11063799006)(261102123227099003)(261028144727099003)(261009223027099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: l4hc5qIMwOLmGiQKx89tI43eVEcqxd4+TCB0teEgDhIC8PvCpn4y9tLsfpZ6glxVePIwzGlKPoamXIHXu9j4WiGcCDr/nf6YDtrhe1hNVY8ZVqUdHNWqDGR7ui8GtPYIy+lhTnZ6geqmyUAeY1BikbXBgnQkUQE1AUiR3nqAiY9y9ugSjQkuwxJJiILwIkEyk4Q5LgP8qiDnZpdN2aMP6o717pjE8NOePp1CBePp6eOgpWg0MlBqqZR8zzPTDTYyLg8IjNLNLaC2s8EX/TGH+QZqBe9NQkWOA2QQ3kBOmXpZIsBgqoondM8Beqx8nBbJP7SDVFpwef3vyVK56WmF/utrtBPbCgw+RpX/y+KVmHXwwEV+wV+gmIiluWKvpOD6wMa17d/m+pRUGPZaI5G4CM5jNTamx8G5a6MOjPymdpRZ88DYS1G9AFHRDsJ4/z2r
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 14:57:35.1970 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f36c5885-a83d-4635-fca3-08df419673c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY7PEPF000000F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8015
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

Read the SRAT entry in mmhub_v4_2_0_get_xgmi_info() and report the VF
as one physical node at id 0 whose segment is the SRAT length. Save
the SRAT address as the FB offset. get_mc_fb_offset() returns that
address, and mc_init copies it, plus the node product, into aper_base
and sets aper_size from the segment. Node id 0 makes the product zero,
so the PTE base stays at the SRAT address.

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

Signed-off-by: Zhigang Luo <zhigang.luo@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h   |  4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h  |  8 +++++---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c |  4 ++++
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c | 25 +++++++++++++++++++++++
 5 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index d17055d4c50a..1772c9f5c940 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -231,6 +231,10 @@ struct amdgpu_gmc {
 	 */
 	resource_size_t		aper_size;
 	resource_size_t		aper_base;
+	/* SPM VF framebuffer offset from SRAT. get_mc_fb_offset() returns
+	 * this, and mc_init copies it into aper_base.
+	 */
+	u64			fb_offset;
 	/* for some chips with <= 32MB we need to lie
 	 * about vram size near mc fb location */
 	u64			mc_vram_size;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
index 5f36aff17e79..47092ec6dff2 100644
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
index b13967a1c8fb..b19f5b601d2c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
@@ -53,6 +53,10 @@ static u64 gfxhub_v12_1_get_fb_location(struct amdgpu_device *adev)
 
 static u64 gfxhub_v12_1_get_mc_fb_offset(struct amdgpu_device *adev)
 {
+	/* SPM VRAM starts at the SRAT address saved as the FB offset. */
+	if (amdgpu_virt_vram_is_spm(adev))
+		return adev->gmc.fb_offset;
+
 	return (u64)(RREG32_SOC15(GC, GET_INST(GC, 0),
 				  regGCMC_VM_FB_OFFSET) << 24);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index 7e0b83b1015f..14ef841d7036 100644
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
index 4495d52b4b07..8593453445e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
@@ -132,6 +132,27 @@ static int mmhub_v4_2_0_get_xgmi_info(struct amdgpu_device *adev)
 	if (!adev->gmc.xgmi.connected_to_cpu)
 		return 0;
 
+	/* The SRAT entry is the VF's whole VRAM. PF_LFB_REGION describes
+	 * the physical GPU, not the VF, so report a single node. The
+	 * length is the segment size; the address is the FB offset.
+	 * aper_base is filled from those later.
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
+		adev->gmc.fb_offset = fb_offset;
+		adev->gmc.xgmi.num_physical_nodes = 1;
+		adev->gmc.xgmi.physical_node_id = 0;
+		adev->gmc.xgmi.node_segment_size = seg_size;
+		return 0;
+	}
+
 	xgmi_lfb_cntl = RREG32_SOC15(MMHUB, GET_INST(MMHUB, 0),
 				     regMMMC_VM_XGMI_LFB_CNTL);
 	seg_size = REG_GET_FIELD(
@@ -177,6 +198,10 @@ static u64 mmhub_v4_2_0_get_fb_location(struct amdgpu_device *adev)
 
 static u64 mmhub_v4_2_0_get_mc_fb_offset(struct amdgpu_device *adev)
 {
+	/* SPM VRAM starts at the SRAT address saved as the FB offset. */
+	if (amdgpu_virt_vram_is_spm(adev))
+		return adev->gmc.fb_offset;
+
 	return (u64)RREG32_SOC15(MMHUB, GET_INST(MMHUB, 0),
 			         regMMMC_VM_FB_OFFSET) << 24;
 }
-- 
2.43.0

