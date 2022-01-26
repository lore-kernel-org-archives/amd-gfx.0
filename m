Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7214CC2BA4C
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jan 2022 10:00:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1691B10E56D;
	Wed, 26 Jan 2022 10:00:59 +0000 (UTC)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C98510E5C3
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jan 2022 10:00:57 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id f17so24756093wrx.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jan 2022 02:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=sHzrO5QeUCWwN721kkHDna/lNCk9WOdVU+3gbmKQHU8=;
 b=hmHptA0VUKYuPPMflMXFuqyEcRwKLUuWKlAkZkdFQx1pZdxZNy/S5So46Aopygfg0i
 8zVieUNEVNlFX7H1dveUOB/uMSshPQp/3+BANuE0FESMOjGzKI+gmiVMbEiRf+z1QVny
 3PbAGvdUqPaqoxW8wv+Z5DOfEFv4qS1iH/wqrCLXa933+6YryOSTjdlO/6dDRwDdbYpG
 sNt8MJYur+XqIUl1O8GSWF2l0CN460a9QU5NpBwGNcmwMYU1fzUI83DqXChi1X2teNHz
 U8xkU7g1BOUkFImWy59YLlnHDz63ym6Cuy/AG006vvR6/QLKtSpz9/HlAKQ3MTfZs6Id
 BF8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=sHzrO5QeUCWwN721kkHDna/lNCk9WOdVU+3gbmKQHU8=;
 b=czpctlZL6KsNCBMJwSvBotMZVgLyCCdZ11OTaC7r0N7A0SRVgJfQNOpLzYUydXMsKC
 22DlS0DON7kdY0fo9E9En/3He0fi86JKbDS0XaU/eFjEKIgcak5NXl7NtRyqgG1OQEGc
 jQQc9Lb04iM6pcKmX/d3e61/Ak4VvFNZxI3Nl28PVf8e9+hF1uXMTYKfmcMYQOSCoshl
 R+TZ7PEKkoqxPrViNPnaw2uzrU2eIfDkVTrtiVs3pmwVqm0oYPmPrYiEJSR7YwzXD8lJ
 5ikKXeconPXGKxNks+yYE0FES0XnkzTHR9pQ1pHKRjFybSkrawVYjg51zqy+QhACa9WN
 uZGg==
X-Gm-Message-State: AOAM531rDMU11KylClbLjmZokhYe9BdYuytjLO8VSO2MgrgsZcCwEYH/
 9fY3ViUnXCXa8+ZzBDj4Bw0=
X-Google-Smtp-Source: ABdhPJx0wQD/MhFbXdTxnIgSZutldFwqR5DwoCUIn3Zn6Lp72wHlP6qcX/hcUOKDplu2qWSDVdBa3A==
X-Received: by 2002:a05:6000:510:: with SMTP id
 a16mr22416655wrf.605.1643191255977; 
 Wed, 26 Jan 2022 02:00:55 -0800 (PST)
Received: from ?IPV6:2a02:908:1252:fb60:6cbd:23a3:7abe:f6e2?
 ([2a02:908:1252:fb60:6cbd:23a3:7abe:f6e2])
 by smtp.gmail.com with ESMTPSA id n18sm4219876wrm.47.2022.01.26.02.00.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jan 2022 02:00:55 -0800 (PST)
Message-ID: <fd878564-3f15-ba76-83f1-42284782e7d5@gmail.com>
Date: Wed, 26 Jan 2022 11:00:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/amdgpu: add safeguards for accessing mmhub CG
 registers
Content-Language: en-US
To: Lang Yu <Lang.Yu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220126075326.1134770-1-Lang.Yu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220126075326.1134770-1-Lang.Yu@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Huang Rui <ray.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 26.01.22 um 08:53 schrieb Lang Yu:
> We observed a gpu hang when querying mmhub CG status(i.e.,
> cat amdgpu_pm_info) on cyan skillfish. Acctually, cyan
> skillfish doesn't support any CG features.
>
> Only allow asics which support CG features accessing related
> registers. Will add similar safeguards for other IPs in the
> furture.

I think you should probably add a macro or function for this check, 
apart from that looks good to me.

Christian.

>
> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c | 3 +++
>   drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c | 3 +++
>   drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c | 3 +++
>   drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c | 3 +++
>   drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c | 3 +++
>   5 files changed, 15 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
> index 4c9f0c0f3116..1869e2019461 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
> @@ -550,6 +550,9 @@ static void mmhub_v1_0_get_clockgating(struct amdgpu_device *adev, u32 *flags)
>   {
>   	int data, data1;
>   
> +	if (!(adev->cg_flags & (AMD_CG_SUPPORT_MC_MGCG | AMD_CG_SUPPORT_MC_LS)))
> +		return;
> +
>   	if (amdgpu_sriov_vf(adev))
>   		*flags = 0;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
> index 3b901f941627..f7b9843b36e6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
> @@ -546,6 +546,9 @@ static void mmhub_v1_7_get_clockgating(struct amdgpu_device *adev, u32 *flags)
>   {
>   	int data, data1;
>   
> +	if (!(adev->cg_flags & (AMD_CG_SUPPORT_MC_MGCG | AMD_CG_SUPPORT_MC_LS)))
> +		return;
> +
>   	if (amdgpu_sriov_vf(adev))
>   		*flags = 0;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
> index 3718ff610ab2..3f5f326379b7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
> @@ -686,6 +686,9 @@ static void mmhub_v2_0_get_clockgating(struct amdgpu_device *adev, u32 *flags)
>   {
>   	int data, data1;
>   
> +	if (!(adev->cg_flags & (AMD_CG_SUPPORT_MC_MGCG | AMD_CG_SUPPORT_MC_LS)))
> +		return;
> +
>   	if (amdgpu_sriov_vf(adev))
>   		*flags = 0;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
> index 9e16da28505a..b23dd9ddfb5c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
> @@ -580,6 +580,9 @@ static void mmhub_v2_3_get_clockgating(struct amdgpu_device *adev, u32 *flags)
>   {
>   	int data, data1, data2, data3;
>   
> +	if (!(adev->cg_flags & (AMD_CG_SUPPORT_MC_MGCG | AMD_CG_SUPPORT_MC_LS)))
> +		return;
> +
>   	if (amdgpu_sriov_vf(adev))
>   		*flags = 0;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
> index 619106f7d23d..a2d5c8424e2b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
> @@ -651,6 +651,9 @@ static void mmhub_v9_4_get_clockgating(struct amdgpu_device *adev, u32 *flags)
>   {
>   	int data, data1;
>   
> +	if (!(adev->cg_flags & (AMD_CG_SUPPORT_MC_MGCG | AMD_CG_SUPPORT_MC_LS)))
> +		return;
> +
>   	if (amdgpu_sriov_vf(adev))
>   		*flags = 0;
>   

