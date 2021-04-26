Return-Path: <SRS0=K+jV=JX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F7E7C433B4
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Apr 2021 19:44:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFBB36143E
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Apr 2021 19:44:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFBB36143E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 477C989E0D;
	Mon, 26 Apr 2021 19:44:53 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B1A889E0D
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Apr 2021 19:44:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BCY8KW+V6LyEwcC6NExQHimEWCaac6ySM6lw+iKQNZf5tQ9rMHEVP+0uqwPdFS/thRa0tDcjUNbT2Cyrb2pjCDn8Mq4rwiZx5S3XmHpn4iwtS82pOxYbA4uIDgmTR9YtoF1zS6qUy0fPMKSTVRL1xo5ZoW70YGyPYK3f+TGte4Bs7dkVwMpQ0ZvauPAgp0SjAqwIbBkCMhaAkTSOs2i2AJreApC59gyW1+6zytWZAjjOC9P1XgXXkNtp7qMDIliLDwo0kiuGkRdaoMiBydH5joDeqhBMj5qLiIXqcR3UwXq8YfKKLkEZ+TmdYLFvRBSjwYNlQOIUteEUoJO+Ct4faQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mmMYybOFbozrygBhiiEJWBGVPatFbLSr/ADChFUEgaY=;
 b=gWVpIRGlH+aMsx0QkkyQLxfnONXvNKK1T/FyUKZ7HySO8NU6BoUR+uh9xZVgRDbAoQYv8p1LURlMIZlNmQlScoqqvZv3UdDGBVb502Z9zv2W3LbdJPNLy9uXFgS1wGWlKe6G3rDgnrVUk96Jm/PSmR2OtUgXYyyCidDvhF3MXr+AQ9BdYKXYZt2p5dXlO6fkLrveeka2X3Pj+KzjRs8fxrzq3++UTh+Jv15ezyZkBlyYX5Xfxbdt7VMZXgmb5gRSYBcHT109FpvowjWjp19TJ5Ng7Az5N8g8hgwjcOYojDLSXGu+h3Klkkjy46UmOFN8Ea8rerA99OAoD5TAmVJMQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mmMYybOFbozrygBhiiEJWBGVPatFbLSr/ADChFUEgaY=;
 b=rw85Uuyn+QwcRWr/4gymSRJGBhqPoWZut93fRHrYtbXjWnXW2mskPjXTT2bgid4h2JSYrMRaETHSZF6P+FPyFr99IGgGQWRqTYLFvUZ50yO9deAPiLUHMe+nk2qwW5k/euo8Ev/3/QzwyQNbGDQ0nerV00Zq6PTwqe4aApxd0yo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB4680.namprd12.prod.outlook.com (2603:10b6:4:a6::33) by
 DM6PR12MB4436.namprd12.prod.outlook.com (2603:10b6:5:2a3::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.21; Mon, 26 Apr 2021 19:44:48 +0000
Received: from DM5PR12MB4680.namprd12.prod.outlook.com
 ([fe80::8d0b:598b:27c2:4b58]) by DM5PR12MB4680.namprd12.prod.outlook.com
 ([fe80::8d0b:598b:27c2:4b58%3]) with mapi id 15.20.4065.027; Mon, 26 Apr 2021
 19:44:48 +0000
From: Jonathan Kim <jonathan.kim@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: fix spelling mistake in packet manager
Date: Mon, 26 Apr 2021 15:44:34 -0400
Message-Id: <20210426194434.83501-1-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTXPR0101CA0012.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::25) To DM5PR12MB4680.namprd12.prod.outlook.com
 (2603:10b6:4:a6::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jonathan-KFD.amd.com (165.204.55.251) by
 YTXPR0101CA0012.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.24 via Frontend Transport; Mon, 26 Apr 2021 19:44:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa9f71e8-e637-41ab-26af-08d908ebc025
X-MS-TrafficTypeDiagnostic: DM6PR12MB4436:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB44367E2A17FC46259522D86085429@DM6PR12MB4436.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TYW08Bo3XpKcSjQaUCAao2yQMa1CQqogB+e2j3RXBBZTVKq+pUxGrzvCJ4jVeqTdresPYNkqgI+OAEngPvhOT/6Kefx68x6H+fNAaci3LUB3MGhb3bTQZGEJTVsdeqqecBLd5WO1sg4Fl8LAJRxJSFA11ibppIVN+gQvcd2x8l8T+aB8EmxlPOsCWsdwBbZAB7s6O9jT4jQAjs7bF76YBx7v45oSzvd/g6fpBq6DXEAE+pvHZYM8FP0GriMHuyXLan+2SakvnRyNko0v0rwmTk6FJ5WMmQ5yRBCAqqhLVPYq6vahfpyXUgfgV4RuTpR7RgUnM3rY1eAcvvHqtcFAidZCtRsxM45Im8pYWAlUFJtqJ9xKfMBn2kITDzY3zzZey+Io3mmWuTRJpsSJcZDe08Z4qOhZeTA/yA/AoWZcEm/4/HbFX6stjMB/6rYXc4iRoTzT6hWM4YVjGu0ZCoSlfMqG24Jj713t1ew38YJqhrVYVH3Jsi8vzK0dRu3jNxju8rs5zhyZew/Mny1W0yF7BKGMVi7ZuuI442M7xzwzTK1W4rlDhycbZPXfo/pW6FUqECr5WIee3hGAnsT5FIswG4tKrldCpEbAJkyeFzjPmsX3Th9u+qEXIoi4LDBkESy9Ml8nuhzqJblFhXm2cebX1zxCiTjTKUbp/GKnm9WXtUQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB4680.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(39860400002)(346002)(376002)(136003)(38100700002)(38350700002)(4326008)(1076003)(86362001)(956004)(316002)(2616005)(6486002)(8936002)(16526019)(6916009)(6666004)(44832011)(8676002)(2906002)(26005)(83380400001)(66946007)(478600001)(66556008)(66476007)(5660300002)(52116002)(7696005)(36756003)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?V9CRZlArc+zsUlMu9H4xzWc1PbU4qqa2O6J9smtFIzASZ1u+M6Rxfgoezhv1?=
 =?us-ascii?Q?p6ydpwxTEeSWgibE240/zbp3K+MEIHmErEcLnipN1lMPgqi4jGQbCLy27mj9?=
 =?us-ascii?Q?G8vVe5wiHWhNOoL2PR6GsoSnsDRuOENl8WupgSwEWQE8xe2uubV7MdKk1YSG?=
 =?us-ascii?Q?psZ2MFsFYl/L5LVjkVhwxK9qC9KcOrezCHFqyO+Jum+q+Qtqeg/R4TyICs6O?=
 =?us-ascii?Q?VHpgVhp8lJdqBpQgCKtUbOp5RDk9aK+z1bhuY55xCy2CO2iRUIEmqYVWSJvm?=
 =?us-ascii?Q?JHwPHHqi5tl9c8BLkul1CGhiDvfLKSXYeYXLp2N+JyDUvbeD4A6ZiGCIVEWR?=
 =?us-ascii?Q?KGHvovFR0b+LN8XLGYLjiSjq1dT9rzlUBsQZ0nvQcE2qIESwKneR/XpMRM71?=
 =?us-ascii?Q?ZfNJgxRFLEex8DRlu49mgVSEwRO6Mvx0O99hti+tJeWp3couFxL2qLdETwJ8?=
 =?us-ascii?Q?8J1hg+WI4Yqg5g1Ii4tWt5pel3Q4sGLrxz6drdRlHDkgVmLc2sSzXpKWNk/v?=
 =?us-ascii?Q?UfvznXZvpnur2vCur17bUI/lmenc5naPU0SwkmEJcqYHfwpwmP5xpnP6eIG5?=
 =?us-ascii?Q?Cb7rk6pAz5A1GdtNYkcmVFlShC4w0GQx1/veCJMlE0fX32RD6FJ7QXGDNdvX?=
 =?us-ascii?Q?MgJyX1ewh1oL2fqwKQG5z5I9uuexoiMf5VgVk91YVeZN6cQBBqvY0aZFw6S2?=
 =?us-ascii?Q?hS/x8XA80o1F04aw/jvsWaTgKipCY7ht3/dlMv/NpCIhx5eU8B6xlE2i0pw0?=
 =?us-ascii?Q?V5ag9wCTxhXS11GGYigNUoIgNJudDCR6QATeGrOVa85hr77qgmY/44LSmePN?=
 =?us-ascii?Q?K4sGfsrnK6imqtbP6zs6SbRrJ3QsM2N1S4oJssGsYDyscgmzNlTwQi7IACrN?=
 =?us-ascii?Q?eCP5w5N+gyUoNAXOJoeDYwhLvfoM9MoYF78b3/qSnRWSFWqNiJmETMZE+8Ac?=
 =?us-ascii?Q?gpmvPf74LT6QG35MWra0vYRhi7hWe5AVs9FVUsI+I1BoTqJD7xfrFcdzUtIa?=
 =?us-ascii?Q?d3+qL925cXaHdc/lP4gc+E/qyz+x3J40CJ+VGvP7neFsxmqm0XUmuA0BnylD?=
 =?us-ascii?Q?+u6AJpS3AnSZfX0ubByFW8se/Z3pqhfCil1FijNbUlFZB0YhyrnquIBPSzqa?=
 =?us-ascii?Q?Gw5xR/kmpruI9dEq7mNfMUSnBQRrrCIsdhp2eWipzcL0E4cIp1dNuGhwsmgU?=
 =?us-ascii?Q?Qr8gTr+VU7ira1ouTBGo3QuBvxBdmYAxnTne0O1t6tZaffoDHUhE7G0yV2+l?=
 =?us-ascii?Q?anDEQyGKbo44MJdXNXGCaYaBQtIu6qurjGlsF2vH+r2F6MUG7fe8+SmECx08?=
 =?us-ascii?Q?yn5PavMDqmhLRJwFpxAdKmRn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa9f71e8-e637-41ab-26af-08d908ebc025
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB4680.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2021 19:44:48.5042 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rNPoWTnOF0h0SzwfVUlrzNUsKYN18egnNejthrfecm98L8frcviUvb9Ymmstu+wv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4436
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
Cc: Felix.Kuehling@amd.com, Jonathan Kim <jonathan.kim@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The plural of 'process' should be 'processes'.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
index 0ce507d7208a..f688451cb299 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
@@ -124,14 +124,14 @@ static int pm_create_runlist_ib(struct packet_manager *pm,
 {
 	unsigned int alloc_size_bytes;
 	unsigned int *rl_buffer, rl_wptr, i;
-	int retval, proccesses_mapped;
+	int retval, processes_mapped;
 	struct device_process_node *cur;
 	struct qcm_process_device *qpd;
 	struct queue *q;
 	struct kernel_queue *kq;
 	bool is_over_subscription;
 
-	rl_wptr = retval = proccesses_mapped = 0;
+	rl_wptr = retval = processes_mapped = 0;
 
 	retval = pm_allocate_runlist_ib(pm, &rl_buffer, rl_gpu_addr,
 				&alloc_size_bytes, &is_over_subscription);
@@ -148,7 +148,7 @@ static int pm_create_runlist_ib(struct packet_manager *pm,
 	list_for_each_entry(cur, queues, list) {
 		qpd = cur->qpd;
 		/* build map process packet */
-		if (proccesses_mapped >= pm->dqm->processes_count) {
+		if (processes_mapped >= pm->dqm->processes_count) {
 			pr_debug("Not enough space left in runlist IB\n");
 			pm_release_ib(pm);
 			return -ENOMEM;
@@ -158,7 +158,7 @@ static int pm_create_runlist_ib(struct packet_manager *pm,
 		if (retval)
 			return retval;
 
-		proccesses_mapped++;
+		processes_mapped++;
 		inc_wptr(&rl_wptr, pm->pmf->map_process_size,
 				alloc_size_bytes);
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
