Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 385E5D715D9
	for <amd-gfx@archiver.kernel.org>; Sat, 24 Jan 2026 09:41:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6F6610E324;
	Sat, 24 Jan 2026 09:41:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="ahVOLqIg";
	dkim-atps=neutral
Received: from mail-qv1-f67.google.com (mail-qv1-f67.google.com
 [209.85.219.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4520F10EAF9
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jan 2026 14:11:43 +0000 (UTC)
Received: by mail-qv1-f67.google.com with SMTP id
 6a1803df08f44-8947e6ffd30so25947956d6.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jan 2026 06:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1769177502; x=1769782302; darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=A5PKpJ/4T6+3Viu0suTKGZFl50yyl7xVfieAULiIAgY=;
 b=ahVOLqIgyXixUNK4lb0/pN99kn1auG+1l3qXDZl5kYJ8cl+hg8wDfKzttUb1daqzzU
 z1zR7YjP4aMZzTjfxdPcm3df2/QoVD+7t9YStQPra+e33dkWzVRWhT0zYMqwzsB5sA1p
 pIUREqS4H82+jWs/4UpaiG3OleRCbrmdhVLTfP6rkpYe5FmiCe6+jngginIdzAaZSuAW
 BQRlfDBU2GLzrCi8WpXxnxWpuWJOzmLPtjrUI1jL6IiPz2W5y2j56C8YhIAry+4NxOUD
 0NFwkWhdOgPIyvWw1iinvLLy+Tge9ct570QIhqTWvwWo7f+SgigfvamQw+w+0/nKVx0g
 uQGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769177502; x=1769782302;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=A5PKpJ/4T6+3Viu0suTKGZFl50yyl7xVfieAULiIAgY=;
 b=FZG3BkvJIaMWPoICj8raiahR4GIeiSsdW8VkDzDZtFkQW8H0VF/uQFbR+IHpCUCPj5
 HGYI047Il0BilEzz4b00vfWgKWsvqqgny1SFFw3g5p5u7PtvxU3Xa5l/KOUnbah4yQsc
 y4hg1pAgqm8lsmPmTbe9nm0NZ5Eae0k/qynjJPfYdQ4j6LAh/IyphHkx0EHXe362eV49
 3CRsEpbDKhRc88al0fkcR8Y6gO5zGriKjB7bbeGEyrwErtQH6RzsEvMhhMy2kS/wsmWY
 gPDW1fre243k86+Jtd2sVGR2ybWQptpcSUU8P21fvF0UFFW3GaiA7t+hii6hWn/O2aJY
 HyJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzOdAI/r2BXZS+G9ywUiN9bAw9M4+Emk+PciX6ocdC3YoqvrbTXCR69fAp5ICdD1D6U7SDJuCv@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyn2VKEupjbIHCXCqMxN3Ic3tHnk/YacnLVdZ374Tm1TV10oEqs
 9ZEFStfQheAEbvMu5u8PwY/vfvgAURY9vB2qxdJLwAoX/mEIZs92Pen6GYaFJWQmPD0=
X-Gm-Gg: AZuq6aLL8dpPhBiwoS8MQJFVTYT42Ue9XEy6Q/ZTF6t4i+yHlrq9ByOZw/PZVD4FOrw
 Fn/ETP5pXP4WBjN09UfzqLsGhfB3HKhczeBgZIMhDbeZp+1ysYH1j8dMkdkgKTQXRcxW73ZDH/K
 v0Y6perIz4bBRHihqXIz0IoT16vKzY+DxCuyuUXTiq/KAJZvTNAH8cy26W0Z0BBh00TiDtqdvhA
 1L+qMQJU0kRJ7PrdCGqtU5ryuejmTBheXf/Oy507m6WhSlClzQn1vg+0XnzEvPyXxLdRpTjvBlp
 GqRcJbIgZdNKyojcpjzTHt/X9jv4N1Febu/dB1g8y15SRillNix/gzr1mNp80CioXqnoa77o0ET
 c+Jd4JSPss+iksd39gBUQ738chYbdb4I+dkjDy0ivZ51BAz6cdJanPhgGms5XjSZzY1qVwNeZaV
 GidUQm6ymt04MeLYYHJUhJ8joVEBsZVptDS7KMro0cqBra3C2BK+VJX9yAbxG/cUce5bQN3/Ae/
 3nWyw==
X-Received: by 2002:ad4:5c46:0:b0:88a:589b:5db5 with SMTP id
 6a1803df08f44-894900d6bccmr42275406d6.0.1769177502022; 
 Fri, 23 Jan 2026 06:11:42 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.112.119]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c6e37c8fa6sm187731585a.4.2026.01.23.06.11.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jan 2026 06:11:41 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1vjHsy-00000006stw-3Bfb;
 Fri, 23 Jan 2026 10:11:40 -0400
Date: Fri, 23 Jan 2026 10:11:40 -0400
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
Message-ID: <20260123141140.GC1589888@ziepe.ca>
References: <20260120-dmabuf-revoke-v3-0-b7e0b07b8214@nvidia.com>
 <20260120-dmabuf-revoke-v3-6-b7e0b07b8214@nvidia.com>
 <b129f0c1-b61e-4efb-9e25-d8cdadaca1b3@amd.com>
 <20260121133146.GY961572@ziepe.ca>
 <b88b500c-bacc-483d-9d1a-725d4158302a@amd.com>
 <20260121160140.GF961572@ziepe.ca>
 <a1c55bd8-9891-4064-83fe-ac56141e586f@amd.com>
 <20260122234404.GB1589888@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260122234404.GB1589888@ziepe.ca>
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

On Thu, Jan 22, 2026 at 07:44:04PM -0400, Jason Gunthorpe wrote:
> On Thu, Jan 22, 2026 at 12:32:03PM +0100, Christian König wrote:
> > >> What roughly happens is that each DMA-buf mapping through a couple
> > >> of hoops keeps a reference on the device, so even after a hotplug
> > >> event the device can only fully go away after all housekeeping
> > >> structures are destroyed and buffers freed.
> > > 
> > > A simple reference on the device means nothing for these kinds of
> > > questions. It does not stop unloading and reloading a driver.
> > 
> > Well as far as I know it stops the PCIe address space from being re-used.
> > 
> > So when you do an "echo 1 > remove" and then an re-scan on the
> > upstream bridge that works, but you get different addresses for your
> > MMIO BARs!
> 
> That's pretty a niche scenario.. Most people don't rescan their PCI
> bus. If you just do rmmod/insmod then it will be re-used, there is no
> rescan to move the MMIO around on that case.

Ah I just remembered there is another important detail here.

It is illegal to call the DMA API after your driver is unprobed. The
kernel can oops. So if a driver is allowing remove() to complete
before all the dma_buf_unmaps have been called it is buggy and risks
an oops.

https://lore.kernel.org/lkml/8067f204-1380-4d37-8ffd-007fc6f26738@kernel.org/T/#m0c7dda0fb5981240879c5ca489176987d688844c

As calling a dma_buf_unmap() -> dma_unma_sg() after remove() returns
is not allowed..

Jason
