Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8755ECE57B
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Sep 2024 08:47:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64E3010E334;
	Mon,  9 Sep 2024 08:47:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="CmmvlXBy";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35B7F10E335
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Sep 2024 08:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725871660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=REa2YtSNPKEgV+iVjb5MY20wP/9OgvEiBZOC+QtDWWk=;
 b=CmmvlXByHvVmDRW5vlj/UrqQlGXyMd0ilI4jiwpS46sTZSeym33RZdzzlHMzoqN9maYVZx
 V0DMnqlXTZG7Qar8OMbsMyXSuFl4r0zPIsb5apvXAu/uTlhuBUiViEXKbXduvf1lxqtXec
 cq69T2JV/AmPWWcqk6cfwr0YgQ6AFms=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-G5NFJcgGOQuUEAi2sfPAeQ-1; Mon, 09 Sep 2024 04:47:39 -0400
X-MC-Unique: G5NFJcgGOQuUEAi2sfPAeQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42cae209243so13378175e9.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Sep 2024 01:47:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725871658; x=1726476458;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=REa2YtSNPKEgV+iVjb5MY20wP/9OgvEiBZOC+QtDWWk=;
 b=MjGdlV3U9fwMSTql6C0lYICzZzxu/vyl/x4TJsUg4rgNyHyh4/984xhOzXGcdHYo9P
 exVn1MUhDS4ebEIqUxstCZyL00HWjozHZe98E4uUT0vv/PPZlT2QbRhZEjA1u08JyBh6
 crYM8AFjJc4nXEgRaEza2ySQOaz8evtfawhf1a06IFg306kNHnN+gJJFutQZmt37zUEf
 LjKshpzmJC1+EBgomVbImcgi8b73KZnG7djqI69cCp0Jmn3umgqd/z7aC5TpSeUu4iOK
 UKLN38EWwDXosFMz3890/BzurEBuzjVb/ox2ezkrxaczFbhTQZm+sb9wwqSQaV8OcaXx
 Kayw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZg/82AGYwZg1N2oIohkjTi7c+qGqwdv+KAFFcTvx7pgahirFfsxSEWYLGQyY/xeA/SZbcffe6@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzRJS5pFEuxpJQd86UpKKPzRHGcVbrxgSxqv/9luOMBKBRnLr15
 BXdlZyPMeBZRRcnQ7MfrLNbs4ZmZxnBHO49Wi8d5O29BlwMYXPU8zS4+pOqeGEvxTBGg/ysYzJn
 1lOAtgEaXducWdtQVI9Kl0kFnPDAOvtFDtY8GxRMFYeuoaZHMdfzCPMD0iPg1wI8=
X-Received: by 2002:a05:6000:1286:b0:374:ba83:8d73 with SMTP id
 ffacd0b85a97d-378949ef80cmr3454471f8f.8.1725871657824; 
 Mon, 09 Sep 2024 01:47:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+fB8HpSRCfOtGoLKTf8mOFAvUUP4CCL5WFFcwiDUp/9hyyGQV+hgsu8BPBsxMUQBquLTCVw==
X-Received: by 2002:a05:6000:1286:b0:374:ba83:8d73 with SMTP id
 ffacd0b85a97d-378949ef80cmr3454450f8f.8.1725871657248; 
 Mon, 09 Sep 2024 01:47:37 -0700 (PDT)
Received: from [10.200.68.91] (nat-pool-muc-u.redhat.com. [149.14.88.27])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42cb0e30249sm53528075e9.1.2024.09.09.01.47.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 01:47:36 -0700 (PDT)
Message-ID: <3d9450d3a7334da47b0d3dd7b902be7dd9051a2d.camel@redhat.com>
Subject: Re: [RFC 0/4] DRM scheduler fixes, or not, or incorrect kind
From: Philipp Stanner <pstanner@redhat.com>
To: Tvrtko Ursulin <tursulin@igalia.com>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org
Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Christian
 =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Luben Tuikov <ltuikov89@gmail.com>, Matthew
 Brost <matthew.brost@intel.com>
Date: Mon, 09 Sep 2024 10:47:35 +0200
In-Reply-To: <20240906180618.12180-1-tursulin@igalia.com>
References: <20240906180618.12180-1-tursulin@igalia.com>
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

Hi,

On Fri, 2024-09-06 at 19:06 +0100, Tvrtko Ursulin wrote:
> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>=20
> In a recent conversation with Christian there was a thought that
> drm_sched_entity_modify_sched() should start using the entity-
> >rq_lock to be
> safe against job submission and simultaneous priority changes.

There are also FIXMEs in gpu_scheduler.h that might be related.

>=20
> The kerneldoc accompanying that function however is a bit unclear to
> me. For
> instance is amdgpu simply doing it wrongly by not serializing the two
> in the
> driver? Or is the comment referring to some other race condition than
> which is
> of concern in this series?
>=20
> To cut the long story short, first three patches try to fix this race
> in three
> places I *think* can manifest in different ways.
>=20
> Last patch is a trivial optimisation I spotted can be easily done.

I took a look and at least to me it doesn't appear to be that trivial,
mostly because it takes two locks.

Would you mind branching that out as a separate patch so that the
series would 100% address bugs?

P.=09

>=20
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Luben Tuikov <ltuikov89@gmail.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
>=20
> Tvrtko Ursulin (4):
> =C2=A0 drm/sched: Add locking to drm_sched_entity_modify_sched
> =C2=A0 drm/sched: Always wake up correct scheduler in
> =C2=A0=C2=A0=C2=A0 drm_sched_entity_push_job
> =C2=A0 drm/sched: Always increment correct scheduler score
> =C2=A0 drm/sched: Optimise drm_sched_entity_push_job
>=20
> =C2=A0drivers/gpu/drm/scheduler/sched_entity.c | 17 ++++++++++++-----
> =C2=A0drivers/gpu/drm/scheduler/sched_main.c=C2=A0=C2=A0 | 21 +++++++++++=
+++-------
> =C2=A0include/drm/gpu_scheduler.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> =C2=A03 files changed, 27 insertions(+), 12 deletions(-)
>=20

