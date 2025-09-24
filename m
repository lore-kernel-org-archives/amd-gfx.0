Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C020CAC5AE
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Sep 2025 21:04:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A719010E259;
	Wed, 24 Sep 2025 21:04:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ynw3pQok";
	dkim-atps=neutral
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E0D810E259
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Sep 2025 21:04:16 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-33082aed31dso301936a91.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Sep 2025 14:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758747856; x=1759352656; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=21DWhot5eDLZ9kTaWV1njQkTXNA+Lnr2/S7TQwa1ecU=;
 b=Ynw3pQokSIXZI1q7rZ8JVGv20RSyYvEmHgZEHela4W7dIdwuD10y555mKnaM5Otgq2
 A6jswmkrGi8srmaM2AAvESOQVsa62JuwpwTKqAZlVe4P6aaU3EmqXMLT1+HdIcp1hrp6
 R8KX3zPH/B0QYQMJWdpAFNYIVGjp6C1gGR3NlqhE7JDsZCxkerOiru7nZzTmyZhBurBe
 fAGwyFq2asiVzbgx6PWgwp5lvCuq6J6HgZHnhPDuT6umc+ZmuUJjVLfGCvS5he6JPk+3
 0vclHRaSDTKW2sk3ZhbfOGuh/xwkIe+YEbtKNzGEyHiuWP4Fbgr0bIedYhh1tmNlgqI7
 2Wkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758747856; x=1759352656;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=21DWhot5eDLZ9kTaWV1njQkTXNA+Lnr2/S7TQwa1ecU=;
 b=vVbnhXZ9fZlzMj4VQCNsCOFypH0RH/SCRA3PBDGzPWqbU/9vxm81DUGQ0cklQyCC6i
 ZvAO7KOV2jzvHLQ61V5Y/wBKTS+5qPdRMB9fXd78DE307LwPULghoFbvVWTiPuZSLr8u
 bP1iLqitvVW3scHRispd4e8tb2yfHfe1kOiMNtAwSOSCf6mjwbIgcpP1XRr+zvwLfHp1
 ro86hoAZnCDh1+/t1HckNsIkpejnghLM3NkslC0r4pjsE1WSBqqEVggNtwYNnm+hQmNz
 QZaD7HEA0nRjEUoFPeA9Q83f2TPQLH/XKUoC9JMHlAf8YjyluOIMo9AhKDNSgsBfDsC/
 5n8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2DTbvuNMkqEj9xo17O3nr9j5+aAZz2J2pWF+FYuedLT7UA0Lie/o6cORlwZhUnj3BZw8Nd/hh@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyHqvc5AgRmiG2ucdhYYe9YKk1mxV4eiT5Wt80bdUEc4nsdLtOe
 BsYu5KWfTYrP7KJJQ5qlEIBOwSynpQA/t55ER0a0OK6AxuXVn1UjtrSqtS1rd/91
X-Gm-Gg: ASbGncsroA+93eVgIs2Nu/kP9fW0F4h8lJLoQ4JWNfbg0M5niNFxmJLlQFES/2eF1RA
 4Obl7nqbRhe7WtdtyXS/zwqA1MMYV1DS2XjF4atTz2+CzhghodkLH7BQdHc8usgL6NkIFfQEAaD
 SZLmgan4xYeiI7K7z2QuVtTPbOuVwSzwrFbCajrXLXIPPnj9SYFE1wwaOpfvDv5pb4407KBYXpC
 APkmRQpOwBMxS5evPfyvN7x9VI8x+Au5MdIQJUbFSmrpvPliHv0IWdDECTge6aT64hra+Tw/ByB
 J6d8b7XX85DaYXMBP9HrS0kBGs3n+gH5lHL9pOH67xL9cyKs+9qjj8JOmj7y4YtRPnA3GvHxYmh
 2YAAuFxdNL00nHBcdbIP3109HOx/MSwLJg+LIOolYN3JXWoh0mq5wz9B+Ejhju0gigCvHzMFZ3K
 ZURXAjI/9kyNH3/twB2myc2wIhQ9xEhB9XaISfRi/7G9BJT+46tix3cjobSo0kvdZFsKBntQA=
X-Google-Smtp-Source: AGHT+IEYZU2f52tzC67pgstKMUhEoFDao/ygxjgNQvKZvMhHBLO53+7GZ/5SsFux92+7QSaudY0x1A==
X-Received: by 2002:a17:90b:4a4c:b0:32e:8c14:5d09 with SMTP id
 98e67ed59e1d1-3342a23718dmr990501a91.7.1758747856053; 
 Wed, 24 Sep 2025 14:04:16 -0700 (PDT)
Received: from ?IPV6:2001:4c4e:24d0:6700:c9f5:8820:b1e:cea8?
 (20014C4E24D06700C9F588200B1ECEA8.dsl.pool.telekom.hu.
 [2001:4c4e:24d0:6700:c9f5:8820:b1e:cea8])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3341bd90587sm3361596a91.6.2025.09.24.14.04.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Sep 2025 14:04:15 -0700 (PDT)
Message-ID: <7fb0b591-5bd9-4f86-ada1-6f9b3fe796de@gmail.com>
Date: Wed, 24 Sep 2025 23:04:09 +0200
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
 <9d0509ea-7341-4bc5-88a0-d36a4b4528cc@gmail.com>
 <7ce5b82f-08d5-41ef-9d87-4ea4e8266e3b@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
In-Reply-To: <7ce5b82f-08d5-41ef-9d87-4ea4e8266e3b@amd.com>
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



On 9/24/25 20:31, Mario Limonciello wrote:

>>
>> The non-DC code has a solution for this to retry in a few seconds.
>> I wasn't able to find anything for this in DC.
>> I found some code to set up some HPD filters, but that code is not 
>> called from anywhere and I was told the HPD filter may not be the 
>> right solution.
>>
>> So my question is, what would be the right solution? Can we use a HPD 
>> filter? Or better to do what the non-DC code does and just retry again 
>> later?
>>
>> Thanks,
>> Timur
> 
> Ah yes this is a totally different problem.  It doesn't turn into a 
> storm does it?  I would think a filter only makes sense if there is an 
> interrupt storm.
> 
> As long as it's just one HPD and no EDID found from what you've 
> described I would think spinning up a timer to try again in a few 
> seconds sounds like a reasonable approach.

Yes, it sounds like a different problem.
There is no storm, just 1 interrupt but at a time when the DDC pins 
haven't made contact yet so we can't read the EDID yet.

I also asked Harry about it and he agrees that a SW delay would be the 
best solution. I'll try to come up with a patch to implement that.

(Another alternative would be the HPD filter, but that can apparently 
cause issues and is not recommended.)
