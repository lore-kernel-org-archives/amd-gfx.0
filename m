Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA7CC04FFE
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Apr 2024 09:50:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2549E10EA72;
	Fri, 19 Apr 2024 09:50:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ENuWIwFL";
	dkim-atps=neutral
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E64A110EA72
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Apr 2024 09:50:31 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-346359c8785so1485039f8f.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Apr 2024 02:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713520230; x=1714125030; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yla+M4GuxhcdFxRN8sHImRz1c40BgK8EcD7umKDMc0I=;
 b=ENuWIwFLwsWjl9Q1Pzv4T8+a5kxPVP/uGPeRkJZL+WV7/LfC41LfgapzKcjiL0Ssh4
 JGdPFCJkjKwlHtDTxhMC03PBGkRnfsXfyZgjZwJLfRayDa1E6j0T3b9o4zSYaJ6syurY
 JeEi7KF/fh5M41F9c49GdGq5DPQfzQ79g3lXkOKwV5BiaXB0gHPxCBrqLf7IBCt4P0al
 FDgCwLDT0nOrhD4EsFWspXHBssIHcvXb8E9d7T+rT9laE8rR6MAzaIyq4pfQTGa+n3ck
 ctJdcEpt4va/JOAzzfchj3TN/b85WNECpsPAs8CjmBNJeNS08O0fGTqAe06rPORq4iar
 4G6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713520230; x=1714125030;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yla+M4GuxhcdFxRN8sHImRz1c40BgK8EcD7umKDMc0I=;
 b=dKxayTY2Vvr6XU0dgXhZjHSYnAKheiNNksQalNrNBkJ+KLnxAImVH5bYeaaF+xZPOv
 EUOX8k98g175PRpi5FOXb6yP6II6fvoTP8XczKNYglFG1TPBLncAtMvIREgbMIOETFSW
 9SH/97bMWE43P52YPHwTFBMe0pn7xV3kdpVv6J2hcZkKAGuuRBg/3t+6jH9eqYpkCBpB
 drbwzamVUm5lL3yFT+1qM6KWDeld72gRwL/ieKQ+4U+gv8FiWgdtBbphWMWZEJq1WZmX
 F1xiSxjiNDi3V6gEAOFZqibIlAfQp6uAhxZSHSuixu+ioL+ewfXd+UDI6Uy2noe93v9O
 dZKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQLmNnVpBx+PAEkZfTHwM6P1d25/gvKzxAz1LzrTny+YLVpNKc3KyK7xn9BeTylYqNArMo09P3kNBnQ3yh9/H6sT8SKKkARWchhrTvHA==
X-Gm-Message-State: AOJu0YwYROOXpP3dcD9eZ60sjA3QnWyz6tIYv36QHc3yBBiTlJ4cQ4uh
 15eXJa0EdeBBwU2F4HNO5mGyrteIamnS4XmL0N1RaEKMQyi5pyHSOUPmyCV2
X-Google-Smtp-Source: AGHT+IHlMLe/Mu4pOMi/CwaB6RNa6Jxn2DfC2QyjFgvLrFAKGwM3gMkG3x4faLq0soILd1rSkpAt3w==
X-Received: by 2002:adf:ebcd:0:b0:346:14d2:fef6 with SMTP id
 v13-20020adfebcd000000b0034614d2fef6mr966130wrn.62.1713520229912; 
 Fri, 19 Apr 2024 02:50:29 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 n12-20020a5d67cc000000b0034a51283404sm1458291wrw.72.2024.04.19.02.50.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Apr 2024 02:50:29 -0700 (PDT)
Message-ID: <b7007a8f-a39b-47ed-a858-48a7bbf6db83@gmail.com>
Date: Fri, 19 Apr 2024 11:50:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/umsch: don't execute umsch test when GPU is in
 reset/suspend
To: Lang Yu <Lang.Yu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Veerabadhran Gopalakrishnan <Veerabadhran.Gopalakrishnan@amd.com>
References: <20240419075203.37194-1-Lang.Yu@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240419075203.37194-1-Lang.Yu@amd.com>
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

Am 19.04.24 um 09:52 schrieb Lang Yu:
> umsch test needs full GPU functionality(e.g., VM update, TLB flush,
> possibly buffer moving under memory pressure) which may be not ready
> under these states. Just skip it to avoid potential issues.
>
> Signed-off-by: Lang Yu <Lang.Yu@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
> index 06ad68714172..9f9d6a6d5cf3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
> @@ -774,6 +774,9 @@ static int umsch_mm_late_init(void *handle)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   
> +	if (amdgpu_in_reset(adev) || adev->in_s0ix || adev->in_suspend)
> +		return 0;
> +
>   	return umsch_mm_test(adev);
>   }
>   

