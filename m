Return-Path: <SRS0=0i2d=KW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B959DC47089
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 11:54:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E79C6103E
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 11:54:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E79C6103E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39CA36EE8F;
	Thu, 27 May 2021 11:54:09 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7CCE6EE8F
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 May 2021 11:54:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wonzge298VbGHL8m+fEcT4PijHpLg2/COX0Hftj43M+LRLmDgOlviIHaHsY0v5luW+TH8b8QS2EFh2Ssc51pgFfO93C4le6Mac1MfXUDWql5KIOk/dojqQrEIwgZJTcNpxeIjP0YbjpVbvTIzXmqSfjpj+LNae5ioQynEaDw1TUkmsUBqRPNL1aKeoYQb8P2hdNDH7RUZpVKQZ1f2wY2Lqkq+6Og3/5Hx1uowYK5SX9VthIt6MWr8ztjKzLXPznl6PtuO1GzVl1KJreb0ULetuZmRVzmxhtcy41F1lFoM/MeQIcLV4RGHvYSN7Ups3kJcWydh39Y9ncbEqL7ZpCLtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dH3lYnvgdjE3jK5DjcYmEGZkobwpkrfPuYZOuheT6hQ=;
 b=URdWIqQ32b0GQ1MA3x0l1V7BW/pi0PsxnDK4emOPowDlPVlCYMfNeLB/vqhVAWMQuQ0i8jS1v1C9Rc/NwYXO6XSYUtKzXQIz9cvDPvR+Yf513SslIpe9eJeZyWek7yU/vZ1WbN/gpp366FJPzX9oNyFjPIcU9hJeZlY7JEnTWC14jv4h2Ybd/eI+k+D0/UMm9a/VUjqY0PeMlUhU8S/q7wFbSHNRo/Zg75qbeSGA1y3oN9qjAW2sQ9xWkm5t3CT2w/IMGrOLkw/DmAtP9T6jfPgKtwatmM05pM30ezK6pCDBekFe1bQywKXbtHf33jZG8dEl1dLtVTyT07xQPpaZ5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dH3lYnvgdjE3jK5DjcYmEGZkobwpkrfPuYZOuheT6hQ=;
 b=Z9QnsdBiFPiwXibvjJNzpGGhVJEh2lXw9KFCIvAHJp1SRoJs/3cRNbZMxzi2qCKlvJSBCB3Q2ALS0GTGZGisihVFnfF0cIPRTSnjf/wQaiFh1kAQRMlVtSheEuin8okg4iXW+cAwbOf8avot/q2/GmfCgi3TX09vV/efhltpOCg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM6PR12MB5536.namprd12.prod.outlook.com (2603:10b6:5:1ba::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Thu, 27 May
 2021 11:54:05 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa%6]) with mapi id 15.20.4173.022; Thu, 27 May 2021
 11:54:05 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 6/6] drm/amdgpu: do not allocate entries separately
Date: Thu, 27 May 2021 13:53:43 +0200
Message-Id: <20210527115343.20133-6-nirmoy.das@amd.com>
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
 15.20.4173.20 via Frontend Transport; Thu, 27 May 2021 11:54:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2f1a1a1-f018-4495-6575-08d9210620eb
X-MS-TrafficTypeDiagnostic: DM6PR12MB5536:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB55367AB84F1567AC9660EBB98B239@DM6PR12MB5536.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jdHEPUdShg0xRBecZYHd63fxu2H70jttDntXJbcIQVNasUwL5r3sj3TGKcJbFZDV4XeGiOcWqzdxCxcQ3+6nEfqux71dYtfCti5Qhed7fNCJVdtBWqAcVEnF4VwEkX06a7Ohe+dh1tX3F5RTYrVEVuDr24be4p7Q4f4SMVWbC0iSrxt4cj7vLv8zPwZVGLf2cYmr4XeB/GGX7Vqd/etPG+VPJGZK8Bf3Mc9el804S3+B39np4agJwVckRbSCdGqMSu4zhQev0rujijvtft16v3B5QRf2UTItoNq4bdr9E26jUdFN6XC+H8yPD07MJWHldqTOjxkxzlEUlT2r5hJLikk+QBsvzvjKkc+SaJdrOIe26LJ0UYhc2musG44l8BqdVTF0jM5v8NzebWFo2WTx0/rE03FiYUq3EXZflBr62QsPMWVx29JS4ZScz/BUM0eubekZ7MPumXDaswDFdypAyvovcc1v7+VtB2Nrelol3XcLiZcQty74p+wVu6UEQWFOgCXUkG00R3LRoPXvsa2DPlyei5L+nUkerDT3cPJRUNt6hTf8PktsEWy42GvoyzvdDwAXhZ1+Gy8Ib8gXGTGJoeHayIYloz2g+wCv+9/6u89R31fcuCNJF2sKit4cPVwgLYzNhECGnA6v0BAdtua+aUOMZikfGD4KB/WuJyfwbRk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(376002)(39860400002)(346002)(136003)(478600001)(4326008)(6486002)(8936002)(2616005)(38350700002)(6666004)(38100700002)(16526019)(956004)(316002)(186003)(6512007)(44832011)(5660300002)(86362001)(83380400001)(2906002)(8676002)(66476007)(66556008)(6916009)(1076003)(66946007)(26005)(52116002)(6506007)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?lDoj++wU7MjYHDC0C5lBHaVKj80XX4BjSAddcAMUyOEzhNX/y//90yLTRZz7?=
 =?us-ascii?Q?qZs8DG/OIjuQhPxp5eivbK+NuCfRzLAIk18f/chpLRmciHRVwXGv21ghULTe?=
 =?us-ascii?Q?iUf5XGdv76omZDkT06qOraI+GrnQwUZ2lPV2RW0s1bit5D+RLyF2QQJ/bEWL?=
 =?us-ascii?Q?jkcpxyVSfKupNEmCLUTc0w9fCS5ePcJXGEBiMFumoudg1g0WmymXvriqt7yO?=
 =?us-ascii?Q?E7dOSaEAQSyEMv4nHg47YItWLFcppVWU+v9e3zFjnOrXt8tVF+837u9rNiYV?=
 =?us-ascii?Q?fnuCpCDtYoVQ182eH9j97OhfZOj49LaSPg2IPls2Mx5PNJx6ZCIAWOoQNd3F?=
 =?us-ascii?Q?+KplKkrQTWQOxGvQq5wvBSLGLR69f/g5pgBm9iS3qRT0jYK8AL0vUfYRvnZA?=
 =?us-ascii?Q?LTHSKpIN7Me5WdV7R38UUSZtvit8GtHFgARVH4WkU/mN7rcWQmReKiR7D6jV?=
 =?us-ascii?Q?211jL46a+bWy+5GklP24kAgYZJo2Y20Me69GGqp3SFU9U2YB/njU/CpTY4WY?=
 =?us-ascii?Q?I4re3Rnhtex63uEhHl5+RrI11QsVVv8nk6UKi7fSliQ0eUXsPc7FkQWhqs/+?=
 =?us-ascii?Q?4cXn0zHoIv9sEE7/Q4FJNeUPVYmg0erjYhBJE/t8tohikZbcp/Lvy/Udx95B?=
 =?us-ascii?Q?RaQ0Fx+3n9khux1f2HE7pM5f+izbauDgOlX8SS+/BzvncQCinUGOltBX7NCW?=
 =?us-ascii?Q?bQgmOzlAbjdBJJ9OC8rQhaz1GheMulErCZmFMMbjx7050+NZcGiCXDcvXs1k?=
 =?us-ascii?Q?3eXyDdDBLZGxKRXD06iB+8z5PJXNO1NA9Tt/Yx4siC9n+h6+1Ix4vJOnqlbx?=
 =?us-ascii?Q?YNtiFGsTuiYZMhyy/YiWHOyDZi1zLplVMxGJNrU0n3KaKoq/lx/nee9k69yS?=
 =?us-ascii?Q?E64CRVD5RW2nGMPjT5+6rBROjsIcCcJsnz6xMuPbyfzd/+8yN45PI1SYkX72?=
 =?us-ascii?Q?AnQYxklNn0N7lyy5TV7wdR2bnqP+XKrz1vBP5dcT7H9TYWCwusW1AxKXnkM6?=
 =?us-ascii?Q?zV1n0pda2vmvqgIxjcZ+7PsiR3EVsEyB4/7LIvSEHaXoha8MqicZPN3VwuQN?=
 =?us-ascii?Q?f+UeG49/0hdNsNA6yNBIuVUHcJ9ILlotO4tKvKG3Gyolvcj8ksb5lzC3/jMe?=
 =?us-ascii?Q?sIwFfWz3zGBw+erblzOjrm9/7XIfspoIegV64De4rAJ861Ny0kgqb0rD1Bag?=
 =?us-ascii?Q?8Y/9DS915ypToP0nqTtfBqbKIu5a33iuXy4K3QSLS9n5Yk3k1a+ck22ZRRY/?=
 =?us-ascii?Q?aI6h5gxgcFc+csh7NBKSuNjxFijGCluGbdy3qSD48a39u+KdOSeoNm+BcVvl?=
 =?us-ascii?Q?6XZq7TrfVy92ZML/eo3b446n?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2f1a1a1-f018-4495-6575-08d9210620eb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2021 11:54:05.6170 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GlAX2RNNokLGmvEZakcmbZhk5EGdDO2SjrPUwDtzXhG+Fpj96+CSqCQSfuraVHorjEthi2rcoDihwESqFiyXkQ==
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

Allocate PD/PT entries while allocating VM BOs and use that
instead of allocating those entries separately.

v2: create a new var for num entries.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 34 +++++++++++++++-----------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index d723873df765..70df453863cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -876,6 +876,7 @@ static int amdgpu_vm_pt_create(struct amdgpu_device *adev,
 	struct amdgpu_bo *bo;
 	struct dma_resv *resv;
 	int r;
+	unsigned int num_entries;

 	memset(&bp, 0, sizeof(bp));

@@ -885,7 +886,14 @@ static int amdgpu_vm_pt_create(struct amdgpu_device *adev,
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

@@ -956,19 +964,14 @@ static int amdgpu_vm_alloc_pts(struct amdgpu_device *adev,
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
@@ -980,6 +983,10 @@ static int amdgpu_vm_alloc_pts(struct amdgpu_device *adev,
 	pt_bo = &pt->bo;
 	pt_bo->parent = amdgpu_bo_ref(cursor->parent->base.bo);
 	amdgpu_vm_bo_base_init(&entry->base, vm, pt_bo);
+	if (cursor->level < AMDGPU_VM_PTB)
+		entry->entries = pt->entries;
+	else
+		entry->entries = NULL;

 	r = amdgpu_vm_clear_bo(adev, vm, pt_bo, immediate);
 	if (r)
@@ -1009,7 +1016,6 @@ static void amdgpu_vm_free_table(struct amdgpu_vm_pt *entry)
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
