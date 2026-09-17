Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 508B7C982C1
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2026 08:03:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDFEC10E375;
	Thu, 17 Sep 2026 08:03:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="SuMhFrIa";
	dkim-atps=neutral
Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com
 [74.125.228.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90BCE10EB56
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2026 08:03:56 +0000 (UTC)
Received: by mail-ej2-f12.google.com with SMTP id
 a640c23a62f3a-c254f56039dso76166266b.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2026 01:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1789632235; x=1790237035; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+HUf6Jowh1+WPb1BCRCr6BL/tYaNnVE+FAszmKXmQss=;
 b=SuMhFrIaHK/z6DHAnhiRM1kwklVTh0dVmTLe9TvDpi/bUsqII+mM3uhEG7yFdYnQgI
 xlBLtd/0eR3I3i1sbdC89mp3+VnZ/DgS088Pxoxv80zB2Adj4wcJMd9WDG3gkAthOiag
 5z0l8JUTCU95HOqyaJR8ObWTh9UHbDhaZ7Gd9Wy+kWLYHmJ461ZFdIzPKzIgz5BotDFz
 Rt9uN67se+Cys4zAPsgd1mNT+JB+uzRNc0Bc6JDrBwPhCQs/eEPfNMZ56x5/nBb0eDjT
 CkI+kytTZg4XTKGLjIQnY+yep0/s8GHovCOknJ59KkE4dHHtOFwuxAMFiDbYf71GByXj
 DTRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789632235; x=1790237035;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+HUf6Jowh1+WPb1BCRCr6BL/tYaNnVE+FAszmKXmQss=;
 b=Gvw3D8MvSpcHviOMcL6gqy/Q3vlhEkDg13z1xOji0CSob8CFBbc4XG9fRFNzqiIPet
 eMe8+ZXz1C2o6Psl2pUM5Fw7mROU3bAYUGZDqNCrAMZr1l0F7y3YwaJbQA7vmwYvrrzb
 Czj1iIdtc9w39LU6widtazuZWKtK/nfnw2k9HXfj7pq9drs7JQzRSJLifXDzGylH86sm
 acQXl9Spr4vIB4lIgwGNpBjecpkfb2PtzTdE0W/Prp2AgzkteMczQcptG2oD3a1UH5KN
 g134c5pJ1nCH39VKZJNLU8bpZhSj6RfWWf3agM9H71jwc5XG/4azvb5L42iIk3nfRntK
 tXzA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxE7ZvyNGvZII/YdUWlSyQ2DZTyCYiDMZk+Ulad0Jf54wznxHZlGCxb1Fbdx0CSL5b7eb25McQj@lists.freedesktop.org
X-Gm-Message-State: AFuF++k3ie220YcqISTJyVvUL9pXL0bEB1h2+UA/mkEo+S2oGOIoCcXu
 ron6tiOaWozPNvLk1mM1bxPlm7us64mMT0m8diGiYF/tQZeDWp1nD2VZB3dVSYhJDgQ=
X-Gm-Gg: AYBFou0WKsYcyrxRiEkOJiCxyL3H6DT2vSNPRhR1Jr/ynhT09M8coAJaG24YKWZLiA9
 uYARWISxgi1Mb8DmYaI62jD7tIlYIBrXgjMgOrCmeKkwmhYP4Hgycs4gm8mjIaaXWd/oBRWxb+j
 2Q244EjFjG9Kbnah+paJJUybgbSe00jQX/5yNSxpZGW6aSuhrHh3PYEBOmS29ti3bGWsA0wEWjG
 P7fp6OfvK13UICliCH9JiEGyF/tR8Fyc8Ny0EOiEqtYG0I87mFphLL39vQbUJMneJe8eTMLeN3T
 l+FA7jdLSVpLf+MvEIjHPvNzh2s560ET1a89fjHzsUeUq6nHYtHbr1PNkWXz+5tJFoEbHT9z5vt
 zO1B/nQzvbaoBJThMfMN5WZLCq/kF71nPPqBMCUdrlnbxbHPYoN1MxfRr9yDx7wFDdSf4hzQy/W
 E6QmpyMcMS/GwuAQttkziHNziankQcNKvEL0Lyrp9rgV8gk1THhtjL6k/cUnHuFtNdwbReGFVVF
 Qmn4vErShD1SZc=
X-Received: by 2002:a17:907:7287:b0:c26:19de:912c with SMTP id
 a640c23a62f3a-c29e530a4c5mr405765466b.31.1789632234807; 
 Thu, 17 Sep 2026 01:03:54 -0700 (PDT)
Received: from [192.168.0.116] ([81.79.79.1]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c29de5f478dsm250536966b.46.2026.09.17.01.03.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Sep 2026 01:03:53 -0700 (PDT)
Message-ID: <eecffa03-ba11-4952-a208-6d528e94bdf5@ursulin.net>
Date: Thu, 17 Sep 2026 09:03:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/gmc: Use amdgpu_gmc_handle_retry_fault() for
 GMC v12.1
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, Felix Kuehling <Felix.Kuehling@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>
References: <20260916225549.282123-1-timur.kristof@gmail.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20260916225549.282123-1-timur.kristof@gmail.com>
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



On 16/09/2026 23:55, Timur Kristóf wrote:
> Use the same helper for GMC v12.1 that is used by other
> GMC IP block versions.
> 
> No functional changes intended. Just code cleanup.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c | 45 ++++----------------------
>   1 file changed, 7 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
> index 3349e8bc1c20..cfc46f912d47 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
> @@ -131,7 +131,7 @@ static int gmc_v12_1_process_interrupt(struct amdgpu_device *adev,
>   	struct amdgpu_vmhub *hub;
>   	uint32_t cam_index = 0;
>   	const char *hub_name;
> -	int ret, xcc_id = 0;
> +	int xcc_id = 0;
>   	uint32_t status = 0, status_hi = 0;
>   	const char *die_name;
>   	char die_name_buf[32];
> @@ -164,44 +164,13 @@ static int gmc_v12_1_process_interrupt(struct amdgpu_device *adev,
>   	hub = &adev->vmhub[vmhub];
>   
>   	if (retry_fault) {
> -		if (adev->irq.retry_cam_enabled) {
> -			/* Delegate it to a different ring if the hardware hasn't
> -			 * already done it.
> -			 */
> -			if (entry->ih == &adev->irq.ih) {
> -				amdgpu_irq_delegate(adev, entry, 8);
> -				return 1;
> -			}
> -
> -			cam_index = entry->src_data[3] & 0x3ff;
> -
> -			ret = amdgpu_vm_handle_fault(adev, entry->pasid, entry->vmid, node_id,
> -							addr, entry->timestamp, write_fault);
> -			WDOORBELL32(adev->irq.retry_cam_doorbell_index, cam_index);
> -			if (ret)
> -				return 1;
> -		} else {
> -			/* Process it onyl if it's the first fault for this address */
> -			if (entry->ih != &adev->irq.ih_soft &&
> -				amdgpu_gmc_filter_faults(adev, entry->ih, addr, entry->pasid,
> -							 entry->timestamp))
> -				return 1;
> -
> -			/* Delegate it to a different ring if the hardware hasn't
> -			 * already done it.
> -			 */
> -			if (entry->ih == &adev->irq.ih) {
> -				amdgpu_irq_delegate(adev, entry, 8);
> -				return 1;
> -			}
> +		cam_index = entry->src_data[3] & 0x3ff;
>   
> -			/* Try to handle the recoverable page faults by filling page
> -			 * tables
> -			 */
> -			if (amdgpu_vm_handle_fault(adev, entry->pasid, entry->vmid, node_id,
> -						   addr, entry->timestamp, write_fault))
> -				return 1;
> -		}
> +		int ret = amdgpu_gmc_handle_retry_fault(adev, entry, addr, cam_index, node_id,
> +							write_fault);
> +		/* Returning 1 here also prevents sending the IV to the KFD */
> +		if (ret == 1)
> +			return 1;
>   	}
>   
>   	if (kgd2kfd_vmfault_fast_path(adev, entry, retry_fault))

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko
