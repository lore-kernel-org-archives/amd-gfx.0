Return-Path: <SRS0=VIdG=L2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC2CC11F69
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Jul 2021 09:25:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A9C9611C0
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Jul 2021 09:25:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A9C9611C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6D766E086;
	Fri,  2 Jul 2021 09:25:40 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2056.outbound.protection.outlook.com [40.107.100.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C6946E082
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Jul 2021 09:25:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R+fIm2JvzrNIWvZteIG67eLuK3IwOgxu3uivheWTk+fqcpglja5VNHyl91L8XV6907eWUYwOi1hNsy9uTlNtu82GdQL9kCm1CMupXg9YaCm4tMfTj417RN+d9mdejDvfzcMlKAO9YXwg/3Ebo1nWv9/DUstl2nCEjUGnmrZWb+VJB2H7KX6Fdr4GVKlw8JhtlS3K5TXhlq/kl28y8u1gh+XuN6uu72At3kdPhOOKR0N4M6sZHMm3qR2Iew9dGLuivGLWMcwjBDMWvlGdnRHHR9kI+6Z93J/LboN7OSRpICHGNYKiBYYNPs5troJ/BuHDgQNjb4rFDj7x1l84Agz8Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CVM9kQxU5BpbwLQ+DxivHxek1cT2oTnkiHRWKpE+deY=;
 b=Xj40Oi5EipUSl4Se5PZLZaTw2mJtfV7e3ypwlQJ3Dljy9Jqsdvzfu6qkNEp51PotKW6AHR43lx+O0hnck5Eyne8HH+vhzJ+kDzQ8IJ9MGYTyJ+uW/Wn6bVHXVRnrqinrbQ6x4p0ZvAa6nIkJIls5FFGnAv6jG/yWrnRTnN6+B4GLP+31rbWsUwI4GlMvWwpVDCYy6EiMZYZirtCX625mLLVRzrjDe98qboOIHeU8b0i2vwmjBXBhDou0+twNennVSgMA/N290gH7Mnfw0R8CRUnLyj8rCmeTfLhhC4IA6x9j/gEpwpKcx0Pj3rycNgFnLAesh6n99tMb8KVxmtyXZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CVM9kQxU5BpbwLQ+DxivHxek1cT2oTnkiHRWKpE+deY=;
 b=t/eQE0bEVWT5I2Ei8rXQOTkIpbi5IsmqtTJYgqU3flKPYpUYZp2lliQ7awvIg6RbsCU5Lt3payfMsqwAbtuNaqFJRn8F3rw+IdbERqjmaj3CfHpCSa5vmnrmFJ2Rd1rdGihAvR1gNDiKGXi4Wn2MU+pRe8iNIus+sxIb5rxTWY8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5166.namprd12.prod.outlook.com (2603:10b6:5:395::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22; Fri, 2 Jul
 2021 09:25:35 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::fde0:6f07:7dfc:8097]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::fde0:6f07:7dfc:8097%5]) with mapi id 15.20.4287.026; Fri, 2 Jul 2021
 09:25:35 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: use xarray for storing pasid in vm
Date: Fri,  2 Jul 2021 11:25:17 +0200
Message-Id: <20210702092518.4251-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.32.0
X-Originating-IP: [217.86.108.238]
X-ClientProxiedBy: PR0P264CA0079.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:18::19) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.108.238) by
 PR0P264CA0079.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:18::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4287.22 via Frontend Transport; Fri, 2 Jul 2021 09:25:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1ad10d7-212e-4504-1ee7-08d93d3b5908
X-MS-TrafficTypeDiagnostic: DM4PR12MB5166:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB516634492D1A39FBAE63A0068B1F9@DM4PR12MB5166.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ivFb0n7WSAWuFqkZUhrsGmfORX9MckRTz5e5hUtXA9aTgrkK8SEQnYXf1vjXn/pFVGtECWuXAQ6dMG068iz3Bmp3aChERP+qp3YMb2K3n6zYmTR3G5JaiWPgIPRwr9rYtxsq5MIEjUbkwh/bgXXRkxXWgRde1XqGw7mEDlMoqLpcWKJF8y2D5BNj7LXnPUPM2fiJD351uLeZi6GPDd8Ag13hKN080+obxFDxewqbW5tXNB9dPxK5IvpM8vuGouS0skZskIb1a8lyYOGzPAHPuW/juj5eA1q1rNBx/XX/n7PV/Jwd7xSoS/rkgWkKCZbOrZ5suWiUNgP/eh1jFtJduoI2S8+KzKtXb8V2z60S5PnWju9YKECVVPhL2d2JTfTiY56kkJ/aV9aGz+8aEKM1xoV+UociotnrkZ7GOGxqlWImiHudYeYoQRLDYBl62LWpFbVCVG+C9a8d1MXMQJErIt8Fj/xWgAieF3G2hAS6toUs5Rb6OUFNlnK1D2u244FJyaTqRCqpwKjNDh0+Cnzav0IHj22I+8g/IV0gbdmVvb/AM3e6+cidGoEIoCg2fr3qc31WMaFsuoZIApc1BQB3mEDkshXu1TQ0hSftroj0RyyPMFZhLsXxDfoF3hT6ZqZs9LLR7YOkjhtBE8B7Xj0L9phuaDN39hMln1PaO21LGMKIn6taA44Xo6ZjuXoE3n8JzsG0csf5AdhM5CJUikqX9g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(366004)(136003)(396003)(376002)(66946007)(66556008)(6512007)(66476007)(6506007)(5660300002)(2616005)(86362001)(6486002)(956004)(8936002)(83380400001)(1076003)(4326008)(8676002)(52116002)(6916009)(36756003)(6666004)(186003)(44832011)(16526019)(2906002)(316002)(38350700002)(38100700002)(26005)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J7b18D5x6aq0PN/RIA+tPu4onBMxahP+awFQFlb/y7wkV/G24+DxU/tJdlqc?=
 =?us-ascii?Q?GbY0MZn98JawgEHR57vCnlUTaP7ClfVMS26Zwi98sac/RBxL2IXVdES4ro8j?=
 =?us-ascii?Q?Tf/rd7okEdcMmaEA/+bUbrfZurA6L0qPauG4Sl2sM5rJ9Na1MbVBzO+CGRwL?=
 =?us-ascii?Q?uxd9bmnxtOE4zyXyG7WlrlfIU8aRv26bXilTYPY4bZJbkCkKf1S7BK8OltI+?=
 =?us-ascii?Q?27HigA0frt7hlagr620shfUE32BaXQmflfQ45lp+18Cl4Z/QuwjiI7R5Bmec?=
 =?us-ascii?Q?kxagp5ikVDfXm6fYBuopweHRvoiN98nLOPJxPBJ3foJxswZoTzRzaOvCZtpd?=
 =?us-ascii?Q?ERUa8W4p8OZw2tgAVmGKh9x4qYjtT1IbcYSjuBq0QcWGGrycMqUC4aQuxCk1?=
 =?us-ascii?Q?OLyBIfhkGNhEJifSKcBUwAg9ddRfKsAH3m67/XiFE21Ygt+tGwlo8senlfy2?=
 =?us-ascii?Q?BKm0SWjS+priAIexDpbjurO+FcOj2Npyw/NMMjPsYgWAjOwz3ytQ9mhFDeWF?=
 =?us-ascii?Q?EepAIxlCencw9X6dRbKfG3h4CpowdPrIrWffEwojgpgkzW4uV/ZfhRDG9KMu?=
 =?us-ascii?Q?2/SBo/AGVKZS9ph3N3NI7QE+zzhwycg2Xdgcw/+BStiZnzOqVNZOEaMp0NPz?=
 =?us-ascii?Q?cKpNJyeBKUiaHORgi5eMKN8uD9iXl88YD3bTcRPoRy220lVopb1PMvtJ9CPz?=
 =?us-ascii?Q?mgRCFCvWXjFoSEyK5waHmNn0SQjNVwxT65husjSDzZeRzPNGgwD1YAkBa6PN?=
 =?us-ascii?Q?hsQL3iU0Gs1Ckyl6nZXBhFsmHRlrLauwU7c7BYNLg5M/PvPhLVQrslZOowaz?=
 =?us-ascii?Q?YH5ulc5rXkalMmZkNiouy8eY8lcvwPXtZs+5XrtYVC9e6CeG4MlCElEzfhKl?=
 =?us-ascii?Q?CUEiX/kN4oKg5c5zUPvmWJEmVlgtquphafFkHof8RK1fO8MLEiIQ2dq2RG2M?=
 =?us-ascii?Q?/XRFvU6QAeZeL+APiXYhM9onkiIb+GSH7s0DsHCvjlwhk7eMIDwumBDlH+Fo?=
 =?us-ascii?Q?XDt83GXAzS49kHTgGRhkFDSVndQb8v5ROjWjz1yp0t1rQZmX2PnFjbHH5egu?=
 =?us-ascii?Q?Os/aA+L6kR6BuJY3eO0yUQ9mHrKkuAXZaNG1qVoLQ3VFdgc1qcF7knPDeZ4V?=
 =?us-ascii?Q?zNGt0EBVDhTfVVUSRe9kTeZVLEO/GV61D7zQc7wFHS0v5aqWUI9n+/HUj+PH?=
 =?us-ascii?Q?aIVfBLBoaZ+FxRvEI2qhb3hiZe7SjVSRTO/C6HPrkHIr+Z6oQ2F39BK0jvOW?=
 =?us-ascii?Q?4jEN1E0FDTwispNWGXk3FidmCtkFoPizSBAcPtMW9ebUEHJ+pzy5pLfhfsJr?=
 =?us-ascii?Q?oyByRrMXWbN9pZjvYv5MAhgE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1ad10d7-212e-4504-1ee7-08d93d3b5908
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2021 09:25:35.7905 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5dqeFdd0Aw5W66d/e8HCtW12MSAjEPOzEutx9WuaQimVtX0zXiI+5Y9D1Z8Af3IAAoO+xQN6Q4RXRwabq/xsoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5166
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

Replace idr with xarray as we actually need hash functionality.
Cleanup code related to vm pasid by adding helper function.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 149 ++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |   6 +-
 2 files changed, 73 insertions(+), 82 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 63975bda8e76..0f82df5bfa7a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -87,6 +87,46 @@ struct amdgpu_prt_cb {
 	struct dma_fence_cb cb;
 };
 
+/**
+ * amdgpu_vm_set_pasid - manage pasid and vm ptr mapping
+ *
+ * @adev: amdgpu_device pointer
+ * @vm: amdgpu_vm pointer
+ * @pasid: the pasid the VM is using on this GPU
+ *
+ * Set the pasid this VM is using on this GPU, can also be used to remove the
+ * pasid by passing in zero.
+ *
+ */
+int amdgpu_vm_set_pasid(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+			u32 pasid)
+{
+	int r;
+
+	if (vm->pasid == pasid)
+		return 0;
+
+	if (vm->pasid) {
+		r = xa_err(xa_erase_irq(&adev->vm_manager.pasids, vm->pasid));
+		if (r < 0)
+			return r;
+
+		vm->pasid = 0;
+	}
+
+	if (pasid) {
+		r = xa_err(xa_store_irq(&adev->vm_manager.pasids, pasid, vm,
+					GFP_KERNEL));
+		if (r < 0)
+			return r;
+
+		vm->pasid = pasid;
+	}
+
+
+	return 0;
+}
+
 /*
  * vm eviction_lock can be taken in MMU notifiers. Make sure no reclaim-FS
  * happens while holding this lock anywhere to prevent deadlocks when
@@ -2940,18 +2980,9 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, u32 pasid)
 
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
+	r = amdgpu_vm_set_pasid(adev, vm, pasid);
+	if (r)
+		goto error_free_root;
 
 	INIT_KFIFO(vm->faults);
 
@@ -3039,18 +3070,15 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (r)
 		goto unreserve_bo;
 
-	if (pasid) {
-		unsigned long flags;
-
-		spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
-		r = idr_alloc(&adev->vm_manager.pasid_idr, vm, pasid, pasid + 1,
-			      GFP_ATOMIC);
-		spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
+	/* Free the original amdgpu allocated pasid,
+	 * will be replaced with kfd allocated pasid.
+	 */
+	if (vm->pasid)
+		amdgpu_pasid_free(vm->pasid);
 
-		if (r == -ENOSPC)
-			goto unreserve_bo;
-		r = 0;
-	}
+	r = amdgpu_vm_set_pasid(adev, vm, pasid);
+	if (r)
+		goto unreserve_bo;
 
 	/* Check if PD needs to be reinitialized and do it before
 	 * changing any other state, in case it fails.
@@ -3061,7 +3089,7 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 				       to_amdgpu_bo_vm(vm->root.bo),
 				       false);
 		if (r)
-			goto free_idr;
+			goto free_pasid_entry;
 	}
 
 	/* Update VM state */
@@ -3078,7 +3106,7 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		r = amdgpu_bo_sync_wait(vm->root.bo,
 					AMDGPU_FENCE_OWNER_UNDEFINED, true);
 		if (r)
-			goto free_idr;
+			goto free_pasid_entry;
 
 		vm->update_funcs = &amdgpu_vm_cpu_funcs;
 	} else {
@@ -3088,36 +3116,13 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	vm->last_update = NULL;
 	vm->is_compute_context = true;
 
-	if (vm->pasid) {
-		unsigned long flags;
-
-		spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
-		idr_remove(&adev->vm_manager.pasid_idr, vm->pasid);
-		spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
-
-		/* Free the original amdgpu allocated pasid
-		 * Will be replaced with kfd allocated pasid
-		 */
-		amdgpu_pasid_free(vm->pasid);
-		vm->pasid = 0;
-	}
-
 	/* Free the shadow bo for compute VM */
 	amdgpu_bo_unref(&to_amdgpu_bo_vm(vm->root.bo)->shadow);
 
-	if (pasid)
-		vm->pasid = pasid;
-
 	goto unreserve_bo;
 
-free_idr:
-	if (pasid) {
-		unsigned long flags;
-
-		spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
-		idr_remove(&adev->vm_manager.pasid_idr, pasid);
-		spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
-	}
+free_pasid_entry:
+	amdgpu_vm_set_pasid(adev, vm, 0);
 unreserve_bo:
 	amdgpu_bo_unreserve(vm->root.bo);
 	return r;
@@ -3133,14 +3138,7 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
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
+	amdgpu_vm_set_pasid(adev, vm, 0);
 	vm->is_compute_context = false;
 }
 
@@ -3164,15 +3162,7 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 
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
+	amdgpu_vm_set_pasid(adev, vm, 0);
 	dma_fence_wait(vm->last_unlocked, false);
 	dma_fence_put(vm->last_unlocked);
 
@@ -3254,8 +3244,7 @@ void amdgpu_vm_manager_init(struct amdgpu_device *adev)
 	adev->vm_manager.vm_update_mode = 0;
 #endif
 
-	idr_init(&adev->vm_manager.pasid_idr);
-	spin_lock_init(&adev->vm_manager.pasid_lock);
+	xa_init_flags(&adev->vm_manager.pasids, XA_FLAGS_LOCK_IRQ);
 }
 
 /**
@@ -3267,8 +3256,8 @@ void amdgpu_vm_manager_init(struct amdgpu_device *adev)
  */
 void amdgpu_vm_manager_fini(struct amdgpu_device *adev)
 {
-	WARN_ON(!idr_is_empty(&adev->vm_manager.pasid_idr));
-	idr_destroy(&adev->vm_manager.pasid_idr);
+	WARN_ON(!xa_empty(&adev->vm_manager.pasids));
+	xa_destroy(&adev->vm_manager.pasids);
 
 	amdgpu_vmid_mgr_fini(adev);
 }
@@ -3337,13 +3326,13 @@ void amdgpu_vm_get_task_info(struct amdgpu_device *adev, u32 pasid,
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
@@ -3385,15 +3374,15 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
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
@@ -3411,11 +3400,11 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
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
index ddb85a85cbba..bcbe362e7d5b 100644
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
@@ -375,6 +374,9 @@ extern const struct amdgpu_vm_update_funcs amdgpu_vm_sdma_funcs;
 void amdgpu_vm_manager_init(struct amdgpu_device *adev);
 void amdgpu_vm_manager_fini(struct amdgpu_device *adev);
 
+int amdgpu_vm_set_pasid(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+			u32 pasid);
+
 long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout);
 int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, u32 pasid);
 int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm, u32 pasid);
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
