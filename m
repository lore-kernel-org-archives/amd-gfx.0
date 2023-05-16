Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DBC3C77B7A
	for <amd-gfx@archiver.kernel.org>; Tue, 16 May 2023 14:36:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F19910E24A;
	Tue, 16 May 2023 14:36:55 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29EE910E248
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 May 2023 14:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684247762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HDtlWQaTJft8O2op6owZ91p6/RHXC3pnklg9iA3D7Gs=;
 b=GwNU2jVXuUSEPvp/FzFFnijUdMuy5Nr9BffD0SVYeWB1Fcvgr1DVLV858MA0o/9O6AEEs5
 6sAnJ9jANU5q8X2wsGbFJhvghTrEmUsAeply9jCxoNilAAvAaDvJjzrqpg4tlaY9p8Yfxk
 v9Rb+eNgY3rEmOjgy4VZoVaCOBLOZ9M=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-Ooq0aY3gMhKtIHKuM1e0WA-1; Tue, 16 May 2023 10:36:01 -0400
X-MC-Unique: Ooq0aY3gMhKtIHKuM1e0WA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-30635d18e55so5097867f8f.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 May 2023 07:36:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684247760; x=1686839760;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HDtlWQaTJft8O2op6owZ91p6/RHXC3pnklg9iA3D7Gs=;
 b=g74qggeFlS54ubO1lX9mTKUq8SthIstAJRRfhvBfhblQae0CVX+qNi67U8yNEF2hLJ
 e8hCimCNfFzv7AEcv0Ta30bftu4WKD5PWYr4fwZuztRJOatWXphRvt6/pO97R0m2V9to
 /jmYXNVuZxc2UsZyMazEvXtcOWu1itnKBcbWZvYr2tUvUgukVfvprMzbA+TtoHLfGeut
 OzQ+T25Muk03YKchZiXNOuhh4BsfaWwHDBvPYkaQ1efWtw3JmHZ03cxo8kK8V8j3B4n4
 +VV0B+PT9O6ij/R3N22sdfne5BJ8y5ySbV4sdvBss/zRzfI/qWYs/3lU7ACkKXrgEzLo
 qOwA==
X-Gm-Message-State: AC+VfDwg5d1MFYoLvHV6uBzS+rxQlcR9nTfIY+Vqus5XnwEDoeDGbHZ4
 XE0Ml+zQRMcv4sdnFx419I2Tj3yN+pKRKIxZnAQpsxDu/QsD0w1OxP2L7JcoEkGtFPZWHS8JqRk
 v5aHhstAKQxGbRzoPdX0b7cegHw==
X-Received: by 2002:adf:f58f:0:b0:306:b3f9:e2c9 with SMTP id
 f15-20020adff58f000000b00306b3f9e2c9mr28308362wro.6.1684247760143; 
 Tue, 16 May 2023 07:36:00 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ43W1M/r+a9sBvXVLNjQ1rWzK4b+y6axsJM1bg4sF6/pP33gd7tOg3iz5gfyS0T7ZUiF6igvw==
X-Received: by 2002:adf:f58f:0:b0:306:b3f9:e2c9 with SMTP id
 f15-20020adff58f000000b00306b3f9e2c9mr28308347wro.6.1684247759798; 
 Tue, 16 May 2023 07:35:59 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74f:2500:1e3a:9ee0:5180:cc13?
 (p200300cbc74f25001e3a9ee05180cc13.dip0.t-ipconnect.de.
 [2003:cb:c74f:2500:1e3a:9ee0:5180:cc13])
 by smtp.gmail.com with ESMTPSA id
 x2-20020a05600c21c200b003f508777e33sm2586081wmj.3.2023.05.16.07.35.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 May 2023 07:35:59 -0700 (PDT)
Message-ID: <7e9651d6-382a-287c-cd08-03762ccce1f7@redhat.com>
Date: Tue, 16 May 2023 16:35:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 1/6] mm/gup: remove unused vmas parameter from
 get_user_pages()
To: Sean Christopherson <seanjc@google.com>
References: <cover.1684097001.git.lstoakes@gmail.com>
 <b61d5999a4fc6d50b7e073cc3c3efa8fe79bbd94.1684097002.git.lstoakes@gmail.com>
 <ZGKC9fHoE+kDs0ar@google.com>
 <b97e8c2a-b629-f597-d011-395071011f1b@redhat.com>
 <ZGOTadDG/b0904YI@google.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZGOTadDG/b0904YI@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 16 May 2023 14:36:52 +0000
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
 Lorenzo Stoakes <lstoakes@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Xinhui Pan <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
 Christian Konig <christian.koenig@amd.com>,
 Jarkko Sakkinen <jarkko@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Paolo Bonzini <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 Pavel Begunkov <asml.silence@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 16.05.23 16:30, Sean Christopherson wrote:
> On Tue, May 16, 2023, David Hildenbrand wrote:
>> On 15.05.23 21:07, Sean Christopherson wrote:
>>> On Sun, May 14, 2023, Lorenzo Stoakes wrote:
>>>> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
>>>> index cb5c13eee193..eaa5bb8dbadc 100644
>>>> --- a/virt/kvm/kvm_main.c
>>>> +++ b/virt/kvm/kvm_main.c
>>>> @@ -2477,7 +2477,7 @@ static inline int check_user_page_hwpoison(unsigned long addr)
>>>>    {
>>>>    	int rc, flags = FOLL_HWPOISON | FOLL_WRITE;
>>>> -	rc = get_user_pages(addr, 1, flags, NULL, NULL);
>>>> +	rc = get_user_pages(addr, 1, flags, NULL);
>>>>    	return rc == -EHWPOISON;
>>>
>>> Unrelated to this patch, I think there's a pre-existing bug here.  If gup() returns
>>> a valid page, KVM will leak the refcount and unintentionally pin the page.  That's
>>
>> When passing NULL as "pages" to get_user_pages(), __get_user_pages_locked()
>> won't set FOLL_GET. As FOLL_PIN is also not set, we won't be messing with
>> the mapcount of the page.

For completeness: s/mapcount/refcount/ :)

> 
> Ah, that's what I'm missing.



-- 
Thanks,

David / dhildenb

