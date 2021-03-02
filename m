Return-Path: <SRS0=vakm=IA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B59C433DB
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Mar 2021 20:21:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0789064F0B
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Mar 2021 20:21:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0789064F0B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 508226E96A;
	Tue,  2 Mar 2021 20:21:00 +0000 (UTC)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com
 [209.85.217.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EAE86E96A
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Mar 2021 20:01:23 +0000 (UTC)
Received: by mail-vs1-f48.google.com with SMTP id z65so8935528vsz.12
 for <amd-gfx@lists.freedesktop.org>; Tue, 02 Mar 2021 12:01:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lzf9U5TyFr8YSgCYbQV0aCCbWT0MRYgraMrf2J/E5OM=;
 b=B8KIGGnmC8ZSXaMb2q4DN7UC0w5v/NM5SKHxglO7fQmAk3SDcoz/2q+hN2WdbHO0+Q
 nAIQZGlc1EIl0RaTUhmZjgunWxuf1JSDv+3R43Ld5G7IxNRIQfmU0wuoPHgL6Apw4TCL
 +97f+UcmcQNkfOdQgV0rgz3BVisi3E6t8dW/wDraFSJ3eopbdVvbuxCV22h2A5Re95Jz
 nir+OJMixSBCUHfvZuJDEnQkGMagFmDvY13tW1m42ZzNL8rQxLaOK60Z/0gET+3JOodT
 eRVu5e80HGfRuq/ZCDMp7hFfO9y1nqYR1ZekiEHFlIaQs6lDSne20s+lG4LcfGVTYyc7
 t/EQ==
X-Gm-Message-State: AOAM533yIxUH7MGDQ6EZIJBMo+CiUxGCj7XiFMZm769NYhgAkWPyiUb8
 gt69HkAv4bxts/SgSMnR7qaGidjRG4UOtR/Cx7Y=
X-Google-Smtp-Source: ABdhPJzRCGpW4RCsZEhpYEAn3MR1Q73gbJHqe3CH+KRCFvVBwE5R/NVI0GIx7VbV9hgc+A3Gg/HXK7gUOE34HM0PfoU=
X-Received: by 2002:a67:fb86:: with SMTP id n6mr3865292vsr.3.1614715282171;
 Tue, 02 Mar 2021 12:01:22 -0800 (PST)
MIME-Version: 1.0
References: <20210301104316.2766484-1-geert@linux-m68k.org>
 <alpine.DEB.2.22.394.2103011342520.710098@ramsan.of.borg>
 <CADnq5_O-j8EWL+Eb8zK-7WqUuWKWETVWYRQNFdS_ymUSgo1jrg@mail.gmail.com>
In-Reply-To: <CADnq5_O-j8EWL+Eb8zK-7WqUuWKWETVWYRQNFdS_ymUSgo1jrg@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 2 Mar 2021 21:01:10 +0100
Message-ID: <CAMuHMdVFstnce-WKmj=4h3ZdtSThJNOLz_f1ervcZxE6hg=KsA@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.12-rc1
To: Alex Deucher <alexdeucher@gmail.com>
X-Mailman-Approved-At: Tue, 02 Mar 2021 20:20:59 +0000
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Alex,

On Tue, Mar 2, 2021 at 8:30 PM Alex Deucher <alexdeucher@gmail.com> wrote:
> On Mon, Mar 1, 2021 at 9:21 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Mon, 1 Mar 2021, Geert Uytterhoeven wrote:
> > > Below is the list of build error/warning regressions/improvements in
> > > v5.12-rc1[1] compared to v5.11[2].
> > >
> > > Summarized:
> > >  - build errors: +2/-0
> >
> > > [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/fe07bfda2fb9cdef8a4d4008a409bb02f35f1bd8/ (all 192 configs)
> > > [2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/f40ddce88593482919761f74910f42f4b84c004b/ (all 192 configs)
> > >
> > >
> > > *** ERRORS ***
> > >
> > > 2 error regressions:
> > >  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c: error: implicit declaration of function 'disable_kernel_vsx' [-Werror=implicit-function-declaration]:  => 674:2
> > >  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c: error: implicit declaration of function 'enable_kernel_vsx' [-Werror=implicit-function-declaration]:  => 638:2
> >
> > powerpc-gcc4.9/ppc64_book3e_allmodconfig
> >
> > This was fixed in v5.11-rc1, but reappeared in v5.12-rc1?
>
> Do you know what fixed in for 5.11?  I guess for PPC64 we depend on CONFIG_VSX?

Looking at the kisskb build logs for v5.11*, it seems compilation never
got to drivers/gpu/drm/ due to internal compiler errors that weren't caught
by my scripts.  So the errors listed above were not really fixed.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
