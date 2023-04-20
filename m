Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40CE1C77B76
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Apr 2023 15:20:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F33D10EC8C;
	Thu, 20 Apr 2023 15:20:52 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E802E10EC8C
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Apr 2023 15:20:50 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id u3so7092330ejj.12
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Apr 2023 08:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1682004047; x=1684596047;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QtRgV6Hyvs9zvyPHkZAUOpHMASjuqBKNlxOZR0/Ip/M=;
 b=DAlfGRJCvFM/0ATGXaJrt+OpsiUPrWwyfWn9oDFoTkSGM//CPzIa4KPIXk9jYHKLsK
 +ISGl2XEyHVHwwP+YVCirH75JEpOcZXM5FT5WG7wnfG2h26gwJG/PNk+3YkFtAbcI69Q
 Z8M1XEVMeDKFbzWzpx1mgM4UBbna9ck2pdze1zbU0N5jRsUpAQJ696mOiw3MOSt5VGT0
 HMczy44RfiuxWf7sdsfre/iKdR29e+l3X1Jh0mZhuIz4yZS+hvo+lE4xqAoZ+Q4DNp7I
 yyMFOftOaWV6Lf9G6oQ89uOe9fIPTIdFZJ37Eu0SthY3EwC43lT5zqoZA/zxe4vokLkg
 hJ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682004047; x=1684596047;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QtRgV6Hyvs9zvyPHkZAUOpHMASjuqBKNlxOZR0/Ip/M=;
 b=JkHG8Cq+N2RHTM1UpWOhdqxzlHVC5qNZtaiVLjK7hOimzGQosuD0dqiXXvBTXvJLLB
 siK5IEHRDIaiEbEBYlkW9wWOLXkzwNWMCtUUPt4FMafRIkX4+WzGEED61mmRRoPoSu33
 NeqyMpSyW0ayGwpLt1h05/CxgTaYiEgg2HxILBW4Ibt1LM8cDOxhfIaePyFPcv9sw8Kl
 Rsn0097M/QYwF2YcGjG3QMiDyW3P8jMjNk0Un1J7sT6QxuT1/3nKBnd5BY873hEx/PeZ
 qQJk+6YuCwd6SpLPQvsuoZZ+LRjxkxMwsUCvSXUiAq0AMKo93NKyVOyytC6DDandhcVI
 xbmQ==
X-Gm-Message-State: AAQBX9foXo2VIfOpbBl46eAXYhF9YhOi/BLVGipUa4r8nAQbS5r+4RLf
 rmtToAkQsn8o0nw2cDCK3e4=
X-Google-Smtp-Source: AKy350bO5V4AfxQwattXkuruCTXSnQK47SuDkuLdvt9hnjuL8nlttGZKhSVz5AxNc3OkmlC9kIJ+Dw==
X-Received: by 2002:a17:906:4555:b0:94e:d43a:58d5 with SMTP id
 s21-20020a170906455500b0094ed43a58d5mr1866962ejq.15.1682004047255; 
 Thu, 20 Apr 2023 08:20:47 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:5c2:1427:6870:462b?
 ([2a02:908:1256:79a0:5c2:1427:6870:462b])
 by smtp.gmail.com with ESMTPSA id
 gz6-20020a170906f2c600b0094ee2b8ab77sm838480ejb.73.2023.04.20.08.20.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Apr 2023 08:20:46 -0700 (PDT)
Message-ID: <49ef986d-46a5-0601-aacb-e2a3aaa126c0@gmail.com>
Date: Thu, 20 Apr 2023 17:20:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] drm/amdgpu: extend the default timeout for kernel compute
 queues
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>, Feifei Xu <Feifei.Xu@amd.com>
References: <20230420091942.5981-1-Feifei.Xu@amd.com>
 <CADnq5_OkR-34GappsZNH5sSrRFOJ36J5_cykreckErekz=bxSw@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CADnq5_OkR-34GappsZNH5sSrRFOJ36J5_cykreckErekz=bxSw@mail.gmail.com>
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
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 20.04.23 um 14:56 schrieb Alex Deucher:
> On Thu, Apr 20, 2023 at 5:19 AM Feifei Xu <Feifei.Xu@amd.com> wrote:
>> Extend to 120s. The default timeout value should also extend if compute
>> shader execution time extended. Otherwise some stress test will trigger
>> compute ring timeout in software.
> I think that's probably too long.  2 minutes is a long time to have a
> hung system.  I think we should rework the tests or use ROCm for long
> running test cases.

Yeah, agree. This came up multiple times now and even 60000 is way to 
much actually.

You need to keep in mind that this has dependencies and it essentially 
means that the system sometimes needs 60sec in case of a bug to become 
responsible again.

So clearly a NAK for this.

Christian.

>
> Alex
>
>> Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index e536886f6d42..1f98b4b0a549 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -3475,7 +3475,7 @@ static int amdgpu_device_get_job_timeout_settings(struct amdgpu_device *adev)
>>
>>          /*
>>           * By default timeout for non compute jobs is 10000
>> -        * and 60000 for compute jobs.
>> +        * and 120000 for compute jobs.
>>           * In SR-IOV or passthrough mode, timeout for compute
>>           * jobs are 60000 by default.
>>           */
>> @@ -3485,7 +3485,7 @@ static int amdgpu_device_get_job_timeout_settings(struct amdgpu_device *adev)
>>                  adev->compute_timeout = amdgpu_sriov_is_pp_one_vf(adev) ?
>>                                          msecs_to_jiffies(60000) : msecs_to_jiffies(10000);
>>          else
>> -               adev->compute_timeout =  msecs_to_jiffies(60000);
>> +               adev->compute_timeout =  msecs_to_jiffies(120000);
>>
>>          if (strnlen(input, AMDGPU_MAX_TIMEOUT_PARAM_LENGTH)) {
>>                  while ((timeout_setting = strsep(&input, ",")) &&
>> --
>> 2.34.1
>>

