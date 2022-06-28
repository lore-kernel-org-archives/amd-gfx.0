Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F66EC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jun 2022 13:03:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D296711BCDE;
	Tue, 28 Jun 2022 13:03:29 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27C6012B5CD
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jun 2022 10:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656412906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8pRM3r8AeF6GLv7Aybx1vUx/f9NMkwqu6LnYZ6evvqI=;
 b=FEMCP5UHCqHS8JYmq5HoEAt39H2O2l/LOpmdOwaP9xRZ5yhd40Q9Mi5FM1DMoWnQamlhKd
 1/U2CErYXB4IKtY0yd6kPeljNITwtDHvw/3L+ar8N0ux+lAUnon95Zkdk8oalXsd2SVQyq
 3rkg/U6QJsn5epK3C7lzMcbUnjfm+pM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-616-PuFkImFuMaaC-tSTWbgDEw-1; Tue, 28 Jun 2022 06:41:44 -0400
X-MC-Unique: PuFkImFuMaaC-tSTWbgDEw-1
Received: by mail-wr1-f71.google.com with SMTP id
 j14-20020adfa54e000000b0021b8c8204easo1704205wrb.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jun 2022 03:41:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:organization:in-reply-to
 :content-transfer-encoding;
 bh=8pRM3r8AeF6GLv7Aybx1vUx/f9NMkwqu6LnYZ6evvqI=;
 b=UwvEVTr0UFeGyTL+pKSmhWT4Zn5aAR8azEGEZea9SKyBBceXN5z/bE5BdvFlhAyRXh
 8HlpULB95YSW7f6UTRitpMGUfTcR4WvTIfFPwg8B965Do8oUaQjJZGrv23XteDfYLKu5
 gEgNlTQfGsS8ctqeT6BUV4rWAav87sDaAmhQecsKCR3VTUz9nem+s8Qe9Hp4ojIpfCNU
 If6fHCc47CroHviBpNIl+fZ6sAQJECPu3tYKcIVbJ4g5cVHHPE9wB+arspqit5Jm+LA/
 OwyJ1gL2mPellvH1U4Hq0fvNuCoKnDO2f78jywLWRF5Sfhyhc1iDWZ2rX8Db0A5pT4ub
 EW4Q==
X-Gm-Message-State: AJIora/5UsS5YP4jLCGk+4jZ5QaSgri0+go+kJrv2OCX0k2qFTOYXszE
 iufq9wS1mmyq48EO2k+zF0PCqls7cNUIVQjTgN4r2EJ7dfTkGmsGUaBxlWpFjfDFucMqyn1FCtM
 TgAEyERSl4EJmEynRWsuiGKLCMQ==
X-Received: by 2002:a05:6000:3c6:b0:21b:9d00:db29 with SMTP id
 b6-20020a05600003c600b0021b9d00db29mr17371379wrg.338.1656412903686; 
 Tue, 28 Jun 2022 03:41:43 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vrjQcjOOWZyri2deV7Hh8adDyK403V4lqaRVOfb8p/+5njBKdZBau0GhQDi3asydV8iTuiRw==
X-Received: by 2002:a05:6000:3c6:b0:21b:9d00:db29 with SMTP id
 b6-20020a05600003c600b0021b9d00db29mr17371350wrg.338.1656412903411; 
 Tue, 28 Jun 2022 03:41:43 -0700 (PDT)
Received: from ?IPV6:2003:cb:c709:a00:46df:e778:456a:8d6b?
 (p200300cbc7090a0046dfe778456a8d6b.dip0.t-ipconnect.de.
 [2003:cb:c709:a00:46df:e778:456a:8d6b])
 by smtp.gmail.com with ESMTPSA id
 q13-20020adfcd8d000000b00219b391c2d2sm15851990wrj.36.2022.06.28.03.41.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jun 2022 03:41:42 -0700 (PDT)
Message-ID: <336094c6-0c94-2b43-5472-c44638e8446a@redhat.com>
Date: Tue, 28 Jun 2022 12:41:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v6 06/14] mm: add device coherent checker to
 is_pinnable_page
To: Alex Sierra <alex.sierra@amd.com>, jgg@nvidia.com
References: <20220628001454.3503-1-alex.sierra@amd.com>
 <20220628001454.3503-7-alex.sierra@amd.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220628001454.3503-7-alex.sierra@amd.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 28 Jun 2022 13:03:28 +0000
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

On 28.06.22 02:14, Alex Sierra wrote:
> is_device_coherent checker was added to is_pinnable_page and renamed
> to is_longterm_pinnable_page. The reason is that device coherent
> pages are not supported for longterm pinning.
> 
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
> ---
>  include/linux/memremap.h | 25 +++++++++++++++++++++++++
>  include/linux/mm.h       | 24 ------------------------
>  mm/gup.c                 |  5 ++---
>  mm/gup_test.c            |  4 ++--
>  mm/hugetlb.c             |  2 +-
>  5 files changed, 30 insertions(+), 30 deletions(-)


Rename of the function should be a separate cleanup patch before any
other changes, and the remaining change should be squashed into patch
#1, to logically make sense, because it still states "no one should be
allowed to pin such memory so that it can always be evicted."

Or am I missing something?

-- 
Thanks,

David / dhildenb

