Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E50BC43458
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2026 14:39:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FBD310E9FC;
	Mon, 13 Jul 2026 14:39:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="bZiSHw76";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32E8910E9FC
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 14:39:12 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-493f25d47dcso33025e9.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 07:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1783953550; x=1784558350; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YNqQGnjwsoyTH11jf3qUXD5jCOjIpWNYwJ5y4OgiCqE=;
 b=bZiSHw76ctXGNNlUasn2HvNKAgcFAuZxa7CvKESc3ktXYsiPK5VCvCDkbhQBUvQyvu
 3j8fRIS4B1REnaneW8MqH3ybICeFCKJrfIjvnUF9z2osDCDHMUdAG2DDWQnIgu+2mgFt
 KjsJdweaSbFsFkdzu9bcrOyTufshMMWDyQKtZCQ6kt4YxHCjdalHc47pk3qlkl4NsM0d
 JRIUupSKHLw3/H/E9tAvX/y1GLx/ssfiLnhyzHjqNu1suQsPI49r51RcTlvITd8esQmp
 8PEILkcfehWOjiMV3GokTugY2KytDHlAt/qyqHeaMkMp/mPyOUErenMDE/J8KZe3M0FA
 lJNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783953550; x=1784558350;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YNqQGnjwsoyTH11jf3qUXD5jCOjIpWNYwJ5y4OgiCqE=;
 b=boF3sZ9yPqFGCypokSf+1Nl7z95Vw/OGeWDBXli2oc6JTLdYAQnGfLikkJ9yiwEIxW
 0mCaEAzxRbHYloYa7cJ5PIIHuHpppshreKWlj7T2GZpMIvLc0VsJSCZRcZonxPycnQZT
 Czaam7PuZP+dMZ+G/85cjLVvThqaDUjwpLSValZDHdNkYdfrYnHUpvQ+fb9cYNyq9vqe
 Is+uGUDGRi9iMYe3vEOTVM1fyW5GlxWfGyKcDT9+FQmXXkuKlxS6rPDMf7K7K7zf4++j
 XIClaJ13Pi/Lb0FUiCbOYUrJuREBCelu/zj717g8LhFGXlXK5BFvxUENpHMOPT8iPqk5
 bTSw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp9RRuT1fV+gDY+Ut9tBNXLIwEod3bR1E/hMpa0tffMH/2hQV2DJ2euAx/og0tx8emKodRfKdEk@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzuQ9q3DVHEgFUsl3obppHkOtZC9oLisbommMh6VXUUfQPTq627
 H7jEg5dX76l+eAEB72sdCvF9jDa/FCC7XTC/CcTmoewYYQOXHyvrAFWoS7KqbZOiQl4=
X-Gm-Gg: AfdE7cm7bbr2QB2y2+02jzqBl+nujHEdQqgQAB/M1highE37cp5g9DzXXsMI9cn+WXB
 Lc2xeLET/GwOg4aFVkqxUBOyKMQzsChBcel3hbUI95JtBDmSPjcO2gmJzkF4BnmXK8xc7wfzT6Y
 7RYu1OsRieZDFUu5CwxuAW4y4Slzdh7w7zfPCd5Plk3njymQPqYaqSS64E4p94xgXYuGNTpFPMG
 RVy1N6daZ1m666EUevtriuVgJ9XRmyRGL+kmf5D5/Z9qblAqT+dXbuYjh1v7YZqN38EjRYdi0Tn
 2iVCGFxhKbxnzfTNEFePA9YVHI77Xg8QZ6M9NdZvQGoWyo8n1CSnPVDKjFN+uWq+tVmTVNMl/5D
 PyLbVc6+pbSoLUYyQUq5d0/HDyEqI0onih82dMVBtW7AgreZ0RTID4w8aV5eXLx9mcjpjjGdX+A
 bjSAX75TI9OZO42ceeR7q553ph8dYaCsvrxQ==
X-Received: by 2002:a7b:cd0e:0:b0:493:92c9:1e6d with SMTP id
 5b1f17b1804b1-493f8839c02mr72552485e9.33.1783953549974; 
 Mon, 13 Jul 2026 07:39:09 -0700 (PDT)
Received: from [192.168.0.116] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4950871e830sm719255e9.2.2026.07.13.07.39.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2026 07:39:09 -0700 (PDT)
Message-ID: <85a1a097-7f6b-4d26-b0ac-8a78d7dd0a79@ursulin.net>
Date: Mon, 13 Jul 2026 15:39:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amd/pm/si: Don't schedule thermal work when queue
 isn't initialized
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Natalie Vock <natalie.vock@gmx.de>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20260712173928.259701-1-timur.kristof@gmail.com>
 <e00d5e54-0713-47e9-9f88-a177a1ffa474@ursulin.net>
 <tM3iYIRPQHWYpTCh4LOKcw@gmail.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <tM3iYIRPQHWYpTCh4LOKcw@gmail.com>
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



On 13/07/2026 12:16, Timur Kristóf wrote:
> On Monday, July 13, 2026 12:25:38 PM Central European Summer Time Tvrtko
> Ursulin wrote:
>> On 12/07/2026 18:39, Timur Kristóf wrote:
>>> When DPM is turned off with the amdgpu.dpm=0 module parameter,
>>> the thermal work queue isn't initialized so we shouldn't
>>> schedule any work on it.
>>>
>>> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
>>> ---
>>>
>>>    drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
>>> b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c index
>>> 832953941266..6a54566d1a68 100644
>>> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
>>> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
>>> @@ -7692,7 +7692,7 @@ static int si_dpm_process_interrupt(struct
>>> amdgpu_device *adev,>
>>>    		break;
>>>    	
>>>    	}
>>>
>>> -	if (queue_thermal)
>>> +	if (queue_thermal && amdgpu_dpm)
>>>
>>>    		schedule_work(&adev->pm.dpm.thermal.work);
>>>    	
>>>    	return 0;
>>
>> I don't know this code but what is suspicious to me is that there appear
>> to be other unguarded entry points to the un-initialized work. Like all
>> the flush_work() calls and one cancel_work_sync() as well.
>>
>> Presumably as long as si_dpm_sw_init() is returning success when
>> amdgpu_dpm == 0 those two can get called?
>>
>> Finding the right Fixes: target might be a good thing too.
>>
>> Regards,
>>
>> Tvrtko
> 
> Hi Tvrtko,
> 
> That's a nice find. Indeed si_dpm_sw_init doesn't initialize the thermal.work
> when amdgpu_dpm is zero. And in fact the same issue seems to be present also
> in kv_dpm. I can address both of these in a follow-up series if you like.

You mean merge this fix for si_dpm_process_interrupt but leave 
si_dpm_sw_fini and si_dpm_suspend for later? I am not sure if that makes 
sense TBH but I guess I don't have the full context. For example whether 
you have hit this bug or just spotted by code inspection? If you hit it, 
can't fini and suspend also be hit and if so why does it make sense not 
to immediately fix all three?

Regards,

Tvrtko

