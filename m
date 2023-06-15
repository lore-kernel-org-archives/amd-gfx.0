Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3735EB64DA
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jun 2023 20:39:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7526710E1A0;
	Thu, 15 Jun 2023 20:39:18 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB9CA10E19A
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jun 2023 19:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686857599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qJ9fh5TisbZKUaORbgtmA89u4YsXzvNQtjxXBV2tisQ=;
 b=d9sXOwXaDHhdNS0y6w3eSf3HsBV/KvHRR4HlqjXjd+Ecl66bSy4lfTLObAWdq0y58XQMPy
 iL2mW1/UC7SQ9cZIbGgVaTOPYc/ermwd/62gKjv67I6HbBpfNG0NK2hog5SQ0veTUJjxR0
 3O2vkqvoNbuSIlnfnFbd3+2JWZNV38E=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-O4W5hEm-N0qrNlcDuR6LLw-1; Thu, 15 Jun 2023 15:33:18 -0400
X-MC-Unique: O4W5hEm-N0qrNlcDuR6LLw-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-62ffa1214edso104126d6.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jun 2023 12:33:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686857596; x=1689449596;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qJ9fh5TisbZKUaORbgtmA89u4YsXzvNQtjxXBV2tisQ=;
 b=VFZG+r//VVsQdn//YjOpbOHyH7HhcVIoRQdFjUwJ0ShzsdnCLLYc3GEmfanA8ZMRaq
 atfBfaKjCXIqzNodzQvw8ajFWws+bX+F7F2p1qXQf0KUnrWfDbus7QMjjpRd2d2a8lQC
 UycgP4zdnoisD8QHxGPqlEt3ZBXIDw7esQq3JhutdYdATRcDvf8dNE4OutRhMliBT8a4
 oOjFxSmBEuboZoQ0zpcwU+JgrhlNY+WGImICXWgMgdsmjS9btOqtrwEy2nWLvUoeht0J
 Gqau2KuSxg/OgMvESvj1kiUjkAPq/Hd3tIAfiLgoCsDsyZADV52ddUBnKNX9wJ8GJBud
 USaw==
X-Gm-Message-State: AC+VfDxikIBcMMwrC9v96WhLaFTGcqxwY8VnGhkrGRVwObI+L+3ULf4K
 AZb+6uf5spbgBcGDxaWLVRlM8+tGYp/s85j9i+q5NxrAgF+Zby8EcDyGtY+g2NryrMpEksdZG17
 9O1TtTtXOFgZkVoflzcYlwWnTfA==
X-Received: by 2002:ad4:5bca:0:b0:5ed:c96e:ca4a with SMTP id
 t10-20020ad45bca000000b005edc96eca4amr22503028qvt.1.1686857595848; 
 Thu, 15 Jun 2023 12:33:15 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5M13ke+gvL3VoDObxmyNhDkjVrjDagXp/R2MhL92zTstn0T61v6zTXVFTefmODf0p29xAboA==
X-Received: by 2002:ad4:5bca:0:b0:5ed:c96e:ca4a with SMTP id
 t10-20020ad45bca000000b005edc96eca4amr22503000qvt.1.1686857595549; 
 Thu, 15 Jun 2023 12:33:15 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 c20-20020a0cca14000000b0062ff47845fcsm719203qvk.48.2023.06.15.12.33.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jun 2023 12:33:14 -0700 (PDT)
Date: Thu, 15 Jun 2023 15:33:12 -0400
From: Peter Xu <peterx@redhat.com>
To: Alex Sierra <alex.sierra@amd.com>
Subject: Re: [PATCH v9 02/14] mm: move page zone helpers from mm.h to mmzone.h
Message-ID: <ZItneGX+sqg7WApF@x1n>
References: <20220715150521.18165-1-alex.sierra@amd.com>
 <20220715150521.18165-3-alex.sierra@amd.com>
MIME-Version: 1.0
In-Reply-To: <20220715150521.18165-3-alex.sierra@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Mailman-Approved-At: Thu, 15 Jun 2023 20:39:16 +0000
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
Cc: rcampbell@nvidia.com, willy@infradead.org, david@redhat.com,
 Felix.Kuehling@amd.com, apopple@nvidia.com, amd-gfx@lists.freedesktop.org,
 linux-xfs@vger.kernel.org, linux-mm@kvack.org, jglisse@redhat.com,
 dri-devel@lists.freedesktop.org, jgg@nvidia.com, akpm@linux-foundation.org,
 linux-ext4@vger.kernel.org, hch@lst.de
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hello, all,

On Fri, Jul 15, 2022 at 10:05:09AM -0500, Alex Sierra wrote:
> +static inline enum zone_type page_zonenum(const struct page *page)
> +{
> +	ASSERT_EXCLUSIVE_BITS(page->flags, ZONES_MASK << ZONES_PGSHIFT);
> +	return (page->flags >> ZONES_PGSHIFT) & ZONES_MASK;
> +}

Sorry to hijack this patch - not directly relevant to the movement, but
relevant to this helper, so maybe I can leverage the cc list..

My question is whether page_zonenum() is ready for taking all kinds of tail
pages?

Zone device tail pages all look fine, per memmap_init_zone_device().  The
question was other kinds of usual compound pages, like either thp or
hugetlb.  IIUC page->flags can be uninitialized for those tail pages.

Asking because I noticed it seems possible that page_zonenum() can just
take any random tail page as input, e.g.:

try_grab_folio -> is_pci_p2pdma_page -> is_zone_device_page -> page_zonenum

I'm worried it'll just read fake things, but maybe I just missed something?

Thanks,

-- 
Peter Xu

