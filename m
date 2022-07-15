Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8261AC43334
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jul 2022 08:48:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E62AE10FA81;
	Fri, 15 Jul 2022 08:48:21 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44ED410FA81
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jul 2022 08:48:19 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id y4so5434062edc.4
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jul 2022 01:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=ebalBoyynqkzx5DKYZ09sSPp8bCz31fpp2YDdA8iQ5Y=;
 b=O6KRVIvsfmJ8Bln/JIsn1WMgp/vrR3Eb52IgMtE5Y4ECF7eXjhBd+LackHLk38BeBO
 MKUC0lpHdF7DLjmVnm4bUvf7uTtSIN5mtQvwnWw0dX31+TEThsmU8GqaQYkULKmSSH1Q
 vNyhwEr2PF8KL8U5toF0xCDbbo0kjKU6ylIkWordqEFHXMdQnGFNB3sC0DmDa0FBO/hc
 9HGXbFWgGe/FUNiqip/5EwrrxLYSolIwQISew/Hbgk1NRrchV58xEjU6W/jjeKPQC2ms
 bWFQDFU9mv4/8p3VcjWhbyG9FIggLI5oAXbXXx7dLrnHDYMQYukfAF3E5HU+IFFYXI4O
 seGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=ebalBoyynqkzx5DKYZ09sSPp8bCz31fpp2YDdA8iQ5Y=;
 b=QMHzh0uTsBwMJNYGlfzoxCoMV9WStUHZIuN7LZAtxeHfQ0C8txJnxg2pDsiJWIKEKo
 2HqcW6ttEWeANwv8LT9PbS2+dJGi+p402WMvvchLfApUwlwrNlvumF48TU6RsmbAbxMX
 N9z+USJadOOzJjohfsPJyAM63fpDPsllYo9RGtlGorBv4TDo4uYSovM4X7C7pULYmOLn
 Uo0SYnn7uJz6CYcNNzm2uiZ8GGm0J9ywXu/5ZQF6khjvkZDKu8mTXXTpbx7+JW8fn72B
 VBw3wG3mTdD3ue0VzpZeCtUhxOQDYN4tOieOdwLU8yO8lx6Un90s3bMHoQOXgqs1PcZt
 ucfg==
X-Gm-Message-State: AJIora/t1ZEkBlwACNX4WyhgsBPNyzvpv0JTbu6K8Dp6YmAd5c+1L1c/
 XRjVjCtXBvBvZK1Cf74ytvY=
X-Google-Smtp-Source: AGRyM1t8Tjl0BlpduVJAZOQyTd9mMu5BFf2olUjhiHn+rhAOpxDqDdgpLTO7fwPSmj3Az6zX2nYRgQ==
X-Received: by 2002:a05:6402:5508:b0:43a:896e:8edd with SMTP id
 fi8-20020a056402550800b0043a896e8eddmr17288837edb.203.1657874897590; 
 Fri, 15 Jul 2022 01:48:17 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:8bc3:ed7a:c741:f27c?
 ([2a02:908:1256:79a0:8bc3:ed7a:c741:f27c])
 by smtp.gmail.com with ESMTPSA id
 z13-20020aa7d40d000000b0043adc6552d6sm2376006edq.20.2022.07.15.01.48.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Jul 2022 01:48:17 -0700 (PDT)
Message-ID: <7ca91143-9da1-4fc4-0cde-268705764e42@gmail.com>
Date: Fri, 15 Jul 2022 10:48:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 3/3] drm/amdgpu: skip put fence if signal fails
Content-Language: en-US
To: jiadong.zhu@amd.com, amd-gfx@lists.freedesktop.org,
 Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
References: <20220715084356.427458-1-Jiadong.Zhu@amd.com>
 <20220715084356.427458-3-Jiadong.Zhu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220715084356.427458-3-Jiadong.Zhu@amd.com>
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
Cc: Ray.Huang@amd.com, aaron.liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 15.07.22 um 10:43 schrieb jiadong.zhu@amd.com:
> From: "Jiadong.Zhu" <Jiadong.Zhu@amd.com>
>
> Dma_fence_signal returning non-zero indicates
> that the fence is signaled and put somewhere else.
> Skip dma_fence_put to make the fence refcount correct.

Well quite a big NAK on this.

Reference counting should be completely independent where a fence signals.

Andrey can you take a look at this as well?

Thanks,
Christian.

>
> Signed-off-by: Jiadong.Zhu <Jiadong.Zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index f4ed0785d523..93c1a5e83835 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1500,8 +1500,8 @@ static void amdgpu_ib_preempt_signal_fences(struct dma_fence **fences,
>   		fence = fences[i];
>   		if (!fence)
>   			continue;
> -		dma_fence_signal(fence);
> -		dma_fence_put(fence);
> +		if (!dma_fence_signal(fence))
> +			dma_fence_put(fence);
>   	}
>   }
>   

