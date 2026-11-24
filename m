Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47226606A31E
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2026 15:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=XbgSnQ5w
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 685B310F75E;
	Tue, 24 Nov 2026 15:55:02 +0000 (UTC)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com
 [209.85.218.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A834B10F68B
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2026 14:20:36 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id
 a640c23a62f3a-c4d2b741ed9so744871766b.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2026 06:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1795530035; x=1796134835; darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Hoa2uDGRiz+jXLxbcD4HBQF2SzMfWsHt0csEQeOTfAo=;
 b=XbgSnQ5w7HsoJWQXtmcP3kkxo7IiRzELTC9pi25LWjC03FdDizbCUiuMyEakdnmHqw
 L4htf7WhxMi4+dkUk7KN850O2GQjK/Hu518NcsCbNomF3VdJWRTt6zZBAO3B1YnOgnX9
 X/bKxGSY6hKbyGJexKTYpSe4K2GhtCe3Yr05MNZJ8mRrVvz9VOzn2SjY4RZceVcsBQ1G
 FojQVp2KjrlhsV8V1CJmEyjvim8S+zp4GnTcImvVbKyNXXw5Vop+eL/F0P82cvBPlSCP
 nvjWYTt5CZWGkBCejbKMk4Y2+xs1tVu73OSCf+1QKolehUvcxFt2wmtwMlna1AByjkYT
 0x1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795530035; x=1796134835;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Hoa2uDGRiz+jXLxbcD4HBQF2SzMfWsHt0csEQeOTfAo=;
 b=kElniF4tcPMmZ42F2KCkgJinhJF4x9nNpvBJkyQaHGIyFhyu7nu3Ur2FWW+noTMPB9
 L2ePFe17+VwgUJWw3E+09NzyuxY4r67MJHQfDPnu3nFDimAppM6sv4L9ktkw2AO9zYY+
 poo0WiL8QrdY3OcZCo1SilJBaBaZofnCwrXGErfVSazUqQu1l8SVuSmmkTo6gGNRoIoU
 gLkIZfTKnJTAPp4CeCFmvf3Oh7ebwZ9kyKQnpDAhklmDdD2jtKZ3NV6X9RB8092U072d
 AMp/p9ca0ZADnW8vXU7Cu0qK9S31kHirpMyUiuM9/kDVj2QeYiGRXpGJSL3Ju9ZsDSRy
 EK6w==
X-Forwarded-Encrypted: i=1;
 AL+hErGHcffKRwdzEWUc5YfIOK+QtktX24QSYCWPQ5PQHOJc0K3R0jOePT61JDYK4Oji0VcmshxxYin4@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8NKruQjQbsabPuS1bqKskShDpYMEkPL3HhiXhI7YREv70SSU6P
 M1GARXSZbZC64JjdUZbIWkvXoVffki0YohhL4t8DbbYSsTdAg5o5fOBJbT1OhlPBP5k=
X-Gm-Gg: AZFdTZdXpZoUgw3nnvIJrjkN/7CmKvWFtW8yIHsfb1lu10n+KbtIL+EhB9e18b8MzNs
 /eTc74FyyaPtqD0Z9zu6pdiG24uTXnc2wLdR7Sw86uUzgkuwRYsW1B7n1eJmLYjoY5tUyHBksAp
 GNV+TDXC1Sujoxs+9sajGCMz6EDest7YZ9765Sd7PwmuU6tcylPNCzf+NKIqxJU61Ot46caqZ8h
 tPV85S0lv9K/WDNwkmFjlyzMEnI5n4W5h4tWUdZHFGd3vYj5isY5uajElLAi7zDz83iEKGa35VB
 5MaQiKy/h0OVUfNmdTxjeSyuVF6VSZtLMvcU7PsNMRILagMx23zFaHhTEBNcXCPif8uF3Jp9srk
 y97DNjJGCF/H7dE4zmMD6q8qqN9hTKD3Y2bU56oumVB9PA4HFgOlTx66NK4pxdBJaa9Mp684X5I
 qdkLuRoRdNH9OMgkxN62/hEMcaVkPvGCUf5kHhkJeWYJnYB81cjc+W+akDM9GYbqczBS0lgh/Sc
 sXxXzn7opglSQkVAd79dnIRsU22PUbAJR6u4qUcXEWfsVljeLqpkAZQ2sD5PCjztFD1MCPQnDdc
 wJNn6Zu/9m3Wrx7WvXPnU9EvoHM=
X-Received: by 2002:a17:906:eec9:b0:c51:5589:35a1 with SMTP id
 a640c23a62f3a-c515589d211mr891019366b.5.1795530034479; 
 Tue, 24 Nov 2026 06:20:34 -0800 (PST)
Received: from ziepe.ca ([142.177.118.84]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513ae8dc60sm518286266b.34.2026.11.24.06.20.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 06:20:33 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1xVrNo-00000000RS3-1UVp;
 Tue, 24 Nov 2026 10:20:32 -0400
Date: Tue, 24 Nov 2026 10:20:32 -0400
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
Message-ID: <20261124142032.GN9566@ziepe.ca>
References: <20261120-dma_mapping_type_v4-v3-0-c0183a409bdf@nvidia.com>
 <20261120-dma_mapping_type_v4-v3-3-c0183a409bdf@nvidia.com>
 <ad46d60a-189d-4dd5-9ad8-ecfd3c90f9d9@amd.com>
 <20261123165716.GM179082@ziepe.ca>
 <7ac7edd0-5c38-440a-b26a-21bcbb6f4702@amd.com>
 <awT8prWsj11TBdmP@nvdebian.thelocal>
 <63eb7b6e-e0a8-4443-a434-0301ed59beae@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <63eb7b6e-e0a8-4443-a434-0301ed59beae@amd.com>
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

On Tue, Nov 24, 2026 at 01:36:21PM +0100, Christian König wrote:
> > The core then negotiates compatible types and adds converters between them,
> 
> I have strong objections to that plan and would potentially NAK it.
> 
> DMA-buf should *NEVER* accept CPU physical addresses nor provide
> conversion between different address types.
> 
> Keep in mind that DMA-buf is solely a container for DMA addresses,
> nothing else and it should not provide any mapping functionality
> whatsoever.

dmabuf needs to provide support for drivers to help them use the
interface, and going from physical to dma_addr_t is absolutely a
common task every driver must do. I don't care how you call it, but it
is a service that must be provided by *something* and matched to the
needs of dmabuf.

I will definitely NAK any direction to open code dma mapping in every
driver again. If we are going away from SGT then we are fixing all the
DRM mistakes, including the wrong open coded DMA mapping, sketchy use
of SGT, and abuse of P2P that seems to be endemic in drm.

Meaing the exporter constructs a phys_addr list, gets a P2P provider,
and some common code constructs what is passed to the importer. I
don't care if this is in "dmabuf" or some "dmabuf library" or
*whatever* but it must exist as common shared code.

dma_buf_phys_vec_to_sgt() is the template how to implement this
transformation.

> > and having SGT as a type is what allows that. It only exists for unconverted
> > exporters and importers and eventually goes away once everything is converted.
> > The idea being we don't have to convert everything all at once, whilst also being
> > able to add support for different interconnect types. Are you ok with the SGT
> > type if it is just transitional?
> 
> Not really, it just complicate things.
> 
> What we should do with the mapping interface is to add the
> information in which domain the DMA addresses are to be used.

You need to negotiate the actual C data types too, especially if you
want to do that nasty idea where dmabuf populates an iommu domain.

Jason
