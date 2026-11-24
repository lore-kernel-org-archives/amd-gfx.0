Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF15606A688
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2026 15:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=LoMiAxTj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C03CF10F6F7;
	Tue, 24 Nov 2026 15:54:45 +0000 (UTC)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
 [209.85.218.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1016210F5D6
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2026 14:00:42 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-c50d3ac6b51so1061355966b.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2026 06:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1795528840; x=1796133640; darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=o+7iSwGfMjtzT2Y6Ygii4nLjUX3g93NcfuA7HOwwEkw=;
 b=LoMiAxTjV4eorbaLjY1PpY8GS4BMTD1RVMTJVe3OjejInLKAbrB7v9hnviDjelJfjH
 1p6JIVi4yXb6IqeKSSAwLvQyJM+lfK70rWd9rpAXaYtbhuHSCQdoHAGUaAiJFqWk1E9s
 ql7Sqp8wDeKRk78Xo9Y6DqCakWDmzHObQjaZXXJ88N/h/wLlWsADpGU0/AsCB37MZ+jd
 wvWcKGXdtNIOnbk3MzOoRBKCPKxpZLdkgW6MhdUouXBJBZIByn8NHc1so1kywFlfxTne
 iH3haIHAafNLDCCbphTFyura/83l84D7uZDMYmA+PlflDgNif1fDbF5Vu3w1gcn7+7o9
 9GWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795528840; x=1796133640;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=o+7iSwGfMjtzT2Y6Ygii4nLjUX3g93NcfuA7HOwwEkw=;
 b=qn9jNVLxlzouoAhn3TzrmaGpxNvViSBN2v2poKO3fkklkkYU5iXsFr6f9Y73u4K3YE
 hlKzAi4zDv0oIFvJ+UNOr4lDzeMrXOZRZSLLsrCA3jBShVy8UfR24e4aauQW4v2bGdnv
 8QcUPxpab1f+gw2ULR3NlNQbmxo+TnezmL5YFn8SWXNOeKL7b3A05wglnDY0NvA+MS8g
 Igjo2Uz9hLoftkmlo0He//2fj3xgeXxvvfAH+NhbR9cYVMG3WNU5ln5h7FvwmksbgpLt
 FddE+OMVxTAG5LrXkjqbf6fDrDHTlVmEdd9DLgQ8mB+tCyStcUzJbYLzllQolEfiBgjb
 neyA==
X-Forwarded-Encrypted: i=1;
 AL+hErFhs6wm3KYIKBITwMpqtw2hIHc3dDzHq0ntMxHwKkomvj0guJ29vh+448KM20BqeIGRI1EBWNgG@lists.freedesktop.org
X-Gm-Message-State: APuU4Z80Kzn6OMiUw0H/6Fd1v0E02TugyOKRG/LjmzFr+m1F2TrkkKmN
 zgCrLqtUnmcj8wmoP4GsHyRLHIAHzE5XTRLSv7NyBkAotUUfH+JOjQ9iq6biy0PXosk=
X-Gm-Gg: AZFdTZf8aOVIj5feYTQ/W/zqSt5VLi5CyQERggCkc2CP9YflESe/ecclnX2X42wR9R0
 xaTB91T6n4TJQRYrzy3YfFmeNue76144TzsuAWz5YoBY3iwNjY1KOZwXhvzH5HkQYbRFkXvHiqB
 ih3YFu44zVh48X//2IYlQIkYlVB+Vza+dez8zIicGeIIF15Yp0jDk3WsNhiFv0bUBW4/5LPJEl+
 f8PGP4qBkod85rAKGJ9aCPhqEjFV6QLRYtdOjFWxFl0FKkja9p1SCBTKDn1HCOTOg13h+qG0SdK
 jrJ/jHPXC06l6A3gzJdfABwlbLpzYG16XiKrm9T2xN3zuY7rSyXY6miKv9Mv6yQJshT5oqoVcBE
 eh2gtib/+8l+1EKkb3JyoXhSXpVwj0B4TkUl4QxrLDIavjwml8zpaKXl4Rl+Dn3YfCr3tRIl7j0
 LWxRickevv3xkItOMTk2bacE1UM6u3hGjDrz39FqeG8Kcn7znV9D/ipzF1sW3ybt0UNRiGvXhbQ
 8dyoNqVzjgPz8PGvmtFnzLUfdpGf3HwYwnUGZcV8y63AoRUwVJMPuWsyrjiCYpZ7gyrFjefKdg7
 h3ZPnA==
X-Received: by 2002:a17:907:3e86:b0:c36:777f:824c with SMTP id
 a640c23a62f3a-c51315851d7mr1405271066b.4.1795528839874; 
 Tue, 24 Nov 2026 06:00:39 -0800 (PST)
Received: from ziepe.ca ([142.177.118.84]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6ba370cc257sm6492195a12.13.2026.11.24.06.00.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 06:00:39 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1xVr4W-00000000QnE-3MAi;
 Tue, 24 Nov 2026 10:00:36 -0400
Date: Tue, 24 Nov 2026 10:00:36 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Alistair Popple <apopple@nvidia.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Simona Vetter <simona.vetter@ffwll.ch>,
 Matthew Brost <matthew.brost@intel.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Dongwon Kim <dongwon.kim@intel.com>, Kevin Tian <kevin.tian@intel.com>,
 Xu Yilun <yilun.xu@linux.intel.com>,
 Karl Mehltretter <kmehltretter@gmail.com>,
 Baolu Lu <baolu.lu@linux.intel.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 Alexey Kardashevskiy <aik@amd.com>, zhipingz@meta.com,
 treding@nvidia.com, jhubbard@nvidia.com, chaitanyak@nvidia.com,
 Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v3 03/24] dma-buf: Add the SGT DMA mapping type
Message-ID: <20261124140036.GM9566@ziepe.ca>
References: <20261120-dma_mapping_type_v4-v3-0-c0183a409bdf@nvidia.com>
 <20261120-dma_mapping_type_v4-v3-3-c0183a409bdf@nvidia.com>
 <ad46d60a-189d-4dd5-9ad8-ecfd3c90f9d9@amd.com>
 <20261123165716.GM179082@ziepe.ca>
 <7ac7edd0-5c38-440a-b26a-21bcbb6f4702@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7ac7edd0-5c38-440a-b26a-21bcbb6f4702@amd.com>
X-Mailman-Approved-At: Tue, 24 Nov 2026 15:54:45 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 23, 2026 at 07:37:41PM +0100, Christian König wrote:
> > Part of the design of this series was to allow the conversion away
> > from SGT to be done incrementally without breaking compatibility.
> 
> Do you know the joke from the hitchhikers guide to the galaxy where
> the dolphins are happy for exactly the same reasons?
> 
> I'm pushing against this plan for exactly the same reason because I
> think it will make the conversation away from SGT even more
> problematic than it already is.

I think it is well proven that trying to do big bang conversions in
software doesn't work well. :(
 
> > So it is effectively this:
> > 
> >> The framework should then either connect the SGT directly if both
> >> importer and export are using the "classic" interface 
> 
> Yeah but that should not be a separate mapping type, it's rather
> that we just convert back and forth from DMA addresses to SGT for
> compatibility reasons.

The mapping type is to support ualink/etc that don't do "DMA".

Only DMA API can create dma_addr_t's, you can't reuse those types for
something else.

And you still need a scheme to negotiate exactly what kind of
connection you need. Focusing on the SGT is missing the big picture of
why this was organized like this.

> > As this is actually quite complicated and needs discussion exactly
> > what it will look like.
> 
> Actually that is the easy step I think because quite a lot of
> drivers already convert the SGT to a DMA addr array outside of the
> DMA-buf framework anyway.

Given the importer an array is not so bad. Getting the sgt out of the
importer will be a debate.

Jason
