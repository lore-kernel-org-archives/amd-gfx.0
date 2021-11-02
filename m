Return-Path: <SRS0=itHt=PV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A2E7C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Nov 2021 11:10:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1220760EE9
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Nov 2021 11:10:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1220760EE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BBA86FCB7;
	Tue,  2 Nov 2021 11:10:58 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F092E6FCB7
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Nov 2021 11:10:57 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id
 c71-20020a1c9a4a000000b0032cdcc8cbafso1775910wme.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 02 Nov 2021 04:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=fzQ1q6eJBXiaNG9HE79EtM0rWSw9UtEJbL7TB2DNI48=;
 b=qaowCmL60pi1Dto6QAXbcK3Y0VeG7EHrnuJcxJfnD44wZsgNs7LV1qq87zTE5sysc5
 WB5H7uD17Y1OsobGRUyxwyMcaw3nJA3GqH3uBaysdTIbUx56pg0bmH6iDLrShtp+9PM7
 fWY5yG4znVP/R49bVLCkhLJv9mySChzN2hV/oYZWkC3z5cLmjQOhMSesvNGkF5Iq8SkJ
 nebL5vssDlksldwn4TewET+KiYe71G8mtu5h9k7oqryHhEnxHJmJ3IIxJUktAkFPISNZ
 DoH6PHh/eUEOPfuEjr80rLF4mRwgyb84LH2B+7uL0Qxv8CNCKExOb20c/g7z/yN0vXsH
 Ufdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=fzQ1q6eJBXiaNG9HE79EtM0rWSw9UtEJbL7TB2DNI48=;
 b=RHNtCzfwPOIgkZCnwz1Lu352o835DOYig/Td57ISOgprHT+7mj+90reNkqMSt8wh/0
 D6+rw96NRfV1CzlreGEZjA2vc/DsaK2g5zhkgphQTrYZsw+QLMRPN2DwUqKwYHQ9xW4H
 1aQ/ee98XJlZtT0WwAUJALrammdNMXqWJEa4hMLn7YIJ1nCrDzqty0lEZSzd0NZ0wpeZ
 eRPForXatusn90puGSUyVDAzOdWBOVFPaDzWXtC7ShKKvIbdhYqx94/xGl23WQTSSVfR
 bPjDIqNpMknLuz6dcfE2RBOxPP7fqi09ccID/qO3yXJJe12G0ya1gEvBBhqrFr2jx8+6
 cG+Q==
X-Gm-Message-State: AOAM533qdOZ7u6bbGbz8hiGepkdJxOX+ZtdV3NvfkqnCKF6qlWvP5mnU
 NeL4nV7zNAW8hAGEiEh1GYI4/UmKEKw=
X-Google-Smtp-Source: ABdhPJxPWy9GTV662iqfm77H1/mdW1uCCxefzi8T8LaOZa0CbifvyTD8egxpxxJrQGk1DHBcjODGVw==
X-Received: by 2002:a1c:9d13:: with SMTP id g19mr6121382wme.41.1635851456481; 
 Tue, 02 Nov 2021 04:10:56 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:2746:f022:81db:a2f4?
 ([2a02:908:1252:fb60:2746:f022:81db:a2f4])
 by smtp.gmail.com with ESMTPSA id a9sm13009650wrt.66.2021.11.02.04.10.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Nov 2021 04:10:56 -0700 (PDT)
Subject: Re: [PATCH] drm/amd/amdgpu: Avoid writing GMC registers under sriov
 in gmc9
To: YuBiao Wang <YuBiao.Wang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211102102500.109229-1-YuBiao.Wang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <9a5c58de-ef3d-a3ee-0f7e-393bd7d239da@gmail.com>
Date: Tue, 2 Nov 2021 12:10:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211102102500.109229-1-YuBiao.Wang@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Jack Xiao <Jack.Xiao@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 horace.chen@amd.com, Kevin Wang <Kevin1.Wang@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 Jingwen Chen <Jingwen.Chen2@amd.com>, Monk Liu <Monk.Liu@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 02.11.21 um 11:25 schrieb YuBiao Wang:
> [Why]
> For Vega10, disabling gart of gfxhub and mmhub could mess up KIQ and PSP under sriov mode, and lead to DMAR on host side.
>
> [How]
> Do not call gmc_gart_disable under sriov but keep vram_unpin to avoid
> pin_count leak.

NAK, if you want to do this you should probably avoid the write in the 
low level hardware callbacks and not here.

Christian.

>
> Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index cb82404df534..365059a20ae8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1793,14 +1793,13 @@ static void gmc_v9_0_gart_disable(struct amdgpu_device *adev)
>   {
>   	adev->gfxhub.funcs->gart_disable(adev);
>   	adev->mmhub.funcs->gart_disable(adev);
> -	amdgpu_gart_table_vram_unpin(adev);
>   }
>   
>   static int gmc_v9_0_hw_fini(void *handle)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   
> -	gmc_v9_0_gart_disable(adev);
> +	amdgpu_gart_table_vram_unpin(adev);
>   
>   	if (amdgpu_sriov_vf(adev)) {
>   		/* full access mode, so don't touch any GMC register */
> @@ -1808,6 +1807,7 @@ static int gmc_v9_0_hw_fini(void *handle)
>   		return 0;
>   	}
>   
> +	gmc_v9_0_gart_disable(adev);
>   	amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
>   	amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
>   

