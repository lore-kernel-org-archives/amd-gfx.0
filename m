Return-Path: <SRS0=dIjB=7B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EFF6C433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2020 19:20:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5347A2070A
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2020 19:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MowJxjHG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5347A2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B12E289F6E;
	Tue, 19 May 2020 19:20:51 +0000 (UTC)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44EE989F6E
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2020 19:20:51 +0000 (UTC)
Received: by mail-ot1-x32c.google.com with SMTP id d7so463387ote.6
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2020 12:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=huEjfQiYn7ZSlUEyo5gul/xTGCrD7I9CtxiHUbIJRTA=;
 b=MowJxjHGQ7t8GLJB6lqH7rJKl80OP6T4wrDEe96HYZtAv+iyzvd5ZVbJDEmX5NTQDq
 Kq/N1tBq5kfRW6L0Xzb6rZqNYEi6hHV3NjpmGRGsrJwHSFPQcYoQKQXuWvN4yJiCGR+F
 yMonjN+q/X+7KX5dPptpoRLHpoZt/Wiwb5Ajz5Ufijry/EkjnZBUR9jqTWMPsd/PIy1p
 O5XronnYGNQJ7TIT2tTxI9anL3TbquaDx8fdt72Ipsag8Vtj7bbJu38ipjEZCd/NQuew
 d1YiAbQJPB/UwkqcehWfUleXGWLG9QY2+OdpPZABX0uSQEHqdfuWU4PUBWGU3rgBnVsl
 NezQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=huEjfQiYn7ZSlUEyo5gul/xTGCrD7I9CtxiHUbIJRTA=;
 b=t9LbUM2JZ5Eg+1OrLGhHjhnRx5TyFfkIKdqX7gPlHbRYWn5jMOr+DWxjNRpHYXHSf7
 1+IgYPwLweU2uPYxGXsHaHP+75ookXzEph/nOb4RXwYr27ZDY35r01Zl6JCikrx5lBGm
 8cw5QIUcTEx0Uqai9MBG2Y5oiTWGtafyCyDGD4aJez4VgKa31vy4ZpEpaZqNzj5qOrrP
 QVzSQhyo2ZUiU0dXHjY8k9TSyUsiNw+vyDujbG7AHK0JOXydsdWtpK4vaEmTucTc3jfj
 /yOTa43ICVy6STbRJk5qjLwlQlr2OxmXz//OQghlZYefnbbKzjA7ax/QmDK+u/cnVtP0
 Iq4A==
X-Gm-Message-State: AOAM533XI/m1xP7OOhTntfqdcifBZHSZuSldhCLp7mXHNzCJT91DkbjI
 dIVCdHRavK84CsxFR06pqaPNRrdA7RWGFsT3YsM=
X-Google-Smtp-Source: ABdhPJw66NSczICZDvFeRoOZQQKg/99lNmfcov9HOwfNajqvU+WymQWxNAcr5YzKrbGNm569Ml8gSvLB6/0S1Ie9JRQ=
X-Received: by 2002:a9d:5cc9:: with SMTP id r9mr471452oti.111.1589916049424;
 Tue, 19 May 2020 12:20:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAEOHGOm=g_VGa5939Qi_HEXAfuUKuy3tXURx9TKg+n==dUDqPQ@mail.gmail.com>
 <CADnq5_N-vLuyqo_rqjy44nwdKPWyiO8cpAJN9pFk79wjwKi7gw@mail.gmail.com>
In-Reply-To: <CADnq5_N-vLuyqo_rqjy44nwdKPWyiO8cpAJN9pFk79wjwKi7gw@mail.gmail.com>
From: Javad Karabi <karabijavad@gmail.com>
Date: Tue, 19 May 2020 14:20:38 -0500
Message-ID: <CAEOHGOkbu5jy_1_bUD4H0U89YEc_9zOxsSdyZqmtqZNsdOyDkg@mail.gmail.com>
Subject: Re: slow rx 5600 xt fps
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

im using Driver "amdgpu" in my xorg conf

how does one verify which gpu is the primary? im assuming my intel
card is the primary, since i have not done anything to change that.

also, if all shared buffers have to go through system memory, then
that means an eGPU amdgpu wont work very well in general right?
because going through system memory for the egpu means going over the
thunderbolt connection

and what are the shared buffers youre referring to? for example, if an
application is drawing to a buffer, is that an example of a shared
buffer that has to go through system memory? if so, thats fine, right?
because the application's memory is in system memory, so that copy
wouldnt be an issue.

in general, do you think the "copy buffer across system memory might
be a hindrance for thunderbolt? im trying to figure out which
directions to go to debug and im totally lost, so maybe i can do some
testing that direction?

and for what its worth, when i turn the display "off" via the gnome
display settings, its the same issue as when the laptop lid is closed,
so unless the motherboard reads the "closed lid" the same as "display
off", then im not sure if its thermal issues.

On Tue, May 19, 2020 at 2:14 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Tue, May 19, 2020 at 2:59 PM Javad Karabi <karabijavad@gmail.com> wrote:
> >
> > given this setup:
> > laptop -thunderbolt-> razer core x -> xfx rx 5600 xt raw 2 -hdmi-> monitor
> > DRI_PRIME=1 glxgears gears gives me ~300fps
> >
> > given this setup:
> > laptop -thunderbolt-> razer core x -> xfx rx 5600 xt raw 2
> > laptop -hdmi-> monitor
> >
> > glx gears gives me ~1800fps
> >
> > this doesnt make sense to me because i thought that having the monitor
> > plugged directly into the card should give best performance.
> >
>
> Do you have displays connected to both GPUs?  If you are using X which
> ddx are you using?  xf86-video-modesetting or xf86-video-amdgpu?
> IIRC, xf86-video-amdgpu has some optimizations for prime which are not
> yet in xf86-video-modesetting.  Which GPU is set up as the primary?
> Note that the GPU which does the rendering is not necessarily the one
> that the displays are attached to.  The render GPU renders to it's
> render buffer and then that data may end up being copied other GPUs
> for display.  Also, at this point, all shared buffers have to go
> through system memory (this will be changing eventually now that we
> support device memory via dma-buf), so there is often an extra copy
> involved.
>
> > theres another really weird issue...
> >
> > given setup 1, where the monitor is plugged in to the card:
> > when i close the laptop lid, my monitor is "active" and whatnot, and i
> > can "use it" in a sense
> >
> > however, heres the weirdness:
> > the mouse cursor will move along the monitor perfectly smooth and
> > fine, but all the other updates to the screen are delayed by about 2
> > or 3 seconds.
> > that is to say, its as if the laptop is doing everything (e.g. if i
> > open a terminal, the terminal will open, but it will take 2 seconds
> > for me to see it)
> >
> > its almost as if all the frames and everything are being drawn, and
> > the laptop is running fine and everything, but i simply just dont get
> > to see it on the monitor, except for one time every 2 seconds.
> >
> > its hard to articulate, because its so bizarre. its not like, a "low
> > fps" per se, because the cursor is totally smooth. but its that
> > _everything else_ is only updated once every couple seconds.
>
> This might also be related to which GPU is the primary.  It still may
> be the integrated GPU since that is what is attached to the laptop
> panel.  Also the platform and some drivers may do certain things when
> the lid is closed.  E.g., for thermal reasons, the integrated GPU or
> CPU may have a more limited TDP because the laptop cannot cool as
> efficiently.
>
> Alex
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
