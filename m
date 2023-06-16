Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7862EB64DA
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jun 2023 12:47:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7085B10E615;
	Fri, 16 Jun 2023 12:47:19 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E62F10E614
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jun 2023 12:47:15 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5147e40bbbbso861804a12.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jun 2023 05:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686919633; x=1689511633;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RlfMi5vKY6QjjzfvXUGj6GpuwoT85GrBCFkNQAMVV2o=;
 b=NQj7DotQV9hAyKF2H7hGm/sJPE0U7TPsb7TBy3tc8URRBgD6Kg+WecRSVMltioUphY
 Q7V4CSK6Rs5BP1RBd10o8FTpgqbi2itwxI2lnVhthisCzeNcOXr65YEg1Xu3h9qaiXu9
 esaIDnWj4niBdp1bdoaIpxeEyWSvlnDwTD6np1mudOUf2KiFG7TB3JnBQR9levwmYC4B
 NLsO4Pi/9fgTJaLggOd0qyHdi/Ndy/d5UvKvNfXKDyrqr032CBn5/Qxyaju1EyxgcK1U
 dcAEBv1aCDFoyUUkuuefPM37Xuw/q0m/ez1PJ4tpWapjxmnb1aB0FFCIld43sn0Ot4/X
 IoUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686919633; x=1689511633;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RlfMi5vKY6QjjzfvXUGj6GpuwoT85GrBCFkNQAMVV2o=;
 b=KFMlGXVKD14BkXmCuoYFFKsSDS15HSibkBNNAU+8FM5eQDrEfTqkBRQd15BDb9El36
 u15F3dNZyHSELBW6mw63upw/bmWEwdXM3kM6jMoDhaLAg9NKpIvxmC93DTpcEMfUqz1n
 l6SuxUMKoaPga6nfkRch4oqaNB3bLdevr0oCMturNoRleCv+/5/GeCHkdftB8AoauK+6
 pAcn4Qp2ew9XW7HY9uxvmd6ezSANENieXiRZkZ0RyepaXN+CXCJmNNyOSd/m8yoPzQJM
 F0B3KD9Livekvj1wSsQkLii+z8yxhIzCAuJx8YNC8PxS/36krqcLa2ElAvv46h86p6vD
 BPvw==
X-Gm-Message-State: AC+VfDwzOA1VH22TsHUXwNEO0kHdMQ5Zn3ipGvqFxGue/kAWMwPC4Wyq
 ip4ClpQe3/7q9DVFh3PpNvqq/Fxa1gM=
X-Google-Smtp-Source: ACHHUZ44XoNiO+0nxzku5689vwwMnCSeaG/ynGoiIWIg3OHhPfRD3S9kbMfZ5k+F3R9AuLU8iCiQKw==
X-Received: by 2002:a05:6402:29a:b0:514:945c:6cea with SMTP id
 l26-20020a056402029a00b00514945c6ceamr1377382edv.37.1686919633136; 
 Fri, 16 Jun 2023 05:47:13 -0700 (PDT)
Received: from ?IPV6:2a00:e180:151b:3a00:4ba7:36a9:cecb:189?
 ([2a00:e180:151b:3a00:4ba7:36a9:cecb:189])
 by smtp.gmail.com with ESMTPSA id
 e5-20020a056402104500b005153b12c9f7sm9959246edu.32.2023.06.16.05.47.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Jun 2023 05:47:12 -0700 (PDT)
Message-ID: <25182053-2c9f-fd10-68cf-31de4ae20045@gmail.com>
Date: Fri, 16 Jun 2023 14:47:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdgpu: enable mcbp by default on gfx9 chips
Content-Language: en-US
To: jiadong.zhu@amd.com, amd-gfx@lists.freedesktop.org
References: <20230616050725.1464277-1-jiadong.zhu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230616050725.1464277-1-jiadong.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Am 16.06.23 um 07:07 schrieb jiadong.zhu@amd.com:
> From: Jiadong Zhu <Jiadong.Zhu@amd.com>
>
> Gfx9 is using software rings which would trigger mcbp in some cases.
> Thus the parameter amdgpu_mcbp shall be enabled by default.

Actually the idea was to not need the amdgpu_mcbp parameter any more and 
deprecate it with the use of the software rings.

Why is that still necessary?

Regards,
Christian.

>
> Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 65577eca58f1..1b3cfda946f9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -4527,6 +4527,7 @@ static int gfx_v9_0_early_init(void *handle)
>   	adev->gfx.xcc_mask = 1;
>   	adev->gfx.num_compute_rings = min(amdgpu_gfx_get_num_kcq(adev),
>   					  AMDGPU_MAX_COMPUTE_RINGS);
> +	amdgpu_mcbp = 1;
>   	gfx_v9_0_set_kiq_pm4_funcs(adev);
>   	gfx_v9_0_set_ring_funcs(adev);
>   	gfx_v9_0_set_irq_funcs(adev);

