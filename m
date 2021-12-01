Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE20DC433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Dec 2021 10:49:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AE796EB22;
	Wed,  1 Dec 2021 10:49:04 +0000 (UTC)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E26DE6EB22
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Dec 2021 10:49:03 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id s13so51269012wrb.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 01 Dec 2021 02:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=lAvJICLiRTTvp7xwxKbwo9bd1CS/wNsNWLWwSSLODZE=;
 b=SWZb94LmgM5gfegtgJPgzya29FEvVEy+TVZ+VPOvi5Or0yJDjMkzozk2+VVDZBvU+v
 MOGaYXJwaHAp0kc7pFu8ZbMJUdmxQA+L+3BtwUWXyH7xuqQ0eAg78rWDtyhCTdHP+apk
 UrqrUhGDcDa+iBHzGeZXrGKjFyT93qIqvnupqN7N+K2HkrEqGPLrqsGI5wmVt6FTjc6C
 66g5S9uG9jYmK9lETK9KkvoU36m0kAqQq+eyZoL1IvJprR+Yw0/X5gIFNEaGa8GhNeDE
 OU8rJn4YnRnxxDRVR+OmddocbSuew60BuaH2ybzYH5wDADFJXT9l3G5N2Kiavx94ruyl
 +N6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=lAvJICLiRTTvp7xwxKbwo9bd1CS/wNsNWLWwSSLODZE=;
 b=C90IcWmRJ9gIy4JTHmOVaaXQXkuYKJ4YK0EAKNT1/LbVNlnXGS7UmwLoO8Pl+gg+97
 rPkR1oJF0rU37mWhq0FIYUnzxky80Sl8MyMstaEvcqZfBypdefIWHB57rBqOVKTNuBed
 ZoR1yxocHQ9Tf52GjrHpn6Rn13QkJMvGb/UsQU7Cj0fnU9eqbxXguxBzKeO6NHDGzvr4
 kyRCGXQdof/UpO0IFppzNVAz0YiksQe2qGITs4/UQWXgnCazbP5ktO0YLwlXYFWFNXtH
 ZtCcJ1Syblcej8k9a8cpSFpC3ElNlKpg1MiZGv2aDkNRKQHEDQFnLkPR1610FCR4lcV9
 Xlxg==
X-Gm-Message-State: AOAM531W7Usnga05L/La2lkTEgU04d+c2Rl2amgE+kMXW1fLEfFj/xsT
 BoSuMiIL6qFFTzVuc0+0rCA=
X-Google-Smtp-Source: ABdhPJxcnmya0MG/0pCsMsEauRhhm2rRsi5B1WryvHM3ipiQQy8tIATVAJRFgZgnZ3FE5YqhSDZUWA==
X-Received: by 2002:adf:a48e:: with SMTP id g14mr5706143wrb.474.1638355742352; 
 Wed, 01 Dec 2021 02:49:02 -0800 (PST)
Received: from [192.168.178.21] (p57b0b77b.dip0.t-ipconnect.de.
 [87.176.183.123])
 by smtp.gmail.com with ESMTPSA id y6sm19372280wrh.18.2021.12.01.02.49.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Dec 2021 02:49:01 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: add support to SMU debug option
To: "Yu, Lang" <Lang.Yu@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20211201092458.3348858-1-lang.yu@amd.com>
 <f7e0dfb0-cdb0-13f2-49e4-d13366a23e0f@amd.com>
 <DM6PR12MB4250974428DA6713B8BC4802FB689@DM6PR12MB4250.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <0ee705b0-d9fe-4339-9381-9fe058dfbd3f@gmail.com>
Date: Wed, 1 Dec 2021 11:48:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <DM6PR12MB4250974428DA6713B8BC4802FB689@DM6PR12MB4250.namprd12.prod.outlook.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 01.12.21 um 11:44 schrieb Yu, Lang:
> [AMD Official Use Only]
>
>
>
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Wednesday, December 1, 2021 5:30 PM
>> To: Yu, Lang <Lang.Yu@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Lazar, Lijo
>> <Lijo.Lazar@amd.com>; Huang, Ray <Ray.Huang@amd.com>
>> Subject: Re: [PATCH] drm/amdgpu: add support to SMU debug option
>>
>> Am 01.12.21 um 10:24 schrieb Lang Yu:
>>> To maintain system error state when SMU errors occurred, which will
>>> aid in debugging SMU firmware issues, add SMU debug option support.
>>>
>>> It can be enabled or disabled via amdgpu_smu_debug debugfs file. When
>>> enabled, it makes SMU errors fatal.
>>> It is disabled by default.
>>>
>>> == Command Guide ==
>>>
>>> 1, enable SMU debug option
>>>
>>>    # echo 1 > /sys/kernel/debug/dri/0/amdgpu_smu_debug
>>>
>>> 2, disable SMU debug option
>>>
>>>    # echo 0 > /sys/kernel/debug/dri/0/amdgpu_smu_debug
>>>
>>> v3:
>>>    - Use debugfs_create_bool().(Christian)
>>>    - Put variable into smu_context struct.
>>>    - Don't resend command when timeout.
>>>
>>> v2:
>>>    - Resend command when timeout.(Lijo)
>>>    - Use debugfs file instead of module parameter.
>>>
>>> Signed-off-by: Lang Yu <lang.yu@amd.com>
>> Well the debugfs part looks really nice and clean now, but one more comment
>> below.
>>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c        | 3 +++
>>>    drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h            | 5 +++++
>>>    drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 2 ++
>>>    drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c             | 8 +++++++-
>>>    4 files changed, 17 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> index 164d6a9e9fbb..86cd888c7822 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> @@ -1618,6 +1618,9 @@ int amdgpu_debugfs_init(struct amdgpu_device
>> *adev)
>>>    	if (!debugfs_initialized())
>>>    		return 0;
>>>
>>> +	debugfs_create_bool("amdgpu_smu_debug", 0600, root,
>>> +				  &adev->smu.smu_debug_mode);
>>> +
>>>    	ent = debugfs_create_file("amdgpu_preempt_ib", 0600, root, adev,
>>>    				  &fops_ib_preempt);
>>>    	if (IS_ERR(ent)) {
>>> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
>>> b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
>>> index f738f7dc20c9..50dbf5594a9d 100644
>>> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
>>> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
>>> @@ -569,6 +569,11 @@ struct smu_context
>>>    	struct smu_user_dpm_profile user_dpm_profile;
>>>
>>>    	struct stb_context stb_context;
>>> +	/*
>>> +	 * When enabled, it makes SMU errors fatal.
>>> +	 * (0 = disabled (default), 1 = enabled)
>>> +	 */
>>> +	bool smu_debug_mode;
>>>    };
>>>
>>>    struct i2c_adapter;
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
>>> b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
>>> index 6e781cee8bb6..d3797a2d6451 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
>>> @@ -1919,6 +1919,8 @@ static int aldebaran_mode2_reset(struct
>> smu_context *smu)
>>>    out:
>>>    	mutex_unlock(&smu->message_lock);
>>>
>>> +	BUG_ON(unlikely(smu->smu_debug_mode) && ret);
>>> +
>>>    	return ret;
>>>    }
>>>
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>> b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>> index 048ca1673863..9be005eb4241 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>> @@ -349,15 +349,21 @@ int smu_cmn_send_smc_msg_with_param(struct
>> smu_context *smu,
>>>    		__smu_cmn_reg_print_error(smu, reg, index, param, msg);
>>>    		goto Out;
>>>    	}
>>> +
>>>    	__smu_cmn_send_msg(smu, (uint16_t) index, param);
>>>    	reg = __smu_cmn_poll_stat(smu);
>>>    	res = __smu_cmn_reg2errno(smu, reg);
>>> -	if (res != 0)
>>> +	if (res != 0) {
>>>    		__smu_cmn_reg_print_error(smu, reg, index, param, msg);
>>> +		goto Out;
>>> +	}
>>>    	if (read_arg)
>>>    		smu_cmn_read_arg(smu, read_arg);
>>>    Out:
>>>    	mutex_unlock(&smu->message_lock);
>>> +
>>> +	BUG_ON(unlikely(smu->smu_debug_mode) && res);
>> BUG_ON() really crashes the kernel and is only allowed if we prevent further data
>> corruption with that.
>>
>> Most of the time WARN_ON() is more appropriate, but I can't fully judge here
>> since I don't know the SMU code well enough.
> This is what SMU FW guys want. They want "user-visible (potentially fatal) errors", then a hang.
> They want to keep system state since the error occurred.

Well that is rather problematic.

First of all we need to really justify that, crashing the kernel is not 
something easily done.

Then this isn't really effective here. What happens is that you crash 
the kernel thread of the currently executing process, but it is 
perfectly possible that another thread still tries to send messages to 
the SMU. You need to have the BUG_ON() before dropping the lock to make 
sure that this really gets the driver stuck in the current state.

Regards,
Christian.

>
> Regards,
> Lang
>
>> Christian.
>>
>>> +
>>>    	return res;
>>>    }
>>>

