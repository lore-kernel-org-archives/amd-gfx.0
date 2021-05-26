Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA2DC47089
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 13:07:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C537661090
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 13:07:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C537661090
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 776C76E4DD;
	Wed, 26 May 2021 13:07:26 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1801A6E4CB
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 13:07:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bmwCE9AG/X9OhsabTlqwlCoR0B82y9ApHOkcCAhnVTdml0U6qq8dqe4dRqZXtwIk6tQoXRdDA5ZrqbF2+dzrXC4oU+olu4H1uiRLqprO7vgJKoGoEe3AzP0vTK5GIYPhlj9FLMO4Thp3PJ7bvy0CpayVgkZYhaZlyhUnKoShrBr1Nu+Rm1X0yNhet91QhBOMgMaQ/tqxb1FmRKBFOW0G1gBYvYWw8lmoLAUGh/KROy6xkyj8/P0ogbhCyGHQPeoaAuuen1DNYeG+FcZJVi88TAYGHux0sbM38QfJ2XNQ21R1HlCdfO4kNsvXenGjHVswmwhCJbF0uQa7xCFuUsgNqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VjQcefHIK55+PzuIOKO+gWJbm/ZUlzfAMUDAMiNE8iE=;
 b=k291JznBjSm1QenmHiYzv210G8s+5Wd/pfhAr3TuQiJeGMwROkx7e+45mcuRgvj2E0s7TAp+IQ7gNZxdrNzwCzdHP4I5jd2YE9Hzz4vEoB6EochytGMvaOJpR3mHM1mKA/sl9y2LPa0KwXKYSpBTuVlOvavaYDY0+SRh3xS6ivX5BD3vRGNAIWuILGG3LvfzQNKKS5cMtvYKkvz9CF5ulJq4DblSCLs0bVDjMYVb1bRwsF6B/nrisa3QrmAZZcm3jFNfRuzFMdUE6GR6QAIhQ0VSBT9A7P3KDJuhSOP12VM7xVw7BOisQ8PUlxL910o/Ahh+PZFsQ+GrQ5SaD4CMQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VjQcefHIK55+PzuIOKO+gWJbm/ZUlzfAMUDAMiNE8iE=;
 b=us0/Xig8AG/C08c7Aqb9dum4e/8u/R9f3I141vGla2X2AAf682StFlr+iym3nWk2ZSz/VlaEqlqNn+G0f8SdT8ZCmLPn4UEUPhqz9/9wlbDVIJ6/qE0klfPCmY2DGfH29G7HZi4H8mZ6ysdh1kOpkZbj4CiHx29kbPwv9K3Tq/A=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM6PR12MB5568.namprd12.prod.outlook.com (2603:10b6:5:20c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Wed, 26 May
 2021 13:07:22 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa%6]) with mapi id 15.20.4150.027; Wed, 26 May 2021
 13:07:22 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/5] drm/amdgpu: do not allocate entries separately
Date: Wed, 26 May 2021 15:06:58 +0200
Message-Id: <20210526130658.4237-5-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526130658.4237-1-nirmoy.das@amd.com>
References: <20210526130658.4237-1-nirmoy.das@amd.com>
X-Originating-IP: [217.86.98.218]
X-ClientProxiedBy: PR2P264CA0047.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:101:1::35) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.98.218) by
 PR2P264CA0047.FRAP264.PROD.OUTLOOK.COM (2603:10a6:101:1::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.20 via Frontend Transport; Wed, 26 May 2021 13:07:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0226240f-d5d0-492e-ae72-08d9204732f5
X-MS-TrafficTypeDiagnostic: DM6PR12MB5568:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB55681AEF563EC6FC88BEAF638B249@DM6PR12MB5568.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0b2EOym065U+ex+C5OMRCdtMnxZYGr1+h6+CTKeZAb8PMoSEA/UgYUI6W3OSGqA5xehmlOGjbToisoqTg4XROieskNLTxqXWzXST6kqX/BXaaSu51ShAsshoKlpm/OwFyD9yJ/4uJ9gfmEF5FlJhLirJeCIFpmwPAjQ+Bkx4BDHkPw+9cI+CtX+B+RY7+nbYmlLWDtHEj6Hbutnx+Pk6UtdGSoKuWjBIbFogESkMBGNM5/wa+r+Oa1FiRmoprEwPyPIuSV/SbzI6dUDoBWyhP6zhlgfMY1P8j7j6kxk9E26OSYjhHdVpT8FxAMyRNpKYMfYTPMo7Ij+K+5uoH3ikYIo5tNchyArjprqpeOP7QVcYfLoNcw+AhmvZCOaoAbGfsieeUKqcAXJBUYXu6AYZAkGAYyeaCPd72vNmItIa0dr0VDnd2zn5m4lqqbsVuXLW2P4qwhx9V1+g5x/4tt9t6hiEqMyoi1BQz/levwK/M/nVoBTazSYTAUL/vGF3dpKAQex3KkGGTaWx5GMGSCEwit/WKErFt2hXDRbE5Y4+T0V6wlyiihF0FlI9j+dPI65f5TUTiFi2sO6wRAe/EkD1ps/qC+8oxSrWV1SmxKn4uEPrHXhQ+OC5uklS7a6jvzdcm7jJF12E2EScb3bhf/n2RGHrE5YzfQGVC3zyGz5N5x8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(366004)(376002)(346002)(39860400002)(8936002)(86362001)(6486002)(38350700002)(186003)(6666004)(44832011)(83380400001)(478600001)(52116002)(38100700002)(6916009)(66556008)(956004)(2616005)(66476007)(316002)(4326008)(66946007)(16526019)(8676002)(26005)(1076003)(5660300002)(6512007)(36756003)(2906002)(6506007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ghgYr/Es1cLweqIuvze+AqGU415g3G6DgomFVbBJuIh4uJ726tcS5cP590pQ?=
 =?us-ascii?Q?OLirDuJQ/9N1OynLhr9zJLJFyLQxCibGAKHNGLXV32Di/pxhKT9rk5hNyV2A?=
 =?us-ascii?Q?1ZqzxJEQ0pW7n0puErt4sXhmYHuf+9Sije73/m945cUZB9XcC8C+Fjgzba7H?=
 =?us-ascii?Q?6/tLcw6wUBvdcBP0/w09NgiNv0i3/GbPmRgfXus/ZJB6lYFIH6SzuHNrTyXa?=
 =?us-ascii?Q?40vGclxdRG62VrXRGPg4HwIef04AtMSnd4L/BcemTMFu/FBv4jpW/2AoSRt0?=
 =?us-ascii?Q?Edbem3q9uv/818v+FGRTABWDa5YK0PzJMBjLkJin6y3reuWLe5o0dXitXAx3?=
 =?us-ascii?Q?PiUCD9K4Ru4ZhfOELkmyRmSo7EKKJRGQD7SZt73A22ioWRMp2/oeyrTajjs1?=
 =?us-ascii?Q?FI6xoMW3BzcJO3cmEzcjDIpEVJmAryWlk7aRI24LHRoXtu/T6mo9F9rayxDz?=
 =?us-ascii?Q?YQv/P4qDOVTgzLL+b+78qg8HWnqFzV81559qzK+A45AP2uDS0RHsim9DkoM+?=
 =?us-ascii?Q?5K0Ho8vyt5QPIXKvQI13VcEOumEV42+TbFtUBcG7TwcRkBhCXB7591lvknNI?=
 =?us-ascii?Q?us2fwYoyO8j8kqMPT6PCUg4qLXe3JJnNhIb20kswBae8XIMKsrNH1JtZxErx?=
 =?us-ascii?Q?f8uR2lkGcKPX9lA0eIS880fYAlt+GXSehHUV9w13L93PIdkmikSHVm+rwXfr?=
 =?us-ascii?Q?HOkH3+F1ZNt/NQgnQnLG+7Va1X4i7/hk6IkS+SQn8XAj/iig37QrsQ9WLAKw?=
 =?us-ascii?Q?FR0lKDenr6r7cU9yWrWtXjvZt8vlrqb8cCWWes5GJhBXnFlsl6jwoR+vfkMT?=
 =?us-ascii?Q?/fdaSYZNb7PzvUOPeiGnNQp1r8Ev6zNZZOu0Z6D84YJAUxyjcMuqUXOw+jIT?=
 =?us-ascii?Q?mpy18Hxl87eTRCvgwscNq3gS9ELc3XIBOVatYUG6KTkKCjFggYDpnFNglb/B?=
 =?us-ascii?Q?LbJ5WIlC4wOy2toSbp3nD4RCNEe2FACkt20nIG06iwDS7rZ+P/FLBocjx2Gb?=
 =?us-ascii?Q?rwXlrRJy3i1Z5zfyBvbwCTKwNEkfKWfyDh+jB9JT48mugxJrb3xw2XD8kem8?=
 =?us-ascii?Q?Stw/OZ9+DCLEb4LPjGZ8uj44KrRG7Al69fYxKodEhBsYQlTAlrdHaNwhhW/z?=
 =?us-ascii?Q?U9zN6w0pXCAlTvxRs6y7EauLrRd4jsJMG8g7M6hdX4zgV/BKqHHmQGzoN2yO?=
 =?us-ascii?Q?Vb7ytrLK+OEfdFStbOG6LnAVn9jD+i5qzD9vgnCdoWd7nvNUcaVIDGXFoJtb?=
 =?us-ascii?Q?VAfe94UFU/xBKheG5XULwHRkD1ocXxkV4LCHo1itouN7BPpQFVnpo/A7z2CV?=
 =?us-ascii?Q?t/DDkozBFVjI3o0TgHptk0nN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0226240f-d5d0-492e-ae72-08d9204732f5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2021 13:07:22.0479 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nd4U1UPKxh4MurB3zSf3fMDGajseIA9Ws4iiRrAO9DyexI3e8yLoceQ8zhWV1GBgDbXvck0cDtbgqXy0DKHzEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5568
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
index 80d50e6d75f9..de9dd882ecdc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -876,6 +876,7 @@ static int amdgpu_vm_pt_create(struct amdgpu_device *adev,
 	struct amdgpu_bo *shadow_bo;
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
 
@@ -958,19 +966,14 @@ static int amdgpu_vm_alloc_pts(struct amdgpu_device *adev,
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
@@ -982,6 +985,10 @@ static int amdgpu_vm_alloc_pts(struct amdgpu_device *adev,
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
 			amdgpu_bo_unref(&to_amdgpu_bo_vm(entry->base.bo)->shadow);
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
