Return-Path: <SRS0=g6Hj=N7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8C8C433FE
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Sep 2021 13:33:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C82B611BF
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Sep 2021 13:33:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8C82B611BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFABF6E87C;
	Thu,  9 Sep 2021 13:33:52 +0000 (UTC)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2152E6E52C
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Sep 2021 11:43:57 +0000 (UTC)
Received: by mail-oi1-x22b.google.com with SMTP id w144so2067765oie.13
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Sep 2021 04:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ge0i4MysJLg7UB+Yx2AaDOSBAP1whBCQ4nJVOdEAFfQ=;
 b=AM0acIeRzwZOQ8ps3Z56Nt2NWs6+nlhrzsKcVFwKMDqqa7rDx5eL5KDD0h/BaJoTnn
 Yyyxu9wJG75huSLycWf8IDuT7DT0EULGp5e0DvypWYxR9B4SQfPU5j8Fn4XhfFEruwLE
 ClKvJyFIvmnV6Km2XZLLKRVpzmuk+CmtA15esdDv1bDunZyDxFsQlEfitpESUQeSYFJp
 8BTH19cQVldl2Q/Q/K063Hrw0iJTbEvdUS66oLsCqTbhNgBAq0kgnGI6EB+sd5gWro4q
 6u6ZSKDtWZTSrF4AorelJKBZfPAQkJjHlymjU+m1V7QiieTyxzEwYQ0qxBYlDgPTQOni
 8v9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ge0i4MysJLg7UB+Yx2AaDOSBAP1whBCQ4nJVOdEAFfQ=;
 b=us7+sWtNe+oaamKXm+6dC//w1/rMLaBZ98B98tymHqY9XGhUdz4Bvn3Et6ZI4462Ns
 QuUgzD0hsjq9Kg60tYD3cu+cEoTHUpfruzqg2P3fRAj2ic3F335R6HmcHoMD/gnGQNGJ
 28aao+Ohm+zYcDhPoDckx168CuzZRFRxwOlZOi4fAtV7SXRaG5oSdSbCCxLr/vp+OmkG
 uvIthwZOX7qUox3GlisAw6Kgsvd+4Qd64AjML//Nq3vxT8ROFsmyA9GjIH3eugW1JviY
 N0jlyutUJowo7vj8HxgA9WB1Yn1ZAkRabvb7MvSI2aioaBCavj0PHwWiAMPKDdZN6x2M
 ewJw==
X-Gm-Message-State: AOAM533v/IN03M2X+JCogcR3Syv6K7r1zLnm8TKEbiWlryqSr01IeER0
 /1jMtfU+EE+rvw3W0MDTlcwT6VMUpowpcyA1vHv/+w==
X-Google-Smtp-Source: ABdhPJz4Mhm5+vx6TwV+94c8TrEoyJnBnwuFZl9zQWVxFkMW7/1ms65QTzG16fCfVI4XNFxP1+08u3vCaxDOvTe4liM=
X-Received: by 2002:aca:4344:: with SMTP id q65mr1645122oia.70.1631187836164; 
 Thu, 09 Sep 2021 04:43:56 -0700 (PDT)
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
In-Reply-To: <CAK8P3a1W-13f-qCykaaAiXAr+P_F+VhjsU-9Uu=kTPUeB4b26Q@mail.gmail.com>
From: Marco Elver <elver@google.com>
Date: Thu, 9 Sep 2021 13:43:44 +0200
Message-ID: <CANpmjNPBdx4b7bp=reNJPMzSNetdyrk+503_1LLoxNMYwUhSHg@mail.gmail.com>
Subject: Re: [PATCH] Enable '-Werror' by default for all kernel builds
To: Arnd Bergmann <arnd@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Guenter Roeck <linux@roeck-us.net>, 
 Nathan Chancellor <nathan@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, 
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
X-Mailman-Approved-At: Thu, 09 Sep 2021 13:33:52 +0000
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

On Thu, 9 Sept 2021 at 13:00, Arnd Bergmann <arnd@kernel.org> wrote:
> On Thu, Sep 9, 2021 at 12:54 PM Marco Elver <elver@google.com> wrote:
> > On Thu, 9 Sept 2021 at 07:59, Christoph Hellwig <hch@infradead.org> wrote:
> > > On Wed, Sep 08, 2021 at 11:58:56PM +0200, Marco Elver wrote:
> > > > It'd be good to avoid. It has helped uncover build issues with KASAN in
> > > > the past. Or at least make it dependent on the problematic architecture.
> > > > For example if arm is a problem, something like this:
> > >
> > > I'm also seeing quite a few stack size warnings with KASAN on x86_64
> > > without COMPILT_TEST using gcc 10.2.1 from Debian.  In fact there are a
> > > few warnings without KASAN, but with KASAN there are a lot more.
> > > I'll try to find some time to dig into them.
> >
> > Right, this reminded me that we actually at least double the real
> > stack size for KASAN builds, because it inherently requires more stack
> > space. I think we need Wframe-larger-than to match that, otherwise
> > we'll just keep having this problem:
> >
> > https://lkml.kernel.org/r/20210909104925.809674-1-elver@google.com
>
> The problem with this is that it completely defeats the point of the
> stack size warnings in allmodconfig kernels when they have KASAN
> enabled and end up missing obvious code bugs in drivers that put
> large structures on the stack. Let's not go there.

Sure, but the reality is that the real stack size is already doubled
for KASAN. And that should be reflected in Wframe-larger-than.

Either that, or we just have to live with the occasional warning (that
is likely benign). But with WERROR we're now forced to make the
defaults as sane as possible. If the worry is allmodconfig, maybe we
do have to make KASAN dependent on !COMPILE_TEST, even though that's
not great either because it has caught real issues in the past (it'll
also mean doing the same for all other instrumentation-based tools,
like KCSAN, UBSAN, etc.).
