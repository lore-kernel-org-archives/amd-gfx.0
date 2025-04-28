Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64D9EC369D5
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Apr 2025 18:08:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C61910E671;
	Mon, 28 Apr 2025 18:08:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FJqBwNkM";
	dkim-atps=neutral
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DB1410E679
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Apr 2025 18:08:10 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-224104a9230so8613485ad.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Apr 2025 11:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745863690; x=1746468490; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mSJISVvkcTlS9dNqdQjCCwbc0qfERJJgB6lOlpZAOss=;
 b=FJqBwNkMEX/XhlvaGXFvbVj5hna2U8DATwEnz4pmxKsHvcEehXVCfFkg7JDCKcmorZ
 tH8bstm9dcsIasIJ1mQAp0FNvXkkqYkfgbMZDLgqLFwg6Ss+zRtXTJ1l4nweWtx8XWLo
 lg+KNahse5V9HND9BbPifK+oOPjIOU4ewUphtvpiJQ0mCARz92RdhWVusoGod9w3ZBhe
 AvBNVnIiiDANtTg3zpzV28cZ2ZN0fTIbuYqDGq05cJBdP/jk2wGEA/O5JBV+Qu3/NgUQ
 SW2PlmSZi2EEXirkHJeSl+Khdv+9DqcWosPda1XyvzLJOI6mdZZfCzR3sX7oYosNXYGJ
 aGHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745863690; x=1746468490;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mSJISVvkcTlS9dNqdQjCCwbc0qfERJJgB6lOlpZAOss=;
 b=VELTVDTzFqdm4/4H2VnqP8FfivbWZvjjtJzT2jYZljKft+i5uIcnR+C59wf/ik5lN2
 H3rCs0kFYw059+Foie0vwwVT8v0RnF+sIkxVeWM5Hq99NupQEryyognbIikqGlmOYzFj
 V72NVDIEb3MftHWsL1PKJMV7ghgvoDPXug0mEX3yie98p7wQac6jfIwNeBRm1cSJ9moC
 LHA3XOD8C11fzkjGfqo7cavhGibEAgrbjGBEsYFvRClhqNtPCkzMJK9PVB1L/Ta7eXFT
 fKSmrgB9CMl/jiW0B2G049mkWZYDH9xU37Eau7EDlAqbBm0FHhliX4yza7hV89AcW8RS
 zA0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhZ8Vl9vdIcqBI538FrljTpYOwyIHZOMHLWp9RQb1wIpS2lBZk6ETYNdkIll+nW0RSREAZiHBF@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzUgyunM6Ame5R68h2d11mxd/g9rkjgeEiINRoKyQEQ9rmDe1Vi
 88uxs696+EavqVmCRr5syV10tJ1G3IDHdif2Q8R0VfSS/wyHeIO1gfhwYU+3r4WaYLgLRffFzdi
 VzlcH3DyfAkDH+WE/v+Ku3bRFqQbhFg==
X-Gm-Gg: ASbGncsdN/EC4x24ta1RIE1EstxM/2BG3jGsKCemjZplESnt5H6LriYZzSAkpwLfsPd
 T4U8UCKahiD5tmPinirZ3RTzdcie5FdHiI5RgYRyN19v2qjavZ8mvTySaJeam4KxgUVv5NO5gCQ
 JlsNOTQLddHsBZAV9lLzo/VQ==
X-Google-Smtp-Source: AGHT+IGiJLtHNDB9K6QAHoaxQIaQV4+J+MIeolpRxAaHubDywab6oh0PCquJ8J+194sh5AIijZTohRdqE2u70suURvw=
X-Received: by 2002:a17:902:d591:b0:223:659d:ac66 with SMTP id
 d9443c01a7336-22de6f310d0mr336725ad.12.1745863689737; Mon, 28 Apr 2025
 11:08:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250425184125.166270-1-alexander.deucher@amd.com>
 <20250425184125.166270-8-alexander.deucher@amd.com>
 <DS7PR12MB6005E321909AC190237A3C42FB812@DS7PR12MB6005.namprd12.prod.outlook.com>
In-Reply-To: <DS7PR12MB6005E321909AC190237A3C42FB812@DS7PR12MB6005.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 28 Apr 2025 14:07:58 -0400
X-Gm-Features: ATxdqUEKTKSOgp09yIu-L8rxWkalnFJsiQKDxQ_QP-jyfA-ntbrM_0MP-4a1S6E
Message-ID: <CADnq5_P75V+500CWdNN=n_DaEFjjJxAfoqT7PxQT-HQj5qFtXg@mail.gmail.com>
Subject: Re: [PATCH 8/8] drm/amdgpu/userq: enable support for creating gangs
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

On Mon, Apr 28, 2025 at 9:48=E2=80=AFAM Liang, Prike <Prike.Liang@amd.com> =
wrote:
>
> [Public]
>
> Except for the patch4, 5, and the other patches set is Reviewed-by: Prike=
 Liang <Prike.Liang@amd.com>
> Question:
> 1) I don't find the user queue gang submission code in the mesa, could yo=
u point out where is the flight mesa counterpart code for supporting user q=
ueue gang submission?

Not yet.  I'm just proposing the UAPI here.  I'd like to get feedback
from the mesa tree to understand if this will meet their needs.

> 2) Do we plan to support user queue gang priority set and change support =
in the further?

I guess that is another question for userspace.  Do they want to be
able to change a queue's priority at runtime or only at queue creation
time?

Alex

>
> Regards,
>       Prike
>
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> > Deucher
> > Sent: Saturday, April 26, 2025 2:41 AM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> > Subject: [PATCH 8/8] drm/amdgpu/userq: enable support for creating gang=
s
> >
> > Gangs are sets of userqs that schedule together.  You specify the prima=
ry and
> > secondary queues and the scheduler will make sure they always run at th=
e same
> > time.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 52
> > +++++++++++++++++++++++
> >  1 file changed, 52 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > index e56fae10400db..95e1495d9a24c 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > @@ -561,6 +561,51 @@ amdgpu_userq_query_status(struct drm_file *filp, u=
nion
> > drm_amdgpu_userq *args)
> >       return 0;
> >  }
> >
> > +static int
> > +amdgpu_userq_create_gang(struct drm_file *filp, union drm_amdgpu_userq
> > +*args) {
> > +     struct amdgpu_usermode_queue *primary_queue, *secondary_queue;
> > +     struct amdgpu_fpriv *fpriv =3D filp->driver_priv;
> > +     struct amdgpu_userq_mgr *uq_mgr =3D &fpriv->userq_mgr;
> > +     const struct amdgpu_userq_funcs *userq_funcs;
> > +     struct amdgpu_device *adev =3D uq_mgr->adev;
> > +     int primary_queue_id =3D args->in_cg.primary_queue_id;
> > +     int secondary_queue_id =3D args->in_cg.secondary_queue_id;
> > +     int r;
> > +
> > +     mutex_lock(&uq_mgr->userq_mutex);
> > +     primary_queue =3D amdgpu_userq_find(uq_mgr, primary_queue_id);
> > +     if (!primary_queue) {
> > +             dev_err(adev->dev, "Invalid gang primary queue id\n");
> > +             mutex_unlock(&uq_mgr->userq_mutex);
> > +             return -EINVAL;
> > +     }
> > +     if ((primary_queue->queue_type !=3D AMDGPU_HW_IP_GFX) &&
> > +         (primary_queue->queue_type !=3D AMDGPU_HW_IP_COMPUTE)) {
> > +             dev_err(adev->dev, "Invalid gang primary queue type\n");
> > +             mutex_unlock(&uq_mgr->userq_mutex);
> > +             return -EINVAL;
> > +     }
> > +     secondary_queue =3D amdgpu_userq_find(uq_mgr, secondary_queue_id)=
;
> > +     if (!secondary_queue) {
> > +             dev_err(adev->dev, "Invalid gang secondary queue id\n");
> > +             mutex_unlock(&uq_mgr->userq_mutex);
> > +             return -EINVAL;
> > +     }
> > +     if ((secondary_queue->queue_type !=3D AMDGPU_HW_IP_GFX) &&
> > +         (secondary_queue->queue_type !=3D AMDGPU_HW_IP_COMPUTE)) {
> > +             dev_err(adev->dev, "Invalid gang secondary queue type\n")=
;
> > +             mutex_unlock(&uq_mgr->userq_mutex);
> > +             return -EINVAL;
> > +     }
> > +
> > +     userq_funcs =3D adev->userq_funcs[primary_queue->queue_type];
> > +     r =3D userq_funcs->set_gang(uq_mgr, primary_queue, secondary_queu=
e);
> > +     mutex_unlock(&uq_mgr->userq_mutex);
> > +
> > +     return r;
> > +}
> > +
> >  int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
> >                      struct drm_file *filp)
> >  {
> > @@ -611,6 +656,13 @@ int amdgpu_userq_ioctl(struct drm_device *dev, voi=
d
> > *data,
> >               if (r)
> >                       DRM_ERROR("Failed to query usermode queue status\=
n");
> >               break;
> > +     case AMDGPU_USERQ_OP_CREATE_GANG:
> > +             if (args->in_cg.pad)
> > +                     return -EINVAL;
> > +             r =3D amdgpu_userq_create_gang(filp, args);
> > +             if (r)
> > +                     DRM_ERROR("Failed to create usermode queue gang\n=
");
> > +             break;
> >       default:
> >               DRM_DEBUG_DRIVER("Invalid user queue op specified: %d\n",
> > args->in.op);
> >               return -EINVAL;
> > --
> > 2.49.0
>
