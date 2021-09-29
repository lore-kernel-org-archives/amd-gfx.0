Return-Path: <SRS0=/upn=OT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16123C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 09:17:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D27E461139
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 09:17:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D27E461139
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 891736E198;
	Wed, 29 Sep 2021 09:17:47 +0000 (UTC)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A95116E198
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Sep 2021 09:17:46 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id k7so2963660wrd.13
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Sep 2021 02:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=b6TZ1Gdy+NsHNRYnaTEXXtScFilK6u/Y8Hfi3pXfXpI=;
 b=hfX6AeapVZFWxYcA5XEQZv3Vwclyr3nAr45rV/Q5A7wWluQfUf8EZD5lVdjesppxHI
 XBBXWpumCNCodj+Vs7KE6uvO6/t5T/kOfY8/Eebal/KWiyXDaYk/HihnVUv2Fra9uQWP
 az3kb8qfyg0S093M8kd/L6yNVP1z8wQ5gwfvDb3JkoQC8/kEtVA9UQagQshGtoDy1r3h
 sTo8N4iAqFM+UqZ77oto2nEyxvNjMemngHW64Ilx5ax9ELoQxZobs2W7P4mrnx24dPJO
 iSpFbgB7Fpvxm5/qCoc3tkIYEhSYxYM2PTuA8C5RDJKkKF/FiF771M/vywZ9pIs2t/K0
 3ghA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=b6TZ1Gdy+NsHNRYnaTEXXtScFilK6u/Y8Hfi3pXfXpI=;
 b=PswbZl5k/ICP8XwCcTkk+OQwh2Yrdkf04FzqheW4zggnWjE4eVDqIaegEh/0Y72Scv
 IeH6fnQ8OzFDULTntzSuLbx95gz3q4u1hiar3jZkcE7H/6u6dd3vPqUsWDLzkz18G12a
 +csRipiH4d5Xy9maM/FkqFjKqwGUkqm0Dys183/mlmUIAJ2iHDb3y7E4HB8tVK7ezHEd
 F8U3CeiX8bwcj3cx6ZIWglhTpVHCJ9YMTZgZn0UCXsGG0Tx0AQG/pyrPDxOCg0ilJMyr
 qAlA3Jyuk/35vrPSghGKBPbiSbCCdQMRLJxPkUavoSOnb2QpXuKfwuPmQluFhs5Om7Ik
 /Zrg==
X-Gm-Message-State: AOAM532dX61bLH4Ox5MLGL298IkMnrAJ8r08l5fEz2QLVxvxUTSNbZix
 maVTF/C1k6VrswYdDUmjcGA0c9YQoQU=
X-Google-Smtp-Source: ABdhPJxdwuYru9nCeMEj8mG1ptCLw/wjb/vMNlzO7eb8YCcdEoRnfLc8+spSYCTLtJ3P5PLOnZiyDA==
X-Received: by 2002:a5d:530a:: with SMTP id e10mr5662759wrv.277.1632907064271; 
 Wed, 29 Sep 2021 02:17:44 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:4405:6e4f:ef81:78d1?
 ([2a02:908:1252:fb60:4405:6e4f:ef81:78d1])
 by smtp.gmail.com with ESMTPSA id m29sm1656545wrb.89.2021.09.29.02.17.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Sep 2021 02:17:43 -0700 (PDT)
Subject: Re: [PATCH 50/64] drm/amdgpu: add VCN1 hardware IP
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210928164237.833132-1-alexander.deucher@amd.com>
 <20210928164237.833132-51-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <16bca756-785f-11fd-443e-57ffb47ae58e@gmail.com>
Date: Wed, 29 Sep 2021 11:17:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210928164237.833132-51-alexander.deucher@amd.com>
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

Am 28.09.21 um 18:42 schrieb Alex Deucher:
> So we can store the VCN IP revision for each instance of VCN.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 815db33190ca..b153c3740307 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -744,6 +744,7 @@ enum amd_hw_ip_block_type {
>   	UVD_HWIP,
>   	VCN_HWIP = UVD_HWIP,
>   	JPEG_HWIP = VCN_HWIP,
> +	VCN1_HWIP,
>   	VCE_HWIP,
>   	DF_HWIP,
>   	DCE_HWIP,

