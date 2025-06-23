Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC00CC7115B
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Jun 2025 13:03:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE28E10E0B0;
	Mon, 23 Jun 2025 13:03:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bb26W2bF";
	dkim-atps=neutral
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19E0010E046
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jun 2025 11:06:10 +0000 (UTC)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-7426c44e014so3412797b3a.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jun 2025 04:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750676769; x=1751281569; darn=lists.freedesktop.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2FyM50vrom+RqosmExQiLKu/PFNh4Gib3mqfekANvh4=;
 b=bb26W2bFUH2y6SpyrfWM3Eo1nXBq/Wbt5xJvetfaXgcq4lLaMEY4RLYbnUh6/Y5Jo5
 2CWj3TzqYX38gGYUx1fmNVTLa0LYvPH8rutLHx7yB6GYDHIie+0kL6aX8he55e0hlqL8
 zrq5QXt0XJ4bqcSo+dm2enmqE/nij7RWWTD+DsXOckZNRV6uFsJAEFjoQqTAB8GJUSJY
 yZYl+XVxI3DRusWanByDbMU2rdPtGXAaCRXsMqrs6CNZ7vkO0VtdPWnwQOeHj81Y+Ef7
 nQu8RfkqnKlOknNcwvVkVa1WWqdRksIp8DpjDWDIaIvg5vcNPpF8se1g9wj/jvkX3ubF
 FUHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750676769; x=1751281569;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2FyM50vrom+RqosmExQiLKu/PFNh4Gib3mqfekANvh4=;
 b=nKmATSUFZBXKZed4hQFjQv+S2eNJQCKMfB/kD2D6To8DELv9HFmgK3RNLRgbyGeNNS
 K1P9ngszLoTE7T6iTZuSqoehUdoLnrAFpQxsizy/YpmoRUuZ2jStiqBmP5OcFcINBPyi
 yHJmdFs6+2dZz0rWmJ5T/UXQ/fOdfQC0D9yYOFmTIg9eT0bne6CNF0QSBvZgsneBkkBm
 WyjTCHarHzS3O07udBVv4O8a/+dEg8yWGYluKcfhQc0Pe4UdT/RSHYjrdWwixOwCwQwM
 puleg+OQ1vkPeTPxAuJSvlbE45G+yohkamWq1I4XlRVayGxW26gwUErb+7GXoCttkZVI
 NgLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+ikrLOUXvlz44A10/CR32pKKfqn2hAFZ0KqBXPUqSZEysfcHdG4jkb3AIrikNJRDeEHPkKDgB@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxNYR0bmhDgEbyBDGctzvYzXHV3N7zLxjm2iSeQ/F1sSrV9rNW3
 73CJUthh+GHQLh0/w0M0B1KKT+hSZrZfhiCJZaas3k2FFn3AqQ0IUx4B
X-Gm-Gg: ASbGnctj9858rPX7QTw/NKv0RSi1+qKw4snFsLxGdJQH2QsC7qAriklg78Kge1KxLbK
 WwOJl09TI/561JbfEl5BlUi8sEx50+9utpHbzVdrJMNkeeRa6/ArINTgNW0fc79ILqEZqAEPzXG
 IoLsTtxTzpL0FCawDY3RxjzxohRwvSMOteRTaFdQ4KECOKJzw5xBddXKkK5yD2/9eDDCJCkN2hF
 YYocgXA/MNuVhTfM20CAwP+TjhL1v656UlW2w+S77SjhwYR4tBC7cLvHojmh2PTVjD4IZ99B8Nm
 N/CCPBWtHB+Qbh2bT1geL9zS1QG/vZDLXVM1ZT/CpKgKiVq19sgE1suUsvEWXDorjbwDBQD2dHI
 O9yfdlIbRIEgAJQz18g==
X-Google-Smtp-Source: AGHT+IHmsuE7Yq1K9EgqWG4AoLF6e/KZcKeo0zUwZFvYcjklIU9FNvtpmOCXDKB2dYdXK8I8piMv+Q==
X-Received: by 2002:a05:6a21:1707:b0:21f:e92d:8e20 with SMTP id
 adf61e73a8af0-22026e6f2dfmr25191654637.31.1750676769376; 
 Mon, 23 Jun 2025 04:06:09 -0700 (PDT)
Received: from localhost (syn-047-229-141-083.res.spectrum.com.
 [47.229.141.83]) by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-7490a64b197sm8158226b3a.122.2025.06.23.04.06.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 04:06:08 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Jun 2025 04:06:07 -0700
Message-Id: <DATV4CAOHVGV.1UJ803EX21II6@gmail.com>
Cc: "Alex Deucher" <alexander.deucher@amd.com>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>
Subject: Re: [RFC PATCH] drm/amdgpu: Enable async flip for cursor planes
From: "Christopher Snowhill" <kode54@gmail.com>
To: "Christopher Snowhill" <chris@kode54.net>, <amd-gfx@lists.freedesktop.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250619125507.54384-1-kode54@gmail.com>
 <DARA1U86AS72.QOIEVZWCFPYC@kode54.net>
 <DATUOZZD8316.2INSL3KL5RA80@kode54.net>
In-Reply-To: <DATUOZZD8316.2INSL3KL5RA80@kode54.net>
X-Mailman-Approved-At: Mon, 23 Jun 2025 13:03:25 +0000
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

On Mon Jun 23, 2025 at 3:46 AM PDT, Christopher Snowhill wrote:
> On Fri Jun 20, 2025 at 3:10 AM PDT, Christopher Snowhill wrote:
>> Here's another alternative change, which may be more thorough. It does
>> seem to fix the issue, at least. The issue does indeed appear to be
>> no-op plane changes sent to the cursor plane.
>>
>> If anyone wants to propose style changes, and suggest a proper commit
>> message, if this is indeed a welcome fix for the problem, please let me
>> know.
>>
>> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_ato=
mic_uapi.c
>> index c2726af6698e..b741939698e8 100644
>> --- a/drivers/gpu/drm/drm_atomic_uapi.c
>> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
>> @@ -1087,17 +1087,22 @@ int drm_atomic_set_property(struct drm_atomic_st=
ate *state,
>>  			}
>>
>>  			/* ask the driver if this non-primary plane is supported */
>> -			if (plane->type !=3D DRM_PLANE_TYPE_PRIMARY) {
>> -				ret =3D -EINVAL;
>> +			else if (plane->type !=3D DRM_PLANE_TYPE_PRIMARY) {
>> +				ret =3D drm_atomic_plane_get_property(plane, plane_state,
>> +								    prop, &old_val);
>> +
>> +				if (ret || old_val !=3D prop_value) {
>> +					ret =3D -EINVAL;
>>
>> -				if (plane_funcs && plane_funcs->atomic_async_check)
>> -					ret =3D plane_funcs->atomic_async_check(plane, state, true);
>> +					if (plane_funcs && plane_funcs->atomic_async_check)
>> +						ret =3D plane_funcs->atomic_async_check(plane, state, true);
>>
>> -				if (ret) {
>> -					drm_dbg_atomic(prop->dev,
>> -						       "[PLANE:%d:%s] does not support async flips\n",
>> -						       obj->id, plane->name);
>> -					break;
>> +					if (ret) {
>> +						drm_dbg_atomic(prop->dev,
>> +							       "[PLANE:%d:%s] does not support async flips\n",
>> +							       obj->id, plane->name);
>> +						break;
>> +					}
>>  				}
>>  			}
>>  		}
>
> Upon further testing and reflection, I have come to the conclusion that
> this is indeed best handled by a kernel fix, rather than breaking user
> space.
>
> I attempted to work around this in wlroots, adjusting 0.18, 0.19, and
> 0.20 git with similar patches. First I attempted to stash all the
> written properties for the atomic code, storing an initial value of all
> 0xFE so it was always likely to write the first time, and only setting a
> property if it changed from the last commit.
>
> This resulted in whole commits breaking for one or both framebuffers
> until I ctrl-alt-fx switched to a tty and back again, and this would
> work again temporarily.
>
> So I went back to the drawing board and only withheld seemingly
> duplicate plane properties. This "worked", until I attempted to play a
> game, and then it started glitching spectacularly, and not updating at
> all if the game was doing direct scanout and vrr.
>
> Clearly this is wrong.
>
> The wlroots library queues up properties for each commit. On every
> commit where the cursor is disabled, it queues up both fb_id=3D0 and
> crtc_id=3D0. Every commit. Is this wrong? Should it only be queueing up
> the disablement properties once? It also queues up the full plane and
> hotspot properties when enabled, even if the cursor doesn't change
> position or appearance.

Probably should have CC'd the drm misc maintainers when I started poking
drm misc instead of amdgpu. Pity there isn't a list for that...
