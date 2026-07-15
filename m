Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B43DCC4450A
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 02:15:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4822310EE91;
	Wed, 15 Jul 2026 02:15:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PkLCRjfC";
	dkim-atps=neutral
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7843D10EE91
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 02:15:17 +0000 (UTC)
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-8485ab7c382so757998b3a.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 19:15:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784081717; cv=none;
 d=google.com; s=arc-20260327;
 b=hLoAjp607LIeuvGUeZ7gCeCYFJFC7EG8hr1GRCkVwtubygSN0q42qDFvfMVu73ULaC
 mj4wujz2l+ULsUZkC7Byv95dBV/j5McJefxaQNjfdty7XoQUgD3YKQK+Iqt8SPEJ4LHC
 y3njfCJa3HbW5Nr2FxWgFohGZorPWg97XdUCkxtkc9BookpMzxQ1wOVJxC4DLM2oxXM3
 mEglvcAvlxDZ6r4ERDvwxA2ex1wLzJ1UtBS8fL3LxLi9gpwol6PUOVvHvzsEQk2o0gK0
 MM+mqoK2OwnxkqQIkvHEPJeCL2Hc8daluEv8390mVK/qHjHKifAXkzlaXcf2k8lDLbnw
 JuzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=OuizryxSZKRFUsSw4CQIMj48vXkwcx3MZKR1605+b/M=;
 fh=2Whg2RURqu8cyyl3X6bj7nVcK8VyxsZQrwvDK5RGFJk=;
 b=qDQwsQ5BaFrszKa2SSkQPYgVThVsTqHrC/ZQ2DKsJ2IyjsBsTzTPpCgN78Htvalp7K
 4G3ql80T//H8/0Gjx4i8IZ+d44OqxQwE2gkQP/kgBhXvUB11R1uO51tcoTc8tJQl0La2
 Al6zZW39rJ/vuTv/qRX2PLgLAPsmriO+bVNOU4abNQPBkBjNRcm28sV6eV9c09qUwE/X
 GvPl0T6Yx7EGg9hPkR6WJ05R9K+nJ29l5gHmYwupaYWCjp7cIskMiHOuA2IshWYZFkTx
 3AP3udj23OJfN+NBnv8JRo4u7/TIowqjvDvKm+RWfOljdRd5byurgFGZQJRMQoScJ88h
 HlZA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784081717; x=1784686517; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OuizryxSZKRFUsSw4CQIMj48vXkwcx3MZKR1605+b/M=;
 b=PkLCRjfCvOoptjIcR/oK0xHR3qm685KRfLsOET5NESzZ2SRwkFcdY7S5sxgj5oIzzk
 8H4OsOdNeqtelG9stI6OIk9LNxVkrpkob65+qQ0DS7g/Hl3WHbUUvr0ugFHtUuYyG++C
 WNJYiBV/f8WSYR/qdWg9Hsp/YMhxGIh2fa0DmaBmFT+9OGTa2Wr24SamkBLZ9lTMBP98
 DPqG5rNu0g/2zspIIhcpmxtyvshpYIC9TUF8AFrv0ELful6/yYPUtjCz96o9+exTwhVR
 QrvXrvPUAjHuCc6AGKXfdBRy0oy8VUS80TQ+8qznIld43wWKmCWL741f9ELcNnzjkxwL
 WWtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784081717; x=1784686517;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OuizryxSZKRFUsSw4CQIMj48vXkwcx3MZKR1605+b/M=;
 b=G1AQ2Ouzqx1bga38/h6EY6Tb8dT3MoDYZ6blOgpbVmoMk5zJwMZG+F5BO+vw5tzYxH
 6d9oeB3pTn87qf4XLYb8sfizPtvEOpWxbxITGdU6x4/yF2xq9h0gv4UGBmoyBFcrqiEq
 RdWCt5+VPM9YbWBMnZV5Ww0m5Gs4q1i5qXfNIli/jAoAy2442p7cz6o+REer4RIAYDXo
 7UJnfwGUCK4WMZ33X4S6mMslmLYl0fgtPLOutB1jcRZss3NzG8344ZUIkObp23IAuQOa
 xHgqaDlPX3e4LqjfTWp7Hk0mrwXy87GEpmWRH+VXjVKSICyX/VoQGfQV2fDTCUZ9aqhb
 d3BA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpA5oAhbcK5MFlNpUb85HLiJ6o3MnzBgVFJZW1IzoVQYrETkxYlwVQxbpbEIySuHUXv/SUeQyvW@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxK80JRT7dftmy27H6VFcFOJDwlpSjEKOqBYfKS7jrfp4nI9GbH
 KiQhpVJnVf2YcIncCXVjPhg83Up7OYp9oePoYFSsFOOJhpdExLB8FYujryPL/VP0AvyXoeNiEI4
 o/kflooIue3s69V5QdlzCZLw58R62vFo=
X-Gm-Gg: AfdE7cnkJP/j+XkiY7bjtQeTVlF+DZhbnzUshe4GcTnB8TOMa8kDsh+IyQHwUAc+sYS
 qQHRj6NrmCerOa4n2XJ8MIcN5UxjbRUt2urB3/n2+ziiBjfdtAYmKaIWBTkWNi1Fj4hUKq03TfX
 cbAY7k1KHWg8kT0rUJNmAQaAww+o69kHQKayQ8DRS3ctQ6dt6F1NvDdGJdvExpxemQ2E7Gy4FlF
 x6+rPFsXcN4sxMAChpbI7pWAtRi6Bkzg7Q+NWEgf1QTMIzVbzcLvxigz7wuyOJk8FdOkg9qiZlW
 h6diKX2Z2v9nUCPBOyjhXwIDX9AEnjkZq53BPErbEfT/6EdBtRikFT9771Vr4hs8aR+bZQ==
X-Received: by 2002:a17:90b:2685:b0:381:28e0:6248 with SMTP id
 98e67ed59e1d1-38dc781f3d7mr12400601a91.1.1784081716926; Tue, 14 Jul 2026
 19:15:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260713203850.650426-1-alexander.deucher@amd.com>
 <DS7PR12MB600589F9C41083DA5506725BFBF92@DS7PR12MB6005.namprd12.prod.outlook.com>
 <DS7PR12MB6005FB0DF535C58EAA3DC93BFBF92@DS7PR12MB6005.namprd12.prod.outlook.com>
 <CADnq5_NtsmdSgmzJrFcv4dCaBdDwAoWEZ2RrRQgGdXqaXGOd_w@mail.gmail.com>
 <DS7PR12MB6005B10D8CB237EE1D0CC9C3FBF82@DS7PR12MB6005.namprd12.prod.outlook.com>
In-Reply-To: <DS7PR12MB6005B10D8CB237EE1D0CC9C3FBF82@DS7PR12MB6005.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 14 Jul 2026 22:15:03 -0400
X-Gm-Features: AUfX_mwyQr2Qr7VX-dAae9GOXdKH6r1ne4Fvdt_dJdA3eUkKw9hbDcCK7inR4WY
Message-ID: <CADnq5_PAJAQKPvj=Pz4w1T5njH7KRu0N6TBj+fFChA+tzQAPYw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/userq: properly account for resets
To: "Liang, Prike" <Prike.Liang@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Khatri,
 Sunil" <Sunil.Khatri@amd.com>
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

On Tue, Jul 14, 2026 at 10:02=E2=80=AFPM Liang, Prike <Prike.Liang@amd.com>=
 wrote:
>
> AMD General
>
> Regards,
>       Prike
>
> > -----Original Message-----
> > From: Alex Deucher <alexdeucher@gmail.com>
> > Sent: Tuesday, July 14, 2026 9:52 PM
> > To: Liang, Prike <Prike.Liang@amd.com>
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-
> > gfx@lists.freedesktop.org; SHANMUGAM, SRINIVASAN
> > <SRINIVASAN.SHANMUGAM@amd.com>; Khatri, Sunil <Sunil.Khatri@amd.com>
> > Subject: Re: [PATCH] drm/amdgpu/userq: properly account for resets
> >
> > On Tue, Jul 14, 2026 at 3:44=E2=80=AFAM Liang, Prike <Prike.Liang@amd.c=
om> wrote:
> > >
> > > AMD General
> > >
> > > Regards,
> > >       Prike
> > >
> > > > -----Original Message-----
> > > > From: Liang, Prike
> > > > Sent: Tuesday, July 14, 2026 10:49 AM
> > > > To: 'Alex Deucher' <alexander.deucher@amd.com>;
> > > > amd-gfx@lists.freedesktop.org
> > > > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; SHANMUGAM,
> > > > SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>; Khatri, Sunil
> > > > <Sunil.Khatri@amd.com>
> > > > Subject: RE: [PATCH] drm/amdgpu/userq: properly account for resets
> > > >
> > > >
> > > >
> > > > Regards,
> > > >       Prike
> > > >
> > > > > -----Original Message-----
> > > > > From: Alex Deucher <alexander.deucher@amd.com>
> > > > > Sent: Tuesday, July 14, 2026 4:39 AM
> > > > > To: amd-gfx@lists.freedesktop.org
> > > > > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; SHANMUGAM,
> > > > > SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>; Liang, Prike
> > > > > <Prike.Liang@amd.com>; Khatri, Sunil <Sunil.Khatri@amd.com>
> > > > > Subject: [PATCH] drm/amdgpu/userq: properly account for resets
> > > > >
> > > > > We need to increment the reset counter, force fence completion,
> > > > > and set the wedged event when a user queue is reset.
> > > > >
> > > > > mes_userq_reset_queue() handles this for collateral damage, but
> > > > > the caller needs to handle this directly for the original guilty =
queue.
> > > > >
> > > > > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > > > > Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> > > > > Cc: Prike Liang <Prike.Liang@amd.com>
> > > > > Cc: Sunil Khatri <sunil.khatri@amd.com>
> > > > > ---
> > > > >  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 7 ++++++-
> > > > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > > > > index 6aa75da27f912..5e1262636e1e9 100644
> > > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > > > > @@ -146,8 +146,13 @@ static void
> > > > > amdgpu_userq_hang_detect_work(struct
> > > > > work_struct *work)
> > > > >                                                      queue, NULL,=
 NULL);
> > > > >             else
> > > > >                     r =3D userq_funcs->reset(queue);
> > > > > -           if (r)
> > > > > +           if (r) {
> > > > >                     gpu_reset =3D true;
> > > > > +           } else {
> > > > > +                   atomic_inc(&adev->gpu_reset_counter);
> > > > > +                   amdgpu_userq_fence_driver_force_completion(qu=
eue);
> > > > > +                   drm_dev_wedged_event(adev_to_drm(adev),
> > > > > DRM_WEDGE_RECOVERY_NONE, NULL);
> > > >
> > > > If we do the userq reset post similar process here just like as
> > > > mes_userq_reset_queue(), so do we need to clear the duplicate the
> > > > code in the mes_userq_reset_queue()? Otherwise, the gpu reset count=
er
> > should be incorrect.
> > > > Except that, we might input the wedge task info to report the guilt=
y process info.
> > >
> > > As to the first question, I recheck the code and found out the guilty=
 user queue in
> > the amdgpu_gfx_reset_mes_compute() was reset separately before
> > mes_userq_reset_queue(), with this current reset sequence then this cha=
nge it
> > make sense to update reset counter and  force complete fence.
> > >
> > > But why need to reset the original guilty queue separately, should th=
is guilty queue
> > was found by the amdgpu_mes_detect_and_reset_hung_queues() in the MES
> > firmware? If so, we may need to reset the guilty queue through
> > mes_userq_reset_queue() rather than reset separately, then we don't nee=
d to add
> > this change anymore.
> >
> > We still need it for gfx and sdma queues.  Those don't get reset via
> > amdgpu_gfx_reset_mes_compute(),
>
> Yes, I will check whether the original guilty compute queue can be identi=
fied by amdgpu_mes_detect_and_reset_hung_queues(). If so, the separate guil=
ty queue reset via mes_userq_reset_queue() becomes redundant and can be rem=
oved. The compute userq reset refcount and completed fence handling would t=
hen be relocated into amdgpu_userq_hang_detect_work(), consolidating the re=
set path into a single flow.
>

I don't think we need that; see V3 of the patch I sent out earlier today.

Alex

>
> Thanks,
> Prike
>
> > Alex
> >
> > >
> > > >
> > > > > +           }
> > > > >     } else {
> > > > >             gpu_reset =3D true;
> > > > >     }
> > > > > --
> > > > > 2.55.0
> > >
