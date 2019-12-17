Return-Path: <SRS0=JueS=2H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A81C43603
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Dec 2019 11:23:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D01612072D
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Dec 2019 11:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VYo5avCI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D01612072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7491F6E987;
	Tue, 17 Dec 2019 11:23:49 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5C5B6E987
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Dec 2019 11:23:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V3Wk027UPIKi58O0pKNHRzOw8D/3zw+lz6nHRmnIOBIguIbdP51e7EcAmr9ao++H9Whpahz8xDkmibeueAreXChpo0jjFbeYAipwNez6SnSStR29M6VtRlrtmS9+VB50/tueLElkefwsSRP9Oa5UonDNUweJ7UgEU06CO+YObzssmhbQN8qg7u3OG1tUqstRqITTu3wQ4qTqzx+ARLPtyh+A45/wGVqiiVr9j9XfA9IOlTpl87JEwgPbUdJ0QNQNBC83s5QT1Q91ez8Qz1haLi7lD6d3/h9K+DlOGEcXYX6vBcKDQF+pou2wR+Nqe8S3bWHKh/Je5lHMC3+LZJT4PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pMuq5u3PNfmfPdTChgucZlGHwXaBJyBZLvvppm/RtsM=;
 b=HF/MtRI4sOBwYXgZKrGsfcg2kA1MOnW4YXoaXQBs0SYM51/I8cG6PXf7Kaod2cTec6gXXJXh20cCU7k/YyJQ3RxZ9F5DC4H1Hvr22pHH/Wh8kTUpA7Dr9RBla+8JZOZXPgsw2t+2kXbvOY1yhUYxyKHmDgwVDuTg+tEIRf0NezPBLYH2KZjtgfuXCaGAPMBXbGK7JXTB4Whi8b7NE8XgtIJFHR2OoxNcZV1opBFjoZIc7szqGRwzbaPMokyvhoqE6BfdpStkdIMolNP42Eo/cgcreUyLwr9YlYXLLP8uB2c2L3EfWriDOiQ0MVJTBSeqYhU3xrWo1Um7Fm9RRKWKWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pMuq5u3PNfmfPdTChgucZlGHwXaBJyBZLvvppm/RtsM=;
 b=VYo5avCIERVA469b2Y8C0Vk+lrvLU6ZQL6mBx3AMMwZLudw+uwUn3pWhhotMfHQTBMRJ37VRdIBA6ux+oqrxwU80Q92V7HuR/rxBHF1iTLgvKKy80Va50+ngJy+DOvraAuev1/+2fCSthHrbypMG0Gvh9qmZqgE7zkyhVkZAwGA=
Received: from MN2PR12CA0011.namprd12.prod.outlook.com (2603:10b6:208:a8::24)
 by CY4PR12MB1398.namprd12.prod.outlook.com (2603:10b6:903:40::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.19; Tue, 17 Dec
 2019 11:23:45 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::200) by MN2PR12CA0011.outlook.office365.com
 (2603:10b6:208:a8::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.16 via Frontend
 Transport; Tue, 17 Dec 2019 11:23:45 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2538.14 via Frontend Transport; Tue, 17 Dec 2019 11:23:44 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 17 Dec
 2019 05:23:30 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 17 Dec
 2019 05:23:30 -0600
Received: from rico-code.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Tue, 17 Dec 2019 05:23:27 -0600
From: Tianci Yin <tianci.yin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: remove memory training p2c buffer reservation
Date: Tue, 17 Dec 2019 19:23:22 +0800
Message-ID: <20191217112322.20042-2-tianci.yin@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191217112322.20042-1-tianci.yin@amd.com>
References: <20191217112322.20042-1-tianci.yin@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(376002)(39860400002)(346002)(428003)(189003)(199004)(54906003)(81166006)(5660300002)(81156014)(478600001)(8936002)(316002)(2616005)(36756003)(426003)(336012)(6916009)(86362001)(6666004)(356004)(70586007)(2906002)(4326008)(44832011)(1076003)(8676002)(186003)(26005)(7696005)(70206006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1398; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e63dea3-332f-4d0d-9712-08d782e393e7
X-MS-TrafficTypeDiagnostic: CY4PR12MB1398:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1398702804FB45F881C6ED9895500@CY4PR12MB1398.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 02543CD7CD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vHVHNNbSZNbw14foreY8K8GOVo/kMLf7UrYtuvlEAUYoo+Rw5YXBAIXzXQEpcEXUw++E9j+zOzXk60077Dtqqd4b2iZW43mSY7JK5IqQOmBlolvTd887+9Q+aCjG3UQok0otq7M2o3ti4rMYbZ6qV1y/eA/sglmdhXZDttq67xF/RvZ6PjzWwdkB0aKyIyPRKjk3wQW7D6aspdKdvIMAgsyEMbqnTgm7ceRCm8AV0DnP5CU5h35ghIEgAcJVjhSmQRINBGJ8Ebd0oKa2EzbnesWqrgyyts7TBl0cvali+zs+Qnb9C9jA+BCKqelQwtLvQr/KKwVQRBYNY3g5ShsloNuqQNSN32owQJuX0J1ttxxQplOY18CTJURiA3H6gXjaan3NMUo0I2tP4UsE93yRk+2kBTrtTGhqqyQ3TQNXfWK4biiWtx10i7peAy33Tr3r
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2019 11:23:44.5208 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e63dea3-332f-4d0d-9712-08d782e393e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1398
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
Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 14 --------------
 2 files changed, 15 deletions(-)

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
index ce5cb854bdb9..6f0ad1d1d4d7 100644
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
 
@@ -1718,17 +1715,6 @@ static int amdgpu_ttm_training_reserve_vram_init(struct amdgpu_device *adev)
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
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
