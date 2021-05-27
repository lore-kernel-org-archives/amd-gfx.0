Return-Path: <SRS0=0i2d=KW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E02C4708B
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 11:54:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 578A56103E
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 11:54:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 578A56103E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 158546EE93;
	Thu, 27 May 2021 11:54:10 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B29EF6EE8F
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 May 2021 11:54:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dgd4/gTOlZFdkTj7inelXy9V/FF2cln6s/mqVPHrrCojln7t/GGWwtwaTGAstrFdFP+pEYl3tUO5RTqkKu0/9REvP4xsTiVVe3GSKcyT6iDMpkut2lI3CMp4V6eT62KejVQmCbeksK3epKfDqXnhKEiFcPNdeHsucrbxmfGQKdCJwg81u91F5Ks5ZFV2XflQ05tlb6Pa3pxVeh0MRRC/BeumvpQh89GN4hog0V8LeD2qRkhlc9Hszjj2cQdjRUonBIepqZYLrWcAvOiEKPRJYQxGTC9zaSOkUsaY1v6IxeHOqcM0uwd+36tvC30GTjcsQiuwLqv6a6ouGNYUMdb7wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cvwh0PD9s0hp0YrQ6g+C0dnz+U4gRtbyDBocwDHJSjA=;
 b=V7/GT7aHfBl5L2wkp6sJHBP9nI+Nt8a1UyFpxv6PDSbbixoPG7O/Kl2+Gv+v0p98Mqk54kVHgjFtyBFE+/JR1UinGe5VKBPhDZPOMaHozSNPF3L9sWkraigrSUuIVZcF8Xn1c3X1xgJDTC4o5s4tsaxwl3rm2LbGJnAmvhM7GrQHj1pN6/qOM1miAJ7jqXY83aWqo7XHftNexZAxLoXsyQguLvRCsc3rJ7G6s7FV3E7QILBTPB7Za60HsNiqMNlz7yIEz/5TT/XtzDEY/75en48KwRuUYyn+HR4Y1rupXydYvL18/rC0ZaATGvfk9KvphNXUASZDbLMFtChDjfGbZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cvwh0PD9s0hp0YrQ6g+C0dnz+U4gRtbyDBocwDHJSjA=;
 b=iJGS5ygjKHz2mGpxhWRoiixN5e2F6liAFQgJPgU4HzQ3w69joMd8VCVThv1nTBGQZNPdJilAwYAJuWMcLEQog2Tc6EjMOFUPuolai3TPBdN9KLmtWDTp1G4j3ydHq03Z+iPGX71utkSTkXSUG/op8KMwD0BX54fEEEXdY8QoQyY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM6PR12MB5536.namprd12.prod.outlook.com (2603:10b6:5:1ba::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Thu, 27 May
 2021 11:54:04 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa%6]) with mapi id 15.20.4173.022; Thu, 27 May 2021
 11:54:04 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 5/6] drm/amdgpu: remove unused code
Date: Thu, 27 May 2021 13:53:42 +0200
Message-Id: <20210527115343.20133-5-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210527115343.20133-1-nirmoy.das@amd.com>
References: <20210527115343.20133-1-nirmoy.das@amd.com>
X-Originating-IP: [217.86.111.109]
X-ClientProxiedBy: AM3PR05CA0123.eurprd05.prod.outlook.com
 (2603:10a6:207:2::25) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.111.109) by
 AM3PR05CA0123.eurprd05.prod.outlook.com (2603:10a6:207:2::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.20 via Frontend Transport; Thu, 27 May 2021 11:54:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07c86eb7-669f-4551-b39b-08d921062041
X-MS-TrafficTypeDiagnostic: DM6PR12MB5536:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB55365B87E93464BA8174C63E8B239@DM6PR12MB5536.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O3DiAEz9h1vb9rZM+vQKBIFZcWhwf2m/FULv559kFDj5RTNrPUKytVYNuMcHKn0KokefZeNqFGy4rg911SMt9onEC8nDcLyVlCKDvflBrdLGN1tHn53SqEFFcIBxnidWdB0VvvbeT57qh5LIXmAkwzZ7Q2jJBbdc4X6VxC7upkYV/LPW8es2fNusZSJ0+N+BpgwzcV6bW/pa6FQw0T5Qzka2DSWGKqCpDi1KPlMm1c1fgm0bazEblN2fJ/wXlZ0spixIgdEDYD2JufeEwyWeOqEa5kDMplNncqHSQHWTXBadDSFBGChEhb/MRoLQmc2kt1+UfRBZ2c1b1YBFYzf/bTuA5+YfRY6RBu/mZSmqg89DwXRFbrA3JOBtKqjk7Z6Moh4C2aNY+pdt2YsSDdx7B05WXhba/tv8v+oAE9sfgXf8EbC4aqX/n7t2bshe+9QzgTwu6QawtLrwWi4lRccWw0oGkfSuaGr0Q5zg4UmDMpJsV1L97rDfkahDRerGzPhxLnAPlhSziFAD+pzDd9wFVxUK778w4M6f8fCOemRXn780xl8sJv2th7yx5xMwOiy3w42NJqvgHpOKZoQcAoeLzSjSWLoBeZyK4KG7qeAwf3zwkL2zxm84XIfEfMT/HCppmtTG0msu/GTVwzANObGT32vK1oEZT7G43KVFzfxsdbU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(376002)(39860400002)(346002)(136003)(478600001)(4326008)(6486002)(8936002)(2616005)(38350700002)(6666004)(38100700002)(16526019)(956004)(316002)(186003)(6512007)(44832011)(5660300002)(86362001)(83380400001)(2906002)(8676002)(66476007)(66556008)(6916009)(1076003)(66946007)(26005)(52116002)(6506007)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?vdJXZ/a+YphcHitxwOIIPB6ck2KcVFpbCQ0IGNnXXsvJqCllVSBhvWzVwqqz?=
 =?us-ascii?Q?gTdhQZWDoL514wMqanmMIDZUqcJZ0IztZt5+1IHmOudAKjmSAbPTqT7bZwm/?=
 =?us-ascii?Q?ILw2odOS5DEOWjkJhRem2KdgGt/Wba0Kv7uC6fBAo4tocrzcm+tk8cPKZBii?=
 =?us-ascii?Q?dOcSAovUldhMKq4vU3eUhbj2CQv8QXUlbeaOAZnwIdjSJ5JtdXGVWQ5eo9z2?=
 =?us-ascii?Q?N1FrLZKIstY4/F6mqco5P8SWY/Epk8SGuYe0cQEzOUdqMDII06Sy5wers057?=
 =?us-ascii?Q?x6B5skvVXvHHAeFVB/UzZLo/8xgdfHziYi2hjKHd1NTDDL6yHcjaILbYqd8T?=
 =?us-ascii?Q?V6KiPCjSzbCcmgE3diGo+RGuEBneuf4X+COj7qNre5v06U/PyTgPwph6G8wS?=
 =?us-ascii?Q?9eTRre2D7LLFj3UlqIzcADoZbZ3RJRSFkIAG8uCGumGheZKgUQILzdXrw44A?=
 =?us-ascii?Q?ZZEmKJyuLTnlQBZsUmu0ocXDkZWszk3k5KGoocuKeoqBZEwu6PD1Ta/ABeg4?=
 =?us-ascii?Q?Yzx5LzL/6iF8OSyjohwVtBmqsliJIuFYG8yUnW1wG9SSyeb+ZcHqG94KK2fx?=
 =?us-ascii?Q?B8p2ZGPHobHcooX2jrEBf+Ivw6oCrWHMw3FWcdynJaQmcnu/L6INoXN2DPYL?=
 =?us-ascii?Q?AMxxBd1ZM/CNhb1CKvBrZ8J9y/Z6cOo/oYhF2133r/7obD7rJFmOwLeDAX/I?=
 =?us-ascii?Q?25UeI+GIzp1fhdFL026KM9YhBc0CcMFnreiC4aDVj4CLkSUpZ6gtBMzNKk03?=
 =?us-ascii?Q?pAaNEu2va+o6HQ9DsSDAU2G1R1vCR43WKQdrxEiKDpRRo0GEt4GcH2yIaZy3?=
 =?us-ascii?Q?ui+56qS+rwPtNWOpkL85G3HT8VKsOoA6ntQKkw1zelVnTinBledqU+GprTJD?=
 =?us-ascii?Q?NSGIGbhPzsGchD4832mkiK405GYYT7u7E8sIvoVPQWI5d+6yZtMmhxQC4M1/?=
 =?us-ascii?Q?vwqDiTIPC46uEzmt/u3IIpUFnVlLWCOuWQ3mV2IC9+1qVmQCZl/GwaOSTiRA?=
 =?us-ascii?Q?QZK/BXO2pVAwvLbi43l0ThLZHuND7NFszs/RNe3bPEUbndCiVsVh7J1sonNO?=
 =?us-ascii?Q?uezw5+S63rMv4UvDh02nRBHDpYNgs4YK5u/U1GDBD98+ut9ZzS0UZFpfRKpI?=
 =?us-ascii?Q?HYQzOHat7TygSiuDTfQmJUjiSZ/v7mS9mv4BWOljVnZzz1Jjn4XlS86ggBRH?=
 =?us-ascii?Q?f5Dpd0hbwPljZhzXYKdmCrMMl3WlY9Yi7QsXRC6Z3quRzxPixKoMc9Kr4e78?=
 =?us-ascii?Q?ue7wXF1RnxPrfID6htZS3U01oZmurycFAgAjJKIYcKzT1cULvYcMYWIpQ4Dz?=
 =?us-ascii?Q?jwgtAjbVPHMnra9mqLaPU9U/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07c86eb7-669f-4551-b39b-08d921062041
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2021 11:54:04.5219 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zt+PXg+54qjzXoVHo/7h9yyF2DOUja20Qys+ptdHrOtQFbWeLi4NQycEbfDJ5hnfu+K7CxTbx19X2jYTBO0d8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5536
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
Cc: alexander.deucher@amd.com, Nirmoy Das <nirmoy.das@amd.com>,
 Christian.Koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove unused code related to shadow BO.

v2: removing shadow bo ptr from base class.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 29 ----------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  6 -----
 2 files changed, 35 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index a63b450cd603..db9c64836556 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -638,35 +638,6 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
 	return r;
 }

-int amdgpu_bo_create_shadow(struct amdgpu_device *adev,
-			    unsigned long size,
-			    struct amdgpu_bo *bo)
-{
-	struct amdgpu_bo_param bp;
-	int r;
-
-	if (bo->shadow)
-		return 0;
-
-	memset(&bp, 0, sizeof(bp));
-	bp.size = size;
-	bp.domain = AMDGPU_GEM_DOMAIN_GTT;
-	bp.flags = AMDGPU_GEM_CREATE_CPU_GTT_USWC;
-	bp.type = ttm_bo_type_kernel;
-	bp.resv = bo->tbo.base.resv;
-	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
-
-	r = amdgpu_bo_create(adev, &bp, &bo->shadow);
-	if (!r) {
-		bo->shadow->parent = amdgpu_bo_ref(bo);
-		mutex_lock(&adev->shadow_list_lock);
-		list_add_tail(&bo->shadow->shadow_list, &adev->shadow_list);
-		mutex_unlock(&adev->shadow_list_lock);
-	}
-
-	return r;
-}
-
 /**
  * amdgpu_bo_create_user - create an &amdgpu_bo_user buffer object
  * @adev: amdgpu device object
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index 9afccf6c66f2..fa75251148be 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -104,9 +104,6 @@ struct amdgpu_bo {
 	struct amdgpu_vm_bo_base	*vm_bo;
 	/* Constant after initialization */
 	struct amdgpu_bo		*parent;
-	struct amdgpu_bo		*shadow;
-
-

 #ifdef CONFIG_MMU_NOTIFIER
 	struct mmu_interval_notifier	notifier;
@@ -300,9 +297,6 @@ int amdgpu_bo_create_vm(struct amdgpu_device *adev,
 			struct amdgpu_bo_vm **ubo_ptr);
 void amdgpu_bo_free_kernel(struct amdgpu_bo **bo, u64 *gpu_addr,
 			   void **cpu_addr);
-int amdgpu_bo_create_shadow(struct amdgpu_device *adev,
-			    unsigned long size,
-			    struct amdgpu_bo *bo);
 int amdgpu_bo_kmap(struct amdgpu_bo *bo, void **ptr);
 void *amdgpu_bo_kptr(struct amdgpu_bo *bo);
 void amdgpu_bo_kunmap(struct amdgpu_bo *bo);
--
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
