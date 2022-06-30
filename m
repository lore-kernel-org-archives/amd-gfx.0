Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D56FC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jun 2022 21:00:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFF12112A85;
	Thu, 30 Jun 2022 21:00:56 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A642C11295F
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jun 2022 20:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656622566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cs91WyVesi99NqFGAEv3+PryqGuZwEkmE4TutiLYwN4=;
 b=G7c17tFl4MFR8c/zubBPh7YAMUjWbjikbt7B+qkHhNtD2MbojHcBa8Lk+b901XouQYfMQ+
 H1ZtU+wFOtsjn9mjhSBdtfD2vJz2CcydHTe8Fx5ciwFzyzL8zt36dOF21xRL8uAlOlnIHE
 O2cBLEsq42Lx45OrIV8blUscU6cQTgY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-513-p9z9TktUMCa9E2gcGub6Vg-1; Thu, 30 Jun 2022 16:56:05 -0400
X-MC-Unique: p9z9TktUMCa9E2gcGub6Vg-1
Received: by mail-wm1-f70.google.com with SMTP id
 h125-20020a1c2183000000b003a0374f1eb8so1938347wmh.8
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jun 2022 13:56:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent
 :content-language:to:cc:references:from:organization:subject
 :in-reply-to:content-transfer-encoding;
 bh=cs91WyVesi99NqFGAEv3+PryqGuZwEkmE4TutiLYwN4=;
 b=TzsYrUCQnz5bFwtmpX8b6NvVNGRZccrAPjI2QMLkVFe/JH8fu9w9NQtSuzyYlUun7i
 JVfJgeQEAj8ZBXYySYLssHF87QNfPfS/RASZv9fknc7+QhP3S7BAV3wne7UKxE2DNJYx
 t02g0Kyz3xocbK7m+2CRZRDcu3Oq2Teb60+wzvYlBYs3oWmq+lY/URB/at74m9rXHwBo
 It2FK4Y+uHWsW9ILxH2ZH2i1hhkkdCx3ELwS8sEB/47E9QBlmgXkWhUj52C/USwnb9uE
 UClSIOwG3JvVSwmSdzDwuvVETF32sH7Ln42q9Ww5Ct4+6mX41mIm/mbRn/exVzlORe1C
 KPyg==
X-Gm-Message-State: AJIora/qKyMtRXP6n5V+dO/vQgdKskTSYKBfLSfA7y7hrfUxxFMSZFKX
 wJh/aljogBkSBF9mE2gQa9f+2uA5A6vgPOHCpG9DmqiUV/MT2D51WY5oHq7+hpYtZmRXjNu4cqo
 u7x/ppk/LiXMZFZ8TMOdwlXhgHw==
X-Received: by 2002:a05:600c:22d0:b0:3a0:3bb9:3936 with SMTP id
 16-20020a05600c22d000b003a03bb93936mr14637971wmg.137.1656622563846; 
 Thu, 30 Jun 2022 13:56:03 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1ulPmxkj72HO5yHWbkMgKLlGDzSAl2x3/KwnxpkCAD53J5CgIe7BBJs8xjCIGOLRUODCIR27Q==
X-Received: by 2002:a05:600c:22d0:b0:3a0:3bb9:3936 with SMTP id
 16-20020a05600c22d000b003a03bb93936mr14637943wmg.137.1656622563542; 
 Thu, 30 Jun 2022 13:56:03 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:7f00:214b:cffb:c693:2b71?
 (p200300cbc7087f00214bcffbc6932b71.dip0.t-ipconnect.de.
 [2003:cb:c708:7f00:214b:cffb:c693:2b71])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a05600c064300b0039c8a22554bsm7666219wmm.27.2022.06.30.13.56.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jun 2022 13:56:02 -0700 (PDT)
Message-ID: <24577304-15ea-0c9c-9b73-946143bf2726@redhat.com>
Date: Thu, 30 Jun 2022 22:56:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
To: Alistair Popple <apopple@nvidia.com>
References: <20220629035426.20013-1-alex.sierra@amd.com>
 <20220629035426.20013-5-alex.sierra@amd.com>
 <956b1c51-b8f1-0480-81ca-5d03b45110f7@redhat.com>
 <878rpe73t3.fsf@nvdebian.thelocal>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v7 04/14] mm: add device coherent vma selection for memory
 migration
In-Reply-To: <878rpe73t3.fsf@nvdebian.thelocal>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 30 Jun 2022 21:00:55 +0000
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
 willy@infradead.org, Felix.Kuehling@amd.com, amd-gfx@lists.freedesktop.org,
 linux-xfs@vger.kernel.org, linux-mm@kvack.org, jglisse@redhat.com,
 dri-devel@lists.freedesktop.org, jgg@nvidia.com, akpm@linux-foundation.org,
 linux-ext4@vger.kernel.org, hch@lst.de
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 30.06.22 13:44, Alistair Popple wrote:
> 
> David Hildenbrand <david@redhat.com> writes:
> 
>> On 29.06.22 05:54, Alex Sierra wrote:
>>> This case is used to migrate pages from device memory, back to system
>>> memory. Device coherent type memory is cache coherent from device and CPU
>>> point of view.
>>>
>>> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
>>> Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
>>> Reviewed-by: Alistair Poppple <apopple@nvidia.com>
>>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>>
>>
>> I'm not too familiar with this code, please excuse my naive questions:
>>
>>> @@ -148,15 +148,21 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
>>>  			if (is_writable_device_private_entry(entry))
>>>  				mpfn |= MIGRATE_PFN_WRITE;
>>>  		} else {
>>> -			if (!(migrate->flags & MIGRATE_VMA_SELECT_SYSTEM))
>>> -				goto next;
>>
>> Why not exclude MIGRATE_VMA_SELECT_DEVICE_PRIVATE here? IIRC that would
>> have happened before this change.
> 
> I might be missing something as I don't quite follow - this path is for
> normal system pages so we only want to skip selecting them if
> MIGRATE_VMA_SELECT_SYSTEM or MIGRATE_VMA_SELECT_DEVICE_COHERENT aren't
> set.
> 
> Note that MIGRATE_VMA_SELECT_DEVICE_PRIVATE doesn't apply here because
> we already know it's not a device private page by virtue of
> pte_present(pte) == True.

Ah, stupid me, pte_present(pte) is the key.

> 
>>>  			pfn = pte_pfn(pte);
>>> -			if (is_zero_pfn(pfn)) {
>>> +			if (is_zero_pfn(pfn) &&
>>> +			    (migrate->flags & MIGRATE_VMA_SELECT_SYSTEM)) {
>>>  				mpfn = MIGRATE_PFN_MIGRATE;
>>>  				migrate->cpages++;
>>>  				goto next;
>>>  			}
>>>  			page = vm_normal_page(migrate->vma, addr, pte);
>>> +			if (page && !is_zone_device_page(page) &&
>>
>> I'm wondering if that check logically belongs into patch #2.
> 
> I don't think so as it would break functionality until the below
> conditionals are added - we explicitly don't want to skip
> is_zone_device_page(page) == False here because that is the pages we are
> trying to select.
> 
> You could add in this:
> 
>>> +			    !(migrate->flags & MIGRATE_VMA_SELECT_SYSTEM))
> 
> But then in patch 2 we know this can never be true because we've already
> checked for !MIGRATE_VMA_SELECT_SYSTEM there.


Ah, okay, thanks

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

