Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A5EFC433FE
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Mar 2022 13:05:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFC9C10E41B;
	Mon, 14 Mar 2022 13:05:38 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3B3910E67F
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Mar 2022 09:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646990172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EIGdPHjLg1hmetspOZdQaeJznczctW/NKNGy6+DAXDs=;
 b=UcdtxkZ0nU42xs84wkXeSqg5hsVAQXU72Gq9cdh0/yPjEKwptiEYktQ7KzWtuM1O+8JB6/
 4NHIYaQVafr0A675JjCIO7KYOLp4Rct/gdNoKg3u5xmjBoAr5Cee7OVQ/TNkbJYXkG4v/M
 MJwrXiljYtN1upzhsYAWme594iKu8UY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-298-X_jyiTglNxKeV8hTq5igrQ-1; Fri, 11 Mar 2022 04:16:11 -0500
X-MC-Unique: X_jyiTglNxKeV8hTq5igrQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 y13-20020adfee0d000000b001f1fa450a3dso2597202wrn.11
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Mar 2022 01:16:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent
 :content-language:to:cc:references:from:organization:subject
 :in-reply-to:content-transfer-encoding;
 bh=EIGdPHjLg1hmetspOZdQaeJznczctW/NKNGy6+DAXDs=;
 b=O0meE0zOKWzeazjx3fj/dy48Kg4ERwp4HO5y8UTJ6qFbF+wBUlqS8bdnjNil6SGveF
 ZH6eYykhjOheRiHuqk3P4aBraKqDBILk2H4yUZpkZGTf5RXCQpaUq9pRnVJdXdmN+yNr
 VNniuEuzeXumDfzfiBby7T9Bm9nOGRcaliOmnUD0J+PWfKzu54ObiJ+VknyoKqF4ewl1
 CWUrT/CDOAqMjn9UXrQElSFewkKwX414Cdj+ew4Z9fxGhv3e62adnVu17KsuVGSTJd8A
 29tTTuNoy9KHayEuKgYMuX0eAGfBzJc87B3rti80wiRvoG1Z1xCDhvRsGiD6osekMKrZ
 0Ufw==
X-Gm-Message-State: AOAM533ADMMKyRv+v9nh1TlyXX49vXQGK/VLbZCI7q7rlQyVuYdDwQiG
 dND0kDyfuDlpMILwxsB8cRVWrVP96XFmNqOgOjRigksRRKOUiykLsgKu0tl3rSLJtHJQGuZlM+X
 aVpWwO0QaL4sGFXm7qiOqrJNcbg==
X-Received: by 2002:a05:600c:4f0e:b0:389:eb27:581f with SMTP id
 l14-20020a05600c4f0e00b00389eb27581fmr2193351wmq.132.1646990169922; 
 Fri, 11 Mar 2022 01:16:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz66GE36RKglM3amxTnbF4SO/2NAriOwP++GkZh2LKs8fqberByaO4MYMTDcE67f9+yx5ejJw==
X-Received: by 2002:a05:600c:4f0e:b0:389:eb27:581f with SMTP id
 l14-20020a05600c4f0e00b00389eb27581fmr2193321wmq.132.1646990169610; 
 Fri, 11 Mar 2022 01:16:09 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:8200:163d:7a08:6e61:87a5?
 (p200300cbc7078200163d7a086e6187a5.dip0.t-ipconnect.de.
 [2003:cb:c707:8200:163d:7a08:6e61:87a5])
 by smtp.gmail.com with ESMTPSA id
 a8-20020a05600c068800b00389bdc8c8c2sm6270654wmn.12.2022.03.11.01.16.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Mar 2022 01:16:09 -0800 (PST)
Message-ID: <07401a0a-6878-6af2-f663-9f0c3c1d88e5@redhat.com>
Date: Fri, 11 Mar 2022 10:16:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
To: Alex Sierra <alex.sierra@amd.com>, jgg@nvidia.com
References: <20220310172633.9151-1-alex.sierra@amd.com>
 <20220310172633.9151-2-alex.sierra@amd.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 1/3] mm: split vm_normal_pages for LRU and non-LRU
 handling
In-Reply-To: <20220310172633.9151-2-alex.sierra@amd.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 14 Mar 2022 13:05:37 +0000
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

On 10.03.22 18:26, Alex Sierra wrote:
> DEVICE_COHERENT pages introduce a subtle distinction in the way
> "normal" pages can be used by various callers throughout the kernel.
> They behave like normal pages for purposes of mapping in CPU page
> tables, and for COW. But they do not support LRU lists, NUMA
> migration or THP. Therefore we split vm_normal_page into two
> functions vm_normal_any_page and vm_normal_lru_page. The latter will
> only return pages that can be put on an LRU list and that support
> NUMA migration, KSM and THP.
> 
> We also introduced a FOLL_LRU flag that adds the same behaviour to
> follow_page and related APIs, to allow callers to specify that they
> expect to put pages on an LRU list.
> 

I still don't see the need for s/vm_normal_page/vm_normal_any_page/. And
as this patch is dominated by that change, I'd suggest (again) to just
drop it as I don't see any value of that renaming. No specifier implies any.

The general idea of this change LGTM.


I wonder how this interacts with the actual DEVICE_COHERENT coherent
series. Is this a preparation? Should it be part of the DEVICE_COHERENT
series?

IOW, should this patch start with

"With DEVICE_COHERENT, we'll soon have vm_normal_pages() return
device-managed anonymous pages that are not LRU pages. Although they
behave like normal pages for purposes of mapping in CPU page, and for
COW, they do not support LRU lists, NUMA migration or THP. [...]"

But then, I'm confused by patch 2 and 3, because it feels more like we'd
already have DEVICE_COHERENT then ("hmm_is_coherent_type").


-- 
Thanks,

David / dhildenb

