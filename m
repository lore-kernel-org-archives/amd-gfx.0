Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F133CD1299
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Apr 2024 07:41:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BC8A10F1F4;
	Thu, 11 Apr 2024 07:41:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ge4k9NFf";
	dkim-atps=neutral
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com
 [209.85.160.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB89110EBFF
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Apr 2024 01:27:55 +0000 (UTC)
Received: by mail-oa1-f52.google.com with SMTP id
 586e51a60fabf-2330f85c2ebso752647fac.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Apr 2024 18:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712798875; x=1713403675; darn=lists.freedesktop.org;
 h=mime-version:message-id:date:user-agent:references:in-reply-to
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zY1vBuYzXUVAUPu7RYDaF9UtFORvIFjy44r4Y5Ige4g=;
 b=Ge4k9NFf8j7/tkmZZBqcMGFxju6naUP5qnKHaNywuOPaJ5I9+xoSj76J5UKMvpkf2P
 y7c2b9aBl9kkyz/0MK+3+sOAsd7VjgLrW5S8CybcxJ/EKmWQTXJMjBLj07mMajuPAtlw
 1uYYM6i6Ip+/F05wCOxlAnIkhY1lbKLB9/072EJCiJCCZhqLtUSiboGlB4oKkZaaW9Id
 opy8Ldf+eY9xqDuvY+w63+Yd0EEc33Y5ieyezqZryaMIZVuOPpPBJAFxg0UP3UAPsaCI
 S1SEe/BNFGwCi8D6FNhISCfm4BzXEGFT9TPekFFuwbYUog80VcCcBRseiTb7OzjEukFJ
 IB+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712798875; x=1713403675;
 h=mime-version:message-id:date:user-agent:references:in-reply-to
 :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zY1vBuYzXUVAUPu7RYDaF9UtFORvIFjy44r4Y5Ige4g=;
 b=GzhVrnuXH81/FKtZNxsueurBVL7GMLB4ebSOPvLjI6DZIgxqNUQpYAQQAs6zRqKady
 v2yrBbwSlv4sKMKHwD1anVjxzcmmDyDSEywYE9JX8NuHvE8cgTM0/U/4LhS/K+dKcKlA
 Zw/33ED/81HQER4UE/OnOToQmXz8ZsL55UVHCEGF7mnURHBokHW8onmG6ip5CtFqAloK
 EVcvnkvMwBMS+KI8XiHN9YW8h7T5MRKaToae3pO9dmZXdRBSI14os7oNvPn6z+WfiT9c
 03durcHsygd1kOUzceF9lS2MfK3jDKCug62k3SMUovlTzSEIm0xAPjJ+0KKCzD9jEE2z
 jofA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6HQy20sUKgKjDrgwrVyinHRv4rop2OHIWY9G5h3vvJZY7rOqLIGx4NQBrjSnkdfenyprSuhNY8WSq1/xpxf9LnYJ2HUJ7TZAKyD0kZQ==
X-Gm-Message-State: AOJu0YyVZf7QWru0QOytftATu2ymJSf6gqyt/uhaIkAeCogVpQwvWECF
 dpIcPp9p6eGGI7qkqBbnYtLe/ZYpVZAooOqoLtVBX4+dHStH68OeQdBd91nFUmyumnvRjQPKqQI
 +Qxs=
X-Google-Smtp-Source: AGHT+IF8lPPFTalL1WPSfnBvduuYhf5K6F9EIeC9RLCCka0Vl/mHkW4wRauCXJubFXwb7faJCr3ffA==
X-Received: by 2002:a05:6870:518:b0:22e:bcfd:deb0 with SMTP id
 j24-20020a056870051800b0022ebcfddeb0mr4667832oao.41.1712798874921; 
 Wed, 10 Apr 2024 18:27:54 -0700 (PDT)
Received: from localhost ([2804:14d:7e39:8470:fcac:9b42:fe81:c62f])
 by smtp.gmail.com with ESMTPSA id
 c1-20020aa78c01000000b006ed38291aebsm289791pfd.178.2024.04.10.18.27.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Apr 2024 18:27:54 -0700 (PDT)
From: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org,  x86@kernel.org,
 linux-kernel@vger.kernel.org,  linux-arch@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,  linux-riscv@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>,  loongarch@lists.linux.dev,
 amd-gfx@lists.freedesktop.org,  Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH v4 13/15] drm/amd/display: Use ARCH_HAS_KERNEL_FPU_SUPPORT
In-Reply-To: <4c8e63d6-ba33-47fe-8150-59eba8babf2d@sifive.com> (Samuel
 Holland's message of "Wed, 10 Apr 2024 20:11:04 -0500")
References: <20240329072441.591471-1-samuel.holland@sifive.com>
 <20240329072441.591471-14-samuel.holland@sifive.com>
 <87wmp4oo3y.fsf@linaro.org>
 <75a37a4b-f516-40a3-b6b5-4aa1636f9b60@sifive.com>
 <87wmp4ogoe.fsf@linaro.org>
 <4c8e63d6-ba33-47fe-8150-59eba8babf2d@sifive.com>
User-Agent: mu4e 1.12.2; emacs 29.3
Date: Wed, 10 Apr 2024 22:27:52 -0300
Message-ID: <87le5kofhj.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Thu, 11 Apr 2024 07:41:32 +0000
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


Hello Samuel,

Samuel Holland <samuel.holland@sifive.com> writes:

> On 2024-04-10 8:02 PM, Thiago Jung Bauermann wrote:
>> Samuel Holland <samuel.holland@sifive.com> writes:
>>> On 2024-04-10 5:21 PM, Thiago Jung Bauermann wrote:
>>>>
>>>> Unfortunately this patch causes build failures on arm with allyesconfig
>>>> and allmodconfig. Tested with next-20240410.
>>
>> <snip>
>>
>>> In both cases, the issue is that the toolchain requires runtime support to
>>> convert between `unsigned long long` and `double`, even when hardware FP is
>>> enabled. There was some past discussion about GCC inlining some of these
>>> conversions[1], but that did not get implemented.
>>
>> Thank you for the explanation and the bugzilla reference. I added a
>> comment there mentioning that the problem came up again with this patch
>> series.
>>
>>> The short-term fix would be to drop the `select ARCH_HAS_KERNEL_FPU_SUPPORT` for
>>> 32-bit arm until we can provide these runtime library functions.
>>
>> Does this mean that patch 2 in this series:
>>
>> [PATCH v4 02/15] ARM: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
>>
>> will be dropped?
>
> No, because later patches in the series (3, 6) depend on the definition of
> CC_FLAGS_FPU from that patch. I will need to send a fixup patch unless I can
> find a GPL-2 compatible implementation of the runtime library functions.

Ok, thank you for clarifying.

Andrew Pinski just responded on the GCC bugzilla and if I understood his
point correctly, it seems to be a matter of changing function names to
what GCC (or actually the arm EABI) expects...

--
Thiago
