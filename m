Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C564F8DFF9
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2026 17:55:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B38010E2CE;
	Fri, 17 Apr 2026 17:55:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fvFcMGmg";
	dkim-atps=neutral
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CB7010E2CE
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2026 17:55:04 +0000 (UTC)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-2bd5658b901so69299eec.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2026 10:55:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776448503; cv=none;
 d=google.com; s=arc-20240605;
 b=XAINnLU4DTfaLC0weznUExH/6cktx4+xYNq8rnQhcDiag1U6SGHOxvDRWcHQfUmvQB
 a0E2Q0MgW2ukDIPn1woED4xaHrpG3KxApU59nLR1cITSf6aCALb6LJFuBrbPP+r4MZt4
 S/9F1eoeOZDqp71WPuQnQ6jkEylUbLoQEwsy/NOOyYpheqy8uft60APALIbMAbC9M2hY
 dxNOlGDKIceJGHbE3f/QLAzOArs7HYypBWqFjrJ0sCVDeGvsAmywSI5hUiwCEQKWeY9f
 W9vfil2GNhZigjt1h2ozSGPOln/zpUTmDfkbnx93ovu5ypFeJbkvnZcTz6sB+GRV4SYj
 zcFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=OAzTZ2F5t9v6aFIS4upkXrnAzCFynSK2YaiHo2R3Kiw=;
 fh=IY98SR0cNO93Tj0qH750yd04bAXFkNbDKtBTzSqo1Bw=;
 b=QaUsVPoz06BwQuXpb2V/kEIJZgt40UUA+GXMYTyvybNNpbpxiyaf/ztpT7YAK+qDkr
 v0+ylvsMCJXp7oQZZ77X2tnj6WQ0WHLU/3UCHP+Lsm50MTFbeBSWiFgS1OQlhKIW7Dfc
 ltBsQ12qsNGiEhG5Ow5o9VmdigJrP4Zc+lAb5nn47ZemiSutzFaWSTc7am3/OPmQ3Q28
 9e/t+wWd+j96hr+wIiaRTIWoAuzPAvctUdpdM6ZSbG6yEVBla6+nDPbkRHNb2+RVVsGB
 611JL9+rNZzztkrwp3+pZymgJZCRTP5TuZ0OwJcmQ5VjAnImm8EVzFCCEy9TbnVt5jJr
 Z7Dw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776448503; x=1777053303; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OAzTZ2F5t9v6aFIS4upkXrnAzCFynSK2YaiHo2R3Kiw=;
 b=fvFcMGmgIhK7fkChVn7Mf6+PR2OarfNaXdOJd5o+1s4I9s6n1mtUJfwikJLr3vK5jI
 lntGPXKLgthoMqqLyItDqQK3gXN9ZoyWI0L+oL1hmjJWo+X7ZV4KkyVjij4m3ColUILy
 g4fHm+SebPiRgSvgaLJXXZNBUJ8GXmtWjKsB43VbHoZ3VTF45hWuJd2JG2v75dwocr8x
 BIoCxxxOEbKqAleM7kZDKnBH2A8ihnV+bRStKdCE6gO+J5q7bMllk5n8sVLFPFUbMdVz
 ACWBUCySEeRxUXIsN8J3zoZ7zF0RgOzaOHhuUKIgrJJxmyH+pjMtVvkgrDUa4kU+1DZV
 Lwtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776448503; x=1777053303;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OAzTZ2F5t9v6aFIS4upkXrnAzCFynSK2YaiHo2R3Kiw=;
 b=TVTWgdVo2dLwC5xnI9imHArzODdXi8JGOW/SSAs9ArP0dTdxKptmrpP3EjdUBn+Imp
 2fuPNFK4Y43h8uSDkol3t3fMUkFOFNJWIQLtyBc7YyXfDXX4bUWgjXmvF16iqLAzApnh
 wpFaqc9xlqJmPOZbP/jibUp6oMxmoHveNBRBdGGc9qPWtEfTSWwCChMFUbLy8EqPmHCO
 mZdW/iTugyxoyzumnvIXCO72Z3kVkHEY3kW+WOdhH2PCN+bWWiPDryiuQrumffjgY77f
 DSHwO8+5uoVD9UdmvuUA28chV8ITS6YGYPJTgH218oNbyxW/Pdz9gzuYQPVUZaxnqkFv
 F4tQ==
X-Gm-Message-State: AOJu0YykXvQBlP+vhS1uUyiJMqJdE1y7mWkbA91FsK49XyzeTU1wSZ1k
 89jCnjqEwbnuMU9Uu43Hh5CiLGuLzzN/Ts0VcoG0EOYpz8eqF3dxHKa4IXbiklCEbbyogGTor6H
 ry2gCjveUTY+u5rO7WJdxV4/Uz/SRKm55sQ==
X-Gm-Gg: AeBDiesqtvq/H1zqvOHrzrNvyRsz6N9BdGYpUsHYjgX1Wz5pLLGf459ibpTDeMmv2Ij
 gp8grGJoaMNJFAHb+2uB+VBAezhW5BXQnxMjQUY7oAHe24oiBbca2jPcYfEILOTc4uPmJF9f/TQ
 D/kZRf/aJ57SZlkEYu4BP1gxYG+61E13iMTKNM+YRkZUdl4RGbY2m89LlS2TO0B01ONJnQdLvf9
 8oek0ktyP4NEvZvHj0GiJZPZdF3CXCfFHk0YNMynGvU5wnJlyEIOuP5GFr/93wEaPbwggQpYla/
 jVIvGwAzHyBrHD6DJWYVFXKjwy1y7xCNakFsEkCeduaISOzvvxnxGP0zxBOKfM1/v3r7aTCMPMM
 VqM6h
X-Received: by 2002:a05:7022:459e:b0:127:332d:63e with SMTP id
 a92af1059eb24-12c73f9b5d7mr774561c88.5.1776448503417; Fri, 17 Apr 2026
 10:55:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260318140837.582776-1-alexander.deucher@amd.com>
 <20260318140837.582776-4-alexander.deucher@amd.com>
 <CADnq5_Md5RSUKZyAq8edL4hbwc1r2uPA7jiC6zn+MKi9KzDY6w@mail.gmail.com>
In-Reply-To: <CADnq5_Md5RSUKZyAq8edL4hbwc1r2uPA7jiC6zn+MKi9KzDY6w@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 17 Apr 2026 13:54:51 -0400
X-Gm-Features: AQROBzAIDz0N7-zlG00d6ay7rlJqaIqOyCjy5zAZypUNIUb6ALBKSuIJLV-qKN0
Message-ID: <CADnq5_OV391Vj80-2xehYzqK0SLkf3f5dwsK0ybDYcxryBQ03w@mail.gmail.com>
Subject: Re: [PATCH 04/16] drm/amdgpu/gfx9.4.3: align mqd settings with KFD
To: Alex Deucher <alexander.deucher@amd.com>
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

Ping?

On Fri, Apr 3, 2026 at 10:03=E2=80=AFAM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> ping?
>
> On Wed, Mar 18, 2026 at 10:34=E2=80=AFAM Alex Deucher <alexander.deucher@=
amd.com> wrote:
> >
> > Make sure to set the quantum bits in the compute MQD
> > for better fairness across queues of the same priority.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/=
amd/amdgpu/gfx_v9_4_3.c
> > index ad4d442e7345e..d0b8fb9317201 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> > @@ -1943,7 +1943,11 @@ static int gfx_v9_4_3_xcc_mqd_init(struct amdgpu=
_ring *ring, int xcc_id)
> >
> >         /* set static priority for a queue/ring */
> >         gfx_v9_4_3_mqd_set_priority(ring, mqd);
> > -       mqd->cp_hqd_quantum =3D RREG32_SOC15(GC, GET_INST(GC, xcc_id), =
regCP_HQD_QUANTUM);
> > +       tmp =3D RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_QUANTU=
M);
> > +       tmp =3D REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_EN, 1);
> > +       tmp =3D REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_SCALE, 1);
> > +       tmp =3D REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_DURATION, 1)=
;
> > +       mqd->cp_hqd_quantum =3D tmp;
> >
> >         /* map_queues packet doesn't need activate the queue,
> >          * so only kiq need set this field.
> > --
> > 2.53.0
> >
