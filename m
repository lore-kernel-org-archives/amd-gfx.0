Return-Path: <SRS0=bbC/=KX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E660C4708D
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 10:56:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3518D613B5
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 10:56:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3518D613B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA29A6ECBA;
	Fri, 28 May 2021 10:56:50 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74BE96EE98
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 May 2021 10:56:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ITWyw/tFnfWgB7UTfKngKJ8WDOm8JpOv2bUK4PNyQW6Roax0KXNESFOcyRWqjAUoBQdYqD111sKpTyuNOfqf/rV8P44qnizzEfjSDguxSfaPefEMMXSVISYjKpQNJK2gzDorq428+Lo29R/ZvrKMhl0+r3k1GU19VS9AQ0hQuHULRT2EoqCjPzmycT9sd36PFY6vXNi5C28dwU12qYEwKzyf9JfHh/D31em2w0Vx4203+3nEAF/7CKHdPGfVzzoCMLDA3mKSbJ19eBs6g9ZN5RzIfHY3Z6AjfBmaUrgad8YEVmhk++0M+axmVFiSnRqQJ3EtBwu3UYYgTQ3tXzE8hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5n3W9/co+Pyxfr8XeSBcCsVWdHRTgoZ+gAGShdRdAV8=;
 b=T4sgfV3UZIbRZnHqiVrhzMnYqDnMOOu7eMWR4N1lWCAFKrdMwl6cxwHsbx4qlaCVRtnn3xptZw1p/nRxky1cC116iOm+IJEUDf1vNBFJLbjSOU0qtLk3MWqTKwx6SkKqC986PkT9hbznjCqNxn9nOPJo08QfAwwUPz+khEQrgSqaYomqU2hQ+jnrMawKYIqyiCY+KbnF1urXPZobo2yzKy0w9mIlbp2dlGLdUd6mnyvw5ekm9X5Gz5ERmPO0/kfzLhevBkQbn1868VhNu6/IYsWsadzjYaaxPdxo15wmZKA0SfoTaUO3Ta+sEhEa3n4x9Z4HWUzrWJO0bGz0zCkMMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5n3W9/co+Pyxfr8XeSBcCsVWdHRTgoZ+gAGShdRdAV8=;
 b=VUZjnj05y74pY6TiM4fIh3zkIuI3edYYlYBtWNwsy2OA8a+ODVzLGih45vBS73BrG/MMysKvr4jlYyRZzOpQy1E8gi0JW+k7+biSbIvs1QJ0bJsqWiOt9TXuf1K9a2sD65ol/1DIILwDOLOg0UT/h6dhreHWIC64oKokKTcuY0I=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM8PR12MB5416.namprd12.prod.outlook.com (2603:10b6:8:28::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Fri, 28 May
 2021 10:56:45 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa%6]) with mapi id 15.20.4173.022; Fri, 28 May 2021
 10:56:45 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 6/6] drm/amdgpu: do not allocate entries separately
Date: Fri, 28 May 2021 12:56:23 +0200
Message-Id: <20210528105623.28148-6-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210528105623.28148-1-nirmoy.das@amd.com>
References: <20210528105623.28148-1-nirmoy.das@amd.com>
X-Originating-IP: [217.86.100.114]
X-ClientProxiedBy: PR3P189CA0081.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:b4::26) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.100.114) by
 PR3P189CA0081.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:b4::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.20 via Frontend Transport; Fri, 28 May 2021 10:56:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75eca678-e3d9-49b4-5cd3-08d921c748bc
X-MS-TrafficTypeDiagnostic: DM8PR12MB5416:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM8PR12MB54168FED997E6B8E97C5CCCF8B229@DM8PR12MB5416.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DSGqj9rfRsVBPWmY3eVNnu5ttIhA/VzolO95OU1hAMnAspZ95XNjrPdMEGYfzEfpg0RPfTS2kqZu9DYtAkl72hDguk+qN5BDpHGZFaHo2qnADLAcHkUPdIGWiQUWU5cnhN9rZM7+OeWwZ1Htjzwc3jEuLP9juGf1PNdnNkWhRXViH66UNKFy1JgKccDoanut4PBGbwcvnPcQgfOzmMXMoK0py59gRlhrYGKsETGipiWXMbv3pQtt7wE2ybBtWwLcMbdmt5ul0r4cpqhkTCzY7joV6+0aMKtc8nea4ermV6IK3UyiMiLnnRfjii72jNOTMlg2/0XiQEKLtnOrQdfPB5xD/C6R5OXxZCLsgb1F3x7pLQ9sUzSgiH68Hx7H+6tFpEElPoBdXDIorEF1xFZXpOIYuKb7J1BrLE2zFN4jFU/NoxjmLINpTEu9YFRisMeuyMG1kaG8jUxsvgqSMJ3d1JduoTLiqE9S+ygbJZYIcgEywPVoSS2q79+5r/65Rmd7ssh8DSp5fmpawozs5kdrXt7fJeXl6nApPZ10A5L1kIOSqELzDh3ZZCGpCzM1/tISWAusUSEo52ItxLQJVmUiFounbSIICdT3KlakdBL1msvBL5ycYKowDS5UMg+G6gIESHFyBLJ0i7+byARd+W0VObtHYrQ01wmv6vZS0xHXdrM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39850400004)(366004)(346002)(136003)(376002)(6486002)(2906002)(6512007)(38350700002)(38100700002)(6916009)(36756003)(44832011)(16526019)(5660300002)(66476007)(186003)(66556008)(66946007)(86362001)(956004)(2616005)(26005)(8936002)(83380400001)(6506007)(478600001)(52116002)(1076003)(8676002)(6666004)(316002)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?KWD3WY3HURBT7VbeQvl7wjASC+i4s8XPoUvoiVrYZMmrNlQOcSZi9sGTnwae?=
 =?us-ascii?Q?QrHPu0rHSnO7LY7W0KF/I0DRZtn84XWZa4qAotU7hgL9idIDK70Zqa3L7UNT?=
 =?us-ascii?Q?qNUlKPzchHQ61B8gH+7N1TEzG8SgsB1TTC+PF6IVsHF103Ew/xt0VenT4F4c?=
 =?us-ascii?Q?c1Wv4z4nwsQ/8gMWLeNcAK+x/glBPngSXfo+bF+cASr4qoCFaecQuXhgHqSM?=
 =?us-ascii?Q?gg2S09gD/vN57jub1odg37hj6CnSgLafg2YPN3kFO5mL+Oysajq8/+npBKwe?=
 =?us-ascii?Q?l+cGEdza5875sprFEW2OCEScijENugXLTRkk0alrqxSKKRe57l30eKXxRBye?=
 =?us-ascii?Q?+iLy3QqK/iuOiEWgO0U3gu4P8AZ4inD9MBaIXYIN89jfM+zqVfzbotSd/XRT?=
 =?us-ascii?Q?5UF6e3OPcw9RCrwBa1yTWfv+8F2asnBruRYFoqOolYG40Xfz9igMWtbXVoNI?=
 =?us-ascii?Q?FN887AtkTHCjfMrVGyQPTx4ZoH1fcGAfhAb5M/io6EGLvw5CHME79E8GxCcL?=
 =?us-ascii?Q?vE4Iu+h1QrOzm8Ut5F8FTsvpXcgJQg9WIhipTwuSJdDUEGiqO+HY0cBJsLPu?=
 =?us-ascii?Q?tU6KhduRyzfzBGGzKt4jq39PSV/IDJPLCP1L9A91bd/NRqFqIRmTK7e0XtBe?=
 =?us-ascii?Q?S3JlapGh8x5NUmYCS/KexSPFguAeJhbfpLAdO+WIGEu+vb6rrZNykRwjT3A6?=
 =?us-ascii?Q?9ZhepTmxmpNPArI6XOIlbNMGQMYyRHPxCc3DGDBJdv5BIqGH3/BRTdwPkKID?=
 =?us-ascii?Q?Zn8PEm4AVplcqbgxppyyGe09HJ3Y+AGh6KAMlh3GFStfsZjihTQFDC0+A3NN?=
 =?us-ascii?Q?kpQpUPdDT/0y0zNG6Uv1iO/eLZZAAUKJQJTGT4mDDWJHeamihurXOR6qLGQv?=
 =?us-ascii?Q?VLr34zD81NSuKJtVrQ79aA2SLgA4MsKooCOczoEu88tpIxqGApGAz2H2BN2t?=
 =?us-ascii?Q?r0TOk2Cvj6oFwEzUvUkMTYfxhNPoRt2RW0OE+c4ZpsqUHZp7aAmcFxqdHfqL?=
 =?us-ascii?Q?5VwYkbk1tVhq6zjWQUWNmgUv95Z/zQeV7mRklMwPSUcldyy7TeiMmkSP4L8j?=
 =?us-ascii?Q?Vg/CMNBxlqPJcdRcYmePiGy7No0zMMEa7oK9SU+gTsiKBRQ2YnVVdNpYcwUI?=
 =?us-ascii?Q?YSuJGne6FiwEjJcVTU2K+o0WvxtRycVGIiAv74r2q5y/K7rjgOV1TstOCd0F?=
 =?us-ascii?Q?sBjqTApn9n5KC/dN+3gUL5zNFN+b1csqO/bVdFrdv3wE+5wOfzP+fUNeRESw?=
 =?us-ascii?Q?5328BR7oujaJ3LHWttFgbymRlIY6GHW5m+WIaxwAfx9MInniAS3Nhj2aM5W1?=
 =?us-ascii?Q?lVKX9di6Vjb1JYqRjiSfSSAT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75eca678-e3d9-49b4-5cd3-08d921c748bc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 10:56:45.3353 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NBPkAEVsFoFxH31kfnwibq9KzD2HWVOe/6HZ7DsLOx5LWF37Y1Xa+j0n4yP/V0xP0BZRhiDMfxmRwLrXVHHJ3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5416
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

Allocate PD/PT entries while allocating VM BOs and use that
instead of allocating those entries separately.

v2: create a new var for num entries.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 34 +++++++++++++++-----------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 223c63342ecd..7e478ffb7fdf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -877,6 +877,7 @@ static int amdgpu_vm_pt_create(struct amdgpu_device *adev,
 	struct amdgpu_bo *bo;
 	struct dma_resv *resv;
 	int r;
+	unsigned int num_entries;

 	memset(&bp, 0, sizeof(bp));

@@ -886,7 +887,14 @@ static int amdgpu_vm_pt_create(struct amdgpu_device *adev,
 	bp.domain = amdgpu_bo_get_preferred_pin_domain(adev, bp.domain);
 	bp.flags = AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |
 		AMDGPU_GEM_CREATE_CPU_GTT_USWC;
-	bp.bo_ptr_size = sizeof(struct amdgpu_bo_vm);
+
+	if (level < AMDGPU_VM_PTB)
+		num_entries = amdgpu_vm_num_entries(adev, level);
+	else
+		num_entries = 0;
+
+	bp.bo_ptr_size = struct_size((*vmbo), entries, num_entries);
+
 	if (vm->use_cpu_for_update)
 		bp.flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;

@@ -957,19 +965,14 @@ static int amdgpu_vm_alloc_pts(struct amdgpu_device *adev,
 	struct amdgpu_bo_vm *pt;
 	int r;

-	if (cursor->level < AMDGPU_VM_PTB && !entry->entries) {
-		unsigned num_entries;
-
-		num_entries = amdgpu_vm_num_entries(adev, cursor->level);
-		entry->entries = kvmalloc_array(num_entries,
-						sizeof(*entry->entries),
-						GFP_KERNEL | __GFP_ZERO);
-		if (!entry->entries)
-			return -ENOMEM;
-	}
-
-	if (entry->base.bo)
+	if (entry->base.bo) {
+		if (cursor->level < AMDGPU_VM_PTB)
+			entry->entries =
+				to_amdgpu_bo_vm(entry->base.bo)->entries;
+		else
+			entry->entries = NULL;
 		return 0;
+	}

 	r = amdgpu_vm_pt_create(adev, vm, cursor->level, immediate, &pt);
 	if (r)
@@ -981,6 +984,10 @@ static int amdgpu_vm_alloc_pts(struct amdgpu_device *adev,
 	pt_bo = &pt->bo;
 	pt_bo->parent = amdgpu_bo_ref(cursor->parent->base.bo);
 	amdgpu_vm_bo_base_init(&entry->base, vm, pt_bo);
+	if (cursor->level < AMDGPU_VM_PTB)
+		entry->entries = pt->entries;
+	else
+		entry->entries = NULL;

 	r = amdgpu_vm_clear_bo(adev, vm, pt, immediate);
 	if (r)
@@ -1010,7 +1017,6 @@ static void amdgpu_vm_free_table(struct amdgpu_vm_pt *entry)
 		amdgpu_bo_unref(&shadow);
 		amdgpu_bo_unref(&entry->base.bo);
 	}
-	kvfree(entry->entries);
 	entry->entries = NULL;
 }

--
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
