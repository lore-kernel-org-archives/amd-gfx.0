Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DA8ED2ECF7
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jan 2026 08:25:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0269610E57B;
	Tue, 20 Jan 2026 08:25:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="KorBXypz";
	dkim-atps=neutral
Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com
 [209.85.222.193])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBFDF10E4F9
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 19:54:47 +0000 (UTC)
Received: by mail-qk1-f193.google.com with SMTP id
 af79cd13be357-8b2f0f9e4cbso388930885a.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 11:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1768852487; x=1769457287; darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zwZ9o3ha19w1BUlcGeJzNZvsy/mlKSz+FRMjn04+Z/c=;
 b=KorBXypzD3nbVZgfSZP8sNab84oJ0qKD60XopeM+b4lUdHii4ysPHmRwNeX0rpUj8T
 FcIgK9wjimWY0BCCTgACe0o5H4I9m7jrbWfeL3ThXa0R+PZtX//2+7Ujjf+qj+ZBHGnq
 g+4FWHWu32S440psZT1uXQCEFjfIp9IJeU8aFZUtYYj9+BiADM52AYctMLQcbiA2EAtI
 QUScZm6g7SGnNCrbWHHGvcPr1PwDFaBdfGnSVJeJwSd8MHycLhLPpKByrkzRkx/H1fnK
 MCzGAPAy/CE9RTPWpvUKJj/YPjpm5I/sJfRWj05xefZgDI26oxh75PAqdoRb4WuVpb8N
 Oruw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768852487; x=1769457287;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zwZ9o3ha19w1BUlcGeJzNZvsy/mlKSz+FRMjn04+Z/c=;
 b=rYoCXeV0SfMK7HPkhr+bXMRFBR6tUwPj8bCpKDmTIPiavnTUa1gUTzkAT2AYVDX4w0
 NOnO6JhG1XsgQ7jbQTcSf1u/TRs8N4+7CPNOeaT9zFJ76uwuAJ0v187V1GwT4cCEmi2j
 CR0P4aRsSLMS8aLfqsQcocMPyDqGLRefDglnYJiKYdjwxJJBLrJTuxeK3kbH+ml1EqJj
 jgSopsk0s7W+HUnSQv/nGTqOtQivtwJK6KeEt/UxdExNebAkuOO4vLGz2S1iCTkhEtd4
 rX91iVf8nLtp4ufAzTLulXUBcfjefhrSqFa/kw51xtiEk+R/KSepYx23+GXb2WUkTbys
 mnWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyuHbSILZR1aiHSy8vTZ68yKipIzUAS76IvxBtdn5GwnzE8uzFEDSdZr2SrbXqudGIu+s8SLRq@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzo2kzHUC9sVv1aaZSQ4T4A09CPzp6DP+T2u/D/ilC/BvipDUlU
 suyDg/DRm6MlY5T9nl5mM8HOynkiYYOkFS3fiDXuKDoBEQZBCGu6QoWCA38j/y2oIFc=
X-Gm-Gg: AY/fxX62WobJqQfB2UVH6VVipxJZ5WCFSNy0UfdEImCSa/JL2OtIFgY07cDFkk4bpHo
 lNfkrhBgg/Suq+wjGNmUEsdmRpQ6+fLtTTkjsCeqmit2/5nb07HENDi3uEfzosfLIaMVtSGlCuP
 OjsZl6a/nEW/OjqGXSVKnAWDiJwtwvkNuennlibmDvoHn2q1jpLFxaM/6s0zxz+KuMYuKcPdcVj
 byblP4gX6yffkGWR+IepLPY9Tm6yZu8ovCNJS6PEn+IP3+akvmnglG0YHM5+9Vg01Fg8Cn14D3e
 TGJ65fcmc/gbkfl6IsMGQ8njHPwDenGCe24GmPVVaC6rTPDsIAxaM4X3jH+WgWsW8HCWJQL+SoE
 h0/u7auW3NJcyBMkNPomWcignhRLhq/DPur1juot3T8YVnrR7MkIKBnEKL2U3e6sZcljW0C105w
 2CerRkJDOWv+l3OdEJ76lRNYKuvaNk1Uv92TwJbuaozcn9Y6tjpyoJtKjD4cLM+fx3nSw=
X-Received: by 2002:a05:620a:4606:b0:8a3:a42e:6e14 with SMTP id
 af79cd13be357-8c589b9706emr2117693085a.10.1768852486747; 
 Mon, 19 Jan 2026 11:54:46 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.112.119]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8942e6ad75asm86947906d6.31.2026.01.19.11.54.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 11:54:44 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1vhvKm-00000005JRT-0mKA;
 Mon, 19 Jan 2026 15:54:44 -0400
Date: Mon, 19 Jan 2026 15:54:44 -0400
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
Message-ID: <20260119195444.GL961572@ziepe.ca>
References: <20260118-dmabuf-revoke-v2-0-a03bb27c0875@nvidia.com>
 <20260118-dmabuf-revoke-v2-3-a03bb27c0875@nvidia.com>
 <20260119165951.GI961572@ziepe.ca> <20260119182300.GO13201@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260119182300.GO13201@unreal>
X-Mailman-Approved-At: Tue, 20 Jan 2026 08:25:58 +0000
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

On Mon, Jan 19, 2026 at 08:23:00PM +0200, Leon Romanovsky wrote:
> On Mon, Jan 19, 2026 at 12:59:51PM -0400, Jason Gunthorpe wrote:
> > On Sun, Jan 18, 2026 at 02:08:47PM +0200, Leon Romanovsky wrote:
> > > From: Leon Romanovsky <leonro@nvidia.com>
> > > 
> > > IOMMUFD does not support page fault handling, and after a call to
> > > .invalidate_mappings() all mappings become invalid. Ensure that
> > > the IOMMUFD DMABUF importer is bound to a revoke‑aware DMABUF exporter
> > > (for example, VFIO).
> > > 
> > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > > ---
> > >  drivers/iommu/iommufd/pages.c | 9 ++++++++-
> > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
> > > index 76f900fa1687..a5eb2bc4ef48 100644
> > > --- a/drivers/iommu/iommufd/pages.c
> > > +++ b/drivers/iommu/iommufd/pages.c
> > > @@ -1501,16 +1501,22 @@ static int iopt_map_dmabuf(struct iommufd_ctx *ictx, struct iopt_pages *pages,
> > >  		mutex_unlock(&pages->mutex);
> > >  	}
> > >  
> > > -	rc = sym_vfio_pci_dma_buf_iommufd_map(attach, &pages->dmabuf.phys);
> > > +	rc = dma_buf_pin(attach);
> > >  	if (rc)
> > >  		goto err_detach;
> > >  
> > > +	rc = sym_vfio_pci_dma_buf_iommufd_map(attach, &pages->dmabuf.phys);
> > > +	if (rc)
> > > +		goto err_unpin;
> > > +
> > >  	dma_resv_unlock(dmabuf->resv);
> > >  
> > >  	/* On success iopt_release_pages() will detach and put the dmabuf. */
> > >  	pages->dmabuf.attach = attach;
> > >  	return 0;
> > 
> > Don't we need an explicit unpin after unmapping?
> 
> Yes, but this patch is going to be dropped in v3 because of this
> suggestion.
> https://lore.kernel.org/all/a397ff1e-615f-4873-98a9-940f9c16f85c@amd.com

That's not right, that suggestion is about changing VFIO. iommufd must
still act as a pinning importer!

Jason
