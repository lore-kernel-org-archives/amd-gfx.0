Return-Path: <SRS0=e+DK=KG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C068EC433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 15:15:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D7DA61400
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 15:15:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D7DA61400
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAF7B891B8;
	Tue, 11 May 2021 15:15:20 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2057.outbound.protection.outlook.com [40.107.95.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24010891B8
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 May 2021 15:15:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Up7gWsv4ac0MRb+y0fMf0/21GiQXyTAGGdp0zyBdSnzNUuPiO4UmfrQXKt7TeEXYDfOlmMKHLYcPAi++wwa+zyIy3Uyjb7LfJi0+fJv6GXZcb8QNXnno3KK5eRYlKnu5cl6hmiyJXNVigPmLExOnASvslYYRNMoVY1Zq3u4pPZ+l65rzdZMfxIhijLwIyISxSVo9y33gmOFszi471wprn/jT6jS9yw5wvYhLba+TO/dVyaZV9kyHZR/EdLwjqX35ink+wH3F3S29ErslmvYdY4+PXXxmvZFiOHQuTBthdbAUcueBgXG+NEYxKkEVXjn/fPY2TDOz7YzQc4tFqfM8wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxHHUr6O37g0/fvuiWfotSlJTgWMxLO8xjyU72Y01x8=;
 b=JJgcsCXvS0Et5DbFrxYNAigOmcHCK4ivAZB13CRuxmzK6GHa6Witk/cybE7KxxvdBah+L7rtSXpL0Kn14uMenNRIMzC9xvOyFaqpOHzEmL89TKIkrO7KxzkTIPhTR7Ipafovpqz/qrHnrelDxWsxn1P65qq9uqPqkTMMbuB83PlpbKdx/hYx0EjN3esHVf1bmlatI/3W9JLQHtukcC7AgHnQu5OtpmYxGK6s/hS++HOWfApwptaveS9jqVrkIxf9K709wnOXofo4eq6KhD0QZJD868U4yvqniVs5J23OKUeigUKZ1El86gNV1BWcTUgbBFWNkSsD3m8naGIZuxTcAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxHHUr6O37g0/fvuiWfotSlJTgWMxLO8xjyU72Y01x8=;
 b=cP5y7ygRf+uGfVXSlrFwhmA5NiB+78U+ri7LrItilc699iTCW/6+MrtOP3JJPbYKmcyltFf6910MBMVdorxxNORtJlxetOxDRaLDeTTxXdlLVugig7Wgx3RTKfVYa5aBP16uecEK8ErAydSQu1ZH4VYZEFQuctmpaD9MwoxZggg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2583.namprd12.prod.outlook.com (2603:10b6:4:b3::28) by
 DM6PR12MB3403.namprd12.prod.outlook.com (2603:10b6:5:11d::27) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.25; Tue, 11 May 2021 15:15:17 +0000
Received: from DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d568:cff1:dc2a:5baa]) by DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d568:cff1:dc2a:5baa%3]) with mapi id 15.20.4108.032; Tue, 11 May 2021
 15:15:17 +0000
From: Philip Yang <Philip.Yang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 2/2] drm/amdkfd: new range accessible by all GPUs
Date: Tue, 11 May 2021 11:15:04 -0400
Message-Id: <20210511151504.31849-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210505175617.30404-2-Philip.Yang@amd.com>
References: <20210505175617.30404-2-Philip.Yang@amd.com>
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT1PR01CA0105.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::14) To DM5PR12MB2583.namprd12.prod.outlook.com
 (2603:10b6:4:b3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Philip-Dev.amd.com (165.204.55.251) by
 YT1PR01CA0105.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.30 via Frontend Transport; Tue, 11 May 2021 15:15:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 61b30b69-7d07-4484-9801-08d9148f9593
X-MS-TrafficTypeDiagnostic: DM6PR12MB3403:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3403C60E16CBDBF29DCEC43AE6539@DM6PR12MB3403.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2QGnVHeinxZUpl+vq0BzhR9plgY2FDirPWSZAuNs7++Mf6NEXNMtGr173qYvfMMyTyJ9gX+l1shka+jtaRbsQ5xTeMeh/c98agCLon9ivzvcGbGosogk+Uh246a6ut9ZHW/or2nNU6Bps1PzH0j136HZAOaY7dY+lToDlXwG+WuDB7BOC/D/bBcqywGsjUlBpyhMW6c2XKXdISWsQzn0D6s10lW5AxOGvkLOml8tPlC/h4S5FogLfmDL562HrSn9gAmAmx9irv1Ho4OGigvuZk+JkxkBny7s4lLK2eQB9ducHXVSFTDOd7QXNsOAcPL9M+r0jrJUHrR2ZU5QKCub1AwMY3KitO8Gtp9BcW51skuuM5b0xAlGvdTmMyJRn7vpUWuB5+DikUyRi8XbSgpVwcnJXd91z9BxWmKZUQVqnDSIsbDnLzwVxNdfDuuqXmJgqRt6HRlPSop6Zr0pH8BVbzlmJzuTCHcKRqklA1Yb8jRznZujSE7S3H4ZqKllYuTBVjYenNAORbEpvxINYuZSpxs4mkKnS9Jzs35hR6PQszzNEwv5NxNo5cg4nd4yTLnNb/eOzOg9JvLNimKDXqDbL4qI1p4BU85aa8ZrmuksuzQEHUnKHKt402f0QxNx+txLntWILjnoQBcV11dnbelWRpnY9Qj5z0dL9VHfGPsjRsQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2583.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(83380400001)(86362001)(1076003)(6486002)(498600001)(8676002)(7696005)(52116002)(26005)(186003)(5660300002)(8936002)(66556008)(66476007)(6916009)(38350700002)(4326008)(38100700002)(6666004)(66946007)(956004)(2616005)(16526019)(2906002)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?5a0M4sihN6rKrdxCOjwuCSejVCEoCV9htElh8bqw3N/WIGcwCmJxfprTQv+c?=
 =?us-ascii?Q?ebla8RFJNcThu13ergrwv5/BuDNh2leJ9vk+DVwWQScYu/yIsD8LfWg/cZNO?=
 =?us-ascii?Q?S0KNB77gQTogkiiQkJ1gEajzwQECBKx9e4LYanywle+M/jBkLUDJ5v+UuQ/n?=
 =?us-ascii?Q?SVB7MW1R6W/57HegRloBgNTsmVpIemhhASqb0A7XmeJbJPdKrVbtj+tjkjIZ?=
 =?us-ascii?Q?ZbKrb322afZPGC+MxD/+DDSInKITDEECPNzJqCFPqk5KPESL+mqlDjKDD0ix?=
 =?us-ascii?Q?Rz8AjP+rgiUWdNK84mlhElemYrQXP6Hw9r9eQFVYOvep+7bUlhum0xGmgyeq?=
 =?us-ascii?Q?OkpNRb/gp0QE2N0MtKxigsvcilh3FpWlV/sqMlG1DKbHRijLpqRx2BlgNdCw?=
 =?us-ascii?Q?PMdgLN/YDhUN4g+eu/PjeHB/kqi7h1Ch2taxVY/ZhXSb6jvDYdNIGr/CrpQb?=
 =?us-ascii?Q?Chryd1l+s6z/5pKgAVm5sMy9YkKLMCMHUb7d+lOvrqWlz4SntUxHi0W9tuGg?=
 =?us-ascii?Q?/dibpyFCCHNBo+tATUbZ7WvxA49w8EE23johKJGTJQ8NA87ONjH718tWdCoW?=
 =?us-ascii?Q?FnqBLXSJZBGNJ0cdEu4TAbtPu/sVWJDm1FDBzj16aEANPe85UHqGLBH2oMpG?=
 =?us-ascii?Q?aRKA67wFKL1dsh/whuf3J8XTAklZjlqiukLCOSeoxajwoTeQtw69X4Gid6U2?=
 =?us-ascii?Q?WHmygdwgFZ1xy1K3Z+9BsyIM0Ht07G8KWIkCd2iAQ3u2927ft2b0BJG1Y+Vh?=
 =?us-ascii?Q?AUeCdM67g/D3Hm6MICJUk+J4uylsaDyhnC3MPtKvc3lZ91ylRLyEyz6epVNs?=
 =?us-ascii?Q?3dJj/8gbAyxyC2dINv9sclqt8qzZRlv7G7s5M9ROJcYBiabdiG5cLwkpQVz4?=
 =?us-ascii?Q?IZPx/GxmVEbi1KW2TBQcNd/JQDfEJ6NTj9/UPM5F45I6h2Go6qefwkfIUlQO?=
 =?us-ascii?Q?8v5HFdwJ2QNweHQensmsLsUxrcNBfWq8YHdT9q810R/aK8MZcQstSfsEVC/v?=
 =?us-ascii?Q?EFpPTDsfL4F6f0I4wonRG0rnE04ulnMyDF/ZDI9K0O6BlwxqDGSF/uQrZLQk?=
 =?us-ascii?Q?BhsBM9y0tMfZTJYtVNqvLhwUSBKV9XepzozEE3QT0WTviRl8u/ljjvRqUs6H?=
 =?us-ascii?Q?4hSoma4KGQW/LGECFRzokAgPzxoiAD11UobBtMAHOGAtR01SA92ykZ4f2dnB?=
 =?us-ascii?Q?cwfqmjVaSbBV1caKNoFpcOmtk73p/ew5s+0VWf1YZQCDjX0jh2Np5IJNlzKV?=
 =?us-ascii?Q?qzzgl2iDbtWF07XwiZhCqWpGxBHwX1HyESuIfCBUjQFlx9QEJ/u5lHUubV6o?=
 =?us-ascii?Q?28n2PuDWPWyWiFYQJrL3vXDF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61b30b69-7d07-4484-9801-08d9148f9593
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2021 15:15:17.4151 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s76j6XBe2PwBBRWrlS7wlcAlagnzh4uJJ210SnW5WYcgl8VOU+n6A3kKOX92KXwn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3403
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

If xnack is on, new range is created to recover retry vm fault or
created by SVM API calls, set all GPUs have access to the range.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index d9111fea724b..6a677bdfcadb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -258,6 +258,7 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
 {
 	uint64_t size = last - start + 1;
 	struct svm_range *prange;
+	struct kfd_process *p;
 
 	prange = kzalloc(sizeof(*prange), GFP_KERNEL);
 	if (!prange)
@@ -277,6 +278,11 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
 	prange->validate_timestamp = 0;
 	mutex_init(&prange->migrate_mutex);
 	mutex_init(&prange->lock);
+
+	p = container_of(svms, struct kfd_process, svms);
+	if (p->xnack_enabled)
+		bitmap_fill(prange->bitmap_access, MAX_GPU_INSTANCE);
+
 	svm_range_set_default_attributes(&prange->preferred_loc,
 					 &prange->prefetch_loc,
 					 &prange->granularity, &prange->flags);
@@ -2243,7 +2249,7 @@ svm_range *svm_range_create_unregistered_range(struct amdgpu_device *adev,
 
 	prange = svm_range_new(&p->svms, start, last);
 	if (!prange) {
-		pr_debug("Failed to create prange in address [0x%llx]\\n", addr);
+		pr_debug("Failed to create prange in address [0x%llx]\n", addr);
 		return NULL;
 	}
 	if (kfd_process_gpuid_from_kgd(p, adev, &gpuid, &gpuidx)) {
@@ -2251,9 +2257,7 @@ svm_range *svm_range_create_unregistered_range(struct amdgpu_device *adev,
 		svm_range_free(prange);
 		return NULL;
 	}
-	prange->preferred_loc = gpuid;
-	prange->actual_loc = 0;
-	/* Gurantee prange is migrate it */
+
 	svm_range_add_to_svms(prange);
 	svm_range_add_notifier_locked(mm, prange);
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
