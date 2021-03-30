Return-Path: <SRS0=Oizy=I4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D684C433C1
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 07:12:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A08B61999
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 07:12:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A08B61999
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E98726E85F;
	Tue, 30 Mar 2021 07:12:55 +0000 (UTC)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB6F56E85F
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Mar 2021 07:12:54 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id x21so16952173eds.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Mar 2021 00:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=FGFj9nxtz3MdXt1H7c+9pOS+9rqgDmjPRYPBGLuznRg=;
 b=Hl45xuDORvBet/1mzMqqvQTculwpK7yXXAZzNUK92XeDNq0KKANg9wPdkJVM0RrM8Y
 VmEItq3HSkryRIMhpu6lZH76kgYZEKPiEcn1++NFIO4Z3rw8z8w0cQytgDpKMmqDmhv0
 r1BR3bO1gzE6n4vnhSD2x4htdLI9z6JfMQ/BQYduXIJHnoDNMEuawGPGdMKWkHMaTQ85
 DGjc1vWZNGVs2/lLFcWPu4pbMvfweFCXi/KtvEYgOCQ2FOfQ2UnSLjtaXmzJKjkRMPmX
 /3wsxNSkROMhRK6Xfrm0ZviMjzqy7HFHoF+RlXOUDkiq4GJ7G4NOKLI1G1l5ovIDUAX1
 JBNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=FGFj9nxtz3MdXt1H7c+9pOS+9rqgDmjPRYPBGLuznRg=;
 b=BM7Y7PWYmLGc0yxlFa4wji5ZSkkbJXdAm3IBKGwPSeZZdtlBIJQYE5fnDOH36tpBo0
 k7/TVZvbklevQVGITeKaWu9D7XAUHT/Xe8Ta33vLsO7vGzKVdvdmJrqYOHZJ0ZwvEwZJ
 h0kCHr4AU7nzFUKCW6OOU3bYG1lV/LbJDNAVhKWgYrEMohCWTQTQXCdjEthqWapHV4P8
 EBvy4Uc01voQRTXaA+ZDxg/HNuQXXM35EGN14gJ/NXsdMJdXsGaOX9YcOH9WDgbo8Bng
 6dsha0hLHEkrb2ueuvqRi0sA2uyQkm/K167SCttni0Mmh3eKqrX5SK16wEgKz0OGXe3C
 VXuw==
X-Gm-Message-State: AOAM533mWyWM4vypafQJlZNxB73QI2P6D8pURtZto0rojenmzDXAgFKp
 QYth/heHwHOBOPWZ/8SY4J4kUZLo1Jk=
X-Google-Smtp-Source: ABdhPJwSp9aWpxRI/yRgZFhDCfWFlnVtaUEYI9e611zs2QoFydOA6Hpq+EFSdSI+RcHaIxSb1qOqYw==
X-Received: by 2002:aa7:ce8a:: with SMTP id y10mr32617607edv.66.1617088373354; 
 Tue, 30 Mar 2021 00:12:53 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:8ca4:a46e:6aa7:208c?
 ([2a02:908:1252:fb60:8ca4:a46e:6aa7:208c])
 by smtp.gmail.com with ESMTPSA id d19sm10323061edr.45.2021.03.30.00.12.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Mar 2021 00:12:53 -0700 (PDT)
Subject: Re: [PATCH 5/6] drm/amdgpu: Disable RPTR write back for navi12
To: Emily Deng <Emily.Deng@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210330044147.57802-1-Emily.Deng@amd.com>
 <20210330044147.57802-5-Emily.Deng@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <4ccce70f-bd74-87ab-a280-5c45b74a7d39@gmail.com>
Date: Tue, 30 Mar 2021 09:12:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210330044147.57802-5-Emily.Deng@amd.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 30.03.21 um 06:41 schrieb Emily Deng:
> It will hit ramdomly sdma hang, and pending on utcl2
> address translation when access the RPTR polling address.
>
> According sdma firmware team mentioned, the RPTR writeback is done by
> hardware automatically, and will hit issue when clock gating occurs. So
> stop using the rptr write back for sdma5.0.
>
> Signed-off-by: Emily Deng <Emily.Deng@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 18 ++++++++++++------
>   1 file changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> index 920fc6d4a127..63e4a78181b8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> @@ -298,13 +298,19 @@ static void sdma_v5_0_ring_patch_cond_exec(struct amdgpu_ring *ring,
>    */
>   static uint64_t sdma_v5_0_ring_get_rptr(struct amdgpu_ring *ring)
>   {
> -	u64 *rptr;
> +	struct amdgpu_device *adev = ring->adev;
> +	u64 rptr;
> +	u32 lowbit, highbit;
> +
> +	lowbit = RREG32(sdma_v5_0_get_reg_offset(adev, ring->me, mmSDMA0_GFX_RB_RPTR));
> +	highbit = RREG32(sdma_v5_0_get_reg_offset(adev, ring->me, mmSDMA0_GFX_RB_RPTR_HI));

That won't work like this.

We have the readpointer writeback because we otherwise can't guarantee 
that the two 32bit values read from the registers are coherent.

In other words it can be that the hi rptr is already wrapped around 
while the lo is still the old value.

Why exactly doesn't the writeback work?

Christian.

>   
> -	/* XXX check if swapping is necessary on BE */
> -	rptr = ((u64 *)&ring->adev->wb.wb[ring->rptr_offs]);
> +	rptr = highbit;
> +	rptr = rptr << 32;
> +	rptr |= lowbit;
>   
> -	DRM_DEBUG("rptr before shift == 0x%016llx\n", *rptr);
> -	return ((*rptr) >> 2);
> +	DRM_DEBUG("rptr before shift == 0x%016llx\n", rptr);
> +	return (rptr >> 2);
>   }
>   
>   /**
> @@ -702,7 +708,7 @@ static int sdma_v5_0_gfx_resume(struct amdgpu_device *adev)
>   		WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR_ADDR_LO),
>   		       lower_32_bits(adev->wb.gpu_addr + wb_offset) & 0xFFFFFFFC);
>   
> -		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RPTR_WRITEBACK_ENABLE, 1);
> +		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RPTR_WRITEBACK_ENABLE, 0);
>   
>   		WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_BASE), ring->gpu_addr >> 8);
>   		WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_BASE_HI), ring->gpu_addr >> 40);

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
