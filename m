Return-Path: <SRS0=Seja=5K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF74C54FD0
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 10:19:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4DA920714
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 10:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fYY8DjCg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4DA920714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 573D689257;
	Wed, 25 Mar 2020 10:19:41 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750077.outbound.protection.outlook.com [40.107.75.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B71F089257
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2020 10:19:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E8bvVGnC3RMC79PQTDqrnpjeX+gn435/rLrb6f36OMy6JfpEnulOworYZR0VF4Cnyw6+Jb6M2KiXgWYzL6PuIoDOlxUV/QWs+zt6n5DHEYp7ytEnSB+bjO4/DiwjUV7I4bpTFoZo+xMD+8TjmsKCFqp/Trj78uPZ/APwibLmhU/kt+U7g1dUzVHzqTyFstQi60NNNNkT9AUnuRoxn2XugZnGin+PjdvK+HvgnU2C0n7soDmXGzi5FJBCdCr0/cJNdHpisA5vT5UCIIz+iGs5GWBETxbIOI5Prx5xixOG2DC+TH0yymdi415IJn96koHjkTujWzpDTg3unEE63b2UEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LjehLASocQZ9OieeAkXkEnN/DUQJ08wMFkG6xD40yYg=;
 b=VJFvGpog3xo+JJ0olsU445ci0EFYoJxhkBOGHV3SXB1EwObsL97J0v3kvpVk4k0w/LoKe+ezk8KE2m9mlNgUvko/a+h5MJ0t3rqtS12CHe1egGFvy8VudHKNyVi8U6tvVwRgzI4IPyF4vT6XrAvtnyPaqfHM5Rd21mH5jnYtGvSe5Vz4EQNmIwQvtE+pfHzYRv+wP3hBAJXumKDx2JGQnLNqqnpez5iejTdq3KbORXDllO7Grasy5McrorlYnaxBtovXeN1y+8VGuXAHcBOhVwJtGrIYyX4RkLewDFW9kAL5hnc0dfJ7w/E+Wlzm/Q6+94+cTfz54UYxYzGJRCVNSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LjehLASocQZ9OieeAkXkEnN/DUQJ08wMFkG6xD40yYg=;
 b=fYY8DjCg0x/NMsWWi7sB6QWCP98SmNnh/KEap+HuQ4Li9p7ZoNux0q5Kjpv+QBVcFwseWuphSALC8d3jQ0WCo+Qw5AHYs/5ouKvHnDTbzzbjrXmhpU8Zq215bhQgh0wo+O/UFgBGw8D5lcfblBA+pLcvOziQUGnCUZc9XFzvCvY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Kevin1.Wang@amd.com; 
Received: from MN2PR12MB3296.namprd12.prod.outlook.com (2603:10b6:208:aa::11)
 by MN2PR12MB4389.namprd12.prod.outlook.com (2603:10b6:208:262::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20; Wed, 25 Mar
 2020 10:19:38 +0000
Received: from MN2PR12MB3296.namprd12.prod.outlook.com
 ([fe80::d96e:c154:8fdc:3fb0]) by MN2PR12MB3296.namprd12.prod.outlook.com
 ([fe80::d96e:c154:8fdc:3fb0%6]) with mapi id 15.20.2835.023; Wed, 25 Mar 2020
 10:19:38 +0000
From: Kevin Wang <kevin1.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: fix hpd bo size calculation error
Date: Wed, 25 Mar 2020 18:18:48 +0800
Message-Id: <20200325101848.8524-1-kevin1.wang@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK2PR02CA0170.apcprd02.prod.outlook.com
 (2603:1096:201:1f::30) To MN2PR12MB3296.namprd12.prod.outlook.com
 (2603:10b6:208:aa::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kevin-kaka-kvm.amd.com (180.167.199.188) by
 HK2PR02CA0170.apcprd02.prod.outlook.com (2603:1096:201:1f::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.20 via Frontend Transport; Wed, 25 Mar 2020 10:19:35 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.188]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6152aab4-aa74-4888-7835-08d7d0a605bd
X-MS-TrafficTypeDiagnostic: MN2PR12MB4389:|MN2PR12MB4389:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB43896A851E982E2A8A143068A2CE0@MN2PR12MB4389.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:862;
X-Forefront-PRVS: 0353563E2B
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(39860400002)(136003)(396003)(366004)(346002)(26005)(5660300002)(956004)(81156014)(2616005)(52116002)(8676002)(86362001)(81166006)(8936002)(7696005)(6916009)(478600001)(66946007)(4326008)(66556008)(66476007)(6486002)(2906002)(1076003)(316002)(16526019)(6666004)(186003)(36756003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4389;
 H:MN2PR12MB3296.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oXa0xyXqb5sI4ymnRt8n0nEgcuKSyDgigIl4gnHXtHFxqHaqknczS/0he0zKdqPPEg73f8bcyegiPEPgqXe2DBczvzEViMkyYAGtWX7ijJJVmZivUzdFMGwKoZlzeFhjm6Nv+YqIxJ+axJenjbB4so2A1DLSgGUqvP1g5GBQ0j+OKTOO1Wnduzz1Y2uRGr/TzRdFPACma6FjTcwiyA7GVe5l2nXq6daRGX6Zfq77+QYXBEjH9HSXN6iFjPR6zZeIPS4y6gl2scNBB0Wqqj7GJokU6+QCDGYaAu/5rWj92nFkl97cmDG+rkrowYh4IVSGDgKSYro5OdX+pxAcrWz7AuaCfbqGn3NmqTF6bYRP5IrVzLBlMR7V0RBzyd/kyRyxFhcE3Roj1nlNlzt18l9lxUj9DfRJ2iBLfkBGfC5oHUrhBtqtEBywvPAX/zkmoxdp
X-MS-Exchange-AntiSpam-MessageData: iaRrgDIvtf483eT2Hr0x6kFStkHprJFViV7MkicLTbQwJCcklmvWGZ04BtomLKDbDWZYuxEybG9C99mHFrUJ+wBWaIMbPRb8boiKCFLomTKFgSF0Pyx6mzj63+8gFOdKkg6RxeCtbYUQdtMnCHrxoA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6152aab4-aa74-4888-7835-08d7d0a605bd
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2020 10:19:38.0853 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D7HYRIOXXshj5PtCqU5i6Tz4oKr3VcKN87a7qqGovItiEuVPBLeNtyz9n4R8Q3iW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4389
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
Cc: Alexander.Deucher@amd.com, Kevin Wang <kevin1.wang@amd.com>,
 Kenneth.Feng@amd.com, christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

the HPD bo size calculation error.
the "mem.size" can't present actual BO size all time.

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 7f9ac1a14e6f..91c82383b016 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -1113,7 +1113,7 @@ static int gfx_v10_0_mec_init(struct amdgpu_device *adev)
 		return r;
 	}
 
-	memset(hpd, 0, adev->gfx.mec.hpd_eop_obj->tbo.mem.size);
+	memset(hpd, 0, mec_hpd_size);
 
 	amdgpu_bo_kunmap(adev->gfx.mec.hpd_eop_obj);
 	amdgpu_bo_unreserve(adev->gfx.mec.hpd_eop_obj);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index fb567cf5671b..01b22dad52fd 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1946,7 +1946,7 @@ static int gfx_v9_0_mec_init(struct amdgpu_device *adev)
 		return r;
 	}
 
-	memset(hpd, 0, adev->gfx.mec.hpd_eop_obj->tbo.mem.size);
+	memset(hpd, 0, mec_hpd_size);
 
 	amdgpu_bo_kunmap(adev->gfx.mec.hpd_eop_obj);
 	amdgpu_bo_unreserve(adev->gfx.mec.hpd_eop_obj);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
