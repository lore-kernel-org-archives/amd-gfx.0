Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3838CD4F5B
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 14:54:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47CFC10E25F;
	Tue, 19 May 2026 14:54:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DUoYOJIr";
	dkim-atps=neutral
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7191110E25F
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 14:54:15 +0000 (UTC)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-2ee4e75bc93so246956eec.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 07:54:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779202455; cv=none;
 d=google.com; s=arc-20240605;
 b=EsxC6QWDTWb7D0bP6yECjKWARcukAU/Nw3uKMTqUZ9KQdRljArt1y06ZGXIXVqwSlX
 2xVM8HpuqbXjxdl90c8P4he35u337g+kaqEAIFJbPrpgbJZycKyD6AeMufsa6ErWIT2Q
 gu39dy0MS/B0u2waqEsSxEzESo3Xb7O0x5N8ThmS0aRr1nvvj4EogVyemjhc5b7r1b3Q
 OPincoNjmS+0KPv8KHOBAKu1Ka5BfmY3AEX9PWOI0E5UyG/OFFcPpfPVsP/4eA1w0X7t
 jeo4DexSYaWF2oMC9cU700EUJ6EPZUKXYfvd/d5IVbF4yxQfZVTpOr9OkgVoV2UiqgxB
 ychQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=gZWNf+53N7+52lQvZ2G96ZulPdc0wrj0Ca/Bgqu6FaA=;
 fh=0q2GbN2kuTfvHEZnJ86eeqqMYVhBsJDCCb/C3/u1EbU=;
 b=MgmtdQyAFLY+/3GjRIohxNbNvW7rTnBj03PSGVjS2BS8Mgt03fxJlchSpl/iWdxfEy
 Nbu+EQlhwqiJnXcUFFyMBJigXtyJxNZG7jfgLvltoMOiFmI5618lSfP/PTyzpLeDtnSW
 IvCjHmf0+fHI/GbdQnv+Avium+TmXlqhgZGzgV4wSD/eqhNRmUUXScRJOUjaPSJfiv6P
 BAd2PJ6CBAKyncYV2CrVtVx4ZwGQ1wex5i/LpOmzAIkClQDQE4XKwxvfJ2bKwOMBxQHs
 Q333GrG6hhNUXon/z1wEqJ4LF4FGg056wkvLWsp5j3YgWO1QwhSnudMXZTDmrFVYpbE2
 Sv3g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779202455; x=1779807255; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gZWNf+53N7+52lQvZ2G96ZulPdc0wrj0Ca/Bgqu6FaA=;
 b=DUoYOJIrMqfacuaMT9UQjk+mKl1V8Ul2N8okeldHw+1w2mrffeq0tc2gOamKG6qD9g
 uN2ebrnG0V5XpnKrkFPQfXwB9aq8c9BmOGYrJCtHrfOjM0YzD7u8BUQIogC0NODQyhHK
 tRWWyIJo4IhMZ/kVdrlp0NXpTBPbDlXXjquJPSlCX5aYl587PIRPKXMa9c2ZeX9hq17M
 lnT6Cjc2J5vFzpDGbGOUlbDXAum+otmXN612T5yOj1h6/sU0Gp1xqLIZXOBdbKQ1v4FF
 X6sVlWniq7cqOVGTRpOjdOb4LAAxg1P2jRI56soKE7F+GJACbN1Rbm4lLDyqzHgGgN2k
 2cfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779202455; x=1779807255;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gZWNf+53N7+52lQvZ2G96ZulPdc0wrj0Ca/Bgqu6FaA=;
 b=jNnskmkqIvHsprboI6r/wyRDMbhJcRQzu5d0g7pHcKroD1nsdiX4o/Kd1cep6YbXt/
 liyPhGhdSgQpZH8wuaEn0yJMyQWPo/6vmWp+6ZOCtHX/dYI6zR6U04GQ/EyycmleT49I
 +dTh6cUPJoIwLOVG470LDtCyrheMf9Ph7arbwc8n0ssxguLsa9Upg8buJamPr0M6gL9I
 vP4lUYsSAt8C35vygxWJQBp0Lx3imUU/gD1qmG03rFGWsZRkK/21u36lip80dovIxkRI
 Zx+ka0i1aAwtBurjkiqwwBWxLokRoHgnOrPdGDoQqrsJqhws5QouF4sZL4SxDYiDysv/
 iliA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9W5DNcbsGiFqioBrFy4r6o1x4ZSCEtku4ma55z7QEbD/ZlBfFusFgciJwBH4HASqdN+UVI0qQu@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxPPGBODEV1HNTic9Pd8WUoUPiinF9iW5vIreeiGtaPdNjmjnJ0
 hFLtnc0nxQ+VL5OamguZCn3S0uKOGeV35goU8vpf3sTQjfc7myGszKjzW9B1K1Wrke9QU5ITQBV
 JMI9pyk9tvnFiO0AuDXUsDUsGO1AMZxU=
X-Gm-Gg: Acq92OE+rUkI5OOnddI4Ocw3cDicGE/5Zhh0uCY56JXE3gWH5pky4S2h99q+z2uaiyD
 m+d4jjn3ab07wsTG7MCw37yIIfkCy0ta13XnsLvYy2JdiTTIkr08MuPF1TREeMvHVnnqRoZRO8j
 7FpFvgboCkhyma9gCgDHFmUBqrJIKVu04ESN/HZdMqMwPWUII9sY3xG20EFcQJ3W/+awt2VlIOe
 SJfurz6eNNA/lB1DjM9m1NKDXTDUhPU5d1NlXy4xrR3LBoQPl+TwVwiKjsGEeBtRS2x1AybzOTr
 JxB7Az8y1YAMCVWkUlsBPWqkFyXz26N1IsLAF9lXryyjW2cOdQe+wwx1ZDjHYvg3Lf+Sg0khocr
 1bkBH
X-Received: by 2002:a05:7022:ea21:b0:135:1b3a:bffb with SMTP id
 a92af1059eb24-1351b3ac1efmr3505287c88.0.1779202454536; Tue, 19 May 2026
 07:54:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260519102118.246466-1-timur.kristof@gmail.com>
 <31fcec2b-cefb-412e-841a-ff98e0479a20@amd.com>
In-Reply-To: <31fcec2b-cefb-412e-841a-ff98e0479a20@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 19 May 2026 10:54:03 -0400
X-Gm-Features: AVHnY4LOLxcvc1hml2KSJDHvB1UlU_fyojyfS7nngM_sGus5JGALK4vYJeM0BKE
Message-ID: <CADnq5_PAwZ-G21fOQ4weU+9Ro9EDHkyr71ZSSexoaHHQw6fc4Q@mail.gmail.com>
Subject: Re: [PATCH 00/14] drm/amd: Delete defunct DAL power level code
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 Natalie Vock <natalie.vock@gmx.de>, Melissa Wen <mwen@igalia.com>, 
 Harry Wentland <Harry.Wentland@amd.com>, Alex Hung <alex.hung@amd.com>,
 Roman Li <Roman.Li@amd.com>, 
 Leo Li <sunpeng.li@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
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

Applied the series.

Alex

On Tue, May 19, 2026 at 9:14=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 5/19/26 12:21, Timur Krist=C3=B3f wrote:
> > Delete unused code related to DAL power levels.
> > It seems that the DAL power level concept has been
> > never fully implemented and was thus non-functional
> > in amdgpu.
> >
> > DCE 11.0 and 11.2 never actually relied on the
> > power level because they calculate all necessary
> > power requirements in dce_calcs and communicate
> > that using dm_pp_apply_display_requirements() to
> > the power management code.
> >
> > DCE 6, 8 and 10 also didn't rely on power levels
> > because they always just set the maximum possible
> > display clock and the power management code
> > already takes that into account when setting the
> > power state. This was somewhat improved recently
> > by also using dm_pp_apply_display_requirements()
> > on these DCE versions.
> >
> > The code base for newer GPUs doesn't use the
> > concept of power levels anymore either, so
> > this change reduces the maintenance burden
> > of the old DCE code.
> >
> > On the DC side:
> >
> > dm_pp_apply_power_level_change_request() was never
> > implemented in amdgpu_dm, and DC has been working
> > fine for years without it. Let's delete the dummy
> > function and the code that calls it.
> >
> > With that, we can also delete the power levels
> > and the static arrays containing hardcoded power
> > level values. These were never used for anything,
> > only for finding the maximum supported display clock.
> >
> > On the AMDGPU PM side:
> >
> > The get_dal_power_level() implementations were
> > dummy on SMU10, Vega10, Vega12 and Vega20 meaning
> > that they didn't return an actual DAL power level,
> > and were non-functional on SMU8 which always
> > returned the highest possible power level.
> > Nothing actually relied on the power level
> > returned by these functions. Let's delete them.
> >
> > What's next:
> >
> > After this code cleanup lands, I have plans to
> > further improve display power management on old DCE.
> >
> > Changes in v2:
> >
> > Applied review suggestions.
>
> Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com> to the full ser=
ies.
>
> Thanks a lot for taking care of that.
>
> Regards,
> Christian.
>
> >
> > Timur Krist=C3=B3f (14):
> >   drm/amd/display: Delete unimplemented
> >     dm_pp_apply_power_level_change_request() (v2)
> >   drm/amd/display: Delete dce_get_required_clocks_state()
> >   drm/amd/display: Remove min/max clock levels from clk_mgr (v2)
> >   drm/amd/display: Delete max_clocks_state
> >   drm/amd/display: Set max supported display clock without
> >     max_clks_by_state (v2)
> >   drm/amd/display: Delete max_clks_by_state from DCE clock manager (v2)
> >   drm/amd/display: Delete disp_clk_voltage from integrated info (v2)
> >   drm/amd/display: Delete dm_pp_clocks_state
> >   drm/amd/pm: Delete unused get_display_power_level() function
> >   drm/amd/pm: Delete dummy get_dal_power_level implementations
> >   drm/amd/pm: Delete non-functional SMU8 get_dal_power_level
> >     implementation
> >   drm/amd/pm: Delete vddc_dep_on_dal_pwrl
> >   drm/amd/pm: Delete get_dal_power_level
> >   drm/amd/pm: Delete PP_DAL_POWERLEVEL
> >
> >  .../amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c  |  55 -------
> >  .../gpu/drm/amd/display/dc/bios/bios_parser.c |  36 -----
> >  .../drm/amd/display/dc/bios/bios_parser2.c    |  18 ---
> >  .../display/dc/clk_mgr/dce100/dce_clk_mgr.c   | 144 ++----------------
> >  .../display/dc/clk_mgr/dce100/dce_clk_mgr.h   |   3 -
> >  .../dc/clk_mgr/dce110/dce110_clk_mgr.c        |  25 ---
> >  .../dc/clk_mgr/dce112/dce112_clk_mgr.c        |  41 -----
> >  .../dc/clk_mgr/dce120/dce120_clk_mgr.c        |  16 --
> >  drivers/gpu/drm/amd/display/dc/dm_services.h  |   8 -
> >  .../drm/amd/display/dc/dm_services_types.h    |  30 ----
> >  .../amd/display/dc/inc/hw/clk_mgr_internal.h  |  10 --
> >  .../display/include/grph_object_ctrl_defs.h   |   9 --
> >  drivers/gpu/drm/amd/include/dm_pp_interface.h |  19 ---
> >  .../gpu/drm/amd/include/kgd_pp_interface.h    |   2 -
> >  .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  |  22 ---
> >  .../amd/pm/powerplay/hwmgr/hardwaremanager.c  |  10 --
> >  .../amd/pm/powerplay/hwmgr/processpptables.c  |   1 -
> >  .../drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c  |  48 ------
> >  .../drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c   |  64 --------
> >  .../drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c |  18 ---
> >  .../drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c |  16 --
> >  .../drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c |  17 ---
> >  .../amd/pm/powerplay/inc/hardwaremanager.h    |   3 -
> >  drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h  |   4 -
> >  24 files changed, 11 insertions(+), 608 deletions(-)
> >
>
