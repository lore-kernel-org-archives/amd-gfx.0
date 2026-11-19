Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E18D606A331
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Nov 2026 11:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hW2E+Kv4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACA911122E4;
	Thu, 19 Nov 2026 11:36:04 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5877B1122E4
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 11:35:58 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-49d64a88222so480393f8f.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 03:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795088157; x=1795692957; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=MPjwE03AK+kOS+G4vhNsbhG+7aXO7nEw3XQW3Hs8lOs=;
 b=hW2E+Kv4H08sIkok+5o7sWyiqrBK96fyx3smI70ez0hq7AWTV/vYHfrlpD/7hMDjQU
 Eo5WyhLap6ajN1zKtZsbLEqYh6MldMa9yCqrZN+fuHVKo9Q8PFSAMFGmgGiY6eF2bNtq
 RaZo1+EYg6BNrEtZNJ7qeiKgXBu8w71ZLn00z5ed1bfS2L2DwnEPpYbsRsIgfr+FHznm
 gO53Z5LQDI9n9PdHequIJb+uC2ohvEdKMScwKqRYpVqiQ4lPMBbiKhMsSOWe4L/Pcpa3
 zzPo1VgKo4tiALYVtTD6D5JAVq9aOPuGWHxFGdQ56tJoms9RLstpuE7KXEyCnMAQuXmj
 p8Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795088157; x=1795692957;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MPjwE03AK+kOS+G4vhNsbhG+7aXO7nEw3XQW3Hs8lOs=;
 b=ZjR/Tyz8GIin2axIfZiXDqowi04nmn0UEqIiJXmVLIZND5vE2lplA7O9XfswJXkKVr
 jdXNdLZ0iSkA+vX0dkUmXadK6WftHO0E5jje5zmW/HCNScizpFpsa0dieiQtDwrTF55s
 VhRn87dtcX40eYTXpgBcFu2U22547CCzkDL0FW6FqWq0NaDKvyuyCALtlHRv/KuVseZq
 fsCevPyH0MZrKD0h457EnED5oaurr+QQjcW6L8YkUiA3Rbt2YmlaLsrHufSiEvI/oo01
 X+AksyhfQKNf0+ZMI+oxns/mNjy6AVS10KGjl+JgHrfpMCMl7t4ijUQSbV7gd9Bhgb5h
 XHaQ==
X-Forwarded-Encrypted: i=1;
 AL+hErG9wJxnuff5jlDOun/TYRgQ4rssoYhLDbQxKMWZVzk41Bh/QPvqOdmsmnlcloZSGCIS4tv/rHAr@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/DcnJHDp5ycjoIDI9xREc3TagAz8bnqw1gPly/nYL9x8Q3MjRY
 JnxetvMB79uGtsaNXQqST9Kp9OgJJ8Cjbg8gbUti+Tt+MoYXraPh8sqm
X-Gm-Gg: AZFdTZf4IxyWidx16eViLJFBN36DnlwX01WKOhwYR8crS4JLHjM227WQ7BEKCh9HlJ0
 HaZr7sm6K8rN++pO0LLH+7toQK9TGhdvl18jf0D5w+SOVOQR5SXNzfEAQ4xmw9HFBILST/cSU24
 5e+fnS4ZFp5XzeBC/2qmqUTAMh3Ec6BGOKNGuwn1hKkYd2RGqyk4vj5BmnIwQkJ4+NCIShWjtX4
 /EurfDZEHqVVaxnGFx7uv6dmlWy6kiJy7IgWi/p+vZaLF3PQIsq/dXWo3QPePAcJNVL9nBNRfOJ
 AWlP0Y6iaBK3uPIZ/hIm/+zoTi3ouJh1QwNxa6Ge/Ow3/YpIuDIwIiRo5hgBiNqRUjnXLeYUZIB
 41nLEz0RH4qQfpdtXkl70iF+lQ4GfbdrrHsJ9ITOcVVmle/q5SEnuAjC4eHVI47ZMM2MrpYjRld
 Nkc6r8+Din6q6q3j6baEArA8HaNucsUeTTa39eTU4j7Ec+9/ppepgd40A9qiSu8m65NFXVX9su2
 TSySoFz2NCV7Tt32BBJYj3lwedr/izbMc7488mdIRr3DTdmnTI94jcPm7YwaJOP44vYWdBTGQuN
 2gc9b6T4xFwgpA8uhs7BCcCk30ePDGW4ta21mQSwtBKGgvWbf5Ccsh+zt2ImZCT1WZ39KN/LuWM
 i8PQr
X-Received: by 2002:a05:6000:2903:b0:491:c392:1f31 with SMTP id
 ffacd0b85a97d-4aa5ab788d1mr2254557f8f.28.1795088156444; 
 Thu, 19 Nov 2026 03:35:56 -0800 (PST)
Received: from [192.168.1.71] (115.red-2-136-224.staticip.rima-tde.net.
 [2.136.224.115]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a654a8c411sm10578255f8f.16.2026.11.19.03.35.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 03:35:55 -0800 (PST)
Message-ID: <8d7613f7203172334b3c295ec73cd9d83cec8340.camel@gmail.com>
Subject: Re: [PATCH v4 05/13] drm/amdgpu/gfx12: save and restore a gfx HQD
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>, 
 Lijo.Lazar@amd.com, Mario.Novales@amd.com, Manu.Rastogi@amd.com, 
 Jiongyu.Zhu@amd.com
Date: Thu, 19 Nov 2026 12:35:54 +0100
In-Reply-To: <20261105030612.726542-5-Jesse.Zhang@amd.com>
References: <20261105030612.726542-1-Jesse.Zhang@amd.com>
 <20261105030612.726542-5-Jesse.Zhang@amd.com>
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
> Implement the gfx callbacks to save and restore a gfx HQD for gfx12:
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

The code looks good, though I didn't test the series yet on GFX12 yet.

Reviewed-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>


> ---
> =C2=A0drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 83
> ++++++++++++++++++++++++++
> =C2=A01 file changed, 83 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> index cb15dad0e57b..484e876fe235 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -274,6 +274,11 @@ static void gfx_v12_0_set_imu_funcs(struct
> amdgpu_device *adev);
> =C2=A0static int gfx_v12_0_get_cu_info(struct amdgpu_device *adev,
> =C2=A0				 struct amdgpu_cu_info *cu_info);
> =C2=A0static uint64_t gfx_v12_0_get_gpu_clock_counter(struct amdgpu_devic=
e
> *adev);
> +static bool gfx_v12_0_save_hqd(struct amdgpu_device *adev, u32
> doorbell_index,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_gfx_saved_hqd *hqd=
);
> +static bool gfx_v12_0_restore_hqd(struct amdgpu_device *adev, void
> *m,
> +				=C2=A0 u32 ring_size,
> +				=C2=A0 const struct amdgpu_gfx_saved_hqd
> *hqd);
> =C2=A0static void gfx_v12_0_select_se_sh(struct amdgpu_device *adev, u32
> se_num,
> =C2=A0				=C2=A0=C2=A0 u32 sh_num, u32 instance, int
> xcc_id);
> =C2=A0static u32 gfx_v12_0_get_wgp_active_bitmap_per_sh(struct
> amdgpu_device *adev);
> @@ -962,6 +967,8 @@ static const struct amdgpu_gfx_funcs
> gfx_v12_0_gfx_funcs =3D {
> =C2=A0	.update_perfmon_mgcg =3D &gfx_v12_0_update_perf_clk,
> =C2=A0	.get_gfx_shadow_info =3D &gfx_v12_0_get_gfx_shadow_info,
> =C2=A0	.get_hdp_flush_mask =3D &amdgpu_gfx_get_hdp_flush_mask,
> +	.save_hqd =3D &gfx_v12_0_save_hqd,
> +	.restore_hqd =3D &gfx_v12_0_restore_hqd,
> =C2=A0};
> =C2=A0
> =C2=A0static int gfx_v12_0_gpu_early_init(struct amdgpu_device *adev)
> @@ -3853,6 +3860,82 @@ static int gfx_v12_0_wait_for_idle(struct
> amdgpu_ip_block *ip_block)
> =C2=A0	return -ETIMEDOUT;
> =C2=A0}
> =C2=A0
> +#define GFX12_HPD_QUEUE_STATE_CONNECTED_MIN	3
> +#define GFX12_HPD_QUEUE_STATE_CONNECTED_MAX	15
> +
> +static bool gfx_v12_0_save_hqd(struct amdgpu_device *adev, u32
> doorbell_index,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_gfx_saved_hqd *hqd=
)
> +{
> +	u32 me, pipe, queue, status, state;
> +
> +	memset(hqd, 0, sizeof(*hqd));
> +	hqd->doorbell_index =3D doorbell_index;
> +	if (!gfx_v12_0_detect_hung_queue(adev, doorbell_index, &me,
> &pipe, &queue))
> +		return true;
> +
> +	amdgpu_gfx_off_ctrl(adev, false);
> +	mutex_lock(&adev->srbm_mutex);
> +	soc24_grbm_select(adev, me, pipe, queue, 0);
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
> +		state >=3D GFX12_HPD_QUEUE_STATE_CONNECTED_MIN &&
> +		state <=3D GFX12_HPD_QUEUE_STATE_CONNECTED_MAX &&
> +		REG_GET_FIELD(status, CP_GFX_HPD_STATUS0,
> MAPPED_QUEUE) =3D=3D queue;
> +out:
> +	soc24_grbm_select(adev, 0, 0, 0, 0);
> +	mutex_unlock(&adev->srbm_mutex);
> +	amdgpu_gfx_off_ctrl(adev, true);
> +
> +	return true;
> +}
> +
> +static bool gfx_v12_0_restore_hqd(struct amdgpu_device *adev, void
> *m,
> +				=C2=A0 u32 ring_size,
> +				=C2=A0 const struct amdgpu_gfx_saved_hqd
> *hqd)
> +{
> +	struct v12_gfx_mqd *mqd =3D m;
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
> =C2=A0static uint64_t gfx_v12_0_get_gpu_clock_counter(struct amdgpu_devic=
e
> *adev)
> =C2=A0{
> =C2=A0	uint64_t clock =3D 0;
