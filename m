Return-Path: <SRS0=g6Hj=N7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB64C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Sep 2021 13:34:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 570F4611C7
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Sep 2021 13:34:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 570F4611C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 148E46E882;
	Thu,  9 Sep 2021 13:33:57 +0000 (UTC)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCB346E4CA
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Sep 2021 10:53:15 +0000 (UTC)
Received: by mail-oi1-x231.google.com with SMTP id q39so1925215oiw.12
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Sep 2021 03:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=fU5ufvRRjTtfwnNvK13MR5zMOLz3I8fk1OzlUMqINLQ=;
 b=svEsGSMujFvTtR4UMtARJNXuZvz+U/550aXRIc+7UMzXzxYASPNNCNz75C6NHgXQGg
 dVJIPTelpAL58scaurL0kBQOQTMznlEy8QRnyHQfYxdvgW794LiM1IeQsfZLCEJ22GDQ
 qeYJDSw9yib0rswsAY4EiMIpR09/rniDzcmwUBU47L1cdLS7q206vZncbq5ddz/unqpR
 JjT6q7GZ3YxYt0F0WB2frZxiJ2+sILr+1ax6Ri2HSHO4/nyZOnqbiOVisCjJQDDu6QAo
 hcv1jpLE7VOWgiP2TLIVuvoIKnrgb/YQjoBfw63Ub7F4cpzR210zw6O/4AgWl9NTv+i7
 YCmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=fU5ufvRRjTtfwnNvK13MR5zMOLz3I8fk1OzlUMqINLQ=;
 b=DMg1cIGhfkQfNBC+ZRjcDAJxJ7/ueqhOn82d9Ijaxuu10gdgi2TF/3JHhgW8/NEiRU
 jNhJ030TehzKiNzViZIMI98HD+CqXXrJWDkHAgZRjsYFVX94N4JiSdbHBjM228TF6wJz
 HFWMD37udNa2Pbbr6rqFVsLDWZwVQmSS7JQdIByaD6vrDGleE7cCEnEahAB4dN+0zeVQ
 fGBq8JZUyXOLQJaz4YmCgdY9Zv0T//StAh0hRMJsW+H6G7TUCTGPsHNpwo0YiIAyTrT1
 GUYZ+GUjBpxK/L7ddTAh2Dyj2KJTleQhbTM/kQiq7opf79s4KbzZghxvYJQQiF3O5jYj
 x1ag==
X-Gm-Message-State: AOAM530jytSetx6aV8csJiWZVeJENB73JOeSSC+Ql6pnfXNbplJD1rUY
 gSue/hQVwb37Ap4rWFLENB9tIah3evg0FtnrNi3tIQ==
X-Google-Smtp-Source: ABdhPJypirAM1jjdo9XWTXuE1r/IYJFmD049z7WphsmfidtaQM2qvedJJrF7FPI9vKRmcHUWVT9heQSyJAVB96uljac=
X-Received: by 2002:a05:6808:21a5:: with SMTP id
 be37mr1443831oib.172.1631184794726; 
 Thu, 09 Sep 2021 03:53:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210906142615.GA1917503@roeck-us.net>
 <CAHk-=wgjTePY1v_D-jszz4NrpTso0CdvB9PcdroPS=TNU1oZMQ@mail.gmail.com>
 <YTbOs13waorzamZ6@Ryzen-9-3900X.localdomain>
 <CAK8P3a3_Tdc-XVPXrJ69j3S9048uzmVJGrNcvi0T6yr6OrHkPw@mail.gmail.com>
 <YTkjJPCdR1VGaaVm@archlinux-ax161>
 <75a10e8b-9f11-64c4-460b-9f3ac09965e2@roeck-us.net>
 <YTkyIAevt7XOd+8j@elver.google.com> <YTmidYBdchAv/vpS@infradead.org>
In-Reply-To: <YTmidYBdchAv/vpS@infradead.org>
From: Marco Elver <elver@google.com>
Date: Thu, 9 Sep 2021 12:53:03 +0200
Message-ID: <CANpmjNNCVu8uyn=8=5_8rLeKM5t3h7-KzVg1aCJASxF8u_6tEQ@mail.gmail.com>
Subject: Re: [PATCH] Enable '-Werror' by default for all kernel builds
To: Christoph Hellwig <hch@infradead.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Nathan Chancellor <nathan@kernel.org>, 
 Arnd Bergmann <arnd@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev,
 Nick Desaulniers <ndesaulniers@google.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 linux-riscv@lists.infradead.org, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
 Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
 Andrey Konovalov <andreyknvl@gmail.com>, kasan-dev@googlegroups.com, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, 9 Sept 2021 at 07:59, Christoph Hellwig <hch@infradead.org> wrote:
> On Wed, Sep 08, 2021 at 11:58:56PM +0200, Marco Elver wrote:
> > It'd be good to avoid. It has helped uncover build issues with KASAN in
> > the past. Or at least make it dependent on the problematic architecture=
.
> > For example if arm is a problem, something like this:
>
> I'm also seeing quite a few stack size warnings with KASAN on x86_64
> without COMPILT_TEST using gcc 10.2.1 from Debian.  In fact there are a
> few warnings without KASAN, but with KASAN there are a lot more.
> I'll try to find some time to dig into them.

Right, this reminded me that we actually at least double the real
stack size for KASAN builds, because it inherently requires more stack
space. I think we need Wframe-larger-than to match that, otherwise
we'll just keep having this problem:

https://lkml.kernel.org/r/20210909104925.809674-1-elver@google.com

> While we're at it, with -Werror something like this is really futile:
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_object.c: In function =E2=80=98amdgpu_b=
o_support_uswc=E2=80=99:
> drivers/gpu/drm/amd/amdgpu/amdgpu_object.c:493:2: warning: #warning
> Please enable CONFIG_MTRR and CONFIG_X86_PAT for better performance thank=
s to write-combining [-Wcpp
>   493 | #warning Please enable CONFIG_MTRR and CONFIG_X86_PAT for better =
performance \
>       |  ^~~~~~~
