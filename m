Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC631C83F1B
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jul 2025 15:20:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 563A010E292;
	Wed, 16 Jul 2025 15:20:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bmhguVll";
	dkim-atps=neutral
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B44A110E292
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Jul 2025 15:20:40 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-313067339e9so5479a91.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Jul 2025 08:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752679240; x=1753284040; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u9kszd3+LO/MVR5LyDA0eWEx819bndfyyriVGecVz3Q=;
 b=bmhguVllEElpc9Yq28sGPB2ilLnl7t5zsVT6Y1l8OqlgUy3SrbKwgeDqClmaHpBpkC
 i5I7N3WlTeKeEmHx5Nv1JJ9zY6+HpPQLuSwCwm1eSbCdeaAOenRWkfqloQVqHxiZY1wo
 XmfIgKzW62/v+4DNpYUWfxmnQjdLpqKbQWQ2Xwg+AOx2E5uzoS44iGB9MOJOR92AR5QN
 A+BwgH6b0NcJT1Pcm3SyqVouYoYhRlfxluARxPi/ENA/O9tQL3PNSLiox/+OQ4ioDpM9
 QAntjgByEVudOCEjFlKLa+el0Prp96N2dopKz2oMG+c7dk+w4nZ2eWYIHhQ4Ho54uopi
 L6pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752679240; x=1753284040;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u9kszd3+LO/MVR5LyDA0eWEx819bndfyyriVGecVz3Q=;
 b=UTBvE+zfxnYQ29q5GHJJT63V2mQgNwc21vrQQXiaib15cODNzZpePkJCvYJLYUe5DS
 B+YhuMypCHOUAmdCEK+UB4/ogQTls8UeXmm0X9UrI1SQvGkUqEvpRE4K7zEPtJZqjpKF
 y3+W0Eg2Q+l34ZVSK2s+nat14gYK6hCInrkt08otHum+pqWEOKk5ixQ/7/+3R8gb/DGr
 OjQFXgL4RB3U5oP9IOdygG1W3+oON+9mYOvlKqYzasoaggRb8N7Hdu0dS29iZEnSNxbt
 0KJXDIjcE3/ls6ZWgG7xqIeavdjkY6hs2WjN4oNAa+7VRK3oTEVWkgsLN2SMRIiY3K45
 Cstg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGwqpsFrHetS2fR4YqEC6ykUkv/b+tPOlNt2zs9h7qycwbtKkiAJfDCRZRy0MjETWykhmZikDO@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz262Sz3VZVvnE9muCrH0xh118F+73+68ZnX3nlzRFMwYSmDceK
 Fo2bZKeI85W7RkICnuuTw/RdFg9I8XvBAhn8Q5f4gCsRLYGdRTbxB4SV+Smma/AznA16MmFbiWo
 3r4tOfxYnd1G23xD10wcRkfUdMvyOpw0t4w==
X-Gm-Gg: ASbGncvUm7bcxa9yu/RLPYDc/9LBWvVYKqxOKrrm9qfVArLaYsGpnk5s8h2O2Ufmi2E
 kpVDP1pDymkSA+//c0mayupLto+jiKXyFkolUl83LYuXGVx2C++cyI5Gd2qpvja+qhfwuI31s8i
 yfAgoBmE5JswxAD+PfzV4fZZ7mikUV4VpTp41l4MI2UKs5KE07VOk62ozYyFPxUzgQdE+gFUHDK
 bdnaT/f
X-Google-Smtp-Source: AGHT+IGXxLLwxyyXP+cOQ9IhKiqgH2iqSEEg26jvBRwWMkKyQEdkyTQ3KmK6biB1ZvIyDY7viKm9OhN2MKsaROVEquM=
X-Received: by 2002:a17:90b:5307:b0:311:b0d3:851 with SMTP id
 98e67ed59e1d1-31c9e75ef14mr2296578a91.4.1752679239978; Wed, 16 Jul 2025
 08:20:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250711215122.23288-1-alexander.deucher@amd.com>
 <20250711215122.23288-2-alexander.deucher@amd.com>
 <6860a000-3ef1-42b2-89ee-ff176ef9ed23@amd.com>
In-Reply-To: <6860a000-3ef1-42b2-89ee-ff176ef9ed23@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 16 Jul 2025 11:20:28 -0400
X-Gm-Features: Ac12FXxOvM-XxrtFbAehxCiqxnW6Clm_ImxlvDrihdtBCzBDr6gPEoVBVvhw7Fc
Message-ID: <CADnq5_Mee2r86FyfeF0v1qtpkwQ208WB9HXbCH4qt6PZLXDA2g@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/amdgpu/gfx11: set MQD as appriopriate for queue
 priv
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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

On Wed, Jul 16, 2025 at 12:33=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.com> w=
rote:
>
>
>
> On 7/12/2025 3:21 AM, Alex Deucher wrote:
> > Set the MQD as appropriate for the queue priv state.
> >
> > Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/a=
md/amdgpu/gfx_v11_0.c
> > index 37dcec2d07841..b9ba8b22a1073 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> > @@ -4124,6 +4124,8 @@ static int gfx_v11_0_gfx_mqd_init(struct amdgpu_d=
evice *adev, void *m,
> >  #endif
> >       if (prop->tmz_queue)
> >               tmp =3D REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, TMZ_MATCH, 1)=
;
> > +     if (!prop->priv_queue)
> > +             tmp =3D REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, RB_NON_PRIV, =
1);
> >       mqd->cp_gfx_hqd_cntl =3D tmp;
> >
> >       /* set up cp_doorbell_control */
> > @@ -4276,8 +4278,10 @@ static int gfx_v11_0_compute_mqd_init(struct amd=
gpu_device *adev, void *m,
> >       tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, UNORD_DISPATCH, 1);
> >       tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNNEL_DISPATCH,
> >                           prop->allow_tunneling);
> > -     tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, PRIV_STATE, 1);
> > -     tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, KMD_QUEUE, 1);
> > +     if (prop->priv_queue) {
> > +             tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, PRIV_STATE,=
 1);
> > +             tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, KMD_QUEUE, =
1);
> > +     }
>
> As per above logic, only kernel mode queues are supposed to be
> privileged. If so, would suggest renaming the flag to kernel_q

I'll respin with the rename.

Alex

>
> Thanks,
> Lijo
>
> >       if (prop->tmz_queue)
> >               tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TMZ, 1);
> >       mqd->cp_hqd_pq_control =3D tmp;
>
