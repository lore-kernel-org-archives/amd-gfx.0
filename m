Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0817C87FDB
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Aug 2025 13:35:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 507D710E475;
	Mon, 11 Aug 2025 13:35:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="J/R3F8TH";
	dkim-atps=neutral
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFFBE10E48A
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Aug 2025 13:35:12 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-24049e42f37so3193225ad.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Aug 2025 06:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754919312; x=1755524112; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=84sNkZvrOW1k1PWbS/vBQaH01fKqFeP8Lnq34vdgDlE=;
 b=J/R3F8THiM1LOtoepQNkCNirEF8sLKkAT3v4zxPc+RyEYTot50e8xucfa7OM2IRhJs
 Em0KAMsUEJPUsI+uHQQ4GyMMeLlzHTxdNyvTd5Og4jspT+u1paDpav1zxjY4d/ozCig9
 9Gs1BICEhMxy8Iqewg3Pj/uM4UOxqcAO8iRhDjfuxOL1sFICfdhcrKLyY1BP3w3Qu97b
 KI/tevooDFLXXZbn7QHp9boaE2xwf5CkC3rQphSGFGgm/ECzzRbaSt71/2xHlnePee4B
 EQUo8p7AY2J63WFUpORT6SUufKdPNjL7DJ0Qfd8NPdJktugpepv6ajHO8v34Zd5ofF79
 t1Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754919312; x=1755524112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=84sNkZvrOW1k1PWbS/vBQaH01fKqFeP8Lnq34vdgDlE=;
 b=d+mbzCX//pGILkfkxDnHXSx/sKqbgIhA6Jbp+HZb14OFnsUgkoLKg4Nf+BlbywdN/e
 pknQKHjOvGsVnNEShUHLb93E9KKiXGR/tV9b23r0sTeYx+DNVzvC9YjjFPUf9AVy+AjI
 DCAJstsbm+R15VAbw3G2IBS/ByNHiPWA5FbBHnmNz4u210OgE1ldHeLhdd6fBhD9p4Ob
 eXasv9P/owxEOs4VvSNz3UE01uv8/tdY65FzM41xfJ+wvKX1wK87aD3+jnVlnf+absg2
 oEqfU39X2kOKnrTQSSGwI3uqawxK5mUrgb0vLMZvQ6riwkQmkMxB9+sjyNODMQZPP2xL
 JzMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXa4JVjqMW3xam9j69cyMsSlH6kHHkUmfi9vs6T5n0p+2dQ8fHChb96MkEa0Vfn2C9xBkzX60RU@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxtA1W4ZCkzzjLKPBEe2EeU+VLWCYWF+Vu9HCDwZ9e/FmW8xQ1l
 JXLoSnxDDEthvvsqqC8Go5ZhL1R0kjTm6mmXL9r4f/Fs36Whhhv3Hsuwh3G/kPVn5omrmUNDwpD
 c76hQatB3MQDc5Fn/huEMo0ZY/UX+DnlkIg==
X-Gm-Gg: ASbGncvL9B54/25e4tMFFDabAb3AFgl9f0Exf2njDYlA7FI7r6WVMD/fba/aOm0bqau
 2mIDIyUoxLdQI6VCcu/6GHauMEdJWSW2B/r7MG9ejOrsT25wluC+TmOFvrng1CBeskG1I5diyes
 JPlwy/AcXCb7Mlnt9+BzHoj7/6R+zj1UTg00gzwvnt8dP1qzd4pI3ex7o45/Xk0zGHO0CL3po9s
 a6s3PpoH9FU2+sjCA==
X-Google-Smtp-Source: AGHT+IHykrwNnrf4q7gUeWlVpSMzF3Sgc+KqbTwg0mDXjVcieClbsteVE8gcQXaErn0BALVWv/pwqwJaMAhNoJlmf8Y=
X-Received: by 2002:a17:903:2449:b0:242:d186:5bce with SMTP id
 d9443c01a7336-242d383451fmr59257895ad.3.1754919312124; Mon, 11 Aug 2025
 06:35:12 -0700 (PDT)
MIME-Version: 1.0
References: <9846b386-87c4-4f86-ae11-6361470cbce7@amd.com>
 <20250811092125.22630-1-listout@listout.xyz>
 <a6da8462-e0c4-4bba-b65d-25ba3f5cdacc@amd.com>
In-Reply-To: <a6da8462-e0c4-4bba-b65d-25ba3f5cdacc@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 11 Aug 2025 09:35:00 -0400
X-Gm-Features: Ac12FXw-e0ywhoHK7Z0ZKlIK4kTRwiALit1X0nC7Kn7H_E-i-z1susch16guNcs
Message-ID: <CADnq5_MimooPVJXu9SnpL_1Yhkz0ZOfsXWDnnWAKmt+ymH=HRg@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon/r600_cs: clean up of dead code in r600_cs
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Brahmajit Das <listout@listout.xyz>, airlied@redhat.com,
 alexander.deucher@amd.com, 
 amd-gfx@lists.freedesktop.org, linux-next@vger.kernel.org
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

Applied.  Thanks!

Alex

On Mon, Aug 11, 2025 at 8:53=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 11.08.25 11:21, Brahmajit Das wrote:
> > GCC 16 enables -Werror=3Dunused-but-set-variable=3D which results in bu=
ild
> > error with the following message.
> >
> > drivers/gpu/drm/radeon/r600_cs.c: In function =E2=80=98r600_texture_siz=
e=E2=80=99:
> > drivers/gpu/drm/radeon/r600_cs.c:1411:29: error: variable =E2=80=98leve=
l=E2=80=99 set but not used [-Werror=3Dunused-but-set-variable=3D]
> >  1411 |         unsigned offset, i, level;
> >       |                             ^~~~~
> > cc1: all warnings being treated as errors
> > make[6]: *** [scripts/Makefile.build:287: drivers/gpu/drm/radeon/r600_c=
s.o] Error 1
> >
> > level although is set, but in never used in the function
> > r600_texture_size. Thus resulting in dead code and this error getting
> > triggered.
> >
> > Fixes: 60b212f8ddcdb ("drm/radeon: overhaul texture checking. (v3)")
> > Signed-off-by: Brahmajit Das <listout@listout.xyz>
>
> Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> > ---
> >  drivers/gpu/drm/radeon/r600_cs.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/radeon/r600_cs.c b/drivers/gpu/drm/radeon/=
r600_cs.c
> > index ac77d1246b94..811265648a58 100644
> > --- a/drivers/gpu/drm/radeon/r600_cs.c
> > +++ b/drivers/gpu/drm/radeon/r600_cs.c
> > @@ -1408,7 +1408,7 @@ static void r600_texture_size(unsigned nfaces, un=
signed blevel, unsigned llevel,
> >                             unsigned block_align, unsigned height_align=
, unsigned base_align,
> >                             unsigned *l0_size, unsigned *mipmap_size)
> >  {
> > -     unsigned offset, i, level;
> > +     unsigned offset, i;
> >       unsigned width, height, depth, size;
> >       unsigned blocksize;
> >       unsigned nbx, nby;
> > @@ -1420,7 +1420,7 @@ static void r600_texture_size(unsigned nfaces, un=
signed blevel, unsigned llevel,
> >       w0 =3D r600_mip_minify(w0, 0);
> >       h0 =3D r600_mip_minify(h0, 0);
> >       d0 =3D r600_mip_minify(d0, 0);
> > -     for(i =3D 0, offset =3D 0, level =3D blevel; i < nlevels; i++, le=
vel++) {
> > +     for (i =3D 0, offset =3D 0; i < nlevels; i++) {
> >               width =3D r600_mip_minify(w0, i);
> >               nbx =3D r600_fmt_get_nblocksx(format, width);
> >
>
