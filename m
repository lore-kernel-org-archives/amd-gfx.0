Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40D56D358CC
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jan 2026 07:33:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D03E410E2D8;
	Thu, 29 Jan 2026 07:33:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nd7XKBpW";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8480C10E2D8;
 Thu, 29 Jan 2026 07:33:36 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 5FF8D41AF1;
 Thu, 29 Jan 2026 07:33:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81028C4CEF7;
 Thu, 29 Jan 2026 07:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769672016;
 bh=QBIwpAtD3x2QlngJHpmtfy+I0xZag8/IoNN2nefvD44=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nd7XKBpWVASqj2PQ5+O26lNzR2owwrjZ+UFhzwzV5C7rfonAJCymlbkRGjNsekjom
 he9rYeseZjNSy/0uUsYtu2rE0V9B2obwvYr84gMEMsIXfMHbRpIOLQG8VKcUj1EDWG
 RCL32sfCprWk7ujIe52D/CGmaJLCftvBy9NNCh9toQxOiXhsAaRnM3ffpkajAH1ZpM
 fXNq2C3mRiG9ylqGldO5M8PS6KozilVEFN97LtMCnv+QZPbZmSb3kvTLNumwZq3+2a
 cXHUw1JolJPAOY7ZZE4cbJzciDN3W68iIBcC3s0kcCkl9sD9ehst1O+sHirdqoPJBu
 OQUMpJRWtxn7A==
Date: Thu, 29 Jan 2026 09:33:31 +0200
From: Leon Romanovsky <leon@kernel.org>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Pranjal Shrivastava <praan@google.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
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
 "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Williamson <alex@shazbot.org>, Ankit Agrawal <ankita@nvidia.com>,
 "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
 "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH v5 4/8] vfio: Wait for dma-buf invalidation to complete
Message-ID: <20260129073331.GB10992@unreal>
References: <20260124-dmabuf-revoke-v5-0-f98fca917e96@nvidia.com>
 <20260124-dmabuf-revoke-v5-4-f98fca917e96@nvidia.com>
 <aXfUZcSEr9N18o6w@google.com> <20260127085835.GQ13967@unreal>
 <20260127162754.GH1641016@ziepe.ca>
 <BN9PR11MB5276B99D4E8C6496B0C447888C9EA@BN9PR11MB5276.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BN9PR11MB5276B99D4E8C6496B0C447888C9EA@BN9PR11MB5276.namprd11.prod.outlook.com>
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

On Thu, Jan 29, 2026 at 07:06:37AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@ziepe.ca>
> > Sent: Wednesday, January 28, 2026 12:28 AM
> > 
> > On Tue, Jan 27, 2026 at 10:58:35AM +0200, Leon Romanovsky wrote:
> > > > > @@ -333,7 +359,37 @@ void vfio_pci_dma_buf_move(struct
> > vfio_pci_core_device *vdev, bool revoked)
> > > > >  			dma_resv_lock(priv->dmabuf->resv, NULL);
> > > > >  			priv->revoked = revoked;
> > > > >  			dma_buf_invalidate_mappings(priv->dmabuf);
> > > > > +			dma_resv_wait_timeout(priv->dmabuf->resv,
> > > > > +					      DMA_RESV_USAGE_BOOKKEEP,
> > false,
> > > > > +					      MAX_SCHEDULE_TIMEOUT);
> > > > >  			dma_resv_unlock(priv->dmabuf->resv);
> > > > > +			if (revoked) {
> > > > > +				kref_put(&priv->kref,
> > vfio_pci_dma_buf_done);
> > > > > +				/* Let's wait till all DMA unmap are
> > completed. */
> > > > > +				wait = wait_for_completion_timeout(
> > > > > +					&priv->comp, secs_to_jiffies(1));
> > > >
> > > > Is the 1-second constant sufficient for all hardware, or should the
> > > > invalidate_mappings() contract require the callback to block until
> > > > speculative reads are strictly fenced? I'm wondering about a case where
> > > > a device's firmware has a high response latency, perhaps due to internal
> > > > management tasks like error recovery or thermal and it exceeds the 1s
> > > > timeout.
> > > >
> > > > If the device is in the middle of a large DMA burst and the firmware is
> > > > slow to flush the internal pipelines to a fully "quiesced"
> > > > read-and-discard state, reclaiming the memory at exactly 1.001 seconds
> > > > risks triggering platform-level faults..
> > > >
> > > > Since the wen explicitly permit these speculative reads until unmap is
> > > > complete, relying on a hardcoded timeout in the exporter seems to
> > > > introduce a hardware-dependent race condition that could compromise
> > > > system stability via IOMMU errors or AER faults.
> > > >
> > > > Should the importer instead be required to guarantee that all
> > > > speculative access has ceased before the invalidation call returns?
> > >
> > > It is guaranteed by the dma_resv_wait_timeout() call above. That call
> > ensures
> > > that the hardware has completed all pending operations. The 1‑second
> > delay is
> > > meant to catch cases where an in-kernel DMA unmap call is missing, which
> > should
> > > not trigger any DMA activity at that point.
> > 
> > Christian may know actual examples, but my general feeling is he was
> > worrying about drivers that have pushed the DMABUF to visibility on
> > the GPU and the move notify & fences only shoot down some access. So
> > it has to wait until the DMABUF is finally unmapped.
> > 
> > Pranjal's example should be covered by the driver adding a fence and
> > then the unbounded fence wait will complete it.
> > 
> 
> Bear me if it's an ignorant question.
> 
> The commit msg of patch6 says that VFIO doesn't tolerate unbounded
> wait, which is the reason behind the 2nd timeout wait here.

It is not accurate. A second timeout is present both in the
description of patch 6 and in VFIO implementation. The difference is
that the timeout is enforced within VFIO.

> 
> Then why is "the unbounded fence wait" not a problem in the same
> code path? the use of MAX_SCHEDULE_TIMEOUT imply a worst-case
> timeout in hundreds of years...

"An unbounded fence wait" is a different class of wait. It indicates broken
hardware that continues to issue DMA transactions even after it has been told to
stop.

The second wait exists to catch software bugs or misuse, where the dma-buf
importer has misrepresented its capabilities.

> 
> and it'd be helpful to put some words in the code based on what's
> discussed here.

We've documented as much as we can in dma_buf_attach_revocable() and
dma_buf_invalidate_mappings(). Do you have any suggestions on what else
should be added here?

Thanks
