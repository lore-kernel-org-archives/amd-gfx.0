Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD50FC48BE5
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 16:04:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 855F760724
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 16:04:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 855F760724
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B4096E1F4;
	Mon, 21 Jun 2021 16:04:40 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2047.outbound.protection.outlook.com [40.107.100.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 208E76E1D2
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 16:04:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PMuy+hPR3v/jieFhQw3v+aaES1X8Boin+wErIZcAMmMD1PBIYcuTHTWCHZtshFtMadxv/hsDmFacHZWjGArGij98nqhZDiArqn96kuYoEZuWeobz5siRaNMNI/WtQu+n26uixGB/ReEWQKvXa2y1gG5FblU7h7g6zmXCGU3hgAAPa9c7p9L+q8LkdAZg4KelNwSS1BVqirLrCiITXEufDF0YMO7PjGC9QB5iuK/IVivU6A5v8QAKh9mib5/53alQFva5PJJMzgIZ3yyFuQiHmaJD0V9cUOC7cc4/WU8BMsCwRAM5hnYXZGRE0btfuaoMUoDygfZjc/7aTDoFAYhFBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U06IeEkS3C06oC9QOwRFMC7L37UBmpx8xheAgAwiKiQ=;
 b=SCY7DEEjhWl0k3vUEIyF2Ffpj30YEKg8XgiOJv6XvT8HoATFn+Ic+9H3sFhi2Sa/VQI/007/OFeWlDS65Dxju6RQxH9g2TZzyx1JAJ8T6qHsM7/6srkH+6z5f+cML1P8IplNvmm7iC3j2CxnwdbhH1jJC+5T6Ks0t9SGyyc/kOdY6NToPA9zrS6kdFeGKHaDI7RLPWAhUuh4yHEE5Bl8SS4pKK9A7pTMbKbZF+lRqn5Gvh4HfbHrqE/Q31AK+uxtPqpBvSVqDcVNPVJA2Hm4Eelyr2yTDa+V8GdZSU1e1tDeYsODtpQCSfWCGOTlS4g3/UPYwxCnCtV9IwuZkrqK1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U06IeEkS3C06oC9QOwRFMC7L37UBmpx8xheAgAwiKiQ=;
 b=QXIWZ/hQW3zlGeRp8Yux+F85gdW0NmVmDCPiu5bJWCNlvSIOT99Tens8ur+56nbWUIBSKJqSiu9c8f2QT3U0XV/UAP3o3ymL9VFjGSE/Sf2YCSbiXUDIlnVTvras9O1C+edjw4W5Rhl37hnsfCNgrazRzXpEHGp8w92PRVeh9Uw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20)
 by SA0PR12MB4365.namprd12.prod.outlook.com (2603:10b6:806:96::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Mon, 21 Jun
 2021 16:04:37 +0000
Received: from SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::5ce6:fed4:e00f:27e4]) by SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::5ce6:fed4:e00f:27e4%6]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 16:04:37 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 02/10] drm/amdkfd: add owner ref param to get hmm pages
Date: Mon, 21 Jun 2021 11:04:15 -0500
Message-Id: <20210621160423.3517-2-alex.sierra@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210621160423.3517-1-alex.sierra@amd.com>
References: <20210621160423.3517-1-alex.sierra@amd.com>
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SA9PR13CA0023.namprd13.prod.outlook.com
 (2603:10b6:806:21::28) To SA0PR12MB4430.namprd12.prod.outlook.com
 (2603:10b6:806:70::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alex-MS-7B09.amd.com (165.204.78.1) by
 SA9PR13CA0023.namprd13.prod.outlook.com (2603:10b6:806:21::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.7 via Frontend Transport; Mon, 21 Jun 2021 16:04:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a37df1cd-72e6-4405-c941-08d934ce451a
X-MS-TrafficTypeDiagnostic: SA0PR12MB4365:
X-Microsoft-Antispam-PRVS: <SA0PR12MB436586AD01624834229C7931FD0A9@SA0PR12MB4365.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 35T516F/FjGoV5i0XFnb0NS7bFTqmRJXsJZYHqB1Aksep3dxPm2HfKKUB8/tLoZ6IYhyeN/vtZQq41H8/k+wfLgDWMAdorTaXD9MtdC0TSR3jbyKNZ4jr3y9b08ATjU+vHpIpCZM4aMyD51fMYxOYXHx49QWYioYCSZ22rNfV9GIhGnJ1Z0t60G37d/DN3YfRPcskVRNhxvoqw3JOgXDus/3xdkMn0wQHRK4QOARkkpEDE3scEMC6X3o4RTbZg/zpqSWsNuiD1akOI0QWbfdSK1G7CQHKdKhx+NtJdDpsmZiIds/tyTvO3xYWrNXbIY0YDYQ0mAxPXn8D5G2wmKjOwvT1pTtUyQcVEgrJlCHCQESzjWjBqoq/MZltoxbjCspm4wjHRR8FhDxWsr3xQpf/E/yWClAvTYJsrFMFOZo/HJaZLYb10KXhw3Mk0rY1Ff9chXLFXLqgSQweP+6LQAd1XzxKI1f/Tpe8R3jI9FgPvQcuP3gMVVvTN5A3I+8wQvDaOvar4zcUevv6/3D8V0lvzNAucu+4xYQ1F7s675QqdQp63soHvGxsTxrsjfpitbKgYh2yeCyN7+MgdJ5CceOJ5Vj2VDVX9ik0Q4A3UOiPIqOJpl7Go5EqHp0wd//UFNbF8ywpVtg6UA8tVQWdJabnAkidL/Wt5cE5Sc+12/IbXQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4430.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(376002)(346002)(366004)(136003)(8936002)(7696005)(52116002)(16526019)(8676002)(26005)(186003)(83380400001)(2906002)(316002)(6916009)(956004)(44832011)(66556008)(6666004)(6486002)(1076003)(86362001)(66946007)(478600001)(38100700002)(5660300002)(36756003)(38350700002)(2616005)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ccIXneV8zzHFf+cHkWk0zy74G+lC4Yf2UcJikHpppTl6mFG+ppyzkgVBIMli?=
 =?us-ascii?Q?lFYDLypkj6iVXs2y+0RROKtpznCMkdE7iFlrTFITVcbrAfgMxeyUxZF9VF1Z?=
 =?us-ascii?Q?Ge/VkCJKKxnjdVqdlHPjOf2oYTPs50ctawuxW69HhAkMd+qG3CBhLoot5hXV?=
 =?us-ascii?Q?auID7uif7w1/3VkQGpIh/qRsFqEB5bBUEqVCMcTWr3Ty62q5WTkUKtXlILwz?=
 =?us-ascii?Q?2JjjotiD7EPXmywSnq/A6BwXOw4a5aLlmR1yh2Z+Z/nYPvqKz+cb7cKmqvAQ?=
 =?us-ascii?Q?b8na41jexpVaE3bmFBUcc0cBKZInpYkiX8H+c0YkszaFh7Y+2jJsahdNmMR9?=
 =?us-ascii?Q?cFQZvG1YeittVjfzuEUJXNU7Kl/nO/lynVqgibxFfNRIqznOhHNx1UGY5aY/?=
 =?us-ascii?Q?/3W3gIHR8rP382dR5i5xLnhHZ42dQzx8CMJTC3uYyrC8dN2y56fclhQpslbY?=
 =?us-ascii?Q?AH0HV6PNwIRYYeFYyskCgc0e/lh61ZdSTgZbRksRW2LapRiq2YQGm8oD51H1?=
 =?us-ascii?Q?Vum9LGp1QHUUCvegnctXAgxLRjYet9dYvf8rx+nNhtDU8jTssozDrkuPwe9t?=
 =?us-ascii?Q?XCJAVU7+pUUp0dDXMAq4AUbGkxCos0MVhI3DdSaHp8+tuHfvdiH3ZxEfLwpy?=
 =?us-ascii?Q?6wXySPiXNS+Wjz/t+ClmP4kXWF8q8eXQH4oxD8p1w2t5pw9B0BRnayTgVO33?=
 =?us-ascii?Q?3Fil33OFVFYHiBejIV6NLJudPHzhtMSSzGhC01+15tL5JCFaKJ6SrB7et15e?=
 =?us-ascii?Q?hC98mc7u8ngw7/bvQ+opwCHpuHg2a2YyvptJgQyNl2bcgnZ/nhi4/pjYEUGG?=
 =?us-ascii?Q?BlX5m++JvDQG1InCMuW9zRzOi1ipntRZJJ3mmv5/rKb16x/ZcqiprBQ5Cc+n?=
 =?us-ascii?Q?0GymObuMGBbmfed5oaqeRMAK+PI7bpCBHMO5l1mH3gG7tIbllyt+d0AdEmM9?=
 =?us-ascii?Q?cvAQBeb7uJplLJ35QHGkdjJkx34dl5ta4DIENxd6PT9EaPu8pxiPmyFcNn8P?=
 =?us-ascii?Q?5XzAgRL6NBixSes5QmLuRJyxkZa4Q384pWTyqCWubBMQt95zujIRKF5MCdci?=
 =?us-ascii?Q?LFY2viBB76Wd5ug69O1UbC72hd2EvcG4Z7SCo+NbOWAepUb1lhSBMHkJAZxT?=
 =?us-ascii?Q?miVcQ6h2U6crtfa42q8Au1NZbH2KfKBYGKxLi+Jc48xbx2jucIm80rtde3aD?=
 =?us-ascii?Q?Kd00TGxRhmoh04fImQqgILZFdKMLIGekFPSmQ+/4RX9Vwaj0AlvN3kSerYLX?=
 =?us-ascii?Q?xvR92Y/GlZzDXvX7i2oxnl2Nay5qBdeOyr/dx0B+0mf7MbMQ9momM9weKd23?=
 =?us-ascii?Q?EQwoQcyt9rsIp26JUPoAUFzX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a37df1cd-72e6-4405-c941-08d934ce451a
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 16:04:37.8350 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NqYBiGhL/dXX6HbUYzw/FkeGfLt4P6MyLtxCXBmosshsj/HuSJKk7NxvwsV+sy1RuP4yH9U67CF4eMoTZ9fGxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4365
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The parameter is used in the dev_private_owner to decide if device
pages in the range require to be migrated back to system memory, based
if they are or not in the same memory domain.
In this case, this reference could come from the same memory domain
with devices connected to the same hive.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c  | 3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h  | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c    | 4 ++--
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
index 2741c28ff1b5..378c238c2099 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
@@ -160,7 +160,7 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
 			       struct mm_struct *mm, struct page **pages,
 			       uint64_t start, uint64_t npages,
 			       struct hmm_range **phmm_range, bool readonly,
-			       bool mmap_locked)
+			       bool mmap_locked, void *owner)
 {
 	struct hmm_range *hmm_range;
 	unsigned long timeout;
@@ -185,6 +185,7 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
 	hmm_range->hmm_pfns = pfns;
 	hmm_range->start = start;
 	hmm_range->end = start + npages * PAGE_SIZE;
+	hmm_range->dev_private_owner = owner;
 
 	/* Assuming 512MB takes maxmium 1 second to fault page address */
 	timeout = max(npages >> 17, 1ULL) * HMM_RANGE_DEFAULT_TIMEOUT;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h
index 7f7d37a457c3..14a3c1864085 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h
@@ -34,7 +34,7 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
 			       struct mm_struct *mm, struct page **pages,
 			       uint64_t start, uint64_t npages,
 			       struct hmm_range **phmm_range, bool readonly,
-			       bool mmap_locked);
+			       bool mmap_locked, void *owner);
 int amdgpu_hmm_range_get_pages_done(struct hmm_range *hmm_range);
 
 #if defined(CONFIG_HMM_MIRROR)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 7e7d8330d64b..c13f7fbfc070 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -709,7 +709,7 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages)
 	readonly = amdgpu_ttm_tt_is_readonly(ttm);
 	r = amdgpu_hmm_range_get_pages(&bo->notifier, mm, pages, start,
 				       ttm->num_pages, &gtt->range, readonly,
-				       false);
+				       false, NULL);
 out_putmm:
 	mmput(mm);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index b665e9ff77e3..b939f353ac8c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1392,7 +1392,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 		r = amdgpu_hmm_range_get_pages(&prange->notifier, mm, NULL,
 					       prange->start << PAGE_SHIFT,
 					       prange->npages, &hmm_range,
-					       false, true);
+					       false, true, NULL);
 		if (r) {
 			pr_debug("failed %d to get svm range pages\n", r);
 			goto unreserve_out;
@@ -2657,7 +2657,7 @@ void svm_range_prefault(struct svm_range *prange, struct mm_struct *mm)
 	r = amdgpu_hmm_range_get_pages(&prange->notifier, mm, NULL,
 				       prange->start << PAGE_SHIFT,
 				       prange->npages, &hmm_range,
-				       false, true);
+				       false, true, NULL);
 	if (!r) {
 		amdgpu_hmm_range_get_pages_done(hmm_range);
 		prange->validated_once = true;
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
