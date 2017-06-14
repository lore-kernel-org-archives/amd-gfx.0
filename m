From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdkfd: NULL dereference involving create_process()
Date: Wed, 14 Jun 2017 16:41:16 +0000
Message-ID: <BN6PR12MB16526A96549054656758635FF7C30@BN6PR12MB1652.namprd12.prod.outlook.com>
References: <20170614105853.GP29394@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20170614105853.GP29394@elgon.mountain>
Content-Language: en-US
Sender: kernel-janitors-owner@vger.kernel.org
To: 'Dan Carpenter' <dan.carpenter@oracle.com>, Oded Gabbay <oded.gabbay@gmail.com>, Alexey Skidanov <Alexey.Skidanov@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>, David Airlie <airlied@linux.ie>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

> -----Original Message-----
> From: Dan Carpenter [mailto:dan.carpenter@oracle.com]
> Sent: Wednesday, June 14, 2017 6:59 AM
> To: Oded Gabbay; Alexey Skidanov
> Cc: Deucher, Alexander; Koenig, Christian; David Airlie; dri-
> devel@lists.freedesktop.org; amd-gfx@lists.freedesktop.org; kernel-
> janitors@vger.kernel.org
> Subject: [PATCH] drm/amdkfd: NULL dereference involving create_process()
>=20
> We accidentally return ERR_PTR(0) which is NULL.  The caller is not
> expecting that and it leads to an Oops.
>=20
> Fixes: dd59239a9862 ("amdkfd: init aperture once per process")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Include Felix.

Alex

>=20
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 84d1ffd1eef9..1190d06884ed 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -318,7 +318,8 @@ static struct kfd_process *create_process(const struc=
t
> task_struct *thread)
>=20
>  	/* init process apertures*/
>  	process->is_32bit_user_mode =3D in_compat_syscall();
> -	if (kfd_init_apertures(process) !=3D 0)
> +	err =3D kfd_init_apertures(process);
> +	if (err !=3D 0)
>  		goto err_init_apretures;
>=20
>  	return process;
