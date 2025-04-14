Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27685C369A2
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Apr 2025 17:33:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC88110E040;
	Mon, 14 Apr 2025 17:33:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UpCjmw2w";
	dkim-atps=neutral
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com
 [209.85.160.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 675CD10E040
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Apr 2025 17:33:53 +0000 (UTC)
Received: by mail-oa1-f41.google.com with SMTP id
 586e51a60fabf-2c76a35f48cso112975fac.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Apr 2025 10:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744652032; x=1745256832; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LcUO+kLv8YZpnKMm0hw2OZpLJ8/XJ1BlU0GeeB9DD1k=;
 b=UpCjmw2wd0/QZEV7nytVGO0yaSQk0LSbhYpj49u7xrRuz7P/sggOKMzvDXXiS5UbKu
 j31Xg5Z97wQebjGpUbTgXbwtv1aLP8cOK9NBx0g69IX807ycXJbkbbkrITerpUEiGMLv
 KEH6+ZiNKKCuYFlhKZ3YY6T7aiph+rmVycgxuHeGXI6EiTROEu9o6Ik5PmlqLsi6MKb+
 cp/brL/GY+OzNLV3imD8sCNLfYK96REDtHiLDYznQqiYnVfZPd7tTJo8unphtSpUOUNr
 FdDm6YtR7fdnbDhbwR5u1z8mHkwKEMoiPbx+Vd1rNNFja6EKifiBXK88lQdvCXyzvtV8
 DXGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744652032; x=1745256832;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LcUO+kLv8YZpnKMm0hw2OZpLJ8/XJ1BlU0GeeB9DD1k=;
 b=PMQaPsWb5hhp6BhZZr5YHL7PgepCmNI0l3ciwyZmZOBbjvF79c6aW82tdKVbR+VPVX
 noptA5Mxis14jgSbhdPakeGOJXgPf1UBZMFRocGER1OvL7NRrcbZSelzlsR4rKamrtP0
 z2wRr8cXNH+/+HnRU9I+KHi2jFpKdXhICguVJGUcaMZlJOHjR5ztilJaxmSQZnolPRto
 yX0gzx2jjxRTOPHKmHCD8976r7+KJHesuz9oH8+ydhyYQwkpQrrSv/BX1XbwZaz/KU60
 ViEE5RNi+socCUaw+dzwcty1LnTCYsAiU8f0EN+uFNSFHRZD7Pe0j3F7Zlbzkftx/6sK
 A1pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXn55SEu3Jq7dW//j6SZmyxL1Tci76IKdrfHwNDvjiZUghJ8pOZl2jB+1zTANxePrInTiRfUQ3t@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxCA2+LLcI3I8qON3YbAAoL3PW/KfrPq2Ihl6q43JCt9ttbBzpo
 XFHcJE6+nhgItDV4jUgZmR5gQUiTUpUU9lS2y7HuxPS/ksEOk2UM3FV7h1cZrjGBJWJEMDAtoqb
 8FB8C59tZaV3j/urteIuptdDubmY=
X-Gm-Gg: ASbGncuONbpqU3fgP1CsTOhibs9CU+Mstx5wJYgvTiU3Qs+VOcGiZz1oz6ZPkpPHeD3
 WchWT/xxmzvGDWl5BwWafxhjNTZLIbqRgM6z41RPQ+ctx0UnitoZefluzkAg/mC2d8l6mi+BTuS
 uftKiQKSa8o87Ac89hSlfH3NE=
X-Google-Smtp-Source: AGHT+IFlm3vyo6/cmpsaBEvsbt1n84VDiP/Q7DNoKIXdZtNp4N9ZBL+uzlTRxXFJWsdRPSPW3mxg+8oL9L8tWL34Pso=
X-Received: by 2002:a05:6871:d043:b0:296:c3e9:507c with SMTP id
 586e51a60fabf-2d1732f0591mr117904fac.10.1744652032268; Mon, 14 Apr 2025
 10:33:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250412080327.2687-1-Arunpravin.PaneerSelvam@amd.com>
 <56dc90ff-afbb-4159-8a7f-fb4923537736@amd.com>
In-Reply-To: <56dc90ff-afbb-4159-8a7f-fb4923537736@amd.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Mon, 14 Apr 2025 13:33:16 -0400
X-Gm-Features: ATxdqUH1D-kUKiqIBqiJHoUi5xmv-sfYL6QriQCBUhGdA-puFUBdNNDOiRBGPHk
Message-ID: <CAAxE2A5EUs9TK+fNp9k-ZaDj6h=CLyogMN5G+4q4ru6bQmvKmA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: Add queue id support to the user queue
 wait IOCTL
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org, 
 alexander.deucher@amd.com, marek.olsak@amd.com
Content-Type: multipart/alternative; boundary="000000000000a3e1070632c074ec"
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

--000000000000a3e1070632c074ec
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2025 at 7:33=E2=80=AFAM Christian K=C3=B6nig <christian.koe=
nig@amd.com>
wrote:

> Am 12.04.25 um 10:03 schrieb Arunpravin Paneer Selvam:
> > Add queue id support to the user queue wait IOCTL
> > drm_amdgpu_userq_wait structure.
> >
> > This is required to retrieve the wait user queue and maintain
> > the fence driver references in it so that the user queue in
> > the same context releases their reference to the fence drivers
> > at some point before queue destruction.
> >
> > Otherwise, we would gather those references until we
> > don't have any more space left and crash.
> >
> > v2: Modify the UAPI comment as per the mesa and libdrm UAPI comment.
> >
> > Libdrm MR: https://gitlab.freedesktop.org/mesa/drm/-/merge_requests/408
> > Mesa MR: https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/3449=
3
> >
> > Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.co=
m
> >
> > Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>

Didn't you notice the ABI breakage?

Marek


>
> > ---
> >  .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 20 +++++++++++--------
> >  .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |  1 -
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c |  1 -
> >  include/uapi/drm/amdgpu_drm.h                 |  6 ++++++
> >  4 files changed, 18 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> > index a4953d668972..83bb2737c92e 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> > @@ -97,7 +97,6 @@ int amdgpu_userq_fence_driver_alloc(struct
> amdgpu_device *adev,
> >       spin_lock_init(&fence_drv->fence_list_lock);
> >
> >       fence_drv->adev =3D adev;
> > -     fence_drv->fence_drv_xa_ptr =3D &userq->fence_drv_xa;
> >       fence_drv->context =3D dma_fence_context_alloc(1);
> >       get_task_comm(fence_drv->timeline_name, current);
> >
> > @@ -591,6 +590,9 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev,
> void *data,
> >       u32 num_syncobj, num_read_bo_handles, num_write_bo_handles;
> >       struct drm_amdgpu_userq_fence_info *fence_info =3D NULL;
> >       struct drm_amdgpu_userq_wait *wait_info =3D data;
> > +     struct amdgpu_fpriv *fpriv =3D filp->driver_priv;
> > +     struct amdgpu_userq_mgr *userq_mgr =3D &fpriv->userq_mgr;
> > +     struct amdgpu_usermode_queue *waitq;
> >       struct drm_gem_object **gobj_write;
> >       struct drm_gem_object **gobj_read;
> >       struct dma_fence **fences =3D NULL;
> > @@ -840,6 +842,10 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev=
,
> void *data,
> >                       fences[num_fences++] =3D fence;
> >               }
> >
> > +             waitq =3D idr_find(&userq_mgr->userq_idr,
> wait_info->waitq_id);
> > +             if (!waitq)
> > +                     goto free_fences;
> > +
> >               for (i =3D 0, cnt =3D 0; i < num_fences; i++) {
> >                       struct amdgpu_userq_fence_driver *fence_drv;
> >                       struct amdgpu_userq_fence *userq_fence;
> > @@ -868,14 +874,12 @@ int amdgpu_userq_wait_ioctl(struct drm_device
> *dev, void *data,
> >                        * Otherwise, we would gather those references
> until we don't
> >                        * have any more space left and crash.
> >                        */
> > -                     if (fence_drv->fence_drv_xa_ptr) {
> > -                             r =3D xa_alloc(fence_drv->fence_drv_xa_pt=
r,
> &index, fence_drv,
> > -                                          xa_limit_32b, GFP_KERNEL);
> > -                             if (r)
> > -                                     goto free_fences;
> > +                     r =3D xa_alloc(&waitq->fence_drv_xa, &index,
> fence_drv,
> > +                                  xa_limit_32b, GFP_KERNEL);
> > +                     if (r)
> > +                             goto free_fences;
> >
> > -                             amdgpu_userq_fence_driver_get(fence_drv);
> > -                     }
> > +                     amdgpu_userq_fence_driver_get(fence_drv);
> >
> >                       /* Store drm syncobj's gpu va address and value *=
/
> >                       fence_info[cnt].va =3D fence_drv->va;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
> > index f0a91cc02880..d5090a6bcdde 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
> > @@ -55,7 +55,6 @@ struct amdgpu_userq_fence_driver {
> >       spinlock_t fence_list_lock;
> >       struct list_head fences;
> >       struct amdgpu_device *adev;
> > -     struct xarray *fence_drv_xa_ptr;
> >       char timeline_name[TASK_COMM_LEN];
> >  };
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> > index ecd49cf15b2a..7c754ba56cff 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> > @@ -73,7 +73,6 @@ amdgpu_userqueue_cleanup(struct amdgpu_userq_mgr
> *uq_mgr,
> >       }
> >
> >       uq_funcs->mqd_destroy(uq_mgr, queue);
> > -     queue->fence_drv->fence_drv_xa_ptr =3D NULL;
> >       amdgpu_userq_fence_driver_free(queue);
> >       idr_remove(&uq_mgr->userq_idr, queue_id);
> >       kfree(queue);
> > diff --git a/include/uapi/drm/amdgpu_drm.h
> b/include/uapi/drm/amdgpu_drm.h
> > index ef97c0d78b8a..2195810ae42d 100644
> > --- a/include/uapi/drm/amdgpu_drm.h
> > +++ b/include/uapi/drm/amdgpu_drm.h
> > @@ -501,6 +501,12 @@ struct drm_amdgpu_userq_fence_info {
> >  };
> >
> >  struct drm_amdgpu_userq_wait {
> > +     /**
> > +      * @waitq_id: Queue handle used by the userq wait IOCTL to
> retrieve the
> > +      * wait queue and maintain the fence driver references in it.
> > +      */
> > +     __u32   waitq_id;
> > +     __u32   pad;
> >       /**
> >        * @syncobj_handles: The list of syncobj handles submitted by the
> user queue
> >        * job to get the va/value pairs.
>
>

--000000000000a3e1070632c074ec
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote gmail_quote_container"><div dir=
=3D"ltr" class=3D"gmail_attr">On Mon, Apr 14, 2025 at 7:33=E2=80=AFAM Chris=
tian K=C3=B6nig &lt;<a href=3D"mailto:christian.koenig@amd.com">christian.k=
oenig@amd.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">Am 12.04.25 um 10:03 schrieb Arunpravin Paneer Selvam:<br>
&gt; Add queue id support to the user queue wait IOCTL<br>
&gt; drm_amdgpu_userq_wait structure.<br>
&gt;<br>
&gt; This is required to retrieve the wait user queue and maintain<br>
&gt; the fence driver references in it so that the user queue in<br>
&gt; the same context releases their reference to the fence drivers<br>
&gt; at some point before queue destruction.<br>
&gt;<br>
&gt; Otherwise, we would gather those references until we<br>
&gt; don&#39;t have any more space left and crash.<br>
&gt;<br>
&gt; v2: Modify the UAPI comment as per the mesa and libdrm UAPI comment.<b=
r>
&gt;<br>
&gt; Libdrm MR: <a href=3D"https://gitlab.freedesktop.org/mesa/drm/-/merge_=
requests/408" rel=3D"noreferrer" target=3D"_blank">https://gitlab.freedeskt=
op.org/mesa/drm/-/merge_requests/408</a><br>
&gt; Mesa MR: <a href=3D"https://gitlab.freedesktop.org/mesa/mesa/-/merge_r=
equests/34493" rel=3D"noreferrer" target=3D"_blank">https://gitlab.freedesk=
top.org/mesa/mesa/-/merge_requests/34493</a><br>
&gt;<br>
&gt; Signed-off-by: Arunpravin Paneer Selvam &lt;<a href=3D"mailto:Arunprav=
in.PaneerSelvam@amd.com" target=3D"_blank">Arunpravin.PaneerSelvam@amd.com<=
/a>&gt;<br>
&gt; Suggested-by: Christian K=C3=B6nig &lt;<a href=3D"mailto:christian.koe=
nig@amd.com" target=3D"_blank">christian.koenig@amd.com</a>&gt;<br>
<br>
Reviewed-by: Christian K=C3=B6nig &lt;<a href=3D"mailto:christian.koenig@am=
d.com" target=3D"_blank">christian.koenig@amd.com</a>&gt;<br></blockquote><=
div><br></div><div>Didn&#39;t you notice the ABI breakage?</div><div><br></=
div><div>Marek</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">
<br>
&gt; ---<br>
&gt;=C2=A0 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c=C2=A0 =C2=A0| 20 +++=
++++++++--------<br>
&gt;=C2=A0 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h=C2=A0 =C2=A0|=C2=A0 =
1 -<br>
&gt;=C2=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c |=C2=A0 1 -<br>
&gt;=C2=A0 include/uapi/drm/amdgpu_drm.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 6 ++++++<br>
&gt;=C2=A0 4 files changed, 18 insertions(+), 10 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers=
/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c<br>
&gt; index a4953d668972..83bb2737c92e 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c<br>
&gt; @@ -97,7 +97,6 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_de=
vice *adev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock_init(&amp;fence_drv-&gt;fence_list=
_lock);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0fence_drv-&gt;adev =3D adev;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0fence_drv-&gt;fence_drv_xa_ptr =3D &amp;userq-&gt=
;fence_drv_xa;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0fence_drv-&gt;context =3D dma_fence_context_=
alloc(1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0get_task_comm(fence_drv-&gt;timeline_name, c=
urrent);<br>
&gt;=C2=A0 <br>
&gt; @@ -591,6 +590,9 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev=
, void *data,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 num_syncobj, num_read_bo_handles, num_wr=
ite_bo_handles;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct drm_amdgpu_userq_fence_info *fence_in=
fo =3D NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct drm_amdgpu_userq_wait *wait_info =3D =
data;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct amdgpu_fpriv *fpriv =3D filp-&gt;driver_pr=
iv;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct amdgpu_userq_mgr *userq_mgr =3D &amp;fpriv=
-&gt;userq_mgr;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct amdgpu_usermode_queue *waitq;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct drm_gem_object **gobj_write;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct drm_gem_object **gobj_read;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct dma_fence **fences =3D NULL;<br>
&gt; @@ -840,6 +842,10 @@ int amdgpu_userq_wait_ioctl(struct drm_device *de=
v, void *data,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0fences[num_fences++] =3D fence;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0waitq =3D idr_find(&a=
mp;userq_mgr-&gt;userq_idr, wait_info-&gt;waitq_id);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!waitq)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0goto free_fences;<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0, cn=
t =3D 0; i &lt; num_fences; i++) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0struct amdgpu_userq_fence_driver *fence_drv;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0struct amdgpu_userq_fence *userq_fence;<br>
&gt; @@ -868,14 +874,12 @@ int amdgpu_userq_wait_ioctl(struct drm_device *d=
ev, void *data,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 * Otherwise, we would gather those references until we don&#3=
9;t<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 * have any more space left and crash.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (fence_drv-&gt;fence_drv_xa_ptr) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D xa_alloc(fence_drv-&gt;fence_drv_x=
a_ptr, &amp;index, fence_drv,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 xa_limit_32b, GFP_KERNEL);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (r)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto free_fe=
nces;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0r =3D xa_alloc(&amp;waitq-&gt;fence_drv_xa, &amp;index, fence_drv,<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 xa_limit_32b, GFP_KERNEL)=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (r)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto free_fences;<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_userq_fence_driver_get(fence_drv)=
;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0amdgpu_userq_fence_driver_get(fence_drv);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0/* Store drm syncobj&#39;s gpu va address and value */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0fence_info[cnt].va =3D fence_drv-&gt;va;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h b/drivers=
/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h<br>
&gt; index f0a91cc02880..d5090a6bcdde 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h<br>
&gt; @@ -55,7 +55,6 @@ struct amdgpu_userq_fence_driver {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0spinlock_t fence_list_lock;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct list_head fences;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct amdgpu_device *adev;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0struct xarray *fence_drv_xa_ptr;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0char timeline_name[TASK_COMM_LEN];<br>
&gt;=C2=A0 };<br>
&gt;=C2=A0 <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_userqueue.c<br>
&gt; index ecd49cf15b2a..7c754ba56cff 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c<br>
&gt; @@ -73,7 +73,6 @@ amdgpu_userqueue_cleanup(struct amdgpu_userq_mgr *uq=
_mgr,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uq_funcs-&gt;mqd_destroy(uq_mgr, queue);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0queue-&gt;fence_drv-&gt;fence_drv_xa_ptr =3D NULL=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_userq_fence_driver_free(queue);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0idr_remove(&amp;uq_mgr-&gt;userq_idr, queue_=
id);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(queue);<br>
&gt; diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_d=
rm.h<br>
&gt; index ef97c0d78b8a..2195810ae42d 100644<br>
&gt; --- a/include/uapi/drm/amdgpu_drm.h<br>
&gt; +++ b/include/uapi/drm/amdgpu_drm.h<br>
&gt; @@ -501,6 +501,12 @@ struct drm_amdgpu_userq_fence_info {<br>
&gt;=C2=A0 };<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 struct drm_amdgpu_userq_wait {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/**<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * @waitq_id: Queue handle used by the userq wait=
 IOCTL to retrieve the<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * wait queue and maintain the fence driver refer=
ences in it.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0__u32=C2=A0 =C2=A0waitq_id;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0__u32=C2=A0 =C2=A0pad;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/**<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * @syncobj_handles: The list of syncobj han=
dles submitted by the user queue<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * job to get the va/value pairs.<br>
<br>
</blockquote></div></div>

--000000000000a3e1070632c074ec--
