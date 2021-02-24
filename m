Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 109F7C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:19:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D079B64F03
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:19:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D079B64F03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9364E6E0C8;
	Wed, 24 Feb 2021 22:19:41 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE96A89DD2
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:19:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hLsq17avXaHL1DgY1aBWhyc/qK+uGvME4zwPkULIPcDHAF3/X6E/GYW8aUzumGIcsg1pV4vv2dMA8hHUX4iyZHDRo49XVKPtAT7udkikm1Oq73Gr/vPPKzRLK690ayUobwk3faSP6j96fc5hfAhPID8yLUCk6s6GJHGPRR84E9MY/hqaHAfpZL+gtYl1qsO3Xeef7CgaavgOyRmzq7oMGXMYnPrTWPJoFRyS3RFa0CEGYre8t7d20mZGC31QxNflTVEwKYpZ0U+WQr2YjoteCwHJeQL0Zr4PPXwk0p6TxJedf1px+n5Bga3f0aoa4kP2faicxVdkA2hHee1ndJOv4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jLKl7+zt+PwWBH9cLadpEYw0Bk7BXQ1wtGjBgn1BxZg=;
 b=Zd5f9BM5PQdT7RWTnqwIvXtT+UGx5oxkEYib4bQoMFCdv8svE3N4LvDL7aHZhIROnSCtebaIPIbQpwCfOulQ2/0LMBr7gNYl5NFtjkYGX7k2Wd9aTk3OGHBOaUYXwgdn9j6EbTYXoy2cbYUbK046rlXt5pIGvUA4at7b833AnAc+5kAC8fEcIfd221U4R68qZzS04tlwWGsF/iKOq5p975KH4zFvY/k0u9xTjrLWhJIuquyPMu6w3y7PMkV97AF7vKclTkPCASgIoCQ7k85EL6QUw2lNq4JhvNzWPDHsKEC1y/LbS027Xyzr8f5NxfKv/zCxCWmtbp1IN6JlinTaQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jLKl7+zt+PwWBH9cLadpEYw0Bk7BXQ1wtGjBgn1BxZg=;
 b=XykQJzcju+K8/a57RA+Qod8VrN0dMSIEctzeJJgxekI8s0dSQSUqzbYruGrPAJfGnr5XnXi5aDCQ1Y6HKFr+dbCFtPCun6eHPf1NdEieO/nMU4iDpRah54nhPhHUempCIEcfX3yTozClLGx8cOnfIsp7PSfpzfcNONoj/ptLvQI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4174.namprd12.prod.outlook.com (2603:10b6:208:15f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Wed, 24 Feb
 2021 22:19:32 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:19:32 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 020/159] drm/amdgpu: set ip blocks for aldebaran
Date: Wed, 24 Feb 2021 17:16:40 -0500
Message-Id: <20210224221859.3068810-13-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:19:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6dfca57d-cba4-43e8-53ae-08d8d9124293
X-MS-TrafficTypeDiagnostic: MN2PR12MB4174:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4174DB9B354ACC82AA743840F79F9@MN2PR12MB4174.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:127;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vLo4nu9RUNjGEzrKJc9/YkpECFu5X+Xk1J6hGj8Wz/fr4QHPOCmixeUi46btd0q/uQfNDQgQBA4HQAgspcGEsOtW+3WUxmdladO0Z1yo37+xb4Q3qV1KEOsrIvcjuZ9CO22WourcT+EKLuqtMyT2m/jFJKaY701D/9aUhX8vmTM+Kdn2t4ZysFfqzuF31uEfyWUDVcqEhReni3HAsGU5rPxM44jxWm7FcfygaGPwTBs6CiXWlqzkPtafqH18BtQZ3GzEcjXTl21vWNfNqQ7vQnWKjkA0GeIwlf0eWJoyHKmle8BrPoIHvPt9gWF62HvtJhkJWLR8UoEzRsV7Xi9dIS2arBE1LTkAc262xacVOICE9usWliN5AiLAaL8Jz17ADq1oDEE/TqWk3uha6bdZtIRINIT+qfywr/4fACEdLoMFaUgPr0GSP7l7Aa3vf9KZ0f/uaufRdZTa+/wVSZ4oDmE27i/r2nVb7X6XQWP+C2Ga1QJIgZoqiUDmYzGoFMcfIJslQIt4fc6EWe4m7G8lY9uWhUN0s8J6AQ6DLPfNFSiTJORnRWAfzacSSXkfSBpit7ayZ50lfj6mU/v0wfuMkw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(376002)(366004)(346002)(8936002)(52116002)(4326008)(186003)(4744005)(2616005)(83380400001)(1076003)(956004)(6506007)(26005)(6486002)(6512007)(54906003)(66556008)(316002)(2906002)(86362001)(66476007)(66946007)(6916009)(16526019)(6666004)(69590400012)(36756003)(5660300002)(478600001)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?cMIbu1i9uQvaCEpawbF6D1gXM4hxghITank1zesG1kyn/My9wDj0/prHMWNR?=
 =?us-ascii?Q?baKlfUpqNP6icG8tOwn83mBOb5IJ4xZtBv9NBg8q8iNA2Kb7Umti3xRM6jxg?=
 =?us-ascii?Q?l9J705aT03BypNxVviKg9pMI0Cu6mkmR0LjRQvKDMHxW1idjPBmj0kny5ISf?=
 =?us-ascii?Q?d7k5r5iVbtcYg8Owud/8mMejkYKrd49V9izg38ot1Xf4IN/m0o8Y/uHoxQ2r?=
 =?us-ascii?Q?9A+D4DwK1an8oAyUczRowyGz9SB4ZU7P0NprcjmIt//IGLN6xdCwr++RO/dj?=
 =?us-ascii?Q?zIlEvPsuOZkfbh++4aqYLlimuMOWH9HG9f92nJUI7daaSwO968J5/X0LAG4I?=
 =?us-ascii?Q?zowvr0qmZ91sZQdiBhss8fkCzoAqqBg3tJWlVZAMeDm6bIZ6ZJArUQ5bulcU?=
 =?us-ascii?Q?7jFgfBgae0dw5z3IwVLcZhfihPsbuZ4XeM5fpm1fHUW1owFWNYIYB2367C/N?=
 =?us-ascii?Q?NvaGgeCSbRueaMQjkthMY4R2s2svDTMEXssCIK/ixRo3h8Zw9ONySACPlfv1?=
 =?us-ascii?Q?0lHljx24rMp0mZrmKnI6q/9i5pFTvmaur4DiVoW3suAbMKk5+VVRVqPSS/uS?=
 =?us-ascii?Q?o8QEiUxfPXsx3vImb1OZa0/pFwybDtA6nTg5l2T1TJPZIfo42+FwfU5UKxe0?=
 =?us-ascii?Q?/dWiL0bJ7BbQX4DPdMRHDAIOR9G8HtYI36jk5z5Chp+GftQUGW+gsov9w560?=
 =?us-ascii?Q?v56HXMv7uaMHQZ7odqKELK3eyeOcebe6oKo9RWPxmlcq3cmaIRaDYSJWRSEs?=
 =?us-ascii?Q?fQuwcxjAcs+d9K3pw9LihIBbQBG2fDfEZ58oOJRT9Oz7krh/VGR3hRjaBwnM?=
 =?us-ascii?Q?shNDay7D/EDfq8DyZPfwpvold9zu4BZZIq3U4UQQnMvqULrK7wbvL8d2bkSX?=
 =?us-ascii?Q?U9BwMWrxbSMXji2Gu0NVS8/47oZz6D0KoF0ENC2aYpZmkfiu8P9/Kfwwl759?=
 =?us-ascii?Q?TKuNX6yA+ljay00L8kf6yMsqMljd5zfGoxgMgH80oWPx2y4LHvPCtqIggPGW?=
 =?us-ascii?Q?94pQfvacA8vc6iM9hGFn+po753/27MdkgkKxHqKis5sYuW9nxaxp5K/O2iOM?=
 =?us-ascii?Q?/xQ7h1bGzc9JEcdkAXDguWhV0WSgJ+TpSWHmMI+4NHF454WQ0Wjs30Tm+Paa?=
 =?us-ascii?Q?TFMY/OQcxjYFaR4lD56JLn4QSeNPTyuR8DwIyHC6dz+5WZqV71rMDjKvN2Sh?=
 =?us-ascii?Q?gMfciVhVbQfywSZZVGuiZ49HBIKOnsfXmVeecoE35CaPwf+KsoqRsuowZ/QV?=
 =?us-ascii?Q?KdOXcz0LP/fuoD6vCQTq2pfcvE459UeQqwmdP+xQeFLA4FInz+1KbbkW+wsT?=
 =?us-ascii?Q?42kOOW3WwGb1xLWD/XWgxI/M?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dfca57d-cba4-43e8-53ae-08d8d9124293
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:19:32.4417 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qJBBMgLfRG2RCjDp/34nur+JTL9Mo4/IjIqlKPkm/NYwK+EFWGKHiJ/0qoLah36o8WQzB8+QmUMNBl7HzAQm/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4174
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Evan Quan <evan.quan@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Le Ma <le.ma@amd.com>

Set ip blocks and asic family id

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Acked-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 7c7a6431f92e..8cb9ac385840 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2013,6 +2013,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 	case CHIP_RAVEN:
 	case CHIP_ARCTURUS:
 	case CHIP_RENOIR:
+	case CHIP_ALDEBARAN:
 		if (adev->flags & AMD_IS_APU)
 			adev->family = AMDGPU_FAMILY_RV;
 		else
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
