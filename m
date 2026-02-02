Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0DCFE83062
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Feb 2026 08:16:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D96510E581;
	Tue,  3 Feb 2026 08:16:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="CT6MM/Lw";
	dkim-atps=neutral
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com
 [209.85.160.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 228F410E52D
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Feb 2026 15:55:14 +0000 (UTC)
Received: by mail-qt1-f171.google.com with SMTP id
 d75a77b69052e-5014600ad12so34293861cf.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Feb 2026 07:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1770047713; x=1770652513; darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ALEv89D4GoCyBIrWNO6jRp/YUrS6bKKk+NOOQflmefI=;
 b=CT6MM/LwSQWyAUZ8oUbVcclHf/cLWGhKvV0HWN73HafdAcBzN6yWuSInG57yn5ugRI
 uWrq5pzxkqkRNRen6m+iV8Csz6fR+53J6tfrnH3enePXF7g99XDW2FeARZkkWtuGJGVd
 1HMqiMhV91D++RIi4k/h0lim3aGjbhK4SsOKAZhBiW8ICLmTF52r5BnTCKfh2PlsM0bt
 NEIwjYoB6MKekoNb5n/KZc56939e+Hdj2p3zwL2Upy7cN96e/nh9leVHqcwPDOJArqrO
 JbAVBqFy76XxaCyfyhZmm4Xn26BiAtf5VRnaCTfainddI+iiwHFPy0pgWl2qHUq3XiqE
 wQeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770047713; x=1770652513;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ALEv89D4GoCyBIrWNO6jRp/YUrS6bKKk+NOOQflmefI=;
 b=OT4w/dDrQNLUqSc0kwNWxnCTcja27WVxWaS2IEinoShqJuont/y9hXZlbmPbFsYRos
 eLYuEKqIZvPoaIJiZU5a78XHGv9TmsMSBsdqOs5WV6l7+K48C59WvU2agLMj/VONCEj/
 +QYF6j640CoHF1ELzN8tee1HjtFW2P5dMB2jdv+3HSQ8Bk3g09tnSIVUi/Qvh6uopEh8
 I7aG4eDkDmwrutWb0blAAQnBWDUlSGCT43LlDe74Y25eHqHPbiiwIfkuWO74Fp3GciHg
 l9gyr+m5S9i+Ds3QIPEJU+/Kr37QE1n3CSeJdf+KzCbdYMINu9CTejhMlC6s98km15SD
 R/Gw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8ctVbWAvilT9+xPd3YGzivcEC/rKPPp0/TtlfzcrxqRVM6jVgXyv1s7+0knBHBC3FtgEi2sne@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz/lv0L2MEDubJ0eUjkn/d19UDmVoDLHHKhqvJ/MXXIYt/M9dVU
 ON1h7FDpPP+XnX7pjXWWJDJlcZeZlmeR3ZHHjhv0ymfWT89IXpFT2o9Jxmf/1pHFRcM=
X-Gm-Gg: AZuq6aLoiSU2tENuKaS+tjgmpKVm5RtRLDMhLdqyXzjwFbkyNcGMWDzwtBBTVUReYvf
 vy9QC7djuBkLhaFWJVdcZU5nSuPczl/sd9kGulpriQZ1H/q14MJqACbXfOqyhJg9R/TXSIA5few
 6xVC49BtBtVJgT/wgDesd6inUkIlntiVQYbHx7aJwAjwMD1eYHmfQNQhwZR5JvE3q0U/t6nCzGp
 q4zwaJ3d/9rbIpaRlKtpg6BejCssz0RrpuYBC3EtzD47w4oW8qbHu0sdZZBslK3UoavA0xYb0n0
 FSEGu2gC3wuxdFrG7X725mLYmZfqYD13VWY5i7GifoXESg+CR4CvgaNXitEIPgw6JaUew9CFAh9
 xygZ9fNexypqFb9Fg9se91WuJR2E3wy48BcSb6jzZW7adi1tdCJJyP3eG4/JdNIKDOB7LbbEZ15
 UCywGt7mSX0O/VllcGIcqIaU+QoYdrWkHlNaWnlguH1Cd/xp98k0Mi3jAg94nKHv0Sd5Y=
X-Received: by 2002:a05:622a:1a82:b0:4f1:dfc8:50b with SMTP id
 d75a77b69052e-505d22b2818mr153088161cf.76.1770047712810; 
 Mon, 02 Feb 2026 07:55:12 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.112.119]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50337ba3997sm107174411cf.17.2026.02.02.07.55.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 07:55:12 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1vmwGd-0000000FWiw-2z4k;
 Mon, 02 Feb 2026 11:55:11 -0400
Date: Mon, 2 Feb 2026 11:55:11 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Alex Williamson <alex@shazbot.org>
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
 Felix Kuehling <Felix.Kuehling@amd.com>, Ankit Agrawal <ankita@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, virtualization@lists.linux.dev,
 intel-xe@lists.freedesktop.org, linux-rdma@vger.kernel.org,
 iommu@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [PATCH v5 4/8] vfio: Wait for dma-buf invalidation to complete
Message-ID: <20260202155511.GI2328995@ziepe.ca>
References: <20260124-dmabuf-revoke-v5-4-f98fca917e96@nvidia.com>
 <31872c87-5cba-4081-8196-72cc839c6122@amd.com>
 <20260130130131.GO10992@unreal>
 <d25bead8-8372-4791-a741-3371342f4698@amd.com>
 <20260130135618.GC2328995@ziepe.ca>
 <d1dce6c1-9a89-4ae4-90eb-7b6d8cdcdd91@amd.com>
 <20260130144415.GE2328995@ziepe.ca>
 <c976c33c-4fa7-4350-8dcc-a5c218d1b0d6@amd.com>
 <20260202151221.GH2328995@ziepe.ca>
 <44ec9689-045e-401b-b9cc-17abdd938bc7@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <44ec9689-045e-401b-b9cc-17abdd938bc7@amd.com>
X-Mailman-Approved-At: Tue, 03 Feb 2026 08:16:06 +0000
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

On Mon, Feb 02, 2026 at 04:21:50PM +0100, Christian König wrote:
> > I admit I don't know a lot about VFIO PM support.. Though I thought in
> > the VFIO case PM was actually under userspace control as generally the
> > PM control is delegated to the VM.
> > 
> > Through that lens, what is happening here is correct. If the VM
> > requests to shut down VFIO PM (through a hypervisor vfio ioctl) then
> > we do want to revoke the DMABUF so that the VM can't trigger a AER/etc
> > by trying to access the sleeping PCI device.
> > 
> > I don't think VFIO uses automatic PM on a timer, that doesn't make
> > sense for it's programming model.
> 
> From your description I agree that this doesn't make sense, but from
> the code it looks like exactly that is done.
> 
> Grep for pm_runtime_* on drivers/vfio/pci, but could be that I
> misunderstood the functionality, e.g. didn't spend to much time on
> it.
> 
> Just keep it in the back of your mind and maybe double check if that
> is actually the desired behavior.

I had a small conversation with AlexW and we think VFIO is OK (bugs
excluded).

The use of the PM timer is still under userspace control, even though
a timer is still involved.

Basically there are a series of IOCTL defined in VFIO, like
LOW_POWER_ENTRY that all isolate the PCI device from userspace. The
mmap is blocked with SIBGUS and the DMABUFs are revoked.

The VFIO uAPI contract requries userspace to stop touching the device
immediately when using these IOCTLs. The PM timer may still be
involved, but is an implementation detail.

Effectively VFIO has a device state "isolated" meaning that userspace
cannot access the MMIO, and it enters this state based on various
IOCTLs from userspace. It ties mmap and DMABUF together so that if
mmap SIGBUS's the DMABUF is unmapped.

I understand your remarks, and this use of PM is certainly nothing
that any other driver should copy, but it does make sense for VFIO. If
there are bugs/issues we would continue to keep the overall property
that SGIBUS==DMABUF unmapped and only adjust when that happens.

TBH, I don't think people use the VFIO PM feature very much.

Jason
