Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60CBDEF5877
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Feb 2026 13:34:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC07C10E4D8;
	Tue, 17 Feb 2026 13:34:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Z9hIeX24";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4858310E25E;
 Tue, 17 Feb 2026 13:34:35 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id F2D1B41932;
 Tue, 17 Feb 2026 13:34:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38DEAC19423;
 Tue, 17 Feb 2026 13:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1771335274;
 bh=5Ve2lFhJ0cDQLZhhoB8VGy9HpsXLE/NXmcWc43kIado=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Z9hIeX24hquUJ4wdZrCAVMv/v+w7DswfB9yd2z01qBeU9SwSfFcRLINuYxFLbTbWy
 nCaHOAy2bOHsxsSLnW36or7B1egpaZTiFbaplu1tu9fczmu8yYgPRzu0HEQQjipBKj
 wF7yVRXjtqgUQEAKhMvSCNQYs0EgfDfTt4ZgnPiQ253vkvearAzcMUCmugprktCoY4
 15q3WwfNIPyVkj8jz85EqiJL+k1gvJaO43mU0XhZYY+dC/maR+PBJXZAnxCGK+V3Yq
 go65AH1Vp25BN4+5W6xdN9xTmNgn8I6z9KxJG8Ld2oDvMIelDF5KLf34AawQ3xnki3
 M3MQrm9ffvLfw==
Date: Tue, 17 Feb 2026 15:34:31 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: David Airlie <airlied@gmail.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 Simona Vetter <simona@ffwll.ch>, Gerd Hoffmann <kraxel@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Chia-I Wu <olvaffe@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Lucas De Marchi <lucas.demarchi@intel.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Williamson <alex@shazbot.org>, Ankit Agrawal <ankita@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, virtualization@lists.linux.dev,
 intel-xe@lists.freedesktop.org, linux-rdma@vger.kernel.org,
 iommu@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [PATCH v7 0/8] dma-buf: Use revoke mechanism to invalidate
 shared buffers
Message-ID: <20260217133431.GN12989@unreal>
References: <20260131-dmabuf-revoke-v7-0-463d956bd527@nvidia.com>
 <20260217080206.GJ12989@unreal>
 <0aa8147c-254d-4a1c-89ee-9dc4d4b6b022@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0aa8147c-254d-4a1c-89ee-9dc4d4b6b022@amd.com>
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

On Tue, Feb 17, 2026 at 10:52:25AM +0100, Christian König wrote:
> On 2/17/26 09:02, Leon Romanovsky wrote:
> > On Sat, Jan 31, 2026 at 07:34:10AM +0200, Leon Romanovsky wrote:
> >> Changelog:
> >> v7:
> >>  * Fixed messed VFIO patch due to rebase.
> > 
> > <...>
> > 
> > Christian,
> > 
> > What should be my next step? Should I resubmit it?
> 
> No, the patches are fine as they are. I'm just waiting for the backmerge of upstream to apply them.

Thanks
