Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4219AC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Mar 2022 08:58:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37F7910E09E;
	Thu, 17 Mar 2022 08:58:32 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC46D10EFF2
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Mar 2022 08:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647504834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xxA0Pce6UnOZWW6gsq8il76yFsehAiTQ6twP7i/3/GQ=;
 b=i9ocHWQ4ruFxw25UNHFShxytWepuLkCReLw3lss3KN+Ovdfa+ThGwCIDnbPe+jitf0YTPx
 WF9pB+KJo/PISDHdtLt+ZatBzQgNYNCrmOreUoawU/NJtuLinQHJBwIi1fZ9OVCMcE+0Jf
 5bJ3tJrBaRJf/FEfQG8DJeuaU6A6X/Y=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-587-FTECtL8oM6Kq4ohXv9F6Ag-1; Thu, 17 Mar 2022 04:13:53 -0400
X-MC-Unique: FTECtL8oM6Kq4ohXv9F6Ag-1
Received: by mail-wm1-f70.google.com with SMTP id
 f19-20020a7bcd13000000b0038c01defd5aso1846419wmj.7
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Mar 2022 01:13:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:organization:in-reply-to
 :content-transfer-encoding;
 bh=xxA0Pce6UnOZWW6gsq8il76yFsehAiTQ6twP7i/3/GQ=;
 b=fHzqKWZeWvxeXFyDbgj07+5xBmh7MAMEzrWvQ9wEt+6rS44ujQflykYcV4BvD5fmSI
 YzTtKAdYOlpgLofW3sb0yB4vi88kM+6qFuVNISeaqFd/cH8iBWArBZOkVYZOcerQhDAe
 e5UoJ67f/USfcwmN1b6QUfiJzOeIHYo7pImM86TDlSjVTTgQZNTXh2hJAZ6dsvtHsllj
 C32Il6FlwhHvRSriG+/CcRGHlbNxGgL+YMXh9CGJZEzgQOUTF4lyb9wZ/ej3u9WY3xfC
 /3DEYmpSuSjUWMJxl3fzwAu/OoJpj1dtF5T1T2Uk0PK8UnoxQENnTCKvu+DwPITubfKH
 pHSA==
X-Gm-Message-State: AOAM532L6mfoEXtPMW7FyjhkGV2lAA9Kp00mAD4tUzdbflH4/dAVLhcE
 A5cBP0EA6mrRnotRdOt8nmlfG5BpmFvHuzBXpcHMC9oCqxLZIhtZtvqxCpbNX/6oLYzy+R/vBrY
 0XGPKxzf8Tf/DKn/LeGdaIRdPTQ==
X-Received: by 2002:a05:6000:144a:b0:203:8688:35d with SMTP id
 v10-20020a056000144a00b002038688035dmr2896891wrx.399.1647504832462; 
 Thu, 17 Mar 2022 01:13:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzkIygRnwahr8xhyLvIiK8lTpLSYuqqmv1avWZ31V4hbmg8hvmgWPIvr5DZvtTFDGtJ3e2QVw==
X-Received: by 2002:a05:6000:144a:b0:203:8688:35d with SMTP id
 v10-20020a056000144a00b002038688035dmr2896866wrx.399.1647504832168; 
 Thu, 17 Mar 2022 01:13:52 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:d000:22e9:afb1:c890:7468?
 (p200300cbc707d00022e9afb1c8907468.dip0.t-ipconnect.de.
 [2003:cb:c707:d000:22e9:afb1:c890:7468])
 by smtp.gmail.com with ESMTPSA id
 j7-20020a05600c410700b0038c72ef3f15sm2542317wmi.38.2022.03.17.01.13.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Mar 2022 01:13:51 -0700 (PDT)
Message-ID: <ab26f7a0-728e-9627-796b-e8e850402aae@redhat.com>
Date: Thu, 17 Mar 2022 09:13:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v1 1/3] mm: split vm_normal_pages for LRU and non-LRU
 handling
To: Alistair Popple <apopple@nvidia.com>,
 Felix Kuehling <felix.kuehling@amd.com>
References: <20220310172633.9151-1-alex.sierra@amd.com>
 <20220310172633.9151-2-alex.sierra@amd.com>
 <07401a0a-6878-6af2-f663-9f0c3c1d88e5@redhat.com>
 <1747447c-202d-9195-9d44-57f299be48c4@amd.com>
 <87lex98dtg.fsf@nvdebian.thelocal>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <87lex98dtg.fsf@nvdebian.thelocal>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 17 Mar 2022 08:58:31 +0000
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
Cc: Alex Sierra <alex.sierra@amd.com>, rcampbell@nvidia.com,
 willy@infradead.org, amd-gfx@lists.freedesktop.org, linux-xfs@vger.kernel.org,
 linux-mm@kvack.org, jglisse@redhat.com, dri-devel@lists.freedesktop.org,
 jgg@nvidia.com, akpm@linux-foundation.org, linux-ext4@vger.kernel.org,
 hch@lst.de
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 17.03.22 03:54, Alistair Popple wrote:
> Felix Kuehling <felix.kuehling@amd.com> writes:
> 
>> On 2022-03-11 04:16, David Hildenbrand wrote:
>>> On 10.03.22 18:26, Alex Sierra wrote:
>>>> DEVICE_COHERENT pages introduce a subtle distinction in the way
>>>> "normal" pages can be used by various callers throughout the kernel.
>>>> They behave like normal pages for purposes of mapping in CPU page
>>>> tables, and for COW. But they do not support LRU lists, NUMA
>>>> migration or THP. Therefore we split vm_normal_page into two
>>>> functions vm_normal_any_page and vm_normal_lru_page. The latter will
>>>> only return pages that can be put on an LRU list and that support
>>>> NUMA migration, KSM and THP.
>>>>
>>>> We also introduced a FOLL_LRU flag that adds the same behaviour to
>>>> follow_page and related APIs, to allow callers to specify that they
>>>> expect to put pages on an LRU list.
>>>>
>>> I still don't see the need for s/vm_normal_page/vm_normal_any_page/. And
>>> as this patch is dominated by that change, I'd suggest (again) to just
>>> drop it as I don't see any value of that renaming. No specifier implies any.
>>
>> OK. If nobody objects, we can adopts that naming convention.
> 
> I'd prefer we avoid the churn too, but I don't think we should make
> vm_normal_page() the equivalent of vm_normal_any_page(). It would mean
> vm_normal_page() would return non-LRU device coherent pages, but to me at least
> device coherent pages seem special and not what I'd expect from a function with
> "normal" in the name.
> 
> So I think it would be better to s/vm_normal_lru_page/vm_normal_page/ and keep
> vm_normal_any_page() (or perhaps call it vm_any_page?). This is basically what
> the previous incarnation of this feature did:
> 
> struct page *_vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
>                             pte_t pte, bool with_public_device);
> #define vm_normal_page(vma, addr, pte) _vm_normal_page(vma, addr, pte, false)
> 
> Except we should add:
> 
> #define vm_normal_any_page(vma, addr, pte) _vm_normal_page(vma, addr, pte, true)
> 

"normal" simply tells us that this is not a special mapping -- IOW, we
want the VM to take a look at the memmap and not treat it like a PFN
map. What we're changing is that we're now also returning non-lru pages.
Fair enough, that's why we introduce vm_normal_lru_page() as a
replacement where we really can only deal with lru pages.

vm_normal_page vs vm_normal_lru_page is good enough. "lru" further
limits what we get via vm_normal_page, that's even how it's implemented.

vm_normal_page vs vm_normal_any_page is confusing IMHO.


-- 
Thanks,

David / dhildenb

