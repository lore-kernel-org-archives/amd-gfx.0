Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C22E0C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jun 2022 21:37:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 599B4112371;
	Thu, 16 Jun 2022 21:37:13 +0000 (UTC)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B81A51120EE
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jun 2022 21:37:11 +0000 (UTC)
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-317741c86fdso24211427b3.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jun 2022 14:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6sNSjILttauQK6aE+vyvhxax1qpTJP50cU1WYTsi1BA=;
 b=QHBWQZ2qHFC/068nNHMxpLpMVDFnFmduIFcssX54XtSho84f8GSL62qObdg2mWggyv
 OJN5IBfBpljkoxbHgxpk4b9fMjJYkXUzt9mBMJzueR3cqQKgUV7xKfttq+p7AhGVHVq5
 QFBLIZo9mv7FUmNhUOEi61+v2xhw7qDMzVDfJnd/Z8p/wtuRzNPRgjQZdBNshduhU6pF
 fF97K9o5H2h+d+NrHkr71c8cPVO9lBFAED4iH65lipfXZwxXka3s+6CbynLjTCv6HP4k
 WZKq8Ta0AsLhB3EUp7DbJM0MIxGDt6gDxbBmX6pm07Jdr5xA0F/cjKJUxF2DSe1cLmOZ
 mkAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6sNSjILttauQK6aE+vyvhxax1qpTJP50cU1WYTsi1BA=;
 b=mxEkMnHeCVCNdB1PpMz4WzONnDePecHMRXFScBS3kEvdTVGMX7ekUjGTj6ynTPh/1o
 IyCyy8nXD9nSFK2DrfI4O1my8F+73+kZl0V43jQcqUTFjxJpQ2jE0VllkbOWfIq+WoBA
 IHuBdN+4x2N+ZS9TdGryTBBnX9JCOhpY2fHyw8+GsUZqEM6IPJUURV5aK3QyHGv3e8YE
 ShFpX65pbWUsBQOd/PKYTzh3YRq7nIxfUnQYrMvomRivuSrAz/dEPdvJvlSNv+CCgQkt
 9ICe1+If0fs2B/Qz2N7ypqTdn3EsinvlcgqrS53LDhLvtWe358e31cCfmovEygipE8ME
 O9Lw==
X-Gm-Message-State: AJIora+DQsX5q44edPWpmDNkZc3FdQMbXKlvqbBGjd7XbpH5BpFgqknn
 EQQh0pZlL1K+8pCALDTPnut05ZHF3Xc0F8cnTas=
X-Google-Smtp-Source: AGRyM1uVUr4D6V5GatNUNcohIF5p8vveOjFcuQ1w9SIuQhOgTS/lQuZqxJT0t7gl/wZ5Roh5mvVjTzltQPej+St98X4=
X-Received: by 2002:a81:184b:0:b0:30c:846e:e2b with SMTP id
 72-20020a81184b000000b0030c846e0e2bmr8201259ywy.97.1655415430965; Thu, 16 Jun
 2022 14:37:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220613200112.3377638-1-Rodrigo.Siqueira@amd.com>
 <20220613200112.3377638-2-Rodrigo.Siqueira@amd.com>
 <pp_VMylAJoi-vp3VAJIjkeIfC89ncoHCCBFR_7ook2cjR9uC7bgBWcsjaFGNPFPgRMJHkwli2RNeXP0L32NQ8-Qvwf1IbTSyG8U5KNhTdJ8=@emersion.fr>
 <CADnq5_Pp+xSJO1mR24PQmm5bHhjY1Q-wC8GG97pr6axvrkmZeQ@mail.gmail.com>
 <wXTO8YYCjZe9USXO-9_zGZeVtSuFwgspCcHzjSZk9xdRK3Q1JisYUroSqU4GUwhL4At_N8UZifT5EAQJMBu5ADnetH8zlrOJNrG0NKqv-4E=@emersion.fr>
 <CADnq5_N_TJPy+UumtFkCn7GOVZjFuk2KxQPcFdJ8uVayC0EBqQ@mail.gmail.com>
 <24138d3c-1593-4d43-af76-5ad114e213b6@amd.com>
In-Reply-To: <24138d3c-1593-4d43-af76-5ad114e213b6@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 16 Jun 2022 17:36:59 -0400
Message-ID: <CADnq5_NkRy1RxHD9j_ae3RpQBFYMF8yd+8EokeJBu=3ueq=dOQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] Documentation/gpu: Add info table for ASICs
To: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
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
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
 Alex Hung <alex.hung@amd.com>, Simon Ser <contact@emersion.fr>,
 Tales Lelo da Aparecida <tales.aparecida@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 =?UTF-8?B?TWHDrXJhIENhbmFs?= <maira.canal@usp.br>,
 Melissa Wen <mwen@igalia.com>, Leo Li <sunpeng.li@amd.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, Hersen Wu <hersenxs.wu@amd.com>,
 Mark Yacoub <markyacoub@chromium.org>, Sean Paul <seanpaul@chromium.org>,
 Isabella Basso <isabbasso@riseup.net>, andrealmeid@riseup.net,
 Harry Wentland <harry.wentland@amd.com>,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 Pierre-Loup <pgriffais@valvesoftware.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jun 16, 2022 at 5:31 PM Rodrigo Siqueira Jordao
<Rodrigo.Siqueira@amd.com> wrote:
>
>
>
> On 2022-06-15 10:13, Alex Deucher wrote:
> > On Wed, Jun 15, 2022 at 3:47 AM Simon Ser <contact@emersion.fr> wrote:
> >>
> >> On Tuesday, June 14th, 2022 at 20:30, Alex Deucher <alexdeucher@gmail.com> wrote:
> >>
> >>> On Tue, Jun 14, 2022 at 2:16 PM Simon Ser contact@emersion.fr wrote:
> >>>
> >>>> On Monday, June 13th, 2022 at 22:01, Rodrigo Siqueira Rodrigo.Siqueira@amd.com wrote:
> >>>>
> >>>>> Amdgpu driver is used in an extensive range of devices, and each ASIC
> >>>>> has some specific configuration. As a result of this variety, sometimes
> >>>>> it is hard to identify the correct block that might cause the issue.
> >>>>> This commit expands the amdgpu kernel-doc to alleviate this issue by
> >>>>> introducing one ASIC table that describes dGPU and another one that
> >>>>> shares the APU info.
> >>>>
> >>>> Nice!
> >>>>
> >>>> Are there plans to keep this list up-to-date?
> >>>>
> >>>> FWIW, my go-to reference tables are 1, updated by Alex.
> >>>>
> >>>> Would it make sense to add a "GFX Core" column?
> >>>
> >>> That's what the GC column is for.
> >>
> >> Oh! Does this stand for "GFX Core", or for "Graphics and Compute"? The
> >> glossary documents GC as the latter. If there is a name conflict, maybe
> >> we can keep using the long name in the table, or document what "GC"
> >> means in a sentence.
> >
> > Both?  The hardware block is called GC, but I think different teams
> > expand it to Graphics Core (as in GCN) or Graphics and Compute.  Same
> > hardware block either way.  I guess we should include both in the
> > glossary.
>
>
> How should I add it? Something like this:
>
> GC/GFX:
>   Graphics and Compute/Core

maybe something like

GC:
   Graphics and Compute or Graphics Core.  Refers to the graphics
hardware block on the GPU.

>
> Thanks
> Siqueira
>
> > Alex
>
