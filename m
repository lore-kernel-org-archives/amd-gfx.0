Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 019A4D6260A
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jan 2026 08:36:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20A9510E936;
	Thu, 22 Jan 2026 08:36:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="fvLx6eyK";
	dkim-atps=neutral
Received: from mail-qt1-f193.google.com (mail-qt1-f193.google.com
 [209.85.160.193])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 589CE10E80C
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jan 2026 13:59:50 +0000 (UTC)
Received: by mail-qt1-f193.google.com with SMTP id
 d75a77b69052e-5018ec2ae21so57076781cf.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jan 2026 05:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1769003989; x=1769608789; darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NrFwAYZYjJdV2hWLBqDeijXZcUvvrfRZB3KhQxPCGpU=;
 b=fvLx6eyKqDTx+NdYcUVM401Knh4Ly59ZGpctk9zvX/1mdfD1b/DNVSjX59whUyVTvG
 AhquZpzdfIeEHSBsEubKtOHBE/L+u0iaCbjCaJsJE2k3Yom44kJdY4SRnPtDufZsMWjR
 QP8pkub6iPaLdXHye6OWUKppOA5RN7+XjMPDuSoJll0ekGe2URr3PgJL7AsaCgTFs4bR
 DKZSLFIIv9yBsrYPFQg/vNwVDQYhlE2GD2v942X5gT8GKTyfddynqtnit3V6LEbZrJu8
 jaeXiVQMYnrY0xIQG3dstPhoQdNnr7/QdHtxJHIVy04KUCLSTC9leMgQixZeCA+kaNKr
 uKZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769003989; x=1769608789;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NrFwAYZYjJdV2hWLBqDeijXZcUvvrfRZB3KhQxPCGpU=;
 b=XgIoguHGdbvtIRh8PDBPzIcd02+iwBB+1KAtmjDi/fMO041dnFKFziWhbtEWVglnhD
 PN+inQalOlelv1SmFaK/edCxnGPelchPtoy0e0UCnLP5EVmUaj08wYZ8nV1PVZ8w56fK
 GhF/WpPu/0pPqSd009evgzaeUGtDKb8YrMUyE9fjuT44b08gsnXLCDOPRZ6rZNFt+y14
 2hzsig7xTLqCfEwOB4MqiSxM1hiwM205EDH8sVt9U0cAQ9ZO3PV5EU5OAti8nc9coWY3
 xMjd15W5CfK1lmgtLrhbY9vN9hlmrcgIwf4Sk2bTBzXqTz3lBlSaHlM7PXB3Wa1XrSJs
 yuUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdojTNR9cDLheyhk7+UKmbktY4Ao3fHwLFP76XNx7v8EvTYBnh3W+Eupw/Ww3i5D/4lDPgdSw6@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx9MeLiCmr/cwGmym7I0XgCyxmDrdCLIHAlypoL8MTNDBwaJomu
 g4WO8qDorGE3sxumtmKXrDN8w1jqrdLRbFD0t1+xXsozsk9ReAU0J2/ZqPLlXJh+K0A=
X-Gm-Gg: AZuq6aKOhtO26g6W0+HqVdRkZvJkEct3c80FPkXZ6xbTaLHhzbENo+61f8LOebuzhkZ
 B95yuDMqZg8f3BwX9FGV9opU1fiL821+vzrVBP0zUbOcFlHym0ld3gyA+L59SvaWRuSueyHKxi1
 EgS7WPOfePJmg6o12Dt+l05QymjLQp12BTUQMD5uyKRKthOmQ6Z3z8Irq51qJDVlwO9etkGkh7j
 mcRVyYottei1k/XthgXBpUKV2NAanlvoZx0Pik/kWpJF4ThBoTFXLpT2xhRwmn1gcfbvefVZ0ln
 t78DIU8egSkbHAiFQXCQ+XOjSo8SIoxwS1kS2pN2EAdq3HRl1dp/1Puv4PVeEDeX1XlQEmuPqYB
 aYaACO5zwyuTxPccaohAjG1BnPh8ZldnFV04f/CD/5odhwvIkIfIJbmYeVbCQ0tklMU3lr5QqDH
 qT7O9L6jzmjiYCiCBFE79N5vgqLKvHbei33ZmIVu6sSSbcu2v+F/bUbjSvISAnhxaFroA=
X-Received: by 2002:ac8:5d14:0:b0:4ff:c5f7:f812 with SMTP id
 d75a77b69052e-502d855fe29mr65972911cf.38.1769003989233; 
 Wed, 21 Jan 2026 05:59:49 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.112.119]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-502a1d9f480sm113423091cf.13.2026.01.21.05.59.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 05:59:48 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1viYkO-00000006E8Z-0XjE;
 Wed, 21 Jan 2026 09:59:48 -0400
Date: Wed, 21 Jan 2026 09:59:48 -0400
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
Message-ID: <20260121135948.GB961572@ziepe.ca>
References: <20260120-dmabuf-revoke-v3-0-b7e0b07b8214@nvidia.com>
 <20260120-dmabuf-revoke-v3-3-b7e0b07b8214@nvidia.com>
 <4fe42e7e-846c-4aae-8274-3e9a5e7f9a6d@amd.com>
 <20260121091423.GY13201@unreal>
 <7cfe0495-f654-4f9d-8194-fa5717eeafff@amd.com>
 <20260121131852.GX961572@ziepe.ca>
 <8a8ba092-6cfa-41d2-8137-e5e9d917e914@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8a8ba092-6cfa-41d2-8137-e5e9d917e914@amd.com>
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

On Wed, Jan 21, 2026 at 02:52:53PM +0100, Christian König wrote:
> On 1/21/26 14:18, Jason Gunthorpe wrote:
> > On Wed, Jan 21, 2026 at 10:17:16AM +0100, Christian König wrote:
> >> The whole idea is to make invalidate_mappings truly optional.
> > 
> > But it's not really optional! It's absence means we are ignoring UAF
> > security issues when the exporters do their move_notify() and nothing
> > happens.
> 
> No that is unproblematic.
> 
> See the invalidate_mappings callback just tells the importer that
> the mapping in question can't be relied on any more.
> 
> But the mapping is truly freed only by the importer calling
> dma_buf_unmap_attachment().
> 
> In other words the invalidate_mappings give the signal to the
> importer to disable all operations and the
> dma_buf_unmap_attachment() is the signal from the importer that the
> housekeeping structures can be freed and the underlying address
> space or backing object re-used.

I see

Can we document this please, I haven't seen this scheme described
anyhwere.

And let's clarify what I said in my other email that this new revoke
semantic is not just a signal to maybe someday unmap but a hard
barrier that it must be done once the fences complete, similar to
non-pinned importers.

The cover letter should be clarified with this understanding too.

Jason
