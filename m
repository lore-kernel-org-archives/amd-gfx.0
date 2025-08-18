Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49A3CCA0EE4
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Aug 2025 14:45:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6DC710E1DC;
	Mon, 18 Aug 2025 14:45:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="l1AI0tY/";
	dkim-atps=neutral
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7FCE10E1DC
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Aug 2025 14:45:04 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-24457f57ed4so7589135ad.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Aug 2025 07:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755528304; x=1756133104; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4ODCObxXMDHZMPb8viIL32XZ4JBE+/PP49rJ0tHf9xc=;
 b=l1AI0tY/5SC2nJuFK2/X4NM32qAqHKepX8O3SaskkKZf2MNAlcj9bnwCnVjCpo5fJK
 ZzaS7nN7oimTD6GmRH45ypEfnZdAX4EATcwZw014PFz6XbXVmHc8mG9mow0xwJKDYaPl
 oTgIE1aMQaM5xjsm/HUSiuaMsvTKUpPH26KC/3FgX8m5tYL2YDSKeVAQrO3PtlCR8RpJ
 fiPiiCdxZDC3OxQVQm2enV2693qMz5wpV9Cn8rpQq3BrV4KnAeuhKfNVhtjzoIqHtkc5
 darIMbQDGv1PH/MjKQv6E0iuMnFhSzI9GJM3WttNQbtjnZSNV72g47gebYAYvmslG4ZE
 eh9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755528304; x=1756133104;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4ODCObxXMDHZMPb8viIL32XZ4JBE+/PP49rJ0tHf9xc=;
 b=Slb5c/Ba2HM8n0O2bkGkV0S4h3iNlm5T8W7VqWdE7bS+nyGWDcLdHVrDGnW4U8XFR6
 TrgLNBAH/xIU/d32QWOQzjTV13zPhLRX3WmTbhWbazvuWmmxk1X+JTdH+TSAskBIG/YJ
 ssr6atWfm9MX0cI+r5q4GPHP2q1EY/Xlpu+/tJEHDfkyKH8ez/VHR5YhAIVkzCS3QCBe
 eEjMblF+vkhF1OjQ+2ECofv6iKmccu1R28N8nCusFVzQPt5FaIe8VTlfmZU/kIYs6Gah
 xtovjpm8V/tz3+lGszKHEIuF0ypFQz7t8CucQAUmjZLwwU5BDmmUDf8KvJWor57C2JQ0
 nqjg==
X-Gm-Message-State: AOJu0YzxBtViSmmU91/rBITi0elStNRsJ61Q4tcnGf5hWepzw2mRSpZJ
 jh7pbL4JKYSvwuckQ+ibTdZdqZzrMS4vWDVI5U5zyKXuey9obLzKf/hj1StAiV+AlhLfkhrdu+U
 e2YVa0jWW2jL52boBo6dPFgMVZwlOhvI=
X-Gm-Gg: ASbGncv98O9HYLaQZfYwCgXxdF7WNYzuSF4Fm27/aYUY/Y+VbEE3eqk8XZ7GAcVVySn
 NKz8WIlVzX1WsUmIGxVHDejknB5w0cDmC8ZvWkdS60bmY8rtfaiGs31Z050JzupsDYk+agjiVzN
 18JQC5bZfx4SEezbtbXWKI4X8EczWDxCCQLOFYupYpTjVAGrKEhjCDGYHQWq4mRsjKjvygeYaD3
 1KNGSw=
X-Google-Smtp-Source: AGHT+IFf8miA2AqUhi2CCFK9qH2gp0VKF6grn/ClIE+2k/LYuPm47czeYDy8aGrlmSjZTg7kGQkWPxaosO08mFivOX4=
X-Received: by 2002:a17:903:11c8:b0:240:33c7:fbf9 with SMTP id
 d9443c01a7336-2446da155e8mr82000035ad.11.1755528304022; Mon, 18 Aug 2025
 07:45:04 -0700 (PDT)
MIME-Version: 1.0
References: <20250731094352.29528-1-timur.kristof@gmail.com>
 <b4b90c56-f46c-4a0b-bfe3-196823e389cf@amd.com>
In-Reply-To: <b4b90c56-f46c-4a0b-bfe3-196823e389cf@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 18 Aug 2025 10:44:52 -0400
X-Gm-Features: Ac12FXynhHlqsLlSqVb-SM9NjezV-5uVdsfXWK_2i7nUNU3rLNGyYhCxCD_LQRY
Message-ID: <CADnq5_NDwdd8z4nBf6LngpUeM4txPHtFz44c5epVz8cMCV8XwQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] DC: don't overclock DCE 6-10 and other fixes
To: Alex Hung <alex.hung@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Sun, Aug 17, 2025 at 11:08=E2=80=AFPM Alex Hung <alex.hung@amd.com> wrot=
e:
>
> Reviewed-by: Alex Hung <alex.hung@amd.com>
>
> This patch series was also tested in the promotion test and in CI
> without any regression.

Did you pick these series up or would you like me to?

Alex

>
> On 7/31/25 03:43, Timur Krist=C3=B3f wrote:
> > This series fixes various issues that I found while trying to
> > get old GPUs with DCE 6 to work well with DC.
> >
> > The most important part of this series is tweaking how
> > the engine clock is set on DCE 6-10.
> >
> > For DCE 6 the maximum according to max_clks_by_state is 600 Mhz,
> > but dce60_validate_bandwidth sets it to 681 MHz, and then
> > dce60_update_clocks further increases it by 15%, resulting in
> > a whopping 783 MHz, which is overall 30% more than what the
> > hardware was supposed to handle. My Tahiti GPU didn't even boot
> > with DC enabled with that clock setting.
> > There is a similar issue with DCE 8-10 too, additionally the
> > dce80_max_clks_by_state data seems to be incorrect, so I changed
> > the maximum to 625 MHz for DCE 8-10, which is what the legacy
> > code uses.
> >
> > I tested these changes and made sure 4K 60Hz (10 bit) output
> > still works with them on the following GPUs:
> >
> > * Tahiti (DCE 6)
> > * Oland (DCE 6.4)
> > * Hawaii (DCE 8)
> > * Tonga, Fiji (DCE 10)
> >
> > I would appreciate if someone from AMD could confirm what the
> > maximum display engine clocks for these parts really are.
> >
> > Other than that, the rest of the series deals with some
> > ligher problems:
> >
> > There are patches to fill the display information on DCE 6-10
> > (previously only filled on DCE 11), such as the first CRTC and
> > its line time, as well as vblank time, display clock etc.
> > These are going to be needed for DPM.
> >
> > It also removes some errors and warnings from the logs which
> > are caused by the VBIOS on old GPUs reporting some information
> > differently, namely some VBIOS seem to lack encoder capability
> > entries for some connectors, as well as the actual amount of
> > connectors on the GPU not matching the number of entries
> > reported by the VBIOS.
> > The DC code base already handles these cases well. They are
> > not actually errors, so we shouldn't spam the logs with them.
> >
> > Finally, there is also a fix for set_pixel_clock_v3 which
> > works slightly differently than the other versions.
> >
> > Timur Krist=C3=B3f (7):
> >    drm/amd/display: Don't overclock DCE 6 by 15%
> >    drm/amd/display: Adjust DCE 8-10 clock, don't overclock by 15%
> >    drm/amd/display: Find first CRTC and its line time in
> >      dce110_fill_display_configs
> >    drm/amd/display: Fill display clock and vblank time in
> >      dce110_fill_display_configs
> >    drm/amd/display: Don't warn when missing DCE encoder caps
> >    drm/amd/display: Don't print errors for nonexistent connectors
> >    drm/amd/display: Fix fractional fb divider in set_pixel_clock_v3
> >
> >   .../gpu/drm/amd/display/dc/bios/bios_parser.c |  5 +--
> >   .../drm/amd/display/dc/bios/command_table.c   |  2 +-
> >   .../display/dc/clk_mgr/dce100/dce_clk_mgr.c   | 14 +++----
> >   .../dc/clk_mgr/dce110/dce110_clk_mgr.c        | 40 +++++++++++-------=
-
> >   .../display/dc/clk_mgr/dce60/dce60_clk_mgr.c  | 10 ++---
> >   drivers/gpu/drm/amd/display/dc/core/dc.c      | 15 ++++++-
> >   .../drm/amd/display/dc/dce/dce_link_encoder.c |  8 ++--
> >   7 files changed, 51 insertions(+), 43 deletions(-)
> >
>
