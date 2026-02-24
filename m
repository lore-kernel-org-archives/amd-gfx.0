Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC6DEE9B250
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Feb 2026 10:31:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62D5E10E1D5;
	Tue, 24 Feb 2026 10:31:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XJc65pZF";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B19289083;
 Tue, 24 Feb 2026 10:31:05 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 2FC9443C95;
 Tue, 24 Feb 2026 10:31:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ACDBC116D0;
 Tue, 24 Feb 2026 10:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1771929065;
 bh=oUwk8VP9X5cwOfy2FaQDDjO2Cz9u/z4sh5gcdr9Ylx4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XJc65pZFDlsZzYhzthM1hMrgBmoCoDRrZXYo8ZXGTAAiBaqdsf54Np++GWVGUvvoC
 0pz/rfohc9lRY0RXJZTvHS/qyGw1ZIQlbsTLz8o6hbr9L1i1oy38rqutgO1Vtkev1P
 22Ja3XtxWP2KCAqX6CuVF3QkH2KcHrQmkBWxN/x0LNnjG/w4SmjNdg0hPTz/QWKqnd
 EYlZikYgFjCRULv1KP5Hc0VEhvcUA7HQy0+e8SoPqrOHViszFP7Cz1dPBVb51eF1ID
 UDGPuaUrmTI6Zm3YKLWvQRYb44/p19BnjdaCM9HsM/uE64YeFqJkcb69ZxSsCwof5d
 3PKIpr1BPzk7A==
Date: Tue, 24 Feb 2026 12:31:00 +0200
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
Message-ID: <20260224103100.GI10607@unreal>
References: <20260131-dmabuf-revoke-v7-0-463d956bd527@nvidia.com>
 <20260217080206.GJ12989@unreal>
 <0aa8147c-254d-4a1c-89ee-9dc4d4b6b022@amd.com>
 <20260217133431.GN12989@unreal>
 <90088594-5835-4f4f-9e69-aaee67109aa1@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <90088594-5835-4f4f-9e69-aaee67109aa1@amd.com>
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

On Mon, Feb 23, 2026 at 07:55:15PM +0100, Christian König wrote:
> On 2/17/26 14:34, Leon Romanovsky wrote:
> > On Tue, Feb 17, 2026 at 10:52:25AM +0100, Christian König wrote:
> >> On 2/17/26 09:02, Leon Romanovsky wrote:
> >>> On Sat, Jan 31, 2026 at 07:34:10AM +0200, Leon Romanovsky wrote:
> >>>> Changelog:
> >>>> v7:
> >>>>  * Fixed messed VFIO patch due to rebase.
> >>>
> >>> <...>
> >>>
> >>> Christian,
> >>>
> >>> What should be my next step? Should I resubmit it?
> >>
> >> No, the patches are fine as they are. I'm just waiting for the backmerge of upstream to apply them.
> 
> And pushed to drm-misc-next.
> 
> There was a minor merge conflict in patch #5. I think I fixed it up correctly, but only compile tested the result.

You resolved it correctly.

> 
> Would probably be good time to now test drm-misc-next if you have some userspace test cases.

Sure, thanks a lot.

> 
> Regards,
> Christian.
> 
> > 
> > Thanks
> 
