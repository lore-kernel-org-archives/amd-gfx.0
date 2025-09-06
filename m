Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 167BDCA1002
	for <amd-gfx@archiver.kernel.org>; Sat,  6 Sep 2025 06:22:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46F8810E062;
	Sat,  6 Sep 2025 06:22:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GrZ4oOTs";
	dkim-atps=neutral
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com
 [209.85.208.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAAFE10E062
 for <amd-gfx@lists.freedesktop.org>; Sat,  6 Sep 2025 06:22:44 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-61cb4374d2fso4327091a12.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 05 Sep 2025 23:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757139763; x=1757744563; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=2PqpxFOlfLI6Npx6KQhV2OPYijNS8gn8cYGYLSM4JdI=;
 b=GrZ4oOTsrkXn297yvNTMAeufc2uUuDYSgtqP0bP9xfzZpDkxVG7DkDVWoct9/LlhUA
 jgct4H9/CoLh8TqeIkozlTSMpcP/n2kYaTfS/68Uw6MMvctu7sKPmO7KhK/sF0Ow15tI
 jrT/R+MUi+Hwbpj1RenwQC6lNtX7iV3r0o5f7e59NhiQK7PQyJVhs9iM3uA+GpbbgAeJ
 5IMwcduQkOXpS5QE9jwcFugg+/yqqmOr43MyVuH2eBirHDQED2+GlnJHoPpfcdwz5YXo
 f0Dr7GwwKmsRSwV4z1p3C928BhHy77lCvH2QGKC2smX6y/5oezf5vfJPwHebWYE1rFSU
 h7pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757139763; x=1757744563;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2PqpxFOlfLI6Npx6KQhV2OPYijNS8gn8cYGYLSM4JdI=;
 b=G2W8v+7gwAXwkmftf8TOhLI9BkgF4m+zhzWpQzCsne3wEZaOtfX8HzGTw1OgqHL3eZ
 1IRF9V6cLPr6k8Sbzi//qFR+S6KjrOAuv6slBdQ2Cwc4p70FW0DPctPdT7tioyvp1FcQ
 7xnJLiLM3IgczCdckxN6qb/WCHAcm6gpP/3Hi0klH5Hih5nrwqPSXdh2RwAwFGqj1Z8p
 FtwSv41y4JQKX+MqFWEBWkNY0R1Gay/BkU1m4/NtSz7Sy8eeiUi2ouU3qoycrGt1YMxg
 R89d9rBFPADXi7hMcAicDsvaNN+DxzNh4t0u+2cijA7y377tDOfV8xUNcOXa6BQrnEDG
 JdTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQOFRrf3VbkS4hRVxl0eRjORKOvUg51I6gm3rjM1y3vKWSID6hrDAhke204OoSVnO3Ry+y4JW1@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw/ga45emWojV93pCx3VvSNLntuoZZe+pgqmH/zUFYDWICr0xna
 W0EdRcXybaiTREb6ZCToPpxz6w3oAVD7+7jUiC6Do0k6jqgdAALNFkfn
X-Gm-Gg: ASbGnct6Ry1o4etry1czZBZvUG7nWYSQ5hZMTG/DeslGoscTeokpSD9piqVXm0WeEPM
 R9AzsNlp313qd5Vys05Kqe76yqhZ9K/T00CT1oBOAfV9W7m/oB64pL8fLGvdC/uUKpG60W/5GCa
 dzZ/eh9Ce42svT2a1/Nt1yxVgfL/WlHzPPt/dgdVd1a+hlx5sONLCO4QYNgphNMh7HcDD8gL6Jw
 yJq4JaskUo1UsisTwqWUUmWw7FRCacBrFcWLAjH1W6rLxPZoWLozkuGVt/zrqfNIXEpXbdLZT6C
 oi61YbGjxIETZ84awHJ7ezUB99gZrqjDC6VvGYPi1BCihpukAhBI2jtTcxC0uUlKuvs7/lfgfyj
 Oj+AaMdWmTQrYdJ9W2bo7qfI+VQEq
X-Google-Smtp-Source: AGHT+IEJfk++3pPE8o0cOO4TQzTq4xvUiIqbZd9Wio9SoNyt7RCKt5gXgrgUG/C8xsg+IrS4j+3IaQ==
X-Received: by 2002:a05:6402:5254:b0:61c:d330:77e7 with SMTP id
 4fb4d7f45d1cf-6237abddc02mr1261317a12.6.1757139762713; 
 Fri, 05 Sep 2025 23:22:42 -0700 (PDT)
Received: from [192.168.1.159] ([193.0.226.6])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-61cfc4e4d77sm18170478a12.37.2025.09.05.23.22.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Sep 2025 23:22:42 -0700 (PDT)
Message-ID: <ed094b44b9fbdadb6ec57161c0402b5e833d3a06.camel@gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: reject gang submissions under SRIOV
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>, Alex Deucher
 <alexdeucher@gmail.com>,  Christian =?ISO-8859-1?Q?K=F6nig?=	
 <ckoenig.leichtzumerken@gmail.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Date: Sat, 06 Sep 2025 08:22:41 +0200
In-Reply-To: <CH0PR12MB537231D3E692E6028C057F0EF403A@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20250905124742.11305-1-christian.koenig@amd.com>
 <20250905124742.11305-2-christian.koenig@amd.com>
 <CADnq5_OmQkYaYSu-QYCXV7YcPLtbVsKqwsjwWt=coPoRcrvadg@mail.gmail.com>
 <CH0PR12MB537231D3E692E6028C057F0EF403A@CH0PR12MB5372.namprd12.prod.outlook.com>
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

On Fri, 2025-09-05 at 18:39 +0000, Liu, Shaoyun wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
>=20
> I can confirm that during world switch the entire gfx block
> (including gfx, compute and sdma for gfx10+) been switched together .
>=20
> Regards
> Shaoyun.liu

Hi Everyone,

At the moment there are only two uses of gang submit:

1. Mesh + task shaders where GFX and ACE are used together
2. Transfer queues where SDMA and ACE are used together (not yet fully
implemented in RADV)

Based on the conversation above, it sounds like both of these would
work just fine under SRIOV.

Thanks,
Timur


>=20
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Alex Deucher
> Sent: Friday, September 5, 2025 9:32 AM
> To: Christian K=C3=B6nig <ckoenig.leichtzumerken@gmail.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>;
> amd-gfx@lists.freedesktop.org; timur.kristof@gmail.com
> Subject: Re: [PATCH 2/2] drm/amdgpu: reject gang submissions under
> SRIOV
>=20
> On Fri, Sep 5, 2025 at 8:47=E2=80=AFAM Christian K=C3=B6nig
> <ckoenig.leichtzumerken@gmail.com> wrote:
> >=20
> > Gang submission means that the kernel driver guarantees that
> > multiple
> > submissions are executed on the HW at the same time on different
> > engines.
> >=20
> > Background is that those submissions then depend on each other and
> > each can't finish stand alone.
> >=20
> > SRIOV now uses world switch to preempt submissions on the engines
> > to
> > allow sharing the HW resources between multiple VFs.
> >=20
> > The problem is now that the SRIOV world switch can't know about
> > such
> > inter dependencies and will cause a timeout if it waits for a
> > partially running gang submission.
> >=20
> > To conclude SRIOV and gang submissions are fundamentally
> > incompatible
> > at the moment. For now just disable them.
>=20
> Are you sure about this?=C2=A0 Thinking about this more, most gang
> submissions are between gfx and compute.=C2=A0 The entire GC block (gfx,
> compute, and sdma on gfx10+) gets preempted on world switch so all of
> the active queues would be preempted.=C2=A0 Everything gets resumed when
> the VF gets switched back.=C2=A0 VCN/JPEG gets switched independently so
> that could be a problem if you have a gang with VCN and GC, but I
> think all gangs within GC should in theory be ok.
>=20
> Alex
>=20
> >=20
> > Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > ---
> > =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 2 +-
> > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > index 2ac9729e4c86..434a551365c7 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > @@ -286,7 +286,7 @@ static int amdgpu_cs_pass1(struct
> > amdgpu_cs_parser *p,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 }
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!p->gang_size) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!p->gang_size || (amdgpu_srio=
v_vf(p->adev) && p-
> > >gang_size
> > + > 1)) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ret =3D -EINVAL;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 goto free_all_kdata;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > --
> > 2.43.0
> >=20
