Return-Path: <SRS0=JueS=2H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5750C43603
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Dec 2019 11:23:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB0252072D
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Dec 2019 11:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GZG4lthA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB0252072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0863A6E98E;
	Tue, 17 Dec 2019 11:23:50 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B60BE6E987
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Dec 2019 11:23:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P2Wwst+FJdOmdjvSViWDLBXkzn32rGxvIWfIZOG54BRQkftDgheYztWK2t6T6JZC15tdgKnZkpYfzq71ZCQipHLz+ZWVMDslZUsJxJnvjeMluPtoVYPZlPz6z4sTB6opa3zfLvZzSodG0Fdrmmd9fSIx6XYLnkBE5UL1S2Gd/9ckPGwrvd3339GU3+WdK8jN3bEhMmjPqzH+2lAnko5Hy522+5hMM/lSz9f6WkVoD5Kg1m5RnIO6NFdhHZrrKPrBU4ZFpzsfVQpmbRERQ6RuBvUYlQiP55wQ0T2MjyCJBl3ELxYjwmjY0MTBTuKcDnTZi0WUAyEomvFeqGd0YVpDwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B3philQrJotYJgWGbaiFjtgDjuWXR4G/G28VxY9PxRw=;
 b=fwMpEasDUJ/HNi0zimlTcT+TLC93pMgA5VgRi3BSHNV3oYVkhHxQlMPK4JZ2KqtnAC0Lp31b2Rl7O2o/yBx/QiS44V+39HB0PdOcdz+3rm+1gPxVYYuCtL62gs+73h3+alwmYTuzu8VNUhyehMpOtxa6FpoyMKGQyl06rJYxftV5jVeDVpRLqEItTlxqela+Pr9H3xazuLvjrvJyr1zVtY2VXBknkSKvzvvnCEXaBSEC51FRGFY5VZbu6bgcQYFpfakYqzzc8FKhRi3xMrsPG85Se7KD2eYVhZjeVTnm/4O4IY/udChdoPjbJADMTDY4bLZCAUK7cppxnwdokZjyTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B3philQrJotYJgWGbaiFjtgDjuWXR4G/G28VxY9PxRw=;
 b=GZG4lthARLeGyyay3ghGExhTQf+CVosF1Fh3ogVECLA9bxRqxpf5cR1FGsNQxk+yzOA8NU1d44zqrGEmBUg38al/1HQVEeNIQc7+NJkOg4OV5/aB9T7HRVhWOFd9gUbSW0uYbuDIVI6osD+4kYtULMMeofWmWs1u5e9P19JH9FQ=
Received: from MN2PR12CA0016.namprd12.prod.outlook.com (2603:10b6:208:a8::29)
 by MN2PR12MB2974.namprd12.prod.outlook.com (2603:10b6:208:c1::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.18; Tue, 17 Dec
 2019 11:23:45 +0000
Received: from BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eae::207) by MN2PR12CA0016.outlook.office365.com
 (2603:10b6:208:a8::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.15 via Frontend
 Transport; Tue, 17 Dec 2019 11:23:44 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT050.mail.protection.outlook.com (10.13.177.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2538.14 via Frontend Transport; Tue, 17 Dec 2019 11:23:44 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 17 Dec
 2019 05:23:27 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 17 Dec
 2019 05:23:27 -0600
Received: from rico-code.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Tue, 17 Dec 2019 05:23:25 -0600
From: Tianci Yin <tianci.yin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: update the method to get fb_loc of memory
 training
Date: Tue, 17 Dec 2019 19:23:21 +0800
Message-ID: <20191217112322.20042-1-tianci.yin@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(396003)(376002)(39860400002)(136003)(428003)(199004)(189003)(8936002)(81166006)(81156014)(426003)(8676002)(336012)(2616005)(6916009)(26005)(36756003)(478600001)(5660300002)(44832011)(7696005)(54906003)(316002)(6666004)(356004)(86362001)(1076003)(70206006)(186003)(70586007)(4326008)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB2974; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bfe099b2-fbbe-4c9c-6cf4-08d782e393fe
X-MS-TrafficTypeDiagnostic: MN2PR12MB2974:
X-Microsoft-Antispam-PRVS: <MN2PR12MB29749C35F8CFDBF0B4CD3C4295500@MN2PR12MB2974.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 02543CD7CD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jbHMXiJVZpir+8fw+1yKc4mlfcROGc1HJ7UNslq4KwbAFlSBHGARPuwS3VHEF5iVfJ9GkaxoGPERC0WStqETkdMK4DXHKSbOkaIiQvYf0zizEHkkKhCsS53kJC8wFvAlFpD2ALEE7d0536XYTX/gFgV5JpOLUQ6Cj9tz3J/0ellYXSYIUyUXNu/IjObEUerY1oeF1lBn7ArfgFdRPO8xmcUGR222X7ZwAGWcPDTVE2h4vfDpHLAOxzubs9gEkgyQI/ByuT0FE1ERiKSK5OwfvqfBnMMXEY62LsKKWErmjaciuN3LrZmUP7VwIb1zTx/yoy206a4i/nLYrvL1tLCXPvJWAG2zTfoBuklgXUhIAnX+gfsIHH+poZIV40CBSrD/i+YsGaavEolOXCFB4TI1XyCtPjOfhQbXBF3tzAQk02RSRtpkwgBccf6/6s4bP0Nw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2019 11:23:44.7594 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfe099b2-fbbe-4c9c-6cf4-08d782e393fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2974
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
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  3 +-
 .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  | 36 ++-----------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  6 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |  7 ++++
 drivers/gpu/drm/amd/include/atomfirmware.h    | 14 --------
 5 files changed, 16 insertions(+), 50 deletions(-)

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
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
index ff4eb96bdfb5..009cb0b03d13 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -528,13 +528,9 @@ static int gddr6_mem_train_support(struct amdgpu_device *adev)
 int amdgpu_atomfirmware_get_mem_train_fb_loc(struct amdgpu_device *adev)
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
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 2ff63d0414c9..ce5cb854bdb9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1705,7 +1705,11 @@ static int amdgpu_ttm_training_reserve_vram_init(struct amdgpu_device *adev)
 		return 0;
 	}
 
-	ctx->c2p_train_data_offset = adev->fw_vram_usage.mem_train_fb_loc;
+	ctx->c2p_train_data_offset = adev->gmc.mc_vram_size;
+	if ((ctx->c2p_train_data_offset & (ONE_MiB - 1)) < (4 * ONE_KiB + 1) ) {
+		ctx->c2p_train_data_offset -= ONE_MiB;
+	}
+	ctx->c2p_train_data_offset &= ~(ONE_MiB - 1);
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
