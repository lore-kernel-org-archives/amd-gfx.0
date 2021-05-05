Return-Path: <SRS0=nRto=KA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D55EC433ED
	for <amd-gfx@archiver.kernel.org>; Wed,  5 May 2021 21:50:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BCA061164
	for <amd-gfx@archiver.kernel.org>; Wed,  5 May 2021 21:50:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BCA061164
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC3A86EC6E;
	Wed,  5 May 2021 21:50:32 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 361486EC6E
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 May 2021 21:50:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JsAaAYdZ8eSPe4SpNslwfmRw4e48gNj9R4cWkxCN4PE1O9RrP50kAfAxKNukH3FjAftOkiQNzexf91ptS/UCUyRZrZzaJqcujHEhUISTMHYpGKiwt+q+KpSZcWAv9iZVnXjVOKqoHFSIj3pa0slirO5/4psG3upmPWzhJh59p/+Nel6HjasKHO1qpSUkxOA5A+OdapUJQdeV0TKSXx/y23qy8QYziFglFx5JOBzJHi0YBwSp8/mzNa9X/UsO7lB99ZhGxBVdSNXF3p0AA0ParbTcb2acqsYeJi2rdaerTtdaSAbZnqvSJgDSSxnFi3Hzkn2tq4oQUuv1/gYw0Bw+Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XTkLpH0aDF3Fmt+FetuiJYY2/qRZsrKY0fOf68kyALY=;
 b=M9VSFq36DGw1YJEH8notWi9lWgUn6O511FcZFrWi9MUKM9apEh8iOP4debVI940AYifVKvShS1ArIfo4Ly2wfjURsv9t469uHUfFU3TdJ7K3h0zz4L9cDCgL4LtkhNByX3E03u+EmerwBb9Am3vR7Bplx460bLD71Y3WaC9NCNYvOoMQFkiL0YEYKgXK8aD/XHs4LBlDZ3wadCaxZZeeir+ZCa7SkXJfyiJqtZ1SSjtYIXEl5dmN05dmYmx/n6CUV1E0Dwq5L+MaXRXsu8mNbFmqsJ3yeBcPawqYL6q7wg+MGyGWFv5f/M1C2ksm0nm+Kul76NsFgl85EUTrmC1A/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XTkLpH0aDF3Fmt+FetuiJYY2/qRZsrKY0fOf68kyALY=;
 b=xyqM/Mi4HuqHn+DNIQpl3FOIs8cArDfaC7iyKlcWrCTAaku4hHQ6AVKW6/2k4N210qn0VwpWDeApkuWCBiN+KMAOHXrmkHtK1d/ubVJL/fpIw3EpBDPXSDiu8DuJ5X/hDEhYq1a6SO6boBh8oWE5XHTFj/+L6Uliji6BjpckZgg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20)
 by SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.41; Wed, 5 May
 2021 21:50:30 +0000
Received: from SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::31de:f08e:20b2:d121]) by SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::31de:f08e:20b2:d121%9]) with mapi id 15.20.4087.044; Wed, 5 May 2021
 21:50:28 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/3] drm/amdkfd: use dev_private_owner ref to get hmm pages
Date: Wed,  5 May 2021 16:50:00 -0500
Message-Id: <20210505215001.3418-2-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210505215001.3418-1-alex.sierra@amd.com>
References: <20210505215001.3418-1-alex.sierra@amd.com>
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SN7PR04CA0014.namprd04.prod.outlook.com
 (2603:10b6:806:f2::19) To SA0PR12MB4430.namprd12.prod.outlook.com
 (2603:10b6:806:70::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alex-MS-7B09.amd.com (165.204.78.1) by
 SN7PR04CA0014.namprd04.prod.outlook.com (2603:10b6:806:f2::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.25 via Frontend Transport; Wed, 5 May 2021 21:50:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28356e1d-7cb2-4a10-d2eb-08d9100fcc08
X-MS-TrafficTypeDiagnostic: SA0PR12MB4430:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB443097D8EAFAF972A3BFB80EFD599@SA0PR12MB4430.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bcq2vSSGS/6kwOVVauaNItmfbq64vjuJM5gnB1UwtrJngmZvHmetvqplsxA1DSkk+r0d0HmxnhY+V1SnqdJEBixXsjZ5HXro2guYfBLGHacBvzvy3WfXe1AYzjalKouY2/sPq/Bb1euCHuXBKJHnw9UqxHzalDqEdPWbmwX05Hltb8c5griBaTnkqZwA1WtP8D/fNROzENAfo4VPzpfCHm58UkvmkXuI6QMsNZHqbgVq57up9mQ495cvUhOzq0nFKVqgYeqwJ2QS6GwmfWRFAqEpf5F5miDPs1zW7hwZdvLM3003Ywucte/tL7mdnBqSVTsBYxCEfwrbSLAA+cYZMHlmvO9/zJR9+5YnoX+wBxaCPfEZZIyyg7dGH3gVwb9g22ySBxpfmC2nLX7EIAdYpknSawY2vcMycaptjQf5h4/8MdN9bNP24xbKbd/DfubSzjoKjfSbg7fTBankSkXenUoYT3Ozr62IEQyIpuJlqnQzHO+rNFRqI0fiGpFB60gzQIitHpPXWTHTKWfUU1A53hapPGBZkSuwmCwjcoO7Sybir9k+d11n2xw1cONtJsBOUT3EWY7vjKKSPLlty/AhDKw6hy6R/fjXp7cfR8g38nJIJ7hHZi9g90gu8VjxsP6JqGElyb8xqvP4Lo6Q71M7SSzBwj14sISAksIdqPXpoCQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4430.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(136003)(346002)(376002)(396003)(6916009)(36756003)(2906002)(44832011)(66946007)(6666004)(66556008)(66476007)(6486002)(1076003)(52116002)(7696005)(2616005)(956004)(86362001)(26005)(316002)(5660300002)(4326008)(186003)(38100700002)(8676002)(83380400001)(8936002)(38350700002)(478600001)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Oc+5Wt4+G0+6bVQvQM2mUCxuN/8K5hK5YclIMRmiI3fwAq0I5wC3WP74AB74?=
 =?us-ascii?Q?IauJel9VS8km7t3H9rQ8H24x4dm7eFeJ+vCtPnaek2E8yk14kABeuRb9c0mm?=
 =?us-ascii?Q?3EmrUC8MgTtm0qJc7E5ugRJ/550Q8uSHdiFG6f0LGNpqEKRkSuan6dtwkI6j?=
 =?us-ascii?Q?n/aHuFapfy8I4urH+xoVXEcmdUJDguDGp3XChYTErmbxTgAcl3BfTIGJb9Lb?=
 =?us-ascii?Q?ruvSPqK0kRIgzLEB8fcA6Ujn8Mfmwo5fjqeq6QUvzrk/2XA+VV86C0afV34D?=
 =?us-ascii?Q?VZdJcaAwy4YcoMTU2FRU/jtm5/J+2HTkE/HiwscND0pYgdVHBaKWdQgjJ0sb?=
 =?us-ascii?Q?ulN+ry9q3qn+jLTN4MD05DYnvA+36tv6b6SUxzt0WtSg/yioOnKwn6/7Vfya?=
 =?us-ascii?Q?i8alBtTqDVF7t0PPVDcopI6Tab2MLPBVZBXP0WQjG+sCXvTfK7MyqxgOEWSt?=
 =?us-ascii?Q?BwI8J5Of2v9SkRxfl+VEPXF0dpYePOb7WcgowK9qKKADRCXPff4E/LofqCP+?=
 =?us-ascii?Q?82waHisf0epmH3T/IOkKC6QQqMgRsRMcbDHXw7irHaFPGZyWI/m6XHBygIDA?=
 =?us-ascii?Q?3DVZXsMO7SRScYOGhsKjPsdZDA3gtaurSykbJQLTg7IdchneUzhuSMyygeB7?=
 =?us-ascii?Q?Yrb/wvnFTEN7Ip4ELMZr1Ujh2vxmfwg/LVrHoss7nrZc6K86S23ehj3avwZO?=
 =?us-ascii?Q?KkH0pZKxyUenTg8N9nwQPyB1ZQFWrlUEBsQBzDXD2rVusvaKJat8Aep/PG3V?=
 =?us-ascii?Q?k+rhqr2kh+3Q3pQmJatV+0sCj25iNkOBg/Q+EbPvFiI/Z0nLgHxhgokDkBRZ?=
 =?us-ascii?Q?1gKJxDH/84dqjToXRliU04Evsu6kAzTsNg8l+3PBwUqRd3UB+1Sv7LuOcJMi?=
 =?us-ascii?Q?iIffnVBuo67/jUSdkgb6heB8zCKgtairLyFOZP+jzqVTDzdlPc1jfAi4v0tG?=
 =?us-ascii?Q?nxpT+NmzeemsKW/+bHzJxjrVoN8NGKkN91l6kAxAuILAZ6ytrsIwgpxHdfhW?=
 =?us-ascii?Q?FH9l6oYCqilluTGnn16nWp9A9obz5Pho0BMRKWdF4ZMMQSTjM9UGGWmqHazj?=
 =?us-ascii?Q?5WduRjcLRC7ju2hnBt9AdC31glGa4/ztND4HV0meiKkPYVcOjXADOfBW4VP6?=
 =?us-ascii?Q?QIyfWg2LRc1EOGqgK+nvnXuALIUbPxg+lbOBt/ORQrF2xRQETsXsnD7hVgIH?=
 =?us-ascii?Q?sYDqZnnHbUKFLi7lwM9UlKoe3FJtzOuf8y5ZphrVzKIYlaBrZfdNhdShn0Oc?=
 =?us-ascii?Q?gjfWGH16AA7yyAViWtZ3I1KJMPZl71/ywVpcJzQzPV8mDDgPgOxJxtvw+UbC?=
 =?us-ascii?Q?o5UVt6zmmOgE59CrBPR9bgI/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28356e1d-7cb2-4a10-d2eb-08d9100fcc08
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2021 21:50:28.4544 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n025YMLvFJ1dDFgWIReuwPivgJ+7SpXU5qdGH+XN2vlxzQq15XkikegQhIzwYtkEdGlN9zm5z2BPA47mTHY0jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4430
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
Cc: Alex Sierra <alex.sierra@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reference helps hmm to decide if device pages in the range
require to be migrated back to system memory, based if they are or
not in the same memory domain.
In this case, this reference could come from the same memory domain
with devices connected to the same hive.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c  |  5 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h  |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c    | 31 ++++++++++++++++++++++---
 4 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
index 2741c28ff1b5..b4ec33fdf4c5 100644
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
@@ -195,11 +196,11 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
 
 	if (likely(!mmap_locked))
 		mmap_read_lock(mm);
-
 	r = hmm_range_fault(hmm_range);
 
 	if (likely(!mmap_locked))
 		mmap_read_unlock(mm);
+
 	if (unlikely(r)) {
 		/*
 		 * FIXME: This timeout should encompass the retry from
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
index d9111fea724b..7683cb44cb9c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1304,6 +1304,16 @@ static void svm_range_unreserve_bos(struct svm_validate_context *ctx)
 	ttm_eu_backoff_reservation(&ctx->ticket, &ctx->validate_list);
 }
 
+static void *kfd_svm_page_owner(struct kfd_process *p, int32_t gpuidx)
+{
+	struct kfd_process_device *pdd;
+	struct amdgpu_device *adev;
+
+	pdd = kfd_process_device_from_gpuidx(p, gpuidx);
+	adev = (struct amdgpu_device *)pdd->dev->kgd;
+
+	return (adev->hive)?(void *)adev->hive:(void *)adev;
+}
 /*
  * Validation+GPU mapping with concurrent invalidation (MMU notifiers)
  *
@@ -1334,7 +1344,11 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 {
 	struct svm_validate_context ctx;
 	struct hmm_range *hmm_range;
+	void *owner;
+	struct kfd_process *p;
 	int r = 0;
+	int i = 0;
+	int32_t idx;
 
 	ctx.process = container_of(prange->svms, struct kfd_process, svms);
 	ctx.prange = prange;
@@ -1380,15 +1394,26 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 	svm_range_reserve_bos(&ctx);
 
 	if (!prange->actual_loc) {
+
+		p = container_of(prange->svms, struct kfd_process, svms);
+		owner = kfd_svm_page_owner(p, find_first_bit(ctx.bitmap,
+							     MAX_GPU_INSTANCE));
+		for_each_set_bit(idx, ctx.bitmap, MAX_GPU_INSTANCE) {
+
+			if (kfd_svm_page_owner(p, idx) != owner) {
+				owner = NULL;
+				break;
+			}
+		}
+
 		r = amdgpu_hmm_range_get_pages(&prange->notifier, mm, NULL,
 					       prange->start << PAGE_SHIFT,
 					       prange->npages, &hmm_range,
-					       false, true);
+					       false, true, owner);
 		if (r) {
 			pr_debug("failed %d to get svm range pages\n", r);
 			goto unreserve_out;
 		}
-
 		r = svm_range_dma_map(prange, ctx.bitmap,
 				      hmm_range->hmm_pfns);
 		if (r) {
@@ -2650,7 +2675,7 @@ void svm_range_prefault(struct svm_range *prange, struct mm_struct *mm)
 	r = amdgpu_hmm_range_get_pages(&prange->notifier, mm, NULL,
 				       prange->start << PAGE_SHIFT,
 				       prange->npages, &hmm_range,
-				       false, true);
+				       false, true, NULL);
 	if (!r) {
 		amdgpu_hmm_range_get_pages_done(hmm_range);
 		prange->validated_once = true;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
