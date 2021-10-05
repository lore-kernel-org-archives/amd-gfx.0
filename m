Return-Path: <SRS0=e3IM=OZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6395DC433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 12:42:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F6826103D
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 12:42:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2F6826103D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA6C48957B;
	Tue,  5 Oct 2021 12:42:01 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F9D18957B
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Oct 2021 12:42:00 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 a11-20020a7bc1cb000000b0030d6aae48b5so2780081wmj.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 05 Oct 2021 05:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=QtdUwkGMQI0CJXOZ273UHGwe9S0ctb70jMC0QItYNy0=;
 b=cgDeZ5pcnmanZv+y0FdI1dSyKDWBEFDDNMF9LhptQE5GOEIVA8aWAKBZo5bDfXrmUu
 z2nsRd9BIJYxdpwTB1w3E9b16DpeV72e7xG5bQ7YD7jlQSjMCyeW46sWqxjLWupHXPs9
 jcESF0hkEnmf7ibGA8rA7lBLrFj28Ql6sJJJa2vtR3GAS6mCe16YMnTOn4tyOm9ZOJBC
 uZr0ZhSFmZVP9gv2E5XS7XqSIbK1P8G/5d2iXP69YybKLayqw/wu3nop71DR+nOk38Uy
 uui6JVZF0C80IxqmZFbLITGj5ylW/8BCSIeNNNkG7SbXrBRnUmv3OfKJ2mjySdvDoz5x
 zBug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=QtdUwkGMQI0CJXOZ273UHGwe9S0ctb70jMC0QItYNy0=;
 b=gOMl8WcXv7UgX6+/GppReVgpHpgdio0RCnWF47KzFE2E0DBp5P7N3MReklq7XzwkWO
 k2VKUyHsIdFGkxTYAgGFH6xf7IhDv1YDyofNdXWUrzco1CXcUdQflWPd4KTiA5n5lL5k
 /vrIKa7qp7YpFuJCO9WxknFuP1ZEDoNTCrD5Lu+AKixpZGXD8zTC0uEEqviZh4wwGzR2
 D6FuMBF8052/Fih1rrA2Rz4o8roo1xwzITIeA+qA5vkol3G3A0bZIYNtE0HIPALJljFc
 uyt2IdDygYo9T6XQuC3uDMlTyPoaGQ427XYsgZCgmD1cej0+B09sUuz314CnJ86cWsJZ
 kU3w==
X-Gm-Message-State: AOAM5308fppUpXFYFehp0xUoxbTePSFVczNT5jRepeWZFtfoeH4wd1+s
 N29jkHokGLRHlsAbPce/znk=
X-Google-Smtp-Source: ABdhPJxdw7Y+67b52Sbc5Eba07uRJ7ToS+98BRsli5+wwN482Y16SnWnEJf9fthEaOrkg+wlR6ECXA==
X-Received: by 2002:a05:600c:4f95:: with SMTP id
 n21mr3255790wmq.22.1633437718796; 
 Tue, 05 Oct 2021 05:41:58 -0700 (PDT)
Received: from [192.168.178.21] (p5b0ea1b5.dip0.t-ipconnect.de.
 [91.14.161.181])
 by smtp.gmail.com with ESMTPSA id a2sm2442202wrv.15.2021.10.05.05.41.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Oct 2021 05:41:58 -0700 (PDT)
Subject: Re: [PATCH 1/1] drm/amdgpu: init debugfs drm driver callback
To: "Das, Nirmoy" <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Christian.Koenig@amd.com, shashank.sharma@amd.com
References: <20211005115856.59649-1-nirmoy.das@amd.com>
 <015bf2cf-f085-0d55-17e2-f9583e0533ec@gmail.com>
 <0e7ba8b4-9a66-6664-83af-839072458d7a@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <b10471fb-8978-4d68-9fd0-29c851454dc7@gmail.com>
Date: Tue, 5 Oct 2021 14:41:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <0e7ba8b4-9a66-6664-83af-839072458d7a@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
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



Am 05.10.21 um 14:20 schrieb Das, Nirmoy:
> Hi Christian,
>
> On 10/5/2021 2:01 PM, Christian König wrote:
>> Am 05.10.21 um 13:58 schrieb Nirmoy Das:
>>> drm_dev_register() will try to init driver's debugfs using
>>> drm_driver.debugfs_init call back function. Use that callback
>>> also for amdgpu to intialize debugfs.
>>
>> Mhm, why is that useful? We rather wanted to get rid of all this DRM 
>> midlayering.
>
>
> Actually main issue I am trying to solve is:
>
> When user disables debugfs with CONFIG_DEBUG_FS_ALLOW_NONE, amdgpu 
> gets EPERM and throws a DRM_ERROR even though it is not an error as 
> this is user controllable.
>
> Shall I just make all debugfs error logs to DRM_WARN ?
>
> ref: https://gitlab.freedesktop.org/drm/amd/-/issues/1686#note_1052168

Why not just add an "if (!root) return" at the beginning of 
amdgpu_debugfs_init() ?

Regards,
Christian.

>
> Regards,
>
> Nirmoy
>
>>
>> Christian.
>>
>>>
>>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 10 +++++-----
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h |  2 +-
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c     |  7 +++----
>>>   3 files changed, 9 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> index 6611b3c7c149..3076742f8f85 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> @@ -1611,8 +1611,9 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
>>>   DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
>>>               amdgpu_debugfs_sclk_set, "%llu\n");
>>>   -int amdgpu_debugfs_init(struct amdgpu_device *adev)
>>> +void amdgpu_debugfs_init(struct drm_minor *minor)
>>>   {
>>> +    struct amdgpu_device *adev = drm_to_adev(minor->dev);
>>>       struct dentry *root = adev_to_drm(adev)->primary->debugfs_root;
>>>       struct dentry *ent;
>>>       int r, i;
>>> @@ -1621,14 +1622,14 @@ int amdgpu_debugfs_init(struct amdgpu_device 
>>> *adev)
>>>                     &fops_ib_preempt);
>>>       if (IS_ERR(ent)) {
>>>           DRM_ERROR("unable to create amdgpu_preempt_ib debugsfs 
>>> file\n");
>>> -        return PTR_ERR(ent);
>>> +        return;
>>>       }
>>>         ent = debugfs_create_file("amdgpu_force_sclk", 0200, root, 
>>> adev,
>>>                     &fops_sclk_set);
>>>       if (IS_ERR(ent)) {
>>>           DRM_ERROR("unable to create amdgpu_set_sclk debugsfs 
>>> file\n");
>>> -        return PTR_ERR(ent);
>>> +        return;
>>>       }
>>>         /* Register debugfs entries for amdgpu_ttm */
>>> @@ -1682,11 +1683,10 @@ int amdgpu_debugfs_init(struct amdgpu_device 
>>> *adev)
>>>       debugfs_create_blob("amdgpu_discovery", 0444, root,
>>>                   &adev->debugfs_discovery_blob);
>>>   -    return 0;
>>>   }
>>>     #else
>>> -int amdgpu_debugfs_init(struct amdgpu_device *adev)
>>> +void amdgpu_debugfs_init(struct drm_minor *minor)
>>>   {
>>>       return 0;
>>>   }
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>>> index 371a6f0deb29..06b68e16e35d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>>> @@ -27,7 +27,7 @@
>>>    */
>>>     int amdgpu_debugfs_regs_init(struct amdgpu_device *adev);
>>> -int amdgpu_debugfs_init(struct amdgpu_device *adev);
>>> +void amdgpu_debugfs_init(struct drm_minor *minor);
>>>   void amdgpu_debugfs_fini(struct amdgpu_device *adev);
>>>   void amdgpu_debugfs_fence_init(struct amdgpu_device *adev);
>>>   void amdgpu_debugfs_firmware_init(struct amdgpu_device *adev);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> index df83b1f438b6..ceda650895db 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> @@ -2012,10 +2012,6 @@ static int amdgpu_pci_probe(struct pci_dev 
>>> *pdev,
>>>               drm_fbdev_generic_setup(adev_to_drm(adev), 32);
>>>       }
>>>   -    ret = amdgpu_debugfs_init(adev);
>>> -    if (ret)
>>> -        DRM_ERROR("Creating debugfs files failed (%d).\n", ret);
>>> -
>>>       return 0;
>>>     err_pci:
>>> @@ -2479,6 +2475,9 @@ static const struct drm_driver 
>>> amdgpu_kms_driver = {
>>>       .dumb_map_offset = amdgpu_mode_dumb_mmap,
>>>       .fops = &amdgpu_driver_kms_fops,
>>>       .release = &amdgpu_driver_release_kms,
>>> +#if defined(CONFIG_DEBUG_FS)
>>> +    .debugfs_init = amdgpu_debugfs_init,
>>> +#endif
>>>         .prime_handle_to_fd = drm_gem_prime_handle_to_fd,
>>>       .prime_fd_to_handle = drm_gem_prime_fd_to_handle,
>>

