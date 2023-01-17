Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 533BBC6379F
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jan 2023 17:12:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C79B510E590;
	Tue, 17 Jan 2023 17:12:14 +0000 (UTC)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com
 [209.85.160.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E3BB10E0CE
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jan 2023 17:02:04 +0000 (UTC)
Received: by mail-qt1-f181.google.com with SMTP id x5so4084721qti.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jan 2023 09:02:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AG07rkufzJudbSBlfxWXzYs9DtgP7S33LaaSRTlg/Ec=;
 b=kKlZIEl8YsRSesRSIaqqqCaSP5HzPsDhmwcMWlladNWkG705qTU6qHqQ9a6k05p5GP
 KtwNWX7YG+9lcznOG+lVeIBdQJJDj75t+F74QD5v47cgLJEZ6xZoeg9usmB1sZtQXZwL
 XJniA0Ys6ciR99T6rbceQBQ2WRYM/yMrS2h8EsffaWy8nFlB7TABIcE7QBDvZ/k6BSbl
 H4CEMu2e9O6i8uD50AvmTPL+lzGSRrLitf72swn6UP+mNugYbAM29PB1lJwcJOa7SAQQ
 Dt80hUinNMNXPsQIRBU8uo2tQ83VVX4Yp6QJKli6hNAFteL45mJi3FaLokg2tDLlq+T0
 EKHQ==
X-Gm-Message-State: AFqh2koZSYjPhQ26uT1xabyPOPbJ7F04SJLCxX21YVudwzk3IscZaCqg
 CS5iVySf8rKd2fxefROsDZ+MKT+OtUg99Q==
X-Google-Smtp-Source: AMrXdXuQdAMx4THfgGJZTlaMYumWX/GefiWAz/eHrvYinWiBdCIYMBubvog2qRH0SGP00XwAnkafSw==
X-Received: by 2002:a05:622a:4a83:b0:3ab:ceb9:170 with SMTP id
 fw3-20020a05622a4a8300b003abceb90170mr5104829qtb.33.1673974923217; 
 Tue, 17 Jan 2023 09:02:03 -0800 (PST)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com.
 [209.85.219.178]) by smtp.gmail.com with ESMTPSA id
 r3-20020ac84243000000b003a5430ee366sm16125170qtm.60.2023.01.17.09.02.02
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Jan 2023 09:02:03 -0800 (PST)
Received: by mail-yb1-f178.google.com with SMTP id v19so28954484ybv.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jan 2023 09:02:02 -0800 (PST)
X-Received: by 2002:a25:d88c:0:b0:77a:b5f3:d0ac with SMTP id
 p134-20020a25d88c000000b0077ab5f3d0acmr418050ybg.202.1673974922451; Tue, 17
 Jan 2023 09:02:02 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wgf929uGOVpiWALPyC7pv_9KbwB2EAvQ3C4woshZZ5zqQ@mail.gmail.com>
 <20221227082932.798359-1-geert@linux-m68k.org>
 <alpine.DEB.2.22.394.2212270933530.311423@ramsan.of.borg>
 <c05bee5d-0d69-289b-fe4b-98f4cd31a4f5@physik.fu-berlin.de>
 <CAMuHMdXNJveXHeS=g-aHbnxtyACxq1wCeaTg8LbpYqJTCqk86g@mail.gmail.com>
 <3800eaa8-a4da-b2f0-da31-6627176cb92e@physik.fu-berlin.de>
In-Reply-To: <3800eaa8-a4da-b2f0-da31-6627176cb92e@physik.fu-berlin.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 17 Jan 2023 18:01:51 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWbBRkhecrqcir92TgZnffMe8ku2t7PcVLqA6e6F-j=iw@mail.gmail.com>
Message-ID: <CAMuHMdWbBRkhecrqcir92TgZnffMe8ku2t7PcVLqA6e6F-j=iw@mail.gmail.com>
Subject: Re: Calculating array sizes in C - was: Re: Build
 regressions/improvements in v6.2-rc1
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 17 Jan 2023 17:12:10 +0000
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
Cc: linux-xtensa@linux-xtensa.org, linux-sh@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-mips@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kasan-dev@googlegroups.com,
 Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>,
 linux-f2fs-devel@lists.sourceforge.net, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Adrian,

On Tue, Jan 17, 2023 at 5:42 PM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On 1/6/23 16:17, Geert Uytterhoeven wrote:
> >> I'm not seeing this one, but I am getting this one instead:
> >>
> >> In file included from ./arch/sh/include/asm/hw_irq.h:6,
> >>                    from ./include/linux/irq.h:596,
> >>                    from ./include/asm-generic/hardirq.h:17,
> >>                    from ./arch/sh/include/asm/hardirq.h:9,
> >>                    from ./include/linux/hardirq.h:11,
> >>                    from ./include/linux/interrupt.h:11,
> >>                    from ./include/linux/serial_core.h:13,
> >>                    from ./include/linux/serial_sci.h:6,
> >>                    from arch/sh/kernel/cpu/sh2/setup-sh7619.c:11:
> >> ./include/linux/sh_intc.h:100:63: error: division 'sizeof (void *) / sizeof (void)' does not compute the number of array elements [-Werror=sizeof-pointer-div]
> >>     100 | #define _INTC_ARRAY(a) a, __same_type(a, NULL) ? 0 : sizeof(a)/sizeof(*a)
> >>         |                                                               ^
> >> ./include/linux/sh_intc.h:105:31: note: in expansion of macro '_INTC_ARRAY'
> >>     105 |         _INTC_ARRAY(vectors), _INTC_ARRAY(groups),      \
> >>         |                               ^~~~~~~~~~~
> >
> > The easiest fix for the latter is to disable CONFIG_WERROR.
> > Unfortunately I don't know a simple solution to get rid of the warning.
>
> I did some research and it seems that what the macro _INT_ARRAY() does with "sizeof(a)/sizeof(*a)"
> is a commonly used way to calculate array sizes and the kernel has even its own macro for that
> called ARRAY_SIZE() which Linus asks people to use here [1].
>
> So, I replaced _INTC_ARRAY() with ARRAY_SIZE() (see below), however the kernel's own ARRAY_SIZE()
> macro triggers the same compiler warning. I'm CC'ing Michael Karcher who has more knowledge on
> writing proper C code than me and maybe an idea how to fix this warning.
>
> Thanks,
> Adrian
>
> > [1] https://lkml.org/lkml/2015/9/3/428
>
> diff --git a/include/linux/sh_intc.h b/include/linux/sh_intc.h
> index c255273b0281..07a187686a84 100644
> --- a/include/linux/sh_intc.h
> +++ b/include/linux/sh_intc.h
> @@ -97,14 +97,12 @@ struct intc_hw_desc {
>          unsigned int nr_subgroups;
>   };
>
> -#define _INTC_ARRAY(a) a, __same_type(a, NULL) ? 0 : sizeof(a)/sizeof(*a)
> -
>   #define INTC_HW_DESC(vectors, groups, mask_regs,       \
>                       prio_regs, sense_regs, ack_regs)   \
>   {                                                      \
> -       _INTC_ARRAY(vectors), _INTC_ARRAY(groups),      \
> -       _INTC_ARRAY(mask_regs), _INTC_ARRAY(prio_regs), \
> -       _INTC_ARRAY(sense_regs), _INTC_ARRAY(ack_regs), \
> +       ARRAY_SIZE(vectors), ARRAY_SIZE(groups),        \
> +       ARRAY_SIZE(mask_regs), ARRAY_SIZE(prio_regs),   \
> +       ARRAY_SIZE(sense_regs), ARRAY_SIZE(ack_regs),   \
>   }

The issue is that some of the parameters are not arrays, but
NULL. E.g.:

arch/sh/kernel/cpu/sh2/setup-sh7619.c:static
DECLARE_INTC_DESC(intc_desc, "sh7619", vectors, NULL,
arch/sh/kernel/cpu/sh2/setup-sh7619.c-                   NULL,
prio_registers, NULL);
--

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
