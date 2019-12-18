Return-Path: <SRS0=4PMp=2I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C38ACC43603
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Dec 2019 02:21:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 991FC20716
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Dec 2019 02:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Oj/I7jM1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 991FC20716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27D516E21F;
	Wed, 18 Dec 2019 02:21:43 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1C846E21F
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Dec 2019 02:21:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IBQF/IkyntsAt7bh0hh4Hm+/GRGh982NLxPcyHFkv3+xZ2Yh845mCa5kp/S4KZxhNmgNzXqeX5vpKmYFlMI70dCiDd9Lsp/71hZ5zqiuthX3Uyb3vANGYjXqsYiHESM/w/KVdlikupwVD+edSlnduj4O+eWIHc1EFDh7hxoz4y8QEQsv/MOjIQu6LsiuAYfJMI9EnVtwokzxwYHCG0rkHNlPY7jUTspcPXTou2Caa1WJNkV0Pyq0ZVxlRs1VbF0Qml6gHkOJsfpiltq9xM5A4yUoDusKY2MfOCTV7eBomkFWTGQxYhGKkzUNi6O7kbDkKmlkeLpV8DPQs69BwZzw8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BzmqbRykaKZVpemPURTXeWxDHUQ2tSAyPIk4ItleN04=;
 b=MNtxS9MBmDKT0ng5Qzg+OTc1/iZ/voFrlcgVDfdmziE8toSaQV6AE00tKyOyA5gxG7lEFNKS93UpwOI2uETnQBKI6BCrw/MbfMME86RI4T4pEgdAnkeu4vd9oeLE2T2S2ZKZM/xCH6/eCruWQHZ7zhVaMDvW2SHxou0ct2ijMWi28B102aLmC+yDegTHoTv5EIQ84Ot1GzuMimq/gkXjenmrFyL3e/PcJ3W2KRxWvXbmYE+x3BpjABr2m+QO8E6DP5muQsji6FUL+nKfoAMSy4u73ui/8cRkd2ykYR6cwC0sJvR5J8PhdXWyJpAr8laDg074bfRY3IV88LYjqrw/bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BzmqbRykaKZVpemPURTXeWxDHUQ2tSAyPIk4ItleN04=;
 b=Oj/I7jM1QXdhEcyfkgPIkmBDj9aoXpsehWz0manj+wZzK/HetH9K2v2zsQBsbmUAFO/NXW2rCrHeL51toJ0WMOxEMWxlaGLiBG0FKqNkhxOBs7DwI7h5o1Eg4jnnd1yTqux+SnDtnMsbkSoDP2dtx//xvLEhmG9Zjn6w6VO6/qY=
Received: from MWHPR1201CA0001.namprd12.prod.outlook.com
 (2603:10b6:301:4a::11) by CY4PR1201MB0133.namprd12.prod.outlook.com
 (2603:10b6:910:1c::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.14; Wed, 18 Dec
 2019 02:21:40 +0000
Received: from CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::206) by MWHPR1201CA0001.outlook.office365.com
 (2603:10b6:301:4a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.17 via Frontend
 Transport; Wed, 18 Dec 2019 02:21:39 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT041.mail.protection.outlook.com (10.13.174.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2538.14 via Frontend Transport; Wed, 18 Dec 2019 02:21:39 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 17 Dec
 2019 20:21:38 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 17 Dec
 2019 20:21:38 -0600
Received: from rico-code.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Tue, 17 Dec 2019 20:21:34 -0600
From: Tianci Yin <tianci.yin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: remove memory training p2c buffer
 reservation(V2)
Date: Wed, 18 Dec 2019 10:21:26 +0800
Message-ID: <20191218022126.25205-2-tianci.yin@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191218022126.25205-1-tianci.yin@amd.com>
References: <20191218022126.25205-1-tianci.yin@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(396003)(39860400002)(376002)(428003)(189003)(199004)(70206006)(70586007)(2616005)(54906003)(2906002)(4326008)(36756003)(8936002)(44832011)(186003)(7696005)(1076003)(5660300002)(26005)(6916009)(81156014)(86362001)(478600001)(8676002)(81166006)(336012)(356004)(426003)(6666004)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR1201MB0133; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7d22881-d1c0-4bcb-c27a-08d7836103e1
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0133:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB013331071013231981D1F4CA95530@CY4PR1201MB0133.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0255DF69B9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tfr8pC2SGHuMzIv/H0E60hVMWng3Mh1ZnmhhNOOFSYEbMVq0QCf+FEu8EmJxuysyjEjm9RgaMlJMIvKknhNvdmtWYTeRlI5ccLeBa+aur1LdOcst77VI/MBc4hO+dJYa4PWK1Luc4+Y4fYKs5X+gVHJcjJoP11mkQFh8ieSM6TGS/v9bucAKArbtAXXAVMgCIa3ZC6T0LxNBPzi/+osNkU4Ku+DIUEUF6ToDGR0J0aYYhyG8K14ZC2Nf2lLpwydlo93sGFDwdYEEub/t0sjPayOQQmZmq06kXlV0DAt+ryZOtHE5lupf8QLl40wqUTCsAI+7b4nq4EmjM7d2y5f3JhymyPXFmwKH/zj/he0Yyr8W3ERudqK/3nnEyuMRt7YW6/j5tcnd1f1dvdkIGDj1PCzO7bO15irHHsWpAVE9/ZjAFfB35VXQUWy63ek4Skqg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2019 02:21:39.4836 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7d22881-d1c0-4bcb-c27a-08d7836103e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0133
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
index ce5cb854bdb9..476ea4a4dc03 100644
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
@@ -1737,15 +1723,12 @@ static int amdgpu_ttm_training_reserve_vram_init(struct amdgpu_device *adev)
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
