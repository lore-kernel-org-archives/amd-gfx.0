Return-Path: <SRS0=hGuQ=PP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED3FC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Oct 2021 06:11:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1FC8610A4
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Oct 2021 06:11:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A1FC8610A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1211E6E51B;
	Wed, 27 Oct 2021 06:11:15 +0000 (UTC)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB2B46E51B
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Oct 2021 06:11:13 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id g7so1064273wrb.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Oct 2021 23:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=OCIBju7xO/FWLxGz5FWdwXxrS7wvUGXoXRijCCHpGko=;
 b=iWD3BSLHiD6GxFG6clURgk+3n/eKBKxR2fUTEff+AMO/77K5RvKjV0i68OsLS7R+Wp
 t5CEkaXQOA6uI+I4nte14U5xnr8AjP4ShBT1CY/3XQ0NC4sfSZk5IYQjBzGDkNYFu4Vu
 0xLfOLkLr9fLh5QKPgDUj7c/+qeFlznbLWdxioMJyrCdI9eONNxTHa82WWsbOtsfq8zt
 0AKvWM7+F5K0tIiPCHc1jEa4q5XOuGhgLutAJjsriL5KfSZR+qnWL/w35YCdmrV4Xhe9
 rvMxtfiUphksOpXteJtQcE/d8stHrgHVDivh7cnW6XwL17OpGVnj6h9oI2koceYyl6m/
 9+hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=OCIBju7xO/FWLxGz5FWdwXxrS7wvUGXoXRijCCHpGko=;
 b=WlR78N5UFMyK+MCjgbof7QfWLYzN2Hv3PE2ortWYqqLNRIkCAYUxNW6nOXZwaFWBqW
 hkQ6bySG4I5Es83uMzmBGRM9tt4qwGgdpIn2ma1ddBXIG7er+jYftu8vXn/sum37iRKF
 ngm+KBr45a1naWZgtmN5MAAWvPg37yBT3zMhxqIacYZLfyOfNpXX+jmav3/dxJe4Jc+U
 axiFG9Kd0HObAP6hniwWM3jvjoEp8a3exaSuCs6XbJwdlUts3ZtFyH1HiT+Xqflm/pny
 0GWpjwKBJ9xoxYL1C0vGn7iY/R96vKu5EOOGntQquqrBjUGUBiCEyLzLBkoOrsaDGfwt
 iyWA==
X-Gm-Message-State: AOAM530AjxqcG7lURnzBlyvCtWPgctJggizBd6ZfoHoltDyfHrdMeLRO
 plO2MNFpexCZJb8mBbCLQD3WclmT8hk=
X-Google-Smtp-Source: ABdhPJxnfchm879XOKY+JgJVK8msXxXrRl3NAxQMYRFK2Es/fiWyOiuZzRJbG8c32QN3MdCVT8IH7A==
X-Received: by 2002:adf:f5c1:: with SMTP id k1mr15345338wrp.96.1635315072255; 
 Tue, 26 Oct 2021 23:11:12 -0700 (PDT)
Received: from [192.168.178.21] (p5b0ea1b5.dip0.t-ipconnect.de.
 [91.14.161.181])
 by smtp.gmail.com with ESMTPSA id x10sm3119107wrt.76.2021.10.26.23.11.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Oct 2021 23:11:11 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu/UAPI: rearrange header to better align related
 items
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211026144726.191916-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <381a8ffd-864b-f7ec-2c74-4192be08c5c6@gmail.com>
Date: Wed, 27 Oct 2021 08:11:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211026144726.191916-1-alexander.deucher@amd.com>
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



Am 26.10.21 um 16:47 schrieb Alex Deucher:
> Move the RAS query parameters to align with the INFO query where
> they are used.  No functional change.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   include/uapi/drm/amdgpu_drm.h | 13 ++++++-------
>   1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 0cbd1540aeac..26e45fc5eb1a 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -786,13 +786,6 @@ struct drm_amdgpu_cs_chunk_data {
>   #define AMDGPU_INFO_VRAM_LOST_COUNTER		0x1F
>   /* query ras mask of enabled features*/
>   #define AMDGPU_INFO_RAS_ENABLED_FEATURES	0x20
> -/* query video encode/decode caps */
> -#define AMDGPU_INFO_VIDEO_CAPS			0x21
> -	/* Subquery id: Decode */
> -	#define AMDGPU_INFO_VIDEO_CAPS_DECODE		0
> -	/* Subquery id: Encode */
> -	#define AMDGPU_INFO_VIDEO_CAPS_ENCODE		1
> -
>   /* RAS MASK: UMC (VRAM) */
>   #define AMDGPU_INFO_RAS_ENABLED_UMC			(1 << 0)
>   /* RAS MASK: SDMA */
> @@ -821,6 +814,12 @@ struct drm_amdgpu_cs_chunk_data {
>   #define AMDGPU_INFO_RAS_ENABLED_MP1			(1 << 12)
>   /* RAS MASK: FUSE */
>   #define AMDGPU_INFO_RAS_ENABLED_FUSE			(1 << 13)
> +/* query video encode/decode caps */
> +#define AMDGPU_INFO_VIDEO_CAPS			0x21
> +	/* Subquery id: Decode */
> +	#define AMDGPU_INFO_VIDEO_CAPS_DECODE		0
> +	/* Subquery id: Encode */
> +	#define AMDGPU_INFO_VIDEO_CAPS_ENCODE		1
>   
>   #define AMDGPU_INFO_MMR_SE_INDEX_SHIFT	0
>   #define AMDGPU_INFO_MMR_SE_INDEX_MASK	0xff

