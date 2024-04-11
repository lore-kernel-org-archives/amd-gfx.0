Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92698CD129C
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Apr 2024 07:41:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B07F410F21B;
	Thu, 11 Apr 2024 07:41:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oAtoadvy";
	dkim-atps=neutral
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9B7E10E55E
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Apr 2024 01:02:12 +0000 (UTC)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-5d8ddbac4fbso5719288a12.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Apr 2024 18:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712797332; x=1713402132; darn=lists.freedesktop.org;
 h=mime-version:message-id:date:user-agent:references:in-reply-to
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kLD5kpB2LP2j5uUBOjlchyyyLOgJsQ4KSunDLcwJfvc=;
 b=oAtoadvyQtfPLma7PF9oV/lxcAwadigg0MtUZdX+LYl1JREb80EZCxcPXQKiAZkZz0
 7UjLeDAcEZPOQxOKT0aRz+RmfNxx0x/JWMyY8tZo1bYNDa8WcKcBJGwbDZ/Yri7ZuWn1
 5SQxbXDGcsC2WChO5ogp/b+xbucVFCcXYe2o8hh7Fr1x38saz0a1YW1HzsLibAPpitn7
 IMgGXYmMULGaIT/lzPndUHYtX7VFdrRt++4rly5rTO4YFqTMahL80LL8NyCxBgzE9Cz2
 MPrQu/ZoPATqfyGpHrGHot0OrLQ0ZQGsEshP0FZgvv3u46o5pgtlg72FB+5rU8Q4WZlB
 PreQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712797332; x=1713402132;
 h=mime-version:message-id:date:user-agent:references:in-reply-to
 :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kLD5kpB2LP2j5uUBOjlchyyyLOgJsQ4KSunDLcwJfvc=;
 b=bIgV8GsgDkn54oiOpw9b1fKbEJNnYH+anqOlbr1fX9vx8LhslOmbFnbMKoKl7L1Vsg
 XvFQxild/cZGwc8xC8me7eV5njjhzXZfvFpDHVt+1aej9XDPtSeGEPsxrURsq1YcZ9p/
 hv+SiTi/W/C4/ApBbKefGxiQTrQjlFIUJBSNz9Q+01UE5CdeBmCY7Zj/dK2BELMe7KYH
 ux3LKR5X38Knj8B4Ahfz7ZorrvZbzqHi5Fbe2OZEtsv6XIIZQJSgBAlXvsJIkxeot+kg
 9gHZrjsS9Bvhqoh3FzKenG1RnuqSNlJShbq6H3GV/7O6hlR6hQ3QMVgJh6MOew8XPyHg
 LfqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVsFwrqmdEmX/3xf7ZOSA6+hzF03yTzMDbAfBlinmZilfEjQqxtsFnAmdzjG/Dp0wCR2p2zyjuBJoxByLNuJepsW50ppxXc4cF229f/A==
X-Gm-Message-State: AOJu0YxOo2Marw00418xSchlL1LDZ2haZl0Dr5DXrXL5qX4Fdp89jSk8
 LVdlQt2Jhhww1q+43iSVqb5niDNQXOA5RMCq67J3E8r90uMAM7gkaHZwZhQNocg=
X-Google-Smtp-Source: AGHT+IFCQFsX0y012c0RYVyy1pzruF/1YvRQvQO3mIZBA6xLw4Uhegn+z6nHl9NsGJg7fqoOGUPO2w==
X-Received: by 2002:a17:90b:3643:b0:2a5:608e:1012 with SMTP id
 nh3-20020a17090b364300b002a5608e1012mr4531315pjb.21.1712797332116; 
 Wed, 10 Apr 2024 18:02:12 -0700 (PDT)
Received: from localhost ([2804:14d:7e39:8470:fcac:9b42:fe81:c62f])
 by smtp.gmail.com with ESMTPSA id
 q4-20020a17090a68c400b002a22c8e99afsm248176pjj.12.2024.04.10.18.02.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Apr 2024 18:02:11 -0700 (PDT)
From: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org,  x86@kernel.org,
 linux-kernel@vger.kernel.org,  linux-arch@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,  linux-riscv@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>,  loongarch@lists.linux.dev,
 amd-gfx@lists.freedesktop.org,  Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH v4 13/15] drm/amd/display: Use ARCH_HAS_KERNEL_FPU_SUPPORT
In-Reply-To: <75a37a4b-f516-40a3-b6b5-4aa1636f9b60@sifive.com> (Samuel
 Holland's message of "Wed, 10 Apr 2024 17:47:27 -0500")
References: <20240329072441.591471-1-samuel.holland@sifive.com>
 <20240329072441.591471-14-samuel.holland@sifive.com>
 <87wmp4oo3y.fsf@linaro.org>
 <75a37a4b-f516-40a3-b6b5-4aa1636f9b60@sifive.com>
User-Agent: mu4e 1.12.2; emacs 29.3
Date: Wed, 10 Apr 2024 22:02:09 -0300
Message-ID: <87wmp4ogoe.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Thu, 11 Apr 2024 07:41:31 +0000
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

Thank you for the quick reply!

Samuel Holland <samuel.holland@sifive.com> writes:
> On 2024-04-10 5:21 PM, Thiago Jung Bauermann wrote:
>>
>> Unfortunately this patch causes build failures on arm with allyesconfig
>> and allmodconfig. Tested with next-20240410.

<snip>

> In both cases, the issue is that the toolchain requires runtime support to
> convert between `unsigned long long` and `double`, even when hardware FP is
> enabled. There was some past discussion about GCC inlining some of these
> conversions[1], but that did not get implemented.

Thank you for the explanation and the bugzilla reference. I added a
comment there mentioning that the problem came up again with this patch
series.

> The short-term fix would be to drop the `select ARCH_HAS_KERNEL_FPU_SUPPORT` for
> 32-bit arm until we can provide these runtime library functions.

Does this mean that patch 2 in this series:

[PATCH v4 02/15] ARM: Implement ARCH_HAS_KERNEL_FPU_SUPPORT

will be dropped?

--
Thiago
