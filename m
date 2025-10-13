Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19FAFCCD185
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Oct 2025 06:15:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EB9510E040;
	Mon, 13 Oct 2025 06:15:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Pvy9AWTw";
	dkim-atps=neutral
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com
 [209.85.218.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F0FC10E040
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 06:15:06 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-b3ee18913c0so596792366b.3
 for <amd-gfx@lists.freedesktop.org>; Sun, 12 Oct 2025 23:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760336105; x=1760940905; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xCLh/zyT4sBA1liMQS6VYeA7LkYZ+mqfXmVC7FVShH8=;
 b=Pvy9AWTwSTIN+XPaaDCQlDnLFRmt4su5ITgMnxHBkOtTP39ZC/4FPoFIeX6UvF9+K7
 FdmvsSCxSVSrOW0drbNmj9s4zrKtQOYcaf2MKwW7m+PHphkxS8byK168pNsRcyiF9MLv
 jhw+xf4CQ/Fj+74bly0N63becAgLZGGn9LrT/gejD835o4hcYO3Q4V0B3jKYuSyBFR7j
 uo/lq6Dyk30rv1+e5UHjuEyU11EwGI6EYePWhe5pWItYZGbDdSEgi42G1kPo23fniIFM
 LyJdSLrAYnF1mUh2CdeJj/yc7QIeGhYYr1MkSeEENWQjXP3/nbYVuXks94hPPZtVc0sY
 0VYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760336105; x=1760940905;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xCLh/zyT4sBA1liMQS6VYeA7LkYZ+mqfXmVC7FVShH8=;
 b=eikukssvnEKerm0l1CqMYVUrTPnKejhyyZCydmD4jnXsHH8ghAlt+rBwB3GgdNOMFS
 9VHOqPYBLblZdP0ZLQaVnb00lCIVCPzk1xw1VU8BQ+ktnGJ9xFwXWsvaTtADC2dnQPFO
 tQtN/7xxfVmX7oPj9Q/iw74u+MIM6CpFiRfLBmfRtShWOOCPlbLy52hZg7y/8B2w+YyL
 o/3c3hhfU5/C5Wb6JMmYlj1uKAv1SaDgD8oxQX4hxk1M9iwy9SsC3DaDCn3oQ7p3WCAm
 99xAt+cUNDZNTGOUuANqCS/shNwUvoOlWSa1Fp3vkrHqgCSdToA9m3mpCt1BLJg/rJDT
 kExw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWya2LU9ECrk/9c4XbP3gxjSGt70h0tW2eUFlUQTaUciPRuhNY44OtymCwMuTJnPI66QbU8rsni@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywr0HLu6uoSzW5m0H/8JWPuzO/wTTIeYRLs9MVXhScZ6UPyvhSh
 FWKtTKEiffsv0sAteTEspfeVlh51jBBVpesdXHowb4XIdlp7uiSpA4c6
X-Gm-Gg: ASbGnctKgUNl5iCsUDpiUm/1msxJN6IqO+HFk7lUKhVH8/PXMlU7c6CgFD0UE5Jqnz0
 9PiXjRklGWJnPMwFtHkLgebMd07M/+pTz7mLk3gkpBhvLcfnBvY64IMR/xUG2I9WOycqEAj4489
 CDKVtkuVIjwAgk1EQ8CeXNO9XUki1iEfuW3OpyNmGZm1pVLW2spVgkoWo2OpYmlDlGu3RMzRYr6
 i5jbvQpWasX8Zp4hWMFTuNzMsiNnfnqt/C7slAc8mRTLdNQ1uu+VvUsnXy0FTdbnDVIJ/nT07hr
 eymW/EgIsC3ZRsB6dFk9ciRSNJWZaw3P5EjnI+Ss3ul2MoZkyH7uCWrMu7vzpI3B9SzvxTVHLY9
 X1VOCl3OO2VvCwCthTkbCknlD/ISGlP3UjRVvWTj6z3I2C0+/GhEyVV/ZWeMC8fndztiLiavybK
 I+UcrvX6U43ify9A9qxdZIZDfmP3gVg0yGrKH1rMwqbKzhNKUYd6ls4F60VE0IHyt4Unb+IB2Eg
 Fhlr+4V/xXPOXvM/eg+
X-Google-Smtp-Source: AGHT+IHGsxEpPCGVQjkP4uSSyWZb/nbK5JSMRZ0Be6PFNy6+9j5ay0bT+sPPp57Q76JYA3/324PEVA==
X-Received: by 2002:a17:907:c12:b0:b4e:a47f:715d with SMTP id
 a640c23a62f3a-b50aa08f88bmr2140146366b.17.1760336104953; 
 Sun, 12 Oct 2025 23:15:04 -0700 (PDT)
Received: from ?IPV6:2001:4c4e:24f2:5600:9464:31e6:97f0:50a9?
 (20014C4E24F25600946431E697F050A9.dsl.pool.telekom.hu.
 [2001:4c4e:24f2:5600:9464:31e6:97f0:50a9])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63a52b0f42esm8200373a12.12.2025.10.12.23.15.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Oct 2025 23:15:04 -0700 (PDT)
Message-ID: <d214f753-21ae-4158-a9de-0459d7171360@gmail.com>
Date: Mon, 13 Oct 2025 08:15:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amd/display: Set stricter clock dividers on DCE
 6-10
To: Alex Deucher <alexdeucher@gmail.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, alex.hung@amd.com,
 harry.wentland@amd.com, siqueira@igalia.com
References: <20250926182614.26629-1-timur.kristof@gmail.com>
 <20250926182614.26629-4-timur.kristof@gmail.com>
 <221fd37b-e2a4-419c-9ac7-bb9eea0b4f78@amd.com>
 <3b1e453fd8595afb0b4c98855a7a06ba940925a4.camel@gmail.com>
 <CADnq5_OFyAQgZdE7_u9JubGKgxTU89rJLJYwW1hMOi6be0nBzA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
In-Reply-To: <CADnq5_OFyAQgZdE7_u9JubGKgxTU89rJLJYwW1hMOi6be0nBzA@mail.gmail.com>
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



On 10/9/25 21:38, Alex Deucher wrote:
> On Sun, Sep 28, 2025 at 7:39 PM <timur.kristof@gmail.com> wrote:
>>
>> On Sun, 2025-09-28 at 16:14 +0200, Christian König wrote:
>>>
>>>
>>> On 26.09.25 20:26, Timur Kristóf wrote:
>>>> Set stricter dividers to stabilize the PLL's feedback loop.
>>>> In practice, the actual output isn't exactly the target
>>>> clock, but slowly oscillates around it. This makes it
>>>> more stable.
>>>>
>>>> The values here are taken from the non-DC code.
>>>
>>> There are also a bunch of other restrictions which need to be kept in
>>> mind.
>>>
>>> For example what is the minimum feedback divider value the DC code
>>> uses?
>>
>> As far as I see DC doesn't have minimum / maximum limits for the
>> feedback divider right now, though I can add that in a future patch if
>> necessary.
>>
>>>
>>> We once had a longer discussion with the PLL HW engineers to get this
>>> working because at least the display code we used as reference back
>>> then got it wrong.
>>
>> After this series is reviewed, I can look through the other
>> restrictions in the amdgpu_atombios_get_clock_info function and write
>> another patch series to add those restrictions to DC.
>>
> 
> The PPLL limits from radeon and the non-DC code were based on the PLL
> registers, i.e., what the hardware limit in the register was.  I'm not
> sure what the practical limits really are per se.  I.e., if the whole
> range is really usable or not.  I would tend to defer to DC.
> 
> Alex

Hi Alex,

I'll leave it up to your judgement if you want to include this patch.
I just wrote this for the sake of consistency with the non-DC code but 
the patch actually doesn't fix any actual bugs for me.

It is is based on information I found in the non-DC code, in the 
amdgpu_atombios_get_clock_info function. Maybe the PLL limits in this 
function were meant for even older GPUs and are not relevant to SI/CIK?

Best regards,
Timur


> 
>>>
>>>> ---
>>>>   drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c | 7 +++++++
>>>>   1 file changed, 7 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
>>>> b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
>>>> index b4f5b4a6331a..00f25e2ee081 100644
>>>> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
>>>> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
>>>> @@ -1700,6 +1700,13 @@ bool dce110_clk_src_construct(
>>>>                      clk_src->cs_mask->PLL_POST_DIV_PIXCLK;
>>>>      calc_pll_cs_init_data.min_pll_ref_divider =     1;
>>>>      calc_pll_cs_init_data.max_pll_ref_divider =     clk_src-
>>>>> cs_mask->PLL_REF_DIV;
>>>> +
>>>> +   if (ctx->dce_version <= DCE_VERSION_10_0) {
>>>> +           /* Set stricter dividers to stabilize the PLL's
>>>> feedback loop on old HW. */
>>>> +           calc_pll_cs_init_data.min_pix_clk_pll_post_divider
>>>> = 2;
>>>> +           calc_pll_cs_init_data.min_pll_ref_divider = 2;
>>>> +   }
>>>> +
>>>>      /* when 0 use minInputPxlClkPLLFrequencyInKHz from
>>>> firmwareInfo*/
>>>>      calc_pll_cs_init_data.min_override_input_pxl_clk_pll_freq_
>>>> khz =       0;
>>>>      /* when 0 use maxInputPxlClkPLLFrequencyInKHz from
>>>> firmwareInfo*/

