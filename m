Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02561D29DEA
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jan 2026 08:02:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8326510E45D;
	Tue, 13 Jan 2026 08:02:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="Q2NOZwtF";
	dkim-atps=neutral
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com
 [209.85.160.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E828710E43F
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Jan 2026 23:54:16 +0000 (UTC)
Received: by mail-qt1-f173.google.com with SMTP id
 d75a77b69052e-4ffbea7fdf1so35462761cf.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Jan 2026 15:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1768262056; x=1768866856; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vbQpTPqvkNza84fX2uyalXQvb9OzER6/e1aJC0fiWDY=;
 b=Q2NOZwtFeLszSK58JN3g3M62saQEAA7XnwRLb/YuxZuzmq2Eh4Km8kPd77/O7QCIRX
 XFOLTjgGH7xzV/1iMfBj+Vk/rBvYMLwYx2/gdHPUJqZl0X6S+nmsZFBa9ifmSFjMVsza
 aOQunpoTyykCKn7ngM5XRNrkmShLyOEck7n6H3c+ZAs90ImXxPLDtKOcrTjNaKUh+zFs
 fslXXfxn/upVoIia3BxXhvgJ9CrYm7G0sHtcqPS/+XGzMMZKUDpNr1P7ijyBf9uTSF4q
 +I06FMcMoRBia6knvy1IHzQliv48sJL5mygSH3K4SkxC3rK/OoSvpx7qmtFWmqPYDitQ
 e1Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768262056; x=1768866856;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vbQpTPqvkNza84fX2uyalXQvb9OzER6/e1aJC0fiWDY=;
 b=pH23RBQ09/RM97uoZVtjibonbcMzr7H+oR+bfM8iGT8o4Eu1/E46cJ7MmegawHpoYy
 aGNgWHuoQSZMM0lpr8J+bRt+Uiexp9TRNeIuXusXJ0xMH5fVEGF/VtMEPvLlewdfhvzt
 akGpH4IG1NG6aYP0H2mZ1k9iROHgaz51QLmFEC2gA3sDSpPfQMLKIND6tWr7nGhu220X
 pbY7V5SQZwWyn488JaKRZcFSB/CUERlxZh2t3Ouie+PVvZmHiOqOmEr+60RG+77IN2Um
 kvs3ra4XQfINqJnmx/14HithNz+gAPYBJYumb9Z01dElmpIOcOpccuxhECQgQ4XxJJfL
 f/SQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9YyOQ57ieQeUmzjcVsCCHLmB6pUrZ5T7lw+LEYOp1f+tuGwoeoUMJyZi/v7GarljjusvtW8he@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyqFAFEEPYNHNm/EC0a18EF500n8WLk4ZFExEq4U2dhREHwFXyR
 ADoL4kDqSuSi/P7Z6RLyB5bXcpz0h1uJsW5taD5I2HthFmBIoV3c0rvUjdSstHV4P4Y=
X-Gm-Gg: AY/fxX7cy62umo6WIfLEBWOwo7TDW0GXe2YvszRlrlepAcwdJvWE3KoZ6+989o5nNs8
 68t2JDgC16bQO4Z3vIE9FcgQyNU/Qvdw4lbYjTG+DhXt/Vwfw/YXZDtbR5G/bxZ3HWINqpInm1x
 lizPXlwh9pH1KVBLQARDFYOrJQfIiVYb8hoqjUTsTcAgIfzZI2wpGwEE8J3eHBjElAwbtC4qQRM
 gSISaAzW9kNQ8tE7f4sj7/+TeFVFwzxCbXeLHiAMUS3BidlgyowBI1eB0T558o8WTPRxrbNAhc4
 StS4LM/CKKDXm0m291NkHkoS2tuwI2eXF1/D1JNDMQgY4/MCmBv+5dOG/5aI/HbO2OC/NgJvOri
 jIWD52nIu8QpfE0VIeGvrl5IcVDZTXZ3oEa2QhjbRsawYp2pMaJaQlbJa7TTZjrc/1/ObEZYUBU
 nz/o8JnEUK/ttFHLjOpfIyfB2bHPecko2Bj7GhgDL46NhHcT045VhEytNGnaOOyjRBOC0=
X-Google-Smtp-Source: AGHT+IFqShnh4nFq4FI+txOqV94h9FNeJmPa4/JUWRJXzRBu2Yp6JXhvTMJ52+U7dVhw4CMApET5TA==
X-Received: by 2002:a05:622a:8d1b:b0:501:3b8c:7d63 with SMTP id
 d75a77b69052e-5013b8c8686mr4698571cf.26.1768262055766; 
 Mon, 12 Jan 2026 15:54:15 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.112.119]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4ffa8e35dbfsm129011631cf.19.2026.01.12.15.54.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 15:54:15 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1vfRji-00000003fUm-0uFg;
 Mon, 12 Jan 2026 19:54:14 -0400
Date: Mon, 12 Jan 2026 19:54:14 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alistair Popple <apopple@nvidia.com>
Cc: Matthew Brost <matthew.brost@intel.com>, Zi Yan <ziy@nvidia.com>,
 Matthew Wilcox <willy@infradead.org>, Balbir Singh <balbirs@nvidia.com>,
 Francois Dugast <francois.dugast@intel.com>,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
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
 Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-pci@vger.kernel.org, linux-mm@kvack.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v4 1/7] mm/zone_device: Add order argument to folio_free
 callback
Message-ID: <20260112235414.GO745888@ziepe.ca>
References: <20260111205820.830410-1-francois.dugast@intel.com>
 <20260111205820.830410-2-francois.dugast@intel.com>
 <aWQlsyIVVGpCvB3y@casper.infradead.org>
 <874d29da-2008-47e6-9c27-6c00abbf404a@nvidia.com>
 <0D532F80-6C4D-4800-9473-485B828B55EC@nvidia.com>
 <20260112134510.GC745888@ziepe.ca>
 <aWVsUu1RBKgn0VFH@lstrano-desk.jf.intel.com>
 <45A4E73B-F6C2-44B7-8C81-13E24ED12127@nvidia.com>
 <aWWCK0C23CUl9zEq@lstrano-desk.jf.intel.com>
 <fzpd6caij2l73jkdvvmlk4jxlrdbt5ozu4yladpsbdc4c4jvag@d72h42nfolgh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fzpd6caij2l73jkdvvmlk4jxlrdbt5ozu4yladpsbdc4c4jvag@d72h42nfolgh>
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

On Tue, Jan 13, 2026 at 10:44:27AM +1100, Alistair Popple wrote:

> Also drivers may have different strategies than just resetting everything back
> to small pages. For example the may choose to only ever allocate large folios
> making the whole clearing/resetting of folio fields superfluous.

+1

Jason
