Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 840EED2ECF7
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jan 2026 14:32:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB24F10E609;
	Tue, 20 Jan 2026 14:32:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="LjEUGirS";
	dkim-atps=neutral
Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com
 [209.85.222.196])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 689E410E5EC
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jan 2026 13:15:33 +0000 (UTC)
Received: by mail-qk1-f196.google.com with SMTP id
 af79cd13be357-8b2f0f9e4cbso439752985a.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jan 2026 05:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1768914932; x=1769519732; darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Jl2KF0othdvrwDImGzxJcxoX7WKdbBXFC823mMEO8nY=;
 b=LjEUGirSRwSa2OJJ9ghicZtfex1eNEPksqh2a+ZOBsyMfG0hD9ixxWh2fzuQYmyoo3
 22XcZ2qt8OwznTVhAriKP5NNJMwX1Kh5E6H88ZMbne8pworwR2QXveJyVf88g+4qW+De
 I4bGjb+U4NfEYkHHukd3Pu/iCiIS6lUv4BS5n4zdhX8aIhZkhew6Er73i4sFn/bgnTfB
 aMWkbfPKjd0GS/QiF/3/ItWJM6ixxP0FVGuc8XVKHR8EPh672r7ddBHSk1ADgkSjyc1Z
 erv9/svM8IL1SSJOKD5uz6b3rP2YVdN6NhaAD4mK2E1U5d16rNu85rxGwiVk4q7BoU5f
 Caag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768914932; x=1769519732;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Jl2KF0othdvrwDImGzxJcxoX7WKdbBXFC823mMEO8nY=;
 b=Q/oZavL0sc5o1t36uyMGMuJzDNEKSCbTe0JURKZ5ZwvYN0N8nQ7cF/mRHXjiYJUHJc
 q9b8lzatkj9uWBkAlgeK1YMMmNusdNEcSs2hsT7QDpfbnUqb5DJ+aCfLMMs76/kyTRhz
 zx72pZ6GWFgRymmr//fqBV+PWUVj+QrguFgB+fGJibWumnMoktEMXD15FaZyTcifYv9k
 +ecsCzFZII69d8vxrhDnPBv9naTTX2tlKCd27gkzJw4cX3o+3NbPT9vVlRLQHFsL4Zgz
 UzAuK592oooxWkH5ASsg47HYL+QltiRdAbxwD64VyDc157FnjAkK4rNyl1eH1UnGFVV6
 Y2EA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOsIGx2KfAHKHwv3c1U+KK/7Jj169/yrD671tYQquavHSevsMDPVDwanZ7DKB7iCTJzzl7vEkD@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzz7EclcOh2dZdD2Qn1FFvqenXyfsG9bazrHCVXcbH53Y5i7sv7
 qVslUW2Vq9WyEKvy0fsm9iyJa/Sp3x0LJhh0MNs9FpPG+FqlwWp8zu8CLdozmjzSSGg=
X-Gm-Gg: AY/fxX67rHF4QryFGaqG5MxB+OYHzloaBK9O4srmJtUnUFkJTsIoaZHI8Vuq2U7mU7p
 ohbotNuLx/yESrlUve8plIze4a++ChnrTu0KFL5Qlxc3XO2WkdRUgwrKPSjPmDb1lg6+iB2XUW8
 xKcUrY8AttzE2ItDFCeWGRq7x+aTBNoFIA+Dm1Ly4NysILAK2vsA8GzIrbAOMNlMFG+/MU1xNoa
 am5y2GGrLkLK7VL+9zrgarYE2xPqBcFGWuGDENY1gs/FUZPnKcRJclGHpSDU8Rwz/L7iz3yeF3Z
 M7EUs87TFWOmE05+jcnRXCIziX7mdtKRyBVcbf3JZ6yroiFhWWpumIzHX4M2VJfknfYrHdsM0hF
 s3y6g3dvoevF+gY62NWlYuOfUv6GEvR6se32kBY16hOA/5g5TbQtcsKFeRNX3wPn5hynkZRaM21
 iZsLXrJz2GSMmNuVvVyoo2eo/EE5RFT9RCevnlrYzsXelrX19BG7meXaae5ri2ic52YSg=
X-Received: by 2002:a05:620a:999:b0:8c6:a68a:bc04 with SMTP id
 af79cd13be357-8c6a68ac1c8mr1389837085a.7.1768914931884; 
 Tue, 20 Jan 2026 05:15:31 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.112.119]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c6a7292cfbsm1017788585a.50.2026.01.20.05.15.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 05:15:31 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1viBZy-00000005W6K-36CW;
 Tue, 20 Jan 2026 09:15:30 -0400
Date: Tue, 20 Jan 2026 09:15:30 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
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
 Alex Williamson <alex@shazbot.org>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 virtualization@lists.linux.dev, intel-xe@lists.freedesktop.org,
 linux-rdma@vger.kernel.org, iommu@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [PATCH v2 3/4] iommufd: Require DMABUF revoke semantics
Message-ID: <20260120131530.GN961572@ziepe.ca>
References: <20260118-dmabuf-revoke-v2-0-a03bb27c0875@nvidia.com>
 <20260118-dmabuf-revoke-v2-3-a03bb27c0875@nvidia.com>
 <20260119165951.GI961572@ziepe.ca> <20260119182300.GO13201@unreal>
 <20260119195444.GL961572@ziepe.ca> <20260120131046.GS13201@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260120131046.GS13201@unreal>
X-Mailman-Approved-At: Tue, 20 Jan 2026 14:32:27 +0000
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

On Tue, Jan 20, 2026 at 03:10:46PM +0200, Leon Romanovsky wrote:
> On Mon, Jan 19, 2026 at 03:54:44PM -0400, Jason Gunthorpe wrote:
> > On Mon, Jan 19, 2026 at 08:23:00PM +0200, Leon Romanovsky wrote:
> > > On Mon, Jan 19, 2026 at 12:59:51PM -0400, Jason Gunthorpe wrote:
> > > > On Sun, Jan 18, 2026 at 02:08:47PM +0200, Leon Romanovsky wrote:
> > > > > From: Leon Romanovsky <leonro@nvidia.com>
> > > > > 
> > > > > IOMMUFD does not support page fault handling, and after a call to
> > > > > .invalidate_mappings() all mappings become invalid. Ensure that
> > > > > the IOMMUFD DMABUF importer is bound to a revoke‑aware DMABUF exporter
> > > > > (for example, VFIO).
> > > > > 
> > > > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > > > > ---
> > > > >  drivers/iommu/iommufd/pages.c | 9 ++++++++-
> > > > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
> > > > > index 76f900fa1687..a5eb2bc4ef48 100644
> > > > > --- a/drivers/iommu/iommufd/pages.c
> > > > > +++ b/drivers/iommu/iommufd/pages.c
> > > > > @@ -1501,16 +1501,22 @@ static int iopt_map_dmabuf(struct iommufd_ctx *ictx, struct iopt_pages *pages,
> > > > >  		mutex_unlock(&pages->mutex);
> > > > >  	}
> > > > >  
> > > > > -	rc = sym_vfio_pci_dma_buf_iommufd_map(attach, &pages->dmabuf.phys);
> > > > > +	rc = dma_buf_pin(attach);
> > > > >  	if (rc)
> > > > >  		goto err_detach;
> > > > >  
> > > > > +	rc = sym_vfio_pci_dma_buf_iommufd_map(attach, &pages->dmabuf.phys);
> > > > > +	if (rc)
> > > > > +		goto err_unpin;
> > > > > +
> > > > >  	dma_resv_unlock(dmabuf->resv);
> > > > >  
> > > > >  	/* On success iopt_release_pages() will detach and put the dmabuf. */
> > > > >  	pages->dmabuf.attach = attach;
> > > > >  	return 0;
> > > > 
> > > > Don't we need an explicit unpin after unmapping?
> > > 
> > > Yes, but this patch is going to be dropped in v3 because of this
> > > suggestion.
> > > https://lore.kernel.org/all/a397ff1e-615f-4873-98a9-940f9c16f85c@amd.com
> > 
> > That's not right, that suggestion is about changing VFIO. iommufd must
> > still act as a pinning importer!
> 
> There is no change in iommufd, as it invokes dma_buf_dynamic_attach()
> with a valid &iopt_dmabuf_attach_revoke_ops. The check determining whether
> iommufd can perform a revoke is handled there.

iommufd is a pining importer. I did not add a call to pin because it
only worked with VFIO that would not support it. Now that this series
fixes it the pin must be added. Don't drop this patch.

All the explanations we just gave say this special revoke mode only
activates if the buffer is pinned by the importer, so iommufd must pin
it. Otherwise it says it is working in the move mode with faulting
that it cannot support.

Jason
