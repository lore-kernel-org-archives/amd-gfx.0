Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F0FDC54798
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Mar 2024 08:54:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0F2C10E0AE;
	Tue,  5 Mar 2024 08:54:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Xddzz+Ca";
	dkim-atps=neutral
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 671A810E0AE
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Mar 2024 08:54:26 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-33dcd8dec88so3437678f8f.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 05 Mar 2024 00:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709628864; x=1710233664; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iWmgoQUZq7vvsT8uZQ1KRY5ZgiQoPQLrEdyK6C8HiAI=;
 b=Xddzz+CaunOr3f1ps29WYy9DmgXCYW/iofU7/6CtePSZi4E1Yt4diwMdwOEhgyFjID
 BOc32J7jHX1vdH770xbpPk/nX81EH0hLWwXKUpvQXRVz1isVbw7n2k5IiEQYf9hmycXY
 Q+7rMZQPbumRixMx4rcBej2312efsiuqKDRpEYHzsg8X22TgNBojOk0ClCUBToK8ajf6
 3a53jbPUgnOVY7TwZAToFUGFY37ZJSOXIlbjqlQGZuFvZ/L2EPHokrPAmyBDY3p2aIPL
 QfLVwR41b3AZzqO1s2XLI3WiPDjwMk//BnS9B98U17CaochpDfi1xewmJ7UwG/A5DxOS
 8njQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709628864; x=1710233664;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iWmgoQUZq7vvsT8uZQ1KRY5ZgiQoPQLrEdyK6C8HiAI=;
 b=I4UjbPwkWRZp9y45W8nereTsECnc9kDJd4B0sWbQkENOzW5R8JCyrrIxmUtI6FeewT
 N63+usGXZFqdn3NKcea0RGI+rBryD2DEVFVHZMVF/7bgeoGCemjo/CbqqtuWXvKyLy1o
 kUlSpqejslpUmu91ZkNRrhP+VdnyUy6CXbeSAGlg2zsD682dP17157B+qAiA1woZqMjV
 RTPYe0mPew+wZuuyM5oDGKPqPdme2bBIbn9EPeEDZvLs3e82judluwmtYti8+6w4506a
 WItmV+H/f5gg0L57dDNY8WF4SbfAdCb4uPXZWhrQdh7PHZgRkOhGqvO2VD23ULVI5Zfh
 nagA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVApm229ZZcMljCrlJX6EeTsUwZU2ceGrlWYm8mNMxAY5s+Rt6Av/KjH7rUGjZdT02p9j9pWi1/GBKmf6BqpDgxC+Kt7J3O6Dz+dNGU3w==
X-Gm-Message-State: AOJu0YyOGd3HAoimWmygh5rHt63N1tBK8pM+ZpM1m4AXVwMOjTJ/HwNv
 ASMKUAk1DjgxheeEvoA1dP27dZ8wionOejYIIY1vYEuCHpaXfsiWG0SM1x5ioTU=
X-Google-Smtp-Source: AGHT+IGWLjArE8MuHU2etXGp8cWae/mn0KP3Y0kED7PYKwQ5hNwEcgxUOosFiYFbdui9CTFXI4ZNJg==
X-Received: by 2002:a5d:6b05:0:b0:33d:6984:3f87 with SMTP id
 v5-20020a5d6b05000000b0033d69843f87mr10845688wrw.8.1709628864216; 
 Tue, 05 Mar 2024 00:54:24 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 r12-20020adfe68c000000b0033df5710fabsm14327881wrm.44.2024.03.05.00.54.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Mar 2024 00:54:23 -0800 (PST)
Message-ID: <6d178a2f-c404-422f-b5ee-1a138f8826e9@gmail.com>
Date: Tue, 5 Mar 2024 09:54:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: Use offsets local to VCN in VF
Content-Language: en-US
To: Lijo Lazar <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com, samir.dhume@amd.com,
 leo.liu@amd.com
References: <20240305064031.548905-1-lijo.lazar@amd.com>
 <20240305064031.548905-2-lijo.lazar@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240305064031.548905-2-lijo.lazar@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 05.03.24 um 07:40 schrieb Lijo Lazar:
> For VCN 4.0.3, use only the local addressing scheme while in VF
> mode. This includes addressing scheme used for HUB offsets.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 20 +++++++++++++++++++-
>   1 file changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> index 7b5ad13b618e..a27f3f260aab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -1381,6 +1381,24 @@ static uint64_t vcn_v4_0_3_unified_ring_get_wptr(struct amdgpu_ring *ring)
>   				    regUVD_RB_WPTR);
>   }
>   
> +static void vcn_v4_0_3_enc_ring_emit_vm_flush(struct amdgpu_ring *ring,
> +				unsigned int vmid, uint64_t pd_addr)
> +{
> +	struct amdgpu_vmhub *hub;
> +
> +	/* For VF, only local offsets should be used */
> +	if (amdgpu_sriov_vf(ring->adev))
> +		ring->vm_hub = AMDGPU_MMHUB0(0);

That is clearly a no-go since the vm_hub must be statically and can't be 
changed here.

Regards,
Christian.

> +	hub = &ring->adev->vmhub[ring->vm_hub];
> +
> +	pd_addr = amdgpu_gmc_emit_flush_gpu_tlb(ring, vmid, pd_addr);
> +
> +	/* wait for reg writes */
> +	vcn_v2_0_enc_ring_emit_reg_wait(ring, hub->ctx0_ptb_addr_lo32 +
> +					vmid * hub->ctx_addr_distance,
> +					lower_32_bits(pd_addr), 0xffffffff);
> +}
> +
>   static void vcn_v4_0_3_ring_emit_hdp_flush(struct amdgpu_ring *ring)
>   {
>   	/* VCN engine access for HDP flush doesn't work when RRMT is enabled.
> @@ -1443,7 +1461,7 @@ static const struct amdgpu_ring_funcs vcn_v4_0_3_unified_ring_vm_funcs = {
>   	.emit_ib_size = 5, /* vcn_v2_0_enc_ring_emit_ib */
>   	.emit_ib = vcn_v2_0_enc_ring_emit_ib,
>   	.emit_fence = vcn_v2_0_enc_ring_emit_fence,
> -	.emit_vm_flush = vcn_v2_0_enc_ring_emit_vm_flush,
> +	.emit_vm_flush = vcn_v4_0_3_enc_ring_emit_vm_flush,
>   	.emit_hdp_flush = vcn_v4_0_3_ring_emit_hdp_flush,
>   	.test_ring = amdgpu_vcn_enc_ring_test_ring,
>   	.test_ib = amdgpu_vcn_unified_ring_test_ib,

