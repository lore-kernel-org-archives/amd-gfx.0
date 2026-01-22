Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8228ED72347
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jan 2026 08:20:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48C8210EA60;
	Fri, 23 Jan 2026 08:20:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="n4aMZ0pv";
	dkim-atps=neutral
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com
 [209.85.219.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4DB010EBA3
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jan 2026 23:44:07 +0000 (UTC)
Received: by mail-qv1-f42.google.com with SMTP id
 6a1803df08f44-89461ccc46eso31061536d6.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jan 2026 15:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1769125446; x=1769730246; darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Udk1T2MTSGRhmMtQ3jtc9BpxDT02wAcqHYT9NWJE+U4=;
 b=n4aMZ0pvsI+Ulqi5d2KQX4AadsmYTHncUGxCJ59ed1e/bh3INgfhl5oyPTMUq2Cnfa
 hKcPUsDS0tmFPAX5Oyy3Rh0CWywVwkYVeYxj8us65tsvZMrfGgUgMTubM0S2PrIkUfWk
 0d3DKkqmtfUksTcNJxj5cfWYAHF4MnvbTWLLA6pVCmeuzhq6Gb6UQyW9rIYfO03xsYkE
 trwsL8WuT8vZikstr43vUywVv6Do0kf6eqALZKaTX2rrhpb6cKDjlC0yfPTyMmA7ZwWU
 FP7miomour9Q22vSdoLeIk/oletIDu5OgZur+JoROyrYJYbLN+CCIjlmcql0HCOPZL2p
 uy3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769125446; x=1769730246;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Udk1T2MTSGRhmMtQ3jtc9BpxDT02wAcqHYT9NWJE+U4=;
 b=WRk5RdQhmY95znMkbgpFbiKb4L9LfTw7q5hkokZ7yYf2V41lswBszKfPuz26jCKfeu
 5EvGSQn0vYZHvVde6M7+K+7H637yBFvhID4RhADPIkw62fwQ9IcJXr9Y6RBDy53zTOm8
 ptIuJHmN3jAf1sTEOXKveh2MP3fs68cPZGuZrQ2XSMe8PeyA7MmVq8G/6jSuA2gHfPwT
 JAzLq9K1IAZ23nVreTXE41uv1E8bOG5gNS5W21Hy6ewHd89x+8Oh2mv0SyoFBZlTitku
 hu+es6xXG15BXwidigKDXOUuaWN9QFN2ITYHrQw8HGVqC4UeljnghQ3IMAuyP3OjG8Cr
 lx4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUj/3VSq/CUucfLZvOw6fSGP0rYXDHSxY7B0yDTdxpll2HK4Z3rKVxqZgYPJBr2+9LCczQAkGp1@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyeG433GRKVe2q9Ky+WGzqHe6rQEkDel7t0E+xdBrl++uD7c+sB
 291yjODXys+JT5niYwWJ+WGcPK2PAtGu3ZieW0opwJP1k3dN+5PvxvdhTx70iPrxAWU=
X-Gm-Gg: AZuq6aLUxC0W842uAr536rhrEXUd1unfoOv2mn5Cz/5WFkXILq7+L0uqqBbh4qM74Tk
 vrWPk05cNxjkrzDRaVwbSDtj6Hl0Gc5zVxhg01ZFAjxcdifEOVZ/wT1Ic57izSQ+TmRgcKJwDCA
 PTpdWIWha//ln3WeGEpKSPYnEt6HalHHq2y5wNsyB1JdrZD8Z5FpXLnGyK9Ot3wviIE/rrRBD59
 ADgRL6bXpZR8OM21DT6UywOvOLtOhN0wr/10/8P5XXVzk/Izn87T0ktxblfSUNuEFGZFNKka84x
 WEeiecQADw21kT3Jpn75Teka6SDy70cz8WvoR3TSz1xB9o2eVQOoU/7oc/SKXL5d+/6dLqjG4/4
 aKA4C5J/PmfJU/8hy2DkqSf7uYW09QpPK96ZA8FNQgBnfruozO7gZz6YAuj8dLXdAvL66tsPREs
 I0/iBvkK7/ggyKQ8HBrz+tCAIeyMtpYDGBXYPtUA1su/uLpMnX4CwVPF67jHHQLUfvbDQ=
X-Received: by 2002:a05:6214:2269:b0:894:6530:efd1 with SMTP id
 6a1803df08f44-894901ac85dmr20677696d6.19.1769125446269; 
 Thu, 22 Jan 2026 15:44:06 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.112.119]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c6e3854a6csm44128885a.41.2026.01.22.15.44.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 15:44:05 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1vj4LM-00000006gRo-0Lke;
 Thu, 22 Jan 2026 19:44:04 -0400
Date: Thu, 22 Jan 2026 19:44:04 -0400
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
Message-ID: <20260122234404.GB1589888@ziepe.ca>
References: <20260120-dmabuf-revoke-v3-0-b7e0b07b8214@nvidia.com>
 <20260120-dmabuf-revoke-v3-6-b7e0b07b8214@nvidia.com>
 <b129f0c1-b61e-4efb-9e25-d8cdadaca1b3@amd.com>
 <20260121133146.GY961572@ziepe.ca>
 <b88b500c-bacc-483d-9d1a-725d4158302a@amd.com>
 <20260121160140.GF961572@ziepe.ca>
 <a1c55bd8-9891-4064-83fe-ac56141e586f@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a1c55bd8-9891-4064-83fe-ac56141e586f@amd.com>
X-Mailman-Approved-At: Fri, 23 Jan 2026 08:20:06 +0000
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

On Thu, Jan 22, 2026 at 12:32:03PM +0100, Christian König wrote:
> >> What roughly happens is that each DMA-buf mapping through a couple
> >> of hoops keeps a reference on the device, so even after a hotplug
> >> event the device can only fully go away after all housekeeping
> >> structures are destroyed and buffers freed.
> > 
> > A simple reference on the device means nothing for these kinds of
> > questions. It does not stop unloading and reloading a driver.
> 
> Well as far as I know it stops the PCIe address space from being re-used.
> 
> So when you do an "echo 1 > remove" and then an re-scan on the
> upstream bridge that works, but you get different addresses for your
> MMIO BARs!

That's pretty a niche scenario.. Most people don't rescan their PCI
bus. If you just do rmmod/insmod then it will be re-used, there is no
rescan to move the MMIO around on that case.

> Oh, well I never looked to deeply into that.
> 
> As far as I know it doesn't block, but rather the last drm_dev_put()
> just cleans things up.
> 
> And we have a CI test system which exercises that stuff over and
> over again because we have a big customer depending on that.

I doubt a CI would detect a UAF like we are discussing here..

Connect a RDMA pinned importer. Do rmmod. If rmmod doesn't hang the
driver has a UAF on some RAS cases. Not great, but is unlikely to
actually trouble any real user.

Jason
