Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8325DC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jun 2022 14:13:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 295AE10FB11;
	Wed, 15 Jun 2022 14:13:15 +0000 (UTC)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCF7E10FB8D
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jun 2022 14:13:14 +0000 (UTC)
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-f2a4c51c45so16633173fac.9
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jun 2022 07:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+J4ufDswvdE1cA+cj+XiCNgvbQcH4U6zak8BXXOvWsk=;
 b=pewXG/albqOb5HAuc5sSZG85sS56EbEittR0vE5CVh2GoCmhh3l1lc0dwQCjefpTuk
 BL0Bpoj2FVl7WACd8uBThe1IhIqweZRkALyDvOgwtPy7SIhrGVuXuKm1ftkUDezQttEC
 /XUgFHhffSOz5DimAAT5EersxUT4FgQzSgavhszYJz+2YR2ra8jy5WHsEt4CJgcWAX6Z
 Lfx3NxC8r/csFYNnX+qD/3FJeRb4tn4QX9DV2RuWrh9oNIEosCM4qkLuNTyxDWm5Kyzq
 H5FaS6SXBuuS8MjrsWHNyfJywJyzpm65DowdX5DmUuPIAP6tLCc04KLBLXlIwmJTMzjY
 hEzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+J4ufDswvdE1cA+cj+XiCNgvbQcH4U6zak8BXXOvWsk=;
 b=We5zfuEM8msoiU5Tg0dgKoxfvFx2EUkWlTuca5wFC5N+d4wHyat1lAN+MRmyLAJV7v
 zIjOIWDTjtPpC9NBFDV4A89Tt6wBT2wcEXml47ZUSHSJYH3ZdZvqfupcfLEViHLwOJlb
 zYxr74RFuC5E71uNaHpWou7ltlGjwDNE76uJwFIknhHeOw9/i5mxMaw5sVCigImBToji
 ivwHRX5NbE651+xU1lEQyH/dNzJiK6e09L1LaaZqXuyV4PaozXmMs7rs6HZqUfB7DlSK
 NELi0H0PzSczgZ4kV06BPMXCTRx2YrcX8xi+IygZtkEhAyxYi8h663tY11jl6ujtVcM8
 5JQg==
X-Gm-Message-State: AJIora/33GI74ysUXP9rGTO9AfvR/AieoHn+l0lo4KTfBJiLjAPHABNb
 +M/H8UPSx3Ip1gNZMO2qLdnO8pZhhtlXphDGKW8=
X-Google-Smtp-Source: AGRyM1sBv9wVMhiHap35Si/Yry98PnpYASrlrafmeY2+7Qk1vGe+TK2pPeRyCUbfz+qnGl0KjhcWDvY9sy+yQ7iUVDY=
X-Received: by 2002:a05:6870:538b:b0:101:17f2:d6e with SMTP id
 h11-20020a056870538b00b0010117f20d6emr5454778oan.200.1655302394031; Wed, 15
 Jun 2022 07:13:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220613200112.3377638-1-Rodrigo.Siqueira@amd.com>
 <20220613200112.3377638-2-Rodrigo.Siqueira@amd.com>
 <pp_VMylAJoi-vp3VAJIjkeIfC89ncoHCCBFR_7ook2cjR9uC7bgBWcsjaFGNPFPgRMJHkwli2RNeXP0L32NQ8-Qvwf1IbTSyG8U5KNhTdJ8=@emersion.fr>
 <CADnq5_Pp+xSJO1mR24PQmm5bHhjY1Q-wC8GG97pr6axvrkmZeQ@mail.gmail.com>
 <wXTO8YYCjZe9USXO-9_zGZeVtSuFwgspCcHzjSZk9xdRK3Q1JisYUroSqU4GUwhL4At_N8UZifT5EAQJMBu5ADnetH8zlrOJNrG0NKqv-4E=@emersion.fr>
In-Reply-To: <wXTO8YYCjZe9USXO-9_zGZeVtSuFwgspCcHzjSZk9xdRK3Q1JisYUroSqU4GUwhL4At_N8UZifT5EAQJMBu5ADnetH8zlrOJNrG0NKqv-4E=@emersion.fr>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 15 Jun 2022 10:13:02 -0400
Message-ID: <CADnq5_N_TJPy+UumtFkCn7GOVZjFuk2KxQPcFdJ8uVayC0EBqQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] Documentation/gpu: Add info table for ASICs
To: Simon Ser <contact@emersion.fr>
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
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
 Alex Hung <alex.hung@amd.com>, Mark Yacoub <markyacoub@chromium.org>,
 Tales Lelo da Aparecida <tales.aparecida@gmail.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Melissa Wen <mwen@igalia.com>,
 Leo Li <sunpeng.li@amd.com>, Hersen Wu <hersenxs.wu@amd.com>,
 =?UTF-8?B?TWHDrXJhIENhbmFs?= <maira.canal@usp.br>,
 Sean Paul <seanpaul@chromium.org>, Isabella Basso <isabbasso@riseup.net>,
 andrealmeid@riseup.net, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 Pierre-Loup <pgriffais@valvesoftware.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jun 15, 2022 at 3:47 AM Simon Ser <contact@emersion.fr> wrote:
>
> On Tuesday, June 14th, 2022 at 20:30, Alex Deucher <alexdeucher@gmail.com> wrote:
>
> > On Tue, Jun 14, 2022 at 2:16 PM Simon Ser contact@emersion.fr wrote:
> >
> > > On Monday, June 13th, 2022 at 22:01, Rodrigo Siqueira Rodrigo.Siqueira@amd.com wrote:
> > >
> > > > Amdgpu driver is used in an extensive range of devices, and each ASIC
> > > > has some specific configuration. As a result of this variety, sometimes
> > > > it is hard to identify the correct block that might cause the issue.
> > > > This commit expands the amdgpu kernel-doc to alleviate this issue by
> > > > introducing one ASIC table that describes dGPU and another one that
> > > > shares the APU info.
> > >
> > > Nice!
> > >
> > > Are there plans to keep this list up-to-date?
> > >
> > > FWIW, my go-to reference tables are 1, updated by Alex.
> > >
> > > Would it make sense to add a "GFX Core" column?
> >
> > That's what the GC column is for.
>
> Oh! Does this stand for "GFX Core", or for "Graphics and Compute"? The
> glossary documents GC as the latter. If there is a name conflict, maybe
> we can keep using the long name in the table, or document what "GC"
> means in a sentence.

Both?  The hardware block is called GC, but I think different teams
expand it to Graphics Core (as in GCN) or Graphics and Compute.  Same
hardware block either way.  I guess we should include both in the
glossary.

Alex
