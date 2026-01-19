Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64100D29C30
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jan 2026 14:26:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E829010E473;
	Mon, 19 Jan 2026 14:26:39 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
 by gabe.freedesktop.org (Postfix) with ESMTP id A6A8A10E2BE
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 08:53:59 +0000 (UTC)
Received: from loongson.cn (unknown [113.200.148.30])
 by gateway (Coremail) with SMTP id _____8Cx68Ik8W1pt0AKAA--.33353S3;
 Mon, 19 Jan 2026 16:53:56 +0800 (CST)
Received: from [10.130.40.83] (unknown [113.200.148.30])
 by front1 (Coremail) with SMTP id qMiowJBx78Ii8W1pYRMlAA--.10191S3;
 Mon, 19 Jan 2026 16:53:54 +0800 (CST)
Subject: Re: [RFC PATCH] drm/amdgpu: Avoid unnecessary Call Traces in
 amdgpu_irq_put()
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: Alan Liu <haoping.liu@amd.com>, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260115012830.31182-1-yangtiezhu@loongson.cn>
 <6ac02ffa-5d62-4fc7-9882-6ccf7b44eaf4@amd.com>
 <0afdb83a-d2db-53d9-3b1b-253e466a5cc3@loongson.cn>
 <1673a119-838f-455e-88fb-528bbd72e1ea@amd.com>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <1a0dab04-cb13-9307-2853-38221193e38e@loongson.cn>
Date: Mon, 19 Jan 2026 16:53:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1673a119-838f-455e-88fb-528bbd72e1ea@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBx78Ii8W1pYRMlAA--.10191S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tFy3uFy7Xw1UAryfWF17Arc_yoW8ZrWDpF
 n3tFy2yrn5uF4jyr1jk3W8uFyYyw1UXa4fKr1UC34I9w4jyrn5KF1xtF18Kr9rGrWxCF42
 yr9Yq3yIqF1qvFcCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1wL
 05UUUUU==
X-Mailman-Approved-At: Mon, 19 Jan 2026 14:26:39 +0000
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

On 2026/1/16 下午6:03, Christian König wrote:
> On 1/16/26 02:20, Tiezhu Yang wrote:
>> On 2026/1/15 下午9:47, Christian König wrote:
>>> On 1/15/26 02:28, Tiezhu Yang wrote:
>>>> Currently, there are many Call Traces when booting kernel on LoongArch,
>>>> here are the trimmed kernel log messages:
>>>>
>>>>     amdgpu 0000:07:00.0: amdgpu: hw_init of IP block <gfx_v6_0> failed -110
>>>>     amdgpu 0000:07:00.0: amdgpu: amdgpu_device_ip_init failed
>>>>     amdgpu 0000:07:00.0: amdgpu: Fatal error during GPU init
>>>>     amdgpu 0000:07:00.0: amdgpu: amdgpu: finishing device.
>>>>     ------------[ cut here ]------------
>>>>     WARNING: drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:639 at amdgpu_irq_put+0xb0/0x140 [amdgpu], CPU#0: kworker/0:0/9
>>>>     ...
>>>>     Call Trace:

...

> The warning can basically only be triggered by two conditions:
> 1. A fatal problem while loading the driver and the error handling is not 100% clean.
> 2. A driver coding error.
> 
> And we really need to catch all of those, so there is no real rational to limit the warning.
> 
> I mean when you run into any of those they should potentially be fixed at some point.

I did the following change and it can fix the problem, given that I am
not familiar with amdgpu driver, could you please check it? If it is OK,
I will send a formal patch later.

----->8-----
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c 
b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index 8112ffc85995..ac19565e7c45 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -138,6 +138,9 @@ void amdgpu_irq_disable_all(struct amdgpu_device *adev)
                         if (!src || !src->funcs->set || !src->num_types)
                                 continue;

+                       kfree(src->enabled_types);
+                       src->enabled_types = NULL;
+
                         for (k = 0; k < src->num_types; ++k) {
                                 r = src->funcs->set(adev, src, k,
 
AMDGPU_IRQ_STATE_DISABLE);

Thanks,
Tiezhu

