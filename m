Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 311F61094472
	for <amd-gfx@archiver.kernel.org>; Sat, 21 Mar 2026 09:47:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57F0B10E386;
	Sat, 21 Mar 2026 09:47:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jOZ5g/GN";
	dkim-atps=neutral
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com
 [74.125.224.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5A8D10EB1A
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2026 17:26:19 +0000 (UTC)
Received: by mail-yx1-f43.google.com with SMTP id
 956f58d0204a3-64c9ebd1369so2263622d50.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2026 10:26:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774027579; cv=none;
 d=google.com; s=arc-20240605;
 b=MvjU1BFw6+tGFHVEyV/YP5f3KliDHUGW3/BbqBvhIe9n10hevthjOjWJLIgz2Oo/Vs
 i2dx5IF85sbfL5OMy2QG61yPij82KsjcP4nG5rxb6zNcaQQlFf09saJMRhQsrbnPkrXj
 EfumYTBy9g4VvFEqQEJ1u5BDCLUd4UCZg16nyq8hGsS2kOX9CIc/JfvV3fitf9f7UFxm
 q/XSR5w8yU3ty3XyoIWVSOWJR5uKMhZny1WHuXb9jMdvESDrjou1cq2oR32VS986ADB0
 4zgEtWb2udACNCxsyJzaQyGa4mugzFv2SEtrXbETV+oGf/SjScb+HO9N7uHTXzPsu4/y
 iDYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Tj3p8eyqsxs0jrqaosm095XCJBb6sVTFmtKJ+h8XxqE=;
 fh=h27AcMFliJPkG4CaoDRENIiKL3358r7zx8oAXiEhhCA=;
 b=CkBlxMxTCRUm8azD2PVaoRFZJlaWvpqMdPn54MkoTMtRUZfx+rXGtIMr16Ofrh+u8T
 rTySJL9FXOiGSVwJWJ98lR3O44Y++py3JMxbhBETy2qemVp/wi6gixj7ABlODxBy0umc
 5Y7+qLgPMu9FoyArPI9wDgV+6wqLP7ccvVAi8wu8EY0OWPllmCDtuUOYaUUH/coco08E
 nDMeLxyd+zLH/cA94W3Pdc8h+9u6Cafx5CnUWwPls1shJ8FCsVV9EvSayavqRX6k2s2E
 OdqvFW6sINKA2p+PCFBJzAtzqkLZxHXVKY41t4uQIFwL3hu7+fKUeNt7IRbnA40wZzbe
 8PeQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774027579; x=1774632379; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tj3p8eyqsxs0jrqaosm095XCJBb6sVTFmtKJ+h8XxqE=;
 b=jOZ5g/GNpWjiPQn6fcUx6KHfCZmbLNDvmaIIfNDWYqBst4A/Hm1MOIpKJ6Y1cdFP43
 4cZ+y6hyacc6tVquPGlhlIpS00gUy610LH6OTWE4sa1vf7oJRWDJdDuv6XDydeFLb1um
 +xWAWZ9Quj6DEsXC2wTJkzTDZ9qerrZRzD27n5XEEXcFLQTIlEkFaXB24t+wlwsMttuC
 qLW9B9RIhvNxqh7IFMNiuJzOW0myTmSR/NJt0wU/rS4N3hPgo/yl5ZYoEHzTRugpwRZM
 rwfK9aEVFkWH6B8Xu8r0qcNnEQd291q3hg+J9tC1s7u/2LrqpiZhdRLkxOADE8HZDnzD
 93JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774027579; x=1774632379;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Tj3p8eyqsxs0jrqaosm095XCJBb6sVTFmtKJ+h8XxqE=;
 b=M10rEn2NPsCF8PLHSl1Ge728vCBzphwERlBv6iM2z8rNfUoxehCq/Mnkf9vrZga+Ao
 34tUQzhcR+hJiSpVwy29r4ZaT4/n2eBZZouL8EPz9fQsrzG4uACXYOTVWRorbEU9o3ak
 mBm9Y5q4M2tJ2Ye5QOyBhK8Un1LfUntF5eFdYaa0YXWppVCjvdCRcLFy05G1dh+7XCKW
 H4nn2mz2n4wLUzrqPisBFB+p1nl4MGhFZRFj4b75aEGClbcr9ygxE0Icvq8A7S0/wC0Q
 jBEhklS3gDT7zjQJBSc0zuuuF8k8G5ngF/5Gs8aS9bt8qQ8T8T7v8f+w3nJuhenIu8pw
 9gcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7aXOQ/Hg/L4LLv0RG4sAfHJrrctBLXAOFtrRz+sYNtzx94KEA6I5gZVwwBsg3yVzPCU6uxVGa@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywaq/5Ruhr8jcLQWzQxHKKAwqWEwBHIh/gHYkHxeAwIodALt4a1
 B+XBRm6X8wdH2IriE27b9Ivn3IyQdPZyRbop0V9IbZEuw6erRLUFcgXPwuQ0wyG8+cVwXiyLYif
 03uikLeD/VanmnBhXdBncnt6GbAsy86A=
X-Gm-Gg: ATEYQzyXpw0aYQnMcqp/xr/+Deq7gV7t/eVBdswsm4owGmTxX1CEPr+u2Py8IulRn9t
 HUZmmThlkoE5iQ2misc1kLOz7YW7oC+AAcG+3r6rf0rt/unuQht2r4xlFzUr7VpNyPohBADP6ci
 8uyI0nZ1W1R0iCZGK1lvH5DsI1VQYBLiHpBbNoh0AcYIbT00nm4a+xyPWFuyatV6hWb55F035Fw
 f9gcQ6a9DwV+csfSkzM4Xh1G8cGX60zPrzMz/PTc082Yu403WjNtZ9zTcFjNCenn54Zifcv1r7e
 x1iK
X-Received: by 2002:a53:b6c5:0:b0:64c:9aa7:549d with SMTP id
 956f58d0204a3-64eaa78df37mr3443072d50.38.1774027578377; Fri, 20 Mar 2026
 10:26:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260313132103.2529746-1-jim.cromie@gmail.com>
 <20260313132103.2529746-2-jim.cromie@gmail.com>
 <177402491426.6181.12855763650074831089.b4-review@b4>
In-Reply-To: <177402491426.6181.12855763650074831089.b4-review@b4>
From: jim.cromie@gmail.com
Date: Fri, 20 Mar 2026 11:25:51 -0600
X-Gm-Features: AaiRm52mzW6EX86AA5Jjc_AE9pPFD7jbLjCUGPg_V9Sh6yOZDr0TEo5Rj5JOx1Q
Message-ID: <CAJfuBxzYUdM=HJ1yc=bTCHuRfPSznRZCPdfq_hfJSW7zxk4pEg@mail.gmail.com>
Subject: Re: [PATCH v11 01/65] dyndbg: fix NULL ptr on i386 due to section
 alignment
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com, 
 gregkh@linuxfoundation.org, mripard@kernel.org, tzimmermann@suse.de, 
 maarten.lankhorst@linux.intel.com, jani.nikula@intel.com, 
 ville.syrjala@linux.intel.com, christian.koenig@amd.com, 
 matthew.auld@intel.com, arunpravin.paneerselvam@amd.com, 
 skhan@linuxfoundation.org, pmladek@suse.com, ukaszb@chromium.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sat, 21 Mar 2026 09:47:17 +0000
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Mar 20, 2026 at 10:41=E2=80=AFAM Louis Chauvet
<louis.chauvet@bootlin.com> wrote:
>
> On Fri, 13 Mar 2026 07:19:26 -0600, Jim Cromie <jim.cromie@gmail.com> wro=
te:
> > [...]
> > smaller alignments, *and* scripts/sorttable.c does not tolerate the
> > added ALIGN(8) padding.
> >

More specifically, it counts records in 2 sections, and insists
they're the same count,
and there's no slop/extra space.  the align(8) broke that last constraint.

> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Closes: https://lore.kernel.org/oe-lkp/202601211325.7e1f336-lkp@intel.c=
om
> > Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
>
> comments may be wrong.


in v12, I found a way to use the makefile to conditionally include a "heade=
r"
file which invokes DYNAMIC_DEBUG_CLASSMAP_USE().

In doing this, I encountered some lost sections (lacking a KEEP in modules)
which I fixed by reusing the codetag.lds.h model, to make dyndbg.lds.h,
which reuses the (now separated out) BOUNDED_SECTION* macros,
and contains MOD_DYNDBG_SECTIONS(). which scripts/module.lds.S invokes.
So, those comments are now obsolete.


>
> >
> >
> > diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vm=
linux.lds.h
> > index eeb070f330bd..a2ba7e3d9994 100644
> > --- a/include/asm-generic/vmlinux.lds.h
> > +++ b/include/asm-generic/vmlinux.lds.h
> > @@ -212,11 +212,13 @@
> > [ ... skip 7 lines ... ]
> >
> >  #define BOUNDED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_)   \
> > +     . =3D ALIGN(8);                                                  =
 \
> >       _label_##_BEGIN_ =3D .;                                          =
 \
> >       KEEP(*(_sec_))                                                  \
> >       _label_##_END_ =3D .;
>
> This affects a lot of existing BOUNDED_SECTION_BY. I agree that it is
> not a big issue (most of them already have ALIGN(8) or ALIGN(32), but
> some have ALIGN(4) or just not aligned at all). I think this can increase
> the size of the kernel in other places.
>
> What do you think about a new macro or a
> BOUNDED_SECTION_BY_ALIGNED(sec,label,align) with explicit aligement?

Thats not crazy, but Im not sure its justified by the 6 lines that the
_ALIGNED() variant would save.  It does add some modest complexity to
the macros.


>
> > @@ -867,15 +869,21 @@
> > [ ... skip 15 lines ... ]
> >       . =3D ALIGN(2);                                                  =
 \
> >       .orc_unwind : AT(ADDR(.orc_unwind) - LOAD_OFFSET) {             \
> > -             BOUNDED_SECTION_BY(.orc_unwind, _orc_unwind)            \
> > +             __start_orc_unwind =3D .;                                =
 \
> > +             KEEP(*(.orc_unwind))                                    \
> > +             __stop_orc_unwind =3D .;                                 =
 \
>
> You already noticed an issue here for example, and you had to manually
> expand the macro to "disable" the align. This is error-prone, I think it =
is
> better to keep BOUNDED_SECTION_BY here.
>

I'll look at it - there is a stack of 3-4 macros that would need adjusting.

> Note: I don't understand well linker scripts and all the implications, my
>
> Note: I don't understand well linker scripts and all the implications, my
>
> --
> Louis Chauvet <louis.chauvet@bootlin.com>

thanks Louis,
Jim
