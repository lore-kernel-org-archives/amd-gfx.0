Return-Path: <SRS0=Dt/2=AZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB4DC433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 08:35:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E70321835
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 08:35:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XkeUG+Zs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E70321835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBA3B6E26F;
	Tue, 14 Jul 2020 08:35:49 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DB776E26F
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 08:35:48 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id z2so20284419wrp.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 01:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=X7UzuYtGlwDEVVME5HvN9Ae3cwkIO0FeBDG7v2EoQE4=;
 b=XkeUG+ZsBdHV1CwrCkPAMgE2JWJJfyzdBO6+eM7vQZiB6Y7XKzbDDWHeruEDF5Zwzt
 5gbtV2DKpOj6gjBrUMwO7dDJzSp7Xi899ThRA3NirEEJbHOxsub4Ws0V+6arFJBiyV/O
 3XAxNU9t+ow4zrXFi7vIPxZSv+rqzpvL/aVeW8ix0ihX/AmN4wfBCxv//DFhvGeszsA8
 +wcv9xvjzu7LkipACPHySNPGSYeUzJIFN7aDL06m+gpTUa+p7JspMCAZalAkWvIFQg/q
 H5VDOFbiTdRlKeRHBs3gDNodAZjQnYLEt2wHdQMBy5Y0JFZAEWai54s63oslwYjnYKno
 AlLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=X7UzuYtGlwDEVVME5HvN9Ae3cwkIO0FeBDG7v2EoQE4=;
 b=r99iv2PjCRIZecfO5TRDE8oTXEehk662JwLvPsP/LIokphaj8jHlODnRelho6HhuAM
 uxkuuQ5IRtSNFomlKe0LFN1YOhARvVPHQKeSqsIFX0FyOujQ1JTPygLPtjzSjwecjfa6
 ofS0vZFv8Rt0C08FvFMCeHS6bVxUtHfkVBBU/xFHLtwX4fUCouSBFu5C/z3KSYSghZ+J
 ErcijP/XW8vba5PWaVYcca8L2Ytg1G2pjNBb5Ha/wHletJnJUercSd2fSAJ5r8II7H8F
 51/HXYfSsOL39sxqQR6VV6H2zpGoP16CPoano3Nw+YYF6Ee4FA4HSYcSfCGyWz02nNhe
 98iA==
X-Gm-Message-State: AOAM531ZNA+szin2d0sr4T0o3ev/eOn3VNBR5EH86l0vkNqqHRZMiPFe
 UcVFbx0/74zm8v43or6miNVITqkX
X-Google-Smtp-Source: ABdhPJykeXIck82dfrx6qB5/2DHPYgTNtShjlYcFfqjfaMn1nKL01A72XpaK2O/r0zq5//3JH9HUoQ==
X-Received: by 2002:a5d:4b0f:: with SMTP id v15mr3753466wrq.216.1594715747178; 
 Tue, 14 Jul 2020 01:35:47 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id j15sm26992519wrx.69.2020.07.14.01.35.46
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 14 Jul 2020 01:35:46 -0700 (PDT)
Subject: Re: [PATCH 4/4] drm/amdgpu: add module parameter choose reset mode
To: Wenhui Sheng <Wenhui.Sheng@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200714022911.3006-1-Wenhui.Sheng@amd.com>
 <20200714022911.3006-4-Wenhui.Sheng@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <fc1653c7-1e3e-91fe-1692-e66ce1be59c3@gmail.com>
Date: Tue, 14 Jul 2020 10:35:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200714022911.3006-4-Wenhui.Sheng@amd.com>
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
Reply-To: christian.koenig@amd.com
Cc: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 14.07.20 um 04:29 schrieb Wenhui Sheng:
> Default value is auto, doesn't change
> original reset method logic.
>
> v2: change to use parameter reset_method
> v3: add warn msg if specified mode isn't supported
>
> Signed-off-by: Likun Gao <Likun.Gao@amd.com>
> Signed-off-by: Wenhui Sheng <Wenhui.Sheng@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 8 ++++++++
>   drivers/gpu/drm/amd/amdgpu/cik.c        | 7 +++++++
>   drivers/gpu/drm/amd/amdgpu/nv.c         | 7 +++++++
>   drivers/gpu/drm/amd/amdgpu/si.c         | 5 +++++
>   drivers/gpu/drm/amd/amdgpu/soc15.c      | 8 ++++++++
>   drivers/gpu/drm/amd/amdgpu/vi.c         | 7 +++++++
>   7 files changed, 43 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 4de93cef79b9..06bfb8658dec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -196,6 +196,7 @@ static const bool debug_evictions; /* = false */
>   #endif
>   
>   extern int amdgpu_tmz;
> +extern int amdgpu_reset_method;
>   
>   #ifdef CONFIG_DRM_AMDGPU_SI
>   extern int amdgpu_si_support;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 94c83a9d4987..581d5fcac361 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -154,6 +154,7 @@ int amdgpu_mes = 0;
>   int amdgpu_noretry = 1;
>   int amdgpu_force_asic_type = -1;
>   int amdgpu_tmz = 0;
> +int amdgpu_reset_method = -1; /* auto */
>   
>   struct amdgpu_mgpu_info mgpu_info = {
>   	.mutex = __MUTEX_INITIALIZER(mgpu_info.mutex),
> @@ -793,6 +794,13 @@ module_param_named(abmlevel, amdgpu_dm_abm_level, uint, 0444);
>   MODULE_PARM_DESC(tmz, "Enable TMZ feature (-1 = auto, 0 = off (default), 1 = on)");
>   module_param_named(tmz, amdgpu_tmz, int, 0444);
>   
> +/**
> + * DOC: reset_method (int)
> + * GPU reset method (-1 = auto (default), 0 = legacy, 1 = mode0, 2 = mode1, 3 = mode2, 4 = baco)
> + */
> +MODULE_PARM_DESC(reset_method, "GPU reset method (-1 = auto (default), 0 = legacy, 1 = mode0, 2 = mode1, 3 = mode2, 4 = baco)");
> +module_param_named(reset_method, amdgpu_reset_method, int, 0444);
> +
>   static const struct pci_device_id pciidlist[] = {
>   #ifdef  CONFIG_DRM_AMDGPU_SI
>   	{0x1002, 0x6780, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_TAHITI},
> diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
> index fe306d0f73f7..310bcf81256f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/cik.c
> +++ b/drivers/gpu/drm/amd/amdgpu/cik.c
> @@ -1326,6 +1326,13 @@ cik_asic_reset_method(struct amdgpu_device *adev)
>   {
>   	bool baco_reset;
>   
> +	if (amdgpu_reset_method == AMD_RESET_METHOD_LEGACY ||
> +	    amdgpu_reset_method == AMD_RESET_METHOD_BACO)
> +		return amdgpu_reset_method;
> +	else if (amdgpu_reset_method != -1)

When you return anyway you can also drop the else here and on other 
occasions as well.

Apart from that the patch looks good to me.

We usually try to avoid adding more module parameters, but I think this 
one is really justified.

Thanks,
Christian.

> +		dev_warn(adev->dev, "Specified reset:%d isn't supported, using AUTO instead.\n",
> +				  amdgpu_reset_method);
> +
>   	switch (adev->asic_type) {
>   	case CHIP_BONAIRE:
>   	case CHIP_HAWAII:
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
> index 9f1240bd0310..486321bcab8f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -311,6 +311,13 @@ nv_asic_reset_method(struct amdgpu_device *adev)
>   {
>   	struct smu_context *smu = &adev->smu;
>   
> +	if (amdgpu_reset_method == AMD_RESET_METHOD_MODE1 ||
> +	    amdgpu_reset_method == AMD_RESET_METHOD_BACO)
> +		return amdgpu_reset_method;
> +	else if (amdgpu_reset_method != -1)
> +		dev_warn(adev->dev, "Specified reset method:%d isn't supported, using AUTO instead.\n",
> +				  amdgpu_reset_method);
> +
>   	if (smu_baco_is_support(smu))
>   		return AMD_RESET_METHOD_BACO;
>   	else
> diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
> index 9d7b4ccd17b8..1b449291f068 100644
> --- a/drivers/gpu/drm/amd/amdgpu/si.c
> +++ b/drivers/gpu/drm/amd/amdgpu/si.c
> @@ -1229,6 +1229,11 @@ static bool si_asic_supports_baco(struct amdgpu_device *adev)
>   static enum amd_reset_method
>   si_asic_reset_method(struct amdgpu_device *adev)
>   {
> +	if (amdgpu_reset_method != AMD_RESET_METHOD_LEGACY &&
> +	    amdgpu_reset_method != -1)
> +		dev_warn(adev->dev, "Specified reset method:%d isn't supported, using AUTO instead.\n",
> +				  amdgpu_reset_method);
> +
>   	return AMD_RESET_METHOD_LEGACY;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index 8c739b285915..40b343b25588 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -532,6 +532,14 @@ soc15_asic_reset_method(struct amdgpu_device *adev)
>   	bool baco_reset = false;
>   	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
>   
> +	if (amdgpu_reset_method == AMD_RESET_METHOD_MODE1 ||
> +	    amdgpu_reset_method == AMD_RESET_METHOD_MODE2 ||
> +		amdgpu_reset_method == AMD_RESET_METHOD_BACO)
> +		return amdgpu_reset_method;
> +	else if (amdgpu_reset_method != -1)
> +		dev_warn(adev->dev, "Specified reset method:%d isn't supported, using AUTO instead.\n",
> +				  amdgpu_reset_method);
> +
>   	switch (adev->asic_type) {
>   	case CHIP_RAVEN:
>   	case CHIP_RENOIR:
> diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
> index 4e5e91888d87..e4628c17802f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vi.c
> @@ -710,6 +710,13 @@ vi_asic_reset_method(struct amdgpu_device *adev)
>   {
>   	bool baco_reset;
>   
> +	if (amdgpu_reset_method == AMD_RESET_METHOD_LEGACY ||
> +	    amdgpu_reset_method == AMD_RESET_METHOD_BACO)
> +		return amdgpu_reset_method;
> +	else if (amdgpu_reset_method != -1)
> +		dev_warn(adev->dev, "Specified reset method:%d isn't supported, using AUTO instead.\n",
> +				  amdgpu_reset_method);
> +
>   	switch (adev->asic_type) {
>   	case CHIP_FIJI:
>   	case CHIP_TONGA:

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
