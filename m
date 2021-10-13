Return-Path: <SRS0=F65H=PB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1C4C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 13:34:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB593610E8
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 13:34:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CB593610E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 577B76E0DA;
	Wed, 13 Oct 2021 13:34:50 +0000 (UTC)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 618F06E0DA
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Oct 2021 13:34:49 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id i12so8458781wrb.7
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Oct 2021 06:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:mail-followup-to:references
 :mime-version:content-disposition:in-reply-to;
 bh=miQRTp5hbRC1OCVn4QsRcT9kmnoc0mnhrgOilHbNn1g=;
 b=F0E4EuXR+3flbL7Xzl8XisBhT8qIwH7MG0zDDrByvsqJ7u0MvCbJ+Jdk27g1cp2SlZ
 9eUPMq4/iImU+0GtvR6R8lhPuCXmipsVTsAD3q7rkP21TldlzL8k+m7OPM4caW0UvsC2
 7EcztkwWSBS0RIOzrl5QE35wqRU+YUSNac2QE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id
 :mail-followup-to:references:mime-version:content-disposition
 :in-reply-to;
 bh=miQRTp5hbRC1OCVn4QsRcT9kmnoc0mnhrgOilHbNn1g=;
 b=pJZ7Kfw0LOy42Z+f2m/1b0sSgAwzl+6BHhTOd2r/9YUZnO2PPqyUEYu+/cpj/D96eG
 fXfoeAkth2w2vFws310TXhs44VX3+QIwXUGP2gbPtqh/wFkZYbEI6jiHhJV12QwI0hf5
 wBcKYCL3Bauyfl9BImzXqPdSUDivIZNLifC6JwXuMrqpxOFkD8I8Klj5gc2CY7QmtFSv
 thFv49OBzs92xDfbxEb1xpzgUmFDxBvNGlU2kLM6pxI170iT0uRX62S3VaK3XFg4vjJI
 Q1AXhDkR/ITKITEmoZdXnWR8kjHNzyO4StGryP+LhG0EBJpuHI33i1L/hOL7td7SEhsY
 LqJQ==
X-Gm-Message-State: AOAM531C/2LpL5vYdlSZcWwu5Rae9Sovt99biSsRotXyvIPHv+1qzOUS
 Ka5lP+t0Hcpc9/WJ++w3Qeineg==
X-Google-Smtp-Source: ABdhPJyPnoPCgju2Szs7ixA3PwCFFi3lyPyAvuULHAdCBT2PI9V1y8J8yrCa0Gufzb/wqCsDI8QXUQ==
X-Received: by 2002:a05:600c:4ecb:: with SMTP id
 g11mr12644285wmq.67.1634132087950; 
 Wed, 13 Oct 2021 06:34:47 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id w1sm5376300wmc.19.2021.10.13.06.34.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Oct 2021 06:34:47 -0700 (PDT)
Date: Wed, 13 Oct 2021 15:34:45 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Alex Sierra <alex.sierra@amd.com>, Felix.Kuehling@amd.com,
 linux-mm@kvack.org, rcampbell@nvidia.com,
 linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 hch@lst.de, jglisse@redhat.com, apopple@nvidia.com
Subject: Re: [PATCH v1 00/12] MEMORY_DEVICE_COHERENT for CPU-accessible
 coherent device memory
Message-ID: <YWbgdXJBtupdy1qs@phenom.ffwll.local>
Mail-Followup-To: Jason Gunthorpe <jgg@nvidia.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Alex Sierra <alex.sierra@amd.com>, Felix.Kuehling@amd.com,
 linux-mm@kvack.org, rcampbell@nvidia.com,
 linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 hch@lst.de, jglisse@redhat.com, apopple@nvidia.com
References: <20211012171247.2861-1-alex.sierra@amd.com>
 <20211012113957.53f05928dd60f3686331fede@linux-foundation.org>
 <20211012185629.GZ2744544@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211012185629.GZ2744544@nvidia.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
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

On Tue, Oct 12, 2021 at 03:56:29PM -0300, Jason Gunthorpe wrote:
> On Tue, Oct 12, 2021 at 11:39:57AM -0700, Andrew Morton wrote:
> > On Tue, 12 Oct 2021 12:12:35 -0500 Alex Sierra <alex.sierra@amd.com> wrote:
> > 
> > > This patch series introduces MEMORY_DEVICE_COHERENT, a type of memory
> > > owned by a device that can be mapped into CPU page tables like
> > > MEMORY_DEVICE_GENERIC and can also be migrated like MEMORY_DEVICE_PRIVATE.
> > > With MEMORY_DEVICE_COHERENT, we isolate the new memory type from other
> > > subsystems as far as possible, though there are some small changes to
> > > other subsystems such as filesystem DAX, to handle the new memory type
> > > appropriately.
> > > 
> > > We use ZONE_DEVICE for this instead of NUMA so that the amdgpu
> > > allocator can manage it without conflicting with core mm for non-unified
> > > memory use cases.
> > > 
> > > How it works: The system BIOS advertises the GPU device memory (aka VRAM)
> > > as SPM (special purpose memory) in the UEFI system address map.
> > > The amdgpu driver registers the memory with devmap as
> > > MEMORY_DEVICE_COHERENT using devm_memremap_pages.
> > > 
> > > The initial user for this hardware page migration capability will be
> > > the Frontier supercomputer project.
> > 
> > To what other uses will this infrastructure be put?
> > 
> > Because I must ask: if this feature is for one single computer which
> > presumably has a custom kernel, why add it to mainline Linux?
> 
> Well, it certainly isn't just "one single computer". Overall I know of
> about, hmm, ~10 *datacenters* worth of installations that are using
> similar technology underpinnings.
> 
> "Frontier" is the code name for a specific installation but as the
> technology is proven out there will be many copies made of that same
> approach.
> 
> The previous program "Summit" was done with NVIDIA GPUs and PowerPC
> CPUs and also included a very similar capability. I think this is a
> good sign that this coherently attached accelerator will continue to
> be a theme in computing going foward. IIRC this was done using out of
> tree kernel patches and NUMA localities.
> 
> Specifically with CXL now being standardized and on a path to ubiquity
> I think we will see an explosion in deployments of coherently attached
> accelerator memory. This is the high end trickling down to wider
> usage.
> 
> I strongly think many CXL accelerators are going to want to manage
> their on-accelerator memory in this way as it makes universal sense to
> want to carefully manage memory access locality to optimize for
> performance.

Yeah with CXL this will be used by a lot more drivers/devices, not
even including nvidia's blob.

I guess if you want make sure get an ack on this from CXL folks, so that
we don't end up with a mess.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
