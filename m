Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A18CAC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Feb 2022 14:56:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25AD410E757;
	Wed, 16 Feb 2022 14:56:34 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 052B310E73B
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Feb 2022 14:56:31 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id bg10so2886177ejb.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Feb 2022 06:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to;
 bh=XL6697pJhSCviuSixbnGJ0hcu7yd9g3emx9SsMR+Zbc=;
 b=UpMBCKzOKI7uhUVR9sYA+H3oQAsK5NDn2v4HWukyJsBDRgyDqG6JWYH5a3d7aon1OI
 +ZES/zHldC2FABUMIqNIh1ytBZAcqgNZalgncTeBCjXnsdBiw7HJzVO4pB72HTwNrEIq
 WQYWzZJXMhi4tBNES8f2eRc96Ty5wLMwcaMpDKlflfd23omnlnxj9KQgi0boJKT7qIRP
 iVsi4jic1ZkoYqYk3G0p0PTPusk1yoGvKvF3tHOZEfO7Iy1ummD7VVZZuZsqmbfbtF5z
 HR0sjrxOWJ0GGt8fZ73HJZpmGNxcx7+r+tUgGoTfsxP9WHMc5abE2qTv3AgPNzKAqByo
 ZgxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to;
 bh=XL6697pJhSCviuSixbnGJ0hcu7yd9g3emx9SsMR+Zbc=;
 b=xy0yOPbRM/nJ3hW3S95K0W/whQhjp0k/i6da7mxcskilkrd5E9m5rCZfE1d1wniwb8
 jTVGTPwN1uI3HPVjqOexQDClzBgWBdJSP0yhdmNAauP4vTN2Yk7wFLyEAvpHR+oUZns+
 HtuQwE0jBVesNq8g7q611MP8902Ofkr0lz1Juytk+RBinmC1npfr4A/p58Qkuotvk6YK
 qBFqRHdDBgx7sxR4zVgA8R7/aariYOLjDZSy27tw6NnHZk4AhusJ2TZm4EIkhxM2Dlvc
 68HBvO4VUSvwHgjiqnP9IjCooiOmOgCo5uXwSfpPF/WjNZt+YFO/1yOS3hJcLquDSaJf
 8S8Q==
X-Gm-Message-State: AOAM531GfiWnExKKqtI4f8dPxSIMsXtDkyqdUYtWYwW2thSAVRsBJz/p
 nC4D/qMNolv4/CVCJMqTuVI=
X-Google-Smtp-Source: ABdhPJz7L9QByLA/iKpgPthAgpEH1RRDsjk1OJENz3x8umtqW1ZmZCOLVQJcG/5uvZ+djY1LTDPDmw==
X-Received: by 2002:a17:906:3905:b0:6cf:7ef5:fee0 with SMTP id
 f5-20020a170906390500b006cf7ef5fee0mr2532476eje.307.1645023390340; 
 Wed, 16 Feb 2022 06:56:30 -0800 (PST)
Received: from ?IPV6:2a02:908:1252:fb60:73f4:ef05:616f:de3f?
 ([2a02:908:1252:fb60:73f4:ef05:616f:de3f])
 by smtp.gmail.com with ESMTPSA id t26sm893550edv.50.2022.02.16.06.56.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Feb 2022 06:56:29 -0800 (PST)
Content-Type: multipart/alternative;
 boundary="------------DkTL0eqTr0mAKXAhqnl7l5ur"
Message-ID: <d531c825-332d-036d-c4b4-5e2cf39edb52@gmail.com>
Date: Wed, 16 Feb 2022 15:56:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v6 1/2] drm/amdgpu: add debugfs for reset registers list
Content-Language: en-US
To: "Somalapuram, Amaranath" <asomalap@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220216094949.3169-1-Amaranath.Somalapuram@amd.com>
 <e9f1e95f-5aac-4a25-51f1-b971a8189d79@amd.com>
 <ed1103b1-835c-e56a-3118-17bd60f0f5f9@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <ed1103b1-835c-e56a-3118-17bd60f0f5f9@amd.com>
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

This is a multi-part message in MIME format.
--------------DkTL0eqTr0mAKXAhqnl7l5ur
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 16.02.22 um 14:11 schrieb Somalapuram, Amaranath:
>
> On 2/16/2022 3:41 PM, Christian König wrote:
>
>> Am 16.02.22 um 10:49 schrieb Somalapuram Amaranath:
>>> List of register populated for dump collection during the GPU reset.
>>>
>>> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  5 ++
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 95 
>>> +++++++++++++++++++++
>>>   2 files changed, 100 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> index b85b67a88a3d..57965316873b 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> @@ -1097,6 +1097,11 @@ struct amdgpu_device {
>>>         struct amdgpu_reset_control     *reset_cntl;
>>>       uint32_t ip_versions[HW_ID_MAX][HWIP_MAX_INSTANCE];
>>> +
>>> +    /* reset dump register */
>>> +    uint32_t            *reset_dump_reg_list;
>>> +    int                             n_regs;
>>> +    struct mutex            reset_dump_mutex;
>>
>> I think we should rather use the reset lock for this instead of 
>> introducing just another mutex.
>>
>>>   };
>>>     static inline struct amdgpu_device *drm_to_adev(struct 
>>> drm_device *ddev)
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> index 164d6a9e9fbb..faf985c7cb93 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> @@ -1609,6 +1609,98 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
>>>   DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
>>>               amdgpu_debugfs_sclk_set, "%llu\n");
>>>   +static ssize_t amdgpu_reset_dump_register_list_read(struct file *f,
>>> +                char __user *buf, size_t size, loff_t *pos)
>>> +{
>>> +    struct amdgpu_device *adev = (struct amdgpu_device 
>>> *)file_inode(f)->i_private;
>>> +    char reg_offset[11];
>>> +    int i, r, len = 0;
>>> +
>>> +    if (*pos)
>>> +        return 0;
>>> +
>>> +    if (adev->n_regs == 0)
>>> +        return 0;
>>> +
>>> +    for (i = 0; i < adev->n_regs; i++) {
>>> +        sprintf(reg_offset, "0x%x ", adev->reset_dump_reg_list[i]);
>>> +        r = copy_to_user(buf + len, reg_offset, strlen(reg_offset));
>>> +
>>> +        if (r)
>>> +            return -EFAULT;
>>> +
>>> +        len += strlen(reg_offset);
>>> +    }
>>
>> You need to hold the lock protecting adev->reset_dump_reg_list and 
>> adev->n_regs while accessing those.
>>
>> (BTW: num_regs instead of n_regs would match more what we use 
>> elsewhere, but is not a must have).
>>
> This is read function for user and returns only list of reg offsets, I 
> did not understand correctly !
>>> +
>>> +    r = copy_to_user(buf + len, "\n", 1);
>>> +
>>> +    if (r)
>>> +        return -EFAULT;
>>> +
>>> +    len++;
>>> +    *pos += len;
>>> +
>>> +    return len;
>>> +}
>>> +
>>> +static ssize_t amdgpu_reset_dump_register_list_write(struct file *f,
>>> +            const char __user *buf, size_t size, loff_t *pos)
>>> +{
>>> +    struct amdgpu_device *adev = (struct amdgpu_device 
>>> *)file_inode(f)->i_private;
>>> +    char *reg_offset, *reg, reg_temp[11];
>>> +    static int alloc_count;
>>> +    int ret, i = 0, len = 0;
>>> +
>>> +    do {
>>> +        reg_offset = reg_temp;
>>> +        memset(reg_offset,  0, 11);
>>> +        ret = copy_from_user(reg_offset, buf + len, min(11, 
>>> ((int)size-len)));
>>> +
>>> +        if (ret)
>>> +            goto failed;
>>> +
>>> +        reg = strsep(&reg_offset, " ");
>>> +
>>> +        if (alloc_count <= i) {
>>
>>> + adev->reset_dump_reg_list =  krealloc_array(
>>> +                            adev->reset_dump_reg_list, 1,
>>> +                            sizeof(uint32_t), GFP_KERNEL);
>>> +            alloc_count++;
>>> +        }
>>> +
>>> +        ret = kstrtouint(reg, 16, &adev->reset_dump_reg_list[i]);
>>
>> This here is modifying adev->reset_dump_reg_list as well and so must 
>> be protected by a lock as well.
>>
>> The tricky part is that we can't allocate memory while holding this 
>> lock (because we need it during reset as well).
>>
>> One solution for this is to read the register list into a local array 
>> first and when that's done swap the local array with the one in 
>> adev->reset_dump_reg_list while holding the lock.
>>
>> Regards,
>> Christian.
>>
> There are 2 situations:
> 1st time creating list n_regs will be 0 and trace event will not be 
> triggered
> 2nd time while updating list n_regs is already set and 
> adev->reset_dump_reg_list will have some offsets address 
> (hypothetically speaking *during reset + update* read values from 
> RREG32 will mix up of old list and new list)
> its only critical when its freed and n_regs is not 0

No, that won't work like this. See you *must* always hold a lock when 
reading or writing the array.

Otherwise it is perfectly possible that one thread sees only halve of 
the updates of another thread.

The only alternative would be RCU, atomic replace and manual barrier 
handling, but that would be complete overkill for that feature.

Regards,
Christian.

>
> Regards,
> S.Amarnath
>>> +
>>> +        if (ret)
>>> +            goto failed;
>>> +
>>> +        len += strlen(reg) + 1;
>>> +        i++;
>>> +
>>> +    } while (len < size);
>>> +
>>> +    adev->n_regs = i;
>>> +
>>> +    return size;
>>> +
>>> +failed:
>>> +    mutex_lock(&adev->reset_dump_mutex);
>>> +    kfree(adev->reset_dump_reg_list);
>>> +    adev->reset_dump_reg_list = NULL;
>>> +    alloc_count = 0;
>>> +    adev->n_regs = 0;
>>> +    mutex_unlock(&adev->reset_dump_mutex);
>>> +    return -EFAULT;
>>> +}
>>> +
>>> +
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
>>> @@ -1618,6 +1710,7 @@ int amdgpu_debugfs_init(struct amdgpu_device 
>>> *adev)
>>>       if (!debugfs_initialized())
>>>           return 0;
>>>   +    mutex_init(&adev->reset_dump_mutex);
>>>       ent = debugfs_create_file("amdgpu_preempt_ib", 0600, root, adev,
>>>                     &fops_ib_preempt);
>>>       if (IS_ERR(ent)) {
>>> @@ -1672,6 +1765,8 @@ int amdgpu_debugfs_init(struct amdgpu_device 
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

--------------DkTL0eqTr0mAKXAhqnl7l5ur
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    Am 16.02.22 um 14:11 schrieb Somalapuram, Amaranath:<br>
    <blockquote type="cite"
      cite="mid:ed1103b1-835c-e56a-3118-17bd60f0f5f9@amd.com">
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <p>On 2/16/2022 3:41 PM, Christian König wrote:<br>
      </p>
      <blockquote type="cite"
        cite="mid:e9f1e95f-5aac-4a25-51f1-b971a8189d79@amd.com">Am
        16.02.22 um 10:49 schrieb Somalapuram Amaranath: <br>
        <blockquote type="cite">List of register populated for dump
          collection during the GPU reset. <br>
          <br>
          Signed-off-by: Somalapuram Amaranath <a
            class="moz-txt-link-rfc2396E"
            href="mailto:Amaranath.Somalapuram@amd.com"
            moz-do-not-send="true">&lt;Amaranath.Somalapuram@amd.com&gt;</a>
          <br>
          --- <br>
            drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  5 ++ <br>
            drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 95
          +++++++++++++++++++++ <br>
            2 files changed, 100 insertions(+) <br>
          <br>
          diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
          b/drivers/gpu/drm/amd/amdgpu/amdgpu.h <br>
          index b85b67a88a3d..57965316873b 100644 <br>
          --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h <br>
          +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h <br>
          @@ -1097,6 +1097,11 @@ struct amdgpu_device { <br>
                  struct amdgpu_reset_control     *reset_cntl; <br>
                uint32_t                       
          ip_versions[HW_ID_MAX][HWIP_MAX_INSTANCE]; <br>
          + <br>
          +    /* reset dump register */ <br>
          +    uint32_t            *reset_dump_reg_list; <br>
          +    int                             n_regs; <br>
          +    struct mutex            reset_dump_mutex; <br>
        </blockquote>
        <br>
        I think we should rather use the reset lock for this instead of
        introducing just another mutex. <br>
        <br>
        <blockquote type="cite">  }; <br>
              static inline struct amdgpu_device *drm_to_adev(struct
          drm_device *ddev) <br>
          diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
          b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c <br>
          index 164d6a9e9fbb..faf985c7cb93 100644 <br>
          --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c <br>
          +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c <br>
          @@ -1609,6 +1609,98 @@
          DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL, <br>
            DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL, <br>
                        amdgpu_debugfs_sclk_set, "%llu\n"); <br>
            +static ssize_t amdgpu_reset_dump_register_list_read(struct
          file *f, <br>
          +                char __user *buf, size_t size, loff_t *pos) <br>
          +{ <br>
          +    struct amdgpu_device *adev = (struct amdgpu_device
          *)file_inode(f)-&gt;i_private; <br>
          +    char reg_offset[11]; <br>
          +    int i, r, len = 0; <br>
          + <br>
          +    if (*pos) <br>
          +        return 0; <br>
          + <br>
          +    if (adev-&gt;n_regs == 0) <br>
          +        return 0; <br>
          + <br>
          +    for (i = 0; i &lt; adev-&gt;n_regs; i++) { <br>
          +        sprintf(reg_offset, "0x%x ",
          adev-&gt;reset_dump_reg_list[i]); <br>
          +        r = copy_to_user(buf + len, reg_offset,
          strlen(reg_offset)); <br>
          + <br>
          +        if (r) <br>
          +            return -EFAULT; <br>
          + <br>
          +        len += strlen(reg_offset); <br>
          +    } <br>
        </blockquote>
        <br>
        You need to hold the lock protecting
        adev-&gt;reset_dump_reg_list and adev-&gt;n_regs while accessing
        those. <br>
        <br>
        (BTW: num_regs instead of n_regs would match more what we use
        elsewhere, but is not a must have). <br>
        <br>
      </blockquote>
      This is read function for user and returns only list of reg
      offsets, I did not understand correctly ! <br>
      <blockquote type="cite"
        cite="mid:e9f1e95f-5aac-4a25-51f1-b971a8189d79@amd.com">
        <blockquote type="cite">+ <br>
          +    r = copy_to_user(buf + len, "\n", 1); <br>
          + <br>
          +    if (r) <br>
          +        return -EFAULT; <br>
          + <br>
          +    len++; <br>
          +    *pos += len; <br>
          + <br>
          +    return len; <br>
          +} <br>
          + <br>
          +static ssize_t amdgpu_reset_dump_register_list_write(struct
          file *f, <br>
          +            const char __user *buf, size_t size, loff_t *pos)
          <br>
          +{ <br>
          +    struct amdgpu_device *adev = (struct amdgpu_device
          *)file_inode(f)-&gt;i_private; <br>
          +    char *reg_offset, *reg, reg_temp[11]; <br>
          +    static int alloc_count; <br>
          +    int ret, i = 0, len = 0; <br>
          + <br>
          +    do { <br>
          +        reg_offset = reg_temp; <br>
          +        memset(reg_offset,  0, 11); <br>
          +        ret = copy_from_user(reg_offset, buf + len, min(11,
          ((int)size-len))); <br>
          + <br>
          +        if (ret) <br>
          +            goto failed; <br>
          + <br>
          +        reg = strsep(&amp;reg_offset, " "); <br>
          + <br>
          +        if (alloc_count &lt;= i) { <br>
        </blockquote>
        <br>
        <blockquote type="cite">+           
          adev-&gt;reset_dump_reg_list =  krealloc_array( <br>
          +                            adev-&gt;reset_dump_reg_list, 1,
          <br>
          +                            sizeof(uint32_t), GFP_KERNEL); <br>
          +            alloc_count++; <br>
          +        } <br>
          + <br>
          +        ret = kstrtouint(reg, 16,
          &amp;adev-&gt;reset_dump_reg_list[i]); <br>
        </blockquote>
        <br>
        This here is modifying adev-&gt;reset_dump_reg_list as well and
        so must be protected by a lock as well. <br>
        <br>
        The tricky part is that we can't allocate memory while holding
        this lock (because we need it during reset as well). <br>
        <br>
        One solution for this is to read the register list into a local
        array first and when that's done swap the local array with the
        one in adev-&gt;reset_dump_reg_list while holding the lock. <br>
        <br>
        Regards, <br>
        Christian. <br>
        <br>
      </blockquote>
      There are 2 situations:<br>
      1st time creating list n_regs will be 0 and trace event will not
      be triggered<br>
      2nd time while updating list n_regs is already set and
      adev-&gt;reset_dump_reg_list will have some offsets address
      (hypothetically speaking  <b>during reset + update</b> read
      values from RREG32 will mix up of old list and new list) <br>
      its only critical when its freed and n_regs is not 0<br>
    </blockquote>
    <br>
    No, that won't work like this. See you *must* always hold a lock
    when reading or writing the array.<br>
    <br>
    Otherwise it is perfectly possible that one thread sees only halve
    of the updates of another thread.<br>
    <br>
    The only alternative would be RCU, atomic replace and manual barrier
    handling, but that would be complete overkill for that feature.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote type="cite"
      cite="mid:ed1103b1-835c-e56a-3118-17bd60f0f5f9@amd.com"> <br>
      Regards,<br>
      S.Amarnath<br>
      <blockquote type="cite"
        cite="mid:e9f1e95f-5aac-4a25-51f1-b971a8189d79@amd.com">
        <blockquote type="cite">+ <br>
          +        if (ret) <br>
          +            goto failed; <br>
          + <br>
          +        len += strlen(reg) + 1; <br>
          +        i++; <br>
          + <br>
          +    } while (len &lt; size); <br>
          + <br>
          +    adev-&gt;n_regs = i; <br>
          + <br>
          +    return size; <br>
          + <br>
          +failed: <br>
          +    mutex_lock(&amp;adev-&gt;reset_dump_mutex); <br>
          +    kfree(adev-&gt;reset_dump_reg_list); <br>
          +    adev-&gt;reset_dump_reg_list = NULL; <br>
          +    alloc_count = 0; <br>
          +    adev-&gt;n_regs = 0; <br>
          +    mutex_unlock(&amp;adev-&gt;reset_dump_mutex); <br>
          +    return -EFAULT; <br>
          +} <br>
          + <br>
          + <br>
          + <br>
          +static const struct file_operations
          amdgpu_reset_dump_register_list = { <br>
          +    .owner = THIS_MODULE, <br>
          +    .read = amdgpu_reset_dump_register_list_read, <br>
          +    .write = amdgpu_reset_dump_register_list_write, <br>
          +    .llseek = default_llseek <br>
          +}; <br>
          + <br>
            int amdgpu_debugfs_init(struct amdgpu_device *adev) <br>
            { <br>
                struct dentry *root =
          adev_to_drm(adev)-&gt;primary-&gt;debugfs_root; <br>
          @@ -1618,6 +1710,7 @@ int amdgpu_debugfs_init(struct
          amdgpu_device *adev) <br>
                if (!debugfs_initialized()) <br>
                    return 0; <br>
            +    mutex_init(&amp;adev-&gt;reset_dump_mutex); <br>
                ent = debugfs_create_file("amdgpu_preempt_ib", 0600,
          root, adev, <br>
                              &amp;fops_ib_preempt); <br>
                if (IS_ERR(ent)) { <br>
          @@ -1672,6 +1765,8 @@ int amdgpu_debugfs_init(struct
          amdgpu_device *adev) <br>
                            &amp;amdgpu_debugfs_test_ib_fops); <br>
                debugfs_create_file("amdgpu_vm_info", 0444, root, adev,
          <br>
                            &amp;amdgpu_debugfs_vm_info_fops); <br>
          +    debugfs_create_file("amdgpu_reset_dump_register_list",
          0644, root, adev, <br>
          +                &amp;amdgpu_reset_dump_register_list); <br>
                  adev-&gt;debugfs_vbios_blob.data = adev-&gt;bios; <br>
                adev-&gt;debugfs_vbios_blob.size = adev-&gt;bios_size; <br>
        </blockquote>
        <br>
      </blockquote>
    </blockquote>
    <br>
  </body>
</html>

--------------DkTL0eqTr0mAKXAhqnl7l5ur--
