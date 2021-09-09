Return-Path: <SRS0=y1ja=OA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F07C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Sep 2021 07:12:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9081160F13
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Sep 2021 07:12:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9081160F13
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 319DF6E979;
	Fri, 10 Sep 2021 07:12:16 +0000 (UTC)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C48A06E8C5
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Sep 2021 16:53:54 +0000 (UTC)
Received: by mail-lf1-x12a.google.com with SMTP id l10so5006943lfg.4
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Sep 2021 09:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dZAGO3iBrhQAq7cxABN7v0YxXWtGf0YiblsBwMfWyrc=;
 b=OWJMz8LLr85sFM8RFy9k59A+OTyiaRWf0ZZ0n6Rcq7tOz8KHuQoirSrp+zkJs09eDI
 qXHOeRQalPKLdGml0NfQEcoEgcJ4RTyh7hAsLCSL/ndaFI7PDIP4NyPdrC6LqlqN47u+
 Tal0cn+jttYnbxNfFIYPgA5YVSh9fCfn1aRs4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dZAGO3iBrhQAq7cxABN7v0YxXWtGf0YiblsBwMfWyrc=;
 b=eo4JyKPKD3YhZ29jv47u6gfMKH1oNRJqGmvCug7e+GkHxsC98ewlaxdD79CNsQc8Ju
 3KBVnChw52BVjJilZ8XBxoYQoMnsGnhPH3YriB5yKi8BM0bH3Ejj7GK69M2rGOV96ipt
 2wN276F7vOpkOJ9L23/YgevrFXbeQE+fr+WPGTwqV1sDSC411FMJ5YzHSodA2EamwnP0
 pxJ1RwVy+/rXgkldjUsBZSze0pXNA6yPlcDpp/JmqwN4YxgiWGJuJSnWN0qh7FUG7LAA
 mydss4UbAMdAC6RUfrA4KbUeddmxQ7HGJ9wffjdAhaMNBEIT9sXbDhdMxQTz4lC71IeV
 12hw==
X-Gm-Message-State: AOAM5337uxtgs5sjhc1SLtXKa0hV9lADSlVe+OKWcQ8yxF0PKobjrJBH
 7LVHSw9IQAkShBFQqeXszy0ccLLJuK6pEFXHq0g=
X-Google-Smtp-Source: ABdhPJyKW+6gD9OpsafNtnwRcb/TXaPPGOrjh5grc2KIi2Nb+bniBfwERvH91TTZ1v1RZh0nkh7w9A==
X-Received: by 2002:a05:6512:31d2:: with SMTP id
 j18mr620088lfe.436.1631206432655; 
 Thu, 09 Sep 2021 09:53:52 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com.
 [209.85.167.41])
 by smtp.gmail.com with ESMTPSA id m17sm256493ljp.80.2021.09.09.09.53.51
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Sep 2021 09:53:51 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id c8so5020447lfi.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Sep 2021 09:53:51 -0700 (PDT)
X-Received: by 2002:a05:6512:3da5:: with SMTP id
 k37mr583246lfv.655.1631206431030; 
 Thu, 09 Sep 2021 09:53:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210906142615.GA1917503@roeck-us.net>
 <CAHk-=wgjTePY1v_D-jszz4NrpTso0CdvB9PcdroPS=TNU1oZMQ@mail.gmail.com>
 <YTbOs13waorzamZ6@Ryzen-9-3900X.localdomain>
 <CAK8P3a3_Tdc-XVPXrJ69j3S9048uzmVJGrNcvi0T6yr6OrHkPw@mail.gmail.com>
 <YTkjJPCdR1VGaaVm@archlinux-ax161>
 <75a10e8b-9f11-64c4-460b-9f3ac09965e2@roeck-us.net>
 <YTkyIAevt7XOd+8j@elver.google.com> <YTmidYBdchAv/vpS@infradead.org>
 <CANpmjNNCVu8uyn=8=5_8rLeKM5t3h7-KzVg1aCJASxF8u_6tEQ@mail.gmail.com>
 <CAK8P3a1W-13f-qCykaaAiXAr+P_F+VhjsU-9Uu=kTPUeB4b26Q@mail.gmail.com>
 <CANpmjNPBdx4b7bp=reNJPMzSNetdyrk+503_1LLoxNMYwUhSHg@mail.gmail.com>
In-Reply-To: <CANpmjNPBdx4b7bp=reNJPMzSNetdyrk+503_1LLoxNMYwUhSHg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 9 Sep 2021 09:53:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiZqRFx6Oh8ZBer2THTMcjdbwZb5X3fCLBHmyuC9jPDhA@mail.gmail.com>
Message-ID: <CAHk-=wiZqRFx6Oh8ZBer2THTMcjdbwZb5X3fCLBHmyuC9jPDhA@mail.gmail.com>
Subject: Re: [PATCH] Enable '-Werror' by default for all kernel builds
To: Marco Elver <elver@google.com>
Cc: Arnd Bergmann <arnd@kernel.org>, Christoph Hellwig <hch@infradead.org>, 
 Guenter Roeck <linux@roeck-us.net>, Nathan Chancellor <nathan@kernel.org>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev,
 Nick Desaulniers <ndesaulniers@google.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 linux-riscv <linux-riscv@lists.infradead.org>,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
 Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
 Andrey Konovalov <andreyknvl@gmail.com>, kasan-dev <kasan-dev@googlegroups.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
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

On Thu, Sep 9, 2021 at 4:43 AM Marco Elver <elver@google.com> wrote:
>
> Sure, but the reality is that the real stack size is already doubled
> for KASAN. And that should be reflected in Wframe-larger-than.

I don't think that's true.

Quite the reverse, in fact.

Yes, the *dynamic* stack size is doubled due to KASAN, because it will
cause much deeper callchains.

But the individual frames don't grow that much apart from compilers
doing stupid things (ie apparently clang and KASAN_STACK), and if
anything, the deeper dynamic call chains means that the individual
frame size being small is even *more* important, but we do compensate
for the deeper stacks by making THREAD_SIZE_ORDER bigger at least on
x86.

Honestly, I am not even happy with the current "2048 bytes for
64-bit". The excuse has been that 64-bit needs more stack, but all it
ever did was clearly to just allow people to just do bad things.

Because a 1kB stack frame is horrendous even in 64-bit. That's not
"spill some registers" kind of stack frame. That's "put a big
structure on the stack" kind of stack frame regardless of any other
issues.

And no, "but we have 16kB of stack and we'll switch stacks on
interrupts" is not an excuse for one single level to use up 1kB, much
less 2kB.  Does anybody seriously believe that we don't quite normally
have stacks that are easily tens of frames deep?

Without having some true "this is the full callchain" information, the
best we can do is just limit individual stack frames. And 2kB is
*excessive*.

                     Linus
