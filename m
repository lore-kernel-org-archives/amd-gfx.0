Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D12E5C433FE
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Nov 2022 10:32:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9816B10E0D3;
	Tue,  8 Nov 2022 10:32:50 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2087.outbound.protection.outlook.com [40.107.212.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA3A310E0D3
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Nov 2022 10:32:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iZ6t/Az5w0/BJDslZl9BaQ/vgMn/+wrw/3ZGngVKyp+CsgesX2taPDVL/W1iGJAcffAzMHzah4VpYE8NWhvO5xYpqDUti7jg1MwpmVlzGaXL2HFaDicGOrYXOOiHV3e6dDt7h44jn41FMm9LuzwSOPDd/Nx1woMzaWWfqXYwE5c1d0td4EUYoH+GbpCyLUcGm14mSigfNeCq1xF6W0VuHiA8KyZX36FQ2fxtpqTnNljPZzrwH3OtLdoCG5PqMsxnpCgl6aX5t14rrBGtk/tLiBrN8JCrPv+UuBvDlEtDouNcv1/vs9BKW6xY80amIhr9Tjf07GOJKJq7Q0g3otpCaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A1Jd/bd86JyFHIUFcPwo3/eL9t0bVQzcrwSR6k3je7I=;
 b=Mlkz+nnoxMOQMEoCcIqKwfScA9OqBI6nccFLKZIW+xt8fwIWotSd61eUdP8VliGes6Yha2eI66VBZYLTfDQ7kH/dIGKgHHBEbfFaQKgunRk3VY5xljeyfoNo3NSraEPBmTndp3/NX614rPPbg4/o3MGoBFM9v/DPhv3iACxxzA/OE+6UnAN6c3MzZunzttbWOqKsxfOH22gMTtS3x8iaGraWq6jvwVOHCiVgILz2O1OHKILmYoNS4VNQuP9IfQf5XVFqlioRF6WpKPfw4XHx8mH2v/Ac8xHFWdvMCiDKSqGlWdmvQgYa1aS8n4v1iwQK5MTUwFdPGZCtIYRUj/kylQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A1Jd/bd86JyFHIUFcPwo3/eL9t0bVQzcrwSR6k3je7I=;
 b=wx+jqyfm3fis5TdMB5EWbgyEKp0jlrwsW0qbMZW3Q0S0L6X1vWZOv8zCa5SLmkXY9VPAo/nigdyqvry1z7oMsBBupQU82ry4n7uDC3hIBFrnSwgqxDqgGUQtM9hbyeiCv7Gh3DTE0Sc37hrJM4e0LFytLK2Z+sBUC/CXwJWvAK4=
Received: from DM6PR06CA0031.namprd06.prod.outlook.com (2603:10b6:5:120::44)
 by BY5PR12MB4082.namprd12.prod.outlook.com (2603:10b6:a03:212::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Tue, 8 Nov
 2022 10:32:42 +0000
Received: from DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::81) by DM6PR06CA0031.outlook.office365.com
 (2603:10b6:5:120::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26 via Frontend
 Transport; Tue, 8 Nov 2022 10:32:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT046.mail.protection.outlook.com (10.13.172.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Tue, 8 Nov 2022 10:32:42 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 8 Nov
 2022 04:32:41 -0600
Received: from amd-SYS-7048GR-TR.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.31
 via Frontend Transport; Tue, 8 Nov 2022 04:32:38 -0600
From: Tong Liu01 <Tong.Liu01@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add vram reservation logic based on
 vram_usagebyfirmware_v2_2
Date: Tue, 8 Nov 2022 18:32:36 +0800
Message-ID: <20221108103236.8777-1-Tong.Liu01@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT046:EE_|BY5PR12MB4082:EE_
X-MS-Office365-Filtering-Correlation-Id: 6eefaa81-b6e0-4346-25c7-08dac1749173
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1ideStG0bk0tSDUkOUjnO5YPCU3nZ4ibe3i6Csp0C5voUsd3BK2Ued77LGvuPXTgYg2PcJCr867uaKpTmajzD+VcrLjUv7osVTjbFaHzUkWae+mxwJohWmgNFrgSFwui6IPg68UTJYmWiO4qh8trOltWE3D25C9mHZ5GpIL/AWi4XdbS4Pz4d4A6VGBU8yheoYIJX2iikla9OQ4vsRe/ckEzerYyJKkV7EdYfxmL+DXhymMmZQqN46eGrg6pXEaRKKAnw2MkW5Le+f1QVCzgWozm5qlL/zV7zn83vlWMz1s8rIPke6qoTZ4vdLGMWCWCDKfWfdR5trBHpfFBY9rFcwOerNiJZrGtdJUDeo60gK/1xkYLoCgXhlbp4yG81PQkXJSM+11QwUgJSzHmyz1nVCVlMmmd9/6NDgmuRKMUP1WE9pongiMt+njwRe+w+hw9QfXlAruGCELpAgjEfA7KJvGghWQDzRnfuN7rjFe1O0oEqrgWL29f55n7jaLYUpkv3UQVQIqy/ByNlYguoVOTuusMp8nNhXN4pIw5NzlQ8yjMF+C6mLnSqz/oUKA8l9BAnLmzNH0m9V3lvSWJz2VH+p6/c5pnur6JAHsODAM735kMe5yMEOa8lGlFUjeJmCJ4yZ5mmoR88x6A+Y5amnMqSkWOVTw7pI2xY6He1ZgXzymG6gKcAE1H0xNykagc+FskioxHVBSjbjA1hOmEu6uevr8LX6UVlBI4JcOKzBd3QU30qEUmKTOADLSNjuLfnnDhqaxROgRerh1HneQQse+YbcFRqdw4SlgDmAh9Mk/oFlaD1GaZu6eOO0Mu+KvY8kr1
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(396003)(346002)(39860400002)(376002)(451199015)(46966006)(40470700004)(36840700001)(36756003)(86362001)(356005)(82740400003)(81166007)(40480700001)(40460700003)(30864003)(2906002)(2616005)(1076003)(7696005)(336012)(26005)(426003)(47076005)(83380400001)(36860700001)(186003)(70206006)(70586007)(54906003)(6916009)(316002)(478600001)(82310400005)(8676002)(4326008)(8936002)(5660300002)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 10:32:42.6175 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eefaa81-b6e0-4346-25c7-08dac1749173
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4082
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
Cc: Jack Xiao <Jack.Xiao@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 horace.chen@amd.com, Kevin Wang <Kevin1.Wang@amd.com>,
 Tong Liu01 <Tong.Liu01@amd.com>, Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Monk
 Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Move TMR region from top of FB to 2MB for FFBM, so we need to reserve TMR
region firstly to make sure TMR can be allocated at 2MB

Signed-off-by: Tong Liu01 <Tong.Liu01@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  | 106 ++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  50 +++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |   5 +
 drivers/gpu/drm/amd/include/atomfirmware.h    |  62 ++++++++--
 4 files changed, 192 insertions(+), 31 deletions(-)

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
index 585460ab8dfd..4a73cb314086 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1578,6 +1578,22 @@ static void amdgpu_ttm_fw_reserve_vram_fini(struct amdgpu_device *adev)
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
@@ -1604,6 +1620,31 @@ static int amdgpu_ttm_fw_reserve_vram_init(struct amdgpu_device *adev)
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
@@ -1771,6 +1812,14 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
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
@@ -1896,6 +1945,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
 	amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
 					&adev->mman.sdma_access_ptr);
 	amdgpu_ttm_fw_reserve_vram_fini(adev);
+	amdgpu_ttm_drv_reserve_vram_fini(adev);
 
 	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index 9120ae80ef52..339838675b11 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -92,6 +92,11 @@ struct amdgpu_mman {
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
index ff855cb21d3f..c0f56ae653f0 100644
--- a/drivers/gpu/drm/amd/include/atomfirmware.h
+++ b/drivers/gpu/drm/amd/include/atomfirmware.h
@@ -705,20 +705,66 @@ struct atom_gpio_pin_lut_v2_1
 };
 
 
-/* 
-  ***************************************************************************
-    Data Table vram_usagebyfirmware  structure
-  ***************************************************************************
+/*
+  VBIOS/PRE-OS always reserve a FB region at the top of frame buffer. driver should not write access that region.
+  driver can allocate their own reservation region as long as it does not overlap firwmare's reservation region.
+  if( atom data table firmwareInfoTable version < 3.3) { //( pre-NV1X )
+    in this case, atom data table vram_usagebyfirmwareTable version always <= 2.1
+    if( VBIOS/UEFI GOP is posted ) {
+      VBIOS/UEFIGOP update used_by_firmware_in_kb = total reserved size by VBIOS
+      update start_address_in_kb = total_mem_size_in_kb - used_by_firmware_in_kb;  ( total_mem_size_in_kb = reg(CONFIG_MEMSIZE)<<10)
+      driver can allocate driver reservation region under firmware reservation,
+      used_by_driver_in_kb = driver reservation size
+      driver reservation start address =  (start_address_in_kb - used_by_driver_in_kb)
+    Comment1[hchan]: There is only one reservation at the beginning of the FB reserved by Host driver.
+    Host driver would overwrite the table with the following
+    used_by_firmware_in_kb = total reserved size for pf-vf info exchange and
+    set SRIOV_MSG_SHARE_RESERVATION mask start_address_in_kb = 0
+    } else {
+      there is no VBIOS reservation region
+      driver must allocate driver reservation region at top of FB.
+      driver set used_by_driver_in_kb = driver reservation size
+      driver reservation start address =  (total_mem_size_in_kb - used_by_driver_in_kb)
+      same as Comment1
+    }
+  } else { //( NV1X and after)
+    if( VBIOS/UEFI GOP is posted ) {
+      VBIOS/UEFIGOP update used_by_firmware_in_kb = atom_firmware_Info_v3_3.fw_reserved_size_in_kb;
+      update start_address_in_kb = total_mem_size_in_kb - used_by_firmware_in_kb;  ( total_mem_size_in_kb = reg(CONFIG_MEMSIZE)<<10  )
+    }
+    if( vram_usagebyfirmwareTable version <= 2.1 ) {
+      driver can allocate driver reservation region under firmware reservation,
+      driver set used_by_driver_in_kb = driver reservation size
+      driver reservation start address =  (start_address_in_kb - used_by_driver_in_kb)
+      same as Comment1
+    } else {
+      dirver can allocate it reservation any place as long as it does overlap pre-OS FW reservation area
+      driver set used_by_driver_region0_in_kb = driver reservation size
+      driver set driver_region0_start_address_in_kb =  driver reservation region start address
+      Comment2[hchan]: Host driver can set used_by_firmware_in_kb and start_address_in_kb to zero
+      as the reservation for VF as it doesn’t exist.  And Host driver should also
+      update atom_firmware_Info table to remove the same VBIOS reservation as well.
+    }
+  }
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

