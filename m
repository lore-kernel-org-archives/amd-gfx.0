Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20457CCA47B
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jul 2022 15:05:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D116410E40C;
	Fri,  8 Jul 2022 15:05:28 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D17C10F4E8
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jul 2022 11:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1657279721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wv13NujG3+dVwkih/Xqwv3AU9lfrcuYQf1ebjgUaVVk=;
 b=UebhZV31iTWdu0pDYEDd8F3yeLxrQCf/lpLm+g1EFVqyhbOQ9KRZfY5oSgx0dnT4tOPcR8
 NNibhiQqpbjh9pmeXn/yp+5CHBYUEX2eraN/mJMamLc7uy4Gy+Q9FCe6jqgi9Vg16nszWn
 AgOezvb1Xtbz2ugIU/sCpqn39e25C7Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-7-L9T47f_YO6G9t5JRYzpdqQ-1; Fri, 08 Jul 2022 07:28:32 -0400
X-MC-Unique: L9T47f_YO6G9t5JRYzpdqQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 v123-20020a1cac81000000b003a02a3f0beeso870949wme.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 Jul 2022 04:28:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:organization:in-reply-to
 :content-transfer-encoding;
 bh=Wv13NujG3+dVwkih/Xqwv3AU9lfrcuYQf1ebjgUaVVk=;
 b=u3WhLHJ8krZuplLgWA53Q8J6u+WHRsC1Rmnh+zuxLXZx5To77OxRDGcg43ctVbSQpj
 BxQVgqRkHGABRq+m1ZZhvUkjnmLSRJuJf13zJ7eTUfSk29FN1rSkLEknqf/xtr6yCzx8
 /QZskqSklqrZvCwEaE7nK+Qv9m2g/3fBlAXx2pw1RKHdmPm/3pEtRb6EAVs3lCbmcN2E
 BwPjT4Fifa1YJjvzGvALTznqR8PGvdSKAEYdrCxxwSIXXmdzJX835wbc6kMmlTU4UW4S
 mnWCMfLbQbywRPoW2rU8d1bPa9eaoYA5ZzZIhZ+IQbBsukRfTeKcGnPBjHpDNgQvssVu
 gGQw==
X-Gm-Message-State: AJIora+LNIXRluE35eNhVJAPa+ta74ZBel6znkrrGTtIfiYnI3OR42sX
 XW2elHeuohvMW9w1uc4g1xP1o4ld2wLVDcUoG9w39EN92fRA5TPDSmTjwhOZADryN6ukD0ocRz2
 x8CUTo5a5G+Y/CHwZj5j0X5mhew==
X-Received: by 2002:a05:600c:2d45:b0:3a0:46e9:7bde with SMTP id
 a5-20020a05600c2d4500b003a046e97bdemr9948574wmg.49.1657279711665; 
 Fri, 08 Jul 2022 04:28:31 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vwGt5CrdxA6TaalbRjXWp7cv9FLQs1vbEX6yKshjXEbNsz1xjWIT4O4gDvAQM4X6U54AxsXw==
X-Received: by 2002:a05:600c:2d45:b0:3a0:46e9:7bde with SMTP id
 a5-20020a05600c2d4500b003a046e97bdemr9948543wmg.49.1657279711385; 
 Fri, 08 Jul 2022 04:28:31 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:6300:c44f:789a:59b5:91e9?
 (p200300cbc7026300c44f789a59b591e9.dip0.t-ipconnect.de.
 [2003:cb:c702:6300:c44f:789a:59b5:91e9])
 by smtp.gmail.com with ESMTPSA id
 y5-20020a056000108500b002167efdd549sm12911271wrw.38.2022.07.08.04.28.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Jul 2022 04:28:30 -0700 (PDT)
Message-ID: <97816c26-d2dd-1102-4a13-fafb0b1a4bc3@redhat.com>
Date: Fri, 8 Jul 2022 13:28:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v8 02/15] mm: move page zone helpers into new
 header-specific file
To: Alex Sierra <alex.sierra@amd.com>, jgg@nvidia.com
References: <20220707190349.9778-1-alex.sierra@amd.com>
 <20220707190349.9778-3-alex.sierra@amd.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220707190349.9778-3-alex.sierra@amd.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 08 Jul 2022 15:05:26 +0000
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

On 07.07.22 21:03, Alex Sierra wrote:
> [WHY]
> Have a cleaner way to expose all page zone helpers in one header

What exactly is a "page zone"? Do you mean a buddy zone as in
include/linux/mmzone.h ?


-- 
Thanks,

David / dhildenb

