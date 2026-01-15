Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9132D41144
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jan 2026 09:25:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23EEA10E719;
	Thu, 15 Jan 2026 09:25:05 +0000 (UTC)
X-Greylist: delayed 514 seconds by postgrey-1.36 at gabe;
 Thu, 15 Jan 2026 01:37:24 UTC
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
 by gabe.freedesktop.org (Postfix) with ESMTP id 0448410E07F
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jan 2026 01:37:23 +0000 (UTC)
Received: from loongson.cn (unknown [113.200.148.30])
 by gateway (Coremail) with SMTP id _____8CxacLNQmhp5gUJAA--.28796S3;
 Thu, 15 Jan 2026 09:28:45 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
 by front1 (Coremail) with SMTP id qMiowJCx2+DMQmhpNLEeAA--.63160S2;
 Thu, 15 Jan 2026 09:28:45 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Alan Liu <haoping.liu@amd.com>, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [RFC PATCH] drm/amdgpu: Avoid unnecessary Call Traces in
 amdgpu_irq_put()
Date: Thu, 15 Jan 2026 09:28:30 +0800
Message-ID: <20260115012830.31182-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCx2+DMQmhpNLEeAA--.63160S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxXr18Kr45Wr17JFWfuF1xZwc_yoW5KF48pr
 n5Jr429r48ZFy2vr1jya48ur90yw47ZF1xCr48Gr129w1rZw15J34xJF18GryUArW7Aay7
 Jr97t3yFq3WqqagCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
 vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
 jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
 x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK
 8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
 0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUzZ2-UUUUU
X-Mailman-Approved-At: Thu, 15 Jan 2026 09:24:59 +0000
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

Currently, there are many Call Traces when booting kernel on LoongArch,
here are the trimmed kernel log messages:

  amdgpu 0000:07:00.0: amdgpu: hw_init of IP block <gfx_v6_0> failed -110
  amdgpu 0000:07:00.0: amdgpu: amdgpu_device_ip_init failed
  amdgpu 0000:07:00.0: amdgpu: Fatal error during GPU init
  amdgpu 0000:07:00.0: amdgpu: amdgpu: finishing device.
  ------------[ cut here ]------------
  WARNING: drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:639 at amdgpu_irq_put+0xb0/0x140 [amdgpu], CPU#0: kworker/0:0/9
  ...
  Call Trace:
  [<90000000047a8524>] show_stack+0x64/0x190
  [<90000000047a0614>] dump_stack_lvl+0x6c/0x9c
  [<90000000047cef34>] __warn+0xa4/0x1b0
  [<90000000060a4884>] __report_bug+0xa4/0x1d0
  [<90000000060a4a88>] report_bug+0x38/0xd0
  [<90000000060df330>] do_bp+0x260/0x410
  [<90000000047a6bc0>] handle_bp+0x120/0x1c0
  [<ffff8000028bff40>] amdgpu_irq_put+0xb0/0x140 [amdgpu]
  [<ffff8000027b1a8c>] amdgpu_fence_driver_hw_fini+0x12c/0x180 [amdgpu]
  [<ffff800002f2c04c>] amdgpu_device_fini_hw+0xf0/0x3fc [amdgpu]
  [<ffff80000279e2ac>] amdgpu_driver_load_kms+0x7c/0xa0 [amdgpu]
  [<ffff800002791128>] amdgpu_pci_probe+0x298/0x810 [amdgpu]
  [<90000000054d04a4>] local_pci_probe+0x44/0xc0
  [<90000000047f4ab0>] work_for_cpu_fn+0x20/0x40
  [<90000000047f93e0>] process_one_work+0x170/0x4e0
  [<90000000047fa14c>] worker_thread+0x3ac/0x4e0
  [<9000000004806824>] kthread+0x154/0x170
  [<90000000060df5b4>] ret_from_kernel_thread+0x24/0xd0
  [<90000000047a62a4>] ret_from_kernel_thread_asm+0xc/0x88

  ---[ end trace 0000000000000000 ]---
  amdgpu 0000:07:00.0: probe with driver amdgpu failed with error -110
  amdgpu 0000:07:00.0: amdgpu: amdgpu: ttm finalized

This is because amdgpu_irq_enabled() is false in amdgpu_irq_put(), then
the condition of WARN_ON() is true.

In order to avoid the unnecessary Call Traces, it can remove the check of
amdgpu_irq_enabled() and only check atomic_read(&src->enabled_types[type]
for three reasons:

(1) The aim is to prevent refcount from being less than 0, it was added in
commit 1fa8d710573f ("drm/amdgpu: Fix desktop freezed after gpu-reset").
(2) There are already many useful failed log before the Call Trace, there
is no need to WARN_ON().
(3) The following checks in amdgpu_irq_put() are same with the checks in
amdgpu_irq_enabled(), there is no need to do the redundant operations.

	if (!adev->irq.installed)
		return -ENOENT;

	if (type >= src->num_types)
		return -EINVAL;

	if (!src->enabled_types || !src->funcs->set)
		return -EINVAL;

Cc: stable@vger.kernel.org
Fixes: 1fa8d710573f ("drm/amdgpu: Fix desktop freezed after gpu-reset")
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index 8112ffc85995..0d00a8d841b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -636,7 +636,7 @@ int amdgpu_irq_put(struct amdgpu_device *adev, struct amdgpu_irq_src *src,
 	if (!src->enabled_types || !src->funcs->set)
 		return -EINVAL;
 
-	if (WARN_ON(!amdgpu_irq_enabled(adev, src, type)))
+	if (!atomic_read(&src->enabled_types[type]))
 		return -EINVAL;
 
 	if (atomic_dec_and_test(&src->enabled_types[type]))
-- 
2.42.0

