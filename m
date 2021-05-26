Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48EA4C47088
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 13:07:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBD916113D
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 13:07:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBD916113D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B26C56E4C7;
	Wed, 26 May 2021 13:07:21 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CE1C6E4C7
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 13:07:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WQ2nCfBwt6QaqzKfIYO+c8mkZRtazSQs2Vb3YWJVnWgcS5LWJw1JV+FWCv85T5iFIRtArX5/tXI0qVHGFyGgYHjHTo6n7ATR9THmPgyQZEA6i3iEkhSS5ITtSwV2yAjIBgLMAA8D4hkJj4mCmCyqZj9FUYSX/oEzIspKbqIGN2RFnAi3sWt6lbxge1Vrl1B3N+pgNYhEKnbyOp7DnB66gg2sw7+P9g8PVYSTagJZc36VaDx1DdMFMcQUxqOVZ78KI3PW6pbpFu6l1RQ3Lr6fCBVthIlu05TJy/qVzm7lSrOwpj4blnrV73+fBdZM+QQgkXB8I6zA2psnlQZkN4wSsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTrAPGgvwoGTMpGAmqyy5eJ6wlPzdLvO3I+vyOJr+Tw=;
 b=PAxIvXeNTUcv8nHOPILvsy7kboojnJ4Wc2Wb+wa662xgmOEZLvxvs2BwtiyKbfBdtnl+O84PgJiM3tN0cIOIdw0U/89fYR1xO7Seupej1zvNkSyaLiOYVLk6XI/RzIkVI3CzaQ12Wb4iwBFGdrAyCWjHAQ1tbx/w4/JbKG08nb7I0+m4PXtcnvXN71hsH5/bWTtJg1jtvwM9wIDHL9JK4NJQ4BP2eiQOmKBRNeK4bcI5fezVRb7dRqXGrSdAnidB7Od0t9reryc4rdMcSirxRTq/FQI1UMShR7KGrSUqludhoLRt3krR2Fu+vYKsbLcfS0YffQUtqxJ4Qhf96iy+ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTrAPGgvwoGTMpGAmqyy5eJ6wlPzdLvO3I+vyOJr+Tw=;
 b=Nv4WoUgc91qPaeA8d7gT9LFmifu1aWeglxWEgDWRVp6RJoYtjOP7wyINO+hUTeXQxfRfJMVoGDRHkgpQ6OS914C+XBrC4fxqz/d4vbz2UCXgxcOMaqd6vcpdgtuYruO2yrTwO63EiykMlIlevuTyWH8cEPlE87tEasVu8VHPMOQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5087.namprd12.prod.outlook.com (2603:10b6:5:38a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Wed, 26 May
 2021 13:07:19 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa%6]) with mapi id 15.20.4150.027; Wed, 26 May 2021
 13:07:19 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 3/5] drm/amdgpu: switch to amdgpu_bo_vm for vm code
Date: Wed, 26 May 2021 15:06:56 +0200
Message-Id: <20210526130658.4237-3-nirmoy.das@amd.com>
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
 15.20.4173.20 via Frontend Transport; Wed, 26 May 2021 13:07:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd572882-af62-4f7d-11e3-08d920473165
X-MS-TrafficTypeDiagnostic: DM4PR12MB5087:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5087BB3D99D6E9A3EA3758EB8B249@DM4PR12MB5087.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4eE0bzfDU+XNV0Y8aaIeh5W3LXYVmKVPDdKkqAIVaXp8vj8xNAFa8f/rb1wJLAUF4EdNdInydZ7qb3rHdeTd6Z0HxcltFpEyq8w3VEZFoe4vKD6iQ43Y2+EPySfsF6PRh4MkczAJWCfljOMqlpmDOZNczT4xwYLlClTKvFPYlR41bI0KokyKXqnw2zhFnUOc0P0/5g1sniwsdXMpqYNPnUvErjWtXgd2frLnP+QCz394OQJOikcv90aMUPZbPYig6ixpTVnxASf3T8fR/JRzjAl7dZSZiWlh0tSBpidCjb9AJ55Z6MwzFExAL63tC0T77WU8wjp3voXGScDGG2z3avW1CXJ8DCZy8w5IACMsok4UG08MfYBwhicuhEXv+GJb63t4EZL3yYZg+V1scpCMWLhEQQ8h0Rgu7wKkgKg2l6eJgqQ/0J12p3bqfKd1ouaXsw6C9KlxVXdel6Mowl2X9NYkSDWc8KBHSBPaXiDQid6HVarkvqqvMJVaELxt+XIFA1TW4Lan/1e2JObpeu8W96fQiPVTQjpi90YpVOujjfQ7hjuu+Z2DH1n9MndFARM8TAhLWAzKpFWsEU4ibe7ulC/BfKVvtUEAXTafBmBbG0gfrwfBIlr+sfNbGW9RfLWmWvqBeoklKaaPajN4wLKq0O8OCMGcLUrF2Fyg0Lbj6Ww=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(366004)(136003)(376002)(396003)(8676002)(2616005)(26005)(52116002)(956004)(6916009)(83380400001)(38100700002)(186003)(38350700002)(6506007)(86362001)(2906002)(6512007)(8936002)(6486002)(6666004)(66946007)(5660300002)(66556008)(16526019)(66476007)(4326008)(478600001)(36756003)(1076003)(44832011)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?2fg7WcsekHnY/Ka71rhWywkd6nJted85lUQ55CFDvR6+nJ5Vm7/mV4zZEBzK?=
 =?us-ascii?Q?snIYhHuXb1QgYuSScNcip6hnqjfxJN677DzOsOcF7FX9Xk0Wfhd77d12Ht1i?=
 =?us-ascii?Q?4yzlRdE9Ny4oO9hNXtSbaIzVOTGrGyluA3Au08UjIzmF/b3gfKy1T8DgDacp?=
 =?us-ascii?Q?6TEXiI2ashnxgRm7EOEH1tCSIsw5ZO7ilBfcDelQNSP/x3sHWgWVr9ZaCh3V?=
 =?us-ascii?Q?mserHFWXF/tfS/pQT0CgwoW3p4+GkdujttUrJT7swI4KCILZbF+xcg6Yieu9?=
 =?us-ascii?Q?B5/VmOJZMR6yFr63PTLj1tPu9NeumQnLyEHmZr1vkY+HS6cFepcbjLm6w51C?=
 =?us-ascii?Q?1GrHXQFcvYRIGGfEOMMLSf1eO5f54Oq3kEVSvnHOjqC5DtufqFkpwmqpp8lV?=
 =?us-ascii?Q?KY4SA5qS9LUUeVOGBT/AdhNScQkmvB7Gt8bRoxuBQM9fphMF7NioNbWVJfcS?=
 =?us-ascii?Q?tHbSqnt+g9ctoXUz0Zy2b5XWOLyYjChR4w0QSQpvB/sy4QTkunn2tuSmizNR?=
 =?us-ascii?Q?SOwtP75KR4UiANqrPf+UvTRe/C4o3kkgN+WlSbuqX8zAwBv5MmW4e+3yomfh?=
 =?us-ascii?Q?nie0Kx8D9XbUPnzK8H3GNEnYnrYXTzptnI3qipH+eQWjDm9bh3X9ECgBBS5h?=
 =?us-ascii?Q?WmxAAFEyC4MuyIii7QHOn/8nIW3ORkg2Hti211KCJzHB3EO2fpWqeKc9xQO0?=
 =?us-ascii?Q?tShhebxAFhZDLBWSW0BkPVAB5DpYtDLjNt6TpUrRcqoSqxKWCmds3E/CTUCk?=
 =?us-ascii?Q?ISENV204BMw4rcmcuvPyvurAeXKktjVWnGF5Qrpc3Evvz+gdKDA503/WsnkV?=
 =?us-ascii?Q?bmE/TfkmEq4JdS3O5JpqcwVjxSC738JSpwgR7Y+KfJBSDH7jEeNcOy+8tuos?=
 =?us-ascii?Q?8JTyKJuTWHGs0DuBRYwRfYW2hSYTcFMLUE1PMWN8njW3fKGPHwkUD2oHDkMf?=
 =?us-ascii?Q?MHB6T0v/iR83riNDkMuvp57HXLeG65vTWkHre1nJEKsgotobZZXIIVAw3rwj?=
 =?us-ascii?Q?+X6VahUCohOmvfIl4Gs4Zf92do6t/bIPzbokEMjBCRvRJDiFWz+lgHzxZYa3?=
 =?us-ascii?Q?C/jMuSOb//g0dVs4xTVlOI4QGY65uWWHrn8jIJSzLLheidsXB9/3wVe7A8Vj?=
 =?us-ascii?Q?cyAfP8RigTEEPlbO+ffkkltcqY6JkwoXv1fbcFzCNzOplVupojKEVNtcW1mL?=
 =?us-ascii?Q?J1iOJqGf5ff4pFteizQFFEZvgnBr1fbguXN3wxMe7k5h01Amcq4UkZuv/3gz?=
 =?us-ascii?Q?YlqbTKejmWNK8myi5L8or6dQcVcpBfi8vt1DQOM79jm8/JFhYQTB9ZbbvIyD?=
 =?us-ascii?Q?5did8ggQQQOXSfG/KXEpbTJ8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd572882-af62-4f7d-11e3-08d920473165
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2021 13:07:19.6017 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D3ghDr3VXLqzX7h0jqkhT6t0dJg0Qf/nmNRe40dwGBA8GyN2r7pqvzf1U3QL6BEpaYJg04PK0SUgiafIgioxXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5087
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

The subclass, amdgpu_bo_vm is intended for PT/PD BOs which are also
shadowed, so switch to amdgpu_bo_vm BO for PT/PD BOs.

v2: squash three related patches.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 90 +++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c | 16 ++--
 2 files changed, 67 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 6bc7566cc193..80d50e6d75f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -658,9 +658,9 @@ void amdgpu_vm_move_to_lru_tail(struct amdgpu_device *adev,

 		ttm_bo_move_to_lru_tail(&bo->tbo, &bo->tbo.mem,
 					&vm->lru_bulk_move);
-		if (bo->shadow)
-			ttm_bo_move_to_lru_tail(&bo->shadow->tbo,
-						&bo->shadow->tbo.mem,
+		if (bo->tbo.type == ttm_bo_type_kernel)
+			ttm_bo_move_to_lru_tail(&to_amdgpu_bo_vm(bo)->shadow->tbo,
+						&to_amdgpu_bo_vm(bo)->shadow->tbo.mem,
 						&vm->lru_bulk_move);
 	}
 	spin_unlock(&adev->mman.bdev.lru_lock);
@@ -696,8 +696,8 @@ int amdgpu_vm_validate_pt_bos(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		r = validate(param, bo);
 		if (r)
 			return r;
-		if (bo->shadow) {
-			r = validate(param, bo->shadow);
+		if (bo->tbo.type == ttm_bo_type_kernel) {
+			r = validate(param, to_amdgpu_bo_vm(bo)->shadow);
 			if (r)
 				return r;
 		}
@@ -793,8 +793,9 @@ static int amdgpu_vm_clear_bo(struct amdgpu_device *adev,
 	if (r)
 		return r;

-	if (bo->shadow) {
-		r = ttm_bo_validate(&bo->shadow->tbo, &bo->shadow->placement,
+	if (bo->tbo.type == ttm_bo_type_kernel) {
+		r = ttm_bo_validate(&to_amdgpu_bo_vm(bo)->shadow->tbo,
+				    &to_amdgpu_bo_vm(bo)->shadow->placement,
 				    &ctx);
 		if (r)
 			return r;
@@ -863,14 +864,17 @@ static int amdgpu_vm_clear_bo(struct amdgpu_device *adev,
  * @vm: requesting vm
  * @level: the page table level
  * @immediate: use a immediate update
- * @bo: pointer to the buffer object pointer
+ * @vmbo: pointer to the buffer object pointer
  */
 static int amdgpu_vm_pt_create(struct amdgpu_device *adev,
 			       struct amdgpu_vm *vm,
 			       int level, bool immediate,
-			       struct amdgpu_bo **bo)
+			       struct amdgpu_bo_vm **vmbo)
 {
 	struct amdgpu_bo_param bp;
+	struct amdgpu_bo *bo;
+	struct amdgpu_bo *shadow_bo;
+	struct dma_resv *resv;
 	int r;

 	memset(&bp, 0, sizeof(bp));
@@ -881,7 +885,7 @@ static int amdgpu_vm_pt_create(struct amdgpu_device *adev,
 	bp.domain = amdgpu_bo_get_preferred_pin_domain(adev, bp.domain);
 	bp.flags = AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |
 		AMDGPU_GEM_CREATE_CPU_GTT_USWC;
-	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
+	bp.bo_ptr_size = sizeof(struct amdgpu_bo_vm);
 	if (vm->use_cpu_for_update)
 		bp.flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;

@@ -890,26 +894,43 @@ static int amdgpu_vm_pt_create(struct amdgpu_device *adev,
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
+	resv = bp.resv;
+	memset(&bp, 0, sizeof(bp));
+	bp.size = amdgpu_vm_bo_size(adev, level);
+	bp.domain = AMDGPU_GEM_DOMAIN_GTT;
+	bp.flags = AMDGPU_GEM_CREATE_CPU_GTT_USWC;
+	bp.type = ttm_bo_type_kernel;
+	bp.resv = bo->tbo.base.resv;
+	bp.bo_ptr_size = sizeof(struct amdgpu_bo);

-	if (!bp.resv)
-		dma_resv_unlock((*bo)->tbo.base.resv);
+	r = amdgpu_bo_create(adev, &bp, &shadow_bo);
+
+
+	if (!resv)
+		dma_resv_unlock(bo->tbo.base.resv);

 	if (r) {
-		amdgpu_bo_unref(bo);
+		amdgpu_bo_unref(&bo);
 		return r;
 	}

+	shadow_bo->parent = amdgpu_bo_ref(bo);
+	mutex_lock(&adev->shadow_list_lock);
+	list_add_tail(&shadow_bo->shadow_list, &adev->shadow_list);
+	mutex_unlock(&adev->shadow_list_lock);
+	(*vmbo)->shadow = shadow_bo;
+
 	return 0;
 }

@@ -933,7 +954,8 @@ static int amdgpu_vm_alloc_pts(struct amdgpu_device *adev,
 			       bool immediate)
 {
 	struct amdgpu_vm_pt *entry = cursor->entry;
-	struct amdgpu_bo *pt;
+	struct amdgpu_bo *pt_bo;
+	struct amdgpu_bo_vm *pt;
 	int r;

 	if (cursor->level < AMDGPU_VM_PTB && !entry->entries) {
@@ -957,10 +979,11 @@ static int amdgpu_vm_alloc_pts(struct amdgpu_device *adev,
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

@@ -968,7 +991,7 @@ static int amdgpu_vm_alloc_pts(struct amdgpu_device *adev,

 error_free_pt:
 	amdgpu_bo_unref(&pt->shadow);
-	amdgpu_bo_unref(&pt);
+	amdgpu_bo_unref(&pt_bo);
 	return r;
 }

@@ -982,7 +1005,8 @@ static void amdgpu_vm_free_table(struct amdgpu_vm_pt *entry)
 	if (entry->base.bo) {
 		entry->base.bo->vm_bo = NULL;
 		list_del(&entry->base.vm_status);
-		amdgpu_bo_unref(&entry->base.bo->shadow);
+		if (entry->base.bo->tbo.type == ttm_bo_type_kernel)
+			amdgpu_bo_unref(&to_amdgpu_bo_vm(entry->base.bo)->shadow);
 		amdgpu_bo_unref(&entry->base.bo);
 	}
 	kvfree(entry->entries);
@@ -2674,7 +2698,8 @@ void amdgpu_vm_bo_invalidate(struct amdgpu_device *adev,
 	struct amdgpu_vm_bo_base *bo_base;

 	/* shadow bo doesn't have bo base, its validation needs its parent */
-	if (bo->parent && bo->parent->shadow == bo)
+	if (bo->parent && bo->tbo.type == ttm_bo_type_kernel &&
+	    to_amdgpu_bo_vm(bo->parent)->shadow == bo)
 		bo = bo->parent;

 	for (bo_base = bo->vm_bo; bo_base; bo_base = bo_base->next) {
@@ -2843,7 +2868,8 @@ long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout)
  */
 int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, u32 pasid)
 {
-	struct amdgpu_bo *root;
+	struct amdgpu_bo *root_bo;
+	struct amdgpu_bo_vm *root;
 	int r, i;

 	vm->va = RB_ROOT_CACHED;
@@ -2897,18 +2923,18 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, u32 pasid)
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

@@ -2935,8 +2961,8 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, u32 pasid)
 	amdgpu_bo_unreserve(vm->root.base.bo);

 error_free_root:
-	amdgpu_bo_unref(&vm->root.base.bo->shadow);
-	amdgpu_bo_unref(&vm->root.base.bo);
+	amdgpu_bo_unref(&root->shadow);
+	amdgpu_bo_unref(&root_bo);
 	vm->root.base.bo = NULL;

 error_free_delayed:
@@ -3078,7 +3104,7 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	}

 	/* Free the shadow bo for compute VM */
-	amdgpu_bo_unref(&vm->root.base.bo->shadow);
+	amdgpu_bo_unref(&to_amdgpu_bo_vm(vm->root.base.bo)->shadow);

 	if (pasid)
 		vm->pasid = pasid;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
index a83a646759c5..3d9cff0c9dda 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
@@ -41,8 +41,8 @@ static int amdgpu_vm_sdma_map_table(struct amdgpu_bo *table)
 	if (r)
 		return r;

-	if (table->shadow)
-		r = amdgpu_ttm_alloc_gart(&table->shadow->tbo);
+	if (table->tbo.type == ttm_bo_type_kernel)
+		r = amdgpu_ttm_alloc_gart(&to_amdgpu_bo_vm(table)->shadow->tbo);

 	return r;
 }
@@ -238,8 +238,9 @@ static int amdgpu_vm_sdma_update(struct amdgpu_vm_update_params *p,

 		if (!p->pages_addr) {
 			/* set page commands needed */
-			if (bo->shadow)
-				amdgpu_vm_sdma_set_ptes(p, bo->shadow, pe, addr,
+			if (bo->tbo.type == ttm_bo_type_kernel)
+				amdgpu_vm_sdma_set_ptes(p, to_amdgpu_bo_vm(bo)->shadow,
+							pe, addr,
 							count, incr, flags);
 			amdgpu_vm_sdma_set_ptes(p, bo, pe, addr, count,
 						incr, flags);
@@ -248,7 +249,7 @@ static int amdgpu_vm_sdma_update(struct amdgpu_vm_update_params *p,

 		/* copy commands needed */
 		ndw -= p->adev->vm_manager.vm_pte_funcs->copy_pte_num_dw *
-			(bo->shadow ? 2 : 1);
+			((bo->tbo.type == ttm_bo_type_kernel) ? 2 : 1);

 		/* for padding */
 		ndw -= 7;
@@ -263,8 +264,9 @@ static int amdgpu_vm_sdma_update(struct amdgpu_vm_update_params *p,
 			pte[i] |= flags;
 		}

-		if (bo->shadow)
-			amdgpu_vm_sdma_copy_ptes(p, bo->shadow, pe, nptes);
+		if (bo->tbo.type == ttm_bo_type_kernel)
+			amdgpu_vm_sdma_copy_ptes(p, to_amdgpu_bo_vm(bo)->shadow,
+						 pe, nptes);
 		amdgpu_vm_sdma_copy_ptes(p, bo, pe, nptes);

 		pe += nptes * 8;
--
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
