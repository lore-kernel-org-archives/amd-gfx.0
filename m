Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BF26D29DEC
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jan 2026 08:02:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E75510E45E;
	Tue, 13 Jan 2026 08:02:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="cBOFG4CO";
	dkim-atps=neutral
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com
 [209.85.219.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 657C910E2A9
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Jan 2026 18:25:02 +0000 (UTC)
Received: by mail-qv1-f51.google.com with SMTP id
 6a1803df08f44-88a3d2f3299so80170616d6.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Jan 2026 10:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1768242301; x=1768847101; darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jdD8MqriJAO2uyiGLSo7KkiIHx3VWLqLd6aNoF+yCm8=;
 b=cBOFG4COn080/Z9WyuXlRr5Hmz1BcShow5odAyVjyHl3IRLTtJtfJqpjcbq5hh0YrW
 02/bX717yrcfeaiak5ki+toH7fY3NSAMJm6V2F5egXvX/1GJiqFNdRqYtaV6lj5VBEnB
 UqkxF8CvbNgl0wFjUdO/zrbBQJZp2yT0o8PlNxQ0XitC9cnWFdws7i/aCojKM4DPUJ+Z
 oMdaMjP8sdKNimU5d+8AiuK7W/SScVJwbwr4htL5TJaJfOX2AkC6mNW26REdO0KqZhAV
 Q/ppKZx+6m0LfIn/MmB9sxEUE8GoWMJCSyK0Qd+COSA9iWe3L0eavbiSpvlD4MZIKR5/
 HlPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768242301; x=1768847101;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jdD8MqriJAO2uyiGLSo7KkiIHx3VWLqLd6aNoF+yCm8=;
 b=AL9boszE4xWnpN16iwnp7mAuWRoiyjFntNcAb0wVCmqRU7+9upmsLLX5PwTr6GhwiQ
 dffulJKJagLer+h+egP3qpuVmkWkpUmjRgeGUJq61YehHsGGrzkXluhAO9zhtoEeFpb3
 7l+NEWzzE5Ex8jH/kezOmRQN846jGM5Lcjfsiffux7YdKP/1CWXqpI4i7Kngo+Q9FtCz
 /OUIFE6BUD4z9ZvxvVTQyhyrkMVtD9qbPDkC90Z7/K4CsiWYAXxD1EzjEIS8aSOfi+h3
 LXTttDfGxrmUlb11biE4XHWC17vC3hY9WQXUg5QbJe+Aw0xJ78sXR1Q1CBiyjxmguV71
 52UQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjDRo5Tw7km5bKaUP8GNNbo8gAmjGELb5xXNyKmHA4sS8yYAHrzDTt08g32xmoAzf/SGbJwY06@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy7ZGL9UO61gNR3lQbgoPvPlo7UXsOztwsrvTxYymzVScE+5uZi
 0zzgDOm8KJuNqxBAlZ8HcfVqClGTMd72qgaxnBrc0mM0PD1ArXlMlBonLtnJVDyHlOc=
X-Gm-Gg: AY/fxX6rUXstNlnMgoP/4zNlNexAGC3n1I/wPRGDgMDXQPxs9nzOwGqwDsi7B3JCBxK
 r19JiuIxhf/a88ZNMzUfWXgUiK7Pbm5ax6D8HxxDAHwH24iVdOOZj8LQUp0rBx4aFFLyQ3fkD4z
 oVS90KSiVZHQKoFdHQ1nvTPXoXTVduAWrMDbPOM/RbcJLhgcSlSOs3jNomkWUpNVy0kZV237VsM
 gJ7iAper7jWRZ5tYsjyO6cpD3PQLyaYDCXC0bjPjy26AL3xEZQMIcapv9hjim+gGcVjLtBBuRhy
 QCJnSqvluVDu0TGK1OZMvYeEiIoCTbnA0+KaRCycbTDWgU3LiYkRuxLEnXi0C5qThcuDVSC+5sR
 1e9noJC2MdLQ1dx+siAWsSOgxOpdFZ7paZAYXn/pAXodezm6XqbjvCrfztmgIhKdoA8H5x/zbFN
 ONcBnbIzC0DTQpZcbr3hJyicKnOqW0RGczaR1yx+NT1ERgDANY6XIvf3PWZ/jmVz9WUmI=
X-Google-Smtp-Source: AGHT+IGn2SBiEVfPnYP4nrga1XlmOOc9x/h3J7lqU+usVoOUoaNofJJs2v26tTONjDwmwZ1AsmIeFg==
X-Received: by 2002:a05:6214:428e:b0:88e:9f73:2c08 with SMTP id
 6a1803df08f44-89084179da3mr258471116d6.5.1768242300986; 
 Mon, 12 Jan 2026 10:25:00 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.112.119]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-890770ce985sm138366276d6.11.2026.01.12.10.25.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 10:25:00 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1vfMb6-00000003SfZ-05E0;
 Mon, 12 Jan 2026 14:25:00 -0400
Date: Mon, 12 Jan 2026 14:25:00 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zi Yan <ziy@nvidia.com>
Cc: Matthew Wilcox <willy@infradead.org>, Balbir Singh <balbirs@nvidia.com>,
 Francois Dugast <francois.dugast@intel.com>,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Matthew Brost <matthew.brost@intel.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>,
 David Hildenbrand <david@kernel.org>, Oscar Salvador <osalvador@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 Leon Romanovsky <leon@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Alistair Popple <apopple@nvidia.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-pci@vger.kernel.org, linux-mm@kvack.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v4 1/7] mm/zone_device: Add order argument to folio_free
 callback
Message-ID: <20260112182500.GI745888@ziepe.ca>
References: <20260111205820.830410-1-francois.dugast@intel.com>
 <20260111205820.830410-2-francois.dugast@intel.com>
 <aWQlsyIVVGpCvB3y@casper.infradead.org>
 <874d29da-2008-47e6-9c27-6c00abbf404a@nvidia.com>
 <0D532F80-6C4D-4800-9473-485B828B55EC@nvidia.com>
 <20260112134510.GC745888@ziepe.ca>
 <218D42B0-3E08-4ABC-9FB4-1203BB31E547@nvidia.com>
 <20260112165001.GG745888@ziepe.ca>
 <86D91C8B-C3EA-4836-8DC2-829499477618@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <86D91C8B-C3EA-4836-8DC2-829499477618@nvidia.com>
X-Mailman-Approved-At: Tue, 13 Jan 2026 08:02:37 +0000
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jan 12, 2026 at 12:46:57PM -0500, Zi Yan wrote:
> On 12 Jan 2026, at 11:50, Jason Gunthorpe wrote:
> 
> > On Mon, Jan 12, 2026 at 11:31:04AM -0500, Zi Yan wrote:
> >>> folio_free()
> >>>
> >>> 1) Allocator finds free memory
> >>> 2) zone_device_page_init() allocates the memory and makes refcount=1
> >>> 3) __folio_put() knows the recount 0.
> >>> 4) free_zone_device_folio() calls folio_free(), but it doesn't
> >>>    actually need to undo prep_compound_page() because *NOTHING* can
> >>>    use the page pointer at this point.
> >>> 5) Driver puts the memory back into the allocator and now #1 can
> >>>    happen. It knows how much memory to put back because folio->order
> >>>    is valid from #2
> >>> 6) #1 happens again, then #2 happens again and the folio is in the
> >>>    right state for use. The successor #2 fully undoes the work of the
> >>>    predecessor #2.
> >>
> >> But how can a successor #2 undo the work if the second #1 only allocates
> >> half of the original folio? For example, an order-9 at PFN 0 is
> >> allocated and freed, then an order-8 at PFN 0 is allocated and another
> >> order-8 at PFN 256 is allocated. How can two #2s undo the same order-9
> >> without corrupting each other’s data?
> >
> > What do you mean? The fundamental rule is you can't read the folio or
> > the order outside folio_free once it's refcount reaches 0.
> 
> There is no such a rule. In core MM, folio_split(), which splits a high
> order folio to low order ones, freezes the folio (turning refcount to 0)
> and manipulates the folio order and all tail pages compound_head to
> restructure the folio.

That's different, I am talking about reaching 0 because it has been
freed, meaning there are no external pointers to it.

Further, when a page is frozen page_ref_freeze() takes in the number
of references the caller has ownership over and it doesn't succeed if
there are stray references elsewhere.

This is very important because the entire operating model of split
only works if it has exclusive locks over all the valid pointers into
that page.

Spurious refcount failures concurrent with split cannot be allowed.

I don't see how pointing at __folio_freeze_and_split_unmapped() can
justify this series.

> Your fundamental rule breaks this.  Allowing compound information
> to stay after a folio is freed means you cannot tell whether a folio
> is under split or freed.

You can't refcount a folio out of nothing. It has to come from a
memory location that already is holding a refcount, and then you can
incr it.

For example lockless GUP fast will read the PTE, adjust to the head
page, attempt to incr it, then recheck the PTE.

If there are races then sure maybe the PTE will point to a stray tail
page that refers to an already allocated head page, but the re-check
of the PTE wille exclude this. The refcount system already has to
tolerate spurious refcount incrs because of GUP fast.

Nothing should be looking at order and refcount to try to guess if
concurrent split is happening!!

Jason
