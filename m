Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5088F606A31A
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2026 07:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=k7FTC1zD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E50AC112672;
	Fri, 30 Oct 2026 07:25:24 +0000 (UTC)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012050.outbound.protection.outlook.com
 [40.107.200.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9C61112672
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2026 07:25:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xez2YT9Q/7PlBIM0708EcrGOzZYaU1H9iL015zHjpWoihq6hRxC+CXryjSVGch2nlpjsrl7lTWMV/OTEqRFXjOOC9vTfPUAYTN9HpPXR/6Z4XaJm165cuDG0bfMyPBc3k1d8oTGtqOkpBc408nqMByeg6566krEjcn0uILZvkEZovKa/caztJpYi+/+9RvxbefPpdIKObDctGIeFHaYnjWc2o5Z8rWqgbFqa5eyxpYlqgdTfSIkLKdYwODCtXFsIyPTqZmOwe7uw/5oxOnaEtQ8ehVwYSDmwiHbqbR7ixC/WUUD9mHLx08bUAJJn4UWGIiW6XZkKOPmIi45x8Q3Ihw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dNlAxQ0K/ungzKefr4LP2SBmlQP/anrZgFKV1Dnukyw=;
 b=odRFMK3IMbA64/3aQEZtoLAMaZbXl3mlJyEhnnm3OFavtYxkmg06RGO+hMWiy2zZNDyW40dM8/qR10/qv7xmK61rLnxpwon8+TEDKhyxjbyb3cXtbFyl+XwTd5Ru/H6wEd6WXpppynTE23UxueSa+j5XozhY/qnAtGlUkhr8ELtp0gIbVkQeWIuf0oZEu4ZdAKN1K3xHK7IYbc/zMT62h9nBKR6EpvvOrOyBXwNdhlfxE6XiV6jTtqzcZ78obPQfSFMA7bFwzoG3RE1qcD6pA+ej/9RB60vhScI2qveVQGvi2w2Xl/LLKKf5Qt7CsphPsBzXplQsbLpDWZT/uu2ung==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dNlAxQ0K/ungzKefr4LP2SBmlQP/anrZgFKV1Dnukyw=;
 b=k7FTC1zD5OOZ3/liTbOmi7u1uQrsBNVPP9dKRZ+gzpuh+QbVBp0sPQ3G6SrSo3Qy1zko7mq8xFxL0hiLdOdfsCqI0TGw6/jBmCDkZeq+48eqJs9eyE6QihhAT4yiX3nAFTKzBDH3LC43PyUJzwAAGCo3JCrHqOW0GfufypCDFXE=
Received: from CYXPR03CA0065.namprd03.prod.outlook.com (2603:10b6:930:d1::7)
 by MN2PR12MB4078.namprd12.prod.outlook.com (2603:10b6:208:1de::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 07:23:12 +0000
Received: from CY6PEPF0000004C.namprd03.prod.outlook.com
 (2603:10b6:930:d1:cafe::48) by CYXPR03CA0065.outlook.office365.com
 (2603:10b6:930:d1::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.9 via Frontend Transport; Fri, 30
 Oct 2026 07:23:12 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY6PEPF0000004C.mail.protection.outlook.com (10.167.247.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Fri, 30 Oct 2026 07:23:11 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 30 Oct
 2026 02:23:08 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 30 Oct
 2026 02:23:08 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Fri, 30 Oct 2026 02:23:01 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <lijo.lazar@amd.com>, Prike Liang <prike.liang@amd.com>, Sunil Khatri
 <sunil.khatri@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 6/6] drm/amdgpu/gfx8: consolidate SH_MEM initialization
Date: Fri, 30 Oct 2026 15:20:28 +0800
Message-ID: <20261030072229.598249-6-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261030072229.598249-1-Jesse.Zhang@amd.com>
References: <20261030072229.598249-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY6PEPF0000004C:EE_|MN2PR12MB4078:EE_
X-MS-Office365-Filtering-Correlation-Id: f63c55b9-0666-4c23-4d86-08df3656a7b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|23010399003|10067099003|11063799006|6133799003|261009223027099003|261022075727099003|261021121427099003|261021123027099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: lQLnpH1dJX1TNL/QFf6cqrXExLoVK/59wTiBt9yJ97lRDg068Yw4v+H0f/h4PZq7rApAmDENxqstyWU8rPEbkvyXwjBV0o7NdL8p1E7uojOEBCXzxsXYhwJRgBYxM3kWYpLCHpmLJTFPn5MX+1QXNuDJA6ZXnNqLDpIs+lY8sErnZJVXbZBVvNNdnU3Ks5BHZ3AQDE6+H8GPipjKiUtElXxbLjLKHGt0OsEYUWCrFV/n8Y7GZYkulvvRaXSrix9GeKcc9EcxGIIUsxS759wfRIwI8C5IEpW33hgYAA7sqFpzm3KplVbHWzxxW23Rkl9Cp42PrR0PrIY/s99Gea7LLxA9msXueUh7+KlVj9lWd+0ndvvmr18OW9qVJ2aoc5faiSU1r498VaG6PhPhAs3lwHEe6l65CE0GY16L20QRvnfafrYKh5QodfdsUoSQioKYQ38DooWyLG46sBUlhV9IWpjqZYPSRdbzSApRB3DIz6OKzOOHPi/5d7i3IsOEMDcTpoh/xt71wQT4YBGM7CIeFJq0ouADk4sfHExRKCXYZ2lJR2ClRPfCj0uL/3jsjZnC//HD2r8eAIcteyQG7AezBwFwx6NhGngEaypkuXsj8zt4cEXsXPFECDFqLgzZX0h7iHTNErHMn4B7Y1SK2i60FuxuL+KCo2ldgSDalu9Xg9T6Ve7Kwdz3Q9fSQYmz+w+coBybw9OjSHb1zSTGMsqEWw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(10067099003)(11063799006)(6133799003)(261009223027099003)(261022075727099003)(261021121427099003)(261021123027099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3wegUZWKELGANqN6fNX7XGxINN8fvudVRTWi8vII5ltESq+s/sqrzc39dbAfflFxl9N8QebbZbTLTLjBeZB5mFkEHMnM9+sp2QsREVVetEDjBuig0K7YTsDUakIax5LhFmaFBNlTsHRIf/vW6Voy65biedTJaHAtZshENeLRs4l3KqnQHAw1u/B1gKZ7I0eFOgRS2YK5/Iwgwq78iDPBXXjvTmtlTHgDputrAbapSzKYSXHUbTqq49VhwcDrhShLzZUROwvCrc0BGAYLa8LyxdvWC4L7NRaWk6tbmKyDw1cz7n+pI39mAgv+jz9LyRkEWH021Sj6UWG6YefEy8J6Q5iJ+KC7Pt074F92h4NSLhtgTvitBoV6mnj619+rmvMMIiAanrpNpjDO6zwPmJRCjDlSXcwHeoFzZ9Hcl/WoHQNuuxWZ1c6IaGJTcjg04PNw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 07:23:11.7909 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f63c55b9-0666-4c23-4d86-08df3656a7b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY6PEPF0000004C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4078
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

gfx_v8_0_constants_init() programs the SH_MEM registers of VMID 0 and the
kernel queue VMIDs, and gfx_v8_0_init_compute_vmid() those of the user
queue VMIDs, each walking its own VMID mask.

Program them in one place, walking the kernel queue and the user queue
VMIDs together and giving each the configuration of its users: VMID 0
uncached with null bases, the kernel queue VMIDs non-coherent with the
shared aperture, and the user queue VMIDs the HSA64 address mode, cache
coherency, ATC for the private aperture and the application apertures;
APE1 stays disabled for all of them. The GDS, GWS and OA clearing of the
user queue VMIDs in gfx_v8_0_init_compute_vmid() goes away,
gfx_v8_0_init_gds_vmid() clears them for all VMIDs but 0 right after.

No functional change.

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 96 ++++++++++++---------------
 1 file changed, 41 insertions(+), 55 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 7e2f9c13dec3..e634d9fbd4b0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -3644,54 +3644,68 @@ static void gfx_v8_0_setup_rb(struct amdgpu_device *adev)
 
 #define DEFAULT_SH_MEM_BASES	(0x6000)
 /**
- * gfx_v8_0_init_compute_vmid - gart enable
+ * gfx_v8_0_init_sh_mem - initialize the sh_mem registers of all VMIDs
  *
  * @adev: amdgpu_device pointer
  *
- * Initialize compute vmid sh_mem registers
- *
+ * Program the sh_mem registers of VMID 0, the kernel queue VMIDs, including
+ * the SPM VMID, and the user queue VMIDs in one place, each with the
+ * configuration of its users.
  */
-static void gfx_v8_0_init_compute_vmid(struct amdgpu_device *adev)
+static void gfx_v8_0_init_sh_mem(struct amdgpu_device *adev)
 {
+	unsigned long uq_mask = adev->vm_manager.vmid_uq_mask_gfxhub;
+	unsigned long mask = amdgpu_vmid_kq_mask(adev, AMDGPU_GFXHUB(0)) | uq_mask;
+	u32 vmid0_config, kq_config, uq_config, uq_bases;
 	int i;
-	uint32_t sh_mem_config;
-	uint32_t sh_mem_bases;
+
+	vmid0_config = REG_SET_FIELD(0, SH_MEM_CONFIG, DEFAULT_MTYPE, MTYPE_UC);
+	vmid0_config = REG_SET_FIELD(vmid0_config, SH_MEM_CONFIG, APE1_MTYPE,
+				     MTYPE_UC);
+	vmid0_config = REG_SET_FIELD(vmid0_config, SH_MEM_CONFIG, ALIGNMENT_MODE,
+				     SH_MEM_ALIGNMENT_MODE_UNALIGNED);
+
+	kq_config = REG_SET_FIELD(0, SH_MEM_CONFIG, DEFAULT_MTYPE, MTYPE_NC);
+	kq_config = REG_SET_FIELD(kq_config, SH_MEM_CONFIG, APE1_MTYPE, MTYPE_UC);
+	kq_config = REG_SET_FIELD(kq_config, SH_MEM_CONFIG, ALIGNMENT_MODE,
+				  SH_MEM_ALIGNMENT_MODE_UNALIGNED);
 
 	/*
-	 * Configure apertures:
+	 * Configure apertures of the user queue VMIDs:
 	 * LDS:         0x60000000'00000000 - 0x60000001'00000000 (4GB)
 	 * Scratch:     0x60000001'00000000 - 0x60000002'00000000 (4GB)
 	 * GPUVM:       0x60010000'00000000 - 0x60020000'00000000 (1TB)
 	 */
-	sh_mem_bases = DEFAULT_SH_MEM_BASES | (DEFAULT_SH_MEM_BASES << 16);
+	uq_bases = DEFAULT_SH_MEM_BASES | (DEFAULT_SH_MEM_BASES << 16);
 
-	sh_mem_config = SH_MEM_ADDRESS_MODE_HSA64 <<
-			SH_MEM_CONFIG__ADDRESS_MODE__SHIFT |
-			SH_MEM_ALIGNMENT_MODE_UNALIGNED <<
-			SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT |
-			MTYPE_CC << SH_MEM_CONFIG__DEFAULT_MTYPE__SHIFT |
-			SH_MEM_CONFIG__PRIVATE_ATC_MASK;
+	uq_config = SH_MEM_ADDRESS_MODE_HSA64 <<
+		    SH_MEM_CONFIG__ADDRESS_MODE__SHIFT |
+		    SH_MEM_ALIGNMENT_MODE_UNALIGNED <<
+		    SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT |
+		    MTYPE_CC << SH_MEM_CONFIG__DEFAULT_MTYPE__SHIFT |
+		    SH_MEM_CONFIG__PRIVATE_ATC_MASK;
 
 	mutex_lock(&adev->srbm_mutex);
-	for_each_uq_gfx_vmid(i, adev) {
+	for_each_set_bit(i, &mask, AMDGPU_NUM_VMID) {
 		vi_srbm_select(adev, 0, 0, 0, i);
 		/* CP and shaders */
-		WREG32(mmSH_MEM_CONFIG, sh_mem_config);
+		if (uq_mask & BIT(i)) {
+			WREG32(mmSH_MEM_CONFIG, uq_config);
+			WREG32(mmSH_MEM_BASES, uq_bases);
+		} else if (i) {
+			WREG32(mmSH_MEM_CONFIG, kq_config);
+			WREG32(mmSH_MEM_BASES,
+			       adev->gmc.shared_aperture_start >> 48);
+		} else {
+			WREG32(mmSH_MEM_CONFIG, vmid0_config);
+			WREG32(mmSH_MEM_BASES, 0);
+		}
+
 		WREG32(mmSH_MEM_APE1_BASE, 1);
 		WREG32(mmSH_MEM_APE1_LIMIT, 0);
-		WREG32(mmSH_MEM_BASES, sh_mem_bases);
 	}
 	vi_srbm_select(adev, 0, 0, 0, 0);
 	mutex_unlock(&adev->srbm_mutex);
-
-	/* Initialize all compute VMIDs to have no GDS, GWS, or OA
-	   access. These should be enabled by FW for target VMIDs. */
-	for_each_uq_gfx_vmid(i, adev) {
-		WREG32(amdgpu_gds_reg_offset[i].mem_base, 0);
-		WREG32(amdgpu_gds_reg_offset[i].mem_size, 0);
-		WREG32(amdgpu_gds_reg_offset[i].gws, 0);
-		WREG32(amdgpu_gds_reg_offset[i].oa, 0);
-	}
 }
 
 static void gfx_v8_0_init_gds_vmid(struct amdgpu_device *adev)
@@ -3728,7 +3742,6 @@ static void gfx_v8_0_config_init(struct amdgpu_device *adev)
 static void gfx_v8_0_constants_init(struct amdgpu_device *adev)
 {
 	u32 tmp, sh_static_mem_cfg;
-	int i;
 
 	WREG32_FIELD(GRBM_CNTL, READ_TIMEOUT, 0xFF);
 	WREG32(mmGB_ADDR_CONFIG, adev->gfx.config.gb_addr_config);
@@ -3750,34 +3763,7 @@ static void gfx_v8_0_constants_init(struct amdgpu_device *adev)
 				   INDEX_STRIDE, 3);
 	WREG32(mmSH_STATIC_MEM_CONFIG, sh_static_mem_cfg);
 
-	mutex_lock(&adev->srbm_mutex);
-	for_each_vmid_and_zero(i, adev, 0) {
-		vi_srbm_select(adev, 0, 0, 0, i);
-		/* CP and shaders */
-		if (i == 0) {
-			tmp = REG_SET_FIELD(0, SH_MEM_CONFIG, DEFAULT_MTYPE, MTYPE_UC);
-			tmp = REG_SET_FIELD(tmp, SH_MEM_CONFIG, APE1_MTYPE, MTYPE_UC);
-			tmp = REG_SET_FIELD(tmp, SH_MEM_CONFIG, ALIGNMENT_MODE,
-					    SH_MEM_ALIGNMENT_MODE_UNALIGNED);
-			WREG32(mmSH_MEM_CONFIG, tmp);
-			WREG32(mmSH_MEM_BASES, 0);
-		} else {
-			tmp = REG_SET_FIELD(0, SH_MEM_CONFIG, DEFAULT_MTYPE, MTYPE_NC);
-			tmp = REG_SET_FIELD(tmp, SH_MEM_CONFIG, APE1_MTYPE, MTYPE_UC);
-			tmp = REG_SET_FIELD(tmp, SH_MEM_CONFIG, ALIGNMENT_MODE,
-					    SH_MEM_ALIGNMENT_MODE_UNALIGNED);
-			WREG32(mmSH_MEM_CONFIG, tmp);
-			tmp = adev->gmc.shared_aperture_start >> 48;
-			WREG32(mmSH_MEM_BASES, tmp);
-		}
-
-		WREG32(mmSH_MEM_APE1_BASE, 1);
-		WREG32(mmSH_MEM_APE1_LIMIT, 0);
-	}
-	vi_srbm_select(adev, 0, 0, 0, 0);
-	mutex_unlock(&adev->srbm_mutex);
-
-	gfx_v8_0_init_compute_vmid(adev);
+	gfx_v8_0_init_sh_mem(adev);
 	gfx_v8_0_init_gds_vmid(adev);
 
 	mutex_lock(&adev->grbm_idx_mutex);
-- 
2.50.1

