Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3978CCF9F0
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Oct 2025 18:05:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 581FE10E31D;
	Thu, 30 Oct 2025 18:05:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JOa22nem";
	dkim-atps=neutral
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com
 [209.85.218.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D341A10E326
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Oct 2025 18:05:33 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-b6d3effe106so105322866b.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Oct 2025 11:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761847532; x=1762452332; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ffUErFjwH6FPsyyAXYKD8BwCvRk0j0ovrU1IvwXLog8=;
 b=JOa22nemtyzHdlEiiUJtawiMaiv2b+jCh6oAPJp8PSBJlN8/t96xOsKuq3VtRMGdLm
 6xcgUW6v/6alKJTkjMA+sBU7DFzUbYK3UvCf0nz7sUE/oaxRzBHsAyMrBXZvXh1xGrL6
 VL3rTwFS5UC8lVtrAxMo9+dISQfXQSH9ZpPyY2z0m8ttqMruhdql3a3WpnCm/irw+L8t
 YXr/sYtW3/zpWpGb+PZB4rBqfgTfFnyHRt5XmZqK3JcVZ91EKqIMSdzoP8zZ0aBvwgg8
 TnmKziGE36RdSHn6z5luyljReaIF3iuxXPROxBUB9BHsExfkhvQXo5JRyrvKneFrod6E
 5q+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761847532; x=1762452332;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ffUErFjwH6FPsyyAXYKD8BwCvRk0j0ovrU1IvwXLog8=;
 b=j5/2/NGZHm++uBAGMGqvLgAzcFAqX1p3khUtjLUiwGw5BfltDpqwAN+hl+9rpExX87
 pW8Pgbcw1GBKY7QoGsfl7ktGYoeGpXEH09497lekMQZaA9A9ggfsDOutRuUE9Ow8uGwg
 m6p2IOO0BrzPSBmc3zri30o27ssJfLNiKo3h4Aqxi7ok/Np36Dsr4SjcvkRRqxwDA4//
 22N1ASAcHXm6f9xlbzBYiE0SaUI1l6+3xuBXRHO0u84RecjaeYAkiZoVaTNPidCQs4wg
 fRvuYmWn2vjbAq4+1D1SAgnHpJXQm1YXd8eLqZUeifPWlWczb0EklngLIhJTUp/3tKrB
 Uwow==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKd/c6Cl8tQattulhGg7TMiqIdoxByoqD5oPvUPozk8Erzo65oBW/SpxcTb8dk3GvM5+IQaUMT@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywmx3jkNYe8a625x21x1mIiGiEyJGT7dPCfiUVH14+6stOK5Pns
 P3lBfT2xR6fIeRD+QMEgtQwW5JEe8NXXvvMxnllf877qGBdMxP/nRB4c
X-Gm-Gg: ASbGnctfhH8ZBsg4ZODZgkXmH4FBDAjxYosNj7QLRaNlKvybRo6tPCsMiCY0ynxPPvp
 Cyger+x0FomorXQoroA/YxDyNUEJYZGMuFcb4XC1Fpga4stXviCedq0yRuUo1rZRz0POapGy+GR
 EGfZe83ol2QBPX3scjzQnKXXTi81g6QOdCmzpB2CDabqvxN2nvHeTWOMksE35rhQf8K1Hp9EEEP
 oZBpg4WgnqpzuEgWnnG8Bz5/lnVy4TGdvPIj52IVMZrI0tHCOrFigsiqnd4X6f24HHMR0YPM4XU
 ctO/i2+9e4HOiriQmeO2buG9is/ceHwT52wQSqsYysno/jkMPari+ktwZH4/CWHUnnYbbGTWR+c
 pFvThkInNVZOukfOmfRaZQuNyIUMOJLRHm00UKk2g7Wbv/8nBQBIqx/YlST2zOI89zEJ9B68riO
 Cl72F5dkLZETuT8Lrbydn4/GkbIYh8q5ciNNout6AdUg3fV8yxzrg91lJ2KuCx/+qh4SI9CQmQ5
 y52kqfdTl3husoU5RX8ecug+hEhp1w+dgGi0tgrV+fOxcy/S7zwjzQ=
X-Google-Smtp-Source: AGHT+IGJV/I1/C7aO/ht8j1BD1EQXUXgawrmeYdDSw5EX8PS0SBYhLW9fl4h/IWLZ5+YHnJQFCdfnw==
X-Received: by 2002:a17:907:94c5:b0:b04:2533:e8dd with SMTP id
 a640c23a62f3a-b7070870952mr42287966b.60.1761847531886; 
 Thu, 30 Oct 2025 11:05:31 -0700 (PDT)
Received: from ?IPv6:2001:4c4e:24cb:f700:23e8:3719:bda9:8268?
 (20014C4E24CBF70023E83719BDA98268.dsl.pool.telekom.hu.
 [2001:4c4e:24cb:f700:23e8:3719:bda9:8268])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d853696a3sm1801921066b.27.2025.10.30.11.05.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Oct 2025 11:05:31 -0700 (PDT)
Message-ID: <32ed124e9d603cad950c4836c7a14a3ba8bc2068.camel@gmail.com>
Subject: Re: linux-next-20251029 - build error in amdgpu
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Valdis =?UTF-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>, Alex
 Deucher	 <alexander.deucher@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>, David Airlie <airlied@gmail.com>, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Date: Thu, 30 Oct 2025 19:05:30 +0100
In-Reply-To: <1043551.1761844832@turing-police>
References: <1043551.1761844832@turing-police>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
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

On Thu, 2025-10-30 at 13:20 -0400, Valdis Kl=C4=93tnieks wrote:
> Hit this error while building next-20251029 with W=3D1 and gcc (GCC)
> 15.2.1 20251022 (Red Hat 15.2.1-3

Hi,

Can you say how to reproduce that?
I use the same version of GCC but it hasn't given me any warning or
error for that patch.

Thanks & best regards,
Timur

>=20
> =C2=A0 CC [M]=C2=A0
> drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_stream_encoder.o
> drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_stream_encoder.c:157
> 1:69: error: positional initialization of field in 'struct' declared
> with 'designated_init' attribute [-Werror=3Ddesignated-init]
> =C2=A01571 | static const struct stream_encoder_funcs
> dce110_an_str_enc_funcs =3D {0};
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> ^
> drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_stream_encoder.c:157
> 1:69: note: (near initialization for 'dce110_an_str_enc_funcs')
> cc1: some warnings being treated as errors
>=20
> Caused by:
> commit deb072d241c906ae378bc88ff91dfcdc34ebe71a
> Author: Timur Krist?f <timur.kristof@gmail.com>
> Date:=C2=A0=C2=A0 Fri Sep 26 20:01:51 2025 +0200
>=20
> =C2=A0=C2=A0=C2=A0 drm/amd/display: Implement DCE analog stream encoders
>=20
>=20
> > > > > > > > >=20
