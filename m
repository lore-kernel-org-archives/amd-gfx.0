Return-Path: <SRS0=hGuQ=PP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE480C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Oct 2021 07:20:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83A156109E
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Oct 2021 07:20:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 83A156109E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E52E6E4AB;
	Wed, 27 Oct 2021 07:20:12 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C475D6E4AB
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Oct 2021 07:20:10 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id g7so1315007wrb.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Oct 2021 00:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=MWi52fBjiToxFRUlz95p5DF8pFNbsC9LY8YOG15fTRM=;
 b=kcpkHypa3Hpbcj5q6JqAITWtgJvtnUm/8fxE25uvqH5z2F6M6Azkgxq0aqy5rqlixQ
 fVKlsq74zrVlEFuuFYIQjTGyTM5dNeWG33eOf8JJ7CcSXRL6j4hYOW+I6ylH6yprIulw
 nscC/k1m/vUTfMO/O7SuakZUREW9oQoWeyqVRWykjb5K5lHE+wqYQ6+E/b21Q44okJX7
 OnL/tZxHG71T8eQ6eLD2MBlqJAYX/DpiF3ibtSszHKWNh6NJRUCHcToMRdXxPgq7cW+H
 AkJWxj+PEfzgNWbJZyKIXEOrKXJCDOVAeUW4CFIwDloiQ10N5lXsoSIQ/MgVJJSO28tZ
 8oSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=MWi52fBjiToxFRUlz95p5DF8pFNbsC9LY8YOG15fTRM=;
 b=asDqMf/qkusG1O/mRKjCOehjhA60CpO2cIOj4PPfBw+BSGR0w3NrmD1EX+05koc3JC
 cB+jds4609KujBFCAu8SxHxNDW08vw4iFbzVOlgdLeE+O8FC/X6TehYzZf0lhWlV6Elz
 1sG38wv5J02obNqZ/CVzfJ/9+lfZqPKfF9RMw+jnMyIgsKhRcHafTJmlRT5XwoF57a1p
 Py66wlbvjXRt/ilYX5gGRqQLs4n1wdxXGPQ5OmlLXBS75HV8NNlNzfFXwZos4thAmYmO
 LQ3VfmyuwfguWwyLEOI0/RV1TSge9lLFYMT2kxtp0juajE5D1DTtQ3V7yGlPIT5NcIZo
 pFpg==
X-Gm-Message-State: AOAM530NBWrK+FoiRRyqZMIF+jlpbXnRXvWZKtJ6eHvVKbr42lZ30yAl
 Rj9FxFQYa///o72JZDYH33M=
X-Google-Smtp-Source: ABdhPJz/93WWiINwxMSRJ9NEeDpPKzLOl1sJaJE2aXRuc+4N/aunPut7buGkX+ZdQkdqRsP22TI8QA==
X-Received: by 2002:adf:8bc4:: with SMTP id w4mr23989693wra.36.1635319209337; 
 Wed, 27 Oct 2021 00:20:09 -0700 (PDT)
Received: from [192.168.178.21] (p5b0ea1b5.dip0.t-ipconnect.de.
 [91.14.161.181])
 by smtp.gmail.com with ESMTPSA id b6sm6480730wrd.85.2021.10.27.00.20.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Oct 2021 00:20:08 -0700 (PDT)
Subject: Re: [PATCH] drm/amd/display: Fix error handling on waiting for
 completion
To: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>,
 =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
 Stylon Wang <stylon.wang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com, contact@emersion.fr
References: <20211026110740.152936-1-stylon.wang@amd.com>
 <0087f1c6-733e-4c31-63c5-c39da51138c1@daenzer.net>
 <b29f5d0e-a0d4-2a2c-d9ee-6e16541b9906@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <8fd7aa27-b9c2-6234-f98a-cb8c88267ea9@gmail.com>
Date: Wed, 27 Oct 2021 09:20:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <b29f5d0e-a0d4-2a2c-d9ee-6e16541b9906@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 26.10.21 um 18:03 schrieb Kazlauskas, Nicholas:
> On 2021-10-26 11:51 a.m., Michel Dänzer wrote:
>> On 2021-10-26 13:07, Stylon Wang wrote:
>>> [Why]
>>> In GNOME Settings->Display the switching from mirror mode to single 
>>> display
>>> occasionally causes wait_for_completion_interruptible_timeout() to 
>>> return
>>> -ERESTARTSYS and fails atomic check.
>>>
>>> [How]
>>> Replace the call with wait_for_completion_timeout() since the 
>>> waiting for
>>> hw_done and flip_done completion doesn't need to worry about 
>>> interruption
>>> from signal.
>>>
>>> Signed-off-by: Stylon Wang <stylon.wang@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c 
>>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> index 4cd64529b180..b8f4ff323de1 100644
>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> @@ -9844,10 +9844,10 @@ static int do_aquire_global_lock(struct 
>>> drm_device *dev,
>>>            * Make sure all pending HW programming completed and
>>>            * page flips done
>>>            */
>>> -        ret = 
>>> wait_for_completion_interruptible_timeout(&commit->hw_done, 10*HZ);
>>> +        ret = wait_for_completion_timeout(&commit->hw_done, 10*HZ);
>>>             if (ret > 0)
>>> -            ret = wait_for_completion_interruptible_timeout(
>>> +            ret = wait_for_completion_timeout(
>>>                       &commit->flip_done, 10*HZ);
>>>             if (ret == 0)
>>>
>>
>> The *_interruptible_* variant is needed so that the display manager 
>> process can be killed while it's waiting here, which could take up to 
>> 10 seconds (per the timeout).
>>
>> What's the problem with -ERESTARTSYS? Either the ioctl should be 
>> restarted automatically, or if it bounces back to user space, that 
>> needs to be able to retry the ioctl while it returns -1 and errno == 
>> EINTR. drmIoctl handles this transparently.
>>
>>
>
> Thanks for the insight Michel!
>
> If it's just an error in the log without a functional issue then maybe 
> we should downgrade it to a debug statement in the case where it 
> returns -ERESTARTSYS.

Yeah, that is a very common problem. -ERESTARTSYS should never be 
logged, not even on debug level, since it is part of normal operation.

Regards,
Christian.

>
> If this is a functional issue (DRM not automatically retrying the 
> commit?) then maybe we should take a deeper look into the IOCTL itself.
>
> Regards,
> Nicholas Kazlauskas
>

