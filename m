Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19437D68BDD
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Dec 2025 05:11:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97C1210E374;
	Thu, 18 Dec 2025 05:11:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GZUtB4/I";
	dkim-atps=neutral
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com
 [209.85.210.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C33310E374
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Dec 2025 05:11:48 +0000 (UTC)
Received: by mail-ot1-f49.google.com with SMTP id
 46e09a7af769-7c6ce4f65f7so201081a34.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Dec 2025 21:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766034707; x=1766639507; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xIb6xIEXcJ+lcR3l06J59UfkaQPmYOoKaKa7knW9GoE=;
 b=GZUtB4/I7Mn54dJ5EpwMtpLSLww/M9hDUJaIhV0xPAPCyp2kTCvvQLAIyFuz3KCO3J
 dDO/GUjc+ntVetv4tedncjtXyZw/jARJ/KPky1i/810sHX1i/+tFUbVChfqS1VRBGuFv
 Hp3Eei0bYC2L2KUu4xfy1Tve/p94e2nJXw1QeoAYZrBFEWLBtntssN+Qvm4lpdUI2HCe
 CDBUkcbQhCTYa6ZYmAj4olXo5zBiNKdMRra1QhqeK0li/14/UFHEDpoi3Fqy4WRqgLBl
 ZqrzHCaZhwAEcdpqBxEYbKEs7MBFZZrFleJ7mHAfoPgNjyI/IbLGHVki/R9Pk9U+wxCg
 6/BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766034707; x=1766639507;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xIb6xIEXcJ+lcR3l06J59UfkaQPmYOoKaKa7knW9GoE=;
 b=sPfklcx3g4zvUUScZpX9WpqhAY928oNWrAETR8jrd5w1MqReUfcmFGnLLJkpX76LoU
 hsGCs1UGi7c+8GPASBaD7kH6AkLEerSAZ9XiPv9pYv0BzqKR5VL7ikwe3vbZDbEegrfY
 cCKZ0vooGEbV7kYy5sl6iitKEiQP8nBtmB6ypfyBPCdUTObnM1o5+usQbdMiuvcyYIWm
 uerMvQF/JznTBfzHUJ7l8a55m7RF5SpB9mxG0jsMUPAuOayYQOzA9lTYRPgEgpVEWIFy
 wVAmEwwkxdkdt5C8WKzyPQvKefmmwvz+o/WWDfJPg0HddwxZQ+1Yg6WhOuof+GAQvVoH
 4Vfw==
X-Gm-Message-State: AOJu0YwxtKS5qLrrsUsKYJsJzFDAG68/OijT2y/ba0Mh9JA/FZZWc6/Z
 /px3qHFots2oakDFdNATVud1LA+dqXePmx/hNpaE873aLeQNvuUGRToIQNCfzbwYzyY=
X-Gm-Gg: AY/fxX5YkRcjkZfwMc2Jfrl3jM9KsDfMnj9h37AfhzjXZlrzk+4j1smaDfKRQWBY5nL
 EengkaPxRu+5Y1vlhCN6VA/7NFk9npPG8jVzuyuVIVSR9j83VzPdx59POY62XyIqlxp9kccwdQY
 JdxhfSPzzbLqWiKumRfvPHneQGVgYwks8U5tHoGoWndpuXTxgec0ITuzXSt2Yc3ckgUqvzIvKae
 n7myw4NOYxNVdQ8Vi37QLUGZpSYUD1AHXjv5kGeMGuDU69qAguseC0a0l1LyLKutLRatIgoObuC
 UB8Spq6r/xexiFo5FkNdGQeWZW9VXG59fcdkntScFWfv2W/YQE2iDFO20afbYKt9HHmBKxJQcKO
 GgaF1VcrYuYiDP8FmPvWhJy2SsyXpdipXq4wy0bQZ1i3ib7sRUzK3eZE/8qickmZU1jL6xz9JTT
 e6Irbbb5hEdLmowNgikWBCwLd8iqk=
X-Google-Smtp-Source: AGHT+IGT0Dt5XhKh/qxOcaHfRotoL2DUJrLLgVh1rf5BPJrMclNVBz/nv0HxLg0gV+0hRE3o/GDOmw==
X-Received: by 2002:a05:6830:349b:b0:7c7:68d6:5925 with SMTP id
 46e09a7af769-7cae837476dmr9710472a34.27.1766034707129; 
 Wed, 17 Dec 2025 21:11:47 -0800 (PST)
Received: from timur-max.localnet ([189.171.135.243])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cc59a63a88sm980180a34.5.2025.12.17.21.11.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Dec 2025 21:11:46 -0800 (PST)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH 6/6] drm/amdgpu/gfx9: Implement KGQ ring reset
Date: Wed, 17 Dec 2025 23:11:45 -0600
Message-ID: <2952111.fDdHjke4Dd@timur-max>
In-Reply-To: <20251215160711.11832-6-alexander.deucher@amd.com>
References: <20251215160711.11832-1-alexander.deucher@amd.com>
 <20251215160711.11832-6-alexander.deucher@amd.com>
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

On 2025. december 15., h=C3=A9tf=C5=91 10:07:11 k=C3=B6z=C3=A9ps=C5=91 =C3=
=A1llamokbeli z=C3=B3naid=C5=91 Alex Deucher=20
wrote:
> GFX ring resets work differently on pre-GFX10 hardware since
> there is no MQD managed by the scheduler.
> For ring reset, you need issue the reset via CP_VMID_RESET
> via KIQ or MMIO and submit the following to the gfx ring to
> complete the reset:
> 1. EOP packet with EXEC bit set
> 2. WAIT_REG_MEM to wait for the fence
> 3. Clear CP_VMID_RESET to 0
> 4. EVENT_WRITE ENABLE_LEGACY_PIPELINE
> 5. EOP packet with EXEC bit set
> 6. WAIT_REG_MEM to wait for the fence
> Once those commands have completed the reset should
> be complete and the ring can accept new packets.
>=20
> However, because we have a pipeline sync between jobs,
> the PFP is waiting on the fence from the bad job to signal so
> it can't process any of the packets in the reset sequence
> until that pipeline sync clears.  To unblock the PFP, we
> use the KIQ to signal the fence after we reset the queue.
>=20
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 104 +++++++++++++++++++++++++-
>  1 file changed, 101 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c index bb1465a98c7ca..9b7073650315e
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -2410,8 +2410,10 @@ static int gfx_v9_0_sw_init(struct amdgpu_ip_block
> *ip_block) amdgpu_get_soft_full_reset_mask(&adev->gfx.gfx_ring[0]);
>  	adev->gfx.compute_supported_reset =3D
>  		amdgpu_get_soft_full_reset_mask(&adev-
>gfx.compute_ring[0]);
> -	if (!amdgpu_sriov_vf(adev) && !adev->debug_disable_gpu_ring_reset)
> +	if (!amdgpu_sriov_vf(adev) && !adev->debug_disable_gpu_ring_reset)=20
{
>  		adev->gfx.compute_supported_reset |=3D=20
AMDGPU_RESET_TYPE_PER_QUEUE;
> +		adev->gfx.gfx_supported_reset |=3D=20
AMDGPU_RESET_TYPE_PER_QUEUE;
> +	}
>=20
>  	r =3D amdgpu_gfx_kiq_init(adev, GFX9_MEC_HPD_SIZE, 0);
>  	if (r) {
> @@ -7163,6 +7165,103 @@ static void gfx_v9_ring_insert_nop(struct
> amdgpu_ring *ring, uint32_t num_nop) amdgpu_ring_insert_nop(ring, num_nop=
 -
> 1);
>  }
>=20
> +static void gfx_v9_0_ring_emit_wreg_me(struct amdgpu_ring *ring,
> +				       uint32_t reg,
> +				       uint32_t val)
> +{
> +	uint32_t cmd =3D 0;
> +
> +	switch (ring->funcs->type) {
> +	case AMDGPU_RING_TYPE_KIQ:
> +		cmd =3D (1 << 16); /* no inc addr */

What do you mean by "inc addr" in this context?

> +		break;
> +	default:
> +		cmd =3D WR_CONFIRM;
> +		break;
> +	}
> +	amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
> +	amdgpu_ring_write(ring, cmd);
> +	amdgpu_ring_write(ring, reg);
> +	amdgpu_ring_write(ring, 0);
> +	amdgpu_ring_write(ring, val);
> +}
> +
> +static void gfx_v9_0_ring_emit_event_write(struct amdgpu_ring *ring,
> +					   uint32_t event_type,
> +					   uint32_t=20
event_index)
> +{
> +	amdgpu_ring_write(ring, PACKET3(PACKET3_EVENT_WRITE, 0));
> +	amdgpu_ring_write(ring, EVENT_TYPE(event_type) |
> +			  EVENT_INDEX(event_index));
> +}
> +
> +static int gfx_v9_0_reset_kgq(struct amdgpu_ring *ring,
> +			      unsigned int vmid,
> +			      struct amdgpu_fence *timedout_fence)
> +{
> +	struct amdgpu_device *adev =3D ring->adev;
> +	struct amdgpu_kiq *kiq =3D &adev->gfx.kiq[0];
> +	struct amdgpu_ring *kiq_ring =3D &kiq->ring;
> +	unsigned long flags;
> +	u32 tmp;
> +	int r;
> +
> +	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
> +
> +	spin_lock_irqsave(&kiq->ring_lock, flags);
> +
> +	if (amdgpu_ring_alloc(kiq_ring, 5 + 5)) {
> +		spin_unlock_irqrestore(&kiq->ring_lock, flags);
> +		return -ENOMEM;
> +	}
> +
> +	/* send the reset - 5 */
> +	tmp =3D REG_SET_FIELD(0, CP_VMID_RESET, RESET_REQUEST, 1 << vmid);
> +	gfx_v9_0_ring_emit_wreg(kiq_ring,
> +				SOC15_REG_OFFSET(GC, 0,=20
mmCP_VMID_RESET), tmp);
> +	/* emit the fence to clear the pipeline sync - 5 */
> +	gfx_v9_0_ring_emit_fence_kiq(kiq_ring, ring->fence_drv.gpu_addr,
> +				     timedout_fence->base.seqno,=20
0);

As far as I see, this isn't going to work when sched_hw_submission > 2 and=
=20
there are more than two jobs (from various different userspace processes)=20
emitted in the ring.

I can think of two possible solutons:
=2D Emit each fence individually, with a short delay in between to give a c=
hance=20
to the GFX ring to catch up with the KIQ.
=2D Change the wait_reg_mem command used for the pipeline sync to allow gre=
ater=20
than equal instead of just equal. Then it's enough to signal just the last=
=20
fence on the KIQ ring.



> +	amdgpu_ring_commit(kiq_ring);
> +	r =3D amdgpu_ring_test_ring(kiq_ring);
> +	spin_unlock_irqrestore(&kiq->ring_lock, flags);
> +	if (r)
> +		return r;
> +
> +	if (amdgpu_ring_alloc(ring, 8 + 7 + 5 + 2 + 8 + 7))
> +		return -ENOMEM;
> +	/* emit the fence to finish the reset - 8 */
> +	ring->trail_seq++;
> +	gfx_v9_0_ring_emit_fence(ring, ring->trail_fence_gpu_addr,
> +				 ring->trail_seq,=20
AMDGPU_FENCE_FLAG_EXEC);
> +	/* wait for the fence - 7 */
> +	gfx_v9_0_wait_reg_mem(ring, 0, 1, 0,
> +			      lower_32_bits(ring-
>trail_fence_gpu_addr),
> +			      upper_32_bits(ring-
>trail_fence_gpu_addr),
> +			      ring->trail_seq, 0xffffffff, 4);
> +	/* clear mmCP_VMID_RESET - 5 */
> +	gfx_v9_0_ring_emit_wreg_me(ring,
> +				   SOC15_REG_OFFSET(GC, 0,=20
mmCP_VMID_RESET), 0);
> +	/* event write ENABLE_LEGACY_PIPELINE - 2 */
> +	gfx_v9_0_ring_emit_event_write(ring, ENABLE_LEGACY_PIPELINE, 0);
> +	/* emit a regular fence - 8 */
> +	ring->trail_seq++;
> +	gfx_v9_0_ring_emit_fence(ring, ring->trail_fence_gpu_addr,
> +				 ring->trail_seq,=20
AMDGPU_FENCE_FLAG_EXEC);
> +	/* wait for the fence - 7 */
> +	gfx_v9_0_wait_reg_mem(ring, 1, 1, 0,
> +			      lower_32_bits(ring-
>trail_fence_gpu_addr),
> +			      upper_32_bits(ring-
>trail_fence_gpu_addr),
> +			      ring->trail_seq, 0xffffffff, 4);

Why is it necessary to emit (and wait for) a regular fence here?
I'm not against it, just curious why it's needed.

> +	amdgpu_ring_commit(ring);
> +	/* wait for the commands to complete */
> +	r =3D amdgpu_ring_test_ring(ring);
> +	if (r)
> +		return r;
> +
> +	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
> +}
> +
>  static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
>  			      unsigned int vmid,
>  			      struct amdgpu_fence *timedout_fence)
> @@ -7441,9 +7540,9 @@ static const struct amdgpu_ring_funcs
> gfx_v9_0_ring_funcs_gfx =3D { .emit_wreg =3D gfx_v9_0_ring_emit_wreg,
>  	.emit_reg_wait =3D gfx_v9_0_ring_emit_reg_wait,
>  	.emit_reg_write_reg_wait =3D gfx_v9_0_ring_emit_reg_write_reg_wait,
> -	.soft_recovery =3D gfx_v9_0_ring_soft_recovery,

Can you please split removing the soft recovery into a separate patch?

Can we talk about removing the soft recovery? For the other chips where it =
has=20
already been removed, it is percieved by users as a regression.

>  	.emit_mem_sync =3D gfx_v9_0_emit_mem_sync,
>  	.emit_cleaner_shader =3D gfx_v9_0_ring_emit_cleaner_shader,
> +	.reset =3D gfx_v9_0_reset_kgq,
>  	.begin_use =3D amdgpu_gfx_enforce_isolation_ring_begin_use,
>  	.end_use =3D amdgpu_gfx_enforce_isolation_ring_end_use,
>  };
> @@ -7542,7 +7641,6 @@ static const struct amdgpu_ring_funcs
> gfx_v9_0_ring_funcs_compute =3D { .emit_wreg =3D gfx_v9_0_ring_emit_wreg,
>  	.emit_reg_wait =3D gfx_v9_0_ring_emit_reg_wait,
>  	.emit_reg_write_reg_wait =3D gfx_v9_0_ring_emit_reg_write_reg_wait,
> -	.soft_recovery =3D gfx_v9_0_ring_soft_recovery,
>  	.emit_mem_sync =3D gfx_v9_0_emit_mem_sync,
>  	.emit_wave_limit =3D gfx_v9_0_emit_wave_limit,
>  	.reset =3D gfx_v9_0_reset_kcq,




