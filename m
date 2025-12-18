Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02440D68BDD
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Dec 2025 05:28:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E40310E539;
	Thu, 18 Dec 2025 05:28:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ng1HaTlE";
	dkim-atps=neutral
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com
 [209.85.210.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 896DB10E539
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Dec 2025 05:28:03 +0000 (UTC)
Received: by mail-ot1-f44.google.com with SMTP id
 46e09a7af769-7c76f65feb5so146100a34.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Dec 2025 21:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766035683; x=1766640483; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8RKH4IwvgErEYZ5vPLe5n/FoTY8RJblyNhPLHqQ966Q=;
 b=ng1HaTlE2aEjUkpJPrUCVPOI2hYyFBp61fk84rczQsXNYQxR2Rc8jRAZ4jo60s92Ee
 m/f+fyEvFdXtWi3HuNqvZHi/vvOZR6B2dyyR1SPKPGfzyIquIc4ym++h0EGAtD1fLaWM
 MhY8s4otZDg23klOmd/DdKAxnhGLnHA3+i70BRtIXQujice7792AdY3zzQirlIp2xvPC
 T4M6mfCQRxi5m+te/UYgBkVb4jMkMl/j+YQ5BJN9V41db5DiHwblejf19R0XxKW8Enc6
 AExSOHkC4lnWEIOTAjGqAgw24NhuAC/Yafk6jXfGn0rGz0TMKeQa0Y2ZIw90niHpp6Uz
 /pEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766035683; x=1766640483;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8RKH4IwvgErEYZ5vPLe5n/FoTY8RJblyNhPLHqQ966Q=;
 b=PDlSo2G4XWQpOXyaLi4GAJsC+RJKFMxlF56DL7gcvEXgzIT51F0jLoiy0bOHUgs2BZ
 frT0UvcIVfTriFOrMFMpuxKzolS5KZ8M9m6w/LDJbKG8IZNVlkhYuwpUdro34SOoqP6h
 U7lOGOpCOUSq/STG/y/6dizLRmAUsoE064tNsZ8HwgUFLWWBn4Gp+9xSXhCtUEMQ2CNA
 QktSFYJB5E2/BQYL0x58palgTOOuYXrRpSI8hF/ZKGdEIYvlm3q8Y1j7dru8wrLw5EKv
 umcLrGOhhTslC1oXwTAL9ZslrB8GShUDJzGN7Og0jOZIO+ClOq8igT5puO9MgoD19US3
 5E6w==
X-Gm-Message-State: AOJu0YzuLzbypRhf/lQOllFbVmarK8mo1Mgte1QVy6gPv/SD0CqK7tYG
 e/ui0iUs3ERJgmlKTTBC/KnUtzvcfZrlMz8OsUKrGNn6IBu8FG3ORUkl7QFCr22vrCw=
X-Gm-Gg: AY/fxX7kEsDJWOCGhBWe6CiF6+yxNavcj3TLXEsWvk3tLSUV48xVc3y0gb4xTTd1a2n
 UjeulHiNAZEF/LGJXV2HegPowykR5TRB8lxtVVwnTD9+7W/XceyCNQb/FsTsfGCZbkRNCAlgm5m
 kpBsjXab58QO2IiAFbkeC7+YSg8g6ZmS5eGd0hiL3tQONmXMFapxN/wpn5KGWLCrbfbcK00LkNp
 ThkD02tNPBPkwTgbhefmJfbtuGJycEnmx2nk2j17zDVjRTsYihRrAooAD9pLB6hZet9ET4ebBg6
 Bja67OWXTM9YdoMImwpSqUVpmsyVKeQpv7q6NGVj/PTVkJdNaJ2sikDL5tVr7nYvq7PNPpxkhHv
 bmL8Q8Di8dbnlvrmconUiTLecjRWEe1rWIjUEf+jTibqSUXoQishLvhQJ1S8yVTMdox8wTzK55Q
 qJbeTLPuAXHVb5fxuc1UHonUELlph9Ew87K0Ux7g==
X-Google-Smtp-Source: AGHT+IGvWIBsXP3qvHdsO5I+x3pmjluPclDZwr4m8cT5ieQlNcP4c4dwbaIrB2B09Bw9ys977Q2TYw==
X-Received: by 2002:a05:6830:2690:b0:748:8b42:77ab with SMTP id
 46e09a7af769-7cae81d5dd6mr10078168a34.0.1766035682635; 
 Wed, 17 Dec 2025 21:28:02 -0800 (PST)
Received: from timur-max.localnet ([189.171.135.243])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cc59a7d60dsm966859a34.12.2025.12.17.21.28.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Dec 2025 21:28:02 -0800 (PST)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH 6/6] drm/amdgpu/gfx9: Implement KGQ ring reset
Date: Wed, 17 Dec 2025 23:28:01 -0600
Message-ID: <2552767.t9SDvczpPo@timur-max>
In-Reply-To: <2952111.fDdHjke4Dd@timur-max>
References: <20251215160711.11832-1-alexander.deucher@amd.com>
 <20251215160711.11832-6-alexander.deucher@amd.com>
 <2952111.fDdHjke4Dd@timur-max>
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

On 2025. december 17., szerda 23:11:45 k=C3=B6z=C3=A9ps=C5=91 =C3=A1llamokb=
eli z=C3=B3naid=C5=91 Timur=20
Krist=C3=B3f wrote:
> On 2025. december 15., h=C3=A9tf=C5=91 10:07:11 k=C3=B6z=C3=A9ps=C5=91 =
=C3=A1llamokbeli z=C3=B3naid=C5=91 Alex
> Deucher
> wrote:
> > GFX ring resets work differently on pre-GFX10 hardware since
> > there is no MQD managed by the scheduler.
> > For ring reset, you need issue the reset via CP_VMID_RESET
> > via KIQ or MMIO and submit the following to the gfx ring to
> > complete the reset:
> > 1. EOP packet with EXEC bit set
> > 2. WAIT_REG_MEM to wait for the fence
> > 3. Clear CP_VMID_RESET to 0
> > 4. EVENT_WRITE ENABLE_LEGACY_PIPELINE
> > 5. EOP packet with EXEC bit set
> > 6. WAIT_REG_MEM to wait for the fence
> > Once those commands have completed the reset should
> > be complete and the ring can accept new packets.
> >=20
> > However, because we have a pipeline sync between jobs,
> > the PFP is waiting on the fence from the bad job to signal so
> > it can't process any of the packets in the reset sequence
> > until that pipeline sync clears.  To unblock the PFP, we
> > use the KIQ to signal the fence after we reset the queue.
> >=20
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >=20
> >  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 104 +++++++++++++++++++++++++-
> >  1 file changed, 101 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c index bb1465a98c7ca..9b70736503=
15e
> > 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > @@ -2410,8 +2410,10 @@ static int gfx_v9_0_sw_init(struct amdgpu_ip_blo=
ck
> > *ip_block) amdgpu_get_soft_full_reset_mask(&adev->gfx.gfx_ring[0]);
> >=20
> >  	adev->gfx.compute_supported_reset =3D
> >  =09
> >  		amdgpu_get_soft_full_reset_mask(&adev-
> >
> >gfx.compute_ring[0]);
> >
> > -	if (!amdgpu_sriov_vf(adev) && !adev->debug_disable_gpu_ring_reset)
> > +	if (!amdgpu_sriov_vf(adev) && !adev->debug_disable_gpu_ring_reset)
>=20
> {
>=20
> >  		adev->gfx.compute_supported_reset |=3D
>=20
> AMDGPU_RESET_TYPE_PER_QUEUE;
>=20
> > +		adev->gfx.gfx_supported_reset |=3D
>=20
> AMDGPU_RESET_TYPE_PER_QUEUE;
>=20
> > +	}
> >=20
> >  	r =3D amdgpu_gfx_kiq_init(adev, GFX9_MEC_HPD_SIZE, 0);
> >  	if (r) {
> >=20
> > @@ -7163,6 +7165,103 @@ static void gfx_v9_ring_insert_nop(struct
> > amdgpu_ring *ring, uint32_t num_nop) amdgpu_ring_insert_nop(ring, num_n=
op
> > -
> > 1);
> >=20
> >  }
> >=20
> > +static void gfx_v9_0_ring_emit_wreg_me(struct amdgpu_ring *ring,
> > +				       uint32_t reg,
> > +				       uint32_t val)
> > +{
> > +	uint32_t cmd =3D 0;
> > +
> > +	switch (ring->funcs->type) {
> > +	case AMDGPU_RING_TYPE_KIQ:
> > +		cmd =3D (1 << 16); /* no inc addr */
>=20
> What do you mean by "inc addr" in this context?
>=20
> > +		break;
> > +	default:
> > +		cmd =3D WR_CONFIRM;
> > +		break;
> > +	}
> > +	amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
> > +	amdgpu_ring_write(ring, cmd);
> > +	amdgpu_ring_write(ring, reg);
> > +	amdgpu_ring_write(ring, 0);
> > +	amdgpu_ring_write(ring, val);
> > +}
> > +
> > +static void gfx_v9_0_ring_emit_event_write(struct amdgpu_ring *ring,
> > +					   uint32_t=20
event_type,
> > +					   uint32_t
>=20
> event_index)
>=20
> > +{
> > +	amdgpu_ring_write(ring, PACKET3(PACKET3_EVENT_WRITE, 0));
> > +	amdgpu_ring_write(ring, EVENT_TYPE(event_type) |
> > +			  EVENT_INDEX(event_index));
> > +}
> > +
> > +static int gfx_v9_0_reset_kgq(struct amdgpu_ring *ring,
> > +			      unsigned int vmid,
> > +			      struct amdgpu_fence *timedout_fence)
> > +{
> > +	struct amdgpu_device *adev =3D ring->adev;
> > +	struct amdgpu_kiq *kiq =3D &adev->gfx.kiq[0];
> > +	struct amdgpu_ring *kiq_ring =3D &kiq->ring;
> > +	unsigned long flags;
> > +	u32 tmp;
> > +	int r;
> > +
> > +	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
> > +
> > +	spin_lock_irqsave(&kiq->ring_lock, flags);
> > +
> > +	if (amdgpu_ring_alloc(kiq_ring, 5 + 5)) {
> > +		spin_unlock_irqrestore(&kiq->ring_lock, flags);
> > +		return -ENOMEM;
> > +	}
> > +
> > +	/* send the reset - 5 */
> > +	tmp =3D REG_SET_FIELD(0, CP_VMID_RESET, RESET_REQUEST, 1 << vmid);
> > +	gfx_v9_0_ring_emit_wreg(kiq_ring,
> > +				SOC15_REG_OFFSET(GC, 0,
>=20
> mmCP_VMID_RESET), tmp);
>=20
> > +	/* emit the fence to clear the pipeline sync - 5 */
> > +	gfx_v9_0_ring_emit_fence_kiq(kiq_ring, ring->fence_drv.gpu_addr,
> > +				     timedout_fence->base.seqno,
>=20
> 0);
>=20
> As far as I see, this isn't going to work when sched_hw_submission > 2 and
> there are more than two jobs (from various different userspace processes)
> emitted in the ring.
>=20
> I can think of two possible solutons:
> - Emit each fence individually, with a short delay in between to give a
> chance to the GFX ring to catch up with the KIQ.
> - Change the wait_reg_mem command used for the pipeline sync to allow
> greater than equal instead of just equal. Then it's enough to signal just
> the last fence on the KIQ ring.

On a second thought, both of my suggestions are wrong because they would ca=
use=20
the fences of non-guilty jobs to be emitted before the jobs are actually=20
complete.

It occurs to me that we could change the gfx pipeline sync to not rely on t=
he=20
same fences that signal job completion. Instead we could emit a different f=
ence=20
for just the pipeline sync. Then it is no longer a problem to signal those=
=20
during recovery.

>=20
> > +	amdgpu_ring_commit(kiq_ring);
> > +	r =3D amdgpu_ring_test_ring(kiq_ring);
> > +	spin_unlock_irqrestore(&kiq->ring_lock, flags);
> > +	if (r)
> > +		return r;
> > +
> > +	if (amdgpu_ring_alloc(ring, 8 + 7 + 5 + 2 + 8 + 7))
> > +		return -ENOMEM;
> > +	/* emit the fence to finish the reset - 8 */
> > +	ring->trail_seq++;
> > +	gfx_v9_0_ring_emit_fence(ring, ring->trail_fence_gpu_addr,
> > +				 ring->trail_seq,
>=20
> AMDGPU_FENCE_FLAG_EXEC);
>=20
> > +	/* wait for the fence - 7 */
> > +	gfx_v9_0_wait_reg_mem(ring, 0, 1, 0,
> > +			      lower_32_bits(ring-
> >
> >trail_fence_gpu_addr),
> >
> > +			      upper_32_bits(ring-
> >
> >trail_fence_gpu_addr),
> >
> > +			      ring->trail_seq, 0xffffffff, 4);
> > +	/* clear mmCP_VMID_RESET - 5 */
> > +	gfx_v9_0_ring_emit_wreg_me(ring,
> > +				   SOC15_REG_OFFSET(GC, 0,
>=20
> mmCP_VMID_RESET), 0);
>=20
> > +	/* event write ENABLE_LEGACY_PIPELINE - 2 */
> > +	gfx_v9_0_ring_emit_event_write(ring, ENABLE_LEGACY_PIPELINE, 0);
> > +	/* emit a regular fence - 8 */
> > +	ring->trail_seq++;
> > +	gfx_v9_0_ring_emit_fence(ring, ring->trail_fence_gpu_addr,
> > +				 ring->trail_seq,
>=20
> AMDGPU_FENCE_FLAG_EXEC);
>=20
> > +	/* wait for the fence - 7 */
> > +	gfx_v9_0_wait_reg_mem(ring, 1, 1, 0,
> > +			      lower_32_bits(ring-
> >
> >trail_fence_gpu_addr),
> >
> > +			      upper_32_bits(ring-
> >
> >trail_fence_gpu_addr),
> >
> > +			      ring->trail_seq, 0xffffffff, 4);
>=20
> Why is it necessary to emit (and wait for) a regular fence here?
> I'm not against it, just curious why it's needed.
>=20
> > +	amdgpu_ring_commit(ring);
> > +	/* wait for the commands to complete */
> > +	r =3D amdgpu_ring_test_ring(ring);
> > +	if (r)
> > +		return r;
> > +
> > +	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
> > +}
> > +
> >=20
> >  static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
> > =20
> >  			      unsigned int vmid,
> >  			      struct amdgpu_fence *timedout_fence)
> >=20
> > @@ -7441,9 +7540,9 @@ static const struct amdgpu_ring_funcs
> > gfx_v9_0_ring_funcs_gfx =3D { .emit_wreg =3D gfx_v9_0_ring_emit_wreg,
> >=20
> >  	.emit_reg_wait =3D gfx_v9_0_ring_emit_reg_wait,
> >  	.emit_reg_write_reg_wait =3D gfx_v9_0_ring_emit_reg_write_reg_wait,
> >=20
> > -	.soft_recovery =3D gfx_v9_0_ring_soft_recovery,
>=20
> Can you please split removing the soft recovery into a separate patch?
>=20
> Can we talk about removing the soft recovery? For the other chips where it
> has already been removed, it is percieved by users as a regression.
>=20
> >  	.emit_mem_sync =3D gfx_v9_0_emit_mem_sync,
> >  	.emit_cleaner_shader =3D gfx_v9_0_ring_emit_cleaner_shader,
> >=20
> > +	.reset =3D gfx_v9_0_reset_kgq,
> >=20
> >  	.begin_use =3D amdgpu_gfx_enforce_isolation_ring_begin_use,
> >  	.end_use =3D amdgpu_gfx_enforce_isolation_ring_end_use,
> > =20
> >  };
> >=20
> > @@ -7542,7 +7641,6 @@ static const struct amdgpu_ring_funcs
> > gfx_v9_0_ring_funcs_compute =3D { .emit_wreg =3D gfx_v9_0_ring_emit_wre=
g,
> >=20
> >  	.emit_reg_wait =3D gfx_v9_0_ring_emit_reg_wait,
> >  	.emit_reg_write_reg_wait =3D gfx_v9_0_ring_emit_reg_write_reg_wait,
> >=20
> > -	.soft_recovery =3D gfx_v9_0_ring_soft_recovery,
> >=20
> >  	.emit_mem_sync =3D gfx_v9_0_emit_mem_sync,
> >  	.emit_wave_limit =3D gfx_v9_0_emit_wave_limit,
> >  	.reset =3D gfx_v9_0_reset_kcq,




