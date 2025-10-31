Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 053FCCCF9FF
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Oct 2025 14:04:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99B4B10EBBE;
	Fri, 31 Oct 2025 14:04:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="N0j2r3SI";
	dkim-atps=neutral
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1979C10EBBE
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 14:04:51 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-429bccca1e8so786431f8f.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 07:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1761919489; x=1762524289;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EvtlwaHzYZFon2EgJ07/XN/tqKyRiHx0hAYzd9XK+Ng=;
 b=N0j2r3SIGpNRBh+G294wlVgWH/VK9LhtHzh0cI1jwTOoLtKQJ/6vdUkploU7nvBugV
 NT/jTwf5NnLF7STtE4AN2qRez2Ytjy/iGYLB49Ufq7ob5E45+2TizJkitLRpM3aZEpMG
 e2ZiTIaR6zpOKFjhcDMVTfSY1UD6AqCZeq6hUF0LSQykdvQmKlzfMoM4OwrgtpEgPhHR
 CKNWbod5JR9bi7MQRdiCjCKAF4nWfNId+p7aCLof+TxqULF267/+lY0epBFjn/tnR/JN
 Ztnu3h+yWZLuh1XGtJNN/+vnm89PWqlt3p8R76lm+5IcavCWFHZCaqeyzEO1uwzjeg4G
 5kcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761919489; x=1762524289;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EvtlwaHzYZFon2EgJ07/XN/tqKyRiHx0hAYzd9XK+Ng=;
 b=i0fz1Pc031nC5667mgd7YbdtSHaY6aq1SHIbD60UnLyLGC4a/FLcEtPhNQFrovOe1S
 2VjNcV755Lh9ac5Vg2zIXJ5y2jVQE1ubModcDS0vxQf5KVVI8vIIb6duQDr4KquvZcgP
 jEtgF/23Ffcc3/HM6EBH3C3fc2I2UKJWgX7cSzyVJUAwNf1JwOdxdkJPE8DeNaF4EeRG
 ZtKTetjIpqjv7pdDFOKnTcGtVbAYwI4yHRciETrjzSwSBmR38J1Xr2MG/Qq9d6uJ2Br2
 5xchoA2Pk1/wJzra8ThzC2YIK6/p0FzRbcsa9yrNIGv6VRKDyhKQ/cppW6te/qX/wiDJ
 1UWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWm9ggTQhdMgX8rvMO5QO/Nra9bvMm1NwtB/0U0Je2fR8lbLaDkLfW7q8mUcrL7YDHvb9fXXB8B@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwNF5P/oC1mGU0DklaLI4pa1TuGRFvPucR/BDMv/hj4/rgQ9HsJ
 Vm8Dx2CfZoMYzGIaJscKWBZMdSvV0DnJo8ro+jvv+trvXLiZZ/Q0ym7/p+HZF8xsUWo=
X-Gm-Gg: ASbGncvrCfXQHQ7trdVr6lIzFMZykG4L+urAEQDos7vfS+SKgPHhoIY2QR+IIvi8B2o
 MVze94lUIy6LkS+ZPYsfeWta81nlN0XAoJivoU09yhLWtEsRcmKAfpcaZxKxHhya4q3bp7IMqGj
 w1ZyX8qb1EPvb9RLhL65JDOAIRp80vKkHve2l2d7WvKzSJg5YJTQA0TFVGXeKGgzZAOIgpUIipt
 GGlkJcYGAlo7hMGbaZ9eQUJ8e07LX/YwzwJ94Lfb9wqrHLoxdmsBVD8cvfGZvDt2aiix+zqK5tT
 Sf2X8Baqi2dz9qGf4YM4R7hslt9RI432VZQw3Z1ClyxwhUdRAP2Tir2MHI4P3FuR7Fvy93cvmhO
 e5ZN9m4lr/IPKGqP8iYbt8QZiuHoeXe8uO6lhCmR1JIZ9EY0RrXuXL6zLLNvAX1k+gxuAOXytym
 ggeyeLZQOZsLTcmxt2Ms5/I3P2y8Tidx84+L5oJQ==
X-Google-Smtp-Source: AGHT+IGObFhC16xfu3Obyo7XhIAOD/LALuiRq/UGanygaAQhLt+0iZTdhGL7NioIT2ZrhmOghKsAbQ==
X-Received: by 2002:a5d:5d0a:0:b0:427:53e:ab33 with SMTP id
 ffacd0b85a97d-429bd6a8f33mr2952256f8f.48.1761919489158; 
 Fri, 31 Oct 2025 07:04:49 -0700 (PDT)
Received: from [192.168.0.101] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c54efcadsm391434f8f.5.2025.10.31.07.04.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Oct 2025 07:04:48 -0700 (PDT)
Message-ID: <8625b51f-df50-4a77-9737-9e71755c2c53@ursulin.net>
Date: Fri, 31 Oct 2025 14:04:48 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/20] dma-buf: cleanup dma_fence_describe v2
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 phasta@mailbox.org, alexdeucher@gmail.com, simona.vetter@ffwll.ch,
 airlied@gmail.com, felix.kuehling@amd.com, matthew.brost@intel.com
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
References: <20251031134442.113648-1-christian.koenig@amd.com>
 <20251031134442.113648-2-christian.koenig@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20251031134442.113648-2-christian.koenig@amd.com>
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


On 31/10/2025 13:16, Christian König wrote:
> The driver and timeline name are meaningless for signaled fences.
> 
> Drop them and also print the context number.
> 
> v2: avoid the calls when the BO is already signaled.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/dma-buf/dma-fence.c | 19 ++++++++++---------
>   1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
> index 39e6f93dc310..cfa6ddcc1278 100644
> --- a/drivers/dma-buf/dma-fence.c
> +++ b/drivers/dma-buf/dma-fence.c
> @@ -999,19 +999,20 @@ EXPORT_SYMBOL(dma_fence_set_deadline);
>    */
>   void dma_fence_describe(struct dma_fence *fence, struct seq_file *seq)
>   {
> -	const char __rcu *timeline;
> -	const char __rcu *driver;
> +	const char __rcu *timeline = "";
> +	const char __rcu *driver = "";
> +	const char *signaled = "";
>   
>   	rcu_read_lock();
>   
> -	timeline = dma_fence_timeline_name(fence);
> -	driver = dma_fence_driver_name(fence);
> +	if (!dma_fence_is_signaled(fence)) {
> +		timeline = dma_fence_timeline_name(fence);
> +		driver = dma_fence_driver_name(fence);
> +		signaled = "un";
> +	}
>   
> -	seq_printf(seq, "%s %s seq %llu %ssignalled\n",
> -		   rcu_dereference(driver),
> -		   rcu_dereference(timeline),
> -		   fence->seqno,
> -		   dma_fence_is_signaled(fence) ? "" : "un");
> +	seq_printf(seq, "%llu %s %s seq %llu %ssignalled\n", fence->context,
> +		   timeline, driver, fence->seqno, signaled);

I still prefer my version, so if I am allowed to bike shed:

  a) %llu:%llu for context:seqno to align with the tracepoints would 
have been nicer.
  b) Why move the driver name in the middle of the timeline and seqno?
  c) Signalled case will have triple space which is odd.

But it's debugfs so who cares.

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko

>   
>   	rcu_read_unlock();
>   }

