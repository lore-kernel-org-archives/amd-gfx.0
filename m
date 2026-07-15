Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FD56C44508
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 08:08:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FD7810EF57;
	Wed, 15 Jul 2026 08:08:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ROixU9tk";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A00E510EF2D
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 08:08:44 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-493b27c7451so4322475e9.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 01:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784102923; x=1784707723; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PHo7/8zkKFccus7wYifqNiAA+dzweW71Wo6mFXfCR08=;
 b=ROixU9tkuib8NJeuZOCirPLVDW+AizBFUylwXodBk69fyv7gQ7hGTm99BHKGCm2SYE
 Oo7kqrN2FmD/TeqAOnjhPLZn952H/zaHouOT1AM0xc/mtFXyPkD7EDivFskHNSwVEhfR
 1Gntvt9sCPX6NSUellOWGLd7Rq6iTNuViKKm6K//ZGdYNhsGB2cT4GAYlQjywmBnsVev
 EI1xY7y4hLY8IofLXCiwoFFS2ciT29VwnNLH76qrLFoOxn141eknBlcXA5EPf0k0QCSa
 oFfyGS/AVFXELUpFnMCrd3PtI419159KmBo2cjRKmuS8/BuZ1bTRygMAdtDnAOb/ap3K
 XbGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784102923; x=1784707723;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PHo7/8zkKFccus7wYifqNiAA+dzweW71Wo6mFXfCR08=;
 b=YWBpNHWAqcdtak7mpJzPvRH9cMRypoJ5SJRugI/trJAkr5ZG3bTMgsWIFiqsLZxKF6
 S5I2fvuHA+zZrEuQwzM/Zl4k2T38xRYXie2DIjoQUlROMI0Te6wmHyKakgiZOyMhVjv1
 gD9pHBq7fhWBBXJ083oiOZEQfNpRU7et+ovWRAfKboQag8lhWx0+7eRMcKvtouoMjf5M
 hdPjOIpa8PpN9ElGs8NQre+0zt6z3M/mTCCw8AH8ypjP9/nZiKCo1XhIwtegyNMyFqc6
 yb14nNfiPvo3meo1Cp4lhBcGCMKdrwUphVO7Cyau9cyMJPaAn9g+94eO2fY/01RWIrFt
 U2Eg==
X-Gm-Message-State: AOJu0Yx6DQg1RRxLFMtKy0nwabo9kJ3OW56eo5m+GXVelBpBLCI7Y64J
 G1khA5UHrcCO2voexkyWceqTjLjlqWNgkI2b7ZTW00QBzlMpIcJW9dSijwL1qQ==
X-Gm-Gg: AfdE7cncAUglJt4Gt/1fzUTMd0HKHW9+Y+OesUuf2LTx5fZnnjwvSfDSpbdMtsx9Bsb
 EBvXfCsvu7DcMho9cZLQA5Of6vUd2mIUm3aA/OEiseynHKSgE15Y+ASbMH3dQrg9BK0it4hhEXo
 XhGO+mVq4SyPLMRxQsxHpT89l1z0qMz4Jhj4ea3D5j/gmvLCNx6P7lArGsKPb02sOmuH3OmDDGT
 pQOrD947YzZz/qqz3hLgL4soEaUkBb8AIFODdheIuT7mHRgjOH/Y7bRre8vpopXJTmMul1fDrZK
 D78AhwQF79apsPEwMFwMWJw8B4GOdjCFhD9XDhHkOdn6w0mkr/ZqyMUP+ZR8bTxvspm9xhFj2z+
 NKsyUP3+6DxI5YbePHTQw0JdMJs3gpG6dHupYNifSTX+jvoH5ddP6sOGHUIMusaQbUWZEC+5P5W
 tcdnrK+A1n+6ZbRPg6ffBVquVYsCwpcnFs3pcC+UO3g3T2/n3LMdOpCH6PpnSjaTnT3fIh7j53j
 MtPPmSKM8KpVPkcF2M=
X-Received: by 2002:a05:600c:3222:b0:493:b36b:4933 with SMTP id
 5b1f17b1804b1-493f2a85bdfmr156963515e9.3.1784102922691; 
 Wed, 15 Jul 2026 01:08:42 -0700 (PDT)
Received: from timur-max.localnet
 (20014C4E24CD7200F6BBA872344E1A32.dsl.pool.telekom.hu.
 [2001:4c4e:24cd:7200:f6bb:a872:344e:1a32])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f464a96fdsm14773091f8f.24.2026.07.15.01.08.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 01:08:42 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, pierre-eric.pelloux-prayer@amd.com,
 Natalie Vock <natalie.vock@gmx.de>, Tvrtko Ursulin <tursulin@ursulin.net>
Subject: Re: [PATCH 2/9] drm/amdgpu/gfx7: Refactor MQD initialization and
 finalization
Date: Wed, 15 Jul 2026 10:08:41 +0200
Message-ID: <4566110.UPlyArG6xL@timur-max>
In-Reply-To: <f0fe75db-5ded-4370-b931-3ef3827f0b16@ursulin.net>
References: <20260713125838.30607-1-timur.kristof@gmail.com>
 <20260713125838.30607-3-timur.kristof@gmail.com>
 <f0fe75db-5ded-4370-b931-3ef3827f0b16@ursulin.net>
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

On 2026. j=C3=BAlius 14., kedd 20:47:14 k=C3=B6z=C3=A9p-eur=C3=B3pai ny=C3=
=A1ri id=C5=91 Tvrtko Ursulin=20
wrote:
> On 13/07/2026 13:58, Timur Krist=C3=B3f wrote:
> > Call amdgpu_gfx_mqd_sw_init()/_fini() on GFX7 to initialize and
> > finalize the MQD, just like GFX8 and newer; instead of doing
> > an ad-hoc BO allocation. This introduces the possibility of
> > doing an MQD backup instead of trying to reinitialize the
> > MQD every time.
> >=20
> > This solves an issue with GFX IP block soft reset where
> > all compute rings would hang after the reset.
> >=20
> > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > ---
> >=20
> >   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 106 +++++++++++++-------------
> >   1 file changed, 51 insertions(+), 55 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> > b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c index 65b8497ad5f0..9c4b3ac27e1f
> > 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> > @@ -2698,25 +2698,6 @@ static int
> > gfx_v7_0_cp_compute_load_microcode(struct amdgpu_device *adev)>=20
> >   	return 0;
> >  =20
> >   }
> >=20
> > -/**
> > - * gfx_v7_0_cp_compute_fini - stop the compute queues
> > - *
> > - * @adev: amdgpu_device pointer
> > - *
> > - * Stop the compute queues and tear down the driver queue
> > - * info.
> > - */
> > -static void gfx_v7_0_cp_compute_fini(struct amdgpu_device *adev)
> > -{
> > -	int i;
> > -
> > -	for (i =3D 0; i < adev->gfx.num_compute_rings; i++) {
> > -		struct amdgpu_ring *ring =3D &adev->gfx.compute_ring[i];
> > -
> > -		amdgpu_bo_free_kernel(&ring->mqd_obj, NULL, NULL);
> > -	}
> > -}
> > -
> >=20
> >   static void gfx_v7_0_mec_fini(struct amdgpu_device *adev)
> >   {
> >  =20
> >   	amdgpu_bo_free_kernel(&adev->gfx.mec.hpd_eop_obj, NULL, NULL);
> >=20
> > @@ -2788,28 +2769,29 @@ static void gfx_v7_0_compute_pipe_init(struct
> > amdgpu_device *adev,>=20
> >   	mutex_unlock(&adev->srbm_mutex);
> >  =20
> >   }
> >=20
> > -static int gfx_v7_0_mqd_deactivate(struct amdgpu_device *adev)
> > +static int gfx_v7_0_mqd_deactivate(struct amdgpu_device *adev, u32 req)
> >=20
> >   {
> >=20
> > -	int i;
> > +	int i, r =3D 0;
> >=20
> >   	/* disable the queue if it's active */
> >=20
> > -	if (RREG32(mmCP_HQD_ACTIVE) & 1) {
> > -		WREG32(mmCP_HQD_DEQUEUE_REQUEST, 1);
> > +	if (RREG32(mmCP_HQD_ACTIVE) & CP_HQD_ACTIVE__ACTIVE_MASK) {
> > +		WREG32_FIELD(CP_HQD_DEQUEUE_REQUEST, DEQUEUE_REQ, req);
> >=20
> >   		for (i =3D 0; i < adev->usec_timeout; i++) {
> >=20
> > -			if (!(RREG32(mmCP_HQD_ACTIVE) & 1))
> > +			if (!(RREG32(mmCP_HQD_ACTIVE) &=20
CP_HQD_ACTIVE__ACTIVE_MASK))
> >=20
> >   				break;
> >   		=09
> >   			udelay(1);
> >   	=09
> >   		}
> >   	=09
> >   		if (i =3D=3D adev->usec_timeout)
> >=20
> > -			return -ETIMEDOUT;
> > +			r =3D -ETIMEDOUT;
> >=20
> > -		WREG32(mmCP_HQD_DEQUEUE_REQUEST, 0);
> > -		WREG32(mmCP_HQD_PQ_RPTR, 0);
> > -		WREG32(mmCP_HQD_PQ_WPTR, 0);
> >=20
> >   	}
> >=20
> > -	return 0;
> > +	WREG32(mmCP_HQD_DEQUEUE_REQUEST, 0);
> > +	WREG32(mmCP_HQD_PQ_RPTR, 0);
> > +	WREG32(mmCP_HQD_PQ_WPTR, 0);
> > +
> > +	return r;
>=20
> I can see this matches gfx_v8_0_deactivate_hqd. If I am not missing
> anything only to replace the hardcoded 1 with CP_HQD_ACTIVE__ACTIVE_MASK?

There are two changes here:
=2D Replacing the hardcoded "1" with the define from the register definition
=2D When it times out, still write the CP_HQD_ registers afterwards like gf=
x8

> Is it okay to call the function mqd if the registers are hqd and is v7
> or v8 (which calls it hqd) more correct? Not saying either way, just
> observing a curiosity.

My best guess is that it's just that they used a different naming conventio=
n=20
and forgot to update the older code.

>=20
> >   }
> >  =20
> >   static void gfx_v7_0_mqd_init(struct amdgpu_device *adev,
> >=20
> > @@ -2964,31 +2946,42 @@ static int gfx_v7_0_mqd_commit(struct
> > amdgpu_device *adev, struct cik_mqd *mqd)>=20
> >   static int gfx_v7_0_compute_queue_init(struct amdgpu_device *adev, int
> >   ring_id) {
> >=20
> > -	int r;
> > -	u64 mqd_gpu_addr;
> > -	struct cik_mqd *mqd;
> >=20
> >   	struct amdgpu_ring *ring =3D &adev->gfx.compute_ring[ring_id];
> >=20
> > -
> > -	r =3D amdgpu_bo_create_reserved(adev, sizeof(struct cik_mqd),=20
PAGE_SIZE,
> > -				      AMDGPU_GEM_DOMAIN_GTT,=20
&ring->mqd_obj,
> > -				      &mqd_gpu_addr, (void=20
**)&mqd);
> > -	if (r) {
> > -		dev_warn(adev->dev, "(%d) create MQD bo failed\n", r);
> > -		return r;
> > +	struct cik_mqd *mqd =3D ring->mqd_ptr;
> > +	int mqd_idx =3D ring - &adev->gfx.compute_ring[0];
> > +
> > +	if (!amdgpu_in_reset(adev) && !adev->in_suspend) {
> > +		memset((void *)mqd, 0, ring->mqd_size);
> > +		mutex_lock(&adev->srbm_mutex);
> > +		cik_srbm_select(adev, ring->me, ring->pipe, ring-
>queue, 0);
> > +		gfx_v7_0_mqd_init(adev, mqd, ring->mqd_gpu_addr, ring);
> > +		gfx_v7_0_mqd_deactivate(adev, 1);
> > +		gfx_v7_0_mqd_commit(adev, mqd);
> > +		cik_srbm_select(adev, 0, 0, 0, 0);
> > +		mutex_unlock(&adev->srbm_mutex);
> > +
> > +		if (adev->gfx.mec.mqd_backup[mqd_idx])
> > +			memcpy(adev->gfx.mec.mqd_backup[mqd_idx],=20
mqd, ring->mqd_size);
> > +	} else {
> > +		/* restore MQD to a clean status */
> > +		if (adev->gfx.mec.mqd_backup[mqd_idx])
> > +			memcpy(mqd, adev-
>gfx.mec.mqd_backup[mqd_idx], ring->mqd_size);
> > +
> > +		/* Re-commit the restored backup */
> > +		mutex_lock(&adev->srbm_mutex);
> > +		cik_srbm_select(adev, ring->me, ring->pipe, ring-
>queue, 0);
> > +		gfx_v7_0_mqd_deactivate(adev, 2);
> > +		gfx_v7_0_mqd_commit(adev, mqd);
> > +		cik_srbm_select(adev, 0, 0, 0, 0);
> > +		mutex_unlock(&adev->srbm_mutex);
> > +
> > +		/* reset ring buffer */
> > +		ring->wptr =3D 0;
> > +		atomic64_set((atomic64_t *)ring->wptr_cpu_addr, 0);
> > +		atomic64_set((atomic64_t *)ring->rptr_cpu_addr, 0);
> > +		amdgpu_ring_clear_ring(ring);
> >=20
> >   	}
> >=20
> > -	mutex_lock(&adev->srbm_mutex);
> > -	cik_srbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
> > -
> > -	gfx_v7_0_mqd_init(adev, mqd, mqd_gpu_addr, ring);
> > -	gfx_v7_0_mqd_deactivate(adev);
> > -	gfx_v7_0_mqd_commit(adev, mqd);
> > -
> > -	cik_srbm_select(adev, 0, 0, 0, 0);
> > -	mutex_unlock(&adev->srbm_mutex);
> > -
> > -	amdgpu_bo_kunmap(ring->mqd_obj);
> > -	amdgpu_bo_unreserve(ring->mqd_obj);
> >=20
> >   	return 0;
> >  =20
> >   }
>=20
> I think I can follow this - only the wptr and rptr reset is a bit
> different than what v8 does it. Any specific reason? Gfx9 then reverts
> back to a single ring->wptr =3D 0. I guess v8 is somehow special?
>=20
> > @@ -3020,10 +3013,8 @@ static int gfx_v7_0_cp_compute_resume(struct
> > amdgpu_device *adev)>=20
> >   	/* init the queues */
> >   	for (i =3D 0; i < adev->gfx.num_compute_rings; i++) {
> >   =09
> >   		r =3D gfx_v7_0_compute_queue_init(adev, i);
> >=20
> > -		if (r) {
> > -			gfx_v7_0_cp_compute_fini(adev);
> > +		if (r)
> >=20
> >   			return r;
> >=20
> > -		}
> >=20
> >   	}
> >   =09
> >   	gfx_v7_0_cp_compute_enable(adev, true);
> >=20
> > @@ -4430,6 +4421,11 @@ static int gfx_v7_0_sw_init(struct amdgpu_ip_blo=
ck
> > *ip_block)>=20
> >   		}
> >   =09
> >   	}
> >=20
> > +	/* create MQD for all compute queues */
> > +	r =3D amdgpu_gfx_mqd_sw_init(adev, sizeof(struct cik_mqd), 0);
> > +	if (r)
> > +		return r;
> > +
> >=20
> >   	adev->gfx.ce_ram_size =3D 0x8000;
> >   =09
> >   	gfx_v7_0_gpu_early_init(adev);
> >=20
> > @@ -4452,7 +4448,7 @@ static int gfx_v7_0_sw_fini(struct amdgpu_ip_block
> > *ip_block)>=20
> >   	for (i =3D 0; i < adev->gfx.num_compute_rings; i++)
> >   =09
> >   		amdgpu_ring_fini(&adev->gfx.compute_ring[i]);
> >=20
> > -	gfx_v7_0_cp_compute_fini(adev);
> > +	amdgpu_gfx_mqd_sw_fini(adev, 0);
> >=20
> >   	amdgpu_gfx_rlc_fini(adev);
> >   	gfx_v7_0_mec_fini(adev);
> >   	amdgpu_bo_free_kernel(&adev->gfx.rlc.clear_state_obj,
>=20
> I am assuming all this applies only to compute because gfx is single
> instance on v7?

It applies only to compute because only compute has HQD/MQD
on these hardware generations.

> Anyway, it looks plausible to me so assuming you were able to exercise
> both paths

What do you mean by "both paths"?

Thanks,
Timur


