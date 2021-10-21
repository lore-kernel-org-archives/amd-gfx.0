Return-Path: <SRS0=oZ58=PJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6169AC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 09:04:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F6CC610CB
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 09:04:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1F6CC610CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A91146EA1B;
	Thu, 21 Oct 2021 09:04:41 +0000 (UTC)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 085966EA1B
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Oct 2021 09:04:41 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id i12so963471wrb.7
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Oct 2021 02:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=JWVBgV17tUCLvjTkBfZji0Am2uqzsT10vAGtfUwmxAI=;
 b=ChdilX/C/WgBFTzYR6eCMieYIOc9VEjpEXc7xQomu6JBO9z5PkUiUUt4EQAN4vTs4E
 4jzB/QCelx53Y1SAhGdjpBiCRHE3qVhhNVz8/rQ+dJTcHmQciCUTX+06EaHu2i4eVqmK
 P49O+cnaZiz5qEwF2wscyYolfnFa7Bj97zqN2biORPy5nGJTU+00RYTB8szNuKzlZsVw
 NBm3F0pmh1ScJs5ngxbhmY4eWqUbvdW27I7sdtFOmWbPuQUEyirey9Nr51SVIGSbLF66
 KYqibO/hWhLVgvGSPRHgwi2wwHmYhaJQDO9lW61+mfASwhqblfphOixQzXLpSAfIRSSY
 uooA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=JWVBgV17tUCLvjTkBfZji0Am2uqzsT10vAGtfUwmxAI=;
 b=lWnpSqJ6SFHNS6mj3BuS09jaq1xaVjXgu510F3x03PinNkGK5lyjmlA009nyncOwQM
 Wy26/HIHpE1qan90+vB00YRMqVGNvvZ4cNxXJjNMpNHd2kp1gxgmhEc2i3GsDqrXycVg
 fZ0Jy67egKRVF4g94nYLbv/qX9ylU6gyFGSoe2HUa6LOivvnEaPqOS7MdhqU2FBKdjBB
 U9ksm0DEs7fmZLId+d0O8SCaYcOfDoaP/i+bNbQighHU0GHQZNMDoqqOXCSGGQ0n0hCu
 vKnOkQA5dHuwZhWg/jRZoJgN4B08/gfMWpO/1ne9fhYYUgwHVy+73QvTyycWgg41FlY+
 99RA==
X-Gm-Message-State: AOAM5331CJz8FC9lyI69RSw/OB39y3VGN0BqAArZqfK/VKHnDe6O7wqd
 TbJs2oeokxairMpqFhnR4og=
X-Google-Smtp-Source: ABdhPJwP+iDRw/v/oIufLwn2Si1SybLASmDnUiYzqJ44T2ytLwerXLiAuFl8f/WwrSy2LVS9UJ4X2Q==
X-Received: by 2002:adf:bb12:: with SMTP id r18mr5653246wrg.313.1634807079453; 
 Thu, 21 Oct 2021 02:04:39 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:46a4:dec3:9292:691a?
 ([2a02:908:1252:fb60:46a4:dec3:9292:691a])
 by smtp.gmail.com with ESMTPSA id m11sm1836458wrz.52.2021.10.21.02.04.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Oct 2021 02:04:38 -0700 (PDT)
Subject: Re: [PATCH] drm/amd/amdgpu: add dummy_page_addr to sriov msg
To: Jingwen Chen <Jingwen.Chen2@amd.com>, amd-gfx@lists.freedesktop.org
Cc: monk.liu@amd.com, horace.chen@amd.com
References: <20211021085022.1130505-1-Jingwen.Chen2@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <7440041f-c4c7-8eb8-b0ba-36c916a5b5e4@gmail.com>
Date: Thu, 21 Oct 2021 11:04:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211021085022.1130505-1-Jingwen.Chen2@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 21.10.21 um 10:50 schrieb Jingwen Chen:
> Add dummy_page_addr to sriov msg for host driver to set
> GCVM_L2_PROTECTION_DEFAULT_ADDR* registers correctly.
>
> Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c    | 1 +
>   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h | 4 +++-
>   2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index 88c4177b708a..99c149397aae 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -584,6 +584,7 @@ static int amdgpu_virt_write_vf2pf_data(struct amdgpu_device *adev)
>   	vf2pf_info->encode_usage = 0;
>   	vf2pf_info->decode_usage = 0;
>   
> +	vf2pf_info->dummy_page_addr = (uint64_t)adev->dummy_page_addr;
>   	vf2pf_info->checksum =
>   		amd_sriov_msg_checksum(
>   		vf2pf_info, vf2pf_info->header.size, 0, 0);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> index 995899191288..5e3d8ecfa968 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> @@ -206,8 +206,10 @@ struct amd_sriov_msg_pf2vf_info {
>   	struct amd_sriov_msg_uuid_info uuid_info;
>   	/* pcie atomic Ops info */
>   	uint32_t pcie_atomic_ops_enabled_flags;
> +	/* dummy page addr */
> +	uint64_t dummy_page_addr;
>   	/* reserved */
> -	uint32_t reserved[256 - 48];
> +	uint32_t reserved[256 - 50];
>   };
>   
>   struct amd_sriov_msg_vf2pf_info_header {

