Return-Path: <SRS0=X6dN=BQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0949EC433E0
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Aug 2020 16:06:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F46223132
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Aug 2020 16:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="K+OKSKAR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F46223132
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69D0E6E8D5;
	Thu,  6 Aug 2020 16:06:49 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28B676E8D5
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Aug 2020 16:06:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NPI1QxJ6S8yGVmnhv/IZ6tw/g7lkxiFjBd/lt33DQvWRrv3FdAj9yqddAS5eP9ysdk8x5Khd4lGjVUMBjomRNnLVIDNUepJh+gn496mgnc3fYnkONvECYHasHYpGd0g5Riu9pr7doUJqKF8HVmCD9u/T6zK8XlHtwJ/Phi6SDBw+YS8X7FmPr3/lKOUemrNRrtfPlazhH194GNDuR21lkrlDwOR5ZBzZSMqv3Sn+Gjb1NHHMHS0cxlU+GkcTKEwvgtAruEE4OduT5CNlf6O/AkjxotW/z8KvVfMAAtytW08TCTTyceCV+b36OQf70QUQDoRG/nKuz3WBTOCZxsRfvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XyjXSU/zjfwkKOl7dmuZn0L5Y/Aa0PRnFZQQYb1vCiA=;
 b=D/jCE/lNv5qUcKL3NBW72njnBTBkDdLWraTvauygGDRqaFudcqiZInEdBDyI8V4N6hVKIOlzXz7HJ7CSVmuDgA/JmpfmT22GCgvi8IY9X6NiP+SziJIFNQLMTXrfE+a8yTXKUIy81lHWCtqUG9QOYXRhyMq3kZ9hXohNlLlEHzOfgnIRKuh94YJWrO0JCoQBm8M5m59BOsiqLS5giXwTgUmMiooA7fZALCmDYJBsGRiztjLGpabS7Z3GKWW95lwVvaU1LCeyEAtjma+G/vbD7IwI5IpxmVXPacr0+i2X1an3EgGdpzQBOLFBYk3TMwBJyyyx90tRA3lk8iIOZPPlWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XyjXSU/zjfwkKOl7dmuZn0L5Y/Aa0PRnFZQQYb1vCiA=;
 b=K+OKSKARmhqnUuZkXoVyWGffhKEdSkiAmi9hTOBmQEc/kegnA3tFACerC1jUuWxtDgMNgDcftPkbhNHLIAM00JJzfm3ukusYKR/ZlfE1xvPE5w2PbIRnwpqaQVumdlhQwfYphsaPrUajziJgKYPrqNVLx8CdvirWrn1693CLDng=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3022.namprd12.prod.outlook.com (2603:10b6:208:ce::32)
 by MN2PR12MB2861.namprd12.prod.outlook.com (2603:10b6:208:af::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17; Thu, 6 Aug
 2020 16:06:35 +0000
Received: from MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::44b3:9382:383e:ab93]) by MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::44b3:9382:383e:ab93%4]) with mapi id 15.20.3239.022; Thu, 6 Aug 2020
 16:06:35 +0000
From: Kevin Wang <kevin1.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: don't create entity when use cpu to update page
 table
Date: Fri,  7 Aug 2020 00:07:44 +0800
Message-Id: <20200806160744.81530-1-kevin1.wang@amd.com>
X-Mailer: git-send-email 2.27.0
X-ClientProxiedBy: HK2P15301CA0020.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::30) To MN2PR12MB3022.namprd12.prod.outlook.com
 (2603:10b6:208:ce::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kevin-pc.amd.com (58.247.170.242) by
 HK2P15301CA0020.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.0 via Frontend Transport; Thu, 6 Aug 2020 16:06:33 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8ec6bb15-1976-4482-6f11-08d83a22b176
X-MS-TrafficTypeDiagnostic: MN2PR12MB2861:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB2861A5E9D3A02D312D58CA52A2480@MN2PR12MB2861.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZfzTnoQfFtd5X4hdwsC1xXAEVlZEwRU8LVh2Xq43lxL1xVhDK9DSimC6IC58Rb+G/U4OVLxdTu8G+iJTIm/MvL0gFhPKZbPXj8+Byr8Uec+CnJYqa5zGDLyKesQIivbM5u3OIg7Jq7/eIB53DfyRBr7E1z8HxGsiovwV0mmyobrxnxXE7dtSN4DUrb00rGEXI/IwPffxzUyupQWSLAwkUAfezHlxc1S0YR4lV20e/yFbb/Pw7aTaPl4QrC+TetwpuFZyyCcvWjHF1mhDToWK9vz5Rgt2Whs7f9YEW0uHNTEoWIqtrvGhl2/3FZ8vgpEp9soh264ALyl787hySuUGwFhlLrd6CWBkZeFQv9fwZ/cYD044tNzYKWgUIHQiUWyf
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3022.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(39860400002)(376002)(396003)(366004)(136003)(956004)(2616005)(8936002)(5660300002)(4326008)(66556008)(66476007)(66946007)(1076003)(86362001)(15650500001)(6666004)(478600001)(2906002)(316002)(36756003)(6486002)(26005)(186003)(6916009)(16526019)(83380400001)(8676002)(7696005)(52116002)(16060500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: c2LLNp7LOMRqQGgsamC1MSA1Q7+iGooHufwAiXxkZiAhp4SEmNYJpQqVlHEnBMWxXGEXJKxjlTbsEnkzljfmlmXjXgmCrY01yP9DRFm13SChhYzvaG1CjnKhvtD0oqBK39xBq8dUJWdNNnJblNH4cjCQXCB87vwia1tWPJCfxJXYfzhw9CqRDcChmVH7iBiuytpNWGllFvKWl5nCoEysV/5XDo7HY21kI+Lld7nLoXYy+qQcoFq6HtMqjr+udOR9uQOHx9FubmK7NBVRNYoBJHtbitrbYV0Oh3+6zsDLv1s0vMviNqecxVRauRs+ZUfTW6GLzBbAJcrDJaY90Ichm2ozJRw9lMc00V/UVoS9Wlq4tswI+BEZ9MTLyEd6JO4G+HoDJ+Dd8HUOCbWKpna3mzFpRu5O6wv8GZ4NVcaS67kGgS57Z8IjFFG3tK02vK2xz0dMG4gmjHeQHWJXCKo83+dn3fPsw+aoAg/Fhhj9UwgTxscUny+TzPVG5HMbCJmOuCXnX0xhBwg46kggxSS9FU+hL+7foGc63Hhph1o+9BJ2Ppo4z4M+/u20ZM4iv5VuN8DXDmm/RW6QEQ2o6iTKrSumZQN30h/ZiE53jUtaybioLVltbXnu1icVk1jWtn2o71mtY9h4cRegsDcgbvDsEg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ec6bb15-1976-4482-6f11-08d83a22b176
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3022.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2020 16:06:35.7850 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DsExjrDgHFPgSuJwr/fxVAgrC5I4G3WsLZFvdZfV6sI2COeTYT/DUbvCjoCAobB4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2861
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
Cc: Kevin Wang <kevin1.wang@amd.com>, christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

the entity isn't needed when vm use cpu to update page table.

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 45 ++++++++++++++------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 71e005cf2952..e15c29d613d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2802,20 +2802,6 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	spin_lock_init(&vm->invalidated_lock);
 	INIT_LIST_HEAD(&vm->freed);
 
-
-	/* create scheduler entities for page table updates */
-	r = drm_sched_entity_init(&vm->immediate, DRM_SCHED_PRIORITY_NORMAL,
-				  adev->vm_manager.vm_pte_scheds,
-				  adev->vm_manager.vm_pte_num_scheds, NULL);
-	if (r)
-		return r;
-
-	r = drm_sched_entity_init(&vm->delayed, DRM_SCHED_PRIORITY_NORMAL,
-				  adev->vm_manager.vm_pte_scheds,
-				  adev->vm_manager.vm_pte_num_scheds, NULL);
-	if (r)
-		goto error_free_immediate;
-
 	vm->pte_support_ats = false;
 	vm->is_compute_context = false;
 
@@ -2835,10 +2821,25 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		   !amdgpu_gmc_vram_full_visible(&adev->gmc)),
 		  "CPU update of VM recommended only for large BAR system\n");
 
-	if (vm->use_cpu_for_update)
+	if (vm->use_cpu_for_update) {
 		vm->update_funcs = &amdgpu_vm_cpu_funcs;
-	else
+	} else {
+		/* create scheduler entities for page table updates */
+		r = drm_sched_entity_init(&vm->immediate, DRM_SCHED_PRIORITY_NORMAL,
+					  adev->vm_manager.vm_pte_scheds,
+					  adev->vm_manager.vm_pte_num_scheds, NULL);
+		if (r)
+			return r;
+
+		r = drm_sched_entity_init(&vm->delayed, DRM_SCHED_PRIORITY_NORMAL,
+					  adev->vm_manager.vm_pte_scheds,
+					  adev->vm_manager.vm_pte_num_scheds, NULL);
+		if (r)
+			goto error_free_immediate;
+
 		vm->update_funcs = &amdgpu_vm_sdma_funcs;
+	}
+
 	vm->last_update = NULL;
 	vm->last_unlocked = dma_fence_get_stub();
 
@@ -2895,10 +2896,12 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 error_free_delayed:
 	dma_fence_put(vm->last_unlocked);
-	drm_sched_entity_destroy(&vm->delayed);
+	if (!vm->use_cpu_for_update)
+		drm_sched_entity_destroy(&vm->delayed);
 
 error_free_immediate:
-	drm_sched_entity_destroy(&vm->immediate);
+	if (!vm->use_cpu_for_update)
+		drm_sched_entity_destroy(&vm->immediate);
 
 	return r;
 }
@@ -3120,8 +3123,10 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	amdgpu_bo_unref(&root);
 	WARN_ON(vm->root.base.bo);
 
-	drm_sched_entity_destroy(&vm->immediate);
-	drm_sched_entity_destroy(&vm->delayed);
+	if (!vm->use_cpu_for_update) {
+		drm_sched_entity_destroy(&vm->immediate);
+		drm_sched_entity_destroy(&vm->delayed);
+	}
 
 	if (!RB_EMPTY_ROOT(&vm->va.rb_root)) {
 		dev_err(adev->dev, "still active bo inside vm\n");
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
