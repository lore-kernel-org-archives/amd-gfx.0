Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EF21C001E0
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jul 2023 12:12:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94B8010E487;
	Wed, 19 Jul 2023 12:12:46 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E7A710E426
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jul 2023 08:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689754741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A3PRF01yQKk/5cZ5BWUeGIVek1A+ZScaFRNRxy8v7WU=;
 b=HbL+PnSYQMWXQyxZK69h8iU3a4RSI0ZacPI8dKea9r8/CtqTK1yd4cMEsrKzOe1oVeI6us
 jQ6w7Rwidq7zR9Pws2bP+O0NHf5QjJy+8/pIfCnBZM1pyBgyYXEOCvxDGh7tQ3Fj1aWTFC
 8FtON6xNDn4uyM/nn+iNNHBXKU+67OY=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-niGAaI1gOYmciHxvhwllpg-1; Wed, 19 Jul 2023 04:18:59 -0400
X-MC-Unique: niGAaI1gOYmciHxvhwllpg-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-4fb736a7746so5516534e87.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jul 2023 01:18:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689754738; x=1692346738;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=A3PRF01yQKk/5cZ5BWUeGIVek1A+ZScaFRNRxy8v7WU=;
 b=I/hHvxlipS3FQDTTAaFuaJrbWPVmZDyBvT18VuTC6nNkhljiL+GsoGLmjiawpr4c/V
 IO2ToUrVVbixxdjR+2QD/EGDRXLR2HlimhHmxKexp9XztEDtdhgDgRjRbMXHEoGl0h2A
 62ptKn4w+RdTJ8Jn63kctymSZfChL2EOYmJ04KB9ifWAJRLXuYjCwHcRWJc+xmJ2sJQa
 kaye1wSjN/IH6cWCGkCBfvjs2T+mpRDst1odmJm1EC+emj0Iw5U2zIwQxTRe+p8vnAir
 /V5c5zQGGEAU9VHP4ixtv4cqsTTgFlG9XAPyOJGOua/Md6Patzim9QkrO7p2lwpjUlec
 rAtA==
X-Gm-Message-State: ABy/qLbxVhbTuGjizxJp/gAG7E9bDTOvxYJPpU9mM9bHNTwwsDEZ3Uqh
 7NY9IlJr0YTWa2D1Qb3a/aeDDYpSuNYcnwqv+HXaf1yZlkjf9tkrp4eZtplaLddEQRoJpZtde2J
 i95OrEbBfwIR9sNuHuqEO072R4Q==
X-Received: by 2002:a05:6512:5c1:b0:4f8:83f:babe with SMTP id
 o1-20020a05651205c100b004f8083fbabemr11169521lfo.62.1689754737884; 
 Wed, 19 Jul 2023 01:18:57 -0700 (PDT)
X-Google-Smtp-Source: APBJJlElWbEEQS6wB/sXWEw3o9coLgNkRyP67VSBFnN2SP6jtQCcIg6AEec+Q116/3HBCGy4e/xB8A==
X-Received: by 2002:a05:6512:5c1:b0:4f8:83f:babe with SMTP id
 o1-20020a05651205c100b004f8083fbabemr11169502lfo.62.1689754737550; 
 Wed, 19 Jul 2023 01:18:57 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74b:4f00:b030:1632:49f2:63?
 (p200300cbc74b4f00b030163249f20063.dip0.t-ipconnect.de.
 [2003:cb:c74b:4f00:b030:1632:49f2:63])
 by smtp.gmail.com with ESMTPSA id
 u6-20020a05600c00c600b003fbb5142c4bsm1075458wmm.18.2023.07.19.01.18.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Jul 2023 01:18:57 -0700 (PDT)
Message-ID: <251edad7-e169-2118-e8e0-e8d4781d5a9c@redhat.com>
Date: Wed, 19 Jul 2023 10:18:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 3/4] selinux: use vma_is_initial_stack() and
 vma_is_initial_heap()
To: Kefeng Wang <wangkefeng.wang@huawei.com>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20230719075127.47736-1-wangkefeng.wang@huawei.com>
 <20230719075127.47736-4-wangkefeng.wang@huawei.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230719075127.47736-4-wangkefeng.wang@huawei.com>
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
Cc: Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org,
 Stephen Smalley <stephen.smalley.work@gmail.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-perf-users@vger.kernel.org,
 linux-mm@kvack.org, amd-gfx@lists.freedesktop.org,
 linux-fsdevel@vger.kernel.org, Eric Paris <eparis@parisplace.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 19.07.23 09:51, Kefeng Wang wrote:
> Use the helpers to simplify code.
> 
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
> Cc: Eric Paris <eparis@parisplace.org>
> Acked-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>   security/selinux/hooks.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index d06e350fedee..ee8575540a8e 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3762,13 +3762,10 @@ static int selinux_file_mprotect(struct vm_area_struct *vma,
>   	if (default_noexec &&
>   	    (prot & PROT_EXEC) && !(vma->vm_flags & VM_EXEC)) {
>   		int rc = 0;
> -		if (vma->vm_start >= vma->vm_mm->start_brk &&
> -		    vma->vm_end <= vma->vm_mm->brk) {
> +		if (vma_is_initial_heap(vma)) {
>   			rc = avc_has_perm(sid, sid, SECCLASS_PROCESS,
>   					  PROCESS__EXECHEAP, NULL);
> -		} else if (!vma->vm_file &&
> -			   ((vma->vm_start <= vma->vm_mm->start_stack &&
> -			     vma->vm_end >= vma->vm_mm->start_stack) ||
> +		} else if (!vma->vm_file && (vma_is_initial_stack(vma) ||
>   			    vma_is_stack_for_current(vma))) {
>   			rc = avc_has_perm(sid, sid, SECCLASS_PROCESS,
>   					  PROCESS__EXECSTACK, NULL);

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

