Return-Path: <SRS0=ctnh=QC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F53C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Nov 2021 13:41:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 395DC60EB9
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Nov 2021 13:41:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 395DC60EB9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C34776E115;
	Mon, 15 Nov 2021 13:41:03 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DC3C6E115
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Nov 2021 13:41:03 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id z200so14003476wmc.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Nov 2021 05:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=6gwO8O34Ljsqh7QdS9srsE8XZ4WLdYhSlVcC8jy/0xY=;
 b=YXA5v25hIBp9QGd8Uo6wafVc1FWA6hJfkkeRyqUHLIfw7zm5UJGNDdjfd+uyKzQycx
 6tcJ9leGE/7sEXX4yG3bQI5FDfSh5VzCpLF2wJQVuMnAX8qk8MzGt0Inq+VPVOPNnpl3
 2jO/YqK5QY3/p64BPAQsKmOrjPnol+ICDKVWP2fkQ36HxFbCqXINx9nuCKwDQgqj2kPB
 stfSDQdWUF+kTnzWQbFqBxBZdU1Spgo3MWcFEz1bL+rxh2UzKk0YikYz8PV+sms4YDm2
 Tp17EenfAdWBfms6ZdQBLfAGCgOwLtNufKkkdm3msiS4Rj6WELod9vW5PYfLap5e99sp
 q8lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=6gwO8O34Ljsqh7QdS9srsE8XZ4WLdYhSlVcC8jy/0xY=;
 b=La5gHxT/yMDo9m4C9BtbkqPkR//HLCNDVp62vvCYX1YpxIuf2fUesDTIXgQlc/WOoi
 PHvYRu6YLmLvwQk/hOY8KaafLfNJhM4gMLQy6tC/1KE92PK88LsOxFeJ6P4lpBth/djU
 hxzswRbvEX7RgJ7X6MYEgApDMs5o4+Vx6l5X2tzualC78WCs01y626K2WLl2LRBbK97f
 cx3NaSCPMBIyNUO5JMZp61z2J8Bs5fAdG2sqTs5cNdi1WbSUi8Y1OD0gvkLmjJP/g/FF
 ij9/7CmdvQvP1gwUUWCTJZ4FRh7Mq6YoMczSdsiNPGPJXi4aUenqWaiHFgkffmwZle10
 kPaw==
X-Gm-Message-State: AOAM531SAmutnvR8EkrMIz0cHqRTjX9iyXtLeoHl8h70W23qjLQyEOct
 HVnmXwyaImv3mke0O1T9yVUd93v1MxQ=
X-Google-Smtp-Source: ABdhPJwnuDqFLQZwktxpwKAsc0xsWwOE7E/7jEosp0F0AJI8vkq0bESA6GgbpDP5xZL6ovRHwnap+A==
X-Received: by 2002:a1c:f31a:: with SMTP id q26mr41413800wmq.148.1636983661977; 
 Mon, 15 Nov 2021 05:41:01 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:bf0c:d52c:6ba0:cfc6?
 ([2a02:908:1252:fb60:bf0c:d52c:6ba0:cfc6])
 by smtp.gmail.com with ESMTPSA id y12sm14263161wrn.73.2021.11.15.05.41.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Nov 2021 05:41:01 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: always reset the asic in suspend
To: Alex Deucher <alexdeucher@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20211112161737.135848-1-alexander.deucher@amd.com>
 <CADnq5_OR7u2FuTbvuysZAHJ+gEso8NzKFaMN3U4fSTOqtft1XQ@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <a1c4ef7e-9466-6ed3-a23e-28bc5db9d4c4@gmail.com>
Date: Mon, 15 Nov 2021 14:41:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CADnq5_OR7u2FuTbvuysZAHJ+gEso8NzKFaMN3U4fSTOqtft1XQ@mail.gmail.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

I was just about to write up my concern as well.

IIRC we used to have that and it didn't really worked that well and we 
switched to resetting the GPU on driver load instead if initializing it 
doesn't work of hand.

Christian.

Am 12.11.21 um 17:19 schrieb Alex Deucher:
> Actually, ignore this for now.  This will likely cause problems with S0ix.
>
> Alex
>
> On Fri, Nov 12, 2021 at 11:18 AM Alex Deucher <alexander.deucher@amd.com> wrote:
>> If the platform suspend happens to fail and the power rail
>> is not turned off, the GPU will be in an unknown state on
>> resume, so reset the asic so that it will be in a known
>> good state on resume even if the platform suspend failed.
>>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index 1db76429a673..42af3d88e0ba 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -2165,8 +2165,9 @@ static int amdgpu_pmops_suspend(struct device *dev)
>>          adev->in_s3 = true;
>>          r = amdgpu_device_suspend(drm_dev, true);
>>          adev->in_s3 = false;
>> -
>> -       return r;
>> +       if (r)
>> +               return r;
>> +       return amdgpu_asic_reset(adev);
>>   }
>>
>>   static int amdgpu_pmops_resume(struct device *dev)
>> --
>> 2.31.1
>>

