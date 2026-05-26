Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C66BCD5BD5
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 22:37:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E1CB10E6F9;
	Tue, 26 May 2026 22:37:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TQ0/zbPX";
	dkim-atps=neutral
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com
 [209.85.217.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8138810E639
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 22:37:07 +0000 (UTC)
Received: by mail-vs1-f44.google.com with SMTP id
 ada2fe7eead31-6312f28a760so338567137.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 15:37:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779835026; cv=none;
 d=google.com; s=arc-20240605;
 b=DSbVlzwKuXoTWyxY2f7kLyZjg4mDIPV6HfR7bjXEJQk+J3TRZxMMVPiyyAmTKAPi4n
 n9BQeYH4IcgUGYR6Wh6FqBoHfXFXHc8hLEobGQ3UHiuyPM8jbS/YGR9A+IRz9PrWsB/0
 PEz2BEsOSqvRzzg145hQ51cAxZndcnWQXWO9EF5qrZ2qihfmuOcOPD+DFNFBv0r006jo
 0xqJiMdRYji0f3xkbRwChFDCHrI2QfNleD9Q1h5FIQzttECVp+zhtreb/i7Y1ex8DX5e
 Dw6UWYui+DPi5uL7uTbO0YYIUxwDBjDBY/Wg+l1TW6GdPmEAp8IING/k4zSVS8bMbh3J
 2+MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=gxsa05tUjuouFbGm3c0WM2ZsVVNT8ITY2j7gA87tNBI=;
 fh=SSepdVjgjLqvKTbkMC7s6dqFdXAF5x7eHvAB+mMvtdM=;
 b=MHkyaHRVaez7Db2ynCz9r9oggZeDe7kxPYAuPElg+iSskC0fEFhZU7DXirZrutIv//
 urpgCAfzAFbWD1MlW5QcBht3bp+VoTWqy8olNCa8IYxlBE/AzJTCE1r6hoB6onsW+3En
 YY5i2Y2HT1mOgguXGomXBr71KZZTgmDGDGRc6vJA0V/PUaKrNcB4W98/JUIovCucEv17
 ohRbdZ8TknKuyqcQJx3QOd63qS/yzSzQm4p5IqBS5hVTP9Mx9vSC+Q0mhC1kaLmWb2Od
 JqAtg+1Fx9iElQf/TMjarXDq9AFheTDyh18IyPGm4Q6eEVGskb/JeYhKBtve13Zv0fN5
 TpmQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779835026; x=1780439826; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gxsa05tUjuouFbGm3c0WM2ZsVVNT8ITY2j7gA87tNBI=;
 b=TQ0/zbPXBJmH7EZyUB/DPr8SrRccWGhN4O9tUCK//7aU4Ea7IgJq0+eC53A5vNBjFs
 c5wrrovavTXRbukDpeN2v8xG5IjamuoYOX2EIrNuo54jUGVrN+3mxdIXqE1wqQYQsH8l
 ODnkHt2WFKaEKDjQm0x0j3ePj4lbRP47CUmakF5sMh+5jFT+mY1WWSDS1V5nUm+pEpG8
 SOtECNJX/yMh2y5r1sYLpvloMiNNnLKvGd3GI6w6jy0c6II6vPn0iZAYovxYXuB+nFEf
 yjd9XGAXyZJXFm8Y+5vCKHNRbXZpoJR9clC0B/QRY9IEgdpu18qDqSGI7HjXee+8F7zW
 IScg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779835026; x=1780439826;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gxsa05tUjuouFbGm3c0WM2ZsVVNT8ITY2j7gA87tNBI=;
 b=lejq9eezXqudwiXp/7LV+Z4thuWXY0xQN8oBJesrN3pNF9ozXsWEPJTrQ1O6iTzXTv
 9wO5a9SZkonO+suh1Y3CKCo8lhJtVd8strQeORkRTljFhuSw/m+s8urLhpvEtC6f3DM8
 tPjH2LDPCC9M3N85/zW+e2vIGDKgnEiZNL9GZucXB+mn/dEmgsUivbs9O6oK9ebcPyko
 9VjAdmHfn3i6AdNurqwufmGc+IplkUd+6n37TB+28NLZJylGNFtFTCj8AJu51eL/azry
 hgYKMtddRhUqBVeXI3UD4ISDzIMjuoqAPK4WvpeN1deONaIDUzBWi/91wrs3A9n0MwBg
 ofug==
X-Forwarded-Encrypted: i=1;
 AFNElJ/V5cFaskYCEccxcqp2PHNiQN8TJthnoBVI6UU2obqIErLCEtASGCWaPQUL3U7+B5yxFZWycLOf@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwnQwUC5WqRk6JZ273Fgv0GyUo53BihIphcrcdaz7uwgJC5CJwf
 gYsieGyzvwn+JPFrWCnLj6eP34Otn6l5cnB8mgAX48wB9ZyaPl9abV/ITd3TGaA+0DrOFmOIUNo
 7obegGXt5bXPUVWbGsMJBb7OAn88Htac=
X-Gm-Gg: Acq92OGbaWv0siizie2O8LHI0VuAiQe4VnofzzhL0EJZ6OfAOZvqTyy1R4UVu7cEY4b
 iEqTgoOj4bziSaxMeVXhv0SepW0qfE0oYohV2Abv83evKyBsUH+S9/zh+GjtP8D+MdwoEbU9yX7
 lmjRKRy6ixkwv4dkf9kGPnRjPtUFMmvzw5/DzpxzR30puRLFU4+/r9g7oXPakTmrdVqAdMcUNOn
 DhCyRccP5sA4oC2q7aJbt5pxnaAhy9lIHhiXsD8CwS/UC8u1awYhbThdpon2fPv6sVwdEvt6XXV
 /k76/9ttX8XlZkKaMjsDO8ebCBf4SWBIJj7aaCbCnGWGy3xK+sB4hnLURUDLzbGAPcAliyJ1/Ux
 Zr8e6
X-Received: by 2002:a67:fc49:0:b0:631:267d:157b with SMTP id
 ada2fe7eead31-67c8abf92cemr3725772137.5.1779835026402; Tue, 26 May 2026
 15:37:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260522002048.98506-1-alexander.deucher@amd.com>
 <20260522002048.98506-22-alexander.deucher@amd.com>
 <DM4PR12MB515279360273798EE8A982ADE30A2@DM4PR12MB5152.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB515279360273798EE8A982ADE30A2@DM4PR12MB5152.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 26 May 2026 18:36:53 -0400
X-Gm-Features: AVHnY4II9PjTKWHMJAY6-n8RgPqEMgfGM9mm8JoLbynCkOK7bRtB2Kcdskn5z1I
Message-ID: <CADnq5_MtWDE6dMSmi4snT2uOxDfCsQANd7m=JMuebu80wQSCwg@mail.gmail.com>
Subject: Re: [PATCH 21/42] drm/amdgpu/userq: add mes userq reset callback
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Khatri,
 Sunil" <Sunil.Khatri@amd.com>, 
 "Lin, Amber" <Amber.Lin@amd.com>, "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
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

On Mon, May 25, 2026 at 5:39=E2=80=AFAM Zhang, Jesse(Jie) <Jesse.Zhang@amd.=
com> wrote:
>
> AMD General
>
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> > Deucher
> > Sent: Friday, May 22, 2026 8:20 AM
> > To: amd-gfx@lists.freedesktop.org; Koenig, Christian
> > <Christian.Koenig@amd.com>; Khatri, Sunil <Sunil.Khatri@amd.com>; Lin, =
Amber
> > <Amber.Lin@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; Liu,
> > Shaoyun <Shaoyun.Liu@amd.com>
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> > Subject: [PATCH 21/42] drm/amdgpu/userq: add mes userq reset callback
> >
> > Enable per queue reset for MES managed queues.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> > b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> > index 14db2124ff81c..4f285a8218ddb 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> > @@ -177,6 +177,26 @@ static int mes_userq_unmap(struct
> > amdgpu_usermode_queue *queue)
> >       return r;
> >  }
> >
> > +static int 4(struct amdgpu_usermode_queue *queue) {
> > +     struct amdgpu_userq_mgr *uq_mgr =3D queue->userq_mgr;
> > +     struct amdgpu_device *adev =3D uq_mgr->adev;
> > +     struct mes_reset_queue_input queue_input;
> > +     int r;
> > +
> > +     /* XXX: add a FW version check for SDMA per queue reset */
> > +     memset(&queue_input, 0x0, sizeof(struct mes_reset_queue_input));
> > +     queue_input.doorbell_offset =3D queue->doorbell_index;
> > +     queue_input.queue_type =3D queue->queue_type;
> [Zhang, Jesse(Jie)] should we use mmio for userq ?
> queue_input.use_mmio =3D adev->gfx.mec.use_mmio_for_reset;

We don't have the queue and pipe info to do the reset via MMIO at this stag=
e.

Alex

>
> > +
> > +     amdgpu_mes_lock(&adev->mes);
> > +     r =3D adev->mes.funcs->reset_hw_queue(&adev->mes, &queue_input);
> > +     amdgpu_mes_unlock(&adev->mes);
> > +     if (r)
> > +             return r;
> > +     return mes_userq_unmap(queue);
> > +}
> > +
> >  static int mes_userq_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
> >                                     struct amdgpu_usermode_queue *queue=
,
> >                                     struct drm_amdgpu_userq_in *mqd_use=
r) @@ -
> > 528,4 +548,5 @@ const struct amdgpu_userq_funcs userq_mes_funcs =3D {
> >       .detect_and_reset =3D mes_userq_detect_and_reset,
> >       .preempt =3D mes_userq_preempt,
> >       .restore =3D mes_userq_restore,
> > +     .reset =3D mes_userq_reset,
> >  };
> > --
> > 2.54.0
>
