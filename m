Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40DC2C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jun 2022 12:57:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C14910EF49;
	Wed, 29 Jun 2022 12:57:40 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCF8910FB02
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jun 2022 09:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656496770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UzceN8npiU1PHAzECBm7qOnZjHThBc7uhuHl4hlHZrs=;
 b=gJvf84fvi2nq0BWO3Hy9NnG1QtuypHCiVgXIUUGkwIX7lVXAPfnM21fEvrkAbmjN0k6S8m
 eCr7/ivX4cKkYhiAt32yU8rPhBMAjNSgCnX51gOMuB8zabSo2TI9vGm8XHjrW8V/LSNhrh
 NJVSPEt0NovUOfWBN9gZw2oPcB/OWAg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-171-5UDP7dz_P6C4Xw-RJ0j-gw-1; Wed, 29 Jun 2022 05:59:29 -0400
X-MC-Unique: 5UDP7dz_P6C4Xw-RJ0j-gw-1
Received: by mail-wr1-f71.google.com with SMTP id
 u9-20020adfa189000000b0021b8b3c8f74so2271664wru.12
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jun 2022 02:59:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent
 :content-language:to:cc:references:from:organization:subject
 :in-reply-to:content-transfer-encoding;
 bh=UzceN8npiU1PHAzECBm7qOnZjHThBc7uhuHl4hlHZrs=;
 b=ozTE+58EWn7m08oEiOTYqP9bGtoPaCXl7YvZJLxXZuUHZLRHRrOmbRhzwvKfnq+qYn
 Gpb699li+s6IS548Po6otV7Kilajc7kKdTWlV75fv2glicl9m/xgF+3VyyWIMaq1N4/o
 Xl2O9zJF/GkceE/+MHtOYF/EE6OI/ibbMS5OkWJgeGy7s2xvsjPzkmVgdEA+H5/snnlV
 JyqYPsdMv2LZvSvaKvlSlcqe5o3hyBQxJHqqNI0TpB+fOuk9tDaal0QNI040/cT1B/fd
 BOG2GIa6sXa2DqNQejuXJ0C+I8nvtBPxWyNATE5Xltd/85aKjwBKpZMJc07jijC4pdkx
 5UTQ==
X-Gm-Message-State: AJIora8i54qb5NQuEtvePnHG+4nW4dBTgBiSisw0CITqpYkZkmtGGq3o
 hocEkr9WM1WlgVrULYjhKfRsKDGIp/B5OP9grncdFCRIRwq6efhICEtoFUjnXBGFx4YKnKL+u9n
 XCfkKFk0qLTRKjhcUDypTEXeUOQ==
X-Received: by 2002:a7b:c5d0:0:b0:3a0:3dc8:73a1 with SMTP id
 n16-20020a7bc5d0000000b003a03dc873a1mr2664062wmk.98.1656496768473; 
 Wed, 29 Jun 2022 02:59:28 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uzk/B6PTZXrzHxht/mKCZa7GoCf9iThGNKGutixbwHJDxt/oLs1rYeiHv7jfh4fv2kOpV6+w==
X-Received: by 2002:a7b:c5d0:0:b0:3a0:3dc8:73a1 with SMTP id
 n16-20020a7bc5d0000000b003a03dc873a1mr2664041wmk.98.1656496768236; 
 Wed, 29 Jun 2022 02:59:28 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:e600:d4fa:af4b:d7b6:20df?
 (p200300cbc708e600d4faaf4bd7b620df.dip0.t-ipconnect.de.
 [2003:cb:c708:e600:d4fa:af4b:d7b6:20df])
 by smtp.gmail.com with ESMTPSA id
 y6-20020a05600c20c600b003a0426fae52sm2555196wmm.24.2022.06.29.02.59.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jun 2022 02:59:27 -0700 (PDT)
Message-ID: <269e4c6e-d6ee-bace-9fab-a9dcb4268d5a@redhat.com>
Date: Wed, 29 Jun 2022 11:59:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
To: Alex Sierra <alex.sierra@amd.com>, jgg@nvidia.com
References: <20220629035426.20013-1-alex.sierra@amd.com>
 <20220629035426.20013-4-alex.sierra@amd.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v7 03/14] mm: handling Non-LRU pages returned by
 vm_normal_pages
In-Reply-To: <20220629035426.20013-4-alex.sierra@amd.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 29 Jun 2022 12:57:38 +0000
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
Cc: rcampbell@nvidia.com, willy@infradead.org, Felix.Kuehling@amd.com,
 apopple@nvidia.com, amd-gfx@lists.freedesktop.org, linux-xfs@vger.kernel.org,
 linux-mm@kvack.org, jglisse@redhat.com, dri-devel@lists.freedesktop.org,
 akpm@linux-foundation.org, linux-ext4@vger.kernel.org, hch@lst.de
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 29.06.22 05:54, Alex Sierra wrote:
> With DEVICE_COHERENT, we'll soon have vm_normal_pages() return
> device-managed anonymous pages that are not LRU pages. Although they
> behave like normal pages for purposes of mapping in CPU page, and for
> COW. They do not support LRU lists, NUMA migration or THP.
> 
> Callers to follow_page that expect LRU pages, are also checked for
> device zone pages due to DEVICE_COHERENT type.

Can we rephrase that to (because zeropage)

"Callers to follow_page() currently don't expect ZONE_DEVICE pages,
however, with DEVICE_COHERENT we might now return ZONE_DEVICE. Check for
ZONE_DEVICE pages in applicable users of follow_page() as well."



[...]

>  		/*
> diff --git a/mm/memory.c b/mm/memory.c
> index 7a089145cad4..e18555af9024 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -624,6 +624,13 @@ struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
>  		if (is_zero_pfn(pfn))
>  			return NULL;
>  		if (pte_devmap(pte))
> +/*
> + * NOTE: New uers of ZONE_DEVICE will not set pte_devmap() and will have

s/uers/users/

> + * refcounts incremented on their struct pages when they are inserted into
> + * PTEs, thus they are safe to return here. Legacy ZONE_DEVICE pages that set
> + * pte_devmap() do not have refcounts. Example of legacy ZONE_DEVICE is
> + * MEMORY_DEVICE_FS_DAX type in pmem or virtio_fs drivers.
> + */

[...]

> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index ba5592655ee3..e034aae2a98b 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -95,7 +95,7 @@ static unsigned long change_pte_range(struct mmu_gather *tlb,
>  					continue;
>  
>  				page = vm_normal_page(vma, addr, oldpte);
> -				if (!page || PageKsm(page))
> +				if (!page || is_zone_device_page(page) || PageKsm(page))
>  					continue;
>  
>  				/* Also skip shared copy-on-write pages */

In -next/-mm there is now an additional can_change_pte_writable() that
calls vm_normal_page() --  added by me. I assume that that is indeed
fine because we can simply map device coherent pages writable.

Besides the nits, LGTM

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

