Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10F4DC433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Dec 2021 13:11:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1B836FB6B;
	Wed,  1 Dec 2021 13:11:46 +0000 (UTC)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD78B6FB6B
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Dec 2021 13:11:45 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id a9so52166560wrr.8
 for <amd-gfx@lists.freedesktop.org>; Wed, 01 Dec 2021 05:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=KFbh8MSl1Y53q9RvVesxr98PxoFfMiwYBGndNYOAKco=;
 b=DdEa0l29zYUOnfuvKI8oCt6d6ycp0WGNdXvjx9olPxiqSvZzv6Og2PakjL4er6FZVu
 wTEHgYwNBpC6Z6C8PoEhxyoenI+hvGqbnB9/FIXrZgc05ei91uOn6lCBhe/ci4XZYejh
 09upoIiGSJ+Q0au/NZnXPr9IdLUbwNo0PHNg+WkcIqw2v9DmHJoPbbQs1cUSd74mcote
 0GIeJJLFtLreUGz/WOabADASBZuYdSGUkr2FKybNETn0sXCAmbQnf1W1gh3RjroLO1Cg
 a3rM65gI9KRsve12KFmyrkoxYrehhwOADA48cZjzK5IhjpNUZ4Ehz950dMaozf0SjzmZ
 Z64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=KFbh8MSl1Y53q9RvVesxr98PxoFfMiwYBGndNYOAKco=;
 b=TwNQ8dYH7E+P9yANXGYeN6V23UWQehn3m3qRAJLHu11o/WUmYaCc8834NFKSYHm8Qu
 ZNigHopdvtJn2pWh2eHCUqUdyyCcuhWHrmD5fmEkDwHCDuewKmEDXvRvmVeDbAGpuwBG
 /neyuIyW1++qyo5uL15LMcuN+0rysdJLekjMA/A0OOhs/LzCATH3DJX8nsyRyrBqQdTF
 QEOTyaG1hiAjSB6yzJ0ARiuC2cVdHMICo+dT/CGN9Yo4CSWTQheeTElt+ibrFMvDdoiV
 hREdg9VgljP7+uOm9/ekZSypI+giytup3YK4G48K0/LusvpAMRrt2Z7loVp4NOuC89uW
 nRiQ==
X-Gm-Message-State: AOAM533EHaap6WMgp/X4/tygOEongXUFlWwih3361jY8eKDnVhss1D9i
 x2L+E2AZaAXiKvOoEl9w5HDw06kdcgI=
X-Google-Smtp-Source: ABdhPJzsdxHxuPLFCjK2JhoRe4YSc2ElIb8ReenwUK4NsMOOgoKocwl/cKhiJhEHwUTkzNkT0aC8cA==
X-Received: by 2002:a5d:6dc1:: with SMTP id d1mr6558210wrz.282.1638364304334; 
 Wed, 01 Dec 2021 05:11:44 -0800 (PST)
Received: from [192.168.178.21] (p57b0b77b.dip0.t-ipconnect.de.
 [87.176.183.123])
 by smtp.gmail.com with ESMTPSA id o25sm1013431wms.17.2021.12.01.05.11.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Dec 2021 05:11:44 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: add support to SMU debug option
To: "Yu, Lang" <Lang.Yu@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
References: <20211201092458.3348858-1-lang.yu@amd.com>
 <f7e0dfb0-cdb0-13f2-49e4-d13366a23e0f@amd.com>
 <DM6PR12MB4250974428DA6713B8BC4802FB689@DM6PR12MB4250.namprd12.prod.outlook.com>
 <0ee705b0-d9fe-4339-9381-9fe058dfbd3f@gmail.com>
 <DM6PR12MB42505899AFB96290F516C21BFB689@DM6PR12MB4250.namprd12.prod.outlook.com>
 <e3bdf34e-b18c-695b-fc58-73426760935b@amd.com>
 <DM6PR12MB4250CB4C8DE2869BB8BD55D1FB689@DM6PR12MB4250.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <0bf2d85f-d879-9402-a953-a637ece495d2@gmail.com>
Date: Wed, 1 Dec 2021 14:11:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <DM6PR12MB4250CB4C8DE2869BB8BD55D1FB689@DM6PR12MB4250.namprd12.prod.outlook.com>
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

Adding Andrey as well.

Am 01.12.21 um 12:37 schrieb Yu, Lang:
> [SNIP]
>>>>>>> +	BUG_ON(unlikely(smu->smu_debug_mode) && res);
>>>>>> BUG_ON() really crashes the kernel and is only allowed if we
>>>>>> prevent further data corruption with that.
>>>>>>
>>>>>> Most of the time WARN_ON() is more appropriate, but I can't fully
>>>>>> judge here since I don't know the SMU code well enough.
>>>>> This is what SMU FW guys want. They want "user-visible (potentially
>>>>> fatal)
>>>> errors", then a hang.
>>>>> They want to keep system state since the error occurred.
>>>> Well that is rather problematic.
>>>>
>>>> First of all we need to really justify that, crashing the kernel is
>>>> not something easily done.
>>>>
>>>> Then this isn't really effective here. What happens is that you crash
>>>> the kernel thread of the currently executing process, but it is
>>>> perfectly possible that another thread still tries to send messages
>>>> to the SMU. You need to have the BUG_ON() before dropping the lock to
>>>> make sure that this really gets the driver stuck in the current state.
>>> Thanks. I got it. I just thought it is a kenel panic.
>>> Could we use a panic() here?
>> Potentially, but that might reboot the system automatically which is probably not
>> what you want either.
>>
>> How does the SMU firmware team gather the necessary information when a
>> problem occurs?
> As far as I know, they usually use a HDT to collect information.
> And they request a hang when error occurred in ticket.
> "Suggested error responses include pop-up windows (by x86 driver, if this is possible) or simply hanging after logging the error."

In that case I suggest to set the "don't_touch_the_hardware_any_more" 
procedure we also use in case of PCIe hotplug.

Andrey has the details but essentially it stops the driver from touching 
the hardware any more, signals all fences and unblocks everything.

It should then be trivial to inspect the hardware state and see what's 
going on, but the system will keep stable at least for SSH access.

Might be a good idea to have that mode for other fault cases like page 
faults and hardware crashes.

Regards,
Christian.

>
> Regards,
> Lang
>

