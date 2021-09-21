Return-Path: <SRS0=vd7l=OL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C93C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 15:42:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E7AA60E08
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 15:42:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7E7AA60E08
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3874E6EA2E;
	Tue, 21 Sep 2021 15:42:21 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6717C6EA2E
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Sep 2021 15:42:20 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1A4B56124C
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Sep 2021 15:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632238940;
 bh=fsjbdWhaoEfRC8WZUJZWmQoz3Z1K+BhTC5bgPI2OUwY=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=gP5MGqKYgk4HRxFKHmdtQGin3QHteX41wLf5I2/j/fNS6xhSnkWlXcgaDGVTPRM+2
 Y/oVqdsaFB0gsP1HruzAViKgHiI4cBYYG0LX3mdra9dwhZboaCOyAgRwQ3KoDZH+h8
 WSji3OwHN4GI/GgONTNcvuRx2shXWPJJGrAqbSSEVY30pWN/soDfU+VlV2is5SrXSZ
 Mnu4eFdelzoVDTtMkAPOy5wAF3xHFA3yr+oFt4+wl6bCHfv3z8LR9fyJ1+x9xYTvEs
 7XnHVHkLyboIn3P/5oBKShVJzirVoAXDe7Jr3YFBWgBkDiEsIjq2LNpCGXkxV2BDdW
 jIoJz1hEuB3YQ==
Received: by mail-wr1-f47.google.com with SMTP id d6so40329278wrc.11
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Sep 2021 08:42:20 -0700 (PDT)
X-Gm-Message-State: AOAM530bkZFlVmZQ605obDg1TpTC+0vg7LE/1iCu2Ifb9xHGdXSiBQQY
 p4L1InQXMw5Ka29RVBg+AMlLAtyX92JEb3Ja0ig=
X-Google-Smtp-Source: ABdhPJxGTopYiF3OBAqRLkSep1+4ZT7zRaVkA2do2C6Qe3HFsc8eV27bRIwi9KNJqEZq+iitDSLyD3XEYzWG5Cg6+sg=
X-Received: by 2002:a05:600c:3209:: with SMTP id
 r9mr5344103wmp.35.1632238935395; 
 Tue, 21 Sep 2021 08:42:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210906142615.GA1917503@roeck-us.net>
 <CAHk-=wgjTePY1v_D-jszz4NrpTso0CdvB9PcdroPS=TNU1oZMQ@mail.gmail.com>
 <YTbOs13waorzamZ6@Ryzen-9-3900X.localdomain>
 <CAK8P3a3_Tdc-XVPXrJ69j3S9048uzmVJGrNcvi0T6yr6OrHkPw@mail.gmail.com>
 <YTkjJPCdR1VGaaVm@archlinux-ax161>
In-Reply-To: <YTkjJPCdR1VGaaVm@archlinux-ax161>
From: Arnd Bergmann <arnd@kernel.org>
Date: Tue, 21 Sep 2021 17:41:58 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0tswcc1icb99cmdX7w0nBc4CAXjaAKJMuYSdJC1MS8YQ@mail.gmail.com>
Message-ID: <CAK8P3a0tswcc1icb99cmdX7w0nBc4CAXjaAKJMuYSdJC1MS8YQ@mail.gmail.com>
Subject: Re: [PATCH] Enable '-Werror' by default for all kernel builds
To: Nathan Chancellor <nathan@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Guenter Roeck <linux@roeck-us.net>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev,
 Nick Desaulniers <ndesaulniers@google.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 linux-riscv <linux-riscv@lists.infradead.org>,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
 Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
 Andrey Konovalov <andreyknvl@gmail.com>, kasan-dev <kasan-dev@googlegroups.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 xinhui pan <Xinhui.Pan@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
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

On Wed, Sep 8, 2021 at 10:55 PM Nathan Chancellor <nathan@kernel.org> wrote:
> On Tue, Sep 07, 2021 at 11:11:17AM +0200, Arnd Bergmann wrote:
> > On Tue, Sep 7, 2021 at 4:32 AM Nathan Chancellor <nathan@kernel.org> wrote:
function 'rtw_aes_decrypt' [-Werror,-Wframe-larger-than]
> > > arm32-fedora.log: drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dce_calcs.c:3043:6: error: stack frame size (1376) exceeds limit (1024) in function 'bw_calcs' [-Werror,-Wframe-larger-than]
> > > arm32-fedora.log: drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dce_calcs.c:77:13: error: stack frame size (5384) exceeds limit (1024) in function 'calculate_bandwidth' [-Werror,-Wframe-larger-than]
> > >
> > > Aside from the dce_calcs.c warnings, these do not seem too bad. I
> > > believe allmodconfig turns on UBSAN but it could also be aggressive
> > > inlining by clang. I intend to look at all -Wframe-large-than warnings
> > > closely later.
> >
> > I've had them close to zero in the past, but a couple of new ones came in.
> >
> > The amdgpu ones are probably not fixable unless they stop using 64-bit
> > floats in the kernel for
> > random calculations. The crypto/* ones tend to be compiler bugs, but hard to fix
>
> I have started taking a look at these. Most of the allmodconfig ones
> appear to be related to CONFIG_KASAN, which is now supported for
> CONFIG_ARM.
>
> The two in bpmp-debugfs.c appear regardless of CONFIG_KASAN and it turns
> out that you actually submitted a patch for these:
>
> https://lore.kernel.org/r/20201204193714.3134651-1-arnd@kernel.org/
>
> Is it worth resending or pinging that?

I'm now restarting from a clean tree for my randconfig patches to see which
ones are actually needed, will hopefully get to that.

> The dce_calcs.c ones also appear without CONFIG_KASAN, which you noted
> is probably unavoidable.

(adding amdgpu folks to Cc here)

Harry Wentland did a nice rework for dcn_calcs.c that should also be
portable to dce_calcs.c, I hope that he will be able to get to that as well.

Looking at my older patches now, I found that I had only suppressed that one
and given up fixing it, but I did put my analysis into
https://bugs.llvm.org/show_bug.cgi?id=42551, which should be helpful
for addressing it in either the kernel or the compiler.

        Arnd
