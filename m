Return-Path: <SRS0=yJoC=B3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787F3C433E1
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2020 17:05:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA9042067C
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2020 17:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YdN8N1Lh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA9042067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BCD189C33;
	Mon, 17 Aug 2020 17:05:54 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2051.outbound.protection.outlook.com [40.107.212.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D335289C33
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2020 17:05:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LVAGVZ42SvpE9EC97TJbtddDE5asyBzkqrNv4hh8V0udIIlfEJdVpk+a8Kcsiw7iXNhEsdTWMNmQNvjj3sxMgKxVtkMWVHCTUhtA/Jl0eEPsFhKzMw1nrc7TnFNkPVTvZq39MMXXhOvCPY2bq8hpKERB8nbx+KL7eKnBF6nWH/C8T6qS+C4Q5hssPJPKd6JeuOJvKifwKUwdMoBh4ytuKM1m4wgJpeyi9mlTGpLjguU52uYfpphLWTEbv7hQoVaus1GbmP/R99yA8+zqo5OKnOFg38L/G8MF5T37d4VcRwzfZIUSM4zuukObmtciKGYGrk/w4Zh1txHmfg04oomjEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fcz91HDrmSbL/Gb2l+lWtUMT+j/83fYUOVJRGYpTPGg=;
 b=JimQh/FI+AmaubRVPQA0ASHVb3jLchcaSXOLBUhcB7BmXarBWw6Y05Ce2H1ThOpyzkoeGFqte/vGLHwgAwxnMJTTjvyabcs4+2HntunCiL0dSFA37KzWfrZTF2ZA3IlgxRf0EWy7CLCLNJyrCjVstqPXmUXd7+cUAWPae92tfbuZQQ2PuDvoYu1DQkv4UqwP32B6Gzzv7rDIM0LegGCQaEat/YYWeNJAyGFJvCXZU2g+VkW1U9SnUwHi1QUeB2G8LhZlkpKcgbmmR59l07KnKl6CYKld3P4OG7DW57GKXDPU+DPjYW7HmrD6vxupS9MfHFGRI6nPrSdIyg2flGHzAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fcz91HDrmSbL/Gb2l+lWtUMT+j/83fYUOVJRGYpTPGg=;
 b=YdN8N1Lh6W6XP3yxGvNVUMkqtqfJUIttKn6zK3xyDUXwtuRgJVd1WgC/6TRjZMK5WYDSWcsUSALMomLQfLB1TJdAAsDGAeQm6nu3xBnmL1sp5KfuREqcBBo6K94OfL4hVt+rmnvjK5wHBQAqb4T2N6fPcWk2Qnn2ehjmFm1G4wQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN7PR12MB2738.namprd12.prod.outlook.com (2603:10b6:408:2d::11)
 by BN8PR12MB2948.namprd12.prod.outlook.com (2603:10b6:408:6d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.24; Mon, 17 Aug
 2020 17:05:48 +0000
Received: from BN7PR12MB2738.namprd12.prod.outlook.com
 ([fe80::89a3:6be6:c99:23a4]) by BN7PR12MB2738.namprd12.prod.outlook.com
 ([fe80::89a3:6be6:c99:23a4%7]) with mapi id 15.20.3283.027; Mon, 17 Aug 2020
 17:05:48 +0000
From: Mukul Joshi <mukul.joshi@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: Initialize SDMA activity counter to 0
Date: Mon, 17 Aug 2020 13:05:31 -0400
Message-Id: <20200817170531.15457-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTBPR01CA0019.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::32) To BN7PR12MB2738.namprd12.prod.outlook.com
 (2603:10b6:408:2d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Ryzen-3700X.amd.com (165.204.55.251) by
 YTBPR01CA0019.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.15 via Frontend Transport; Mon, 17 Aug 2020 17:05:47 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 12ec8162-c102-44cb-4161-08d842cfc953
X-MS-TrafficTypeDiagnostic: BN8PR12MB2948:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB294825CD1E6A83BC8C9B8195EE5F0@BN8PR12MB2948.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:361;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R0jTtXKXsAWuPgqv+lOu9YEIgrYlO+L5ZVWviLYA16JVY966zdk6hErrzgcsW6uFuHNDn2JykpothGCigq2TcsNIlPiXeKk4XVTvDcQfjOtUXCUc0eeqFaJXaoUUBb9G7jNbm9KN5XbKri6PvNgsUB7I0GGqPKBEArbXU+CpVSNpbacyXeaAa7JYVpy9qkOOloMQunqLZhMKuLhpkkF0/p+k7yGLAW89mNPRKQJ5kP6D7abG47naM2dbBuKl++0/M250uAQwUCOR1I0CopduAnEfTpDg910aQVSKZ6rICcHiubLrJAaVoHN9b/SpYYAZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR12MB2738.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(39860400002)(396003)(366004)(4744005)(1076003)(8676002)(8936002)(4326008)(5660300002)(36756003)(66946007)(6666004)(86362001)(478600001)(6916009)(26005)(956004)(186003)(7696005)(52116002)(16526019)(44832011)(2616005)(66476007)(66556008)(2906002)(316002)(6486002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 7s/LkUOjUG4DG72nQNPubKz2VnsewFtDFq+KqPr/N+RUhaYorvGVYe1oeMUkjH9kp6+nDnCE87mCkP/QQoRmQ9VwoBnPfth3LA0uoOeNBNitvH4mbb2mhcm6IEXSjoboiwTwJTQZbRdhEu5wDwK+VshJJLO1LwOYtAZpvbbgRr4k10lU0jadZwnNex1CXblgXY7OCdTuZEXQz/zQC769uiiyuLpnO2cUnuSYo/As18dDZjB7yNV4wpgo6v3q5dfYbOHBL0J7oIJdCei92iskifU6sk4uOApV6TOJanN5K8YxUsKY3uz2Wvsb8p/0U/9yl1qAUijYYSGo577oJtdlf8zzHeS3+BcOJ+mN1zu/PCGCo6iOp4Nl3YZ4N+TfGC+kqM66eRjjnhGWrN7LAyAS1ju/qjIkv+JGVnqjiN68WeSEI92S1P9kVQMVAc9wOw+k2Kt3x3hKbdPy8IHEmxxE3Faoh9fgJqodeXshme4aer1SNu7tJgHdvq+zB8RmivK1l0uLGLHELH3N18uzY+auKkiYwz9HM/v930KwdI6IHSYGZ2Jrl6iiNmLcFCFsIL2P9Esh7VbW1w8/73Q0o1B9H++Sw8muTtWrOv9iKvReld8vKg8EqUez9BaUpJdt1/AXNaOIJqFwR5zP43mdHenpfA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12ec8162-c102-44cb-4161-08d842cfc953
X-MS-Exchange-CrossTenant-AuthSource: BN7PR12MB2738.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2020 17:05:47.9003 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I7cB8PmdVpwoCNPrq8EerJF4KvYiQaSAxpu4gUFAoJnoTZ623q+iQrk8zpZ8T1xRy4JJFMNaNY8ry9+VLpRSWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2948
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
Cc: Mukul Joshi <mukul.joshi@amd.com>, Felix.Kuehling@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To prevent reporting erroneous SDMA usage, initialize SDMA
activity counter to 0 before using.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 013c2b018edc..4480f905814c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -270,6 +270,7 @@ static ssize_t kfd_procfs_show(struct kobject *kobj, struct attribute *attr,
 					kfd_sdma_activity_worker);
 
 		sdma_activity_work_handler.pdd = pdd;
+		sdma_activity_work_handler.sdma_activity_counter = 0;
 
 		schedule_work(&sdma_activity_work_handler.sdma_activity_work);
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
