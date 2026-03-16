Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FEDCF53D82
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2026 17:56:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4235710E0AC;
	Mon, 16 Mar 2026 17:56:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iVk9mVeB";
	dkim-atps=neutral
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E997810E0AC
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2026 17:56:41 +0000 (UTC)
Received: by mail-dl1-f44.google.com with SMTP id
 a92af1059eb24-12711867ca1so266432c88.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2026 10:56:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773683801; cv=none;
 d=google.com; s=arc-20240605;
 b=HgRvHqWtf9KJf2U/zTGj3OB94NfEIETUAOh1wzsGI1hIuiAWQMY1Jf+nevCSRQpjY0
 E/2sIF9Nk9C31Y1JChgf28pZ14rn6ha9yYSE4a3SELdXQ48PhFOJ1SePaJ0pMFHHYtHM
 lR/mHJbHshUfWnbuHv6OgQzI9VLg7+A8cUT5yur0rt5fDLwHMDcAL1VGOmh3Jlz+tuHj
 r/uysM3aEECUZw5qYga4bPlZSns0yArElBoDMyLb8LziuzlUAjvMi5ID1OlaBOIWouHr
 z5Kela7qQHsw3B/D+YTg7xLSdqwNGqM/JpS4JI1hX3KyARwWy3hEJo0GjjGYlaoWlAZn
 TQnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=CwwBHwyqZWt8hMwcERqPQNytRT4JFrihhfaIt7JvawQ=;
 fh=u5hM9wggNTIVHRAuBhN45t8qgfQoQ+eH6M0P+claHfk=;
 b=hODEBWnyMWNx7K7lsdL2L9BEGSTyr1GzWjvYGo32xOJ/+RE9o0lQH91L/i+PqGb2LR
 55IrwGwreHBT2H/WQj0+7R/Ye8SPrVR5kOh6EIWSLo+IYpFYNU8LxSRoIy9IVXYQpvNc
 GBxkzg7LGsD4hW4ou0935xfnbAgS1soKulOdZ1JdCO1UfNoyYYGcEuJwUd+dxRWuUplc
 TUHnUBgvhqrxif4paZo6QyRDEL20PnGc88ydhbn5bHU+tLxxb88zCOBqB+tazmWw9BoA
 KcxD7df4ccXcNcfHC7C3RNcjEPphi2qM4P5/BDklNJF12Ex1J9ytfEhv1hW4UxYcf6L0
 teWQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773683801; x=1774288601; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CwwBHwyqZWt8hMwcERqPQNytRT4JFrihhfaIt7JvawQ=;
 b=iVk9mVeBp5K+71JeWT97VFRQ0XdN4vPw+Yi6LDNsfKr9AgJnv0KwKtqhNg06XvLdHi
 FszdcIwm0+Xk9+QAdN0BGJHkK0A3CJr7h2Rh+S6gr1Z5s4VMN7hZ4LwI3KVvlZZMlcXI
 MAzMIDER6Iy5jLJ/0I1DgxSZ9Qiqur+rD2XevSYlB8bfAOUgcRA6u80DJZh3ArgHOHSg
 AXJlu4CzlfH6jYGlefAZ4TLsnLPG6ATNsRdPV9M6VGY5m0Nu8ibsHAdnk7Ub9rr94ki+
 z5JdWmbXGAJeRQtDYUNO6wc+jEvYX29U8zQPeosS/JKNgY+CZALrvNJon+llbPiOjyUO
 quPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773683801; x=1774288601;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CwwBHwyqZWt8hMwcERqPQNytRT4JFrihhfaIt7JvawQ=;
 b=EKlA7bFoQIc/4ZGdnXvUaS6n3oGIVdaH107zGY/83ZQndWaUpwPgtFKGDlrEFsci2d
 k5Nq7v3Lk0V8drWse4zj1lUWOcZO6IerFUjb/BeaTEn3Fetwoc7zA+g4Vzi47M7Ix9XH
 lXG3cWXxFYISBuTeOLDJpOfW/+MMgQ3ahvtVqS0x3+aEkjORQpJWUFchV6iNgwdZJRab
 d/08mXeuctCphxKzjjO4L+y0hpaHioRAzEvuIQBDUCcNjdSDUQ0LnDauydqRslKgeBmK
 DoqF5dP/5IiE4zxlaF+AlNQTDqeLOnjTUQpEwM83r9gmPPKUfVY+sayNAKQ+fbKp3gtN
 4nRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWezQqZWFljP5UYw+Ce/GkMyeq6gKI1B0NY6MMA9krayMt+Y2ufKx5p64U43zqRMWhBSaNcM/Rh@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx0n0hYfm+siBuAv1O6USlSf3yFIJJWM67VYGQ3BSykp9JxJT6C
 sH9jgUKbAqRI8u+c5l+9knTENlS4Cq93KtkrpyLR+45mcSSjrIkGbrXY4TVbIQ//l7i1xobB4md
 KgCxup6wlpRoRNzEVtWywmSsA0glBBq4=
X-Gm-Gg: ATEYQzyfVSzrspD9afChrdlSuePYnFs64rRyNjdVetwkcaIaAzWW64szJfyw+zCapt5
 yAieBb0l72UXTsuP6it2sEZBhkCgFbh+lKz9oo4mImTAJ2lI0XOZKhDVAapB5UJ1xuzgfu4frLR
 6kgzlvggmQIslQOeyIg3SyobkQUrRxNohIhCF+5En95erA47TkarDoTAXV4Bnbhhk/auWoUGJda
 dJeKv3GFTL+37CVA6fhvpQxZBwFMq/dQtdvi3faEKeFDhL6C2itiP0t5kcskZDfadZ/0NC1w6LN
 cVw2aheX4Yj0HyoBe+bACK/JwDp4khNpUCPDZ73497c/aZxahr1qTjKuAlVuZuz/1tUhrw==
X-Received: by 2002:a05:7300:2316:b0:2be:1f56:ed0d with SMTP id
 5a478bee46e88-2bea552ea64mr3206501eec.6.1773683801013; Mon, 16 Mar 2026
 10:56:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260304222732.2403409-1-alexander.deucher@amd.com>
 <42e624f7-5190-49b4-95c4-dc22a6ba1ab8@amd.com>
 <CADnq5_Md6LQ2n7ciXKuhvvbcq7NZxHZ2VsY0TpPQyDNwAko7iA@mail.gmail.com>
In-Reply-To: <CADnq5_Md6LQ2n7ciXKuhvvbcq7NZxHZ2VsY0TpPQyDNwAko7iA@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 16 Mar 2026 13:56:28 -0400
X-Gm-Features: AaiRm50mJvwYtVHH2zPB8KeShwgCTLvErqo48JJZGSvIY61GSdIqv7uaz-L1_2c
Message-ID: <CADnq5_NGVphuiyT9Tyo73o2D7e4a5Y0unm7Ppht-+kmjDCyQ5A@mail.gmail.com>
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

Ping on this series.

Alex

On Thu, Mar 5, 2026 at 11:16=E2=80=AFAM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> On Thu, Mar 5, 2026 at 10:24=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.com> =
wrote:
> >
> >
> >
> > On 05-Mar-26 3:57 AM, Alex Deucher wrote:
> > > The value should never exceed the array size as those
> > > are the only values the hardware is expected to return,
> > > but add checks anyway.
> > >
> > > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > > ---
> > >   drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c | 9 ++++++---
> > >   1 file changed, 6 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/dr=
m/amd/amdgpu/mmhub_v2_0.c
> > > index a0cc8e218ca1e..534cb4c544dc4 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
> > > @@ -154,14 +154,17 @@ mmhub_v2_0_print_l2_protection_fault_status(str=
uct amdgpu_device *adev,
> > >       switch (amdgpu_ip_version(adev, MMHUB_HWIP, 0)) {
> > >       case IP_VERSION(2, 0, 0):
> > >       case IP_VERSION(2, 0, 2):
> > > -             mmhub_cid =3D mmhub_client_ids_navi1x[cid][rw];
> > > +             mmhub_cid =3D cid < ARRAY_SIZE(mmhub_client_ids_navi1x)=
 ?
> >
> > Does this introduce speculation and requirement to use array_index_nosp=
ec?
>
> I don't think so, but I'm not really an expert on side channel attacks.
>
> Alex
>
> >
> > Thanks,
> > Lijo
> >
> > > +                     mmhub_client_ids_navi1x[cid][rw] : NULL;
> > >               break;
> > >       case IP_VERSION(2, 1, 0):
> > >       case IP_VERSION(2, 1, 1):
> > > -             mmhub_cid =3D mmhub_client_ids_sienna_cichlid[cid][rw];
> > > +             mmhub_cid =3D cid < ARRAY_SIZE(mmhub_client_ids_sienna_=
cichlid) ?
> > > +                     mmhub_client_ids_sienna_cichlid[cid][rw] : NULL=
;
> > >               break;
> > >       case IP_VERSION(2, 1, 2):
> > > -             mmhub_cid =3D mmhub_client_ids_beige_goby[cid][rw];
> > > +             mmhub_cid =3D cid < ARRAY_SIZE(mmhub_client_ids_beige_g=
oby) ?
> > > +                     mmhub_client_ids_beige_goby[cid][rw] : NULL;
> > >               break;
> > >       default:
> > >               mmhub_cid =3D NULL;
> >
