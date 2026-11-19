Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC1B606A331
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Nov 2026 11:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Bmtmb4GI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C3021122E3;
	Thu, 19 Nov 2026 11:36:25 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3513C1122E8
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 11:36:19 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-492fcbfaa88so1368433f8f.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 03:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795088177; x=1795692977; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=yWtJKzy+cMo/Pi8H79xrTwKkXy692352VdPV70DPjkk=;
 b=Bmtmb4GIh2wL8qhcASeOWl8hh1ZCPWuJSkHGanIMNdzsfT8Rt9ab56wr9dvpKArckI
 is1sAFyw0u6R1wBtaWbeXJxX3BFG/7ewUjWQ7GWPN7t4mvXQdXl1Pj4v5OwBX2AlYvEZ
 GprMIDl6GfG6A4l+J8xywc4lwDZsCXVmuhGbVL1n6xd+YfoUG95c/2oHcDyU4rZ/exP9
 4gCRZ367txHlGh12PYnjmh2ga+KGJdd6FD45RsiTZrqOqKSEYWycBB9YkkdOWTm04Z7e
 eO6INVVYmYODFiJTjR0lNS4nPhfN3cMUwejwa40d3UIDFDEinX5NdWeB4HYGdHVXA4/R
 m61Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795088177; x=1795692977;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yWtJKzy+cMo/Pi8H79xrTwKkXy692352VdPV70DPjkk=;
 b=hb6PLDdPtX5O+estShyPJab7GfwKeQJhw6aFHbpvWiSG5hsR6R37R6Hnpf63AonNdK
 YU71L1bHyj1Ce02xWFormD4o3FWMctyLmk56YIvzQJR1LyqT1srbNKCtyYkS2FvvbBad
 aDqKjd1keMFkOYdGoetl1dFfn6c25K+jB48lwTp719ahK/fgE59yilW1trtiRFvP5QdS
 l6o+1FYcP4LglK9xZwGai17h0lc27JxwLIG1IxavW+DnUULDSuxgLfTk8x6akgYA6Ymz
 I5vfCF5Hwb7g+NrJF2D0wEhF4bbreyMTHpow17MWRWpezU7GeLUpL9wyPIup/Fdt35Ct
 bC8w==
X-Forwarded-Encrypted: i=1;
 AL+hErETvnKuXmInDDCzGRr3OUGiWMveLqhqLGVueuIWuN2lrZN+QYWTAWklx6/QYPBV1u5KHfV8R8hq@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/sxsPsFlSqSF6p4Fomlw8h5fFCPV7q45fTSOQCI0BH1fOtcByl
 3dUgV7h3A/QsN1yc1FsuNTEjibXfgiufK7g68PMbZhZX4PdO0fjHHHDN
X-Gm-Gg: AZFdTZeRPq2NksuJ7tGRH8qq7kzo8+6+uCnQRlOrwn2nKno4ojKq+arlCzvQwHRuA0k
 MjoLXQUlGPKsDl7Lh5nZp/nc+/JbJpRKtGZWchBKBzheQ0T9Gcj2R6YFnOZLWIjiKd9/OT9KhXu
 VoGuo3NNV8qVDAEew2XK4TeHQ4fotmKzR1FlTMtrg3QkL3fc0E3Eq2QNwUauT/RGjNUh7Zfwegw
 KpIecVP4d/tR/N3RvCifLJ8EUEOeulHEeWGRf/kbWN+mQySY5G06YP/6sJzQkoczjGCWO90IaxB
 vrxxFw8OdxPTkXx/P2y5dR4ZdDQCtSl78O6y6e+62zpSOPnbATCh8wLAsQEJQ8suFliKiwXz4cR
 OP4L+0sMoAN4qmhytahUmgXqp9isdZm5lzk1rL11BmRD0W4EdhPWFx0ANOpwFx4B66ZA/f676MS
 +Ti9ySZ4uCM83zk0cOJX44PTqKWIK4O4K66P86ybPoBeR1daz2+3OxL4PQMi+afvhnYGgHlG7bD
 xHDQmpUrKIt1cRJ3i74+BmymTCz+/3K+rirM/hCCNA6Ga96RDQGSXH0eIP4Et/cOn0yMs1WaSeY
 hI0o/i/nGl8IyfoErfxm3BeO4PqGz6jchZ+1/9n+9PKcWHH4Qo4UEVbXw1LSTaX0ZBvIgad7+L7
 3KuUX
X-Received: by 2002:adf:e183:0:b0:4aa:8de6:6648 with SMTP id
 ffacd0b85a97d-4aa8de66db5mr1495810f8f.45.1795088177378; 
 Thu, 19 Nov 2026 03:36:17 -0800 (PST)
Received: from [192.168.1.71] (115.red-2-136-224.staticip.rima-tde.net.
 [2.136.224.115]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a654a8c3a7sm10739694f8f.9.2026.11.19.03.36.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 03:36:16 -0800 (PST)
Message-ID: <7cca49f80a855f1cbbd7c77ed62ade1011155570.camel@gmail.com>
Subject: Re: [PATCH v4 06/13] drm/amdgpu/gfx11: save and restore a gfx HQD
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>, 
 Lijo.Lazar@amd.com, Mario.Novales@amd.com, Manu.Rastogi@amd.com, 
 Jiongyu.Zhu@amd.com
Date: Thu, 19 Nov 2026 12:36:15 +0100
In-Reply-To: <20261105030612.726542-6-Jesse.Zhang@amd.com>
References: <20261105030612.726542-1-Jesse.Zhang@amd.com>
 <20261105030612.726542-6-Jesse.Zhang@amd.com>
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
> Implement the gfx callbacks to save and restore a gfx HQD for gfx11:
> - save_hqd() saves the HQD offset, CSMD read pointer and write
> pointer
> =C2=A0 of the gfx HQD of a doorbell, and whether the queue is the one
> =C2=A0 connected to its pipe;
> - restore_hqd() writes them into the MQD after a reset, for MES to
> map
> =C2=A0 the queue again where it was. A queue switched out of the pipe
> resumes
> =C2=A0 from the preemption status the PFP saved in its MQD, also in the
> =C2=A0 middle of an IB. The queue the pipe was executing has its state in
> the
> =C2=A0 PFP, which the reset cleared: it restarts after the work submitted
> so
> =C2=A0 far instead, and that work is dropped.
>=20
> v4: Rename to save_hqd()/restore_hqd() (Timur).
>=20
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Reviewed-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>

> ---
> =C2=A0drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 83
> ++++++++++++++++++++++++++
> =C2=A01 file changed, 83 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 430b8f3743b2..798015689f0c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -365,6 +365,11 @@ static void gfx_v11_0_unset_safe_mode(struct
> amdgpu_device *adev, int xcc_id);
> =C2=A0static void gfx_v11_0_update_spm_vmid(struct amdgpu_device *adev,
> int xcc_id,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int vmid);
> =C2=A0static void gfx_v11_0_userq_priv_fault_work(struct work_struct
> *work);
> +static bool gfx_v11_0_save_hqd(struct amdgpu_device *adev, u32
> doorbell_index,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_gfx_saved_hqd *hqd=
);
> +static bool gfx_v11_0_restore_hqd(struct amdgpu_device *adev, void
> *m,
> +				=C2=A0 u32 ring_size,
> +				=C2=A0 const struct amdgpu_gfx_saved_hqd
> *hqd);
> =C2=A0static void gfx_v11_0_update_perf_clk(struct amdgpu_device *adev,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool enable);
> =C2=A0
> @@ -1150,6 +1155,8 @@ static const struct amdgpu_gfx_funcs
> gfx_v11_0_gfx_funcs =3D {
> =C2=A0	.get_gfx_shadow_info =3D &gfx_v11_0_get_gfx_shadow_info,
> =C2=A0	.get_hdp_flush_mask =3D &amdgpu_gfx_get_hdp_flush_mask,
> =C2=A0	.detect_hung_queue =3D &gfx_v11_0_detect_hung_queue,
> +	.save_hqd =3D &gfx_v11_0_save_hqd,
> +	.restore_hqd =3D &gfx_v11_0_restore_hqd,
> =C2=A0};
> =C2=A0
> =C2=A0static int gfx_v11_0_gpu_early_init(struct amdgpu_device *adev)
> @@ -6770,6 +6777,82 @@ static void gfx_v11_0_emit_mem_sync(struct
> amdgpu_ring *ring)
> =C2=A0	amdgpu_ring_write(ring, gcr_cntl); /* GCR_CNTL */
> =C2=A0}
> =C2=A0
> +#define GFX11_HPD_QUEUE_STATE_CONNECTED_MIN	3
> +#define GFX11_HPD_QUEUE_STATE_CONNECTED_MAX	15
> +
> +static bool gfx_v11_0_save_hqd(struct amdgpu_device *adev, u32
> doorbell_index,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_gfx_saved_hqd *hqd=
)
> +{
> +	u32 me, pipe, queue, status, state;
> +
> +	memset(hqd, 0, sizeof(*hqd));
> +	hqd->doorbell_index =3D doorbell_index;
> +	if (!gfx_v11_0_detect_hung_queue(adev, doorbell_index, &me,
> &pipe, &queue))
> +		return true;
> +
> +	amdgpu_gfx_off_ctrl(adev, false);
> +	mutex_lock(&adev->srbm_mutex);
> +	soc21_grbm_select(adev, me, pipe, queue, 0);
> +	hqd->on_hqd =3D RREG32_SOC15(GC, 0, regCP_GFX_HQD_ACTIVE) &
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CP_GFX_HQD_ACTIVE__ACTIVE_MASK;
> +	if (!hqd->on_hqd)
> +		goto out;
> +	hqd->mqd_addr =3D RREG32_SOC15(GC, 0, regCP_GFX_MQD_BASE_ADDR)
> |
> +			(u64)RREG32_SOC15(GC, 0,
> regCP_GFX_MQD_BASE_ADDR_HI) << 32;
> +	hqd->offset =3D RREG32_SOC15(GC, 0, regCP_GFX_HQD_OFFSET);
> +	hqd->csmd_rptr =3D RREG32_SOC15(GC, 0,
> regCP_GFX_HQD_CSMD_RPTR);
> +	hqd->wptr =3D RREG32_SOC15(GC, 0, regCP_GFX_HQD_WPTR) |
> +		=C2=A0=C2=A0=C2=A0 (u64)RREG32_SOC15(GC, 0, regCP_GFX_HQD_WPTR_HI)
> << 32;
> +	status =3D RREG32_SOC15(GC, 0, regCP_GFX_HPD_STATUS0);
> +	state =3D REG_GET_FIELD(status, CP_GFX_HPD_STATUS0,
> QUEUE_STATE);
> +	hqd->connected =3D
> +		state >=3D GFX11_HPD_QUEUE_STATE_CONNECTED_MIN &&
> +		state <=3D GFX11_HPD_QUEUE_STATE_CONNECTED_MAX &&
> +		REG_GET_FIELD(status, CP_GFX_HPD_STATUS0,
> MAPPED_QUEUE) =3D=3D queue;
> +out:
> +	soc21_grbm_select(adev, 0, 0, 0, 0);
> +	mutex_unlock(&adev->srbm_mutex);
> +	amdgpu_gfx_off_ctrl(adev, true);
> +
> +	return true;
> +}
> +
> +static bool gfx_v11_0_restore_hqd(struct amdgpu_device *adev, void
> *m,
> +				=C2=A0 u32 ring_size,
> +				=C2=A0 const struct amdgpu_gfx_saved_hqd
> *hqd)
> +{
> +	struct v11_gfx_mqd *mqd =3D m;
> +	u32 wptr =3D lower_32_bits(hqd->wptr) & ((ring_size >> 2) -
> 1);
> +	u32 *status;
> +
> +	/*
> +	 * MQD dwords 32-41 (reserved_32..41) are the PFP preemption
> status,
> +	 * mcbp_status_pfp: the offset and chained IB size and
> address of IB1
> +	 * (32-35) and IB2 (36-39), rb_preempt (40: preempted in the
> ring) and
> +	 * completion_status (41: 0 IB not started, 1 preempted
> inside an IB,
> +	 * 2 IB completed, 3 IB resumed). The PFP saves it when the
> queue is
> +	 * switched out of the pipe and resumes from it when the
> queue runs
> +	 * again, at the HQD offset. That survives the reset for a
> queue that
> +	 * was switched out. The queue the pipe executed has its
> state in the
> +	 * PFP, which the reset cleared: restart it at the write
> pointer with
> +	 * no IB to resume, and drop its work in flight.
> +	 */
> +	if (hqd->connected) {
> +		mqd->cp_gfx_hqd_offset =3D wptr;
> +		mqd->cp_gfx_hqd_csmd_rptr =3D wptr;
> +		for (status =3D &mqd->reserved_32; status <=3D &mqd-
> >reserved_41; status++)
> +			*status =3D 0;
> +	} else {
> +		mqd->cp_gfx_hqd_offset =3D hqd->offset;
> +		mqd->cp_gfx_hqd_csmd_rptr =3D hqd->csmd_rptr;
> +	}
> +	mqd->cp_gfx_hqd_wptr =3D lower_32_bits(hqd->wptr);
> +	mqd->cp_gfx_hqd_wptr_hi =3D upper_32_bits(hqd->wptr);
> +	mqd->cp_gfx_hqd_active =3D 0;
> +
> +	return hqd->connected;
> +}
> +
> =C2=A0static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int vmid,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_fence *timedo=
ut_fence)
