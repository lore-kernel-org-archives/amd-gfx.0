Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E3BC43334
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jun 2022 01:04:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EBD010E054;
	Thu, 30 Jun 2022 01:04:24 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75DED10E3B7
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jun 2022 22:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656540912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JfIp4/8d6FKNViDaImkd8XOnHcFGT6GmiXjgK1Qhx+g=;
 b=P8sYflo74DRNJ42D2jMyIZcNApMzP93uObhdP8uHgsK0YTt1LrFY5C1YKopAagKoVlu4/0
 4zVKg+W6x5xoxfcT3a0OXvmF+2o01zISR1aXEgQ++HZ8cpp0r9Q/FXx0p0L+7XBLGj4sDm
 CArzgoek8nSauIZ5ZX0G6SKy7c+SE84=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-379-WSkVBt4iMCKRadaA8-VdQA-1; Wed, 29 Jun 2022 18:15:09 -0400
X-MC-Unique: WSkVBt4iMCKRadaA8-VdQA-1
Received: by mail-wm1-f71.google.com with SMTP id
 n15-20020a05600c4f8f00b0039c3e76d646so408368wmq.7
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jun 2022 15:15:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:organization:in-reply-to
 :content-transfer-encoding;
 bh=JfIp4/8d6FKNViDaImkd8XOnHcFGT6GmiXjgK1Qhx+g=;
 b=42BR/h/mS7qs+0tPh02zOBH0aYb3tUeBqj8LYbb0agm4B2SBUuY3AZB90DW3yY/Lr3
 tR4Mrn8v9vUGecEx6rnHsXWRaPeyc3TsH3QfGzsy2jLw2Mq0ujz8BxRtmUZB9Y20e/vw
 Vkq6+QlqQmwEC9ZM1Qrg+rKT++m3ouj4n6AMmYFjzNjvWpW4zx5urJzLQCduroxqRi0U
 7Oj3BwK0hDrnslnE9Pv6M3dtkVfAojZeTasQiZUn9CCe65ifAnzO5gg1sCR4wmMpSway
 hqyXmVPpjW5PRNF/5tdpHhAIlmKz17BssNtI0D+4GVY1ExyOeKammC61Lqh6wUVocRh9
 wkjw==
X-Gm-Message-State: AJIora+vCdtnNrJrlWk9Kf6fDyPVlpNcMfF7QUwXyIb18wsl4xf/ePZL
 RgC3s63DYwanGrl/o3qeGP3//bbOS2V5ZYWG9QghLAA2snBzN3TJCVxouMyAjPwdK84Nky+RXWp
 x9388pBklB6rvYQFSPQOuWoT5KA==
X-Received: by 2002:a5d:5481:0:b0:21a:3573:def0 with SMTP id
 h1-20020a5d5481000000b0021a3573def0mr5049187wrv.28.1656540908359; 
 Wed, 29 Jun 2022 15:15:08 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t5fcdInM+cviZFvBrEBaCvHGKr28RaqkJjmjlhZihtB4ptS3bDvlPUJ4iGFvCByQR4VNIvKw==
X-Received: by 2002:a5d:5481:0:b0:21a:3573:def0 with SMTP id
 h1-20020a5d5481000000b0021a3573def0mr5049172wrv.28.1656540908120; 
 Wed, 29 Jun 2022 15:15:08 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:e600:d4fa:af4b:d7b6:20df?
 (p200300cbc708e600d4faaf4bd7b620df.dip0.t-ipconnect.de.
 [2003:cb:c708:e600:d4fa:af4b:d7b6:20df])
 by smtp.gmail.com with ESMTPSA id
 e20-20020a5d5954000000b0020fcaba73bcsm17891932wri.104.2022.06.29.15.15.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jun 2022 15:15:07 -0700 (PDT)
Message-ID: <49315889-96de-8e41-f8ee-dd5b33c5e1db@redhat.com>
Date: Thu, 30 Jun 2022 00:15:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v7 01/14] mm: rename is_pinnable_pages to
 is_pinnable_longterm_pages
To: Felix Kuehling <felix.kuehling@amd.com>, Alex Sierra
 <alex.sierra@amd.com>, jgg@nvidia.com
References: <20220629035426.20013-1-alex.sierra@amd.com>
 <20220629035426.20013-2-alex.sierra@amd.com>
 <f00f9c93-c115-d222-dc8c-11493ccd2567@redhat.com>
 <575b48a6-e372-acda-9a7c-449f307a588c@amd.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <575b48a6-e372-acda-9a7c-449f307a588c@amd.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 30 Jun 2022 01:04:23 +0000
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

On 30.06.22 00:08, Felix Kuehling wrote:
> On 2022-06-29 03:33, David Hildenbrand wrote:
>> On 29.06.22 05:54, Alex Sierra wrote:
>>> is_pinnable_page() and folio_is_pinnable() were renamed to
>>> is_longterm_pinnable_page() and folio_is_longterm_pinnable()
>>> respectively. These functions are used in the FOLL_LONGTERM flag
>>> context.
>> Subject talks about "*_pages"
>>
>>
>> Can you elaborate why the move from mm.h to memremap.h is justified?
> 
> Patch 2 adds is_device_coherent_page in memremap.h and updates 
> is_longterm_pinnable_page to call is_device_coherent_page. memremap.h 
> cannot include mm.h because it is itself included by mm.h. So the choice 
> was to move is_longterm_pinnable_page to memremap.h, or move 
> is_device_coherent_page and all its dependencies to mm.h. The latter 
> would have been a bigger change.

I really don't think something mm generic that compiles without
ZONE_DEVICE belongs into memremap.h. Please find a cleaner way to get
this done.

-- 
Thanks,

David / dhildenb

