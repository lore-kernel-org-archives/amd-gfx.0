Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F6EC48BC2
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 16:04:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1508D60FEA
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 16:04:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1508D60FEA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC2AD6E204;
	Mon, 21 Jun 2021 16:04:47 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11E676E1F3
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 16:04:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VUSkgP7IbVseLn/pNCqsNhUDnnylrZxWMH5pKehVLcAAoy8C645C8f9ckdnmyrbSf6Y+ahFQK9FMoH+Kzth3mc3VEGW4rd6zroPOaBdRADmaxWeuvmyqNW4rv6x+zncZXSc/zXUDSYuGCv8BbMKNipmkl3ISJundB9EMKf4yrMUmxCJbkw+Cv4luD0gBXCJpMui8goA5twLT3tDq9XMq/PQILnCb5R+xnHSl0AWeUeNWEOkXEHHlKLZTs2FERhD8kpLI14CaNCZ+ypHf5og9idGD6jZRW5o1zIxkzvDOArR32ZCGE+FdaxuRYgyvU2vauJ1pRDrALQgdPHnz97W8AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FTTe/kJH0n14871Min69xwkMMcu6EjYYQl2dNDetiYs=;
 b=WlVS/U4vlJTP1ENb0WL21wHzFLlr4geTbkT9umC2a2mzGcLMnGJnl2bQfnamiPy5btWyX9etO7ks1BFZiWtT14pywiSj+L8DeD19TbUkRUp/RA7xF1RSs40NpUd8HIy2rSp0t5Fb7LRgPZ7CjRLqpGApcjpxcQqMe8VZUzd9Ahmw4y96dgEY27sfJoR3Blnr8JfDT+HNaW1ObunqacAQC0M9AGWHiBmApsA2Ll12pkp3+1PmWa2FnmLEOrPwiFh3puzPfL6PuA97Qmep5REdOitw0H206k0txCB9El7+k/HNG4Ip1cM33GlMNsDl5cdso4WTgoYOKX/+XVTHLyanRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FTTe/kJH0n14871Min69xwkMMcu6EjYYQl2dNDetiYs=;
 b=Lu+PmNyy/AuXFz0qNGoh1+4dboCcuUMiVPhUmWDduYQy/24Y4eFpNR4MTB7DL/9OjJ9j+4cOU7JZAbLvY0XSSZGkS4nIgvLNg+I2B9JnRE9P0+FAKbDlX9IiV5zwX22YmIHkbwWgz6382BuFBY6P7277ZpkCFcx2l10mx7N/be8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20)
 by SN1PR12MB2447.namprd12.prod.outlook.com (2603:10b6:802:27::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Mon, 21 Jun
 2021 16:04:41 +0000
Received: from SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::5ce6:fed4:e00f:27e4]) by SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::5ce6:fed4:e00f:27e4%6]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 16:04:41 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 09/10] drm/amdkfd: partially actual_loc removed
Date: Mon, 21 Jun 2021 11:04:22 -0500
Message-Id: <20210621160423.3517-9-alex.sierra@amd.com>
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
 15.20.4264.7 via Frontend Transport; Mon, 21 Jun 2021 16:04:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c39d910c-7ec9-4b79-7610-08d934ce473e
X-MS-TrafficTypeDiagnostic: SN1PR12MB2447:
X-Microsoft-Antispam-PRVS: <SN1PR12MB2447D6C358844BBA11B5381DFD0A9@SN1PR12MB2447.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z7wZiPfYCMKBdZH6ju73pUen1Y8MVWtk7pOhKuNUmBDJr7EkyJx03jV0Aqqa4mxjIFa5NRPtBhhMCytuWGbsclyQddvGKpc6/lM3iMBQJDxasx5ZTmIAj2UPdl3hb5pvH03dhHrzvd4ORRXeubw82pdQLKc0o29s7tH30KR9aNqYrWzoD9NUt+1qFrgynL15lF42m+YyxvwlUSUZnDuN1E1e+cGvDJ6WNwG5feXQOBVmY8Nnz/Gx6j44bl/oEw93EKchusEksyI4cC6BWH4/PUbYM1peTYntnJ/wwllNSd1F1Nme1bEFEVNJ9MTAy1NBx39VjKg8IJL+LeEGVDS+SChkPr7KHQopqONWjiQ4hgUCdLPuwQ32aSYTMWEYUfXIfEtO9qTaIyj4neO1FdIcfI5VUaRzXzjIDRTrY+cebrouTFpsl6a9J3QGXMb6w5sVDjHAoI8VY3n0vy7XMwLG0W9666QRbf5oQZ2tyJmr2wFc8n7q4ztVCKYB/fyZ/j/k7PBkCRrhR4v6bghnwr2RqBjclG1PBNCl3dvfXqE1Apa9IcPJv53BywuXcPTSHGyYn9iuWOVhzaHugWIC7VFrfZGaArb2M3JP6S0NnY6E0PllgVHBY9l8RI2qNFCbDlHd7CPSPnmCjmmn0HcEEC1Qx9dyddliHwcfODeEGIymVcQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4430.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(396003)(376002)(136003)(39860400002)(2906002)(26005)(38100700002)(86362001)(38350700002)(36756003)(956004)(8936002)(2616005)(16526019)(316002)(8676002)(186003)(5660300002)(44832011)(83380400001)(66946007)(6666004)(6916009)(6486002)(66476007)(66556008)(52116002)(7696005)(478600001)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QlUzAMTyurDi7nDFPAiLZl6UFXwhKG7kpF8mvbeyP0J4ZLnZZZgLpogZxzDQ?=
 =?us-ascii?Q?q72KuwunIMnFlLS94TrE7KTGi2zp9SgSKHfbk6XLo53ZNUh9nqhwdIby+mly?=
 =?us-ascii?Q?Vx+cj2WUCOa9MCX3hkCZdY0ANLGuAwqL8KriRsK5OjrC5Bm6zWTXjF3A1UFe?=
 =?us-ascii?Q?FOa6mdBLKJXtn2szm2EJDiTD1oBKBwrzrAnYo4ExfXAj+sTNitZgAJHOIhVS?=
 =?us-ascii?Q?HIze2BLdukv2CZ+W68SsdV7Bx69kMKN+ffD6KaaGXCt/MjmhZY9jxpdH+Q0g?=
 =?us-ascii?Q?POyhUW7j3/5YloKEsH5RZe9AdFDafRylVxXO8BNuSfCKHOizOaPBSgV729Cc?=
 =?us-ascii?Q?Woxk9VBixK9IVLUT831wlfN1ZRfpchAsee0+joVx6vgZviU24FNNmjCcLuoG?=
 =?us-ascii?Q?5D5N2tde9A6hD/SyKhd4s4m9pJ9OIIEXh2I0BSBDvgAOPqmBi6Qas9QkNO2a?=
 =?us-ascii?Q?LfrIsDYqo+k2y9h+ore8EmNC/27oHArptcqOBupUVlGPRHoM7B3vQlRPRoyH?=
 =?us-ascii?Q?yYAZAiqSGzDvlvhG4w2s885rx3Mip3xcInwiFn1yi2qVGWcQgXByXHc+Jn8h?=
 =?us-ascii?Q?jyLrkH3uQ5zSYXcP/mhvowx0w1mBTp6hX9YbDFUbPd/dUO3sjgL/UTGDJ1K+?=
 =?us-ascii?Q?vT0ETb7bz/A0AQmJ8001Cnr3ITiRyOA5gXWEneaApDDt+G0og2G0S3O37XM6?=
 =?us-ascii?Q?jA+4idHIE8XqGy6yD2dyvpiluzxLhc1U82y9o7I4U5NBvw0WgocmHQqoWIhi?=
 =?us-ascii?Q?aN+cWsRTxDW2yN7bJvDt6APwg7mr7V4um130YOrv5wikI+iFUAywnC/DhNRL?=
 =?us-ascii?Q?/MO9KDRtDSdQRTt2Ds3/5X+UpCVkxPuJ47nor3h0M7FJapQ4Us8LV3+MIgEU?=
 =?us-ascii?Q?Jc7PrMD9LyBndRF+ENMB91o6Vhn+XxOyZO9rn3rUWtimCOnLWsd0ziAdBGv0?=
 =?us-ascii?Q?ILTdxlxuCqaZ8w6Q6GWnBJ2XFugoJP7JVAxCGr/mrXrHzb+GRwK4a0blliaQ?=
 =?us-ascii?Q?K39uRp8mI01J3FAhKq7igAs3a4G2UhSGf5WzuVUiS5AFIgIe13CaRfbptaCC?=
 =?us-ascii?Q?NRDnwebS3K8OCfVAfhi8I5+3if59wF7Vbd6pYHj9x6sLRZp/C7VzEaFoJZcF?=
 =?us-ascii?Q?7eT1A3hs8XMu9ZF6A6FXYuqvjmuBkin0FGon2W0QwlrwpMfUzeO0siLtd5XF?=
 =?us-ascii?Q?/95Hli8MZJwr3YBiXCgFHR1JHSohujGUAEfM1U8ey0mG8TMWqPTjgDFXrvMC?=
 =?us-ascii?Q?9WvRVNakOWSLnFOTmMntt58BotKiuMC2V6pUIqxczV3wLtifbsbs52LRjU9s?=
 =?us-ascii?Q?5WKkINA8Emk3Vb/oFf/ybGSs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c39d910c-7ec9-4b79-7610-08d934ce473e
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 16:04:41.4212 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UUztaIb1ydAp9lFAqULmt/DhHkjApcJ1In5BTH+on75uLqTGygKB5MaFLt+TIuOUZvrkJ97sQn3x8Q5CgevF3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2447
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

actual_loc should not be used anymore, as pranges
could have mixed locations (VRAM & SYSRAM) at the
same time.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 12 +---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 71 ++++++++++--------------
 2 files changed, 29 insertions(+), 54 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index f71f8d7e2b72..acb9f64577a0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -501,12 +501,6 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
 	struct amdgpu_device *adev;
 	int r = 0;
 
-	if (prange->actual_loc == best_loc) {
-		pr_debug("svms 0x%p [0x%lx 0x%lx] already on best_loc 0x%x\n",
-			 prange->svms, prange->start, prange->last, best_loc);
-		return 0;
-	}
-
 	adev = svm_range_get_adev_by_id(prange, best_loc);
 	if (!adev) {
 		pr_debug("failed to get device by id 0x%x\n", best_loc);
@@ -791,11 +785,7 @@ int
 svm_migrate_to_vram(struct svm_range *prange, uint32_t best_loc,
 		    struct mm_struct *mm)
 {
-	if  (!prange->actual_loc)
-		return svm_migrate_ram_to_vram(prange, best_loc, mm);
-	else
-		return svm_migrate_vram_to_vram(prange, best_loc, mm);
-
+	return svm_migrate_ram_to_vram(prange, best_loc, mm);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 3b05bc270732..ebc1ae7e5193 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1421,42 +1421,38 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 
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
@@ -2741,20 +2737,9 @@ svm_range_trigger_migration(struct mm_struct *mm, struct svm_range *prange,
 	*migrated = false;
 	best_loc = svm_range_best_prefetch_location(prange);
 
-	if (best_loc == KFD_IOCTL_SVM_LOCATION_UNDEFINED ||
-	    best_loc == prange->actual_loc)
+	if (best_loc == KFD_IOCTL_SVM_LOCATION_UNDEFINED)
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
