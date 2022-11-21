Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21A90C433FE
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Nov 2022 17:04:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5242910E1C9;
	Mon, 21 Nov 2022 17:04:52 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7CBF10E2E2
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Nov 2022 16:37:01 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id l24so4473569edj.8
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Nov 2022 08:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=nE3Bxy8A1HvC+XZ5FPqcTnwpLNQvQiJYssjKLP/+wbs=;
 b=Vl38n5K1dDdWSTrmTdVEkYnq3EB09UBuX3gE23kP5JQ93sIvHU+63e2QCSA5vW1twI
 sxsQFbh5WedPX/O+jmlMa3tOYLGvZgMV66KG6ZKMkNyTYY8tn1fV0VFyHKznDdhEx8po
 zwyd/Ki/FNgp9lThHHbJivNZHL89VtbENQl9tMzh3o+DmuutGNwCtktnov+c93v6+ZhM
 chy15uBV7/vG6+jA9taKyR9T1uBHCuxy1uovMfiH/60tzgiMHXCryImTCBb7UgYjXMZq
 N2dMl9bn4d+v9BihJSXAqsxVU/FhVwdoBUYptX0vxpP8SrfX/6Hsw62QXfiQWR1JTBVS
 AyTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nE3Bxy8A1HvC+XZ5FPqcTnwpLNQvQiJYssjKLP/+wbs=;
 b=1BqPSOaD2YuW/koeVzjdU8GZR+HYoIPZSlakZYJrJ1UeQtUa6nz4Re+EQ2Suv1Rmns
 gy6hKTUUQPEoZnMLmXL5KNWbjDqCyVFQIFp+hOhzFJ0PL8HY1H4rpcoiaUo20Arv+wDk
 B+165N0MXTCmLC9HdYW1vlkW6fOoSDZUxZ5MRxHx7+47065EkZkBYzOMMPnCe8eRUpNb
 5EIyTyDYFXad+uuzbQV4K0GIMjDaM+Oset/bRy0ZNr+rrPoQ3yTol5hCxeWZal5k//cC
 Ck/+gRQJTfbpMWgZ2Z51X/ukQ6VqAwas3vLmOu1jEvPzACfYkBEOvd9MKUHAFr1rYwV+
 vpNg==
X-Gm-Message-State: ANoB5plhcdAvg3By86OeozenuALjC8AqEUPgYTgCwYqZmRrtym+WPBQC
 vXYVJDMlxn8tYLuXFzHuGLw=
X-Google-Smtp-Source: AA0mqf5zqEYhejnliXQIvNfcc+ni+EW/JmO5hmBoOW9m53FtyiWnVKcx49MIdi4oC1cseBbn1EoqpQ==
X-Received: by 2002:a05:6402:28c9:b0:469:ba7c:bc75 with SMTP id
 ef9-20020a05640228c900b00469ba7cbc75mr2692149edb.286.1669048620153; 
 Mon, 21 Nov 2022 08:37:00 -0800 (PST)
Received: from [192.168.0.131] (catv-89-134-213-173.catv.fixed.vodafone.hu.
 [89.134.213.173]) by smtp.gmail.com with ESMTPSA id
 x10-20020a1709064a8a00b0078d3a075525sm5200417eju.56.2022.11.21.08.36.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Nov 2022 08:36:59 -0800 (PST)
Message-ID: <39d1300065afbb79f589aa627552d6da82083fe8.camel@gmail.com>
Subject: Re: [PATCH] drm/amdgpu: handle gang submit before VMID
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>, 
 amd-gfx@lists.freedesktop.org
Date: Mon, 21 Nov 2022 17:36:58 +0100
In-Reply-To: <a180281a-c78e-0d0f-7163-c57f104b714c@gmail.com>
References: <20221118153023.312582-1-christian.koenig@amd.com>
 <3144fa81950d36c0e30d984ecc775664a86f754f.camel@gmail.com>
 <a180281a-c78e-0d0f-7163-c57f104b714c@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 21 Nov 2022 17:04:47 +0000
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
Cc: Alexander.Deucher@amd.com,
 Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The patch did not make it into rc6 after all.
Can you please make sure it goes into rc7?

Thanks,
Timur

On Fri, 2022-11-18 at 17:53 +0100, Christian K=C3=B6nig wrote:
> Pushed to drm-misc-fixes, should be picked up for the next rc.
>=20
> Let me know if you run into any more problems with that.
>=20
> Thanks,
> Christian.
>=20
> Am 18.11.22 um 16:36 schrieb Timur Krist=C3=B3f:
> > Can you guys please push this into the next 6.1 RC? This solves a
> > significant issue with gang submit.
> >=20
> > On Fri, 2022-11-18 at 16:30 +0100, Christian K=C3=B6nig wrote:
> > > Otherwise it can happen that not all gang members can get a VMID
> > > assigned and we deadlock.
> > >=20
> > > Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > > Tested-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > > Acked-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > > Fixes: 68ce8b242242 ("drm/amdgpu: add gang submit backend v2")
> > > ---
> > > =C2=A0=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 6 +++---
> > > =C2=A0=C2=A01 file changed, 3 insertions(+), 3 deletions(-)
> > >=20
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > > index cd968e781077..abb99cff8b4b 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > > @@ -254,6 +254,9 @@ static struct dma_fence
> > > *amdgpu_job_dependency(struct drm_sched_job *sched_job,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0DRM_ERROR("Error adding fence (%d)\n",
> > > r);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > > =C2=A0=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!fence && job->gang_su=
bmit)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0fence =3D amdgpu_device_switch_gang(ring->adev,
> > > job-
> > > > gang_submit);
> > > +
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0while (fence =
=3D=3D NULL && vm && !job->vmid) {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0r =3D amdgpu_vmid_grab(vm, ring, &job->syn=
c,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 &job->base.s_fence-
> > > >finished,
> > > @@ -264,9 +267,6 @@ static struct dma_fence
> > > *amdgpu_job_dependency(struct drm_sched_job *sched_job,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fence =3D amdgpu_sync_get_fence(&job->sync=
);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > > =C2=A0=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!fence && job->gang_su=
bmit)
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0fence =3D amdgpu_device_switch_gang(ring->adev,
> > > job-
> > > > gang_submit);
> > > -
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return fence;
> > > =C2=A0=C2=A0}
> > > =C2=A0=20
>=20

