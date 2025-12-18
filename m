Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A33ED66BB3
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Dec 2025 05:21:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34F6610E535;
	Thu, 18 Dec 2025 05:21:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IqCI0meA";
	dkim-atps=neutral
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com
 [209.85.210.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9905810E535
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Dec 2025 05:21:00 +0000 (UTC)
Received: by mail-ot1-f53.google.com with SMTP id
 46e09a7af769-7c730af8d69so143303a34.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Dec 2025 21:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766035260; x=1766640060; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IP2ImOjAX+l+7tQGNXFK+zr1JeycaSZhRaLCs8/TNP0=;
 b=IqCI0meAx17RCqYel5hRS53koDZt5xs6wsm++TnL1MPPKb0zlRx2CB8nKrvkeUILJM
 6M0BNkx8BxVQyestCfwDpT/XdIG3V/nv26olXXkf2Ano1jtabche7lNEcqltMweSstOw
 zAgmavEqJKgkdT+s4Ar8bCVV7zeTbqO/nhuw2IdgupCLT4wxxVCacOxNTRRKnyBuqTFF
 LMBjbYRucghZUG7LKsGRQpPMZ1HJ+4SLKWm33svFabetAP4hlXrnGMRDk6Iz5UN3hpbT
 +4xv8kYn6cvs/ujWtMErz8geOrCPK/2O6UAxjKdtIM6n3DptjqhhO3jX2pNt8EumX9fF
 l1ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766035260; x=1766640060;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IP2ImOjAX+l+7tQGNXFK+zr1JeycaSZhRaLCs8/TNP0=;
 b=DfVRoQ0hMj5X/xVejTCsnjIbK4KXvba4HkWCiMT0vyeaiKuySxi8zzROgUq2rF8lsE
 uZSK0lSnEW3rgsdTiMds4/XXfaifC3iPFIQdu2ytGD7atdRB+DaiyovqG0sgQ+NpdlhJ
 SWtoxUI/qTESwCh1+WyiZ3RfZByTAho72GrUPIRh1vx7uEJH3nekK7sCXA3PmooHgdtv
 QN+csONbMuRP2Jql1Arw5h6srEQroOMtA1hSZaqa0vgz0SYU2uw4IPz1qutPQnmCFdM3
 Aa5bApNGn2DPZgo8Z+tU5c12IqLJTxv9C4X8QoDgZmNOCeaK5Qwqi7+kiF6/mNzanGML
 Ws1g==
X-Gm-Message-State: AOJu0YxiJfp/KGHeB0jokV5VgFTpn7YDmsoySDE7knUEmVJLanMD3dA0
 fdHpoWDyBDCamxlsuXiEWxQLyfBGP2qG9s1hD5aYq9YwBHiNv2y8pzkqoQ4m2FNOfOM=
X-Gm-Gg: AY/fxX6x94w7DLAAtDANagpBAeSwdAq8Nt0UEDE/BUmxE4zcwd94KHDMMkDdPt5+wZV
 8p4OXAcoiJHsXpJDmbN64ODW1cxS33T4+6rYJeTjP2BrqjvGFBy46ewVTKli/zZUVQmSRNHoVDS
 jO2lAvsRJYwXrKWwQHhhqcXJGyQoXLlrfIt2Wx4rxskWDqRUxy1rM91/Xa904yJk9b+hIdH28yk
 Ct94gHjuw/5PBWj+UADJFabFm1wZw3Wlqm92BHvBtYwIVMOjVKhzl7PMNU5s7odFhbK02GkZQ/1
 HaM4Iv8pZ4ZiUv/yIB406zc4R4FMgW+jGei6X19OcDjKHq/63py0AEK9ymi6WQvPYjGnxbojZ7G
 7CHKltXxRw2ibeVteOkoAnbWYEGQDgSALxoDcEtt6DmtIdDB8gw9tJ2YDu7fq2XqlzZsIiFNfrD
 GAY5KivSGgAz10iohNiikWjqYBktA=
X-Google-Smtp-Source: AGHT+IEwkXpLikgPQ8fYX8wyFL0Lvo9QzzAwVZufUjTBu4qv1ctHO+UgoYsniMWna+/WARcQxq6QSw==
X-Received: by 2002:a05:6830:2e05:b0:7c6:e92f:41df with SMTP id
 46e09a7af769-7cae82e3fe0mr13541504a34.12.1766035259765; 
 Wed, 17 Dec 2025 21:20:59 -0800 (PST)
Received: from timur-max.localnet ([189.171.135.243])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cc59b78cb2sm971518a34.16.2025.12.17.21.20.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Dec 2025 21:20:59 -0800 (PST)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH 1/6] drm/amdgpu: don't reemit ring contents more than once
Date: Wed, 17 Dec 2025 23:20:57 -0600
Message-ID: <2459360.yiUUSuA9gR@timur-max>
In-Reply-To: <20251215160711.11832-1-alexander.deucher@amd.com>
References: <20251215160711.11832-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

On 2025. december 15., h=C3=A9tf=C5=91 10:07:06 k=C3=B6z=C3=A9ps=C5=91 =C3=
=A1llamokbeli z=C3=B3naid=C5=91 Alex Deucher=20
wrote:
> If we cancel a bad job and reemit the ring contents, and
> we get another timeout, cancel everything rather than reemitting.
> The wptr markers are only relevant for the original emit.  If
> we reemit, the wptr markers are no longer correct.

I see the point of not reemitting, considering the wptrs are no longer=20
correct. However, would it be possible to correct the wptrs instead?

As it is, this sounds like it would make the reset less reliable when there=
 is=20
more than one job emitted that can cause hangs.

>=20
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 22 +++++++++++++++++-----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  |  2 ++
>  2 files changed, 19 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c index
> 1fe31d2f27060..334ddd6e48c06 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -710,6 +710,7 @@ void amdgpu_fence_driver_guilty_force_completion(stru=
ct
> amdgpu_fence *af) struct amdgpu_ring *ring =3D af->ring;
>  	unsigned long flags;
>  	u32 seq, last_seq;
> +	bool reemitted =3D false;
>=20
>  	last_seq =3D amdgpu_fence_read(ring) & ring-
>fence_drv.num_fences_mask;
>  	seq =3D ring->fence_drv.sync_seq & ring->fence_drv.num_fences_mask;
> @@ -727,7 +728,9 @@ void amdgpu_fence_driver_guilty_force_completion(stru=
ct
> amdgpu_fence *af) if (unprocessed &&
> !dma_fence_is_signaled_locked(unprocessed)) { fence =3D
> container_of(unprocessed, struct amdgpu_fence, base);
>=20
> -			if (fence =3D=3D af)
> +			if (fence->reemitted > 1)
> +				reemitted =3D true;
> +			else if (fence =3D=3D af)
>  				dma_fence_set_error(&fence->base,=20
=2DETIME);
>  			else if (fence->context =3D=3D af->context)
>  				dma_fence_set_error(&fence->base,=20
=2DECANCELED);
> @@ -735,9 +738,16 @@ void amdgpu_fence_driver_guilty_force_completion(str=
uct
> amdgpu_fence *af) rcu_read_unlock();
>  	} while (last_seq !=3D seq);
>  	spin_unlock_irqrestore(&ring->fence_drv.lock, flags);
> -	/* signal the guilty fence */
> -	amdgpu_fence_write(ring, (u32)af->base.seqno);
> -	amdgpu_fence_process(ring);
> +
> +	if (reemitted) {
> +		/* if we've already reemitted once then just cancel=20
everything */
> +		amdgpu_fence_driver_force_completion(af->ring);
> +		af->ring->ring_backup_entries_to_copy =3D 0;
> +	} else {
> +		/* signal the guilty fence */
> +		amdgpu_fence_write(ring, (u32)af->base.seqno);
> +		amdgpu_fence_process(ring);
> +	}
>  }
>=20
>  void amdgpu_fence_save_wptr(struct amdgpu_fence *af)
> @@ -785,10 +795,12 @@ void amdgpu_ring_backup_unprocessed_commands(struct
> amdgpu_ring *ring, /* save everything if the ring is not guilty, otherwise
>  			 * just save the content from other=20
contexts.
>  			 */
> -			if (!guilty_fence || (fence->context !=3D=20
guilty_fence->context))
> +			if (!fence->reemitted &&
> +			    (!guilty_fence || (fence->context !=3D=20
guilty_fence->context)))
>  			=09
amdgpu_ring_backup_unprocessed_command(ring, wptr,
>  							=09
       fence->wptr);
>  			wptr =3D fence->wptr;
> +			fence->reemitted++;
>  		}
>  		rcu_read_unlock();
>  	} while (last_seq !=3D seq);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h index
> a1fb0fadb6eab..d881829528976 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -150,6 +150,8 @@ struct amdgpu_fence {
>  	u64				wptr;
>  	/* fence context for resets */
>  	u64				context;
> +	/* has this fence been reemitted */
> +	unsigned int			reemitted;
>  };
>=20
>  extern const struct drm_sched_backend_ops amdgpu_sched_ops;




