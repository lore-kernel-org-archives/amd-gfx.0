Return-Path: <SRS0=S2wj=5F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA718C4332D
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 18:27:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0B7F20767
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 18:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TRcBt7WN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0B7F20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71BCC6EB60;
	Fri, 20 Mar 2020 18:27:49 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D2626E0DF
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2020 18:27:48 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id h4so8765296wru.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2020 11:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=SWYdA8Gs7J51OhiGl1EEANQQ2xKQWx3/7m76fwCheSs=;
 b=TRcBt7WN+Z9dyj/wH/9jCfaX5jDWfLv4WhM5W/wjyeKexkatmFV8rQssudE30FFifL
 BxxSRUXwWw8aIxzQnKSKf+aAIfuOpliLYqYAbiFwJf9toBDAQ8CnJxM4RFSWdsZh5o1e
 4xXe1dUlwyLOpHH1lwMn59oxgHUWshpiVnnzaJPlGSaDiG8b2ltBjesQFYNu13NUhwpM
 9jovB2JSVG8kcuqyBoX316r9DrRheOerYHo6u1x/60g/p5IUJ991ox1q1uO38mBKlG8C
 dZOQBK/QFsFFaNsNn5MJsjXiSun2AHhGOLkeV+qdjsf+Acwu7zQbBkLhzqKQxAj9cGDg
 vbCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=SWYdA8Gs7J51OhiGl1EEANQQ2xKQWx3/7m76fwCheSs=;
 b=pSM3wxoDh7NNuli5xm46l3ibIZMLC7Cwu7+HFKpvbzmQcCe/mqTVDte//1BYxH3HCI
 ZCEEMSTsfyrxB71tjnlH2JY5uWr+MYE34LsaxeMOywz+0RMnjmuQSAUPxGelER9pslF5
 uw/zykvhf/OpsfFBsSjTIcz1i7c/MzN/xBpc+tq/oQfRYTzaAP8Ey7nj1zk2w09dORSh
 MpgzOPJsmMQ+iKx/CcfRx/ZKlSyz55P5mY1Ljjpycf6MklrWv1J/ihFseq/9KYz0TouL
 vWj0TpBoz9rTYGHNYllpjLSSK6kmnYqu9WGOB2U2Ehwk0kywub/5OaxsG0yfLPiNzkLf
 Fb9w==
X-Gm-Message-State: ANhLgQ1L3UUxR5VopmBrAaX9uaQDEul3jPLN91MQJtQmS8mHfLzxK7gk
 FdKy1AcR7Pvu5oMuPaNdicRgGJ87
X-Google-Smtp-Source: ADFU+vt85veOUOwfTBA923ZNO+9Umz8VIAJtWLNFSUrIacJLb187DdAcwF7MEW8oo92EO5QpJgAfZA==
X-Received: by 2002:a5d:56cd:: with SMTP id m13mr12414541wrw.236.1584728866839; 
 Fri, 20 Mar 2020 11:27:46 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id d21sm9272037wrb.51.2020.03.20.11.27.45
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 20 Mar 2020 11:27:46 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: fix size validation failure in large buffer
 creation
To: Tianci Yin <tianci.yin@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200320094615.5524-1-tianci.yin@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <cb153afb-1e3c-e512-7775-ae144db9aff9@gmail.com>
Date: Fri, 20 Mar 2020 19:27:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200320094615.5524-1-tianci.yin@amd.com>
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
Cc: Feifei Xu <Feifei.Xu@amd.com>, Pauline Li <pauline.li@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>, Long Gang <Gang.Long@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 20.03.20 um 10:46 schrieb Tianci Yin:
> From: "Tianci.Yin" <tianci.yin@amd.com>
>
> [why]
> When GTT domain size is smaller than VRAM, if APP apply a very large
> buffer whose size is larger than GTT but smaller than VRAM, the size
> validation will fail.
>
> [how]
> Validate VRAM domain size at first place, then GTT domain.

NAK, this is intended behavior. VRAM allocations larger than GTT 
allocations are illegal and can crash the memory management.

Regards,
Christian.

>
> Change-Id: Ic1d31b9b0a4939e6bba0241ff79ae9aa2225ee05
> Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 84745f9e7408..bab134b6369f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -464,21 +464,21 @@ static bool amdgpu_bo_validate_size(struct amdgpu_device *adev,
>   {
>   	struct ttm_mem_type_manager *man = NULL;
>   
> -	/*
> -	 * If GTT is part of requested domains the check must succeed to
> -	 * allow fall back to GTT
> -	 */
> -	if (domain & AMDGPU_GEM_DOMAIN_GTT) {
> -		man = &adev->mman.bdev.man[TTM_PL_TT];
> +	if (domain & AMDGPU_GEM_DOMAIN_VRAM) {
> +		man = &adev->mman.bdev.man[TTM_PL_VRAM];
>   
>   		if (size < (man->size << PAGE_SHIFT))
>   			return true;
> -		else
> +		else if (!(domain & AMDGPU_GEM_DOMAIN_GTT))
>   			goto fail;
>   	}
>   
> -	if (domain & AMDGPU_GEM_DOMAIN_VRAM) {
> -		man = &adev->mman.bdev.man[TTM_PL_VRAM];
> +	/*
> +	 * If GTT is part of requested domains the check must succeed to
> +	 * allow fall back to GTT
> +	 */
> +	if (domain & AMDGPU_GEM_DOMAIN_GTT) {
> +		man = &adev->mman.bdev.man[TTM_PL_TT];
>   
>   		if (size < (man->size << PAGE_SHIFT))
>   			return true;

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
