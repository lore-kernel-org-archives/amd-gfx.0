Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDD22C83F1B
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jul 2025 15:19:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CDAC10E286;
	Wed, 16 Jul 2025 15:19:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jNITX11F";
	dkim-atps=neutral
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD37410E286
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Jul 2025 15:19:50 +0000 (UTC)
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-b34b770868dso726045a12.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Jul 2025 08:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752679190; x=1753283990; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6Tqa0KCdI1gqe6SBCgdHgxFcmW0FHkHvcRnTGXkj9sY=;
 b=jNITX11FpgtJqLsWKM5nAQo26YEyBLmX2UU9fVtbCqv/R+r9pczMWOxtkULYbH1lne
 eDT+EHeQr7mQoGwNpel80G649PeCgwTSeJva2Vk9uVZUTHsFAfuqyzqKq5JP3UDW3hLe
 wTdygBHsnVpwzBY/VHl+7C2QeYGHWTktwfNPnUR13Atm0ZEJfYOrX8WCEp3ybJ6YvAxe
 gFil45hnBpoKv88LDeMtN1y7ICCkKq8f95LmnIXLd6nfqn+MUGuWHHlGTg9hXaGHSf7H
 R2Ohd2lQ/ZU0zLKfM0SCjZi2xh8nG6dGrfJUZ7VvMAW4tUGtGmHqL+5ySYEoXHDhDFf9
 5NSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752679190; x=1753283990;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6Tqa0KCdI1gqe6SBCgdHgxFcmW0FHkHvcRnTGXkj9sY=;
 b=ZMgk1wIlcCj3NA+zLMTrgpAP+1gccAuqKPzYVlfOJ1aC6Sq7IbRG6GTeTIEqEa2n05
 gGgrosueSMLcS5CPOWUgwU5soH+8+GvDsBvKlT95+79q3qItIeXbLW8Zx9lCFdae88/Y
 +YO5t1m8X4WsoYqvHoIjzrOJax6bA55PniH0HQaZz3MJtdSEGBK9tXJMabIzlY6myaMC
 wT0QcT6U7gDI7RjyuikpH2iXMPYqmkKufT7jFXbshcD+WjZhT33QzF6xHFaedjQvhRTU
 d58YqIqROEqFJG/dEKQI4O1l3FUuIbJKxuU0ZLqqyUk8HaZPMPRoiGEDdXQRgXldyqFl
 6hiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZ+0EB3lNjL0DdO3i/7moTN2OTj9vvgklRdXpmWs9mWHf6rGtjF+SyXW4jOxYNIerzB5OhtX5G@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyG8p401+GUJupa1mrXxprdoOJtRrvvs+EohWMjsvl7mE0oV0W2
 NxyJvm/NYKFz4BWluMYLxXlLa8Bs4GN1zoxtgAXzBsdYPsnKEXdWgxl+EdZ2F/CRh8uGj6zOGkk
 zNcNkqXIvy17GfF6A5UJ31canU/qP7j2f1Q==
X-Gm-Gg: ASbGnctPhW5uTeOMfGjDFc1DE52M2tv5RL4Va1/wIqdTlMJw2MH00GUrVZd+dhUdVDk
 goljB28aFY8PjVkI0a7k4AqM87HE5krTrkJBI1TF2rTuiX5RssmvJKjRnxvxJKpMSygMY4YsRLt
 +FZXZOrsNMEpIkCt5H1jlMvahD6lt7VGpUCeIsvi5dQJHIqrtggjgVf3V9HVoOnxIy4LU7FHocU
 Odbf3Sh
X-Google-Smtp-Source: AGHT+IGjvvELNG2G4j6rkkuSZUrURONdY2LkAXj+YWnOP7YeHXE56KLU9YZtT14HnymaZHIWuOTdku7qhPvlOQ3NxLc=
X-Received: by 2002:a17:90b:520a:b0:312:25dd:1c8b with SMTP id
 98e67ed59e1d1-31c9e6ec82dmr2007949a91.2.1752679190252; Wed, 16 Jul 2025
 08:19:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250711215122.23288-1-alexander.deucher@amd.com>
 <20250711215122.23288-2-alexander.deucher@amd.com>
 <6860a000-3ef1-42b2-89ee-ff176ef9ed23@amd.com>
 <DS7PR12MB60058FF28CFE6FB8326A24E3FB56A@DS7PR12MB6005.namprd12.prod.outlook.com>
In-Reply-To: <DS7PR12MB60058FF28CFE6FB8326A24E3FB56A@DS7PR12MB6005.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 16 Jul 2025 11:19:38 -0400
X-Gm-Features: Ac12FXyjmkof1PsAJlfWn1PZkqWEoRV1TYgKWWePcJAVLG4zJAyKcB5wo1sW82c
Message-ID: <CADnq5_P+PmesAQFRn+83cFjN5hADjH+LxSN0cmzQvQn6KUaXEA@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/amdgpu/gfx11: set MQD as appriopriate for queue
 priv
To: "Liang, Prike" <Prike.Liang@amd.com>
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "Koenig, Christian" <Christian.Koenig@amd.com>
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

On Wed, Jul 16, 2025 at 5:58=E2=80=AFAM Liang, Prike <Prike.Liang@amd.com> =
wrote:
>
> [Public]
>
> Regards,
>       Prike
>
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Laza=
r, Lijo
> > Sent: Wednesday, July 16, 2025 12:18 PM
> > To: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-
> > gfx@lists.freedesktop.org
> > Cc: Koenig, Christian <Christian.Koenig@amd.com>
> > Subject: Re: [PATCH 2/3] drm/amdgpu/gfx11: set MQD as appriopriate for =
queue priv
> >
> >
> >
> > On 7/12/2025 3:21 AM, Alex Deucher wrote:
> > > Set the MQD as appropriate for the queue priv state.
> > >
> > > Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 8 ++++++--
> > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> > > b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> > > index 37dcec2d07841..b9ba8b22a1073 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> > > @@ -4124,6 +4124,8 @@ static int gfx_v11_0_gfx_mqd_init(struct
> > > amdgpu_device *adev, void *m,  #endif
> > >     if (prop->tmz_queue)
> > >             tmp =3D REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, TMZ_MATCH,
> > 1);
> > > +   if (!prop->priv_queue)
> > > +           tmp =3D REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL,
> > RB_NON_PRIV, 1);
> > >     mqd->cp_gfx_hqd_cntl =3D tmp;
> > >
> > >     /* set up cp_doorbell_control */
> > > @@ -4276,8 +4278,10 @@ static int gfx_v11_0_compute_mqd_init(struct
> > amdgpu_device *adev, void *m,
> > >     tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL,
> > UNORD_DISPATCH, 1);
> > >     tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL,
> > TUNNEL_DISPATCH,
> > >                         prop->allow_tunneling);
> > > -   tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, PRIV_STATE, 1);
> > > -   tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, KMD_QUEUE, 1);
> > > +   if (prop->priv_queue) {
> > > +           tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL,
> > PRIV_STATE, 1);
> > > +           tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL,
> > KMD_QUEUE, 1);
> > > +   }
> >
> > As per above logic, only kernel mode queues are supposed to be privileg=
ed. If so,
> > would suggest renaming the flag to kernel_q
> According to the CP guys, the privileged bit can be applied both the user=
 queue and kernel queue. So, we may don't bound the privileged queue to the=
 kernel queue.
> Meanwhile, the KMD_QUEUE bit may only set for the kernel queue only enabl=
ed case.

I think we want PRIV_STATE for only kernel queues.  Why would you want
it for user queues?

Alex

>
> > Thanks,
> > Lijo
> >
> > >     if (prop->tmz_queue)
> > >             tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TMZ, 1);
> > >     mqd->cp_hqd_pq_control =3D tmp;
>
