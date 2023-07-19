Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B87AC001B0
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jul 2023 12:12:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9938B10E46B;
	Wed, 19 Jul 2023 12:12:38 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A40F210E427
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jul 2023 08:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689754875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lHNdzhJYXIyEvVVXeSxx/4ftxohEVfyVH2IVByUb0ic=;
 b=H+85tU3l/XL2ySiw1RieVnRnd6OaOXcXMdxqg8OZbdp7J3klrQm/jrs9qEseqh4gA5bo04
 sIapRpQfiAJMLpDN63kSjdesp2Yq5gp+i5V8RVQd7I6RlHmIqjuEyYLzFcNKps/wIZvV+f
 BX1dVl8n3OyO6l0yLwelTperNImAVrQ=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-qgl5zl7XOJmw7AIphItnKw-1; Wed, 19 Jul 2023 04:21:14 -0400
X-MC-Unique: qgl5zl7XOJmw7AIphItnKw-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-4fb76659d44so5671775e87.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jul 2023 01:21:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689754873; x=1692346873;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lHNdzhJYXIyEvVVXeSxx/4ftxohEVfyVH2IVByUb0ic=;
 b=iMmsiqGNhXOw067TGjVr/9oQ4ygLRgkwpXm2gBup6TYsWcMncHR3rsmp2bsh0uFFsj
 Y9pcZx5OlxVrB5fQTxV73KKdL+REyQvnBG5266ZzaH+670lbCvGuTXg29BrtS2RWaSo2
 usziFXs7zudrj6Rz7vr/2Rn1eRmAE544eHf10PrTWLwR3QzqYh5OgN2XtvR/pQ2BE+nB
 NHTco0fLsmG2yaVlmdWW9+empUXFIxrB3tUQu3bdijvVUREP4i4yT8HP54ex2JSneYqS
 0qSKIL/9tdht3rYItnuFrUnNqGRtdcgz9zZ2vdc4cvGgnvdVTzIvkV9GdchC20smH3LC
 Ic8A==
X-Gm-Message-State: ABy/qLZXFEmgHE8qoFNLctnyoakU8n8id0mnVGXnXo3rkuU0e4lPFMU0
 s5D3HTw6Mxw8USe6o9TEwNgAo8A9CeJ+5rE0jGOiWogsGGsoQPOgptPrAJXK+K/3qr8WDM+gsBW
 1hhv9tJ8o6f7ExdIYuw//dYAvMA==
X-Received: by 2002:a05:6512:750:b0:4fb:8cc0:57e3 with SMTP id
 c16-20020a056512075000b004fb8cc057e3mr1188129lfs.62.1689754872991; 
 Wed, 19 Jul 2023 01:21:12 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFai0n0RcKXdiYpXZ+aojTS7Ksd/OHMwbJ10bIJdz+36AnhayvLRUmFZjEcfE4R/uLtmx1AWQ==
X-Received: by 2002:a05:6512:750:b0:4fb:8cc0:57e3 with SMTP id
 c16-20020a056512075000b004fb8cc057e3mr1188110lfs.62.1689754872632; 
 Wed, 19 Jul 2023 01:21:12 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74b:4f00:b030:1632:49f2:63?
 (p200300cbc74b4f00b030163249f20063.dip0.t-ipconnect.de.
 [2003:cb:c74b:4f00:b030:1632:49f2:63])
 by smtp.gmail.com with ESMTPSA id
 7-20020a05600c230700b003fba6709c68sm1048356wmo.47.2023.07.19.01.21.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Jul 2023 01:21:12 -0700 (PDT)
Message-ID: <0dc0e6b5-4c07-2ae3-80d3-99a5386c8f7d@redhat.com>
Date: Wed, 19 Jul 2023 10:21:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 4/4] perf/core: use vma_is_initial_stack() and
 vma_is_initial_heap()
To: Kefeng Wang <wangkefeng.wang@huawei.com>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20230719075127.47736-1-wangkefeng.wang@huawei.com>
 <20230719075127.47736-5-wangkefeng.wang@huawei.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230719075127.47736-5-wangkefeng.wang@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
 linux-mm@kvack.org, Peter Zijlstra <peterz@infradead.org>,
 amd-gfx@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 19.07.23 09:51, Kefeng Wang wrote:
> Use the helpers to simplify code, also kill unneeded goto cpy_name.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>   kernel/events/core.c | 22 +++++++---------------
>   1 file changed, 7 insertions(+), 15 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 78ae7b6f90fd..d59f6327472f 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -8685,22 +8685,14 @@ static void perf_event_mmap_event(struct perf_mmap_event *mmap_event)
>   		}
>   
>   		name = (char *)arch_vma_name(vma);
> -		if (name)
> -			goto cpy_name;
> -
> -		if (vma->vm_start <= vma->vm_mm->start_brk &&
> -				vma->vm_end >= vma->vm_mm->brk) {
> -			name = "[heap]";
> -			goto cpy_name;
> +		if (!name) {
> +			if (vma_is_initial_heap(vma))
> +				name = "[heap]";
> +			else if (vma_is_initial_stack(vma))
> +				name = "[stack]";
> +			else
> +				name = "//anon";
>   		}
> -		if (vma->vm_start <= vma->vm_mm->start_stack &&
> -				vma->vm_end >= vma->vm_mm->start_stack) {
> -			name = "[stack]";
> -			goto cpy_name;
> -		}
> -
> -		name = "//anon";
> -		goto cpy_name;

If you're removing that goto, maybe also worth removing the goto at the 
end of the previous if branch.

Reviewed-by: David Hildenbrand <david@redhat.com>


-- 
Cheers,

David / dhildenb

