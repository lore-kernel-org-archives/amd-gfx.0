Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B4B0EB64DA
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jun 2023 12:55:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87D7710E620;
	Fri, 16 Jun 2023 12:55:36 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D81710E621
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jun 2023 12:55:35 +0000 (UTC)
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-986bfdfe8d4so22075266b.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jun 2023 05:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686920133; x=1689512133;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2+oaBIK2LF4p170HeT28XZaKtZGrxpWgqFm5igejLSk=;
 b=su2zY1LAiIwX3sFJUhe3T1HAXYNIbO+v7/iM6ZNDrUAHA04DQSVZZub+JGXPDnOrja
 GWE2f8Nf22zDDZZq+ICrQq6sbcaAFoC4tHICUI/rZGgGNfvCoRnOpwzWarYk3XEAsV6C
 HixSX0ujIn6zXlVJNYdFDxZEIoAYiwVJPA+n8SaNLyMpmLtab3Omb+wzajkU26bWMOZi
 jAcZExziTjTdXZ9kj5emXaH62hnsgfOSop2ovb3ZJklWFQchzWrztNkmNkqyf2pF32uR
 fMNEG03rQXUhVpgqPunkzUbfKR6S76F7hl/4duLZImJUC+2p88RMMNmeZ/SNCsnyrvjK
 JDyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686920133; x=1689512133;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2+oaBIK2LF4p170HeT28XZaKtZGrxpWgqFm5igejLSk=;
 b=jNnbmZo1JzP48rEhShnSujqKGStscJP7DQPnIh1yA9KF47kVt1vbJmLSHdT1zCf1+f
 /slWu33VTl/Wuu/F2ElyvtWMSKammyMhq0Tbnj9Xm6Wsr7/ztT4ItBRxvYIFdPsApGIe
 DoPEnCKXLborhxRDsNWK3vigHze+0oipQ0/zZl6nJ5aYQ1iKF15gxsW30bwmSva6yz3B
 /7Zwx2Z5bQ0VjMWTHwA7FkUDtHVzpPqAbCA7fD7qrmh4i795ap7dRAOU58yHY6FKPxzP
 n9UhV42K3dKui9KNtERnTgVq/afeRy9SaFwe2p6wgnyUlWo0sawhmSaQENBX3qlKARPG
 GFCw==
X-Gm-Message-State: AC+VfDzXkjKM5Rln8/5LjLx9/l9ywCJKJ7mU9N8FYeVvsf/EmGj+2MfV
 T9tYNpqyZcSHgUNieGBPB+Q=
X-Google-Smtp-Source: ACHHUZ6//kLJfSfYb13DuxlEl/F8twAlkdZ/OIHE9hlVt8E43TOpYOfMiLMfLYRZG5t4bEQfWrf9gA==
X-Received: by 2002:a17:907:1c85:b0:982:84a4:9f80 with SMTP id
 nb5-20020a1709071c8500b0098284a49f80mr7815459ejc.31.1686920133300; 
 Fri, 16 Jun 2023 05:55:33 -0700 (PDT)
Received: from ?IPV6:2a00:e180:151b:3a00:4ba7:36a9:cecb:189?
 ([2a00:e180:151b:3a00:4ba7:36a9:cecb:189])
 by smtp.gmail.com with ESMTPSA id
 m8-20020a1709066d0800b0098275b9e00csm3308858ejr.156.2023.06.16.05.55.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Jun 2023 05:55:32 -0700 (PDT)
Message-ID: <5d86416d-d3ec-f651-f608-5ba20a6952dd@gmail.com>
Date: Fri, 16 Jun 2023 14:55:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdgpu: fix clearing mappings for BOs that are always
 valid in VM
Content-Language: en-US
To: Samuel Pitoiset <samuel.pitoiset@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20230616062708.15913-1-samuel.pitoiset@gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230616062708.15913-1-samuel.pitoiset@gmail.com>
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
Cc: stable@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 16.06.23 um 08:27 schrieb Samuel Pitoiset:
> If the BO has been moved the PT should be updated, otherwise the VAs
> might point to invalid PT.

You might want to update this sentence a bit. Something like:

Per VM BOs must be marked as moved or otherwise their ranges are not 
updated on use which might be necessary when the replace operation 
splits mappings.

Apart from that really good catch and the patch is Reviewed-by: 
Christian König <christian.koenig@amd.com>

Regards,
Christian.

>
> This fixes random GPU hangs when replacing sparse mappings from the
> userspace, while OP_MAP/OP_UNMAP works fine because always valid BOs
> are correctly handled there.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Samuel Pitoiset <samuel.pitoiset@gmail.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 143d11afe0e5..eff73c428b12 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1771,18 +1771,30 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_device *adev,
>   
>   	/* Insert partial mapping before the range */
>   	if (!list_empty(&before->list)) {
> +		struct amdgpu_bo *bo = before->bo_va->base.bo;
> +
>   		amdgpu_vm_it_insert(before, &vm->va);
>   		if (before->flags & AMDGPU_PTE_PRT)
>   			amdgpu_vm_prt_get(adev);
> +
> +		if (bo && bo->tbo.base.resv == vm->root.bo->tbo.base.resv &&
> +		    !before->bo_va->base.moved)
> +			amdgpu_vm_bo_moved(&before->bo_va->base);
>   	} else {
>   		kfree(before);
>   	}
>   
>   	/* Insert partial mapping after the range */
>   	if (!list_empty(&after->list)) {
> +		struct amdgpu_bo *bo = after->bo_va->base.bo;
> +
>   		amdgpu_vm_it_insert(after, &vm->va);
>   		if (after->flags & AMDGPU_PTE_PRT)
>   			amdgpu_vm_prt_get(adev);
> +
> +		if (bo && bo->tbo.base.resv == vm->root.bo->tbo.base.resv &&
> +		    !after->bo_va->base.moved)
> +			amdgpu_vm_bo_moved(&after->bo_va->base);
>   	} else {
>   		kfree(after);
>   	}

