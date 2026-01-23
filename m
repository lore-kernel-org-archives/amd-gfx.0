Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50AFED715D9
	for <amd-gfx@archiver.kernel.org>; Sat, 24 Jan 2026 09:41:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD67A10E317;
	Sat, 24 Jan 2026 09:41:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="ZO5RmoSV";
	dkim-atps=neutral
Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com
 [209.85.222.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C54610EB5E
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jan 2026 16:31:34 +0000 (UTC)
Received: by mail-qk1-f195.google.com with SMTP id
 af79cd13be357-8c6a0702b86so252334985a.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jan 2026 08:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1769185893; x=1769790693; darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=871+kMuUuN8eKawcT4NNcOEOt4uiGeIzveYuD9+CVek=;
 b=ZO5RmoSVLOiysFFU8LQmu8CIzve35nyX9KrixGYVrXljHmjYr77pxbQd1IQJbIlQDd
 U09NyFvmAijZU6g0MUKDSF2UJN5T7mFNuU4epMCQ9wtQXfXoU+5gTb5ivKUFPZStLN34
 zaU1lUXd7gBAp3nBU4WiRfdCGwBdIXlMyqjJ53sfrnHv7vrJ31I5pIxRwbkRO+V+nnqs
 dIMj5htLqZ3T09fBaU/V7uPZzxdnLu2/rlTXHn71L7xke6zDk7GEn+j+N/dNopNVgIi4
 oe9a6aI85sjds0RU6ndeTBJFdxZquIAyrE6pz2rI360UHOyTKKQ2ICBsTK416Z+RQcLe
 5BZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769185893; x=1769790693;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=871+kMuUuN8eKawcT4NNcOEOt4uiGeIzveYuD9+CVek=;
 b=DxcTmhvT9mRt2sh9Ds7USdKWkRBzGY9iwhHNCmkVrSK6oY50vxsV+FeUm3ICq0Yc9J
 30Bm1FCG7RNl/ex9ySXBrzAsDK0A7irpQjVI1a4oGDjp8P7BhKSLW4XF3lbVTxwDaf85
 Za+dUh6MLbCAIiEl1e0wYMIRbJjuH0lQZhvb1jtLRWggnMpadjMCX3i5wv4lXEe9L9jB
 pC9xjD2rYbDS1OFjf/nlY0MWJp0E7efmVi2HL5OMGsMJ2764AixRPeCFBXwsq1v6JG5o
 +Lc5Tjb5yQrH3OxCWZYTfcw9NuJS1os6s12hSJOF2c9kn7/6LwLSbI8IXTUSRuw23gRH
 dlTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXu6gsT7mx1eQ2sn9/eEvrouPABKq/MetUwMIO04DGUYaDgTF4fdCxd3w+ddRuZVtXUl7yYi34r@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzqydu9NClCsgGl2D0YigmlsmINkNjQrHhv3EX4uGS72XxqrXIT
 eINP9jI0rqBbbZApX+tgaBCT0MW/vZHOTLGC+4k1s82cIN+OlYmtNjbZB7AzucEynyA=
X-Gm-Gg: AZuq6aLHO6Hx0bZ2rKF6FPO05i4NH8lqSGuu0A9BCZkbiinL/pXOjz32pQMPDQbQSEL
 zIv/8AXin0RFS/AE4K4/V4hcm+EHbLReFV3bvrhz9WOXRL1dzLUlziw+dVIcqt3CwelJIN7PP53
 4FjlogUhc96cCTMg4cVwohVcGWHa089sTrIPaEB4f5/tW99fRiiYOmXAgjueClAVLQ/NSCPI4E9
 LdEr6vhCQXaIDHifDyeVTXfOGRs1w9DEBqfuHGVgNqMvm/uND+WZropwVQud3PATNR9yqYowOkR
 T0Xht14nwq/LOxDeTwCRQ6yWBwOFGrFkk+UhBG4f+vCC10Oy/oZC4Ljd8MIOcd2i4HpsetW+TA7
 bCqNtK4vk/vzoYEpjDxYAWMbPyziH8ZrviZi/JmJoZmwaZQ5OMMTiJR8X4BhNZLxsuZawaxelvA
 b2CU+0ZigIp/2LodcTz43vCXvpMVgitBaq7h6kMWtK2m0m42yt3k9GN/7W036vZlqydKs=
X-Received: by 2002:a05:620a:1901:b0:8c6:c9a2:504d with SMTP id
 af79cd13be357-8c6e2e48438mr431308085a.59.1769185893221; 
 Fri, 23 Jan 2026 08:31:33 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.112.119]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8949193cdc1sm19709316d6.47.2026.01.23.08.31.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jan 2026 08:31:32 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1vjK4K-00000007Grc-04II;
 Fri, 23 Jan 2026 12:31:32 -0400
Date: Fri, 23 Jan 2026 12:31:32 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Leon Romanovsky <leon@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Chia-I Wu <olvaffe@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Lucas De Marchi <lucas.demarchi@intel.com>,
 Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Williamson <alex@shazbot.org>, Ankit Agrawal <ankita@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, virtualization@lists.linux.dev,
 intel-xe@lists.freedesktop.org, linux-rdma@vger.kernel.org,
 iommu@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [PATCH v3 6/7] vfio: Wait for dma-buf invalidation to complete
Message-ID: <20260123163132.GA1641016@ziepe.ca>
References: <20260120-dmabuf-revoke-v3-0-b7e0b07b8214@nvidia.com>
 <20260120-dmabuf-revoke-v3-6-b7e0b07b8214@nvidia.com>
 <b129f0c1-b61e-4efb-9e25-d8cdadaca1b3@amd.com>
 <20260121133146.GY961572@ziepe.ca>
 <b88b500c-bacc-483d-9d1a-725d4158302a@amd.com>
 <20260121160140.GF961572@ziepe.ca>
 <a1c55bd8-9891-4064-83fe-ac56141e586f@amd.com>
 <20260122234404.GB1589888@ziepe.ca>
 <20260123141140.GC1589888@ziepe.ca>
 <98b74c7a-44c1-49ba-997b-bbbab60429ba@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98b74c7a-44c1-49ba-997b-bbbab60429ba@amd.com>
X-Mailman-Approved-At: Sat, 24 Jan 2026 09:41:19 +0000
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

On Fri, Jan 23, 2026 at 05:23:34PM +0100, Christian König wrote:
> > It is illegal to call the DMA API after your driver is unprobed. The
> > kernel can oops. So if a driver is allowing remove() to complete
> > before all the dma_buf_unmaps have been called it is buggy and risks
> > an oops.
> > 
> > https://lore.kernel.org/lkml/8067f204-1380-4d37-8ffd-007fc6f26738@kernel.org/T/#m0c7dda0fb5981240879c5ca489176987d688844c
> > 
> > As calling a dma_buf_unmap() -> dma_unma_sg() after remove() returns
> > is not allowed..
> 
> That is not even in the hands of the driver. The DMA-buf framework
> itself does a module_get() on the exporter.

module_get() prevents the module from being unloaded. It does not
prevent the user from using /sys/../unbind or various other ways to
remove the driver from the device.

rmmod is a popular way to trigger remove() on a driver but not the
only way, and you can't point to a module_get() to dismiss issues with
driver remove() correctness.

> Revoking the DMA mappings won't change anything on that, the
> importer needs to stop using the DMA-buf and drop all their
> references.

And to be correct an exporting driver needs to wait in its remove
function until all the unmaps are done.

Jason
