Return-Path: <SRS0=w1A1=LX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D177C11F68
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 18:03:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA5B961DD7
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 18:02:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA5B961DD7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81AC46E8D7;
	Tue, 29 Jun 2021 18:02:57 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EEE96E8E2
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jun 2021 18:02:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V21nEjkufMl3iLg6mbwf3ySUVZfpAeshdkSAFuKwq5AGvTeQm6EDqDTAeJfKqFKIF18GK5wY9ECzKdXx4uCAEw06nAJ5Rfuo9d655fdy4TndmOw71+rpouAsoCQr85k54Gs+WEpvaAJaCeR+ir+HfrirUjSriw38b6/fAvHYzahNr8u3vA3OjenKBRZSyIxUYqKv58PULsOFTZEuVXQbnHSF0SZmM07fV1uxPWZnXMSSlqVCagov80lRQOOvR5lg4TdZEH297qezz7FxqougfVtg6FaW4N/g7tkTlo3XqTThG5gVxDJKI9ClAtgJLPApMqCjrKfc4DQJqlYKd12BSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6P90tQ+an9W1MYvSHJK4g7uxBaM5lvjz2YH7IYNuLHU=;
 b=DCOQSAE7Qeo/pzB/5K3RHg32mBixbnTHXGlHGJHCVXI1R3uQljCci10o3v84iYh/3vsRfTr94eBKpMMSScdqIm7OUGqzuDx4OgPLsdr+dZCYpKOTNqvx7TuSME9kWVMm9YxEdJFbx4dcU/Kc44A5/5QS71itVbjNmb/iOwjfNlgfE4t3/hD8hXt3OMr+L0Td15UBB3K/El09RtDc/qfhiFA8SbaiO17f3UcHYxFdzagtaMlBep8L3/iwT10yAgXoSLV1EWvXXDZrGjbO/68t7OtE715LPom/wK0f4NOGctg0EuxMEuTOPSL3CA/X0gHikW3gOlkWCoOTnUousDpHwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6P90tQ+an9W1MYvSHJK4g7uxBaM5lvjz2YH7IYNuLHU=;
 b=L7c1Noo/jWyw6G4EvCYzx79pEX38/2fKnKM1MJsoJNJqvXPbhvEJard8ePJfu6mBH+Tzxhxa3JWHHu9kr7O+JD/3qSxPFntnrknPAT9F/aiphQTnyANQjlCYdwZUjhAmhZPWTL8EAm8bHJTyZ6uDaa9Gte1QseyL84aeEJyMZvE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20)
 by SN1PR12MB2542.namprd12.prod.outlook.com (2603:10b6:802:26::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.23; Tue, 29 Jun
 2021 18:02:53 +0000
Received: from SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::5ce6:fed4:e00f:27e4]) by SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::5ce6:fed4:e00f:27e4%6]) with mapi id 15.20.4264.026; Tue, 29 Jun 2021
 18:02:53 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 02/11] drm/amdkfd: add owner ref param to get hmm pages
Date: Tue, 29 Jun 2021 13:01:57 -0500
Message-Id: <20210629180206.8002-2-alex.sierra@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210629180206.8002-1-alex.sierra@amd.com>
References: <20210629180206.8002-1-alex.sierra@amd.com>
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SN7P220CA0022.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::27) To SA0PR12MB4430.namprd12.prod.outlook.com
 (2603:10b6:806:70::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alex-MS-7B09.amd.com (165.204.78.1) by
 SN7P220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.18 via Frontend Transport; Tue, 29 Jun 2021 18:02:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 529f56b9-b0af-4057-c4fc-08d93b281d67
X-MS-TrafficTypeDiagnostic: SN1PR12MB2542:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2542A40FB5CC10B875F35F98FD029@SN1PR12MB2542.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mvcd2AzYcTQxURgxADAXxN+jmwFJyPoGHPt3y7DGJw4fQoTjx03hJAM+mKDz0pWPvdE6O1wPtmkAjm4YWB/Ec2J/5wQrWjjBePy44ocxkcQVWCCrmNvr+DHTIumSY6ADHLqXFlEiekCTqS+KYO6WbZr01m/gOqQccTK4/ZhnCCokQOMGNPexhzU30ATkGROydxaFG2aQJzS9pry852+EdDIdAQcUmqAJT1jrv7OAYymvEppsGdJks3SRMnNWysJjG1FMMRSUVfea+wShnIOpOWxfFTw0QDr8VIef4WkDRwCq7uJ/0Zl/8Ql1fVqBQXJcSr8eunXoAyXxdpyBFdPKQBLoLCWBeayhbtc3fL9l5bRrHAPnRFasgsTTz/Vs8cIcHWzOO3AnKbrE4v7YeORkZrL1B6F6KpYrgLQ8zim0Kw7CERc4tndra1Tcm/J7xCTK/g8Dpa9nF+oDoyEQhWaaNwSZF/A2oR9aL5pfGb5AKGLYpIUddspSvi/I48yDDhv/zKFDR+pz6rOLaDoGuJCG8YiLMKpSNhek8KAr+hg76Ud/csOFA70nMMtutPwUxvmbPIMr92M3yBZ7j6CMGCUCCJa2gohxjiQkwaNtoMCSixogBE1GRARgH9r5jdL/QLwZdlJveaMHtVu0A2bLq7Q/NBk9Iln9J7N+GXKVWLEC0Ipg9OMWsLLkSQWNJiP/5gqemikaQBtapkbkMOVyt73C4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4430.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(346002)(396003)(376002)(136003)(38100700002)(2616005)(86362001)(52116002)(186003)(4326008)(44832011)(6916009)(7696005)(54906003)(956004)(8936002)(16526019)(8676002)(38350700002)(1076003)(26005)(36756003)(6486002)(66556008)(66476007)(66946007)(2906002)(83380400001)(5660300002)(316002)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PLuIyapWgAZYxmkBZVjDqmrEiQqX2Cmb6VIqfkvyNuINKVbqlvroHitp8Rxg?=
 =?us-ascii?Q?9kMTcEOlWPmP+FbbGntfQ98W2I7FXU3JlT+FOnmfwnOxlLs9y2Zvd+AREcUa?=
 =?us-ascii?Q?VUmEGVqlnVo8nj6pCSFan3hxTGKKokVrlhd9E8fT/oNWsNvq/ODxHY/AqrwC?=
 =?us-ascii?Q?604AEKA5uH+XayiQzSL3cB9FmXjLtGA6FK+PZSI4u87eWNSKcbtlT0DeZCJT?=
 =?us-ascii?Q?hO+5jo+G6Wjwj1GiNG2q3n7m2cNSiIBrWifR6cquv84KckoREcS4yOUcmK75?=
 =?us-ascii?Q?viLEDuP6hDHONfYNdB6ESDyy5qB/NRvpglZcfxjuZzbf2/vphN10y5jVNIms?=
 =?us-ascii?Q?s1yfgBpsG1tBZyqAGigwmTrFcy9HMAYM2rHFf9z9tWz/YvoV+T0oYcVfk/rv?=
 =?us-ascii?Q?hK0TNISTqFpvecNIUGRF0Zj2myfZcF2qFZ472q7Q0nYsboLMhS5cyrlICZzU?=
 =?us-ascii?Q?7WN5bdY1z/s3H54bec2NId8nUS32aFZWyTbVnNEKxqoN9gW9p3L2q6rX1kWq?=
 =?us-ascii?Q?LLgAdSxGAaYAojtjxBB3uYEneHNTkWvYV1iTG4xlY+v9I7H/G3fev7prevIN?=
 =?us-ascii?Q?dShIMxQpJ+8LaZdeFCan7DGuXhVzNhE7wn28LpIAAKeStCmGe5fvzsynYAtt?=
 =?us-ascii?Q?u9CHh39vcOCFMPW8n0qRjFrMlWnvPV4SrVD9voPW0tyNywpx8xjhiAMoNFF+?=
 =?us-ascii?Q?4eZ6pI4uVwMG921DgXcKfu43heRoGs1fSDdKaousM3MVWC99Dg6WkELZ+xMo?=
 =?us-ascii?Q?UMcrnyFsXQqAEyYQPudrmJ3fpdLlbw7Ygfmr8pEjs7ow84JIdPZzQ0r+2okl?=
 =?us-ascii?Q?3Z7tlMpRWJ6y6g2KK/siaZD7HXMZMiaASAsd5ycLb6dOd7KX/xo+MUkafRBO?=
 =?us-ascii?Q?ywhyLTcXoJV8VMHQrJonKE2pvXP/pf+mCs66RoOQYly6bDFatLOIrU09Em+4?=
 =?us-ascii?Q?4gsFRI3znOM1MDd017Dk475rBQcB6O//qmeWv/8schGyk5KgQ2HRAkJlbCeS?=
 =?us-ascii?Q?xAFGojiP1NYDjp9kkyvxpeYWDc22kVD6Juj4gnZKFGhaXC5BfiQzHPvWJkb5?=
 =?us-ascii?Q?k9oRXSooppyf64hzBOaO0XDfPH40chApUkagDUcEPdFZKd5Z19hmmQlmK/pF?=
 =?us-ascii?Q?VjMMfvsflEylIi86WBIUCidyh/sN/gQGHHaN8n5lu8rgBa2ZaFZ+61dD/Awk?=
 =?us-ascii?Q?oRydqy8+2VWsaOMtpnTlmQK/7AEECz4wpKZ3ELHI+XdqODKDlazoUlUJglWg?=
 =?us-ascii?Q?FrrTSRmgCaqjLl8ibtmGXsEtksMjJzZbN/rmCx1EYvIOwhqlGNWQESNRGxRY?=
 =?us-ascii?Q?8rQQbhXTSeetSSs0AM4Rh6MM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 529f56b9-b0af-4057-c4fc-08d93b281d67
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 18:02:52.8980 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bqkCvj6pmid4VcnmjJuNS1uKOr9c4/onA9CizANHCFh7z5rI1iQMtQTeXDQZY6HMw2l4P8wLYeHdx82zxJ+Ddw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2542
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
Cc: Alex Sierra <alex.sierra@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>
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
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
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
index 6297363ab740..89bd19e816f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -712,7 +712,7 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages)
 	readonly = amdgpu_ttm_tt_is_readonly(ttm);
 	r = amdgpu_hmm_range_get_pages(&bo->notifier, mm, pages, start,
 				       ttm->num_pages, &gtt->range, readonly,
-				       false);
+				       false, NULL);
 out_putmm:
 	mmput(mm);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 00b46846a5e0..125099a91e18 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1416,7 +1416,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 		r = amdgpu_hmm_range_get_pages(&prange->notifier, mm, NULL,
 					       prange->start << PAGE_SHIFT,
 					       prange->npages, &hmm_range,
-					       false, true);
+					       false, true, NULL);
 		if (r) {
 			pr_debug("failed %d to get svm range pages\n", r);
 			goto unreserve_out;
@@ -2716,7 +2716,7 @@ void svm_range_prefault(struct svm_range *prange, struct mm_struct *mm)
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
