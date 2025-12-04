Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10E0CD2E03C
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Dec 2025 08:19:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B708D10EA5E;
	Fri,  5 Dec 2025 08:19:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V5ENf9uW";
	dkim-atps=neutral
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com
 [209.85.210.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C74F010E99F
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Dec 2025 17:40:32 +0000 (UTC)
Received: by mail-ot1-f54.google.com with SMTP id
 46e09a7af769-7c76d855ddbso464879a34.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 04 Dec 2025 09:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linuxfoundation.org; s=google; t=1764870032; x=1765474832;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=s7Rn5OHlrxb2qkeqjO8QCULVMCiSnHuDaJSd7PMI+Cc=;
 b=V5ENf9uWrYAaGEiaLF3hk+p2vnVwo0szFHSNmCLVbLuTZcPbdnMpj/RqlVc1cw5Cdr
 Y09w8iHPEsnBakI9A4DbsKS7UjFUOXQl3rWGr+qFJ34SYJoQt+xKKyD5sL11708aMzAN
 SWaDIkTY0RXqZVKbz+F9jmzI38bO5saNd5H70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764870032; x=1765474832;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s7Rn5OHlrxb2qkeqjO8QCULVMCiSnHuDaJSd7PMI+Cc=;
 b=V+WXPSAn+TnJRF/iv/KPdinNx5fThokN2J9UOLXyUio+iE+l2iKBoxDtL1Uc0G0nbs
 VcG1yqnAxqgEJffuml4/YbChwWFwjAVQx571LCuW9VjtpPEaVqOiqIzkf0rJRJCoK2T5
 uD6Z1uOkQcMJBoDIx5L0w3VShZKB7vxSwjVBlyGv4bajpQxbkYZr9OQVl52oUuIU/dgP
 fUyl7cVwNm4QMWCiQT0tXofmVbrkM30Y1M9OmriAIajys7Pp6GIwZyOULNMLMXZfV1PC
 XDnHaCUzM80dPTOeGXTjSazMV0EcgPdRFFOU3GPGzz12hQRNyYncBGaXVOUe07UGpYv2
 UWVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHbwyv2Z0CGSr/fv+NwqrhuBOZIlZzksmLZn9FiH1nw90sDPA62aYrCpM36fz81ytvqy3ftwcA@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzAHTkrKgY4pI62GxW4s5P5bFIfsgFxrufja15vHB/MML/qiVH4
 b8zIIOXzkvqgbMV3HSTBMGu797arig5SSFmhfdPqS+ooZwgN1dEdLF6FPTm5uXWM5Mc=
X-Gm-Gg: ASbGncvjcwb2DG/GaYCnjuOg/mGVHxsX+727YLbai58b8TG7J9xNJzFYPmxDf1zn0NA
 SDxN5ZRvLLgksPG+KUWm9recOEnL+eccl7HMfDTq73z/4GFotqcu711amyxaaylRl61Xz1cSHeS
 0r5Rj2BB2LRRbPvrB8aU3UQ0E/qThsUftKruc3z1JBSP5GW8ebRuZrxMU4dDT/8tee6/aCSZ2I3
 sZyYRIOLr4VmAkS6+pTta2nC/Qk8jk1iODKaVC5zy9HJNb6p4dTaq4SAt67nLQFiGw4iOpUp4p7
 Rn+d3JhORW26ULXn4HIpglmVYyhLEuiweeHUGvUGVjPRJBI7149SXTnmbB2vx3NQ42IE47Xab/X
 XQ2RFSIPM6gxIq8NCLqhewlBsX1VH/aKTXk4vyx1pI1yAEBL72DlLRfIV/vBEuf86WD2lb9Jrrw
 qCf2Vo6/F62MFqyPaQXW2k9Wk=
X-Google-Smtp-Source: AGHT+IFXMYm8uo/02RyQ9KYlJ4KVuvzBZjjPLJoJhlhqhfro08LIJnMS5kW+39YjCpGAgxuJvojUKQ==
X-Received: by 2002:a05:6830:2406:b0:7c9:5c77:54da with SMTP id
 46e09a7af769-7c95c775a7amr2219135a34.17.1764870031834; 
 Thu, 04 Dec 2025 09:40:31 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c95acff1bfsm1802681a34.31.2025.12.04.09.40.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Dec 2025 09:40:31 -0800 (PST)
Message-ID: <b24fc85c-0e6d-42f9-a6b9-05136409098f@linuxfoundation.org>
Date: Thu, 4 Dec 2025 10:40:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux 6.18 amdgpu build error
To: "David Hildenbrand (Red Hat)" <david@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, akpm@linux-foundation.org
Cc: Alexander Deucher <Alexander.Deucher@amd.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 amd-gfx@lists.freedesktop.org, dri-devel <dri-devel@lists.freedesktop.org>,
 Guenter Roeck <linux@roeck-us.net>,
 Linux Memory Management List <linux-mm@kvack.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <74032153-813a-4a40-8363-cce264f4d5ea@linuxfoundation.org>
 <1eb24816-530b-4470-8e58-ce7d8297996c@roeck-us.net>
 <0425d7b4-76e4-4057-83a5-a7b17a051c54@linuxfoundation.org>
 <ec77d11a-7613-4b75-8c9e-f2bba1595f0f@roeck-us.net>
 <9d520a1d-0b8d-4d30-b29f-230fc0f92b8a@linuxfoundation.org>
 <1f31b86d-283c-4878-92d0-ab90aed0c58d@roeck-us.net>
 <5af4522e-30ab-4eec-a861-c2760cdabd4f@linuxfoundation.org>
 <2bc690ca-fa57-46fa-949b-28b5441cd364@kernel.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <2bc690ca-fa57-46fa-949b-28b5441cd364@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 05 Dec 2025 08:19:27 +0000
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

On 12/3/25 23:05, David Hildenbrand (Red Hat) wrote:
> On 12/4/25 03:34, Shuah Khan wrote:
>> On 12/3/25 18:06, Guenter Roeck wrote:
>>> On 12/3/25 14:16, Shuah Khan wrote:
>>
>>>>
>>>> CONFIG_RANDSTRUCT is disabled and so are the GCC_PLUGINS in my config.
>>>
>>> I guess that would have been too easy...
>>>
>>>> I am also seeing issues with cloning kernel.org repos on my system after
>>>> a recent update:
>>>>
>>>> remote: Enumerating objects: 11177736, done.
>>>> remote: Counting objects: 100% (1231/1231), done.
>>>> remote: Compressing objects: 100% (624/624), done.
>>>> remote: Total 11177736 (delta 855), reused 781 (delta 606), pack-reused 11176505 (from 1)
>>>> Receiving objects: 100% (11177736/11177736), 3.01 GiB | 7.10 MiB/s, done.
>>>> Resolving deltas: 100% (9198323/9198323), done.
>>>> fatal: did not receive expected object 0002003e951b5057c16de5a39140abcbf6e44e50
>>>> fatal: fetch-pack: invalid index-pack output
>>>>
>>>
>>
>> Linus, Andrew, and David,
>>
>> Finally figured this out. I narrowed it to  to be the HAVE_GIGANTIC_FOLIOS
>> support that went into Linux 6.18-rc6 in this commit:
>>
>>   From 39231e8d6ba7f794b566fd91ebd88c0834a23b98 Mon Sep 17 00:00:00 2001
>> From: "David Hildenbrand (Red Hat)" <david@kernel.org>
>> Date: Fri, 14 Nov 2025 22:49:20 +0100
>> Subject: [PATCH] mm: fix MAX_FOLIO_ORDER on powerpc configs with hugetlb
>>
> 
> Unsuspected and confusing :(

This commit has impact on all architectures, not a narrow scoped
powerpc only thing -  it enables HAVE_GIGANTIC_FOLIOS on x86_64
and changes the common code that determines MAX_FOLIO_ORDER in
include/linux/mm.h

> 
> Let me take a look at reply on the revert.
> 

Sounds good. Reverting or finding a fix is good with me. It definitely
impacted two of my systems and the problem was introduced in
Linux 6.18-rc6 and is in Linux 6.18.

thanks,
-- Shuah

