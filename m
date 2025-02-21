Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25C3CC021B5
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 14:56:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87FEB10EA7D;
	Fri, 21 Feb 2025 14:56:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MsgW65oY";
	dkim-atps=neutral
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88C2D10EA7D
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 14:56:45 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-2fc8482c62dso530500a91.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 06:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740149805; x=1740754605; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EPgbwZHEmXNjyA+TuIRw0Hx+4A8xMWXiEAgCqj5z3s0=;
 b=MsgW65oYIWBuKmhQQ3dZmqLIJ/hsoGY0gCoM1zM6RG8E+WujvwZy3Q0dS/M+6Rnxg3
 Y7zYe08j8j+j7cuHxosVZZ63w8KINpTetXjRaMcJ5VjMgWUZEzwDdLaeo1b8tQ3aXMvK
 ttBjwePjHS5zH5FFqBphqnQUhBQGG+mnP7T/sP5H1aqK2ZtTv56GC3gOkR91TrT9tLae
 G8+u0xv1sHDvbuJahfuCL7mN0zyy56GJIBq4W1b1vxLpUcnFKtul0Dqz5dNJqUtYd8b6
 0pUYtmLj62gL81nHqw+0RICawpFnjw8TAkUIdD/QwiEbiWRZaluQTzkl0uc0KVX9mJav
 zaVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740149805; x=1740754605;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EPgbwZHEmXNjyA+TuIRw0Hx+4A8xMWXiEAgCqj5z3s0=;
 b=nsVu0j/P1JCxD3btN/lVRB3FzWUTYiJXzYPpd/t9epORwJkvpY/RjvDff6NEyulMBz
 yltkuPhz4i4L6FMPtTIbnwkwAgJXO4o5LqyKJuQzhNeZOxzeTi+gIaw+5nMqSioqDSA+
 tyYqq1/UxTLuNJEP9xiPOPnnPZqduTHavXTghwK5k+HO4BQV2ofss3rmuRtiuh9Ygr3x
 r9MV8KODSUAhXxhAkJCCu4gwQ+PWm9ZLRdOAy2VhXpf8XkOE7/PbSKkB9zYmC3ckuzdV
 v74QVYb7uGgebRvsnOpt0x5F6xHGPaL6r2XjMr+0YEg046PkigWlBSv092y+fb+YVsXb
 FEXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6gt/SU5RNC0RV5XInXXDl64lDiBs4iicJrAmiTiXoBCLjhIm4SXMgZ24ZGNv480ggZb6qwMzL@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywd4EUrj6XCkJo46op/ooa3kH/kzUmS38RNSbEW24g9CqAZTXUx
 sRFNrtorsPiEbgFu9N4giTCsG9eoHQb8tjiXbejrVM9mzdo2eUyNHPMDYg1BXx9NAexLj74g8yV
 bQbOkzaDuhlgICNVJTDTFTQ7z9H5UcA==
X-Gm-Gg: ASbGncsen/hung2Dk85mZCFojrTGwtFjcnUxSiKFIg7NJS8v4LppOTO2Q7njvKUXu6G
 S+3X3tydjPzD8KSCKMiztHG85pIxU3blK8YC60aNzY3Skr6HMpHi0s2HB9aVP52C+9kf46fwyTV
 GAk1koFF4=
X-Google-Smtp-Source: AGHT+IEwilNWiw2rzaUZ7mvVLVzNUwRCp+viZaFmCC/tGTeKYvHtx5mKSQFFP2zhO3WfyIDe76qy54NQG0+KZunPd/4=
X-Received: by 2002:a17:90b:17c9:b0:2fc:1370:9c2f with SMTP id
 98e67ed59e1d1-2fce7af8ddcmr2239987a91.4.1740149804779; Fri, 21 Feb 2025
 06:56:44 -0800 (PST)
MIME-Version: 1.0
References: <20250219184702.242924-1-siqueira@igalia.com>
 <20250219184702.242924-3-siqueira@igalia.com>
 <57df3cae-a70d-48c7-a623-fe8194f620cc@amd.com>
In-Reply-To: <57df3cae-a70d-48c7-a623-fe8194f620cc@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 21 Feb 2025 09:56:33 -0500
X-Gm-Features: AWEUYZnrfoIqcj5TyLN8B05XJ3z4t8QsUvng0Bqpd5gNos1PAihfNQfdPLPnbME
Message-ID: <CADnq5_P8=KRfUdk0C4tH=yvOPH2OEt1QexUCnQqBgkFWDnxSEA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mailmap: Add entry for Rodrigo Siqueira
To: Harry Wentland <harry.wentland@amd.com>
Cc: Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 Leo Li <sunpeng.li@amd.com>, amd-gfx@lists.freedesktop.org,
 kernel-dev@igalia.com, linux-kernel@vger.kernel.org
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

Applied the series.  Thanks!

Alex

On Wed, Feb 19, 2025 at 3:39=E2=80=AFPM Harry Wentland <harry.wentland@amd.=
com> wrote:
>
> On 2025-02-19 13:46, Rodrigo Siqueira wrote:
> > Map all of my previously used email addresses to my @igalia.com address=
.
> >
> > Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
>
> Acked-by: Harry Wentland <harry.wentland@amd.com>
>
> Harry
>
> > ---
> >  .mailmap | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/.mailmap b/.mailmap
> > index 5e829da09e7f..64413bbc286c 100644
> > --- a/.mailmap
> > +++ b/.mailmap
> > @@ -583,6 +583,8 @@ Richard Leitner <richard.leitner@linux.dev> <me@g0h=
l1n.net>
> >  Richard Leitner <richard.leitner@linux.dev> <richard.leitner@skidata.c=
om>
> >  Robert Foss <rfoss@kernel.org> <robert.foss@linaro.org>
> >  Rocky Liao <quic_rjliao@quicinc.com> <rjliao@codeaurora.org>
> > +Rodrigo Siqueira <siqueira@igalia.com> <rodrigosiqueiramelo@gmail.com>
> > +Rodrigo Siqueira <siqueira@igalia.com> <Rodrigo.Siqueira@amd.com>
> >  Roman Gushchin <roman.gushchin@linux.dev> <guro@fb.com>
> >  Roman Gushchin <roman.gushchin@linux.dev> <guroan@gmail.com>
> >  Roman Gushchin <roman.gushchin@linux.dev> <klamm@yandex-team.ru>
>
