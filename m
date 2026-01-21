Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89770D4694F
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jan 2026 15:46:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28AF310E21F;
	Wed, 21 Jan 2026 15:46:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="t97wEG8R";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8B5510E21F;
 Wed, 21 Jan 2026 15:46:26 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id C74B2600AA;
 Wed, 21 Jan 2026 15:46:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C79C7C4CEF1;
 Wed, 21 Jan 2026 15:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769010385;
 bh=wsp0Ee/Wyi7vSUVwVM1dt7Rh8gLnheehWV+BoZfOvsU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=t97wEG8R3Vclg+HjbADh6Re31LoTY+IEQ//+/mnlWg1SY0DWWznX+wkzufS/8RTPw
 cFRK4kAf7NSHmPyBgCi82jqY7mcIsr1SPIUA+DfGH+0sVbcGIIjaD3E9NvDWdaGQVx
 LdTOIbm0sfpJbWGFzlKIoFrPX2a1YPoLdupT/uZEE8P5zTY/Y9osGFW/VyLT82WWgJ
 TZMQRbM9NUBS2Upq18HxU+6bzyq7clPDWPDeMzkHTDGuxQmBCpWoxQ0JRBZ6ihl7MC
 pISuKsiX5PxQGXQHWql6x3YzR56jEtvSfhu2oH2477i9lN+U+568UYrW9OFuumSVq0
 ES+FsrOJCjoVw==
Date: Wed, 21 Jan 2026 17:46:21 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Alex Williamson <alex@shazbot.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
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
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
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
Subject: Re: [PATCH v4 8/8] vfio: Validate dma-buf revocation semantics
Message-ID: <20260121154621.GH13201@unreal>
References: <20260121-dmabuf-revoke-v4-0-d311cbc8633d@nvidia.com>
 <20260121-dmabuf-revoke-v4-8-d311cbc8633d@nvidia.com>
 <20260121134712.GZ961572@ziepe.ca> <20260121144701.GF13201@unreal>
 <20260121154137.GD961572@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121154137.GD961572@ziepe.ca>
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

On Wed, Jan 21, 2026 at 11:41:37AM -0400, Jason Gunthorpe wrote:
> On Wed, Jan 21, 2026 at 04:47:01PM +0200, Leon Romanovsky wrote:
> > > We need to push an urgent -rc fix to implement a pin function here
> > > that always fails. That was missed and it means things like rdma can
> > > import vfio when the intention was to block that. It would be bad for
> > > that uAPI mistake to reach a released kernel.
> > 
> > I don't see any urgency here. In the current kernel, the RDMA importer
> > prints a warning to indicate it was attached to the wrong exporter.
> > VFIO also invokes dma_buf_move_notify().
> 
> The design of vfio was always that it must not work with RDMA because
> we cannot tolerate the errors that happen due to ignoring the
> move_notify.
> 
> The entire purpose of this series could be stated as continuing to
> block RDMA while opening up other pining users.
> 
> So it must be addressed urgently before someone builds an application
> relying on this connection.

Done, https://lore.kernel.org/all/20260121-vfio-add-pin-v1-1-4e04916b17f1@nvidia.com/T/#u

Thanks

> 
> Jason
