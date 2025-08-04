Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71B75C87FCF
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 16:57:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F27C210E217;
	Mon,  4 Aug 2025 16:57:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lIfcjWr7";
	dkim-atps=neutral
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6888710E217
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 16:57:38 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-31ec291f442so762757a91.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Aug 2025 09:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754326658; x=1754931458; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FAfUdpE/piLIvtmvqVaAZGDmb/Y/vO9x7VqkmMql6G8=;
 b=lIfcjWr7lxzg4VB1rFs4s47k33jFCwtWlA6CfZdk1vgp3D0//tU1CDbUWGcoExVCvX
 HDMYt8/6ePnW7FBuO0rODBEvy69FyQ0+u8UA/XKRwYT6ze0oLMJ8n6r/ZJZVBXAnektf
 AT7SQXeX1HvYYg5mUEJqU+HAtnr4KYWJIaTGa48zuppAcxvRJ1rxPdNuh2p9sOaAL5AV
 v/P9iYXVF4CxqTp5Nf8wKKF0ARfCpF3q412cuHjqYXe4MHTGKhmQA8VsHqOvoMcV9FiE
 AeDoZXWQdQ3Ociw63omLvidCAFFy6+sKZ0M0M2OjMeM3r4ZclRM4sb5ISurKtZgS5tLo
 WjCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754326658; x=1754931458;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FAfUdpE/piLIvtmvqVaAZGDmb/Y/vO9x7VqkmMql6G8=;
 b=M6G2G3ZaG9gBFaPHClz2e5GcIJzkmbBbrJ2G3ie84s0OghSCNpGTvvlmrltqsAXZXS
 wlDfz3/f2xuEr23+9Mo18TxS9h0diM78ij0dLAKt0duAyfCoHAqoJzqJDn0Hn7iWvrwv
 H2uzgJJZXK4vXXPoLBOo5Cdh72ranEgNuEuOm1G2HKk5QJ9HaeqqBEvz/wV8Iac0ayZz
 LvN1zou5SukmAcdBgOCynNXtWLfxdw7NKZlMKkzeffNvzjwF1FHZMwLYZuRae6daSA0/
 pCT0DTPTxCjHkd7EXaNti7cc5sb6UcyXT1CMhWmKMnrjCctDnV/8gl3uicKDhNymV8vz
 gZdA==
X-Gm-Message-State: AOJu0YyFPrqoWS16Ima0j4DtaqzNlkOJ7auyeMsTjo353WXQLIORHImd
 KA0PhmqlWCCuLVDwzgqvCE9ngcSOP3gC2R410+mA0CjOq192ZVoZdGc4TDo4NlIO5R/esAy5OdC
 m5bJbu8Gd3u9t16oy3eCmaNn8pXVl2sE=
X-Gm-Gg: ASbGnct1sRdgv4NIvD5ji5kYRpFh7HzURXf+SK8lAJyCM6gAOM7Hl6ZWVoOf+bt2Hi3
 b6tc58I6LhTqgbBOZCEdErIzCWfG18VrOXvpMofjNV+Q9vAoZDB0XkBSciQ2fggk6CXRNUEOnih
 aLWukbJEmq1tO9tD8bk5HkE2ZKeuEHbyAKuAyi6bV5ArMWEaMTRSH9eAxblVCFwt/fAVQucL/a2
 MNRNY7iquKvnsuopWI=
X-Google-Smtp-Source: AGHT+IG6+gEWEE6AFX3DiWVujVWnSKRXIFzriY21WvViN+sSQpHL3gj89hxY+ykfBFXc0eCwd9h/8A7ovekKVFldtyY=
X-Received: by 2002:a17:90b:38d0:b0:31f:7b7:405d with SMTP id
 98e67ed59e1d1-321162d2846mr6005122a91.7.1754326657552; Mon, 04 Aug 2025
 09:57:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250731094352.29528-1-timur.kristof@gmail.com>
 <20250731094352.29528-3-timur.kristof@gmail.com>
 <CADnq5_OAOrZETWPBzUjGJigJxXRsK=nBPjY+-j3ZE+skXr4vfw@mail.gmail.com>
 <7c144d14fb8726b812091719a69192c9bc655762.camel@gmail.com>
In-Reply-To: <7c144d14fb8726b812091719a69192c9bc655762.camel@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 4 Aug 2025 12:57:23 -0400
X-Gm-Features: Ac12FXyG0AyhAiaEngICZjhA1VwzFYLt_QdnjVD_TU1H9PheTGZPAzberSkP-bU
Message-ID: <CADnq5_OC2uXm8CzezBKMt5djP=esRP-TNW37prQKvyZAr42xNw@mail.gmail.com>
Subject: Re: [PATCH 2/7] drm/amd/display: Adjust DCE 8-10 clock, don't
 overclock by 15%
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
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

On Mon, Aug 4, 2025 at 12:35=E2=80=AFPM Timur Krist=C3=B3f <timur.kristof@g=
mail.com> wrote:
>
> On Mon, 2025-08-04 at 11:56 -0400, Alex Deucher wrote:
> > On Thu, Jul 31, 2025 at 5:58=E2=80=AFAM Timur Krist=C3=B3f
> > <timur.kristof@gmail.com> wrote:
> > >
> > > Adjust the nominal (and performance) clocks for DCE 8-10,
> > > and set them to 625 MHz, which is the value used by the legacy
> > > display code in amdgpu_atombios_get_clock_info.
> > >
> > > This was tested with Hawaii, Tonga and Fiji.
> > > These GPUs can output 4K 60Hz (10-bit depth) at 625 MHz.
> > >
> > > The extra 15% clock was added as a workaround for a Polaris issue
> > > which uses DCE 11, and should not have been used on DCE 8-10 which
> > > are already hardcoded to the highest possible display clock.
> > > Unfortunately, the extra 15% was mistakenly copied and kept
> > > even on code paths which don't affect Polaris.
> > >
> > > This commit fixes that and also adds a check to make sure
> > > not to exceed the maximum DCE 8-10 display clock.
> > >
> > > Fixes: 8cd61c313d8b ("drm/amd/display: Raise dispclk value for
> > > Polaris")
> > > Fixes: dc88b4a684d2 ("drm/amd/display: make clk mgr soc specific")
> > > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > >
> > > x
> >
> > Stray x here.  with that fixed:
> > Acked-by: Alex Deucher <alexander.deucher@amd.com>
>
> Thanks!
> Sorry about that, that's a typo that I made during a rebase.
>
> Maybe a silly question but what is the right way to deal with it?
> Should I send the entire series or just the patch with the typo fixed?
> Or can you just delete the typo when you are applying it to your tree?

If you end up resending the series, you can fix it then.  If not, I
can fix it up when I apply the patches.  I wanted to give it a few
more days so the display guys have a chance to review them.

Alex

>
> Timur
>
> >
> > > ---
> > >  .../drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c  | 12 +++++---
> > > ----
> > >  1 file changed, 5 insertions(+), 7 deletions(-)
> > >
> > > diff --git
> > > a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
> > > b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
> > > index 26feefbb8990..69e9540f553b 100644
> > > --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
> > > +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
> > > @@ -72,9 +72,9 @@ static const struct state_dependent_clocks
> > > dce80_max_clks_by_state[] =3D {
> > >  /* ClocksStateLow */
> > >  { .display_clk_khz =3D 352000, .pixel_clk_khz =3D 330000},
> > >  /* ClocksStateNominal */
> > > -{ .display_clk_khz =3D 600000, .pixel_clk_khz =3D 400000 },
> > > +{ .display_clk_khz =3D 625000, .pixel_clk_khz =3D 400000 },
> > >  /* ClocksStatePerformance */
> > > -{ .display_clk_khz =3D 600000, .pixel_clk_khz =3D 400000 } };
> > > +{ .display_clk_khz =3D 625000, .pixel_clk_khz =3D 400000 } };
> > >
> > >  int dentist_get_divider_from_did(int did)
> > >  {
> > > @@ -400,11 +400,9 @@ static void dce_update_clocks(struct clk_mgr
> > > *clk_mgr_base,
> > >  {
> > >         struct clk_mgr_internal *clk_mgr_dce =3D
> > > TO_CLK_MGR_INTERNAL(clk_mgr_base);
> > >         struct dm_pp_power_level_change_request level_change_req;
> > > -       int patched_disp_clk =3D context->bw_ctx.bw.dce.dispclk_khz;
> > > -
> > > -       /*TODO: W/A for dal3 linux, investigate why this works */
> > > -       if (!clk_mgr_dce->dfs_bypass_active)
> > > -               patched_disp_clk =3D patched_disp_clk * 115 / 100;
> > > +       const int max_disp_clk =3D
> > > +               clk_mgr_dce-
> > > >max_clks_by_state[DM_PP_CLOCKS_STATE_PERFORMANCE].display_clk_khz;
> > > +       int patched_disp_clk =3D MIN(max_disp_clk, context-
> > > >bw_ctx.bw.dce.dispclk_khz);
> > >
> > >         level_change_req.power_level =3D
> > > dce_get_required_clocks_state(clk_mgr_base, context);
> > >         /* get max clock state from PPLIB */
> > > --
> > > 2.50.1
> > >
