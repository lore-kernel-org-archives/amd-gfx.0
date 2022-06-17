Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A5A3C433EF
	for <amd-gfx@archiver.kernel.org>; Sat, 18 Jun 2022 13:54:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A827E10E515;
	Sat, 18 Jun 2022 13:54:50 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3877310E473
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jun 2022 17:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655487197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l9t8ci2pOVMm92hWEf9qj7OSOv7zoUPsj9UgV8OEIRA=;
 b=MH90flJXY+UUDmSid2k1nD5RzwUrvHpR+L/7qp8uw1djLYcERSMIcQYFoBc8kDr5GkTKip
 W1hYYScAWpK9uGUhQ+NHxRUiApWINHs3SykRdbaxmRRbHjXFvL0Z0WrRm8A3z+XBJqiJmj
 N5Dd6v27kxXzzPdoPE/3gEnzHXOkDcw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-191-ohVkcrCGP9uxFgbsUQyiOA-1; Fri, 17 Jun 2022 13:33:15 -0400
X-MC-Unique: ohVkcrCGP9uxFgbsUQyiOA-1
Received: by mail-wm1-f72.google.com with SMTP id
 h205-20020a1c21d6000000b0039c96ec500fso2979415wmh.8
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jun 2022 10:33:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:organization:in-reply-to
 :content-transfer-encoding;
 bh=l9t8ci2pOVMm92hWEf9qj7OSOv7zoUPsj9UgV8OEIRA=;
 b=hxtRFMl648bfDkuv/Z+gf4BXTt0SKyTag0IIFkzql2R0nhje8VFa5YnaBPXyoLv+vA
 1M0Pz9HnsUUhiEem31L05SbyH9oFVXMOQq/W8Duw3DfHmpYU5RiQm5fjEeDZnFCR94+W
 DniKTzcc4VAdstIxk8IXtkrUlIS7oqncfo2TzqW1HvFfg9vtJGRcMThiXLlmxoK1roQd
 S1ieAR3J9mW7FVoddTU4LOMSQk+HimJTEPXAqrYkW4mGoQ0o8y3Zo/TETOtFpC02QYdd
 fdtxpGCMI/DZRcuZUoiGHRkPVwmbeIFCIp5W1JdtcWeyaoeesqTBlWQ8GIwvzGw01c7/
 f5KA==
X-Gm-Message-State: AJIora/ljzatSGGmWhcJbET86rqMWCJlqzzwa5+qxdZlXt4GbeAGcKzt
 0yduZkIbvwDfK+cnHxdcQObLfTdHNdmhTCLcUDlK4OEvmViEZ9MTunm6C3yzMIrqQWWU3fdP+a3
 MB0RiSiIC1nkE5aF4G6ZMMLd6kQ==
X-Received: by 2002:a5d:62ce:0:b0:21a:33d9:70eb with SMTP id
 o14-20020a5d62ce000000b0021a33d970ebmr8760930wrv.86.1655487194590; 
 Fri, 17 Jun 2022 10:33:14 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1urFEzCzeOEUS5o/eRCkTO1px9MVS8RRmDRPHAiaj7roLYkwKxp344rt/xnUHDqok2Mu+dWjw==
X-Received: by 2002:a5d:62ce:0:b0:21a:33d9:70eb with SMTP id
 o14-20020a5d62ce000000b0021a33d970ebmr8760916wrv.86.1655487194277; 
 Fri, 17 Jun 2022 10:33:14 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70a:7e00:bb5b:b526:5b76:5824?
 (p200300cbc70a7e00bb5bb5265b765824.dip0.t-ipconnect.de.
 [2003:cb:c70a:7e00:bb5b:b526:5b76:5824])
 by smtp.gmail.com with ESMTPSA id
 h4-20020a5d6e04000000b0020d02262664sm5229194wrz.25.2022.06.17.10.33.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jun 2022 10:33:13 -0700 (PDT)
Message-ID: <7605beee-0a76-4ee9-e950-17419630f2cf@redhat.com>
Date: Fri, 17 Jun 2022 19:33:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v5 01/13] mm: add zone device coherent type memory support
To: "Sierra Guiza, Alejandro (Alex)" <alex.sierra@amd.com>, jgg@nvidia.com
References: <20220531200041.24904-1-alex.sierra@amd.com>
 <20220531200041.24904-2-alex.sierra@amd.com>
 <3ac89358-2ce0-7d0d-8b9c-8b0e5cc48945@redhat.com>
 <02ed2cb7-3ad3-8ffc-6032-04ae1853e234@amd.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <02ed2cb7-3ad3-8ffc-6032-04ae1853e234@amd.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Sat, 18 Jun 2022 13:54:45 +0000
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

On 17.06.22 19:20, Sierra Guiza, Alejandro (Alex) wrote:
> 
> On 6/17/2022 4:40 AM, David Hildenbrand wrote:
>> On 31.05.22 22:00, Alex Sierra wrote:
>>> Device memory that is cache coherent from device and CPU point of view.
>>> This is used on platforms that have an advanced system bus (like CAPI
>>> or CXL). Any page of a process can be migrated to such memory. However,
>>> no one should be allowed to pin such memory so that it can always be
>>> evicted.
>>>
>>> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
>>> Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
>>> Reviewed-by: Alistair Popple <apopple@nvidia.com>
>>> [hch: rebased ontop of the refcount changes,
>>>        removed is_dev_private_or_coherent_page]
>>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>>> ---
>>>   include/linux/memremap.h | 19 +++++++++++++++++++
>>>   mm/memcontrol.c          |  7 ++++---
>>>   mm/memory-failure.c      |  8 ++++++--
>>>   mm/memremap.c            | 10 ++++++++++
>>>   mm/migrate_device.c      | 16 +++++++---------
>>>   mm/rmap.c                |  5 +++--
>>>   6 files changed, 49 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/include/linux/memremap.h b/include/linux/memremap.h
>>> index 8af304f6b504..9f752ebed613 100644
>>> --- a/include/linux/memremap.h
>>> +++ b/include/linux/memremap.h
>>> @@ -41,6 +41,13 @@ struct vmem_altmap {
>>>    * A more complete discussion of unaddressable memory may be found in
>>>    * include/linux/hmm.h and Documentation/vm/hmm.rst.
>>>    *
>>> + * MEMORY_DEVICE_COHERENT:
>>> + * Device memory that is cache coherent from device and CPU point of view. This
>>> + * is used on platforms that have an advanced system bus (like CAPI or CXL). A
>>> + * driver can hotplug the device memory using ZONE_DEVICE and with that memory
>>> + * type. Any page of a process can be migrated to such memory. However no one
>> Any page might not be right, I'm pretty sure. ... just thinking about special pages
>> like vdso, shared zeropage, ... pinned pages ...
> 

Well, you cannot migrate long term pages, that's what I meant :)

>>
>>> + * should be allowed to pin such memory so that it can always be evicted.
>>> + *
>>>    * MEMORY_DEVICE_FS_DAX:
>>>    * Host memory that has similar access semantics as System RAM i.e. DMA
>>>    * coherent and supports page pinning. In support of coordinating page
>>> @@ -61,6 +68,7 @@ struct vmem_altmap {
>>>   enum memory_type {
>>>   	/* 0 is reserved to catch uninitialized type fields */
>>>   	MEMORY_DEVICE_PRIVATE = 1,
>>> +	MEMORY_DEVICE_COHERENT,
>>>   	MEMORY_DEVICE_FS_DAX,
>>>   	MEMORY_DEVICE_GENERIC,
>>>   	MEMORY_DEVICE_PCI_P2PDMA,
>>> @@ -143,6 +151,17 @@ static inline bool folio_is_device_private(const struct folio *folio)
>> In general, this LGTM, and it should be correct with PageAnonExclusive I think.
>>
>>
>> However, where exactly is pinning forbidden?
> 
> Long-term pinning is forbidden since it would interfere with the device 
> memory manager owning the
> device-coherent pages (e.g. evictions in TTM). However, normal pinning 
> is allowed on this device type.

I don't see updates to folio_is_pinnable() in this patch.

So wouldn't try_grab_folio() simply pin these pages? What am I missing?

-- 
Thanks,

David / dhildenb

