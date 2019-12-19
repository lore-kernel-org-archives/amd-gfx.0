Return-Path: <SRS0=793y=2J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA19C43603
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2019 09:16:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89B2A21D7D
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2019 09:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="BeDNfm0c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89B2A21D7D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E33E6EAE5;
	Thu, 19 Dec 2019 09:16:34 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC26E6EAE5
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Dec 2019 09:16:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IBKzUQ/HQ4p5qG0La3fXq9O4Y5kq3ly268Y8BgkHZm5n8/VrLULNpC1Uogjg9dUh3Rg6/fH7/i237THwIrZkAF5q0N1Dlrr/CMmqVU/s9Jya3mQvl5xq7DOob/XyH/bZwJa5p4B8JJCJxuI5IR3UMW97quZ5At6C2tfBBNajzmJhGF19x/dhij0FSFiwTblUTEjWeOTfzYHbMOVqeOiZx4qjYpJzHWUsBWeJiIBRk+mUiUghLpC+aAreeH3KjP3TKTsxdJWGCAjH5GEACDDgA8Fr5UD8I6QtTpCZkrlst1iBhZi/e/hSV7FiLzT9XKQUL1VnIAjr1SrPtyrDcDwT3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s6iXGqNIjBZFmdpSxo9jdb2pMy0/xOR7X/U+HN4eIeA=;
 b=aMVQRPsaKufvJgDIXm5o4vWRuIFnyLforWLDSna6dedEs2i+U8nlE9NX+8AXRXy9XMgnkVXXQbzhEw6AUZnnvBXIUqd9JTG0ZtSi1IGb9LCnhFOoazkGo1/GWzenJs8awxfAnLzT3araYSCjnY+jKw0cj/eALFIHh7VpyuMVpcBMnRUQ1Rxm6SksLAMLU63eGXbknzSNW2XUEJ5xfeE/dwoZXWREt8CAKdpTH8N9y0m5qX02AMYOlxatJAVdkXPdTP6xKgN2TiK7ZZXN9LzQSNx95zkcOaRbxt4vYRDUHqsI/5vZf+EsqnOLJ+EaniRM35+FspfY16Q/bgCYJr4e7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s6iXGqNIjBZFmdpSxo9jdb2pMy0/xOR7X/U+HN4eIeA=;
 b=BeDNfm0cXO/bwzkVWy7GjxTpDrvO8q3twsaL9+KmYOJjNL8zVnCXFZZ8zoMbLPUbNqGt5cWkzx0xZB6BnzK9haw/wMS+dwwH9nvM/y/Uz8NpBJz3WV3VeH7ztwE7fNPVePNdyTPd8a+NuJ6EdbuJKZss42aGu910fhKHGyLeSqU=
Received: from DM3PR12CA0043.namprd12.prod.outlook.com (2603:10b6:0:56::11) by
 DM5PR12MB2360.namprd12.prod.outlook.com (2603:10b6:4:bb::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Thu, 19 Dec 2019 09:16:30 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::200) by DM3PR12CA0043.outlook.office365.com
 (2603:10b6:0:56::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.14 via Frontend
 Transport; Thu, 19 Dec 2019 09:16:30 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2559.15 via Frontend Transport; Thu, 19 Dec 2019 09:16:29 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 19 Dec
 2019 03:16:28 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 19 Dec
 2019 03:16:28 -0600
Received: from rico-code.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 19 Dec 2019 03:16:25 -0600
From: Tianci Yin <tianci.yin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: update the method to get fb_loc of memory
 training(V4)
Date: Thu, 19 Dec 2019 17:16:22 +0800
Message-ID: <20191219091623.3922-1-tianci.yin@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(136003)(376002)(346002)(428003)(199004)(189003)(186003)(2906002)(6916009)(356004)(316002)(426003)(336012)(8676002)(6666004)(81166006)(8936002)(81156014)(70206006)(70586007)(54906003)(1076003)(26005)(5660300002)(7696005)(2616005)(44832011)(4326008)(86362001)(36756003)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2360; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37e6e1bc-103f-42a2-247c-08d7846421e9
X-MS-TrafficTypeDiagnostic: DM5PR12MB2360:
X-Microsoft-Antispam-PRVS: <DM5PR12MB236022461FAC641B818A614095520@DM5PR12MB2360.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:590;
X-Forefront-PRVS: 0256C18696
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gnqf9H8DzI3iBDhpFfybplxb9yPOBFKiAHZWIxQO3R1T1yfHIXDdL6tSWxc5e/Aai7TacGSbAjj05HtJ67qg83Wh/PAI2K/mV2qtgz7x91wfKlHssGTfcmJlcbiSxBPPvLaa705zAQBJNWc79GX+UTGsyzaEkHwMBM8cWvtOnwYkmBhETvgonqstjMAlROP/CIdQomgdZ+yk0yjMg6os5qUXxf82QRwroR/lGTcqdtHK2FeQkmKuh8hQIW85/5Qtr3dVeC4w2FjBFDI64/NLJdf+dUaRjURa61uhmAWQJFO6sj7zHiam40FD83oyvBf+awoJPZaaNuyYi7q1DviqFmufpHIPiHJ0m2NyXo2OFzDUEx75qjc6AeYt81czsw+cnc/y1+6XalXbYRzJ811LLDi863tco56kgRKzglksiEM2N1jyUs6iea6MZ9TPlbvC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2019 09:16:29.5036 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37e6e1bc-103f-42a2-247c-08d7846421e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2360
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 10 ++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |  7 ++++
 drivers/gpu/drm/amd/include/atomfirmware.h    | 14 -------
 7 files changed, 23 insertions(+), 53 deletions(-)

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
index 2ff63d0414c9..1515413fd356 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1687,6 +1687,14 @@ static int amdgpu_ttm_training_reserve_vram_fini(struct amdgpu_device *adev)
 	return 0;
 }
 
+static u64 amdgpu_ttm_training_get_c2p_offset(u64 vram_size)
+{
+       if ((vram_size & (ONE_MiB - 1)) < (4 * ONE_KiB + 1) )
+               vram_size -= ONE_MiB;
+
+       return ALIGN(vram_size, ONE_MiB);
+}
+
 /**
  * amdgpu_ttm_training_reserve_vram_init - create bo vram reservation from memory training
  *
@@ -1705,7 +1713,7 @@ static int amdgpu_ttm_training_reserve_vram_init(struct amdgpu_device *adev)
 		return 0;
 	}
 
-	ctx->c2p_train_data_offset = adev->fw_vram_usage.mem_train_fb_loc;
+	ctx->c2p_train_data_offset = amdgpu_ttm_training_get_c2p_offset(adev->gmc.mc_vram_size);
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
