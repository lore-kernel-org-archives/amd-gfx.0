Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53C1ACD1292
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Apr 2024 07:16:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D3E110EEFD;
	Thu, 11 Apr 2024 07:16:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PoTjX5JU";
	dkim-atps=neutral
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C45E010EEFD
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Apr 2024 07:15:59 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id B7B59CE2F32
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Apr 2024 07:15:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9EB3C43141
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Apr 2024 07:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1712819756;
 bh=EGxUFWIY3FhDr3OERYjKXmTSAvHQ47fM+usiXa4A2Co=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=PoTjX5JUmRzsaa0P9y56kJydskXtPGFPN262bWdaHgDQod2o3roC0PZCNerABsCwG
 bfYoknQIk2nufau511D9CeAz99/c+XBDYy9O7yS9Z1jFNFtUA7xvKQxJ/mBKdpOcAQ
 8oBKA5LroCCkdcvSrmvcnHz8S4wEMgGzlbJBgQOBAwfoqFEvq51qHBY4tBRmieeKdp
 K1V/z2yZw+dZ7cxWukX9RlSxbg26oONq6miKxZS20ViA44IL5h1YPGHEH4QM1NDmps
 q4uBHpt3fB7RefgLPmbmEkh8QFaXUgnwKcsoM6Ruke9SxJbcWtDtjMPnbo5XIn7C6E
 5gAsmHwkNvlMw==
Received: by mail-lj1-f181.google.com with SMTP id
 38308e7fff4ca-2d87660d5dbso55471821fa.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Apr 2024 00:15:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCVK2DLosHHMuFhVtaIzKFDpxLSh18VBt7HNIBZYDqdmCNxTrIFuCUMWT04DHj/ptCgZ4hZx1BOdAjVskXE7ESWv+VHDl0F3QbWYelTQbQ==
X-Gm-Message-State: AOJu0YxTiCtI8/FlZMC/BmePjxrYafGJVK8M2oz9ZgvFSMsU3snTs5gp
 CsxFANexZaz9R/rJe9bsxPd65tLT8v37jMz2RUtGCNga/YzqS9330DYtrSgMwcxz39/4ZCK42Lj
 NCHP5l7mh5mMBgx3B0kb5RH+F6J0=
X-Google-Smtp-Source: AGHT+IEIbzlNGUw7dH6rrBUAPRiam7orrjfOi6n1jf8KoAxJeALyXjve8wFV4wHUyAY7FtZhkFPztybk10CRfm7afS8=
X-Received: by 2002:a05:651c:211e:b0:2d8:d8b5:73d4 with SMTP id
 a30-20020a05651c211e00b002d8d8b573d4mr2830394ljq.4.1712819754902; Thu, 11 Apr
 2024 00:15:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240329072441.591471-1-samuel.holland@sifive.com>
 <20240329072441.591471-14-samuel.holland@sifive.com>
 <87wmp4oo3y.fsf@linaro.org>
 <75a37a4b-f516-40a3-b6b5-4aa1636f9b60@sifive.com> <87wmp4ogoe.fsf@linaro.org>
 <4c8e63d6-ba33-47fe-8150-59eba8babf2d@sifive.com>
In-Reply-To: <4c8e63d6-ba33-47fe-8150-59eba8babf2d@sifive.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 11 Apr 2024 09:15:43 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGW5XQxXrYaPhT6sCjH7s0EwqzNjWies3b8UWnUBW5Ngw@mail.gmail.com>
Message-ID: <CAMj1kXGW5XQxXrYaPhT6sCjH7s0EwqzNjWies3b8UWnUBW5Ngw@mail.gmail.com>
Subject: Re: [PATCH v4 13/15] drm/amd/display: Use ARCH_HAS_KERNEL_FPU_SUPPORT
To: Samuel Holland <samuel.holland@sifive.com>, Arnd Bergmann <arnd@arndb.de>
Cc: Thiago Jung Bauermann <thiago.bauermann@linaro.org>,
 Andrew Morton <akpm@linux-foundation.org>, 
 linux-arm-kernel@lists.infradead.org, x86@kernel.org, 
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
 Christoph Hellwig <hch@lst.de>, loongarch@lists.linux.dev,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>
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

(cc Arnd)

On Thu, 11 Apr 2024 at 03:11, Samuel Holland <samuel.holland@sifive.com> wrote:
>
> Hi Thiago,
>
> On 2024-04-10 8:02 PM, Thiago Jung Bauermann wrote:
> > Samuel Holland <samuel.holland@sifive.com> writes:
> >> On 2024-04-10 5:21 PM, Thiago Jung Bauermann wrote:
> >>>
> >>> Unfortunately this patch causes build failures on arm with allyesconfig
> >>> and allmodconfig. Tested with next-20240410.
> >
> > <snip>
> >
> >> In both cases, the issue is that the toolchain requires runtime support to
> >> convert between `unsigned long long` and `double`, even when hardware FP is
> >> enabled. There was some past discussion about GCC inlining some of these
> >> conversions[1], but that did not get implemented.
> >
> > Thank you for the explanation and the bugzilla reference. I added a
> > comment there mentioning that the problem came up again with this patch
> > series.
> >
> >> The short-term fix would be to drop the `select ARCH_HAS_KERNEL_FPU_SUPPORT` for
> >> 32-bit arm until we can provide these runtime library functions.
> >
> > Does this mean that patch 2 in this series:
> >
> > [PATCH v4 02/15] ARM: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
> >
> > will be dropped?
>
> No, because later patches in the series (3, 6) depend on the definition of
> CC_FLAGS_FPU from that patch. I will need to send a fixup patch unless I can
> find a GPL-2 compatible implementation of the runtime library functions.
>

Is there really a point to doing that? Do 32-bit ARM systems even have
enough address space to the map the BARs of the AMD GPUs that need
this support?

Given that this was not enabled before, I don't think the upshot of
this series should be that we enable support for something on 32-bit
ARM that may cause headaches down the road without any benefit.

So I'd prefer a fixup patch that opts ARM out of this over adding
support code for 64-bit conversions.
