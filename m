Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89C83CAC5A5
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Sep 2025 18:11:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 231D810E7A8;
	Wed, 24 Sep 2025 18:11:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ldswkI8a";
	dkim-atps=neutral
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1A4B10E7A8
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Sep 2025 18:11:23 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-3304a57d842so95919a91.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Sep 2025 11:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758737483; x=1759342283; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=g5rT/W9uUAK/NHtr7+0JxXRuhjMcxGZ8XDsZEXBtbGE=;
 b=ldswkI8a2c2uLf4e3KQcx8cVIlqGJsd0XxnfDFYx+fYJeuA2zVVmiYm/Q7/SADHztj
 X+WjpL1LZkcXux7ngDxhh5I0bYHz8pOUytYqQvFXk3SpBWpOLxLUVW0Fir5S7KouHSHs
 uEp1dEhBJE3TwqelNdwMfR3XWBUmCBwDCTDpdkR0AVmOihOPGmEQeCAfzqbkn2K6I6fT
 a8RJSAv5WSRFg/NPeMPnPCw3PZHH0A6pGuFvQh6wO5EAb1Toz/LZnenqxMjMt2jdRnjc
 n84KvQ6pmptemQe3je2ZDa9VehekyQSoe5MtDFFrMaoADIEkSZIukVQQSmNxtPRtX079
 Tbkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758737483; x=1759342283;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g5rT/W9uUAK/NHtr7+0JxXRuhjMcxGZ8XDsZEXBtbGE=;
 b=qsewBEz94pZM0he4HmdKmOyI5W31/FbuszDrreKgawH1dnoiwIaPBGISHI0G5qEkHU
 B8Q3xx8YO0idmVIyeJTgzKkLIA71F48TJY3drIxiayWyxc/eHxu4oAim7BMRROMmX+Xp
 qK8II8s4GrYsMft0TYc8UNiCUCnpgLykQ/HYasy3K48cqPXJrCrJt9D+Jud2I5hzIErM
 lbgFPpV+Nsiq9GjjmeIB/Fu4xQnSurXyOXpt5qmP5O/1PMxYa7v19wB57/gtCJHtHU+q
 oDcpC8XjR//uuMbo8EqM/LJEZ3JMxjkYItnRs+Tnu+UcfvupGPL79zt5WyP4owToC3wn
 L6Yw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRGjNbWfHrSRVeZGipyQUP5UVilOkokYKgmFmH0Wcxq1pV0Qm9pATtgJHQ6OymkftOUps3F8K/@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz6laqfk++QMqvAHTeWWgdjZtDfyw6T1fpjtLZPWbuJvLlHUtCd
 /MrLUtgrMQrYfo/5ifg8KWaYWvpLSZRSc9XXYvx4zoB8baCmtIxR4YTaMAphv3tJ
X-Gm-Gg: ASbGnct25ND/az0joYuobODr0K3l5T+OjsjtIczDPAIEADcgZ1ZNGq5VgncbLMxMjt0
 mVqu3m87s444LwOoQyOLKWkpJfpvth7EZNXCYWwgJvBmbbHaubltKTB352siS5YKpaKIKHUXaXr
 w04QalukREqA3OknuDcFNS9AFatQe3drY/x1/WB2Ab6fQ/VlIo5vY1lLtNZhHO2LrHPd8B2P0si
 0mKIL6FS9RAYtFpzVgvTK+JcWl+wYPPIRRbnkubq/YZcOpFEFb353unG2E36YG3cF0cVDmOgQUc
 1u2+RJpmrBobHnIJ3LSzelOprcnxBwbcT42cB/KTxMQYVQ3Yrfgio0UtlbY8yocnbTQcqSZbCpu
 MCXuJjj4NtEqT1sn4WxYydtzRpkYP+6b0WOcznkmddStBJtyhi8K4t/I6QebL18QEo5R6K/tbfw
 7Qh/EuM093aiIhmMkxgk47aQKspY73stN8Leeo/MSGHpIYmMIJn3n0XoHTXPWM
X-Google-Smtp-Source: AGHT+IHor4kQrThayd7qvx/bO0dTWR6C2eXSn4w+SdLn5tJywbjNZUo8ustNNMu/z6SoJAhRDcqVTA==
X-Received: by 2002:a17:90a:d44c:b0:32b:d089:5c12 with SMTP id
 98e67ed59e1d1-3342a2f5955mr697888a91.33.1758737483102; 
 Wed, 24 Sep 2025 11:11:23 -0700 (PDT)
Received: from ?IPV6:2001:4c4e:24d0:6700:c9f5:8820:b1e:cea8?
 (20014C4E24D06700C9F588200B1ECEA8.dsl.pool.telekom.hu.
 [2001:4c4e:24d0:6700:c9f5:8820:b1e:cea8])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3341bdd63c1sm3066239a91.26.2025.09.24.11.11.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Sep 2025 11:11:22 -0700 (PDT)
Message-ID: <9d0509ea-7341-4bc5-88a0-d36a4b4528cc@gmail.com>
Date: Wed, 24 Sep 2025 20:11:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Adjustments to common mode behavior
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org, "Wentland, Harry" <Harry.Wentland@amd.com>,
 Alex Hung <alex.hung@amd.com>
References: <20250924161624.1975819-1-mario.limonciello@amd.com>
 <29cbab3f-083a-41a8-81a1-b0234f36152f@gmail.com>
 <cc2094c5-3cc2-476e-8d6f-72fc61ebab90@amd.com>
 <bebbe919-0c5d-4399-a211-c7cf744febdc@gmail.com>
 <68bff33a-46ef-4518-8b1e-d9d1b3087f2a@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
In-Reply-To: <68bff33a-46ef-4518-8b1e-d9d1b3087f2a@amd.com>
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



On 9/24/25 19:48, Mario Limonciello wrote:

> 
>> A slightly related question, would you be OK with changing the link 
>> detection code to return dc_connection_none when DDC cannot read an 
>> EDID header on digital signals, similar to how the non-DC code does it?
>>
> 
> I personally think lining up all these nuances that are different 
> between the two is a good idea.e e
> 
> But for that specific question that's probably more of a Harry/Alex Hung 
> question.

@Harry and @Alex, what do you guys think about this?

>>>>
>>>> Two possible cases come to mind:
>>>> 1. When we are unable to read the EDID for some reason
>>>> 2. When the EDID is buggy and/or doesn't contain any modes
>>>> Are these issues real or am I overthinking it?
>>>>
>>>> Thanks & best regards,
>>>> Timur
>>>
>>> Failing to read EDID has happened in the past, but I think with the 
>>> deferred aux message handling that should be cleared up now.
>>
>> I was actually curious about that. I saw that issue while I was 
>> working on something else. How is it deferred now? Can you point me to 
>> the series that fixed it?
>>
> 
> There's more patches than this one, but I believe this was the 💰 patch.
> 
> https://lore.kernel.org/amd-gfx/20250428135514.20775-27-ray.wu@amd.com/
> 

I'm not sure if that deals with the same issue that I'm referring to.

Basically what I notice is that when plugging in a cable, it can happen 
that the HPD pins make contact before the DDC pins, and hence DC fails 
to read the EDID. This can happen often with DVI ports and rarely with 
HDMI (and never happened to me with DP).

The non-DC code has a solution for this to retry in a few seconds.
I wasn't able to find anything for this in DC.
I found some code to set up some HPD filters, but that code is not 
called from anywhere and I was told the HPD filter may not be the right 
solution.

So my question is, what would be the right solution? Can we use a HPD 
filter? Or better to do what the non-DC code does and just retry again 
later?

Thanks,
Timur
