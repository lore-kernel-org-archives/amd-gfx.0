Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1371ECE564
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Sep 2024 09:57:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34CB210E0CA;
	Tue, 10 Sep 2024 09:57:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="DhcTdOMk";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 688EF10E0CA
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Sep 2024 09:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725962225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5PiDJuasXThJ7vbj/ldyoca5Jl01N0InxFIbiVHzjY0=;
 b=DhcTdOMktYvFvtRZHPRVgpXneAHLmUX2ztHiZEDrHEw5+0hZdBMFOqSB4r8o0WRyYQID4U
 a4sGTLDW8IciR78/Ays3S7UfZy5fQrgStU0NvgAloQc+eiBlJU+iRK0VcfJxRKKwOJuEr+
 eN0gBGWRHWW7IglrRpXgOgxuagGzhd4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-7vBF9P-YOuilwOfQQfP1fg-1; Tue, 10 Sep 2024 05:57:04 -0400
X-MC-Unique: 7vBF9P-YOuilwOfQQfP1fg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-374c44e58a9so2821595f8f.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Sep 2024 02:57:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725962223; x=1726567023;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6xmJDJHCrFEJG1w4322U2zHbVoLSbOK3ERE+KWCaag8=;
 b=FIWlaex2+5D7sWKDvusRElF8vaqAM/2vOZ0q2Agp7iOOXRy3cioqus2pyxOV5ohhDS
 NnMOPTRAX8StYiVsouPOIhxTmGVSc0Rs4Zv1IaKPZIu57P41Pm2BZLxgf6uugM5C3/AR
 Qhl9FfaRoDiUqQ2djxLtW8fZoJh/jUmjGD0q0ATgTM0cRjpBWwke326v104voyECyIdq
 C8LNyNhnFMCB73OKqRZKmIMzINL6YR+KUQneXnaeegkek0hB0OXRhBStdHy9GvGVW1F5
 qnF2PRN8v+JQHpiHLh68GnGezbGddbz6hOPKyYznlmAqPl3ZtMc2FOlG2GKNh82AUl2a
 z5uA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdfYJCrpxUALJjOzO2hRzL6tLs4Y5hV5AebxTcvTsQLwSRLrbRNt8MuCy518eQEBDVymIqGoWe@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwwmPv9RBvlRAQrvs+MLi7GFxRK90D/yyUW0ejVEXY4AOGzjXcN
 rJ6sQUtjL8bfycUN6JoL8d8+n45cTpSwuJ0GdMGD4Gc2rTUXMevCV6rJ3uWnXP3bvFCO/r05PIS
 6Rk53ccSMP3mqqE4Lr818q7ohly5tEo+5EdkGVNygKZM8j+A+FJh8MPwUkkwDrFE=
X-Received: by 2002:adf:a407:0:b0:374:c318:2188 with SMTP id
 ffacd0b85a97d-37889670950mr8629344f8f.42.1725962222728; 
 Tue, 10 Sep 2024 02:57:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQFd5NJamzzjdq+dxtvPLXnw545coT4h9RSKBn5pqWHp/OzlFLx8WTZz6cV76JxVC0FLq4dg==
X-Received: by 2002:adf:a407:0:b0:374:c318:2188 with SMTP id
 ffacd0b85a97d-37889670950mr8629320f8f.42.1725962222149; 
 Tue, 10 Sep 2024 02:57:02 -0700 (PDT)
Received: from eisenberg.fritz.box ([2001:16b8:3dba:4b00:6ba1:ad1b:2dfb:e2a2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378956dbf42sm8366725f8f.102.2024.09.10.02.57.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 02:57:01 -0700 (PDT)
Message-ID: <0f3309f2fee746879a941e45e63a67facbc98f6d.camel@redhat.com>
Subject: Re: [PATCH 5/8] drm/sched: Stop setting current entity in FIFO mode
From: Philipp Stanner <pstanner@redhat.com>
To: Tvrtko Ursulin <tursulin@igalia.com>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org
Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Christian
 =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Luben Tuikov <ltuikov89@gmail.com>, Matthew
 Brost <matthew.brost@intel.com>
Date: Tue, 10 Sep 2024 11:57:00 +0200
In-Reply-To: <20240909171937.51550-6-tursulin@igalia.com>
References: <20240909171937.51550-1-tursulin@igalia.com>
 <20240909171937.51550-6-tursulin@igalia.com>
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

On Mon, 2024-09-09 at 18:19 +0100, Tvrtko Ursulin wrote:
> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>=20
> It does not seem there is a need to set the current entity in FIFO
> mode
> since ot only serves as being a "cursor" in round-robin mode. Even if
> scheduling mode is changed at runtime the change in behaviour is
> simply
> to restart from the first entity, instead of continuing in RR mode
> from
> where FIFO left it, and that sounds completely fine.
>=20
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

I went through the code and agree that this looks good.

Reviewed-by: Philipp Stanner <pstanner@redhat.com>

> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Luben Tuikov <ltuikov89@gmail.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Philipp Stanner <pstanner@redhat.com>
> ---
> =C2=A0drivers/gpu/drm/scheduler/sched_main.c | 1 -
> =C2=A01 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c
> b/drivers/gpu/drm/scheduler/sched_main.c
> index 10abbcefe9d8..54c5fe7a7d1d 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -356,7 +356,6 @@ drm_sched_rq_select_entity_fifo(struct
> drm_gpu_scheduler *sched,
> =C2=A0=09=09=09=09return ERR_PTR(-ENOSPC);
> =C2=A0=09=09=09}
> =C2=A0
> -=09=09=09rq->current_entity =3D entity;
> =C2=A0=09=09=09reinit_completion(&entity->entity_idle);
> =C2=A0=09=09=09break;
> =C2=A0=09=09}

