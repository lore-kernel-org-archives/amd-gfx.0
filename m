Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EDD4C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Feb 2022 14:09:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3CF110E5B0;
	Tue, 15 Feb 2022 14:09:11 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A102110E45A
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Feb 2022 12:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644927407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pt3kaDq1aQDkXB/hX2rUZYURxbJS3EoGhO0bUKlqTws=;
 b=JDfCjqg2zoroNThqR/XA9QKeAjdFenvQ7BDKXd9ZqqocagWyZ7nk3EuCgv8Ak3xJ1MMwKu
 CPefNfm22rty+4gWV3/OpKKdgM4Nthjj+SpnHysi/q0q1nXKoIn3MBflEJrDIMIXV8/tBJ
 FY43NQrJlFN7t+kIiN+CpwmqiT59eiU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-674-I7_mWjliPcibWprMHvkBWQ-1; Tue, 15 Feb 2022 07:16:46 -0500
X-MC-Unique: I7_mWjliPcibWprMHvkBWQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 k20-20020adfc714000000b001e305cd1597so8274250wrg.19
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Feb 2022 04:16:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:organization:in-reply-to
 :content-transfer-encoding;
 bh=Pt3kaDq1aQDkXB/hX2rUZYURxbJS3EoGhO0bUKlqTws=;
 b=ZvUlIPiCH1pG5u/1zhut02BSgZdjTOp5m7udXb3YHV8sWjlzTEutMEbEUMuFOc2/hg
 NHo0paJ8IhAGjlErYWYkCdXwlnR/82EnxZ8IVQxlhpWsLQ9CQ/1ldzKbIlrsL69E07mN
 FAd0LyZJchLq0nBZIhemqWsNFeiz1xt8us1BAZa/aHytAktU1wPQYKJPiiZy+GBymysQ
 Wwm49nzhOeL8ZeqZ4KQEfLJ+iphvzsXryEqdsGdnLXLdW0lFcY9ogUzYVluIai4lzmTh
 naiI7PJCsaxlxyZx5Smoivv8gQ/quE3GbMKYp8+VqcMK5GlKFexV1l2DmSPpz2nI/31V
 diUw==
X-Gm-Message-State: AOAM531LQsDfDTqhlqBKouH9MiwgZLhlTGI4r/D5zNcQcKyA+0CeNQ05
 Mhm3L8Q6WJQpGpkBK0akcpxCcp0HrXgT2LujaeAQynvTw/ZHZ1W0+sBSlsY4KSm0Fev0Hjtc8Jo
 aohhSg8NG9AnovS8BOTr72tkv9A==
X-Received: by 2002:a05:6000:156c:: with SMTP id
 12mr2943173wrz.387.1644927405397; 
 Tue, 15 Feb 2022 04:16:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwsEhDLYb4heqpDoCuYC8NeTX+i0m6l8MCzsccoJvk2OwBqm/N5306LsnwqqqFvXB+oF92GrA==
X-Received: by 2002:a05:6000:156c:: with SMTP id
 12mr2943150wrz.387.1644927405198; 
 Tue, 15 Feb 2022 04:16:45 -0800 (PST)
Received: from ?IPV6:2003:cb:c70e:3700:9260:2fb2:742d:da3e?
 (p200300cbc70e370092602fb2742dda3e.dip0.t-ipconnect.de.
 [2003:cb:c70e:3700:9260:2fb2:742d:da3e])
 by smtp.gmail.com with ESMTPSA id y6sm7829264wrd.30.2022.02.15.04.16.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Feb 2022 04:16:44 -0800 (PST)
Message-ID: <078dd84e-ebbc-5c89-0407-f5ecc2ca3ebf@redhat.com>
Date: Tue, 15 Feb 2022 13:16:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v6 01/10] mm: add zone device coherent type memory support
To: Felix Kuehling <felix.kuehling@amd.com>, Alex Sierra
 <alex.sierra@amd.com>, akpm@linux-foundation.org, linux-mm@kvack.org,
 rcampbell@nvidia.com, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
References: <20220201154901.7921-1-alex.sierra@amd.com>
 <20220201154901.7921-2-alex.sierra@amd.com>
 <beb38138-2266-1ff8-cc82-8fe914bed862@redhat.com>
 <f2af73c1-396b-168f-7f86-eb10b3b68a26@redhat.com>
 <a24d82d9-daf9-fa1a-8b9d-5db7fe10655e@amd.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <a24d82d9-daf9-fa1a-8b9d-5db7fe10655e@amd.com>
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
Cc: willy@infradead.org, apopple@nvidia.com, dri-devel@lists.freedesktop.org,
 jglisse@redhat.com, amd-gfx@lists.freedesktop.org, jgg@nvidia.com, hch@lst.de
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 11.02.22 18:07, Felix Kuehling wrote:
> 
> Am 2022-02-11 um 11:39 schrieb David Hildenbrand:
>> On 11.02.22 17:15, David Hildenbrand wrote:
>>> On 01.02.22 16:48, Alex Sierra wrote:
>>>> Device memory that is cache coherent from device and CPU point of view.
>>>> This is used on platforms that have an advanced system bus (like CAPI
>>>> or CXL). Any page of a process can be migrated to such memory. However,
>>>> no one should be allowed to pin such memory so that it can always be
>>>> evicted.
>>>>
>>>> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
>>>> Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
>>>> Reviewed-by: Alistair Popple <apopple@nvidia.com>
>>> So, I'm currently messing with PageAnon() pages and CoW semantics ...
>>> all these PageAnon() ZONE_DEVICE variants don't necessarily make my life
>>> easier but I'm not sure yet if they make my life harder. I hope you can
>>> help me understand some of that stuff.
>>>
>>> 1) What are expected CoW semantics for DEVICE_COHERENT?
>>>
>>> I assume we'll share them just like other PageAnon() pages during fork()
>>> readable, and the first sharer writing to them receives an "ordinary"
>>> !ZONE_DEVICE copy.
>>>
>>> So this would be just like DEVICE_EXCLUSIVE CoW handling I assume, just
>>> that we don't have to go through the loop of restoring a device
>>> exclusive entry?
>>>
>>> 2) How are these pages freed to clear/invalidate PageAnon() ?
>>>
>>> I assume for PageAnon() ZONE_DEVICE pages we'll always for via
>>> free_devmap_managed_page(), correct?
>>>
>>>
>>> 3) FOLL_PIN
>>>
>>> While you write "no one should be allowed to pin such memory", patch #2
>>> only blocks FOLL_LONGTERM. So I assume we allow ordinary FOLL_PIN and
>>> you might want to be a bit more precise?
>>>
>>>
>>> ... I'm pretty sure we cannot FOLL_PIN DEVICE_PRIVATE pages, but can we
>>> FILL_PIN DEVICE_EXCLUSIVE pages? I strongly assume so?
>>>
>>>
>>> Thanks for any information.
>>>
>> (digging a bit more, I realized that device exclusive pages are not
>> actually/necessarily ZONE_DEVICE pages -- so I assume DEVICE_COHERENT
>> will be the actual first PageAnon() ZONE_DEVICE pages that can be
>> present in a page table.)
> 
> I think DEVICE_GENERIC pages can also be mapped in the page table. In 
> fact, the first version of our patches attempted to add migration 
> support to DEVICE_GENERIC. But we were convinced to create a new 
> ZONE_DEVICE page type for our use case instead.

Do you know if DEVICE_GENERIC pages would end up as PageAnon()? My
assumption was that they would be part of a special mapping.

-- 
Thanks,

David / dhildenb

