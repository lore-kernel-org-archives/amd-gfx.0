Return-Path: <SRS0=q3BR=7P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE7CBC433DF
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 10:00:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81D6020679
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 10:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URk64xCE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81D6020679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07D986E19C;
	Tue,  2 Jun 2020 10:00:37 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82D7E6E19C
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jun 2020 10:00:35 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id j198so1869987wmj.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 02 Jun 2020 03:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=mYKk9nhJs3kOOs6lEwod3u0dwd5iYCypao+iTZZLO3A=;
 b=URk64xCEQJthY64jGCqS54tMdxNeUJ00QiUPQuZf3tcg7F5Os8bhb5pf77yG1dv9oS
 1RdbEJMq5qItcW+F6PSoeQI/N701cnS9cSDU9plR6DTBu8jafi1oiNWn9t8oo91W+w8C
 n4s4vu2pMXu5MX5aUIUza5EjOZbH7FcVRUNW9e83JC8wef088Z9JxkT1f7yeudREiXzg
 QtFu81NsA4Or4r5jjEp+kg/ZBjlvRFPXYY88b4DKtoh8pXRCLQDfezIVfZDmrihd6Z5G
 9YUjdwlaXxPFVjC0YInjKJI+TCnz0tjw89e8cnbrfUDvejmKb9rf4FVkUOHzjVd8taLB
 YkNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=mYKk9nhJs3kOOs6lEwod3u0dwd5iYCypao+iTZZLO3A=;
 b=F5Bp+G68813KgHL4k/CapHkSaDG/zyWbfbhbxjtz3cqDdBRIt+lHSmHuIenemCIbdH
 1ixBbrfxQeXRDEv1y+2ZbnmI0vxIDnxgq2UT/FZkJkRreA9RPb+blDpnycTzBaHU/cbL
 VhJv/eMRbXdPetYRV+Y7r7p80naWUpx1jmdWSfVXG7Yl1w9X1u8cgoU2JMKOb7RoSegA
 zU0NJNJybopnlp2wq6mmfbpx9cvhCwICDnCupPsRUVpdf3R0gxOi06eqpHwXQl7XVnCe
 9Niq8Fv646nK9I7AixaBhIqVpycckwbbXOK0UInFC5Q3H0/LPs93szywIGBBKA8XA79M
 AnJQ==
X-Gm-Message-State: AOAM530vYZAj2aJ3rhULxTOQB7LfM6vLa//fdRcHlpQob+bLXsWEnl/V
 LQwgdWN1+lbHOfOIRhndXhM=
X-Google-Smtp-Source: ABdhPJy+Vi3cutwo4nS5spDb+q+JAjJywIg4MhsN8MjI1D2qRzZsADMqnyhCMAAYZad5EF+6GCa9dg==
X-Received: by 2002:a1c:4d11:: with SMTP id o17mr3281672wmh.37.1591092034212; 
 Tue, 02 Jun 2020 03:00:34 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id h18sm2993013wru.7.2020.06.02.03.00.33
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 02 Jun 2020 03:00:33 -0700 (PDT)
Subject: Re: [PATCH 061/207] drm/amdgpu/mes10.1: implement the ring functions
 of mes specific
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200601180239.1267430-1-alexander.deucher@amd.com>
 <20200601180239.1267430-58-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <78297506-1670-da85-21d0-b6a32dc945c2@gmail.com>
Date: Tue, 2 Jun 2020 12:00:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200601180239.1267430-58-alexander.deucher@amd.com>
Content-Language: en-US
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
Reply-To: christian.koenig@amd.com
Cc: Alex Deucher <alexander.deucher@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 01.06.20 um 20:00 schrieb Alex Deucher:
> From: Jack Xiao <Jack.Xiao@amd.com>
>
> Implement mes ring functions and set up them.
>
> Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
> Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/mes_v10_1.c | 43 ++++++++++++++++++++++++++
>   1 file changed, 43 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
> index 4f7e345673ca..80f6812d8ecf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
> @@ -33,6 +33,47 @@ MODULE_FIRMWARE("amdgpu/navi10_mes.bin");
>   
>   #define MES_EOP_SIZE   2048
>   
> +static void mes_v10_1_ring_set_wptr(struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +
> +	if (ring->use_doorbell) {
> +		atomic64_set((atomic64_t*)&adev->wb.wb[ring->wptr_offs],
> +			     ring->wptr);

This atomic64_t type case still looks fishy to me. IIRC we agreed to not 
use them, don't we?

> +		WDOORBELL64(ring->doorbell_index, ring->wptr);
> +	} else {
> +		BUG();

Do we really need the BUG() here and below?

Christian.

> +	}
> +}
> +
> +static u64 mes_v10_1_ring_get_rptr(struct amdgpu_ring *ring)
> +{
> +	return ring->adev->wb.wb[ring->rptr_offs];
> +}
> +
> +static u64 mes_v10_1_ring_get_wptr(struct amdgpu_ring *ring)
> +{
> +	u64 wptr;
> +
> +	if (ring->use_doorbell)
> +		wptr = atomic64_read((atomic64_t *)
> +				     &ring->adev->wb.wb[ring->wptr_offs]);
> +	else
> +		BUG();
> +	return wptr;
> +}
> +
> +static const struct amdgpu_ring_funcs mes_v10_1_ring_funcs = {
> +	.type = AMDGPU_RING_TYPE_MES,
> +	.align_mask = 1,
> +	.nop = 0,
> +	.support_64bit_ptrs = true,
> +	.get_rptr = mes_v10_1_ring_get_rptr,
> +	.get_wptr = mes_v10_1_ring_get_wptr,
> +	.set_wptr = mes_v10_1_ring_set_wptr,
> +	.insert_nop = amdgpu_ring_insert_nop,
> +};
> +
>   static int mes_v10_1_add_hw_queue(struct amdgpu_mes *mes,
>   				  struct mes_add_queue_input *input)
>   {
> @@ -315,6 +356,8 @@ static int mes_v10_1_ring_init(struct amdgpu_device *adev)
>   
>   	ring = &adev->mes.ring;
>   
> +	ring->funcs = &mes_v10_1_ring_funcs;
> +
>   	ring->me = 3;
>   	ring->pipe = 0;
>   	ring->queue = 0;

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
