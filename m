Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93344D29DEB
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jan 2026 08:02:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDF2A10E463;
	Tue, 13 Jan 2026 08:02:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="Ccmkqi1S";
	dkim-atps=neutral
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com
 [209.85.222.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F0AD10E2B1
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Jan 2026 19:28:19 +0000 (UTC)
Received: by mail-qk1-f174.google.com with SMTP id
 af79cd13be357-8be92e393f8so608774485a.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Jan 2026 11:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1768246098; x=1768850898; darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=a9AdLI7uJUYtOYd89GixDifcE7N5970uW2swaB6ncSw=;
 b=Ccmkqi1SsEOtm3ZU7Ws11jAuKhWF/D0sLD5Hn2H58ZM+OktVgBJ6+CH+PmPrcm34TT
 qoEfEP6dPxpWYw3+VCcB83NU8BoPJ30yUGNUsa42KnIK8pdX2ysoZzq2QkGVrFSW4S/+
 EoUfbuloGWx5kmzvViEb0QTUePypfweEdIYbsu9jdkgxIRF6CLjmXvkKAF0RusP4d9Xj
 DWhJXqBuzCnh1P7RqbQZzyBFeZNadxI/baj6zyKneT5Ihfz/RPRFoRKV2M83EjlIGvZO
 2b+j5EggJAM9goErNaStya+xrhi+v6icfYEJINtTCtBjXJQaOp/7ZCXqC7i2PVHJe82q
 bQbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768246098; x=1768850898;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a9AdLI7uJUYtOYd89GixDifcE7N5970uW2swaB6ncSw=;
 b=aKtkI3hDT+ONCFhdK7nnXkaKNphwmnwbxS36H2RmYo7np6Uu7zd/3DAqwh+81a/s8N
 1CWNVRJ1D+rkE7Y9sA9+oIoXlJJDeOvarvFLeDFnK78FDs1e2xXiGf2+H4cP4rx8NQdk
 6Q1IbPOcuzFndxQ2gfcr0iLlZsyA24sRiaWWL0Iz6FfdOhz/zwNkWfTzxfqfcZicxysv
 T60CAX2cBJ7un0XE7QB/B9/H0OhHXBIferRWvioTu+NGRPT8oMvWD3Ii2L4u71kT5CLR
 aBrwdzvPW+CLfrgCCrTmtqxSlwPpFNSLyrQX6mSw+R+fuMmcL9Ra93MU0Vk8yA5UVIBh
 fHqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKU5tlTwVh9kNjmnSKukVq6y7gL/5hACfB7ThVIDRkG//2j1g0QIkrlVaXiX09a/RvJWtWM5F0@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxc5886yGA8ZAS3hzHi9CNXgUU53jRVNkRhPCzUxaoAz4EBU+wJ
 vYA4MY+TDjbL5Bm31pdFFTIwXzkWbbcL70023egPVjcFIsMvT5tc3gXeaYOG8etaTVs=
X-Gm-Gg: AY/fxX4a2XHl32ew7Jn8qpTD+5z7g0lxHsmaGze+/4pnJEpgTCO8cz4mvQ6rLXl0Oaw
 nAWnACKD5VgpOC094E8dCQ6r/C2jWUf+qGqn9JmdTvlXt2Js99WXuwWy7ga+kAEGyYL0y2KTmuU
 bxxmxCPadEgJVrHRqvQuxJvrFk8g1XNS9hkWIsna2A4KMraLA2gDt6n78LcUpQ/7w5ML4O40kIn
 uORljgTm0l3+HoUA22lIMZTLqisf+soGfpV/k+gcIYIkT756QzB+dSM3s37eYpEZKdMO80siZ0V
 yN2HqR9w3i9OJ2W98GBaPDuTwGwT1qSb2x7yYEfCLESB40P88fWNANiPaEalOtbhFsuJxwgdPyw
 hL2oajslm1O2iAiX1ucNFp/Wr1enm1ao9NjdGMcTHdxex40339KBXkLw1Cc3r0d8ww1yJLI+ls5
 MMm4Jbiz0b0SoKn7uxop29LWNeQsrbh0SSnPIn9CKN+NMvvsG9GE1dJDJDUmhsvwUfAbA=
X-Received: by 2002:a05:620a:1726:b0:8b8:7f8d:c33b with SMTP id
 af79cd13be357-8c5208f18e3mr71372585a.43.1768246097807; 
 Mon, 12 Jan 2026 11:28:17 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.112.119]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c37f4cd7a3sm1609425185a.24.2026.01.12.11.28.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 11:28:16 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1vfNaK-00000003cxB-192v;
 Mon, 12 Jan 2026 15:28:16 -0400
Date: Mon, 12 Jan 2026 15:28:16 -0400
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
Message-ID: <20260112192816.GL745888@ziepe.ca>
References: <20260111205820.830410-2-francois.dugast@intel.com>
 <aWQlsyIVVGpCvB3y@casper.infradead.org>
 <874d29da-2008-47e6-9c27-6c00abbf404a@nvidia.com>
 <0D532F80-6C4D-4800-9473-485B828B55EC@nvidia.com>
 <20260112134510.GC745888@ziepe.ca>
 <218D42B0-3E08-4ABC-9FB4-1203BB31E547@nvidia.com>
 <20260112165001.GG745888@ziepe.ca>
 <86D91C8B-C3EA-4836-8DC2-829499477618@nvidia.com>
 <20260112182500.GI745888@ziepe.ca>
 <6AFCEB51-8EE1-4AC9-8F39-FCA561BE8CB5@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6AFCEB51-8EE1-4AC9-8F39-FCA561BE8CB5@nvidia.com>
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

On Mon, Jan 12, 2026 at 01:55:18PM -0500, Zi Yan wrote:
> > That's different, I am talking about reaching 0 because it has been
> > freed, meaning there are no external pointers to it.
> >
> > Further, when a page is frozen page_ref_freeze() takes in the number
> > of references the caller has ownership over and it doesn't succeed if
> > there are stray references elsewhere.
> >
> > This is very important because the entire operating model of split
> > only works if it has exclusive locks over all the valid pointers into
> > that page.
> >
> > Spurious refcount failures concurrent with split cannot be allowed.
> >
> > I don't see how pointing at __folio_freeze_and_split_unmapped() can
> > justify this series.
> >
> 
> But from anyone looking at the folio state, refcount == 0, compound_head
> is set, they cannot tell the difference.

This isn't reliable, nothing correct can be doing it :\

> If what you said is true, why is free_pages_prepare() needed? No one
> should touch these free pages. Why bother resetting these states.

? that function does alot of stuff, thinks like uncharging the cgroup
should obviously happen at free time.

What part of it are you looking at?

> > You can't refcount a folio out of nothing. It has to come from a
> > memory location that already is holding a refcount, and then you can
> > incr it.
> 
> Right. There is also no guarantee that all code is correct and follows
> this.

Let's concretely point at things that have a problem please.

> My point here is that calling prep_compound_page() on a compound page
> does not follow core MM’s conventions.

Maybe, but that doesn't mean it isn't the right solution..

Jason
