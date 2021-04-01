Return-Path: <SRS0=FlJ6=I6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C2BFC433ED
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 19:36:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FC01601FF
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 19:36:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FC01601FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4E496ED03;
	Thu,  1 Apr 2021 19:36:53 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680071.outbound.protection.outlook.com [40.107.68.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B1176ED02
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Apr 2021 19:36:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mRbuMe+BsyIZeamfop+1byUKKa9+DsIGxK7Sf6viEanl6SnhNe9qCBHkhg5OerMklVGED9TWci5sxWPaiQcNjOviz5g2K6YwcMFMF0RJE/VFipXg3gBXYW6vc8xeU9mSYbeHW5PSoMWSh5Blk0pcUtRcBTyaMGVUGrR1abde2f6QPggBM8IEkKJZM2z+zN1Dgq3NWxO2TYimfjacBXIY1QDmC2Em4ia8IRVplkLmVz/oArL6gm9XVP6YAqAHOppitGSQJTHBBULbTQXNuRgr1h8F799FhGz2cjjoj5F6SIa4efu2qR64NO8bobWu61MNMMnNjdDo5XtnDWg4sRzqJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j74FDZlGL9ZQMufcEEn3qS5BiKduxepP1oB5w6B22fY=;
 b=eaI3EJ6oNOYgUecjc5t7bxqUWHA+ZLXQLcydexfCKPHtXGVk/XEecyR8IUtnJZLtEwpuKvX7RLQiTZLLnaMvOfuSYzCCxlWNJFqpPJ53D6U34dvwAYqOTNsRm9xJFBogUYDvTR5M/UDS/zt82HmYJGMnJhTHyzkfMHTQsJ84SyGqV7DzoBqPTWgxmF253pZVkAOLCbdx9bkxMEVzWXgyJQp59h2U0Jm5uHWmw7eyXwLrO+zAt2G1aKIfutnQ8ZlaERmFJv5FYQaGMAMEnp1lEGZJ6XO6HSt8uqYZ3t4Ku5Cb6ACewh0dC+StH4/8mwzTyOgf9ytdqV8tKYVMD16BIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j74FDZlGL9ZQMufcEEn3qS5BiKduxepP1oB5w6B22fY=;
 b=x+n+byIMcv7f4n5uVyOwbiSzOnezg+glog5EmOvyodRdXJ8Ttl4igLoX11TQSw5fruqxV7FXv4u9otBfpio6MRamUO7De55aRjvwS7Z46GH5P4umhotYCx+ILvURtJL5v3VnQvSJsQdHnBCp+ZSYJEPe/gvdTb64fqd0Ro1xkXQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4732.namprd12.prod.outlook.com (2603:10b6:5:32::25) by
 DM6PR12MB4203.namprd12.prod.outlook.com (2603:10b6:5:21f::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.27; Thu, 1 Apr 2021 19:36:51 +0000
Received: from DM6PR12MB4732.namprd12.prod.outlook.com
 ([fe80::f40e:1245:84b6:e2a4]) by DM6PR12MB4732.namprd12.prod.outlook.com
 ([fe80::f40e:1245:84b6:e2a4%3]) with mapi id 15.20.3977.033; Thu, 1 Apr 2021
 19:36:50 +0000
From: Oak Zeng <Oak.Zeng@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/4] drm/amdgpu: Introduce functions for vram physical addr
 calculation
Date: Thu,  1 Apr 2021 14:36:40 -0500
Message-Id: <1617305803-5767-1-git-send-email-Oak.Zeng@amd.com>
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YT1PR01CA0143.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::22) To DM6PR12MB4732.namprd12.prod.outlook.com
 (2603:10b6:5:32::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ozeng-develop.amd.com (165.204.55.250) by
 YT1PR01CA0143.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3977.30 via Frontend Transport; Thu, 1 Apr 2021 19:36:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b8ecad3-9c08-4f55-a3f4-08d8f5457ef8
X-MS-TrafficTypeDiagnostic: DM6PR12MB4203:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4203F018A7C80F60FAAB6BE3807B9@DM6PR12MB4203.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:451;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u5OY5bQx3Xey5tPCw+JQl8TVvXjcHTLU+5ozXoKI8EVUAqKwKdpHOwMoGiyDY5w+y/Go8KWNgRZ85i53smnfAPPyEjcfMK8k+Hb9maL1gOrsdJsHjT6rMe6qKkje5hwwergSl/uKjYG2HC0RVgPtfU/C6AeWZU3yPf0qfk/LYAXZ35lO15e+zh1fkuT1sMCpQC7pkTlzERMwJyM5mx50DS5bPq3Q6K7Pli3yQev/+zTnRZEPUSeBisaGb30G01u5qRdNpzCNMsJbJpzje05h8Qt74iKixJlLhBwZFS5Nz+FdFiQHKOuB7BBR8wn/JE7zQv8QCBI2+/MecfGGvj+TW9vVwOssttO8RAK/fwSt5VcwVzs623rB4YRhCeO7d+uExAy/KdIObvFgyEvp44uOQPuzIgp+jV94Qny5HE2f8rr0maWlMr3kQ4rZ64rsw06L2UITw72VcSnN+simCgjLYbCeTOuXOjamfrnZtcrJMpiZ34euS/R+GdFLmbCwFsnIwY39calN7gUVrB+mO4kS4OaGRhKf42yP5b9B1BJ53aGubmwJHg9E/9099m0dPpKuuVCSZZ0PmVvZeWShA8etPJXWcmNxQ0DN97D3GyuRUjMyrhPYzVZT0CTANAfoBgxXR1AmILpgy7tvlOItfGmAfhhvaFDwwf0TmgDJZ2Mi3r4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4732.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(346002)(39860400002)(136003)(376002)(38100700001)(66476007)(66556008)(6916009)(66946007)(26005)(52116002)(16526019)(186003)(6666004)(36756003)(8676002)(7696005)(86362001)(6486002)(2616005)(478600001)(956004)(316002)(5660300002)(2906002)(4326008)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?wnwTucnYu9IXbJitqD4mdew19z8+Z7TA6d40gpDfUASXnTfwD8gT183XqaSf?=
 =?us-ascii?Q?KZbF0GqzGgmOdkc9bqxK1BObrp8nHN+hd9wiEJj83ezBpocVgb+3BkR2rb6p?=
 =?us-ascii?Q?iySWEvGvVwoGgmvuLiUR6slzY/VGHMUBBg1SlmzuPTXNQolqgwpEdmIr8m5A?=
 =?us-ascii?Q?ICX5a+y/draEviuANzxA7XzwZRzCTMdaYLRfhk0ZfZXNyIjHcTbcuNVxq0vc?=
 =?us-ascii?Q?uaESdTxL6gASNUeuIjz2fIj34aYU9PInkY9n9sScVKEx2tMuEP/QYY/BaCU0?=
 =?us-ascii?Q?QzaV9uXf6HWWe1zcM8963cA4W4UqHikeZm8l46/D9IcJjMa77uvT8mJMA51Y?=
 =?us-ascii?Q?XF/YZciitOnM+27FeUiWR2AxKEaR3lRk70i/KcYGNFhXMgT4MGrjD8v3EqXr?=
 =?us-ascii?Q?I83Mr1XV27z4QlxAMfJk81dPmRWVkmPh+e9Ho3ECvyEIaQFeW3XTyoUOKAnV?=
 =?us-ascii?Q?TrKo0oesndVbunO4LbWH+dCp/TKS7NF6WihidH6YLNQwP7I1vuJ0GqcsBT+3?=
 =?us-ascii?Q?8kPR19w9zRIMfHpN8DXiAq5koL0xu6Yt/PwAo6Y49Af7D3u8GWlSCLVS2rqv?=
 =?us-ascii?Q?FkiuJOXZr9ZFYDL90f0Wjg2grv+Gay9WcFa0YnOyrLsqWF9gAWNAerUI2lMB?=
 =?us-ascii?Q?hoGUQlnVh2kPPxvzt7pdpjd16W6HCN2WUhA6XaGOATfQPydLO+8gxnMNrSja?=
 =?us-ascii?Q?WBh3Q/7PAn12pqrfli3TSgSVKJr4VeTs0DL3lcVkNtNndH+md9fygpHdbuzO?=
 =?us-ascii?Q?yX2O1pgZgdd5t6gbduQBqusA3hQYcoLwtPSsvgjt+p+Tfa7WiUZTi9YCgic2?=
 =?us-ascii?Q?A1t9GOC0m0ItlAXOMZecs5hb+4JrrIMMmvMvlXvvR17nGjH3/zGrvxEtFoUL?=
 =?us-ascii?Q?ielPtaoHUCn5cHAJtZjfPUc1Rpm7Mro3q+0QG7WBNnRpZ8D8rB2vmnB02/tN?=
 =?us-ascii?Q?uz+vGyIOheqocCMQ6CKGlxLLXhfF8dFC9rUPG2+5b7KdSLkEu8rB7siapmme?=
 =?us-ascii?Q?x26XnS0IQTbbz2EsiZoBwe/esb3g/zA/63oecctz9l4CvKasYEjl/1PnHWkx?=
 =?us-ascii?Q?t0jJfMWLtTS7KMKwYtlFukZuyQcy2xYHFVb/2APZ15GaPH+4ChMUq2ZNVOj3?=
 =?us-ascii?Q?Ni1pqRQZJjvShoJaTfzvg42DUH/iThK1Bp778N7LsoR6uPJZqijQdkunvTqR?=
 =?us-ascii?Q?o7Dnea0xdMmSX52uz3hDs8RUMwrfKWLaMc33zykPrWBpcufssFeA8C5/52rr?=
 =?us-ascii?Q?2CkEkw7LhVW4u/RkIs2CPb11mqUVtdME/VIukCs5zwSdEP5DQjd6m6blbHip?=
 =?us-ascii?Q?72Hy6BaYEgRawHJpE2v7evzL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b8ecad3-9c08-4f55-a3f4-08d8f5457ef8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2021 19:36:50.6666 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yRZlowwuX+UFGZOtRGlkMWaU8MppNwJ2q35VNtF4jCBJQhfyj4noIuwWM0//K2fI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4203
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
Cc: felix.kuehling@amd.com, lijo.lazar@amd.com, christian.koenig@amd.com,
 Oak Zeng <Oak.Zeng@amd.com>, hawking.zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add one function to calculate BO's GPU physical address.
And another function to calculate BO's CPU physical address.

v2: Use functions vs macros (Christian)
    Use more proper function names (Christian)

Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 34 +++++++++++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  3 +++
 2 files changed, 37 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index b9d68fd..ca16649 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -665,3 +665,37 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev)
 	/* Requires gart_ptb_gpu_pa to be 4K aligned */
 	amdgpu_gmc_set_pte_pde(adev, adev->gmc.ptr_pdb0, i, gart_ptb_gpu_pa, flags);
 }
+
+/**
+ * amdgpu_gmc_vram_mc2pa - calculate vram buffer's physical address from MC
+ * address
+ *
+ * @adev: amdgpu_device pointer
+ * @mc_addr: MC address of buffer
+ */
+uint64_t amdgpu_gmc_vram_mc2pa(struct amdgpu_device *adev, uint64_t mc_addr)
+{
+	return mc_addr - adev->gmc.vram_start + adev->vm_manager.vram_base_offset;
+}
+/**
+ * amdgpu_gmc_vram_pa - calculate vram buffer object's physical address from
+ * GPU's view
+ *
+ * @adev: amdgpu_device pointer
+ * @bo: amdgpu buffer object
+ */
+uint64_t amdgpu_gmc_vram_pa(struct amdgpu_device *adev, struct amdgpu_bo *bo)
+{
+	return amdgpu_gmc_vram_mc2pa(adev, amdgpu_bo_gpu_offset(bo));
+}
+/**
+ * amdgpu_gmc_vram_cpu_pa - calculate vram buffer object's physical address
+ * from CPU's view
+ *
+ * @adev: amdgpu_device pointer
+ * @bo: amdgpu buffer object
+ */
+uint64_t amdgpu_gmc_vram_cpu_pa(struct amdgpu_device *adev, struct amdgpu_bo *bo)
+{
+	return amdgpu_bo_gpu_offset(bo) - adev->gmc.vram_start + adev->gmc.aper_base;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 7e248a4..bc374bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -332,4 +332,7 @@ amdgpu_gmc_set_vm_fault_masks(struct amdgpu_device *adev, int hub_type,
 void amdgpu_gmc_get_vbios_allocations(struct amdgpu_device *adev);
 
 void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev);
+uint64_t amdgpu_gmc_vram_mc2pa(struct amdgpu_device *adev, uint64_t mc_addr);
+uint64_t amdgpu_gmc_vram_pa(struct amdgpu_device *adev, struct amdgpu_bo *bo);
+uint64_t amdgpu_gmc_vram_cpu_pa(struct amdgpu_device *adev, struct amdgpu_bo *bo);
 #endif
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
