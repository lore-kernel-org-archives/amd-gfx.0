Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11BAEE77187
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Dec 2024 10:25:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 997FC10E8DC;
	Wed, 18 Dec 2024 10:25:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=ffwll.ch header.i=@ffwll.ch header.b="FFo9mXs5";
	dkim-atps=neutral
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73D1310E8DC
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Dec 2024 10:25:02 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43622267b2eso65575565e9.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Dec 2024 02:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ffwll.ch; s=google; t=1734517501; x=1735122301; darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Jono6wMZ3ZiagoZWzR/N7UxIlBos0dNmF7MemUcAJTE=;
 b=FFo9mXs5dh9fq/EaouAGPEnCNoRzhZqljozLypSTRMR+HglPSHI40Uh76dPNWn9wRm
 dYlrE7RgtNPt7QDbzwaq7xoRcOceHFedu6Rb3LS/iDB1C13H0yAwv8rT5Gvr/LCyywRy
 e3E2fzmF2wax9rPAFwpie9Rd607aL839gw0nY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734517501; x=1735122301;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Jono6wMZ3ZiagoZWzR/N7UxIlBos0dNmF7MemUcAJTE=;
 b=WoNBIKiJgklDyUzBFmDY9wD53LC7U2LuSSiPTtzyilUwMaoB2j/lpVtJiFzab3RUCF
 7Sp5eFPExh0/i6Y8LUUfvCHyoUYkCGV7sD2fgY00U4hZ8kGXBUCjr9OmqWzwYk1C4vzr
 /6uxv56G2Crc+Bwy2/wttPbNNmgrVPpQcBAWZ5TZpHnaz8rH6PppjVAipuP2E5QCEgBm
 EjpaOx3SwoVknyqRFRlMpY7buA9qtGZrXXwfUJ0YVvyw6U4LPWPUZ9b1mq8wi91T1hYe
 ORI5dWTTl3KjGF2a4wS6ZSeJQxZhROgci9SLwcYkd6I2bMrVwarNbeGww8d35yDEYZGD
 Fvbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6QUMMMaaKkVL/OE6Uud/4HQ842Mtg9S8/1JLhPoOPnjT0RoDrXk/m9O5UQdoTqZMpmBA22QRM@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw9W+Y9y0KNrTlkes33oGv9r0JajLFPtWb8UIn545RO6S0zc+Vf
 1PqT9LMqIgCHbf40bwZrK4vOnl/rufAtXIusZN0VdMJ8NueLBQhQ7W3/fsccoTw=
X-Gm-Gg: ASbGnct5lb+Qk4IBqt20TWDlADo5ejksV2juSmgoAmipFZFsi32rUpacHHFBm9OAzMD
 PgxOUHpZVkJtWJ2cY8P6M0/02wORo+rmr8jdEwTcEHYUBmHvFwiRbOr02lwwYfIm3+OX8Evz6JX
 QKW6/6kIhlmbWyfEy3n0fFEvGn7Q//jFOSvzZBPreP+uCvzJYfP5DfmDBMfgsWyw+7P4QcCEZdE
 t6E1lP23KgsjfbFtMu4+xDB5P+K6875itgLs9/cWpV5dN1fioJGjIVcaUhGR2TesK4J
X-Google-Smtp-Source: AGHT+IHhiC87PK18+QBUVN9wM1L5J2CKoKDMT1U8khxwF8YSZNNu7RvVuRFu/AfmKmYSZMSQUR7XfA==
X-Received: by 2002:a05:600c:1c1c:b0:434:edcf:7461 with SMTP id
 5b1f17b1804b1-4365540c077mr20344475e9.30.1734517500788; 
 Wed, 18 Dec 2024 02:25:00 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656afd57esm15775605e9.5.2024.12.18.02.25.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 02:25:00 -0800 (PST)
Date: Wed, 18 Dec 2024 11:24:58 +0100
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Michel =?iso-8859-1?Q?D=E4nzer?= <michel.daenzer@mailbox.org>
Cc: Brian Starkey <brian.starkey@arm.com>,
 Marek =?utf-8?B?T2zFocOhaw==?= <maraeo@gmail.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
 ML Mesa-dev <mesa-dev@lists.freedesktop.org>, nd@arm.com
Subject: Re: [PATCH] drm/fourcc: add LINEAR modifiers with an exact pitch
 alignment
Message-ID: <Z2Ki-lQH4Fbch6RO@phenom.ffwll.local>
References: <CAAxE2A5BkF13bFt8_UnuiqPM8W-ZESgmKEjqqGfv=DGzSfJ7aQ@mail.gmail.com>
 <uffsfaps6a75zmkyshkwfxgybcslqrnfqqtjzekegdptvwpugc@2ndpcuxyfp3f>
 <c64cb9d8-5ea7-4644-93c8-04a97b758fa0@mailbox.org>
 <h26quuebhpxwkc3fl4vtfteoqyvingnddgxbnzptfnxfg6xgkd@kkkmeqwplomv>
 <8dae97c9-9286-451a-8122-b309eb21b2f4@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8dae97c9-9286-451a-8122-b309eb21b2f4@mailbox.org>
X-Operating-System: Linux phenom 6.12.3-amd64 
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Dec 18, 2024 at 10:44:17AM +0100, Michel Dänzer wrote:
> On 2024-12-17 12:03, Brian Starkey wrote:
> > On Tue, Dec 17, 2024 at 11:13:05AM +0000, Michel Dänzer wrote:
> >> On 2024-12-17 10:14, Brian Starkey wrote:
> >>
> >>> Modifiers are meant to describe framebuffers, and this pitch alignment
> >>> requirement isn't really a framebuffer property - it's a device
> >>> constraint. It feels out of place to overload modifiers with it.
> 
> FWIW, KMS framebuffers aren't the only use case for sharing buffers
> between devices.
> 
> 
> >>> I'm not saying we don't need a way to describe constraints to
> >>> allocators, but I question if modifiers the right mechanism to
> >>> communicate them?
> >> While I agree with your concern in general, AFAIK there's no other
> >> solution for this even on the horizon, after years of talking about
> >> it. The solution proposed here seems like an acceptable stop gap,
> >> assuming it won't result in a gazillion linear modifiers.
> > 
> > UAPI is baked forever, so it's worth being a little wary IMO.
> > 
> > This sets a precedent for describing constraints via modifiers. The
> > reason no other proposal is on the horizon is because describing the
> > plethora of constraints across devices is a hard problem; and the
> > answer so far has been "userspace needs to know" (à la Android's
> > gralloc).
> > 
> > If we start down the road of describing constraints with modifiers, I
> > fear we'll end up in a mess. The full enumeration of modifiers is
> > already horrendous for parameterized types, please let's not
> > combinatorially multiply those by constraints.
> 
> I agree there's a slippery slope.
> 
> That said, linear buffers are special in that they're the only
> possibility which can work for sharing buffers between devices in many
> cases, in particular when the devices are from different vendors or even
> different generations from the same vendor.
> 
> So as long as device vendors don't get too creative with their linear
> pitch alignment restrictions, it still seems like this might be workable
> stop-gap solution for that specific purpose alone, until a better
> solution for handling constraints arrives.
> 
> 
> > P.S. "is the only modifier that has a chance of not working" is
> > fundamentally false.
> 
> My reading of that part of the comment is that pitch alignment shouldn't
> be an issue with non-linear modifiers, since the constraints for pitch
> should be part of the modifier definition. Maybe that could be clarified
> in the comment.

Yeah with all other modifiers pitch alignment or other alignment/sizing
requirements are generally implied. Mostly by stuff like tile size, but
there's others where the hw requirement flat out is that the buffer must
have a power-of-two stride (and maybe we should document these when they
pop up, but the only one I know of are the legacy i915 modifiers, which
are kinda busted anyway for interop).

For that reason I think linear modifiers with explicit pitch/size
alignment constraints is a sound concept and fits into how modifiers work
overall.
-Sima

> 
> 
> -- 
> Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
> https://redhat.com             \               Libre software enthusiast

-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
