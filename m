Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9C5FC79F9F
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2026 13:25:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C82D10E182;
	Thu, 10 Sep 2026 13:25:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jMHoJZUl";
	dkim-atps=neutral
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com
 [209.85.218.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1671B10E182
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2026 13:25:20 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-c29432715d2so218075866b.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2026 06:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789046718; x=1789651518; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Bno9+C1c7GXBH1GN2kKoRVvZNURrQNEcmb/HGTi1aes=;
 b=jMHoJZUl+OEEEUJnQp/e6kEPVosRjXVEz5yVp/2jPdOiwlg5rmyBbEXbez1mrQEHDA
 GIZC5x32QdjU1CDvHLRg50cbaz8YlPEVnDLkt1QJR6aDim1vrbINcYMCC7MJHXvVI/GU
 VKf1Vr4I2b8uq1IGa1v43TWdJBCubNVu2n5ebS+GFWskuayBIrLkzMVoWW/ta2yRiy2T
 xGSQrCIDZYy70g3G+N2T+lHgsh2XHpga7jW2HYg+9uMCuzuoT7x2eOzGYhk/7k9nNo2t
 McL3sozhc3Z8pw0obgajFNo+Gi/Hei/trNFxOCEUj6EUFVaSGzubzjdnXxdKcJHkYfNw
 Eozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789046718; x=1789651518;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Bno9+C1c7GXBH1GN2kKoRVvZNURrQNEcmb/HGTi1aes=;
 b=AjzXgVa+VOucfHZC2f0GlmF6ZpopF7j5yRJ4yrL4bXmYTBqve96j2CyqZuPNC2YSme
 0S/NTBCVf+E2GsI81DoO2Ti3d9G6AE/Go9MKZxa3yG0CsB/5JUNaPBiz2vHEnJMaTGxd
 vDRMP+gKM9fmnzrmj6LBLBVbaH4Lc76feVn8oYc+8Zi2zUgj42aIONlOWBDX5vw+G0MW
 CL0vDAV3n9ewOsBGERXoajlZT2lxrXQ9qbjEo6IoZqXVaHJmFxTk0J3XqjWUek8FMnGk
 0NGbZp8b9gkxPtWPVWku/mTL5kpGwyn8whxEFwsU6w4a/kNb6UZ9y/gYfXqZ2iWtiyuD
 7FUw==
X-Gm-Message-State: AFuF++lH7UyyGmG1gsMdzw5M841+EWvHeG9BwMENRnkg0fbPp1TJnFW+
 i6tLs6tlyC7wf6xDSM0ekG++pEQo6vylmMqV9nOGve3Isb5jlZLVxyzXSIl0Ng==
X-Gm-Gg: AYBFou1jB17/WPPdz/CtihocqFepLnoSCO1sum8ECTM2e/HCvHHxztkE+G6FEyxhIbx
 OmFn/wcPFPfuEGY/J9pqvnNFRLso7kvgUD8btuPfEIejYraPFkCEks2s+n8MKgGfXylxhnIm8Yn
 hTcbLHwS+iEJCWzAIHSS4MhYzruUQ1EECWr8AdioMnVQynV0rowpQjrXYdGgrbQm+WycXxsR0/Q
 SY4ZQL/JeG4wXki3AptrOAoOX9Q1KwliMNwtuILEZbi+JFafYEFAwlWSaoTEFavsWum/PAyjWjw
 05xWtoioZM6T7CNY0eOiOlrVCYF3tNbmkN9JzGwULjJ8MUl+lB2ftaJWJB02T3AFl1E2N7hho/V
 p9wEtOTkG9E9GsoGaB4KGG08rsSd2KLlgJdoWS8mwLEjh12W1Lqt7ZzO9hlgVjhzs+cjehjoyPC
 cgBwka5Jt+v4gK1u78qLo+MJbfep+oIQKqrIOlqLy6WkghWYrrZl1RVIsRu01u622TknmXzcyIO
 N0xHr6lbL0=
X-Received: by 2002:a17:907:1c13:b0:c24:87e3:b8b8 with SMTP id
 a640c23a62f3a-c260ca22522mr1716597066b.17.1789046717823; 
 Thu, 10 Sep 2026 06:25:17 -0700 (PDT)
Received: from timur-max.localnet ([37.220.204.82])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c260d5921e2sm911968266b.46.2026.09.10.06.25.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 06:25:17 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: Re: [PATCH 2/6] drm/amdgpu: Add amdgpu_sdma_types.h header
Date: Wed, 09 Sep 2026 20:28:29 +0200
Message-ID: <ujSsqFLQQ3WNDjDea3i5HQ@gmail.com>
In-Reply-To: <20260909105215.88242-3-tvrtko.ursulin@igalia.com>
References: <20260909105215.88242-1-tvrtko.ursulin@igalia.com>
 <20260909105215.88242-3-tvrtko.ursulin@igalia.com>
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

On 2026. szeptember 9., szerda 12:52:11 k=C3=B6z=C3=A9p-eur=C3=B3pai ny=C3=
=A1ri id=C5=91 Tvrtko Ursulin=20
wrote:
> There is an include loop between amdgpu.h and amdgpu_sdma.h which
> prevents adding any interesting static inline helpers to the latter.
>=20
> Break it by moving the type definitions to a new amdgpu_sdma_types.h
> header.

Wouldn't it be simpler to add some forward-declatations to amdgpu_sdma.h=20
instead?

>=20
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Cc: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c       |   2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h      | 141 ++--------------
>  .../gpu/drm/amd/amdgpu/amdgpu_sdma_types.h    | 159 ++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c    |   1 +
>  drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c    |   1 +
>  drivers/gpu/drm/amd/amdgpu/cik_sdma.c         |   1 +
>  drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c        |   1 +
>  drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c        |   1 +
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c        |   1 +
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c      |   1 +
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c        |   1 +
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c        |   1 +
>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        |   1 +
>  drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c        |   1 +
>  drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c        |   1 +
>  drivers/gpu/drm/amd/amdkfd/kfd_migrate.c      |   2 +
>  18 files changed, 188 insertions(+), 131 deletions(-)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma_types.h
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h index 79b69d74eb2e..5811709b33b7
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -79,7 +79,7 @@
>  #include "amdgpu_umsch_mm.h"
>  #include "amdgpu_gmc.h"
>  #include "amdgpu_gfx.h"
> -#include "amdgpu_sdma.h"
> +#include "amdgpu_sdma_types.h"
>  #include "amdgpu_lsdma.h"
>  #include "amdgpu_nbio.h"
>  #include "amdgpu_reg_access.h"
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c index
> d80fe17556da..d8786a93a851 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -36,6 +36,7 @@
>  #include "amdgpu_rap.h"
>  #include "amdgpu_securedisplay.h"
>  #include "amdgpu_fw_attestation.h"
> +#include "amdgpu_sdma.h"
>  #include "amdgpu_umr.h"
>=20
>  #include "amdgpu_reset.h"
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c index 7c0554506334..1bf2a42fa63c
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -33,6 +33,8 @@
>  #include "amdgpu_gmc.h"
>  #include "amdgpu_ras.h"
>  #include "amdgpu_reset.h"
> +#include "amdgpu_ring.h"
> +#include "amdgpu_sdma.h"
>  #include "amdgpu_xgmi.h"
>  #include "amdgpu_atomfirmware.h"
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h index 2f1edef97c2f..526ea305a7=
de
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> @@ -23,141 +23,22 @@
>=20
>  #ifndef __AMDGPU_SDMA_H__
>  #define __AMDGPU_SDMA_H__
> -#include "amdgpu_ras.h"
>=20
> -/* max number of IP instances */
> -#define AMDGPU_MAX_SDMA_INSTANCES		16
> +#include "amdgpu_sdma_types.h"
>=20
> -enum amdgpu_sdma_irq {
> -	AMDGPU_SDMA_IRQ_INSTANCE0  =3D 0,
> -	AMDGPU_SDMA_IRQ_INSTANCE1,
> -	AMDGPU_SDMA_IRQ_INSTANCE2,
> -	AMDGPU_SDMA_IRQ_INSTANCE3,
> -	AMDGPU_SDMA_IRQ_INSTANCE4,
> -	AMDGPU_SDMA_IRQ_INSTANCE5,
> -	AMDGPU_SDMA_IRQ_INSTANCE6,
> -	AMDGPU_SDMA_IRQ_INSTANCE7,
> -	AMDGPU_SDMA_IRQ_INSTANCE8,
> -	AMDGPU_SDMA_IRQ_INSTANCE9,
> -	AMDGPU_SDMA_IRQ_INSTANCE10,
> -	AMDGPU_SDMA_IRQ_INSTANCE11,
> -	AMDGPU_SDMA_IRQ_INSTANCE12,
> -	AMDGPU_SDMA_IRQ_INSTANCE13,
> -	AMDGPU_SDMA_IRQ_INSTANCE14,
> -	AMDGPU_SDMA_IRQ_INSTANCE15,
> -	AMDGPU_SDMA_IRQ_LAST
> -};
> +#include "amdgpu.h"
> +#include "amdgpu_ring.h"
> +
> +#include <linux/types.h>
> +
> +struct amdgpu_device;
> +struct amdgpu_iv_entry;
> +struct amdgpu_irq_src;
> +struct amdgpu_ring;
> +struct ras_common_if;
>=20
>  #define NUM_SDMA(x) hweight32(x)
>=20
> -struct amdgpu_sdma_csa_info {
> -	u32 size;
> -	u32 alignment;
> -};
> -
> -struct amdgpu_sdma_funcs {
> -	int (*stop_kernel_queue)(struct amdgpu_ring *ring);
> -	int (*start_kernel_queue)(struct amdgpu_ring *ring);
> -	int (*soft_reset_kernel_queue)(struct amdgpu_device *adev, u32
> instance_id); -};
> -
> -struct amdgpu_sdma_instance {
> -	/* SDMA firmware */
> -	const struct firmware	*fw;
> -	uint32_t		fw_version;
> -	uint32_t		feature_version;
> -
> -	struct amdgpu_ring	ring;
> -	struct amdgpu_ring	page;
> -	bool			burst_nop;
> -	union {
> -	    uint32_t		aid_id;
> -	    uint32_t		xcc_id;
> -	};
> -
> -	struct amdgpu_bo	*sdma_fw_obj;
> -	uint64_t		sdma_fw_gpu_addr;
> -	uint32_t		*sdma_fw_ptr;
> -	struct mutex		engine_reset_mutex;
> -	/* track guilty state of GFX and PAGE queues */
> -	bool			gfx_guilty;
> -	bool			page_guilty;
> -	const struct amdgpu_sdma_funcs   *funcs;
> -};
> -
> -struct amdgpu_sdma_ras {
> -	struct amdgpu_ras_block_object ras_block;
> -};
> -
> -struct amdgpu_sdma {
> -	struct amdgpu_sdma_instance instance[AMDGPU_MAX_SDMA_INSTANCES];
> -	struct amdgpu_irq_src	trap_irq;
> -	struct amdgpu_irq_src	illegal_inst_irq;
> -	struct amdgpu_irq_src	fence_irq;
> -	struct amdgpu_irq_src	ecc_irq;
> -	struct amdgpu_irq_src	vm_hole_irq;
> -	struct amdgpu_irq_src	doorbell_invalid_irq;
> -	struct amdgpu_irq_src	pool_timeout_irq;
> -	struct amdgpu_irq_src	srbm_write_irq;
> -	struct amdgpu_irq_src	ctxt_empty_irq;
> -
> -	int			num_instances;
> -	uint32_t 		sdma_mask;
> -	bool    		sdma_debug;
> -	union {
> -	    int			num_inst_per_aid;
> -	    int			num_inst_per_xcc;
> -	};
> -	uint32_t                    srbm_soft_reset;
> -	bool			has_page_queue;
> -	struct ras_common_if	*ras_if;
> -	struct amdgpu_sdma_ras	*ras;
> -	uint32_t		*ip_dump;
> -	uint32_t 		supported_reset;
> -	struct list_head	reset_callback_list;
> -	bool			no_user_submission;
> -	bool			disable_uq;
> -	void (*get_csa_info)(struct amdgpu_device *adev,
> -			     struct amdgpu_sdma_csa_info *csa_info);
> -};
> -
> -/*
> - * Provided by hw blocks that can move/clear data.  e.g., gfx or sdma
> - * But currently, we use sdma to move data.
> - */
> -struct amdgpu_buffer_funcs {
> -	/* maximum bytes in a single operation */
> -	uint32_t	copy_max_bytes;
> -
> -	/* number of dw to reserve per operation */
> -	unsigned	copy_num_dw;
> -
> -	/* used for buffer migration */
> -	void (*emit_copy_buffer)(struct amdgpu_ib *ib,
> -				 /* src addr in bytes */
> -				 uint64_t src_offset,
> -				 /* dst addr in bytes */
> -				 uint64_t dst_offset,
> -				 /* number of byte to transfer */
> -				 uint32_t byte_count,
> -				 uint32_t copy_flags);
> -
> -	/* maximum bytes in a single operation */
> -	uint32_t	fill_max_bytes;
> -
> -	/* number of dw to reserve per operation */
> -	unsigned	fill_num_dw;
> -
> -	/* used for buffer clearing */
> -	void (*emit_fill_buffer)(struct amdgpu_ib *ib,
> -				 /* value to write to memory */
> -				 uint32_t src_data,
> -				 /* dst addr in bytes */
> -				 uint64_t dst_offset,
> -				 /* number of byte to fill */
> -				 uint32_t byte_count);
> -};
> -
>  int amdgpu_sdma_ring_init(struct amdgpu_device *adev, struct amdgpu_ring
> *ring, const char *prefix, unsigned int index);
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma_types.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma_types.h new file mode 100644
> index 000000000000..d6e7a703c2e0
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma_types.h
> @@ -0,0 +1,159 @@
> +/*
> + * Copyright 2018 Advanced Micro Devices, Inc.
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
> +#ifndef __AMDGPU_SDMA_TYPES_H__
> +#define __AMDGPU_SDMA_TYPES_H__
> +#include "amdgpu_ras.h"
> +
> +/* max number of IP instances */
> +#define AMDGPU_MAX_SDMA_INSTANCES		16
> +
> +enum amdgpu_sdma_irq {
> +	AMDGPU_SDMA_IRQ_INSTANCE0  =3D 0,
> +	AMDGPU_SDMA_IRQ_INSTANCE1,
> +	AMDGPU_SDMA_IRQ_INSTANCE2,
> +	AMDGPU_SDMA_IRQ_INSTANCE3,
> +	AMDGPU_SDMA_IRQ_INSTANCE4,
> +	AMDGPU_SDMA_IRQ_INSTANCE5,
> +	AMDGPU_SDMA_IRQ_INSTANCE6,
> +	AMDGPU_SDMA_IRQ_INSTANCE7,
> +	AMDGPU_SDMA_IRQ_INSTANCE8,
> +	AMDGPU_SDMA_IRQ_INSTANCE9,
> +	AMDGPU_SDMA_IRQ_INSTANCE10,
> +	AMDGPU_SDMA_IRQ_INSTANCE11,
> +	AMDGPU_SDMA_IRQ_INSTANCE12,
> +	AMDGPU_SDMA_IRQ_INSTANCE13,
> +	AMDGPU_SDMA_IRQ_INSTANCE14,
> +	AMDGPU_SDMA_IRQ_INSTANCE15,
> +	AMDGPU_SDMA_IRQ_LAST
> +};
> +
> +struct amdgpu_sdma_csa_info {
> +	u32 size;
> +	u32 alignment;
> +};
> +
> +struct amdgpu_sdma_funcs {
> +	int (*stop_kernel_queue)(struct amdgpu_ring *ring);
> +	int (*start_kernel_queue)(struct amdgpu_ring *ring);
> +	int (*soft_reset_kernel_queue)(struct amdgpu_device *adev, u32
> instance_id); +};
> +
> +struct amdgpu_sdma_instance {
> +	/* SDMA firmware */
> +	const struct firmware	*fw;
> +	uint32_t		fw_version;
> +	uint32_t		feature_version;
> +
> +	struct amdgpu_ring	ring;
> +	struct amdgpu_ring	page;
> +	bool			burst_nop;
> +	union {
> +	    uint32_t		aid_id;
> +	    uint32_t		xcc_id;
> +	};
> +
> +	struct amdgpu_bo	*sdma_fw_obj;
> +	uint64_t		sdma_fw_gpu_addr;
> +	uint32_t		*sdma_fw_ptr;
> +	struct mutex		engine_reset_mutex;
> +	/* track guilty state of GFX and PAGE queues */
> +	bool			gfx_guilty;
> +	bool			page_guilty;
> +	const struct amdgpu_sdma_funcs   *funcs;
> +};
> +
> +struct amdgpu_sdma_ras {
> +	struct amdgpu_ras_block_object ras_block;
> +};
> +
> +struct amdgpu_sdma {
> +	struct amdgpu_sdma_instance instance[AMDGPU_MAX_SDMA_INSTANCES];
> +	struct amdgpu_irq_src	trap_irq;
> +	struct amdgpu_irq_src	illegal_inst_irq;
> +	struct amdgpu_irq_src	fence_irq;
> +	struct amdgpu_irq_src	ecc_irq;
> +	struct amdgpu_irq_src	vm_hole_irq;
> +	struct amdgpu_irq_src	doorbell_invalid_irq;
> +	struct amdgpu_irq_src	pool_timeout_irq;
> +	struct amdgpu_irq_src	srbm_write_irq;
> +	struct amdgpu_irq_src	ctxt_empty_irq;
> +
> +	int			num_instances;
> +	uint32_t 		sdma_mask;
> +	bool    		sdma_debug;
> +	union {
> +	    int			num_inst_per_aid;
> +	    int			num_inst_per_xcc;
> +	};
> +	uint32_t                    srbm_soft_reset;
> +	bool			has_page_queue;
> +	struct ras_common_if	*ras_if;
> +	struct amdgpu_sdma_ras	*ras;
> +	uint32_t		*ip_dump;
> +	uint32_t 		supported_reset;
> +	struct list_head	reset_callback_list;
> +	bool			no_user_submission;
> +	bool			disable_uq;
> +	void (*get_csa_info)(struct amdgpu_device *adev,
> +			     struct amdgpu_sdma_csa_info *csa_info);
> +};
> +
> +/*
> + * Provided by hw blocks that can move/clear data.  e.g., gfx or sdma
> + * But currently, we use sdma to move data.
> + */
> +struct amdgpu_buffer_funcs {
> +	/* maximum bytes in a single operation */
> +	uint32_t	copy_max_bytes;
> +
> +	/* number of dw to reserve per operation */
> +	unsigned	copy_num_dw;
> +
> +	/* used for buffer migration */
> +	void (*emit_copy_buffer)(struct amdgpu_ib *ib,
> +				 /* src addr in bytes */
> +				 uint64_t src_offset,
> +				 /* dst addr in bytes */
> +				 uint64_t dst_offset,
> +				 /* number of byte to transfer */
> +				 uint32_t byte_count,
> +				 uint32_t copy_flags);
> +
> +	/* maximum bytes in a single operation */
> +	uint32_t	fill_max_bytes;
> +
> +	/* number of dw to reserve per operation */
> +	unsigned	fill_num_dw;
> +
> +	/* used for buffer clearing */
> +	void (*emit_fill_buffer)(struct amdgpu_ib *ib,
> +				 /* value to write to memory */
> +				 uint32_t src_data,
> +				 /* dst addr in bytes */
> +				 uint64_t dst_offset,
> +				 /* number of byte to fill */
> +				 uint32_t byte_count);
> +};
> +
> +#endif
> \ No newline at end of file
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c index
> ad8cc95e6cfa..29723ff53503 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> @@ -26,6 +26,7 @@
>  #include <drm/drm_mm.h>
>  #include <linux/random.h>
>  #include "amdgpu.h"
> +#include "amdgpu_sdma.h"
>  #include "amdgpu_ualink.h"
>  #include "amdgpu_xgmi.h"
>  #include "amdgpu_dma_buf.h"
> diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c index
> cddfe4015f53..9a0c12b1a309 100644
> --- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> +++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> @@ -30,6 +30,7 @@
>  #include "gfxhub_v1_2.h"
>  #include "sdma_v4_4_2.h"
>  #include "amdgpu_ip.h"
> +#include "amdgpu_sdma.h"
>=20
>  void aqua_vanjaram_doorbell_index_init(struct amdgpu_device *adev)
>  {
> diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c index de2323e23566..45f429ed23e4
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> @@ -27,6 +27,7 @@
>=20
>  #include "amdgpu.h"
>  #include "amdgpu_ucode.h"
> +#include "amdgpu_sdma.h"
>  #include "amdgpu_trace.h"
>  #include "cikd.h"
>  #include "cik.h"
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c index fb2047d8e25a..1f9fd8b23ac7
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> @@ -28,6 +28,7 @@
>=20
>  #include "amdgpu.h"
>  #include "amdgpu_ucode.h"
> +#include "amdgpu_sdma.h"
>  #include "amdgpu_trace.h"
>  #include "vi.h"
>  #include "vid.h"
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c index 656f66527999..6577306311a3
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> @@ -28,6 +28,7 @@
>=20
>  #include "amdgpu.h"
>  #include "amdgpu_ucode.h"
> +#include "amdgpu_sdma.h"
>  #include "amdgpu_trace.h"
>  #include "vi.h"
>  #include "vid.h"
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c index e135dfb1c3e2..5ab191806b22
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> @@ -28,6 +28,7 @@
>=20
>  #include "amdgpu.h"
>  #include "amdgpu_ucode.h"
> +#include "amdgpu_sdma.h"
>  #include "amdgpu_trace.h"
>=20
>  #include "sdma0/sdma0_4_2_offset.h"
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c index 2e46e63a6dbf..365085a15a=
34
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -30,6 +30,7 @@
>  #include "amdgpu_xcp.h"
>  #include "amdgpu_ucode.h"
>  #include "amdgpu_trace.h"
> +#include "amdgpu_sdma.h"
>  #include "amdgpu_reset.h"
>=20
>  #include "sdma/sdma_4_4_2_offset.h"
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c index a0614fa9ffa6..b803d74fc40f
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> @@ -28,6 +28,7 @@
>=20
>  #include "amdgpu.h"
>  #include "amdgpu_ucode.h"
> +#include "amdgpu_sdma.h"
>  #include "amdgpu_trace.h"
>=20
>  #include "gc/gc_10_1_0_offset.h"
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c index 5b3dafc194d7..213fa9ac883f
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -28,6 +28,7 @@
>=20
>  #include "amdgpu.h"
>  #include "amdgpu_ucode.h"
> +#include "amdgpu_sdma.h"
>  #include "amdgpu_trace.h"
>=20
>  #include "gc/gc_10_3_0_offset.h"
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c index 845e622d3c1a..2f5de866b248
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> @@ -28,6 +28,7 @@
>=20
>  #include "amdgpu.h"
>  #include "amdgpu_ucode.h"
> +#include "amdgpu_sdma.h"
>  #include "amdgpu_trace.h"
>=20
>  #include "gc/gc_11_0_0_offset.h"
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c index ea460a19b89d..d5cad2cede98
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> @@ -28,6 +28,7 @@
>=20
>  #include "amdgpu.h"
>  #include "amdgpu_ucode.h"
> +#include "amdgpu_sdma.h"
>  #include "amdgpu_trace.h"
>=20
>  #include "gc/gc_12_0_0_offset.h"
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c index 1704d406c34a..bf26cc515b9a
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
> @@ -28,6 +28,7 @@
>=20
>  #include "amdgpu.h"
>  #include "amdgpu_ucode.h"
> +#include "amdgpu_sdma.h"
>  #include "amdgpu_trace.h"
>=20
>  #include "gc/gc_12_1_0_offset.h"
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c index 6b64b1692235..8b96e1fe74=
1a
> 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -24,6 +24,8 @@
>  #include <linux/dma-direction.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/migrate.h>
> +#include "amdgpu.h"
> +#include "amdgpu_sdma.h"
>  #include "amdgpu_sync.h"
>  #include "amdgpu_object.h"
>  #include "amdgpu_vm.h"




