Return-Path: <SRS0=dIjB=7B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5532C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2020 19:14:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEFAD207D4
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2020 19:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eutLamuC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEFAD207D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 708A089F6E;
	Tue, 19 May 2020 19:14:04 +0000 (UTC)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 129ED89F6E
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2020 19:14:04 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id e1so643419wrt.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2020 12:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rqe/GihtsS3DTuuhxb5YEFis2EK8t3bD1Q8ngixANLQ=;
 b=eutLamuC5DMLETVuJ3lC+h9arRSpN5xAU5J+lcv6siko4SU9TQ0Xh1R0a67y0KX0fY
 Mi1gbSn1CPcJ/Nhonl2MmN6nt/wRwKClwCeTODOiQ/kH9TsFnV4y13gFGKymroBT2aNw
 K1/d+cgYMF0RMQ2FH8Clv81ogRKqRdGxWi8KY0TyuB2xFqqAC1VjTJ03RY5N0u1lwcVr
 OdDmViyzUBg8pJnNWblioSgG32a8U3gy9jGofSKKLuaoshc4r4oKSP0eY+IFYQ+fiNb4
 H4pGwq4EeAp6OGRpP8Jv/pF8xZP5Tb8+MKggZY6B/+6BooAUj8+et3MU3JRSEZGqT1Q8
 KCRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rqe/GihtsS3DTuuhxb5YEFis2EK8t3bD1Q8ngixANLQ=;
 b=p5ZXOvXEf6Vlo/Ckhw3Ua2tDTlv3lduA7Nqb1Xd4qELqarL1xeUgQmA6Oqq4iRwViZ
 G4TzUt636pSqgVkjQzUV+548tiy4PZb7ncgAVe+kJoHqkfWtQK0TGpkWZF3QoIE+RMOc
 Wxm7H6cSxBD8uKFaQxb+HQJrP6FVq81XBMR+QHqbVRwuAOAXZFZu4A2xHWCQPkpLi55s
 oHUzZ1SlLhYh0+rzaqmVJ/oVyemsdbeX2fUZb+hlf7Wtxf2FJSWFPHg0BgjNxXEYyzrq
 on0sZ4XLe7q5JiBAjgWhBHBMgMeiyJGI69FLY0CI+493dfBuufCe6YfAmmSqhZy3uVHu
 UyrA==
X-Gm-Message-State: AOAM5325GeemBeF7jPUW6HsnKRbND7JZfsexjYjg1BLgYRaOa5nEP9mE
 UVxf9TM4hrGThxaxA9QcHsz9/UVHSoWiS34b3v4=
X-Google-Smtp-Source: ABdhPJwhg3859yUYtZspFbSGle+R1rL/aisx7hv2aE/DQSQ3u6E3H7R+uufhFzYRsDs8GMQbXhqJJS0wqRseH2rWF70=
X-Received: by 2002:a5d:4389:: with SMTP id i9mr419479wrq.374.1589915642689;
 Tue, 19 May 2020 12:14:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAEOHGOm=g_VGa5939Qi_HEXAfuUKuy3tXURx9TKg+n==dUDqPQ@mail.gmail.com>
In-Reply-To: <CAEOHGOm=g_VGa5939Qi_HEXAfuUKuy3tXURx9TKg+n==dUDqPQ@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 19 May 2020 15:13:50 -0400
Message-ID: <CADnq5_N-vLuyqo_rqjy44nwdKPWyiO8cpAJN9pFk79wjwKi7gw@mail.gmail.com>
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

On Tue, May 19, 2020 at 2:59 PM Javad Karabi <karabijavad@gmail.com> wrote:
>
> given this setup:
> laptop -thunderbolt-> razer core x -> xfx rx 5600 xt raw 2 -hdmi-> monitor
> DRI_PRIME=1 glxgears gears gives me ~300fps
>
> given this setup:
> laptop -thunderbolt-> razer core x -> xfx rx 5600 xt raw 2
> laptop -hdmi-> monitor
>
> glx gears gives me ~1800fps
>
> this doesnt make sense to me because i thought that having the monitor
> plugged directly into the card should give best performance.
>

Do you have displays connected to both GPUs?  If you are using X which
ddx are you using?  xf86-video-modesetting or xf86-video-amdgpu?
IIRC, xf86-video-amdgpu has some optimizations for prime which are not
yet in xf86-video-modesetting.  Which GPU is set up as the primary?
Note that the GPU which does the rendering is not necessarily the one
that the displays are attached to.  The render GPU renders to it's
render buffer and then that data may end up being copied other GPUs
for display.  Also, at this point, all shared buffers have to go
through system memory (this will be changing eventually now that we
support device memory via dma-buf), so there is often an extra copy
involved.

> theres another really weird issue...
>
> given setup 1, where the monitor is plugged in to the card:
> when i close the laptop lid, my monitor is "active" and whatnot, and i
> can "use it" in a sense
>
> however, heres the weirdness:
> the mouse cursor will move along the monitor perfectly smooth and
> fine, but all the other updates to the screen are delayed by about 2
> or 3 seconds.
> that is to say, its as if the laptop is doing everything (e.g. if i
> open a terminal, the terminal will open, but it will take 2 seconds
> for me to see it)
>
> its almost as if all the frames and everything are being drawn, and
> the laptop is running fine and everything, but i simply just dont get
> to see it on the monitor, except for one time every 2 seconds.
>
> its hard to articulate, because its so bizarre. its not like, a "low
> fps" per se, because the cursor is totally smooth. but its that
> _everything else_ is only updated once every couple seconds.

This might also be related to which GPU is the primary.  It still may
be the integrated GPU since that is what is attached to the laptop
panel.  Also the platform and some drivers may do certain things when
the lid is closed.  E.g., for thermal reasons, the integrated GPU or
CPU may have a more limited TDP because the laptop cannot cool as
efficiently.

Alex
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
