Return-Path: <SRS0=w1A1=LX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B321FC11F68
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 18:03:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 749746192F
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 18:03:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 749746192F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E9106E8DE;
	Tue, 29 Jun 2021 18:03:02 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C6426E8D5
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jun 2021 18:02:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DbvIYFm8QWHDBdBS43yij5KTgJj0qWFjaL69Zh/3ARu0EdEchJs/2qAA+MevM9NjhwHJ0Q+OvrT0X6s0Uz6MOMLA86EcTo9KxnW1mb6hDV+CdHSkZ373RL43lipxMkeQ4xgdas3L3VdgI7rKtxD00jQnK3Fy9kEdn6ywK+ArlkY308HHy6buGCrHUAAckdOoa7B3k+ELTlWaO//AE2ZS5P3kghegG+rXOpKGgtEak4DcizRZoGPMffOipa7jzPE8fKdlngJxf+AMakZ3VRk5qLBugJuOHzcxynMTfb4f6KRtMEHmAFCWIjqJqYUr81EqwqZc3/mS7OT6TAf66u3Gkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JAL9G1C1tzfkmjULgcxwiN+XSqpG22FEAyvt1tfq45k=;
 b=Zea42P6H/DejCgSjEZcjBrd3Vi+aq5jCmHRisPGv8Do3+JcCI7qMxVzuS4GCnnm8xvA9+GaQxNOGXOC/M1zGoeAgFukRo8Tl3M13dj9WWE9clTE9+r1uKvRqFwIXGLTClBXPHKB/E1qtuj+rXBB2ULChVt7KPzVrbBhWTVOXE/Skb/CgU9l+++w6iR1bDW2rczo6mQkkoAw7G3KzWHiJ4PBH0MDmfV9QgBSqXc+eqv5kGocxQhkajkgfBDDrQBQyDUtNJeM52XGyiu4Xq1XFZFkjCp+H5mitZfQRzxfDJE9k4iDkfXHTRF23PnuFH0HyKXAG5qW6UokFX5PIOUkyvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JAL9G1C1tzfkmjULgcxwiN+XSqpG22FEAyvt1tfq45k=;
 b=NsJlmuG8HlrxdGG9o7R5bAGrCs0usLUDvJl7v+jBQ8WHkAy3wscWRqAzUS40HHBviBcp33bHhpzCxU7Qj5T4CXHuCP9JCWiWwu21AGnWOzzwTX07aQ6v7PMNxUa20T+co+JsmqKvcHEfiEHTdttg0crCW3EuU1o19wuSJZb7uQ0=
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
Subject: [PATCH 03/11] drm/amdkfd: set owner ref to svm range prefault
Date: Tue, 29 Jun 2021 13:01:58 -0500
Message-Id: <20210629180206.8002-3-alex.sierra@amd.com>
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
 15.20.4264.18 via Frontend Transport; Tue, 29 Jun 2021 18:02:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c4bcdf10-7fd2-4aa8-4995-08d93b281db8
X-MS-TrafficTypeDiagnostic: SN1PR12MB2542:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB254260CD74952BF01500B687FD029@SN1PR12MB2542.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7CnkIDs1sOaJuZch1nMRfCjB1JeBJ1TyjKRAFFW1mhJrg+zDNoALLIk8mzRzuc21tlICqiryzwNzRAvxjJ/CMcmyZ4tEW5J17qqKPTYeuknwhNw1MgR9HvyCUNVlhVyPwaxJx0RrYzkSSQQTkFt7lHSs2oKxmHZk1YlERVCep3KJdi6v5xXIVvjJK/Fw0w0SGk7Vp/G0jWX50eSXcEbhKr6mmIjFBDHIRAwAtLqHwhjCt0dRN9gAykiRdF13DyWe7QO5e/05eb6RF+LUxMmiMjQ1SLs4SYjwBeCMNVe5hmo6p4VG7/+0FUtNaILK0USohY3SaB1k93+ziikDwbBVJAEAQuVZ8SuXTOyEgoMckAp88Fr5KFoEK62pUqF+u4DABVelw8ndlARy6/L5wnXvV+FUZ1EXA2MHCiKm+iCKTbkupcm5k8RPCNSkDEuqTZElQEjuqGufvMe8H6/J/jCieSAc/pEtRPF/EFVKO4phZEwLQ4dfbX75MYNclO6QZttibL4Erm8rJtctFa28twfjEojn/a19ZSuNOrSHQeEL5ilRRWylKvhX38QSlPBgoZTY+BHGN+VD+/Rx+KLAPI8AJ8ErF/B7GI39N6NBbB7kflSRphDFS8odo7MmRSaPJvsVAxD1f2p+CSm6OwfbjlI4cN+S/Vd0RxVnjucj2TB+WH7b0tiT++25coEDukcoWlH79YdPqqNNL5qA7REslMDRXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4430.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(346002)(396003)(376002)(136003)(38100700002)(2616005)(86362001)(52116002)(186003)(4326008)(44832011)(6916009)(7696005)(54906003)(956004)(8936002)(16526019)(8676002)(38350700002)(1076003)(26005)(36756003)(6486002)(66556008)(66476007)(66946007)(2906002)(83380400001)(5660300002)(316002)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zUCYnM+qDmiNqDqaDL9K26e5a3/MY+vZ0u5Mg9F4HGOVDqK4FpwzmiSuwhTj?=
 =?us-ascii?Q?MzTpyK2IRu0NDJZ1okLn42bw/QJI361VCRGJCoVuoCIScKvBk48U6rUUVr1I?=
 =?us-ascii?Q?+5eDi1Au9udVSuXMdCCYRn5Tfkk+u52wzws4XA7zLswHPo7YBL0y9gf4oDZr?=
 =?us-ascii?Q?sfeGFQhCTaHfQwKWLuQWnwPl5qql1Np0NwFWxKjD6pbTlUBuVes/n8UkjbSy?=
 =?us-ascii?Q?gNZ+2cH0dGYyjrnvdhBPcUPGOeA6ChS4Jqz+N5ABnb6JtPBUAutnD7Qrbn8V?=
 =?us-ascii?Q?3CmI8fL2Q3xI+4Z5r7zIJCnJuEE314PYnWPanbtZHHiqX07Wo5EysRa5VDId?=
 =?us-ascii?Q?T7aGfodb3ZXybMvPYms++FTliSfxkd4I7BCh/n2uLCMXTHVe9BtXhPiUghBf?=
 =?us-ascii?Q?zrqtBUMMFK72ynJ7WM6Gviv+B1jgJKMFHnjLMxFhrgLgpnBglDGbOY7rmGr2?=
 =?us-ascii?Q?6+VcJUdhXmOM4qBgpY2KLYVp+TMnnzy8glg3mik6n/DcejHGWTxbw689/GLM?=
 =?us-ascii?Q?kGyYCu5a9rp+Umn05TPzIbWvJFNm0Q+dWER43Hm1J4FEnATWcoEtvMussHE4?=
 =?us-ascii?Q?7OHVZdejt/2tcXj+PFSiDiW2u4zj5NUgpEwVJu0eI+zVychMhKQq6rWpjkJ6?=
 =?us-ascii?Q?CC/l7bn8BH4AVR6516WyrSxZaeMbd7OODGW+P8zZlu95iyasKYi5MyNa/Ym7?=
 =?us-ascii?Q?HY/hBIWc5e1mfGwkxm6EzUn5RxFiuVEVEs0zy/iraavtFYVIGkiYMTfkbRjR?=
 =?us-ascii?Q?vry+XdlSEYXyWFlFSqtJgux9ayBUfx5LsX//WC8HGmkfhscG8Wm6rIsK5AKI?=
 =?us-ascii?Q?Gi6syD0+GjuDNJ1tQ9KiOfheJmQ25Mpnatm6BZqwNuZYqIpYEcdG5QZMuyxS?=
 =?us-ascii?Q?6mAMcjKR35XKk+duxtdjx7D2Antovs+gL0GDGuNj8ZCMDmaiybIcDKlti9M6?=
 =?us-ascii?Q?4+ubnM8ETIOIlJe3YiF9AyhNG36kXerDxzUGxfaJOA8eJRIskDAZqk7t+8Up?=
 =?us-ascii?Q?tQlvgXHo2TAmG035iJ66MqnUIAnHsP7eU3NUXK0H5ajeclTFyk6inWxrmkhb?=
 =?us-ascii?Q?8yEgnivkAzChiKVxWUt1+BCj/cXwQhrP8K7zKxgvC91mAqNZWKniiUmmCf9e?=
 =?us-ascii?Q?7uKe+qzAcgpMX/RAGD70MxnCbm7fxjDhf3Vw83O5hzKy1tNPW5Bnj8FEDtJ2?=
 =?us-ascii?Q?1nvggcIBIsZjRMCBDvPAiI50g7wIpZTDY5a+FdUdI09iNYkT6IvpVB/rrQva?=
 =?us-ascii?Q?ul1SfAUDtom2avufAwOJfy9sBjQE1V2+acRqoWpYh2P4RDnA5rMMz3fJn+Tu?=
 =?us-ascii?Q?T0WBgNdcit3xzg/prxYGbzvE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4bcdf10-7fd2-4aa8-4995-08d93b281db8
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 18:02:53.4287 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8e6PW8a2trQKh+/RQWCad9Y/YOaApwA1aRtXa1lL4tmEQIDtTl1InyeZnoo1KywRaAkU4+sUFUUerVcNhWVkMA==
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

svm_range_prefault is called right before migrations to VRAM,
to make sure pages are resident in system memory before the migration.
With partial migrations, this reference is used by hmm range get pages
to avoid migrating pages that are already in the same VRAM domain.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 5 +++--
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h     | 3 ++-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 8ce71c8142aa..33d4a118d05f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -519,7 +519,7 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
 		 prange->start, prange->last, best_loc);
 
 	/* FIXME: workaround for page locking bug with invalid pages */
-	svm_range_prefault(prange, mm);
+	svm_range_prefault(prange, mm, SVM_ADEV_PGMAP_OWNER(adev));
 
 	start = prange->start << PAGE_SHIFT;
 	end = (prange->last + 1) << PAGE_SHIFT;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 125099a91e18..61db2a4db917 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2705,7 +2705,8 @@ svm_range_best_prefetch_location(struct svm_range *prange)
 /* FIXME: This is a workaround for page locking bug when some pages are
  * invalid during migration to VRAM
  */
-void svm_range_prefault(struct svm_range *prange, struct mm_struct *mm)
+void svm_range_prefault(struct svm_range *prange, struct mm_struct *mm,
+			void *owner)
 {
 	struct hmm_range *hmm_range;
 	int r;
@@ -2716,7 +2717,7 @@ void svm_range_prefault(struct svm_range *prange, struct mm_struct *mm)
 	r = amdgpu_hmm_range_get_pages(&prange->notifier, mm, NULL,
 				       prange->start << PAGE_SHIFT,
 				       prange->npages, &hmm_range,
-				       false, true, NULL);
+				       false, true, owner);
 	if (!r) {
 		amdgpu_hmm_range_get_pages_done(hmm_range);
 		prange->validated_once = true;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index 1f88bdfdbcc2..9a7744a12dab 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -176,7 +176,8 @@ void schedule_deferred_list_work(struct svm_range_list *svms);
 void svm_range_dma_unmap(struct device *dev, dma_addr_t *dma_addr,
 			 unsigned long offset, unsigned long npages);
 void svm_range_free_dma_mappings(struct svm_range *prange);
-void svm_range_prefault(struct svm_range *prange, struct mm_struct *mm);
+void svm_range_prefault(struct svm_range *prange, struct mm_struct *mm,
+			void *owner);
 struct kfd_process_device *
 svm_range_get_pdd_by_adev(struct svm_range *prange, struct amdgpu_device *adev);
 
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
