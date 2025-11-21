Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D156CFD31C
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Nov 2025 08:12:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABA5110E1DD;
	Mon, 24 Nov 2025 08:12:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cM0CQeBK";
	dkim-atps=neutral
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com
 [209.85.208.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 740A010E113
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Nov 2025 17:51:12 +0000 (UTC)
Received: by mail-ed1-f52.google.com with SMTP id
 4fb4d7f45d1cf-644f90587e5so3615279a12.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Nov 2025 09:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763747471; x=1764352271; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9syd0iDwsyEu4s/8iEAd1AcquGv2uEIeHc2ss2ClUv0=;
 b=cM0CQeBKp7WDHvn05RhwCqY1wq3MPQimLTE0ekrJPsoU8ZNnzg3G50Wws36UN1beca
 OopuhHXcFfzqrXLRy8iSW0oZ8FWEumcBJ3av9FnYOzZEcujNreWzJFGCzqROM8KYcKiW
 i1SVjh50/kg41vpM5TiynTRz8ja9m36g9K3WYjXW7VYCkDrxymih7NZCaTR3kvko6FJu
 LpJq75EId63usD/vBjZv4LeH+ehJU5dRVNI9bAGjz6QmlYjNcdZQkGbUKa0R+MM9Tbrh
 kn0RpVSVLxkV9+qxlsG6lGqTAFHOS8Fec2jwGK+aBJ1AzMazMYO+F524cUY+dz/f/5SR
 Kf5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763747471; x=1764352271;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9syd0iDwsyEu4s/8iEAd1AcquGv2uEIeHc2ss2ClUv0=;
 b=L+pGk3X7k6lhbAPDHAPm0qHuNAKCju0mUbrC50/+GwWr9TKk5MQoEhpEieaYr8TSKE
 asXmIHi0Hd7zfhgabH1YkTwIZ3LUUAHRLVLrw2ftf60FwRKNoNsi82ufwKs0NSTDqOzV
 9wCrst1+6pUutnULyABZM+/iUKPw32GkoySvnI9wUZoNBSTy4GZQI28olZ34jkB5juWn
 UU75RfSktTtpn/3nAYYLvLdg86XXZi2n90+paS9IyLDWh/KRWd7hdxub8P2KZvx8lHn2
 AJ/D/F/W4vFRL6h9aeoeM57tfqfTk/F+SvP9jgn+Ry+dawqhZf2cJWK2efyQo5pgdKbs
 aE0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0gtLCDzddJ7J1yuPb1KK7/yWn8zpgG61mVnbu8W/GKJR69CwH7zf1REyUmwimx4AhxWx9GOr4@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy0iyYvFJEPtnrlvshF+F2NecRjgFRpR6QWorddz8P8JohiaNls
 /nbqlTsTN58ET7neYLKPifokZMvdCW71cqzfW68nQkiy2c0xN5kl8DDIkAZQ1dk0o+4xN19BgDX
 BdgZtVjyADGMS/UHnvusSDVy0dpfhgFE=
X-Gm-Gg: ASbGnctSwW1qqifs5oHDb7wL3tb/PPGyds0YsC8p2fTXXmlGqwTNAphy9LYWM90zSiG
 FeSBqBprBqr2CgnfEG1bzRw9Ro/oyYDM3+hr6DgL+uSLDTFUYEaWH/oYY07N2Zh9Vi4XxUQKz/G
 fe3AkMB7bp7zJ7REC0sdws7Bp4YCUyUZ6ak6jSeL2MYVySReuvipHRTyuaNU0Z6AVpWwPYjsutP
 mJr42qRkxg/FvTeMcxoppCbDGoSb0x8akRFrp4B232OwZVs66VtvBikgQOGzDnldt2t0uEUjPHL
 dVX+VPw+6RD0js7Kr+3FRo67igvaZg==
X-Google-Smtp-Source: AGHT+IF3hROYoDCS1hO41P1oM8NXxKoOBwYdjkSygtTGJdSCz+R5viMeN+1Yw/VFITJkAcfVYyLIW4VR2yoQ0cXw6J0=
X-Received: by 2002:a17:906:dc89:b0:b73:6b85:1a9a with SMTP id
 a640c23a62f3a-b7671591ebemr330236166b.21.1763747470654; Fri, 21 Nov 2025
 09:51:10 -0800 (PST)
MIME-Version: 1.0
References: <20251115000237.3561250-1-alex.hung@amd.com>
 <cbe00ac4-a535-47d3-813a-e2eda7e9b991@amd.com>
In-Reply-To: <cbe00ac4-a535-47d3-813a-e2eda7e9b991@amd.com>
From: Xaver Hugl <xaver.hugl@gmail.com>
Date: Fri, 21 Nov 2025 18:50:59 +0100
X-Gm-Features: AWmQ_blPOyJRHHyAhmzIMJ97nbk2_s8DU5jtcmQ-QZC3hMwvXMbdNW-TOUolRQ8
Message-ID: <CAFZQkGwRbuE9Whp0YNMA9Q8074B_c3+MhzzUQ_Y+gHaBkogKuQ@mail.gmail.com>
Subject: Re: [PATCH V13 00/51][FINAL] Color Pipeline API w/ VKMS
To: Harry Wentland <harry.wentland@amd.com>
Cc: Alex Hung <alex.hung@amd.com>, dri-devel@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org, wayland-devel@lists.freedesktop.org, 
 leo.liu@amd.com, ville.syrjala@linux.intel.com, pekka.paalanen@collabora.com, 
 contact@emersion.fr, mwen@igalia.com, jadahl@redhat.com, 
 sebastian.wick@redhat.com, shashank.sharma@amd.com, agoins@nvidia.com, 
 joshua@froggi.es, mdaenzer@redhat.com, aleixpol@kde.org, 
 victoria@system76.com, daniel@ffwll.ch, uma.shankar@intel.com, 
 quic_naseer@quicinc.com, quic_cbraga@quicinc.com, quic_abhinavk@quicinc.com, 
 marcan@marcan.st, Liviu.Dudau@arm.com, sashamcintosh@google.com, 
 chaitanya.kumar.borah@intel.com, louis.chauvet@bootlin.com, mcanal@igalia.com, 
 nfraprado@collabora.com, arthurgrillo@riseup.net
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 24 Nov 2025 08:12:45 +0000
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

Am Do., 20. Nov. 2025 um 21:13 Uhr schrieb Harry Wentland
<harry.wentland@amd.com>:
> Xaver, are the kwin patches ready to be merged?

Yes. I'll need to take another look at making the rewritten KWin->KMS
color pipeline matching algorithm easier to follow, but I split that
out into a separate commit, and basic support for drm color operations
is ready to be merged (the only thing the basic version can't do is
tonemapping, but it's useful without that as well).
Just to be sure, I also tested it again on top of the latest kernel
patches and it works as expected.

- Xaver
