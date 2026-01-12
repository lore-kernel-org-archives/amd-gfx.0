Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1755C9EC96
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Jan 2026 14:04:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53F7010E3D4;
	Mon, 12 Jan 2026 14:04:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="eXDhQoVq";
	dkim-atps=neutral
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com
 [209.85.160.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7A4C10E3CF
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Jan 2026 13:45:13 +0000 (UTC)
Received: by mail-qt1-f174.google.com with SMTP id
 d75a77b69052e-4ee1939e70bso72171561cf.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Jan 2026 05:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1768225513; x=1768830313; darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=oQVWjYpPCtwp4dXF89g7hQK6KDriflVp74tvOjx72Jc=;
 b=eXDhQoVq3DMjGm5amCRpyKArZcwdgs2ArRllGGKXLAhTvyOCAV8NrxAUn3MBMtS9Hv
 QZKutUpEg7Ub18ivE5xPSF+9WjWeQ/j2WcwfB9+Dv9S8IQQcLqcw3p54jKGtTO/pwc/G
 7B86l3qmVRclekBUeBYL3iCPW6STIadaC7zPkwDlQ31W04dtRczLinamSP8DHI4awyra
 XO9HUxy2Ijp1TXBErwBsQecD55vN+2Uf4CrPxtaJQiLnZVHMTo6fHX/JObgUK4SdSlUZ
 owY21399n1OxhTzu8nl5jztfAaK9oE6Z3LUO8F9r9dzmDB3+ZDO4Wxb40mQi75uxcrYL
 NZsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768225513; x=1768830313;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oQVWjYpPCtwp4dXF89g7hQK6KDriflVp74tvOjx72Jc=;
 b=Ks9lb8kMLXqtIMJvWfnoPqwXIaIOJ0ozk6DTtOOR6FRINvD9ABmjnAjsaAIY7R1EO/
 tAvPyKkHddsFgQHN46y9mStsfXFxTi2wSktM2fMcS8Rh8UNfcod2jiY3ZDtaAlQwDxhj
 NWM0iXqizK8joqy9827SfXvS7dng9VzXVbEpigc84Qb8eqinBjj9Izj53utb7YeBxOye
 o0LQPrkYb/V7HQC+3fZ7nTVTtF42n3EJwE3S8SnY9Cel1ONlF7C7/oxnvKBumeDa051Q
 leZrc1Q0d1yuzcmOHxgpK/zZR56PZb2tsqxXDNYp+TlRwqYxNtVOrq8XPO68JmmqS+9d
 R3BQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7twWY6Q6tepRD/5lhdfuQoYQXTN16S2x7NAo8d0sKFjIOgOO02uu2XmOBQe7xFLdqcq0JFH8p@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwvIu/Xm8RisGBSAVmZy5RrGPN6IJaAnRe+atY5+0DKrvb4yfBg
 ZtCNr3oJ6JhlzplOdNcVv4yKxEgO/N+FL50NfUMMPI0D6I6BGqSQdbzOwHbxGiH397w=
X-Gm-Gg: AY/fxX55oYUlltdw7SD+aBuVc79DmBtMTz5fiJz6Ntw2wrO73gbMvPiU1mTlcfje7OY
 g1n2RpuAvNsrDo/ZdByd8onqx4cTYJvt/Wz6EvKJaj6Kq5pd1HIcaVqAmElquNL3CisRsxtsqC8
 FKVWrY4QELP0trBC1XA8p9QAat2/3lXx8u6hC0K7XjSMcgHzM1Y3l+ciCjHIMd9G+6rjf3sTYKe
 sB9xBktwcDPteRvNjJZfQtOxv8lja0YkTbdib8ONEJ7CSFGfKMYUYegw1D13cPuzyXsO2YlMM2R
 HESGjZd8H9AeUNV9l0uSLanpX/pXwMYlgeooVWKMuz5sUWj3YhNsV473zlgrazVmCNBfjgYV1ex
 qS9OY7wcJ7hOT1JOFg5eqR/WgPeqTpJv5duzWfh6gNB3Bei5dahETDdIVkU9riKsFDi7IeYRPDi
 srTxpDvornOa9A9UBAgMulSkpfCiMRFbDqY8uug9IxvPyfP6UOXHEF8qzzL9o4rZZK1Tib7lt3M
 1Qa3A==
X-Google-Smtp-Source: AGHT+IG20+wZaR0cdbZzmqo1CbORIU0XkpxQP0kdASvCc3hNxGR2kbLwFGbi9bRoyfQYpJE34s/36Q==
X-Received: by 2002:ac8:7f4e:0:b0:4ed:6803:6189 with SMTP id
 d75a77b69052e-4ffb49998dfmr285683391cf.53.1768225512643; 
 Mon, 12 Jan 2026 05:45:12 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.112.119]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4ffa8e36232sm124159891cf.22.2026.01.12.05.45.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 05:45:11 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1vfIEI-00000003Q1m-3fo1;
 Mon, 12 Jan 2026 09:45:10 -0400
Date: Mon, 12 Jan 2026 09:45:10 -0400
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
Message-ID: <20260112134510.GC745888@ziepe.ca>
References: <20260111205820.830410-1-francois.dugast@intel.com>
 <20260111205820.830410-2-francois.dugast@intel.com>
 <aWQlsyIVVGpCvB3y@casper.infradead.org>
 <874d29da-2008-47e6-9c27-6c00abbf404a@nvidia.com>
 <0D532F80-6C4D-4800-9473-485B828B55EC@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0D532F80-6C4D-4800-9473-485B828B55EC@nvidia.com>
X-Mailman-Approved-At: Mon, 12 Jan 2026 14:04:34 +0000
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

On Sun, Jan 11, 2026 at 07:51:01PM -0500, Zi Yan wrote:
> On 11 Jan 2026, at 19:19, Balbir Singh wrote:
> 
> > On 1/12/26 08:35, Matthew Wilcox wrote:
> >> On Sun, Jan 11, 2026 at 09:55:40PM +0100, Francois Dugast wrote:
> >>> The core MM splits the folio before calling folio_free, restoring the
> >>> zone pages associated with the folio to an initialized state (e.g.,
> >>> non-compound, pgmap valid, etc...). The order argument represents the
> >>> folio’s order prior to the split which can be used driver side to know
> >>> how many pages are being freed.
> >>
> >> This really feels like the wrong way to fix this problem.
> >>
> 
> Hi Matthew,
> 
> I think the wording is confusing, since the actual issue is that:
> 
> 1. zone_device_page_init() calls prep_compound_page() to form a large folio,
> 2. but free_zone_device_folio() never reverse the course,
> 3. the undo of prep_compound_page() in free_zone_device_folio() needs to
>    be done before driver callback ->folio_free(), since once ->folio_free()
>    is called, the folio can be reallocated immediately,
> 4. after the undo of prep_compound_page(), folio_order() can no longer provide
>    the original order information, thus, folio_free() needs that for proper
>    device side ref manipulation.

There is something wrong with the driver if the "folio can be
reallocated immediately".

The flow generally expects there to be a driver allocator linked to
folio_free()

1) Allocator finds free memory
2) zone_device_page_init() allocates the memory and makes refcount=1
3) __folio_put() knows the recount 0.
4) free_zone_device_folio() calls folio_free(), but it doesn't
   actually need to undo prep_compound_page() because *NOTHING* can
   use the page pointer at this point.
5) Driver puts the memory back into the allocator and now #1 can
   happen. It knows how much memory to put back because folio->order
   is valid from #2
6) #1 happens again, then #2 happens again and the folio is in the
   right state for use. The successor #2 fully undoes the work of the
   predecessor #2.

If you have races where #1 can happen immediately after #3 then the
driver design is fundamentally broken and passing around order isn't
going to help anything.

If the allocator is using the struct page memory then step #5 should
also clean up the struct page with the allocator data before returning
it to the allocator.

I vaugely remember talking about this before in the context of the Xe
driver.. You can't just take an existing VRAM allocator and layer it
on top of the folios and have it broadly ignore the folio_free
callback.

Jsaon
