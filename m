Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE3A0D29DE8
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jan 2026 08:02:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 242F810E20F;
	Tue, 13 Jan 2026 08:02:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="Bat6wu0U";
	dkim-atps=neutral
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com
 [209.85.160.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9B0B10E41E
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Jan 2026 16:50:03 +0000 (UTC)
Received: by mail-qt1-f176.google.com with SMTP id
 d75a77b69052e-4fc42188805so69728261cf.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Jan 2026 08:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1768236603; x=1768841403; darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=eAxh70JY3ShLNfnDxBWsRZWpalCHcaRfsM5YzKZ+W9w=;
 b=Bat6wu0UmG9fuCZn5Iq+jd5OxvWiNpQdIq69eBLJAYXkYQWDeAMwNBJ5Y0b1/2B+d+
 B0G6komz5bqCZYsgSITfSNPdBzcVf0tjViU4xq+Txkgph+iNLcPkLZ7PFGAwpPwOuPkc
 iY8Czei3UIRUh5uOIZpQCl0QZHn9eYXAXI4kazYPlVShGUvbzk4nBmWxDV6oTIgkP4Bx
 qLNRohAt09eNZp4HJdf0cNdSZ1JNHeIBe75r/rx+lcKZhSuyD7Vclo2NzLgLCLq7nwoa
 dbeoOYpcoH3Mkui+6mbyEz1OJkRvlSAW+/48hQ3LQ754slxzzgbwEFseE7AAscvSfFVg
 8WOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768236603; x=1768841403;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eAxh70JY3ShLNfnDxBWsRZWpalCHcaRfsM5YzKZ+W9w=;
 b=O3I9W7e1ujfGpN762F8ENMY/JDZ/v4Frr98MtDz81G+qz8a80XRrAWdKj3eSQrS3IQ
 ZW1PqEs1jMaFEnfGQwJBMbpuUNV81WBBXIJqbriZ06/krmsnSbQMgWyT2C6g6vS0RsO1
 ge9BMcw/5yXiAH9ewjNI6Tfdl83V8hEsjNDFEkpxrSCrS+BIyGm3Cxmtzxwhq9akZYaP
 NXgknPXamQsTZi00kZqPchcFdEGoYXRpM8TZuDWpGm5rf44KvM3LEdIQCi96AwVUpc5F
 W0FmgOB5NOSoUaMryh9qnEAIKpgx1pI2emwWvzeL4uRI5NF2sNlReeixFwT00uZJk1mX
 X62Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9bmvt8QO7r0WTVJFyOH3OLa2V2O6M8X0ki0mQ5v+YxZGuiOuJjf0NopK5AXyP9wwQcMT0ERJA@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy+fyyKdVNpkMYW6krkapRK0kdLMovG8kAleHFywQdH9XU4NWuN
 orLnPUlAu8cGliXk+I3gnF3WWJKRXnXAhO2gTxyPDytYRM/11JmwrT6Zm2ej8r+MULE=
X-Gm-Gg: AY/fxX4FI18eBSAwgbxxDrSOfxqkhMqY8rWPnsIRJQFQ8hS19N9tqJRW7dTWbwe6Zqj
 on4M2/1tfq/CWRXF7luySo2B7K55tXoCXCHPpv8RLmuuBbM2QgN8QaYK/MxjFualjWJFiB2ZbiK
 fBq4WrsecfGuovyrtym2cVYWXdMkXiu+uk1ShJD2u6WmcCgN44zi9Qoi1aFpUtNGMh8bEiBBxkq
 0HgaYB1PbSjCewal+pK2W6BO4IXhC+k+G5yv+sgrzZRAPsvRNwR1102ADm8eDVuAjZyZxpL9gRX
 dkckY6SN+oZoLWbK+TihD5AEpomFUcnPKzTt3roipUKK7kyS9WodNGkszbKY7UXnX5z/ZVVd5dE
 v/kZqUg+0O1IdbUIiZUKp/de87NcUh7HQd9Z/8B1n17gPWjnzkkvLxaV3KcbWBz1EKJ6rAkBiBO
 0mtRsIomZnUL9yABmguwVuwS8hL2qbQj+En7e7gPzeuwiAOnAAVlGOc9QXjQaIOZPAuuQ=
X-Google-Smtp-Source: AGHT+IE/A98Uf8f6ySXPvh9xamBlLANpUoYS4iXttzp8YDJn905I/7mcjcPxPkNVMXbRPnmf8UaJPg==
X-Received: by 2002:ac8:6f1a:0:b0:4ee:208a:fbec with SMTP id
 d75a77b69052e-4ffb4a1ed32mr255276771cf.66.1768236602551; 
 Mon, 12 Jan 2026 08:50:02 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.112.119]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89077253218sm139285396d6.43.2026.01.12.08.50.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 08:50:02 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1vfL7B-00000003RcK-2R9k;
 Mon, 12 Jan 2026 12:50:01 -0400
Date: Mon, 12 Jan 2026 12:50:01 -0400
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
Message-ID: <20260112165001.GG745888@ziepe.ca>
References: <20260111205820.830410-1-francois.dugast@intel.com>
 <20260111205820.830410-2-francois.dugast@intel.com>
 <aWQlsyIVVGpCvB3y@casper.infradead.org>
 <874d29da-2008-47e6-9c27-6c00abbf404a@nvidia.com>
 <0D532F80-6C4D-4800-9473-485B828B55EC@nvidia.com>
 <20260112134510.GC745888@ziepe.ca>
 <218D42B0-3E08-4ABC-9FB4-1203BB31E547@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <218D42B0-3E08-4ABC-9FB4-1203BB31E547@nvidia.com>
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

On Mon, Jan 12, 2026 at 11:31:04AM -0500, Zi Yan wrote:
> > folio_free()
> >
> > 1) Allocator finds free memory
> > 2) zone_device_page_init() allocates the memory and makes refcount=1
> > 3) __folio_put() knows the recount 0.
> > 4) free_zone_device_folio() calls folio_free(), but it doesn't
> >    actually need to undo prep_compound_page() because *NOTHING* can
> >    use the page pointer at this point.
> > 5) Driver puts the memory back into the allocator and now #1 can
> >    happen. It knows how much memory to put back because folio->order
> >    is valid from #2
> > 6) #1 happens again, then #2 happens again and the folio is in the
> >    right state for use. The successor #2 fully undoes the work of the
> >    predecessor #2.
> 
> But how can a successor #2 undo the work if the second #1 only allocates
> half of the original folio? For example, an order-9 at PFN 0 is
> allocated and freed, then an order-8 at PFN 0 is allocated and another
> order-8 at PFN 256 is allocated. How can two #2s undo the same order-9
> without corrupting each other’s data?

What do you mean? The fundamental rule is you can't read the folio or
the order outside folio_free once it's refcount reaches 0.

So the successor #2 will write updated heads and order to the order 8
pages at PFN 0 and the ones starting at PFN 256 will remain with
garbage.

This is OK because nothing is allowed to read them as their refcount
is 0.

If later PFN256 is allocated then it will get updated head and order
at the same time it's refcount becomes 1.

There is corruption and they don't corrupt each other's data.

> > If the allocator is using the struct page memory then step #5 should
> > also clean up the struct page with the allocator data before returning
> > it to the allocator.
> 
> Do you mean ->folio_free() callback should undo prep_compound_page()
> instead?

I wouldn't say undo, I was very careful to say it needs to get the
struct page memory into a state that the allocator algorithm expects,
whatever that means.

Jason
