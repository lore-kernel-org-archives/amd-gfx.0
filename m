Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDFD0C54798
	for <amd-gfx@archiver.kernel.org>; Sat,  9 Mar 2024 16:27:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA2201121D2;
	Sat,  9 Mar 2024 16:27:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="e5dYkd9T";
	dkim-atps=neutral
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com
 [209.85.218.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E96E1121D2
 for <amd-gfx@lists.freedesktop.org>; Sat,  9 Mar 2024 16:27:41 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-a450615d1c4so539210466b.0
 for <amd-gfx@lists.freedesktop.org>; Sat, 09 Mar 2024 08:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710001659; x=1710606459; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1P1wwMFoY2RUh7Yj+jL9MiMM7Nkvq6eanhZxeCT4jZI=;
 b=e5dYkd9ToV1Wp5OPL3UrbjOHJ8A3usa1Jkbry8PqFdlGTT+X0FxpnXLYy2ziPdfQHs
 IzNIb6UsNiEHkLQV0OscX6dy34n6+DnMeLbPHiA6BnQNu8X/QvwRQIRhsoM6qD059yU8
 JI3Q9sA/airr8sTw+bMWp8R5v1YiYldUZaomZPxp2jVvTPdEiynLRjB4PZCAOW5NUap2
 mCEuUGGrmKrWvo18WUg8pzvW7AnOLDf4RCtHNyGMZsr0nb0BmkdzZ/zvaobkRkRtmKtA
 fHX3lRU7vz0mXJSbZe6t40IjnBn7Sgcz4LvJCrD1JZQUwN52NO+fwigaerFwfUuARV4d
 jFbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710001659; x=1710606459;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1P1wwMFoY2RUh7Yj+jL9MiMM7Nkvq6eanhZxeCT4jZI=;
 b=bdlx9pHqEnkHbfipfkYqXPb7WD6TWSIyuuis64OVAnRoVn4hXx8/82CBB/JPVytJEz
 iyJsVGGni5bj3LiUUTpJ4VR3HX7qe1dpGh4FCidV1i+Q96hW1f7hUSrP2hGGtdzzF+vn
 KFLwPydvnj1KBqLHXrvxn25IVutMq3/LyCUQKXC7bXCbr+WNezg1mBnpd3W5YXgJ8ZWK
 dbbnJe/dAnz5EdfRwVk5g1MKJtRJe4SQ0f+LmyjjuQzt9Uq2C3mHyDTqhQlUJ54Diai3
 Yrow5RHEQhuPtFLH8cFsGAH0lXQdQ229dGptCL49tv4ka37u+xA/6LwX3SjnQhJKgtI/
 jOiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTocuJ+82VLMyUUw+OVj+xm9S9hDmifuToCqxKtSJP2sGHepDFHnBFOwE+CbFStJgyETekK32pw3nDPU0vreF5SzGCQox/eNsWuTUkNQ==
X-Gm-Message-State: AOJu0YzKgTPqNX5QDDEv5+4h2Pi9zmDw5sxf5m7O+y+OKUqhbhCbt8ET
 vnGxE5EnZL1NZN9+AH3YJ+7kGUfRc3b+VXojbSWYGnFNKlcSs5DA82mOx7U5WqVJQijzYCLvF1P
 LQ2fIzP1slS4yMShzy/e4NA+71kA=
X-Google-Smtp-Source: AGHT+IHHMNeP3+/otXi0qgvrZdjaTaAaOTiIqnN+erSanUTc3T8EWwNBtBOFWRSZpBbDRHpMPmETU7F++zaJ5QPVdQo=
X-Received: by 2002:a17:906:a14c:b0:a45:fa87:b011 with SMTP id
 bu12-20020a170906a14c00b00a45fa87b011mr1606134ejb.20.1710001659328; Sat, 09
 Mar 2024 08:27:39 -0800 (PST)
MIME-Version: 1.0
References: <20240307190447.33423-1-joshua@froggi.es>
 <d9632885-35da-4e4a-b952-2b6a0c38c35b@amd.com>
In-Reply-To: <d9632885-35da-4e4a-b952-2b6a0c38c35b@amd.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Sat, 9 Mar 2024 11:27:03 -0500
Message-ID: <CAAxE2A7SV2cwBAFKikKDjeHzWQMU+emXG7kR2okt0C9WvD6Hfw@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/amdgpu: Forward soft recovery errors to userspace
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Joshua Ashton <joshua@froggi.es>, amd-gfx@lists.freedesktop.org, 
 "Olsak, Marek" <Marek.Olsak@amd.com>, Friedrich Vock <friedrich.vock@gmx.de>, 
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
 stable@vger.kernel.org
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

Reviewed-by: Marek Ol=C5=A1=C3=A1k <marek.olsak@amd.com>

Marek

On Fri, Mar 8, 2024 at 3:43=E2=80=AFAM Christian K=C3=B6nig <christian.koen=
ig@amd.com> wrote:
>
> Am 07.03.24 um 20:04 schrieb Joshua Ashton:
> > As we discussed before[1], soft recovery should be
> > forwarded to userspace, or we can get into a really
> > bad state where apps will keep submitting hanging
> > command buffers cascading us to a hard reset.
>
> Marek you are in favor of this like forever.  So I would like to request
> you to put your Reviewed-by on it and I will just push it into our
> internal kernel branch.
>
> Regards,
> Christian.
>
> >
> > 1: https://lore.kernel.org/all/bf23d5ed-9a6b-43e7-84ee-8cbfd0d60f18@fro=
ggi.es/
> > Signed-off-by: Joshua Ashton <joshua@froggi.es>
> >
> > Cc: Friedrich Vock <friedrich.vock@gmx.de>
> > Cc: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Cc: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> > Cc: stable@vger.kernel.org
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 3 +--
> >   1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_job.c
> > index 4b3000c21ef2..aebf59855e9f 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > @@ -262,9 +262,8 @@ amdgpu_job_prepare_job(struct drm_sched_job *sched_=
job,
> >       struct dma_fence *fence =3D NULL;
> >       int r;
> >
> > -     /* Ignore soft recovered fences here */
> >       r =3D drm_sched_entity_error(s_entity);
> > -     if (r && r !=3D -ENODATA)
> > +     if (r)
> >               goto error;
> >
> >       if (!fence && job->gang_submit)
>
