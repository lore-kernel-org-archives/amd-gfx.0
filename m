Return-Path: <SRS0=NRDG=IQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A404C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Mar 2021 07:22:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B25C164F0C
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Mar 2021 07:22:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B25C164F0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 486AD6E897;
	Thu, 18 Mar 2021 07:22:17 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 156426E897
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Mar 2021 07:22:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NKF5TmquzbcOdHHsfImiHP4uAfFYMfHLtQQhi55t7utlsxUcA5yRForgbmYCtSPqi1Hhhl2VHyPnZL0kzngfU198kmqxxey2o3jiJGNiakvppLcBKuBUg+UjDgo6uLv1V88GkwjxphcxBBEB9gsQyRe0553VJIzypxOWk2aT6pwCEKu2vcCZBHingiQUt7yBLKJ7I6o7GwQ/Plg4F3sf828lmVjGlYUdN5hVcofIHkaCqtlaOevk7AJTDJFyK9ahrpXcqqLCNHK8tbMm4w1+nbvwzJJr0s95ki0nuc1JqwyyJDEURaooC3ybFsXC/pK2NvZf4aGghQqcdCOfMliYxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/0ZXNwuIrJ07cCiFVADu7dy9fRNYaJsBvairEKH9svw=;
 b=f/a7pFR55L4HMvmKNb5L78RaVUKYXkOJqGJ0D9s/OI6zPub2FF8WiXdFBP71rNwvhgtJvrmQ/C+by8JjcqMTeI3oeSsTf1p0wAWaGDBGBTieLv5dGtZbvI6TKNLqga0MVqFlgEKJQObroDGW2NGfNsAwACYqnVzNg06m2VwQFj9SCXqA7EQyMklagCg0Yq3TJaQe7XUoucnty41uXAQEzghMJIWYQJqgeAHsVfkB2MrvJFi+RMj2SwLQH55rA2GL0WiywkG6In4dKhtvaYBZiM444FyklR+ORVTEh7a4SYQvDsxuItrPgNx2pTN3dH+6Q8823gVeVmOOE8k/9PDM0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/0ZXNwuIrJ07cCiFVADu7dy9fRNYaJsBvairEKH9svw=;
 b=QP13m7/+4zersvqMxSGbG0Ptrpax7lp7KP+VzpjTY/wgX2DD9dVkYJQ1W8aDVmM/If188nVcBZwEStsyNqdezgKfMkPBqoRVztBV5whUtZBifcpdhqMCaAlOkQD3GS8FJ7zDr8opQ5yoEniyGUYn9aRvW06BtaMXy1mJu5+nnk8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN6PR12MB1124.namprd12.prod.outlook.com (2603:10b6:404:19::10)
 by BN8PR12MB3073.namprd12.prod.outlook.com (2603:10b6:408:66::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Thu, 18 Mar
 2021 07:22:14 +0000
Received: from BN6PR12MB1124.namprd12.prod.outlook.com
 ([fe80::df2:b35d:351a:6c8a]) by BN6PR12MB1124.namprd12.prod.outlook.com
 ([fe80::df2:b35d:351a:6c8a%6]) with mapi id 15.20.3955.018; Thu, 18 Mar 2021
 07:22:13 +0000
From: Xiaojian Du <Xiaojian.Du@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: enable mode-2 gpu reset for vangogh
Date: Thu, 18 Mar 2021 15:21:20 +0800
Message-Id: <20210318072120.10535-1-Xiaojian.Du@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.245]
X-ClientProxiedBy: HKAPR04CA0001.apcprd04.prod.outlook.com
 (2603:1096:203:d0::11) To BN6PR12MB1124.namprd12.prod.outlook.com
 (2603:10b6:404:19::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jenkins-MyrtleD.amd.com (58.247.170.245) by
 HKAPR04CA0001.apcprd04.prod.outlook.com (2603:1096:203:d0::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.18 via Frontend Transport; Thu, 18 Mar 2021 07:22:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 43b9aa36-da3c-440d-ab94-08d8e9de8d36
X-MS-TrafficTypeDiagnostic: BN8PR12MB3073:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB30735CD7A5AEE49A28A55F4DF1699@BN8PR12MB3073.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jrdXhKMHKqDcMEymNtSFOYAEqbWKBXmNDLzQiZ7/NnKkMghUNyPwzeXZaJin9062s4icPOo+cbl0N6BsQCmH0+vL2kgXI0wYC3CipUr8PjWAKeR8nVTv4Pb8gJIMTK2doWOuDh348qbGjtpmO7WlxsSxC/gxE3axzFMiP+T1kIwV472D1N1F7I06PJXp8NvbGwBuece+0FJjSKOcGBSuDVlwwwgb4tZRgOp6aGfzDLkXTtkQ0Dy/Op+UD+J0Mc90R++OMctpmwPON+Sz9/md5XkFwI7w/Kfccr5urZG8pR/i/8OabnL0P9Wi+us5hjWWg8AgGoUVvKmfbo//sPdBVRSRPhLcRnC9KbZwquYsO9onw4bWmYMg6SPxOyHXfhVJ/1U/NBgP8Vtpf8qfHCPsCbKSStzMbq+ii1cI6nSQZjCCWw6nmQg/3kXjVOCcN1TUX49cvH+y6jKIqI+i0nOOO3di5oVXPsCGqtU6SC/1v6dI8fun2koi8p/qCN8xHSvpKQ5n5UdmD8CF6WeSQaCF5HoHMoLL2C/9aZjOXW8BzFFDs/BlM0tkKAgNLcxmn7nmYtg4XMvSI03KgDVFFX7PyHv6OfDnfAbmJHeR/JqrO9Adu/RpAknmisP0Ta88qsyc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR12MB1124.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(39860400002)(376002)(136003)(396003)(36756003)(8676002)(8936002)(316002)(4326008)(478600001)(38100700001)(26005)(6666004)(7696005)(6916009)(52116002)(86362001)(2906002)(956004)(1076003)(2616005)(54906003)(83380400001)(66946007)(66556008)(66476007)(6486002)(5660300002)(16526019)(186003)(4744005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?oozMGUTy9JJQ3bDkrdFLwk+rhwGdGe5PYRa/NfdeTM/5bQiHMoNkQOeP86vh?=
 =?us-ascii?Q?tkZgMa7SHWFmz/IyxoCbXv8gMOl3vtQUM3VuFW1QiIlriOoTDupPuEfZ/eS9?=
 =?us-ascii?Q?MAVMt4srdYezfN5Ph4QrUj3PRt3dQGEmxb9xyU53xIoMLBjYJ79juEe8QQoB?=
 =?us-ascii?Q?j5W7oepEJiO1K5JG0wPG9ZMr1FTIKSosf86koQtXU1Q0tgX3PVKuBiAi7oxk?=
 =?us-ascii?Q?21IvIn86C0uJRX7dZF2ntqp/VhX9ELcVdwOO9uydRdBs28gSOGIWCeHLbTGx?=
 =?us-ascii?Q?RnvPXLdTb+bB7+YqpYfz5BDeDEpcmxzbfUASi0HQp6HmZ6LDG17YyyFd4J19?=
 =?us-ascii?Q?2Y4U8Z6RCqIX5Bv7mwFovBMkUD65Q9IufQJ0wxEmFgeIe4sZHOTPvi8Yp1YS?=
 =?us-ascii?Q?6IpN4PuhF6fRhEUXLCOFp5mBdtbHXI/NrkEmQcfw7upOJwxcR+VI6I3L6rs/?=
 =?us-ascii?Q?+I8KzIOoX9CbVFX0cL5dYVGnBIyC8FYzbv6WjggS5cnK5Iolysi0GlEtvuVh?=
 =?us-ascii?Q?cVqB440ab4RB/88wNC1pMWn8ybXV8aOjXLq7rDyvMtNtB/px9C8wE7iV4Wmm?=
 =?us-ascii?Q?aZGQp7pBclA68u3mTc1kn2+8Y4xWOcjt7qEFmk9my3kRaF0uLaHQOJ+vndjB?=
 =?us-ascii?Q?DDiW3UBCkP9hHGzu9f04UO1mSxmqAreWiswtxt5zJUHQI40zSxpKrnHnFQbZ?=
 =?us-ascii?Q?1FTFZ3VHpdXQ6gOztgeEMaqZ6sBgZ0lfUN+oOYqPCOWAM+9M9ewZV1w4a84U?=
 =?us-ascii?Q?Du7LydMoXeXABIrL6S4j8HFJ+oCxcbiCb5hZRKkICboCV61GEhvozjtM1xfy?=
 =?us-ascii?Q?yeylbf7BWcVsix5p8qkJeRFrtZT+0IA223EPvl5Y6Y5nqAeL5RczIIBsTXj3?=
 =?us-ascii?Q?h+BN4b8/myiMoScJSQ0EjtYy1DCctFPgNPX86fH/fXP3X+mzUXQvifu8Rnn+?=
 =?us-ascii?Q?EVkV5HD3Yjk/78xpJfIASun13dUKobpAfQBeCXFSeO4CuYGquHs/JWW0X8ET?=
 =?us-ascii?Q?Nfc01pphZIvi1ofc5tQ6ht5fEO2q9BcR5kiBYvXshsWyCKzrtt3KV09PvmC8?=
 =?us-ascii?Q?fXJViZTD1LXzXRQgZ09hJTgKsxcn8BzqgbYxPCy2ygCl5cWFeJolXxGtKgFp?=
 =?us-ascii?Q?Q/9xeIBnuboe46GLOTHH9oQyuGDpyPrSMZvn5fVK7npWQ09EzNhlB5IH6n7O?=
 =?us-ascii?Q?XBBYYKWCKZP0FP9E89FGU6kaXzsgV1aLinMAdJxf9Oa10o5Xkkhra+6iavHE?=
 =?us-ascii?Q?RcwCIAMGy4URhjvbBzSNSxPeNuuJZWm7pR4FrnDZBaXBZmS9S5KWMUt9c71t?=
 =?us-ascii?Q?cH6yHioIeYWM9Ol5yjIEbwa1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43b9aa36-da3c-440d-ab94-08d8e9de8d36
X-MS-Exchange-CrossTenant-AuthSource: BN6PR12MB1124.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2021 07:22:13.8355 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hzdaqv+lzhOvZRr0H6cGcxbIChVEl+883cPc7UYO9Ip5iLu069lcAxn1U/DtkWiMhEZ3Wt3G44Jdp3o9oE0+GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3073
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
Cc: Alexander.Deucher@amd.com, ray.huang@amd.com,
 Xiaojian Du <Xiaojian.Du@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Xiaojian Du <xiaojian.du@amd.com>

From: Xiaojian Du <Xiaojian.Du@amd.com>

This patch is to enable mdoe-2 gpu reset for vangogh.

Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 5846eac292c3..a31ef68ee2ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -561,10 +561,6 @@ static int nv_asic_reset(struct amdgpu_device *adev)
 	int ret = 0;
 	struct smu_context *smu = &adev->smu;
 
-	/* skip reset on vangogh for now */
-	if (adev->asic_type == CHIP_VANGOGH)
-		return 0;
-
 	switch (nv_asic_reset_method(adev)) {
 	case AMD_RESET_METHOD_PCI:
 		dev_info(adev->dev, "PCI reset\n");
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
