Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ED5DC07D5A
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Nov 2023 21:55:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09A4810E3FE;
	Mon, 27 Nov 2023 21:55:48 +0000 (UTC)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9349C10E3FE
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Nov 2023 21:55:45 +0000 (UTC)
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-1f066fc2a2aso2451393fac.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Nov 2023 13:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701122145; x=1701726945; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JRrkOibBI2xutGYY7NLAyHS46z89sTj6YE2grjRoNkI=;
 b=coEngTfprub/3dIRPyx+PYjKkEJttSMOnvLQnsmWk+ePCQyN0LIDW6fS+ICsfAdGGd
 n5cQPOK840y8Lb2LQi33AB3Y6/56y0B4amFr8+2InBn2L0zAq/EbGiRZlf2Ud6MBXMGt
 fbBXrKvekt+bBSQwGg7Mu5p9ZqPfqjDIpiT14gcdHQHHa2LYZfLldA5QlC0u+SFKo2+S
 qzxla6bULVQJNfy3NiFMe6bUCfLKZ1J6LaxN3KzSOUKKl7V3IhL4KblaQSwJwD4EqWLy
 KX0ua0+efdb6L12aL8wNELCGz5Bgin/vSUwoFUjMz5XbUHgDDI2B9WxPzhVnnhiwEmu1
 NmSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701122145; x=1701726945;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JRrkOibBI2xutGYY7NLAyHS46z89sTj6YE2grjRoNkI=;
 b=pLfdJshd+OSH20q/stpO+kJp8L50NaZ1wJ5jYAkMQXL2qjp1M0JU3oIGJjxTe0BHyd
 YEmUHoM4f47GhK0v4JKLI1ELFtIyDxz2QxfCHtns6DWH1mAOocO8qW62oZMoyMzx7orW
 /u3IZDsDqEYvWlsfJ3hZnUcob3zlr+EEgCFIB7bUzIY+PD7LoS4lHNepqMKjxAcVrpYa
 zAzKdf/VvQVc/4Q7Ts26Fm5CMD6B1yXEZLxDS80tIb6BCORcehDxEXnRfej69Jk5wBCe
 WoiUZC3xzQHYRdsaywt4Fl6D4dMfx25GDMjDKepYMq5Tx/9icVgVy6Prxo5xO3QMMnFB
 ZeNA==
X-Gm-Message-State: AOJu0Yy70g0q5HMJ2znXiDYqIZWrJ/gv7NScqWAnp+WxOYD/2L5w8dru
 F5JgCjlObVCxKK/OWT4inu55559921OslR+yy6vZcnDR
X-Google-Smtp-Source: AGHT+IGw0kNBOq/vmlx90Qs36KHj0Nzz1qckhsk/87kGr6NXi1lapMaaX8uZOwHfqnxpj7GyRs5BhChcJ3mxoBlB9sk=
X-Received: by 2002:a05:6870:6c16:b0:1fa:1fa6:231a with SMTP id
 na22-20020a0568706c1600b001fa1fa6231amr11001203oab.39.1701122144784; Mon, 27
 Nov 2023 13:55:44 -0800 (PST)
MIME-Version: 1.0
References: <20231127182945.1109556-1-lijo.lazar@amd.com>
 <ac4bc87d-7ae1-45d3-8f85-0e294289ad3a@gmail.com>
In-Reply-To: <ac4bc87d-7ae1-45d3-8f85-0e294289ad3a@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 27 Nov 2023 16:55:33 -0500
Message-ID: <CADnq5_NA0fi8cGvrSzCtmtsWpgKhaG4O8T6cW+ObJoCm=iwzSQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix uninitialized return value
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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
Cc: Alexander.Deucher@amd.com, Lijo Lazar <lijo.lazar@amd.com>,
 amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Nov 27, 2023 at 2:22=E2=80=AFPM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 27.11.23 um 19:29 schrieb Lijo Lazar:
> > The return value is uniinitialized if ras context is NULL.
> >
> > Fixes: 0f4c8faa043c (drm/amdgpu: Move mca debug mode decision to ras)
> >
> > Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_ras.c
> > index 1a8668a63e67..f6b47ebce9d6 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > @@ -3410,7 +3410,7 @@ int amdgpu_ras_reset_gpu(struct amdgpu_device *ad=
ev)
> >   int amdgpu_ras_set_mca_debug_mode(struct amdgpu_device *adev, bool en=
able)
> >   {
> >       struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
> > -     int ret;
> > +     int ret =3D 0;
>
> That's usually considered very bad coding style and complained about by
> automated checkers.
>
> Instead explicitly set the return value in the code paths not actually
> setting it.

In this case, the function is so short, I think it makes things less
readable to do that.

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
> Regards,
> Christian.
>
> >
> >       if (con) {
> >               ret =3D amdgpu_mca_smu_set_debug_mode(adev, enable);
>
