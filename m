Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16363FED3F0
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2026 16:47:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B10310E0ED;
	Fri, 24 Apr 2026 16:47:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kx3tSgdu";
	dkim-atps=neutral
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D233510E0ED
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Apr 2026 16:47:07 +0000 (UTC)
Received: by mail-dl1-f42.google.com with SMTP id
 a92af1059eb24-12c7288cfb9so175256c88.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Apr 2026 09:47:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777049227; cv=none;
 d=google.com; s=arc-20240605;
 b=Q+bYPtgV4fzXNZD/euSN0jfaIU+E5pnpCjPlCpxpPme9s+laYKIsuVsGQ2901ro21c
 EmGKgPhZ6zcN48fF8Oebg+3eSZACxbtaLZZnawnfyRBRg4XscGsQux7I+iB6sThRfhyn
 lEfZJy6ZmWD44otCwpEGmZuzeg3rms2HyWGdDHq5BwEGKsDo0wEPIlwojwnWnyNIkcJK
 Cvj6RBpBlVNqr+M07caD75S7wF4keCgM7NBlfWMVqpHsJ6ag7Sa5iChYBbLvWbv9DpbK
 SZMgjpPyXoXTMzxsvtY9YWbdUF5z3oQdFuobIB7RXt+siZOoeCSqbsOoE5x0N4tWrGrh
 VOhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=eZvZViiM+KTU4U/lHwXHb/VYi6/H9RrxQbIfS0n37TE=;
 fh=tdeteHDu0TTxjlo1rS45TJ4py/kcUPjpsWnOyQTw0sw=;
 b=ayUgoa70KBlGXUIt33+AFpkQhMF5DXPQfBhoVZbjrGzanVpPDynvo3GBohT/XIHFKf
 dBW7lkffaLp/nALVm1tQME8z0QPqP0y+RrDfTcroRROw4Q267LVQHELtD40le2VvFbQf
 oA/X1BIQfGQTcRL1zz/99AN8KjDX4y9rmcYpbHjUZdI8IZAlvuWU9L1cv8s5ubneAzGX
 JtFRD70VhzGgOS5q+551iF057EfadISqpWoSvF3QXivjWoPteSRgl+rns0MSB+HA2jrf
 3R+AJLp9dpaciw1+tni/R9PIFLjulhE7ki2xtE6yAMpQD+u8agmOiPLkDCeRzQNRsAev
 1JuA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777049227; x=1777654027; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eZvZViiM+KTU4U/lHwXHb/VYi6/H9RrxQbIfS0n37TE=;
 b=kx3tSgdufT/FxDOoOp9V4P/m7DFWmYz8u3hWyf7N4RV/U/Yb3EJ2XCPnrG0otvhviZ
 kF5UkQnsrFW/GwZ4pFoDvMQ8IQb2H8xvbXIabAWO53QayA2SqWWu4BiSI1KgU0B45Dio
 qwX3aK9UzYjnw4OZQ874F062fNKzsVm5yJuBNzRC/lrGVseGG51YTkSI40h66W2t6zkd
 6uwgKzyiL/COqdN5TOZKphtW1EDPsaA75NL8QQDO0OQkPboVuPaGC7sesJqXo7zLzlCz
 Rvg2thpx+et8UgEwC1bMVbBGr/gvN/h98K9HxkW9ToDSvz+H4FSvC6Hzar7rT0iMn4Ub
 isow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777049227; x=1777654027;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eZvZViiM+KTU4U/lHwXHb/VYi6/H9RrxQbIfS0n37TE=;
 b=QWPS27L94WEkbx8wY3/ZWiMMIqjeZykret3/4rnuiveGwHI431OXlBGEDCk7gJfQl5
 7tRrBTPgb5CgRxsqBK83RY08a7jOIxiv5qOlwYTfflh81LacZjRXq/nlP1o6W3flL2g+
 tfZ2mht0hTRDIdqwG+knANAlT0GIio4bwa+V4MGpLoGQjAOM6sT8/ch0xEglCBSouHQv
 /mILXe/etWB5XFCwdRb6nXARu0SJfw0dyw4AUb68KQCWSIydW5AsiUsAdDfddF42SZRG
 twoNpXPROc83Y0irJ6mnRK/r1ewDpRcjC7SuUnXw+QDHEJPuqW/dwZQSZNAx9fJBpcuN
 t+tw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9DpCrbaUAr/onK1qqR21Tb9rIoSbxF0KSj/fAci1s4YMK9txw36IaLOosBBQ48bzhbLU4GnlDz@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyn5rqxO9JVXvaT3jQDhA85dqyeuAlG6HFVwki2uMXe8+ZlCOvc
 TavuY41Kqm4pfvjbsIqjz6GAh+8/wrGEn34iG2y2Bc6gcZN7Q/WNUxS4zqbIGJoMkm4F+o8KJsr
 we2E7hIpRTZ+ncQ1pOuWd27XPwmdZG4Q=
X-Gm-Gg: AeBDiessvTJVgNjjIvtsiShng1Yn4bA+wEf1bukFbutN6Z0jVcohHPkrfdoxOsFXxZm
 BsGqMtDAUbdfn5m/PM+Zh341Gpa7DMyXxuZxzYOPj2pcfqvHhCmPQ1WEf4TIaH4s38UQjyduxZG
 YuZ8ZnlSkpI1kUNmkYaqx4Dw0eIXz11lit/dlBcdZ0bh/7ZqU6+nWCF1VEDwh+AMwlo3oKaSncT
 xXhnAP2vbK9FVvlpPEyROoVTpGCAhsxLAiTswVjh6W0R1DyHnLHNpdpMZZ8u1zP11ohXvvAiiCs
 vPiboYhz4eaxPoQFfkgChAywvZN4IqGz13hAzkIsbGtdWUnecc6jQfblKXkb9Q2V7Mb3z+yG0x5
 uGGYI
X-Received: by 2002:a05:7022:5f01:b0:12d:b654:8180 with SMTP id
 a92af1059eb24-12db65484bfmr1873101c88.2.1777049226880; Fri, 24 Apr 2026
 09:47:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260306031932.136179-1-alex.hung@amd.com>
 <20260306031932.136179-20-alex.hung@amd.com>
 <7370736.9J7NaK4W3v@timur-max>
 <df82dbc6-623f-4be7-acbc-49157e59764c@leemhuis.info>
In-Reply-To: <df82dbc6-623f-4be7-acbc-49157e59764c@leemhuis.info>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 24 Apr 2026 12:46:55 -0400
X-Gm-Features: AQROBzBraznBYsAZpxHnqUE8Q_8czz02MUBY3I2yXLrWz3uNfcj8hqf_okcVyc4
Message-ID: <CADnq5_MFgdSH6sXPg+bpHYda0SGkK+sLevgwXNo+iDJmYMOdzg@mail.gmail.com>
Subject: Re: DC analog support regressed by "drm/amd/display: Sync dcn42 with
 DC 3.2.373"
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, 
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, 
 Fangzhi Zuo <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>,
 Ray Wu <Ray.Wu@amd.com>, 
 Ivan Lipski <ivan.lipski@amd.com>, Alex Hung <alex.hung@amd.com>, 
 David Airlie <airlied@gmail.com>, Christian <christian.koenig@amd.com>, 
 Linux kernel regressions list <regressions@lists.linux.dev>
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

On Fri, Apr 24, 2026 at 12:34=E2=80=AFPM Thorsten Leemhuis
<regressions@leemhuis.info> wrote:
>
> On 4/13/26 15:09, Timur Krist=C3=B3f wrote:
> > This patch breaks analog connector support in DCE, both for analog enco=
ders
> > and DP bridge encoders, because it deletes key functions such as
> > dce110_enable_analog_link_output, dce110_prepare_ddc,
> > dce110_external_encoder_control, and more.
> >
> > With this patch applied, when you connect an analog monitor you just ge=
t a
> > crash in DC from trying to call link->dc->hwss.enable_analog_link_outpu=
t()
> > which is now NULL.
> >
> > This is basically undoing all the work I did for supporting old GPUs wi=
th DC.
> > I think either this commit should be reverted or someone should add bac=
k the
> > analog support bits that were removed. I'm happy to help with that if n=
eeded.
> > What do you guys think?
>
> I noticed that a patch to fix this mistake is ready by now:
> drm/amd/display: Restore analog connector support --
> https://lore.kernel.org/all/20260418003539.1862136-1-Roman.Li@amd.com/
>
> And from that thread the fix was even "merged" somewhere. But I can't
> see this in -next or Alex' drm-fixes-7.1 pull, so I assume it will miss
> -rc1 (please corrent me if I'm wrong). Is that something to be concerned
> about?

It will be in -rc2.

Alex

>
> Ciao, Thorsten
>
> > As a side question, why was this commit merged without any review or ac=
k?
> >
> > Thanks & best regards,
> > Timur
> >
> > On 2026. m=C3=A1rcius 6., p=C3=A9ntek 4:13:45 k=C3=B6z=C3=A9p-eur=C3=B3=
pai ny=C3=A1ri id=C5=91 Alex Hung wrote:
> >> From: Roman Li <Roman.Li@amd.com>
> >>
> >> This patch provides a bulk merge to align driver
> >> support for DCN42 with Display Core version 3.2.373.
> >>
> >> It includes upgrade for:
> >> - clk_mgr
> >> - dml2/dml21
> >> - optc
> >> - hubp
> >> - mpc
> >> - optc
> >> - hwseq
> >>
> >> Signed-off-by: Roman Li <Roman.Li@amd.com>
> >> Signed-off-by: Alex Hung <alex.hung@amd.com>
> >> ---
> >>  .../gpu/drm/amd/display/dc/bios/bios_parser.c |  11 +-
> >>  .../display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c  | 141 +++--
> >>  .../display/dc/clk_mgr/dcn42/dcn42_clk_mgr.h  |   2 +-
> >>  drivers/gpu/drm/amd/display/dc/core/dc.c      |  95 ++-
> >>  .../gpu/drm/amd/display/dc/core/dc_stream.c   |  41 +-
> >>  .../gpu/drm/amd/display/dc/core/dc_surface.c  |   9 +
> >>  drivers/gpu/drm/amd/display/dc/dc.h           |  59 +-
> >>  .../gpu/drm/amd/display/dc/dc_bios_types.h    |   3 +-
> >>  drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |   2 +-
> >>  drivers/gpu/drm/amd/display/dc/dc_plane.h     |   1 +
> >>  drivers/gpu/drm/amd/display/dc/dc_types.h     |  24 +
> >>  .../amd/display/dc/dccg/dcn401/dcn401_dccg.c  |  20 +
> >>  .../drm/amd/display/dc/dce/dmub_hw_lock_mgr.c |  16 +
> >>  .../drm/amd/display/dc/dce/dmub_hw_lock_mgr.h |  13 +
> >>  .../dml2_0/dml21/dml21_translation_helper.c   |  30 +-
> >>  .../amd/display/dc/dml2_0/dml21/dml21_utils.c |   1 +
> >>  .../display/dc/dml2_0/dml21/dml21_wrapper.c   |  14 +-
> >>  .../dml21/inc/bounding_boxes/dcn42_soc_bb.h   | 308 ++++------
> >>  .../dml21/inc/dml_top_display_cfg_types.h     |  13 +
> >>  .../dc/dml2_0/dml21/inc/dml_top_types.h       |   2 +
> >>  .../dml21/src/dml2_core/dml2_core_dcn4.c      | 204 +++----
> >>  .../dml21/src/dml2_core/dml2_core_factory.c   |   1 +
> >>  .../dml21/src/dml2_core/dml2_core_utils.c     |  63 +-
> >>  .../dml21/src/dml2_core/dml2_core_utils.h     |   2 +
> >>  .../dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c      |   1 -
> >>  .../dml21/src/dml2_dpmm/dml2_dpmm_factory.c   |   1 +
> >>  .../dml2_0/dml21/src/dml2_mcg/dml2_mcg_dcn4.h |   2 +-
> >>  .../dml21/src/dml2_mcg/dml2_mcg_dcn42.h       |   5 +-
> >>  .../dml21/src/dml2_mcg/dml2_mcg_factory.c     |   1 +
> >>  .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c  |   6 +
> >>  .../dml21/src/dml2_pmo/dml2_pmo_factory.c     |   4 +-
> >>  .../dml21/src/dml2_pmo/dml2_pmo_factory.h     |   2 +-
> >>  .../dml21/src/dml2_top/dml2_top_interfaces.c  |   1 +
> >>  .../dml21/src/dml2_top/dml2_top_legacy.c      |   1 -
> >>  .../src/inc/dml2_internal_shared_types.h      |   3 +
> >>  .../drm/amd/display/dc/dml2_0/dml2_wrapper.c  |   3 +-
> >>  .../amd/display/dc/dpp/dcn30/dcn30_dpp_cm.c   |   2 +
> >>  .../display/dc/dpp/dcn401/dcn401_dpp_dscl.c   |  21 +
> >>  .../hpo/dcn31/dcn31_hpo_dp_stream_encoder.c   |   5 +
> >>  .../amd/display/dc/hubp/dcn401/dcn401_hubp.c  | 201 ++++---
> >>  .../amd/display/dc/hubp/dcn401/dcn401_hubp.h  |  23 +-
> >>  .../amd/display/dc/hubp/dcn42/dcn42_hubp.c    |  85 ++-
> >>  .../amd/display/dc/hubp/dcn42/dcn42_hubp.h    |  16 +-
> >>  .../amd/display/dc/hwss/dce110/dce110_hwseq.c | 136 +++--
> >>  .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 412 +++++--------
> >>  .../amd/display/dc/hwss/dcn42/dcn42_hwseq.c   | 553 +++--------------=
-
> >>  .../amd/display/dc/hwss/dcn42/dcn42_hwseq.h   |  10 +-
> >>  .../amd/display/dc/hwss/dcn42/dcn42_init.c    |   8 +-
> >>  drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |  36 +-
> >>  .../gpu/drm/amd/display/dc/inc/hw/hw_shared.h |  18 +-
> >>  drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h   | 112 ++--
> >>  drivers/gpu/drm/amd/display/dc/inc/resource.h |   1 +
> >>  .../amd/display/dc/mpc/dcn401/dcn401_mpc.c    | 177 +++---
> >>  .../amd/display/dc/mpc/dcn401/dcn401_mpc.h    |  25 +-
> >>  .../drm/amd/display/dc/mpc/dcn42/dcn42_mpc.c  | 390 ++----------
> >>  .../drm/amd/display/dc/mpc/dcn42/dcn42_mpc.h  |  50 +-
> >>  .../amd/display/dc/optc/dcn10/dcn10_optc.h    |   2 +-
> >>  .../amd/display/dc/optc/dcn42/dcn42_optc.c    | 105 +++-
> >>  .../amd/display/dc/optc/dcn42/dcn42_optc.h    |  13 +-
> >>  .../dc/resource/dcn42/dcn42_resource.c        |  10 +-
> >>  .../dcn401/dcn401_soc_and_ip_translator.c     |   3 +
> >>  .../dcn42/dcn42_soc_and_ip_translator.c       |  12 +-
> >>  .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  38 +-
> >>  .../include/asic_reg/dcn/dcn_4_2_0_offset.h   |   2 +
> >>  .../include/asic_reg/dcn/dcn_4_2_0_sh_mask.h  |   9 +
> >>  65 files changed, 1596 insertions(+), 1984 deletions(-)
> >
> >
> >
> >
> >
>
