Return-Path: <SRS0=8rPh=AD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34601C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2020 18:20:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05DDE20767
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2020 18:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="acxcJHDC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05DDE20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 903376E8A5;
	Mon, 22 Jun 2020 18:20:25 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 066C16E8A5
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2020 18:20:24 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id h5so17700727wrc.7
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2020 11:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=GpCePX+LlnABHzL24StLtd/SdsQB2+fgdR7xnHIAg2M=;
 b=acxcJHDCouTWf6PC4bE3EBjw6ihwuKIIZ6IarKP6dsdLkqrbbGhxAf7g/O7CCTb0KS
 U6am+0XXur9YPzlBvdZjjzeqHnftUZpccCGfjIdV36bTCVJjSH4pKbP+Usyow243RGV+
 vKSBF8MAZwDOj7zMm+IkgPfJm0kIZxzma/dE+jLnUsSbwQMCHg4bXy2Mfpo/DjaHZ4uc
 170V7O0UUYN19MeDaycIqc6VWa8EXJt0dq1kRcJR/JNjGdhXvLLyTump+KGmTBn24w15
 UzP7SM/YsthnRexx36Ouvs0rFg2fJBJHOCdX+ZnacRBREJlcmrtJwyaN77RV+jXsy+Ud
 Bhsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=GpCePX+LlnABHzL24StLtd/SdsQB2+fgdR7xnHIAg2M=;
 b=tX5qhD4aBXmNmvTn5eLhqJJueoAeg3AIn3gyfDCOU5NHvWQP5ozwZdWSOJpgUZQmKV
 QppzBrFdo5weKvJb8MBjCLv3upsRvXrRjKIZ17B1nd+MlFcH7klCFFwUoPu3pRbSMQH7
 tBF87/aRd/d3Y3yhdKW8SNYrWFcYVPivnHjKEAj64j9vIWh1rS6Ok6R6E/DRXBmBKc06
 +tDormxTyVcFzRYRKVYXp2CKh2jszbomjsSY3f+pmr44HQF+PdglzLL3ofJO2UgZ4aKB
 GYhngS7kfnnpfW3GD5a3UeNrdfwvXRSX8ctRduCEq5ocUliPm8UCaVmnsx9MhrIA7yVf
 zDaQ==
X-Gm-Message-State: AOAM530SPQrwLgRJ6yjCh4Ak3bzXCoo1dSsRQDCd96Gn186QLBAahd2j
 TYGFV5U42GFtnd4WO/uBaVEUkete
X-Google-Smtp-Source: ABdhPJxDglSB/dpQgnTwQS7w96a7JiO3UmlzTzOdT9Z1pe5974fc8nNJg0e70kLKWcT20F8GzmxPIA==
X-Received: by 2002:adf:9205:: with SMTP id 5mr19487470wrj.232.1592850022426; 
 Mon, 22 Jun 2020 11:20:22 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id y14sm384541wma.25.2020.06.22.11.20.21
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 22 Jun 2020 11:20:21 -0700 (PDT)
Subject: Re: [PATCH 2/2] drm/amdgpu: add fw release for sdma v5_0
To: Wenhui Sheng <Wenhui.Sheng@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200618075307.3721-1-Wenhui.Sheng@amd.com>
 <20200618075307.3721-2-Wenhui.Sheng@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <72531925-ef53-b9f8-7c4c-04743340a756@gmail.com>
Date: Mon, 22 Jun 2020 20:20:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200618075307.3721-2-Wenhui.Sheng@amd.com>
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

Am 18.06.20 um 09:53 schrieb Wenhui Sheng:
> sdma v5_0 fw isn't released when module exit
>
> Signed-off-by: Wenhui Sheng <Wenhui.Sheng@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> index 58d2a80af450..6751ad69ed90 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> @@ -1299,8 +1299,12 @@ static int sdma_v5_0_sw_fini(void *handle)
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   	int i;
>   
> -	for (i = 0; i < adev->sdma.num_instances; i++)
> +	for (i = 0; i < adev->sdma.num_instances; i++) {
> +		if (adev->sdma.instance[i].fw != NULL)
> +			release_firmware(adev->sdma.instance[i].fw);

Please drop the extra NULL check here.

Kernel APIs like kfree() etc.. are usually NULL tolerant and we have 
automated scripts complaining about this as bad coding style if you 
duplicate the check in the driver.

Apart from that the series looks good to me.

Regards,
Christian.

> +
>   		amdgpu_ring_fini(&adev->sdma.instance[i].ring);
> +	}
>   
>   	return 0;
>   }

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
