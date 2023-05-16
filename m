Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BFFBC77B7A
	for <amd-gfx@archiver.kernel.org>; Tue, 16 May 2023 13:13:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD9C910E1D7;
	Tue, 16 May 2023 13:13:53 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBF4910E20B
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 May 2023 10:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684232516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DdwZekQhQhJYfD71ineBvZDWMF1v7qroVT5L1UXxv4Y=;
 b=BJLmKJH/+DqLPoaghhFc3uDuMNe1iWdl6Z5VnoOsIyjD7ypWzdGOFt/lYPDua3+5sc3G2Y
 uGl4QbTUvj0zM3bIhaVLwwLKip7EZvNQdI3CA49SOjkDWsZF1EViw1qIqNcpUpEh2je6KS
 aRAH03hFn/6QNuCRQ/Y+PmQmHn9s2es=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-o14FozocO9CKFZw9OBTjvw-1; Tue, 16 May 2023 06:21:55 -0400
X-MC-Unique: o14FozocO9CKFZw9OBTjvw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f420742d40so38001425e9.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 May 2023 03:21:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684232514; x=1686824514;
 h=content-transfer-encoding:in-reply-to:subject:organization:from
 :references:cc:to:content-language:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DdwZekQhQhJYfD71ineBvZDWMF1v7qroVT5L1UXxv4Y=;
 b=GsADCjeA4hbgl1C7NcpREOxEBlTYc9XwVKbjWE82T1N82hsvNLR4xum06jTpjudqre
 RRFL/C89Z1TI4k5DfPbsVvnV9OOaTYvVlJikgGjTRzRbCPtMf+GySitHelPmsY5SmtcS
 J0fzj8N2RqyvS4hh9fjHt1zPV7ueS93iWHTI/DalNPSlND7WiYpLrx75FtJwkLz+KcGr
 A/BKk6uXmx+CtmznV+gBU/zcsoF1zsWO+NMhBR0RKD04qHd/eJG82oZc8QS+NPZDkZNl
 8pttlSwz4PoyVOZYEIQ/3lGxBKRNhMiPKU0vqF0fdOL/3WNFUYPvDNqbfDe9YELJf6Am
 PLdA==
X-Gm-Message-State: AC+VfDyDsXAp+gUVsoEJG1fasb5rH//2QMlrEp0Ee5YFcN7+oov9UxR3
 ytMPan136HPoi+7FLm5H3IQSM5yRwtdoeePhbIM6pKsjvpxsNW0TiEXtv63Uo/MqjGOa9FSEXEl
 O72o5pip5mE7M6sX8rP+lGvaU+Q==
X-Received: by 2002:a5d:6ad2:0:b0:306:3b39:9a3d with SMTP id
 u18-20020a5d6ad2000000b003063b399a3dmr28037451wrw.15.1684232513859; 
 Tue, 16 May 2023 03:21:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6bdJSovfEtFVKVvmRsoufWG6M0qCFHLXRoPnSmKuTb+/8PzxuUbfsqia5+hKdAyzixUpyepw==
X-Received: by 2002:a5d:6ad2:0:b0:306:3b39:9a3d with SMTP id
 u18-20020a5d6ad2000000b003063b399a3dmr28037403wrw.15.1684232513432; 
 Tue, 16 May 2023 03:21:53 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74f:2500:1e3a:9ee0:5180:cc13?
 (p200300cbc74f25001e3a9ee05180cc13.dip0.t-ipconnect.de.
 [2003:cb:c74f:2500:1e3a:9ee0:5180:cc13])
 by smtp.gmail.com with ESMTPSA id
 t1-20020a5d5341000000b002ff2c39d072sm2092106wrv.104.2023.05.16.03.21.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 May 2023 03:21:52 -0700 (PDT)
Message-ID: <b97e8c2a-b629-f597-d011-395071011f1b@redhat.com>
Date: Tue, 16 May 2023 12:21:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
To: Sean Christopherson <seanjc@google.com>,
 Lorenzo Stoakes <lstoakes@gmail.com>
References: <cover.1684097001.git.lstoakes@gmail.com>
 <b61d5999a4fc6d50b7e073cc3c3efa8fe79bbd94.1684097002.git.lstoakes@gmail.com>
 <ZGKC9fHoE+kDs0ar@google.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v5 1/6] mm/gup: remove unused vmas parameter from
 get_user_pages()
In-Reply-To: <ZGKC9fHoE+kDs0ar@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 16 May 2023 13:13:51 +0000
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
Cc: kvm@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
 amd-gfx@lists.freedesktop.org, "H . Peter Anvin" <hpa@zytor.com>,
 David Airlie <airlied@gmail.com>, x86@kernel.org,
 Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Ingo Molnar <mingo@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Arnd Bergmann <arnd@arndb.de>, John Hubbard <jhubbard@nvidia.com>,
 Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 linux-sgx@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 Dimitri Sivanich <dimitri.sivanich@hpe.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Xinhui Pan <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
 Christian Konig <christian.koenig@amd.com>,
 Jarkko Sakkinen <jarkko@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Paolo Bonzini <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 Pavel Begunkov <asml.silence@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 15.05.23 21:07, Sean Christopherson wrote:
> On Sun, May 14, 2023, Lorenzo Stoakes wrote:
>> No invocation of get_user_pages() use the vmas parameter, so remove it.
>>
>> The GUP API is confusing and caveated. Recent changes have done much to
>> improve that, however there is more we can do. Exporting vmas is a prime
>> target as the caller has to be extremely careful to preclude their use
>> after the mmap_lock has expired or otherwise be left with dangling
>> pointers.
>>
>> Removing the vmas parameter focuses the GUP functions upon their primary
>> purpose - pinning (and outputting) pages as well as performing the actions
>> implied by the input flags.
>>
>> This is part of a patch series aiming to remove the vmas parameter
>> altogether.
>>
>> Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Acked-by: David Hildenbrand <david@redhat.com>
>> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>> Acked-by: Christian Kï¿½nig <christian.koenig@amd.com> (for radeon parts)
>> Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
>> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
>> ---
>>   arch/x86/kernel/cpu/sgx/ioctl.c     | 2 +-
>>   drivers/gpu/drm/radeon/radeon_ttm.c | 2 +-
>>   drivers/misc/sgi-gru/grufault.c     | 2 +-
>>   include/linux/mm.h                  | 3 +--
>>   mm/gup.c                            | 9 +++------
>>   mm/gup_test.c                       | 5 ++---
>>   virt/kvm/kvm_main.c                 | 2 +-
>>   7 files changed, 10 insertions(+), 15 deletions(-)
> 
> Acked-by: Sean Christopherson <seanjc@google.com> (KVM)
> 
>> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
>> index cb5c13eee193..eaa5bb8dbadc 100644
>> --- a/virt/kvm/kvm_main.c
>> +++ b/virt/kvm/kvm_main.c
>> @@ -2477,7 +2477,7 @@ static inline int check_user_page_hwpoison(unsigned long addr)
>>   {
>>   	int rc, flags = FOLL_HWPOISON | FOLL_WRITE;
>>   
>> -	rc = get_user_pages(addr, 1, flags, NULL, NULL);
>> +	rc = get_user_pages(addr, 1, flags, NULL);
>>   	return rc == -EHWPOISON;
> 
> Unrelated to this patch, I think there's a pre-existing bug here.  If gup() returns
> a valid page, KVM will leak the refcount and unintentionally pin the page.  That's

When passing NULL as "pages" to get_user_pages(), 
__get_user_pages_locked() won't set FOLL_GET. As FOLL_PIN is also not 
set, we won't be messing with the mapcount of the page.

So even if get_user_pages() returns "1", we should be fine.


Or am I misunderstanding your concern? At least hva_to_pfn_slow() most 
certainly didn't return "1" if we end up calling 
check_user_page_hwpoison(), so nothing would have been pinned there as well.

-- 
Thanks,

David / dhildenb

