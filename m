Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91675C6FA8A
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 09:01:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EE1F10E8B9;
	Wed, 14 Sep 2022 09:01:35 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B80010E8B9
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 09:01:32 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id y3so33201267ejc.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 02:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date;
 bh=Iqx6mC8oQmFltTAKt+UE9Wf2CDXKhOfmXBbtKibyGeM=;
 b=U8uIR5oyX0498yjblocpRg/gJSU1gcOU+t9w6n8mVviB5pWZ88w9S3msWDukUqg/+M
 Pg5FtO8nZUD7m6n0E+s6jGT2Tu0DLAx+R/RiIqU2BxH+C27yqJITL9qm/9YU0KwmlHAu
 k53A+Q73y6Cu7CHxuPLq8VEbkTpBvlRFD8/nHq8xLcRttgGN22unZML5uXzWy7Po8Gqs
 SmMg9H6S/4LQXEXmo2hcoX7IAwZmqju2vvPknO3v567aF8tLdTFvHai6oaSp3C9+DO1b
 weL8W0+bgtuaBru5Rg5GNgq7vzqiL30H4CcRQz921Xd4B3siMBXsPe8dReWFyZTE8tT9
 xi+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date;
 bh=Iqx6mC8oQmFltTAKt+UE9Wf2CDXKhOfmXBbtKibyGeM=;
 b=IgbtS4789qr8yww6jILJBEclN4J72XMNO8QFWqSsRk4azwOfnfRDB0v4ZCOfSaOZU3
 J4WHbulInbaNE396VF3qCTuft+zVwm33AeU7VDb10BeqNnYAMSQa+7VCe82JKy3sysTD
 /knsHKLafSlfIiYkBamYCuatwcwrVvp2WUH1obQZTC3nW3+td3ViCV8uYH0sP48lpHLy
 iO3im9YXbWm3qu2pvEzSNxCoY3vqGjxeFOJ5wIe2yEpOCv45p2jqgwPF4Deum4cdcxg4
 5KpZJq0v6tDKxTuhoJ4aNuoRzssYcEf4nFc5p/ccZdIm6ps03NtrjjxutkkVaYZKSe9A
 drew==
X-Gm-Message-State: ACgBeo0XbVZ27oGerUEtIwj+JfpGl6iYWz4nBMoNb69quiAO4dU5Iw9H
 Ca17PY3C3JYzBe3zK1QotaM=
X-Google-Smtp-Source: AA6agR6fcdmP+nYRGLffSxkkvZ8kqcuA7EhFW4B1Jdn7TWgUZUYMDLlEQOQiQqGGFHcWbaxWrBQkBw==
X-Received: by 2002:a17:907:6d08:b0:77b:d4f:e409 with SMTP id
 sa8-20020a1709076d0800b0077b0d4fe409mr13873581ejc.744.1663146090449; 
 Wed, 14 Sep 2022 02:01:30 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:158e:603b:8394:aba3?
 ([2a02:908:1256:79a0:158e:603b:8394:aba3])
 by smtp.gmail.com with ESMTPSA id
 q10-20020a170906360a00b007309a570bacsm7361676ejb.176.2022.09.14.02.01.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Sep 2022 02:01:29 -0700 (PDT)
Message-ID: <7b4f18c7-abf1-8aaf-c50b-6d0e0fe1c5eb@gmail.com>
Date: Wed, 14 Sep 2022 11:01:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/4] drm/amdgpu: Introduce gfx software ring(v4)
Content-Language: en-US
To: jiadong.zhu@amd.com, amd-gfx@lists.freedesktop.org
References: <20220913090558.685714-1-jiadong.zhu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220913090558.685714-1-jiadong.zhu@amd.com>
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
Cc: Ray.Huang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 13.09.22 um 11:05 schrieb jiadong.zhu@amd.com:
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
> v4: remove amdgpu_ring_sw_init/fini functions,
> using gtt for sw ring buffer for later dma copy
> optimization.
>
> Signed-off-by: Jiadong.Zhu <Jiadong.Zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/Makefile          |   3 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h      |   3 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h     |   3 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c | 182 +++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h |  67 +++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c  |  60 ++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.h  |  43 +++++
>   7 files changed, 360 insertions(+), 1 deletion(-)
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
> index 000000000000..652a6d3e0ec3
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
> +	u64 r_rptr, offset, start, end;
> +
> +	e = amdgpu_get_sw_entry(mux, ring);
> +	if (!e) {
> +		DRM_ERROR("no sw entry found!\n");
> +		return 0;
> +	}
> +
> +	r_rptr = amdgpu_ring_get_rptr(mux->real_ring);
> +
> +	start = e->start_ptr_in_hw_ring & mux->real_ring->buf_mask;
> +	end = e->end_ptr_in_hw_ring & mux->real_ring->buf_mask;
> +	if (start > end) {
> +		if (r_rptr <= end)
> +			r_rptr += mux->real_ring->ring_size >> 2;
> +		end += mux->real_ring->ring_size >> 2;
> +	}
> +
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

Drop the return value here. There is no error handling which would make 
sense here.

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

So this could either mean we should copy nothing or everything. I think 
the best approach would be to print an error into the sytem log if that 
every happens.

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
> index 000000000000..7a59e3fbb970
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c
> @@ -0,0 +1,60 @@
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
> +u64 amdgpu_sw_ring_get_rptr_gfx(struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +	struct amdgpu_ring_mux *mux = &adev->gfx.muxer;
> +
> +	BUG_ON(!ring->is_sw_ring);

Never ever add a BUG_ON() if you don't prevent further corruption or 
make an imminent crash more obvious to track down with it.

This here should be a WARN_ON instead.

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
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.h
> new file mode 100644
> index 000000000000..0a2e66318f3f
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.h
> @@ -0,0 +1,43 @@
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
> +u64 amdgpu_sw_ring_get_rptr_gfx(struct amdgpu_ring *ring);
> +u64 amdgpu_sw_ring_get_wptr_gfx(struct amdgpu_ring *ring);
> +void amdgpu_sw_ring_set_wptr_gfx(struct amdgpu_ring *ring);
> +void amdgpu_sw_ring_commit(struct amdgpu_ring *ring);
> +
> +void amdgpu_sw_ring_ib_begin(struct amdgpu_ring *ring);
> +void amdgpu_sw_ring_ib_end(struct amdgpu_ring *ring);
> +
> +#endif

