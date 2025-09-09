Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 548F1CAC583
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Sep 2025 16:56:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C122010E20D;
	Tue,  9 Sep 2025 16:56:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MBeSzysV";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A97D10E20D
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Sep 2025 16:56:33 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2445806e03cso74663255ad.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 09 Sep 2025 09:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757436993; x=1758041793; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=f4ERk8Qck8NaYPaGcLKu76DGj0YJRuZRk/ikeTno2r8=;
 b=MBeSzysVk5jxRrTkW3oiAfBmZlnuEn1bCaYum1G7ztwtmTE8L9tZrcNkG/joptqSmm
 QKeWMxMGJuveIFBggyQRpnVv4IKwbMJK8P9PvTYudSaybIysDv8TqA9cE1P/UPOCyX34
 /cgiojWOEo6Pj+WoAySsrSc0veQQQksl9ujNmZDAEjxoUAwL86ZB5Tteq4fJscCTwK/3
 +nyrcxt3mEe5NMqbw4pZLxow/ewUHGd4H5ZjLWBl2QBCMvAKHkK7YwKXBQIiAR/PAfzs
 HDbM+BMDDAdhWCnEYjCRRKUxGnQ7s2ZGhnpgurWOICkyG0HOPGiQrxHG4BQA+0O6O1vg
 VL7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757436993; x=1758041793;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=f4ERk8Qck8NaYPaGcLKu76DGj0YJRuZRk/ikeTno2r8=;
 b=sworrHZd/GEPsUYzxgnZl5/x21p2z0PiDnxabfPz/gO9QWRmgxI0LdQ4NFMXmrzTNN
 A2RvDJF0gmuZzEIEnADDWtgWC5wx2QhrgunqTPKNJFPwHcZvLeBfcrJXgr8dqY6Xg12+
 CKd1voVLwtQAP6WxoUCdHccL8LQB1jZmuO+T333Gx4x6vS4ME6e9cMqVqUnmia7JMN9L
 Exq+RiA6b2WHUmkCz0feDlcJw/T8fjYpvZ1mDjj4JoaRVLYwgGHK+Od9uLESKSOw4Efq
 83OZdch63gT1hmUeFBk2Z+BvPzrjR8ZRNblXnZ6zHr2I3cpnrfnpbrnvmQ+KYTaPkkGY
 Q4Zg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8OPo7m3871aD/dfvzUznMFks2ePFoY7TIljTL7ECD8gDLA98eVmXOLa26VcB6hONxeqwmPo/0@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyn+4FThCwJmKLlAF3HW83BNTRNO2EKWDgnpR/etiNO5xnn61dS
 lgYArnAk9Kz0dEZ85scGlqOLECc6Kb8lpUhPZ2NnegE0sfugkd7L/wCl
X-Gm-Gg: ASbGncv7dyagBTypCpWWF50nhHCEXY9CMk/+2XDA5diMkbjAZnMMtiUWrnzC4kYKKxD
 goMoM1xXfKVH6rfVLFGwWsuhdIyac3K/VO9JcX3ilO+L2wNlrfV9ATs8EGqx3y+tAaKiu//oUJt
 IHYSrEI2m2qwe9FEfpo2wtyHP7HpSlJMxYAIdcRbU1E7ar1Y6BLdITrSLWDVz+J4g+TqWilBVh7
 tFA/860bBuLHykpaaKVk++oj1Ror2mmUfUnQKBnAT6gRYIGDPKz4Of885Db6Nn4VcuIuSaxL/g1
 V8b55kCIX29Ie2YyEtPiS4ECTNYOJjUEUIxaCwiF+onOqOy7K6FpRa3zxYZYNjX+lk3ZFG70Ah3
 YPFAofRDRJ9pyHa28uVoto1uFQt9/aVwvKYLcA2i5w9cKYDuUTIHpYExupMFZMxnuPxM6uIfzDI
 Hugass8LwFEzE1V5wi5WSHAlFRw4gLsxRr6yZxt0cNpoHnkzSEuEkmCYObl3Y9Sk0=
X-Google-Smtp-Source: AGHT+IEcYDIBARleosZzevCD6vqGLKqxCwVIFEA875QzGrc4H5d7DKKalvO1RbF1UFnLIIRg9/xjBA==
X-Received: by 2002:a17:902:ec8e:b0:248:9e56:e806 with SMTP id
 d9443c01a7336-2516d52d4ebmr196321385ad.12.1757436992690; 
 Tue, 09 Sep 2025 09:56:32 -0700 (PDT)
Received: from ?IPv6:2001:4c4e:24d7:a100:85c7:4347:ba90:8e23?
 (20014C4E24D7A10085C74347BA908E23.dsl.pool.telekom.hu.
 [2001:4c4e:24d7:a100:85c7:4347:ba90:8e23])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-25a2a43a9bcsm2649425ad.89.2025.09.09.09.56.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Sep 2025 09:56:32 -0700 (PDT)
Message-ID: <a065f044dd629a9863ca18bb0e913d8f9299bedc.camel@gmail.com>
Subject: Re: [PATCH 2/3] drm/amdgpu: Set SDMA v3 copy_max_bytes to 0x3fff00
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, "Olsak, Marek" <Marek.Olsak@amd.com>
Date: Tue, 09 Sep 2025 18:56:27 +0200
In-Reply-To: <26b5d36d-1c9b-4891-962c-ec13b65f02ac@amd.com>
References: <20250909144937.22452-1-timur.kristof@gmail.com>
 <20250909144937.22452-2-timur.kristof@gmail.com>
 <26b5d36d-1c9b-4891-962c-ec13b65f02ac@amd.com>
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

On Tue, 2025-09-09 at 17:21 +0200, Christian K=C3=B6nig wrote:
> On 09.09.25 16:49, Timur Krist=C3=B3f wrote:
> > SDMA v3-v5 can copy almost 4 MiB in a single copy operation.
> > Use the	same value as PAL and Mesa for copy_max_bytes.
> >=20
> > For reference, see oss2DmaCmdBuffer.cpp	in PAL:
> > "Due to HW limitation, the maximum count may not be 2^n-1,
> > can only be 2^n - 1 - start_addr[4:2]"
>=20
> Ah! In this case the value the kernel uses is actually correct.
>=20
> The difference is that the kernel never has start_addr[4:2] !=3D 0 for
> anything larger than PAGE_SIZE while for PAL and Mesa that can
> happen.
>=20
> > See also sid.h in Mesa:
> > "There is apparently an undocumented HW limitation that
> > prevents the HW from copying the last 255 bytes of (1 << 22) - 1"
>=20
> That is actually pretty well documented and makes perfect sense. For
> unaligned start or dst addresses the SDMA needs to use an internal
> bounce buffer. That's where the limit comes from.
>=20
> Not sure if we should apply that patch or not, it probably doesn't
> make any difference in practice.
>=20
> > Fixes: dfe5c2b76b2a ("drm/amdgpu: Correct bytes limit for SDMA 3.0
> > copy and fill")
>=20
> Even when we apply it I think we should drop that, the value the
> kernel uses is correct.

Hi Christian,

The kernel and Mesa disagree on the limits for almost all SDMA
versions, so it would be nice to actually understand what the limits of
the SDMA HW are and use the same limit in the kernel and Mesa, or if
that isn't viable, let's document why the different limits make sense.

I'm adding Marek to CC, he wrote the comment that I referenced here.
As far as I understand from my conversation with Marek, the kernel is
actually wrong.

If the limits depend on alignment, then we should either set a limit
that is always safe, or make sure SDMA copies in the kernel are always
aligned and add assertions about it. Looking at the implementation of
amdgpu_copy_buffer in the kernel, I see that it relies on
copy_max_bytes and doesn't take alignment into account, so with the
current limit it could issue subsequent copies that aren't 256 byte
aligned.

Best regards,
Timur


>=20
> Regards,
> Christian.
>=20
> > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > ---
> > =C2=A0drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c | 4 ++--
> > =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> > b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> > index 1c076bd1cf73..9302cf0b5e4b 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> > @@ -1659,11 +1659,11 @@ static void
> > sdma_v3_0_emit_fill_buffer(struct amdgpu_ib *ib,
> > =C2=A0}
> > =C2=A0
> > =C2=A0static const struct amdgpu_buffer_funcs sdma_v3_0_buffer_funcs =
=3D {
> > -	.copy_max_bytes =3D 0x3fffe0, /* not 0x3fffff due to HW
> > limitation */
> > +	.copy_max_bytes =3D 0x3fff00, /* not 0x3fffff due to HW
> > limitation */
> > =C2=A0	.copy_num_dw =3D 7,
> > =C2=A0	.emit_copy_buffer =3D sdma_v3_0_emit_copy_buffer,
> > =C2=A0
> > -	.fill_max_bytes =3D 0x3fffe0, /* not 0x3fffff due to HW
> > limitation */
> > +	.fill_max_bytes =3D 0x3fff00, /* not 0x3fffff due to HW
> > limitation */
> > =C2=A0	.fill_num_dw =3D 5,
> > =C2=A0	.emit_fill_buffer =3D sdma_v3_0_emit_fill_buffer,
> > =C2=A0};
