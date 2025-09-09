Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A039CA0FED
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Sep 2025 08:17:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BF0910E64A;
	Tue,  9 Sep 2025 08:17:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="q50nA+kw";
	dkim-atps=neutral
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF3B710E236
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Sep 2025 08:17:41 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-3da4c14a5f9so3886452f8f.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 09 Sep 2025 01:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1757405860; x=1758010660;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6bIhnKcS3S70H3FZzFxNSCh5KKC75qWJ8QzD4ToSAuU=;
 b=q50nA+kwteKk+1OVZKAnJgmB9ACboZHFfbmfmcmJUPf2OyPkwMhZqoMj7Nc4QAL7Au
 KSJpNOWYQWzhkZ2VxLvOYpPiO6nqx3leJHBm7k3d2eumD+Vn64MDlhn6xIByhUgMhzWe
 KNrdgg1Dde0nua9+O+g0We2yAHYF6p7gh1psRMZC9BRZ+DKvLBzojQhapDDM6vP2M7AB
 atY8D0K+rIVTF1CMpc+kDLck09ep+irhmx8DEmE1llI0h2gpYQh53NnGPZCOM2odNwC9
 Yo3LD3wIumjOZ94zHzLqmGPUHCHJsCygedOjlyt7fYINKdYq5yZ03+M5EcR0V4DCnDn+
 CUGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757405860; x=1758010660;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6bIhnKcS3S70H3FZzFxNSCh5KKC75qWJ8QzD4ToSAuU=;
 b=JKrNOnmhLefCI2X+0KaubJDAVH1h+BLsrPgHjpVTqFfcM9xmw/3x8TCf7Gm0tQSrg2
 OiN4AFkNwDF6qRP5/JymD/Kq13iKFTXWUEIC5wjcz1GX+r1sFtbMv1qV1Pm0dJ/4QKQj
 TK3AtP56dBc1/Oi20fCjyWsIWvpyEbt23BiBXIRCGv5GNxVtuLrYdSO4qb0GdteeGmhL
 xs5nZCMiPg9znbpfxsBvKVierV+PXihQxmz63Y3EH+iSXb3ksh5t8t9CayJLUEZgK+E8
 jstwJ29jFo3gD0YvHuHSUdpOS7Y0jWQG9YVKm0HHp03CdABpT59xjRr93lfLDh6WgDuU
 FPvg==
X-Gm-Message-State: AOJu0Yy7/4JU9dmxG6OY0dtYBWijiHh674aVGDpTPw6qYNAawAs5qjRD
 NIP340rNFBq7mT2/sDiBoiS0RV8UeCZzBGyGg6JCYiArrPPeyjpcF4OB9Xs+M7+HdJ4=
X-Gm-Gg: ASbGncvmwEwnKdIilHLkFX0GmIduMzrtPiY9iZsKsQb6WgOYZRzzTTs5R3Rrc6rRni6
 d+xaj4W4oPR8zkyYBE0Ja0JwN8njw4UesFug0qHZH4ghV21schft4Mv+iWyumUwl/fTG9G1FNXC
 BAWNnYoOdyxSf4IK2blaXPEA+10c657yo2B7ZINSebdzHbkhDiNkZuuabeLUeoPvfcjePSjoq8K
 05xfnbn22toztW/vxi7fibwdqOshNpgv84R7YW4JkLgwtCb9GYQLSPZIwZvPeFSxdqbwSe/b9d1
 JY2AXKafd/shCTXYXow6cZH4/aQ9s5/Duz6n2AghP+ycpo8/7Am5S3Pjmav8G0nLXuMaXriZMDy
 kOU3Bb6Pc71G7U+0xdoECXcLOqnxKGt/jx4Q=
X-Google-Smtp-Source: AGHT+IGk/HS1vx4EfCGI4dFGwAuLXmkcrlGKuUZjVSXZ43a4gop7RXKKeI1Ok/7F2vR2eAlPxii3Yg==
X-Received: by 2002:a05:6000:178a:b0:3d8:3eca:a97d with SMTP id
 ffacd0b85a97d-3e6289efdafmr9689272f8f.11.1757405859678; 
 Tue, 09 Sep 2025 01:17:39 -0700 (PDT)
Received: from [192.168.0.101] ([84.66.36.92])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e752238851sm1551187f8f.29.2025.09.09.01.17.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Sep 2025 01:17:39 -0700 (PDT)
Message-ID: <4005498b-d866-4e41-a8a4-d8228b2062e7@ursulin.net>
Date: Tue, 9 Sep 2025 09:17:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Replace kzalloc + copy_from_user with
 memdup_user
To: Thorsten Blum <thorsten.blum@linux.dev>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20250908211559.519892-1-thorsten.blum@linux.dev>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20250908211559.519892-1-thorsten.blum@linux.dev>
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


On 08/09/2025 22:15, Thorsten Blum wrote:
> Replace kzalloc() followed by copy_from_user() with memdup_user() to
> improve and simplify ta_if_load_debugfs_write() and
> ta_if_invoke_debugfs_write().
> 
> No functional changes intended.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c | 20 ++++++--------------
>   1 file changed, 6 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
> index 38face981c3e..6e8aad91bcd3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
> @@ -171,13 +171,9 @@ static ssize_t ta_if_load_debugfs_write(struct file *fp, const char *buf, size_t
>   
>   	copy_pos += sizeof(uint32_t);
>   
> -	ta_bin = kzalloc(ta_bin_len, GFP_KERNEL);
> -	if (!ta_bin)
> -		return -ENOMEM;
> -	if (copy_from_user((void *)ta_bin, &buf[copy_pos], ta_bin_len)) {
> -		ret = -EFAULT;
> -		goto err_free_bin;
> -	}
> +	ta_bin = memdup_user(&buf[copy_pos], ta_bin_len);
> +	if (IS_ERR(ta_bin))
> +		return PTR_ERR(ta_bin);
>   
>   	/* Set TA context and functions */
>   	set_ta_context_funcs(psp, ta_type, &context);
> @@ -327,13 +323,9 @@ static ssize_t ta_if_invoke_debugfs_write(struct file *fp, const char *buf, size
>   		return -EFAULT;
>   	copy_pos += sizeof(uint32_t);
>   
> -	shared_buf = kzalloc(shared_buf_len, GFP_KERNEL);
> -	if (!shared_buf)
> -		return -ENOMEM;
> -	if (copy_from_user((void *)shared_buf, &buf[copy_pos], shared_buf_len)) {
> -		ret = -EFAULT;
> -		goto err_free_shared_buf;
> -	}
> +	shared_buf = memdup_user(&buf[copy_pos], shared_buf_len);
> +	if (IS_ERR(shared_buf))
> +		return PTR_ERR(shared_buf);
>   
>   	set_ta_context_funcs(psp, ta_type, &context);
>   

More complete than the one I sent in June^1.

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

I had some other in that series, not sure if you caught those.

Regards,

Tvrtko

1)
https://lore.kernel.org/amd-gfx/20250612104430.41169-1-tvrtko.ursulin@igalia.com/

