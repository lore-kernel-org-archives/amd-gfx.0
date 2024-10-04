Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7A0DCFB443
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Oct 2024 13:06:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 024F710E393;
	Mon,  7 Oct 2024 13:06:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O/MMSUcW";
	dkim-atps=neutral
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com
 [209.85.166.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02C0D10EA4E
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Oct 2024 17:33:52 +0000 (UTC)
Received: by mail-io1-f51.google.com with SMTP id
 ca18e2360f4ac-82cdada0f21so94276439f.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 04 Oct 2024 10:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linuxfoundation.org; s=google; t=1728063232; x=1728668032;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AgjqbFQ8hXrOjTXuOvQSjPVxsFmi6mOfY4A+dK7+CZQ=;
 b=O/MMSUcWSF5tkAvP5FhZ4BgHknUUnkMhLISDjxkS5w5xOK02w3/dplc2W5AE+Q6vyY
 EhANvktAd/IIG+QSTpsbD7AloB2bGbou2PPlDAcWX6EAMoMPCnoUYifIIMb672r5k4Dy
 xA9THu/ULKKBgFIbaPdF3pUMCzmOdVPbScz+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728063232; x=1728668032;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AgjqbFQ8hXrOjTXuOvQSjPVxsFmi6mOfY4A+dK7+CZQ=;
 b=CzZ+wz90Nt+Ldc/OminBxCiFn0zKddYtQfNAAMbikvr07LZY3sadNjKIklVER/pzdF
 KPACeqZ897Ay0aqElvW6BVpudpered/jnCDxaVFFxtQtpSK9S9M2FvtRc5BUiWLlNJky
 mekT1f4hDQiOg+mEbxWh14UtSqwPPqTxr4K4FyF7vNN3NAylZbxzAdjPAiTsKVp27ToU
 TpCAFUP+TeYQlUezglJ3TfMmbyn9/HEpoRKNwVEga9krbis9jMMyat5cSNuHVCqLOEDh
 njSwNNtajG3C7R3lziaxeqdYcA42Swm6serWaW8uWe5Q1Z2MiFxwaom0PaM2+lxIedFg
 HRfQ==
X-Gm-Message-State: AOJu0YyfjofXvYoipNdYDYbwzmbUd9MPSWMmnOK2QxD9ON2noTjSPTb4
 uP6CtOBY105Foc3pLdH9/ujO4ZepKVoqx4TX37EP44BecZMBoGvwQ+cjLKnNEK8=
X-Google-Smtp-Source: AGHT+IFWtN+nePXXWQrjbLcWtHgnNNN+hX6zEwqzI13DzO7+hHBsT7GAMCn6f/EhVXGV2DP3eQ9Jew==
X-Received: by 2002:a05:6602:3f93:b0:82c:fa71:2326 with SMTP id
 ca18e2360f4ac-834f7cfb296mr299279739f.8.1728063231607; 
 Fri, 04 Oct 2024 10:33:51 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
 by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-83503b154b5sm4227339f.43.2024.10.04.10.33.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Oct 2024 10:33:51 -0700 (PDT)
Message-ID: <7e1d5d2d-1b6d-4232-8d1b-6523849708b5@linuxfoundation.org>
Date: Fri, 4 Oct 2024 11:33:49 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-next] Fix unintentional integer overflow
To: "Sundararaju, Sathishkumar" <sasundar@amd.com>,
 Advait Dhamorikar <advaitdhamorikar@gmail.com>, alexander.deucher@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
 simona@ffwll.ch, leo.liu@amd.com, sathishkumar.sundararaju@amd.com,
 saleemkhan.jamadar@amd.com, Veerabadhran.Gopalakrishnan@amd.com,
 sonny.jiang@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, anupnewsmail@gmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241004081618.27599-1-advaitdhamorikar@gmail.com>
 <00761132-75f3-41fd-b571-30b0cbe5565d@amd.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <00761132-75f3-41fd-b571-30b0cbe5565d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 07 Oct 2024 13:06:21 +0000
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

On 10/4/24 03:15, Sundararaju, Sathishkumar wrote:
> 
> All occurrences of this error fix should have been together in a single patch both in _get and _set callbacks corresponding to f0b19b84d391, please avoid separate patch for each occurrence.
> 
> Sorry Alex, I missed to note this yesterday.
> 
> 
> Regards,
> Sathish

Sathish,

Please don't post on top when responding to kernel emails
and patches. It makes it difficult to follow the discussions

> 
> 
> On 10/4/2024 1:46 PM, Advait Dhamorikar wrote:
>> Fix shift-count-overflow when creating mask.
>> The expression's value may not be what the
>> programmer intended, because the expression is
>> evaluated using a narrower integer type.
>>
>> Fixes: f0b19b84d391 ("drm/amdgpu: add amdgpu_jpeg_sched_mask debugfs")
>> Signed-off-by: Advait Dhamorikar<advaitdhamorikar@gmail.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
>> index 95e2796919fc..7df402c45f40 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
>> @@ -388,7 +388,7 @@ static int amdgpu_debugfs_jpeg_sched_mask_get(void *data, u64 *val)
>>   		for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
>>   			ring = &adev->jpeg.inst[i].ring_dec[j];
>>   			if (ring->sched.ready)
>> -				mask |= 1 << ((i * adev->jpeg.num_jpeg_rings) + j);
>> +				mask |= (u64)1 << ((i * adev->jpeg.num_jpeg_rings) + j);
>>   		}
>>   	}
>>   	*val = mask;

thanks,
-- Shuah
