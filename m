Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F098EE95A91
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Oct 2023 08:41:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 759D310E0E4;
	Mon,  9 Oct 2023 08:41:45 +0000 (UTC)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA37F10E230
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Oct 2023 08:41:42 +0000 (UTC)
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-533d31a8523so7600957a12.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Oct 2023 01:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696840901; x=1697445701; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ApCrJAyOyFeWefTOoFwImp0y/CPgSMlbofMcbpkts10=;
 b=Wx36VI570z0QQxC09E17T25ay5cIkonB2zShaHXezwXjgW5t6RwySRVhSjbJSw0fSO
 42qF7UCYpPNBt0BoY2GgIni/oZj/WVrlfaHFmIEP3Vzm2gtVZPSZ/vvETIsmIwL9bCUQ
 A2XSAFXYyXWzOdLNdUG8Bxbo81y7SuccEOVHcpFzeiQYu7P+wHlgdu/BhUobadBKbqHQ
 4Sid/p/TJmfn/0hf5kIoNYGoiKn/BZn6qCq/SIRHUs3NO71Ax6bb/zOOFgR84QP893iy
 BttsaFKIGfytjVydhrbBjkx3fPsbVL5e8uHhhUTLdShf4g4+D3svnArVlWHY54sTHK3v
 6ShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696840901; x=1697445701;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ApCrJAyOyFeWefTOoFwImp0y/CPgSMlbofMcbpkts10=;
 b=Eb/T4v3Uusj9zPa+eCHo4GjKq+FWMkA/OLUlqPVLSVqbmkb4LqmPjTBKwj1CuoAQ8f
 YrYS1EMGfwvj6BuVMyLAmhSa++KhK4PpXoMXCTY1aECg7AyhrLWUtXh479EcePSPZFSv
 eN5aUaHtClByTNvOoSdRmfGLfFUXWigKiABAiukH6VywG8MO6twIiqcFDmdt2RgSvHPp
 Hh+rZGVX6ZTtvH28/XKvc5m0rqZ9SfP4vpWCuqm4JSC6TDbS4fnW4i51+MWmXP1UJV39
 YhyLexsmukjghDjB0cV8bTR6FbNKoyT8voeMCnjFvpTdtWnVsEMJ17YdJxuskEYuZiEd
 3Qng==
X-Gm-Message-State: AOJu0YyM7aPZORclhIkJMwSt8cMPY0iROkl8UN18lFrklnqklp5IaKgu
 mSRJC33F+yOmbNXh6yRZGn8=
X-Google-Smtp-Source: AGHT+IGndSqLsa/XTSD478OScIkZI1V+VA11c7KVkSj2xCVtFSvh9Qy8fFc/Q9W3WMabYU6uhkyXwQ==
X-Received: by 2002:aa7:c998:0:b0:530:ccf7:37af with SMTP id
 c24-20020aa7c998000000b00530ccf737afmr12569146edt.12.1696840900781; 
 Mon, 09 Oct 2023 01:41:40 -0700 (PDT)
Received: from [192.168.178.25] ([134.19.31.182])
 by smtp.gmail.com with ESMTPSA id
 bf14-20020a0564021a4e00b005362bcc089csm5711033edb.67.2023.10.09.01.41.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Oct 2023 01:41:40 -0700 (PDT)
Message-ID: <11992882-b7ff-4fe5-8777-755f128472e9@gmail.com>
Date: Mon, 9 Oct 2023 10:41:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] drm/amd/pm: Add sysfs attribute to get pm log
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <20231006052149.1566154-1-lijo.lazar@amd.com>
 <20231006052149.1566154-4-lijo.lazar@amd.com>
 <007b0fed-4982-4978-95e3-6763d114a97e@gmail.com>
 <CADnq5_MzHbigYydWy9xkT_rgNEpogU8+y4bodAy1NxD99acnZQ@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CADnq5_MzHbigYydWy9xkT_rgNEpogU8+y4bodAy1NxD99acnZQ@mail.gmail.com>
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
Cc: Alexander.Deucher@amd.com, Lijo Lazar <lijo.lazar@amd.com>,
 kevinyang.wang@amd.com, amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 06.10.23 um 16:24 schrieb Alex Deucher:
> On Fri, Oct 6, 2023 at 4:32 AM Christian König
> <ckoenig.leichtzumerken@gmail.com> wrote:
>> Am 06.10.23 um 07:21 schrieb Lijo Lazar:
>>> Add sysfs attribute to read power management log. A snapshot is
>>> captured to the buffer when the attribute is read.
>>>
>>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>>> ---
>>>
>>> v2: Pass PAGE_SIZE as the max size of input buffer
>>>
>>>    drivers/gpu/drm/amd/pm/amdgpu_pm.c | 40 ++++++++++++++++++++++++++++++
>>>    1 file changed, 40 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>>> index 4c65a2fac028..5a1d21c52672 100644
>>> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>>> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>>> @@ -1794,6 +1794,44 @@ static ssize_t amdgpu_set_apu_thermal_cap(struct device *dev,
>>>        return count;
>>>    }
>>>
>>> +static int amdgpu_pmlog_attr_update(struct amdgpu_device *adev,
>>> +                                 struct amdgpu_device_attr *attr,
>>> +                                 uint32_t mask,
>>> +                                 enum amdgpu_device_attr_states *states)
>>> +{
>>> +     if (amdgpu_dpm_get_pm_log(adev, NULL, 0) == -EOPNOTSUPP)
>>> +             *states = ATTR_STATE_UNSUPPORTED;
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static ssize_t amdgpu_get_pmlog(struct device *dev,
>>> +                             struct device_attribute *attr, char *buf)
>>> +{
>>> +     struct drm_device *ddev = dev_get_drvdata(dev);
>>> +     struct amdgpu_device *adev = drm_to_adev(ddev);
>>> +     ssize_t size = 0;
>>> +     int ret;
>>> +
>>> +     if (amdgpu_in_reset(adev))
>>> +             return -EPERM;
>> Please stop using amdgpu_in_reset() for stuff like that altogether.
>>
>> When this is reset critical it should grab the reset rw semaphore. If it
>> isn't than that check isn't necessary.
> All of the power related sysfs files have this check.  It was
> originally added because users have processes running which poll
> various hwmon files at regular intervals and since SMU also handles
> reset, we don't want to get a metrics table request while a reset is
> happening otherwise the SMU gets confused.

Then this approach is completely broken. Nothing prevents the reset from 
starting right after doing the check.

If we need exclusive access to the SMU then we should just grab a lock.

Christian.

>
> Alex
>
>> Regards,
>> Christian.
>>
>>> +     if (adev->in_suspend && !adev->in_runpm)
>>> +             return -EPERM;
>>> +
>>> +     ret = pm_runtime_get_sync(ddev->dev);
>>> +     if (ret < 0) {
>>> +             pm_runtime_put_autosuspend(ddev->dev);
>>> +             return ret;
>>> +     }
>>> +
>>> +     size = amdgpu_dpm_get_pm_log(adev, buf, PAGE_SIZE);
>>> +
>>> +     pm_runtime_mark_last_busy(ddev->dev);
>>> +     pm_runtime_put_autosuspend(ddev->dev);
>>> +
>>> +     return size;
>>> +}
>>> +
>>>    /**
>>>     * DOC: gpu_metrics
>>>     *
>>> @@ -2091,6 +2129,8 @@ static struct amdgpu_device_attr amdgpu_device_attrs[] = {
>>>        AMDGPU_DEVICE_ATTR_RW(smartshift_bias,                          ATTR_FLAG_BASIC,
>>>                              .attr_update = ss_bias_attr_update),
>>>        AMDGPU_DEVICE_ATTR_RW(xgmi_plpd_policy,                         ATTR_FLAG_BASIC),
>>> +     AMDGPU_DEVICE_ATTR_RO(pmlog,                                    ATTR_FLAG_BASIC,
>>> +                           .attr_update = amdgpu_pmlog_attr_update),
>>>    };
>>>
>>>    static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_attr *attr,

