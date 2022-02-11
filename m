Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 059DBC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Feb 2022 13:19:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C23C10E12E;
	Fri, 11 Feb 2022 13:19:55 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CF9310EB90
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Feb 2022 13:19:54 +0000 (UTC)
Received: by mail-ej1-x630.google.com with SMTP id qk11so2516510ejb.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Feb 2022 05:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=V6TVpQ/QMYeARzTfF4Y94+vyzZ+GLghs4DE5x32psbE=;
 b=kV7WYOkB9CEZbPsKBdIo1zECOveQDKoIOzatAYrirtPXaGpm+nTAShlfLJkoxTUpQH
 fEsT6tsDHaJBUJbXFPwEOV8OV69eA0KgthgZuIGA1IQzciMRnoA6nvRWs5yIHaAfWWBA
 loqFjk6G0QV7uQFpUtArwVJ2n8qkQvBaFUJ7a6O34CwJCsUadiwetZHMLzkVNNaKa2u5
 2yk2mfTHPdcjlc3WvAEpyCzC/pdyUDY2oxQRjXwL52iScRsH8T2fgmZmJPv9xroN9BlI
 AjpNR+FlxmENmR8FUeXrRa2PdbUSEzqgdV4E/fqsdKgNiCjJL4Qzf3H11ccJPNUxXfS5
 SB1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=V6TVpQ/QMYeARzTfF4Y94+vyzZ+GLghs4DE5x32psbE=;
 b=cmNTZsh8/plj+wity22EtKovcIgDUwBdklqOe9g06+QVVY1shtfMfJ640wRUgb3nmO
 leqWHDAd/kPNIgH/scc0NS4HmEMwAvDVXZzK8MEBA5NUnHi7XEERl49OaUt5B3kc6lU9
 hXwRa7WyPIKXCQON5ksx4HhysYH7xC+3MG8jgW08XlMsyAV+Ereh+xvY14/gLr1EVA2r
 ySx38oEk8O2rx9eyyExSU1Xb8/5iTrAwVMYtpUMnblNUk9xbk4omSoMVhfRdrMLdMx+N
 AipoVFG+DMzLFTtp7tyKxwHTyypNYDRowPOk4VaCUk/j4yMfNgHE6uAfw8MBpIYuRswi
 j/eg==
X-Gm-Message-State: AOAM532rjEPIL15cHk3wqjKTwuPpp5vCdUGHXtQTi5K9tnpTEyPBIfvU
 ROcekofnwtxZxRhOG3HOH+6lL8kUKcQ=
X-Google-Smtp-Source: ABdhPJxXt0PRaj9d1Sedtz/KQax/7rCdzzRiPnsztcazlwvItULIFXTQnc6hKwKVaFz4I4aVRSoBPg==
X-Received: by 2002:a17:907:3d01:: with SMTP id
 gm1mr1359482ejc.695.1644585592641; 
 Fri, 11 Feb 2022 05:19:52 -0800 (PST)
Received: from [192.168.178.21] (p57b0bff8.dip0.t-ipconnect.de.
 [87.176.191.248])
 by smtp.gmail.com with ESMTPSA id b2sm5458924ejg.91.2022.02.11.05.19.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Feb 2022 05:19:52 -0800 (PST)
Message-ID: <e5610649-9aea-a656-9656-d078ef14e1a7@gmail.com>
Date: Fri, 11 Feb 2022 14:19:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/2] drm/amdgpu: add debugfs for reset registers list
Content-Language: en-US
To: "Somalapuram, Amaranath" <asomalap@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220211114740.10904-1-Amaranath.Somalapuram@amd.com>
 <a7c372d6-0ea5-a41f-88c5-77784ebe0811@amd.com>
 <00ed810c-b474-d1ca-81ee-ea362d709a32@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <00ed810c-b474-d1ca-81ee-ea362d709a32@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: alexander.deucher@amd.com, shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 11.02.22 um 14:15 schrieb Somalapuram, Amaranath:
>
> On 2/11/2022 5:22 PM, Christian König wrote:
>> Am 11.02.22 um 12:47 schrieb Somalapuram Amaranath:
>>> List of register to be populated for dump collection during the GPU 
>>> reset.
>>>
>>> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  5 ++
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 61 
>>> +++++++++++++++++++++
>>>   2 files changed, 66 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> index b85b67a88a3d..b90349b86918 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> @@ -813,6 +813,7 @@ struct amd_powerplay {
>>>     #define AMDGPU_RESET_MAGIC_NUM 64
>>>   #define AMDGPU_MAX_DF_PERFMONS 4
>>> +#define AMDGPU_RESET_DUMP_REGS_MAX     128
>>>   struct amdgpu_device {
>>>       struct device            *dev;
>>>       struct pci_dev            *pdev;
>>> @@ -1097,6 +1098,10 @@ struct amdgpu_device {
>>>         struct amdgpu_reset_control     *reset_cntl;
>>>       uint32_t ip_versions[HW_ID_MAX][HWIP_MAX_INSTANCE];
>>> +
>>> +    /* reset dump register */
>>> +    uint32_t reset_dump_reg_list[AMDGPU_RESET_DUMP_REGS_MAX];
>>
>> Using an xarray or just dynamic allocation with krealloc_array would 
>> probably be better.
>>
>> Regards,
>> Christian.
>>
> I can use krealloc_array,
> Then in the second patch i need to use kmalloc (or hard-code values) 
> for this: uint32_t reg_value[AMDGPU_RESET_DUMP_REGS_MAX];
> We actually tried to avoid  dynamic allocation during reset (second 
> patch).

It's correct that you can't allocate any memory during reset, but that's 
also not necessary since you just need to trace one register at a time 
and that uses the trace ring buffer.

> Also AMDGPU_RESET_DUMP_REGS_MAX getting used in trace function.

Exactly that's what I'm trying to avoid here. Big traces have caused us 
quite a bunch of problems already :)

Regards,
Christian.

>
> Regards,
> S.Amarnath
>>> +    int                n_regs;
>>>   };
>>>     static inline struct amdgpu_device *drm_to_adev(struct 
>>> drm_device *ddev)
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> index 164d6a9e9fbb..fb99f3d657a4 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> @@ -1609,6 +1609,65 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
>>>   DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
>>>               amdgpu_debugfs_sclk_set, "%llu\n");
>>>   +static ssize_t amdgpu_reset_dump_register_list_read(struct file *f,
>>> +                char __user *buf, size_t size, loff_t *pos)
>>> +{
>>> +    struct amdgpu_device *adev = (struct amdgpu_device 
>>> *)file_inode(f)->i_private;
>>> +    char *reg_offset;
>>> +    int i, r, len;
>>> +
>>> +    reg_offset = kmalloc(2048, GFP_KERNEL);
>>> +    memset(reg_offset,  0, 2048);
>>> +    for (i = 0; i < adev->n_regs; i++)
>>> +        sprintf(reg_offset + strlen(reg_offset), "0x%x ", 
>>> adev->reset_dump_reg_list[i]);
>>> +
>>> +    sprintf(reg_offset + strlen(reg_offset), "\n");
>>> +    len = strlen(reg_offset);
>>> +
>>> +    if (*pos >=  len)
>>> +        return 0;
>>> +
>>> +    r = copy_to_user(buf, reg_offset, len);
>>> +    *pos += len - r;
>>> +    kfree(reg_offset);
>>> +
>>> +    return len - r;
>>> +}
>>> +
>>> +static ssize_t amdgpu_reset_dump_register_list_write(struct file 
>>> *f, const char __user *buf,
>>> +        size_t size, loff_t *pos)
>>> +{
>>> +    struct amdgpu_device *adev = (struct amdgpu_device 
>>> *)file_inode(f)->i_private;
>>> +    char *reg_offset, *reg;
>>> +    int ret, i = 0;
>>> +
>>> +    reg_offset = kmalloc(size, GFP_KERNEL);
>>> +    memset(reg_offset,  0, size);
>>> +    ret = copy_from_user(reg_offset, buf, size);
>>> +
>>> +    if (ret)
>>> +        return -EFAULT;
>>> +
>>> +    while ((reg = strsep(&reg_offset, " ")) != NULL) {
>>> +        ret  = kstrtouint(reg, 16, &adev->reset_dump_reg_list[i]);
>>> +        if (ret)
>>> +            return -EINVAL;
>>> +        i++;
>>> +    }
>>> +
>>> +    adev->n_regs = i;
>>> +    kfree(reg_offset);
>>> +
>>> +    return size;
>>> +}
>>> +
>>> +static const struct file_operations amdgpu_reset_dump_register_list 
>>> = {
>>> +    .owner = THIS_MODULE,
>>> +    .read = amdgpu_reset_dump_register_list_read,
>>> +    .write = amdgpu_reset_dump_register_list_write,
>>> +    .llseek = default_llseek
>>> +};
>>> +
>>>   int amdgpu_debugfs_init(struct amdgpu_device *adev)
>>>   {
>>>       struct dentry *root = adev_to_drm(adev)->primary->debugfs_root;
>>> @@ -1672,6 +1731,8 @@ int amdgpu_debugfs_init(struct amdgpu_device 
>>> *adev)
>>>                   &amdgpu_debugfs_test_ib_fops);
>>>       debugfs_create_file("amdgpu_vm_info", 0444, root, adev,
>>>                   &amdgpu_debugfs_vm_info_fops);
>>> +    debugfs_create_file("amdgpu_reset_dump_register_list", 0644, 
>>> root, adev,
>>> +                &amdgpu_reset_dump_register_list);
>>>         adev->debugfs_vbios_blob.data = adev->bios;
>>>       adev->debugfs_vbios_blob.size = adev->bios_size;
>>

