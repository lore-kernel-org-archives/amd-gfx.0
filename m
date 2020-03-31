Return-Path: <SRS0=uap9=5Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8078DC43331
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2020 12:54:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 571CD20848
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2020 12:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ujdYA4NG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 571CD20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22A736E2FF;
	Tue, 31 Mar 2020 12:54:13 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4D086E2FF
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2020 12:54:11 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id t7so25749818wrw.12
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2020 05:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=+/WMsa9NsgUVBMM7lVOXMFOI1EKhxgDcHybbMYgDUms=;
 b=ujdYA4NGTLiQ2Lp2igomBV5MqYM5OS5mYID87CJvPwRFAb5W/Gb7kGlz4ihQPu0sCi
 Fycv+ZEPSHWfhX0+lAoFed6KswOxJZS2pASBJV4cr+MOqNmz/QnRK/+45X0Es9LGNkTG
 iM5q3KYcJVkT9UGyn7UlC3WN2gxZ5zIFw1L2WZH/NHdp9CdZh8p587Nx4E9Apq9xlaIE
 NSV+T/a6+jKrG7KfqZjjb5ITUKzc8D64Zo1aXGvKOGPSUT6ivl3yUulghbdkJ0HEZCj2
 u65J7DVkByDpGkG8vd91ppgSXsstJC/m4r9esNK9I2/q8NV/xo4sFkH6NJkzqaaw8foz
 ZiWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=+/WMsa9NsgUVBMM7lVOXMFOI1EKhxgDcHybbMYgDUms=;
 b=MEsvrk7n2pvyvFjokEYIA8FaqzB1YvXebUM5aJnGmZlVFHcRb+BelFUjXwOHA5zXm4
 76d9Hc7x2/tGqVSFH+USX9eSGNHF5CjtU/tUcxkG+JgwEs4s8HPcyYXdrre0gPp3z0lP
 g5FEQzK5vFAPBmfcCyPuD11pAbg4bvPm+Wa3IEMnPZDsnBRJyz5+thHbDpty21BJk1Hb
 TakEPUsvK6gXYHfa3bJp5dCGuJLPj6H7pmuHeqNKNdfeD99bMoLw5jkpDhdOj1kGkZuJ
 P+ZdY48RwvYg/6nDCHjnsQJ7El/KKFxxhcHSVFM/WvSe87ZdnoevHViRiZ8S1WlabJnm
 w82g==
X-Gm-Message-State: ANhLgQ1EDBOLXEjC6dAnMzmXBNj9I3IXTQsPAqxwQz3YhUxDV6eoMRGi
 ddJ+RrTl01wdzwg5lwEAR9Ei1Ru6
X-Google-Smtp-Source: ADFU+vvjTGVGV8STJkgYQ/jJ9za7ubWhPqq8MNwPvFkOXMQU765sglyvxemCy6/PeYdsLurqEeCzKA==
X-Received: by 2002:adf:afdb:: with SMTP id y27mr20623083wrd.208.1585659250546; 
 Tue, 31 Mar 2020 05:54:10 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id b67sm3793842wmh.29.2020.03.31.05.54.09
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 31 Mar 2020 05:54:10 -0700 (PDT)
Subject: Re: [PATCH 1/2] drm/amdgpu: sync ring type with drm hw_ip type
To: Nirmoy Das <nirmoy.aiemd@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200331125448.47874-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <c6eab496-d709-9068-c233-c1811ce5d13c@gmail.com>
Date: Tue, 31 Mar 2020 14:54:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200331125448.47874-1-nirmoy.das@amd.com>
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
Cc: alexander.deucher@amd.com, ray.huang@amd.com, nirmoy.das@amd.com,
 christian.koenig@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 31.03.20 um 14:54 schrieb Nirmoy Das:
> Move AMDGPU_RING_TYPE_KIQ at the end of amdgpu_ring_type enum
> to sync amdgpu_ring_type values with AMDGPU_HW_IP_*
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 080024d21d3e..121041369c42 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -52,11 +52,11 @@ enum amdgpu_ring_type {
>   	AMDGPU_RING_TYPE_SDMA,
>   	AMDGPU_RING_TYPE_UVD,
>   	AMDGPU_RING_TYPE_VCE,
> -	AMDGPU_RING_TYPE_KIQ,
>   	AMDGPU_RING_TYPE_UVD_ENC,
>   	AMDGPU_RING_TYPE_VCN_DEC,
>   	AMDGPU_RING_TYPE_VCN_ENC,
> -	AMDGPU_RING_TYPE_VCN_JPEG
> +	AMDGPU_RING_TYPE_VCN_JPEG,
> +	AMDGPU_RING_TYPE_KIQ

That is most likely not sufficient to keep the two enums in sync since 
we are getting even more kernel internal ring types in the future.

We either need some form of static assert or your original approach of 
defining AMDGPU_RING_TYPE_SDMA = AMDGPU_HW_IP_SDMA.....

Christian.

>   };
>
>   struct amdgpu_device;
> --
> 2.25.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
