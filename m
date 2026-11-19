Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2830606A325
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Nov 2026 11:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mmg3gDAO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D6601122E8;
	Thu, 19 Nov 2026 11:36:36 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E6BD1122E8
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 11:36:30 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4ba013938d7so20477985e9.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 03:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795088189; x=1795692989; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=1VE54Qb4v1NGmiiS20ZMEk6QoIfrRO7JC7ljpVGYcLA=;
 b=mmg3gDAOqnxlg3UcnO+jYUv1v7X4tmW4q7x7g4FIYZS9Ltwf00QjJ00f5unSZnGZPu
 s1t5PKwCXKkXjn8qAi+saZOWKTyOGIEQVhAKIEcLR9z7oNTR20VkjhaYUD2P6zLnyYeh
 4/TTPAKoChVm50WWdUEbU/x8Lj598oAFFFU73QcsLnomCxqeM8FmgWxh97HL8woBSXLs
 XTbNIQKGQpveb9YRYZ/D91rpUv9id4hiYeZZ1SvwijvQQtraIdJ2a7W8Ai2TR+bvvNai
 7zMeGEDyMu+mMeXmLvgJeiUEMicvy6umakZX7TO0wVUqF4mY5higs4cqtepf49rchyOJ
 oP7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795088189; x=1795692989;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1VE54Qb4v1NGmiiS20ZMEk6QoIfrRO7JC7ljpVGYcLA=;
 b=nQoJekXl4GgsoqVKLEYtbfPyqeFnv6xGTbF7LxBlmTo8BdJ9VYrTPsvEt6tGeyoB3m
 JGkm/jfe8Wm6mFRCAHr00rG14muJcjHYI3BXVfgOo/zyGbvleE99nuavM8UcSi1cG36C
 xScfh3wrIOn4wB0Q4I6liHPfKnfLPoBqoMWDfjlyY22jmo0ActP/3Iw4fEAx2HjOPjpu
 wiLrd6QNM02eliHtkbnKIIULMkB6YZN/XTuuYSfIrbp9MxsyYBSV29/o0DAewE2E4wRl
 xcxIAEHAmkyyKKzIYDHZW3FNmImguFJdKJY5rn3J+Il1J+R9g5NRbhOFA0Ndu2WKW4nC
 duJA==
X-Forwarded-Encrypted: i=1;
 AL+hErEZHVg7glp6N0UAz7IkueopqlLgP6e944NAFAC0GbcregG2l0QT9JhvcnIYKewGXbVfCpQsBVmj@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+IOD1XZbL6PM8z3blEN4kq1UIbi/uALprNERhrt87MqRUWejqh
 IztCdLSRBAlE/1VkUzpJrviqV1NbdnONqtp1cinGQ6VnOj9K4p5YBpO4
X-Gm-Gg: AYBFou2O6xjlKACKMU0Xzdkju7nF+miMcAWmA5pspsSAJ8CpVaUeqGxE1QGs1NLHTFm
 gKmSze2bvib1qiqXFwwnzEMKSFjnGDWPJq7JXhRcE88/gwfi+1CJ+FJZpou00tAe4jXzFstnObZ
 a0Dnnj1k7AoPmmMkeryHSrOJ2Mat8qLjkh6tJAP3RosITL+sS531pXVrYi4Trai12JXtTVpsY8t
 tB8XxSewxbXq0RQ8XRPitUnKzUsFf1CV2s3vuFlcQP36H44No1TQaXwB747gBxw1PRDiZ9SyIjj
 ErF6xOUndahoDhfaa4mxFCVe6wIxUzof2n7YlJN6Hq1MY769g8kc7NOliYPxEJkJJsnbvNrGUKf
 JyLucaCjBKJDXYZgErOqc2kHhpTeXcVw/Sb7GYrmcuDZLlVmGdtMKnwAh5H2RuXAgbwRu4NIioS
 /0uhTxUAVy8HyngKSkLk0NRyn8uIzXcrTb2Vr5984npgHO93fnbQY2sJDc8YyTAV6gUdoYeFluU
 J7tLM0rjrMjyhEAMTzjLmRtQ00Ci/QKI8HtphRUOLejgu+eR9a8DkvXMQL0VR302BmLlLz55mT5
 sLfvWQPhYjM6BbH3dXVem/s9NdM21WfsHVSsc7hM18XjcLcmUIhksZKGxzK17ZL68PDBRtRpJKx
 CU99R
X-Received: by 2002:a05:600c:5250:b0:4bb:60ba:49e0 with SMTP id
 5b1f17b1804b1-4bb7da3a2b8mr109034135e9.26.1795088188927; 
 Thu, 19 Nov 2026 03:36:28 -0800 (PST)
Received: from [192.168.1.71] (115.red-2-136-224.staticip.rima-tde.net.
 [2.136.224.115]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb84e5edf5sm15905445e9.4.2026.11.19.03.36.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 03:36:28 -0800 (PST)
Message-ID: <cf1a09e421c89f74bd484a5140c46d63d1eb3199.camel@gmail.com>
Subject: Re: [PATCH v4 07/13] drm/amdgpu/userq: add a helper to signal the
 fences of a queue up to a point
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>, 
 Lijo.Lazar@amd.com, Mario.Novales@amd.com, Manu.Rastogi@amd.com, 
 Jiongyu.Zhu@amd.com
Date: Thu, 19 Nov 2026 12:36:27 +0100
In-Reply-To: <20261105030612.726542-7-Jesse.Zhang@amd.com>
References: <20261105030612.726542-1-Jesse.Zhang@amd.com>
 <20261105030612.726542-7-Jesse.Zhang@amd.com>
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
> The fence value of a user queue is the write pointer of the queue
> when
> the work was submitted. amdgpu_userq_fence_driver_force_completion()
> signals all the fences of a queue, as after a reset that dropped all
> its
> work.
>=20
> Add amdgpu_userq_fence_driver_force_completion_with_seqno(), which
> only
> signals the fences of the work up to a write pointer, with an error,
> for
> a reset that drops only part of the work of a queue: the work
> submitted
> after that write pointer still runs.
>=20
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Reviewed-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>

> ---
> =C2=A0.../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c=C2=A0=C2=A0 | 31
> +++++++++++++++++++
> =C2=A0.../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h=C2=A0=C2=A0 |=C2=A0 2 +=
+
> =C2=A02 files changed, 33 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index dd976a50e053..d20dce32168b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -460,6 +460,37 @@
> amdgpu_userq_fence_driver_force_completion(struct
> amdgpu_usermode_queue *userq)
> =C2=A0	}
> =C2=A0}
> =C2=A0
> +/*
> + * Signal the fences of @userq with a seqno up to @seqno with -
> ECANCELED, eg.
> + * when a reset dropped the work that would have signaled them.
> + */
> +void
> +amdgpu_userq_fence_driver_force_completion_with_seqno(struct
> amdgpu_usermode_queue *userq,
> +						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 seqno)
> +{
> +	struct amdgpu_userq_fence_driver *fence_drv =3D userq-
> >fence_drv;
> +	struct amdgpu_userq_fence *fence;
> +	unsigned long flags;
> +
> +	if (!fence_drv)
> +		return;
> +
> +	spin_lock_irqsave(&fence_drv->fence_list_lock, flags);
> +	list_for_each_entry(fence, &fence_drv->fences, link) {
> +		if (fence->base.seqno > seqno)
> +			break;
> +		spin_lock(dma_fence_spinlock(&fence->base));
> +		if (!dma_fence_is_signaled_locked(&fence->base))
> +			dma_fence_set_error(&fence->base, -
> ECANCELED);
> +		spin_unlock(dma_fence_spinlock(&fence->base));
> +	}
> +	if (amdgpu_userq_fence_read(fence_drv) < seqno)
> +		amdgpu_userq_fence_write(fence_drv, seqno);
> +	spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);
> +
> +	amdgpu_userq_fence_driver_process(fence_drv);
> +}
> +
> =C2=A0int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct drm_file *filp)
> =C2=A0{
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
> index 0bd51616cef1..0407c8c2575f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
> @@ -65,6 +65,8 @@ int amdgpu_userq_fence_driver_alloc(struct
> amdgpu_device *adev,
> =C2=A0void amdgpu_userq_fence_driver_free(struct amdgpu_usermode_queue
> *userq);
> =C2=A0int amdgpu_userq_fence_driver_process(struct
> amdgpu_userq_fence_driver *fence_drv);
> =C2=A0void amdgpu_userq_fence_driver_force_completion(struct
> amdgpu_usermode_queue *userq);
> +void amdgpu_userq_fence_driver_force_completion_with_seqno(struct
> amdgpu_usermode_queue *userq,
> +							=C2=A0=C2=A0 u64
> seqno);
> =C2=A0void amdgpu_userq_fence_driver_destroy(struct kref *ref);
> =C2=A0int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct drm_file *filp);
