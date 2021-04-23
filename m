Return-Path: <SRS0=d4Si=JU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56108C433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 19:02:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DA8D6124B
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 19:02:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DA8D6124B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7F8C6EC2F;
	Fri, 23 Apr 2021 19:02:56 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2041.outbound.protection.outlook.com [40.107.95.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E85C6EC2F
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Apr 2021 19:02:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kx76VjVMflMFCpTWJ9+zBzkWfvvvnJZ9vQxvbnFiV00HVvGFRcItNfHNwa4MZI1IWfWGexXSgr9cQpf/tHXHkOFJ+hSjioqwBYquY/OmOCBzK2XwkZ/8vWyBpUqCLLxTLRNzzKRhb7nWJV36TcT9ZVgLrfSW2BK6B8qi39lxIB/iuXtDQwhnhjVcfjcQcJb9YjjfV4G0ZCA2w1oluCrjRc3wyLlpGnQZqGKavvT0k3ef14tmcmBtHRaHVx9YI+GZEU9X94ufw8AdiUeKCtO9GbzmrobeRA2ty0vgTy73hJAe513d+WUKZOMGFeHyfUdUV6EaHL4USB3YaJ/i2wAkpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NB75VhtwUUUFsCwqcy0LzBxTD+Nx/NkPxM3DBwJpoyI=;
 b=DcpMTGubu18nJRj9qJb2/sTDSI6cwH6qv0qUexMFnXflFgSh1RIQkmq7rmeopplOxyv1T+DkXua3eblSOF/vp04HYmhdbAESRypbSQqK1dHrEK/llyISmXuzX9P6WKmN7oWQyueTXb81jwhpjaiIPTuryFltYlSmC4pS0rr8R/NcWZo2YyVMg2mgMJLb8AYOF96inNA6GRxL2fn5+809GEzvpByhsWm+qH6Kn+x+0+k68CoG+hTy443l6KELJ0TWZlSXGqGniJs8p6xBFkmJajC2mWS574bUelDuiWVUQLKbwrf9zpqFti8VSjH8gfBapItVLG7Ko1OaNWQ9de9A9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NB75VhtwUUUFsCwqcy0LzBxTD+Nx/NkPxM3DBwJpoyI=;
 b=YA+zKLpjDEuYvm8Dv/fBk9kIMohAtsqKGY3aVglv7brBE1A/1A0BYy2xLIBnfo+W+mIT06tJc84tIwpQc7E0rUO7sL6aFfYbh9sBKoibt+SvXaVD/HuQ20I5cBKdyCHI0m9mK3PXCWIBv0Kji+gxQpB+Hzqot5gIJSSCTLWxu88=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2761.namprd12.prod.outlook.com (2603:10b6:5:41::27) by
 DM5PR12MB1180.namprd12.prod.outlook.com (2603:10b6:3:74::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.16; Fri, 23 Apr 2021 19:02:53 +0000
Received: from DM6PR12MB2761.namprd12.prod.outlook.com
 ([fe80::5194:b381:c345:eb0f]) by DM6PR12MB2761.namprd12.prod.outlook.com
 ([fe80::5194:b381:c345:eb0f%2]) with mapi id 15.20.4042.024; Fri, 23 Apr 2021
 19:02:53 +0000
From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/pm: Update energy_accumulator in gpu metrics
Date: Fri, 23 Apr 2021 15:02:42 -0400
Message-Id: <20210423190242.2118230-1-Harish.Kasiviswanathan@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTXPR0101CA0034.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::47) To DM6PR12MB2761.namprd12.prod.outlook.com
 (2603:10b6:5:41::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from harish-base-compute.amd.com (165.204.55.251) by
 YTXPR0101CA0034.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.19 via Frontend Transport; Fri, 23 Apr 2021 19:02:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b7dd5a8-781c-4df6-4b7e-08d9068a65fe
X-MS-TrafficTypeDiagnostic: DM5PR12MB1180:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1180D37B94C1F53189315D2C8C459@DM5PR12MB1180.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9EkVEyLXDjXCwGDaofTWiCN7mFr3rc8VVzHDPTvGD1ohmBt/QW4FmNav4DfRkekqEwbwre8EiKFxenGn+sgfXW2T3E62PQjcraueCUZg6f9Hl+61mQT/BF2A/gQFeuJGi+/L9IbdTXqv+jkHb8ApLZg0J9u39hYr1KIBegLxJW9g5Jqx0dOWodPga6z00D7Ozteu4HTOj9gDH/beKndX1HnIbAEeKzeGkp66LjfCnErbDHK4Z302EHJLqDg0jxvoFDC/Cn4u+WEhh3Lb/kI6AQp6WVFJr74VHifQ8gLi9id7TOnxEPeJu4grQKU2EvIL07RjOwqV9VgAwytpicxn4E05o/+HTAcX20etOjXn0D1aa0uclk3vOEvs9ESW/+/u4fYroWbgcbrXQYVMBIoE5CtnPzZvxfN+KDsahBW44E8qXN22PstJXUYTGsTLbVSER+hqqXXVfHsEuuQ2zrg9HqIjwPkrsHqQ6G1hgvbX5kxoPL9MVXZtK+C6iu085GuxwkIq84UwR23NNu1nr/ivonVYYf3Bb3nEbBX7sCtEAajWD2J+tFEu3N2Prd8ag7gqO2tEwcIFofR/3HAfFDX/gcFmCH8Qrazcif4aPzxAjYwLz+sXVIuZfc7RGrbL+EQ1ykMs4UYAHDXrTi27FQ3jNA8Pac5eHp3uKsiyLGz3Ys0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2761.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(39860400002)(376002)(396003)(366004)(52116002)(316002)(66476007)(6666004)(2906002)(38350700002)(8936002)(86362001)(956004)(1076003)(6916009)(38100700002)(26005)(186003)(5660300002)(4744005)(66556008)(16526019)(2616005)(4326008)(83380400001)(6486002)(8676002)(7696005)(66946007)(19627235002)(478600001)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?vdzuXcCRRtdr6YbgL8HCP9UxXh604EhmmEU9ypyZBSUSnsbu30bsdoRwbYon?=
 =?us-ascii?Q?cljYQ6xt95FuZVpKl2Sey0ph8XE840dy+7LbuDejlpmSWOsbyqY7YQhzXVHX?=
 =?us-ascii?Q?0oIR/xC+61cYbZlCKdzfcouNu95YPn4DbrxwSxrvoqkOlLs5bndm+KvDfhJt?=
 =?us-ascii?Q?8uVw2FCun0o4nombgVPrTqZ48aJIYuQNn46Hdhy58hpqmkVODxau2dToxACZ?=
 =?us-ascii?Q?1GUFu8vzjiJbMewYVsCLJ6hoxskUnhgLKNQ8RH8lNQ09JCr6i/ixYoW2axEJ?=
 =?us-ascii?Q?jJWEbrDfryCili+l7HIxmlO5MRkVhsqntdaZvORdbnRbUd7u1Y4agW7J06Hb?=
 =?us-ascii?Q?N6Ht06dnlDF5E6cMlYkM5qsGyzFrJRKp1XX1GpDeiD8szdfjvqj/BZPEyAz4?=
 =?us-ascii?Q?Bi90Pg1+XXExIgWj4z3uB5fIEEtdiaxOKYUbHJiwkgtNFBDDz/K5meb2Mwix?=
 =?us-ascii?Q?DvSLevevcFQW9bMZb+N8VaOEE2l7kMCpRgCgBN/AyYxdKkbCgQ0V4BNfE0SI?=
 =?us-ascii?Q?oa4foA/oZZwJWxmFuUxHWU7ZlsxpLgbSamJBmaRqGg0/q9jmFxNge6CQO2iu?=
 =?us-ascii?Q?89XNCdPrmp55nIRYsmPYNGMccxA7u1/NWeLWIHUdOrkeMLTjWKi+LXogmgfK?=
 =?us-ascii?Q?D58oyz27bBs1ZcMkKUDLhEjBiZDBVaf6O4/bV6BTmCf6mMZXzrlYHEZqeo1I?=
 =?us-ascii?Q?LHOrGCWRmTgNeUKkIJZDOszTeAdT7Z6QLf4Y5oYeJD6subF3ac0qUpXVD6Ir?=
 =?us-ascii?Q?LJRyXpL0IXMPAJ8Yj8btJ/etmlTdQeWU3/gq8RMPd5R0Z+zLDtM98Ty3nCN0?=
 =?us-ascii?Q?8E0j8N3wOxRhxr5F/8Zf7DFayJOsMAp8GCEkq1Enaq9gknsWvp9j9O93It0J?=
 =?us-ascii?Q?oR3GKbCR7ycSQ6rIwFSHGni0Wqk94uxyNnAfVHbVWq7/F3zVii7hPzaLz9uN?=
 =?us-ascii?Q?VBitbedOWzVBThSPegGxOdF55Sq9mZYouh4nE1pdeHQKJan4Mi3zqWhuRhQu?=
 =?us-ascii?Q?yz+EUoeTPJBjzoI/zUmGgoUulYLSzxprFGtLeqV8xHz0JRgD7t7Fk7m0uCjz?=
 =?us-ascii?Q?E+AVVJa6wP7b05qDOOH92FLiQkaD9nPmxPZl8Bou6e4qFp/b+qjMQXwNFmXZ?=
 =?us-ascii?Q?K4tMwTbY+Ryo5u9vufLwHZzdyh9CqPnSunWNAvknG/4hWtwTNUlc1Q75/JYG?=
 =?us-ascii?Q?aDx5KNAAZYQJJtL19Q2CUUC5buVzzOkR2m3XLEjAbC+nWvZSZ0NFM6PXBEz3?=
 =?us-ascii?Q?fAF/s3+SUuUc8gAw+jjPyk4iU4ku74Kabg1vujCLSr6pi17NjOBT92ZUGhXh?=
 =?us-ascii?Q?Z7snh/qo1+wJxCw10BfTNaTW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b7dd5a8-781c-4df6-4b7e-08d9068a65fe
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2761.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2021 19:02:53.7872 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HDDjmKTIE1hbauZOcb6l/w+feFqGPDkHGdg5B6nYElX2RPtTB4SS7wD0gAWHIOv4HR1jp86yHG4OEgbsbfAUNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1180
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
Cc: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index dcbe3a72da09..1f02e4ee2909 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1657,7 +1657,8 @@ static ssize_t aldebaran_get_gpu_metrics(struct smu_context *smu,
 	gpu_metrics->average_mm_activity = 0;
 
 	gpu_metrics->average_socket_power = metrics.AverageSocketPower;
-	gpu_metrics->energy_accumulator = 0;
+	gpu_metrics->energy_accumulator = metrics.EnergyAcc64bitHigh << 32 |
+					  metrics.EnergyAcc64bitLow;
 
 	gpu_metrics->average_gfxclk_frequency = metrics.AverageGfxclkFrequency;
 	gpu_metrics->average_socclk_frequency = metrics.AverageSocclkFrequency;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
