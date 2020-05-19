Return-Path: <SRS0=dIjB=7B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A765C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2020 21:32:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EF012072C
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2020 21:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ihp5UgSB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EF012072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBA026E393;
	Tue, 19 May 2020 21:32:24 +0000 (UTC)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 078206E0C1
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2020 21:32:22 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id k13so1024678wrx.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2020 14:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Q+fk2jjNA3ll9mCY/m1yreyCEW/l3sMpRj0BpbHjLMs=;
 b=Ihp5UgSBcIdntvCy6LdXhN27Za0TDH0IuAi9HJTwoVWqtEhFYsQdwmt40e/1utgu7K
 TxxL5MQBmZjgKvXBasQm0f6r8j0GWuVUg0Fu3AhFGcQ21ge68WXZ+HMAlBXBhv7H+3J9
 oGrTaYD1HtiRMy3dQdN+w3rEEQdyepqIkObvzA8PrSsQ3cZO3PpH2I31srYb7Bgx+rC+
 xvp5p4ykKyjih5YemWIgS0KAjRZAB8S/B2SkBQJKImnoaugAdRjno/wBFe1LWMQk9TYL
 1Ow/TTb+sInaK3bBQ5ZGr7WJqPv8zHlfQxXE+J4t/MCSYD7Jvau87rN8i7FnjWpiz4WO
 6MCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Q+fk2jjNA3ll9mCY/m1yreyCEW/l3sMpRj0BpbHjLMs=;
 b=LOHGRg1b/OwMLYaDl3pTN4WI6aOYNrU/WTkJZ0RRYZ+QIDiE41rdZBw3cb0ORhbKt6
 82KbcKL7zYK29gifLRhLEt81REzg5ezkOB0NYLeKISipUxdtwt+WTgMpQff45Aj+XMNK
 VI11f7SzQ+f/DcCKfvEiAB8XQmOrt0e0rcJGfliJVh0zwaaJA80mK40FQurFk019zXTz
 z0HHI+1K7jVoZqAXrlmgc2lNGZVy7UonzclCbES3EqEYBKhrfNjF47KGJTpKbytA1CWp
 F+2rWIJyppUNGdlrGwHJvbKS7xTGDYP34NS7Jykq8aWHYro55dngJlOcgWqB/yddqRE0
 GRbg==
X-Gm-Message-State: AOAM533AnUHsL2Gqfx2KyKCytmymaTjeq765BxnHWpEcVU2i16N22ekk
 srbIYXh6HVQjnab7nKduS/uh9L+nmpv8g6RYv5+7Mw==
X-Google-Smtp-Source: ABdhPJzAK2B5JgykY68KEtEtcpwRYYav7annW96NIYb+NZHoqHp6hRJ7l1FgHOSHHBerlSXV+ff1epjaeVGaAu6BBns=
X-Received: by 2002:a5d:4389:: with SMTP id i9mr906108wrq.374.1589923941332;
 Tue, 19 May 2020 14:32:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAEOHGOm=g_VGa5939Qi_HEXAfuUKuy3tXURx9TKg+n==dUDqPQ@mail.gmail.com>
 <CADnq5_N-vLuyqo_rqjy44nwdKPWyiO8cpAJN9pFk79wjwKi7gw@mail.gmail.com>
 <CAEOHGOkbu5jy_1_bUD4H0U89YEc_9zOxsSdyZqmtqZNsdOyDkg@mail.gmail.com>
In-Reply-To: <CAEOHGOkbu5jy_1_bUD4H0U89YEc_9zOxsSdyZqmtqZNsdOyDkg@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 19 May 2020 17:32:10 -0400
Message-ID: <CADnq5_NSVzq-B0x_h0jqbgpeVpd8aEqwZVsDY961cLUSrNtUfg@mail.gmail.com>
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

On Tue, May 19, 2020 at 3:20 PM Javad Karabi <karabijavad@gmail.com> wrote:
>
> im using Driver "amdgpu" in my xorg conf
>
> how does one verify which gpu is the primary? im assuming my intel
> card is the primary, since i have not done anything to change that.
>

Check your xorg log.

> also, if all shared buffers have to go through system memory, then
> that means an eGPU amdgpu wont work very well in general right?
> because going through system memory for the egpu means going over the
> thunderbolt connection

If you want to render on the dGPU and display on the integrated GPU,
then the content will have to traverse the bus.

>
> and what are the shared buffers youre referring to? for example, if an
> application is drawing to a buffer, is that an example of a shared
> buffer that has to go through system memory? if so, thats fine, right?
> because the application's memory is in system memory, so that copy
> wouldnt be an issue.

For optimal performance, dGPUs will want to render to local vram.  So
when a dGPU is rendering it will render to a buffer in vram.  However,
if the display is connected to the integrated GPU, it can't directly
access the buffer in the dGPU's vram.  In order to transfer the buffer
from the dGPU to the integrated GPU for display, it has to be copied
from vram to buffer in system memory.  This buffer is then shared with
the integrated GPU.  Depending on the integrated GPU's capabilities,
it may be able to use the buffer as is, or it may have to copy the
buffer again to a buffer that it can display from.

>
> in general, do you think the "copy buffer across system memory might
> be a hindrance for thunderbolt? im trying to figure out which
> directions to go to debug and im totally lost, so maybe i can do some
> testing that direction?

If you are mainly concerned with checking the performance of the the
dGPU itself (where the dGPU handles display and rendering), I would
make sure your desktop environment is configured to be running on the
dGPU only.  Take the integrated GPU out of the picture.

>
> and for what its worth, when i turn the display "off" via the gnome
> display settings, its the same issue as when the laptop lid is closed,
> so unless the motherboard reads the "closed lid" the same as "display
> off", then im not sure if its thermal issues.

If the integrated GPU is the primary display, turning the displays off
or closing the lid may signal to the integarted GPU driver that it's
not in use so it can power down.  So it may go to a lower power state
which has a relatively high exit latency.  Every time a copy is
required the integrated GPU has to wake up and do the copy.  The copy
is probably not necessary, but I'm not sure how well optimized most
display servers are in this regard.  Really if all the displays on one
GPU are off and the display server should fallback to same GPU render
and display, but I'm not sure how well this is handled.  The current
multi-GPU support in X is mostly focused on the following two use
cases:
1. Hybrid graphics, where you have a integrated GPU which handles
displays and you have a dGPU which is mainly for render offload.  The
render GPU renders content and it it shared with the display GPU.
2. Multi-GPU displays, where you have a large desktop spread across
multiple GPUs.  The render GPU renders content and it is shared with
the display GPUs.

Alex


>
> On Tue, May 19, 2020 at 2:14 PM Alex Deucher <alexdeucher@gmail.com> wrote:
> >
> > On Tue, May 19, 2020 at 2:59 PM Javad Karabi <karabijavad@gmail.com> wrote:
> > >
> > > given this setup:
> > > laptop -thunderbolt-> razer core x -> xfx rx 5600 xt raw 2 -hdmi-> monitor
> > > DRI_PRIME=1 glxgears gears gives me ~300fps
> > >
> > > given this setup:
> > > laptop -thunderbolt-> razer core x -> xfx rx 5600 xt raw 2
> > > laptop -hdmi-> monitor
> > >
> > > glx gears gives me ~1800fps
> > >
> > > this doesnt make sense to me because i thought that having the monitor
> > > plugged directly into the card should give best performance.
> > >
> >
> > Do you have displays connected to both GPUs?  If you are using X which
> > ddx are you using?  xf86-video-modesetting or xf86-video-amdgpu?
> > IIRC, xf86-video-amdgpu has some optimizations for prime which are not
> > yet in xf86-video-modesetting.  Which GPU is set up as the primary?
> > Note that the GPU which does the rendering is not necessarily the one
> > that the displays are attached to.  The render GPU renders to it's
> > render buffer and then that data may end up being copied other GPUs
> > for display.  Also, at this point, all shared buffers have to go
> > through system memory (this will be changing eventually now that we
> > support device memory via dma-buf), so there is often an extra copy
> > involved.
> >
> > > theres another really weird issue...
> > >
> > > given setup 1, where the monitor is plugged in to the card:
> > > when i close the laptop lid, my monitor is "active" and whatnot, and i
> > > can "use it" in a sense
> > >
> > > however, heres the weirdness:
> > > the mouse cursor will move along the monitor perfectly smooth and
> > > fine, but all the other updates to the screen are delayed by about 2
> > > or 3 seconds.
> > > that is to say, its as if the laptop is doing everything (e.g. if i
> > > open a terminal, the terminal will open, but it will take 2 seconds
> > > for me to see it)
> > >
> > > its almost as if all the frames and everything are being drawn, and
> > > the laptop is running fine and everything, but i simply just dont get
> > > to see it on the monitor, except for one time every 2 seconds.
> > >
> > > its hard to articulate, because its so bizarre. its not like, a "low
> > > fps" per se, because the cursor is totally smooth. but its that
> > > _everything else_ is only updated once every couple seconds.
> >
> > This might also be related to which GPU is the primary.  It still may
> > be the integrated GPU since that is what is attached to the laptop
> > panel.  Also the platform and some drivers may do certain things when
> > the lid is closed.  E.g., for thermal reasons, the integrated GPU or
> > CPU may have a more limited TDP because the laptop cannot cool as
> > efficiently.
> >
> > Alex
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
