Return-Path: <SRS0=vakm=IA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A4DEC433DB
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Mar 2021 19:30:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23D9564F2E
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Mar 2021 19:30:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23D9564F2E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DDC76E057;
	Tue,  2 Mar 2021 19:30:46 +0000 (UTC)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44B986E057
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Mar 2021 19:30:45 +0000 (UTC)
Received: by mail-oi1-x22f.google.com with SMTP id a13so23213241oid.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 02 Mar 2021 11:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=w+SvXqEUjfhHwthcmMkrQk6d+ywLo9CmIC2aql3ZVM0=;
 b=Lp7mh2C4IHdf0flEGeKe/5N8ZYv6KEEUscBWkwK1euVPGZ/fOHaRUUpBQnOpSgw/si
 xY+qfrjzZF1/am/b6SwS9j6EZgOol6H/gb4/AGyAlk3BbhEoT2ZAbIIpvQuondXQlcU0
 wLG3M1raZqNKtcfCbJmLXbjsYHFA01JqedLealCorhgejMvwwmzFsVgx+Ad4KGxFznvG
 EyU7C/gs4iWpZ7lPgLBGUauUIi6ATTILlwLP19Wx31EpdPTyC5h1/UWGXxiC4OK7T0jB
 3ZkUdZ/EAxW/34sWDTcRSdtvk7HhGBBSCY3IfWdMA/li4ff9B9giPEkYjw62qhWGK2Cw
 yA0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=w+SvXqEUjfhHwthcmMkrQk6d+ywLo9CmIC2aql3ZVM0=;
 b=S+Fnf17bWQz8vLHzbKeMkyZTtk0ohv62dyu0pQ/eAHIs/gMK+gKbIit1zAEteffPN5
 YbPJHA6sznBlDsnffixhlH5zl3xUvUPTdCcCzfWV2RbB5HD1WTbGz7Vfa116c+CUYNbT
 nn1CMFN4foLy/gMO4r8H209FxeMuJQiW00AM9FR5o2rfJHpblkdMilp8DLoCCkqx7vo3
 DOK6E1OPiiFhpvllK8w/wsux0jF5KRwthuNr5+gxmSTWubo6M56kyY+1iF7r8bQcdMBg
 7z7EPquOvk8aF+BL8o5yUhiLs+XQANb1UF/AQaqT1L1pwdQCNumjBDXNptBLpXHTZviw
 8vTg==
X-Gm-Message-State: AOAM530NGzCBrWct9UX2asPIywlE1qmmZCfJQr7hNft6NI7NSJl/T92p
 5kEed2vLr1KIWicEKPxweN6RLfGKASavc7swUd7iHX+QVTs=
X-Google-Smtp-Source: ABdhPJzlv/EMCY/06qzQWW42RcptrNGrRcveS7uV6iQI72w++yR/IzUbjOzwaHiRbj/bu1zhokO2qeQJsPzzePUxsU4=
X-Received: by 2002:a05:6808:f15:: with SMTP id
 m21mr4350086oiw.123.1614713444602; 
 Tue, 02 Mar 2021 11:30:44 -0800 (PST)
MIME-Version: 1.0
References: <20210301104316.2766484-1-geert@linux-m68k.org>
 <alpine.DEB.2.22.394.2103011342520.710098@ramsan.of.borg>
In-Reply-To: <alpine.DEB.2.22.394.2103011342520.710098@ramsan.of.borg>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 2 Mar 2021 14:30:33 -0500
Message-ID: <CADnq5_O-j8EWL+Eb8zK-7WqUuWKWETVWYRQNFdS_ymUSgo1jrg@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.12-rc1
To: Geert Uytterhoeven <geert@linux-m68k.org>
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

On Mon, Mar 1, 2021 at 9:21 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> On Mon, 1 Mar 2021, Geert Uytterhoeven wrote:
> > Below is the list of build error/warning regressions/improvements in
> > v5.12-rc1[1] compared to v5.11[2].
> >
> > Summarized:
> >  - build errors: +2/-0
>
> > [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/fe07bfda2fb9cdef8a4d4008a409bb02f35f1bd8/ (all 192 configs)
> > [2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/f40ddce88593482919761f74910f42f4b84c004b/ (all 192 configs)
> >
> >
> > *** ERRORS ***
> >
> > 2 error regressions:
> >  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c: error: implicit declaration of function 'disable_kernel_vsx' [-Werror=implicit-function-declaration]:  => 674:2
> >  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c: error: implicit declaration of function 'enable_kernel_vsx' [-Werror=implicit-function-declaration]:  => 638:2
>
> powerpc-gcc4.9/ppc64_book3e_allmodconfig
>
> This was fixed in v5.11-rc1, but reappeared in v5.12-rc1?

Do you know what fixed in for 5.11?  I guess for PPC64 we depend on CONFIG_VSX?

Alex

>
> Gr{oetje,eeting}s,
>
>                                                 Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                                             -- Linus Torvalds
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
