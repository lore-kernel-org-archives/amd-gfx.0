Return-Path: <SRS0=dIjB=7B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A65C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2020 21:34:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 482092072C
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2020 21:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="emEfekyJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 482092072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 093E289C48;
	Tue, 19 May 2020 21:34:24 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9710D89C48
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2020 21:34:22 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id m12so707027wmc.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2020 14:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FBucR01cR92xI6syNYQ82Pv4WKnjnbTR1vSh5N8jz9U=;
 b=emEfekyJoyEEFgKNQy5708f9Ot65NgRoU1WoPgF/nVPFXGXDjzYlyJu1YdtkOzHrE+
 hkJrmTp3eFD81kFDo2a7423mJEe4HdaVtvqpgXx2Wxbojkqs9Z9HJr3N/nOBhjuZjllm
 HZft7WhKXNaEH8YjEjj9SvQfNsOoNusxLagnjts5YdgSEomRSYlDPzNjeI5uxpX9QWQI
 0vQqnzcntuuwZnofxvrURw9CGV0aGnrINE8GBCPgNK9KBYcKX4LkI8/u51nnGduncoQC
 5r9gMXrgF6swCmRutsonvm/Y9/yjfymF6hkwlFkgsbRYkwKXhl23boUmGqhzQmOfNa8x
 fXMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FBucR01cR92xI6syNYQ82Pv4WKnjnbTR1vSh5N8jz9U=;
 b=dlRFcJrsdvmXa19dfrEzfhU5j9pUEvZ4s9LgbRABvxLNgJgNakaSRfGAGSb2grZDvm
 ++icAE+og4au9Y97ZTjK+3yCqogELRkckR8JRvE8mb55/UGef0nbfCEB844UJ658j2EZ
 9vr3Y2egMPGCtlCdTgKLpCmo12N7nEuy9f3SBdY7IkKoqL5oqRVVt4ZP43U0jH+ySrBw
 HQK6b043kxTaaOXje5IIY+VH4oonz+dOFT9v7XT6nlw0wFKEwJ76EGT9NJUusR5+iY8h
 t6afulWk5LZ9qDSUGkZ5tnzA0HmvAebV3QXiNQH2VfB6xhTceScsYngCAzhQmIyRVIrj
 Zy6w==
X-Gm-Message-State: AOAM533IsyZqzyej1S0U5fEbFSy1iNQyW0qLWvx0iePJbAQd+Psdysq+
 NScSSIi4u/W2LAH0Q4lIX1wLq6YzoYMSmW2iSwJrySA8
X-Google-Smtp-Source: ABdhPJwDbhHPQYskfGQONBcOZxVk7RZWDLY+XF73dt+GJvufpVW+LzeSr8uS4H71RqGbLXHxt72WZUewbGP/oNIyhV8=
X-Received: by 2002:a7b:cc0e:: with SMTP id f14mr1367597wmh.39.1589924061157; 
 Tue, 19 May 2020 14:34:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAEOHGOm=g_VGa5939Qi_HEXAfuUKuy3tXURx9TKg+n==dUDqPQ@mail.gmail.com>
 <CADnq5_N-vLuyqo_rqjy44nwdKPWyiO8cpAJN9pFk79wjwKi7gw@mail.gmail.com>
 <CAEOHGOkbu5jy_1_bUD4H0U89YEc_9zOxsSdyZqmtqZNsdOyDkg@mail.gmail.com>
 <CAEOHGOkRYXZWN-20VagBEFFywRT=26xphP3JQeQD4AJuxxzg+Q@mail.gmail.com>
 <CAEOHGOnPz2pWTrPPWS=-kN9O7RG21rL2iGwJYTSboh0d-5--Lw@mail.gmail.com>
In-Reply-To: <CAEOHGOnPz2pWTrPPWS=-kN9O7RG21rL2iGwJYTSboh0d-5--Lw@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 19 May 2020 17:34:09 -0400
Message-ID: <CADnq5_PH9t87pPNx=-_LxN+mVBJkz4yL2XSYTKJGGZV1FpE4fg@mail.gmail.com>
Subject: Re: slow rx 5600 xt fps
To: Javad Karabi <karabijavad@gmail.com>
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

On Tue, May 19, 2020 at 4:01 PM Javad Karabi <karabijavad@gmail.com> wrote:
>
> another tidbit:
> when in linux, the gpu's fans _never_ come on.
>
> even when i run 4 instances of glmark2, the fans do not come on :/
> i see the temp hitting just below 50 deg c, and i saw some value that
> says that 50c was the max?
> isnt 50c low for a max gpu temp?
>

Maybe you are not using the dGPU for most things.  Use something like
glxinfo to figure out which GPU you are using for different
situations.  E.g.,
glxinfo | grep renderer
vs
DRI_PRIME=1 glxinfo | grep renderer

Alex

>
> On Tue, May 19, 2020 at 2:44 PM Javad Karabi <karabijavad@gmail.com> wrote:
> >
> > just a couple more questions:
> >
> > - based on what you are aware of, the technical details such as
> > "shared buffers go through system memory", and all that, do you see
> > any issues that might exist that i might be missing in my setup? i
> > cant imagine this being the case because the card works great in
> > windows, unless the windows driver does something different?
> >
> > - as far as kernel config, is there anything in particular which
> > _should_ or _should not_ be enabled/disabled?
> >
> > - does the vendor matter? for instance, this is an xfx card. when it
> > comes to different vendors, are there interface changes that might
> > make one vendor work better for linux than another? i dont really
> > understand the differences in vendors, but i imagine that the vbios
> > differs between vendors, and as such, the linux compatibility would
> > maybe change?
> >
> > - is the pcie bandwidth possible an issue? the pcie_bw file changes
> > between values like this:
> > 18446683600662707640 18446744071581623085 128
> > and sometimes i see this:
> > 4096 0 128
> > as you can see, the second value seems significantly lower. is that
> > possibly an issue? possibly due to aspm?
> >
> > On Tue, May 19, 2020 at 2:20 PM Javad Karabi <karabijavad@gmail.com> wrote:
> > >
> > > im using Driver "amdgpu" in my xorg conf
> > >
> > > how does one verify which gpu is the primary? im assuming my intel
> > > card is the primary, since i have not done anything to change that.
> > >
> > > also, if all shared buffers have to go through system memory, then
> > > that means an eGPU amdgpu wont work very well in general right?
> > > because going through system memory for the egpu means going over the
> > > thunderbolt connection
> > >
> > > and what are the shared buffers youre referring to? for example, if an
> > > application is drawing to a buffer, is that an example of a shared
> > > buffer that has to go through system memory? if so, thats fine, right?
> > > because the application's memory is in system memory, so that copy
> > > wouldnt be an issue.
> > >
> > > in general, do you think the "copy buffer across system memory might
> > > be a hindrance for thunderbolt? im trying to figure out which
> > > directions to go to debug and im totally lost, so maybe i can do some
> > > testing that direction?
> > >
> > > and for what its worth, when i turn the display "off" via the gnome
> > > display settings, its the same issue as when the laptop lid is closed,
> > > so unless the motherboard reads the "closed lid" the same as "display
> > > off", then im not sure if its thermal issues.
> > >
> > > On Tue, May 19, 2020 at 2:14 PM Alex Deucher <alexdeucher@gmail.com> wrote:
> > > >
> > > > On Tue, May 19, 2020 at 2:59 PM Javad Karabi <karabijavad@gmail.com> wrote:
> > > > >
> > > > > given this setup:
> > > > > laptop -thunderbolt-> razer core x -> xfx rx 5600 xt raw 2 -hdmi-> monitor
> > > > > DRI_PRIME=1 glxgears gears gives me ~300fps
> > > > >
> > > > > given this setup:
> > > > > laptop -thunderbolt-> razer core x -> xfx rx 5600 xt raw 2
> > > > > laptop -hdmi-> monitor
> > > > >
> > > > > glx gears gives me ~1800fps
> > > > >
> > > > > this doesnt make sense to me because i thought that having the monitor
> > > > > plugged directly into the card should give best performance.
> > > > >
> > > >
> > > > Do you have displays connected to both GPUs?  If you are using X which
> > > > ddx are you using?  xf86-video-modesetting or xf86-video-amdgpu?
> > > > IIRC, xf86-video-amdgpu has some optimizations for prime which are not
> > > > yet in xf86-video-modesetting.  Which GPU is set up as the primary?
> > > > Note that the GPU which does the rendering is not necessarily the one
> > > > that the displays are attached to.  The render GPU renders to it's
> > > > render buffer and then that data may end up being copied other GPUs
> > > > for display.  Also, at this point, all shared buffers have to go
> > > > through system memory (this will be changing eventually now that we
> > > > support device memory via dma-buf), so there is often an extra copy
> > > > involved.
> > > >
> > > > > theres another really weird issue...
> > > > >
> > > > > given setup 1, where the monitor is plugged in to the card:
> > > > > when i close the laptop lid, my monitor is "active" and whatnot, and i
> > > > > can "use it" in a sense
> > > > >
> > > > > however, heres the weirdness:
> > > > > the mouse cursor will move along the monitor perfectly smooth and
> > > > > fine, but all the other updates to the screen are delayed by about 2
> > > > > or 3 seconds.
> > > > > that is to say, its as if the laptop is doing everything (e.g. if i
> > > > > open a terminal, the terminal will open, but it will take 2 seconds
> > > > > for me to see it)
> > > > >
> > > > > its almost as if all the frames and everything are being drawn, and
> > > > > the laptop is running fine and everything, but i simply just dont get
> > > > > to see it on the monitor, except for one time every 2 seconds.
> > > > >
> > > > > its hard to articulate, because its so bizarre. its not like, a "low
> > > > > fps" per se, because the cursor is totally smooth. but its that
> > > > > _everything else_ is only updated once every couple seconds.
> > > >
> > > > This might also be related to which GPU is the primary.  It still may
> > > > be the integrated GPU since that is what is attached to the laptop
> > > > panel.  Also the platform and some drivers may do certain things when
> > > > the lid is closed.  E.g., for thermal reasons, the integrated GPU or
> > > > CPU may have a more limited TDP because the laptop cannot cool as
> > > > efficiently.
> > > >
> > > > Alex
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
