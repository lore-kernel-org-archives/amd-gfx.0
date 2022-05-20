Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12A5EC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 20 May 2022 07:53:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 870AE11B77A;
	Fri, 20 May 2022 07:53:25 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE45711B779
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 May 2022 07:53:23 +0000 (UTC)
Received: by mail-ej1-x62a.google.com with SMTP id f21so440090ejh.11
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 May 2022 00:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :references:from:in-reply-to:content-transfer-encoding;
 bh=iy/8rT1WVQP/wz+dMRKw5nQ1hUXXrNEShylTAat0gIs=;
 b=BON0JxXPBW6UMFEAlrtlVj6blDwlh+LmK+yHE4wOrLGUVjEc3siSq3RP2pp3S6QV9i
 y6LAYAPP5Qh2Xyy1vIDFLfyEXuYALt+/81SNaYBUczMZ58lhLBSuzfV2yGFmP/5KmC27
 KZaMsPG221xhzW9hZlSEmedVW+/42tBclnj8z1FmmXNhbk6QQ93Hy6kUM+CXWUVkbZhD
 wYYoXQKWwDxiCG2lJxllhobS8VPRqjcHCR3oJPglQoMRxkdbYzhoH5BHQuaXfcpkWm6P
 QfjMPTmEBda7YoeZWz2WqF/KlyuNw68IUZQcKf/eCLU9y21bX1ynzie/URj1RlZZbeS3
 iajA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:references:from:in-reply-to
 :content-transfer-encoding;
 bh=iy/8rT1WVQP/wz+dMRKw5nQ1hUXXrNEShylTAat0gIs=;
 b=pRubu8V0xp1tpptmYI0zhYicRYvq4g3Pchtx3XbM1gz2h24zVv0JuXDwss0yKRAZzH
 ySP6VQvEZxMuN7yZtiqDaCVpPXt8antrQEU/GrTULuH4ixulRiP9eDNDlvFOUQHF4AyB
 6WoB9HmEECJyhX4LbFpsicEteDVkrCHhdr6nZzeENijziDsr1a9ZdiW4ug1YpbMungde
 zcELDVBf30VQ47bPAWCPZ0JEA9fNk7X1CNzrcN6izucpLjIMrgoRgUjkv9f8kinvsH/3
 z6ixYMaajR2EZSuI4qiIjqzGGSU8tQYJbK8kvFF4uk9prrZKic0jOSC513djr3VAZHrl
 4Mkg==
X-Gm-Message-State: AOAM531qXz26k4dkdXj+RhuLQMdmWZm3XQABf3IooKAnQWcEVURinJ9Q
 K9d1kyxZer7tz5ac7iRbZazffNe7G5w=
X-Google-Smtp-Source: ABdhPJzqx/jOHCc7ABZcvI1lVKYqkvQwjbEYzktw6ir3T5LwzY0Et6070AsY6m8yq4UvLJEmNGltCQ==
X-Received: by 2002:a17:907:97d5:b0:6fe:af07:65a with SMTP id
 js21-20020a17090797d500b006feaf07065amr1298549ejc.20.1653033202436; 
 Fri, 20 May 2022 00:53:22 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:66f:9303:6022:1507?
 ([2a02:908:1256:79a0:66f:9303:6022:1507])
 by smtp.gmail.com with ESMTPSA id
 sa24-20020a170906edb800b006fe8ac6bc69sm200441ejb.140.2022.05.20.00.53.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 May 2022 00:53:21 -0700 (PDT)
Message-ID: <a35fa377-6c06-e54d-1ce3-c3099f66f801@gmail.com>
Date: Fri, 20 May 2022 09:53:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] drm/amdgpu: Adjust logic around GTT size (v2)
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220519155759.93428-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220519155759.93428-1-alexander.deucher@amd.com>
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

Am 19.05.22 um 17:57 schrieb Alex Deucher:
> Certain GL unit tests for large textures can cause problems
> with the OOM killer since there is no way to link this memory
> to a process.  This was originally mitigated (but not necessarily
> eliminated) by limiting the GTT size.  The problem is this limit
> is often too low for many modern games so just make the limit 3/4
> of system memory. The OOM accounting needs to be addressed, but
> we shouldn't prevent common 3D applications from being usable
> just to potentially mitigate that corner case.
>
> Set default GTT size to 3/4 of system ram by default.
>
> v2: drop previous logic and default to 3/4 of ram

Well that is a pretty clear NAK.

This will cause massive problems for some test cases.

Christian.

>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 17 ++++++++++++-----
>   1 file changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 4b9ee6e27f74..4966412024a3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1804,12 +1804,19 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>   		struct sysinfo si;
>   
>   		si_meminfo(&si);
> -		gtt_size = min(max((AMDGPU_DEFAULT_GTT_SIZE_MB << 20),
> -			       adev->gmc.mc_vram_size),
> -			       ((uint64_t)si.totalram * si.mem_unit * 3/4));
> -	}
> -	else
> +		/* Certain GL unit tests for large textures can cause problems
> +		 * with the OOM killer since there is no way to link this memory
> +		 * to a process.  This was originally mitigated (but not necessarily
> +		 * eliminated) by limiting the GTT size.  The problem is this limit
> +		 * is often too low for many modern games so just make the limit 3/4
> +		 * of system memory. The OOM accounting needs to be addressed, but
> +		 * we shouldn't prevent common 3D applications from being usable
> +		 * just to potentially mitigate that corner case.
> +		 */
> +		gtt_size = (u64)si.totalram * si.mem_unit * 3 / 4;
> +	} else {
>   		gtt_size = (uint64_t)amdgpu_gtt_size << 20;
> +	}
>   
>   	/* Initialize GTT memory pool */
>   	r = amdgpu_gtt_mgr_init(adev, gtt_size);

