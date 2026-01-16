Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A846D4A60E
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jan 2026 08:30:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29B5210E2BD;
	Fri, 16 Jan 2026 08:30:24 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
 by gabe.freedesktop.org (Postfix) with ESMTP id 8C79810E7D8
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jan 2026 01:20:31 +0000 (UTC)
Received: from loongson.cn (unknown [113.200.148.30])
 by gateway (Coremail) with SMTP id _____8CxVvBbkmlptGgJAA--.31382S3;
 Fri, 16 Jan 2026 09:20:28 +0800 (CST)
Received: from [10.130.40.83] (unknown [113.200.148.30])
 by front1 (Coremail) with SMTP id qMiowJBx78JYkmlpc54fAA--.65514S3;
 Fri, 16 Jan 2026 09:20:26 +0800 (CST)
Subject: Re: [RFC PATCH] drm/amdgpu: Avoid unnecessary Call Traces in
 amdgpu_irq_put()
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: Alan Liu <haoping.liu@amd.com>, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260115012830.31182-1-yangtiezhu@loongson.cn>
 <6ac02ffa-5d62-4fc7-9882-6ccf7b44eaf4@amd.com>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <0afdb83a-d2db-53d9-3b1b-253e466a5cc3@loongson.cn>
Date: Fri, 16 Jan 2026 09:20:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <6ac02ffa-5d62-4fc7-9882-6ccf7b44eaf4@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBx78JYkmlpc54fAA--.65514S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxurW8Jw48Gr18Xr43CFy3trc_yoWrWry8pr
 n5JF429r4vvry2v3srtFyUuF90kw4jvF1Skrs7Ww1j93WrArn8t34xJF48JFyUJrZrCay7
 JF93tayFvw1qqabCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1QVy3UU
 UUU==
X-Mailman-Approved-At: Fri, 16 Jan 2026 08:30:22 +0000
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

On 2026/1/15 下午9:47, Christian König wrote:
> On 1/15/26 02:28, Tiezhu Yang wrote:
>> Currently, there are many Call Traces when booting kernel on LoongArch,
>> here are the trimmed kernel log messages:
>>
>>    amdgpu 0000:07:00.0: amdgpu: hw_init of IP block <gfx_v6_0> failed -110
>>    amdgpu 0000:07:00.0: amdgpu: amdgpu_device_ip_init failed
>>    amdgpu 0000:07:00.0: amdgpu: Fatal error during GPU init
>>    amdgpu 0000:07:00.0: amdgpu: amdgpu: finishing device.
>>    ------------[ cut here ]------------
>>    WARNING: drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:639 at amdgpu_irq_put+0xb0/0x140 [amdgpu], CPU#0: kworker/0:0/9
>>    ...
>>    Call Trace:
>>    [<90000000047a8524>] show_stack+0x64/0x190
>>    [<90000000047a0614>] dump_stack_lvl+0x6c/0x9c
>>    [<90000000047cef34>] __warn+0xa4/0x1b0
>>    [<90000000060a4884>] __report_bug+0xa4/0x1d0
>>    [<90000000060a4a88>] report_bug+0x38/0xd0
>>    [<90000000060df330>] do_bp+0x260/0x410
>>    [<90000000047a6bc0>] handle_bp+0x120/0x1c0
>>    [<ffff8000028bff40>] amdgpu_irq_put+0xb0/0x140 [amdgpu]
>>    [<ffff8000027b1a8c>] amdgpu_fence_driver_hw_fini+0x12c/0x180 [amdgpu]
>>    [<ffff800002f2c04c>] amdgpu_device_fini_hw+0xf0/0x3fc [amdgpu]
>>    [<ffff80000279e2ac>] amdgpu_driver_load_kms+0x7c/0xa0 [amdgpu]
>>    [<ffff800002791128>] amdgpu_pci_probe+0x298/0x810 [amdgpu]
>>    [<90000000054d04a4>] local_pci_probe+0x44/0xc0
>>    [<90000000047f4ab0>] work_for_cpu_fn+0x20/0x40
>>    [<90000000047f93e0>] process_one_work+0x170/0x4e0
>>    [<90000000047fa14c>] worker_thread+0x3ac/0x4e0
>>    [<9000000004806824>] kthread+0x154/0x170
>>    [<90000000060df5b4>] ret_from_kernel_thread+0x24/0xd0
>>    [<90000000047a62a4>] ret_from_kernel_thread_asm+0xc/0x88
>>
>>    ---[ end trace 0000000000000000 ]---
>>    amdgpu 0000:07:00.0: probe with driver amdgpu failed with error -110
>>    amdgpu 0000:07:00.0: amdgpu: amdgpu: ttm finalized
>>
>> This is because amdgpu_irq_enabled() is false in amdgpu_irq_put(), then
>> the condition of WARN_ON() is true.
>>
>> In order to avoid the unnecessary Call Traces, it can remove the check of
>> amdgpu_irq_enabled() and only check atomic_read(&src->enabled_types[type]
>> for three reasons:
>>
>> (1) The aim is to prevent refcount from being less than 0, it was added in
>> commit 1fa8d710573f ("drm/amdgpu: Fix desktop freezed after gpu-reset").
>> (2) There are already many useful failed log before the Call Trace, there
>> is no need to WARN_ON().
> 
> Well completely disagree. The call trace here is absolutely intentional.

If so, since the call trace is same, is it enough to use WARN_ON_ONCE()
here?

> That you get a lot of other backtraces because the driver doesn't initialize at all isn't a good rational to remove this one here.
> 
> Regards,
> Christian.
> 
>> (3) The following checks in amdgpu_irq_put() are same with the checks in
>> amdgpu_irq_enabled(), there is no need to do the redundant operations.
>>
>> 	if (!adev->irq.installed)
>> 		return -ENOENT;
>>
>> 	if (type >= src->num_types)
>> 		return -EINVAL;
>>
>> 	if (!src->enabled_types || !src->funcs->set)
>> 		return -EINVAL;

Is this reasonable? Only check atomic_read(&src->enabled_types[type]?

That is to say, does it make sense to do the following change?

----->8-----
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c 
b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index 8112ffc85995..d10d6fcc525e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -636,7 +636,7 @@ int amdgpu_irq_put(struct amdgpu_device *adev, 
struct amdgpu_irq_src *src,
         if (!src->enabled_types || !src->funcs->set)
                 return -EINVAL;

-       if (WARN_ON(!amdgpu_irq_enabled(adev, src, type)))
+       if (WARN_ON_ONCE(!atomic_read(&src->enabled_types[type])))
                 return -EINVAL;

         if (atomic_dec_and_test(&src->enabled_types[type]))

Thanks,
Tiezhu

