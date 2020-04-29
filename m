Return-Path: <SRS0=m206=6N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEFDAC83000
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2020 18:15:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 951D621D79
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2020 18:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uc4seFus"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 951D621D79
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E3A66EAC5;
	Wed, 29 Apr 2020 18:15:38 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5997B6EAC5
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Apr 2020 18:15:37 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id u127so3091645wmg.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Apr 2020 11:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OIEaVTO2k/ZD+3/FAaQmFrsXEb1vFDWRHoiNnwqZBRY=;
 b=Uc4seFusJ41p4FkXMMwjSzeNeJE4YOrvt0nFe6ZXEEGPW/b+pNV4mo7oSE5Uvt0Xuh
 wlqAa0WhCrLIVl/Hd2nT+yrXXModNlO44A0g03IzcxSIacTz4LknU//OC7nwkp+UwBFK
 dEyP+wt5xS6ekbLgSnU9vEHfakUe171FGPIoQPPIN+bydVt/Lb9EbksWJgknaNofnhMd
 5JKOS6FBy5BBBWQi0zlEQVaugasoeUO70iyos6qWtrI3lwM0GaVSGVTD5nViOAUGzwAI
 Rwq+buM6dsDOvh7pbnA2pYxshy/OOk8NmiWWs2yER+NdGVjMoGdKsfv0RBxrXhMzdqmT
 uUuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OIEaVTO2k/ZD+3/FAaQmFrsXEb1vFDWRHoiNnwqZBRY=;
 b=Mw+azBbHx7e1KWVjc4I9TXKHdRUlPtBmEGjnSfTPzrQEUtleHTxmmcfJYn90s8emKx
 yHpKqsqABowH+wQgwMVtM2SLx9H/MppJP/jp+9lzqzsh4HXIzP5fWAuISxAd3mN9mV3t
 M7cidwRStieRlrqxdbDENYYugYiBjP5HDO0stSsJ9KuiU/NO+M4e1nrqfnRVna/cvd1H
 mzqHOXam8ZWA+o2r9U0VD4DIPWHurCiZ6DUIGccog9kjSrzg8O6Tx/j8Wl2ErlDHsx7z
 jfZdD8AV73JxYDQdclYjbTPZIZcONYlYOty2oUPiyJgmhX3SlLthGzen45dBC6ofvzbO
 /eQQ==
X-Gm-Message-State: AGi0PuYPdcEysMUPnQWQk9THnmpuF+UHy3zDuukAtPga589WNclvgCnh
 w6BfqpljPgYUDcToBCoFauVxyaWTGrXNYOa3/nY=
X-Google-Smtp-Source: APiQypLetzwxjo6q3G2j4l6IMFBm//m1YL+lK6cXNOEXuzXZojEgSaNSJYgoUlaVrkMZscvlzQWNatTXLz7Qif3h254=
X-Received: by 2002:a1c:9d8c:: with SMTP id g134mr4735111wme.79.1588184136010; 
 Wed, 29 Apr 2020 11:15:36 -0700 (PDT)
MIME-Version: 1.0
References: <8db5ae80-0b9d-7d44-18b6-5641eab0ac0d@FreeBSD.org>
In-Reply-To: <8db5ae80-0b9d-7d44-18b6-5641eab0ac0d@FreeBSD.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 29 Apr 2020 14:15:23 -0400
Message-ID: <CADnq5_NkrG1SDMAEfsVNA11Kn8baMaO4J3EcDzKOsNZCWk6LaA@mail.gmail.com>
Subject: Re: amdgpu, dc, backlight brightness
To: Andriy Gapon <avg@freebsd.org>
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

On Wed, Apr 29, 2020 at 3:29 AM Andriy Gapon <avg@freebsd.org> wrote:
>
>
> I see that amdgpu_atif_handler() has this comment and code:
>                 /* todo: add DC handling */
>                 if ((req.pending & ATIF_PANEL_BRIGHTNESS_CHANGE_REQUEST) &&
>                     !amdgpu_device_has_dc_support(adev)) {
> ...
>                 }
>
> So, this makes me curious how a typical Linux distribution handles backlight
> brightness change via special keys hooked to ACPI.
>
> This is what I see on FreeBSD.
> - a special key is pressed
> - there is a bunch of uninteresting ACPI and kernel stuff involving EC
> - ACPI notification 0x86 on VGA.LCD device is handled by acpi_video driver
> - the driver invokes VGA.LCD._BCM method
> - if I read the ASL of my system correctly, ACPI does not touch any hardware
>   but simply saves some things like the requested brightness level
> - then ACPI posts notification 0x81 on VGA device
> - the notification gets routed to amdgpu
> - amdgpu invokes VGA.ATIF and gets some interesting data from ACPI
> - and this is where things stop in the DC case (because of the code above)
>
> In the non-DC case amdgpu would actually set the brightness based on the data
> returned from ATIF.  radeon driver also did the same as far as I can see.
>
> So, how things work in the DC case?
>
> I see that Linux acpi_video does something that FreeBSD doesn't do, it posts
> KEY_BRIGHTNESSUP / KEY_BRIGHTNESSDOWN / etc.  I guess that in the end this is
> similar to just having the corresponding multimedia keys on a keyboard.
> Is this how the brightness control supposed to work?
> So, there must be some userland program listening for those keys and somehow
> knowing about amdgpu backlight controls (e.g., /sys/class/backlight/amdgpu_bl0).
> Is that correct?
>
> I tried a live image of Void Linux (LXQT flavor).  While it does handle the
> special brightness keys it seems to do it without actually controlling the
> backlight.  That is, it makes the picture lighter / darker, but values under
> /sys/class/backlight/amdgpu_bl0 do not change.  If I set brightness under
> /sys/class/backlight/amdgpu_bl0 to some low level then the brightness up key
> cannot make the screen brighter.  So, it appears to be just a rendering /
> composition trick.

I think it varies from OEM to OEM and whatever windows required at the
time.  The sbios may also do different things depending on the osi
string passed to ACPI.  Originally, ACPI handled it all directly.
Then we got some laptops which which did the whole event via ATIF
thing (even that I think varied based on the .  Later, I think the
keys just produced brightness events and it was up to the OS to do
something with them so the user's environment would catch the events
and adjust the backlight via the standard OS backlight control
interface.  We never hooked up the ATIF stuff to DC since I don't
recall ever running into any laptops that used it for backlight
control (the code was carried over from radeon when we forked amdgpu).

Alex
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
