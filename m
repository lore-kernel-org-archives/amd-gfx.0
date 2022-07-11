Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07DA2CCA47B
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jul 2022 15:24:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C350D8D802;
	Mon, 11 Jul 2022 15:24:03 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FDA18E99B
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jul 2022 14:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1657548059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=th2buvr24d07qJGzIS/AKju5zI095zK3996wlFgRrAE=;
 b=EDR/Y/Y2m93fdLrIxehN8yy7/+YCBKpDqJM6EeRLznDItptSVoXC67yZjDxvoYX/S/7Cwx
 hebf17rmTIFYDmaArw+O6OKKfL14d5pL+N0R8Yn3rBvQhp6Ud88ykT+BFcyJC6FaDVUc4h
 NoKZY/QTEJoIVQ6CXDUxTTItrZzYZ0c=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-359-ubtaTlzYOh-erQymGJhUXw-1; Mon, 11 Jul 2022 10:00:58 -0400
X-MC-Unique: ubtaTlzYOh-erQymGJhUXw-1
Received: by mail-wm1-f69.google.com with SMTP id
 v123-20020a1cac81000000b003a02a3f0beeso5271938wme.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jul 2022 07:00:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:organization:in-reply-to
 :content-transfer-encoding;
 bh=th2buvr24d07qJGzIS/AKju5zI095zK3996wlFgRrAE=;
 b=blDuYqL0RRrbh9Tr/HZm6osr7nc2x2rCGBaovZSDS/Mc4+aHM05lv84o149tclrHXg
 oEYkT1+OcHi4TugTVT9z6Mj4VqSgkX9dDrqS6MH+VPxNrh8VrzYQ+lcU1MNIHoMUMYyI
 LfR8Kbz2Q/+EB7NG7h0ygF3XlKdoZeRQig9zcZvnIFHdSfHZp0DNg9/Xpra/7cGkbdS9
 vVpJ/Y6WusrHrn3MYUycIvBX/RiwD5FTxQqBTy0Ok9ZAUN65LH8LuSuSukxyzFsMnWjG
 fgYgJfZVML4nw/llg1zoto1LgIc2r87jbsMMP51W+6vzaotdM9x9uIWR+JPHjQhZKRfT
 cajQ==
X-Gm-Message-State: AJIora8lXQvuKlVrK6eSeLvJOeDZfagd207xL/KpWg2xO2m5fDg1jhIH
 W/EsGTSk5CZl1P/FcPNoMgCwBKTOn3Rc5yjgSab4Im0SCbCcytIR2+3URBgNd+oXGMhQwpCkGMt
 dv1XunxiihouUmGa1oYP4kL9kMw==
X-Received: by 2002:a5d:6dab:0:b0:21d:9fc8:3029 with SMTP id
 u11-20020a5d6dab000000b0021d9fc83029mr8016749wrs.172.1657548056005; 
 Mon, 11 Jul 2022 07:00:56 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tHUpdQt0jOB6/Le/88y5FMlWl7A0VwJVjWJ8qwyFnogYLhO4qiJJpxW2UhqlLHOVvPkjmbsQ==
X-Received: by 2002:a5d:6dab:0:b0:21d:9fc8:3029 with SMTP id
 u11-20020a5d6dab000000b0021d9fc83029mr8016733wrs.172.1657548055721; 
 Mon, 11 Jul 2022 07:00:55 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:1400:c3:4ae0:6d5c:1ab2?
 (p200300cbc702140000c34ae06d5c1ab2.dip0.t-ipconnect.de.
 [2003:cb:c702:1400:c3:4ae0:6d5c:1ab2])
 by smtp.gmail.com with ESMTPSA id
 f12-20020a05600c4e8c00b003a2cf17a894sm11063409wmq.41.2022.07.11.07.00.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Jul 2022 07:00:55 -0700 (PDT)
Message-ID: <4b2f9a61-ca67-6a34-41c9-c191cac756b3@redhat.com>
Date: Mon, 11 Jul 2022 16:00:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v8 07/15] mm/gup: migrate device coherent pages when
 pinning instead of failing
To: Matthew Wilcox <willy@infradead.org>
References: <20220707190349.9778-1-alex.sierra@amd.com>
 <20220707190349.9778-8-alex.sierra@amd.com>
 <2c4dd559-4fa9-f874-934f-d6b674543d0f@redhat.com>
 <Ysws7LOirtQ07JG/@casper.infradead.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Ysws7LOirtQ07JG/@casper.infradead.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 11 Jul 2022 15:24:02 +0000
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
 Felix.Kuehling@amd.com, apopple@nvidia.com, amd-gfx@lists.freedesktop.org,
 linux-xfs@vger.kernel.org, linux-mm@kvack.org, jglisse@redhat.com,
 dri-devel@lists.freedesktop.org, jgg@nvidia.com, akpm@linux-foundation.org,
 linux-ext4@vger.kernel.org, hch@lst.de
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 11.07.22 16:00, Matthew Wilcox wrote:
> On Mon, Jul 11, 2022 at 03:35:42PM +0200, David Hildenbrand wrote:
>>> +		/*
>>> +		 * Device coherent pages are managed by a driver and should not
>>> +		 * be pinned indefinitely as it prevents the driver moving the
>>> +		 * page. So when trying to pin with FOLL_LONGTERM instead try
>>> +		 * to migrate the page out of device memory.
>>> +		 */
>>> +		if (folio_is_device_coherent(folio)) {
>>> +			WARN_ON_ONCE(PageCompound(&folio->page));
>>
>> Maybe that belongs into migrate_device_page()?
> 
> ... and should be simply WARN_ON_ONCE(folio_test_large(folio)).
> No need to go converting it back into a page in order to test things
> that can't possibly be true.
> 

Good point.

-- 
Thanks,

David / dhildenb

