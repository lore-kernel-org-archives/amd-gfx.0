Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF8F1C43334
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jul 2022 15:24:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6188C8B043;
	Mon, 11 Jul 2022 15:24:03 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A493E8E933
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jul 2022 13:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1657547767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aE4NfC1H6uTSXnC9kdw86YADNW6bGnH63De3NmdMle8=;
 b=e6RivnbbiE1h4HJY/+H4UCT4z+NXBlSJ0c96XcAi06GdabYx8AD6UIMDNXH5i26hcolPVF
 rHmcIlKJJ8zWC4c7OCt14ZaPJCxAjcSQ/ENaN2dg40Yd/a9nNnMsKJk+w1IVee3lcjf6po
 Puju8Nr1GBSs0Dls3a4EEcrSVZ7V4Ng=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-253-mS-LnJIcN422NpXPCodHfg-1; Mon, 11 Jul 2022 09:56:06 -0400
X-MC-Unique: mS-LnJIcN422NpXPCodHfg-1
Received: by mail-wm1-f72.google.com with SMTP id
 r186-20020a1c44c3000000b003a2daf644f9so4964415wma.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jul 2022 06:56:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:organization:in-reply-to
 :content-transfer-encoding;
 bh=aE4NfC1H6uTSXnC9kdw86YADNW6bGnH63De3NmdMle8=;
 b=RxWZ/bzwQC7mF2mrAH2+fqVn7DEXqk98Sa4x9ziBxcqSiYGuKUPrBUYVjsSkCJK9hn
 g9vhGVAnG4ZzZ3CfpkmxSpNGmO3h7bwbOkirbeul4daRjq65pyzWDEJbjKJ6l1ldOxLo
 lXU/U0tlM7OaKoUm5NkdFMn9blTaYWoL7yWue4mYaX681wGYKiqD5Jrrt02WPRjfCLlb
 cCpyQ+9twcxS7hZiCa5wbRyQGoXR8SsDCrb4+EBlgA9t5yLzlABEu9vi+wkIB/l+8viL
 L03UmdzspnOwq20Z/Fy+9uxX9d3r70CQOkxKfKGJqGSYX/WoZFG7arMJT8majXvqpyyB
 PvMg==
X-Gm-Message-State: AJIora8BENNo3Db4L5EzT1xwU0p6wlPAMBMmLIhb+J/wTZx8Iv7ca3Yp
 ayTAsfymZM2lYXqFgz78ENRU/4UuVSzAtwUIlPOuU6QjcD3Q11XrJZNXIf0AARerjiUOmWBD2Qt
 IBSVPOxk067fEOjrxnzGdks+XLg==
X-Received: by 2002:a5d:6e85:0:b0:21d:65ec:22d with SMTP id
 k5-20020a5d6e85000000b0021d65ec022dmr17110874wrz.435.1657547765483; 
 Mon, 11 Jul 2022 06:56:05 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1twv2L3ZevD/RVvtfPY4LjhC4WGJFMlZ2FQQkXXNrSvlcGGqG7Pzzjip3VPLrNidVEXGx3eVw==
X-Received: by 2002:a5d:6e85:0:b0:21d:65ec:22d with SMTP id
 k5-20020a5d6e85000000b0021d65ec022dmr17110860wrz.435.1657547765208; 
 Mon, 11 Jul 2022 06:56:05 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:1400:c3:4ae0:6d5c:1ab2?
 (p200300cbc702140000c34ae06d5c1ab2.dip0.t-ipconnect.de.
 [2003:cb:c702:1400:c3:4ae0:6d5c:1ab2])
 by smtp.gmail.com with ESMTPSA id
 p18-20020a05600c359200b003a2e2ba94ecsm5925143wmq.40.2022.07.11.06.56.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Jul 2022 06:56:04 -0700 (PDT)
Message-ID: <2ff85751-b0b6-eaa6-8338-2bf03ba6e973@redhat.com>
Date: Mon, 11 Jul 2022 15:56:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v8 02/15] mm: move page zone helpers into new
 header-specific file
To: Felix Kuehling <felix.kuehling@amd.com>, Alex Sierra
 <alex.sierra@amd.com>, jgg@nvidia.com
References: <20220707190349.9778-1-alex.sierra@amd.com>
 <20220707190349.9778-3-alex.sierra@amd.com>
 <97816c26-d2dd-1102-4a13-fafb0b1a4bc3@redhat.com>
 <715fc1ae-7bd3-5b96-175c-e1cc74920739@amd.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <715fc1ae-7bd3-5b96-175c-e1cc74920739@amd.com>
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
Cc: rcampbell@nvidia.com, willy@infradead.org, apopple@nvidia.com,
 dri-devel@lists.freedesktop.org, linux-xfs@vger.kernel.org, linux-mm@kvack.org,
 jglisse@redhat.com, amd-gfx@lists.freedesktop.org, akpm@linux-foundation.org,
 linux-ext4@vger.kernel.org, hch@lst.de
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 08.07.22 23:25, Felix Kuehling wrote:
> On 2022-07-08 07:28, David Hildenbrand wrote:
>> On 07.07.22 21:03, Alex Sierra wrote:
>>> [WHY]
>>> Have a cleaner way to expose all page zone helpers in one header
>> What exactly is a "page zone"? Do you mean a buddy zone as in
>> include/linux/mmzone.h ?
>>
> Zone as in ZONE_DEVICE. Maybe we could extend mmzone.h instead of 

Yes, I think so. And try moving as little as possible in this patch.

> creating page_zone.h? That should work as long as it's OK to include 
> mmzone.h in memremap.h.

I think so.

-- 
Thanks,

David / dhildenb

