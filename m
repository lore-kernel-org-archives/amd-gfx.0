Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2DB8CA5507
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Sep 2023 08:25:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5440A10E47F;
	Wed, 13 Sep 2023 08:25:54 +0000 (UTC)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E2CD10E47F
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Sep 2023 08:25:53 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-313e742a787so397618f8f.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Sep 2023 01:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694593552; x=1695198352; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DwXTnWTtSXUbbQId+gxVpa7JS1gAFAWvNd1AHN7nJE0=;
 b=UDEF+A1pHnfvE6z/FowLpbZPqdpZM7Fe9fKIzhLZX/7PDJH2pM5iiHdB0trz39QEdz
 xnz6RbbPsXlzMO5g+7mxhV9a0tbjHNBY0Ui3GPX7uPXJS0zF1GCtrOKHs8JB/1j1pzYI
 4D2RmxVh7V97ZkHmMMVtW5X70ctSjQHLD8/+y0n7jFsEo0kcVPZCpQUhb4asxozx3+R7
 n/0uX4QLhyvl2BzUi5VKLF8Z/dAryXY+jSqVNSvpSRc5eAvVhFmNAay6tdRil9KF1wu5
 VGCSdb/syr97XBqkV1ze73zSyFZedASF3eecVyEd7RkNxRGHIWLAfuguFwm9/771TAbO
 f6gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694593552; x=1695198352;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DwXTnWTtSXUbbQId+gxVpa7JS1gAFAWvNd1AHN7nJE0=;
 b=MyZ2qP8tXGMVSEl223r3AQ5yah2QeWSWtMshisp5wycut0k413ql8OCMhSTxj4Tex5
 ecIrglj6t0Rh08RWlRJKc89v5nFx125OttQX6TF8c7bXMZI8P0NhMftwANLh2UebAQvN
 NhS5uErDHj2cgGWeyKnKN6MxeNwc17RjJCvcAyQXSBAK8OVB01sMDfJj6ACQjEe/x3gL
 Io4bUmPRR9ELjQHxPfiEefSG1lOQ7EXDaNQDJy4wLVG/ntc22KsAAwVeE6hNN8jWlDvo
 ii+psiCvaYs7FtR+LhLa89RoTDW7tB512hBJdPlua5YyDgV8zRvOi5VRAMG611pli4NT
 eP1A==
X-Gm-Message-State: AOJu0Yy1nfHBoxXfnPCwA4SRNFfo0sty2QjkYJI+c+zsiAHbqrusYo6X
 bZc8u/RiQy0ik38kzAY2IpsBgqaxh55moQ==
X-Google-Smtp-Source: AGHT+IHPOks8IkXFm2SnyxZ1y2ZciaF+Mg/DvvhPv3CqrSi6/muV1TMqfacuhICQNrVMkTMeaxMbUg==
X-Received: by 2002:a05:6000:1364:b0:31c:8c5f:877e with SMTP id
 q4-20020a056000136400b0031c8c5f877emr3777749wrz.33.1694593551671; 
 Wed, 13 Sep 2023 01:25:51 -0700 (PDT)
Received: from [10.254.108.106] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 d6-20020a5d4f86000000b0031c77c010e1sm14855707wru.96.2023.09.13.01.25.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Sep 2023 01:25:51 -0700 (PDT)
Message-ID: <c13acfe2-6867-613b-ef7e-356928e84e89@gmail.com>
Date: Wed, 13 Sep 2023 10:25:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] drm/amdkfd: Insert missing TLB flush on GFX10 and later
Content-Language: en-US
To: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230911190023.193702-1-Harish.Kasiviswanathan@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230911190023.193702-1-Harish.Kasiviswanathan@amd.com>
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

Am 11.09.23 um 21:00 schrieb Harish Kasiviswanathan:
> Heavy-weight TLB flush is required after unmap on all GPUs for
> correctness and security.
>
> Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index b315311dfe2a..b9950074aee0 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -1466,8 +1466,7 @@ void kfd_flush_tlb(struct kfd_process_device *pdd, enum TLB_FLUSH_TYPE type);
>   
>   static inline bool kfd_flush_tlb_after_unmap(struct kfd_dev *dev)
>   {
> -	return KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 3) ||
> -	       KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2) ||
> +	return KFD_GC_VERSION(dev) > IP_VERSION(9, 4, 2) ||
>   	       (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 1) && dev->sdma_fw_version >= 18) ||
>   	       KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 0);
>   }

