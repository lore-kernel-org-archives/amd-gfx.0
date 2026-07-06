Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66AEAC43458
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2026 20:30:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1C8910EABA;
	Mon,  6 Jul 2026 20:30:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jveu8Lv1";
	dkim-atps=neutral
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F1B110EAB8
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jul 2026 20:29:59 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2cc7e132d3eso3230225ad.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Jul 2026 13:29:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783369799; cv=none;
 d=google.com; s=arc-20260327;
 b=oTkpAaMdoN61f0+WLc6rlr9KIDn3Czzjbmv47YfHRCcOVy3HE8ESo5Zm7kuRWisctM
 KqdvAWLxk3hdglQkg3plFrwgm8FGhH/buhGAS2IUcXhAbLWGrqpiPEQUpjpr0Tr2mqZH
 ZtDcmxirL4mFQzo3FTXubzkOebS0uBqWH4c2R/fwdZrSUO18gUlgXcOFfqZi1177APF7
 p6+U1h65hrbuqq1RikIG+UcKg/13Y8jdvXFEa7d5e4dZQXEbgOLDSAXmiFiW+n+bbE0j
 xk5QIOEspKOGnUQQhw5MYKvSyGzvx582WkV0f2hG7tXCUnlgoOaz656sesdyviGimZVt
 C1kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ZCaivyiBYiwd3GPhPAxEHpU25/jMo6srs2VZ6JIo6g0=;
 fh=6V9N+yFOEzkTQqjKCWoFYG+hEphx5u1JcDU/seLSECg=;
 b=skHq35RBWrT7iMGebHcBQbAZDW/GsQduNpb1OyM++pq8soBXGx4VDpSBW3U0Qin81+
 Y2EjDt5nUystDE2Yjn0xpWZJDLSuuJ1Mxn3vcglAhXWALj1VGStoBmOio+PDjVnK0K38
 lK3pjGDr5B65IXjYm3Wh5AGcxTP3K4h0YC+Ott41S2MTZaMHJmb8+yks7QQkqN8FxRtj
 AXdbpfrw+e6Txps9a2WsnnlqbS76xG4qX6pH4tzQY+y5gVfA//jAsnzXm2IcDEsAfXHK
 ymsUs0WKEx/e6PXy8qnw5/8/Mxcm4EE3R6i2Mlj/PzdQzB+IEbFc0qb5E4zcsmZPRcN/
 9Z6A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783369799; x=1783974599; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZCaivyiBYiwd3GPhPAxEHpU25/jMo6srs2VZ6JIo6g0=;
 b=jveu8Lv1k19ve1rHG5J7oUKMTPpBsiA/mMbhi9wieoGbYCaY+q4AHd/R5zdMXsR5we
 Gqd8npljAOZx3yG5qW42vuULXX5l7Gg9AQ3stxqlP8QXlgCkxdGKU3wRvzw8hQWcZw+w
 5Ikthyr9QGfKDHIzaAZGxIlcSyrjuVRlM140GuVDWLgx9MetlpXB2/71ZUpBKgHBr+Un
 bCP8l1ad3048CF/+jBsm87ePp9PRlMcL7xN6miraRU0iW+A86rVFaDen4lCfq6LW081k
 vAf3OMw1yvP3cCa+3+IHNZANIuNR8TWzOdUW4ULeAKiT1eeo6w+qjh4XY2YUxrM7ncQ2
 3qvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783369799; x=1783974599;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZCaivyiBYiwd3GPhPAxEHpU25/jMo6srs2VZ6JIo6g0=;
 b=K5PgAqZyN6/RAGnJwpZVyM0gUq27a/EgVs6KuNaJiZR1PdQ90vXjSlToEiLFjB7voB
 Q697zMlU2f7MhUz9CHzfS7iPe/1lVmWaX5D2e53w2Vhw2hmkUkOl8hmqaySAMhFLlfRF
 WXYkAJ5ImBP0bIlK8SvlM5lZ5vybBkBHdniUBMyeaKaA45GtYsNTTEGoS2eM9mGJDdjy
 UjhkZNgNeByJjYfrMQx6oluBmKKuC50aiB2+cBfTICVvnIHrSMe6G2Xglky6fvX8Ko5V
 BQjza3Ux4ahj8irVJ8AwoEBOEp56w3DpJaLcMpLeENITL6gObPi90xKS3F9CwT5LFMRB
 Db4w==
X-Forwarded-Encrypted: i=1;
 AHgh+RoUf2+kttxq/Ni7u80C3Pa+gUpMF4Dyj5QnQYvhfsLHEEdGg84AdNGXSYeOsKqaT3IbZ/150d3V@lists.freedesktop.org
X-Gm-Message-State: AOJu0YziqBkHxVdJ575NOKtSMWQV0ezeWSRTMStWkIdmMyWrKxE3PaLH
 7MQ6T9OJ0HZgwmRvXUUz0VTJ7hjAsgwBeon6NqlyoK0L9JV5BcUYTtZzx7vBbLwfrEziuHgKMhH
 ZQtceDO512bR0dcZwCWM46aL6ml7dHL0=
X-Gm-Gg: AfdE7ckazuZCAud8utMjdE0wrj1C9+A4i8/Ik9uw6RzE7i3snzTxFhWBgfrIKSXLoob
 Fwq+FYEBrT3RzRglPAILsSF4f+KY1fKEgFlWvdxqcj4+lAYuQrKLIIxn6J2mPTBSSf8DLfDUEem
 OTrM8oFgbExSyoYzSvECijK0MS25vUaeEwoOwoGFEBs/hNch0KTB48WzXxtbtgxqVu2im+AAuRT
 EZYKM01UEWNwzsXHvvfXDc/mOyTLJ5dFQExnOjoqKD6kjXlMkXp+4TlXrAdF3Kk4A2VBVJdeTtC
 1eg/9uCfDqLnOpUQQmySPR0Dd7q+GGSxatP4Hds3i8DjyqcgQnGh1cD7h3E=
X-Received: by 2002:a17:903:28e:b0:2ca:e860:197 with SMTP id
 d9443c01a7336-2cbb9f19800mr78073565ad.4.1783369798948; Mon, 06 Jul 2026
 13:29:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260611143326.2870571-1-srinivasan.shanmugam@amd.com>
 <20260611143326.2870571-6-srinivasan.shanmugam@amd.com>
 <IA0PR12MB8208F770F1FFB032BD4FCC42901B2@IA0PR12MB8208.namprd12.prod.outlook.com>
In-Reply-To: <IA0PR12MB8208F770F1FFB032BD4FCC42901B2@IA0PR12MB8208.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 6 Jul 2026 16:29:47 -0400
X-Gm-Features: AVVi8CfIKeI7whPNtBUE4olku5KM_25vXvuT_p76GjLtrYryB2ne2-gxOPYltF0
Message-ID: <CADnq5_PwGZom-1KcTDpH85ihL1BCerTU26uD_bv5MLrb+wE=ew@mail.gmail.com>
Subject: Re: [PATCH v12 5/5] drm/amdgpu: Use queue references for queue-aware
 EVENTFD subscriptions
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
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

On Thu, Jun 11, 2026 at 10:38=E2=80=AFAM SHANMUGAM, SRINIVASAN
<SRINIVASAN.SHANMUGAM@amd.com> wrote:
>
> Public
>
> RB was added by mistake onto this patch, this patch needs to be reviewed.
>
> Thanks in advance!
> Srini
>
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Srin=
ivasan
> > Shanmugam
> > Sent: Thursday, June 11, 2026 8:03 PM
> > To: Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander
> > <Alexander.Deucher@amd.com>
> > Cc: amd-gfx@lists.freedesktop.org; SHANMUGAM, SRINIVASAN
> > <SRINIVASAN.SHANMUGAM@amd.com>
> > Subject: [PATCH v12 5/5] drm/amdgpu: Use queue references for queue-awa=
re
> > EVENTFD subscriptions
> >
> > Queue-scoped EVENTFD subscriptions originally used queue_id as part of =
the
> > routing key. However, queue_id is only a UAPI-visible handle and can be=
 reused
> > after a queue is destroyed, making it unsuitable as a stable identifier=
 for internal
> > EVENTFD tracking.
> >
> > Rework queue-scoped EVENTFD handling to resolve queue_id to the
> > corresponding amdgpu_usermode_queue object in the ioctl path before cal=
ling into
> > the EVENTFD helpers. Resolve the eventfd file descriptor to an eventfd =
context in
> > the same place.
> >
> > EVENTFD subscriptions now store the actual queue pointer and eventfd co=
ntext
> > instead of the reusable queue identifier and raw eventfd file descripto=
r.
> >
> > Use the existing user queue refcounting infrastructure to keep queues a=
live while
> > EVENTFD subscriptions exist. Release those references during unbind, ma=
nager
> > teardown, and explicit queue cleanup.
> >
> > Introduce amdgpu_eventfd_remove_queue() to remove all subscriptions ass=
ociated
> > with a queue when that queue is removed from the USERQ manager. This pr=
events
> > EVENTFD from retaining stale queue references after queue removal.
> >
> > Queue-scoped subscriptions are matched using the queue pointer, while G=
PU-
> > scoped subscriptions continue to operate without an associated queue.
> >
> > Also validate supported event types, distinguish queue-scoped events fr=
om GPU-
> > scoped events, and allow eventfd file descriptor 0 by rejecting only ne=
gative values.
> >
> > EVENTFD remains notification-only and does not carry event payloads.
> >
> > v11: (per Christian)
> > - Convert queue_id to a queue pointer in the ioctl path before calling
> >   EVENTFD helpers.
> > - Convert the eventfd file descriptor to an eventfd context in the ioct=
l
> >   path before calling EVENTFD helpers.
> > - Store queue pointers in EVENTFD entries instead of reusable queue_id
> >   values.
> > - Add queue cleanup to remove EVENTFD subscriptions when queues are
> >   removed from the USERQ manager.
> >
> > v12:
> > - Remove explicit NULL checks before amdgpu_userq_put() and rely on the
> >   _put helper to handle NULL queue pointers. (Christian)
> >
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> > Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
It would be good to add proper kerneldoc for this interface as well.
Add a kerneldoc page that describes how userspace interacts with this
API.

Alex

> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c   | 146 ++++++++++++------
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h   |  17 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |  79 ++++++++--
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     |   6 +
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |   3 -
> >  .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |   1 +
> >  .../drm/amd/amdgpu/amdgpu_userq_internal.h    |  37 +++++
> >  7 files changed, 225 insertions(+), 64 deletions(-)  create mode 10064=
4
> > drivers/gpu/drm/amd/amdgpu/amdgpu_userq_internal.h
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c
> > index c777d563f1b5..7e90d9aad84e 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c
> > @@ -28,12 +28,15 @@
> >   * Event metadata/details are expected to be consumed separately throu=
gh the
> >   * corresponding wait/event path.
> >   *
> > + * Queue-scoped subscriptions store a refcounted queue pointer, not th=
e
> > + * reusable UAPI queue_id.
> >   */
> >
> >  #include <linux/slab.h>
> >  #include <linux/err.h>
> >
> >  #include "amdgpu_eventfd.h"
> > +#include "amdgpu_userq_internal.h"
> >
> >  #define AMDGPU_EVENTFD_MAX_BINDS 4096
> >
> > @@ -132,7 +135,7 @@ amdgpu_eventfd_id_get_or_create(struct
> > amdgpu_eventfd_mgr *mgr,
> >   *
> >   * The manager stores mappings:
> >   *
> > - *   event_id -> list of eventfds
> > + *   event_type -> list of eventfds
> >   *
> >   * The xarray provides efficient lookup of event type containers.
> >   */
> > @@ -168,6 +171,7 @@ void amdgpu_eventfd_mgr_fini(struct
> > amdgpu_eventfd_mgr *mgr)
> >
> >               hlist_for_each_entry_safe(e, tmp, &id->entries, hnode) {
> >                       hlist_del(&e->hnode);
> > +                     amdgpu_userq_put(e->queue);
> >                       eventfd_ctx_put(e->ctx);
> >                       kfree(e);
> >               }
> > @@ -180,55 +184,49 @@ void amdgpu_eventfd_mgr_fini(struct
> > amdgpu_eventfd_mgr *mgr)  }
> >
> >  /**
> > - * amdgpu_eventfd_bind - bind an eventfd to an event type
> > + * amdgpu_eventfd_bind - bind eventfd to an EVENTFD subscription
> >   * @mgr: eventfd manager
> >   * @event_type: kernel-defined AMDGPU event type
> > - * @eventfd: eventfd file descriptor
> > + * @queue: queue pointer for queue-scoped events, or NULL for
> > + GPU-scoped events
> > + * @ctx: eventfd context
> >   *
> > - * Register an eventfd subscription for the specified event type.
> > - * Duplicate subscriptions are treated as success.
> > + * The caller resolves queue_id to @queue and eventfd to @ctx before
> > + * calling this helper. This helper assumes ownership of the reference=
s
> > + * passed in. On success, the EVENTFD entry retains those references.
> > + * On duplicate binds or errors, the references are dropped before
> > + * returning.
> >   *
> >   * Return:
> >   * 0 on success or a negative error code.
> >   */
> >  int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mgr,
> > -                     u32 event_type, int eventfd)
> > +                     u32 event_type,
> > +                     struct amdgpu_usermode_queue *queue,
> > +                     struct eventfd_ctx *ctx)
> >  {
> >       struct amdgpu_eventfd_id *id;
> >       struct amdgpu_eventfd_entry *e =3D NULL, *it;
> > -     struct eventfd_ctx *ctx;
> >       unsigned long flags;
> >       bool dup =3D false;
> >       int r =3D 0; /* duplicate binds are treated as success */
> >
> > -     if (!mgr || !event_type || eventfd < 0)
> > +     if (!mgr || !event_type || !ctx)
> >               return -EINVAL;
> >
> > -     /*
> > -      * Enforce total bind limit without a separate manager lock.
> > -      * For duplicate binds, we decrement back before returning succes=
s.
> > -      */
> >       if (atomic_inc_return(&mgr->bind_count) >
> > AMDGPU_EVENTFD_MAX_BINDS) {
> > -             atomic_dec(&mgr->bind_count);
> > -             return -ENOSPC;
> > -     }
> > -
> > -     ctx =3D eventfd_ctx_fdget(eventfd);
> > -     if (IS_ERR(ctx)) {
> > -             atomic_dec(&mgr->bind_count);
> > -             return PTR_ERR(ctx);
> > +             r =3D -ENOSPC;
> > +             goto out_put_refs;
> >       }
> >
> >       id =3D amdgpu_eventfd_id_get_or_create(mgr, event_type);
> >       if (!id) {
> >               r =3D -ENOMEM;
> > -             goto out_put_ctx;
> > +             goto out_dec_bind_count;
> >       }
> >
> > -     /* check for duplicate binding */
> >       xa_lock_irqsave(&mgr->ids, flags);
> >       hlist_for_each_entry(it, &id->entries, hnode) {
> > -             if (it->ctx =3D=3D ctx) {
> > +             if (it->ctx =3D=3D ctx && it->queue =3D=3D queue) {
> >                       dup =3D true;
> >                       break;
> >               }
> > @@ -236,24 +234,24 @@ int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr
> > *mgr,
> >       xa_unlock_irqrestore(&mgr->ids, flags);
> >
> >       if (dup)
> > -             goto out_put_ctx; /* duplicate bind: success */
> > +             goto out_dec_bind_count;
> >
> > -     /* Allocate entry only after ctx/id prerequisites are satisfied. =
*/
> >       e =3D kzalloc(sizeof(*e), GFP_KERNEL);
> >       if (!e) {
> >               r =3D -ENOMEM;
> > -             goto out_put_ctx;
> > +             goto out_dec_bind_count;
> >       }
> >
> >       e->ctx =3D ctx;
> > +     e->queue =3D queue;
> >
> >       /*
> >        * Re-check duplicate under lock to close the race with another b=
ind()
> > -      * for the same event_type and eventfd context.
> > +      * for the same (event_type, queue, ctx).
> >        */
> >       xa_lock_irqsave(&mgr->ids, flags);
> >       hlist_for_each_entry(it, &id->entries, hnode) {
> > -             if (it->ctx =3D=3D ctx) {
> > +             if (it->ctx =3D=3D ctx && it->queue =3D=3D queue) {
> >                       dup =3D true;
> >                       break;
> >               }
> > @@ -262,6 +260,8 @@ int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr
> > *mgr,
> >       if (!dup) {
> >               hlist_add_head(&e->hnode, &id->entries);
> >               id->n_entries++;
> > +             queue =3D NULL;
> > +             ctx =3D NULL;
> >               e =3D NULL; /* consumed */
> >       }
> >       xa_unlock_irqrestore(&mgr->ids, flags); @@ -273,41 +273,43 @@ int
> > amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mgr,
> >
> >  out_free_entry:
> >       kfree(e);
> > -out_put_ctx:
> > -     eventfd_ctx_put(ctx);
> > +out_dec_bind_count:
> >       atomic_dec(&mgr->bind_count);
> > +out_put_refs:
> > +     amdgpu_userq_put(queue);
> > +     eventfd_ctx_put(ctx);
> >
> >       return r;
> >  }
> >
> >  /**
> > - * amdgpu_eventfd_unbind - remove an eventfd subscription
> > + * amdgpu_eventfd_unbind - remove an EVENTFD subscription
> >   * @mgr: eventfd manager
> >   * @event_type: kernel-defined AMDGPU event type
> > - * @eventfd: eventfd file descriptor
> > + * @queue: queue pointer for queue-scoped events, or NULL for
> > + GPU-scoped events
> > + * @ctx: eventfd context
> >   *
> > - * Remove an existing subscription for the specified event type.
> > + * The caller resolves queue_id to @queue and eventfd to @ctx before
> > + * calling this helper. This helper assumes ownership of the reference=
s
> > + * passed in and drops them before returning.
> >   *
> >   * Return:
> >   * 0 on success or a negative error code.
> >   */
> >  int amdgpu_eventfd_unbind(struct amdgpu_eventfd_mgr *mgr,
> > -                       u32 event_type, int eventfd)
> > +                       u32 event_type,
> > +                       struct amdgpu_usermode_queue *queue,
> > +                       struct eventfd_ctx *ctx)
> >  {
> >       struct amdgpu_eventfd_id *id;
> >       struct amdgpu_eventfd_entry *e;
> >       struct hlist_node *tmp;
> > -     struct eventfd_ctx *ctx;
> >       unsigned long flags;
> >       bool removed =3D false;
> >
> > -     if (!mgr || !event_type || eventfd < 0)
> > +     if (!mgr || !event_type || !ctx)
> >               return -EINVAL;
> >
> > -     ctx =3D eventfd_ctx_fdget(eventfd);
> > -     if (IS_ERR(ctx))
> > -             return PTR_ERR(ctx);
> > -
> >       xa_lock_irqsave(&mgr->ids, flags);
> >
> >       id =3D xa_load(&mgr->ids, event_type);
> > @@ -315,13 +317,14 @@ int amdgpu_eventfd_unbind(struct amdgpu_eventfd_m=
gr
> > *mgr,
> >               goto out_unlock;
> >
> >       hlist_for_each_entry_safe(e, tmp, &id->entries, hnode) {
> > -             if (e->ctx !=3D ctx)
> > +             if (e->ctx !=3D ctx || e->queue !=3D queue)
> >                       continue;
> >
> >               hlist_del(&e->hnode);
> >               id->n_entries--;
> >               removed =3D true;
> >
> > +             amdgpu_userq_put(e->queue);
> >               eventfd_ctx_put(e->ctx);
> >               kfree(e);
> >
> > @@ -338,21 +341,68 @@ int amdgpu_eventfd_unbind(struct amdgpu_eventfd_m=
gr
> > *mgr,
> >  out_unlock:
> >       xa_unlock_irqrestore(&mgr->ids, flags);
> >       eventfd_ctx_put(ctx);
> > +     amdgpu_userq_put(queue);
> >
> >       return removed ? 0 : -ENOENT;
> >  }
> >
> >  /**
> > - * amdgpu_eventfd_signal - signal all eventfds bound to an event type
> > + * amdgpu_eventfd_remove_queue - remove all EVENTFD bindings for a
> > + queue
> >   * @mgr: eventfd manager
> > - * @event_type: kernel-defined AMDGPU event type
> > + * @queue: queue being destroyed/released
> >   *
> > - * Notify all subscribers associated with the specified event type.
> > + * Remove all subscriptions that hold a reference to @queue.
> > + * This is called when the queue id is released so EVENTFD can drop
> > + * its queue references before the queue is finally destroyed.
> > + */
> > +void amdgpu_eventfd_remove_queue(struct amdgpu_eventfd_mgr *mgr,
> > +                              struct amdgpu_usermode_queue *queue) {
> > +     struct amdgpu_eventfd_id *id;
> > +     struct amdgpu_eventfd_entry *e;
> > +     struct hlist_node *tmp;
> > +     unsigned long index;
> > +     unsigned long flags;
> > +
> > +     if (!mgr || !queue)
> > +             return;
> > +
> > +     xa_lock_irqsave(&mgr->ids, flags);
> > +
> > +     xa_for_each(&mgr->ids, index, id) {
> > +             hlist_for_each_entry_safe(e, tmp, &id->entries, hnode) {
> > +                     if (e->queue !=3D queue)
> > +                             continue;
> > +
> > +                     hlist_del(&e->hnode);
> > +                     id->n_entries--;
> > +
> > +                     amdgpu_userq_put(e->queue);
> > +                     eventfd_ctx_put(e->ctx);
> > +                     kfree(e);
> > +
> > +                     atomic_dec(&mgr->bind_count);
> > +             }
> > +
> > +             if (!id->n_entries) {
> > +                     __xa_erase(&mgr->ids, index);
> > +                     kfree(id);
> > +             }
> > +     }
> > +
> > +     xa_unlock_irqrestore(&mgr->ids, flags); }
> > +
> > +/**
> > + * amdgpu_eventfd_signal - signal matching eventfd subscriptions
> > + * @mgr: eventfd manager
> > + * @event_type: kernel-defined AMDGPU event type
> > + * @queue: queue pointer for queue-scoped events, or NULL for
> > +GPU-scoped events
> >   *
> >   * Signaling is notification-only and does not carry additional payloa=
d.
> >   */
> >  void amdgpu_eventfd_signal(struct amdgpu_eventfd_mgr *mgr,
> > -                        u32 event_type)
> > +                        u32 event_type, struct amdgpu_usermode_queue *=
queue)
> >  {
> >       struct amdgpu_eventfd_id *id;
> >       struct amdgpu_eventfd_entry *e;
> > @@ -369,8 +419,10 @@ void amdgpu_eventfd_signal(struct amdgpu_eventfd_m=
gr
> > *mgr,
> >
> >       id =3D xa_load(&mgr->ids, event_type);
> >       if (id) {
> > -             hlist_for_each_entry(e, &id->entries, hnode)
> > -                     eventfd_signal(e->ctx);
> > +             hlist_for_each_entry(e, &id->entries, hnode) {
> > +                     if (e->queue =3D=3D queue)
> > +                             eventfd_signal(e->ctx);
> > +             }
> >       }
> >
> >       xa_unlock_irqrestore(&mgr->ids, flags); diff --git
> > a/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h
> > index e13b86240afc..8dbae07b0d84 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h
> > @@ -32,8 +32,11 @@
> >  #include <linux/eventfd.h>
> >  #include <linux/xarray.h>
> >
> > +struct amdgpu_usermode_queue;
> > +
> >  struct amdgpu_eventfd_entry {
> >       struct eventfd_ctx *ctx;
> > +     struct amdgpu_usermode_queue *queue;
> >       struct hlist_node hnode;
> >  };
> >
> > @@ -52,11 +55,19 @@ void amdgpu_eventfd_mgr_init(struct
> > amdgpu_eventfd_mgr *mgr);  void amdgpu_eventfd_mgr_fini(struct
> > amdgpu_eventfd_mgr *mgr);
> >
> >  int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mgr,
> > -                     u32 event_type, int eventfd);
> > +                     u32 event_type,
> > +                     struct amdgpu_usermode_queue *queue,
> > +                     struct eventfd_ctx *ctx);
> >  int amdgpu_eventfd_unbind(struct amdgpu_eventfd_mgr *mgr,
> > -                       u32 event_type, int eventfd);
> > +                       u32 event_type,
> > +                       struct amdgpu_usermode_queue *queue,
> > +                       struct eventfd_ctx *ctx);
> > +
> > +void amdgpu_eventfd_remove_queue(struct amdgpu_eventfd_mgr *mgr,
> > +                              struct amdgpu_usermode_queue *queue);
> >
> >  void amdgpu_eventfd_signal(struct amdgpu_eventfd_mgr *mgr,
> > -                        u32 event_type);
> > +                        u32 event_type,
> > +                        struct amdgpu_usermode_queue *queue);
> >
> >  #endif /* __AMDGPU_EVENTFD_H__ */
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > index 7cc54b7e3b81..3cb675a33945 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > @@ -46,6 +46,7 @@
> >  #include "amdgpu_reset.h"
> >  #include "amd_pcie.h"
> >  #include "amdgpu_userq.h"
> > +#include "amdgpu_userq_internal.h"
> >
> >  void amdgpu_unregister_gpu_instance(struct amdgpu_device *adev)  { @@ =
-
> > 634,11 +635,71 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *ad=
ev,
> >       return 0;
> >  }
> >
> > +static bool amdgpu_eventfd_queue_scoped(u32 event_type) {
> > +     switch (event_type) {
> > +     case DRM_AMDGPU_EVENT_TYPE_USERQ_EOP:
> > +     case DRM_AMDGPU_EVENT_TYPE_QUEUE_RESET:
> > +     case DRM_AMDGPU_EVENT_TYPE_SCRATCH:
> > +             return true;
> > +     default:
> > +             return false;
> > +     }
> > +}
> > +
> > +static bool amdgpu_eventfd_valid_type(u32 event_type) {
> > +     switch (event_type) {
> > +     case DRM_AMDGPU_EVENT_TYPE_USERQ_EOP:
> > +     case DRM_AMDGPU_EVENT_TYPE_QUEUE_RESET:
> > +     case DRM_AMDGPU_EVENT_TYPE_MEMORY_EXCEPTION:
> > +     case DRM_AMDGPU_EVENT_TYPE_SCRATCH:
> > +     case DRM_AMDGPU_EVENT_TYPE_GPU_RESET:
> > +             return true;
> > +     default:
> > +             return false;
> > +     }
> > +}
> > +
> > +static int amdgpu_eventfd_get_refs(struct amdgpu_fpriv *fpriv,
> > +                                struct drm_amdgpu_eventfd *args,
> > +                                struct amdgpu_usermode_queue **queue,
> > +                                struct eventfd_ctx **ctx)
> > +{
> > +     *queue =3D NULL;
> > +     *ctx =3D NULL;
> > +
> > +     if (!amdgpu_eventfd_valid_type(args->event_type))
> > +             return -EINVAL;
> > +
> > +     if (amdgpu_eventfd_queue_scoped(args->event_type)) {
> > +             if (!args->queue_id)
> > +                     return -EINVAL;
> > +
> > +             *queue =3D amdgpu_userq_get(&fpriv->userq_mgr, args->queu=
e_id);
> > +             if (!*queue)
> > +                     return -ENOENT;
> > +     } else if (args->queue_id) {
> > +             return -EINVAL;
> > +     }
> > +
> > +     *ctx =3D eventfd_ctx_fdget(args->eventfd);
> > +     if (IS_ERR(*ctx)) {
> > +             amdgpu_userq_put(*queue);
> > +             return PTR_ERR(*ctx);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> >  int amdgpu_eventfd_ioctl(struct drm_device *dev, void *data,
> >                        struct drm_file *file_priv)
> >  {
> >       struct amdgpu_fpriv *fpriv =3D file_priv->driver_priv;
> >       struct drm_amdgpu_eventfd *args =3D data;
> > +     struct amdgpu_usermode_queue *queue;
> > +     struct eventfd_ctx *ctx;
> > +     int r;
> >
> >       if (!fpriv)
> >               return -EINVAL;
> > @@ -649,24 +710,20 @@ int amdgpu_eventfd_ioctl(struct drm_device *dev, =
void
> > *data,
> >       if (args->flags || !args->event_type || args->eventfd < 0)
> >               return -EINVAL;
> >
> > -     /*
> > -      * Queue-scoped subscriptions are enabled by the later
> > -      * queue-reference routing patch. Until then, keep
> > -      * queue_id zero.
> > -      */
> > -     if (args->queue_id)
> > -             return -EINVAL;
> > +     r =3D amdgpu_eventfd_get_refs(fpriv, args, &queue, &ctx);
> > +     if (r)
> > +             return r;
> >
> >       switch (args->op) {
> >       case DRM_AMDGPU_EVENTFD_OP_BIND:
> >               return amdgpu_eventfd_bind(&fpriv->eventfd_mgr,
> > -                                        args->event_type,
> > -                                        args->eventfd);
> > +                                        args->event_type, queue, ctx);
> >       case DRM_AMDGPU_EVENTFD_OP_UNBIND:
> >               return amdgpu_eventfd_unbind(&fpriv->eventfd_mgr,
> > -                                          args->event_type,
> > -                                          args->eventfd);
> > +                                          args->event_type, queue, ctx=
);
> >       default:
> > +             amdgpu_userq_put(queue);
> > +             eventfd_ctx_put(ctx);
> >               return -EINVAL;
> >       }
> >  }
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > index 427c09c83d6b..b77385e35e4e 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > @@ -33,6 +33,7 @@
> >  #include "amdgpu_userq.h"
> >  #include "amdgpu_hmm.h"
> >  #include "amdgpu_userq_fence.h"
> > +#include "amdgpu_userq_internal.h"
> >
> >  /*
> >   * Get the per-file eventfd manager associated with this userq manager=
.
> > @@ -872,6 +873,8 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void=
 *data,
> >               if (!queue)
> >                       return -ENOENT;
> >
> > +             amdgpu_eventfd_remove_queue(&fpriv->eventfd_mgr, queue);
> > +
> >               amdgpu_userq_put(queue);
> >               break;
> >       }
> > @@ -1232,6 +1235,9 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mg=
r
> > *userq_mgr)
> >               if (!queue)
> >                       break;
> >
> > +
> >       amdgpu_eventfd_remove_queue(amdgpu_userq_eventfd_mgr(userq_mgr),
> > +                                         queue);
> > +
> >               amdgpu_userq_put(queue);
> >       }
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> > index 8c4b55517a0a..e1a7d0dbc436 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> > @@ -144,9 +144,6 @@ struct amdgpu_db_info {
> >       struct amdgpu_userq_obj *db_obj;
> >  };
> >
> > -struct amdgpu_usermode_queue *amdgpu_userq_get(struct amdgpu_userq_mgr
> > *uq_mgr, u32 qid); -void amdgpu_userq_put(struct amdgpu_usermode_queue
> > *queue);
> > -
> >  int amdgpu_userq_ioctl(struct drm_device *dev, void *data, struct drm_=
file *filp);
> >
> >  int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct d=
rm_file
> > *file_priv, diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.=
c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> > index 008330a0d852..8795156270f2 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> > @@ -31,6 +31,7 @@
> >
> >  #include "amdgpu.h"
> >  #include "amdgpu_userq_fence.h"
> > +#include "amdgpu_userq_internal.h"
> >
> >  #define AMDGPU_USERQ_MAX_HANDLES     (1U << 16)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_internal.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_internal.h
> > new file mode 100644
> > index 000000000000..f41ec9167581
> > --- /dev/null
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_internal.h
> > @@ -0,0 +1,37 @@
> > +/*
> > + * Copyright 2026 Advanced Micro Devices, Inc.
> > + *
> > + * Permission is hereby granted, free of charge, to any person
> > +obtaining a
> > + * copy of this software and associated documentation files (the
> > +"Software"),
> > + * to deal in the Software without restriction, including without
> > +limitation
> > + * the rights to use, copy, modify, merge, publish, distribute,
> > +sublicense,
> > + * and/or sell copies of the Software, and to permit persons to whom
> > +the
> > + * Software is furnished to do so, subject to the following conditions=
:
> > + *
> > + * The above copyright notice and this permission notice shall be
> > +included in
> > + * all copies or substantial portions of the Software.
> > + *
> > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY
> > KIND,
> > +EXPRESS OR
> > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> > +MERCHANTABILITY,
> > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN
> > NO EVENT
> > +SHALL
> > + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY
> > CLAIM,
> > +DAMAGES OR
> > + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> > +OTHERWISE,
> > + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR
> > THE USE
> > +OR
> > + * OTHER DEALINGS IN THE SOFTWARE.
> > + *
> > + */
> > +
> > +#ifndef __AMDGPU_USERQ_INTERNAL_H__
> > +#define __AMDGPU_USERQ_INTERNAL_H__
> > +
> > +#include <linux/types.h>
> > +
> > +struct amdgpu_userq_mgr;
> > +struct amdgpu_usermode_queue;
> > +
> > +struct amdgpu_usermode_queue *
> > +amdgpu_userq_get(struct amdgpu_userq_mgr *userq_mgr, u32 queue_id);
> > +
> > +void amdgpu_userq_put(struct amdgpu_usermode_queue *queue);
> > +
> > +#endif /* __AMDGPU_USERQ_INTERNAL_H__ */
> > --
> > 2.34.1
>
