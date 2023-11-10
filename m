Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37DA6C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Nov 2023 09:01:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFA1D10E953;
	Fri, 10 Nov 2023 09:01:28 +0000 (UTC)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A412910E97C
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Nov 2023 09:01:17 +0000 (UTC)
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2c5071165d5so23893621fa.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Nov 2023 01:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699606876; x=1700211676; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2YJso1LnH7eeW0SnmHqyDfZ8DW2h/SHhnspP45vkulI=;
 b=kTmDxwC+pba9ORcrfiYYvElm31fAZLH2fx1EQ+JGX4VwVkX4ouzENid4ny/ux9F+u9
 O6jCEf/AwqaHje11rh5NG0OJBq2rTmanB7H76pA4LxPFVMILw4yEL6SsLAqhsFQSdC7O
 BOWRkqKy6KQ2hy4sCU4sB7bcivRjT4GgHm76dblfYWO243vX3h+sgRCy2xVnDf/M7qtF
 Agzyxz0lAKnIH847nhMNK8WDI4dCkv+xZpAZtYgTiLajdKZFHYIVE1aVy8xaSrmPz0qA
 6M5imziOAL3rHt6sl+10NljaDPiLUqkJOqr2kUnNC/sOwA51w9tWnBkLRhibw/yV9fwl
 NA3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699606876; x=1700211676;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2YJso1LnH7eeW0SnmHqyDfZ8DW2h/SHhnspP45vkulI=;
 b=PLeMl9Pwps4PvWgTboekHp7N5aSx2Xl/sIjFBiaHQ9VlToGjBsl16e3oinPdtYtuOk
 C+LHaDtFJ+c3PGN9wUMl61jGwQ88tTveIswquGVBDvQaSEUwDElc6Ef8Agg+D83w9x6C
 O3dlxn9iWNc7N/MWRmtYeLhQJ/otNFcfoPP8mYQGkxIal3cbZevnMsR3e/BImXyc9PGv
 oIvM+2YXH2LEMzAw5WdldrUE3dtlr2M7zR+hOkDMhBPgiZEq/Y0FyfRtLk0YomA+P+b/
 vo/Xd/R8glTrGy8vAmJpitWq+gLxl4bRbJGYFAbEZKtNPY5D75oRNxhyMZhvRd/a4aVv
 PQeQ==
X-Gm-Message-State: AOJu0Yy1QdYyhUuZ0L35H/jqhofDr4HI0Hn3zPrfyJuMyqi2OBoKUpLj
 rE7CTww6p0TCWo364JXoH6m2Gsb7FD0=
X-Google-Smtp-Source: AGHT+IFo4RFGYrF8KUiilmWBfXCTuI4TiPAsf5H3UW9oVejykwYe923VFbBAHy5kezRGrs77pJwl1g==
X-Received: by 2002:a2e:9a82:0:b0:2c5:17c0:cd53 with SMTP id
 p2-20020a2e9a82000000b002c517c0cd53mr6100045lji.42.1699606875438; 
 Fri, 10 Nov 2023 01:01:15 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 c19-20020a7bc013000000b0040a3e417d65sm4467348wmb.0.2023.11.10.01.01.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Nov 2023 01:01:15 -0800 (PST)
Message-ID: <9ec8806c-6559-41a3-8e72-a864355c35a4@gmail.com>
Date: Fri, 10 Nov 2023 10:01:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu/gmc11: disable AGP aperture
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231109144143.502132-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20231109144143.502132-1-alexander.deucher@amd.com>
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

Am 09.11.23 um 15:41 schrieb Alex Deucher:
> We've had misc reports of random IOMMU page faults when
> this is used.  It's just a rarely used optimization anyway, so
> let's just disable it.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Acked-by: Christian König <christian.koenig@amd.com> for the series.

> ---
>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 3 ---
>   1 file changed, 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> index 6dce9b29f675..e1cac5da9c4b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -640,9 +640,6 @@ static void gmc_v11_0_vram_gtt_location(struct amdgpu_device *adev,
>   	amdgpu_gmc_set_agp_default(adev, mc);
>   	amdgpu_gmc_vram_location(adev, &adev->gmc, base);
>   	amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_HIGH);
> -	if (!amdgpu_sriov_vf(adev) ||
> -	    (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(11, 5, 0)))
> -		amdgpu_gmc_agp_location(adev, mc);
>   
>   	/* base offset of vram pages */
>   	if (amdgpu_sriov_vf(adev))

