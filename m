Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0659FD2F004
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Jan 2026 11:42:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61C5810E1EE;
	Tue, 27 Jan 2026 11:42:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="u+LJdlmU";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C84E10E02A;
 Tue, 27 Jan 2026 11:42:50 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 1A6E344054;
 Tue, 27 Jan 2026 11:42:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FC54C116C6;
 Tue, 27 Jan 2026 11:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769514170;
 bh=fAHM5q9wQLwXxl3T67WPkBrXvMLT3XUbL9WwMpc1kVY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=u+LJdlmUXoEUT+qS8vdwdGhuVoxoBM8bpGP76IPFvQ2hPoxYogjUoZQMHsGTlLuGz
 Wi1irQ+OaS9vZIPoRwJ+ZcylK5RTFC8tosvgADB6cn79OhFqjwAcYfUY+jEfyh0gAc
 G9aEoU5cSdAHZ8YsIePIVVTAmiXeu42p78b7GyUNEn73EnF8KjSdfazGrSHPHfrsXS
 8PC3zJHRPg8aEyB+5F/ILhQ28gUQjagLmvBzA+Zjn/8gYldm16hilAft/cMikzCr/f
 a3q1yoFN+jz33KmtrEztFNuoUNKjPnSSBkf5e/DweEwIKaeqez+OKWtP4O4t1ZC7q0
 KgHBtLPJo2YYg==
Date: Tue, 27 Jan 2026 13:42:43 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
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
Subject: Re: [PATCH v5 3/8] dma-buf: Always build with DMABUF_MOVE_NOTIFY
Message-ID: <20260127114243.GS13967@unreal>
References: <20260124-dmabuf-revoke-v5-0-f98fca917e96@nvidia.com>
 <20260124-dmabuf-revoke-v5-3-f98fca917e96@nvidia.com>
 <0d2ec2d6-c999-45d8-a2bd-b5b21883db47@amd.com>
 <20260127095831.GR13967@unreal>
 <83cd911c-99ea-4fab-821e-fcf703209731@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <83cd911c-99ea-4fab-821e-fcf703209731@amd.com>
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

On Tue, Jan 27, 2026 at 11:02:03AM +0100, Christian König wrote:
> On 1/27/26 10:58, Leon Romanovsky wrote:
> > On Tue, Jan 27, 2026 at 10:26:26AM +0100, Christian König wrote:
> >> On 1/24/26 20:14, Leon Romanovsky wrote:
> >>> From: Leon Romanovsky <leonro@nvidia.com>
> >>>
> >>> DMABUF_MOVE_NOTIFY was introduced in 2018 and has been marked as
> >>> experimental and disabled by default ever since. Six years later,
> >>> all new importers implement this callback.
> >>>
> >>> It is therefore reasonable to drop CONFIG_DMABUF_MOVE_NOTIFY and
> >>> always build DMABUF with support for it enabled.
> >>>
> >>> Suggested-by: Christian König <christian.koenig@amd.com>
> >>> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> >>
> >> Reviewed-by: Christian König <christian.koenig@amd.com>
> >>
> >> As long as nobody starts screaming in the last second or I encounter some other problem I'm going to push the first three patches to drm-misc-next now.
> > 
> > How do you see progress of other patches?
> > Can they be queued for that tree as well?
> 
> I was hoping to get through them by the end of the week.
> 
> Just wanted to make sure that CI systems start to see the first three patches (who affect everybody), so that we get early feedback should we have missed something.

Perfect, I based my patches on these two commits:
61ceaf236115 (vfio/for-linus) vfio: Prevent from pinned DMABUF importers to attach to VFIO DMABUF
24d479d26b25 (tag: v6.19-rc6) Linux 6.19-rc6

Thanks

> 
> Regards,
> Christian.
> 
> > 
> > Thanks
> > 
> >>
> >> They are basically just cleanups we should have done a long time ago.
> >>
> >> Regards,
> >> Christian.
> >>
> 
