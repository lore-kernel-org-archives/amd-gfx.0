Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 143ACC4332F
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Mar 2022 16:47:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52DB610E686;
	Tue,  1 Mar 2022 16:47:28 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5D8A10E6F2
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Mar 2022 16:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646152350;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n44Wo6vgxZpi5bWperlxNMLPYijk8JsTILs9YPWVgno=;
 b=ev/F+9HK1B5n47Khw3eIrrSbtGBzIKfSMiTPlQIzO8XL96Lqhs/+H/mB2j2rjP2NI9dsXd
 DNTrzlwQXpMDtEcULsg0IA31i0LLsg12j6y2thjtmXPzbQlPSZ0pJf7UswziY3a/r3mE9y
 yfcVIVhqoHiZLJ8ONQ90eMXbHasYK3g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-13-r1gWoUpOOGCuJ00d_BJY3g-1; Tue, 01 Mar 2022 11:32:27 -0500
X-MC-Unique: r1gWoUpOOGCuJ00d_BJY3g-1
Received: by mail-wm1-f72.google.com with SMTP id
 l31-20020a05600c1d1f00b00380e3425ba7so1446263wms.9
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Mar 2022 08:32:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:organization:in-reply-to
 :content-transfer-encoding;
 bh=n44Wo6vgxZpi5bWperlxNMLPYijk8JsTILs9YPWVgno=;
 b=Z8dzZTdzFzqLsAbyTfGUcj2KHJrOMr1P/wWdu9ylE4pRAzJIXOvFcQAjbUDHV6HNZA
 iuoSTjTsvfMoD/JtiTGxqvljXrJ6Ig91zuaQ2x3wr1873Y/GL+HPY20fZ0ePNEipYNIf
 tmUY8RDqgdJ5QUGVuhLchp1CXBVF3dp55WxPHgjhEX8uSFi+9qHzHHOp2jzOEagLUShL
 /hBVGGwkmcSVyJJgWYdpKZXtfVZ/XGEnY8/oh58CUlHau1KqQ2fbn3uvLwmpq5XV6/St
 +0aGHkbPItwOYcay/4X3kfnTG6Xa0bdom9MU55oH2fPV66zPAhO83LmnPBr/h6hy1+Ww
 C6VQ==
X-Gm-Message-State: AOAM533vguBfqchMLx1gT7i34X1bSJvAhIbzJ/RsJjhVETA29ABNXvVF
 s0MaV95KX03dWOIa7ECIGwauaeeqRsa+OhUcZR4xlqE5YAxnqlHK49YzTTnqejiH13dnLEdG39d
 +T8zDq4k+7VNFP4FjoEiCno1Ytw==
X-Received: by 2002:a05:6000:1b0c:b0:1ef:956e:3210 with SMTP id
 f12-20020a0560001b0c00b001ef956e3210mr10718763wrz.322.1646152346582; 
 Tue, 01 Mar 2022 08:32:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy3kzdNGIIvZpX2C9to3Pb3Y486zu3gVqra59S1lC+acXexuk7wv16jDLZDxszLnYK+EvUsSg==
X-Received: by 2002:a05:6000:1b0c:b0:1ef:956e:3210 with SMTP id
 f12-20020a0560001b0c00b001ef956e3210mr10718743wrz.322.1646152346319; 
 Tue, 01 Mar 2022 08:32:26 -0800 (PST)
Received: from ?IPV6:2003:cb:c70e:5e00:88ce:ad41:cb1b:323?
 (p200300cbc70e5e0088cead41cb1b0323.dip0.t-ipconnect.de.
 [2003:cb:c70e:5e00:88ce:ad41:cb1b:323])
 by smtp.gmail.com with ESMTPSA id
 m34-20020a05600c3b2200b00380e3225af9sm3328629wms.0.2022.03.01.08.32.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Mar 2022 08:32:25 -0800 (PST)
Message-ID: <85a68c56-7cce-ef98-7aa6-c68eabf3fa0b@redhat.com>
Date: Tue, 1 Mar 2022 17:32:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] mm: split vm_normal_pages for LRU and non-LRU handling
To: Felix Kuehling <felix.kuehling@amd.com>, Alex Sierra
 <alex.sierra@amd.com>, jgg@nvidia.com
References: <20220218192640.GV4160@nvidia.com>
 <20220228203401.7155-1-alex.sierra@amd.com>
 <2a042493-d04d-41b1-ea12-b326d2116861@redhat.com>
 <41469645-55be-1aaa-c1ef-84a123fdb4ea@amd.com>
 <bfae7d17-eb50-55b1-1275-5ba0f86a5273@redhat.com>
 <353c7bbd-b20e-8a7a-029a-cda9b531e5e8@amd.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <353c7bbd-b20e-8a7a-029a-cda9b531e5e8@amd.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 01 Mar 2022 16:47:26 +0000
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
Cc: rcampbell@nvidia.com, amd-gfx@lists.freedesktop.org, apopple@nvidia.com,
 dri-devel@lists.freedesktop.org, linux-xfs@vger.kernel.org, linux-mm@kvack.org,
 jglisse@redhat.com, willy@infradead.org, akpm@linux-foundation.org,
 linux-ext4@vger.kernel.org, hch@lst.de
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 01.03.22 17:30, Felix Kuehling wrote:
> Am 2022-03-01 um 11:22 schrieb David Hildenbrand:
>>>>>    		if (PageReserved(page))
>>>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>>>> index c31d04b46a5e..17d049311b78 100644
>>>>> --- a/mm/migrate.c
>>>>> +++ b/mm/migrate.c
>>>>> @@ -1614,7 +1614,7 @@ static int add_page_for_migration(struct mm_struct *mm, unsigned long addr,
>>>>>    		goto out;
>>>>>    
>>>>>    	/* FOLL_DUMP to ignore special (like zero) pages */
>>>>> -	follflags = FOLL_GET | FOLL_DUMP;
>>>>> +	follflags = FOLL_GET | FOLL_DUMP | FOLL_LRU;
>>>>>    	page = follow_page(vma, addr, follflags);
>>>> Why wouldn't we want to dump DEVICE_COHERENT pages? This looks wrong.
>>> This function later calls isolate_lru_page, which is something you can't
>>> do with a device page.
>>>
>> Then, that code might require care instead. We most certainly don't want
>> to have random memory holes in a dump just because some anonymous memory
>> was migrated to DEVICE_COHERENT.
> I don't think this code is for core dumps. The call chain I see is
> 
> SYSCALL_DEFINE6(move_pages, ...) -> kernel_move_pages -> do_pages_move 
> -> add_page_for_migration
> 

Ah, sorry, I got mislead by FOLL_DUMP and thought we'd be in
get_dump_page() . As you said, nothing to do.

-- 
Thanks,

David / dhildenb

