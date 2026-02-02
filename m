Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CAA9E83061
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Feb 2026 08:16:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B67A210E57E;
	Tue,  3 Feb 2026 08:16:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="mHjmZK2C";
	dkim-atps=neutral
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com
 [209.85.160.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8948310E2CD
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Feb 2026 15:12:24 +0000 (UTC)
Received: by mail-qt1-f181.google.com with SMTP id
 d75a77b69052e-5014e1312c6so29109541cf.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Feb 2026 07:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1770045143; x=1770649943; darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xO0aL+oRN74yVSsHQO79QNqtu9/dj8jxjzC/60StG/Q=;
 b=mHjmZK2CmvQxQ0XAUb3rNkLamIHL4x5oX8SoAdm6Z6tVEKW3TRpqdDLDwApd3n58wA
 5p1qivXekI8cOrBg0svssXisHj/9OT9L2NwmivHVFOTYHacj/4AqZ+/xDD49cvqpKgap
 jL0fzHjLkNCEQQh9F0ojLUJzro1775y2cGSu5nLYRmnVvZfb1Y/zCKuw3ig8q/PI8irX
 wmLs4I2WytRYDlhgvmMEgTI2QL7OUKqNS8aKVkyM/skBQPEMJNbx9gwYStQ13WfMynJP
 qhmnyHKc64KuK2dPNVTJ/VU7F6NIj7J0Q1byBhr6XULyOsnKw8RBBtioelrCjBzscGSl
 sbZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770045143; x=1770649943;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xO0aL+oRN74yVSsHQO79QNqtu9/dj8jxjzC/60StG/Q=;
 b=OXasL0j5Q/uNPIhi1ce4rgBN4zM38ypf+xRpJ0y5C9QzEGej8vjoNKqeK7MaWjA1j+
 iJBURN5rS9kr0/W76ItlszuXm++rmpDEjW+G2qduz7ZYVaB2jGbGwhPEHU6Ftxlxnk23
 UhX9eyOxFrX/VP5sKNhGuAeC0sDYLcgoFysGUX8U0z94cMZLk6c0hLH3bpeMRn77jRni
 BcZC2RkRxfKj8DN1+3St0BHxr+BTGzvhyTaqtjTVnk+uMCyXmG538p8/9/crZOgKv0qo
 7EfnBcogAyQpm9VVQ5uzwj+o125txUceHnRGyL3FSyeCOyoek6t1eV9k2UNoUN40bIta
 EMVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhb7gNXndnnLHwzHc2CNeS4uuEMX26KwZ26t/bVV47ZZXWPDj3R9zxTa3bqY0LpBbQtZ+Sdl+N@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxrODKHVkBASO6alhWrcOvNGT4EAlmLt77Al6o31TrBOGcGf+eJ
 6VBjIWBc1j06pYDj4QUOaNC/hcZNDdPIKAMg8nqO/mqcHNsS3W+lp11nCMP04z6YFhc=
X-Gm-Gg: AZuq6aJ9Vw4h9/SPhFJsQp0a6Bcf6BX4pFJw9YdvvERxVwPAIvPuCciclP0RIFoB+E/
 nKikupUmj1BiD+AttCRiqSP82GVfVI4xkHfd4H6o5bj0CPD1pne7RPjMM5AHuU5jotidRNuORoh
 5kXS0Hefd9jKH20CeBhY6Xl6EBaAwbJ5VONp5Hnu2IAe+HiKLxjqrEP2cnepDIuwHTHVIJLYY6z
 qcnUTo5wYK83K2YdIYp9F6+TbVKGkM6Dp+tg7s4W/AoI5gGp+Nwk7dHLiUu4PTNFYvZIijfec/O
 lGGrF39Lqee4BGaEM/400pFJqFpsMTJJm6ShGwjc+Tiq12CxTdVWuzMZPHh7pBzgxHO7Q5pFXbQ
 LLi3/wrP2ToIwBAoPYsn4g73nYdue49B0Jv+U0ry/E1LQHZ/Sh8+maVb1BgXIiOW9A3axc+SoQr
 jDTlg57mfmmADLhU3tZu6MDLbKjk1i5JgtKGv8Vgt9IlWvwomFhhnpQUSKnqF/uf0zaSg=
X-Received: by 2002:a05:622a:1993:b0:4ee:1903:367b with SMTP id
 d75a77b69052e-505d214ba65mr150834861cf.5.1770045143271; 
 Mon, 02 Feb 2026 07:12:23 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.112.119]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50337bb9d21sm106856261cf.26.2026.02.02.07.12.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 07:12:22 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1vmvbB-0000000FJuI-3Zxp;
 Mon, 02 Feb 2026 11:12:21 -0400
Date: Mon, 2 Feb 2026 11:12:21 -0400
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
Subject: Re: [PATCH v5 4/8] vfio: Wait for dma-buf invalidation to complete
Message-ID: <20260202151221.GH2328995@ziepe.ca>
References: <20260124-dmabuf-revoke-v5-0-f98fca917e96@nvidia.com>
 <20260124-dmabuf-revoke-v5-4-f98fca917e96@nvidia.com>
 <31872c87-5cba-4081-8196-72cc839c6122@amd.com>
 <20260130130131.GO10992@unreal>
 <d25bead8-8372-4791-a741-3371342f4698@amd.com>
 <20260130135618.GC2328995@ziepe.ca>
 <d1dce6c1-9a89-4ae4-90eb-7b6d8cdcdd91@amd.com>
 <20260130144415.GE2328995@ziepe.ca>
 <c976c33c-4fa7-4350-8dcc-a5c218d1b0d6@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c976c33c-4fa7-4350-8dcc-a5c218d1b0d6@amd.com>
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

On Mon, Feb 02, 2026 at 09:42:22AM +0100, Christian König wrote:
> On 1/30/26 15:44, Jason Gunthorpe wrote:
> > On Fri, Jan 30, 2026 at 03:11:48PM +0100, Christian König wrote:
> >> On 1/30/26 14:56, Jason Gunthorpe wrote:
> >>> On Fri, Jan 30, 2026 at 02:21:08PM +0100, Christian König wrote:
> >>>
> >>>> That would work for me.
> >>>>
> >>>> Question is if you really want to do it this way? See usually
> >>>> exporters try to avoid blocking such functions.
> >>>
> >>> Yes, it has to be this way, revoke is a synchronous user space
> >>> triggered operation around things like FLR or device close. We can't
> >>> defer it into some background operation like pm.
> >>
> >> Yeah, but you only need that in a couple of use cases and not all.
> > 
> > Not all, that is why the dma_buf_attach_revocable() is there to
> > distinguish this case from others.
> 
> No, no that's not what I mean.
> 
> See on the one hand you have runtime PM which automatically shuts
> down your device after some time when the last user stops using it.
> 
> Then on the other hand you have an intentional revoke triggered by
> userspace.
> 
> As far as I've read up on the code currently both are handled the
> same way, and that doesn't sound correct to me.
> 
> Runtime PM should *not* trigger automatically when there are still
> mappings or even DMA-bufs in existence for the VFIO device.

I'm a little confused why we are talking about runtime PM - are you
pointing out an issue in VFIO today where it's PM support is not good?

I admit I don't know a lot about VFIO PM support.. Though I thought in
the VFIO case PM was actually under userspace control as generally the
PM control is delegated to the VM.

Through that lens, what is happening here is correct. If the VM
requests to shut down VFIO PM (through a hypervisor vfio ioctl) then
we do want to revoke the DMABUF so that the VM can't trigger a AER/etc
by trying to access the sleeping PCI device.

I don't think VFIO uses automatic PM on a timer, that doesn't make
sense for it's programming model.

Jason
