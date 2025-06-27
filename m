Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D6D6C7EE31
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Jun 2025 14:46:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF67610EA48;
	Fri, 27 Jun 2025 14:46:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="afG8zh7b";
	dkim-atps=neutral
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
 [209.85.215.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B882510EA48
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Jun 2025 14:46:27 +0000 (UTC)
Received: by mail-pg1-f175.google.com with SMTP id
 41be03b00d2f7-b34b770868dso290998a12.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Jun 2025 07:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751035587; x=1751640387; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EV38qf8YhY2NyOejxwbzB6mKfWXObd9wqPIX5QX0gWI=;
 b=afG8zh7bZhhmOdRN0VjOhYRT6B1Rm8Ct+FjlN/0D30icoKkQcodhN+/fdOy+j7RzeJ
 JWSipMF1+swX1+GrItct06oRhZ0BrF9k/4jZnjq7shHiX+Ql7/twqWAmVlV4xS7rgCkR
 1x3cT8QvjHyQigpni5gRDZ43LvvQ3+IcsA/6wne7I/lzbdNQ09J9/QOXablmTzLHO+us
 cRv+s5v3sGn6xNXzjKcAm1S+31VY/6S1cxbrw6lGXLqQwtxYP4owU/3mjM+QEz29yBUl
 RjSxs9VXJ3T1L3Q1oT9/H8AE+kAA3IZBk0UCTZoHN9rpQgdQtFHqblx1ovRz28aJuBRH
 uBLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751035587; x=1751640387;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EV38qf8YhY2NyOejxwbzB6mKfWXObd9wqPIX5QX0gWI=;
 b=GRDxsn58JQ33jFHAKrL5WEfB5gSWO1KzKvelIJkwEqmcK/9t05j/SarqPpNIzXy9es
 nVOYQNYBFUxupXiLh9uTRgDN6J5ZmYeKCAClpg/WunGWkPkW1vKN7+ZuHe22/kwt/sJ1
 fimcVMaHbgUAv5ZniTKYFguifdU3OM1LsprNrJwHaBI+9Y6PdLq9cnoQDDhe0p9WIIve
 4kdHB+NPZPFJhHF6CDy4ZB+SPbw3fdH388TxnvICfbH0c8MXxL7YbSG8blDz0SgSDpjo
 77mxPvzhPnk2OaJWgzIbLZ+/kvSofV7TUrqSgdWSSEyl8Iul2rd6tpH6ND5tgdXmbzZD
 sOzw==
X-Gm-Message-State: AOJu0Yw/8Xm9abll98Pn6ee9WfcpB4Maifu4iSAZzdS6F/izt4b9Kh9x
 n7AiG/BdWw/I+PBXkwEbwnuq59xYUES0kIUBUZP6cLhQBXBN1s9y8k1OjzJzc4Amk4gznJ6akea
 wRFBfFIy05lHsh3Pr8EHFLsT2In32PNpFoBZo
X-Gm-Gg: ASbGncuUHQD7auKj938qx8DHvV/RBN0T4Mp/czcGuT2O5Rsqh65cxlJSTq4M7BeSw22
 FpDQb8kqiA3CIpwrgBN+VB0tKmwpnIUpTxpj944032Ajdw7ZmMay1XQcCTAjDSr52nKb4t9xa0j
 DVYm8A6qcEmJmLFX1mC+92g44HZXryFxyJRFN1hPaK1ziF
X-Google-Smtp-Source: AGHT+IF1nGewjOojFDoxMUAK6zh9AX9MNO8j4Io9hhwozIdh/Y18YdBX9KKxk+98aNqgVvvbSDI/Bq7DhRC1HokTb9k=
X-Received: by 2002:a17:90b:6c5:b0:314:29ff:6845 with SMTP id
 98e67ed59e1d1-318c923bf51mr1889099a91.4.1751035587089; Fri, 27 Jun 2025
 07:46:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250610191232.15597-1-patrick9876@free.fr>
 <20250610191232.15597-2-patrick9876@free.fr>
 <CADnq5_M=yTiipiYxwvxGDGMfbWqOWJwcdRk1kgPVK_jB7=f+Ug@mail.gmail.com>
In-Reply-To: <CADnq5_M=yTiipiYxwvxGDGMfbWqOWJwcdRk1kgPVK_jB7=f+Ug@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 27 Jun 2025 10:46:15 -0400
X-Gm-Features: Ac12FXw5vUwzpF7ZcHZtMUat-Gwf7s-0Y_vhC9MI_3daIUafqiiKDNcZm8-t7Dc
Message-ID: <CADnq5_MRRO=YPv4OfzYeiZUgjqi35yKLG7+fOVmqaVXn5FZHTw@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/radeon/evergreen_cs: lower
 evergreen_surface_check_linear_aligned restriction
To: Patrick Lerda <patrick9876@free.fr>
Cc: amd-gfx@lists.freedesktop.org
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

BTW, do you want to send a patch to bump the driver version so that
mesa can check for this and determine whether or not to enable this
functionality?  See KMS_DRIVER_MINOR in radeon_drv.c.

Alex

On Fri, Jun 20, 2025 at 5:41=E2=80=AFPM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> Applied the series.
>
> Thanks!
>
> On Tue, Jun 10, 2025 at 3:12=E2=80=AFPM Patrick Lerda <patrick9876@free.f=
r> wrote:
> >
> > This change removes the restriction when palign=3D64 and nbx=3D32.
> > This makes two piglit tests working. This is discussed on the
> > thread linked below.
> >
> > Link: https://gitlab.freedesktop.org/mesa/mesa/-/issues/9056
> > Signed-off-by: Patrick Lerda <patrick9876@free.fr>
> > ---
> >  drivers/gpu/drm/radeon/evergreen_cs.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/radeon/evergreen_cs.c b/drivers/gpu/drm/ra=
deon/evergreen_cs.c
> > index 7d00096fc915..266c57733136 100644
> > --- a/drivers/gpu/drm/radeon/evergreen_cs.c
> > +++ b/drivers/gpu/drm/radeon/evergreen_cs.c
> > @@ -211,7 +211,7 @@ static int evergreen_surface_check_linear_aligned(s=
truct radeon_cs_parser *p,
> >         surf->base_align =3D track->group_size;
> >         surf->palign =3D palign;
> >         surf->halign =3D 1;
> > -       if (surf->nbx & (palign - 1)) {
> > +       if ((surf->nbx & (palign - 1)) && !(palign =3D=3D 64 && surf->n=
bx =3D=3D 32)) {
> >                 if (prefix) {
> >                         dev_warn(p->dev, "%s:%d %s pitch %d invalid mus=
t be aligned with %d\n",
> >                                  __func__, __LINE__, prefix, surf->nbx,=
 palign);
> > --
> > 2.49.0
> >
