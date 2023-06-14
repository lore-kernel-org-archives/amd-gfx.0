Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 039E3EB64D8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jun 2023 12:51:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD22E10E25B;
	Wed, 14 Jun 2023 12:51:33 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACBCE10E25B
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jun 2023 12:51:31 +0000 (UTC)
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-9768fd99c0cso129063066b.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jun 2023 05:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686747088; x=1689339088;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OHnv8FXXrMFJit6OkBaiCVLo1lhSoqg03YDvVs22Z3I=;
 b=pCMVDp6fEUsOXWmlKhdO1d9tUv5Xx3QGryUDweVBkUiGTHhzuOFUgXOIwf933rwQeS
 ctKFT8hTu9n3WQJQ759jJVadVL/9xib1AYADVrhNgTzsE6qvR36nizdHzXjgVVeIFKqC
 lzXgEhCAWXVoxb3R27pLtU7CmJR2HPZixnWiXmmQV94O2XbUOq6hhRK2a3RsmZ/qB9ab
 3+3b0tY7FTff4hqjWNEglJ5Gx7HhmpyXZSOPHsQxMWaO2NDmZ1ensSJPy8k02GCLxdlb
 XNyd6xz/4C2ZSbvGBX4ETHvRFfimhP0FrHguAV64syD5JihdRhEVbLpfhrSMJZsrCPak
 eVLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686747088; x=1689339088;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OHnv8FXXrMFJit6OkBaiCVLo1lhSoqg03YDvVs22Z3I=;
 b=jhQq1/LMIJBxn971CiP/tDhphYzPA2M+Ne/P43/Y9uE0FmO5/4JGtNe0vVdnDb8u9T
 TcwxL9BOyIgExzEkALdjZbyGA5c7txyRUS6NNUggqhjiFmJW5FUFirCQ9EaYuUcmG5fm
 cE7DDkvww6McgOrfya3AgEdQlWdLzAqcmlq3ifiFWIX69jretOx6nJp+8UNyBWUCb777
 Z1J765qFR1T9wChV29IDkMJWkeQd8xRrq74bLim3eFtMf2/93xUxoCPx6gziz/hJ2wMJ
 OZW9mAfDabZMC3XO0INoYlb0l8oCcacEU8KVGWTtZrn876fnY1BWDIxNawHCIEy5YoE5
 w0CA==
X-Gm-Message-State: AC+VfDxDen/kdg8dXSHKNGukvbXp5s1Z3zJcwtDzRfajCk+nrj4SklpX
 0TkPL+a0OM+mrH89AJcFEBA=
X-Google-Smtp-Source: ACHHUZ7n1P7O0uhURqbkOuzqZ50UYM5Ktrj5XIQw8PCifjc1mxh8G2CN6v6Tpj107VkIU72F6X7/Ww==
X-Received: by 2002:a17:907:96a0:b0:978:af9d:c004 with SMTP id
 hd32-20020a17090796a000b00978af9dc004mr1760818ejc.4.1686747088037; 
 Wed, 14 Jun 2023 05:51:28 -0700 (PDT)
Received: from ?IPV6:2a00:e180:15e4:4200:3c54:f73b:1892:7271?
 ([2a00:e180:15e4:4200:3c54:f73b:1892:7271])
 by smtp.gmail.com with ESMTPSA id
 f13-20020a170906494d00b0097461fecc91sm7954119ejt.81.2023.06.14.05.51.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Jun 2023 05:51:27 -0700 (PDT)
Message-ID: <cca52290-bd13-e9e9-297c-e480acaef782@gmail.com>
Date: Wed, 14 Jun 2023 14:51:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdgpu: add amdgpu_timeout_ring_* file to debugfs
Content-Language: en-US
To: =?UTF-8?Q?Nicolai_H=c3=a4hnle?= <nicolai.haehnle@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230614112758.120429-1-nicolai.haehnle@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230614112758.120429-1-nicolai.haehnle@amd.com>
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

Am 14.06.23 um 13:27 schrieb Nicolai Hähnle:
> Report the per-ring timeout in milliseconds and allow users to adjust
> the timeout dynamically. This can be useful for debugging, e.g. to more
> easily test whether a submission genuinely hangs or is just taking very
> long, and to temporarily disable GPU recovery so that shader problems
> can be examined in detail, including single-stepping through shader
> code.
>
> It feels a bit questionable to access ring->sched.timeout without any
> locking -- under a C++ memory model it would technically be undefined
> behavior. But it's not like a lot can go wrong here in practice, and
> it's not clear to me what locking or atomics, if any, should be used.

Uh, that's very dangerous what you do here and wouldn't work in a whole 
bunch of cases.

First of all GPU recovery is part of normal operation and necessary for 
system stability. So disabling GPU recovery is actually not a good idea 
in the first place.

We already discussed that we probably need to taint the kernel if we do 
so to indicate in crash logs that the system is not considered stable 
any more. The problem was only that there wasn't an agreement on how to 
do this.

Since this here now makes it even easier to disable GPU recovery it's 
probably not the right approach.

Regards,
Christian.

>
> Signed-off-by: Nicolai Hähnle <nicolai.haehnle@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 32 +++++++++++++++++++++++-
>   1 file changed, 31 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index dc474b809604..32d223daa789 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -471,35 +471,65 @@ static ssize_t amdgpu_debugfs_ring_read(struct file *f, char __user *buf,
>   
>   	return result;
>   }
>   
>   static const struct file_operations amdgpu_debugfs_ring_fops = {
>   	.owner = THIS_MODULE,
>   	.read = amdgpu_debugfs_ring_read,
>   	.llseek = default_llseek
>   };
>   
> +static int amdgpu_debugfs_timeout_ring_get(void *data, u64 *val) {
> +	struct amdgpu_ring *ring = data;
> +
> +	if (ring->sched.timeout == MAX_SCHEDULE_TIMEOUT)
> +		*val = 0;
> +	else
> +		*val = jiffies_to_msecs(ring->sched.timeout);
> +
> +	return 0;
> +}
> +
> +static int amdgpu_debugfs_timeout_ring_set(void *data, u64 val) {
> +	struct amdgpu_ring *ring = data;
> +
> +	if (val == 0)
> +		ring->sched.timeout = MAX_SCHEDULE_TIMEOUT;
> +	else
> +		ring->sched.timeout = msecs_to_jiffies(val);
> +
> +	return 0;
> +}
> +
> +DEFINE_DEBUGFS_ATTRIBUTE(amdgpu_debugfs_timeout_ring_fops,
> +			 amdgpu_debugfs_timeout_ring_get,
> +			 amdgpu_debugfs_timeout_ring_set,
> +			 "%llu\n");
> +
>   #endif
>   
>   void amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
>   			      struct amdgpu_ring *ring)
>   {
>   #if defined(CONFIG_DEBUG_FS)
>   	struct drm_minor *minor = adev_to_drm(adev)->primary;
>   	struct dentry *root = minor->debugfs_root;
> -	char name[32];
> +	char name[40];
>   
>   	sprintf(name, "amdgpu_ring_%s", ring->name);
>   	debugfs_create_file_size(name, S_IFREG | S_IRUGO, root, ring,
>   				 &amdgpu_debugfs_ring_fops,
>   				 ring->ring_size + 12);
>   
> +	sprintf(name, "amdgpu_timeout_ring_%s", ring->name);
> +	debugfs_create_file(name, S_IFREG | S_IRUGO | S_IWUSR, root, ring,
> +			    &amdgpu_debugfs_timeout_ring_fops);
>   #endif
>   }
>   
>   /**
>    * amdgpu_ring_test_helper - tests ring and set sched readiness status
>    *
>    * @ring: ring to try the recovery on
>    *
>    * Tests ring and set sched readiness status
>    *

