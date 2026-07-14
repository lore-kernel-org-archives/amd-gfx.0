Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18F85C43458
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2026 09:57:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA80010E6B0;
	Tue, 14 Jul 2026 09:56:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="QhXjzjUw";
	dkim-atps=neutral
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com
 [209.85.218.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C85EC10E682
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 09:56:57 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-c029505b389so121543066b.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 02:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1784023016; x=1784627816; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=IOEPumFcVz6G39rKfEM/ts7+86CRIean3XXbbcfEk1k=;
 b=QhXjzjUwTbN3GSsfNeUTatuUQZS1frEvXj7553FmG5M7MmMm/dTWHq8jiNd9GoeZsd
 H/k9sX8MOKPTDtlUsNnwrpqxkju+5GGuMIlAY3g5Pp1LBgXShM68ljospYXdEYHjXC5U
 7t9eZs6jRKVonZStC/G/B65HLl1yB/ld0Q/5O/Kuoa/4nKOD2mrRPhZnCw8ffr7YM3vm
 MnSQ2Dk6l6ivflO7L+2LxL/e1KXOcibAk/36WgIUzmahsPkOk4GOX/WLMv0z1S8PnEET
 ujWI3joC2W1FcMJxhHgtnGjBrLnVNEydTS/AX2ByGoC5f0GrBxCGb9VrshzRKEj1d+IV
 A9Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784023016; x=1784627816;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IOEPumFcVz6G39rKfEM/ts7+86CRIean3XXbbcfEk1k=;
 b=AyVyqxGGNHaOTO/qRrN49HbyDucRknHBIuhgakwbqeUJhzq28Q7w167ZzB7WCpnOOe
 x7jLijlq/Aa9FXGeHgSuGEC2DxbYvPGqNLj/eLtJI86zRHcJDrWDf/i62yFIus+zdsXg
 jT0nbmh7MzSAVzMUGz/FEEkzLpOY+EQqNSstEijX21ULu8MJIS+MM5yIq2g/yzCupvaj
 iYdpvqutDztFbibaxjcxFDOTbAIVfemACzRrsWod+3ZkIg2wTJevBY3ioJEx8dqz43dJ
 bkZwTxTHv/I0v9an28meTbpfLfxtIcYeIQvpwxdI5HbS+ScCIiTjFKCJEZ9LrGnLmNZm
 vgOQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rptn3hnY04LsA2V4m2hcx5SDNRI6t9X0+McorZfz+qE66LDcNFBbGv0KCx59aTMzJmgi1mvDLPb@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwMj4FcVSpdyoUVidMQXbymaUU+hkjrrFqgPjZ3IVXSfBDw806N
 ayEQfCKHF5myowz8udi0bTiYE8Izlro0219rSsVAPJHAW0zQrgOu3mlLKxy93C9HZ6w=
X-Gm-Gg: AfdE7cmj2cUBFFjaJGISsMu0tC4Ek7DqAZNDXo/ob6KWFu4OxH/7bbj8zMiRhtYQ5xO
 4eftIAhdh5z4sgSJ3Mton2ScmtEGu+MUBZ30cVdw06P9rAUjd45f4GLLmskGgidW7bqlmsI5Iag
 BRie1AvfywB76db4e5sZ15+nAX21Y7CO2G9HMSKLlRWPOUsKfvvisyY8q3dxxFvyEegVDLJJ7Ix
 UGfvEfWVUKpGsNA/2ug1BROTDwY3Fnzb9AkpSc+MxhIG+1cMV4GfeKXHYMbCr4oVhBSUD5FxP5L
 a0GGkTN0id3n42wayolgTVbRVQLaNbIF5k+yly0xdzr82qEDOLN55evfaUhDKIcsLGfoQQuu2M3
 3MeMxGCtHIE6J077zaye24NoqYoCuSDIHyKzwfBp45mRTpJKnnJQbFprt4Wd2cI0+yaAoUbtoZm
 SahiRyh5HzGXGQICwPi7gd2Rjkt6FtXGxHQhNxsDPmubVeRC5y34DHn/M=
X-Received: by 2002:a17:907:7247:b0:c15:a7b9:2ae1 with SMTP id
 a640c23a62f3a-c161e844fc3mr714094466b.6.1784023016128; 
 Tue, 14 Jul 2026 02:56:56 -0700 (PDT)
Received: from [192.168.0.116] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c15ada057dasm1157122066b.50.2026.07.14.02.56.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2026 02:56:55 -0700 (PDT)
Message-ID: <de029dfd-e3ff-40f4-be57-458706fbefd8@ursulin.net>
Date: Tue, 14 Jul 2026 10:56:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amd/display: Shorten name of FRL polling workqueue
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, Melissa Wen <mwen@igalia.com>,
 mario.limonciello@amd.com, alex.hung@amd.com, harry.wentland@amd.com
References: <20260711113009.26512-1-timur.kristof@gmail.com>
 <c1d30a27-0fa2-442c-b2be-aac23137a08e@ursulin.net>
 <aXo6J2_kQ_SXM08igon8Aw@gmail.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <aXo6J2_kQ_SXM08igon8Aw@gmail.com>
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


On 14/07/2026 09:51, Timur Kristóf wrote:
> On Monday, July 13, 2026 12:15:13 PM Central European Summer Time Tvrtko
> Ursulin wrote:
>> On 11/07/2026 12:30, Timur Kristóf wrote:
>>> The current name is too long and triggers a warning.
>>>
>>> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
>>> ---
>>>
>>>    drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c index
>>> b97ceabe6173..6299f0e384f1 100644
>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> @@ -829,9 +829,9 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>>>
>>>    	}
>>>    	if (adev->dm.dc->caps.max_links > 0) {
>>>    	
>>>    		adev->dm.hdmi_frl_status_polling_wq =
>>>
>>> -			
> create_singlethread_workqueue("hdmi_frl_status_polling_workqueue");
>>> +			
> create_singlethread_workqueue("hdmi_frl_status_polling_wq");
>>>
>>>    		if (!adev->dm.hdmi_frl_status_polling_wq)
>>>
>>> -			drm_err(adev_to_drm(adev), "failed to
> initialize
>>> hdmi_frl_status_polling_workqueue\n"); +			
> drm_err(adev_to_drm(adev),
>>> "failed to initialize hdmi_frl_status_polling_wq\n");>
>>>    	}
>>>    	if (dc_is_dmub_outbox_supported(adev->dm.dc)) {
>>>    	
>>>    		init_completion(&adev->dm.dmub_aux_transfer_done);
>>
>> This one does not require display knowledge so I feel okay to review it:
>>
>> Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>
>> Two nitpicks would be that the _wq suffix is even redundant since for
>> the task name it will have the kworker/ prefix anyway.
> 
> Ok, what name do you suggest to use then?

Dropping the suffix. :)

>> Second one is
>> that while touching this it may make sense to replace the variable name
>> from the error message with a human readable name like "failed to
>> initialize HDMI FLR status polling".
> 
> Ok, can do.

You can leave it for follow up work. Perhaps to clarify things, when I 
give r-b that implies it is acceptable as is. Otherwise I would have 
said "with that fixed r-b".

>> In fact, is this even an error or
>> should be a warning given I do not see an immediate exit?
> 
> No idea, I just wanted to fix the warning that I saw.

drm_warn or drm_notice I would say is appropriate for things which 
failed, were expected to work, but do not prevent the driver to probe 
and work. Btw, on a glance, the neighbouring code is already confused 
with a mix or drm_err and drm_info for this class of issues.

Regards,

Tvrtko

