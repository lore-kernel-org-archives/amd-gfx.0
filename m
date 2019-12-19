Return-Path: <SRS0=793y=2J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C224C43603
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2019 03:00:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3BE6222C2
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2019 02:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="EyAgiRkW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3BE6222C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAE9D6E072;
	Thu, 19 Dec 2019 02:59:58 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 505B66E072
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Dec 2019 02:59:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HYHi5TH9VKTIaKSt1We38Tz9wdcE9Uiq0aR5ZTYcCHi6/AzN7maQYOElancu2btbLuPZhaf82kzWB4XoK1nIkZpAK6xmZfjtN0UxwpK3hwUK+MjVnh6z3alCoi476wfWkUqUvjZnWSnwUwFFX3/QKsFWUScB92NiTUFr1nqbbeN6N6h9D1Tx5jJjvpfV4/5VYhxMrAQ4N1rFOSLNGFPSf2vcMe0MJGtM0rvpz/yfAIqlcsiHj8FIjnAPDuUjtJv8mCtGaBYrwalA2w9KiqwQ4UVbZHRgWW4XWn/FuTNxyX9EKaKc66d5JAUxMoCZtIMsm9sJuoDlOczKzTRxE4B3sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DmdN2BPFZxR5MIAhAM9Dqj0ijHctJafkNM8E7XwB0Ig=;
 b=Mf6tgnEEfE9BrkzRArl0XLSqa5UtfobBGzXRLW6UV2TvvaxmWuVWgbYWk3oOBTDCftnKGt0ZE+TRuhLGLMa7fHdtj/QiVNZxG1C2LQSHpC++u15jszfK+ErvMfvJfpy7KZVW10xHNky0H0VBdftAP9tfwaLs0gn59EQzynMXZgMUcKYdyGeoQGQdHGMUuGUId7SgUKozyP1q6Efyeo/V+JnGL8Iv+i0KvSRIkqU2YmNDNDp9oN1cncdZ7Q/9EcjSAJynMqFu4D8V4VV3maPxHdsBGk3+cj9t+bRxnB/cmgs5kD5XVaWmSDHD078uB1XuVgVfgDAHCx2MiwCyDfZQbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DmdN2BPFZxR5MIAhAM9Dqj0ijHctJafkNM8E7XwB0Ig=;
 b=EyAgiRkW079uvo2kLvS46/T5muc/WqqPN6mDHhCRQNynuJ2CVSfEHqjfsaa9O+q0Sa+nlaiz/Y7NWYmbVZ7XDKX8pXvabn76IDypX1EpGkfld17O3xenBJbewteRFN3KlM81dmERJ3YJ+R7K+wpJ0HWPvDQe6pb6BTFR5nOmPM8=
Received: from DM5PR12CA0004.namprd12.prod.outlook.com (2603:10b6:4:1::14) by
 MN2PR12MB4110.namprd12.prod.outlook.com (2603:10b6:208:1dd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.13; Thu, 19 Dec
 2019 02:44:33 +0000
Received: from DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::201) by DM5PR12CA0004.outlook.office365.com
 (2603:10b6:4:1::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.14 via Frontend
 Transport; Thu, 19 Dec 2019 02:44:33 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT055.mail.protection.outlook.com (10.13.173.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2538.14 via Frontend Transport; Thu, 19 Dec 2019 02:44:32 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 18 Dec
 2019 20:44:32 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 18 Dec
 2019 20:44:31 -0600
Received: from rico-code.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 18 Dec 2019 20:44:27 -0600
From: Tianci Yin <tianci.yin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: remove memory training p2c buffer
 reservation(V2)
Date: Thu, 19 Dec 2019 10:44:16 +0800
Message-ID: <20191219024416.32321-2-tianci.yin@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191219024416.32321-1-tianci.yin@amd.com>
References: <20191219024416.32321-1-tianci.yin@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(376002)(136003)(346002)(428003)(199004)(189003)(2906002)(356004)(6666004)(81156014)(81166006)(426003)(2616005)(186003)(36756003)(4326008)(86362001)(54906003)(26005)(316002)(8676002)(336012)(8936002)(7696005)(1076003)(6916009)(70206006)(44832011)(478600001)(5660300002)(70586007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4110; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d582deb8-a33d-411b-4296-08d7842d6106
X-MS-TrafficTypeDiagnostic: MN2PR12MB4110:
X-Microsoft-Antispam-PRVS: <MN2PR12MB411097C10324974FD784E1D495520@MN2PR12MB4110.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0256C18696
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ey+oKa/vtnKZ/1A4eLytu4zDQq7//7uOi5ApI5nkrX6M43f3REZ1qMf3OXpSQRUUNsYhToEAqeEgP94zPsT2kFkOZRkXuXuwIb2XvUu2mw4hED6mwYZAk9SfuT7uREa0699UyboNPeXe0iwhFbwH59TaTFDOYvCZWZS5y14Mp5dwmQnEaTZdwNoEr+Tao/xbKSmEDryquR5rqFxQSxZgc3gRsLdTnMTsVzHSvHAXS1RzCrof/vJrqzbCxe6isQ2+1AoV8rDEGRMOQPvtmKCSNgErCs0NCkZRf2amp0mLIfcaSomySEHzbJN96gW/YeZqJGLGpIUe7Jv2gZH7LR4179Jt6Yg060X3EvN9bV4RjGFEJULAts6rQN4kPNLyo03L+Bi9HJrCnxpJ377mD4xC3ZWYQJ1jjClLBG2idwaCyn7e9A0rIZUseTSfzwbfYf/E
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2019 02:44:32.8176 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d582deb8-a33d-411b-4296-08d7842d6106
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4110
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

IP discovery TMR(occupied the top VRAM with size DISCOVERY_TMR_SIZE)
has been reserved, and the p2c buffer is in the range of this TMR, so
the p2c buffer reservation is unnecessary.

Change-Id: Ib1f2f2b4a1f3869c03ffe22e2836cdbee17ba99f
Reviewed-by: Kevin Wang <kevin1.wang@amd.com>
Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 21 ++-------------------
 2 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 5f8fd3e3535b..3265487b859f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -202,7 +202,6 @@ struct psp_memory_training_context {
 
 	/*vram offset of the p2c training data*/
 	u64 p2c_train_data_offset;
-	struct amdgpu_bo *p2c_bo;
 
 	/*vram offset of the c2p training data*/
 	u64 c2p_train_data_offset;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index ec84acdd43a2..60f17e989014 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1681,9 +1681,6 @@ static int amdgpu_ttm_training_reserve_vram_fini(struct amdgpu_device *adev)
 	amdgpu_bo_free_kernel(&ctx->c2p_bo, NULL, NULL);
 	ctx->c2p_bo = NULL;
 
-	amdgpu_bo_free_kernel(&ctx->p2c_bo, NULL, NULL);
-	ctx->p2c_bo = NULL;
-
 	return 0;
 }
 
@@ -1725,17 +1722,6 @@ static int amdgpu_ttm_training_reserve_vram_init(struct amdgpu_device *adev)
 		  ctx->p2c_train_data_offset,
 		  ctx->c2p_train_data_offset);
 
-	ret = amdgpu_bo_create_kernel_at(adev,
-					 ctx->p2c_train_data_offset,
-					 ctx->train_data_size,
-					 AMDGPU_GEM_DOMAIN_VRAM,
-					 &ctx->p2c_bo,
-					 NULL);
-	if (ret) {
-		DRM_ERROR("alloc p2c_bo failed(%d)!\n", ret);
-		goto Err_out;
-	}
-
 	ret = amdgpu_bo_create_kernel_at(adev,
 					 ctx->c2p_train_data_offset,
 					 ctx->train_data_size,
@@ -1744,15 +1730,12 @@ static int amdgpu_ttm_training_reserve_vram_init(struct amdgpu_device *adev)
 					 NULL);
 	if (ret) {
 		DRM_ERROR("alloc c2p_bo failed(%d)!\n", ret);
-		goto Err_out;
+		amdgpu_ttm_training_reserve_vram_fini(adev);
+		return ret;
 	}
 
 	ctx->init = PSP_MEM_TRAIN_RESERVE_SUCCESS;
 	return 0;
-
-Err_out:
-	amdgpu_ttm_training_reserve_vram_fini(adev);
-	return ret;
 }
 
 /**
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
