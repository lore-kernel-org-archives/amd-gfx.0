Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A9FEC36018
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Sep 2024 12:21:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 239B510E211;
	Tue, 17 Sep 2024 12:21:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="f+pifRlY";
	dkim-atps=neutral
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDEB610E211
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Sep 2024 12:21:11 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-378f90ad32dso1259448f8f.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Sep 2024 05:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726575670; x=1727180470; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/aS+C8ooi6jWL4a6QRLnXZQfnd+/0GWG0GnqnAoMFPE=;
 b=f+pifRlYxTAj5O1z2VdcSX9WEkoTfExLYP6E1KCNj5l3EITLq7Zla38lLBh3Dia8q8
 ZtwEQfS8CAR/oSId+jT4xwpeSTXB847fpB1phILX8m+jbmDrY3NJ6NP0unzzqhlW62T3
 XNxoKzp5VQF4mFZSuqq8IrhcmGzw1W79FmXDRrqAZ5mumwZPDho32tzk++B9uZhUaOjV
 TAXhamB18mBDAgZz/oIWwhmq5hpzwypYYwHwxsljoRJQuwScuLsmcYo+9Cqq6bpPIQmR
 OSI07RGeYqvhXGcsuApR6dIg3hy7jN/Z/rh2PtfWJdG74h/D6Kk8PkbR5m0hxsm2GVv3
 DZAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726575670; x=1727180470;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/aS+C8ooi6jWL4a6QRLnXZQfnd+/0GWG0GnqnAoMFPE=;
 b=cQycDat2Cac70xHKWC6H67qcBXgktDUezTFyTvtGuEunJ8QArSctwqEEN1DAKxy6Jo
 iaaD7C2MjLcZRbINdz+LBtp8RcGZRrnjaP/nkq+6sBnj+3M0hTGpMKlP3zXFPGUccJq4
 0e0sQ8vOrLXWWiBlX3cZ+8IM0YNaGDkN7+RWILIEjVto9HW0ADpIPP5HBGtRkUZ8KZEL
 61OAseFfCjuOMvsaGrDN4uW6Lj5gnVMMLAmg/dR6Ez6smzhotpTWQKLYyfBEa7ZP6nS3
 N9ldWEtO1Ue0lhWIkRQknZokCnqzYhdanrxjlQ0yA7qrINleqSy2lhzCfDvtL/xIINjx
 +Pew==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKM0Rg5PZ3MhDNkYCAliqs0TAa4m2ijliCth1wq86vwSjC9znCpNmzyvKtpGBKoNTs6Ln4P4Zn@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzuFdSRIaEfjKMCPw4KxC8H2TWENlHGCJ56qkJWW0QujQT4Ooq/
 dQnHlRGBvH6Qb4l8Y1lGCyUoVmlN9jlLltgr+rpHlreYpv+98hGK
X-Google-Smtp-Source: AGHT+IEpM75SFJk4l7vPHt7bf8C9WT+hMrubsncdTqsti2wkT0NWaNVUDoXKkGRJRc3Tk4dYpX+bSA==
X-Received: by 2002:a5d:48d2:0:b0:376:efb7:d19a with SMTP id
 ffacd0b85a97d-378c2d4d6e0mr9490036f8f.44.1726575669977; 
 Tue, 17 Sep 2024 05:21:09 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378e73e85ccsm9379024f8f.42.2024.09.17.05.21.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Sep 2024 05:21:09 -0700 (PDT)
Message-ID: <38063fdb-03d1-4b44-9835-105f756a0ed0@gmail.com>
Date: Tue, 17 Sep 2024 14:21:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 26/28] drm/amdgpu: fix MES GFX mask
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Arvind Yadav <Arvind.Yadav@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <Christian.Koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20240909200614.481-1-shashank.sharma@amd.com>
 <20240909200614.481-22-shashank.sharma@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240909200614.481-22-shashank.sharma@amd.com>
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

Am 09.09.24 um 22:06 schrieb Shashank Sharma:
> From: Arvind Yadav <Arvind.Yadav@amd.com>
>
> Current MES GFX mask prevents FW to enable oversubscription. This patch
> does the following:
> - Fixes the mask values and adds a description for the same
> - Removes the central mask setup and makes it IP specific, as it would
>    be different when the number of pipes and queues are different.
>
> Cc: Christian König <Christian.Koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
> Change-Id: I86f5b89c5527c23df94edc707c69c78819f4c8cf

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 3 ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 2 +-
>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 9 +++++++--
>   3 files changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index f7d5d4f08a53..dbf19122dfc3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -151,9 +151,6 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>   		adev->mes.compute_hqd_mask[i] = 0xc;
>   	}
>   
> -	for (i = 0; i < AMDGPU_MES_MAX_GFX_PIPES; i++)
> -		adev->mes.gfx_hqd_mask[i] = i ? 0 : 0xfffffffe;
> -
>   	for (i = 0; i < AMDGPU_MES_MAX_SDMA_PIPES; i++) {
>   		if (amdgpu_ip_version(adev, SDMA0_HWIP, 0) <
>   		    IP_VERSION(6, 0, 0))
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> index 96788c0f42f1..45e3508f0f8e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -109,8 +109,8 @@ struct amdgpu_mes {
>   
>   	uint32_t                        vmid_mask_gfxhub;
>   	uint32_t                        vmid_mask_mmhub;
> -	uint32_t                        compute_hqd_mask[AMDGPU_MES_MAX_COMPUTE_PIPES];
>   	uint32_t                        gfx_hqd_mask[AMDGPU_MES_MAX_GFX_PIPES];
> +	uint32_t                        compute_hqd_mask[AMDGPU_MES_MAX_COMPUTE_PIPES];
>   	uint32_t                        sdma_hqd_mask[AMDGPU_MES_MAX_SDMA_PIPES];
>   	uint32_t                        aggregated_doorbells[AMDGPU_MES_PRIORITY_NUM_LEVELS];
>   	uint32_t                        sch_ctx_offs[AMDGPU_MAX_MES_PIPES];
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index 2911c45cfbe0..d2610a664b2a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -653,8 +653,13 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
>   		mes_set_hw_res_pkt.compute_hqd_mask[i] =
>   			mes->compute_hqd_mask[i];
>   
> -	for (i = 0; i < MAX_GFX_PIPES; i++)
> -		mes_set_hw_res_pkt.gfx_hqd_mask[i] = mes->gfx_hqd_mask[i];
> +	/*
> +	 * GFX pipe 0 queue 0 is being used by kernel
> +	 * Set GFX pipe 0 queue 1 for MES scheduling
> +	 * GFX pipe 1 can't be used for MES due to HW limitation.
> +	 */
> +	mes_set_hw_res_pkt.gfx_hqd_mask[0] = 0x2;
> +	mes_set_hw_res_pkt.gfx_hqd_mask[1] = 0;
>   
>   	for (i = 0; i < MAX_SDMA_PIPES; i++)
>   		mes_set_hw_res_pkt.sdma_hqd_mask[i] = mes->sdma_hqd_mask[i];

