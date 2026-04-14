Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91D9CF9D0CA
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2026 13:40:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29A6F10E608;
	Tue, 14 Apr 2026 13:40:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fdQxNsJN";
	dkim-atps=neutral
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D4F910E608
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2026 13:40:56 +0000 (UTC)
Received: by mail-dl1-f42.google.com with SMTP id
 a92af1059eb24-12c373ee97fso431348c88.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2026 06:40:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776174055; cv=none;
 d=google.com; s=arc-20240605;
 b=SZ6hvr57U4rzY6INaS+2vWP6kYbo3naZqUtoQPVtwXcg3tDZ2hU6odqMaKsA0UJLi7
 NCO2TMMnu1q+SheVFbOLYQ5x6fefBTEZpgukTdxv9vV9oSJOwn7hOECt5AIsf1k5KHpv
 Bzrmx8C4DNlDdR+Q2HAQjFGtuQAZfifmS4aYJtb2+MrVgfkrU608A9tAd7s/vm5z6Zsl
 8c+DD64c2CA1ym2aJBOgkVNGClhQ6ZmaUf0GMabQBZlNj9edCCS5UJ9RSC0r2xDL7zQV
 4qMdZw9acGOhaIgquSQial67K6D2Akn14Bo7rwz/Eks/xWWSM9ur5TYzAILfOlF7IL/j
 OIhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=L8b7HARmJOcORhs3aGr6TKpVN09KkOibsg2DUH/4q+U=;
 fh=eguGM10YUUNBibZxFmMZl1B/zoScwB0b00B1UFNujk4=;
 b=iUz1ihCjDVSwggvyHYzKJ/sfwMi0C2DAooa3tMQ42iIuAKpwRKdx8MqgAGBNSoNW8i
 2Pyv/XgFd4/lbVbKHzp9cMyAdUfPCJkbbBONhrf4ncRWi8KJ+h06UUXT7Faj5DOaLzSG
 Oxyg65uaOHCnpzfu6SsFl2SYbChnoswdfIPxhQ3dSQL2saXxnD+l+ckcZJmzxZbGKSMq
 2TN36ZoFLLYR1s+OKkzkv93VIzSQ2aGN76d6TqcOcKL6t5Fp8uSz4akyvUbg13UnTPCA
 w1ZPA4dZtqFhXsJo25wYSQaJzXyxZ4awQ7yNf0lO67J5sGmpPrvPreSNel/sfkGKwO7x
 P5eA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776174055; x=1776778855; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L8b7HARmJOcORhs3aGr6TKpVN09KkOibsg2DUH/4q+U=;
 b=fdQxNsJNuPDdtDMOuRH6WgGIahWoaUJmZaSzRrSRg+O+el5frPcubouARiPBZbz7bJ
 hbo7J7nJPiMhJe9X7IeEs4+6KBjp4BO+oJ8L1FRLGqDfr12pgvQgywEfK/F3wpTNdd/3
 raUQljGUG+5CXhjXZY2v8ueOxk2TEMWZqChvu/QhwIIB3fzjWQTUyu+qjl3dzQ5lJRpz
 B8MNJCDMAIcdaNRjBfWyoJsJmS+92ONuCu9Dy9LONsHeDzR3visbpGDx6K7SmctyT1W4
 XsVxRJTszH2ZJzQL10F0Yy88JtMuRp3sC9MDtqlQ1NWyp6jTtg6aGKQLIGLYDAVdZsPg
 QsjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776174055; x=1776778855;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=L8b7HARmJOcORhs3aGr6TKpVN09KkOibsg2DUH/4q+U=;
 b=GSBzfhEMbbQhXbakdnBQBGXpDKhk3nCRleBd4hMky6qA96SB4LbLm4stfj4ACQeNRD
 xm8oqwR2GgeK73JZN9zdYeweE5uGpPHSyjLd693R52vz6iczH1sl/VEEwHp4nRKz5L37
 uKSFhmvvhTBlrefNd6ffwnv8xBSi6UvSDrTtzQ4X9i+8Ku56A/NW7VjmF2NHXTn1AF/d
 kxLh2nmokn/ALw2M31IM5ZYKj8E85sl1Rz4nkX31jzRzXdUuqTCdMcX4eVqDJ3fP8q/N
 RkirN/jIWh8oLf2eJtTwYHBIig1Ppfhzj7sdz9uuD22dwtPpWlWNR6cB1LgknGkC9UHi
 OqeQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8PXrBLjXB0cLPTDQ8h/FyiKmzQJesMQN+lPXEmL75MKpOcgkBgVdYGMEI72EY6kapLrAbMK0JB@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxpr/Wowimu4jhsbWfclyhAWc6ZA+n6Jx1JJO14pak1KcqGnSBV
 Op1v68GdIlJgDpckxJ/h90np55WgdtBBiMYb4idgQyWivf9xSrOVpN3BEtMSDUQbSYyZBAzpphH
 1QUFhv6WDFS3omsE6KqN9hbrVB8L0Oog=
X-Gm-Gg: AeBDietzSqPVDMIhciqbjS59ZyFvYitosAfkt3Ebi+Dn5HWwQv9+hz3LpjR6CkEN7mW
 0Bq28o4pxwwbZSuJhtAOczwk2SXdxMH/CrrUUPUFjyeuX0FXHkdfrrOWu1Utf+Dhiwo6y3DJdMz
 wptwl1TaivRR9yFQpNvXAHw545KUUFLC2iYa+jLPm7vCaXCI9qCBH8wVtU0eClBknO4xXIN3ujU
 J+PITRFyQ8Mb7FL+bpa0NNaYDUE27lUe+JhUIPcUUWShTVDKqRkPkzN7kZEgAmGEWF28yM47Chp
 xh037ukmpUOBGyXcRmYwJpALHXLONZOkCbzy77BEZK6/4Py8X1qr7jcNVE6bDVQjJRRVlQ==
X-Received: by 2002:a05:7022:6085:b0:12b:ebb8:df87 with SMTP id
 a92af1059eb24-12c34ef51bdmr3482672c88.3.1776174055208; Tue, 14 Apr 2026
 06:40:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260326175140.52753-1-alexander.deucher@amd.com>
 <CADnq5_ONMWOCPR3wdWLEKPz7EeOHDS3ZMeFe9VD_5N5CXQ3Piw@mail.gmail.com>
 <CADnq5_N4_0bC-y1FPBq4tP0PpbT8OgDi9Rx3j+m78RTmDoQR-A@mail.gmail.com>
 <PH7PR12MB600024A792B867BB964322D9FB252@PH7PR12MB6000.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB600024A792B867BB964322D9FB252@PH7PR12MB6000.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 14 Apr 2026 09:40:43 -0400
X-Gm-Features: AQROBzBKZ5bQgXK-xB90QDFFneywdPKbN-e6835zoNXSf7hqy6lbWY_v8xBVtBw
Message-ID: <CADnq5_MfEedhypkx-4jvsq_8spk8gCoH-KOkyJf1xO+DZouyVg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/sdma7.1: add support for disable_kq
To: "Liang, Prike" <Prike.Liang@amd.com>
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

On Mon, Apr 13, 2026 at 10:44=E2=80=AFPM Liang, Prike <Prike.Liang@amd.com>=
 wrote:
>
> [Public]
>
> Regards,
>       Prike
>
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> > Deucher
> > Sent: Tuesday, April 14, 2026 12:12 AM
> > To: Deucher, Alexander <Alexander.Deucher@amd.com>
> > Cc: amd-gfx@lists.freedesktop.org
> > Subject: Re: [PATCH] drm/amdgpu/sdma7.1: add support for disable_kq
> >
> > Ping?
> >
> > On Fri, Apr 3, 2026 at 10:01=E2=80=AFAM Alex Deucher <alexdeucher@gmail=
.com> wrote:
> > >
> > > Ping?
> > >
> > > On Thu, Mar 26, 2026 at 2:09=E2=80=AFPM Alex Deucher <alexander.deuch=
er@amd.com>
> > wrote:
> > > >
> > > > Plumb in support for disabling kernel queues and make it the
> > > > default.  For testing, kernel queues can be re-enabled by setting
> > > > amdgpu.user_queue=3D0.  Kernel queues are still created for use by =
the
> > > > kernel driver for memory management, etc., just not user
> > > > submissions.
> > > >
> > > > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > > > ---
> > > >  drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c | 12 ++++++++++++
> > > >  1 file changed, 12 insertions(+)
> > > >
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
> > > > b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
> > > > index f20e0fc3fc743..061934a2e93a3 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
> > > > @@ -1268,6 +1268,18 @@ static int sdma_v7_1_early_init(struct
> > amdgpu_ip_block *ip_block)
> > > >         struct amdgpu_device *adev =3D ip_block->adev;
> > > >         int r;
> > > >
> > > > +       switch (amdgpu_user_queue) {
> > > > +       case -1:
> > > > +       default:
> > > > +               adev->sdma.no_user_submission =3D true;
> > > > +               adev->sdma.disable_uq =3D true;
> > > > +               break;
> What's the case which requires disabling the UQ and dropping the userspac=
e submission to the ring at the same time? If so, then how to schedule the =
job to the SDMA for this case?

All submissions will go through KFD user queues.  There's no need for
user submission via kernel queues.  The kernel queues are still used
by the kernel driver for internal buffer clears, migration.

Alex

>
> > > > +       case 0:
> > > > +               adev->sdma.no_user_submission =3D false;
> > > > +               adev->sdma.disable_uq =3D true;
> > > > +               break;
> > > > +       }
> > > > +
> > > >         r =3D amdgpu_sdma_init_microcode(adev, 0, true);
> > > >         if (r) {
> > > >                 DRM_ERROR("Failed to init sdma firmware!\n");
> > > > --
> > > > 2.53.0
> > > >
