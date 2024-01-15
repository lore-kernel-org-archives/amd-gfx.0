Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4363C3DA79
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jan 2024 15:43:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DFA610E2BC;
	Mon, 15 Jan 2024 15:43:51 +0000 (UTC)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FA1610E2BC
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jan 2024 15:43:50 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-336746c7b6dso7612475f8f.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jan 2024 07:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=froggi.es; s=google; t=1705333429; x=1705938229; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Z2zcYbckF5d5AB6zybIpnTkn3BuZoyEhPoQBI81m3Ls=;
 b=NUMchIy3zdoOFh0OpgkB1gCrHqyMxrxKUmcT8YNCuaULo/2JfK+epbTSJn06ixXIjR
 5MeUzvV842D+kiNSsxlV10+y4YkXi3hAUZ8A1qH8uN6qajqxw+5HF2xwUgTJYaDsnoyv
 10xDIGrmx7NwqJpu0eV96EABIH/ts8o9ss+2c6ChxKDi68ckzTyVV+TDWKn3rl3sg3hQ
 NtavJri1VOZKfwY0gnZHWq5N9bWCc8Y/bKWjYIZe6a43l0u5mMSpvUtAu8mRca8jsmyu
 N5Hk0+hePixVTaEVB33dY33suXZH2Z4KHII151mg+mgad86+zEHdd5c+CVs922yHWvAs
 8GQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705333429; x=1705938229;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z2zcYbckF5d5AB6zybIpnTkn3BuZoyEhPoQBI81m3Ls=;
 b=KyIQQbbPHqM7O2zibNfaGvjnZnrcz8rPj4jESQiLOQ0TjlBQa2OvqDYfZA1mNHRjqZ
 LxJ3Jubn3dUV1irb8VWg0QGDq7cz7Fof28Ez1H9bubEgnADemPB0uM/D9DmGbGYNPBPw
 kBJh7oKs3uu/xgtpJKe41oxGYEmvYrtvDHqUEbyCaoWF35E97cdPekwcKJLyL+uqPwyR
 GNR8d04j8FRdYJ2CxrmIB5NCR0PniPwIMQeUOr02yQUOr2zNdnRsh7PVMVRaVCrtOprn
 hqF2s1PQBTXqGXC8l5jQREZYwJxJR+D1LFdrdIKV7z1+rR1zeKZsp760a5UMfc7Gf7PB
 41dw==
X-Gm-Message-State: AOJu0YzzDbuP3w9Y871oM4HnYeQuUCAkoRQy/mI0PsQYSR81/ExaYp+2
 HdqiH+R/tAjaWjamUZTwjt5hsHnzEdtRSjUM4UzApN2voX4=
X-Google-Smtp-Source: AGHT+IGWUDk6US2gXA3c/NqTlA6h646Ny4irc4bxXsymeVT8J4kj8YyiIyvATt0FCc3Ao0fB37xjng==
X-Received: by 2002:a5d:6505:0:b0:337:3f72:3de1 with SMTP id
 x5-20020a5d6505000000b003373f723de1mr2994573wru.37.1705333428804; 
 Mon, 15 Jan 2024 07:43:48 -0800 (PST)
Received: from [192.168.0.89]
 (darl-09-b2-v4wan-165404-cust288.vm5.cable.virginm.net. [86.17.61.33])
 by smtp.gmail.com with ESMTPSA id
 co8-20020a0560000a0800b00336755f15b0sm12289208wrb.68.2024.01.15.07.43.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jan 2024 07:43:48 -0800 (PST)
Message-ID: <f2153219-e791-4e97-96eb-26094d7acf87@froggi.es>
Date: Mon, 15 Jan 2024 15:43:47 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: Mark ctx as guilty in ring_soft_recovery
 path
Content-Language: en-US
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20240113140206.2383133-1-joshua@froggi.es>
 <20240113140206.2383133-2-joshua@froggi.es>
 <c9b839cd-4c42-42a6-8969-9a7b54d4fbe8@amd.com>
 <0e701278-a633-403c-b397-e4f772d66c5a@froggi.es>
 <aca706e6-58bc-4c38-bbfe-19137f38c897@gmail.com>
 <9a07c4e4-321c-4f75-aeae-81ed90038365@daenzer.net>
From: Joshua Ashton <joshua@froggi.es>
In-Reply-To: <9a07c4e4-321c-4f75-aeae-81ed90038365@daenzer.net>
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
Cc: Friedrich Vock <friedrich.vock@gmx.de>,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 1/15/24 15:25, Michel Dänzer wrote:
> On 2024-01-15 14:17, Christian König wrote:
>> Am 15.01.24 um 12:37 schrieb Joshua Ashton:
>>> On 1/15/24 09:40, Christian König wrote:
>>>> Am 13.01.24 um 15:02 schrieb Joshua Ashton:
>>>>
>>>>> Without this feedback, the application may keep pushing through the soft
>>>>> recoveries, continually hanging the system with jobs that timeout.
>>>>
>>>> Well, that is intentional behavior. Marek is voting for making soft recovered errors fatal as well while Michel is voting for better ignoring them.
>>>>
>>>> I'm not really sure what to do. If you guys think that soft recovered hangs should be fatal as well then we can certainly do this.
> 
> A possible compromise might be making soft resets fatal if they happen repeatedly (within a certain period of time?).
> 

No, no and no. Aside from introducing issues by side effects not 
surfacing and all of the stuff I mentioned about descriptor buffers, 
bda, draw indirect and stuff just resulting in more faults and hangs...

You are proposing we throw out every promise we made to an application 
on the API contract level because it "might work". That's just wrong!

Let me put this in explicit terms: What you are proposing is in direct 
violation of the GL and Vulkan specification.

You can't just chose to break these contracts because you think it 
'might' be a better user experience.

> 
>>> They have to be!
>>>
>>> As Marek and I have pointed out, applications that hang or fault will just hang or fault again, especially when they use things like draw indirect, buffer device address, descriptor buffers, etc.
>>
>> Ok, well then I now have two people (Marek and you) saying that soft recovery should be fatal while Michel is saying that soft recovery being non fatal improves stability for him :)
> 
> That's not quite what I wrote before.
> 
> I pointed out that my GNOME session has survived a soft reset without issues[0] on multiple occasions, whereas Marek's proposal at the time would have kicked me back to the login screen every time. > 0 vs effectively 0 chance of survival.

The correct thing for GNOME/Mutter to do is to simply re-create it's 
context, reimport it's DMABUFs, etc.

The fact that it survives and keeps soldiering on with whatever side 
effects missed is purely coincidental and not valid API usage.

If you want such behaviour for hangs for Mutter, you should propose a 
GL/VK extension for it, but I really doubt that will get anywhere.

- Joshie 🐸✨

> 
> [0] Except for Firefox unnecessarily falling back to software rendering, which is a side note, not the main point.
> 
> 

