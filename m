Return-Path: <SRS0=QFXE=LS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A20CFC48BDF
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Jun 2021 13:01:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64D4F61003
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Jun 2021 13:01:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64D4F61003
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4B9A6EADA;
	Thu, 24 Jun 2021 13:01:39 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E4136EADA
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Jun 2021 13:01:38 +0000 (UTC)
Received: by mail-ej1-x636.google.com with SMTP id gn32so9445128ejc.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Jun 2021 06:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=bKnihQGJPT8SQCUfJnBpGgQdFUbHtuV5QyEHuxRVi54=;
 b=NsND0aP0DThaZWoFUOm9xUHKGGvEm9XR39NEDtclO9DJ95+ntIVtldhK6tsx5j7GPd
 NpuH+yi9tfNFZzmJlGibFiKf/78BnZOYpQ2JLx+u0AlFPg8OxXooU2449zL9vge6OzCH
 xRe56M5Dk9VY6FrD6EbGmzsSkr7DOtV9aXSbgskDnTz2JX+BZMcaSJ6RJpBWhXcLp11I
 QY1W7S1eyVwIhdPnmoW49NH2ISrmnBWCMjWLN7qr1Odfuhut50PMHSChKPGit0cJY/V7
 78Cr/vzNVNW/8/Fd42Y0KQFqGbrit2U/45fa9eTvo9HwbuVzBpHlw7Yv1RNuwrusWnCF
 6TVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=bKnihQGJPT8SQCUfJnBpGgQdFUbHtuV5QyEHuxRVi54=;
 b=mre1n8olvgcMP0cvBfQ9wUifFPLy8RvyX7hjHgKGa7dEb8Yu/lxv2WzOE44Lk30uB0
 T23jlKHdk9r+G1Qxm5S0JSVR3IWVuNVrgyP/6Xgxio6myCjBmL6mwAI4/v+k8hWER6m2
 BwC8bNuhlltHqByXpqqvNGCKXfG11cK2l1vw3FY4DrIpIlHdXGzCI31DQMqGb3ju/TQz
 zhu2wdVgfHly2O4p3Q1iqAFwzF4hX5HxbosR5c2+vZcBb084QZgoYmzLaXtrOdoQ0un1
 o1i4ZGORJOy9KQ0H+H1u3Gf/Jk/kKKRbAFTqhaGNbcE2aR+ehe2Rojq8pYkA9P0GeYNS
 K/Lw==
X-Gm-Message-State: AOAM532jBWr39zKx5k6NiFvmnn9xUbmfCbZw5cB0dYjHqEwxAhxYjELA
 L0K32Sb+RvDk1rL/onRDeq4G60xeXUo=
X-Google-Smtp-Source: ABdhPJxEeGm8dJ6rhrdWtnL3lWbHk++9CJaTnakB8r39z7Pv2h2KF2TnZg6c4io8GtHrTYVSmUXCuw==
X-Received: by 2002:a17:907:7b82:: with SMTP id
 ne2mr5025803ejc.271.1624539697327; 
 Thu, 24 Jun 2021 06:01:37 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:8a1c:e700:29c4:44b6?
 ([2a02:908:1252:fb60:8a1c:e700:29c4:44b6])
 by smtp.gmail.com with ESMTPSA id s7sm1230483ejd.88.2021.06.24.06.01.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Jun 2021 06:01:36 -0700 (PDT)
Subject: Re: [PATCH v2] drm/amdgpu: Restore msix after FLR
To: Peng Ju Zhou <PengJu.Zhou@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210624053132.3458-1-PengJu.Zhou@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <a550d028-a8ae-b783-dfc7-809c3f350380@gmail.com>
Date: Thu, 24 Jun 2021 15:01:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210624053132.3458-1-PengJu.Zhou@amd.com>
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
Cc: "Emily.Deng" <Emily.Deng@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 24.06.21 um 07:31 schrieb Peng Ju Zhou:
> From: "Emily.Deng" <Emily.Deng@amd.com>
>
> After FLR, the msix will be cleared, so need to re-enable it.
>
> Signed-off-by: Emily.Deng <Emily.Deng@amd.com>
> Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> index 90f50561b43a..ba9edafd4fc6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> @@ -277,6 +277,18 @@ static bool amdgpu_msi_ok(struct amdgpu_device *adev)
>   	return true;
>   }
>   
> +void amdgpu_restore_msix(struct amdgpu_device *adev)
> +{
> +#ifdef PCI_IRQ_MSIX

Please drop that ifdef, the macro is always defined upstream.

Christian.

> +	u16 ctrl;
> +
> +	pci_read_config_word(adev->pdev, adev->pdev->msix_cap + PCI_MSIX_FLAGS, &ctrl);
> +	ctrl &= ~PCI_MSIX_FLAGS_ENABLE;
> +	pci_write_config_word(adev->pdev, adev->pdev->msix_cap + PCI_MSIX_FLAGS, ctrl);
> +	ctrl |= PCI_MSIX_FLAGS_ENABLE;
> +	pci_write_config_word(adev->pdev, adev->pdev->msix_cap + PCI_MSIX_FLAGS, ctrl);
> +#endif
> +}
>   /**
>    * amdgpu_irq_init - initialize interrupt handling
>    *
> @@ -558,6 +570,7 @@ void amdgpu_irq_gpu_reset_resume_helper(struct amdgpu_device *adev)
>   {
>   	int i, j, k;
>   
> +	amdgpu_restore_msix(adev);
>   	for (i = 0; i < AMDGPU_IRQ_CLIENTID_MAX; ++i) {
>   		if (!adev->irq.client[i].sources)
>   			continue;

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
