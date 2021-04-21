Return-Path: <SRS0=nJCL=JS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F555C433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Apr 2021 16:36:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2328E61448
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Apr 2021 16:36:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2328E61448
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDA7D6E9DC;
	Wed, 21 Apr 2021 16:36:06 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EEFE6E9CF
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Apr 2021 16:36:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QNpdZlOVccOG5KinSWo1vcLwD6Jr5piCChGP5y9v08rJh5fXjj/ZdfAFyB3f4wYO+eCxmVkIysV3ypFJXmRuFM2GPfM5QW7qTvIIeLVTRqkoh+012br7jDCn1+xhFrpzRIt3RUkMyolXLJqwTOittcLTTxjg90oLiFmcVzfZatg5rHefYWDpA80LHHPemiGqqGsJwPOUIfi+I5do2suu6qrYdAYH+56b5kdtZ04JTdksgwLmOXZZ6GtS/sCfbpAwCuckB+TAOpLo0+3cwBjLVQVltfouSuNLEz9cxuu6gGw8YG0HlnRqd29so7FsVRLPAq4kkQKFJlmc/YAlkSeU5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1jVfWZhUb8ec0c9BwhCBMpm2UhKRi9v/ITAeqr4c6rE=;
 b=UhOD2TlIcyVoL3rT1gPZHc6K8i4ObbaGz3vPFgA3vSPRrMvfQL+8BCIgpHjHMMbD6LZVm7URJg7dnukV9Tez8tVVv33HXGSqCyeXRYtKDD5yn3Xhr87IcfiIbbyUXZaEXJCHU+KZ6k6kBgtMMtmGM1y/zyNhmguet0gwuFx7nghHKZ/2UCOXQ2/dqgShcoZpV/GeFTShlP4Ihk9Dmv3fxmmk9o2CpaaB3me60JgCiaTQkGlB7OFdraJxuQeC6ZiQlePLSuSv0WFtkvhEYA73KwRjQhSYEKrs03lerQ7RWS8cgts4236Gb/9yiTTE5o5Qs1E9tS1WUAlRC/BAJpHaTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1jVfWZhUb8ec0c9BwhCBMpm2UhKRi9v/ITAeqr4c6rE=;
 b=vYZ7zFLHeek1T0DF/zxgyjOld9dFlokvM2oLutukjbHUmZhkGyL2zDlS4PBBnD9mPtKMCJuTIkO5oMnfxGs8pN74+K0+SPagB2jXRwMtw/lROMBHZENz5t4DRwmxLbRmDNpenxzPNU19q79OMomsB9W4zjhbczLu4pEuwBex9a4=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR12MB1576.namprd12.prod.outlook.com (2603:10b6:910:10::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Wed, 21 Apr
 2021 16:36:04 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::a457:1047:3886:4630]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::a457:1047:3886:4630%9]) with mapi id 15.20.4042.024; Wed, 21 Apr 2021
 16:36:04 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: Christian.Koenig@amd.com
Subject: [PATCH 2/4] drm/amdgpu: create shadow bo using
 amdgpu_bo_create_shadow()
Date: Wed, 21 Apr 2021 18:35:21 +0200
Message-Id: <20210421163523.14493-2-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421163523.14493-1-nirmoy.das@amd.com>
References: <20210421163523.14493-1-nirmoy.das@amd.com>
X-Originating-IP: [217.86.111.123]
X-ClientProxiedBy: AM3PR03CA0071.eurprd03.prod.outlook.com
 (2603:10a6:207:5::29) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux.fritz.box (217.86.111.123) by
 AM3PR03CA0071.eurprd03.prod.outlook.com (2603:10a6:207:5::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.16 via Frontend Transport; Wed, 21 Apr 2021 16:36:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b00785b3-83aa-4c5f-c5a5-08d904e38e16
X-MS-TrafficTypeDiagnostic: CY4PR12MB1576:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1576626CD4F90235FED9EE138B479@CY4PR12MB1576.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2sEw+/6vSz1F6OBEHbHWWuNF1q4Sr7fvjU3xVsvUSX29dXyy/naShUWQwNRk0kRWhXO04of4v4dgy4AmuPaPxfeTLI+9KEwcJ94w7jrvYwRy4HvEH2ilVuPfAni33cU8BvfYikpxDTNaXrffrmbKD4cVCZMwcSKOH1DNgn/A8fNjr28tQ/fxH1/rQxg3cPI9EOuz2kHXKI1LEAcqAT7xKT45Iy0yTAOGUh4C6PglsVmzNxAhvgZ+E8mElcrF8a5lMWrSl40Pyu1OrAypcpTc69zNEvcpDKrhZn8zy6yLQsJ/fPaazy2fqVXgHC+WKYumluuZE2fKkV3QlilQDFxLUFxQfdy57NmvTpFvE555mZ+7pM3KndlwD0TLZLzBIiXk384rE5W7yHOCIPzFo+LpphGUNQ1TbBE66ZekbJPV/En54vjDeYPINVkAArZvQF5LMDQmj9nz3Dn3gBgfvQ1TlwEHKocsh3Qq2zI7x2nwZa/pbmOb8vNM5DECoIFEVTfPpImxavMdMz0Vd5eEm6p8/xj1qaOL1WT5DuMsBqdVtwc8z11jtS1VCPNtcYKQp/JueWzn8bX4J6LuqXnblrVey+YJy2JDEpG/wUSGkToWcfWvi/t6mrEUsJHm8xJ38O68wGmgYeBNRxmluEhCxGtqPx3qfG0kWhy0ETksKjuDvTg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(366004)(376002)(136003)(346002)(26005)(44832011)(83380400001)(66946007)(6666004)(6506007)(4326008)(186003)(8936002)(5660300002)(52116002)(478600001)(6486002)(6512007)(6636002)(36756003)(316002)(66556008)(34206002)(956004)(86362001)(38100700002)(8676002)(16526019)(38350700002)(1076003)(2616005)(66476007)(37006003)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?rxJ2KG8iyOx2WrK53d1vRu1NnxgtbAz1Ky2KbekxAzdUWIcSiWEVaBhWfsUN?=
 =?us-ascii?Q?xzfL2k/dYxfoxumwDjSyKxhD7ChJVzBI5hFzO8Y5vfVxxQkk+RgBVnx3dh0w?=
 =?us-ascii?Q?J6Wj05nuL9sDc7ruAkRniNlYMZdL+HSu8HqEEuWV7mAW7cLbXxPximVeiDUj?=
 =?us-ascii?Q?PlPJg+DkMeCiAo4DMoCNEgph9vgCciEjGliKFL173qOVoNz+le68/y6uoC7w?=
 =?us-ascii?Q?Ty5Bz2fjVng2vyWVN6574z3oIqZ/sJfg4Fu12icV5b15pgHJMIAfyhGwKz3Y?=
 =?us-ascii?Q?kVYZZiYIbggYgBQvmaEOFhTkmgbn7BT2HOW66+R7vo5xyspus/mreJ14Dz2m?=
 =?us-ascii?Q?Lcx+xuzzm4qL3LqRz2wXgkKHZQlXSULic5xWGFoaAa21hs49JzO4exJzPviT?=
 =?us-ascii?Q?eBgygXWuvHMHdSJKxOI8yORGzyovb+a6BJpOOlMfj8unjv4ujhcIGKqSXrhT?=
 =?us-ascii?Q?c7wzHdwdFv9w+AJl8vxp5v3qBm7on2jeiyW+gkHRiM0s04WjvBkEf2l8YSup?=
 =?us-ascii?Q?WSvc68dZuiRS47IYvWJikcl05jm9Rg86U8hnJIVcWP5IC4edXfuX4y2jIAVH?=
 =?us-ascii?Q?9weFyzGh5Xi3uzEi6J64WS1mu2Jn/SSS1sXeWiluzRo2QjlZe2l4C2786fCi?=
 =?us-ascii?Q?vWhPrX80tSJUBtxr4fjAl9frpLJWwwvVS+3BSSo/gHNZEVnoRRTpSG1Onhd+?=
 =?us-ascii?Q?YA68tyYUbOdYBA5gMqcIMs0rEuTpvsJqSTcq9HFKImG3MiXGx7R5wtkGge+k?=
 =?us-ascii?Q?1/JRzo0+w4VSCsBshWgEa+kksUoKiUWPwZiqV7ZQXPSmR0BgFqq9QuTocVRj?=
 =?us-ascii?Q?yJrGntQT0q/g0kyRQjIMvb1QqBQhy7kPIenV4vcb+d0op/opsMD3LIGSl/L1?=
 =?us-ascii?Q?XeaQcJD2AN9/pGrxAUKgmV9EErykLLqaGFDbAWpKf998yo2CaSWMWBFaMbgD?=
 =?us-ascii?Q?WDV4R4bvNUwMPIxRrs5pQoaLZVWdZJOxvgcsjQHeqGPckW6KNCunq4ukM87U?=
 =?us-ascii?Q?WzxQG4HDfrZl0XiWeC2cXpXdt20LhVLd1BgtBck1gbYpfDPnfPrb6sUVzHt0?=
 =?us-ascii?Q?FJqTOw/d63QIwV8fL/btIN/4Urh0hMLNbdvksNmZm4lpVgaBd0Z5ktwPSuxH?=
 =?us-ascii?Q?IzyRjehH/GSeenwQwWBXr4/R/50lfC5AFoApZkvsx1UdqPFdmA2Zj/QXiHUK?=
 =?us-ascii?Q?33knOSy8vLTuOUAv79I3INDrn7sglQGDZZq2hnwPV6qPiVJW6L+uO4nGx6iI?=
 =?us-ascii?Q?QOF10QLFOTch+unXjonMiHaNGrokBNcUyl6BGXUUToiI4EFXfK5gKWzI8Txy?=
 =?us-ascii?Q?sTksnwjjARiQlulqUJLbyw9c?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b00785b3-83aa-4c5f-c5a5-08d904e38e16
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 16:36:03.9199 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6gNKgQQSdhQy4dsnFdqAAeBD9nw+1r6qNQMUcIULDIbPtefoTOExAxF87wpd6tImfMyz6FSlP4A+yf/SEjoFdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1576
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
Cc: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Shadow BOs are only needed for vm code so call amdgpu_bo_create_shadow()
directly instead of depending on amdgpu_bo_create().

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index f95bcda8463f..bc302548dfba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -873,8 +873,7 @@ static void amdgpu_vm_bo_param(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	bp->bo_ptr_size = sizeof(struct amdgpu_bo);
 	if (vm->use_cpu_for_update)
 		bp->flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
-	else if (!vm->root.base.bo || vm->root.base.bo->shadow)
-		bp->flags |= AMDGPU_GEM_CREATE_SHADOW;
+
 	bp->type = ttm_bo_type_kernel;
 	bp->no_wait_gpu = immediate;
 	if (vm->root.base.bo)
@@ -2844,12 +2843,24 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	vm->evicting = false;
 
 	amdgpu_vm_bo_param(adev, vm, adev->vm_manager.root_level, false, &bp);
-	if (vm_context == AMDGPU_VM_CONTEXT_COMPUTE)
-		bp.flags &= ~AMDGPU_GEM_CREATE_SHADOW;
 	r = amdgpu_bo_create(adev, &bp, &root);
 	if (r)
 		goto error_free_delayed;
 
+	if (!(vm_context == AMDGPU_VM_CONTEXT_COMPUTE) &&
+	    (!vm->root.base.bo || vm->root.base.bo->shadow)) {
+		if (!bp.resv)
+			WARN_ON(dma_resv_lock(root->tbo.base.resv,
+					      NULL));
+		r = amdgpu_bo_create_shadow(adev, bp.size, root);
+
+		if (!bp.resv)
+			dma_resv_unlock(root->tbo.base.resv);
+
+		if (r)
+			amdgpu_bo_unref(&root);
+	}
+
 	r = amdgpu_bo_reserve(root, true);
 	if (r)
 		goto error_free_root;
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
