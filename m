Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87EE1C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Apr 2022 21:39:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3346210E036;
	Mon, 11 Apr 2022 21:39:48 +0000 (UTC)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A26AE10E036
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Apr 2022 21:39:46 +0000 (UTC)
Received: by mail-il1-x135.google.com with SMTP id e1so12393486ile.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Apr 2022 14:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:from:date:message-id:subject:to;
 bh=0bIfDh535F17EPoR6l5KVLN12GNis9QLPKagtgcgGkE=;
 b=SgQ/3YNB1kN0GxPiZPAq/vYYGF2quX88cJXLvK61O0qktgWUqzexBpvmRXwI685e0h
 sCYjv/FyalXq/x7HnZ7qJO9/bAYwJMGao5/F+M/sCaL+caGSi0GKpKWRX+z9opbUDs19
 WOENx7fvh1CsGuhANOeaqkF6CAbMEPqA1zVpgxvVn2kGSeDO47gXpehKff++4LenwTBD
 KCjMoO2T/mj6IZXU8QMiNHbzjyS6SxOlEapqSj56rls7dOH6n6IC366VBO/f2kL6j/Sk
 ZyzQaAboQZcae5s+w1s+aHaZJqOSCaE1tBoNIhWkYYyLrCsSP1h+pHhC2LCg50Q9P3mX
 h3bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=0bIfDh535F17EPoR6l5KVLN12GNis9QLPKagtgcgGkE=;
 b=WqFaVVy4sQoK60x0JVuQKxnQPtS4Kn6MorcN1oRXGSZPdGiqM5H4sMPzD6u0UA4Y5F
 V3VzGk3XK5Up3I1PpUNt9tE6KNeMDw6Sf3xmEffeg67wmuAebA9l+HElLIOT9MQs504r
 KlxsEYqeGUdGl10/Nwauz7RgYlDXTkTScpqxs0BXqOJWfVLLCblDOqge9HKZtx0xbPfS
 URUJMZJal5B6FeCOa6q9XT2SiPFpdfJy4tpQ/bmKSK90EMlLw5uXoeiuZcQ43vc5QEJa
 WKQou3zFVOQRjMlyl500rlSPeJ2ZGc8/DHNjQ2Vj0v0xh2R1+csmR3VvwfPRgxF8qbIu
 DcFg==
X-Gm-Message-State: AOAM533qNOPcwQONiPfJLFILnHhbPIYtQklJsVzpQHiXTyinl3ZefZUY
 ox/a0P6ilSkARNL5wV5A6j9oCJkIQzict2xmoMr5jw9OwHg=
X-Google-Smtp-Source: ABdhPJwlrkj0YpWsktKWwnorvs01dELgX1Cv+LFfm/SP0x9rUs+OHuJzIOIFeG8UcS6DI7ShnhwJiXp6A7AtPzCmLDI=
X-Received: by 2002:a92:602:0:b0:2ca:480a:c19d with SMTP id
 x2-20020a920602000000b002ca480ac19dmr14692148ilg.223.1649713185333; Mon, 11
 Apr 2022 14:39:45 -0700 (PDT)
MIME-Version: 1.0
From: James Dutton <james.dutton@gmail.com>
Date: Mon, 11 Apr 2022 22:39:09 +0100
Message-ID: <CAAMvbhF-mcZd+mfSUVpYShvKmFiQ6pb+j2eosBr-kvsxE+202g@mail.gmail.com>
Subject: Vega 56 failing to process EDID from VR Headset
To: amd-gfx@lists.freedesktop.org
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

I have an Oculus Rift S, that I am trying to get working in Linux.
I have an AMD Vega 56  graphics card.

The VR headset plugs into a display port of the Vega56.
The amdgpu driver sees the connection, and tries to process it.
The problem is it cannot process the EDID, so fails to recognise the
VR headset, and the VR headset does not work as a result.
Please find the EDID below.
I am guessing that the following is causing the problem:
Established Timings I & II: none
Standard Timings: none
Forcing the driver to understand the Detailed mode, to which it is failing.
If it helps, when attached to windows 10, it uses 1440x2560, portrait mode.
Some dmesg lines that may be useful:
// We should pick 1440x2560 as Windows picks that, but for some reason
is rejects it with error 10.
[10402.650734] [drm:create_validate_stream_for_sink [amdgpu]] Mode
1440x2560 (clk 571570) failed DC validation with error 10 (No DP link
bandwidth)
[10402.650991] [drm:update_stream_scaling_settings [amdgpu]]
Destination Rectangle x:0  y:0  width:1440  height:2560
[10402.651225] [drm:create_validate_stream_for_sink [amdgpu]] Mode
1440x2560 (clk 571570) failed DC validation with error 10 (No DP link
bandwidth)


Can anyone help give me with some pointers as to how to get the amdgpu
driver to accept this EDID?

edid-decode (hex):

00 ff ff ff ff ff ff 00 3e d2 12 00 00 00 00 00
01 1d 01 04 a5 00 00 00 0e 00 00 00 00 00 00 00
00 00 00 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 45 df a0 38 51 00 ee a5 d2 0c
f1 0c 00 00 00 00 00 10 00 00 00 ff 00 31 57 4d
47 48 35 32 30 47 41 39 35 32 00 00 00 fc 00 52
69 66 74 20 53 0a 20 20 20 20 20 20 00 00 00 10
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 33

----------------

EDID version: 1.4
Manufacturer: OVR Model 18 Serial Number 0
Made in week 1 of 2019
Digital display
8 bits per primary color channel
DisplayPort interface
Image size is variable
Gamma: 1.00
Supported color formats: RGB 4:4:4, YCrCb 4:4:4
Default (sRGB) color space is primary color space
First detailed timing includes the native pixel format and preferred
refresh rate
Color Characteristics
  Red:   0.0000, 0.0000
  Green: 0.0000, 0.0000
  Blue:  0.0000, 0.0000
  White: 0.0000, 0.0000
Established Timings I & II: none
Standard Timings: none
Detailed mode: Clock 571.570 MHz, digital composite
               1440 1650 1662 1752 (210  12  90)
               2560 2623 2624 4078 ( 63   1 1454)
               -hsync
               VertFreq: 80.000 Hz, HorFreq: 326.239 kHz
Display Product Serial Number: 1WMGH520GA952
Display Product Name: Rift S
Dummy Descriptor
Checksum: 0x33
