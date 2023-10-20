Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 564D7C001DF
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Oct 2023 12:24:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BACF510E0E1;
	Fri, 20 Oct 2023 12:24:31 +0000 (UTC)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE1F710E0E1
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Oct 2023 12:24:29 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-538e8eca9c1so1017128a12.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Oct 2023 05:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697804668; x=1698409468; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GUyywSs9rRjDmByqMxl4zzVcR2FEYGRQ+eBwg9JDUog=;
 b=jlO1+++3TPEOx5c4ZCw4TC9QyFIqn72ocXSrE/ImkJARhTkNO4B7mSUfaZuFK9zeX6
 RT9w1hbKVZUjLCHEPBm7bX1BTgMx/nFQJXCVatnW0J8pUZswHAHR3xm7T7R6nCPJLDT/
 WxSE+iq7IAUP9gYsIDjIB2f+CY/Q0ODPq39EHKbRnO87UVCGzEK/MKKWDxMxMavvVc2t
 PJtAmIdUStY3J9F74R5c7IDztSxCO7Lh7WZ1/6rdjsKPboISVA2gr66zRjNxgILGCQ77
 6r/v2OD6bXjl4ZIsFiBVpbGn73Ax3Oi6pPbZNxI450kio8ij1qdIp7LG9nG+ltFKYv6m
 Gi3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697804668; x=1698409468;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GUyywSs9rRjDmByqMxl4zzVcR2FEYGRQ+eBwg9JDUog=;
 b=ac6gMA9KXkm6h0b21fMzPnARC1zYy2KqzzS+TmQFosmh7GE5agTlyTo+/mpDVkiFzO
 a1PdDy8+2KzsSns1WCooyEbJ5PB6EzJoaTCqjeHNsC9PUw63vZwYIsixND0O0KlfkaIy
 s3butCXfzwg5OM5R3nXTp7Z+FLReZAyh00f8167YCNfiE9nySv79Vvfrms5ERuwdciwO
 rfRdCGFZGYSwSTCauc1CLdAtSwFq/Fyp5sizV2FWhzZQ6J6YRSVdcfM0O7lGKmd1+t2L
 HeuRiCguVy3ogxgVhLocK4d1JmzK7EhKTdYMLlrySi0cGbwTpJ0F/VvjgGm4gZAKG/Ns
 /gWQ==
X-Gm-Message-State: AOJu0Yyp26cuhf49O6fJf9bbJ3pvOdvrq80UteOfdJzEcSxx8cBI3Uma
 qKR9TU6Rj6TrdQhMrNbzEt0=
X-Google-Smtp-Source: AGHT+IGJfEQ+lwSWolH+xaTRLl61ulzS+quiowAaOr9EXy9mr6CewNkSo4XKQntvek72q7LgIoVFXQ==
X-Received: by 2002:a17:907:26c2:b0:9be:53d0:3707 with SMTP id
 bp2-20020a17090726c200b009be53d03707mr1312794ejc.25.1697804667842; 
 Fri, 20 Oct 2023 05:24:27 -0700 (PDT)
Received: from [192.168.178.25] ([134.19.58.40])
 by smtp.gmail.com with ESMTPSA id
 v26-20020a17090610da00b00993a37aebc5sm1384226ejv.50.2023.10.20.05.24.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Oct 2023 05:24:27 -0700 (PDT)
Message-ID: <be52d289-fe3b-4e36-8a6f-f6f9057d1669@gmail.com>
Date: Fri, 20 Oct 2023 14:24:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH Review 1/1] drm/amdgpu: Workaround to skip kiq ring test
 during ras gpu recovery
Content-Language: en-US
To: "Stanley.Yang" <Stanley.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231017143638.3203961-1-Stanley.Yang@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20231017143638.3203961-1-Stanley.Yang@amd.com>
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

Am 17.10.23 um 16:36 schrieb Stanley.Yang:
> This is workaround, kiq ring test failed in suspend stage when do ras
> recovery for gfx v9_4_3.

Any idea why that failed? Problems like this usually point to an 
incorrect init or in this case re-init procedure and are actually what 
the ring test should uncover.

Christian.

>
> Change-Id: I8de9900aa76706f59bc029d4e9e8438c6e1db8e0
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 9a158018ae16..902e60203809 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -29,6 +29,7 @@
>   #include "amdgpu_rlc.h"
>   #include "amdgpu_ras.h"
>   #include "amdgpu_xcp.h"
> +#include "amdgpu_xgmi.h"
>   
>   /* delay 0.1 second to enable gfx off feature */
>   #define GFX_OFF_DELAY_ENABLE         msecs_to_jiffies(100)
> @@ -501,6 +502,9 @@ int amdgpu_gfx_disable_kcq(struct amdgpu_device *adev, int xcc_id)
>   {
>   	struct amdgpu_kiq *kiq = &adev->gfx.kiq[xcc_id];
>   	struct amdgpu_ring *kiq_ring = &kiq->ring;
> +	struct amdgpu_hive_info *hive;
> +	struct amdgpu_ras *ras;
> +	int hive_ras_recovery;
>   	int i, r = 0;
>   	int j;
>   
> @@ -521,6 +525,23 @@ int amdgpu_gfx_disable_kcq(struct amdgpu_device *adev, int xcc_id)
>   					   RESET_QUEUES, 0, 0);
>   	}
>   
> +	/**
> +	 * This is workaround: only skip kiq_ring test
> +	 * during ras recovery in suspend stage for gfx v9_4_3
> +	 */
> +	hive = amdgpu_get_xgmi_hive(adev);
> +	if (hive) {
> +		hive_ras_recovery = atomic_read(&hive->ras_recovery);
> +		amdgpu_put_xgmi_hive(hive);
> +	}
> +
> +	ras = amdgpu_ras_get_context(adev);
> +	if ((amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3)) &&
> +		ras && (atomic_read(&ras->in_recovery) || hive_ras_recovery)) {
> +		spin_unlock(&kiq->ring_lock);
> +		return 0;
> +	}
> +
>   	if (kiq_ring->sched.ready && !adev->job_hang)
>   		r = amdgpu_ring_test_helper(kiq_ring);
>   	spin_unlock(&kiq->ring_lock);

