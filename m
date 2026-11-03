Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17438606A31B
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2026 20:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ijJaLywg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E9FF10F825;
	Tue,  3 Nov 2026 20:39:05 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 724A010F825
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 20:38:59 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a35ac4475dso33540025e9.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Nov 2026 12:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793738338; x=1794343138; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=P/j1eo49jZRvJQJEyvbp0ZFPMjoz6SFc/JkYiwUaVi0=;
 b=ijJaLywgWPOn6sHV0hMX5/jnUnpgYBUEBbg0tfO9lnEa6pahHGmYB5Ayx2deo4V5mz
 lZWsMLSTzFL83R6Zt1C518ECS82HcxIdfkn0HesKNKuOUrsXLAgLP9GBF+aGZ9OEfb8M
 o3RebH6w38NOUIbWEfWVTt9VikLp3HPz1wbT+tF1oRzjVF97WS/KuAjOFJwsB5uKSSYE
 Dya5/+UcN3niJkIIRhaUPuBZRyasa/WOb5Og0nWQwH1mdMXo99PqmYOY9d2gcAE2xu/v
 ZQ+TTfSMx8h4b8oA4T0bGGjD+tyV6gP/sAZQMbz1WePL0bTnYA6eU3bnDqt0b//uvNWp
 HefQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793738338; x=1794343138;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=P/j1eo49jZRvJQJEyvbp0ZFPMjoz6SFc/JkYiwUaVi0=;
 b=LY+9i03AWDkMZgFW/hOQmhn4EtmznpTOTxZFM6V3ziRHJO3MQZSkpuNw/oomwt+6T2
 DfXzn7vTsAXGEnHa/P/hoB9jMZVYi7pJ59d/CMhhMiQ6UlV17ndcNOl/13kpCHJuoAWV
 Z227v5DznQhV+v42YeKwt281sScbT+b3sg5+fPEaW+lHEtsqKpsBHbbcXVzTYcsI7J5p
 50vKORoXmLIImV7sHU177OLywjDl9hu7ctMZO0FfOPLtIDvZ7+yjFs602XYBlYB3elhS
 VGxIClrryzf6Sj6BPNgW/0z9acvkvCSD01GwkZpZAt41ypkmw1aaSrWNXrPYhopmUxDv
 XzYg==
X-Forwarded-Encrypted: i=1;
 AKwUvBy65q3bewe2065TJvSfifCSrtTdmGs7MhjmYNx0ADgvpSy25RRqzvqzVkQO1LLG3qwoytpgwTK8@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/8PVHe6V+6gROCLpfEceYkDRBWnw/D0BzfomXpUHjol2ZF3RjR
 aDSmKerYZVWhJf0qmBEm0sum9FS8KcakE8pIWsb2Qt2Qv5W2RCALpfTA
X-Gm-Gg: AYBFou3feJYjnHoQE1UV65c490xhTQ2qcH/NgbZ8JkP40V0oKQ5qaKdU5aHoVnv5Rs5
 Vtz9x0KI3ScIifUHkEAkdV7yoWMhywS252khUD8rjZqkhDi5fZIlEBnV8nAqc5h+CRz4AHVxuPO
 NPTVF7MSqgfL4CdMlgpqD+kJmLirzdrECFtzhUSCjXP0ZHuYBqFGtgpGRgubXSK+8H817jmB4vY
 9VeATMOuF5ICMAzV/1PAI3YtBQIcC9/35Vqfq4gBMGx89caaCJgp3SRFtJ3XiA3fIOG1C7FY/vJ
 FTV8x4VifKF4I/Y/wQNsrTQJw87geLFqW+wxsmYKjoGw0TblXntAWLYgqKYGe9o3Y/ffQ80hkJ+
 7TTIpV/4drefTM7UwuJS3wJmoPUQoWeYORwUVigcYQiRE+dA8giGiGZ8EQa3kf1Vv4FTKJA4KdE
 mQAZDyKOSABRXCAet3HkSazdS+gqDG8AffVAbS2Wjr63DN8K6ADY5L434Eh1l0vXNMI2B56xmFi
 Ckd1lyFmImmmZtNd59X1FDgzgI0eN7Mci8NfK/xLlY/wCV42IMxbSVrfzzvyhTn+yYNLGaL5bVY
 UA6CU0BqdSYZ9hioinhhBL6DSLYrH48OiM7CV9fmCxK0NKtfLvPB4gqbMXiixqFILFW3OXYA7do
 XQbOwiIZ7yA==
X-Received: by 2002:a05:600c:5397:b0:4a4:7a8d:c736 with SMTP id
 5b1f17b1804b1-4ac16acfceamr315330565e9.9.1793738337720; 
 Tue, 03 Nov 2026 12:38:57 -0800 (PST)
Received: from [192.168.1.86] (240.red-79-154-229.dynamicip.rima-tde.net.
 [79.154.229.240]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fcc0e459dsm551110f8f.10.2026.11.03.12.38.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 12:38:57 -0800 (PST)
Message-ID: <5b50e068b3a16d7e25af73ecbb61c3e137ecedda.camel@gmail.com>
Subject: Re: [PATCH v3 12/15] drm/amdgpu/gfx: add a gfx engine soft reset
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>, 
 Lijo.Lazar@amd.com, Mario.Novales@amd.com, Manu.Rastogi@amd.com, 
 Jiongyu.Zhu@amd.com
Date: Tue, 03 Nov 2026 21:38:56 +0100
In-Reply-To: <20261028085736.3808569-12-Jesse.Zhang@amd.com>
References: <20261028085736.3808569-1-Jesse.Zhang@amd.com>
 <20261028085736.3808569-12-Jesse.Zhang@amd.com>
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
> Add amdgpu_gfx_soft_reset_engine(), the soft_reset_engine() IP block
> callback of the gfx IPs, around the reset_engine callback. It only
> supports the graphics engine so far. The IP block soft reset stops,
> backs up and replays the kernel gfx rings around it; the compute
> rings
> aren't stopped.
>=20
> MES is suspended across the reset, so that it doesn't schedule or map
> queues while the CP front-end is reset. The compute queues are
> preempted
> meanwhile: their work is only paused. MES
> fetches its commands through the CP front-end though, and a hung gfx
> stream can keep it from completing the suspend. Reset the engine
> anyway:
> the reset frees the front-end.
>=20
> The reset also clears the HQDs of the gfx user queues. Call
> amdgpu_userq_pre_engine_reset() after the MES suspend, to save the
> ring
> state of the queues still on a HQD, and
> amdgpu_userq_post_engine_reset()
> after the reset, before MES resumes, to restore them. @guilty_queue
> is
> the gfx user queue that hung, if any: it is hung instead. If the
> engine
> reset fails, amdgpu_userq_cancel_engine_reset() drops the saved ring
> state for the full reset that follows.
>=20
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 41
> +++++++++++++++++++++++++
> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |=C2=A0 3 ++
> =C2=A02 files changed, 44 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 0ae6e990c310..f1a26e4eb06c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -2181,6 +2181,47 @@ int amdgpu_gfx_reset_mes_gfx(struct
> amdgpu_device *adev,
> =C2=A0	return r;
> =C2=A0}
> =C2=A0
> +/**
> + * amdgpu_gfx_soft_reset_engine() - Soft reset one engine of the GFX
> IP.
> + *
> + * @ip_block: The GFX IP block.
> + * @engine: The engine to reset.
> + * @guilty_queue: The user queue that hung, or NULL.
> + *
> + * soft_reset_engine() IP block callback around the reset_engine
> callback,
> + * which resets the CP of the engine. Only the graphics engine is
> supported
> + * so far.
> + */
> +int amdgpu_gfx_soft_reset_engine(struct amdgpu_ip_block *ip_block,
> +				 enum amd_ip_engine engine,
> +				 struct amdgpu_usermode_queue
> *guilty_queue)
> +{
> +	struct amdgpu_device *adev =3D ip_block->adev;
> +	int r;
> +
> +	if (engine !=3D AMD_IP_ENGINE_GFX || !adev->gfx.funcs-
> >reset_engine)
> +		return -EOPNOTSUPP;
> +
> +	mutex_lock(&adev->gfx.mec.reset_mutex);
> +
> +	/* The suspend may time out while the gfx engine hangs:
> reset anyway. */
> +	amdgpu_mes_suspend(adev, 0);
> +	amdgpu_userq_pre_engine_reset(adev, AMDGPU_HW_IP_GFX);
> +	r =3D adev->gfx.funcs->reset_engine(adev, engine);
> +	if (r) {
> +		amdgpu_userq_cancel_engine_reset(adev,
> AMDGPU_HW_IP_GFX);
> +		amdgpu_mes_resume(adev, 0);
> +		goto exit;
> +	}
> +
> +	amdgpu_userq_post_engine_reset(adev, AMDGPU_HW_IP_GFX,
> guilty_queue);
> +	r =3D amdgpu_mes_resume(adev, 0);
> +
> +exit:
> +	mutex_unlock(&adev->gfx.mec.reset_mutex);
> +	return r;
> +}

I think the additional functionality should be added to
the amdgpu_device_ip_soft_reset() function as well.

> +
> =C2=A0int amdgpu_gfx_mes_reset_queue(struct amdgpu_ring *ring,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int vmid,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_fence *timedo=
ut_fence,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index 6bbf53359a49..d63d9f5f5b96 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -740,6 +740,9 @@ void amdgpu_gfx_pipe_reset_prepare(struct
> amdgpu_device *adev,
> =C2=A0				=C2=A0=C2=A0 struct amdgpu_ring *guilty_ring,
> =C2=A0				=C2=A0=C2=A0 u32 me, u32 pipe,
> =C2=A0				=C2=A0=C2=A0 struct amdgpu_gfx_pipe_reset_ctx
> *ctx);
> +int amdgpu_gfx_soft_reset_engine(struct amdgpu_ip_block *ip_block,
> +				 enum amd_ip_engine engine,
> +				 struct amdgpu_usermode_queue
> *guilty_queue);
> =C2=A0int amdgpu_gfx_reset_mes_gfx(struct amdgpu_device *adev,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_ring *ring,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_fence *guilty_fence,
