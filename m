Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD07C48BC2
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 16:04:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88C7360FEA
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 16:04:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88C7360FEA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B39C6E1F5;
	Mon, 21 Jun 2021 16:04:41 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2047.outbound.protection.outlook.com [40.107.100.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54C8C6E1D2
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 16:04:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dzj9Cw/zigQ4l06mrFcia0rjqAvHkZVoaxeuyMMeQGr8OG39SHRVvvsZXz34Rc8uuRFhBeJyObahJDCHgjE4QLzv4GhdNV4ABAvyJCLRM14W0qef283NqAlePy2orP1nZmXmOkGOttKmE3GPUpvsVpCkL2xCLcTTFY58eAq0BCJ82VFoxfAQBO/WNhS442X0o8NhOJDzzsfagJSoQwPORZEz6YCfg2HbTHEd54JtbhMJWygxPhHtES7xAY2/Ir9xGV6Av8/xYXatSznaVaLRrzA6fEw7TcXO2xrlzAIwgyX0zn4O7N4byozZaZSuX6MkBPgZIzUBDFH1YDRQRcNsGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=01CuqscK8kt5o0rN/KAJCapDEbSxJcSlWDJ6T+SWJFI=;
 b=CF3pK7l02/dkehT8I3SI/F7uJfiTzHRCrNRFGaH+fUrtJxAa2uhynEvYVQ0+6z2Xc/1RWBNlLdYDbNPUT21id8yId+uEoXv6CJ4pP904x2RBTER7cpeF6zBRkQdLD6ZuBQrpBunpukQjnvaHreHAB9jOCT9RXk4pewYEB6/aNc8h6hK8t6DvvELS1tFYqQe/iiznDuMl0Xtd9Gk2UKgnhNbxf+LyjL10QoBfE55uKUKLKR+3elX9yKy5AxBBVUMFcQ0bLez7fFHUg96g5vVYlp2Z13DevXxg+IK0t50rS6Gk3LQVtzl8Ta94MtFqvSGi+/G+AdEz2UEcFAf9vYu9dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=01CuqscK8kt5o0rN/KAJCapDEbSxJcSlWDJ6T+SWJFI=;
 b=WIK/9OMg6dJ/rHbN2w3nMaPwp3Rn59Up2HNAttk8HDyaWpWFfr0wbt4GeL4kB7oJ9GRaeDDST0imTrqXgKiCUn+qUFmno/BZmDUSSQa3cne3NfXvRbR5nAJifrYiReGnYEreSu4t2LZoGUwhdy8Mc5Ptl8JEdZOF/Sv+BR8Dwnk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20)
 by SA0PR12MB4365.namprd12.prod.outlook.com (2603:10b6:806:96::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Mon, 21 Jun
 2021 16:04:38 +0000
Received: from SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::5ce6:fed4:e00f:27e4]) by SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::5ce6:fed4:e00f:27e4%6]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 16:04:38 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 03/10] drm/amdkfd: set owner ref to svm range prefault
Date: Mon, 21 Jun 2021 11:04:16 -0500
Message-Id: <20210621160423.3517-3-alex.sierra@amd.com>
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
 15.20.4264.7 via Frontend Transport; Mon, 21 Jun 2021 16:04:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19c9b7b9-e16b-4da0-87fe-08d934ce4565
X-MS-TrafficTypeDiagnostic: SA0PR12MB4365:
X-Microsoft-Antispam-PRVS: <SA0PR12MB4365D0A2692CF7F1BB2AFCE2FD0A9@SA0PR12MB4365.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GsdaNecKENX/1EsHyUYcE51t2hMJXbu83YKtFvxpJvnCygDpOfO3kTBk+o/vod9zDmTMacOEk2aQgre57BSvmm3CI48tVX0lER7fAY7zMsfG+2UtopBmcNMZpEe/sIRc/1ELGlVgNu85sVsonRpr7D09+pm6sO1TUWl3+lrZCIvb7/e0+En40vrtKLP4Mp1EfVuxrwuGA7aR47MKceAY83ssfLsqMguZ0k0o8wR/N6CaHIsPmGgekcjN/jGQva8JiSWMM76qwTZlduuZb82cMKc/Dg5/Nun/nMOXxttbVUsVRlChTEi4asNBKJAzvdTICStoqLRQLPyeznlZnBRYdSrnfoJdzvsaPrM1tp+6h50Ax0gtFd+QLHzF4+UPo/XNRGDEZeuqBOVrcme6cdbozYKE7Rsw+mE03yvWcinlulN0SY10Zt4NYpT4ihMADYhUFJfE2A0pGCj16WorjIHxb1GIk3p4COXADXuzSXu0YqYA0wj7T1Bc6zVA7gk+ncrHUNG6Zf6TL+joqqAcqqf+KNrRLtBEdJqRMK0Nm+pU119tQFQQPoKOVPXYuuKBXTs5LNyaBC8qKhD611jTDRKHUG26MDD37HY7HJBU41iKMvwRkXCIKA51UrzZzNB8fpHbnnaNeVyQHbLvlMIU2sHCet7espLE6GeLBXlmRsF5Kgw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4430.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(376002)(346002)(366004)(136003)(8936002)(7696005)(52116002)(16526019)(8676002)(26005)(186003)(83380400001)(2906002)(316002)(6916009)(956004)(44832011)(66556008)(6666004)(6486002)(1076003)(86362001)(66946007)(478600001)(38100700002)(5660300002)(36756003)(38350700002)(2616005)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6iJz4TwbD5pBBqOOgBXBRbNEku/mQB6yNZ8WsoYI0cSkLSkxTyi4yzYwWirN?=
 =?us-ascii?Q?Ry7HJSVv6B3gaz0oPXe7U7Xaf3eBLtA8DWllCqJbjZ7LajZRKFhGrvAuQZfl?=
 =?us-ascii?Q?gJn2hSVIYILvsbPmi6j1fUit8SAVJ/0YtPfQbuCctXnrJ6DvgwlDxutpCcYL?=
 =?us-ascii?Q?t6q1wd+sK/gbAPfG3p0lP2QYVfxd13ayVD95uJbOnzjCLS+pskkUZYEifyOJ?=
 =?us-ascii?Q?W/4ZoNJXtReZgz6sosNkL3W39YgpJDHeercFMVqjcj+iesl1zjAlSN7v3FZ9?=
 =?us-ascii?Q?YQixTi1phAg1CttOyQSWfgeTAKabP4P6/tssA33XId6QY11wqG+FoXdyvHnR?=
 =?us-ascii?Q?dAxg1Nu4dH+ixwg5X3sfmhFZv/4iY6eTr2c5urRgV9N5VsC3KCryafOyUOu3?=
 =?us-ascii?Q?be2n1iCxfYI301qeT4QtG6fXkyVy7wWSRLbZibgGx/DVqyhJV0ITBT5FiOov?=
 =?us-ascii?Q?DPP3jpm272ywqrUoyLMNjWqWoyf8YDdvJvgrcuYd/QtpNZZM4A+ufPka0NiN?=
 =?us-ascii?Q?9JKAPMO8CmBAUO0Um4tdYnqhaqteoCSjCUSjir9UdaBFgHXs5/se512I57++?=
 =?us-ascii?Q?9qPIHvpjZTnfgWifljeL4K6ifYRfmRc4socOBCWnXIuuAYZaf6k5rOoQvzH9?=
 =?us-ascii?Q?iNHWYWCiBzKKIiiilB13YShq8qDb5omYFe3TYUYNDA6udnIdW225JHaY07Y1?=
 =?us-ascii?Q?NyzABnNkZ0AmggoWGGGx64j2glsUbv97XEL/rcxt3ni3+oTPV40Fp3gEi8aU?=
 =?us-ascii?Q?iJM4DocoE3/uxY0q3hjQ2+nnafdMW8oIS4ZOh1wefLzvi1SNhB+/f3yBIdlS?=
 =?us-ascii?Q?A041Ws+sEJ/0MYZnyxJtpTF1ubW8mbIBEGb1vyKSpSJTZSuJ6RQAPXDVbvXa?=
 =?us-ascii?Q?+THNwGr6XB1QajNhCDZo/rWB/Q3Sp7U6SkKqH7PzVq92kLyV//f0fxVnLnCp?=
 =?us-ascii?Q?iZE5BcKh9AFx1a/OiN6siCyqOFO6GnNBuZY85ByGx9yyzPMU7F5P/hJ7lGDz?=
 =?us-ascii?Q?l+bw6SJsO5TA9ScGUffbjZkMC9phDYL9zPeGWRmaUBfv5BCH9CGGiGr4znTY?=
 =?us-ascii?Q?j3TaPqTD8IZVA2l2QMN6vz1SQySRKBViSzBXNBincFxaFptiAUQqGDGhPVNo?=
 =?us-ascii?Q?SxBZFb2tzi+X2epGB3brrCkEv9qzs69v7L2C1deucPFqvG4Kf+sTK/6qO4TB?=
 =?us-ascii?Q?290ClqsaWqOQBgEQiIyk+SY4FTxpV8muA6Az8bp/W10auSafEveLaRXIMLSy?=
 =?us-ascii?Q?Crm7O86a3rEubgVs/SuSm+JTAERWhkk+lqvmotPnE6FHZRqOlbEFd0vVx66d?=
 =?us-ascii?Q?93sJalOdK7fqc6BCSrm0AMTs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19c9b7b9-e16b-4da0-87fe-08d934ce4565
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 16:04:38.3099 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gMfDAnl4eT38zpTngCy0HcUSE7nirzZZGJ3h1JfnWbIRg1U1ihad0W6lDIJep1+TXZjSI8MwDrZnaJpxh0cKPw==
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

svm_range_prefault is called right before migrations to VRAM,
to make sure pages are resident in system memory before the migration.
With partial migrations, this reference is used by hmm range get pages
to avoid migrating pages that are already in the same VRAM domain.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 5 +++--
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h     | 3 ++-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 11f7f590c6ec..b298aa8dea4d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -512,7 +512,7 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
 		 prange->start, prange->last, best_loc);
 
 	/* FIXME: workaround for page locking bug with invalid pages */
-	svm_range_prefault(prange, mm);
+	svm_range_prefault(prange, mm, SVM_ADEV_PGMAP_OWNER(adev));
 
 	start = prange->start << PAGE_SHIFT;
 	end = (prange->last + 1) << PAGE_SHIFT;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index b939f353ac8c..54f47b09b14a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2646,7 +2646,8 @@ svm_range_best_prefetch_location(struct svm_range *prange)
 /* FIXME: This is a workaround for page locking bug when some pages are
  * invalid during migration to VRAM
  */
-void svm_range_prefault(struct svm_range *prange, struct mm_struct *mm)
+void svm_range_prefault(struct svm_range *prange, struct mm_struct *mm,
+			void *owner)
 {
 	struct hmm_range *hmm_range;
 	int r;
@@ -2657,7 +2658,7 @@ void svm_range_prefault(struct svm_range *prange, struct mm_struct *mm)
 	r = amdgpu_hmm_range_get_pages(&prange->notifier, mm, NULL,
 				       prange->start << PAGE_SHIFT,
 				       prange->npages, &hmm_range,
-				       false, true, NULL);
+				       false, true, owner);
 	if (!r) {
 		amdgpu_hmm_range_get_pages_done(hmm_range);
 		prange->validated_once = true;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index 4297250f259d..08542fe39303 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -176,7 +176,8 @@ void schedule_deferred_list_work(struct svm_range_list *svms);
 void svm_range_dma_unmap(struct device *dev, dma_addr_t *dma_addr,
 			 unsigned long offset, unsigned long npages);
 void svm_range_free_dma_mappings(struct svm_range *prange);
-void svm_range_prefault(struct svm_range *prange, struct mm_struct *mm);
+void svm_range_prefault(struct svm_range *prange, struct mm_struct *mm,
+			void *owner);
 
 #else
 
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
