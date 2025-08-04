Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19117C87FCF
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 17:34:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DA5010E20E;
	Mon,  4 Aug 2025 17:34:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hMWr4obF";
	dkim-atps=neutral
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A31110E20E
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 17:34:51 +0000 (UTC)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-76c1008fd60so58454b3a.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Aug 2025 10:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754328891; x=1754933691; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fF2S1owfCATG2uNRBY0YYuwTR2uI6ikALJFvqvRtaSE=;
 b=hMWr4obFp7fmr0koHagOnQgKc9iYnwmEtM6U2MTL8/0glHgVZaH7w04mS3dfSFxxqw
 g6ZyvoUnfRN2Kp1/BjXEQewyjWgPoPxP0zm08Uq6akkwSS3QerKly+WtgWJ9FtPv2949
 bywvOOypXN6Xrl3gyKZjJUfKuBZr5IH0A16yRsiBGt+0VIqqcLdp6n930EhqBxqhyDKU
 ba7aOL+5pfbNUCmGxqBpG9WkNQuQWEKO4IuPYdbD+UMxZ2b5C/3ua6OySqnANBAAhP+Y
 45utIaif0vnD8qRG74SZYg0uaHYqEpfHb6ClLP9/jS+l3Q7+IAZQdq/WnqOKzYjxFUt5
 gpqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754328891; x=1754933691;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fF2S1owfCATG2uNRBY0YYuwTR2uI6ikALJFvqvRtaSE=;
 b=mnr6yMYJA7rYk78cdxp1c+HHjNRK7bE5YuMDBwrAaDfFs/bc6v8B2EUKFB/vXwCSoH
 8iIjLYYFmiq3jBYc1f4CvFZQyi8PqL+7D/Or2ScNOHVpHYFYYcU/ISf+NU8i2UZB9Zji
 HYhP4uIZTb8lgW4M5uM2/xPYZlQ/KIGbmr2p0SpOsw5U2GOlYn0fAj7SAPmyMVsLLJR2
 M1uT+9IfdkeSyCLwYnjXv7yCbWDYS6n9ZqvtWwb4OlpmWQlEqeT4xUCDzNSa4hU0sDqZ
 o/19V6kkFjJghJGSXXeZmqp5CFuF01FMheRSh05iiARWGI9FKFoSR9Vv0ldInKYp+HKI
 hNEg==
X-Gm-Message-State: AOJu0Yz43ZFAGfwI0gfzd4ifsaZXYRtoQs5WOXSybUvU02dYNhC2AOC+
 c8w4K9qIDAul9h/YkiDoLfSd2qim0qTbx5q4rsY++YxEY0t35nlWq7UiWxWTNyhtRRsInIhazZs
 IEV5z7PIOKcglB2YyupnZhY7fx0v82gk=
X-Gm-Gg: ASbGncsJWxJtsu6ZzcpIqq67QUDllSiq7Yr9eKZ/fNT2ryhUHgipKZRRLPpCWohuqDy
 Q9E30aa+9I3dRCkW7Mni/UqsDcthggWccNMGfR2vj7+GN5szY71MEfczAGcBFJiyOymLlQG+Lje
 ywL2TBHkDJfD6nR9SBhfm94hAErUEuZRnSWrIvmdaM2X3IuZrUGm9nxuku+3al6aAQEn6qm78Mg
 Ihr39VN
X-Google-Smtp-Source: AGHT+IEGLn1JK9kWw+RlBUfsFhJz6Pyc0G9HoSlfPAnDmXeOe7F0bXCOzNRPDAhC1DkD7Hfm3WfsS2opEL129XwBQ9c=
X-Received: by 2002:a05:6a21:3d89:b0:240:28e:c333 with SMTP id
 adf61e73a8af0-240028ec620mr2646527637.2.1754328891350; Mon, 04 Aug 2025
 10:34:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250804134154.95875-1-timur.kristof@gmail.com>
 <20250804134154.95875-4-timur.kristof@gmail.com>
 <CADnq5_NoepbUzAczVq-t2P1jKweq6h2bOfHU9jqyupSszToXZg@mail.gmail.com>
 <2de9270e32cf9e69edd72f3f6ce284b07901fa86.camel@gmail.com>
In-Reply-To: <2de9270e32cf9e69edd72f3f6ce284b07901fa86.camel@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 4 Aug 2025 13:34:40 -0400
X-Gm-Features: Ac12FXxuwny6TC-sSN2qVnRxRTTnM7Jtf5N_AVkk8Mr8Xi4ZdBdrnROSNVPLcjc
Message-ID: <CADnq5_Oz1AZg7Vng7W7=XTsL4xi70o8v3kfzSRQhAjfRcYZHXw@mail.gmail.com>
Subject: Re: [PATCH 3/6] drm/radeon: Disable ULV even if unsupported
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

On Mon, Aug 4, 2025 at 12:09=E2=80=AFPM Timur Krist=C3=B3f <timur.kristof@g=
mail.com> wrote:
>
> On Mon, 2025-08-04 at 11:24 -0400, Alex Deucher wrote:
> > On Mon, Aug 4, 2025 at 10:18=E2=80=AFAM Timur Krist=C3=B3f
> > <timur.kristof@gmail.com> wrote:
> > >
> > > Backport of the same commit to amdgpu.
> > > This commit fixes some instability on Tahiti.
> >
> > Have you tested this with radeon?
> >
> > Alex
>
> Considering that ULV is currently always marked as unsupported by both
> radeon and amdgpu, and that the same patch fixes a real issue on
> amdgpu, I assume it would improve stability on radeon too.
>
> I leave it up to your judgement whether it's a good idea to apply this
> to radeon or not.
>
> That said, I haven't got a specific issue which this fixes on radeon.
> I only tested that Tahiti can boot with radeon with this patch
> included, but didn't do detailed testing other than that. Do you have
> something specific in mind that I should try?

That's fine.  I was thinking this contributed to the other issue you
were debugging, but you clarified that in the other patch.
Acked-by: Alex Deucher <alexander.deucher@amd.com>

Alex

>
> Timur
>
> >
> > >
> > > Fixes: a9e61410921b ("drm/radeon/kms: add dpm support for SI (v7)")
> > > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > > ---
> > >  drivers/gpu/drm/radeon/si_dpm.c | 7 +++++--
> > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/radeon/si_dpm.c
> > > b/drivers/gpu/drm/radeon/si_dpm.c
> > > index 9deb91970d4d..47fba85436a7 100644
> > > --- a/drivers/gpu/drm/radeon/si_dpm.c
> > > +++ b/drivers/gpu/drm/radeon/si_dpm.c
> > > @@ -5073,10 +5073,13 @@ static int si_disable_ulv(struct
> > > radeon_device *rdev)
> > >  {
> > >         struct si_power_info *si_pi =3D si_get_pi(rdev);
> > >         struct si_ulv_param *ulv =3D &si_pi->ulv;
> > > +       PPSMC_Result r;
> > >
> > > +       r =3D si_send_msg_to_smc(rdev, PPSMC_MSG_DisableULV);
> > > +
> > > +       /* Only care about SMC reply when ULV is supported. */
> > >         if (ulv->supported)
> > > -               return (si_send_msg_to_smc(rdev,
> > > PPSMC_MSG_DisableULV) =3D=3D PPSMC_Result_OK) ?
> > > -                       0 : -EINVAL;
> > > +               return (r =3D=3D PPSMC_Result_OK) ? 0 : -EINVAL;
> > >
> > >         return 0;
> > >  }
> > > --
> > > 2.50.1
> > >
