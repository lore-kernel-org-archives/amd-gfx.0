Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76B19CCD187
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Oct 2025 07:45:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1657910E952;
	Thu,  9 Oct 2025 07:45:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KBR3T3Tl";
	dkim-atps=neutral
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BC7F10E8F2
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Oct 2025 22:00:20 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-42557c5cedcso253796f8f.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Oct 2025 15:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759960819; x=1760565619; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5GU1Xl1K6+Pk8hlhPh8Orqtx3Ns4/PlbjU1PHpUk8BI=;
 b=KBR3T3Tl9JIbMb6VLILtMh6+fTmQSghS0zK8Hn/vR+QaooTPUrYx1+TaKmHvNfpMuP
 AV6qLS/UnUx2Wbf6sFf224pxyq8CbBJZQ7ci56PLQP2t8wQ+WSVh7OQFngUf8RvNl4mQ
 R8AZo03XbaGrCbYFzMcl/kEEVoPSyaPT0K0eCZqfEnt5rJ4RUxdNch3Emonn2xUYcLHE
 kRQJa6VuiFF78nuasSLCculsamDa1rs4YDK4+nPT9F0dmHF3kTp9KFqLWdZYerS9eRtY
 MBKfEb04MmT/lEa3qEkJnHFx3HBGYUoAEkswmkTgh2rf+6ml55wN6uHS6Y9y92B1DQK3
 t6qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759960819; x=1760565619;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5GU1Xl1K6+Pk8hlhPh8Orqtx3Ns4/PlbjU1PHpUk8BI=;
 b=uiUnEdP6ASFvIsbq/YViZ4xt0d3thdf2w/jHhQ4USnrIcEpKu168rQ58s8nJstO+s3
 j3gFKGBGIURXwgC7Zs2Ahk+7KfWAKUAYfUeNnZFyqxfeiPSqKX53t7qnF5WgWIon6FhN
 6jAGu1U3LkWeo19NirG50FaLRviY1dxNNhVGVn2vpgRayb9+cfgUYcFE3DMuWFppUl3m
 AvDglWuFOUXRWIRkNKsokibD1UGLBYONiuX/bzfjjXFxty1Vf8nbFxiAqRUsd0qoTm47
 5PFosSPxHPwdOPSRyoiLurAhaq1roYxyFNsIVIClVNx1o2aLQxFDiHQqfdtARnBAJLvn
 7dxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNZW/xIftka7U7dFmqzKoCdp49HRt5sSdUGdg5mjAm0y0cVxB3akB/FJEuSm27dSd+eJhVHoRE@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxxMYDs9kLkKdJvSmLizwM6WYkVyRvOGVpRmRGXUa8hSngZOpXC
 QKj+7+9731p5JXUqLhF4LpitkExAn8Ynzy0skDuDuZeu002+/Eyaj6Mg
X-Gm-Gg: ASbGncvch4b01wI6NSyPPHWpUocx8cbuZ0aySXubS9D96qeORym7qjV1W0+AZuPxeae
 MNaXIGpeAkoFzR/MxKpAXmJLysHV5rLDWudS5Xlu3pASHXlPzy4bgM3DgEO0bvBENkw6fadMJz/
 zaGYv11NgqpFAv9BjN8Ud8Rhw38t+KPJMGp1kAhBCWfJBf4JmK+y+8gcOqhQFR8XQk2JikVys5q
 EOXASxrZ7vpzV3MfpQXYpu6O5kGt+A9KgHfy19T2wSjtrZ7phovgSg3dDzoj5z0+s9cKEa3guWu
 lfe7tNE4V/WDTxnYdWgcgxbJksVNY3+ug7BjcUlgAY44TmlVU5HftF9P+3EVv5lt+uXWPRdeeUX
 fzvG70GxYvJQR+LUOOcypaZftx7sh9DuNBDiqieYmgRkowcxszZw4Vkc=
X-Google-Smtp-Source: AGHT+IGM/GqujYDl21bAoN2Inkzb/Y4dx34wMexePnZgIwLqQp6UnyIsYIhpOwJWA7nmUp+t5SFi0g==
X-Received: by 2002:a05:6000:2388:b0:425:8255:fedf with SMTP id
 ffacd0b85a97d-4266726c31fmr3138290f8f.23.1759960818430; 
 Wed, 08 Oct 2025 15:00:18 -0700 (PDT)
Received: from [192.168.1.12] ([41.37.1.171]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8e9762sm32013820f8f.38.2025.10.08.15.00.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Oct 2025 15:00:18 -0700 (PDT)
Message-ID: <ca29530d-f890-47b5-b254-20c4ef301f7d@gmail.com>
Date: Thu, 9 Oct 2025 01:00:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] drm/amd/display: Initialize return value in
 dm_cache_state()
To: Mario Limonciello <mario.limonciello@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Alex Hung <alex.hung@amd.com>, Wayne Lin <Wayne.Lin@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>,
 Dominik Kaszewski <dominik.kaszewski@amd.com>,
 Yilin Chen <Yilin.Chen@amd.com>,
 "open list:AMD DISPLAY CORE" <amd-gfx@lists.freedesktop.org>,
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20251007224549.87548-1-eslam.medhat1993@gmail.com>
 <6f24d0cb-ce14-4e56-990b-00ad579bc282@amd.com>
Content-Language: en-US
From: Eslam Khafagy <eslam.medhat1993@gmail.com>
In-Reply-To: <6f24d0cb-ce14-4e56-990b-00ad579bc282@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 09 Oct 2025 07:45:21 +0000
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


On 10/8/25 05:15, Mario Limonciello wrote:
>
>
> On 10/7/2025 5:45 PM, Eslam Khafagy wrote:
>> Initialize the return variable "r" to 0 in dm_cache_state() to fix
>> a potential use of uninitialized variable warning.
>>
>> The return value for this function might not be a PTR_ERR, in casse if
>> condition fails. In that case we ensure predictable reutrn.
>
> Can you walk me through your thought process?  I looked at all 
> possible returns for drm_atomic_helper_suspend() and they all return 
> ERR_PTR() or a state.
>
> So I don't see how the IS_ERR() clause could have a problem.
Hello ,

Thank you for the response. Initially i was working on warnings via 
coverity scan.
Initially my thinking was just by following the sequence of 
dm_cache_state you can see that there was a potential issue if
drm_atomic_helper_suspend returned a non valid pointer that is not PTR_ERR.

But having a second look after your response, indeed it shouldn't be the 
case. so please feel free to drop this patch.

>>
>> Signed-off-by: Eslam Khafagy <eslam.medhat1993@gmail.com>
>> ---
>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c 
>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index 8e1622bf7a42..6b4f3eb9ce48 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -3115,7 +3115,7 @@ static void hpd_rx_irq_work_suspend(struct 
>> amdgpu_display_manager *dm)
>>     static int dm_cache_state(struct amdgpu_device *adev)
>>   {
>> -    int r;
>> +    int r = 0;
>>         adev->dm.cached_state = 
>> drm_atomic_helper_suspend(adev_to_drm(adev));
>>       if (IS_ERR(adev->dm.cached_state)) {
>
