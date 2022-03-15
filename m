Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D388DC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Mar 2022 16:03:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 725FA894FE;
	Tue, 15 Mar 2022 16:03:26 +0000 (UTC)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A32E894FE
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Mar 2022 16:03:25 +0000 (UTC)
Received: by mail-oo1-xc35.google.com with SMTP id
 n5-20020a4a9545000000b0031d45a442feso24919526ooi.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Mar 2022 09:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rFPya0NqpIhre5NBJh4hXrJtc3e7zNpTwIrU+BLxjAI=;
 b=OxWylegEAskyVJ7RVHFBOEfHjls5siT5Z0AO47Y8GlnAmLbKnuqktaj8HcOYYep+ud
 zSqmF7WnGr5PvNgagethT6z5RjyJQmUpl0rs+J6e+lfBycDu987E1SpNF/5iQhsMxb04
 r4owRpHjKZvK6EiIXrUH/r2JeF8dWJxmRx7QzXffFMT60EhJd891e4dq7yS40qhLCqdW
 85g1nVy03itW2DVLiQKXPuxc0FjvkYF/rd0nc3tWNwZi2rp5g93xi7KvXaqwpAqG+hsD
 MMMizc1nCZIUDj1I15Kmd63ZRav0ajefzsAQwoG0Np3ng8oRSybiFi+cR4qcyRhgJVAc
 7skg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rFPya0NqpIhre5NBJh4hXrJtc3e7zNpTwIrU+BLxjAI=;
 b=OR4XHgxWN+kybct4PXTbjQCvrykTJtoyzt+kP/C3uRjup2ymaMCUgWVkXZUCvi2hj0
 zrbQARHsHi2d/vWJUfWWuyapctd/mLw2LvY623i/pAreOOEbjrOh9nisI04X9/0O3Jcz
 hOL/ex0UFUpbH0ApWnew6aZEj8ZZU3r6sOQXRo6DP0LaTRsr7xOeZtKCelfaAYDtkYiG
 9d48n1cCMwMX7yMoUjyDEay4GynF//wf4RB1SzDqPT31LKeHWWCJYDDRY4TimYruC4tj
 hNyiQ6AiFykudsp1vjDwYlRi9hpLHdn8NuQe/11M/1sv39GOEISKDct9PqQ1T8XXgoyD
 x0hA==
X-Gm-Message-State: AOAM531tQJwkCrXpmLoyXYinhS5OMMmWgSr1bWx8uc/HT5Itz+KfdkWI
 op/vBmrI+T+pCh6xySs2IdA2WzhnNQgBa1frwMrQgP8A
X-Google-Smtp-Source: ABdhPJwmtlazjvu4OS1toxXpf1XjxHbkBvzWdRLcHV5tNrOX+V+9m3sHRDiC4D2boW6A3a4P9oV+swJ8OOZMyfPr39E=
X-Received: by 2002:a05:6870:630c:b0:da:b3f:324d with SMTP id
 s12-20020a056870630c00b000da0b3f324dmr1847582oao.253.1647360204272; Tue, 15
 Mar 2022 09:03:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220315092937.141380-1-pmenzel@molgen.mpg.de>
 <8e18afb8-497d-8ce5-5636-498e7b8d45ea@amd.com>
In-Reply-To: <8e18afb8-497d-8ce5-5636-498e7b8d45ea@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 15 Mar 2022 12:03:13 -0400
Message-ID: <CADnq5_Nw55vKTUWxBrh_DXXVX79A6xP3tnHHm7bHEudbr-nkxA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Use ternary operator in `vcn_v1_0_start()`
To: James Zhu <jamesz@amd.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Tue, Mar 15, 2022 at 8:49 AM James Zhu <jamesz@amd.com> wrote:
>
> This patch is Reviewed-by: James Zhu <James.Zhu@amd.com>
>
> On 2022-03-15 5:29 a.m., Paul Menzel wrote:
> > Remove the boilerplate of declaring a variable and using an if else
> > statement by using the ternary operator.
> >
> > Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 9 ++-------
> >   1 file changed, 2 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> > index 3799226defc0..78ad85fdc769 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> > @@ -1095,13 +1095,8 @@ static int vcn_v1_0_start_dpg_mode(struct amdgpu_device *adev)
> >
> >   static int vcn_v1_0_start(struct amdgpu_device *adev)
> >   {
> > -     int r;
> > -
> > -     if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
> > -             r = vcn_v1_0_start_dpg_mode(adev);
> > -     else
> > -             r = vcn_v1_0_start_spg_mode(adev);
> > -     return r;
> > +     return (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ?
> > +             vcn_v1_0_start_dpg_mode(adev) : vcn_v1_0_start_spg_mode(adev);
> >   }
> >
> >   /**
