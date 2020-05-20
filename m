Return-Path: <SRS0=vyzA=7C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F3FC433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2020 01:35:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 349982075F
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2020 01:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bOeGs25U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 349982075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEB156E10C;
	Wed, 20 May 2020 01:35:14 +0000 (UTC)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 494316E10C
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2020 01:35:14 +0000 (UTC)
Received: by mail-oo1-xc2b.google.com with SMTP id s139so403884oos.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2020 18:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=pUeJLinI6usvGecdWZEj1MG0nvAjeRBixW67OXgqLGw=;
 b=bOeGs25UIWSuyxDkB3UTBugic5cpG4+lfs9ampQB5LPK12PChS0ChvTN6lQHpf75Gh
 vmBi3cvFfnL5LWf16Pw7gxmi7AwDLs8Uw4DDIIas02d+okKVpMxg5wMIiNenCbycN7i4
 mdfYPUkPHxfo08Px2WR5idnNPXvBvVfQd01DNlqhpVo35uO0iomBVPsVwEKWBRwKUcir
 l+g/U+tCIjp4uNtOxGgFblBTeX7tBlgufadB6KImWcPqJy6nlmd9DhH/lATAXVl+Gw8S
 0dPRUvQnmIAob0dLwK7Ov6OsLXGp09Vdl82oLJtkoIEdqGHdZvdyHIxMijoVfiItJ/lV
 iILQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=pUeJLinI6usvGecdWZEj1MG0nvAjeRBixW67OXgqLGw=;
 b=iTOSdB98qjLIALKI1mspMeRQtTfGfIHbc61NIFnBzNuTPNkneN1wxk0zUqbYpcDsVR
 BbniRwpG0N+RddeRjrkSQCfkcNFaWoNcZZ0vEI7DboTZbUkz7UxRilb0e20jVCeKcgB3
 2DCQKNuvcK6Pnhu5v1px7HEpnmb49O3R31h/DSG8ERVtdJBg4x5f08wmjGDHDQRCtUzt
 0n5DBEWQYzwR5UD9/YZ4IJkQZMipZPSlqAEM7BA4uT2RkuhaOzaSLT3vr/nUg6KkYED4
 om1T2YH1WyAd0pfE+T2n0P2lcEmyoAgsyk2NVS0ac5ZXcinUgMWDZDQNF/I6g/QUpQa3
 +N2w==
X-Gm-Message-State: AOAM532UU3uHtLbvyC8Bdb+sS5kLR5xq8ydoDqUWzD4s9UuoIjoNHps5
 TVoY0aQr6eF0eqwBKRRCG4ImNNj9hJvnH0zjems=
X-Google-Smtp-Source: ABdhPJzQe9xSNjKlyt6MiQXUC6NalKta1GgAnP9tHX451h6e8GT1doD5IOt7lOBwsVzl6xrFnP63ymgtsFazFn2jeOM=
X-Received: by 2002:a4a:88e4:: with SMTP id q33mr1343916ooh.27.1589938513253; 
 Tue, 19 May 2020 18:35:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAEOHGOm=g_VGa5939Qi_HEXAfuUKuy3tXURx9TKg+n==dUDqPQ@mail.gmail.com>
 <CADnq5_N-vLuyqo_rqjy44nwdKPWyiO8cpAJN9pFk79wjwKi7gw@mail.gmail.com>
 <CAEOHGOkbu5jy_1_bUD4H0U89YEc_9zOxsSdyZqmtqZNsdOyDkg@mail.gmail.com>
 <CAEOHGOkRYXZWN-20VagBEFFywRT=26xphP3JQeQD4AJuxxzg+Q@mail.gmail.com>
 <CADnq5_Nc+eoCKsQrHA-u0d7trv=MM=5iKv5G1R3TMCyot40OjA@mail.gmail.com>
 <CAEOHGOk-YO_B3gS7WayrBEAO4oxrUAGtR0o9ZzW8ehOypuc1YA@mail.gmail.com>
 <CADnq5_M2R93S6aQn8XtrC_JdHhB=ajC17D780koNvdnDFbWCpA@mail.gmail.com>
 <CAEOHGO=Tgook7i5R5Ucxn3Pg4ovZe+Fak5rntZ2P+UuwDJ+-Vg@mail.gmail.com>
 <DM6PR12MB3097F4ACE6F41E4EE925BD4FE8B60@DM6PR12MB3097.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB3097F4ACE6F41E4EE925BD4FE8B60@DM6PR12MB3097.namprd12.prod.outlook.com>
From: Javad Karabi <karabijavad@gmail.com>
Date: Tue, 19 May 2020 20:35:02 -0500
Message-ID: <CAEOHGOnFB-OVDqNkzgxmKkhVzjMnd4Pqk5mXmvfgi4muvU-5yg@mail.gmail.com>
Subject: Re: slow rx 5600 xt fps
To: "Bridgman, John" <John.Bridgman@amd.com>
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
Cc: Alex Deucher <alexdeucher@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

John,

yea, totally agree with you.
one other thing i havent mentioned is that, each time, ive also been
testing everything by running dota 2 with graphics settings all the
way up. and the behavior in dota2 has been consistent

its funny: when i run dota 2, it consistently hovers at 40fps, but the
weird thing is that with graphics settings all the way low, or
graphics settings all the way up, it sticks to 40fps. regardless of
vsync on / off.
i didnt mention my testing of dota 2 because i figured that glxgears
would summarize the issue best, but i do understand what you mean by
trying a more demanding test.
ive also been testing with glmark2, and it would only give 300-400fps too

heres an example:

$ vblank_mode=0 DRI_PRIME=1 glmark2
ATTENTION: default value of option vblank_mode overridden by environment.
ATTENTION: option value of option vblank_mode ignored.
=======================================================
    glmark2 2014.03+git20150611.fa71af2d
=======================================================
    OpenGL Information
    GL_VENDOR:     X.Org
    GL_RENDERER:   AMD Radeon RX 5600 XT (NAVI10, DRM 3.36.0,
5.6.13-karabijavad, LLVM 9.0.1)
    GL_VERSION:    4.6 (Compatibility Profile) Mesa 20.0.4
=======================================================
[build] use-vbo=false: FPS: 128 FrameTime: 7.812 ms
[build] use-vbo=true: FPS: 129 FrameTime: 7.752 ms



On Tue, May 19, 2020 at 8:20 PM Bridgman, John <John.Bridgman@amd.com> wrote:
>
> [AMD Official Use Only - Internal Distribution Only]
>
>
> Suggest you use something more demanding that glxgears as a test - part of the problem is that glxgears runs so fast normally (30x faster than your display) that even a small amount of overhead copying a frame from one place to another makes a huge difference in FPS.
>
> If you use a test program that normally runs at 90 FPS you'll probably find that the "slow" speed is something like 85 FPS, rather than the 6:1 difference you see with glxgears.
>
> ________________________________
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Javad Karabi <karabijavad@gmail.com>
> Sent: May 19, 2020 9:16 PM
> To: Alex Deucher <alexdeucher@gmail.com>
> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
> Subject: Re: slow rx 5600 xt fps
>
> thanks for the answers alex.
>
> so, i went ahead and got a displayport cable to see if that changes
> anything. and now, when i run monitor only, and the monitor connected
> to the card, it has no issues like before! so i am thinking that
> somethings up with either the hdmi cable, or some hdmi related setting
> in my system? who knows, but im just gonna roll with only using
> displayport cables now.
> the previous hdmi cable was actually pretty long, because i was
> extending it with an hdmi extension cable, so maybe the signal was
> really bad or something :/
>
> but yea, i guess the only real issue now is maybe something simple
> related to some sysfs entry about enabling some powermode, voltage,
> clock frequency, or something, so that glxgears will give me more than
> 300 fps. but atleast now i can use a single monitor configuration with
> the monitor displayported up to the card.
>
> also, one other thing i think you might be interested in, that was
> happening before.
>
> so, previously, with laptop -tb3-> egpu-hdmi> monitor, there was a
> funny thing happening which i never could figure out.
> when i would look at the X logs, i would see that "modesetting" (for
> the intel integrated graphics) was reporting that MonitorA was used
> with "eDP-1",  which is correct and what i expected.
> when i scrolled further down, i then saw that "HDMI-A-1-2" was being
> used for another MonitorB, which also is what i expected (albeit i
> have no idea why its saying A-1-2)
> but amdgpu was _also_ saying that DisplayPort-1-2 (a port on the
> radeon card) was being used for MonitorA, which is the same Monitor
> that the modesetting driver had claimed to be using with eDP-1!
>
> so the point is that amdgpu was "using" Monitor0 with DisplayPort-1-2,
> although that is what modesetting was using for eDP-1.
>
> anyway, thats a little aside, i doubt it was related to the terrible
> hdmi experience i was getting, since its about display port and stuff,
> but i thought id let you know about that.
>
> if you think that is a possible issue, im more than happy to plug the
> hdmi setup back in and create an issue on gitlab with the logs and
> everything
>
> On Tue, May 19, 2020 at 4:42 PM Alex Deucher <alexdeucher@gmail.com> wrote:
> >
> > On Tue, May 19, 2020 at 5:22 PM Javad Karabi <karabijavad@gmail.com> wrote:
> > >
> > > lol youre quick!
> > >
> > > "Windows has supported peer to peer DMA for years so it already has a
> > > numbers of optimizations that are only now becoming possible on Linux"
> > >
> > > whoa, i figured linux would be ahead of windows when it comes to
> > > things like that. but peer-to-peer dma is something that is only
> > > recently possible on linux, but has been possible on windows? what
> > > changed recently that allows for peer to peer dma in linux?
> > >
> >
> > A few things that made this more complicated on Linux:
> > 1. Linux uses IOMMUs more extensively than windows so you can't just
> > pass around physical bus addresses.
> > 2. Linux supports lots of strange architectures that have a lot of
> > limitations with respect to peer to peer transactions
> >
> > It just took years to get all the necessary bits in place in Linux and
> > make everyone happy.
> >
> > > also, in the context of a game running opengl on some gpu, is the
> > > "peer-to-peer" dma transfer something like: the game draw's to some
> > > memory it has allocated, then a DMA transfer gets that and moves it
> > > into the graphics card output?
> >
> > Peer to peer DMA just lets devices access another devices local memory
> > directly.  So if you have a buffer in vram on one device, you can
> > share that directly with another device rather than having to copy it
> > to system memory first.  For example, if you have two GPUs, you can
> > have one of them copy it's content directly to a buffer in the other
> > GPU's vram rather than having to go through system memory first.
> >
> > >
> > > also, i know it can be super annoying trying to debug an issue like
> > > this, with someone like me who has all types of differences from a
> > > normal setup (e.g. using it via egpu, using a kernel with custom
> > > configs and stuff) so as a token of my appreciation i donated 50$ to
> > > the red cross' corona virus outbreak charity thing, on behalf of
> > > amd-gfx.
> >
> > Thanks,
> >
> > Alex
> >
> > >
> > > On Tue, May 19, 2020 at 4:13 PM Alex Deucher <alexdeucher@gmail.com> wrote:
> > > >
> > > > On Tue, May 19, 2020 at 3:44 PM Javad Karabi <karabijavad@gmail.com> wrote:
> > > > >
> > > > > just a couple more questions:
> > > > >
> > > > > - based on what you are aware of, the technical details such as
> > > > > "shared buffers go through system memory", and all that, do you see
> > > > > any issues that might exist that i might be missing in my setup? i
> > > > > cant imagine this being the case because the card works great in
> > > > > windows, unless the windows driver does something different?
> > > > >
> > > >
> > > > Windows has supported peer to peer DMA for years so it already has a
> > > > numbers of optimizations that are only now becoming possible on Linux.
> > > >
> > > > > - as far as kernel config, is there anything in particular which
> > > > > _should_ or _should not_ be enabled/disabled?
> > > >
> > > > You'll need the GPU drivers for your devices and dma-buf support.
> > > >
> > > > >
> > > > > - does the vendor matter? for instance, this is an xfx card. when it
> > > > > comes to different vendors, are there interface changes that might
> > > > > make one vendor work better for linux than another? i dont really
> > > > > understand the differences in vendors, but i imagine that the vbios
> > > > > differs between vendors, and as such, the linux compatibility would
> > > > > maybe change?
> > > >
> > > > board vendor shouldn't matter.
> > > >
> > > > >
> > > > > - is the pcie bandwidth possible an issue? the pcie_bw file changes
> > > > > between values like this:
> > > > > 18446683600662707640 18446744071581623085 128
> > > > > and sometimes i see this:
> > > > > 4096 0 128
> > > > > as you can see, the second value seems significantly lower. is that
> > > > > possibly an issue? possibly due to aspm?
> > > >
> > > > pcie_bw is not implemented for navi yet so you are just seeing
> > > > uninitialized data.  This patch set should clear that up.
> > > > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatchwork.freedesktop.org%2Fpatch%2F366262%2F&amp;data=02%7C01%7Cjohn.bridgman%40amd.com%7C07bde460768d4af97a0a08d7fc5b7e3f%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637255342498350409&amp;sdata=LnoK84DCjYelteqMR7w2UZ2VH6lM0vojz9eeTH7odXI%3D&amp;reserved=0
> > > >
> > > > Alex
> > > >
> > > > >
> > > > > On Tue, May 19, 2020 at 2:20 PM Javad Karabi <karabijavad@gmail.com> wrote:
> > > > > >
> > > > > > im using Driver "amdgpu" in my xorg conf
> > > > > >
> > > > > > how does one verify which gpu is the primary? im assuming my intel
> > > > > > card is the primary, since i have not done anything to change that.
> > > > > >
> > > > > > also, if all shared buffers have to go through system memory, then
> > > > > > that means an eGPU amdgpu wont work very well in general right?
> > > > > > because going through system memory for the egpu means going over the
> > > > > > thunderbolt connection
> > > > > >
> > > > > > and what are the shared buffers youre referring to? for example, if an
> > > > > > application is drawing to a buffer, is that an example of a shared
> > > > > > buffer that has to go through system memory? if so, thats fine, right?
> > > > > > because the application's memory is in system memory, so that copy
> > > > > > wouldnt be an issue.
> > > > > >
> > > > > > in general, do you think the "copy buffer across system memory might
> > > > > > be a hindrance for thunderbolt? im trying to figure out which
> > > > > > directions to go to debug and im totally lost, so maybe i can do some
> > > > > > testing that direction?
> > > > > >
> > > > > > and for what its worth, when i turn the display "off" via the gnome
> > > > > > display settings, its the same issue as when the laptop lid is closed,
> > > > > > so unless the motherboard reads the "closed lid" the same as "display
> > > > > > off", then im not sure if its thermal issues.
> > > > > >
> > > > > > On Tue, May 19, 2020 at 2:14 PM Alex Deucher <alexdeucher@gmail.com> wrote:
> > > > > > >
> > > > > > > On Tue, May 19, 2020 at 2:59 PM Javad Karabi <karabijavad@gmail.com> wrote:
> > > > > > > >
> > > > > > > > given this setup:
> > > > > > > > laptop -thunderbolt-> razer core x -> xfx rx 5600 xt raw 2 -hdmi-> monitor
> > > > > > > > DRI_PRIME=1 glxgears gears gives me ~300fps
> > > > > > > >
> > > > > > > > given this setup:
> > > > > > > > laptop -thunderbolt-> razer core x -> xfx rx 5600 xt raw 2
> > > > > > > > laptop -hdmi-> monitor
> > > > > > > >
> > > > > > > > glx gears gives me ~1800fps
> > > > > > > >
> > > > > > > > this doesnt make sense to me because i thought that having the monitor
> > > > > > > > plugged directly into the card should give best performance.
> > > > > > > >
> > > > > > >
> > > > > > > Do you have displays connected to both GPUs?  If you are using X which
> > > > > > > ddx are you using?  xf86-video-modesetting or xf86-video-amdgpu?
> > > > > > > IIRC, xf86-video-amdgpu has some optimizations for prime which are not
> > > > > > > yet in xf86-video-modesetting.  Which GPU is set up as the primary?
> > > > > > > Note that the GPU which does the rendering is not necessarily the one
> > > > > > > that the displays are attached to.  The render GPU renders to it's
> > > > > > > render buffer and then that data may end up being copied other GPUs
> > > > > > > for display.  Also, at this point, all shared buffers have to go
> > > > > > > through system memory (this will be changing eventually now that we
> > > > > > > support device memory via dma-buf), so there is often an extra copy
> > > > > > > involved.
> > > > > > >
> > > > > > > > theres another really weird issue...
> > > > > > > >
> > > > > > > > given setup 1, where the monitor is plugged in to the card:
> > > > > > > > when i close the laptop lid, my monitor is "active" and whatnot, and i
> > > > > > > > can "use it" in a sense
> > > > > > > >
> > > > > > > > however, heres the weirdness:
> > > > > > > > the mouse cursor will move along the monitor perfectly smooth and
> > > > > > > > fine, but all the other updates to the screen are delayed by about 2
> > > > > > > > or 3 seconds.
> > > > > > > > that is to say, its as if the laptop is doing everything (e.g. if i
> > > > > > > > open a terminal, the terminal will open, but it will take 2 seconds
> > > > > > > > for me to see it)
> > > > > > > >
> > > > > > > > its almost as if all the frames and everything are being drawn, and
> > > > > > > > the laptop is running fine and everything, but i simply just dont get
> > > > > > > > to see it on the monitor, except for one time every 2 seconds.
> > > > > > > >
> > > > > > > > its hard to articulate, because its so bizarre. its not like, a "low
> > > > > > > > fps" per se, because the cursor is totally smooth. but its that
> > > > > > > > _everything else_ is only updated once every couple seconds.
> > > > > > >
> > > > > > > This might also be related to which GPU is the primary.  It still may
> > > > > > > be the integrated GPU since that is what is attached to the laptop
> > > > > > > panel.  Also the platform and some drivers may do certain things when
> > > > > > > the lid is closed.  E.g., for thermal reasons, the integrated GPU or
> > > > > > > CPU may have a more limited TDP because the laptop cannot cool as
> > > > > > > efficiently.
> > > > > > >
> > > > > > > Alex
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cjohn.bridgman%40amd.com%7C07bde460768d4af97a0a08d7fc5b7e3f%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637255342498350409&amp;sdata=h%2BvYNKSx6vPQ5PNDKW2dBO3I4oEr3wV%2FkyLHJv08e6A%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
