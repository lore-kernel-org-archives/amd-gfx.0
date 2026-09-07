Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2507EC79F99
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Sep 2026 18:34:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6244010E8AC;
	Mon,  7 Sep 2026 18:34:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BLoiwRZ/";
	dkim-atps=neutral
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F90510E8AC
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Sep 2026 18:34:53 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-485888b3c3dso3955411f8f.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Sep 2026 11:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788806091; x=1789410891; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OUG3wECEJCHoF21ZXT5wJ0K33w5T+LFm1eDRcNwAdqs=;
 b=BLoiwRZ/4rwaUgqXrH6qa7+9zxCyjwMgu+YaiPXB8Dja8cGQ1bFQDsWwHvCTaEmsDf
 cjHyXBs5HGkKFzLOumIFnJk+ksKLx4aaUhTwjx3fT4J4XHbfAFmx+EcppDxruRkjhGU8
 Q8pvNvi80iewQk/wJ+gfZ/3Lu+LWddI89wILZUeIzIhJCbv5WWEm1xNdcbmax52vCXmO
 tAfZDuBMneqTOHTmqOuAu5YdlsjcZa7to4PaBmtTq2t2RKm1EzEMgQpozTn0Jv1A09qL
 flvFoHq1gvGl6M2DNV0F+LUY/CvqlZUPmPD+2YfHeGok/JoR8QpqtqTNeT8eA5mumjEq
 v9QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788806091; x=1789410891;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OUG3wECEJCHoF21ZXT5wJ0K33w5T+LFm1eDRcNwAdqs=;
 b=rGyCfZh2I31P9ahpNYqrHt7grKnPcbcdCL0BuBz9sTOUGeX0z8eFdpcDi7OxzmVbBt
 1t6bekSWOQE1J+iwVRrlh3FBL+mStRE4BtjYDcf3W1BFu7MKhcUVHBULN8qDpuOUiTKS
 urXsgWhVq1Ny80om3JSL8eqXD6B9M9m5LRHTjJ2tGNahRt8k2mftL3OLtsHjiuZng2z5
 oB99bufis5TEOIMiK/bwMQ8+losw82S+AH2N8d43iNA4YSEIl2GNZTLy9kOyMKvAHsp+
 vk7pdX1iHJQ5uYseXV3f/L5KS1vAZeeHTfnVpjRy5zt9+57Fvs8iAAY53O2ZjscfOjZQ
 Z4xg==
X-Gm-Message-State: AFuF++nAlJqQr2U/fiNAN6VthsgMHSfsiOQ8TIHQ6FPp5bFUiBFBf96r
 LB2ck1I94mKJjvXFMg8J0ccxXMj3k6cAiZ+Sbz+TItSKdsLoVLRYUm6PP2eTWA5d
X-Gm-Gg: AYBFou2rJkSWzDaaGiyrWnyqlIioX/V0SMdNw0vXNrC9NnDiqLd/zQ0sQw62Y5sJh8i
 EUbXZv4AiilCbM8jzhzy3bunL/cCP/rvpZOOKJC6wjGW4socGNzAn54sZuukANDV9xjTjg4ngLJ
 gJLBxz4yUHIR8LtG0ofJe8eYUdCZKhwu0oideH2f4jolsDNrsbs613TZNtkhA1P3SRRKWK+aqf1
 c4XbFZ7BkIEiabuVcXaEiqYQFZ5cY8pUnWzv7gmj27a8b5vFHo92RxDuTvXkGsFAcMzrWsTxS0U
 2gz4Lns8E7kS8pinZ0KvDAUkqV0r5BDnRX9d1ND5VHIjCRUKhPBXNtBiiv9ix571wGiGI/F7qws
 iVN5Qzlu69DPR3fpCCn74VnABctgyLUBsMMtBW5lTlukUzxhXVhYxvb+Bmy1jIMSQzNeNndlyyK
 RudAtIy4BLTXQiVwVWIso5HAvSWhTLWrOQvM2Gal2c5mEs3/Ii9uSH6Ab5cPTDDXmUZFrEMOkRb
 X3szsBJxZHpJ0E6epBqBXgRV1rEbcrF
X-Received: by 2002:a5d:5f83:0:b0:485:8c16:5ef3 with SMTP id
 ffacd0b85a97d-4858c16619amr23059057f8f.45.1788806091329; 
 Mon, 07 Sep 2026 11:34:51 -0700 (PDT)
Received: from timur-max.localnet (athedsl-4460056.home.otenet.gr.
 [79.129.254.8]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485885be1c1sm29725824f8f.32.2026.09.07.11.34.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 11:34:50 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>, "Lazar, Lijo" <lijo.lazar@amd.com>
Subject: Re: [PATCH 7/8] drm/amdgpu/sdma: Always handle kernel queues in
 amdgpu_sdma_reset_engine()
Date: Mon, 07 Sep 2026 20:34:48 +0200
Message-ID: <ZBE1nOSpRoOewoLNHFTFIA@gmail.com>
In-Reply-To: <e6270791-f276-487e-abc7-4ee1a529f357@amd.com>
References: <20260904072850.321759-1-timur.kristof@gmail.com>
 <20260904072850.321759-8-timur.kristof@gmail.com>
 <e6270791-f276-487e-abc7-4ee1a529f357@amd.com>
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

On 2026. szeptember 7., h=C3=A9tf=C5=91 9:17:12 k=C3=B6z=C3=A9p-eur=C3=B3pa=
i ny=C3=A1ri id=C5=91 Lazar, Lijo=20
wrote:
> On 04-Sep-26 12:58 PM, Timur Krist=C3=B3f wrote:
> > Remove the caller_handles_kernel_queues argument from
> > the amdgpu_sdma_reset_engine() function and make it
> > always handle kernel queues.
> >=20
> > Now the SDMA recovery sequence is more consistent
> > between callers for the KFD as follows.
> > Before recovery: first the KFD is suspended,
> > then the SDMA queue contents are backed up.
> > After recovery: first the SDMA queue contents
> > are restored, then the KFD is resumed.
> >=20
> > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > ---
> >=20
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c      | 68 ++++++++++---------
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h      |  3 +-
> >   drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c      |  2 +-
> >   .../drm/amd/amdkfd/kfd_device_queue_manager.c |  2 +-
> >   4 files changed, 38 insertions(+), 37 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c index
> > 9eebd8380834..07aac5b3ea92 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> > @@ -542,16 +542,14 @@ static int amdgpu_sdma_soft_reset(struct
> > amdgpu_device *adev, u32 instance_id)>=20
> >   }
> >  =20
> >   /**
> >=20
> > - * amdgpu_sdma_reset_engine - Reset a specific SDMA engine
> > + * amdgpu_sdma_reset_engine() - Reset a specific SDMA engine instance.
> > + *
> >=20
> >    * @adev: Pointer to the AMDGPU device
> >    * @instance_id: Logical ID of the SDMA engine instance to reset
> >=20
> > - * @caller_handles_kernel_queues: Skip kernel queue processing. Caller
> > - * will handle it.
> >=20
> >    *
> >    * Returns: 0 on success, or a negative error code on failure.
> >    */
> >=20
> > -int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t
> > instance_id, -			     bool=20
caller_handles_kernel_queues)
> > +int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t
> > instance_id)>=20
> >   {
> >  =20
> >   	struct amdgpu_sdma_instance *sdma_instance =3D
> >   	&adev->sdma.instance[instance_id]; struct amdgpu_ring *gfx_ring =3D
> >   	&sdma_instance->ring;
> >=20
> > @@ -564,20 +562,23 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device
> > *adev, uint32_t instance_id,>=20
> >   	mutex_lock(&sdma_instance->engine_reset_mutex);
> >=20
> > -	if (!caller_handles_kernel_queues) {
> > -		/* Stop the scheduler's work queue for the GFX and page=20
rings if they
> > are running. -		 * This ensures that no new tasks are=20
submitted to the
> > queues while -		 * the reset is in progress.
> > -		 */
> > +	/*
> > +	 * Stop the scheduler's work queue for the GFX and page rings if=20
they
> > are running. +	 * This ensures that no new tasks are submitted to=20
the
> > queues while +	 * the reset is in progress.
> > +	 */
> > +	if (amdgpu_ring_sched_ready(gfx_ring) &&
> > !drm_sched_is_stopped(&gfx_ring->sched))>=20
> >   		drm_sched_wqueue_stop(&gfx_ring->sched);
> >=20
> > -		gfx_fence =3D amdgpu_ring_find_guilty_fence(gfx_ring);
> > -		amdgpu_ring_reset_helper_begin(gfx_ring, gfx_fence);
> >=20
> > -		if (adev->sdma.has_page_queue) {
> > +	gfx_fence =3D amdgpu_ring_find_guilty_fence(gfx_ring);
> > +	amdgpu_ring_reset_helper_begin(gfx_ring, gfx_fence);
> > +
> > +	if (adev->sdma.has_page_queue) {
> > +		if (amdgpu_ring_sched_ready(page_ring) &&
> > !drm_sched_is_stopped(&page_ring->sched))>=20
> >   			drm_sched_wqueue_stop(&page_ring->sched);
> >=20
> > -			page_fence =3D=20
amdgpu_ring_find_guilty_fence(page_ring);
> > -			amdgpu_ring_reset_helper_begin(page_ring,=20
page_fence);
> > -		}
> > +
> > +		page_fence =3D amdgpu_ring_find_guilty_fence(page_ring);
> > +		amdgpu_ring_reset_helper_begin(page_ring, page_fence);
> >=20
> >   	}
>=20
> Since this resets the engine, a different way may be to have something
> like below (similar to amdgpu_multi_ring_reset_helper_begin) which takes
> care of all rings in the engine instance.
>=20
> amdgpu_ring_engine_reset_helper_begin(guilty_ring, guilty_fence);
>=20
> amdgpu_ring_engine_reset_helper_end(guilty_ring, guilty_fence);
>=20
> ring_type =3D guilty_ring->funcs->type;
> eng_instance =3D guilty_ring->me
>=20
> Thanks,
> Lijo

I am planning to do exactly that, but I want to keep this series short and=
=20
focused on unifying the code paths for SDMA v4.4.2 and v5.x.

Is it OK if I do that in a follow-up series?

Thanks,
Timur

>=20
> >   	if (sdma_instance->funcs->stop_kernel_queue) {
> >=20
> > @@ -612,22 +613,25 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device
> > *adev, uint32_t instance_id,>=20
> >   	}
> >  =20
> >   exit:
> > -	if (!caller_handles_kernel_queues) {
> > -		/* Restart the scheduler's work queue for the GFX and=20
page rings
> > -		 * if they were stopped by this function. This allows=20
new tasks
> > -		 * to be submitted to the queues after the reset is=20
complete.
> > -		 */
> > -		if (!ret) {
> > -			ret =3D amdgpu_ring_reset_helper_end(gfx_ring,=20
gfx_fence);
> > +	/* Restart the scheduler's work queue for the GFX and page rings
> > +	 * if they were stopped by this function. This allows new tasks
> > +	 * to be submitted to the queues after the reset is complete.
> > +	 */
> > +	if (!ret) {
> > +		ret =3D amdgpu_ring_reset_helper_end(gfx_ring,=20
gfx_fence);
> > +		if (ret)
> > +			goto unlock;
> > +
> > +		if (amdgpu_ring_sched_ready(gfx_ring))
> > +			drm_sched_wqueue_start(&gfx_ring->sched);
> > +
> > +		if (adev->sdma.has_page_queue) {
> > +			ret =3D=20
amdgpu_ring_reset_helper_end(page_ring, page_fence);
> >=20
> >   			if (ret)
> >   		=09
> >   				goto unlock;
> >=20
> > -			drm_sched_wqueue_start(&gfx_ring->sched);
> > -			if (adev->sdma.has_page_queue) {
> > -				ret =3D=20
amdgpu_ring_reset_helper_end(page_ring, page_fence);
> > -				if (ret)
> > -					goto unlock;
> > +
> > +			if (amdgpu_ring_sched_ready(page_ring))
> >=20
> >   			=09
drm_sched_wqueue_start(&page_ring->sched);
> >=20
> > -			}
> >=20
> >   		}
> >   =09
> >   	}
> >  =20
> >   unlock:
> > @@ -662,13 +666,11 @@ int amdgpu_sdma_reset_queue_legacy(struct
> > amdgpu_ring *ring,>=20
> >   		return -EINVAL;
> >   =09
> >   	}
> >=20
> > -	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
> > -
> >=20
> >   	amdgpu_amdkfd_suspend(adev, true);
> >=20
> > -	r =3D amdgpu_sdma_reset_engine(adev, ring->me, true);
> > +	r =3D amdgpu_sdma_reset_engine(adev, ring->me);
> >=20
> >   	amdgpu_amdkfd_resume(adev, true);
> >   	if (r)
> >   =09
> >   		return r;
> >=20
> > -	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
> > +	return 0;
> >=20
> >   }
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h index
> > cb41453c1a19..5709d438e824 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> > @@ -153,8 +153,7 @@ struct amdgpu_buffer_funcs {
> >=20
> >   				 uint32_t byte_count);
> >  =20
> >   };
> >=20
> > -int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t
> > instance_id, -			     bool=20
caller_handles_kernel_queues);
> > +int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t
> > instance_id);>=20
> >   int amdgpu_sdma_reset_queue_legacy(struct amdgpu_ring *ring,
> >  =20
> >   				   unsigned int vmid,
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> > b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c index
> > 77f385b9ef53..796ea9f74763 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> > @@ -1583,7 +1583,7 @@ static int sdma_v4_4_2_reset_queue(struct
> > amdgpu_ring *ring,>=20
> >   	int r;
> >   =09
> >   	amdgpu_amdkfd_suspend(adev, true);
> >=20
> > -	r =3D amdgpu_sdma_reset_engine(adev, id, false);
> > +	r =3D amdgpu_sdma_reset_engine(adev, id);
> >=20
> >   	amdgpu_amdkfd_resume(adev, true);
> >   	return r;
> >  =20
> >   }
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> > b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c index
> > a23384571193..f9fbc5628fb4 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> > @@ -2576,7 +2576,7 @@ static int reset_hung_queues_sdma(struct
> > device_queue_manager *dqm)>=20
> >   				continue;
> >   		=09
> >   			/* Reset engine and check. */
> >=20
> > -			if (amdgpu_sdma_reset_engine(dqm->dev->adev,=20
i, false) ||
> > +			if (amdgpu_sdma_reset_engine(dqm->dev->adev,=20
i) ||
> >=20
> >   			    dqm->dev->kfd2kgd-
>hqd_sdma_get_doorbell(dqm->dev->adev, i, j) ||
> >   			    !set_sdma_queue_as_reset(dqm,=20
doorbell_off)) {
> >   			=09
> >   				r =3D -ENOTRECOVERABLE;




