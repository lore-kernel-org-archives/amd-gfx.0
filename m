Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31DA1C87FCB
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 16:04:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB4F410E5B0;
	Mon,  4 Aug 2025 16:04:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="C/Ax49EV";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B91D510E5B0
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 16:04:03 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-3b780bdda21so3088236f8f.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Aug 2025 09:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754323442; x=1754928242; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=9PCYTdQGY8OZH1XxQ9Pd2d8enjjc4k4hXlMb7paUOWo=;
 b=C/Ax49EVXt2KRaCyayYp4wnyr7u7SRwTC2NJynj7KrhkbV/my+WWpG1TG+0Eh6Srs+
 eXbmJPkeZGuanJ1bPmlB09iw7vQ16ukgvKz+16cjrz41Qdf+3o+6I1tjhGz0XXZTxX2I
 BGqw44jk/RoKjG6Ea8mmw5am+QXJoINHIzEhyVQ6StAz2IpQwl4mEad7KtaBQvsB7rs3
 KncF6lPSZ+6Hh71QKpJQmTZz0KKJQ5xlmtg78i+nYIxTf/XpI3cth/zmdBCmZFLnWymQ
 aANSDjVRMpLZNRd+NIYNqiTOEDK6AmFGWefs+9pwFcoQKVxe3dLEhefSv8rK0Hu6n07p
 kOYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754323442; x=1754928242;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9PCYTdQGY8OZH1XxQ9Pd2d8enjjc4k4hXlMb7paUOWo=;
 b=EMIEcK8aicl5UuzNGFjaCMz+q5hE03JcvHZxJBfmVSr4nfDFFmy+4bUe5W5jg8AAXS
 6kravuMBr6Fut2oiawGmEy+Y+2UfI8fPc1h0cBg7SrrabiaEdWmBFpNtlBVgdox5YRGO
 UkjMNoteCbdYhyw25nS/GwnbY8JX88IA8DPsCI+hhfivLXB3iBGqRp5oaHIdUmxsv67r
 SoBMFZDSeni+4GYo737wQDuwxW2V9T51d/AqDvdu4zj6qMByUQ+8o9CNdqI2ry/bKDnt
 OVFp7msMVPOqR/07+Ikb02C6okn94Sm7JZIROKpA1VYN6xIoj+ge4U6IU15ha3DCkCmK
 L4+g==
X-Gm-Message-State: AOJu0Yxb8rbQv5NwpxJZZY9oO9gs9oINHq8AMAR8Ni+9KnaO0OUyjF8a
 lpLsbdwsneS7A5nNaKJtdH+wjPsdcHaVaqX/SEY89rjBOdRaiseGFVnk
X-Gm-Gg: ASbGncvu3u2lsANcBka35hv0yk6RJXiEYI+aauac+mp9SHPI9ngcjzL5u9lWvdew6D6
 +EHOsKO0FmHv6RYtXHQPzcEA0VtiJn/b1RJnMS8kKtTlfZxgn51CjA3rFyVOfJZzwcZJjsUGJZk
 4Zq257zK0X7mD3hVEkTi+F0aGUSBFHKvPNK/GIGuwCS9zel56ypiei2DCQ17y5zN5AlCYf6gXSG
 jf8waBglbtaQL6arK1yePYqkq0QHda3BYDBZQ+ZaQus6LFHFDMsEWLCd3YmY7PEEHE5vNslSnVj
 pcXckY10GdJfB1W8MdO45cfiNoM6xKN0ksKkRac7XA2Q2KzsleWBbzIVtVR53KXGwHmZL1SM/Z4
 wVt5mQyl+AQHOza1SYePLwH/EcVVCZDUURs5NZGuqS3WlS69u3BiZC4O7/OrNoB62JBZsgu0ujM
 JDcivN2muPvIZ/CXavrbpFDPHeJvfeOEw4mRfU4V7HfcrHLAc119ctdLWQwMYjmA==
X-Google-Smtp-Source: AGHT+IEvQwtveH1rGfw1hnBju597k3rfQgJpUQV00eja8FEptGMCQXxjYCT7wHqNE6VZrPJw4PLcVw==
X-Received: by 2002:a05:6000:2083:b0:3b7:8c83:db18 with SMTP id
 ffacd0b85a97d-3b8d94645f0mr7129039f8f.6.1754323442123; 
 Mon, 04 Aug 2025 09:04:02 -0700 (PDT)
Received: from ?IPv6:2001:4c4e:24da:bd00:a473:4c1d:2078:832b?
 (20014C4E24DABD00A4734C1D2078832B.dsl.pool.telekom.hu.
 [2001:4c4e:24da:bd00:a473:4c1d:2078:832b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c4530b3sm16455166f8f.34.2025.08.04.09.04.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 09:04:01 -0700 (PDT)
Message-ID: <98b288895c31c3c94fe7a23f6694b583caae5f65.camel@gmail.com>
Subject: Re: [PATCH 2/6] drm/amd/pm: Disable ULV even if unsupported
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
Date: Mon, 04 Aug 2025 18:04:00 +0200
In-Reply-To: <CADnq5_PPfscSbxEhmDXzcgcQNX3RecMzUwZMsXm5Cm+g72uDaA@mail.gmail.com>
References: <20250804134154.95875-1-timur.kristof@gmail.com>
 <20250804134154.95875-3-timur.kristof@gmail.com>
 <CADnq5_PPfscSbxEhmDXzcgcQNX3RecMzUwZMsXm5Cm+g72uDaA@mail.gmail.com>
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
> On Mon, Aug 4, 2025 at 9:58=E2=80=AFAM Timur Krist=C3=B3f
> <timur.kristof@gmail.com> wrote:
> >=20
> > This commit fixes some instability on Tahiti.
> >=20
> > Sometimes UVD initialization would fail when using DC.
> > I suspect this is because DC doesn't immediately turn on the
> > display clock, so it changes how DPM behaves.
>=20
> Is this the right description for this patch?=C2=A0 I thought you had sai=
d
> this fixed something else.
>=20
> Alex

Yes, this patch together with the previous one fixes the "amdgpu: UVD
Firmware validate fail" when I enable DC on Tahiti.

Last week I thought this also fixed the "si_set_sw_state failed", but
that turned out to be wrong. For that one, I sent a separate patch
which involves a different fix.

Timur

>=20
> >=20
> > Fixes: 841686df9f7d ("drm/amdgpu: add SI DPM support (v4)")
> > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > ---
> > =C2=A0drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 7 +++++--
> > =C2=A01 file changed, 5 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> > b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> > index 52e732be59e3..33b9d4beec84 100644
> > --- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> > +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> > @@ -5639,10 +5639,13 @@ static int si_disable_ulv(struct
> > amdgpu_device *adev)
> > =C2=A0{
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct si_power_info *si_pi =
=3D si_get_pi(adev);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct si_ulv_param *ulv =3D=
 &si_pi->ulv;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PPSMC_Result r;
> >=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r =3D amdgpu_si_send_msg_to_smc(a=
dev, PPSMC_MSG_DisableULV);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Only care about SMC reply when=
 ULV is supported. */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ulv->supported)
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return (amdgpu_si_send_msg_to_smc(adev,
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
