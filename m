From: Kangjie Lu <kjlu@umn.edu>
Subject: Re: [PATCH] gpu: amdkfd: fix a missing check of kmemdup
Date: Fri, 22 Mar 2019 21:20:31 -0500
Message-ID: <71B1FB5B-DB3A-4E23-A62B-3ACC63D83319@umn.edu>
References: <20190309041949.3176-1-kjlu@umn.edu>
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190309041949.3176-1-kjlu@umn.edu>
Sender: linux-kernel-owner@vger.kernel.org
To: kjlu@umn.edu
Cc: pakki001@umn.edu, Oded Gabbay <oded.gabbay@gmail.com>, Alex Deucher <alexander.deucher@amd.com>, =?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org



> On Mar 8, 2019, at 10:19 PM, Kangjie Lu <kjlu@umn.edu> wrote:
>=20
> kmemdup could fail and return NULL. To avoid null pointer
> dereference, the fix checkes its return value and returns
> ENOMEM upon failures.

This is a NULL-pointer dereference issue.
Can someone review this patch? Thanks.

>=20
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
> drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 3 +++
> 1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c =
b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> index 2e7c44955f43..7ef62d4e7598 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -404,6 +404,9 @@ static int kfd_parse_subtype_iolink(struct =
crat_subtype_iolink *iolink,
> 			return -ENODEV;
> 		/* same everything but the other direction */
> 		props2 =3D kmemdup(props, sizeof(*props2), GFP_KERNEL);
> +		if (!props2)
> +			return -ENOMEM;
> +
> 		props2->node_from =3D id_to;
> 		props2->node_to =3D id_from;
> 		props2->kobj =3D NULL;
> --=20
> 2.17.1
>=20
