Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2464FC5479D
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Jan 2023 15:22:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC7B510E86C;
	Fri,  6 Jan 2023 15:22:37 +0000 (UTC)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com
 [209.85.128.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83D0E10E049
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Jan 2023 15:18:01 +0000 (UTC)
Received: by mail-yw1-f182.google.com with SMTP id
 00721157ae682-4c186ff0506so26621087b3.6
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Jan 2023 07:18:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Alz05ZcNgoaQdFl2lti3Hdp2W/onZPDBRRL7a7nm+Vw=;
 b=Dk+/I3ytlHywCajvGXfCTLx4z8XKFvZhA3gHl7II9DQGORCfqFWVWcV9rRQ4huxMVR
 xWlvO1bWas2CzttXFNrNaNwZjtTVosR9AW6hDQPtnGVKIxUgtQYoGwZlpDDBExnhngsG
 4YWOPirk7O8nXw3eZ/SyQGr1j2AmSjL1wIcdlOIkpELIUSUAcL2E/ueP5HGufiVz+yG0
 FcxnpQie7UUU1IG6CVw0Ypj43JbYroBPteS8QSlFVp/7Jpw/B1MbS3ieQOOv1DcJT3l6
 34SjxQC+tH8EWa6r+gBi9m9nEBscv3ITMDCmlf6SUH3jeMbRjX7sUuFNFeyXv/PJ3GD9
 bhZw==
X-Gm-Message-State: AFqh2kquWzFV6Edl2dYrrT2H+nGiXrYHfEx1JnX6NVNpQUzH5VJz9OxL
 XO1OysSnOVPVNsash7r8s5T2feZu50wsBQ==
X-Google-Smtp-Source: AMrXdXsX7lVhxndHexjRO/faZKlj6tedFIRJ7Oa59pu2KJPW1zcMWVODIL8REuetR1jbOJUm7w3hWA==
X-Received: by 2002:a81:83c6:0:b0:480:c479:c501 with SMTP id
 t189-20020a8183c6000000b00480c479c501mr33190365ywf.15.1673018280320; 
 Fri, 06 Jan 2023 07:18:00 -0800 (PST)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com.
 [209.85.219.174]) by smtp.gmail.com with ESMTPSA id
 q5-20020a05620a0d8500b006eee3a09ff3sm651567qkl.69.2023.01.06.07.17.59
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Jan 2023 07:17:59 -0800 (PST)
Received: by mail-yb1-f174.google.com with SMTP id j206so2198836ybj.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Jan 2023 07:17:59 -0800 (PST)
X-Received: by 2002:a25:d84e:0:b0:7b4:6a33:d89f with SMTP id
 p75-20020a25d84e000000b007b46a33d89fmr557375ybg.543.1673018279290; Fri, 06
 Jan 2023 07:17:59 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wgf929uGOVpiWALPyC7pv_9KbwB2EAvQ3C4woshZZ5zqQ@mail.gmail.com>
 <20221227082932.798359-1-geert@linux-m68k.org>
 <alpine.DEB.2.22.394.2212270933530.311423@ramsan.of.borg>
 <c05bee5d-0d69-289b-fe4b-98f4cd31a4f5@physik.fu-berlin.de>
In-Reply-To: <c05bee5d-0d69-289b-fe4b-98f4cd31a4f5@physik.fu-berlin.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 6 Jan 2023 16:17:47 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXNJveXHeS=g-aHbnxtyACxq1wCeaTg8LbpYqJTCqk86g@mail.gmail.com>
Message-ID: <CAMuHMdXNJveXHeS=g-aHbnxtyACxq1wCeaTg8LbpYqJTCqk86g@mail.gmail.com>
Subject: Re: Build regressions/improvements in v6.2-rc1
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 06 Jan 2023 15:22:35 +0000
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
 kasan-dev@googlegroups.com, linux-f2fs-devel@lists.sourceforge.net,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi John,

On Fri, Jan 6, 2023 at 4:10 PM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On 12/27/22 09:35, Geert Uytterhoeven wrote:
> >    + /kisskb/src/include/linux/compiler_types.h: error: call to '__comp=
iletime_assert_262' declared with attribute error: Unsupported access size =
for {READ,WRITE}_ONCE().:  =3D> 358:45
> >    + /kisskb/src/include/linux/compiler_types.h: error: call to '__comp=
iletime_assert_263' declared with attribute error: Unsupported access size =
for {READ,WRITE}_ONCE().:  =3D> 358:45
> >
> > In function 'follow_pmd_mask',
> >      inlined from 'follow_pud_mask' at /kisskb/src/mm/gup.c:735:9,
> >      inlined from 'follow_p4d_mask' at /kisskb/src/mm/gup.c:752:9,
> >      inlined from 'follow_page_mask' at /kisskb/src/mm/gup.c:809:9:
> >
> > sh4-gcc11/sh-defconfig (G=C3=BCnter wondered if pmd_t should use union)
>
> I'm seeing this, too. Also for sh7785lcr_defconfig.
>
> > sh4-gcc11/sh-allmodconfig (ICE =3D internal compiler error)
>
> I'm not seeing this one, but I am getting this one instead:
>
> In file included from ./arch/sh/include/asm/hw_irq.h:6,
>                   from ./include/linux/irq.h:596,
>                   from ./include/asm-generic/hardirq.h:17,
>                   from ./arch/sh/include/asm/hardirq.h:9,
>                   from ./include/linux/hardirq.h:11,
>                   from ./include/linux/interrupt.h:11,
>                   from ./include/linux/serial_core.h:13,
>                   from ./include/linux/serial_sci.h:6,
>                   from arch/sh/kernel/cpu/sh2/setup-sh7619.c:11:
> ./include/linux/sh_intc.h:100:63: error: division 'sizeof (void *) / size=
of (void)' does not compute the number of array elements [-Werror=3Dsizeof-=
pointer-div]
>    100 | #define _INTC_ARRAY(a) a, __same_type(a, NULL) ? 0 : sizeof(a)/s=
izeof(*a)
>        |                                                               ^
> ./include/linux/sh_intc.h:105:31: note: in expansion of macro '_INTC_ARRA=
Y'
>    105 |         _INTC_ARRAY(vectors), _INTC_ARRAY(groups),      \
>        |                               ^~~~~~~~~~~

The easiest fix for the latter is to disable CONFIG_WERROR.
Unfortunately I don't know a simple solution to get rid of the warning.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
