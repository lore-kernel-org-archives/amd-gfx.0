Return-Path: <SRS0=awHg=KH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A6E5C433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 01:51:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCDC561186
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 01:51:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCDC561186
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 749426E10C;
	Wed, 12 May 2021 01:51:46 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCBB46E10C
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 May 2021 01:51:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kLKV+r7Uhjv0xV4XSRNKXoKMsjkTH6Lwrg508kpHMA4X/bWChOMCmP2jy5FUyi1Z1MUFdnHpDrhV6k38U6XjmBzlWnPbAFL5qJF4acQuimB0Q1Q2PXRnkX6ihK/cEaaU4rAGafQfH9UdNg4byCYET1iKLLDyGBCw28ZGbvaYSlMmPnTjoiXcrevcMgGAYTdgXtI1E1SXKqzBHP4qQGPB+kEe42B24pjHRp/JYV6EpLUOtyNO1n58ECIrWcahxeCtkOwhi8DuChMtkHXudLCMw1lToWKmAqFLk2eS+Y/Yz/fbtsJnxqqkGvNAT28UbeoCfSPTOUcHdo0N8dDJa2u85Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vNVjaX3X8ny4TUnx81BrP5o/Njk0bdyPyscT3xw1Rz8=;
 b=Er96ttjSqDBNHhVyShnzAZum+wu6sbCIjuzk2MQz1/5i1sp91tgCMlBjaJW0evwXyRubF+ftPHYdevzjM0lPmuyDjoZcj9gIXXqmE+mA1NrW7awaVi6bGTZBXO3RPciL4CWIwkTrDo8YQ11e6RrwN0SER3Ju5dBUVKM6IlVUGq80BlzBgpImXz70tAMlKaLok4yuOz5H3TSKCgae+0AYY2qYK4kl+G7Ixz9pwfbLjY6uGX74fO/E495sKgEritbc+ZKlUADkKDZhfNhajphXSV7ZMhZ/Py/cmVVMUskHoNsG9JpQmyHfXPySXz8ZrTvN+jAgVltzuj9p5TdUFZxltw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vNVjaX3X8ny4TUnx81BrP5o/Njk0bdyPyscT3xw1Rz8=;
 b=XcP6yjBw5Wy1uOJr+YICpTJtSD46zWZempjmLrtQh737hdN4K0guH7KyrS4qsH4efQwjTMb6E3grXKLxUcKcw26syb/ujuB9X8EUbKHRKWZAQONgPbC4VtmuM4JJPzrp+2PnEPOW2S/NjY4wp5iRuQe4G440VIaUvSc2GKpEpyM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2812.namprd12.prod.outlook.com (2603:10b6:5:44::27) by
 DM6PR12MB3596.namprd12.prod.outlook.com (2603:10b6:5:3e::27) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.26; Wed, 12 May 2021 01:51:41 +0000
Received: from DM6PR12MB2812.namprd12.prod.outlook.com
 ([fe80::3cf9:ffa6:9371:feee]) by DM6PR12MB2812.namprd12.prod.outlook.com
 ([fe80::3cf9:ffa6:9371:feee%6]) with mapi id 15.20.4108.031; Wed, 12 May 2021
 01:51:41 +0000
From: Jinzhou Su <Jinzhou.Su@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Add compile flag for securedisplay
Date: Wed, 12 May 2021 09:51:21 +0800
Message-Id: <20210512015121.2122807-1-Jinzhou.Su@amd.com>
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [165.204.134.244]
X-ClientProxiedBy: HK0PR01CA0052.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::16) To DM6PR12MB2812.namprd12.prod.outlook.com
 (2603:10b6:5:44::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jinzhosu-System-Product-Name.amd.com (165.204.134.244) by
 HK0PR01CA0052.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Wed, 12 May 2021 01:51:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cbcf79a5-52a0-4864-7b67-08d914e87d01
X-MS-TrafficTypeDiagnostic: DM6PR12MB3596:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB35967AB0531F047562E4D62790529@DM6PR12MB3596.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C/LSdxphpv7yf1Goo/cfi60NbS82sZryi0IMssR8118PnVN/Tdgifgfkvom38R/i1H3Ac0D9rTqgYUcb0yE+SkoEaMML726ySwlaE/YyxC+VU6LIrSKXTtPLWZ6B+/WTgEj5ijRcv60nV0vHcNs45fKgsZCZmcOzD4WBa2yzlA4L5vECNQ6ppM0jAbu0F2pdQJlYkBN4ZxTVq4tNj5xd8G/35tAn/uqTyZzMcZDKrJdE2NFS+4ySSbjDLiSbV5goru+O9PitGekLBMYbE8QpZKoP2ohdjzYv1pqM/W9ljsd4ioJkXS4xpq8IVW0QSHPQ3sTPCh6Gtl+qphMl/z8diKlVcDS/6IdDnU9jyaakbo+VPYfRp31hhwyRtJHLbxfuz0cci0tU1Xb/lhJAZ7cUj1HpzJXpiDO3FS6PsXn8aUR4U6X8V73GpTQg6RHE0Mz4cEvEpxMwRKzCxJezU/F3PeewrC6K+0YOTcpfw7KSpsqgmSjs4pXl1AHdg/jz/l2Sq0NpHqCpzZ7HRPqBI5Y0Wr2MAHvQWXQyfHJsac9u1dDNpMQz7jot5zQH9lt4kK/AUkbSPJoShq30JxLP18cQAtHGWTdRhvrrhqy3uVYcwTKa40RJ+Pmos9ESYGHWjC8EeZlUUlvxqx9UKiFkoBp/Qg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2812.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(396003)(376002)(366004)(346002)(8676002)(2906002)(83380400001)(6486002)(36756003)(66476007)(1076003)(66946007)(26005)(86362001)(7696005)(2616005)(316002)(66556008)(52116002)(38350700002)(8936002)(6666004)(38100700002)(478600001)(4326008)(186003)(16526019)(6916009)(956004)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?WoP8REMKv+aQ7iJDIIkyXlNP87c+GoLpb6/OHt+b5xYX18FkTYUI2NnQXDZU?=
 =?us-ascii?Q?D55uoVQolf7RiH69I061WjEfdx/QDBC2EsIh6l5EygxF81mC9AXoloybNcPU?=
 =?us-ascii?Q?A0jokNOl7gPyDZTAehI44TYmdo3VWqEj/JoL4gA+XTnVH7rmHVd+DXLGZtIs?=
 =?us-ascii?Q?BqU1IFaPvg6F8C5VtjvS+/h3A2KTQpe080+WrBRmjsnY+VWeMwuL4Uxj5g12?=
 =?us-ascii?Q?UMlbO03uHzCFLXh0CQRaLjrwxdNRTc1QkEN7S/lqYBpoOvlSABX9MDr66he+?=
 =?us-ascii?Q?fI6p94PEGwLh/EZ2KrV85QfjLPGcajK2GiFTkrLBW5s5HXqGtBBSukf2r+5q?=
 =?us-ascii?Q?QIkszAH4p2AUeZyIwN8mCUeBgwRAqxhqTvYZSi23Tl/N7ND5zbuTtvi5TDaQ?=
 =?us-ascii?Q?hDecxIrlBljxugnmMYCTSnoO/j719OD9eO6KhpMQk2r3tmY2/klbbQa0uvwi?=
 =?us-ascii?Q?qLUEhgnMvZCPu9T6Cs0tr+oIMM+TBwYWFsClXG54B1ugYwXn00TQ33FJSnO6?=
 =?us-ascii?Q?/wAp9GNKTl0Km2xEdPDieNoqEuBb0fJAo6D0MV73Tdx6cmZeJv2ulJmeqBbB?=
 =?us-ascii?Q?p9HqkImdhXJpMrSNFCG/6bVauhGLDGuRLx8NYLH5i+SmlAKvyg9L3tRFlEaS?=
 =?us-ascii?Q?evf8aWOxTtP8TJxgNdjGgqFzHgU08f+od4FHbKcfcZigULRa2UkHeqWNrb/N?=
 =?us-ascii?Q?yinpN7RLxo/Ay5hCRmWfzDD2QIibh5gMp8zXebSpwZZEJP84SJ/CRPnSywbU?=
 =?us-ascii?Q?MBrv3recUGgsXirtcKFHcrnPu3NlN5Wc1ILWmjc9zwR6zMboEywH1z63BgMN?=
 =?us-ascii?Q?BK3bFJlcW3sSytWU0mnTFUQeBL007D1jcxVUzcBmHEUDzLbj0gpM0QqvfxbY?=
 =?us-ascii?Q?M0AWlzQtuKDAPomzvaf0LVvY43u/z2JJ3b/8OG05Iy5iwZknGkPZV+uhhHuI?=
 =?us-ascii?Q?2EJNjF0hBDPKbLvVIGZh8lGxAmNA8aD6x5UlvoR/cAkCXIiOtiPO6t08n9tH?=
 =?us-ascii?Q?PdS6tuRfKyS0nOWZtktkMUooUZ/+shiDQNqCs1AUem2VtQ43XS3S9Vel27eT?=
 =?us-ascii?Q?nM4W9VBykmDQJewdsD+7x59k9bq6rrchiBVMFYMxC3qDh/quSs6me9FvbtUE?=
 =?us-ascii?Q?DlGmzZiiK90kKvFn0xT6W7QNXOVxX9GPxSjduVntey4JvNqDU50eJy5IxhuN?=
 =?us-ascii?Q?6b+U5jiAW3lnbfjzLxSiQKJm0QguGKFPcyU8RmNjXlkaTFfSgKkPxL9wHrnD?=
 =?us-ascii?Q?y1mHbuLn+YSJg/EEQMTTuMzwp6/yZx+LdsxcVB8s/P7pepdJPnFjOoicbJuk?=
 =?us-ascii?Q?f1NdcHCKKGC/369dkXbVdO3Y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbcf79a5-52a0-4864-7b67-08d914e87d01
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2812.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 01:51:41.5211 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TwLZVWqJaxsFAYbbDNniiSUGqqi1pMpaPTWdPX3Fhd4G4TG97QpCFQ4xGMM0kIIlEztuPq4YPr57J+nudryirw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3596
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
Cc: Jinzhou Su <Jinzhou.Su@amd.com>, ray.huang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add compile flag CONFIG_DEBUG_FS to clear the warning:
unused variable 'amdgpu_securedisplay_debugfs_ops'

Signed-off-by: Jinzhou Su <Jinzhou.Su@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
index 5369c8dd0764..123453999093 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
@@ -86,6 +86,8 @@ void psp_prep_securedisplay_cmd_buf(struct psp_context *psp, struct securedispla
 	(*cmd)->cmd_id = command_id;
 }
 
+#if defined(CONFIG_DEBUG_FS)
+
 static ssize_t amdgpu_securedisplay_debugfs_write(struct file *f, const char __user *buf,
 		size_t size, loff_t *pos)
 {
@@ -162,6 +164,8 @@ static const struct file_operations amdgpu_securedisplay_debugfs_ops = {
 	.llseek = default_llseek
 };
 
+#endif
+
 void amdgpu_securedisplay_debugfs_init(struct amdgpu_device *adev)
 {
 #if defined(CONFIG_DEBUG_FS)
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
