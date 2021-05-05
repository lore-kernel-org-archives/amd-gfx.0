Return-Path: <SRS0=nRto=KA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 969A5C433ED
	for <amd-gfx@archiver.kernel.org>; Wed,  5 May 2021 17:56:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CD5E613C3
	for <amd-gfx@archiver.kernel.org>; Wed,  5 May 2021 17:56:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CD5E613C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97BC66EC30;
	Wed,  5 May 2021 17:56:33 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53D216EC30
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 May 2021 17:56:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mrXx6fLqN3YgNTVQDLSv34Edls3XSL2YPJritjhfJf9a3/ZQYnmYu0K01lQIpoj/qd/iNNeL/dvo6V2GngU94TU5w/ItZprYa03gLVO9VWjzwpcD7R7z9Eprnupey1oAlKRQZbonqe1I3G2wumPfYOXp0TC+MrOzuHWNbQllHt91oWmeGV11ByXIv+LDsJPi7DioNTpleTydoHVJkXAUILH6+mo6YHLCN/TfuHi46v9sFGCWiJneRzyRqpDFU21b0gO2di+/cnJINL+EpPhgJ0ZRYvynVmMawyRBhOCI6zUyy9igxLh/SsSRf2pPgux4Q1Sj2zIDuS9DuCkQVZrkyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fc3EpaxAq3EsT5E1M94PokLtDNGH7HJ00BoxCNlgIP8=;
 b=klfikjcOemS7IMdHl4bNZPg5YQFO/Dmk0oJaPmgjcLURa9opaYI9CJbyZk3aDVXtnn9fw6Q4eK58S3Tf/0EacZvcaYc1+HTH2M8/dyL6UIgBPN4QgLw/iCjvuJ0FjFe+K1qYQOycFTRn5LmMyfaOx2cSItbl3IYj5Xpxvn1Kxx4TOTx+hEigz9u/JmV0ariQcH9yk8+cF9C2lBLgiPxRXxklxFEJz/5l9aoCxjeSrZvkBLRXRY2zrPUMqDN8gYZ8H4kcFERZKYWvKeZb2iVPWXFMvXtoLtNDz59xXevK72zthAfMBKRZfq/uDrWIG14EfmYoTwDUGxOpwsZv2Dlyyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fc3EpaxAq3EsT5E1M94PokLtDNGH7HJ00BoxCNlgIP8=;
 b=E+hIBS+txUCET13gDhlupwqTVE6KVI/gIBpxw1iCw6uOuudK2frnDxzvIEAtSkqRMlBPSNKyooyiDRxY83I9SYGdRE41Q2WvojgnrHw76rpzScbDKvtwu4aIF8IpaFGCCTQNNmAAHH1iVAoDSWEonLPje9CD3Ljv03gOFBXX9gI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2583.namprd12.prod.outlook.com (2603:10b6:4:b3::28) by
 DM6PR12MB3210.namprd12.prod.outlook.com (2603:10b6:5:185::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.41; Wed, 5 May 2021 17:56:31 +0000
Received: from DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d568:cff1:dc2a:5baa]) by DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d568:cff1:dc2a:5baa%3]) with mapi id 15.20.4087.044; Wed, 5 May 2021
 17:56:31 +0000
From: Philip Yang <Philip.Yang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdkfd: set prefetch GPU has access attribute
Date: Wed,  5 May 2021 13:56:16 -0400
Message-Id: <20210505175617.30404-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTXPR0101CA0051.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::28) To DM5PR12MB2583.namprd12.prod.outlook.com
 (2603:10b6:4:b3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Philip-Dev.amd.com (165.204.55.251) by
 YTXPR0101CA0051.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.39 via Frontend
 Transport; Wed, 5 May 2021 17:56:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39216751-9ec2-4ee7-9984-08d90fef1cee
X-MS-TrafficTypeDiagnostic: DM6PR12MB3210:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3210C109C806CFAD04CA9042E6599@DM6PR12MB3210.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: usOQS3HqNdXD62U7pYeUaDHDkATzR68WbRe7fRMFn9ovZ5PvMdlxj6S8QtJkrqKGNyxNV+MV4ENVfXEQq1PxCd+fnL5Tg0giEZE10SHuKMd9B7JdJ3FWbGYWDvVeJTQcKSLqcpc+kVi64p04rLQfWAQLXlt7OOpKiLG3U4XGoA89YE40aeNY8HhzIK7sEGZtqR1wVMaQhLQY7l59ScEMWTYoudW/QSZ0pQ0Jg6IgeLwTP9id5SpU+WaItR/5st9toaU1oujz4lyBxzZl/SmdCeS2+uOxssibpYvUpU2fyslvLPErNQqSQ8WPbnvGDl0JHR6x7pLejNq8z4XsUxloUqKSU9hrRA/7TvYOokiEsVgD6nWb6WOM42qAemrFu628T0NVLNQvojQAo11bZ8j8sQnMQhP7IY8ioXzeLOvEO8Chhy/ar3DtPBVDSAE1MKGeH0oH+b3ScDuLTz7hTC6DfV4aG3LvcS1pqbIUL3UIn0tY6AEk7r0nR1BUSgo4Ow9CmMq43u9Zljy1lfrE7I9kLpUMvS/PbXNLTBax9Rsu9+AZ6c+mnq05pXHwLEdSQWjcJPI4GjtlADimQkbX/W23ajxSg/19NrIqYbI5vIA0UWDi5i+Ne4mAqFlqK4KWmxdhhfPJiIXlUmFUcMkzG7FC7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2583.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39850400004)(136003)(396003)(376002)(366004)(346002)(4326008)(83380400001)(52116002)(7696005)(8936002)(86362001)(8676002)(2906002)(66946007)(36756003)(38100700002)(478600001)(6486002)(2616005)(26005)(6916009)(316002)(186003)(66476007)(66556008)(1076003)(956004)(38350700002)(16526019)(5660300002)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?BO4eSuMDiAVfrJJywP098ofvh7bbzNX3uEDpMafcSiHWaUw6zRRFzpaU0f+Q?=
 =?us-ascii?Q?QoKiIYqJaBblbpEpoQLrqaYX7F5raoplB/SUws2TgPduQdaZJpjiUe1e2BZd?=
 =?us-ascii?Q?+Lwq69um9s/nYd/guhnXbBJrfEC1jkhVQ8TAPjkd+FAZ2WfsZhkx6gF6ksr6?=
 =?us-ascii?Q?qKI7X26wIBAVd0vAm+tleQDNwQhU5avo6TFmCnPQlk7E9nFB6mksu9M6q8zz?=
 =?us-ascii?Q?s9tqOq99MwxY73JzdvV4fsQ6H0GZcoEtlsspOxy39Mq3xfI9SjRg/kCrKYMT?=
 =?us-ascii?Q?FQL9RmxwRBaJ3YoqlaVKYOTrnwEsF0oPw6FQL+j72chC46GGTmcbemhWwQw0?=
 =?us-ascii?Q?TvVLoUkyl+Ioi6UvHBTYfWm/jOYnEHyLCSJhW5tm5kIguMOqfk1jb1peRFfB?=
 =?us-ascii?Q?vLhvQ/FbtKGE20SA33fFCgjvmcQnFAK9Bu5YwlUTAoOVwOQuJHry4L63j1ZN?=
 =?us-ascii?Q?/fXbh2bTqw+3+HFr2TgiQFl171HIMUgxylR8BaPdunP19JbEy4bbURQ6dXJ0?=
 =?us-ascii?Q?RSDQPnmz18F9ox2xIQ8gri/W3btwgbaX694ktDkAbn1Wd6sJV7b64DDAkobd?=
 =?us-ascii?Q?23XL/8Vq7bKo9gfQLWbG3CmwkqTMdpOJAfKSvesBpVdMBbHeA5r7hWCWrf2O?=
 =?us-ascii?Q?drBr7UBYNqpeQIOsI0drrqXMx9k20CSGS5IDeCmC5wqcUx2o5L61H5taJiLu?=
 =?us-ascii?Q?WdCycdAXHPNdrAJXUKBp8REZyHZ5eOTCc2MuPfZ6nmTTG1ob9XlJlnE3c2YO?=
 =?us-ascii?Q?+dmWpr9nLft47dlWZpcCf8h5aLIhVelAWwMzYvogQpkefrhbY/FRZMumEcMJ?=
 =?us-ascii?Q?I5P6xB4Yi1sxW6poSPY9reyOo/wltutznl1+hlt7kpnijdc7yX2Ntd3r4nUa?=
 =?us-ascii?Q?n17LLt4nj1ME14zO+EBicBP5iOy8Oa5jkTPTr2vrpDh7dqtg/8d0xuGpYuS3?=
 =?us-ascii?Q?xgYgINFRdwfKxTsoRgdLMjGRHEXnTQzYChdwZXQt1/p7WeCCrambuiOeA4qk?=
 =?us-ascii?Q?OwYQV29jBGNE5lfYuHRqdmxyeZodq/tfBvOMNtzHhO/FTA0LfYd4SgdikcSK?=
 =?us-ascii?Q?FfGA/jQRhn/VX5D/nP+Ysj2x7SSy9Yep3Bxi6hLJiPWMRYCohieUSeGBXUp1?=
 =?us-ascii?Q?lHSR0Rp3WJWPbZhwJK+tKgCCG3kfdGPgPojgnKiHuSw/UsJ0JccJ66oh6rpx?=
 =?us-ascii?Q?69U+hcYVbZujk513Fl0K2c+qLbQvrnkOKHksdf+4LJU/467pQL9rFABDemLy?=
 =?us-ascii?Q?tHNBqeAwoCY716he+cOzl3KenMy8J8YtMnGh6UYci6/A1Q6KJbXhm2FraD8m?=
 =?us-ascii?Q?9q8yKxlqFL9106R51hnqsAj0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39216751-9ec2-4ee7-9984-08d90fef1cee
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2021 17:56:30.8344 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: imJbbaQIcsKZ63Ty6wJc2BEaHkmeTkkBZQzxY13QTSm6ADJ9keEIoQGpdyU/oigu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3210
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
Cc: Philip Yang <Philip.Yang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

After svm range prefetch and migrate to GPU, if GPU has no access or
access in place attribute, add GPU to range access_bitmap to be able to
update GPU page table.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index d9111fea724b..3b640772d9c5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2869,6 +2869,17 @@ svm_range_set_attr(struct kfd_process *p, uint64_t start, uint64_t size,
 			continue;
 		}
 
+		if (migrated && prange->prefetch_loc) {
+			int gpuidx;
+
+			gpuidx = kfd_process_gpuidx_from_gpuid(p,
+							prange->prefetch_loc);
+			if (gpuidx >= 0 &&
+			    !test_bit(gpuidx, prange->bitmap_access) &&
+			    !test_bit(gpuidx, prange->bitmap_aip))
+				bitmap_set(prange->bitmap_access, gpuidx, 1);
+		}
+
 		r = svm_range_validate_and_map(mm, prange, MAX_GPU_INSTANCE,
 					       true, true);
 		if (r)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
