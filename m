Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A169CD4F49
	for <amd-gfx@archiver.kernel.org>; Mon, 18 May 2026 14:40:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9BF810E2FA;
	Mon, 18 May 2026 14:40:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mSRMFyFd";
	dkim-atps=neutral
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com
 [209.85.208.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1735D10E2FA
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 May 2026 14:40:17 +0000 (UTC)
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-6802f9c5debso5741059a12.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 May 2026 07:40:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779115215; cv=none;
 d=google.com; s=arc-20240605;
 b=OVAoqObq1oBxO+LGt4ykRqVTg+DNY4DE0nqb1TnaNKxbYu/fZppCUU6I4gK2DEAMsR
 akvDpUpvhz2+qvrbJaDwWe8Du6ibYaAEytdFUPiYupFoqMXNYgFck7wKXEyD58ruOxpK
 9/G1+wYbZx/rG+B4kZg24+//PRL/KldMHukIEknJk4trrAOE0tfJDK6wStrrntN3otcy
 X4QQIGy10unmtrgcHl9AW5V5kQLeQxcUnKn4B3xlzy9DOoMyUt7Rm8U2dI2BrQNOzPz4
 EvpCpZZ/E3xPxGfSEVZEmxb6B5DtXtonueZMEgO18kZ7YiNcSvkshzIC3er+E5a4Mm5A
 ayOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=23OQBj946LsrUWd9smy0+poYAXMVfhuEdwxjZI4yuq0=;
 fh=oOn461+myFCbJo8zvkR9U3bS+AUR6Y7vH5Al5UL2ZWo=;
 b=H5d0gqeR/R1iwW10eIS9IotuebCf/iLvLoPqeR9UdFGSiwERSWsy8Y8LD4Wkp1zdGZ
 I3f93bo9tHG4x7Chnk6nDTTC8HiygfCdLm06TQYLuaaMYEmxw/wSH3F8Ru7ATs+j46cB
 kHqtbJnwLonZrnh0T0p19chB/UisXouueyOdLPWBkf6UwQ3rvt6PVtR4bkibucf8ZdPu
 Ky5bzK7GRk6wKWfBsTeC9wY/Z91T8STS99TwhvQZFjto6Y3dftcXwlfJQXZtUyUrMpBn
 R07PCN0CmISpX4WkzN9mdJ8ulh/i5/E9O4AJuLBwyWuRzK1dNKJszrfMgs6yMMFP4/6N
 sDqA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779115215; x=1779720015; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=23OQBj946LsrUWd9smy0+poYAXMVfhuEdwxjZI4yuq0=;
 b=mSRMFyFdbo/NKMCkLwwqLJPuI2BpZB6EVfX/9EXYcM/LH2/+rviLs6HtbUX+GAFsSj
 Z52KlrmaLSMDh07zxWRGTMKjt1MsJ8N3QIVcXH/Kb5Gze1fH/+jL6Nbhsh3pLWIxCKhr
 4Re3y5rbn6d7m8iwY1xYBwW/JzT/swq4sC65P4nkuiHXHKDVHt67AwUH60hV76y+WHbH
 8HWHXmP40GA7r9Krwgn88LHQLyRObULfnTrmIeZFnidqoGWWdzvVbFkzFSdRD9GsTUKM
 l8OuoueGvnDdi+qTQ+5CR7iFoxQqvhrPYW9E2+EVPaRCVfFJRGqMXWeQWB4ZP8simEoB
 Ns5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779115215; x=1779720015;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=23OQBj946LsrUWd9smy0+poYAXMVfhuEdwxjZI4yuq0=;
 b=pqGVM4qkTmwKGQG8wGmo8aRf/ftUM+1OPGrIQy0zvBkcwXJs/VwWL26TRkBrCgnQNl
 eQxPcZwEt0gJNmPDPwoTGa5etr/f2pqYchgJAdpPl5+rtzr/oErgyVKSq9+Fgj2huBU9
 SV9WvvQMmZsInMz8TEqzXe2a2yEwG2rDERuezPfTxATc5RBTdHwMSyEHtVA90P29tQL9
 NrhLfjqbKyRtzpgvL6cQqjfXMj5XiQmTzyDwwHgTIioUal9kbMcjswbaz2Ed1vkpoZ9r
 voxhC7Y4l1THkLn/0OA14LDt+yD6FCvybI3NYLonhW9FEKzyQfnMPoMn86xyjdQNAxmg
 MRZg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8KJXf2XLr584BG2F+zfB4qYsxT6QgkUu7dZ/wZMpPb/ECMlBhEJqTQFkh58q7j1Os4Ss+xTnW1@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy/BSXlGwcjhZxiY8SoHP9MaMLt+aShJbR2hwTKhBlTRJaGySNk
 02X75guBWPNQSobEieju3dYOJmmIAFnm1l9oadbcD5mP5SoGkXo7NFcrcjO8cYt407r8n4bdaFn
 12rsEDRZzE9g7MS6vQ4p4jtqDiv9dZ0Q=
X-Gm-Gg: Acq92OE+JqUjqtI8hXIDq9XorPSAc0nLAFlhkXTPNwcoad2yyymqJvBWGidovFNiljd
 zYaJnclkd1nS7+EgyQ9x/SqrIHaCceZbSHR55mAWQjbZG7mN7CAiNoanF+JPwgSmxd/bM4AxWne
 0TyI3buIPxN+Z/3RT/Igv4RT4gXxB+r57KODKVXfb3DXdz3E9Rei0pz3djZR8oCpiDxv8aZaxX4
 lkcCATnMC0k758fLso5mKMEfzS0wade7kyPcu9cYlz/kflw1D/vCqEpBX1awoj1651FUlkKU9DP
 8KUmWw==
X-Received: by 2002:a05:6402:1bcd:b0:67e:2498:dc77 with SMTP id
 4fb4d7f45d1cf-683bc2c14b3mr4963249a12.6.1779115215271; Mon, 18 May 2026
 07:40:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260516092420.3579-2-gilles.risch@gmail.com>
 <20260516185226.3005-1-gilles.risch@gmail.com>
 <CADnq5_OZ8c4r-b6EzWCWuPA4BfDWs99ypJx-tS0FBuRZqHzH8w@mail.gmail.com>
In-Reply-To: <CADnq5_OZ8c4r-b6EzWCWuPA4BfDWs99ypJx-tS0FBuRZqHzH8w@mail.gmail.com>
From: Gilles Risch <gilles.risch@gmail.com>
Date: Mon, 18 May 2026 16:40:02 +0200
X-Gm-Features: AVHnY4L2NaW4w8sTXjQU5-0-qwZgPRCfD39LXc2zqmS6AjQsLTGx9Dzu4uqk_6c
Message-ID: <CALnjqVm06ZJ0mAE9=mQdPwDrNu0gtPmsQpwzn0NDbXDNugvJxg@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: fix eDP resume from suspend on iMac11, 1 /
 DCE3.1 systems
To: Alex Deucher <alexdeucher@gmail.com>
Cc: alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org
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

Am Mo., 18. Mai 2026 um 16:13 Uhr schrieb Alex Deucher <alexdeucher@gmail.c=
om>:
>
> On Sat, May 16, 2026 at 2:52=E2=80=AFPM Gilles Risch <gilles.risch@gmail.=
com> wrote:
> >
> > After suspend/resume the internal eDP display on iMac11,1 (and
> > potentially other DCE3.1 systems) stays dark because
> > atombios_set_edp_panel_power() skips panel power control for
> > anything older than DCE4.
> >
> > Fix this by:
> > - Extending atombios_set_edp_panel_power() to also handle DCE3.1
> >   by changing the !ASIC_IS_DCE4() guard to !ASIC_IS_DCE31().
> >   HPD polling works correctly on DCE3.1 (verified: HPD is asserted
> >   at iteration 0 on iMac11,1).
> > - Issuing ATOM_ENCODER_CMD_DP_VIDEO_ON/OFF for DCE3.1 in addition
> >   to DCE4+.
> >
> > Tested on iMac11,1 (Mobility Radeon HD 4850, RV770/DCE3.1).
> >
> > Signed-off-by: Gilles Risch <gilles.risch@gmail.com>
> > ---
> >  drivers/gpu/drm/radeon/atombios_encoders.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/radeon/atombios_encoders.c b/drivers/gpu/d=
rm/radeon/atombios_encoders.c
> > index 4e984973c043..b62fd713efcf 100644
> > --- a/drivers/gpu/drm/radeon/atombios_encoders.c
> > +++ b/drivers/gpu/drm/radeon/atombios_encoders.c
> > @@ -1383,7 +1383,7 @@ atombios_set_edp_panel_power(struct drm_connector=
 *connector, int action)
> >         if (connector->connector_type !=3D DRM_MODE_CONNECTOR_eDP)
> >                 goto done;
> >
> > -       if (!ASIC_IS_DCE4(rdev))
> > +       if (!ASIC_IS_DCE31(rdev))
> >                 goto done;
> >
> >         if ((action !=3D ATOM_TRANSMITTER_ACTION_POWER_ON) &&
> > @@ -1707,7 +1707,7 @@ radeon_atom_encoder_dpms_dig(struct drm_encoder *=
encoder, int mode)
> >                 if (ENCODER_MODE_IS_DP(atombios_get_encoder_mode(encode=
r)) && connector) {
> >                         /* DP_SET_POWER_D0 is set in radeon_dp_link_tra=
in */
> >                         radeon_dp_link_train(encoder, connector);
> > -                       if (ASIC_IS_DCE4(rdev))
> > +                       if (ASIC_IS_DCE4(rdev) || ASIC_IS_DCE31(rdev))
> >                                 atombios_dig_encoder_setup(encoder, ATO=
M_ENCODER_CMD_DP_VIDEO_ON, 0);
> >                 }
> >                 if (radeon_encoder->devices & (ATOM_DEVICE_LCD_SUPPORT)=
) {
> > @@ -1724,7 +1724,7 @@ radeon_atom_encoder_dpms_dig(struct drm_encoder *=
encoder, int mode)
> >         case DRM_MODE_DPMS_SUSPEND:
> >         case DRM_MODE_DPMS_OFF:
> >
> > -               if (ASIC_IS_DCE4(rdev)) {
> > +               if (ASIC_IS_DCE4(rdev) || ASIC_IS_DCE31(rdev)) {
> >                         if (ENCODER_MODE_IS_DP(atombios_get_encoder_mod=
e(encoder)) && connector)
> >                                 atombios_dig_encoder_setup(encoder, ATO=
M_ENCODER_CMD_DP_VIDEO_OFF, 0);
> >                 }
>
> These changes don't make sense and will break other DCE3.c boards.   I
> had the attached patch from you in one of my old branches, does it fix
> the issue?
>
> Alex

While the initial attached patch resolved the dark screen issue after
a fresh boot, this follow-up patch addresses the same problem
occurring after resuming from suspend. Should I used dmi_match() to
avoid breaking other DCE3.c boards?

Regards,
Gilles
