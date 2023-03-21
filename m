Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBAB8C74A5B
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Mar 2023 15:36:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 700C510E7AC;
	Tue, 21 Mar 2023 15:36:36 +0000 (UTC)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46ADE10E7AC
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Mar 2023 15:36:35 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id l27so5828744wrb.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Mar 2023 08:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1679412993;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZEYmgERY9aB3arXlnNK5RKRLAj/Mzohr+h6KQDgCn9A=;
 b=iTlDiA1pAmIb+6mBw145e1oEo5eRRrMbT89K9IHzNJwQ2zuqh5vEQMp4Kg4nF+YXEA
 T60CnL4U3aBeCHW+pmWILEwZ7d5/+P1zpB59HgLCCmbsH4zOOBqGu/ZTho9/+CkGO2Bu
 KmcLmrUzFOJFrnLlxZzO4M31GxvDC8gFDLVRYtuV/EP7Owt3ELSqT6VPs1GzmI0CfYRC
 ZT5mFqXp2YiOjl2qP4kMMD6MYmo6lB9xQelZcnCibbYanyK2Jly+OUPFJU8TStmMDpgv
 3TIViIfZBY9QiWP6hOvKArMQOGN1eodUiUxISBJToQY8lTH6BiiFZCGdOYH/fS1HeDI+
 iqjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679412993;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZEYmgERY9aB3arXlnNK5RKRLAj/Mzohr+h6KQDgCn9A=;
 b=DQgTaOBh6zWrwS1zx6bXaJuelV35ZISRSH+IoBtWre+ASHEgWhsMVlkv7H/YtzE/Cm
 F6i/1QZi49//ipGQfjBMsKXAjnWO6zh0+L5dq9IW8q3lsifONUyheQH0+U91IQ16t1Kf
 2RYWj2HM2jJFVFkRxiKgzYdv1hFA3FLUfA2D1au0a117sROuGpVOXcW1lz9a6qsQhLwJ
 l1JeDGwLwhh2whj2gSf2YxIstAsl3vcbIAjX1p7Xl+Ohly8Qyq7dMN3ELoyiVggGzZD9
 2usNiIAzqC85D+/6277lgdFs+uhfPplVsL39v6Gwmi82sttsqOqPtiACWy911mRKBmS5
 mngg==
X-Gm-Message-State: AO0yUKWgm0jX0+EIfBkCgonKKRC76k5TiK+PMisZ07gcEQLvom7sxPDw
 /hoeNYciNG99O/Yd++QsXZ4=
X-Google-Smtp-Source: AK7set9jN34XrPk72hpoMkUJ1uvZ71uIHbAYXDWyeuhW/Fb0kOeoCZoxaLAd8pwKReGINtj9ozVyaA==
X-Received: by 2002:adf:f48a:0:b0:2ce:a862:551 with SMTP id
 l10-20020adff48a000000b002cea8620551mr2488487wro.58.1679412993578; 
 Tue, 21 Mar 2023 08:36:33 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:ecb6:57a3:fc8e:3359?
 ([2a02:908:1256:79a0:ecb6:57a3:fc8e:3359])
 by smtp.gmail.com with ESMTPSA id
 g9-20020a5d4889000000b002c559843748sm11630572wrq.10.2023.03.21.08.36.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Mar 2023 08:36:32 -0700 (PDT)
Message-ID: <c9acf289-fcd5-4b58-dd21-de398607376c@gmail.com>
Date: Tue, 21 Mar 2023 16:36:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 02/11] drm/amdgpu/gfx11: check the CP FW version CP GFX
 shadow support
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230320173810.250835-1-alexander.deucher@amd.com>
 <20230320173810.250835-3-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230320173810.250835-3-alexander.deucher@amd.com>
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

Am 20.03.23 um 18:38 schrieb Alex Deucher:
> Only set the supported flag if we have new enough CP FW.
>
> XXX: don't commit this until the CP FW versions are finalized!
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index a0d830dc0d01..4a50d0fbcdcf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -469,6 +469,15 @@ static void gfx_v11_0_check_fw_cp_gfx_shadow(struct amdgpu_device *adev)
>   	case IP_VERSION(11, 0, 0):
>   	case IP_VERSION(11, 0, 2):
>   	case IP_VERSION(11, 0, 3):
> +		/* XXX fix me! */
> +		if ((adev->gfx.me_fw_version >= 1498) &&
> +		    (adev->gfx.me_feature_version >= 29) &&
> +		    (adev->gfx.pfp_fw_version >= 1541) &&
> +		    (adev->gfx.pfp_feature_version >= 29) &&
> +		    (adev->gfx.mec_fw_version >= 507) &&
> +		    (adev->gfx.mec_feature_version >= 29))
> +			adev->gfx.cp_gfx_shadow = true;
> +		break;
>   	default:
>   		adev->gfx.cp_gfx_shadow = false;
>   		break;

