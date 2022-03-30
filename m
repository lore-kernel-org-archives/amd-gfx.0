Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A98BC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Mar 2022 20:51:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7245510E0D5;
	Wed, 30 Mar 2022 20:51:20 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE68410E0D5
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Mar 2022 20:51:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PXJUX6vy/tVFnQPKuKYViMchKQtJGOjpJQeHf8wmRvx2w2kn1KmlEfieIWs220joGoZQwbOyl2TkpIi0kr8bD4wW6yv6oCg03sr3h6sHtg8ZdakpkGAFr6vPCUsfGFjtNbMivMyzs9yB7yQ+1QoTGRHGkC2+d7ceaaUmBSwip+WuttrYKwFN94uaMfaArzAcCKieDR/aOz3g4JU5+meD0Hul/wdLE8y3ADnv+3/OYyRQS59cxMLRNnElaQvAhNEMCvGBqQT3z4ZRgogYR+NNgZ2ruidwbl8ZP7rvtjKP52H7KaY8VvlwIKjFkZxnMLLlkIDrTDkM0Z1ILLJRI9IvgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KrL+9KzVrVsYzEDSXH2p3zZg6wBXDf9srQ4lmEXl0rI=;
 b=dxAl5EROToVfAcf9BINZEIzz9Cr0Hr+bYGJRKvWSTt3wtDgIw9iXCvGX59YM01FUo9JAIJCigP+jnGsve5EhFGo9GVtXmSF3c2eXdc9CGau+hrOuob5+hdLaOBeD3VWXWSY/7tVJNELi3ztKVSuU+B+sM2oe9BTdrVx6xqAsO/AxcmCjBuH2ee/Hp8qmM0jd9zn7ZN796gDU6Eu7rbO3FHJ53tG147w0V1ugr88iCaTrcYnq1NueeWWHmBj/zEiAnSNZOi7IefOa4H9YUfbEK/eYr+ksrnv2I6OKyp4uvF+EXHzfEysPjjIwwukYc9RZm2LWd6CZv5TrBnqaWLk79g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KrL+9KzVrVsYzEDSXH2p3zZg6wBXDf9srQ4lmEXl0rI=;
 b=mwE5DljJ+Z/PZGeCi1tp5QN1eXXL/aztKfltvwVaQ4zssBGqGP5PaXFsmKM+xmHvFillxKMvnHGK7XNoP6VjZlvOExQvzvW/2mZKzskZ1lv6yazT+ChlM7InbnH826NJaIgkNpm3zVtvXOXthQd4nR6IBrBM9bfp3Fbd14rnLC8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5138.namprd12.prod.outlook.com (2603:10b6:610:bd::17)
 by MN2PR12MB4439.namprd12.prod.outlook.com (2603:10b6:208:262::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18; Wed, 30 Mar
 2022 20:51:16 +0000
Received: from CH0PR12MB5138.namprd12.prod.outlook.com
 ([fe80::f154:80d0:31ea:b22b]) by CH0PR12MB5138.namprd12.prod.outlook.com
 ([fe80::f154:80d0:31ea:b22b%5]) with mapi id 15.20.5123.020; Wed, 30 Mar 2022
 20:51:16 +0000
Message-ID: <d1191314-478d-cacd-76b3-14a39157231c@amd.com>
Date: Wed, 30 Mar 2022 16:51:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/amdgpu: fix TLB flushing during eviction
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org, Philip.Yang@amd.com, felix.kuehling@amd.com
References: <20220330090032.16218-1-christian.koenig@amd.com>
From: philip yang <yangp@amd.com>
In-Reply-To: <20220330090032.16218-1-christian.koenig@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR02CA0068.namprd02.prod.outlook.com
 (2603:10b6:207:3d::45) To CH0PR12MB5138.namprd12.prod.outlook.com
 (2603:10b6:610:bd::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78471db3-91b9-42de-72f3-08da128f08ae
X-MS-TrafficTypeDiagnostic: MN2PR12MB4439:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB44398027D2ADCEC073DC3D99E61F9@MN2PR12MB4439.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MEiWxeJEH7y/EAcXj3LRfYuf7+6u2VKtZLTd/CUXN/21ILt30QeSUIWmkbhc69f05QA3GIlVANK2Q6PCD5yTcvIaUGOxsEwdzXl/o9u2ziD9WqB5m+7sIOON37WLTU17ASSi98qtDEF3ejmgAt1qvmvFmtXOkw+8JqHsAq3l54wF1m6rtESW1o/ipFFyHKHMaA+M5/XbeZPnKbKPmQOp7ZhQ1+9/p7KjDlxdJOAMzrA4m09XhNoL8GbNWoDMsOXYRNLw9QQbUDCXeGPenID86BaQ/yI10OJAi9xIaZuxT9glaGRjpgKHsdlXR0dXBcWcTYyr4GMpP2/uBWS0zAOaSna7meFI9I7XIpRFUhaZHUT87y+914EDtH3e/W0Xu2PHYzOg9SXfbESDZRlaRcI310hI6Qten77WRAcLwzljPALav2P6+FoRS3FL3m0K67lf8nfkazXXaudzNZDVOONM0+LyQe0hldKsgjsEJXSBinPV1ICCzBGH26syt52NOshuEyDzU6/zwEQyL32U4+hS4tMq3Cpui/3t+1qDLzQDx5oBIroFKGG+y96R6jsrnecZ8E8ZFBWFYAW9oQA/v/lRyRdS0W1z8Akk3ltjb5yTh4XsNZK1nZQA8QvFXA9xYcPf5o4vKW8KIARk4Wtd2tfrrTQ9uUPfP2LWReUJp/a8nd65xJLlssrYTB6bTafXEWe+jR0ynkFjcXfT/08XIAqjzvGWUet8TvjIPuMul0BAhUA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5138.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(26005)(316002)(8676002)(186003)(6486002)(66574015)(508600001)(4326008)(66476007)(66946007)(2616005)(66556008)(31686004)(31696002)(6512007)(38100700002)(6506007)(8936002)(2906002)(36756003)(53546011)(5660300002)(83380400001)(6636002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3NCTml0SXhtZ1U4ZkUzSXFNaXEwcHZrSko5M0F5MFNJRDI2ZFNpMnNiMlc1?=
 =?utf-8?B?M0JIZE0xaFNwU2pkc29Kd0tWcmVpSlU0VkFUdUV1Rkd0ZU9jdWFvenQ1NVky?=
 =?utf-8?B?WjNwelY0cDNaVEtxM0UrK3NRWHM4NndNVm5UeUVrUlEvYVc4UWdxYkF6U0Q4?=
 =?utf-8?B?dkliNWtFVkZhYmVnZ0E5MXU0VnB1LzlPT25XVWdSRUNpSEFDTytSYXJraFNV?=
 =?utf-8?B?czE3MXo2alV1TU5PTGhpRHpBVVNzMVlKQ0d6TWZMemdwdU80VGQ4aDR1Z3dD?=
 =?utf-8?B?bGNNYUhabEd1ZmdWWVFMUGE5RFRsT0JabjByNUNPYWZoYS9mbDdjZlNXVjAx?=
 =?utf-8?B?Y1VzRVVaQnR5VFNPNytHRFQ2WG5OOEdXQTd2Qnl0QmJydHIzVk41ZFZRVHJz?=
 =?utf-8?B?ZVpYTExwS09FMktqb0dtQ0wvNGlhUnducW9mV244SmR2Yy9LOHhNdTBtbkJE?=
 =?utf-8?B?RlZMVTFSOEhHSXpXeHphekxnUEFsaE0rdElPTHlteUJNSnh2Ukk1a0hZUDVh?=
 =?utf-8?B?Ny9OZndBNVd4MnpET1JWSTlKdG11SjZjdnA3b2p2OFl6Z3BVUG0wTmJYQXdY?=
 =?utf-8?B?akNXaHBmWjkwbzk3TmVkMFFxNUJNdGZsY1RQQVJtZlNyNTZQbnRGU3VtVEtW?=
 =?utf-8?B?Z1MySTZvbkprT0xNWFk0NXYwV040Q0lSR21tb1RqWUhTZUtBcVNRZGhMdXlG?=
 =?utf-8?B?ZXo0TEFRYzVCdlpuMzhieisxQ2owdWtleWo3V0VIMVVldjBsZGxIVHAvb0J1?=
 =?utf-8?B?OEgxNTJVdEdXWjk2RnJISW0zR013cDFQVjFlQ242endnZXVyTjA5L21lcTRI?=
 =?utf-8?B?NzVWNTZvZFpTUTZ5U1BiRWU5Q2tHMjRjakRnK3EwWFcrNmFDcEJ1RTdTb3o5?=
 =?utf-8?B?Y0p3TUdmTzVZWWZPREJsR0NraGR2bGJpeURBRDZEVE4rNFNNTXVBVHZ6M0ZQ?=
 =?utf-8?B?QkRKNVdFWVlpSU9lZklEYWk4eWhIMXJOR01oTmEvUlVIcW9EZkpYcS9Wc0kx?=
 =?utf-8?B?ZWZUMFJRL0hOQVN3Mi9HSnJMR2U0NXRITkVtQVBPZ2s0b282eFJDYnAxMmc2?=
 =?utf-8?B?VzRmQ2EvekJ4LzR3bVB6YjlFZFZpNkxqaVdQSUlZZ2J1bEZFb3FpeFdiL3Bz?=
 =?utf-8?B?Wm9TT1E1d05CMGRwcUl3Sk9RZ0U1SDEvMWtNb25RdWxyVHFmSG5SUC8wQW5y?=
 =?utf-8?B?SFFRWXVzMmRpZ2F6S0cxa2pUcUx6UjUrcGhwMDdOVjdyKzBwZ3VHbzk0eXJr?=
 =?utf-8?B?MElqVTBnaDVQdnhoWXJONVlzTFJtZmYzc3NaVmt2dDBoaHB0bGg4b1k1b2lw?=
 =?utf-8?B?ZXFKdTZNSFFCdVFoZDhkdU5Xb0FxcjlkSk1vd2hXdXd4NUxMMDJoTS91bGda?=
 =?utf-8?B?ZUVXeTllQktzRWJJZGpGcXBDR0l1ekt0WFVyRzVkaVdzTUNBU2xDVDlEaXJM?=
 =?utf-8?B?VUlkN1ZSVHd0TDFqUnpMQXV0YVMxbjhOTkxKTlIra2h2TzhsV1pFaHozSklE?=
 =?utf-8?B?L0lUZ1hsTFNmREcrMGJLa05VMFhCUGtxaHgzcnNXcGhrVGtrYURMNDlYMnhT?=
 =?utf-8?B?a0xvSS9kenhYdWVlVm9heU5CMHBNZm4xeW53dlVXNW9laGFyTzdRb3ptalRF?=
 =?utf-8?B?VEZlSmhSaWZtZXg4d1lMOWh1TkFET0hVMUo5bGN1UXFYNlczVmJtd28xU0tr?=
 =?utf-8?B?NWowUHB3Q2szbzFGR3RJbEQ2cEtWSWNxc0drUkdPb3FpT1UxM05XeDRXN1JZ?=
 =?utf-8?B?ek9tUFVDOEw2akkwWGNTOE1MRWovNFV1czVqd044T1llOHhYSnp2aGR5Smxz?=
 =?utf-8?B?SFMxVHhINTVRbTNzTDVzTTFSRzc5cGpoU3hINERnRjN6K3d0ZTNDNDEwZDRw?=
 =?utf-8?B?cW41UlVvelE0bnJOYitPL0FzT09LS09wbXBRMm9NTUZvQ2g0TGVuanlTTE9m?=
 =?utf-8?B?ZjFlYSt5Z1dNU0pIU0ZGb0RrSVdBNVBWelA3UlpzZkNUTTM3UWZVNFpWdllM?=
 =?utf-8?B?MUQrdVNoamM1c2djOU5SaytPc0puMENuNitVVEJDemd2ZUF4L2daamdhUWM0?=
 =?utf-8?B?WkNWM1dUdXU5dk03Y3paTzIwR2U2K1FhWnlKMzBLNDNyTlVVa2RRNDEwekRz?=
 =?utf-8?B?NzN4YVRybG5SOXJEcHdYd3E2ZVo5YVZWZ0tyWDJQWGthL1JEd0taNW80enY2?=
 =?utf-8?B?WC9waGs2RlhpWnRwVkgwZFA5aHF5Mjc3eXIyL1VBckpaaXo5d3c2YkRUMVRH?=
 =?utf-8?B?akR6UzUxVWFNVGtINUlDRGN1R2ZPV2FJaWRDTHpFb2JUQkVoaWJuZzlOQW9V?=
 =?utf-8?B?MmFsTFdhdWs3d0FmM0JkQVdheEpxU0MrWTg0dHpVdCtFMm9mVHpQUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78471db3-91b9-42de-72f3-08da128f08ae
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5138.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2022 20:51:16.3494 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D9vUEfbaqG40zL3SOah7Yyea6g7EckTe4qzQDw0ICqzWX/+OS81eoLrsIPwxpFRk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4439
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
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2022-03-30 05:00, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20220330090032.16218-1-christian.koenig@amd.com">
      <pre class="moz-quote-pre" wrap="">Testing the valid bit is not enough to figure out if we
need to invalidate the TLB or not.

During eviction it is quite likely that we move a BO from VRAM to GTT and
update the page tables immediately to the new GTT address.

Rework the whole function to get all the necessary parameters directly as
value.

Signed-off-by: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 63 ++++++++++++++------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 15 +++---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c   | 18 ++++----
 3 files changed, 48 insertions(+), 48 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 9992a7311387..1cac90ee3318 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -793,18 +793,19 @@ static void amdgpu_vm_tlb_seq_cb(struct dma_fence *fence,
 }
 
 /**
- * amdgpu_vm_bo_update_mapping - update a mapping in the vm page table
+ * amdgpu_vm_update_range - update a range in the vm page table
  *
- * @adev: amdgpu_device pointer of the VM
- * @bo_adev: amdgpu_device pointer of the mapped BO
- * @vm: requested vm
+ * @adev: amdgpu_device pointer to use for commands
+ * @vm: the VM to update the range
  * @immediate: immediate submission in a page fault
  * @unlocked: unlocked invalidation during MM callback
+ * @flush_tlb: trigger tlb invalidation after update completed
  * @resv: fences we need to sync to
  * @start: start of mapped range
  * @last: last mapped entry
  * @flags: flags for the entries
  * @offset: offset into nodes and pages_addr
+ * @vram_base: base for vram mappings
  * @res: ttm_resource to map
  * @pages_addr: DMA addresses to use for mapping
  * @fence: optional resulting fence
@@ -812,17 +813,14 @@ static void amdgpu_vm_tlb_seq_cb(struct dma_fence *fence,
  * Fill in the page table entries between @start and @last.
  *
  * Returns:
- * 0 for success, -EINVAL for failure.
+ * 0 for success, negative erro code for failure.
  */
-int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
-				struct amdgpu_device *bo_adev,
-				struct amdgpu_vm *vm, bool immediate,
-				bool unlocked, struct dma_resv *resv,
-				uint64_t start, uint64_t last,
-				uint64_t flags, uint64_t offset,
-				struct ttm_resource *res,
-				dma_addr_t *pages_addr,
-				struct dma_fence **fence)
+int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+			   bool immediate, bool unlocked, bool flush_tlb,
+			   struct dma_resv *resv, uint64_t start, uint64_t last,
+			   uint64_t flags, uint64_t offset, uint64_t vram_base,
+			   struct ttm_resource *res, dma_addr_t *pages_addr,
+			   struct dma_fence **fence)
 {
 	struct amdgpu_vm_update_params params;
 	struct amdgpu_vm_tlb_seq_cb *tlb_cb;
@@ -910,8 +908,7 @@ int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
 			}
 
 		} else if (flags &amp; (AMDGPU_PTE_VALID | AMDGPU_PTE_PRT)) {
-			addr = bo_adev-&gt;vm_manager.vram_base_offset +
-				cursor.start;
+			addr = vram_base + cursor.start;
 		} else {
 			addr = 0;
 		}
@@ -927,7 +924,7 @@ int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
 
 	r = vm-&gt;update_funcs-&gt;commit(&amp;params, fence);
 
-	if (!(flags &amp; AMDGPU_PTE_VALID) || params.table_freed) {
+	if (flush_tlb || params.table_freed) {</pre>
    </blockquote>
    <p>All change look good to me, but when I look at previous changes
      again, kfd_ioctl_map_memory_to_gpu is not correct now, as this
      should flush TLB if (!kfd_flush_tlb_after_unmap(dev)).</p>
    <p> To fix it, seems we need beow change, then pass flush_tlb flag
      via kfd_ioctl_map_memory_to_gpu -&gt; map_bo_to_gpuvm -&gt;
      update_gpuvm_pte -&gt; amdgpu_vm_bo_update<br>
    </p>
    <p>-int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct
      amdgpu_bo_va *bo_va,<br>
      &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; bool clear)</p>
    <p>-&nbsp;&nbsp;&nbsp; bool flush_tlb = clear;<br>
      <br>
    </p>
    <p>+int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct
      amdgpu_bo_va *bo_va,<br>
      &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; bool clear, bool flush_tlb)</p>
    <p>+ flush_tlb |= clear;</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:20220330090032.16218-1-christian.koenig@amd.com">
      <pre class="moz-quote-pre" wrap="">
 		tlb_cb-&gt;vm = vm;
 		if (!fence || !*fence ||
 		    dma_fence_add_callback(*fence, &amp;tlb_cb-&gt;cb,
@@ -1010,9 +1007,10 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 	dma_addr_t *pages_addr = NULL;
 	struct ttm_resource *mem;
 	struct dma_fence **last_update;
+	bool flush_tlb = clear;
 	struct dma_resv *resv;
+	uint64_t vram_base;
 	uint64_t flags;
-	struct amdgpu_device *bo_adev = adev;
 	int r;
 
 	if (clear || !bo) {
@@ -1037,14 +1035,18 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 	}
 
 	if (bo) {
+		struct amdgpu_device *bo_adev = adev;
+
 		flags = amdgpu_ttm_tt_pte_flags(adev, bo-&gt;tbo.ttm, mem);
 
 		if (amdgpu_bo_encrypted(bo))
 			flags |= AMDGPU_PTE_TMZ;
 
 		bo_adev = amdgpu_ttm_adev(bo-&gt;tbo.bdev);
+		vram_base = bo_adev-&gt;vm_manager.vram_base_offset;
 	} else {
 		flags = 0x0;
+		vram_base = 0;
 	}
 
 	if (clear || (bo &amp;&amp; bo-&gt;tbo.base.resv ==
@@ -1054,7 +1056,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 		last_update = &amp;bo_va-&gt;last_pt_update;
 
 	if (!clear &amp;&amp; bo_va-&gt;base.moved) {
-		bo_va-&gt;base.moved = false;
+		flush_tlb = true;
 		list_splice_init(&amp;bo_va-&gt;valids, &amp;bo_va-&gt;invalids);
 
 	} else if (bo_va-&gt;cleared != clear) {
@@ -1077,11 +1079,11 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 
 		trace_amdgpu_vm_bo_update(mapping);
 
-		r = amdgpu_vm_bo_update_mapping(adev, bo_adev, vm, false, false,
-						resv, mapping-&gt;start,
-						mapping-&gt;last, update_flags,
-						mapping-&gt;offset, mem,
-						pages_addr, last_update);
+		r = amdgpu_vm_update_range(adev, vm, false, false, flush_tlb,
+					   resv, mapping-&gt;start, mapping-&gt;last,
+					   update_flags, mapping-&gt;offset,
+					   vram_base, mem, pages_addr,
+					   last_update);
 		if (r)
 			return r;
 	}
@@ -1104,6 +1106,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 
 	list_splice_init(&amp;bo_va-&gt;invalids, &amp;bo_va-&gt;valids);
 	bo_va-&gt;cleared = clear;
+	bo_va-&gt;base.moved = false;
 
 	if (trace_amdgpu_vm_bo_mapping_enabled()) {
 		list_for_each_entry(mapping, &amp;bo_va-&gt;valids, list)
@@ -1272,10 +1275,10 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
 		    mapping-&gt;start &lt; AMDGPU_GMC_HOLE_START)
 			init_pte_value = AMDGPU_PTE_DEFAULT_ATC;
 
-		r = amdgpu_vm_bo_update_mapping(adev, adev, vm, false, false,
-						resv, mapping-&gt;start,
-						mapping-&gt;last, init_pte_value,
-						0, NULL, NULL, &amp;f);
+		r = amdgpu_vm_update_range(adev, vm, false, false, true, resv,
+					   mapping-&gt;start, mapping-&gt;last,
+					   init_pte_value, 0, 0, NULL, NULL,
+					   &amp;f);
 		amdgpu_vm_free_mapping(adev, vm, mapping, f);
 		if (r) {
 			dma_fence_put(f);
@@ -2519,8 +2522,8 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 		goto error_unlock;
 	}
 
-	r = amdgpu_vm_bo_update_mapping(adev, adev, vm, true, false, NULL, addr,
-					addr, flags, value, NULL, NULL, NULL);
+	r = amdgpu_vm_update_range(adev, vm, true, false, false, NULL, addr,
+				   addr, flags, value, 0, NULL, NULL, NULL);
 	if (r)
 		goto error_unlock;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 6b7682fe84f8..1a814fbffff8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -402,15 +402,12 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
 			   struct amdgpu_vm *vm);
 void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
 			    struct amdgpu_vm *vm, struct amdgpu_bo *bo);
-int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
-				struct amdgpu_device *bo_adev,
-				struct amdgpu_vm *vm, bool immediate,
-				bool unlocked, struct dma_resv *resv,
-				uint64_t start, uint64_t last,
-				uint64_t flags, uint64_t offset,
-				struct ttm_resource *res,
-				dma_addr_t *pages_addr,
-				struct dma_fence **fence);
+int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+			   bool immediate, bool unlocked, bool flush_tlb,
+			   struct dma_resv *resv, uint64_t start, uint64_t last,
+			   uint64_t flags, uint64_t offset, uint64_t vram_base,
+			   struct ttm_resource *res, dma_addr_t *pages_addr,
+			   struct dma_fence **fence);
 int amdgpu_vm_bo_update(struct amdgpu_device *adev,
 			struct amdgpu_bo_va *bo_va,
 			bool clear);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 27533f6057e0..907b02045824 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1188,9 +1188,9 @@ svm_range_unmap_from_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 	pr_debug(&quot;[0x%llx 0x%llx]\n&quot;, start, last);
 
-	return amdgpu_vm_bo_update_mapping(adev, adev, vm, false, true, NULL,
-					   start, last, init_pte_value, 0,
-					   NULL, NULL, fence);
+	return amdgpu_vm_update_range(adev, vm, false, true, true, NULL, start,
+				      last, init_pte_value, 0, 0, NULL, NULL,
+				      fence);
 }
 
 static int
@@ -1277,12 +1277,12 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
 			 (last_domain == SVM_RANGE_VRAM_DOMAIN) ? 1 : 0,
 			 pte_flags);
 
-		r = amdgpu_vm_bo_update_mapping(adev, bo_adev, vm, false, false,
-						NULL, last_start,
-						prange-&gt;start + i, pte_flags,
-						last_start - prange-&gt;start,
-						NULL, dma_addr,
-						&amp;vm-&gt;last_update);
+		r = amdgpu_vm_update_range(adev, vm, false, false, false, NULL,
+					   last_start, prange-&gt;start + i,
+					   pte_flags,
+					   last_start - prange-&gt;start,
+					   bo_adev-&gt;vm_manager.vram_base_offset,
+					   NULL, dma_addr, &amp;vm-&gt;last_update);
 
 		for (j = last_start - prange-&gt;start; j &lt;= i; j++)
 			dma_addr[j] |= last_domain;
</pre>
    </blockquote>
  </body>
</html>
