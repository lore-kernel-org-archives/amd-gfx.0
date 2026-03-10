Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11F61FCC9D6
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2026 08:25:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FCFA10E681;
	Tue, 10 Mar 2026 08:25:16 +0000 (UTC)
X-Greylist: delayed 32000 seconds by postgrey-1.36 at gabe;
 Tue, 10 Mar 2026 01:00:04 UTC
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net
 [13.76.78.106])
 by gabe.freedesktop.org (Postfix) with ESMTP id 7F16610E137;
 Tue, 10 Mar 2026 01:00:04 +0000 (UTC)
Received: from zju.edu.cn (unknown [10.98.66.117])
 by mtasvr (Coremail) with SMTP id _____wAH_GYHba9pz2IlAQ--.13752S3;
 Tue, 10 Mar 2026 08:59:52 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
 by mail-app2 (Coremail) with SMTP id zC_KCgDXOj0Gba9pjvsvBg--.5049S2;
 Tue, 10 Mar 2026 08:59:51 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Fan Wu <fanwu01@zju.edu.cn>
Subject: [PATCH v2] drm/amdgpu: fix PASID task_info lookup race
Date: Tue, 10 Mar 2026 00:58:48 +0000
Message-Id: <20260310005848.614611-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <01de9910-3fe6-4683-b005-f41103a9bf89@amd.com>
References: <01de9910-3fe6-4683-b005-f41103a9bf89@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zC_KCgDXOj0Gba9pjvsvBg--.5049S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?nRBQSQXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
 sfncp7Oa4RjKRyNF7NkJaR8oJN8O+r/qLFIxzcK4BNfE4wg7DuyW4+V4p9keUxvixXzpsC
 ckGy0nBMooUrrLs/JHsB5rM+H8XhqwExY4Cjs2QP
X-Coremail-Antispam: 1Uk129KBj93XoWxAr43urWfXF1ftFW8tr43urX_yoW5WF1kpF
 4fGr1YyF4kZr4aqr18Jas5Zas0yw1kZw1jkrWfGw1F9as8J3Z5Xrn7CFWUZF9xCFWkCFW2
 qrWUJ3y8WFnFgFcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUU9Cb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAF
 wI0_Cr1j6rxdM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l57
 IF6xkI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE
 14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2
 IYc2Ij64vIr41lF7xvr2IYc2Ij64vIr40E4x8a64kEw24l42xK82IYc2Ij64vIr41l4I8I
 3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxV
 WUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAF
 wI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcI
 k0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j
 6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jbo7NUUUUU=
X-Mailman-Approved-At: Tue, 10 Mar 2026 08:25:11 +0000
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

amdgpu_vm_get_task_info_pasid() currently looks up the VM from the
PASID xarray, drops the xarray lock, and only then grabs the task_info
reference through amdgpu_vm_get_task_info_vm().

Take the task_info reference directly while holding the PASID xarray
lock instead. This keeps the lookup and reference acquisition in the
same critical section.

The task_info is dropped only after the VM is removed from the PASID
mapping, so a regular kref_get() is sufficient here.

Also remove the now unnecessary amdgpu_vm_get_vm_from_pasid() helper.

Fixes: b8f67b9ddf4f ("drm/amdgpu: change vm->task_info handling")
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
v2:
- grab the task_info reference directly under the PASID xarray lock
- drop the extra local-variable comment
- use kref_get() instead of kref_get_unless_zero()
- simplify the changelog

 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 35 +++++++++++++++-----------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index f2beb980e3c3..706ca8dd65d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2468,19 +2468,6 @@ static void amdgpu_vm_destroy_task_info(struct kref *kref)
 	kfree(ti);
 }
 
-static inline struct amdgpu_vm *
-amdgpu_vm_get_vm_from_pasid(struct amdgpu_device *adev, u32 pasid)
-{
-	struct amdgpu_vm *vm;
-	unsigned long flags;
-
-	xa_lock_irqsave(&adev->vm_manager.pasids, flags);
-	vm = xa_load(&adev->vm_manager.pasids, pasid);
-	xa_unlock_irqrestore(&adev->vm_manager.pasids, flags);
-
-	return vm;
-}
-
 /**
  * amdgpu_vm_put_task_info - reference down the vm task_info ptr
  *
@@ -2527,8 +2514,26 @@ amdgpu_vm_get_task_info_vm(struct amdgpu_vm *vm)
 struct amdgpu_task_info *
 amdgpu_vm_get_task_info_pasid(struct amdgpu_device *adev, u32 pasid)
 {
-	return amdgpu_vm_get_task_info_vm(
-			amdgpu_vm_get_vm_from_pasid(adev, pasid));
+	struct amdgpu_vm *vm;
+	unsigned long flags;
+	struct amdgpu_task_info *ti = NULL;
+
+	/*
+	 * Acquire the task_info reference while holding the pasids xarray
+	 * lock to prevent a race with amdgpu_vm_fini() which removes the
+	 * PASID mapping before freeing the VM (embedded in struct amdgpu_fpriv).
+	 * Without this, the VM could be freed between xa_load() return and
+	 * the task_info dereference.
+	 */
+	xa_lock_irqsave(&adev->vm_manager.pasids, flags);
+	vm = xa_load(&adev->vm_manager.pasids, pasid);
+	if (vm && vm->task_info) {
+		ti = vm->task_info;
+		kref_get(&ti->refcount);
+	}
+	xa_unlock_irqrestore(&adev->vm_manager.pasids, flags);
+
+	return ti;
 }
 
 static int amdgpu_vm_create_task_info(struct amdgpu_vm *vm)
-- 
2.34.1

