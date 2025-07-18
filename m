Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B839C83F17
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Jul 2025 13:44:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5BEA10E9AE;
	Fri, 18 Jul 2025 13:44:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Cb2jV9oN";
	dkim-atps=neutral
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com
 [209.85.215.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDFA110E175
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Jul 2025 13:44:39 +0000 (UTC)
Received: by mail-pg1-f169.google.com with SMTP id
 41be03b00d2f7-b31d4886c50so364050a12.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Jul 2025 06:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752846279; x=1753451079; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VKM0PLZvW+p3qs/xAuNLbafRekPc9G0Bi9AmGDt338E=;
 b=Cb2jV9oN/7Zo3Q67VRGUK7Rb8bq9S5uGnbL56TE2LLwuHXcm76x8cObUNRn0KBQFM6
 axenvg9hARlHmC6jlfKGibU4oQNOb4+b9IkSG+LK/UU+gp/EhiNdgBhFlqQSD7ePAFH3
 sBTim0DTm+bjzNo1yIm93qeyco9ooNzSbJdP+5OmtNLdh6fumxiWp1KzcmKwmV+CQPqs
 ct4qtjX449v4ZGz9YLdBAXgRrr0WiN7ieLrhveE6NVBS9WuVIi4njdt8uf08RWlusZx0
 GmFHB+aHv7DLMM7PsYPBqFQgiyTnWWiHkfhIVHim/r5p48HzNf2bzRgGQY87K/Cog5B/
 KhQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752846279; x=1753451079;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VKM0PLZvW+p3qs/xAuNLbafRekPc9G0Bi9AmGDt338E=;
 b=aOC+Zt8YQzGcoBzS4T7XmRymZTHRuqCKK1p6EtgFZNR1Y1tgTAuSsq29D2SyEnABWe
 PsPSRLwT32UJkRYQ38sLmLbdD4h4FV8N/2I/khUWDPcUjEu48fxR7d2yUzkvsDBZ9rZ/
 GVjOhNrbL6Rg4uL7esKZPgzv5aOgcE26qufvifCOYnyyVbEnMsrQ2ESId2rJCTfR40YS
 0KhyudVk47RaUUsSlefEtneeLkf6JTnLWkEbO2G695r5PmHLQtC6ZGf6+JpdjitLQMxq
 e5u9qPs4ACs3TV0C3Ux8ecu6NRvPFI/8wcANYmCtKNW6cFtJm2NrG++7axltbP2zzZqt
 WcaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDrMEzNfADOCA+tjMVGjVXojYAdNsYFldHMoMmo4lqr1C/4K3LTNH2HLmflmiMqkF9BeCTAcbk@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyK1r3Z1jkoUsMa9GOj+BrVc0/uJ8Gq61r9zC+S+v+ZKDQpNMfF
 rksfQuVBMBAROkviJJdmWbLXFK7dbKn7arUeUWl19Q6r++jyG/7OKVFpvKafYu936cVfGx7MhPn
 2LyHnbrUTzK2ATGkcmNPMfcWTDENyXe3bHw==
X-Gm-Gg: ASbGncuWisHnKGWrtTVMSpJv3CbzvB9Bsye/1MPGsD0lSmmmkOlTW4JtcxX6E9r1/Fb
 rQoeW4J8FsVD3Ph1toQGNeolJjkIAhhq21OUzW8bfSlRBuCve0nWppfPkMWnBQLuEZTiD0XFgd4
 G4a1AOgXHk81K+aCYAZ6T6LeWCgJ64xn4qXU8F8/Qk3IDX9PBDRqYUFAVkUxlfUPSvm9ofan9eF
 MJV9bLo
X-Google-Smtp-Source: AGHT+IFOrMv+W/FBMsoo3nJqo+WcnqyIHtObRy0LjBFQC9C225BzeEQrmLngfKkXVF9kwMMT0/P+rWP6TbZeZKYAcuw=
X-Received: by 2002:a05:6a21:339a:b0:1f0:d178:7d0e with SMTP id
 adf61e73a8af0-237d55022dbmr7852467637.1.1752846279094; Fri, 18 Jul 2025
 06:44:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250716220115.3872837-1-alexander.deucher@amd.com>
 <20250716220115.3872837-3-alexander.deucher@amd.com>
 <c78b9083-cdf2-43fb-ae29-dab1544b03de@amd.com>
 <DS7PR12MB600532AE46C2420CFB949E60FB50A@DS7PR12MB6005.namprd12.prod.outlook.com>
In-Reply-To: <DS7PR12MB600532AE46C2420CFB949E60FB50A@DS7PR12MB6005.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 18 Jul 2025 09:44:27 -0400
X-Gm-Features: Ac12FXwDFtf12_n8bzyoTudCYuoItcUYSMmoUwlfIJpnMZ-RXJ9oUawch4yWDJI
Message-ID: <CADnq5_MiStFmWqWe1y1F8HTOz3_9pG2bCdWY+VZDKD-=XXoVFA@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amdgpu/gfx12: set MQD as appriopriate for queue
 types
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

On Fri, Jul 18, 2025 at 6:28=E2=80=AFAM Liang, Prike <Prike.Liang@amd.com> =
wrote:
>
> [Public]
>
> What if when the kernel queue and user queue are enabled at the same time=
,
> then how to handle the case when userq mapped to a queue that has been
> enabled privileged bit by kernel queue?

These settings are per queue.  kernel queues will be privileged and
user queues will not be privileged.  The MES will program the values
from the MQD into the HQD when it maps the queues.

Alex

>
> Regards,
>       Prike
>
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Laza=
r, Lijo
> > Sent: Friday, July 18, 2025 12:13 PM
> > To: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-
> > gfx@lists.freedesktop.org
> > Cc: Koenig, Christian <Christian.Koenig@amd.com>
> > Subject: Re: [PATCH 3/3] drm/amdgpu/gfx12: set MQD as appriopriate for =
queue
> > types
> >
> >
> >
> > On 7/17/2025 3:31 AM, Alex Deucher wrote:
> > > Set the MQD as appropriate for the kernel vs user queues.
> > >
> > > Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >
> > A couple of nit-picks for patch 1.
> >
> > Series is -
> >
> >       Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
> >
> > Thanks,
> > Lijo
> >
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 8 ++++++--
> > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> > > b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> > > index 7220ed2fa2a33..73a04d07bb494 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> > > @@ -3020,6 +3020,8 @@ static int gfx_v12_0_gfx_mqd_init(struct
> > > amdgpu_device *adev, void *m,  #endif
> > >     if (prop->tmz_queue)
> > >             tmp =3D REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, TMZ_MATCH,
> > 1);
> > > +   if (!prop->kernel_queue)
> > > +           tmp =3D REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL,
> > RB_NON_PRIV, 1);
> > >     mqd->cp_gfx_hqd_cntl =3D tmp;
> > >
> > >     /* set up cp_doorbell_control */
> > > @@ -3169,8 +3171,10 @@ static int gfx_v12_0_compute_mqd_init(struct
> > amdgpu_device *adev, void *m,
> > >                         (order_base_2(AMDGPU_GPU_PAGE_SIZE / 4) - 1))=
;
> > >     tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL,
> > UNORD_DISPATCH, 1);
> > >     tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL,
> > TUNNEL_DISPATCH, 0);
> > > -   tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, PRIV_STATE, 1);
> > > -   tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, KMD_QUEUE, 1);
> > > +   if (prop->kernel_queue) {
> > > +           tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL,
> > PRIV_STATE, 1);
> > > +           tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL,
> > KMD_QUEUE, 1);
> > > +   }
> > >     if (prop->tmz_queue)
> > >             tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TMZ, 1);
> > >     mqd->cp_hqd_pq_control =3D tmp;
>
