Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83DEFC10F1A
	for <amd-gfx@archiver.kernel.org>; Tue,  7 May 2024 13:27:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A58F1124CE;
	Tue,  7 May 2024 13:27:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BNYDxo3R";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50C0C1124CE
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 May 2024 13:27:16 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-34e7a35d5d4so2350123f8f.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 May 2024 06:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715088434; x=1715693234; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3aaOm4QVe3KTZPoIb9XkqGFEi4IZ3pqZ2QOiUbiTC6Q=;
 b=BNYDxo3Rd2MECNTObgINAa8j3ZpGWbUlj/ClwnMiThz4aqimzKHxa9c4AOXJBPatsd
 PJvavF3ZZ38DkMHBvmp8HsO/LWBtw9IjP0AGjQNqvDF8p18xUB4vxtd/SUCYL+f6Pgf/
 mC49SgfZRzIKegujR3RuaCnd4ZIY+zoCpGeMJyw9KOMFel+jS1uzte5fraYdPmpxwNjR
 dmS6U1306CSgfqr+G9Q9/j+7BHq0Ou/5RUtn22nEN7xyB1dDcwB+o7loNJ0uXyCfV1Vv
 9WAGgsjYr3ST4P2ak7RIC8qTj+DpQq/b6xH+X2MPmFfskWMkCfFJijphJJaCSzSTFzOW
 Cn1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715088434; x=1715693234;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3aaOm4QVe3KTZPoIb9XkqGFEi4IZ3pqZ2QOiUbiTC6Q=;
 b=JLIyT7iGSakrgC9vUr0MHCuCgf2KvK7W97AUnL8c3g+02L5E9+SUXbC7vUCBtBwVoZ
 9T4bu6KN1KHN8jBKkEYshuepPcpVtZresAvfSIKdkSDB8uG478V+teoppAUhNF8un7vy
 FCatc0UJEqAtPA2CCeA+PZuFUQQJ9SKeUCAWdNCdlBJVENJ/3zU/CqrUMH4ylAy3jF7U
 JOxM5P3HHEh/pfZjKusI8ri0DLnWYyy66+n2MzjouwS/8giw4/SYnpXq3dXTA+Tfk5sl
 cskNmF0mckon36QHdi3cjzif9kJERAytohNNjEDXx+kGPyv80aiP3ncCgSQ/fUVx3olY
 GvBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFOMneZ41lZPTdS414hjgy7Ifc2rFW2K4KJtDXF/RS9sGoZycj2qZZV81WLDX2TmrAoyjy8gB4iQ0Fpjq9ln6tp09m/9CB8Uiv7PsMdg==
X-Gm-Message-State: AOJu0Yz5iKAN8DXNkx01ncwO0lUBn9vsdw/1USGxCMsXYrNjqZdQiF4t
 oY+SnSTe4UCQ826cayx+UD/Zj2vkKzIIPhj8QInUQlmi42uSEIOf
X-Google-Smtp-Source: AGHT+IFrM1TdMvOYIMZ7ve6xPrgcaQzho/jCJrAzxKIJBhCfxBe8QP3I0T0RqtujZEoA5c0o1ZbHRg==
X-Received: by 2002:a5d:6b92:0:b0:34d:bbcf:1ef with SMTP id
 n18-20020a5d6b92000000b0034dbbcf01efmr8552319wrx.61.1715088434163; 
 Tue, 07 May 2024 06:27:14 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 z18-20020adff752000000b0034e19861891sm12961680wrp.33.2024.05.07.06.27.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 May 2024 06:27:13 -0700 (PDT)
Message-ID: <a6f3ce54-e6e2-41d2-b5b0-4b5c26659cc1@gmail.com>
Date: Tue, 7 May 2024 15:27:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Fix out-of-bounds write warning
To: Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com, Alexander.Deucher@amd.com
References: <20240506055901.227249-1-Jun.Ma2@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240506055901.227249-1-Jun.Ma2@amd.com>
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

Am 06.05.24 um 07:59 schrieb Ma Jun:
> Check the ring type value to fix the out-of-bounds
> write warning
>
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> Suggested-by: Christian König <christian.koenig@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index 15c240656470..ad49cecb20b8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -352,7 +352,7 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
>   	ring->max_dw = max_dw;
>   	ring->hw_prio = hw_prio;
>   
> -	if (!ring->no_scheduler) {
> +	if (!ring->no_scheduler && ring->funcs->type < AMDGPU_HW_IP_NUM) {
>   		hw_ip = ring->funcs->type;
>   		num_sched = &adev->gpu_sched[hw_ip][hw_prio].num_scheds;
>   		adev->gpu_sched[hw_ip][hw_prio].sched[(*num_sched)++] =

