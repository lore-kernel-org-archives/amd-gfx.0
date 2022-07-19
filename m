Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23A63C43334
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jul 2022 12:55:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A90FB14A86D;
	Tue, 19 Jul 2022 12:55:21 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF0DE11B540
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Jul 2022 08:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658220062;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aCQLJQOHcJOJ8JmCqZRzHzMUpESxVjd3NNjhzKxLWQs=;
 b=Sk9pVL3nLTNm+GI2UzYgk45qGkMGxqaDTToP1XCcg5rG21ST6Mc/cGy56bbRxVk4oH3FW2
 dCBpyqFP/rK+T0gbeyQuDiE/eFoU0ZTDGHLm+5DoQiDa/VMbgCfw4LpFTpzACdZDk+V7nM
 nFLLkX4+j6eVLz3hIfH52RN/PZk9qgY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-630-_hZ_yvA4NZG76LR4d62SsQ-1; Tue, 19 Jul 2022 04:40:58 -0400
X-MC-Unique: _hZ_yvA4NZG76LR4d62SsQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 n21-20020a7bc5d5000000b003a2ff4d7a9bso5224570wmk.9
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Jul 2022 01:40:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:organization:in-reply-to
 :content-transfer-encoding;
 bh=aCQLJQOHcJOJ8JmCqZRzHzMUpESxVjd3NNjhzKxLWQs=;
 b=2hrf/vpI9qR5Staou6iWh3S4OvV+FIF8zA4KMm8w8MXoUQEDxi4vMohwhc6I+YCLgF
 he625paLi/ybxAfidPlYgIZDTsHJgF7naU3BR5qLZpXSx6PDJaAnnQlfqVwqpbpJz0D+
 PK3TxM0t5WGEyTk+2DP0IopxJDF1tBEywlS9ZcntRRqUjiHAS4KIQdXUPdRgifG38+0k
 2mKzXEIN/quJvlQKRU/ZFw+p1mAYkKLB1HELrxzZ/KwM/4VwKBHnTQ/IfnYMg33bsBPf
 NUGKNuCOPvQqKNmnxjyOCTQbLvlKadapj/2DlXiOK3+vmwNdhgf50+VyHvDlCQUbPon6
 f/zg==
X-Gm-Message-State: AJIora9XfeWg4Pz+2+i5cFlDYm6cyXUdxpwe/+GJhQJHIxk76LJTN3E4
 KC7HgV0W2lYN7M9OO6+C8H4i6EMw5H+qkCYLRCIb6D5yBa2dPG5T1OKmT87w8i/Zd8UbF9kngAg
 SdLotmlS2JtTEcwnW1t7Ce8/yaw==
X-Received: by 2002:a7b:c381:0:b0:3a2:aef9:8df4 with SMTP id
 s1-20020a7bc381000000b003a2aef98df4mr37053747wmj.7.1658220057356; 
 Tue, 19 Jul 2022 01:40:57 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1toW+ZoFXTJPEFs8reXmrBMtF0NaGli8q7vJKFZ+PCo4DXMfNrAYpetGiTuQdFEWq6RXg/h9w==
X-Received: by 2002:a7b:c381:0:b0:3a2:aef9:8df4 with SMTP id
 s1-20020a7bc381000000b003a2aef98df4mr37053722wmj.7.1658220057065; 
 Tue, 19 Jul 2022 01:40:57 -0700 (PDT)
Received: from ?IPV6:2003:cb:c709:600:7807:c947:bc5a:1aea?
 (p200300cbc70906007807c947bc5a1aea.dip0.t-ipconnect.de.
 [2003:cb:c709:600:7807:c947:bc5a:1aea])
 by smtp.gmail.com with ESMTPSA id
 j23-20020a05600c1c1700b003a32251c3f9sm1833646wms.5.2022.07.19.01.40.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Jul 2022 01:40:56 -0700 (PDT)
Message-ID: <d0e631e1-c7ef-4e03-6c34-189042b84005@redhat.com>
Date: Tue, 19 Jul 2022 10:40:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v9 06/14] mm/gup: migrate device coherent pages when
 pinning instead of failing
To: Andrew Morton <akpm@linux-foundation.org>
References: <20220715150521.18165-1-alex.sierra@amd.com>
 <20220715150521.18165-7-alex.sierra@amd.com>
 <225554c2-9174-555e-ddc0-df95c39211bc@redhat.com>
 <20220718133235.4fdbd6ec303219e5a3ba49cf@linux-foundation.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220718133235.4fdbd6ec303219e5a3ba49cf@linux-foundation.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 19 Jul 2022 12:55:20 +0000
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
 willy@infradead.org, Felix.Kuehling@amd.com, apopple@nvidia.com,
 amd-gfx@lists.freedesktop.org, linux-xfs@vger.kernel.org, linux-mm@kvack.org,
 jglisse@redhat.com, dri-devel@lists.freedesktop.org, jgg@nvidia.com,
 linux-ext4@vger.kernel.org, hch@lst.de
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 18.07.22 22:32, Andrew Morton wrote:
> On Mon, 18 Jul 2022 12:56:29 +0200 David Hildenbrand <david@redhat.com> wrote:
> 
>>>  		/*
>>>  		 * Try to move out any movable page before pinning the range.
>>>  		 */
>>> @@ -1919,7 +1948,8 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
>>>  				    folio_nr_pages(folio));
>>>  	}
>>>  
>>> -	if (!list_empty(&movable_page_list) || isolation_error_count)
>>> +	if (!list_empty(&movable_page_list) || isolation_error_count
>>> +		|| coherent_pages)
>>
>> The common style is to
>>
>> a) add the || to the end of the previous line
>> b) indent such the we have a nice-to-read alignment
>>
>> if (!list_empty(&movable_page_list) || isolation_error_count ||
>>     coherent_pages)
>>
> 
> I missed that.  This series is now in mm-stable so any fix will need to
> be a standalone followup patch, please.
> 
>> Apart from that lgtm.
>>
>> Reviewed-by: David Hildenbrand <david@redhat.com>
> 
> And your reviewed-by's will be lost.  Stupid git.

I know, I already raised my concerns regarding the new workflow, so I
won't repeat that. I can understand (too some degree) that we don't want
code to change just before the new merge window opens.

But I do wonder if we really don't even want to do subject+description
updates. Sure, the commit IDs will change. Who cares?

Anyhow, it is what it is.

-- 
Thanks,

David / dhildenb

