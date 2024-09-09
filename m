Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E794ECE57B
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Sep 2024 09:51:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B64BD10E361;
	Mon,  9 Sep 2024 09:51:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="P2yNn4V7";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3BAE10E2F7
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Sep 2024 09:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725875509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/ayd7IleCwsO+FnPkJR5KHxukDOZi4foXR3Bb3l4R1g=;
 b=P2yNn4V7Z2/B59LQ0lRkt1yxl9Hwe+tzrI0WZshTaApBwlGINg4wD5yliGhRGiDcPIHD2w
 LQTcLy54LN3hb28ou/kpihmyiZCI1jMi0CImyZoXOXJHBIHDlC5zcRPM3Lb10DU0k7TkDc
 vkmmO01048l13utPrYc+hDu9dswfEXA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548--oDIWi9SPs6rK15NRTz2Ug-1; Mon, 09 Sep 2024 05:51:48 -0400
X-MC-Unique: -oDIWi9SPs6rK15NRTz2Ug-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-374bb1e931cso2516664f8f.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Sep 2024 02:51:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725875507; x=1726480307;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=m+Tbw+vwPqAwjyalWaaJ8tVR88aCGFVgkshL4vXUNzo=;
 b=reu2maSKB47fSAXNsa0sF4D0tqVeLnhy05UBRm8g8eg/bNSoXKZKl7ta/gqjiEkngl
 6BHHSVkC8itsmydGfflFyX/r0LMbs5C0zwSTprwzmEdywGFGvbZTuPnifwYvBcovFsUn
 AIYi5ygRZry11yj10HdMTEN/9E5KWWtE5bqqEF73Buowyxo4l4HVSbWAviHrDF4UoVWd
 yIeSlrwz4a4EJMg8RuVnO/+yVWWoj35O7miD3dGOW8BlbG4ElYbo1u9XI4OSmz2uQWF/
 nZh1xYSGRlCIQzLUHf3icq5M6wsfTr8Sx0Ob1pzJhKyc1JVAA7gPPKM109UE12OXEZzM
 fmOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDPzm24Ul9gpsttqFWiz+0DTSpglXUbrECra7bFDTS17TUL41bgBmK+PC6O45JoNFSCb8E0LrD@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy6BbVRjXrAsJKzCm2su6q940hopSk8ITVP5Pu+4QwtnzHn8ujx
 lzd0+lD1+U289HQLqCi7nFDzfaZHMXpUqhmOkx8nQaKYHTIS6f0Bpf/cYGJ3rmslWVJLWQ0882V
 tKMOQ+/d2aG3H0aPG4pjWL/tVtDH4RbF4be4+kSAjhuPEWBBj2/3LP7RXsKAI+Zk=
X-Received: by 2002:adf:f2c7:0:b0:374:c157:a84a with SMTP id
 ffacd0b85a97d-378885dfa6dmr6447739f8f.16.1725875507538; 
 Mon, 09 Sep 2024 02:51:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGO/5zepFCrbxUqLeH1UXU2lnxmqLq6D4IEGIZA56a9vh4xBHhJLHcdXgd1cWD/A0n6hc7YGA==
X-Received: by 2002:adf:f2c7:0:b0:374:c157:a84a with SMTP id
 ffacd0b85a97d-378885dfa6dmr6447716f8f.16.1725875507060; 
 Mon, 09 Sep 2024 02:51:47 -0700 (PDT)
Received: from dhcp-64-8.muc.redhat.com (nat-pool-muc-t.redhat.com.
 [149.14.88.26]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378956dd932sm5549616f8f.98.2024.09.09.02.51.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 02:51:46 -0700 (PDT)
Message-ID: <ee0e0294c2af5a651cc3a28404cde23df764bb43.camel@redhat.com>
Subject: Re: [RFC 2/4] drm/sched: Always wake up correct scheduler in
 drm_sched_entity_push_job
From: Philipp Stanner <pstanner@redhat.com>
To: Tvrtko Ursulin <tursulin@igalia.com>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org
Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Christian
 =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Luben Tuikov <ltuikov89@gmail.com>, Matthew
 Brost <matthew.brost@intel.com>, David Airlie <airlied@gmail.com>, Daniel
 Vetter <daniel@ffwll.ch>, stable@vger.kernel.org
Date: Mon, 09 Sep 2024 11:51:45 +0200
In-Reply-To: <20240906180618.12180-3-tursulin@igalia.com>
References: <20240906180618.12180-1-tursulin@igalia.com>
 <20240906180618.12180-3-tursulin@igalia.com>
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

On Fri, 2024-09-06 at 19:06 +0100, Tvrtko Ursulin wrote:
> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>=20
> Since drm_sched_entity_modify_sched() can modify the entities run
> queue
> lets make sure to only derefernce the pointer once so both adding and
> waking up are guaranteed to be consistent.
>=20
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Fixes: b37aced31eb0 ("drm/scheduler: implement a function to modify
> sched list")
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Luben Tuikov <ltuikov89@gmail.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v5.7+
> ---
> =C2=A0drivers/gpu/drm/scheduler/sched_entity.c | 8 ++++++--
> =C2=A01 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c
> b/drivers/gpu/drm/scheduler/sched_entity.c
> index ae8be30472cd..62b07ef7630a 100644
> --- a/drivers/gpu/drm/scheduler/sched_entity.c
> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> @@ -599,6 +599,8 @@ void drm_sched_entity_push_job(struct
> drm_sched_job *sched_job)
> =C2=A0
> =C2=A0=09/* first job wakes up scheduler */
> =C2=A0=09if (first) {
> +=09=09struct drm_sched_rq *rq;
> +
> =C2=A0=09=09/* Add the entity to the run queue */
> =C2=A0=09=09spin_lock(&entity->rq_lock);
> =C2=A0=09=09if (entity->stopped) {
> @@ -608,13 +610,15 @@ void drm_sched_entity_push_job(struct
> drm_sched_job *sched_job)
> =C2=A0=09=09=09return;
> =C2=A0=09=09}
> =C2=A0
> -=09=09drm_sched_rq_add_entity(entity->rq, entity);
> +=09=09rq =3D entity->rq;
> +
> +=09=09drm_sched_rq_add_entity(rq, entity);
> =C2=A0=09=09spin_unlock(&entity->rq_lock);
> =C2=A0
> =C2=A0=09=09if (drm_sched_policy =3D=3D DRM_SCHED_POLICY_FIFO)
> =C2=A0=09=09=09drm_sched_rq_update_fifo(entity, submit_ts);
> =C2=A0
> -=09=09drm_sched_wakeup(entity->rq->sched, entity);
> +=09=09drm_sched_wakeup(rq->sched, entity);

OK, I think that makes sense. But I'd mention that the more readable
solution of moving the spin_unlock() down here cannot be done because
drm_sched_rq_update_fifo() needs that same lock.

P.

> =C2=A0=09}
> =C2=A0}
> =C2=A0EXPORT_SYMBOL(drm_sched_entity_push_job);

