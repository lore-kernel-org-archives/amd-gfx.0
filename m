Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92470C43334
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jul 2022 12:15:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B0F810F9F4;
	Thu, 14 Jul 2022 12:15:24 +0000 (UTC)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com
 [209.85.222.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4875910FCA5
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jul 2022 07:23:28 +0000 (UTC)
Received: by mail-qk1-f180.google.com with SMTP id o26so645402qkl.6
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jul 2022 00:23:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RmlXtnA3cC4Ik7QOf/RIurG9dJCZvwzcFfVviIGb20U=;
 b=uJS5JataEzboXRALBRG9cld2kdDDQrCS/sbS5smbY6Bywddvt0GEqXwZJWrHirB+OA
 pmEJzFwvhEnVfYr3usOsWPpX6DX/u8CNCp7jk4pu/KlZOY+3y2PnOeWA7iVKREBf9z7B
 riBtaQz4kwe7zZmBUeZbSKbBV9ztMM+eXTxeRnw8iWm0GwrMW3ORd2lIfrdXW0y3OWGV
 ZASpCr3iqWMkfZeXiCaQJb7lmlkAtIrGALclrxxI/X4E621HuJIiOG3DOS9fRrhticiy
 w11dqELpgH4p/z6boCBwOPw3yQP5DCuH6mWYEa6H8sZ++ZrYP9CcCeRFcKQulTc0ddKg
 u6Yg==
X-Gm-Message-State: AJIora9QFl4Ya51piQQ7Msl5FXL3Kmc4/TD1/qX8swbQGpi6mXi5bML2
 77k4QpjBkFCjfJO9eBw/0d0xnbjyCglGyQ==
X-Google-Smtp-Source: AGRyM1tJud3QXNPCCWAqZ0omMDetzqeFo3gerK0MXuUtN4P7cF0uCmAwvS6D/+JTpEEQmS3HiBXswQ==
X-Received: by 2002:a05:620a:1539:b0:6b5:5792:c3fd with SMTP id
 n25-20020a05620a153900b006b55792c3fdmr5002718qkk.669.1657783407105; 
 Thu, 14 Jul 2022 00:23:27 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com.
 [209.85.219.182]) by smtp.gmail.com with ESMTPSA id
 p7-20020a05620a056700b006a6bb044740sm788730qkp.66.2022.07.14.00.23.26
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Jul 2022 00:23:26 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id r3so1772999ybr.6
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jul 2022 00:23:26 -0700 (PDT)
X-Received: by 2002:a5b:6c1:0:b0:669:a7c3:4c33 with SMTP id
 r1-20020a5b06c1000000b00669a7c34c33mr7180560ybq.543.1657783405770; Thu, 14
 Jul 2022 00:23:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgTmGaToVFdSdoFqT2sNkk7jg2rSWasUYv-tASUZ2j_0Q@mail.gmail.com>
 <20220713050724.GA2471738@roeck-us.net>
 <CAHk-=widUqghhXus_GCM9+FESa5vHqMb_pO3=0dGYH8C+yix2w@mail.gmail.com>
 <a804b76e-159f-dbc2-f8dc-62a58552e88d@roeck-us.net>
 <CADnq5_O6Tp2QPXyDCvpWuRXhDr6H1PM50Ow5YG2WeukqUd-GnQ@mail.gmail.com>
 <CAHk-=wj4+BSj2SPMRUr-TZ4Qg2o9HGOBWiJQE336YcF_U1sVNQ@mail.gmail.com>
In-Reply-To: <CAHk-=wj4+BSj2SPMRUr-TZ4Qg2o9HGOBWiJQE336YcF_U1sVNQ@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 14 Jul 2022 09:23:13 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV9Pj9V-ZPpu=BMSkPt1uA_eCvU4+bxF8ZfHjteRk2CAg@mail.gmail.com>
Message-ID: <CAMuHMdV9Pj9V-ZPpu=BMSkPt1uA_eCvU4+bxF8ZfHjteRk2CAg@mail.gmail.com>
Subject: Re: Linux 5.19-rc6
To: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 14 Jul 2022 12:15:21 +0000
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
 Michael Ellerman <mpe@ellerman.id.au>, Balbir Singh <bsingharora@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Paul Mackerras <paulus@ozlabs.org>, Alex Deucher <alexander.deucher@amd.com>,
 "Russell King \(Oracle\)" <rmk+kernel@armlinux.org.uk>,
 Alex Deucher <alexdeucher@gmail.com>, Harry Wentland <harry.wentland@amd.com>,
 Guenter Roeck <linux@roeck-us.net>, Daniel Axtens <dja@axtens.net>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Linus,

On Wed, Jul 13, 2022 at 11:51 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Wed, Jul 13, 2022 at 2:01 PM Alex Deucher <alexdeucher@gmail.com> wrote:
> > If you want to apply Guenter's patch original patch:
> > https://patchwork.freedesktop.org/patch/490184/
> > That's fine with me.
>
> Honestly, by this time I feel that it's too little, too late.

[...]

> So considering that the ppc people ignored this whole issue since the
> merge window, I think it's entirely unreasonable to then apply a
> ppc-specific patch for this at this time, when people literally asked
> "why is this needed", and there was no reply from the powerpc side.

Oh, it's not just this one. The lists of build regressions between v5.18
and v5.19-rc1 [1] resp. v5.19-rc6 [2] look surprisingly similar :-(

[1] https://lore.kernel.org/all/20220606082201.2792145-1-geert@linux-m68k.org
[2] https://lore.kernel.org/all/20220711064425.3084093-1-geert@linux-m68k.org

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
