Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6EA5C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jun 2022 07:51:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3841410E8C8;
	Wed, 15 Jun 2022 07:51:09 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6610B10E8EE
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jun 2022 07:51:07 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id 25so14842470edw.8
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jun 2022 00:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=dbBBAgQysQPlT6VJW6XgW6dVAnmsUwZU/CE8uZNC2fU=;
 b=llMTE4b+UHVQLnVBdHqZhepqYlXIQXRWttwPWUphFHa52iMfsTDJpv+DEMLWP0BEID
 qV6e3EmvHoE2bqqqnc02WXKsK08aWUPKg9QlP0C6DV1rxVYGv5+N/02tYuZCUIKs57mC
 U1s5EGNhsJjjognc0XT/4sqkeAxSApW70yxO7ZtkkZOeCXT4DYLOEwjIG8h5zRa7hUkk
 YTKjvZwXAkQXbJA8c8qTiHrlgr2UWrKQfv4/xrMcTi5Z6AkM1+NslhEeWdDwKPmQ0Lz9
 YNSFz/VjZz3lsl9y3DppoThQnv1BgS7g9U4u85FA/7gFj7EcvjBFWweZXN1Duqh31crJ
 JrzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=dbBBAgQysQPlT6VJW6XgW6dVAnmsUwZU/CE8uZNC2fU=;
 b=7pzKrYDivR8ghDrh2aJNoqn+tS1sygDdBJL8Rzpe5VLxKaBNxideuFfFBuUecoT5CD
 tZG9AHU8AnDgj6hAPlZrEu+B6qyikGAyHP01oIMzyD8P7Powm++5XfVrXR9jcjdJg4aa
 wlQOAfhJzOnRg0OgJM19myKOaTtbDpXp/+85ufc/pm+VqhbQ/E6XR1j3kYIkyY00IbTY
 LrJ5G3oytrouyVWocbXVv/X7VwwYurw34+HVZux500R2pmY8P0vg+7klZSyCWsOVO2pm
 LFc8mLShViavySeWmG4yCYB4MbyrrO5o2xoDPWUis82Tmi06tUY4pSn1/+fpUWtbxvQm
 S51Q==
X-Gm-Message-State: AOAM532Lj34CjuVgU2VWSgn3U/v6AWfEcvVw858yu+uZz8s/8nYvOvtg
 FhHiNscRXt2usxLGeOf0PeCM0i7PQ5Y=
X-Google-Smtp-Source: ABdhPJzztBqNfNyz0JavGRYDvxOEw+256XjNRBqFPhl24+G2C8bpOcipo7yzmzpz8e4dpOIjZPZ7OQ==
X-Received: by 2002:a05:6402:177b:b0:433:426d:83ea with SMTP id
 da27-20020a056402177b00b00433426d83eamr11126402edb.18.1655279465877; 
 Wed, 15 Jun 2022 00:51:05 -0700 (PDT)
Received: from [192.168.178.21] (p5b0ea4d2.dip0.t-ipconnect.de.
 [91.14.164.210]) by smtp.gmail.com with ESMTPSA id
 u26-20020aa7db9a000000b004314bb65e7fsm8740411edt.41.2022.06.15.00.51.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jun 2022 00:51:05 -0700 (PDT)
Message-ID: <a5a994db-38eb-3822-7af3-b366f8c7bea6@gmail.com>
Date: Wed, 15 Jun 2022 09:51:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] drm/amdgpu/vcn: adjust unified queue code format
Content-Language: en-US
To: Ruijing Dong <ruijing.dong@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220615025610.49839-1-ruijing.dong@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220615025610.49839-1-ruijing.dong@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: alexander.deucher@amd.com, leo.liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 15.06.22 um 04:56 schrieb Ruijing Dong:
> Fixed some errors and warnings found by checkpatch.pl.
>
> Signed-off-by: Ruijing Dong <ruijing.dong@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 12 ++++++------
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   |  8 ++++----
>   2 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index e62ff7db4736..fea436023351 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -730,8 +730,8 @@ int amdgpu_vcn_dec_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>   	return r;
>   }
>   
> -static uint32_t * amdgpu_vcn_unified_ring_ib_header(struct amdgpu_ib *ib,
> -					  uint32_t ib_pack_in_dw, bool enc)
> +static uint32_t *amdgpu_vcn_unified_ring_ib_header(struct amdgpu_ib *ib,
> +						uint32_t ib_pack_in_dw, bool enc)
>   {
>   	uint32_t *ib_checksum;
>   
> @@ -749,7 +749,7 @@ static uint32_t * amdgpu_vcn_unified_ring_ib_header(struct amdgpu_ib *ib,
>   }
>   
>   static void amdgpu_vcn_unified_ring_ib_checksum(uint32_t **ib_checksum,
> -				        uint32_t ib_pack_in_dw)
> +						uint32_t ib_pack_in_dw)
>   {
>   	uint32_t i;
>   	uint32_t checksum = 0;
> @@ -790,7 +790,7 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
>   	/* single queue headers */
>   	if (sq) {
>   		ib_pack_in_dw = sizeof(struct amdgpu_vcn_decode_buffer) / sizeof(uint32_t)
> -			                     + 4 + 2; /* engine info + decoding ib in dw */
> +						+ 4 + 2; /* engine info + decoding ib in dw */
>   		ib_checksum = amdgpu_vcn_unified_ring_ib_header(ib, ib_pack_in_dw, false);
>   	}
>   
> @@ -896,7 +896,7 @@ static int amdgpu_vcn_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
>   					 struct amdgpu_ib *ib_msg,
>   					 struct dma_fence **fence)
>   {
> -	unsigned ib_size_dw = 16;
> +	unsigned int ib_size_dw = 16;
>   	struct amdgpu_job *job;
>   	struct amdgpu_ib *ib;
>   	struct dma_fence *f = NULL;
> @@ -962,7 +962,7 @@ static int amdgpu_vcn_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
>   					  struct amdgpu_ib *ib_msg,
>   					  struct dma_fence **fence)
>   {
> -	unsigned ib_size_dw = 16;
> +	unsigned int ib_size_dw = 16;
>   	struct amdgpu_job *job;
>   	struct amdgpu_ib *ib;
>   	struct dma_fence *f = NULL;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> index d6f134ef9633..84ac2401895a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -120,7 +120,7 @@ static int vcn_v4_0_sw_init(void *handle)
>   		sprintf(ring->name, "vcn_unified_%d", i);
>   
>   		r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[i].irq, 0,
> -				  AMDGPU_RING_PRIO_0, &adev->vcn.inst[i].sched_score);
> +						AMDGPU_RING_PRIO_0, &adev->vcn.inst[i].sched_score);
>   		if (r)
>   			return r;
>   
> @@ -907,7 +907,7 @@ static int vcn_v4_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
>   	WREG32_SOC15(VCN, inst_idx, regUVD_RB_RPTR, 0);
>   	WREG32_SOC15(VCN, inst_idx, regUVD_RB_WPTR, 0);
>   
> -	tmp= RREG32_SOC15(VCN, inst_idx, regUVD_RB_RPTR);
> +	tmp = RREG32_SOC15(VCN, inst_idx, regUVD_RB_RPTR);
>   	WREG32_SOC15(VCN, inst_idx, regUVD_RB_WPTR, tmp);
>   	ring->wptr = RREG32_SOC15(VCN, inst_idx, regUVD_RB_WPTR);
>   
> @@ -1048,8 +1048,8 @@ static int vcn_v4_0_start(struct amdgpu_device *adev)
>   
>   				dev_err(adev->dev, "VCN[%d] is not responding, trying to reset the VCPU!!!\n", i);
>   				WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL),
> -						UVD_VCPU_CNTL__BLK_RST_MASK,
> -						~UVD_VCPU_CNTL__BLK_RST_MASK);
> +							UVD_VCPU_CNTL__BLK_RST_MASK,
> +							~UVD_VCPU_CNTL__BLK_RST_MASK);
>   				mdelay(10);
>   				WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL), 0,
>   						~UVD_VCPU_CNTL__BLK_RST_MASK);

