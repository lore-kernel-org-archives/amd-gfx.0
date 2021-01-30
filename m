Return-Path: <SRS0=ZBQi=HB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B78A7C433E0
	for <amd-gfx@archiver.kernel.org>; Sat, 30 Jan 2021 09:15:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7408F64DE2
	for <amd-gfx@archiver.kernel.org>; Sat, 30 Jan 2021 09:15:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7408F64DE2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE3806E027;
	Sat, 30 Jan 2021 09:14:59 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680064.outbound.protection.outlook.com [40.107.68.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 097146E027
 for <amd-gfx@lists.freedesktop.org>; Sat, 30 Jan 2021 09:14:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B9qhGl4SKnoxny8byFSiQxif4vI8pm/2xfXHMx3uJWHZ+Q+5+Jeo+mFpeIYdWvCsjBnO9BheosS5BCmQZaszxHMj+0fBFVIXQPOm1wMPbJx50Bvnhja/4dWMAWlAun1Lu9Svq9c305o2J+TzeZWWRDLD5Br7YS+sCgbz2hSnrNOSqcMEp24hhusVORw79JjuIsow4LTWE/zBzyzLlQc5X59+gtouhxUU5fXk2QfGWaTyduJ4RzWf/MlZm1jK98VQXTw9J0luxJLJWgFtXZtVqIv13oQZtgU7FtHQNamSJpHUiImQa0+xZhMADFKfmBq1wERYsd6OGNtC52oj4j/AAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=225IKffIghv/uYW8MiAWnlojXIsEqxQ0cOu5XHYfJCM=;
 b=EmBAsZVKFJ1iTUKN2RWNq7Q6NgKpefq1Ga7YtC3xXg2AOg1GtBJFSC+7KH1CJDZfnQ4D9TE/O75N303lthv08klAwXtV5fUzcZPN2upYiHHUe3MGigNo9D2FgymqriPgBMhJAQfuuf6CzEFjCOYScqX68G+wFHQvKicnoqF+5mFlhr9T6sPDIDg3YwbaLRsahLYwtlw75EOmhV1fPRfzqE+8wOL6d+M9miBWSjysxtNgqvbQJky3N/4nXSIHTWG9OYxp0hWm5CoBcqDy8sWyoaAQsKYMob4CZzwAGTU83UDHwZaflvFrngwj+hSUZf3l61droRpQyGqm5pI/8Ok8qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=225IKffIghv/uYW8MiAWnlojXIsEqxQ0cOu5XHYfJCM=;
 b=mCM3RTm9KlkqzbTMgvay2Mv9NmOQP3ZoO5Mjz/4nMVGH3C3iF5WyV4u3ecceiSj6cyB5E0aL4J3ZBEQMLyJh6oW/FRA2Ne/m81b2CpF3iDceyg/EAStOvCPjRS0ak5nQTdDwSyDRj4YFli84baalRPJm1uxPEHTdTwGpSCm2XRE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MW3PR12MB4522.namprd12.prod.outlook.com (2603:10b6:303:5f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Sat, 30 Jan
 2021 09:14:52 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98%6]) with mapi id 15.20.3805.022; Sat, 30 Jan 2021
 09:14:52 +0000
From: Huang Rui <ray.huang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: fix the issue that retry constantly once the
 buffer is oversize
Date: Sat, 30 Jan 2021 17:14:30 +0800
Message-Id: <20210130091430.3079814-1-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR0302CA0020.apcprd03.prod.outlook.com
 (2603:1096:202::30) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd.amd.com (180.167.199.189) by
 HK2PR0302CA0020.apcprd03.prod.outlook.com (2603:1096:202::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.8 via Frontend Transport; Sat, 30 Jan 2021 09:14:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e97552e6-e2ae-4c2e-1956-08d8c4ff8021
X-MS-TrafficTypeDiagnostic: MW3PR12MB4522:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW3PR12MB45225BA98959E61E54394165ECB89@MW3PR12MB4522.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DBa4IAkb55Pif+CN5Tz3IvPgf8YCPo/zMg14qh8ZLYw8ly/ZZs+LKBMRft4GTr+ev+ueTlozZ9cWVLLLqhO53WLVNHZZMuOmIsYCjyF0knNsaZMiptm2IyB6B/dA5oW0UHCxNhYSl5l5zxRdEHCDBnqf/Ybo2GJKqZ/67HsET5VAIXRprYXIUoYJt84JbgUHP9ZLNi7TBZXVIyb8Wy5Ar87duFm6I4sEUrNl6bpy6h/8ucEmrDsvsLN+5LXqHFGuUbnm7L/U87mP6EyZjT//EP5OrdNJOubtnu6q+BLMGjAfw+tIthTGdSecjiQEDEhFYqIs8j6bNZmVBZ0Pcq7YCoDGKU5s1oBvQ4FHc2kiPT+j8GHRYKmb628zUR6OSkWABLSkvhWK4mtIAcHGfVrRGemLoEYjiEpbf96huCRRtEsSim9RF4yQds2np/iFucs49T6P/YtpaQANAMAZAZ1TR4veqY6g26Eh+x9RBFomTH/uPyzwNwELBhn6h55I7416Gy3+MJIQ3MrvPPaTBUzkXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(39850400004)(396003)(136003)(346002)(66476007)(66556008)(4744005)(83380400001)(5660300002)(1076003)(66946007)(186003)(6666004)(52116002)(4326008)(36756003)(478600001)(6486002)(8676002)(8936002)(316002)(26005)(7696005)(2616005)(6916009)(956004)(2906002)(54906003)(86362001)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?c7LbWRka1fo5W6nCubq2oOazsXjzUrkptTxrFfOLLiiyptRoxyKtxWewgwzs?=
 =?us-ascii?Q?5fen4EK15ZutDStlrLOv0mhfb49GTntdznbILTshVTo0p24FXjWQX7JgE+Nv?=
 =?us-ascii?Q?N3tDAW9YuBE6BulVYZl7ZFsKCwxxCOYvOExEZtO7+1sZN1J+1y3YjAmdx7qH?=
 =?us-ascii?Q?utoSt/fLhLAiAQRQBVBU2yYEOyOfdNMl3S1fyhNmKTIyRZXserqORYNVkmG6?=
 =?us-ascii?Q?6YWV+yvGbsH6UnB/NGZqD308FqcUykb/Ktg0UqrslZ/+hc5Troo9on9+D8pY?=
 =?us-ascii?Q?vRivNYQ6fxbw2WIxpqPzKZnHCtHmA8oH5gxiQeiANPUduTeqRVKZO9Bu/5cI?=
 =?us-ascii?Q?LzPrx/1ol6S/rfvHVvyfLaaIfGrvP2SjQOvaQsid6EM+l/nezS868WcqJW1t?=
 =?us-ascii?Q?37QCSN2ps8Y701zaC25TSubLZQwzi9hFALeNNYRVWA4v2y8pHFi/R/LSjYke?=
 =?us-ascii?Q?+DmgvoAhWl/6jPeMprsk2i34i5aaEbC10c5ZrWVl/Sl4GH8vrqjGIUdkpRHf?=
 =?us-ascii?Q?isofkYbbX21ONqyIxY7i7G8ja3pkyM5CD+fjaloJmVklaMZxnNP8Ql50IZFb?=
 =?us-ascii?Q?mmIe7H906Z9SPU0eirV4V4P2epTCG41h1oLyW91mj86mTGN5i5CfurjetyKS?=
 =?us-ascii?Q?quX+tq1Q6Tr0pKoaZlQoSpoNeB/9QnTKlTZNpuWCfAQYYWSQ6F3d2jLhdUR0?=
 =?us-ascii?Q?Kp45k7phXzhc6yzWFoxGlCCMzVSo01ezagq+bOms6tGqomUW9OtclMqjF146?=
 =?us-ascii?Q?oaQr1UHLXVonU2BjrgYJ1BpMCWyPreHZQGGIi8KFCFL6sgFf0lPaU/8G6zVR?=
 =?us-ascii?Q?r1xbFWTCLoAOBPBsEuYnMJYe22DqOTydWIMOvXpwtWDpXsQ31/7q8o4K3dQa?=
 =?us-ascii?Q?u1HB9JYQ5/L0K215khd6TDJxsWCYug8dffcIM50KJBpXupFDWE22JQFY128e?=
 =?us-ascii?Q?vnyZCV8+ClfzyDH+9vqiJsWPAqPx5Fw+Ly0+r6uopgiHumMR0NMD2kkWGpgo?=
 =?us-ascii?Q?WWq/aMg71FXUWDmBWsak8td1PYdHoyAuaBzGQxI0ypln3Y4POY6BOd0DBSSN?=
 =?us-ascii?Q?TnctfsESoK/gY9GeqUNkcBBSTgbHMg=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e97552e6-e2ae-4c2e-1956-08d8c4ff8021
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2021 09:14:52.3240 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l3zgvuWG2VRXdAFqhjpCtV0XqSofEoDBPvTigyi6Q21K8JEAUm0EEcXCn54ONOUvzR3aQzGCt5mA5zptoVQt5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4522
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>, Huang Rui <ray.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We cannot modify initial_domain every time while the retry starts. That
will cause the busy waiting that unable to switch to GTT while the vram
is not enough.

Fixes: f8aab60422c3 ("drm/amdgpu: Initialise drm_gem_object_funcs for
imported BOs")

Signed-off-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index a5c42c3004a0..b443907afcea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -269,8 +269,8 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
 		resv = vm->root.base.bo->tbo.base.resv;
 	}
 
-retry:
 	initial_domain = (u32)(0xffffffff & args->in.domains);
+retry:
 	r = amdgpu_gem_object_create(adev, size, args->in.alignment,
 				     initial_domain,
 				     flags, ttm_bo_type_device, resv, &gobj);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
