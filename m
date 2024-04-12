Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91A51C4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Apr 2024 01:54:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7F5A10EE6D;
	Fri, 12 Apr 2024 01:54:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="M0v6I6BB";
	dkim-atps=neutral
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A0E510EE6D
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Apr 2024 01:54:38 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-346b94fa7ecso371113f8f.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Apr 2024 18:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712886876; x=1713491676; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=y4vlt8TB9yDjErxa7aoPppj34TQs7XIg9OjF7nGdMbk=;
 b=M0v6I6BBs3WA+7t4O85TYnQkkqgBqpl3FTBj+VHxMrdAMg+b7ExeB0jjl9NOBs7ZYh
 uSHuW1jPaKa2LVMj7DiAwyQm68Pp5uJ33qjd31Xz6GyLqcjTrGzPNNUo3AIXmMRYV9nY
 U7y+dYTIHEraLtda5ULcASb6k3TLCcTb4hWSGAAA9lKrv+6No+eoHBNzLuBXfVPX1dt/
 XqCDJxDEmctKhNRpasHnpOQ1Wqb+8pvl5InV4I0M2T6fLiMXjmjlKZq71lv8y0Hhgds2
 Xyl+gzMVX5G9zETqbhT37Dl982D42R3VTbBR1FZvS4iK88SCSVLtAg7r0HM3k/zsvVxb
 daAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712886876; x=1713491676;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y4vlt8TB9yDjErxa7aoPppj34TQs7XIg9OjF7nGdMbk=;
 b=N6YqUv0fQiDhM26CkEea1gKzf5XoGE22j3EY5hhr2gb7VkCELN2qeYf4EI4+MgYmHN
 /GwDTwjVf80y4RiyQnJPRUq7HkKupwRpQBiY1sRwPkacNf9tGY/oA/GJmOzmDXsYxnnn
 NRqRoYl0NwxIIMZoRYNIENQHmzmVZkIrRy5gnDHh2vqJhYUg5E+jpEdTy7z2Rld98L7+
 kSbTEMQI9dEbDgBcYfkWUgH8BSK04BLX3HIjFMXwEXMF4wpJOqH14HwGPEXGgCGyucto
 yV4J3SuFLBz0QQKGR86PycnGVwxwnde0B/+RSLwGZYQrq8xVho2T/FpIhDSjA4/8bvVC
 H9wQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoe0BGelYeT+UT9VQfK4y6Af5/73Fv3lnmGq5RxFsB2FCmaBfXmwCqEmRZm91Er0BbSEea91Quv8kyBN4BtyDg82HEEf0AGCt4ibaaMA==
X-Gm-Message-State: AOJu0YxzKmHVxbQDMKE4jOjmtRhAj1jBFIVEM+F+7SGJtwBj77z+uQgp
 3cTCwfdfE63yGoGIv6PpDMc1fUl+7ELUvhdhwRbhWwtG1XrelN95fvsP0uDjkURzeR2SRCXVMlQ
 a3q9UixO6sklkXjpmPV58tnhQpos=
X-Google-Smtp-Source: AGHT+IH+PR4h3oVtQ8Ez0cRs6zyDvlUxECTYXxWqfVRSac34W79R5yeA3Zq4bIaDyQbovOeeCgfyqRUJHwPOnRqGQX0=
X-Received: by 2002:a5d:474f:0:b0:33e:ca28:bb59 with SMTP id
 o15-20020a5d474f000000b0033eca28bb59mr856430wrs.57.1712886876424; Thu, 11 Apr
 2024 18:54:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240329072441.591471-1-samuel.holland@sifive.com>
 <20240329072441.591471-14-samuel.holland@sifive.com>
 <87wmp4oo3y.fsf@linaro.org>
 <75a37a4b-f516-40a3-b6b5-4aa1636f9b60@sifive.com> <87wmp4ogoe.fsf@linaro.org>
 <4c8e63d6-ba33-47fe-8150-59eba8babf2d@sifive.com>
 <CAMj1kXGW5XQxXrYaPhT6sCjH7s0EwqzNjWies3b8UWnUBW5Ngw@mail.gmail.com>
 <c0e170f7-5498-40ed-ba35-2ac392c2dd2a@app.fastmail.com>
In-Reply-To: <c0e170f7-5498-40ed-ba35-2ac392c2dd2a@app.fastmail.com>
From: Dave Airlie <airlied@gmail.com>
Date: Fri, 12 Apr 2024 11:54:25 +1000
Message-ID: <CAPM=9ty_9yKEk+cS6oJ8gD_UiB_K4X3P4mLv2RmKixLaq-1RfQ@mail.gmail.com>
Subject: Re: [PATCH v4 13/15] drm/amd/display: Use ARCH_HAS_KERNEL_FPU_SUPPORT
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ard Biesheuvel <ardb@kernel.org>,
 Samuel Holland <samuel.holland@sifive.com>, 
 Thiago Jung Bauermann <thiago.bauermann@linaro.org>,
 Andrew Morton <akpm@linux-foundation.org>, 
 linux-arm-kernel@lists.infradead.org, x86@kernel.org, 
 linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>, 
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

On Thu, 11 Apr 2024 at 17:32, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Apr 11, 2024, at 09:15, Ard Biesheuvel wrote:
> > On Thu, 11 Apr 2024 at 03:11, Samuel Holland <samuel.holland@sifive.com> wrote:
> >> On 2024-04-10 8:02 PM, Thiago Jung Bauermann wrote:
> >> > Samuel Holland <samuel.holland@sifive.com> writes:
> >>
> >> >> The short-term fix would be to drop the `select ARCH_HAS_KERNEL_FPU_SUPPORT` for
> >> >> 32-bit arm until we can provide these runtime library functions.
> >> >
> >> > Does this mean that patch 2 in this series:
> >> >
> >> > [PATCH v4 02/15] ARM: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
> >> >
> >> > will be dropped?
> >>
> >> No, because later patches in the series (3, 6) depend on the definition of
> >> CC_FLAGS_FPU from that patch. I will need to send a fixup patch unless I can
> >> find a GPL-2 compatible implementation of the runtime library functions.
> >>
> >
> > Is there really a point to doing that? Do 32-bit ARM systems even have
> > enough address space to the map the BARs of the AMD GPUs that need
> > this support?
> >
> > Given that this was not enabled before, I don't think the upshot of
> > this series should be that we enable support for something on 32-bit
> > ARM that may cause headaches down the road without any benefit.
> >
> > So I'd prefer a fixup patch that opts ARM out of this over adding
> > support code for 64-bit conversions.
>
> I have not found any dts file for a 32-bit platform with support
> for a 64-bit prefetchable BAR, and there are very few that even
> have a pcie slot (as opposed on on-board devices) you could
> plug a card into.
>
> That said, I also don't think we should encourage the use of
> floating-point code in random device drivers. There is really
> no excuse for the amdgpu driver to use floating point math
> here, and we should get AMD to fix their driver instead.

That would be nice, but it won't happen, there are many reasons for
that code to exist like it does, unless someone can write an automated
converter to fixed point and validate it produces the same results for
a long series of input values, it isn't really something that will get
"fixed".

AMD's hardware team produces the calculations, and will only look into
hardware problems in that area if the driver is using the calculations
they produce and validate.

If you've looked at the calculation complexity you'd understand this
isn't a trivial use of float-point for no reason.

Dave.
