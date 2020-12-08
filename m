Return-Path: <SRS0=uNpP=FM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9175C4167B
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 07:41:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 765B323A3C
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 07:41:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 765B323A3C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9C666E94A;
	Tue,  8 Dec 2020 07:41:08 +0000 (UTC)
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com
 [IPv6:2a00:1450:4864:20::541])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65D556E94A
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Dec 2020 07:41:07 +0000 (UTC)
Received: by mail-ed1-x541.google.com with SMTP id r5so16510852eda.12
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Dec 2020 23:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=wYWhhPHy8v7MXwBRd2oxDAprJyPn5Rn4XkFo8mivKz0=;
 b=cuaUoAZRcReOpdqfmgkGFzj9P36TNQweW9pUsft3EYwHQItrcqwVLzUEqMR8FOx1Hr
 eHO+7R3iR9eJCOOmCSbN72htSqdNfK/4VPK5tpxzfhw9uwyQtbOrtkgxYX7wUWJunms0
 kN80L14SJQCYyZsS+ZjKRxTnOVMGvK3o+JudrYqF+GlKi+BvGGf0TstxYwd4beCUPNJA
 2Ap+s67HaMlmsg2zF4yYzcNTw5CONHcpeSw5WyaA5x8DocGf2wXBIJL7fcTcnS2jDuXE
 h7xSu44MkS+fJ5nnAUbOF9PjUttRBIFjV1fdaC5naUpoQyWTZonxzGNuSlWfW9WYjXc7
 TjKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=wYWhhPHy8v7MXwBRd2oxDAprJyPn5Rn4XkFo8mivKz0=;
 b=kR6uJDgdLblCtlEZVtTfHGfc8imKF1Q7L8Qs01XSa4QnyWD/h+4iH4oo7Cj4scBOiO
 /eZcdMUYVeoo4h6YjHKCiBC3oo8ARlYei1Hv/irBV/jnoO+JSYEbviFKWsjOLeXIJ9sO
 ffQmU+wEtgPKvGFvEqcokKEdzdyhwWPEMVwjJ2bbTRDEN5Cx6j9uXAPtHE/uOzaCUSU5
 E3Z/1gFT0i01xXFcjHVmcQCpRnOmwVU9hJGH3OYLhjxVhg3Nz+fDFsdCx4yug5gN1E5h
 b9Qq31XDFudF3hNjKVKeZqel+cSY+2yoCOxNM3h7FV+8RoBBe8i/PMkJIRJa3pXAGbwQ
 hRkw==
X-Gm-Message-State: AOAM530VlxhA6K7S9Bj10LxMFCwjQ4N6Za4mgCIPSCtmTSEaGpERgFUK
 zfpcdDy7QROfK/MJvxSzJF1vEGqmshw=
X-Google-Smtp-Source: ABdhPJw0RUSqbCzo2JcAoKzmb0deN8exWtVmYrvljZ2AYNoU71gIkJf7JRx7AS1Pxnu68mQsa7j5bA==
X-Received: by 2002:a50:e715:: with SMTP id a21mr23571358edn.285.1607413265853; 
 Mon, 07 Dec 2020 23:41:05 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id b17sm14654838eju.76.2020.12.07.23.41.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Dec 2020 23:41:05 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: add the missing
 AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS flag
To: Chen Lei <chenlei18s@ict.ac.cn>, alexander.deucher@amd.com,
 christian.koenig@amd.com
References: <20201208025040.30268-1-chenlei18s@ict.ac.cn>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <a0ee3531-194c-d388-7788-69d59e7421e2@gmail.com>
Date: Tue, 8 Dec 2020 08:41:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201208025040.30268-1-chenlei18s@ict.ac.cn>
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
Cc: amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 08.12.20 um 03:50 schrieb Chen Lei:
> Add the AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS flag in amdgpu_gem_create_ioctl.
>
> Signed-off-by: Chen Lei <chenlei18s@ict.ac.cn>

NAK, that is not missing but intentionally blocked.

Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 7e8265da9..da18aeff7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -233,6 +233,7 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
>   		      AMDGPU_GEM_CREATE_NO_CPU_ACCESS |
>   		      AMDGPU_GEM_CREATE_CPU_GTT_USWC |
>   		      AMDGPU_GEM_CREATE_VRAM_CLEARED |
> +		      AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |
>   		      AMDGPU_GEM_CREATE_VM_ALWAYS_VALID |
>   		      AMDGPU_GEM_CREATE_EXPLICIT_SYNC |
>   		      AMDGPU_GEM_CREATE_ENCRYPTED))

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
