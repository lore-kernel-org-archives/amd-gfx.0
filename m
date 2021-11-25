Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 797ADC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Nov 2021 07:08:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE1576E59B;
	Thu, 25 Nov 2021 07:08:10 +0000 (UTC)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4BD36E4C1
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Nov 2021 07:08:10 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id u18so9399629wrg.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Nov 2021 23:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=5ou2ssjVEIvVvdJfFPwiH5oVPVBtyeewjRFFB1l1aYE=;
 b=haDEvc30/krOjBWeF7S5wI/2YayrYZdFA44hB/a+yx6z6L7lvYmCdsHcQlIc1stWMg
 BVZN665a1VeHm1AsgtSbK0Dz7xZCsBd6C+pllWwY4eZkoJ2hySYAD8tWQhMgzgTHk7eH
 bT5RUd7quICG1bgoxjWUp5fF24U9SaPQJjpvdKu8dmu9UvAW9a2hUja9VvtphsIfT1ZV
 miKjJq5b30eM9ZiTjPDfVOePcvvRUhfgjeANxLyivBxnAAiCO8QHIXjbWQM86vOA8eJo
 BcKp+gjJNZGJ7U6Y953yiXuR78NNqiEo4PyCK68RsdBjj6qnYLnAOGrzHEEijBRuTBz3
 UEng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=5ou2ssjVEIvVvdJfFPwiH5oVPVBtyeewjRFFB1l1aYE=;
 b=y6TBmmDC/1XT0ImUyDzToJOkKw7mg1uy/VgZcUiQYb/EOwTSASaXEAjMkmObZWhaS4
 xcsH8aCPg0E8//XriBxia54T7KdxxZbLJqH2O1p2EabtgNrppEIQrByN3d4l5BgRmTQE
 /n1e6+jS1g9iUmjJScEmEMqPpBPsOLGisNjTb0BetSA8Q9giW/3OAbucbi9EEV4CF7HT
 d8TpeuYRnALYBxdfGqNqinSzMwVM4Z3OJWoNzFOxWY26YCExyBbf6YlMxq/cJeI2UJ8/
 LMrvFALe0iQgt31iTXeUyLptSsBsT5EN/daH6huvJX/COUbEnF13XPbVwHSQM02w7gNg
 EIkg==
X-Gm-Message-State: AOAM5324g33BtVITwoXVo/gIdVc6pJPkOJzduRWriKjsT+wo+e5E5aQ2
 +5436pGc/DtLc9ZcNxpOCeA=
X-Google-Smtp-Source: ABdhPJwd/xt7tUExoNJVIZ1E5qXzNVeiOHzINkK32KWQAX+UYDGXgiY52HMKeNPHKqEhiYEy6ADUJw==
X-Received: by 2002:adf:9bca:: with SMTP id e10mr4040937wrc.490.1637824089129; 
 Wed, 24 Nov 2021 23:08:09 -0800 (PST)
Received: from [192.168.178.21] (p57b0b77b.dip0.t-ipconnect.de.
 [87.176.183.123])
 by smtp.gmail.com with ESMTPSA id n1sm2264211wmq.6.2021.11.24.23.08.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Nov 2021 23:08:08 -0800 (PST)
Subject: Re: [PATCH v5] drm/amdgpu: handle IH ring1 overflow
To: philip yang <yangp@amd.com>, =?UTF-8?Q?Christian_K=c3=b6nig?=
 <christian.koenig@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20211123192254.21681-1-Philip.Yang@amd.com>
 <3d17fd21-751d-6f87-95b9-d120db7f4a0e@gmail.com>
 <5ec42928-995f-04c6-c7c8-3d2e33744457@amd.com>
 <bc4b8eb7-698f-a522-ef33-6d2232612167@amd.com>
 <430de254-8f6b-3a8b-1796-3d664f1b3dbc@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <3849366d-2228-bbab-2757-2a475f1b9ce9@gmail.com>
Date: Thu, 25 Nov 2021 08:08:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <430de254-8f6b-3a8b-1796-3d664f1b3dbc@amd.com>
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
Cc: Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 24.11.21 um 23:52 schrieb philip yang:
>
>
> On 2021-11-24 10:33 a.m., Christian König wrote:
>>
>>
>> Am 24.11.21 um 16:23 schrieb philip yang:
>>> [SNIP]
>>>>>   +/**
>>>>> + * amdgpu_ih_process1 - interrupt handler work for IH ring1
>>>>> + *
>>>>> + * @adev: amdgpu_device pointer
>>>>> + * @ih: ih ring to process
>>>>> + *
>>>>> + * Interrupt handler of IH ring1, walk the IH ring1.
>>>>> + * Returns irq process return code.
>>>>> + */
>>>>> +int amdgpu_ih_process1(struct amdgpu_device *adev, struct 
>>>>> amdgpu_ih_ring *ih)
>>>>
>>>> I don't think we need this new function any more.
>>>>
>>>> The check if the timestamp goes backwards can now be done inside 
>>>> the page fault handler.
>>> Do you mean to merge this into the original ring0 interrupt handler? 
>>> Then we need add parameter (ih->overflow_enabled) and process two 
>>> different cases in ring0 interrupt handler, I think that is not good 
>>> to maintain later so I want to separate them.
>>
>> What I mean is you don't need any different handling any more if we 
>> use the timestamp anyway.
>>
>> Just keep the last processed timestamp in the page fault code and 
>> ignore faults when it starts to go backwards.
>>
>> If IVs should be dropped or processed as much as possible is 
>> depending on quite a bunch of things and should probably not be 
>> handled in the IH code in general.
>
> Use ih->processed_timestamp updated in decode_iv, for both checkpoint 
> process and page fault handler to drop stale fault.
>
> interrupt handler don't need change.
>

Well that's what I wanted to say: I would rather change the interrupt 
handler for page faults than the general interrupt processing.

That we should drop older faults is page fault handling specific and 
should not affect other handlers.

Regards,
Christian.

> Thanks,
>
> Philip
>
>>
>> Regards,
>> Christian.

