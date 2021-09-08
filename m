Return-Path: <SRS0=RbrA=N6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C376C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 07:24:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C44061102
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 07:24:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2C44061102
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACCAF6E145;
	Wed,  8 Sep 2021 07:24:25 +0000 (UTC)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EEBE89363
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Sep 2021 04:41:45 +0000 (UTC)
Received: by mail-lj1-x233.google.com with SMTP id g14so1302271ljk.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Sep 2021 21:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SXLeBiUyDbIxM6wAYybRH9JPurCTPQJNt9i7c78CL8c=;
 b=Rbgf8Y1OXI0IcL3zhk0dAWwKjW7yFbGTWIW0f6eAu/jbsLFDiOi4j9Td9AclL2N+NR
 +6bSqPxyyq+5Nb0LgFDGqMsCdDLmUjwHSxBgvgFvSdLMsvikGXFKbJroSSWKznRdQ5wl
 7Cdl6ZMEU4XV5qDZwE4sZ4/k/6rM9tLNlbWD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SXLeBiUyDbIxM6wAYybRH9JPurCTPQJNt9i7c78CL8c=;
 b=t6vHaWMhT9+hBe85HXnssnTlHEjiQRITAyYZPQO3RAdaT0liJSGMTZfMwZ/IXiQvq1
 /cChwug5GVDK7pS8QAmHvo6fSAtzeaTe+NhI+9lJMynXNpOOgk19zc7qUYz7jrzYoC5B
 CVfllq+ZrfdpIIkQ00twxzl1yqc5mB2Opu/BuyOE25qhfM2R6rHmf1g7bVDutDIhqQ36
 eJ0Nket9bq2MbTNY0Wwtzj8HPcaxFEI8qIRs+raDiyGlrxeSS8LDbVWfLk0jqWjyk2V1
 CaCzz/WUrPgak2ARAk29+82hPANF4D5rl2nDB1rv7x2hDOtPXa+lI0CU1YJdO6yAEi2C
 bDjA==
X-Gm-Message-State: AOAM532hYhi5FmePFOVVDQz2ikeuhJvoNAqZ00JbEZRntal/YbdcVYz/
 uI0iF1DMMvbVsxQlSsX6xiOc2/mpTLhWAdY21AI=
X-Google-Smtp-Source: ABdhPJysvrJJ7cBsBfRO3BmxVxTbfTa3ZGkxvWSpmU5ZbesDKU/yxSHkASco/jpbkjwxUInGmCLFbQ==
X-Received: by 2002:a05:651c:1131:: with SMTP id
 e17mr1258440ljo.301.1631076103247; 
 Tue, 07 Sep 2021 21:41:43 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com.
 [209.85.167.49])
 by smtp.gmail.com with ESMTPSA id i6sm102605lja.112.2021.09.07.21.41.42
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Sep 2021 21:41:42 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id k4so2262642lfj.7
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Sep 2021 21:41:42 -0700 (PDT)
X-Received: by 2002:a05:6512:1112:: with SMTP id
 l18mr1285247lfg.402.1631076101854; 
 Tue, 07 Sep 2021 21:41:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210906142615.GA1917503@roeck-us.net>
 <CAHk-=wgjTePY1v_D-jszz4NrpTso0CdvB9PcdroPS=TNU1oZMQ@mail.gmail.com>
 <YTbOs13waorzamZ6@Ryzen-9-3900X.localdomain>
 <CAK8P3a3_Tdc-XVPXrJ69j3S9048uzmVJGrNcvi0T6yr6OrHkPw@mail.gmail.com>
 <CAHk-=wgZkQ+eZ02TaCpAWo_ffiLMwA2tYNHyL+B1dQ4YB0qfmA@mail.gmail.com>
 <CAHk-=wh37UWTqUzbh5qg_x9pFgqBVwpdq_Kf+hnB5mqEUkrjmg@mail.gmail.com>
 <fb50dc44-fbe4-e6b3-5abc-d90375992292@amd.com>
 <5263c3bc-b741-5fdf-92d9-42a726076e76@amd.com>
In-Reply-To: <5263c3bc-b741-5fdf-92d9-42a726076e76@amd.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 7 Sep 2021 21:41:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjgi9jGiFHs7S2BPrGXKKOaVDqQsVPUsLWxkvZFAQ_WqQ@mail.gmail.com>
Message-ID: <CAHk-=wjgi9jGiFHs7S2BPrGXKKOaVDqQsVPUsLWxkvZFAQ_WqQ@mail.gmail.com>
Subject: Re: [PATCH] Enable '-Werror' by default for all kernel builds
To: Harry Wentland <harry.wentland@amd.com>
Cc: Arnd Bergmann <arnd@kernel.org>, Leo Li <sunpeng.li@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, Nathan Chancellor <nathan@kernel.org>, 
 Guenter Roeck <linux@roeck-us.net>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev,
 Nick Desaulniers <ndesaulniers@google.com>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 08 Sep 2021 07:24:24 +0000
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

On Tue, Sep 7, 2021 at 8:52 PM Harry Wentland <harry.wentland@amd.com> wrote:
>
> Attached patches fix these x86_64 ones reported by Nick:

Hmm.

You didn't seem to fix up the calling convention for print__xyz(),
which still take those xyz structs as pass-by-value.

Obviously it would be good to do things incrementally, so if that
attached patch was just [1/N] I won't complain..

> I'm also seeing one more that might be more challenging to fix but is nearly at 1024:
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn21/display_mode_vba_21.c:3397:6: error: stack frame size of 1064 bytes in function 'dml21_ModeSupportAndSystemConfigurationFull' [-Werror,-Wframe-larger-than=]

Oh Gods, that function is truly something else..

Is there some reason why it's one humongous function, with the
occasional single-line comment?

Because it really looks to me like pretty much everywhere I see one of
those rare comments, I would go "this part should be a function of its
own", and then there would be one caller fuynction that just calls
each of those sub-functions one after the other.

That would - I think - make the code easier to read, and then it would
also make it very obvious where it magically uses a lot of stack.

My suspicion is actually "nowhere". The stack use is just hugely
spread out, and the compiler has just kept accumulating more spill
variables on the frame with no single big reason.

Yes, I see a couple of local structures:

                Pipe myPipe;
                HostVM myHostVM;

but more than that I see several function calls that have basically 62
arguments. And I wish I was making that number up. I'm not. That
"CalculatePrefetchSchedule()" call literally has 62 arguments.

But *all* of the top-level loops in that function literally look like
they could - and should - be functions in their own right. Some of
them would be fairly complex even so (ie that code under the comment

        //Prefetch Check

would be quite the big function all of its own.

We have a coding style thing:

    Documentation/process/coding-style.rst

that says that you should strive to have functions that are "short and
sweet" and fit on one or two screenfuls of text.

That one function from hell is 1832 lines of code.

It really could be improved upon.

               Linus
