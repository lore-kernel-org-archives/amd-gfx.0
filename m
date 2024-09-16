Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01AB5C3ABB2
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Sep 2024 08:16:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EF7D10E16B;
	Mon, 16 Sep 2024 08:16:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="GuPWisE1";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9211E10E097
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Sep 2024 08:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726474592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X9SZPQqVNZ+LpnL44lBJE+Mp94qpYJOtqq8/bcvSdwQ=;
 b=GuPWisE1akap5vZ3vo5KtSeN43jqU+SsmcNykMZb0w5FQGauUmV/CG/4JPqhMnEadD3M9S
 zaEao3FX39zSg4P0xXhXYUPdkOzeW2uLPXBsqzJVc17Jh/NvjR2zsZbQDVjkwOWs6MdpuE
 1Q5Euu5jYJbG/FRbpRVPovwwFnM8c7Y=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-339qyoE5NH6P4BDJ8rK6zg-1; Mon, 16 Sep 2024 04:16:28 -0400
X-MC-Unique: 339qyoE5NH6P4BDJ8rK6zg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-374c54e188dso2560739f8f.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Sep 2024 01:16:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726474588; x=1727079388;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ru+y90+/NDdm3ALQ4k8hpnsdZ4JCGl0gCU2htuaBc5Q=;
 b=xTRCIoFLikMybaP0V5TNw1v3O6kGYxc9DNWXuMMiFujFTuV74DEV83xNUc+YSn3AwJ
 EeAktly8nfyLffwoeI2XIzeqjCImXakmwZphSRxeZ1utM/3N5gd9jzJDnYpYizP2Zotw
 w6m5SCWj+f1obd65kAX31RAY9gHk8Q/goJhJuavBCtgFQIL1iDsqkZNNojzKuLoG3x3K
 y+hFzL8+Y7rcpnDQv4RSMaC1vsR7zQvzi2CEjtcdK/sOqnPgIj3m1IEB4R74iukYPsJl
 6siM0M6tQYzm4VkXcEKIajns4gvad0S4IB3ek3xkyuhoGH1zpA7vmCv5/ADscB1YrFPd
 Gi/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkQf30cjRjNyaWkbB1714HxO+GWjbAvw6+4XoQnpq3UQu+In/fjzIUO0mZ93/oqVQbdxL0SlqR@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzVLwIIvqbGURlJrFIGVMg8nwUd7iQsghzoKbmWGAttpwXNmAjJ
 psdd1iGIzaAs7rIryTCXqa79xeeAI8j6XW5ZaNcJQUjj+fNDrWPGYQzv/hkMU3HJIkFGdvMGAs2
 8hvGUXOakDti1yacch1v2ZvTrYqidRChGlcL3mClw2k10w63RbEqoVzLyBag2UG4=
X-Received: by 2002:adf:ef06:0:b0:374:c692:42e2 with SMTP id
 ffacd0b85a97d-378a8a0b8d9mr12166043f8f.9.1726474587638; 
 Mon, 16 Sep 2024 01:16:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3Pe7vB4fkiiwscsyI8XJ1gc3S/ZG6W0I9i8O0mpHG4jkRbDMGA+yNv3NCd/yNP/wC1oUJXQ==
X-Received: by 2002:adf:ef06:0:b0:374:c692:42e2 with SMTP id
 ffacd0b85a97d-378a8a0b8d9mr12166023f8f.9.1726474587085; 
 Mon, 16 Sep 2024 01:16:27 -0700 (PDT)
Received: from eisenberg.fritz.box ([2001:16b8:3d97:9600:c4de:e8e2:392:1c61])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378e73e81a5sm6503395f8f.34.2024.09.16.01.16.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2024 01:16:26 -0700 (PDT)
Message-ID: <f193ac6e13c9069eacf3498e1df41c97577c58e4.camel@redhat.com>
Subject: Re: [PATCH 6/8] drm/sched: Re-order struct drm_sched_rq members for
 clarity
From: Philipp Stanner <pstanner@redhat.com>
To: Tvrtko Ursulin <tursulin@igalia.com>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Luben Tuikov <ltuikov89@gmail.com>, Matthew
 Brost <matthew.brost@intel.com>
Date: Mon, 16 Sep 2024 10:16:25 +0200
In-Reply-To: <20240913160559.49054-7-tursulin@igalia.com>
References: <20240913160559.49054-1-tursulin@igalia.com>
 <20240913160559.49054-7-tursulin@igalia.com>
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

On Fri, 2024-09-13 at 17:05 +0100, Tvrtko Ursulin wrote:
> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>=20
> Current kerneldoc for struct drm_sched_rq incompletely documents what
> fields are protected by the lock.
>=20
> This is not good because it is misleading.
>=20
> Lets fix it by listing all the elements which are protected by the
> lock.
>=20
> While at it, lets also re-order the members so all protected by the
> lock
> are in a single group.
>=20
> v2:
> =C2=A0* Refer variables by kerneldoc syntax, more verbose commit text.
> (Philipp)
>=20
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Luben Tuikov <ltuikov89@gmail.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Philipp Stanner <pstanner@redhat.com>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Looks good, thx

Reviewed-by: Philipp Stanner <pstanner@redhat.com>


> ---
> =C2=A0include/drm/gpu_scheduler.h | 10 ++++++----
> =C2=A01 file changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/include/drm/gpu_scheduler.h
> b/include/drm/gpu_scheduler.h
> index 38465b78c7d5..2f58af00f792 100644
> --- a/include/drm/gpu_scheduler.h
> +++ b/include/drm/gpu_scheduler.h
> @@ -243,10 +243,10 @@ struct drm_sched_entity {
> =C2=A0/**
> =C2=A0 * struct drm_sched_rq - queue of entities to be scheduled.
> =C2=A0 *
> - * @lock: to modify the entities list.
> =C2=A0 * @sched: the scheduler to which this rq belongs to.
> - * @entities: list of the entities to be scheduled.
> + * @lock: protects @entities, @rb_tree_root and @current_entity.

nit: in case you'll provide a new version anyways you could consider
sorting these three to be congruent with the lines below.

Thank you!
P.


> =C2=A0 * @current_entity: the entity which is to be scheduled.
> + * @entities: list of the entities to be scheduled.
> =C2=A0 * @rb_tree_root: root of time based priory queue of entities for
> FIFO scheduling
> =C2=A0 *
> =C2=A0 * Run queue is a set of entities scheduling command submissions fo=
r
> @@ -254,10 +254,12 @@ struct drm_sched_entity {
> =C2=A0 * the next entity to emit commands from.
> =C2=A0 */
> =C2=A0struct drm_sched_rq {
> -=09spinlock_t=09=09=09lock;
> =C2=A0=09struct drm_gpu_scheduler=09*sched;
> -=09struct list_head=09=09entities;
> +
> +=09spinlock_t=09=09=09lock;
> +=09/* Following members are protected by the @lock: */
> =C2=A0=09struct drm_sched_entity=09=09*current_entity;
> +=09struct list_head=09=09entities;
> =C2=A0=09struct rb_root_cached=09=09rb_tree_root;
> =C2=A0};
> =C2=A0

