Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CD2BCA0FFD
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Sep 2025 10:13:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 090AD10E40F;
	Mon,  1 Sep 2025 10:13:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="a1hcQ268";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E09D710E40F
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Sep 2025 10:13:48 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-45b869d35a0so10162355e9.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Sep 2025 03:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1756721627; x=1757326427;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=81d5joX+qr1QpDIakoIkCPcwgxBYkYKdo9qnYzZJgXI=;
 b=a1hcQ268hwDguyfvLvWVNmj0ABHeW5gnxOydsDqlbJOi8EcSJqbYqcn/I2govcLA+H
 P16UAcXTHqf8slKC1qWZm+o5/M7q8P5C0/Wo0uB7pkcHVhikoIH7dyApBfat/Lp4wybs
 //wBZo07wCqsxtEO51itmtO1NZhigqYUn3dgDO0HtzCSEdWSHeczj8ghY+lp61I82icv
 l3VUSH7/KGh+YfUBvNbUtnnhAwYlFx9nUW1YvB0/X2hnBAQsMc+KrENlDxCBbMUf31Hs
 AtbES+LAtEjEnm9mCGMnF08wsIXu/nMzxVm8pnzl/g9lT7BbR07On8vVwptu2muC0V7a
 1T+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756721627; x=1757326427;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=81d5joX+qr1QpDIakoIkCPcwgxBYkYKdo9qnYzZJgXI=;
 b=U9o/Ty9VbtY+nh8TQPnIOokQUJhDLdzW7i8kC7jd1UGZ8rr8HU9VIn7X9xCZsKisY2
 7skOP/Ay2+qOTK5dodqWHDvKQsvwveZ7Z9RBfAzdqdd2tyo+6JeLAEF2djDGVOfJgnFv
 04U1uu7CeBf7mf+CLcF0amnuCC8h3KwD2i3/I3KtJwJa9xKHker1AAY27qAaNKZaVXib
 9DtTqqsas0STZtMhzMJcFxMEhRMU8QUnHg153kYhNog6B6rLTrcNIKC9ukBDZ7zDbX9g
 K0rfDREWMRKYK6tCQ4yR4VmQaxd2Cr5iRMKqZLsr7kYuX1+7exlvpvXaZ+iYBgDkgTgK
 j6kA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2iF1ZrbBFP9aeB1O4vz7O/1BG1e6Ddsomb57YCCCKa17g/HX0iZlJMOt3JvtB7zY61UKmyQuE@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxHhX7CLTuyqXwZgTr9Fo7DcyOZbN2BHhSM6YSSOg+18N/89oAR
 HZtrjStcgdY8P42KJ5cmgG3a/L5XhxWK4ZlQXmZ6fCQLAkxly6pp1SRtwWgRP3d4HVw=
X-Gm-Gg: ASbGncuSmozMvCIPw1q3CvQAh2QUPUY1jSu1BT9J5bW3NinS5L/sxB4jqVUQaIihJ/I
 Fz/Zz9QTXMWdlKFKQ73Wsh+nxA70qByAx/1K1bMOHPvNNbD/QYxT6FE6PwMlaIv3XE9G/N++mej
 WUTbxzjUNoyQmuArtgNiY97spOEFzkbNWYwv62iMW5YUZg8iR0D9by6UqkgM50V1D7d9r29F1ci
 ghyQ6huY263gh31sNATJCWXPwq0AhmplxfpeAuOGi9GJT2XTt21CoxQ6ZIJ5YhhNlHqLHd22TGH
 iyBNKkI56VcfyTC6EfHuU7SDxqpZ81pm550tBS0vdEwTAoyAR6Ki5PRB4V6G72lm9f7LJI8ax70
 FoUUQnu2nmq9AoKcaWjOSBvpXtvGii5E5QRQc/G0UZyfxUw==
X-Google-Smtp-Source: AGHT+IHCM7ACgR36Q9+XI3NFO9MiztrpT+qHGLVtJuizYwM/L+cN1AElgDtN8nDTxTFjIoUp4qZelQ==
X-Received: by 2002:a05:600c:3b28:b0:456:201a:99f with SMTP id
 5b1f17b1804b1-45b8730d443mr53857735e9.18.1756721627071; 
 Mon, 01 Sep 2025 03:13:47 -0700 (PDT)
Received: from [192.168.0.101] ([84.66.36.92])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f0c72f8sm232212565e9.3.2025.09.01.03.13.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 03:13:46 -0700 (PDT)
Message-ID: <9d3566f4-9ede-4d4c-8849-2ccac3fa65a6@ursulin.net>
Date: Mon, 1 Sep 2025 11:13:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] drm/amdgpu: Fill extra dwords with NOPs
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com
References: <20250901100012.439155-1-timur.kristof@gmail.com>
 <20250901100012.439155-3-timur.kristof@gmail.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20250901100012.439155-3-timur.kristof@gmail.com>
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


Hi,

On 01/09/2025 11:00, Timur Kristóf wrote:
> Technically not necessary, but clear the extra dwords too,
> so that the command processors don't read uninitialized memory.
> 
> Fixes: c8c1a1d2ef04 ("drm/amdgpu: define and add extra dword for jpeg ring")
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 7670f5d82b9e..6a55a85744a9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -474,6 +474,11 @@ static inline void amdgpu_ring_clear_ring(struct amdgpu_ring *ring)
>   	while (i <= ring->buf_mask)
>   		ring->ring[i++] = ring->funcs->nop;
>   
> +	/* Technically not necessary, but clear the extra dwords too,
> +	 * so that the command processors don't read uninitialized memory.
> +	 */
> +	for (i = 0; i < ring->funcs->extra_dw; i++)
> +		ring->ring[ring->ring_size / 4 + i] = ring->funcs->nop;

Should I resend this maybe?

commit 11b0b5d942fe46bfb01f021cdb0616c8385d5ea8
Author: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Date:   Thu Dec 26 16:12:37 2024 +0000

     drm/amdgpu: Use memset32 for ring clearing

     Use memset32 instead of open coding it, just because it is
     a tiny bit nicer.

     Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
     Cc: Christian König <christian.koenig@amd.com>
     Cc: Sunil Khatri <sunil.khatri@amd.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h 
b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index dee5a1b4e572..96bfc0c23413 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -369,10 +369,7 @@ static inline void 
amdgpu_ring_set_preempt_cond_exec(struct amdgpu_ring *ring,

  static inline void amdgpu_ring_clear_ring(struct amdgpu_ring *ring)
  {
-       int i = 0;
-       while (i <= ring->buf_mask)
-               ring->ring[i++] = ring->funcs->nop;
-
+       memset32(ring->ring, ring->funcs->nop, ring->buf_mask + 1);
  }

  static inline void amdgpu_ring_write(struct amdgpu_ring *ring, uint32_t v)

Looks like with two loops it would made even more sense to consolidate.

Regards,

Tvrtko

>   }
>   
>   static inline void amdgpu_ring_write(struct amdgpu_ring *ring, uint32_t v)


