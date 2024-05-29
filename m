Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 092FEC25B75
	for <amd-gfx@archiver.kernel.org>; Wed, 29 May 2024 08:55:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 859DF1128DD;
	Wed, 29 May 2024 08:55:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XSioYxAh";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 225701128DD
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 May 2024 08:54:58 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4201986d60aso14465735e9.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 May 2024 01:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716972896; x=1717577696; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rxLOB9Xau18b97ZtO5VA5+IEOnQ56ULmPxb+x+2vz+o=;
 b=XSioYxAhQbn3JCEMtUABs7HMNlfDuq/00KPgoU8KSFTMcGXBErL+abikNxAG4JJIKk
 8kczz6HyLmZb9A8I5Sa333tZ6Sn9OJhmLlq3tpKLvpCrtS0LwIRJNuh8TSVtL4pniAg4
 SvyOb9M20vyk1ZtmnTtNActjxxIocJ/jFmpNEg0vfryYovXVDi5D5ZHqRDzilAu5Bnwi
 eSe5M8rw1OOYeBJAa6erwx7buzTOdjLTWQSLZHjCM0OMjW9ts6wkWU+EjiMq+lJ+SvX/
 bJV7qwvn0zIX1KGvDiv2ie9VFOKrfNkGl68dU4ohgkzvh3oyGqYXHcpeBAhtQCv3N++5
 NniQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716972896; x=1717577696;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rxLOB9Xau18b97ZtO5VA5+IEOnQ56ULmPxb+x+2vz+o=;
 b=Fy24FYNBw7kzaPBHA/oZyO6vV7KjAjK+qHXo/w4+SkmY39m7+jcm1xzU6EsvaiZeYu
 LsdyjpxfoRhb23R9+Th5DaitRWsFjESew5h7wXemehgLALvXdwDZu8tgsH1TTovIkeG5
 vQmaaM/NPG3ZBHtc9Af7Ze5f+hd7wf+CXOV9iD8zA8zu6y2R4ZP/XMTapRCKITmQnlkz
 zDADnKW6DaJna/eCNH2ElpFypVpY5hKCg+snQ5EahDHJZDyA0ktp1VRPbTgvbbZPV3FR
 R4lsTXtq0599EtMBO4+NgLlX3kMgSD5+7zjiAUXP1CWqROpKF89z36+j7AmOUiAZGkCK
 h+KA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVE2va+6S1x2nbFIckdpZRJ1DxmDIC7b6wsFvkLTfjRwLN2oKFAozkAsZzrhlOuJpRgYsTVXoFd61FIOqrtevS/2jghldZmOIyNPOJcpA==
X-Gm-Message-State: AOJu0YyTJHRTgeT6w/0yJcMHwDwRiTU3MSuX8XcldsKwqr0NyJE6ysEE
 6BOMkTdu2nmTICQZYUs6oy95EdKP/Be87s8EBaVufNbRww4Ej8yLepRjaUod
X-Google-Smtp-Source: AGHT+IHobuDA5KEyEToERh2AWhSDP0rm4e8dtdUmboXtQYTS7olns60cf/Q+sAUYzTuBel6ibH+0Mg==
X-Received: by 2002:a05:600c:568d:b0:420:139e:9eda with SMTP id
 5b1f17b1804b1-421089d3318mr114078845e9.12.1716972896348; 
 Wed, 29 May 2024 01:54:56 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-421252b6e66sm5898565e9.26.2024.05.29.01.54.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 May 2024 01:54:55 -0700 (PDT)
Message-ID: <11c8a300-b262-49e7-983e-6b9ecff0e3d5@gmail.com>
Date: Wed, 29 May 2024 10:54:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/14] drm/amdgpu: add nbio set_reg_remap helper
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix Kuehling <felix.kuehling@amd.com>
References: <20240506184539.1669157-1-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240506184539.1669157-1-alexander.deucher@amd.com>
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

Acked-by: Christian König <christian.koenig@amd.com> for the whole series.


Am 06.05.24 um 20:45 schrieb Alex Deucher:
> Will be used to consolidate reg remap settings and fix HDP
> flushes on systems with non-4K pages.
>
> Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
> index 7b8c03be1d9e7..f61d117b0cafe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
> @@ -102,6 +102,7 @@ struct amdgpu_nbio_funcs {
>   	u32 (*get_memory_partition_mode)(struct amdgpu_device *adev,
>   					 u32 *supp_modes);
>   	u64 (*get_pcie_replay_count)(struct amdgpu_device *adev);
> +	void (*set_reg_remap)(struct amdgpu_device *adev);
>   };
>   
>   struct amdgpu_nbio {

