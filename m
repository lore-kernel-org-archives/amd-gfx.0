Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FE05ECE57A
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Sep 2024 13:41:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C8BE10E583;
	Mon,  9 Sep 2024 13:41:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="VtbNU9GL";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C59DD10E583
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Sep 2024 13:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725889262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Th3ZR3EL1plv5t9bnbhjvduRXVqLRDu6yA89xIZ+JNc=;
 b=VtbNU9GLvVXLrDeTWudyzEjsr+cj8B6zbByXSNSmsUxDY1lbCUvk3JUGfEJYTTxsuCArxV
 zmsqHIPFNXqKtQah3VvGxCHrW/GYXm/w4KF+Oun3fqaUvuMLu5hSJyzIEdvMh0HF59MXUT
 v6uiaeksF8AM/8FxjlpAH2fdeXgGrwU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-e55_Qar7OtKUGnmjpVenRA-1; Mon, 09 Sep 2024 09:41:01 -0400
X-MC-Unique: e55_Qar7OtKUGnmjpVenRA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-374cd315c68so2653242f8f.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Sep 2024 06:41:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725889260; x=1726494060;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kRT4RGVSoW78yOsC/Y7gv9msChIjfBCcI5oKX4lypl8=;
 b=rPxEwXycTEMZ+/BtP82ZWutSibt7nee3XYoeH+HA+QTmtQLMqqFOLKVgnH6+yqY1Td
 1/6hNTEBhbUM4gPgYgBJp1wmDJpoPXf3XfwN2bsF2UQdz0pIwrnmxuM9LZRlS9SSih4L
 foSOV5ExjHm6k9ipbdznbm5xv2KAE3+K7s3svTFPAxkK8kMt5HebOXrSfqS9PXXvFu0V
 CD9TxB/cQMOeoWytD8iW+zWx6OVMwicns+p66JA2fIHpYRYLPwrliYBPAAUdBo8mlxd6
 mGYy2OTMMXmgWSMv53bmDrPZolD4BglwlKBcmZOlJCzP3m4aeoB7uX7M8w9FCtSXVBo8
 omyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBqvaRGA3oQLltGQFahHSZUPnKCqGyq4JmBPqI4MSWgM3+xM6Uxu75F0c5AE00BpYzMWq+eY6t@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzvHqIHnmJ6J3owQOtcLjZAyRy31HbbiOFi5uV4XeKP/kxwmWoX
 f4fsSHIArzT12UC8gcrnPqXqM1f6sUdT+DGWFEMiPL2ihx4j3Cb8j/Sy61ZQql2HI58e9e+XHXY
 RhdTPrv5V34uhKTcHRwbkdyrfAMEXf4czJ1LphmCQMw1d+168nYvVWNS9LAqBfBw=
X-Received: by 2002:adf:f38b:0:b0:374:c847:859 with SMTP id
 ffacd0b85a97d-37894a6b15dmr4073461f8f.54.1725889260407; 
 Mon, 09 Sep 2024 06:41:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpHrLlqrLCC/C9OzpjJS85NonzndADR4+sBGv0pOLpgNEZxs4Hgk1jmN1WiQIH+0KN4RFJBg==
X-Received: by 2002:adf:f38b:0:b0:374:c847:859 with SMTP id
 ffacd0b85a97d-37894a6b15dmr4073453f8f.54.1725889259813; 
 Mon, 09 Sep 2024 06:40:59 -0700 (PDT)
Received: from dhcp-64-8.muc.redhat.com (nat-pool-muc-t.redhat.com.
 [149.14.88.26]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378956654e8sm6085882f8f.41.2024.09.09.06.40.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 06:40:59 -0700 (PDT)
Message-ID: <3d361fc62a43dde95ce31185470d3a153c648909.camel@redhat.com>
Subject: Re: [RFC 1/4] drm/sched: Add locking to drm_sched_entity_modify_sched
From: Philipp Stanner <pstanner@redhat.com>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Christian
 =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>, Tvrtko Ursulin <tursulin@igalia.com>, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>, Luben Tuikov
 <ltuikov89@gmail.com>,  Matthew Brost <matthew.brost@intel.com>, David
 Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 stable@vger.kernel.org
Date: Mon, 09 Sep 2024 15:40:58 +0200
In-Reply-To: <1848b0fc-7031-46f2-b7f8-f7c086fb00ce@igalia.com>
References: <20240906180618.12180-1-tursulin@igalia.com>
 <20240906180618.12180-2-tursulin@igalia.com>
 <8d763e5162ebc130a05da3cefbff148cdb6ce042.camel@redhat.com>
 <80e02cde-19e7-4fb6-a572-fb45a639a3b7@amd.com>
 <2356e3d66da3e5795295267e527042ab44f192c8.camel@redhat.com>
 <fb9556a1-b48d-49ed-9b9c-74b21fb76af4@amd.com>
 <14ef37f4-b982-41c1-8121-80882917e9c0@igalia.com>
 <d8944e6ad57e4efcd480d917a38f9cee9475d59c.camel@redhat.com>
 <1848b0fc-7031-46f2-b7f8-f7c086fb00ce@igalia.com>
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

On Mon, 2024-09-09 at 14:27 +0100, Tvrtko Ursulin wrote:
>=20
> On 09/09/2024 13:46, Philipp Stanner wrote:
> > On Mon, 2024-09-09 at 13:37 +0100, Tvrtko Ursulin wrote:
> > >=20
> > > On 09/09/2024 13:18, Christian K=C3=B6nig wrote:
> > > > Am 09.09.24 um 14:13 schrieb Philipp Stanner:
> > > > > On Mon, 2024-09-09 at 13:29 +0200, Christian K=C3=B6nig wrote:
> > > > > > Am 09.09.24 um 11:44 schrieb Philipp Stanner:
> > > > > > > On Fri, 2024-09-06 at 19:06 +0100, Tvrtko Ursulin wrote:
> > > > > > > > From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> > > > > > > >=20
> > > > > > > > Without the locking amdgpu currently can race
> > > > > > > > amdgpu_ctx_set_entity_priority() and
> > > > > > > > drm_sched_job_arm(),
> > > > > > > I would explicitly say "amdgpu's
> > > > > > > amdgpu_ctx_set_entity_priority()
> > > > > > > races
> > > > > > > through drm_sched_entity_modify_sched() with
> > > > > > > drm_sched_job_arm()".
> > > > > > >=20
> > > > > > > The actual issue then seems to be drm_sched_job_arm()
> > > > > > > calling
> > > > > > > drm_sched_entity_select_rq(). I would mention that, too.
> > > > > > >=20
> > > > > > >=20
> > > > > > > > leading to the
> > > > > > > > latter accesing potentially inconsitent entity-
> > > > > > > > >sched_list
> > > > > > > > and
> > > > > > > > entity->num_sched_list pair.
> > > > > > > >=20
> > > > > > > > The comment on drm_sched_entity_modify_sched() however
> > > > > > > > says:
> > > > > > > >=20
> > > > > > > > """
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0* Note that this must be called und=
er the same
> > > > > > > > common
> > > > > > > > lock for
> > > > > > > > @entity as
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0* drm_sched_job_arm() and
> > > > > > > > drm_sched_entity_push_job(),
> > > > > > > > or the
> > > > > > > > driver
> > > > > > > > needs to
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0* guarantee through some other mean=
s that this is
> > > > > > > > never
> > > > > > > > called
> > > > > > > > while
> > > > > > > > new jobs
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0* can be pushed to @entity.
> > > > > > > > """
> > > > > > > >=20
> > > > > > > > It is unclear if that is referring to this race or
> > > > > > > > something
> > > > > > > > else.
> > > > > > > That comment is indeed a bit awkward. Both
> > > > > > > drm_sched_entity_push_job()
> > > > > > > and drm_sched_job_arm() take rq_lock. But
> > > > > > > drm_sched_entity_modify_sched() doesn't.
> > > > > > >=20
> > > > > > > The comment was written in 981b04d968561. Interestingly,
> > > > > > > in
> > > > > > > drm_sched_entity_push_job(), this "common lock" is
> > > > > > > mentioned
> > > > > > > with
> > > > > > > the
> > > > > > > soft requirement word "should" and apparently is more
> > > > > > > about
> > > > > > > keeping
> > > > > > > sequence numbers in order when inserting.
> > > > > > >=20
> > > > > > > I tend to think that the issue discovered by you is
> > > > > > > unrelated
> > > > > > > to
> > > > > > > that
> > > > > > > comment. But if no one can make sense of the comment,
> > > > > > > should
> > > > > > > it
> > > > > > > maybe
> > > > > > > be removed? Confusing comment is arguably worse than no
> > > > > > > comment
> > > > > > Agree, we probably mixed up in 981b04d968561 that
> > > > > > submission
> > > > > > needs a
> > > > > > common lock and that rq/priority needs to be protected by
> > > > > > the
> > > > > > rq_lock.
> > > > > >=20
> > > > > > There is also the big FIXME in the drm_sched_entity
> > > > > > documentation
> > > > > > pointing out that this is most likely not implemented
> > > > > > correctly.
> > > > > >=20
> > > > > > I suggest to move the rq, priority and rq_lock fields
> > > > > > together
> > > > > > in the
> > > > > > drm_sched_entity structure and document that rq_lock is
> > > > > > protecting
> > > > > > the two.
> > > > > That could also be a great opportunity for improving the lock
> > > > > naming:
> > > >=20
> > > > Well that comment made me laugh because I point out the same
> > > > when
> > > > the
> > > > scheduler came out ~8years ago and nobody cared about it since
> > > > then.
> > > >=20
> > > > But yeah completely agree :)
> > >=20
> > > Maybe, but we need to keep in sight the fact some of these fixes
> > > may
> > > be
> > > good to backport. In which case re-naming exercises are best left
> > > to
> > > follow.
> >=20
> > My argument basically. It's good if fixes and other improvements
> > are
> > separated, in general, unless there is a practical / good reason
> > not
> > to.
>=20
> Ah cool, I am happy to add follow up patches after the fixes.
>=20
> > > Also..
> > >=20
> > > > > void drm_sched_rq_update_fifo(struct drm_sched_entity
> > > > > *entity,
> > > > > ktime_t
> > > > > ts)
> > > > > {
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Both locks need to be grabbed, o=
ne to protect from
> > > > > entity-
> > > > > > rq
> > > > > change
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * for entity from within concurren=
t
> > > > > drm_sched_entity_select_rq
> > > > > and the
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * other to update the rb tree stru=
cture.
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0spin_lock(&entity->rq_lock);
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0spin_lock(&entity->rq->lock);
> > >=20
> > > .. I agree this is quite unredable and my initial reaction was a
> > > similar
> > > ugh. However.. What names would you guys suggest and for what to
> > > make
> > > this better and not lessen the logic of naming each individually?
> >=20
> > According to the documentation, drm_sched_rq.lock does not protect
> > the
> > entire runque, but "@lock: to modify the entities list."
> >=20
> > So I would keep drm_sched_entity.rq_lock as it is, because it
> > indeed
> > protects the entire runqueue.
>=20
> Agreed on entity->rq_lock.
>=20
> > And drm_sched_rq.lock could be named "entities_lock" or
> > "entities_list_lock" or something. That's debatable, but it should
> > be
> > something that highlights that this lock is not for locking the
> > entire
> > runque as the one in the entity apparently is.
>=20
> AFAICT it also protects rq->current_entity and rq->rb_tree_root in
> which=20
> case it is a bit more tricky.

Then in any case we'll also have to update the documentation snippet I
had quoted above.

btw. I'm not saying you have to do all of that; I'm also currently
working on some additional scheduler documentation.

>  Only rq->sched is outside its scope. Hm.=20
> Maybe just re-arrange the struct to be like:
>=20
> struct drm_sched_rq {
> =09struct drm_gpu_scheduler=09*sched;
>=20
> =09spinlock_t=09=09=09lock;
> =09/* Following members are protected by the @lock: */
> =09struct list_head=09=09entities;
> =09struct drm_sched_entity=09=09*current_entity;
> =09struct rb_root_cached=09=09rb_tree_root;
> };
>=20
> I have no ideas for better naming.

Hmmm. Difficult.

Maybe rq_outer_lock <-> rq_inner_lock or "partial" and "whole".

Explains why no one ever bothered renaming it.

>  But this would be inline with=20
> Christian's suggestion for tidying the order in drm_sched_entity.
>=20
> I am also not sure what is the point of setting rq->current_entity in
> drm_sched_rq_select_entity_fifo().

It seems to me that current_entity is only used (read) in
drm_sched_rq_remove_entity() and drm_sched_rq_select_entity_rr(). It=20
seems to be only really useful for the RR function?

drm_sched_rq_select_entity_fifo() was added later, in 08fb97de03aa2,
and it's very likely that the author oriented himself at the RR
function. So it's possible it's actually not needed and was just copied
by accident.


P.

>=20
> Regards,
>=20
> Tvrtko
>=20
> >=20
> >=20
> > Cheers,
> > P.
> >=20
> > >=20
> > > Regards,
> > >=20
> > > Tvrtko
> > >=20
> > > > > [...]
> > > > >=20
> > > > >=20
> > > > > P.
> > > > >=20
> > > > >=20
> > > > > > Then audit the code if all users of rq and priority
> > > > > > actually
> > > > > > hold the
> > > > > > correct locks while reading and writing them.
> > > > > >=20
> > > > > > Regards,
> > > > > > Christian.
> > > > > >=20
> > > > > > > P.
> > > > > > >=20
> > > > > > > > Signed-off-by: Tvrtko Ursulin
> > > > > > > > <tvrtko.ursulin@igalia.com>
> > > > > > > > Fixes: b37aced31eb0 ("drm/scheduler: implement a
> > > > > > > > function
> > > > > > > > to
> > > > > > > > modify
> > > > > > > > sched list")
> > > > > > > > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > > > > > > > Cc: Alex Deucher <alexander.deucher@amd.com>
> > > > > > > > Cc: Luben Tuikov <ltuikov89@gmail.com>
> > > > > > > > Cc: Matthew Brost <matthew.brost@intel.com>
> > > > > > > > Cc: David Airlie <airlied@gmail.com>
> > > > > > > > Cc: Daniel Vetter <daniel@ffwll.ch>
> > > > > > > > Cc: dri-devel@lists.freedesktop.org
> > > > > > > > Cc: <stable@vger.kernel.org> # v5.7+
> > > > > > > > ---
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0drivers/gpu/drm/scheduler/sched_ent=
ity.c | 2 ++
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A01 file changed, 2 insertions(+)
> > > > > > > >=20
> > > > > > > > diff --git a/drivers/gpu/drm/scheduler/sched_entity.c
> > > > > > > > b/drivers/gpu/drm/scheduler/sched_entity.c
> > > > > > > > index 58c8161289fe..ae8be30472cd 100644
> > > > > > > > --- a/drivers/gpu/drm/scheduler/sched_entity.c
> > > > > > > > +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> > > > > > > > @@ -133,8 +133,10 @@ void
> > > > > > > > drm_sched_entity_modify_sched(struct
> > > > > > > > drm_sched_entity *entity,
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0{
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WARN_ON(!num_sch=
ed_list || !sched_list);
> > > > > > > > +=C2=A0=C2=A0=C2=A0 spin_lock(&entity->rq_lock);
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 entity->sched_li=
st =3D sched_list;
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 entity->num_sche=
d_list =3D num_sched_list;
> > > > > > > > +=C2=A0=C2=A0=C2=A0 spin_unlock(&entity->rq_lock);
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0}
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0EXPORT_SYMBOL(drm_sched_entity_modi=
fy_sched);
> > > >=20
> > >=20
> >=20
>=20

