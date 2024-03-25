Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DFC5C54E64
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Mar 2024 15:01:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C54C810E1EA;
	Mon, 25 Mar 2024 15:01:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DR6Doe2b";
	dkim-atps=neutral
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B31A410E1EA
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Mar 2024 15:01:18 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-29c14800a7fso3167610a91.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Mar 2024 08:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711378878; x=1711983678; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qRKaB5iUS0CbZnXclByI8JNrm3ewlTvie87HnzvPrGE=;
 b=DR6Doe2b6aai5OpU1OIMudiOlgj3XjRDZsKWOPmS56jsY1/neEZMuR2vlxcQmWtNw4
 jLTHLYrX9KRS2DpoJn5QtDCsQtW0A0H9G3+YLpnbLCPIjTk3Lps1FT+2/VLJVjbLwa7R
 piF1V4J7f68vu6z9E6a2YcnjxljoSqEJS7sVJ+u6SpgvPec01UT/306E7n0WY4BLWXgs
 usgSAcU1xDFVmE3hRcbucSkO9WrE4aKHP4W32WjQst6x8g6+9TJDFsZPVGVcBoqiKpMN
 KQ7zAf/fJNeE580g+AvnWzcnJ0OivOuKV45wNFHmhvxZG2qb05K2FptqlR/7Nx5WP+f/
 xGiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711378878; x=1711983678;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qRKaB5iUS0CbZnXclByI8JNrm3ewlTvie87HnzvPrGE=;
 b=SAIZrRbWI8FcUKda+0S/unv/JqbfbKv8e21+2NVZQd0YSH5ytEckqVn/W0ylipBjyc
 fJYdFFZBGMYSwvvZaTc6piHS2f1BGDjS8Hat1f5UXGrLVmQ2PVOlTGV37TPbjp1O7j0H
 WsNlXNIwkoBfMmMaktGJWYfTwH4JupkOUrrrfWDm1lO3ztz9Ty3z84JPDZvYlXUNVXBW
 9RuP73RWtCQbvdUM6FK1Q982yIFXcWSB4zzkA1Paj/HOFf2YCRUAjBnwCGsnAaZpu6Vq
 oT8G8BVF9wGmMeI0qmEtg7iWamPZiAhJ9lxBIXBUUOHptxOPfx+K7NcwZ1Rj6PpXg88g
 xObg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYuZTOgK9UJdIvRspo9fyxaglMONGjHEExj6c6n0slaiGLf2KZfx57CNBSOxMyOTkPIk4pTbzQbgqQOEchCnNCAG076T1NxBmRE7CKEA==
X-Gm-Message-State: AOJu0YzGEMdvpwitweU4QnNECvz8XbrdQvqrRwKR5vqrWHqYkyIUiQMj
 kgwRbs4FGmQCm8VWyj5gQ+4TzqUUjiHXpNPyWMRIJ+1DfH0eaxwLsT4aoE8owD6uboXACrudn5Q
 IgSx3rWUbCG75DITvrROmN2vspoI=
X-Google-Smtp-Source: AGHT+IHN2+QJIEv9Rbkm8NqxssEEZNu+kfA8e7f7Yk5FHbLW57xZsm8DvBJewq92SaiwWi9J6cR0vhrenNBVvObR540=
X-Received: by 2002:a17:90a:6343:b0:29f:66e2:d2a6 with SMTP id
 v3-20020a17090a634300b0029f66e2d2a6mr5241989pjs.26.1711378877869; Mon, 25 Mar
 2024 08:01:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240324005220.2649840-1-alexander.deucher@amd.com>
 <7eefc428-16b7-4f88-a99b-510203a244f9@gmx.de>
In-Reply-To: <7eefc428-16b7-4f88-a99b-510203a244f9@gmx.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 25 Mar 2024 11:01:05 -0400
Message-ID: <CADnq5_O6Vu3bh_P6vt2sOSxuwh0OoZqXdtLtzMehbnQv=uYo9w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: always force full reset for SOC21
To: Friedrich Vock <friedrich.vock@gmx.de>
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

On Sun, Mar 24, 2024 at 6:42=E2=80=AFAM Friedrich Vock <friedrich.vock@gmx.=
de> wrote:
>
> On 24.03.24 01:52, Alex Deucher wrote:
> > There are cases where soft reset seems to succeed, but
> > does not, so always use mode1/2 for now.
>
> Does "for now" mean that a proper fix is being worked on/will appear late=
r?
>
> Immediately falling back to full resets is a really bad experience, and
> it's especially catastrophic when only MODE1 is available.
>
> Of course, soft resets succeeding but leaving the GPU in a faulty state
> isn't acceptable either, but I think it's pretty important to keep the
> ability to do soft resets if at all possible.
>
> If it's not possible to wait with this until the proper fix is
> available, I hope that at least it can be reverted soon.

Yes, it's being actively debugged.

Alex

>
> Thanks,
> Friedrich
>
> > Signed-off-by: Alex Deucher<alexander.deucher@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/soc21.c | 2 --
> >   1 file changed, 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/a=
mdgpu/soc21.c
> > index 581a3bd11481..8526282f4da1 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
> > @@ -457,10 +457,8 @@ static bool soc21_need_full_reset(struct amdgpu_de=
vice *adev)
> >   {
> >       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
> >       case IP_VERSION(11, 0, 0):
> > -             return amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__UM=
C);
> >       case IP_VERSION(11, 0, 2):
> >       case IP_VERSION(11, 0, 3):
> > -             return false;
> >       default:
> >               return true;
> >       }
