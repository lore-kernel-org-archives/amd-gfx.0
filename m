Return-Path: <SRS0=xcSd=EJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A691DC388F7
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 06:16:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B47722277
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 06:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0GL8h7bB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B47722277
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F02F96E5A3;
	Tue,  3 Nov 2020 06:16:57 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7BD96E5A3
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2020 06:16:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YmK8b4J77S3BW4RlU49igXkHE1ZOByumjwzZOBNibesEbrJQ6GeV5HDZZYU8F+N8KQQ62lowoaoe3aO697QBvfYxiz5rT0y73DZcAsBbMpIXMP1urbZfM3eOZiLVc7CPvldMnfTxlMFlg1JMY3S+1KGg34ta99+57uKJQEMahS+AMj8BE92p/hMrHgFk7ryU1TYUYshQ+yiZEaxEMG2x7dowH6owCdLNi0YifDYKt43aXG0JpBgRgO4Q4/Pb5SV5DOZfAgHiamrfky8Xzp5Q90C/VvMut1mYU+Hut4luchF+9kL8ohhSXtFV6vxL+mA8G6dNo3oJkLKkgWzPJzRxIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cR2/Xq48fZZBNdy1x8Yivw4R87mTTh3mFLRrt62v1Vo=;
 b=Yl18bcw2bLVF3udOB1uKwH2zQ/O1t44ODfgjsvDiA10LE1aWNFu/UPOzkAdILItig8o2XcWJ8q/ThzFJap50goHUrfHNgN63y5pN5qq+5j2vxHBLZ3kcJ8ALplE1+0bK2eUQoOyCCKk7czKefcJsgaidfNrTkXnGdwtr6/unQBKZMQblysuOAmZAzrjjtzEkH6gpRmH7PjCxy6uQCamVI+c8l2mRC6y9xm3qkE9mBgVTAlAiPimxfAbBQiKMm+gemmcoeqVkcVMTCFHR1rF3om2LJTXojQSusprbkhzBmIkAckTwkUr5SifxbZ4LBHXEPALWBe8SR8kkV/C5i/FoWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cR2/Xq48fZZBNdy1x8Yivw4R87mTTh3mFLRrt62v1Vo=;
 b=0GL8h7bB6Brd9GUwhEA3REaNXn6+JpoJNmjROhv+IC2WMPwtsM/GsJYAOuqb+tOZimKKp8VksLL1Zh9FfEpAoHSeFJ+E6sxtshIfPC0rbpAR9HaGs0rmQUjoMZ1RoM5bqAyObdyOEtlTrYvaJkpTSBeI2eqkJKojbMv07okydYY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3467.namprd12.prod.outlook.com (2603:10b6:5:3c::10) by
 DM5PR1201MB0217.namprd12.prod.outlook.com (2603:10b6:4:54::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.29; Tue, 3 Nov 2020 06:16:55 +0000
Received: from DM6PR12MB3467.namprd12.prod.outlook.com
 ([fe80::791c:a3f1:47ad:902e]) by DM6PR12MB3467.namprd12.prod.outlook.com
 ([fe80::791c:a3f1:47ad:902e%4]) with mapi id 15.20.3499.032; Tue, 3 Nov 2020
 06:16:55 +0000
From: "Jinzhou.Su" <Jinzhou.Su@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/3] drm/amdgpu: Enable FGCG for Vangogh
Date: Tue,  3 Nov 2020 14:16:21 +0800
Message-Id: <20201103061621.10549-3-Jinzhou.Su@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201103061621.10549-1-Jinzhou.Su@amd.com>
References: <20201103061621.10549-1-Jinzhou.Su@amd.com>
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR0302CA0015.apcprd03.prod.outlook.com
 (2603:1096:202::25) To DM6PR12MB3467.namprd12.prod.outlook.com
 (2603:10b6:5:3c::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jinzhosu-System-Product-Name.amd.com (58.247.170.242) by
 HK2PR0302CA0015.apcprd03.prod.outlook.com (2603:1096:202::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.10 via Frontend Transport; Tue, 3 Nov 2020 06:16:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3b421ee3-5bb8-47bc-6e96-08d87fc00fd6
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0217:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB021794CD0556DF9E998016AE90110@DM5PR1201MB0217.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UumIvP9zHcvYHW5ZwP82uyJaxPOA07uSxSsym4SRoJCtzgnfoDV23y18BSoESapsA1CxZ2zIuhx4J0dqefLZsvbtzjY2DZdu8DOkS+WlyR4O2jAfJ74RxWUPc6LkOWQegdgaaQpvWzgFysfoZ+k3FXzP89LdlT5BwWBJhT7PDZDl/X5cquK9f0lyCG9yHbxl1CUFgquON9D7vogEaL7GAc17Esz35d9atVwdGoy2WgWHJvYcOnz/VKyV+9xYs1Im3Qyscrlek+rrltCsJAn8tZNSWR9PYFCyvFagrQnoz96NNR4hS16Nx6o1cVRu/4lm4nlwsegT5YXt9e7xBFHJow==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3467.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(366004)(396003)(346002)(136003)(86362001)(36756003)(6486002)(6666004)(316002)(66476007)(2616005)(6916009)(66556008)(4744005)(66946007)(956004)(8936002)(5660300002)(8676002)(478600001)(52116002)(2906002)(16526019)(186003)(7696005)(1076003)(4326008)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: OHUADdozxle/tEpKe4urDgfW+dTUjMVYDBN8ucByYs0I6MgelZ84ulG4OZ9jKibpk49GKjrNHFfm7K9Qmi2mEuWf9ocCX2fsdX/bhkzoh3biaaGctn+BwqQ57YYKI43ja3HsGtHtoOhvVa4KOwp0gPg1LSziMyiNXSFs5YBe3Bi3OdQ76t/2ruzWwUSqoBfsSMlfwQNpXPrTarUt6lV4SpWOpN1F6FQujo43vEIvVj/a0inopZwoSsJMR9EG95bzXjzX4tmBZ9DV06cGBn9eoMbE62OzaSwTumwjf+5h+C7FZCaa+2ynGSN882KPWczGWc8arkXUeCpDnaewdlgJTpzjr5l5o6Y+vpd+aaejpWWR4rOe2p5HzldsAAvtkfK/hOz2UaUpc9dv/j3lTqDVTXTwVDzuyt455d0g52YMCX/SiRcTwtAxxDEkxFjJb1HUowKlYMBxdnaxsH8sgcsTyed7azmUARpSBQ6dWS694eIsOObVCOvJPPbfwJEDMNCN4BbcNBdqkSStk4EcMbxreYRxUBPFGrRzzeR8CdxR7dxkedEJabgEIQPFx3N83fC5DyNNz/OUuHQqGXTDRWju8hp4V5tYDw94x7oK96czPngLVj1UbZHI6+8mGERb13Y25gba+8XgimM+MRnXB0WBJA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b421ee3-5bb8-47bc-6e96-08d87fc00fd6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3467.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2020 06:16:55.1953 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FaJt1MPSHP4b1135awpwqi5E+NlV6L0IbUjNbeLG+W/F/ArRDiaCl5/PNaH/bI2rzVRyMICQsgZk1s0p2ao3GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0217
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
Cc: "Jinzhou.Su" <Jinzhou.Su@amd.com>, ray.huang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add flags AMD_CG_SUPPORT_GFX_FGCG for Vangogh

Signed-off-by: Jinzhou.Su <Jinzhou.Su@amd.com>
Change-Id: I730754a0929368bb35221e586fbfa5bda0af0eaf
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 1f8659a1a4cf..e33d8022cc32 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -953,6 +953,7 @@ static int nv_common_early_init(void *handle)
 			AMD_CG_SUPPORT_GFX_3D_CGLS |
 			AMD_CG_SUPPORT_MC_MGCG |
 			AMD_CG_SUPPORT_MC_LS |
+			AMD_CG_SUPPORT_GFX_FGCG |
 			AMD_CG_SUPPORT_VCN_MGCG |
 			AMD_CG_SUPPORT_JPEG_MGCG;
 		adev->pg_flags = AMD_PG_SUPPORT_GFX_PG |
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
