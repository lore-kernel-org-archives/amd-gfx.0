Return-Path: <SRS0=nRto=KA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC576C433ED
	for <amd-gfx@archiver.kernel.org>; Wed,  5 May 2021 17:55:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B47461041
	for <amd-gfx@archiver.kernel.org>; Wed,  5 May 2021 17:55:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B47461041
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5C486EC2D;
	Wed,  5 May 2021 17:55:45 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81D0A6EC2D
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 May 2021 17:55:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KxhAQOVd2N7wh8pflNZut+28aJBU8qxBxGkfF+xf5r38Bqu3xfopuoJ6A5gMkbivg/piH33zZ84Ch1Dh+ikdNk8ubzGo7nJB5S52tCR5YzPzY2joxSc9orElMir3MJ/cX4Bb1Vhv855CjpCMw/BjqIC+fQk0/2sQFqvFpyVpPmn/Bli7I9mDs+z4jd9+wurt8B90V3i1dpxixK4PNE/4WHpaI88T2qRTRNGIp9Dy+1oZZD2cTjkmNKI4ad18rEaPc2qiaBd3eMO2eamnj/JUi69fX2Og7SA5Fodeygspj5ELvgrqoufdzFc7w/nybz52Ji34GhqptGj6DtV7NUXwCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4DgRd1fCm2RcCyzkYAiYqH/JPnEsQkRPtoPboHOaXg=;
 b=a7YcYAvhOG72d7aZvVlKebI2hDRhXUqfaJZn78lTSYIom46Ub9hpCTRYnElOpjOTP4F4D9s5flj68rptSEhqD2CadOq2EpcI9qYqfbIqsk8WYUlaLfpCKfMP3GfjqTEzF1LD9XwrNdZRceyQhB4bqPM5UtjGYxsAnZiomg5B5dyQArbcIA2WViGld8KxMNUiJsgA9yKZl5s++n0pZgeOXktM9WwO3o7DihzmW/nGHxWB2YTogGdrCdk+hJbJek7N8pG8hQKhUV24kcnTTNpWU9GQUYhjqQlH4vvUMFmV/9pWsBapmGSlhp8uWR/CiGCp9JFZcGmLwwp7n+KD4PbA/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4DgRd1fCm2RcCyzkYAiYqH/JPnEsQkRPtoPboHOaXg=;
 b=DD2zbGgu4z82i12PR97aEkVwFLCYV0p/mnmvYcurT9NqdhaPnx5Up/qTSk7H99LABHNWIy71/KiIBVpsMKGIi+zlv3H1yI/YaH04001WENrobEdWdpTBQWucTXfUgjjnHJhU50ORhggXLIqfeAxZb0ZCor8TPn2hFfvpVRjna4E=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2583.namprd12.prod.outlook.com (2603:10b6:4:b3::28) by
 DM6PR12MB3210.namprd12.prod.outlook.com (2603:10b6:5:185::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.41; Wed, 5 May 2021 17:55:42 +0000
Received: from DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d568:cff1:dc2a:5baa]) by DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d568:cff1:dc2a:5baa%3]) with mapi id 15.20.4087.044; Wed, 5 May 2021
 17:55:42 +0000
From: Philip Yang <Philip.Yang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: handle errors returned by
 svm_migrate_copy_to_vram/ram
Date: Wed,  5 May 2021 13:55:29 -0400
Message-Id: <20210505175529.30180-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT1PR01CA0108.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::17) To DM5PR12MB2583.namprd12.prod.outlook.com
 (2603:10b6:4:b3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Philip-Dev.amd.com (165.204.55.251) by
 YT1PR01CA0108.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.38 via Frontend Transport; Wed, 5 May 2021 17:55:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: baea702d-d953-4420-1e45-08d90fef0040
X-MS-TrafficTypeDiagnostic: DM6PR12MB3210:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3210F6A38F5C9C840D7A03D8E6599@DM6PR12MB3210.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:549;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pTUc76diQEs9lW2bYjCxvP281Q6dYuvFEXJZ1SoI3Q01JNo+zpgXEzTuNq7Lcoc3oY7Gf3j7zRL0P/fkRBZ/w7HXOhJILj2hvCIzGGnpP76gWf3xtiIY6gcM1AITwmF+cZ374xrsimX/yGuXJAe48B9ifMWs7ONllqSn39IB1suLPgMut9wN5NN7HuHyoL7JOIWXVWlqlswA2GjC2AZRGXNkLyU0pZp7in1TALbpIpDaInt+JlLlw2j4MrScY+AgMKi+FfmI6k3z6xyzaQymOgV4VtZxMcHOGTxvycEjnzur2lIDskbBF3dBYEhwlpdqKmwW3BiycrkVjpjs02ElkR8VbeJXXQmwOvgXqy38PyA/vPtl2YCKdMdSWjCTfIlmViMkI2OzDRmgIbFkZHbbQKViHD3udoJlxeut5GtCXenWdmpD7NIJtNAtcJ4AEM5i4XOIKvjXqVA7wtcKfcHdS+hngJfWhIGBZj53BQP+gr7Guk4/caLmVoL+xqr/lG3jDR98Md/+Jqir29i0iweiEWl2JrwpokSkHr0DqIkCH0kyqQ1MrnM3MbjvP4teUeBc7M17JexXIdn188+5xOVFtrPDdfrWR8yxe+4b58WJ9csSgSjJvcb5RXFHPIH7kJqQ4XCJyLgnP60qPtZNMmax5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2583.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(396003)(376002)(366004)(346002)(4326008)(83380400001)(52116002)(7696005)(8936002)(86362001)(8676002)(2906002)(66946007)(36756003)(38100700002)(478600001)(6486002)(2616005)(26005)(6916009)(316002)(186003)(66476007)(66556008)(1076003)(956004)(38350700002)(16526019)(5660300002)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?sSgnSLE11AChlvwFQ0Ggbmxji9XV95znURU2SRnIiv0H5Q0vqHWV1FtBeNbT?=
 =?us-ascii?Q?xlhZONyo8rsP+wC/KhsGklH48LBaSkV8O/FzIpnVnaoYG4AaqJQAKazc32AO?=
 =?us-ascii?Q?GVoZlm4glSE5LuOjWr7ODE6e1rruh0oIkV3ZJouRC0RbByS+0KwXEYSiPTy3?=
 =?us-ascii?Q?Tka7Q8G3m6fnvA7BD+lWlORV7z+OpU3EGQvzll/zj9j3ESZ4ZFj59naDneDQ?=
 =?us-ascii?Q?3t1riGCFJej1hZFYDp3oMofisQZYTJ6DeR5+nOx452lZdQAqrLP4Y/7TUHfX?=
 =?us-ascii?Q?1M57SYYRvqP20avvijA9vOAvF3H4Rq/hk0KCe9No7vGO617n9uJ0boah4dbW?=
 =?us-ascii?Q?4eqt2kJTJnte75j3rVmKyhY8L4MICmQZcnfO+8E2hLf5JcbPFya7aOFY9OpD?=
 =?us-ascii?Q?pbMkgg127H3oXQClY6mFhTIO45NIJixAefhemviHTI3J5BDNUN6mIXnJBJrB?=
 =?us-ascii?Q?39eqf9d4z4C7cJN79al0l6sP1MPAMvzVjNq86JevpHUzWgKNliRqWL5NFjeF?=
 =?us-ascii?Q?5+Q4BsdnkLi+N4ZMAVhAfTRjjfmP67HKqA6fSSsGYQHvEMkq4hvuNOg8K2Hk?=
 =?us-ascii?Q?xRFk34UqXSj7La/8ZcpKjR+rMaEA9MHCOWoKJGRUPlZhIPmNmBIKbi17RaXH?=
 =?us-ascii?Q?TH/t+aW8peaSXm/tj92x4Vzx7YB1lBIiBV48ctX84jx4KW4GTfVt8l6tasuN?=
 =?us-ascii?Q?eV7FkT+dPYAXULQYlxP651ATJKrS804K1gV1w8LQc4PrX7d0bnLvbWHJcOjG?=
 =?us-ascii?Q?l62/S0w+DJkiYMZ+Lxevuklo7OKl8IQPjop/y7uZxA10L7OYglj4LskEo3If?=
 =?us-ascii?Q?rnYhN4ta3Vog64/Rp+ocwo4LkZWVgjUustLvBU1Q+cUHMiKKRbeic/lSqljl?=
 =?us-ascii?Q?FM+YlzSOHpGK4He/he+5b+X9ScTdqh4fqOswejV+8kQlaIU0BrG4ayjYO2LW?=
 =?us-ascii?Q?2myiG7mYKEwlf59cxdT7aG1+rca0bPUa58q0r3doFiSsUp1CUAgFqUVWulGO?=
 =?us-ascii?Q?XcI7hWmG2kUoyht2vQGhN/jke2gxaDwtwqNKf1Svp9lF+/iTz1QXgGa3t6wP?=
 =?us-ascii?Q?hpTUX5dd+qCou2ZVDwG9Zx+aDmG5o/0zv/yCHQmPZtt6m2j4SIjKJbqr6wmK?=
 =?us-ascii?Q?3WkoBEQTZpeVhauts4740KSHBA1unPHvqkfDwIA6Bzwgt0UDp5YE9owr9KJr?=
 =?us-ascii?Q?G+M+F7sEMtbV2Q2XQaCW8403XgJdDnu5ZneWu9g5iq73I905xfZrtRGS/k6m?=
 =?us-ascii?Q?i3gq4AOAi7WJzzJtKsRqxeJ7VLzypWstjvdtSohAjaZ5lCor8XbzMkZ8wqmr?=
 =?us-ascii?Q?8GA3Z/vs6xscORBKCmOPKfAE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baea702d-d953-4420-1e45-08d90fef0040
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2021 17:55:42.6827 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 53Ue1v5ymQUGbQG9PF0yWv0GDXwHLsluUNG5hU52wXEWDZ0P7SkV8a2DsEnAsq+e
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

If migration copy failed because process is killed, or out of VRAM or
system memory, pass error code back to caller to handle error
gracefully.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index bc2fc528ad58..fd8f544f0de2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -460,8 +460,8 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 	}
 
 	if (migrate.cpages) {
-		svm_migrate_copy_to_vram(adev, prange, &migrate, &mfence,
-					 scratch);
+		r = svm_migrate_copy_to_vram(adev, prange, &migrate, &mfence,
+					     scratch);
 		migrate_vma_pages(&migrate);
 		svm_migrate_copy_done(adev, mfence);
 		migrate_vma_finalize(&migrate);
@@ -663,8 +663,8 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 	pr_debug("cpages %ld\n", migrate.cpages);
 
 	if (migrate.cpages) {
-		svm_migrate_copy_to_ram(adev, prange, &migrate, &mfence,
-					scratch);
+		r = svm_migrate_copy_to_ram(adev, prange, &migrate, &mfence,
+					    scratch);
 		migrate_vma_pages(&migrate);
 		svm_migrate_copy_done(adev, mfence);
 		migrate_vma_finalize(&migrate);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
