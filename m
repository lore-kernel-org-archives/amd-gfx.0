Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DA16CCF9E9
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Sep 2024 08:16:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 064D710E042;
	Thu, 26 Sep 2024 08:16:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="NzyIBgt8";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE7A010E042
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Sep 2024 08:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727338562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jkE98gTtDfNr5GfMuftp4G9EJP69laL9HOqoZTWYEH4=;
 b=NzyIBgt8LxKeBm7PkwFy0UF+ciwZquoVTjRA0D46byz16J8XLZ+IzyF9vlMIH0VOUXAIX9
 V00UFsu6e/7Hsil39nmLoJdBTe6fBsTtEUj1a5IPaC8+gVSm5Xu2O2qhmcpCZzuQVHj6bM
 fongz5g5FTdpHpwOWbmPjEPIoBdQ4dw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-6HkrhnVqP9iHyOmhVlY1Vg-1; Thu, 26 Sep 2024 04:16:01 -0400
X-MC-Unique: 6HkrhnVqP9iHyOmhVlY1Vg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42cb9e14ab6so4408145e9.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Sep 2024 01:16:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727338560; x=1727943360;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Q+PB1bX63yvpVUwHd1p8kcnlGkK65hhrsf8Uv72pc7E=;
 b=uHfQAfpmqyRbKBcFScgs4Nz6quJ4bZH/A8+9WThxRh1LcJF+G2e1uHHURflJg6nl/i
 Gttvv1KTiEw+crUr8ZqKKberY38aVk2q7L+2iDUR8wJm7ydiazBx0cq4eaxYbq73j6aO
 UYmRAL2dUZpiSszOZ2HfsBUyw6NhYjhHOnN93A5OrVsuf4kfRe2AUfRVb+2EKNQ/DUpU
 LKfWxYs+58oBxDZyTcdFDO+T4qHi2IfmVD7AkB19q+RxgerB5NaNKit/CXALetM0IDi3
 yiqpqptbWFxERNwEmsogDMk/FVWWyAagkxLD4DEwC6lZTlCDZhm6ekBnA1pfrruxdDga
 Aonw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWusLR/GMeyCDgjqX7KpcagNUg/0CoIdUEx3pbDYdCCXvWEHLSPERWfMPWKpTqjNmWRv+zeeUl7@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxuopOzTI2pqHVwg8pLB9FspZbgB0WrxdXhCIJEQapAV5pnOBBT
 ph7TMyaGju9hiuLZR19WBDmTNC3qXj61goktb7MRBEUVC1gL8ep3Vd7ZP7DZB7Ka92LadWxD/L/
 oZZwyLIXhQakNiGTD6+sTPOT+Q+wdXLVwNkQRkGliVWRBMr6uWJZCrui7QTv9cTk=
X-Received: by 2002:a05:600c:1d28:b0:42c:cd7c:a196 with SMTP id
 5b1f17b1804b1-42e9611d114mr43907395e9.17.1727338559961; 
 Thu, 26 Sep 2024 01:15:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwymqbtplHXtGKps6e8X68XchcCU8AuujFE6kob4eddrzwCgTX6kD4e43/wdKG6NNCah1n6g==
X-Received: by 2002:a05:600c:1d28:b0:42c:cd7c:a196 with SMTP id
 5b1f17b1804b1-42e9611d114mr43907165e9.17.1727338559472; 
 Thu, 26 Sep 2024 01:15:59 -0700 (PDT)
Received: from eisenberg.fritz.box ([2001:16b8:3dee:bc00:37ec:5f5c:23da:fb5f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e969ddb64sm40042255e9.8.2024.09.26.01.15.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 01:15:59 -0700 (PDT)
Message-ID: <a5dd98b71891ea0392d61e24cde8b35051035780.camel@redhat.com>
Subject: Re: [PATCH v2] drm/sched: Further optimise drm_sched_entity_push_job
From: Philipp Stanner <pstanner@redhat.com>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Tvrtko Ursulin
 <tursulin@igalia.com>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Luben
 Tuikov <ltuikov89@gmail.com>, Matthew Brost <matthew.brost@intel.com>
Date: Thu, 26 Sep 2024 10:15:58 +0200
In-Reply-To: <1650ecb9-ac8a-4199-8693-77c73a95bbbd@igalia.com>
References: <20240913160559.49054-9-tursulin@igalia.com>
 <20240916173007.118-1-tursulin@igalia.com>
 <1650ecb9-ac8a-4199-8693-77c73a95bbbd@igalia.com>
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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

On Mon, 2024-09-23 at 15:35 +0100, Tvrtko Ursulin wrote:
>=20
> Ping Christian and Philipp - reasonably happy with v2? I think it's
> the=20
> only unreviewed patch from the series.

Howdy,

sry for the delay, I had been traveling.

I have a few nits below regarding the commit message. Besides, I'm OK
with that, thx for your work :)

>=20
> Regards,
>=20
> Tvrtko
>=20
> On 16/09/2024 18:30, Tvrtko Ursulin wrote:
> > From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> >=20
> > Having removed one re-lock cycle on the entity->lock in a patch
> > titled
> > "drm/sched: Optimise drm_sched_entity_push_job",=C2=A0
> > with only a tiny bit
> > larger refactoring we can do the same optimisation=C2=A0

Well, the commit message does not state which optimization that is. One
would have to look for the previous patch, which you apparently cannot
provide a commit ID for yet because it's not in Big Boss's branch.

In this case I am for including a sentence about what is being
optimized also because

> > on the rq->lock.
> > (Currently both drm_sched_rq_add_entity() and
> > drm_sched_rq_update_fifo_locked() take and release the same lock.)
> >=20
> > To achieve this we make drm_sched_rq_update_fifo_locked() and

it's not clear what the "this" that's being achieved is.

> > drm_sched_rq_add_entity() expect the rq->lock to be held.
> >=20
> > We also align drm_sched_rq_update_fifo_locked(),
> > drm_sched_rq_add_entity() and
> > drm_sched_rq_remove_fifo_locked() function signatures, by adding rq
> > as a
> > parameter to the latter.
> >=20
> > v2:
> > =C2=A0 * Fix after rebase of the series.
> > =C2=A0 * Avoid naming incosistency between drm_sched_rq_add/remove.
> > (Christian)
> >=20
> > Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Reviewed-by: Philipp Stanner <pstanner@redhat.com>

> > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: Luben Tuikov <ltuikov89@gmail.com>
> > Cc: Matthew Brost <matthew.brost@intel.com>
> > Cc: Philipp Stanner <pstanner@redhat.com>
> > ---
> > =C2=A0 drivers/gpu/drm/scheduler/sched_entity.c | 12 ++++++++--
> > =C2=A0 drivers/gpu/drm/scheduler/sched_main.c=C2=A0=C2=A0 | 29 ++++++++=
++++-------
> > -----
> > =C2=A0 include/drm/gpu_scheduler.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 ++-
> > =C2=A0 3 files changed, 26 insertions(+), 18 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/scheduler/sched_entity.c
> > b/drivers/gpu/drm/scheduler/sched_entity.c
> > index d982cebc6bee..8ace1f1ea66b 100644
> > --- a/drivers/gpu/drm/scheduler/sched_entity.c
> > +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> > @@ -515,9 +515,14 @@ struct drm_sched_job
> > *drm_sched_entity_pop_job(struct drm_sched_entity *entity)
> > =C2=A0=20
> > =C2=A0=C2=A0=09=09next =3D to_drm_sched_job(spsc_queue_peek(&entity-
> > >job_queue));
> > =C2=A0=C2=A0=09=09if (next) {
> > +=09=09=09struct drm_sched_rq *rq;
> > +
> > =C2=A0=C2=A0=09=09=09spin_lock(&entity->lock);
> > -=09=09=09drm_sched_rq_update_fifo_locked(entity,
> > +=09=09=09rq =3D entity->rq;
> > +=09=09=09spin_lock(&rq->lock);
> > +=09=09=09drm_sched_rq_update_fifo_locked(entity,
> > rq,
> > =C2=A0=C2=A0=09=09=09=09=09=09=09next-
> > >submit_ts);
> > +=09=09=09spin_unlock(&rq->lock);
> > =C2=A0=C2=A0=09=09=09spin_unlock(&entity->lock);
> > =C2=A0=C2=A0=09=09}
> > =C2=A0=C2=A0=09}
> > @@ -618,11 +623,14 @@ void drm_sched_entity_push_job(struct
> > drm_sched_job *sched_job)
> > =C2=A0=C2=A0=09=09sched =3D rq->sched;
> > =C2=A0=20
> > =C2=A0=C2=A0=09=09atomic_inc(sched->score);
> > +
> > +=09=09spin_lock(&rq->lock);
> > =C2=A0=C2=A0=09=09drm_sched_rq_add_entity(rq, entity);
> > =C2=A0=20
> > =C2=A0=C2=A0=09=09if (drm_sched_policy =3D=3D DRM_SCHED_POLICY_FIFO)
> > -=09=09=09drm_sched_rq_update_fifo_locked(entity,
> > submit_ts);
> > +=09=09=09drm_sched_rq_update_fifo_locked(entity,
> > rq, submit_ts);
> > =C2=A0=20
> > +=09=09spin_unlock(&rq->lock);
> > =C2=A0=C2=A0=09=09spin_unlock(&entity->lock);
> > =C2=A0=20
> > =C2=A0=C2=A0=09=09drm_sched_wakeup(sched, entity);
> > diff --git a/drivers/gpu/drm/scheduler/sched_main.c
> > b/drivers/gpu/drm/scheduler/sched_main.c
> > index 18a952f73ecb..5c83fb92bb89 100644
> > --- a/drivers/gpu/drm/scheduler/sched_main.c
> > +++ b/drivers/gpu/drm/scheduler/sched_main.c
> > @@ -153,17 +153,18 @@ static __always_inline bool
> > drm_sched_entity_compare_before(struct rb_node *a,
> > =C2=A0=C2=A0=09return ktime_before(ent_a->oldest_job_waiting, ent_b-
> > >oldest_job_waiting);
> > =C2=A0 }
> > =C2=A0=20
> > -static inline void drm_sched_rq_remove_fifo_locked(struct
> > drm_sched_entity *entity)
> > +static void drm_sched_rq_remove_fifo_locked(struct

I think the commit message should contain a short sentence about why
you removed the inline.

AKA "As we're at it, remove the inline function specifier from
drm_sched_rq_remove_fifo_locked() because XYZ"


P.

> > drm_sched_entity *entity,
> > +=09=09=09=09=09=C2=A0=C2=A0=C2=A0 struct drm_sched_rq
> > *rq)
> > =C2=A0 {
> > -=09struct drm_sched_rq *rq =3D entity->rq;
> > -
> > =C2=A0=C2=A0=09if (!RB_EMPTY_NODE(&entity->rb_tree_node)) {
> > =C2=A0=C2=A0=09=09rb_erase_cached(&entity->rb_tree_node, &rq-
> > >rb_tree_root);
> > =C2=A0=C2=A0=09=09RB_CLEAR_NODE(&entity->rb_tree_node);
> > =C2=A0=C2=A0=09}
> > =C2=A0 }
> > =C2=A0=20
> > -void drm_sched_rq_update_fifo_locked(struct drm_sched_entity
> > *entity, ktime_t ts)
> > +void drm_sched_rq_update_fifo_locked(struct drm_sched_entity
> > *entity,
> > +=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0 struct drm_sched_rq *rq,
> > +=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0 ktime_t ts)
> > =C2=A0 {
> > =C2=A0=C2=A0=09/*
> > =C2=A0=C2=A0=09 * Both locks need to be grabbed, one to protect from
> > entity->rq change
> > @@ -171,17 +172,14 @@ void drm_sched_rq_update_fifo_locked(struct
> > drm_sched_entity *entity, ktime_t ts
> > =C2=A0=C2=A0=09 * other to update the rb tree structure.
> > =C2=A0=C2=A0=09 */
> > =C2=A0=C2=A0=09lockdep_assert_held(&entity->lock);
> > +=09lockdep_assert_held(&rq->lock);
> > =C2=A0=20
> > -=09spin_lock(&entity->rq->lock);
> > -
> > -=09drm_sched_rq_remove_fifo_locked(entity);
> > +=09drm_sched_rq_remove_fifo_locked(entity, rq);
> > =C2=A0=20
> > =C2=A0=C2=A0=09entity->oldest_job_waiting =3D ts;
> > =C2=A0=20
> > -=09rb_add_cached(&entity->rb_tree_node, &entity->rq-
> > >rb_tree_root,
> > +=09rb_add_cached(&entity->rb_tree_node, &rq->rb_tree_root,
> > =C2=A0=C2=A0=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm_sched_entity_compa=
re_before);
> > -
> > -=09spin_unlock(&entity->rq->lock);
> > =C2=A0 }
> > =C2=A0=20
> > =C2=A0 /**
> > @@ -213,15 +211,14 @@ static void drm_sched_rq_init(struct
> > drm_gpu_scheduler *sched,
> > =C2=A0 void drm_sched_rq_add_entity(struct drm_sched_rq *rq,
> > =C2=A0=C2=A0=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0 struct drm_sched_entity *=
entity)
> > =C2=A0 {
> > +=09lockdep_assert_held(&entity->lock);
> > +=09lockdep_assert_held(&rq->lock);
> > +
> > =C2=A0=C2=A0=09if (!list_empty(&entity->list))
> > =C2=A0=C2=A0=09=09return;
> > =C2=A0=20
> > -=09spin_lock(&rq->lock);
> > -
> > =C2=A0=C2=A0=09atomic_inc(rq->sched->score);
> > =C2=A0=C2=A0=09list_add_tail(&entity->list, &rq->entities);
> > -
> > -=09spin_unlock(&rq->lock);
> > =C2=A0 }
> > =C2=A0=20
> > =C2=A0 /**
> > @@ -235,6 +232,8 @@ void drm_sched_rq_add_entity(struct
> > drm_sched_rq *rq,
> > =C2=A0 void drm_sched_rq_remove_entity(struct drm_sched_rq *rq,
> > =C2=A0=C2=A0=09=09=09=09struct drm_sched_entity *entity)
> > =C2=A0 {
> > +=09lockdep_assert_held(&entity->lock);
> > +
> > =C2=A0=C2=A0=09if (list_empty(&entity->list))
> > =C2=A0=C2=A0=09=09return;
> > =C2=A0=20
> > @@ -247,7 +246,7 @@ void drm_sched_rq_remove_entity(struct
> > drm_sched_rq *rq,
> > =C2=A0=C2=A0=09=09rq->current_entity =3D NULL;
> > =C2=A0=20
> > =C2=A0=C2=A0=09if (drm_sched_policy =3D=3D DRM_SCHED_POLICY_FIFO)
> > -=09=09drm_sched_rq_remove_fifo_locked(entity);
> > +=09=09drm_sched_rq_remove_fifo_locked(entity, rq);
> > =C2=A0=20
> > =C2=A0=C2=A0=09spin_unlock(&rq->lock);
> > =C2=A0 }
> > diff --git a/include/drm/gpu_scheduler.h
> > b/include/drm/gpu_scheduler.h
> > index 80198e6cf537..b21806d5a8eb 100644
> > --- a/include/drm/gpu_scheduler.h
> > +++ b/include/drm/gpu_scheduler.h
> > @@ -596,7 +596,8 @@ void drm_sched_rq_add_entity(struct
> > drm_sched_rq *rq,
> > =C2=A0 void drm_sched_rq_remove_entity(struct drm_sched_rq *rq,
> > =C2=A0=C2=A0=09=09=09=09struct drm_sched_entity *entity);
> > =C2=A0=20
> > -void drm_sched_rq_update_fifo_locked(struct drm_sched_entity
> > *entity, ktime_t ts);
> > +void drm_sched_rq_update_fifo_locked(struct drm_sched_entity
> > *entity,
> > +=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0 struct drm_sched_rq *rq,
> > ktime_t ts);
> > =C2=A0=20
> > =C2=A0 int drm_sched_entity_init(struct drm_sched_entity *entity,
> > =C2=A0=C2=A0=09=09=09=C2=A0 enum drm_sched_priority priority,
>=20

