Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2461C0015E
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Jul 2023 13:01:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F82C10E251;
	Mon, 17 Jul 2023 13:01:00 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5E2A10E226
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Jul 2023 10:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689589623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QcjXX5GWlegc91aegHozDG5ys9NXk4J7QfyGnNAR82g=;
 b=XrpZPjAsl8mA7ZAChOz1BPW2utDsrTt6W0f0wLIkGDy7RKO8FekuySZ6xmU+/0l2b/WrdZ
 UbDp1rDD2Ylm2q5KuxrTEwqeHD3q0mvKAOj3Vqf2Aqfhw9UT8z5BAoZAEHiY2fMGnK29HR
 ZktIiR5/LJDY0BS79YUN8cln1t31U0w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-y3Dn0OR7O8Oq28rp0wYRxw-1; Mon, 17 Jul 2023 06:27:02 -0400
X-MC-Unique: y3Dn0OR7O8Oq28rp0wYRxw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3fc07d4c2f4so25252555e9.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Jul 2023 03:27:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689589621; x=1692181621;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QcjXX5GWlegc91aegHozDG5ys9NXk4J7QfyGnNAR82g=;
 b=WPET5JJCKcY/7nh6AlgLPHypC4rZR3n9ylpHIzCj79a7BVEnW6abTCtcUCMWtNqddX
 hYAFD0k+EVEJEdoBG3/Ja8rWs2/nhnLP1EKY8sXvFADBJdrCvEwMfzEV3rIk7XEEiW02
 g4kthCowz4dSNGJSz1CZXomnKdDvPQEVv9WijoqRTZwWpwiZM9YNkGfki7ZaEbguAg0K
 +9qIMvqUqsxYNLUL/DwOvf9L8MF1rCIEk29E8Fyl23SoSr17tRt3y7clu1fM20YImyBf
 hbdo5SNPgvVjIRqYr/bVqIrnQtHo5sz5msu3jkvmHhSeH7hdhMSpzwxLq49CYkwCo6Rk
 svxw==
X-Gm-Message-State: ABy/qLY2rc339ptkCv967Xn36ldfGuFNCAWV1kAiKIJgkQtm416AoDHu
 ZHgZ2OGCwMJ/jMRPNEZ3jBmG0pfcCvbRXQ0RwzU5kEUdJjEhhtRs/q2BqXjyyxDdN6GmehAndlf
 JfHAIQm9QOQAB8QQAptDl1gzfew==
X-Received: by 2002:a5d:6a49:0:b0:314:2c17:d921 with SMTP id
 t9-20020a5d6a49000000b003142c17d921mr10297825wrw.38.1689589621623; 
 Mon, 17 Jul 2023 03:27:01 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHg4QSrt7ASwOV1fEBcNK4Q/NKk0aYoKscyfvU06BxfjAob7ZBV5ewkV0pAvLD46ImkfH0r8w==
X-Received: by 2002:a5d:6a49:0:b0:314:2c17:d921 with SMTP id
 t9-20020a5d6a49000000b003142c17d921mr10297812wrw.38.1689589621295; 
 Mon, 17 Jul 2023 03:27:01 -0700 (PDT)
Received: from ?IPV6:2003:cb:c735:400:2501:5a2e:13c6:88da?
 (p200300cbc735040025015a2e13c688da.dip0.t-ipconnect.de.
 [2003:cb:c735:400:2501:5a2e:13c6:88da])
 by smtp.gmail.com with ESMTPSA id
 v16-20020a5d4b10000000b003143be36d99sm18839549wrq.58.2023.07.17.03.27.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jul 2023 03:27:00 -0700 (PDT)
Message-ID: <4a7feeb3-0c9e-0dba-1023-4f0ae1bfe471@redhat.com>
Date: Mon, 17 Jul 2023 12:26:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/5] mm: introduce vma_is_stack() and vma_is_heap()
To: Kefeng Wang <wangkefeng.wang@huawei.com>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20230712143831.120701-1-wangkefeng.wang@huawei.com>
 <20230712143831.120701-2-wangkefeng.wang@huawei.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230712143831.120701-2-wangkefeng.wang@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 17 Jul 2023 13:00:58 +0000
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
 linux-fsdevel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 12.07.23 16:38, Kefeng Wang wrote:
> Introduce the two helpers for general use.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>   include/linux/mm.h | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 1462cf15badf..0bbeb31ac750 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -926,6 +926,18 @@ static inline bool vma_is_anonymous(struct vm_area_struct *vma)
>   	return !vma->vm_ops;
>   }
>   
> +static inline bool vma_is_heap(struct vm_area_struct *vma)
> +{
> +       return vma->vm_start <= vma->vm_mm->brk &&
> +		vma->vm_end >= vma->vm_mm->start_brk;
> +}
> +
> +static inline bool vma_is_stack(struct vm_area_struct *vma)
> +{
> +       return vma->vm_start <= vma->vm_mm->start_stack &&
> +	       vma->vm_end >= vma->vm_mm->start_stack;
> +}
> +
>   static inline bool vma_is_temporary_stack(struct vm_area_struct *vma)
>   {
>   	int maybe_stack = vma->vm_flags & (VM_GROWSDOWN | VM_GROWSUP);

Looking at the comments in patch #3, should these functions be called

vma_is_initial_heap / vma_is_initial_stack ?

-- 
Cheers,

David / dhildenb

