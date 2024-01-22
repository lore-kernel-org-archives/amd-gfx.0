Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C4E1C47DD3
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jan 2024 18:40:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8402F10EEE1;
	Mon, 22 Jan 2024 18:40:28 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99B0F10ED66
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jan 2024 18:40:27 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-40d6b4e2945so42104625e9.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jan 2024 10:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705948766; x=1706553566; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Dt6xvbmUyISYy2xEvArPMXDQv76v3ZmjGBt+tYNMDqY=;
 b=gKCXicM+ApeeGZsUkdDu4BOJzhoz/ELfSCK/9Q63UEohxPecahOQhKAWDFW5RaljdA
 4NtBmQYCet32Q1xFmuPBS4DyE3eG6zm++0JTk+bjdZesW5w4Ehlmq3S2vPsBw08AiJfd
 LhB289q3gL4e+1m5qwvNEebYbvFWlX6lz1p0G0s50Z64WBr1h7H9r0ZKMiHot5pBOY4N
 PTzDwe0mgIipy2XbxymfbaF82Y3+vy3dr2gj8137upnKXa6AqzgLTw6gVR3MG1Kl9VG+
 sUAjoSJk5rbDH94eqT/48nnuDd5q80rdgAb8XH0rgS8TTyUyFbuAL8Ryh2OMjT4CnK7f
 tqfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705948766; x=1706553566;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Dt6xvbmUyISYy2xEvArPMXDQv76v3ZmjGBt+tYNMDqY=;
 b=ZYa9hGD+qdOH6OtPv1hZUbzHkxWuaGnG3vrQ50LMgWTyMhKRAoiDIc9FKgk8CLaNad
 e7N4FfudC70Ocv3+6hIHeVi80iOJdTzViOqKfMJM6TqeOQzazj2+XxP31SaZWIgYRjrt
 dbVeBAGW0Flt9YKhaoeorNsP4fERHr1nM1wBkgPbls+pPNusbBmV/PoVtdmqIgeEL5+4
 90wg5THxKLfO0igj9SeksPFCcEZBMDtUcYCCnPHGOwjYdjg+nOKuRK4v5JGLGFUf+4V6
 GBpsiYKKFuE4VlW5NB6V6cBlykdzByiJgj2jDP/0iDX6CFiTTYehfMgFLuZqRUkGJdAQ
 fN3w==
X-Gm-Message-State: AOJu0Yw1mndi6kDJw1gmfezBdL9/XMc81KoEBOC5XTRk3zVx054wLtGq
 cF/T18mRnN9NS6Scoc7dfrJXkfOWAvAQ8lKKHJXqK3X/osDR38Ew+DgBBgPy
X-Google-Smtp-Source: AGHT+IHU1/kUplYfjHHVp3C7NlObbdmPTXK7BYATDXkZ4R6FrzOcUZYWbTxw25xEhVakT8GZjcMUYw==
X-Received: by 2002:a05:600c:3787:b0:40e:6206:a518 with SMTP id
 o7-20020a05600c378700b0040e6206a518mr1601557wmr.184.1705948765814; 
 Mon, 22 Jan 2024 10:39:25 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 h5-20020a05600c314500b0040d7c3d5454sm43896623wmo.3.2024.01.22.10.39.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jan 2024 10:39:25 -0800 (PST)
Message-ID: <c9311e26-102c-45c1-93d4-f09ef3348183@gmail.com>
Date: Mon, 22 Jan 2024 19:39:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/pptable: convert some variable sized arrays to
 [] style
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240122160010.1132083-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240122160010.1132083-1-alexander.deucher@amd.com>
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

Am 22.01.24 um 17:00 schrieb Alex Deucher:
> Replace [1] with [].  Silences UBSAN warnings.
>
> Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2039926
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/include/pptable.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/include/pptable.h b/drivers/gpu/drm/amd/include/pptable.h
> index ef3feb0b6674..2e8e6c9875f6 100644
> --- a/drivers/gpu/drm/amd/include/pptable.h
> +++ b/drivers/gpu/drm/amd/include/pptable.h
> @@ -658,7 +658,7 @@ typedef struct _ATOM_PPLIB_SAMClk_Voltage_Limit_Record
>   
>   typedef struct _ATOM_PPLIB_SAMClk_Voltage_Limit_Table{
>       UCHAR numEntries;
> -    ATOM_PPLIB_SAMClk_Voltage_Limit_Record entries[1];
> +    ATOM_PPLIB_SAMClk_Voltage_Limit_Record entries[];
>   }ATOM_PPLIB_SAMClk_Voltage_Limit_Table;
>   
>   typedef struct _ATOM_PPLIB_SAMU_Table

