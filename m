Return-Path: <SRS0=g6Hj=N7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B90BAC433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Sep 2021 07:29:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ED5861101
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Sep 2021 07:29:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5ED5861101
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA7D06E45D;
	Thu,  9 Sep 2021 07:29:12 +0000 (UTC)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 046B16E444
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Sep 2021 06:08:00 +0000 (UTC)
Received: by mail-ot1-x32f.google.com with SMTP id
 m7-20020a9d4c87000000b0051875f56b95so1141187otf.6
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Sep 2021 23:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=5IZhKmYjWyUNxqS/JWropfkc5GoYoPNRqG2FrnyCWSw=;
 b=Uby1UFSqv+tObg8zy1Qt9JfEE0z4OOZS1mZrQSbWDi0jjncQe48BLUiEkCBnIT0OEH
 XZEM6zsVARUlXeVJksyht7d1Gib8J5mY4X0cwD8cLeV3nlJJKTPKqo6WI+mrt82lFgq8
 FApkveOpRQYKUP/1FEkXoO8h21Ow3ja9KPCw6IFjzKNNfU+7+afhnR/akfRpZdNGlp0T
 lcEBTEqvbbJdbdGUGw6Y+vIhtwvqzpYx3iPXFHBJw7axVEtjK/5LyF7fYiUNP8a9DCEk
 Bj0kX4U3FzIu5lmRVwoJ1aWhneyWpViN7s5hOqA/z7SRBwEVs51RxSVvIohhBbGaAJHq
 5h9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5IZhKmYjWyUNxqS/JWropfkc5GoYoPNRqG2FrnyCWSw=;
 b=gss9Ro5o5ZMEXv97W3uzM7nhjlVpQTGzSRL+IaqXKpDnU/nrmlsVONaeaGO+HJEwXl
 tEfMwfjBDh/EfWKuL7DDSmzHr27Al0wY31IjRqIn8b+6slDvYuFw2XURWmT7x7Yxh4Pz
 JF430snmZoN2T+D6NrhdcBlbbEAVyShkBfS0uvCi06yei/+p6wrNsPB1Xj/saJacYXPs
 ZTR9qK9m/+xKY716E7vtBPx3y+z6jH32VYGl/hs/yndjY3UshQSqsuPpIgk2vwa6P/4Z
 OpzNJMAokLohN4QYR3KDpkClCcAi32glp90eNeVBnjn4XjEQFJISezcO64+sgLsvHXWA
 HhwQ==
X-Gm-Message-State: AOAM530/1x0CEgeNhfK5SpJXl/JD2xDKlX+jvpJbE3vsLJwtHOpi5rvF
 cLUETJ05K+e51geFsi7Ja9eWKC/6+Eo=
X-Google-Smtp-Source: ABdhPJz2e0pQIKzbERrP4yOrC1kq1zJGwp23agv3qtyCHWfk+VzWPFR9D44RgTj57Sc8MlD8s8FyJg==
X-Received: by 2002:a05:6830:4084:: with SMTP id
 x4mr1039349ott.280.1631167679964; 
 Wed, 08 Sep 2021 23:07:59 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 y7sm180455oov.36.2021.09.08.23.07.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Sep 2021 23:07:59 -0700 (PDT)
Subject: Re: [PATCH] Enable '-Werror' by default for all kernel builds
To: Christoph Hellwig <hch@infradead.org>, Marco Elver <elver@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 llvm@lists.linux.dev, Nick Desaulniers <ndesaulniers@google.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 linux-riscv@lists.infradead.org, Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, kasan-dev@googlegroups.com,
 Christian =?unknown-8bit?B?S8O2bmln?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210906142615.GA1917503@roeck-us.net>
 <CAHk-=wgjTePY1v_D-jszz4NrpTso0CdvB9PcdroPS=TNU1oZMQ@mail.gmail.com>
 <YTbOs13waorzamZ6@Ryzen-9-3900X.localdomain>
 <CAK8P3a3_Tdc-XVPXrJ69j3S9048uzmVJGrNcvi0T6yr6OrHkPw@mail.gmail.com>
 <YTkjJPCdR1VGaaVm@archlinux-ax161>
 <75a10e8b-9f11-64c4-460b-9f3ac09965e2@roeck-us.net>
 <YTkyIAevt7XOd+8j@elver.google.com> <YTmidYBdchAv/vpS@infradead.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <a04c4c37-7151-ef7e-09ce-a61ac7b12106@roeck-us.net>
Date: Wed, 8 Sep 2021 23:07:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YTmidYBdchAv/vpS@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 09 Sep 2021 07:29:12 +0000
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

On 9/8/21 10:58 PM, Christoph Hellwig wrote:
> On Wed, Sep 08, 2021 at 11:58:56PM +0200, Marco Elver wrote:
>> It'd be good to avoid. It has helped uncover build issues with KASAN in
>> the past. Or at least make it dependent on the problematic architecture.
>> For example if arm is a problem, something like this:
> 
> I'm also seeing quite a few stack size warnings with KASAN on x86_64
> without COMPILT_TEST using gcc 10.2.1 from Debian.  In fact there are a
> few warnings without KASAN, but with KASAN there are a lot more.
> I'll try to find some time to dig into them.
> 
> While we're at it, with -Werror something like this is really futile:
> 
> drivers/gpu/drm/amd/amdgpu/amdgpu_object.c: In function ‘amdgpu_bo_support_uswc’:
> drivers/gpu/drm/amd/amdgpu/amdgpu_object.c:493:2: warning: #warning
> Please enable CONFIG_MTRR and CONFIG_X86_PAT for better performance thanks to write-combining [-Wcpp
>    493 | #warning Please enable CONFIG_MTRR and CONFIG_X86_PAT for better performance \
>        |  ^~~~~~~
> 

I have been wondering if all those #warning "errors" should either
be removed or be replaced with "#pragma message".

Guenter
