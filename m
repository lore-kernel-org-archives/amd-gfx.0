Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B0A0C77B72
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Apr 2023 12:46:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89F8510E7CD;
	Wed, 12 Apr 2023 12:46:09 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24E2510E7CD
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Apr 2023 12:46:08 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 hg25-20020a05600c539900b003f05a99a841so14034886wmb.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Apr 2023 05:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1681303566; x=1683895566;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iZwv1eGnXgWO/Pl13kLJQAgBYi84P7vcOtTAsoXaiU0=;
 b=PwGgA0k0TICpx5yvwwOgcEe9Rnz/JW4qdltGKam9E4s+x/TxgAevO62gjH+5Bfi2yd
 WvJDJEHvykUp/QR5H5t4BYPJnG5xNiy8A/MvFHQ4Oy4HQ3cW1YcXeaxcZ6x88EUjO/AA
 dZXdR1XOX5PORp7cEKaYKxPHQRySLUXCcgeou7nYbRIAGwaKwiDf/F9ZJ51n0fFNuTPx
 GeI2wXoA/az+5ZufSE9r4OsxHSR6etOjZ4AwXAAhQA5yEFJmTCp9GAT3e28ux5w41VIY
 ox2LqeJAHVn0JGTsE2r2FFGcSVw2rP40PJzRf588/y6lBj/ZkTuOCS5vTmvKxgEYg3vK
 A0xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681303566; x=1683895566;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iZwv1eGnXgWO/Pl13kLJQAgBYi84P7vcOtTAsoXaiU0=;
 b=w0UOAZZKoB2hqoURSE1uTGH78ZhmtjxT98Yynk3WWWtsW1NUw9Eid/gXCBqXf4oD91
 Hsow9JHgD6g6lgPuM8WX2uRpZvkb08K+ilVShCMb9rX7GWxYTk++J4yWmEB5PgabZ9lo
 DbTFpTm1qw+OvGEGjeo//KPx4y3xveN2/uwmPdyxmzyjCLL6/pbo4HM9f91fIN2GFm+4
 4X9wbRe77jJNxG2llq8MWLl6KSho6/diS4Bp2RPjAksD+xhF0Gd7hyFtnwaJTQ8172UI
 eOUnnPah9tpt6oE1no8yxyjyykXiPz4ie/gMzhCGHfn9/LqAHVC0G6liupmEd8PcY4Vp
 rzwQ==
X-Gm-Message-State: AAQBX9d8t9IDpm4+jshy2vq2JdJtTfuXGU5waOGPpuhzAE6zp5p65clE
 htsdocEcEdPu7U/EEoupFAY=
X-Google-Smtp-Source: AKy350bcLYu3A976g5XiuI4eP4xCQCtX7lirCbUQp1Gl1RBrbGFa6AavrCulgjVfOjvw/ibHMSnUNw==
X-Received: by 2002:a1c:7917:0:b0:3f0:7f4f:2aa8 with SMTP id
 l23-20020a1c7917000000b003f07f4f2aa8mr1880678wme.9.1681303565766; 
 Wed, 12 Apr 2023 05:46:05 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:fe02:9bb5:5deb:be0e?
 ([2a02:908:1256:79a0:fe02:9bb5:5deb:be0e])
 by smtp.gmail.com with ESMTPSA id
 m13-20020a05600c4f4d00b003f09c489940sm2354219wmq.28.2023.04.12.05.46.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Apr 2023 05:46:05 -0700 (PDT)
Message-ID: <4365dd57-f61d-9d19-79c8-697f0554fa26@gmail.com>
Date: Wed, 12 Apr 2023 14:46:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 1/2] drm/amdgpu: Add a max ibs per submission limit.
Content-Language: en-US
To: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>, amd-gfx@lists.freedesktop.org
References: <20230412121827.1122035-1-bas@basnieuwenhuizen.nl>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230412121827.1122035-1-bas@basnieuwenhuizen.nl>
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, maraeo@gmail.com,
 timur.kristof@gmail.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 12.04.23 um 14:18 schrieb Bas Nieuwenhuizen:
> And ensure each ring supports that many submissions. This makes
> sure that we don't get surprises after the submission has been
> scheduled where the ring allocation actually gets rejected.
>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2498
> Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   |  3 +++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 25 ++++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  1 +
>   3 files changed, 29 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 7af3041ccd0e..8362738974c8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -110,6 +110,9 @@ static int amdgpu_cs_p1_ib(struct amdgpu_cs_parser *p,
>   	if (r < 0)
>   		return r;
>   
> +	if (num_ibs[r] >= amdgpu_ring_max_ibs(chunk_ib->ip_type))
> +		return -EINVAL;
> +
>   	++(num_ibs[r]);
>   	p->gang_leader_idx = r;
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index dc474b809604..abd70d2f26f6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -49,6 +49,25 @@
>    * them until the pointers are equal again.
>    */
>   
> +/**
> + * amdgpu_ring_max_ibs - Return max IBs that fit in a single submission.
> + *
> + * @type: ring type for which to return the limit.
> + */
> +unsigned int amdgpu_ring_max_ibs(enum amdgpu_ring_type type)
> +{
> +	switch (type) {
> +	case AMDGPU_RING_TYPE_GFX:
> +	case AMDGPU_RING_TYPE_COMPUTE:
> +		/* gfx/compute are often used more extensively and radv
> +		 * has historically assumed the limit was 192.
> +		 */
> +		return 192;
> +	default:
> +		return 50;
> +	}
> +}
> +
>   /**
>    * amdgpu_ring_alloc - allocate space on the ring buffer
>    *
> @@ -182,6 +201,7 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
>   	int sched_hw_submission = amdgpu_sched_hw_submission;
>   	u32 *num_sched;
>   	u32 hw_ip;
> +	unsigned int max_ibs_dw;
>   
>   	/* Set the hw submission limit higher for KIQ because
>   	 * it's used for a number of gfx/compute tasks by both
> @@ -290,6 +310,11 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
>   		return r;
>   	}
>   
> +	max_ibs_dw = ring->funcs->emit_frame_size +
> +		     amdgpu_ring_max_ibs(ring->funcs->type) * ring->funcs->emit_ib_size;
> +	max_ibs_dw = (max_ibs_dw + ring->funcs->align_mask) & ~ring->funcs->align_mask;
> +	max_dw = max(max_dw, max_ibs_dw);

I think something like "if (WARN_ON(max_ibs_dw > max_dw) max_dw = 
max_ibs_dw;" would be more appropriate.

Apart from that this looks really good to me,
Christian.

> +
>   	ring->ring_size = roundup_pow_of_two(max_dw * 4 * sched_hw_submission);
>   
>   	ring->buf_mask = (ring->ring_size / 4) - 1;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 3989e755a5b4..e6e672727529 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -317,6 +317,7 @@ struct amdgpu_ring {
>   #define amdgpu_ring_patch_cond_exec(r,o) (r)->funcs->patch_cond_exec((r),(o))
>   #define amdgpu_ring_preempt_ib(r) (r)->funcs->preempt_ib(r)
>   
> +unsigned int amdgpu_ring_max_ibs(enum amdgpu_ring_type type);
>   int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsigned ndw);
>   void amdgpu_ring_ib_begin(struct amdgpu_ring *ring);
>   void amdgpu_ring_ib_end(struct amdgpu_ring *ring);

