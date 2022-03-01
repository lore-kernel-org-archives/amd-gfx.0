Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89B8AC433FE
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Mar 2022 16:47:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DED1410E655;
	Tue,  1 Mar 2022 16:47:26 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B55010E615
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Mar 2022 16:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646151733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VpcEjZ3pDaEx12dH+BduTDFR/D5IwkR6BCpw7XkWHU0=;
 b=gPj0/G4JttlA8PIQES5HkDDGyu7uuI/AAEmsvq0Hk8ohCU/RLGKsP6/YiL2g4O6GUdD0bB
 loFPbqzt5gEdJqWOCGMDiBbKONP0mEFjxO8onZ2mdXfY8q275EqPgcN5ya+iLPK4ku16Bw
 UxKS7T4cqfJkfG1cr4i1U0AdoJ+VRZo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-280-gixu3u08Nhu2G5Wgw9ll3A-1; Tue, 01 Mar 2022 11:22:12 -0500
X-MC-Unique: gixu3u08Nhu2G5Wgw9ll3A-1
Received: by mail-wr1-f70.google.com with SMTP id
 j27-20020adfb31b000000b001ea8356972bso3516535wrd.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Mar 2022 08:22:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:organization:in-reply-to
 :content-transfer-encoding;
 bh=VpcEjZ3pDaEx12dH+BduTDFR/D5IwkR6BCpw7XkWHU0=;
 b=xeyS7qsstKx4xo7LLGOjUyfz9xoqwasG4goWYJRNvH/pq/p9X6dqpfFXuiXdpyE1Qi
 JTmxUgqkBCSUJTZPf//1rYAcdwqo5wU2Q8YclGnlJrsBM0iIMyDm948rjb4bEMf8Yp3j
 tWlq1TbPD0CGn2DHunkKQIzTxIRZDJfpW9SrlkPazXkGuRGRKrzEnQg/+62HGeTTonl7
 v62ukUMJS05W2yRjKfv3XR93wqCMqzRE8pfiqNNCH9pz5UdGMxhR7TeFvOIq64zr3g3I
 6MBvO0+R9bonY2BGr2H/su5ZWD1e055HGMGnBlxAnabHCM91ix8M8OLGMrtAcHt27EyI
 UAvg==
X-Gm-Message-State: AOAM532rbpkLz4l5a5cqeHuQ4oQffcHwwNXl2PalG+IDpmDVVzD7g2By
 jmhWHdpw51cQigO9Q8ywWmHXmO9TIc4GbYaPsE2Cfcw4+bwZzfjEL1gYFu4JwZ7Hi8q52dHWcvl
 2t2L+Srzm/4WTwiHrHO72A2HRJQ==
X-Received: by 2002:a05:600c:1e03:b0:381:4134:35ca with SMTP id
 ay3-20020a05600c1e0300b00381413435camr14983721wmb.145.1646151730957; 
 Tue, 01 Mar 2022 08:22:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxYfHVRSOGMfPLPfHkM21n2ADlCruTETrhJPt1WIhsU9tWlvnq+Hh/dL+h6goFY71nLBUFD/w==
X-Received: by 2002:a05:600c:1e03:b0:381:4134:35ca with SMTP id
 ay3-20020a05600c1e0300b00381413435camr14983702wmb.145.1646151730682; 
 Tue, 01 Mar 2022 08:22:10 -0800 (PST)
Received: from ?IPV6:2003:cb:c70e:5e00:88ce:ad41:cb1b:323?
 (p200300cbc70e5e0088cead41cb1b0323.dip0.t-ipconnect.de.
 [2003:cb:c70e:5e00:88ce:ad41:cb1b:323])
 by smtp.gmail.com with ESMTPSA id
 g6-20020a05600c4ec600b0037bf934bca3sm3706698wmq.17.2022.03.01.08.22.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Mar 2022 08:22:10 -0800 (PST)
Message-ID: <bfae7d17-eb50-55b1-1275-5ba0f86a5273@redhat.com>
Date: Tue, 1 Mar 2022 17:22:08 +0100
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
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <41469645-55be-1aaa-c1ef-84a123fdb4ea@amd.com>
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
Cc: rcampbell@nvidia.com, willy@infradead.org, apopple@nvidia.com,
 dri-devel@lists.freedesktop.org, linux-xfs@vger.kernel.org, linux-mm@kvack.org,
 jglisse@redhat.com, amd-gfx@lists.freedesktop.org, akpm@linux-foundation.org,
 linux-ext4@vger.kernel.org, hch@lst.de
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


>>
>>>   		if (PageReserved(page))
>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>> index c31d04b46a5e..17d049311b78 100644
>>> --- a/mm/migrate.c
>>> +++ b/mm/migrate.c
>>> @@ -1614,7 +1614,7 @@ static int add_page_for_migration(struct mm_struct *mm, unsigned long addr,
>>>   		goto out;
>>>   
>>>   	/* FOLL_DUMP to ignore special (like zero) pages */
>>> -	follflags = FOLL_GET | FOLL_DUMP;
>>> +	follflags = FOLL_GET | FOLL_DUMP | FOLL_LRU;
>>>   	page = follow_page(vma, addr, follflags);
>> Why wouldn't we want to dump DEVICE_COHERENT pages? This looks wrong.
> 
> This function later calls isolate_lru_page, which is something you can't 
> do with a device page.
> 

Then, that code might require care instead. We most certainly don't want
to have random memory holes in a dump just because some anonymous memory
was migrated to DEVICE_COHERENT.

-- 
Thanks,

David / dhildenb

