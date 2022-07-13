Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE700C43334
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jul 2022 21:46:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4333A9BE8B;
	Wed, 13 Jul 2022 21:46:33 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A71299BE51
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jul 2022 21:45:33 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id k30so40584edk.8
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jul 2022 14:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xryg/wyAEmcgAFZe/2FGYSAJQ5pYUeWTkKhjNYqQp04=;
 b=AdGnrzwQyk+BkYsu8V/E2oDFORdr7gasa29EuHtC3fdSF1wxQ97TWw10RMsUyVPeyi
 paiwWxijYZ/Ejbq7QJuQopODRVp8UWSEJdxm02AltWOPBW7jgLsV7cb8ILrX8QKcATKk
 7ekEPZGvOkl5y4D2u7O1u+O6jffe3hJs6QRik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xryg/wyAEmcgAFZe/2FGYSAJQ5pYUeWTkKhjNYqQp04=;
 b=Ao/520n0qlTm95U943RUX3o0b1lWJ9zJ4bMdaBVrzui/jFi1abyb0uJmMEuMuvjaQu
 u+gNAdizjOWcmoKbfBkQTfl/V7t7LoZmuiXsixqXNN4fa/TViC+RZ6Kr3XQvvXDHVD+T
 t0QTqRRL3oJPBARR9bpdVDjyX2Miuqxj1ToV1oIRhJ6udT8OdhnXAs8xIZI1BTG5ucPi
 xvDzSG1M0DQp8cINupRU+c0s/Thm4rFHig9QODbIPtsX+AD/BW+yF9kHe7MwrvZSq5gz
 FiSObh1pcd0xpQWuiqjspe6f15jTsXmcs1PtB+4xlScTme73JA/d6vJ0Kv8/kX8qZMqB
 sovw==
X-Gm-Message-State: AJIora8uWUTLaZ8Mbj+/QfQze0JSS9DIQYNvVhp8YdCJuFy0GPJ/CAot
 DzITRLedBqVu6T6ent8ZzpqT/KoEOaWgClqnZAA=
X-Google-Smtp-Source: AGRyM1sql1FeIxlAwMDpvDgAFz8oYmoXWJFupr63TmPJKRB8Lomt62Z52cdzAS1EKuBLK5zhIf++bQ==
X-Received: by 2002:a05:6402:2b88:b0:43a:6c58:6c64 with SMTP id
 fj8-20020a0564022b8800b0043a6c586c64mr7952247edb.348.1657748731766; 
 Wed, 13 Jul 2022 14:45:31 -0700 (PDT)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com.
 [209.85.128.48]) by smtp.gmail.com with ESMTPSA id
 e41-20020a056402332900b0042de3d661d2sm8672299eda.1.2022.07.13.14.45.30
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Jul 2022 14:45:31 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id
 i204-20020a1c3bd5000000b003a2fa488efdso1657370wma.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jul 2022 14:45:30 -0700 (PDT)
X-Received: by 2002:a1c:4455:0:b0:3a2:d929:917a with SMTP id
 r82-20020a1c4455000000b003a2d929917amr5761713wma.38.1657748730445; Wed, 13
 Jul 2022 14:45:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgTmGaToVFdSdoFqT2sNkk7jg2rSWasUYv-tASUZ2j_0Q@mail.gmail.com>
 <20220713050724.GA2471738@roeck-us.net>
 <CAHk-=widUqghhXus_GCM9+FESa5vHqMb_pO3=0dGYH8C+yix2w@mail.gmail.com>
 <Ys8hqoiN5iWbslsM@shell.armlinux.org.uk>
 <CAHk-=wjNxyXQqn=k0KipzUPoBYWQhUwybxee8GTkF_Oz6RPVFw@mail.gmail.com>
 <CADVatmMJ4f+3-z1SWOSXuygee3fMsLqjcWhEY=NLhSCj61OB5Q@mail.gmail.com>
In-Reply-To: <CADVatmMJ4f+3-z1SWOSXuygee3fMsLqjcWhEY=NLhSCj61OB5Q@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 13 Jul 2022 14:45:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgUGp96_Wup3=Utws=Mn+07vi7ZXknv4nKZkAJv8Ezhnw@mail.gmail.com>
Message-ID: <CAHk-=wgUGp96_Wup3=Utws=Mn+07vi7ZXknv4nKZkAJv8Ezhnw@mail.gmail.com>
Subject: Re: Linux 5.19-rc6
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 13 Jul 2022 21:46:32 +0000
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
 "Russell King \(Oracle\)" <linux@armlinux.org.uk>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Paul Mackerras <paulus@ozlabs.org>, Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Guenter Roeck <linux@roeck-us.net>,
 Daniel Axtens <dja@axtens.net>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jul 13, 2022 at 2:36 PM Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
>
> > >
> > > https://lore.kernel.org/all/20220524025139.40212-1-wangkefeng.wang@huawei.com/
> >
> > That patch looks sane to me, but I guess Guenter would need to check
>
> I still see the failure in my builds with this patch. But surprisingly
> I dont see the build failure (with or without this patch) with gcc-12,
> only with gcc-11.

Arrghs. "build failure"?

So is there another problem than the runtime issue that Guenter reports:

  OF: amba_device_add() failed (-19) for /amba/smc@10100000

in this area? That patch looks harmless from a build standpoint, but
that's not saying much, so can you please quote the actual build
failure here?

                  Linus
