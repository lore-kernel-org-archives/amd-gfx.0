Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA02606A31A
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2026 07:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=LT7FSPjf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 307F5112671;
	Fri, 30 Oct 2026 07:24:08 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011067.outbound.protection.outlook.com [52.101.62.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B37EE112671
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2026 07:24:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j+kqUZqRuyNJDNJO882pDZbzHzWOZVgrfMupivS5MKwrCbr3l3STXBAbTOkzu2sTADWS4SYT++P4dMsFeA48J6xTIuBCbB7K86eFc9AfRm1aTdgoLNa4XmCE/g5NmtUWVIAhyfgw9lmkbA2bdNEqTqAdWG4dIHO9pEKpgQ9AMrReJ8jCMeAa3fEdPrQK3Q0sKgVeLOpZvi/zS2G2oNxnsQ7oaVuaVIyUj1amDAAU+nyoUpx8xvQMilXdrd/pnfRaVWD+oXqKQzrY1BJsZoUwftdfCmJZy8brlc2DdiS1vWW6gELAvLjHst6Dmh5pJxjLS/po10v9zeh7CXIoEeuwsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eBigJ0VMeMVuYZGgAtlHONlbVYoHYuqk2OYTZKCAIwM=;
 b=JGuP8RxPTnj2439HUCOENaHZK00e4ECRwBdqUT7B+BwSZ3TVTdWLseKxO21n38wju7vtkE701H811FxmZzTNmUriYLl/qnwfYAZOD2+DmtY7FG3zjLUUEvpsNoeosxuS8vLvTbRdFm+eQJ+RvfPcjrTY7l6kkdd4AfHzX4z8uAPDhGhw99cuf/uYrXkHiLlrrPYs/vrgsHz3YjAFmiH5cmboThQHHiwvJJTm4pq/BM95ATtaUdI7mbdfh+WVYhCSSKyqiwdivdaOZo0JOit0UISsIWpDNYQLorsnFC4utCzGL/0bnMIh+5XrIldM3Nj/J3KgFYPdLJdQSN6V0H29jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBigJ0VMeMVuYZGgAtlHONlbVYoHYuqk2OYTZKCAIwM=;
 b=LT7FSPjfVhYQ2BH0BDkyL4zX9iEhtkW03CjLF+VZddnam8sW9PPenbsjntU4x9VL9Wgzn8frxk9rB+K7wYsRwS+1goytkUCQbNiw/uYeoeQR4LEYaitmz+Sm/fcd8k+gFXBwoDiESrXj1qjec8nQYQ9X/f6fIIbS1EiZFF2Tufs=
Received: from PH8PR21CA0005.namprd21.prod.outlook.com (2603:10b6:510:2ce::21)
 by MW4PR12MB6924.namprd12.prod.outlook.com (2603:10b6:303:207::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 07:22:55 +0000
Received: from CY6PEPF00000047.namprd03.prod.outlook.com
 (2603:10b6:510:2ce:cafe::99) by PH8PR21CA0005.outlook.office365.com
 (2603:10b6:510:2ce::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.5 via Frontend Transport; Fri, 30
 Oct 2026 07:22:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY6PEPF00000047.mail.protection.outlook.com (10.167.247.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Fri, 30 Oct 2026 07:22:54 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 30 Oct
 2026 02:22:53 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Fri, 30 Oct 2026 02:22:46 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <lijo.lazar@amd.com>, Prike Liang <prike.liang@amd.com>, Sunil Khatri
 <sunil.khatri@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 4/6] drm/amdgpu/gfx10: consolidate SH_MEM initialization
Date: Fri, 30 Oct 2026 15:20:26 +0800
Message-ID: <20261030072229.598249-4-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261030072229.598249-1-Jesse.Zhang@amd.com>
References: <20261030072229.598249-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY6PEPF00000047:EE_|MW4PR12MB6924:EE_
X-MS-Office365-Filtering-Correlation-Id: b95dd3af-fbdf-4792-bf93-08df36569d5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|18002099003|22082099003|56012099006|11063799006|261009223027099003|261022075727099003|261021123027099003|261021121427099003|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info: OZhWH4upM/kRv4zGIA00WB+zEi4Wr5iFyTTz0fufb9i+rCCz46f1PG4D0/c05A9gbY3DmVGgpaXSlNfxKJIHnFZ1XY5Z0B5IoR+ISaCnUrb5OxsBO4ex9AtdlNMc85YkXcECSKKJkT6RIEh8QdVXL4y/HZLd2mWvB/xaiHJSHSidz2aODmMk3iGhxmw+x6pyh84x1zy0wwIGWwtJvX7KaEiMKI6XR3CWOZ61FnTI4Hz/noINAcCB/Udx/mAnA7qS/igkajmvk+X/tKn3pZ+EqqR2F1srgLXnaSN9Tld+nKLAnnQ/n+rPMyWK8FRs4HQrU0QhJgDqIEx13CQCCGxjaX/cfFyW7av0OGgAH3dMwcbuq/6fBXpzvVA+7YhrzA/D7nWHQgurdrw/UrfPU2thb12bsb2ePLPhW7oCGvNuZPv0wl+Hkx/S2Fj1ceSPXzeVSQvTqAZ4D6Mub8ox0fpM3wv/PuE+vYBRYHv6P2LzJuQ1HLxU6psBEMqpliDgz0Rg4JllPxdV+cEsJuC6GTfBrjB7m25CEYrlll99cYnByCACfbD2nsWqs6X+8I02DMb9MuvxdCbcZbSjRoeeWxcqo9gGHIJYvlUgBMs+BgYVp6OK8m0285UsMiO/wgtBa7kB3F+t/y3U9C1EM1RSubiw1UhwnvtRfee/oebt3kQIXSimBw++sA1gQmRrYNp09VBt6/7jr3wA93MljA/yJ+8KlQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(18002099003)(22082099003)(56012099006)(11063799006)(261009223027099003)(261022075727099003)(261021123027099003)(261021121427099003)(10067099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UKJfcgs24qS/xyBqhxlYpf97pcHz9bP2aJIzLtV7Cij5fGEjEfYl9iR5j1cWVXnpQkaRkhABVxEslm4DfSWK2m28HP2gPDQsUr6aDw42dVpuUHYzqM5P4xB2gpcunUN7XKy/u1UK/tZgweFuq2oX2sy5wY80gfMNG1DVUnvaWFKJus8FeqUHck+HdAbVfeVITK8UZxjfxGC2khNKifWsC/IJupEllMIpX/nxIl8iUIdKgYwr14X2F2UiNHrgtnKEc5utM+sX58n4ZMiejJ/l7PkgkC8iWmEv9qTPJf/F8OxRw7/GCc3wFua+39dIV3D2Bl9PAQjI+PoB3Qbhwf8bXYSMxWhEnjRWiDg70LeXdKqrgpA7YLipazIourt9fpfcbq5vIyh4jal02996mX+YEjsUsxbcAWJwH0WuSbITmphxrX9qmd594gPWigCGcluT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 07:22:54.4342 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b95dd3af-fbdf-4792-bf93-08df36569d5e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY6PEPF00000047.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6924
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

gfx_v10_0_constants_init() programs SH_MEM_CONFIG and SH_MEM_BASES of
VMID 0 and the kernel queue VMIDs, and gfx_v10_0_init_compute_vmid() those
of the user queue VMIDs, each walking its own VMID mask.

Program them in one place, walking the kernel queue and the user queue
VMIDs together and giving each the configuration of its users, as on
GFX11 and GFX12, and keep enabling the traps of the user queue VMIDs with
gfx_v10_0_debug_trap_config_init(). The GDS, GWS and OA clearing of the
user queue VMIDs in gfx_v10_0_init_compute_vmid() goes away,
gfx_v10_0_init_gds_vmid() clears them for all VMIDs but 0 right after.

No functional change.

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 65 ++++++++++----------------
 1 file changed, 24 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index b6f61f4a08e5..c48099f62133 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -5193,41 +5193,46 @@ static void gfx_v10_0_debug_trap_config_init(struct amdgpu_device *adev,
 	WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_DATA1), 0);
 }
 
-static void gfx_v10_0_init_compute_vmid(struct amdgpu_device *adev)
+/*
+ * Program SH_MEM_CONFIG and SH_MEM_BASES of all VMIDs in one place: the user
+ * queue VMIDs get the application apertures and traps enabled, the kernel
+ * queue VMIDs, including the SPM VMID, the GPUVM apertures. VMID 0 only gets
+ * SH_MEM_CONFIG, its SH_MEM_BASES is left alone.
+ */
+static void gfx_v10_0_init_sh_mem(struct amdgpu_device *adev)
 {
+	unsigned long uq_mask = adev->vm_manager.vmid_uq_mask_gfxhub;
+	unsigned long mask = amdgpu_vmid_kq_mask(adev, AMDGPU_GFXHUB(0)) | uq_mask;
+	u32 kq_bases, uq_bases;
 	int i;
-	uint32_t sh_mem_bases;
+
+	kq_bases = REG_SET_FIELD(0, SH_MEM_BASES, PRIVATE_BASE,
+				 adev->gmc.private_aperture_start >> 48);
+	kq_bases = REG_SET_FIELD(kq_bases, SH_MEM_BASES, SHARED_BASE,
+				 adev->gmc.shared_aperture_start >> 48);
 
 	/*
-	 * Configure apertures:
+	 * Configure apertures of the user queue VMIDs:
 	 * LDS:         0x60000000'00000000 - 0x60000001'00000000 (4GB)
 	 * Scratch:     0x60000001'00000000 - 0x60000002'00000000 (4GB)
 	 * GPUVM:       0x60010000'00000000 - 0x60020000'00000000 (1TB)
 	 */
-	sh_mem_bases = DEFAULT_SH_MEM_BASES | (DEFAULT_SH_MEM_BASES << 16);
+	uq_bases = DEFAULT_SH_MEM_BASES | (DEFAULT_SH_MEM_BASES << 16);
 
 	mutex_lock(&adev->srbm_mutex);
-	for_each_uq_gfx_vmid(i, adev) {
+	for_each_set_bit(i, &mask, AMDGPU_NUM_VMID) {
 		nv_grbm_select(adev, 0, 0, 0, i);
 		/* CP and shaders */
 		WREG32_SOC15(GC, 0, mmSH_MEM_CONFIG, DEFAULT_SH_MEM_CONFIG);
-		WREG32_SOC15(GC, 0, mmSH_MEM_BASES, sh_mem_bases);
+		if (uq_mask & BIT(i))
+			WREG32_SOC15(GC, 0, mmSH_MEM_BASES, uq_bases);
+		else if (i)
+			WREG32_SOC15(GC, 0, mmSH_MEM_BASES, kq_bases);
 	}
 	nv_grbm_select(adev, 0, 0, 0, 0);
 	mutex_unlock(&adev->srbm_mutex);
 
-	/*
-	 * Initialize all compute VMIDs to have no GDS, GWS, or OA
-	 * access. These should be enabled by FW for target VMIDs.
-	 */
-	for_each_uq_gfx_vmid(i, adev) {
-		WREG32_SOC15_OFFSET(GC, 0, mmGDS_VMID0_BASE, 2 * i, 0);
-		WREG32_SOC15_OFFSET(GC, 0, mmGDS_VMID0_SIZE, 2 * i, 0);
-		WREG32_SOC15_OFFSET(GC, 0, mmGDS_GWS_VMID0, i, 0);
-		WREG32_SOC15_OFFSET(GC, 0, mmGDS_OA_VMID0, i, 0);
-	}
-
-	gfx_v10_0_debug_trap_config_init(adev, adev->vm_manager.vmid_uq_mask_gfxhub);
+	gfx_v10_0_debug_trap_config_init(adev, uq_mask);
 }
 
 static void gfx_v10_0_init_gds_vmid(struct amdgpu_device *adev)
@@ -5336,9 +5341,6 @@ static void gfx_v10_0_get_tcc_info(struct amdgpu_device *adev)
 
 static void gfx_v10_0_constants_init(struct amdgpu_device *adev)
 {
-	u32 tmp;
-	int i;
-
 	if (!amdgpu_sriov_vf(adev))
 		WREG32_FIELD15(GC, 0, GRBM_CNTL, READ_TIMEOUT, 0xff);
 
@@ -5357,26 +5359,7 @@ static void gfx_v10_0_constants_init(struct amdgpu_device *adev)
 	WREG32_FIELD15(GC, 0, DB_RING_CONTROL, COUNTER_CONTROL,
 		       (adev->gfx.me.num_pipe_per_me > 1) ? 0 : 1);
 
-	/* XXX SH_MEM regs */
-	/* where to put LDS, scratch, GPUVM in FSA64 space */
-	mutex_lock(&adev->srbm_mutex);
-	for_each_vmid_and_zero(i, adev, AMDGPU_GFXHUB(0)) {
-		nv_grbm_select(adev, 0, 0, 0, i);
-		/* CP and shaders */
-		WREG32_SOC15(GC, 0, mmSH_MEM_CONFIG, DEFAULT_SH_MEM_CONFIG);
-		if (i != 0) {
-			tmp = REG_SET_FIELD(0, SH_MEM_BASES, PRIVATE_BASE,
-				(adev->gmc.private_aperture_start >> 48));
-			tmp = REG_SET_FIELD(tmp, SH_MEM_BASES, SHARED_BASE,
-				(adev->gmc.shared_aperture_start >> 48));
-			WREG32_SOC15(GC, 0, mmSH_MEM_BASES, tmp);
-		}
-	}
-	nv_grbm_select(adev, 0, 0, 0, 0);
-
-	mutex_unlock(&adev->srbm_mutex);
-
-	gfx_v10_0_init_compute_vmid(adev);
+	gfx_v10_0_init_sh_mem(adev);
 	gfx_v10_0_init_gds_vmid(adev);
 
 }
-- 
2.50.1

