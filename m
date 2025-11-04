Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B91E5CCFA07
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Nov 2025 15:45:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DDF310E635;
	Tue,  4 Nov 2025 15:45:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="Ob3nF446";
	dkim-atps=neutral
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEEB910E634
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Nov 2025 15:45:44 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-429b895458cso3826843f8f.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 04 Nov 2025 07:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1762271143; x=1762875943; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Kz0hZBc3/xaNhkLSfrIHZyC0hOGqT/ceaujJ7HQsHCI=;
 b=Ob3nF446ANDiN0UyXj47ywLnh3wxE3W/i+RGYJe0yjKQB29kY0TKqLGelZC4NCxijL
 GosoX51KF7Vy4h26CDYgFaH7Jp/KFqU6b9liZvtcLXM1OyrMa6e/Qv/oo10QHyM/B1uI
 +XDW3Nkt0b4lbKzs8cNHymXEdX4GvHUOWQuzb23Rk2IV4xBwpv0/XJ8MHp7W2VHQJsjY
 WQzhCZUtP+wPnwV21XcYZTvJD0rYgHVlg5kD2A/pAPJuCEJHrff/I6VGbG7X3JjMGn4W
 r7thfoJfFsK8chIOqBOUI9cbllciu39W1rbXxe+mEZ5bgAmy2ulgLuaXrc7/DSJZuB4s
 GBXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762271143; x=1762875943;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Kz0hZBc3/xaNhkLSfrIHZyC0hOGqT/ceaujJ7HQsHCI=;
 b=PDNwcrhNLZrJxxFolPHhBd5b4bPcMDPAEgd3hIPtRrJNxGtKeXjBK8z5d4rotHDB2l
 lvXBIPxfuclwfOlyukghB3Jglzaguz4S5PlLPjUVNlspT6YN0lZ4v2bU4RZDoRLc0VxX
 QdVFS9Pi+uWWMdWhNzNbUBPonfeepwHY4bAI/8ivKx8nZ+xt+g0hmoAfKRvjUHaqUP4Q
 moCtoZVQia8v+ndSn6XdkvLnEhMbxOY0MzoK57L+TT4tx4ahg1VK+dSibiNSwbX/8uWM
 2ScIwJa4IFK1GByoY15nRR1w27Ocs352dLugIDqmcsPvCEjstXQDXnupYGA95fgkoNwG
 MzsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzDXshKA1F07CFUOrfOfTOrIlL5i05n7SzPH7/vKLOlScD4V08E6lMjizHSUVm6CowaSddS8rt@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzCPYsN3FzqhXzLHMDgOM69KxKqmkS7x232m3rPYGsqIfw4Vu6T
 rZspXB4+qxTbMAZ/HaBxQkPgdpcCCCZKEjH08n1AGwXaovFTOkZxM8eCpU5HLImfc2E=
X-Gm-Gg: ASbGncsn1IDxqC3Vqw+PnsRhctGR9SHR8MAscSXm1gWgnelYbtTy9oROceqzXmlsfY1
 s4rwZjFuNa/CLcwMYq3IxbSBYMCa46NMTjRFV4dlK8JcAd/hWGto/JvsAnl6vjeUaWX4ppZWb43
 IWtYHcUNKazLHzTeINcv+b+nRQ7hN2c9GvfpzIEUQ68Eh5lxbhDUjg9fEmJrqhUhax/Cczkbe89
 qSKD4ncpmniF6tXbfgHeQY95kRJbjkDOsvMCWMD2DsikQLK6tWDtSZehZ/A/6G7rDcJQ1XWRqWK
 lI2lRuIh9YOC362035Hwp2UN3BdIiIWuOHb5j5G0vgSjbVqYYG5Y8mvI+kN9iBrHOWcgZOPuf20
 BNn7gmbKGd+nqEEcEEk0kcXFsu/XcWtaahLNslSSblvdEpRTd2tvqWG1c3i834xQiH3inF330cZ
 XZa9HP1Hc2UYCZB640
X-Google-Smtp-Source: AGHT+IEgq6iVAzz+YRuiS0ch5RS+BCQ7T4ZAOlkIya7vFL/1/F/3paJM0L+BsFB3BLOm707Nrfj+Yw==
X-Received: by 2002:a05:6000:24c2:b0:427:167:c2ce with SMTP id
 ffacd0b85a97d-429bd6a607cmr14812430f8f.42.1762271143135; 
 Tue, 04 Nov 2025 07:45:43 -0800 (PST)
Received: from [192.168.0.101] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429dc1f5c72sm5521990f8f.26.2025.11.04.07.45.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Nov 2025 07:45:42 -0800 (PST)
Message-ID: <d3c9ca86-68d7-440f-98de-80fa1fcdea42@ursulin.net>
Date: Tue, 4 Nov 2025 15:45:41 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/20] drm/amdgpu: independence for the
 amdgpu_vm_tlb_fence!
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 phasta@mailbox.org, alexdeucher@gmail.com, simona.vetter@ffwll.ch,
 airlied@gmail.com, felix.kuehling@amd.com, matthew.brost@intel.com
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
References: <20251031134442.113648-1-christian.koenig@amd.com>
 <20251031134442.113648-15-christian.koenig@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20251031134442.113648-15-christian.koenig@amd.com>
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


On 31/10/2025 13:16, Christian König wrote:
> This should allow amdgpu_vm_tlb_fences to outlive the amdgpu module.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
> index 5d26797356a3..27bf1f569830 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
> @@ -33,7 +33,6 @@ struct amdgpu_tlb_fence {
>   	struct amdgpu_device	*adev;
>   	struct dma_fence	*dependency;
>   	struct work_struct	work;
> -	spinlock_t		lock;
>   	uint16_t		pasid;
>   
>   };
> @@ -98,9 +97,8 @@ void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev, struct amdgpu_vm *vm
>   	f->dependency = *fence;
>   	f->pasid = vm->pasid;
>   	INIT_WORK(&f->work, amdgpu_tlb_fence_work);
> -	spin_lock_init(&f->lock);
>   
> -	dma_fence_init64(&f->base, &amdgpu_tlb_fence_ops, &f->lock,
> +	dma_fence_init64(&f->base, &amdgpu_tlb_fence_ops, NULL,
>   			 vm->tlb_fence_context, atomic64_read(&vm->tlb_seq));
>   
>   	/* TODO: We probably need a separate wq here */

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko

