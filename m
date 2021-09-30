Return-Path: <SRS0=sE/Q=OU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D30C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Sep 2021 18:00:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C677619F6
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Sep 2021 18:00:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4C677619F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DCCE6EC3C;
	Thu, 30 Sep 2021 18:00:07 +0000 (UTC)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBC1B6EC3C;
 Thu, 30 Sep 2021 18:00:05 +0000 (UTC)
Received: by mail-oi1-x22e.google.com with SMTP id x124so8329926oix.9;
 Thu, 30 Sep 2021 11:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Fw8pwH1OA13DiwW71Gp8zTFcOzlqtHtiksx8vBnSuZo=;
 b=m5+pnYPhp5Mbbl/i9v8Rayru7Xk0LHfsYZ/3ARwECIFS8Pg8nv5paLDPvYkwyh4Ca0
 arVdov2yDLqKrEtQAVe7Byn4CiqcTi2C0JwPArKj6xt/qkc65HNDbv4HSUHo1BqhTjPc
 dJdaY85okFWxMiOoGC5V6/loSkBmKHz8mYi/LACtdatdLYOB1mU5NHnLYXDlYmUbE7wJ
 PLbg0ZkPm+Ysz8O0c2kUx+pvWoWDVe3+WSgEKpw9nHMvoH2AmvHIn8NUt8C1uZf+4KTq
 hxPOTJ0Z0JDOrTp9TBwHkHbKXbwNaxX6R2HQgMghcbkMssONuWMb+Q58XNPQfoEcXHMA
 njIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Fw8pwH1OA13DiwW71Gp8zTFcOzlqtHtiksx8vBnSuZo=;
 b=cb2cDFUs222uSLvojj6c0kXGX0chGD4p/YeXC9Ml6mnjYNoN84wWbf8bUrvPxbd6qg
 peSwPwUMEz0WgQgLqcf76D9S20JsDr3K2vT83DxmOjLHEeGlp8B276BMrFsu09EXPWTK
 HpAQcUsrQ0p14lybN1rangqROyyOqFxmAETXXdYhI0kFn5tUCwElQwfxEsF80Jvx7dDh
 WM1tY7379OeJddDIRqV48MyZsNxcDb9WCdOON3+R3ReuxdoY/VWVkPirvQX62oErH6PP
 xfmPx6MLnPBpRRXxgj1kXM6mKBu38g9Vlbjf9YZBWfZ8WSxbbYKyrqB6m9zKWYIzSzuB
 0suA==
X-Gm-Message-State: AOAM532LIrX8Z973JJ2uuuGHoqfycyI28cizL5kabOxmHewoPxULtImX
 qZRp3pVTohgEz42H9kO4A3ShtIV937j4b7xqZJA=
X-Google-Smtp-Source: ABdhPJwXt1IhVLGQOfviPEsWczuXrnB2viox7TeVfyjdkXam/lIb60V/M9UNSLtcAmDLi1dT0ZBzUFXTJQRA5PgV35o=
X-Received: by 2002:a05:6808:1141:: with SMTP id
 u1mr440287oiu.123.1633024805243; 
 Thu, 30 Sep 2021 11:00:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210930162302.2344542-1-nathan@kernel.org>
 <CADnq5_PBMGdUG8VMUQ2UOSdd9qXbZ7QoyGH2RTgUPnTjdzKqFA@mail.gmail.com>
 <CAKwvOdk56-7UQDs_EAn+WK397mnd5H7_JMrsjROPk5ZFCw2QLw@mail.gmail.com>
In-Reply-To: <CAKwvOdk56-7UQDs_EAn+WK397mnd5H7_JMrsjROPk5ZFCw2QLw@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 30 Sep 2021 13:59:54 -0400
Message-ID: <CADnq5_N=x-PFvU2oYtLLSHcos1G_K=2qhSE0+1LS=zuBNov0JQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Return NULL instead of false in
 dcn201_acquire_idle_pipe_for_layer()
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>, 
 "Koenig, Christian" <christian.koenig@amd.com>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, 
 Nathan Chancellor <nathan@kernel.org>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, 
 amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Sep 30, 2021 at 1:23 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Thu, Sep 30, 2021 at 10:10 AM Alex Deucher <alexdeucher@gmail.com> wrote:
> >
> > Applied.  Thanks!
> >
> > Alex
> >
> > On Thu, Sep 30, 2021 at 12:23 PM Nathan Chancellor <nathan@kernel.org> wrote:
> > >
> > > Clang warns:
>
> Any chance AMDGPU folks can look into adding clang to the CI roster?

We can look into it.  We may already be doing it for some groups.

Alex

> --
> Thanks,
> ~Nick Desaulniers
