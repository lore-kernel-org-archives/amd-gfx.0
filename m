Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A884C47088
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 10:10:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D245D61355
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 10:10:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D245D61355
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90ED96E1DE;
	Wed, 26 May 2021 10:10:53 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2073.outbound.protection.outlook.com [40.107.101.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E99D6E0ED
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 10:10:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e7zsxDNR+l+nqBG3WI3FFOd2bfsOPmbsr3+QhMumM02/Q4j9AQLt98wgYqMyF6IhxmRrOZg8Ef4BQWP6srOR88F2olIpg7yl6ewgGcM2i1WVCRzFRr+19U5eUFAsXVdbnQcMyTOLW1J26hVAGIhWqD7JTmW12Z/PBWr2Y66YrgGKJDj+2VHHEFIj6WVjhO5HsPDFrLejruWIRbUfiWr6sgQJURZXaY+zOXJp2nT6IqfTWavlw6cgFXlbEOj/GNmJWuXs4bWDHZXvMa58j4sssqglO45Nij6NV94P3RczJG3v3o+0FeJ2hyg7ywPUOqUGzzWqpzdpkDOiyNoBxHXuyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5NRDcwDLTbxLrhi0bVetJGhm9kj5/B1y3gsYJ7Vpkwo=;
 b=CnaAvDbHbWiL9I+jIcKduTeTHiDdahTKGudtfotGuLuEDjXFaarMZLm0V4WR8oRKeh/XGZrcIEWmjMT9tmrheY8t+AbHR+doj3mQzOgZCpQlLlk+aiJzAr0vvJl2yBWQ2/aLPBsl8JoMDvh1/gZT+llF8UnbC9rVkOTEA7Li0XpgC7zZPcVb1PvnZ02cnA6V7kDG2W9wLmA/lMg4c3Uxsm1CJXPLs1+osrRY+2hTwmkYMOJqYrdR3bjj8L2jOFjbrgGDcUIfdhVD2QiEUDhw/4bVqW4uHrtiIDx7QoWwhRZJuaKiiicFqTjM7SpwBJQFw5OgQzNzV93JkldsS4GaUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5NRDcwDLTbxLrhi0bVetJGhm9kj5/B1y3gsYJ7Vpkwo=;
 b=o+P+M0qt/wfQ22bqz5X5Rk0Mn6NQkhP94VDPy3URGGGc7wFyRHv6DrBHKUxZJcUtYIVMIxE49aQ5kZsbguYCFYqWP8eAVMqxrZ88YqO92zWMpO1A8habAkhMIUnwaaxqp3OM4AIyfNiJ2Rl8g4Nqi6St98YY6VmAAqrkpTlYgzI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5232.namprd12.prod.outlook.com (2603:10b6:5:39c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Wed, 26 May
 2021 10:10:51 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa%6]) with mapi id 15.20.4150.027; Wed, 26 May 2021
 10:10:51 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/7] drm/amdgpu: use amdgpu_bo_vm for vm code
Date: Wed, 26 May 2021 12:10:23 +0200
Message-Id: <20210526101027.14936-3-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526101027.14936-1-nirmoy.das@amd.com>
References: <20210526101027.14936-1-nirmoy.das@amd.com>
X-Originating-IP: [217.86.98.218]
X-ClientProxiedBy: AM0PR03CA0049.eurprd03.prod.outlook.com (2603:10a6:208::26)
 To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.98.218) by
 AM0PR03CA0049.eurprd03.prod.outlook.com (2603:10a6:208::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.20 via Frontend Transport; Wed, 26 May 2021 10:10:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06f1f61e-f0a1-4d1e-693f-08d9202e8a79
X-MS-TrafficTypeDiagnostic: DM4PR12MB5232:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5232C74C96AEC8E8BA8D89A88B249@DM4PR12MB5232.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0t1aKpEbt4WbLhxazsFxFEHVUqsEvJQWda5x+MxTDB8nf4+2lwKqhg8ZK0ERokC3ff/cn1k92W/yiOB8fnTvjyfYmiZUKC171V+nzBz73otg9NQ+f3BHNFIvE5GjKNwEZBTbfRdXxTO1Vfk/Pdh0hXvk3aHvdGBuwlYfhtXpq0MeKYDX7Wkazgidlj7EhM2qu4jvPbLMBkzGpU9H9z3M6KHwCOGY97f9qY45b2yTL66tC2jQ9WaeCogEoLQdUwdLLwYohJg2jX/anMxbkX1WiVlJd/zZjCTWJRLaj0cJQVOQEV36L8OJmoBFHyKphp6WBiiKgFJhzER3hMmJLElW+tZBHFfwX1cshKOWUvv5bgbNPPal4qS25bxZ8f7yl4TTeto3JhwYsUQaNGQU6q88qU1Qe7bl5OB0rAhu2P9jeDQK7+fXA3LYj4IRHOV/4uBrbwYgLxfceFK5Ke71NyWOk+IRkwLj0ssFyOkfNNxE9ClfseYIfc2DCeRixNzGV6Xi1dRSne1+W6YTGF+iiG6jD3BCUBem7zDsNWxMzJnsqW9LSuEcH3orGvstIptkSk7QaaNkVsaxNPM8y9jgb97s766LJFLjtfqg/DXj8/ydBMamUDCa+cInLriycsCdHeAaTs226QHnAX2S9LYgrGLT/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(366004)(376002)(136003)(5660300002)(66946007)(66556008)(6486002)(66476007)(6666004)(86362001)(2906002)(1076003)(6512007)(83380400001)(16526019)(44832011)(36756003)(186003)(6916009)(26005)(956004)(2616005)(4326008)(478600001)(6506007)(8936002)(38350700002)(316002)(38100700002)(52116002)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?BiEdT3RxEoUfinwnT4BWYc796YhWHd19WXOdICOtpFk7oUE0ukHo6UvNgWA0?=
 =?us-ascii?Q?vXSD2WK14s04cygF8TuUuipW/0alJLPYgJkimZpuV0I95fwyTXz+hXlIpdhP?=
 =?us-ascii?Q?gCwJB4Dm7GLu27vrOnQPB9/uhrbGp2+VZk9SPIe6Om27dJFgtkC2PEHebk/5?=
 =?us-ascii?Q?7+Z8msUZFBXNcPLuKaajAfhW2kc6uNyOmKcPWo51QxDIvm8ivd6ifQb62Vcb?=
 =?us-ascii?Q?iKbgSTbgd/M/CXrNrCTr7SWarulK0eSgxSodtBlWOKsNSYFF97cXRGwIHNbw?=
 =?us-ascii?Q?r2iu/AHdJ+aFXvagcWsIR/nfygMKlyd6Hxc7Q0zgDN8aJNbUNVgcrftHGSPh?=
 =?us-ascii?Q?csOCAK0CJ7lcBmoG32sfKeyLIGJbw1pNlx9GOnEddY79aAVBvUwEBeaceSIz?=
 =?us-ascii?Q?Ju/Y2yqjl9S4skZ6AJNXWBqGMf9F/hv6CxmPSyp0+6ytHAYbUgNl0phNULbf?=
 =?us-ascii?Q?VTMLIQ4NRSktKuDNdQF96tnfUu32NJRzoD++gCRPGTjqFI3jIZsT0hds7+EE?=
 =?us-ascii?Q?ZbG2v5+VvZv2vP0CLJiGvrvXQ+AGuhl4RqaVqFKRTYexrseTfP2PHkDg8fdl?=
 =?us-ascii?Q?c5lPWwR9ADZwBd2JjcgWhGPV9s7mfumIPd2C3GwzmaKB5maAc7Qmru3W0zjV?=
 =?us-ascii?Q?OBtj3dEbR1VuC3Sg+oJgsG/jKYmsNh/2Ph+nsI3M5aybj05UaMw/R3BTfJUD?=
 =?us-ascii?Q?i1LvhybhBJco9phZ7Shfdg9BHVaZf51H/cTHTsV52kxkU3Z51iKX2IRFNzG4?=
 =?us-ascii?Q?tCRc/UJa1WwgWq5UJPAaZM0XQTcK7UivCKDEa5c8f6XMjCxRktNerfaoxemb?=
 =?us-ascii?Q?rfrEVGOeBxmiageSyqp7xzNiHMDbUuPb5E8FJnVbGxFJH/0cyrAth0jUllY5?=
 =?us-ascii?Q?6g3pogg9dNAmGp6gdkk7wdSC/sHMvobRYX/Kh2Te3ES+Z2eXtbVG1cLwnchD?=
 =?us-ascii?Q?DyFawPo+qOI4fv+c4iVXCDAs8qvwgvrD0V3t+syQx2/yZR5S+TxMEsvJqbBj?=
 =?us-ascii?Q?xqGkk9HufVABh+kOQ/9Gm0UauIy/g+ut9hOqVqm2p72DkHp7WDJI9W6o1B+6?=
 =?us-ascii?Q?0S7h2zE0rL1P1dF3ZvC7Kt+at1Vy3HxGQn9cYlacCplfsVQl0cTz7pzNAmTH?=
 =?us-ascii?Q?yTacHdTPA/AP/8YhXxEBclL+eC2G+aMGrZEoblpJCgIZgWzXvelHA/wM8CFZ?=
 =?us-ascii?Q?/g0giDEj+CM3BIeYmWF15sg8x/lQEnHVd1UXIlDwrdYyxLIuZI9yQBVLYTH6?=
 =?us-ascii?Q?5YvWL2WY+XfcfTddZGQjMDdsYCKCImlHSoeomPx077YEiFl4hoKG+RGqjdei?=
 =?us-ascii?Q?4Y+2CCJzRqchfRtd3sHGiuON?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06f1f61e-f0a1-4d1e-693f-08d9202e8a79
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2021 10:10:51.4667 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HIVQOrVlGYslfVIEob3otqU4iiebkeW4aZef5kcPQ7rPGZSPHRnHq+qfGWhzO4/gMCbOO/KiEPlC1szExYiSig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5232
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

Use amdgpu_bo_vm subclass for creating BOs related to PD/PT.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 43 ++++++++++++++------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index f474f15ba344..2c97d67d9cfc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -868,9 +868,10 @@ static int amdgpu_vm_clear_bo(struct amdgpu_device *adev,
 static int amdgpu_vm_pt_create(struct amdgpu_device *adev,
 			       struct amdgpu_vm *vm,
 			       int level, bool immediate,
-			       struct amdgpu_bo **bo)
+			       struct amdgpu_bo_vm **vmbo)
 {
 	struct amdgpu_bo_param bp;
+	struct amdgpu_bo *bo;
 	int r;
 
 	memset(&bp, 0, sizeof(bp));
@@ -881,7 +882,7 @@ static int amdgpu_vm_pt_create(struct amdgpu_device *adev,
 	bp.domain = amdgpu_bo_get_preferred_pin_domain(adev, bp.domain);
 	bp.flags = AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |
 		AMDGPU_GEM_CREATE_CPU_GTT_USWC;
-	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
+	bp.bo_ptr_size = sizeof(struct amdgpu_bo_vm);
 	if (vm->use_cpu_for_update)
 		bp.flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
 
@@ -890,23 +891,24 @@ static int amdgpu_vm_pt_create(struct amdgpu_device *adev,
 	if (vm->root.base.bo)
 		bp.resv = vm->root.base.bo->tbo.base.resv;
 
-	r = amdgpu_bo_create(adev, &bp, bo);
+	r = amdgpu_bo_create_vm(adev, &bp, vmbo);
 	if (r)
 		return r;
 
+	bo = &(*vmbo)->bo;
 	if (vm->is_compute_context && (adev->flags & AMD_IS_APU))
 		return 0;
 
 	if (!bp.resv)
-		WARN_ON(dma_resv_lock((*bo)->tbo.base.resv,
+		WARN_ON(dma_resv_lock(bo->tbo.base.resv,
 				      NULL));
-	r = amdgpu_bo_create_shadow(adev, bp.size, *bo);
+	r = amdgpu_bo_create_shadow(adev, bp.size, bo);
 
 	if (!bp.resv)
-		dma_resv_unlock((*bo)->tbo.base.resv);
+		dma_resv_unlock(bo->tbo.base.resv);
 
 	if (r) {
-		amdgpu_bo_unref(bo);
+		amdgpu_bo_unref(&bo);
 		return r;
 	}
 
@@ -933,7 +935,8 @@ static int amdgpu_vm_alloc_pts(struct amdgpu_device *adev,
 			       bool immediate)
 {
 	struct amdgpu_vm_pt *entry = cursor->entry;
-	struct amdgpu_bo *pt;
+	struct amdgpu_bo *pt_bo;
+	struct amdgpu_bo_vm *pt;
 	int r;
 
 	if (cursor->level < AMDGPU_VM_PTB && !entry->entries) {
@@ -957,18 +960,19 @@ static int amdgpu_vm_alloc_pts(struct amdgpu_device *adev,
 	/* Keep a reference to the root directory to avoid
 	 * freeing them up in the wrong order.
 	 */
-	pt->parent = amdgpu_bo_ref(cursor->parent->base.bo);
-	amdgpu_vm_bo_base_init(&entry->base, vm, pt);
+	pt_bo = &pt->bo;
+	pt_bo->parent = amdgpu_bo_ref(cursor->parent->base.bo);
+	amdgpu_vm_bo_base_init(&entry->base, vm, pt_bo);
 
-	r = amdgpu_vm_clear_bo(adev, vm, pt, immediate);
+	r = amdgpu_vm_clear_bo(adev, vm, pt_bo, immediate);
 	if (r)
 		goto error_free_pt;
 
 	return 0;
 
 error_free_pt:
-	amdgpu_bo_unref(&pt->shadow);
-	amdgpu_bo_unref(&pt);
+	amdgpu_bo_unref(&pt_bo->shadow);
+	amdgpu_bo_unref(&pt_bo);
 	return r;
 }
 
@@ -2843,7 +2847,8 @@ long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout)
  */
 int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, u32 pasid)
 {
-	struct amdgpu_bo *root;
+	struct amdgpu_bo *root_bo;
+	struct amdgpu_bo_vm *root;
 	int r, i;
 
 	vm->va = RB_ROOT_CACHED;
@@ -2897,18 +2902,18 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, u32 pasid)
 				false, &root);
 	if (r)
 		goto error_free_delayed;
-
-	r = amdgpu_bo_reserve(root, true);
+	root_bo = &root->bo;
+	r = amdgpu_bo_reserve(root_bo, true);
 	if (r)
 		goto error_free_root;
 
-	r = dma_resv_reserve_shared(root->tbo.base.resv, 1);
+	r = dma_resv_reserve_shared(root_bo->tbo.base.resv, 1);
 	if (r)
 		goto error_unreserve;
 
-	amdgpu_vm_bo_base_init(&vm->root.base, vm, root);
+	amdgpu_vm_bo_base_init(&vm->root.base, vm, root_bo);
 
-	r = amdgpu_vm_clear_bo(adev, vm, root, false);
+	r = amdgpu_vm_clear_bo(adev, vm, root_bo, false);
 	if (r)
 		goto error_unreserve;
 
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
