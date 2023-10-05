Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFF5CE9370C
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Oct 2023 12:36:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C88B10E3F7;
	Thu,  5 Oct 2023 12:36:52 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFD5710E3EC
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Oct 2023 12:36:50 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-405361bba99so8024365e9.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Oct 2023 05:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696509409; x=1697114209; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rI9wJkI+IqiEgEo5eMGn1S/QghGmhREEuVklQnQvmDQ=;
 b=GBVeVxLE3JVW9uK03Bh82eTa4DcfHrEAuB/SFG1qrUgWfe+mn2i88PeUeDxUGcNZU4
 7vD7SpGgaQi4ny6WpK0DYf2/mDx2+xWopDikYObk3f4Q2aBfya53B3G1pziCMT021diy
 1uPikN5/w09mTF0Ild/inpq7yJpTgq5a1py0qgTgYBaJVY6iyhL1kDLR0KNPjgC5lA1Z
 mcmppTxrQMYWPoDvTdo0KRQhOnUlFl2LMmGLcLJRC/P6QnpsZ8veBOT0gMQ52oudGwUH
 +1XreVe1zJw7SJjBF9MgNCVjDxXrFvLFGk1k/LiwdrpKVroC/kzKPRvlOBh35isBVsnQ
 iaRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696509409; x=1697114209;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rI9wJkI+IqiEgEo5eMGn1S/QghGmhREEuVklQnQvmDQ=;
 b=Get/71NsVmP+lBQAifru9vHcL25fPYJt6YSyCi5vzPMx1dJvCmx25p80dCWKIR6jiq
 0ZYwgiZDl8stzFoYt9Ctdoa7WRJ1vZk7l0ppSOGmgACA1LDZ0b9PGpQ0mI6Ygq8aTUoo
 Z4NGhzKFrJZt2Vnmngnr3WC/IfbNKA/YHt6h0jS2Oy7kjDCT3B6w/hKe0s+Ahh31iV7Q
 reI7RA3KFOSKkmZYJnYE0KGrKj3Xc1H35RiF4PgcJnO2RlhErOiEhWaoy02hzHAORSp6
 CHnFBAkrpNXhi0IdDAlXRVHaC6hfqfzXe+Hkd5HuAvMN32vmBszUdhGNuYVT2m13VYUi
 G6Hg==
X-Gm-Message-State: AOJu0YxRW3K39759xFCbWQ/x2KFj+gcg7XIAKkaNgOnRfxM96T2uWGsI
 nwUKmgeRtKemOJ49sTXjIBoi295VSag=
X-Google-Smtp-Source: AGHT+IFi3P8FSc4qabEtNXIH2mFmvL6kWc6cGp8NLTa8kAmtwd29B0BqHJcFRrRgYhTAn0myCzjMlA==
X-Received: by 2002:a7b:cb89:0:b0:401:b6f6:d8fd with SMTP id
 m9-20020a7bcb89000000b00401b6f6d8fdmr4970744wmi.6.1696509409120; 
 Thu, 05 Oct 2023 05:36:49 -0700 (PDT)
Received: from [10.254.108.106] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 j35-20020a05600c1c2300b003fe15ac0934sm966112wms.1.2023.10.05.05.36.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Oct 2023 05:36:48 -0700 (PDT)
Message-ID: <15caa1c4-cf3e-474d-b4f5-12f7562e1587@gmail.com>
Date: Thu, 5 Oct 2023 14:36:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] drm/amdgpu: Move package type enum to amdgpu_smuio
Content-Language: en-US
To: Lijo Lazar <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231004073941.1489693-1-lijo.lazar@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20231004073941.1489693-1-lijo.lazar@amd.com>
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
Cc: Alexander.Deucher@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 04.10.23 um 09:39 schrieb Lijo Lazar:
> Move definition of package type to amdgpu_smuio header and add new
> package types for CEM and OAM.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>
> v2: Move definition to amdgpu_smuio.h instead of amdgpu.h (Christian/Hawking)
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h   | 5 -----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_smuio.h | 7 +++++++
>   2 files changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index 42ac6d1bf9ca..7088c5015675 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -69,11 +69,6 @@ enum amdgpu_gfx_partition {
>   
>   #define NUM_XCC(x) hweight16(x)
>   
> -enum amdgpu_pkg_type {
> -	AMDGPU_PKG_TYPE_APU = 2,
> -	AMDGPU_PKG_TYPE_UNKNOWN,
> -};
> -
>   enum amdgpu_gfx_ras_mem_id_type {
>   	AMDGPU_GFX_CP_MEM = 0,
>   	AMDGPU_GFX_GCEA_MEM,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_smuio.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_smuio.h
> index 89c38d864471..5910d50ac74d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_smuio.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_smuio.h
> @@ -23,6 +23,13 @@
>   #ifndef __AMDGPU_SMUIO_H__
>   #define __AMDGPU_SMUIO_H__
>   
> +enum amdgpu_pkg_type {
> +	AMDGPU_PKG_TYPE_APU = 2,
> +	AMDGPU_PKG_TYPE_CEM = 3,
> +	AMDGPU_PKG_TYPE_OAM = 4,
> +	AMDGPU_PKG_TYPE_UNKNOWN,
> +};
> +
>   struct amdgpu_smuio_funcs {
>   	u32 (*get_rom_index_offset)(struct amdgpu_device *adev);
>   	u32 (*get_rom_data_offset)(struct amdgpu_device *adev);

