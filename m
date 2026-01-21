Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8826ED62604
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jan 2026 08:36:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F54110E928;
	Thu, 22 Jan 2026 08:36:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="Wp4ujBkB";
	dkim-atps=neutral
Received: from mail-qv1-f68.google.com (mail-qv1-f68.google.com
 [209.85.219.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9728010E835
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jan 2026 15:39:59 +0000 (UTC)
Received: by mail-qv1-f68.google.com with SMTP id
 6a1803df08f44-8946e0884afso247656d6.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jan 2026 07:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1769009999; x=1769614799; darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Q/gIihsafKtPWuGmVrtzbFv3/1+tW3nx1RJPQscpuso=;
 b=Wp4ujBkB9ilpwPb4/Dadsv3Wvw2wNGm+L2bOGrZ0k+ec55NHbZ+F2EfsRnsjca0vOd
 p2fOYtvuRMhWH6RGUJuHba1GwuOtwl4Phe3dDWp9/gkgS7kHT8M14HCwG+e5CNtDHnqy
 +UmQbEpaAr/IrqAnuM7FDhQrDisuHB8ij1AGUrk5wAIFt7iH8muITrdD8S89EL4WoHeA
 ww47DkEWXH1RWYMW5uVBpbZnBNcSH38W63gKi3aeW8sOFWzvyv2S/eI6tBlQxOYoqwZJ
 F1tTcyIfNI/T3qbCOfBIo4uvFYOozMv6eIOGbXUIKXuXI8phKINBsA0r6WNlNrdtuWPh
 g/2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769009999; x=1769614799;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q/gIihsafKtPWuGmVrtzbFv3/1+tW3nx1RJPQscpuso=;
 b=a3tzpKnulXv8g8r4YVz+xvEH8xChp/CnpjlzGzBvGQPnwNI7cbgPL4zDUkQh5F18Xx
 gijH3z4peMouYjWFxYtHM1+OOIgpgb3XsVY8tiZO4XYUKmXiC7ZKd3PDC9BrQBwSy4Vb
 DIFhOvqda+KxeU8l2/ng/FnvuB5yhJOtqA27B6Ly8DX0aCs0QSeru9mA32Q0z9rYCdyW
 JlCNoS+YbEO+5pHow0B6fBoj6n5uzXCCx5uJb13sJsOBdeZo0C2mElKyEMfiuo6RxgUv
 O7Eg9doOKVlD7qGWHDEYeCWp/Le9VxOH31u2Mohx1YAvPMMhfvDpObhmuMQ5yCBbH+iI
 X9Kw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGHTPv9Y0zq5wsuERlXVfKzOI0PIa65XGNSQox8CSYJ/K1WLpKl7KONLpsxLpOzRj3dL/02Tbm@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx3N/PB14VPk4OzKBYVt82Km1vQAKHoIVXdPH5XrJEnhmm2PmT9
 xwENqCUdiz5HYmTDeN9fVyijjAOlKhGu9H/j4M6DnQSmZZWDWtCVQdwoF0u4q4WKi/0=
X-Gm-Gg: AZuq6aJ2Kl0Y0AeFYxD5O6gZwfsIByN3o9ut8+X2FTP6X84Udaj6BGDHp/TlDsoMqrk
 wVOjfT0PPGQN0vGfFt13cEdwgs022JYSk5rMhryB4Y7PEGBt8zRpfzrleRVP5ItibtR+eZtDkrV
 ULCQMlXfQHDd+F7hmLC1YsCCU1E9rh0gQHMbCGRHdtYX3Mfwe6ky9l6fyIn43T11z+gC8cjqZaA
 AqZSLeA8xOsqHw7lBRh7G6ks8BFyxuEjV4S5NECBCes03I4cV04p2pL9BCNhbILEnjriTBx7SUX
 jpDOs1+KrwZR/DhjFIeV42xD5fzn6RlNA7XGaxL9hTbkXnyyx8lZnLc3kWHRHRlCHyj/1p9cs5F
 lD7w+Mhd5BEEt3Kgshv8lgFaTa+BPPGLfyFpKXTXK37PKPKy6S4PD+v27l4Z8qBwU2uNOzMgOOs
 l49BIxac5oO9mY2XjM5iTrrKpiu6bJhg4Wky+u90HHS8fw3H0octUQA5l1lj99dJeiIZ8=
X-Received: by 2002:a05:6214:469b:b0:894:3cde:f81e with SMTP id
 6a1803df08f44-8943cdef85amr237172426d6.41.1769009998640; 
 Wed, 21 Jan 2026 07:39:58 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.112.119]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-894592ba642sm58791866d6.57.2026.01.21.07.39.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 07:39:57 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1viaJJ-00000006EiI-13u3;
 Wed, 21 Jan 2026 11:39:57 -0400
Date: Wed, 21 Jan 2026 11:39:57 -0400
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
Subject: Re: [PATCH v3 3/7] dma-buf: Document RDMA non-ODP
 invalidate_mapping() special case
Message-ID: <20260121153957.GC961572@ziepe.ca>
References: <20260120-dmabuf-revoke-v3-0-b7e0b07b8214@nvidia.com>
 <20260120-dmabuf-revoke-v3-3-b7e0b07b8214@nvidia.com>
 <4fe42e7e-846c-4aae-8274-3e9a5e7f9a6d@amd.com>
 <20260121091423.GY13201@unreal>
 <7cfe0495-f654-4f9d-8194-fa5717eeafff@amd.com>
 <20260121131852.GX961572@ziepe.ca>
 <8a8ba092-6cfa-41d2-8137-e5e9d917e914@amd.com>
 <20260121135948.GB961572@ziepe.ca>
 <8689345b-241a-47f4-8e9a-61cde285bf8b@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8689345b-241a-47f4-8e9a-61cde285bf8b@amd.com>
X-Mailman-Approved-At: Thu, 22 Jan 2026 08:36:26 +0000
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

On Wed, Jan 21, 2026 at 03:15:46PM +0100, Christian König wrote:
> > And let's clarify what I said in my other email that this new revoke
> > semantic is not just a signal to maybe someday unmap but a hard
> > barrier that it must be done once the fences complete, similar to
> > non-pinned importers.
> 
> Well, I would avoid that semantics.
>
> Even when the exporter requests the mapping to be invalidated it
> does not mean that the mapping can go away immediately.
> 
> It's fine when accesses initiated after an invalidation and then
> waiting for fences go into nirvana and have undefined results, but
> they should not trigger PCI AER, warnings from the IOMMU or even
> worse end up in some MMIO BAR of a newly attached devices.

So what's the purpose of the fence if accesses can continue after
waiting for fences?

If we always have to wait for the unmap call, is the importer allowed
to call unmap while its own fences are outstanding?

> So if the exporter wants to be 100% sure that nobody is using the
> mapping any more then it needs to wait for the importer to call
> dma_buf_unmap_attachment().

We are trying to introduce this new idea called "revoke".

Revoke means the exporter does some defined sequence and after the end
of that sequence it knows there are no further DMA or CPU accesses to
its memory at all.

It has to happen in bounded time, so it can't get entangled with
waiting for userspace to do something (eg importer unmap via an ioctl)

It has to be an absolute statement because the VFIO and RDMA exporter
use cases can trigger UAFs and AERs if importers keep accessing.

So, what exactly should the export sequence be? We were proposing to
call invalidate_mapping() and when it returns there is no access.

The fence is missing, so now the sequences includes wait for the
fences.

And now you are saying we have to wait for all unmaps? Not only wait
for the unmaps, but the importers now also must call unmap as part of
their invalidate_mapping() callback.. Is that OK? Do existing
importers do that?

If all the above are yes, then lets document explicitly this is the
required sequence and we can try to make it work. Please say, because
we just don't know and keep getting surprised :)

Thanks,
Jason
