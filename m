Return-Path: <SRS0=n+xW=KC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B15C5C433ED
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 03:37:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56F92613D9
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 03:37:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56F92613D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5C7D6E0C2;
	Fri,  7 May 2021 03:37:20 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CCA16E02B
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 May 2021 03:37:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mwgwnzq2fCqbT6xealhXKdYLqV3NirpvdpLZ/l7pyjGITL+6uO7Gbsp5djNZiRg9n+ZLjcxXTMepETG2jOzmm2RISmLw447QKWNJpkKtItjGxF0TKN0p2qrckCr/5k7G+EfKA4pLV0ujIR2hZrGjcMT6DT4QE6NJMvb5W3MESlEIuUCn0NuZBRi445T4sc3uThCeooMl+weElosdq/gkL+h4J3bv85VgNsTCWPQbS8pNvg7gZOvhlaoYvDp2MH2tr2RO+xIJxp6bk1tP6FvxGJsezFC26UTf5GHDLbHfc0kH6JQ+xK+wZDTnFHBa81sNjEIzAxZxKB95SNAROZHt7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c028u+bxaA1ieIVIcqeTefxG1QqdKP7KjXzeb9Hw2Ns=;
 b=PxilAgQRrZ05eAQC24LtvboPIQdJL4DKHlbJ6xwv50ei0CyjO97ZdYFYQRVQxl/55X2J1z3doss3X1v6D2+yVH3UxuZrOMW7ev3rhshkuLK+GWh0kI3OhG0kKKOg7V4vzkFRH9/cuh/9qE1xkWl4fLHKEbMeMihgesPa/qBuw83zRMFgEop3Q5U1LUb7T78A1WWqaMg/rs+Naw6oADhE/K5uQeRiXm1IfH17zKvNO8FLrxBeoFT+LqD7mdPNK7OtMRI8KMWJbQmSKrc8WfzHpEGqoiiYNINxSQdJKlyjWXNxDvXRmofXSytLAlR+GDCGkuGXKCmnacfZ9IlZsDNFJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c028u+bxaA1ieIVIcqeTefxG1QqdKP7KjXzeb9Hw2Ns=;
 b=08p2olqANCyZ9Hv6YABHKQGTxeaMfYeiby77tfjKYwrCUrJGftrWM5pZQi8JCZlPlnGc/fBtZFvGvqo0KR4V0xWx2Y7D+aa3HvsGzUfogcMSlKD+T8JC3ll2EA1l6YIqf1QpYFOkjIRKX/HX7qkNR1PVTr1KpjXQnr0kMFJ5RmM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20)
 by SN1PR12MB2365.namprd12.prod.outlook.com (2603:10b6:802:2e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.27; Fri, 7 May
 2021 03:37:17 +0000
Received: from SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::31de:f08e:20b2:d121]) by SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::31de:f08e:20b2:d121%9]) with mapi id 15.20.4108.027; Fri, 7 May 2021
 03:37:17 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/5] drm/amdkfd: set owner ref to svm range prefault
Date: Thu,  6 May 2021 22:36:35 -0500
Message-Id: <20210507033637.29622-3-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210507033637.29622-1-alex.sierra@amd.com>
References: <20210507033637.29622-1-alex.sierra@amd.com>
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SA0PR13CA0018.namprd13.prod.outlook.com
 (2603:10b6:806:130::23) To SA0PR12MB4430.namprd12.prod.outlook.com
 (2603:10b6:806:70::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alex-MS-7B09.amd.com (165.204.78.1) by
 SA0PR13CA0018.namprd13.prod.outlook.com (2603:10b6:806:130::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.11 via Frontend
 Transport; Fri, 7 May 2021 03:37:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71327007-091d-4150-e518-08d9110969b8
X-MS-TrafficTypeDiagnostic: SN1PR12MB2365:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2365C693905ADD5F54EACECDFD579@SN1PR12MB2365.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hx9FukFFh2S0k3uq8ao55UBaA0X+O/13YCqi76uf+CkaXzdzUaNVcf4FOWkExY+T5GoAkA3PJN6xe2a/GFXUCibGgsickeA5IHzxhJuh3r8JwnEO8xL/N/x/zJs/aVBEpGHaNh7D/VFOcj4BpyWGyMK/t2lquFTt1MAxOBSN176XoF3RUIBIH9s4iU11v40EptVV/qD1TooLGNWY5k+DGHodVtIFoRQUfcAOCpg1SvPcaesn8xs7tkJs2di/F2sT0/bl1TWnBJDavDCZKxMUoascAZgS/q0Lq9mQlx+fMht7WXfLUp+1k8gwV5uQfX7AsGbAywOB2I/sPSaYAtM6juVmKe1g+o6xkHXKnYYKZfheN28AFYCzqO/BZh2Z5NVvioec/gxL0rPIu5zyPhjXwCOM2lWzb5q3X+5RV+xAZdSwXU+VuBsh5yluNaJCHhACBYCqnPzB6JVXKrQa+AEJp6GU6osuHbIvu3MPV0Tp+BYA6BoXtJEjkziwPxT0Wqzpwim0YxKvN92RdpaKVzdwEHNs+aMXmXd5nQ6MUamld4CRIZ6ddnXJ738+0nKC1WZB43UKqGEdbpjAEmWIUdioy6MmaJYb/ZQeSM1VVUSP7Y3g641rR3mg+9kYD1+DGyrk81Pl3nVFokzJIEkLJ9g94Voazt99RpueR3ghzZICmfI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4430.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(39860400002)(396003)(346002)(136003)(8676002)(26005)(8936002)(66556008)(4326008)(52116002)(2616005)(66946007)(16526019)(186003)(7696005)(38350700002)(478600001)(66476007)(38100700002)(6486002)(44832011)(956004)(36756003)(86362001)(316002)(6666004)(6916009)(2906002)(83380400001)(1076003)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?aqdgvL47ZxlRGG+CcvLi71qYaEXfzBYV29Hif/ua6ojIdYGSOrb1r0fq2atf?=
 =?us-ascii?Q?gYcMfq9ndIciCc5kUxFA4Qi6Iw6xfXjX3tE9wcpwR3oO0M8p/pKt3gRmc8NE?=
 =?us-ascii?Q?udA9sYTpELuxhLQtv4qEJXKGsdYgxSA+pYcE+sSndwIAiHd6k/s6vGK/gw7e?=
 =?us-ascii?Q?vbmFRM4i0tWEt24tO9YFj4/L2oUDlfWxbOZuNIbPhY95auQBTDNCL3jnD26U?=
 =?us-ascii?Q?UzaPrrYU/WIEfC39msd3lGOSTihjZBqfK/XNSbhlOjRoTVkMWUZXP4zSSF/4?=
 =?us-ascii?Q?lnDoqNetpaHtSjvMzcD4m3UovxTbtPgogJcCDRETlNkWicy0cr0eI6YMc010?=
 =?us-ascii?Q?ABqQkKtze0ns9VMUWcvqZqC+z3J5SFI+avYncr9OyqK+ZwX3nrSQ+z7x558s?=
 =?us-ascii?Q?k27z/WqrHdbmDzXOYcE071jfVGvp0qvgAhdMoZPJeoEmqeSS7wPtOnU5B1JR?=
 =?us-ascii?Q?zF98O9iSMOV1Q9xGycN+qNdZdtSTtZm/KufzjqSSzLCmvXZgBtPWAGXZd/5r?=
 =?us-ascii?Q?0MHobZ42VOLluBuay1Sne1swjtoE0MA3iQmxl5x2b6Tm93xayHv8r46sglJ4?=
 =?us-ascii?Q?JkpF+FJR5XbVa6qyLOGqhahNY+JQ6EJg9AYQxA6/Vdqm4fqqw6TyX1wo5ISN?=
 =?us-ascii?Q?RGvrVb7WQkU4Ibjczd0KLO+o3i0X79WjufxJxg4RFb47cKscWEJ3/8IhepFw?=
 =?us-ascii?Q?kvnzIYLSklhVXmZoseoOjSmyzHNDWVWdIefkoLpmjVKgghOMSoabKCKgu9VT?=
 =?us-ascii?Q?7D9zUGjfqLm/MwBtDBHmQLXSwGmQjRA6dR7dXI06JDPOjXLH04hypbKdaeiS?=
 =?us-ascii?Q?6aaonc3q9CFYqt7g+TvUXkX9oiG8In3eG1hBIqhk18FBjxRuB1Ou7R6OH5i8?=
 =?us-ascii?Q?nfkISxmB1P/hTr9NfuP01mXXZrAoTfJaqX3Pk3WLC4PnGvUD8rGMLireZf4A?=
 =?us-ascii?Q?AgzhVAnQwcdGhSAv1UWo1GKHLv80dsqJZ9CyEJRu1BjIYXkTaNRTulDNMoj7?=
 =?us-ascii?Q?O63jYezWRjxhmJgX8LbbhmLCHyrFcU9x0awdjHphtVMMo0Q+tVcCLV6e1jA+?=
 =?us-ascii?Q?oUiBdBedcRXAq44sgkDqpJKeQGfTICnv7CC6tkKgYao/lHxllfsk5GtX8gZ9?=
 =?us-ascii?Q?dfUwBXRWSXCG3JSzzMAHQ7MUij8clBirWUaXeo20nQaJMR1W6+3cf08Jk34C?=
 =?us-ascii?Q?RM2/oejDTX34n2aM6xNX9E4mF8PkADdbAutjaMlIudPOz17ydyhofZ9R5jne?=
 =?us-ascii?Q?H9jnf9PC670Uy2W8srzVqJ9t7Ft6R3rA2Njrnc0lKltlQtrr/twaB3GlppA5?=
 =?us-ascii?Q?XG0MG3UiJ+2j3D0V4mO97TPH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71327007-091d-4150-e518-08d9110969b8
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2021 03:37:17.7242 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1jvzxZ9+qD9RGrUmcFhfPAigwA2CCcP4jqBH15p7LQh+Pic48s1NmhgAeW/AttGyMTbEgJe68GPgddzTIwWNrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2365
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
index 02340f36bd3d..231ba60f130f 100644
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
index 540496d27c07..f8537940ab22 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2642,7 +2642,8 @@ svm_range_best_prefetch_location(struct svm_range *prange)
 /* FIXME: This is a workaround for page locking bug when some pages are
  * invalid during migration to VRAM
  */
-void svm_range_prefault(struct svm_range *prange, struct mm_struct *mm)
+void svm_range_prefault(struct svm_range *prange, struct mm_struct *mm,
+			void *owner)
 {
 	struct hmm_range *hmm_range;
 	int r;
@@ -2653,7 +2654,7 @@ void svm_range_prefault(struct svm_range *prange, struct mm_struct *mm)
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
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
