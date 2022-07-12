Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0B69C43334
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jul 2022 15:33:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E6C08F74E;
	Tue, 12 Jul 2022 15:33:51 +0000 (UTC)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B16538F74E
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jul 2022 15:33:49 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id t3so10343341edd.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jul 2022 08:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=IuZqJ2BDGD1AfBH5ahLXW5nXjkt4wk0LGRlzXQrJO3k=;
 b=ZhdVg2q62o2HMKLjD7HwHpTqyTD/VpTdU8dvtXyK70Xur+/ZIO/C0sxwKMGSTMWlTS
 7JiCuPMr9D/qGVd0mQsRGBqZ+G2tpi+HYJxn8fNwjt9qA6Hg1UazDeuH6GEiyX68dnSX
 BHfn/MBzPu+zSHEID+5X4fg8g6GNVXnHeqzak09CGBF5fHv4nm24Ti3jB6rpNNFzN/Li
 /UuMOuTd2p1ysgB3J7GTbrNBmzPhDLyf1I4ClpDI1QR4N4LEyhS6VZAWIua84/DIzhgN
 Rt7y7Ap24gtdXw4azLJfL/Qctqwi3VALS1dUxxAvMiwb4m1nUu97pvGvIR9v6fpx3RG0
 UJZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=IuZqJ2BDGD1AfBH5ahLXW5nXjkt4wk0LGRlzXQrJO3k=;
 b=tXOwTVcxdB5LvoZVXw5yCGg+//jl7REkl4mBTRaDjPE18J+9AYSdWT7xBPzkqS9D83
 UDpeBVpx4QRavNDJ0FmGhlR9BTKmz/m380J9Y98E7guKRu9Bp4+aYQGm9tuugrDmDgK/
 pwCvBQE+j1Bu+mH/R2solzewfAzyEk8W7uAaf2azllFgpo1llZY+Sk1mvKuX2DEfINDM
 kJoENmUq34Kekam4Fho8rWb9KDsZ2uXNDqgLD4vMvV/m7mHIsjNKLQU48Wm7XIXSfc/4
 0KIOscU18y1hVfNVSwBiXsFr+nYCCyEZhVf71lwNZ3MekhClW39Ym4Dqn+fg/Q54B4p8
 lZmA==
X-Gm-Message-State: AJIora+xhDSQFPqLyslC+OOUP91PhE0lDnM4oLFMXcEK0d+MNuxiLyJ2
 +PINHyc9mGdEAaHXbLHaKtSKFRnER98=
X-Google-Smtp-Source: AGRyM1vgWSKk+adqukfmsX84yjDA3WBkeFqzvyGLtjsOnR4QXTrSCY9DOL8yfxdYFk8Vs2Lnv14+Pg==
X-Received: by 2002:a05:6402:34c5:b0:43a:8f90:e643 with SMTP id
 w5-20020a05640234c500b0043a8f90e643mr32307075edc.88.1657640028199; 
 Tue, 12 Jul 2022 08:33:48 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:cf35:dc88:25dd:1187?
 ([2a02:908:1256:79a0:cf35:dc88:25dd:1187])
 by smtp.gmail.com with ESMTPSA id
 r2-20020a1709061ba200b00711edab7622sm3925682ejg.40.2022.07.12.08.33.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Jul 2022 08:33:47 -0700 (PDT)
Message-ID: <559baace-907f-954a-af84-e840a086f62e@gmail.com>
Date: Tue, 12 Jul 2022 17:33:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/2] drm/amd/display: fix comment format
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220712143159.2700970-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220712143159.2700970-1-alexander.deucher@amd.com>
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
Cc: kernel test robot <lkp@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 12.07.22 um 16:31 schrieb Alex Deucher:
> This is not a compliant kerneldoc comment, so make it just
> a regular comment.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com> for this series.

> ---
>   drivers/gpu/drm/amd/display/dc/dcn314/dcn314_optc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_optc.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_optc.c
> index c4a5f8198209..436c3545a983 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_optc.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_optc.c
> @@ -42,7 +42,7 @@
>   #define FN(reg_name, field_name) \
>   	optc1->tg_shift->field_name, optc1->tg_mask->field_name
>   
> -/**
> +/*
>    * Enable CRTC
>    * Enable CRTC - call ASIC Control Object to enable Timing generator.
>    */

