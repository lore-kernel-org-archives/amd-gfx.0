Return-Path: <SRS0=g6Hj=N7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1593C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Sep 2021 15:56:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57593610CE
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Sep 2021 15:56:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 57593610CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F02186E8A8;
	Thu,  9 Sep 2021 15:56:24 +0000 (UTC)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E63016E873
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Sep 2021 15:00:00 +0000 (UTC)
Received: by mail-oi1-x22d.google.com with SMTP id v2so2827288oie.6
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Sep 2021 08:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=cdZ5UReirNbJCz4qtRz9jPX8lIr89503B9bA6FIRuzQ=;
 b=jDgnkGSK/AzbQ/fvUe+F8Q6VZgBkRHWd4DcBMpA845U1VP2maB6KuDUGyL8c2z1MQ5
 UX6S2hMX3XaL+wIg8XPiRW3uTqvaEgPp8GwPJPJByHRkVu8WdVGBxNU7ND2J8PWd6MjQ
 1BL0tMyxa7ZdE0Z2Q+WzTnNgCJ+YMSVMHlQ3G1GlF5G2afc7lU4RB3k5FIovm8QarUG7
 RPmR6TFjaMcSuvD67sPx0N8yWJj2K9lVY4kxvs9O3saKM+uEhuFWmi956IZGiUFIdrmY
 hqz6C5u3zKx731XS7IajOTZL1HWrKGy6fsTJ74ufvBqwljrPlIixlbiTt+K2g3iOZX5u
 avbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cdZ5UReirNbJCz4qtRz9jPX8lIr89503B9bA6FIRuzQ=;
 b=cuNpEXVmgu+1iCHRWix6yjBS0FqnhI/7hnerGRu68avhdIL98mpyk938zYoK8oJi2n
 ceIOS06f3MvmmHVGvfOSUX6yvTbs/iPfodFriBVf8B3uA9ax68QXsjKVKAGjfV/cYwcC
 IWFfDZU+JBzuqXE+CCXzddDHg3TsSywmL0SVF0SGkWmy0SN68TGQ4JP6ncXtKJa5wEpt
 bwQWFpM48CP3YtugFDbha6kDdXqlXbSTCP0eSjyByevqwELWiO3J3nB2GUIHlYdHEGAv
 8Nj9PGghk3RZpiRe2lQ+G4l8Hl3PTnFnYACBeTlQTW4HgkSl0W+zUXsbfmMVJOCn1BmV
 UCBA==
X-Gm-Message-State: AOAM533OE4NwVtl9JHLYwYogz0OKiFaF5xCqjhxCh/Q3z/nJtL51ymNq
 OL3FbfA81190/ObVjxHSVPYlB96aln8=
X-Google-Smtp-Source: ABdhPJy29+VUAR+47DHLnfifhIlBecXxb8pFnECJqaJhWQNcxsfS3c0Ish2MaEwbx71o2d1eL5rWmg==
X-Received: by 2002:aca:1709:: with SMTP id j9mr233084oii.120.1631199599971;
 Thu, 09 Sep 2021 07:59:59 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 l44sm475368otv.81.2021.09.09.07.59.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Sep 2021 07:59:59 -0700 (PDT)
Subject: Re: [PATCH] Enable '-Werror' by default for all kernel builds
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Christoph Hellwig <hch@infradead.org>, Marco Elver <elver@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 llvm@lists.linux.dev, Nick Desaulniers <ndesaulniers@google.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 linux-riscv@lists.infradead.org, Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, kasan-dev@googlegroups.com,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210906142615.GA1917503@roeck-us.net>
 <CAHk-=wgjTePY1v_D-jszz4NrpTso0CdvB9PcdroPS=TNU1oZMQ@mail.gmail.com>
 <YTbOs13waorzamZ6@Ryzen-9-3900X.localdomain>
 <CAK8P3a3_Tdc-XVPXrJ69j3S9048uzmVJGrNcvi0T6yr6OrHkPw@mail.gmail.com>
 <YTkjJPCdR1VGaaVm@archlinux-ax161>
 <75a10e8b-9f11-64c4-460b-9f3ac09965e2@roeck-us.net>
 <YTkyIAevt7XOd+8j@elver.google.com> <YTmidYBdchAv/vpS@infradead.org>
 <a04c4c37-7151-ef7e-09ce-a61ac7b12106@roeck-us.net>
 <78aeab09-de88-966f-9f03-a2d56a0a6064@amd.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <80a56a5a-5351-1897-b87e-3c3cd84bb13c@roeck-us.net>
Date: Thu, 9 Sep 2021 07:59:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <78aeab09-de88-966f-9f03-a2d56a0a6064@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 09 Sep 2021 15:56:23 +0000
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

On 9/9/21 12:30 AM, Christian König wrote:
> Am 09.09.21 um 08:07 schrieb Guenter Roeck:
>> On 9/8/21 10:58 PM, Christoph Hellwig wrote:
>>> On Wed, Sep 08, 2021 at 11:58:56PM +0200, Marco Elver wrote:
>>>> It'd be good to avoid. It has helped uncover build issues with KASAN in
>>>> the past. Or at least make it dependent on the problematic architecture.
>>>> For example if arm is a problem, something like this:
>>>
>>> I'm also seeing quite a few stack size warnings with KASAN on x86_64
>>> without COMPILT_TEST using gcc 10.2.1 from Debian.  In fact there are a
>>> few warnings without KASAN, but with KASAN there are a lot more.
>>> I'll try to find some time to dig into them.
>>>
>>> While we're at it, with -Werror something like this is really futile:
>>>
>>> drivers/gpu/drm/amd/amdgpu/amdgpu_object.c: In function ‘amdgpu_bo_support_uswc’:
>>> drivers/gpu/drm/amd/amdgpu/amdgpu_object.c:493:2: warning: #warning
>>> Please enable CONFIG_MTRR and CONFIG_X86_PAT for better performance thanks to write-combining [-Wcpp
>>>    493 | #warning Please enable CONFIG_MTRR and CONFIG_X86_PAT for better performance \
>>>        |  ^~~~~~~
> 
> Ah, yes good point!
> 
>>
>> I have been wondering if all those #warning "errors" should either
>> be removed or be replaced with "#pragma message".
> 
> Well we started to add those warnings because people compiled their kernel with CONFIG_MTRR and CONFIG_X86_PAT and was then wondering why the performance of the display driver was so crappy.
> 
> When those warning now generate an error which you have to disable explicitly then that might not be bad at all.
> 
> It at least points people to this setting and makes it really clear that they are doing something very unusual and need to keep in mind that it might not have the desired result.
> 

That specific warning is surrounded with "#ifndef CONFIG_COMPILE_TEST"
so it doesn't really matter because it doesn't cause test build failures.
Of course, we could do the same for any #warning which does now
cause a test build failure.

Guenter
