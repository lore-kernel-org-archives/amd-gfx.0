Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08993C43334
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jul 2022 14:37:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50A1911325C;
	Thu, 14 Jul 2022 14:37:38 +0000 (UTC)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com
 [209.85.160.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7974410FD60
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jul 2022 13:56:59 +0000 (UTC)
Received: by mail-qt1-f180.google.com with SMTP id y3so1450685qtv.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jul 2022 06:56:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=VAkD3iZBMP+yVm34poCQsaJsrow+jcIzp7CvvJFKyqQ=;
 b=vsD0/tnhvLkKUI0Fo7gLwYIo2WZ4z89AUr/FaGwHKwnwVBicanrDfh3k8tKET9647a
 3b1oN23nQUhftctG8KPlDdIsSwFpDyzNNExSWCI5/9XQRjw8IG/oejk6GWQhLyIFVIQv
 7KeUse4k8uWYv3+htteHvzhck/EGUCyKSG083IdOHjzswOYgX5EgycyKPiNXnVOxGzxm
 UqgcY745CTwKJ0uqyJitbCK15gttBFThkIn1GhLwK196iSOtD0Mngp210jVGG3BSj6OM
 Zh2qcr2/g1d/aeYH1Q4g9nFFYwqnMSOAEbxEgb+CdPNRXXTl364CtP60UrVdrYfAptH9
 tLeQ==
X-Gm-Message-State: AJIora97HUXnW2TVK9SZGSMDKLMaK601xhE7QeIVSUYFx0/W2jW7ZInc
 /SleX5hPedTjS5r5NXxB3VInscRADH9v4w==
X-Google-Smtp-Source: AGRyM1v1LligUAwRzhYyxBHZiGUCRFduOLykJmUTaGMn/1jpHkhp/NLVTN9MXPfbRSZPzah5ADgnnA==
X-Received: by 2002:a05:622a:60e:b0:31d:3328:352a with SMTP id
 z14-20020a05622a060e00b0031d3328352amr8271294qta.184.1657807018285; 
 Thu, 14 Jul 2022 06:56:58 -0700 (PDT)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com.
 [209.85.128.182]) by smtp.gmail.com with ESMTPSA id
 n7-20020a05620a294700b006b5bc40a220sm1353714qkp.51.2022.07.14.06.56.57
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Jul 2022 06:56:57 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id
 00721157ae682-31bf3656517so17519447b3.12
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jul 2022 06:56:57 -0700 (PDT)
X-Received: by 2002:a81:af27:0:b0:31c:833f:eda5 with SMTP id
 n39-20020a81af27000000b0031c833feda5mr10022492ywh.358.1657807017454; Thu, 14
 Jul 2022 06:56:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgTmGaToVFdSdoFqT2sNkk7jg2rSWasUYv-tASUZ2j_0Q@mail.gmail.com>
 <20220713050724.GA2471738@roeck-us.net>
 <CAHk-=widUqghhXus_GCM9+FESa5vHqMb_pO3=0dGYH8C+yix2w@mail.gmail.com>
 <a804b76e-159f-dbc2-f8dc-62a58552e88d@roeck-us.net>
 <CADnq5_O6Tp2QPXyDCvpWuRXhDr6H1PM50Ow5YG2WeukqUd-GnQ@mail.gmail.com>
 <CAHk-=wj4+BSj2SPMRUr-TZ4Qg2o9HGOBWiJQE336YcF_U1sVNQ@mail.gmail.com>
 <CAMuHMdV9Pj9V-ZPpu=BMSkPt1uA_eCvU4+bxF8ZfHjteRk2CAg@mail.gmail.com>
 <2cac3590-3e9c-bdf3-4211-8559e581d44d@roeck-us.net>
In-Reply-To: <2cac3590-3e9c-bdf3-4211-8559e581d44d@roeck-us.net>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 14 Jul 2022 15:56:45 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUSMk5ghxi_AvqYOha7EPa7o+2pKCmreNoB9BfD=BEHRA@mail.gmail.com>
Message-ID: <CAMuHMdUSMk5ghxi_AvqYOha7EPa7o+2pKCmreNoB9BfD=BEHRA@mail.gmail.com>
Subject: Re: Linux 5.19-rc6
To: Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 14 Jul 2022 14:37:36 +0000
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
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>, Leo Li <sunpeng.li@amd.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Balbir Singh <bsingharora@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Paul Mackerras <paulus@ozlabs.org>, Alex Deucher <alexander.deucher@amd.com>,
 "Russell King \(Oracle\)" <rmk+kernel@armlinux.org.uk>,
 Michael Ellerman <mpe@ellerman.id.au>, Alex Deucher <alexdeucher@gmail.com>,
 Harry Wentland <harry.wentland@amd.com>, Daniel Axtens <dja@axtens.net>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi G=C3=BCnter,

On Thu, Jul 14, 2022 at 3:20 PM Guenter Roeck <linux@roeck-us.net> wrote:
> On 7/14/22 00:23, Geert Uytterhoeven wrote:
> > On Wed, Jul 13, 2022 at 11:51 PM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> >> On Wed, Jul 13, 2022 at 2:01 PM Alex Deucher <alexdeucher@gmail.com> w=
rote:
> >>> If you want to apply Guenter's patch original patch:
> >>> https://patchwork.freedesktop.org/patch/490184/
> >>> That's fine with me.
> >>
> >> Honestly, by this time I feel that it's too little, too late.
> >
> > [...]
> >
> >> So considering that the ppc people ignored this whole issue since the
> >> merge window, I think it's entirely unreasonable to then apply a
> >> ppc-specific patch for this at this time, when people literally asked
> >> "why is this needed", and there was no reply from the powerpc side.
> >
> > Oh, it's not just this one. The lists of build regressions between v5.1=
8
> > and v5.19-rc1 [1] resp. v5.19-rc6 [2] look surprisingly similar :-(
> >
> > [1] https://lore.kernel.org/all/20220606082201.2792145-1-geert@linux-m6=
8k.org
> > [2] https://lore.kernel.org/all/20220711064425.3084093-1-geert@linux-m6=
8k.org
> >
>
> How do you build your images ? I don't see many of the problems you repor=
t,
> even if I build the files with W=3D1. It is odd, since reports such as

I rely on the kisskb build service, and just parse their build logs.

> drivers/mfd/asic3.c:941:23: error: unused variable 'asic'
>
> are real, but I just don't see that. If I build that file, I see that
> it builds with -Wno-unused-but-set-variable, due to
>
> Makefile:KBUILD_CFLAGS +=3D $(call cc-disable-warning, unused-but-set-var=
iable)
>
> The override in scripts/Makefile.extrawarn doesn't seem to work even thou=
gh
> it adds "-Wunused-but-set-variable" to the compile flags. And if I remove
> "-Wno-unused-but-set-variable" from Makefile I still don't get the error/=
warning.
> Confused. I must be missing something, but what ?

That particular error is seen in the sh4-gcc11/sh-allmodconfig
build[3].  I assume it is fixed by now (see commit d684e0a52d36f893
("sh: convert nommu io{re,un}map() to static inline functions")).

[3] http://kisskb.ellerman.id.au/kisskb/buildresult/14767627/

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
