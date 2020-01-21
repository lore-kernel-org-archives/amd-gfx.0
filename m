Return-Path: <SRS0=lIYJ=3K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42B8C32771
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2020 02:22:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A851722522
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2020 02:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="oFHyd6vv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A851722522
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1051B6E1EE;
	Tue, 21 Jan 2020 02:22:19 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F13B6E1EC
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jan 2020 02:22:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A9fsr67z2tNMcDIO9JLxWaDxml1XuKPiM2GGbr/bHBk+0ii0haH60gY2dpNBN+wBm6i/FY3TSVvLyKWY8y/pDya7CQFq8k4+A1qxLTOZTDk3GwAu+pQCjD1cQIYiR5feLnwnFzopu050dvExi4Zz4PSKycoZc6zJDyP0yH45TeDw/p72QNSQWg2dja+jBRuXaYY3orFxpRxiGmFR5sGqocwPULMPKxpEYzRe4zroBLrp32VEkdibTBdqF6D94y5BjE1KNkF/x8fQzl3fUReKHFsm/k5wwHM46X58G7gDx5Y2uiS1zyXeQdy+tkYUFgA8jOC3y7qDVQkuQ0G9zQJ+ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGz88XsdeQSUYIh0RiFf8IMEWQH9oNR08+ryQh0Gmnw=;
 b=h7JGzNS/2fy3bxVvrdpkkTDTbnd/vwAKeqvdT+epC8GhYZO+IX4YsdMIXT9o5K1rtaeOGiLPU4QvssfEM4BDYezyhhyrbDpZad3stAsrX44RA7eDAM33iJmvCZMXs/qNBtZgznjXZHC7C3Oph31+DDQsmCEELPuLz/rCt+pHlnio4jhuixqDTD/seDYiByWFEzh/js0VBdbj+6sctK1l3NKf5xgNR0MrMrM/BvlXQKiD1KKDFbG6Ot8BslK2kZpR0p3+Zgn114KPR4vhAV/t1eU1AoaA8go3mfzuhmYJYI+bwbWOyhIHmKFoQkUqTosN0SV3APOIm1GUSZObUvOHoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGz88XsdeQSUYIh0RiFf8IMEWQH9oNR08+ryQh0Gmnw=;
 b=oFHyd6vvA8CRGG2ZS9SPgB7u3baOReOPV4ipp2C2CrXfDhNMmeaDdyGd7FtRi2l4azO4MaSVeCzYKa70NCAJqzrp9Df5mea71mr6RahCHcwARAgWxihBbMTbyjPVcraAD5AhTB9ZW5BnTJqkXUkv5pM9fkYys6aUnPpFttgv1xQ=
Received: from BN6PR1201CA0012.namprd12.prod.outlook.com
 (2603:10b6:405:4c::22) by DM6PR12MB4282.namprd12.prod.outlook.com
 (2603:10b6:5:223::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.24; Tue, 21 Jan
 2020 02:22:13 +0000
Received: from CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::202) by BN6PR1201CA0012.outlook.office365.com
 (2603:10b6:405:4c::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19 via Frontend
 Transport; Tue, 21 Jan 2020 02:22:13 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT038.mail.protection.outlook.com (10.13.174.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2644.19 via Frontend Transport; Tue, 21 Jan 2020 02:22:12 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 20 Jan
 2020 20:22:11 -0600
Received: from rico-code.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Mon, 20 Jan 2020 20:22:09 -0600
From: Tianci Yin <tianci.yin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: fix VRAM partially encroached issue in GDDR6
 memory training(V2)
Date: Tue, 21 Jan 2020 10:22:05 +0800
Message-ID: <20200121022206.5223-1-tianci.yin@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(39860400002)(396003)(136003)(428003)(199004)(189003)(81156014)(8676002)(81166006)(8936002)(316002)(5660300002)(336012)(44832011)(54906003)(1076003)(6666004)(186003)(356004)(7696005)(4326008)(478600001)(86362001)(70586007)(2906002)(26005)(70206006)(2616005)(36756003)(426003)(6916009);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4282; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf0334a7-3f3b-44bc-9e46-08d79e18b9c6
X-MS-TrafficTypeDiagnostic: DM6PR12MB4282:
X-Microsoft-Antispam-PRVS: <DM6PR12MB428263BCC137BB854B827BFF950D0@DM6PR12MB4282.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-Forefront-PRVS: 0289B6431E
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jkchzBwlOHB0AvCROJvh96TE1uZZKbYEyWsFHMxsr6za8Pdj6BVuAmT2XC8lh9dqjf9jFkYKefs8gYpgKnClUarytqAgE9BIUyO0ZEO6AjOJr17zvZdpk2ibVanUyuvt1/K3OZSFma5v0HUWBYDuHACVwCmVIdyFDqm/dU+h33Zal0T6ZZilrka1kh/4bpUXI1gS6JgicyuCbo1JeJrC5/41MRocWOzFV7Pndmxz0uZ8DAacJq3Zuq/P3MDI7lz3XhX9kFOK54rw8Twu+Rqb8D3UbP0LzJNHSTQukTyIdms2vjn8qFxieeC0UA41khnPOWme/RHezBzGcOJLRg9n42ZTVTDO2TiSQd3ZB2bH0HSXbFqT982c7ADAEuORLznWGQZapyHXtTAeKOsLDfQRK/gYxCCXT986VRG+qwH5l1dFsdpSR3E1M4dVj+w3seMb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2020 02:22:12.7818 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf0334a7-3f3b-44bc-9e46-08d79e18b9c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4282
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

[why]
In GDDR6 BIST training, a certain mount of bottom VRAM will be encroached by
UMC, that causes problems(like GTT corrupted and page fault observed).

[how]
Saving the content of this bottom VRAM to system memory before training, and
restoring it after training to avoid VRAM corruption.

Change-Id: I04a8a6e8e63b3619f7c693fe67883b229cbf3c53
Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  2 ++
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c  | 36 ++++++++++++++++++++++---
 2 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 3265487b859f..611021514c52 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -172,6 +172,8 @@ struct psp_dtm_context {
 #define MEM_TRAIN_SYSTEM_SIGNATURE		0x54534942
 #define GDDR6_MEM_TRAINING_DATA_SIZE_IN_BYTES	0x1000
 #define GDDR6_MEM_TRAINING_OFFSET		0x8000
+/*Define the VRAM size that will be encroached by BIST training.*/
+#define GDDR6_MEM_TRAINING_ENCROACHED_SIZE	0x2000000
 
 enum psp_memory_training_init_flag {
 	PSP_MEM_TRAIN_NOT_SUPPORT	= 0x0,
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index 685dd9754c67..ac173d2eb809 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -971,10 +971,13 @@ static int psp_v11_0_memory_training_init(struct psp_context *psp)
  */
 static int psp_v11_0_memory_training(struct psp_context *psp, uint32_t ops)
 {
-	int ret;
-	uint32_t p2c_header[4];
 	struct psp_memory_training_context *ctx = &psp->mem_train_ctx;
 	uint32_t *pcache = (uint32_t*)ctx->sys_cache;
+	struct amdgpu_device *adev = psp->adev;
+	uint32_t p2c_header[4];
+	uint32_t sz;
+	void *buf;
+	int ret;
 
 	if (ctx->init == PSP_MEM_TRAIN_NOT_SUPPORT) {
 		DRM_DEBUG("Memory training is not supported.\n");
@@ -989,7 +992,7 @@ static int psp_v11_0_memory_training(struct psp_context *psp, uint32_t ops)
 		return 0;
 	}
 
-	amdgpu_device_vram_access(psp->adev, ctx->p2c_train_data_offset, p2c_header, sizeof(p2c_header), false);
+	amdgpu_device_vram_access(adev, ctx->p2c_train_data_offset, p2c_header, sizeof(p2c_header), false);
 	DRM_DEBUG("sys_cache[%08x,%08x,%08x,%08x] p2c_header[%08x,%08x,%08x,%08x]\n",
 		  pcache[0], pcache[1], pcache[2], pcache[3],
 		  p2c_header[0], p2c_header[1], p2c_header[2], p2c_header[3]);
@@ -1026,11 +1029,38 @@ static int psp_v11_0_memory_training(struct psp_context *psp, uint32_t ops)
 	DRM_DEBUG("Memory training ops:%x.\n", ops);
 
 	if (ops & PSP_MEM_TRAIN_SEND_LONG_MSG) {
+		/*
+		 * Long traing will encroach certain mount of bottom VRAM,
+		 * saving the content of this bottom VRAM to system memory
+		 * before training, and restoring it after training to avoid
+		 * VRAM corruption.
+		 */
+		sz = GDDR6_MEM_TRAINING_ENCROACHED_SIZE;
+
+		if (adev->gmc.visible_vram_size < sz || !adev->mman.aper_base_kaddr) {
+			DRM_ERROR("visible_vram_size %llx or aper_base_kaddr %p is not initialized.\n",
+				  adev->gmc.visible_vram_size,
+				  adev->mman.aper_base_kaddr);
+			return -EINVAL;
+		}
+
+		buf = vmalloc(sz);
+		if (!buf) {
+			DRM_ERROR("failed to allocate system memory.\n");
+			return -ENOMEM;
+		}
+
+		memcpy_fromio(buf, adev->mman.aper_base_kaddr, sz);
 		ret = psp_v11_0_memory_training_send_msg(psp, PSP_BL__DRAM_LONG_TRAIN);
 		if (ret) {
 			DRM_ERROR("Send long training msg failed.\n");
+			vfree(buf);
 			return ret;
 		}
+
+		memcpy_toio(adev->mman.aper_base_kaddr, buf, sz);
+		adev->nbio.funcs->hdp_flush(adev, NULL);
+		vfree(buf);
 	}
 
 	if (ops & PSP_MEM_TRAIN_SAVE) {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
