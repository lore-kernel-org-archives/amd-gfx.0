Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4A05CCF9FF
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Oct 2025 10:35:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73E3110EAFF;
	Fri, 31 Oct 2025 10:35:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="MgQAUrWh";
	dkim-atps=neutral
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB83610EB00
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 10:35:07 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-426fd62bfeaso974969f8f.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 03:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1761906906; x=1762511706;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PdrymPQFa+0z7DHo2EakNjMe5XtHWaGvX1vPpLrRBxs=;
 b=MgQAUrWhtLtsLnGDlEJZ0w6b8b/VqkB+F1C8UGSHJcxxsqfqvxaJfyJn+KbkN2l6/r
 tr31BXj7lXqZ4fmx1CbgKp48EWvdsAm08mDsXkDQZYwm8pKlm4hnilDBHVN/svVjfrUj
 zX+4vLsyusKLd16vVPjhXg2cW9ZBF4HyX3BZHhKyVR8b4N7v7njLJtlEXkPoaDEJBb3G
 0otGfsqEsmwyfDu7HQntV6tp7fH03XswxnZQT42obMojwBxPybiS3AQrNG9iD11ssopS
 eCHHOl9CUYgpEn0J1NN4cxKxjCxl2/t6GNd86herjsnYxiE42aOGQ8JB/VJ/PcgDn/h3
 zAWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761906906; x=1762511706;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PdrymPQFa+0z7DHo2EakNjMe5XtHWaGvX1vPpLrRBxs=;
 b=jz2IrvCfDjgJqThciOdgxNx/ORk5DlLhCgPI4RoHQB3EzLvCHYUXfRlZwEPJaTbxqm
 Fb/h6slKqjWiSnoGarqv7chb5SA0Qmif7JoxMXogdz+xVhHfHHg8G+VQ4U4HxXsUZVCT
 wXWwaHnMDh2nf+/fYknJPxQa3Gt8MkOjaxByzArGNrKmFqkAmSpbY7Q4uPL7Xb3SQkVs
 Ipq/r0modV6aIzt2/77mnl4kqPgXBZop6gw+r+c6txR4IPfmYrVDPRCa3d6m2QeJJkq1
 k6LNEzW+bZBF0y/qL00FGsiKbNE4c0+MngtoUpqPGaTUa9M8Y08ZQqE2uslx9CCbe1AL
 VZqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtDdyNzWQm+sSjqkDWBqLksjqx5RNTrHTH/iJFK84YXzd/jV0oDpbFE3KUc/FiCMvF/GlbdHKQ@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx6uosWtIITl4SbM1GKKmPT8Dvrg4nj6GifFMDlQx+x7uHEu+5L
 mYVY4eNMPkkRDtNaW2Bg1YC8KBw79nTEkN63XU4Xp0ozR0THcWxgqMHNXPLAKgeeODI=
X-Gm-Gg: ASbGncuhhQzaTgBegQydpN1CUBPZqdIpSTfla1E86lkrmwUrADBF3YFA5sN3YlIuPXY
 w+98okBAT0Xbw70gTgNEdQxkAqrQQKGgG2ptLrznUrJz7Jmxojpbf8U38SBYbQdroF0YR/OfpT9
 0s1QNCozPVWAROEYMV+PWDGr55GdiWSET9AT2Z7gJ7xQlvPBh8R9dGCpr6ONphl4omIn41xHi4y
 Wv9HPHkvFckwUm5U/10mL2jli6oIa/OMZamUQT2AC5pVpdAxYwhYf4yp9EjP96Ae3lJZAc+NbVc
 idArG2YEO17ko6K7hVqR3mDwGZ2Y/Kkpy/p97wOZ1nym/60BZNfWjNG4isAVa026wJG75/I3hMp
 rDIi3TRjQ1ykgUMFnciBAq3A4FMXVYsjTZWKvkf1juh6/k5aTVV0FPSyMTGr+SZWriGNWuNzIU3
 WU+OhhVYoqCzR4lKgGOD12dnAs1v0=
X-Google-Smtp-Source: AGHT+IEbXjZwVZ0BRz6eKPRreWtcxs3tBkrOmZ3nSlwbUYhE9YCNIcCaf2kqw06sBQspAX6iWIdKEw==
X-Received: by 2002:a05:6000:18a5:b0:427:a34:648c with SMTP id
 ffacd0b85a97d-429bd6efbbdmr2615765f8f.58.1761906906340; 
 Fri, 31 Oct 2025 03:35:06 -0700 (PDT)
Received: from [192.168.0.101] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c1125ad0sm2882917f8f.13.2025.10.31.03.35.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Oct 2025 03:35:05 -0700 (PDT)
Message-ID: <332f1009-1371-4287-8726-f7b875cadd03@ursulin.net>
Date: Fri, 31 Oct 2025 10:35:05 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/15] dma-buf: protected fence ops by RCU
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 phasta@mailbox.org, alexdeucher@gmail.com, simona.vetter@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
References: <20251013143502.1655-1-christian.koenig@amd.com>
 <20251013143502.1655-4-christian.koenig@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20251013143502.1655-4-christian.koenig@amd.com>
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


One additional comment on this patch:

On 13/10/2025 14:48, Christian König wrote:
> At first glance it is counter intuitive to protect a constant function
> pointer table by RCU, but this allows modules providing the function
> table to unload by waiting for an RCU grace period.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/dma-buf/dma-fence.c | 65 +++++++++++++++++++++++++++----------
>   include/linux/dma-fence.h   | 18 ++++++++--
>   2 files changed, 62 insertions(+), 21 deletions(-)
> 

8><

> @@ -1104,11 +1127,14 @@ EXPORT_SYMBOL(dma_fence_init64);
>    */
>   const char __rcu *dma_fence_driver_name(struct dma_fence *fence)
>   {
> +	const struct dma_fence_ops *ops;
> +
>   	RCU_LOCKDEP_WARN(!rcu_read_lock_held(),
>   			 "RCU protection is required for safe access to returned string");
>   
> +	ops = rcu_dereference(fence->ops);
>   	if (!test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags))
> -		return fence->ops->get_driver_name(fence);
> +		return ops->get_driver_name(fence);
>   	else
>   		return "detached-driver";
>   }
> @@ -1136,11 +1162,14 @@ EXPORT_SYMBOL(dma_fence_driver_name);
>    */
>   const char __rcu *dma_fence_timeline_name(struct dma_fence *fence)
>   {
> +	const struct dma_fence_ops *ops;
> +
>   	RCU_LOCKDEP_WARN(!rcu_read_lock_held(),
>   			 "RCU protection is required for safe access to returned string");
>   
> +	ops = rcu_dereference(fence->ops);

For the above two functions, the RCU_LOCKDEP_WARN now becomes redundant 
to the one rcu_dererence() would emit. Maybe just move the string into a 
comment?

Regards,

Tvrtko

>   	if (!test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags))
> -		return fence->ops->get_driver_name(fence);
> +		return ops->get_driver_name(fence);
>   	else
>   		return "signaled-timeline";
>   }
