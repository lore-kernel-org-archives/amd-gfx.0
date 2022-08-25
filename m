Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0720C1B0E9
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Aug 2022 15:56:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA07110E094;
	Thu, 25 Aug 2022 15:56:38 +0000 (UTC)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D7A910E053;
 Thu, 25 Aug 2022 15:56:29 +0000 (UTC)
Received: by mail-oo1-xc29.google.com with SMTP id
 q6-20020a4aa886000000b0044b06d0c453so2888799oom.11; 
 Thu, 25 Aug 2022 08:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc;
 bh=2sx4/x621XjoOsAHsYvDRl4ejxU/tu33VcZX+qjgFuQ=;
 b=KNWI5qktF53AcillC2DCSWiSMqu5KKXeO611Cnlmb4y/p2HS/c9jInbRFwKBO5jQeo
 Y7897V7lMQH+5NADak9NVGSSLmZnKXjmw26GGfmBojo8/tPEaKuNbg0Dwrh4AQxEV743
 P4z9zEcmbJd+6MWh5l0VcTQqjvz/FMhSCXUVl8hUzj5ydVTx6jJWUoe1MAB9xm8aCCil
 73i/2UHIWsCXSNvpAZh1nI+IQ+J4MjSuje6h6/CXhMoyYzIjUq7SPvclAAZ1fRPuMrxC
 5MqsqtyOjdTvsuE0Sc3NNZ2l4JDf0F2xvYO7vDwxwyJusTfxvptmJEUY21rQkzF6U2Kn
 vPpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=2sx4/x621XjoOsAHsYvDRl4ejxU/tu33VcZX+qjgFuQ=;
 b=eXgINAR2WkkG3pJjkBgmWPMCC+DUEWZDcgehIA8oWW24TSPoC2Bcxb/GZb4oZ8HN20
 s/ruzUVVLhNH7eUop95p7xQPluPpXxisIdVciW5f6d+DHrHvag3JWKIbabLqjZw+6T44
 urctd3Q6g51RslDqkC2VsGf4aO1oszia3uW0Yc6EjFtKNq45G+ccUtEmodPJ34KSYNHM
 r7Wtbunfu4+jDfv1k2STCmfTXRIOCCx4g/0ScMW9wL4oA/DpxeZbkSQcYbB97qkBF4jL
 ZwUv7wNzKymz2zEP4BLUuwud/YTuCwlWv0oKm7lHkS5/BeoiOM5SxCq5Aa3S0Nixq1ID
 dm2A==
X-Gm-Message-State: ACgBeo17iPeTOnySh145QqPJuvuHhSJDVTODgWpdMrS/ZALT0KeaM0rH
 vef5eurIX+C+N8uL0zZHxm9IPC7Yc8BImC13ElQ=
X-Google-Smtp-Source: AA6agR5GJTWv75t/YXIQTurxidXrwhktIW4TYORHY2v/FTLgQ5T+umce8C8KJ7FiylZz0JPLtVPXAHBMCboopaV7+Ic=
X-Received: by 2002:a4a:aa81:0:b0:44a:da30:274e with SMTP id
 d1-20020a4aaa81000000b0044ada30274emr1512269oon.97.1661442988766; Thu, 25 Aug
 2022 08:56:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220823064406.1874-1-jinsdb@126.com>
In-Reply-To: <20220823064406.1874-1-jinsdb@126.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 25 Aug 2022 11:56:17 -0400
Message-ID: <CADnq5_OZUX0UBOzQyQDi_oFQK1Pgno4sFrmV2FdA+a+2NiaSyA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: mmVM_L2_CNTL3 register not initialized
 correctly
To: jinsdb@126.com
Content-Type: text/plain; charset="UTF-8"
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
Cc: airlied@linux.ie, Xinhui.Pan@amd.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 daniel@ffwll.ch, alexander.deucher@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Tue, Aug 23, 2022 at 3:15 AM <jinsdb@126.com> wrote:
>
> From: Qu Huang <jinsdb@126.com>
>
> The mmVM_L2_CNTL3 register is not assigned an initial value
>
> Signed-off-by: Qu Huang <jinsdb@126.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
> index 1da2ec692057e..b8a987a032a8e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
> @@ -176,6 +176,7 @@ static void mmhub_v1_0_init_cache_regs(struct amdgpu_device *adev)
>         tmp = REG_SET_FIELD(tmp, VM_L2_CNTL2, INVALIDATE_L2_CACHE, 1);
>         WREG32_SOC15(MMHUB, 0, mmVM_L2_CNTL2, tmp);
>
> +       tmp = mmVM_L2_CNTL3_DEFAULT;
>         if (adev->gmc.translate_further) {
>                 tmp = REG_SET_FIELD(tmp, VM_L2_CNTL3, BANK_SELECT, 12);
>                 tmp = REG_SET_FIELD(tmp, VM_L2_CNTL3,
> --
> 2.31.1
>
