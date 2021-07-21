Return-Path: <SRS0=ovQZ=MN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B307BC12002
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jul 2021 14:51:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74C2361245
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jul 2021 14:51:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74C2361245
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 314E16E981;
	Wed, 21 Jul 2021 14:51:15 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BEFC6E8BA
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jul 2021 14:51:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UOJMWgRtP+SmwMngHRuNN+a2dR943jSd4cGFDSZdiQ3IhW96qRJH2vhdhu1gr06K1pzYO6bL3OZxoViQrI4S0GutIwpPWdcUFCUVt3mHrlGNbRH7NPqe5+OVSarY41MfbWcy8sVnrK70z71e/ujiG1lVhC9QsH/M3McS5AQDJEELglzHVkYnC+9YM29pFaOJ2Ay/dCkGv86ZNoZgdUm65AuovThSrWT4hma8JPjkeQD/4X1CA1mkrdlf8kRqDNd68RmuCGaIYMjHxVEX8EjKchMCEanKyoUO1XGCTknIY0LbzjBlwo69axbr5+KBkAV0IlvqPjb1g+EsuDrbG4u6Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y89fB2FTjWn86lVOINbADrxxRpzNjWp8twyMWXY4aPg=;
 b=h+J/MRes0YFgtFxHvdRioGBHTi/KlrCqaJfHkxAB1sELIPupqMkNitzMyIQXiBLQWEgw3VezLqBSb9Gigyg7yfGkWSedu+yrAwtnW4QGYq4FClz6JqVuypQibGdnm0EsBqk6VSgTkaYpdEeT7BX7X4115A1ptwv0SUFePZBAtVheGyldJdHhmdYzsrdKZseoFl0hQFRpmR1IQcPV5MlLFhBbeJ4Ht9T+emDRXTgIkgW+BVkIt8wHlSN0FZvO3Zc5Gh2TDOYj3UtUndrzNwQUAqv/cd1p0SlNyHBEzqzTtUhlsTT9L7HnUn/9QBfEZacvRqpuTaM/4wNtI2kP9PYbLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y89fB2FTjWn86lVOINbADrxxRpzNjWp8twyMWXY4aPg=;
 b=MF+R4kG9ak36yjImG4l5SwKFmFcj/l3TKRnH+5Hy38JNwie6FSGwahdkAS9XQBDjAu9gWvATop5Qovl+BcQ3bNgloHGvgQuaR2c/pWT3JLfg/BNJT8LBE3aKSolinIgDj47KvSjPWtIsQK49yuB9n2eWCjBhAdl5jRsAMQcrnNU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.29; Wed, 21 Jul
 2021 14:51:09 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3%9]) with mapi id 15.20.4352.025; Wed, 21 Jul 2021
 14:51:09 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: update yellow carp external rev_id handling
Date: Wed, 21 Jul 2021 10:50:54 -0400
Message-Id: <20210721145055.2619181-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
X-ClientProxiedBy: MN2PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:208:c0::23) To BL1PR12MB5144.namprd12.prod.outlook.com
 (2603:10b6:208:316::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 MN2PR05CA0010.namprd05.prod.outlook.com (2603:10b6:208:c0::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4352.10 via Frontend Transport; Wed, 21 Jul 2021 14:51:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81d2ad45-115c-45e2-07d9-08d94c56f9e6
X-MS-TrafficTypeDiagnostic: BL1PR12MB5349:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB534992EFF977035720987015F7E39@BL1PR12MB5349.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:639;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PltgKek6SZyNKdcV3CmOT/HaZVGsZcYutJJbzDUbqwjrxLCpKmm8AxFgS3mZ/kMOUQcVX54E7KoECNT4gUEQr+QjaxmLsidaZHV5OrdG1HHEEYXiEWsULve31oQz+iyt09gyte4ubwk5qFRKR+hHziYhGkdtSRLaAgyuIV72hc9Uk7UQLwq43tLL4wE864uG5Mo20E73TGGlP5UjYs5QzxDZi9graSVx75Mhf+78RjCaLH0URS8nUU8+Xaeg0+hkcIM2Z90/QVcOL3hLXm4VnpmhD3HOSF2XSejWIScSJc7OzwxTcrJJerCiwLGL3Oxsjtijd1KyMqZZ1x3zWAc23mExvIrc6bdLfGtHCnnV1c8hIwa4ZxYch4UxKm1k8geT9IvIwFhbYai3i85X9+KDy56+lNbxlc4p17t+Ya1zhXJyTHlY1yqShWy8Co7+9jsFqZigOYtesyETi8sqFDqq15KVM+Xf42LmfdaD2+VZDqMVpWiDwcTfjNHrwQpVOoxzZnVo2DbIwzF3y+ffmtQSMphGrsIWOmII7rvPW1eK9+04qiJfPcCD3LyHIrDWoawf2D+RYGkxyaTAPOSxJ210Q6+EVzBLhrY8h/sIi36zyC2GfwdZhEFfZqDML20EmnN29IgrvXXU38sQtC0jojTA2kg/KJopxM090HgfhzCj/JvWzIBUuvU4b+MFVpjcI8X6uX7fzvsFIdXPLeMpCFQKmg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(366004)(136003)(346002)(376002)(5660300002)(66556008)(38350700002)(26005)(8676002)(186003)(6512007)(66946007)(66476007)(6916009)(6486002)(8936002)(36756003)(54906003)(6666004)(52116002)(83380400001)(2616005)(86362001)(4744005)(6506007)(4326008)(38100700002)(2906002)(956004)(1076003)(478600001)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QU8xto6elyovOZdLp7d7OacRbaO9FUdxl+BKquDcL9aJwC+M364aiuWRF6kt?=
 =?us-ascii?Q?WFZgYkLvfDZHtW4HX4batnFi2BYXWqc4qxV0T5L+GpgaQIoiNRI3iUD8+TdX?=
 =?us-ascii?Q?t/5zz0HqgaU3IzuivuXaPPfT+WzF7r0NU0A01exGMohVcZ2F41sELL69YF/6?=
 =?us-ascii?Q?Du93NpGIT4r2GZ9HMpaiNhP+DDY1rJZL1svST20mop9IaEiQieCSk4e0BR/X?=
 =?us-ascii?Q?eiWA7Luph834vU9uhHccR3DdAqq827RfGoPJtrVhZj4DDL8HHkJ3MPHjbUgr?=
 =?us-ascii?Q?i14xztx+ty2NrbiZvuZKrnyQz/zVbcehw1OtaLWG4DvCjho/k0K4v4xGsgW0?=
 =?us-ascii?Q?MUXY4TaaZ4FGY9zXuGky+Zrwai6UnJkTAUPXOyCv3eCLccWpiPB6mEhhwaoc?=
 =?us-ascii?Q?zgkoKYL9G8KBvmGOVeZEbks54xxWyiJQfkCaDsyLNUljS3xTO9ABe9sU1Ky2?=
 =?us-ascii?Q?+mxaOjWEu6VC5cRmF/hHuFBTLmOefscawGvWWwMjK9XLiA/S+06uQX9QHjZN?=
 =?us-ascii?Q?lLcd/E9rrgAvfajNJUDk3b4Q1dxvW//kMOYmuJbYKzCI767RHVtnhA4nBTpJ?=
 =?us-ascii?Q?R+UfPFxtu2fSVSf/0OderoqmEZbk7WXmVmTjV239zDqnGvADMZaCyqB+drNU?=
 =?us-ascii?Q?irtXkBNX503hVIbVY2A4ALH9QTB3wlNmYPoNzNZeckqcx/aP5AF0JtKmGBM4?=
 =?us-ascii?Q?+13W90Az4Vn8vBY8ISm5WzLqueEBvWu2F1Ad9i4gCJE9ecGO/qZQSE6QKA5V?=
 =?us-ascii?Q?n/Pvi2I4Lg4Nm4NptlV8qbzMJoumCrBXJrBTUEnFqkD1xtYC9tSNkVMKBKNO?=
 =?us-ascii?Q?dhDkpn92QC4447qO67+IhikiwXxhGg2YZVuJw+iFqzt+VobZwoOAyr/x6deh?=
 =?us-ascii?Q?DKuqCpyRZPxbE1OtUUIYU9Gi3limy/qfg8ftAEa5rmIGufAsUiFQ2dDeluT4?=
 =?us-ascii?Q?l3OCP5Hls1/Sj2HpFbizvA9AMN3EcVRYzAAWarqS/ncC4UoRQAiUo/zhajtk?=
 =?us-ascii?Q?a+fu/DvRL/LHL/aoVoPg6XdB3Pk8YJup+jPyLC4ChpT+zudUAKeNSySIqey+?=
 =?us-ascii?Q?zi+xoNMuwJzRRiKlMqGh5hyLcf2e4LrH8yAZr9EjluW4H7+9zZ3jgMSvx9Lk?=
 =?us-ascii?Q?8mNF0K8sIQboqqHy2FNuuraC7U2pC8ksOoZe2x9lF1chusbwnS++42IIfZ1V?=
 =?us-ascii?Q?IrNwkSyE8/0z3vi5VTlfmoblmHfwX3WqNgPWEgzGrlNogluFlsGIx8Uo0pn3?=
 =?us-ascii?Q?XTAi4OO0+NCvW2JNRbrlFpUXXoJJR6k2yau6KHdGqZsbBw7CwzvNGfPhlVkM?=
 =?us-ascii?Q?HJ07TzhRfgZG9d5RQsV3wT2I?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81d2ad45-115c-45e2-07d9-08d94c56f9e6
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2021 14:51:09.4769 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nvgPuq5XJAF2/ovK6xDzEFWlMlS2eCi3rRA5SZ+U9MlCZyVQkREpTI7hRivsQxP0NNRmC1uVS55XHcFr1rM3CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5349
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Aaron Liu <aaron.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aaron Liu <aaron.liu@amd.com>

0x1681 has a different external revision id.

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 751c7b8b13e6..94d029dbf30d 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -1236,7 +1236,10 @@ static int nv_common_early_init(void *handle)
 			AMD_PG_SUPPORT_VCN |
 			AMD_PG_SUPPORT_VCN_DPG |
 			AMD_PG_SUPPORT_JPEG;
-		adev->external_rev_id = adev->rev_id + 0x01;
+		if (adev->pdev->device == 0x1681)
+			adev->external_rev_id = adev->rev_id + 0x19;
+		else
+			adev->external_rev_id = adev->rev_id + 0x01;
 		break;
 	default:
 		/* FIXME: not supported yet */
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
