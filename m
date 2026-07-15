Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8510FC44501
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 08:02:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19F1B10EF2C;
	Wed, 15 Jul 2026 08:02:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qFHIf8g0";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12D8010EF22
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 08:02:54 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4921eed3fa2so42782735e9.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 01:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784102572; x=1784707372; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IXG7e5rrawzo35m9/0tm3JVzxLn0JXGxhNy6R+mWNdA=;
 b=qFHIf8g0SwHCjd48BmAeNucbA+ian3Y443vpovgus9bcLeSODgT3vg+8TGgIRvNzM3
 lo2SgyoHXzddFdmnZ81G/YJd0f5sgtDjF5fAqp/QN6nMcL+g4BhCGZvm4gnh5rr8eDFo
 nN8XiHf2ly/lTTu8wbMfV990nrG8uaQ4QiI02kqKzq3znfGMksW0J78x99ZBI0YiR35+
 ScifE7gJNJY8zfvxJ+VuZqoas4eXiMeBYNgvd1W4GzkKBaaQUxu2s8DAW35tNsJArkS5
 waC+FUGfxz/uSxK4bth3cykdyW0OPE5j9xcvk5qllhdjRO/pPE97EoPU+Hben5oC27OJ
 jcww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784102572; x=1784707372;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IXG7e5rrawzo35m9/0tm3JVzxLn0JXGxhNy6R+mWNdA=;
 b=tZvCB3Qr7HTBqbX9gZEksrM1O8cACSKACUU0doLN6HOv/v+JOU3RlYjmHYZLkalkVh
 MmBP0XCZttY3mrBrtNoFmxX0xMMyKA43rXgsQkTRBarJbuwL5VqhrPTpnSZvNQ37Vov1
 SUS7eCqAiGOW1Ltd/BiUpg4nRPke9PRshdbhv5a8fGWU7VNvV0XVITKFFq4Zdqywdf+w
 u9E8qO5yZlYbR1PXPCwTy+F+9XqVHOD9jmVLXN7Z9Brzoua8OojNE5YsrzaXJoyTw0le
 0k7EckZBvu5teBA8PQY2uRQcZnbaWD0CxT4K6af9EopatsowYcfSuPIcYszt8gpKRHa2
 dZWQ==
X-Gm-Message-State: AOJu0YwFZpGI0453Pwe13dYNy0Skdr2oeVSgwfFx/MFpo02JuRIEh/M9
 lVeiqMbOzZirNn2cQ1Sexp+JaW7256CrhYs5Z/njsVB1mH3gBo7GDI5L14TC5g==
X-Gm-Gg: AfdE7cmO1vt9LEyOy7X39EhfBwhZvfPoRH+g45a12psItfuidY0+ONBhpGu6SReOiYg
 gFEM6wd7rg5+T6q4HVVmB3UFbXgEvA9oWkNChokSNWH+oaIpEvPO9SAKykkNxz338fcREBhPk3v
 IDTVPlfjoHNFmLy2MccnO+37Eir7GXsYae3MXNYS2lsmg3RFL0O9I7mBGuYIHeqOxdTiCk1kQUR
 Ju1gkv6WzWUp1hekLm3V6Sjuwx8ELMyDNvDmtX2MwnmnL3RMJgvBsF9MI5VUu0y0/JG4RwNwmpq
 2l9QYtIOjse19wuwCCu5CUET3SnXoTB4PYKxiDXRVneH1IZmI46oYE2Fuk/3okyyW1ipUMib9Or
 EBsuf+7zqNj38B7nCmqQc/ADG+fp12XD6c9ziG5OvjZKR4oVy2xa5Pslj8o2GPCgAcjHIOpj5Vy
 VMhyEx6eS9wocrr5+rpz9GrkCy0a5iHPVocYCbOkcCqHcMsky2t1GzuIN+HHivkkW8mGivFSX8G
 HYF1P5WmM2BF8JBQ/CSCHighmi4sQ==
X-Received: by 2002:a05:600c:6207:b0:493:faf3:3ea5 with SMTP id
 5b1f17b1804b1-49538992bcdmr60001505e9.4.1784102571996; 
 Wed, 15 Jul 2026 01:02:51 -0700 (PDT)
Received: from timur-max.localnet
 (20014C4E24CD7200F6BBA872344E1A32.dsl.pool.telekom.hu.
 [2001:4c4e:24cd:7200:f6bb:a872:344e:1a32])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49508728019sm130013635e9.5.2026.07.15.01.02.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 01:02:51 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: Tvrtko Ursulin <tursulin@ursulin.net>, Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, pierre-eric.pelloux-prayer@amd.com,
 Natalie Vock <natalie.vock@gmx.de>
Subject: Re: [PATCH 3/9] drm/amdgpu/gfx7: Return error code when compute ring
 tests fail
Date: Wed, 15 Jul 2026 10:02:49 +0200
Message-ID: <7296879.9J7NaK4W3v@timur-max>
In-Reply-To: <CADnq5_M9hwLQw8YMqEebQ7q_kYLx2KKetZJFrszGOiOSYio_dQ@mail.gmail.com>
References: <20260713125838.30607-1-timur.kristof@gmail.com>
 <2c920253-9bbc-4057-b5e0-15414220a52b@ursulin.net>
 <CADnq5_M9hwLQw8YMqEebQ7q_kYLx2KKetZJFrszGOiOSYio_dQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

On 2026. j=C3=BAlius 14., kedd 22:41:33 k=C3=B6z=C3=A9p-eur=C3=B3pai ny=C3=
=A1ri id=C5=91 Alex Deucher wrote:
> On Tue, Jul 14, 2026 at 4:14=E2=80=AFPM Tvrtko Ursulin <tursulin@ursulin.=
net> wrote:
> > On 13/07/2026 13:58, Timur Krist=C3=B3f wrote:
> > > The gfx_v7_0_cp_compute_resume() function should only return
> > > success when all compute rings are actually functional.
> > > This will be especially important for soft reset which needs
> > > this to know whether the reset was successful.
> > >=20
> > > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > > ---
> > >=20
> > >   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 6 ++++--
> > >   1 file changed, 4 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> > > b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c index
> > > 9c4b3ac27e1f..a1a9f3fc4567 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> > > @@ -3019,12 +3019,14 @@ static int gfx_v7_0_cp_compute_resume(struct
> > > amdgpu_device *adev)> >=20
> > >       gfx_v7_0_cp_compute_enable(adev, true);
> > >=20
> > > +     r =3D 0;
> > > +
> > >=20
> > >       for (i =3D 0; i < adev->gfx.num_compute_rings; i++) {
> > >      =20
> > >               ring =3D &adev->gfx.compute_ring[i];
> > >=20
> > > -             amdgpu_ring_test_helper(ring);
> > > +             r |=3D amdgpu_ring_test_helper(ring);
> > >=20
> > >       }
> > >=20
> > > -     return 0;
> > > +     return r;
> > >=20
> > >   }
> > >  =20
> > >   static void gfx_v7_0_cp_enable(struct amdgpu_device *adev, bool
> > >   enable)
> >=20
> > Gfx8 and 9 (did not look further) do not do it like that. Should they?
> > Or there is more work there to be done first?

I actually added the same code for GFX8 in the previous series.
In gfx_v8_0_cp_test_all_rings() it checks that all rings are functional, an=
d=20
it calls that from gfx_v8_0_cp_resume().

I think it would be a good idea to do this for newer GPUs as well, but I=20
haven't yet touched the code for those.

> >=20
> > I actually might like this because maybe it gets us closer to removing
> > the ring->sched.ready hack but what I am just not sure if the idea was
> > to allow driver to function with some non-functional rings after resume.
> > Under the premise that if they initialized during init, then after
> > resume they must too, or if they don't, it is a transient glitch. I
> > don't know.. I am being imaginative here thinking about silly driver
> > workarounds for weird hardware glitches. It is much more likely this was
> > just an oversight and it is completely fine to to error out.
> >=20
> > I have to defer to Alex and Christian on this one.
>=20
> The reason for not checking the errors was because compute queue
> failure was not seen as fatal.  There are a lot of compute queues
> (relative to other engines), so if something happened, it seemed
> better to just continue in a degraded mode with fewer compute queues
> than to fail to resume in general.

We had a conversation about a similar topic (it was about UVD), where Alex=
=20
said that in general we should prefer not to handle degraded functionality =
in=20
amdgpu. I think the same principle should apply here.

1. My main problem with handling degraded functionality here is that I have=
=20
never seen any issue where just some compute queues fail to initialize afte=
r=20
boot or after suspend/resume. That means we can't meaningfully test that=20
scenario, so we can't trust any code we write to handle that either.
2. It would be very tedious to keep track of which queues didn't work in th=
e=20
first place vs. which are those that don't work because of a bug in the sof=
t=20
reset code. I consider the soft reset as failed if not all queues work=20
correctly.

Considering the above, I vote that we should just expect all queues to work=
=20
correctly at initialization and after a recovery. What do you guys think?

Thanks & best regards,
Timur





