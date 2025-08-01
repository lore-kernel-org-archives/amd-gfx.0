Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD17FC87FD2
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Aug 2025 07:19:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FE9210E083;
	Fri,  1 Aug 2025 07:19:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HHDAuAim";
	dkim-atps=neutral
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com
 [209.85.219.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9C9010E083
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Aug 2025 07:19:36 +0000 (UTC)
Received: by mail-qv1-f46.google.com with SMTP id
 6a1803df08f44-7076b55460eso15609606d6.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 01 Aug 2025 00:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754032775; x=1754637575; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :reply-to:subject:references:to:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=L/sn5d1+4ZcjqPpZ8VLEkGN87TjdmNlrfE2wilVgilw=;
 b=HHDAuAim7DOQxo//nB+oiXAVhOfjzP9rDhLPeGody3uCB/KogjUjVpLXi9UBAGV2gm
 //3cEmbDh3q96RPeQZCJwcvdV7RIMlsYqMNwlZ1E2pl1Nej+7tUJxd5yvKbvWNkw1vgA
 0klPrnTOYfJiSpKR2bdHNdzgZcRvAHNQ818NMO106Gg5jXClY4iJKPvlQqduOlIh2TQ9
 s+kpXQopbiKct2JbW8ApkCPrMMI7P3s9XNrCM31m8FNY/tcyXb6N7fAjQ2mvznWy9xez
 /vJQasoZVUoSiE735OVp2R70k/xcceL4iGCRxolp0/d2J2cTvfbsNjYbRACmDKesjCyQ
 /8UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754032775; x=1754637575;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :reply-to:subject:references:to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L/sn5d1+4ZcjqPpZ8VLEkGN87TjdmNlrfE2wilVgilw=;
 b=WQLRMXwlRRajErwen/BCS8KTcGjz8SdGz0HxuRvvW4XvD0bTKP8x3RWC3AxLI8X3OS
 1oFaXil7o85qwwqV/ahHCFf0GyGF7W8CF0Z3uyfzpzcRGRZ/hWfT9jO6MWgbO7ddxei+
 tugBJs/ITNyYsr+u7UDyr4aXQMgcgENG6DYXjXppfUCoU23AOMx3HKsu3PO7ejb3b6xe
 uGu0J+SHB0PsHSpWPJV/k/zgg5OsL77/jrtZzDjgrvQU8+4gxUmigoX/uAw5RmQqMS3J
 /+5vkUnpFGOLwph/JeoamFNCOdjyOohFwl5+p3JlMbxHJDis+lsplsI0wahjSv1VNcFq
 H20Q==
X-Gm-Message-State: AOJu0Yy5LdoQ8KcefYhLljoyvg/mp6DokCptzMb39op3198BccKie5VK
 /hb1oTcH+aZ3tG1RqeKSNN5YvRzFPKSKs2u/SwkPIbEntGF9lTTGz98oK0qv3z2u
X-Gm-Gg: ASbGncuCNsb5QRHlt0PxrPXBKFhwDsAv2ycJIeMFOnIXC3UCOTDLAALwcZvF1/LpKN2
 RWjY77VjgEI974V1hn6qBqMecdXJDxUmphhd3U/8xP5a/nDelpMWxm/n3po29xxauZfvE5NTeDC
 Uc2q51RZRTVgQoyZ/Vp7e/A9VkI7wKATPzJqzOw+6i1Dwd9LpUTspy99aPilNyrOlCHM5hhILws
 jl9YLlU+427B5HNulmYGK0kqtmqepFz/14IcHfRGXonzQQgIy0WkV4p4M42gCp+yWMOShgnJlLB
 qDOWlbX2arDLoxgut29xE+n+vc0RxWjh8cGF+FU4wwmby6SBTdyQ4lsBya0EqauDrdRMvots731
 mdC2OBRGKl2N+IVszSknmhW9fs/o2Kfu7IZY=
X-Google-Smtp-Source: AGHT+IE02L8ITyhDc6ei/gC7QZOEl4jpDNEDRLVlsl0ujEvai9QOMDNcmPLTdVghWojZW79lIlz7zA==
X-Received: by 2002:a05:6214:2626:b0:707:63d3:d528 with SMTP id
 6a1803df08f44-70766e7e526mr165162756d6.19.1754032775409; 
 Fri, 01 Aug 2025 00:19:35 -0700 (PDT)
Received: from [10.0.0.246] ([104.251.39.208])
 by smtp.googlemail.com with ESMTPSA id
 6a1803df08f44-7077cddc290sm18099226d6.63.2025.08.01.00.19.34
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Aug 2025 00:19:34 -0700 (PDT)
Message-ID: <1ce09488-0384-4d88-a1eb-cdff89c0bed1@gmail.com>
Date: Fri, 1 Aug 2025 03:19:07 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: amd-gfx@lists.freedesktop.org
References: <7bae9003-933d-49bc-969d-abf45424b825@amd.com>
Subject: Re: [PATCH 07/20] drm/amd/display: Don't use stereo sync and audio on
 RGB signals
Content-Language: en-US-large
From: Alexandre Demers <alexandre.f.demers@gmail.com>
In-Reply-To: <7bae9003-933d-49bc-969d-abf45424b825@amd.com>
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
Reply-To: alexandre.f.demers@gmail.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

>On 2025-07-30 13:08, Timur Kristóf wrote:
>> On Wed, 2025-07-30 at 10:34 -0400, Harry Wentland wrote:
>>>
>>>
>>> On 2025-07-30 04:19, Timur Kristóf wrote:
>>>> On Tue, 2025-07-29 at 14:21 -0400, Harry Wentland wrote:
>>>>>
>>>>>
>>>>> On 2025-07-23 11:58, Timur Kristóf wrote:
>>>>>> Features like stereo sync and audio are not supported by RGB
>>>>>> signals, so don't try to use them.
>>>>>>
>>>>>
>>>>> Where does it say that?
>>>>>
>>>>> Harry
>>>>
>>>> 1. Audio
>>>>
>>>> VGA ports (and the analog part of DVI-I ports) simply cannot carry
>>>> audio. So there is no hardware to control any audio, therefore
>>>> there is
>>>> nothing for this code to enable, which is why I added those ifs to
>>>> not
>>>> even try to enable audio on analog video signals.
>>>>
>>>
>>> My bad, I was thinking RGB as opposed to YCbCr. Forgot that we use
>>> RGB signal to refer to VGA.
>> 
>> Sorry for the confusion.
>> 
>>>
>>>> As a side note, DVI-D ports (and the digital part of DVI-I ports)
>>>> may
>>>> have a non-standard extension to carry digital audio signals, but
>>>> that
>>>> is not revelant to supporting analog displays.
>>>>
>>>> 2. Stereo sync
>>>>
>>>> With regards to stereo sync, I didn't find any reference to this in
>>>> the
>>>> legacy display code, so I assumed either it is unsupported or the
>>>> VBIOS
>>>> already sets it up correctly. At least, considering that the legacy
>>>> code didn't bother setting it up, we don't lose any functionality
>>>> if we
>>>> leave it out of DC as well.
>>>>
>>>> That being said, upon some further digging in the DCE register
>>>> files, I
>>>> found a register called DAC_STEREOSYNC_SELECT so maybe I could
>>>> investigate using that. Maybe it would be better to work with the
>>>> registers directly instead of the VBIOS? Would it be okay to
>>>> investigate that further in a future patch series once this one is
>>>> merged?
>>>>
>>>
>>> I don't think DC supports stereo sync currently. I'm not sure there
>>> is
>>> much value in pursuing that.
>> 
>> If stereo sync is not supported, what does setup_stereo_sync() do?
>> 
> 
> My bad. Not sure then. But no objection if you want to explore it.
> 
> Harry
> >>>
>>>>>> diff --git a/drivers/gpu/drm/amd/display/include/signal_types.h
>>>>>> b/drivers/gpu/drm/amd/display/include/signal_types.h
>>>>>> index a10d6b988aab..825a08fcb125 100644
>>>>>> --- a/drivers/gpu/drm/amd/display/include/signal_types.h
>>>>>> +++ b/drivers/gpu/drm/amd/display/include/signal_types.h
>>>>>> @@ -118,6 +118,11 @@ static inline bool dc_is_dvi_signal(enum
>>>>>> signal_type signal)
>>>>>>  	}
>>>>>>  }
>>>>>>  
>>>>>> +static inline bool dc_is_rgb_signal(enum signal_type signal)
>>>
>>> To avoid confusion with people that haven't worked on analog
>>> signals in years (or ever) it might be better to name this
>>> dc_is_analog_signal.
>>>
>>> Harry
>> 
>> Sounds good, I'll rename it in the next version of the series.
>> To further ease the confusion, what do you think about renaming
>> SIGNAL_TYPE_RGB to SIGNAL_TYPE_ANALOG?
I think Harry hasn't answered your proposition. I must say that the 
first time I looked for VGA in the legacy code, I stumbled upon the RGB 
usage. But then, it began to make sense (I'm not completely sure if 
signals and connector types are used properly everywhere), because we 
are mostly translating DRM signal types to supported connector 
types.That being said, while both dc_is_rgb_signal() and 
dc_is_analog_signal() could be used here, we are specifically querying 
the signal type and this signal type is RGB. Because of this, I would be 
in favor of keeping dc_is_rgb_signal() unless there is another analog 
type that could be queried and not rename SIGNAL_TYPE_RGB to 
SIGNAL_TYPE_ANALOG in any case. Cheers, Alexandre >>
>> Thanks,
>> Timur
>> 
>> 
>>>
>>>>>> +{
>>>>>> +	return (signal == SIGNAL_TYPE_RGB);
>>>>>> +}
>>>>>> +
>>>>>>  static inline bool dc_is_tmds_signal(enum signal_type signal)
>>>>>>  {
>>>>>>  	switch (signal) {


