Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E15F6C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jul 2022 16:49:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71D5810F876;
	Thu, 14 Jul 2022 16:49:17 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B2E210F87C
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jul 2022 16:48:56 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id m16so3153319edb.11
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jul 2022 09:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Qdwr0Ml6l65d9PvQ1N7Cqu7i3NgaLCCXJQKH4OW6snM=;
 b=WW+Mt5NH1K828fylJUZ5VelGkCH2HdmOWxOk4e94fwyd/+wD6pkJPQ2wgqMeaijwyX
 9F5ThYUcqjYGzIBAR/FBPjevBm+rlWZKPw3Cu3TCClKUF7wTKoSlc+IiG/GiuQ70+Q42
 UDBLmTfs8LaYePDB+3Pa5U3B3CGhy9airybE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Qdwr0Ml6l65d9PvQ1N7Cqu7i3NgaLCCXJQKH4OW6snM=;
 b=gmbr4Umz2x4ahHHi4c4EEhBhG5aY8dTNswfqNxDh5uPMIT1cDDAVtdgqfZeDtZ0ihq
 +EwFS5KkLbwwPJ5BZ0sraA5QMZjjNXPYhvBGg8rIrUvqBGNgeGX52OZ6xoOU7G6dFOJ1
 fJiZJ97PeX3HNQHoKCfd6nsKa5gT/KlI/l6958kHSDmnCVjJGmHLfYIIyNVxmQ4/ivcP
 msk1oN+4MjhT7oD0iZ+gYDcYnsHQuMVlFHLYNl5QkOgr4OvJ6hqjwl3jw+7z2ArI9seE
 7H+0YDSP0X3KFP0VVKnlv1ypf5jyzW34D6O2UsAdfA0pkToqh2So7Y7/TEw4NOHzSXQP
 h1Ug==
X-Gm-Message-State: AJIora+J4m6ttksoJqHCovaeihjORBApc7dlM0Ye7KHlzeqxsZmdVCqj
 +FQ2sLzYEEW1AkKlCNMbmhTF7D6hy9mlWTcLPFU=
X-Google-Smtp-Source: AGRyM1ujCM08DmpJlgRDrDxCNv6Uc+vaWcll6iViF3/P1Hmgcf2zko4v6mS2AZeddSceZs73qjCzZQ==
X-Received: by 2002:a05:6402:3581:b0:43a:d66b:99b5 with SMTP id
 y1-20020a056402358100b0043ad66b99b5mr13519596edc.375.1657817334431; 
 Thu, 14 Jul 2022 09:48:54 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com.
 [209.85.221.43]) by smtp.gmail.com with ESMTPSA id
 y18-20020a1709063a9200b007030c97ae62sm874322ejd.191.2022.07.14.09.48.53
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Jul 2022 09:48:53 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id z12so3343200wrq.7
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jul 2022 09:48:53 -0700 (PDT)
X-Received: by 2002:a5d:544b:0:b0:21d:70cb:b4a2 with SMTP id
 w11-20020a5d544b000000b0021d70cbb4a2mr8939974wrv.281.1657817332916; Thu, 14
 Jul 2022 09:48:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgTmGaToVFdSdoFqT2sNkk7jg2rSWasUYv-tASUZ2j_0Q@mail.gmail.com>
 <20220713050724.GA2471738@roeck-us.net>
 <CAHk-=widUqghhXus_GCM9+FESa5vHqMb_pO3=0dGYH8C+yix2w@mail.gmail.com>
 <a804b76e-159f-dbc2-f8dc-62a58552e88d@roeck-us.net>
 <CADnq5_O6Tp2QPXyDCvpWuRXhDr6H1PM50Ow5YG2WeukqUd-GnQ@mail.gmail.com>
 <CAHk-=wj4+BSj2SPMRUr-TZ4Qg2o9HGOBWiJQE336YcF_U1sVNQ@mail.gmail.com>
 <CAMuHMdV9Pj9V-ZPpu=BMSkPt1uA_eCvU4+bxF8ZfHjteRk2CAg@mail.gmail.com>
In-Reply-To: <CAMuHMdV9Pj9V-ZPpu=BMSkPt1uA_eCvU4+bxF8ZfHjteRk2CAg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 14 Jul 2022 09:48:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgnmaTVigBc02tjqgcZaNJiYz8Xw77P+ERAXhcYjkwd=Q@mail.gmail.com>
Message-ID: <CAHk-=wgnmaTVigBc02tjqgcZaNJiYz8Xw77P+ERAXhcYjkwd=Q@mail.gmail.com>
Subject: Re: Linux 5.19-rc6
To: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 14 Jul 2022 16:49:16 +0000
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

On Thu, Jul 14, 2022 at 12:23 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Oh, it's not just this one. The lists of build regressions between v5.18
> and v5.19-rc1 [1] resp. v5.19-rc6 [2] look surprisingly similar :-(
>
> [1] https://lore.kernel.org/all/20220606082201.2792145-1-geert@linux-m68k.org
> [2] https://lore.kernel.org/all/20220711064425.3084093-1-geert@linux-m68k.org

Hmm.

Some of them are because UM ends up defining and exposing helper
functions like "to_phys()", which it just shouldn't do. Very generic
name - so when some driver ends up using the same name, you get those
errors.

And some look positively strange. Like that

  drivers/mfd/asic3.c: error: unused variable 'asic'
[-Werror=unused-variable]:  => 941:23

which is clearly used three lines later by

        iounmap(asic->tmio_cnf);

and I can't find any case of 'iounmap()' having been defined to an
empty macro or anything like that to explain it. The error in
drivers/tty/serial/sh-sci.c looks to be exactly the same issue, just
with ioremap() instead of iounmap().

It would be good to have some way to find which build/architecture it
is, because right now it just looks bogus.

Do you perhaps use some broken compiler that complains when the empty
inline functions don't use their arguments? Because that's what those
ioremap/iounmap() ones look like to me, but there might be some
magical architecture / config that has issues that aren't obvious.

IOW, I'd love to get those fixed, but I would also want a little bit more info.

            Linus
