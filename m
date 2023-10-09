Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 524B5E95A8E
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Oct 2023 09:06:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE65B10E245;
	Mon,  9 Oct 2023 09:06:48 +0000 (UTC)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 720F910E245
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Oct 2023 09:06:47 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-32003aae100so3200444f8f.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Oct 2023 02:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696842406; x=1697447206; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mJsqMKGpI4z6fq1njAqJ9d651YUMwUDa/zVs1NYZm5k=;
 b=DtpeMmt5jJky2VK5WC/1KmyODiXzO/oUE+K/CHr7hrSEK+dlMP2rwcwLpsaKVbUfKt
 1ws1wcpjyExqBRQ9jKRcrNQ2C/9h/7OK37VFGvOx2VBgT8c3wJNAmUhoLX5Ud/pL2CIc
 N5IClnDHNoZNxLJQSfl8iH/AmU1gBNwyJCFLFxG4nP/7eq2zdfj9WvAuyzwdta/ajt90
 HGnL2Vj7Y7incVKq4pwfBoc15oNI7Z9Gl+CA2mziRNphiLS2aDZ2CWUj0657nmFAeuIn
 ZKgq4bhSPgl6yKFi42KL3q3QPt1YynpItKMfHc2Ugae8xQoiUH6yhbwoA3iKkU3qgouG
 /dGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696842406; x=1697447206;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mJsqMKGpI4z6fq1njAqJ9d651YUMwUDa/zVs1NYZm5k=;
 b=P1Dwg+t+eiYA1F8MiM4K5XIA1Cz2RSL5k1B8pQbSOyLlaJYnv2ocyHbNzbKNZJmJel
 cdviEnWXEl8NKHyn9to89lzhT8yhOo2x7i0E5K2eMVuB0pe3mRNMJs8EIL0MPMTEChUz
 3O3aNAL/xcupcVLz6CG2m9MPXTO49Y88C1yc7bAqrE/jPfQ8pXuJ6LF6syJ3iJZirATw
 lnCkxp/BDb4QhX6Ehu14hGe9oKyPflNsZeX+puoCq2jYyuISPxBmsw5oaIZSpY254Ns6
 RlneKwEK3tVzp8Vjh1Z26ch3k6OPWeuA2Q7XbcNBmNM+BgeSWQsuXEBLANHgiVdmGIGz
 gMQQ==
X-Gm-Message-State: AOJu0Yx7b9CgPNRFBdO6CcwwFh+SB/ZDH2WW/r25Vdj0P30yCaeqretF
 fq1cCk1FyeqAaPqG+1UbUEY=
X-Google-Smtp-Source: AGHT+IFuJRh6PpmHe5lH9tLvnPJnCEEgUcmRhn90O9uc7zR2TJv2OLeBGWlOp2LF6eQvxvW8XmEuqQ==
X-Received: by 2002:adf:f049:0:b0:324:87bc:e6ca with SMTP id
 t9-20020adff049000000b0032487bce6camr9933152wro.6.1696842405747; 
 Mon, 09 Oct 2023 02:06:45 -0700 (PDT)
Received: from [10.254.108.106] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 x8-20020adfcc08000000b003296bb21c77sm8408527wrh.80.2023.10.09.02.06.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Oct 2023 02:06:45 -0700 (PDT)
Message-ID: <6df720ca-1cd4-4adb-a326-c1e68a133b6a@gmail.com>
Date: Mon, 9 Oct 2023 11:06:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/7] drm/amd/display: Catch errors from
 drm_atomic_helper_suspend()
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20231006185026.5536-1-mario.limonciello@amd.com>
 <20231006185026.5536-6-mario.limonciello@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20231006185026.5536-6-mario.limonciello@amd.com>
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
Cc: Harry.Wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 06.10.23 um 20:50 schrieb Mario Limonciello:
> drm_atomic_helper_suspend() can return PTR_ERR(), in which case the
> error gets stored into `dm->cached_state`.  This can cause failures
> during resume.  Catch the error during suspend and fail the suspend
> instead.
>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2362
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
> v4->v5:
>   * New patch
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index a59a11ae42db..63944d3b9e8c 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -2716,6 +2716,8 @@ static int dm_suspend(void *handle)
>   
>   	WARN_ON(adev->dm.cached_state);
>   	adev->dm.cached_state = drm_atomic_helper_suspend(adev_to_drm(adev));
> +	if (IS_ERR(adev->dm.cached_state))
> +		return PTR_ERR(adev->dm.cached_state);
>   
>   	s3_handle_mst(adev_to_drm(adev), true);
>   

