Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA02A606A330
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2026 09:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=eAtWsGDd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8809C11297F;
	Fri, 27 Nov 2026 09:59:11 +0000 (UTC)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com
 [209.85.160.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A35E10E489
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Nov 2026 00:37:20 +0000 (UTC)
Received: by mail-qt1-f180.google.com with SMTP id
 d75a77b69052e-53644ab1f7bso66729991cf.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2026 16:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1795739839; x=1796344639; darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BYEpToCdu/Jrl7504w/3VIKWXqy3i8TunCn9olVHqm8=;
 b=eAtWsGDdbDcI+fuui3Wdr+SpsotjS41YWqkqRCtFuHv2RuhjOWk8sv6pXuCE54t1xN
 eBsa5PBMiL1oS2TV8QuTD90s5vmykU1VHx25Gxp4CUx1gJxFBBd94kC1nBgJEPybgK7i
 LpZNHRET3VfCMYNJwvjxtC9skOzMYjuJxYQPYIzi2DX0QorzuiTMK9gtj9jllJ6u/5WE
 L7pSBhW2kukOFcaHQiv7hEeuP58DoU4UyGGx6/xs/AfFyqAQ3HfCuyoIXIyXIQ5njCEH
 SjpO7f5QyEfy0GNsvJraVCa1dP6WPe3S9S0eHtM3hhDxXRQsNqJcVvVgP8qX9qFKyve8
 QAwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795739839; x=1796344639;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BYEpToCdu/Jrl7504w/3VIKWXqy3i8TunCn9olVHqm8=;
 b=lhqqaYJSd39GZepgnaG6d1b5FPfctA0tGIjDDxcCE4YJ00cXFRgSE4rvpjc4DJy08i
 N0Tc7Y3NZBLMO3LZfz980qujRkueQR23RS+kFIySFR9YYoVCvJT5E2bI2HbcNntip3Kk
 2g1CQD6z5L1HIBrVZFxV7fJyR8Axs+VCad9WwpzNT2s60RqtmEu3rV3MGvM6SEgHPKzT
 yBC2tjknprCK18B3vaP2XcF8Q4vCPdKV6nBsAgAq8zUkC7bf7IYrIuojvz23LmUUgyKx
 vtXSZl63I0Mv8ewS/UfONRUz86QHDZ02m1hVxwghZI++G8zYVJ0xK3xxDuLhvLpCgV/5
 XQlw==
X-Forwarded-Encrypted: i=1;
 AL+hErEHf9tcqBqPufRWJF8vkXh3zocfC/pbU4i7lt/DJkggqRVHenMc51ERf+MU9ly68ndaDAICUSmj@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8uYsHXnNzT9cax1mNNPVF0Iwmvuxz7ZHQm5dfZfv4JewBAO5a8
 QCyUf/v6FVqgfLqjWlVt0GCP/FHNDvsSsBMiZ6lriX2Gppf7yTvtZrM1BohWnIVMfsU=
X-Gm-Gg: AZFdTZdcvczUPmjiB4GPlBo2eUx9OluL3cItPgAxEpO4SWeg4AfGwjHxhNkNrLqttAN
 izQt+DG4s44j4dCoHONpkuvF1kK6D/3pPSB7WUZnpohtUu/bkbTfgjTnTsfjcEcI9Nmx9gNwe6B
 EkhfT4H1wDre6Lkm3LoTCU8TNqOCehizXt6bDHIWLDk23Ymg4uOVj/l237BBq5GGsnJw9al2viX
 Ad4N49pJ3XjrPsi+EGgSMFG8zGKP6SVElzD3HBlFx8adtP+ixef4Wms+RfkygVkg7uYznJZVlxI
 PkVHURqFlkjDTEROe3oMXZAm+CrmnlJuGBIYDjQGPB9H94L5+gzAi2QDQI9sdV3ZZzVi4zSOjVE
 iXqGUPRYciuAM2oRnRGGANqHS1Oq6xrDC7tfhD9H7300Manp1NIyk8I7fkWUlMuA8m3oVN1cpMT
 HauxyzPEM1oiRuZroUmhrdyjE+LCUaZVyx67FHY1GTv7cOhNNAp3hVTZHnmk9FrEN1P/A33lhnX
 7D5i9lrLhd3ThtX7xqjJMhUyQWg+arHmU17NUnftRRM2mFeUbdsj/aQztQ+jdeoT4bRTD51W7Bf
 JYFJDw==
X-Received: by 2002:a05:622a:1f13:b0:533:8900:4eae with SMTP id
 d75a77b69052e-55d76a168d0mr403124891cf.13.1795739839275; 
 Thu, 26 Nov 2026 16:37:19 -0800 (PST)
Received: from ziepe.ca ([142.177.118.84]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-55d788506b0sm192115611cf.17.2026.11.26.16.37.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 16:37:18 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1xWjxm-00000005OdJ-0d4j;
 Thu, 26 Nov 2026 20:37:18 -0400
Date: Thu, 26 Nov 2026 20:37:18 -0400
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
Message-ID: <20261127003718.GR246011@ziepe.ca>
References: <20261124142032.GN9566@ziepe.ca>
 <7a5a2d3a-e42e-4dc0-8d22-8dd1bd249501@amd.com>
 <20261124194618.GC114530@ziepe.ca>
 <awZ_Os1pXelOGaFP@nvdebian.thelocal>
 <fb9a6b12-c134-4e40-86a5-dbcb59c0b91b@amd.com>
 <20261125155559.GL246011@ziepe.ca>
 <5fb8bb60-7d9f-49b1-899c-40a890fdc14b@amd.com>
 <20261125190705.GN246011@ziepe.ca>
 <awfMy1d8ICL6mr9i@nvdebian.thelocal>
 <a8c00bbf-dddb-4207-bcdf-af58d27116c5@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a8c00bbf-dddb-4207-bcdf-af58d27116c5@amd.com>
X-Mailman-Approved-At: Fri, 27 Nov 2026 09:58:44 +0000
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

On Thu, Nov 26, 2026 at 10:58:13AM +0100, Christian König wrote:
> Would it help if have a call on Teams or similar services to discuss the whole thing?
> 
> That might be easier and especially faster than by mail.

I think that is a good idea, I suggest you and Alistair should pick a
time and see who else can come. From experience eu/au/eastern na
doesn't jive :)

Jason
