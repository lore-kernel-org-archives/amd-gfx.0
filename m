Return-Path: <SRS0=IWiu=JT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12849C433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Apr 2021 15:40:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A28556140F
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Apr 2021 15:40:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A28556140F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDFD06E2EF;
	Thu, 22 Apr 2021 15:40:41 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 560BB6E2D5
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Apr 2021 15:40:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fyD0bVW5EI6KZDaIJdiQiaNgWSKZUXoYFVxLSlATHFEiGy9iWo+mS0oZ0Pn8C03cIQbRQHoBIHWVm6BwvYJLYJOwlDzVPOSDqHQXL5gYtHXfHqjYF/fwxSZHF6zGdkmFE48osenbejmbFZ1j4PuD5Hv4KRHvN7jJp/STyTlX6X5cQMoHnwzRBK2+mGd8/WZACSuBzuUMQ9mT7DYPiDMzd30yaI/ot9XoS/9VJYeqCaS5LYSBs/fLP/Bh7kWvkn73e2QSzz+AUvgUuseHBN4D5vjHhmmVsvaGXc6o4Jy0dCsK4f0psfRnkm4WzvTHJjPW861dwCsriuVb2OrgO/ipYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQWPgV7nla9ep7dke32lNhGLyadN2iETfma8D3FVOWo=;
 b=cvsaLZtyqxrSMZCYClyca1QVfBYfQzftxt/RrftiiCkB4Y12dEErilsXT6Wpj/KgCxNViD8SMJrNXXOunNT3UomWH5Bla84vBmsNwHjnCrHtRZbqz0vqv0HbMVkdMq0sjumlLjGgsO6utXjC4ePl6rKVj2A1LI/Ve9Bu0Tf3kbKVdcUFVcToZISKHx9+qYS/gBitWoqs2u0Nh0A6yHD5UTQIAPQYp5FgGKmVh2GcjmrMbRPUqOHJv09NXMSI0YUkLYsXn2fpxZ1GAjRaWYO/7V30M+ABIMsVuU3nRhTLhOg5FVvLfC2nlOwo1kJx3tdZwRbXTRWstMP4Ff/fN9jlQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQWPgV7nla9ep7dke32lNhGLyadN2iETfma8D3FVOWo=;
 b=A0WA/Jo+7MRYB6rpYq8qczquPj/0abbAXb9gQ/4d71lqwbRKwg+v8LPc6BCc6jRkpzmCVVWPbrR31fsvyUIgpj31Cn8ge9MOgBq2ybVo1dzv0OAH/Ofat+w+i0bWglrrDO+MeBaP9qY4kxXHzxhXFb7nh1T7lvKMOdydCuxrdMg=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR12MB1173.namprd12.prod.outlook.com (2603:10b6:903:41::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Thu, 22 Apr
 2021 15:40:39 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::a457:1047:3886:4630]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::a457:1047:3886:4630%9]) with mapi id 15.20.4065.022; Thu, 22 Apr 2021
 15:40:39 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: Christian.Koenig@amd.com
Subject: [PATCH 4/6] create shadow bo using amdgpu_bo_create_shadow()
Date: Thu, 22 Apr 2021 17:40:01 +0200
Message-Id: <20210422154003.4048-4-nirmoy.das@amd.com>
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
 15.20.4065.22 via Frontend Transport; Thu, 22 Apr 2021 15:40:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3c260de-82ad-45ec-c25d-08d905a4fab0
X-MS-TrafficTypeDiagnostic: CY4PR12MB1173:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1173D16C6497D5FA365207E78B469@CY4PR12MB1173.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2dWKxgDfiieSJI7EvLiqVT+hdfLFnHsNQLslU/YQPWCUW0Ibg3LIs6hprlgX9sF/MQhAEtcG3xHBsMp8VJPvGe3vmt5ISLmKpeFh/35wp6JadOHJF30SZU8Hw1/0R/W1afm8voH5BdYkoszdkHryS+f1WHsx1V0DRsCzyn2HcvTzNulsdnaoFZJTIpwH8V47S/KuccSIDNshmzg4/jFNmtZMe4XnimTogSdYX7eydOab6uo9kXkVITOqPIR04f6Yz3+F8zMALoP5/nALd2RkgykrnBQyfuK8W4+emW3oz0NaRHPvFUvv3FUecT2XQI/7n68sk3QuDTynNfOFLkr5109NKEEj4G6h7P7E17PikQSU21++01YIXY5gOid0y/YKYj3/k1W/nj6wd90NE1nFlfZ5R/4tluGZ048QYreGfiQMIrDoWKqQPsBBYNuXxFNA3WH1HvlHDyUkijV5rZAHDrbW9CTvY1nw+IILRNau7/EbwQMKlWRJ41rAPBEfaY/9bsZWFmBOQISWzyPRmom/Tx9lH4dH6nwSOv6sOohxWrUqCX0Mdw0Hlj8jPW1MKeUOl7SaGZeqBMUAlQX+M3OFIzCLZblzFCtVF7aUiXM8jon8bRJGH3zxSYkKDIkJopJSTi2Gi4nddK2uTIbY4rflC74wzAvDBKRlTHDgD+KiMOM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(366004)(346002)(136003)(39860400002)(83380400001)(38350700002)(2906002)(38100700002)(8936002)(34206002)(6636002)(66946007)(86362001)(66476007)(66556008)(6512007)(316002)(26005)(44832011)(4326008)(6486002)(1076003)(37006003)(186003)(478600001)(52116002)(6666004)(8676002)(956004)(16526019)(2616005)(36756003)(6506007)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?RCMsj6tDWmxY5EPBD+XAKYMZBTPio3g5sdlMv4xhhM2yo+XvN+FAbLZE66Rh?=
 =?us-ascii?Q?WQDH8bo+u+GDkk/6p07LGg8AcJzPtJCHbbD9U7CndECBZxHvT76k6Xuppfqq?=
 =?us-ascii?Q?V82hethm2nmV+squlWosJyLOmSXUZvBScHi1FhKARCfjs9XvE97DV+my0M0F?=
 =?us-ascii?Q?d7FRqMGdwN8eR2KSnaNj1Bue8KciGb/4mPHEr2LNKSATHnE+LAxi71ITt6wp?=
 =?us-ascii?Q?zIEElCJUyKAF5o0RbTAzzziiAs8H92gWbz+WZWb8LU9mGFNUlJtsF2FkgI7l?=
 =?us-ascii?Q?BrbGVT9yHoGH3EBiO8wmyYo50TpIncRPLIugDmwPuqqe3A5EZueuq1AQHZ6D?=
 =?us-ascii?Q?u2R6hzZxcwqDlgLpva0s2Al7BfVi0bVypCuOtvinND9poCcCPUumrk0sR61D?=
 =?us-ascii?Q?d9a39TY5I2ZY4WsoOIVe1kATG8TxBR1rWyxbv7MD4l6RUa1Li8YREWBOEPy2?=
 =?us-ascii?Q?zrJU7FxozHND0hblHyizrw21K1hobBZlOg3/uQwJeZF3+JPkyzJjZAikjMV1?=
 =?us-ascii?Q?PL4ZS2+LCTRZYst4x5CoEZe6zz8NbUTapFJJDwM5JuNlpMxNJmX2uLx4gkIW?=
 =?us-ascii?Q?fa4S6Vm9qrIIjCHGLMublNv2/+s7WpCoFAjp75cjjHE6DP0GL8Fza/VenDfU?=
 =?us-ascii?Q?k/YIKzxNrYtCetvNxKQLzKYtGEN4SN7Wh/sv9cQ8zLedvbykk+xQ9jdVmc3G?=
 =?us-ascii?Q?s4iS61rJfYE17vBi8gx/4sBhchVPAB9MrUT0dTvbNU4tMrQ+07iBrxnNARYI?=
 =?us-ascii?Q?PlXSbci6MOLnhCboZSheuHUBA1Da4AuTq3C2aTGPnWoSceHe/phFqRcAiEjQ?=
 =?us-ascii?Q?/tDpcsKjAZqiEfL9s5tt9fLOc8+uf7UfpcAOB9AakpoS9BRv5MzYMYR4f4+7?=
 =?us-ascii?Q?lK22wssQahkkDUViK3LP1FKDk63zZaJEopmrUdwCnIJSTRlbhg+bWTghHPGa?=
 =?us-ascii?Q?oE2DzUFpo/E0bMWQcws7Kccmp9D6N9obEYUKPJiHGcH2fkFcjaOVjkAfWBy1?=
 =?us-ascii?Q?mQjxvTw0zRFOaMP9Oq+B7sdDTDmisGXUQH9jNxlHi51XtIRLLfQ8sBGYcSet?=
 =?us-ascii?Q?EwP3D+q2e7KAIFfCOesWOqAlIoorMR0E11PeLnhkvMbtXxL8kNDytTWgi4EC?=
 =?us-ascii?Q?XmvP86m8dh2KXKOc68DpeP7KWtN/k2Vgh0tV213Mv6UlrxllSHKEPlRZxjHG?=
 =?us-ascii?Q?G1SrXSin5fvOsw+oF1ItjPkBGnGxYUVuW09pUf77liFXu8MgRU8z2IvJdtVC?=
 =?us-ascii?Q?UEfpF63YQ5BWbl/Sh3F3rq0XQqQ5dTun1lXj9cs6bBaIlbMZUVQ5yPai/Fkz?=
 =?us-ascii?Q?jwjVRhnqOIWkBppYYi2sytOX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3c260de-82ad-45ec-c25d-08d905a4fab0
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 15:40:39.0158 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kSjxIJvd7MbIlKeAWjXXJbxcSSjhGtLY9XFSixel7QJhx6dzmIe56dZxAz3Bm4Xtl8ma1PjeN/ahX7Qc6M6rfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1173
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

Shadow BOs are only needed for vm code so call amdgpu_bo_create_shadow()
directly instead of depending on amdgpu_bo_create().

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 70 +++++++++++++++++---------
 1 file changed, 47 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 577148a4ffaa..bb5506ff80dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -850,35 +850,63 @@ static int amdgpu_vm_clear_bo(struct amdgpu_device *adev,
 }
 
 /**
- * amdgpu_vm_bo_param - fill in parameters for PD/PT allocation
+ * amdgpu_vm_pt_create - create bo for PD/PT
  *
  * @adev: amdgpu_device pointer
  * @vm: requesting vm
  * @level: the page table level
  * @immediate: use a immediate update
- * @bp: resulting BO allocation parameters
+ * @bo: pointer to the buffer object pointer
  */
-static void amdgpu_vm_bo_param(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+static int amdgpu_vm_pt_create(struct amdgpu_device *adev,
+			       struct amdgpu_vm *vm,
 			       int level, bool immediate,
-			       struct amdgpu_bo_param *bp)
+			       struct amdgpu_bo **bo)
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
+	r = amdgpu_bo_create(adev, &bp, bo);
+	if (r)
+		return r;
+
+	if (vm->is_compute_context && (adev->flags & AMD_IS_APU))
+		return 0;
+
+	if (!bp.resv)
+		WARN_ON(dma_resv_lock((*bo)->tbo.base.resv,
+				      NULL));
+	r = amdgpu_bo_create_shadow(adev, bp.size, *bo);
+
+	if (!bp.resv)
+		dma_resv_unlock((*bo)->tbo.base.resv);
+
+	if (r) {
+		amdgpu_bo_unref(bo);
+		return r;
+	}
+
+	return 0;
 }
 
 /**
@@ -901,7 +929,6 @@ static int amdgpu_vm_alloc_pts(struct amdgpu_device *adev,
 			       bool immediate)
 {
 	struct amdgpu_vm_pt *entry = cursor->entry;
-	struct amdgpu_bo_param bp;
 	struct amdgpu_bo *pt;
 	int r;
 
@@ -919,9 +946,7 @@ static int amdgpu_vm_alloc_pts(struct amdgpu_device *adev,
 	if (entry->base.bo)
 		return 0;
 
-	amdgpu_vm_bo_param(adev, vm, cursor->level, immediate, &bp);
-
-	r = amdgpu_bo_create(adev, &bp, &pt);
+	r = amdgpu_vm_pt_create(adev, vm, cursor->level, immediate, &pt);
 	if (r)
 		return r;
 
@@ -2784,7 +2809,6 @@ long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout)
  */
 int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, u32 pasid)
 {
-	struct amdgpu_bo_param bp;
 	struct amdgpu_bo *root;
 	int r, i;
 
@@ -2835,8 +2859,8 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, u32 pasid)
 	mutex_init(&vm->eviction_lock);
 	vm->evicting = false;
 
-	amdgpu_vm_bo_param(adev, vm, adev->vm_manager.root_level, false, &bp);
-	r = amdgpu_bo_create(adev, &bp, &root);
+	r = amdgpu_vm_pt_create(adev, vm, adev->vm_manager.root_level,
+				false, &root);
 	if (r)
 		goto error_free_delayed;
 
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
