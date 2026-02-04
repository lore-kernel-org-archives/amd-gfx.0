Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9537FE83F1F
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Feb 2026 14:01:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D90C10E8B6;
	Thu,  5 Feb 2026 14:01:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="GPUdg60W";
	dkim-atps=neutral
Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com
 [209.85.222.196])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3B4510E6E6
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Feb 2026 16:55:09 +0000 (UTC)
Received: by mail-qk1-f196.google.com with SMTP id
 af79cd13be357-8c710439535so563070285a.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Feb 2026 08:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1770224108; x=1770828908; darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+k5zz356tCtx+TsrSTgNS2LOgl52lZtCniOLQPd/1s0=;
 b=GPUdg60WryYi1Tdg25F+/ATxrcArA1eIzo+DLTK0OFdldSXA2i8mgELuG7NCrrFMi4
 d0Efd/CZD487hh/LBwnwMfPteOtlgM9B+BKPjxbZK0zo2eS4kjbFxnjAYs1fviKnrMAq
 2RdKLFdARvk3euApVykjvvqmiCu1p6yw+mzqgIxLERlaBUvkUGLB7MunFZSMkk7bgOWS
 kVWgGjUroYu4WN7xx7URKz/7OZoE6f+N+k8ebpzXfJ8KcZjCwzdPoXBSNPVM3uAzOmaq
 9QmK6/Z2MYXXcavXvtR9g+pzJJaOa+FP0vfjgHI7VwInc05Mo6t9+0Rq76XVFc0hM4J5
 gYnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770224108; x=1770828908;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+k5zz356tCtx+TsrSTgNS2LOgl52lZtCniOLQPd/1s0=;
 b=a8KMySiHhVscqAqghf6HUK0BTY8faSjVJd191Vm2oH9Z19JhZoH0rD52CGP1incrXX
 96igPf2yn16wvmU2ddNAcxAaDhqO626kvdgLl3jUIgiwaASN4eBbfNNAGRnL64mCLwUf
 ESnGWDdZopirAjR5qurmr78u39lvV/SQy3xNwpH0qclMoKqqYgzFJJ+85yc29vvDDExE
 EacmJOXENKzYfKDbHeLnxyfe2QxCOMoPtvJM+Vtoyu0SqtlyOyeQ3z3CDdJs2Y/5PF/5
 Iudo1GZgkxdVVtG83RD2CiHrSrjiD1TNpOygrHClg7fwrn+WjOOkt4xJqmr0kE9Gvh1m
 W3xA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWAkiir9ZgRBRY4Ae+2EucrQ57i7rgpWid/nvdY73qu+k4yDAfVR7r/X4cKJ6sq9yT52aNoef3@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwR5cY+aBmBv41Vsz7i8wx2PYS8RPqDlPwKt8Lfcx8pPfpX9kRs
 61xjNmnMOdIcTt+vkn/3/SlP2B8dcBUZxtXI3d7uJTX+CxAEqi+y2dAqFSpsGZ7mZDk=
X-Gm-Gg: AZuq6aK+X/oftzhTuA1pBOCWyDmUgC9ydaqd5r0lpNFGdseY0wiHh7Ra5V3bysth7ph
 iPtWsmPjXJQVM5D9lMkccYcGX3cNlzlL4sm/IamRS0jv3MAM9M3hBbVIiyIuwkvTcbZUMOS52A/
 XyGir8R4L4izJVRKFbqv55wGw4Yfka1nAAH/RFhPbZxcz6QSp6rOCo25djH+1R7FHMnE8OPip6s
 AZkhlQ2zGOWJjUtjYSGtUnXqFU6ohe6m6UMZtIF2lCPFrXTY5RwCI8z5RHUFROklRLv/nxwaV+x
 gyRnSiGQBaOdX5k4H4uTy9MQSotc7O2oi5NA92xzMcSUYJgnyPmU5fNjBlaVDK1oVFpCvioKrn/
 umC0nrg5ap2D68R3dpjQX3kvAMnhqa43/nyfXNlm0G44Z2kKE6L3+DnqrCj8i2y5eji/ot+tPFX
 AzlF31iZWXWe8dJx2xr5oT2CBhGa8ELHBOFQBMzFXi74FGFdSr45uazgsVhzvhupPIlyY=
X-Received: by 2002:a05:620a:4627:b0:8c7:177f:cc17 with SMTP id
 af79cd13be357-8ca2f9bbb5amr467025085a.46.1770224108469; 
 Wed, 04 Feb 2026 08:55:08 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.112.119]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8ca2fd2cfb4sm226461485a.33.2026.02.04.08.55.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 08:55:07 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1vng9j-0000000HH15-13rk;
 Wed, 04 Feb 2026 12:55:07 -0400
Date: Wed, 4 Feb 2026 12:55:07 -0400
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
Subject: Re: [PATCH v7 7/8] vfio: Permit VFIO to work with pinned importers
Message-ID: <20260204165507.GH2328995@ziepe.ca>
References: <20260131-dmabuf-revoke-v7-0-463d956bd527@nvidia.com>
 <20260131-dmabuf-revoke-v7-7-463d956bd527@nvidia.com>
 <fb9bf53a-7962-451a-bac2-c61eb52c7a0f@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fb9bf53a-7962-451a-bac2-c61eb52c7a0f@amd.com>
X-Mailman-Approved-At: Thu, 05 Feb 2026 14:01:18 +0000
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

On Wed, Feb 04, 2026 at 05:21:45PM +0100, Christian König wrote:
> On 1/31/26 06:34, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > Till now VFIO has rejected pinned importers, largely to avoid being used
> > with the RDMA pinned importer that cannot handle a move_notify() to revoke
> > access.
> > 
> > Using dma_buf_attach_revocable() it can tell the difference between pinned
> > importers that support the flow described in dma_buf_invalidate_mappings()
> > and those that don't.
> > 
> > Thus permit compatible pinned importers.
> > 
> > This is one of two items IOMMUFD requires to remove its private interface
> > to VFIO's dma-buf.
> > 
> > Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> > Reviewed-by: Alex Williamson <alex@shazbot.org>
> > Reviewed-by: Christian König <christian.koenig@amd.com>
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> >  drivers/vfio/pci/vfio_pci_dmabuf.c | 15 +++------------
> >  1 file changed, 3 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
> > index 78d47e260f34..a5fb80e068ee 100644
> > --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> > +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> > @@ -22,16 +22,6 @@ struct vfio_pci_dma_buf {
> >  	u8 revoked : 1;
> >  };
> >  
> > -static int vfio_pci_dma_buf_pin(struct dma_buf_attachment *attachment)
> > -{
> > -	return -EOPNOTSUPP;
> > -}
> > -
> > -static void vfio_pci_dma_buf_unpin(struct dma_buf_attachment *attachment)
> > -{
> > -	/* Do nothing */
> > -}
> > -
> 
> This chunk here doesn't want to apply to drm-misc-next, my educated
> guess is that the patch adding those lines is missing in that tree.

Yes. It looks like Alex took it to his next tree:

commit 61ceaf236115f20f4fdd7cf60f883ada1063349a
Author: Leon Romanovsky <leon@kernel.org>
Date:   Wed Jan 21 17:45:02 2026 +0200

    vfio: Prevent from pinned DMABUF importers to attach to VFIO DMABUF
    
    Some pinned importers, such as non-ODP RDMA ones, cannot invalidate their
    mappings and therefore must be prevented from attaching to this exporter.
    
    Fixes: 5d74781ebc86 ("vfio/pci: Add dma-buf export support for MMIO regions")
    Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
    Reviewed-by: Pranjal Shrivastava <praan@google.com>
    Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
    Link: https://lore.kernel.org/r/20260121-vfio-add-pin-v1-1-4e04916b17f1@nvidia.com
    Signed-off-by: Alex Williamson <alex@shazbot.org>

The very best thing would be to pull
61ceaf236115f20f4fdd7cf60f883ada1063349a which is cleanly based on
v6.19-rc6 ?

> How should we handle that? Patches 1-3 have already been pushed to
> drm-misc-next and I would rather like to push patches 4-6 through
> that branch as well.

Or we get Alex to take a branch from you for the first 3 and push it?

Jason
