Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECA7EC3DA49
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jul 2024 12:57:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3DC010E2D7;
	Fri, 26 Jul 2024 12:57:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="i6lZs+/I";
	dkim-atps=neutral
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com
 [209.85.210.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA55010E2D7
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jul 2024 12:57:16 +0000 (UTC)
Received: by mail-pf1-f174.google.com with SMTP id
 d2e1a72fcca58-70ea93aa9bdso778352b3a.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jul 2024 05:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721998636; x=1722603436; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EX0VpSpzBY1sGz7QXKiW7mOQ43Q7BwdAbHe5fbi3tNs=;
 b=i6lZs+/IeyadDBG+4Yb5dUAkeagy4MIWgP5KEGaiDgd2MXs8aOuf4EkG4YNbk1+lEP
 2ycOwNh0bTDRruwoYwpwwvjcqX03T+WHLb3L0oRjZaNj513bxSaN12WVqnPKIU7/mGpi
 qGVcga+bqR8eq2JdBNb1g23iOPn0HbpLZNLJBGWy1c46m+bqx1gYYq2J/cTjB2LlXhK9
 P3N6sqCU62Rj7s+Cl1Agp1WSWmTuSfKBgBYcTJzTuCbUSwBw8I7PTgWK/qyMJq6DFMGt
 R0fLruq2nuK7sDuAtNhneLgkvZbg+VNYQ1dTOIzxxO6hmXc8zdDDUbRO5Z5ZncSF1JlQ
 JRpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721998636; x=1722603436;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EX0VpSpzBY1sGz7QXKiW7mOQ43Q7BwdAbHe5fbi3tNs=;
 b=PaVZU7VfQBNzEaZPd1XxJpcDbM1OlvTFGyN+49anUR3Fj7HAMg5WoCQ7owFyn6CBzj
 E2aXXC4wpYP+jX9bouFd/qfOnv2hKagvKfIlp/MXdLcWluttFS2HzncwnkfCQHsJyHa4
 Q5jdU200tXdiGQKqGQG7dvkF+NvAg2iKq5LUNSnrTYH1S7GxTF2b6fhszLEOzk/H+xPk
 nzPaPDUQmRyffLsLEd6cYGUb2pC+TQtfoU9029DKBbxD9goWrWLi+c98ojoGbrZ1Ntpt
 +HRUbocPsQs0qsbeKO3v5YmWLq3akZbabbcYC6sdiK8qfTs+w70G1TG+ToN42xF2ompa
 JiuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVd+YBEOeLaHGxsDYPY09peOlCP0zQiRK36/pZfzZDPV/l0ZFg9XhFsxvawLcuWlPCnlnkOCqcbAnZmZ7U72N8IV3ARy5UYQjDMRo1rHQ==
X-Gm-Message-State: AOJu0YzjFBMpKVsEIqc+9uO3O+9xovdabX+mR6+JTasfPF63A7nw7upi
 rmqBidt7EK4RHxrbHiesKLdH5leNqUmNTBaOl8hb+gk3KuOPQ9bAAZhvLSi2jmonHF46ajBuldx
 /AFKZtKC3+158kvQsEs/Qf82vkjopKA==
X-Google-Smtp-Source: AGHT+IEOO6RBjsSS9XZYrB4GcGLR4Lbd+nHQgI1YeQSc5J1Ti60wwBW7TA3vwLlaalQSuKlgNpeEZUIYin/jHu3HFY8=
X-Received: by 2002:a05:6a20:2590:b0:1c3:b2db:4ddd with SMTP id
 adf61e73a8af0-1c4727fb0c5mr7391113637.13.1721998635989; Fri, 26 Jul 2024
 05:57:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240502202216.3385044-1-alexander.deucher@amd.com>
 <CADnq5_NsEWDX2T05PvaQHccLE8S8zUWYEeCmVn=4wEm+p1DdHw@mail.gmail.com>
 <DM4PR12MB51655820A3FFEB1AFD23BFEF8EB42@DM4PR12MB5165.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB51655820A3FFEB1AFD23BFEF8EB42@DM4PR12MB5165.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 26 Jul 2024 08:57:03 -0400
Message-ID: <CADnq5_P6Rrpd8n5kM7P41OhE4LYYOpUbVeuJnpJ35id44HeWrg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/pm: update documentation on memory clock
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
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

On Thu, Jul 25, 2024 at 11:11=E2=80=AFPM Feng, Kenneth <Kenneth.Feng@amd.co=
m> wrote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Hi Alex,
> I know that G6 MCLK =3D 2*UCLK.
> May I know how did you get the data that effective_memory_clock =3D memor=
y_controller_clock * 1?

I swear someone on the pplib team told me it was 1 due to changes in
the PHY.  I stand corrected.

Alex


> Thanks.
>
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex D=
eucher
> Sent: Friday, July 26, 2024 5:41 AM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH] drm/amdgpu/pm: update documentation on memory clock
>
> Caution: This message originated from an External Source. Use proper caut=
ion when opening attachments, clicking links, or responding.
>
>
> Ping?
>
> On Thu, May 2, 2024 at 5:07=E2=80=AFPM Alex Deucher <alexander.deucher@am=
d.com> wrote:
> >
> > Update documentation for RDNA3 dGPUs.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/pm/amdgpu_pm.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/p=
m/amdgpu_pm.c
> > index ec9058c80647a..9ad114e695e5d 100644
> > --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> > +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> > @@ -610,12 +610,18 @@ static ssize_t amdgpu_set_pp_table(struct device =
*dev,
> >   *
> >   * Clock conversion (Mhz):
> >   *
> > + * Pre-RDNA3 GPUs:
> > + *
> >   * HBM: effective_memory_clock =3D memory_controller_clock * 1
> >   *
> >   * G5: effective_memory_clock =3D memory_controller_clock * 1
> >   *
> >   * G6: effective_memory_clock =3D memory_controller_clock * 2
> >   *
> > + * RDNA3 GPUs:
> > + *
> > + * G6: effective_memory_clock =3D memory_controller_clock * 1
> > + *
> >   * DRAM data rate (MT/s):
> >   *
> >   * HBM: effective_memory_clock * 2 =3D data_rate
> > --
> > 2.44.0
> >
