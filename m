Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC9A606A31D
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2026 07:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=X99g0W+d
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8DF1112670;
	Fri, 30 Oct 2026 07:22:58 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011033.outbound.protection.outlook.com [52.101.57.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B3E6112673
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2026 07:22:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZWXPMkXQyjjDMGfVNMY7hEWnerqLRunm/NQQ3IHaGmYuvJmx8Gx0udZvoPk2I0efH3lC1myDEUaNPedirkkiEtTifvzhflYMgnSe0Q3MXEDyc2pSAkzVMIx9Fsdbx4NbAxsfAxf/Yd5H9OvcMvykRXxwBJYv45KI9D6QnHhrcxHFb+tRU6qkxqRhwnodP0kDzRW/AxF0dxEVqRWU5ch8epoQ6x3nz41ThU09QByQ1dTWpoFLQ8YxUHXLeyXrpTSq/sSRq5LCBNV986dVpmYxI7s+KWxonMHxZys4MTC0XUFP/0S56T+6eWRF6Grd1ihegD9QvSiYItki8RwfX7jvxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O37iEw/IfFeiGDaWObujA3RHY0ZBTPFdF3JKF0AhrSM=;
 b=EDpMykn++6iheswdXbH3Jra23wVDzGWbAMG1ng6Z4r6CifkbK7rVnQsKU68OB2paif7ELmi5Vc+7awUwxl0oAoeUO/P6QathnsfIsWDIotViJSKqKv/qHD0dO5RKfasZh4r06/PpAphpPMHU+agZK0kaShmdMcGIJU8ISa2N4Uu+OWdFC7q0BC2ZIcQzfeH3KRcqhHfxKlYYpthwWJE+zJiroNvfIp3CVVhmQPnylj6WsKVUJJ6AjslyCWrEqGf9KqKpjwqcLueuu6I5lg+202qlO5I+hFFf0Q2qde0n/pze3g0L7W1tfpb9Pb2txUAoSzwYGp421sau4EiUDYQUog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O37iEw/IfFeiGDaWObujA3RHY0ZBTPFdF3JKF0AhrSM=;
 b=X99g0W+d9i5XRyTwwYCwDqX00GfLxqgaOeXyBrACXhJ2EF2057GBaFdAHecy2l3t0sB13tj/T2DdKgrkacAVc4t8UiucXccDwKxY9uUO12sbDGsxGCkfpn/mo2kcaDLzOucT9MbaRLeRCOu6C/+JMTkLT7COMNaM4lngkEQ8BmA=
Received: from CYXPR03CA0065.namprd03.prod.outlook.com (2603:10b6:930:d1::7)
 by MW4PR12MB6681.namprd12.prod.outlook.com (2603:10b6:303:1e1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 07:22:47 +0000
Received: from CY6PEPF0000004D.namprd03.prod.outlook.com
 (2603:10b6:930:d1:cafe::38) by CYXPR03CA0065.outlook.office365.com
 (2603:10b6:930:d1::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.9 via Frontend Transport; Fri, 30
 Oct 2026 07:22:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY6PEPF0000004D.mail.protection.outlook.com (10.167.247.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Fri, 30 Oct 2026 07:22:47 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 30 Oct
 2026 02:22:46 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Fri, 30 Oct 2026 02:22:39 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <lijo.lazar@amd.com>, Prike Liang <prike.liang@amd.com>, Sunil Khatri
 <sunil.khatri@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 3/6] drm/amdgpu/gfx11: consolidate SH_MEM initialization
Date: Fri, 30 Oct 2026 15:20:25 +0800
Message-ID: <20261030072229.598249-3-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261030072229.598249-1-Jesse.Zhang@amd.com>
References: <20261030072229.598249-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY6PEPF0000004D:EE_|MW4PR12MB6681:EE_
X-MS-Office365-Filtering-Correlation-Id: 44f5d6df-f7c2-486e-e0ba-08df365698f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|10067099003|11063799006|6133799003|261009223027099003|261022075727099003|261021121427099003|261021123027099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: dpsp65VAlNkjqFnaafdmBfkTyUVXNrLjSu+0Q4A+kkemErPdMVDdynpuXWrRG9GhMioaRbk7HNUQ3DB3kEVTlYMY5kDDtettMKRX5D2G2kTNHmrErb7mAsOmyTBucVLPKkKU/GSNYN/Xlj9JaqtmxhIucMncOemzESPVYAknNyOzNmFGI49TRKlNXO2H+FC0KLZeFzMAiEviBNEIFJ0XOuEjk48/CdJB1eHfOWD/Uxb5GgM12MGJ3mAFALAmC9DDBBCNpgqSpzCMzkyGsMAkGku5BRmPMIzsiegBOkcaOcSloxnDcLU6Fgyo0f2iF5E2qo9ELVi+mbXZwSDik8TvxZWuJwBojP4JpBun9lcsxpXj2rnv9rPeVjgFn5yLQYL7Wmn/X4924uTYjtL5k6xEelx6L66rIbz9BJEp7XzD0VbmGOINUx1W8j/DACfYtp6nIrEyWFCbV3uTozAijWckVzUSEuyDQST/wkfMCp0sQNFQxX5/uxb/vpH+XDv8fsxDOcYm8SxlNs41lxPugXHTWA1Oh2/DaSacCesO0PsHRlpg811pvPb4Q7t//TaIp/MBDQXhW0uqloVdLRmcHR7MC4xhuFdF55XDwCdQLArhlQHtu/ajxd6qXRIV9I3KlQ8oKccqoBCJPMqlh3QdzdRIWFo6PtBhvV2O5lrDWgYJGsqK4vCVKOm0zKd22Kon3brK+r0C6t1oEMGDOWsPYYpT0A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(10067099003)(11063799006)(6133799003)(261009223027099003)(261022075727099003)(261021121427099003)(261021123027099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3X+S6ntVZSoOTgzci4SKntSLeHDH6xy18FhQuLY0jD/yhGKFdwwMhpHHWKiAz4gURxq+OuxW7vpVizyaVcbx06dtmmsEg7UFGw+B5NceqLrqWeJ0cmY0Vh3DkMDD55xqXOUIMOE8QEczDhEMiFlm7XnOpjyAODYysTDX+9EtAWjlHwvvwiIrnipFnRQrs37D2BBCVAEH8xid2qFF/vAkFyKQD9I8uh2mt4XWyP8CBTjMNkUaAzUt9TLz6QOBIVg0EMnWLpdw+V0qLARWG6jktxSiYn23pFplOVyIRUp2e8A+aGY807beJ1MhB7uC49gVG1uOpP4EF/qcsuhZLfiZF9TNmIbEjDMDAmSxaAcpE7T3KEbsVPN2R8usLO0cAMh3xvOF4hYLD1/KMZ6hRmo09re6hB9a5/CapCqY5Se6K7s82UItf04l/JgyzU/yfI0w
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 07:22:47.0104 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44f5d6df-f7c2-486e-e0ba-08df365698f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY6PEPF0000004D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6681
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

gfx_v11_0_constants_init() programs SH_MEM_CONFIG and SH_MEM_BASES of
VMID 0 and the kernel queue VMIDs, and gfx_v11_0_init_compute_vmid() those
of the user queue VMIDs, each walking its own VMID mask.

Program them in one place, walking the kernel queue and the user queue
VMIDs together and giving each the configuration of its users, as on
GFX12. The GDS, GWS and OA clearing of the user queue VMIDs in
gfx_v11_0_init_compute_vmid() goes away, gfx_v11_0_init_gds_vmid() clears
them for all VMIDs but 0 right after.

No functional change.

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 75 +++++++++++---------------
 1 file changed, 30 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 315dfd806d56..cdf543f1cd9a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -2151,46 +2151,51 @@ static void gfx_v11_0_setup_rb(struct amdgpu_device *adev)
 #define LDS_APP_BASE           0x1
 #define SCRATCH_APP_BASE       0x2
 
-static void gfx_v11_0_init_compute_vmid(struct amdgpu_device *adev)
+/*
+ * Program SH_MEM_CONFIG and SH_MEM_BASES of all VMIDs in one place: the user
+ * queue VMIDs get the application apertures and traps enabled, the kernel
+ * queue VMIDs, including the SPM VMID, the GPUVM apertures. VMID 0 only gets
+ * SH_MEM_CONFIG, its SH_MEM_BASES is left alone.
+ */
+static void gfx_v11_0_init_sh_mem(struct amdgpu_device *adev)
 {
+	unsigned long uq_mask = adev->vm_manager.vmid_uq_mask_gfxhub;
+	unsigned long mask = amdgpu_vmid_kq_mask(adev, AMDGPU_GFXHUB(0)) | uq_mask;
+	u32 kq_bases, uq_bases, data;
 	int i;
-	uint32_t sh_mem_bases;
-	uint32_t data;
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
-	sh_mem_bases = (LDS_APP_BASE << SH_MEM_BASES__SHARED_BASE__SHIFT) |
-			SCRATCH_APP_BASE;
+	uq_bases = (LDS_APP_BASE << SH_MEM_BASES__SHARED_BASE__SHIFT) |
+		   SCRATCH_APP_BASE;
 
 	mutex_lock(&adev->srbm_mutex);
-	for_each_uq_gfx_vmid(i, adev) {
+	for_each_set_bit(i, &mask, AMDGPU_NUM_VMID) {
 		soc21_grbm_select(adev, 0, 0, 0, i);
 		/* CP and shaders */
 		WREG32_SOC15(GC, 0, regSH_MEM_CONFIG, DEFAULT_SH_MEM_CONFIG);
-		WREG32_SOC15(GC, 0, regSH_MEM_BASES, sh_mem_bases);
-
-		/* Enable trap for each kfd vmid. */
-		data = RREG32_SOC15(GC, 0, regSPI_GDBG_PER_VMID_CNTL);
-		data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, TRAP_EN, 1);
-		WREG32_SOC15(GC, 0, regSPI_GDBG_PER_VMID_CNTL, data);
+		if (uq_mask & BIT(i)) {
+			WREG32_SOC15(GC, 0, regSH_MEM_BASES, uq_bases);
+
+			/* Enable trap for each kfd vmid. */
+			data = RREG32_SOC15(GC, 0, regSPI_GDBG_PER_VMID_CNTL);
+			data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, TRAP_EN, 1);
+			WREG32_SOC15(GC, 0, regSPI_GDBG_PER_VMID_CNTL, data);
+		} else if (i) {
+			WREG32_SOC15(GC, 0, regSH_MEM_BASES, kq_bases);
+		}
 	}
 	soc21_grbm_select(adev, 0, 0, 0, 0);
 	mutex_unlock(&adev->srbm_mutex);
-
-	/*
-	 * Initialize all compute VMIDs to have no GDS, GWS, or OA
-	 * access. These should be enabled by FW for target VMIDs.
-	 */
-	for_each_uq_gfx_vmid(i, adev) {
-		WREG32_SOC15_OFFSET(GC, 0, regGDS_VMID0_BASE, 2 * i, 0);
-		WREG32_SOC15_OFFSET(GC, 0, regGDS_VMID0_SIZE, 2 * i, 0);
-		WREG32_SOC15_OFFSET(GC, 0, regGDS_GWS_VMID0, i, 0);
-		WREG32_SOC15_OFFSET(GC, 0, regGDS_OA_VMID0, i, 0);
-	}
 }
 
 static void gfx_v11_0_init_gds_vmid(struct amdgpu_device *adev)
@@ -2230,7 +2235,6 @@ static void gfx_v11_0_get_tcc_info(struct amdgpu_device *adev)
 static void gfx_v11_0_constants_init(struct amdgpu_device *adev)
 {
 	u32 tmp;
-	int i;
 
 	if (!amdgpu_sriov_vf(adev))
 		WREG32_FIELD15_PREREG(GC, 0, GRBM_CNTL, READ_TIMEOUT, 0xff);
@@ -2254,26 +2258,7 @@ static void gfx_v11_0_constants_init(struct amdgpu_device *adev)
 	WREG32_FIELD15_PREREG(GC, 0, DB_RING_CONTROL, COUNTER_CONTROL,
 			      (adev->gfx.me.num_pipe_per_me > 1) ? 0 : 1);
 
-	/* XXX SH_MEM regs */
-	/* where to put LDS, scratch, GPUVM in FSA64 space */
-	mutex_lock(&adev->srbm_mutex);
-	for_each_vmid_and_zero(i, adev, AMDGPU_GFXHUB(0)) {
-		soc21_grbm_select(adev, 0, 0, 0, i);
-		/* CP and shaders */
-		WREG32_SOC15(GC, 0, regSH_MEM_CONFIG, DEFAULT_SH_MEM_CONFIG);
-		if (i != 0) {
-			tmp = REG_SET_FIELD(0, SH_MEM_BASES, PRIVATE_BASE,
-				(adev->gmc.private_aperture_start >> 48));
-			tmp = REG_SET_FIELD(tmp, SH_MEM_BASES, SHARED_BASE,
-				(adev->gmc.shared_aperture_start >> 48));
-			WREG32_SOC15(GC, 0, regSH_MEM_BASES, tmp);
-		}
-	}
-	soc21_grbm_select(adev, 0, 0, 0, 0);
-
-	mutex_unlock(&adev->srbm_mutex);
-
-	gfx_v11_0_init_compute_vmid(adev);
+	gfx_v11_0_init_sh_mem(adev);
 	gfx_v11_0_init_gds_vmid(adev);
 }
 
-- 
2.50.1

