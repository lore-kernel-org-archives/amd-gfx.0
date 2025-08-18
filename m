Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4604CCA0EE4
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Aug 2025 17:07:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D677610E4AB;
	Mon, 18 Aug 2025 17:07:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XZxzhsaF";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1585310E4AB
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Aug 2025 17:07:54 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-32326e20aeeso755965a91.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Aug 2025 10:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755536873; x=1756141673; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=goVjMkEop6JEv9YegPsLIkkQgFH09bsbyMXIYvDDmqk=;
 b=XZxzhsaFUAGJrYnzWXya5ypTUhO4heZqKmzEzllkCUO1j49191SvzHTVE5iba6qkel
 GWLXAM55eJQLtb1V4+WNIvUxrkqeJfgMnIcPUBk5NLg/inGdSWufCa81OxT5YVh0cjSl
 HkEpeFRSZH7qgevBmshNsdqAcfs9ifltNhreUcIc/ZguY6+1jmjn4wTNZP1enIdcosCZ
 c2G9rUjnACCzQM8gJ8v3LzvxWmvhKHQtxtvkXVpOoQMNJgtjNe1OM2sQK7vgqmVBuT21
 XqXw2Xkb4p5AnR6sstXWaND6XN2BYhfJ76OAwfeQ3RbqKpGoOVdup14mg49qSpVmt7kM
 ntZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755536873; x=1756141673;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=goVjMkEop6JEv9YegPsLIkkQgFH09bsbyMXIYvDDmqk=;
 b=Gji9DmpMG00RdiiZ+bkV3q4mBT9YR7q+i4JF7M56CHAVSB1jFmJ37tub4OKnxXNGXF
 yrs/AN4UaYDqHpzaqZy1shoGk33MTcffyMTUuG5fpeIubHFeQQmo6b483cAMgQlnfsnc
 YpxBkYVJ/MDsvx/iRQo/7HtndRgeyePLY/yJ1DzRrRncYup8T/8ybU6FCkwZ3kMQAhjb
 XOH5lc8gpjlxaCpUNMUX3nBfOX7444H0hldjxLbAX8MdxaqIysUPoAPwrasRSVmoyHyn
 o5xg3KbJ0OzRJXChZ0XPd0L8rlHcYO9HKgmJV/5uKH1ZqiPbkz5AsnFR41nFeKhZe0se
 VlcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVw6fuAJ1ZuCMn+35w+luh3PrtQkFl2sE+39bqt+z6nPki9XccTZaWFC3s0M9xPYH0V/REzbnLb@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz2jBtX54KSUdrfBYt7u+gqeHnazKIEYL6ZJQY+XdcNUZRDGJ48
 9LJcqgOUXjz2zpnhsWnA6bdMbNVzvdkoBd2PXznvRJwAD8XqG1qxUV9wdWv+DLJoiYuo5awnc0D
 LzP7eSs5XtxvPFJtbGyrak950/oXsdZk=
X-Gm-Gg: ASbGncs/yYr+9R+HIyUSZ184MkpMoYDVWl8cPhiYHzxsCqqtYAtzHi75b3KO62cZq6L
 8ju0iUlAfesiuKIdUWTh9C4S89VhhK2d3Ar4uEyJxZMtsO/LLRj1X14Pbi7QLi0mLct5NEelNhb
 sFlDdeBd7jHuWnWJlTHC7tRs1H0DqmfGBIJXCJQCfRpFGZaeNrL3CaXfD4DLEmyR6sxc8mBTjUB
 V1IBdwjnrOrkfxaZ+BSlRDYEXO/
X-Google-Smtp-Source: AGHT+IFnxHHtVp/WYZJchURHiZ3YY/3kXSUd4kzZl3UeEgCW8CH1iORY/kckxu78geVip5iWIgEEPTjjPe9FnoWVdlQ=
X-Received: by 2002:a17:903:1ce:b0:240:3e5c:476b with SMTP id
 d9443c01a7336-2446d70c9abmr77696415ad.3.1755536873389; Mon, 18 Aug 2025
 10:07:53 -0700 (PDT)
MIME-Version: 1.0
References: <20250802155153.6432-1-timur.kristof@gmail.com>
 <xmdk2cncflqglv7jn5yrzkhhvnth5fxp6ekv7lnp5ruzpinhkv@5rxk6sj7fosd>
In-Reply-To: <xmdk2cncflqglv7jn5yrzkhhvnth5fxp6ekv7lnp5ruzpinhkv@5rxk6sj7fosd>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 18 Aug 2025 13:07:41 -0400
X-Gm-Features: Ac12FXxCJynRfH-GADtcXW63NJAw8MbMmtQHSZwzxXjOVJ2070pi8mDGcrGoCEE
Message-ID: <CADnq5_P3nbQbhtPUqesi_orp6G+A3ahWp4iacMT=DfhODYuBjA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix DP audio DTO1 clock source on DCE 6.
To: Rodrigo Siqueira <siqueira@igalia.com>
Cc: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 Daniel Wheeler <daniel.wheeler@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, 
 Alex Hung <alex.hung@amd.com>, amd-gfx@lists.freedesktop.org, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>
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

Applied.  Thanks!

Alex

On Fri, Aug 8, 2025 at 2:39=E2=80=AFAM Rodrigo Siqueira <siqueira@igalia.co=
m> wrote:
>
> On 08/02, Timur Krist=C3=B3f wrote:
> > On DCE 6, DP audio was not working. However, it worked when an
> > HDMI monitor was also plugged in.
> >
> > Looking at dce_aud_wall_dto_setup it seems that the main
> > difference is that we use DTO1 when only DP is plugged in.
> >
> > When programming DTO1, it uses audio_dto_source_clock_in_khz
> > which is set from get_dp_ref_freq_khz
> >
> > The dce60_get_dp_ref_freq_khz implementation looks incorrect,
> > because DENTIST_DISPCLK_CNTL seems to be always zero on DCE 6,
> > so it isn't usable.
> > I compared dce60_get_dp_ref_freq_khz to the legacy display code,
> > specifically dce_v6_0_audio_set_dto, and it turns out that in
> > case of DCE 6, it needs to use the display clock. With that,
> > DP audio started working on Pitcairn, Oland and Cape Verde.
> >
> > However, it still didn't work on Tahiti. Despite having the
> > same DCE version, Tahiti seems to have a different audio device.
> > After some trial and error I realized that it works with the
> > default display clock as reported by the VBIOS, not the current
> > display clock.
> >
> > The patch was tested on all four SI GPUs:
> >
> > * Pitcairn (DCE 6.0)
> > * Oland (DCE 6.4)
> > * Cape Verde (DCE 6.0)
> > * Tahiti (DCE 6.0 but different)
> >
> > The testing was done on Samsung Odyssey G7 LS28BG700EPXEN on
> > each of the above GPUs, at the following settings:
> >
> > * 4K 60 Hz
> > * 1080p 60 Hz
> > * 1080p 144 Hz
> >
> > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > ---
> >  .../display/dc/clk_mgr/dce60/dce60_clk_mgr.c  | 21 ++++++-------------
> >  1 file changed, 6 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr=
.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c
> > index 0267644717b2..883591706db9 100644
> > --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c
> > +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c
> > @@ -83,22 +83,13 @@ static const struct state_dependent_clocks dce60_ma=
x_clks_by_state[] =3D {
> >  static int dce60_get_dp_ref_freq_khz(struct clk_mgr *clk_mgr_base)
> >  {
> >       struct clk_mgr_internal *clk_mgr =3D TO_CLK_MGR_INTERNAL(clk_mgr_=
base);
> > -     int dprefclk_wdivider;
> > -     int dp_ref_clk_khz;
> > -     int target_div;
> > +     struct dc_context *ctx =3D clk_mgr_base->ctx;
> > +     int dp_ref_clk_khz =3D 0;
> >
> > -     /* DCE6 has no DPREFCLK_CNTL to read DP Reference Clock source */
> > -
> > -     /* Read the mmDENTIST_DISPCLK_CNTL to get the currently
> > -      * programmed DID DENTIST_DPREFCLK_WDIVIDER*/
> > -     REG_GET(DENTIST_DISPCLK_CNTL, DENTIST_DPREFCLK_WDIVIDER, &dprefcl=
k_wdivider);
> > -
> > -     /* Convert DENTIST_DPREFCLK_WDIVIDERto actual divider*/
> > -     target_div =3D dentist_get_divider_from_did(dprefclk_wdivider);
> > -
> > -     /* Calculate the current DFS clock, in kHz.*/
> > -     dp_ref_clk_khz =3D (DENTIST_DIVIDER_RANGE_SCALE_FACTOR
> > -             * clk_mgr->base.dentist_vco_freq_khz) / target_div;
> > +     if (ASIC_REV_IS_TAHITI_P(ctx->asic_id.hw_internal_rev))
> > +             dp_ref_clk_khz =3D ctx->dc_bios->fw_info.default_display_=
engine_pll_frequency;
> > +     else
> > +             dp_ref_clk_khz =3D clk_mgr_base->clks.dispclk_khz;
> >
> >       return dce_adjust_dp_ref_freq_for_ss(clk_mgr, dp_ref_clk_khz);
> >  }
> > --
> > 2.50.1
> >
>
> Very nice patch! I checked the mentioned functions, and it looks correct
> to me.
>
> I added other display folks for further review/validation. It could be a
> good idea to include this patch in the next week's promotion.
>
> Reviewed-by: Rodrigo Siqueira <siqueira@igalia.com>
>
> Thanks
>
> --
> Rodrigo Siqueira
