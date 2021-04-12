Return-Path: <SRS0=UsYE=JJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82EBDC43461
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Apr 2021 16:01:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C9E861278
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Apr 2021 16:01:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C9E861278
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03FED89C48;
	Mon, 12 Apr 2021 16:01:37 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CDAF89C48
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Apr 2021 16:01:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SlyPcWaDw1KgrOaTj7LggwgW17553fB/eiJsqv5cd17ad6bBafXU7LgTQhshfDThaCnja6dPy3G1BVqv+Te91ILzyRhIfA7l4SbmXIPQ21wzNDvjyY7YV5c5E8SbHlOYc3PNxMH/hGJfsskUGCMov8aardki3U4wZGwe//Pqq1LyI6PCBus1ypG6vw6Pj8vs1VMOezomdpWLFDyEESbnPJAUPYFaPyLQUIl2LyMM+Iq9eg311TBx8hD8oMix/TZP3CtcYgnkUYm8HuYelmtxXqHNYL0XTzMF7505GLyp11zGdHdN98xvatZVMJzSOoxAX+i/zcC5ms4FZ4/1POHiFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iRPG/myn1B1xtYAyq3uYPLNCZN02d20ZvzM+a9D6KTo=;
 b=Q51Z8DzUGFCQMocGCPqtka5EJEZrSF4RyJjX0Qb4ZpZjdySV7T++5oOD+7AH8EhMj6xm8dWIb1uJoMsu9UA3kGPEc0vUQ0+eokV/F0B8VaPxPD7XqSHmZJh6em8vOcXqtGmk70R6ePTsc8S2Fjk+e6U1bowLFmYpOsJrW+J7dAK9Hxhj7C+VPOTFu48Uv8G+V/5NSN2g6eGD2taDR0ZNWTN3h5cv7HeTeINA7yx4agf0kIIUPIU+otX7Rg968fDIxBBKbdwHwdQz8mmV56bUmornU8wunaCoS+6VsEDzSzWa2bEKdRplncasFSu2NL8nH53TrqeaKRXQG2z732RPqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iRPG/myn1B1xtYAyq3uYPLNCZN02d20ZvzM+a9D6KTo=;
 b=CUSyBAXAwGE6x1GQh9CyVVo7Y5sMlOsjELzuiMkna/s5Ud1b9OS8eiZlBJTPq0KjO0JCLFhr3z+myu4jEv6MJLoV5FDEyN1W7ByTIQSefcWyrqvBISosC8/BHwsXu54DOIB7huL1hhURuBQ/obKxwt7XJQ9FhCgsXdlEQPUexec=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3324.namprd12.prod.outlook.com (2603:10b6:5:11e::26)
 by DM6PR12MB3948.namprd12.prod.outlook.com (2603:10b6:5:1c4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16; Mon, 12 Apr
 2021 16:01:33 +0000
Received: from DM6PR12MB3324.namprd12.prod.outlook.com
 ([fe80::e5:ccc4:4120:4b89]) by DM6PR12MB3324.namprd12.prod.outlook.com
 ([fe80::e5:ccc4:4120:4b89%7]) with mapi id 15.20.4020.022; Mon, 12 Apr 2021
 16:01:33 +0000
From: Kent Russell <kent.russell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Ensure dcefclk isn't created on Aldebaran
Date: Mon, 12 Apr 2021 12:01:21 -0400
Message-Id: <20210412160121.27434-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTBPR01CA0003.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::16) To DM6PR12MB3324.namprd12.prod.outlook.com
 (2603:10b6:5:11e::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from krussell.amd.com (165.204.55.251) by
 YTBPR01CA0003.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.21 via Frontend Transport; Mon, 12 Apr 2021 16:01:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97e983e9-f118-4907-9c2c-08d8fdcc3e1f
X-MS-TrafficTypeDiagnostic: DM6PR12MB3948:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3948BE92610F570B16F5B36385709@DM6PR12MB3948.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:208;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yo43A9rMSxpLLkPAChsqlzr/nAMnqjnTgM+TPA8Y50NagFkeXY9ys8mPyg05GsEB7NXrN2cXT8+J3ZnCRUo3WnCpj0Y0F1YsNXa+GXrdqKZSmoSbk5Roo6wT+gOInPMinzsuIxccJTfFboMZzlzERJ49DYFdPZxFVaZPaXlhQunpoZJIu5Wqd1L4k5VKpWKpJTN0yYZGzNb5/nO5AkfktTbpP/MDqVEBGMqhhUqTnAaDPU0y+I8zZKv4AWz1DkyApox1LbXHm9kpGArrqasuXghzL1if2RTvNjeZo6OYii4tjVazT8XHupG/a+l/8XCRPsgnO6xDM2Bh9Yl7YUw/FCtzClAgcBMxYuVRBOapVLLDTkvkLWFFNHYabO1IGg+iyl9KbE/RVE8ZQ2yr3oRy15T8Xw9YP8GbHwUet1vxKnXZHnUqzAKTh6SNYxcxe+8Ygrc7LpDd0gEIVQus38ksYTcUoxB7gd3EVDwJD5vEgUs4kMKlbAeCahGWQbEKttCRG/8B1MHyXgJINVjZibZwepdjPRLTl+PSdol5tCWfOYas+gfo6R+G1TVMg7G4qH/q4OkDGhsSPtYoSyxhwcGm8SbHhs8leaIETu8/4vK6VtQBoYSdJsn+ovCFdecjAMusJTjaQ7FE0jp5lIWX36E8Vg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3324.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(396003)(376002)(366004)(39860400002)(66476007)(956004)(66556008)(66946007)(16526019)(186003)(478600001)(2906002)(52116002)(6486002)(44832011)(5660300002)(4744005)(7696005)(1076003)(316002)(83380400001)(8676002)(38350700002)(2616005)(4326008)(6916009)(26005)(36756003)(6666004)(8936002)(86362001)(38100700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?kNluxV6riXBV4agjhyqK6EJWrkAZZlPAKCTHj3/vfHfrEZ0OPuIOqBglam6B?=
 =?us-ascii?Q?7bKwufrOwcz9+iARKYAdSZLqvoPgaLzfXiOi3hg/Sgz8Z8zYWV/MPv19WUqm?=
 =?us-ascii?Q?sxpKcMwwxkyVkKzzV5rdMyAOGwPWX2IgdvgyJq8zazEaQFcfrdv4pJcJGiD9?=
 =?us-ascii?Q?yd2Gn8uyHKqtwZqGzJHeDlJXQmLCkzI2WPs9eR25ox4SSutYs8z/kJGQuEZI?=
 =?us-ascii?Q?KmeQwZsCZxRnEOmakZAkp6a05ASB0nEXDJC38gY35qTiSRlABMFOoywi8sdA?=
 =?us-ascii?Q?DcebimjhTdqzomaU58pZzxJ6XeUGPirH8r++jlfiNYSpSvbpb3lg2/UoToRh?=
 =?us-ascii?Q?hD/4jbcd6j/gsjaiERXebbbvq31cqyXp4zQmX/LwdTc6piMxTZId7LqrWIz3?=
 =?us-ascii?Q?KS6vE0JB6u1EASVCEtG/gd+G2tKMV3P+lyhCRjxMCdcxSSZcbqM8IQER6zBC?=
 =?us-ascii?Q?VJisxZyyFRdJ2tnvskQk/ijjOMiVpkEOwHvLwv8EquuBlSqPk2oopsCuOgSj?=
 =?us-ascii?Q?8/R14JjBKIkQ7ac3hNA9KbEWqQetfwhW/0D08kUWnMWisVD30PvOnyfJQikt?=
 =?us-ascii?Q?7HnC67ewrWnSS1wxG0vEMOHqOkMX21tzrJmJX1hWU+segcUANkke6p0K22T1?=
 =?us-ascii?Q?T3rsgdZvv61UwautQallfFxe6TjFgTZdwhNHCnyIcR6JlzweNl6KmBQtPwDS?=
 =?us-ascii?Q?dREY6IHgwphspVkg3r9M/yOCDakIuyujDdrKOin+vQvq2ji7I6lN1Kf99kZA?=
 =?us-ascii?Q?Km27NbzctKpx/3m8Zbj15Ix/eO2lVn/BqbeNR70q00f8xgyakFSidmBrSwRN?=
 =?us-ascii?Q?yOtb2y38Y+gw3+G8LWRdHpIL3ALVs9FofVporDVUNpVsPlPPiwNd9DlPn9RJ?=
 =?us-ascii?Q?VWDM1UmUoMlwBZj09zWLn1xv8IBYtQ0oyUT51d9iinByDcGyRZhYwDOSpQlr?=
 =?us-ascii?Q?8USTWeOE5V9kcZUFlj7cV/+AGt91fO1bHtWEk9QCnv+RxX+DQv0uH/SppgJC?=
 =?us-ascii?Q?KGl6ytqfAk7Q4hz3PzQNK3OlQE2vTnc49H1XFdctEu9appHBpy00iH8whF6Q?=
 =?us-ascii?Q?kUoIzkCJxq1feWntTU2RbORQd+VenDQ/4iOc8mM20bJTJk2ZCUQV2yoGQxIu?=
 =?us-ascii?Q?OVdskFlE3BjCeBZx1MX1PyvTFEwzwYen5rTGEt0DOQCS4NmaVbRCw1/Vw78S?=
 =?us-ascii?Q?FQwZd9WAGhjlYM4saZ7P8HA2OzodmDAEllCKODeOkvaY2oLRHZdmmWbvw81s?=
 =?us-ascii?Q?Dz6JuUHOIefQZMYJINo92kA9RlVf/WQnMCRJlIOhJOl8fDxYB5snPJj2T6KU?=
 =?us-ascii?Q?SY7fJhsXZgumtO1UY/GnYjy/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97e983e9-f118-4907-9c2c-08d8fdcc3e1f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3324.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2021 16:01:33.2448 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gJ5f9eovOyCU05nf8rdCv4xOA8jiajVqkKXFMJri3Y1s8znoLtK7cnNsLjCF5hx20imPGdCZdaUVDYWqo9LWcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3948
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
Cc: Kent Russell <kent.russell@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Like Arcturus, this isn't available on Aldebaran, so remove it
accordingly

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 204e34549013..8128603ef495 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -1844,7 +1844,9 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 		if (asic_type < CHIP_VEGA10)
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_dpm_dcefclk)) {
-		if (asic_type < CHIP_VEGA10 || asic_type == CHIP_ARCTURUS)
+		if (asic_type < CHIP_VEGA10 ||
+		    asic_type == CHIP_ARCTURUS ||
+		    asic_type == CHIP_ALDEBARAN)
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_dpm_fclk)) {
 		if (asic_type < CHIP_VEGA20)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
