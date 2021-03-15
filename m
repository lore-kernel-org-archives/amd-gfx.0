Return-Path: <SRS0=AQd/=IN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43672C433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 11:22:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBA2364DDF
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 11:22:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBA2364DDF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 989728997A;
	Mon, 15 Mar 2021 11:22:43 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2042.outbound.protection.outlook.com [40.107.100.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F4888997A
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Mar 2021 11:22:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T1qz3bcLh0hA2e96EHNNBAkg2sxMG/qU3viXQ89iiDWRR48D8CYE1DYMU1xqK0fZJp+s0ugCjK4j8K5rE6AzPmnbl0QWTOLbCOmaOyGcdMa/dedU0Pyz852QNhLOZwUqFhC1lGZf3v6gmhzqBQvLwirzIQrP6Nzrm4TjRyaJVJyYlDNpZL2vuazPYCnkexmBloimdgFqVAXI8bILQ9IUZftfU+xuS3dMVO9PnzEJ08H1zfv1HiYOfh/9NE4zhAwZyvi90A25ABtMqk0fPV/V9Xe/TQ7OIn8rWH9Q8ilZyvvaPE1WjoUiv2jgc1vVkeecKwMqJMyNjLkyGqCta4Oxng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vx2Ao+55/OFD0mfQVN0cb25wCMlMjzSIfQ4zblJ2MNM=;
 b=FMNzHG+GA7uI1VooIsmoIIf5i/EuiayvrkyCyk8qgmDBYrrrStMmssdfspRR1SWZljYPOkq1sId2umFlrenKdoXcC+GniJrlRKj2n2NNoUrZI5uw+flIqTs00RsiN4LiTxgkb2PXfKNXD9k223g2JH3tqkzhChdirzUxDbu5gf1Ew9qpK/rg724SXIcY7PzSH+OsK/mw+C8rqYUuYbFbCqW6K7O/pPjLaAWOq/BZUiYu414TOmfZzn5Ap7BlSs6gPUcvni+xL0VjVkmKpJnR9EGghIHxKJ2A8XKK+iXfLVoMFIbk/YXEM8ijcymUlxMrNLlbfJz/RBx4k+EEr5j6XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vx2Ao+55/OFD0mfQVN0cb25wCMlMjzSIfQ4zblJ2MNM=;
 b=Saxy6VLHVTnZzvNC61KIumv31FmWuPiKsb3kwQgeUxCyf1XQtqfXvaNnbBa3utpC9kQ7qqo4MoRFHVh7TQVk852yo0uL8r40KSpGAyxfuu0QkWdIC9f+eYNZsMrw+q0zeDYiGJkIpvPUYuttPrXAofwLBJwSdc+ymbgQlJTypys=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2604.namprd12.prod.outlook.com (2603:10b6:5:4d::15) by
 DM6PR12MB3740.namprd12.prod.outlook.com (2603:10b6:5:1c3::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.32; Mon, 15 Mar 2021 11:22:41 +0000
Received: from DM6PR12MB2604.namprd12.prod.outlook.com
 ([fe80::1c30:5644:fcfa:a1a7]) by DM6PR12MB2604.namprd12.prod.outlook.com
 ([fe80::1c30:5644:fcfa:a1a7%7]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 11:22:41 +0000
From: Solomon Chiu <solomon.chiu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 06/23] drm/amd/display: Fix for outbox1 ring buffer
 typecasting issue
Date: Mon, 15 Mar 2021 09:39:53 +0800
Message-Id: <20210315014010.16238-7-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210315014010.16238-1-solomon.chiu@amd.com>
References: <20210315014010.16238-1-solomon.chiu@amd.com>
X-Originating-IP: [165.204.134.249]
X-ClientProxiedBy: HK2P15301CA0002.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::12) To DM6PR12MB2604.namprd12.prod.outlook.com
 (2603:10b6:5:4d::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from LAPTOP-K5LN3AJ2.localdomain (165.204.134.249) by
 HK2P15301CA0002.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3977.2 via Frontend Transport; Mon, 15 Mar 2021 11:22:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ee508a9d-ba36-448e-6cfe-08d8e7a4a571
X-MS-TrafficTypeDiagnostic: DM6PR12MB3740:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3740CBE30B518A5E797420D0976C9@DM6PR12MB3740.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v/U4D36nj0RRPVfxzLQjYogs2C0kq9xdBuLp6LTIh3wpSX+1lPLCJdncKuhxyPKNhhN6S3K6dBkz4YvUawydnIO+33/9W47N3lCtEdQifkECDfBjUs4jXzRJNEDjp+A8t1icuxeHaTeakRnv4Z8UCSyGN9A2defS0V3gAV7P/CFRG2ir0650SssbUMZpMDJdkZeK4zpgXLlKiuiBWhlSluDTltHlUz7t4FVHjiiOBt+PlbKqMzIuSWRKIAgeJRm7Kx7WCMI8tppaksl1ga8xTPoEIv15bzvOY9TrxeMOc7nDQGsWBb9WohRxvpsTxrVnNuSMSUTu5b3v4VzTwsdZrW2vRoYGbDh8ZU2z6Ct5oFM5ZrfQQR6CspE90+SbVIqAFPEWCHq3Bci6Wqf7aR9SZ0ASYgi8QfS+IBhBPJ3UFTDaq9NiFjdf6Y4sDCtqBMadKiB+a2DNv1ksurbMD4An9GYH5/FGFVkqoBTw3mdWOB2NHbBVOTFzD0L9PkuDOB9rLBRvotx7fmVhpQMj/6dKPfdFc6QgN0lEiTkUOzn9fd3FHO5SxCgfyIi7hPHjmI/s
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2604.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(366004)(396003)(346002)(376002)(186003)(6486002)(6512007)(36756003)(6506007)(86362001)(4326008)(66946007)(16526019)(6666004)(66476007)(66556008)(6916009)(26005)(8676002)(478600001)(956004)(5660300002)(54906003)(2906002)(316002)(83380400001)(44832011)(52116002)(1076003)(2616005)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?DXEsNbCu31hFvX1+befAbK8SP4JWCE4WjKSM7/TgDIdc+723QGSpt26cDLzz?=
 =?us-ascii?Q?sssoFvkCyTI5Kqk9Fs/LkL3Uv1B3wTXKIOrL3RWUUQXOmB05EWGiwEQMLhmj?=
 =?us-ascii?Q?gOqi9kpvtRZids3/V4WG3pKRXtRz2yileJWr13cbwwCpD2UOM3ppFZdy2Eaw?=
 =?us-ascii?Q?SsnFpT95v4fpFCKB9ihEbEXeJ8h15nPzPYwR7clSA+wwaPmIY1p3kW918tS2?=
 =?us-ascii?Q?4OzxDW2sk39+XB4FNp9PFBcfv4yhys1IGgvfZTIPF1PH77M1TIxwMKANFRPF?=
 =?us-ascii?Q?ezu/1mYLZ8ZtNZ21C5ztsEXp2iRjdxKVgFaO1KjYSULg1+flZJoPCttj4t/A?=
 =?us-ascii?Q?5BVPTc+IkB1yXBOoWPrBkPinYeuUAxtTZdjZ9nILg9tO6hB+BnYu8PvojaUH?=
 =?us-ascii?Q?Y0zjg5I65GNLrHjG+TCoI3uW1Gu+I9oFgZ+fUaC9Lk88+dssFe8trJ8IG6Mj?=
 =?us-ascii?Q?snCPADklQDEnCagt5WVLvD+9+HecRryMVFBreXSCwrTt351cPTif9Yst1V6L?=
 =?us-ascii?Q?uq1z6NOZmLcYmBabwQR5KIde7kTSLfpslCEbM2xODGTuOTtrZfDzU1HlzV2s?=
 =?us-ascii?Q?POiDIihjMn9rNydhPVYvf8l8P9gP0OW5i/mLF7+hVsohC3M2yemt71JfomWk?=
 =?us-ascii?Q?GBL/413KcpMAiJhE5SAliBc1PjL6LIbUE59w6AOkMafK6TWg1baUV3P8AJm1?=
 =?us-ascii?Q?l6UOVb3MaGST6jURHnAiEHx7dAphU/FjpSvkTxmyj419VjiKM0vMDtB6T7lM?=
 =?us-ascii?Q?DdtQdgIF3Cfh+PibhjFMmKOmu/nM9oOOvrNRFocVm53ojB7UWm0zfD4LocRo?=
 =?us-ascii?Q?zF4nzmFX14jw3/PFb+2dFtoZKL6XfBnTUtk6spc/iNJbROkdy08+5R9ZlqOS?=
 =?us-ascii?Q?EwmZncPJXfeKes5PLQPkY7C6zDZvbX16D7PEzD4kS0G6Y1ApKN5EkxCNNWuR?=
 =?us-ascii?Q?+27FZErdEZ35H9gYOaxogHSLX2nsM4aojf9yz9YAsUCVV3H+NSGT7q1kB9fq?=
 =?us-ascii?Q?/puIoPKceDLKmFTr4u/HulVGddx6oCzjKqfrgmOtDo6Eq6/+dp7wh0ECTuhM?=
 =?us-ascii?Q?/hYSXur3P/kfdL4lzOwYgVBtYBPH1qD5Si9aaCNLz5XIUa7tmUujWB4kHodG?=
 =?us-ascii?Q?Soj+Y4jsbcJFDRJqO5OT6bOXtTf/KHESEkVJ+JJ3wngMMTY3VnC9LR9J+Aec?=
 =?us-ascii?Q?XklvQ+pI80/xIhqssKsXIC4lR3h6dBRmIMgyGSIaL8jTTK1iUWrwNvXNTQAq?=
 =?us-ascii?Q?osFimLMhFaqolsrKXMItYMvU/NlXu+jeO8Ofj4N1Q02Nd3eP//O/g2HDlV8t?=
 =?us-ascii?Q?TvBt2xp25/NgmIt6CTvRpIsBhENxGr2ePtsPvCJ5ZwTKvQ=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee508a9d-ba36-448e-6cfe-08d8e7a4a571
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 11:22:41.3179 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HABQtrsqemnVIWbl6MX/yLPGq2JRimSm1PPRnHSQgQaa6RaZnTkMYby2AJWai8MgsuOAurqOpguvMU3PhIZxww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3740
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
Cc: kernel test robot <lkp@intel.com>, Eryk.Brol@amd.com,
 Solomon Chiu <solomon.chiu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>

[WHY]
Compiler warning "pointer to integer of different size" reported on
outbox1 ring buffer address typecasting.

Reported-by: kernel test robot <lkp@intel.com>

[HOW]
Fixed the issue by typecasting with character pointer.

Signed-off-by: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index 1ee2000ad099..8ba0a9e2da54 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -508,7 +508,7 @@ enum dmub_status dmub_srv_hw_init(struct dmub_srv *dmub,
 
 		// Initialize outbox1 ring buffer
 		rb_params.ctx = dmub;
-		rb_params.base_address = (void *) ((uint64_t) (mail_fb->cpu_addr) + DMUB_RB_SIZE);
+		rb_params.base_address = (void *) ((uint8_t *) (mail_fb->cpu_addr) + DMUB_RB_SIZE);
 		rb_params.capacity = DMUB_RB_SIZE;
 		dmub_rb_init(&dmub->outbox1_rb, &rb_params);
 
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
