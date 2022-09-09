Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6621EECAAA1
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Sep 2022 14:24:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A72A10EDC9;
	Fri,  9 Sep 2022 14:24:27 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1D2110EDC9
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Sep 2022 14:24:23 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id z8so2760796edb.6
 for <amd-gfx@lists.freedesktop.org>; Fri, 09 Sep 2022 07:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date;
 bh=lgknUgvTjwaD90gyP0ZoSnVwOipsKqIolvK6TEW3rko=;
 b=H0B1iaZXJOzBANBHaWr1dkbaJXYCYV1kUKHaRHPAzEynzu00InlsNXAFgpbsIzQcVS
 6jI8OkSD4zo90vULOAdQrt02nlWTKayYtV2f68WcTdF7yHz2ngS186KcYGeHZ2nrDesR
 uYOgJQCfNkg9CTGR97sfFl8h+DFkw+h1esI4MT+54vpGT/tQVz0yvhNEs1ssTXSJlm5P
 BxURcE7rFktXs0vO/+Kd0ITpEYk8fPM6qdORQ1J6fjG7Hct7jAgKF15hC3uupQcvVJzN
 3Iu/E1izhmfWokgtgZ7LD/NGvMQpwZaB7FoAMV7vwRXO7ED2Ji0rYZAm49JB7bZjEuE7
 LauQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date;
 bh=lgknUgvTjwaD90gyP0ZoSnVwOipsKqIolvK6TEW3rko=;
 b=uA8/QZpKFBRy4WLG3/lmYaaXT6RL/A58lcimZCNikx5aLr+6MU2qgu8MyApNzpHnLf
 iBFEU8nu+t+uYJblvb9bvSW1KrLwV74jfwE2eZz3ANAD646k6k2GIeaueeOGE75r8+qD
 RpOHkbvrl2ki0HYV0n6wdbLaFiQqs9wKTV5nuozVyq1DCaaygBsSU3OG1t9JEe9iOWe/
 w9GZ3J4yGajr/YycRntzkULE/IIx1L99bacWQQSu2ZqsLHSXygnhmMgPEsOtIIcavhQG
 XBrBbNgtUbMMdR/TikkfILdIzmZvJg3GHIP+oO5EQWAnqmMvNy3v1RX+zgr8/TLxyEG2
 Cf0A==
X-Gm-Message-State: ACgBeo0llI19Pj3wKiu0OcrN0/oMNELG+9iCYFtBdfHYdGITQe/b6t9V
 qxy+umDtiamtkChQNjd7HOmthXGbQfw=
X-Google-Smtp-Source: AA6agR4hjRSiX//wwofubJXfrnXfTnghdwKqpBoFY77t2OBoNN4OK21Q8QNXMyYqCE6V39Lj9uJD9g==
X-Received: by 2002:a05:6402:10d2:b0:445:d9ee:fc19 with SMTP id
 p18-20020a05640210d200b00445d9eefc19mr11185018edu.81.1662733462175; 
 Fri, 09 Sep 2022 07:24:22 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:9da0:4bb2:ba96:23be?
 ([2a02:908:1256:79a0:9da0:4bb2:ba96:23be])
 by smtp.gmail.com with ESMTPSA id
 o23-20020a17090611d700b007341663d7ddsm341095eja.96.2022.09.09.07.24.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Sep 2022 07:24:21 -0700 (PDT)
Message-ID: <5c0a4135-72e3-184f-e581-8e1fe222597d@gmail.com>
Date: Fri, 9 Sep 2022 16:24:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/4] drm/amdgpu: Introduce gfx software ring(v3)
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org,
 Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 "Tuikov, Luben" <Luben.Tuikov@amd.com>
References: <20220909015022.557099-1-jiadong.zhu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220909015022.557099-1-jiadong.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: Ray.Huang@amd.com, jiadong.zhu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Andrey and Luben please take a look at this set here and help with 
reviewing it.

Thanks,
Christian.

Am 09.09.22 um 03:50 schrieb jiadong.zhu@amd.com:
> From: "Jiadong.Zhu" <Jiadong.Zhu@amd.com>
>
> The software ring is created to support priority
> context while there is only one hardware queue
> for gfx.
>
> Every software rings has its fence driver and could
> be used as an ordinary ring for the gpu_scheduler.
> Multiple software rings are binded to a real ring
> with the ring muxer. The packages committed on the
> software ring are copied to the real ring.
>
> v2: use array to store software ring entry.
> v3: remove unnecessary prints.
>
> Signed-off-by: Jiadong.Zhu <Jiadong.Zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/Makefile          |   3 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h      |   3 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h     |   3 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c | 182 +++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h |  67 ++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c  | 204 +++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.h  |  48 +++++
>   7 files changed, 509 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.h
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index 3e0e2eb7e235..85224bc81ce5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -58,7 +58,8 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
>   	amdgpu_vm_sdma.o amdgpu_discovery.o amdgpu_ras_eeprom.o amdgpu_nbio.o \
>   	amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o \
>   	amdgpu_fw_attestation.o amdgpu_securedisplay.o \
> -	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o
> +	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o \
> +	amdgpu_sw_ring.o amdgpu_ring_mux.o
>   
>   amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index 53526ffb2ce1..0de8e3cd0f1c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -33,6 +33,7 @@
>   #include "amdgpu_imu.h"
>   #include "soc15.h"
>   #include "amdgpu_ras.h"
> +#include "amdgpu_ring_mux.h"
>   
>   /* GFX current status */
>   #define AMDGPU_GFX_NORMAL_MODE			0x00000000L
> @@ -346,6 +347,8 @@ struct amdgpu_gfx {
>   	struct amdgpu_gfx_ras		*ras;
>   
>   	bool				is_poweron;
> +
> +	struct amdgpu_ring_mux			muxer;
>   };
>   
>   #define amdgpu_gfx_get_gpu_clock_counter(adev) (adev)->gfx.funcs->get_gpu_clock_counter((adev))
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 7d89a52091c0..fe33a683bfba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -278,6 +278,9 @@ struct amdgpu_ring {
>   	bool			is_mes_queue;
>   	uint32_t		hw_queue_id;
>   	struct amdgpu_mes_ctx_data *mes_ctx;
> +
> +	bool			is_sw_ring;
> +
>   };
>   
>   #define amdgpu_ring_parse_cs(r, p, job, ib) ((r)->funcs->parse_cs((p), (job), (ib)))
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
> new file mode 100644
> index 000000000000..ea4a3c66119a
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
> @@ -0,0 +1,182 @@
> +/*
> + * Copyright 2022 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +#include <drm/drm_print.h>
> +
> +#include "amdgpu_ring_mux.h"
> +#include "amdgpu_ring.h"
> +
> +#define AMDGPU_MUX_RESUBMIT_JIFFIES_TIMEOUT (HZ/2)
> +
> +static int copy_pkt_from_sw_ring(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring,
> +	u64 s_begin, u64 s_end);
> +
> +int amdgpu_ring_mux_init(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring)
> +{
> +	mux->real_ring = ring;
> +	memset(mux->ring_entries, 0, sizeof(mux->ring_entries));
> +	mux->num_ring_entries = 0;
> +	spin_lock_init(&mux->lock);
> +	return 0;
> +}
> +
> +void amdgpu_ring_mux_fini(struct amdgpu_ring_mux *mux)
> +{
> +	memset(mux->ring_entries, 0, sizeof(mux->ring_entries));
> +	mux->num_ring_entries = 0;
> +}
> +
> +int amdgpu_ring_mux_add_sw_ring(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_mux_entry *e;
> +
> +	if (mux->num_ring_entries == AMDGPU_MAX_GFX_RINGS) {
> +		DRM_ERROR("adding sw ring exceeds max gfx num\n");
> +		return -ENOMEM;
> +	}
> +
> +	e = &mux->ring_entries[mux->num_ring_entries++];
> +
> +	e->ring = ring;
> +	e->start_ptr_in_hw_ring = 0;
> +	e->end_ptr_in_hw_ring = 0;
> +	e->sw_cptr = 0;
> +	e->sw_rptr = 0;
> +	e->sw_wptr = 0;
> +
> +	return 0;
> +}
> +
> +static struct amdgpu_mux_entry *amdgpu_get_sw_entry(struct amdgpu_ring_mux *mux,
> +				struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_mux_entry *e;
> +	int i;
> +
> +	e = NULL;
> +	for (i = 0; i < mux->num_ring_entries; i++) {
> +		if (mux->ring_entries[i].ring == ring) {
> +			e = &mux->ring_entries[i];
> +			break;
> +		}
> +	}
> +
> +	return e;
> +}
> +
> +void amdgpu_ring_set_wptr_to_mux(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring, u64 wptr)
> +{
> +	struct amdgpu_mux_entry *e;
> +
> +	e = amdgpu_get_sw_entry(mux, ring);
> +	if (!e) {
> +		DRM_ERROR("cannot find entry for sw ring\n");
> +		return;
> +	}
> +
> +	spin_lock(&mux->lock);
> +	e->sw_cptr = e->sw_wptr;
> +	e->sw_wptr = wptr;
> +	e->start_ptr_in_hw_ring = mux->real_ring->wptr;
> +
> +	if (copy_pkt_from_sw_ring(mux, ring, e->sw_cptr, wptr) == 0) {
> +		e->end_ptr_in_hw_ring = mux->real_ring->wptr;
> +		amdgpu_ring_commit(mux->real_ring);
> +	}
> +
> +	spin_unlock(&mux->lock);
> +}
> +
> +u64 amdgpu_ring_get_wptr_from_mux(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_mux_entry *e;
> +
> +	e = amdgpu_get_sw_entry(mux, ring);
> +	if (!e) {
> +		DRM_ERROR("cannot find entry for sw ring\n");
> +		return 0;
> +	}
> +
> +	return e->sw_wptr;
> +}
> +
> +u64 amdgpu_ring_get_rptr_from_mux(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_mux_entry *e;
> +	u64 r_rptr, r_wptr, offset, start, end;
> +
> +	e = amdgpu_get_sw_entry(mux, ring);
> +	if (!e) {
> +		DRM_ERROR("no sw entry found!\n");
> +		return 0;
> +	}
> +
> +	r_rptr = amdgpu_ring_get_rptr(mux->real_ring);
> +	r_wptr = amdgpu_ring_get_wptr(mux->real_ring);
> +
> +	if (r_wptr < r_rptr)
> +		r_wptr += mux->real_ring->ring_size >> 2;
> +
> +	start = e->start_ptr_in_hw_ring & mux->real_ring->buf_mask;
> +	end = e->end_ptr_in_hw_ring & mux->real_ring->buf_mask;
> +	if (start > end)
> +		end += mux->real_ring->ring_size >> 2;
> +	if (r_rptr <= end && r_rptr >= start) {
> +		offset = r_rptr - start;
> +		e->sw_rptr = (e->sw_cptr + offset) & ring->buf_mask;
> +	} else if (r_rptr < start) {
> +		e->sw_rptr = e->sw_cptr;
> +	} else {
> +		e->sw_rptr = e->sw_wptr;
> +	}
> +
> +	return e->sw_rptr;
> +}
> +
> +/*copy packages on sw ring range[begin, end) */
> +static int copy_pkt_from_sw_ring(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring,
> +	u64 s_begin, u64 s_end)
> +{
> +	u64 begin, end, r_begin, r_end;
> +	struct amdgpu_ring *real_ring = mux->real_ring;
> +
> +	begin = s_begin & ring->buf_mask;
> +	end = s_end & ring->buf_mask;
> +
> +	r_begin = real_ring->wptr & real_ring->buf_mask;
> +	if (begin == end)
> +		return -ERANGE;
> +	if (begin > end) {
> +		amdgpu_ring_alloc(real_ring, (ring->ring_size >> 2) + end - begin);
> +		amdgpu_ring_write_multiple(real_ring, (void *)&ring->ring[begin],
> +			(ring->ring_size >> 2) - begin);
> +		amdgpu_ring_write_multiple(real_ring, (void *)&ring->ring[0], end);
> +	} else {
> +		amdgpu_ring_alloc(real_ring, end - begin);
> +		amdgpu_ring_write_multiple(real_ring, (void *)&ring->ring[begin], end - begin);
> +	}
> +
> +	r_end = real_ring->wptr & real_ring->buf_mask;
> +
> +	return 0;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
> new file mode 100644
> index 000000000000..d058c43bb063
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
> @@ -0,0 +1,67 @@
> +/*
> + * Copyright 2022 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +#ifndef __AMDGPU_RING_MUX__
> +#define __AMDGPU_RING_MUX__
> +
> +#include <linux/timer.h>
> +#include <linux/spinlock.h>
> +#include "amdgpu_ring.h"
> +
> +struct amdgpu_ring;
> +/*
> + * start_ptr_in_hw_ring - last copied start loc on hw ring
> + * end_ptr_in_hw_ring - last copied end loc on hw ring
> + *sw_cptr -the begin of copy ptr in sw ring
> + *sw_rptr; the read ptr in sw ring
> + *sw_wptr; the write ptr in sw ring
> + */
> +struct amdgpu_mux_entry {
> +	struct amdgpu_ring	*ring;
> +	u64 start_ptr_in_hw_ring;
> +	u64 end_ptr_in_hw_ring;
> +
> +	u64 sw_cptr;
> +	u64 sw_rptr;
> +	u64 sw_wptr;
> +};
> +
> +struct amdgpu_ring_mux {
> +	struct amdgpu_ring *real_ring;
> +
> +	struct amdgpu_mux_entry ring_entries[AMDGPU_MAX_GFX_RINGS];
> +
> +	unsigned num_ring_entries;
> +
> +	spinlock_t			lock;
> +
> +};
> +
> +int amdgpu_ring_mux_init(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring);
> +void amdgpu_ring_mux_fini(struct amdgpu_ring_mux *mux);
> +int amdgpu_ring_mux_add_sw_ring(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring);
> +void amdgpu_ring_set_wptr_to_mux(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring, u64 wptr);
> +u64 amdgpu_ring_get_wptr_from_mux(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring);
> +u64 amdgpu_ring_get_rptr_from_mux(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring);
> +
> +#endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c
> new file mode 100644
> index 000000000000..452d0ff37758
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c
> @@ -0,0 +1,204 @@
> +/*
> + * Copyright 2022 Advanced Micro Devices, Inc.
> + * All Rights Reserved.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the
> + * "Software"), to deal in the Software without restriction, including
> + * without limitation the rights to use, copy, modify, merge, publish,
> + * distribute, sub license, and/or sell copies of the Software, and to
> + * permit persons to whom the Software is furnished to do so, subject to
> + * the following conditions:
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDERS, AUTHORS AND/OR ITS SUPPLIERS BE LIABLE FOR ANY CLAIM,
> + * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> + * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
> + * USE OR OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * The above copyright notice and this permission notice (including the
> + * next paragraph) shall be included in all copies or substantial portions
> + * of the Software.
> + *
> + */
> +
> +#include "amdgpu_sw_ring.h"
> +#include "amdgpu_ring_mux.h"
> +
> +#define amdgpu_ring_get_gpu_addr(ring, offset)				\
> +	(ring->is_mes_queue ?						\
> +	 (ring->mes_ctx->meta_data_gpu_addr + offset) :			\
> +	 (ring->adev->wb.gpu_addr + offset * 4))
> +
> +#define amdgpu_ring_get_cpu_addr(ring, offset)				\
> +	(ring->is_mes_queue ?						\
> +	 (void *)((uint8_t *)(ring->mes_ctx->meta_data_ptr) + offset) : \
> +	 (&ring->adev->wb.wb[offset]))
> +
> +
> +int amdgpu_sw_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
> +		     unsigned int max_dw, struct amdgpu_irq_src *irq_src,
> +		     unsigned int irq_type, unsigned int hw_prio,
> +		     atomic_t *sched_score)
> +{
> +	int r;
> +	int sched_hw_submission = amdgpu_sched_hw_submission;
> +	u32 *num_sched;
> +	u32 hw_ip;
> +
> +	BUG_ON(!ring->is_sw_ring);
> +
> +	if (ring->adev == NULL) {
> +		if (adev->num_rings >= AMDGPU_MAX_RINGS)
> +			return -EINVAL;
> +
> +		ring->adev = adev;
> +		ring->num_hw_submission = sched_hw_submission;
> +		ring->sched_score = sched_score;
> +		ring->vmid_wait = dma_fence_get_stub();
> +
> +		if (!ring->is_mes_queue) {
> +			ring->idx = adev->num_rings++;
> +			adev->rings[ring->idx] = ring;
> +		}
> +
> +		r = amdgpu_fence_driver_init_ring(ring);
> +		if (r)
> +			return r;
> +	}
> +
> +	r = amdgpu_device_wb_get(adev, &ring->fence_offs);
> +	if (r) {
> +		dev_err(adev->dev, "(%d) ring fence_offs wb alloc failed\n", r);
> +		return r;
> +	}
> +
> +	r = amdgpu_device_wb_get(adev, &ring->fence_offs);
> +	if (r) {
> +		dev_err(adev->dev, "(%d) ring fence_offs wb alloc failed\n", r);
> +		return r;
> +	}
> +
> +	r = amdgpu_device_wb_get(adev, &ring->trail_fence_offs);
> +	if (r) {
> +		dev_err(adev->dev, "(%d) ring trail_fence_offs wb alloc failed\n", r);
> +		return r;
> +	}
> +
> +	r = amdgpu_device_wb_get(adev, &ring->cond_exe_offs);
> +	if (r) {
> +		dev_err(adev->dev, "(%d) ring cond_exec_polling wb alloc failed\n", r);
> +		return r;
> +	}
> +
> +	ring->fence_gpu_addr =
> +		amdgpu_ring_get_gpu_addr(ring, ring->fence_offs);
> +	ring->fence_cpu_addr =
> +		amdgpu_ring_get_cpu_addr(ring, ring->fence_offs);
> +
> +	ring->trail_fence_gpu_addr =
> +		amdgpu_ring_get_gpu_addr(ring, ring->trail_fence_offs);
> +	ring->trail_fence_cpu_addr =
> +		amdgpu_ring_get_cpu_addr(ring, ring->trail_fence_offs);
> +
> +	ring->cond_exe_gpu_addr =
> +		amdgpu_ring_get_gpu_addr(ring, ring->cond_exe_offs);
> +	ring->cond_exe_cpu_addr =
> +		amdgpu_ring_get_cpu_addr(ring, ring->cond_exe_offs);
> +
> +	/* always set cond_exec_polling to CONTINUE */
> +	*ring->cond_exe_cpu_addr = 1;
> +
> +	r = amdgpu_fence_driver_start_ring(ring, irq_src, irq_type);
> +	if (r) {
> +		dev_err(adev->dev, "failed initializing fences (%d).\n", r);
> +		return r;
> +	}
> +
> +	ring->ring_size = roundup_pow_of_two(max_dw * 4 * sched_hw_submission);
> +
> +	ring->buf_mask = (ring->ring_size / 4) - 1;
> +	ring->ptr_mask = ring->funcs->support_64bit_ptrs ?
> +		0xffffffffffffffff : ring->buf_mask;
> +
> +	/* Allocate ring buffer */
> +	if (ring->ring == NULL) {
> +		ring->ring = kzalloc(ring->ring_size + ring->funcs->extra_dw, GFP_KERNEL);
> +		if (!ring->ring) {
> +			dev_err(adev->dev, "(%d) swring create failed\n", r);
> +			return r;
> +		}
> +
> +		amdgpu_ring_clear_ring(ring);
> +	}
> +
> +	ring->max_dw = max_dw;
> +	ring->hw_prio = hw_prio;
> +
> +	if (!ring->no_scheduler) {
> +		hw_ip = ring->funcs->type;
> +		num_sched = &adev->gpu_sched[hw_ip][hw_prio].num_scheds;
> +		adev->gpu_sched[hw_ip][hw_prio].sched[(*num_sched)++] =
> +			&ring->sched;
> +	}
> +
> +	return 0;
> +}
> +
> +u64 amdgpu_sw_ring_get_rptr_gfx(struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +	struct amdgpu_ring_mux *mux = &adev->gfx.muxer;
> +
> +	BUG_ON(!ring->is_sw_ring);
> +	return amdgpu_ring_get_rptr_from_mux(mux, ring);
> +}
> +
> +u64 amdgpu_sw_ring_get_wptr_gfx(struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +	struct amdgpu_ring_mux *mux = &adev->gfx.muxer;
> +
> +	BUG_ON(!ring->is_sw_ring);
> +	return amdgpu_ring_get_wptr_from_mux(mux, ring);
> +}
> +
> +void amdgpu_sw_ring_set_wptr_gfx(struct amdgpu_ring *ring)
> +{
> +	BUG_ON(!ring->is_sw_ring);
> +}
> +
> +void amdgpu_sw_ring_commit(struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +	struct amdgpu_ring_mux *mux = &adev->gfx.muxer;
> +
> +	BUG_ON(!ring->is_sw_ring);
> +	amdgpu_ring_set_wptr_to_mux(mux, ring, ring->wptr);
> +}
> +
> +void amdgpu_sw_ring_fini(struct amdgpu_ring *ring)
> +{
> +	BUG_ON(!ring->is_sw_ring);
> +
> +	/* Not to finish a ring which is not initialized */
> +	if (!(ring->adev) ||
> +	    (!ring->is_mes_queue && !(ring->adev->rings[ring->idx])))
> +		return;
> +
> +	ring->sched.ready = false;
> +
> +	amdgpu_device_wb_free(ring->adev, ring->cond_exe_offs);
> +	amdgpu_device_wb_free(ring->adev, ring->fence_offs);
> +
> +	kfree((void *)ring->ring);
> +
> +	dma_fence_put(ring->vmid_wait);
> +	ring->vmid_wait = NULL;
> +	ring->me = 0;
> +
> +	ring->adev->rings[ring->idx] = NULL;
> +}
> +
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.h
> new file mode 100644
> index 000000000000..c05d8a94ad0c
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.h
> @@ -0,0 +1,48 @@
> +/*
> + * Copyright 2012 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +#include <drm/amdgpu_drm.h>
> +#include <drm/gpu_scheduler.h>
> +#include <drm/drm_print.h>
> +
> +#include "amdgpu_irq.h"
> +#include "amdgpu_ring.h"
> +#include "amdgpu.h"
> +
> +#ifndef __AMDGPU_SWRING_H__
> +#define __AMDGPU_SWRING_H__
> +
> +int amdgpu_sw_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *sw_ring,
> +		     unsigned int max_dw, struct amdgpu_irq_src *irq_src,
> +		     unsigned int irq_type, unsigned int hw_prio,
> +		     atomic_t *sched_score);
> +void amdgpu_sw_ring_fini(struct amdgpu_ring *ring);
> +u64 amdgpu_sw_ring_get_rptr_gfx(struct amdgpu_ring *ring);
> +u64 amdgpu_sw_ring_get_wptr_gfx(struct amdgpu_ring *ring);
> +void amdgpu_sw_ring_set_wptr_gfx(struct amdgpu_ring *ring);
> +void amdgpu_sw_ring_commit(struct amdgpu_ring *ring);
> +
> +void amdgpu_sw_ring_ib_begin(struct amdgpu_ring *ring);
> +void amdgpu_sw_ring_ib_end(struct amdgpu_ring *ring);
> +
> +#endif

