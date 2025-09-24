Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61BF6CAC5A5
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Sep 2025 17:33:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01FC710E797;
	Wed, 24 Sep 2025 17:33:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NzThQd3z";
	dkim-atps=neutral
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8A5F10E797
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Sep 2025 17:33:20 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-244580523a0so623695ad.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Sep 2025 10:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758735200; x=1759340000; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ThPqAdR+mCun7kyx290ee1fSZyBhrq3b4v6Pof7TJyU=;
 b=NzThQd3zPwFdeboKq6zwxOJ+2qe1lcUU+DJ+Pj7XQ8Oe/k2RZctFnLXreUaejZNYCv
 TYVWDHTl50AHV4BUQtVZ3OACkiczkzV+nc/CKt2Pr2vRPDDnJ/uIrZRUpmYOUD1OLn+i
 v2rLRcvSR9sR/363/z1Lh8BZp0kUwtDKW9suX31FrJ/gRS3F5OnkcvlKiYYMET38HgqV
 5CL0CZ4A7xaUGwtT0hiEpUXTkXbHI9uISXTBxH2ijaBVSRD4nEMte774mZulje1YXTwi
 GzEDSO//PerM8dghqZNokZUW2EwOYGIBfOeSYBcfEX8viR8OVCACQYW7NYdAzwiArt6F
 1Xwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758735200; x=1759340000;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ThPqAdR+mCun7kyx290ee1fSZyBhrq3b4v6Pof7TJyU=;
 b=YHHI01BmNIEL9NAOGo+ljufwE8/sBO6UUkeC5ZTnhJGZ0GJQZpBbvc5Vngm352m+ni
 ArY8Z6xEO/qgFE7iZfiEkBMcI17C3JMtHBIUMeSpmDwv+OyRsZXBnxr2ISGk0cTwWyA4
 aQzFU/ENvGMElKHZUx1qTT5jaMPIeZvEn0tG0rD+4EVLrXEE+F9iYVzVT9DJhyWDTD6Q
 +OpoEOFDDZmZjMJgOBrldGJbatGpUGcCsrsPQTppKe9UpcM0Es1J2r39PImhSFvJKD86
 GQmHPH3eawx9Q2lTSIhEOy/tl5pAhDMNsohJnn00+4KO4quE0H3Q/EuvpRhjoUn6umtn
 oPjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVk2Dd6F5SPs9bJpPx71sUhtI33KD6VmININqtqjS3+Z6iwxuk0UYKmCc1lbZQBPvIt7qEVdoa8@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyg0MoqVi97iZeA6uSIeg5LurJMZWyfIl2qsrUipaFkoJJWRgg7
 SaSWotoumWQ8a1OryILFCAWYVsVu4pXX7yDiN3lVlYZUWHL1od4sk2X+
X-Gm-Gg: ASbGncvU1hPQpkLp6Z41S74AY3WSgEjbQuOBaGB0irdiJ7NmotHcn3p/ffvMjJE7Q3e
 ozUUuTEzPlg3AftMrWS0kjN59vHqjNhsEu2+ZWhaQfQvWtLVpPUAMI66DpX8ZhnnrWpqkBU0JfZ
 s0MRpQ9C6qnbYPA8HSi+lDM8DXe0PNPdR3dfUPbGCv5izh0TYDnC2I/HZn8X4iu9eG8hg5mAMqH
 ww/B/n65kQ6fUH0zBEWo0/4zjDrJ9d1JyNYgJjprf5H+uOjjOSu8rfEy7Wpa1vOyvy5SfDIq7LN
 pM5wSAZL7LyBAYdyAdFiM96gBhT9DWf1aKxD572iEYvdzZOQgrHmf2Fa2nnQVB79501MnZKmhH9
 91wvQEJKfyb0x3ktIY4ZhiRLfojCNF/3lIOKaH1W3mWyBLHN8P70bEMlRzdv4C3AZe8ARRhPqnA
 7Bzrp6U4yTXIuUsB0B8XfTqqCCvYOOemnve32GObyjC4jG6iHQNjsZHQ3cXGJk
X-Google-Smtp-Source: AGHT+IFfhkWParbMsiV7hfQ7juqWrjtlJpWIdPuY5P5HjnQtaaYa02TcFc6CFeNzV7oB/gxnBnqIVQ==
X-Received: by 2002:a17:903:3d06:b0:275:7ee4:83bc with SMTP id
 d9443c01a7336-27ed49b8694mr6803465ad.2.1758735200127; 
 Wed, 24 Sep 2025 10:33:20 -0700 (PDT)
Received: from ?IPV6:2001:4c4e:24d0:6700:c9f5:8820:b1e:cea8?
 (20014C4E24D06700C9F588200B1ECEA8.dsl.pool.telekom.hu.
 [2001:4c4e:24d0:6700:c9f5:8820:b1e:cea8])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3341bda0724sm2986103a91.8.2025.09.24.10.33.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Sep 2025 10:33:19 -0700 (PDT)
Message-ID: <bebbe919-0c5d-4399-a211-c7cf744febdc@gmail.com>
Date: Wed, 24 Sep 2025 19:33:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Adjustments to common mode behavior
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org, "Wentland, Harry" <Harry.Wentland@amd.com>
References: <20250924161624.1975819-1-mario.limonciello@amd.com>
 <29cbab3f-083a-41a8-81a1-b0234f36152f@gmail.com>
 <cc2094c5-3cc2-476e-8d6f-72fc61ebab90@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
In-Reply-To: <cc2094c5-3cc2-476e-8d6f-72fc61ebab90@amd.com>
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



On 9/24/25 19:21, Mario Limonciello wrote:
> 
> On 9/24/25 12:13 PM, Timur Kristóf wrote:
>>
>>
>> On 9/24/25 18:16, Mario Limonciello wrote:
>>> As part of enablement for SI and CIK in DC Timur pointed out some
>>> differences in behavior for common mode handling for DC vs non DC
>>> code paths. This series lines up the behavior between the two
>>> implementations.
>>>
>> Reviewed-by: Timur Kristóf <timur.kristof@gmail.com>
>>
>> Thank you Mario, this series makes good sense to me.
>> My only worry is this: is it possible that removing the common modes 
>> from connectors like DP, HDMI, etc. will regress somebody's setup?
> 
> Possibly.  We're not going to know until we try.  I generally prefer not 
> to add common modes (hence why I tried to drop them before until we hit 
> the Xorg bug report).
> 
> If someone complains about this then I see two other directions we can go.

Sounds good.

Considering the non-DC code already didn't add those common modes, I 
think it's reasonable to assume that we would have already heard about 
it if somebody had issues with it.

> 
> 1) to make both DC and non-DC paths apply common modes to eDP,LVDS, DP, 
> HDMI.  Make them not apply common modes to VGA and DVI
> 
> 2) Enabling common modes /across the board/ but anything not in the EDID 
> gets the GPU scalar turned on.

I guess we'll see if any of those are necessary. For now, I'd propose to 
just consider adding the common modes if there are 0 modes probed. But 
I'm also OK with leaving that for later if you feel it isn't necessary.

A slightly related question, would you be OK with changing the link 
detection code to return dc_connection_none when DDC cannot read an EDID 
header on digital signals, similar to how the non-DC code does it?

>>
>> Two possible cases come to mind:
>> 1. When we are unable to read the EDID for some reason
>> 2. When the EDID is buggy and/or doesn't contain any modes
>> Are these issues real or am I overthinking it?
>>
>> Thanks & best regards,
>> Timur
> 
> Failing to read EDID has happened in the past, but I think with the 
> deferred aux message handling that should be cleared up now.

I was actually curious about that. I saw that issue while I was working 
on something else. How is it deferred now? Can you point me to the 
series that fixed it?

> 
> I don't think it's a bug if a monitor doesn't advertise support for 
> certain modes.  Honestly I think we've gotten quite lucky that eDP that 
> panels worked with non-native resolutions not in the EDID in the first 
> place.

Agreed.



