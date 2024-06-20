Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54E08C2BA18
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jun 2024 13:06:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A75A510E9C1;
	Thu, 20 Jun 2024 13:06:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=damsy.net header.i=@damsy.net header.b="h8Z/91Pd";
	dkim=permerror (0-bit key) header.d=damsy.net header.i=@damsy.net header.b="URTK9x2C";
	dkim-atps=neutral
Received: from bunu.damsy.net (bunu.damsy.net [51.159.160.159])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34F2B10E9C1
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jun 2024 13:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202404r; d=damsy.net; c=relaxed/relaxed; 
 h=From:To:Subject:Date:Message-ID; t=1718888772;
 bh=B8db4QMptL2lrBZhDBghPm9
 t1MPqkQYVOQoxBMIZpNw=; b=h8Z/91PdsFxYh4KqdxEjNp3xs8R5HWhwrHFCa/M3/VHxsT3aTp
 XhlGsWozP9hMeVfgfVdI2nQWF50AO8DjHZP1xz9PcajafyOuasetpCPLeOvdtDYb3WgEHkUxbBN
 VZOyOfjHRUGm2pNDq6dNvzWHphwFBIpTFZkryvbG1VWmIikwXjio/9JQQbKtG8LBNbI0G8hzeFY
 JDMUZCSgBTsH/ICKSQswJWRmCE/mBxkOXGefnfX7GzMI+uEYWd5HtmDYRaHjgf39rmhucFUVwlk
 MzUMpMSqUylAdEGpnrWe1loDFMaN2i/PTAqGw2CeIS2qmabzTzjGbzpbGqjiC7+LzQA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202404e; d=damsy.net;
 c=relaxed/relaxed; 
 h=From:To:Subject:Date:Message-ID; t=1718888772; bh=B8db4QMptL2lrBZhDBghPm9
 t1MPqkQYVOQoxBMIZpNw=; b=URTK9x2CEb8cbXMFn7aQUEsRMlETnHqY2KwoZCYHhL9HsJCCDd
 P2O9l43FihmR5m2Hd9JDcTkxMA7ThZmcJzDg==;
Message-ID: <d2eefecf-656e-4c9c-96b3-717756581cc1@damsy.net>
Date: Thu, 20 Jun 2024 15:06:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] drm/amdgpu: allow ioctls to opt-out of runtime pm
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
References: <20240618153003.146168-1-pierre-eric.pelloux-prayer@amd.com>
 <20240618153003.146168-2-pierre-eric.pelloux-prayer@amd.com>
 <c45283a1-98d2-43a2-a73c-71896464c7f9@amd.com>
Content-Language: en-US
From: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>
In-Reply-To: <c45283a1-98d2-43a2-a73c-71896464c7f9@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Le 19/06/2024 à 11:26, Christian König a écrit :
> Am 18.06.24 um 17:23 schrieb Pierre-Eric Pelloux-Prayer:
>> Waking up a device can take multiple seconds, so if it's not
>> going to be used we might as well not resume it.
>>
>> The safest default behavior for all ioctls is to resume the GPU,
>> so this change allows specific ioctls to opt-out of generic
>> runtime pm.
> 
> I'm really wondering if we shouldn't put that into the IOCTL description.
> 
> See amdgpu_ioctls_kms and DRM_IOCTL_DEF_DRV() for what I mean.

Are you suggesting to add a new entry in enum drm_ioctl_flags to 
indicate ioctls which need the device to be awake?

Something like: "DRM_NO_DEVICE = BIT(6)" and then use it for both
core and amdgpu ioctls?

Pierre-Eric




> 
> Regards,
> Christian.
> 
>>
>> Signed-off-by: Pierre-Eric Pelloux-Prayer 
>> <pierre-eric.pelloux-prayer@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 25 ++++++++++++++++++++-----
>>   1 file changed, 20 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index 60d5758939ae..a9831b243bfc 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -2855,18 +2855,33 @@ long amdgpu_drm_ioctl(struct file *filp,
>>   {
>>       struct drm_file *file_priv = filp->private_data;
>>       struct drm_device *dev;
>> +    bool needs_device;
>>       long ret;
>>       dev = file_priv->minor->dev;
>> -    ret = pm_runtime_get_sync(dev->dev);
>> -    if (ret < 0)
>> -        goto out;
>> +
>> +    /* Some ioctl can opt-out of powermanagement handling
>> +     * if they don't require the device to be resumed.
>> +     */
>> +    switch (cmd) {
>> +    default:
>> +        needs_device = true;
>> +    }
>> +
>> +    if (needs_device) {
>> +        ret = pm_runtime_get_sync(dev->dev);
>> +        if (ret < 0)
>> +            goto out;
>> +    }
>>       ret = drm_ioctl(filp, cmd, arg);
>> -    pm_runtime_mark_last_busy(dev->dev);
>>   out:
>> -    pm_runtime_put_autosuspend(dev->dev);
>> +    if (needs_device) {
>> +        pm_runtime_mark_last_busy(dev->dev);
>> +        pm_runtime_put_autosuspend(dev->dev);
>> +    }
>> +
>>       return ret;
>>   }
