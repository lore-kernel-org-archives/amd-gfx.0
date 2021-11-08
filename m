Return-Path: <SRS0=eROb=P3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5A1C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Nov 2021 10:26:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0628161215
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Nov 2021 10:26:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0628161215
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98F9C6E952;
	Mon,  8 Nov 2021 10:26:22 +0000 (UTC)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19E4B6E952
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Nov 2021 10:26:21 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id d27so25954604wrb.6
 for <amd-gfx@lists.freedesktop.org>; Mon, 08 Nov 2021 02:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=hsQH2fE6VJQeiEij9uuQ8MHinmNWBfib8qibm2KgQmk=;
 b=J2ZtFxbwmRT07cZnD5HbQMu5gQ8DOdCxulfke2rB3+zNFq9I75blurFS7cADlCWZnE
 CdkuTyGVMY8UXCNdSs5WmHAzPfxagSevKphgcP9xwd9A6bOmyWONxXba5P+2WKW/VMD1
 TCHTBuGUAlOGazKsqj/VNp7Vw/cquR8Vek4Sn3UnZhNCiAK3JfZkV2zSd/QbLa6EyfWa
 x3ZCnCLylqrpe7qQsvTbZUjvN3t/E+5C5gJwJZRGuqXJcQIRM5vZM7DIYT5GoYHkheg7
 jh9m1k6Ojhs427Q5qdI9Q/hOF40NsaIa0Tw9nSxT+6r1TSf4Pc7RrRfmbsolRYgGzCIJ
 pB2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=hsQH2fE6VJQeiEij9uuQ8MHinmNWBfib8qibm2KgQmk=;
 b=aO0D41y5jdeggAxT/+OFSXGGmU0zd76wWorhvqw6ERiSUWYhEsOlNkCmf85InpwTWS
 YFOOp9Oif/Obw9d/xi+II3q4sTE2cjffaCXVLkHdPXviVQ9Vx4tYjXiggojP17mibv7n
 ed1BppZjmVnODBuzosiE59H/MgomhQ66+xG9XA76afNS1STd8Wp1vyt49GUwKmhldQO1
 BzEVNz8T00fBcTYAqiy4T7mDlQvygSH6zuPB9p8718NmWkC5dimhL5z1qr2U02gjoNHy
 B1fdbsvhMI5Cg6Cvjn9fffEzXTgoFCLACfm4Y/1RzvIHm25xrneFW9rT8SY6836DqXRW
 8riQ==
X-Gm-Message-State: AOAM5338x1NFWwdcA42pCKy/Pzqk/SR+tM89rTGN0q1knnS90lT5pFJi
 /IUpLBwZGXeGJKoliVcVVFNOg7EMWE4=
X-Google-Smtp-Source: ABdhPJwWX8Kcj3dBa+A+wDfU/aQ+Yr0qnTQJoPRTNAj1mbP+r24QQQxA4efUDEmuF45o6GQoPaRlBQ==
X-Received: by 2002:adf:f44e:: with SMTP id f14mr98033179wrp.37.1636367179643; 
 Mon, 08 Nov 2021 02:26:19 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:308a:d18e:268b:408f?
 ([2a02:908:1252:fb60:308a:d18e:268b:408f])
 by smtp.gmail.com with ESMTPSA id f7sm10417208wri.74.2021.11.08.02.26.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Nov 2021 02:26:19 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: fix the Carrizo UVD hang on system reboot
To: "Quan, Evan" <Evan.Quan@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20211104081931.467399-1-evan.quan@amd.com>
 <675b8367-3b91-a565-f656-fe46ba65723c@amd.com>
 <DM6PR12MB261981F9883D33EA4A9BD549E48E9@DM6PR12MB2619.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <1130a777-3aa8-425e-cc39-44b49edfc32e@gmail.com>
Date: Mon, 8 Nov 2021 11:26:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <DM6PR12MB261981F9883D33EA4A9BD549E48E9@DM6PR12MB2619.namprd12.prod.outlook.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 05.11.21 um 08:58 schrieb Quan, Evan:
> [AMD Official Use Only]
>
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Thursday, November 4, 2021 4:55 PM
>> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Subject: Re: [PATCH] drm/amdgpu: fix the Carrizo UVD hang on system
>> reboot
>>
>>
>>
>> On 11/4/2021 1:49 PM, Evan Quan wrote:
>>> It's confirmed that on some APUs the interaction with SMU about DPM
>>> disablement will power off the UVD completely. Thus the succeeding
>>> interactions with UVD during the reboot will trigger hard hang. To
>>> workaround this issue, we will skip the dpm disablement on APUs.
>>>
>>> Signed-off-by: Evan Quan <evan.quan@amd.com>
>>> Change-Id: I4340cc2fb0fd94f439cbac5d4963fe920866bc13
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c | 20 ++++++++++--------
>>>    drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c | 30
>> +++++++++++++++++++--------
>>>    drivers/gpu/drm/amd/amdgpu/vce_v2_0.c | 18 +++++++++-------
>>>    drivers/gpu/drm/amd/amdgpu/vce_v3_0.c | 18 +++++++++-------
>>>    4 files changed, 52 insertions(+), 34 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
>>> b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
>>> index c108b8381795..67ec13622e51 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
>>> @@ -238,15 +238,17 @@ static int uvd_v4_2_suspend(void *handle)
>>>    	 */
>>>    	cancel_delayed_work_sync(&adev->uvd.idle_work);
>> If the idle work handler had already started execution, it also goes through
>> the same logic. Wouldn't that be a problem? The other case is if decode work
>> is already completed before suspend is called, then also it disables DPM. Not
>> sure how it works then, or is this caused by a second atempt to power off
>> again after idle work is executed?
> [Quan, Evan] Good point. Yes, maybe there should not be 2nd attempt when the target IP is already in the desired state.
> Let me confirm with Boris.

It sounds like you not only need to prevent the clock gating, but also 
enable the clocks during shutdown.

Regards,
Christian.

>
> BR
> Evan
>> Thanks,
>> Lijo
>>
>>> -	if (adev->pm.dpm_enabled) {
>>> -		amdgpu_dpm_enable_uvd(adev, false);
>>> -	} else {
>>> -		amdgpu_asic_set_uvd_clocks(adev, 0, 0);
>>> -		/* shutdown the UVD block */
>>> -		amdgpu_device_ip_set_powergating_state(adev,
>> AMD_IP_BLOCK_TYPE_UVD,
>>> -						       AMD_PG_STATE_GATE);
>>> -		amdgpu_device_ip_set_clockgating_state(adev,
>> AMD_IP_BLOCK_TYPE_UVD,
>>> -						       AMD_CG_STATE_GATE);
>>> +	if (!(adev->flags & AMD_IS_APU)) {
>>> +		if (adev->pm.dpm_enabled) {
>>> +			amdgpu_dpm_enable_uvd(adev, false);
>>> +		} else {
>>> +			amdgpu_asic_set_uvd_clocks(adev, 0, 0);
>>> +			/* shutdown the UVD block */
>>> +			amdgpu_device_ip_set_powergating_state(adev,
>> AMD_IP_BLOCK_TYPE_UVD,
>>> +
>> AMD_PG_STATE_GATE);
>>> +			amdgpu_device_ip_set_clockgating_state(adev,
>> AMD_IP_BLOCK_TYPE_UVD,
>>> +
>> AMD_CG_STATE_GATE);
>>> +		}
>>>    	}
>>>
>>>    	r = uvd_v4_2_hw_fini(adev);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
>>> b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
>>> index 2d558c2f417d..60d05ec8c953 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
>>> @@ -560,15 +560,27 @@ static int uvd_v6_0_suspend(void *handle)
>>>    	 */
>>>    	cancel_delayed_work_sync(&adev->uvd.idle_work);
>>>
>>> -	if (adev->pm.dpm_enabled) {
>>> -		amdgpu_dpm_enable_uvd(adev, false);
>>> -	} else {
>>> -		amdgpu_asic_set_uvd_clocks(adev, 0, 0);
>>> -		/* shutdown the UVD block */
>>> -		amdgpu_device_ip_set_powergating_state(adev,
>> AMD_IP_BLOCK_TYPE_UVD,
>>> -						       AMD_PG_STATE_GATE);
>>> -		amdgpu_device_ip_set_clockgating_state(adev,
>> AMD_IP_BLOCK_TYPE_UVD,
>>> -						       AMD_CG_STATE_GATE);
>>> +	/*
>>> +	 * It's confirmed that on some APUs the interaction with SMU(about
>> DPM disablement)
>>> +	 * will power off the UVD. That will make the succeeding interactions
>> with UVD on the
>>> +	 * suspend path impossible. And the system will hang due to that. To
>> workaround the
>>> +	 * issue, we will skip the dpm disablement on APUs.
>>> +	 *
>>> +	 * TODO: a better solution is to reorg the action chains performed on
>> suspend and make
>>> +	 * the dpm disablement the last one. But that will involve a lot and
>> needs MM team's
>>> +	 * help.
>>> +	 */
>>> +	if (!(adev->flags & AMD_IS_APU)) {
>>> +		if (adev->pm.dpm_enabled) {
>>> +			amdgpu_dpm_enable_uvd(adev, false);
>>> +		} else {
>>> +			amdgpu_asic_set_uvd_clocks(adev, 0, 0);
>>> +			/* shutdown the UVD block */
>>> +			amdgpu_device_ip_set_powergating_state(adev,
>> AMD_IP_BLOCK_TYPE_UVD,
>>> +
>> AMD_PG_STATE_GATE);
>>> +			amdgpu_device_ip_set_clockgating_state(adev,
>> AMD_IP_BLOCK_TYPE_UVD,
>>> +
>> AMD_CG_STATE_GATE);
>>> +		}
>>>    	}
>>>
>>>    	r = uvd_v6_0_hw_fini(adev);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
>>> b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
>>> index 67eb01fef789..8aa9d8c07053 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
>>> @@ -505,14 +505,16 @@ static int vce_v2_0_suspend(void *handle)
>>>    	 */
>>>    	cancel_delayed_work_sync(&adev->vce.idle_work);
>>>
>>> -	if (adev->pm.dpm_enabled) {
>>> -		amdgpu_dpm_enable_vce(adev, false);
>>> -	} else {
>>> -		amdgpu_asic_set_vce_clocks(adev, 0, 0);
>>> -		amdgpu_device_ip_set_powergating_state(adev,
>> AMD_IP_BLOCK_TYPE_VCE,
>>> -						       AMD_PG_STATE_GATE);
>>> -		amdgpu_device_ip_set_clockgating_state(adev,
>> AMD_IP_BLOCK_TYPE_VCE,
>>> -						       AMD_CG_STATE_GATE);
>>> +	if (!(adev->flags & AMD_IS_APU)) {
>>> +		if (adev->pm.dpm_enabled) {
>>> +			amdgpu_dpm_enable_vce(adev, false);
>>> +		} else {
>>> +			amdgpu_asic_set_vce_clocks(adev, 0, 0);
>>> +			amdgpu_device_ip_set_powergating_state(adev,
>> AMD_IP_BLOCK_TYPE_VCE,
>>> +
>> AMD_PG_STATE_GATE);
>>> +			amdgpu_device_ip_set_clockgating_state(adev,
>> AMD_IP_BLOCK_TYPE_VCE,
>>> +
>> AMD_CG_STATE_GATE);
>>> +		}
>>>    	}
>>>
>>>    	r = vce_v2_0_hw_fini(adev);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
>>> b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
>>> index 142e291983b4..b177cd442838 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
>>> @@ -520,14 +520,16 @@ static int vce_v3_0_suspend(void *handle)
>>>    	 */
>>>    	cancel_delayed_work_sync(&adev->vce.idle_work);
>>>
>>> -	if (adev->pm.dpm_enabled) {
>>> -		amdgpu_dpm_enable_vce(adev, false);
>>> -	} else {
>>> -		amdgpu_asic_set_vce_clocks(adev, 0, 0);
>>> -		amdgpu_device_ip_set_powergating_state(adev,
>> AMD_IP_BLOCK_TYPE_VCE,
>>> -						       AMD_PG_STATE_GATE);
>>> -		amdgpu_device_ip_set_clockgating_state(adev,
>> AMD_IP_BLOCK_TYPE_VCE,
>>> -						       AMD_CG_STATE_GATE);
>>> +	if (!(adev->flags & AMD_IS_APU)) {
>>> +		if (adev->pm.dpm_enabled) {
>>> +			amdgpu_dpm_enable_vce(adev, false);
>>> +		} else {
>>> +			amdgpu_asic_set_vce_clocks(adev, 0, 0);
>>> +			amdgpu_device_ip_set_powergating_state(adev,
>> AMD_IP_BLOCK_TYPE_VCE,
>>> +
>> AMD_PG_STATE_GATE);
>>> +			amdgpu_device_ip_set_clockgating_state(adev,
>> AMD_IP_BLOCK_TYPE_VCE,
>>> +
>> AMD_CG_STATE_GATE);
>>> +		}
>>>    	}
>>>
>>>    	r = vce_v3_0_hw_fini(adev);
>>>

