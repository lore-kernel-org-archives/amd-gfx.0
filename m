Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F23606A31A
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2026 07:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=O3rTjr1W
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76D5D11266C;
	Fri, 30 Oct 2026 07:22:53 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011040.outbound.protection.outlook.com
 [40.93.194.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1576C11266C
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2026 07:22:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eWr9UdZPStQz5lBrQdt8xXfTAPRaSpLUHpcPAJnBR4EyH9GQE9XMjvPsVWKYrJC1BqTyacm+uCfPcz6SLKo5PMnCQRKjKRdAJinqR8D2mi20EigL2MQD6+6dTaUbVMNtpSSb6fDrV3Y9ZscRIPZ3Ij3I5Sc0H+uS/HFm/pvgnIrvMVC12OHAaiBGmn/LI/PlI8QjG1mYBbZQswPjEn+XE8x+WhEn0nr/z5o/5pFmdjQ5LVML1oYyCElo2s++NcC4/273csVrEyQdsH0juB1OmY7N5wc/mLXAJ04GuY9FVH24d3wb8w6s487VC1TH2wmzPCRInYM6uXbp7G24D3DD7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YEkl29Jueqf+2asZWFoWlz3QMAvnrS5sSXHhDAfq67g=;
 b=ELYkWpLH9pxYFZdmLykbK+/zeGkEhyJSvZNIBGAX1kNBLrIm4O1ea4kK0vd3+tT5ID2LGIyhvhAW3KGV9E39oXS3NCEnsoABNCYNEz0IwuuUUqCikogea3i7v0TJrDtDmyj8TR00n7QPUI16CcH3R290JAzDWUx/emRVxpRf5NTM/Bd2PeZ2bBxov+ZRNb+q6agKbgsD44VzmkI+RcOyi0UZOnX2wZMzsYJZAaOu6++sMVfCGF4G+TFktdQT4nkNyvPKhGLGCr3b3yos6IG/GjLWH4B3sXCwmRYSqPVewgrKuRF245yz8IeAV8PhU4a9n6KpOm6z7Dox9j56/tnxlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YEkl29Jueqf+2asZWFoWlz3QMAvnrS5sSXHhDAfq67g=;
 b=O3rTjr1WZ7AugG06LrOph06B0R9GtzAPeBavhFezcaGWcmXGN4XcTFVaS5y1ujVYoGOMKnEwjpiwUFjRj8ISXxU5OVep5IKF3U29SC13IrSbM2fu7cXiYKrHO2Gyx0WHNCTw6QfCokTIxwCeNjCzIACBIv4zLfQvAHzDPMNSYLI=
Received: from DS7PR03CA0043.namprd03.prod.outlook.com (2603:10b6:5:3b5::18)
 by CY1PR12MB9697.namprd12.prod.outlook.com (2603:10b6:930:107::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 07:22:42 +0000
Received: from BN2PEPF00004FC0.namprd04.prod.outlook.com
 (2603:10b6:5:3b5:cafe::53) by DS7PR03CA0043.outlook.office365.com
 (2603:10b6:5:3b5::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.9 via Frontend Transport; Fri, 30
 Oct 2026 07:22:42 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF00004FC0.mail.protection.outlook.com (10.167.243.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Fri, 30 Oct 2026 07:22:42 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 30 Oct
 2026 02:22:39 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 30 Oct
 2026 02:22:38 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Fri, 30 Oct 2026 02:22:32 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <lijo.lazar@amd.com>, Prike Liang <prike.liang@amd.com>, Sunil Khatri
 <sunil.khatri@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 2/6] drm/amdgpu/gfx12: consolidate SH_MEM initialization
Date: Fri, 30 Oct 2026 15:20:24 +0800
Message-ID: <20261030072229.598249-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261030072229.598249-1-Jesse.Zhang@amd.com>
References: <20261030072229.598249-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC0:EE_|CY1PR12MB9697:EE_
X-MS-Office365-Filtering-Correlation-Id: 1122828d-224a-42a0-f06d-08df36569600
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|6133799003|18002099003|22082099003|56012099006|11063799006|10067099003|261021123027099003|261021121427099003|261022075727099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: VqZ2/My+LmlR+cm44GgFrwpNgbuyirm23XSDV6qSZRIdSzrS7B2ROx6oJ+fx0ixBXJeuHjZUEux7lhRRzJtokXZ27ib9vmJoQ8pzhC0zXNqKIR5qrtN4ZC6dmQWs5U8/DBgn+LhrYuDAHbPZnM0QrfgKB1B9juIl3Hqpk2QvSOqMQ29mX6F+s8HTJsJqs/zw9DpUZKMr08YjWHLpl/2jIp1BRaoO4+Lw6aGA/ljAt2z0BKoBwbCpB0mrOcMfKcVhnX3sN4MccPfMT1p4cH/hBsSm0Ln4xD1EhLyiftMCElGY6u/Z2Rt5LYo8Bn26aAIRI5GNAfhPVQDcoXgvC4VSQ5KpUrjr54mwhrOvdYKZtaLlJCS3SKpEop3JsLNzzxIQlFXfb/OpzPyfz0+S0a1pn8NTNEeyXqBmcB8SYoVmTm3aal0CYCI/x9yxLynHTvCjdywJH7vF1wAqPjNKbqfqGyoHok5Lg1Q4A0KXlDIcagWemKq2K5UCDuX0fq6qGrs5No/BlZX5GGPSBFinDHbYXHg4X1zG+fKYg/woUGMSlHL0iBbJjl4j+BI0iqrMECglxL0KF+W/Q0YiJ6EJNB8jkOKZp9lAcp7h/0m1fUIsCuDGOJD3K/N0o7DnoVLN+h28GhNuFNwIabQWE1m5EqBV1GQO7+n7OVU3wtx4xTurpVyOARCCcpOZIXCldFAqnYrVzOxI0KPOaVauL+9PeJe4zw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003)(261021123027099003)(261021121427099003)(261022075727099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JWYGl5CZBVLv4v/vHYlII/1wr04diFqD6C7rX7+IbIKs2R2hLuvg7uqEltrL0Lgv2sF5vF0eTUa3/kvOHHfhnYUw4QAR0meUwU1nvXQc82v5EPzWg3TnsUzH5cVYNHs0dE5PASo74BGHGIaNpK90ZpweHmEVukCWOGXuqWFbkMERvzKJn8zIWJIbzL6I5rHo5RzV3HYLiC7YlF0XJoERs5QZuNh7Qmypsh0z4RI4GfO+VZOsEMm8AJ2LzoGQLGMHOAwLJRz74qu19rK4E3YjkdB8GurrVh9rktpDRYSKc71qPKfTHxTvI+sOrF1TS47Pue7P8XwM+BAUfpV7eKzKoJxnHaJH1rRXQchDosuQBPM+2br5I7/pv9miDx0z/b+EU+5i03gmvrmXKInZay2ksCnyzB9LhKeDkxGEA7dX94+yE4NSI7zmYlp90Etqz9dn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 07:22:42.1180 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1122828d-224a-42a0-f06d-08df36569600
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9697
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

gfx_v12_0_constants_init() programs SH_MEM_CONFIG and SH_MEM_BASES of
VMID 0 and the kernel queue VMIDs, and gfx_v12_0_init_compute_vmid() those
of the user queue VMIDs, each walking its own VMID mask.

Program them in one place, walking the kernel queue and the user queue
VMIDs together and giving each the configuration of its users. The
kernel queue VMIDs come from amdgpu_vmid_kq_mask(), like those
for_each_vmid_and_zero() walks, so the SPM VMID stays with them.

No functional change.

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 64 ++++++++++++--------------
 1 file changed, 30 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index d334fb805020..336eee54d63a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -1792,32 +1792,48 @@ static void gfx_v12_0_setup_rb(struct amdgpu_device *adev)
 #define LDS_APP_BASE           0x1
 #define SCRATCH_APP_BASE       0x2
 
-static void gfx_v12_0_init_compute_vmid(struct amdgpu_device *adev)
+/*
+ * Program SH_MEM_CONFIG and SH_MEM_BASES of all VMIDs in one place: the user
+ * queue VMIDs get the application apertures and traps enabled, the kernel
+ * queue VMIDs, including the SPM VMID, the GPUVM apertures. VMID 0 only gets
+ * SH_MEM_CONFIG, its SH_MEM_BASES is left alone.
+ */
+static void gfx_v12_0_init_sh_mem(struct amdgpu_device *adev)
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
 		soc24_grbm_select(adev, 0, 0, 0, i);
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
 	soc24_grbm_select(adev, 0, 0, 0, 0);
 	mutex_unlock(&adev->srbm_mutex);
@@ -1835,7 +1851,6 @@ static void gfx_v12_0_get_tcc_info(struct amdgpu_device *adev)
 static void gfx_v12_0_constants_init(struct amdgpu_device *adev)
 {
 	u32 tmp;
-	int i;
 
 	if (!amdgpu_sriov_vf(adev))
 		WREG32_FIELD15_PREREG(GC, 0, GRBM_CNTL, READ_TIMEOUT, 0xff);
@@ -1860,26 +1875,7 @@ static void gfx_v12_0_constants_init(struct amdgpu_device *adev)
 	WREG32_FIELD15_PREREG(GC, 0, DB_RING_CONTROL, COUNTER_CONTROL,
 			      (adev->gfx.me.num_pipe_per_me > 1) ? 0 : 1);
 
-	/* XXX SH_MEM regs */
-	/* where to put LDS, scratch, GPUVM in FSA64 space */
-	mutex_lock(&adev->srbm_mutex);
-	for_each_vmid_and_zero(i, adev, AMDGPU_GFXHUB(0)) {
-		soc24_grbm_select(adev, 0, 0, 0, i);
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
-	soc24_grbm_select(adev, 0, 0, 0, 0);
-
-	mutex_unlock(&adev->srbm_mutex);
-
-	gfx_v12_0_init_compute_vmid(adev);
+	gfx_v12_0_init_sh_mem(adev);
 }
 
 static u32 gfx_v12_0_get_cpg_int_cntl(struct amdgpu_device *adev,
-- 
2.50.1

