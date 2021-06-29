Return-Path: <SRS0=w1A1=LX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 210F7C11F67
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 18:03:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB93961DD7
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 18:03:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB93961DD7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFADB6E8D9;
	Tue, 29 Jun 2021 18:02:57 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50F7C6E8D7
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jun 2021 18:02:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kqBKRMIpMFZ58lh/uhiz6XDvjTDzQAzglwSPsJC7Qr3svJQMst6u/VqlE+oGGhVeg+znflrRhqGsRXeovJppQ5KGu7rpO+LN/V8CrOTZHNVj1x8da3Zp69VnZWxC6Hw/WYOJCcYTZ4xtMD1ujzpWwKpONgm+lOiqCU2IKrUKZoOcZj4+VMhwiRuh4Ct/Y2To5FOvxGuIjrccI7sCoOQMsyOP0cB+ETlzhKNB+0xUI2Fz08Zc10ajB15/Qq879HsIJvRNsQkTXNWQEF0/AS1GRuIRTi+meny00UDm9Wbu+A4Etqu7+Mqqxy18b9xii22n+Dk/ELlQPzv4Bs3kM4cxjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KIsGwIG/SMbO7RAMGJMgnSmScg2jjUmngC5hg2nAaj4=;
 b=cxu/O8uxiefQMWWuyhs+yjt5b2XLkLVRKHD0r99MRjN606Ldc497TrRLHZTmSLWasgjv8AJsAVCw+BTtAGdesD1U3kPEDVGSDQb47RDKXIXJRTO8RF3ynT6COliHPlXhrnR7S9zYrcio+Qy4YwaBFTMOTggopRT0kquxUdQk2jLJgrZx49ji1TIkiZHU2wWiWEwnOflxXs1/ej8ByLgV8/O+H4y8enXYjEUTbc8z0BadAXJrSMZkff4PxGprcgO57/qJiX7Gx1hjOdPAC5D/L/7/n6ocWONWfblDjErCreTxHrbHs+hrz/9dLSTBp40eIiBmo8RoLJ6bS5rWW2oGoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KIsGwIG/SMbO7RAMGJMgnSmScg2jjUmngC5hg2nAaj4=;
 b=Dh9oYkeTXKobEPpUoOA98wrmsYwqE6/8F3RAo8Y3WhIYSfapNQvI2B3fvYdpBgD7Pi10eVI5Ioh3zMZlf0FfsonsmaWHO+jkAbMPQizID7zbGX7g7YgK19eFmCPV8ZNloRKYBNskRtg67pX+pXzpYYmxYwmjWnkztlEOqZxEGBI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20)
 by SN1PR12MB2542.namprd12.prod.outlook.com (2603:10b6:802:26::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.23; Tue, 29 Jun
 2021 18:02:55 +0000
Received: from SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::5ce6:fed4:e00f:27e4]) by SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::5ce6:fed4:e00f:27e4%6]) with mapi id 15.20.4264.026; Tue, 29 Jun 2021
 18:02:55 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 05/11] drm/amdkfd: use hmm range fault to get both domain pfns
Date: Tue, 29 Jun 2021 13:02:00 -0500
Message-Id: <20210629180206.8002-5-alex.sierra@amd.com>
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
 15.20.4264.18 via Frontend Transport; Tue, 29 Jun 2021 18:02:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af376d27-8213-439e-1834-08d93b281e53
X-MS-TrafficTypeDiagnostic: SN1PR12MB2542:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2542D03D8EFE4560C01CEEC7FD029@SN1PR12MB2542.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r47nTXpE4PdCdCnen8P6C2xya1yZkfS1Evgf3eTlOoahB11V+sVTRH8a+rx9dGMp30E66IEo23kn32HO1BscwEHmAIwKxONSakmM7DvUCr2PiQDI8THAQFdowhA/vvofzVMt2rJn23VNY+X8rsXVSHYeFrsJjm9SCxuPKIalb4von/P0HR1mKVoa7U912NbNrWvS6pyqBfnz6Ialt5M80Y22drPeyrz2vzyUpvjJPqdQ/HohKgnLkA8BHVSBezOCCG3PuZCjPP/SeAPPqZxYnqDqQOTbDSzB113bjJPoEds4vZgWqfx3xVVmPBzSYp1XPR0yGKSdy5qUS9n6C7b7p29jGR9cFypMk3zBx6nkIwDkkNLopmayrcAwiyeW72oeCrj5dXKckK1F6kvlpzzkBU7j4L13r2ovqHQb6Xtw7+CdNFytKl2h/Z0rWjjjXSqjB5WAWNiG84GZkstm38rDbnIV4ic1VzhK8m1ZeDVOMF7RPp2Zef3KzTcBRug/eyDV9wgeLrI/DTlgCs9Wj012oiIL60gobZ6kqgUfHFTwYfMwvxzQVToyFMdIaI9DTUJ4JaybP2cnwfLWHBfSMoudQk1y79NUTyZbFMP+d0gdMscIFunujyZhc1Q86aQH3notP31zQ3zM6UlVaLNba4cxh8squprGsi3VKR6h/MgZiuJE+v6eMtpfB+dkLdjTHYeHJVOcqxHLd0BdNGNmwLsX3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4430.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(346002)(396003)(376002)(136003)(38100700002)(2616005)(86362001)(52116002)(186003)(4326008)(44832011)(6666004)(6916009)(7696005)(956004)(8936002)(16526019)(8676002)(38350700002)(1076003)(26005)(36756003)(6486002)(66556008)(66476007)(66946007)(2906002)(83380400001)(5660300002)(316002)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XmSAxfiw/82lLBJYKJBsM/7+6amA9fYleYsV0oDDp09QR0ODlxW6kvfP0Y+r?=
 =?us-ascii?Q?wPJQPJpKzADZAmG5PB3cdzhr2bDDllJjKu33hNKTLHO56ESP6LeZiZDDMVSl?=
 =?us-ascii?Q?eJwSp/NlLmONHDU5/YNMERvK7aXxWYhI1zei0RH+19r25AN7odsIA/Gb/myh?=
 =?us-ascii?Q?V+o2dxDfnCNhoXzzWNIe+UAX/GxWzql9Rpb/D1Jbbmczjw/mDvWRzjXOA+nv?=
 =?us-ascii?Q?2AadqOOSwUHPc7SqJjtxCP5K69bGwFAlHC9m9YmoUlAszlhNilFX1egB8jnL?=
 =?us-ascii?Q?Xqem14LvPCTCDrbU9JljWvF2UtojbIhK5EWb0lCRda4zpP5mXhiAU0P2fcVm?=
 =?us-ascii?Q?4YjGyrH1EnR0HHO0zBvLkQ48WKKzCXUgnlv2mxx9cVd/UUHgZQbXzL5JaZWZ?=
 =?us-ascii?Q?yIoAUEh4bQeS1IktUYS5NZDrb7yh7d5cVttTAiPaeb2ukmhcOdXaoH23IDXT?=
 =?us-ascii?Q?zLOvFjVuWuoaFXDJygs4zHchbcEZ252e6QBsGhICXrNg7ayFHSPNavtVSvtZ?=
 =?us-ascii?Q?0K2Qcbw3HHw9hMjo/P75QDUJ9i6P1dWdh20AP90vHupMyW6WAys2MCmHkXCh?=
 =?us-ascii?Q?rgPP4BWQRkwgIdkFQanBlqBDkPrGBegBzjgIDopdPKxEvU9vFnlBZ0W+3A/V?=
 =?us-ascii?Q?NkppxaDakAEzD6CROOsbODZzZAWQ/Rm7GkZUHwJn/xfOMfupp2tfgyDf1hJF?=
 =?us-ascii?Q?KvB78XY7b9hOqwqT1Wloh9cqqdd+zNiQMT/IwrKWYHeiXQPVhLiPk/jiXjle?=
 =?us-ascii?Q?21sCI2cv2WOGhD8kii7jXoHwS2x6YrwvE/0jQFZpL2jACRqoZi/GcRL3C4kA?=
 =?us-ascii?Q?JY3BhG4J8CcFhXUedCAfbishNsVMkcDEYjfL/P5RXGoe3+6vixQ2Wk6Xk8re?=
 =?us-ascii?Q?evLpY7pTtQLcZFBoUW3uCXHybCz4FDkFoB8hKKxqVS/GG0dkaeAFW6pO87Ky?=
 =?us-ascii?Q?ZFjXzjfhSQvz33SnSWfNghND+YkTQp2fmDVo64B41UWvVM2gZJMdCf2TLqyf?=
 =?us-ascii?Q?Pe5w526u6pTaAwCSGaPa6SF/vEJTScWE3XhrqPRvObnpFRm5jSPm42KTyNIa?=
 =?us-ascii?Q?5EqZKMLpH04udhVas7X0L+lHkR62XM+wH+nq+nEctdt5F65iCmFX6HlIzFFz?=
 =?us-ascii?Q?2txpvj3YPRwV0O+zPaWnQC5RJ5L0AuCEkToSe51Q569mITIX2Fhm5HlQDK+t?=
 =?us-ascii?Q?go0sGkvHlz0EQbCOZQZqFltUdJtKEWu/lNZ5rYQT4vzYulZdMU6cK7gB/6PJ?=
 =?us-ascii?Q?wWC4dII6RKmQFQ4bYn2kaIpg8cW/w8S2YNFDjW1yyZcMdMOH2BlLhynvtoWR?=
 =?us-ascii?Q?VBDRGYi/K5FH/qeLWjcGvMoB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af376d27-8213-439e-1834-08d93b281e53
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 18:02:54.4323 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lXmTtI0W8gADn3O8NQ1iEpg+eQnJXbHE8OXG2k2h4azmXVNPXNAZtodQ+txKheCQplAP8F3y5DPYm03K7h8i7g==
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
Cc: Alex Sierra <alex.sierra@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Now that prange could have mixed domains (VRAM or SYSRAM),
actual_loc nor svm_bo can not be used to check its current
domain and eventually get its pfns to map them in GPU.
Instead, pfns from both domains, are now obtained from
hmm_range_fault through amdgpu_hmm_range_get_pages
call. This is done everytime a GPU map occur.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 68 +++++++++++-----------------
 1 file changed, 27 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index fafc11cd274d..bd0cc438c429 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1426,42 +1426,38 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 
 	svm_range_reserve_bos(&ctx);
 
-	if (!prange->actual_loc) {
-		p = container_of(prange->svms, struct kfd_process, svms);
-		owner = kfd_svm_page_owner(p, find_first_bit(ctx.bitmap,
-							MAX_GPU_INSTANCE));
-		for_each_set_bit(idx, ctx.bitmap, MAX_GPU_INSTANCE) {
-			if (kfd_svm_page_owner(p, idx) != owner) {
-				owner = NULL;
-				break;
-			}
-		}
-		r = amdgpu_hmm_range_get_pages(&prange->notifier, mm, NULL,
-					       prange->start << PAGE_SHIFT,
-					       prange->npages, &hmm_range,
-					       false, true, owner);
-		if (r) {
-			pr_debug("failed %d to get svm range pages\n", r);
-			goto unreserve_out;
-		}
-
-		r = svm_range_dma_map(prange, ctx.bitmap,
-				      hmm_range->hmm_pfns);
-		if (r) {
-			pr_debug("failed %d to dma map range\n", r);
-			goto unreserve_out;
+	p = container_of(prange->svms, struct kfd_process, svms);
+	owner = kfd_svm_page_owner(p, find_first_bit(ctx.bitmap,
+						MAX_GPU_INSTANCE));
+	for_each_set_bit(idx, ctx.bitmap, MAX_GPU_INSTANCE) {
+		if (kfd_svm_page_owner(p, idx) != owner) {
+			owner = NULL;
+			break;
 		}
+	}
+	r = amdgpu_hmm_range_get_pages(&prange->notifier, mm, NULL,
+				       prange->start << PAGE_SHIFT,
+				       prange->npages, &hmm_range,
+				       false, true, owner);
+	if (r) {
+		pr_debug("failed %d to get svm range pages\n", r);
+		goto unreserve_out;
+	}
 
-		prange->validated_once = true;
+	r = svm_range_dma_map(prange, ctx.bitmap,
+			      hmm_range->hmm_pfns);
+	if (r) {
+		pr_debug("failed %d to dma map range\n", r);
+		goto unreserve_out;
 	}
 
+	prange->validated_once = true;
+
 	svm_range_lock(prange);
-	if (!prange->actual_loc) {
-		if (amdgpu_hmm_range_get_pages_done(hmm_range)) {
-			pr_debug("hmm update the range, need validate again\n");
-			r = -EAGAIN;
-			goto unlock_out;
-		}
+	if (amdgpu_hmm_range_get_pages_done(hmm_range)) {
+		pr_debug("hmm update the range, need validate again\n");
+		r = -EAGAIN;
+		goto unlock_out;
 	}
 	if (!list_empty(&prange->child_list)) {
 		pr_debug("range split by unmap in parallel, validate again\n");
@@ -2785,16 +2781,6 @@ svm_range_trigger_migration(struct mm_struct *mm, struct svm_range *prange,
 	    best_loc == prange->actual_loc)
 		return 0;
 
-	/*
-	 * Prefetch to GPU without host access flag, set actual_loc to gpu, then
-	 * validate on gpu and map to gpus will be handled afterwards.
-	 */
-	if (best_loc && !prange->actual_loc &&
-	    !(prange->flags & KFD_IOCTL_SVM_FLAG_HOST_ACCESS)) {
-		prange->actual_loc = best_loc;
-		return 0;
-	}
-
 	if (!best_loc) {
 		r = svm_migrate_vram_to_ram(prange, mm);
 		*migrated = !r;
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
