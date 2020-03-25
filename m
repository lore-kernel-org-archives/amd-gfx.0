Return-Path: <SRS0=Seja=5K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03852C18E5B
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 08:28:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CBAD20663
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 08:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPZba/lI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CBAD20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31ED06E5A4;
	Wed, 25 Mar 2020 08:28:24 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E0AE6E5A4
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2020 08:28:22 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id p10so1721354wrt.6
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2020 01:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=WAAJ5RoHalv6UDJU0kzSGZwZPBIdyEXTyRTTwzJzqZU=;
 b=BPZba/lIvd/dChAz5pRsDaFFz+BocSyfagl0siwunMdmi3pAzt+MNJNSvaGCHQg4PW
 MJ73USEvd67QUIhNUWp2JaGXqsC+PDXdltE9K/wbIgd0/huXk1CA/XcY7o1a8ssSFK/p
 u65vpbuCgeivrA4YqSUWsFfgndHf8iRyw+onHMsOY5tTXouE2e4wzUc3vvw6mM/W0jie
 1okydkgnRIACBjx8Thuuz6uNKzD7l5HVfYA0CVW3xrb8fuwGbfYwISUiTx7TEosaPFXQ
 XAVZi3+UaCMN9FYIn26hCv2q+J9p713Ie6/IgzrjBswhHGLJAa4kAQ9B5OU3/skHd3Qb
 XLdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=WAAJ5RoHalv6UDJU0kzSGZwZPBIdyEXTyRTTwzJzqZU=;
 b=CdKS40KFGeZqN/BCOuf5CvwnetrQ6PhRoHPWwDHOlBlvugfkJ2gBz8oV0ZyRQvvviO
 lPa7FAzc0GK+Exm0oANLg1y9HUtHZ64oNDu6ebHFkGevAY+qXoQhPZcZnv+RevyCb3Hm
 79SuK/w8XEl19w28U3qNRu1s+Bxc8IZSma4WnPoxyfWcIZ6NY6k2pbdS5cbvY/z7R3i7
 cGEqtMob1/GMIUo0mqKMylf8PzetZRPx99gzGnWDCVYqo+DFkihmm0sn1zxEUlNTLsd3
 4z5l/D+Y+zCYKgiIfCrtxPuMPZjWZACEZjfyX9Y+Vi1DenVMnTYLqt/A8Z05MPaLW7Iv
 022w==
X-Gm-Message-State: ANhLgQ3g5KIQp2AmyedPcem/xoIOmVArFaaBDMEePxeudiOS6g7B/syo
 LAAYdXF34J4NpX/dIahvXm/1mHyY
X-Google-Smtp-Source: ADFU+vtv/pfO30NHoNATQkcNUP1Vytp/pgvBUxWGptReC9TxgXQ0BHj4eI94Sh32UpZ9i1IMJVySMw==
X-Received: by 2002:a5d:52cb:: with SMTP id r11mr2177322wrv.95.1585124900750; 
 Wed, 25 Mar 2020 01:28:20 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id k204sm8278896wma.17.2020.03.25.01.28.20
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 25 Mar 2020 01:28:20 -0700 (PDT)
Subject: Re: [PATCH 1/4] drm/amdgpu: don't try to reserve training bo for sriov
To: Monk Liu <Monk.Liu@amd.com>, amd-gfx@lists.freedesktop.org
References: <1585047533-10966-1-git-send-email-Monk.Liu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <4c59f110-0917-c9e3-7128-bd112faef7fd@gmail.com>
Date: Wed, 25 Mar 2020 09:28:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1585047533-10966-1-git-send-email-Monk.Liu@amd.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 24.03.20 um 11:58 schrieb Monk Liu:
> 1) SRIOV guest KMD doesn't care training buffer
> 2) if we resered training buffer that will overlap with IP discovery
> reservation because training buffer is at vram_size - 0x8000 and
> IP discovery is at ()vram_size - 0x10000 => vram_size -1)
>
> Signed-off-by: Monk Liu <Monk.Liu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 665db23..54cfa3a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1859,9 +1859,10 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>   	 *The reserved vram for memory training must be pinned to the specified
>   	 *place on the VRAM, so reserve it early.
>   	 */
> -	r = amdgpu_ttm_training_reserve_vram_init(adev);
> -	if (r)
> -		return r;
> +	if (!amdgpu_sriov_vf(adev))
> +		r = amdgpu_ttm_training_reserve_vram_init(adev);
> +		if (r)
> +			return r;

Missing { } here, apart from that the series looks good to me.

Christian.

>   
>   	/* allocate memory as required for VGA
>   	 * This is used for VGA emulation and pre-OS scanout buffers to

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
