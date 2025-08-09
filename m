Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38844C87FD2
	for <amd-gfx@archiver.kernel.org>; Sat,  9 Aug 2025 20:25:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5EA210E21C;
	Sat,  9 Aug 2025 20:25:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FmLR2+JS";
	dkim-atps=neutral
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com
 [209.85.208.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AFAE10E21C
 for <amd-gfx@lists.freedesktop.org>; Sat,  9 Aug 2025 20:25:13 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id
 4fb4d7f45d1cf-61530559887so5134593a12.1
 for <amd-gfx@lists.freedesktop.org>; Sat, 09 Aug 2025 13:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754771112; x=1755375912; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xzGHbrJ6iFxtHpy6NalkPNI0U2UsmEg20gwB+0wDnUY=;
 b=FmLR2+JSNQIJpRBfoXGW6HFgSMlRb/vt+Py1lbSamrKRmLnQWZcotkbvgYOhcoesGx
 CPgyhM8YT0d+cSN1bsUdYEroy1LVAIq1rgMXmDZQFclXIAt5Z+BDvUKcIWVn34/moJpe
 fzhJZbhAEYXeKYX2rTG034NmM92aVaF+TwIoTQyqyBPh3MIwtsC6Tqhksa94V23rTAV1
 nT88AF3zGr3t5n/9FpZmbFnHnXbWYAuI03lUe15jlA+nQ9DUYr/Ap77N+fsWQCVlJXmp
 cVnw4Ab6yySrQ4N4/OvH9JvVr02tJ3hSejHInd2T7Yh7dbgGRPlzFm8L8RKg2ksmvBRZ
 +KmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754771112; x=1755375912;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xzGHbrJ6iFxtHpy6NalkPNI0U2UsmEg20gwB+0wDnUY=;
 b=N+Hvcj5vjXzdnWzsYhmMMaHpj6Vwn7YuOYU0Ne8tnQHcTZq5TynJChhJx2uhwQrTB7
 LTanZGEc70UIev7zPT4Y9qvDT9jP3cU2jOZMSqF8eJEslHhKBWCoK7Ctg5rw8oR5xuXo
 LZSKJFmDc1xZftCiOF7fwZXsjEsUXRSkA2tnJziJ6tzCRYz77lu9dGvcsw2PI97sbJix
 7ODw7LcUKfR2Vd6SoesZZoneHgJGQZC5ejvGyh9u/Cm4QzZeThAWW4/DhJ48kIX2Qvsq
 kikiDwrLdKRl/UhkM0PpqFA+2LOW6MsHnSh52JwyqQqhI9HzhlRRV0NLshdnOcifkxoX
 zUtQ==
X-Gm-Message-State: AOJu0YyU8UKUGkADOmZON4z35vw8RYnB3rYE0/KpTIg0y1NG1DxEBE0i
 2w7T2N021xl+PZXdNaVVKrqj2jETQdGDee95AeUOOdlA/QlGsgJh/m/Axf+Hdw==
X-Gm-Gg: ASbGncv5Xe5WnHkD7jdTwTEpamzf5rmfR4kl+SNUlG6RJbJjBqjePztVoBZRizP2RR6
 zBTCcprUSC9d7TGp4ULHtc0SVZ74kK+1ZA++x+AoTfDbzPOvtohSY3q7b2Q7AJmGeSUPt1LAlIN
 XkKZZCx0tOCxX0iLmVgR4PNdcf/GvxbO3Z295PYmiSQztPp9ukz7XrA2fSw0PH+Knf6pvgT9uqr
 fkTpoKcueTcnmHgD1MadHsB3eQn0LswYbuGmdmfgnMweMcgS0eoZqxhTsOUXLlny44pgdGWEG10
 MYQKJ4oU9bseq3yQ6gYOhZJR6tWwm6sdg63OUHkPjmIf5GBrpNXCIkoMwVg+CfCPTWdbOGff1Ql
 H7okuu1kIiAYhXT7wGVDoT1fQ9FNoFkWXRIlNEpGhk5EEeJnvYdYxISvQ7niJg5d5Kovnl3BRsH
 U=
X-Google-Smtp-Source: AGHT+IFiwW5u9mkhoCmQBI/9bXi9yAw/xZYvMu/bsMn8WYekUIVxtE+XH68lWKkda07i0/dvOLdOiA==
X-Received: by 2002:a05:6402:254d:b0:615:a7f4:da26 with SMTP id
 4fb4d7f45d1cf-617e2bbbd55mr5678279a12.12.1754771111403; 
 Sat, 09 Aug 2025 13:25:11 -0700 (PDT)
Received: from ?IPv6:2a0a:f640:1601:b924:fc04:eba8:855f:f82?
 ([2a0a:f640:1601:b924:fc04:eba8:855f:f82])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-617f648789dsm2171907a12.53.2025.08.09.13.25.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Aug 2025 13:25:10 -0700 (PDT)
Message-ID: <a30a2c710669c7e48a42453a52a691b2b1680b2e.camel@gmail.com>
Subject: Re: [PATCH 0/7] DC: don't overclock DCE 6-10 and other fixes
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, "Wheeler, Daniel"
 <Daniel.Wheeler@amd.com>,  "Wentland, Harry" <Harry.Wentland@amd.com>
Date: Sat, 09 Aug 2025 22:25:09 +0200
In-Reply-To: <20250731094352.29528-1-timur.kristof@gmail.com>
References: <20250731094352.29528-1-timur.kristof@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
MIME-Version: 1.0
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

Hi Harry & Daniel,

I apologize, I just realized that I forgot to copy you directly on
these series. Can you please take a look and review?

DC: don't overclock DCE 6-10 and other fixes
https://lists.freedesktop.org/archives/amd-gfx/2025-July/128002.html

drm/amd/display: Fix DP audio DTO1 clock source on DCE 6.
https://lists.freedesktop.org/archives/amd-gfx/2025-August/128101.html

DC: Fix page flip timeouts on DCE 6
https://lists.freedesktop.org/archives/amd-gfx/2025-August/128102.html


Thanks & best regards,
Timur

On Thu, 2025-07-31 at 11:43 +0200, Timur Krist=C3=B3f wrote:
> This series fixes various issues that I found while trying to
> get old GPUs with DCE 6 to work well with DC.
>=20
> The most important part of this series is tweaking how
> the engine clock is set on DCE 6-10.
>=20
> For DCE 6 the maximum according to max_clks_by_state is 600 Mhz,
> but dce60_validate_bandwidth sets it to 681 MHz, and then
> dce60_update_clocks further increases it by 15%, resulting in
> a whopping 783 MHz, which is overall 30% more than what the
> hardware was supposed to handle. My Tahiti GPU didn't even boot
> with DC enabled with that clock setting.
> There is a similar issue with DCE 8-10 too, additionally the
> dce80_max_clks_by_state data seems to be incorrect, so I changed
> the maximum to 625 MHz for DCE 8-10, which is what the legacy
> code uses.
>=20
> I tested these changes and made sure 4K 60Hz (10 bit) output
> still works with them on the following GPUs:
>=20
> * Tahiti (DCE 6)
> * Oland (DCE 6.4)
> * Hawaii (DCE 8)
> * Tonga, Fiji (DCE 10)
>=20
> I would appreciate if someone from AMD could confirm what the
> maximum display engine clocks for these parts really are.
>=20
> Other than that, the rest of the series deals with some
> ligher problems:
>=20
> There are patches to fill the display information on DCE 6-10
> (previously only filled on DCE 11), such as the first CRTC and
> its line time, as well as vblank time, display clock etc.
> These are going to be needed for DPM.
>=20
> It also removes some errors and warnings from the logs which
> are caused by the VBIOS on old GPUs reporting some information
> differently, namely some VBIOS seem to lack encoder capability
> entries for some connectors, as well as the actual amount of
> connectors on the GPU not matching the number of entries
> reported by the VBIOS.
> The DC code base already handles these cases well. They are
> not actually errors, so we shouldn't spam the logs with them.
>=20
> Finally, there is also a fix for set_pixel_clock_v3 which
> works slightly differently than the other versions.
>=20
> Timur Krist=C3=B3f (7):
> =C2=A0 drm/amd/display: Don't overclock DCE 6 by 15%
> =C2=A0 drm/amd/display: Adjust DCE 8-10 clock, don't overclock by 15%
> =C2=A0 drm/amd/display: Find first CRTC and its line time in
> =C2=A0=C2=A0=C2=A0 dce110_fill_display_configs
> =C2=A0 drm/amd/display: Fill display clock and vblank time in
> =C2=A0=C2=A0=C2=A0 dce110_fill_display_configs
> =C2=A0 drm/amd/display: Don't warn when missing DCE encoder caps
> =C2=A0 drm/amd/display: Don't print errors for nonexistent connectors
> =C2=A0 drm/amd/display: Fix fractional fb divider in set_pixel_clock_v3
>=20
> =C2=A0.../gpu/drm/amd/display/dc/bios/bios_parser.c |=C2=A0 5 +--
> =C2=A0.../drm/amd/display/dc/bios/command_table.c=C2=A0=C2=A0 |=C2=A0 2 +=
-
> =C2=A0.../display/dc/clk_mgr/dce100/dce_clk_mgr.c=C2=A0=C2=A0 | 14 +++---=
-
> =C2=A0.../dc/clk_mgr/dce110/dce110_clk_mgr.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 40 +++++++++++------
> --
> =C2=A0.../display/dc/clk_mgr/dce60/dce60_clk_mgr.c=C2=A0 | 10 ++---
> =C2=A0drivers/gpu/drm/amd/display/dc/core/dc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 15 ++++++-
> =C2=A0.../drm/amd/display/dc/dce/dce_link_encoder.c |=C2=A0 8 ++--
> =C2=A07 files changed, 51 insertions(+), 43 deletions(-)
