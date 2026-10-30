Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FEC606A31A
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2026 07:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Xur90uvr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBD2E11266F;
	Fri, 30 Oct 2026 07:23:14 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012007.outbound.protection.outlook.com [52.101.48.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18D3811266F
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2026 07:23:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XNE0i3UsThrJgmVGb6KWo3wEhttvUHq7Myn7TREuaWzrX8ShZwhHwM7vZ3HdV/Jbjcfe6etTjbtdZNo52C7Ry/C2QiZHNgorPcb2fCucSevyDjkm6SzaJkDGARCK23dTsXkZMnemZPPH5lrZ6SR5izMkt+4UaECGfhDzaX12RoLkTBpx8XULOOm3zWBFEzsJPSey99f2swXp62ePhd1IhzmiZjjMywejwhSTwN6cN5grHpwvoZwVb5c5JRbymwlA7VPFHhBhcP5B3OvDt0Jf+/08sN6C1/S24IFSKwDOk27sWMSGFZIc2rg9eT2uFIR5NDwzOJ4MMXbPf/Z1kgEGgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uR2nUk71ei6AKEC8gp4ICD+mnkmo51kq2/8XAbIdwKw=;
 b=AW/25wdnnqkZ0ynKYPzSNG8RO+WIgcKtWRo5MtIi45GP4go+a/O0tY03+F2hbEV/ImrGR/Huq+EmnLzmweLFn4WlqPuakpAXqyi/HLkXYWx4mhsxv132/SyDpPt0r0UsBawSlFLaSA74neaXoIVvTbT0MRahtsg18ZEXBKRtrMUswvHRqJLrNOU+2TZcKZzVYttB0yHSucG2WGedZq/64WC9jzXLfEmhgDJwJVTK3TpxIpXDyCl4CmyPK9AoYjA1rLcq7JiYnCTqFgaZqi4p7nrW6jwBrdxI+EiRYcC+54x4QODg2YrCGTRW1KVk5FN9XDTqBGy7f3Bupi5xzNv39Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uR2nUk71ei6AKEC8gp4ICD+mnkmo51kq2/8XAbIdwKw=;
 b=Xur90uvrV6lS/YqD1w80bTXNq82UWTB/cAcc/6imId5fG5Da4FA1xbyZtmFcBvqJgvJRt6ZNSFwup53B37A1ntv8r7FlsxjMXAvsZVkyY9jozh4KuuLcmtq5T4ZWtGNhY+BQOpyN1H3925aGGvnpN/U+6C7uVbfjm00PLV7cJ2E=
Received: from PH8P222CA0015.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:2d7::19)
 by SA3PR12MB991115.namprd12.prod.outlook.com (2603:10b6:806:515::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Fri, 30 Oct
 2026 07:23:02 +0000
Received: from CY6PEPF00000048.namprd03.prod.outlook.com
 (2603:10b6:510:2d7:cafe::12) by PH8P222CA0015.outlook.office365.com
 (2603:10b6:510:2d7::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Fri,
 30 Oct 2026 07:23:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY6PEPF00000048.mail.protection.outlook.com (10.167.247.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Fri, 30 Oct 2026 07:23:01 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 30 Oct
 2026 02:23:01 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Fri, 30 Oct 2026 02:22:54 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <lijo.lazar@amd.com>, Prike Liang <prike.liang@amd.com>, Sunil Khatri
 <sunil.khatri@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 5/6] drm/amdgpu/gfx9: consolidate SH_MEM initialization
Date: Fri, 30 Oct 2026 15:20:27 +0800
Message-ID: <20261030072229.598249-5-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261030072229.598249-1-Jesse.Zhang@amd.com>
References: <20261030072229.598249-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY6PEPF00000048:EE_|SA3PR12MB991115:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a8be7b8-f89b-4f9e-20b3-08df3656a1a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|23010399003|376014|36860700016|11063799006|56012099006|261021121427099003|261021123027099003|261009223027099003|261022075727099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: upvjAjSf6E8ybc5K5Q5cnaG+Fdtnw/X4v8qzVdPg1SRvLZE+CnYb0g4khGYlVe4tk7tUfNnNOvwuycZPT0xOKtL0j8WQuGC43emoC5F7VzQrR+YrSTyBwk4IqYNVLAXPfHU8NBz53oLjHpExzxOb4iWmcaiPHoqdMG7HJhV3jXQon2xRbke2D9Lb1z4V/UnWmt56tNQEgQrV3/wsMK/GV4XnTkh2Lp/dRp5uAhR8OFJeeghSeWp/ZfkguDlZB7Y7M05zJMfFR9Pgqbb8yHsdwK5z3Kl9OcbU0kPpNPbU8emzaYLRyu2zfUZyGy1NK3pfj+/pwd7QHnHeY92zfiGiUwEG/O8VYKhabqVKQ9uDiCX5gbKy+uu84QdnTfq61czKDxG9u3cTjsjoLrc+CIBrXn7GmWuCL9D1JwPlcIvI+S4dYLzzgREI8xfg49dRuNKhh3TYDsB2mzgTImxlKJrJTmagsRRhyoG4s9rqnF0OgT9sLdEr2BJ/pOR69X1M6TGUv/uikksxNCJGkiuvHx47NF7tUx1cp08OUEYUDfeXU7cQdPfKc9ua4f5ZDIwBxSCWONwrVgKWRUNLGEyyzebS5tfaGcG+IgNtzV9Qmb+RNK41pNEZ5EYhc4yfvDLi5fEy+qkVHTmp2dZU7WOCPaRWiJJ4qin5rA5PsGt2lDU0DP5YRxRjWjhblhd4qKiJxS2tBWybgrX98F/jBoD46pB6Ww==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(23010399003)(376014)(36860700016)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261009223027099003)(261022075727099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Gwk2s/IWT/ry+lHMwjutKdxrdGR60VS1LNaMzq4Pt3S3Pp+8kVZJXuygKPq5clsEaLaVu8jfoOEQyuUxI6PxR7lIIqX7nSEnF+kpY8TreV6iBnQvStNE7cDhgjVRzyCcMy1YzlN1tbtT2W1QPCI6n+dqad095TbBigvgzwUxzXJxwzvtvseXYRUTFZvyYETY640zbbj2K0O/7hQ9cH6ClA2TMXwqxtwFq5YcrJO/lpnqM5Lr7iE7lxhivP6JeT+Fr/BiOzXgqjzhHSm/v0eCN7q+mR5nQFfy51Eos6SwA+kEB6VR0Ic1/G7ioK3DPJkYhUGCHUKniiRtb8TUFgu1+YS/kL9Heu9LWT8ns55asHvO11FjeABeVGxfCtbRDiO9NrLiJtx34vdirw2K7IIrJfFJjjsYirc+tuRjouBfvYolYTtFwvW4vZNs8Tbi9AaZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 07:23:01.6319 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a8be7b8-f89b-4f9e-20b3-08df3656a1a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY6PEPF00000048.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB991115
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

gfx_v9_0_constants_init() programs SH_MEM_CONFIG and SH_MEM_BASES of
VMID 0 and the kernel queue VMIDs, and gfx_v9_0_init_compute_vmid() those
of the user queue VMIDs, each walking its own VMID mask.

Program them in one place, walking the kernel queue and the user queue
VMIDs together and giving each the configuration of its users: the
kernel queue VMIDs keep the retry mode of the GMC and the GPUVM
apertures, VMID 0 null bases, and the user queue VMIDs the 64-bit address
mode and the application apertures. The GDS, GWS and OA clearing of the
user queue VMIDs in gfx_v9_0_init_compute_vmid() goes away,
gfx_v9_0_init_gds_vmid() clears them for all VMIDs but 0 right after.

No functional change.

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 89 ++++++++++-----------------
 1 file changed, 34 insertions(+), 55 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 75d1bbdb421f..c02777f9137e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2584,42 +2584,54 @@ static void gfx_v9_0_debug_trap_config_init(struct amdgpu_device *adev,
 }
 
 #define DEFAULT_SH_MEM_BASES	(0x6000)
-static void gfx_v9_0_init_compute_vmid(struct amdgpu_device *adev)
+/*
+ * Program SH_MEM_CONFIG and SH_MEM_BASES of all VMIDs in one place: the user
+ * queue VMIDs get the 64-bit address mode and the application apertures,
+ * VMID 0 and the kernel queue VMIDs, including the SPM VMID, the retry mode
+ * of the GMC, the kernel queue VMIDs the GPUVM apertures and VMID 0 null
+ * bases.
+ */
+static void gfx_v9_0_init_sh_mem(struct amdgpu_device *adev)
 {
+	unsigned long uq_mask = adev->vm_manager.vmid_uq_mask_gfxhub;
+	unsigned long mask = amdgpu_vmid_kq_mask(adev, AMDGPU_GFXHUB(0)) | uq_mask;
+	u32 kq_config, kq_bases, uq_config, uq_bases;
 	int i;
-	uint32_t sh_mem_config;
-	uint32_t sh_mem_bases;
+
+	kq_config = REG_SET_FIELD(0, SH_MEM_CONFIG, ALIGNMENT_MODE,
+				  SH_MEM_ALIGNMENT_MODE_UNALIGNED);
+	kq_config = REG_SET_FIELD(kq_config, SH_MEM_CONFIG, RETRY_DISABLE,
+				  !!adev->gmc.noretry);
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
-
-	sh_mem_config = SH_MEM_ADDRESS_MODE_64 |
-			SH_MEM_ALIGNMENT_MODE_UNALIGNED <<
-			SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT;
+	uq_bases = DEFAULT_SH_MEM_BASES | (DEFAULT_SH_MEM_BASES << 16);
+	uq_config = SH_MEM_ADDRESS_MODE_64 |
+		    SH_MEM_ALIGNMENT_MODE_UNALIGNED <<
+		    SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT;
 
 	mutex_lock(&adev->srbm_mutex);
-	for_each_uq_gfx_vmid(i, adev) {
+	for_each_set_bit(i, &mask, AMDGPU_NUM_VMID) {
 		soc15_grbm_select(adev, 0, 0, 0, i, 0);
 		/* CP and shaders */
-		WREG32_SOC15_RLC(GC, 0, mmSH_MEM_CONFIG, sh_mem_config);
-		WREG32_SOC15_RLC(GC, 0, mmSH_MEM_BASES, sh_mem_bases);
+		if (uq_mask & BIT(i)) {
+			WREG32_SOC15_RLC(GC, 0, mmSH_MEM_CONFIG, uq_config);
+			WREG32_SOC15_RLC(GC, 0, mmSH_MEM_BASES, uq_bases);
+		} else {
+			WREG32_SOC15_RLC(GC, 0, mmSH_MEM_CONFIG, kq_config);
+			WREG32_SOC15_RLC(GC, 0, mmSH_MEM_BASES, i ? kq_bases : 0);
+		}
 	}
 	soc15_grbm_select(adev, 0, 0, 0, 0, 0);
 	mutex_unlock(&adev->srbm_mutex);
-
-	/* Initialize all compute VMIDs to have no GDS, GWS, or OA
-	   access. These should be enabled by FW for target VMIDs. */
-	for_each_uq_gfx_vmid(i, adev) {
-		WREG32_SOC15_OFFSET(GC, 0, mmGDS_VMID0_BASE, 2 * i, 0);
-		WREG32_SOC15_OFFSET(GC, 0, mmGDS_VMID0_SIZE, 2 * i, 0);
-		WREG32_SOC15_OFFSET(GC, 0, mmGDS_GWS_VMID0, i, 0);
-		WREG32_SOC15_OFFSET(GC, 0, mmGDS_OA_VMID0, i, 0);
-	}
 }
 
 static void gfx_v9_0_init_gds_vmid(struct amdgpu_device *adev)
@@ -2661,9 +2673,6 @@ static void gfx_v9_0_init_sq_config(struct amdgpu_device *adev)
 
 static void gfx_v9_0_constants_init(struct amdgpu_device *adev)
 {
-	u32 tmp;
-	int i;
-
 	if (!amdgpu_sriov_vf(adev) ||
 	    amdgpu_ip_version(adev, GC_HWIP, 0) != IP_VERSION(9, 4, 2)) {
 		WREG32_FIELD15_RLC(GC, 0, GRBM_CNTL, READ_TIMEOUT, 0xff);
@@ -2676,37 +2685,7 @@ static void gfx_v9_0_constants_init(struct amdgpu_device *adev)
 	gfx_v9_0_get_cu_info(adev, &adev->gfx.cu_info);
 	adev->gfx.config.db_debug2 = RREG32_SOC15(GC, 0, mmDB_DEBUG2);
 
-	/* XXX SH_MEM regs */
-	/* where to put LDS, scratch, GPUVM in FSA64 space */
-	mutex_lock(&adev->srbm_mutex);
-	for_each_vmid_and_zero(i, adev, AMDGPU_GFXHUB(0)) {
-		soc15_grbm_select(adev, 0, 0, 0, i, 0);
-		/* CP and shaders */
-		if (i == 0) {
-			tmp = REG_SET_FIELD(0, SH_MEM_CONFIG, ALIGNMENT_MODE,
-					    SH_MEM_ALIGNMENT_MODE_UNALIGNED);
-			tmp = REG_SET_FIELD(tmp, SH_MEM_CONFIG, RETRY_DISABLE,
-					    !!adev->gmc.noretry);
-			WREG32_SOC15_RLC(GC, 0, mmSH_MEM_CONFIG, tmp);
-			WREG32_SOC15_RLC(GC, 0, mmSH_MEM_BASES, 0);
-		} else {
-			tmp = REG_SET_FIELD(0, SH_MEM_CONFIG, ALIGNMENT_MODE,
-					    SH_MEM_ALIGNMENT_MODE_UNALIGNED);
-			tmp = REG_SET_FIELD(tmp, SH_MEM_CONFIG, RETRY_DISABLE,
-					    !!adev->gmc.noretry);
-			WREG32_SOC15_RLC(GC, 0, mmSH_MEM_CONFIG, tmp);
-			tmp = REG_SET_FIELD(0, SH_MEM_BASES, PRIVATE_BASE,
-				(adev->gmc.private_aperture_start >> 48));
-			tmp = REG_SET_FIELD(tmp, SH_MEM_BASES, SHARED_BASE,
-				(adev->gmc.shared_aperture_start >> 48));
-			WREG32_SOC15_RLC(GC, 0, mmSH_MEM_BASES, tmp);
-		}
-	}
-	soc15_grbm_select(adev, 0, 0, 0, 0, 0);
-
-	mutex_unlock(&adev->srbm_mutex);
-
-	gfx_v9_0_init_compute_vmid(adev);
+	gfx_v9_0_init_sh_mem(adev);
 	gfx_v9_0_init_gds_vmid(adev);
 	gfx_v9_0_init_sq_config(adev);
 }
-- 
2.50.1

