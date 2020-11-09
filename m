Return-Path: <SRS0=C2iJ=EP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC631C4741F
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2020 08:17:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 359B42084C
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2020 08:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JdBW15lh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 359B42084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA777894EB;
	Mon,  9 Nov 2020 08:17:26 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4217E894E3
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Nov 2020 08:17:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fi9fQKX2t7wL5zb6p2DjKxCf58SHAa/qfWes4b4OTMp+oYqD2hRsPGPxiSy6iUL+FDvak3T7RZYZJJY/tjCE3/j1y7gi8nvnIYJ2psHf1BkyIen5ipLeF/HOAqC/dV7pP2QzUoP2T4SYEgO8kOduHZfruXC3+gRhD9ry7zVbYsZpH44m3zPtu7Fld9jz8URtI7O3WiooAF/ZlYYef37EAwooF849dtEq9Ot8n9+KhogqgbwFN0xiVuPSwrJ1JwP1eRam51b40ekbC+zxbiwlRtYs+84W+6w9QsmhgNGR/BC6qajAcUuMrkbZ2mTx90M3UpmthjxCiBDH8dyn6B78dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xEVJsS5thQUingkX4EtEr3A6iY176BqF/Tb3AlUACRo=;
 b=HLNd3rLGIlCsc52WI5TSwyfbF3VoXFgV8WsuT7BhkbyjRsasIdwMIB5M7RhXplngt0KG9UaGRdrxpFodjwCLC8THiq+gkLlzFNF/PMxuMudLjvIKSi1ujb98bpdKnnw9xKlcaF8r4UI5Bjfu03MtGXx6QAZrB0aqFYn1CZpVS6+GfFYHpnTFisuFJBKluEL2DUVBqT/JOV/+NOT6vBwaeG6OVsGGUyn/0hMyAeLVE2yeWFZFrDt0u5j3njXamYpjLOycwYLTOjsXPZKqaqG6+r1tC7As8T37MsY+8+sNZ1S0VuRIQ+34Y1645MzDfxNX1hjxJEycfVcgaKjQT0YOpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xEVJsS5thQUingkX4EtEr3A6iY176BqF/Tb3AlUACRo=;
 b=JdBW15lhmqxUK63tn9zxBsBtCPptrqgKiiuOHwD0UQDE06jZI4PwFzNGJl9SiBvc82tK1uzOQHkgRmiCtYi6r7S2O96S+mXY1qLyzocnPogrdsMKJjtjWGXLYUyilNPj1EOV3GRrc6I3CNZQQXX3pSiJ8LcevJrMVmdUP4fvMlE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB3274.namprd12.prod.outlook.com (2603:10b6:5:182::25) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.24; Mon, 9 Nov 2020 08:17:24 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::214c:5fb0:3572:853d]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::214c:5fb0:3572:853d%8]) with mapi id 15.20.3541.022; Mon, 9 Nov 2020
 08:17:24 +0000
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/5] drm/amdgpu: disable rom clock gating support for APUs
Date: Mon,  9 Nov 2020 16:16:52 +0800
Message-Id: <20201109081652.1964-5-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201109081652.1964-1-Hawking.Zhang@amd.com>
References: <20201109081652.1964-1-Hawking.Zhang@amd.com>
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR02CA0129.apcprd02.prod.outlook.com
 (2603:1096:202:16::13) To DM6PR12MB4075.namprd12.prod.outlook.com
 (2603:10b6:5:21d::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hawzhang-System-Product-Master.amd.com (58.247.170.242) by
 HK2PR02CA0129.apcprd02.prod.outlook.com (2603:1096:202:16::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.21 via Frontend Transport; Mon, 9 Nov 2020 08:17:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e382c73d-a00b-4130-0a83-08d88487e319
X-MS-TrafficTypeDiagnostic: DM6PR12MB3274:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3274BCA114D92CB0FD503136FCEA0@DM6PR12MB3274.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l40AhyvpZIbfgGvPjejxvew+9OZHSgxsImLdHZyBbR0oYujuJSJnoeR2Hvi+wwMmTg/YX51VmJ6UCT23dOHCNCVgxcY9IgS4JpNhPdjiAbCB3jBJGyx9by0dUZNM0XYYarxI6JQHhKOhiHIcprBEy+fDtErUOvtIZ3SzqQNtr2NxY4bvL/luVaK143p9PM2nR1oadWQdIO4D2zYM3jQqPSw4/C4zLoNbTf8KonizS6ahus3A8Iydi1QaTaN1BadFMOsFylgu+3NMhV7MBrU4eALfeSQ/kaSBEV+dVOJq0baUJOsfqBBb0Rdnc2vozkqK9KSm018zM4Djo7pTBRhZ2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(136003)(396003)(39860400002)(66476007)(66556008)(316002)(66946007)(6916009)(5660300002)(8676002)(8936002)(4326008)(1076003)(26005)(2906002)(86362001)(83380400001)(6486002)(2616005)(478600001)(956004)(186003)(16526019)(52116002)(6666004)(36756003)(7696005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: LL53QYEoTEjhOATWF4pETIJhB6zaOXb3sUSOyCL/YxpxH/+QVBBICqnnasiu4vxDhZXwyBNaGA4jFHUGhB3xgnrrDuo+9ZmqE28whcSZK5inJjtHkfeTjbpBhQreGSQ5swh8mZGT05r95zwCrH9bIM5SuJ74kzuQgcJyIpcJFXjk2yxd1+g/UUaZ7HAFx4u7CR8DWVHGIoM7Ln5izaoxTS/2L8w6Z43FN0JvME/WCtN719wBFPhEfKBCiGaSRESC7Ll9a3mUEUeFkWgPqT6+URGSDKqcDEKMob5K3V6u74SjJpR/jzQTgpv/KR5l8/9IDztYZHo+iixXU9X5lHmmMy2TSQ3pu9AVtqoSUgShAVYIncyhVBIT04J21bG+mH5OCFSg6KMd0XHlbw9u2CMLGAd8DP2BCysF1cEKpa8Zx5JfV0MO+iMBtOYkorEG3Q7qH1Ftr/dfKzIY1Dk31qnvoU/mrx2IN1vTRjC+XihitZuHX2a71fqURZKxFQ6D5JKX+B//psi7b9gcOAVBmJQSkVc0AjiJaj1aF8qRRZuIn9nCZnZLtLht5qTWmO4uKxV97YTQkZKsXGAx7YJpLgSgogKLoyOazIXsu9hJwcsnf5nnTNQ4G469yC3ne2OOC9ChaFW22xGNWFg1kBVY7NxamA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e382c73d-a00b-4130-0a83-08d88487e319
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2020 08:17:24.0108 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: on4IqgbHgs0RnmXGiR/JhtAJr7KmenM6AtyyaQdaRBNY9kXeKItSj8sp7bAb1+NwHiIsM50GuVjmz8WkglrD9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3274
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

ROM clock gating enable/disable is not supported
on APU platform. (i.e. CGTT_ROM_CLK_CTRL0 register
is not availabe on APU). SMUIO callbacks will check
APU flag before enable/disable rom clock gating, and
skip the programming. Accordingly, query clock gating
status through CGTT_ROM_CLK_CTRL0 also doesn't support
on APU platform.

The change applies to RAVEN/RAVEN2/PICASSO/RENOIR.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 7d3788c..8a23636 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1169,7 +1169,6 @@ static int soc15_common_early_init(void *handle)
 				AMD_CG_SUPPORT_GFX_CGLS |
 				AMD_CG_SUPPORT_BIF_LS |
 				AMD_CG_SUPPORT_HDP_LS |
-				AMD_CG_SUPPORT_ROM_MGCG |
 				AMD_CG_SUPPORT_MC_MGCG |
 				AMD_CG_SUPPORT_MC_LS |
 				AMD_CG_SUPPORT_SDMA_MGCG |
@@ -1187,7 +1186,6 @@ static int soc15_common_early_init(void *handle)
 				AMD_CG_SUPPORT_GFX_CGLS |
 				AMD_CG_SUPPORT_BIF_LS |
 				AMD_CG_SUPPORT_HDP_LS |
-				AMD_CG_SUPPORT_ROM_MGCG |
 				AMD_CG_SUPPORT_MC_MGCG |
 				AMD_CG_SUPPORT_MC_LS |
 				AMD_CG_SUPPORT_SDMA_MGCG |
@@ -1211,7 +1209,6 @@ static int soc15_common_early_init(void *handle)
 				AMD_CG_SUPPORT_HDP_LS |
 				AMD_CG_SUPPORT_DRM_MGCG |
 				AMD_CG_SUPPORT_DRM_LS |
-				AMD_CG_SUPPORT_ROM_MGCG |
 				AMD_CG_SUPPORT_MC_MGCG |
 				AMD_CG_SUPPORT_MC_LS |
 				AMD_CG_SUPPORT_SDMA_MGCG |
@@ -1264,7 +1261,6 @@ static int soc15_common_early_init(void *handle)
 				 AMD_CG_SUPPORT_SDMA_LS |
 				 AMD_CG_SUPPORT_BIF_LS |
 				 AMD_CG_SUPPORT_HDP_LS |
-				 AMD_CG_SUPPORT_ROM_MGCG |
 				 AMD_CG_SUPPORT_VCN_MGCG |
 				 AMD_CG_SUPPORT_JPEG_MGCG |
 				 AMD_CG_SUPPORT_IH_CG |
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
