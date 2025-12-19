Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04B65D711D2
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Dec 2025 01:17:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 587B410EC2C;
	Fri, 19 Dec 2025 01:17:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VRRsJ7Za";
	dkim-atps=neutral
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com
 [209.85.160.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 725B610EC2C
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Dec 2025 01:17:44 +0000 (UTC)
Received: by mail-oa1-f44.google.com with SMTP id
 586e51a60fabf-3f4f9ea26aaso921235fac.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Dec 2025 17:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766107063; x=1766711863; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6qsF1lyPF05DNoWjbeBL22ujoEaWyfNodi3SQWf1vWs=;
 b=VRRsJ7Za0YGvGI1QjxMhgwnkf5mo9udOv3nAWbQAsm8vs69lkRwNUrDWXLAGYVM8M5
 niFhmskKqBo2/da7QjtTEUAi5JVxXP+/wZNI/RQD5Qo18eE+44KlpxBgA7D+8nlJrHoK
 B83/NmyJoKjh7tbp5o4GJYUqzxZZi4guGuCv4fKQCNy7pK2HvHEEmzBMw/yRwzjD3h5s
 T/VdaN96xljlpqJMTv/mRRKwxI5Y1NSYybWj/gNzBlVyNEl6iGDnl/CIT62p3XmL8nGX
 9X1bUOzHNdTfP8d3+FofXllDUvYhEmvURrPdxVvR8uf4UMmyDNtvhn+qBDQTEyXOFpAb
 DHpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766107063; x=1766711863;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6qsF1lyPF05DNoWjbeBL22ujoEaWyfNodi3SQWf1vWs=;
 b=roPYl3RBsQXW28u/1ifGRffSHbwD+ZCffluTEWClpZLX+tH582kdOtwV6AxRTdmb4e
 g/AnCxeo5a/am1AjwOGLL6cD298xNDmTSM+K9+Ny+uHSQh4X6amnOBoLnpYbtsIF7KdS
 /RUeg5MaODGdESL3ABlMEV4Oh8BXIQ9lD6tk0sUYSZiFs6xwAZJRUwUm5JtvivugZ3nI
 C7lQym6WIngTF3N93SsQaOf2oJrXiQCED+MM4F0fZTFf7y/crYi+hzqRkL+WM7QfT8gh
 ZvJrrEZkWh5XBHQB7OUFyKWkGiWR4cR/nt+5Sa/d4G1YMs9YYX0/seTLQVF0wYClNxif
 ISiQ==
X-Gm-Message-State: AOJu0Yw4z8dnHPQOKxsbutuK4Q+OGLuKlVww3IlasINxu6w4jk+Ish4u
 1p3I6O4fGchgBsNMAgmkNgDIwRmfNRhosdkJHuR7EXKT3j9hmrr7U9H1bzc10Z+1tW0=
X-Gm-Gg: AY/fxX6/Z5tLtx7GBrrNXuW35/TjKVsRL3OQz/oHfZW+CMOb38ktwYtRfYvkyoOvs1l
 wJN/vKSPHlBb1+6s8JCXAfX8+mHvwNEHUKcCGQcAENUUE681ecEfBlc006YCC3lhtOztDr7wqrc
 HJMCSLwmBXTt7oN9oBLNHtTAa0amUdA0ZVmcdem1q09BZ8D98qZ2PPWz5/vBtVAJZGnjJplM7cL
 PtWCjKWybSGT/la1VktriK2vUrDYgp/vIT3D7LGH36e44nIEqUQtOhHApXqybxE2i5lsDbZHgt2
 jHuTL0Gk0qOIwOhpj+TtkfMNekhk5ITvmBFdXyMsyxlwOp8AIeVyZ90sVfVfjfHDceAoa1necGY
 YFQ7QsJ7pqDOHgohpFIMFFCMwTN/ShWIbkPWpCl0rwYh/S7EdT4P8cMUompr8nQsifGSEadYRFz
 Fn7wmvDNhXOwA3Kd3OQMd19KnzRehXtta+FfU3sA==
X-Google-Smtp-Source: AGHT+IGcXtFPTIHeT0+5+g0b1XZOeclPPQy7CWwlxeRw9q6yCvjuu0aDV8UjYnI4/7GsRxALfsrnRA==
X-Received: by 2002:a4a:b28b:0:b0:659:9a49:9022 with SMTP id
 006d021491bc7-65d0eafd703mr473591eaf.79.1766107063375; 
 Thu, 18 Dec 2025 17:17:43 -0800 (PST)
Received: from timur-max.localnet ([189.171.135.243])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65d0f69ae7esm604910eaf.9.2025.12.18.17.17.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 17:17:42 -0800 (PST)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH 6/7] drm/amdgpu/gfx9: rework pipeline sync packet sequence
Date: Thu, 18 Dec 2025 19:17:42 -0600
Message-ID: <3069977.btlEUcBR6m@timur-max>
In-Reply-To: <20251218224141.5841-6-alexander.deucher@amd.com>
References: <20251218224141.5841-1-alexander.deucher@amd.com>
 <20251218224141.5841-6-alexander.deucher@amd.com>
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

On 2025. december 18., cs=C3=BCt=C3=B6rt=C3=B6k 16:41:40 k=C3=B6z=C3=A9ps=
=C5=91 =C3=A1llamokbeli z=C3=B3naid=C5=91 Alex=20
Deucher wrote:
> Replace WAIT_REG_MEM with EVENT_WRITE flushes for all
> shader types and PFP_SYNC_ME.  That should accomplish
> the same thing and avoid having to wait on a fence
> preventing any issues with pipeline syncs during
> queue resets.
>=20
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 32 ++++++++++++++++++---------
>  1 file changed, 21 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c index 7b012ca1153ea..d9dee3c11a05d
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -5572,15 +5572,26 @@ static void gfx_v9_0_ring_emit_fence(struct
> amdgpu_ring *ring, u64 addr, amdgpu_ring_write(ring, 0);
>  }
>=20
> -static void gfx_v9_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
> +static void gfx_v9_0_ring_emit_event_write(struct amdgpu_ring *ring,
> +					   uint32_t event_type,
> +					   uint32_t=20
event_index)
>  {
> -	int usepfp =3D (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_GFX);
> -	uint32_t seq =3D ring->fence_drv.sync_seq;
> -	uint64_t addr =3D ring->fence_drv.gpu_addr;
> +	amdgpu_ring_write(ring, PACKET3(PACKET3_EVENT_WRITE, 0));
> +	amdgpu_ring_write(ring, EVENT_TYPE(event_type) |
> +			  EVENT_INDEX(event_index));
> +}
>=20
> -	gfx_v9_0_wait_reg_mem(ring, usepfp, 1, 0,
> -			      lower_32_bits(addr),=20
upper_32_bits(addr),
> -			      seq, 0xffffffff, 4);
> +static void gfx_v9_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
> +{
> +	if (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_GFX) {
> +		gfx_v9_0_ring_emit_event_write(ring, VS_PARTIAL_FLUSH,=20
4);

Is VS_PARTIAL_FLUSH necessary when we already have PS_PARTIAL_FLUSH?
When we wait for all PS to finish, wouldn't that imply that all VS had alre=
ady=20
finished as well?

> +		gfx_v9_0_ring_emit_event_write(ring, PS_PARTIAL_FLUSH,=20
4);
> +		gfx_v9_0_ring_emit_event_write(ring, CS_PARTIAL_FLUSH,=20
4);
> +		amdgpu_ring_write(ring, PACKET3(PACKET3_PFP_SYNC_ME,=20
0));
> +		amdgpu_ring_write(ring, 0x0);

The above sequence just waits for all shaders to finish, but as far as I=20
understand it doesn't wait for memory writes and cache flushes. Please corr=
ect=20
me if I'm wrong about this. For that, I think we do need an ACQUIRE_MEM=20
packet. (And, if the ACQUIRE_MEM is done on the PFP then we won't need the=
=20
PFP_SYNC_ME.)

> +	} else {
> +		gfx_v9_0_ring_emit_event_write(ring, CS_PARTIAL_FLUSH,=20
4);
> +	}
>  }
>=20
>  static void gfx_v9_0_ring_emit_vm_flush(struct amdgpu_ring *ring,
> @@ -7404,7 +7415,7 @@ static const struct amdgpu_ring_funcs
> gfx_v9_0_ring_funcs_gfx =3D { .set_wptr =3D gfx_v9_0_ring_set_wptr_gfx,
>  	.emit_frame_size =3D /* totally 242 maximum if 16 IBs */
>  		5 +  /* COND_EXEC */
> -		7 +  /* PIPELINE_SYNC */
> +		8 +  /* PIPELINE_SYNC */
>  		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
>  		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
>  		2 + /* VM_FLUSH */
> @@ -7460,7 +7471,7 @@ static const struct amdgpu_ring_funcs
> gfx_v9_0_sw_ring_funcs_gfx =3D { .set_wptr =3D amdgpu_sw_ring_set_wptr_gf=
x,
>  	.emit_frame_size =3D /* totally 242 maximum if 16 IBs */
>  		5 +  /* COND_EXEC */
> -		7 +  /* PIPELINE_SYNC */
> +		8 +  /* PIPELINE_SYNC */
>  		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
>  		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
>  		2 + /* VM_FLUSH */
> @@ -7521,7 +7532,7 @@ static const struct amdgpu_ring_funcs
> gfx_v9_0_ring_funcs_compute =3D { 20 + /* gfx_v9_0_ring_emit_gds_switch */
>  		7 + /* gfx_v9_0_ring_emit_hdp_flush */
>  		5 + /* hdp invalidate */
> -		7 + /* gfx_v9_0_ring_emit_pipeline_sync */
> +		2 + /* gfx_v9_0_ring_emit_pipeline_sync */
>  		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
>  		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
>  		8 + 8 + 8 + /* gfx_v9_0_ring_emit_fence x3 for user=20
fence, vm fence */
> @@ -7564,7 +7575,6 @@ static const struct amdgpu_ring_funcs
> gfx_v9_0_ring_funcs_kiq =3D { 20 + /* gfx_v9_0_ring_emit_gds_switch */
>  		7 + /* gfx_v9_0_ring_emit_hdp_flush */
>  		5 + /* hdp invalidate */
> -		7 + /* gfx_v9_0_ring_emit_pipeline_sync */
>  		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
>  		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
>  		8 + 8 + 8, /* gfx_v9_0_ring_emit_fence_kiq x3 for user=20
fence, vm fence */




