Return-Path: <SRS0=LS4N=HH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C928C433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Feb 2021 09:27:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D29264FBE
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Feb 2021 09:27:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D29264FBE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B1976EEAD;
	Fri,  5 Feb 2021 09:27:15 +0000 (UTC)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B0AC6EEAD
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Feb 2021 09:27:14 +0000 (UTC)
Received: by mail-oi1-x231.google.com with SMTP id k25so6760308oik.13
 for <amd-gfx@lists.freedesktop.org>; Fri, 05 Feb 2021 01:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bC/3x6xZEQEo7Rsd9WsSYs1ThpFMpsu6DZqs3xi1V9Y=;
 b=d+s/ttLBBPSulMIDf3H7fLuKrz6HNnnlqIVrjMKrOE1Gj9yFAiwXDEvH71ecmVGbJ4
 w0jRvHgwJ7m5m6tcBDKmicFBM7CrDMNRc5wATCbKjuhp/KHxpKfntMMYVPGwiltIeH+E
 gVRO0sj2Ec2BkChi9BgIwoVkJmwbJAoLDUQmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bC/3x6xZEQEo7Rsd9WsSYs1ThpFMpsu6DZqs3xi1V9Y=;
 b=DlTEpSCm/hSqGCA5rs6vVm83gEoUuxtTPB2+ZOL+5hJ/lCKtRI8Xs2MnI1rAeyMm9r
 HpZ0uY8KwSY4aE/XAIwSzOR3NP2FrgS15OZ3uczZbfLDKZim3NxtMY7ADCQYQdTpT81q
 6+HmSeT7Z8/a+4lKWfUuCbqlTM/sxflclknDDiAm2QsuDfc2LldNDkufBuq8zcZVGtH7
 3pE8EGrTLvoBiimugfthCH9A3UT5M43EQ248oEqkvzPgxlvCeyCwmqqPPcKBuuLCO4UY
 JHp2ageoR4rNUJL+EwiDTwKj7Rx+JYCDFux/D4kjQdY9KR2cU+1r6Ijy6487SEyOH4FJ
 BBGA==
X-Gm-Message-State: AOAM533hxZxz53qH+p+MZH6M9Al3Xx5qxEx1mLdlSt6QgnIKq9u5J4Vb
 zlugwqDf523qsxDVYvhKnQgmu7JS5Ihq6lE8Bt1twA==
X-Google-Smtp-Source: ABdhPJzv8GE0uwZQUhy9jqVDIt8IvNcyHBE1WLfaB0ey4yuYQ/4vwsGVMsyTskHNVChYgwUcm3guoxdIO+ZIU7ZOcrI=
X-Received: by 2002:aca:df42:: with SMTP id w63mr2496478oig.128.1612517233942; 
 Fri, 05 Feb 2021 01:27:13 -0800 (PST)
MIME-Version: 1.0
References: <20210204045717.3823-1-alexander.deucher@amd.com>
 <CAPM=9tzKzgOTQd4zorqn8LP2QJhSLuD_xJhm5saSH2uUJE7_+w@mail.gmail.com>
 <CADnq5_MjZrt4EQt8UhszT-_UcuSY_j7Ezk__TmTr+NhBuWw=3A@mail.gmail.com>
In-Reply-To: <CADnq5_MjZrt4EQt8UhszT-_UcuSY_j7Ezk__TmTr+NhBuWw=3A@mail.gmail.com>
From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Fri, 5 Feb 2021 10:27:03 +0100
Message-ID: <CAKMK7uEqqEBHFm369oP-nFntUq-tN-bFRyR92M0UUyLbarqzfQ@mail.gmail.com>
Subject: Re: [pull] amdgpu, amdkfd drm-next-5.12
To: Alex Deucher <alexdeucher@gmail.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Dave Airlie <airlied@gmail.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Feb 5, 2021 at 5:33 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Thu, Feb 4, 2021 at 6:52 PM Dave Airlie <airlied@gmail.com> wrote:
> >
> > On Thu, 4 Feb 2021 at 14:57, Alex Deucher <alexdeucher@gmail.com> wrote:
> > >
> > > Hi Dave, Daniel,
> > >
> > > More fixes for 5.12.  Same PR from last week with the issue Felix reported
> > > fixed and a few more additional fixes on top.
> > >
> > > The following changes since commit a6b8720c2f85143561c3453e1cf928a2f8586ac0:
> > >
> > >   Merge tag 'amd-drm-next-5.12-2021-01-20' of https://gitlab.freedesktop.org/agd5f/linux into drm-next (2021-01-20 13:08:18 +0100)
> > >
> > This brought an arm32 warning with it, I've applied Arnd's patch to
> > drm-next to fix it.
> >
> > https://patchwork.freedesktop.org/patch/msgid/20210125124849.102037-1-arnd@kernel.org
> >
> > However that function has an ifdef around an ifdef that probably could
> > do with cleaning up.
>
> Sorry about that.  Bhawan fixed that up at the time:
> https://patchwork.freedesktop.org/patch/415092/
> Daniel said he picked that up last week:
> https://lists.freedesktop.org/archives/dri-devel/2021-January/294941.html
> but I guess it never landed, otherwise I would have included it in my PR.

Oops sorry, I somehow failed to push that one out :-/

I kinda liked the patch from Bhawan more, since less #ifdef.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
