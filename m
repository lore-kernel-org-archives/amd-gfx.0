Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACE2DC3DA78
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jan 2023 20:25:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E164910E5CB;
	Tue, 17 Jan 2023 20:25:30 +0000 (UTC)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com
 [209.85.160.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AE8110E33D
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jan 2023 20:06:13 +0000 (UTC)
Received: by mail-qt1-f173.google.com with SMTP id r15so4950703qtx.6
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jan 2023 12:06:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3xoeiV+nYOsKZ3P5r1QIbmJ251MgYmk7NsIx6imHg00=;
 b=gPT6hfFioQHk9DIsSTrabRoUDDraOFTG2Nt4SoCUhPyd0vIMCxlYJuGnrPVqLVJfAp
 6U4Urgj4ZEpg+fXAOutzQpmwGEmlAzwxKsjhqw+iRliB7MPF/PHC30JFXnUS431p0ikQ
 yudJCGubWnpDAqBmEUUFMwwefSWsp/L5ggEdTNmsJ1dy9B4DEEskELvyTOOCFOdbsgxj
 trZfpri/DJuCC7EQLrqg/hqTNjq7+jVEDKxAC832Z/4EvOgFcdydSgB/7xg9OYkybjr2
 L+T8VxuiUc5lEdgQ0duQlX3xrsUmfQmrwNbXrMIqJgGts2ZSV7vNlDGFl14JTmgcyA1T
 p0wg==
X-Gm-Message-State: AFqh2kqF7OmWtWAYoCLaCiCUtFiwUrj9RO5+yEUpyakWI75X2zPqTv5j
 /Ao3CTwWv9RIoe/5SYwC0tUkF1yI6cO4fQ==
X-Google-Smtp-Source: AMrXdXuLF6nIZ5WaW9Iot2STa/ZLTH2bJjBt+mgfCZ2KywCMQkV17DNrtCB/C3XTpT+iGJMpKCzhTg==
X-Received: by 2002:ac8:4443:0:b0:3b6:2ec0:69fe with SMTP id
 m3-20020ac84443000000b003b62ec069femr5968653qtn.40.1673985971902; 
 Tue, 17 Jan 2023 12:06:11 -0800 (PST)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com.
 [209.85.219.173]) by smtp.gmail.com with ESMTPSA id
 t13-20020ac8760d000000b003b63187dbe1sm3329582qtq.27.2023.01.17.12.06.10
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Jan 2023 12:06:11 -0800 (PST)
Received: by mail-yb1-f173.google.com with SMTP id p188so35525005yba.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jan 2023 12:06:10 -0800 (PST)
X-Received: by 2002:a25:9012:0:b0:7b8:a0b8:f7ec with SMTP id
 s18-20020a259012000000b007b8a0b8f7ecmr700718ybl.36.1673985970579; Tue, 17 Jan
 2023 12:06:10 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wgf929uGOVpiWALPyC7pv_9KbwB2EAvQ3C4woshZZ5zqQ@mail.gmail.com>
 <20221227082932.798359-1-geert@linux-m68k.org>
 <alpine.DEB.2.22.394.2212270933530.311423@ramsan.of.borg>
 <c05bee5d-0d69-289b-fe4b-98f4cd31a4f5@physik.fu-berlin.de>
 <CAMuHMdXNJveXHeS=g-aHbnxtyACxq1wCeaTg8LbpYqJTCqk86g@mail.gmail.com>
 <3800eaa8-a4da-b2f0-da31-6627176cb92e@physik.fu-berlin.de>
 <CAMuHMdWbBRkhecrqcir92TgZnffMe8ku2t7PcVLqA6e6F-j=iw@mail.gmail.com>
 <429140e0-72fe-c91c-53bc-124d33ab5ffa@physik.fu-berlin.de>
In-Reply-To: <429140e0-72fe-c91c-53bc-124d33ab5ffa@physik.fu-berlin.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 17 Jan 2023 21:05:58 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWpHSsAB3WosyCVgS6+t4pU35Xfj3tjmdCDoyS2QkS7iw@mail.gmail.com>
Message-ID: <CAMuHMdWpHSsAB3WosyCVgS6+t4pU35Xfj3tjmdCDoyS2QkS7iw@mail.gmail.com>
Subject: Re: Calculating array sizes in C - was: Re: Build
 regressions/improvements in v6.2-rc1
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 17 Jan 2023 20:25:29 +0000
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
Cc: linux-xtensa@linux-xtensa.org, Arnd Bergmann <arnd@arndb.de>,
 linux-sh@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-mips@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
 Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>,
 linux-f2fs-devel@lists.sourceforge.net, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Adrian,

On Tue, Jan 17, 2023 at 6:06 PM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On 1/17/23 18:01, Geert Uytterhoeven wrote:
> > The issue is that some of the parameters are not arrays, but
> > NULL. E.g.:
> >
> > arch/sh/kernel/cpu/sh2/setup-sh7619.c:static
> > DECLARE_INTC_DESC(intc_desc, "sh7619", vectors, NULL,
> > arch/sh/kernel/cpu/sh2/setup-sh7619.c-                   NULL,
> > prio_registers, NULL);
>
> Isn't this supposed to be caught by this check:
>
>         a, __same_type(a, NULL)
>
> ?

Yeah, but gcc thinks it is smarter than us...
Probably it drops the test, assuming UB cannot happen.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
