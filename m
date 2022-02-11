Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED35EC433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Feb 2022 17:06:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C73410EAA4;
	Fri, 11 Feb 2022 17:06:06 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EC2210EAC7
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Feb 2022 16:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644596130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bCRcaleTGgKZtCPcAf/F4rdGaJxNLIOVjEVDZ1rkuA8=;
 b=ZMOaPJX0suHtoX5wZ/XZylqdA1qglUQW62fMDpIidgOdUFTs14G1bspDCy5HLrc7k10/oi
 kKY4OFyJ6oR5tIh29a/VDEN6ZMvT+WOwnkLvlf+Ai+/yR67c/55rWBxNEniiDlY1twrmjM
 rnDNxxHY6hvvBUxyDm4UDFgD7NeuOEI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-21-CbKUMwmVMVGIy77TXyaEQQ-1; Fri, 11 Feb 2022 11:15:28 -0500
X-MC-Unique: CbKUMwmVMVGIy77TXyaEQQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 j8-20020adfc688000000b001e3322ced69so4032693wrg.13
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Feb 2022 08:15:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent
 :content-language:to:cc:references:from:organization:subject
 :in-reply-to:content-transfer-encoding;
 bh=bCRcaleTGgKZtCPcAf/F4rdGaJxNLIOVjEVDZ1rkuA8=;
 b=krHIp6hsW3faS+YO+b9zeOX+V9pw8BKCrGwUNzDJeYAmH4pj0GF4jB91NWU1HsXPVk
 m3tCWW1yCRwTHmrzT/XLeYvvSTsMYTxNGtBD8zota+aARs4W06GjwE2Vl3Nwu9UgIzmJ
 Ba7hz33Btq0RCKe+UurW8Y7dWY+knyj0MWRhF1FR9FBIU0rwxC3ez4dnGs6Z8fF5tLIy
 rlzy8Omaj/KHXJV2s5GggcM9EDLRB+TYzbpMZHWb5GX8Lquep0W34OERXJqDhaVHtkNZ
 9RyqM3in5nsLaMieA0qu4zfGJtMynC7qzAr7aAsXCkVAZ2LQEyuWBrY1Ppg4CLbEXxhP
 ljKg==
X-Gm-Message-State: AOAM533g1gzcejeodtgF1BXuAkEoTtz0mmDxrLiYS9jJWBJhbjQbr0l0
 KML0IMlNciXzuRvwl/5pR3HPZ1qtU8ZkCxNnarnNmbOp56Uro0kzL+Rf6dOzvNMBovS+EipAr5P
 XF6Wk1HaL9OFP6A5M/BbCMD9LSQ==
X-Received: by 2002:adf:f904:: with SMTP id b4mr1897422wrr.183.1644596127745; 
 Fri, 11 Feb 2022 08:15:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxxWjE7RoWsgISgQBtP4hRDQ/YRVeK6b5oKT74teyBVgT9eGeQ23Quvk5zgwZNMOVVwPpSm9A==
X-Received: by 2002:adf:f904:: with SMTP id b4mr1897388wrr.183.1644596127444; 
 Fri, 11 Feb 2022 08:15:27 -0800 (PST)
Received: from ?IPV6:2003:cb:c70c:aa00:4cc6:d24a:90ae:8c1f?
 (p200300cbc70caa004cc6d24a90ae8c1f.dip0.t-ipconnect.de.
 [2003:cb:c70c:aa00:4cc6:d24a:90ae:8c1f])
 by smtp.gmail.com with ESMTPSA id l21sm4770865wms.0.2022.02.11.08.15.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Feb 2022 08:15:26 -0800 (PST)
Message-ID: <beb38138-2266-1ff8-cc82-8fe914bed862@redhat.com>
Date: Fri, 11 Feb 2022 17:15:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
To: Alex Sierra <alex.sierra@amd.com>, akpm@linux-foundation.org,
 Felix.Kuehling@amd.com, linux-mm@kvack.org, rcampbell@nvidia.com,
 linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
References: <20220201154901.7921-1-alex.sierra@amd.com>
 <20220201154901.7921-2-alex.sierra@amd.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v6 01/10] mm: add zone device coherent type memory support
In-Reply-To: <20220201154901.7921-2-alex.sierra@amd.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 11 Feb 2022 17:06:05 +0000
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
Cc: willy@infradead.org, apopple@nvidia.com, dri-devel@lists.freedesktop.org,
 jglisse@redhat.com, amd-gfx@lists.freedesktop.org, jgg@nvidia.com, hch@lst.de
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 01.02.22 16:48, Alex Sierra wrote:
> Device memory that is cache coherent from device and CPU point of view.
> This is used on platforms that have an advanced system bus (like CAPI
> or CXL). Any page of a process can be migrated to such memory. However,
> no one should be allowed to pin such memory so that it can always be
> evicted.
> 
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
> Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
> Reviewed-by: Alistair Popple <apopple@nvidia.com>

So, I'm currently messing with PageAnon() pages and CoW semantics ...
all these PageAnon() ZONE_DEVICE variants don't necessarily make my life
easier but I'm not sure yet if they make my life harder. I hope you can
help me understand some of that stuff.

1) What are expected CoW semantics for DEVICE_COHERENT?

I assume we'll share them just like other PageAnon() pages during fork()
readable, and the first sharer writing to them receives an "ordinary"
!ZONE_DEVICE copy.

So this would be just like DEVICE_EXCLUSIVE CoW handling I assume, just
that we don't have to go through the loop of restoring a device
exclusive entry?

2) How are these pages freed to clear/invalidate PageAnon() ?

I assume for PageAnon() ZONE_DEVICE pages we'll always for via
free_devmap_managed_page(), correct?


3) FOLL_PIN

While you write "no one should be allowed to pin such memory", patch #2
only blocks FOLL_LONGTERM. So I assume we allow ordinary FOLL_PIN and
you might want to be a bit more precise?


... I'm pretty sure we cannot FOLL_PIN DEVICE_PRIVATE pages, but can we
FILL_PIN DEVICE_EXCLUSIVE pages? I strongly assume so?


Thanks for any information.

-- 
Thanks,

David / dhildenb

