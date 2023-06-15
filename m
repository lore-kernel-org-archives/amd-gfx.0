Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CE63EB64DD
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jun 2023 20:57:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09F0F10E54B;
	Thu, 15 Jun 2023 20:57:45 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35B3510E543
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jun 2023 20:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686862145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hKMjMj3FplZLOT+91I/4pBUGTAnLqLsMd/PZxjoHeJI=;
 b=VY/RFTEH78npZ2CTBhF5QX5iCnMcei+jL8WXQQqyKKEyoDBcDVBUqSXm6Qtt6BcdnS0WJR
 kiXaSaQxKJOX6Ft/YrHFF6U9uKpCjmDP/WzrLexJijqkFdKoanwh90RmgPsqqrJ5qbLl3H
 Qotg2eKDcq/F0k7Enkev0BB/7FoQXaE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-4LKcPTaqOVqgJsbxrPs5xQ-1; Thu, 15 Jun 2023 16:49:01 -0400
X-MC-Unique: 4LKcPTaqOVqgJsbxrPs5xQ-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-62dd79f63e0so129546d6.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jun 2023 13:49:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686862141; x=1689454141;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hKMjMj3FplZLOT+91I/4pBUGTAnLqLsMd/PZxjoHeJI=;
 b=WX+loe8O7zxZdb94C714trwCJGLeF1z92bJCUAvZMk/4zVbalEgV6c91xSTEaWevND
 E0/HZ0DvJ3TTKq0kavKUtDf9uIb76O0wDq+k2f5D/bNUzVZlqatVH2PycDrrQLaCfrhb
 bnme7ho2haYAuclli/t3zltZ5xTTmUO/Akyz7uwQbh170Bm6waO6IFMz+jAKvYYcqE+q
 Jfb+NCMjkFZTQ5fV8jeJG8qFyoZZfpCKUf8bgae/qURy9gevBcyM/gzzxIidJGkwpo9T
 8Wd4jtjOB3PSpPqbP0M1WtXRq+ZP/Myxy6Tfq3IeQC4qBY05D99CjTkEo2IzV1fnQe46
 HMrw==
X-Gm-Message-State: AC+VfDzNT26YUYr40OGbWi26mwJOLI0KAQsDNg8nooyCCCyYtDn4kaP3
 bJAeYVG6RiJSqc46AIiAOlbLtbI2BLpK/ZgIoxcbXMxGeYoUAIms8Hi5a/5nnCmO0UHt6ohLu+g
 yI45EPhTgQqZuvH9AAS7SxZprnw==
X-Received: by 2002:a05:6214:411c:b0:62d:f62b:907 with SMTP id
 kc28-20020a056214411c00b0062df62b0907mr205922qvb.0.1686862140906; 
 Thu, 15 Jun 2023 13:49:00 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ67Q0T7UNcg441S5K48ufQ95OaInqX07S7iw3hjgHEcSdnXpq3izlYE7fKD1k9BhKtWSVJMmA==
X-Received: by 2002:a05:6214:411c:b0:62d:f62b:907 with SMTP id
 kc28-20020a056214411c00b0062df62b0907mr205893qvb.0.1686862140601; 
 Thu, 15 Jun 2023 13:49:00 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 d24-20020a05620a159800b0074a6c29df4dsm1117082qkk.119.2023.06.15.13.48.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jun 2023 13:48:59 -0700 (PDT)
Date: Thu, 15 Jun 2023 16:48:58 -0400
From: Peter Xu <peterx@redhat.com>
To: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v9 02/14] mm: move page zone helpers from mm.h to mmzone.h
Message-ID: <ZIt5Oho3enLFs+sv@x1n>
References: <20220715150521.18165-1-alex.sierra@amd.com>
 <20220715150521.18165-3-alex.sierra@amd.com> <ZItneGX+sqg7WApF@x1n>
 <ZItxXny9kRDq/ryf@casper.infradead.org>
MIME-Version: 1.0
In-Reply-To: <ZItxXny9kRDq/ryf@casper.infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Mailman-Approved-At: Thu, 15 Jun 2023 20:57:43 +0000
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
Cc: Alex Sierra <alex.sierra@amd.com>, rcampbell@nvidia.com, david@redhat.com,
 Felix.Kuehling@amd.com, apopple@nvidia.com, amd-gfx@lists.freedesktop.org,
 linux-xfs@vger.kernel.org, linux-mm@kvack.org, jglisse@redhat.com,
 dri-devel@lists.freedesktop.org, jgg@nvidia.com, akpm@linux-foundation.org,
 linux-ext4@vger.kernel.org, hch@lst.de
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jun 15, 2023 at 09:15:26PM +0100, Matthew Wilcox wrote:
> On Thu, Jun 15, 2023 at 03:33:12PM -0400, Peter Xu wrote:
> > My question is whether page_zonenum() is ready for taking all kinds of tail
> > pages?
> > 
> > Zone device tail pages all look fine, per memmap_init_zone_device().  The
> > question was other kinds of usual compound pages, like either thp or
> > hugetlb.  IIUC page->flags can be uninitialized for those tail pages.
> 
> I don't think that's true.  It's my understanding that page->flags is
> initialised for all pages in memmap at boot / hotplug / delayed-init
> time.  So you can check things like zone, node, etc on literally any
> page.  Contrariwise, those flags are not available in tail pages for
> use by the entity that has allocated a compound page / large folio.

Oh so the zone mask is special.  Fair enough.

> 
> Also, I don't believe zone device pages support compound allocation.
> I think they're always allocated as order-0.

Totally not familiar with zone device pages, but memmap_init_zone_device()
has pfns_per_compound which can be >1.  From there, memmap_init_compound()
does go ahead and setup pages as compound ones.

Thanks!

-- 
Peter Xu

