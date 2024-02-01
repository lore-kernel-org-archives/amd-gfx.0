Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 562E4C4828D
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Feb 2024 14:01:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E40DF10EDF9;
	Thu,  1 Feb 2024 14:01:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KiNVTDm9";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC0F410EDFA
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Feb 2024 14:01:35 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-3392b045e0aso482788f8f.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 01 Feb 2024 06:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706796094; x=1707400894; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6ZLqgVwSelq37BUp4ErOCd0BgDVgpawiYXc4dDhRtUk=;
 b=KiNVTDm9sFSiCUdYfUZeNvw9ddP46nHJ9u06d+srCE0Ktb/ED17g1mu9VfT4TCD2vS
 HnZTDUZGQrLkTQL+Rd7j5GyP5mjE2uxcM+cWsDSjWlqfQ5BW+ez/d09xVHa1jqRcZmli
 YbTwpPRFfyd/d7rMNNwhzwf5kjkx61G+vE0HPAAMSBe5NxiiqtOt84c2Z3fIjhvQmjVb
 DfankT86S3MMZxTS/mLLF6eB+fvH+4HfH2TaaVG5tWNHrC36vf6OAqY+hetu/n403IM0
 IOMB14Q9QwsKBmhzmPEK1Z+Ua+A0o89ED1AONGSR2AvorNvS8PZKH+2+Di1HdqwaMhDV
 4iIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706796094; x=1707400894;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6ZLqgVwSelq37BUp4ErOCd0BgDVgpawiYXc4dDhRtUk=;
 b=R9yfjhmbhTrZ72J4GvK3zgRgwc76dx6qCMrPZmBKdlmnU+ow2CJSNdcpXgW/LqRR22
 s7hqKp+MaRmEx4x4P/2ay2FdmjVrsGG3gWgyzteacgTk/Yr/Ls5UAii8krlI0IrpgOet
 1I8+fMJSPUvm/3s80wrERCGAOGjUIFnoceOy1vfmYFehwbb9vwdwW+RBx41NHJApL8wN
 rAR/8PElfnYWbhWPV4jvjsFHz+mr7N321HmehZxZreLbp/9Nwq5NNoezMIpETKYIcn4a
 ZoBayv0JnveCnHwlhjTavKzQXOWLAkb78R5gpWsmO5Rx1gEgWtCrDkPZjZiOi5hrOi4h
 UYDA==
X-Gm-Message-State: AOJu0YwntRm/RUvCK+vG4d5jdaf7QR0iLzXrqGh/59rWsB7fJ1yie2/n
 6cjTT6fpYFMvuSyFC4u7rCDrRj3QRJ6jVVx1SCLedqBGHbFNCsJnrrHpQOXB
X-Google-Smtp-Source: AGHT+IFJYJu3XijN+wxtL+IbP+SEAhbYaMcir0wSM7rN2uN5TpUB+Bhm6ihsg8t6iInPP9vyr6LLug==
X-Received: by 2002:adf:ecca:0:b0:33a:e93c:e1c8 with SMTP id
 s10-20020adfecca000000b0033ae93ce1c8mr3479474wro.47.1706796093906; 
 Thu, 01 Feb 2024 06:01:33 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCVR4Fp1vQk/EfJ6xOMdiD9eyj77QHTbvAWGe5bI7Ts8dp+AjeZMfHaKES4hw/r8Io3kySMxdHwJ2YYYigtmrklhFAhVoYQ/Odg23lFkUg==
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 x18-20020a5d54d2000000b0033b14e447d1sm1689339wrv.1.2024.02.01.06.01.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Feb 2024 06:01:33 -0800 (PST)
Message-ID: <b5132e7f-2fcb-4ad2-8a12-8479feb6415a@gmail.com>
Date: Thu, 1 Feb 2024 15:01:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix typo in parameter description
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240111155837.3460096-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240111155837.3460096-1-alexander.deucher@amd.com>
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

Am 11.01.24 um 16:58 schrieb Alex Deucher:
> Missing space.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

And sorry that this took so long. I'm still trying to catch up to my mails.

Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 5c9caf5fa075..0712d5867849 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -366,7 +366,7 @@ module_param_named(aspm, amdgpu_aspm, int, 0444);
>    * Setting the value to 0 disables this functionality.
>    * Setting the value to -2 is auto enabled with power down when displays are attached.
>    */
> -MODULE_PARM_DESC(runpm, "PX runtime pm (2 = force enable with BAMACO, 1 = force enable with BACO, 0 = disable, -1 = auto, -2 = autowith displays)");
> +MODULE_PARM_DESC(runpm, "PX runtime pm (2 = force enable with BAMACO, 1 = force enable with BACO, 0 = disable, -1 = auto, -2 = auto with displays)");
>   module_param_named(runpm, amdgpu_runtime_pm, int, 0444);
>   
>   /**

