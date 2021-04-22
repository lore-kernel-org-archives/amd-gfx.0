Return-Path: <SRS0=IWiu=JT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C717C433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Apr 2021 15:40:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1305F613F6
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Apr 2021 15:40:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1305F613F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B92C6E235;
	Thu, 22 Apr 2021 15:40:40 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C03D36E235
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Apr 2021 15:40:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hlh2C3vBa+p0B+okr0ozIRgZojYl/wyMH/gYOy85mFbkm1zXtGyXDaDhUjo+3vjgCSC+K7OEgfY18s1lxNPF1NiTAlBSon/mMBASJftQDOnCw4xWSrA42/8TpKnPzIes8h9bGs3/QzLQEpSDFK5doPB3f8Hr1H0JKiOXYAZ00CdUnDePRuljK49Kwxn5ZpS8MR098HfXQhGIymvRit+rys1txW2kIgkbhdGswKgYeE93fY5No+X0blO2X1Wl6OIc6uQUPGiivrEuTrGy5BIacGqZj1kfruKRoeEIoWsvQjoRa1SjrhLIt4sUthklM9gFyuIFJsGOo7aCk7m53dWFCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7NratV4tL45YH7V//bD3wxuhyz7MY9OEg9gDcLj26Q=;
 b=Sjzi9m3e2cwBi1oxkKZ7jXWpAa2MTWvY7VxUnAvrsaYuBrrup6MeIxchK9WMTABOW5m0QGenRtuCJIZXVyrXQLmUMy+prl7UscxaRn1++DL3YWW+uyEfthDcNKyVVqCFaGav/DbF5U+TQPgXPMzMiZafyJCPTc76iki+d1MWdz2DO61nOQPAd2OLtamVMTfvRn4yyWEA65TmQT27BKuMj4tNNEAsqJXRhThJS7zG4xA5qxoamlWIhCGtMFQaW7HCGa2RwnUAPDWxzej9iHFE+AWscUUyh3FvzKKQStOEdt967DhreEJLkCUw3llGFdN0C8CYDJX0b/wWizSx9vzyUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7NratV4tL45YH7V//bD3wxuhyz7MY9OEg9gDcLj26Q=;
 b=UCw1Z3eImVz6N3dzaBWioIknO5U3tnG1kJr7FBBkKpHjzufX43aKquSAAggZKKSyg9M/Pu8gftmF71WBUkqBwgWefjpsNHG5+082Yla2YY0SMIxcS7kuHd6tfSRTMvr5gFIgjxva5DLveOV12Kv72/lV23rz2YP4Ta6yFrnvUBM=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR12MB1239.namprd12.prod.outlook.com (2603:10b6:903:3d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18; Thu, 22 Apr
 2021 15:40:36 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::a457:1047:3886:4630]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::a457:1047:3886:4630%9]) with mapi id 15.20.4065.022; Thu, 22 Apr 2021
 15:40:36 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: Christian.Koenig@amd.com
Subject: [PATCH 2/6] drm/amdgpu: cleanup amdgpu_vm_init()
Date: Thu, 22 Apr 2021 17:39:59 +0200
Message-Id: <20210422154003.4048-2-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210422154003.4048-1-nirmoy.das@amd.com>
References: <20210422154003.4048-1-nirmoy.das@amd.com>
X-Originating-IP: [217.86.127.111]
X-ClientProxiedBy: PR3P189CA0083.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:b4::28) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux.fritz.box (217.86.127.111) by
 PR3P189CA0083.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:b4::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.22 via Frontend Transport; Thu, 22 Apr 2021 15:40:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 487b43a0-bf49-46ed-0c5e-08d905a4f8ee
X-MS-TrafficTypeDiagnostic: CY4PR12MB1239:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1239E75ACE44B10FD749B3638B469@CY4PR12MB1239.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nqIaxcOPQuNV2rjIrJvR66RLf/1WoHd0BSr1nd+p8Rt5YIJrwM0RrDUrvAFRpm+7O9PfDyTl/bIppg++8kxKyD6k9FydADpJ9ELJWp56U5iI5KSwVo0Vb7QvZWk+ANWflSL+GWcxbokLRsbzYhkuIGMtMDbmppQF/Zyusy9jNi0G5V8IlNQ/Ss/LdFwCnQiPeHNvzuUQwKZzlnl2wcFYedfu0KmqEQkzHpQ2c2lZcHDEShJOZPjkkhL0tu2fNXp9JzvmCAXfaV610WI2K5ZyEttDfAxB4DZWnPqqOjJqBwiONrndZa4Zj9QN1GUaBY1sg6m3Zx7ph7WBuQj23SMCa+7AQNtxYxEgzcxO1jmb5MjGM01ro0Xg79H5dL2hs/M58t8XJHd0lAF34Uhe0urVQyIGUb8vkae+K0YfYJr9vK5UItxbagaWT9vi2SUe0RdIZnAy/qRL4br2vAToIs3lCUBkWPq3evAYWHGp8psCo+3Lq8kLqmJIccZa1iGr4x0TsdQwBRxwep5MTKX77UU20lpn/Lh7lIK7u9erRPno6Ht6VmT97m1hiDpp7UvP9g4NAnehjnChaFCdcmAKRqwqt/qk3QVLeGJpzXDEw9+8leyC8wUtDoNz1F+kvfu5idSrpYX7BGyQ2Y/HFOoxdt3E1ZE5EY90iypK59R0UzTdbsU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(396003)(39860400002)(136003)(2616005)(956004)(8936002)(44832011)(478600001)(34206002)(186003)(6486002)(66476007)(1076003)(5660300002)(4326008)(6666004)(86362001)(8676002)(6636002)(38350700002)(83380400001)(38100700002)(316002)(6506007)(26005)(36756003)(66556008)(66946007)(2906002)(16526019)(6512007)(52116002)(37006003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?XNu1bA8+hI2wVqPN5ba/ZcUGhTPDNmLNYpLoU+VMbhOApgmrWBH5SzbldkQC?=
 =?us-ascii?Q?geDPFYahlP6DFv64fI7XvLyufICz0xxfMji62420UYHZT7CcS5NktyO7HTQs?=
 =?us-ascii?Q?XZxsa65h+Gpmb38i32KQUCXTULDJfpsU6i5SEEGqs2AFwkqZkE5ciwr8RAsb?=
 =?us-ascii?Q?pa2Xx91TsDQxpBpCz4JMY+6uGqLdzWOMuuOqRaOEgjR4Pf/klr89W8dfwtoo?=
 =?us-ascii?Q?XRpACYzGv4t+ruCQzkugwqww4lyhYdF+cdf/AXIutGrFyPYi1GkB/TgzxaCo?=
 =?us-ascii?Q?9M+a2rSJCF85WNCgyDccqOJ8Xag+oQ5bwwjldJ8ZIG9NTbjRrafx6r5rXKd0?=
 =?us-ascii?Q?dpUZwnYhDm1uMBSykCbc/cqzZzpooElZ9QAf0OPVv6T7peSrNi+2+cK09bEJ?=
 =?us-ascii?Q?U3CidoLjwPO5v/TXCyR8Tq4sZ6RLde7LBtu+xZvgJVFXh7h+kGO9CYiXvrpy?=
 =?us-ascii?Q?QnrFvK/IuEuHgNW4Zj8/4TiR3L5aVNi8IrmCCw1rHu0E7jH0BbFiiOxqs5Y+?=
 =?us-ascii?Q?Zl7DTIfyk9oo85XPl+N75NR9s38TE6BNaNSV+W4oa55wCuC3C/GJh3ZsH2dt?=
 =?us-ascii?Q?ZjiI3eJ0fI1m/yMykIVxhY7lX6C7SdKGTeQWaOJVNEA9W/gWhAD0OJq47Cl6?=
 =?us-ascii?Q?Sl4K5dyDeL7Pd7nNoKThgGfaqpZFLwIXbTnnW1BYTnT/XMG6/Eanh1FRrf1m?=
 =?us-ascii?Q?hNyzwLO/ITjpR0AzQhHzTnYCXXb9tyAkxuyad8LLsSTH2pD3/0z0oK7dvxXM?=
 =?us-ascii?Q?zpv1b2yTtntTL9u9vZM7OagAlh4nQMOCwnjjrJc+ZnACbD/0r5x2XZ/3QHQn?=
 =?us-ascii?Q?jvSDH273DCUOhcpJvt8k3VKB651NqIeKX3XCt0UAwLU89BXCHxbozfEmlbjA?=
 =?us-ascii?Q?DC7R5qaphSDnF9m3EHqihj3uTrYveXmj8Qt8l4Gz+AbeP8Pn1UjOmZHEngtH?=
 =?us-ascii?Q?SpWKnGB6d4k7M5a6mT8jWpOa4+Pbytk3dNxV1sS/htQCmIvlPXp7jnzb0J0n?=
 =?us-ascii?Q?cYPlwYjNVvP1Ergdi/YPhUeZ+LLQkj44qTZbJCKS3UTkIBZLquaE1c2LSfLd?=
 =?us-ascii?Q?pbbOCEimjA1zjVm9nIlJSpROD+MLNEkGG9ao/JCyR9UIxXpvLJC/5npi5s0m?=
 =?us-ascii?Q?DZZcBaGVhc6dez4CYNS+bRQRr0CAYNefiDoVV9j8wgbwezgteibztqpwmw+R?=
 =?us-ascii?Q?qkx7xCOtYBdhyRrxc8/tAhRW/5MCfPv+ZKWHvYoYByDKO7wjSDGm2DtdGYZ7?=
 =?us-ascii?Q?yPqK1YPN+81j2gH0TADShfxfbH3K3JwduWrbSsBEYJzd1iEJyBbjQ2GtsSPb?=
 =?us-ascii?Q?7Yg63iPUkiA6pLD905o9ojPY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 487b43a0-bf49-46ed-0c5e-08d905a4f8ee
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 15:40:36.0600 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9K0EB8mbFhctTiHZiR1XhcIZBEBNA73OGyKRPxcYiDyogpAI/Du32FmRP2nyhJufB11z097Ukp0rDhV5kRxzLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1239
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
Cc: felix.kuehling@amd.com, Nirmoy Das <nirmoy.das@amd.com>,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Currently only way to create compute vm is through
amdgpu_vm_make_compute(). So vm_context isn't required
anymore for amdgpu_vm_init().

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 16 +++-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  |  3 +--
 3 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 39ee88d29cca..07e8a7c28561 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1114,7 +1114,8 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 		dev_warn(adev->dev, "No more PASIDs available!");
 		pasid = 0;
 	}
-	r = amdgpu_vm_init(adev, &fpriv->vm, AMDGPU_VM_CONTEXT_GFX, pasid);
+
+	r = amdgpu_vm_init(adev, &fpriv->vm, pasid);
 	if (r)
 		goto error_pasid;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index f95bcda8463f..577148a4ffaa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2782,8 +2782,7 @@ long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout)
  * Returns:
  * 0 for success, error for failure.
  */
-int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-		   int vm_context, u32 pasid)
+int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, u32 pasid)
 {
 	struct amdgpu_bo_param bp;
 	struct amdgpu_bo *root;
@@ -2817,16 +2816,9 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	vm->pte_support_ats = false;
 	vm->is_compute_context = false;
 
-	if (vm_context == AMDGPU_VM_CONTEXT_COMPUTE) {
-		vm->use_cpu_for_update = !!(adev->vm_manager.vm_update_mode &
-						AMDGPU_VM_USE_CPU_FOR_COMPUTE);
+	vm->use_cpu_for_update = !!(adev->vm_manager.vm_update_mode &
+				    AMDGPU_VM_USE_CPU_FOR_GFX);
 
-		if (adev->asic_type == CHIP_RAVEN)
-			vm->pte_support_ats = true;
-	} else {
-		vm->use_cpu_for_update = !!(adev->vm_manager.vm_update_mode &
-						AMDGPU_VM_USE_CPU_FOR_GFX);
-	}
 	DRM_DEBUG_DRIVER("VM update mode is %s\n",
 			 vm->use_cpu_for_update ? "CPU" : "SDMA");
 	WARN_ONCE((vm->use_cpu_for_update &&
@@ -2844,8 +2836,6 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	vm->evicting = false;
 
 	amdgpu_vm_bo_param(adev, vm, adev->vm_manager.root_level, false, &bp);
-	if (vm_context == AMDGPU_VM_CONTEXT_COMPUTE)
-		bp.flags &= ~AMDGPU_GEM_CREATE_SHADOW;
 	r = amdgpu_bo_create(adev, &bp, &root);
 	if (r)
 		goto error_free_delayed;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 848e175e99ff..7f07acae447b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -379,8 +379,7 @@ void amdgpu_vm_manager_init(struct amdgpu_device *adev);
 void amdgpu_vm_manager_fini(struct amdgpu_device *adev);
 
 long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout);
-int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-		   int vm_context, u32 pasid);
+int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, u32 pasid);
 int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm, u32 pasid);
 void amdgpu_vm_release_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm);
 void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm);
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
