Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA7D0C43334
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jul 2022 00:59:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A719B18BCD9;
	Thu, 14 Jul 2022 00:59:10 +0000 (UTC)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F065B966AD
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jul 2022 23:10:00 +0000 (UTC)
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-31d85f82f0bso933197b3.7
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jul 2022 16:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=K8O302/7c4M+y4oSPuw97osYexdl2kGKky6mRepNyHk=;
 b=H09N2BCSGmpudE0ji2Q/gaZvJBtiZgN4m8BvrTevY/CHTWDL6gz4rjztzk441wczCU
 RX4gyudPZ0x6/dcPIjtS/PqA7m1mhDKscwmdHN5W5vsacoMRaca1xaX8Bi9c0vJ7912Y
 35miB9lQMLd1D54hGVRZ74ghp5WHLHU3DqsSCrXST6bNWO3IViYh+VjOlJqDoPapciKK
 B7ndbKU+2YYtw13rtVJZGEvMBwcAMWJwOye8ekF9n9tnm7IFdOyOki4IqzxnTMm2I4P6
 CmVlhgirpkFIW2USMZ6EmJ3cqChrEZJsbzK6ZtsZBz+KrDoC4VrgBy2HHOHBzZPFxO6H
 +T4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=K8O302/7c4M+y4oSPuw97osYexdl2kGKky6mRepNyHk=;
 b=5YqrdKeOW0VQmvGLZ0ltBqy3kSQ0PQc0Mo3tKWjlKURhHbuZAuwveaf/hX+K42v2NO
 WjT0jdrQ4ivqtOiZrPqOIgbkZzYCmC6kKHcnadqvLxjptYnCD5S4JigkeInmUtkOmV4a
 F5cq+9C1uYaZN9y1A5jSrejRnIQylxr9URonGzpC1Tdm66dF/3ISXAnMl03bqgF/GFJm
 tRJkWmHgkYiIEzAojFW0Wf4LtrNZTDpd98iGZx0SIXHppkuOO+mSnAYFahUWgXPRU+BS
 apbxGUBSQMOdf9lysvX5H0t1OpFqtBUU68OY554HUTNkjMSGwQEebYM4+qKTRBewE6R5
 en3g==
X-Gm-Message-State: AJIora/rddWI6YJNYNSNv6Vo5Z4FMrn2+kg3p1SzlyJvPlt5yZK6kYXw
 52QYXyTIGVF8h+AvyfSqinRJVbxYR90CnMC1YnY=
X-Google-Smtp-Source: AGRyM1ta1KjbW6tgvLYjpf/6k/gpgB7wBMLpjjuGdsSpq+y6Of+DnuhfTohzZB61/WRXkJef9Gp/OdBu/c/GkCpjDpE=
X-Received: by 2002:a81:158a:0:b0:31c:a84a:d772 with SMTP id
 132-20020a81158a000000b0031ca84ad772mr6811397ywv.233.1657753800010; Wed, 13
 Jul 2022 16:10:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgTmGaToVFdSdoFqT2sNkk7jg2rSWasUYv-tASUZ2j_0Q@mail.gmail.com>
 <20220713050724.GA2471738@roeck-us.net>
 <CAHk-=widUqghhXus_GCM9+FESa5vHqMb_pO3=0dGYH8C+yix2w@mail.gmail.com>
 <Ys8hqoiN5iWbslsM@shell.armlinux.org.uk>
 <CAHk-=wjNxyXQqn=k0KipzUPoBYWQhUwybxee8GTkF_Oz6RPVFw@mail.gmail.com>
 <CADVatmMJ4f+3-z1SWOSXuygee3fMsLqjcWhEY=NLhSCj61OB5Q@mail.gmail.com>
 <CAHk-=wgUGp96_Wup3=Utws=Mn+07vi7ZXknv4nKZkAJv8Ezhnw@mail.gmail.com>
 <CADVatmPx=T_i1oaX2i_d5crbWkixFZU7s-_wky_kz58wDgwGDQ@mail.gmail.com>
 <20220713225627.GC32544@roeck-us.net>
In-Reply-To: <20220713225627.GC32544@roeck-us.net>
From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Thu, 14 Jul 2022 00:09:24 +0100
Message-ID: <CADVatmM=JR4d4WU_53PtA6g-y40qc=CbHL9uhsJc2cSW=uoOXA@mail.gmail.com>
Subject: Re: Linux 5.19-rc6
To: Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 14 Jul 2022 00:59:04 +0000
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
 "Russell King \(Oracle\)" <linux@armlinux.org.uk>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Paul Mackerras <paulus@ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Daniel Axtens <dja@axtens.net>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jul 13, 2022 at 11:56 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Wed, Jul 13, 2022 at 10:50:06PM +0100, Sudip Mukherjee wrote:
> > On Wed, Jul 13, 2022 at 10:45 PM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > On Wed, Jul 13, 2022 at 2:36 PM Sudip Mukherjee
> > > <sudipm.mukherjee@gmail.com> wrote:
> > > >
> > > > > >
> > > > > > https://lore.kernel.org/all/20220524025139.40212-1-wangkefeng.wang@huawei.com/
> > > > >
> > > > > That patch looks sane to me, but I guess Guenter would need to check
> > > >
> > > > I still see the failure in my builds with this patch. But surprisingly
> > > > I dont see the build failure (with or without this patch) with gcc-12,
> > > > only with gcc-11.
> > >
> > > Arrghs. "build failure"?
> >
> > Uhh.. no, sorry.. I meant the same problem which Guenter reported with
> > powerpc64-linux-ld, hard float and soft float.
> > But I dont see this problem with gcc-12, only with gcc-11.
> >
>
> Weird. It works for me with gcc 11.3.0 / binutils 2.38 as well as with
> gcc 11.2.0 / binutils 2.36.1.

Its entirely possible that I have messed up, there are references to
many patches in this thread. :)
Can you please paste the link of the patch that you say is working for
you. I will try a clean build with that.


-- 
Regards
Sudip
