Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246B5606A32D
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2026 08:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=SmUYv/3Y
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E63E10F9F7;
	Wed, 25 Nov 2026 08:41:42 +0000 (UTC)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com
 [209.85.160.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2526210E285
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2026 19:46:21 +0000 (UTC)
Received: by mail-qt1-f176.google.com with SMTP id
 d75a77b69052e-55c48582654so55886591cf.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2026 11:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1795549580; x=1796154380; darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cCMOaZdag+2OcXEDMl2EbRqTcxfKhXeKWu4Qydoaad0=;
 b=SmUYv/3YcvWtJAUFJuDDZ6Jec81JftJEhCUCKqY5bEM0GEVHxarE150oX+g+JObVay
 EzhwpmvQfJdTwDNaouFPrr40QNwDCuM3nc8FpdkyBHM9PBI7CzTNT2OCgFnde4WrwO2b
 JpWSVr8VVYbxoTTyWnzMiu0gufZ6bT4qPyCtZzJvCt6ENwcLKWaBKZlTfcaNXBMgQuJR
 SSmcToLhMVgszxrczx9SEGMeEotlbWqFIDxTLTyTZBNvor35PICsOBw9MquvWpnHZxo0
 NVcYY2djvCP27Z7C1PAAWhLnj2WDRdVnd+kObZ1OXPKO4EydNGHl8V2+p9g2ycKVlpQ8
 xMKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795549580; x=1796154380;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cCMOaZdag+2OcXEDMl2EbRqTcxfKhXeKWu4Qydoaad0=;
 b=Mea/B81FoXlUg34NoMsU10ELkngjYXpdwIjFJcwVkM0tSW88MoiHtxAcaJ6oggRgAs
 eHfc84MbFBUGXIJ8sSR1aM3YD2kJV0d4CY/RK5PoSHlWF/EAris1Wxj6+cjof5U2G19p
 xoo+S1W3LioT9C5IBzI7ixZOQN+bDgbnUIFyDO4YnPFdZgGT+o/jpSvXeh1YAf/uweM+
 7GW5aQoVw4FWdNvdIiYGgJkKDf6SRVw3srMV64Ve3lxcC5UkBMtznw5qiemzg7NM7AVr
 WZa5tKOfDEjbK+t2LVG5KCuhKnZhpjdLXFq1itoOnpkVfMVmFxvF8ElFgKK1bTib/9Q2
 VhFw==
X-Forwarded-Encrypted: i=1;
 AL+hErFgrchRNN/RTQSxOzSP/xY1zKMBAas7wwZQ7F8ol+IKt6svK1gz58qlf5E0iyc/Avib60JrR/gV@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8CwNyT5jDnZ0JGgrcZj2avjYNKOaXy10Q7CEwGoJ8k1h5c/OwF
 CIagadtJzl12s2r9bM5CCuKZnWJ3CgGod67fjNB7nCKxMPsYVgxDMDz4W1tYMkVa1fI=
X-Gm-Gg: AZFdTZeEoHPHha5B870OZttgeOaMd6hWwyMeXcS6N0oMTvXO133Awwiraavm9yWNc2x
 U98/oTcShL7Sk1IW4WDxOW/Ls+w3Z/aYMHvzt4b0wf0cWjk3HAMbwMIrtSzVs4bZnn1F6w4idIZ
 6V4StzrKqv/ySDYfdiHqPuhCYYuSsdDJg5MoKuaL3qLjlk2d18eU40n76Ms7uBpDwZNc5lMkxvG
 MbpEuqroar1IS0PLbpMgBC3dykogMmXYpXMzxEhxjn7xMLTd6dDgb20ohDj+tvPY3ALPi6R6S6C
 llKcootX4KMY3sSsskFWAjj7UYL3gUYCkhj8RF8bpUyB4jXBSMZkO4H47YoK14TPbYXCY1Qfv7t
 FHLr+zU1zG9LxVVjoRH5/E3AQY4E/SGj8K2CUPaVTbzT3LlsbTEYpnyjPv1bIim2+XZI0pr0yTB
 ha1aqUJNBZA2JbRNsWzujygIdLMuBDyp+Yy86o7SSh7wJI++Yj879JE/iREePGUs7s8i6ApIo+q
 NtmLp6hRKfEYU3qf3WDYTE7t+FXnBJMStB6+UqNx8BCZYKsmV9Jqmn/NHnjHdGajVVf7teS7C2Y
 HTSrLA==
X-Received: by 2002:ac8:5c8a:0:b0:55c:66f0:5bfe with SMTP id
 d75a77b69052e-55d76a6f55fmr288174681cf.22.1795549579924; 
 Tue, 24 Nov 2026 11:46:19 -0800 (PST)
Received: from ziepe.ca ([142.177.118.84]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-55d7882ea2dsm135596661cf.15.2026.11.24.11.46.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 11:46:19 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1xVwT4-0000000113s-3B2s;
 Tue, 24 Nov 2026 15:46:18 -0400
Date: Tue, 24 Nov 2026 15:46:18 -0400
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
Message-ID: <20261124194618.GC114530@ziepe.ca>
References: <20261120-dma_mapping_type_v4-v3-0-c0183a409bdf@nvidia.com>
 <20261120-dma_mapping_type_v4-v3-3-c0183a409bdf@nvidia.com>
 <ad46d60a-189d-4dd5-9ad8-ecfd3c90f9d9@amd.com>
 <20261123165716.GM179082@ziepe.ca>
 <7ac7edd0-5c38-440a-b26a-21bcbb6f4702@amd.com>
 <awT8prWsj11TBdmP@nvdebian.thelocal>
 <63eb7b6e-e0a8-4443-a434-0301ed59beae@amd.com>
 <20261124142032.GN9566@ziepe.ca>
 <7a5a2d3a-e42e-4dc0-8d22-8dd1bd249501@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7a5a2d3a-e42e-4dc0-8d22-8dd1bd249501@amd.com>
X-Mailman-Approved-At: Wed, 25 Nov 2026 08:41:41 +0000
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

On Tue, Nov 24, 2026 at 05:02:31PM +0100, Christian König wrote:
> The whole conversion from phys_vec to DMA addresses is something
> some API should provide based on the data the exporter/importer have
> negotiated (e.g. p2pdma_provider for example).

Yeah, probably, and this is exactly why I think it will take some
time. Building a new something in lib/ like this is not a
straightforward task.

But also, this:

> > You need to negotiate the actual C data types too, especially if you
> > want to do that nasty idea where dmabuf populates an iommu domain.
> 
> Yeah agree as well, but to be honest that task is negligible. We
> first need to figure out where to put the code.

Means you need to get the phys_addr_t into the dma-buf code so it can
do this conversion.

I'm still absolutely NAKity against allowing any DRM driver visibility
to an importer's iommu_domain if we do this hack.

I don't see how to meet all these concerns without making dma-buf into
a "converter" framework...

Regards,
Jason
