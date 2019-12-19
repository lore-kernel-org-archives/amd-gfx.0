Return-Path: <SRS0=793y=2J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6FE6C43603
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2019 02:44:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 876F822314
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2019 02:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3OHiSa2L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 876F822314
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADCFE6E0A1;
	Thu, 19 Dec 2019 02:44:31 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700088.outbound.protection.outlook.com [40.107.70.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 258DE6E0A1
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Dec 2019 02:44:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eFi7m1hsGoV3KZtK0hbsdZVzkFzqttYSJjX8soHhzE1IvNVz5Z0hixxgro7PzRRfelwud+bjS4YiWv9QTsaSwV2OjpuW/HuBz6CIOrPoQfl6eJ/MaI8CZKsJfwmHJ6nBuxufFJH3asl8r8ofKdlAe/LrYa19sBJUf+P3Mp7zU/5UnSjHalX2npLxgm08hUARjr0MIv1JqeiPfNKaj0QXp0TSMD9YPvmejNuetBHkFEKGAE58lGwC/EtNZrkoxifohDKlHxOwDyUt+mi9Nq4V7alZVmAVui4vyfMZPts95sO11y1ZPvU0fjbEJhpY96HdBA3tzPx1c8v3qM9uWOkm6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kemBZ1jod86Oc9/lkOjvatltwncTC5ZbV818LIGxcoA=;
 b=bGqVWFeJo/iXlz9XgAhICEv8/tOCU//WNoLbcDUOopnUappYWG8CUhTEfe6301GrOpX+WEQ+zjcKXNWJE79+UFAyDIjjVIE+kKmNjAGP/0iXNQ/YyL5+KqjpqKZDafgqMmGmM5iHqiVYb47YsGi4BOg9Pm/S1INFmYnyCRfCdnEgwkAy7B/dEWO+1S05O23c5kkqOBhxjdQ90kpO6LLHod28eAIgOAa4S/1ZR5Kd1/1G8LhgcxS3RKRnZGV7mEz5s99D5CvlAw4wANlahwZ4MyhsGiyXObVZ+VXRDayasIhN6P/CsQc6e267PnZgmgVZWtQ1sAugLP9AEte/PW+jYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kemBZ1jod86Oc9/lkOjvatltwncTC5ZbV818LIGxcoA=;
 b=3OHiSa2LuycNpWDt4gyEmMRfEp/+zQMrsbvdJrAGqtpDNAVf+BQog25gSsKhTsG8CHZSZ2lRJWYoHZeAooO3zv09F6sD3Ea1WpfJgUKBODvyi9/KeT/NvmWB/M8A7c/emwcIqlRpiuBh/Q6WbmHgPgn3YufN9fe9delWeCSYk7E=
Received: from DM5PR12CA0020.namprd12.prod.outlook.com (2603:10b6:4:1::30) by
 DM6PR12MB3898.namprd12.prod.outlook.com (2603:10b6:5:1c6::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Thu, 19 Dec 2019 02:44:27 +0000
Received: from BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eae::207) by DM5PR12CA0020.outlook.office365.com
 (2603:10b6:4:1::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.14 via Frontend
 Transport; Thu, 19 Dec 2019 02:44:27 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT028.mail.protection.outlook.com (10.13.176.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2538.14 via Frontend Transport; Thu, 19 Dec 2019 02:44:27 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 18 Dec
 2019 20:44:26 -0600
Received: from rico-code.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 18 Dec 2019 20:44:19 -0600
From: Tianci Yin <tianci.yin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: update the method to get fb_loc of memory
 training(V3)
Date: Thu, 19 Dec 2019 10:44:15 +0800
Message-ID: <20191219024416.32321-1-tianci.yin@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(346002)(396003)(376002)(428003)(199004)(189003)(478600001)(336012)(70206006)(2906002)(86362001)(2616005)(70586007)(7696005)(26005)(186003)(8676002)(81166006)(81156014)(1076003)(36756003)(54906003)(356004)(316002)(6666004)(426003)(4326008)(5660300002)(44832011)(6916009)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3898; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9022d896-73e0-4b7d-cf8a-08d7842d5da1
X-MS-TrafficTypeDiagnostic: DM6PR12MB3898:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3898D51D4F7FBB690CC6CE1895520@DM6PR12MB3898.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:590;
X-Forefront-PRVS: 0256C18696
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JvnU0WE1ZHkhYr1Gi+tu+YxmajfyL4vTHDQ4llVeffFMB4M0Jsp5B9EBPoG0XGg+bwoH0zr/+OQAKx6K7Imay+lyf2OZ47UP7oTJACevnIyr/MH4V5hUkjijPUH0JACLlDrTvr9OYVWL+IB9sqoKZtImPPvwWwdfvqGBp++TwNMPcCWmyDFUKZiot4WVMfOJN1/ncs7IlQYNfGG3MfPNgCfVWmWff82rwuHkO/5RuUXdAN/2SSwo3oyP793mSYNEUGs8ryL4i0qrdcKnT2X4W9lTkvpXegGhekyJpb8tcNw33wzGu3NBqL9DQXAsqSUYg7tDLKIXOxPuvc5ltXoWqGEcs3ogLLfZrPZTokGapktbQZe51cU056WLWhSqO5A49j06+LGpvA7xykhzqxQMCJrgv/bZKlx0tBNaVP2X0Fit6hHvGNCas0RgCNwiFkG+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2019 02:44:27.5074 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9022d896-73e0-4b7d-cf8a-08d7842d5da1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3898
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
Cc: Long Gang <Gang.Long@amd.com>, Tianci Yin <tianci.yin@amd.com>,
 Feifei Xu <Feifei.Xu@amd.com>, Kevin Wang <Kevin1.Wang@amd.com>,
 Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Xiaojie Yuan <xiaojie.yuan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Tianci.Yin" <tianci.yin@amd.com>

The method of getting fb_loc changed from parsing VBIOS to
taking certain offset from top of VRAM

Change-Id: I053b42fdb1d822722fa7980b2cd9f86b3fdce539
Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c  |  2 +-
 .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  | 38 ++-----------------
 .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h  |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 13 ++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |  7 ++++
 drivers/gpu/drm/amd/include/atomfirmware.h    | 14 -------
 7 files changed, 26 insertions(+), 53 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index a78a363b1d71..fa2cf8e7bc07 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -642,9 +642,8 @@ struct amdgpu_fw_vram_usage {
 	struct amdgpu_bo *reserved_bo;
 	void *va;
 
-	/* Offset on the top of VRAM, used as c2p write buffer.
+	/* GDDR6 training support flag.
 	*/
-	u64 mem_train_fb_loc;
 	bool mem_train_support;
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
index 9ba80d828876..fdd52d86a4d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
@@ -2022,7 +2022,7 @@ int amdgpu_atombios_init(struct amdgpu_device *adev)
 	if (adev->is_atom_fw) {
 		amdgpu_atomfirmware_scratch_regs_init(adev);
 		amdgpu_atomfirmware_allocate_fb_scratch(adev);
-		ret = amdgpu_atomfirmware_get_mem_train_fb_loc(adev);
+		ret = amdgpu_atomfirmware_get_mem_train_info(adev);
 		if (ret) {
 			DRM_ERROR("Failed to get mem train fb location.\n");
 			return ret;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
index ff4eb96bdfb5..58f9d8c3a17a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -525,16 +525,12 @@ static int gddr6_mem_train_support(struct amdgpu_device *adev)
 	return ret;
 }
 
-int amdgpu_atomfirmware_get_mem_train_fb_loc(struct amdgpu_device *adev)
+int amdgpu_atomfirmware_get_mem_train_info(struct amdgpu_device *adev)
 {
 	struct atom_context *ctx = adev->mode_info.atom_context;
-	unsigned char *bios = ctx->bios;
-	struct vram_reserve_block *reserved_block;
-	int index, block_number;
+	int index;
 	uint8_t frev, crev;
 	uint16_t data_offset, size;
-	uint32_t start_address_in_kb;
-	uint64_t offset;
 	int ret;
 
 	adev->fw_vram_usage.mem_train_support = false;
@@ -569,32 +565,6 @@ int amdgpu_atomfirmware_get_mem_train_fb_loc(struct amdgpu_device *adev)
 		return -EINVAL;
 	}
 
-	reserved_block = (struct vram_reserve_block *)
-		(bios + data_offset + sizeof(struct atom_common_table_header));
-	block_number = ((unsigned int)size - sizeof(struct atom_common_table_header))
-		/ sizeof(struct vram_reserve_block);
-	reserved_block += (block_number > 0) ? block_number-1 : 0;
-	DRM_DEBUG("block_number:0x%04x, last block: 0x%08xkb sz, %dkb fw, %dkb drv.\n",
-		  block_number,
-		  le32_to_cpu(reserved_block->start_address_in_kb),
-		  le16_to_cpu(reserved_block->used_by_firmware_in_kb),
-		  le16_to_cpu(reserved_block->used_by_driver_in_kb));
-	if (reserved_block->used_by_firmware_in_kb > 0) {
-		start_address_in_kb = le32_to_cpu(reserved_block->start_address_in_kb);
-		offset = (uint64_t)start_address_in_kb * ONE_KiB;
-		if ((offset & (ONE_MiB - 1)) < (4 * ONE_KiB + 1) ) {
-			offset -= ONE_MiB;
-		}
-
-		offset &= ~(ONE_MiB - 1);
-		adev->fw_vram_usage.mem_train_fb_loc = offset;
-		adev->fw_vram_usage.mem_train_support = true;
-		DRM_DEBUG("mem_train_fb_loc:0x%09llx.\n", offset);
-		ret = 0;
-	} else {
-		DRM_ERROR("used_by_firmware_in_kb is 0!\n");
-		ret = -EINVAL;
-	}
-
-	return ret;
+	adev->fw_vram_usage.mem_train_support = true;
+	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h
index f871af5ea6f3..434fe2fa0089 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h
@@ -31,7 +31,7 @@ void amdgpu_atomfirmware_scratch_regs_init(struct amdgpu_device *adev);
 int amdgpu_atomfirmware_allocate_fb_scratch(struct amdgpu_device *adev);
 int amdgpu_atomfirmware_get_vram_info(struct amdgpu_device *adev,
 	int *vram_width, int *vram_type, int *vram_vendor);
-int amdgpu_atomfirmware_get_mem_train_fb_loc(struct amdgpu_device *adev);
+int amdgpu_atomfirmware_get_mem_train_info(struct amdgpu_device *adev);
 int amdgpu_atomfirmware_get_clock_info(struct amdgpu_device *adev);
 int amdgpu_atomfirmware_get_gfx_info(struct amdgpu_device *adev);
 bool amdgpu_atomfirmware_mem_ecc_supported(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 2ff63d0414c9..ec84acdd43a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1687,6 +1687,17 @@ static int amdgpu_ttm_training_reserve_vram_fini(struct amdgpu_device *adev)
 	return 0;
 }
 
+static void amdgpu_ttm_training_get_c2p_offset(struct amdgpu_device *adev)
+{
+	u64 offset = adev->gmc.mc_vram_size;
+	struct psp_memory_training_context *ctx = &adev->psp.mem_train_ctx;
+
+	if ((offset & (ONE_MiB - 1)) < (4 * ONE_KiB + 1) )
+		offset -= ONE_MiB;
+
+	ctx->c2p_train_data_offset = ALIGN(offset,ONE_MiB);
+}
+
 /**
  * amdgpu_ttm_training_reserve_vram_init - create bo vram reservation from memory training
  *
@@ -1705,7 +1716,7 @@ static int amdgpu_ttm_training_reserve_vram_init(struct amdgpu_device *adev)
 		return 0;
 	}
 
-	ctx->c2p_train_data_offset = adev->fw_vram_usage.mem_train_fb_loc;
+	amdgpu_ttm_training_get_c2p_offset();
 	ctx->p2c_train_data_offset = (adev->gmc.mc_vram_size - GDDR6_MEM_TRAINING_OFFSET);
 	ctx->train_data_size = GDDR6_MEM_TRAINING_DATA_SIZE_IN_BYTES;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index f1ebd424510c..19eb3e8456c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -66,6 +66,13 @@ struct amdgpu_copy_mem {
 	unsigned long			offset;
 };
 
+/* Definitions for constance */
+enum amdgpu_internal_constants
+{
+	ONE_KiB	= 0x400,
+	ONE_MiB	= 0x100000,
+};
+
 extern const struct ttm_mem_type_manager_func amdgpu_gtt_mgr_func;
 extern const struct ttm_mem_type_manager_func amdgpu_vram_mgr_func;
 
diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/amd/include/atomfirmware.h
index dd7cbc00a0aa..70146518174c 100644
--- a/drivers/gpu/drm/amd/include/atomfirmware.h
+++ b/drivers/gpu/drm/amd/include/atomfirmware.h
@@ -672,20 +672,6 @@ struct vram_usagebyfirmware_v2_1
   uint16_t  used_by_driver_in_kb; 
 };
 
-/* This is part of vram_usagebyfirmware_v2_1 */
-struct vram_reserve_block
-{
-	uint32_t start_address_in_kb;
-	uint16_t used_by_firmware_in_kb;
-	uint16_t used_by_driver_in_kb;
-};
-
-/* Definitions for constance */
-enum atomfirmware_internal_constants
-{
-	ONE_KiB	= 0x400,
-	ONE_MiB	= 0x100000,
-};
 
 /* 
   ***************************************************************************
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
