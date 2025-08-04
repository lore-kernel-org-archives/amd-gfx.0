Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE746C87FCF
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 16:09:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68E4910E5B2;
	Mon,  4 Aug 2025 16:09:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dXTgJF0w";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E15F10E5B2
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 16:09:45 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-3b78d337dd9so2202311f8f.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Aug 2025 09:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754323784; x=1754928584; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=3IvGO8Dt4fb7FV7FpEi0FYquDJy8Xo/Y2vFyXgO8ulA=;
 b=dXTgJF0wVghWVC+K0UwanMpveXc+3hERoad4ayOLwheS+/Wouqw2zPqboqvzPHarwc
 fBWhl2VTlLHqxuY1E3iJlzY3Jg74brZ+q7q9h5PytV7IXC07trfh9tYdNjID3Y1nHpoX
 AXRR0AoP+ZcU0Xm90H3tUuZABWiyaVIL0sbux7nnW3O0aknnu1NqXTPzqJ3TzIwgB3e1
 1CTAO0WUE1TeH/GS1tTJ+HfLQalqKCOwJIVjTNyg2yw1weqF0df5SREcTuWH+BKDKipv
 ReqDO7x4Q6v6gd8k9DUypXftsAv8C2xhlEvkFyDuWeJudbAvtXLv6ua8hHAYNrs/h0aS
 V7Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754323784; x=1754928584;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3IvGO8Dt4fb7FV7FpEi0FYquDJy8Xo/Y2vFyXgO8ulA=;
 b=LjxptdeaqlPhjJkvzdN61eAi1iQ7AASxnzlEc8FXNZNIIBM5pzq88htaQMwTdI5Xxu
 tNJjjs1zGjYQAcymA/ifmNdG5ZFHLFfKGxhseQz4zPokhd+PWl7HzIw/aJ8903PwN4NI
 ZgiSo+V94H3YtRnLgFyei0FdxG8NBI++TjbTSXOgYGOUM0/oLowHIG3PJV80D1S3p5AH
 Q4OfhZm7DPGvF4fYE32hRW6LRZk+i//zN8SWeEpsbztU1OjPsU5rh1wIf22yh4sCNOWa
 M3YxyblIkITJ2zNd7OItQ1bNAk7C2m5AgzJ/jOPv/VIAnerl0kcf3Gv994VzX3BOdd/N
 TjCA==
X-Gm-Message-State: AOJu0Yxc91No1EcGL1/wgP0Q0hVSziUSjq/iJMrou7oJHRGHUs3Hsdpl
 5syYkOrsraf5+vqIwGTaesM9g3EqzYqrLyKlTMfnNURv27Sd1GCYv3JR
X-Gm-Gg: ASbGncvTgrOuhlaNbZSaK6E7ahShCmMQ+htN4kg4QPSEpTdSywlxmN7UldjG8qD8l8F
 079IRzl4lXz4XMFUnVQOjLHlpaEpHJW/AtZUu6nTbjHYBpJDjLzAhZ4vSec46Eg+yXRAFw1GVpN
 aL/oz22RCiQ70olrZ58tPsFrwLSdFHCdUMfb2l7Xu60kpkLw/bFdwrqdDzsmHFOd40/890orwiH
 YQEOh5OGCxWOSg6ubnds2pVh7TxuMLNkgyMKcVsmalHdbPPi3hVkk3Q2gb1Q/Xp2Vf/4+r9eYbD
 M3SicNm5CVRVNHYrb1EtywpPi/hmqfAeiz4IWWeAqnTXy6f4Slf+1vnw/fDRwJQCoNn5IvSJ5Og
 f4t+XiR0MThSd46ft0QZLLxeFRbHcha5uhCVIzhrFIPf0zodtA+jaF/HdXSaF2T3Scrw/6mYQzX
 2TneIytbS5Z+Zdnw/UPSdwyDzCIiuo/+KIyG8F4UYal2iS8YOXXd1NQ/E3OAafWg==
X-Google-Smtp-Source: AGHT+IHoz8V8CH+7aCCT4edflCcA1/hf6k0jS2d71kbHagS8zXT77PiDPhFFHQxNaZ2xHl4G8XxBRw==
X-Received: by 2002:a05:6000:2902:b0:3b7:895c:1562 with SMTP id
 ffacd0b85a97d-3b8d94649f4mr8572795f8f.11.1754323782298; 
 Mon, 04 Aug 2025 09:09:42 -0700 (PDT)
Received: from ?IPv6:2001:4c4e:24da:bd00:a473:4c1d:2078:832b?
 (20014C4E24DABD00A4734C1D2078832B.dsl.pool.telekom.hu.
 [2001:4c4e:24da:bd00:a473:4c1d:2078:832b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c47ca5fsm15760236f8f.63.2025.08.04.09.09.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 09:09:41 -0700 (PDT)
Message-ID: <2de9270e32cf9e69edd72f3f6ce284b07901fa86.camel@gmail.com>
Subject: Re: [PATCH 3/6] drm/radeon: Disable ULV even if unsupported
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
Date: Mon, 04 Aug 2025 18:09:41 +0200
In-Reply-To: <CADnq5_NoepbUzAczVq-t2P1jKweq6h2bOfHU9jqyupSszToXZg@mail.gmail.com>
References: <20250804134154.95875-1-timur.kristof@gmail.com>
 <20250804134154.95875-4-timur.kristof@gmail.com>
 <CADnq5_NoepbUzAczVq-t2P1jKweq6h2bOfHU9jqyupSszToXZg@mail.gmail.com>
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

On Mon, 2025-08-04 at 11:24 -0400, Alex Deucher wrote:
> On Mon, Aug 4, 2025 at 10:18=E2=80=AFAM Timur Krist=C3=B3f
> <timur.kristof@gmail.com> wrote:
> >=20
> > Backport of the same commit to amdgpu.
> > This commit fixes some instability on Tahiti.
>=20
> Have you tested this with radeon?
>=20
> Alex

Considering that ULV is currently always marked as unsupported by both
radeon and amdgpu, and that the same patch fixes a real issue on
amdgpu, I assume it would improve stability on radeon too.

I leave it up to your judgement whether it's a good idea to apply this
to radeon or not.

That said, I haven't got a specific issue which this fixes on radeon.
I only tested that Tahiti can boot with radeon with this patch
included, but didn't do detailed testing other than that. Do you have
something specific in mind that I should try?

Timur

>=20
> >=20
> > Fixes: a9e61410921b ("drm/radeon/kms: add dpm support for SI (v7)")
> > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > ---
> > =C2=A0drivers/gpu/drm/radeon/si_dpm.c | 7 +++++--
> > =C2=A01 file changed, 5 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/radeon/si_dpm.c
> > b/drivers/gpu/drm/radeon/si_dpm.c
> > index 9deb91970d4d..47fba85436a7 100644
> > --- a/drivers/gpu/drm/radeon/si_dpm.c
> > +++ b/drivers/gpu/drm/radeon/si_dpm.c
> > @@ -5073,10 +5073,13 @@ static int si_disable_ulv(struct
> > radeon_device *rdev)
> > =C2=A0{
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct si_power_info *si_pi =
=3D si_get_pi(rdev);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct si_ulv_param *ulv =3D=
 &si_pi->ulv;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PPSMC_Result r;
> >=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r =3D si_send_msg_to_smc(rdev, PP=
SMC_MSG_DisableULV);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Only care about SMC reply when=
 ULV is supported. */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ulv->supported)
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return (si_send_msg_to_smc(rdev,
> > PPSMC_MSG_DisableULV) =3D=3D PPSMC_Result_OK) ?
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 : -EINVAL=
;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return (r =3D=3D PPSMC_Result_OK) ? 0 : -EINVAL;
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > =C2=A0}
> > --
> > 2.50.1
> >=20
