Return-Path: <SRS0=jB5Z=EB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FCAEC388F9
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2020 19:34:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8CF02085B
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2020 19:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ua/skFVp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8CF02085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EFBA89E63;
	Mon, 26 Oct 2020 19:34:38 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1911189E36;
 Mon, 26 Oct 2020 19:34:37 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id c16so13685805wmd.2;
 Mon, 26 Oct 2020 12:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Dt4AWesHgq95MuA9noAsqgwDvEHb5guDweoxzfn9TuQ=;
 b=ua/skFVpbRauDrk7eU647JocRmuulattFN3tamwpD1R3kDFDul1hutbRR/NHpZZ4TR
 QOi9sR0tej5ewSmtacJVK/RSoeta5RBfVfqvleriesi6pvhQp2yqoHNgM/2JLOD5xsSu
 SFwtCTo5TYmVdyL75EcYwQo+6ROk+p0Al8X+CWVAoWDkxgsC7Pgcj+Lk8j8IbN8W2eJ+
 uJn8gMZkGofT8ifLHiVV6l5SEiAp3MfwQmhnRswrc5p/tmX8M+Fkvqek1phdIvOxk02O
 uV3lIfkgbFdyVEimgrwM8H3TCHAjSfgPXgQZQmJKhuHSxbqX1ZVYFNLJhYQdm8ellHs0
 GdVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Dt4AWesHgq95MuA9noAsqgwDvEHb5guDweoxzfn9TuQ=;
 b=bARGO+++Em3YQGlIQ6iboV+VAjp3lhUnjeBURSOrpaGSgP3cLKpfXJTZP0fSzx+z4e
 U7Pc2VLh3+aWh4/FJSDKv496QOOvsiaob/aZKI5ZqbH057mT5vLHrIdCeXQhD2642btn
 KWDHqCLkct785JR92bM1nh84KH1w5YdUiBv960wBqAPp9KyQ3txvoHH0RMzU+uPDrHp7
 k6zYefOWRTfYeKDnwpF66ZxvHWwdv800aDVJgALLD9ig8znlVFhlddsB6mU35zuiAjVC
 d+gsMGjETDWhzWWLC99agy0q1J59cf0I3GCP3vHuCE+P3AmJLOTjYuSaFvnRw+ru6TH9
 6KHA==
X-Gm-Message-State: AOAM533E2h7rNT8SXprsxlUxXR1Y9ywjMGfA3KEQaHNZrl1IaFgJQwbh
 tf7Kcn1KUjiWEwfxjtTJcecD3GWFE0ut6BG8EW0=
X-Google-Smtp-Source: ABdhPJx8VRcrhv9u5TFKRPzbWDC4InYcOACd443ZXQxhRMYnK4DNXUCXAYaxfxxQ6ex6FFNBDhBx6aM37v+/WXqsGi8=
X-Received: by 2002:a1c:6302:: with SMTP id x2mr17930983wmb.56.1603740875736; 
 Mon, 26 Oct 2020 12:34:35 -0700 (PDT)
MIME-Version: 1.0
References: <20201023074656.11855-1-tiwai@suse.de>
 <1d3e22ef-a301-f557-79ca-33d6520bb64e@amd.com>
In-Reply-To: <1d3e22ef-a301-f557-79ca-33d6520bb64e@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 26 Oct 2020 15:34:24 -0400
Message-ID: <CADnq5_OY8tRqs-bao9mkKxgcXC=305-_71U=04C5z9HM0+5MuQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] drm/amd/display: Fix kernel panic by breakpoint
To: Luben Tuikov <luben.tuikov@amd.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Yes, looks good to me as well.  Series is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>
I'll give the display guys a few more days to look this over, but if
there are no objections, I'll apply them.

Thanks!

Alex

On Fri, Oct 23, 2020 at 7:16 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
>
> On 2020-10-23 03:46, Takashi Iwai wrote:
> > Hi,
> >
> > the amdgpu driver's ASSERT_CRITICAL() macro calls the
> > kgdb_breakpoing() even if no debug option is set, and this leads to a
> > kernel panic on distro kernels.  The first two patches are the
> > oneliner fixes for those, while the last one is the cleanup of those
> > debug macros.
>
> This looks like good work and solid. Hopefully it gets picked up.
>
> Regards,
> Luben
>
> >
> >
> > Takashi
> >
> > ===
> >
> > Takashi Iwai (3):
> >   drm/amd/display: Fix kernel panic by dal_gpio_open() error
> >   drm/amd/display: Don't invoke kgdb_breakpoint() unconditionally
> >   drm/amd/display: Clean up debug macros
> >
> >  drivers/gpu/drm/amd/display/Kconfig             |  1 +
> >  drivers/gpu/drm/amd/display/dc/gpio/gpio_base.c |  4 +--
> >  drivers/gpu/drm/amd/display/dc/os_types.h       | 33 +++++++++----------------
> >  3 files changed, 15 insertions(+), 23 deletions(-)
> >
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
