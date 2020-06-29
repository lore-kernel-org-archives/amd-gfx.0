Return-Path: <SRS0=Kvqq=AK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC391C433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jun 2020 12:17:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 903C623B23
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jun 2020 12:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iXVrPTaM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 903C623B23
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36FD8899A5;
	Mon, 29 Jun 2020 12:17:02 +0000 (UTC)
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com
 [IPv6:2a00:1450:4864:20::643])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34DB9899A5
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jun 2020 12:17:00 +0000 (UTC)
Received: by mail-ej1-x643.google.com with SMTP id p20so16297131ejd.13
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jun 2020 05:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=gScygd+/P3s9mPBwYeX6YR5GYzsEiqWyhe6LbOwfIys=;
 b=iXVrPTaMPOLzSS2sgRVgnQEXpQuRmkZI/YKjzJl+aKR5qj/NsEqnozBZ5bs5fb+71g
 p9D1mPPrA2K+VKwkfPplmyI7bD+bejmXJB5yLcZ4SgB9NA5L9zR1Uo6jVNJ5Lh32Gc7H
 apYjX1xp4bM10Eqi6HuxHSYhImbTSD35V4AE/ctTH0NduKUXv/QOtZxMUtyA9B7jWRQy
 YHJobBNUZUoNhMTPJJxI6GuMwdJGJ1aweoVAgHZ2KqRL1h8ZJYJjBieyBlcNfUJxfk0/
 9Hplmbcb07sAAeoxWXXYpj6AlwLU9rdNfWOKzEQtXyy30gTHy67wg+zPr0Fw4t4ehXHR
 7eug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=gScygd+/P3s9mPBwYeX6YR5GYzsEiqWyhe6LbOwfIys=;
 b=p1mOBo+SQLpArRJc8s04X6fCCa2rCEkap6c485nh70lDFA98Iu+Lwst2DzObwWTiBj
 MEY3bD5yP3BLPC7pxEBlUzUan1WefAJcUo7nrNODVjB5938VjaSMfKpzPZdIar14596A
 fC2TrDqhZMp98MCK6AqkVjSeJBZtrMAGgGMvjkbNvsv8ku1uyV1k2w/ErRVLHi0tzosn
 OJ3rYmaoAVOPxSoVpR5ZP0n2HFKXSQN/XQReZ2pv4I3GnTdUA0r3ynKkaxyeG5KX4zHl
 bgfuozO8hXcag8RVjRJGYLnPnbVPy8dGPlt95+PAvUazSsf/qD5a7J8zZmESJTrsLppc
 Qw3g==
X-Gm-Message-State: AOAM533YiDtZ+w0Cpf2SVaPHCCuZUGzYiJDUm2FECEsRTTSW+13L2Ran
 8QkEMFWXtXbNWYPBkaWUbxIfCPXr
X-Google-Smtp-Source: ABdhPJwdH/eYL3Cnb0csr8VAoj5yMBSDq2kV1MQ6EOGQDWVfRfP3N3ikbPGClWine2PCACAMn1llbA==
X-Received: by 2002:a17:906:ecb3:: with SMTP id
 qh19mr1933568ejb.273.1593433018445; 
 Mon, 29 Jun 2020 05:16:58 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id o8sm16091791ejj.102.2020.06.29.05.16.57
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Jun 2020 05:16:57 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: Fix compile warning in amdgpu_fru_read_eeprom
To: Kent Russell <kent.russell@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200629121313.18064-1-kent.russell@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <ade43f8c-6ea1-ea69-d173-323e1d1f1867@gmail.com>
Date: Mon, 29 Jun 2020 14:16:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200629121313.18064-1-kent.russell@amd.com>
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

Am 29.06.20 um 14:13 schrieb Kent Russell:
> This fixes the missing-prototypes warning for the amdgpu_fru_read_eeprom
> function. Since we declare it in the header, we can make it un-static

Well is it used in different files? Otherwise we might just have unused 
code in the module which can potentially raise a warning as well.

Christian.

>
> Signed-off-by: Kent Russell <kent.russell@amd.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Change-Id: I2b9419365cb8b38bcfb6582df53b96c83861d6cf
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c | 2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.h | 2 ++
>   2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> index e811fecc540f..68ed16e4d8be 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> @@ -48,7 +48,7 @@ static bool is_fru_eeprom_supported(struct amdgpu_device *adev)
>   	return false;
>   }
>   
> -static int amdgpu_fru_read_eeprom(struct amdgpu_device *adev, uint32_t addrptr,
> +int amdgpu_fru_read_eeprom(struct amdgpu_device *adev, uint32_t addrptr,
>   			   unsigned char *buff)
>   {
>   	int ret, size;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.h
> index f29a8611d69b..f4024f1d66c9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.h
> @@ -24,6 +24,8 @@
>   #ifndef __AMDGPU_FRU_EEPROM_H__
>   #define __AMDGPU_FRU_EEPROM_H__
>   
> +int amdgpu_fru_read_eeprom(struct amdgpu_device *adev, uint32_t addrptr,
> +                           unsigned char *buff);
>   int amdgpu_fru_get_product_info(struct amdgpu_device *adev);
>   
>   #endif  // __AMDGPU_PRODINFO_H__

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
