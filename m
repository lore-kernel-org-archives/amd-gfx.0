Return-Path: <SRS0=IWiu=JT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC77C433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Apr 2021 12:36:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFC1B613F6
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Apr 2021 12:36:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFC1B613F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B0526EA6F;
	Thu, 22 Apr 2021 12:36:19 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACF476EA6F
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Apr 2021 12:36:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NFT4VmhtWkxbEqSCjM4cIXJHG5XZHWMqpcWCSSSIGvrXVEuL5CldBlRwn1g2s4WLSiISNC2w8pjb7o3258HY7o7+gQ7S6alncYrMGoeA1t+StxKXQEZ7lBD1WaBNQZKaUVnyWhLsfytVopDYMbr/ttpS1HESp4emMzle5l4KH0Xdooma7YcqyiFIKPBLECSLOOHcrji6tO0uCjDPJHdchLDlAdgy5SEZLbKwXmeUNS8tsGRxq3rQo/WCs8l+2HK9aI0lAVdvJ6wcj/1B0osnQLOaPcjRe7SaO2jLECZouIAZ94mvHLlZsZGeiN9xKZ7b5DugmgOEbxkyqAP9fLoVnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/EupyXuDnDZY8alLuMd4gEcWlzK6PGeoe14gfM9s6M=;
 b=ZJSBmL6JHgbE4cYwaawjupaBI3M/tG4HfI/GBWtb3AMJYrUHt2L1pCri/Guyksj2UDivZgTv3VQ2Oo/03TXXPR9/wOgMdhBEKvfQjBiIT4V1RAcBuITD5OUcGLTENrZglHI1PHJlP78vzIPdpt46Zp7pHqAaF4vNGmbVtBocoYGnY2Fm6GFNBSJsnHJ2BmWHMhQOG5JpwAIfThFRh3DzZs7s0UgZj3cSMwwoviSHAeHlvYy78/GNHuw3EY1jyUAra16Taa3WSQHnU6uQ21xTFzv5KRXTKxYSKpzIO0xnbrMgfzah3HVPFcE8ryPQENi6sexpsbqtvILqAkzFyo5k9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/EupyXuDnDZY8alLuMd4gEcWlzK6PGeoe14gfM9s6M=;
 b=WKhL2xfNouFZP1/FahXU6QIFIsCjPnj5TGdXbwDW1lm9sjteFZoE1ObfyepXbKFYTd3rsow22lHRGIT2vq/XfmQiHyckAsqikm68AEv7q0cbDJou468pZV/K85RdMMkRrcgJigAIoFbG/cM+njthXCE1OG6OPTOjCm3NfpNIrfo=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR1201MB0231.namprd12.prod.outlook.com (2603:10b6:910:24::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18; Thu, 22 Apr
 2021 12:36:16 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::a457:1047:3886:4630]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::a457:1047:3886:4630%9]) with mapi id 15.20.4065.022; Thu, 22 Apr 2021
 12:36:16 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: Christian.Koenig@amd.com
Subject: [PATCH 3/5] drm/amdgpu: create shadow bo using
 amdgpu_bo_create_shadow()
Date: Thu, 22 Apr 2021 14:35:43 +0200
Message-Id: <20210422123545.2389-3-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210422123545.2389-1-nirmoy.das@amd.com>
References: <20210422123545.2389-1-nirmoy.das@amd.com>
X-Originating-IP: [217.86.127.111]
X-ClientProxiedBy: AM8P190CA0008.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::13) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux.fritz.box (217.86.127.111) by
 AM8P190CA0008.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:219::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.20 via Frontend Transport; Thu, 22 Apr 2021 12:36:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5abe40aa-6375-4e16-b5c1-08d9058b38e4
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0231:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB02315084D55F1E68FA0DECAA8B469@CY4PR1201MB0231.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yoyj0nNjs5SFhw/pNq8Kaecwpo/mvLb62Y7bbh5WYzdYCzKMOd7k8umXk/ELOtY4HSeJbPf7hrvzE9wBa2624Rk3J69CPTs/DSmZ4symV4P8D1nNNPqv5yE81IABoz+HB3Nsn1MVn7smi/XUngH/xY3EMklivU7Fv+TNSxz5V6txjIiTkzyPByomKfDTSAUyB2FLri8guX/PVgb52LtY/cqoKySW/pAWFZKA7gjtGogK9/rXhQQqFrIiaiVN3nIvxpAsUVfYXmhWpD+7csC0H3zeBSgOZ1U5hKlHMs8kTeSe4Q8E546Xw+YamD1JtNB3nTtlBvAwqP3tkDEqSDxxkafbp7ImANV2R6odrkrLUQC3NM3xeX2vBqHWstJ55COLZQKybYVysHNmC0NHhiDirFBdU6JSuX3of9YN54t5w4o8HabcldEsiL73TIugUOkYs4WGALZSbKy3DaIj3ifJiT8ZCaGvF2wGzIoadoHTci0sc/MNI8WopRXp8VgCPvEci9ecOCcaoXtAvIO4E0qbghhULFAoXuilI8wJkohFMZydGxz2ZnRLf68jV8/ukcJGkQ6XQoyv1qvrjVlYE7XOYvYEN0HjQVKfDdX0Ef2irAm6Lu+CeOjRlDAt2tg72Q504WOQgjUWgRXwjehqeBYvNQ5qk/fNbUBpUTZU+vqOAso=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39840400004)(376002)(136003)(396003)(346002)(52116002)(2906002)(26005)(38100700002)(44832011)(37006003)(1076003)(16526019)(38350700002)(36756003)(6506007)(6666004)(6512007)(8676002)(956004)(5660300002)(83380400001)(186003)(2616005)(6486002)(4326008)(6636002)(34206002)(86362001)(66946007)(316002)(66556008)(66476007)(478600001)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?2zb83dGTkMQ33ZTXov17Oh3o0rECdiuIfI5lExbRFjbwD2SwmeP7gFnoRhbh?=
 =?us-ascii?Q?LT04PaFLnjKHpC4J3YBPc6iC5ap030USqGv0K2xQFQZ9z8lpCxxPyIc5e6ou?=
 =?us-ascii?Q?LvZP6SWavYOVkjhOmfVpWVrRpQrJHvK5fOPI+zLlxVw8TLGPIphJaDksAyzw?=
 =?us-ascii?Q?zouRJ23m2N97ARi2WZRZxQuppuSQ6KBjt2NMRPw+7q6BrW+tPNl0j1g64NTC?=
 =?us-ascii?Q?VOBbYWg1Pi9fWoIhikgyFJDNbR64nbV2TxupzjfBLq8+uXdc10URVpuGNGVs?=
 =?us-ascii?Q?ovpQX8vDM4iwn3VjcJbx+38sep/9m5nXEOT6d4f7IMom1ReYGGWcqNJnsRsS?=
 =?us-ascii?Q?Kd9hlUbNSrSBwol7nG7Pffi+dUGY4MQ+BFi2vyGYZGKa6appu8JNFE/leUGu?=
 =?us-ascii?Q?q6HkAiiAC7eBjvjZxSM/d2jhkGAkDAdqNThuTBej3QPR00t9EWfUhc74jASV?=
 =?us-ascii?Q?19Y4c4BIzpXaUhtQ94ZQsXsKiTy01vG8tXA+Str2lhAfFMlW7NEkX3NO3u1o?=
 =?us-ascii?Q?0BYUk/L9nmhFKvEDUY3cPSaAq16eLPhDgmFn/40RsxUejrLL3h8NmE80cPaq?=
 =?us-ascii?Q?WQDuSEYIWoSIf+9lsduF/+MKTbchvLh5oegxtrxcTh1VfunK+12SZkWIUsEg?=
 =?us-ascii?Q?2/orMHSFNo2EsbtB+kD+HOZ9Q4EVjz0NjbyO9JdoKEofHn3OcW+XCHZvWVZS?=
 =?us-ascii?Q?Klpym2fg27JvSmKzbyDf+PVEFNzPun1q2DhiTpyNfAwIXOexUBrA+hjcQjf3?=
 =?us-ascii?Q?2VLBTR/tRwdUVEOugDC2h+C2xtLqIQhsO4sZz1/jC0prWUwlnD8EiWlZIpPQ?=
 =?us-ascii?Q?DvDi/bxTWR0SfWPfkLvSk7pz2inehwB0Sb4oAkX+bFfFPql7dPySKL+EGZG+?=
 =?us-ascii?Q?OBtXbHqmX63WMxLNiOHvtnmiUifDZKu12cvSaXg4A2e/Wvd5XPPLpeyWQir9?=
 =?us-ascii?Q?10dEDFEnCseJH2NEqQhQHR+T/jnEroPsn8JlKJVNxGYbn89xHUZ/b9ItccKK?=
 =?us-ascii?Q?ilAeNbdOrftrqFnoWmTgAKFTnrdKKjTJzQ/SMqmC9UuL1XkD6VKGbANU834T?=
 =?us-ascii?Q?EEgQNa3C8kXH2fURRi6TFdpXKwuYRR/7DYKCzOzCGzhMT95MX1NRld2G3s43?=
 =?us-ascii?Q?HwDnnkpvzTtUTXMaG72aaAF6eRbwQGIvEWQgi0E3VisFlBcese4y8nHgN8iF?=
 =?us-ascii?Q?kwfGbkhwvJBNgJz4LGjP/EOaDrABcvH8GkkJspRv6cb/9TVHUqMXyBla6TLi?=
 =?us-ascii?Q?29yX/skho6iqv9sWYBfeL31+oUWVif9uiwnTYV/F0MfdlIxeDl2HQ/vBkNOQ?=
 =?us-ascii?Q?GA5cGvAjtpCySnvm+P16/x2y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5abe40aa-6375-4e16-b5c1-08d9058b38e4
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 12:36:16.4061 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eTg1VnZfgXjY/hMwmqmIe03DDSsmOGmcJSaThEjTT7ejdmBlp7gvH40m0pxoIU+wSAAe1KD76a/EMm2xaAGbXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0231
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 75 +++++++++++++++++---------
 1 file changed, 49 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 6f0a6011cb3d..0e1d08a88f54 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -850,35 +850,64 @@ static int amdgpu_vm_clear_bo(struct amdgpu_device *adev,
 }
 
 /**
- * amdgpu_vm_bo_param - fill in parameters for PD/PT allocation
+ * amdgpu_vm_bo_create - create bo for PD/PT
  *
  * @adev: amdgpu_device pointer
  * @vm: requesting vm
  * @level: the page table level
  * @immediate: use a immediate update
- * @bp: resulting BO allocation parameters
+ * @bo: pointer to the buffer object pointer
  */
-static void amdgpu_vm_bo_param(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-			       int level, bool immediate,
-			       struct amdgpu_bo_param *bp)
+static int amdgpu_vm_bo_create(struct amdgpu_device *adev,
+				struct amdgpu_vm *vm,
+				int level, bool immediate,
+				struct amdgpu_bo **bo)
 {
-	memset(bp, 0, sizeof(*bp));
+	struct amdgpu_bo_param bp;
+	bool create_shadow = false;
+	int r;
 
-	bp->size = amdgpu_vm_bo_size(adev, level);
-	bp->byte_align = AMDGPU_GPU_PAGE_SIZE;
-	bp->domain = AMDGPU_GEM_DOMAIN_VRAM;
-	bp->domain = amdgpu_bo_get_preferred_pin_domain(adev, bp->domain);
-	bp->flags = AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |
+	memset(&bp, 0, sizeof(bp));
+
+	bp.size = amdgpu_vm_bo_size(adev, level);
+	bp.byte_align = AMDGPU_GPU_PAGE_SIZE;
+	bp.domain = AMDGPU_GEM_DOMAIN_VRAM;
+	bp.domain = amdgpu_bo_get_preferred_pin_domain(adev, bp.domain);
+	bp.flags = AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |
 		AMDGPU_GEM_CREATE_CPU_GTT_USWC;
-	bp->bo_ptr_size = sizeof(struct amdgpu_bo);
+	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
 	if (vm->use_cpu_for_update)
-		bp->flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
+		bp.flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
 	else if (!vm->root.base.bo || vm->root.base.bo->shadow)
-		bp->flags |= AMDGPU_GEM_CREATE_SHADOW;
-	bp->type = ttm_bo_type_kernel;
-	bp->no_wait_gpu = immediate;
+		create_shadow = true;
+
+	bp.type = ttm_bo_type_kernel;
+	bp.no_wait_gpu = immediate;
 	if (vm->root.base.bo)
-		bp->resv = vm->root.base.bo->tbo.base.resv;
+		bp.resv = vm->root.base.bo->tbo.base.resv;
+
+
+	r = amdgpu_bo_create(adev, &bp, bo);
+	if (r)
+		return r;
+	if (!vm->is_compute_context &&
+	    !(adev->flags & AMD_IS_APU) &&
+	    create_shadow) {
+		if (!bp.resv)
+			WARN_ON(dma_resv_lock((*bo)->tbo.base.resv,
+					      NULL));
+		r = amdgpu_bo_create_shadow(adev, bp.size, *bo);
+
+		if (!bp.resv)
+			dma_resv_unlock((*bo)->tbo.base.resv);
+
+		if (r) {
+			amdgpu_bo_unref(bo);
+			return r;
+		}
+	}
+
+	return 0;
 }
 
 /**
@@ -901,7 +930,6 @@ static int amdgpu_vm_alloc_pts(struct amdgpu_device *adev,
 			       bool immediate)
 {
 	struct amdgpu_vm_pt *entry = cursor->entry;
-	struct amdgpu_bo_param bp;
 	struct amdgpu_bo *pt;
 	int r;
 
@@ -919,9 +947,7 @@ static int amdgpu_vm_alloc_pts(struct amdgpu_device *adev,
 	if (entry->base.bo)
 		return 0;
 
-	amdgpu_vm_bo_param(adev, vm, cursor->level, immediate, &bp);
-
-	r = amdgpu_bo_create(adev, &bp, &pt);
+	r = amdgpu_vm_bo_create(adev, vm, cursor->level, immediate, &pt);
 	if (r)
 		return r;
 
@@ -2785,7 +2811,6 @@ long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout)
 int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		   int vm_context, u32 pasid)
 {
-	struct amdgpu_bo_param bp;
 	struct amdgpu_bo *root;
 	int r, i;
 
@@ -2843,10 +2868,8 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	mutex_init(&vm->eviction_lock);
 	vm->evicting = false;
 
-	amdgpu_vm_bo_param(adev, vm, adev->vm_manager.root_level, false, &bp);
-	if (vm->is_compute_context)
-		bp.flags &= ~AMDGPU_GEM_CREATE_SHADOW;
-	r = amdgpu_bo_create(adev, &bp, &root);
+	r = amdgpu_vm_bo_create(adev, vm, adev->vm_manager.root_level,
+				false, &root);
 	if (r)
 		goto error_free_delayed;
 
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
