Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97AC7C32792
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Aug 2022 09:59:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55C7EB2B9F;
	Tue, 23 Aug 2022 09:59:36 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90530B2B78
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Aug 2022 09:59:05 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id ce26so10643027ejb.11
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Aug 2022 02:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc; bh=SrmL7IQNsc6gTMJ/6MeOo9O8E7exVLgUx80xVRn4LKY=;
 b=Ew3iedJdYRvWHtBFLPEL7WbTx+gRjuDw/L8r896qdVPt9WCQ+Wt2fjPT+Zvx5cmzM9
 zdpVEjXjsCXmRIm3UFsvGdmp9h395B+YYwinqmwKZJRwovj2uMmqH+hBbJCu+7dZAsrv
 LwNohotwIlcc4fe8boViN8HeeZ+tPjyQg1BY1eY0yyW5W9EBsoBnv+A3tutoLVsXL25X
 kqCLBu83RYMMBld7FpJ7dLoqkldH9e+9DNbVQ3wcjgyqTAlzMXl4JHdjyOtH31elvcKe
 1W7gHwl09BvpP5UFoMmxRUuOxFfWx4qX/FnScC9pLoKkPh3yDY62TymhlbKrSAz96Y1i
 9b0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc;
 bh=SrmL7IQNsc6gTMJ/6MeOo9O8E7exVLgUx80xVRn4LKY=;
 b=5UtoeZZ5+6r7/ie5nQ6S6n4ggvZkDtPlvoeX74nxm44oH15hjf1fi4HMLiWh9UVGhy
 st7Be7Bas+LG/Ahbn7BMMUDxHXSZvr56JHodFBxpdzdVQAqhbyCE0ylhajWfq2HWe2y6
 iMuD1LRxuwR64spCjcE55Fb2GfI8sLTRQU236HUsUlZ00uIPVNxQYylv3IaugnUe5oDY
 NFQsIl+N6/r64ccJwo+z392FMknkujloGRTa6p213FzMdhEb8uLNEyopmqnGaUtVjjV6
 J4LvptpVCsm5thwY2gpb4hfJBCKr7Z5AZmDklcIeXJMEhYFyNfOqAOhUdcB27dKN/ifU
 JBXA==
X-Gm-Message-State: ACgBeo34VziCdF1NF1rG9p9pXdLx4CTQcIkzFwlhQ3mEWdm++as4RA64
 wrTRgATuaGPVbqmaDfzNtmloCeTHo3k=
X-Google-Smtp-Source: AA6agR4soOcHTDgcjtCtpGpFT82lKgAWprP+Whm2gCA+uPKaLD9J116+Y+rJ9e69ZpGXWdzyfGWDWQ==
X-Received: by 2002:a17:907:9606:b0:72f:826d:21b4 with SMTP id
 gb6-20020a170907960600b0072f826d21b4mr15595511ejc.510.1661248743766; 
 Tue, 23 Aug 2022 02:59:03 -0700 (PDT)
Received: from [192.168.178.21] (p4fc20ad4.dip0.t-ipconnect.de.
 [79.194.10.212]) by smtp.gmail.com with ESMTPSA id
 1-20020a170906210100b007307e7df83bsm7221948ejt.21.2022.08.23.02.59.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Aug 2022 02:59:03 -0700 (PDT)
Message-ID: <e24582c4-aa29-ac6b-d148-d5a554c066d0@gmail.com>
Date: Tue, 23 Aug 2022 11:59:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amdgpu: Fix page table setup on Arcturus
Content-Language: en-US
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220822155217.911506-1-mukul.joshi@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220822155217.911506-1-mukul.joshi@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 22.08.22 um 17:52 schrieb Mukul Joshi:
> When translate_further is enabled, page table depth needs to
> be updated. This was missing on Arcturus MMHUB init. This was
> causing address translations to fail for SDMA user-mode queues.
>
> Fixes: 2abf2573b1c69 ("drm/amdgpu: Enable translate_further to extend UTCL2 reach"
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
> index 6e0145b2b408..445cb06b9d26 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
> @@ -295,9 +295,17 @@ static void mmhub_v9_4_disable_identity_aperture(struct amdgpu_device *adev,
>   static void mmhub_v9_4_setup_vmid_config(struct amdgpu_device *adev, int hubid)
>   {
>   	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
> +	unsigned int num_level, block_size;
>   	uint32_t tmp;
>   	int i;
>   
> +	num_level = adev->vm_manager.num_level;
> +	block_size = adev->vm_manager.block_size;
> +	if (adev->gmc.translate_further)
> +		num_level -= 1;
> +	else
> +		block_size -= 9;
> +
>   	for (i = 0; i <= 14; i++) {
>   		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, mmVML2VC0_VM_CONTEXT1_CNTL,
>   				hubid * MMHUB_INSTANCE_REGISTER_OFFSET + i);
> @@ -305,7 +313,7 @@ static void mmhub_v9_4_setup_vmid_config(struct amdgpu_device *adev, int hubid)
>   				    ENABLE_CONTEXT, 1);
>   		tmp = REG_SET_FIELD(tmp, VML2VC0_VM_CONTEXT1_CNTL,
>   				    PAGE_TABLE_DEPTH,
> -				    adev->vm_manager.num_level);
> +				    num_level);
>   		tmp = REG_SET_FIELD(tmp, VML2VC0_VM_CONTEXT1_CNTL,
>   				    RANGE_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
>   		tmp = REG_SET_FIELD(tmp, VML2VC0_VM_CONTEXT1_CNTL,
> @@ -323,7 +331,7 @@ static void mmhub_v9_4_setup_vmid_config(struct amdgpu_device *adev, int hubid)
>   				    EXECUTE_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
>   		tmp = REG_SET_FIELD(tmp, VML2VC0_VM_CONTEXT1_CNTL,
>   				    PAGE_TABLE_BLOCK_SIZE,
> -				    adev->vm_manager.block_size - 9);
> +				    block_size);
>   		/* Send no-retry XNACK on fault to suppress VM fault storm. */
>   		tmp = REG_SET_FIELD(tmp, VML2VC0_VM_CONTEXT1_CNTL,
>   				    RETRY_PERMISSION_OR_INVALID_PAGE_FAULT,

