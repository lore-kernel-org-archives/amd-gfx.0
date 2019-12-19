Return-Path: <SRS0=793y=2J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB87C43603
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2019 09:16:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E197F21D7D
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2019 09:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="a/ePWfiW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E197F21D7D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 964C16EAE4;
	Thu, 19 Dec 2019 09:16:38 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770047.outbound.protection.outlook.com [40.107.77.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 282A86EAE6
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Dec 2019 09:16:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ji6NK3Sdu3QR65JLpVBlyROT3WX2HCtZCO2/vNc3CuCvaGp2yGZRbGDk4V04QR4zTmx5ymTo0doCOJ2nW6eIXU/AkQa0BlgE4VK5bFolp3Brw40TFI+YmjH2UsoVuRSDnt31dhZYVYpCYslbaKeWakJVIlzmWmn2Cim1PQD5BljQYR5HscIe+684Pdc7JZi7gEnWssCln3Lq7xrNRXP4t3jNhfow9x4eUVCqtmQmOvtqnzAr+vmodcRT8kT1RxNYhNhsL/eoYzFFUpsX8/Tn9EwSREFz4dWadhOs8KJcZVD0kkjJwMg6I2+T7nJXCNhEtkxuDLt2cmgIQiSTe4ee7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sv9cA89K9nuA/VzxxrPiYV5JVmCeUJCUvAeiwzPWdJ8=;
 b=CjwF0OUU/7oscvpPvZB9u49hvoB3NLgEiqHDaz9Nh/sD3hxrHiQ3ZXzzbGlJV6W1YSsN18zK557XYwG8VQTuvuiphhPVc8/xhthpPL6nDBjk+OQm7AMTAZdfzC8ClRIAsGw2KxudCerqXDXcgiuD7Rqjk4Kc57LK7VdOIjxKyNfvFHOOr+VoXyeKrw6Jx2ZqdiEjHVIVKOBwUhv9Bm2MFCzQG67BaCplWYgUKbarW0QDk4obF1/5NLeBNs13NH0QxfnHfkrAATIoR2uTCaYQKXHWkhE0HXOpnVkxF1bNRVdljtbrEVY9CFN1lA3DWZIn5rXFjfoP/g4rQyWXPiiH6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sv9cA89K9nuA/VzxxrPiYV5JVmCeUJCUvAeiwzPWdJ8=;
 b=a/ePWfiWqgvewYrECh4IJUM5EiCex2/ntBNTYi2JIvSbSBzQv0+wd31VEVF9iKY7ZcfPu7GJ4ciguBIgmjI3FOejZ5qyNw2Q9IsTtQZme0PZRAdrq69WLoWfhK1UNER90jf56hseOHLZ9ko0nqKsGpmmvqZRJoDRVduW30uEIVw=
Received: from DM5PR12CA0023.namprd12.prod.outlook.com (2603:10b6:4:1::33) by
 BN6PR12MB1601.namprd12.prod.outlook.com (2603:10b6:405:8::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Thu, 19 Dec 2019 09:16:33 +0000
Received: from CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::200) by DM5PR12CA0023.outlook.office365.com
 (2603:10b6:4:1::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.13 via Frontend
 Transport; Thu, 19 Dec 2019 09:16:33 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT003.mail.protection.outlook.com (10.13.175.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2559.15 via Frontend Transport; Thu, 19 Dec 2019 09:16:32 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 19 Dec
 2019 03:16:32 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 19 Dec
 2019 03:16:31 -0600
Received: from rico-code.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 19 Dec 2019 03:16:28 -0600
From: Tianci Yin <tianci.yin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: remove memory training p2c buffer
 reservation(V2)
Date: Thu, 19 Dec 2019 17:16:23 +0800
Message-ID: <20191219091623.3922-2-tianci.yin@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191219091623.3922-1-tianci.yin@amd.com>
References: <20191219091623.3922-1-tianci.yin@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(346002)(376002)(39860400002)(428003)(189003)(199004)(81156014)(316002)(5660300002)(86362001)(4326008)(54906003)(81166006)(6916009)(478600001)(36756003)(7696005)(426003)(8676002)(1076003)(8936002)(44832011)(6666004)(356004)(2906002)(2616005)(70586007)(26005)(186003)(336012)(70206006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR12MB1601; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16f9082d-f58a-41d9-0097-08d7846423e4
X-MS-TrafficTypeDiagnostic: BN6PR12MB1601:
X-Microsoft-Antispam-PRVS: <BN6PR12MB16018ED93E021E0C56D09B6595520@BN6PR12MB1601.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0256C18696
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3n7bhwUGO+AY0sbdwu5FtubP9dycDwb6XlUeVD6bHyzfpTv3uofmE+49mG0X9Hp/J1ArnCC+SWTeddKFR1e3GTUFQfMIU99N1BlVpnxJSRxT/vmJPeI+IHOvJjcjpcyfoW90UPnWf3K8U3seKdKodADZEdBYkUOAZgu2AU1zkhSZB6cCjiA6A2QlTzA5ubluB1VpDS/eiYdisXYVSD6h/ATsV7QnfhJfQhqwUnMzDaSfXmh+xpMTJdxOqu4Ls6BRZ/z771Bbc7LH8erimOjkjxQ1e0sA2WkXbnUdlTpJn0NnC6ANaptmtgt5dHUarc1o6sYdmXzCKnvuLUb2E9gLiKyt9mKjB9/6zBHNgztZP6Z/MaFZzPirg6g/oSX3cgWEFBIih07ift6ZJLr/vgaTdvKJyHVgzJv6gI9YGY5Ge4cf1ah0WLSql0KHvSNxOiL+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2019 09:16:32.8395 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16f9082d-f58a-41d9-0097-08d7846423e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1601
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
Reviewed-by: Xiaojie Yuan <xiaojie.yuan@amd.com>
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
index 1515413fd356..1aab4e349bc8 100644
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
 
@@ -1722,17 +1719,6 @@ static int amdgpu_ttm_training_reserve_vram_init(struct amdgpu_device *adev)
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
@@ -1741,15 +1727,12 @@ static int amdgpu_ttm_training_reserve_vram_init(struct amdgpu_device *adev)
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
