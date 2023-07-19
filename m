Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4145C001B0
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jul 2023 12:12:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C97BE10E47C;
	Wed, 19 Jul 2023 12:12:39 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30FF410E425
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jul 2023 08:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689754723;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WssQg9iV0YySJw5yTj4rTXaeROV2bWX6ZiqkxpcpXZY=;
 b=hphdHnmNkSWqp7GBjGritiXcy9Cvdp04ydSfqyoxPPKKkNv3WvvaPgSqFCwWCn7hT2qhmJ
 C5CgkS+AyqVsGvyiTjp5w28v7BhezaXKS8tskbnbRx3CNu23XxVRa0SwwxGdWvpdt6ylnC
 7bMZXyFeATe7cjeEsG0G2P2J3SN3lR4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-2kqdxQFBOQ6stjKTRGIkLg-1; Wed, 19 Jul 2023 04:18:40 -0400
X-MC-Unique: 2kqdxQFBOQ6stjKTRGIkLg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f41a04a297so37491215e9.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jul 2023 01:18:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689754719; x=1692346719;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WssQg9iV0YySJw5yTj4rTXaeROV2bWX6ZiqkxpcpXZY=;
 b=MmvJAbjTf/a9L83nrD0Qdz9WRcNJvAj2s00KenqbIBLsOVshs8vsvjVoYIDT6VM8n0
 eBcyR6y1RPdrKlZfX/z4c4Uxrvk+0ENmpsxpnXF2tpoJUz5Lbj9GWF73bn3soGGYfu8+
 dhyto4a7tFuCjLxrM2rTuhD+WDjzvQs+FGriWG5rcBQ1EHhJF57RLSJSJBf+etLePe/v
 PWlIIv6t05o8doUbx0JUBlAfuTnkSilqnldWW2C7ZQyXuHZXuMRE2/nqduxian0xnKSF
 p5+rUA8Zukd19VYZI8Sp+wfC6NpkSaJ7MBEHo3xREY67H97Tydc2hSL3WRRikmuOxWQB
 1lbg==
X-Gm-Message-State: ABy/qLZgV8k7R0PoVFZUYQn3KNpABYwR4zTEGKGkXiSo8HFdPhmI+rlG
 RqRjPQ4jmJW6srs4PtiLxnTSRsBAu8DVTg30gfICKiGJ9jodcxINzdbZ1D7pQSvnG9cQU7LDtPL
 spEtk6O2leephq2LXXMsBwUhMyg==
X-Received: by 2002:a05:6000:196c:b0:313:e9d7:108f with SMTP id
 da12-20020a056000196c00b00313e9d7108fmr1523223wrb.33.1689754719290; 
 Wed, 19 Jul 2023 01:18:39 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG4mVtD6KPNWpna0uoP5njNw9A2AvVcDer/KJcrmJqawn0BMPkdBDdKHedf8gqslDrAWE1usQ==
X-Received: by 2002:a05:6000:196c:b0:313:e9d7:108f with SMTP id
 da12-20020a056000196c00b00313e9d7108fmr1523206wrb.33.1689754718915; 
 Wed, 19 Jul 2023 01:18:38 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74b:4f00:b030:1632:49f2:63?
 (p200300cbc74b4f00b030163249f20063.dip0.t-ipconnect.de.
 [2003:cb:c74b:4f00:b030:1632:49f2:63])
 by smtp.gmail.com with ESMTPSA id
 n6-20020a5d67c6000000b0030e5bd253aasm4592215wrw.39.2023.07.19.01.18.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Jul 2023 01:18:38 -0700 (PDT)
Message-ID: <149bdc44-eba1-1615-dd12-c3c324426dca@redhat.com>
Date: Wed, 19 Jul 2023 10:18:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 2/4] drm/amdkfd: use vma_is_initial_stack() and
 vma_is_initial_heap()
To: Kefeng Wang <wangkefeng.wang@huawei.com>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20230719075127.47736-1-wangkefeng.wang@huawei.com>
 <20230719075127.47736-3-wangkefeng.wang@huawei.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230719075127.47736-3-wangkefeng.wang@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 19 Jul 2023 12:12:37 +0000
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
Cc: selinux@vger.kernel.org, Felix Kuehling <Felix.Kuehling@amd.com>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-perf-users@vger.kernel.org,
 linux-mm@kvack.org, amd-gfx@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, linux-fsdevel@vger.kernel.org,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 19.07.23 09:51, Kefeng Wang wrote:
> Use the helpers to simplify code.
> 
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian König" <christian.koenig@amd.com>
> Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 5ff1a5a89d96..0b7bfbd0cb66 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -2621,10 +2621,7 @@ svm_range_get_range_boundaries(struct kfd_process *p, int64_t addr,
>   		return -EFAULT;
>   	}
>   
> -	*is_heap_stack = (vma->vm_start <= vma->vm_mm->brk &&
> -			  vma->vm_end >= vma->vm_mm->start_brk) ||
> -			 (vma->vm_start <= vma->vm_mm->start_stack &&
> -			  vma->vm_end >= vma->vm_mm->start_stack);
> +	*is_heap_stack = vma_is_initial_heap(vma) || vma_is_initial_stack(vma);
>   
>   	start_limit = max(vma->vm_start >> PAGE_SHIFT,
>   		      (unsigned long)ALIGN_DOWN(addr, 2UL << 8));

Certainly a valid refactoring, although questionable if such code should 
care about that.

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

