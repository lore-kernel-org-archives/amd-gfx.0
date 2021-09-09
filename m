Return-Path: <SRS0=y1ja=OA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 944F2C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Sep 2021 07:12:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22ADD60F13
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Sep 2021 07:12:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 22ADD60F13
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 547466E97C;
	Fri, 10 Sep 2021 07:12:16 +0000 (UTC)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D8356E8C2
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Sep 2021 16:46:45 +0000 (UTC)
Received: by mail-lf1-x12f.google.com with SMTP id x27so4952510lfu.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Sep 2021 09:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6u9UXBJqq0DvpwbwzhX2UgLgOMc73mPLE0iuNkQUyLg=;
 b=c3sO1BQBDxCW8APZUbAlW9nwWGjPxn+LQp0JgfliDLXRZzDRVo3j7/1R4pPWKE+xNx
 UbgmU4XAmaM891Bx14LElamvax9VI3JEUCFywjuYbWwv0nvT93I+fRhltOoT4VSe8vnz
 QPRBUEbBxEv21a9fqhAw650AWuxptlmMiPwqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6u9UXBJqq0DvpwbwzhX2UgLgOMc73mPLE0iuNkQUyLg=;
 b=wGHqM7JkIlPJditCewsqkfeZjdLY01GbX5P0WHkY09rZnvh2KKMwsbLEsvp6w5ThWY
 Lcybti3qaIX72aqgjBURwzJ8APntBuGth9IPwlPkVJSRvxxEEFePtvXQ6Xtm5Ndgv46a
 v7ncpBvgPW1E6Tf6ocE+QyP4Ipj1LaO164ybShMDDXeyzvoRgbONFZw3wM17WCzK8wbn
 gTeAh2uEPxJM2tQMOvDqy920VfN3w2Fbz7ODyyQuHQqxQCKgKi+OHCXRM2yZmxVIpusM
 6AWZOXvDecytyYnD2VuLURg0pQnhpt9x/7ANj8w7gXQwxMyNdouEvYJBC1aht7TnrYuS
 R0YQ==
X-Gm-Message-State: AOAM531CU+XhNR/BXc1Yj+1ItB086vIeaxkrJ5n9YEDX4J6g99rtb4BS
 b52bIENBYL6O3jnGF4Fw/0pzqwmuknPxyemNoBc=
X-Google-Smtp-Source: ABdhPJy1wKY709jX72fKLY8htDb73Hf5gV+TjV+QoRc27qAQmDl2mD+itTAv87bBTHWRo0/NdRZbqg==
X-Received: by 2002:a05:6512:3e22:: with SMTP id
 i34mr672713lfv.374.1631206002976; 
 Thu, 09 Sep 2021 09:46:42 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com.
 [209.85.167.44])
 by smtp.gmail.com with ESMTPSA id j17sm249809lfe.55.2021.09.09.09.46.41
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Sep 2021 09:46:41 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id s10so4912990lfr.11
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Sep 2021 09:46:41 -0700 (PDT)
X-Received: by 2002:a05:6512:1112:: with SMTP id
 l18mr609222lfg.402.1631206001151; 
 Thu, 09 Sep 2021 09:46:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210906142615.GA1917503@roeck-us.net>
 <CAHk-=wgjTePY1v_D-jszz4NrpTso0CdvB9PcdroPS=TNU1oZMQ@mail.gmail.com>
 <YTbOs13waorzamZ6@Ryzen-9-3900X.localdomain>
 <CAK8P3a3_Tdc-XVPXrJ69j3S9048uzmVJGrNcvi0T6yr6OrHkPw@mail.gmail.com>
 <YTkjJPCdR1VGaaVm@archlinux-ax161>
 <75a10e8b-9f11-64c4-460b-9f3ac09965e2@roeck-us.net>
 <YTkyIAevt7XOd+8j@elver.google.com> <YTmidYBdchAv/vpS@infradead.org>
In-Reply-To: <YTmidYBdchAv/vpS@infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 9 Sep 2021 09:46:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=whsicuPaicXWh5je6unQYRKwoazuNLzB-9PRXpSY3CZ-g@mail.gmail.com>
Message-ID: <CAHk-=whsicuPaicXWh5je6unQYRKwoazuNLzB-9PRXpSY3CZ-g@mail.gmail.com>
Subject: Re: [PATCH] Enable '-Werror' by default for all kernel builds
To: Christoph Hellwig <hch@infradead.org>
Cc: Marco Elver <elver@google.com>, Guenter Roeck <linux@roeck-us.net>, 
 Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@kernel.org>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev,
 Nick Desaulniers <ndesaulniers@google.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 linux-riscv@lists.infradead.org, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
 Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
 Andrey Konovalov <andreyknvl@gmail.com>, kasan-dev <kasan-dev@googlegroups.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 10 Sep 2021 07:12:15 +0000
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

On Wed, Sep 8, 2021 at 10:59 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> While we're at it, with -Werror something like this is really futile:

Yeah, I'm thinking we could do

 -Wno-error=cpp

to at least allow the cpp warnings to come through without being fatal.

Because while they can be annoying too, they are most definitely under
our direct control, so..

I didn't actually test that, but I think it should work.

That said, maybe they should just be removed. They might be better off
just as Kconfig rules, rather than as a "hey, you screwed up your
Kconfig" warning after the fact.

             Linus
