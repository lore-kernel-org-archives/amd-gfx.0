Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64CA5C433FE
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Oct 2022 14:57:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D54F10E296;
	Tue,  4 Oct 2022 14:57:30 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0FB010E296
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Oct 2022 14:57:23 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id z23so12703802ejw.12
 for <amd-gfx@lists.freedesktop.org>; Tue, 04 Oct 2022 07:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date;
 bh=89bwNCU+fjo2ZlS1NQ3E5HxTCGw3UokUMa+Dk0LpcE8=;
 b=pjPpX9cpWhNKFdy+5KB6iFqa1s8aoM9PQRFYq0caaA0TvoF3EBj+XzynZcrNYxZwU/
 0Hbt3QjTxJ4MNJzAecctR60rlwGZCcNXuOnqUIY/01D4FZEJhQ0R7VAP4NK42bAvPN/5
 lZp96rC6CUCvPMiLLt1vyC2PBHxoiNe31llrKV6ly2lgqW+Wux4WuYSrI/pGAFgMA537
 lolQLRgJXF+peEi/eBbTKr3q2U9Jfty2dYGV9VQIZK7343VFqGUAPOvOLTbolEjhqhcx
 7sd4kgizAeWwkeU0W5r5UioiiWWDrQw+siI3il1L/2mEDKbmhYVr6rfFYmEk9yVNdmdz
 +hBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date;
 bh=89bwNCU+fjo2ZlS1NQ3E5HxTCGw3UokUMa+Dk0LpcE8=;
 b=ehFjhBBrUtrfgx9MMs2RIy4ifZhjGuCsVyiNQd4AryBMJ0DlnSLIROo7R1Y09ROxVU
 F9TfwRoGVjlAIVlNqOP/Gj9zCxgI2aXQZJf4hdKuW9hv1Jd9+c3MRFOVQrLEXXFMm5Wa
 jAkFRCVPAgZ0whiM3EaS9sqf1nM/38mz84e3U7UGXjQEvERugxydo2AKp1DjiyBkaxMe
 z+GcFKtdl2rzQ30IN7Y9ebrvyMjT05KFmTc+5ysiTRaNr5Fb7CGx+B/Q6VAied+vqLJu
 9x3xqU1ySsePAcC1NQmbAiWZnXYEXJkFVT5MpeVhLFS71kMbEON6BlV/WcJ5ZiaJtbZD
 +z9Q==
X-Gm-Message-State: ACrzQf0PfUdnmORL07McBolcbF+NoVmfEUGy/3kkPkWtJ2oGC4+jKTVA
 AP9yOXBbG7sMEyoTPm73yuY=
X-Google-Smtp-Source: AMsMyM60VKhbiz5fJQM6YpJEXugM6ZlkTjTvWJfPeLkYIDWK8Bn9vbKA7d2+SS5dEcVmYSlriWt3Lg==
X-Received: by 2002:a17:907:724a:b0:782:3754:ecb3 with SMTP id
 ds10-20020a170907724a00b007823754ecb3mr19966282ejc.282.1664895442336; 
 Tue, 04 Oct 2022 07:57:22 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:7a81:bed1:e9ec:231b?
 ([2a02:908:1256:79a0:7a81:bed1:e9ec:231b])
 by smtp.gmail.com with ESMTPSA id
 c11-20020a056402158b00b004545287d464sm1870782edv.14.2022.10.04.07.57.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Oct 2022 07:57:21 -0700 (PDT)
Message-ID: <e8028216-431c-6662-3520-dd84279edebe@gmail.com>
Date: Tue, 4 Oct 2022 16:57:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] Set vm_update_mode=0 as default for Sienna Cichlid in
 SRIOV case
Content-Language: en-US
To: Danijel Slivka <danijel.slivka@amd.com>, amd-gfx@lists.freedesktop.org,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>
References: <20221004140830.18308-1-danijel.slivka@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20221004140830.18308-1-danijel.slivka@amd.com>
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

Am 04.10.22 um 16:08 schrieb Danijel Slivka:
> CPU pagetable updates have issues with HDP flush as VF MMIO access
> protection is not allowing write during sriov runtime to
> mmBIF_BX_DEV0_EPF0_VF0_HDP_MEM_COHERENCY_FLUSH_CNTL

The subject should have a drm/amdgpu prefix and in general Felix need to 
take a look at this.

Regards,
Christian.

>
> Signed-off-by: Danijel Slivka <danijel.slivka@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 83b0c5d86e48..32088ac0666c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2338,7 +2338,9 @@ void amdgpu_vm_manager_init(struct amdgpu_device *adev)
>   	 */
>   #ifdef CONFIG_X86_64
>   	if (amdgpu_vm_update_mode == -1) {
> -		if (amdgpu_gmc_vram_full_visible(&adev->gmc))
> +		if (amdgpu_gmc_vram_full_visible(&adev->gmc) &&
> +		    !(adev->asic_type == CHIP_SIENNA_CICHLID &&
> +		    amdgpu_sriov_vf(adev)))
>   			adev->vm_manager.vm_update_mode =
>   				AMDGPU_VM_USE_CPU_FOR_COMPUTE;
>   		else

