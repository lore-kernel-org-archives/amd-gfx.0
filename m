Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBE3DC43334
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jul 2022 16:53:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF5F611305B;
	Thu, 14 Jul 2022 16:53:03 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9EE511A392
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jul 2022 16:53:01 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id ss3so4439244ejc.11
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jul 2022 09:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5tuLjpCGqWrD227/QGgnnSNYGLhT/vS01RvkkxDi7L4=;
 b=TZsJ1ETna5AdZ9RUaz3BU1K06a0qxx7Lmc2KWmixjNCYKF3jI7BxPIkOC+Qj9zRghD
 l5Fzn3Y+T7eKxPuPwxN0jxHkTm41clKD/a8wI1pJgiL/4tmWdd445WFkkX0UqpDwfaf8
 CKfI6AxIl1ahxJJsc0V60tRZUco7YXkim060eyE6tKzRBriKRtH4Z7Wa9bOvdMCtinni
 vX425htCQlkf/N27mVBvwst5puJ+li9xAb+yGkzWhtCGb2svRSOBLT41f7lCmYGzntMb
 otwXLl9V2CK7fMSE6XByhfZjAmQBIohjqk3qCbdzLbsSRI3gYX7IIBolcdEiLqOSX86j
 1lXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5tuLjpCGqWrD227/QGgnnSNYGLhT/vS01RvkkxDi7L4=;
 b=4vhAYec7kxZ6UdhwMmlBvZrc3g4B8tXuOhOhbuSwPy8kwwB0t5Cmrs5MVwxCuQSRTF
 E+BdiceMAeEG6NMX4Dj0MYXSHjac/hMutBmoZl8CIhyI1Ipl9VlJxXyORYdskUaIB1/F
 OUW5Mb0l717osP2HKPwUChR/IJI9V2S4VTkDxXMduvldwJXJMG5x+WoLAuC+7Oiv+7fP
 fYXse6HAOMowHiPoFWImnsrArziexuCuV/Mr/WxQbxHXcqK6vj+4Im/erWmlroUfpL8c
 /HVLD+R8xlAeDDu/JwKWzhergtcyfrgxpv6NOScg4e/OYeZnHNnqeLY2MIEHT6OULNXQ
 rmaw==
X-Gm-Message-State: AJIora/K5D8D8EBpDLcHo9XpvlpwNVAo6m8+Mj7ISn8kGTU7kiR0GyWA
 cBioOQ+IR0JExcGI4GtpX5HpfHxi7ArvJacrK3s=
X-Google-Smtp-Source: AGRyM1s6mcagDQ5ljN0eoYPPZCg+A/DFYjmUcK2ayLILrDu7Mxf2FI+04Gck13f6BKZ8622WE2PUCMXV5IU5gO/KDgw=
X-Received: by 2002:a17:907:2702:b0:72b:307b:98e6 with SMTP id
 w2-20020a170907270200b0072b307b98e6mr9697124ejk.658.1657817580248; Thu, 14
 Jul 2022 09:53:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgTmGaToVFdSdoFqT2sNkk7jg2rSWasUYv-tASUZ2j_0Q@mail.gmail.com>
 <20220713050724.GA2471738@roeck-us.net>
 <CAHk-=widUqghhXus_GCM9+FESa5vHqMb_pO3=0dGYH8C+yix2w@mail.gmail.com>
 <a804b76e-159f-dbc2-f8dc-62a58552e88d@roeck-us.net>
 <CADnq5_O6Tp2QPXyDCvpWuRXhDr6H1PM50Ow5YG2WeukqUd-GnQ@mail.gmail.com>
 <CAHk-=wj4+BSj2SPMRUr-TZ4Qg2o9HGOBWiJQE336YcF_U1sVNQ@mail.gmail.com>
In-Reply-To: <CAHk-=wj4+BSj2SPMRUr-TZ4Qg2o9HGOBWiJQE336YcF_U1sVNQ@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 14 Jul 2022 12:52:48 -0400
Message-ID: <CADnq5_ME1DsZsmC1NbHOyzfKbBp_jcKycG7Fh1HMN8y3AejWKg@mail.gmail.com>
Subject: Re: Linux 5.19-rc6
To: Linus Torvalds <torvalds@linux-foundation.org>
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
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>, Leo Li <sunpeng.li@amd.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Balbir Singh <bsingharora@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Paul Mackerras <paulus@ozlabs.org>,
 "Russell King \(Oracle\)" <rmk+kernel@armlinux.org.uk>,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Guenter Roeck <linux@roeck-us.net>,
 Daniel Axtens <dja@axtens.net>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jul 13, 2022 at 5:32 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, Jul 13, 2022 at 2:01 PM Alex Deucher <alexdeucher@gmail.com> wrote:
> >
> > If you want to apply Guenter's patch original patch:
> > https://patchwork.freedesktop.org/patch/490184/
> > That's fine with me.
>
> Honestly, by this time I feel that it's too little, too late.
>
> The ppc people apparently didn't care at all about the fact that this
> driver didn't compile.
>
> At least Michael Ellerman and Daniel Axtens were cc'd on that thread
> with the proposed fix originally.
>
> I don't see any replies from ppc people as to why it happened, even
> though apparently a bog-standard "make allmodconfig" just doesn't
> build.
>
> I'd try it myself, since I do have a cross-build environment for some
> earlier cross-build verification I did.
>
> But since my upgrade to F36 it now uses gcc-12, and possibly due to
> that I get hundreds of errors long before I get to any drm drivers:
>
>   Cannot find symbol for section 19: .text.create_section_mapping.
>   arch/powerpc/mm/mem.o: failed
>   ...
>   Cannot find symbol for section 19: .text.cpu_show_meltdown.
>   drivers/base/cpu.o: failed
>   Error: External symbol 'memset' referenced from prom_init.c
>
> this cross environment used to work for me, but something changed (I
> mention gcc-12, but honestly, that's based on nothing at all, except
> for the few problems it caused on x86-64. It could be something
> entirely unrelated, but it does look like some bad interaction with
> -ffunction-sections).
>
> So considering that the ppc people ignored this whole issue since the
> merge window, I think it's entirely unreasonable to then apply a
> ppc-specific patch for this at this time, when people literally asked
> "why is this needed", and there was no reply from the powerpc side.
>
> Does any of that sound like "we should support this driver on powerpc" to you?

Fair enough.  I don't have a strong opinion on the matter.  Users will
hopefully likely notice the failure after release because most people
don't test until after a release and then we'll apply the fix and
re-enable it for 5.20 so that would leave 5.19 broken for PPC64 users
which would not be ideal.  But as you said, no one has cared up to
this point.

Alex

>
>                  Linus
