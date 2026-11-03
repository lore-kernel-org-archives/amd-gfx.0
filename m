Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88678606A31B
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2026 20:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JJetyill
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20F2110F7D3;
	Tue,  3 Nov 2026 20:22:37 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78C1010F7D3
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 20:22:30 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a214c5c4c0so41962245e9.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Nov 2026 12:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793737349; x=1794342149; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Edj5QXbFZvoVwuWBGaigqz4t51sd+Gll5hDbtniKj0g=;
 b=JJetyillHZeFiP3zAVzIgfX1tTd0p5n8fSn5uqq8WHSpIkMsGLXa3025x9mHkLGPcM
 hRxBpz9QtWeEmULckQbOFpRibnjhBAqcgseGbdsxUn1vn49ndQhScJiWE2VSqhrAblm7
 2x22OW5149KBT8T8+fAFRTVuQnZL/Se6O440vkMGNmHsEDXXNrUhATLS+jVB3SDzU/2z
 A4ZNMTlmU7x9KPAxxodWJL2kej44fkKZJm6giIxLGmRKV2Fte+xXGlJ5YHq5900GHqYE
 c9q2tJZPQz0h8DTBbxmKHWea2aFV7Nqnkev0sDHrUkQBIb/E5P/tmgYrtAqoYbUhPYzy
 gBHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793737349; x=1794342149;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Edj5QXbFZvoVwuWBGaigqz4t51sd+Gll5hDbtniKj0g=;
 b=xXHxI/FbFD9bHXvqkd7XwiRErvPjLJprEPVmU3hGQIDjTTZMCTxsX2DdSaviE46eUw
 O+GZVftrdTwy9VY4zh4mgA0OBlPaDtKCwVpO89qJbZdiTXucULQMRR01BLqRkGYHkvIk
 q9QexvgMZon9+MjV+RTdSyudgZBNvMPv1+c6HhasBBmAJhNRQU1SYGy0WA3aijnUZ7GH
 xBU8sv2Kcgn1/r0b5jF3SRfhoQAeQemuevzbZeymlJ6rfweBkUIms5bQ/izEWhwnq/Oa
 D/oNyUOOaHuMUUjD2JREo5Enqsw8/nsomJvKLcAPCpjQSUahLriU8O74GULByNRYE0Zi
 /UeQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBybse9UmLPNgP3dIUsXhMo0xcYY/Qrcps9GS/hjdXEn7hfOyy99F9xKIXAHwwPp1EnTcA6ha9wC@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/YfdF5Kbtnk7Q/sIjuMBeTasPvjkotc9w9zT2nEuvsq5KmquXB
 XXhji1SXNVUI8oq2w1JMDA827DsI+ADv1Pww3q8sZ0qHtb+mjTsZhAdC
X-Gm-Gg: AYBFou2HGcoIiNkvMS8yyzVhEZ4OWo95eNc6SzJoeqV5czNZx/epl6sU82Jnl4q/PRR
 NhU8QNAha13RswwC0IsxDlN/VivlSRftf+Scc4PnprpV++BBW0XiBiE2B7eg03uUYyLC5Pr4qSD
 iu1GQc/FZMebgWkm7/jWEx4JIK2J6NqsgS5h5Rmte8HkCajCqMBtIApasHnwcLS5DNSijUl+8BF
 wWhDhK7wTlw3QusGFFqOiqgptzX5gqjBHE38U9OV8Pi9c8NCaioFrGaandXDGblr+z03SBAOjTJ
 D64qo3arXs04Zg503YA/4Q0f5H3NKYKEbeaIg95EVe8OcOtxLRiFkAK2jb4LA38THecrTJX4RBL
 l35SjNPOrGBhHome+bhnDXOWulsoy6OQVTwP2nRzHodOXEOAYWHNI0NQ64Ku894089rMpao6LIG
 0OwQkPF4xeDynefmYeBvPqwlPNGa9qcEhKgNkjZwWNX0qQ3vCe6WP1LKiKq7BXDBDNTuTs0Edxf
 h/ol/IOyCdKtdwy5oMswkk63522yVKNOywfwEYfVdCsUQm00kkMPOGa84MqMuj+4PLmWzjGImt8
 /+4ztr8p4bdwKAve82jY0CzQ7hthL80Py+jzQiymErVjJgrwqCHVQikioZ55c/IRR/NsRQAdNQl
 EC/cQ7YsM
X-Received: by 2002:a05:600c:a103:b0:4ae:63e9:36a9 with SMTP id
 5b1f17b1804b1-4ae63e93a86mr165318135e9.14.1793737348570; 
 Tue, 03 Nov 2026 12:22:28 -0800 (PST)
Received: from [192.168.1.86] (240.red-79-154-229.dynamicip.rima-tde.net.
 [79.154.229.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2ab00ff3dsm157780075e9.14.2026.11.03.12.22.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 12:22:28 -0800 (PST)
Message-ID: <0c653382d51b619fb7e3a219ac153eaa60253956.camel@gmail.com>
Subject: Re: [PATCH v3 06/15] drm/amdgpu/gfx11: add a gfx engine reset
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>, 
 Lijo.Lazar@amd.com, Mario.Novales@amd.com, Manu.Rastogi@amd.com, 
 Jiongyu.Zhu@amd.com
Date: Tue, 03 Nov 2026 21:22:27 +0100
In-Reply-To: <20261028085736.3808569-6-Jesse.Zhang@amd.com>
References: <20261028085736.3808569-1-Jesse.Zhang@amd.com>
 <20261028085736.3808569-6-Jesse.Zhang@amd.com>
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

On Wed, 2026-10-28 at 16:56 +0800, Jesse Zhang wrote:
> Implement the reset_engine callback for the graphics engine of gfx11,
> as
> for gfx12:
> - halt PFP/ME and wait for the memory requests of the CP DMA to
> complete;
> - with CP_SOFT_RESET_CNTL.GFX_ONLY_SOFT_RESET and GFX_HQD_REG_RESET
> set,
> =C2=A0 pulse GRBM_SOFT_RESET.SOFT_RESET_CPF/CPG, holding the MES lock, an=
d
> =C2=A0 wait for the memory requests again;
> - clear CP_VMID_RESET;
> - restart PFP/ME from the start of their RS64 firmware and restore
> =C2=A0 CP_PFP_IB_CONTROL; if the CP doesn't go idle then, fail the reset
> so
> =C2=A0 that a full reset follows;
> - remap the kernel gfx queue through MES from its MQD backup and
> restart
> =C2=A0 it with gfx_v11_0_cp_gfx_start().
>=20
> MES resets a gfx queue by writing CP_VMID_RESET, which the PFP
> handles.
> When the PFP hung, eg. on a bad opcode, the request stays pending
> across
> the CPF/CPG reset, and the restarted PFP then waits on it forever for
> queues the reset already cleared.
>=20
> gfx11 has no helper to restart PFP/ME from their start addresses
> outside
> of the firmware load: add one. A later patch enables the reset with
> MES, async gfx rings and the RS64 firmware.
>=20
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
> =C2=A0drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 176
> +++++++++++++++++++++++++
> =C2=A01 file changed, 176 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 315dfd806d56..e533a5939d02 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -363,6 +363,8 @@ static void gfx_v11_0_ring_invalidate_tlbs(struct
> amdgpu_ring *ring,
> =C2=A0static void gfx_v11_0_set_safe_mode(struct amdgpu_device *adev, int
> xcc_id);
> =C2=A0static void gfx_v11_0_unset_safe_mode(struct amdgpu_device *adev,
> int xcc_id);
> =C2=A0static void gfx_v11_0_userq_priv_fault_work(struct work_struct
> *work);
> +static int gfx_v11_0_reset_engine(struct amdgpu_device *adev,
> +				=C2=A0 enum amd_ip_engine engine);
> =C2=A0static void gfx_v11_0_update_perf_clk(struct amdgpu_device *adev,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool enable);
> =C2=A0
> @@ -1150,6 +1152,7 @@ static const struct amdgpu_gfx_funcs
> gfx_v11_0_gfx_funcs =3D {
> =C2=A0	.get_gfx_shadow_info =3D &gfx_v11_0_get_gfx_shadow_info,
> =C2=A0	.get_hdp_flush_mask =3D &amdgpu_gfx_get_hdp_flush_mask,
> =C2=A0	.detect_hung_queue =3D &gfx_v11_0_detect_hung_queue,
> +	.reset_engine =3D &gfx_v11_0_reset_engine,

Instead, this should be hooked up to the soft_reset_engine callback of
the IP block.

> =C2=A0};
> =C2=A0
> =C2=A0static int gfx_v11_0_gpu_early_init(struct amdgpu_device *adev)
> @@ -6916,6 +6919,179 @@ static void gfx_v11_0_emit_mem_sync(struct
> amdgpu_ring *ring)
> =C2=A0	amdgpu_ring_write(ring, gcr_cntl); /* GCR_CNTL */
> =C2=A0}
> =C2=A0
> +/* Restart the PFP and ME pipes from the start of their RS64
> firmware. */
> +static void gfx_v11_0_restart_gfx_rs64(struct amdgpu_device *adev)
> +{
> +	const struct gfx_firmware_header_v2_0 *pfp_hdr, *me_hdr;
> +	u32 pipe_id, tmp;
> +
> +	pfp_hdr =3D (const struct gfx_firmware_header_v2_0 *)adev-
> >gfx.pfp_fw->data;
> +	me_hdr =3D (const struct gfx_firmware_header_v2_0 *)adev-
> >gfx.me_fw->data;
> +
> +	mutex_lock(&adev->srbm_mutex);
> +	for (pipe_id =3D 0; pipe_id < adev->gfx.me.num_pipe_per_me;
> pipe_id++) {
> +		soc21_grbm_select(adev, 0, pipe_id, 0, 0);
> +		WREG32_SOC15(GC, 0, regCP_PFP_PRGRM_CNTR_START,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 (pfp_hdr->ucode_start_addr_hi << 30) |
> +			=C2=A0=C2=A0=C2=A0=C2=A0 (pfp_hdr->ucode_start_addr_lo >> 2));
> +		WREG32_SOC15(GC, 0, regCP_PFP_PRGRM_CNTR_START_HI,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 pfp_hdr->ucode_start_addr_hi >> 2);
> +		WREG32_SOC15(GC, 0, regCP_ME_PRGRM_CNTR_START,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 (me_hdr->ucode_start_addr_hi << 30) |
> +			=C2=A0=C2=A0=C2=A0=C2=A0 (me_hdr->ucode_start_addr_lo >> 2));
> +		WREG32_SOC15(GC, 0, regCP_ME_PRGRM_CNTR_START_HI,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 me_hdr->ucode_start_addr_hi >> 2);
> +
> +		tmp =3D RREG32_SOC15(GC, 0, regCP_ME_CNTL);
> +		if (pipe_id =3D=3D 0) {
> +			tmp =3D REG_SET_FIELD(tmp, CP_ME_CNTL,
> PFP_PIPE0_RESET, 1);
> +			tmp =3D REG_SET_FIELD(tmp, CP_ME_CNTL,
> ME_PIPE0_RESET, 1);
> +		} else {
> +			tmp =3D REG_SET_FIELD(tmp, CP_ME_CNTL,
> PFP_PIPE1_RESET, 1);
> +			tmp =3D REG_SET_FIELD(tmp, CP_ME_CNTL,
> ME_PIPE1_RESET, 1);
> +		}
> +		WREG32_SOC15(GC, 0, regCP_ME_CNTL, tmp);
> +		if (pipe_id =3D=3D 0) {
> +			tmp =3D REG_SET_FIELD(tmp, CP_ME_CNTL,
> PFP_PIPE0_RESET, 0);
> +			tmp =3D REG_SET_FIELD(tmp, CP_ME_CNTL,
> ME_PIPE0_RESET, 0);
> +		} else {
> +			tmp =3D REG_SET_FIELD(tmp, CP_ME_CNTL,
> PFP_PIPE1_RESET, 0);
> +			tmp =3D REG_SET_FIELD(tmp, CP_ME_CNTL,
> ME_PIPE1_RESET, 0);
> +		}
> +		WREG32_SOC15(GC, 0, regCP_ME_CNTL, tmp);
> +	}
> +	soc21_grbm_select(adev, 0, 0, 0, 0);
> +	mutex_unlock(&adev->srbm_mutex);
> +}
> +
> +/* The CP DMA and the interfaces its memory requests go through */
> +#define GFX11_CP_STAT_MEM_BUSY	(CP_STAT__DMA_BUSY_MASK | \
> +				 CP_STAT__TCIU_BUSY_MASK | \
> +				 CP_STAT__RCIU_BUSY_MASK | \
> +				 CP_STAT__UTCL2IU_BUSY_MASK)
> +
> +/*
> + * Soft reset the gfx CP and restart PFP and ME. Returns 0, or -
> ETIMEDOUT if the
> + * CP doesn't go idle after PFP and ME are restarted.
> + */
> +static int gfx_v11_0_soft_reset_gfx_cp(struct amdgpu_device *adev)
> +{
> +	u32 tmp, cntl, me_cntl, ib_control;
> +	int i;
> +
> +	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
> +
> +	/* MES fetches its queues through CPF: keep it out of the
> reset. */
> +	amdgpu_mes_lock(&adev->mes);
> +
> +	me_cntl =3D RREG32_SOC15(GC, 0, regCP_ME_CNTL);
> +	/* Cleared by the reset. */
> +	ib_control =3D RREG32_SOC15(GC, 0, regCP_PFP_IB_CONTROL);
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
> +	/* Without GFX_ONLY_SOFT_RESET, a CPF reset would also hit
> compute and MES. */
> +	cntl =3D RREG32_SOC15(GC, 0, regCP_SOFT_RESET_CNTL);
> +	tmp =3D REG_SET_FIELD(cntl, CP_SOFT_RESET_CNTL,
> GFX_ONLY_SOFT_RESET, 1);
> +	tmp =3D REG_SET_FIELD(tmp, CP_SOFT_RESET_CNTL,
> GFX_HQD_REG_RESET, 1);
> +	WREG32_SOC15(GC, 0, regCP_SOFT_RESET_CNTL, tmp);
> +
> +	/* A CPF reset alone leaves the streaming engine stuck. */
> +	tmp =3D RREG32_SOC15(GC, 0, regGRBM_SOFT_RESET);
> +	tmp =3D REG_SET_FIELD(tmp, GRBM_SOFT_RESET, SOFT_RESET_CPF,
> 1);
> +	tmp =3D REG_SET_FIELD(tmp, GRBM_SOFT_RESET, SOFT_RESET_CPG,
> 1);

Why not also set the SOFT_RESET_GFX bit?

> +	WREG32_SOC15(GC, 0, regGRBM_SOFT_RESET, tmp);
> +	tmp =3D RREG32_SOC15(GC, 0, regGRBM_SOFT_RESET);
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
> +	/* Not the whole CP: the halted PFP stays busy until
> restarted. */
> +	for (i =3D 0; i < adev->usec_timeout; i++) {
> +		if (!(RREG32_SOC15(GC, 0, regCP_STAT) &
> GFX11_CP_STAT_MEM_BUSY))
> +			break;
> +		udelay(1);
> +	}
> +
> +	/* A CP_VMID_RESET the hung PFP never handled survives the
> reset. */
> +	WREG32_SOC15(GC, 0, regCP_VMID_RESET, 0);
> +	amdgpu_mes_unlock(&adev->mes);
> +
> +	gfx_v11_0_restart_gfx_rs64(adev);

As far as I know, rs64 is for Navi3x dGPUs only, right?
We need an alternative code path that works on APUs too.

> +	tmp =3D RREG32_SOC15(GC, 0, regCP_ME_CNTL);
> +	tmp =3D REG_SET_FIELD(tmp, CP_ME_CNTL, CE_HALT,
> +			=C2=A0=C2=A0=C2=A0 REG_GET_FIELD(me_cntl, CP_ME_CNTL,
> CE_HALT));
> +	WREG32_SOC15(GC, 0, regCP_ME_CNTL, tmp);
> +	WREG32_SOC15(GC, 0, regCP_PFP_IB_CONTROL, ib_control);
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
> +/*
> + * Reset the graphics engine: the CP front-end (CPF/CPG), PFP/ME and
> the gfx
> + * HQDs. MEC, MES and the compute queues aren't reset.
> + */
> +static int gfx_v11_0_reset_engine(struct amdgpu_device *adev,
> +				=C2=A0 enum amd_ip_engine engine)
> +{
> +	int i, r;
> +
> +	lockdep_assert_held(&adev->gfx.mec.reset_mutex);
> +
> +	if (engine !=3D AMD_IP_ENGINE_GFX)
> +		return -EOPNOTSUPP;

It's OK if we don't support resetting compute initially, but we need a
plan to implement that eventually (and/or full GFX IP block reset).

> +
> +	amdgpu_gfx_off_ctrl(adev, false);
> +
> +	r =3D gfx_v11_0_soft_reset_gfx_cp(adev);
> +	if (r) {
> +		dev_err(adev->dev, "gfx CP still busy after reset,
> CP_STAT 0x%08x\n",
> +			RREG32_SOC15(GC, 0, regCP_STAT));
> +		goto exit;
> +	}
> +
> +	/* Map the kernel gfx queue again: the reset cleared its
> HQD. */
> +	r =3D amdgpu_gfx_disable_kgq(adev, 0);
> +	if (r)
> +		goto exit;
> +
> +	for (i =3D 0; i < adev->gfx.num_gfx_rings; i++)
> +		amdgpu_gfx_mqd_reset_restore(&adev-
> >gfx.gfx_ring[i]);
> +	r =3D amdgpu_gfx_enable_kgq(adev, 0);
> +	if (r)
> +		goto exit;
> +
> +	r =3D gfx_v11_0_cp_gfx_start(adev);
> +
> +exit:
> +	amdgpu_gfx_off_ctrl(adev, true);
> +	return r;
> +}
> +
> =C2=A0static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int vmid,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_fence *timedo=
ut_fence)
