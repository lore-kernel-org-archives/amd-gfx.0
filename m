Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8CC9C433EF
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Jul 2022 14:36:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87D3D10EB56;
	Sat, 16 Jul 2022 14:35:21 +0000 (UTC)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com
 [209.85.219.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1E1211ACEC
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jul 2022 07:26:34 +0000 (UTC)
Received: by mail-qv1-f47.google.com with SMTP id p14so3160248qvo.9
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jul 2022 00:26:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WlQWMuQP9i7JA/10N1xXkOOHrioXOIiFbLtTV9MnWc8=;
 b=ynEDlSGw/12qA/LNaVQAqgzF1Wr14S9IT8e8LqneJWu9yvdvJG+Xp118hyoboP1VEj
 dqUdW75J+XrG5AVEDod+oEqBDUF1KHvcXkA+thhDuo+qxOqqkEbmtwvYBSgA2NmzULrs
 Bi9DETiEWGPnFseTy/3T9oO4Tujqtn6waOXf1SoU2J/bkmJh8RA8ujubCDsm6w6Cj2ie
 ihFEMK3EA4lKxczLbGwxxlP8WIamHAg8C3CO73zFffCzifzuYVyQliirc8ojC7eaFTEK
 SFbB1vU4Fr1aCnoTlMaYAGP7ZIY/Tuf54SKYCvq2A5249sZ7R4VKf38NVUQ1TEDrjyOP
 UDOA==
X-Gm-Message-State: AJIora8n7/beE3vcwOTgh2Y6L0mLgro7OcvxmgI8uDjy8kJItiSR5e4P
 Uf3ERE7UZaNrNM0nR2oLF//8nqS9X5gCuA==
X-Google-Smtp-Source: AGRyM1uRTMHj9mflurMOu+FEPEl1AAv2N+XWmRFF8UQxOFzZAGRGXVUizpZwBueK9rPtaIiq6rdjgg==
X-Received: by 2002:a05:6214:20e9:b0:472:f2e6:dd62 with SMTP id
 9-20020a05621420e900b00472f2e6dd62mr10958194qvk.67.1657869993588; 
 Fri, 15 Jul 2022 00:26:33 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com.
 [209.85.128.172]) by smtp.gmail.com with ESMTPSA id
 k7-20020a05620a414700b006b5ccec4121sm1779021qko.5.2022.07.15.00.26.32
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Jul 2022 00:26:32 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id
 00721157ae682-31c8bb90d09so39254927b3.8
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jul 2022 00:26:32 -0700 (PDT)
X-Received: by 2002:a81:9209:0:b0:31c:b1b7:b063 with SMTP id
 j9-20020a819209000000b0031cb1b7b063mr14363430ywg.383.1657869991832; Fri, 15
 Jul 2022 00:26:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgTmGaToVFdSdoFqT2sNkk7jg2rSWasUYv-tASUZ2j_0Q@mail.gmail.com>
 <20220713050724.GA2471738@roeck-us.net>
 <CAHk-=widUqghhXus_GCM9+FESa5vHqMb_pO3=0dGYH8C+yix2w@mail.gmail.com>
 <a804b76e-159f-dbc2-f8dc-62a58552e88d@roeck-us.net>
 <CADnq5_O6Tp2QPXyDCvpWuRXhDr6H1PM50Ow5YG2WeukqUd-GnQ@mail.gmail.com>
 <CAHk-=wj4+BSj2SPMRUr-TZ4Qg2o9HGOBWiJQE336YcF_U1sVNQ@mail.gmail.com>
 <CAMuHMdV9Pj9V-ZPpu=BMSkPt1uA_eCvU4+bxF8ZfHjteRk2CAg@mail.gmail.com>
 <CAHk-=wgnmaTVigBc02tjqgcZaNJiYz8Xw77P+ERAXhcYjkwd=Q@mail.gmail.com>
 <6d5ac61b-b490-4f9d-6521-a4b7477d6fd2@roeck-us.net>
In-Reply-To: <6d5ac61b-b490-4f9d-6521-a4b7477d6fd2@roeck-us.net>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 15 Jul 2022 09:26:18 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX4Srd=WTGvtGoWhatEb8No7WUhrAYEmjX2+E11PnMVeg@mail.gmail.com>
Message-ID: <CAMuHMdX4Srd=WTGvtGoWhatEb8No7WUhrAYEmjX2+E11PnMVeg@mail.gmail.com>
Subject: Re: Linux 5.19-rc6
To: Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 15 Jul 2022 13:56:14 +0000
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

On Thu, Jul 14, 2022 at 7:24 PM Guenter Roeck <linux@roeck-us.net> wrote:
> On 7/14/22 09:48, Linus Torvalds wrote:
> > And some look positively strange. Like that
> >
> >    drivers/mfd/asic3.c: error: unused variable 'asic'
> > [-Werror=unused-variable]:  => 941:23
> >
> > which is clearly used three lines later by
> >
> >          iounmap(asic->tmio_cnf);
> >
> > and I can't find any case of 'iounmap()' having been defined to an
> > empty macro or anything like that to explain it. The error in
> > drivers/tty/serial/sh-sci.c looks to be exactly the same issue, just
> > with ioremap() instead of iounmap().
> >
> > It would be good to have some way to find which build/architecture it
> > is, because right now it just looks bogus.
> >
> > Do you perhaps use some broken compiler that complains when the empty
> > inline functions don't use their arguments? Because that's what those
> > ioremap/iounmap() ones look like to me, but there might be some
> > magical architecture / config that has issues that aren't obvious.
> >
> > IOW, I'd love to get those fixed, but I would also want a little bit more info.
> >
> Geert gave the necessary hint - it looks like sh-nommu used defines
> for iomap() and iounmap(), which made the variable unused. According
> to Geert that was fixed a couple of days ago.

Yes, post-rc6 should be fine, as the fix went in... for the third time.
Combine people that keep on switching back to macros without reading
a file's history with unresponsive maintainers...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
