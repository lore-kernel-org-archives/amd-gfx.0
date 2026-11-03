Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DF6606A31B
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2026 20:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=avXeqKUI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9777510F824;
	Tue,  3 Nov 2026 20:29:26 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E285310E1AA
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 20:29:20 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a4d7ae1ae9so45920915e9.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Nov 2026 12:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793737759; x=1794342559; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=LRwSSvz2qh1Tlh+vlqFwNgKAXiSJNzDB5ml4ijYNmEI=;
 b=avXeqKUIsp5/ye6EItqLJCiVWhz5jOKwvjh8YdiPGp59t5RI6UnZqXaIvRQZz7jGYp
 xzyLzMcJ1sfnSZ3hVJMJDQMf8WuaCsobRdEgyQTmr3c4uNpljCkmculk4p66JAUT4yn+
 aigYKPU8N5bO2k35WBzRiIa8Eojum2e3mOYAbH+h73HYh4qG+P8nJeDaAlMnnLyKdHIS
 qqd6iwyLzkJygSNEqqGAbz4Av7uKrnTzeJekDUCFmVTnU2ZdqBvCpFxJsQO3+MXEQrhi
 oQgzGdsFYSoV3feL8OiXqK9hxC8ULPFItFWrtsU3zPYHMKw7V2lXzeGxZDn8de5N8b5o
 Dgbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793737759; x=1794342559;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LRwSSvz2qh1Tlh+vlqFwNgKAXiSJNzDB5ml4ijYNmEI=;
 b=twpCfN9a4WCa/olRhvg9MtebOCs51gJhIp4ZNaxxwhSaCil+0TZ20Jf7CVGYYxXmPD
 h2PKVnrFvo+FkP3WmjQVciLKMSSFTSB1c9llNR8qsPDdv2AUZ4ahn6IOnt8+u+jsu0NZ
 Xc7iNSW+MZm1qYMYzova8qr4lDZSGtqJqg/S2CLA6EfoefLaF+us7JQVfHULdQ0K0AAd
 jwIYVGDqm70BEWrktoiILLs5GzELEnfEs0vANYTtcehaOmWfh6cGIuCEe+gMwRdAp5eo
 ASpdXylpNScA6AYGZpbEXGMDkiTbUKUAFg9RirYey5+CbqRB5i+lMqpAW3O7KX0Rumz/
 p6BQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBySe07FTJMpWNZRB4x8M82BpSH2O2onLmaHOloFeANrdar8R6WMbOCvhmFY01TkYyvrzHhEcFqX@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9p5sY4GiUB3uuiZtzrS/RwZ/bLvpOKR/DieRdA3NPoH7xqxJCP
 xP8Y5Ltc8Xu5hj+2G4KsB/5UQ47GFKos6Wink+T5B/fe6L1fpgFNq+o3
X-Gm-Gg: AYBFou2WIeuPzb/PPryjKpNx4gaznUa5Frn18l+73VDTorMIQjtjMbYyzJTglJFrRBr
 d8t5d9m2JISrp/2MmkcUZf3W+ZgWUv0/cZsBe7TZmNASj5EB0o0vuVyBOV43mzSaiinxSNKSZZz
 RHLd2Fo//G8ItUSHUYYe46lgCM/vZsPy11NshhJNRp+1CvQUcS/ql8zQsGI2Q5gMcqJJ+j+gfp3
 N9EpUtnVMaJcOeAMxUy9DPGOAKZME0y/lyuk/3YqZFiuKphA77HLrzwTC9BK1GRa/6EFt0JFh1a
 EehWiH2C4dms7/VR4+2Q8lPNEOWkAt3TOyfwrpg+LRwgYoJX6p/OxLOKg4Hf3CmQOETvP4nE75N
 BxwiWc1o8tBsxovDuw3GqoT0oGurREaSG5gvFsMEjaoNWvBz9TRJk3bBgKhmfBIuOY7kMXR2mBB
 9AP1GVZl6PwxGGI2y6hzB4g7c3tyVJSwPU9kEqGB7rW/xfpWdUPAzyL96/MStKSQlsoAmqrJvZU
 rNf/BCBhxcaZ4FgD7b8cRTqqKqzFtAGyD201yUjmBEN40R8Wb2oNGUU3QG2Rr9iZtQr8F0gbxyo
 /VCn0WF/Wwjajz0FpTG6ZF+vkCmJZ1RZ2glQW1RhiBUS71GkpelsRUaqGFXY2/ghz7hd9uwInBt
 bbymq6cUP
X-Received: by 2002:a05:600c:470d:b0:4a2:191f:7cb8 with SMTP id
 5b1f17b1804b1-4ac1899378bmr313345385e9.17.1793737759284; 
 Tue, 03 Nov 2026 12:29:19 -0800 (PST)
Received: from [192.168.1.86] (240.red-79-154-229.dynamicip.rima-tde.net.
 [79.154.229.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2aa481a45sm76533715e9.7.2026.11.03.12.29.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 12:29:18 -0800 (PST)
Message-ID: <8ec9c4789ab1e56a6d25a0ad5c7c95449b9e14e2.camel@gmail.com>
Subject: Re: [PATCH v3 07/15] drm/amdgpu/gfx: add callbacks to read and
 restore the ring state of a gfx queue
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>, 
 Lijo.Lazar@amd.com, Mario.Novales@amd.com, Manu.Rastogi@amd.com, 
 Jiongyu.Zhu@amd.com
Date: Tue, 03 Nov 2026 21:29:18 +0100
In-Reply-To: <20261028085736.3808569-7-Jesse.Zhang@amd.com>
References: <20261028085736.3808569-1-Jesse.Zhang@amd.com>
 <20261028085736.3808569-7-Jesse.Zhang@amd.com>
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
> A gfx engine reset clears the HQD registers of the gfx queues,
> including
> the only copy of the ring position of the queues MES didn't preempt.
> MES doesn't save them in the MQD either when the engine hangs.
>=20
> Add struct amdgpu_gfx_hqd_ptrs for that ring state, and gfx callbacks
> for the gfx IP, which knows its registers and the layout of its MQD:
> - read_gfx_hqd_ptrs() reads the ring state of the gfx HQD of a
> doorbell;
> - restore_gfx_mqd_ring() puts it in the MQD after the reset, for MES
> to
> =C2=A0 map the queue again from it.
>=20
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 21 +++++++++++++++++++++
> =C2=A01 file changed, 21 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index 8d7bd7057666..f750b11f4ad4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -346,6 +346,17 @@ struct amdgpu_gfx_shadow_info {
> =C2=A0	u32 eop_alignment;
> =C2=A0};
> =C2=A0
> +/* Ring state of a gfx HQD that a gfx engine reset clears. */
> +struct amdgpu_gfx_hqd_ptrs {
> +	u32	doorbell_index;
> +	u64	mqd_addr;	/* the MQD loaded in the HQD */
> +	bool	on_hqd;
> +	u64	wptr;
> +	u32	offset;
> +	u32	csmd_rptr;
> +	bool	connected;	/* the queue the pipe executes */
> +};
> +
> =C2=A0struct amdgpu_gfx_funcs {
> =C2=A0	/* get the gpu clock counter */
> =C2=A0	uint64_t (*get_gpu_clock_counter)(struct amdgpu_device
> *adev);
> @@ -380,6 +391,16 @@ struct amdgpu_gfx_funcs {
> =C2=A0	/* reset the CP of one engine and map its kernel queues
> again */
> =C2=A0	int (*reset_engine)(struct amdgpu_device *adev,
> =C2=A0			=C2=A0=C2=A0=C2=A0 enum amd_ip_engine engine);
> +	/* read the ring state of the gfx HQD of a doorbell, if it
> has one */
> +	bool (*read_gfx_hqd_ptrs)(struct amdgpu_device *adev, u32
> doorbell_index,
> +				=C2=A0 struct amdgpu_gfx_hqd_ptrs *ptrs);

Why is this called "ptrs" (plural) when the function seems to just read
a single HQD?

> +	/*
> +	 * write the ring state read by read_gfx_hqd_ptrs() into a
> gfx MQD;
> +	 * true if the work up to ptrs->wptr was dropped
> +	 */
> +	bool (*restore_gfx_mqd_ring)(struct amdgpu_device *adev,
> void *mqd,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 u32 ring_size,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_gfx_hqd_ptrs
> *ptrs);

Seems inconsistent to me that this one is named "mqd" while the other
one is named "hqd", and "ring" vs. "ptrs".

I suggest the following naming: save_hqd() and restore_hqd()

> =C2=A0};
> =C2=A0
> =C2=A0struct sq_work {
