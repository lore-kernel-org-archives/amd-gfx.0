Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0214D46944
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jan 2026 14:47:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68F1410E813;
	Wed, 21 Jan 2026 14:47:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JbtXmZSx";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13E8610E0E5;
 Wed, 21 Jan 2026 14:47:07 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 20B276012A;
 Wed, 21 Jan 2026 14:47:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1598EC116D0;
 Wed, 21 Jan 2026 14:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769006825;
 bh=VUd/erMA9+hZk86UiU7NZHM5b4w3R6spYmbLOtJgHkg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JbtXmZSxHWLaEI1QTp0Q8IQ5MH0jbQvbYAo8cgM2Pj4N1/oGHFyjgztvi0eewWe/o
 wqDQp3Kr5rl4cZ4oigzTAV5wzelm4FfNhjA7yT3wbGPp5B20a88x+4TdtQaFHPOd7u
 CIq4I0xGvg122z6NXkf9F0+RwOjhvH6fhsDoJjEZoZsx194Wau2SXnVm0JM9UsFo2P
 kp6Uqg634KNYi8joBJcTxqmS3PRTyhOtwuR34sAGEP5Q+BFp24bN7hbCf+e97kLMS3
 2UZWDLQvYcXJZsCPqgiUzRWKjS0rdakOxAfV0ThJbUtlUFFlD8tRYHbhNwlrewCWwq
 WG/aSv1CDr9ZQ==
Date: Wed, 21 Jan 2026 16:47:01 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
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
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Williamson <alex@shazbot.org>, Ankit Agrawal <ankita@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, virtualization@lists.linux.dev,
 intel-xe@lists.freedesktop.org, linux-rdma@vger.kernel.org,
 iommu@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [PATCH v4 8/8] vfio: Validate dma-buf revocation semantics
Message-ID: <20260121144701.GF13201@unreal>
References: <20260121-dmabuf-revoke-v4-0-d311cbc8633d@nvidia.com>
 <20260121-dmabuf-revoke-v4-8-d311cbc8633d@nvidia.com>
 <20260121134712.GZ961572@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121134712.GZ961572@ziepe.ca>
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

On Wed, Jan 21, 2026 at 09:47:12AM -0400, Jason Gunthorpe wrote:
> On Wed, Jan 21, 2026 at 02:59:16PM +0200, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > Use the new dma_buf_attach_revocable() helper to restrict attachments to
> > importers that support mapping invalidation.
> > 
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> >  drivers/vfio/pci/vfio_pci_dmabuf.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
> > index 5fceefc40e27..85056a5a3faf 100644
> > --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> > +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> > @@ -31,6 +31,9 @@ static int vfio_pci_dma_buf_attach(struct dma_buf *dmabuf,
> >  	if (priv->revoked)
> >  		return -ENODEV;
> >  
> > +	if (!dma_buf_attach_revocable(attachment))
> > +		return -EOPNOTSUPP;
> > +
> >  	return 0;
> >  }
> 
> We need to push an urgent -rc fix to implement a pin function here
> that always fails. That was missed and it means things like rdma can
> import vfio when the intention was to block that. It would be bad for
> that uAPI mistake to reach a released kernel.

I don't see any urgency here. In the current kernel, the RDMA importer
prints a warning to indicate it was attached to the wrong exporter.
VFIO also invokes dma_buf_move_notify().

With this series, we finally remove that warning.

Let's focus on getting this series merged.

Thanks

> 
> It's tricky that NULL pin ops means "I support pin" :|
> 
> Jason
