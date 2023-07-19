Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E8C7C001DE
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jul 2023 12:12:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DBD910E473;
	Wed, 19 Jul 2023 12:12:44 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2013010E424
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jul 2023 08:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689754686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MmVR/bllIudc94xa/30s1JGUSnUJtFWF09nSa97ATdk=;
 b=TkvMVbjFo+6H8ZozwyHZXCW44Y/Hvq1Awj8HnEDATCSDeoQPwp1MtKofuRo/iGMmlyciyK
 K4h+M9dWPzPMOkDF3EJTslfzjGkzNeekdG6bWCPpa6ONmtoxn6BuoVb4aKO3laN5rpYr/7
 kBXKjZ67J3nEv005FRPgiftBnI4s4xA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-cWvJr7iCOx-cLPuhm8OkUw-1; Wed, 19 Jul 2023 04:18:05 -0400
X-MC-Unique: cWvJr7iCOx-cLPuhm8OkUw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-314326f6e23so3686297f8f.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jul 2023 01:18:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689754684; x=1692346684;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MmVR/bllIudc94xa/30s1JGUSnUJtFWF09nSa97ATdk=;
 b=XnYq4EWdJl05tBFtXN9ymbjuO57czD18tRoQ40LkK+3dH3mrou07Oc0wB9JYKk7VIm
 BLIszq7mhmSZ7VpyxxvMDbKyKkfF3Zml7dhYSqyQstx+xoAwWguVzDOJ58wukUIQSRQJ
 /oHVQK3tcaCTHWxq/QqmQGEIzGaen2Hk1nlOqiJv51jvSqG4BdLAqnHWuHXvjDdEo48C
 yWLrUvN5S5ZmF7JGqNtQEfxJxcqz+5THFD0Jcg5Wp6e8ilBcSmLhJs7FxX1QKOTO1FCC
 HYG80Gs2M2yx8IziMv8tuEVeZoTNY3ki61ihl114pJngt8YIZZ8/PeVrf5drXDIXTr8P
 kj4g==
X-Gm-Message-State: ABy/qLawlo/HRz1ux22RI5oFdQQfpcUXgKSoRDaUYQ4atIMUTt3Xyx5q
 Yk6lbj//nnDb/N6zv4pZhgxllm8Df6XouTWf9oRfz/zaP8gcdJ/5oUu0W4GHrorUoW1RasWlMOW
 lGE5Bz7DfiPmkgPI67ha60jbJlw==
X-Received: by 2002:adf:fe49:0:b0:314:1ca4:dbd9 with SMTP id
 m9-20020adffe49000000b003141ca4dbd9mr13566757wrs.27.1689754683963; 
 Wed, 19 Jul 2023 01:18:03 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF49g1Vta7mjhC1+bf3quUqv/nXAVqJtAkEUDjFA8Ku+wnpSH62a3c0EOossUbfX4CpB0nijg==
X-Received: by 2002:adf:fe49:0:b0:314:1ca4:dbd9 with SMTP id
 m9-20020adffe49000000b003141ca4dbd9mr13566743wrs.27.1689754683589; 
 Wed, 19 Jul 2023 01:18:03 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74b:4f00:b030:1632:49f2:63?
 (p200300cbc74b4f00b030163249f20063.dip0.t-ipconnect.de.
 [2003:cb:c74b:4f00:b030:1632:49f2:63])
 by smtp.gmail.com with ESMTPSA id
 n10-20020a5d51ca000000b00314398e4dd4sm4588195wrv.54.2023.07.19.01.18.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Jul 2023 01:18:03 -0700 (PDT)
Message-ID: <456a78ae-5d7e-9955-5edb-f9f46c22bd75@redhat.com>
Date: Wed, 19 Jul 2023 10:18:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 1/4] mm: factor out VMA stack and heap checks
To: Kefeng Wang <wangkefeng.wang@huawei.com>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20230719075127.47736-1-wangkefeng.wang@huawei.com>
 <20230719075127.47736-2-wangkefeng.wang@huawei.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230719075127.47736-2-wangkefeng.wang@huawei.com>
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
Cc: selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-perf-users@vger.kernel.org,
 linux-mm@kvack.org, amd-gfx@lists.freedesktop.org,
 linux-fsdevel@vger.kernel.org,
 =?UTF-8?Q?Christian_G=c3=b6ttsche?= <cgzones@googlemail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 19.07.23 09:51, Kefeng Wang wrote:
> Factor out VMA stack and heap checks and name them
> vma_is_initial_stack() and vma_is_initial_heap() for
> general use.
> 
> Cc: Christian Göttsche <cgzones@googlemail.com>
> Cc: David Hildenbrand <david@redhat.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---


[...]

> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 2dd73e4f3d8e..51f8c573db74 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -822,6 +822,27 @@ static inline bool vma_is_anonymous(struct vm_area_struct *vma)
>   	return !vma->vm_ops;
>   }
>   

Worth adding a similar comment like for vma_is_initial_stack() ?

> +static inline bool vma_is_initial_heap(const struct vm_area_struct *vma)
> +{
> +       return vma->vm_start <= vma->vm_mm->brk &&
> +		vma->vm_end >= vma->vm_mm->start_brk;
> +}
> +
> +/*
> + * Indicate if the VMA is a stack for the given task; for
> + * /proc/PID/maps that is the stack of the main task.
> + */
> +static inline bool vma_is_initial_stack(const struct vm_area_struct *vma)
> +{
> +	/*
> +	 * We make no effort to guess what a given thread considers to be
> +	 * its "stack".  It's not even well-defined for programs written
> +	 * languages like Go.
> +	 */
> +       return vma->vm_start <= vma->vm_mm->start_stack &&
> +	       vma->vm_end >= vma->vm_mm->start_stack;
> +}
> +
>   static inline bool vma_is_temporary_stack(struct vm_area_struct *vma)
>   {
>   	int maybe_stack = vma->vm_flags & (VM_GROWSDOWN | VM_GROWSUP);

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

