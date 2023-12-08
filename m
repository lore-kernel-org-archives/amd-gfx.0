Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB445C4167B
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Dec 2023 08:19:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B01210E25A;
	Fri,  8 Dec 2023 08:19:27 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB48910E25A
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Dec 2023 08:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1702023562; x=1702628362; i=friedrich.vock@gmx.de;
 bh=prJeMVz0zr0lHid82lS8OH9O/z+mHWshjSuppbfC520=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=t/dZBMV7sOkQRl0pjRZdT906se036N2cVOWm7GgTZyVmfaug4bUFRo6JjMRzGVzn
 m8Vfj7rLA5avlyS8/oPnYN1kU4Wv19cuuA1qaoAPdBsVNz2q1lecdu6NUBYd9nflY
 E4xE3NR7xYpeiDBnhoVqiyogm5epF4I9TrpzfIqztH+Pv7P/Fc1VvKghs6TlGwlWC
 71u7PP6Vxu823pbQwym3K1nY1H/twqJF1xKV7b2tV4R7StHXtTmLbCYlys0IYon+W
 1nc43QZyOtAJsvfp+Nz53pmB+XElxeO+JpHfilqWkrz7NJ6kLnSCG6Hq1er4yFLtX
 9REBKoxTKjQoxFMfSw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.177.3] ([213.152.118.80]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N8XPn-1rG07P0INN-014RAQ; Fri, 08
 Dec 2023 09:19:22 +0100
Message-ID: <3525f437-9537-4fb4-80d0-65acd9d55d2f@gmx.de>
Date: Fri, 8 Dec 2023 09:19:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Enable tunneling on high-priority compute
 queues
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org
References: <20231202001740.120840-1-friedrich.vock@gmx.de>
From: Friedrich Vock <friedrich.vock@gmx.de>
Autocrypt: addr=friedrich.vock@gmx.de; keydata=
 xsDNBGPTxTYBDACuXf97Zpb1IttAOHjNRHW77R759ueDHfkZT/SkWjtlwa4rMPoVdJIte9ZY
 +5Ht5+MLdq+Pjd/cbvfqrS8Q+BBwONaVzjDP35lQdim5sJ/xBqm/sozQbGVLJ/szoYhGY+va
 my9lym47Z14xVGH1rhHcXLgZ0FHbughbxmwX77P/BvdI1YrjIk/0LJReph27Uko8WRa3zh6N
 vAxNk6YKsQj4UEO30idkjmpw6jIN2qU7SyqKmsI+XnB9RrUyisV/IUGGuQ4RN0Rjtqd8Nyhy
 2qQGr8tnbDWEQOcdSCvE/bnSrhaX/yrGzwKoJZ8pMyWbkkAycD72EamXH13PU7A3RTCrzNJa
 AKiCvSA9kti4MRkoIbE+wnv1sxM+8dkDmqEY1MsXLTJ4gAkCnmsdGYz80AQ2uyXD06D8x/jR
 RcwbRbsQM5LMSrXA0CDmNXbt5pst7isDbuoBu1zerqy2ba+rf6sxnSnCzQR6SuE0GB7NYV8A
 lrNVyQlMModwmrY2AO3rxxcAEQEAAc0mRnJpZWRyaWNoIFZvY2sgPGZyaWVkcmljaC52b2Nr
 QGdteC5kZT7CwQ4EEwEIADgWIQT3VIkd33wSl/TfALOvWjJVL7qFrgUCY9PFNgIbAwULCQgH
 AgYVCgkICwIEFgIDAQIeAQIXgAAKCRCvWjJVL7qFro7GC/9PfV0ICDbxBoILGLM6OXXwqgoC
 HkAsBEXE/5cS68TT++YXMHCetXpFfBIwTe8FlBcbhtylSYIUhFLmjiGfgoXy5S87l9osOp1G
 y3+RNbFoz4OJvqcXX5BqFK5KHh7iL/Q6BaZB9u3es0ifFt5YMwhDgcCbYaLUlTPbl+5m+/ie
 Eori0ASylvhz3EdB11sMqN9CmoKvBEVnkdiydDMuFvpEi08WB8ZC8qckiuwrLOIa4/JB54E2
 QyGw0KgBT4ApeMmkKurS3UOsrAwoKKP/0rgWsBFVnXrBIOEL+7/HGqSSDboLAjt1qE967yxM
 3Qzt1FUBU9db2biFW7O3TmXP31SyPwVYWfeETa4MT9A8EyjfWF66+sfPXREsBvqRTin3kEst
 IlbMdSNijCjKZz9XPCaKwx3hJaD5VEs3gPsKa9qXOQftfTqt+SI0nYBw3sdT2+wWJCeyZ3aE
 L0Us8uMILncTxVAhX2a8pUvGrbtuyW2qqEFId1OSfWlrLZEuv8+631fOwM0EY9PFNgEMAKx2
 G48lrQ1bLAWgjq3syyswS80e70M+/Fbxb2aBKRHw5XbpSPYr9FLE3MPdgvUtt+fiK2xA69bk
 i86sfSV2KNhRuiS2rb1h/jfmTlxfimBezHv6xnzVuHJNd87vL35lqd0D6B5zvnzzP9CjpXq/
 o7isfiA2FMSOI1OnrHEw9pbEd1B26cgS+mIGhDf/gBI6MtsPuN8xMUyybtpUSSVi3b4oRkge
 +vwwbMn+vwvhN39kjcISAT+jFWNupDybFIs8cYNWA7MkWJAIuqSjMydE0l1+c8eF7nnvzY2o
 2GGarFmxNO4CHuh3JoMFfY4wlKjmDlk+FJ5UfIFelVmOiVPLGrSL8ggcubnOS75VjDvDTQgY
 tjDvLuUmOj1vYSmPSE9PjDMhrpx1LcSOHyV+aX0NQeHP869A/YLjwQbOJBJVIN+XdsGlnwG5
 teXXxU9uwFDqYPAneHp4As5OKovOCIzNj6EB4MIZIpTGgYQBIN4xrwL0YsjvPm2i1RyBPTpf
 UKvjVQARAQABwsD2BBgBCAAgFiEE91SJHd98Epf03wCzr1oyVS+6ha4FAmPTxTYCGwwACgkQ
 r1oyVS+6ha4Hlgv/Z2q6pSxeCjK/g20vub8Gvg09jNYAle3FTaJD2Jd/MhUs6s9Y5StWtiDf
 hw27O8bhJan1W4hrngQceR2EcvKxejroVhu3UI2b9ElM5aphD2IolOWqfwPXeUetIgaMNqTl
 GJ9rGx+k8HCpchW4QVZfWn7yM+IymCwOYov+36vMMHd8gdQ0BxMiT2WLDzCWwDb+/PYMfOiq
 AoPBV5EQ2K3x85wl9N4OxiQdGWi9+/0KJyMPYoGlFqCdPdvvbpFe4XD6YOBr3HmVOFCWtLcW
 Bm+BCucpo93VhjNVqZ+cuN/tlS+Px8kl0qW9J3Q8fwWhgz69v5YdiOczQza/zQu3YrcYapBD
 kQXSmDju1Yd4jIGeZ8vf+dnmbX78mpj3nBmYLhIs5lszAH634uoWyJqMLs77WG1pkk0utvwh
 Zvq4r6fbLIuofLsboYKQxUJuX5uRSK4/hWXEETUTxxvkA/hiuhsdMbDWIZWFp8yuoZvR2itT
 f7+xmX0X3AMtWz/15Y+7cPO2
In-Reply-To: <20231202001740.120840-1-friedrich.vock@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:gfXcfkcgzW/hHTn1941WaEfl5KSlv+PvFxx41t6etbkY/v9bCyC
 KCRkHhpxlXR2SErWKNNSD5XcrsjQxkkQr6ut/y0geRmKTC/psFJsZb2w4K8zy6UT1EXr1IL
 46Grk7PQKpEU+ubTbOejOQiH5xrpJdCvAUnwfWuZj3bwET6Dh3eUapXePzQVyc5mfoXoJ3P
 5CK6mepxt2ein6AWxYRBA==
UI-OutboundReport: notjunk:1;M01:P0:K5owJCQOwkM=;0au0qo03IsVMMyeFb4d76GHz+c1
 PSMg/EvI4hBv9DVpGXskaSn2epPEyBSFPkgg9i3PmeS44pcoPiPw/YaoYPJecz7QwsWzCPs1h
 U+Zli6NAH/6P6U2CPva3a6BWQYrDNmtSf0i8eDv5d9Bx5o7dsrLy28SukyoQfNRzZys6OdgZD
 SZ7HoG4kQ3yef/fpFBz1207dpknEonLH1Pa1cbiYrob2NLG00C3+SOLifYglwrsF5KpoDkWaw
 Tflg7c8i7D7xLoEYFAhzFf5I66AmBloujcIKu/Ndp6GvqEsaJOqWeGI4YIroAw+afjoIIRVVM
 OnKsLPHzBH7+8aVA+f4gMmkFhyV5pSZPMG4UkSEXAi98sJeC6XeG+seDkUe/jICMHTma/EVd2
 EUQcRHZkfR2Y0MZYhB0fIj/0Zob38CewYKK87J+c/jTzo3q6hKpK4GnQYmFuSYhF6UnOzVzj9
 36L2W+N+L8ZJcUNkSf7x7yoRYhdZMryxWL0KjbZ7ZA4R0mlBCpDh7L01DVyyfPxS8qA2MlfIm
 oV5tg+J4zUDygjeVhp47bB2eOwHC3Xj6OdopHyrGkBi+hlVfy5RGmUnWMM7dzjtJgWDk403zD
 E0Fa/Ufva/v2JwbkD6ZlAfzTqic56ZwFHeWfq0Kjin3FAw9AGiaPN/gFaCfiJkmNBujdudTD6
 Ch5CVknQQ/wQdidJEiZmSTDvMppEEXyQnbJhxvCeZrWlIddnk/SxSzoPuBKQ+EmT9EOyvArvn
 dv+rIkZjZTchG+gKob7tTc3lByR1wW6UsXlnISSiRC+sIG4qZvYu921zAh/RijPcQ3w9q7+Ca
 obT/sPmLaqHm5GpdWmF0UZs0peCz+kAoINusLvHEz/fTGP0WpuR0V4G4zyYetQ/t+Y4z55cCr
 4rFIWEKMFgjH7JFQl9bXVu6moa0cyexwHAt/cwlatMtZYtf9AE6+COtBVZyYfm9ARxRmojrTf
 F+bUNfB9gHhOMIwXE2Y17oHNzL0=
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Friendly ping on this one.
Userspace side got merged, so would be great to land this patch too :)

On 02.12.23 01:17, Friedrich Vock wrote:
> This improves latency if the GPU is already busy with other work.
> This is useful for VR compositors that submit highly latency-sensitive
> compositing work on high-priority compute queues while the GPU is busy
> rendering the next frame.
>
> Userspace merge request:
> https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/26462
>
> Signed-off-by: Friedrich Vock <friedrich.vock@gmx.de>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 10 ++++++----
>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   |  3 ++-
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   |  3 ++-
>   4 files changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 9505dc8f9d69..4b923a156c4e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -790,6 +790,7 @@ struct amdgpu_mqd_prop {
>   	uint64_t eop_gpu_addr;
>   	uint32_t hqd_pipe_priority;
>   	uint32_t hqd_queue_priority;
> +	bool allow_tunneling;
>   	bool hqd_active;
>   };
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index 231d49132a56..4d98e8879be8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -620,6 +620,10 @@ static void amdgpu_ring_to_mqd_prop(struct amdgpu_ring *ring,
>   				    struct amdgpu_mqd_prop *prop)
>   {
>   	struct amdgpu_device *adev = ring->adev;
> +	bool is_high_prio_compute = ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE &&
> +				    amdgpu_gfx_is_high_priority_compute_queue(adev, ring);
> +	bool is_high_prio_gfx = ring->funcs->type == AMDGPU_RING_TYPE_GFX &&
> +				amdgpu_gfx_is_high_priority_graphics_queue(adev, ring);
>
>   	memset(prop, 0, sizeof(*prop));
>
> @@ -637,10 +641,8 @@ static void amdgpu_ring_to_mqd_prop(struct amdgpu_ring *ring,
>   	 */
>   	prop->hqd_active = ring->funcs->type == AMDGPU_RING_TYPE_KIQ;
>
> -	if ((ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE &&
> -	     amdgpu_gfx_is_high_priority_compute_queue(adev, ring)) ||
> -	    (ring->funcs->type == AMDGPU_RING_TYPE_GFX &&
> -	     amdgpu_gfx_is_high_priority_graphics_queue(adev, ring))) {
> +	prop->allow_tunneling = is_high_prio_compute;
> +	if (is_high_prio_compute || is_high_prio_gfx) {
>   		prop->hqd_pipe_priority = AMDGPU_GFX_PIPE_PRIO_HIGH;
>   		prop->hqd_queue_priority = AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM;
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index c8a3bf01743f..73f6d7e72c73 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -6593,7 +6593,8 @@ static int gfx_v10_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
>   	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, ENDIAN_SWAP, 1);
>   #endif
>   	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, UNORD_DISPATCH, 0);
> -	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNNEL_DISPATCH, 0);
> +	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNNEL_DISPATCH,
> +			    prop->allow_tunneling);
>   	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, PRIV_STATE, 1);
>   	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, KMD_QUEUE, 1);
>   	mqd->cp_hqd_pq_control = tmp;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index c659ef0f47ce..bdcf96df69e6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -3847,7 +3847,8 @@ static int gfx_v11_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
>   	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, RPTR_BLOCK_SIZE,
>   			    (order_base_2(AMDGPU_GPU_PAGE_SIZE / 4) - 1));
>   	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, UNORD_DISPATCH, 0);
> -	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNNEL_DISPATCH, 0);
> +	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNNEL_DISPATCH,
> +			    prop->allow_tunneling);
>   	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, PRIV_STATE, 1);
>   	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, KMD_QUEUE, 1);
>   	mqd->cp_hqd_pq_control = tmp;
> --
> 2.43.0
>
