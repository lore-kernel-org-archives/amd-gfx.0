Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7955D2E03A
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Dec 2025 08:19:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6937210EA50;
	Fri,  5 Dec 2025 08:19:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gCF13Wg8";
	dkim-atps=neutral
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com
 [209.85.160.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9895710E9E2
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Dec 2025 23:20:18 +0000 (UTC)
Received: by mail-oa1-f51.google.com with SMTP id
 586e51a60fabf-3e80c483a13so1169361fac.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 04 Dec 2025 15:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linuxfoundation.org; s=google; t=1764890417; x=1765495217;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1ilabqU0ZPIRb1Uuq8o42HfQ+CvcrcgaYSOj/pymfPA=;
 b=gCF13Wg8z/53oQuUm5vPTf1llpt9GzXEBZf6ddLZeZ+lKc0DwGP1Z//3ppKEkSh0rj
 o6wh5uiHE+qgef8RSqWLKipjcMcss2nrW9cs34cuaqdksIlHDhJX1UvfEbj9JfJVBwS6
 Nevf6m+a1UE2Gr/MHnchaLSJyCHKzY2tT0y2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764890417; x=1765495217;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1ilabqU0ZPIRb1Uuq8o42HfQ+CvcrcgaYSOj/pymfPA=;
 b=mObWHkKhWuMiM4rLQXFbuCritDLLEn/DrT2y89srUkDT0beI/piM89xRta9cgRrJSK
 rOfgOmjCZnewkrNNfuBHKuQt2vvxEgWObfEUiSUWzd0EnkzEoB8GL+yJHOHtFJM281MJ
 8NBsc5NASo/M0vvJ6NY1T47VH4GbJvEgjiHPvuAsD915bK+zBu6LVMwz7IqJ06oOuAwX
 E+6LyjzUkG9XrnXrhsqdaelwts+2WHlFrwYSrC/qcegDYYszfNcsAMTyC46H96JTVI7J
 j4WMlyYc0Yx9tQbrPvWHznPX2OriGYmPzq1bicGRYQJ9Mbh0vXFAmyKKrmFxT4PiC5a/
 vwqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWlUqSYdXlYj8YYGARNQx3YR1rIOR3WCrjutlIMX+oZypt59I1L7BJQtC7Z2L8R27sZA5FmMFs@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy9Mf3N6qer4LZullRz/xWZpbDhLGq4S/H+40niBVh0xdXx5lGE
 9ePT88y2pDmYTj9gc4XG/ZuedaeMWJu4M3xrKfyr++j0T00AA2OI+MDIMGbpzJLT4l4=
X-Gm-Gg: ASbGncvZTlozuomGFufIKzrbypoYeWVijn2JM+Grv7YYpCKEygHHohOnuMft7Jn8Q1s
 IQQD0dg+vQ5gCIwy6OfCBnR0ykhiT+wHW0ThD2zyjMCRLwSCjdmQX86gpKEVgPHwfxf9tZ0JO/J
 vnPQnS3sxyJFhCLDv1tipjrh8nQR9uce1s8Ng1Opmsc7rEptaZrXoV9PCxnOjD4RgHzzNiq7mMs
 xODKlfnJsIIjJ1DrV3yw5Mr2EvWdtJCLmAFIeqn9F2LOs3CcmgfegaozkfMHRMFahwhoVZee0LO
 7JwsGFTeKgjkOGwySrnY6avqqomIfw6uE/k3EXK+5FKG1BY/R8XhPS9FlSPYDqLL3dvBpN6sPSx
 LN3lrz5jDw1ncB6jD8NCA/MVbcWzVP8EK8uF5V57xfhumffRC6E1smO6/C4eRefa7pPV/nu4QlN
 JIQUISlf1b3v+7KYmbpfT0FGQ=
X-Google-Smtp-Source: AGHT+IEWl3G9taWVAc0FXunulp0EUlwKR0OqZ4+JiONHzArIhRnKO+2ONevOYyoQ9T+k/jyvf8v9NA==
X-Received: by 2002:a05:6870:ec8b:b0:3ec:4e22:bbb0 with SMTP id
 586e51a60fabf-3f1691d07f6mr3791225fac.18.1764890417156; 
 Thu, 04 Dec 2025 15:20:17 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f50aa9ed65sm2288970fac.7.2025.12.04.15.20.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Dec 2025 15:20:16 -0800 (PST)
Message-ID: <3cd2240b-ec2c-45d0-b73b-b66c83e75b9f@linuxfoundation.org>
Date: Thu, 4 Dec 2025 16:20:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux 6.18 amdgpu build error
To: "David Hildenbrand (Red Hat)" <david@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: akpm@linux-foundation.org, Alexander Deucher <Alexander.Deucher@amd.com>, 
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
 <b24fc85c-0e6d-42f9-a6b9-05136409098f@linuxfoundation.org>
 <CAHk-=whd-k3GhNGvVmP7W2p1d0d4ctqJ8iCuG8DbyKzgNqCL+g@mail.gmail.com>
 <3b6d6e50-91ac-435e-adad-a67d4198a5b5@kernel.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <3b6d6e50-91ac-435e-adad-a67d4198a5b5@kernel.org>
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

On 12/4/25 12:45, David Hildenbrand (Red Hat) wrote:
> On 12/4/25 20:36, Linus Torvalds wrote:
>> On Thu, 4 Dec 2025 at 09:40, Shuah Khan <skhan@linuxfoundation.org> wrote:
>>>
>>> This commit has impact on all architectures, not a narrow scoped
>>> powerpc only thing -  it enables HAVE_GIGANTIC_FOLIOS on x86_64
>>> and changes the common code that determines MAX_FOLIO_ORDER in
>>> include/linux/mm.h
>>
>> So I suspect your bisection might not have worked out, and there might
>> be two different things going on.
>>
>> In particular, hugepages were broken in 6.18-rc6 due to commit
>> adfb6609c680 ("mm/huge_memory: initialise the tags of the huge zero
>> folio").
>>
>> That was then fixed for rc7 (and obviously final 6.18) by commit
>> 5bebe8de19264 ("mm/huge_memory: Fix initialization of huge zero
>> folio"), but the breakage up until that time was a bit random.
>>

Both my systems were running rc6 - I was stuck in a state
where I was able to rebase to rc7 and then 6.18, but could
never build either one.

>> End result: if you ever ended up bisecting into that broken range
>> between those two commits, you would get failures on some loads (but
>> not reliably), and your bisection would end up pointing to some random
>> thing.
>>
>> But as mentioned, that particular problem would have been fixed in rc7
>> and in final 6.18, so any issues you saw with the final build would
>> have been due to something else.
>>
>> Can I ask you to try to re-do the bisection, but with that commit
>> 5bebe8de19264 applied by hand - if it wasn't already there - every
>> time you build a kernel that has adfb6609c680?

When I suspected rc6 to be the problem, I booted rc5 and compiled 6.18
after reverting 39231e8d6ba based on config file changes between rc5
and rc6.

> 
> Right, that's what I also proposed in [1].
> 
> I cannot make sense of how 39231e8d6ba could possibly trigger it given that it only affects the value of MAX_FOLIO_ORDER --- which is primarily used for safety checks and snapshot_page(), nothing that could explain changed application behavior, really.
> 
> But while Shuah is retesting, I'll go have a yet another look.

I retested on both systems on 6.18 making sure I have 5bebe8de19264
and 39231e8d6ba in there. I cloned linux_next and built it on both.

I didn't see any problems on 6.18. Having said that, It might make
sense to hold off on including 39231e8d6ba in 6.18 so there is more
time to test beyond 2 rc cycles. That is for you all to decide.

thanks,
-- Shuah
