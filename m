Return-Path: <SRS0=gNHI=NR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 662F4C432BE
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 12:56:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E126601FE
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 12:56:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2E126601FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D18BD6E842;
	Thu, 26 Aug 2021 12:56:20 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB5E56E842
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 12:56:18 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 c129-20020a1c35870000b02902e6b6135279so2201103wma.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 05:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=U0IWOcoQf3kqWAD4wjVybzcfxeVdMWfRFpEIKZbGZtc=;
 b=F3QytwezwO0sHvLrqEu7oiqV6n68Rc6fzw7TX25jXdQXdXSSyRgWxmcLzJcb9xrV6u
 XQhLRO2fW9aIG2eA68hxsJtoGxOBHAFPgN25GI4ykSJVyL0GbKVVPG98tJJ/yWMjnL3u
 57wpwHNMVvGL6VD53+LIhkUY5cYYFtAyXqmlyAyhoTOaw6FFDpowiUtUsCwA7QY3Y/xG
 6fTq2SjWXOMgsBM1/FtI7caa9v6/LCmJ6JCYU9nhIFkDNt5Qywk2AKW+YrP8hIYGAAGz
 0NFTv7d7kjvFN8MY+Brc67eruoWVP4GXS0MS0FE8CS3m5mQEqBHiRvNid7WDW3naPfrx
 mQJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=U0IWOcoQf3kqWAD4wjVybzcfxeVdMWfRFpEIKZbGZtc=;
 b=RVquXqez2m7+d/924QWsDg9Eb43MGLM6cqhlTFt4NYu6z8iOMhev5Q09Rdi2R2h5/F
 2YcIzy5Ewj5lnUOGXJSTs2omkt6eHcHbWtRJwZGlUcP/3W+ERuj/Qv8c+YY+FQugf7c6
 9IBhMhUvLd+7cWQba1RB9R9gPIrT1m/v3vmatKDYybghMGLBWaLe1K/mZAhNGzkcT/nx
 TrwMf16roeAjy4j34ac+ol9e2XxDVPGZcJBX6nyBsrQNhnk+TUMCqXwC4HZWKnCdXeTv
 QJMvMt8+AR1H7KRLzktRzibgealSe7ClwU6X5+F6WuqkGZjjiMu0lbfDmeiDKvqy5flQ
 ZqEg==
X-Gm-Message-State: AOAM531rMCy07dVpbwtFpJgUxYx/xq2RATha8D83V7wsKWxFi6qzuD0k
 b3MADnYk/jr7luNJpDvlC2jUZANqqnY=
X-Google-Smtp-Source: ABdhPJyLI3Aqzb7frvP/C1Kz22M4Og8rqMMLF8HQ/N1NfWxvjdgCoJO+kA27HaIDrmoD5IK5CwRFww==
X-Received: by 2002:a7b:cb44:: with SMTP id v4mr3559697wmj.169.1629982577372; 
 Thu, 26 Aug 2021 05:56:17 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:1f1e:4529:2fc9:1857?
 ([2a02:908:1252:fb60:1f1e:4529:2fc9:1857])
 by smtp.gmail.com with ESMTPSA id m5sm8261271wmi.1.2021.08.26.05.56.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Aug 2021 05:56:16 -0700 (PDT)
Subject: Re: [PATCH] drm/amd/amdgpu: New debugfs interface for MMIO registers
 (v5)
To: "StDenis, Tom" <Tom.StDenis@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20210825172659.247530-1-tom.stdenis@amd.com>
 <4f68568f-6f38-a36d-397b-c9d1d03cf9e2@amd.com>
 <DM6PR12MB3547D401A95FC5CB86595348F7C79@DM6PR12MB3547.namprd12.prod.outlook.com>
 <eec9d9d5-aff6-5344-b15b-155a46a57e76@amd.com>
 <DM6PR12MB35470F0FA108B66B49434B10F7C79@DM6PR12MB3547.namprd12.prod.outlook.com>
 <2ae34dc2-adb6-54e2-30bc-a9636e1fc41e@amd.com>
 <DM6PR12MB3547902D3B388B2F5124E8BCF7C79@DM6PR12MB3547.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <0836bcdd-b39d-cd8c-a8c7-8f8d6ff7e31b@gmail.com>
Date: Thu, 26 Aug 2021 14:56:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <DM6PR12MB3547902D3B388B2F5124E8BCF7C79@DM6PR12MB3547.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
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

Well for the record you can do something like using READ_ONCE() and work 
with a local copy.

But Tom is right we shouldn't spend much more time on this.

Christian.

Am 26.08.21 um 14:28 schrieb StDenis, Tom:
> [AMD Official Use Only]
>
> The state is set with one syscall and used with a different syscall.  They're not atomic.
>
> (I also don't see the need to bikeshed this anymore than we already have).
>
> Tom
>
> ________________________________________
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Thursday, August 26, 2021 08:26
> To: StDenis, Tom; amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH] drm/amd/amdgpu: New debugfs interface for MMIO registers (v5)
>
> Does that really need a lock? Can't local variables solve it?
>
> Thanks,
> Lijo
>
> On 8/26/2021 5:52 PM, StDenis, Tom wrote:
>> [AMD Official Use Only]
>>
>> The issue is someone can issue an ioctl WHILE a read/write is happening.  In that case a read could take a [say] SRBM lock but then never free it.
>>
>> Two threads racing operations WITH the lock in place just means the userspace gets undefined outputs which from the kernel is fine.
>>
>> Tom
>>
>> ________________________________________
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Thursday, August 26, 2021 08:19
>> To: StDenis, Tom; amd-gfx@lists.freedesktop.org
>> Subject: Re: [PATCH] drm/amd/amdgpu: New debugfs interface for MMIO registers (v5)
>>
>> If there are two threads using the same fd, I don't see anything that
>> prevent this order
>>
>>           set_state (T1) // State1
>>           set_state (T2) // State2
>>           read (T1)
>>           write (T2)
>>
>> If there are separate fds, I guess the device level mutex takes care anyway.
>>
>> Thanks,
>> Lijo
>>
>> On 8/26/2021 5:45 PM, StDenis, Tom wrote:
>>> [AMD Official Use Only]
>>>
>>> While umr uses this as a constant two-step dance that doesn't mean another user task couldn't misbehave.  Two threads firing read/write and IOCTL at the same time could cause a lock imbalance.
>>>
>>> As I remarked to Christian offline that's unlikely to happen since umr is the only likely user of this it's still ideal to avoid potential race conditions as a matter of correctness.
>>>
>>> Tom
>>>
>>> ________________________________________
>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>> Sent: Thursday, August 26, 2021 08:12
>>> To: StDenis, Tom; amd-gfx@lists.freedesktop.org
>>> Subject: Re: [PATCH] drm/amd/amdgpu: New debugfs interface for MMIO registers (v5)
>>>
>>>
>>>
>>> On 8/25/2021 10:56 PM, Tom St Denis wrote:
>>>> This new debugfs interface uses an IOCTL interface in order to pass
>>>> along state information like SRBM and GRBM bank switching.  This
>>>> new interface also allows a full 32-bit MMIO address range which
>>>> the previous didn't.  With this new design we have room to grow
>>>> the flexibility of the file as need be.
>>>>
>>>> (v2): Move read/write to .read/.write, fix style, add comment
>>>>           for IOCTL data structure
>>>>
>>>> (v3): C style comments
>>>>
>>>> (v4): use u32 in struct and remove offset variable
>>>>
>>>> (v5): Drop flag clearing in op function, use 0xFFFFFFFF for broadcast
>>>>           instead of 0x3FF, use mutex for op/ioctl.
>>>>
>>>> Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
>>>> ---
>>>>      drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 150 ++++++++++++++++++++
>>>>      drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h |   1 -
>>>>      drivers/gpu/drm/amd/amdgpu/amdgpu_umr.h     |  51 +++++++
>>>>      3 files changed, 201 insertions(+), 1 deletion(-)
>>>>      create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_umr.h
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>> index 277128846dd1..87766fef0b1c 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>> @@ -36,6 +36,7 @@
>>>>      #include "amdgpu_rap.h"
>>>>      #include "amdgpu_securedisplay.h"
>>>>      #include "amdgpu_fw_attestation.h"
>>>> +#include "amdgpu_umr.h"
>>>>
>>>>      int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev)
>>>>      {
>>>> @@ -279,6 +280,143 @@ static ssize_t amdgpu_debugfs_regs_write(struct file *f, const char __user *buf,
>>>>          return amdgpu_debugfs_process_reg_op(false, f, (char __user *)buf, size, pos);
>>>>      }
>>>>
>>>> +static int amdgpu_debugfs_regs2_open(struct inode *inode, struct file *file)
>>>> +{
>>>> +     struct amdgpu_debugfs_regs2_data *rd;
>>>> +
>>>> +     rd = kzalloc(sizeof *rd, GFP_KERNEL);
>>>> +     if (!rd)
>>>> +             return -ENOMEM;
>>>> +     rd->adev = file_inode(file)->i_private;
>>>> +     file->private_data = rd;
>>>> +     mutex_init(&rd->lock);
>>>> +
>>>> +     return 0;
>>>> +}
>>>> +
>>>> +static int amdgpu_debugfs_regs2_release(struct inode *inode, struct file *file)
>>>> +{
>>>> +     kfree(file->private_data);
>>>> +     return 0;
>>>> +}
>>>> +
>>>> +static ssize_t amdgpu_debugfs_regs2_op(struct file *f, char __user *buf, u32 offset, size_t size, int write_en)
>>>> +{
>>>> +     struct amdgpu_debugfs_regs2_data *rd = f->private_data;
>>>> +     struct amdgpu_device *adev = rd->adev;
>>>> +     ssize_t result = 0;
>>>> +     int r;
>>>> +     uint32_t value;
>>>> +
>>>> +     if (size & 0x3 || offset & 0x3)
>>>> +             return -EINVAL;
>>>> +
>>>> +     r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
>>>> +     if (r < 0) {
>>>> +             pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>>> +             return r;
>>>> +     }
>>>> +
>>>> +     r = amdgpu_virt_enable_access_debugfs(adev);
>>>> +     if (r < 0) {
>>>> +             pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>>> +             return r;
>>>> +     }
>>>> +
>>>> +     mutex_lock(&rd->lock);
>>>> +
>>>> +     if (rd->id.use_grbm) {
>>>> +             if ((rd->id.grbm.sh != 0xFFFFFFFF && rd->id.grbm.sh >= adev->gfx.config.max_sh_per_se) ||
>>>> +                 (rd->id.grbm.se != 0xFFFFFFFF && rd->id.grbm.se >= adev->gfx.config.max_shader_engines)) {
>>>> +                     pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>>>> +                     pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>>> +                     amdgpu_virt_disable_access_debugfs(adev);
>>>> +                     mutex_unlock(&rd->lock);
>>>> +                     return -EINVAL;
>>>> +             }
>>>> +             mutex_lock(&adev->grbm_idx_mutex);
>>>> +             amdgpu_gfx_select_se_sh(adev, rd->id.grbm.se,
>>>> +                                                             rd->id.grbm.sh,
>>>> +                                                             rd->id.grbm.instance);
>>>> +     }
>>>> +
>>>> +     if (rd->id.use_srbm) {
>>>> +             mutex_lock(&adev->srbm_mutex);
>>>> +             amdgpu_gfx_select_me_pipe_q(adev, rd->id.srbm.me, rd->id.srbm.pipe,
>>>> +                                                                     rd->id.srbm.queue, rd->id.srbm.vmid);
>>>> +     }
>>>> +
>>>> +     if (rd->id.pg_lock)
>>>> +             mutex_lock(&adev->pm.mutex);
>>>> +
>>>> +     while (size) {
>>>> +             if (!write_en) {
>>>> +                     value = RREG32(offset >> 2);
>>>> +                     r = put_user(value, (uint32_t *)buf);
>>>> +             } else {
>>>> +                     r = get_user(value, (uint32_t *)buf);
>>>> +                     if (!r)
>>>> +                             amdgpu_mm_wreg_mmio_rlc(adev, offset >> 2, value);
>>>> +             }
>>>> +             if (r) {
>>>> +                     result = r;
>>>> +                     goto end;
>>>> +             }
>>>> +             offset += 4;
>>>> +             size -= 4;
>>>> +             result += 4;
>>>> +             buf += 4;
>>>> +     }
>>>> +end:
>>>> +     if (rd->id.use_grbm) {
>>>> +             amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
>>>> +             mutex_unlock(&adev->grbm_idx_mutex);
>>>> +     }
>>>> +
>>>> +     if (rd->id.use_srbm) {
>>>> +             amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0);
>>>> +             mutex_unlock(&adev->srbm_mutex);
>>>> +     }
>>>> +
>>>> +     if (rd->id.pg_lock)
>>>> +             mutex_unlock(&adev->pm.mutex);
>>>> +
>>>> +     mutex_unlock(&rd->lock);
>>>> +
>>>> +     pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>>>> +     pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>>> +
>>>> +     amdgpu_virt_disable_access_debugfs(adev);
>>>> +     return result;
>>>> +}
>>>> +
>>>> +static long amdgpu_debugfs_regs2_ioctl(struct file *f, unsigned int cmd, unsigned long data)
>>>> +{
>>>> +     struct amdgpu_debugfs_regs2_data *rd = f->private_data;
>>>> +     int r;
>>>> +
>>>> +     switch (cmd) {
>>>> +     case AMDGPU_DEBUGFS_REGS2_IOC_SET_STATE:
>>>> +             mutex_lock(&rd->lock);
>>>> +             r = copy_from_user(&rd->id, (struct amdgpu_debugfs_regs2_iocdata *)data, sizeof rd->id);
>>>> +             mutex_unlock(&rd->lock);
>>> As this is a two-step read/write, I don't think there is any protection
>>> offered by having this mutex.
>>>
>>> Thanks,
>>> Lijo
>>>
>>>> +             return r ? -EINVAL : 0;
>>>> +     default:
>>>> +             return -EINVAL;
>>>> +     }
>>>> +     return 0;
>>>> +}
>>>> +
>>>> +static ssize_t amdgpu_debugfs_regs2_read(struct file *f, char __user *buf, size_t size, loff_t *pos)
>>>> +{
>>>> +     return amdgpu_debugfs_regs2_op(f, buf, *pos, size, 0);
>>>> +}
>>>> +
>>>> +static ssize_t amdgpu_debugfs_regs2_write(struct file *f, const char __user *buf, size_t size, loff_t *pos)
>>>> +{
>>>> +     return amdgpu_debugfs_regs2_op(f, (char __user *)buf, *pos, size, 1);
>>>> +}
>>>> +
>>>>
>>>>      /**
>>>>       * amdgpu_debugfs_regs_pcie_read - Read from a PCIE register
>>>> @@ -1091,6 +1229,16 @@ static ssize_t amdgpu_debugfs_gfxoff_read(struct file *f, char __user *buf,
>>>>          return result;
>>>>      }
>>>>
>>>> +static const struct file_operations amdgpu_debugfs_regs2_fops = {
>>>> +     .owner = THIS_MODULE,
>>>> +     .unlocked_ioctl = amdgpu_debugfs_regs2_ioctl,
>>>> +     .read = amdgpu_debugfs_regs2_read,
>>>> +     .write = amdgpu_debugfs_regs2_write,
>>>> +     .open = amdgpu_debugfs_regs2_open,
>>>> +     .release = amdgpu_debugfs_regs2_release,
>>>> +     .llseek = default_llseek
>>>> +};
>>>> +
>>>>      static const struct file_operations amdgpu_debugfs_regs_fops = {
>>>>          .owner = THIS_MODULE,
>>>>          .read = amdgpu_debugfs_regs_read,
>>>> @@ -1148,6 +1296,7 @@ static const struct file_operations amdgpu_debugfs_gfxoff_fops = {
>>>>
>>>>      static const struct file_operations *debugfs_regs[] = {
>>>>          &amdgpu_debugfs_regs_fops,
>>>> +     &amdgpu_debugfs_regs2_fops,
>>>>          &amdgpu_debugfs_regs_didt_fops,
>>>>          &amdgpu_debugfs_regs_pcie_fops,
>>>>          &amdgpu_debugfs_regs_smc_fops,
>>>> @@ -1160,6 +1309,7 @@ static const struct file_operations *debugfs_regs[] = {
>>>>
>>>>      static const char *debugfs_regs_names[] = {
>>>>          "amdgpu_regs",
>>>> +     "amdgpu_regs2",
>>>>          "amdgpu_regs_didt",
>>>>          "amdgpu_regs_pcie",
>>>>          "amdgpu_regs_smc",
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>>>> index 141a8474e24f..6d4965b2d01e 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>>>> @@ -22,7 +22,6 @@
>>>>       * OTHER DEALINGS IN THE SOFTWARE.
>>>>       *
>>>>       */
>>>> -
>>>>      /*
>>>>       * Debugfs
>>>>       */
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umr.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umr.h
>>>> new file mode 100644
>>>> index 000000000000..919d9d401750
>>>> --- /dev/null
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umr.h
>>>> @@ -0,0 +1,51 @@
>>>> +/*
>>>> + * Copyright 2021 Advanced Micro Devices, Inc.
>>>> + *
>>>> + * Permission is hereby granted, free of charge, to any person obtaining a
>>>> + * copy of this software and associated documentation files (the "Software"),
>>>> + * to deal in the Software without restriction, including without limitation
>>>> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
>>>> + * and/or sell copies of the Software, and to permit persons to whom the
>>>> + * Software is furnished to do so, subject to the following conditions:
>>>> + *
>>>> + * The above copyright notice and this permission notice shall be included in
>>>> + * all copies or substantial portions of the Software.
>>>> + *
>>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
>>>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
>>>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
>>>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>>>> + * OTHER DEALINGS IN THE SOFTWARE.
>>>> + *
>>>> + */
>>>> +#include <linux/ioctl.h>
>>>> +
>>>> +/*
>>>> + * MMIO debugfs IOCTL structure
>>>> + */
>>>> +struct amdgpu_debugfs_regs2_iocdata {
>>>> +     __u32 use_srbm, use_grbm, pg_lock;
>>>> +     struct {
>>>> +             __u32 se, sh, instance;
>>>> +     } grbm;
>>>> +     struct {
>>>> +             __u32 me, pipe, queue, vmid;
>>>> +     } srbm;
>>>> +};
>>>> +
>>>> +/*
>>>> + * MMIO debugfs state data (per file* handle)
>>>> + */
>>>> +struct amdgpu_debugfs_regs2_data {
>>>> +     struct amdgpu_device *adev;
>>>> +     struct mutex lock;
>>>> +     struct amdgpu_debugfs_regs2_iocdata id;
>>>> +};
>>>> +
>>>> +enum AMDGPU_DEBUGFS_REGS2_CMDS {
>>>> +     AMDGPU_DEBUGFS_REGS2_CMD_SET_STATE=0,
>>>> +};
>>>> +
>>>> +#define AMDGPU_DEBUGFS_REGS2_IOC_SET_STATE _IOWR(0x20, AMDGPU_DEBUGFS_REGS2_CMD_SET_STATE, struct amdgpu_debugfs_regs2_iocdata)
>>>>

