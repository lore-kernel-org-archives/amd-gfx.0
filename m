Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3B7FC83F26
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jul 2025 17:39:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C26010E55F;
	Mon, 28 Jul 2025 17:39:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JA1ATZhC";
	dkim-atps=neutral
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD08510E55B
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Jul 2025 17:39:05 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-313067339e9so746285a91.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Jul 2025 10:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753724345; x=1754329145; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t6d9zu/8MXKzz/y5bU6VHaWJ911scU517rl/C+r82DI=;
 b=JA1ATZhCDgb7mFUn9DK4SHH5//qNtqWa+BRL+tN5ANeQ737KfeCjaF1RfHFf0ngIZm
 jMK0zs1JvdjDuFIHQzYhCJzti/QtnUghL/lO5YVJDIeM43Os/Yy6FVPrYdwdN1WxeUFK
 6jcUthWMba2QoCCA0iKp9PahbDxA2NE92T+R/f1zZrPk2ybxan+/hMijjKeZSKBV3yic
 tgWuNRhoKnINowFnNjF/29RHJdqsctL45vX6hUw4rpsHNeAw6jyZ4Wql1ipF1/G4e6ta
 Um+RLp97D7uMEndjvZiUciyV2R/izH8Hb8+jfexC3pB7BlVjgu4eMctHMqD/ApkV3b/O
 hbgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753724345; x=1754329145;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t6d9zu/8MXKzz/y5bU6VHaWJ911scU517rl/C+r82DI=;
 b=Adac+5Pfjs3SpNUFJovzGvVS9L2SSPejGJQ+70cTHQGKOkM2ACu5zw88aJroczwhjR
 5QaVZUfz8FOaiG2F/TRCNXVbha6PN8CtMhtRTRVb3HRRHasTCXimFqvg0ykb0os13oEr
 WhS6u/OvNuKSU7WTbJKvymrn4y10AH0MDmwJt4sEi8I11fgbZbMfssjLZRNqReFdGm3e
 +sNqOTYNvjw1ctp16ylauzTockMlt6La5ByhiCGE47DvpAyXeKIYm/tTeCfXrEPjKmoL
 st9Pu3idDABtGWBsZ9lytGcnVlZCAoWdjT3pF81kNOr2fQ+ukd7Mh5CvKDrhQ6EmrPkb
 Xv+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrqozj0qmwAAGXsvk6PK/1yZDSslKgFBQiqnqRFtLMSQtwt9YTpXCbki5Jy1sJfkNI7u0Uh7Cj@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwrVvbNiV8PBBzBMJ+H/GkQZPY7RsdGdx4Nzjy4J6vzEVaHCs7W
 NrNX9X5J1MaCNYEB8NwQsGZN2Bh3KNNZOA90JAUBm5hUuKnQE+KH1ZiXpe0x6AtoPUGJWF6bpxL
 fM7lJPg3tdF8Y96uX6utFC5OvWR1aTTo=
X-Gm-Gg: ASbGnctypKqVGMWbWME9mr+JkkqS2jhe9etr7ifCcb13sNGRkw/qK8mBjrm+UFRwEbC
 x6oLkkO3No9iRaMj61TXCK4P3yCmrS3TjYmV9TuUAqhrlMZ+AMFvhuDbopSI1aa+oEsj0+dOOns
 Y4kH9VcWPDGexXmNNxB42/YtGLpqNvNDLKpyP5kpHO7PN+bDJaoZUUK3TvmyQCR/hSij9cdCtdP
 /hEav0i
X-Google-Smtp-Source: AGHT+IHHwyLnIh0OOspAb/Ne63WT7VVCdj7/GpZ+4C29aG/ZUicmzCMO21OUQ/TmkZGRxu0XC0Tp2AAmQRVPwroap0c=
X-Received: by 2002:a17:90b:3ece:b0:31f:3f3:4516 with SMTP id
 98e67ed59e1d1-31f03f34736mr1510637a91.2.1753724345268; Mon, 28 Jul 2025
 10:39:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250721134350.4074047-1-superm1@kernel.org>
 <ead2f2f1-6627-4884-87f8-932f38d54803@amd.com>
In-Reply-To: <ead2f2f1-6627-4884-87f8-932f38d54803@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 28 Jul 2025 13:38:53 -0400
X-Gm-Features: Ac12FXyMTQix-9HOMhbljwQ3QOjUYNnGHI87C1rXwEG10kE7ir5R0BmNsD3Ry5Q
Message-ID: <CADnq5_PFp2Qey8JhY=gjgwEF4yWZwwa31XQF=-TQjQy_TWL5kw@mail.gmail.com>
Subject: Re: [PATCH] Revert "drm/amd/display: Fix AMDGPU_MAX_BL_LEVEL value"
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc: Mario Limonciello <superm1@kernel.org>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "stable@vger.kernel.org" <stable@vger.kernel.org>
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

On Mon, Jul 21, 2025 at 3:15=E2=80=AFPM Limonciello, Mario
<Mario.Limonciello@amd.com> wrote:
>
> On 7/21/25 8:43 AM, Mario Limonciello wrote:
> > From: Mario Limonciello <mario.limonciello@amd.com>
> >
> > This reverts commit 66abb996999de0d440a02583a6e70c2c24deab45.
> > This broke custom brightness curves but it wasn't obvious because
> > of other related changes. Custom brightness curves are always
> > from a 0-255 input signal. The correct fix was to fix the default
> > value which was done by [1].
> >
> > Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4412
> > Cc: stable@vger.kernel.org
> > Link: https://lore.kernel.org/amd-gfx/0f094c4b-d2a3-42cd-824c-dc2858a56=
18d@kernel.org/T/#m69f875a7e69aa22df3370b3e3a9e69f4a61fdaf2
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > ---
> >   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 +++++-----
> >   1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/driver=
s/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index 8e1405e9025ba..f3e407f31de11 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -4740,16 +4740,16 @@ static int get_brightness_range(const struct am=
dgpu_dm_backlight_caps *caps,
> >       return 1;
> >   }
> >
> > -/* Rescale from [min..max] to [0..MAX_BACKLIGHT_LEVEL] */
> > +/* Rescale from [min..max] to [0..AMDGPU_MAX_BL_LEVEL] */
> >   static inline u32 scale_input_to_fw(int min, int max, u64 input)
> >   {
> > -     return DIV_ROUND_CLOSEST_ULL(input * MAX_BACKLIGHT_LEVEL, max - m=
in);
> > +     return DIV_ROUND_CLOSEST_ULL(input * AMDGPU_MAX_BL_LEVEL, max - m=
in);
> >   }
> >
> > -/* Rescale from [0..MAX_BACKLIGHT_LEVEL] to [min..max] */
> > +/* Rescale from [0..AMDGPU_MAX_BL_LEVEL] to [min..max] */
> >   static inline u32 scale_fw_to_input(int min, int max, u64 input)
> >   {
> > -     return min + DIV_ROUND_CLOSEST_ULL(input * (max - min), MAX_BACKL=
IGHT_LEVEL);
> > +     return min + DIV_ROUND_CLOSEST_ULL(input * (max - min), AMDGPU_MA=
X_BL_LEVEL);
> >   }
> >
> >   static void convert_custom_brightness(const struct amdgpu_dm_backligh=
t_caps *caps,
> > @@ -4977,7 +4977,7 @@ amdgpu_dm_register_backlight_device(struct amdgpu=
_dm_connector *aconnector)
> >               drm_dbg(drm, "Backlight caps: min: %d, max: %d, ac %d, dc=
 %d\n", min, max,
> >                       caps->ac_level, caps->dc_level);
> >       } else
> > -             props.brightness =3D props.max_brightness =3D MAX_BACKLIG=
HT_LEVEL;
> > +             props.brightness =3D props.max_brightness =3D AMDGPU_MAX_=
BL_LEVEL;
>
> This bottom hunk doesn't need to revert, that one is fine.  The other
> two need to be reverted though to fix this issue.

With that fixed, the patch is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>
