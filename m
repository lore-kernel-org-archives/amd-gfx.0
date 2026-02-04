Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87653E83EE7
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Feb 2026 08:56:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24A8A10E588;
	Wed,  4 Feb 2026 08:56:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="V7pTqA4L";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDFBD10E13E;
 Wed,  4 Feb 2026 08:56:11 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 780C442B6C;
 Wed,  4 Feb 2026 08:56:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBAFAC4CEF7;
 Wed,  4 Feb 2026 08:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1770195371;
 bh=7OhNdyQd9Hj4JZ3WwzaaVRughLWneBid2/id9k15jgM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=V7pTqA4L9gw8RLNHTPQ3c3PmSmPUJN8CJLkSplhC/tA6rLyNs/ON8PEJ77FghkrYL
 7YC7kC+vzUJczQux8gMcjkSltXZByy2k3Y/tn+IZTssRYphrNHoXV/inmhMNPSeTpq
 /EElHDk0r2Fud4Ow8YLv+QLv1E77BycSs/6TXoM2dUc9VjGtgSPDYwYm8Ej4MLTHbO
 elG6nwpwLEFKKVyCeZfL3VndxYrhjKHWPJEgy+OWK/3jRcIHqHo7MMa8eGJO5MfqPJ
 iaudGOxgyj2Q+GiGdIWm2eFONDY0yvSNQsmD2v7LsLyMzax1HMUELlY3ibNKbudFUm
 17VPZKFF1DiPg==
Date: Wed, 4 Feb 2026 09:56:08 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>,
 Alex Deucher <alexander.deucher@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 Lucas De Marchi <lucas.demarchi@intel.com>, 
 Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Felix Kuehling <Felix.Kuehling@amd.com>, 
 Alex Williamson <alex@shazbot.org>, Ankit Agrawal <ankita@nvidia.com>, 
 Vivek Kasireddy <vivek.kasireddy@intel.com>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, 
 virtualization@lists.linux.dev, intel-xe@lists.freedesktop.org,
 linux-rdma@vger.kernel.org, iommu@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [PATCH v7 0/8] dma-buf: Use revoke mechanism to invalidate
 shared buffers
Message-ID: <20260204-icy-classic-crayfish-68da6d@houat>
References: <20260131-dmabuf-revoke-v7-0-463d956bd527@nvidia.com>
 <20260202160425.GO34749@unreal> <20260204081630.GA6771@unreal>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="md2hsdfsayzd7ozo"
Content-Disposition: inline
In-Reply-To: <20260204081630.GA6771@unreal>
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


--md2hsdfsayzd7ozo
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v7 0/8] dma-buf: Use revoke mechanism to invalidate
 shared buffers
MIME-Version: 1.0

On Wed, Feb 04, 2026 at 10:16:30AM +0200, Leon Romanovsky wrote:
> On Mon, Feb 02, 2026 at 06:04:25PM +0200, Leon Romanovsky wrote:
> > On Sat, Jan 31, 2026 at 07:34:10AM +0200, Leon Romanovsky wrote:
> > > Changelog:
> > > v7:
> >=20
> > <...>
> >=20
> > > Leon Romanovsky (8):
> > >       dma-buf: Rename .move_notify() callback to a clearer identifier
> > >       dma-buf: Rename dma_buf_move_notify() to dma_buf_invalidate_map=
pings()
> > >       dma-buf: Always build with DMABUF_MOVE_NOTIFY
> > >       vfio: Wait for dma-buf invalidation to complete
> > >       dma-buf: Make .invalidate_mapping() truly optional
> > >       dma-buf: Add dma_buf_attach_revocable()
> > >       vfio: Permit VFIO to work with pinned importers
> > >       iommufd: Add dma_buf_pin()
> > >=20
> > >  drivers/dma-buf/Kconfig                     | 12 -----
> > >  drivers/dma-buf/dma-buf.c                   | 69 +++++++++++++++++++=
+-----
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 14 ++---
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c  |  2 +-
> > >  drivers/gpu/drm/amd/amdkfd/Kconfig          |  2 +-
> > >  drivers/gpu/drm/virtio/virtgpu_prime.c      |  2 +-
> > >  drivers/gpu/drm/xe/tests/xe_dma_buf.c       |  7 ++-
> > >  drivers/gpu/drm/xe/xe_bo.c                  |  2 +-
> > >  drivers/gpu/drm/xe/xe_dma_buf.c             | 14 ++---
> > >  drivers/infiniband/core/umem_dmabuf.c       | 13 -----
> > >  drivers/infiniband/hw/mlx5/mr.c             |  2 +-
> > >  drivers/iommu/iommufd/pages.c               | 11 +++-
> > >  drivers/iommu/iommufd/selftest.c            |  2 +-
> > >  drivers/vfio/pci/vfio_pci_dmabuf.c          | 80 +++++++++++++++++++=
+++-------
> > >  include/linux/dma-buf.h                     | 17 +++---
> > >  15 files changed, 153 insertions(+), 96 deletions(-)
> >=20
> > Christian,
> >=20
> > Given the ongoing discussion around patch v5, I'm a bit unclear on the
> > current state. Is the series ready for merging, or do you need me to
> > rework anything further?
>=20
> Christian,
>=20
> Let's not miss the merge window for work that is already ready.

The cutoff date for the merge window was on 25/1, so it was already
missed by the time you sent your series.

Maxime

--md2hsdfsayzd7ozo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaYMJowAKCRAnX84Zoj2+
djVFAX4o65eZLnv9pSuBC/f19F9Wa+5AV3tbnVDyNWy7aEVTPVlpkwyBh3kSx24f
CiGuWJUBgMDxh0mGTwKw1M4dapaGNtVEhWvE/mj7fWyRzk3l536hontO+fVSQspp
IjEjywqm8A==
=TNrj
-----END PGP SIGNATURE-----

--md2hsdfsayzd7ozo--
