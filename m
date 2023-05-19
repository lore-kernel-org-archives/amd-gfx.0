Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF89C77B75
	for <amd-gfx@archiver.kernel.org>; Fri, 19 May 2023 13:37:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF26D10E021;
	Fri, 19 May 2023 13:37:05 +0000 (UTC)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FEB910E021
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 May 2023 13:37:03 +0000 (UTC)
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3942bcf62f3so1159567b6e.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 May 2023 06:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684503422; x=1687095422;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0mNJRDNvM2MoEHXgaR8tH2cJ392Hg7M2RRaUQcRXPpk=;
 b=aiV6oWdm3n1UdNlrEmkcq3WLfz4n19PwwjPfuvleRLKVYmqFjdKlhyqzTwrB9uH+gS
 sXwmCRX1AnTwZ6hGtc9y0yFqjibV+mKBmMdri+sxgtO+7lxoY68374VaCXpqsxXRDERg
 14oefNagc4XBMqPcqXNLfqz4/AB/q0TdPiVPFLqaXLO0bokVDeWbt1AZ8lpI44aNBoxb
 WM+CoSjZcN3x//QGbvdwm51n3KCsRWWnbIHgIn/WPm3Df4kncITd5B76rKxa6gndYDgD
 aCFN3R7iEn+CTL7VfHWMPWVgEJstuPiIecAchqqhLTsp+RI+AcdzBd4fCO94Ye9qhhbK
 bq4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684503422; x=1687095422;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0mNJRDNvM2MoEHXgaR8tH2cJ392Hg7M2RRaUQcRXPpk=;
 b=Y67nxRdLzCF3CFZpSt9D5AwNc61Px84GZsK6fiJyKeciZXltFx6M4Bd1ZY8qCZEsP1
 zl/1JOsqQa/H1NaN3M3IiRszDrOWhoXX385RV53EPlaEOcsUU7lh4BVYd+rbXScVa7A3
 V0z4Dp0VGYrX6GgqQdCgB9hGoCTNAQ34e9mc/R/jMLrC9nb5IJWAu52LgHFDbuy++Dci
 lYOKgtpAINWznpkdWpfyvG9llJw5OG4G4jn1GIxVmuPD+kC65s6DVSH2wQnqOiaVQytg
 n19XP3Gc5uSRRaY8/3qmRc+G76hGhZR5yqULA+mlgdQIhGG7m0eQ7ik+F8yxfUKWk333
 pGMw==
X-Gm-Message-State: AC+VfDz3/3wgvG8Gk0Jy7J/r+I/aD0NfDdjlDojzA1gRw9W7easq/Fte
 OkYo02w3eL9ujNe+6D1CLXCwF1WtG84ZRh1bAMw=
X-Google-Smtp-Source: ACHHUZ4bQYs6y47mzDnpkWF9CnMG7R5DIiBGFJrgYVmVbwwcf7CUFQMAFUYKyPTs6Yj4b9D/cG0qLyIahl4IpafGJmQ=
X-Received: by 2002:a05:6808:b2b:b0:396:e16:1a42 with SMTP id
 t11-20020a0568080b2b00b003960e161a42mr1160776oij.36.1684503421766; Fri, 19
 May 2023 06:37:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230510212333.2071373-1-alexander.deucher@amd.com>
 <20230510212333.2071373-6-alexander.deucher@amd.com>
 <CAHbf0-GBC+4uPm=QCaH4a8FT56AnRJy-_wwMQ6z9q0mv3nr77w@mail.gmail.com>
In-Reply-To: <CAHbf0-GBC+4uPm=QCaH4a8FT56AnRJy-_wwMQ6z9q0mv3nr77w@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 19 May 2023 09:36:50 -0400
Message-ID: <CADnq5_NHewmJdU6R73n2SrG+Zxdv02HAJAVb95b0UO3y6q9D0A@mail.gmail.com>
Subject: Re: [PATCH 06/29] drm/amdgpu: keep amdgpu_ctx_mgr in ctx structure
To: Mike Lothian <mike@fireburn.co.uk>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, May 19, 2023 at 8:16=E2=80=AFAM Mike Lothian <mike@fireburn.co.uk> =
wrote:
>
> On Wed, 10 May 2023 at 22:24, Alex Deucher <alexander.deucher@amd.com> wr=
ote:
> >
> > From: James Zhu <James.Zhu@amd.com>
> >
> > Keep amdgpu_ctx_mgr in ctx structure to track fpriv.
> >
> > Signed-off-by: James Zhu <James.Zhu@amd.com>
> > Acked-by: Lijo Lazar <lijo.lazar@amd.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 1 +
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h | 1 +
> >  2 files changed, 2 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_ctx.c
> > index e3d047663d61..06d68a08251a 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> > @@ -332,6 +332,7 @@ static int amdgpu_ctx_init(struct amdgpu_ctx_mgr *m=
gr, int32_t priority,
> >         else
> >                 ctx->stable_pstate =3D current_stable_pstate;
> >
> > +       ctx->ctx_mgr =3D &(fpriv->ctx_mgr);
> >         return 0;
> >  }
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_ctx.h
> > index 5fd79f94e2d0..85376baaa92f 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> > @@ -57,6 +57,7 @@ struct amdgpu_ctx {
> >         unsigned long                   ras_counter_ce;
> >         unsigned long                   ras_counter_ue;
> >         uint32_t                        stable_pstate;
> > +       struct amdgpu_ctx_mgr           *ctx_mgr;
> >  };
> >
> >  struct amdgpu_ctx_mgr {
> > --
> > 2.40.1
> >
>
> Hi
>
> This isn't compiling for me with clang 16
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c:348:19: error: use of
> undeclared identifier 'fpriv'
>        ctx->ctx_mgr =3D &(fpriv->ctx_mgr);
>                         ^
> 1 error generated.

When this patch was originally written the function had fpriv defined,
but it got missed after a rebase.  Fixed up now.

Alex


>
> Cheers
>
> Mike
