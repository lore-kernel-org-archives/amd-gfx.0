Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977AE606A335
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Nov 2026 11:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=03GNdPCi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A0B2112306;
	Thu, 19 Nov 2026 11:47:15 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED965112322
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 11:47:08 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-490d59c3edaso605354f8f.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 03:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795088827; x=1795693627; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=MgVkb48sL4tFM75FtgxLJzFN8qSyFQmjdlzcKgC1ds0=;
 b=03GNdPCiOheWVa1fU3ellB4ugYblVxpFqqeADP3ocG+MM/9713OJwTAAt1JOr698+2
 Z7SnUJVf5kt6Bvt4OLwYcnadxuwKSmjtJCeIqyJqdr9zmJ4nZv7lkWLLlRcpFGjLci4M
 t4TEF/85hkDtg4SAXQx9iLWgVj0Ha1RdkCWSs73wz3+4x33MDW/VpyraV0/C7oBN8TBY
 Au4Ds8Kpzt4oitUJwuBXPXE+aPBaA4k1CmrA64L1Fke11S4RKDmr5bm3xR9bjxuLtojS
 sSvu707RJJ0pHGNMlP//OENroLDrALrWPABcDHX813qWOndZw9TpDtdmvQfSIVFS3ugD
 5IRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795088827; x=1795693627;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MgVkb48sL4tFM75FtgxLJzFN8qSyFQmjdlzcKgC1ds0=;
 b=sct7qRsArTP+lRRMkcZYnq16F/8qpJuLgnsYxZASH4LYXq0/stKUY0BzJJLtswCW/j
 UdJoIGLkdVRv0+bTanIKmQiAGLUNoE/67BunpuP9dED81XxobYgPPLXMhSnYFsfvH3rf
 Mjvnfnhqn9Qofvw2CZUTJBKCcg1y8UOGiLYGT1SUWySEZjOepp3MlIIJEn1arHa68BOP
 EHFb+n4NPt0vetDYRdk+2vuPnJxvssoC7lWhy6t656Johd9AWhCb3afQVL4Nz+cROmGl
 H3kfNJ9prxwyFrLXsbTMOOAx2jNQpQ0HL0ycATKKxJalfbxfeqRXGA9t0c6W7xAWoLJk
 c6+A==
X-Forwarded-Encrypted: i=1;
 AL+hErEwXcbuW1eLvnYoCm1zWfctOQgYeVng2DdMUNJ/bvMduqaw1bYPuG3shjMkfZUQ8PByVdUlXqCW@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/Udzl41zsU+wTxKyzPSF6R5aOzECWmkEEHfOhSSuNgwFRhno3t
 szyKJ3Ddpbc/T23QGZsNnVWz7fXmA8KullxpDo2jc3fc6WPMJyMnirnI
X-Gm-Gg: AZFdTZfmvVMGJ6wosFW4eJPtw9nD50sqoqVcKDBHhE+9yy9pB9gA0A9ozEfhtIVFHMH
 QSsqtboPqcf2f3YEkP0iDWZWHoruEUDsMyDdfB3LnPI5YsC8VCdp7RCji+cR8p7EUYncoxRYkET
 B5euc2TlPXkuXpBZPxNdw3Be2HxXJmLtJxzC5/jSY6UFHHt6xsVFoZpEQODTiY58qnLRYlRFm8a
 cwDn+f/IhB4SEVgCjueSMooWhVrM34f65OiLTUk+smCtB0GZS0s9qlCoPU9EzrSapeOGlY4rj17
 mlnqCyxFoNng7Ae62b1F8k3+k5kRG89lm0bV0qpmifg49cRrY/j81B8Nue0ec7/lAMYT+krYXIX
 3KPSPhkT/ZBWTBecCQSQdRowwMU/FDT9Ke7DDrguCqxDXWxX+8zNOwqY3BdRT54782t7Iq3AKyJ
 +KEmxXN8miAQ9mUpjvjoR9bDpsvV386pjnNxo35VnsfJiZn0/Ll9C1iMsBOSu5+DCDkxAC4YJwG
 GKKe8IVwxYlZgBoU0PdWRJGtn7z+dkpx2RhkZq27MCr79exJM0EfAXZoY0ygqyg1RPKlwsCnq9g
 vdkBVoj+MLxxkJDG7GP9PRPXgVKu7V+90s0sowatW2UM0rLfeNaJJOoKKd+y5POeiDFJinMKvLc
 A8mAU
X-Received: by 2002:a05:6000:2083:b0:491:cd7:e96b with SMTP id
 ffacd0b85a97d-4aa5710d738mr2209723f8f.15.1795088827183; 
 Thu, 19 Nov 2026 03:47:07 -0800 (PST)
Received: from [192.168.1.71] (115.red-2-136-224.staticip.rima-tde.net.
 [2.136.224.115]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a655f9f53dsm9387995f8f.35.2026.11.19.03.47.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 03:47:06 -0800 (PST)
Message-ID: <22d20d88c1d6a8284f5945dd33102af9150a5d1a.camel@gmail.com>
Subject: Re: [PATCH v4 10/13] drm/amdgpu/gfx11: add a gfx engine soft reset
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>, 
 Lijo.Lazar@amd.com, Mario.Novales@amd.com, Manu.Rastogi@amd.com, 
 Jiongyu.Zhu@amd.com
Date: Thu, 19 Nov 2026 12:47:05 +0100
In-Reply-To: <20261105030612.726542-10-Jesse.Zhang@amd.com>
References: <20261105030612.726542-1-Jesse.Zhang@amd.com>
 <20261105030612.726542-10-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 2026-11-05 at 11:05 +0800, Jesse Zhang wrote:
> Implement soft_reset_engine() for the graphics engine of gfx11, as
> for
> gfx12, with two differences:
> - clear CP_VMID_RESET: a VMID reset the hung PFP didn't handle
> survives
> =C2=A0 the CPF/CPG reset;
> - boot PFP/ME with CP_PFP_IB_CONTROL cleared and restore it
> afterwards:
> =C2=A0 set, it makes the F32 PFP of the APUs resume from power gating and
> wait
> =C2=A0 for a clear state that never comes.
>=20
> The CPF/CPG reset already puts PFP/ME back at their firmware start
> address, so unhalting them restarts the RS64 and F32 firmware alike.
>=20
> v4: Implement soft_reset_engine() directly instead of a reset_engine
> gfx
> =C2=A0=C2=A0=C2=A0 callback, drop gfx_v11_0_restart_gfx_rs64(), and boot =
with
> =C2=A0=C2=A0=C2=A0 CP_PFP_IB_CONTROL cleared for the F32 firmware (Timur)=
.
>=20
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
> =C2=A0drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 134
> +++++++++++++++++++++++++
> =C2=A01 file changed, 134 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 798015689f0c..80b91459f5b0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -6777,6 +6777,139 @@ static void gfx_v11_0_emit_mem_sync(struct
> amdgpu_ring *ring)
> =C2=A0	amdgpu_ring_write(ring, gcr_cntl); /* GCR_CNTL */
> =C2=A0}
> =C2=A0
> +/* The CP DMA and the interfaces its memory requests go through */
> +#define GFX11_CP_STAT_MEM_BUSY	(CP_STAT__DMA_BUSY_MASK | \
> +				 CP_STAT__TCIU_BUSY_MASK | \
> +				 CP_STAT__RCIU_BUSY_MASK | \
> +				 CP_STAT__UTCL2IU_BUSY_MASK)
> +
> +/* Reset CPF/CPG, PFP/ME and the gfx HQDs, then boot PFP/ME again.
> */
> +static int gfx_v11_0_soft_reset_gfx_cp(struct amdgpu_device *adev)
> +{
> +	u32 tmp, cntl, me_cntl, ib_control;
> +	int i;
> +
> +	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
> +	/* MES fetches its queues through CPF: keep it out of the
> reset. */
> +	amdgpu_mes_lock(&adev->mes);

I wonder if we should lock the SRBM mutex here. What do you think?

> +
> +	me_cntl =3D RREG32_SOC15(GC, 0, regCP_ME_CNTL);
> +	ib_control =3D RREG32_SOC15(GC, 0,
> regCP_PFP_IB_CONTROL);	/* cleared by the reset */
> +
> +	tmp =3D REG_SET_FIELD(me_cntl, CP_ME_CNTL, ME_HALT, 1);
> +	tmp =3D REG_SET_FIELD(tmp, CP_ME_CNTL, PFP_HALT, 1);
> +	WREG32_SOC15(GC, 0, regCP_ME_CNTL, tmp);
> +	udelay(50);
> +
> +	/* A CP DMA in flight during the reset leaves the ME busy
> after it. */
> +	for (i =3D 0; i < adev->usec_timeout; i++) {
> +		if (!(RREG32_SOC15(GC, 0, regCP_STAT) &
> GFX11_CP_STAT_MEM_BUSY))
> +			break;
> +		udelay(1);
> +	}
> +
> +	/* GFX_ONLY keeps compute and MES out; CPF alone leaves the
> stream stuck. */
> +	cntl =3D RREG32_SOC15(GC, 0, regCP_SOFT_RESET_CNTL);
> +	tmp =3D REG_SET_FIELD(cntl, CP_SOFT_RESET_CNTL,
> GFX_ONLY_SOFT_RESET, 1);
> +	tmp =3D REG_SET_FIELD(tmp, CP_SOFT_RESET_CNTL,
> GFX_HQD_REG_RESET, 1);
> +	WREG32_SOC15(GC, 0, regCP_SOFT_RESET_CNTL, tmp);
> +
> +	tmp =3D RREG32_SOC15(GC, 0, regGRBM_SOFT_RESET);
> +	tmp =3D REG_SET_FIELD(tmp, GRBM_SOFT_RESET, SOFT_RESET_CPF,
> 1);
> +	tmp =3D REG_SET_FIELD(tmp, GRBM_SOFT_RESET, SOFT_RESET_CPG,
> 1);

I just tested this on Strix Halo (GFX11.5).
We need to set the SOFT_RESET_GFX bit here in order to reset the fixed-
function graphics pipeline. Otherwise this can't recover from cases
when the fixed-function pipeline hangs, for example a buggy NGG shader.

> +	WREG32_SOC15(GC, 0, regGRBM_SOFT_RESET, tmp);
> +	tmp =3D RREG32_SOC15(GC, 0, regGRBM_SOFT_RESET);

This line should be moved below the delay.

> +	udelay(50);
> +	tmp =3D REG_SET_FIELD(tmp, GRBM_SOFT_RESET, SOFT_RESET_CPF,
> 0);
> +	tmp =3D REG_SET_FIELD(tmp, GRBM_SOFT_RESET, SOFT_RESET_CPG,
> 0);
> +	WREG32_SOC15(GC, 0, regGRBM_SOFT_RESET, tmp);
> +	tmp =3D RREG32_SOC15(GC, 0, regGRBM_SOFT_RESET);
> +
> +	WREG32_SOC15(GC, 0, regCP_SOFT_RESET_CNTL, cntl);
> +
> +	/* The halted PFP stays busy: only wait for the memory
> requests. */
> +	for (i =3D 0; i < adev->usec_timeout; i++) {
> +		if (!(RREG32_SOC15(GC, 0, regCP_STAT) &
> GFX11_CP_STAT_MEM_BUSY))
> +			break;
> +		udelay(1);
> +	}
> +	/* A VMID reset the hung PFP didn't handle survives the
> reset. */
> +	WREG32_SOC15(GC, 0, regCP_VMID_RESET, 0);

Does this introduce a race condition between per-queue resets and the
soft reset? I mean, what happens if we are doing a queue reset on a
compute queue at the same time while this function is resetting the GFX
engine?

> +	amdgpu_mes_unlock(&adev->mes);
> +
> +	tmp =3D RREG32_SOC15(GC, 0, regCP_ME_CNTL);
> +	tmp =3D REG_SET_FIELD(tmp, CP_ME_CNTL, CE_HALT,
> +			=C2=A0=C2=A0=C2=A0 REG_GET_FIELD(me_cntl, CP_ME_CNTL,
> CE_HALT));
> +	WREG32_SOC15(GC, 0, regCP_ME_CNTL, tmp);
> +	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
> +
> +	/*
> +	 * Boot with CP_PFP_IB_CONTROL cleared: set, it makes the
> F32 PFP resume
> +	 * from power gating and wait for a clear state that never
> comes.
> +	 */
> +	tmp =3D RREG32_SOC15(GC, 0, regCP_ME_CNTL);
> +	tmp =3D REG_SET_FIELD(tmp, CP_ME_CNTL, ME_HALT, 0);
> +	tmp =3D REG_SET_FIELD(tmp, CP_ME_CNTL, PFP_HALT, 0);
> +	WREG32_SOC15(GC, 0, regCP_ME_CNTL, tmp);
> +	for (i =3D 0; i < adev->usec_timeout; i++) {
> +		if (!RREG32_SOC15(GC, 0, regCP_STAT))
> +			break;
> +		udelay(1);
> +	}
> +	WREG32_SOC15(GC, 0, regCP_PFP_IB_CONTROL, ib_control);
> +
> +	return i < adev->usec_timeout ? 0 : -ETIMEDOUT;
> +}
> +
> +static int gfx_v11_0_soft_reset_engine(struct amdgpu_ip_block
> *ip_block,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum amdgpu_ring_type
> ring_type,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_usermode_queue
> *guilty_queue)
> +{
> +	struct amdgpu_device *adev =3D ip_block->adev;
> +	int i, r;
> +
> +	if (ring_type !=3D AMDGPU_RING_TYPE_GFX)
> +		return -EOPNOTSUPP;
> +
> +	mutex_lock(&adev->gfx.mec.reset_mutex);
> +	amdgpu_gfx_off_ctrl(adev, false);
> +
> +	/* A hung gfx stream can keep MES from suspending: reset
> anyway. */
> +	amdgpu_mes_suspend(adev, 0);
> +	amdgpu_userq_save_hqds(adev, AMDGPU_HW_IP_GFX);
> +
> +	r =3D gfx_v11_0_soft_reset_gfx_cp(adev);
> +	if (r) {
> +		dev_err(adev->dev, "gfx CP still busy after reset,
> CP_STAT 0x%08x\n",
> +			RREG32_SOC15(GC, 0, regCP_STAT));
> +		goto fail;
> +	}
> +
> +	/* The reset cleared the HQD of the kernel gfx queue: map it
> again. */
> +	r =3D amdgpu_gfx_disable_kgq(adev, 0);
> +	if (r)
> +		goto fail;
> +	for (i =3D 0; i < adev->gfx.num_gfx_rings; i++)
> +		amdgpu_gfx_mqd_reset_restore(&adev-
> >gfx.gfx_ring[i]);
> +	r =3D amdgpu_gfx_enable_kgq(adev, 0);
> +	if (!r)
> +		r =3D gfx_v11_0_cp_gfx_start(adev);
> +	if (r)
> +		goto fail;
> +
> +	amdgpu_userq_restore_hqds(adev, AMDGPU_HW_IP_GFX,
> guilty_queue);
> +	r =3D amdgpu_mes_resume(adev, 0);
> +	goto out;
> +
> +fail:
> +	amdgpu_userq_clear_hqds(adev, AMDGPU_HW_IP_GFX);
> +	amdgpu_mes_resume(adev, 0);
> +out:
> +	amdgpu_gfx_off_ctrl(adev, true);
> +	mutex_unlock(&adev->gfx.mec.reset_mutex);
> +	return r;
> +}
> +
> =C2=A0#define GFX11_HPD_QUEUE_STATE_CONNECTED_MIN	3
> =C2=A0#define GFX11_HPD_QUEUE_STATE_CONNECTED_MAX	15
> =C2=A0
> @@ -7045,6 +7178,7 @@ static const struct amd_ip_funcs
> gfx_v11_0_ip_funcs =3D {
> =C2=A0	.suspend =3D gfx_v11_0_suspend,
> =C2=A0	.resume =3D gfx_v11_0_resume,
> =C2=A0	.wait_for_idle =3D gfx_v11_0_wait_for_idle,
> +	.soft_reset_engine =3D gfx_v11_0_soft_reset_engine,
> =C2=A0	.soft_reset =3D gfx_v11_0_soft_reset,
> =C2=A0	.set_clockgating_state =3D gfx_v11_0_set_clockgating_state,
> =C2=A0	.set_powergating_state =3D gfx_v11_0_set_powergating_state,
