Return-Path: <SRS0=KKXi=LR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C379C4743C
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Jun 2021 07:56:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E86261185
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Jun 2021 07:56:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E86261185
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C329C6E08C;
	Wed, 23 Jun 2021 07:56:45 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2045.outbound.protection.outlook.com [40.107.101.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EEF86E064
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Jun 2021 07:56:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QayrCZbOaPxskyBYp3cyGWOel917JQ6mdV9hq15HEFXWPTrO/JhpmDMBAbmo61wC30yngxxKI2+wOsmn7SADoGgBVcZvdgw92169GUEZRpCYi+vfJoevHIOJWkOiitJaekgT2jww+I6PjQaMChKFrQSkYxDAuI8scXricmmnp4Sk4UYqzRco90Ih4NQIMsSJWQu8JkvFcAS/kZ/G72vdmlzlrzfuipyWbJ+yajeRNppR1riKpwgiWD0mimdp0Xk1zk8YFloMq8fA+hnrqTXNxXcw98BZsOfcHOvxt/QdHRHLbcNGrL/isE8MIgLyWNgaslq7haLQ/8IDvp8h+vWlsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uh7LK5ggIT3FvRRuYzQRO3Qr24eaXKn7lwuxhBelpIc=;
 b=EeyhDh/HEuaoTq2syhp3h8c9ZtvNaOEwxKb1w4b+jRbpBAxREcHLvifPZo2hnlLgQB6t+WQTg9GVhldJui6VsXgAPpdXWQKtaKm41xI6ql87+dCL2Ahj2UYQvxWJuxCfeANAbJBvfwEUtCQ2Wift4NHyE42HcB0m+uLVgkRg2kdKuOeXVO15EB5v9n0L8a8dmrEvsbaz4nZAc/dpcFQHYxoXJsd9ccQ5kW0Z7yvy0bA0Yh5oYQnFKijKRvhlUhwGNduF7eYAwLfelxYOHrIU3Rvx0ItCJw7qMMFxKeJ62u0S89+3E2EXJrbYvZTzebE2kwymJGYhJFGcDNkBjuVFVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uh7LK5ggIT3FvRRuYzQRO3Qr24eaXKn7lwuxhBelpIc=;
 b=fUqXmzlzUMXNMx1PLZEGRdYuDKTgPyf/TljhsiqRK0byHSXNb+jzsMKVYMe7B6aK1pvp3kW7KdFIn14b7Van/4qkh4pne9YSTA85IahXLHh656qk1jVQouNIC73RK66eFsGVnvZNGm3ucicvDu180b2J5Sw6NnbebYYWW6LBF0I=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM6PR12MB5533.namprd12.prod.outlook.com (2603:10b6:5:1bc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Wed, 23 Jun
 2021 07:56:42 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::901b:72bb:a15:2a68]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::901b:72bb:a15:2a68%4]) with mapi id 15.20.4264.019; Wed, 23 Jun 2021
 07:56:42 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/1] drm/amdgpu: cleanup pasid handling
Date: Wed, 23 Jun 2021 09:56:27 +0200
Message-Id: <20210623075627.14797-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.32.0
X-Originating-IP: [217.86.115.200]
X-ClientProxiedBy: PR0P264CA0195.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1f::15) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.115.200) by
 PR0P264CA0195.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1f::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.18 via Frontend Transport; Wed, 23 Jun 2021 07:56:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5649d982-9f4b-4d09-376e-08d9361c709f
X-MS-TrafficTypeDiagnostic: DM6PR12MB5533:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB553364897C214781C25116A88B089@DM6PR12MB5533.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hA68+gXPQiZ39SnGHDpVsOhoN2NVnnZyB5395IQ20e8sg3zr13Osx69tg947yubkm2zWKMO6oCGq0MWDiBu2Jaj0T0CUON4OhAghGj+oekbqpdFvXLbmj9O2Dk9TQMwBTq5z+/IcRPu3Y4SfAg5bAhhj/nz9FdyDAUsVYiH5p7r7oaekF8ZUrz4aOCUwb9HmBJ7bO3cg26g9+jSArJ+mZt2teVTMYF8AZa0CHNTJyrphQMiMiv8ut8FUl0YORvlmNMxisFDCzdB8zztJ6Dnfm+2ZMlKb0/DZLTBYMibocv3+sqsfVekGH8bK1sfL13Djmiul/Ejl0qe5AWDT9oMYRqDyFRZnfjdAjhURqF+s+0d8hpb3i+jbbchqOBMD6NVqaVdZ5WDl6OAi855d9FDin16BAMwGA6zgkkvhDSchuoZnwgtk3p1ZjJiwciPaLpHg9FvAZ9asLmU1Qkw1np7hqo+W3C+Y0xHGRA9GiYD/l91XWFGAN1xduz44FFM/7T1YBDdYNFL2b6a425mk0jEIoaWHm7qIVbHrPvAGSOTG4h16tYiokQ9379n3XNIssK8ZA/w0KrYFzup04ZeN11I5wgkgfSpd5WKLzfnVHwJcFCgYWgtimZt2Zttj9w3XszkPmmR1F0hDQEQwRPM7znD5yw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(6506007)(52116002)(26005)(8676002)(16526019)(66556008)(44832011)(6486002)(66476007)(66946007)(956004)(36756003)(316002)(2616005)(8936002)(6512007)(186003)(86362001)(478600001)(1076003)(4326008)(5660300002)(6666004)(83380400001)(6916009)(38350700002)(38100700002)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D6sjHBOPZzUaKaDteszhOSDdexdDmVDUebpUCCrMp10zPWHFPQYzHVGtQ/P6?=
 =?us-ascii?Q?G7cMWaXF9+6UUkcNpVHiYA/cNNpZHcW2LrQ281N4pJh5zAQ+0wf6qY6qIxRL?=
 =?us-ascii?Q?mbYPUNPnqInZctquXuYDudm5J7IKWQRFqb1x+ktMjtdVfz8NBgzMbo0XsmP5?=
 =?us-ascii?Q?yA5KPmZo2gBwtpjWj6eOlvSPNMSyHqjKTsd1TNmIfCHtMPl06QD6kEO3kdx1?=
 =?us-ascii?Q?7vaquRlNmYPYsPvI45BqfkUW+swSTMgZ+W5yWFd08UB8Sh2d2bBsVgRu72uS?=
 =?us-ascii?Q?lwxoSLOl5TYW3Xd+d/VmD7EDMAbA5mR56OuDSOYxp/jFU7LLhI0t5gmyBm6S?=
 =?us-ascii?Q?orcL7VwS9aulCzNjaFkI6MQNTvSV75mUd0+9ZW+nw7Ao4DJxiYI0Ciu0X1tM?=
 =?us-ascii?Q?53RHn4ssGpMWdy7ggeVAf8HUYUFaHtMPRAUAMLNT8PqUoYmfiIJOAZMUrM78?=
 =?us-ascii?Q?1heI/sJMxOd+ANXbbsxGUwy6GJU4FSCYarkV9iLHP7UVo1ziff2qkG4jfej8?=
 =?us-ascii?Q?JGb/m9NvFq6QKPOtOV0CAVW8+gLOAza2lQIqNSAPALPo+Mc7w4r/hMVLV2wX?=
 =?us-ascii?Q?uB0W9lG/fPp7aGjX36hp4U1zlkzN91wZeKsjH/yrICfC6MvEqikeCb0ojFc/?=
 =?us-ascii?Q?Fe7/YwjTAG+Qfoj03SJXp43AErWERgrYvqP4Zl+GUKoWPN5JsOB/Y31Ee0a8?=
 =?us-ascii?Q?oRXPLLUAG87a1MI8gu8luP6F9hPmJpb9QRhiYZ4wzX0ZjDYjtDYtULAYetle?=
 =?us-ascii?Q?em1GIV9+wG+5aleCbxxYydu5NpToqAtjt/wUNkxqGgOByqr719nLcJ33Q71e?=
 =?us-ascii?Q?ah9TS9CezwvAUQIuLOqVvdxsov2nDymY2zPRBJNpqBmm9keXmnvtuGVMOrFA?=
 =?us-ascii?Q?wWUcBGN34YBXfjpghPDAiQftbWvJyatk9y01oy3J/43NeDeP8wyyTCD/Y4YJ?=
 =?us-ascii?Q?mFDy7pufP+cO6qRNj7vPyfh9VMdks27epaKLiJoQACqBjsT0Un4zMR94Cmat?=
 =?us-ascii?Q?TrcAenGenUKeq4cnMIh6dbSwrja8sVMkUGV9FYhLb+Y/UkpnstymHzvX8Bab?=
 =?us-ascii?Q?EKN95yPe8uxLkeZFJ+9Hj7NQarwf+ZL3uwrIzDEtJV3qM0Ni/UyxQxyyiqtW?=
 =?us-ascii?Q?+bXmi43xsSHSRQj/aE/pxhYh74uHfQK+nivaxLkfd9DVvJvyERmN4Ia8IeiN?=
 =?us-ascii?Q?47bZHRN8MQ1MaYxR1C3qyiQQj9Lj/qGZ1aGY8pMx57vqI5F5XXj1hwi+Ce7F?=
 =?us-ascii?Q?e71ZU4U5grgafQ3Op9xviHYbKEyrynpf6pcLQ45RDT1IcylVqlRyb40UBes9?=
 =?us-ascii?Q?uas7A5SuRlRB/9hX9V3IHO65?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5649d982-9f4b-4d09-376e-08d9361c709f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2021 07:56:42.8910 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pPLQERz6DvJhpuPREffCio7nLObiiYUxhonAtw2i3gT/erhQx/N/LcPxMwkJ2HVVQdKQW+7Irx163WPqOEdjbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5533
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
Cc: Felix.Kuehling@amd.com, Nirmoy Das <nirmoy.das@amd.com>,
 Christian.Koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Cleanup code related to vm pasid by adding helper functions.
Also replace idr with xarray as we actually need hash functionality.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 130 ++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |   3 +-
 2 files changed, 62 insertions(+), 71 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 63975bda8e76..abba1e2de264 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -87,6 +87,45 @@ struct amdgpu_prt_cb {
 	struct dma_fence_cb cb;
 };
 
+static int amdgpu_vm_pasid_insert(struct amdgpu_device *adev,
+				  struct amdgpu_vm *vm,
+				  unsigned long pasid,
+				  unsigned int *vm_pasid)
+{
+	unsigned long flags;
+	int r;
+
+	if (!pasid)
+		return 0;
+
+	xa_lock_irqsave(&adev->vm_manager.pasids, flags);
+	r = xa_err(__xa_store(&adev->vm_manager.pasids, pasid, vm, GFP_ATOMIC));
+	xa_unlock_irqrestore(&adev->vm_manager.pasids, flags);
+	if (r < 0)
+		return r;
+	if (vm_pasid)
+		*vm_pasid = pasid;
+
+	return 0;
+}
+
+static void amdgpu_vm_pasid_remove(struct amdgpu_device *adev,
+				   unsigned long pasid,
+				   unsigned int *vm_pasid)
+{
+	unsigned long flags;
+
+	if (!pasid)
+		return;
+
+	xa_lock_irqsave(&adev->vm_manager.pasids, flags);
+	__xa_erase(&adev->vm_manager.pasids, pasid);
+	xa_unlock_irqrestore(&adev->vm_manager.pasids, flags);
+
+	if (vm_pasid)
+		*vm_pasid = 0;
+}
+
 /*
  * vm eviction_lock can be taken in MMU notifiers. Make sure no reclaim-FS
  * happens while holding this lock anywhere to prevent deadlocks when
@@ -2940,18 +2979,9 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, u32 pasid)
 
 	amdgpu_bo_unreserve(vm->root.bo);
 
-	if (pasid) {
-		unsigned long flags;
-
-		spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
-		r = idr_alloc(&adev->vm_manager.pasid_idr, vm, pasid, pasid + 1,
-			      GFP_ATOMIC);
-		spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
-		if (r < 0)
-			goto error_free_root;
-
-		vm->pasid = pasid;
-	}
+	r = amdgpu_vm_pasid_insert(adev, vm, pasid, &vm->pasid);
+	if (r)
+		goto error_free_root;
 
 	INIT_KFIFO(vm->faults);
 
@@ -3038,19 +3068,9 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	r = amdgpu_vm_check_clean_reserved(adev, vm);
 	if (r)
 		goto unreserve_bo;
-
-	if (pasid) {
-		unsigned long flags;
-
-		spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
-		r = idr_alloc(&adev->vm_manager.pasid_idr, vm, pasid, pasid + 1,
-			      GFP_ATOMIC);
-		spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
-
-		if (r == -ENOSPC)
-			goto unreserve_bo;
-		r = 0;
-	}
+	r = amdgpu_vm_pasid_insert(adev, vm, pasid, NULL);
+	if (r)
+		goto unreserve_bo;
 
 	/* Check if PD needs to be reinitialized and do it before
 	 * changing any other state, in case it fails.
@@ -3089,35 +3109,23 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	vm->is_compute_context = true;
 
 	if (vm->pasid) {
-		unsigned long flags;
-
-		spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
-		idr_remove(&adev->vm_manager.pasid_idr, vm->pasid);
-		spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
-
 		/* Free the original amdgpu allocated pasid
 		 * Will be replaced with kfd allocated pasid
 		 */
 		amdgpu_pasid_free(vm->pasid);
-		vm->pasid = 0;
+		amdgpu_vm_pasid_remove(adev, vm->pasid, &vm->pasid);
 	}
 
 	/* Free the shadow bo for compute VM */
 	amdgpu_bo_unref(&to_amdgpu_bo_vm(vm->root.bo)->shadow);
-
 	if (pasid)
 		vm->pasid = pasid;
 
 	goto unreserve_bo;
 
 free_idr:
-	if (pasid) {
-		unsigned long flags;
+	amdgpu_vm_pasid_remove(adev, pasid, NULL);
 
-		spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
-		idr_remove(&adev->vm_manager.pasid_idr, pasid);
-		spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
-	}
 unreserve_bo:
 	amdgpu_bo_unreserve(vm->root.bo);
 	return r;
@@ -3133,14 +3141,7 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
  */
 void amdgpu_vm_release_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 {
-	if (vm->pasid) {
-		unsigned long flags;
-
-		spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
-		idr_remove(&adev->vm_manager.pasid_idr, vm->pasid);
-		spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
-	}
-	vm->pasid = 0;
+	amdgpu_vm_pasid_remove(adev, vm->pasid, &vm->pasid);
 	vm->is_compute_context = false;
 }
 
@@ -3164,15 +3165,7 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 
 	root = amdgpu_bo_ref(vm->root.bo);
 	amdgpu_bo_reserve(root, true);
-	if (vm->pasid) {
-		unsigned long flags;
-
-		spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
-		idr_remove(&adev->vm_manager.pasid_idr, vm->pasid);
-		spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
-		vm->pasid = 0;
-	}
-
+	amdgpu_vm_pasid_remove(adev, vm->pasid, &vm->pasid);
 	dma_fence_wait(vm->last_unlocked, false);
 	dma_fence_put(vm->last_unlocked);
 
@@ -3254,8 +3247,7 @@ void amdgpu_vm_manager_init(struct amdgpu_device *adev)
 	adev->vm_manager.vm_update_mode = 0;
 #endif
 
-	idr_init(&adev->vm_manager.pasid_idr);
-	spin_lock_init(&adev->vm_manager.pasid_lock);
+	xa_init_flags(&adev->vm_manager.pasids, XA_FLAGS_LOCK_IRQ);
 }
 
 /**
@@ -3267,8 +3259,8 @@ void amdgpu_vm_manager_init(struct amdgpu_device *adev)
  */
 void amdgpu_vm_manager_fini(struct amdgpu_device *adev)
 {
-	WARN_ON(!idr_is_empty(&adev->vm_manager.pasid_idr));
-	idr_destroy(&adev->vm_manager.pasid_idr);
+	WARN_ON(!xa_empty(&adev->vm_manager.pasids));
+	xa_destroy(&adev->vm_manager.pasids);
 
 	amdgpu_vmid_mgr_fini(adev);
 }
@@ -3337,13 +3329,13 @@ void amdgpu_vm_get_task_info(struct amdgpu_device *adev, u32 pasid,
 	struct amdgpu_vm *vm;
 	unsigned long flags;
 
-	spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
+	xa_lock_irqsave(&adev->vm_manager.pasids, flags);
 
-	vm = idr_find(&adev->vm_manager.pasid_idr, pasid);
+	vm = xa_load(&adev->vm_manager.pasids, pasid);
 	if (vm)
 		*task_info = vm->task_info;
 
-	spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
+	xa_unlock_irqrestore(&adev->vm_manager.pasids, flags);
 }
 
 /**
@@ -3385,15 +3377,15 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 	struct amdgpu_vm *vm;
 	int r;
 
-	spin_lock_irqsave(&adev->vm_manager.pasid_lock, irqflags);
-	vm = idr_find(&adev->vm_manager.pasid_idr, pasid);
+	xa_lock_irqsave(&adev->vm_manager.pasids, irqflags);
+	vm = xa_load(&adev->vm_manager.pasids, pasid);
 	if (vm) {
 		root = amdgpu_bo_ref(vm->root.bo);
 		is_compute_context = vm->is_compute_context;
 	} else {
 		root = NULL;
 	}
-	spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, irqflags);
+	xa_unlock_irqrestore(&adev->vm_manager.pasids, irqflags);
 
 	if (!root)
 		return false;
@@ -3411,11 +3403,11 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 		goto error_unref;
 
 	/* Double check that the VM still exists */
-	spin_lock_irqsave(&adev->vm_manager.pasid_lock, irqflags);
-	vm = idr_find(&adev->vm_manager.pasid_idr, pasid);
+	xa_lock_irqsave(&adev->vm_manager.pasids, irqflags);
+	vm = xa_load(&adev->vm_manager.pasids, pasid);
 	if (vm && vm->root.bo != root)
 		vm = NULL;
-	spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, irqflags);
+	xa_unlock_irqrestore(&adev->vm_manager.pasids, irqflags);
 	if (!vm)
 		goto error_unlock;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index ddb85a85cbba..31c467764162 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -359,8 +359,7 @@ struct amdgpu_vm_manager {
 	/* PASID to VM mapping, will be used in interrupt context to
 	 * look up VM of a page fault
 	 */
-	struct idr				pasid_idr;
-	spinlock_t				pasid_lock;
+	struct xarray				pasids;
 };
 
 struct amdgpu_bo_va_mapping;
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
