Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE64CA0EF8
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Aug 2025 12:49:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE4C110E98E;
	Thu, 21 Aug 2025 12:49:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="eLcXVeQq";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D54A610E782
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Aug 2025 15:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755703392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MHMC0ytWt4UnbdQQ3ai3X6E6JH7mYxGupeQxLSXwMtc=;
 b=eLcXVeQq9scCqTXJvWZAJIAFdt2Emoff+IWyC6ot1sM4dBEX3ChCbEXHUq+h3BaiNKqPcY
 heVRM0D8elwGhjrFlWbJt6JLeWmsua5cOu5NGD3vxa8je/NIgqNLZlnW9vBJTaiFBGcNbV
 Ux/jTH1wYQU0N5UDQpGti0I85sGn7MU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-1E5nZNx-M_OCuhP-pSiYlg-1; Wed, 20 Aug 2025 11:23:11 -0400
X-MC-Unique: 1E5nZNx-M_OCuhP-pSiYlg-1
X-Mimecast-MFC-AGG-ID: 1E5nZNx-M_OCuhP-pSiYlg_1755703390
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45a1b0cfbafso41982895e9.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Aug 2025 08:23:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755703390; x=1756308190;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MHMC0ytWt4UnbdQQ3ai3X6E6JH7mYxGupeQxLSXwMtc=;
 b=X7BUY10qG0hdB9GiyqBrFAUp7fm//atnsYxN358UQotvjZH/OTBAposN9g9pqHtCj2
 AhkX3lXXeuLGXr0cy4GVQbhdyiDRcE8061oVftrYfiEeOklgBJQOp7QlWOeGtCECbjwY
 jWSplc56plIOwObXHqmL6AnTLZhjKFLcXSbu1w+GIR5+gUN8vghfGLmb2wFL44Ox7RoW
 1sw+VF2bXOBIrvXTtRc+rcLE/k38FgsbReZIc4t9Iu+R3uK1cbdecoElWHiyzBO4HSzb
 h/N2yo+53+T/h27vb9HSS3spqbtvBEw4BR9gdePlG4slTmlEPnrmyHknEv54GECaAEs8
 AR2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXF8Al2rWWjwHTNRSWLHzM67xPjKx68x0pzIla4ZrwZlHwpLlT/iApRfFb314qiBDoaXqlngN9t@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwQU+kgAlcwlu4Bj8LI/+3u8k0bxNR0D2BK1L3lTUARzNeMcQH7
 whiuXDP4EwNdFbBW6CNxS/wy+HLYQO9Gq6z5/tYo+hX6Q0PVsTdvxA2Ur0NPNbebDUZ4Cpjsk0j
 H1jpfmrX6MEcvO7OlWv0zjgh/djd41cDNpEnJn+HSnRbwwA1a7c9v8avQHRtypPOWAFw=
X-Gm-Gg: ASbGncuywDRribMYvTHhu1sjXUjoqJYZmXbsm8f9mEuBJSCMMe4teMlT/aXl6REq/e7
 eja3TekGVi2keLKC6/BM0LHL6jobbRvNAXFZk4HqJOTHen2Rxhs3iS76grGmP9T6K3sZ6djelfY
 XGCyxgJlwsZJ6X7KHnQx0SKOu11dGiv092t8xMYWcu2GQpdl4s4ITWslTPllWySGTYEeifK8FL2
 tZbOR9Al436jrw1Jvu+sEbltOO7ysHC7WQUEJPQ/4HX6VHFdJEXwASp0B9D681jn++lsSe00hxf
 HfbhLyZfMmoI5TZIcoQACWVNtdLsTyCLMM2aZpfAFBNaAnuUjWxy0I1WCjPv46JZq667WQyuKbQ
 Dq1h/xyRhFPBFZa+uQauykDzB8lARgZuws34EcmqxSguLx7IpZpBP9Ghxj4mW3ke3
X-Received: by 2002:a05:600c:1c0f:b0:45b:47e1:f5ff with SMTP id
 5b1f17b1804b1-45b47e1f78emr19926185e9.35.1755703389807; 
 Wed, 20 Aug 2025 08:23:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhEZ/n8PZkcKynPCVdAwa7qiBMdV4if/4Cu2oXhVKYAe2TWTJLq5lgkm+j9KdvQrljPj3TIQ==
X-Received: by 2002:a05:600c:1c0f:b0:45b:47e1:f5ff with SMTP id
 5b1f17b1804b1-45b47e1f78emr19925905e9.35.1755703389377; 
 Wed, 20 Aug 2025 08:23:09 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f13:de00:e9f1:62b4:5bb:5d83?
 (p200300d82f13de00e9f162b405bb5d83.dip0.t-ipconnect.de.
 [2003:d8:2f13:de00:e9f1:62b4:5bb:5d83])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b47c64984sm36601325e9.23.2025.08.20.08.23.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Aug 2025 08:23:08 -0700 (PDT)
Message-ID: <edf4aee5-54eb-4fad-aa89-4913d44371fe@redhat.com>
Date: Wed, 20 Aug 2025 17:23:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re:
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 x86@kernel.org
Cc: airlied@gmail.com, thomas.hellstrom@linux.intel.com,
 matthew.brost@intel.com, dave.hansen@linux.intel.com, luto@kernel.org,
 peterz@infradead.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
References: <20250820143739.3422-1-christian.koenig@amd.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250820143739.3422-1-christian.koenig@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4hZ6ZAgFAr7hBBhCRYlTkHXC1FlvXMf8LuQCeGj9hRs_1755703390
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 21 Aug 2025 12:48:46 +0000
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

CCing Lorenzo

On 20.08.25 16:33, Christian König wrote:
> Hi everyone,
> 
> sorry for CCing so many people, but that rabbit hole turned out to be
> deeper than originally thought.
> 
> TTM always had problems with UC/WC mappings on 32bit systems and drivers
> often had to revert to hacks like using GFP_DMA32 to get things working
> while having no rational explanation why that helped (see the TTM AGP,
> radeon and nouveau driver code for that).
> 
> It turned out that the PAT implementation we use on x86 not only enforces
> the same caching attributes for pages in the linear kernel mapping, but
> also for highmem pages through a separate R/B tree.
> 
> That was unexpected and TTM never updated that R/B tree for highmem pages,
> so the function pgprot_set_cachemode() just overwrote the caching
> attributes drivers passed in to vmf_insert_pfn_prot() and that essentially
> caused all kind of random trouble.
> 
> An R/B tree is potentially not a good data structure to hold thousands if
> not millions of different attributes for each page, so updating that is
> probably not the way to solve this issue.
> 
> Thomas pointed out that the i915 driver is using apply_page_range()
> instead of vmf_insert_pfn_prot() to circumvent the PAT implementation and
> just fill in the page tables with what the driver things is the right
> caching attribute.

I assume you mean apply_to_page_range() -- same issue in patch subjects.

Oh this sounds horrible. Why oh why do we have these hacks in core-mm 
and have drivers abuse them :(

Honestly, apply_to_pte_range() is just the entry in doing all kinds of 
weird crap to page tables because "you know better".

All the sanity checks from vmf_insert_pfn(), gone.

Can we please fix the underlying issue properly?

-- 
Cheers

David / dhildenb

