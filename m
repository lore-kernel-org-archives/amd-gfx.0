Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A653606A320
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Nov 2026 11:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mKK3xPVI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 984D210E6D1;
	Thu, 19 Nov 2026 11:42:54 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3764310E6D1
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 11:42:48 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-4a357b1c649so1349271f8f.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 03:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795088566; x=1795693366; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Ti4mTGv1hOcHPBD2Bh0m2ZcHPJyOAs96Y5CwUxOCUAk=;
 b=mKK3xPVI0sD2K6bFoLlTizh3iySfhrQiVmPMjX4q3uWGu11fUJuVcn1PZ9hhXPwZd3
 Hx2Wy1zanltFUmRx0zTAwK2rO1Dojw3krUcK7SwFp3YywI7i0JFeLIvjUn3/s6tuUJqt
 kktFlr97FSMFnpALvSwcpD0DoSPIV2Y+HtrwUjZy6KTBVlo4XSevxxkd/6ZlFScZxyw9
 0/8Z7BfHnh2VI0RPwnxetTNIkjF0kYPtnIdtX01pxZIAUuk5GqQkiLvViAInylrTng4O
 rYTO4vIT37EBwZzsX5G9w3XCNxltltvgMG4KMqwsxsaAblQbBZF2x9y4Ux50jY7YBwVK
 Xt/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795088566; x=1795693366;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ti4mTGv1hOcHPBD2Bh0m2ZcHPJyOAs96Y5CwUxOCUAk=;
 b=eArSzXvFWJ8u3M/MHYQcAR7o6eVW5ET3P4t/nLAg/y1oy1rqpjRRVf8wx5baDcd+0T
 XbOr/e/hD0R0T4PPeWdHfn0xKVFDCKAQyMpGCiaiop+oc/5TlCAPG/oVMuq3n5Ff24h5
 gBjGmZQvgpdMM65RfxkOCxGaER4K8w3zRM+PBbdEBho7ue9JGvEXsxhTEAAQ2/HjzlUi
 RmA2Di7xbmWtd6ufhej4uLbDq6v9nWOrEh0rKx1jbfjXsLDvDF0Pwofncx1GRJALiU9u
 tV7n8GPHjhv5C2rMsQpmOFBNmUhDwAZei94VPs9yzHWH4X9diRGhYPEopeAd5xHbP8LD
 3ECA==
X-Forwarded-Encrypted: i=1;
 AL+hErF0pUcyour4NR7/RKXJn+eSvMfLJIfe9CTk5wfeXlKexeK64fbNx4EnpDixzDhFkbRQUvphHYRG@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+MerJWdzvcU6ZPOqOvHDSTwt15949PiWgLC3cxscrlwPMqivKl
 csreyO8reUz/TBudAYXzDUEbiSyw+a+w9CmNOKlg7WctU7BC/qLC6/tl
X-Gm-Gg: AZFdTZeISj2Cdys/F5ePGjqIa2YYRwFx5+77PlLBvaBGKXn1dSWw15I4ZE1K9z6t0Pj
 RESoI8JrYmOUtvVDVjRKgcSXeX/ZoLz1IEQZ7Ahgf/pZO0/OEOUI8RUB6CZLDQdx8MDK539FBFv
 9OUiQnA1nZANsGMQWfCgamP4vX1AgF8z3YjVZiahzxPREoX7nwlu2qnpgxtU6Xa2w7IR5yCsLEE
 hKyjxJFsf6IrkAxw9jR5tLMlw0W48GiHAMqRh60+Qpb9SBld3C517fLm7n8obfy1f3b9xHwftwh
 j4w1zYcvzOVayjlKvxzLit7De15DU6pYuWjLG8RS34nsPiVOO6UzS9ls9C4CiRbxluhYSvvtKno
 heRWPfKeBOaeta/5wyDbby/gaOnu3OBzaxnQ2o4+dikn9L0sH8QucV/1bDRHEXfg53hF1gYC+gY
 bsMJqLJLOC64vpKX2Tg///I+95m46UroQ8BxDaZ80R1VG2DwxlRoQTF96K49bPQXWugEj1Xq8rE
 FzLkFUeVOwknFOfaZsdfffoJMvVaV94/3w52PxF47qU3cn3IeMG323jWHoEhWVbfIU0cTiW9GaC
 LcM4ZghOqB+Yt/SpEbTLsPPm2sOmde68zcuz/kGRSCuQt3N0mJ8aQPPf/NzS5CcLoNs5nRwDYc3
 WHqBW
X-Received: by 2002:a5d:64c8:0:b0:493:1004:96f7 with SMTP id
 ffacd0b85a97d-4a63d1d9aeamr12271272f8f.54.1795088566500; 
 Thu, 19 Nov 2026 03:42:46 -0800 (PST)
Received: from [192.168.1.71] (115.red-2-136-224.staticip.rima-tde.net.
 [2.136.224.115]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a65693389dsm9356698f8f.48.2026.11.19.03.42.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 03:42:46 -0800 (PST)
Message-ID: <7f108e1161bc2825a5d8f542ee3b7c8b6cabf399.camel@gmail.com>
Subject: Re: [PATCH v4 09/13] drm/amdgpu/gfx12: add a gfx engine soft reset
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>, 
 Lijo.Lazar@amd.com, Mario.Novales@amd.com, Manu.Rastogi@amd.com, 
 Jiongyu.Zhu@amd.com
Date: Thu, 19 Nov 2026 12:42:45 +0100
In-Reply-To: <20261105030612.726542-9-Jesse.Zhang@amd.com>
References: <20261105030612.726542-1-Jesse.Zhang@amd.com>
 <20261105030612.726542-9-Jesse.Zhang@amd.com>
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
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 2026-11-05 at 11:05 +0800, Jesse Zhang wrote:
> Some hangs leave the gfx streaming engine of the CP front-end stuck,
> eg.
> waiting for packet data that never arrives. Neither a queue nor a
> pipe
> reset can stop it, so they end in a full GPU reset.
>=20
> Implement soft_reset_engine() for the graphics engine: halt PFP/ME,
> pulse GRBM_SOFT_RESET.SOFT_RESET_CPF/CPG with
> CP_SOFT_RESET_CNTL.GFX_ONLY_SOFT_RESET and GFX_HQD_REG_RESET, restart
> PFP/ME and map the kernel gfx queue again.
> MEC, MES and the compute queues keep running. The MES lock is held
> across
> the pulse, as MES fetches its queues through CPF, and the CP DMA is
> drained around it, as a request in flight leaves the ME busy.
>=20
> MES is suspended meanwhile, and the gfx user queues the reset clears
> are
> saved and restored around it. If the CP doesn't go idle, the reset
> fails
> and a full reset follows.
>=20
> v4: Implement soft_reset_engine() directly instead of a reset_engine
> gfx
> =C2=A0=C2=A0=C2=A0 callback (Timur).
>=20
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
> =C2=A0drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 129
> +++++++++++++++++++++++++
> =C2=A01 file changed, 129 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> index 484e876fe235..8b96f2a29b1f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -3860,6 +3860,134 @@ static int gfx_v12_0_wait_for_idle(struct
> amdgpu_ip_block *ip_block)
> =C2=A0	return -ETIMEDOUT;
> =C2=A0}
> =C2=A0
> +/* The CP DMA and the interfaces its memory requests go through */
> +#define GFX12_CP_STAT_MEM_BUSY	(CP_STAT__DMA_BUSY_MASK | \
> +				 CP_STAT__TCIU_BUSY_MASK | \
> +				 CP_STAT__RCIU_BUSY_MASK | \
> +				 CP_STAT__UTCL2IU_BUSY_MASK)
> +
> +/* Reset CPF/CPG, PFP/ME and the gfx HQDs, then boot PFP/ME again.
> */
> +static int gfx_v12_0_soft_reset_gfx_cp(struct amdgpu_device *adev)
> +{
> +	u32 tmp, cntl, me_cntl, ib_control;
> +	int i;
> +
> +	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
> +	/* MES fetches its queues through CPF: keep it out of the
> reset. */
> +	amdgpu_mes_lock(&adev->mes);
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
> GFX12_CP_STAT_MEM_BUSY))
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

I still think that this needs the SOFT_RESET_GFX bit too.


> +	WREG32_SOC15(GC, 0, regGRBM_SOFT_RESET, tmp);
> +	tmp =3D RREG32_SOC15(GC, 0, regGRBM_SOFT_RESET);

This should be moved below the delay.

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
> GFX12_CP_STAT_MEM_BUSY))
> +			break;
> +		udelay(1);
> +	}
> +	amdgpu_mes_unlock(&adev->mes);

We should clear the CP_VMID_RESET register here, same as we do on
GFX11. It makes no sense for the CP to be doing a VMID reset while we
are soft-resetting it.

> +
> +	gfx_v12_0_set_pfp_ucode_start_addr(adev);
> +	gfx_v12_0_set_me_ucode_start_addr(adev);
> +	tmp =3D RREG32_SOC15(GC, 0, regCP_ME_CNTL);
> +	tmp =3D REG_SET_FIELD(tmp, CP_ME_CNTL, CE_HALT,
> +			=C2=A0=C2=A0=C2=A0 REG_GET_FIELD(me_cntl, CP_ME_CNTL,
> CE_HALT));
> +	WREG32_SOC15(GC, 0, regCP_ME_CNTL, tmp);
> +	WREG32_SOC15(GC, 0, regCP_PFP_IB_CONTROL, ib_control);

Why is it important to restore the CP_PFP_IB_CONTROL register?
The kernel driver currently never writes this register, isn't the
default value good enough?

> +	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
> +
> +	tmp =3D RREG32_SOC15(GC, 0, regCP_ME_CNTL);
> +	tmp =3D REG_SET_FIELD(tmp, CP_ME_CNTL, ME_HALT, 0);
> +	tmp =3D REG_SET_FIELD(tmp, CP_ME_CNTL, PFP_HALT, 0);
> +	WREG32_SOC15(GC, 0, regCP_ME_CNTL, tmp);
> +	for (i =3D 0; i < adev->usec_timeout; i++) {
> +		if (!RREG32_SOC15(GC, 0, regCP_STAT))
> +			return 0;
> +		udelay(1);
> +	}
> +	return -ETIMEDOUT;
> +}
> +
> +static int gfx_v12_0_soft_reset_engine(struct amdgpu_ip_block
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
> +	r =3D gfx_v12_0_soft_reset_gfx_cp(adev);
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
> +		r =3D gfx_v12_0_cp_gfx_start(adev);
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
> =C2=A0#define GFX12_HPD_QUEUE_STATE_CONNECTED_MIN	3
> =C2=A0#define GFX12_HPD_QUEUE_STATE_CONNECTED_MAX	15
> =C2=A0
> @@ -5375,6 +5503,7 @@ static const struct amd_ip_funcs
> gfx_v12_0_ip_funcs =3D {
> =C2=A0	.suspend =3D gfx_v12_0_suspend,
> =C2=A0	.resume =3D gfx_v12_0_resume,
> =C2=A0	.wait_for_idle =3D gfx_v12_0_wait_for_idle,
> +	.soft_reset_engine =3D gfx_v12_0_soft_reset_engine,
> =C2=A0	.set_clockgating_state =3D gfx_v12_0_set_clockgating_state,
> =C2=A0	.set_powergating_state =3D gfx_v12_0_set_powergating_state,
> =C2=A0	.get_clockgating_state =3D gfx_v12_0_get_clockgating_state,
