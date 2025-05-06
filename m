Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EA85C3ABBE
	for <amd-gfx@archiver.kernel.org>; Tue,  6 May 2025 19:17:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E45110E271;
	Tue,  6 May 2025 19:17:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fJtrZGVP";
	dkim-atps=neutral
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 824EE10E098
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 May 2025 19:17:05 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2240ff0bd6eso12001905ad.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 06 May 2025 12:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746559025; x=1747163825; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mdwTsE/XVR3oCCOpFVjTDnwZWQidPWh//GRPiQiHhZ8=;
 b=fJtrZGVPrf6e4nbFC3ttGfQNa6zYF4ESvL+DtLCyefzrxZb1HeXujI/lxyMTgBwm+U
 KU7QZ2H4PaFqVBO7nTg1q1ICeUW5m1nZ1h8BDB0BVs8AtScOu9QJ9kCQEO9/vEulWx4Z
 tnLoL+2PMhW1FsdtDRTLCx5y7E0FfjDtTIW5U34Jsgue68T1E/OFAtOca3w68EIU5GJx
 V1dKuYw5isUNUV+70AIxJp5NNaBaXbTqdyvrAWLv995Wjrfoe4wZBhu2QEpmEblXPsqh
 Gzh6z30uHbv2qG1+9Ddz8ur7ub8NXiRO3kGYsh60Z68ZZOnuU9x9qrRyxafkzQn0Cp1y
 oSxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746559025; x=1747163825;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mdwTsE/XVR3oCCOpFVjTDnwZWQidPWh//GRPiQiHhZ8=;
 b=lBfNTlqwwr+MJGgfNddNSzf6xUDQ9yWpQB5ji2RhDYdrgcwqGn01dYanL1P78wCVOp
 BXluk9GVb0m2DHDdckoW3f+5FOygij2rnE+5P06HORMP0i7INGz+UJEdSVAfvwAfqX97
 mx2NCaJ4x/D8tUxiIT12/FHfFNHEMZ8syoQne9ZLLum5zXdtjA8Hc1tshj33THd0ivlH
 oNhT0YVjlrQtgyeQJ7yZyziyWRQEmEqxR9Vu6j8xcGZulVmBCH0fyn2chWcRZKzIXInv
 EcdnGA4I+gAY4rhDKCkrkZzhFFrnPtX7lwsHnD0bR+uFHfYWaZdMkv2qnDlr0fbI3ezK
 avTw==
X-Gm-Message-State: AOJu0Yw3MQ+F09OUVhCYHNNK2cNrtG/MHGpfW2DWMfzLs5IBFEzQ2OQL
 Ei255AydU24zVRDTh/fcww0Jxt2Bmo7X7cgmUvdtVT9Ro98oqSABw5lzuW4wkPL5VhCJkSemGeC
 SQ+C9TffJgEcRYzV6QmVQzZt3lKE=
X-Gm-Gg: ASbGncv6cmXCb5eYKmFQQ03lb4FTcyEc/7jMjsMmAzLP+VUbp7hd8z6BSNStRWEY4J8
 qM0R0gr9lItCB68abiY2+1cH/SAIKVMwG7BY7bTFFwuub2CSzjWbf/ekJ7W4nD4pzvZnIogDYsQ
 UDziaQM/cuRSVyJrak8IldlA==
X-Google-Smtp-Source: AGHT+IHko27oB8/jGpHFT2MvclIk+QFOGETmaocOFYKFkowB56A/na2hhXOO4zPhev2J0UpszV/lHptAbHQ3TBODEeU=
X-Received: by 2002:a17:902:e783:b0:212:48f0:5b6f with SMTP id
 d9443c01a7336-22e5ea9c75cmr1951385ad.9.1746559024930; Tue, 06 May 2025
 12:17:04 -0700 (PDT)
MIME-Version: 1.0
References: <20250506175419.3518-1-mario.limonciello@amd.com>
 <20250506175419.3518-2-mario.limonciello@amd.com>
 <CADnq5_MyumjKzir20fOxYvEci84oGWszyVH2rmaf6D6f8amdPA@mail.gmail.com>
In-Reply-To: <CADnq5_MyumjKzir20fOxYvEci84oGWszyVH2rmaf6D6f8amdPA@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 6 May 2025 15:16:53 -0400
X-Gm-Features: ATxdqUF3RaANUG81HI6HEE0UXEyFwDQrPXTFdT_iWgsCV8Uz1FscFtbRP-9Z6Ls
Message-ID: <CADnq5_N2Uc4XFkt4w86KKBRar9M7Y67hso1Srzx1RQFYeKqzbg@mail.gmail.com>
Subject: Re: [PATCH 1/1] drm/amd: Add per-ring reset for vcn v4.0.5 use
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: "amd-gfx @ lists . freedesktop . org" <amd-gfx@lists.freedesktop.org>,
 David.Wu3@amd.com
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

On Tue, May 6, 2025 at 3:12=E2=80=AFPM Alex Deucher <alexdeucher@gmail.com>=
 wrote:
>
> On Tue, May 6, 2025 at 2:19=E2=80=AFPM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
> >
> > There is a problem occurring on VCN 4.0.5 where in some situations a jo=
b
> > is timing out.  This triggers a job timeout which then causes a GPU
> > reset for recovery.  That has exposed a number of issues with GPU reset
> > that have since been fixed. But also a GPU reset isn't actually needed
> > for this circumstance. Just restarting the ring is enough.
> >
> > Add a reset callback for the ring which will stop and start VCN if the
> > issue happens.
> >
> > Link: https://gitlab.freedesktop.org/mesa/mesa/-/issues/12528
> > Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3909
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/=
amd/amdgpu/vcn_v4_0_5.c
> > index 558469744f3a..3e6e8127143b 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> > @@ -1440,6 +1440,24 @@ static void vcn_v4_0_5_unified_ring_set_wptr(str=
uct amdgpu_ring *ring)
> >         }
> >  }
> >
> > +static int vcn_v4_0_5_ring_reset(struct amdgpu_ring *ring, unsigned in=
t vmid)
> > +{
> > +       struct amdgpu_device *adev =3D ring->adev;
> > +       int i;
> > +
> > +       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> > +               struct amdgpu_vcn_inst *vinst =3D &adev->vcn.inst[i];
> > +
> > +               if (ring !=3D &vinst->ring_enc[0])
> > +                       continue;
>
> You can drop the loop and just look up the instance directly:
> struct amdgpu_vcn_inst *vinst =3D &adev->vcn.inst[ring->me];
>
> Also check if per queue reset is supported:
> if (!(adev->vcn.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
>         return -EOPNOTSUPP;
>
> You'll also need something like:
> adev->vcn.supported_reset =3D
> amdgpu_get_soft_full_reset_mask(&adev->vcn.inst[0].ring_enc[0]);
> adev->vcn.supported_reset |=3D AMDGPU_RESET_TYPE_PER_QUEUE;
> in vcn_v4_0_5_sw_init().
>
> Also, since each VCN instance is only single threaded, you could
> theoretically save the other jobs in the ring and fix up the ring
> pointers after resetting to continue after the bad job.  That could be
> left as a future improvement however.

While you are at it, you could implement support in vcn_v4_0.c and
vcn_v5_0_0.c as well.  Older VCNs will be a bit more complex as they
support multiple queues per engine, so if you reset the engine, you
need to properly clean up all the queues.

Alex

>
> Alex
>
> > +               vcn_v4_0_5_stop(vinst);
> > +               vcn_v4_0_5_start(vinst);
> > +               break;
> > +       }
> > +
> > +       return amdgpu_ring_test_helper(ring);
> > +}
> > +
> >  static struct amdgpu_ring_funcs vcn_v4_0_5_unified_ring_vm_funcs =3D {
> >         .type =3D AMDGPU_RING_TYPE_VCN_ENC,
> >         .align_mask =3D 0x3f,
> > @@ -1467,6 +1485,7 @@ static struct amdgpu_ring_funcs vcn_v4_0_5_unifie=
d_ring_vm_funcs =3D {
> >         .emit_wreg =3D vcn_v2_0_enc_ring_emit_wreg,
> >         .emit_reg_wait =3D vcn_v2_0_enc_ring_emit_reg_wait,
> >         .emit_reg_write_reg_wait =3D amdgpu_ring_emit_reg_write_reg_wai=
t_helper,
> > +       .reset =3D vcn_v4_0_5_ring_reset,
> >  };
> >
> >  /**
> > --
> > 2.49.0
> >
