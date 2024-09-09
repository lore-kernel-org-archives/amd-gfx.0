Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46A6BECE57A
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Sep 2024 12:14:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6F1110E406;
	Mon,  9 Sep 2024 12:14:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="SCTuXv8k";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E99BC10E406
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Sep 2024 12:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725884038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DGXaupiBvlrrtQtHTXtD8BDwBLVb5uLvmxCBzgICBUE=;
 b=SCTuXv8k38WvmY0lE4kPPWio7JuLRu6KL47IgqlB2VBkmKnDLfw5PulKSHeZDK9caM/Qt/
 cnBgjfsXD5Bn0Ug703Kq4EktIvIKBau+OeQ/D7aw8hom57HPx7h8/S4ybfexBF8nyHOxhE
 tOtUj8JSDFrZrhFxSWselRxQSxfnJP8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-Hx9ua1ReNWK-XaSppJGFKQ-1; Mon, 09 Sep 2024 08:13:56 -0400
X-MC-Unique: Hx9ua1ReNWK-XaSppJGFKQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-374b9a8512dso2051829f8f.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Sep 2024 05:13:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725884033; x=1726488833;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bkATp1QtmV3cfFCcvxrwKHj5NzaYjxngX1fAPFVvMdU=;
 b=plfba7Dl76tGbo0J8mm6oIoUs0DG5no8xoJgTDBxKmPCpCnx6ZVxTh+lYZcDQsZAgK
 LJN683BxqJFGuU4YNal+KnQwd9PDu7jQGiMTcKjrhPoA8opRlrnMdVHC3udrIEAijKr5
 CmpQmoG20cORwN9el9+6hjjReqAql8fL1bt2H/QCn9A3+g5I9+rrBdCtH1wgQLpymXK3
 R2J1JJyUmNt2u7SPHryh7fkT3jSH/InL9U6Dw3373U7LUgmfwvGP9Z3W96wnKZlWO6J+
 rVhBfaRVumq+t7Uf+zzA3Wmi3NmoFOmYXchMVJ9EHPVWW+jWFnJE/AeDYRu4aQ9Infjj
 Idwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWA5UCB8Hfl+ZVuQP75tds+NcaXsUNZGkynmjykHvuzBj9AsXN0baNOm/lEaOaaN/8lGB3a+FV@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyx+nkKC52rSSHOx8viXSILV4qitsz71lpdGlFerVVcz+BACsHY
 V/JvsSNaB5pvy3IfNNpg3Fp5WWP3P8Vi8s8LVFjXg3P1I6QhakHEURMQXsV60nZXpWqdxTWZqT1
 CuoIoojkSFCF94RyGQewJ1zhuLDsXDh8BuC2C9yoZ82lPEj0bjRzBeHUVz0HHeUM=
X-Received: by 2002:adf:f34c:0:b0:367:9d05:cf1f with SMTP id
 ffacd0b85a97d-378895cafc0mr6687250f8f.14.1725884032742; 
 Mon, 09 Sep 2024 05:13:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgMPgGNVXT36LLq3lOi6IkAmkuKGmW1abkfOEOmlNebAx4FKPDNq5cQYQfDHfnz4n6zWNSAg==
X-Received: by 2002:adf:f34c:0:b0:367:9d05:cf1f with SMTP id
 ffacd0b85a97d-378895cafc0mr6687227f8f.14.1725884032182; 
 Mon, 09 Sep 2024 05:13:52 -0700 (PDT)
Received: from dhcp-64-8.muc.redhat.com (nat-pool-muc-t.redhat.com.
 [149.14.88.26]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378956de3d4sm5882267f8f.108.2024.09.09.05.13.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 05:13:51 -0700 (PDT)
Message-ID: <2356e3d66da3e5795295267e527042ab44f192c8.camel@redhat.com>
Subject: Re: [RFC 1/4] drm/sched: Add locking to drm_sched_entity_modify_sched
From: Philipp Stanner <pstanner@redhat.com>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Tvrtko
 Ursulin <tursulin@igalia.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Alex Deucher
 <alexander.deucher@amd.com>, Luben Tuikov <ltuikov89@gmail.com>, Matthew
 Brost <matthew.brost@intel.com>, David Airlie <airlied@gmail.com>, Daniel
 Vetter <daniel@ffwll.ch>, stable@vger.kernel.org
Date: Mon, 09 Sep 2024 14:13:50 +0200
In-Reply-To: <80e02cde-19e7-4fb6-a572-fb45a639a3b7@amd.com>
References: <20240906180618.12180-1-tursulin@igalia.com>
 <20240906180618.12180-2-tursulin@igalia.com>
 <8d763e5162ebc130a05da3cefbff148cdb6ce042.camel@redhat.com>
 <80e02cde-19e7-4fb6-a572-fb45a639a3b7@amd.com>
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

On Mon, 2024-09-09 at 13:29 +0200, Christian K=C3=B6nig wrote:
> Am 09.09.24 um 11:44 schrieb Philipp Stanner:
> > On Fri, 2024-09-06 at 19:06 +0100, Tvrtko Ursulin wrote:
> > > From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> > >=20
> > > Without the locking amdgpu currently can race
> > > amdgpu_ctx_set_entity_priority() and drm_sched_job_arm(),
> > I would explicitly say "amdgpu's amdgpu_ctx_set_entity_priority()
> > races
> > through drm_sched_entity_modify_sched() with drm_sched_job_arm()".
> >=20
> > The actual issue then seems to be drm_sched_job_arm() calling
> > drm_sched_entity_select_rq(). I would mention that, too.
> >=20
> >=20
> > > leading to the
> > > latter accesing potentially inconsitent entity->sched_list and
> > > entity->num_sched_list pair.
> > >=20
> > > The comment on drm_sched_entity_modify_sched() however says:
> > >=20
> > > """
> > > =C2=A0=C2=A0* Note that this must be called under the same common loc=
k for
> > > @entity as
> > > =C2=A0=C2=A0* drm_sched_job_arm() and drm_sched_entity_push_job(), or=
 the
> > > driver
> > > needs to
> > > =C2=A0=C2=A0* guarantee through some other means that this is never c=
alled
> > > while
> > > new jobs
> > > =C2=A0=C2=A0* can be pushed to @entity.
> > > """
> > >=20
> > > It is unclear if that is referring to this race or something
> > > else.
> > That comment is indeed a bit awkward. Both
> > drm_sched_entity_push_job()
> > and drm_sched_job_arm() take rq_lock. But
> > drm_sched_entity_modify_sched() doesn't.
> >=20
> > The comment was written in 981b04d968561. Interestingly, in
> > drm_sched_entity_push_job(), this "common lock" is mentioned with
> > the
> > soft requirement word "should" and apparently is more about keeping
> > sequence numbers in order when inserting.
> >=20
> > I tend to think that the issue discovered by you is unrelated to
> > that
> > comment. But if no one can make sense of the comment, should it
> > maybe
> > be removed? Confusing comment is arguably worse than no comment
>=20
> Agree, we probably mixed up in 981b04d968561 that submission needs a=20
> common lock and that rq/priority needs to be protected by the
> rq_lock.
>=20
> There is also the big FIXME in the drm_sched_entity documentation=20
> pointing out that this is most likely not implemented correctly.
>=20
> I suggest to move the rq, priority and rq_lock fields together in the
> drm_sched_entity structure and document that rq_lock is protecting
> the two.

That could also be a great opportunity for improving the lock naming:

void drm_sched_rq_update_fifo(struct drm_sched_entity *entity, ktime_t ts)
{
=09/*
=09 * Both locks need to be grabbed, one to protect from entity->rq change
=09 * for entity from within concurrent drm_sched_entity_select_rq and the
=09 * other to update the rb tree structure.
=09 */
=09spin_lock(&entity->rq_lock);
=09spin_lock(&entity->rq->lock);

[...]


P.


>=20
> Then audit the code if all users of rq and priority actually hold the
> correct locks while reading and writing them.
>=20
> Regards,
> Christian.
>=20
> >=20
> > P.
> >=20
> > > Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> > > Fixes: b37aced31eb0 ("drm/scheduler: implement a function to
> > > modify
> > > sched list")
> > > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > > Cc: Alex Deucher <alexander.deucher@amd.com>
> > > Cc: Luben Tuikov <ltuikov89@gmail.com>
> > > Cc: Matthew Brost <matthew.brost@intel.com>
> > > Cc: David Airlie <airlied@gmail.com>
> > > Cc: Daniel Vetter <daniel@ffwll.ch>
> > > Cc: dri-devel@lists.freedesktop.org
> > > Cc: <stable@vger.kernel.org> # v5.7+
> > > ---
> > > =C2=A0=C2=A0drivers/gpu/drm/scheduler/sched_entity.c | 2 ++
> > > =C2=A0=C2=A01 file changed, 2 insertions(+)
> > >=20
> > > diff --git a/drivers/gpu/drm/scheduler/sched_entity.c
> > > b/drivers/gpu/drm/scheduler/sched_entity.c
> > > index 58c8161289fe..ae8be30472cd 100644
> > > --- a/drivers/gpu/drm/scheduler/sched_entity.c
> > > +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> > > @@ -133,8 +133,10 @@ void drm_sched_entity_modify_sched(struct
> > > drm_sched_entity *entity,
> > > =C2=A0=C2=A0{
> > > =C2=A0=C2=A0=09WARN_ON(!num_sched_list || !sched_list);
> > > =C2=A0=20
> > > +=09spin_lock(&entity->rq_lock);
> > > =C2=A0=C2=A0=09entity->sched_list =3D sched_list;
> > > =C2=A0=C2=A0=09entity->num_sched_list =3D num_sched_list;
> > > +=09spin_unlock(&entity->rq_lock);
> > > =C2=A0=C2=A0}
> > > =C2=A0=C2=A0EXPORT_SYMBOL(drm_sched_entity_modify_sched);
> > > =C2=A0=20
>=20

