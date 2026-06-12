Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3840CD8CA8
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jun 2026 06:13:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9705010F25C;
	Fri, 12 Jun 2026 06:13:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iRgpm88V";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69C2910F25C
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 06:12:59 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-490b12270b3so3109145e9.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2026 23:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781244778; x=1781849578; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OaWvmKmPSHAFcJiVhL7ND9FjnEUCmZcGgWc1yvYx4rw=;
 b=iRgpm88VWP81dM6gRAO6Afix8W5mQhLGUZV5ak9oZ94VbumGrfdYaAs0gnoaDGWLvD
 GlaqVupHSk6A6DJP2diC1x6ItnE13VTlcCL77XTQa8z1TvEwXu8bhYgQPgDd+qODi5YP
 CRpn5dbd+kFeJizuQ3IxH4eMrqE8t7IjTXXK+POkfIJTa/LnUD/PYpQUOltIXEpSNmT5
 qjqCWKz18lpj9XTrCvCJOvOaBMIqugTvE2gMFzpTcquIwIQXBeYxDYpfX6iACdaZZCBl
 Rb2A01stAWgRTrdv+VeMvdsyHoG15pKAw1uNCzXj3RxDx50HsCzRxAu8OzXRUskP8vMN
 A0qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781244778; x=1781849578;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OaWvmKmPSHAFcJiVhL7ND9FjnEUCmZcGgWc1yvYx4rw=;
 b=JUudZEQClc3Tq+E4R1yFfTBbQGk4nmlIIKYtZbS4qFWMC9I8bGZe9C3kDjm0RH3CoN
 c4OUqfHvq32WLGw7u3jL7yLA3MzVhqN/Aq2uZNdUgIPfs/lPpe68KFuPi1Xa12xgQWhk
 AuSRxlIKkqu2nOnK1xQnFlc62LTY67vNo8FV1VcML5KJybRd08Ao3WLo9gHqo+hfJ+5H
 D4GCW+2kkOi8jptSbyHcjuAElwc6228hZQbiAiPC4U7swHpCE6Bs+N7shQ02l2145319
 /izCR09hjI2MkdxhwGLmXtOf8wDH3KRkaejGS22fyyNcBXzlVJRFt65nws5QQ5GRtMON
 N0VQ==
X-Gm-Message-State: AOJu0YwJaySOaHWNW6Hf4qp2WCqH1jtZ3RYEGZZ0czhzLoHHljJvXFZG
 3dbKyu1Y0WHkA8o5Ua6Y9J+lc2IhJNBNNUk7OZARxUUrFgfLOprZq+35
X-Gm-Gg: Acq92OEV3rF5gL8yF23jHNlaz0aKn1oSGrzSyuVE/sf2+vwFlTpzg2xhs9WNkOQn+0d
 vM5UHW36vgcJL7Ye/GzabpzAphUbUh0MG4ICkqdnfvwfOp6c6WIKwlkbaFwJtFElu/H26skSgIt
 M0nBpULGWV/SvpqEBt6TMkvK3r4cSB0qeg1sqL+dPq34BMyolO9g6M1JT12fdKiavoAn7zJ9r4Z
 TmbdRdcR0ZoNa6ohf/U1+Pa9HGHylXNoQiX3z4wDebE+Vxsngi19lJMR5cyQ3EqmweLUrWi256I
 Jc9nxHixUt1vvzXHNZp/9EjqBJQUbNidF29mf57PAeiU7SJIfjHzxYWQAxW8YJsixfPDn6Vbf7V
 I4l8DhoT6ZaYB1fKwlJN8LHLUYywfMuxZgXoVeynDovTS8AGu7oexxQlACm5K6fH4xRofrzY1EE
 9SxAd+WDbCWCVmBwVqqPZM8QjsFs61yuZX/+tDQflHyTGpoJwuUVu7qFNgzH/xRBf9xmDS9l5uA
 r7hv1oMA1ud+BjL4T5BWxPY83odWw==
X-Received: by 2002:a05:600d:8443:20b0:490:601f:d776 with SMTP id
 5b1f17b1804b1-490ec4c5bc4mr8896845e9.3.1781244777787; 
 Thu, 11 Jun 2026 23:12:57 -0700 (PDT)
Received: from timur-max.localnet
 (20014C4E24EDFA00ACE56DB4A62D1E35.dsl.pool.telekom.hu.
 [2001:4c4e:24ed:fa00:ace5:6db4:a62d:1e35])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f263923sm2757414f8f.2.2026.06.11.23.12.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 23:12:57 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: natalie.vock@gmx.de, honghuan@amd.com, Alexander.Deucher@amd.com,
 Felix.Kuehling@amd.com, Philip.Yang@amd.com, christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 01/13] drm/amdgpu: move suballoc defines into own header
Date: Fri, 12 Jun 2026 08:12:56 +0200
Message-ID: <4884437.vXUDI8C0e8@timur-max>
In-Reply-To: <20260529114031.3714-2-christian.koenig@amd.com>
References: <20260529114031.3714-1-christian.koenig@amd.com>
 <20260529114031.3714-2-christian.koenig@amd.com>
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

On 2026. m=C3=A1jus 29., p=C3=A9ntek 13:24:03 k=C3=B6z=C3=A9p-eur=C3=B3pai =
ny=C3=A1ri id=C5=91 Christian K=C3=B6nig=20
wrote:
> Just some code cleanup, while at it remove outdated comment.
>=20
> No functional change.
>=20
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Looks good, makes good sense.

Reviewed-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 32 +--------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.h | 40 -----------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sa.h     | 77 ++++++++++++++++++++++
>  3 files changed, 78 insertions(+), 71 deletions(-)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_sa.h
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h index 5d7bfa59424a..4b6c9d9e6773
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -112,6 +112,7 @@
>  #include "amdgpu_userq.h"
>  #include "amdgpu_eviction_fence.h"
>  #include "amdgpu_ip.h"
> +#include "amdgpu_sa.h"
>  #if defined(CONFIG_DRM_AMD_ISP)
>  #include "amdgpu_isp.h"
>  #endif
> @@ -386,37 +387,6 @@ struct amdgpu_clock {
>  	uint32_t max_pixel_clock;
>  };
>=20
> -/* sub-allocation manager, it has to be protected by another lock.
> - * By conception this is an helper for other part of the driver
> - * like the indirect buffer or semaphore, which both have their
> - * locking.
> - *
> - * Principe is simple, we keep a list of sub allocation in offset
> - * order (first entry has offset =3D=3D 0, last entry has the highest
> - * offset).
> - *
> - * When allocating new object we first check if there is room at
> - * the end total_size - (last_object_offset + last_object_size) >=3D
> - * alloc_size. If so we allocate new object there.
> - *
> - * When there is not enough room at the end, we start waiting for
> - * each sub object until we reach object_offset+object_size >=3D
> - * alloc_size, this object then become the sub object we return.
> - *
> - * Alignment can't be bigger than page size.
> - *
> - * Hole are not considered for allocation to keep things simple.
> - * Assumption is that there won't be hole (all object on same
> - * alignment).
> - */
> -
> -struct amdgpu_sa_manager {
> -	struct drm_suballoc_manager	base;
> -	struct amdgpu_bo		*bo;
> -	uint64_t			gpu_addr;
> -	void				*cpu_ptr;
> -};
> -
>  /*
>   * IRQS.
>   */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h index
> 4d68732d6223..ff11a0903499 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -312,46 +312,6 @@ uint32_t amdgpu_bo_mem_stats_placement(struct amdgpu=
_bo
> *bo); uint32_t amdgpu_bo_get_preferred_domain(struct amdgpu_device *adev,
> uint32_t domain);
>=20
> -/*
> - * sub allocation
> - */
> -static inline struct amdgpu_sa_manager *
> -to_amdgpu_sa_manager(struct drm_suballoc_manager *manager)
> -{
> -	return container_of(manager, struct amdgpu_sa_manager, base);
> -}
> -
> -static inline uint64_t amdgpu_sa_bo_gpu_addr(struct drm_suballoc *sa_bo)
> -{
> -	return to_amdgpu_sa_manager(sa_bo->manager)->gpu_addr +
> -		drm_suballoc_soffset(sa_bo);
> -}
> -
> -static inline void *amdgpu_sa_bo_cpu_addr(struct drm_suballoc *sa_bo)
> -{
> -	return to_amdgpu_sa_manager(sa_bo->manager)->cpu_ptr +
> -		drm_suballoc_soffset(sa_bo);
> -}
> -
> -int amdgpu_sa_bo_manager_init(struct amdgpu_device *adev,
> -				     struct amdgpu_sa_manager=20
*sa_manager,
> -				     unsigned size, u32 align,=20
u32 domain);
> -void amdgpu_sa_bo_manager_fini(struct amdgpu_device *adev,
> -				      struct amdgpu_sa_manager=20
*sa_manager);
> -int amdgpu_sa_bo_manager_start(struct amdgpu_device *adev,
> -				      struct amdgpu_sa_manager=20
*sa_manager);
> -int amdgpu_sa_bo_new(struct amdgpu_sa_manager *sa_manager,
> -		     struct drm_suballoc **sa_bo,
> -		     unsigned int size);
> -void amdgpu_sa_bo_free(struct drm_suballoc **sa_bo,
> -		       struct dma_fence *fence);
> -#if defined(CONFIG_DEBUG_FS)
> -void amdgpu_sa_bo_dump_debug_info(struct amdgpu_sa_manager *sa_manager,
> -					 struct seq_file *m);
> -u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct seq_file *=
m);
> -#endif
> -void amdgpu_debugfs_sa_init(struct amdgpu_device *adev);
> -
>  bool amdgpu_bo_support_uswc(u64 bo_flags);
>=20
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.h new file mode 100644
> index 000000000000..8c85c80fc119
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.h
> @@ -0,0 +1,77 @@
> +/* SPDX-License-Identifier: MIT */
> +/*
> + * Copyright 2026 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the
> "Software"), + * to deal in the Software without restriction, including
> without limitation + * the rights to use, copy, modify, merge, publish,
> distribute, sublicense, + * and/or sell copies of the Software, and to
> permit persons to whom the + * Software is furnished to do so, subject to
> the following conditions: + *
> + * The above copyright notice and this permission notice shall be includ=
ed
> in + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS
> OR + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> MERCHANTABILITY, + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT=
=2E=20
> IN NO EVENT SHALL + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR
> ANY CLAIM, DAMAGES OR + * OTHER LIABILITY, WHETHER IN AN ACTION OF
> CONTRACT, TORT OR OTHERWISE, + * ARISING FROM, OUT OF OR IN CONNECTION WI=
TH
> THE SOFTWARE OR THE USE OR + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +#ifndef AMDGPU_SA_H_
> +#define AMDGPU_SA_H_
> +
> +#include <drm/drm_suballoc.h>
> +
> +struct amdgpu_device;
> +struct amdgpu_bo;
> +
> +struct amdgpu_sa_manager {
> +	struct drm_suballoc_manager	base;
> +	struct amdgpu_bo		*bo;
> +	uint64_t			gpu_addr;
> +	void				*cpu_ptr;
> +};
> +
> +static inline struct amdgpu_sa_manager *
> +to_amdgpu_sa_manager(struct drm_suballoc_manager *manager)
> +{
> +	return container_of(manager, struct amdgpu_sa_manager, base);
> +}
> +
> +static inline uint64_t amdgpu_sa_bo_gpu_addr(struct drm_suballoc *sa_bo)
> +{
> +	return to_amdgpu_sa_manager(sa_bo->manager)->gpu_addr +
> +		drm_suballoc_soffset(sa_bo);
> +}
> +
> +static inline void *amdgpu_sa_bo_cpu_addr(struct drm_suballoc *sa_bo)
> +{
> +	return to_amdgpu_sa_manager(sa_bo->manager)->cpu_ptr +
> +		drm_suballoc_soffset(sa_bo);
> +}
> +
> +int amdgpu_sa_bo_manager_init(struct amdgpu_device *adev,
> +			      struct amdgpu_sa_manager *sa_manager,
> +			      unsigned size, u32 align, u32 domain);
> +void amdgpu_sa_bo_manager_fini(struct amdgpu_device *adev,
> +			       struct amdgpu_sa_manager *sa_manager);
> +int amdgpu_sa_bo_manager_start(struct amdgpu_device *adev,
> +			       struct amdgpu_sa_manager *sa_manager);
> +int amdgpu_sa_bo_new(struct amdgpu_sa_manager *sa_manager,
> +		     struct drm_suballoc **sa_bo,
> +		     unsigned int size);
> +void amdgpu_sa_bo_free(struct drm_suballoc **sa_bo,
> +		       struct dma_fence *fence);
> +#if defined(CONFIG_DEBUG_FS)
> +void amdgpu_sa_bo_dump_debug_info(struct amdgpu_sa_manager *sa_manager,
> +				  struct seq_file *m);
> +u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct seq_file *=
m);
> +#endif
> +void amdgpu_debugfs_sa_init(struct amdgpu_device *adev);
> +
> +#endif



