Return-Path: <SRS0=4PMp=2I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8AA8C2D0C3
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Dec 2019 08:51:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B985E21582
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Dec 2019 08:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nTrGjLEf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B985E21582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E7986E26F;
	Wed, 18 Dec 2019 08:51:03 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700060.outbound.protection.outlook.com [40.107.70.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77FD16E26F
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Dec 2019 08:51:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=enYftO3Bya6/vZGKYaKwvZOzFLD7NJohwApT5wp2YC+svG3iB43xvx/LHYZxajBgLHU5tJl7H6b+W7V6QhNkpbOjJZvBH+4Fm+0JqU72Lr5flRCgT3HggZIxZHwS9jCeJFiAHyVHa15rFNfvuwnTak8riNZiXUOnlweWsHwXOit6JzpQhwxHOveAIgDIXyCPZjeHB2qcjkn+JQOo+Vi4j7z3L/YWH5y/qpHlZ5U10RgpTUZ/4nkSGo66JvfITLzsWJLArMnuHCbpizpuuf/twA/LsmQ0kXNuLhdSEgFzKLbvH9E0+hh7ftB8IFS7JqOjf5dkrHN6spOuKZM6v7y0Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BzmqbRykaKZVpemPURTXeWxDHUQ2tSAyPIk4ItleN04=;
 b=ZpUkdDwZk32r1WkyhhdJgtiRuH6k/GBuP7Gca9IsDfDlLqRLKDH+GNwvNN9hySebT4ZMOjrw6lAIwYHQr3HKX7oI/8KFBduH8/MfaE7I6LgtRjRT/sKb+rvwuxi4EIcz0fmhgHBkNO4LBLUAwZu7ITGSn81mIf7XZ1kcdJA+G/7BdpuTXIgIOv/2vh7FPED/PbwMtZz7mMBLy3dJwwSuKTK6ABKW/fgCN9PnJ+UO6zCL8VFY6RU9eR43z6UeFxWmSZW9k27F3RFmkSRd34Lj8zelL8KZWzUdzyBuSz4W8fFstadEqHITa5RpMTLKMX7puSjpB2bVAJpOWuPigQ62og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BzmqbRykaKZVpemPURTXeWxDHUQ2tSAyPIk4ItleN04=;
 b=nTrGjLEf+A0LEkeKrdpkRe4l7vrP0slr5U+34ZlsfvTGSuN52UqUUsNOO9uYaMrga3vF/41Iqz2Jxi1Zi1jWIArAyLofwYE7IbVNVkX5Gl0zUUzp8c1l0IKM5yVD3RYOrSUkLKhUSsRpkKd4lezuOX+Qd1N0anNiwVPdJtxITc8=
Received: from BN4PR12CA0006.namprd12.prod.outlook.com (2603:10b6:403:2::16)
 by DM5PR12MB1162.namprd12.prod.outlook.com (2603:10b6:3:72::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.18; Wed, 18 Dec
 2019 08:51:00 +0000
Received: from DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::202) by BN4PR12CA0006.outlook.office365.com
 (2603:10b6:403:2::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.14 via Frontend
 Transport; Wed, 18 Dec 2019 08:51:00 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT028.mail.protection.outlook.com (10.13.173.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2538.14 via Frontend Transport; Wed, 18 Dec 2019 08:50:59 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 18 Dec
 2019 02:50:59 -0600
Received: from rico-code.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 18 Dec 2019 02:50:56 -0600
From: Tianci Yin <tianci.yin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: remove memory training p2c buffer
 reservation(V2)
Date: Wed, 18 Dec 2019 16:50:50 +0800
Message-ID: <20191218085050.28635-2-tianci.yin@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191218085050.28635-1-tianci.yin@amd.com>
References: <20191218085050.28635-1-tianci.yin@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(428003)(189003)(199004)(70206006)(336012)(186003)(356004)(426003)(86362001)(2906002)(36756003)(70586007)(1076003)(7696005)(6666004)(26005)(5660300002)(498600001)(6916009)(44832011)(54906003)(2616005)(4326008)(81156014)(8676002)(81166006)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1162; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 951b65cb-1fc7-494d-ca1d-08d7839767b1
X-MS-TrafficTypeDiagnostic: DM5PR12MB1162:
X-Microsoft-Antispam-PRVS: <DM5PR12MB116245DAD9CCFBC47DE1EC2D95530@DM5PR12MB1162.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0255DF69B9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZAfnZ3K3AVsOrxKbSDVyccraip7LZSQXEZXmomwisinWzyYZuUzx73j3JxehTjPVvQTnqUqNBy3ByRHeV1RYojpJ961S0Vg8VxEmevE+BlQ1rW/uerSzZafli+irOQ/zRg2w1GLAijEGZ1u7ue+kj1JRIUorWdzsdNEuwFZvFLKPeZYEE+Kyt/3lTV8fQgb1iTFdNWSsFbm1A4/H3onQ9PCP19RjJ01FkP2kPUDGtktTJYAV0XaTbM65Q/29AVvtYKphGQo9LGSxOE/SlGwkIOnCHNoDfZixWVPHqw4U4vymGrsmG7h0wApa27KOzgnG1AtLK0/U0pBNFnEXbD5fc7sGUGY+P1XodzfmNOvEQZDHBpxSb7Xzlx9BWnCQ/uQZqKsTQIDZYG4y0f4Vn04HEdkEyYMgT9wAAbMdGWqxLec97xb90GTv38f5XwW7Om71
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2019 08:50:59.8349 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 951b65cb-1fc7-494d-ca1d-08d7839767b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1162
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
