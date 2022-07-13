Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E816EC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jul 2022 19:42:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6CCD18B475;
	Wed, 13 Jul 2022 19:42:44 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07CAC98896
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jul 2022 19:37:10 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id ss3so15615592ejc.11
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jul 2022 12:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HoAbDIhN0wIvuBzIf7PXjfvUQchgB2xoehfek+ArK5Q=;
 b=Tlb8RLYE4eUtO3febqnZ3zs/xCAod6r+5u7XYX7K2st0NgU18fCImdG+9sO63aYPGA
 6/mDqerxkiMl9azFBWP8UVQmsxvzHu4Oy+RYuI1N8tYvZ4kNa/itnwE+60YnKDLuWp9E
 2lFLqb6uQwjJG29KsTfqJvqtE+QYMzxxaAHmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HoAbDIhN0wIvuBzIf7PXjfvUQchgB2xoehfek+ArK5Q=;
 b=M9vBCDC+XC17AuNKjPsfJV4CzJr6gSOVyAYPhvKHa8P23eY3TEN6Km1ZIoRzEducXv
 ZrGo7VPw+voO3q26rEDxq3xNcxEvKpWTgL2SfL08yGnAKbSgdy++Xvzl/KrrNd9GIsYA
 Ozy673kmsFQr/WtqvE037dVWaEK4P4Jxgr6qBrIqovsahFKsqz/aVVQqTgO+Heu0z6JP
 z8zdOc86ORapnP59QE8xKT7j/yXTNyjr6EzYOl723xLxS4F4r2vb3nihb1aJbb66t0G8
 u0OANEn93aOOJ8cPeB2a+OdutwLZdL4r88Thh/pjSyAxB/L6j7ZJL6pqpbm4nP+k5KvL
 1eSQ==
X-Gm-Message-State: AJIora9JC7p9y15dcVBuITfU8IFDLXLk7jdtKRZ8KKunKxgnJ2Niy4dd
 fKHpin3lNtaLJztS1tLPqm7qh2sefIrqvP1LZe8=
X-Google-Smtp-Source: AGRyM1vwoPvvfQHrsxfvlzkh+tJLkg7TH+/LKuTtLenNbd1HvK89CFzTLQw1+p97bhRxfIYGMBE6/Q==
X-Received: by 2002:a17:906:6146:b0:722:f8c4:ec9b with SMTP id
 p6-20020a170906614600b00722f8c4ec9bmr5165359ejl.708.1657741029078; 
 Wed, 13 Jul 2022 12:37:09 -0700 (PDT)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com.
 [209.85.221.46]) by smtp.gmail.com with ESMTPSA id
 f17-20020a17090631d100b0072b6d93b9afsm2881976ejf.210.2022.07.13.12.37.06
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Jul 2022 12:37:07 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id z12so16912239wrq.7
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jul 2022 12:37:06 -0700 (PDT)
X-Received: by 2002:a05:6000:1f8c:b0:21d:7e98:51ba with SMTP id
 bw12-20020a0560001f8c00b0021d7e9851bamr4621239wrb.442.1657741026295; Wed, 13
 Jul 2022 12:37:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgTmGaToVFdSdoFqT2sNkk7jg2rSWasUYv-tASUZ2j_0Q@mail.gmail.com>
 <20220713050724.GA2471738@roeck-us.net>
In-Reply-To: <20220713050724.GA2471738@roeck-us.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 13 Jul 2022 12:36:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=widUqghhXus_GCM9+FESa5vHqMb_pO3=0dGYH8C+yix2w@mail.gmail.com>
Message-ID: <CAHk-=widUqghhXus_GCM9+FESa5vHqMb_pO3=0dGYH8C+yix2w@mail.gmail.com>
Subject: Re: Linux 5.19-rc6
To: Guenter Roeck <linux@roeck-us.net>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
 Balbir Singh <bsingharora@gmail.com>, Daniel Axtens <dja@axtens.net>, 
 Paul Mackerras <paulus@ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 Kefeng Wang <wangkefeng.wang@huawei.com>, 
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 13 Jul 2022 19:42:44 +0000
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
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jul 12, 2022 at 10:07 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> Same problems as every week.
>
> Building powerpc:allmodconfig ... failed

Ok, this has been going on since -rc1, which is much too long.

From your patch submission that that was rejected:

> The problem was introduced with commit 41b7a347bf14 ("powerpc: Book3S
> 64-bit outline-only KASAN support") which adds support for KASAN. This
> commit in turn enables DRM_AMD_DC_DCN because KCOV_INSTRUMENT_ALL and
> KCOV_ENABLE_COMPARISONS are no longer enabled. As result, new files are
> compiled which lack the selection of hard-float.

And considering that neither the ppc people nor the drm people seem
interested in fixing this, and it doesn't revert cleanly I think the
sane solution seems to be to just remove PPC64 support for DRM_AMD_DC
entirely.

IOW, does something like this (obviously nor a proper patch, but you
get the idea) fix the ppc build for you?

  @@ -6,7 +6,7 @@ config DRM_AMD_DC
          bool "AMD DC - Enable new display engine"
          default y
          select SND_HDA_COMPONENT if SND_HDA_CORE
  -       select DRM_AMD_DC_DCN if (X86 || PPC64) &&
!(KCOV_INSTRUMENT_ALL && KCOV_ENABLE_COMPARISONS)
  +       select DRM_AMD_DC_DCN if X86 && !(KCOV_INSTRUMENT_ALL &&
KCOV_ENABLE_COMPARISONS)
          help
            Choose this option if you want to use the new display engine
            support for AMDGPU. This adds required support for Vega and

> OF: amba_device_add() failed (-19) for /amba/smc@10100000
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 1 at lib/refcount.c:28 of_platform_bus_create+0x33c/0x3dc
> refcount_t: underflow; use-after-free.

This too has been going on since -rc1, but it's not obvious what caused it.

At a guess, looking around the amba changes, I'm assuming it's

  7719a68b2fa4 ("ARM: 9192/1: amba: fix memory leak in amba_device_try_add()")

Does reverting that commit make it go away?

                    Linus
