Return-Path: <SRS0=w1A1=LX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8019BC11F6B
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 18:03:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F3FB61DD7
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 18:03:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F3FB61DD7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B449E6E8E5;
	Tue, 29 Jun 2021 18:03:02 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9EE56E8DA
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jun 2021 18:02:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JhGfgQDJUltylEnyfi9tEwEzf4TKAA/SwtsBtOZSizU48uHyPeEzMuPcHxIaf5viGseEfhYsjvA1CdQ+cqAFMqfDHuSa+70SXovtmwMM8d4MWlvMVz2PMEKCSnStOt0LUZY0BDx8ATAI9+6LGEyrfJo+NsOP0AKXp685MbUb8vhpAWsMFyw0wV1cQe2ATxIFDtIZbSCMrLSKtzdsC5rIfcsMcq2+K5TuTr/S/IDEiRW9YH6EQWUPCkkAE4dA1CbUUaKtXUMykzelfj1gOd58/NnC72OvXnmltSya4iHt7TsK7K2cDieW7Sdcop+3FQ/XvEw3LTJjCybiKO5ocxTf+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vpHuMK6aO0rI1sPLEHVEcBaTuwGycZBjS3ZTPIiXtWk=;
 b=Ph15i92QPzB1IkyGL0uS1nOckdIcL1eT0nQiburuEKjcM4VAKZtAeXqffCznNpZZ9GF05SSGOjD3o4bDLlEFibF1jxCkJfNkhchfNGF+i7L+jrFj3sndAViIjouIjwjCZRKrX2ox7gQpJ+nUS0VcFzeGlcEHsca2pyucOnNhnup9HoPgqzyyIOS+pgHRHSqY1lv9Zi2+XnC+ucPnWVaKkgh5ufn0ryS3IuZzcn7AgEJbf5Tqq3ozsqVkoyBu/mbqZxhxRfTsY8d9pqavj2GBxqUYCs5sPCoyJrDGtkRNiPXkgIV9ocBvgqsgoU5/uLkM+QbDG69woMA0GETPmMuW0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vpHuMK6aO0rI1sPLEHVEcBaTuwGycZBjS3ZTPIiXtWk=;
 b=HO2jQ+Os1xwC6C91I6nAG9+C+Xc7+HR3arQbgPTicvunZEtIEmwZJhPAqsB3eE7CDbItAdjUs98555rbtOh/WTJTAjGwYbu8LSOd9zh7PbPTg4PAscG1v1ERb/KA+YGEx4LqfHNDUXnxbWxRJQQGFQMk+cFvjn27olRsSsTh/ds=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20)
 by SN1PR12MB2542.namprd12.prod.outlook.com (2603:10b6:802:26::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.23; Tue, 29 Jun
 2021 18:02:56 +0000
Received: from SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::5ce6:fed4:e00f:27e4]) by SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::5ce6:fed4:e00f:27e4%6]) with mapi id 15.20.4264.026; Tue, 29 Jun 2021
 18:02:56 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 08/11] drm/amdkfd: skip migration for pages already in VRAM
Date: Tue, 29 Jun 2021 13:02:03 -0500
Message-Id: <20210629180206.8002-8-alex.sierra@amd.com>
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
 15.20.4264.18 via Frontend Transport; Tue, 29 Jun 2021 18:02:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92a93633-9c86-4543-cdab-08d93b281f5c
X-MS-TrafficTypeDiagnostic: SN1PR12MB2542:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB25421BB9D4D76C7B06BAECF9FD029@SN1PR12MB2542.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xNuvHWze5kbzRXLaiCYsEq8j+MtFeui0UpuDTv0SMx7Eg2R0l1Xv6p8KPqCQYOIk+8PMyFx2s7eEsPOQCN5oDhXjNIJlhMmc4gH+/06hsDOcQC4QPLwV0KLxgqr7fq1cjFcNtUwxUsZbdV7lNoQ5OYpCtaEjb+eMZwDKFyCWmSLum5hLeVJK1FbUh849lFwseaHsPmUiidyN9SbxraOzq9RTEHohcSoqzJNImpwckRFVPQH9eslkLeRsjoZMZ6svSn0jZIo/wQw4ftS/avPZzyjGnJq2dge2A3jOtIFib3zbwXfDqE5S8BmJd287BpBMi3rYf4BAJ4F1YBSxET8oPU0POqai1PRf0ZTo/Ab7DVGo768x2ilx5TYRc3XYOkiLdBzs7i8QNOPEmEWEMiZbQKarR6upujY8DHS5I/P1+ZByE8RZpDHsMdG79+2qVQxHkjowHjjhnJg+XXtgf3WuLqPfZD/bw1RYmghvgGhjRcxZuIA59QE0/w5/u4w/TpnlZ7kWs5tUnxPrYDmQd4Yn76wpmu8IcnXd5H93LzVE1ummD4WmFvPlENS0fxy6H9KRJi2zcqikf/pEnwfqKJE37ZpA21epAKrCqA57DSN7PbIUbmF0AOzsQ5/IVEKMyYAjlkSVnx2AA7/2Ose5jfBVc65C2h5ONML2Ar/UWuu/EDG8z9p4esd8/nmXsH1nm6TdFPltTPdYnX/hoeodveNqGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4430.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(346002)(396003)(376002)(136003)(38100700002)(2616005)(86362001)(52116002)(186003)(4326008)(44832011)(6666004)(6916009)(7696005)(956004)(8936002)(16526019)(8676002)(38350700002)(1076003)(26005)(36756003)(6486002)(66556008)(66476007)(66946007)(2906002)(83380400001)(5660300002)(316002)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a8XxETnP7w+jv4aLCeDv4RHyUROId+K6PZAsp2uwjb5KwAenwJVctCfoUUxW?=
 =?us-ascii?Q?USdgK9cN+alazF4zsF3ucLIrBELeqxsspoKF7aN2YxNjGsW+cbqP95+KFoWX?=
 =?us-ascii?Q?U7O00LUpHqHEXPWtR9w6lMb/IZerOkxmwBl+eSJLLN5uss6O6AOpS412ZPfZ?=
 =?us-ascii?Q?FF3A+kHOVRt4BPhdcW4oD2lzrucV94NLFGoVMdh/6MLA2bD7eCsW/kLdifda?=
 =?us-ascii?Q?3zkcJZUeJq15sqaB9Lkxhn0E45oc3M9v1TvKC3C1aoItfO2Vqd9yXu0kUxd4?=
 =?us-ascii?Q?w+NiWQWEtAzhFYMSm5/lav09ftPywA3p8/RuG7sJWH1peAPoO5vdVI4mnH0v?=
 =?us-ascii?Q?Kk1HblgBn8ThMZHBQ3cQi7smO2tZ1ZsHlfijaOoqJs2FFV7kwDAKINoBUJvR?=
 =?us-ascii?Q?z86qpd9OB8lMMkgIKIB3IycQ5rw9sN301UdsvbpVPZaj9Gh754R1LXW2dghg?=
 =?us-ascii?Q?o5t2/8boZoW3nAY83eRmg39nSZtbuZ5zPm501YY+WFiyvtpe/LvJruS3jvhy?=
 =?us-ascii?Q?Ff3ptRIeRB74Gvdp2bPIxgKwVo17QmWG9HTnsqaKkk7V0WkCk0Qf7YioL3/M?=
 =?us-ascii?Q?bk+aaMwnpI5cgLgpUIIZhlPUtlJCeiPUvemM+C6BOladdmkoSuD090BEMNtc?=
 =?us-ascii?Q?OqkMxoNy/88ywjkk7GcUzvqcR6uwR67l8kkHjUA9xrSU9giNga9f+QVVqYEw?=
 =?us-ascii?Q?MobLMlsKMNQ4/KNC1Kqw/4EBGlTBwNNIIZm71Aj0kiEn3Mx8zWMus/1drtC9?=
 =?us-ascii?Q?Nsr68viGFnWqbroLO+L07ZPmcG33YfUn3DgQK9PpVz4Lohg1yh9iDB7Qp3iJ?=
 =?us-ascii?Q?CdOUWsFRpx+4uRYLHOuIvgebSYqkqnHV9SGaquZEsfHhi7c1RKZaIc89X2Tw?=
 =?us-ascii?Q?QC1hBzBIQSqpjYajZ15VGBRhDto2ZwtMpGGherBMkUUO07dmnVLwir0t0u2d?=
 =?us-ascii?Q?FfULderuG+sIWtCqSBZ21+26FIrDe2qmGOmi2JFwiZxwKlixgPPdrP4VAxHT?=
 =?us-ascii?Q?R9MLjyBZjGakLs7BTaDlOZGJdz7UxkYQddGOFBUHM8xGEOjUU2ZRNKTwTPiQ?=
 =?us-ascii?Q?GTqOeFV55o5zTQsMQjlADlhDU92afT37Lm3Y9puwVmspMeXeyT7qSe42GuYU?=
 =?us-ascii?Q?+w7J56cNbjnnCLT0PceBjDqL3VdUGYz1BnmKbWkHg6g1jGj5jIgFmIAFjWn1?=
 =?us-ascii?Q?PL61SzqKEiMSOs9zQhC50cB7ZumGOddvmbTChW7cs8X+ptyN4pUUBX8j2OSg?=
 =?us-ascii?Q?E/KJD1Q8Sn7BIKG/O6pye9aQ0AwN4bv0G2Env0mixTxyP2f+WkQzc3L0bIvz?=
 =?us-ascii?Q?rn2cDzilXpfGaI4t9MO/uYSO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92a93633-9c86-4543-cdab-08d93b281f5c
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 18:02:56.2135 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xy0BqnUvcY8MQ+mByu632NguV5stk2Uane8N97scH3HF99blkKRLPdN7gQcsU+pGF4w2+IIHHYFA3+QrkmkQYw==
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

Migration skipped for pages that are already in VRAM
domain. These could be the result of previous partial
migrations to SYS RAM, and prefetch back to VRAM.
Ex. Coherent pages in VRAM that were not written/invalidated after
a copy-on-write.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 7b31c8596786..ae360d94c06f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -329,15 +329,13 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 	for (i = j = 0; i < npages; i++) {
 		struct page *spage;
 
-		dst[i] = vram_addr + (j << PAGE_SHIFT);
-		migrate->dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
-		svm_migrate_get_vram_page(prange, migrate->dst[i]);
-
-		migrate->dst[i] = migrate_pfn(migrate->dst[i]);
-		migrate->dst[i] |= MIGRATE_PFN_LOCKED;
-
-		if (migrate->src[i] & MIGRATE_PFN_VALID) {
-			spage = migrate_pfn_to_page(migrate->src[i]);
+		spage = migrate_pfn_to_page(migrate->src[i]);
+		if (spage && !is_zone_device_page(spage)) {
+			dst[i] = vram_addr + (j << PAGE_SHIFT);
+			migrate->dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
+			svm_migrate_get_vram_page(prange, migrate->dst[i]);
+			migrate->dst[i] = migrate_pfn(migrate->dst[i]);
+			migrate->dst[i] |= MIGRATE_PFN_LOCKED;
 			src[i] = dma_map_page(dev, spage, 0, PAGE_SIZE,
 					      DMA_TO_DEVICE);
 			r = dma_mapping_error(dev, src[i]);
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
