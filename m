Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B09C4C4332F
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Nov 2022 17:28:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A996E10E4D2;
	Tue,  8 Nov 2022 17:28:57 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2971310E4D2
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Nov 2022 17:28:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LA8tbBWE00EbNDKX6Jddh7u37MZma4bW9AxMpyCVwZededsvM/oHpWx+4pnbK/Ngjeg4VtgZ+egx3lapvj3bq4FP/G65twmMkaMLp5IeJ0Sr/F57If/le9h6lNNT1lqh3y5zx2rAlLEe3TnrAVQNLFaSn8BcxKXkRHoeLR4KWqL09lqZ3WCT3IYdR3xIASVSzboouwHdr3IHpxZVlu5VN4uknW3UwKzCAyExE4g2U/WES5ombLzNu+QYtEdPGPbYwaEeJvsUbdu86JXOTxPpAgpwr4eaGAe5GKfruly9y9MQsd89KOKICXDMibGjJNlcUj4aUnANH+yGIJWOOv9Wqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8OymW97KpIVjl+jjuvd3UgGr/Pf+r3rlponqdS+R8Uo=;
 b=mUo+E4DkVNRAO38EVWMSRSkqdYNMQd4Zxmbk3SmOcvwMwrJlJAMobam9G46QEiHqqWacAi5LFUcED23SVZOVzRTgRkoHDwM9HJ/ioJLrhLV8mBlax0DZ2TlmRAtFqHGO5eqWguia/ylywNkbwlgN5Njk1KlwHtcnQsq+lPApIE9BUBjqMugAlmn08hcvt0ny4LMpjYDkN2x67jhFtucfUvXMujMjx2jRPdSjf4OdWExz0Fc96mpddkGa5WZVy7stRiYlivjhwNllQkR3RoKGgB9xpNm8+X5D85kQPwyd8SyRJzAqHwUM/VNVOAVs3zkiLzgZf/gbxEMnUJzTTbGqUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8OymW97KpIVjl+jjuvd3UgGr/Pf+r3rlponqdS+R8Uo=;
 b=35LrPLfE+H9yCqZs3j6Cyu1K9jR4BH8Tn2PYtCke4utamJn7YDB1o3qjRAmL6b1tp6EWBcPc2GbYzIVfVfDXZjzJKlfb5ujaNvJGIGiD2nkTlLIHkhOcy8P+tzQiuAyEP66RxHyRcl5lpvRr6ifm/uG2emiYEu8iQlzJkVYTAT8=
Received: from BN9P223CA0008.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::13)
 by IA1PR12MB8079.namprd12.prod.outlook.com (2603:10b6:208:3fb::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Tue, 8 Nov
 2022 17:28:52 +0000
Received: from BN8NAM11FT090.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::30) by BN9P223CA0008.outlook.office365.com
 (2603:10b6:408:10b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27 via Frontend
 Transport; Tue, 8 Nov 2022 17:28:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT090.mail.protection.outlook.com (10.13.177.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Tue, 8 Nov 2022 17:28:52 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 8 Nov
 2022 11:28:52 -0600
Received: from bokun-kvm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Tue, 8 Nov 2022 11:28:51 -0600
From: Bokun Zhang <bokun.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add vram reservation logic based on
 vram_usagebyfirmware_v2_2
Date: Tue, 8 Nov 2022 12:28:51 -0500
Message-ID: <20221108172851.48141-1-bokun.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT090:EE_|IA1PR12MB8079:EE_
X-MS-Office365-Filtering-Correlation-Id: 29c82229-dcd3-4819-bd33-08dac1aeb4c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oiQOWBWYltKxN95ZLucw6y6AECNH/OP8TEpWWJd7Y/s9Zhc4EVHaFJUX0YQ47npQOGR6x8nIYpP2LWyvgXAXF20hpZ/X9vFMDhWLq9jZSyCjS2G4+x5UViMJ6hVMf+ECvTIrc6xMFM2FtEIFAVsPUTv6KCsBAG66sbZHMP0EU3uvIJAZF+JBxSEhgGrcOicejtX/JkHbABtJOBfIrPKbfNcHxaxqIsjeA6dFefEfFW2IYIbSJZmAhbkCGuLpWyaWYKvdLVu/BxZ2Mmr8AoOHzfVbnLND+F4T4lyNdgOtOqU7TktYnLe07iet05RCW9kIp/vX9KqYX/rC3yexpDjmQ1Bf9DC3Kglc4S68fjEq5B210rWYgGubKVukk9YDBsyEh8bYvMnFjGC9RIWHCEdM6r21K+XP/YIbMIO7lukW1G0UxMt5a50bXFHy7T6Z3Q61wyhZe+Gzif8qV2Q6k14GY5VU94Y0rddSwML8J6K/scmRReSy4Ez2QXNgndY2lckUJR7ftlExvK5k+fTIfGJ65BSdNZ2KecTaQ2bTTzJ8I7to7LAUjsIQ5rXN5zflkf58343FMz5RgdNMSIRK+Xh8xbleMCCrFznUFwBpC7W8eKEctHrkZZGIeL65gPgtC+rTbvRS3lalkmEytTQ1tuKTWTYsIgk+ZCsRioAy8z8JCs2gijf85J8Bs6h5AKqbQkgCPJfTtQaRznSebvC/n3FzJ7/lXtTO1TeuW4FkhSzrRR5UAcbAyj2mjr4aT9tw7gu5C/IE8rJrYJHEO/H3xy0wHcrhXjkw7qTcR9RAuZ9+rJUYiCz0XStphiiX0QKTY2oM
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(346002)(136003)(376002)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(82740400003)(40480700001)(81166007)(36756003)(40460700003)(86362001)(54906003)(356005)(7696005)(4326008)(316002)(478600001)(41300700001)(44832011)(30864003)(2906002)(26005)(70586007)(70206006)(5660300002)(83380400001)(82310400005)(8676002)(6916009)(36860700001)(8936002)(186003)(1076003)(336012)(2616005)(426003)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 17:28:52.7009 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29c82229-dcd3-4819-bd33-08dac1aeb4c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT090.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8079
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: Bokun Zhang <bokun.zhang@amd.com>, Tong Liu01 <Tong.Liu01@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

- Move TMR region from top of FB to 2MB for FFBM, so we need to
  reserve TMR region firstly to make sure TMR can be allocated at 2MB

Signed-off-by: Tong Liu01 <Tong.Liu01@amd.com>
Signed-off-by: Bokun Zhang <bokun.zhang@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  | 106 ++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  50 +++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |   5 +
 drivers/gpu/drm/amd/include/atomfirmware.h    |  68 +++++++++--
 4 files changed, 198 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
index b81b77a9efa6..032dc2678d7c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -101,39 +101,99 @@ void amdgpu_atomfirmware_scratch_regs_init(struct amdgpu_device *adev)
 	}
 }
 
+static int amdgpu_atomfirmware_allocate_fb_v2_1(struct amdgpu_device *adev,
+		struct vram_usagebyfirmware_v2_1 *firmware_usage_v2_1,
+		int *usage_bytes)
+{
+	uint32_t start_addr, fw_size, drv_size;
+
+	start_addr = le32_to_cpu(firmware_usage_v2_1->start_address_in_kb);
+	fw_size = le16_to_cpu(firmware_usage_v2_1->used_by_firmware_in_kb);
+	drv_size = le16_to_cpu(firmware_usage_v2_1->used_by_driver_in_kb);
+
+	DRM_DEBUG("atom firmware v2_1 requested %08x %dkb fw %dkb drv\n",
+		start_addr,
+		fw_size,
+		drv_size);
+
+	if ((start_addr & ATOM_VRAM_OPERATION_FLAGS_MASK) ==
+		(uint32_t)(ATOM_VRAM_BLOCK_SRIOV_MSG_SHARE_RESERVATION <<
+		ATOM_VRAM_OPERATION_FLAGS_SHIFT)) {
+		/* Firmware request VRAM reservation for SR-IOV */
+		adev->mman.fw_vram_usage_start_offset = (start_addr &
+			(~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
+		adev->mman.fw_vram_usage_size = fw_size << 10;
+		/* Use the default scratch size */
+		*usage_bytes = 0;
+	} else {
+		*usage_bytes = drv_size << 10;
+	}
+	return 0;
+}
+
+static int amdgpu_atomfirmware_allocate_fb_v2_2(struct amdgpu_device *adev,
+		struct vram_usagebyfirmware_v2_2 *firmware_usage_v2_2,
+		int *usage_bytes)
+{
+	uint32_t fw_start_addr, fw_size, drv_start_addr, drv_size;
+
+	fw_start_addr = le32_to_cpu(firmware_usage_v2_2->fw_region_start_address_in_kb);
+	fw_size = le16_to_cpu(firmware_usage_v2_2->used_by_firmware_in_kb);
+
+	drv_start_addr = le32_to_cpu(firmware_usage_v2_2->driver_region0_start_address_in_kb);
+	drv_size = le32_to_cpu(firmware_usage_v2_2->used_by_driver_region0_in_kb);
+
+	DRM_DEBUG("atom requested fw start at %08x %dkb and drv start at %08x %dkb\n",
+		fw_start_addr,
+		fw_size,
+		drv_start_addr,
+		drv_size);
+
+	if ((fw_start_addr & (ATOM_VRAM_BLOCK_NEEDS_NO_RESERVATION << 30)) == 0) {
+		/* Firmware request VRAM reservation for SR-IOV */
+		adev->mman.fw_vram_usage_start_offset = (fw_start_addr &
+			(~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
+		adev->mman.fw_vram_usage_size = fw_size << 10;
+	}
+
+	if ((drv_start_addr & (ATOM_VRAM_BLOCK_NEEDS_NO_RESERVATION << 30)) == 0) {
+		/* driver request VRAM reservation for SR-IOV */
+		adev->mman.drv_vram_usage_start_offset = (drv_start_addr &
+			(~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
+		adev->mman.drv_vram_usage_size = drv_size << 10;
+	}
+
+	*usage_bytes = 0;
+	return 0;
+}
+
 int amdgpu_atomfirmware_allocate_fb_scratch(struct amdgpu_device *adev)
 {
 	struct atom_context *ctx = adev->mode_info.atom_context;
 	int index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
 						vram_usagebyfirmware);
-	struct vram_usagebyfirmware_v2_1 *firmware_usage;
-	uint32_t start_addr, size;
+	struct vram_usagebyfirmware_v2_1 *firmware_usage_v2_1;
+	struct vram_usagebyfirmware_v2_2 *firmware_usage_v2_2;
 	uint16_t data_offset;
+	uint8_t frev, crev;
 	int usage_bytes = 0;
 
-	if (amdgpu_atom_parse_data_header(ctx, index, NULL, NULL, NULL, &data_offset)) {
-		firmware_usage = (struct vram_usagebyfirmware_v2_1 *)(ctx->bios + data_offset);
-		DRM_DEBUG("atom firmware requested %08x %dkb fw %dkb drv\n",
-			  le32_to_cpu(firmware_usage->start_address_in_kb),
-			  le16_to_cpu(firmware_usage->used_by_firmware_in_kb),
-			  le16_to_cpu(firmware_usage->used_by_driver_in_kb));
-
-		start_addr = le32_to_cpu(firmware_usage->start_address_in_kb);
-		size = le16_to_cpu(firmware_usage->used_by_firmware_in_kb);
-
-		if ((uint32_t)(start_addr & ATOM_VRAM_OPERATION_FLAGS_MASK) ==
-			(uint32_t)(ATOM_VRAM_BLOCK_SRIOV_MSG_SHARE_RESERVATION <<
-			ATOM_VRAM_OPERATION_FLAGS_SHIFT)) {
-			/* Firmware request VRAM reservation for SR-IOV */
-			adev->mman.fw_vram_usage_start_offset = (start_addr &
-				(~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
-			adev->mman.fw_vram_usage_size = size << 10;
-			/* Use the default scratch size */
-			usage_bytes = 0;
-		} else {
-			usage_bytes = le16_to_cpu(firmware_usage->used_by_driver_in_kb) << 10;
+	if (amdgpu_atom_parse_data_header(ctx, index, NULL, &frev, &crev, &data_offset)) {
+		if (frev == 2 && crev == 1) {
+			firmware_usage_v2_1 =
+				(struct vram_usagebyfirmware_v2_1 *)(ctx->bios + data_offset);
+			amdgpu_atomfirmware_allocate_fb_v2_1(adev,
+					firmware_usage_v2_1,
+					&usage_bytes);
+		} else if (frev >= 2 && crev >= 2) {
+			firmware_usage_v2_2 =
+				(struct vram_usagebyfirmware_v2_2 *)(ctx->bios + data_offset);
+			amdgpu_atomfirmware_allocate_fb_v2_2(adev,
+					firmware_usage_v2_2,
+					&usage_bytes);
 		}
 	}
+
 	ctx->scratch_size_bytes = 0;
 	if (usage_bytes == 0)
 		usage_bytes = 20 * 1024;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 76a8ebfc9e71..06673a756231 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1579,6 +1579,22 @@ static void amdgpu_ttm_fw_reserve_vram_fini(struct amdgpu_device *adev)
 		NULL, &adev->mman.fw_vram_usage_va);
 }
 
+/*
+ * Driver Reservation functions
+ */
+/**
+ * amdgpu_ttm_drv_reserve_vram_fini - free drv reserved vram
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * free drv reserved vram if it has been reserved.
+ */
+static void amdgpu_ttm_drv_reserve_vram_fini(struct amdgpu_device *adev)
+{
+	amdgpu_bo_free_kernel(&adev->mman.drv_vram_usage_reserved_bo,
+		NULL, NULL);
+}
+
 /**
  * amdgpu_ttm_fw_reserve_vram_init - create bo vram reservation from fw
  *
@@ -1605,6 +1621,31 @@ static int amdgpu_ttm_fw_reserve_vram_init(struct amdgpu_device *adev)
 					  &adev->mman.fw_vram_usage_va);
 }
 
+/**
+ * amdgpu_ttm_drv_reserve_vram_init - create bo vram reservation from driver
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * create bo vram reservation from drv.
+ */
+static int amdgpu_ttm_drv_reserve_vram_init(struct amdgpu_device *adev)
+{
+	uint64_t vram_size = adev->gmc.visible_vram_size;
+
+	adev->mman.drv_vram_usage_reserved_bo = NULL;
+
+	if (adev->mman.drv_vram_usage_size == 0 ||
+	    adev->mman.drv_vram_usage_size > vram_size)
+		return 0;
+
+	return amdgpu_bo_create_kernel_at(adev,
+					  adev->mman.drv_vram_usage_start_offset,
+					  adev->mman.drv_vram_usage_size,
+					  AMDGPU_GEM_DOMAIN_VRAM,
+					  &adev->mman.drv_vram_usage_reserved_bo,
+					  NULL);
+}
+
 /*
  * Memoy training reservation functions
  */
@@ -1772,6 +1813,14 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 		return r;
 	}
 
+	/*
+	 *The reserved vram for driver must be pinned to the specified
+	 *place on the VRAM, so reserve it early.
+	 */
+	r = amdgpu_ttm_drv_reserve_vram_init(adev);
+	if (r)
+		return r;
+
 	/*
 	 * only NAVI10 and onwards ASIC support for IP discovery.
 	 * If IP discovery enabled, a block of memory should be
@@ -1897,6 +1946,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
 	amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
 					&adev->mman.sdma_access_ptr);
 	amdgpu_ttm_fw_reserve_vram_fini(adev);
+	amdgpu_ttm_drv_reserve_vram_fini(adev);
 
 	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index 6a70818039dd..7c38843f411e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -84,6 +84,11 @@ struct amdgpu_mman {
 	struct amdgpu_bo	*fw_vram_usage_reserved_bo;
 	void		*fw_vram_usage_va;
 
+	/* driver VRAM reservation */
+	u64		drv_vram_usage_start_offset;
+	u64		drv_vram_usage_size;
+	struct amdgpu_bo	*drv_vram_usage_reserved_bo;
+
 	/* PAGE_SIZE'd BO for process memory r/w over SDMA. */
 	struct amdgpu_bo	*sdma_access_bo;
 	void			*sdma_access_ptr;
diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/amd/include/atomfirmware.h
index ff855cb21d3f..68a86b14dff4 100644
--- a/drivers/gpu/drm/amd/include/atomfirmware.h
+++ b/drivers/gpu/drm/amd/include/atomfirmware.h
@@ -705,20 +705,72 @@ struct atom_gpio_pin_lut_v2_1
 };
 
 
-/* 
-  ***************************************************************************
-    Data Table vram_usagebyfirmware  structure
-  ***************************************************************************
+/*
+ * VBIOS/PRE-OS always reserve a FB region at the top of frame buffer.
+ * driver should not write access that region.
+ * driver can allocate their own reservation region as long as it does not overlap firwmare's
+ * reservation region.
+ * if( atom data table firmwareInfoTable version < 3.3) { //( pre-NV1X )
+ * in this case, atom data table vram_usagebyfirmwareTable version always <= 2.1
+ * if( VBIOS/UEFI GOP is posted ) {
+ *    VBIOS/UEFIGOP update used_by_firmware_in_kb = total reserved size by VBIOS
+ *    update start_address_in_kb = total_mem_size_in_kb - used_by_firmware_in_kb;
+ *    Where: ( total_mem_size_in_kb = reg(CONFIG_MEMSIZE)<<10)
+ *    driver can allocate driver reservation region under firmware reservation,
+ *    used_by_driver_in_kb = driver reservation size
+ *    driver reservation start address =  (start_address_in_kb - used_by_driver_in_kb)
+ *  Comment1[hchan]:
+ *    There is only one reservation at the beginning of the FB reserved by Host driver.
+ *  Host driver would overwrite the table with the following
+ *  used_by_firmware_in_kb = total reserved size for pf-vf info exchange and
+ *  set SRIOV_MSG_SHARE_RESERVATION mask start_address_in_kb = 0
+ *  } else {
+ *    there is no VBIOS reservation region
+ *    driver must allocate driver reservation region at top of FB.
+ *    driver set used_by_driver_in_kb = driver reservation size
+ *    driver reservation start address =  (total_mem_size_in_kb - used_by_driver_in_kb)
+ *    same as Comment1
+ *  }
+ * } else { //( NV1X and after)
+ * if( VBIOS/UEFI GOP is posted ) {
+ *    VBIOS/UEFIGOP update used_by_firmware_in_kb = atom_firmware_Info_v3_3.fw_reserved_size_in_kb;
+ *    update start_address_in_kb = total_mem_size_in_kb - used_by_firmware_in_kb;
+ *    Where: ( total_mem_size_in_kb = reg(CONFIG_MEMSIZE)<<10  )
+ *  }
+ *  if( vram_usagebyfirmwareTable version <= 2.1 ) {
+ *    driver can allocate driver reservation region under firmware reservation,
+ *    driver set used_by_driver_in_kb = driver reservation size
+ *    driver reservation start address =  (start_address_in_kb - used_by_driver_in_kb)
+ *    same as Comment1
+ *  } else {
+ *    dirver can allocate it reservation any place as long as
+ *    it does overlap pre-OS FW reservation area
+ *    driver set used_by_driver_region0_in_kb = driver reservation size
+ *    driver set driver_region0_start_address_in_kb =  driver reservation region start address
+ *  Comment2[hchan]: Host driver can set used_by_firmware_in_kb and start_address_in_kb to zero
+ *  as the reservation for VF as it doesn’t exist.  And Host driver should also
+ *  update atom_firmware_Info table to remove the same VBIOS reservation as well.
+ *  }
+ * }
 */
 
 struct vram_usagebyfirmware_v2_1
 {
-  struct  atom_common_table_header  table_header;
-  uint32_t  start_address_in_kb;
-  uint16_t  used_by_firmware_in_kb;
-  uint16_t  used_by_driver_in_kb; 
+	struct  atom_common_table_header  table_header;
+	uint32_t  start_address_in_kb;
+	uint16_t  used_by_firmware_in_kb;
+	uint16_t  used_by_driver_in_kb;
 };
 
+struct vram_usagebyfirmware_v2_2 {
+	struct  atom_common_table_header  table_header;
+	uint32_t  fw_region_start_address_in_kb;
+	uint16_t  used_by_firmware_in_kb;
+	uint16_t  reserved;
+	uint32_t  driver_region0_start_address_in_kb;
+	uint32_t  used_by_driver_region0_in_kb;
+	uint32_t  reserved32[7];
+};
 
 /* 
   ***************************************************************************
-- 
2.25.1

