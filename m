Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00636F3D31A
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2026 16:17:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9285810EC50;
	Thu,  5 Mar 2026 16:17:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jVkA6szp";
	dkim-atps=neutral
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A74C10EC3E
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Mar 2026 16:17:05 +0000 (UTC)
Received: by mail-dl1-f45.google.com with SMTP id
 a92af1059eb24-127337e3870so398174c88.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Mar 2026 08:17:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772727425; cv=none;
 d=google.com; s=arc-20240605;
 b=Buy+ojBs4atCmqrs+j5iWROqiaaKwaTKGS6H/USdqs8uqHxG5/gMAa/uIiZdKE72gn
 BN1QsQnB/ZuDyZntMk9dd6fduqTcxdG08OHk78DTjJXG7nowTq75ezwvxN3adL8UuEX2
 jx60nHxknPz/ZACqpAe5ld2dtPVNIYKpwA5AYO4ijs7XwSrJQqE044hGCXIB2eVKSP4Q
 emfS98x96M3SiVFsO+rMCazliMuKhMztAPWOwdKsMUaTqLJtOtrOHj9b+mjBR6XvJJk4
 knCVfOJAatttfcpJEFlgVS+aJN+YmOGq+mSeaTaUBjcaAtP0z6CJTnTurufvhy0VpYIj
 V9Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=VW4fluvLXpkSm5l3tJWLpzGdSZxAHhTQFuOxlkilp8Q=;
 fh=Tu1gLr2UAUz1DKxvTgjFVnniHuqtQ4ARVsYDcnB4B6g=;
 b=EWXs1gbkYgb4iG0DftpuMT6rzXwJ8qmkbMcDnDZFsg1lhB98BVi74ylSN1kHQbhV+Y
 dhZTVSDYBcS55SwOvay06NH4gHh/Kvupl+BfixDZXX3Xz9AiA1oOBge+Ot3CaG3vCs6h
 HcLsOSpWaQpz6UJKC7v5uBSVDTiudRpA5Rvkvkh1tWrRF5Nzx8vH/MGPubMlUtOZ73xe
 MLUzChpst/2VzPmnKrpv+UUZbS2tMWqSQE9LpU54j+ztBSv0JF/n0z3hNI1MXpcnMTzs
 jb2hyUCQUKu5czsdDIJpu7z3LRCsu2SYlhQbWKrVxdaQ7nDdFiX4Il0gkIAyB4VycN0S
 Zy1g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772727425; x=1773332225; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VW4fluvLXpkSm5l3tJWLpzGdSZxAHhTQFuOxlkilp8Q=;
 b=jVkA6szpt6uoNV9/Z8swU5Cw75qBTRC5hHXEbKC2JSCK4U/0u4mS96aGeRroeKlQhB
 LBSeU3qqFcmYW8RiRAfJwaKtBTM3KtPJ4p+5EBQhFwVtOGLZdiDrLV13tFHmZvaodNYM
 UVCeAip8FRW7FH00V1G/nVvIdwjo/KAodyY6prJRUe+LO34HjF8BmrinrAdFr+Bo3c5g
 NEXn6tL7AXY1bHoOSQgw53Iv0KI/wh29xYZ9fh9e/pOR9vC5VI3oiItdesyFkeg6xQMc
 3b49Mr3qP++Nsrx1tYZ0508osxXH4T77MXjGds51nPj6pfwRtycG976FzrZOwn2zzcAK
 dDqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772727425; x=1773332225;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VW4fluvLXpkSm5l3tJWLpzGdSZxAHhTQFuOxlkilp8Q=;
 b=O7z6clILxv0m95wXklHM8evoSRZs2SKbhCTqlABX+33Y+06ZE4lrzDf5MVfawsl/o5
 SrmMW8/2gK7AFHDSxQ9fOJZhOj2IoMX61ncEUb0smBKvJ6cellQQhOD0KVdq2/r5AbQ9
 8+4cTqAhfcz0M/I0RgrMeFBA3rtJbU1hURzD+Anz498vcg24G5UUD1OdxaxDz3289iuL
 6A+Pmtq4rtJF3CQTmYiAzLzaDS8j0REnYElq+i5vw3jTmqF0Z2Qa6Hda5mbqpyo01mFD
 CRslb3wkpQlDHMCKNAadzlr5rA+cOQhfxMRKQWiq6YnJKqeT/4280Wykn+vPZqAgIWtw
 r9VA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbiqi/QYAg5qp6wCCyP+LG+xtZ3fUnb0p3faHSHOP/VF0W6qc0FNA8ZcMppc+mEN3iNvvVpMll@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yypi3ET0sF1x5686Pw+VWbVsf7kwisSxiIsevP4z3UIf4k0Uoa0
 elwpuKj0HkmLuWH5N57y4POTlwqNHf8Iqu406YEpsFyL6Em0yuUgCRiHyn9sAYzjmsleKbFoVZa
 dZgfC6dnkilBmUU5IbECGtfug3nEc5dg=
X-Gm-Gg: ATEYQzwiT70Io9axXk/goNKvNCmL8g6knIFArkyErv6oeTdO/Wh/UbjMW4W2+j4S5fN
 KA2e86CMC7eSDUxfFpBQzsLVchhXZnBFXcyZV89JfAUUnzcR60bwATX+VauNqrQ8Xn4FEUpEuHR
 LWjmpG3AVc1h3ijzDEQjNVQgT4xUSPVjJA8wILKjJ5kgikJ0TiBefzzPWpLNUwadoS52fUIPKPW
 e8RSxRDTNFcvF2Eey/yVF7SZbX+ZvczBz7aDLaWMFQtd4GqRVjeUZwPKYJG4fn65chmL3HJYu9c
 zBEN7LmWNuyxvSkY67rJ0KhJppeaC7oYyh5N0huknEaikct7rqFUYO10PmIacUrg+voVitzTx00
 IKsKY
X-Received: by 2002:a05:7022:ef05:b0:122:33e:6ec1 with SMTP id
 a92af1059eb24-128b6fd1600mr1114670c88.0.1772727424705; Thu, 05 Mar 2026
 08:17:04 -0800 (PST)
MIME-Version: 1.0
References: <20260304222732.2403409-1-alexander.deucher@amd.com>
 <42e624f7-5190-49b4-95c4-dc22a6ba1ab8@amd.com>
In-Reply-To: <42e624f7-5190-49b4-95c4-dc22a6ba1ab8@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 5 Mar 2026 11:16:53 -0500
X-Gm-Features: AaiRm51ERRpcNIu8irMm6sRnIs1EpX-sCPj8JoIHrkXKcRhCfoGK613U-o03fh0
Message-ID: <CADnq5_Md6LQ2n7ciXKuhvvbcq7NZxHZ2VsY0TpPQyDNwAko7iA@mail.gmail.com>
Subject: Re: [PATCH 1/7] drm/amdgpu/mmhub2.0: add bounds checking for cid
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Thu, Mar 5, 2026 at 10:24=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.com> wr=
ote:
>
>
>
> On 05-Mar-26 3:57 AM, Alex Deucher wrote:
> > The value should never exceed the array size as those
> > are the only values the hardware is expected to return,
> > but add checks anyway.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c | 9 ++++++---
> >   1 file changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/=
amd/amdgpu/mmhub_v2_0.c
> > index a0cc8e218ca1e..534cb4c544dc4 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
> > @@ -154,14 +154,17 @@ mmhub_v2_0_print_l2_protection_fault_status(struc=
t amdgpu_device *adev,
> >       switch (amdgpu_ip_version(adev, MMHUB_HWIP, 0)) {
> >       case IP_VERSION(2, 0, 0):
> >       case IP_VERSION(2, 0, 2):
> > -             mmhub_cid =3D mmhub_client_ids_navi1x[cid][rw];
> > +             mmhub_cid =3D cid < ARRAY_SIZE(mmhub_client_ids_navi1x) ?
>
> Does this introduce speculation and requirement to use array_index_nospec=
?

I don't think so, but I'm not really an expert on side channel attacks.

Alex

>
> Thanks,
> Lijo
>
> > +                     mmhub_client_ids_navi1x[cid][rw] : NULL;
> >               break;
> >       case IP_VERSION(2, 1, 0):
> >       case IP_VERSION(2, 1, 1):
> > -             mmhub_cid =3D mmhub_client_ids_sienna_cichlid[cid][rw];
> > +             mmhub_cid =3D cid < ARRAY_SIZE(mmhub_client_ids_sienna_ci=
chlid) ?
> > +                     mmhub_client_ids_sienna_cichlid[cid][rw] : NULL;
> >               break;
> >       case IP_VERSION(2, 1, 2):
> > -             mmhub_cid =3D mmhub_client_ids_beige_goby[cid][rw];
> > +             mmhub_cid =3D cid < ARRAY_SIZE(mmhub_client_ids_beige_gob=
y) ?
> > +                     mmhub_client_ids_beige_goby[cid][rw] : NULL;
> >               break;
> >       default:
> >               mmhub_cid =3D NULL;
>
