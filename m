Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D529C43334
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jul 2022 15:20:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADAC510E620;
	Fri,  8 Jul 2022 15:20:39 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF8B210E622
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jul 2022 15:20:38 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id a9so8526485ejf.6
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 Jul 2022 08:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NvfOvaZIT8+ZZv1AoqnWxdQhwyarbX7+jknoMLrUCew=;
 b=qdKssxsmKjBZ2thhmEAnglvORQi0SfXtMWFbBjY2igAf35bDnri8WN2vXDnLo4J0h5
 wYZKBxzTmhF7Al5kCIUsPCg1bz3A0MJdlBnAlHyGojC1o3vwBEdJZJo95od6UfptFoms
 H8oKB/X2OGIV10MqOPL6ZWeck6Gr4f+mbv4kcFPdHS0ZTDXjogyyyyDK6ELJGWUeEf6p
 lGVAJmAFEVD6WT476VcGqFWSVdaUHU8z2rG9pFAzdqJPFXouKMPeCi3SFa53S5/7hgLz
 yLhsd1RuiwESB9i9uWVwoLQ0jshCSOoYlTTg3L0APiypx3UeopADTxOBCqTkGyMK879u
 Wvww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NvfOvaZIT8+ZZv1AoqnWxdQhwyarbX7+jknoMLrUCew=;
 b=l4grsMmcaJ9NLzKpLQw1uaFvuig5v4sneBhc4R3NI8659WHVdu1Z2fOjrNv2hf/KmQ
 kAk3AMWcfh8cw4snC/M3zYVFxQyqixtOxVSiLbtXQRJx0GCVOJte/I/MGFtmmCqsew0p
 xz9sa95KqYsJpCmy4LFb86soguvDgBzNg1idpBoGzcYGcIlb2i33YT/Sv4Cp5tO+JuL0
 QymilqR7V6cbNhNQR1vMDT7wpaNSomZTZO5c2i8gsVjjAXtN798krSA6bJLVZbYICXcH
 9vhUxz0PBpVOXjApyxQa1ize6KssYJOWZAxr77J88I+/Lgt9Juogy2QtmzhxDG1WRi5c
 EIBA==
X-Gm-Message-State: AJIora+gSY3Sd6SuBuboKIorKMDM/3pae5aQ05F6yge2ZxATbdA1R9Jl
 ChwgOZwV1qNbl5Vd35fAxKupYqus4UuTiAPr4V9MHOckyQM=
X-Google-Smtp-Source: AGRyM1tVheo9mYr+Vn1hZvF5Fe1JXX2Mu/cDtR24bzsxYc4nBDP1DvyTY6DQx+DLWVCSAB11tKRJ/0v3yKvBDimKT44=
X-Received: by 2002:a17:907:d22:b0:726:dbb1:8828 with SMTP id
 gn34-20020a1709070d2200b00726dbb18828mr4165834ejc.722.1657293637455; Fri, 08
 Jul 2022 08:20:37 -0700 (PDT)
MIME-Version: 1.0
References: <625b6eec-6ecb-cd97-3061-408ebfb7539c@cam.ac.uk>
In-Reply-To: <625b6eec-6ecb-cd97-3061-408ebfb7539c@cam.ac.uk>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 8 Jul 2022 11:20:25 -0400
Message-ID: <CADnq5_OeX7Yi4srZDPQH-dO0A8NkAp3huh6WqO8Uf1Unv1+sSg@mail.gmail.com>
Subject: Re: Radeon Evergreen/NI, power modes & DL-DVI
To: mjr19@cam.ac.uk
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jul 8, 2022 at 11:05 AM <mjr19@cam.ac.uk> wrote:
>
> Most Radeon Evergreen and Northern Island cards support power-saving modes
> with Linux and XOrg well, and have done for years. But if a dual link DVI
> monitor is in use (e.g. a 2560x1440 or 2560x1600 screen), the card will
> refuse to transition out of its high power mode while the display is
> active. I believe that this is because transitions are not supported when
> multiple displays are active, and dual link DVI is counted as being two
> displays.

This has nothing to do with dual link vs single link.  Whether or not
we can change memory clocks comes down to the length of the vblank
period.  We can only change the memory clock during display blanking
periods otherwise you get display disruptions.  WIth multiple displays
this is obviously more complex because the blanking periods may not
align at all.  With single displays however, the blanking period needs
to be long enough to allow the memory reclocking to complete.  Some
displays have a very short vblank period which is not long enough for
a memory reclock.  One option in that case is to tweak the display
timing a bit to extend the vblank period.  Also, depending on the
chip, mclk switching is not possible with very high refresh rates.  In
your particular case, you might be right on the edge of the time which
is why the driver disables mclk switching even though it might appear
to be possible.  Even in some rare cases where users were under the
limit, they were near enough to it that you periodically would see
display disruption during certain mclk reclocks.  See
radeon_dpm_single_display() in radeon_pm.c.

Alex
