Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0426BC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Feb 2022 14:09:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05FAE10E5A8;
	Tue, 15 Feb 2022 14:09:11 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE6F6892D5
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Feb 2022 12:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644927344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=li59JkksonHEim8N19eLLyTcVUoQZhmnR79T7jisS84=;
 b=N0ndL/Cn1apaefDfSHrZwZ2y/ErqTpF5dQFg/JTMuuDjJ/uaY4s7boj386eVVG10LTOelr
 Fo/kIn2mSDeYLpZ6VOJ2Ueau3MKKrbpJDLxEx5Ewzw+gmEvmPeYACdAIYd7XHJ0oaRJ/As
 r3YA2PQpQXoZZRHW77or5x2WGv9Rmuc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-59-tvkpFWvTPViGs7VYWAfnmw-1; Tue, 15 Feb 2022 07:15:41 -0500
X-MC-Unique: tvkpFWvTPViGs7VYWAfnmw-1
Received: by mail-wm1-f72.google.com with SMTP id
 a17-20020a05600c069100b0037bb7eb6944so1978436wmn.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Feb 2022 04:15:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent
 :content-language:to:cc:references:from:organization:subject
 :in-reply-to:content-transfer-encoding;
 bh=li59JkksonHEim8N19eLLyTcVUoQZhmnR79T7jisS84=;
 b=u8qKGC/Jy59kX1IK6u+nkGOaWMVU+FExGaaYMKigqBY+YfS2WESwJC6ZvWLHn47yEi
 8Mz3DDvnERyi0kPnOkuy505LeA+7owFWylnXXLFjCaI0FhRTVqVLUpfvxrmz9/uQk8sH
 FKXSBEcwjEE6gLA04mcbLdCyDnL6VtR9vkQSbb9EqFCXYyqnZBidgLWsfcY/Pxdla4Hz
 p3XDIdTzJmaR7tY0Gbo5fzAo91iFkY4qxoxUKuErRBL63Xw1Wpy8CH0e9becwq2fF4Ib
 idwKcg9yLtsf0lpgqWTqaYp6w2T9oatNNi3fojIQpS0f9Klbcl0EyR1rFK6zcix+bx9e
 4mzQ==
X-Gm-Message-State: AOAM530lxF1xRO1RkV58dszYyQ4qQHMWpZ6i3UHiqjzTX8ArbYLlMz/a
 otTmwYSNnMGhPIF1KFMS4EYi9VyyY1l2Gj+XY9zevRnzuVklY1myLVwu8+XFnfjo9NWrXX2lBD2
 yswRpVp/ZYasbpNjbUJOlle5iQg==
X-Received: by 2002:a05:6000:2ac:: with SMTP id
 l12mr3048029wry.639.1644927339846; 
 Tue, 15 Feb 2022 04:15:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzkXiKIPDmUKc3peLAnxWMPOpVfO+YZVnwiubxG8ybWR9d1yWHVTQW3fpFRYPoIV1z4/FG1xQ==
X-Received: by 2002:a05:6000:2ac:: with SMTP id
 l12mr3047997wry.639.1644927339488; 
 Tue, 15 Feb 2022 04:15:39 -0800 (PST)
Received: from ?IPV6:2003:cb:c70e:3700:9260:2fb2:742d:da3e?
 (p200300cbc70e370092602fb2742dda3e.dip0.t-ipconnect.de.
 [2003:cb:c70e:3700:9260:2fb2:742d:da3e])
 by smtp.gmail.com with ESMTPSA id u3sm18392835wmm.0.2022.02.15.04.15.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Feb 2022 04:15:39 -0800 (PST)
Message-ID: <7b830dc4-37bc-fb7b-c094-16595bd2a128@redhat.com>
Date: Tue, 15 Feb 2022 13:15:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20220201154901.7921-1-alex.sierra@amd.com>
 <20220201154901.7921-2-alex.sierra@amd.com>
 <beb38138-2266-1ff8-cc82-8fe914bed862@redhat.com>
 <20220211164537.GO4160@nvidia.com>
 <6a8df47e-96d0-ffaf-247a-acc504e2532b@redhat.com>
 <20220211165624.GP4160@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v6 01/10] mm: add zone device coherent type memory support
In-Reply-To: <20220211165624.GP4160@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 15 Feb 2022 14:09:09 +0000
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
 willy@infradead.org, Felix.Kuehling@amd.com, apopple@nvidia.com,
 amd-gfx@lists.freedesktop.org, linux-xfs@vger.kernel.org, linux-mm@kvack.org,
 jglisse@redhat.com, dri-devel@lists.freedesktop.org, akpm@linux-foundation.org,
 linux-ext4@vger.kernel.org, hch@lst.de
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 11.02.22 17:56, Jason Gunthorpe wrote:
> On Fri, Feb 11, 2022 at 05:49:08PM +0100, David Hildenbrand wrote:
>> On 11.02.22 17:45, Jason Gunthorpe wrote:
>>> On Fri, Feb 11, 2022 at 05:15:25PM +0100, David Hildenbrand wrote:
>>>
>>>> ... I'm pretty sure we cannot FOLL_PIN DEVICE_PRIVATE pages
>>>
>>> Currently the only way to get a DEVICE_PRIVATE page out of the page
>>> tables is via hmm_range_fault() and that doesn't manipulate any ref
>>> counts.
>>
>> Thanks for clarifying Jason! ... and AFAIU, device exclusive entries are
>> essentially just pointers at ordinary PageAnon() pages. So with DEVICE
>> COHERENT we'll have the first PageAnon() ZONE_DEVICE pages mapped as
>> present in the page tables where GUP could FOLL_PIN them.
> 
> This is my understanding
> 
> Though you probably understand what PageAnon means alot better than I
> do.. I wonder if it really makes sense to talk about that together
> with ZONE_DEVICE which has alot in common with filesystem originated
> pages too.

For me, PageAnon() means that modifications are visible only to the
modifying process. On actual CoW, the underlying page will get replaced
-- in the world of DEVICE_COHERENT that would mean that once you write
to a DEVICE_COHERENT you could suddenly have a !DEVICE_COHERENT page.

PageAnon() pages don't have a mapping, thus they can only be found in
MAP_ANON VMAs or in MAP_SHARED VMAs with MAP_PRIVATE. They can only be
found via a page table, and not looked up via the page cache (excluding
the swap cache).

So if we have PageAnon() pages on ZONE_DEVICE, they generally have the
exact same semantics as !ZONE_DEVICE pages, but the way they "appear" in
the page tables the allocation/freeing path differs -- I guess :)

... and as we want pinning semantics to be different we have to touch GUP.

> 
> I'm not sure what AMDs plan is here, is there an expecation that a GPU
> driver will somehow stuff these pages into an existing anonymous
> memory VMA or do they always come from a driver originated VMA?

My understanding is that a driver can just decide to replace "ordinary"
PageAnon() pages e.g., in a MAP_ANON VMA by these pages. Hopefully AMD
can clarify.


-- 
Thanks,

David / dhildenb

