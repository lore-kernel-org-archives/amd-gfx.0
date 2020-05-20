Return-Path: <SRS0=vyzA=7C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D70C433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2020 22:05:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E995920873
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2020 22:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cvc4YH2J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E995920873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9405D89C5E;
	Wed, 20 May 2020 22:05:05 +0000 (UTC)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6CAC89C5E
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2020 22:05:04 +0000 (UTC)
Received: by mail-oi1-x229.google.com with SMTP id l6so4361025oic.9
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2020 15:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HTU65Vxf14X6DFUm2eX6u2PY4wOICAtGoXIGyrK40qU=;
 b=Cvc4YH2JtXZXCjHoZQAIESAeOfeJKgPq4omVc6Hbtx7IUakLzom6Nl9c1o1PIq9Jr8
 PBhySWDKI77S54AqCSSNrZG0a0OGVz/iYh5ySRjjCYTKrtRyg9CCk5PzXAScmkibkovv
 7maD4wK2OxqabDfxu57I7chQgyqX7VWFI8yVOPsS+rJFttwl4NDe+EaJ9L28lgSEzxdt
 DIk0yOMYG+BkgMh7paKyQnhjt7ChL+kWuK0Vt6T0OGENtjjiG3TXAGNqSknsU9FnFXdJ
 Y15nGeGJFCxg7A0ha9unEdIM+P/TLvGYq2zbNmDXmlE08NonatDoNoQq0TXNifhOh3xd
 3SoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HTU65Vxf14X6DFUm2eX6u2PY4wOICAtGoXIGyrK40qU=;
 b=N21glQiAuIp1RYqfKRFB1eULf2gTKWLA4ULj4cSze9wY+aVyIb2Q1fFRBKDZ11bpr/
 Q6tDZXM1qmBmAQa05xfLKGiwxIrjsNrmbwLW6HMZjEcFfoPAqy8/ejHwQ4u+4Z+bQS+q
 o7vGnnHeLs1HFzECWvZj/dWOc6GjHRCPFLKXsxFnBYqOtY8bja57crOvGvN1E7Bh1Qk+
 r9WnzIa8d54MpNsmry9YZ/fM5dH/wq0FbBD03zlrP5hLQRAdfqfrK4KoMyFzwNrTIAYB
 6GVEogxPIWpsDst128rAN849bt249TZiwzJbp6ahqN2FzkEhB2p4zAhKQP4HV77wGYWZ
 DGig==
X-Gm-Message-State: AOAM532o9GmIpQdEIhS0kXDinpiHRYrrWmJza+16aP2ZYssACWTbcE6b
 bVWF2i0aFMxLZMVAOyuM9vr3NE6W6kuHJoS/wQk=
X-Google-Smtp-Source: ABdhPJwtQa3PSyHf9lHeGbCwkoKGxYAucFtxK7rQ1/s4HH6e5m12/iW+hlxWNCDcBI2S89n4ynVyR6tSC0bI/jYrIls=
X-Received: by 2002:aca:3008:: with SMTP id w8mr4767352oiw.157.1590012303481; 
 Wed, 20 May 2020 15:05:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAEOHGOm=g_VGa5939Qi_HEXAfuUKuy3tXURx9TKg+n==dUDqPQ@mail.gmail.com>
 <CADnq5_N-vLuyqo_rqjy44nwdKPWyiO8cpAJN9pFk79wjwKi7gw@mail.gmail.com>
 <CAEOHGOkbu5jy_1_bUD4H0U89YEc_9zOxsSdyZqmtqZNsdOyDkg@mail.gmail.com>
 <CAEOHGOkRYXZWN-20VagBEFFywRT=26xphP3JQeQD4AJuxxzg+Q@mail.gmail.com>
 <CADnq5_Nc+eoCKsQrHA-u0d7trv=MM=5iKv5G1R3TMCyot40OjA@mail.gmail.com>
 <CAEOHGOk-YO_B3gS7WayrBEAO4oxrUAGtR0o9ZzW8ehOypuc1YA@mail.gmail.com>
 <CADnq5_M2R93S6aQn8XtrC_JdHhB=ajC17D780koNvdnDFbWCpA@mail.gmail.com>
 <CAEOHGO=Tgook7i5R5Ucxn3Pg4ovZe+Fak5rntZ2P+UuwDJ+-Vg@mail.gmail.com>
 <CADnq5_Mef-FCri1_wriYgvmnkTNQpxaUfba9_hLSB-yVQHU9cQ@mail.gmail.com>
In-Reply-To: <CADnq5_Mef-FCri1_wriYgvmnkTNQpxaUfba9_hLSB-yVQHU9cQ@mail.gmail.com>
From: Javad Karabi <karabijavad@gmail.com>
Date: Wed, 20 May 2020 17:04:52 -0500
Message-ID: <CAEOHGOm+ooti4JX6OD2zd7rOxbAVn1yQ22TwgS0hmiy8Ssf-Kg@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="===============1521195657=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1521195657==
Content-Type: multipart/alternative; boundary="00000000000089a4c705a61b96d3"

--00000000000089a4c705a61b96d3
Content-Type: text/plain; charset="UTF-8"

Thanks Alex,
Here's my plan:

since my laptop's os is pretty customized, e.g. compiling my own kernel,
building latest xorg, latest xorg-driver-amdgpu, etc etc,
im going to use the intel iommu and pass through my rx 5600 into a virtual
machine, which will be a 100% stock ubuntu installation.
then, inside that vm, i will continue to debug

does that sound like it would make sense for testing? for example, with
that scenario, it adds the iommu into the mix, so who knows if that causes
performance issues. but i think its worth a shot, to see if a stock kernel
will handle it better

also, quick question:
from what i understand, a thunderbolt 3 pci express connection should
handle 8 GT/s x4, however, along the chain of bridges to my device, i
notice that the bridge closest to the graphics card is at 2.5 GT/s x4, and
it also says "downgraded" (this is via the lspci output)

now, when i boot into windows, it _also_ says 2.5 GT/s x4, and it runs
extremely well. no issues at all.

so my question is: the fact that the bridge is at 2.5 GT/s x4, and not at
its theoretical "full link speed" of 8 GT/s x4, do you suppose that _could_
be an issue?
i do not think so, because, like i said, in windows it also reports that
link speed.
i would assume that you would want the fastest link speed possible, because
i would assume that of _all_ tb3 pci express devices, a GPU would be the #1
most demanding on the link

just curious if you think 2.5 GT/s could be the bottleneck

i will pass through the device into a ubuntu vm and let you know how it
goes. thanks



On Tue, May 19, 2020 at 9:29 PM Alex Deucher <alexdeucher@gmail.com> wrote:

> On Tue, May 19, 2020 at 9:16 PM Javad Karabi <karabijavad@gmail.com>
> wrote:
> >
> > thanks for the answers alex.
> >
> > so, i went ahead and got a displayport cable to see if that changes
> > anything. and now, when i run monitor only, and the monitor connected
> > to the card, it has no issues like before! so i am thinking that
> > somethings up with either the hdmi cable, or some hdmi related setting
> > in my system? who knows, but im just gonna roll with only using
> > displayport cables now.
> > the previous hdmi cable was actually pretty long, because i was
> > extending it with an hdmi extension cable, so maybe the signal was
> > really bad or something :/
> >
> > but yea, i guess the only real issue now is maybe something simple
> > related to some sysfs entry about enabling some powermode, voltage,
> > clock frequency, or something, so that glxgears will give me more than
> > 300 fps. but atleast now i can use a single monitor configuration with
> > the monitor displayported up to the card.
> >
>
> The GPU dynamically adjusts the clocks and voltages based on load.  No
> manual configuration is required.
>
> At this point, we probably need to see you xorg log and dmesg output
> to try and figure out exactly what is going on.  I still suspect there
> is some interaction going on with both GPUs and the integrated GPU
> being the primary, so as I mentioned before, you should try and run X
> on just the amdgpu rather than trying to use both of them.
>
> Alex
>
>
> > also, one other thing i think you might be interested in, that was
> > happening before.
> >
> > so, previously, with laptop -tb3-> egpu-hdmi> monitor, there was a
> > funny thing happening which i never could figure out.
> > when i would look at the X logs, i would see that "modesetting" (for
> > the intel integrated graphics) was reporting that MonitorA was used
> > with "eDP-1",  which is correct and what i expected.
> > when i scrolled further down, i then saw that "HDMI-A-1-2" was being
> > used for another MonitorB, which also is what i expected (albeit i
> > have no idea why its saying A-1-2)
> > but amdgpu was _also_ saying that DisplayPort-1-2 (a port on the
> > radeon card) was being used for MonitorA, which is the same Monitor
> > that the modesetting driver had claimed to be using with eDP-1!
> >
> > so the point is that amdgpu was "using" Monitor0 with DisplayPort-1-2,
> > although that is what modesetting was using for eDP-1.
> >
> > anyway, thats a little aside, i doubt it was related to the terrible
> > hdmi experience i was getting, since its about display port and stuff,
> > but i thought id let you know about that.
> >
> > if you think that is a possible issue, im more than happy to plug the
> > hdmi setup back in and create an issue on gitlab with the logs and
> > everything
> >
> > On Tue, May 19, 2020 at 4:42 PM Alex Deucher <alexdeucher@gmail.com>
> wrote:
> > >
> > > On Tue, May 19, 2020 at 5:22 PM Javad Karabi <karabijavad@gmail.com>
> wrote:
> > > >
> > > > lol youre quick!
> > > >
> > > > "Windows has supported peer to peer DMA for years so it already has a
> > > > numbers of optimizations that are only now becoming possible on
> Linux"
> > > >
> > > > whoa, i figured linux would be ahead of windows when it comes to
> > > > things like that. but peer-to-peer dma is something that is only
> > > > recently possible on linux, but has been possible on windows? what
> > > > changed recently that allows for peer to peer dma in linux?
> > > >
> > >
> > > A few things that made this more complicated on Linux:
> > > 1. Linux uses IOMMUs more extensively than windows so you can't just
> > > pass around physical bus addresses.
> > > 2. Linux supports lots of strange architectures that have a lot of
> > > limitations with respect to peer to peer transactions
> > >
> > > It just took years to get all the necessary bits in place in Linux and
> > > make everyone happy.
> > >
> > > > also, in the context of a game running opengl on some gpu, is the
> > > > "peer-to-peer" dma transfer something like: the game draw's to some
> > > > memory it has allocated, then a DMA transfer gets that and moves it
> > > > into the graphics card output?
> > >
> > > Peer to peer DMA just lets devices access another devices local memory
> > > directly.  So if you have a buffer in vram on one device, you can
> > > share that directly with another device rather than having to copy it
> > > to system memory first.  For example, if you have two GPUs, you can
> > > have one of them copy it's content directly to a buffer in the other
> > > GPU's vram rather than having to go through system memory first.
> > >
> > > >
> > > > also, i know it can be super annoying trying to debug an issue like
> > > > this, with someone like me who has all types of differences from a
> > > > normal setup (e.g. using it via egpu, using a kernel with custom
> > > > configs and stuff) so as a token of my appreciation i donated 50$ to
> > > > the red cross' corona virus outbreak charity thing, on behalf of
> > > > amd-gfx.
> > >
> > > Thanks,
> > >
> > > Alex
> > >
> > > >
> > > > On Tue, May 19, 2020 at 4:13 PM Alex Deucher <alexdeucher@gmail.com>
> wrote:
> > > > >
> > > > > On Tue, May 19, 2020 at 3:44 PM Javad Karabi <
> karabijavad@gmail.com> wrote:
> > > > > >
> > > > > > just a couple more questions:
> > > > > >
> > > > > > - based on what you are aware of, the technical details such as
> > > > > > "shared buffers go through system memory", and all that, do you
> see
> > > > > > any issues that might exist that i might be missing in my setup?
> i
> > > > > > cant imagine this being the case because the card works great in
> > > > > > windows, unless the windows driver does something different?
> > > > > >
> > > > >
> > > > > Windows has supported peer to peer DMA for years so it already has
> a
> > > > > numbers of optimizations that are only now becoming possible on
> Linux.
> > > > >
> > > > > > - as far as kernel config, is there anything in particular which
> > > > > > _should_ or _should not_ be enabled/disabled?
> > > > >
> > > > > You'll need the GPU drivers for your devices and dma-buf support.
> > > > >
> > > > > >
> > > > > > - does the vendor matter? for instance, this is an xfx card.
> when it
> > > > > > comes to different vendors, are there interface changes that
> might
> > > > > > make one vendor work better for linux than another? i dont really
> > > > > > understand the differences in vendors, but i imagine that the
> vbios
> > > > > > differs between vendors, and as such, the linux compatibility
> would
> > > > > > maybe change?
> > > > >
> > > > > board vendor shouldn't matter.
> > > > >
> > > > > >
> > > > > > - is the pcie bandwidth possible an issue? the pcie_bw file
> changes
> > > > > > between values like this:
> > > > > > 18446683600662707640 18446744071581623085 128
> > > > > > and sometimes i see this:
> > > > > > 4096 0 128
> > > > > > as you can see, the second value seems significantly lower. is
> that
> > > > > > possibly an issue? possibly due to aspm?
> > > > >
> > > > > pcie_bw is not implemented for navi yet so you are just seeing
> > > > > uninitialized data.  This patch set should clear that up.
> > > > > https://patchwork.freedesktop.org/patch/366262/
> > > > >
> > > > > Alex
> > > > >
> > > > > >
> > > > > > On Tue, May 19, 2020 at 2:20 PM Javad Karabi <
> karabijavad@gmail.com> wrote:
> > > > > > >
> > > > > > > im using Driver "amdgpu" in my xorg conf
> > > > > > >
> > > > > > > how does one verify which gpu is the primary? im assuming my
> intel
> > > > > > > card is the primary, since i have not done anything to change
> that.
> > > > > > >
> > > > > > > also, if all shared buffers have to go through system memory,
> then
> > > > > > > that means an eGPU amdgpu wont work very well in general right?
> > > > > > > because going through system memory for the egpu means going
> over the
> > > > > > > thunderbolt connection
> > > > > > >
> > > > > > > and what are the shared buffers youre referring to? for
> example, if an
> > > > > > > application is drawing to a buffer, is that an example of a
> shared
> > > > > > > buffer that has to go through system memory? if so, thats
> fine, right?
> > > > > > > because the application's memory is in system memory, so that
> copy
> > > > > > > wouldnt be an issue.
> > > > > > >
> > > > > > > in general, do you think the "copy buffer across system memory
> might
> > > > > > > be a hindrance for thunderbolt? im trying to figure out which
> > > > > > > directions to go to debug and im totally lost, so maybe i can
> do some
> > > > > > > testing that direction?
> > > > > > >
> > > > > > > and for what its worth, when i turn the display "off" via the
> gnome
> > > > > > > display settings, its the same issue as when the laptop lid is
> closed,
> > > > > > > so unless the motherboard reads the "closed lid" the same as
> "display
> > > > > > > off", then im not sure if its thermal issues.
> > > > > > >
> > > > > > > On Tue, May 19, 2020 at 2:14 PM Alex Deucher <
> alexdeucher@gmail.com> wrote:
> > > > > > > >
> > > > > > > > On Tue, May 19, 2020 at 2:59 PM Javad Karabi <
> karabijavad@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > given this setup:
> > > > > > > > > laptop -thunderbolt-> razer core x -> xfx rx 5600 xt raw 2
> -hdmi-> monitor
> > > > > > > > > DRI_PRIME=1 glxgears gears gives me ~300fps
> > > > > > > > >
> > > > > > > > > given this setup:
> > > > > > > > > laptop -thunderbolt-> razer core x -> xfx rx 5600 xt raw 2
> > > > > > > > > laptop -hdmi-> monitor
> > > > > > > > >
> > > > > > > > > glx gears gives me ~1800fps
> > > > > > > > >
> > > > > > > > > this doesnt make sense to me because i thought that having
> the monitor
> > > > > > > > > plugged directly into the card should give best
> performance.
> > > > > > > > >
> > > > > > > >
> > > > > > > > Do you have displays connected to both GPUs?  If you are
> using X which
> > > > > > > > ddx are you using?  xf86-video-modesetting or
> xf86-video-amdgpu?
> > > > > > > > IIRC, xf86-video-amdgpu has some optimizations for prime
> which are not
> > > > > > > > yet in xf86-video-modesetting.  Which GPU is set up as the
> primary?
> > > > > > > > Note that the GPU which does the rendering is not
> necessarily the one
> > > > > > > > that the displays are attached to.  The render GPU renders
> to it's
> > > > > > > > render buffer and then that data may end up being copied
> other GPUs
> > > > > > > > for display.  Also, at this point, all shared buffers have
> to go
> > > > > > > > through system memory (this will be changing eventually now
> that we
> > > > > > > > support device memory via dma-buf), so there is often an
> extra copy
> > > > > > > > involved.
> > > > > > > >
> > > > > > > > > theres another really weird issue...
> > > > > > > > >
> > > > > > > > > given setup 1, where the monitor is plugged in to the card:
> > > > > > > > > when i close the laptop lid, my monitor is "active" and
> whatnot, and i
> > > > > > > > > can "use it" in a sense
> > > > > > > > >
> > > > > > > > > however, heres the weirdness:
> > > > > > > > > the mouse cursor will move along the monitor perfectly
> smooth and
> > > > > > > > > fine, but all the other updates to the screen are delayed
> by about 2
> > > > > > > > > or 3 seconds.
> > > > > > > > > that is to say, its as if the laptop is doing everything
> (e.g. if i
> > > > > > > > > open a terminal, the terminal will open, but it will take
> 2 seconds
> > > > > > > > > for me to see it)
> > > > > > > > >
> > > > > > > > > its almost as if all the frames and everything are being
> drawn, and
> > > > > > > > > the laptop is running fine and everything, but i simply
> just dont get
> > > > > > > > > to see it on the monitor, except for one time every 2
> seconds.
> > > > > > > > >
> > > > > > > > > its hard to articulate, because its so bizarre. its not
> like, a "low
> > > > > > > > > fps" per se, because the cursor is totally smooth. but its
> that
> > > > > > > > > _everything else_ is only updated once every couple
> seconds.
> > > > > > > >
> > > > > > > > This might also be related to which GPU is the primary.  It
> still may
> > > > > > > > be the integrated GPU since that is what is attached to the
> laptop
> > > > > > > > panel.  Also the platform and some drivers may do certain
> things when
> > > > > > > > the lid is closed.  E.g., for thermal reasons, the
> integrated GPU or
> > > > > > > > CPU may have a more limited TDP because the laptop cannot
> cool as
> > > > > > > > efficiently.
> > > > > > > >
> > > > > > > > Alex
>

--00000000000089a4c705a61b96d3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks Alex,<div>Here&#39;s my plan:</div><div><br></div><=
div>since my laptop&#39;s os is pretty customized, e.g. compiling my own ke=
rnel, building latest xorg, latest xorg-driver-amdgpu, etc etc,</div><div>i=
m going to use the intel iommu and pass through my rx 5600 into a virtual m=
achine, which will be a 100% stock ubuntu installation.</div><div>then, ins=
ide that vm, i will continue to debug</div><div><br></div><div>does that so=
und like it would make sense for testing? for example, with that scenario, =
it adds the iommu into the mix, so who knows if that causes performance iss=
ues. but i think its worth a shot, to see if a stock kernel will handle it =
better</div><div><br></div><div>also, quick question:</div><div>from what i=
 understand, a thunderbolt 3 pci express connection should handle 8 GT/s x4=
, however, along the chain of bridges to my device, i notice that the bridg=
e closest to the graphics card is at 2.5 GT/s x4, and it also says &quot;do=
wngraded&quot; (this is via the lspci output)</div><div><br></div><div>now,=
 when i boot into windows, it _also_ says 2.5 GT/s x4, and it runs extremel=
y well. no issues at all.</div><div><br></div><div>so my question is: the f=
act that the bridge is at 2.5 GT/s x4, and not at its theoretical &quot;ful=
l link speed&quot; of 8 GT/s x4, do you suppose that _could_ be an issue?</=
div><div>i do not think so, because, like i said, in windows it also report=
s that link speed.=C2=A0</div><div>i would assume that you would want the f=
astest link speed possible, because i would assume that of _all_ tb3 pci ex=
press devices, a GPU would be the #1 most demanding on the link</div><div><=
br></div><div>just curious if you think 2.5 GT/s could be the bottleneck</d=
iv><div><br></div><div>i will pass through the device into a ubuntu vm and =
let you know how it goes. thanks</div><div><br></div></div><div><div dir=3D=
"auto"><br></div></div><div><br><div class=3D"gmail_quote"><div dir=3D"ltr"=
 class=3D"gmail_attr">On Tue, May 19, 2020 at 9:29 PM Alex Deucher &lt;<a h=
ref=3D"mailto:alexdeucher@gmail.com" target=3D"_blank">alexdeucher@gmail.co=
m</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>On Tue, May 19, 2020 at 9:16 PM Javad Karabi &lt;<a href=3D"mailto:karabij=
avad@gmail.com" target=3D"_blank">karabijavad@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; thanks for the answers alex.<br>
&gt;<br>
&gt; so, i went ahead and got a displayport cable to see if that changes<br=
>
&gt; anything. and now, when i run monitor only, and the monitor connected<=
br>
&gt; to the card, it has no issues like before! so i am thinking that<br>
&gt; somethings up with either the hdmi cable, or some hdmi related setting=
<br>
&gt; in my system? who knows, but im just gonna roll with only using<br>
&gt; displayport cables now.<br>
&gt; the previous hdmi cable was actually pretty long, because i was<br>
&gt; extending it with an hdmi extension cable, so maybe the signal was<br>
&gt; really bad or something :/<br>
&gt;<br>
&gt; but yea, i guess the only real issue now is maybe something simple<br>
&gt; related to some sysfs entry about enabling some powermode, voltage,<br=
>
&gt; clock frequency, or something, so that glxgears will give me more than=
<br>
&gt; 300 fps. but atleast now i can use a single monitor configuration with=
<br>
&gt; the monitor displayported up to the card.<br>
&gt;<br>
<br>
The GPU dynamically adjusts the clocks and voltages based on load.=C2=A0 No=
<br>
manual configuration is required.<br>
<br>
At this point, we probably need to see you xorg log and dmesg output<br>
to try and figure out exactly what is going on.=C2=A0 I still suspect there=
<br>
is some interaction going on with both GPUs and the integrated GPU<br>
being the primary, so as I mentioned before, you should try and run X<br>
on just the amdgpu rather than trying to use both of them.<br>
<br>
Alex<br>
<br>
<br>
&gt; also, one other thing i think you might be interested in, that was<br>
&gt; happening before.<br>
&gt;<br>
&gt; so, previously, with laptop -tb3-&gt; egpu-hdmi&gt; monitor, there was=
 a<br>
&gt; funny thing happening which i never could figure out.<br>
&gt; when i would look at the X logs, i would see that &quot;modesetting&qu=
ot; (for<br>
&gt; the intel integrated graphics) was reporting that MonitorA was used<br=
>
&gt; with &quot;eDP-1&quot;,=C2=A0 which is correct and what i expected.<br=
>
&gt; when i scrolled further down, i then saw that &quot;HDMI-A-1-2&quot; w=
as being<br>
&gt; used for another MonitorB, which also is what i expected (albeit i<br>
&gt; have no idea why its saying A-1-2)<br>
&gt; but amdgpu was _also_ saying that DisplayPort-1-2 (a port on the<br>
&gt; radeon card) was being used for MonitorA, which is the same Monitor<br=
>
&gt; that the modesetting driver had claimed to be using with eDP-1!<br>
&gt;<br>
&gt; so the point is that amdgpu was &quot;using&quot; Monitor0 with Displa=
yPort-1-2,<br>
&gt; although that is what modesetting was using for eDP-1.<br>
&gt;<br>
&gt; anyway, thats a little aside, i doubt it was related to the terrible<b=
r>
&gt; hdmi experience i was getting, since its about display port and stuff,=
<br>
&gt; but i thought id let you know about that.<br>
&gt;<br>
&gt; if you think that is a possible issue, im more than happy to plug the<=
br>
&gt; hdmi setup back in and create an issue on gitlab with the logs and<br>
&gt; everything<br>
&gt;<br>
&gt; On Tue, May 19, 2020 at 4:42 PM Alex Deucher &lt;<a href=3D"mailto:ale=
xdeucher@gmail.com" target=3D"_blank">alexdeucher@gmail.com</a>&gt; wrote:<=
br>
&gt; &gt;<br>
&gt; &gt; On Tue, May 19, 2020 at 5:22 PM Javad Karabi &lt;<a href=3D"mailt=
o:karabijavad@gmail.com" target=3D"_blank">karabijavad@gmail.com</a>&gt; wr=
ote:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; lol youre quick!<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &quot;Windows has supported peer to peer DMA for years so it=
 already has a<br>
&gt; &gt; &gt; numbers of optimizations that are only now becoming possible=
 on Linux&quot;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; whoa, i figured linux would be ahead of windows when it come=
s to<br>
&gt; &gt; &gt; things like that. but peer-to-peer dma is something that is =
only<br>
&gt; &gt; &gt; recently possible on linux, but has been possible on windows=
? what<br>
&gt; &gt; &gt; changed recently that allows for peer to peer dma in linux?<=
br>
&gt; &gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; A few things that made this more complicated on Linux:<br>
&gt; &gt; 1. Linux uses IOMMUs more extensively than windows so you can&#39=
;t just<br>
&gt; &gt; pass around physical bus addresses.<br>
&gt; &gt; 2. Linux supports lots of strange architectures that have a lot o=
f<br>
&gt; &gt; limitations with respect to peer to peer transactions<br>
&gt; &gt;<br>
&gt; &gt; It just took years to get all the necessary bits in place in Linu=
x and<br>
&gt; &gt; make everyone happy.<br>
&gt; &gt;<br>
&gt; &gt; &gt; also, in the context of a game running opengl on some gpu, i=
s the<br>
&gt; &gt; &gt; &quot;peer-to-peer&quot; dma transfer something like: the ga=
me draw&#39;s to some<br>
&gt; &gt; &gt; memory it has allocated, then a DMA transfer gets that and m=
oves it<br>
&gt; &gt; &gt; into the graphics card output?<br>
&gt; &gt;<br>
&gt; &gt; Peer to peer DMA just lets devices access another devices local m=
emory<br>
&gt; &gt; directly.=C2=A0 So if you have a buffer in vram on one device, yo=
u can<br>
&gt; &gt; share that directly with another device rather than having to cop=
y it<br>
&gt; &gt; to system memory first.=C2=A0 For example, if you have two GPUs, =
you can<br>
&gt; &gt; have one of them copy it&#39;s content directly to a buffer in th=
e other<br>
&gt; &gt; GPU&#39;s vram rather than having to go through system memory fir=
st.<br>
&gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; also, i know it can be super annoying trying to debug an iss=
ue like<br>
&gt; &gt; &gt; this, with someone like me who has all types of differences =
from a<br>
&gt; &gt; &gt; normal setup (e.g. using it via egpu, using a kernel with cu=
stom<br>
&gt; &gt; &gt; configs and stuff) so as a token of my appreciation i donate=
d 50$ to<br>
&gt; &gt; &gt; the red cross&#39; corona virus outbreak charity thing, on b=
ehalf of<br>
&gt; &gt; &gt; amd-gfx.<br>
&gt; &gt;<br>
&gt; &gt; Thanks,<br>
&gt; &gt;<br>
&gt; &gt; Alex<br>
&gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; On Tue, May 19, 2020 at 4:13 PM Alex Deucher &lt;<a href=3D"=
mailto:alexdeucher@gmail.com" target=3D"_blank">alexdeucher@gmail.com</a>&g=
t; wrote:<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; On Tue, May 19, 2020 at 3:44 PM Javad Karabi &lt;<a hre=
f=3D"mailto:karabijavad@gmail.com" target=3D"_blank">karabijavad@gmail.com<=
/a>&gt; wrote:<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; just a couple more questions:<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; - based on what you are aware of, the technical de=
tails such as<br>
&gt; &gt; &gt; &gt; &gt; &quot;shared buffers go through system memory&quot=
;, and all that, do you see<br>
&gt; &gt; &gt; &gt; &gt; any issues that might exist that i might be missin=
g in my setup? i<br>
&gt; &gt; &gt; &gt; &gt; cant imagine this being the case because the card =
works great in<br>
&gt; &gt; &gt; &gt; &gt; windows, unless the windows driver does something =
different?<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Windows has supported peer to peer DMA for years so it =
already has a<br>
&gt; &gt; &gt; &gt; numbers of optimizations that are only now becoming pos=
sible on Linux.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; - as far as kernel config, is there anything in pa=
rticular which<br>
&gt; &gt; &gt; &gt; &gt; _should_ or _should not_ be enabled/disabled?<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; You&#39;ll need the GPU drivers for your devices and dm=
a-buf support.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; - does the vendor matter? for instance, this is an=
 xfx card. when it<br>
&gt; &gt; &gt; &gt; &gt; comes to different vendors, are there interface ch=
anges that might<br>
&gt; &gt; &gt; &gt; &gt; make one vendor work better for linux than another=
? i dont really<br>
&gt; &gt; &gt; &gt; &gt; understand the differences in vendors, but i imagi=
ne that the vbios<br>
&gt; &gt; &gt; &gt; &gt; differs between vendors, and as such, the linux co=
mpatibility would<br>
&gt; &gt; &gt; &gt; &gt; maybe change?<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; board vendor shouldn&#39;t matter.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; - is the pcie bandwidth possible an issue? the pci=
e_bw file changes<br>
&gt; &gt; &gt; &gt; &gt; between values like this:<br>
&gt; &gt; &gt; &gt; &gt; 18446683600662707640 18446744071581623085 128<br>
&gt; &gt; &gt; &gt; &gt; and sometimes i see this:<br>
&gt; &gt; &gt; &gt; &gt; 4096 0 128<br>
&gt; &gt; &gt; &gt; &gt; as you can see, the second value seems significant=
ly lower. is that<br>
&gt; &gt; &gt; &gt; &gt; possibly an issue? possibly due to aspm?<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; pcie_bw is not implemented for navi yet so you are just=
 seeing<br>
&gt; &gt; &gt; &gt; uninitialized data.=C2=A0 This patch set should clear t=
hat up.<br>
&gt; &gt; &gt; &gt; <a href=3D"https://patchwork.freedesktop.org/patch/3662=
62/" rel=3D"noreferrer" target=3D"_blank">https://patchwork.freedesktop.org=
/patch/366262/</a><br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Alex<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; On Tue, May 19, 2020 at 2:20 PM Javad Karabi &lt;<=
a href=3D"mailto:karabijavad@gmail.com" target=3D"_blank">karabijavad@gmail=
.com</a>&gt; wrote:<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; im using Driver &quot;amdgpu&quot; in my xorg=
 conf<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; how does one verify which gpu is the primary?=
 im assuming my intel<br>
&gt; &gt; &gt; &gt; &gt; &gt; card is the primary, since i have not done an=
ything to change that.<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; also, if all shared buffers have to go throug=
h system memory, then<br>
&gt; &gt; &gt; &gt; &gt; &gt; that means an eGPU amdgpu wont work very well=
 in general right?<br>
&gt; &gt; &gt; &gt; &gt; &gt; because going through system memory for the e=
gpu means going over the<br>
&gt; &gt; &gt; &gt; &gt; &gt; thunderbolt connection<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; and what are the shared buffers youre referri=
ng to? for example, if an<br>
&gt; &gt; &gt; &gt; &gt; &gt; application is drawing to a buffer, is that a=
n example of a shared<br>
&gt; &gt; &gt; &gt; &gt; &gt; buffer that has to go through system memory? =
if so, thats fine, right?<br>
&gt; &gt; &gt; &gt; &gt; &gt; because the application&#39;s memory is in sy=
stem memory, so that copy<br>
&gt; &gt; &gt; &gt; &gt; &gt; wouldnt be an issue.<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; in general, do you think the &quot;copy buffe=
r across system memory might<br>
&gt; &gt; &gt; &gt; &gt; &gt; be a hindrance for thunderbolt? im trying to =
figure out which<br>
&gt; &gt; &gt; &gt; &gt; &gt; directions to go to debug and im totally lost=
, so maybe i can do some<br>
&gt; &gt; &gt; &gt; &gt; &gt; testing that direction?<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; and for what its worth, when i turn the displ=
ay &quot;off&quot; via the gnome<br>
&gt; &gt; &gt; &gt; &gt; &gt; display settings, its the same issue as when =
the laptop lid is closed,<br>
&gt; &gt; &gt; &gt; &gt; &gt; so unless the motherboard reads the &quot;clo=
sed lid&quot; the same as &quot;display<br>
&gt; &gt; &gt; &gt; &gt; &gt; off&quot;, then im not sure if its thermal is=
sues.<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; On Tue, May 19, 2020 at 2:14 PM Alex Deucher =
&lt;<a href=3D"mailto:alexdeucher@gmail.com" target=3D"_blank">alexdeucher@=
gmail.com</a>&gt; wrote:<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; On Tue, May 19, 2020 at 2:59 PM Javad Ka=
rabi &lt;<a href=3D"mailto:karabijavad@gmail.com" target=3D"_blank">karabij=
avad@gmail.com</a>&gt; wrote:<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; given this setup:<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; laptop -thunderbolt-&gt; razer core=
 x -&gt; xfx rx 5600 xt raw 2 -hdmi-&gt; monitor<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; DRI_PRIME=3D1 glxgears gears gives =
me ~300fps<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; given this setup:<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; laptop -thunderbolt-&gt; razer core=
 x -&gt; xfx rx 5600 xt raw 2<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; laptop -hdmi-&gt; monitor<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; glx gears gives me ~1800fps<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; this doesnt make sense to me becaus=
e i thought that having the monitor<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; plugged directly into the card shou=
ld give best performance.<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; Do you have displays connected to both G=
PUs?=C2=A0 If you are using X which<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; ddx are you using?=C2=A0 xf86-video-mode=
setting or xf86-video-amdgpu?<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; IIRC, xf86-video-amdgpu has some optimiz=
ations for prime which are not<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; yet in xf86-video-modesetting.=C2=A0 Whi=
ch GPU is set up as the primary?<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; Note that the GPU which does the renderi=
ng is not necessarily the one<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; that the displays are attached to.=C2=A0=
 The render GPU renders to it&#39;s<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; render buffer and then that data may end=
 up being copied other GPUs<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; for display.=C2=A0 Also, at this point, =
all shared buffers have to go<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; through system memory (this will be chan=
ging eventually now that we<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; support device memory via dma-buf), so t=
here is often an extra copy<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; involved.<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; theres another really weird issue..=
.<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; given setup 1, where the monitor is=
 plugged in to the card:<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; when i close the laptop lid, my mon=
itor is &quot;active&quot; and whatnot, and i<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; can &quot;use it&quot; in a sense<b=
r>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; however, heres the weirdness:<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; the mouse cursor will move along th=
e monitor perfectly smooth and<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; fine, but all the other updates to =
the screen are delayed by about 2<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; or 3 seconds.<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; that is to say, its as if the lapto=
p is doing everything (e.g. if i<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; open a terminal, the terminal will =
open, but it will take 2 seconds<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; for me to see it)<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; its almost as if all the frames and=
 everything are being drawn, and<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; the laptop is running fine and ever=
ything, but i simply just dont get<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; to see it on the monitor, except fo=
r one time every 2 seconds.<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; its hard to articulate, because its=
 so bizarre. its not like, a &quot;low<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; fps&quot; per se, because the curso=
r is totally smooth. but its that<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; _everything else_ is only updated o=
nce every couple seconds.<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; This might also be related to which GPU =
is the primary.=C2=A0 It still may<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; be the integrated GPU since that is what=
 is attached to the laptop<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; panel.=C2=A0 Also the platform and some =
drivers may do certain things when<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; the lid is closed.=C2=A0 E.g., for therm=
al reasons, the integrated GPU or<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; CPU may have a more limited TDP because =
the laptop cannot cool as<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; efficiently.<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; Alex<br>
</blockquote></div></div>

--00000000000089a4c705a61b96d3--

--===============1521195657==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1521195657==--
