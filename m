Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA0FEC369AB
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 18:42:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AA9A10EC56;
	Fri, 11 Apr 2025 18:42:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HU+Eo9fn";
	dkim-atps=neutral
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E382810EC56
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 18:41:59 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-2ff67f44fcaso408648a91.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 11:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744396919; x=1745001719; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mzYmGD5PvOQl7WePjk7oAv+kTMl+4frGczfDDmr9A+0=;
 b=HU+Eo9fn/B/l7dsX/gxegh/4k0WCUM7XENfi0W3TtXfv63bz9/meDv3YrDsNA+EkUr
 ior4R0q0loK3e7R6GnNhyLwWamldUyx05LVHv1efYEuT6mRe6e2D/VEnxIDl/BUwfClo
 1N18D5A8KFU7wEEABNMfxDsbFJ+zSeN3sn+hp6qXNBJdVzZKUaT2pXN/ibvsfQvhQC6X
 IsA4nooag5rirYh9WReuBQpm0ItTrcEmSR6zxNAwFB2sFZOURdaF30HbFy3WBge6PObq
 jvbHxS3N4vKq62GF3Bs8ZdlEa+D1ikwNuEvlYtm03kKAbKzIcreVn9lwyfIkxPY4LD8s
 GO3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744396919; x=1745001719;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mzYmGD5PvOQl7WePjk7oAv+kTMl+4frGczfDDmr9A+0=;
 b=O7CsslUAVALflkrLEeoqabztelKsuBK9XPy1yq0SD9yHcqDSQhUX08/Cy1/NZJXaT9
 N52Ea1P3maEZo6dGZmBz1Ng8ONEkNfth90+FUPT9Aw5izNhsQf9bsUsBw+Mr7gtr6hWA
 drBAitKXhoi7K4020l3zAkPqS3NNn35l5OUB6O3yOWxgbGdIpE4F1ndLFw2uiVKhvzW1
 Tkovb7dEc8G9Wz9FP/tG0mPkUnO7G8O+0PW7NzzDRevWJhzgolPYle1B23Kx2xMxzI5S
 U6Ebyaxwx2VqfQLV6S+AciLtejStwQ3wuu80aexDysgrVDwnBckGeTingxk/7MszjvLX
 b+aQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsciJevkpZPlcAxEojm2HghHDUSDnSDhTKVAUjGn3t8dE/jutn0qnZ+WhV1w+86/DNHbHaxM+G@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyqfndthVSVWEsmSb+vO1G2P1/Q8fGCczGvmt1S3SMGxSKAgyPY
 B4AJuDTVW6AMw47uv1g8JUh4P7u19kK4LCDtbHIPYI9vKN8PJd7BzzhsISB+unSk7cJusftOYBo
 GmSzVOFRmDNvS3HGGs87KVExyBC4=
X-Gm-Gg: ASbGncvWLhX4Wq9w2AJlvyzoGXZuNyHDiODIrN2Oy56WI/JrorxMvQny8O+g39UJn+d
 G5WwJ2Ch0IBOIZ1cuqtEaqOfpeAg841rO67lf2DQKCJTr9qjKYFANiw36EPbYIunzypbfM/FlDE
 9iP/nSaQsWC4aAEtKK/sZChA==
X-Google-Smtp-Source: AGHT+IFCc7ayN4jht6lFho9rErhU1kMLnsr8ktXF4ceKrGEoQ6vCR+80M89uT//L4cdYr6FUeqyqHhsRIAScHLp4B00=
X-Received: by 2002:a17:90b:3ece:b0:2fa:6055:17e7 with SMTP id
 98e67ed59e1d1-3082378c79bmr2208029a91.8.1744396919197; Fri, 11 Apr 2025
 11:41:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250410185402.2352109-1-alexander.deucher@amd.com>
 <20250410185402.2352109-7-alexander.deucher@amd.com>
 <b372fade-f4d6-4eb5-8654-354d6ba4d1f7@amd.com>
In-Reply-To: <b372fade-f4d6-4eb5-8654-354d6ba4d1f7@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 11 Apr 2025 14:41:47 -0400
X-Gm-Features: ATxdqUGinZ01RtHR0Dwy_6NytkcaEe0cRMJO97_iSNrAuEPDo-zYuZiYbfQXgUY
Message-ID: <CADnq5_N6JgBKcF4_QTyfSuTp6RxO=Qt9kFo3ectNvxutNgVJFA@mail.gmail.com>
Subject: Re: [PATCH 07/13] drm/amdgpu/userq: enable support for queue
 priorities
To: "Khatri, Sunil" <sukhatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Fri, Apr 11, 2025 at 1:18=E2=80=AFPM Khatri, Sunil <sukhatri@amd.com> wr=
ote:
>
> A small comment otherwise it looks great.
> Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
>
> On 4/11/2025 12:23 AM, Alex Deucher wrote:
> > Enable users to create queues at different priority levels.
> > The highest level is restricted to drm master.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 26 ++++++++++++++++++=
-
> >   1 file changed, 25 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_userqueue.c
> > index 57a4ef64e0b8b..b8b13b6ab4631 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> > @@ -22,6 +22,7 @@
> >    *
> >    */
> >
> > +#include <drm/drm_auth.h>
> >   #include <drm/drm_exec.h>
> >   #include "amdgpu.h"
> >   #include "amdgpu_vm.h"
> > @@ -260,6 +261,21 @@ amdgpu_userqueue_destroy(struct drm_file *filp, in=
t queue_id)
> >       return r;
> >   }
> >
> > +static int amdgpu_userq_priority_permit(struct drm_file *filp,
> > +                                     int priority)
> > Do we want this value of priority to be unsigned as we only want values=
 >=3D0.

The values we pass in will always be >=3D0.

Alex

> > +{
> > +     if (priority < AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_HIGH)
> > +             return 0;
> > +
> > +     if (capable(CAP_SYS_NICE))
> > +             return 0;
> > +
> > +     if (drm_is_current_master(filp))
> > +             return 0;
> > +
> > +     return -EACCES;
> > +}
> > +
> >   static int
> >   amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq=
 *args)
> >   {
> > @@ -271,6 +287,9 @@ amdgpu_userqueue_create(struct drm_file *filp, unio=
n drm_amdgpu_userq *args)
> >       struct amdgpu_db_info db_info;
> >       uint64_t index;
> >       int qid, r =3D 0;
> > +     int priority =3D
> > +             (args->in.flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORIT=
Y_MASK) >>
> > +             AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_SHIFT;
> >
> >       /* Usermode queues are only supported for GFX IP as of now */
> >       if (args->in.ip_type !=3D AMDGPU_HW_IP_GFX &&
> > @@ -280,6 +299,10 @@ amdgpu_userqueue_create(struct drm_file *filp, uni=
on drm_amdgpu_userq *args)
> >               return -EINVAL;
> >       }
> >
> > +     r =3D amdgpu_userq_priority_permit(filp, priority);
> > +     if (r)
> > +             return r;
> > +
> >       /*
> >        * There could be a situation that we are creating a new queue wh=
ile
> >        * the other queues under this UQ_mgr are suspended. So if there =
is any
> > @@ -305,6 +328,7 @@ amdgpu_userqueue_create(struct drm_file *filp, unio=
n drm_amdgpu_userq *args)
> >       queue->doorbell_handle =3D args->in.doorbell_handle;
> >       queue->queue_type =3D args->in.ip_type;
> >       queue->vm =3D &fpriv->vm;
> > +     queue->priority =3D priority;
> >
> >       db_info.queue_type =3D queue->queue_type;
> >       db_info.doorbell_handle =3D queue->doorbell_handle;
> > @@ -377,7 +401,7 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void=
 *data,
> >
> >       switch (args->in.op) {
> >       case AMDGPU_USERQ_OP_CREATE:
> > -             if (args->in.flags)
> > +             if (args->in.flags & ~AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRI=
ORITY_MASK)
> >                       return -EINVAL;
> >               r =3D amdgpu_userqueue_create(filp, args);
> >               if (r)
