Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B0C7C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Apr 2024 09:05:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 567D010E663;
	Tue, 16 Apr 2024 09:05:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="i9YxSaBr";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E73710E663
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Apr 2024 09:05:04 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-3481bb34e7dso389386f8f.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Apr 2024 02:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713258302; x=1713863102; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ERDESXdourK6FWFdcwXqd9Ks4cdjRteeFDLNIJpYIYs=;
 b=i9YxSaBr1ErFCwMbT4OqXWX+ukeKixY/pxMbVbpYDBGBnNtBexKYAhNHXFKJKI5TNb
 bAqaCiLRuqLWKj7HP085poHxlMVDVt1aImIeld51J8M/LNaJHkBDG/zkCdcbCrK0iicY
 v0zI6Iav9yKcMMz1G0r6I0RtxK5HP6zP/rz1G84mS0tp+QVBBB7u8x7IDF+sAM21qNnm
 gGVW454WvT5xKqyh3RlNSeDp4AxzJe6LVbXB9Em5hRkv7nJPVpzT0CkTlIKPW0hQn8w4
 FYiXfTv2vCC3KHhNrHiCedS/BQvjGiZRn2WNek55iPy3S9ZQjm3THuq6TcAOYnXPelmZ
 mJsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713258302; x=1713863102;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ERDESXdourK6FWFdcwXqd9Ks4cdjRteeFDLNIJpYIYs=;
 b=dD9+dAPXQ19U8To4Orca6YXHbWUltMbIwxQkSnqS88TXm9A017aHI7VLWkVF8iggcg
 Dl7fMMll7uJ/UH0+wJEWvweNnAuDRgaPzsZ915AV4tz6GLTSRH7H8GAb6Nmczh+cDzow
 zYnNzaSpuzsdIgCC0rqnUcUcB6v9vVlinWb5+lSh7oqxSLm3xrI+N2uMefRMMlNwueHv
 fEA4yxNCuoHWFYMLVkhkumqH1cveTTtdBhQCSaPoAfmxWN4+IMmOH0fH4np9oGpREerO
 1wNjU2Utn906diyZfTsCuUpjvMCvNvSh2uhyK06aJuDwhwqE5kKCr9KuACI+SzvotsCR
 OvWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpOlS1fxh5HJ6WyzjDW/ymcHEdFA3+0YVKIYgmnAnl/eKF7R32to8erk7HRmdoY3IvNiKT1mYKgMAdj6a02RyQKswbEfHvcX46gPGJig==
X-Gm-Message-State: AOJu0Yz9DeUIk+OYnXelSvLvxxQTIrX4JtxFEQz2N+P1KGZu27yFO+Xm
 FKXEtflr4Jtx0S2osiDN0tRwAoS9ak2vCd0kprGRxl1BbrBnNHyJ
X-Google-Smtp-Source: AGHT+IEAxyRqOdlFwMo/m7B0iYmoEXeD8g+q3Hn5LQwhkB2KdQEEHCzacOj8r2BbroBYq4ndHHzKCw==
X-Received: by 2002:a5d:6106:0:b0:343:9b68:d9a3 with SMTP id
 v6-20020a5d6106000000b003439b68d9a3mr8106130wrt.64.1713258302365; 
 Tue, 16 Apr 2024 02:05:02 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 t7-20020adfe447000000b00343eac2acc4sm14297595wrm.111.2024.04.16.02.05.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Apr 2024 02:05:02 -0700 (PDT)
Message-ID: <662576a5-4597-4a3e-bead-4b80852eb19c@gmail.com>
Date: Tue, 16 Apr 2024 11:05:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: clear seq64 memory on free
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, alexander.deucher@amd.com
References: <20240415184837.299965-1-Arunpravin.PaneerSelvam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240415184837.299965-1-Arunpravin.PaneerSelvam@amd.com>
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

Am 15.04.24 um 20:48 schrieb Arunpravin Paneer Selvam:
> We should clear the memory on free. Otherwise,
> there is a chance that we will access the previous
> application data and this would leads to an abnormal
> behaviour in the current application.

Mhm, I would strongly expect that we initialize the seq number after 
allocation.

It could be that we also have situations were the correct start value is 
0xffffffff or something like that instead.

Why does this matter?

Regards,
Christian.

>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
> index 4b9afc4df031..9613992c9804 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
> @@ -189,10 +189,14 @@ int amdgpu_seq64_alloc(struct amdgpu_device *adev, u64 *va, u64 **cpu_addr)
>   void amdgpu_seq64_free(struct amdgpu_device *adev, u64 va)
>   {
>   	unsigned long bit_pos;
> +	u64 *cpu_addr;
>   
>   	bit_pos = (va - amdgpu_seq64_get_va_base(adev)) / sizeof(u64);
> -	if (bit_pos < adev->seq64.num_sem)
> +	if (bit_pos < adev->seq64.num_sem) {
> +		cpu_addr = bit_pos + adev->seq64.cpu_base_addr;
> +		memset(cpu_addr, 0, sizeof(u64));
>   		__clear_bit(bit_pos, adev->seq64.used);
> +	}
>   }
>   
>   /**

